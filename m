Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FE27EBADB
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:13:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34SA-0006M5-GU; Tue, 14 Nov 2023 20:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34S8-0006Li-RQ
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:12:24 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34S7-0008Fh-7J
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:12:24 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6c4eb5fda3cso4771136b3a.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 17:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700010741; x=1700615541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CHBOb3VRy/Vod6gFpo67m1WGjkyjs2wdmib4PsHWByY=;
 b=MQ5DrsqlQe8S0FK5ENbQ1P8r8K7lCkMYRDqoy4LQ6DPswIXWqLuHJa1ZYnAPAQUsfR
 srfwSyaPY3pEGucWfNny+r/mM9Uq81VyioK4m3vmNm9sRk5rw3NO/ffgPSgu1JelPhFU
 fmQYqqcgSdjufgPQaWad9CZBv6jhDbj2Se/Jl0vPDe4rWPgzgSbaFJe81MT5veVOWnNc
 6hPFMRGDbCWcWlO4AHbAYK4E3G+UGadtm/TTlVB7/zp9lgP6NWV806lpddz1m0pzVJmo
 hDDGxodO+9+KtsREt+vd5i8Mtc0VGuwtq4OrY+c/wUlaUYdD9iCSXWdcVRC9eLPwHAb/
 xAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700010741; x=1700615541;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CHBOb3VRy/Vod6gFpo67m1WGjkyjs2wdmib4PsHWByY=;
 b=fu1FPAwTLcfrn98cwfXX6pkKpp/jB01+2v9kDij7Cu+EsPxcDoN4Css2juN3iT5DO3
 stwO1KoUbQBROWcDcu4O+7XTMnP/giUMBOUnSug4QGXtEHQInY8SjIzgIuhbs0N6BfND
 0Z/xROxipUgjvmpkXO3UNjzbusWmG6yYlKyb3gJBThzx6108rfxul76utO0rG4h1Ik1U
 1aRr5fmzvSzRoMXHo/85TVPmjHFuOZJ5cLjV9lN5fqRvKnyA6Hf24Gtyt90hew3ULN34
 YWv01YEGJcPy93afq4Rj6yxY8+biu31kkPDlP66uOKvJIIht8PMsaRN8DxO8kBbIfZRX
 aiUA==
X-Gm-Message-State: AOJu0Ywg0epHyBjaOenY921H3VoqwgLN1uukI2j6kwj5fFVc3pH61gMV
 llD3Yi6RD1S8me2hmsQjlvmY9nyVShEge+/JeCU=
X-Google-Smtp-Source: AGHT+IEB+A+mxyO/dIe1fzwFZT4JT86EZ9xc/ZLPre2q43W9peinnuVffhfnRne2y+WiuhP35mGkAw==
X-Received: by 2002:a05:6a20:158c:b0:15d:e68d:a850 with SMTP id
 h12-20020a056a20158c00b0015de68da850mr12715125pzj.29.1700010741657; 
 Tue, 14 Nov 2023 17:12:21 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 4-20020a17090a018400b0028098225450sm8724465pjc.1.2023.11.14.17.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 17:12:21 -0800 (PST)
Message-ID: <4d12bbdb-8f6b-4fa0-8939-da3d7ae49467@linaro.org>
Date: Tue, 14 Nov 2023 17:12:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/31] target/xtensa: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-22-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-22-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 11/14/23 15:56, Gavin Shan wrote:
> Before it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-xtensa -cpu ?
> Available CPUs:
>    test_mmuhifi_c3
>    sample_controller
>    lx106
>    dsp3400
>    de233_fpu
>    de212
>    dc233c
>    dc232b
> 
> After it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-xtensa -cpu ?
> Available CPUs:
>    dc232b
>    dc233c
>    de212
>    de233_fpu
>    dsp3400
>    lx106
>    sample_controller
>    test_mmuhifi_c3
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/xtensa/cpu.h          | 10 +---------
>   target/xtensa/helper.c       | 19 +++----------------
>   target/xtensa/overlay_tool.h |  7 ++-----
>   3 files changed, 6 insertions(+), 30 deletions(-)
> 
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index dd81729306..ffeb1ca43f 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -491,11 +491,6 @@ typedef struct XtensaConfig {
>       bool use_first_nan;
>   } XtensaConfig;
>   
> -typedef struct XtensaConfigList {
> -    const XtensaConfig *config;
> -    struct XtensaConfigList *next;
> -} XtensaConfigList;
> -
>   #if HOST_BIG_ENDIAN
>   enum {
>       FP_F32_HIGH,
> @@ -600,8 +595,6 @@ G_NORETURN void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
>                                                  MMUAccessType access_type, int mmu_idx,
>                                                  uintptr_t retaddr);
>   
> -#define cpu_list xtensa_cpu_list
> -
>   #define CPU_RESOLVING_TYPE TYPE_XTENSA_CPU
>   
>   #if TARGET_BIG_ENDIAN
> @@ -620,13 +613,12 @@ void xtensa_collect_sr_names(const XtensaConfig *config);
>   void xtensa_translate_init(void);
>   void **xtensa_get_regfile_by_name(const char *name, int entries, int bits);
>   void xtensa_breakpoint_handler(CPUState *cs);
> -void xtensa_register_core(XtensaConfigList *node);
> +void xtensa_register_core(XtensaConfig *config);
>   void xtensa_sim_open_console(Chardev *chr);
>   void check_interrupts(CPUXtensaState *s);
>   void xtensa_irq_init(CPUXtensaState *env);
>   qemu_irq *xtensa_get_extints(CPUXtensaState *env);
>   qemu_irq xtensa_get_runstall(CPUXtensaState *env);
> -void xtensa_cpu_list(void);
>   void xtensa_sync_window_from_phys(CPUXtensaState *env);
>   void xtensa_sync_phys_from_window(CPUXtensaState *env);
>   void xtensa_rotate_window(CPUXtensaState *env, uint32_t delta);
> diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
> index dbeb97a953..3654739b09 100644
> --- a/target/xtensa/helper.c
> +++ b/target/xtensa/helper.c
> @@ -35,8 +35,6 @@
>   #include "qemu/qemu-print.h"
>   #include "qemu/host-utils.h"
>   
> -static struct XtensaConfigList *xtensa_cores;
> -
>   static void add_translator_to_hash(GHashTable *translator,
>                                      const char *name,
>                                      const XtensaOpcodeOps *opcode)
> @@ -187,17 +185,15 @@ static void xtensa_core_class_init(ObjectClass *oc, void *data)
>       cc->gdb_num_core_regs = config->gdb_regmap.num_regs;
>   }
>   
> -void xtensa_register_core(XtensaConfigList *node)
> +void xtensa_register_core(XtensaConfig *config)
>   {
>       TypeInfo type = {
>           .parent = TYPE_XTENSA_CPU,
>           .class_init = xtensa_core_class_init,
> -        .class_data = (void *)node->config,
> +        .class_data = (void *)config,
>       };

This patch does two things and should be split.


r~

