Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB0D73DADB
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:10:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDiDO-0001BH-2s; Mon, 26 Jun 2023 05:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qDiDL-0001B0-IP
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:08:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qDiDJ-0005GX-HT
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687770527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RsxQ4D4DcTH9QwJ2OVq+X5IO62aMvQbcs5Mam6rbB1g=;
 b=YE3+YwDFYWrkyJquiD9qDaOr3Jq6317KJ9RBlAbpK+4YxKvSu99nncOIZGc899z4vUr5V2
 l8sm4DlfiqT6BkQXu5D/wqe5wo2jzEjvtQBPf49mX766RYZK080SF1CqYbGSVbdFyUpT7D
 DJBMFW9b30Z3h0uWgbyKbarIsx36a4Y=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-beR1qoEZMluHEDirwByLuA-1; Mon, 26 Jun 2023 05:08:46 -0400
X-MC-Unique: beR1qoEZMluHEDirwByLuA-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-c17812e30b4so2259944276.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 02:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687770526; x=1690362526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RsxQ4D4DcTH9QwJ2OVq+X5IO62aMvQbcs5Mam6rbB1g=;
 b=fZ1jE8dkER3PGSl+geCy9pN/qiEKb31cj3c4elgxvtS1gqQE2xb1oI379j7ygpPOLj
 EnvFEHd+RQUTgnXwxxtJDZqsnnN2fit2Dqt+uN39XM5M32rW+StvMswXhQA1aaexp5d4
 IaOB09T1sfUqOKzNN9KPT+BfhhUae3N7CONtqILKQEKgO2m26ju7qHFWn4HTKUnVfk3w
 WCsBWP+3vJxdp0Z6tZdfvANEpj3tD0cB4CXgWfIaf0Nqms2zQjCCg8Do5BcI+gCIoPZB
 P3MgBFnjDfozSerzZp/Hl0IvYX0I62E7rdZc/QPWGc/uolxWW3TqMBXtNt3lFgsu0FjJ
 7nBQ==
X-Gm-Message-State: AC+VfDzo6dWVuuAH5SKyvTLSqTAxTB+YGVNpoyDSDjpPqjo8YSv5+Nza
 PTuWYpMlNWbMAZ6utZpb4SVgYJX5onSFXwHWPFHVGyipZfzAMZl67itU9TLXUZ4qHLbLY3bZG+R
 FaQQrc/Daj8Axp07jwYWB6JVTgkLBrnM=
X-Received: by 2002:a25:b10a:0:b0:c28:bcc1:483c with SMTP id
 g10-20020a25b10a000000b00c28bcc1483cmr510043ybj.37.1687770525964; 
 Mon, 26 Jun 2023 02:08:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZoEPq5qVtxDH2nLOYA+M9msMeBgyjmponRxkqRS93DYct62LNRFazIKflPaxM3HW+t2RXgC+l7XKSeNIy7QI=
X-Received: by 2002:a25:b10a:0:b0:c28:bcc1:483c with SMTP id
 g10-20020a25b10a000000b00c28bcc1483cmr510032ybj.37.1687770525714; Mon, 26 Jun
 2023 02:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230622010651.22698-1-yin31149@gmail.com>
 <CAJaqyWfr6XTz7qhMfYR7kJW_A409N7x6hcYQd2ypUD_p6kyc_g@mail.gmail.com>
 <CAKrof1O12p=7zf5jzJca0mtcyoYJHiR-5ubYLD1Q0aszWaKhoQ@mail.gmail.com>
In-Reply-To: <CAKrof1O12p=7zf5jzJca0mtcyoYJHiR-5ubYLD1Q0aszWaKhoQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 26 Jun 2023 11:08:09 +0200
Message-ID: <CAJaqyWeRy5c6KngJBSXO6cisvQzoqXgTGJ3BDneS2zVT6PpvJg@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Increase out buffer size for CVQ commands
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jun 26, 2023 at 10:26=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com=
> wrote:
>
> On 2023/6/25 18:48, Eugenio Perez Martin wrote:
> > On Thu, Jun 22, 2023 at 3:07=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.=
com> wrote:
> >>
> >> According to the VirtIO standard, "Since there are no guarantees,
> >> it can use a hash filter or silently switch to
> >> allmulti or promiscuous mode if it is given too many addresses."
> >> To achive this, QEMU ignores MAC addresses and marks `mac_table.x_over=
flow`
> >> in the device internal state in virtio_net_handle_mac()
> >> if the guest sets more than `MAC_TABLE_ENTRIES` MAC addresses
> >> for the filter table.
> >>
> >> However, the problem is that QEMU never marks the `mac_table.x_overflo=
w`
> >> for the vdpa device internal state when the guest sets more than
> >> `MAC_TABLE_ENTRIES` MAC addresses.
> >>
> >> To be more specific, currently QEMU offers a buffer size of
> >> vhost_vdpa_net_cvq_cmd_len() for CVQ commands, which represents the si=
ze of
> >> VIRTIO_NET_CTRL_MAC_TABLE_SET command with a maximum `MAC_TABLE_ENTRIE=
S`
> >> MAC addresses.
> >>
> >> Consequently, if the guest sets more than `MAC_TABLE_ENTRIES` MAC addr=
esses,
> >> QEMU truncates the CVQ command data and copies this incomplete command
> >> into the out buffer. In this situation, virtio_net_handle_mac() fails =
the
> >> integrity check and returns VIRTIO_NET_ERR instead of marking
> >> `mac_table.x_overflow` and returning VIRTIO_NET_OK, since the copied
> >> CVQ command in the buffer is incomplete and flawed.
> >>
> >> This patch solves this problem by increasing the buffer size to
> >> vhost_vdpa_net_cvq_cmd_page_len(), which represents the size of the bu=
ffer
> >> that is allocated and mmaped. Therefore, everything should work correc=
tly
> >> as long as the guest sets fewer than `(vhost_vdpa_net_cvq_cmd_page_len=
() -
> >> sizeof(struct virtio_net_ctrl_hdr)
> >> - 2 * sizeof(struct virtio_net_ctrl_mac)) / ETH_ALEN` MAC addresses.
> >>
> >> Considering the highly unlikely scenario for the guest setting more th=
an
> >> that number of MAC addresses for the filter table, this patch should
> >> work fine for the majority of cases. If there is a need for more than =
thoes
> >> entries, we can increase the value for vhost_vdpa_net_cvq_cmd_page_len=
()
> >> in the future, mapping more than one page for command output.
> >>
> >> Fixes: 7a7f87e94c ("vdpa: Move command buffers map to start of net dev=
ice")
> >> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> >> ---
> >>   net/vhost-vdpa.c | 11 ++++++++++-
> >>   1 file changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> >> index 5a72204899..ecfa8852b5 100644
> >> --- a/net/vhost-vdpa.c
> >> +++ b/net/vhost-vdpa.c
> >> @@ -784,9 +784,18 @@ static int vhost_vdpa_net_handle_ctrl_avail(Vhost=
ShadowVirtqueue *svq,
> >>       };
> >>       ssize_t dev_written =3D -EINVAL;
> >>
> >> +    /*
> >> +     * This code truncates the VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ comm=
and
> >> +     * and prevents QEMU from marking `mac_table.x_overflow` in the d=
evice
> >> +     * internal state in virtio_net_handle_mac() if the guest sets mo=
re than
> >> +     * `(vhost_vdpa_net_cvq_cmd_page_len() - sizeof(struct virtio_net=
_ctrl_hdr)
> >> +     * - 2 * sizeof(struct virtio_net_ctrl_mac)) / ETH_ALEN` MAC addr=
esses for
> >> +     * filter table.
> >> +     * However, this situation is considered rare, so it is acceptabl=
e.
> >
> > I think we can also fix this situation. If it fits in one page, we can
> > still send the same page to the device and virtio_net_handle_ctrl_iov.
> > If it does not fit in one page, we can clear all mac filters with
> > VIRTIO_NET_CTRL_RX_ALLUNI and / or VIRTIO_NET_CTRL_RX_ALLMULTI.
>
> Hi Eugenio,
>
> Thank you for your review.
>
> However, it appears that the approach may not resolve the situation.
>
> When the CVQ command exceeds one page,
> vhost_vdpa_net_handle_ctrl_avail() truncates the command, resulting in a
> malformed SVQ command being received by the hardware, which in turn
> triggers an error acknowledgement to QEMU.
>

If that happens we can sanitize the copied cmd buffer. Let's start
with an overflowed unicast table first.

To configure the device we need to transform the command to
VIRTIO_NET_CTRL_RX_ALLUNI, as we cannot copy all the table to the out
cmd page. If that succeeds, we can continue to register that in the
VirtIONet struct.

 We can copy the first MAC_TABLE_ENTRIES + 1 entries and set entries =3D
(MAC_TABLE_ENTRIES + 1), and then use that buffer to call
virtio_net_handle_ctrl_iov. That sets VirtIONet.uni_overflow =3D true
and VirtIONet.all_uni =3D false.

We need to handle the multicast addresses in a similar way, but we can
find cases where only multicast addresses overflow.

In future series we can improve the situation:
* Allocating bigger out buffers so more mac addresses fit in it.
* Mapping also guest pages in CVQ, so the real device is able to read
the full table but VirtIONet only stores the first MAC_TABLE_ENTRIES
or .uni_overflow =3D 1.

But I think it should be enough at this point.

Thanks!

> So if CVQ command exceeds one page, vhost_vdpa_net_handle_ctrl_avail()
> should not update the device internal state because the SVQ command
> fails.(Please correct me if I am wrong)
>
> It appears that my commit message and comments did not take this into
> account. I will refactor them in the v2 patch..
>
> Thanks!
>
>
> >
> > Thanks!
> >
> >> +     */
> >>       out.iov_len =3D iov_to_buf(elem->out_sg, elem->out_num, 0,
> >>                                s->cvq_cmd_out_buffer,
> >> -                             vhost_vdpa_net_cvq_cmd_len());
> >> +                             vhost_vdpa_net_cvq_cmd_page_len());
> >>       if (*(uint8_t *)s->cvq_cmd_out_buffer =3D=3D VIRTIO_NET_CTRL_ANN=
OUNCE) {
> >>           /*
> >>            * Guest announce capability is emulated by qemu, so don't f=
orward to
> >> --
> >> 2.25.1
> >>
> >
>


