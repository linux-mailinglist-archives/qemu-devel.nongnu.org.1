Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 788177B56CC
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 17:40:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnL1O-0003pn-U6; Mon, 02 Oct 2023 11:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qnL1M-0003nK-Fb; Mon, 02 Oct 2023 11:39:44 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qnL1K-0003EE-PV; Mon, 02 Oct 2023 11:39:43 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c60a514f3aso116843725ad.3; 
 Mon, 02 Oct 2023 08:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696261181; x=1696865981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xdG0wQ9/Qmn8JLemKxJFsNQSVmuHpRqBejR/wjMiqq8=;
 b=fIATLBT79fEqLKJuXeQHS7S2PDItJLhUttdGkFREr/xxhqzDdGy8aaRU0+YOWMg/ZC
 MoFS4g74GHlDTqdlZtcNXSeKfhkR3MsmakqjE2bBB9XkJ2Pthk5+WK6224Ekfi7a1iEk
 W3uNn30a0xLW1X26t50T5FAyWWBgXw9vDUUmh/X/371EQU2N5gjM+nleOZvtRTPyKS6o
 5ogJooXZqYPNI8TEMRMmfOTPQmqliYrbr1XhFvsxbBW2vmqYGN1Dkgf3j464pNTBootq
 lCutBsq3kLvTStS2flf3SAhozStll2Dcw3Ga0rdNQzBGtBKZNja6tk6AUj14PKhMeWlJ
 d7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696261181; x=1696865981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xdG0wQ9/Qmn8JLemKxJFsNQSVmuHpRqBejR/wjMiqq8=;
 b=CHEf8NP8x6b20CnJE99i1L8Cv1CQqtY0sZ+7VOVC9zA1s+xGOuT/lDGu/pVB8okczO
 pq7V+QbTkqCLJjg0Kkm6Qu1WHppkQLqzQ0qEYFPxYqI9XX3zI3gMAa5De17Y32ZZ1QQB
 UchDcph9EgVqcpeSEpLfqFzZP9Tc4pCibu56iJhRshRJm+2uX9vAcJAYjBlOkEHoSqM0
 reqyo8llmvIgMs8QjYes/idPwBHeDPWwUXSCEEXcUCToBum0nVKI48mF4vV0bBecnMbL
 7rovCa2HVJQCzuOgK36zV/LJbxDBVQSLO4s4EMCh3i6SaQnTuPQHBkJABwIDkX9mmbb4
 YExA==
X-Gm-Message-State: AOJu0Yw8yeQpk4n5/xoQjsdsGAExHxhjDvGDGBPVmQOAfPPXjdt0w4Iy
 PB5P/y8NJUFoJnFc56X6gs0=
X-Google-Smtp-Source: AGHT+IG+QxGYQCvqyoU0O7+dJkqwiaMTPCQnshcLVpIHI6Y3YzEgO7xfD1fCeQ5HCLQ7oHh87y8TBQ==
X-Received: by 2002:a17:902:d2ce:b0:1c3:ed30:ce0a with SMTP id
 n14-20020a170902d2ce00b001c3ed30ce0amr15934783plc.19.1696261180823; 
 Mon, 02 Oct 2023 08:39:40 -0700 (PDT)
Received: from [192.168.68.107] ([177.94.15.124])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a170902820a00b001c1f161949fsm22027037pln.96.2023.10.02.08.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 08:39:40 -0700 (PDT)
Message-ID: <3abfd6bc-e925-7f47-74a2-f4d368d61a3a@gmail.com>
Date: Mon, 2 Oct 2023 12:39:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/8] MAINTAINERS: Adjust file list for PPC e500 machines
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
References: <20231002122326.365368-1-clg@kaod.org>
 <20231002122326.365368-5-clg@kaod.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20231002122326.365368-5-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=danielhb413@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-2.321,
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



On 10/2/23 09:23, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2bf7af9bd150..23ce59995d59 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1357,6 +1357,7 @@ e500
>   L: qemu-ppc@nongnu.org
>   S: Orphan
>   F: hw/ppc/e500*
> +F: hw/ppc/ppce500_spin.c
>   F: hw/gpio/mpc8xxx.c
>   F: hw/i2c/mpc_i2c.c
>   F: hw/net/fsl_etsec/
> @@ -1366,6 +1367,7 @@ F: include/hw/pci-host/ppce500.h
>   F: pc-bios/u-boot.e500
>   F: hw/intc/openpic_kvm.h
>   F: include/hw/ppc/openpic_kvm.h
> +F: docs/system/ppc/ppce500.rst
>   
>   mpc8544ds
>   L: qemu-ppc@nongnu.org

