Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C55C7C7F31
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:00:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD43-0000A3-Gp; Fri, 13 Oct 2023 03:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD40-000055-2k
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:28 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3x-0006pp-Ur
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:27 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4056ce55e7eso18654455e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183904; x=1697788704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FVMc7C3P9kHYr0jPsMuU0YyC4w2RjwroOoVS3PMEwE=;
 b=cKhW+XlsDDb+p3Mk0FyqQn59hagHstnyf+17of6cKfWfQ+2sPhwo7nk5I3milTCYfz
 PC02LIsYqDQpoZL8FtFgOGqYzNhCpiQwFPYVGe60MPc2M13omt3KoMKGKpZOnz3AX809
 kzhOBQRxPFpyQ/sNkuxzdqrmEKanqZMinbpnDIawJEFuu25xvh/TihZH5F+ivGEAYAnF
 oikg4eWlkumsQPHOUHfXFNaTkJ2M1d2Wggf9HUJr1XK3EuXnFKJPPt0VyoYR/3Fipngc
 v3fx7u3a7BZNoHdpKZSMzV/1gCdtzBa82fY1+WPi8jrIge7/k5oP+XMhm266m2JO/ttZ
 e4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183904; x=1697788704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FVMc7C3P9kHYr0jPsMuU0YyC4w2RjwroOoVS3PMEwE=;
 b=clKqURJA37zcamv5syEzuCfNJ9Gbd+m2XFLVKXhGObRqIZFtzjrl+JPXtyDM3v42wa
 0N6sAL9OTlqMqnnt2qCK5klYwVbIAS1YY2eYk3JTXqbm1SBmNUSFqQKk+EdvVSqN0Xsy
 pkaxUCwzCj980FSr7LvxS9m2SQxT44visbPaeZfiJ46aDbIvsoKn1+nesg1FX5/gEj1E
 W3NN4szSOErZrIiDMXHqLOhWS4W48Ty0oWWdoANAGTX4PBVSnfBb2rX960m85lqueXCq
 yR2/gvAxP8qEV9W3WqXskkgWAlC6yh9g+FpnDgv0Spqqmgs65msXrWUTMZjK7d+uceNN
 idBw==
X-Gm-Message-State: AOJu0YzSv1MG0PtRI4vUQbglOyBV1aHZ7X/LuuxRrT3/hOzDjG5egMhW
 TCfL5ufbNhSHmx6F7AWeHsuRsQ9i8PNpFM76HjA=
X-Google-Smtp-Source: AGHT+IFUK+idei1p8btWgahJ3dl6V9AnMjcdrDpFBlV0n9CdQBbkL6r4Q8383s/RZCy76PGWFX76yQ==
X-Received: by 2002:a7b:c41a:0:b0:401:b2c7:349b with SMTP id
 k26-20020a7bc41a000000b00401b2c7349bmr23252987wmi.7.1697183904296; 
 Fri, 13 Oct 2023 00:58:24 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:23 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v2 15/78] accel/tcg: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:42 +0300
Message-Id: <0fb697b5da862866e981e581bf61092d0be7e515.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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
 accel/tcg/cputlb.c             | 4 ++--
 accel/tcg/ldst_atomicity.c.inc | 2 +-
 accel/tcg/plugin-gen.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b8c5e345b8..92b7ab529a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2209,53 +2209,53 @@ static Int128 do_ld_whole_be16(CPUState *cpu, uintptr_t ra,
 /*
  * Wrapper for the above.
  */
 static uint64_t do_ld_beN(CPUState *cpu, MMULookupPageData *p,
                           uint64_t ret_be, int mmu_idx, MMUAccessType type,
                           MemOp mop, uintptr_t ra)
 {
     MemOp atom;
     unsigned tmp, half_size;
 
     if (unlikely(p->flags & TLB_MMIO)) {
         return do_ld_mmio_beN(cpu, p->full, ret_be, p->addr, p->size,
                               mmu_idx, type, ra);
     }
 
     /*
      * It is a given that we cross a page and therefore there is no
      * atomicity for the load as a whole, but subobjects may need attention.
      */
     atom = mop & MO_ATOM_MASK;
     switch (atom) {
     case MO_ATOM_SUBALIGN:
         return do_ld_parts_beN(p, ret_be);
 
     case MO_ATOM_IFALIGN_PAIR:
     case MO_ATOM_WITHIN16_PAIR:
         tmp = mop & MO_SIZE;
         tmp = tmp ? tmp - 1 : 0;
         half_size = 1 << tmp;
         if (atom == MO_ATOM_IFALIGN_PAIR
             ? p->size == half_size
             : p->size >= half_size) {
             if (!HAVE_al8_fast && p->size < 4) {
                 return do_ld_whole_be4(p, ret_be);
             } else {
                 return do_ld_whole_be8(cpu, ra, p, ret_be);
             }
         }
-        /* fall through */
+        fallthrough;
 
     case MO_ATOM_IFALIGN:
     case MO_ATOM_WITHIN16:
     case MO_ATOM_NONE:
         return do_ld_bytes_beN(p, ret_be);
 
     default:
         g_assert_not_reached();
     }
 }
 
 /*
  * Wrapper for the above, for 8 < size < 16.
  */
@@ -2625,57 +2625,57 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
 /*
  * Wrapper for the above.
  */
 static uint64_t do_st_leN(CPUState *cpu, MMULookupPageData *p,
                           uint64_t val_le, int mmu_idx,
                           MemOp mop, uintptr_t ra)
 {
     MemOp atom;
     unsigned tmp, half_size;
 
     if (unlikely(p->flags & TLB_MMIO)) {
         return do_st_mmio_leN(cpu, p->full, val_le, p->addr,
                               p->size, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         return val_le >> (p->size * 8);
     }
 
     /*
      * It is a given that we cross a page and therefore there is no atomicity
      * for the store as a whole, but subobjects may need attention.
      */
     atom = mop & MO_ATOM_MASK;
     switch (atom) {
     case MO_ATOM_SUBALIGN:
         return store_parts_leN(p->haddr, p->size, val_le);
 
     case MO_ATOM_IFALIGN_PAIR:
     case MO_ATOM_WITHIN16_PAIR:
         tmp = mop & MO_SIZE;
         tmp = tmp ? tmp - 1 : 0;
         half_size = 1 << tmp;
         if (atom == MO_ATOM_IFALIGN_PAIR
             ? p->size == half_size
             : p->size >= half_size) {
             if (!HAVE_al8_fast && p->size <= 4) {
                 return store_whole_le4(p->haddr, p->size, val_le);
             } else if (HAVE_al8) {
                 return store_whole_le8(p->haddr, p->size, val_le);
             } else {
                 cpu_loop_exit_atomic(cpu, ra);
             }
         }
-        /* fall through */
+        fallthrough;
 
     case MO_ATOM_IFALIGN:
     case MO_ATOM_WITHIN16:
     case MO_ATOM_NONE:
         return store_bytes_leN(p->haddr, p->size, val_le);
 
     default:
         g_assert_not_reached();
     }
 }
 
 /*
  * Wrapper for the above, for 8 < size < 16.
  */
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 1cf5b92166..3752f74214 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -22,86 +22,86 @@
 /**
  * required_atomicity:
  *
  * Return the lg2 bytes of atomicity required by @memop for @p.
  * If the operation must be split into two operations to be
  * examined separately for atomicity, return -lg2.
  */
 static int required_atomicity(CPUState *cpu, uintptr_t p, MemOp memop)
 {
     MemOp atom = memop & MO_ATOM_MASK;
     MemOp size = memop & MO_SIZE;
     MemOp half = size ? size - 1 : 0;
     unsigned tmp;
     int atmax;
 
     switch (atom) {
     case MO_ATOM_NONE:
         atmax = MO_8;
         break;
 
     case MO_ATOM_IFALIGN_PAIR:
         size = half;
-        /* fall through */
+        fallthrough;
 
     case MO_ATOM_IFALIGN:
         tmp = (1 << size) - 1;
         atmax = p & tmp ? MO_8 : size;
         break;
 
     case MO_ATOM_WITHIN16:
         tmp = p & 15;
         atmax = (tmp + (1 << size) <= 16 ? size : MO_8);
         break;
 
     case MO_ATOM_WITHIN16_PAIR:
         tmp = p & 15;
         if (tmp + (1 << size) <= 16) {
             atmax = size;
         } else if (tmp + (1 << half) == 16) {
             /*
              * The pair exactly straddles the boundary.
              * Both halves are naturally aligned and atomic.
              */
             atmax = half;
         } else {
             /*
              * One of the pair crosses the boundary, and is non-atomic.
              * The other of the pair does not cross, and is atomic.
              */
             atmax = -half;
         }
         break;
 
     case MO_ATOM_SUBALIGN:
         /*
          * Examine the alignment of p to determine if there are subobjects
          * that must be aligned.  Note that we only really need ctz4() --
          * any more sigificant bits are discarded by the immediately
          * following comparison.
          */
         tmp = ctz32(p);
         atmax = MIN(size, tmp);
         break;
 
     default:
         g_assert_not_reached();
     }
 
     /*
      * Here we have the architectural atomicity of the operation.
      * However, when executing in a serial context, we need no extra
      * host atomicity in order to avoid racing.  This reduction
      * avoids looping with cpu_loop_exit_atomic.
      */
     if (cpu_in_serial_context(cpu)) {
         return MO_8;
     }
     return atmax;
 }
 
 /**
  * load_atomic2:
  * @pv: host address
  *
  * Atomically load 2 aligned bytes from @pv.
  */
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index d31c9993ea..ba9a8c8789 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -179,23 +179,23 @@ static void gen_wrapped(enum plugin_gen_from from,
 static void plugin_gen_empty_callback(enum plugin_gen_from from)
 {
     switch (from) {
     case PLUGIN_GEN_AFTER_INSN:
         gen_wrapped(from, PLUGIN_GEN_DISABLE_MEM_HELPER,
                     gen_empty_mem_helper);
         break;
     case PLUGIN_GEN_FROM_INSN:
         /*
          * Note: plugin_gen_inject() relies on ENABLE_MEM_HELPER being
          * the first callback of an instruction
          */
         gen_wrapped(from, PLUGIN_GEN_ENABLE_MEM_HELPER,
                     gen_empty_mem_helper);
-        /* fall through */
+        fallthrough;
     case PLUGIN_GEN_FROM_TB:
         gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb);
         gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
         break;
     default:
         g_assert_not_reached();
     }
 }
-- 
2.39.2


