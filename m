Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F86E802903
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 00:32:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9vvk-0004O3-Mk; Sun, 03 Dec 2023 18:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r9vvY-0004NW-E1
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 18:31:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r9vvV-0004qd-1v
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 18:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701646263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4sLLt6RkTxm9WrXH5ATrYIbizpJhKLEMffigQpTnVYU=;
 b=J2lXrwwToEWvUtVFfXhMmIMJHC2UZNWachd7QHF8gGCyCIB2itdYS68ihiOQjM7yOcuP8F
 hCCnDx0hKYMpujdsHXFq+j9QlAgczmqqi1d1nkfjVq1I9ss6HEmGmEvcCV+P6P+vPeXKe+
 6kElZG4uT7pnGqby+AFCKFgoIBHVEr0=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-LBoetFCNOzaLGfNMjwmSjw-1; Sun, 03 Dec 2023 18:31:02 -0500
X-MC-Unique: LBoetFCNOzaLGfNMjwmSjw-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3b897ce666fso3875254b6e.2
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 15:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701646261; x=1702251061;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4sLLt6RkTxm9WrXH5ATrYIbizpJhKLEMffigQpTnVYU=;
 b=JDRYpawIb8plaqiiAeIxvukmuliuN+9V3uHtOFDGpUe+HW1Mo32AUUZji6dcCPqupg
 LwwQ7mPJ/tKkNAa1lG9xi5fkJhMoyCNPvpklHhuKX0RJDZ5Looc0DjTKQHz9l9zPAu4J
 EMCUw0AEqu6WWtbe6dCiKIrs/5Oj1e6k1xC8fHWPDkk275gyx4OZYiB72HTAUAoKf4XL
 sl9rQpaWfZai42CKYR5UzhF/USv7Bf0gar+RHv4d0w5AHZxVSXTwbRqxmUAK3pggtmlU
 mXFFVKrMadzMkb0r9Rskemg7LctztAzQ/eHCqllvpQ5GSw/ysOGnE8iQnRchcWPjF+n1
 Dfmw==
X-Gm-Message-State: AOJu0YwsIhnm/5PLm9SwglM1i+P6GggOQ4BkLgOSMvW1togVag04SFAK
 x91CzftuFVAfTlqiXg6y/uepu/wHvdne7bfomwrz6MiPgELemej9Y24FVLd4o2SPKQKsQ9e7KNt
 4HxefG7I/1qHAVAY=
X-Received: by 2002:a05:6808:208d:b0:3b8:b063:8240 with SMTP id
 s13-20020a056808208d00b003b8b0638240mr3976561oiw.66.1701646261761; 
 Sun, 03 Dec 2023 15:31:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhEho2lC2hhiZ0uNveEsIYpaarciAvGgblC8zjUYspRg44rYo0kjuZpS7Xbi1ql3kWZAhnfQ==
X-Received: by 2002:a05:6808:208d:b0:3b8:b063:8240 with SMTP id
 s13-20020a056808208d00b003b8b0638240mr3976534oiw.66.1701646261562; 
 Sun, 03 Dec 2023 15:31:01 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 x21-20020aa793b5000000b006ce4c7ba43fsm1046633pff.120.2023.12.03.15.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 15:31:01 -0800 (PST)
Message-ID: <fbcf6473-9961-4d42-a961-d87e99e46351@redhat.com>
Date: Mon, 4 Dec 2023 09:30:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/9] machine: Improve is_cpu_type_supported()
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, b.galvani@gmail.com, strahinja.p.jankovic@gmail.com,
 sundeep.lkml@gmail.com, kfting@nuvoton.com, wuhaotsh@google.com,
 nieklinnenbank@gmail.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, vijai@behindbytes.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com
References: <20231129042012.277831-1-gshan@redhat.com>
 <20231129042012.277831-4-gshan@redhat.com>
 <83046c42-1df3-499e-b202-b123391d39cb@linaro.org>
 <fa0e8be7-8f18-4d74-ad5d-6dc44d375d2d@redhat.com>
In-Reply-To: <fa0e8be7-8f18-4d74-ad5d-6dc44d375d2d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Phil,

On 12/4/23 09:20, Gavin Shan wrote:
> On 12/1/23 20:57, Philippe Mathieu-Daudé wrote:
>> On 29/11/23 05:20, Gavin Shan wrote:
>>> It's no sense to check the CPU type when mc->valid_cpu_types[0] is
>>> NULL.
>>
>> This case is a programming error, right? We should simply:
>>
>>   assert(!mc->valid_cpu_types || *mc->valid_cpu_types);
>>
> 
> Yes, assert() should be used instead. I will do this like below:
> 
>      if (mc->valid_cpu_types && machine->cpu_type) {
>          assert(mc->valid_cpu_types[1] != NULL);
> 

I meant assert(mc->valid_cpu_types[0] != NULL) and sorry for the confusion.

       if (mc->valid_cpu_types && machine->cpu_type) {
           assert(mc->valid_cpu_types[0] != NULL);
           :
       }

> 
>>> So the check is skipped for this particular case. The constraint
>>> has been taken when the error messags are appended.
>>>
>>> A precise hint for the error message is given when mc->valid_cpu_types[0]
>>> is the only valid entry. Besides, enumeration on mc->valid_cpu_types[0]
>>> when we have mutiple valid entries there is avoided to increase the code
>>> readability, as suggested by Philippe Mathieu-Daudé.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   hw/core/machine.c | 18 ++++++++++++------
>>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>

Thanks,
Gavin


