Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 893337DBFCF
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 19:25:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxWwH-0005AJ-UX; Mon, 30 Oct 2023 14:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxWwG-0005AB-HR
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 14:24:36 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxWwF-0000gG-2T
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 14:24:36 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso3749542a12.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698690273; x=1699295073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q/F2LVC0VT5W+c7zooeF+919O7d32953+DAfkmVd68Y=;
 b=SYCTycqc8p8obmRAcTAy4k/jB8b/tq+7u3krN+Gns6xjas8nvAjLLeyv9FMRfy0SLe
 0aymhW2m/ZrcqqGLLKVCFv/o2MlftrfK57CehA1819A2PuTCMCOCQZpUaWKFVrzT2CFS
 k1iVntG1Dvxa3OsswfnFESLLtFqHcEzBCmP4i3EtiNe8zq3aSYajjWTjnoNOiazNS4BW
 ++s/ExDzlPrq2rCLoQxm018Byiyf2d0OdhJfjauwgHOq/bvBAwAues6IojNykxKp0bs2
 39ljaptZu5T/f5FfQnhEH3bjRYkxXF3nm5TzTb74+TCPmzJ1NGsvi4MkAM9WhB1V4HBk
 jZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698690273; x=1699295073;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q/F2LVC0VT5W+c7zooeF+919O7d32953+DAfkmVd68Y=;
 b=YtRpgeqL+91EkAiowzh4FIcgRdiKtb484sUNEAfXrssyThZk683Qif/kxXtkENpxcJ
 tIsKaAo5qZzEz8CEAT7Kn82LObBvvQVnbDce76Kuvm+Ar/ttqvSJRUh8vXntvc8i66Pn
 ChpdQ9/XdIo29bOna+/hYIRu5xRIbDmpOsZ6MSJLOPFu7nGX/jlfiwJvVH9BqvtTyEGk
 HXxjsxXwV67IfKotEdBOBLqsY4TbTePWFIxT5e++Qw0D1qDsq7vuVanz7fxswlbSbRY0
 ktElxYY3ZFjMLEP8fqa/SHaStuRBY5k6KONDqTKiRPKqr0YOAtBB4c9cjMzQ7RVC9kEU
 uw+Q==
X-Gm-Message-State: AOJu0YybO1JK+tvNd7uf4B6uhwnPQuTnwf8oBhFVcuSWHgex48vkj+jY
 NUXEMxKtyNxfBBS1UocdEfEznw==
X-Google-Smtp-Source: AGHT+IFy7BUcSeteFtH4a7TIGR3ha3gNaz5CwmcuwfGh10Rky1RR7gtb5+AjdcApDmetsHgoyJ2XMA==
X-Received: by 2002:a17:902:cac4:b0:1bb:598a:14e5 with SMTP id
 y4-20020a170902cac400b001bb598a14e5mr9390152pld.43.1698690272837; 
 Mon, 30 Oct 2023 11:24:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 m8-20020a170902db0800b001c9bc811d4dsm1609395plx.295.2023.10.30.11.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 11:24:32 -0700 (PDT)
Message-ID: <0a5891de-2177-497b-9489-2e2aed05918c@linaro.org>
Date: Mon, 30 Oct 2023 11:24:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] target/arm: Fix various FEAT_MOPS bugs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231030174000.3792225-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231030174000.3792225-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/30/23 10:39, Peter Maydell wrote:
> This patchset fixes some bugs in FEAT_MOPS that were encountered
> by somebody trying to use it in qemu user-mode:
>   * we forgot to set the SCTLR bit in CPU reset, so all the
>     insns UNDEF
>   * we weren't reporting the hwcap bit because of a uint32_t
>     vs uint64_t mixup
>   * we didn't handle the case of SET* with Xs == XZR correctly
> 
> This set of patches fix these issues.
> 
> thanks
> -- PMM
> 
> Peter Maydell (3):
>    target/arm: Enable FEAT_MOPS insns in user-mode emulation
>    linux-user: Report AArch64 hwcap2 fields above bit 31
>    target/arm: Make FEAT_MOPS SET* insns handle Xs == XZR correctly

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

