Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 388F572B882
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 09:17:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8bnh-0007g7-AX; Mon, 12 Jun 2023 03:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q8bnb-0007fm-Ku
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 03:17:11 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q8bnZ-0002qq-Qx
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 03:17:11 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-bc476bf5239so2119147276.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 00:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686554228; x=1689146228;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oYYxvVOm7SuokDORqy+h1gBCSkGxi8qwS8+yjMWgu64=;
 b=e0ynxhO2w4kH0ekb2iYusfBJpF5akhFWEEuOv/HBRbUWw2ONFPMSck44PY1jra5Jvm
 UFAHEPnAoPqHc81rQrQxc5Ma9scmA5auq3FrQAwndHXolGASQWjWaUPUGTqDmDNKT6Bf
 D7h3PF2e2jHUQGOKC56F1W07+oNg0FoKBrMiJYKNFQuINckMJzTFbU7Mx6oDPRiSaOJx
 OFvUtEagJdbg4p4eBn0ivyXypgly3HCG+nTSfKd68PFIPE1g2xIINWb/RKCH/eA4NDae
 MzrXhqECywzAwE+Bx7valmSzdrrqFy2ZU+9k2tqwm4DsoTxDfIW3MskSUfBxWK9ryEmE
 eK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686554228; x=1689146228;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oYYxvVOm7SuokDORqy+h1gBCSkGxi8qwS8+yjMWgu64=;
 b=TJ9wbg+PS/GxAzxCTWilY1gz1HFPIKgF0G8j6VA1dLyw1BJyVPmvle1s3b4l50uqsX
 LYDvKMir4cu+yTNVyOjYwAyj74zOpKObr3/ffs5RtdL8mLrcB8FPB7ZJ2whzXjQ6Fikx
 Bqn/FgSPFjf0b0/ImAm6vqZQ9UziRXkmO9yACQK1dEteqVfymM1zeW76uN8qsRLWGhnL
 HR/0IvkkRQc3LLFlu5szedzs4egRJMWJpXp4oTOjAcJkStMSGAiAxweFpoBih43AUOOv
 /CX9XWLkKIJs8gLp1+urD1siWaSfjFQSJ/ETww0hoiHJG57iYxa1HRa7gJMIP+M1/eSm
 0aQA==
X-Gm-Message-State: AC+VfDxkUXdcFiTt9uyW/+ZDJwtTtRlaY3mToUj4pN1JnjbURrTXz7Kb
 UobKJcQAAUqS0qsHvv76tp1CuQ==
X-Google-Smtp-Source: ACHHUZ5o4lxlEafvI/npsibpmhkmaMFBYUBwhvaEnUduWeQsfdP/HhIu0AaMHU5hHDKnpHhxlLEV4g==
X-Received: by 2002:a25:8a0a:0:b0:bad:125f:9156 with SMTP id
 g10-20020a258a0a000000b00bad125f9156mr8040493ybl.35.1686554228387; 
 Mon, 12 Jun 2023 00:17:08 -0700 (PDT)
Received: from [192.168.85.227] ([172.58.160.122])
 by smtp.gmail.com with ESMTPSA id
 l23-20020a25b317000000b00bc9588e9a05sm677329ybj.37.2023.06.12.00.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 00:17:07 -0700 (PDT)
Message-ID: <63354939-ae21-dbbd-c788-1acacc64abae@linaro.org>
Date: Mon, 12 Jun 2023 09:17:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v15 07/10] tb-stats: Adding info [tb-list|tb] commands to
 HMP (WIP)
Content-Language: en-US
To: "Wu, Fei" <fei2.wu@intel.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230607122411.3394702-1-fei2.wu@intel.com>
 <20230607122411.3394702-8-fei2.wu@intel.com>
 <81e761e4-7776-b569-229f-f0bd8257145d@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <81e761e4-7776-b569-229f-f0bd8257145d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb34.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/12/23 03:44, Wu, Fei wrote:
> On 6/7/2023 8:24 PM, Fei Wu wrote:
>> +void hmp_info_tb(Monitor *mon, const QDict *qdict)
>> +{
>> +    const int id = qdict_get_int(qdict, "id");
>> +    g_autoptr(GString) buf = g_string_new("");
>> +
>> +    if (!tcg_enabled()) {
>> +        monitor_printf(mon, "Only available with accel=tcg\n");
>> +        return;
>> +    }
>> +
>> +    TBStatistics *tbs = get_tbstats_by_id(id);
>> +    if (tbs == NULL) {
>> +        monitor_printf(mon, "TB %d information is not recorded\n", id);
>> +        return;
>> +    }
>> +
>> +    monitor_printf(mon, "\n------------------------------\n\n");
>> +
>> +    int valid_tb_num = dump_tb_info(buf, tbs, id);
>> +    monitor_printf(mon, "%s", buf->str);
>> +
>> +    if (valid_tb_num > 0) {
>> +        unsigned num_inst = tbs->code.num_guest_inst / tbs->translations.total;
>> +
>> +        monitor_printf(mon, "\n----------------n\n");
>> +        // FIXME: cannot disas
>> +        monitor_disas(mon, mon_get_cpu(mon), tbs->phys_pc, num_inst, true);
>> +        monitor_printf(mon, "\n------------------------------\n\n");
>> +    }
>> +}
>> +
> So far the following methods are candidates for monitor_disas:
> 
> 1. still use ram_addr_t for tbs->phys_pc, and extend monitor_disas to
> support disassemble ram_addr_t by using qemu_map_ram_ptr(NULL, ram_addr)
> to convert it to hva first
> 
> 2. use gpa for tbs->phys_pc, there is no need to change monitor_disas,
> but add another parameter for get_page_addr_code_hostp() to return extra
> gpa, probe_access_internal() has already returned CPUTLBEntryFull, so
> it's plain to get gpa here.

No, we need the ram_addr_t for dirty-page handling in order to detect self-modifying code. 
  Leave tb->phys_pc alone.


r~

> 
> 3. record gpa in another field of tbs, and keep tbs->phys_pc as it is,
> this is just a variation of #2.
> 
> I'm inclined to use method #2. I think gpa carries more information for
> debugging than ram_addr_t, guest can map gpa to the executable file
> etc., but it has little knowledge of ram_addr_t.
> 
> What do you suggest?
> 
> Thanks,
> Fei.
> 


