Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A0F7F1499
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 14:47:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r54cp-0002op-VU; Mon, 20 Nov 2023 08:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r54cj-0002j2-Rw
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 08:47:39 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r54cg-0002WM-MH
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 08:47:37 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ccbb7f79cdso31639035ad.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 05:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700488053; x=1701092853;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G1YPkG7cgUJJOPXY+RV8P3M6wJ2yAnoImOMdmRAaSXw=;
 b=NuNBKH7E9Br3BOSlBcWM+s9f/S88pR/S59KkW+cQfSbxMWL8GFaGzhTG0fZ5RinPCu
 d7W7xjcaQKgLpixaYdBwSUlKMkRn89nD6XddXZFs26F/Eg4rlKKmiZt064jwVgcd/peo
 aQVQOAYsHUbyIb1Z6+uD0zDV2TYarVK1jMFNeD8GLbAVHTPyTHMDUQnXGXrlNlw0Q2+E
 qclt5OD9EPVtmN2n3ZeY46otma7DTuCp5dXq6wijdTCk5frE2rrzrSFve/fV91WPLwVm
 u1auDjDSVDu85GKCZyeFdOM6FuoAwmGBCFn1/P5+sZrPXT09PSRQf+KuCegT/mhnEKvd
 wchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700488053; x=1701092853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G1YPkG7cgUJJOPXY+RV8P3M6wJ2yAnoImOMdmRAaSXw=;
 b=OaicknPjMQI3H4c4gUtb/WdbriqYgYrIV50FuouKvK9alfNad5KGdLBDX1J/FLsPjv
 4JVG8IeMDZn9YBAJgJuIGAfuEkwNCazK29p7m+oVxuIWXMI5+B79o/DR7xunA49czdIm
 NprBBI0gfdonDWt0nwyTkxSgQ4hVUccTMe3jXrwiK56ur5qDnvU5KySF5w+0L4+Zk2zH
 i8j27vYZK7cwN4oj7yPHgTmYA4BIGKhD/bAFPFz9wmeYCp3bCop2dNKbwdzxp2eCwARs
 ecO0Bfv8pQKpBZ1zkYbXTmqGHDXLadUS87kS+9ho4QKe8uJypcD0JPfk5z99+e2yLXvb
 to9A==
X-Gm-Message-State: AOJu0YxXRzl2OC70FTrT8hglWmWo70PJeTC81+YaTtFoAp/KWzQ2nFWn
 lKgfL9TXCq55Op2XszJnk4L0SQ==
X-Google-Smtp-Source: AGHT+IEncEJRtxxavUdXMdgLIOPlCvwEhxPbYDegme5Yxlj1ytVO/v1rMhV85lVqoHJNX5zcCOnLXQ==
X-Received: by 2002:a17:902:d4c9:b0:1c6:21b4:30bb with SMTP id
 o9-20020a170902d4c900b001c621b430bbmr7047592plg.15.1700488053264; 
 Mon, 20 Nov 2023 05:47:33 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a170902ecd200b001cc2c7a30f2sm6099378plh.155.2023.11.20.05.47.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 05:47:32 -0800 (PST)
Message-ID: <2859b544-ab81-411a-b074-c6fcf0102730@daynix.com>
Date: Mon, 20 Nov 2023 22:47:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC-PATCH-for-8.2?] disas/cris: Pass buffer size to format_dec()
 to avoid overflow warning
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>
References: <20231120132222.82138-1-philmd@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231120132222.82138-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/11/20 22:22, Philippe Mathieu-Daudé wrote:
> Propagate the buffer size to format_dec() and use snprintf().
> 
> This should silence this UBSan -Wformat-overflow warning:
> 
>    In file included from /usr/include/stdio.h:906,
>                     from include/qemu/osdep.h:114,
>                     from ../disas/cris.c:21:
>    In function 'sprintf',
>        inlined from 'format_dec' at ../disas/cris.c:1737:3,
>        inlined from 'print_with_operands' at ../disas/cris.c:2477:12,
>        inlined from 'print_insn_cris_generic.constprop' at ../disas/cris.c:2690:8:
>    /usr/include/bits/stdio2.h:30:10: warning: null destination pointer [-Wformat-overflow=]
>     30 |   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     31 |                                   __glibc_objsize (__s), __fmt,
>        |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     32 |                                   __va_arg_pack ());
>        |                                   ~~~~~~~~~~~~~~~~~
> 
> Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> TODO: add compiler version

My compiler is GCC 12.1.0, and I confirmed this change suppresses the 
warnings.

> 
> Surgical alternative to this patch from Akihiko:
> https://lore.kernel.org/all/20231120112329.4149-1-akihiko.odaki@daynix.com/
> ---
>   disas/cris.c | 47 ++++++++++++++++++++++++++++++++---------------
>   1 file changed, 32 insertions(+), 15 deletions(-)
> 
> diff --git a/disas/cris.c b/disas/cris.c
> index 0b0a3fb916..74a487c733 100644
> --- a/disas/cris.c
> +++ b/disas/cris.c
> @@ -1731,10 +1731,10 @@ format_hex (unsigned long number,
>      unsigned (== 0).  */
>   
>   static char *
> -format_dec (long number, char *outbuffer, int signedp)
> +format_dec(long number, char *outbuffer, size_t outsize, int signedp)
>   {
>     last_immediate = number;
> -  sprintf (outbuffer, signedp ? "%ld" : "%lu", number);
> +  snprintf(outbuffer, outsize, signedp ? "%ld" : "%lu", number);
>   
>     return outbuffer + strlen (outbuffer);
>   }
> @@ -1898,6 +1898,7 @@ print_with_operands (const struct cris_opcode *opcodep,
>        intermediate parts of the insn.  */
>     char temp[sizeof (".d [$r13=$r12-2147483648],$r10") * 2];
>     char *tp = temp;
> +  ptrdiff_t tp_avail;
>     static const char mode_char[] = "bwd?";
>     const char *s;
>     const char *cs;
> @@ -2102,12 +2103,13 @@ print_with_operands (const struct cris_opcode *opcodep,
>   		number = 42;
>   	      }
>   
> -	    if ((*cs == 'z' && (insn & 0x20))
> -		|| (opcodep->match == BDAP_QUICK_OPCODE
> -		    && (nbytes <= 2 || buffer[1 + nbytes] == 0)))
> -	      tp = format_dec (number, tp, signedp);
> -	    else
> -	      {
> +        if ((*cs == 'z' && (insn & 0x20))
> +            || (opcodep->match == BDAP_QUICK_OPCODE
> +            && (nbytes <= 2 || buffer[1 + nbytes] == 0))) {
> +            tp_avail = temp - tp;

I think this should be: temp + sizeof(temp) - tp

