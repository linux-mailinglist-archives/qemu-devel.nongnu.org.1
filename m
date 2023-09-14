Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF4B7A0BEE
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 19:46:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqOZ-0000kw-On; Thu, 14 Sep 2023 13:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgqOV-0000fW-5q
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:44:47 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgqOS-00070L-1j
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:44:46 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68a3ced3ec6so1114565b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694713482; x=1695318282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PvdEJV3jhqsKSWl/RxX9U8TRziNTQDBkGzBSJuHzFo=;
 b=oE8Z0mf6l+c1eGu4vpXVRgO9kLwQVxzGGS5q7Zc03PDV98VDZs5NlYAgmyOvfVEFXp
 M97SswfZ1pkofCUqdLXTEkkt0B0s0J0Bs1LwZjR1kAA8ZTyJVRsu5FGRm+6FJJWkTJg8
 BgZ/Rhm4lywot/fe1BLcwzHsd2Vv2+fLCOJuLQEKvfKYFq/Pn83PUv+5b2bh37WkX9Zr
 uyRSaQJhIxPAYLGmY09uPh0j+mdaeked7DL+tTNF2njuvHspgvKUqFS1HY4s4PisACc/
 fLDCI9sTZVH1T7B/vkf6JBv2Nlks2lEJl2V+kfCw+C0hY5RxYQq+l5vQT/5byq65vlDh
 whiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694713482; x=1695318282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PvdEJV3jhqsKSWl/RxX9U8TRziNTQDBkGzBSJuHzFo=;
 b=lrrDog9jjQNeuMLpE5GtdzzlIHV86pfXPYWj0Xw1G0V3yW/nYo1E2BhdMwAk4Hlh3H
 PcZpSgrlE9a7mkkyj/P4lCw/cr9LnBA1zAq2utnTPtAywSVQ4niPQ13/SlzB4G3tP0RG
 y0wgXO+12Ewsu17eM6k/Xz+KbLpU21qU7i7WUJL3y3Jqm90LVkQ/FL4z0Dzu2XF7ASOD
 PKK3FkK/HD4xKQkuzsNmwFRXBR0jg0zUBZMU7pmArrbLtAWzuqBhY/HJo/9IykLl/YQH
 GPGtNvdi7zxLsfEeNW+xxz7pHKkpfTOwR4ipcCC5CBhiOg+bm0iQLSWXifr4HeXzhoBY
 VGUA==
X-Gm-Message-State: AOJu0Yzn+uL9R6YD8CLa9fF06KWQm3QsqjWJN6Q54Qyjkm0qAy2BrQe4
 o37PIkjTKlbYIDYqhjHWDJRAz+5ygXHjchtMBKk=
X-Google-Smtp-Source: AGHT+IHJPEKTUUKcc7vPH+EHU5DIsAZsiYa2FJeLuNK/Od/4/7CssrY1DUavJ6i/448KZ1wtUYgbKg==
X-Received: by 2002:a05:6a21:6d84:b0:132:a85f:b20c with SMTP id
 wl4-20020a056a216d8400b00132a85fb20cmr7422194pzb.38.1694713482655; 
 Thu, 14 Sep 2023 10:44:42 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 w17-20020aa78591000000b0068c5bd3c3b4sm1588933pfn.206.2023.09.14.10.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 10:44:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 5/6] accel/tcg: Always set CF_LAST_IO with CF_NOIRQ
Date: Thu, 14 Sep 2023 10:44:35 -0700
Message-Id: <20230914174436.1597356-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914174436.1597356-1-richard.henderson@linaro.org>
References: <20230914174436.1597356-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Without this we can get see loops through cpu_io_recompile,
in which the cpu makes no progress.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 2 +-
 accel/tcg/tb-maint.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index e2c494e75e..c724e8b6f1 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -720,7 +720,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
             && cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra == 0) {
             /* Execute just one insn to trigger exception pending in the log */
             cpu->cflags_next_tb = (curr_cflags(cpu) & ~CF_USE_ICOUNT)
-                | CF_NOIRQ | 1;
+                | CF_LAST_IO | CF_NOIRQ | 1;
         }
 #endif
         return false;
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 32ae8af61c..0c3e227409 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1083,7 +1083,8 @@ bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc)
     if (current_tb_modified) {
         /* Force execution of one insn next time.  */
         CPUState *cpu = current_cpu;
-        cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
+        cpu->cflags_next_tb =
+            1 | CF_LAST_IO | CF_NOIRQ | curr_cflags(current_cpu);
         return true;
     }
     return false;
@@ -1153,7 +1154,8 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
     if (current_tb_modified) {
         page_collection_unlock(pages);
         /* Force execution of one insn next time.  */
-        current_cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
+        current_cpu->cflags_next_tb =
+            1 | CF_LAST_IO | CF_NOIRQ | curr_cflags(current_cpu);
         mmap_unlock();
         cpu_loop_exit_noexc(current_cpu);
     }
-- 
2.34.1


