Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0827E7E207D
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:54:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzyAc-0000ZZ-K8; Mon, 06 Nov 2023 06:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzyAb-0000Wm-1Z
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:53:29 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzyAZ-0006nX-CJ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:53:28 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so38397405e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271605; x=1699876405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oCYvkfn1ciyM5BknWtAEgXJWGjMAeu4VlK1sBNiXJxg=;
 b=KRp/6/+ya0Ef/bcDaCxcGS19zBk4oaONWNCXWtI9PpR+Nas1hmk37/51R0jiGq2YG9
 lxW/ksPTea3opav7SxXx2RFQIXqU3YZfGm7DXon8L5AdE3Y6/rZS9DY3DmnXvcSjkUYg
 Z3d/T9yoV3G5Cekn6W6SW8ZSLVmdGCgEVxZZYqosITEo9lwapWI63GOc9ovaicCneOKQ
 /gpy2bWhn960xz6aNKCxoo0y1BT3arIqRR5TX36rlJb9hemzpsfq6eifyiswmm8+8CKM
 W1wqCRiGeICnUg1wt4817XKOXYKC7smNYJ6nn1H8cHSrb9ANz6enuEAnXzITCqFElykz
 JScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271605; x=1699876405;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oCYvkfn1ciyM5BknWtAEgXJWGjMAeu4VlK1sBNiXJxg=;
 b=ppJycuamxEJt4bbzO9EkpiPL9bEUQdRSSWP4LDwB+c1zkfyk+yT9vSz3M/rCcBohpc
 Zye7N0Z+1XIhrkvPS0KwlAdRa/6Iu4ScRrP3WcOzY8xaDBkExehumFM6zkyfD7Kp/CBC
 HKc8uyOur5C+rEO2NB9aQJeOV6eHEUGF3WV84UJSoV9PByPFeOiQVMpYPYlZaz+OLWWJ
 ysnCmFK/l0wWMSRPA9Rmx6U0ZuOuacgS7UpsTFe+S9c1PkYR3TM5+sunYi/XTHFJEdDZ
 kB1vgCATXZrLmlGgZ7dKkVKFciBsV334J+oBI2AneXkFhM2eIZad9S1gG6SIfnrVo9bw
 6Zmw==
X-Gm-Message-State: AOJu0Yy7JLNCOPT21dg8UYm6qy7b/E4j7uTE7y493meKwC1zMoyYJx2E
 47w8ZkkcIdw1CCk4RzhWu8YrXoW5q9d2DetsBNQ=
X-Google-Smtp-Source: AGHT+IGCauuVOp+52D3TYcV6kGN6bTmFJ4r+F8SB40vcL3C7N9ZbkJc+FNi10Ptxjr0WuUIWAoqU5g==
X-Received: by 2002:a5d:47a1:0:b0:32f:a48f:3654 with SMTP id
 1-20020a5d47a1000000b0032fa48f3654mr12960328wrb.65.1699271604842; 
 Mon, 06 Nov 2023 03:53:24 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 n7-20020adfe347000000b0032fb17c65desm9230450wrj.19.2023.11.06.03.53.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 03:53:24 -0800 (PST)
Message-ID: <4e08b280-e9b5-1a7d-2872-8a3fac787710@linaro.org>
Date: Mon, 6 Nov 2023 12:53:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 18/71] hw/arm: Constify VMState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-19-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 6/11/23 07:57, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/arm/armsse.c          |  2 +-
>   hw/arm/armv7m.c          |  2 +-
>   hw/arm/highbank.c        |  2 +-
>   hw/arm/integratorcp.c    |  6 +++---
>   hw/arm/musicpal.c        | 14 +++++++-------
>   hw/arm/pxa2xx.c          | 18 +++++++++---------
>   hw/arm/pxa2xx_gpio.c     |  2 +-
>   hw/arm/pxa2xx_pic.c      |  2 +-
>   hw/arm/smmuv3.c          |  8 ++++----
>   hw/arm/spitz.c           |  8 ++++----
>   hw/arm/stellaris.c       |  6 +++---
>   hw/arm/strongarm.c       | 12 ++++++------
>   hw/arm/versatilepb.c     |  2 +-
>   hw/arm/virt-acpi-build.c |  2 +-
>   hw/arm/z2.c              |  4 ++--
>   15 files changed, 45 insertions(+), 45 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


