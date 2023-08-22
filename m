Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C2D7844EB
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 17:04:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYSur-0003ic-Fs; Tue, 22 Aug 2023 11:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYSup-0003gB-Ey
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:03:31 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYSum-0008HS-NJ
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:03:31 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bf5c314a57so15964875ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692716607; x=1693321407;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=21e3RkwAZ6G2atJiptcSykPHGMcVCJLE+pfi1imkcDs=;
 b=LrUz6k3SPOdd75/cqDSIP+CpDhtY9L+ibSAqxJMva3MgzXi6O6g5lx8eUNqCqiIILK
 d5sI0jUVTDEbnUsimvss8KU86ux8aFWj7iUHhHZ1bzkJ2CvooB8DVgG3KNl6EwcbZXO1
 hqPWBpOthoYZymArdVUI6zQZUU2PjkAz7fQ8haxvtJ6tSDxF9I2NKPEos4qxnLlvJKSl
 hKK8oEdj/c1kJmS+ONBBwkuBn3TD5Wq87IdshnTa9OjwbwVJI8+reyadfQS0FpVpCx5h
 eje5LGfiAshjJ6etcsLsYZm7wtQ7XQIFe7Quv8d+aQ5HSdTib0N5hSWhJZx/TFFH7k/4
 fyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692716607; x=1693321407;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=21e3RkwAZ6G2atJiptcSykPHGMcVCJLE+pfi1imkcDs=;
 b=OfzbyEsLVGEqtxen1PDEpouT5d/1Azr44jWFLxk7J7i4U8bcYI1pdAuNT+8kQy+J9P
 WpJcotsCXdmH9txZssJ5prtCnA3vRRHxfiXvifc6lvthpqDeB7nl5bHfU4Dn6juu3/tG
 tfnGITkEBkyN4k5gBNKxRw+d5aw2gSmqvOPaVjfpsg6yPFq4MezQufX4etTG267HB2Y8
 eU/nE72KYp0UhTAVkMebsZu0pV22y7hJCcUVF9yFhuB/eONhSxMQunYLsZWngLal0gmD
 AUsaV7znQOYRUcwaSuZHWC9nCjbWl/W6PA441CIhqX0PIqoh1D2WmV8ZWPjsykfo90ut
 Z7hQ==
X-Gm-Message-State: AOJu0YzUTOBfajO7sLkQ/YJ4O0pdSznKqL3BZz54Cp3Z0/3Nb3RD/2JN
 a32d+1YilpsZ3gsemu7IaS+rXg==
X-Google-Smtp-Source: AGHT+IGy3oh1D7Z2xWys1CGQfM8PpvO+MeASrtW8zo3kDkGM3uHL9r5FYXTY1aYgSV/RlbzwZNQbGw==
X-Received: by 2002:a17:902:7890:b0:1bd:d14a:7e14 with SMTP id
 q16-20020a170902789000b001bdd14a7e14mr7069714pll.65.1692716607332; 
 Tue, 22 Aug 2023 08:03:27 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a170902ec8c00b001befe0ac506sm9150089plg.175.2023.08.22.08.03.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 08:03:26 -0700 (PDT)
Message-ID: <38bd0492-f18f-04c4-d202-4fb5376e2aa8@linaro.org>
Date: Tue, 22 Aug 2023 08:03:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] target/sh4: Use hswap_i32() in SWAP.W opcode
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
 <20230822110129.41022-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822110129.41022-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 8/22/23 04:01, Philippe Mathieu-Daudé wrote:
> Commit 46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}")
> introduced the generic hswap_i32(). Use it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/sh4/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

