Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 458D77E28CD
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:34:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01cX-0004E1-8Z; Mon, 06 Nov 2023 10:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r01cS-0004Ae-8A
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:34:28 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r01cQ-0004ZU-LS
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:34:28 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9d8d3b65a67so676838466b.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284865; x=1699889665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z52539ZZk+yxZaKzausWKXJ79E3nCCPtZhMbsExE5w4=;
 b=hSK9noadkmsCcWgaFJqBY9SE7M5aS3JGVQQfwcq/gv9bx1CR8WdT9RPAo2wZUEV9AC
 Me/SvDSgZlMJqStFEmuiPGWRD5pj/1dO0VkpMkMTjKhh0KbaeyuVpFkU/0FQUQoK81C+
 EpojKDlKgXzecviUUKSokjJ5p1NoncfYQc2Cal5rZP3Z9gT6Gv5KILHfYOYzvkIv8r8Q
 cF46TK5DCh9NuPjeZjECT7hl/SodpkUxVP68gPF5OhfuImcKHiGp9mpL2euWUI45M4LU
 92WUjmncktEIvr4x3/A2kPXmYI72la0HUxYlVM3qNvBtcJfL5iQNfnLrW45TtcdFhrox
 drMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284865; x=1699889665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z52539ZZk+yxZaKzausWKXJ79E3nCCPtZhMbsExE5w4=;
 b=Sjsd8hrQS7Bb0NkSuGQxrnEKH/A7mzj/2QZHGU+AQR7ksPS///oh1CapgGkeKfYEFC
 mu5xPBnYwKmnpFt1JTDEv8uNL5mRa9xykSpwsKS+gO1M0MJi1bMnkhPwryHhHiwjY7Oj
 14rSygIyiSQsu8bDUrq49sSqyXeeuMiNqSnZsBcrQu/CRLFlEAqyodxgZqqpKXzthwTz
 lHQQ0KnXIFLI4lqfdIxrczuioA1S9jGpqGpDawj7IWKi+73q8+0F7DQ0e/EXlaWibHyV
 QPdOiq4425SATQ4OEODvA3Ndk+qtKGFc5py5B6LU4mwqfpHS6O0fMRQQX6b59O6cvVmo
 Yj4A==
X-Gm-Message-State: AOJu0Yw2fb2JWJlLobybkRj+bNoCvXwWtCTxFK/WZcNYZ80YPGO4YOmQ
 jUhLhCNJsZkjATB/X4BrKZZxIg==
X-Google-Smtp-Source: AGHT+IECL3pZ0OHO0prnP85fAekEUncgx92otXuecGDgBYODqMTs9WQnwuwcNe8Q6kH5Rp3x/MHpIw==
X-Received: by 2002:a17:907:98a:b0:9ae:69b8:322b with SMTP id
 bf10-20020a170907098a00b009ae69b8322bmr13286696ejc.60.1699284865052; 
 Mon, 06 Nov 2023 07:34:25 -0800 (PST)
Received: from [192.168.69.115] ([176.172.125.26])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a1709063bd100b009cc1e8ed7c5sm4231798ejf.133.2023.11.06.07.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 07:34:24 -0800 (PST)
Message-ID: <270472b5-5db2-73ac-8645-2c7ee59fc106@linaro.org>
Date: Mon, 6 Nov 2023 16:34:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 05/35] tcg/optimize: Split out arg_new_constant
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 28/10/23 21:44, Richard Henderson wrote:
> Fixes a bug wherein raw uses of tcg_constant_internal
> do not have their TempOptInfo initialized.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


