Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3BC826717
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 02:23:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMeLG-0007KC-6s; Sun, 07 Jan 2024 20:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rMeLD-0007Jj-G3
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 20:22:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rMeLB-0007G1-Mg
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 20:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704676928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ksm2/s0Vd75lDfEQF9n6o4uocnJVvUszCCEf/csOooE=;
 b=XzRPD6JuicGqvyMX+PkkBWltoRy2dcLJXcgz2nx9Nlwd/0fFbBehjukhaAuIjuaiEtZr6S
 kvBY0AUdnRBSgOaEBeo2hlG9yKSgFvZmSyBKlq+Mh46Aw3hRCi/4kBiOSXBTJPP3Si0mmV
 YA90ufs0rFkdzpXYmp+GQLbySV5LrE4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-ivGKG02cOTO23o0zKyJCWA-1; Sun, 07 Jan 2024 20:22:06 -0500
X-MC-Unique: ivGKG02cOTO23o0zKyJCWA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28be574c1c4so1719868a91.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 17:22:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704676926; x=1705281726;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ksm2/s0Vd75lDfEQF9n6o4uocnJVvUszCCEf/csOooE=;
 b=KmzBRx7WXka7wHX4busdfbno+M6WiNuHxEmZmP7QFXq66gU7JFQ+0GOQCyyaLD5/5+
 yko4Iiqki3OREZhK2TfNxKl2BCrlzwN0IgHbQ/Gl/4zpY7DoeQLDvFwJ32i4EQ2FX7wp
 MRmIsWoyZ3Kb0H2zikgeEXxB/03iZmrSSBUGbFWzLIluILriMjFtXKyVI4a61T/H8YKz
 O1qy6iet0OB8fb7geJIqtGeazqTIgHc1RqLXqKZ5Uk3qYLGu8hSz+vZ4JWIYFS2NBD2q
 t1JH/zvw2cVuV43Zr3WpxACFdluDGLSZTzOqq/IQ85r7Yd4nj91NHaWd8hmYls9YwF6V
 qbdw==
X-Gm-Message-State: AOJu0Yw9qL85S4QqdehWqvdosXk+iR+ChWAdsWIIOFZPfbTpMNCGaD74
 MzJCroyqronJ6znpvSddNlGVAjsSNl1u5aPgZsrhsgeIrJPPhc4BlQI0RIXtA7aEW6L5XId6kQ1
 Q8Z86OYYyJ43v0aUlhuf6lO0=
X-Received: by 2002:a17:902:ecc1:b0:1d4:bc19:d7cc with SMTP id
 a1-20020a170902ecc100b001d4bc19d7ccmr4092417plh.116.1704676925738; 
 Sun, 07 Jan 2024 17:22:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/M7WU+9PQ44R81JuuCUJy+iYIfrf0/obxGkNl+UIPSbfhOijlmbuxVK9V8+ZqnV66NlMx7A==
X-Received: by 2002:a17:902:ecc1:b0:1d4:bc19:d7cc with SMTP id
 a1-20020a170902ecc100b001d4bc19d7ccmr4092391plh.116.1704676925407; 
 Sun, 07 Jan 2024 17:22:05 -0800 (PST)
Received: from [10.72.112.108] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 w21-20020a170902d3d500b001d3f5cfa741sm4960557plb.283.2024.01.07.17.21.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jan 2024 17:22:04 -0800 (PST)
Message-ID: <de2e49be-4bc1-4cf0-a3eb-4f67630c8009@redhat.com>
Date: Mon, 8 Jan 2024 11:21:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/9] machine: Improve is_cpu_type_supported()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 b.galvani@gmail.com, strahinja.p.jankovic@gmail.com, imammedo@redhat.com,
 kfting@nuvoton.com, wuhaotsh@google.com, nieklinnenbank@gmail.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 wangyanan55@huawei.com, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com
References: <20231204004726.483558-1-gshan@redhat.com>
 <20231204004726.483558-4-gshan@redhat.com>
 <3ef0442a-800c-47ac-a685-2f31b0cb136c@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <3ef0442a-800c-47ac-a685-2f31b0cb136c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
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

On 1/6/24 08:09, Philippe Mathieu-Daudé wrote:
> On 4/12/23 01:47, Gavin Shan wrote:
>> It's no sense to check the CPU type when mc->valid_cpu_types[0] is
>> NULL, which is a program error. Raise an assert on this.
>>
>> A precise hint for the error message is given when mc->valid_cpu_types[0]
>> is the only valid entry. Besides, enumeration on mc->valid_cpu_types[0]
>> when we have mutiple valid entries there is avoided to increase the code
>> readability, as suggested by Philippe Mathieu-Daudé.
>>
>> Besides, @cc comes from machine->cpu_type or mc->default_cpu_type. For
>> the later case, it can be NULL and it's also a program error. We should
>> use assert() in this case.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> v9: assert(mc->valid_cpu_types[0] != NULL)                   (Phil)
>>      assert(cc != NULL);                                      (Phil)
>> ---
>>   hw/core/machine.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 1797e002f9..4ae9aaee8e 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -1400,6 +1400,7 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
>>        * type is provided through '-cpu' option.
>>        */
>>       if (mc->valid_cpu_types && machine->cpu_type) {
>> +        assert(mc->valid_cpu_types[0] != NULL);
>>           for (i = 0; mc->valid_cpu_types[i]; i++) {
>>               if (object_class_dynamic_cast(oc, mc->valid_cpu_types[i])) {
>>                   break;
>> @@ -1409,20 +1410,27 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
>>           /* The user specified CPU type isn't valid */
>>           if (!mc->valid_cpu_types[i]) {
>>               error_setg(errp, "Invalid CPU type: %s", machine->cpu_type);
>> -            error_append_hint(errp, "The valid types are: %s",
>> -                              mc->valid_cpu_types[0]);
>> -            for (i = 1; mc->valid_cpu_types[i]; i++) {
>> -                error_append_hint(errp, ", %s", mc->valid_cpu_types[i]);
>> +            if (!mc->valid_cpu_types[1]) {
>> +                error_append_hint(errp, "The only valid type is: %s\n",
>> +                                  mc->valid_cpu_types[0]);
>> +            } else {
>> +                error_append_hint(errp, "The valid types are: ");
>> +                for (i = 0; mc->valid_cpu_types[i]; i++) {
>> +                    error_append_hint(errp, "%s%s",
>> +                                      mc->valid_cpu_types[i],
>> +                                      mc->valid_cpu_types[i + 1] ? ", " : "");
>> +                }
>> +                error_append_hint(errp, "\n");
>>               }
>> -            error_append_hint(errp, "\n");
>>               return false;
>>           }
>>       }
>>       /* Check if CPU type is deprecated and warn if so */
>>       cc = CPU_CLASS(oc);
>> -    if (cc && cc->deprecation_note) {
>> +    assert(cc != NULL);
>> +    if (cc->deprecation_note) {
>>           warn_report("CPU model %s is deprecated -- %s",
>>                       machine->cpu_type, cc->deprecation_note);
>>       }
> 
> Since we were getting:
> 
> $ qemu-system-s390x -M none
> QEMU 8.2.50 monitor - type 'help' for more information
> qemu-system-s390x: ../../hw/core/machine.c:1444: _Bool is_cpu_type_supported(const MachineState *, Error **): Assertion `cc != NULL' failed.
> Aborted (core dumped)
> 
> I added a check on mc->valid_cpu_types before calling
> is_cpu_type_supported() in the previous patch. See commit acbadc5a29.
> 

Phil, thanks for fixing it up and it looks good to me.

Thanks,
Gavin


