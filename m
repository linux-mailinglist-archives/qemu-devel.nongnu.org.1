Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF257881B3
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 10:12:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZRv6-0002rc-2z; Fri, 25 Aug 2023 04:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZRv3-0002rU-Nj
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 04:11:49 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZRv1-0004kU-0J
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 04:11:49 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so80776266b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 01:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692951105; x=1693555905;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5YGr1o107mv0Wqr91vOVuwvcpL8DfCVB/r0dMKaWkOg=;
 b=vCQD1S8DQBQvUSf46upau1ri7yGfYo29HR3KY4wsGQz6oDzspTwiaAsZ24ARoZ2SuK
 5ZJf3RQiQsoxZURJi8qjpd76zXFbGvj398bTPyQpYll1kJyjxkzXdy6PLdxk8X1aBYRT
 nTHav6pT8BI8AAOQftsaxDb4AhpTPCGO+voCKVc3+yp3ZE9oVDNwYPazyjdRc0FmWQFU
 33012ptTwg7SNx8jMmJtHrV+Fu+UpeeJIUcgDVv0qJUAI95UmJajN8cMw1I6Z+RvmawB
 BgRQ5DYWIpL2QNlYX9f6IFPL+njcbCsgKwGycmJZX2x/1vdyHM4qw/+FtyhfpGEWYzAT
 gh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692951105; x=1693555905;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5YGr1o107mv0Wqr91vOVuwvcpL8DfCVB/r0dMKaWkOg=;
 b=QByPCLQl9C4XEgNsdvuMBPg5KTQ8PFcnyTZPoF2UehXx39OPttvJTQ/Eyl70UXB1ba
 yVS58/tw2yVzmoJz81MCI2SZrIJS5IFJ5CjNCE1RanntcwCk8lMMrWzq5GEH4C3QBF/D
 MNJrUYUeOlyuC/j8Fl2nT1xEhEZzBHpB8h96jmE/RMKWnrzWKAn/pRbcZYiFOxbI8lts
 ouM8gHowecp585+hzZrHDeqH6Ss6lE+rZkwXygFzK8MAwM0IrM5AtoRR5XpJKGD9tiGd
 I90CZpCuQ9zbzLzUpfBv9WOOUkHmp4CN/hl75HzTttVGFsdrFmsSjLW42iFE3X2on0Kl
 aSdw==
X-Gm-Message-State: AOJu0Yyfg6nkwiD4PGvD7qF5x7xOLfoz3yrexGYihXhPjui75SL94L4T
 Y22S2n5/mR5MBwCwcuQjpE7CeQ==
X-Google-Smtp-Source: AGHT+IHDwiGayFAwXd6dWDu/Alz0DgGz2qmzOkrlKWLdi439pkSsicTJmqtmHvoGEJCq2I0b5Z1jeg==
X-Received: by 2002:a17:906:3287:b0:991:fef4:bb9 with SMTP id
 7-20020a170906328700b00991fef40bb9mr13728140ejw.58.1692951105175; 
 Fri, 25 Aug 2023 01:11:45 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 w26-20020a1709064a1a00b009786c8249d6sm681328eju.175.2023.08.25.01.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 01:11:44 -0700 (PDT)
Message-ID: <354b3401-c386-380a-dacb-0e0fecc28f8f@linaro.org>
Date: Fri, 25 Aug 2023 10:11:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 4/6] hw/virtio/vhost-vdpa: Use target-agnostic
 qemu_target_page_mask()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230710094931.84402-1-philmd@linaro.org>
 <20230710094931.84402-5-philmd@linaro.org>
 <e24e67e0-fd01-6374-3bb7-1a73a35b48da@linaro.org>
In-Reply-To: <e24e67e0-fd01-6374-3bb7-1a73a35b48da@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 18/8/23 13:00, Philippe Mathieu-Daudé wrote:
> ping?
> 
> On 10/7/23 11:49, Philippe Mathieu-Daudé wrote:
>> Similarly to commit e414ed2c47 ("virtio-iommu: Use
>> target-agnostic qemu_target_page_mask"), Replace the
>> target-specific TARGET_PAGE_SIZE and TARGET_PAGE_MASK
>> definitions by a call to the runtime qemu_target_page_size()
>> helper which is target agnostic.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/virtio/vhost-vdpa.c | 26 +++++++++++++++-----------
>>   1 file changed, 15 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index a3dd7c712a..2717edf51d 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/vfio.h>
>>   #include <sys/eventfd.h>
>>   #include <sys/ioctl.h>
>> +#include "exec/target_page.h"
>>   #include "hw/virtio/vhost.h"
>>   #include "hw/virtio/vhost-backend.h"
>>   #include "hw/virtio/virtio-net.h"
>> @@ -23,7 +24,6 @@
>>   #include "migration/blocker.h"
>>   #include "qemu/cutils.h"
>>   #include "qemu/main-loop.h"
>> -#include "cpu.h"
>>   #include "trace.h"
>>   #include "qapi/error.h"
>> @@ -313,9 +313,11 @@ static void 
>> vhost_vdpa_listener_region_add(MemoryListener *listener,
>>       Int128 llend, llsize;
>>       void *vaddr;
>>       int ret;
>> +    int page_size = qemu_target_page_size();
>> +    int page_mask = -page_size;

Richard, this is the change you asked here:
https://lore.kernel.org/qemu-devel/f877dda3-a3d9-5081-c2b3-c10eeb7b6814@linaro.org/

Did I miss something else?

>>       if (vhost_vdpa_listener_skipped_section(section, 
>> v->iova_range.first,
>> -                                            v->iova_range.last, 
>> TARGET_PAGE_MASK)) {
>> +                                            v->iova_range.last, 
>> page_mask)) {
>>           return;
>>       }
>>       if (memory_region_is_iommu(section->mr)) {
>> @@ -323,14 +325,14 @@ static void 
>> vhost_vdpa_listener_region_add(MemoryListener *listener,
>>           return;
>>       }
>> -    if (unlikely((section->offset_within_address_space & 
>> ~TARGET_PAGE_MASK) !=
>> -                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
>> +    if (unlikely((section->offset_within_address_space & ~page_mask) !=
>> +                 (section->offset_within_region & ~page_mask))) {
>>           error_report("%s received unaligned region", __func__);
>>           return;
>>       }
>> -    iova = ROUND_UP(section->offset_within_address_space, 
>> TARGET_PAGE_SIZE);
>> -    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
>> +    iova = ROUND_UP(section->offset_within_address_space, page_size);
>> +    llend = vhost_vdpa_section_end(section, page_mask);
>>       if (int128_ge(int128_make64(iova), llend)) {
>>           return;
>>       }
>> @@ -396,23 +398,25 @@ static void 
>> vhost_vdpa_listener_region_del(MemoryListener *listener,
>>       hwaddr iova;
>>       Int128 llend, llsize;
>>       int ret;
>> +    int page_size = qemu_target_page_size();
>> +    int page_mask = -page_size;
>>       if (vhost_vdpa_listener_skipped_section(section, 
>> v->iova_range.first,
>> -                                            v->iova_range.last, 
>> TARGET_PAGE_MASK)) {
>> +                                            v->iova_range.last, 
>> page_mask)) {
>>           return;
>>       }
>>       if (memory_region_is_iommu(section->mr)) {
>>           vhost_vdpa_iommu_region_del(listener, section);
>>       }
>> -    if (unlikely((section->offset_within_address_space & 
>> ~TARGET_PAGE_MASK) !=
>> -                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
>> +    if (unlikely((section->offset_within_address_space & ~page_mask) !=
>> +                 (section->offset_within_region & ~page_mask))) {
>>           error_report("%s received unaligned region", __func__);
>>           return;
>>       }
>> -    iova = ROUND_UP(section->offset_within_address_space, 
>> TARGET_PAGE_SIZE);
>> -    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
>> +    iova = ROUND_UP(section->offset_within_address_space, page_size);
>> +    llend = vhost_vdpa_section_end(section, page_mask);
>>       trace_vhost_vdpa_listener_region_del(v, iova,
>>           int128_get64(int128_sub(llend, int128_one())));
> 


