Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB20A7EA2B9
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:20:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bXf-0003cT-IT; Mon, 13 Nov 2023 13:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2bWs-00030R-HM
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:19:26 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2bWe-0000eM-IY
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:19:21 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc68c1fac2so42042245ad.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699899547; x=1700504347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=umxmIrkbAOLmL1DmXXbJI6TnuJLS61wFseCU5AQMMlE=;
 b=p4G7ZJHLpWPGnuglprgf8WPQv2cvc8WWtR6wDaFaGMvGS+H6i1w6I3bmzBel01FHLu
 hBSFXUpPysXnfoiaqY+sJwc43CXOjBlS2zD7d2i1MFlLAuAo5w122Akm0QPL7NOUBTRP
 x3h2l1NlfERM+utJ2r91Z5jT1H8SK7p/uMYEX4et0Tz+ynQU6MQLviHtGZzzjiExhrZk
 5PPsdfvPGvm3Ji0g/QhBYoZJoSgxFqeRByf0PX+q0z5E3dUyZd99UmMS02oQ6f5otvpF
 V1eI1U78dsfR/E+jDcOzfDtiMcaO308LNjfuiGtp/ASTtUj2XrvK481bbWJFPgXKzQrQ
 XR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699899547; x=1700504347;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=umxmIrkbAOLmL1DmXXbJI6TnuJLS61wFseCU5AQMMlE=;
 b=evNb2MdePf9wBya/WhkCM/SdnuXGxIaAcjfgtnTgpHh7rSfjgQBSyY/pgPdOA37bBA
 kY+iaw6pf1AuXDzySz+q70Tb5i9VTWKwCyb7DzYP9gYUQzvBRf0Q4xe8JmqQ8HdvjPF0
 1t0YxIvlsmC+1ExzAOzoaJlwfQIfGPGjI9ES/rm+dOZ5M59gUkGEl+XvgXVxzVdlM4T0
 KVX8fqhDs6jdhKOJ1U0adZ2j79un82udrtd1xwhBTMqql3uucwunJMAb/P7vDWiHqsjb
 BrCw4si29q+EXLSEH2tnZOLNbyLlZbBkntS/+ZcPeyxDcUGAXXxnB5EvTgae2in4F31a
 Y4Xw==
X-Gm-Message-State: AOJu0YwjeqQBKbcWWWHvaIysXVrpkuHJeIv10RN121scQr6PXzGPpc+7
 QU70mQVXmanKSExCIlUx1DWvUMYeca7bQBSZmgk=
X-Google-Smtp-Source: AGHT+IGg248TCR5/kb/i5Pi6wxhtajoY/akEWVclfGdoBcuPjMW4q7qpmailfQkpV0PQqKGOfBIpTg==
X-Received: by 2002:a17:902:e88e:b0:1c2:1068:1f4f with SMTP id
 w14-20020a170902e88e00b001c210681f4fmr423529plg.17.1699899546984; 
 Mon, 13 Nov 2023 10:19:06 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ju10-20020a170903428a00b001c59f23a3fesm4142792plb.251.2023.11.13.10.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 10:19:06 -0800 (PST)
Message-ID: <a6333482-93f5-4ff6-826a-c1564e89c796@linaro.org>
Date: Mon, 13 Nov 2023 10:19:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 06/10] hw/xen: Reduce inclusion of 'cpu.h' to
 target-specific sources
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20231113152114.47916-1-philmd@linaro.org>
 <20231113152114.47916-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231113152114.47916-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On 11/13/23 07:21, Philippe Mathieu-Daudé wrote:
> We rarely need to include "cpu.h" in headers. Including it
> 'taint' headers to be target-specific. Here only the i386/arm
> implementations requires "cpu.h", so include it there and
> remove from the "hw/xen/xen-hvm-common.h" *common* header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/xen/xen-hvm-common.h | 1 -
>   hw/arm/xen_arm.c                | 1 +
>   hw/i386/xen/xen-hvm.c           | 1 +
>   3 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

