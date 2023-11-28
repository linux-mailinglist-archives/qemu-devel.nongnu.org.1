Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C6B7FB90B
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 12:10:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7vxQ-00085B-4H; Tue, 28 Nov 2023 06:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7vxM-00084R-P1
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 06:08:45 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7vxJ-0001rp-Uj
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 06:08:43 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a08e4352992so532253866b.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 03:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701169720; x=1701774520; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X4UnIEG4bLGgO/r4zSqP7V5F+JhAr1lIupKqM/3PPCM=;
 b=A3anCzrKNhNaUDrOPNiyM6Ve/m1H3IMSF1qhWEXm71ap7l9aKPuVpfs+/1cT/RtzyZ
 RhLLwJkubYyUTwC5+Tec5yrdKsPdqBhTWqkq+VDV/HFRolAtHbxdmyJnQvvPf/6S195k
 fdZaQVSqJH/alqAzCh4jS+stbvoFDlmr9DG4N+py3TW3YfBvLHIdep6YcNegFigM8sXJ
 EGoj1s+d3b3nl1/QO/oXZHNpe4nUJD6VmBw3FUGwc43u9Nu3eOvGxFesbo3Jp0x0vR80
 LyU1c70vfmMq1J+GjNATPbvnzQNFTdM0trr9fV2phQPzq674LfDGUOHwqd8pjwhS4lfB
 +A8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701169720; x=1701774520;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X4UnIEG4bLGgO/r4zSqP7V5F+JhAr1lIupKqM/3PPCM=;
 b=EWPaVOH1oaWGFKFboU4chXXAS+lXiGD32he8eaMY8rXtOd6E/4V5MqfOyn4VXGnIGB
 tchm+A6gx6WqWRomjn/cF5dsHcOJDRw6dfxOE4tPq9R6y6PdeqtBYnjGrTgvfCs9Y9nd
 MNoULfV4irk+kTvT8Chc11nUk0AaFEHZYSXoIZLHd6RBrZTY0jAc8bdiRkctWYh+lBJ9
 RBgZwaByM9Ur4RG/HpQsVDVs2uyJpeGOP5JqmPp4MhuX2BK5iHxsKtKaMBp3xVC9baMo
 VYFx1OBuCNivPHd6MWXlWtuQU/mdW19taxiJUvgs1e2ejELCE7o+XNgRq4NO0XKCy0xR
 zGvw==
X-Gm-Message-State: AOJu0YyFPSZ1pJoxRzfMLU+rLY7vQWceJvz41Y5seZXxaEkIWiK1lQdM
 gKSSdMx8vGb2DwwWXiIlrvTpNA==
X-Google-Smtp-Source: AGHT+IE3YwJV3D3A1aewPMUI5dObg5IzWJIXt7LGU58Jll2640E75ZdasTK0xtsdgKz4qlp8GZKCog==
X-Received: by 2002:a17:906:f813:b0:a16:3da0:dd36 with SMTP id
 kh19-20020a170906f81300b00a163da0dd36mr696408ejb.48.1701169720222; 
 Tue, 28 Nov 2023 03:08:40 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 w7-20020a17090633c700b009ff10633221sm6695711eja.128.2023.11.28.03.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 03:08:39 -0800 (PST)
Message-ID: <7a6efb0c-62fb-4047-a20a-261ebb8c99ac@linaro.org>
Date: Tue, 28 Nov 2023 12:08:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.1 v6 14/17] accel/tcg: Move breakpoint recognition
 outside translation
Content-Language: en-US
To: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org,
 mark.cave-ayland@ilande.co.uk, Max Filippov <jcmvbkbc@gmail.com>
References: <20210720195439.626594-1-richard.henderson@linaro.org>
 <20210720195439.626594-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20210720195439.626594-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

Hi,

On 20/7/21 21:54, Richard Henderson wrote:
> Trigger breakpoints before beginning translation of a TB
> that would begin with a BP.  Thus we never generate code
> for the BP at all.
> 
> Single-step instructions within a page containing a BP so
> that we are sure to check each insn for the BP as above.
> 
> We no longer need to flush any TBs when changing BPs.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/286
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/404
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/489
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cpu-exec.c   | 91 ++++++++++++++++++++++++++++++++++++++++--
>   accel/tcg/translator.c | 24 +----------
>   cpu.c                  | 20 ----------
>   3 files changed, 89 insertions(+), 46 deletions(-)


> diff --git a/cpu.c b/cpu.c
> index 91d9e38acb..d6ae5ae581 100644
> --- a/cpu.c
> +++ b/cpu.c
> @@ -225,11 +225,6 @@ void tb_invalidate_phys_addr(target_ulong addr)
>       tb_invalidate_phys_page_range(addr, addr + 1);
>       mmap_unlock();
>   }
> -
> -static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
> -{
> -    tb_invalidate_phys_addr(pc);
> -}

This patch removed the last use of tb_invalidate_phys_addr() in
user emulation:

   void tb_invalidate_phys_addr(hwaddr addr)
   {
       mmap_lock();
       tb_invalidate_phys_page(addr);
       mmap_unlock();
   }

Do we still need it?

(In sysemu there is a single use in Xtensa tb_invalidate_virtual_addr).

>   #else
>   void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
>   {
> @@ -250,17 +245,6 @@ void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
>       ram_addr = memory_region_get_ram_addr(mr) + addr;
>       tb_invalidate_phys_page_range(ram_addr, ram_addr + 1);
>   }
> -
> -static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
> -{
> -    /*
> -     * There may not be a virtual to physical translation for the pc
> -     * right now, but there may exist cached TB for this pc.
> -     * Flush the whole TB cache to force re-translation of such TBs.
> -     * This is heavyweight, but we're debugging anyway.
> -     */
> -    tb_flush(cpu);
> -}
>   #endif


