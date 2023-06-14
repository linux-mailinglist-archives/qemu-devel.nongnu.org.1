Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E4172F3A7
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 06:40:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9IIe-0004IY-Ud; Wed, 14 Jun 2023 00:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IIa-0004HH-1P
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:40:01 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IIX-00028u-9L
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:39:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f8c65020dfso3287015e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 21:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686717595; x=1689309595;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cUBBWBw+uyW8UXtKIT+auAdqYC8/1Olp+XwvKN/be20=;
 b=MOTFgg2LsX+U6hs4zT6McB0uznikCQIYrhtUDWNSpsZrX+pd6RAqBxduogehOpP39H
 Pp3vE4g1q3c1U8zSsk3gTd9mq/m1Wh+QUT8o1OBoH8uUoKxGlSbblX7Gts//RKt0DrkM
 5hARQhZN0xHA1LpvIidlB0v0bYW800XpAL10tjLo5Mdb3jEHbTHr8r1I+JePQVMaJPzr
 wpKcL6I8abg/rM9IaCjIRAupXSTIccH9RzGHAIAT1R5Y1ARl1SkQu34wGzeL+XZtoMtN
 CXORP29WoEhvT8XgIl2m77nlM6TiOpwpS4gYHsJsBJkfQyCOSy75tNX7Kj6PrYkuoA2f
 7kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686717595; x=1689309595;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cUBBWBw+uyW8UXtKIT+auAdqYC8/1Olp+XwvKN/be20=;
 b=joa6BLOfMlPg3hE6MPobB9lo6iWmIqFvMPunOzV5SsYQLkWbfOWDdlk4xc0IM40POG
 fb0R5NSTPEwV130EKQh8DwCF6F7GIzRsR2LRjXbZqIOd7mi62U0XxO5hF+Hv54dE5IKg
 fEiEEmpEEuXGdvH6DoVBWtesKUJKIzg4WQO/M0GCkIkkM2LS+aUue5GYBsl4M2p6inQ8
 qQwlN8IU06TZBLk4bcHNYtVpGCxyN5pPmLraZdrc9HL11qRPU+aBKU9f6r2iM7s2o1Yn
 ORxVxUy/XJuPEidgT171piFE8i47MuH2o8Sg1wawRu5Z0FG5pg3fSAnQLEzNV7ITVpcO
 5RvQ==
X-Gm-Message-State: AC+VfDxK33/xhUFyUYwip0gTUyS9WOfqFPPrgDWi670uxd/8SrcwzArl
 DnGiSwDNDZSFjSkkfDq0NfSIWA==
X-Google-Smtp-Source: ACHHUZ7QTsUbnhOLBjrilwWLTB3Kx76qNkID5invyhTyDGI1QMNGGY05btuypgpsodR7p8OFaHO73g==
X-Received: by 2002:a5d:60c6:0:b0:310:fe5e:894a with SMTP id
 x6-20020a5d60c6000000b00310fe5e894amr727216wrt.6.1686717594863; 
 Tue, 13 Jun 2023 21:39:54 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 n7-20020adff087000000b0030ae5a0516csm16932122wro.17.2023.06.13.21.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 21:39:54 -0700 (PDT)
Message-ID: <13011115-c8f0-8bbe-be23-b892e95cd336@linaro.org>
Date: Wed, 14 Jun 2023 06:39:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/60] riscv-to-apply queue
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/14/23 03:19, Alistair Francis wrote:
> The following changes since commit fdd0df5340a8ebc8de88078387ebc85c5af7b40f:
> 
>    Merge tag 'pull-ppc-20230610' ofhttps://gitlab.com/danielhb/qemu  into staging (2023-06-10 07:25:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git  tags/pull-riscv-to-apply-20230614
> 
> for you to fetch changes up to 860029321d9ebdff47e89561de61e9441fead70a:
> 
>    hw/intc: If mmsiaddrcfgh.L == 1, smsiaddrcfg and smsiaddrcfgh are read-only. (2023-06-14 10:04:30 +1000)
> 
> ----------------------------------------------------------------
> Second RISC-V PR for 8.1
> 
> * Skip Vector set tail when vta is zero
> * Move zc* out of the experimental properties
> * Mask the implicitly enabled extensions in isa_string based on priv version
> * Rework CPU extension validation and validate MISA changes
> * Fixup PMP TLB cacheing errors
> * Writing to pmpaddr and MML/MMWP correctly triggers TLB flushes
> * Fixup PMP bypass checks
> * Deny access if access is partially inside a PMP entry
> * Correct OpenTitanState parent type/size
> * Fix QEMU crash when NUMA nodes exceed available CPUs
> * Fix pointer mask transformation for vector address
> * Updates and improvements for Smstateen
> * Support disas for Zcm* extensions
> * Support disas for Z*inx extensions
> * Remove unused decomp_rv32/64 value for vector instructions
> * Enable PC-relative translation
> * Assume M-mode FW in pflash0 only when "-bios none"
> * Support using pflash via -blockdev option
> * Add vector registers to log
> * Clean up reference of Vector MTYPE
> * Remove the check for extra Vector tail elements
> * Smepmp: Return error when access permission not allowed in PMP
> * Fixes for smsiaddrcfg and smsiaddrcfgh in AIA

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


