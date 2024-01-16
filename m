Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FD482F281
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 17:38:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPmSG-0006lS-FI; Tue, 16 Jan 2024 11:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPmSE-0006kJ-7X
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:38:22 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPmSC-0004yb-Om
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:38:22 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d542701796so53892605ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 08:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705423099; x=1706027899; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=okimEG51+XiEmoQDSIqagcta5CU/94AI9Gm/k7SR8mE=;
 b=NNze2poRm6PPzMZ8O8QVuAGMVhXfBCl8MRmrfSYa4J+obDQQ+HyE95Ht3XrhRJYZ9l
 P19ufK9Z1R+fMCsno2I7f0NO1CfWODLwbyEF1M0L2DavaP7K2Sq9rZI5g8jCERlblFCC
 3aXMDj/J/i8LMlKe/4gsUMyCtLt5XGzwvl3caMJDsJFR1IrgBy5lqeDXyq28Uc8CfkTV
 wDjPft50VZSgyGtBgPGQAp8+8Tvul9M3UHzr3WumhG2Dag8ZzAbP5+pV8dIFDhd1F+Mg
 9XJhvTlhohiUrdBEUnJv4VUHsBlAErIEJQOR1PsiPxkbnWLUTqln8L9bLv+mB3ORaPIh
 PMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705423099; x=1706027899;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=okimEG51+XiEmoQDSIqagcta5CU/94AI9Gm/k7SR8mE=;
 b=Q4ExAf56s0uDF8E3rRvmTRbuCmLPWUE+qSdWYNSHiGiHuiy9MD8lFo8/9vfsCAa/qK
 yUhs9HyxqBN4ZN1mWkGYY+jxACFddhEZ54pi0+RT/nbbu2X7+jVea9JLcXTunVZBB3kJ
 S5FibKABCjHHTXvAdzcfZfOJbLWthXTfQX0/b8A0/C7ydhokqOQtY6OqkROOUUwqDmKk
 ytI8KtFwuUjng+uEAT54ZelYkZsmWV20XGG/YJuFNDboIV3PPonr4fG2xaohAmQPZVMc
 uHUhLz1fQTgYp68kGlfWeoM1Gku1NoMEs6ziBSxs3uUj6cdVMuKxDoKSujPL2PQHlaIl
 o+sQ==
X-Gm-Message-State: AOJu0YzO+OTLQjm3gCcNKHdOOQC1jJOh7yYLR0pVwr+I7khrB0mep0Gn
 Fk+AzaFrLeiKvaRTsVeI8CmgMAP1U2KCaQ==
X-Google-Smtp-Source: AGHT+IHWwfsi2XmF0fCkvyAtIU0+SPvR0TtEFM1yqKsemy8guP6AAvwJ1HH9abdq+XmSN58LQFCYnQ==
X-Received: by 2002:a17:902:e841:b0:1d4:3ef:2810 with SMTP id
 t1-20020a170902e84100b001d403ef2810mr4789698plg.107.1705423099018; 
 Tue, 16 Jan 2024 08:38:19 -0800 (PST)
Received: from ?IPV6:2001:8004:2738:1dd9:d367:1372:f10d:5a30?
 ([2001:8004:2738:1dd9:d367:1372:f10d:5a30])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a170902e18400b001d5e9bcc8b2sm1336580pla.308.2024.01.16.08.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 08:38:18 -0800 (PST)
Message-ID: <8ecba163-cd69-4adf-96aa-95f46a0d07e9@linaro.org>
Date: Wed, 17 Jan 2024 03:38:13 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/elf_ops: Ignore loadable segments with zero size
To: Bin Meng <bmeng@tinylab.org>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20240116155049.390301-1-bmeng@tinylab.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240116155049.390301-1-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/17/24 02:50, Bin Meng wrote:
> Some ELF files really do have segments of zero size, e.g.:
> 
> Program Headers:
>    Type           Offset             VirtAddr           PhysAddr
>                   FileSiz            MemSiz              Flags  Align
>    RISCV_ATTRIBUT 0x00000000000025b8 0x0000000000000000 0x0000000000000000
>                   0x000000000000003e 0x0000000000000000  R      0x1
>    LOAD           0x0000000000001000 0x0000000080200000 0x0000000080200000
>                   0x00000000000001d1 0x00000000000001d1  R E    0x1000
>    LOAD           0x00000000000011d1 0x00000000802001d1 0x00000000802001d1
>                   0x0000000000000e37 0x0000000000000e37  RW     0x1000
>    LOAD           0x0000000000000120 0x0000000000000000 0x0000000000000000
>                   0x0000000000000000 0x0000000000000000         0x1000
> 
> The current logic does not check for this condition, resulting in
> the incorrect assignment of 'lowaddr' as zero.
> 
> There is already a piece of codes inside the segment traversal loop
> that checks for zero-sized loadable segments for not creating empty
> ROM blobs. Let's move this check to the beginning of the loop to
> cover both scenarios.
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

But please report this as a bug to whatever tool produced such nonsense.


r~

