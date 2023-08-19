Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8B5781A2E
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 16:39:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXN50-000660-AA; Sat, 19 Aug 2023 10:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXN4x-00065n-H3
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 10:37:27 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXN4v-000469-Ai
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 10:37:27 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a44cccbd96so1361825b6e.3
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692455843; x=1693060643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lj4X5Pu9M2JD+z07RyYTZIXVL/NmSCG3CMpfxjAuBHA=;
 b=icPjZelVWVaxt8/CyTl67A7INpcG80cBM75GmsB5a4T5AwZP96i5qQbOuY28kXYL1o
 aw3A18dn8J5Opr5mYkS3YHIpzVoGjxEZKNvpklk9stpWFZPxNKZCxnUwmq3CIZj8lERU
 8/quO8pCh2X7f5Gx6hd/4hUloL4+AGwLKGjr0k61oBK/RV4rWMgJaA/8caE74gU/Jefu
 GnxaGBBDh+p7ZagTT4Z8e+ljKx4O4lu66nVrO6/uNQInUhmtY38VNU9Yri2DoPPkwq7e
 bGPPwFwOKsT+R86yPQOe6zHHfxIoT9e/P/aiitCNxj8vfElcovtIFKy+tS7l08ROgwoN
 5LWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692455843; x=1693060643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lj4X5Pu9M2JD+z07RyYTZIXVL/NmSCG3CMpfxjAuBHA=;
 b=JwEzO43A/XPeru0ZLX0ziSPH4dGgD42gywMdTjUH8aaP5aOoOy8hm6FOWtpzF0a/sZ
 ZZaucSqs28DFRJao180HICnodip262CB68TYQGFl1fIqGOuciblYAg/3syC3IQ7KL4fI
 50XSEidZztL0hWP0xbFE7eciqNY2GdHiT7vr3k/QizYvV05EK3CC9ijvfiWXXeSfX5Yg
 WsWIO0sPbdhxWIRpWKMFm2BbiR9EKwplbcVRpjv/Ki7EDOLsisyOufaHj+iThKWR0H4c
 zxEdfgxuKKdZ/RlyvyImCWX/O//6UcsECYP2RGVPZ13eIyGSQCDQ68u4Ka0zRoxGZQ3W
 aBBg==
X-Gm-Message-State: AOJu0YyK5kwOvWx/rsGJiocmYCGxXZZ7HN3eL7skOb2PSI32OWyzxKz+
 9INRxcOBQYGzP6bA7PN0znVyIw==
X-Google-Smtp-Source: AGHT+IGgtTRk5P27yZcLWB8PTx1cl1R2CGfsG1dW/6W9zzihaCj4OXG2QBaa+SiiOB3CBf8ISQ6mBg==
X-Received: by 2002:aca:f045:0:b0:3a7:56a1:9bbe with SMTP id
 o66-20020acaf045000000b003a756a19bbemr2952382oih.45.1692455843403; 
 Sat, 19 Aug 2023 07:37:23 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:d058:ace4:c86a:5384?
 ([2602:47:d483:7301:d058:ace4:c86a:5384])
 by smtp.gmail.com with ESMTPSA id
 t26-20020aa7939a000000b0067b643b814csm3262858pfe.6.2023.08.19.07.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Aug 2023 07:37:22 -0700 (PDT)
Message-ID: <3877349d-d6cb-6c6e-77e7-b379067103b5@linaro.org>
Date: Sat, 19 Aug 2023 07:37:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/22] Implement struct target_ipc_perm
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-2-kariem.taha2.7@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-2-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.862,
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

On 8/19/23 02:47, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/syscall_defs.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

