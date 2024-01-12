Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9A682BAAF
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 06:13:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO9q6-0003R9-Vk; Fri, 12 Jan 2024 00:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rO9q5-0003Ql-Ah
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 00:12:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rO9q3-0008Fe-QX
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 00:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705036335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=edgr9fm1oLMgZey8Ul7s/e25c1AHIceM1qV0RVJbFMs=;
 b=I4Fy+2yL6ncQq0mxBWKJmgCFZkunqFVN1/zbGzoIvs4bSxSZYVI4AZd6NT5KNqj7z3Fkif
 MWKdwXom6Gz4gQG0hmrOXS4ubxc8vas1L4V1RWKby+PGVc4Vs5i7EdrlX4QsvwYBaDYRK7
 LqpSbz/FxXfRIpsbL3R7klhbSvlr/pA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-gA1xicAdMDqNvzlkV30G2Q-1; Fri, 12 Jan 2024 00:12:11 -0500
X-MC-Unique: gA1xicAdMDqNvzlkV30G2Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40d8586c709so54661765e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 21:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705036330; x=1705641130;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=edgr9fm1oLMgZey8Ul7s/e25c1AHIceM1qV0RVJbFMs=;
 b=fsGCuGklMXmzXrJ1uPJ0H5yEjck5hpxLcjOROit+yXJWex+OXYyl7YvGNMfaQccEZb
 J4RVdP2EU6NYfO/Ec/N0c+XeJZVBAy4Q5Wy/+CTbTapw/h4+HWnNy11Hi6UkrKAgGtDc
 5A+wdpOfsRMO92dS4hTdPlo70A3uF0yGj1Me4h0YAMIZy9iKwcON5hrE+smGETrnXlnV
 iYK753IL0e8f8oslCa02qkBiF+Em1c5+utrnGGnJSNoCGjlXDG8g14e3ftFAYgipItAf
 RRLIn12005HZw5zjOf60Ao5XkJgPMFJGsz0kdArFtmJvPu0C/ZYRIgN4zPyx6asuMwD5
 uoRA==
X-Gm-Message-State: AOJu0Yz5S1Nr2Xpb7XprqNt1hiuhSLi8GbH6SpjxFtKPyAguQvmEwCw/
 MbCa20nX2sl6wXQGXW2zrVMvzkzJF416uJ31maVQz30T6o3XyFu1Quo8E4I0tnwPLozlxo5kkYO
 /W9ME0B4jXcJ3oUqRcKmahqE=
X-Received: by 2002:a1c:7c0f:0:b0:40e:5200:c52d with SMTP id
 x15-20020a1c7c0f000000b0040e5200c52dmr367884wmc.155.1705036329968; 
 Thu, 11 Jan 2024 21:12:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFphFhxh8fpQ3x8kcJULELTeHB6l01vtSBR8gIABdqXqnOFU5/vAYe1u8KcFtQjyfbPkKiGig==
X-Received: by 2002:a1c:7c0f:0:b0:40e:5200:c52d with SMTP id
 x15-20020a1c7c0f000000b0040e5200c52dmr367883wmc.155.1705036329713; 
 Thu, 11 Jan 2024 21:12:09 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-232.web.vodafone.de.
 [109.43.176.232]) by smtp.gmail.com with ESMTPSA id
 lb14-20020a170906adce00b00a2c869c2fe8sm944303ejb.161.2024.01.11.21.12.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 21:12:09 -0800 (PST)
Message-ID: <27a311a8-f6db-48ea-8bbd-a09eb3c2e07e@redhat.com>
Date: Fri, 12 Jan 2024 06:12:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/ppc/cpu-models: Rename power5+ and power7+ for
 new QOM naming rules
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20240111164652.908182-1-thuth@redhat.com>
 <20240111164652.908182-2-thuth@redhat.com>
 <70fae07d-f6c1-4143-b632-a988ae53ccb0@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <70fae07d-f6c1-4143-b632-a988ae53ccb0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 12/01/2024 05.57, Harsh Prateek Bora wrote:
> 
> 
> On 1/11/24 22:16, Thomas Huth wrote:
>> The character "+" is now forbidden in QOM device names (see commit
>> b447378e1217 - "Limit type names to alphanumerical and some few special
>> characters"). For the "power5+" and "power7+" CPU names, there is
>> currently a hack in type_name_is_valid() to still allow them for
>> compatibility reasons. However, there is a much nicer solution for this:
>> Simply use aliases! This way we can still support the old names without
>> the need for the ugly hack in type_name_is_valid().
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/ppc/spapr_cpu_core.c |  4 ++--
>>   qom/object.c            |  4 ----
>>   target/ppc/cpu-models.c | 10 ++++++----
>>   3 files changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>> index 5aa1ed474a..214b7a03d8 100644
>> --- a/hw/ppc/spapr_cpu_core.c
>> +++ b/hw/ppc/spapr_cpu_core.c
>> @@ -389,9 +389,9 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
>>       DEFINE_SPAPR_CPU_CORE_TYPE("970_v2.2"),
>>       DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.0"),
>>       DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.1"),
>> -    DEFINE_SPAPR_CPU_CORE_TYPE("power5+_v2.1"),
>> +    DEFINE_SPAPR_CPU_CORE_TYPE("power5plus_v2.1"),
>>       DEFINE_SPAPR_CPU_CORE_TYPE("power7_v2.3"),
>> -    DEFINE_SPAPR_CPU_CORE_TYPE("power7+_v2.1"),
>> +    DEFINE_SPAPR_CPU_CORE_TYPE("power7plus_v2.1"),
> 
> Will using Power5x, Power7x be a better naming than using 'plus' suffix ?

The "x" looks like a placeholder to me, so it could be confused with 
power50, power51, power52, etc. ...?
But actually, I was thinking about using "power5p" and "power7p" first, so 
if the whole "plus" looks too long for you, would "p" be an option instead?

> Otherwise,
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Thanks!

  Thomas


