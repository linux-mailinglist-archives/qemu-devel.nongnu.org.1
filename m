Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6C07034FB
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pybSJ-0007Cj-DC; Mon, 15 May 2023 12:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pybSG-0007CN-3w
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pybSE-00043b-BE
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684169625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=koXB86YcdlhtYM8jTsdhSNuw3MmESbIaCMNRDuLS0Ko=;
 b=BabnTVZk0Xdemk+NEucBP1bsdaDjC458tP8WJFWUKkIv2OrAiWhk5IZ5xAowOc/1W24azd
 s9hxMX5xzW+yndExHMrFKJl0WbdNK6eJC6YDtXIRhqSOWFXz60E62OntqAkcdcMC54nMUG
 Mq6S3uR61CaVLCQnVE7wfFbdcnoF+bs=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-FHIdc7NROumFtNq2Lt357A-1; Mon, 15 May 2023 12:53:43 -0400
X-MC-Unique: FHIdc7NROumFtNq2Lt357A-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-4346be31809so2677113137.1
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 09:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684169623; x=1686761623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=koXB86YcdlhtYM8jTsdhSNuw3MmESbIaCMNRDuLS0Ko=;
 b=iqo2houEA5pKKipAALisqpyHn52Tvu4s45IbZ600QIrxn+HmVv3k15Ho0WxD5aUYeu
 U3cgwIJTZjTnluKRupnIbKMukn1z4PJegAOxoWCvZxPegTrwFP4haksMo5u3Lu5U91+O
 5Q7OlY8+0jaSv99VOeGo3IyrZAHBidq/qBS149mbAiv5AJwMJnoC2YIqj04HEjNgT4Eu
 61tO+IakolBltdmPKl/UC4tpA2l/0EsTPO/cCv1/lqDzVRzoQujNiCZLAJE+QKV4L1Yv
 9FiwcIQewpkZdUbMf8aSBEn8MysNhT2g9F5qLW5mM1nNe9LuqMpXP+R9j7vwkgEhWj23
 5tRw==
X-Gm-Message-State: AC+VfDxi9oUQvZNCqpLfPQZ8Hcz3JZmUj7Q/Ca2wWS/xYiyRyOrnRzGH
 86VH/LPMmBt4kY863hTmPvVWfrqBniVumI1ucZncC1LZe54W4jC/1FhjJ83UiYZ4Gs29Zm6ZQ2Y
 spsBeT6qqBDVbZSWKrodSwz2oFSEu3nw=
X-Received: by 2002:a67:f50a:0:b0:432:8c1d:88a with SMTP id
 u10-20020a67f50a000000b004328c1d088amr14236040vsn.23.1684169623296; 
 Mon, 15 May 2023 09:53:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4IJstJVcpuWanKcigp/OBlT6XfGJ2JfUBuQ9f5i4bO8EJWK6XqhKi1wfvMoiL48EGouFCeIwy2TLCwWTNIbrk=
X-Received: by 2002:a67:f50a:0:b0:432:8c1d:88a with SMTP id
 u10-20020a67f50a000000b004328c1d088amr14236033vsn.23.1684169622998; Mon, 15
 May 2023 09:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230515135823.382388-1-pbonzini@redhat.com>
 <CANDNypxvFYQSeXyFg=wqqHNpghoAoU=FtJYMpZt5QzbXLJ6=jw@mail.gmail.com>
In-Reply-To: <CANDNypxvFYQSeXyFg=wqqHNpghoAoU=FtJYMpZt5QzbXLJ6=jw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 15 May 2023 18:53:31 +0200
Message-ID: <CABgObfZq7VqT_TU29h7y+G+ko3mRVNdHEaSuSbFomMgBMS_AMQ@mail.gmail.com>
Subject: Re: [PATCH] scsi-generic: fix buffer overflow on block limits inquiry
To: =?UTF-8?Q?Th=C3=A9o_Maillart?= <tmaillart@freebox.fr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000001ee68905fbbe4ccf"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000001ee68905fbbe4ccf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 15 mag 2023, 16:49 Th=C3=A9o Maillart <tmaillart@freebox.fr> ha scri=
tto:

> From my perspective r->buflen can be more than 16 bytes, The Block limits
> VPD
> page length is 0x3c (paragraph 5.4.5 page 475 from SCSI Commands Referenc=
e
> Manual, Rev. J).
>

Absolutely you're right. What a mess. :)

Paolo


> On Mon, May 15, 2023 at 3:58=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > Using linux 6.x guest, at boot time, an inquiry on a scsi-generic
> > device makes qemu crash.  This is caused by a buffer overflow when
> > scsi-generic patches the block limits VPD page.
> >
> > Do the operations on a temporary on-stack buffer that is guaranteed
> > to be large enough.
> >
> > Reported-by: Th=C3=A9o Maillart <tmaillart@freebox.fr>
> > Analyzed-by: Th=C3=A9o Maillart <tmaillart@freebox.fr>
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  hw/scsi/scsi-generic.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> > index ac9fa662b4e3..373fab0a2a61 100644
> > --- a/hw/scsi/scsi-generic.c
> > +++ b/hw/scsi/scsi-generic.c
> > @@ -191,12 +191,15 @@ static int
> scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s, int len)
> >      if ((s->type =3D=3D TYPE_DISK || s->type =3D=3D TYPE_ZBC) &&
> >          (r->req.cmd.buf[1] & 0x01)) {
> >          page =3D r->req.cmd.buf[2];
> > -        if (page =3D=3D 0xb0) {
> > +        if (page =3D=3D 0xb0 && r->buflen >=3D 8) {
>
> r->buflen > 8 because if r->buflen =3D=3D 8, the final memcpy will be vai=
n ?
>
> > +            uint8_t buf[16] =3D {};
> >              uint64_t max_transfer =3D calculate_max_transfer(s);
> > -            stl_be_p(&r->buf[8], max_transfer);
> > -            /* Also take care of the opt xfer len. */
> > -            stl_be_p(&r->buf[12],
> > -                    MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])))=
;
> > +
> > +            memcpy(buf, r->buf, r->buflen);
>
> Should be memcpy(buf, r->buf, MIN(r->buflen, 16)); ?
>
> > +            stl_be_p(&buf[8], max_transfer);
> > +            stl_be_p(&buf[12], MIN_NON_ZERO(max_transfer,
> ldl_be_p(&buf[12])));
> > +            memcpy(r->buf + 8, buf + 8, r->buflen - 8);
>
> Idem memcpy(r->buf + 8, buf + 8, MIN(r->buflen - 8, 8)); ?
>
> > +
> >          } else if (s->needs_vpd_bl_emulation && page =3D=3D 0x00 &&
> r->buflen >=3D 4) {
> >              /*
> >               * Now we're capable of supplying the VPD Block Limits
> > --
> > 2.40.1
> >
>
>

--0000000000001ee68905fbbe4ccf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 15 mag 2023, 16:49 Th=C3=A9o Maillart &lt;<a hr=
ef=3D"mailto:tmaillart@freebox.fr">tmaillart@freebox.fr</a>&gt; ha scritto:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">From my perspective r-&gt;buflen c=
an be more than 16 bytes, The Block limits VPD<br>
page length is 0x3c (paragraph 5.4.5 page 475 from SCSI Commands Reference<=
br>
Manual, Rev. J).<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Absolutely you&#39;re right. What a mess. :)</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
On Mon, May 15, 2023 at 3:58=E2=80=AFPM Paolo Bonzini &lt;<a href=3D"mailto=
:pbonzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.=
com</a>&gt; wrote:<br>
&gt;<br>
&gt; Using linux 6.x guest, at boot time, an inquiry on a scsi-generic<br>
&gt; device makes qemu crash.=C2=A0 This is caused by a buffer overflow whe=
n<br>
&gt; scsi-generic patches the block limits VPD page.<br>
&gt;<br>
&gt; Do the operations on a temporary on-stack buffer that is guaranteed<br=
>
&gt; to be large enough.<br>
&gt;<br>
&gt; Reported-by: Th=C3=A9o Maillart &lt;<a href=3D"mailto:tmaillart@freebo=
x.fr" target=3D"_blank" rel=3D"noreferrer">tmaillart@freebox.fr</a>&gt;<br>
&gt; Analyzed-by: Th=C3=A9o Maillart &lt;<a href=3D"mailto:tmaillart@freebo=
x.fr" target=3D"_blank" rel=3D"noreferrer">tmaillart@freebox.fr</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank" rel=3D=
"noreferrer">qemu-stable@nongnu.org</a><br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/scsi/scsi-generic.c | 13 ++++++++-----<br>
&gt;=C2=A0 1 file changed, 8 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c<br>
&gt; index ac9fa662b4e3..373fab0a2a61 100644<br>
&gt; --- a/hw/scsi/scsi-generic.c<br>
&gt; +++ b/hw/scsi/scsi-generic.c<br>
&gt; @@ -191,12 +191,15 @@ static int scsi_handle_inquiry_reply(SCSIGeneric=
Req *r, SCSIDevice *s, int len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if ((s-&gt;type =3D=3D TYPE_DISK || s-&gt;type =3D=
=3D TYPE_ZBC) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (r-&gt;req.cmd.buf[1] &amp; 0x01)) {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 page =3D r-&gt;req.cmd.buf[2];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (page =3D=3D 0xb0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (page =3D=3D 0xb0 &amp;&amp; r-&gt;buf=
len &gt;=3D 8) {<br>
<br>
r-&gt;buflen &gt; 8 because if r-&gt;buflen =3D=3D 8, the final memcpy will=
 be vain ?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t buf[16] =3D {};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t max_transfer =
=3D calculate_max_transfer(s);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stl_be_p(&amp;r-&gt;buf[8],=
 max_transfer);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Also take care of the op=
t xfer len. */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stl_be_p(&amp;r-&gt;buf[12]=
,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 MIN_NON_ZERO(max_transfer, ldl_be_p(&amp;r-&gt;buf[12])));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(buf, r-&gt;buf, r-&g=
t;buflen);<br>
<br>
Should be memcpy(buf, r-&gt;buf, MIN(r-&gt;buflen, 16)); ?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stl_be_p(&amp;buf[8], max_t=
ransfer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stl_be_p(&amp;buf[12], MIN_=
NON_ZERO(max_transfer, ldl_be_p(&amp;buf[12])));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(r-&gt;buf + 8, buf +=
 8, r-&gt;buflen - 8);<br>
<br>
Idem memcpy(r-&gt;buf + 8, buf + 8, MIN(r-&gt;buflen - 8, 8)); ?<br>
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (s-&gt;needs_vpd_bl_emulat=
ion &amp;&amp; page =3D=3D 0x00 &amp;&amp; r-&gt;buflen &gt;=3D 4) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Now we&#39;re =
capable of supplying the VPD Block Limits<br>
&gt; --<br>
&gt; 2.40.1<br>
&gt;<br>
<br>
</blockquote></div></div></div>

--0000000000001ee68905fbbe4ccf--


