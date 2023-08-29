Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EB578C9EB
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:51:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1vS-0000o8-12; Tue, 29 Aug 2023 12:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb1vQ-0000nz-37
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:50:44 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb1vN-0002fq-Ls
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:50:43 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bf3a2f4528so36331385ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693327839; x=1693932639;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dlGPxNJs1rYJb4lGGefgNFLnY2Gy2Osh8nfAMBl8a2g=;
 b=u4ZqePS+2eFTpm6aQ4/zTIvTlbBy1aGw9+tAN7cdMJTvVFgq2qEExPokst3mrRlgFH
 WN80GwpbnJQ8qShdsJBmObtKuefLdTfjtETXicBnJrPJfLsE3m2gKxp+Qa04j2/4QF+J
 g7uRVTEY4X9cbinnvTWg/VF8K08isPdjy1tzA4rSeCvMdG4vDkWRj5gmfDi6LEdoIdKR
 xNeZ3QwA0iAP6OJxk3pT4f9JJ36xns8jLSd4b5qlQNZCQ8GgYlE/IO5Lea7F6ULgvjtr
 6L/3fsu4y8EdT4u7Q012ZBDDUooMof6iEkpTTtqvZsdVEoULNt6o1kKuzeGAulQh4+9Q
 nw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693327839; x=1693932639;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dlGPxNJs1rYJb4lGGefgNFLnY2Gy2Osh8nfAMBl8a2g=;
 b=ZhKzRP68Cuibwpzeg3CGfMG/TljEIG4X0GII5TtuZie4HGoe+nrzq7ELGY9wJam/zz
 1jjOpbVXvpIyRJk39qQ09rvYroqOKWD3YEYBIHK0lyWh1BSm63qGknL0dPEL//hifvTq
 s3y9DpFmcChGA2WLxNGfzHSJ1pjvrbDjOCzSSO2fqEKaby4ORI08KMGODQ7kcJUWlHMJ
 0v97V8E+WdqApImsN+X/27sda+LIswPELB+lgcyFu5egfkwg19BfKkMN56Fh7Mu9rKHF
 OvbepUYuudBbUHhJAbnTGblnvyI2hO+uM8S+eDgyKTI9RLE/O9+AWGffUJXhvjMJqngB
 PHTQ==
X-Gm-Message-State: AOJu0YxwPJSOeYnlDl9PSblXmkJyVIqqV8gh4IRIZTvATxb3aG9k+jPu
 9kj2sAS3Ct/8SV7RLHf5sJGLoMqNLrpbNSFjImM=
X-Google-Smtp-Source: AGHT+IHsmWcfPyFO9MxkDjWhn6FDm4QdInv2gpLvJX64E8DQ2vITB7ZgGZFQ4wPzCkmxMruhyIGLNw==
X-Received: by 2002:a17:902:d4c3:b0:1b8:987f:3f34 with SMTP id
 o3-20020a170902d4c300b001b8987f3f34mr37092364plg.25.1693327838999; 
 Tue, 29 Aug 2023 09:50:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 jd14-20020a170903260e00b001b03a1a3151sm9572892plb.70.2023.08.29.09.50.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 09:50:38 -0700 (PDT)
Message-ID: <b0fd3765-af78-9c7b-02e4-bd6304a3d029@linaro.org>
Date: Tue, 29 Aug 2023 09:50:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/6] hw/virtio/vhost-vdpa: Use target-agnostic
 qemu_target_page_mask()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230710094931.84402-1-philmd@linaro.org>
 <20230710094931.84402-5-philmd@linaro.org>
 <e24e67e0-fd01-6374-3bb7-1a73a35b48da@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e24e67e0-fd01-6374-3bb7-1a73a35b48da@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/18/23 04:00, Philippe Mathieu-Daudé wrote:
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


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
>> @@ -313,9 +313,11 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>       Int128 llend, llsize;
>>       void *vaddr;
>>       int ret;
>> +    int page_size = qemu_target_page_size();
>> +    int page_mask = -page_size;
>>       if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
>> -                                            v->iova_range.last, TARGET_PAGE_MASK)) {
>> +                                            v->iova_range.last, page_mask)) {
>>           return;
>>       }
>>       if (memory_region_is_iommu(section->mr)) {
>> @@ -323,14 +325,14 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>           return;
>>       }
>> -    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
>> -                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
>> +    if (unlikely((section->offset_within_address_space & ~page_mask) !=
>> +                 (section->offset_within_region & ~page_mask))) {
>>           error_report("%s received unaligned region", __func__);
>>           return;
>>       }
>> -    iova = ROUND_UP(section->offset_within_address_space, TARGET_PAGE_SIZE);
>> -    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
>> +    iova = ROUND_UP(section->offset_within_address_space, page_size);
>> +    llend = vhost_vdpa_section_end(section, page_mask);
>>       if (int128_ge(int128_make64(iova), llend)) {
>>           return;
>>       }
>> @@ -396,23 +398,25 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
>>       hwaddr iova;
>>       Int128 llend, llsize;
>>       int ret;
>> +    int page_size = qemu_target_page_size();
>> +    int page_mask = -page_size;
>>       if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
>> -                                            v->iova_range.last, TARGET_PAGE_MASK)) {
>> +                                            v->iova_range.last, page_mask)) {
>>           return;
>>       }
>>       if (memory_region_is_iommu(section->mr)) {
>>           vhost_vdpa_iommu_region_del(listener, section);
>>       }
>> -    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
>> -                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
>> +    if (unlikely((section->offset_within_address_space & ~page_mask) !=
>> +                 (section->offset_within_region & ~page_mask))) {
>>           error_report("%s received unaligned region", __func__);
>>           return;
>>       }
>> -    iova = ROUND_UP(section->offset_within_address_space, TARGET_PAGE_SIZE);
>> -    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
>> +    iova = ROUND_UP(section->offset_within_address_space, page_size);
>> +    llend = vhost_vdpa_section_end(section, page_mask);
>>       trace_vhost_vdpa_listener_region_del(v, iova,
>>           int128_get64(int128_sub(llend, int128_one())));
> 


