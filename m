Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3C87EF811
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 20:54:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r44tN-0000GG-Dy; Fri, 17 Nov 2023 14:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r44tL-0000EJ-Fl
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 14:52:39 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r44tJ-0003rD-KB
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 14:52:39 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ce5b7040e4so11092465ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 11:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700250755; x=1700855555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Ku04tseP3aYOuaMn4miUgcIFlw2zfMAUhYiFCjcVK4=;
 b=TtXmrPs2sEb8R1QlQYNUlNJrSzOJAfo5BePykSb4jcPRT1wwUV+AOMStLFKE3z28j8
 gkzJEsAhBm+JKBfa96mtZu7HmaZkcRjtoK4/Y+Z9yYhxtwRJ2sECHB/YtcedNsuVUwhQ
 dg2I3KRuqUdOtTq/LmeL3bv58YN/ZXSeF+FKnk7evo3z4OtTFHVp3TTXIdIXWMSK9oHl
 kAA1Xu3g1XvpYTR2zh/EbP7eFFlvF7Nbu/RMuaPe0Hun+gRh+3HCTQznTk3QO456CbgJ
 1lG5yOHYIxOkL2H/P+f0aWtAnFBaFMvWe7mp6TxF0tGKPuAjJLBP5CH0KdFskEvNU8+Y
 hAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700250755; x=1700855555;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Ku04tseP3aYOuaMn4miUgcIFlw2zfMAUhYiFCjcVK4=;
 b=LS7+Nm36ToYNga+xkleiTEMeNYI4eplga4QBWQ0jR+dbbiVhjsqfoADh/EAYJNVXLy
 uyGRaxtbMUg/b9o6ovlyg+IwVhLQf2VtdFX5GpsH3Ibivyp6+M2A+3GWpAkF6KcPF/K7
 LKl8gNirxFLcR4UX9Y5PBp9gtbtpTLoj6H2OuzkosaHCmhFubdd2/NcceFSRNWQPE6cz
 KR0qVmsnR7sm7y8ok66BgiTjRBYvK/nxOnsM9ZrCLGyfpQlWEBFS85pq/PyL1ac41hfi
 y0dMBQgXsb3KBEbsUfop23vtPCTEptrkipCEpgzC1GN81Pv/1En07oT0m9J7q80dxmNH
 8ZzQ==
X-Gm-Message-State: AOJu0YxIYlxnng0sdrA6xZd/okOaKNdEc+oNKPEdHGUYbU6mVCbcg090
 jX55r9ZNihbUiGKS74qg9LUzKw==
X-Google-Smtp-Source: AGHT+IHVU9SLawx5JnJhjwXTkqISDNbuVXxhH0XLFzuD0ksTHd2MRNrp16HJH+y9IZtidkF2nQPgqg==
X-Received: by 2002:a17:902:904a:b0:1cc:1ee2:d41d with SMTP id
 w10-20020a170902904a00b001cc1ee2d41dmr560084plz.39.1700250755135; 
 Fri, 17 Nov 2023 11:52:35 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jb1-20020a170903258100b001c898328289sm1751144plb.158.2023.11.17.11.52.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 11:52:34 -0800 (PST)
Message-ID: <44d4277a-3f43-47a4-9e5e-0c8bc49e7082@linaro.org>
Date: Fri, 17 Nov 2023 11:52:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] disas/hppa: Show hexcode of instruction along with
 disassembly
Content-Language: en-US
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org
References: <20231117105309.149225-1-deller@kernel.org>
 <20231117105309.149225-3-deller@kernel.org>
 <6e256fa7-69eb-47de-a06b-f99d66318918@linaro.org> <ZVej4L9FHe9zZF9A@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZVej4L9FHe9zZF9A@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 11/17/23 09:33, Helge Deller wrote:
> * Richard Henderson <richard.henderson@linaro.org>:
>> On 11/17/23 02:53, deller@kernel.org wrote:
>>> From: Helge Deller <deller@gmx.de>
>>>
>>> On hppa many instructions can be expressed by different bytecodes.
>>> To be able to debug qemu translation bugs it's therefore necessary to see the
>>> currently executed byte codes without the need to lookup the sequence without
>>> the full executable.
>>> With this patch the instruction byte code is shown beside the disassembly.
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>> ---
>>>    disas/hppa.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/disas/hppa.c b/disas/hppa.c
>>> index dcf9a47f34..38fc05acc4 100644
>>> --- a/disas/hppa.c
>>> +++ b/disas/hppa.c
>>> @@ -1979,6 +1979,9 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
>>>    	  if (opcode->arch == pa20w)
>>>    	    continue;
>>>    #endif
>>> +	  (*info->fprintf_func) (info->stream, " %02x %02x %02x %02x   ",
>>> +                (insn >> 24) & 0xff, (insn >> 16) & 0xff,
>>> +                (insn >>  8) & 0xff, insn & 0xff);
>>>    	  (*info->fprintf_func) (info->stream, "%s", opcode->name);
>>>    	  if (!strchr ("cfCY?-+nHNZFIuv{", opcode->args[0]))
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> A possible improvement is to push this outside of the search loop and then change
>>
>>       }
>> -  (*info->fprintf_func) (info->stream, "#%8x", insn);
>> +  info->fprintf_func(info->stream, "<unknown>");
>>     return sizeof (insn);
>>
>> so the byte decode is shared with the rare case of garbage in the insn stream.
> 
> Like below?

Yes, perfect, thanks.


r~

> 
> From: Helge Deller <deller@gmx.de>
> Subject: [PATCH] disas/hppa: Show hexcode of instruction along with
>   disassembly
> 
> On hppa many instructions can be expressed by different bytecodes.
> To be able to debug qemu translation bugs it's therefore necessary to see the
> currently executed byte codes without the need to lookup the sequence without
> the full executable.
> With this patch the instruction byte code is shown beside the disassembly.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/disas/hppa.c b/disas/hppa.c
> index dcf9a47f34..cce4f4aa37 100644
> --- a/disas/hppa.c
> +++ b/disas/hppa.c
> @@ -1968,6 +1968,10 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
>   
>     insn = bfd_getb32 (buffer);
>   
> +  info->fprintf_func(info->stream, " %02x %02x %02x %02x   ",
> +                (insn >> 24) & 0xff, (insn >> 16) & 0xff,
> +                (insn >>  8) & 0xff, insn & 0xff);
> +
>     for (i = 0; i < NUMOPCODES; ++i)
>       {
>         const struct pa_opcode *opcode = &pa_opcodes[i];
> @@ -2826,6 +2830,6 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
>   	  return sizeof (insn);
>   	}
>       }
> -  (*info->fprintf_func) (info->stream, "#%8x", insn);
> +  info->fprintf_func(info->stream, "<unknown>");
>     return sizeof (insn);
>   }


