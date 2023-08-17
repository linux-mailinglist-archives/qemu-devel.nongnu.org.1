Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8272877F857
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 16:07:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWddr-0004AU-6J; Thu, 17 Aug 2023 10:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qWddk-0004AG-Vr
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qWddi-0005Jk-4M
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692281176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o/ev/PwjhReflw6DqrX5sEngf+8jtyAVcwA7Kum2GQg=;
 b=ZBOuJhCq5ymaJfTpO+2HLsqtE1I9o7NB9xo9jrjAikR560Ehw1v4cOFNeVVFCWCy0F/eG0
 rHsooYtQaxu2HLV056grcMf+IB0B9V9XSeoowOC7UXdBG/3aRpOX1nNxQE1X+Js2aSAMxR
 4FjSAlJTL+D+NnxPTmmQGCygivdPLy4=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-dR8SLPqqOESsrHFelLUJfA-1; Thu, 17 Aug 2023 10:06:14 -0400
X-MC-Unique: dR8SLPqqOESsrHFelLUJfA-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-c647150c254so1934654276.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 07:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692281174; x=1692885974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o/ev/PwjhReflw6DqrX5sEngf+8jtyAVcwA7Kum2GQg=;
 b=KY9m/fcWs+HS+//Aek1aTMAfQbj0OzUtBeHS1AYw3FGynH9nxvJi0NQjyxxdTh7Hym
 B5ohiW5KodqZzskkSbB4SaiNPVHat+AH57HOBK0WSqCILTR2U6rt1u9raNgVBtDSBvjv
 XrLn9ufI/S9rSgCVHIGZ21sya7Qt3rA1QkMN58QMjf18u5nvANQiTsGbsJOazxcg2V9J
 RHCNfB56JENacOLUeNExWLu6r3HYgj9Mn/DtUs+uLi1sIFj8aaf+K6eCr/J1pyPXBlE+
 9llMYaLEIBDj8Lflnx6ofVZLAuHwsuszPoUlnSOhaHIfAK2NQ3UnYZO2/coNoYRZH4bq
 zIog==
X-Gm-Message-State: AOJu0Yw5YN7cLz2KeXB0Ul496RDQq+5/neKSvgpXg9UV4S3F6OZAcEne
 Y+VJRrmAArQR3ZFjUoz0bmgdFh3sfV+0dqZhP4C+T2xBMcUWmP14LjA2ymoCRv79Iw44GlWMW6s
 N+bt3QPPKYdJzsCX/f6fDtmoVCnrBx14=
X-Received: by 2002:a25:ac4a:0:b0:d71:f3bf:d5f with SMTP id
 r10-20020a25ac4a000000b00d71f3bf0d5fmr3498563ybd.5.1692281174224; 
 Thu, 17 Aug 2023 07:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjEcGeWiPNuGvKqilgBEZVV47RRMI+lcBpNNioFxIfwNHCkhRL8kwZH1d8lHSUAXSnbpgluBaAoy9D+Po3HFk=
X-Received: by 2002:a25:ac4a:0:b0:d71:f3bf:d5f with SMTP id
 r10-20020a25ac4a000000b00d71f3bf0d5fmr3498522ybd.5.1692281173858; Thu, 17 Aug
 2023 07:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688743107.git.yin31149@gmail.com>
 <3482cc50eebd13db4140b8b5dec9d0cc25b20b1b.1688743107.git.yin31149@gmail.com>
 <CAJaqyWeZxv6Lf8QEAmw_Ge_BGbPJdDvsGNnze4uavqXhPZQChQ@mail.gmail.com>
 <CAKrof1OwTCbcfTxQ=6B2-iyH2E0Wxt-f+CtkkdBWtiZOPvRNLw@mail.gmail.com>
In-Reply-To: <CAKrof1OwTCbcfTxQ=6B2-iyH2E0Wxt-f+CtkkdBWtiZOPvRNLw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 17 Aug 2023 16:05:37 +0200
Message-ID: <CAJaqyWcSwPV=AKX+HN19-GOyFRyZtWLraPmn8MyJJVG+UmQ1MA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] vdpa: Use iovec for vhost_vdpa_net_load_cmd()
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
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
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

On Thu, Aug 17, 2023 at 2:42=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> On 2023/8/17 17:23, Eugenio Perez Martin wrote:
> > On Fri, Jul 7, 2023 at 5:27=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.c=
om> wrote:
> >>
> >> According to VirtIO standard, "The driver MUST follow
> >> the VIRTIO_NET_CTRL_MAC_TABLE_SET command by a le32 number,
> >> followed by that number of non-multicast MAC addresses,
> >> followed by another le32 number, followed by that number
> >> of multicast addresses."
> >>
> >> Considering that these data is not stored in contiguous memory,
> >> this patch refactors vhost_vdpa_net_load_cmd() to accept
> >> scattered data, eliminating the need for an addtional data copy or
> >> packing the data into s->cvq_cmd_out_buffer outside of
> >> vhost_vdpa_net_load_cmd().
> >>
> >> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> >> ---
> >> v3:
> >>    - rename argument name to `data_sg` and `data_num`
> >>    - use iov_to_buf() suggested by Eugenio
> >>
> >> v2: https://lore.kernel.org/all/6d3dc0fc076564a03501e222ef1102a6a7a643=
af.1688051252.git.yin31149@gmail.com/
> >>    - refactor vhost_vdpa_load_cmd() to accept iovec suggested by
> >> Eugenio
> >>
> >>   net/vhost-vdpa.c | 33 +++++++++++++++++++++++++--------
> >>   1 file changed, 25 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> >> index 373609216f..31ef6ad6ec 100644
> >> --- a/net/vhost-vdpa.c
> >> +++ b/net/vhost-vdpa.c
> >> @@ -620,29 +620,38 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAS=
tate *s, size_t out_len,
> >>   }
> >>
> >>   static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t cl=
ass,
> >> -                                       uint8_t cmd, const void *data,
> >> -                                       size_t data_size)
> >> +                                       uint8_t cmd, const struct iove=
c *data_sg,
> >> +                                       size_t data_num)
> >>   {
> >>       const struct virtio_net_ctrl_hdr ctrl =3D {
> >>           .class =3D class,
> >>           .cmd =3D cmd,
> >>       };
> >> +    size_t data_size =3D iov_size(data_sg, data_num);
> >>
> >>       assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ct=
rl));
> >>
> >> +    /* pack the CVQ command header */
> >>       memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
> >> -    memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_size);
> >>
> >> -    return vhost_vdpa_net_cvq_add(s, sizeof(ctrl) + data_size,
> >> +    /* pack the CVQ command command-specific-data */
> >> +    iov_to_buf(data_sg, data_num, 0,
> >> +               s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
> >> +
> >> +    return vhost_vdpa_net_cvq_add(s, data_size + sizeof(ctrl),
> >
> > Nit, any reason for changing the order of the addends? sizeof(ctrl) +
> > data_size ?
>
> Hi Eugenio,
>
> Here the code should be changed to `sizeof(ctrl) + data_size` as you
> point out.
>
> Since this patch series has already been merged into master, I will
> submit a separate patch to correct this problem.
>

Ouch, I didn't realize that. No need to make it back again, I was just
trying to reduce lines changed.

> >
> >>                                     sizeof(virtio_net_ctrl_ack));
> >>   }
> >>
> >>   static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONe=
t *n)
> >>   {
> >>       if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_MA=
C_ADDR)) {
> >> +        const struct iovec data =3D {
> >> +            .iov_base =3D (void *)n->mac,
> >
> > Assign to void should always be valid, no need for casting here.
>
> Yes, assign to void should be valid for normal pointers.
>
> However, `n->mac` is an array and is treated as a const pointer. It will
> trigger the warning "error: initialization discards =E2=80=98const=E2=80=
=99 qualifier
> from pointer target type" if we don't add this cast.
>

Got it, I didn't realize it. Everything is ok then.

Thanks!

> Thanks!
>
>
> >
> >> +            .iov_len =3D sizeof(n->mac),
> >> +        };
> >>           ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NE=
T_CTRL_MAC,
> >>                                                     VIRTIO_NET_CTRL_MA=
C_ADDR_SET,
> >> -                                                  n->mac, sizeof(n->m=
ac));
> >> +                                                  &data, 1);
> >>           if (unlikely(dev_written < 0)) {
> >>               return dev_written;
> >>           }
> >> @@ -665,9 +674,13 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState =
*s,
> >>       }
> >>
> >>       mq.virtqueue_pairs =3D cpu_to_le16(n->curr_queue_pairs);
> >> +    const struct iovec data =3D {
> >> +        .iov_base =3D &mq,
> >> +        .iov_len =3D sizeof(mq),
> >> +    };
> >>       dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MQ,
> >> -                                          VIRTIO_NET_CTRL_MQ_VQ_PAIRS=
_SET, &mq,
> >> -                                          sizeof(mq));
> >> +                                          VIRTIO_NET_CTRL_MQ_VQ_PAIRS=
_SET,
> >> +                                          &data, 1);
> >>       if (unlikely(dev_written < 0)) {
> >>           return dev_written;
> >>       }
> >> @@ -706,9 +719,13 @@ static int vhost_vdpa_net_load_offloads(VhostVDPA=
State *s,
> >>       }
> >>
> >>       offloads =3D cpu_to_le64(n->curr_guest_offloads);
> >> +    const struct iovec data =3D {
> >> +        .iov_base =3D &offloads,
> >> +        .iov_len =3D sizeof(offloads),
> >> +    };
> >>       dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST=
_OFFLOADS,
> >>                                             VIRTIO_NET_CTRL_GUEST_OFFL=
OADS_SET,
> >> -                                          &offloads, sizeof(offloads)=
);
> >> +                                          &data, 1);
> >>       if (unlikely(dev_written < 0)) {
> >>           return dev_written;
> >>       }
> >
> > Apart from that:
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > Thanks!
> >
>


