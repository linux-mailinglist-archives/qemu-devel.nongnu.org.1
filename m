Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 678F47BD80F
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:07:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpn9v-0000PR-FX; Mon, 09 Oct 2023 06:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn9o-000069-HC
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:06:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn9l-0000oS-DF
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:06:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4053c6f0db8so39683695e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 03:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696845990; x=1697450790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ldXvejHUlq8lXngd2UJIF9wWYF6PyGVBw2D7jCD/ui8=;
 b=kibaBU+2QWeDMseYFjl3AFhAuBpKE+4CxvPdJh1pHgw2YZz6DJViKTEM3/Yq7RUaWR
 YvG6skASLfl2ZXyjBwcRnGedieIwaY8ilCMEMLwWe2+hH96yccILfUGQZSnKjN84zA2q
 vS/OWyeSNMvs0fwcAqGcota1Kj+vV7SH+ZF+7Ojxxm/2ZMcQ16nqhNCETZder6s3bAkv
 Ul0saaPrRmOWi4rGvk+bJYSk6K2hN/kE4d6Zkk38Yn+7bCLBExxgBHRE+TQ1tW0eKTm2
 BYUBlrLVsCw/l2Pv08/PbObdYkvqZXZnTWL4/It0UKEzo4MLmUdLllbZEC7Ie3rjjLMS
 u9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845990; x=1697450790;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ldXvejHUlq8lXngd2UJIF9wWYF6PyGVBw2D7jCD/ui8=;
 b=Qg5gLm5qMs0q6GaUHTSLPNR9GjJr/acLU0J6x9j3XBanLSOuzqFvQ/nt4RGSTp1s3z
 /0ndCNRzYG6m5XBue8MumxwYeKZYTMegw5Y3vF9GGAoDARQ4EUMkBz1y1+aV/cu48ZPE
 sqDCM3+bNn9wJHl2GbIp74j32rCXYPiet2xmRieUHkQ+39+beGVX8/zYVC8nxj0FUOnG
 y4fiMT448I4wbpDIMiW7ThW+AhPo3QX4SZjKCU5BB8/j8yf7EIxRqr8Q6HWhVt558yVa
 UFDArLJ/6iwJyiCaAcx6SRxpsO6TxeLPkSUjPpaLGJbK63q/sA/RunCnpHp11i4Vxbso
 jRug==
X-Gm-Message-State: AOJu0YwWXyDVnI5oMJidudHB25hAR9SIm/NE0zATqp8eQWe38av8Jl0J
 WuGC2aCKlsc1gjuGSaWDCx7s6nVnWsizUJqyzIU=
X-Google-Smtp-Source: AGHT+IHvsI0wEMbwLv81/n6izWw3s/xvix1IybAFlS1yewfbVNaVLL+tK8Gb2rID88IShYhkbnat+A==
X-Received: by 2002:a5d:6e8e:0:b0:321:68fa:70aa with SMTP id
 k14-20020a5d6e8e000000b0032168fa70aamr12650554wrz.9.1696845990490; 
 Mon, 09 Oct 2023 03:06:30 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a5d538c000000b0032769103ae9sm9142034wrv.69.2023.10.09.03.06.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 03:06:30 -0700 (PDT)
Message-ID: <2db281e4-ae4a-e7b8-48a7-17c12cbba43c@linaro.org>
Date: Mon, 9 Oct 2023 12:06:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 05/10] tests/hd-geo-test: Clean up global variable
 shadowing
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Hao Wu <wuhaotsh@google.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Tyrone Ting <kfting@nuvoton.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20231009100251.56019-1-philmd@linaro.org>
 <20231009100251.56019-6-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231009100251.56019-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.818,
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

On 9/10/23 12:02, Philippe Mathieu-Daudé wrote:
> Rename the variable to fix:
> 
>    tests/qtest/hd-geo-test.c:610:11: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>        char *img_file_name;
>              ^
>    tests/qtest/hd-geo-test.c:80:14: note: previous declaration is here
>    static char *img_file_name[backend_last];
>                 ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/hd-geo-test.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
> index d08bffad91..e5e28c412d 100644
> --- a/tests/qtest/hd-geo-test.c
> +++ b/tests/qtest/hd-geo-test.c
> @@ -78,6 +78,7 @@ static const CHST hd_chst[backend_last][mbr_last] = {
>   };
>   
>   static char *img_file_name[backend_last];
> +static char *qcow2_imgpath;
>   
>   static const CHST *cur_ide[4];
>   
> @@ -607,18 +608,17 @@ static TestArgs *create_args(void)
>   static void add_drive_with_mbr(TestArgs *args,
>                                  MBRpartitions mbr, uint64_t sectors)
>   {
> -    char *img_file_name;
>       char part[300];
>       int ret;
>   
>       g_assert(args->n_drives < MAX_DRIVES);
>   
> -    img_file_name = create_qcow2_with_mbr(mbr, sectors);
> +    qcow2_imgpath = create_qcow2_with_mbr(mbr, sectors);
>   
> -    args->drives[args->n_drives] = img_file_name;
> +    args->drives[args->n_drives] = qcow2_imgpath;
>       ret = snprintf(part, sizeof(part),
>                      "-drive file=%s,if=none,format=qcow2,id=disk%d",
> -                   img_file_name, args->n_drives);
> +                   qcow2_imgpath, args->n_drives);
>       g_assert((0 < ret) && (ret <= sizeof(part)));
>       args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
>       args->n_drives++;
> @@ -1139,6 +1139,10 @@ test_add_done:
>               g_free(img_file_name[i]);
>           }
>       }
> +    if (qcow2_imgpath) {
> +        unlink(qcow2_imgpath);
> +        g_free(qcow2_imgpath);

Oops I squashed this part while rebasing, this was supposed to
be a different patch.

> +    }
>   
>       return ret;
>   }


