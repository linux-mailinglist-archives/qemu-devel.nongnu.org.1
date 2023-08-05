Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F914770F0E
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 11:30:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSDb0-0000gw-08; Sat, 05 Aug 2023 05:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qSDar-0000gS-RI; Sat, 05 Aug 2023 05:29:05 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qSDaq-0005j9-3V; Sat, 05 Aug 2023 05:29:05 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2b9e6cc93c6so43763261fa.2; 
 Sat, 05 Aug 2023 02:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691227736; x=1691832536;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cdy4rO90ujEXJNsc/0hbts99UxzA7k1xO6nu8umKq9E=;
 b=cpeCa1fkpfW0Ooxd/MsJ1iEXgVxoTRgtpHFk4JWJF6xPYRS9GdPNXFHjsyFm69mnZk
 cLNUREC3WHED7b/dLHpwy1YJ0FrOGDW1ivhXlypbR5p+yQqxzDfnZ0eaCauwYSvWXBiV
 VrEVe6j/ZXp3ubwye2yfDIcSUr9/eFeIHLLzt6lttvkGO5u8+4aRIgHKSoQYlgaEzfGh
 L3YwCVdNJYVeAbuT1sCgy0cISgAWqJe3R1NX9z//sHPskaYjy3OYkAjPGRjYlPHKH0lK
 87eWVGvCb1yDs5cTra7xWyTbxCRLbz/e1ju31QwDcd5uX5qrFaM9CChAlW6IudO0qNvW
 /09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691227736; x=1691832536;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cdy4rO90ujEXJNsc/0hbts99UxzA7k1xO6nu8umKq9E=;
 b=SQGuDGeA97K6TlAzquI8jvyzhYnkqcIRmNMdhUmNZf6f77YFDTZ83JZxrz3ZoYMVkT
 fg5rlC61tHDFLgKktsXxV6yZvX/9WPycctB0U/3kftfW83am0OkJRKbntt3RQtwPBaFj
 6ygQcxuEnP354Vj9GGy7c3o9E/oVpcnmsSeRiXWmTJQKVJen7PkT0X2TNvVPpfGk87K7
 ldr4WOgtfUfMzTV5ozT82nRjRxIKu2zjRrwD0mJwE7Wcqedzt1JD/baqb/hiylRlO+DG
 KTXuUm6iaqfoxnftpFv67rTZUHdPzdqH7N1V2TZCztmvBNNSG1rNauYQ69a/Aw1Y6mNZ
 Kfug==
X-Gm-Message-State: AOJu0YzAqFyAKk1jiSH+3yPCtOhhF4mB7j7QkK3IUvecxTdtNhxHbQyw
 q+9OdubQW1Spg/huWILhwV4y4QZub6ClX+Lfr/g=
X-Google-Smtp-Source: AGHT+IHP9cHys8tO5A/qpddKVesdi8wZY3+3xuyAisVBZDgb6/GRKOB78kcglzT/hquv6b+yJwvOfj8U5wrFszLS+DY=
X-Received: by 2002:a2e:9a92:0:b0:2b6:eefc:3e4f with SMTP id
 p18-20020a2e9a92000000b002b6eefc3e4fmr3356938lji.21.1691227735653; Sat, 05
 Aug 2023 02:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688438055.git.yin31149@gmail.com>
 <86a640b2-a9f8-5b62-349c-c0927c2a013b@tls.msk.ru>
In-Reply-To: <86a640b2-a9f8-5b62-349c-c0927c2a013b@tls.msk.ru>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Sat, 5 Aug 2023 17:28:44 +0800
Message-ID: <CAKrof1NXV22zdjww=+P2NybZCyoNBOdahDMLrJfTDmK0Xa5BEA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] vdpa: Return -EIO if device ack is VIRTIO_NET_ERR
To: Michael Tokarev <mjt@tls.msk.ru>, jasowang@redhat.com, mst@redhat.com, 
 eperezma@redhat.com
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2023/8/5 14:15, Michael Tokarev wrote:
> 04.07.2023 06:34, Hawkins Jiawei wrote:
>> According to VirtIO standard, "The class, command and
>> command-specific-data are set by the driver,
>> and the device sets the ack byte.
>> There is little it can do except issue a diagnostic
>> if ack is not VIRTIO_NET_OK."
>>
>> Therefore, QEMU should stop sending the queued SVQ commands and
>> cancel the device startup if the device's ack is not VIRTIO_NET_OK.
>>
>> Yet the problem is that, vhost_vdpa_net_load_x() returns 1 based on
>> `*s->status != VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
>> As a result, net->nc->info->load() also returns 1, this makes
>> vhost_net_start_one() incorrectly assume the device state is
>> successfully loaded by vhost_vdpa_net_load() and return 0, instead of
>> goto `fail` label to cancel the device startup, as vhost_net_start_one()
>> only cancels the device startup when net->nc->info->load() returns a
>> negative value.
>>
>> This patchset fixes this problem by returning -EIO when the device's
>> ack is not VIRTIO_NET_OK.
>>
>> Changelog
>> =========
>> v3:
>>   - split the fixes suggested by Eugenio
>>   - return -EIO suggested by Michael
>>
>> v2:
>> https://lore.kernel.org/all/69010e9ebb5e3729aef595ed92840f43e48e53e5.1687875592.git.yin31149@gmail.com/
>>   - fix the same bug in vhost_vdpa_net_load_offloads()
>>
>> v1: https://lore.kernel.org/all/cover.1686746406.git.yin31149@gmail.com/
>>
>> Hawkins Jiawei (3):
>>    vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mac()
>>    vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mq()
>>    vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_offloads()
>
> Hi!
>
> I don't remember why, but this patch series is marked as "check later" in
> my qemu-stable-to-apply email folder.  Does it make sense to back-port this
> series to stable-8.0?
>
> 6f34807116 vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in
> _load_offloads()
> f45fd95ec9 vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mq()
> b479bc3c9d vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mac()
>

Hi Michael,

Yes, this bug exists in stable-8.0, so it makes sense to back-port this
series.

Commit f45fd95ec9("vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in
_load_mq()") and
commit b479bc3c9d("vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in
_load_mac()") can be back-ported directly.

> Patch 6f34807116 also needs
>
> b58d3686a0 vdpa: Add vhost_vdpa_net_load_offloads()

As you point out, patch 6f34807116("vdpa: Return -EIO if device ack is
VIRTIO_NET_ERR in _load_offloads()") is a fix to the commit
b58d3686a0("vdpa: Add vhost_vdpa_net_load_offloads()"), which was
introduced by patch series "Vhost-vdpa Shadow Virtqueue Offloads
support" at [1].

This mentioned patch series introduces a new feature for QEMU and
has not been merged into stable-8.0 yet, so I think we do not need to
apply the
patch 6f34807116("vdpa: Return -EIO if device ack is
VIRTIO_NET_ERR in _load_offloads()") to stable-8.0.

Sorry for not mentioning this information in the cover letter.

Thanks!

[1]. https://lore.kernel.org/all/cover.1685704856.git.yin31149@gmail.com/

>
> for 8.0.
>
> Thanks,
>
> /mjt

