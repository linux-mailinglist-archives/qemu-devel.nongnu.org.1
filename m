Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7A17F5DE4
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 12:35:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r67zZ-0002qU-Rb; Thu, 23 Nov 2023 06:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r67zS-0002o9-7X
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:35:27 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r67zP-0002SQ-6p
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:35:25 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3316ad2bee5so427621f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 03:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700739321; x=1701344121; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gb/9mpTegSgkpfjGfYLr5PJaM1omkYp059XCsfXHIMA=;
 b=MnVJ0gHmoLrIesFiz1aFwi32u/yewX1xckyVbLt22BDh7GAPJUTy7Cydb0MDEywYUX
 3q5RgwBU48UUsSM+KUjI5BPvuwN4kKsXDRBq23OWYnKQs78s1ewR16mo6d15JbVViPqa
 saLc23GvwEMRuUSjHe1hHkJlfZCAZMZrpxJLmMavg3ezLPDGLiOu6MuhYlVxs0SZwv7g
 rO8ulkIhjhsSncGVd3Y63dWsMRgselbP1jkjD+Tp3PPGanBotit0GXjmq6PFa0nv4xxA
 T9ndtOZQlu5lxSH96V7W/fqvJVjvFbXV516RvsRFrgSHv0j9YihEIX6/K6DP0F9amzH2
 xRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700739321; x=1701344121;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gb/9mpTegSgkpfjGfYLr5PJaM1omkYp059XCsfXHIMA=;
 b=gS0zLl+INgWEa1jh21zi4LlQk3mhUSdghS1ITyUrS21NOno6434ncYxls9dcbgHEQw
 FEoO8bLnBdE3+MFbNfC3cBUaUq2VuqPiX6O2H1cIgxWxiibAsgOsduoeuSNEGpVRGpO1
 +J8YrhzytoxRA12kq4JlR6YYi4xQ3LWl51Sp5+Lc7bd44f1GY+z0hEDk+yl9GsxD3M5T
 j8TjoeGTFYpmTw14AUNVRet+rPrPm7G3LPKGkapZtS4r9aZwFH9hsc6hezI/xoIiz5xm
 bAu3Zs97AVbni+ox76rTRR0qR7asd2eC0RdIbQDPyOMBGlak5l2L25Yiv0Vmb3y5SfSk
 5ncA==
X-Gm-Message-State: AOJu0YxGlHa/I7/mZs3TP8SuvJtXz48DqoVz7qKSDjYW+EmH/ysfjaF5
 mpLHa+N8S6z2be21335xNfD7iA==
X-Google-Smtp-Source: AGHT+IHECI4IPGZjcE3KNBojXqMU/NHVTnJNGWioNz25P+Sn+tFbbGirWW49EHqIfpRwaMN7Fj3csg==
X-Received: by 2002:a5d:5749:0:b0:332:e692:a127 with SMTP id
 q9-20020a5d5749000000b00332e692a127mr162094wrw.50.1700739321531; 
 Thu, 23 Nov 2023 03:35:21 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 x9-20020adfdd89000000b00332dc82f70esm1408239wrl.102.2023.11.23.03.35.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 03:35:21 -0800 (PST)
Message-ID: <201c37c6-bc37-483d-8e84-0f8bfa7f2978@linaro.org>
Date: Thu, 23 Nov 2023 12:35:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/21] target/arm/kvm: Move kvm_arm_handle_debug and
 unexport
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 23/11/23 05:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h |  9 ------
>   target/arm/kvm.c     | 77 ++++++++++++++++++++++++++++++++++++++++++++
>   target/arm/kvm64.c   | 70 ----------------------------------------
>   3 files changed, 77 insertions(+), 79 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


