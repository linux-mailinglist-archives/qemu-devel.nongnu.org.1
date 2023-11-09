Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2092C7E74F1
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 00:09:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1E7q-0000gV-Ch; Thu, 09 Nov 2023 18:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1E7o-0000fm-6P
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 18:07:48 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1E7Y-0004am-TA
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 18:07:47 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc37fb1310so12324845ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 15:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699571249; x=1700176049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rEqoaBAI4OAYO1WRKf/xzDbGXzq3kD5M0df0KJ2oYso=;
 b=vczedZQhfVkqowBIZQ1Br80lYyLNClOCwS8DtrcS7gbLYgscKBmODRiR+OJppZzZVd
 RGePF1mgiheKQfWPgiTail5AeOK50aNfiU0KxzJoIKrPkhmhYVeTql2EFofP4MrwKOIc
 ywcHJ2tOgBEgbGZBUn3gSnbynY35BGwhg7xho2AdfS+x4G1cr8cb7yHRcHeL6QQ/prmI
 v7LHfWOYwSDmTdU3U/rlRhgLqAerVpI17U+fziLbyCKBKMsJDAiCU682+Ame8l+zC/+I
 Aoq5smFTWIT5Uw/mhagG+d9DHXBKCCb7VIZe5DKvo94TWAdhidoEQUbQ7AMRqYjBsfq8
 ZJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699571249; x=1700176049;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rEqoaBAI4OAYO1WRKf/xzDbGXzq3kD5M0df0KJ2oYso=;
 b=XSeHfjsWaldurwncRLzvPtr6oO0yd61A+qFJ1xCmXHQl3nxWDnTl9OC1NuCIqBAHG1
 iQ7jCL6zA3FguTHNXcNd4fbfZvkhIYm617O4hVL2NJq/hwgwVX6ApZdjzftLmK3v79mL
 Be5MuGas5yD0WXx9FGXbwX2HsjMRLGIEuF0hUG/mQRiNdyQox8Yf4he3YgTU9LVoB3HP
 RuKlPbDIwIdHAgjcgLzcMw9cI7AmZ1vBi5GceU/wPpYKZJDI9QuBTUcBvn1+UYmK+RCn
 BT0GNuYaFawaVSN3Drpt21lqLZe5Uct1wMjSgg/hZtd7i3EkINDnj9e4ha7Qeghpba7h
 fpCA==
X-Gm-Message-State: AOJu0YyhMIsXTgvNm9qWliswhs3RWWQdmrylfgp+vv36cQUxmu08znk7
 t+BnTfRd/mv12hdUN2A0GnCE5A==
X-Google-Smtp-Source: AGHT+IEg8k3jxk+WY2mWSRoY/WzSFyCnvAuUy8INftL84pgJiaC7Zvo9gg9fO4/zLGL/c3p6tjxGrw==
X-Received: by 2002:a17:903:338e:b0:1cc:7af4:d136 with SMTP id
 kb14-20020a170903338e00b001cc7af4d136mr5149683plb.28.1699571249612; 
 Thu, 09 Nov 2023 15:07:29 -0800 (PST)
Received: from [192.168.101.169] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a1709026b0700b001c5f77e23a8sm4025073plk.73.2023.11.09.15.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 15:07:29 -0800 (PST)
Message-ID: <936f6ab2-5e51-4162-a71d-79dde0833b42@linaro.org>
Date: Thu, 9 Nov 2023 15:07:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: HVC at EL3 should go to EL3, not EL2
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20231109151917.1925107-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231109151917.1925107-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 11/9/23 07:19, Peter Maydell wrote:
> AArch64 permits code at EL3 to use the HVC instruction; however the
> exception we take should go to EL3, not down to EL2 (see the pseudocode
> AArch64.CallHypervisor()). Fix the target EL.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

r~

