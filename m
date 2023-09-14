Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF29979FD69
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:45:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgh2Q-0003ZW-HQ; Thu, 14 Sep 2023 03:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgh2L-0003Qc-Lx
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgh2C-000864-3k
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694677505;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ey42loVo3gWXID4VgE8l8LNjk2zLsdnZkbI3N9xhACE=;
 b=d+dxoG6RQfNrnxHx3PHctYsW00BkfiIi+BIjzGdo8FndEypjpmiE4Q9oaP+pSPdMlrA3Ta
 JTQJTTDZT01fFvXS/dvTNlhutrc26fNZVSBaXOiqNNmk7uSLdv/ShHEZON9ehTvDT/J+fr
 uM01jbTcJpBrU4A1Y7Ju/saLs6xmJjg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-7kwpOazFNSO_i3q9aX5eoA-1; Thu, 14 Sep 2023 03:45:03 -0400
X-MC-Unique: 7kwpOazFNSO_i3q9aX5eoA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31dc8f0733dso413398f8f.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 00:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694677503; x=1695282303;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ey42loVo3gWXID4VgE8l8LNjk2zLsdnZkbI3N9xhACE=;
 b=JsfWcFJ9YHCbdzigU7NV4ICRGCZQ49ATgQfr4hbt5jEdi3gIEUy0h/AJCTDjTFW+6b
 OuU8aTegyTD3HD5pHZ0mP/ucu9vs+GeCpDzhOwvksRIg8fV8LyFyJb4884fzeYfXvfjC
 swwKRWCWWsM8eEokfIoRa+OpOqiHe8SBR7TIEo74XONI4OoxtWrkQVxhVbjCU4xchXie
 IqN+o2NdRk9/ZLWI/BccDsbNZCV/cnfoZzeDlxU/vss7bNPYqDqbk9WFCsnCNeIm/NGQ
 /uNZzHrTVsa+hqYLqoekWZ6eY+AvjtQCc+HmWmFpimhsRoHZFDpQ9xIotd85Ip9jscym
 OYHQ==
X-Gm-Message-State: AOJu0YwvBTPX5Ut7kEYxkZ7CnQxlNvnZGP9XRsxCjkk9OE5y9GK9/b3X
 ouxC9loV6vbOdzw8qVa6GfBw4JlE/08Ewu991ByV6mSepw4E38dM6DNG9wgo4sSlFKqUnASP4bB
 jEl3+lV+PaRCJAX8=
X-Received: by 2002:a5d:6589:0:b0:319:84dd:4596 with SMTP id
 q9-20020a5d6589000000b0031984dd4596mr4274994wru.5.1694677502928; 
 Thu, 14 Sep 2023 00:45:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeZSoCJaX0YuLwEmWYUprK4XO6LoDeNivV+dYy3vjwu9XzqlVPGaxYnnkE9aoTEqIQ+KYP+g==
X-Received: by 2002:a5d:6589:0:b0:319:84dd:4596 with SMTP id
 q9-20020a5d6589000000b0031984dd4596mr4274970wru.5.1694677502499; 
 Thu, 14 Sep 2023 00:45:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 z8-20020a056000110800b0031f3ad17b2csm990297wrw.52.2023.09.14.00.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 00:45:01 -0700 (PDT)
Message-ID: <ff2fd1c8-f894-fb4b-fa21-323698ab352a@redhat.com>
Date: Thu, 14 Sep 2023 09:45:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] vhost: Add a defensive check in vhost_commit against
 wrong deallocation
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: eric.auger.pro@gmail.com, mst@redhat.com, qemu-devel@nongnu.org,
 lvivier@redhat.com
References: <20230913074657.523530-1-eric.auger@redhat.com>
 <CACGkMEttFn3eBfTPeumtfLuWnhZs7_4zKh6fP1jzyAb47GuQkQ@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CACGkMEttFn3eBfTPeumtfLuWnhZs7_4zKh6fP1jzyAb47GuQkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Jason,

On 9/14/23 05:46, Jason Wang wrote:
> On Wed, Sep 13, 2023 at 3:47 PM Eric Auger <eric.auger@redhat.com> wrote:
>> In vhost_commit(), it may happen that dev->mem_sections and
>> dev->tmp_sections are equal, in which case, unconditionally
>> freeing old_sections at the end of the function will also free
>> dev->mem_sections used on subsequent call leading to a segmentation
>> fault.
>>
>> Check this situation before deallocating memory.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Fixes: c44317efecb2 ("vhost: Build temporary section list and deref
>> after commit")
>> CC: QEMU Stable <qemu-stable@nongnu.org>
>>
>> ---
>>
>> This SIGSEV condition can be reproduced with
>> https://lore.kernel.org/all/20230904080451.424731-1-eric.auger@redhat.com/#r
>> This is most probably happening in a situation where the memory API is
>> used in a wrong manner but well.
> Any chance to move this to the memory API or we may end up with things
> like this in another listener?

I am not very familiar with the vhost code but aren't those tmp_sections
and mem_sections really specific to the vhost device? I am not sure we
can easily generalize.

Thanks

Eric
>
> Thanks
>
>> ---
>>  hw/virtio/vhost.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index e2f6ffb446..c02c599ef0 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -545,6 +545,11 @@ static void vhost_commit(MemoryListener *listener)
>>      dev->mem_sections = dev->tmp_sections;
>>      dev->n_mem_sections = dev->n_tmp_sections;
>>
>> +    if (old_sections == dev->mem_sections) {
>> +        assert(n_old_sections ==  dev->n_mem_sections);
>> +        return;
>> +    }
>> +
>>      if (dev->n_mem_sections != n_old_sections) {
>>          changed = true;
>>      } else {
>> --
>> 2.41.0
>>


