Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B6570A54F
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 06:23:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0E6K-0002y0-2f; Sat, 20 May 2023 00:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0E6I-0002xb-5s
 for qemu-devel@nongnu.org; Sat, 20 May 2023 00:21:50 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0E6G-0003ln-JW
 for qemu-devel@nongnu.org; Sat, 20 May 2023 00:21:49 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-309d3e8777cso197071f8f.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 21:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684556507; x=1687148507;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9L++UuYY0EHz3yiv5WPTM6cAEkrR/f/dIGRBMDbQPJ0=;
 b=MgUHVozj2HliXcmx47Bw9aO6dQMuf1CdJ27HE2wCF3rO4qOAQmU/vkzzu0w2pYgDX9
 qhvjTfcaXinlWEMG3nOPGYlC2eZcQanBeAWvIV/RebOKJGkeE3Rpk1O5fTo1IP7mIwQC
 +rj2sx/j2yKfqS73kcFLFyICKV+/96yOowpaub+LXsGkDUG3c45VboCu4kkUn5HttSlY
 08oN/HM3tDSByoj7oxr7A7FQ+bRdHLL2aBhA90B77OIV2EliyE7fmqxd9tuJgR98ECIf
 /OJiY6Jcr1QTkrEl4cSGo+IaxRMlnp5OTlKgf/Jo94IbToukkNnVwizFhDUuBKCE7T9t
 qubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684556507; x=1687148507;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9L++UuYY0EHz3yiv5WPTM6cAEkrR/f/dIGRBMDbQPJ0=;
 b=eK+K3lE7/3ihxMgGFB6fIILdLycEG/5l5WVYc3hz19KfEWmtXQkCXqpA/BNOwq4v8o
 1TRAlF9j/6FXB2JUZWwcXchp35bfBUtgmd+nGz4dOzJJcwsfHx+Jama6XdwTxza+b6ul
 +loipneQcFyGvcpLerGkNjEghhzYqxA8fIlgwRZ9yWr1pkpVKui5xATVYB/IIYEq4X4x
 vW8BARaFrZTQSCgzhqMYBIDucFJFdYEbNwHp8oulYwUUYqq+p3yFLHjrS5kcX88lX9vR
 n5Fd7t7rde7vQ3Kwkc1XzJA22S6VrIpdz6xjL//mdjzqUVehgoeMDiiZsmSx34z6CLHF
 zGsA==
X-Gm-Message-State: AC+VfDyu+i6yg6KzkJwLQFWzF66vhyL2UfuOcQoiA2PplGBw6NqeMoUs
 gCMooWvvEqDL0hDI4zGd19wjRg==
X-Google-Smtp-Source: ACHHUZ7d+24cJuxOFc7Ji5UC8rjIJbY6foTS2BZ9yiP3evsOuGWp9Lff+ac9OGyUAWFvktlQfUWauQ==
X-Received: by 2002:adf:f64f:0:b0:2f8:33bd:a170 with SMTP id
 x15-20020adff64f000000b002f833bda170mr5907688wrp.32.1684556506756; 
 Fri, 19 May 2023 21:21:46 -0700 (PDT)
Received: from [192.168.69.115] (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr.
 [176.184.41.228]) by smtp.gmail.com with ESMTPSA id
 z14-20020a7bc7ce000000b003f4b6bcbd8bsm956536wmk.31.2023.05.19.21.21.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 21:21:46 -0700 (PDT)
Message-ID: <381a8c29-66ae-c998-6d18-0fdff7995139@linaro.org>
Date: Sat, 20 May 2023 06:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 2/8] plugins: fix memory leak while parsing options
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>
Cc: Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20230519170454.2353945-1-alex.bennee@linaro.org>
 <20230519170454.2353945-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230519170454.2353945-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
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

On 19/5/23 19:04, Alex Bennée wrote:
> It was hard to track down this leak as it was an internal allocation
> by glib and the backtraces did not give much away. The autofree was
> freeing the allocation with g_free() but not taking care of the
> individual strings. They should have been freed with g_strfreev()
> instead.
> 
> Searching the glib source code for the correct string free function
> led to:
> 
>    G_DEFINE_AUTO_CLEANUP_FREE_FUNC(GStrv, g_strfreev, NULL)
> 
> and indeed if you read to the bottom of the documentation page you
> will find:
> 
>    typedef gchar** GStrv;
> 
>    A typedef alias for gchar**. This is mostly useful when used together with g_auto().

So possibly glib could improve by declaring g_strsplit()
(and co) returning a GStrv instead of a gchar** type?

> So fix up all the g_autofree g_strsplit case that smugly thought they
> had de-allocation covered.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   contrib/plugins/cache.c     | 2 +-
>   contrib/plugins/drcov.c     | 2 +-
>   contrib/plugins/execlog.c   | 2 +-
>   contrib/plugins/hotblocks.c | 2 +-
>   contrib/plugins/hotpages.c  | 2 +-
>   contrib/plugins/howvec.c    | 2 +-
>   contrib/plugins/hwprofile.c | 2 +-
>   contrib/plugins/lockstep.c  | 2 +-
>   tests/plugin/bb.c           | 2 +-
>   tests/plugin/insn.c         | 2 +-
>   tests/plugin/mem.c          | 2 +-
>   tests/plugin/syscall.c      | 2 +-
>   12 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
> index 2e25184a7f..5036213f1b 100644
> --- a/contrib/plugins/cache.c
> +++ b/contrib/plugins/cache.c
> @@ -772,7 +772,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
>   
>       for (i = 0; i < argc; i++) {
>           char *opt = argv[i];
> -        g_autofree char **tokens = g_strsplit(opt, "=", 2);
> +        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

