Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B98800B22
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 13:39:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r92mZ-0007cq-NQ; Fri, 01 Dec 2023 07:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r92mX-0007cT-3g
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 07:38:09 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r92mV-0003Ed-7E
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 07:38:08 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50bc743c7f7so2823669e87.3
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 04:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701434285; x=1702039085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aJh++K+d4yNCAqMv6qP4dBCvQBedPipsezm3BLTLEqs=;
 b=sF/IvptYKdLzIWuW92QQU5lXtJ0znhvTZuv3S4N1jvVXSVtiT8Wvh9W+UM3h60H5G5
 I5RwxJDOgBgRcfJ9aSMLxKs+dopa0rf10YoCNb61QCa3SlZvZsE0bbBiIy+5YXXEvDE8
 hp2hSMdklsc45ZB9SQIaQyMLNiMdFY+RTJqAJ9ecKUEmjWYDMM4Pn0mepi2xn4oXzYPu
 q/rqtvYOLZEiKiCYPZ3Vova38N6LGkMzHe5qgQvSk2DwvqeNaHoebI+nnengkVj35QOa
 DhhEAq37IiW9Ng6pv+c4j8OGNncSblNjypafJD9lanAfFvaBuVZRpckcvr1X/Uk0on4S
 jKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701434285; x=1702039085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aJh++K+d4yNCAqMv6qP4dBCvQBedPipsezm3BLTLEqs=;
 b=IUxU13WupFiOFzaDCi62Gfhj5f/blAEdFLMM2k0XTF2d7e6k039OiIYK1eU1BUxd8w
 p0H99VTaica5BLnYxV/+XWgVGA2TS4o3dW47eD0yPTWUnx4ujARnnivDsw8II6z+4+tq
 ATulIJKiswEedZxyWWomvh8vELXIX+Ge7tvi+S2CgIGWceoNmuB2BWsnbotpM8v47qcL
 R3Rc+mTOHtMC1OZIf7MhBBH1qgWpHxcgLcJ8Mz7VF3QL7ZEWyaXmaDScbtnxaSwm2P8D
 D+O2dF2UddfQpCuCRMuJL3FRPafTGus30Qgb4eiGUUxJt4jz44z3NERKovK5htoAYMhZ
 vy5A==
X-Gm-Message-State: AOJu0Yy3jIGHq06jmpN1BtOZLoTydHtcndnagIwYc+EAAuTVb8NJFjK7
 T3MSQPrRQcJ6DiV2C5UcrWXF1g==
X-Google-Smtp-Source: AGHT+IHBheyzKXXCKc4hZ9OvgWQp7McQWIoZ2oU3AMbhB/a+3NecV4unh/NEnT9LesYAK57xm+Y5aw==
X-Received: by 2002:ac2:5e2e:0:b0:50b:d764:649b with SMTP id
 o14-20020ac25e2e000000b0050bd764649bmr645191lfg.80.1701434284678; 
 Fri, 01 Dec 2023 04:38:04 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a5d4686000000b0033315876d3esm4099137wrq.12.2023.12.01.04.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 04:38:04 -0800 (PST)
Message-ID: <3d64ec14-09a8-4446-9a22-2b2981b1bc06@linaro.org>
Date: Fri, 1 Dec 2023 13:38:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2? 1/2] linux-user: Define TARGET_O_LARGEFILE for
 aarch64
Content-Language: en-US
To: Shu-Chun Weng <scw@google.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231201032140.2470599-1-scw@google.com>
 <20231201032140.2470599-2-scw@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231201032140.2470599-2-scw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/12/23 04:21, Shu-Chun Weng wrote:
> In 050a1ba, when moving the macros from preprocessor-guarding to
> file-based definition, TARGET_O_LARGEFILE appeared to have been
> accidentally left off.
> 
> This may have correctness implication, but so far I was only confused by
> strace's output.
> 

Fixes: 050a1ba69a ("linux-user: move arm/aarch64/m68k fcntl definitions 
to [arm|aarch64|m68k]/target_fcntl.h")

> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>   linux-user/aarch64/target_fcntl.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/aarch64/target_fcntl.h b/linux-user/aarch64/target_fcntl.h
> index efdf6e5f05..55ab788a7c 100644
> --- a/linux-user/aarch64/target_fcntl.h
> +++ b/linux-user/aarch64/target_fcntl.h
> @@ -11,6 +11,7 @@
>   #define TARGET_O_DIRECTORY      040000 /* must be a directory */
>   #define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
>   #define TARGET_O_DIRECT        0200000 /* direct disk access hint */
> +#define TARGET_O_LARGEFILE     0400000
>   
>   #include "../generic/fcntl.h"
>   #endif
> 


