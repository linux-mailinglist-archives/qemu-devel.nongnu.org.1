Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E90E944A73
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Aug 2024 13:34:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZU3t-0001lS-QE; Thu, 01 Aug 2024 07:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZU3s-0001ks-I8
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 07:33:36 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZU3q-0005bc-Vk
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 07:33:36 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fd9e70b592so48303725ad.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 04:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722512013; x=1723116813; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AikQYzZLvJC1qAr5mnVkHuc3qnQ4VJKU1Kq1tgMFSIM=;
 b=fUhoFkValWUCgqfeorBf6hRTbjMBy85Cqz1Ver9qGoYPDJotCuQIx1oA3fmXq+Hbkw
 JWHsvYueY2rmAd2Dx4jVD4zTe8KwJ4AoJT/w3UbHrJU7UilOeu57YaS4LJIZUafJJq+I
 0Dr9f/9oCtapt66DpD7S+y3OE+kF0lnvB1sNPAerVanetOE0gUZw2M0CJhakGINeFXC9
 ApeceO3SpCzq1gX+NGDF7zTlQzGr6WdB2US3aTZxEiof4+jNvkF6eIZvfUXhlmisLCKB
 AublI7kxgddgYq0xrFg57Lzb/CsWFW+CGkqvGsfdJwdcHgjoAp7Tbrm0dpxT/mi+1AL6
 EfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722512013; x=1723116813;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AikQYzZLvJC1qAr5mnVkHuc3qnQ4VJKU1Kq1tgMFSIM=;
 b=HSvqtSB3V2dkr4+l+RI1lpUDoIr3vOihX/HYagnS1AgD+YfvZ4UKCYoJxbQfyCQ97u
 xCGHRVdK/R0BEPNVvAldgdXlEXgdtsUm0yWTa10X1/M1/tuKll044hSxnFfqe1f/C0hQ
 wbxbkJRwBqAdy0WUHLaIGVtEzlL/NAKwMGUidpF9DV6wSlCr1jqwFHV2AypX7vbxDe+J
 nyPzzugQnwwxn60LYjWAJqjr9lQBp+kk/NxfTF4hEvZIGE3UPr/Qh1X7ya9qE2Qs2unR
 SbzWYRx/zEZyZLMApiahyB2O6dgEHroBDRIWawhr+KgUrwUxyVKZTTNodMcVsAZ11VSa
 tW6Q==
X-Gm-Message-State: AOJu0YxjiNALePfz+86d1owG/VmhcZrGoaS704Kb+CAACdwOK5Mz5dQ9
 ER2yTzjbh+CLphVUk6i5nVTGIKs7F22dyzqM9X3ED3djby1EugGTEH7BzCdXHn8=
X-Google-Smtp-Source: AGHT+IHO3OEx23NTGtwtbjYkauzVaNO+tjRCqHIoEFgxqZYAS3VQg718fJMxSXvrZIedbVHGTenKVQ==
X-Received: by 2002:a17:903:2308:b0:1ff:493:8de1 with SMTP id
 d9443c01a7336-1ff4ce70206mr26477655ad.1.1722512013144; 
 Thu, 01 Aug 2024 04:33:33 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7fb497esm136333995ad.268.2024.08.01.04.33.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 04:33:32 -0700 (PDT)
Message-ID: <0cbb34e8-fa32-469a-a516-4f9ac91a6eff@linaro.org>
Date: Thu, 1 Aug 2024 19:12:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/24] target/riscv: tracking indirect branches (fcfi)
 for zicfilp
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-devel@nongnu.org
References: <20240729175327.73705-1-debug@rivosinc.com>
 <20240729175327.73705-6-debug@rivosinc.com>
 <ed23bcbc-fdc4-4492-803c-daa95880375a@linaro.org>
 <CAKC1njQJiNHT1b2jD009zsNeXrUZ9OG2S4VTeFmnAS4c_f-kAA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAKC1njQJiNHT1b2jD009zsNeXrUZ9OG2S4VTeFmnAS4c_f-kAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 8/1/24 16:59, Deepak Gupta wrote:
> hmm... you've suggested below to use `aarch64_tr_translate_insn` and
> check if it's the first instruction.
> and put the check there.
> In that case I won't need FCFI_LP_EXPECTED TB flag.
> Then I would rather use it as FCFI_ENABLED TB flag.

You will need both bits.


r~

