Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB18072BF1F
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 12:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8eqq-0006nU-KL; Mon, 12 Jun 2023 06:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1q8eqo-0006mb-RQ
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 06:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1q8eqn-0003AZ-6z
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 06:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686565960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L3kjKlmlo8m3pz6ZdryL3iaANjHxm8k9snUYnwkVFVc=;
 b=ZuTnZ9o1VMfYS+6CuIcn58VVkkfN+lYgwTYwrDa17GUa+KcCNbxqYj30260BPTSxEi9+Gt
 jsHJnqnzGOfsbuvwAqhgJCiRGTvUgR2UqNNSIVQlkR1p4F6ReVrxM+oa+Qwce0n3Ov+pHq
 b19Zf/sjsxDgUdQmVJmyXREdUr9j8N4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-sEUtDQdvMNSHqdmaHnIZBg-1; Mon, 12 Jun 2023 06:32:38 -0400
X-MC-Unique: sEUtDQdvMNSHqdmaHnIZBg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9775f04de56so480999666b.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 03:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686565957; x=1689157957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L3kjKlmlo8m3pz6ZdryL3iaANjHxm8k9snUYnwkVFVc=;
 b=KV5KlWEqQdsNWFyn8HP40D/PdIF0tcvQQHJvlSyDMHfY8t9a7yr6C0WKvFrq5UF83w
 gO7cYb7gEHGM1NMSjCrYrRtC9XXJUv73vjzrzct7B/d8b8q+15Aalsg4d38BQFdPbtTk
 L85yN1b2YSjrO2x0HKJd0GqwHCZmoetjph5fvchTyDKBAelAdocLtIVcxd9F5Gx7k9wO
 PD3+Fkm6Cl+DqKxTiBTVOVShHY6SIz710wTTh/SJsTG27B746cN8hQFxWj27IfKMjFJB
 K/QvHsTkJLccLyZwOKd2ZpAnbZmeCzIo2PdFVMmFyP30DIoXnfF/v3RX6r/bZTbcXaTx
 KRxA==
X-Gm-Message-State: AC+VfDwNFVrLXbDrThN5mdZZkz6GcXwmoVMmDmUb3Sb26zYKSm/iMgbW
 mW5c2d/4h+4lWdTwrhDSoD3yCWtCVuTY4BqN612++ZyT8SU4X4yNe4EGjZ8lCfCinlvGI9ttUa2
 Dgj1aBuECsloBXUNXIFXk1DjJycK1qDE=
X-Received: by 2002:a17:907:809:b0:977:cbaf:bc56 with SMTP id
 wv9-20020a170907080900b00977cbafbc56mr9774072ejb.43.1686565957725; 
 Mon, 12 Jun 2023 03:32:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4q0CC0x6Un9iGkemXe/jAf6AxgKG292IXwvUX4Gxfa0NnEE43IBt0+YZDOxEe47aaZ2s6l7mDYNs/TAGj/Pvg=
X-Received: by 2002:a17:907:809:b0:977:cbaf:bc56 with SMTP id
 wv9-20020a170907080900b00977cbafbc56mr9774061ejb.43.1686565957460; Mon, 12
 Jun 2023 03:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230607145455.158267-1-ernunes@redhat.com>
In-Reply-To: <20230607145455.158267-1-ernunes@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 12 Jun 2023 12:32:22 +0200
Message-ID: <CAMxuvayExoAWAC7kMwnJm1mjAJUAMwpfG9zHNa3yJfAQ+Gj=Vw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] vhost-user-gpu get_edid feature
To: Erico Nunes <ernunes@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, kraxel@redhat.com
Content-Type: multipart/alternative; boundary="000000000000c8f70105fdec3c81"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
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

--000000000000c8f70105fdec3c81
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 7, 2023 at 4:55=E2=80=AFPM Erico Nunes <ernunes@redhat.com> wro=
te:

> This adds support to the virtio-gpu get_edid command in qemu as the
> frontend as well as the vhost-user-gpu implementation in contrib/.
> So far, qemu has been outputting the following message:
>   EDID requested but the backend doesn't support it.
> when using that implementation.
>
> This is tested with vhost-user-gpu, the dbus ui backend and the
> monitor-edid application, which now shows complete "QEMU Monitor" edid
> data.
>
> The VHOST_USER_GPU_PROTOCOL_F_EDID protocol feature is required if the
> frontend sets the VIRTIO_GPU_F_EDID virtio-gpu feature. If the frontend
> sets the virtio-gpu feature but does not support the protocol feature,
> the backend will abort with an error.
>
> v2 -> v3:
> - Fixed review comments from v2. Missing struct documentation and
> setting feature bits to be compatible with the frontend.
>
> Erico Nunes (4):
>   virtio-gpu: refactor generate_edid function to virtio_gpu_base
>   docs: vhost-user-gpu: add protocol changes for EDID
>   contrib/vhost-user-gpu: implement get_edid feature
>   vhost-user-gpu: implement get_edid frontend feature
>
>  contrib/vhost-user-gpu/vhost-user-gpu.c | 73 +++++++++++++++++++++++--
>  contrib/vhost-user-gpu/virgl.c          |  3 +
>  contrib/vhost-user-gpu/vugpu.h          | 11 ++++
>  docs/interop/vhost-user-gpu.rst         | 28 +++++++++-
>  hw/display/vhost-user-gpu.c             | 36 ++++++++++++
>  hw/display/virtio-gpu-base.c            | 17 ++++++
>  hw/display/virtio-gpu.c                 | 20 +------
>  include/hw/virtio/virtio-gpu.h          |  2 +
>  8 files changed, 162 insertions(+), 28 deletions(-)
>

Except minor unused code to be fixed in last patch, series is:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--000000000000c8f70105fdec3c81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 7, 2023 at 4:55=E2=80=
=AFPM Erico Nunes &lt;<a href=3D"mailto:ernunes@redhat.com">ernunes@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">This adds support to the virtio-gpu get_edid command in qemu as the<br>
frontend as well as the vhost-user-gpu implementation in contrib/.<br>
So far, qemu has been outputting the following message:<br>
=C2=A0 EDID requested but the backend doesn&#39;t support it.<br>
when using that implementation.<br>
<br>
This is tested with vhost-user-gpu, the dbus ui backend and the<br>
monitor-edid application, which now shows complete &quot;QEMU Monitor&quot;=
 edid<br>
data.<br>
<br>
The VHOST_USER_GPU_PROTOCOL_F_EDID protocol feature is required if the<br>
frontend sets the VIRTIO_GPU_F_EDID virtio-gpu feature. If the frontend<br>
sets the virtio-gpu feature but does not support the protocol feature,<br>
the backend will abort with an error.<br>
<br>
v2 -&gt; v3:<br>
- Fixed review comments from v2. Missing struct documentation and<br>
setting feature bits to be compatible with the frontend.<br>
<br>
Erico Nunes (4):<br>
=C2=A0 virtio-gpu: refactor generate_edid function to virtio_gpu_base<br>
=C2=A0 docs: vhost-user-gpu: add protocol changes for EDID<br>
=C2=A0 contrib/vhost-user-gpu: implement get_edid feature<br>
=C2=A0 vhost-user-gpu: implement get_edid frontend feature<br>
<br>
=C2=A0contrib/vhost-user-gpu/vhost-user-gpu.c | 73 +++++++++++++++++++++++-=
-<br>
=C2=A0contrib/vhost-user-gpu/virgl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 3 +<br>
=C2=A0contrib/vhost-user-gpu/vugpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11=
 ++++<br>
=C2=A0docs/interop/vhost-user-gpu.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 28=
 +++++++++-<br>
=C2=A0hw/display/vhost-user-gpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 36 ++++++++++++<br>
=C2=A0hw/display/virtio-gpu-base.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 17 ++++++<br>
=C2=A0hw/display/virtio-gpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 20 +------<br>
=C2=A0include/hw/virtio/virtio-gpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 +<br>
=C2=A08 files changed, 162 insertions(+), 28 deletions(-)<br></blockquote><=
div><br></div><div>Except minor unused code to be fixed in last patch, seri=
es is:</div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:=
marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; <br></div>=
</div></div>

--000000000000c8f70105fdec3c81--


