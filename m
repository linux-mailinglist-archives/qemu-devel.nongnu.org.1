Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9F27C7F8C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:09:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4r-00035J-5t; Fri, 13 Oct 2023 03:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4k-0002Rb-Kn
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4W-0006wy-GR
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:14 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-406650da82bso18275365e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183937; x=1697788737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=liKgkIDmjxIZ8iQlMr82pqfYKW1BlEIkMZjnyTOJpWk=;
 b=rUHuqxV9ypb9HTLlU4oP2Nht2SUGpHizf0iVvu5aucip4jxywF7Gtx9YEkTjvUoQMJ
 tNGP9FsQDKJ6m/DoolJ7UkPKJn+pAAVLYuENE2UUNADoVFkKmZllr5/lm9nixCZZb2/E
 LFSQPQ9w2/oGXtAof10E1ka+VltUIyIahi7T/ICWCi5Q5m8UziT3G8Ar3u9R/aQhECEi
 Z/8NweRIpjM/aBWHmfHYDQ1LrPXz3+tm6C5Semnlhe5QDA2szR+HjbMZuah8T01w23eK
 vYtC9cRCOLxLMI2ywJa2cjYqwPJslHHO1c7CANFFlBWQlX51ImQI/trIWspcciq8FoDI
 V+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183938; x=1697788738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=liKgkIDmjxIZ8iQlMr82pqfYKW1BlEIkMZjnyTOJpWk=;
 b=QtXTlqGL2friBb0uz8nXTCRSyXFmCV/kHNxlZ9NSmokaj8dEy+hSzOH9Pfo0kXdZzi
 7AHEQa3jvIq94a3JWkb6o293q9l1OrHI8DF49MkKWp5CEFxAM/aOrg7yvLHeLQkf0/Xl
 ecLG/2arxWQ1wPP4MyAChwZrhX3l9hNcEc/jNuCUhUQkCMnthtvJDzc74MyvHjQOonsS
 v2ENvb137/o2SeL0edBYsFyrkIoK7tBDVfo6hSP00HsW1fqfUIwoa/1glRo5D4sZb99f
 tZH+W29hbN/0z4ZG6Qiey3hNuJmXpa8cglFd5uqRcAIkyW5HdQaJpm4fHoRR9At1dE7+
 jggQ==
X-Gm-Message-State: AOJu0Yx+eGZdGw0uBCmIFYtVzZ5Q9gRjoSYYXsIyIFSJZT7c+Qc09FFs
 zZDtxY/gPI288825mQ6IoQAit6E45QsLdMOaNWg=
X-Google-Smtp-Source: AGHT+IFS4gDkzFXune0KaZbgdzZ2N6T+rDvww2QUP6Ti6ushuZ7BQeWMmR4Ggl4RMXhcRQpfCXpSNg==
X-Received: by 2002:a05:600c:2218:b0:406:535a:f558 with SMTP id
 z24-20020a05600c221800b00406535af558mr24135288wml.10.1697183937768; 
 Fri, 13 Oct 2023 00:58:57 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:57 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [RFC PATCH v2 35/78] target/sh4: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:02 +0300
Message-Id: <1616b3baa81059284d7b58f2c5480f0b4dde439e.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/sh4/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index e02e7af607..c1cc5e82f4 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -56,131 +56,131 @@ int cpu_sh4_is_cached(CPUSH4State *env, target_ulong addr)
 void superh_cpu_do_interrupt(CPUState *cs)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
     CPUSH4State *env = &cpu->env;
     int do_irq = cs->interrupt_request & CPU_INTERRUPT_HARD;
     int do_exp, irq_vector = cs->exception_index;
 
     /* prioritize exceptions over interrupts */
 
     do_exp = cs->exception_index != -1;
     do_irq = do_irq && (cs->exception_index == -1);
 
     if (env->sr & (1u << SR_BL)) {
         if (do_exp && cs->exception_index != 0x1e0) {
             /* In theory a masked exception generates a reset exception,
                which in turn jumps to the reset vector. However this only
                works when using a bootloader. When using a kernel and an
                initrd, they need to be reloaded and the program counter
                should be loaded with the kernel entry point.
                qemu_system_reset_request takes care of that.  */
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             return;
         }
         if (do_irq && !env->in_sleep) {
             return; /* masked */
         }
     }
     env->in_sleep = 0;
 
     if (do_irq) {
         irq_vector = sh_intc_get_pending_vector(env->intc_handle,
 						(env->sr >> 4) & 0xf);
         if (irq_vector == -1) {
             return; /* masked */
 	}
     }
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
 	const char *expname;
         switch (cs->exception_index) {
 	case 0x0e0:
 	    expname = "addr_error";
 	    break;
 	case 0x040:
 	    expname = "tlb_miss";
 	    break;
 	case 0x0a0:
 	    expname = "tlb_violation";
 	    break;
 	case 0x180:
 	    expname = "illegal_instruction";
 	    break;
 	case 0x1a0:
 	    expname = "slot_illegal_instruction";
 	    break;
 	case 0x800:
 	    expname = "fpu_disable";
 	    break;
 	case 0x820:
 	    expname = "slot_fpu";
 	    break;
 	case 0x100:
 	    expname = "data_write";
 	    break;
 	case 0x060:
 	    expname = "dtlb_miss_write";
 	    break;
 	case 0x0c0:
 	    expname = "dtlb_violation_write";
 	    break;
 	case 0x120:
 	    expname = "fpu_exception";
 	    break;
 	case 0x080:
 	    expname = "initial_page_write";
 	    break;
 	case 0x160:
 	    expname = "trapa";
 	    break;
 	default:
             expname = do_irq ? "interrupt" : "???";
             break;
 	}
 	qemu_log("exception 0x%03x [%s] raised\n",
 		  irq_vector, expname);
         log_cpu_state(cs, 0);
     }
 
     env->ssr = cpu_read_sr(env);
     env->spc = env->pc;
     env->sgr = env->gregs[15];
     env->sr |= (1u << SR_BL) | (1u << SR_MD) | (1u << SR_RB);
     env->lock_addr = -1;
 
     if (env->flags & TB_FLAG_DELAY_SLOT_MASK) {
         /* Branch instruction should be executed again before delay slot. */
 	env->spc -= 2;
 	/* Clear flags for exception/interrupt routine. */
         env->flags &= ~TB_FLAG_DELAY_SLOT_MASK;
     }
 
     if (do_exp) {
         env->expevt = cs->exception_index;
         switch (cs->exception_index) {
         case 0x000:
         case 0x020:
         case 0x140:
             env->sr &= ~(1u << SR_FD);
             env->sr |= 0xf << 4; /* IMASK */
             env->pc = 0xa0000000;
             break;
         case 0x040:
         case 0x060:
             env->pc = env->vbr + 0x400;
             break;
         case 0x160:
             env->spc += 2; /* special case for TRAPA */
-            /* fall through */
+            fallthrough;
         default:
             env->pc = env->vbr + 0x100;
             break;
         }
         return;
     }
 
     if (do_irq) {
         env->intevt = irq_vector;
         env->pc = env->vbr + 0x600;
         return;
     }
 }
-- 
2.39.2


