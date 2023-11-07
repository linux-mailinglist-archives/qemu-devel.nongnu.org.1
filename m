Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1047E3468
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:56:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0DCF-0000pG-Mt; Mon, 06 Nov 2023 22:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0DCD-0000p7-TJ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:56:09 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0DCB-0001iX-Uq
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:56:09 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc4f777ab9so36952285ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699329366; x=1699934166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zwiC6NhaC+jdDpouNjbaoVYZy430o6+gJp/Eh9bF3CY=;
 b=OykW8MaT7W/etCGuh1scjB54V5lM1xjju/s0wojY7M+NbplM6i9N+fs7VVGmShv/8y
 2AA527hP4gNIVXNmAXJtMupkXEuq8fhz82+ziOc9Kae5IqNthF2TgTtF3icuV3L2LgdG
 jujY0OTfLxmw6Q4xT/vmwU/i1ftd3YtqitKFWJijsi+8n9y3qQxLEK0TjUQ2GhfPylgd
 ut/hSAALTVLYr4Nf+NCv89Y8+voMAJF8/d/aCfVbz2CcCV8QTu+FszE5f3OXB1KwTE0O
 NJPT/dAveJ1isTe/K9U/2FG3n941xWqWw/hnKtom+krWhDqZjq+jbWw9DiHvOes/ZV/t
 EmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699329366; x=1699934166;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zwiC6NhaC+jdDpouNjbaoVYZy430o6+gJp/Eh9bF3CY=;
 b=IvqSf5vdu1AoolM4/8mWfso7imrpj/2eQH1NMEuKCbW/oFI4sTcbyFtS/Xh6KTCCC1
 8hHEJR8zhlAduK/6EdV2yn1r5+MYXaQgIFy7OyXRwX338579JERGOa/kxSNLs7qGTB1C
 58tiWirPnNqHt2TrRtCfSt2i10pKV17L/N8AIhTQ/Y+t7tKzOAsyciaJIN9itB2lxQ8l
 tNqZFS+kHvlsYyEeUU1434OuM+0QCjFNXiehFuSyvYFwHMLLddmwM5/eD6H9uoHejMAC
 a91VOBoNeZOIhg/d0pW+p7aeAaiV9fEw6rm1WI7SZZFBnZ+abnGFcd2Ig8JVf7TUWkbL
 Y0og==
X-Gm-Message-State: AOJu0YxYFSlHgSlD9U1w//BpB0k3RaNeeCLewKJ84G4nWbMnxtscjE27
 fe3y5cOnudBqOLm75mNa3WVmqFM3Gbma3/mjmJU=
X-Google-Smtp-Source: AGHT+IH/nKRLEHWL/iGNKxj+lceEqKi0jbcEF3/kNg0sVL3dWRhtQxFrTbeTh41lncQhSIrglrpICw==
X-Received: by 2002:a17:902:e745:b0:1cc:45db:e21e with SMTP id
 p5-20020a170902e74500b001cc45dbe21emr24253153plf.37.1699329366171; 
 Mon, 06 Nov 2023 19:56:06 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a170902c3d100b001cca8a01e68sm6152313plj.278.2023.11.06.19.56.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 19:56:05 -0800 (PST)
Message-ID: <4d27f293-529c-405f-bfe5-7435b6874d0d@linaro.org>
Date: Mon, 6 Nov 2023 19:56:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/22] tests/avocado: update the tcg_plugins test
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
 <20231106185112.2755262-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231106185112.2755262-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 11/6/23 10:50, Alex Bennée wrote:
> There are a number of things that are broken on the test currently so
> lets fix that up:
> 
>    - replace retired Debian kernel for tuxrun_baseline one
>    - remove "detected repeat instructions test" since ea185a55
>    - log total counted instructions/memory accesses
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231103195956.1998255-8-alex.bennee@linaro.org>
> ---
>   tests/avocado/tcg_plugins.py | 28 ++++++++++++++++++----------
>   1 file changed, 18 insertions(+), 10 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

