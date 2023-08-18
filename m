Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E02780F1A
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:25:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1LU-0006d2-1l; Fri, 18 Aug 2023 11:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qX1LR-0006cR-Ol
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qX1LP-0003La-I8
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692372299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9bQOxePKqyfZsTAk2wZLcyo1tSTpNtEDEySTeiR+xO4=;
 b=KkgU84jF5ka1ivhul8g7WGxpucxoNlHzIcQDmScQ2NNgHGnp4pR1XBTWvUbvtFm8yx6XYO
 7hHwd9SmbN+qpph560St/Ej0e7rxbAXLyzsTPGsOiPS5whiVtvtYxpPw4NUCglHZiYEUt6
 WfZOZj9oayv8x7rT68SE1EJry4VJep8=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-F_1T4hSVNtyXir0BrTvU4w-1; Fri, 18 Aug 2023 11:24:56 -0400
X-MC-Unique: F_1T4hSVNtyXir0BrTvU4w-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-d6b7eb39ef0so1220965276.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692372296; x=1692977096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9bQOxePKqyfZsTAk2wZLcyo1tSTpNtEDEySTeiR+xO4=;
 b=bXNBYJ8RO+N8IzU4zMJKI/WlADvJIrsjZi0r8YMAAso682F+K4KTWIS+Yg2qSjZBSK
 DTCJwSSPJ2WG127WPSmGfBSaNQoZiMgl16GWIsEe/Kt2R+AL08g6Y6AAaztTmrmFFXuR
 mtsDFzHxpkUKbgrmRwspRO2bZO2LP0qBya1KeTQisLLIqx7fGoXzvgo1QV3K2JNg0KIU
 vfs0lhekX7eS01L3C3tko2ec41a9xBndzzWva3rV9+diweG4hAKqG1OiZwqkW269WK4H
 ppPREtRf7V17yvB2LTHdkcpYZMraLmry+6yLW4L5uGciH7BHL4JmRP8x7dS900St/kRa
 Koxw==
X-Gm-Message-State: AOJu0YxNjFjIc0252XMHU81HL92olUuWlTpYfGaCXG0fU0uj6gcI4I15
 MffLF6ROG2WiETc4FcS/vUSfOYFBdPh+x6Tu0/kstkL3Q0wyRZFSTnvlCK0V0EyB/cqNKyc+P2d
 2/AYZxFB1P5wSKJx2F0Y7hgoMEdUei+XJ2OX44mG1vw==
X-Received: by 2002:a25:9783:0:b0:d71:7cb4:8293 with SMTP id
 i3-20020a259783000000b00d717cb48293mr3070323ybo.44.1692372295911; 
 Fri, 18 Aug 2023 08:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWQDRqdeW9U81OwlKoX5olR1dDNVLas4+88eUOmWyfbj2BaJfOPNx0R+oE3n3npEeOEEwzNcEKsunoDzn/k5Q=
X-Received: by 2002:a25:9783:0:b0:d71:7cb4:8293 with SMTP id
 i3-20020a259783000000b00d717cb48293mr3070306ybo.44.1692372295684; Fri, 18 Aug
 2023 08:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689748694.git.yin31149@gmail.com>
 <110db78638438360da7e049343b06ea58af2a195.1689748694.git.yin31149@gmail.com>
In-Reply-To: <110db78638438360da7e049343b06ea58af2a195.1689748694.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 18 Aug 2023 17:24:19 +0200
Message-ID: <CAJaqyWew5LwUcJ_aG7j4-+HAYTyriLS-D1i5Ch2L8-1Xw+6EqQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] vhost: Expose vhost_svq_available_slots()
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 19, 2023 at 9:54=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> Next patches in this series will delay the polling
> and checking of buffers until either the SVQ is
> full or control commands shadow buffers are full,
> no longer perform an immediate poll and check of
> the device's used buffers for each CVQ state load command.
>
> To achieve this, this patch exposes
> vhost_svq_available_slots() and introduces a helper function,
> allowing QEMU to know whether the SVQ is full.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 2 +-
>  hw/virtio/vhost-shadow-virtqueue.h | 1 +
>  net/vhost-vdpa.c                   | 9 +++++++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index e731b1d2ea..fc5f408f77 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -66,7 +66,7 @@ bool vhost_svq_valid_features(uint64_t features, Error =
**errp)
>   *
>   * @svq: The svq
>   */
> -static uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *sv=
q)
> +uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
>  {
>      return svq->num_free;
>  }
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-=
virtqueue.h
> index 5bce67837b..19c842a15b 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -114,6 +114,7 @@ typedef struct VhostShadowVirtqueue {
>
>  bool vhost_svq_valid_features(uint64_t features, Error **errp);
>
> +uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq);
>  void vhost_svq_push_elem(VhostShadowVirtqueue *svq,
>                           const VirtQueueElement *elem, uint32_t len);
>  int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 6b16c8ece0..dd71008e08 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -620,6 +620,13 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState=
 *s,
>      return vhost_svq_poll(svq, 1);
>  }
>
> +/* Convenience wrapper to get number of available SVQ descriptors */
> +static uint16_t vhost_vdpa_net_svq_available_slots(VhostVDPAState *s)
> +{
> +    VhostShadowVirtqueue *svq =3D g_ptr_array_index(s->vhost_vdpa.shadow=
_vqs, 0);
> +    return vhost_svq_available_slots(svq);
> +}
> +
>  static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
>                                         uint8_t cmd, const struct iovec *=
data_sg,
>                                         size_t data_num)
> @@ -640,6 +647,8 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState=
 *s, uint8_t class,
>      };
>
>      assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl))=
;
> +    /* Each CVQ command has one out descriptor and one in descriptor */
> +    assert(vhost_vdpa_net_svq_available_slots(s) >=3D 2);
>
>      /* pack the CVQ command header */
>      memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
> --
> 2.25.1
>


