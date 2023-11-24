Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4637F72E0
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:38:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6UUi-0008RB-CW; Fri, 24 Nov 2023 06:37:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6UUf-0008HX-PV
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:37:10 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6UUd-000828-3B
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:37:09 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso14078375e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 03:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700825825; x=1701430625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5sC1btWtsw+91xFP0BzSofhkxnN3GjDSpQs6fWt0Kp0=;
 b=lBgrbvgLqH4A7Hyoo5OOnejdqG9vmCVOoxCHIeQ/AuAaOwgKZp3XkR4RQ/BDdOX45k
 XPOn3ajxT1n4DcR2PztZCPCrivS+ZCgAU/d8gIE4QJrXhOThIC0S5nlbqcpEKlmj2sfA
 IP0X31FUqIhtvdZQfjJQx1EABJuA0hrLdKEAMotQL/8uO3SOrSKdR7SmwuXjx3x4Zuj0
 lqMsomM/g4nqydxeTVYs88pRvH8ZZyCfDCEoneWgcZ5WZZLm863FthddT14LJYpT0iLC
 y8nI98h56m1XsokAHTZj2TiPNNPXXFrYF9se2oWQE4mz96Tu1ro92ACPfsdbKNTVRs6Y
 5lxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700825825; x=1701430625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5sC1btWtsw+91xFP0BzSofhkxnN3GjDSpQs6fWt0Kp0=;
 b=hEQ5rgG4WgKP5eeY2ciqlV14ibJTO0gInSciw94sPubJ5P2i2KIriYVXk6qH9/FGeY
 YBZJFm6mlnsgXLOtnpvyIpljx6+u0eATk3/UOL06MIgNfYIVfDBj6BtJaYo9m4HZzkEA
 vTMPrAYpjIiDo3RezmW5IrgkrsfNXWftng5afsD2FnWzESqHhyCgGem19avoEl5UPVoW
 Hoq9rfBN/jiztIayrmxq/qK+K3vGb04paga+e1dPU0FwqK2I/usHsiHWTk+vwVqgs+yn
 YXFKlesY4NHZZvhpZwCumfQQylcST5cFnQxcDiTy4QD3jGBrUkAsNxQbBMjLXD+vh0px
 pIiQ==
X-Gm-Message-State: AOJu0YyCx+C5SdxYC9EjwzwyllsAa5r2LFmen6f3BW47HPRrApE9QYSX
 aMYuqk36rjb7ct5cHPab+4yFaA==
X-Google-Smtp-Source: AGHT+IEtq4GfuUHW5MKpFrw3i7oMuMgXR2+wQH+W4uYOJJswJU0ut6jrpoZyNsvGPe2r3Xjtbi8fog==
X-Received: by 2002:a05:600c:314f:b0:40b:2a18:f1be with SMTP id
 h15-20020a05600c314f00b0040b2a18f1bemr2118372wmo.1.1700825825295; 
 Fri, 24 Nov 2023 03:37:05 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a05600c350400b0040b34720206sm4835060wmq.12.2023.11.24.03.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 03:37:04 -0800 (PST)
Message-ID: <bafb1ae9-6cf6-4764-8ac9-9b750b48cb89@linaro.org>
Date: Fri, 24 Nov 2023 12:37:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] target/arm/kvm: Move kvm_arm_get_host_cpu_features
 and unexport
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 23/11/23 05:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h |  22 ----
>   target/arm/kvm.c     | 265 +++++++++++++++++++++++++++++++++++++++++++
>   target/arm/kvm64.c   | 254 -----------------------------------------
>   3 files changed, 265 insertions(+), 276 deletions(-)

Reviewed using 'git-diff --color-moved=dimmed-zebra',

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


