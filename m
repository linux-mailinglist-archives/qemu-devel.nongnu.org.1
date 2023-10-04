Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D497B7DCF
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 13:09:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnzkP-00079u-CQ; Wed, 04 Oct 2023 07:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qnzk1-0006vq-S4
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qnzjz-00047w-Mn
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696417711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nivnr0iv1DS2BqjL93n1UyJaBBNCY4t/SkIQNAI3BAo=;
 b=X6cxpOEwTgh2guxnef03oWOe0HkARwgtarsOIKatWJwlGRR2ugh60wq0NXzgzGpBhLjiWd
 olXe71UM9VZdMnF+IFzs2Ycsv8Ibvw6OjmVT/DTo4XtkAj0v/GZXRhioTdYYnE0ZgNG+g3
 p9gnD0GWFPhFe44gbfFho5vjnxgP28w=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-YqOZHWjJNlumJ0eSa_WfwQ-1; Wed, 04 Oct 2023 07:08:29 -0400
X-MC-Unique: YqOZHWjJNlumJ0eSa_WfwQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7740c8048bbso117561785a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 04:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696417708; x=1697022508;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nivnr0iv1DS2BqjL93n1UyJaBBNCY4t/SkIQNAI3BAo=;
 b=v4FUEyyhc+Fn0p650i0bfZC/K5eCpgd6lGBwjeeO9hJW0igrEfvOf2sqVtVbLev6cu
 81MASYnd9Pn2AaoyNuUUt8FLnqVhS1+HIhOW9pXdPOU6AKOOYMNJ3MW2Nuc2/Q9YUoGw
 ynHkX1PwqYtWz7PCFInCYTzI7jl686/8Slv+pajJrYwewZHbFvQUclCVhdxGvPwrFz5N
 ojOrz8ba8owRIwAZPGjA4438tpawnR2ND+lowtygZ2KXvIvKqnGJM1TAV8/bRb86SAXO
 kcitFN9plewlsNR0Vu+ovzqTxtWKtC67ER1a1aScQ3OkIfklE6G6e7NXHs8zpgVhR+f4
 4pFQ==
X-Gm-Message-State: AOJu0Yy8xmJnKfGiY6g3iIsM7DSsV+O276SKrxVmEoUa1MByMi/HFwRr
 tHfJ2Uj9MYLxdo504XmT2oPIJrIodqOabhN86y3MQyq1MOXeFNOkQ4Y2o9Wz8fdEl8b65v6UyG/
 g+kUAL2u5za1LlgY=
X-Received: by 2002:a05:620a:459e:b0:774:2afe:97c4 with SMTP id
 bp30-20020a05620a459e00b007742afe97c4mr6697322qkb.12.1696417708726; 
 Wed, 04 Oct 2023 04:08:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFiXF483LQ36s9drVpxH0l+D4gmvYbLYuJlcYrnHwN2Lkt0CfPSCKHMXFZQ7J9MjzJZ4UH8A==
X-Received: by 2002:a05:620a:459e:b0:774:2afe:97c4 with SMTP id
 bp30-20020a05620a459e00b007742afe97c4mr6697300qkb.12.1696417708477; 
 Wed, 04 Oct 2023 04:08:28 -0700 (PDT)
Received: from [10.33.192.181] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 g27-20020a05620a13db00b00770f3e5618esm1173943qkl.101.2023.10.04.04.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 04:08:28 -0700 (PDT)
Message-ID: <c3e2e15d-f4dd-a5bd-eab7-f4db9f93626e@redhat.com>
Date: Wed, 4 Oct 2023 13:08:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/virtio/virtio-pci: Avoid compiler warning with -Wshadow
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org
References: <20231004075536.48219-1-thuth@redhat.com>
 <87bkdeiri9.fsf@pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <87bkdeiri9.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 04/10/2023 12.58, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> "len" is used as parameter of the function virtio_write_config()
>> and as a local variable, so this causes a compiler warning
>> when compiling with "-Wshadow" and can be confusing for the reader.
>> Rename the local variable to "caplen" to avoid this problem.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/virtio/virtio-pci.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index edbc0daa18..d0ef1edd66 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -780,15 +780,15 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
>>                                                                     pci_cfg_data),
>>                          sizeof cfg->pci_cfg_data)) {
>>           uint32_t off;
>> -        uint32_t len;
>> +        uint32_t caplen;
>>   
>>           cfg = (void *)(proxy->pci_dev.config + proxy->config_cap);
>>           off = le32_to_cpu(cfg->cap.offset);
>> -        len = le32_to_cpu(cfg->cap.length);
>> +        caplen = le32_to_cpu(cfg->cap.length);
>>   
>> -        if (len == 1 || len == 2 || len == 4) {
>> -            assert(len <= sizeof cfg->pci_cfg_data);
>> -            virtio_address_space_write(proxy, off, cfg->pci_cfg_data, len);
>> +        if (caplen == 1 || caplen == 2 || caplen == 4) {
>> +            assert(caplen <= sizeof cfg->pci_cfg_data);
>> +            virtio_address_space_write(proxy, off, cfg->pci_cfg_data, caplen);
>>           }
>>       }
>>   }
> 
> I see the same warning in virtio_read_config().  Care to patch that,
> too?

Patch is already on the list:
https://lore.kernel.org/qemu-devel/20231004095302.99037-1-thuth@redhat.com/

  Thomas



