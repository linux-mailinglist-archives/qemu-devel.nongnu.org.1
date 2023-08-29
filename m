Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA81A78D074
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:25:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n1-0000oH-9z; Tue, 29 Aug 2023 19:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4Dl-0003KO-8V
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:17:49 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4Di-00085y-7B
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:17:48 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-26b5e737191so2447159a91.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693336665; x=1693941465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l2kB6RN3B2cMZvIFbaaSFmexbu2C12QLRZjMSTZ3VhU=;
 b=NcDyOxx3kpr+MAKto/ADHE3bXmqYkZn1NdqRqe6Zbf3U9yKwAPI3fSn9SPnbFd1wn2
 TiZxkw19cA+ipBRd9h8A6Qe62Ndl8uJyqJQLlxBKWMUlBNZoZyhcTmJl/X/97akQFoby
 hdT5tiO0bMzGAE8hIe2Pl4FVHpLVjVA1NpwQBry/lN1aT+gHR9UyoWexAACE5IqTw4qU
 +WTDHV46556c8tMilSNCmY0zVv7BmiMoTNsz8Pj6pNwDCTHbSZ8uuD0vLwx+8XOY4q/c
 VLSQFwWnEJoIDMYla/BNUIhovKiiDElDi2u1CWsk53qnQjfWgLKoe536WVqK3vCiFTws
 KNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693336665; x=1693941465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l2kB6RN3B2cMZvIFbaaSFmexbu2C12QLRZjMSTZ3VhU=;
 b=NII3YzLGPqHd1eWEj+tuGzeuCTwzdZ1zB6yAkJzBbL0dVgZS4Mk+AY03DTMX1nqq7l
 +aPqLrQqZGvJ2uA2AQgHgh18KZtHacbI4SROhneVEp9vNudkjWX1db5AKd3TyqrM6hZ4
 IYZ/BH3n1+EQDvrHMmxWYlvyiZ4XaI1rBpfbQscG5rC+Y1BVLs1C6IeSpoWPj+8PAk7D
 NsSegdLBuiP0cGcYTNLDFG6LEioi01feH8t3+lGvvgI/deW0RmYBIiQF5HFJKLgmWViM
 GTzJK41K5YaihgEiwFqdw9XKkM7E/GenDkQCPbO3eB0pHbfb6R6MMd3YMohBHwvUcAO2
 wEaw==
X-Gm-Message-State: AOJu0YykZh46GnboSqjoOd/OMXY62KhsIT7m73ljb1RHnWzMeuxVhB2z
 SsMT/oKcu95t2mQXMfp4LpJYm+12uwDiZe2Zln8=
X-Google-Smtp-Source: AGHT+IEBw+OYqEAkcpNlup1j7n/qOO8/E7t2CRtWZc290oBBq2Cjry7TNYUyM3e/XVHBDrSgjXrlfw==
X-Received: by 2002:a17:90b:1809:b0:26b:1081:a432 with SMTP id
 lw9-20020a17090b180900b0026b1081a432mr140900pjb.30.1693336664704; 
 Tue, 29 Aug 2023 12:17:44 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a17090ab00700b0026b6d0a68c5sm610399pjq.18.2023.08.29.12.17.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:17:43 -0700 (PDT)
Message-ID: <0ba04d33-b3d9-75a4-d421-17d16fc2e2ac@linaro.org>
Date: Tue, 29 Aug 2023 12:17:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/32] bsd-user: Add bsd-proc.c to meson.build
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-7-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-7-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
> From: Warner Losh <imp@bsdimp.com>
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-proc.h  | 4 ++++
>   bsd-user/meson.build | 6 ++++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
> index a1061bffb8..048773a75d 100644
> --- a/bsd-user/bsd-proc.h
> +++ b/bsd-user/bsd-proc.h
> @@ -22,6 +22,10 @@
>   
>   #include <sys/resource.h>
>   
> +#include "qemu-bsd.h"
> +#include "gdbstub/syscalls.h"
> +#include "qemu/plugin.h"
> +
>   /* exit(2) */
>   static inline abi_long do_bsd_exit(void *cpu_env, abi_long arg1)
>   {
> diff --git a/bsd-user/meson.build b/bsd-user/meson.build
> index 5243122fc5..b97fce1472 100644
> --- a/bsd-user/meson.build
> +++ b/bsd-user/meson.build
> @@ -7,6 +7,7 @@ bsd_user_ss = ss.source_set()
>   common_user_inc += include_directories('include')
>   
>   bsd_user_ss.add(files(
> +  'bsd-proc.c',
>     'bsdload.c',
>     'elfload.c',
>     'main.c',
> @@ -16,6 +17,11 @@ bsd_user_ss.add(files(
>     'uaccess.c',
>   ))

Ok so far.

>   
> +elf = cc.find_library('elf', required: true)
> +procstat = cc.find_library('procstat', required: true)
> +kvm = cc.find_library('kvm', required: true)
> +bsd_user_ss.add(elf, procstat, kvm)

What are these for?  Particularly kvm?


r~

