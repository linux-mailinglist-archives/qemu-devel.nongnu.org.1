Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E46D870E677
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 22:30:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1YdQ-0003Lz-9O; Tue, 23 May 2023 16:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1YdO-0003LV-Ah
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:29:30 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1YdL-00045B-RG
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:29:30 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2553b0938a9so121069a91.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 13:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684873766; x=1687465766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9/wMJejiQTOCASrIKD5di/z5ge9W0pxt5+IDh1iRxE0=;
 b=AHcwgyT3FjI//alOMHg/pzkAn6VgGfW28yGuBhev0afR/0Z42MizrN5AXPZvAWJQ5h
 LOSrZfNTfwm22OIW1wx5M8J7tryEn9i6JI+ZeNp6enKICbzFK2qsYn9fYVZAFL//JGL+
 Swwky5OMXQPEnykHgEQ7VlI1TGNni2gdZxsD8a85PCZ+3WHhNdEtxPyyfEOfVgWUX7Tw
 Zq2pB5ND+ubBGoITZH7u/iNyppVMEgYSudqm8UDoUJR0FCPTn0dld4/mwBkBYlCxKj2A
 FGFiAnZW1X3ACD5pWhHKa4bVZWmrrZwYl4ci079PEbSLgsCG2ZK2PVl5hhXod3GhBjwU
 s3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684873766; x=1687465766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9/wMJejiQTOCASrIKD5di/z5ge9W0pxt5+IDh1iRxE0=;
 b=cnI5PxMbhMV1NuSfCzG+vahG+K1psPjJW53A+XSil9G9nvVTPuYrSAokjQZ0v8WBQQ
 s7mFd4EXHOcvVSsfba9tlx37YoeHUFUKTb0WsprHuqh4sIWb5OmSS140geNZciaxrmw7
 sh1ZoD/V+RBktKSGqGWf0hKHpyCTvQfgJYGlVgxqqscQvQT+AinSddT/GsOUJ8pGzp4X
 QDphiFOLOyebS+2CUe4hRIfGu+NONaVym2mGm3TvQNMOzXjdW1p3FnuekELG3GzvxGTn
 1IJ9HyZQqGV6Y3HNDd4Ui3HhAobo61rpMBfYcSpar3QdNwVmWlxYH6DsHzdkouGOL5un
 XVMw==
X-Gm-Message-State: AC+VfDwGgEOtBGgWA/tOKCtrwy/aXBy4Jc2LkxnxY2DVN28HORvM+Gsv
 K9KYkqCB4QdMXoKMrpMSdThBdw==
X-Google-Smtp-Source: ACHHUZ5eVFTYqqppGeTkYuHbVDxdyNwFIIZTXKsVUEz9Y9L4z1ZIVAejGzT0Ir+2N7vk3x+5jbJRNQ==
X-Received: by 2002:a17:90a:f3c7:b0:249:748b:a232 with SMTP id
 ha7-20020a17090af3c700b00249748ba232mr15079986pjb.25.1684873766417; 
 Tue, 23 May 2023 13:29:26 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 ha11-20020a17090af3cb00b0025368c90773sm7921233pjb.34.2023.05.23.13.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 13:29:25 -0700 (PDT)
Message-ID: <73a27d8d-f0d4-3301-a857-1d5dc2601d10@linaro.org>
Date: Tue, 23 May 2023 13:29:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/7] target/riscv: Change gen_goto_tb to work on
 displacements
Content-Language: en-US
To: Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
References: <20230523135939.299246-1-liweiwei@iscas.ac.cn>
 <20230523135939.299246-4-liweiwei@iscas.ac.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523135939.299246-4-liweiwei@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 06:59, Weiwei Li wrote:
> Reduce reliance on absolute value to prepare for PC-relative translation.
> 
> Signed-off-by: Weiwei Li<liweiwei@iscas.ac.cn>
> Signed-off-by: Junqiang Wang<wangjunqiang@iscas.ac.cn>
> ---
>   target/riscv/insn_trans/trans_rvi.c.inc | 4 ++--
>   target/riscv/translate.c                | 8 +++++---
>   2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tar

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

