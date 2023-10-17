Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 304747CCC77
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:41:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspw8-0003F1-Sm; Tue, 17 Oct 2023 15:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspw7-0003Eq-3D
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:41:03 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspw4-0000a5-Vx
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:41:02 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-57b9231e91dso3673473eaf.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 12:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697571659; x=1698176459;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V4/Udz1quXCda6ZwFnS8mstkxUlbwA7cnkkoAgSfB1g=;
 b=gMv2WGrh7PCYiKNQQUaD+1oFs7lC+dxzZVq+fqONQy9MQswbhucCpm9KafT3IS/pyx
 gHlUa8ccz60oPmr1cOF133wOcCL3YXcS6q7mxHjlllkmS9m7syC1/KQnUPN7J9wwdA52
 24qeQ2Qre47wyHCrKGxklUpES6Jv1+K2iwqWd1PENAagNShWqMLbp0WTA6uzys1xsjB2
 EutLpU64trHPyt83B54UFuVTTRtgSvkLtXgHApzM9aisrvM7Wb0/9zVECL0uF3vh05sZ
 A193tmZmRLDXF2jliFCxHrkMBzkYebPu/6/QIklfkI5D/A0dzmIYpDGuWaH8f1Z0S0f/
 c2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697571659; x=1698176459;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V4/Udz1quXCda6ZwFnS8mstkxUlbwA7cnkkoAgSfB1g=;
 b=A0pFOYqEvbq1UiOw6IcmjmffMu7rsIbMXKygfVh02d7BZGoTmAOcacLVYY3oDi1IpC
 tATtV//dcY5GGI75bLmeMJ7eoE87rEVl7NeGkhrpAkR3diHE+JTcRzmbiWCYRApZte/M
 ixudapE33A2vciMh4JgDC4PhWKu3FrlA6WSLWz1EOny1agyuzF560tS9+jm1ErfR1R9F
 zWC6uglcjyxniNTf/IlnaDTiHYpQUwaaBAUglpGSbxKv/z8DlT78Rd+TeRz3CN/9XlvK
 TXnnKRkUxJbQrfYP88SUrvgKaqdSt+MPI2a6GuGwg3XzlEAPBAp95j94uigaWOnOJRjy
 FyWw==
X-Gm-Message-State: AOJu0YwJzOmy5BaZvCuoSpvBoVJH2Qomzjc/A+4k7KnxzSPEMZNSQFsl
 MiOOea3JOYGp05Nt8l0m+YEyig==
X-Google-Smtp-Source: AGHT+IFKQkpwTRxQ3efnZjakFFMyAX1mgyRkZEXuxsNdMzgOgyx0t6PWKLTab/0+skufdR/VsLNnbA==
X-Received: by 2002:a05:6359:3510:b0:166:9c14:a838 with SMTP id
 un16-20020a056359351000b001669c14a838mr3338765rwb.19.1697571659352; 
 Tue, 17 Oct 2023 12:40:59 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 b16-20020aa78ed0000000b006870ed427b2sm1889375pfr.94.2023.10.17.12.40.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 12:40:57 -0700 (PDT)
Message-ID: <cb30adc2-f68d-4414-bd5d-e6ad4ff9be9f@daynix.com>
Date: Wed, 18 Oct 2023 04:40:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 19/25] gdbstub: Replace gdb_regs with an array
To: Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
 <20231011103329.670525-20-alex.bennee@linaro.org> <87ttqpwdh7.fsf@suse.de>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87ttqpwdh7.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/17 23:05, Fabiano Rosas wrote:
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>> An array is a more appropriate data structure than a list for gdb_regs
>> since it is initialized only with append operation and read-only after
>> initialization.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Message-Id: <20230912224107.29669-13-akihiko.odaki@daynix.com>
>> [AJB: fixed a checkpatch violation]
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Message-Id: <20231009164104.369749-20-alex.bennee@linaro.org>
>>
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index 7b8347ed5a..3968369554 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -502,7 +502,7 @@ struct CPUState {
>>   
>>       CPUJumpCache *tb_jmp_cache;
>>   
>> -    struct GDBRegisterState *gdb_regs;
>> +    GArray *gdb_regs;
>>       int gdb_num_regs;
>>       int gdb_num_g_regs;
>>       QTAILQ_ENTRY(CPUState) node;
>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>> index 62608a5389..b1532118d1 100644
>> --- a/gdbstub/gdbstub.c
>> +++ b/gdbstub/gdbstub.c
>> @@ -51,7 +51,6 @@ typedef struct GDBRegisterState {
>>       gdb_get_reg_cb get_reg;
>>       gdb_set_reg_cb set_reg;
>>       const char *xml;
>> -    struct GDBRegisterState *next;
>>   } GDBRegisterState;
>>   
>>   GDBState gdbserver_state;
>> @@ -386,7 +385,8 @@ static const char *get_feature_xml(const char *p, const char **newp,
>>                   xml,
>>                   g_markup_printf_escaped("<xi:include href=\"%s\"/>",
>>                                           cc->gdb_core_xml_file));
>> -            for (r = cpu->gdb_regs; r; r = r->next) {
>> +            for (guint i = 0; i < cpu->gdb_regs->len; i++) {
> 
> It seems we can reach here before having initialized gdb_regs at
> gdb_register_coprocessor():
> 
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> 0x0000555555e5310b in get_feature_xml (p=0x555556a99118
> <gdbserver_state+56> "target.xml:0,ffb", newp=0x7fffffffc6b0,
> process=0x555557a21dd0) at ../gdbstub/gdbstub.c:388
> 
> (gdb) p/x cpu->gdb_regs
> $1 = 0x0
> 
> 
> Using:
> qemu-system-x86 ... -s -s
> 
> just connect GDB and it crashes.

Hi,

Sorry for trouble and thank you for reporting.

I have just posted a fix "[PATCH v4 1/5] gdbstub: Check if gdb_regs is 
NULL" as part of series "[PATCH v4 0/5] gdbstub and TCG plugin 
improvements". Please test it if possible.

Alex, you may pick the patch early since the bug is quite a serious. 
Please add "Reported-by: Fabiano Rosas <farosas@suse.de>" when you do so 
since I forgot it. You may skip applying target/riscv patches though 
since the maintainers may still have something to comment.

Regards,
Akihiko Odaki

