Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9C0789FB3
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 16:00:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaGHi-0002uN-DF; Sun, 27 Aug 2023 09:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad.frederic@yahoo.fr>)
 id 1qaGHg-0002to-D5
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 09:58:32 -0400
Received: from sonic311-30.consmr.mail.ir2.yahoo.com ([77.238.176.162])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <konrad.frederic@yahoo.fr>)
 id 1qaGHZ-00013R-5J
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 09:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.fr; s=s2048;
 t=1693144700; bh=jJSBXTwKjjWu9vZDOAiLqUFgXlAFPgpNTuiC4sW9gcg=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To;
 b=Kl1NjwdKH5Thl7v+XIZPQuJ/Jn7ZKdlbUWzLVjPy5wACkC/qbC8Cd0TxWgz4Ml0BLHk9kdm3Iy2YHfRmZ+8rlYet/wlyDVDpTLQ8fnaPeMaUOqhhC8ctQSvrGSOo+Ok8HsRUFgi3Wp979MVdHXHFJFGEgRc8cWr/6ISaNmcogu5TU76Y2qR49osuLO7xc6RLAm33sw6XP3Zfk5udELIxkctIgzPoBC83qo9xkMthY78ES3pOX0HvoJ4vsROzUZB2rRv4C1jx7b6jrLuq/lt2aZYJpGCu7WDDBeVWeLQrhm29iFVXA27YpZbgh70mwgnSzADrzT1frsFCf1dpVjjKgg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1693144700; bh=exVnvrSx3w3q1xSxOiAl2Rtsiz7co/Xri8zmnvt3U6i=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=sk3BHUrx/h2B/P+yHgR7R80RISjqt903TP1Iuba0N7LKeKZ1k4vZhHeOmuG0me7N/LeH2PM7mXPABDkY5+6pqaeV+9gq4IBd2V2yivY13JCdspGexx4a6VnmWc/oqCDBXVRXMg3X7w7Ro/eMZ8X873Nq4Yvz0aZik4nvOmIyCPipPlXJLqGP92BIcJUR9SGaeCa0GyV83/CMR0Gzqjd3myUtd53MUCy/bJbO2rWJa2VnjtTDRQx9svA5xyS4nPIsWwmIyJqDQpDvXL/AmSDvvEabc3lTO2XPb8mZplHDZdJ8mPGeT7za6LasILfWm17wVJkneRfsezOWT6te1RTMDA==
X-YMail-OSG: b9JAsdMVM1nZTZumZugPcwuLw.ezqz1zCIK0AqeItTftP7N5jhxykqfhF1PpZpC
 daawzqdOtlLJyKgp8khlxA93tE95mCrs01W5buKGIkCeV7li5lS744SUfPVnM8BzdQa_an4xhLv4
 hKq8PUzU.iegJMT_TH.IXjgDPSeZ62kErpOwsL7KvagGWiipX0ZkHxKol53MGhRpEN9EX.xdQpv3
 .dwp1dS.5vRnAR4c0AP0hpqI5Mse34stCkANcRFghfwE30I.KYxHQTCXHQIlAU4fuQ5T3uPBmAW7
 7SO2BxqoOr8W2ujRbiIXhfLCG2JdB_SWdWoCaBp5_S1Y7MugWTQqIcQrmJfYcAhBX1Dauu4CNeB7
 .ELTWZgJUNm3dZ_PY6HBvEdGbj6oVY8jkop6pribH21XCiHDBJEIDw6XoXaoHp1yh8HVXSFGPosG
 2nI6Hbo8BZTfHhRTYgvTwWOyp52z7fIdzxCM16CUkPX81WJ_kOy4Ig3LPlc5VWUZLnCwtbOiQOIh
 qZBCb4mU1rzOQuXdKbkceFfhfCF2rdJVeEGlXhPm_Vmf85pEIJaRLJ9hnPVRrdZZW7VoHjanuyBG
 gU5N64Tb_yoYKfllPlyqziMsEctpFnU8qpLvt_fLWUg3VgyCACgb4C5tAT_8x6DZagZwILB2_2Fm
 fuq5SFc.LRRxVeWJhPC6HbhAe6lQuGWR6e8qEPVnq1Jblme6wneMuZqfrrGkask_1NNHoEfbtwUp
 b3.OCX6tOrvWeq3W2GGqasAx.0pzoHuTwDughSpAhWWg3.N4UD15T.16rx71Q2UDSr0q8y.uTk82
 vKmajqFwGNuKLfCTLVVIWbyB7X9eLI7ZWOOfaFuBigiQu6QT9607NIf4Ci0LQr0LhSB_Zi4Q.R46
 ei5zv6TOD6t7l5XqpW5_PjQEzzf0H75kk.IlKLaQhbkYNunj9AzSBZQeSfpodlmmj.Cz7OkjDW31
 QFGnXxvTqAc0DAmLLQXSzO_2r8QtI9trZIfnkwGlOO1cccJW7x9clN.m45teSkHxuTD3nwftdsg.
 Pv03tnjTu7wrtrlYcg1isu8loRqLXT2nqEUddRZpoEo.TlJpyLNR8Fq2Kp2uYzR0505MTtVVsvtQ
 NDulh6tLXr4runDIQULeOhd6H75IrbJRuQIHX5hzeuIHO99AAVc1qpqd8SpwRsXINrClq6nvaPNh
 iaHreyiQMy716Xb.BsU1ennVfqiiKtsXb57XGfyi4L8XTSC3Fn5jgekBOszM4_NbrAgCcy8q1aA8
 ffaudBuCjHcjd.6cQOEzsP2PefyOOHnxJmVyDztUzgJxtxNacPwzkiQLTnTijoHb0LgyuXSDAF1j
 1oSNVzP0ipH3QH1k19ps56T4VGtJ9IgSSc6CJtvI5ijLsldYyy.sIVvUW5qwtRiySeL9JEgQ.gct
 FzExafwzt89Cu4_qi1m9uM7Lky_JyZWrCLcbu_8TIwZGrrdAQoQ3Ntb4dyid67QhUIxK3l8CV9wG
 um74JzTh91K_5L1AZdQPyxvyBOoy.pij_Qznfbbrc5hJIaoon4cmqkxm2gxekCn.fPL7tC4NugtR
 1O4dZ7tjxEei_L0NjkpVyAs7Bk.DxsYBpw32pFwC9BGf010u.rTEdFqRby9GaXxODGzSqRbqNMEC
 hqnzyJaPHPEpRswX2f80WQKhBG3S4nhQJ8sOUnITMAVhb9xOjm3E.qXgrRkSJCNc662_h7_79P_w
 PTv_HmJYNE3wiEO26QWyfUFQ1L5snZLxZhj4aKK_LPR64TjBrPsAlDlHwxRc6_i7veKR1pWGi9tN
 IrYCuAPD.zGLVSRcrtzVgYgwE8YmZzTuC.v2i4fnLRAYas3cAXaZNTk.4KiKQv38d0F9KD1acxcB
 TlsWkVSAPuHWFMTkWQHwaUeCSdKVqy_xxFbbOOeoYJGIwN5i.UyDkxXjteSvtL1OF6ZWFdXfBqJb
 cNoFgjGk0ZA5rIMBcgUUfvC79O6q1d8tHicOLdAPBBCXAhs93xRgRFcq9ngqKpsacVY5JTrBuDcH
 ktWrTTPkh.yv8.VoBxuCld07DyM9elkLOE9OHzCE5oUqoBWnch5KusUwlRVUfrLWQZZ13OfamQrt
 lQsPPNWvDE_qNtUoItU2ovzfouvJhdcXb1v8fGSwVw9LNYlQ0H0BKe8sFLvaNgxLAFYqC3gSSmR0
 YWKxfjdpm.F0UHaqY_3AtIeANSmSdDv4jBmuw6q4El04CMmBMFbtcOIeS5NJdzv95CA9BQTsBEk5
 IztqcfgxfHkT4h0wIfY1p082hyz7s7J_U_Rc..W7ir_J1Z8W7KU9UBRxz3iJugtaoOeM-
X-Sonic-MF: <konrad.frederic@yahoo.fr>
X-Sonic-ID: e83433df-8da7-425d-b03b-da7d68dda5fb
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.ir2.yahoo.com with HTTP; Sun, 27 Aug 2023 13:58:20 +0000
Date: Sun, 27 Aug 2023 13:58:16 +0000 (UTC)
From: Frederic Konrad <konrad.frederic@yahoo.fr>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <750471950.1150401.1693144696776@mail.yahoo.com>
In-Reply-To: <2f63a7b2-e70f-42a4-a0c7-346e7e00ebda@tls.msk.ru>
References: <2f63a7b2-e70f-42a4-a0c7-346e7e00ebda@tls.msk.ru>
Subject: Re: hw/display/xlinx-dp: fixing comment
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_1150400_1163415542.1693144696774"
X-Mailer: WebService/1.1.21763 YMailNorrin
Received-SPF: pass client-ip=77.238.176.162;
 envelope-from=konrad.frederic@yahoo.fr;
 helo=sonic311-30.consmr.mail.ir2.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

------=_Part_1150400_1163415542.1693144696774
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 Hi,
Yes that comment makes sense thanks.

Best Regards,Fred

    Le samedi 26 ao=C3=BBt 2023 =C3=A0 12:20:35 UTC+2, Michael Tokarev <mjt=
@tls.msk.ru> a =C3=A9crit : =20
=20
 Hi!

Hopefully this address still works. If not, let's just commit Peter's comme=
nt.

Back in 2016, this commit introduced xlinx-dp.c:

commit 58ac482a66de09a7590f705e53fc6a3fb8a055e8
Author: Frederic Konrad <konrad.frederic@yahoo.fr>
Date:=C2=A0 Tue Jun 14 15:59:15 2016 +0100

=C2=A0 =C2=A0 introduce xlnx-dp

=C2=A0 =C2=A0 This is the implementation of the DisplayPort.
=C2=A0 =C2=A0 It has an aux-bus to access dpcd and edid.


This commit has the following comment in it:

+static void xlnx_dp_audio_callback(void *opaque, int avail)
+{
+=C2=A0 =C2=A0 /*
+=C2=A0 =C2=A0 * Get some data from the DPDMA and compute these datas.
+=C2=A0 =C2=A0 * Then wait for QEMU's audio subsystem to call this callback=
.
+=C2=A0 =C2=A0 */

As it is, the commit is difficult to understand and has spelling
error in it (datas).=C2=A0 Is the following interpretation by Peter
Maydell correct?

=C2=A0 =C2=A0 /*
=C2=A0 =C2=A0 * Get the individual left and right audio streams from
=C2=A0 =C2=A0 * the DPDMA, and fill the output buffer with the
=C2=A0 =C2=A0 * combined stereo audio data adjusted by the volume
=C2=A0 =C2=A0 * controls.
=C2=A0 =C2=A0 * QEMU's audio subsystem will call this callback
=C2=A0 =C2=A0 * repeatedly; we return it the data from the output
=C2=A0 =C2=A0 * buffer until it is emptied, and then we will read
=C2=A0 =C2=A0 * data from the DPDMA again.
=C2=A0 =C2=A0 */

Thanks,

/mjt
 =20
------=_Part_1150400_1163415542.1693144696774
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div class=3D"ydpc74e8915yahoo-style-wrap" style=
=3D"font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:13px=
;"><div></div>
        <div dir=3D"ltr" data-setdir=3D"false">Hi,</div><div dir=3D"ltr" da=
ta-setdir=3D"false"><br></div><div dir=3D"ltr" data-setdir=3D"false">Yes th=
at comment makes sense thanks.<br></div><div dir=3D"ltr" data-setdir=3D"fal=
se"><br></div><div dir=3D"ltr" data-setdir=3D"false">Best Regards,</div><di=
v dir=3D"ltr" data-setdir=3D"false">Fred<br></div><div><br></div>
       =20
        </div><div id=3D"yahoo_quoted_3764357619" class=3D"yahoo_quoted">
            <div style=3D"font-family:'Helvetica Neue', Helvetica, Arial, s=
ans-serif;font-size:13px;color:#26282a;">
               =20
                <div>
                    Le samedi 26 ao=C3=BBt 2023 =C3=A0 12:20:35 UTC+2, Mich=
ael Tokarev &lt;mjt@tls.msk.ru&gt; a =C3=A9crit :
                </div>
                <div><br></div>
                <div><br></div>
                <div><div dir=3D"ltr">Hi!<br></div><div dir=3D"ltr"><br></d=
iv><div dir=3D"ltr">Hopefully this address still works. If not, let's just =
commit Peter's comment.<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr=
">Back in 2016, this commit introduced xlinx-dp.c:<br></div><div dir=3D"ltr=
"><br></div><div dir=3D"ltr">commit 58ac482a66de09a7590f705e53fc6a3fb8a055e=
8<br></div><div dir=3D"ltr">Author: Frederic Konrad &lt;<a ymailto=3D"mailt=
o:konrad.frederic@yahoo.fr" href=3D"mailto:konrad.frederic@yahoo.fr">konrad=
.frederic@yahoo.fr</a>&gt;<br></div><div dir=3D"ltr">Date:&nbsp;  Tue Jun 1=
4 15:59:15 2016 +0100<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">=
&nbsp; &nbsp;  introduce xlnx-dp<br></div><div dir=3D"ltr"><br></div><div d=
ir=3D"ltr">&nbsp; &nbsp;  This is the implementation of the DisplayPort.<br=
></div><div dir=3D"ltr">&nbsp; &nbsp;  It has an aux-bus to access dpcd and=
 edid.<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr"><br></div><div =
dir=3D"ltr">This commit has the following comment in it:<br></div><div dir=
=3D"ltr"><br></div><div dir=3D"ltr">+static void xlnx_dp_audio_callback(voi=
d *opaque, int avail)<br></div><div dir=3D"ltr">+{<br></div><div dir=3D"ltr=
">+&nbsp; &nbsp; /*<br></div><div dir=3D"ltr">+&nbsp; &nbsp;  * Get some da=
ta from the DPDMA and compute these datas.<br></div><div dir=3D"ltr">+&nbsp=
; &nbsp;  * Then wait for QEMU's audio subsystem to call this callback.<br>=
</div><div dir=3D"ltr">+&nbsp; &nbsp;  */<br></div><div dir=3D"ltr"><br></d=
iv><div dir=3D"ltr">As it is, the commit is difficult to understand and has=
 spelling<br></div><div dir=3D"ltr">error in it (datas).&nbsp; Is the follo=
wing interpretation by Peter<br></div><div dir=3D"ltr">Maydell correct?<br>=
</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">&nbsp; &nbsp; /*<br></div=
><div dir=3D"ltr">&nbsp; &nbsp;  * Get the individual left and right audio =
streams from<br></div><div dir=3D"ltr">&nbsp; &nbsp;  * the DPDMA, and fill=
 the output buffer with the<br></div><div dir=3D"ltr">&nbsp; &nbsp;  * comb=
ined stereo audio data adjusted by the volume<br></div><div dir=3D"ltr">&nb=
sp; &nbsp;  * controls.<br></div><div dir=3D"ltr">&nbsp; &nbsp;  * QEMU's a=
udio subsystem will call this callback<br></div><div dir=3D"ltr">&nbsp; &nb=
sp;  * repeatedly; we return it the data from the output<br></div><div dir=
=3D"ltr">&nbsp; &nbsp;  * buffer until it is emptied, and then we will read=
<br></div><div dir=3D"ltr">&nbsp; &nbsp;  * data from the DPDMA again.<br><=
/div><div dir=3D"ltr">&nbsp; &nbsp;  */<br></div><div dir=3D"ltr"><br></div=
><div dir=3D"ltr">Thanks,<br></div><div dir=3D"ltr"><br></div><div dir=3D"l=
tr">/mjt<br></div></div>
            </div>
        </div></body></html>
------=_Part_1150400_1163415542.1693144696774--

