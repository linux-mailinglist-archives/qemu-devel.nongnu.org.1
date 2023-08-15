Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 203AA77C712
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 07:27:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVmZl-0005yS-Rk; Tue, 15 Aug 2023 01:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qVmZj-0005y4-68
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 01:26:39 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qVmZh-0005Jc-4u
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 01:26:38 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3a80e665410so792751b6e.2
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 22:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692077195; x=1692681995;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MV0V3kG9qzs+b2W0oLtdOgsrrd10uQOnTxVp1e6/I9w=;
 b=nHKSh5cQG/n1y44C2RdBsw6glYxJfBFMqVm6l/RuExfUfUgEGRrPMnMjunhz8zhkFo
 T8C4fB+R7hHki4Of2WMIR79a+M1gNWBRkVu6kJoHKlqEhPV0AeQi57jt6AwlEelDMv49
 wx+UtiuWIj3r0jNcfjQwv+TUDRzyP8h5jY3NOaLvnMviybyfPTQJsPu8jWmJJoSPTANY
 dgGqsB/G8+pyv92U+tAIR2JubdJII5mBheqc0D6fA4E0Se1iqwie3dx14x5ubRLaxUKv
 5AcktVIVXSkH8fqMfrlBimamKZEVUtob+qIhZdNBL41t2GKuSUL+t7V+0Ra/YY4iACdn
 RqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692077195; x=1692681995;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MV0V3kG9qzs+b2W0oLtdOgsrrd10uQOnTxVp1e6/I9w=;
 b=Nov2mfdHVXl3LkRvucP5/uU5f7zWb2BHaoHaROr0TQP69Rdi3JIi01/+H3rQwfZ1pk
 k+8j9sTybxJOL0p0YI+04apfwWLVQg14OqFaRMQxzFILDuy1hKtnQSfDJiAjR+l0y8IQ
 lbVaNLGGwrkwbhz1p//fZwFMRzJSLcIjTGIKtSxlWmFqeI0uQehQED0SvkTRQsjaVOxN
 Pv4brcjrPX+pYAfpkmAgKs8BHd+PcNuZN+8Ex/ZZC85v2+LKOrHBvmeJ49s7tWFk0N8L
 FpR+vDldxkHUs2ZWW97VLGZJYArKITOHHJE06cQlxbKhko7SZ+ohDwKXqSWA0sYECLoW
 J75A==
X-Gm-Message-State: AOJu0YxaVXmVegZ7ZYOLV3bB3nqTsYYzFq4HbOlemcmxAVbsxWaQLRoZ
 Za3NlKN4zUBiZlphB6TvUUIhedZq5pub3ZvOMPM=
X-Google-Smtp-Source: AGHT+IE+HJMf/+r/j0i/kUKf6W5nsnpYy3duEWY7sTzMoZos3cTmZifq9arH2LkMgGem8ywFGB+wyw==
X-Received: by 2002:a05:6808:1148:b0:3a7:4e0c:faa9 with SMTP id
 u8-20020a056808114800b003a74e0cfaa9mr15717944oiu.29.1692077195363; 
 Mon, 14 Aug 2023 22:26:35 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6e91:84e5:6cba:4205?
 ([2602:47:d483:7301:6e91:84e5:6cba:4205])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a62e70e000000b00687196f369esm8706374pfh.62.2023.08.14.22.26.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Aug 2023 22:26:34 -0700 (PDT)
Message-ID: <3bd6e3f1-9775-69f6-baa2-7c1c9b9e63f5@linaro.org>
Date: Mon, 14 Aug 2023 22:26:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/1] late tcg fix
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230815021033.1090676-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20230815021033.1090676-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.265,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/14/23 19:10, Richard Henderson wrote:
> The following changes since commit bb5f142cb320d45d3d8dee2c82dae003cad39da8:
> 
>    Merge tag 'pull-riscv-to-apply-20230811-3' of https://github.com/alistair23/qemu into staging (2023-08-11 14:47:23 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230814
> 
> for you to fetch changes up to d3b41127c205062ca6c29c89c9542c4112c39ca0:
> 
>    tcg/i386: Output %gs prefix in tcg_out_vex_opc (2023-08-12 08:51:12 -0700)
> 
> ----------------------------------------------------------------
> tcg/i386: Output %gs prefix in tcg_out_vex_opc
> 
> ----------------------------------------------------------------
> Richard Henderson (1):
>        tcg/i386: Output %gs prefix in tcg_out_vex_opc
> 
>   tcg/i386/tcg-target.c.inc | 3 +++
>   1 file changed, 3 insertions(+)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


