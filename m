Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B247E3812
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:46:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Ieg-0001yx-Em; Tue, 07 Nov 2023 04:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0IeH-0001la-S8
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:45:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0IeF-000611-OG
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699350326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NyDiqNvjUf3gtn/SezsxiMrXNXVGVgfOUkU5if9omOE=;
 b=XKFT4U5eAG0p3OgDgNQTbCaBMCLl3NjbVq/ATczuBQQsd+HDCB3oLDnIXIUeQdq3/qEkUL
 GqnsxlvfDTRFO7s2Ta83ttq6iImYGwHjVcmbj9/7zIPP9l2xcf6CPwIRPGKqgywImlcZIr
 fMBK3JgFLPyQSzSPPpc1KMfsYy9xVVM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-Dniwj8v9O0O4R-qGHyea5A-1; Tue, 07 Nov 2023 04:45:22 -0500
X-MC-Unique: Dniwj8v9O0O4R-qGHyea5A-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66d03dcdc6bso66680366d6.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 01:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699350322; x=1699955122;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NyDiqNvjUf3gtn/SezsxiMrXNXVGVgfOUkU5if9omOE=;
 b=IvtqHcm6Xm5VGClvC1fE4mGrIBzFcuDzWd90VJ8XpWFsIhOLG15k2PJnpBa+KeK1nN
 DScPCzAAFREWcM8+ix7FUyTB6/YiRvQAKSPe+kvSdgutzKa18H+kSD9spaQIfGhJWQj+
 ARa8EoYkY9LLHosFlxkNxB1uYXAp3XK8cro9BSPAp41jRH6rWjYqaLn978IbG79JA5Ff
 yplKW+JzhNz3QM+rgzMMEx7mlUVe4YkVdaQe7YRVQ4w49i6X0GdgDu3ir3wTZmL7g2wL
 Rap+1kdiW66e3j2ckvdsLa9yoPKGeyor97VWk4L0zZX2HvR56GhFpRvtorclL9uxJcjp
 xGdA==
X-Gm-Message-State: AOJu0YxNvgF/+EPWRrkeB860dJL5EJO7QAHy82up2iFY3XjA0ERwMDTv
 TLMgHMbWH0c3Ttg8P4P4A3/vaqanMxSITatgDHT2TKZJjYcFrglAOsINPlBBBZeCh8U7F/KkZId
 uYWFJiM4oMc80iiw=
X-Received: by 2002:ad4:5747:0:b0:63d:3bea:f663 with SMTP id
 q7-20020ad45747000000b0063d3beaf663mr41545725qvx.47.1699350322271; 
 Tue, 07 Nov 2023 01:45:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEbYSCL+X580uUbi7EK3CTl1SGa2o1NN8rkmQhHXXuJ4hZigew5LioYyhZcAVr0tQa1b26fA==
X-Received: by 2002:ad4:5747:0:b0:63d:3bea:f663 with SMTP id
 q7-20020ad45747000000b0063d3beaf663mr41545717qvx.47.1699350322075; 
 Tue, 07 Nov 2023 01:45:22 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-179-224.web.vodafone.de.
 [109.43.179.224]) by smtp.gmail.com with ESMTPSA id
 s8-20020ad45248000000b00670867d7bdfsm4206753qvq.122.2023.11.07.01.45.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 01:45:21 -0800 (PST)
Message-ID: <f9a4c0bd-347e-4f26-9690-c27a6266a1e9@redhat.com>
Date: Tue, 7 Nov 2023 10:45:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/sclp: fix SCLP facility map
Content-Language: en-US
To: Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20231024100703.929679-1-hca@linux.ibm.com>
 <0cb53eda95889a41d485b993003a10600a7d4424.camel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <0cb53eda95889a41d485b993003a10600a7d4424.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 02/11/2023 19.50, Eric Farman wrote:
> (+cc qemu-devel)
> 
> On Tue, 2023-10-24 at 12:07 +0200, Heiko Carstens wrote:
>> Qemu's SCLP implementation incorrectly reports that it supports CPU
>> reconfiguration. If a guest issues a CPU reconfiguration request it
>> is rejected as invalid command.
>>
>> Fix the SCLP_HAS_CPU_INFO mask, and remove the unused
>> SCLP_CMDW_CONFIGURE_CPU and SCLP_CMDW_DECONFIGURE_CPU defines.
>>
>> Reviewed-by: Eric Farman <farman@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
>> ---
>>   include/hw/s390x/sclp.h | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Thomas, any concerns? Could this get picked up for 8.2, please?

Sorry, been away from keyboard for the last 10 days... queued it now!

  Thomas


>>
>> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
>> index 9aef6d937012..b4ecd04e2341 100644
>> --- a/include/hw/s390x/sclp.h
>> +++ b/include/hw/s390x/sclp.h
>> @@ -38,10 +38,8 @@
>>   #define MAX_STORAGE_INCREMENTS                  1020
>>   
>>   /* CPU hotplug SCLP codes */
>> -#define SCLP_HAS_CPU_INFO
>> 0x0C00000000000000ULL
>> +#define SCLP_HAS_CPU_INFO
>> 0x0800000000000000ULL
>>   #define SCLP_CMDW_READ_CPU_INFO                 0x00010001
>> -#define SCLP_CMDW_CONFIGURE_CPU                 0x00110001
>> -#define SCLP_CMDW_DECONFIGURE_CPU               0x00100001
>>   
>>   /* SCLP PCI codes */
>>   #define SCLP_HAS_IOA_RECONFIG
>> 0x0000000040000000ULL



