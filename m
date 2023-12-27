Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E25281F22C
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 22:09:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIb9A-0000XP-AF; Wed, 27 Dec 2023 16:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIb8z-0000TA-5e
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 16:08:49 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIb8x-00074U-0q
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 16:08:48 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d430bac207so20794765ad.0
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 13:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703711325; x=1704316125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zHKq0bqP7Qzj+Vaa7zm/ioZ4qsgAU2Yx5PlrwIWiekI=;
 b=pIyEJJiTkn+ccKWFuD6RStriRc7S1uqvYrOFVZ1qk95jLcUnhQPRuxShN9xQ6amESE
 pBD1/0xSe2gLqVRQTL4oB1ArrWwTme61coC5ucSLh+d3wDxTalHRnWlzYEPjC3pLelJP
 3lTWIhvJGM5WoY1rLNtW/BApXe462j2GQcWE0gVdKTVSHQP364f5hjcb3fxR/QXhHVFO
 iR2vyZDI2Vpzh6eq3jv3XvnuXOIsKkzNMXZglZr80Y7RFyn8aUCF5EWmiTLKZd+dGkG+
 Yx00GgaPOWBHG354YtJa9/tpVNTmDmbannheWFvlUHAEFQFTmve17zo7JucjhcllB/6w
 OFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703711325; x=1704316125;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zHKq0bqP7Qzj+Vaa7zm/ioZ4qsgAU2Yx5PlrwIWiekI=;
 b=wL91nHEnrPFIaQinNqIGlyWy2xXdrro++gE/5YsZYvfFZ8odBJvQ2MkcPbDJ1A/ObY
 JHJ6iCb47+fl0cqUH6cx8wEE/B1oMDDBJoMIxdV1yKq81ChxW4c9YUHM9fdhfft1VH1Y
 ehTqSJ1FfN9FPm9HyI6HZS6MhszPsPHB8aNcuH4ciXOUAqr3oYITWA+v0e38lL9OnOU1
 9rmcpwYv/3D9j2hLgUVoSGR3rCEQbH6iTE36JpLRJYOwvOQM2fSERSAPKYzgSkeCdmpd
 Wt+QlUmtQznyRoVpNspfGBdy1DJ6w/L+Cts6aj6dzi9MeyoiZyyc+D1fLshVnoeW0Y7y
 Rhhg==
X-Gm-Message-State: AOJu0YyInd0Bd74ir39OngmKLmb0N3M/pTm6zQzwuf+6uwY9FIuOoBfn
 G5krW2RXNzkTeR1Cm0Bz854rp+7zg3z3dWfTUX1tO4Fnn90GIQ==
X-Google-Smtp-Source: AGHT+IFNFBP3GFsCK1ylS12P7sRtgf1vylJQin9MiEGfd2e+Zv+IC5P6Ob3XkASVdkrFXakhD4T8dA==
X-Received: by 2002:a17:902:6846:b0:1d4:81bc:a2c2 with SMTP id
 f6-20020a170902684600b001d481bca2c2mr1682881pln.2.1703711325385; 
 Wed, 27 Dec 2023 13:08:45 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a170902db0a00b001d0b4693539sm12436231plx.189.2023.12.27.13.08.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 13:08:44 -0800 (PST)
Message-ID: <3de06a76-a409-4810-8113-715bfa1a645e@linaro.org>
Date: Thu, 28 Dec 2023 08:08:42 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/35] target/arm: Set CTR_EL0.{IDC, DIC} for the 'max' CPU
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/18/23 22:32, Peter Maydell wrote:
> The CTR_EL0 register has some bits which allow the implementation to
> tell the guest that it does not need to do cache maintenance for
> data-to-instruction coherence and instruction-to-data coherence.
> QEMU doesn't emulate caches and so our cache maintenance insns are
> all NOPs.
> 
> We already have some models of specific CPUs where we set these bits
> (e.g.  the Neoverse V1), but the 'max' CPU still uses the settings it
> inherits from Cortex-A57.  Set the bits for 'max' as well, so the
> guest doesn't need to do unnecessary work.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

