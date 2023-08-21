Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E93782F73
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 19:31:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY8j8-0003Qo-HS; Mon, 21 Aug 2023 13:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY8j6-0003Px-AB
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 13:30:04 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY8j4-0002rX-3S
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 13:30:04 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31965c94001so3094592f8f.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 10:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692639000; x=1693243800;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EvO69nucgaFjZyc/ys1Q2ii8/KbXilX+Cn2Pm0FkLFU=;
 b=NQu46tlc/QsJr6ZLMPtNQJzTYoDg8o3/msdyGoY9ilreGjmA+cOMdrqT8+RbpcwZxO
 6jfE5DdnTrvDqI8BxcXzOrEwE0uq0Z3bFEeUgA5Cdec42c7ePcqVcbD6nZyia9J8CI4A
 cZy5RqaT9+OI4srMtGnrgtRfsBSrPP0sdf/r4cNYuRa3LMs74SacJ29oCccuU0B0jOK1
 O1ATZkG4F1FFw8KFsbNeXaAR1gmTgxEeIK4xv1zfCYstFWK039UVPte7ia3ycQo5ltqm
 9afC6eGWJfUHNKAJfOI/bsFtF49ze2lk81dO9vfq68tnHFZCU3fl5ixD9bIHYhfzXNKR
 A45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692639000; x=1693243800;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EvO69nucgaFjZyc/ys1Q2ii8/KbXilX+Cn2Pm0FkLFU=;
 b=lanDtaGbbcVQgY0EmJ5azc8efgY9yvh3Lg/yjkjwWk3WesdOy49UagioFeQzmiz8b0
 tIJGPFMov3o+OmkrkHSHjuI8GtB39uOvlz7rGi7obGdXPeiAjFXC+OCugMOlrxCBWoTz
 P8yRsVp/q5p7Wg+2SwoJw4GjvrBBrIk8+EU2kPhuPrNsXfgx5wyi5GwqZJXNyiP8hJuR
 a6pBca8NUcPcPQDwZHxb0xIRKFEmDcjSziwdPhRB0ORTtMbCZu/odiY0CH8yPSI125s9
 fhqOI3ffSu9Gi2OnjYtc/93N0ZMkYE6g1i/UyrwkAs3d2p7bhpm3QyNDUFOtsr0ocxei
 Q4tw==
X-Gm-Message-State: AOJu0YzOuLUXT5uTAIqXD8jaD+cYkZEnCPKq6WH3ng4lrvJYLiZ3WTC+
 SSyIGagq0Rdw+Ms4CEYpRjdPTQ==
X-Google-Smtp-Source: AGHT+IH1nY/orGV88m247xIhYGvt/bH04SF8MOS1g9PXAv2h6xy7CnBMs953jkQ3f9i/ITAZ/R7hEA==
X-Received: by 2002:a5d:6949:0:b0:319:7471:2965 with SMTP id
 r9-20020a5d6949000000b0031974712965mr5467203wrw.21.1692638999976; 
 Mon, 21 Aug 2023 10:29:59 -0700 (PDT)
Received: from [192.168.69.115]
 (cor91-h05-176-171-248-246.dsl.sta.abo.bbox.fr. [176.171.248.246])
 by smtp.gmail.com with ESMTPSA id
 e1-20020adfe7c1000000b0031b2c01f342sm7232713wrn.87.2023.08.21.10.29.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 10:29:59 -0700 (PDT)
Message-ID: <8a237a8f-cad1-a873-9c38-218f51699786@linaro.org>
Date: Mon, 21 Aug 2023 19:29:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 15/19] target/i386: Use clmul_64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org
References: <20230821161854.419893-1-richard.henderson@linaro.org>
 <20230821161854.419893-16-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230821161854.419893-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 21/8/23 18:18, Richard Henderson wrote:
> Use generic routine for 64-bit carry-less multiply.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/ops_sse.h | 40 +++++++++-------------------------------
>   1 file changed, 9 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


