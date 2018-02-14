;
; Copyright (c) 2017-, Marc De Graef/Carnegie Mellon University
; All rights reserved.
;
; Redistribution and use in source and binary forms, with or without modification, are 
; permitted provided that the following conditions are met:
;
;     - Redistributions of source code must retain the above copyright notice, this list 
;        of conditions and the following disclaimer.
;     - Redistributions in binary form must reproduce the above copyright notice, this 
;        list of conditions and the following disclaimer in the documentation and/or 
;        other materials provided with the distribution.
;     - Neither the names of Marc De Graef, Carnegie Mellon University nor the names 
;        of its contributors may be used to endorse or promote products derived from 
;        this software without specific prior written permission.
;
; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
; DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
; SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
; CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
; OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE 
; USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
; ###################################################################
;--------------------------------------------------------------------------
; EMsoft:OMETinitrotator.pro
;--------------------------------------------------------------------------
;
; PROGRAM: OMETinitrotator.pro
;
;> @author Marc De Graef, Carnegie Mellon University
;
;> @brief returns a structure with all the fields necessary to describe a polarizer
;
;> @date 02/15/17 MDG 1.0 first attempt at a user-friendly interface
;--------------------------------------------------------------------------
function OMETinitrotator, oenumber, update=update

common OMET_data_common, OMETdata
common OMET_widget_common, OMETwidget_s
common OMET_optelem_common, optelemptr

if (OMETdata.eventverbose eq 1) then print,'entering OMETinitrotator'

if (keyword_set(update)) then begin
	rotatorstructure = (*optelemptr[oenumber])
end else begin
	rotatorstructure = {rotatorstruct, $
						oetype:fix(3), $	; optical element type number
						theta:float(0.0), $	; rotation angle (radians)
						MuellerMatrix:dblarr(4,4), $ ; Mueller matrix for rotator element
						widgetexists:fix(0), $
						widgetID:long(0), $
						creationorder:fix(oenumber), $
						oenum:fix(oenumber)}; sequential number of optical element in chain
	OMETdata.availableOEnumber += 1
	OMETdata.numleft -= 1

	WIDGET_CONTROL, OMETwidget_s.numleft, SET_VALUE=string(OMETdata.numleft,format="(I2)")
endelse

; initialize the Mueller matrix for this element
res = MC_get_rotator(rotatorstructure.theta)
rotatorstructure.MuellerMatrix = res.M

return, rotatorstructure
end 