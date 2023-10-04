Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1525B7B78AA
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 09:24:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwDV-0002wH-Cy; Wed, 04 Oct 2023 03:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qnwDK-0002w1-H5
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qnwDH-00071k-Pm
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696404149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YgeJbFK1oeVXsbeXF1TQfy3/qL6WL+pbp+wPa4xfYRE=;
 b=EZgeO8g0ojHVYgdsIo7icdAPCYeVz+k/BI1+D0ydKeQpj9+JI6Spyl8PbHLQaHD8jwlqjE
 fRd2UcXNC50CO26LaimcHpFP3oBQ8yZJsDd4g/74GanWlqvleUhA05XKPG5V5rf6QQxk7L
 TtOy3RN0NFx2fx0kdRaWnksrofrrOwI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-FqbcwiTUNG-Wo6Tvt9tgNA-1; Wed, 04 Oct 2023 03:22:12 -0400
X-MC-Unique: FqbcwiTUNG-Wo6Tvt9tgNA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-59b59e1ac70so26990087b3.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 00:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696404131; x=1697008931;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgeJbFK1oeVXsbeXF1TQfy3/qL6WL+pbp+wPa4xfYRE=;
 b=eyi6j1WH65953jag4FisrgQuqfmRMDjStit+wJglDC1ZLKJr0ESl85KigNEI4RqLRX
 OkoUBoXRQ+SgENpeJwWelNBvDR4P7Y9WrsMdjMNJb4iPanFThDGHbydoH7V87uaoWRXZ
 9U7BLfcLj4SpPN2rbtXOKseeaQZfMkJFCvu+Ofwqnr3unxxs6eRC1fvQnj90dcM9sFeT
 xQzVZBknqUSmzJvv8l0WbZlfN6PfcxJ4b4QfnhDs/SXH2+M8osYwhe+K2m0K/GFG4N09
 yuBl19XB5EltrEoAm7qGYz3V7GRM6Bl0aqHtkwqAUzV8yD4aCAzk27LutM2suYH6JfdO
 iz7Q==
X-Gm-Message-State: AOJu0Yz7zh75Bs0qY6yU08GbwT7RhEMpywyi/eeEQJ2+r7yJJR2fcupZ
 ER4DLpjmnm2BRngholRHawv9ZxgT+0ILSh9IPjXrs+Ceme1gZPQuE3ItTp0nsMhtmVmZGKnrSI+
 InRrVzaPk9B5Fz9Rf6SWP7YDGkIKYqJo=
X-Received: by 2002:a81:7b0b:0:b0:57a:5c79:482a with SMTP id
 w11-20020a817b0b000000b0057a5c79482amr1493419ywc.50.1696404131633; 
 Wed, 04 Oct 2023 00:22:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFqIKprxN3WAYes5eWzFVZ+pYvVS1lQYtFC2v/eh21jGHDuvirGDXx3mV/L36GhFERy4Ce//VrqaD04ay+PW4=
X-Received: by 2002:a81:7b0b:0:b0:57a:5c79:482a with SMTP id
 w11-20020a817b0b000000b0057a5c79482amr1493399ywc.50.1696404131310; Wed, 04
 Oct 2023 00:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693287885.git.yin31149@gmail.com>
 <0e2af3ed5695a8044877911df791417fe0ba87af.1693287885.git.yin31149@gmail.com>
In-Reply-To: <0e2af3ed5695a8044877911df791417fe0ba87af.1693287885.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 4 Oct 2023 09:21:35 +0200
Message-ID: <CAJaqyWfQq+cKU5+uJvq2iAVDOmLMbKjBHdMiAiJeA2tWFKuu1Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] vdpa: Introduce cursors to vhost_vdpa_net_loadx()
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, 18801353760@163.com
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

On Tue, Aug 29, 2023 at 7:55=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This patch introduces two new arugments, `out_cursor`
> and `in_cursor`, to vhost_vdpa_net_loadx(). Addtionally,
> it includes a helper function
> vhost_vdpa_net_load_cursor_reset() for resetting these
> cursors.
>
> Furthermore, this patch refactors vhost_vdpa_net_load_cmd()
> so that vhost_vdpa_net_load_cmd() prepares buffers
> for the device using the cursors arguments, instead
> of directly accesses `s->cvq_cmd_out_buffer` and
> `s->status` fields.
>
> By making these change, next patches in this series
> can refactor vhost_vdpa_net_load_cmd() directly to
> iterate through the control commands shadow buffers,
> allowing QEMU to send CVQ state load commands in parallel
> at device startup.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
> v4:
>   - use `struct iovec` instead of `void **` as cursor
> suggested by Eugenio
>   - add vhost_vdpa_net_load_cursor_reset() helper function
> to reset the cursors
>   - refactor vhost_vdpa_net_load_cmd() to prepare buffers
> by iov_copy() instead of accessing `in` and `out` directly
> suggested by Eugenio
>
> v3: https://lore.kernel.org/all/bf390934673f2b613359ea9d7ac6c89199c31384.=
1689748694.git.yin31149@gmail.com/
>
>  net/vhost-vdpa.c | 114 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 77 insertions(+), 37 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index d9b8b3cf6c..a71e8c9090 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -633,7 +633,22 @@ static uint16_t vhost_vdpa_net_svq_available_slots(V=
hostVDPAState *s)
>      return vhost_svq_available_slots(svq);
>  }
>
> -static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
> +static void vhost_vdpa_net_load_cursor_reset(VhostVDPAState *s,
> +                                             struct iovec *out_cursor,
> +                                             struct iovec *in_cursor)
> +{
> +    /* reset the cursor of the output buffer for the device */
> +    out_cursor->iov_base =3D s->cvq_cmd_out_buffer;
> +    out_cursor->iov_len =3D vhost_vdpa_net_cvq_cmd_page_len();
> +
> +    /* reset the cursor of the in buffer for the device */
> +    in_cursor->iov_base =3D s->status;
> +    in_cursor->iov_len =3D vhost_vdpa_net_cvq_cmd_page_len();
> +}
> +
> +static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s,
> +                                       struct iovec *out_cursor,
> +                                       struct iovec *in_cursor, uint8_t =
class,
>                                         uint8_t cmd, const struct iovec *=
data_sg,
>                                         size_t data_num)
>  {
> @@ -641,28 +656,25 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPASta=
te *s, uint8_t class,
>          .class =3D class,
>          .cmd =3D cmd,
>      };
> -    size_t data_size =3D iov_size(data_sg, data_num);
> -    /* Buffers for the device */
> -    const struct iovec out =3D {
> -        .iov_base =3D s->cvq_cmd_out_buffer,
> -        .iov_len =3D sizeof(ctrl) + data_size,
> -    };
> -    const struct iovec in =3D {
> -        .iov_base =3D s->status,
> -        .iov_len =3D sizeof(*s->status),
> -    };
> +    size_t data_size =3D iov_size(data_sg, data_num),
> +           cmd_size =3D sizeof(ctrl) + data_size;
> +    struct iovec out, in;
>      ssize_t r;
>
>      assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl))=
;
>      /* Each CVQ command has one out descriptor and one in descriptor */
>      assert(vhost_vdpa_net_svq_available_slots(s) >=3D 2);
>
> -    /* pack the CVQ command header */
> -    memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
> +    /* Prepare the buffer for out descriptor for the device */
> +    iov_copy(&out, 1, out_cursor, 1, 0, cmd_size);

I may be missing something here, but cmd_size should be the bytes
available in "out", so we don't overrun it.

> +    /* Prepare the buffer for in descriptor for the device. */
> +    iov_copy(&in, 1, in_cursor, 1, 0, sizeof(*s->status));
>

Same here, although it is impossible for the moment to overrun it as
all cmds only return one byte.

> +    /* pack the CVQ command header */
> +    iov_from_buf(&out, 1, 0, &ctrl, sizeof(ctrl));
>      /* pack the CVQ command command-specific-data */
>      iov_to_buf(data_sg, data_num, 0,
> -               s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
> +               out.iov_base + sizeof(ctrl), data_size);

Is it possible to replace this by:
iov_to_buf(data_sg, data_num, sizeof(ctrl), out.iov_base, data_size)

In other words, let iov_to_but handle the offset in the buffer instead
of adding it manually.

The rest looks good to me.

>
>      r =3D vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
>      if (unlikely(r < 0)) {
> @@ -676,14 +688,17 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPASta=
te *s, uint8_t class,
>      return vhost_vdpa_net_svq_poll(s, 1);
>  }
>
> -static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n=
)
> +static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n=
,
> +                                   struct iovec *out_cursor,
> +                                   struct iovec *in_cursor)
>  {
>      if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_MAC_AD=
DR)) {
>          const struct iovec data =3D {
>              .iov_base =3D (void *)n->mac,
>              .iov_len =3D sizeof(n->mac),
>          };
> -        ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CT=
RL_MAC,
> +        ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, i=
n_cursor,
> +                                                  VIRTIO_NET_CTRL_MAC,
>                                                    VIRTIO_NET_CTRL_MAC_AD=
DR_SET,
>                                                    &data, 1);
>          if (unlikely(dev_written < 0)) {
> @@ -735,7 +750,7 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s,=
 const VirtIONet *n)
>              .iov_len =3D mul_macs_size,
>          },
>      };
> -    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s,
> +    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cu=
rsor,
>                                  VIRTIO_NET_CTRL_MAC,
>                                  VIRTIO_NET_CTRL_MAC_TABLE_SET,
>                                  data, ARRAY_SIZE(data));
> @@ -750,7 +765,9 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s,=
 const VirtIONet *n)
>  }
>
>  static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
> -                                  const VirtIONet *n)
> +                                  const VirtIONet *n,
> +                                  struct iovec *out_cursor,
> +                                  struct iovec *in_cursor)
>  {
>      struct virtio_net_ctrl_mq mq;
>      ssize_t dev_written;
> @@ -764,7 +781,8 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>          .iov_base =3D &mq,
>          .iov_len =3D sizeof(mq),
>      };
> -    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MQ,
> +    dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
> +                                          VIRTIO_NET_CTRL_MQ,
>                                            VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SE=
T,
>                                            &data, 1);
>      if (unlikely(dev_written < 0)) {
> @@ -778,7 +796,9 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>  }
>
>  static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
> -                                        const VirtIONet *n)
> +                                        const VirtIONet *n,
> +                                        struct iovec *out_cursor,
> +                                        struct iovec *in_cursor)
>  {
>      uint64_t offloads;
>      ssize_t dev_written;
> @@ -809,7 +829,8 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAStat=
e *s,
>          .iov_base =3D &offloads,
>          .iov_len =3D sizeof(offloads),
>      };
> -    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST_OFF=
LOADS,
> +    dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
> +                                          VIRTIO_NET_CTRL_GUEST_OFFLOADS=
,
>                                            VIRTIO_NET_CTRL_GUEST_OFFLOADS=
_SET,
>                                            &data, 1);
>      if (unlikely(dev_written < 0)) {
> @@ -823,6 +844,8 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAStat=
e *s,
>  }
>
>  static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
> +                                       struct iovec *out_cursor,
> +                                       struct iovec *in_cursor,
>                                         uint8_t cmd,
>                                         uint8_t on)
>  {
> @@ -832,7 +855,8 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPAState=
 *s,
>      };
>      ssize_t dev_written;
>
> -    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
> +    dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
> +                                          VIRTIO_NET_CTRL_RX,
>                                            cmd, &data, 1);
>      if (unlikely(dev_written < 0)) {
>          return dev_written;
> @@ -845,7 +869,9 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPAState=
 *s,
>  }
>
>  static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
> -                                  const VirtIONet *n)
> +                                  const VirtIONet *n,
> +                                  struct iovec *out_cursor,
> +                                  struct iovec *in_cursor)
>  {
>      ssize_t r;
>
> @@ -872,7 +898,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>       * configuration only at live migration.
>       */
>      if (!n->mac_table.uni_overflow && !n->promisc) {
> -        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC,=
 0);
> +        r =3D vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
> +                                        VIRTIO_NET_CTRL_RX_PROMISC, 0);
>          if (unlikely(r < 0)) {
>              return r;
>          }
> @@ -896,7 +923,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>       * configuration only at live migration.
>       */
>      if (n->mac_table.multi_overflow || n->allmulti) {
> -        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLMULTI=
, 1);
> +        r =3D vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
> +                                        VIRTIO_NET_CTRL_RX_ALLMULTI, 1);
>          if (unlikely(r < 0)) {
>              return r;
>          }
> @@ -917,7 +945,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>       * configuration only at live migration.
>       */
>      if (n->alluni) {
> -        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLUNI, =
1);
> +        r =3D vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
> +                                        VIRTIO_NET_CTRL_RX_ALLUNI, 1);
>          if (r < 0) {
>              return r;
>          }
> @@ -934,7 +963,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>       * configuration only at live migration.
>       */
>      if (n->nomulti) {
> -        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOMULTI,=
 1);
> +        r =3D vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
> +                                        VIRTIO_NET_CTRL_RX_NOMULTI, 1);
>          if (r < 0) {
>              return r;
>          }
> @@ -951,7 +981,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>       * configuration only at live migration.
>       */
>      if (n->nouni) {
> -        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOUNI, 1=
);
> +        r =3D vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
> +                                        VIRTIO_NET_CTRL_RX_NOUNI, 1);
>          if (r < 0) {
>              return r;
>          }
> @@ -968,7 +999,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>       * configuration only at live migration.
>       */
>      if (n->nobcast) {
> -        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOBCAST,=
 1);
> +        r =3D vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
> +                                        VIRTIO_NET_CTRL_RX_NOBCAST, 1);
>          if (r < 0) {
>              return r;
>          }
> @@ -979,13 +1011,16 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *=
s,
>
>  static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
>                                             const VirtIONet *n,
> +                                           struct iovec *out_cursor,
> +                                           struct iovec *in_cursor,
>                                             uint16_t vid)
>  {
>      const struct iovec data =3D {
>          .iov_base =3D &vid,
>          .iov_len =3D sizeof(vid),
>      };
> -    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_V=
LAN,
> +    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cu=
rsor,
> +                                                  VIRTIO_NET_CTRL_VLAN,
>                                                    VIRTIO_NET_CTRL_VLAN_A=
DD,
>                                                    &data, 1);
>      if (unlikely(dev_written < 0)) {
> @@ -999,7 +1034,9 @@ static int vhost_vdpa_net_load_single_vlan(VhostVDPA=
State *s,
>  }
>
>  static int vhost_vdpa_net_load_vlan(VhostVDPAState *s,
> -                                    const VirtIONet *n)
> +                                    const VirtIONet *n,
> +                                    struct iovec *out_cursor,
> +                                    struct iovec *in_cursor)
>  {
>      int r;
>
> @@ -1010,7 +1047,8 @@ static int vhost_vdpa_net_load_vlan(VhostVDPAState =
*s,
>      for (int i =3D 0; i < MAX_VLAN >> 5; i++) {
>          for (int j =3D 0; n->vlans[i] && j <=3D 0x1f; j++) {
>              if (n->vlans[i] & (1U << j)) {
> -                r =3D vhost_vdpa_net_load_single_vlan(s, n, (i << 5) + j=
);
> +                r =3D vhost_vdpa_net_load_single_vlan(s, n, out_cursor,
> +                                                    in_cursor, (i << 5) =
+ j);
>                  if (unlikely(r !=3D 0)) {
>                      return r;
>                  }
> @@ -1027,6 +1065,7 @@ static int vhost_vdpa_net_load(NetClientState *nc)
>      struct vhost_vdpa *v =3D &s->vhost_vdpa;
>      const VirtIONet *n;
>      int r;
> +    struct iovec out_cursor, in_cursor;
>
>      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
>
> @@ -1035,23 +1074,24 @@ static int vhost_vdpa_net_load(NetClientState *nc=
)
>      }
>
>      n =3D VIRTIO_NET(v->dev->vdev);
> -    r =3D vhost_vdpa_net_load_mac(s, n);
> +    vhost_vdpa_net_load_cursor_reset(s, &out_cursor, &in_cursor);
> +    r =3D vhost_vdpa_net_load_mac(s, n, &out_cursor, &in_cursor);
>      if (unlikely(r < 0)) {
>          return r;
>      }
> -    r =3D vhost_vdpa_net_load_mq(s, n);
> +    r =3D vhost_vdpa_net_load_mq(s, n, &out_cursor, &in_cursor);
>      if (unlikely(r)) {
>          return r;
>      }
> -    r =3D vhost_vdpa_net_load_offloads(s, n);
> +    r =3D vhost_vdpa_net_load_offloads(s, n, &out_cursor, &in_cursor);
>      if (unlikely(r)) {
>          return r;
>      }
> -    r =3D vhost_vdpa_net_load_rx(s, n);
> +    r =3D vhost_vdpa_net_load_rx(s, n, &out_cursor, &in_cursor);
>      if (unlikely(r)) {
>          return r;
>      }
> -    r =3D vhost_vdpa_net_load_vlan(s, n);
> +    r =3D vhost_vdpa_net_load_vlan(s, n, &out_cursor, &in_cursor);
>      if (unlikely(r)) {
>          return r;
>      }
> --
> 2.25.1
>


