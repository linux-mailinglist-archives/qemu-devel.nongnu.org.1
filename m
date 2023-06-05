Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFCF72269D
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:56:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69kp-0008Vv-Ew; Mon, 05 Jun 2023 08:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69kk-0008Ui-69
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:56:06 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69ki-00077y-OY
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:56:05 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f735259fa0so19892885e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685969763; x=1688561763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SLI9N6LV3Pn3Em+tXxud0DvUBwYYAfPJbXmB1fEYpJk=;
 b=t1Vl2Hf3v3PjHtsglY4nY9LEiUBgGe5v1HuAPfh+6a1Nx67qSGT567xtctHoBEK29i
 yp1ejzXtIc7eintxQDxeIdZsct3GfPQ03vi6YSlKSILBJhkpvDRLKMUf8ciQ+es9rBRt
 hjYvTt8goI37PyqNdqMqG5m+3p70MbwLcSAs6vTI0UlPGebwRCPkxBKEMh5GychDR76H
 AxolULs6RSKLDWvEpyAC+HoMtzeFPufqXFvsPmO6ziHeB2zWFqWIkI39GLmZEswOC/MC
 f/HdA4Yd5KAN9ll6MENpfErJiYX7c3BcGK34ER6YPottXj0NgfG/T4T/qjYNdxf6Z8av
 orlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969763; x=1688561763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SLI9N6LV3Pn3Em+tXxud0DvUBwYYAfPJbXmB1fEYpJk=;
 b=ePYK5QsWMkyt7In6MMBdodhUR0i6LzwTufxQv74+1UEotIAqNdJSTy5ypXEEOierAq
 MS4G6/L4HdQehTeWUK1QmMgSr+LWnyw+rJPq4ehGIqorYezZ0MsVnDG8udAnZUUU377E
 EJdOlZW1KYbPsoTGK3mcZrSi5+8rB2r6knl1Q/oP/uZ3HKHs4lJiLlVvmRb9wIM8/myY
 NI7FnUZhuANDxeg2d1dY19UaPDQttrV7HpEYEZP+/hvOZXibw/2o6cS/IGB59dPe2MGZ
 u/U6jqGl3q1YPjnym6rhMLGyQq/Ccn/0g+gFx2WkViY/mfIW2r3YHwAkKYh7TD28TZMJ
 nMgA==
X-Gm-Message-State: AC+VfDzmcDSRDVcxcAFhcQ9+pUG/4OwpDvyZhCNes3oQeykmWJlvgFLl
 //bVi0e6Wv0Y5P1XyYt/AkL+ORGsI/EI6LU4law=
X-Google-Smtp-Source: ACHHUZ5PAB0og9RZd8tCoOd7uHWY9HyHRqICF+FMk/N927x4PnpydD2rSmyq8T71lUZXe5MeNGCucA==
X-Received: by 2002:a05:6000:1b03:b0:309:3da5:be89 with SMTP id
 f3-20020a0560001b0300b003093da5be89mr5888295wrz.71.1685969763137; 
 Mon, 05 Jun 2023 05:56:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a5d5102000000b0030ab5ebefa8sm9703596wrt.46.2023.06.05.05.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:56:02 -0700 (PDT)
Message-ID: <523de2d3-4e6f-0d5a-ce9b-8b873e136d00@linaro.org>
Date: Mon, 5 Jun 2023 14:56:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 08/15] linux-user: Use abi_ullong not unsigned long long
 in syscall_defs.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
 <20230603222355.1379711-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230603222355.1379711-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 4/6/23 00:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall_defs.h | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


