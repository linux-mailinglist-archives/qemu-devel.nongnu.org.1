Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBA3800226
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 04:35:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8uHi-00060E-PC; Thu, 30 Nov 2023 22:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r8uHg-0005zX-6N
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 22:33:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r8uHe-0007VT-HZ
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 22:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701401621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDA/YtOoP8t8dKReQnD71j9147YsvGu3IU9MGrJu/m0=;
 b=g+LaaVx2nm5yx8amrjtxIOCzPXv8nXEBEiYZTVOlKLoK7ammqQpzntsAxgZvNFNr1N6FEp
 BqsNciJ7baQT6kMFU8Rg8XRunV7AoYJrui2+LAH8WA+tOb5OmgOC/CDpWRtNv4MyPLnMxb
 xfp/1qbX+T7M87j30VoZE5JMCBPpP4M=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-8XNUdUhONze6antiBWXRnA-1; Thu, 30 Nov 2023 22:33:39 -0500
X-MC-Unique: 8XNUdUhONze6antiBWXRnA-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-58a21120248so1929496eaf.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 19:33:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701401618; x=1702006418;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pDA/YtOoP8t8dKReQnD71j9147YsvGu3IU9MGrJu/m0=;
 b=JmuUmGRJMDHME59CRI7RueDslXbCQmI8+yIC3RPpCjmNXL3f6uDBIY+IrpvDejlV/S
 gvhlnu03P2gbhzSrL2y7+Tb6ua+uBYVywtOGTiHoe/+NwlUGoEjuqoRn1gIUuNaXhASK
 +lAKoV89Ffia0K8M2iAsAdQtRm7US8245FKDS/JCpc6mdgaC+yWIeRYOCOSTINu/u1h5
 MWkkqv6MCX+i0an0Pt3AVxO8OzVPjh1yoT588FR9A/5+zQFKnjerdjwo6l4+WUKSutsO
 Za0WKgpCYGxk6LWzFQXVQXEGyqa7EzgBynsICk1fich4ibAfjK2vvkAZog/ZH7kCW8c/
 55xg==
X-Gm-Message-State: AOJu0YyfDIHcMp5PsApHg8nFXH8+aqmE6vFmUG1Q9Nr/0+kdtghMRAE8
 XCFutLDsDi1W1f8LySD7zq0WE7yaZcnQbm9QGpSRgZemX7xk4MEE4CVrc+m7KES6mDJS4CIwjf3
 P/R1nOEZFq+cnc+4=
X-Received: by 2002:a05:6808:3084:b0:3b8:6151:cacb with SMTP id
 bl4-20020a056808308400b003b86151cacbmr1895377oib.10.1701401618666; 
 Thu, 30 Nov 2023 19:33:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLNblhD5zWTa0i5YTn2QIev5tya97sYzEWqFH0zt12ePHxZanyGqH3f/gH+EO//66wXm4hCQ==
X-Received: by 2002:a05:6808:3084:b0:3b8:6151:cacb with SMTP id
 bl4-20020a056808308400b003b86151cacbmr1895345oib.10.1701401618359; 
 Thu, 30 Nov 2023 19:33:38 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 b17-20020aa78ed1000000b006c06779e593sm2013549pfr.16.2023.11.30.19.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 19:33:37 -0800 (PST)
Message-ID: <a1a3a5f9-f785-4b27-9b33-ea5b29e919b3@redhat.com>
Date: Fri, 1 Dec 2023 14:33:26 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/9] machine: Use error handling when CPU type is
 checked
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, b.galvani@gmail.com,
 strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com, kfting@nuvoton.com,
 wuhaotsh@google.com, nieklinnenbank@gmail.com, rad@semihalf.com,
 quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com
References: <20231129042012.277831-1-gshan@redhat.com>
 <20231129042012.277831-2-gshan@redhat.com> <87bkbdnf6u.fsf@pond.sub.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <87bkbdnf6u.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Markus,

On 11/29/23 19:20, Markus Armbruster wrote:
> Gavin Shan <gshan@redhat.com> writes:
> 
>> QEMU will be terminated if the specified CPU type isn't supported
>> in machine_run_board_init(). The list of supported CPU type names
>> is tracked by mc->valid_cpu_types.
> 
> Suggest to drop the second sentence.
> 

Indeed, it's not so helpful.

>> The error handling can be used to propagate error messages, to be
>> consistent how the errors are handled for other situations in the
>> same function.
>>
>> No functional change intended.
>>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>> v8: Drop @local_err and use @errp to be compatible with
>>      ERRP_GUARD()                                          (Phil)
>> ---
>>   hw/core/machine.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 0c17398141..bde7f4af6d 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -1466,15 +1466,16 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>>   
>>           if (!machine_class->valid_cpu_types[i]) {
>>               /* The user specified CPU is not valid */
>> -            error_report("Invalid CPU type: %s", machine->cpu_type);
>> -            error_printf("The valid types are: %s",
>> -                         machine_class->valid_cpu_types[0]);
>> +            error_setg(errp, "Invalid CPU type: %s", machine->cpu_type);
>> +            error_append_hint(errp, "The valid types are: %s",
>> +                              machine_class->valid_cpu_types[0]);
>>               for (i = 1; machine_class->valid_cpu_types[i]; i++) {
>> -                error_printf(", %s", machine_class->valid_cpu_types[i]);
>> +                error_append_hint(errp, ", %s",
>> +                                  machine_class->valid_cpu_types[i]);
>>               }
>> -            error_printf("\n");
>>   
>> -            exit(1);
>> +            error_append_hint(&errp, "\n");
>> +            return;
>>           }
>>       }
> 
> This cleans up an anti-pattern: use of error_report() within a function that
> returns errors through an Error **errp parameter.
> 
> Cleanup, not bug fix, because the only caller passes &error_abort.
> 
> Suggest to start the commit message with a mention of the anti-pattern.
> Here's how I'd write it:
> 
>      Functions that use an Error **errp parameter to return errors should
>      not also report them to the user, because reporting is the caller's
>      job.
> 
>      machine_run_board_init() violates this principle: it calls
>      error_report(), error_printf(), and exit(1) when the machine doesn't
>      support the requested CPU type.
> 
>      Clean this up by using error_setg() and error_append_hint() instead.
>      No functional change, as the only caller passes &error_fatal.
> 

Thanks for the nice write-up. I will take it if v9 is needed to address
comments from other people.

> Whether you use my suggestion or not:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

Thanks for your review.

Thanks,
Gavin


