Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F55F79DFEC
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 08:20:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgJEg-00062m-MF; Wed, 13 Sep 2023 02:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgJEa-000616-Dk
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:20:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgJEJ-0003EP-Fg
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:20:19 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-401ec23be82so71067515e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 23:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694586002; x=1695190802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SB96KD18npn/kcrw4zMKGB5t2au2/Jt4/BcLy0E/MSQ=;
 b=HxMJfCwAh+vtfDK2dPZ8CuwEvxLF6jL3bmdz+Fboy9yff93MCYo4xvnOdkArvfGBIG
 y3ft6n0/1nU3Mwl187dkp1JsEirdy6Wo3XvL4k8GZmEgmCJHGw4cVJt3/k309/7BPVYK
 tFiUEsaGlpi87QIacWArCXIgwH9hNfzbuwimXPufpcdkbEd9SCqKiAV/VVxqMj01z3AE
 emHZEdt07lFQci+GGFMj0w3z7979WHP6LRPM8TAdNOzw0dmguiwPPJvA8sHyjDhIsevs
 nhKIV73cTLjypbAtIoxzkhTbOVh7RHg3B24lOeffZqEekMZB0Pfa3xtCxk9IdA/9knt5
 rwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694586002; x=1695190802;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SB96KD18npn/kcrw4zMKGB5t2au2/Jt4/BcLy0E/MSQ=;
 b=FyF0EE5b2kJ7qFt5uBgJe6zmjkrczBGTxGfI3MdRiztbGDNuVrBbPRBxQGkhQr5H21
 uuaZKL7P0RZvDwmECOSCbYbRjXb4wLawYqwKHJ+haNYWAgrN0/F7NRkWY7uxILn35i5R
 wJZeOvAAgSCnvYugm1ZbQm+c/3QyU7vRlZo9vOciCl58Uka3FnhCHDRK4F3ZqN4LgSPX
 GstyNm5Wi7AosSespN0YCkWkedY6btOami6eB3R6ss56zv2VZ2Hc2YGJVGwg36BHWeAo
 bYWJkjP5GOmbgcwADLAvATDSSTuawQgtinXmqD/9FfOdYryRTcsmfLr/fo/nc7XDmHtY
 CwDA==
X-Gm-Message-State: AOJu0YzfYfpod5rX/ExElllxnnLlmGCwSIQs74kCSn/m57usenj1Ng4Q
 fo+Vv8wB0Iki4ncz5gznAt9GNA==
X-Google-Smtp-Source: AGHT+IF7XPvrU8dO9+2DrNJ2HDr6qdMjaTuxGtuxLD6rLKhl7+MWZPYYkTo9rf06Vm4UjzvZA9rRvQ==
X-Received: by 2002:a05:600c:241:b0:400:ce4f:f184 with SMTP id
 1-20020a05600c024100b00400ce4ff184mr1229411wmj.41.1694586001816; 
 Tue, 12 Sep 2023 23:20:01 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 t11-20020a1c770b000000b003fc04d13242sm1010978wmi.0.2023.09.12.23.19.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 23:20:00 -0700 (PDT)
Message-ID: <270f65e9-2036-4c5a-f29c-49edebbc58ad@linaro.org>
Date: Wed, 13 Sep 2023 08:19:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 2/3] target/ppc: Use FP CR1 update helper more widely
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org
References: <20230913005814.413113-1-npiggin@gmail.com>
 <20230913005814.413113-3-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230913005814.413113-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 13/9/23 02:58, Nicholas Piggin wrote:
> Several places open-code this FP CR1 update. Move them to call
> gen_set_cr1_from_fpscr().
> 
> FPSCR_OX = 28 so move that to the symbolic constant while we are here.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/translate/fp-impl.c.inc | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


