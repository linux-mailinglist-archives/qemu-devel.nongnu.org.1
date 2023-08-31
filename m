Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 926C478F421
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 22:35:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qboNR-0005sD-OF; Thu, 31 Aug 2023 16:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboNL-0005rV-DF
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:34:47 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboNI-0003do-3n
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:34:47 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-500c63c9625so2386149e87.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 13:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693514082; x=1694118882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HnrRM3jpo15vClbqUmXDhj60Aht6RYW2Cwot3eESiN8=;
 b=ckIvsLUuGY7qYytsAlWrCjJhAXQMpx5gKnMq2T252vA2v6h5LGpOwj2FR3TvDYDXLk
 MGiXiv55xmdasoN7OR3d38p90e0ZxEAXHUHvRBjxiHM8Ow3xDaEr6Zt1grzh10FT08qY
 AyfZEccQS9eAetMcIO6lvgIBfMukYAfCBSTejA8uIkSms0xIQM+ZLjWlq4ukU8p6psSF
 t0r3S5F/i6yKAs+u9vj5T2XX1rOhIGbUofqZv3Oh37XSGQKulJGrQbmA6NlXBhyTYBkf
 4C6Y5mdO4355fLzxWSyAHPzsdxXqJR4NiUo/Uiro/FEBuTdtvgqKr9oX163RpyZq0XQq
 onuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693514082; x=1694118882;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HnrRM3jpo15vClbqUmXDhj60Aht6RYW2Cwot3eESiN8=;
 b=Fpng6AuRsAz8wMkMDoiI0qlL/zIaVX2pZSsbHKvXVKjwJg2BiVBbOSanvdw4asn/OJ
 E/WHrrtI6R+M0GfhAt4MZf+Ma9rJtxIkopQj2SNctVxUmTdFSd2cWmaTEuJDm6bfKTbO
 970Zk66ek3mOyEHKQq25z8E+n68CEVyblHuoVgXNHaXDePDr/Oe50FxRelXABU/HKtFI
 9Ge4ULFuoyTAmIvSIekLtgzOxE6oj5Q03VuvHRaseY5wZjTvqVa3k6+ye2s9tH7PWL9w
 A6ZkNbjtdybijDVNvXPpWJ8jaVPg+AogLwcgTxXkpRx2/JytUYjys7HLHgAKTqF7/vLQ
 F9fA==
X-Gm-Message-State: AOJu0YwEoS8oVKsAJ0pTqNUwfqpbfkPAmFjPK9FeSbVa0oxIKUSFtqV2
 5uCVwJBNiDbJ85srIRyYOq+clA==
X-Google-Smtp-Source: AGHT+IFCExjMxu4dxykaBYDB7HpRh5yd3aiK+xT1LLMgMBrvhV5mBdSHmtB84lrrK9WMRpZVjBf/5A==
X-Received: by 2002:a05:6512:b8e:b0:500:9b7d:ee22 with SMTP id
 b14-20020a0565120b8e00b005009b7dee22mr259852lfv.60.1693514082266; 
 Thu, 31 Aug 2023 13:34:42 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a1709060d9500b0099bc2d1429csm1135740eji.72.2023.08.31.13.34.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 13:34:41 -0700 (PDT)
Message-ID: <9c4aa5e1-c9e7-c7eb-197a-de0c0f7c8648@linaro.org>
Date: Thu, 31 Aug 2023 22:34:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 11/12] hw/vmapple/virtio-blk: Add support for apple
 virtio-blk
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20230830161425.91946-1-graf@amazon.com>
 <20230830161425.91946-12-graf@amazon.com> <20230831200342.GF532982@fedora>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230831200342.GF532982@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 31/8/23 22:03, Stefan Hajnoczi wrote:
> On Wed, Aug 30, 2023 at 04:14:24PM +0000, Alexander Graf wrote:
>> Apple has its own virtio-blk PCI device ID where it deviates from the
>> official virtio-pci spec slightly: It puts a new "apple type"
>> field at a static offset in config space and introduces a new barrier
>> command.
>>
>> This patch first creates a mechanism for virtio-blk downstream classes to
>> handle unknown commands. It then creates such a downstream class and a new
>> vmapple-virtio-blk-pci class which support the additional apple type config
>> identifier as well as the barrier command.
>>
>> It then exposes 2 subclasses from that that we can use to expose root and
>> aux virtio-blk devices: "vmapple-virtio-root" and "vmapple-virtio-aux".
>>
>> Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> Aside from my comments below:
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
>>
>> ---
>>
>> v1 -> v2:
>>
>>    - Rework to make all vmapple virtio-blk logic a subclass
>> ---
>>   include/hw/pci/pci_ids.h        |   1 +
>>   include/hw/virtio/virtio-blk.h  |  12 +-
>>   include/hw/vmapple/virtio-blk.h |  39 ++++++
>>   hw/block/virtio-blk.c           |  19 ++-
>>   hw/vmapple/virtio-blk.c         | 212 ++++++++++++++++++++++++++++++++
>>   hw/vmapple/Kconfig              |   3 +
>>   hw/vmapple/meson.build          |   1 +
>>   7 files changed, 282 insertions(+), 5 deletions(-)
>>   create mode 100644 include/hw/vmapple/virtio-blk.h
>>   create mode 100644 hw/vmapple/virtio-blk.c

>> diff --git a/include/hw/vmapple/virtio-blk.h b/include/hw/vmapple/virtio-blk.h
>> new file mode 100644
>> index 0000000000..b23106a3df
>> --- /dev/null
>> +++ b/include/hw/vmapple/virtio-blk.h
>> @@ -0,0 +1,39 @@
>> +/*
>> + * VMApple specific VirtIO Block implementation
>> + *
>> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef HW_VMAPPLE_CFG_H
>> +#define HW_VMAPPLE_CFG_H
>> +
>> +#include "hw/sysbus.h"
> 
> I'm surprised to see this header since this isn't a SysBus device. Is it
> really needed?
> 
>> +#include "qom/object.h"
>> +#include "hw/virtio/virtio-pci.h"

"virtio-pci.h" surprised me too.

>> +#include "hw/virtio/virtio-blk.h"
>> +
>> +#define TYPE_VMAPPLE_VIRTIO_BLK "vmapple-virtio-blk"
>> +#define TYPE_VMAPPLE_VIRTIO_ROOT "vmapple-virtio-root"
>> +#define TYPE_VMAPPLE_VIRTIO_AUX "vmapple-virtio-aux"
>> +
>> +OBJECT_DECLARE_TYPE(VMAppleVirtIOBlk, VMAppleVirtIOBlkClass, VMAPPLE_VIRTIO_BLK)
>> +
>> +typedef struct VMAppleVirtIOBlkClass {
>> +    /*< private >*/
>> +    VirtIOBlkClass parent;
>> +    /*< public >*/
>> +    void (*get_config)(VirtIODevice *vdev, uint8_t *config);
>> +} VMAppleVirtIOBlkClass;
>> +
>> +typedef struct VMAppleVirtIOBlk {
>> +    /* <private> */
>> +    VirtIOBlock parent_obj;
>> +
>> +    /* <public> */
>> +    uint32_t apple_type;
>> +} VMAppleVirtIOBlk;
>> +
>> +#endif /* HW_VMAPPLE_CFG_H */


