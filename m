Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CCC78D094
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:28:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nr-0001ZI-Je; Tue, 29 Aug 2023 19:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb550-0004Yv-WA
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:12:51 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb54y-0001Sd-RT
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:12:50 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a86a0355dfso3293937b6e.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693339967; x=1693944767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZkHtxYxtgz/j5KBlg8wbBUi7AN1SEjTUY8xUJ/fP18c=;
 b=I7Qzjdexgv8tF8xXo1dWwk3uWfv88lq1Gm0wo1HpQVeJ3VrH0fTlkelrqVe/YorqWU
 Hb/eGMvrRATlv88kS2mHU7v/n8zpgJtL6ldxRKlBvkfEWEdSVuhPVjRbCxKY1PZIkHtc
 QQXcUKqU4Se9/z2pXNZtRCYrzsChis4R0waszzum0VsNCa3NlUD6QnNmeQ93227Q+eW/
 cEVBq0ba9Dt76XUTev4BYkA/B9Ix/m7/oWhgwRcAE2Y22tdwuF4dk3+F6MaB5p8AQ8j2
 3+yyjVGSjru8vBFiaK6rvWWM4A0DE4E1smJ8IZriHe7n5cGG8iGW70GkOX34pxKUYkze
 QH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693339967; x=1693944767;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZkHtxYxtgz/j5KBlg8wbBUi7AN1SEjTUY8xUJ/fP18c=;
 b=DWx5DLXysxc37vCDGlPtgkyK82o1TeSfCAQocgla+Vg28EaMBPImRiQvAro7FPbUGY
 9HRed0rNUfpDeXgNc05ng85hawaCNifuJZJ1sbxHp12NfADQPWuRlz/IYH5aNR/G1C9s
 28NZhB+LJCf07BojQ1qgpjWPJDZg4j/ck/HtFrHC05S9fp+1L7CY+otAzMHWyI2GYfdS
 4Dci1XJjjCMwSgDD3IMPanlQpJ4nco4gaX+fVWhOhq/HjMYlUfIHWnt0n+v4aF+1Gxp6
 0vrY3m8ykg6amg9DdpW1f5zmpsKH8TdwVxiBwjKmnU0ZUIdZr7yVQ2bYfHYXs8MrJWK+
 PxEA==
X-Gm-Message-State: AOJu0YwCwRLFIOxL7LKaWQQfCAbFvk78503ts7k4TIR312n13SbFT6CJ
 aYMELoitcOTRFV3Oaj3ou9rMvg==
X-Google-Smtp-Source: AGHT+IEGZ/iDRUc9+/NhBi4cFO3Ypvit4umusnSzvMbv+ayoIw5eVCIaS4y94v4MMgrvbEU/17NhIQ==
X-Received: by 2002:a05:6808:b18:b0:3a7:4cf6:f0cb with SMTP id
 s24-20020a0568080b1800b003a74cf6f0cbmr183354oij.21.1693339967636; 
 Tue, 29 Aug 2023 13:12:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y17-20020aa78051000000b0064d74808738sm8829804pfm.214.2023.08.29.13.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:12:47 -0700 (PDT)
Message-ID: <20923e4e-23b3-4d80-f890-0ec7ce24b257@linaro.org>
Date: Tue, 29 Aug 2023 13:12:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 20/32] bsd-user: Add freebsd/os-proc.c to meson.build
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-21-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-21-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/27/23 08:57, Karim Taha wrote:
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
> index f87c788e84..d169e31235 100644
> --- a/bsd-user/freebsd/meson.build
> +++ b/bsd-user/freebsd/meson.build
> @@ -1,4 +1,5 @@
>   bsd_user_ss.add(files(
> +  'os-proc.c',
>     'os-sys.c',
>     'os-syscall.c',
>   ))

This won't build -- won't configure -- without the file being present.
Just merge into the next patch.


r~

