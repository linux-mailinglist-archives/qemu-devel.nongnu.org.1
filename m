Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D7C803502
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 14:33:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA93f-00016h-Ck; Mon, 04 Dec 2023 08:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rA93a-00016J-Q5
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 08:32:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rA93W-00039r-NL
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 08:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701696733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zJDrI3zWEbx/x34g9HEIsCQOKxJBfp/zMesBMi9uRDw=;
 b=Y7VmXplwVwFCJVxhL80KTDoHGh6puTNmxAScU0GcqXxdw6Y5ZPob7LF3HDSxkz9G1fAji4
 xFYvgLVYlWj0mwQSPlbx1vgciNz0086pkUM4GycaCMREy6zaFwP8SQqD1DS/WmtTbOuA/7
 aRNM9x5vz54vlHYBxykI1rQlfKBwjCA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-TEaIYllzOhWgrfVKS5E-lw-1; Mon, 04 Dec 2023 08:32:12 -0500
X-MC-Unique: TEaIYllzOhWgrfVKS5E-lw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40b349b9711so38456465e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 05:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701696731; x=1702301531;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zJDrI3zWEbx/x34g9HEIsCQOKxJBfp/zMesBMi9uRDw=;
 b=eb9vKMBnBNilqrrscxfmSfDiUoVmCqHZtZYzAXO8G9K2IRc3RmjqgGwAgAA3NdGxle
 eXzQXi2atpfsXctbcRF5yXFkhfRfsZmZGTzDFgnCn1nGkoGx0ESrIqkb4buyEZK2bi7Q
 6qL/U70IThhgAFVl/mkKtWMjbJoygHAgM0LUIIYGpb2cCvJfkGJD29PsI61D6DEdzVQh
 8BilWlltvGrsFaH6tpNCDOQskpML1mGWi+qQvHVBQIDPvlziQecxmGuv3Imhfr81x0VI
 Sd8tQCjCuTzEqoELmrDMZ2MxLAU+iImIbmziMfdeb3+HFq68ZInhhqMUi/GqKobhKXe2
 95ag==
X-Gm-Message-State: AOJu0YxEMORad2VcEjMRLnB9iTOb/GCc7gP9aRTnUumky9d77LgMBvp8
 UmHGqzzjRfDrmL4J1la5qAg7DhPKBHHuZMeisOrlGSjkujXsFRgQ0dZntD+F5dcBCeiOKLVaOPj
 CDUiOXwGmwf2x2uE=
X-Received: by 2002:a1c:7214:0:b0:40b:5e1d:83a9 with SMTP id
 n20-20020a1c7214000000b0040b5e1d83a9mr1000280wmc.61.1701696731064; 
 Mon, 04 Dec 2023 05:32:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3PKXbv50Ri0RUoQNCAX8WL9cBS3jLgkcdUsnsfcpV+Y7BqVr6ltUEfg/O38oFRB9WIHcW+g==
X-Received: by 2002:a1c:7214:0:b0:40b:5e1d:83a9 with SMTP id
 n20-20020a1c7214000000b0040b5e1d83a9mr1000272wmc.61.1701696730738; 
 Mon, 04 Dec 2023 05:32:10 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-178-85.web.vodafone.de.
 [109.43.178.85]) by smtp.gmail.com with ESMTPSA id
 b19-20020a05600c4e1300b0040648217f4fsm18726763wmq.39.2023.12.04.05.32.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 05:32:09 -0800 (PST)
Message-ID: <3fa71396-abbd-47e3-b9c5-a1c1eabcf7ac@redhat.com>
Date: Mon, 4 Dec 2023 14:32:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] gitlab: build the correct microblaze target
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
 <20231201093633.2551497-7-alex.bennee@linaro.org>
 <a9b7f414-5229-4dc6-9d32-b95d36cdbaf7@redhat.com>
 <871qc29m3z.fsf@draig.linaro.org>
 <181145d8-4d1e-4b19-a77b-1c583155a725@redhat.com>
 <3ae174c2-bad6-4099-8e39-a2f02f58cdfd@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <3ae174c2-bad6-4099-8e39-a2f02f58cdfd@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 04/12/2023 13.48, Cédric Le Goater wrote:
> On 12/4/23 13:43, Thomas Huth wrote:
>> On 04/12/2023 13.40, Alex Bennée wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> On 01/12/2023 10.36, Alex Bennée wrote:
>>>>> We inadvertently built the LE target for BE tests.
>>>>> Fixes: 78ebc00b06 (gitlab: shuffle some targets and reduce avocado
>>>>> noise)
>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>> ---
>>>>>    .gitlab-ci.d/buildtest.yml | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>>>>> index 7f9af83b10..62b5379a5e 100644
>>>>> --- a/.gitlab-ci.d/buildtest.yml
>>>>> +++ b/.gitlab-ci.d/buildtest.yml
>>>>> @@ -41,7 +41,7 @@ build-system-ubuntu:
>>>>>      variables:
>>>>>        IMAGE: ubuntu2204
>>>>>        CONFIGURE_ARGS: --enable-docs
>>>>> -    TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
>>>>> +    TARGETS: alpha-softmmu microblaze-softmmu mips64el-softmmu
>>>>>        MAKE_CHECK_ARGS: check-build
>>>>>      check-system-ubuntu:
>>>>
>>>> We've got microblazeel-softmmu here and microblaze-softmmu in the
>>>> build-system-fedora job. So please don't change the ubuntu job here,
>>>> otherwise we're building the same target twice instead.
>>>
>>> Hmm - what would be really useful is an actual microblazeel test image
>>> so we can test what we build.
>>
>> We've got at least a small test in tests/qtest/boot-serial-test.c, so we 
>> know that at least some instructions can be executed via TCG.
> 
> There are 2 configs under buildroot, qemu_microblazebe_mmu_defconfig and
> qemu_microblazeel_mmu_defconfig, we could possibly use.

I already used the big endian config for going shopping for ballerinas 
(which we already use in one of the avocado tests):

  http://www.qemu-advent-calendar.org/2018/#day-17

And as I just learnt today, the QEMU advent calendar opens its doors again 
in 2023:

  http://www.qemu-advent-calendar.org/2023/

Let's see, maybe we can have a nice surprise for microblazeel this time...

  Thomas


