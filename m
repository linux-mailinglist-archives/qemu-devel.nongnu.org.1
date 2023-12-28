Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B0281F37D
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 01:53:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIedw-00004v-CX; Wed, 27 Dec 2023 19:53:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIedv-0008WL-6d
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:52:59 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIedt-0000qh-Qw
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:52:58 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5cdc159034eso1955018a12.0
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 16:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703724776; x=1704329576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Xwn5APP1bY7qzdrOsqpFEdCkuVZgD8lJBuyKFLdWtw=;
 b=lsaIhv/YW5DB4nwSsSrlm0KFWL5Pha0CqN67IWg4U6BK5bqRZcQaImPCG/zEywrHEq
 OEs39t4+WiXB1mmpZa4eQjsBHCWwLMrnsUwgrmVsZEDj3CFKnXHuix7ArzgUqavvTAQu
 k+vHVwJg4vpE2XGTYo/vqYp+jI1+yE5f12fXUugLRPfAyzNCVbIxi6K2Ele4Olynfg2S
 0kCNek0vTe6OpMrBYBI29udTe1cbYQrmsfcGSjBo7eqpSVun7xi2D1d1K7ufk2JNOAka
 a56xwfyRAiXUIexD22unLK0hy1JtPCTAAk8rSriUyrcaC/Rv5SClVEz6J9dCnFTXkVqo
 ZLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703724776; x=1704329576;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Xwn5APP1bY7qzdrOsqpFEdCkuVZgD8lJBuyKFLdWtw=;
 b=ZnKwTfmmWy9kdziECCMQ9It27sPYArWkzxImxB9vweJYm3XK4WA7W0+2WMN6AL3w9y
 CieAZq8LThVaUuT0kGHiN/ErpU7nOyXh7zwjO/AgjORkCdV6kZPv/Foy36rG1Wi/OOE0
 TplGaMIvvtcHYWMskmGhACCUp59OWG25OKkeLylmUm6MJQpxDEWJ02qy/7XE4nmTMA97
 h8SM4vEJ+44FuhMKY/k2Y6pEmUkSM0Oj1T5jWRo8kJstNZyo3G5xx0X1Ix5XF/A0jAZx
 CNQoRBOG6UD0mKEclMy0fFzAZtT+ovJBypHOuk/Hcn7uR1CPzzyr4zWAWfgfx8+okg+6
 E49A==
X-Gm-Message-State: AOJu0YxT6zrP8s3m0Pji11RjXMMPniI0a9onkDUlHnyY11fxDssMOMco
 dsMFg1sb7FYfrtpfBVt3y8DINUzwYvhPG8l9qFVKJwRe0ZX6Kg==
X-Google-Smtp-Source: AGHT+IEElF+VqP6u4tq7JEWmU3JekPqHq2ieck93zpPuXiGNrs8Z1ToqRAkXzxHh7W/24p0ANXLEnQ==
X-Received: by 2002:a05:6a20:1594:b0:196:4775:b5b with SMTP id
 h20-20020a056a20159400b0019647750b5bmr254690pzj.49.1703724776519; 
 Wed, 27 Dec 2023 16:52:56 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a170902969200b001d4872d9429sm1145847plp.156.2023.12.27.16.52.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 16:52:56 -0800 (PST)
Message-ID: <8cb62137-ebb3-48b6-bcd0-feab8b086bd7@linaro.org>
Date: Thu, 28 Dec 2023 11:52:50 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/35] hw/intc/arm_gicv3_cpuif: Mark up VNCR offsets for
 GIC CPU registers
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-33-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-33-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 12/18/23 22:33, Peter Maydell wrote:
> Mark up the cpreginfo structs for the GIC CPU registers to indicate
> the offsets from VNCR_EL2, as defined in table D8-66 in rule R_CSRPQ
> in the Arm ARM.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv3_cpuif.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

