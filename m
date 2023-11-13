Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DDD7E9AA1
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 12:05:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2UjW-00047J-4U; Mon, 13 Nov 2023 06:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2UjU-00046j-Am
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:03:56 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2UjS-0000ep-Mu
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:03:56 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9e2838bcb5eso631366866b.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 03:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699873433; x=1700478233; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QKp+xYb/ek79oav1SQxQszAVvb+w9y9wc6rs4s4TIV0=;
 b=rK9P8se6NJRjGlnL1Y0A0tX3ewC0sLtg2HPjDsXOhvwm8jo2rDXSUvZujcxLYi/0mH
 QLvh44a5eKwv7BTH686gRa+/Qa2/VypUQh0wK8N35CfPbobzvuScdKfCsbxiTO5dNKay
 Rbmy6WHhyP2t14zTi3mwBhr8AHz14sXX7GHxi7MIRCHiXzViy5F1yXvgu0+2WLN8OGfs
 jlk9/8nI7xQ5mKsfyl54vnA8I4zbzs0RK4oMx0BoBHJa/0lp4IQ2y/0NJCcB9FhAIWgd
 9ppAhfpBKCBFWXMW+QwcsVXIrFr0INPQcqGg7/UJ9R4fABmuG+tS2r6eQyGjjz2tRJ6K
 VTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699873433; x=1700478233;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QKp+xYb/ek79oav1SQxQszAVvb+w9y9wc6rs4s4TIV0=;
 b=c2Zx7yUeAWONxnDJNcF6knU85ayhpm6VXMfZEcqE+9m9c7c0dqU0mg70qw/lX9UuZX
 V/4MOV8dsHOXJiFAb103+mdDfzFL0I6ovBNUl/Vml0omusT8fYkpNoHb2Zx/hqynTQK7
 QC80Y5oF/dSJlssY+0Hr5nvSDzhVkGr7E9krltUH4Sa6eYUKn4SfiLb/ZW5KdNtaBG/M
 1yPT9HAwcK8Dwtr1iBq0bgufjJwiJW88sNJUKqrvmQYe9+eIGJ1BnorYvjOg5ttChrHT
 2aQ5+TfjQfwi13Gzu9Or8khiLNWVaravzU3D5WfET1cTPmWz6ZoMtikA+TKWrvrrW5QK
 Rq2g==
X-Gm-Message-State: AOJu0YyYocpZ8haO7wLMisDPx6R4X7i2XKNo+aow9WfeQ5BZCq98vJ/d
 iAKSVp5cZSTSBVb8ze7jQCZtJw==
X-Google-Smtp-Source: AGHT+IEcpVk/ZJKH5fUHjDdlkXBWtXHg+h8SVusuB7e0Qp2gye6Uj+gs62g2kIJC5D/Yp5I7FMSxeA==
X-Received: by 2002:a17:907:20e5:b0:9e6:3570:bc0d with SMTP id
 rh5-20020a17090720e500b009e63570bc0dmr4636729ejb.59.1699873432995; 
 Mon, 13 Nov 2023 03:03:52 -0800 (PST)
Received: from [192.168.69.100] ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 dx9-20020a170906a84900b009c3828fec06sm3838073ejb.81.2023.11.13.03.03.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 03:03:52 -0800 (PST)
Message-ID: <4d71476c-7de2-4e35-bb7c-d687578ce91e@linaro.org>
Date: Mon, 13 Nov 2023 12:03:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/36] plugins: update lockstep to use g_memdup2
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Bandan Das
 <bsd@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
 <20230627160943.2956928-20-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230627160943.2956928-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Hi Alex,

On 27/6/23 18:09, Alex Bennée wrote:
> The old g_memdup is deprecated, use the replacement.
> 
> Message-Id: <20230623122100.1640995-21-alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   contrib/plugins/lockstep.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
> index e36f0b9562..3614c3564c 100644
> --- a/contrib/plugins/lockstep.c
> +++ b/contrib/plugins/lockstep.c
> @@ -130,7 +130,7 @@ static void report_divergance(ExecState *us, ExecState *them)
>           }
>       }
>       divergence_log = g_slist_prepend(divergence_log,
> -                                     g_memdup(&divrec, sizeof(divrec)));
> +                                     g_memdup2(&divrec, sizeof(divrec)));

Actually I missed g_memdup2() is GLib >= 2.68. For QEMU codebase we
define it in include/glib-compat.h, but contrib/ files don't include
that.

So on Ubuntu 20.04 LTS we get:

contrib/plugins/lockstep.c:133:38: error: implicit declaration of 
function 'g_memdup2' is invalid in C99 
[-Werror,-Wimplicit-function-declaration]
   133 |                                      g_memdup2(&divrec, 
sizeof(divrec)));
       |                                      ^~~~~~~~~
       |                                      g_memdup

>   
>       /* Output short log entry of going out of sync... */
>       if (verbose || divrec.distance == 1 || diverged) {


