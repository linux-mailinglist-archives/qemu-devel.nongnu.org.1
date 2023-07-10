Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C2274E1A1
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:00:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzqc-0000j3-Nn; Mon, 10 Jul 2023 18:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIzqa-0000hS-Pr
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:59:12 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIzqZ-0003Cw-7x
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:59:12 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3142ee41fd2so5112031f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689029949; x=1691621949;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gvpgUBF/HKCzBFvK/iuWBqO2W0GNNQBgIFNRGQtJMFM=;
 b=x8A1iHoqVPxmBO1BsjradUc8M0zNCCZAA0hGEYi2k+jUCB7vwxW6MadpK28Osz29Gh
 4eMznW6MEEMzmcr5/F5SeW4qrQUT1RIj7I0G0EbwqqJeDEzQkR3cpSXNFKdIT+wDGxu0
 x+GtTXLbMQAAUXsoaPFIFIObGwCYMbM1JvRUBEDfuxf0UC1GzQbV2+pBtzkbGorwOn9f
 Y95YePQLm6dcyB/TZ/TINY3ml8xa++w32A+CBroDD5wwUOFXYIpPtbQzM/qK7XR5V/4Q
 r+QjPejpObFfleh6jGh4EZdS06rK0kq1wfkfFwO+XLXknUQbt0LlMsaJBunwx8Xe4sox
 ZE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689029949; x=1691621949;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gvpgUBF/HKCzBFvK/iuWBqO2W0GNNQBgIFNRGQtJMFM=;
 b=kEiGDoZ1RhIHc8b5ZOaZR0EzK16v3WOuZCdr2kFdMdLaUfOuuDeyiXc+ZJUW056R/O
 x0HmD8TFk+/kIIPzkk2EZ7R0r1Dd9PKGr0Gq50qsczosUbZZCFh3j8l/8q3JNvLAnCYN
 r3RBL788iMWQio6VEwRJz6sZCDHYwd9GAiQH+WCiq1Yq723VaTKoBWo7TBkoOZh8gGsl
 8JAmLTpss7DGDkt8GhdRvGckXNn6FHc9KmOMGSDiLlLeUPs6PhjaF8BFxUI4aa8oiJyG
 izV4NkuEoaljvIvtkH2GU444n+gnPcYUjuF8miKIkclRmt5b7m+Okjp9gpqGVXAj3LUN
 IMuQ==
X-Gm-Message-State: ABy/qLa66k1k1KLW5ys8e/IrwgrpDqCYwYGi2a6bzbTplTpwAzbEOlL/
 W6eq9PfvSOWb4Mf0YkWQi0yUl2ok0I9hhB0BkbcuYQ==
X-Google-Smtp-Source: APBJJlF2rkHwM1PA/N8lFz4IC/OGOL/rBTQAgbCx8ZY0jFivfyFVCfYpqINJ6bxlmYJxQHBtmeHrwA==
X-Received: by 2002:a5d:4fc5:0:b0:313:ea84:147a with SMTP id
 h5-20020a5d4fc5000000b00313ea84147amr11542238wrw.64.1689029949396; 
 Mon, 10 Jul 2023 15:59:09 -0700 (PDT)
Received: from [192.168.8.133] ([85.255.236.57])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a5d4fc3000000b0031272fced4dsm580931wrw.52.2023.07.10.15.59.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 15:59:08 -0700 (PDT)
Message-ID: <5edaf40e-e503-cfcf-d1d6-f5064d409bfa@linaro.org>
Date: Mon, 10 Jul 2023 23:59:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/54] riscv-to-apply queue
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/10/23 13:31, Alistair Francis wrote:
> The following changes since commit fcb237e64f9d026c03d635579c7b288d0008a6e5:
> 
>    Merge tag 'pull-vfio-20230710' ofhttps://github.com/legoater/qemu  into staging (2023-07-10 09:17:06 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git  tags/pull-riscv-to-apply-20230710-1
> 
> for you to fetch changes up to a47842d16653b4f73b5d56ff0c252dd8a329481b:
> 
>    riscv: Add support for the Zfa extension (2023-07-10 22:29:20 +1000)
> 
> ----------------------------------------------------------------
> Third RISC-V PR for 8.1
> 
> * Use xl instead of mxl for disassemble
> * Factor out extension tests to cpu_cfg.h
> * disas/riscv: Add vendor extension support
> * disas/riscv: Add support for XVentanaCondOps
> * disas/riscv: Add support for XThead* instructions
> * Fix mstatus related problems
> * Fix veyron-v1 CPU properties
> * Fix the xlen for data address when MPRV=1
> * opensbi: Upgrade from v1.2 to v1.3
> * Enable 32-bit Spike OpenSBI boot testing
> * Support the watchdog timer of HiFive 1 rev b
> * Only build qemu-system-riscv$$ on rv$$ host
> * Add RVV registers to log
> * Restrict ACLINT to TCG
> * Add syscall riscv_hwprobe
> * Add support for BF16 extensions
> * KVM_RISCV_SET_TIMER macro is not configured correctly
> * Generate devicetree only after machine initialization is complete
> * virt: Convert fdt_load_addr to uint64_t
> * KVM: fixes and enhancements
> * Add support for the Zfa extension

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


