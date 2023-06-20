Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F12736D95
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 15:42:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBbbV-0003I8-9D; Tue, 20 Jun 2023 09:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qBbbO-0003FR-99
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qBbbM-0000TI-Mk
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687268455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tC3qdFtTdeycT8afpwZwMdQp6ocXNX/FZs91WkGcpJE=;
 b=Ut9ruH2XESmw+uqxwbtiYYRF3WM0zYBs3Fsf46Sa8a5c8bPq6MPlpoprrMqKOqGgxrIP3P
 noJ31Wf0D3Q3M2iTBkTg2Y46eCiR6PmwA42BZdK4Z9bfXRWyZ6mTC01YRSUcml4oHudVp+
 LlNLvl3xyf5bJtpw/o2zZ8/QGjdrlBk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-pBNcVTXcOWeZje2iMVM__w-1; Tue, 20 Jun 2023 09:40:53 -0400
X-MC-Unique: pBNcVTXcOWeZje2iMVM__w-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f3932e595dso3235821e87.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 06:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687268447; x=1689860447;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tC3qdFtTdeycT8afpwZwMdQp6ocXNX/FZs91WkGcpJE=;
 b=DOiKFB+BSxWDIIdkchb8eUxYqbbG/yCSg5p8gYBsYutbBkPBnoyvMiQ6+D6t7YHkDR
 yU0WpDBjQuPUmatla2ZvJ4anGRO/ofkOrMhTJ1T0rwT7zSj1sAZVkcNVTC0NnlhdMpAN
 yZkIZLf/nKAcbi4m5OsmTk236vROtegxhG0UwpSZ5gFO1qbXxlTpHi4TAg4It3cmTRsW
 DZCawdsmNKPyr5ivMjPJ4lOzz/xoXxFrkHAvyeZavBZTAyAzjlX7mhTD5iJgh+14IYR9
 2s3fvA3hqVlu8m4srD9jrr+zfJR+j0SJbnn0bwRqpGJmnOOTXF8yfIF1+w7NELeJRdxJ
 bVkA==
X-Gm-Message-State: AC+VfDzUlYmkL3yd6xdSrbq6jqBpKTYnuXRnvpTZzoZkKyPe8jx4DVeo
 k8XYNJIY/Gv+6oX28gnG1cr+PAprxYhGtsdploYy98SbQfsLMCv3P1RX5g6wDuK+OvnaWdrDTkF
 7mVSVx+MRBvrU1xc=
X-Received: by 2002:a05:6512:446:b0:4f8:47e9:ad90 with SMTP id
 y6-20020a056512044600b004f847e9ad90mr8859375lfk.35.1687268446705; 
 Tue, 20 Jun 2023 06:40:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73sHvmwBXS59zi6SFmyClCbYF78zJD5sd0iwdyRaxQdCB75vwJaHKfHrHQrCS2VI/tukw1vQ==
X-Received: by 2002:a05:6512:446:b0:4f8:47e9:ad90 with SMTP id
 y6-20020a056512044600b004f847e9ad90mr8859352lfk.35.1687268446317; 
 Tue, 20 Jun 2023 06:40:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:d200:8745:c520:8bf6:b587?
 (p200300cbc739d2008745c5208bf6b587.dip0.t-ipconnect.de.
 [2003:cb:c739:d200:8745:c520:8bf6:b587])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a7bc050000000b003f080b2f9f4sm13494996wmc.27.2023.06.20.06.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 06:40:45 -0700 (PDT)
Message-ID: <9cf21743-17b3-45f7-6fdb-e2d8a53f8c39@redhat.com>
Date: Tue, 20 Jun 2023 15:40:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 4/4] virtio-mem: Support "x-ignore-shared" migration
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>
References: <20230620130354.322180-1-david@redhat.com>
 <20230620130354.322180-5-david@redhat.com>
 <20230620090527-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230620090527-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20.06.23 15:06, Michael S. Tsirkin wrote:
> On Tue, Jun 20, 2023 at 03:03:54PM +0200, David Hildenbrand wrote:
>> To achieve desired "x-ignore-shared" functionality, we should not
>> discard all RAM when realizing the device and not mess with
>> preallocation/postcopy when loading device state. In essence, we should
>> not touch RAM content.
>>
>> As "x-ignore-shared" gets set after realizing the device, we cannot
>> rely on that. Let's simply skip discarding of RAM on incoming migration.
>> Note that virtio_mem_post_load() will call
>> virtio_mem_restore_unplugged() -- unless "x-ignore-shared" is set. So
>> once migration finished we'll have a consistent state.
>>
>> The initial system reset will also not discard any RAM, because
>> virtio_mem_unplug_all() will not call virtio_mem_unplug_all() when no
>> memory is plugged (which is the case before loading the device state).
>>
>> Note that something like VM templating -- see commit b17fbbe55cba
>> ("migration: allow private destination ram with x-ignore-shared") -- is
>> currently incompatible with virtio-mem and ram_block_discard_range() will
>> warn in case a private file mapping is supplied by virtio-mem.
>>
>> For VM templating with virtio-mem, it makes more sense to either
>> (a) Create the template without the virtio-mem device and hotplug a
>>      virtio-mem device to the new VM instances using proper own memory
>>      backend.
>> (b) Use a virtio-mem device that doesn't provide any memory in the
>>      template (requested-size=0) and use private anonymous memory.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   hw/virtio/virtio-mem.c | 47 ++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 38 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
>> index 9f6169af32..b013dfbaf0 100644
>> --- a/hw/virtio/virtio-mem.c
>> +++ b/hw/virtio/virtio-mem.c
>> @@ -18,6 +18,7 @@
>>   #include "sysemu/numa.h"
>>   #include "sysemu/sysemu.h"
>>   #include "sysemu/reset.h"
>> +#include "sysemu/runstate.h"
>>   #include "hw/virtio/virtio.h"
>>   #include "hw/virtio/virtio-bus.h"
>>   #include "hw/virtio/virtio-access.h"
>> @@ -886,11 +887,23 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>>           return;
>>       }
>>   
>> -    ret = ram_block_discard_range(rb, 0, qemu_ram_get_used_length(rb));
>> -    if (ret) {
>> -        error_setg_errno(errp, -ret, "Unexpected error discarding RAM");
>> -        ram_block_coordinated_discard_require(false);
>> -        return;
>> +    /*
>> +     * We don't know at this point whether shared RAM is migrated using
>> +     * QEMU or migrated using the file content. "x-ignore-shared" will be
>> +     * configurated
> 
> configurated == configured?

Thanks!

-- 
Cheers,

David / dhildenb


