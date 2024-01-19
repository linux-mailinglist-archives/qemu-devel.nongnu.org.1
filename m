Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5948B8327A6
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 11:28:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQm5o-0006Uc-U1; Fri, 19 Jan 2024 05:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rQm5l-0006UC-Hj
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 05:27:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rQm5i-0004en-V8
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 05:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705660029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGModt5VnP84Ku4gAp6JzfVTT/lRgMcN1yiZhC5kbXw=;
 b=R6SbF5/0jUDgQeEmubRgQqyJ2pwYT9ToDjYCZGXF4NjJCCuAWU9BUl3jzE43pYP6Ux00It
 jcdl3izNHBlJJagXOBZ1vXuvTRpP0d+D/M5jJx/4nDlR+Agm/seBRZU2EX92pjnwpHQiK7
 suoBqOEAnByP6PgQER36CU7DF4G+0rw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-1ZgE3D_pOzSvcjh4mJzWQA-1; Fri, 19 Jan 2024 05:27:06 -0500
X-MC-Unique: 1ZgE3D_pOzSvcjh4mJzWQA-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dc21b7f41a1so944110276.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 02:27:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705660025; x=1706264825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mGModt5VnP84Ku4gAp6JzfVTT/lRgMcN1yiZhC5kbXw=;
 b=b25gEQVaqjRyT/nNNh7+zJogyO0iD+l6kbtBjonyWl3vDQFSBGAvfYillfJBVEK+G4
 tJfZswQ5l/Guvz/pAWVVlbQELOov1UYHevlqrg4xVVFoi6ZJYBCsn/NofDF8EaP1Px1Y
 YjC+qILxGH25Y0SgAdnoMoYuqZc3UP31rfSAyLNm41T/Ha05hhLyKeWdKEQfDkW2xPrz
 ZBSKANWRIUuggo1nIe/zoZ7417zP+btgl+zjBBuZEtv/zDF1Z/eNryh/2NEQhwFjexdc
 8UfvWf87/1S4aWNMZ4tE6Cq2kqyIKwkj/5tNuKHft/j8aK/TC33HDXhjkc+L8mVq+M8f
 pWbw==
X-Gm-Message-State: AOJu0Yx6HX/AWrPKc7M2eAwqfpSJGezbmolLk3lxO3zkVyXJbibXRIH6
 JXS19S8ujXGjzeZ/1RXcAsXvNCVuD02lExhQm/kfy09/ynNnZYfuqMcpWXKVRmNa+T6LzyMG+44
 /C5WYPKIZ7HxjO/p1CYUSpxibMOiV1nQWCM1wHY2uAI/6CSLl6HezI8sY1OIsJTtylcbJJr7OBU
 egeGAozpMo66IEi19qwPjDq5dLcS8=
X-Received: by 2002:a25:b289:0:b0:dc2:2ae7:8899 with SMTP id
 k9-20020a25b289000000b00dc22ae78899mr1879813ybj.10.1705660025564; 
 Fri, 19 Jan 2024 02:27:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuMT5sMNw+4a4VYMyhLhwMeTXW3JIL5me3MrkORm9Gr84+0TkvegUV6QiEQ9BNaI7e9Cjl+Tf4shNfyl/ju50=
X-Received: by 2002:a25:b289:0:b0:dc2:2ae7:8899 with SMTP id
 k9-20020a25b289000000b00dc22ae78899mr1879805ybj.10.1705660025255; Fri, 19 Jan
 2024 02:27:05 -0800 (PST)
MIME-Version: 1.0
References: <SN4PR13MB5727A538887598415C5A37D28681A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB5727D7B4E7CC91345135A5058661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEvwanHfheCMo-gDjzx1DrX51AMtoaYJ9PcE0yYmZdA+Uw@mail.gmail.com>
 <SN4PR13MB5727A90B141E383127F1E25D8661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB572773EF8D25A2E2C5AE48608661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB57274870E6BBFC76749E8D96866F2@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEu6X2L-eawwsy_pE1mVVDU7V=Qe_51YrK16W-kKu4BGxA@mail.gmail.com>
 <SN4PR13MB572738F10FAE449DDBD735D686732@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEtHQHmhBAF6WguUSHr+iFMmOjvTshqpGzkvE=QtkgVVPA@mail.gmail.com>
 <SN4PR13MB5727AF7CB6E6CF563B618F1386732@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB5727D5A7AD34F7169E2A236F86702@SN4PR13MB5727.namprd13.prod.outlook.com>
In-Reply-To: <SN4PR13MB5727D5A7AD34F7169E2A236F86702@SN4PR13MB5727.namprd13.prod.outlook.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 19 Jan 2024 11:26:29 +0100
Message-ID: <CAJaqyWc2P6iHrG9dR2X9YC=P7dw4=Y2RwRkr5H81hkj6ej_5hA@mail.gmail.com>
Subject: Re: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
 VIRTIO_F_NOTIFICATION_DATA feature
To: Wentao Jia <wentao.jia@nephogine.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, 
 Rick Zhong <zhaoyong.zhong@nephogine.com>, Jason Wang <jasowang@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Guo Zhi <qtxuning1999@sjtu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jan 19, 2024 at 7:42=E2=80=AFAM Wentao Jia <wentao.jia@nephogine.co=
m> wrote:
>
>
> VIRTIO_F_IN_ORDER and VIRTIO_F_NOTIFICATION_DATA feature are important fe=
ature
> for dpdk vdpa packets transmitting performance, add the 2 features at vho=
st-user
> front-end to negotiation with backend.
>
> Signed-off-by: Kyle Xu <zhenbing.xu@corigine.com>
> Signed-off-by: Wentao Jia <wentao.jia@corigine.com>
> Reviewed-by:   Xinying Yu <xinying.yu@corigine.com>
> Reviewed-by:   Shujing Dong <shujing.dong@corigine.com>
> Reviewed-by:   Rick Zhong <zhaoyong.zhong@corigine.com>
> ---
>  hw/core/machine.c   | 2 ++
>  hw/net/vhost_net.c  | 2 ++
>  hw/net/virtio-net.c | 4 ++++
>  3 files changed, 8 insertions(+)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index fb5afdcae4..e620f5e7d0 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -40,6 +40,7 @@ GlobalProperty hw_compat_8_1[] =3D {
>      { "ramfb", "x-migrate", "off" },
>      { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
>      { "igb", "x-pcie-flr-init", "off" },
> +    { TYPE_VIRTIO_NET, "notification_data", "off"},
>  };

Assuming the default "true" in
hw/net/virtio-net.c:virtio_net_properties is valid, this needs to be
appended to the array of the QEMU version that introduced the property
in the virtio_net_properties array, not the one that imported the
macro from the kernel. This allows QEMU to know that old versions have
these features disabled although the default set in
hw/net/virtio-net.c:virtio_net_properties is true when migrating from
/ to these versions.

You can check that this is added properly by migrating from / to a
previous version of QEMU, with the combinations of true and false.

You have an example in [1] with blk devices multiqueue. CCing Peter Xu
as he knows more than me about this.

This is very easy to miss when adding new features. Somebody who knows
perl should add a test in checkpath.pl similar to the warning "added,
moved or deleted file(s), does MAINTAINERS need updating?" when virtio
properties are modified :).

>  const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
>
> @@ -65,6 +66,7 @@ GlobalProperty hw_compat_7_1[] =3D {
>      { "virtio-rng-pci", "vectors", "0" },
>      { "virtio-rng-pci-transitional", "vectors", "0" },
>      { "virtio-rng-pci-non-transitional", "vectors", "0" },
> +    { TYPE_VIRTIO_NET, "in_order", "off"},
>  };
>  const size_t hw_compat_7_1_len =3D G_N_ELEMENTS(hw_compat_7_1);
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index e8e1661646..211ca859a6 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -76,6 +76,8 @@ static const int user_feature_bits[] =3D {
>      VIRTIO_F_IOMMU_PLATFORM,
>      VIRTIO_F_RING_PACKED,
>      VIRTIO_F_RING_RESET,
> +    VIRTIO_F_IN_ORDER,
> +    VIRTIO_F_NOTIFICATION_DATA,
>      VIRTIO_NET_F_RSS,
>      VIRTIO_NET_F_HASH_REPORT,
>      VIRTIO_NET_F_GUEST_USO4,
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7a2846fa1c..dc0a028934 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3949,6 +3949,10 @@ static Property virtio_net_properties[] =3D {
>                        VIRTIO_NET_F_GUEST_USO6, true),
>      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
>                        VIRTIO_NET_F_HOST_USO, true),
> +    DEFINE_PROP_BIT64("in_order", VirtIONet, host_features,
> +                      VIRTIO_F_IN_ORDER, true),
> +    DEFINE_PROP_BIT64("notification_data", VirtIONet, host_features,
> +                      VIRTIO_F_NOTIFICATION_DATA, true),

This default=3Dtrue is wrong, and makes emulated devices show these
features as available when they're not. You can test it by running
qemu with the parameters:

-netdev tap,id=3Dhostnet0,vhost=3Doff -device virtio-net-pci,netdev=3Dhostn=
et0,...

The emulated device must support both features before making them tunnables=
.

On the other hand, all kinds of virtio devices can use in_order and
notification_data, so they should be in
include/hw/virtio/virtio.h:DEFINE_VIRTIO_COMMON_FEATURES. But not all
of them benefit from in_order. One example of this is virtio-blk. It
is usual that requests are completed out of order by the backend
device, so my impression is that in_order will hurt its performance.
I've never profiled it though, so I may be wrong :).

Long story short: Maybe in_order should be false by default, and
enabled just in virtio-net?

You can see previous attempts of implementing this feature in qemu in
[2]. CCing Guo too, as I don't know if he plans to continue this work
soon.

Please let me know if you need any help with these!

Thanks!

[1] https://www.qemu.org/docs/master/devel/migration/compatibility.html#how=
-backwards-compatibility-works
[2] https://lists.gnu.org/archive/html/qemu-devel/2022-08/msg02772.html

>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> --
>


