Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AEA766092
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 02:12:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPAnw-0003Vv-9S; Thu, 27 Jul 2023 19:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPAnu-0003VY-M1
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:53:58 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPAnt-0001Zc-7V
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:53:58 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3465bd756afso6389565ab.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 16:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690502035; x=1691106835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/7rJRcsZDtoFwKLeZD9p520evCk9FjWLU5t5hU8J9/g=;
 b=L3gzHzzb+4qPQbi5QYojRDnRJS9leMayKfWbDHsgcOKnr6uzQdGJ7O+hXlb9L6AiHn
 JY3I6YKDYMeS4pra+h5y7cUNqNiB1QgdW/gSh8lGiGoaEFACx6JbjoPi9QK03W53msGE
 Z0U5ih95HTVq4Lp8xxIOwyaClL/s9AVbLuc7u7QPRUAVtNl/zJEahdPZlm32pnHxIxgp
 zOZl64fZBYeUu9CjuY9jx+rJRCuL++FfhmM2M5R2qDYnmOX2X0jEXwqSerXgc16R0RIc
 JEHyAhGX5843gz1LgBSZIZjW/XbJqOS69KNhsmHQGVkrJOOOkuNYkMXUes1AhHkUqx1P
 3lLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690502035; x=1691106835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/7rJRcsZDtoFwKLeZD9p520evCk9FjWLU5t5hU8J9/g=;
 b=Ap7wELQ+0hRSvF+ikxkWeUtuZiZrBVNd7EPicrkzwuGlRysgyS05mzSPdqAbfxfGxl
 m5MvMBuGKn5rffrcfBKc9MQ7LhgwVC9jMC1bjxS3540plfPvRd0jDWIQkXwqijYkTWt0
 7JZp4EbEBCVBiIYpi2gYBzTN5fGz/rmozoH8RKrsCBek5XiwNwWZzFXnhL5YqnK3dHIX
 m+jiJvrcwseBwseJuVN8UHgpxcyLOWLozZo0bM5oG+031CWsYk6X4SdThHLEpeqfN0xp
 WH3RZc+7iKgyEmIpwk5NJa4tap4C8Neep1xz5DREU1GnzGplt43wcpfp9qRsE8IZN6On
 3wbQ==
X-Gm-Message-State: ABy/qLZWqxGHgFX2+19E7VClxDBTWQ8/vgGM66mCsEFRLHvq2iqs+5bN
 7rnIICXnTzzobamktnBhwYVxYA==
X-Google-Smtp-Source: APBJJlHk9kt5XYXP8z1tZd9A5CofmSZN+O4I0U00kjlnMojugFmT/4h1aagBoNzjEdCPklJESK/97A==
X-Received: by 2002:a05:6e02:d4b:b0:348:8125:acd with SMTP id
 h11-20020a056e020d4b00b0034881250acdmr875153ilj.27.1690502035608; 
 Thu, 27 Jul 2023 16:53:55 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:943b:b6e1:1f00:9721?
 ([2602:ae:154e:c001:943b:b6e1:1f00:9721])
 by smtp.gmail.com with ESMTPSA id
 18-20020aa79152000000b00686f0b15b06sm1970418pfi.188.2023.07.27.16.53.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 16:53:55 -0700 (PDT)
Message-ID: <76fccd58-b475-9784-0401-01e75fc6551c@linaro.org>
Date: Thu, 27 Jul 2023 16:53:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 9/9] accel/tcg: Update run_on_cpu_data static assert
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org, agraf@csgraf.de,
 dirty@apple.com, rbolshakov@ddn.com, anielhb413@gmail.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
References: <20230721205827.7502-1-anjo@rev.ng>
 <20230721205827.7502-10-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230721205827.7502-10-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/21/23 13:58, Anton Johansson wrote:
> As we are now using vaddr for representing guest addresses, update the
> static assert to check that vaddr fits in the run_on_cpu_data union.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   accel/tcg/cputlb.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

