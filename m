Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDF77466E4
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 03:34:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGUvN-0001Ks-FZ; Mon, 03 Jul 2023 21:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGUvL-0001KI-56; Mon, 03 Jul 2023 21:33:47 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGUvJ-00065u-Ep; Mon, 03 Jul 2023 21:33:46 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b5c2433134so63681551fa.0; 
 Mon, 03 Jul 2023 18:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688434423; x=1691026423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f1fnJ3fQlQvp4eKB4P25xJD1uB+h5WoBSI3O19HTGiI=;
 b=O5wBdPQviwDmkKBIn9+9pidM0q+ZaVDTpvlkNQBekO1WK00FUQtoQpCcw+ZAWO3u3b
 J+qNfgqknNqrJqugJXSOrnZiyePdJ4RR15A7azwfGnPf5bmtO3Kdn9iVdcQ1dLiMD/GL
 kEOq39sPzhWDPRqtJ6dwpTeBXlz8l6dzspcmLlLrV1nvxfMtQmOuGE89PxvrxWVM1J72
 2j9HncIHkkqAnxI2rRMRuyLy1XH8xra0asXjV27+TBKcNf5EGiL3qBOoEfLDuwFhEDCm
 cXN/fYrLmMhEaPomsVw3BUEmo2i6LR1u1t2WyFeD7RvbF8ONdPBfWbfWnbHaz+eOVL6c
 DUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688434423; x=1691026423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f1fnJ3fQlQvp4eKB4P25xJD1uB+h5WoBSI3O19HTGiI=;
 b=K1YXqXf7cGcekfAcgF8Vl9wXs4KBWCDzzPOYxiehHGbTIEI0Zfh0k/cgYg4IAI2c/V
 8FQqEWlFTm/CXvwgT4HBPs4gC8DKoZ2wXHGZOfRP3c5o1QHtt100opz395NnU1wZxt9G
 2Igpd1E+QClapuNhfj1RVL96hVws5cKfBzigJ/5as+65ORos2PJubUZSXxAr/DVFfG69
 sot2o8Joy2e54zFAVGWeYH/k8c4OZarCwlu815Jws5VJH3iAHXmRH7Sdwnb5PnQeGVZZ
 aBnmdM93MSn54SIsgUWkFl1+T0rim/qLd/81GYvndGEf7HqoyIqbTPQuLkCxfPlbQI5r
 94oQ==
X-Gm-Message-State: AC+VfDy8EQuuMFKFDBGfVAiKEJMg7rdJVVG3a3dSVLsJr0MMPNBBnpPc
 ZPR0XvZCc9EI3U8kCMH0uMq7yeL3d75HI6vbVus=
X-Google-Smtp-Source: ACHHUZ4NGo7qHHrO0/8gL6ViKkdl6SDfdC3/Bf0cBhF8TY7e+vjh8h44lN2Ttj9Lh9mGeVBxNqHAEE1c/1U7zv1JNXA=
X-Received: by 2002:a05:651c:1309:b0:2b6:9f54:af9a with SMTP id
 u9-20020a05651c130900b002b69f54af9amr6088044lja.8.1688434422875; Mon, 03 Jul
 2023 18:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686746406.git.yin31149@gmail.com>
 <07a1133d6c989394b342e35d8202257771e76769.1686746406.git.yin31149@gmail.com>
 <20230703125134-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230703125134-mutt-send-email-mst@kernel.org>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Tue, 4 Jul 2023 09:33:30 +0800
Message-ID: <CAKrof1O_YcMedVNfXitC=b6yXTTL2s9Uecj4LMr8hWGOkZTC+g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] vdpa: Return -EINVAL if device's ack is
 VIRTIO_NET_ERR
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x233.google.com
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

On 2023/7/4 0:52, Michael S. Tsirkin wrote:
> On Wed, Jun 14, 2023 at 09:01:47PM +0800, Hawkins Jiawei wrote:
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
>> This patch fixes this problem by returning -EINVAL when the device's
>> ack is not VIRTIO_NET_OK.
>>
>> Fixes: f73c0c43ac ("vdpa: extract vhost_vdpa_net_load_mac from vhost_vdpa_net_load")
>> Fixes: f64c7cda69 ("vdpa: Add vhost_vdpa_net_load_mq")
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>>   net/vhost-vdpa.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 37cdc84562..630c9bf71e 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -651,8 +651,9 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
>>           if (unlikely(dev_written < 0)) {
>>               return dev_written;
>>           }
>> -
>> -        return *s->status != VIRTIO_NET_OK;
>> +        if (*s->status != VIRTIO_NET_OK) {
>> +            return -EINVAL;
>> +        }
>>       }
>>
>>       return 0;
>> @@ -676,8 +677,11 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>>       if (unlikely(dev_written < 0)) {
>>           return dev_written;
>>       }
>> +    if (*s->status != VIRTIO_NET_OK) {
>> +        return -EINVAL;
>> +    }
>>
>> -    return *s->status != VIRTIO_NET_OK;
>> +    return 0;
>>   }
>
> I think EIO would be better, we have too many EINVAL cases,
> making things hard to debug.

I will refactor this patch to return -EIO according to your suggestion.

Thanks!

>
>
>>

>>   static int vhost_vdpa_net_load(NetClientState *nc)
>> --
>> 2.25.1
>

