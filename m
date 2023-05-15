Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D12017032E2
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:26:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyb1t-0005ni-7r; Mon, 15 May 2023 12:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <secalert@redhat.com>)
 id 1pyb1r-0005nN-66; Mon, 15 May 2023 12:26:31 -0400
Received: from outbound28.service-now.com ([149.96.5.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <secalert@redhat.com>)
 id 1pyb1o-00063N-Ls; Mon, 15 May 2023 12:26:30 -0400
Received: from app141155.ytz3.service-now.com (unknown [10.248.2.236])
 by outbound28.service-now.com (Postfix) with ESMTP id 44FF641F29DE;
 Mon, 15 May 2023 09:26:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 outbound28.service-now.com 44FF641F29DE
Date: Mon, 15 May 2023 09:26:25 -0700 (PDT)
From: Red Hat Product Security <secalert@redhat.com>
To: marcel.apfelbaum@gmail.com, mcascell@redhat.com,
 qemu-security@nongnu.org, yuval.shaia.ml@gmail.com,
 qemu-devel@nongnu.org, soulchen8650@gmail.com
Message-ID: <30146075.23060.1684167985262@app141155.ytz3.service-now.com>
Subject: Re: [PATCH v1] hw/pvrdma: Protect against buggy or malicious guest
 driver
MIME-Version: 1.0
Content-Type: multipart/mixed; 
 boundary="----=_Part_23058_30033456.1684167985262"
X-ServiceNow-Source: Notification-ec04d32213ede300196f7e276144b04e
X-ServiceNow-SysEmail-Version: 2
Precedence: bulk
Auto-Submitted: auto-generated
X-ServiceNow-Generated: true
Received-SPF: pass client-ip=149.96.5.7; envelope-from=secalert@redhat.com;
 helo=outbound28.service-now.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Red Hat Product Security <secalert@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

------=_Part_23058_30033456.1684167985262
Content-Type: multipart/alternative; 
	boundary="----=_Part_23059_23364167.1684167985262"

------=_Part_23059_23364167.1684167985262
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hello!

INC2534320 ([PATCH v1] hw/pvrdma: Protect against buggy or malicious guest =
driver) has been closed.

Opened for:=C2=A0yuval.shaia.ml@gmail.com
Followers:=C2=A0qemu-devel@nongnu.org, soulchen8650@gmail.com, Mauro Matteo=
 Cascella, qemu-security@nongnu.org, yuval.shaia.ml@gmail.com, marcel.apfel=
baum@gmail.com

A Guest updated your request with the following comments:

Reply from: mjt@tls.msk.ru [mailto:mjt@tls.msk.ru]
=C2=A001.03.2023 17:29, Yuval Shaia wrote:
> Guest driver allocates and initialize page tables to be used as a ring
> of descriptors for CQ and async events.
> The page table that represents the ring, along with the number of pages
> in the page table is passed to the device.
> Currently our device supports only one page table for a ring.
>=20
> Let's make sure that the number of page table entries the driver
> reports, do not exceeds the one page table size.
>=20
> Reported-by: Soul Chen <soulchen8650@gmail.com [mailto:soulchen8650@gmail=
.com]>
> Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com [mailto:yuval.shaia.=
ml@gmail.com]>
> ---
> v0 -> v1:
> * Take ring-state into account
> * Add Reported-by
> ---
> hw/rdma/vmw/pvrdma_main.c | 16 +++++++++++++++-
> 1 file changed, 15 insertions(+), 1 deletion(-)
=C2=A0Fixes: CVE-2023-1544
=C2=A0Ping ^2?
Laurent, maybe you can take this one too?
I understand the fact you picked up the previous one in this area
does not make you pvrdma maintainer, but it is definitely being stuck.. :)
=C2=A0/mjt

How can I track and update my request?

We want to make sure we have provided you with a complete resolution.

If you feel that your request should not be closed yet, then please reply t=
o this email and let us know.

Thank you,
Product Security

Ref:MSG74315854
------=_Part_23059_23364167.1684167985262
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head></head><body><div><p style=3D"margin-top:0;margin-bottom:10px;"=
>Hello!</p><p style=3D"margin-top:0;margin-bottom:10px;">INC2534320 ([PATCH=
 v1] hw/pvrdma: Protect against buggy or malicious guest driver) has been c=
losed.</p><p style=3D"margin-top:0;margin-bottom:10px;">Opened for:&nbsp;yu=
val.shaia.ml@gmail.com<br>Followers:&nbsp;qemu-devel@nongnu.org, soulchen86=
50@gmail.com, Mauro Matteo Cascella, qemu-security@nongnu.org, yuval.shaia.=
ml@gmail.com, marcel.apfelbaum@gmail.com</p></div>
<p style=3D"margin-top: 10px; margin-bottom: 10px;">A Guest updated your re=
quest with the following comments:</p>
<div style=3D"padding: 10px 0 10px 10px; background-color: ivory;"><div>Rep=
ly from: <a target=3D"_blank" href=3D"mailto:mjt@tls.msk.ru" rel=3D"noopene=
r noreferrer nofollow">mjt@tls.msk.ru</a></div><div>&nbsp;</div><div>01.03.=
2023 17:29, Yuval Shaia wrote:</div><div>&gt; Guest driver allocates and in=
itialize page tables to be used as a ring</div><div>&gt; of descriptors for=
 CQ and async events.</div><div>&gt; The page table that represents the rin=
g, along with the number of pages</div><div>&gt; in the page table is passe=
d to the device.</div><div>&gt; Currently our device supports only one page=
 table for a ring.</div><div>&gt; </div><div>&gt; Let's make sure that the =
number of page table entries the driver</div><div>&gt; reports, do not exce=
eds the one page table size.</div><div>&gt; </div><div>&gt; Reported-by: So=
ul Chen &lt;<a target=3D"_blank" href=3D"mailto:soulchen8650@gmail.com" rel=
=3D"noopener noreferrer nofollow">soulchen8650@gmail.com</a>&gt;</div><div>=
&gt; Signed-off-by: Yuval Shaia &lt;<a target=3D"_blank" href=3D"mailto:yuv=
al.shaia.ml@gmail.com" rel=3D"noopener noreferrer nofollow">yuval.shaia.ml@=
gmail.com</a>&gt;</div><div>&gt; ---</div><div>&gt; v0 -&gt; v1:</div><div>=
&gt; =09* Take ring-state into account</div><div>&gt; =09* Add Reported-by<=
/div><div>&gt; ---</div><div>&gt;   hw/rdma/vmw/pvrdma_main.c | 16 ++++++++=
+++++++-</div><div>&gt;   1 file changed, 15 insertions(+), 1 deletion(-)</=
div><div>&nbsp;</div><div>Fixes: CVE-2023-1544</div><div>&nbsp;</div><div>P=
ing ^2?</div><div>Laurent, maybe you can take this one too?</div><div>I und=
erstand the fact you picked up the previous one in this area</div><div>does=
 not make you pvrdma maintainer, but it is definitely being stuck.. :)</div=
><div>&nbsp;</div><div>/mjt</div></div>
<div><p style=3D"margin-top:20px;margin-bottom:5px;"><strong>How can I trac=
k and update my request?</strong></p><p style=3D"margin-top:0;margin-bottom=
:0;">We want to make sure we have provided you with a complete resolution.<=
/p><p style=3D"margin-top:0;margin-bottom:10px;">If you feel that your requ=
est should not be closed yet, then please reply to this email and let us kn=
ow.</p></div>
<p style=3D"margin-top: 14px; margin-bottom: 0;">Thank you,<br>Product Secu=
rity</p><div>&nbsp;</div><div style=3D"display:inline">Ref:MSG74315854</div=
></body></html>
------=_Part_23059_23364167.1684167985262--

------=_Part_23058_30033456.1684167985262--

