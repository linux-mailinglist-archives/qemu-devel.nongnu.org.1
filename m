Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5E37D24D3
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 19:12:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qubye-0004SE-JK; Sun, 22 Oct 2023 13:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qubyZ-0004Rm-Ji
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 13:10:58 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qubyX-0006b1-PI
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 13:10:55 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-27d0e3d823fso1499923a91.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697994652; x=1698599452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MT7/OkbwYXzqm7VE2qtOps/wtX8JVt4hsiNR/F3abZY=;
 b=pdUXvEw8iZCd3odgDFCEuHFTjJqlMZKI4PDkkmGOVdYvvjZpaTrQX+9uZJZK6j2S1g
 /rBtdoIHqnxMkH2XfPpwYg/SniSE9xnLORxgMbBFD3zMXzfOo9Br26sLUrW0nk1UEjtf
 IpZMA/v5sDreipkVHXOwZHQMpbcUhdQnt0Mp53s+hjAdYNb51zIaI7Yy0tuGl6TT9Eta
 bVnR5j5/MSgOpnw508c494yxJlIE/TdsL/RBn6b8M8WqXxeDzLcu5xgVmrLwLkJuBq6T
 HOifZEwItgxWRbKCFZHhoIaSztzvQqB2W5CJLmNMBiDhfsFRkCo3X37Kv42BDcIahuX/
 K5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697994652; x=1698599452;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MT7/OkbwYXzqm7VE2qtOps/wtX8JVt4hsiNR/F3abZY=;
 b=kMpeQqwDy41VsvldwLgnMHrndyWbfO0HjZny98mKB/7lk9vY1pQDShIlhOuKK77Ru2
 eAWpqGHY/K3gOHmxRuT/dty772FQ+rH24a9gkbnHOqqxGHD/1bTq2jwClxAFiUmfS85G
 Z2jTC6DQG3RDy0Dad915I1T0NFii0iB9GGcpbC9RTQ/No2OgsFrTOYB8zod1+V7LFoIm
 s0otNbHznp1Xa5U472gPih/EXLgf5TvPacFIqN+g7ql+khiXu0LpiRn+/PaXgfeXpkyO
 78qHS1BO4BFa5QXLJjE9TwimqsA9Xf3zeZWJuA4UDMByqVktO+gRIHGNnOBjb+9Bj5TS
 wJLA==
X-Gm-Message-State: AOJu0Yxo1lxvTkfe/kWoacu0FYYtOZrz6B6vRhUakkVW7YQ1ZOmqPTJW
 uJcF8KI0MIC8xarrY1gouNVfEUeykFjTNAkf7c0=
X-Google-Smtp-Source: AGHT+IFgUwGw2Xi4aBuNr8lbRXNgirACtiQ3YzP5k4t7JFGaBDsUHvJYgS+MpmKcz0MpX0S9DloBjw==
X-Received: by 2002:a17:90b:3784:b0:27d:8fbd:be95 with SMTP id
 mz4-20020a17090b378400b0027d8fbdbe95mr5163574pjb.28.1697994652233; 
 Sun, 22 Oct 2023 10:10:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 gd22-20020a17090b0fd600b002791d5a3e29sm4533932pjb.6.2023.10.22.10.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 10:10:51 -0700 (PDT)
Message-ID: <9b50799e-aaa0-42ce-b110-33e9a581dd1c@linaro.org>
Date: Sun, 22 Oct 2023 10:10:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/90] target/sparc: Convert to decodetree
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20231022060031.490251-1-richard.henderson@linaro.org>
 <f4fec7ec-7aff-475f-a055-eaf4069830e8@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f4fec7ec-7aff-475f-a055-eaf4069830e8@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/22/23 05:44, Mark Cave-Ayland wrote:
> On 22/10/2023 06:59, Richard Henderson wrote:
> 
>> Changes for v4:
>>    * Implement htstate for RDHPR, WRHPR.
>>      This was the issue with sun4v rom, "wrhpr %g0, %htstate".
>>      Previously we "implemented" this with nop.  But since we
>>      have env->htstate[], add the obvious implementation.
> 
> Ah I see. So presumably the patch that implements this could also have a Fixes: 
> https://gitlab.com/qemu-project/qemu/-/issues/847 tag?

Yes indeed.  I'd forgotten about that one.

> 
>>    * The fp asi reorg got lost with "sizes", one of which was for
>>      the size of the access, and the other was a proxy for the
>>      original instruction.  This broke "stda reg, [addr] #ASI_FL8_P",
>>      used in Mark's netbsd image.
> 
> I found a build failure when building this series with --target-list='sparc-softmmu 
> sparc64-softmmu':
> 
> cc -m64 -mcx16 -Ilibqemu-sparc-softmmu.fa.p -I. -I.. -Itarget/sparc -I../target/sparc 
> -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/pixman-1 -I/usr/include/spice-server 
> -I/usr/include/spice-1 -I/usr/include/glib-2.0 
> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fdiagnostics-color=auto -Wall -Winvalid-pch 
> -Werror -std=gnu11 -O2 -g -fstack-protector-strong -Wundef -Wwrite-strings 
> -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls -Wold-style-declaration 
> -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self 
> -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined 
> -Wimplicit-fallthrough=2 -Wmissing-format-attribute -Wno-missing-include-dirs 
> -Wno-shift-negative-value -Wno-psabi -isystem /home/build/src/qemu/git/qemu/linux-headers 
> -isystem linux-headers -iquote . -iquote /home/build/src/qemu/git/qemu -iquote 
> /home/build/src/qemu/git/qemu/include -iquote 
> /home/build/src/qemu/git/qemu/host/include/x86_64 -iquote 
> /home/build/src/qemu/git/qemu/host/include/generic -iquote 
> /home/build/src/qemu/git/qemu/tcg/i386 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 
> -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -fPIE 
> -isystem../linux-headers -isystemlinux-headers -DNEED_CPU_H 
> '-DCONFIG_TARGET="sparc-softmmu-config-target.h"' 
> '-DCONFIG_DEVICES="sparc-softmmu-config-devices.h"' -MD -MQ 
> libqemu-sparc-softmmu.fa.p/target_sparc_translate.c.o -MF 
> libqemu-sparc-softmmu.fa.p/target_sparc_translate.c.o.d -o 
> libqemu-sparc-softmmu.fa.p/target_sparc_translate.c.o -c ../target/sparc/translate.c
> In file included from ../target/sparc/translate.c:21:
> ../target/sparc/translate.c: In function ‘do_wrhtstate’:
> /home/build/src/qemu/git/qemu/include/qemu/osdep.h:261:35: error: call to 
> ‘qemu_build_not_reached_always’ declared with attribute error: code path is reachable
>    261 | #define qemu_build_not_reached()  qemu_build_not_reached_always()
>        |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../target/sparc/translate.c:3800:5: note: in expansion of macro ‘qemu_build_not_reached’
>   3800 |     qemu_build_not_reached();
>        |     ^~~~~~~~~~~~~~~~~~~~~~
> [10/23] cc -m64 -mcx16 -Iqemu-io.p

Ho hum, I think I only tested this change with --enable-debug.
I'll improve the avail_HYPV() test so the compiler can tell this is a 64-bit thing.

> Otherwise this version passes all my boot tests so:
> 
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Feel free to take this via tcg-next if it's easier for you, and thanks once again for such 
> a great piece of work :)

Thank you for the testing.  I can certainly send the PR.


r~

