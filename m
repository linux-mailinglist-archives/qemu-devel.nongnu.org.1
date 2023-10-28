Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ADD7DA8DD
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:20:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwoqA-0002Pn-0b; Sat, 28 Oct 2023 15:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwoq8-0002PW-PC
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:19:20 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwoq7-000874-3Q
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:19:20 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b2e73a17a0so2005478b6e.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698520757; x=1699125557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dphfOE6vHSD/14MlcBGwFt4SYtewL8qMwKpJb3tLHcY=;
 b=DaI5uvEjx5iTgDcRltXe/kM+yXvAYga0VIqLcHgcklcbremf7cco95aOjUoymgmBF3
 Z/fjsDKfZexZlZAaa0DN9TwsIjtGBRR1j9rnaYjkm0EzDFt+/nwd2dFJ+31p38cgyWVE
 8848Zkm3O/n8c9mhIwCkdkDzHbH7yqzOVdJyK4UR7IWLyxxqkwdkXE8sFVAZ9XSPTCNU
 PsBiX2AcWY2Rpe3OPIBCZsnX+Cbd+gcUvPCLKJUA5S0/i9nzL1zIgLZw3jtyLg+ldV8u
 LceHL4drkWJHJ+nThtZrgoGSBCWAIkoruoZXOyp/AzpHVk747VjF5LXV0Ie5Z+fIaF/g
 PPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698520757; x=1699125557;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dphfOE6vHSD/14MlcBGwFt4SYtewL8qMwKpJb3tLHcY=;
 b=uvhmJinSgdFRc+upzoGb++CqL1iFCDPtrGjGJT/u2e7VpAqVLSy9C6gKzHoKILTCiH
 GwtgSL/NzbsG5Iac7Tzx61Sc12+u1nP/D2ptTgfeH8lr9pWwmgeuaWaL3PXdjZBqeEuc
 n04ETnck/fkHpT1cpRBZfst6IFpVjPl51OahRHDpf//WnrbeIo8xe8DYXsZ8calKoV1C
 ae/bOQvGybNajalHwax6dTm4WeLxeaIBb+5oAQ0Fz85J776ifjt1QAvwmKDRzQjWl1s3
 88MKl7BeZu+LaiuO6aAC3tlWQBmuf+SgZzDRB0xE8XLOScmxzN+X8NU3zLeJbot615Xx
 4kGw==
X-Gm-Message-State: AOJu0YxpXKzWuLVZF9gQlObaLJ0UX/BuFAEDF1KCRKZ34clFbN6J3Ozu
 pXnBFypoxNB2EvP5XTbID47cGA==
X-Google-Smtp-Source: AGHT+IH6XDQit0N0AkPLTRRQcpsv21b93cKwqoIUD04IllPAeIgKtA6/1Hypqrlmf2ANfa1KGRkPdA==
X-Received: by 2002:a05:6359:1a09:b0:168:e8e6:b91f with SMTP id
 rt9-20020a0563591a0900b00168e8e6b91fmr4748053rwb.18.1698520757443; 
 Sat, 28 Oct 2023 12:19:17 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a17090abd9200b0028012be0764sm2646030pjr.20.2023.10.28.12.19.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 12:19:17 -0700 (PDT)
Message-ID: <06c05aad-d91a-4c6d-9264-b9538b8c392e@linaro.org>
Date: Sat, 28 Oct 2023 12:19:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] gitlab: split alpha testing into a legacy container
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231028103311.347104-1-alex.bennee@linaro.org>
 <20231028103311.347104-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231028103311.347104-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 10/28/23 03:32, Alex Bennée wrote:
> @@ -278,6 +291,7 @@ build-user-hexagon:
>       MAKE_CHECK_ARGS: check-tcg
>   
>   # Only build the softmmu targets we have check-tcg tests for
> +# (skip alpha due to missing compilers, others need their own containers)
>   build-some-softmmu:
>     extends: .native_build_job_template
>     needs:
> @@ -285,7 +299,7 @@ build-some-softmmu:
>     variables:
>       IMAGE: debian-all-test-cross
>       CONFIGURE_ARGS: --disable-tools --enable-debug
> -    TARGETS: xtensa-softmmu arm-softmmu aarch64-softmmu alpha-softmmu
> +    TARGETS: arm-softmmu aarch64-softmmu i386-softmmu riscv64-softmmu s390x-softmmu xtensa-softmmu
>       MAKE_CHECK_ARGS: check-tcg
>   
>   # We build tricore in a very minimal tricore only container

This is unrelated to alpha-linux-user.  Is this related to tests/tcg/alpha/system/boot.S? 
Even then the change is larger than that.


r~

