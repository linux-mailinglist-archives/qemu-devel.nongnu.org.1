Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 289B082C1D1
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 15:29:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOIW6-0004hV-Ot; Fri, 12 Jan 2024 09:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rOIVz-0004gG-8L
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 09:28:08 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rOIVv-0001up-1E
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 09:28:04 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e68ca8ec8so3052635e9.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 06:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705069680; x=1705674480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l4/sArlAahq1MKWC9A5IV1cOthXjX+fytmnZdwTU7qo=;
 b=H2L9DyL0wJfU/I/eadt9rY6K2/h2se8ilZYFcQ8CjjJdModBd0JOuFmYCqaKzZ3DQi
 OdOWjKSmb7FrE1rQb9MpwOgdEM+kxKijMFScHIqwIUgwBjJodPnCek/E3CRzTUln+pKH
 ch8otJG0pgUOE42niBlc0o5epZtfSBDhAsK3YL3p1REZx0ay8t4VapRj25fzWh7iPNej
 31cxm1ADLi2jkl4I/mAUsT1F9mpyugd1q6KAIWR8KzHjd8TkFpJoZ967H5ffLE08QWBa
 uGmCAAprWzkdA2Lf/OfHMkRxR7sKitxaln+pvhkIv54La04yGXTUMgyktSUjffzrjk23
 plwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705069680; x=1705674480;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l4/sArlAahq1MKWC9A5IV1cOthXjX+fytmnZdwTU7qo=;
 b=exTm3yafzn12CWGxYeaMebNLZ7pnqVPGrzvHJh5F5GKgj2WkIhJcvDXZhCsoSbb/v9
 B9kSmZM9kxMc2cqa2pd14vJ/4mGHN87OUxOmwyA7FUD6OIupU0r5kFshUanfSKqNqg00
 zsUmnPWqlf7DgKPkgfIRFfjASP9SBBIW9i1FisFk2htE9BQ9w8SrCOn1okhDhnMCO4sP
 rcvZjSxoP8prKstsbcrqwNL1uhk5zfVDPg90DwlGJ/mx0nb2V36ot+aX97IOGvnUZ+rB
 lwyWp1GtrXoSCN49tq7ALea8jihULTF1i8JeGA6LevMiET7rEIB+wxFhZYKgYbApU/+r
 tbgA==
X-Gm-Message-State: AOJu0YzzJr05r+5b+S8eZK1EOisniafB6poeoQHZsI7XDn6o/2oCYWmB
 ibNBcJpcKz7nTgntHVFkxFWZ/qd8uMcgtg==
X-Google-Smtp-Source: AGHT+IFaN283KEZ8dBg6Gax8kdVc/w/bYZ4BF17Xat5gh7ZtDpndMmKoczwSzRiUDN8C9rnwJ1N4KA==
X-Received: by 2002:a05:600c:4f06:b0:40d:9057:68bd with SMTP id
 l6-20020a05600c4f0600b0040d905768bdmr773283wmq.111.1705069679997; 
 Fri, 12 Jan 2024 06:27:59 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 m22-20020a05600c4f5600b0040d5b849f38sm9992083wmq.0.2024.01.12.06.27.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 06:27:59 -0800 (PST)
Message-ID: <e10e21ea-0bf9-4565-9552-e03928610161@linaro.org>
Date: Fri, 12 Jan 2024 18:27:55 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] plugins: implement inline operation with cpu_index
 offset
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-2-pierrick.bouvier@linaro.org>
 <76fa391a-9f3c-4308-a84c-2b84ddadbb88@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <76fa391a-9f3c-4308-a84c-2b84ddadbb88@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/12/24 02:04, Richard Henderson wrote:
> On 1/12/24 01:23, Pierrick Bouvier wrote:
>> Instead of working on a fixed memory location, allow to index it based
>> on cpu_index and a given offset (ptr + cpu_index * offset).
>> Current semantic is not modified as we use a 0 offset, thus inline
>> operation still targets always the same memory location.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    accel/tcg/plugin-gen.c | 60 +++++++++++++++++++++++++++++++++++-------
>>    include/qemu/plugin.h  |  1 +
>>    plugins/api.c          |  7 ++---
>>    plugins/core.c         | 11 +++++---
>>    plugins/plugin.h       |  5 ++--
>>    5 files changed, 65 insertions(+), 19 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> For the to-do list: add mul -> shl strength reduction in fold_mul().
>

Would you like me to add a todo somewhere about it? Or is it a reminder 
for follow-up work?

> 
> r~

