Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9861E7691FB
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 11:43:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQPQJ-0006d3-ID; Mon, 31 Jul 2023 05:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQPQH-0006cg-DU
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:42:41 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQPQF-0007mV-Ii
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:42:41 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b9b50be31aso62408461fa.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 02:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690796557; x=1691401357;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=94rJexk6sJ80zfrLyBFxHVQRG+5JO+wxJCGHv8Ci6cY=;
 b=TW/W62NHyN5yFFqRyI5FEVACH8iPVQSKFl15UBGyQes5+je6jBN8bxcojAP9iTOleY
 tZ5qSOHwR/YpzTAjSZEibYfwGMf7dQA5BYjjfaO8lNh/cAOgY9InbMSl+R/g/6o1giQL
 Xdpcqpi3LV9UyKKGPAy0XAhhU0xeDnUeMKChRzDZjPJtzIEf9pya37QXjaqstB1kOH1i
 7rNF0tLZlRA3PtQodiCh7P905ZOxW/rRvbHVFxDZk4ZkcvpNzaVTrt6gdDF1ojIwvYj/
 omD9iP233dboEVXgPGL9J5Mt4ldcy1KOUVcdytWXyfziL4kxUG8ewGgkHCm8aO/WJvl9
 tIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690796557; x=1691401357;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=94rJexk6sJ80zfrLyBFxHVQRG+5JO+wxJCGHv8Ci6cY=;
 b=Y+0XpOFBid95S4Vn3fcSNWc/Rt02zWqNyHff49jRc0Rw1JFKbWCbXIL4fQIJT9JY6y
 EDICC5BjEERIPayGI0oFvAOdj5y/sBKb5rmLqzu+mq7U9ESOpde5izbFuZYrMRU3Ud0H
 6LRaf77ztnUKcuW2M1ykfKX8oeK/3Y7Xw2iIc54Yq0s2VrJnX7Oenm8V4uKDr+hSyUkq
 4h4DDKDh+mmkqrBmdWkmJupdosONptgxbba9sXSyAHHs7IG749Fo+dqVD4XrVFaQ20e8
 HrN+HqTOe6r8Ok5CfQ0XLpTENUQe7puBXmgiyL3cjmrAzs4h/hHx8Kq0b2X9nCuO+tzq
 doDA==
X-Gm-Message-State: ABy/qLY94qzj7BTq6XaUI8u4VXYWSX6KwfB04TlgDG/WFRiDJd7ntYW7
 TPD5g2IauLnaKO8/PyBG2UqHvQ==
X-Google-Smtp-Source: APBJJlGRVt6D0IbUFAmmzDXvN5zlGCpiwW+YhaeezL3FH34Z/dxlajV2mu8L8gU5Dv9AUJKt7ztcFA==
X-Received: by 2002:a2e:9995:0:b0:2b7:ae29:88fd with SMTP id
 w21-20020a2e9995000000b002b7ae2988fdmr5651451lji.48.1690796557293; 
 Mon, 31 Jul 2023 02:42:37 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.143.207])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a05600c294200b003fc02e8ea68sm13834403wmd.13.2023.07.31.02.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 02:42:36 -0700 (PDT)
Message-ID: <88c68fbc-06d1-03eb-9f42-ce95635eba3c@linaro.org>
Date: Mon, 31 Jul 2023 11:42:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3] linux-user/armeb: Fix __kernel_cmpxchg() for armeb
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, John Reiser
 <jreiser@bitwagon.com>, "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
References: <ZMQVnqY+F+5sTNFd@p100>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZMQVnqY+F+5sTNFd@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 28/7/23 21:23, Helge Deller wrote:
> Commit 7f4f0d9ea870 ("linux-user/arm: Implement __kernel_cmpxchg with host
> atomics") switched to use qatomic_cmpxchg() to swap a word with the memory
> content, but missed to endianess-swap the oldval and newval values when
> emulating an armeb CPU, which expects words to be stored in big endian in
> the guest memory.
> 
> The bug can be verified with qemu >= v7.0 on any little-endian host, when
> starting the armeb binary of the upx program, which just hangs without
> this patch.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-stable@nongnu.org
> Reported-by: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
> Reported-by: John Reiser <jreiser@BitWagon.com>
> Closes: https://github.com/upx/upx/issues/687
> 
> --
> v3:
> - use tswap64() in arm_kernel_cmpxchg64_helper() [review from Richard]
> - mention that bug exists since qemu v7.0 [info from Markus]
> v2:
> - add tswap32() in arm_kernel_cmpxchg64_helper() [bisected by John]

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


