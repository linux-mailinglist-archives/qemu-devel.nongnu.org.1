Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8638B7E2EE4
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 22:21:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r071A-0001Wr-Oz; Mon, 06 Nov 2023 16:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0710-0001Vj-88
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:20:13 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r070x-0007Bb-JC
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:20:08 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4084095722aso37656505e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 13:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699305605; x=1699910405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CikI/sk0YZ9I6sVzbYm3Ey8sCCyttbhD8h0tQ0QdS2Q=;
 b=PIQ6hCX4g41jglaAgqfrV5aVnL7Gddt9E2ZDaENLMd7PQJBKKCNs1+a9jVcfvJaWCa
 GmS7DDkbMWm7qvqAqqpWFXw3nbx/L7xVCO27DBKWUEIyZ1RxrqDRMlT8HDU237SU2gCZ
 qnwFxdiyROsiTvCSELvIt5NAlV32kmq4tL7cCO+5t4w3v+87EiPgLgnFEAP5CABoN4zZ
 MbNotIp9oydtvleQVknDgZNZn1Ehi7KfaH2FPDipw0UI3xeDBC3L0OSiLvhrWKS87joS
 bvsuGu/SVLkRyLJMBIvf3VbDB0ncLG+DTxf5hL2/cKohiCpOdd0OLky8hZWg5Rmvl/t1
 BSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699305605; x=1699910405;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CikI/sk0YZ9I6sVzbYm3Ey8sCCyttbhD8h0tQ0QdS2Q=;
 b=KcH6xH+fqiBpN4mDOTNH11V82o3hL9HkapQ6mtWvo2bULeUi+bEzuEw9VlhiBzuSvg
 S35n570xTpDLLBBgrjAfeAvawfctOKlsajBZRpqznLKgl4WKM3zZrDzYsodgTtWqaRY2
 X5RzqGz58ZSbxErDYVSiYMgZC1yDyaM4qv5XzpYWz4VEDP+gh6cGn/09ESFoLC8XTgqw
 x8zIFcqNGSLgiBgxX6wJ4W1lwfu1MPZRZyb370NaS69YlVbWijQhXyhTfVBSyDvuboc3
 OmOPorXC0bMFviEAWOzZoSic0rd0kYo3PoVbON7cdUyrpGXgf3rThD+WlffMn68JJFjE
 hxKw==
X-Gm-Message-State: AOJu0Ywze+TbThBgek0azb6SyUdHc3xTF383tno4zRohRo2kXHkJk9gs
 kbPEdjTT9f2YBZVK8GNDk2WWTw==
X-Google-Smtp-Source: AGHT+IE3yeWrE/oG9VzhADA0YX7/2uei2Y9j60MlNg6EKc/djx0k3Aabar2bvi0mj4kzG+oXQv9AXg==
X-Received: by 2002:a5d:584a:0:b0:32f:8a23:fd10 with SMTP id
 i10-20020a5d584a000000b0032f8a23fd10mr18879877wrf.21.1699305605528; 
 Mon, 06 Nov 2023 13:20:05 -0800 (PST)
Received: from [192.168.69.115] ([176.172.125.26])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a5d5503000000b003233b554e6esm556460wrv.85.2023.11.06.13.20.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 13:20:05 -0800 (PST)
Message-ID: <9c9feaf1-fb91-42ae-a0ab-cf6095bae494@linaro.org>
Date: Mon, 6 Nov 2023 22:20:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/35] tcg/optimize: Handle TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 28/10/23 21:44, Richard Henderson wrote:
> Fold constant comparisons.
> Canonicalize "tst x,x" to equality vs zero.
> Canonicalize "tst x,sign" to sign test vs zero.
> Fold double-word comparisons with zero parts.
> Fold setcond of "tst x,pow2" to a bit extract.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 245 ++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 223 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


