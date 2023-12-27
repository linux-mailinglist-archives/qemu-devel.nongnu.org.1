Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4514181F29E
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 23:59:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIcry-0004Yz-Pg; Wed, 27 Dec 2023 17:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcrw-0004YT-NE
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:59:20 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcrj-0003o3-6z
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:59:20 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d3ec3db764so14956005ad.2
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 14:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703717946; x=1704322746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WtfvLzPdSxebpaFJhGM4BSGPry9jCoomPU6OoNI/jIw=;
 b=CDZcd1OfSmLGF5nVUwl3TFfpqV4ZbngqvD+bNUMI5AnktvBoQ5ah/cW+Et7DfkEG+z
 6LdHl1ghmHBrMcbqZcW/xkRGr4cBmMduoLEEO5xDuNyj5gqVC+iPz6g10PKKVTWJTtf3
 Knzv6jIEfcJ9F4886kRhOYpkGahrFZ19vRxlip/6m1QSoZCQdCoB0+uNu451a1BB19DS
 7hxZYVpPQQpL7AyLzg0hHpnnSXlkwpw6pGvXAu0JCi2ofAPXq3rDbyYJBPR4cG2rK1kL
 lIbI2JpUvE/qcwqk+GWdASiRXpm/8zW2o8An2JxQ0/gK8ok9mIQFski4lL6zWUlodKag
 PbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703717946; x=1704322746;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WtfvLzPdSxebpaFJhGM4BSGPry9jCoomPU6OoNI/jIw=;
 b=Sy3J4fFWvLHIp8JfixjOF6SeH5wU3fUetCLuRsOzE4BOVMsNWoUe4NGBAhWpClk2RR
 /rwBszcDX5vL/i41UzOdPuXk+aKYJyxIfvMtN6um29Q4eaXtMNrZVHsc3n9LJwpWgw6W
 xjQdHoYE2V1Ja1nnPKR0xDxN6Fl9d0ciodCf8lslI242MRtkAJBRzR67Y5Po2QrcylmK
 kNWFVqHnF+y7yuSmJyLUOfzGUS5z6HML84MiPIbcor81BXhAjGFZxMcuMrvfXwWxpa7d
 MAh7RmX2a8s9hdSo/dmsVSTGjzsr9rC8HqpyA1bs1IZ123Uuc7HtlEaQVIW41HCwjdvq
 86sw==
X-Gm-Message-State: AOJu0YwHKo7bw3R5yEBfUdwX2SBV874J0YUvZP6q9uTRMi5Sz90pYid9
 buNKftRjCI+yVW/sPRtYBoXaREfUFgjWnw==
X-Google-Smtp-Source: AGHT+IF610/SN7l8FggzfYOXFyToXWqqT2cGNHdkKKNoo4HiCpmyfmxjeIvbgkKZInl7tHu04ouSXA==
X-Received: by 2002:a17:903:2983:b0:1d4:5282:f26a with SMTP id
 lm3-20020a170903298300b001d45282f26amr3096636plb.118.1703717945893; 
 Wed, 27 Dec 2023 14:59:05 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a170902e88c00b001d06df5c1absm12529753plg.86.2023.12.27.14.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 14:59:05 -0800 (PST)
Message-ID: <937f38a2-440f-483a-8b4c-7346838aa618@linaro.org>
Date: Thu, 28 Dec 2023 09:59:02 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/35] target/arm: Add FEAT_NV to max, neoverse-n2,
 neoverse-v1 CPUs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-22-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-22-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 12/18/23 22:32, Peter Maydell wrote:
> Enable FEAT_NV on the 'max' CPU, and stop filtering it out for the
> Neoverse N2 and Neoverse V1 CPUs.  We continue to downgrade FEAT_NV2
> support to FEAT_NV for the latter two CPU types.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   target/arm/cpu.c              | 8 +++++---
>   target/arm/tcg/cpu64.c        | 1 +
>   3 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

