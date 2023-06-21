Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A25A738747
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:40:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBz05-0004yt-Qg; Wed, 21 Jun 2023 10:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBz03-0004y2-AR
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:39:59 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBz00-0007LG-Dv
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:39:58 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-988689a5f44so464434866b.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 07:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687358395; x=1689950395;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SGtMTywOuUUyYfQBn0axmk2QY1A0tbrfESUEH6k05r8=;
 b=Cp5E2r4s8e9d9vmbz43S4PHG9d6011IrvDEnKNjXAi2Er1Iy8T11x3PdtKqSsYRLOh
 2BsJyuXXXZ5AK4+ncTEOqwIiSulxpXVShZlSPD1qjLxly3wNGukXLol5huEyebtW8+Kp
 UGlZe2DhO5qGf3xbPvrr+0U4eCSac6LhH4sUnxw9kjyoFNxj/oo9q/bESacgop+LiTUQ
 +Pu74iZWisXTFXXtmxT/2PqlGJZCSonIyLxodsxv9bVdeQQl6+GBQ48VmiPPk4Wqasrr
 tYH/DZ/a14brSUyEbYD/7CKinac+U9kcdWXC9Bsv7MiphDOTN0fks7Rlmo+4lpglhKEA
 CT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687358395; x=1689950395;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SGtMTywOuUUyYfQBn0axmk2QY1A0tbrfESUEH6k05r8=;
 b=hFF2ZNvEp4zhutVYjcnfcsESZnUnioXmYEIWtcWMxQgiT+bV9GzGJnBqky4ZFFoCNI
 cF7Fs65jD5kZd9ME2wYtmYaLgFYcv403t73RzgWwoEUFRjjk2C6AJrbT6IcgOcaEyvES
 mZASn22sOKNt81p7iG+pTr4ghxAN63eMZxY+z6Ng7nbj+CsUom66q0NdJTN9DEeY4SAK
 eL7tq7+hb22PQUmHy0U44oY9H+HiqN1+v+cfsBLIB5vC5Bbn0Pl62LmrrJ6f2V2UQzdw
 uEgLk/Ehmd2ftJquwik76Ve7WdAteY5Av7rS3JQSuboM9m4FGRWII99DYpzAbq9bONs4
 u0Rw==
X-Gm-Message-State: AC+VfDzMDeUjQ6UB71EH7+wzn3X3Zvlf0fj2o2wH7JbySfInVebRWCfK
 z1MabUP6bnyN3moLXKc8JHreqa7AugKqFnMDon5Mrfjn
X-Google-Smtp-Source: ACHHUZ5TYf0Dbb8VKvBaPMJZPmXapC6AbYIQUNHclsxCNIna3PC/RTrkwRGpOUZ8hJTkGLh7C7MAvw==
X-Received: by 2002:a17:907:3e08:b0:982:79fa:453d with SMTP id
 hp8-20020a1709073e0800b0098279fa453dmr15803910ejc.73.1687358394750; 
 Wed, 21 Jun 2023 07:39:54 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.128.70])
 by smtp.gmail.com with ESMTPSA id
 r27-20020a170906281b00b00988cfb8ccd4sm3241236ejc.142.2023.06.21.07.39.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 07:39:54 -0700 (PDT)
Message-ID: <36cfeeae-0852-35ef-6323-18d2d9765670@linaro.org>
Date: Wed, 21 Jun 2023 16:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 8/8] target/tricore: Fix ICR.IE offset in RESTORE insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230621142302.1648383-1-kbastian@mail.uni-paderborn.de>
 <20230621142302.1648383-9-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230621142302.1648383-9-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/21/23 16:23, Bastian Koppelmann wrote:
> from ISA v1.6.1 onwards the bit position of ICR.IE changed.
> ctx->icr_ie_offset contains the correct value for the ISA version used
> by the vCPU. We also need to exit this tb here, as we might have enabled
> interrupts.
> 
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
> v3 -> v4:
>      - Exit tb for RESTORE
> 
>   target/tricore/translate.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

