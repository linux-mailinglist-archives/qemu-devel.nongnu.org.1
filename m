Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB637D1840
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 23:35:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtx9a-0001ih-Oj; Fri, 20 Oct 2023 17:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtx9T-0001hs-Mu
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 17:35:29 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtx9S-0003Wi-36
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 17:35:27 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so195644466b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697837724; x=1698442524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wLSooQ+3ySe4mxkgVtXV/vCbnBnlB9SGltjYmQv2KKg=;
 b=ebNJBp2QJctKASN8fDN8zPRlr6luebEbcMHBCDIPGqH82PDqCRW3E2a/89m1+dCAxC
 rgo9EO2IVf1szGfXCmqdHQHlaqRoQ+Gc/SpL6sVWvGHs8uVIKopdDScTk1XJ8OfYHsVr
 9ocJzWgFQJqEzd68hb5h4JtLU5ISRyKyQL/35l5FwvdDBhdPypfQBjwCUSzNYloz51Iw
 NvUMOOr3jtShMdkoDVxAW6jj7n1pmF57D4YmI/GJKwZVPezYdRkB7v+NiV1xnHtkADwr
 vwlMBYv4Wa0oIGN2vDE8iTEbIwE+b+3OjMUN6gDeR+6deoxY1rN8mLclP/qLycuJQ9LY
 CLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697837724; x=1698442524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wLSooQ+3ySe4mxkgVtXV/vCbnBnlB9SGltjYmQv2KKg=;
 b=iVI85V2wDXdKA/4sBJsN7Jlhujc+2IGtXxFWArhvVmzY8vtSZCuQQIVtCb7hKe0JlX
 qPhFTexbkAvjMKHJ35R0i1UrzpMgT3sP0/P0TGsLnO8GVcTjegNK8EBxo3HUtV859G9P
 Bwuc5p9jywqNOdG6q6qXN9i3abeBtUhQx73N0E+G7ZCTBPQOXkoubE/ayX4bGCJkVmiX
 o4/w2ftbfhPrhVUPoQWJO5XlaJmwqUXXfNh6NRB+8eGc1pWgGakvj58zbXUp1p57Q5fI
 eGWD4bK0fcEuDAzr075DtBF1QOTzuZrBQ7KwTmwTIb9JbiFZ/30wwGN+cEhA3lJCOO64
 ldSA==
X-Gm-Message-State: AOJu0Yxgw6LYDlBiD1P2yPtGzdyjOg7hfGpLJSJBDrLRhwuX7Wv2Z9+D
 NpPCdGWfLzc0jH6vcmgfEJ3Iyw==
X-Google-Smtp-Source: AGHT+IFRv0nBVYy1EWLXO6qN55OD+vSv7BVKaqaBOxv4tthXIGigItCI2ABIdmUXC0X1T1+W+otr5w==
X-Received: by 2002:a17:907:6088:b0:9ad:8aac:362b with SMTP id
 ht8-20020a170907608800b009ad8aac362bmr2542799ejc.23.1697837724024; 
 Fri, 20 Oct 2023 14:35:24 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 ze15-20020a170906ef8f00b009bf7a4d591bsm2204070ejb.45.2023.10.20.14.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 14:35:23 -0700 (PDT)
Message-ID: <e0cb30bc-e0d6-175d-0fd3-b8cd41e9d75d@linaro.org>
Date: Fri, 20 Oct 2023 23:35:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 19/65] target/hppa: Adjust hppa_cpu_dump_state for
 hppa64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20231020204331.139847-1-richard.henderson@linaro.org>
 <20231020204331.139847-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231020204331.139847-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 20/10/23 22:42, Richard Henderson wrote:
> Dump all 64 bits for pa2.0 and low 32 bits for pa1.x.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/helper.c | 28 +++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


