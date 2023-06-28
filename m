Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB9B74194B
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 22:10:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbUK-0001Nm-Bj; Wed, 28 Jun 2023 16:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEbUE-0001NE-9X
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 16:09:59 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEbUB-0005wn-9x
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 16:09:57 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-313df030ccaso260648f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 13:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687982992; x=1690574992;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iEuW69sfEvqBnPbokbE3p53YmPaHn4LFfEYbquahgSs=;
 b=VNzEdgEHDetg10zCYWoLW59h9sgLl804LSJ50rQNRxjyvj5WTBJuLR4p4y32tGB43V
 cE5Lgdlu87pQaUYoX8r9ClyCZGMCOwRqJDwLvNrSNQ0E2IXunTN46SCKnefD3HxN7qPf
 6Iy9wCN7z1IjHTm3MDCEgPPLpI4AuuQ8uY9sVnsODH5RuA8+Ym5mr5rxPwkFsOa9lH+e
 V5i8mAKXoTuwqabbx2Ug1ZTKblLoXZS/r5+/+Zx5uIscG2MnnT5mS3E9C2UoAzjEQWXe
 GXfvaP5M+gXxjuucqBw9xSxG01YEb7criUYYImVM4yS0VM//ED9kBdllmkAN5Qt2cL12
 JJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687982992; x=1690574992;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iEuW69sfEvqBnPbokbE3p53YmPaHn4LFfEYbquahgSs=;
 b=YcFwL685at27DKZPJtOWzyotCxtbBWEWJXPzc7nqdpcnD1dPRx1ntrWmOymMP59qhQ
 uujEK1ZOgL/CGRCAhjOdAx9qYAjMeRrIKAbCNMvIRBZukv1wUyC9DfYuZqyVpquen0jj
 6SJIyhM6eMYK4cZKjW5a0Iy9ZTCLM2F27qo1Sq3cbb+F1W75z+djw6mW/NLskn/xKLy/
 LCqEctIYYa0YnK1kQBdIujjui9Ri1o60Xlbmy7/UrzdPbC3o9WrHEm2wjtQ57LizkFJy
 llTFNx4v24plYBb8UUpEOqvW0Xd1vbCGQ8m8Inw3rqBnRlgFqgG9aok/vnLbeAlm+7It
 t8+Q==
X-Gm-Message-State: AC+VfDzChDiozAMtQ0i0IzMAMxinpJnvN9K67Q+poXDiRKp9f4iePdvS
 mS32HL6Ndq/m4aGEq0nbhMmCDA==
X-Google-Smtp-Source: ACHHUZ4v/+nFYdce2Yl8aGSYi04rhImV2+G5ZUnSw/G8uu4umk+ni/7NlW4bp8Dfo0x9kRefbF/Sug==
X-Received: by 2002:a5d:63c5:0:b0:30f:cf93:4bb8 with SMTP id
 c5-20020a5d63c5000000b0030fcf934bb8mr28948912wrw.57.1687982992103; 
 Wed, 28 Jun 2023 13:09:52 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 r3-20020adfda43000000b0030ae3a6be4asm14166863wrl.72.2023.06.28.13.09.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 13:09:51 -0700 (PDT)
Message-ID: <441e8217-31ac-0fd9-1d85-e83f9fdcb3f3@linaro.org>
Date: Wed, 28 Jun 2023 22:09:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] target/arm: gdbstub: Guard M-profile code with CONFIG_TCG
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230628164821.16771-1-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230628164821.16771-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 28/6/23 18:48, Fabiano Rosas wrote:
> This code is only relevant when TCG is present in the build. Building
> with --disable-tcg --enable-xen on an x86 host we get:
> 
> $ ../configure --target-list=x86_64-softmmu,aarch64-softmmu --disable-tcg --enable-xen
> $ make -j$(nproc)
> ...
> libqemu-aarch64-softmmu.fa.p/target_arm_gdbstub.c.o: in function `m_sysreg_ptr':
>   ../target/arm/gdbstub.c:358: undefined reference to `arm_v7m_get_sp_ptr'
>   ../target/arm/gdbstub.c:361: undefined reference to `arm_v7m_get_sp_ptr'
> 
> libqemu-aarch64-softmmu.fa.p/target_arm_gdbstub.c.o: in function `arm_gdb_get_m_systemreg':
> ../target/arm/gdbstub.c:405: undefined reference to `arm_v7m_mrs_control'

I'm a bit confused, isn't this covered by the cross-arm64-xen-only job?

> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> This is a respin of:
> https://lore.kernel.org/r/20230313151058.19645-5-farosas@suse.de
> ---
>   target/arm/gdbstub.c | 4 ++++
>   1 file changed, 4 insertions(+)


