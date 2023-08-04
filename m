Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E81770923
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:37:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0c3-0002th-SW; Fri, 04 Aug 2023 15:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS0bw-0002sX-63
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 15:37:20 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS0bs-0005Eq-68
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 15:37:18 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3a3fbfb616dso1800369b6e.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691177833; x=1691782633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RkWw1sVHSLAkYM2E19JazQnGKXNRqm0SBAsZJUnqiW8=;
 b=digaXDJx2AMZ+foXbQBwdioAhGH8V+h+5jqRhFTV4H07MoH/kWWXpVujgCOK1QRUNI
 4gtjTj7yC3wJaGIUeXmiZZ+bYypcWKL2jMnOaIxoRrN9KYjD6PqaImDippnDsGfdMkzH
 j5+xwQdfjAuZ666hh6Squ/4Qun39cQLl1RbqDOuvWVXcYgnCIfyMxoLdZNJ3QLLjxxpX
 H8A10JsiJZd70ouQovQwAArIBn/dUgnMadZqaQ/h0uwgbq7Z4ZvjKKMsRDur+lfDJF+0
 ZZqv6eVvsVgWzprhnqqRFtJ+SAAXEI1ZHFH8uov+EZLwt4zG9AktWrTu9dw8EfUyG538
 ufzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691177833; x=1691782633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RkWw1sVHSLAkYM2E19JazQnGKXNRqm0SBAsZJUnqiW8=;
 b=kiGFItcgXqxCk8dSkd1InHqU4mo8xEdhtkuoeeI8m/lshKrL/0+VpXnH4ujR8TpIG0
 +GYWjvPmhA1Ymuh2LSiU8B2BKPjm+EQTjnL5XISLSPlqiS5aTJSqlhJYGTvyG4zwSuTq
 5iU6wHXR1x0Q/kWVo33jRwZQhV1xyXFnewq0PgSrNq+gTwA55RqYYIb2oyDFg3LdiPA6
 D19781iVJIQJaUpwwxuWpdiu6VNbDG/lGNyYP1uMtvNVQtubAPebd7Jve/1gKV5y8pWk
 xDY5aP5HUKYfAKb0TxgEGGrYvQ0q7rhYMryJQBZzmgMuw8pvm3YWrKanKL4vNF9xUEoj
 8kqA==
X-Gm-Message-State: AOJu0YznZQVUacgkkpwCt34b/W8I+uhuVVeR8xvQmKaVj3Z2xfHrRUwr
 JtvXTZPVSG3cPUsqPh5qyWdCEQ==
X-Google-Smtp-Source: AGHT+IENqTzNKThxtuMa5J6SszRe7lafZZrZKzO4Divu6unEkADBJtXxn9vmP98lLZcb6Vyd3sIBHQ==
X-Received: by 2002:a54:478c:0:b0:3a4:17cd:dd31 with SMTP id
 o12-20020a54478c000000b003a417cddd31mr3194305oic.14.1691177833584; 
 Fri, 04 Aug 2023 12:37:13 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:1eed:f77f:f320:8b14?
 ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 15-20020a17090a0ccf00b00263c6b44dd8sm4804401pjt.15.2023.08.04.12.37.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Aug 2023 12:37:13 -0700 (PDT)
Message-ID: <9f0e6e6c-2ba6-ef89-8b60-8e245cf39b08@linaro.org>
Date: Fri, 4 Aug 2023 12:37:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/7] ppc queue
Content-Language: en-US
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peter.maydell@linaro.org
References: <20230804152955.22316-1-danielhb413@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230804152955.22316-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/4/23 08:29, Daniel Henrique Barboza wrote:
> The following changes since commit c26d005e62f4fd177dae0cd70c24cb96761edebc:
> 
>    Merge tag 'hppa-linux-user-speedup-pull-request' ofhttps://github.com/hdeller/qemu-hppa  into staging (2023-08-03 18:49:45 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/danielhb/qemu.git  tags/pull-ppc-20230804
> 
> for you to fetch changes up to 0e2a3ec36885f6d79a96230f582d4455878c6373:
> 
>    target/ppc: Fix VRMA page size for ISA v3.0 (2023-08-04 12:22:03 -0300)
> 
> ----------------------------------------------------------------
> ppc patch queue for 2023-08-04:
> 
> This queue contains target/ppc register and VRMA fixes for 8.1. pegasos2
> fixes are also included.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


