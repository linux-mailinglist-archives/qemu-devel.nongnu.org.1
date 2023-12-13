Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D28F38115CD
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:08:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDQqb-0004uI-6W; Wed, 13 Dec 2023 10:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDQqY-0004tt-UM
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:08:26 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDQqX-0002zW-BB
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:08:26 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40c3f68b79aso50244805e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 07:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702480103; x=1703084903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dpqSMYXb7mMaqnzjky1y1YuwKxBRaqjRVCFB7eRrPlg=;
 b=NsnF81sX7lZILmlzqVbloOiv8xNoWSZU7fsMvCNOLbYYiIzKfIn5ZhTjvUwIatU8dQ
 nfcaYo5GhqTA3HziZog+GFClSCXKDQ8l+KZNEmTF390exDNZNTFILWvXKdiBly3V2v6z
 ct3ZPd0H5RUvQ6Pqhdb1CN8wEf/UV6qnU2mbp7HC7KfGb6o2wONEsk0CYMAWbiLkgqw1
 1BGeDrfDuvzHrBsWvCP66GnsfX4mzl3HALFsJZgko3L8ZsptR7BPmF2tDw8od3FD6T8D
 8vVIg7A26XG30YoT01H0z5zUaqb0Ru75nuGDfn4ehHamjppVpcZ1hsCW+NZ82K9kUk5y
 NFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702480103; x=1703084903;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dpqSMYXb7mMaqnzjky1y1YuwKxBRaqjRVCFB7eRrPlg=;
 b=qK6+B/75a3CUjJn/b1j60a0/TsJFTSKlaUcNfdfJ20vpOOQVRKBKWg+7Xtv9V8M7t0
 JZHsBvz1/wf5QfBCvd/vfFnQvL0TPMEqgrI5aG6ccI5Dnl+5D1FgbRSA9SziCSgssqnb
 NqCCY+UwkupUNLUNaUgxE0RsJzcztRz+lNaXqjQpLkJDwQQ3avylzJkrOqUCiyI6mMOm
 vwvxngjX4sT+923c7RST04K+QkTXDgqUA83ZK6OvQzi1ZkcxScU4pI8dd6F+4YkfHCag
 a+XfmiBQkZtCJYdlBIhG2YNC9oLbDiDm5C3wNblwgIS3Fmyvjtva9BJ2Wao2SJRjsuuZ
 Stcg==
X-Gm-Message-State: AOJu0YxACAIprvStPWtKE/lFBU1ug5a9I8+QOeXA5HhLPWrVc3vi2fI2
 HC8ZbjBm9bbu1K2ewgH4YZtX+A==
X-Google-Smtp-Source: AGHT+IF9uiPHAorQd8PR1D7hatFUfpWnUAB5ppEP1nHROEatAneXkcnSveyxiRJ5cYmhIit+j6hGAQ==
X-Received: by 2002:a1c:7c08:0:b0:40b:5e21:dd3d with SMTP id
 x8-20020a1c7c08000000b0040b5e21dd3dmr4895628wmc.107.1702480103187; 
 Wed, 13 Dec 2023 07:08:23 -0800 (PST)
Received: from [192.168.71.175] (76.red-88-28-19.dynamicip.rima-tde.net.
 [88.28.19.76]) by smtp.gmail.com with ESMTPSA id
 fa17-20020a05600c519100b0040c46719966sm11982085wmb.25.2023.12.13.07.08.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 07:08:22 -0800 (PST)
Message-ID: <089f4e83-528c-4758-b353-7ef675bf9fa9@linaro.org>
Date: Wed, 13 Dec 2023 16:08:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] tcg: Move tcg_temp_free_* out of line
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231029210848.78234-1-richard.henderson@linaro.org>
 <20231029210848.78234-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231029210848.78234-12-richard.henderson@linaro.org>
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
>   include/tcg/tcg-temp-internal.h | 29 +++++------------------------
>   tcg/tcg.c                       | 25 +++++++++++++++++++++++++
>   2 files changed, 30 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


