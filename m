Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECB479A3E1
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:49:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfahW-0000lC-Ox; Mon, 11 Sep 2023 02:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qfah0-000807-K4
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qfagy-0005Ke-3k
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694414799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2GFEsMHhmxwDeXAhRY5jRzLsshWG+kXShsF5dZtdzMA=;
 b=Ne/YmOpR+DgkuQBDgoT+sF1GH4pRP9bKEyAWAgAsQmtynjSOfI1WgKUSiFMLbDTQBF2YLL
 iWg5zX1t/Xs6FEYS/oVkQbwwIEkgBdxLDmxG2RfoVMRpEa5ioe+ZwIntr2xA85ANuAHDeJ
 awq8RFuibRWq/2R0Pg05XZIXIHY16dI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-9MITMFqSNGi7z8dm9clwgw-1; Mon, 11 Sep 2023 02:46:36 -0400
X-MC-Unique: 9MITMFqSNGi7z8dm9clwgw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-26f3fce5b0bso4924503a91.2
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414795; x=1695019595;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2GFEsMHhmxwDeXAhRY5jRzLsshWG+kXShsF5dZtdzMA=;
 b=V0KVHVUwaLomisIyfMesLH7hpL0eM1IpJ50tZglj1atGgcNib/4X0yjTzlikrJ0dKQ
 7BgW6nll2ihyQPCtvvA1LsUBMb9ymtGCE1GFG0Yy20zGpIFGTmLVmyojsHJHTpyj2BGF
 Gklxxhp8mzMpvl+Idu3WsMKHjSTqn5UEwogy5wi4Uwmq1PsKe5Kw/mYLClUDjbayIH5H
 lGAD1SY+bKh7sQvfhR4/hIMy9EvXYbl0NUvmUuIXuJlltosS5QbvI9DxjMP3Qe6uuF6z
 HCHJ6oQCnVN5pz/xPtvNC+A/KYpFQHwvJvsrY3BZ4LHD4c2ZqlwguYTX0ke+ZT6xncuR
 /s/Q==
X-Gm-Message-State: AOJu0YxzwufeTsbkyxE294Qfygjy8Yu7suX5hEysj/oZGkY8nPbqSo8P
 y84vT+ZdSKG+rn58Tar0U5QIx229KM1JAGCFVPxM7AfBYjdSPagJoryMp1OW0LKDKK7263ItDdm
 woJmdoKsKCP9uBaKlcDM7kqD24I1VsG0=
X-Received: by 2002:a17:90b:4c45:b0:273:dfd8:c01c with SMTP id
 np5-20020a17090b4c4500b00273dfd8c01cmr5052471pjb.40.1694414794601; 
 Sun, 10 Sep 2023 23:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNE557DCto0iycgCe5tX3cW1MoPHbT3P9m8efy/TcE8NYrKAqu6w8vOlgbtWWJMznid7+Q7tTfzNP1ZTTvxA8=
X-Received: by 2002:a17:90b:4c45:b0:273:dfd8:c01c with SMTP id
 np5-20020a17090b4c4500b00273dfd8c01cmr5052441pjb.40.1694414793410; Sun, 10
 Sep 2023 23:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230908154743.809569-1-aesteve@redhat.com>
 <5b82b6ae-cc19-2fc7-abef-8eefe40e4247@linaro.org>
In-Reply-To: <5b82b6ae-cc19-2fc7-abef-8eefe40e4247@linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 11 Sep 2023 08:46:22 +0200
Message-ID: <CADSE00LndhSPGDOqCkO-ewOg2R3sF1ULPtYXZ4Q_SQP+youshQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Virtio shared dma-buf
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 marcandre.lureau@gmail.com, 
 cohuck@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com
Content-Type: multipart/alternative; boundary="000000000000dd1e8906050faf4d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000dd1e8906050faf4d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 8, 2023 at 5:55=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> On 8/9/23 17:47, Albert Esteve wrote:
> > v1 link ->
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg00598.html
> > v2 link ->
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04530.html
> > v3 link ->
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg06126.html
> > v4 link ->
> https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg05174.html
> > v5 link ->
> https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg00255.html
> > v6 link ->
> https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg00987.html
> > v7 link ->
> https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01190.html
> > v7 -> v8:
> > - Move "qemu/osdep.h" include to the virtio-dmabuf source file.
> > - Remove duplicated glib include.
> > - Change the title of commits to better reflect the path to the change
>
> Thank Albert you for the various respin with review comment addressed.
>
>
Hi Philippe,

Thank you for taking the time to review!


> Michael, no other comment on my side.
>
> Regards,
>
> Phil.
>
> > This patch covers the required steps to add support for virtio
> cross-device resource sharing[1],
> > which support is already available in the kernel.
>
> > Albert Esteve (4):
> >    util/uuid: add a hash function
> >    hw/display: introduce virtio-dmabuf
> >    vhost-user: add shared_object msg
> >    libvhost-user: handle shared_object msg
>
>

--000000000000dd1e8906050faf4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 8, 2023 at 5:55=
=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro=
.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On 8/9/23 17:47, Albert Esteve wrote:<br>
&gt; v1 link -&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel=
/2023-05/msg00598.html" rel=3D"noreferrer" target=3D"_blank">https://lists.=
gnu.org/archive/html/qemu-devel/2023-05/msg00598.html</a><br>
&gt; v2 link -&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel=
/2023-05/msg04530.html" rel=3D"noreferrer" target=3D"_blank">https://lists.=
gnu.org/archive/html/qemu-devel/2023-05/msg04530.html</a><br>
&gt; v3 link -&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel=
/2023-05/msg06126.html" rel=3D"noreferrer" target=3D"_blank">https://lists.=
gnu.org/archive/html/qemu-devel/2023-05/msg06126.html</a><br>
&gt; v4 link -&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel=
/2023-06/msg05174.html" rel=3D"noreferrer" target=3D"_blank">https://lists.=
gnu.org/archive/html/qemu-devel/2023-06/msg05174.html</a><br>
&gt; v5 link -&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel=
/2023-08/msg00255.html" rel=3D"noreferrer" target=3D"_blank">https://lists.=
gnu.org/archive/html/qemu-devel/2023-08/msg00255.html</a><br>
&gt; v6 link -&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel=
/2023-09/msg00987.html" rel=3D"noreferrer" target=3D"_blank">https://lists.=
gnu.org/archive/html/qemu-devel/2023-09/msg00987.html</a><br>
&gt; v7 link -&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel=
/2023-09/msg01190.html" rel=3D"noreferrer" target=3D"_blank">https://lists.=
gnu.org/archive/html/qemu-devel/2023-09/msg01190.html</a><br>
&gt; v7 -&gt; v8:<br>
&gt; - Move &quot;qemu/osdep.h&quot; include to the virtio-dmabuf source fi=
le.<br>
&gt; - Remove duplicated glib include.<br>
&gt; - Change the title of commits to better reflect the path to the change=
<br>
<br>
Thank Albert you for the various respin with review comment addressed.<br>
<br></blockquote><div><br></div><div>Hi Philippe,</div><div><br></div><div>=
Thank you for taking the time to review!</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
Michael, no other comment on my side.<br>
<br>
Regards,<br>
<br>
Phil.<br>
<br>
&gt; This patch covers the required steps to add support for virtio cross-d=
evice resource sharing[1],<br>
&gt; which support is already available in the kernel.<br>
<br>
&gt; Albert Esteve (4):<br>
&gt;=C2=A0 =C2=A0 util/uuid: add a hash function<br>
&gt;=C2=A0 =C2=A0 hw/display: introduce virtio-dmabuf<br>
&gt;=C2=A0 =C2=A0 vhost-user: add shared_object msg<br>
&gt;=C2=A0 =C2=A0 libvhost-user: handle shared_object msg<br>
<br>
</blockquote></div></div>

--000000000000dd1e8906050faf4d--


