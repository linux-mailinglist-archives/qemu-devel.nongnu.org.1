Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8924278E3FE
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 02:32:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbVaH-0001Ml-Bp; Wed, 30 Aug 2023 20:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbVaD-0001Md-GP
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 20:30:49 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbVa9-0003sQ-IE
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 20:30:49 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bdbf10333bso1885805ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 17:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693441843; x=1694046643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f6P6KafQ6w+cTgk4y3GyB7YeiDLuZC4+rLxDUlI+2vM=;
 b=xjmfIQcLHHYXwtMkB3c1/pyAQwrPgLcSFo+E7w0JuTV0jnsZvpEYL2msbd28+xHWPI
 Lbi54PzC+W3+DxFGQhjoB9TwyGxkieeJ31KpOD0X/Fj7hy1l7DE70iRVEmYi8jMrfrtu
 /qisbNOHUlQXF78YNo7dqtHUIwtDXKyEBOQcRnYIrJ3eHz9NvnwlRst3DI3ArtzvBI+2
 u/3PNsDO3rRGfMfKz52tlYYeh2ugACd9bVVutKfE+ZFQf0CvodwLSZjW9IKH9pdw+Fqz
 fQNRpfH2a+PknYoeH03Zg4J+Zctu5dbL1eR1U3wkLltwVjdhg0Z9+H5XpjQmz1uKFhBn
 hjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693441843; x=1694046643;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f6P6KafQ6w+cTgk4y3GyB7YeiDLuZC4+rLxDUlI+2vM=;
 b=JVGx1GIRAyGzjiIyosnMaFvye086GoFUgcKdsvzp5ZgH7mbGukuNR8KncBmzloKpRy
 6/XrfnDMEc+bKJZDCQvvIg1SkQaFS/HIC4UPUxJtVMnN2OX+M1yjjOWFcWNsEcrq4hRb
 7085O5LDYwjqath9qEGIV6NlG39TrKJkAZGg5l3svgrAqtv9lsbmBkZVWoS4ewiT/RG4
 guFOvOFsF5zTWDEoyYhlvl8w3rO6PBtIudgL0fzeIGyA40qJBJkutaBaqaOfTlaTFa9/
 HiXvMMEyopcECSyLSC2eAkMsDBG745NAqF5O7J7XP7Sk5PnfoJ1/l5xIAK0R3GY7Pf8m
 o5Mg==
X-Gm-Message-State: AOJu0YxuCMdEUjGMhPGO8+S1ZAvtFt+c7po9i0UMhd6Z0SlM7TgYkypK
 zkGbkqmHMn2+Frn858cx+d9pjBTgZ2Bw3aHmLY0=
X-Google-Smtp-Source: AGHT+IHtAJ7FETtL39Iy10mI8zPGnZoKW8fmz62BVpf8sCZ7uYgMJ8cyIAmdm/JPhYRZd1c53tR+Yg==
X-Received: by 2002:a17:903:22cd:b0:1b8:954c:1f6 with SMTP id
 y13-20020a17090322cd00b001b8954c01f6mr4398032plg.36.1693441843033; 
 Wed, 30 Aug 2023 17:30:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 p21-20020a170902ead500b001bc6536051bsm86845pld.184.2023.08.30.17.30.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 17:30:42 -0700 (PDT)
Message-ID: <1cace254-61e7-ec15-9621-528ecd5b91d1@linaro.org>
Date: Wed, 30 Aug 2023 17:30:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 41/48] target/loongarch: Implement xvfcmp
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-42-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-42-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
> - XVFCMP.cond.{S/D}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/helper.h                    |  8 +-
>   target/loongarch/insns.decode                |  3 +
>   target/loongarch/disas.c                     | 94 ++++++++++++++++++++
>   target/loongarch/vec_helper.c                |  4 +-
>   target/loongarch/insn_trans/trans_lasx.c.inc |  3 +
>   target/loongarch/insn_trans/trans_lsx.c.inc  | 17 ++--
>   6 files changed, 117 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

