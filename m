Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CA278F665
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 02:31:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbs2x-0003kl-6t; Thu, 31 Aug 2023 20:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbs2t-0003dv-01
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 20:29:55 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbs2q-00029U-NW
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 20:29:54 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c313f8c6c9so3247395ad.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 17:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693528191; x=1694132991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dIC7rKSHYhIABa7HPhMpK46sFJ4BG039qQFODTERsNA=;
 b=T/oz0FhAG8GIX6C47f1zRtvT75W68BS5buDLxWmrfIDgmjudXlB4P7wR+6n93E/JTM
 qzQ9aXQmuM/aEilzACVSsqZDbvJ8xVpfd1I/hynleu3YLn4dL3FQH6Yk+TLSbat6LNbB
 5a4Z5nCh+Fivkrc4fkOcV4vEOl5+27r8XjqxZhbmQpQuVbZhi2QadpX9Qu4XrXHuhTre
 211QZnv6LKlRDmz6tMNAJN7Q80gNK02z4kjUdB359o9StXxDNV18/CqAycsETiAl2TXW
 PswMniLA79oVxOne6R8rBrf2X4KY8e8RAIP8lJQZ2mK63ms8oIN+VRhFe/ZCm8R9PFTo
 /mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693528191; x=1694132991;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dIC7rKSHYhIABa7HPhMpK46sFJ4BG039qQFODTERsNA=;
 b=bcEM5mR7rL+2KAQE1Wlto0MCqxVaWCz8irnO62FOI85G8OGxWT5UivbKU/v8lQxoKP
 jcJBfvn2HY4vCrNInE1KITYI777BBe1o2g3WqU/+NmodYR6Rpb5GZ9k1a5+ISGvuP7f5
 FBKI+M5gKonLEfjyauHKRELSl3CDWKe6Rt89GF//krb0w2dh4ROcMLhZ59Wdfk9qoXQC
 OIWyDLTZGbpRL/Wu+xU8BBzIBVlumv6sBm5IxsvuMz8+LNKznsfGdQRtGv+odx85Kc+t
 a3U+B4jSnCzi9rXWqeY1MewwCH3iyOku9go9R9DJexssohny9qZaQhwtNjYsAfedIFub
 5VIw==
X-Gm-Message-State: AOJu0YyAc9E65aVgwBge3rk+H5uY2P2ypZ4EjVYUrSm0vHsFqK5tjQea
 WO+kst9Wt6ZFJFu587HNlgCeiA==
X-Google-Smtp-Source: AGHT+IER04UQAmgaTxQcWTOkACWDGnZ0AzQ5hgERef3v7xpdGjSxTF0idl+Hqb+vYQXCn7qhdtAmKQ==
X-Received: by 2002:a17:903:2653:b0:1b8:90bd:d157 with SMTP id
 je19-20020a170903265300b001b890bdd157mr1263113plb.26.1693528190842; 
 Thu, 31 Aug 2023 17:29:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y11-20020a1709027c8b00b00198d7b52eefsm1759178pll.257.2023.08.31.17.29.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 17:29:50 -0700 (PDT)
Message-ID: <47fa4915-4bc9-665a-5679-4dafc03a5c62@linaro.org>
Date: Thu, 31 Aug 2023 17:29:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 7/7] target/mips: Convert Loongson [D]MULT[U].G opcodes
 to decodetree
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20230831203024.87300-1-philmd@linaro.org>
 <20230831203024.87300-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230831203024.87300-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 8/31/23 13:30, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Convert the following opcodes to decodetree:
> 
> - MULT.G - multiply 32-bit signed integers
> - MULTU.G - multiply 32-bit unsigned integers
> - DMULT.G - multiply 64-bit signed integers
> - DMULTU.G - multiply 64-bit unsigned integers
> 
> Now that all opcodes from the extension have been converted, we
> can remove completely gen_loongson_integer() and its 2 calls in
> decode_opc_special2_legacy() and decode_opc_special3_legacy().
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> +    if (is_double) {
> +        if (TARGET_LONG_BITS != 64) {
> +            return false;
> +        }
> +        check_mips_64(s);
> +    }

This preserves existing behaviour vs

> -#if defined(TARGET_MIPS64)
> -    case OPC_DMULT_G_2E:
> -    case OPC_DMULT_G_2F:
> -        tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
> -        break;
> -    case OPC_DMULTU_G_2E:
> -    case OPC_DMULTU_G_2F:
> -        tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
> -        break;
> -#endif

this ifdef.  But it doesn't seem quite right.

It's a behaviour change between qemu-system-mips and qemu-system-mips64 for the same cpu. 
Returning false allows another insn to match instead.  But we have identified the insn, it 
just isn't legal.

Anyway, aren't all of these loongson cpus 64-bit?


r~

