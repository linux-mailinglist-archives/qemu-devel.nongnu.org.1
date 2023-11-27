Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 287967FA7BC
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:11:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7f5u-0007Oz-NI; Mon, 27 Nov 2023 12:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@rivosinc.com>)
 id 1r7f5s-0007Of-TL
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:24 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <patrick@rivosinc.com>)
 id 1r7f5r-0004af-6v
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:24 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6cd89f2af9dso1371898b3a.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 09:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701104901; x=1701709701;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y3pzaA2iozJj/N8vidb2ccmFICnnuhJzu37DFxDCrdU=;
 b=AW0zTNeiBJWJTJ8WA8KX1t/5lnTpu6yUtwRJR3jnB3e1r2HgwIQ5XTIEl4c9tM0mvL
 ZMiszUcQaDs5NhEhy5T5ZHHluKMh7J5by4bsgKmLSMdGEVjeNhZIkCkYyvJnZON/JUBE
 hC5tie3sQOTFJizXL4H//q3z0nemJGuHpgC1smkd5S+TqPRoBQ/otdqZAn5NR+4F36fC
 40mmphuRGNZmgO+uq0zm67QXMvtJJe8FxZFG1o9ImZqwae+3iFt5n2zU1+AUCjeKtP1Y
 K3ywjhnN+pE4+UrEtEgiSJGz9x7a+i+6du6shv88i49j74JTLIFOc831hFd1DQ9NQePk
 OF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701104901; x=1701709701;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y3pzaA2iozJj/N8vidb2ccmFICnnuhJzu37DFxDCrdU=;
 b=AYXpTokGR3A4sjalsh8LbsmQAXMdCnYOnTsfFNB78q7kCBH5sRP8rUnTFCORAMTTrC
 nA97YdezpCY4jtcLwoKb9AgmJDUMG428dBzVZgfyg1y2zbQwR+C3Rm+ulX0En8fwpbsK
 kn6VDGozhX8X6PrgKnK58mLBDJdcVdLKkUVZbtv48vnyQKutB82p4HYVIsEFZg7euFeh
 /Dk+uY15gdgo5zZd8mUpVew/r4o1qkIX6JKV/4NyyGKRVtcBemATC8kSaAKopLrFMoza
 9PKYbflB6j/G9d4cjOWim29BWpo3CMxHS3Iqhl95jDhhymKXvgHRRYDEhr/VT/Z3xmJe
 Z6TQ==
X-Gm-Message-State: AOJu0Yxs1sxOeYVLhXStOc9cRguJH4hMpEu0MMk1OxoxBpQMqy3whhrI
 hQpicAiKvL0FIklDdHMLH7wyJg==
X-Google-Smtp-Source: AGHT+IEwBkwQRA8Xvprm1ajg1KJ88yZYg4Dfl6mtNdV/hRGcxcvwFlytFqq2o07lcpUO1z/HNo7UCA==
X-Received: by 2002:a17:903:44c:b0:1c9:aac5:df30 with SMTP id
 iw12-20020a170903044c00b001c9aac5df30mr13166653plb.66.1701104900998; 
 Mon, 27 Nov 2023 09:08:20 -0800 (PST)
Received: from [10.0.17.156] ([12.44.203.122])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a170902654800b001c61acd5bd2sm8722354pln.112.2023.11.27.09.08.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 09:08:20 -0800 (PST)
Message-ID: <9eba31fa-74b3-4d35-97d4-632fbdd2666f@rivosinc.com>
Date: Mon, 27 Nov 2023 09:08:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: Increase max vlen to 4096
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20231123001709.64934-1-patrick@rivosinc.com>
 <50795130-6a02-4611-8da7-c06158fc9cff@linaro.org>
From: Patrick O'Neill <patrick@rivosinc.com>
In-Reply-To: <50795130-6a02-4611-8da7-c06158fc9cff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=patrick@rivosinc.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Hi Phil,

On 11/23/23 02:21, Philippe Mathieu-Daudé wrote:
> Hi Patrick,
>
> On 23/11/23 01:17, Patrick O'Neill wrote:
>> QEMU currently limits the max vlenb to 1024. GCC sets the upper bound
>> to 4096 [1]. There doesn't seem to be an upper bound set by the spec [2]
>> so this patch just changes QEMU to match GCC's upper bound.
>>
>> [1] 
>> https://github.com/gcc-mirror/gcc/blob/5d2a360f0a541646abb11efdbabc33c6a04de7ee/gcc/testsuite/gcc.target/riscv/rvv/base/zvl-unimplemented-2.c#L4
>> [2] https://github.com/riscv/riscv-v-spec/issues/204
>>
>> Signed-off-by: Patrick O'Neill <patrick@rivosinc.com>
>> ---
>> Tested by applying to QEMU v8.1.2 and running the GCC testsuite in QEMU
>> user mode with rv64gcv_zvl4096b. Failures are somewhat reasonable and on
>> first inspection appear to be in the same ballpark as failures for
>> rv64gcv_zvl1024b. Since I used tip-of-tree GCC I'm expecting those
>> failures to be GCC-caused & from skimming the debug log they appear to
>> be.
>> ---
>>   target/riscv/cpu.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 6ea22e0eea..2ff3a72fc0 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -97,7 +97,7 @@ typedef enum {
>>   #include "debug.h"
>>   #endif
>>
>> -#define RV_VLEN_MAX 1024
>> +#define RV_VLEN_MAX 4096
>
> This seems to break the "cpu/vector" field migration. Maybe we don't
> care, but this should be clarified in the commit description.
I wasn't aware of that (this is actually my first patch to qemu!). Do
you have a pointer to more information about the migration so I can
write an appropriate blurb/understand what the migration was/did?

Thanks,
Patrick
>
> Regards,
>
> Phil.
>

