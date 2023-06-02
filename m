Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F2271F9D4
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 08:02:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4xpm-00042r-7B; Fri, 02 Jun 2023 02:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4xpc-000420-MY
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 02:00:15 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4xpa-0002Gl-50
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 02:00:12 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b1a3fa2cd2so19152431fa.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 23:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685685607; x=1688277607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QdjEC360sxrieo5cxjhaSj57K01ezhgMMMCYNusaBIg=;
 b=ZAvV6LWPiG4dkXv9GOYeiKfB9utvxaldKCNdauvTmWIJ7+BnG/61wkA2OKzAm5Anj7
 spMGRxAixe23Yj1mVEUkUBWwRDDrLdazvsTNjD+puMmadmOjDdTsV7szE7BrfXDXL38I
 KFDWpzJABI5tK+iC6qC60CiKY4iU/JEbBapDsfSv6wJLItMQFR2DChPdaQjR58QiMzz7
 UPXU/ejjizXCOP7DWJEJBom0Hns7CNXFSf1dFU/zEFyn4S9irNf0HtwJJFrhyFd6eiKb
 Mj+DT/c4C2w3N0/BV4sNk3kRpVCsTXHo8gVxhTvAHLBQUTOjHjPxF6f1pGHfqWX0JGbM
 dM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685685607; x=1688277607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QdjEC360sxrieo5cxjhaSj57K01ezhgMMMCYNusaBIg=;
 b=Qyc7Hzho0kyOkuKNV4GaHhOIc3BdTfnc859dtqBxqOw8GVS3imlXLkz774xskZ3ZUY
 Ln4jHNMuUM3VLayHjjc7pDldLkI5up4nhsG+6C8MSLd4BVhGK+AYRUNmrKh7eepLefwX
 z26yeoypqrUSyE3ZfA2cvImpE6sErVNbs2tFbVPEzEpu82bTJQuq7873ehHST98i7d3L
 PoS0W518NerJwovh7y+ZhUcL+hAPtGh1KIG5IfPR4Od7XMvuQnu58lxcIjCNXAmoQEXr
 XhHxwAxma3iLGExHJC7bRuv6wBH+Va0vVGOExwc2VR2996tQLfq1dWJeTDxRLgB47ZLm
 1iNQ==
X-Gm-Message-State: AC+VfDyyjoVnUzbr/qTTw2vrzjhoUsV0sdB5Fn6I3e98eAkISzEsg/ii
 DJjSGPx9Vjd3hyRqKRYnbGDqtohSFZCyKXXzPAM=
X-Google-Smtp-Source: ACHHUZ7agzmJhB40X4EtSW2CSDvg//xzzS51okowY5anQCFltjWpdXvYnApHvc1m3n8D0yRHIV2NM5PixLmf7HBp7CA=
X-Received: by 2002:a2e:8057:0:b0:2a7:6f82:4a87 with SMTP id
 p23-20020a2e8057000000b002a76f824a87mr883363ljg.35.1685685606574; Thu, 01 Jun
 2023 23:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685623090.git.yin31149@gmail.com>
 <68226edccea8d6e51ea3f2da26d5ff2da2abc224.1685623090.git.yin31149@gmail.com>
 <CAJaqyWcE0UgUYL8hwGNFNTOvqa8aSYF-_FoTc4+dYC0j+A5LwQ@mail.gmail.com>
In-Reply-To: <CAJaqyWcE0UgUYL8hwGNFNTOvqa8aSYF-_FoTc4+dYC0j+A5LwQ@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Fri, 2 Jun 2023 13:59:54 +0800
Message-ID: <CAKrof1OBqkQwpk1araC8wZ+m4G_rRhfFz3MUx-aBantzpirUaw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] virtio-net: expose
 virtio_net_supported_guest_offloads()
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2023/6/1 22:37, Eugenio Perez Martin wrote:
> On Thu, Jun 1, 2023 at 3:49=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com=
> wrote:
>>
>> To support restoring offloads state in vdpa, need to expose
>> the function virtio_net_supported_guest_offloads().
>> QEMU uses this function to get the guest supported offloads
>> and no needs to send the corresponding CVQ command if guest
>
> doesn't need to send?

I will correct it in the v4 patch.

>
>> enables all supported features.
>>
>
> Good! I'd add the same message as the next patch's comment, to signal
> it is because the device has already enabled by default:
>
> +         * According to VirtIO standard, "Upon feature negotiation
> +         * corresponding offload gets enabled to preserve
> +         * backward compatibility."
> +         * So we do not need to send this CVQ command if the guest
> +         * also enables all supported offloads.

I will add these messages in the v4 patch.

Thanks!


>
> Thanks!
>
>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>>   hw/net/virtio-net.c            | 2 +-
>>   include/hw/virtio/virtio-net.h | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 7b27dad6c4..7e8897a8bc 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -874,7 +874,7 @@ static uint64_t virtio_net_guest_offloads_by_feature=
s(uint32_t features)
>>       return guest_offloads_mask & features;
>>   }
>>
>> -static inline uint64_t virtio_net_supported_guest_offloads(const VirtIO=
Net *n)
>> +uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
>>   {
>>       VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>>       return virtio_net_guest_offloads_by_features(vdev->guest_features)=
;
>> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-n=
et.h
>> index ef234ffe7e..5f5dcb4572 100644
>> --- a/include/hw/virtio/virtio-net.h
>> +++ b/include/hw/virtio/virtio-net.h
>> @@ -227,5 +227,6 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev=
,
>>                                     unsigned out_num);
>>   void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
>>                                      const char *type);
>> +uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n);
>>
>>   #endif
>> --
>> 2.25.1
>>
>

