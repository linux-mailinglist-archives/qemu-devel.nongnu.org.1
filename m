Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3227F2545
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 06:33:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5JNK-0002Ap-2V; Tue, 21 Nov 2023 00:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r5JNH-00029f-Mo
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 00:32:39 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r5JNF-0002Hx-Jx
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 00:32:39 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cf6bdf8274so4491795ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 21:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700544756; x=1701149556;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z8OI76ITA8B6Lo6PLCpQjx4dxD3QehPvz6jv2ndA7ZU=;
 b=nfsNMNh/Zjy8YxbR4gI3sIBAuO/yhT0Fe6iyB6XgN0P2xECwrdlcy1/1I4Z4uhFJea
 mUkT1Qv5MVuoXyFCZ01qEcIdTmzqskH4ylW13AGmPf2ApTr08KMXbSQUD10TNBuMVgCb
 PQkpOff0Yzj4dai5TGutFH4RPRKb7RVUktRn170vxQWK3oP8kpka/zcfJqZD+Q8mhLig
 KLCpuNlSKzXXpy2kcmUMXbKcqdGherbK8hQzYecBC1tePw1lKDVr6rpH+vBNxWG+nRCE
 8KGeeQ+Knc5I9/DheDBGh4vHhrIMLOUzAQq+Aq8pZsT752YX+r4FUokq7/ZE/KNTvYwa
 7W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700544756; x=1701149556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8OI76ITA8B6Lo6PLCpQjx4dxD3QehPvz6jv2ndA7ZU=;
 b=UWD6XlzhuuLWpZNaUzV/AxOou4R4q3w1yA4kSVDnturNAY4/L6R79sz/9lz1hnJsO4
 W8I96nkE8xRPWDqPkcIQ02YD1blHoredueiFdkSYJQurpqYaGVOH5EynnXtqhBr9Jxpw
 FnFyHizrmyO7swvSgIWaqYsCfi64nlNmO/1Ze9x3yMrroy7b/vMUnAneTfkCXZeW4aQS
 y7jIgEqnH0ZDFi/89FqfdrZDSuNXYsQvK6RVBVBBLEqZeK6sErIID/RT7Ir6EoXbmW5M
 sFxkfeT7f09dOU9IifsSoKs3qHTm1AN8949QBFofIgNKsv8K7+mt++2yJNm1kYVdZtDV
 1Pcw==
X-Gm-Message-State: AOJu0YyKCr9QtTo+/L+/aoL8Vzmd3bZjPAsEXK3lPt6KbZ/cObGtwBgU
 HVZB++cGnYB8itYIWkzMWt6J+Q==
X-Google-Smtp-Source: AGHT+IEmryUvx3TwB3lkdhkgO0gT0/Fl9vUdP752qm/Y1kdhOS6EWu5Klt0/S3SjKw1vcTGgtX9Cyg==
X-Received: by 2002:a17:902:ab54:b0:1cc:32df:8ebd with SMTP id
 ij20-20020a170902ab5400b001cc32df8ebdmr2186555plb.25.1700544755746; 
 Mon, 20 Nov 2023 21:32:35 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a6568cf000000b0056c2f1a2f6bsm6026749pgt.41.2023.11.20.21.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 21:32:35 -0800 (PST)
Message-ID: <88928426-1151-4200-9c36-8c2a570746d1@daynix.com>
Date: Tue, 21 Nov 2023 14:32:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] disas/cris: Pass buffer size to format_dec() to avoid
 overflow warning
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20231120214520.59431-1-pbonzini@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231120214520.59431-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

On 2023/11/21 6:45, Paolo Bonzini wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
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
> Message-ID: <20231120132222.82138-1-philmd@linaro.org>
> [Rewritten to fix logic and avoid repeated expression. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   disas/cris.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/disas/cris.c b/disas/cris.c
> index 0b0a3fb9165..409a224c5d1 100644
> --- a/disas/cris.c
> +++ b/disas/cris.c
> @@ -1731,10 +1731,10 @@ format_hex (unsigned long number,
>      unsigned (== 0).  */
>   
>   static char *
> -format_dec (long number, char *outbuffer, int signedp)
> +format_dec (long number, char *outbuffer, size_t outsize, int signedp)
>   {
>     last_immediate = number;
> -  sprintf (outbuffer, signedp ? "%ld" : "%lu", number);
> +  snprintf (outbuffer, outsize, signedp ? "%ld" : "%lu", number);
>   
>     return outbuffer + strlen (outbuffer);
>   }
> @@ -1876,6 +1876,12 @@ print_flags (struct cris_disasm_data *disdata, unsigned int insn, char *cp)
>     return cp;
>   }
>   
> +#define FORMAT_DEC(number, tp, signedp)                      \
> +    format_dec (number, tp, ({                                \

Nit: the slash at the end is misaligned.

Otherwise,
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> +            assert(tp >= temp && tp <= temp + sizeof(temp)); \
> +            temp + sizeof(temp) - tp;                        \
> +        }), signedp)
> +
>   /* Print out an insn with its operands, and update the info->insn_type
>      fields.  The prefix_opcodep and the rest hold a prefix insn that is
>      supposed to be output as an address mode.  */
> @@ -2105,7 +2111,7 @@ print_with_operands (const struct cris_opcode *opcodep,
>   	    if ((*cs == 'z' && (insn & 0x20))
>   		|| (opcodep->match == BDAP_QUICK_OPCODE
>   		    && (nbytes <= 2 || buffer[1 + nbytes] == 0)))
> -	      tp = format_dec (number, tp, signedp);
> +	      tp = FORMAT_DEC (number, tp, signedp);
>   	    else
>   	      {
>   		unsigned int highbyte = (number >> 24) & 0xff;
> @@ -2241,7 +2247,7 @@ print_with_operands (const struct cris_opcode *opcodep,
>   				       with_reg_prefix);
>   		      if (number >= 0)
>   			*tp++ = '+';
> -		      tp = format_dec (number, tp, 1);
> +		      tp = FORMAT_DEC (number, tp, 1);
>   
>   		      info->flags |= CRIS_DIS_FLAG_MEM_TARGET_IS_REG;
>   		      info->target = (prefix_insn >> 12) & 15;
> @@ -2340,7 +2346,7 @@ print_with_operands (const struct cris_opcode *opcodep,
>   			  {
>   			    if (number >= 0)
>   			      *tp++ = '+';
> -			    tp = format_dec (number, tp, 1);
> +			    tp = FORMAT_DEC (number, tp, 1);
>   			  }
>   		      }
>   		    else
> @@ -2397,7 +2403,7 @@ print_with_operands (const struct cris_opcode *opcodep,
>   	break;
>   
>         case 'I':
> -	tp = format_dec (insn & 63, tp, 0);
> +	tp = FORMAT_DEC (insn & 63, tp, 0);
>   	break;
>   
>         case 'b':
> @@ -2426,11 +2432,11 @@ print_with_operands (const struct cris_opcode *opcodep,
>         break;
>   
>       case 'c':
> -      tp = format_dec (insn & 31, tp, 0);
> +      tp = FORMAT_DEC (insn & 31, tp, 0);
>         break;
>   
>       case 'C':
> -      tp = format_dec (insn & 15, tp, 0);
> +      tp = FORMAT_DEC (insn & 15, tp, 0);
>         break;
>   
>       case 'o':
> @@ -2463,7 +2469,7 @@ print_with_operands (const struct cris_opcode *opcodep,
>   	if (number > 127)
>   	  number = number - 256;
>   
> -	tp = format_dec (number, tp, 1);
> +	tp = FORMAT_DEC (number, tp, 1);
>   	*tp++ = ',';
>   	tp = format_reg (disdata, (insn >> 12) & 15, tp, with_reg_prefix);
>         }
> @@ -2474,7 +2480,7 @@ print_with_operands (const struct cris_opcode *opcodep,
>         break;
>   
>       case 'i':
> -      tp = format_dec ((insn & 32) ? (insn & 31) | ~31L : insn & 31, tp, 1);
> +      tp = FORMAT_DEC ((insn & 32) ? (insn & 31) | ~31L : insn & 31, tp, 1);
>         break;
>   
>       case 'P':

