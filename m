Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FD67511BB
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 22:15:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJgF1-0007AQ-TK; Wed, 12 Jul 2023 16:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qJgEy-0007AE-0z
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 16:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qJgEs-0003Iq-PI
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 16:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689192905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjXct6QyHMgUfqhtTgEk0R9CeSHqsm0bJ7QiO4uTmfE=;
 b=OWV7D5gelP/B8+BYl2JW6fiGaEvzJ8wmDxedCb+tW4AZ8mA//Bv9KEDmhC18s4yFXg1PCW
 fFX0ilRGrNQWGnZK85N2qHOkVn9UWkrGOpBIVQVj+i7e8fR50Iz1P418DB+cR6gEA+5N/B
 Q1LvMaF+XV84TwJp4DKsIr2vUS+Thr4=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-8Eiwhlh_OHamCFbKCK7a1A-1; Wed, 12 Jul 2023 16:15:04 -0400
X-MC-Unique: 8Eiwhlh_OHamCFbKCK7a1A-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-793fbd392c2so1381842241.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 13:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689192904; x=1691784904;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rjXct6QyHMgUfqhtTgEk0R9CeSHqsm0bJ7QiO4uTmfE=;
 b=SK7VVVD/4EYaP27iDFMJxUB4Yf+qyE0JJHAwG1+JLZsaDuxSyaJaA2xMkJ46G952Lr
 ttHcGolu+0n3qmKrEcZAgTWJEu/J3y0Rdh6BniHy/7oXoE2LQU1NWN5Vyr8CiQ5tgUd1
 cjdBhw/Kkxe/cDBqTO4U53ozUoPs86NlzYrJSXYAnb7T5kzB7a0yXJ9zOCbNfP1i/KFQ
 kdhqM6t/MSPY0wj2oDMcjSeKCQbjkJ6G7/fJI0x94GAYpJmDHfJQSLRUO2phplI6EK8/
 /zcS2mGsRbJuuYRa4TF4Fmc7S6TU7f3DbgNFwbOw6XVTrKDRhHZxjGxFLeYh/xXE7W3p
 AtkQ==
X-Gm-Message-State: ABy/qLaJfPT2TuOA9hNLfuAnKCa5Q30lVow1Y1NsT6mUa/HW1v9vqZed
 PGLM+eCRI2IG8oWrHaWESifQ/NL5q9t+X7BnvPYOoeICTURP3hdp0Dhd5hWmCptWOZnVUZStqaE
 vVUXhirQZU7VbY5A=
X-Received: by 2002:a05:6102:34e8:b0:444:17aa:df60 with SMTP id
 bi8-20020a05610234e800b0044417aadf60mr11395493vsb.13.1689192904107; 
 Wed, 12 Jul 2023 13:15:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFVtFy0Lt61ytlue3Jw7sp5oSlCsS3zt2wE42+BBpCVNmjdJZmcZFIAIfS/ZBqq5gpdlFT53w==
X-Received: by 2002:a05:6102:34e8:b0:444:17aa:df60 with SMTP id
 bi8-20020a05610234e800b0044417aadf60mr11395473vsb.13.1689192903776; 
 Wed, 12 Jul 2023 13:15:03 -0700 (PDT)
Received: from [192.168.8.101] (tmo-097-78.customers.d1-online.com.
 [80.187.97.78]) by smtp.gmail.com with ESMTPSA id
 t10-20020a0ce2ca000000b0062618962ec0sm2435777qvl.133.2023.07.12.13.14.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 13:15:03 -0700 (PDT)
Message-ID: <6a302f29-9b46-2a5f-c1e2-7f72b38f0f6d@redhat.com>
Date: Wed, 12 Jul 2023 22:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v21 03/20] target/s390x/cpu topology: handle STSI(15) and
 build the SYSIB
Content-Language: en-US
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org,
 frankja@linux.ibm.com, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-4-pmorel@linux.ibm.com>
 <aef8accb-3576-2b10-a946-191a6be3e3e0@redhat.com>
 <b1768b7b-301d-8208-8b31-8ddef378f216@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <b1768b7b-301d-8208-8b31-8ddef378f216@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.11, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/07/2023 16.24, Pierre Morel wrote:
> 
> On 7/4/23 13:40, Thomas Huth wrote:
>> On 30/06/2023 11.17, Pierre Morel wrote:
>>> On interception of STSI(15.1.x) the System Information Block
>>> (SYSIB) is built from the list of pre-ordered topology entries.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>> ...
>>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>>> index 7ebd5e05b6..6e7d041b01 100644
>>> --- a/target/s390x/cpu.h
>>> +++ b/target/s390x/cpu.h
>>> @@ -569,6 +569,29 @@ typedef struct SysIB_322 {
>>>   } SysIB_322;
>>>   QEMU_BUILD_BUG_ON(sizeof(SysIB_322) != 4096);
>>>   +/*
>>> + * Topology Magnitude fields (MAG) indicates the maximum number of
>>> + * topology list entries (TLE) at the corresponding nesting level.
>>> + */
>>> +#define S390_TOPOLOGY_MAG  6
>>> +#define S390_TOPOLOGY_MAG6 0
>>> +#define S390_TOPOLOGY_MAG5 1
>>> +#define S390_TOPOLOGY_MAG4 2
>>> +#define S390_TOPOLOGY_MAG3 3
>>> +#define S390_TOPOLOGY_MAG2 4
>>> +#define S390_TOPOLOGY_MAG1 5
>>> +/* Configuration topology */
>>> +typedef struct SysIB_151x {
>>> +    uint8_t  reserved0[2];
>>> +    uint16_t length;
>>> +    uint8_t  mag[S390_TOPOLOGY_MAG];
>>> +    uint8_t  reserved1;
>>> +    uint8_t  mnest;
>>> +    uint32_t reserved2;
>>> +    char tle[];
>>> +} SysIB_151x;
>>> +QEMU_BUILD_BUG_ON(sizeof(SysIB_151x) != 16);
>>> +
>>>   typedef union SysIB {
>>>       SysIB_111 sysib_111;
>>>       SysIB_121 sysib_121;
>>> @@ -576,9 +599,62 @@ typedef union SysIB {
>>>       SysIB_221 sysib_221;
>>>       SysIB_222 sysib_222;
>>>       SysIB_322 sysib_322;
>>> +    SysIB_151x sysib_151x;
>>>   } SysIB;
>>>   QEMU_BUILD_BUG_ON(sizeof(SysIB) != 4096);
>>>   +/*
>>> + * CPU Topology List provided by STSI with fc=15 provides a list
>>> + * of two different Topology List Entries (TLE) types to specify
>>> + * the topology hierarchy.
>>> + *
>>> + * - Container Topology List Entry
>>> + *   Defines a container to contain other Topology List Entries
>>> + *   of any type, nested containers or CPU.
>>> + * - CPU Topology List Entry
>>> + *   Specifies the CPUs position, type, entitlement and polarization
>>> + *   of the CPUs contained in the last Container TLE.
>>> + *
>>> + * There can be theoretically up to five levels of containers, QEMU
>>> + * uses only three levels, the drawer's, book's and socket's level.
>>> + *
>>> + * A container with a nesting level (NL) greater than 1 can only
>>> + * contain another container of nesting level NL-1.
>>> + *
>>> + * A container of nesting level 1 (socket), contains as many CPU TLE
>>> + * as needed to describe the position and qualities of all CPUs inside
>>> + * the container.
>>> + * The qualities of a CPU are polarization, entitlement and type.
>>> + *
>>> + * The CPU TLE defines the position of the CPUs of identical qualities
>>> + * using a 64bits mask which first bit has its offset defined by
>>> + * the CPU address orgin field of the CPU TLE like in:
>>> + * CPU address = origin * 64 + bit position within the mask
>>> + *
>>> + */
>>> +/* Container type Topology List Entry */
>>> +typedef struct SysIBTl_container {
>>> +        uint8_t nl;
>>> +        uint8_t reserved[6];
>>> +        uint8_t id;
>>> +} SysIBTl_container;
>>
>> Why mixing CamelCase with underscore-style here? SysIBTlContainer would 
>> look more natural, I think?
> 
> 
> OK, what about SYSIBContainerListEntry ?

Sounds fine!

> 
>>
>>> +QEMU_BUILD_BUG_ON(sizeof(SysIBTl_container) != 8);
>>> +
>>> +/* CPU type Topology List Entry */
>>> +typedef struct SysIBTl_cpu {
>>> +        uint8_t nl;
>>> +        uint8_t reserved0[3];
>>> +#define SYSIB_TLE_POLARITY_MASK 0x03
>>> +#define SYSIB_TLE_DEDICATED     0x04
>>> +        uint8_t flags;
>>> +        uint8_t type;
>>> +        uint16_t origin;
>>> +        uint64_t mask;
>>> +} SysIBTl_cpu;
>>
>> dito, maybe better SysIBTlCpu ?
> 
> 
> What about SysIBCPUListEntry ?

Ack.

  Thomas



