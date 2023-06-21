Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF46737D3C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:21:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBt56-0000R5-0E; Wed, 21 Jun 2023 04:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qBt50-0000Nd-BM
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qBt4y-0007Dc-46
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687335639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5JSipsNyscisVAjAiXJbrOHvVpmc3Jes5OQrmS7Jjdk=;
 b=ccznPLa9f++zTkVKYe2P0mAGHTEcSyn2lhwL3hrPjY/DpLk9rPBkhCIO8YKIFNlO0WkK9K
 AXfpv9hV2nxiaUUJVlRLGfU0cmRIBPeP2nJSwQIgNiM6/SLWvVHF7dnboF8M2DA1LfBhOS
 Lh3uxzoYvwAdrb0toBiIBPxNvecNHBg=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-c6XFWXktPjuRyL4J0COOuQ-1; Wed, 21 Jun 2023 04:20:37 -0400
X-MC-Unique: c6XFWXktPjuRyL4J0COOuQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1ad14b0ba06so538355fac.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 01:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687335636; x=1689927636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5JSipsNyscisVAjAiXJbrOHvVpmc3Jes5OQrmS7Jjdk=;
 b=gKK+ehEHVeRtUbEut9tqtEWT8LNk33yDWkusElcPNrJrY4f4ksJjpQ/P5y5wQ873gt
 UxreuyaEu8YFEaZfKWRzaImxd+atr0qqovD620jhBwa9GVCREOFgJDWaDTlRHuVWTSix
 Yls64kE1UfqqDl7WRKsdv7px30st1eN/hOPk9kuvKCpo60SzoOSBB+3Ys+N2bM9Mf3z6
 aiMQ0RNUKvCBoA172uQ7vYLYq93mDillJ+JP74knTtocuS8g7gNmY09pn86GQ1Ij77Mr
 5pxmLqtt0D8Cl8nAM6zRMt1e1Pm+Tj5fRpK/wzeCGkT6m7fOfLof03lo/2mizsWWsQrQ
 sPZw==
X-Gm-Message-State: AC+VfDxJlrv3d8PrGU4fs5Ca2cNVHGN87S/cW4KGFK22TH8gq319n9ZN
 R1/sSMpn5j3G+6uiLxNUBqfb7Dvk4gVy5LtqjIZOtf00yzxewz/iZwzVGGuMIlqPgjJDxELgsgh
 ETf6D/1a1zvr+NRqJuybhrT3CSKxhYJYg067KtSg=
X-Received: by 2002:a05:6870:f906:b0:18b:15cd:9b45 with SMTP id
 ao6-20020a056870f90600b0018b15cd9b45mr7969435oac.40.1687335636485; 
 Wed, 21 Jun 2023 01:20:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4mdEb6Cm2CcUg9/1gZX2d64g2PwSKtd8fbN9M8K5hTFKUO6EnrIe8AgCwu3+djElLMN5VdtKKn0DC5NCMW13M=
X-Received: by 2002:a05:6870:f906:b0:18b:15cd:9b45 with SMTP id
 ao6-20020a056870f90600b0018b15cd9b45mr7969426oac.40.1687335636227; Wed, 21
 Jun 2023 01:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230524091333.201767-1-aesteve@redhat.com>
In-Reply-To: <20230524091333.201767-1-aesteve@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 21 Jun 2023 10:20:25 +0200
Message-ID: <CADSE00KNb4vxsL-JzQMrVgks+EJvt1dj7v9jd3s9gnkzGow6UA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Virtio shared dma-buf
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@gmail.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Fam Zheng <fam@euphon.net>
Content-Type: multipart/alternative; boundary="00000000000036eddc05fe9f71b2"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000036eddc05fe9f71b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

It has been a month since I sent this patch, so I'll give it a bump to get
some attention back.

@mst and @Fam any comments? What would be the next steps to take to move
this forward?

BR,
Albert


On Wed, May 24, 2023 at 11:13=E2=80=AFAM Albert Esteve <aesteve@redhat.com>=
 wrote:

> v1 link ->
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg00598.html
> v2 link ->
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04530.html
> v2 -> v3:
>     - Change UUID hash function strategy to djb
>     - Add qemu_uuid_is_equal wrapper
>
> This patch covers the required steps to add support for virtio
> cross-device resource sharing[1],
> which support is already available in the kernel.
>
> The main usecase will be sharing dma buffers from virtio-gpu devices (as
> the exporter
> -see VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID in [2]), to virtio-video (under
> discussion)
> devices (as the buffer-user or importer). Therefore, even though virtio
> specs talk about
> resources or objects[3], this patch adds the infrastructure with dma-bufs
> in mind.
> Note that virtio specs let the devices themselves define what a vitio
> object is.
>
> These are the main parts that are covered in the patch:
>
> - Add hash_func and key_equal_func to uuid
> - Shared resources table, to hold all resources that can be shared in the
> host and their assigned UUID
> - Internal shared table API for virtio devices to add, lookup and remove
> resources
> - Unit test to verify the API.
> - New message to the vhost-user protocol to allow backend to interact wit=
h
> the shared
>   table API through the control socket
>
> Applies cleanly to 1c12355
>
> [1] - https://lwn.net/Articles/828988/
> [2] -
> https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.ht=
ml#x1-3730006
> [3] -
> https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.ht=
ml#x1-10500011
>
> Albert Esteve (4):
>   uuid: add hash_func and equal_func
>   virtio-dmabuf: introduce virtio-dmabuf
>   vhost-user: add shared_object msg
>   vhost-user: refactor send_resp code
>
>  MAINTAINERS                               |   7 ++
>  docs/interop/vhost-user.rst               |  15 +++
>  hw/display/meson.build                    |   1 +
>  hw/display/virtio-dmabuf.c                |  90 +++++++++++++++++
>  hw/virtio/vhost-user.c                    |  90 ++++++++++++++---
>  include/hw/virtio/virtio-dmabuf.h         |  59 ++++++++++++
>  include/qemu/uuid.h                       |   2 +
>  subprojects/libvhost-user/libvhost-user.c |  88 +++++++++++++++++
>  subprojects/libvhost-user/libvhost-user.h |  56 +++++++++++
>  tests/unit/meson.build                    |   1 +
>  tests/unit/test-uuid.c                    |  27 ++++++
>  tests/unit/test-virtio-dmabuf.c           | 112 ++++++++++++++++++++++
>  util/uuid.c                               |  14 +++
>  13 files changed, 549 insertions(+), 13 deletions(-)
>  create mode 100644 hw/display/virtio-dmabuf.c
>  create mode 100644 include/hw/virtio/virtio-dmabuf.h
>  create mode 100644 tests/unit/test-virtio-dmabuf.c
>
> --
> 2.40.0
>
>

--00000000000036eddc05fe9f71b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature"><div>Hi!</div><div><br></div><div>It has been a mo=
nth since I sent this patch, so I&#39;ll give it a bump to get some attenti=
on back.</div><div><br></div><div>@mst and=C2=A0@Fam any comments? What wou=
ld be the next steps to take to move this forward?<br></div><div><br></div>=
<div>BR,</div><div>Albert</div></div></div><br></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 24, 2023 at 11:1=
3=E2=80=AFAM Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com">aestev=
e@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">v1 link -&gt; <a href=3D"https://lists.gnu.org/archive/html/qem=
u-devel/2023-05/msg00598.html" rel=3D"noreferrer" target=3D"_blank">https:/=
/lists.gnu.org/archive/html/qemu-devel/2023-05/msg00598.html</a><br>
v2 link -&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023=
-05/msg04530.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.o=
rg/archive/html/qemu-devel/2023-05/msg04530.html</a><br>
v2 -&gt; v3:<br>
=C2=A0 =C2=A0 - Change UUID hash function strategy to djb<br>
=C2=A0 =C2=A0 - Add qemu_uuid_is_equal wrapper<br>
<br>
This patch covers the required steps to add support for virtio cross-device=
 resource sharing[1],<br>
which support is already available in the kernel.<br>
<br>
The main usecase will be sharing dma buffers from virtio-gpu devices (as th=
e exporter<br>
-see VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID in [2]), to virtio-video (under di=
scussion)<br>
devices (as the buffer-user or importer). Therefore, even though virtio spe=
cs talk about<br>
resources or objects[3], this patch adds the infrastructure with dma-bufs i=
n mind.<br>
Note that virtio specs let the devices themselves define what a vitio objec=
t is.<br>
<br>
These are the main parts that are covered in the patch:<br>
<br>
- Add hash_func and key_equal_func to uuid<br>
- Shared resources table, to hold all resources that can be shared in the h=
ost and their assigned UUID<br>
- Internal shared table API for virtio devices to add, lookup and remove re=
sources<br>
- Unit test to verify the API.<br>
- New message to the vhost-user protocol to allow backend to interact with =
the shared<br>
=C2=A0 table API through the control socket<br>
<br>
Applies cleanly to 1c12355<br>
<br>
[1] - <a href=3D"https://lwn.net/Articles/828988/" rel=3D"noreferrer" targe=
t=3D"_blank">https://lwn.net/Articles/828988/</a><br>
[2] - <a href=3D"https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virti=
o-v1.2-csd01.html#x1-3730006" rel=3D"noreferrer" target=3D"_blank">https://=
docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-3730=
006</a><br>
[3] - <a href=3D"https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virti=
o-v1.2-csd01.html#x1-10500011" rel=3D"noreferrer" target=3D"_blank">https:/=
/docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-105=
00011</a><br>
<br>
Albert Esteve (4):<br>
=C2=A0 uuid: add hash_func and equal_func<br>
=C2=A0 virtio-dmabuf: introduce virtio-dmabuf<br>
=C2=A0 vhost-user: add shared_object msg<br>
=C2=A0 vhost-user: refactor send_resp code<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 ++<b=
r>
=C2=A0docs/interop/vhost-user.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 15 +++<br>
=C2=A0hw/display/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/display/virtio-dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 90 +++++++++++++++++<br>
=C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 90 ++++++++++++++---<br>
=C2=A0include/hw/virtio/virtio-dmabuf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 59 ++++++++++++<br>
=C2=A0include/qemu/uuid.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0subprojects/libvhost-user/libvhost-user.c |=C2=A0 88 ++++++++++++++++=
+<br>
=C2=A0subprojects/libvhost-user/libvhost-user.h |=C2=A0 56 +++++++++++<br>
=C2=A0tests/unit/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0tests/unit/test-uuid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 27 ++++++<br>
=C2=A0tests/unit/test-virtio-dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 112 ++++++++++++++++++++++<br>
=C2=A0util/uuid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 +++<br>
=C2=A013 files changed, 549 insertions(+), 13 deletions(-)<br>
=C2=A0create mode 100644 hw/display/virtio-dmabuf.c<br>
=C2=A0create mode 100644 include/hw/virtio/virtio-dmabuf.h<br>
=C2=A0create mode 100644 tests/unit/test-virtio-dmabuf.c<br>
<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div>

--00000000000036eddc05fe9f71b2--


