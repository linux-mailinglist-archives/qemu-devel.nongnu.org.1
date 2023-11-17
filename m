Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3B47EF3D9
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 14:49:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3zCv-0004KP-ND; Fri, 17 Nov 2023 08:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3zCt-0004Js-Eg
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 08:48:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3zCr-0007ZD-O5
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 08:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700228903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3M724XqkonEAHAMLFt5kwSmMf3grQ0PGt6o5NKc3C+k=;
 b=FVeb0JOGoZAdRuP5HeXy76pXo7HWgPe6OvqxPL2+qvSDDb6uArsrd0EDfKP7Y50XRfrSOY
 05ksVTo+34kZFpj/TXni98ZoQGqxtWTGsodzRzsfU2VbaDPfqvcOHZrQFfpOQZMpgHoRB7
 8tqPP26DNTMA5N4BePnSSgBn7Fbf20A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-8kHbK6t2NGmNxzPE7aXWpg-1; Fri, 17 Nov 2023 08:48:22 -0500
X-MC-Unique: 8kHbK6t2NGmNxzPE7aXWpg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-778b5354c7bso247338385a.1
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 05:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228900; x=1700833700;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3M724XqkonEAHAMLFt5kwSmMf3grQ0PGt6o5NKc3C+k=;
 b=LdRCWhOEnvzROIh5awF/NbkTpxYl19nsHUiSo8MfusRXE0fV88gWYWFi71ncma2+oD
 LcfcVb16uvKdJoaKIF888dTbMEL6fTgpzWsztkxMVaO/n+OB6dBCu2BCrvshWB87RVqk
 /qlS4RlLoEnT2t3j8SOJYn9XEBs9jCTpduU6KNu1WU3XQk++g0h7oBBvQ8F25NQl17w3
 9VZ8hadmZHaGy+BQtUQaB1GNGvXc0Uh5Nu1WAOXN9asw0/5yFP0KKoUdgloiqQR5V42J
 Tkg0C9Cg02CNUvxkCphWljm113yjvqSk+YCQF3yBQM5g2BxZd7MBmcOv1AEqOiZIJdag
 Gc7w==
X-Gm-Message-State: AOJu0YymBmKy6R6wEiajCbhNT/1kQZMqMeaChNrGUfDDH5mbt7O2fk3t
 n6UVN0tngPwJywiSvDns7jVuSJp/jknsHkpVViV8TiJ2lozxgz85Y0a7Q96oeJydAwruNrVI92o
 P2Ya9CszXaYESkXA=
X-Received: by 2002:a05:620a:6545:b0:774:1adc:c572 with SMTP id
 qc5-20020a05620a654500b007741adcc572mr9052321qkn.74.1700228900439; 
 Fri, 17 Nov 2023 05:48:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9I9rTno84jXhndR3AG/Xt3PJncVv98HsPan71YacGUPlfB0g8Dcr/qSLSiYtFTTaTo3y1/Q==
X-Received: by 2002:a05:620a:6545:b0:774:1adc:c572 with SMTP id
 qc5-20020a05620a654500b007741adcc572mr9052309qkn.74.1700228900129; 
 Fri, 17 Nov 2023 05:48:20 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-122.web.vodafone.de.
 [109.43.176.122]) by smtp.gmail.com with ESMTPSA id
 m18-20020ae9e012000000b007742ad3047asm600045qkk.54.2023.11.17.05.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 05:48:19 -0800 (PST)
Message-ID: <d6c244d5-5b1c-4a0f-a07f-94d0c853c8e1@redhat.com>
Date: Fri, 17 Nov 2023 14:48:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] qom/object: Limit type names to alphanumerical and
 some few special characters
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20231117114457.177308-1-thuth@redhat.com>
 <20231117114457.177308-6-thuth@redhat.com>
 <a774e56e-cac9-40e8-b8d0-cedce6a1bc7e@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a774e56e-cac9-40e8-b8d0-cedce6a1bc7e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 17/11/2023 13.25, Philippe Mathieu-Daudé wrote:
> On 17/11/23 12:44, Thomas Huth wrote:
>> QOM names currently don't have any enforced naming rules. This
>> can be problematic, e.g. when they are used on the command line
>> for the "-device" option (where the comma is used to separate
>> properties). To avoid that such problematic type names come in
>> again, let's restrict the set of acceptable characters during the
>> type registration.
>>
>> Ideally, we'd apply here the same rules as for QAPI, i.e. all type
>> names should begin with a letter, and contain only ASCII letters,
>> digits, hyphen, and underscore. However, we already have so many
>> pre-existing types like:
>>
>>      486-x86_64-cpu
>>      cfi.pflash01
>>      power5+_v2.1-spapr-cpu-core
>>      virt-2.6-machine
>>      pc-i440fx-3.0-machine
>>
>> ... so that we have to allow "." and "+" for now, too. While the
>> dot is used in a lot of places, the "+" can fortunately be limited
>> to two classes of legacy names ("power" and "Sun-UltraSparc" CPUs).
>>
>> We also cannot enforce the rule that names must start with a letter
>> yet, since there are lot of types that start with a digit. Still,
>> at least limiting the first characters to the alphanumerical range
>> should be way better than nothing.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   qom/object.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/qom/object.c b/qom/object.c
>> index 95c0dc8285..654e1afaf2 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -138,9 +138,50 @@ static TypeImpl *type_new(const TypeInfo *info)
>>       return ti;
>>   }
>> +static bool type_name_is_valid(const char *name)
>> +{
>> +    const int slen = strlen(name);
>> +    int plen;
>> +
>> +    g_assert(slen > 1);
>> +
>> +    /*
>> +     * Ideally, the name should start with a letter - however, we've got
>> +     * too many names starting with a digit already, so allow digits here,
>> +     * too (except '0' which is not used yet)
>> +     */
>> +    if (!g_ascii_isalnum(name[0]) || name[0] == '0') {
>> +        return false;
>> +    }
>> +
>> +    plen = strspn(name, "abcdefghijklmnopqrstuvwxyz"
>> +                        "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
>> +                        "0123456789-_.");
>> +
>> +    /* Allow some legacy names with '+' in it for compatibility reasons */
>> +    if (name[plen] == '+') {
>> +        if (plen == 6 && g_str_has_prefix(name, "power")) {
>> +            /* Allow "power5+" and "power7+" CPU names*/
>> +            return true;
>> +        }
>> +        if (plen >= 17 && g_str_has_prefix(name, "Sun-UltraSparc-I")) {
>> +            /* Allow "Sun-UltraSparc-IV+" and "Sun-UltraSparc-IIIi+" */
>> +            return true;
>> +        }
>> +    }
>> +
>> +    return plen == slen;
>> +}
>> +
>>   static TypeImpl *type_register_internal(const TypeInfo *info)
>>   {
>>       TypeImpl *ti;
>> +
>> +    if (!type_name_is_valid(info->name)) {
>> +        fprintf(stderr, "Registering '%s' with illegal type name\n", 
>> info->name);
> 
> Shouldn't we use error_report() instead of fprintf()? Regardless,

It doesn't work here yet - the type registration happens so early that we 
cannot use error_report() here yet.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

  Thomas



