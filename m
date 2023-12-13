Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FDF8115C4
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:06:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDQoM-0001Tg-Cx; Wed, 13 Dec 2023 10:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDQoK-0001Sp-5x
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:06:08 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDQoF-0002mC-8W
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:06:07 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40c3984f0cdso56019125e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 07:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702479961; x=1703084761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GTHWE9XnhElxfmz089QjcAg9MpY0yRNOB5OH8WY0f0A=;
 b=SAul5tYp6O8kgop8WpzJq20c2BjI+5pG1Vjfnfvw6CvXXbQUalNf+Z1qx4PoknNbvb
 cs3H/P9cHv0y5HqUIgUXihaK08jKeKlpLHWVz5Bt1mJ6sdeqZDrJKi1FwGUAXweljcg/
 AxXm9rRMVLoEL/6zYDhcBCFARxi/oCDRCtng7tM5wBhHfXivZTtdPAm1bUOb9ofyi/pE
 fUkrXKCylCFJ7nlWDUpwENbQG4+6Rqen7ozL+Q5uSfFcesa+yEhwx04lgiiLFX1cKNTw
 kgz8VFlttBMpJFcK15aOIzZgZJvkkbsF6+Io44APvKD+orlfiq3NDfneejY0+uzUsmQk
 cqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702479961; x=1703084761;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GTHWE9XnhElxfmz089QjcAg9MpY0yRNOB5OH8WY0f0A=;
 b=EA+1RALKXNWyINeyaEAWdzN1gS4QXZKvc87aANfF0/K/szFACuKkEmD0wqGaVaGPu4
 jPWRJlnONE4vDlACIhtC7rBwbUIDjY7x/Zwdy18Qvu9/aVoY69cW4bR/Dnps+XgfXyzV
 jSn2jB7nWit6TsCtITmzdNfpprK9+MrCJZ1SmS6CbIFaDofOVeqgzwBOBUBYkpefq2GT
 xtGnD/Gei1IFz/2AqPIJJ6OD2jJtUg83c+kb7dalKwiPV1bVISpGH1H1s5HxZSejyEgH
 ydhOb5EkAaazYmVKjifDKMK+9AKLYzzeVHSrOboCM+ecI4KIqAilL1HNF74qyZQmOEVd
 f6Qg==
X-Gm-Message-State: AOJu0YzZ05wKWZwhVyXhitGPsxsfT56NQbemInVQ4u1pE3GG1F9KjfU8
 AxpFuJ/tkCuuN5CvN4/x45fZRg==
X-Google-Smtp-Source: AGHT+IF61mp7WBhRWzDTlcQ+Tq7JhWfO8RcJXABrEq8bIOWegZLAAcegZwrpmVU+ZRzToCJi5oaqPg==
X-Received: by 2002:a7b:c3d3:0:b0:40b:4520:45c9 with SMTP id
 t19-20020a7bc3d3000000b0040b452045c9mr4871304wmj.36.1702479960850; 
 Wed, 13 Dec 2023 07:06:00 -0800 (PST)
Received: from [192.168.71.175] (76.red-88-28-19.dynamicip.rima-tde.net.
 [88.28.19.76]) by smtp.gmail.com with ESMTPSA id
 e17-20020a05600c4e5100b0040c34cb896asm19587207wmq.41.2023.12.13.07.06.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 07:06:00 -0800 (PST)
Message-ID: <60d14440-27b6-4b05-926b-74c509a9604c@linaro.org>
Date: Wed, 13 Dec 2023 15:21:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] tcg: Move generic expanders out of line
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231029210848.78234-1-richard.henderson@linaro.org>
 <20231029210848.78234-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231029210848.78234-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 29/10/23 22:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h | 19 +++----------------
>   tcg/tcg-op.c                | 16 ++++++++++++++++
>   2 files changed, 19 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


