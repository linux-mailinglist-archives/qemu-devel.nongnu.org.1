Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE687AEE83
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 16:45:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql9JZ-00025v-L8; Tue, 26 Sep 2023 10:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ql9JV-00025Y-1o
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ql9JT-0006X8-09
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695739522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jo1jF6Tz2JEmfw/m+d4sLfTT/oMF3LY7OkcfOdl40lQ=;
 b=W/h/5NAMLmdaiS8EYU2dgprFnpt79X3nlKjcS3QVfEr19BJARjG9SRRedImjgf9tQ0nvhC
 /FBMx1AD1A3ZJxi0S5qfmVoiRQ8t8YT6XLjYYf/+xjfyCLCOUGnPlvCm6Zr0UdatCd0Nqt
 wDNgMzRqsQ1KMN5stFGQn2s74RkFTP4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-1_jTRiygMdiyaWgc6TszEA-1; Tue, 26 Sep 2023 10:45:19 -0400
X-MC-Unique: 1_jTRiygMdiyaWgc6TszEA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2746ce771f7so8527547a91.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 07:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695739518; x=1696344318;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jo1jF6Tz2JEmfw/m+d4sLfTT/oMF3LY7OkcfOdl40lQ=;
 b=RQaFF4vRg/wcX3vwl8htyBiRIGnqrHcVdNRtBit4hDMR4lSTpFoKHrXFTJJI1XkVkc
 TrY1ldxAQP1u47KxBeXb+M/h90nMt1QLm/B2PZRvgMvI8rwVEpJtPt6GcbKIUJ/jK3e7
 +1qxfMHXfLnDRCvJ3LwjYYBiDnFLFuVcxLsGdM0zxOgLyy6ppx5m5fGBFYwsbE0SVcJ8
 7+FCOiIzQ3oW1wGrXMfkFhDRQSllKM9EDoBS6lBC+SkRw3tsqb7V6VfEl//Hn1TnatG6
 PZRe8XFwTfM2aiOV02YZKf/EakiPS9HNxHDJZI21ZF2AmihPNFB3lNhsEpH13zPFvVBv
 hzCA==
X-Gm-Message-State: AOJu0YxqTd+Bd4Q9hAh8dNniZ2t5yZBeND8MwbcQOWjAynS10Mk+/ChL
 H0fgldW7jW6rK72hHJ2dhuDFq67+f+cgM47zugXgQqBt+DJhs5hERzS8kyE8QVQLW13Grmf1eeX
 KboGv8gZ2640f25LLrcQ7yWTnjvWkOPc=
X-Received: by 2002:a17:90b:3885:b0:267:f9c4:c0a8 with SMTP id
 mu5-20020a17090b388500b00267f9c4c0a8mr7723785pjb.4.1695739518564; 
 Tue, 26 Sep 2023 07:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7ZGomZ9aFYezzvVNrzAkvCYULbcEqm5NESuQ4NPi69slIxqUEOiUXn00NJo4+Xz1ydspO6J5bgZ/sofckRrY=
X-Received: by 2002:a17:90b:3885:b0:267:f9c4:c0a8 with SMTP id
 mu5-20020a17090b388500b00267f9c4c0a8mr7723762pjb.4.1695739518176; Tue, 26 Sep
 2023 07:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230921160712.99521-1-simon.rowe@nutanix.com>
 <20230921160712.99521-2-simon.rowe@nutanix.com>
 <CAFn=p-YL_hmnrFY9hhuMgMkV4hL3dojMMWUdG9=DBGYuxi_TUw@mail.gmail.com>
 <7658d927-1d05-8f2d-9739-d1db692bee72@proxmox.com>
In-Reply-To: <7658d927-1d05-8f2d-9739-d1db692bee72@proxmox.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 26 Sep 2023 10:45:07 -0400
Message-ID: <CAFn=p-YkEJajV_YuOsK4KPL6T1erEhdkameN-XEEXrwY+XZZ6g@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/ide/core: terminate in-flight DMA on IDE bus reset
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Niklas Cassel <niklas.cassel@wdc.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Qemu-block <qemu-block@nongnu.org>, Simon Rowe <simon.rowe@nutanix.com>, 
 Felipe Franciosi <felipe@nutanix.com>
Content-Type: multipart/alternative; boundary="0000000000009ce5020606441f27"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000009ce5020606441f27
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023, 3:11 AM Fiona Ebner <f.ebner@proxmox.com> wrote:

> Am 25.09.23 um 21:53 schrieb John Snow:
> > On Thu, Sep 21, 2023 at 12:07=E2=80=AFPM Simon Rowe <simon.rowe@nutanix=
.com>
> wrote:
> >>
> >> When an IDE controller is reset, its internal state is being cleared
> >> before any outstanding I/O is cancelled. If a response to DMA is
> >> received in this window, the aio callback will incorrectly continue
> >> with the next part of the transfer (now using sector 0 from
> >> the cleared controller state).
> >
> > Eugh, yikes. It feels like we should fix the cancellation ...
> Please note that there already is a patch for that on the list:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-09/msg01011.html
>
> Best Regards,
> Fiona
>

Gotcha, thanks for the pointer. I wonder if that's sufficient to fix the
CVE here? I don't have the reproducer in my hands (that I know of ... it's
genuinely possible I missed it, apologies)

>

--0000000000009ce5020606441f27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Sep 26, 2023, 3:11 AM Fiona Ebner &lt;<a href=
=3D"mailto:f.ebner@proxmox.com">f.ebner@proxmox.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">Am 25.09.23 um 21:53 schrieb John Snow:<br>
&gt; On Thu, Sep 21, 2023 at 12:07=E2=80=AFPM Simon Rowe &lt;<a href=3D"mai=
lto:simon.rowe@nutanix.com" target=3D"_blank" rel=3D"noreferrer">simon.rowe=
@nutanix.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; When an IDE controller is reset, its internal state is being clear=
ed<br>
&gt;&gt; before any outstanding I/O is cancelled. If a response to DMA is<b=
r>
&gt;&gt; received in this window, the aio callback will incorrectly continu=
e<br>
&gt;&gt; with the next part of the transfer (now using sector 0 from<br>
&gt;&gt; the cleared controller state).<br>
&gt; <br>
&gt; Eugh, yikes. It feels like we should fix the cancellation ... <br>
Please note that there already is a patch for that on the list:<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2023-09/msg0101=
1.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.nongn=
u.org/archive/html/qemu-devel/2023-09/msg01011.html</a><br>
<br>
Best Regards,<br>
Fiona<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Gotcha, thanks for the pointer. I wonder if that&#39;s sufficient to f=
ix the CVE here? I don&#39;t have the reproducer in my hands (that I know o=
f ... it&#39;s genuinely possible I missed it, apologies)</div><div dir=3D"=
auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000009ce5020606441f27--


