Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC2E7D7566
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 22:23:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvkOv-0003oC-Ea; Wed, 25 Oct 2023 16:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvkOm-0003gO-4O
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 16:22:41 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvkOk-0006xg-MP
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 16:22:39 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5aa7fdd1420so162216a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698265357; x=1698870157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EH00ShC+bYI+Rh5dYlT3bo9krZsHAkI8ga6LoiJ5Lx4=;
 b=Dh95F+6wDVumNzN+YMiie3V7Uzu8A6WT0KMXmYcgdSk2faRoAPd0TO+05WZ0azMspz
 ZYlIFuQbiipWrC2gojQLGllHBgB4/N+e5RazDAE77wSoAQekagNDP7md4+L8bbRUWRM6
 1Xp0ecy/ZP2vbXZ9lvqbTmJfb1+6u9Ae2C1ouVOfqSpfEmDVOa/Sf2Fczq2LLUXcf65J
 czj8zgsxvH59695gaEWNyctrCvAuwKufr0KNuId9jTxAXkBwNqXrRpHDpPsg1w1MQaqL
 PO3ousFmHJ/DzpeGvSv7hbzyKXta9lSKMtTsCB/0MZAJVu3fm0zrUzTLEmU3Oop1G93f
 IyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698265357; x=1698870157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EH00ShC+bYI+Rh5dYlT3bo9krZsHAkI8ga6LoiJ5Lx4=;
 b=ClJkx5lw1QsECqjsQ0JjUtoiw4rJ6bWahGwL8FtE3pPOOxeD+FdtqBI+DZ1lA3W52W
 0r0rIQMReVDINUFIXnalyDKO4cU6Lwg3uNpROd7RT9bjzWmAJq6psrmdn/0pBySr0oaG
 XBSQyxuf7wBxe7LfRbj0TvuOd9dFBfh3EtsapwD26xwEDL1V3CXZ8q90goZNK7pvuc1/
 7v+ysACHNZnRULBrM0XEpoxr2WSe/bNcCXEc2GVm6twq+g2AjH7CV8rwrayRm+m00qRz
 Iq7AmfoPYgkoHO6RVUV5gRPKB8utc9+/Sz4scein80Zd8WrCqn4ncNL+/GmTeVOodKiK
 pRfg==
X-Gm-Message-State: AOJu0YwU1aVnlWiAuPgsc5EypFXy5G9nglbqwspTH+eHcb728QPgS4BX
 P+FfiC8iLrYiwmVEliN4JSu4toiUow1WHEJQUzk=
X-Google-Smtp-Source: AGHT+IFSkqZgxcfcGyzhP9I00w/HU9vsafzg6MhojFR8kRAhwzb5e1qEfPjZFPSgrYb9V3kEFWMhlg==
X-Received: by 2002:a17:90a:a38d:b0:27d:3fa4:9d9a with SMTP id
 x13-20020a17090aa38d00b0027d3fa49d9amr13380033pjp.29.1698265357199; 
 Wed, 25 Oct 2023 13:22:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 24-20020a17090a19d800b0026b46ad94c9sm320918pjj.24.2023.10.25.13.22.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 13:22:36 -0700 (PDT)
Message-ID: <f8282bf8-071f-4aa9-833b-d694bdb85467@linaro.org>
Date: Wed, 25 Oct 2023 13:22:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] target/mips: Use tcg_gen_ext*u_tl
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20231024165903.40861-1-philmd@linaro.org>
 <20231024165903.40861-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231024165903.40861-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/24/23 09:59, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/mxu_translate.c | 44 ++++++++++++++++-----------------
>   1 file changed, 22 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

