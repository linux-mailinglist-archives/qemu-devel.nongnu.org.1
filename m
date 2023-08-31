Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E04178F12B
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:23:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbkR1-0002Yh-Lk; Thu, 31 Aug 2023 12:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbkQy-0002Xw-2d
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:22:16 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbkQv-0004FF-Sx
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:22:15 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68bee12e842so819603b3a.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 09:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693498932; x=1694103732; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9LIqioZxB2I5mEfdzUJITll35Gi08IapauPvBjmlcB0=;
 b=nO+z66tlQPW0AfVxah8N7+3sjYR6KWD1qnSM6XOU8CHHfRJOHHEI1Vg8qHh2GkqulC
 j16YCtIxP0YrJ3C41Ox+m1cfMZYNLph4FxPyma3Op9HraEUdC8099w/VYBiv3tX5HSZh
 CJi5DlQmEvA3CxQE3iaTDYZPrUxor5zig/UqluoWFKnS1wSE6Cr7BUsV+RurjNX5aVCZ
 BtFpj0vf4mezYPpQbWFCentkdKvgGK2zLxxoF6cEYy1aBv1D60K4lbFL8scIYkpsuCFR
 AdZLrMcqMqggyNWXCECtlqvU+ukxuwOp3dDu4MIEHecwqo8v0T9DqJF3ldpZa016Wwni
 1yWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693498932; x=1694103732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9LIqioZxB2I5mEfdzUJITll35Gi08IapauPvBjmlcB0=;
 b=fWzl7C10gPTCuZmQSFLN/pXrOesIGyt1VZnmNreLcM6DqLTtkndxgbBntZLD8DaWG0
 3B7OJliIxJBVL43YeKsoG/5pRRHs42kS8vbnFBqgn4An/kjRhK6WgnAlnriaqzbUXHWg
 hixCXMm+3C/MFGsTleDHYMz3MlQsn1w3QRmTkO0A1N0xnJGhc2MQIzPdeODTpCERTe+f
 jk8H1LvUP6NeCqXjdxrQbWQ6UhiNBvLIPvFX+og0ybA1gYqDrat10uRhROi1JzIg12oJ
 w0IFeP0sonr/qov6zhuL9shUvgZWwrmv+nAWDd4JWIOWrxhyQ0JyYcHmMNCBgTTGdXuc
 CR1Q==
X-Gm-Message-State: AOJu0YzHnhgC0CZi2Qr+BVMVQVWvNhseP4+NBDKeJPvLZ07s0934w7xQ
 LN1o1UnvldKaD3Ldk0Vs43Z1kw==
X-Google-Smtp-Source: AGHT+IFhm+uGZ7S1++7dYug2kY1D3YngcD+Y00PkJ4HheOydYtRWPOSTJfzVGNjBmMRfn96vQ2Z9fg==
X-Received: by 2002:a05:6a00:1d0d:b0:68c:1fb:a74e with SMTP id
 a13-20020a056a001d0d00b0068c01fba74emr185162pfx.7.1693498932433; 
 Thu, 31 Aug 2023 09:22:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a639801000000b0056946623d7esm1509139pgd.55.2023.08.31.09.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 09:22:12 -0700 (PDT)
Message-ID: <1555d191-1590-cadb-8617-ca3780dc0dee@linaro.org>
Date: Thu, 31 Aug 2023 09:22:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] target/riscv: Use accelerated helper for AES64KS1I
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20230831154118.138727-1-ardb@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230831154118.138727-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 8/31/23 08:41, Ard Biesheuvel wrote:
> Use the accelerated SubBytes/ShiftRows/AddRoundKey AES helper to
> implement the first half of the key schedule derivation. This does not
> actually involve shifting rows, so clone the same value into all four
> columns of the AES vector to counter that operation.
> 
> Cc: Richard Henderson<richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daudé<philmd@linaro.org>
> Cc: Palmer Dabbelt<palmer@dabbelt.com>
> Cc: Alistair Francis<alistair.francis@wdc.com>
> Signed-off-by: Ard Biesheuvel<ardb@kernel.org>
> ---
> v2: assign round constant to elements 0 and 1 only
> 
>   target/riscv/crypto_helper.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

