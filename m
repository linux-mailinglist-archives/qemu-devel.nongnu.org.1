Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C28DF706E33
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:32:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzK4G-0002It-4X; Wed, 17 May 2023 12:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzK4B-0002Gs-TS
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzK49-0005kw-7N
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684341111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxgqhD5vPKGXm74+5tq/Sk3g29Gbqys16Si0q6/CbTA=;
 b=SDLQByQCAd38iN1ZQ0I2hXhovBFHrtkkh0Sp7ECqJE1Stb6bD/pdwPIjSg8RfnK3pSotnJ
 4D1p97UKZgGGCyuwEvDyqVkltBLXVQ2QocizTks1mcTK7BBue7jaRGNkvtw/Tf79cJdGiu
 uxKoyeg52RocqZBcYoXtoqWfVbjw3qI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-7aysI4mfO_ytemmepbFDwA-1; Wed, 17 May 2023 12:31:50 -0400
X-MC-Unique: 7aysI4mfO_ytemmepbFDwA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f426ffdbc6so6032945e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 09:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684341108; x=1686933108;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rxgqhD5vPKGXm74+5tq/Sk3g29Gbqys16Si0q6/CbTA=;
 b=e2mNJktkqs2gt6v5fadxHjNoMMtCtryoh/VAvD7qYXQsfbzSclGpPNDgBJ72HDgq+V
 hWzoeodiKnTDCpZFiw5dk/8MM+KyNSA5qIDi5z7+1HXso0fS3dYWqAk5h/S6/J9jvG/6
 k+6EGMF36E2/0dUdN0SOcfgu3gNYKuhgHUHZxyHCUNzWvou7Uaaxun+cmr939HpZumFx
 6Iv6nTL5hnL+bQu030+fLQxIQk8vvRZ2MyqS+s2v4ysRJPoX1BJTwqjuC4sp6TAFbPhI
 eVQwrO88j3w3hwqRZhJxLqzPKes8EqBxPo/F4hpt/SCZd8tM6PFZwm3k8vtty8OgE/oN
 8gHg==
X-Gm-Message-State: AC+VfDwwIKs4yvfUo1daK5QA0RjVngXIXliz9p5mtAIUqWIdbfOMX66I
 kvOBNlLxPi6+tGbtlmQpO9ovfqXXdF2JTZy1eC3eUYIUkpZwjdkqkTYLeG7QRLQD4aG5JOpsM7o
 4+S3S3RA7u9fnEeo=
X-Received: by 2002:a05:600c:258:b0:3f4:20ec:75f1 with SMTP id
 24-20020a05600c025800b003f420ec75f1mr27086220wmj.33.1684341107882; 
 Wed, 17 May 2023 09:31:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7bQL4wZxurpluOP+L/BEvq9M27EZpGJA4IxSVJ/MSSukfy++k2D+dEs61D6Av7nOSDR2HQWQ==
X-Received: by 2002:a05:600c:258:b0:3f4:20ec:75f1 with SMTP id
 24-20020a05600c025800b003f420ec75f1mr27086204wmj.33.1684341107506; 
 Wed, 17 May 2023 09:31:47 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 d22-20020a1c7316000000b003f09d7b6e20sm2750796wmb.2.2023.05.17.09.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 09:31:46 -0700 (PDT)
Message-ID: <21f5725b-2b05-a233-6289-617c17dffd11@redhat.com>
Date: Wed, 17 May 2023 18:31:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] softmmu/ioport.c: QOMify MemoryRegionPortioList
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230419151652.362717-1-mark.cave-ayland@ilande.co.uk>
 <20230419151652.362717-3-mark.cave-ayland@ilande.co.uk>
 <68cca2b7-a61f-325b-2a45-33d6f3bb0c24@linaro.org>
 <b03cac1d-33d9-5f2f-1f29-3fc566dcdf3f@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <b03cac1d-33d9-5f2f-1f29-3fc566dcdf3f@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.412, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/11/23 16:43, Mark Cave-Ayland wrote:
>>>
>>> +#define TYPE_MEMORY_REGION_PORTIO_LIST "memory-region-portio-list"
>>
>> Possibly simpler as: TYPE_MEMORY_REGION_PORTIO "memory-region-portio"
> 
> I'm a little undecided about this one: the ports field contains an array 
> of MemoryRegionPortio entries e.g. 
> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/ide/ioport.c#L31 
> so I considered that the QOM object contains a list of 
> MemoryRegionPortios. TYPE_MEMORY_REGION_PORTIO_LIST feels a better fit 
> here since it reflects this whilst also matching the existing 
> MemoryRegionPortioList struct name.

I agree, using memory-region-portio would be confusing given the name of 
the struct.

Paolo


