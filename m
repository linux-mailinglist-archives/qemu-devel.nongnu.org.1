Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BBA746052
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:04:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGM0u-0004vD-9D; Mon, 03 Jul 2023 12:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGM0s-0004np-71
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:02:54 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGM0q-0006Hx-7D
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:02:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc54cab6fso38072575e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 09:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688400170; x=1690992170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DdCgr/met3qApu8Mb7xwcxDNQPvkh7I3Mm9mGg/3Pos=;
 b=Eb248sFqMMTkHFnrq3ZXeRUo0x5U3NGkwZoQolx9zUixMDbf7x90HuQnzTO41tDq5n
 myhkMQHzO+HFZpzMdvoQkr3etIwgKiz9Eapnd0yIRjURK4ea2fkoUyC72rePr9e+0nST
 l188If2e85Gf+dBabUVweJQauq1Js+IOaiTrdlPP0tZMhBaaCtU4HH8PkuN0ByZ6Izb8
 bNVBWqdx639BT78RGViIEKVZAxy+OYCHfGx6iWymquPfo3C19qif8e43vnZyDiIbQyjO
 8kQ7PSYeBNPLJz5hUQnK79YwwUJaAIH6qCtIQBUFLtNooDix5tIb4QYhhyWVyf7aYos6
 jCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688400170; x=1690992170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DdCgr/met3qApu8Mb7xwcxDNQPvkh7I3Mm9mGg/3Pos=;
 b=gls2URwNmN15t2nb8jQA1f032NN9kXLgzwMDXVSs+CeAp6MmPDYbhUJtvELbsxzqGs
 6cW/6dreLyum7zAmTXvKa71gJrsFT0KVbTJWpPdOclhOraaDjgvH8KqCww9dwYvJoW6k
 REG0mWgmaiCbsAyNr8niNPEdVqS1D8bNAsxXzgLtFE6d8KXNE1VUYQ5pN3b8zIgWJrG8
 eTbtRBgAIv9ZEeYCAjxmoXIIgmKuoDASVdq5u+rk3DR1qvX6CeBhJii9o4xNKrEjP9Kf
 ThSVG7+gcpWtGYx1HqqgarbJRpU1ZiUs1ZB3+Sy3+FHUc1hG9tecU0IeTiPH0MQRG4Pi
 N3Mw==
X-Gm-Message-State: AC+VfDw+JIepglhSl+Yy7eUBhGBTTpuWlmv4co0VNmIzPAAMGiUqm+g2
 kJenZzOxSQ5UFPjVa+27VHtbyDtKcT5EkrV9ljFPPg==
X-Google-Smtp-Source: ACHHUZ5EJ4lqMR/4vkHkhHNKtSDQRJ6WqUBqkj8g4HRIS5NWpXZbnHbCDmxxprCsAiJ0GTZYCef5Wg==
X-Received: by 2002:a05:600c:21da:b0:3f8:dac6:58ee with SMTP id
 x26-20020a05600c21da00b003f8dac658eemr8295643wmj.5.1688400170248; 
 Mon, 03 Jul 2023 09:02:50 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a05600c211400b003fbb618f7adsm13217997wml.15.2023.07.03.09.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 09:02:49 -0700 (PDT)
Message-ID: <0113bc73-5b0f-be77-26c6-c7412e76e1a5@linaro.org>
Date: Mon, 3 Jul 2023 18:02:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 05/24] linux-user: Split TARGET_PROT_* out of
 syscall_defs.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, laurent@vivier.eu
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230630132159.376995-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 30/6/23 15:21, Richard Henderson wrote:
> Move the values into the per-target target_mman.h headers
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/aarch64/target_mman.h |  3 +++
>   linux-user/generic/target_mman.h |  4 ++++
>   linux-user/mips/target_mman.h    |  2 ++
>   linux-user/syscall_defs.h        | 11 -----------
>   linux-user/xtensa/target_mman.h  |  2 ++
>   5 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


