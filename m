Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0E6782945
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:38:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4Aw-0007pv-P4; Mon, 21 Aug 2023 08:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qY4Al-0007mh-66
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qY4Ae-0004Tz-VY
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692621491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=25CBHc2BnhbQi4PmpzRFjE5cp9SAoyDOs65XnYzNEtw=;
 b=G1k9ofgnhCRZ+r6hfLA/InR0uJv/bx/AvJPFy/I8bR/293j/owKI6micY8XgbuoMbZfZqX
 F0YgCVo+FNZyJ2a8eU2Yei3TG3tQrKPSL9gcuTU9eopbQkplPVAusviKAY67t1wCwrVhOm
 8pVePeMDLlTDV1jfOZtGy3wqgnZQSac=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-pOz7Af9XOsG32zIvB-CI6w-1; Mon, 21 Aug 2023 08:38:09 -0400
X-MC-Unique: pOz7Af9XOsG32zIvB-CI6w-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-268099fd4f5so3304941a91.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 05:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692621488; x=1693226288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=25CBHc2BnhbQi4PmpzRFjE5cp9SAoyDOs65XnYzNEtw=;
 b=BAS80AGeY/Ik32EciaMhEivY5OoA0QKleqKnFHuW9udbgxwgWQQh/YxrJKcT9xuhBK
 M/hmCcHr6cDhlfzU2c/AJc4EK7qAJxwb74qbCeCZAuc7IdCthLIWhxL8GFg4Axtl/gry
 pyDm/i7N6l1yXD0EUY5BLnbik6W3+DxVXp6Gu6KMV65dM57fvUzBmL7Gjn4wK1U+27E8
 X32f8oDdEjb8jDZuyUF8PJWyRJjAx4Rc/f9xMH1kJTRjgoF4SkLspFqJ2DGLkJihKzyc
 v/3iSwAW3XpZ3CVWB5l3mWsGu4s0TQRHehj7NSrwWuPxpdKf4WLolDgeQC89EG6ZIFlv
 jjew==
X-Gm-Message-State: AOJu0Yx4Rh6Om1WC1zBvMDTpnFTVTRAdXl18mONq70+ev2b/yFkSZ5Zj
 kzrw7bkMt2lBpE9zZ0Di+OTUK9UoHH5r3kSUpTBVhgBRt3DPvO9relsQ62s+zFxULGrKfQoMWJx
 v4zbaGGsR/yTE06r1QIWy+BeR9ForjpFl91UBFgk=
X-Received: by 2002:a17:90a:bf88:b0:263:5d25:150c with SMTP id
 d8-20020a17090abf8800b002635d25150cmr3616572pjs.29.1692621487800; 
 Mon, 21 Aug 2023 05:38:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgA27ouDBzdrG8bP7dA3mQjPJdI99IKNfp5PjTn+WWqCCxTmd5vCEGqIPFZRibVw16jvwr5yAsQBaXHX35hXA=
X-Received: by 2002:a17:90a:bf88:b0:263:5d25:150c with SMTP id
 d8-20020a17090abf8800b002635d25150cmr3616562pjs.29.1692621487460; Mon, 21 Aug
 2023 05:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230802090824.91688-1-aesteve@redhat.com>
In-Reply-To: <20230802090824.91688-1-aesteve@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 21 Aug 2023 14:37:56 +0200
Message-ID: <CADSE00JRMvQ6Ye445xon0GoCDSsp7oAY_B--rABooabMTraoaQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Virtio shared dma-buf
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, kraxel@redhat.com, cohuck@redhat.com, 
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007fe95f06036e2621"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

--0000000000007fe95f06036e2621
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

A little bump for this patch, sorry for the extra noise.

Regards,
Albert


On Wed, Aug 2, 2023 at 11:08=E2=80=AFAM Albert Esteve <aesteve@redhat.com> =
wrote:

> v1 link ->
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg00598.html
> v2 link ->
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04530.html
> v3 link ->
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg06126.html
> v4 link ->
> https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg05174.html
> v4 -> v5:
> - Allow shared table to hold pointers for vhost devices, in a struct that
> defines the types that the table can store
> - New message VHOST_USER_GET_SHARED_OBJECT to retrieve objects stored in
> vhost backends
> - Minor additions to support the previous items (e.g. new test usecases).
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
> - Add hash function to uuid module
> - Shared resources table, to hold all resources that can be shared in the
> host and their assigned UUID,
>   or pointers to the backend holding the resource
> - Internal shared table API for virtio devices to add, lookup and remove
> resources
> - Unit test to verify the API
> - New messages to the vhost-user protocol to allow backend to interact
> with the shared
>   table API through the control socket
> - New vhost-user feature bit to enable shared objects feature
>
> Applies cleanly to 38a6de80b917b2a822cff0e38d83563ab401c890
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
>   uuid: add a hash function
>   virtio-dmabuf: introduce virtio-dmabuf
>   vhost-user: add shared_object msg
>   vhost-user: refactor send_resp code
>
>  MAINTAINERS                               |   7 +
>  docs/interop/vhost-user.rst               |  57 +++++++
>  hw/display/meson.build                    |   1 +
>  hw/display/virtio-dmabuf.c                | 136 +++++++++++++++++
>  hw/virtio/vhost-user.c                    | 174 ++++++++++++++++++++--
>  include/hw/virtio/vhost-backend.h         |   3 +
>  include/hw/virtio/virtio-dmabuf.h         | 103 +++++++++++++
>  include/qemu/uuid.h                       |   2 +
>  subprojects/libvhost-user/libvhost-user.c | 118 +++++++++++++++
>  subprojects/libvhost-user/libvhost-user.h |  55 ++++++-
>  tests/unit/meson.build                    |   1 +
>  tests/unit/test-uuid.c                    |  27 ++++
>  tests/unit/test-virtio-dmabuf.c           | 137 +++++++++++++++++
>  util/uuid.c                               |  14 ++
>  14 files changed, 821 insertions(+), 14 deletions(-)
>  create mode 100644 hw/display/virtio-dmabuf.c
>  create mode 100644 include/hw/virtio/virtio-dmabuf.h
>  create mode 100644 tests/unit/test-virtio-dmabuf.c
>
> --
> 2.40.0
>
>

--0000000000007fe95f06036e2621
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div class=3D"gmail_signature" data-smartmail=3D"gmai=
l_signature">Hi all,</div></div><div class=3D"gmail_signature" data-smartma=
il=3D"gmail_signature"><br></div><div class=3D"gmail_signature" data-smartm=
ail=3D"gmail_signature">A little bump for this patch, sorry for the extra n=
oise.</div><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature=
"><br></div><div class=3D"gmail_signature" data-smartmail=3D"gmail_signatur=
e">Regards,</div><div class=3D"gmail_signature" data-smartmail=3D"gmail_sig=
nature">Albert</div><br></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Aug 2, 2023 at 11:08=E2=80=AFAM Albert Este=
ve &lt;<a href=3D"mailto:aesteve@redhat.com">aesteve@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">v1 link -&gt=
; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg00598=
.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archive/h=
tml/qemu-devel/2023-05/msg00598.html</a><br>
v2 link -&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023=
-05/msg04530.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.o=
rg/archive/html/qemu-devel/2023-05/msg04530.html</a><br>
v3 link -&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023=
-05/msg06126.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.o=
rg/archive/html/qemu-devel/2023-05/msg06126.html</a><br>
v4 link -&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023=
-06/msg05174.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.o=
rg/archive/html/qemu-devel/2023-06/msg05174.html</a><br>
v4 -&gt; v5:<br>
- Allow shared table to hold pointers for vhost devices, in a struct that d=
efines the types that the table can store<br>
- New message VHOST_USER_GET_SHARED_OBJECT to retrieve objects stored in vh=
ost backends<br>
- Minor additions to support the previous items (e.g. new test usecases).<b=
r>
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
- Add hash function to uuid module<br>
- Shared resources table, to hold all resources that can be shared in the h=
ost and their assigned UUID,<br>
=C2=A0 or pointers to the backend holding the resource<br>
- Internal shared table API for virtio devices to add, lookup and remove re=
sources<br>
- Unit test to verify the API<br>
- New messages to the vhost-user protocol to allow backend to interact with=
 the shared<br>
=C2=A0 table API through the control socket<br>
- New vhost-user feature bit to enable shared objects feature<br>
<br>
Applies cleanly to 38a6de80b917b2a822cff0e38d83563ab401c890<br>
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
=C2=A0 uuid: add a hash function<br>
=C2=A0 virtio-dmabuf: introduce virtio-dmabuf<br>
=C2=A0 vhost-user: add shared_object msg<br>
=C2=A0 vhost-user: refactor send_resp code<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +<br=
>
=C2=A0docs/interop/vhost-user.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 57 +++++++<br>
=C2=A0hw/display/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/display/virtio-dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 136 +++++++++++++++++<br>
=C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 174 ++++++++++++++++++++--<br>
=C2=A0include/hw/virtio/vhost-backend.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A03 +<br>
=C2=A0include/hw/virtio/virtio-dmabuf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
103 +++++++++++++<br>
=C2=A0include/qemu/uuid.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0subprojects/libvhost-user/libvhost-user.c | 118 +++++++++++++++<br>
=C2=A0subprojects/libvhost-user/libvhost-user.h |=C2=A0 55 ++++++-<br>
=C2=A0tests/unit/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0tests/unit/test-uuid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 27 ++++<br>
=C2=A0tests/unit/test-virtio-dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 137 +++++++++++++++++<br>
=C2=A0util/uuid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 ++<br>
=C2=A014 files changed, 821 insertions(+), 14 deletions(-)<br>
=C2=A0create mode 100644 hw/display/virtio-dmabuf.c<br>
=C2=A0create mode 100644 include/hw/virtio/virtio-dmabuf.h<br>
=C2=A0create mode 100644 tests/unit/test-virtio-dmabuf.c<br>
<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div>

--0000000000007fe95f06036e2621--


