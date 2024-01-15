Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF4682E2B0
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:41:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVdr-00057N-V8; Mon, 15 Jan 2024 17:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPVdM-00056W-Ol
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:40:45 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPVdL-0000li-8Z
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:40:44 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d5c1c1cf58so12292415ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705358442; x=1705963242; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UQjOXFCCdXEUZ7BmttbQ6odKbMYn+G8Rcyt2evJdjMk=;
 b=oWXbkOpNk7S66p/EKkGI51WfmzallWIUot4MucLfOeXbUbATfpQOOkI6fs310Bf0Wl
 R6d9crVGjfU/+eHGabuYsfytGxofCV+hFcjhEDQXPpTC7qodLktkmDEsMRhMO2GwelHJ
 SfWCiNMHBTmodz/vTV87H1oV4HWhwfSPXHW7Fno0AwO9u88Ds1FpHv5ClqHJ7fS7H8mp
 xeFvhRNljV+o+O3XKABizFBJ5V2rrrxnsuI96AKyP+8OZKAPUzMQ4ljK8WwfxmcUnc34
 Qjn6fIpni8PLdcA718jlOejhCRh6ZHFIMRkZJd9yVdZNHEfaGKUVzxzwvq0ptuWyYajc
 92iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705358442; x=1705963242;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UQjOXFCCdXEUZ7BmttbQ6odKbMYn+G8Rcyt2evJdjMk=;
 b=RA/O0Obec7ARs6DEvglY+VyV72gNXfWmY27U0yljkpZ+mXUnG3e2J+Wxnyy4qFRRWj
 17fyunq4TXStw0rYthc+tVYHduLRrD9Ezk3++TvVIdCCGtgww5xRKbX527HgFJ++urdX
 L16xIivjyp3+QXe3t29SyV0ogNis2R2D4s/k/4EY27/azWHaWHe7IJIRrOspGT0Ic6cJ
 eEECuM/AVMrDNFxc9LXWQagpc3SXnJ1cVtwc8zslD4DFYm7QQINkTC5BRVYLt6oAHCor
 9y+kJzQPlHmN8lvly4qUi8fj+ifza1SA1aJVjuxiWQStoPtA/eAA3QbXFWe2ZAsRw8cK
 JekA==
X-Gm-Message-State: AOJu0YyeEcyb+3w0M7fvh9tNf17ZD3GlUbnw/j5Z0M5VmPsb3IECSE+v
 Sz8L5AnJZPJnlhG8Po+tsCLEwXRwC55C7g==
X-Google-Smtp-Source: AGHT+IEcJ3k/IXsYKnf3Oj9QM0FTHkpkw/23e7jZopyokchaq5Z7NwEU7u9z3Ke5/bIpe7BG1/cNtQ==
X-Received: by 2002:a17:902:8bc7:b0:1d5:73b7:5de8 with SMTP id
 r7-20020a1709028bc700b001d573b75de8mr7412740plo.49.1705358441815; 
 Mon, 15 Jan 2024 14:40:41 -0800 (PST)
Received: from ?IPV6:2001:8004:2738:1dd9:85fe:4dd3:358e:ec4?
 ([2001:8004:2738:1dd9:85fe:4dd3:358e:ec4])
 by smtp.gmail.com with ESMTPSA id
 mf8-20020a170902fc8800b001d58b7cb7c3sm8111698plb.90.2024.01.15.14.40.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 14:40:41 -0800 (PST)
Message-ID: <f64e26e6-c87d-4452-8132-fe7db67a5099@linaro.org>
Date: Tue, 16 Jan 2024 09:40:36 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] target/riscv/insn_trans/trans_rvbf16.c.inc: use
 cpu->cfg.vlenb
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240115222528.257342-1-dbarboza@ventanamicro.com>
 <20240115222528.257342-5-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240115222528.257342-5-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/16/24 09:25, Daniel Henrique Barboza wrote:
> Use ctx->cfg_ptr->vlenb instead of ctx->cfg_ptr->vlen / 8.
> 
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/insn_trans/trans_rvbf16.c.inc | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

