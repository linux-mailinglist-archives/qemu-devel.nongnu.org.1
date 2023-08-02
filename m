Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A49A76CFCF
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 16:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRCc8-0003Zh-U8; Wed, 02 Aug 2023 10:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRCc5-0003Z7-Vz
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 10:14:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRCc4-0008Ta-DD
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 10:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690985646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+f7ohqmV94Vchze/rAHpPkOwnQK+0dCtslyM8j4wJ7Y=;
 b=Pfp0nS0KDxGbICLxGc7dBhXq1lfNRRm4zldlIBEUeCE84sBzkmLeXS8RpT3IzztU2s+Jnq
 8vWV1zpW/B2c1d2/iLO2WAKDkyXm5DQTwTfwQ04uH74/3mTBeQ83544AJtkQlx+uOilL0L
 7Nl/dnLbjHMt8UEX5lEJ6YbDsUTF//A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-kCPccsucPzOIztlHN0mb2w-1; Wed, 02 Aug 2023 10:14:05 -0400
X-MC-Unique: kCPccsucPzOIztlHN0mb2w-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7623d5cb0caso738593185a.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 07:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690985644; x=1691590444;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+f7ohqmV94Vchze/rAHpPkOwnQK+0dCtslyM8j4wJ7Y=;
 b=IqbW7wf7jfxVX2chtVEXk7iCizGskPBF9+i+4xpoSHLETZgHIQ9ICAk/EUS41sRUsS
 qj7/vPdd2FSOMutT2LkE24gGKn0toI+TJOU1aepd8hMOTnBhzVifZk2JyKJrvBsmU72d
 ycGVQi/49su3nk9vFO2+3hhtEsZ70UjURSceRAxUltFYMoSaG4cvfvEegJPaa6lD2Zu4
 ujmcF4ZC+IjQ/1UTanN//1bE/HbeNZkWCYf6iIA18qX4UdycyEo8fz2z71tiqG+31DI3
 l5osoPLvMcgUYLRzY6mF4djTpkoLvHeyOT4DSRG9awL6P5TjYm0JqcuS05r7mOzZRm2E
 tmcg==
X-Gm-Message-State: ABy/qLYSYY21DXK8h/0Fgc2XD4TynJmbfPtBdOQmQiB0qJmx/CHqeRoW
 iMh+HnJKAoLC7Lk5ZrN0wmB0rAx7LyWfNAYYM/kjU26fxWnYOVfKs8o6tvgCVd2VYl9mOeGeVps
 iQNOjfmXa2KISdCgFNef3R58=
X-Received: by 2002:a0c:f249:0:b0:63d:6330:b53a with SMTP id
 z9-20020a0cf249000000b0063d6330b53amr8727119qvl.52.1690985644819; 
 Wed, 02 Aug 2023 07:14:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlErlgYSnuWRGP3/zsC+xLIqPh2A3IC8NkhxvHzOVopgQ2zlRJIOG0hoEOOGr9CJ29reyq88Uw==
X-Received: by 2002:a0c:f249:0:b0:63d:6330:b53a with SMTP id
 z9-20020a0cf249000000b0063d6330b53amr8727101qvl.52.1690985644554; 
 Wed, 02 Aug 2023 07:14:04 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-230.web.vodafone.de.
 [109.43.178.230]) by smtp.gmail.com with ESMTPSA id
 h4-20020a0cf404000000b0063d4c39b3dbsm4607772qvl.112.2023.08.02.07.14.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 07:14:04 -0700 (PDT)
Message-ID: <231556af-02cd-a243-acdb-78cec6fd24a2@redhat.com>
Date: Wed, 2 Aug 2023 16:14:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/i386/intel_iommu: Fix endianness problems related to
 VTD_IR_TableEntry
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230802092837.153689-1-thuth@redhat.com> <ZMph6J8reFmxOpit@x1n>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <ZMph6J8reFmxOpit@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.102, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 02/08/2023 16.02, Peter Xu wrote:
> On Wed, Aug 02, 2023 at 11:28:37AM +0200, Thomas Huth wrote:
>>   #if HOST_BIG_ENDIAN
>> -        uint32_t __reserved_1:8;     /* Reserved 1 */
>> -        uint32_t vector:8;           /* Interrupt Vector */
>> -        uint32_t irte_mode:1;        /* IRTE Mode */
>> -        uint32_t __reserved_0:3;     /* Reserved 0 */
>> -        uint32_t __avail:4;          /* Available spaces for software */
>> -        uint32_t delivery_mode:3;    /* Delivery Mode */
>> -        uint32_t trigger_mode:1;     /* Trigger Mode */
>> -        uint32_t redir_hint:1;       /* Redirection Hint */
>> -        uint32_t dest_mode:1;        /* Destination Mode */
>> -        uint32_t fault_disable:1;    /* Fault Processing Disable */
>> -        uint32_t present:1;          /* Whether entry present/available */
>> +        uint64_t dest_id:32;         /* Destination ID */
>> +        uint64_t __reserved_1:8;     /* Reserved 1 */
>> +        uint64_t vector:8;           /* Interrupt Vector */
>> +        uint64_t irte_mode:1;        /* IRTE Mode */
>> +        uint64_t __reserved_0:3;     /* Reserved 0 */
>> +        uint64_t __avail:4;          /* Available spaces for software */
>> +        uint64_t delivery_mode:3;    /* Delivery Mode */
>> +        uint64_t trigger_mode:1;     /* Trigger Mode */
>> +        uint64_t redir_hint:1;       /* Redirection Hint */
>> +        uint64_t dest_mode:1;        /* Destination Mode */
>> +        uint64_t fault_disable:1;    /* Fault Processing Disable */
>> +        uint64_t present:1;          /* Whether entry present/available */
>>   #else
>> -        uint32_t present:1;          /* Whether entry present/available */
>> -        uint32_t fault_disable:1;    /* Fault Processing Disable */
>> -        uint32_t dest_mode:1;        /* Destination Mode */
>> -        uint32_t redir_hint:1;       /* Redirection Hint */
>> -        uint32_t trigger_mode:1;     /* Trigger Mode */
>> -        uint32_t delivery_mode:3;    /* Delivery Mode */
>> -        uint32_t __avail:4;          /* Available spaces for software */
>> -        uint32_t __reserved_0:3;     /* Reserved 0 */
>> -        uint32_t irte_mode:1;        /* IRTE Mode */
>> -        uint32_t vector:8;           /* Interrupt Vector */
>> -        uint32_t __reserved_1:8;     /* Reserved 1 */
>> +        uint64_t present:1;          /* Whether entry present/available */
>> +        uint64_t fault_disable:1;    /* Fault Processing Disable */
>> +        uint64_t dest_mode:1;        /* Destination Mode */
>> +        uint64_t redir_hint:1;       /* Redirection Hint */
>> +        uint64_t trigger_mode:1;     /* Trigger Mode */
>> +        uint64_t delivery_mode:3;    /* Delivery Mode */
>> +        uint64_t __avail:4;          /* Available spaces for software */
>> +        uint64_t __reserved_0:3;     /* Reserved 0 */
>> +        uint64_t irte_mode:1;        /* IRTE Mode */
>> +        uint64_t vector:8;           /* Interrupt Vector */
>> +        uint64_t __reserved_1:8;     /* Reserved 1 */
>> +        uint64_t dest_id:32;         /* Destination ID */
>>   #endif
>> -        uint32_t dest_id;            /* Destination ID */
>> -        uint16_t source_id;          /* Source-ID */
>>   #if HOST_BIG_ENDIAN
>>           uint64_t __reserved_2:44;    /* Reserved 2 */
>>           uint64_t sid_vtype:2;        /* Source-ID Validation Type */
>>           uint64_t sid_q:2;            /* Source-ID Qualifier */
>> +        uint64_t source_id:16;       /* Source-ID */
>>   #else
>> +        uint64_t source_id:16;       /* Source-ID */
>>           uint64_t sid_q:2;            /* Source-ID Qualifier */
>>           uint64_t sid_vtype:2;        /* Source-ID Validation Type */
>>           uint64_t __reserved_2:44;    /* Reserved 2 */
> 
> A quick comment before a repost: we can merge the two HOST_BIG_ENDIAN
> blocks into one now?

We could, and I also considered it while working on this. But I think it 
would rather decrease the readability of this code. These are two separete 
64-bit fields, and you might want to compare the big endian version of a 
bitfield to the little endian version next to it. If we merge, it looks 
rather like one big 128-bitfield if you don't look carefully enough, and 
comparision gets worse. So I'd prefer to keep them separate.

  Thomas



