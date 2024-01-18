Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA489832099
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:51:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQZLA-0000AF-12; Thu, 18 Jan 2024 15:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQZL6-00009n-T7
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:50:17 -0500
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQZL5-0006Gl-Cc
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:50:16 -0500
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3619e804f2aso176425ab.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705611012; x=1706215812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0f5l0fzZIywWl9cmu82n3FRn9QIX6DqHcYTn9G4/qUo=;
 b=NwHUY3bWNJ6hUz9l6p5JH7ghp5SRms7UZuBIS9+lcu/aSESEQc9gug8RtGaQiMgB6m
 rRkNzcZQtXCASifsZTtOQxonh/7vRjccTD6+OHeCSEubN928Cfzo5KrdD72dlraitUUE
 F5pi9QbSpNli19zweDSnNdoSAQwb+E8de8UPOJbB4hvbk6fHkhPC48JHMOEIi5NzxLht
 fH+ZEh5OsbXp0ynARrWE726xAzLt+NoDNJESNxMPa5W3eecutdwIkWcI4fxXd68f5LXE
 Rl/qQqiVb4Kz/ix8vdwDdjTwzEa8wSITg6EFeF8RyQSfhFSA9eY9jb21HJqUQ8ajtuDI
 1jSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705611012; x=1706215812;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0f5l0fzZIywWl9cmu82n3FRn9QIX6DqHcYTn9G4/qUo=;
 b=bA0KFkG0HOdzTa1b/IH4IcuYa5TGSSba3V0+wCQdvQ8JeAaSQazwW8U9yNHWu8KP2l
 hx8JIpiwJqMoilz57TxYmmomvgpOF22k8YzLCCUHFE0+ImRNmtbKThu0d9aycxDTyxoX
 HfiE4jdPLhIsbZy6dMx8C4hw1p6sGBuXDHyHMHsMQUISTHvHLjsYB9FiKWw9FaUa9Wc9
 n4gfPIwymK0HUiBlYywUo06d4XT24SxzU5SN1ilu7K0LnVZ6yiHUGdO6tzXY5OkTEGr/
 kH51nTznsN24vs5R5RN+jA2jZ1gWX9SsoV3SoyJCDno0KHwHAApyPkd6Fq/JitmON85i
 mwXQ==
X-Gm-Message-State: AOJu0YzVM7ox1VNXy+Ov1cWrKRsTe1t7CQYGOow0DsV44Tle6u0Pa/GK
 YgrEd/OJiEgjbd6buu4yKvAlixtEYPFe8aWyFV7y/dOMJ7g1kleIcVqHLFnQzW0=
X-Google-Smtp-Source: AGHT+IGHiby9diI9TREoPopm6V97A5jRa669kOhxaCnubzBKU+/06WhRBcyqYFoETgKftG+K9SNPVQ==
X-Received: by 2002:a05:6e02:505:b0:361:933c:3afb with SMTP id
 d5-20020a056e02050500b00361933c3afbmr1644171ils.50.1705611011942; 
 Thu, 18 Jan 2024 12:50:11 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:321b:4bd7:3071:22d6:a756?
 ([2001:8004:2728:321b:4bd7:3071:22d6:a756])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a63e748000000b005c6e8fa9f24sm1980383pgk.49.2024.01.18.12.50.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 12:50:11 -0800 (PST)
Message-ID: <3cb918ca-27cd-4f1e-8738-306dc5280f42@linaro.org>
Date: Fri, 19 Jan 2024 07:50:03 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
To: Deepak Gupta <debug@rivosinc.com>, Alexey Baturo <baturo.alexey@gmail.com>
Cc: zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20240109102930.405323-1-me@deliversmonkey.space>
 <20240109102930.405323-4-me@deliversmonkey.space>
 <CAKC1njSLR614zQk0_DAgYN1jjdg=0eUa7N1AEwwXZVNN6BwjmA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAKC1njSLR614zQk0_DAgYN1jjdg=0eUa7N1AEwwXZVNN6BwjmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/19/24 04:21, Deepak Gupta wrote:
> On Tue, Jan 9, 2024 at 2:31 AM Alexey Baturo <baturo.alexey@gmail.com> wrote:
>>
>> From: Alexey Baturo <baturo.alexey@gmail.com>
>>
>> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
>> ---
> 
>> +
>> +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
>> +{
>> +    bool virt_mem_en = false;
>> +#ifndef CONFIG_USER_ONLY
>> +    int satp_mode = 0;
>> +    int priv_mode = cpu_address_mode(env);
>> +    /* Get current PMM field */
>> +    if (riscv_cpu_mxl(env) == MXL_RV32) {
>> +        satp_mode = get_field(env->satp, SATP32_MODE);
>> +    } else {
>> +        satp_mode = get_field(env->satp, SATP64_MODE);
>> +    }
>> +    virt_mem_en = ((satp_mode != VM_1_10_MBARE) && (priv_mode != PRV_M));
>> +#endif
>> +    return virt_mem_en;
> 
> Obsessing a little bit on how to test PM enabled binaries with qemu-user.
> If we return false above then we're not allowed to test binaries with
> pointer masking enabled with qemu-user.
> That use case is not required?

In a previous round I suggested that the ifdefs are not necessary.
But for now it will always be off for qemu-user.

At some point pointer masking will be in hardware, and the kernel will gain support for 
it, and there will likely be a prctl() added for it.  At the point the kernel finalizes 
the API, you will be able to enable pointer masking for qemu-user.


r~

