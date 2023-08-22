Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 700C67844EA
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 17:03:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYSuZ-0003dw-HI; Tue, 22 Aug 2023 11:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYSuW-0003dL-R3
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:03:12 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYSuU-0008Eq-LE
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:03:12 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c09673b006so4192455ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692716589; x=1693321389;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1c3Q8P0oq0kEBXmp4eoqEIjCy2qbJINRMas9Qi46fYQ=;
 b=CUfRN75y/on1343CWxAMGlmRy6eC+N6x7wblxRRDzqQQqTNFHWb6nPVbLSDPJwPycB
 m0HHNkl4Y+LGY0kjSsvdDDCLVjj+0VRcf0JLGez3pzXJFgqkH4ywVcqp5SkkJlwCp+yQ
 +kHzjaRz8YYWF2Qevcp9L4zCkoRy0jNIGJtKKG4uYY203mrfEYScGKhV1xIjb4LT2dLU
 9gRk39NuaEdIrdebh1Vs/QBOjS0Nm6s/HL2JWj366lqNSE1Ie31joH0LZHi+HoC2iKqJ
 ULZfqnT183l6Tf+kwVEUoDBGxfFbQlx61PCgcIx3KHiW+d1V/KSvUmJLut+C04TrFMEJ
 yCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692716589; x=1693321389;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1c3Q8P0oq0kEBXmp4eoqEIjCy2qbJINRMas9Qi46fYQ=;
 b=KdN1Io3dDYaVV4wzu7Esp2n30Oyb8H3FjPA7OqrEbx8jIo4GgFbh6KYF+0Hc9fAVT7
 td2pgdiAxJgLFH1x8Fxy3LsLvJGmigChGi+2qf1LjCVyyel4AHnUup0SMSL9DGxmt0mh
 N7lqiJvJJT0oIYZCbsbL9h9UF1qWFLDJ2bc+YdzSlKWQDZ/FkuVQ13YFBzsbPhfVA+Ln
 nSq1fBEw/7db8opVcnK1LaVvj3fm0rC0rXijrFzJddp6+qLX/UdSxRlRjLGg5RHKYGd6
 9PLd6YoI1NiVTpHAQRjy7FYY2nSS+tS8CsxizQoOXS+S1YmFp5bxn41eSCv+yw3uUSyj
 r1Cg==
X-Gm-Message-State: AOJu0Yzam3SIxDDPvcc0gC/NjqT5WdoTyBFFvLHmw6//7S9bDmYV8AzT
 TXL7wXePP2qUIZ3mROceALxlhA==
X-Google-Smtp-Source: AGHT+IHHonsKPSe3UZedfXFiwKmPmCcYJ/Pxp+K25wAba0Iej2adeCAI5NUlHxy5FFTJg0+6wm0bfA==
X-Received: by 2002:a17:90b:300d:b0:26d:1eec:1fc4 with SMTP id
 hg13-20020a17090b300d00b0026d1eec1fc4mr6650735pjb.19.1692716588841; 
 Tue, 22 Aug 2023 08:03:08 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 8-20020a17090a034800b0026f90d7947csm1670836pjf.34.2023.08.22.08.03.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 08:03:07 -0700 (PDT)
Message-ID: <c4491b26-8056-77fd-4ad1-0e6eaf0b6f4b@linaro.org>
Date: Tue, 22 Aug 2023 08:03:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] target/microblaze: Use hswap_i32() in SWAPH opcode
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
References: <20230822110129.41022-1-philmd@linaro.org>
 <20230822110129.41022-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822110129.41022-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/22/23 04:01, Philippe Mathieu-Daudé wrote:
> Commit 46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}")
> introduced the generic hswap_i32(). Use it instead of open-coding
> it as gen_swaph().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/microblaze/translate.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

