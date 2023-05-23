Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 236D770D716
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 10:18:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1NCq-0001pR-GL; Tue, 23 May 2023 04:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1NCo-0001nz-Vm
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:17:18 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1NCn-00054V-2R
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:17:18 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-307d20548adso4493871f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 01:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684829835; x=1687421835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wOg/ElcURmgDjsZY9jcV4KohG5mmMl8xig9nVa8Ef+c=;
 b=WxlpC3DOOxmyrTKM5LLaQQq5oZihx9HzRY8EGWuTtLHKytE0LiWEp2aClJ2XRmoHt4
 +u7VVu4ce55pZVsH0X2vDVHs5DM1Qk3MJLi2O0BAWXtgQ3468u7z1733jEet8RfD7hx/
 g1YpKrHVwPrmCgv1vDGUkEDaXxOUFf265MkbcPN+Zi89Ma6OoTDfRl7zcqW6Zi6qVgGM
 gQcaiCrexorkyTRbeREriT0A2vfC3mjqbMvygtf9iGhhHFrkvSIjEM99EaCkQ1OC6gpj
 /YjD1MpLiF4Yjk3TT851KT82ezAcISttcT/5Fmil7mlnyEVOL8dvnEqm0jEY5YhjMbUq
 Dv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684829835; x=1687421835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wOg/ElcURmgDjsZY9jcV4KohG5mmMl8xig9nVa8Ef+c=;
 b=BmM1OT1hxHvaqVes5Qha0hVewZzWTTCh8Ekb0co85+pLtPf3u79poT4sA2IXTBVsjx
 H8Kcey00P+I8iU0timE7mAcqgT4pXOdpu1WfnAAB2LjjIJpwGduuZurKsQfNH8TT6KvM
 FQntotNybaM8z/EtaXCZu1jA8Ax5dDYpMjavcPqlUhA5qa4d/NmFlgpbotG1PBy2jlf3
 aPU3Fnb/7J2NfCKvDg8jSW6g6JAMbHs2c3kZlEQDBmYH8Uv8MuEnz0dd5LEklbZfUXSd
 FXH0Il5F6JBsyuFpO7xqPfUFD1n+LWza/vbE2n6P/qL4rWCKTaO+z4rUB/h1jaA6lkJR
 0y0A==
X-Gm-Message-State: AC+VfDzzzL/ieihBovZUClIOkhBDy9zCwZfJ97S0Kc+fdv8rjVJQ7iA2
 x532UPSMprQyOkH/vWWKQQ8I4Q==
X-Google-Smtp-Source: ACHHUZ6758k9u2YBeQGtPjxrLtID+09Cbo03iV1sQek63dOIp6f4a3PhyY1e87o4ZlZzta26WzaPiA==
X-Received: by 2002:a5d:4210:0:b0:306:5149:3aa8 with SMTP id
 n16-20020a5d4210000000b0030651493aa8mr8634358wrq.24.1684829835416; 
 Tue, 23 May 2023 01:17:15 -0700 (PDT)
Received: from [192.168.69.115] (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr.
 [176.184.48.94]) by smtp.gmail.com with ESMTPSA id
 n6-20020a7bcbc6000000b003f42d8dd7ffsm10742432wmi.19.2023.05.23.01.17.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 01:17:15 -0700 (PDT)
Message-ID: <324353de-39e9-c7e1-953b-44f97f86c1f6@linaro.org>
Date: Tue, 23 May 2023 10:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2] meson: move -no-pie from linker to compiler
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, vr_qemu@t-online.de,
 richard.henderson@linaro.org
References: <20230523073029.19549-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523073029.19549-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 23/5/23 09:30, Paolo Bonzini wrote:
> The large comment in the patch says it all; the -no-pie flag is broken and
> this is why it was not included in QEMU_LDFLAGS before commit a988b4c5614
> ("build: move remaining compiler flag tests to meson", 2023-05-18).  And
> some distros made things even worse, so we have to add it to the compiler
> command line.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1664
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 0a5cdefd4d3d..20accae99281 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -265,12 +265,21 @@ endif
>   
>   # Meson currently only handles pie as a boolean for now, so if the user
>   # has explicitly disabled PIE we need to extend our cflags.
> +#
> +# -no-pie is supposedly a linker flag that has no effect on the compiler
> +# command line, but some distros, that didn't quite know what they were
> +# doing, made local changes to gcc's specs file that turned it into
> +# a compiler command-line flag.
> +#
> +# What about linker flags?  For a static build, no PIE is implied by -static
> +# which we added above (and if it's not because of the same specs patching,
> +# there's nothing we can do: compilation will fail, report a bug to your
> +# distro and do not use --disable-pie in the meanwhile).  For dynamic linking,
> +# instead, we can't add -no-pie because it overrides -shared: the linker then
> +# tries to build an executable instead of a shared library and fails.  So
> +# don't add -no-pie anywhere and cross fingers. :(
>   if not get_option('b_pie')
> -  qemu_common_flags += cc.get_supported_arguments('-fno-pie')
> -  if not get_option('prefer_static')
> -    # No PIE is implied by -static which we added above.
> -    qemu_ldflags += cc.get_supported_link_arguments('-no-pie')
> -  endif
> +  qemu_common_flags += cc.get_supported_arguments('-fno-pie', '-no-pie')
>   endif

This removes this annoying warning with Clang on Darwin/Aarch64:

clang: warning: argument unused during compilation: '-no-pie' 
[-Wunused-command-line-argument]

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


