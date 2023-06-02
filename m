Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FE571FDF6
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 11:35:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q51B4-0007qY-E0; Fri, 02 Jun 2023 05:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q51B0-0007qK-O1
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:34:31 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q51Az-0007C8-7f
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:34:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f606a80d34so17611985e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685698467; x=1688290467;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ns5Obj7YSTA1BbthcxXqIgesV4zYidBvJSK1Ir8+lqw=;
 b=qe0rvnNuMD4J10pnio1Xo8NRe7Rt/w9W5ltrwTxafpxFkQPrVcM1tp9SpXQwNVJbDD
 5L+YswxcbiU02ERO0RE2GSbv+kCctnS2jowxZStnSFJeUbb7oejpcOMRZJ6O4DEDgN2N
 v/3gcJzyvzZKg6wdcaPYiOPqTGRBRdacYeGA/64oJKvbaQjWFJcXf1A0HRtDi1JsDvex
 QRt4n8WtuPIJ8JgjTyyeYSBx5zXYE2G6eA+UaBxiS0SYXvbsDsfbShwDJk+df7ecbleO
 yOVeU7NNoex2RL6nxD5Cydf+hRRPY88NC6QG34msWrS9T+YUAyp6bT/I1NqLU8K+tHuv
 OsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685698467; x=1688290467;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ns5Obj7YSTA1BbthcxXqIgesV4zYidBvJSK1Ir8+lqw=;
 b=ZOz9UbAU9T1z0BXvYFts90egV1UGMKV6YLTzdpeOef8vrhrst/VxOo7ztd2CUXgqpJ
 kZYGX8OC1NoZpb0A7SiH9cEyrm2ecexANm8IYinHBSuzd7gjHgPiMYkAkmsCeyBoGcBF
 7s8A6xaGJJRJyjpv1XWQkEeIs1358SXI+jYVP92jNv9bKw1o8wL8H/1JCZZSIB1EeP1R
 CqruvbjgJeUrZdqAk6mESoCWIy8ohRGIsJa8D1FizHsVgp8xrKdHRe6CgWmvWuHO2Ub0
 85Nwm+g7lefIO8WgNq0CT/7I3pbxJXb1OxYlWdSCGTbWMFkZ1mgLR2DopuHhjFKnoSaB
 LY4A==
X-Gm-Message-State: AC+VfDyWNz5J5ABJAcfNal79/5oEdExeXmfiswmSDXvb+QdE/C6YEKWZ
 FLISC5ykkfaRRfWLIJQcgHTutDapbBs95HUNBtE=
X-Google-Smtp-Source: ACHHUZ465nz8L70tg9Fxk0Payf104v5BYcZByNzzdVTo9OwlZexfKtkxyeHK439KpWrNyF1b2YIyyA==
X-Received: by 2002:a05:600c:294b:b0:3f6:20c:db83 with SMTP id
 n11-20020a05600c294b00b003f6020cdb83mr1468086wmd.16.1685698466958; 
 Fri, 02 Jun 2023 02:34:26 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a7bcbc3000000b003f09d7b6e20sm1405103wmi.2.2023.06.02.02.34.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 02:34:26 -0700 (PDT)
Message-ID: <d84544e5-ce3d-eec8-de20-2bda5b7f9d13@linaro.org>
Date: Fri, 2 Jun 2023 11:34:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 33/48] include/exec: Remove CODE_GEN_AVG_BLOCK_SIZE
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-34-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 31/5/23 06:03, Richard Henderson wrote:
> The last use was removed with 2ac01d6dafab.
> 
> Fixes: 2ac01d6dafab ("translate-all: use a binary search tree to track TBs in TBContext")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/exec-all.h | 10 ----------
>   1 file changed, 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


