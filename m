Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB851821AE4
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 12:27:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKcu2-0000Hy-Bk; Tue, 02 Jan 2024 06:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1rKcty-0000HF-Qp
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 06:25:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1rKctw-0002tC-Rj
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 06:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704194736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1fm8RMozqhcx5QL1wbwiFOXeebUByWtTm6er0KdWWM=;
 b=BF8RZj6V6D+KjY7u2Tt/FsRzPG8BfVFACNCNt5TXcufU7V4KbrSk2UuIkwUURW9/7WHNkz
 yqS/fo3Xc6vJw8KwPbXE4O2d550Dnpc52ntFzhRAZK1MfmLo6t8MXsgbrxW26DZtT0TuAR
 tBZnC2eQQg2QU4bb5lF97THNF8rzSE4=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-7om6iaTpNlqk0hW6k7rMkg-1; Tue, 02 Jan 2024 06:25:35 -0500
X-MC-Unique: 7om6iaTpNlqk0hW6k7rMkg-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7cbf6fd4870so1891505241.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 03:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704194734; x=1704799534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R1fm8RMozqhcx5QL1wbwiFOXeebUByWtTm6er0KdWWM=;
 b=asMp1zmZHjGZMFK35G8gtX3kFBDau7aVEOr66htDiZgiIHR+Id0ZCbVEKdVWx7QQv/
 n5LprF1AN6COKYO7hFzDp/LWrxqSHF/IL0C7VJ3EVAvAtqtT4xOpmYDneiK5lvKE0Pk7
 I2jO6ZxW8UUuzBRP2c2rtw0eiP+T8d6U++pFaYdZdRMQEv85UrHDDkFfIUdY4p1Lb8mJ
 7m7FdUYPnOvMbNri9YZ+bifHcmBQGBNkaA6dFJFNkOTMDjCqk69H887rsLklXw0sNzuC
 ApCP2HLgyJHG1HdotQAyDOL7yUS4ZrCsycISYmS2BAXJKc8MXfmk/lpDaLlZ/J0Cxjkw
 ixtg==
X-Gm-Message-State: AOJu0YyH4+sM6dvdj5WNruk38HyrBgN0zrqn0bDejTqV3Hw20cHXS93V
 5l4eZ7BqnbPXsVjNFaajYhG3bLEtophIRb8EudO+h/sXQRqbSa7NKUGPlLYaIlLJcAiXUEFoxkH
 K9TwHr3zOR1W1eNPNu9+kULjYX7ExJt1QuIvFB4w=
X-Received: by 2002:a05:6102:3f04:b0:467:1968:87f1 with SMTP id
 k4-20020a0561023f0400b00467196887f1mr5871075vsv.1.1704194734716; 
 Tue, 02 Jan 2024 03:25:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGltn1PLjvOAikYoQin0GMYsGt/l415m+6EHCEc/KXEo6TkAIz/3Mm2mJctyhlGkrEKoB15E/RswyOk/lvl9Vo=
X-Received: by 2002:a05:6102:3f04:b0:467:1968:87f1 with SMTP id
 k4-20020a0561023f0400b00467196887f1mr5871071vsv.1.1704194734476; Tue, 02 Jan
 2024 03:25:34 -0800 (PST)
MIME-Version: 1.0
References: <20240102032901.3234-1-jasowang@redhat.com>
 <CAOEp5Oe9PcZd2999bzYGCVTd8xbX8+_HXW2UbAZLSoVzSxYjnw@mail.gmail.com>
In-Reply-To: <CAOEp5Oe9PcZd2999bzYGCVTd8xbX8+_HXW2UbAZLSoVzSxYjnw@mail.gmail.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Tue, 2 Jan 2024 12:25:23 +0100
Message-ID: <CAA8xKjUq+iXiEFfY=-ZWeTVWbNbKFRw9TyDFzNTzGyU4saiH2Q@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: correctly copy vnet header when flushing TX
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org, 
 Xiao Lei <leixiao.nop@zju.edu.cn>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.246,
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

On Tue, Jan 2, 2024 at 12:20=E2=80=AFPM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> I agree, thank you.
>
> Where is this CVE-2023-6693 available?

Here: https://bugzilla.redhat.com/show_bug.cgi?id=3D2254580.

> Thanks,
> Yuri
>
> On Tue, Jan 2, 2024 at 5:29=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>>
>> When HASH_REPORT is negotiated, the guest_hdr_len might be larger than
>> the size of the mergeable rx buffer header. Using
>> virtio_net_hdr_mrg_rxbuf during the header swap might lead a stack
>> overflow in this case. Fixing this by using virtio_net_hdr_v1_hash
>> instead.
>>
>> Reported-by: Xiao Lei <leixiao.nop@zju.edu.cn>
>> Cc: Yuri Benditovich <yuri.benditovich@daynix.com>
>> Cc: qemu-stable@nongnu.org
>> Cc: Mauro Matteo Cascella <mcascell@redhat.com>
>> Fixes: CVE-2023-6693
>> Fixes: e22f0603fb2f ("virtio-net: reference implementation of hash repor=
t")
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>  hw/net/virtio-net.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 80c56f0cfc..73024babd4 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -674,6 +674,11 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n=
, int mergeable_rx_bufs,
>>
>>      n->mergeable_rx_bufs =3D mergeable_rx_bufs;
>>
>> +    /*
>> +     * Note: when extending the vnet header, please make sure to
>> +     * change the vnet header copying logic in virtio_net_flush_tx()
>> +     * as well.
>> +     */
>>      if (version_1) {
>>          n->guest_hdr_len =3D hash_report ?
>>              sizeof(struct virtio_net_hdr_v1_hash) :
>> @@ -2693,7 +2698,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue =
*q)
>>          ssize_t ret;
>>          unsigned int out_num;
>>          struct iovec sg[VIRTQUEUE_MAX_SIZE], sg2[VIRTQUEUE_MAX_SIZE + 1=
], *out_sg;
>> -        struct virtio_net_hdr_mrg_rxbuf mhdr;
>> +        struct virtio_net_hdr_v1_hash vhdr;
>>
>>          elem =3D virtqueue_pop(q->tx_vq, sizeof(VirtQueueElement));
>>          if (!elem) {
>> @@ -2710,7 +2715,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue =
*q)
>>          }
>>
>>          if (n->has_vnet_hdr) {
>> -            if (iov_to_buf(out_sg, out_num, 0, &mhdr, n->guest_hdr_len)=
 <
>> +            if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len)=
 <
>>                  n->guest_hdr_len) {
>>                  virtio_error(vdev, "virtio-net header incorrect");
>>                  virtqueue_detach_element(q->tx_vq, elem, 0);
>> @@ -2718,8 +2723,8 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue =
*q)
>>                  return -EINVAL;
>>              }
>>              if (n->needs_vnet_hdr_swap) {
>> -                virtio_net_hdr_swap(vdev, (void *) &mhdr);
>> -                sg2[0].iov_base =3D &mhdr;
>> +                virtio_net_hdr_swap(vdev, (void *) &vhdr);
>> +                sg2[0].iov_base =3D &vhdr;
>>                  sg2[0].iov_len =3D n->guest_hdr_len;
>>                  out_num =3D iov_copy(&sg2[1], ARRAY_SIZE(sg2) - 1,
>>                                     out_sg, out_num,
>> --
>> 2.42.0
>>

--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


