Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D197A22A5
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:41:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhAwr-00075n-Fp; Fri, 15 Sep 2023 11:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhAwk-0006sn-U7
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:41:31 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhAwj-00083P-6z
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:41:30 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31f853f2f3aso2257297f8f.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694792479; x=1695397279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k1yfVen9EvE1M5ExDmee6eWosvnUI0QWWrDRKlsBkJM=;
 b=yGdMx3e5NfKhQ7H2sGeetJslE8Z9zAPHmxKfVdWDn5bK+wMY/4qTwWaGHBmWFKYyho
 JCbAg8eNtzktsEwe004rd5qhd/sAbT8mMFKc80HMIq5y2Cy0pdmGLLgRN0jmzk03RdbM
 31rlAx8hyma+O/bzHnKP5Cy7bnuFuRSSwhEAJEop574U6nO5wcJqeFnuF/FaJhViLoym
 biGqwQBx7Kb2BkFEmJOUAulzGlBx4TXlO2QnxsPlO2wLvwmUXCYaWS69bq2soohrrZ0d
 gSTr6g0gcL7BqnxdnjWv3WiPdwfGCXsrwS6l94Z/JgTI2+dXnyM6sjRxHf9zMVb6YOot
 XLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694792479; x=1695397279;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k1yfVen9EvE1M5ExDmee6eWosvnUI0QWWrDRKlsBkJM=;
 b=SGJooSOrIBzQqMtMiyNtGcl4OHCjbQ6RyQF493oO5VMaNH4xOgSXW3DtTQEvngQFuw
 aIQ6MLXaAGgr27ScPhjiHwlNPXiAXjuKco3JivafgTRSQ/Mr6oiTVANjj5n+CNNOQsRY
 3UJAaYa1R3+0yVyi7kiUwh0OfOEnTtAwB3ej79eClHwuFXfdjy/GporzF16PBxqwQW0U
 ciXImgmJPCwxfl/UBrHbZ5aKiGQkIkntmpozmKeq3ij1098ADKU6x5fykOtxWZc7LKLe
 awXfAgfcscId5r29xd/WpeQOKt0c/sD8IFrd8OT3LwAV0DXWKuWSjFO6CmkxfYO+OhUj
 l/SQ==
X-Gm-Message-State: AOJu0Ywqt1ZV+3Te+Q3xsqhjPkEEZyPoTVjNgvxlVZMbu56PWEtIRVtx
 zl1lGLkYQZcno4CzuOanNBeuHuALtXjU0vMaWsA=
X-Google-Smtp-Source: AGHT+IGQeAQFWwZEUKrUSgaZCe0J9Vc4DM/v3uEtyOOArysQXRfiNoQqRk3slzOBdEoGWhH5CO6exQ==
X-Received: by 2002:a5d:4112:0:b0:317:6579:2b9f with SMTP id
 l18-20020a5d4112000000b0031765792b9fmr1609494wrp.30.1694792478969; 
 Fri, 15 Sep 2023 08:41:18 -0700 (PDT)
Received: from [192.168.69.115]
 (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a5d6ac8000000b0031416362e23sm4761833wrw.3.2023.09.15.08.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 08:41:18 -0700 (PDT)
Message-ID: <37051e76-3edd-2895-aa6c-b9a63c586c9f@linaro.org>
Date: Fri, 15 Sep 2023 17:41:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] accel/tcg: Remove unused tcg_flush_jmp_cache() stub
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Anton Johansson <anjo@rev.ng>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
References: <20230914195229.78244-1-philmd@linaro.org>
 <20230914195229.78244-3-philmd@linaro.org>
 <76e01d80-c1ff-6a7c-9f2d-3fa2e02b7144@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <76e01d80-c1ff-6a7c-9f2d-3fa2e02b7144@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/9/23 17:12, Harsh Prateek Bora wrote:
> 
> 
> On 9/15/23 01:22, Philippe Mathieu-Daudé wrote:
>> Since commit ba7d3d1858 ("cpu_common_reset: wrap TCG
>> specific code in tcg_enabled()") we protect the single call
>> to tcg_flush_jmp_cache() with a check on tcg_enabled(). The
>> stub isn't needed anymore.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Commit log might need rephrase as I see multiple instance of call,
> with one without check for tcg_enabled() in plugin_cpu_update__async but 
> seems to be building only with tcg enabled so no build breaks.

TCG Plugins are restricted to TCG, so we don't need to guard
there :) I'll update the description mentioning it.

Thanks for your review!

> Thanks
> Harsh
>> ---
>>   accel/stubs/tcg-stub.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
>> index f088054f34..dd890d6cf6 100644
>> --- a/accel/stubs/tcg-stub.c
>> +++ b/accel/stubs/tcg-stub.c
>> @@ -18,10 +18,6 @@ void tb_flush(CPUState *cpu)
>>   {
>>   }
>> -void tcg_flush_jmp_cache(CPUState *cpu)
>> -{
>> -}
>> -
>>   int probe_access_flags(CPUArchState *env, vaddr addr, int size,
>>                          MMUAccessType access_type, int mmu_idx,
>>                          bool nonfault, void **phost, uintptr_t retaddr)


