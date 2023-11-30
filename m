Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4E37FF391
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 16:27:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8iv7-00039t-LX; Thu, 30 Nov 2023 10:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8iuu-00036C-Df
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 10:25:29 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8iur-0003JJ-R4
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 10:25:27 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b8412723c4so615870b6e.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 07:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701357924; x=1701962724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q1sYlCR+h46u7F8BXbMBUaK/bgTyBE5IwIsbR3noZPA=;
 b=Jyifrbv96izDrD/PDQxDMoVBX97eLQBETycHz8DJVw1QZngaPzAXjoAEK089VVkl5k
 zwG8QoZvFwDpb8GrYEjf6VIpeTsFwNRP8fyHHrWBNfidvvJfjEcazm6MNkyJsDECUMv6
 a2DGZi8WpcHPzkI7+kROVnL2PFOej651l9XPU1Y/ioEIOD5fWylKRIKlYwradIGbiKKh
 yZQaigxR/gqrcniWwggAXhHVxfSZrG5Ijh4ybEwdbDYxKT2QxX/qgQbh8V04zBYvvsVg
 POgWW+TQ1ifkMZZ3T6P+JRN8SnLHSQhS01KkRzXo9jed0LwEHuWpu7isdMAUWNgbGlk+
 wGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701357924; x=1701962724;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q1sYlCR+h46u7F8BXbMBUaK/bgTyBE5IwIsbR3noZPA=;
 b=o0Dn/muwprfppzdZnGnjYZ//A6qwyy5JveqNPZf+Via0g2i5pwemJPvZWEhlAl2xGo
 dweIH/ocqlDwrvXXH5pK+SYP7fPU8fXWrmaL+LVPq5opZt90BCPh97QAywPdMdFqWbCk
 fmwURH4jtToC9PcBQPERp8FNs4RKr78n+QPMACET+vAwKWmx/zo0kokCz04X8VW74Mmj
 l5BI67ed5ndRbIRfNhuZn4FFNeaYg5nv3F9gZVg0eGLdPdXzyK61VSRkqCpPyBP9WTrw
 Wq56/MUNrwOS6bTBKNDbnTXkFg6BKzBWbeNAHNWVhujQE4RwogEsCVXZ3s3cURHUklmp
 FDJg==
X-Gm-Message-State: AOJu0YzlRNdpQDUxwDzYzUVHoU+/2Xq8euemEv6Qg13XnbqqHQc2ujN1
 Ub3eZcpPcceZcaHcO44Lg4Ygpw==
X-Google-Smtp-Source: AGHT+IHMJ4ZQ0aPM16L53lE59DQ9OpcIDS87Mar2sBFZOwqxDeKTHNqmedH8YRDG91gV3q72UCOE8g==
X-Received: by 2002:a05:6808:1211:b0:3b8:43fe:96d9 with SMTP id
 a17-20020a056808121100b003b843fe96d9mr31743671oil.35.1701357921497; 
 Thu, 30 Nov 2023 07:25:21 -0800 (PST)
Received: from ?IPV6:2607:fb90:f2e0:8450:be70:af46:b71a:41bf?
 ([2607:fb90:f2e0:8450:be70:af46:b71a:41bf])
 by smtp.gmail.com with ESMTPSA id
 bf6-20020a056808190600b003a43759b9cdsm207572oib.29.2023.11.30.07.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 07:25:21 -0800 (PST)
Message-ID: <6db88fca-9ca7-4aa7-90ae-0dba182dda0e@linaro.org>
Date: Thu, 30 Nov 2023 09:25:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 0/3] target/arm/tcg: Few non-TCG cleanups
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20231130142519.28417-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231130142519.28417-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 11/30/23 08:25, Philippe Mathieu-Daudé wrote:
> Few non-TCG cleanups extracted from a bigger rework.
> 
> Philippe Mathieu-Daudé (3):
>    target/arm: Restrict TCG specific helpers
>    target/arm: Restrict DC CVAP & DC CVADP instructions to TCG accel
>    target/arm/tcg: Including missing 'exec/exec-all.h' header
> 
>   target/arm/helper.c            | 60 +++-------------------------------
>   target/arm/tcg/op_helper.c     | 55 +++++++++++++++++++++++++++++++
>   target/arm/tcg/translate-a64.c |  1 +
>   3 files changed, 61 insertions(+), 55 deletions(-)
> 

Series:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

