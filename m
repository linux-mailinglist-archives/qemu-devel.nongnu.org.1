Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 479EB7F142C
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 14:18:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5496-0004al-Pt; Mon, 20 Nov 2023 08:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r548d-0004VT-LL
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 08:16:37 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r548b-0007AV-Ee
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 08:16:31 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9e28724ac88so594928666b.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 05:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700486188; x=1701090988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9dPUl4ao4kYTTsm3z2dXW5oo/5D8kX3qYthgRRF855U=;
 b=SXXDmK6kl4ys0Fx21KTKbXmjE86QUxPxv1m9L2cHth3B4H1+5K9WYR9j5Y8etXC8x6
 xtUFXUDQuIFdlXb1sHwX5lirdDK9nWwYVn+00PMf6F7wvl+Dl/LgGBwAYid8CjCs7Ne5
 wg+WZWk+0uH7pBxCfRdON8qKgXWeo9oG4E3z29667pJ0FlGbYwEtXr/BSPBy7K304TwI
 f8jEtzD7WvIj8Q8uO2Nr98aAM5CRuChNLDCHURC57aZmb7dlrpytJoHrOBxtU6DVin+e
 XlMmAsEPTxIC5uns86tfTnU2fSCj6KzGU0ZktMQAxyzhowt+/elI5sZ64mHkpReLev7W
 mt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700486188; x=1701090988;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9dPUl4ao4kYTTsm3z2dXW5oo/5D8kX3qYthgRRF855U=;
 b=knRjh37jVFfIDK06Jj0bkbPLCqNF07IKJqFiFyLKtsuET1O3A/mY0vhrdVJ7ORstnE
 nE+VsJF5721LW5TLoaLBiwKYTDjqWg10ZBn7iM/wF4FmSlG5B0losaHlh1wLP2TjuoCp
 rf/RiYYl5DfIM8TNzaWpjA4BcMXDNIMLiw/eARKseqLr08SOmu7XcHHfgJ9ygdbIIvPS
 r1OxCWlItCb+JNSIFUWKeZ9wzHuXjo1+Nreu43EviZuBebviBcWY+M7Uy3YXs1F8/ru3
 YHa2yQc1G+mpqKqnL3DeCitRxRc/b309rPV+8UgEUK5O/sUGvssNyq9qExwFMgKexBsV
 X6oA==
X-Gm-Message-State: AOJu0YzpHD9M1HPo6LaIF6KNSUy7sjBSkqsC/Q4HnlSZbo8sW7pQOUPe
 fJR+KgbQ/F2EpdC7YEq0FKgyfw==
X-Google-Smtp-Source: AGHT+IFFTa1cMHxzGymVvKJiLs7+3tcPtb2rk/41m3rckg1YNX2gEhpS30pqidpyVE+VPxf8i1VxRg==
X-Received: by 2002:a17:907:ea5:b0:9e3:fab3:3f4d with SMTP id
 ho37-20020a1709070ea500b009e3fab33f4dmr7225555ejc.59.1700486187741; 
 Mon, 20 Nov 2023 05:16:27 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a1709063b9300b009e5db336137sm3878708ejf.196.2023.11.20.05.16.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 05:16:26 -0800 (PST)
Message-ID: <f9aff170-5ec8-4bfb-a100-3d312baedbef@linaro.org>
Date: Mon, 20 Nov 2023 14:16:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: -Wno-error=format-overflow for ubsan
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20231120112329.4149-1-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231120112329.4149-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Hi Akihiko,

On 20/11/23 12:23, Akihiko Odaki wrote:
> ubsan causes wrong -Wformat-overflow warnings as follows:
> 
> In file included from /usr/include/stdio.h:906,
>                   from /home/alarm/q/var/qemu/include/qemu/osdep.h:114,
>                   from ../disas/cris.c:21:
> In function 'sprintf',
>      inlined from 'format_dec' at ../disas/cris.c:1737:3,
>      inlined from 'print_with_operands' at ../disas/cris.c:2477:12,
>      inlined from 'print_insn_cris_generic.constprop' at ../disas/cris.c:2690:8:
> /usr/include/bits/stdio2.h:30:10: warning: null destination pointer [-Wformat-overflow=]
>     30 |   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     31 |                                   __glibc_objsize (__s), __fmt,
>        |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     32 |                                   __va_arg_pack ());
>        |                                   ~~~~~~~~~~~~~~~~~
> 
> Don't let these errors stop the build.

Which compiler/version?

> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   meson.build | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index d7d841e71e..02f1a18080 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -365,7 +365,9 @@ if get_option('sanitizers')
>     # Detect static linking issue with ubsan - https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84285
>     if cc.links('int main(int argc, char **argv) { return argc + 1; }',
>                 args: [qemu_ldflags, '-fsanitize=undefined'])
> -    qemu_cflags = ['-fsanitize=undefined'] + qemu_cflags
> +    # 87884 – ubsan causes wrong -Wformat-overflow warning
> +    # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87884
> +    qemu_cflags = ['-fsanitize=undefined', '-Wno-error=format-overflow'] + qemu_cflags
>       qemu_ldflags = ['-fsanitize=undefined'] + qemu_ldflags
>     endif
>   endif


