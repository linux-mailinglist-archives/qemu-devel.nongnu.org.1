Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1FC70B77C
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 10:21:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q10la-0006hj-J5; Mon, 22 May 2023 04:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q10lX-0006hL-W6
 for qemu-devel@nongnu.org; Mon, 22 May 2023 04:19:40 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q10lW-0002Vh-16
 for qemu-devel@nongnu.org; Mon, 22 May 2023 04:19:39 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-307d20548adso3581581f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 01:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684743576; x=1687335576;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1rYTZnXWrUsx4Cdvhy/O68pPzO71pW+JO0C28PVr/nE=;
 b=wNaBggAHhwep8YDAzD8aiiVU3QgTgsv9JXBJa9Mhlp71UmdN3wka9u7qr7bCbJG+1Y
 aVp9llvMK3otA0rZv852QQqW04TB/FFmm1gPNstP/nF8fFJos/wNeOI45LUPf62Lwjqs
 sx8h9adGB/0sJPiSsCzc/BzAPFV2AKLsu7vsJty8MEn0W9043TqojWTVs85Ts5M7zfES
 CijEz77y6VXaMUkAtg9kStd7G8zT/lSdjDUY1IQ+rvSdQM1wTAjyGhL6Z5j56mx1QP1m
 iT55tBs9y+VYPzM9xDeGP38Ha50lZZFXu7uBaBsPnNYuuINtHHg7OkMdVmrT4HAfimJg
 HUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684743576; x=1687335576;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1rYTZnXWrUsx4Cdvhy/O68pPzO71pW+JO0C28PVr/nE=;
 b=gLOEuuQsmTDsm8ri4bqkw+a5NU93RS9wHS0CitgGrnmQT4NLJT0YwoOOQnNv39zENv
 osEzI4lpgLOMvyFOhzGrwcJ5RqsQWJA4d98w1f1KZaOrqrUzMi9CuLjGJy7SsyrIbdSN
 ID3Mq0p0aucdU8FCSxl1BPEgclhNppClnX7UfWUaYysSQffg1e6GzlKf4kK+Ndt3JHVq
 bxiJk1EDKKacyXmGX/Vy2bKE4fsRTbj2mz+qniyjFduC5m0OkextaykHjQdLdaAOnP5+
 8XyKzbwl6eawVS/PFsw4McHAQwso/7Pzr5jlZbK4gWaXnXImjkaikFvuP7g4kftEoJU1
 njyg==
X-Gm-Message-State: AC+VfDwEZBm5p7wXDIqLSPMxfaaLxxwhrRJy6iY+rDUjj7yaXMT19n7e
 sXaLQ5bOLz9Bvi9KtKPd1JcVDQ==
X-Google-Smtp-Source: ACHHUZ5nIuJPkX3KjsJfD5RpXCnLoa/tduHyOPaLc9UnI2PjKh7cR+jNPliD5YJZMnptBt/ql6hn0w==
X-Received: by 2002:adf:e4c5:0:b0:305:e8db:37df with SMTP id
 v5-20020adfe4c5000000b00305e8db37dfmr6998330wrm.22.1684743576300; 
 Mon, 22 May 2023 01:19:36 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 i10-20020adfe48a000000b002fed865c55esm6865806wrm.56.2023.05.22.01.19.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 01:19:35 -0700 (PDT)
Message-ID: <bb3bb561-310c-8d9c-fc3f-99048d2bc3f9@linaro.org>
Date: Mon, 22 May 2023 10:19:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] meson: remove -no-pie linker flag
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: vr_qemu@t-online.de, marcandre.lureau@redhat.com
References: <20230522080816.66320-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230522080816.66320-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 22/5/23 10:08, Paolo Bonzini wrote:
> The large comment in the patch says it all; the -no-pie flag is broken and
> this is why it was not included in QEMU_LDFLAGS before commit a988b4c5614
> ("build: move remaining compiler flag tests to meson", 2023-05-18).
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1664
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 0a5cdefd4d3d..6733b2917081 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -267,10 +267,15 @@ endif
>   # has explicitly disabled PIE we need to extend our cflags.
>   if not get_option('b_pie')
>     qemu_common_flags += cc.get_supported_arguments('-fno-pie')
> -  if not get_option('prefer_static')
> -    # No PIE is implied by -static which we added above.
> -    qemu_ldflags += cc.get_supported_link_arguments('-no-pie')
> -  endif
> +  # What about linker flags?  For a static build, no PIE is implied by -static
> +  # which we added above.  For dynamic linking, adding -no-pie is messy because
> +  # it overrides -shared: the linker then wants to build an executable instead
> +  # of a shared library and the build fails.  Before moving this code to Meson,
> +  # we went through a dozen different commits affecting the usage of -no-pie,
> +  # ultimately settling for a completely broken one that added -no-pie to the
> +  # compiler flags together with -fno-pie... except that -no-pie is a linker
> +  # flag that has no effect on the compiler command line.  So, don't add
> +  # -no-pie anywhere and cross fingers.
>   endif
>   
>   if not get_option('stack_protector').disabled()

This removes this annoying warning with Clang on Aarch64:

clang: warning: argument unused during compilation: '-no-pie' 
[-Wunused-command-line-argument]

Not tested on mingw64, but at least on Darwin:

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


