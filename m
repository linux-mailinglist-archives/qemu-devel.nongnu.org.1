Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A53247C01D7
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 18:40:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqFkr-0006Ph-62; Tue, 10 Oct 2023 12:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqFkq-0006PY-1J
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:38:44 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqFko-0002Fi-Bg
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:38:43 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c9c5a1b87bso2511975ad.3
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696955920; x=1697560720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xPSW7wXq4+Ny1mwRI36hLCXX+jYJiwl86LXgwhIEZzw=;
 b=GpI1/i82ZKEST6sRTIGGNfPt6NofmWhccS/JHrlxsERx7qkKpdrGrKr4kEIXHGgFnd
 PKt42Jx8OerTLvcbV0xV15guKGr4GJVHzY+w7MqG5ghLtVjP6AiAhkFgMifcMLrKjvCi
 la2vU7jXXDGONYIxd/eLdwFE10sKl64uTMtAa//11Cbj6IRjrfFg+G6mM+rL1zWWGxLH
 WvT+XnTvukyY64ZK1TNA7jPgLe6VOrJFU6DuN6t2RWus8oiRM6+iWYcBCJirjzGDn/3G
 nvaLLX51oXNa8Dx9c1O1QkvUC2gpBhE9edCHZqf+tvAllVAiZmaC8TxTRgQpOoKurWM6
 JpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696955920; x=1697560720;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xPSW7wXq4+Ny1mwRI36hLCXX+jYJiwl86LXgwhIEZzw=;
 b=qlP6K0hbOCqMDclKdcEHACG5pmypZ3Dpc/gfVHIpPH7wwePY9wisdjHUHmFhkDXKo/
 rg1815PyPW6z9wThJzp4AELkw35cNMVobCx+O6Cg9bqxriDlIVwPLwnrSHwZ43qXnV3N
 Ofnx2Hnz0wh1lpIVPcZQYr/1/gqv5PQXokt8NrZF4YbXam3wuhw4PRYdplg/5552KWgV
 hERBNS8eZsS5+nYW/hAZ2devCKGLI58GdAvhjbng8fdZ/U3YyxWHNzK/sCSJBJUfXMRB
 r9tlxuBltq+OgtdUDvY5AaTLMifQvhCWi0fyMbRhYP7OX6b32sG7yIfLH/PpwTbnw/s7
 I7Ew==
X-Gm-Message-State: AOJu0Yz9R2vzCc/bozuWTxUopavuWFBPlOuqSTByBOFas2aJKGM2AIrl
 A14o1OJb6/esJXXR4oyNPSLMegmQtQTAUEVp1Ws=
X-Google-Smtp-Source: AGHT+IGCcu44VASNrHxvYcL1Uyj0OtPD8i4Si6Pj8G8/WNBVGKWeDduhj3BOq+6bNpCV+qaih9tuPg==
X-Received: by 2002:a17:902:db0d:b0:1c9:9573:69b3 with SMTP id
 m13-20020a170902db0d00b001c9957369b3mr6206319plx.30.1696955920615; 
 Tue, 10 Oct 2023 09:38:40 -0700 (PDT)
Received: from ?IPV6:2607:fb90:b763:d52:6ee3:1cf3:f2d2:e12d?
 ([2607:fb90:b763:d52:6ee3:1cf3:f2d2:e12d])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a170902e74b00b001c61afa7009sm12015348plf.114.2023.10.10.09.38.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 09:38:40 -0700 (PDT)
Message-ID: <771f5bd6-a09e-4a3a-a6cc-0203dccc9683@linaro.org>
Date: Tue, 10 Oct 2023 09:38:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/mips/malta: Use sdram_type enum from
 'hw/i2c/smbus_eeprom.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Corey Minyard
 <cminyard@mvista.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20231009092127.49778-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231009092127.49778-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 10/9/23 02:21, Philippe Mathieu-Daudé wrote:
> Since commit 93198b6cad ("i2c: Split smbus into parts") the SDRAM
> types are enumerated as sdram_type in "hw/i2c/smbus_eeprom.h".
> 
> Using the enum removes this global shadow warning:
> 
>    hw/mips/malta.c:209:12: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>        enum { SDR = 0x4, DDR2 = 0x8 } type;
>               ^
>    include/hw/i2c/smbus_eeprom.h:33:19: note: previous declaration is here
>    enum sdram_type { SDR = 0x4, DDR = 0x7, DDR2 = 0x8 };
>                      ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

