Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFD678E343
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 01:28:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbUby-0007ah-B3; Wed, 30 Aug 2023 19:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUbo-0007Zy-U6
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:28:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUbm-0000Pd-M9
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:28:24 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c0db66af1bso1326215ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 16:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693438101; x=1694042901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GrpQJ+QpBGDmLT+wKIjPVDrMi3k/GUxMvgBlSAkAIzQ=;
 b=C0p0Agx8+/tOnxEohojix1moqbWQSYvmI6vuAJeq+bHFDPeWuwEuRPA/qPcB/+dM9s
 ZbVr1+Z4cjILHi18Sr/L/sABk12gFBCwkAU4IWMHXCulz/Ovdb4FUJ9bxmniZaDz5lMe
 Q2PpE2xW3pgiIbylHlwnEImTQMyhyj9/qM6lSCo0O5xMFZCl2D9A/Igw3TU9HIWN1fsn
 B8feaBax9XrlkaBGn4qZv5uGcCmTGbzCut7nnkEtkWBCQoX4WJNmbZsV7axsG4yOjhu3
 561ztajirvWwv1tOC6DyhNgenkeeM+vgIvY6/IxKzfNIKf7VF0MgVEJJxtV3VtfYJfGy
 8wMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693438101; x=1694042901;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GrpQJ+QpBGDmLT+wKIjPVDrMi3k/GUxMvgBlSAkAIzQ=;
 b=ht2DLF9+54m+UwL6gE/H8e7oRJnu+vLVQBPQdHKtPdCqvfIjOLDiyDCVp150iZ8z1B
 hqV3fELO5HmEQTgUGYoRbMvB8m5b4vg5wEgBDidbtEj57Kx0Qokt0PN8YsdMLnggnFe1
 CCfdra78c++UvTklfObHi5b2iI0bUhz3gOlJMiLqt+L0x+Rwu9NEgY7yZxczqzf1h3Gc
 29znRomUcKq+44wGxrkkdcYcc3qrNYd/p6qD1oz0FyQ9aa0647rL6P3ATIW1J4HMoXBf
 XptIo6MYx8HFWkOwzByY1wyqciHuA2taUYcpO3W7GWp4oTOCQU+CHA1YerzQoAXMKSKM
 4D/w==
X-Gm-Message-State: AOJu0YxIvSUAjjtCWZ64HjyibioXpkvg2yGsULDOV0czUhP5VI3MbkpV
 ANV4ueqkjChbibBpbxN24TKT2ZrVFM1IxtNUFwY=
X-Google-Smtp-Source: AGHT+IFAAOwWFdej+a2vHWBza2BvBu+eLtPz26awmkX+qkQRN3ymRlNLHirfk3iTpVfyYpGONTYXzg==
X-Received: by 2002:a17:902:ab93:b0:1bb:f1d9:432e with SMTP id
 f19-20020a170902ab9300b001bbf1d9432emr2930145plr.37.1693438101293; 
 Wed, 30 Aug 2023 16:28:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a17090301d200b001bd41b70b60sm46772plh.45.2023.08.30.16.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 16:28:20 -0700 (PDT)
Message-ID: <0b099d0a-1a8f-7dc7-0fc3-cebeae717513@linaro.org>
Date: Wed, 30 Aug 2023 16:28:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 35/48] target/loongarch: Implement xvpcnt
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-36-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-36-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> This patch includes:
> - VPCNT.{B/H/W/D}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode                | 5 +++++
>   target/loongarch/disas.c                     | 5 +++++
>   target/loongarch/vec_helper.c                | 4 ++--
>   target/loongarch/insn_trans/trans_lasx.c.inc | 5 +++++
>   4 files changed, 17 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

