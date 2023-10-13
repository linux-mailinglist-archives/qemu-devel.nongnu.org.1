Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8397C7EF7
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:52:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCvi-0004Bk-I3; Fri, 13 Oct 2023 03:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCvc-0004AW-CE
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:49:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCvW-00043f-AP
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:49:48 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4066241289bso19037125e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183380; x=1697788180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLlr5rM7K7HFMOYaMZw1hwvaelBo6N2zKwQvcIMTzLA=;
 b=aIoAMCMyn+5tj1twT6Q/jFL29e373pXlJpEjRVKdUMJ9oqvryhw5zMEDtfL61TVFUq
 mFsbedIo4EeAkbCoB/bnmwny4yW9vFrUmZPc/4VSr7MQE3iiIkNkLN8hSEZ4apFjr7Zc
 zpr3pzjE7gYdt+2z3huA3PAJVF1ZBiWrUMKhnm4IBYq8Xtmkiy70EZJ3M9NZWJnuhj8F
 46sJEgeZCN4kCF5nAboDO4Kqbc1XVhXnOGveerfurcYv+gl/Rw2vM8rnX/3Llr6yLVLE
 4t7PBWkgRY/lKDuf7kPw/XjzljgHwEbb4VSbtGNaXtE5JN3dXm8JtFBd35F7pf4vyiQp
 wzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183380; x=1697788180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WLlr5rM7K7HFMOYaMZw1hwvaelBo6N2zKwQvcIMTzLA=;
 b=PyGcNXu+WcMPdV441szhQLelHJJitpuohbcO+MYXjjLf5/ZKPQdaDL3+JHAvOsIMCi
 Erw+jSwUjIVX8fa0ezyv3yu+KT2DCk/GiDITlnmBeHkS/2X2G+iE1hNtC1fWujsria+6
 YSx60t8+UMjREKd48dafLI6t+G3B3XuWfD+EVY69KpF0IrS6aW4w2XCNjLnraqpJNqvp
 Y7dzaH4/U0i1atWaNkkB84MlbDrKnDbcj9gCxsVTZS1auYIB+w6XcbwJRTcVA7MWeneK
 ERWTXbealTadEtD2iOfOAKpm1y9hAbSvjE5zfGNXNmV1lUbX+vtZqnbZXlmCH62JczeK
 jx3A==
X-Gm-Message-State: AOJu0YwnbEL4En78vL9RC2RuTm9JF+5UO//X0PIA//Is1Qvm2Sy0QwiI
 BbYyOCHtIH3ikO2+U22GX+xo8I5dSUaRxqYh1kc=
X-Google-Smtp-Source: AGHT+IEAzlVEPkj4W+fpne4f9k3Fs0QGLPylRgEbh614MOjSVMZQUSPj32cGAmMn4IDhYhfNU7BpYg==
X-Received: by 2002:a05:600c:28c:b0:405:e492:8aef with SMTP id
 12-20020a05600c028c00b00405e4928aefmr23009846wmk.40.1697183380279; 
 Fri, 13 Oct 2023 00:49:40 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:49:39 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 01/78] include/qemu/compiler.h: replace QEMU_FALLTHROUGH
 with fallthrough
Date: Fri, 13 Oct 2023 10:47:05 +0300
Message-Id: <2e08cff874b2f9fc4143bdcde87ebba9b70b356c.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 audio/pwaudio.c              |  8 ++++----
 hw/arm/smmuv3.c              |  2 +-
 include/qemu/compiler.h      | 30 +++++++++++++++++++++++-------
 include/qemu/osdep.h         |  4 ++--
 target/loongarch/cpu.c       |  4 ++--
 target/loongarch/translate.c |  2 +-
 tcg/optimize.c               |  8 ++++----
 7 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 3ce5f6507b..bf26fadb06 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -1,29 +1,29 @@
 /*
  * QEMU PipeWire audio driver
  *
  * Copyright (c) 2023 Red Hat Inc.
  *
  * Author: Dorinda Bassey       <dbassey@redhat.com>
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#include <spa/param/audio/format-utils.h>
+#include <spa/utils/ringbuffer.h>
+#include <spa/utils/result.h>
+#include <spa/param/props.h>
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "audio.h"
 #include <errno.h>
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include <spa/param/audio/format-utils.h>
-#include <spa/utils/ringbuffer.h>
-#include <spa/utils/result.h>
-#include <spa/param/props.h>
 
 #include <pipewire/pipewire.h>
 #include "trace.h"
 
 #define AUDIO_CAP "pipewire"
 #define RINGBUFFER_SIZE    (1u << 22)
 #define RINGBUFFER_MASK    (RINGBUFFER_SIZE - 1)
 
 #include "audio_int.h"
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 6f2b2bd45f..545d82ff04 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1166,210 +1166,210 @@ smmuv3_invalidate_ste(gpointer key, gpointer value, gpointer user_data)
 static int smmuv3_cmdq_consume(SMMUv3State *s)
 {
     SMMUState *bs = ARM_SMMU(s);
     SMMUCmdError cmd_error = SMMU_CERROR_NONE;
     SMMUQueue *q = &s->cmdq;
     SMMUCommandType type = 0;
 
     if (!smmuv3_cmdq_enabled(s)) {
         return 0;
     }
     /*
      * some commands depend on register values, typically CR0. In case those
      * register values change while handling the command, spec says it
      * is UNPREDICTABLE whether the command is interpreted under the new
      * or old value.
      */
 
     while (!smmuv3_q_empty(q)) {
         uint32_t pending = s->gerror ^ s->gerrorn;
         Cmd cmd;
 
         trace_smmuv3_cmdq_consume(Q_PROD(q), Q_CONS(q),
                                   Q_PROD_WRAP(q), Q_CONS_WRAP(q));
 
         if (FIELD_EX32(pending, GERROR, CMDQ_ERR)) {
             break;
         }
 
         if (queue_read(q, &cmd) != MEMTX_OK) {
             cmd_error = SMMU_CERROR_ABT;
             break;
         }
 
         type = CMD_TYPE(&cmd);
 
         trace_smmuv3_cmdq_opcode(smmu_cmd_string(type));
 
         qemu_mutex_lock(&s->mutex);
         switch (type) {
         case SMMU_CMD_SYNC:
             if (CMD_SYNC_CS(&cmd) & CMD_SYNC_SIG_IRQ) {
                 smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0);
             }
             break;
         case SMMU_CMD_PREFETCH_CONFIG:
         case SMMU_CMD_PREFETCH_ADDR:
             break;
         case SMMU_CMD_CFGI_STE:
         {
             uint32_t sid = CMD_SID(&cmd);
             IOMMUMemoryRegion *mr = smmu_iommu_mr(bs, sid);
             SMMUDevice *sdev;
 
             if (CMD_SSEC(&cmd)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
 
             if (!mr) {
                 break;
             }
 
             trace_smmuv3_cmdq_cfgi_ste(sid);
             sdev = container_of(mr, SMMUDevice, iommu);
             smmuv3_flush_config(sdev);
 
             break;
         }
         case SMMU_CMD_CFGI_STE_RANGE: /* same as SMMU_CMD_CFGI_ALL */
         {
             uint32_t sid = CMD_SID(&cmd), mask;
             uint8_t range = CMD_STE_RANGE(&cmd);
             SMMUSIDRange sid_range;
 
             if (CMD_SSEC(&cmd)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
 
             mask = (1ULL << (range + 1)) - 1;
             sid_range.start = sid & ~mask;
             sid_range.end = sid_range.start + mask;
 
             trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
             g_hash_table_foreach_remove(bs->configs, smmuv3_invalidate_ste,
                                         &sid_range);
             break;
         }
         case SMMU_CMD_CFGI_CD:
         case SMMU_CMD_CFGI_CD_ALL:
         {
             uint32_t sid = CMD_SID(&cmd);
             IOMMUMemoryRegion *mr = smmu_iommu_mr(bs, sid);
             SMMUDevice *sdev;
 
             if (CMD_SSEC(&cmd)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
 
             if (!mr) {
                 break;
             }
 
             trace_smmuv3_cmdq_cfgi_cd(sid);
             sdev = container_of(mr, SMMUDevice, iommu);
             smmuv3_flush_config(sdev);
             break;
         }
         case SMMU_CMD_TLBI_NH_ASID:
         {
             uint16_t asid = CMD_ASID(&cmd);
 
             if (!STAGE1_SUPPORTED(s)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
 
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_asid(bs, asid);
             break;
         }
         case SMMU_CMD_TLBI_NH_ALL:
             if (!STAGE1_SUPPORTED(s)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-            QEMU_FALLTHROUGH;
+            fallthrough;
         case SMMU_CMD_TLBI_NSNH_ALL:
             trace_smmuv3_cmdq_tlbi_nh();
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_all(bs);
             break;
         case SMMU_CMD_TLBI_NH_VAA:
         case SMMU_CMD_TLBI_NH_VA:
             if (!STAGE1_SUPPORTED(s)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
             smmuv3_range_inval(bs, &cmd);
             break;
         case SMMU_CMD_TLBI_S12_VMALL:
         {
             uint16_t vmid = CMD_VMID(&cmd);
 
             if (!STAGE2_SUPPORTED(s)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
 
             trace_smmuv3_cmdq_tlbi_s12_vmid(vmid);
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_vmid(bs, vmid);
             break;
         }
         case SMMU_CMD_TLBI_S2_IPA:
             if (!STAGE2_SUPPORTED(s)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
             /*
              * As currently only either s1 or s2 are supported
              * we can reuse same function for s2.
              */
             smmuv3_range_inval(bs, &cmd);
             break;
         case SMMU_CMD_TLBI_EL3_ALL:
         case SMMU_CMD_TLBI_EL3_VA:
         case SMMU_CMD_TLBI_EL2_ALL:
         case SMMU_CMD_TLBI_EL2_ASID:
         case SMMU_CMD_TLBI_EL2_VA:
         case SMMU_CMD_TLBI_EL2_VAA:
         case SMMU_CMD_ATC_INV:
         case SMMU_CMD_PRI_RESP:
         case SMMU_CMD_RESUME:
         case SMMU_CMD_STALL_TERM:
             trace_smmuv3_unhandled_cmd(type);
             break;
         default:
             cmd_error = SMMU_CERROR_ILL;
             break;
         }
         qemu_mutex_unlock(&s->mutex);
         if (cmd_error) {
             if (cmd_error == SMMU_CERROR_ILL) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "Illegal command type: %d\n", CMD_TYPE(&cmd));
             }
             break;
         }
         /*
          * We only increment the cons index after the completion of
          * the command. We do that because the SYNC returns immediately
          * and does not check the completion of previous commands
          */
         queue_cons_incr(q);
     }
 
     if (cmd_error) {
         trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
         smmu_write_cmdq_err(s, cmd_error);
         smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
     }
 
     trace_smmuv3_cmdq_consume_out(Q_PROD(q), Q_CONS(q),
                                   Q_PROD_WRAP(q), Q_CONS_WRAP(q));
 
     return 0;
 }
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 1109482a00..959982805d 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -1,215 +1,231 @@
 /* compiler.h: macros to abstract away compiler specifics
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
 
 #ifndef COMPILER_H
 #define COMPILER_H
 
 #define HOST_BIG_ENDIAN (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)
 
 /* HOST_LONG_BITS is the size of a native pointer in bits. */
 #define HOST_LONG_BITS (__SIZEOF_POINTER__ * 8)
 
 #if defined __clang_analyzer__ || defined __COVERITY__
 #define QEMU_STATIC_ANALYSIS 1
 #endif
 
 #ifdef __cplusplus
 #define QEMU_EXTERN_C extern "C"
 #else
 #define QEMU_EXTERN_C extern
 #endif
 
 #if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
 # define QEMU_PACKED __attribute__((gcc_struct, packed))
 #else
 # define QEMU_PACKED __attribute__((packed))
 #endif
 
 #define QEMU_ALIGNED(X) __attribute__((aligned(X)))
 
 #ifndef glue
 #define xglue(x, y) x ## y
 #define glue(x, y) xglue(x, y)
 #define stringify(s) tostring(s)
 #define tostring(s) #s
 #endif
 
 /* Expands into an identifier stemN, where N is another number each time */
 #define MAKE_IDENTFIER(stem) glue(stem, __COUNTER__)
 
 #ifndef likely
 #define likely(x)   __builtin_expect(!!(x), 1)
 #define unlikely(x)   __builtin_expect(!!(x), 0)
 #endif
 
 #ifndef container_of
 #define container_of(ptr, type, member) ({                      \
         const typeof(((type *) 0)->member) *__mptr = (ptr);     \
         (type *) ((char *) __mptr - offsetof(type, member));})
 #endif
 
 #define sizeof_field(type, field) sizeof(((type *)0)->field)
 
 /*
  * Calculate the number of bytes up to and including the given 'field' of
  * 'container'.
  */
 #define endof(container, field) \
     (offsetof(container, field) + sizeof_field(container, field))
 
 /* Convert from a base type to a parent type, with compile time checking.  */
 #define DO_UPCAST(type, field, dev) ( __extension__ ( { \
     char __attribute__((unused)) offset_must_be_zero[ \
         -offsetof(type, field)]; \
     container_of(dev, type, field);}))
 
 #define typeof_field(type, field) typeof(((type *)0)->field)
 #define type_check(t1,t2) ((t1*)0 - (t2*)0)
 
 #define QEMU_BUILD_BUG_ON_STRUCT(x) \
     struct { \
         int:(x) ? -1 : 1; \
     }
 
 #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
 
 #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
 
 #define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)) - \
                                    sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)))
 
 #if !defined(__clang__) && defined(_WIN32)
 /*
  * Map __printf__ to __gnu_printf__ because we want standard format strings even
  * when MinGW or GLib include files use __printf__.
  */
 # define __printf__ __gnu_printf__
 #endif
 
 #ifndef __has_warning
 #define __has_warning(x) 0 /* compatibility with non-clang compilers */
 #endif
 
 #ifndef __has_feature
 #define __has_feature(x) 0 /* compatibility with non-clang compilers */
 #endif
 
 #ifndef __has_builtin
 #define __has_builtin(x) 0 /* compatibility with non-clang compilers */
 #endif
 
 #if __has_builtin(__builtin_assume_aligned) || !defined(__clang__)
 #define HAS_ASSUME_ALIGNED
 #endif
 
 #ifndef __has_attribute
 #define __has_attribute(x) 0 /* compatibility with older GCC */
 #endif
 
 #if defined(__SANITIZE_ADDRESS__) || __has_feature(address_sanitizer)
 # define QEMU_SANITIZE_ADDRESS 1
 #endif
 
 #if defined(__SANITIZE_THREAD__) || __has_feature(thread_sanitizer)
 # define QEMU_SANITIZE_THREAD 1
 #endif
 
 /*
  * GCC doesn't provide __has_attribute() until GCC 5, but we know all the GCC
  * versions we support have the "flatten" attribute. Clang may not have the
  * "flatten" attribute but always has __has_attribute() to check for it.
  */
 #if __has_attribute(flatten) || !defined(__clang__)
 # define QEMU_FLATTEN __attribute__((flatten))
 #else
 # define QEMU_FLATTEN
 #endif
 
 /*
  * If __attribute__((error)) is present, use it to produce an error at
  * compile time.  Otherwise, one must wait for the linker to diagnose
  * the missing symbol.
  */
 #if __has_attribute(error)
 # define QEMU_ERROR(X) __attribute__((error(X)))
 #else
 # define QEMU_ERROR(X)
 #endif
 
 /*
  * The nonstring variable attribute specifies that an object or member
  * declaration with type array of char or pointer to char is intended
  * to store character arrays that do not necessarily contain a terminating
  * NUL character. This is useful in detecting uses of such arrays or pointers
  * with functions that expect NUL-terminated strings, and to avoid warnings
  * when such an array or pointer is used as an argument to a bounded string
  * manipulation function such as strncpy.
  */
 #if __has_attribute(nonstring)
 # define QEMU_NONSTRING __attribute__((nonstring))
 #else
 # define QEMU_NONSTRING
 #endif
 
 /*
  * Forced inlining may be desired to encourage constant propagation
  * of function parameters.  However, it can also make debugging harder,
  * so disable it for a non-optimizing build.
  */
 #if defined(__OPTIMIZE__)
 #define QEMU_ALWAYS_INLINE  __attribute__((always_inline))
 #else
 #define QEMU_ALWAYS_INLINE
 #endif
 
-/**
- * In most cases, normal "fallthrough" comments are good enough for
- * switch-case statements, but sometimes the compiler has problems
- * with those. In that case you can use QEMU_FALLTHROUGH instead.
+/*
+ * Add the pseudo keyword 'fallthrough' so case statement blocks
+ * must end with any of these keywords:
+ *   break;
+ *   fallthrough;
+ *   continue;
+ *   goto <label>;
+ *   return [expression];
+ *
+ *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
  */
-#if __has_attribute(fallthrough)
-# define QEMU_FALLTHROUGH __attribute__((fallthrough))
+
+/*
+ * glib_macros.h contains its own definition of fallthrough, so if we define
+ * the pseudokeyword here it will expand when the glib header checks for the
+ * attribute. glib headers must be #included after this header.
+ */
+#ifdef fallthrough
+#undef fallthrough
+#endif
+
+#if __has_attribute(__fallthrough__)
+# define fallthrough                    __attribute__((__fallthrough__))
 #else
-# define QEMU_FALLTHROUGH do {} while (0) /* fallthrough */
+# define fallthrough                    do {} while (0)  /* fallthrough */
 #endif
 
 #ifdef CONFIG_CFI
 /*
  * If CFI is enabled, use an attribute to disable cfi-icall on the following
  * function
  */
 #define QEMU_DISABLE_CFI __attribute__((no_sanitize("cfi-icall")))
 #else
 /* If CFI is not enabled, use an empty define to not change the behavior */
 #define QEMU_DISABLE_CFI
 #endif
 
 /*
  * Apple clang version 14 has a bug in its __builtin_subcll(); define
  * BUILTIN_SUBCLL_BROKEN for the offending versions so we can avoid it.
  * When a version of Apple clang which has this bug fixed is released
  * we can add an upper bound to this check.
  * See https://gitlab.com/qemu-project/qemu/-/issues/1631
  * and https://gitlab.com/qemu-project/qemu/-/issues/1659 for details.
  * The bug never made it into any upstream LLVM releases, only Apple ones.
  */
 #if defined(__apple_build_version__) && __clang_major__ >= 14
 #define BUILTIN_SUBCLL_BROKEN
 #endif
 
 #if __has_attribute(annotate)
 #define QEMU_ANNOTATE(x) __attribute__((annotate(x)))
 #else
 #define QEMU_ANNOTATE(x)
 #endif
 
 #if __has_attribute(used)
 # define QEMU_USED __attribute__((used))
 #else
 # define QEMU_USED
 #endif
 
 #endif /* COMPILER_H */
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 475a1c62ff..8f790f0deb 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -1,171 +1,171 @@
 /*
  * OS includes and handling of OS dependencies
  *
  * This header exists to pull in some common system headers that
  * most code in QEMU will want, and to fix up some possible issues with
  * it (missing defines, Windows weirdness, and so on).
  *
  * To avoid getting into possible circular include dependencies, this
  * file should not include any other QEMU headers, with the exceptions
  * of config-host.h, config-target.h, qemu/compiler.h,
  * sysemu/os-posix.h, sysemu/os-win32.h, glib-compat.h and
  * qemu/typedefs.h, all of which are doing a similar job to this file
  * and are under similar constraints.
  *
  * This header also contains prototypes for functions defined in
  * os-*.c and util/oslib-*.c; those would probably be better split
  * out into separate header files.
  *
  * In an ideal world this header would contain only:
  *  (1) things which everybody needs
  *  (2) things without which code would work on most platforms but
  *      fail to compile or misbehave on a minority of host OSes
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
 #ifndef QEMU_OSDEP_H
 #define QEMU_OSDEP_H
 
 #if !defined _FORTIFY_SOURCE && defined __OPTIMIZE__ && __OPTIMIZE__ && defined __linux__
 # define _FORTIFY_SOURCE 2
 #endif
 
 #include "config-host.h"
 #ifdef NEED_CPU_H
 #include CONFIG_TARGET
 #else
 #include "exec/poison.h"
 #endif
 
 /*
  * HOST_WORDS_BIGENDIAN was replaced with HOST_BIG_ENDIAN. Prevent it from
  * creeping back in.
  */
 #pragma GCC poison HOST_WORDS_BIGENDIAN
 
 /*
  * TARGET_WORDS_BIGENDIAN was replaced with TARGET_BIG_ENDIAN. Prevent it from
  * creeping back in.
  */
 #pragma GCC poison TARGET_WORDS_BIGENDIAN
 
-#include "qemu/compiler.h"
-
 /* Older versions of C++ don't get definitions of various macros from
  * stdlib.h unless we define these macros before first inclusion of
  * that system header.
  */
 #ifndef __STDC_CONSTANT_MACROS
 #define __STDC_CONSTANT_MACROS
 #endif
 #ifndef __STDC_LIMIT_MACROS
 #define __STDC_LIMIT_MACROS
 #endif
 #ifndef __STDC_FORMAT_MACROS
 #define __STDC_FORMAT_MACROS
 #endif
 
 /* The following block of code temporarily renames the daemon() function so the
  * compiler does not see the warning associated with it in stdlib.h on OSX
  */
 #ifdef __APPLE__
 #define daemon qemu_fake_daemon_function
 #include <stdlib.h>
 #undef daemon
 QEMU_EXTERN_C int daemon(int, int);
 #endif
 
 #ifdef _WIN32
 /* as defined in sdkddkver.h */
 #ifndef _WIN32_WINNT
 #define _WIN32_WINNT 0x0602 /* Windows 8 API (should be >= the one from glib) */
 #endif
 /* reduces the number of implicitly included headers */
 #ifndef WIN32_LEAN_AND_MEAN
 #define WIN32_LEAN_AND_MEAN
 #endif
 #endif
 
 /* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
 #ifdef __MINGW32__
 #define __USE_MINGW_ANSI_STDIO 1
 #endif
 
 /*
  * We need the FreeBSD "legacy" definitions. Rust needs the FreeBSD 11 system
  * calls since it doesn't use libc at all, so we have to emulate that despite
  * FreeBSD 11 being EOL'd.
  */
 #ifdef __FreeBSD__
 #define _WANT_FREEBSD11_STAT
 #define _WANT_FREEBSD11_STATFS
 #define _WANT_FREEBSD11_DIRENT
 #define _WANT_KERNEL_ERRNO
 #define _WANT_SEMUN
 #endif
 
 #include <stdarg.h>
 #include <stddef.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <sys/types.h>
 #include <stdlib.h>
 #include <stdio.h>
 
 #include <string.h>
 #include <strings.h>
 #include <inttypes.h>
 #include <limits.h>
 /* Put unistd.h before time.h as that triggers localtime_r/gmtime_r
  * function availability on recentish Mingw-w64 platforms. */
 #include <unistd.h>
 #include <time.h>
 #include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <getopt.h>
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <assert.h>
 /* setjmp must be declared before sysemu/os-win32.h
  * because it is redefined there. */
 #include <setjmp.h>
 #include <signal.h>
 
 #ifdef CONFIG_IOVEC
 #include <sys/uio.h>
 #endif
 
 #if defined(__linux__) && defined(__sparc__)
 /* The SPARC definition of QEMU_VMALLOC_ALIGN needs SHMLBA */
 #include <sys/shm.h>
 #endif
 
 #ifndef _WIN32
 #include <sys/wait.h>
 #else
 #define WIFEXITED(x)   1
 #define WEXITSTATUS(x) (x)
 #endif
 
 #ifdef __APPLE__
 #include <AvailabilityMacros.h>
 #endif
 
 /*
  * This is somewhat like a system header; it must be outside any extern "C"
  * block because it includes system headers itself, including glib.h,
  * which will not compile if inside an extern "C" block.
  */
 #include "glib-compat.h"
 
+#include "qemu/compiler.h"
+
 #ifdef _WIN32
 #include "sysemu/os-win32.h"
 #endif
 
 #ifdef CONFIG_POSIX
 #include "sysemu/os-posix.h"
 #endif
 
 #ifdef __cplusplus
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 2bea7ca5d5..e01d626b15 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -142,145 +142,145 @@ static inline bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
 static void loongarch_cpu_do_interrupt(CPUState *cs)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
     CPULoongArchState *env = &cpu->env;
     bool update_badinstr = 1;
     int cause = -1;
     const char *name;
     bool tlbfill = FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
     uint32_t vec_size = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, VS);
 
     if (cs->exception_index != EXCCODE_INT) {
         if (cs->exception_index < 0 ||
             cs->exception_index >= ARRAY_SIZE(excp_names)) {
             name = "unknown";
         } else {
             name = excp_names[cs->exception_index];
         }
 
         qemu_log_mask(CPU_LOG_INT,
                      "%s enter: pc " TARGET_FMT_lx " ERA " TARGET_FMT_lx
                      " TLBRERA " TARGET_FMT_lx " %s exception\n", __func__,
                      env->pc, env->CSR_ERA, env->CSR_TLBRERA, name);
     }
 
     switch (cs->exception_index) {
     case EXCCODE_DBP:
         env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DCL, 1);
         env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, ECODE, 0xC);
         goto set_DERA;
     set_DERA:
         env->CSR_DERA = env->pc;
         env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DST, 1);
         set_pc(env, env->CSR_EENTRY + 0x480);
         break;
     case EXCCODE_INT:
         if (FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)) {
             env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DEI, 1);
             goto set_DERA;
         }
-        QEMU_FALLTHROUGH;
+        fallthrough;
     case EXCCODE_PIF:
     case EXCCODE_ADEF:
         cause = cs->exception_index;
         update_badinstr = 0;
         break;
     case EXCCODE_SYS:
     case EXCCODE_BRK:
     case EXCCODE_INE:
     case EXCCODE_IPE:
     case EXCCODE_FPD:
     case EXCCODE_FPE:
     case EXCCODE_SXD:
     case EXCCODE_ASXD:
         env->CSR_BADV = env->pc;
-        QEMU_FALLTHROUGH;
+        fallthrough;
     case EXCCODE_BCE:
     case EXCCODE_ADEM:
     case EXCCODE_PIL:
     case EXCCODE_PIS:
     case EXCCODE_PME:
     case EXCCODE_PNR:
     case EXCCODE_PNX:
     case EXCCODE_PPI:
         cause = cs->exception_index;
         break;
     default:
         qemu_log("Error: exception(%d) has not been supported\n",
                  cs->exception_index);
         abort();
     }
 
     if (update_badinstr) {
         env->CSR_BADI = cpu_ldl_code(env, env->pc);
     }
 
     /* Save PLV and IE */
     if (tlbfill) {
         env->CSR_TLBRPRMD = FIELD_DP64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV,
                                        FIELD_EX64(env->CSR_CRMD,
                                        CSR_CRMD, PLV));
         env->CSR_TLBRPRMD = FIELD_DP64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PIE,
                                        FIELD_EX64(env->CSR_CRMD, CSR_CRMD, IE));
         /* set the DA mode */
         env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DA, 1);
         env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 0);
         env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA,
                                       PC, (env->pc >> 2));
     } else {
         env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, ECODE,
                                     EXCODE_MCODE(cause));
         env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, ESUBCODE,
                                     EXCODE_SUBCODE(cause));
         env->CSR_PRMD = FIELD_DP64(env->CSR_PRMD, CSR_PRMD, PPLV,
                                    FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV));
         env->CSR_PRMD = FIELD_DP64(env->CSR_PRMD, CSR_PRMD, PIE,
                                    FIELD_EX64(env->CSR_CRMD, CSR_CRMD, IE));
         env->CSR_ERA = env->pc;
     }
 
     env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PLV, 0);
     env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, IE, 0);
 
     if (vec_size) {
         vec_size = (1 << vec_size) * 4;
     }
 
     if  (cs->exception_index == EXCCODE_INT) {
         /* Interrupt */
         uint32_t vector = 0;
         uint32_t pending = FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS);
         pending &= FIELD_EX64(env->CSR_ECFG, CSR_ECFG, LIE);
 
         /* Find the highest-priority interrupt. */
         vector = 31 - clz32(pending);
         set_pc(env, env->CSR_EENTRY + \
                (EXCCODE_EXTERNAL_INT + vector) * vec_size);
         qemu_log_mask(CPU_LOG_INT,
                       "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
                       " cause %d\n" "    A " TARGET_FMT_lx " D "
                       TARGET_FMT_lx " vector = %d ExC " TARGET_FMT_lx "ExS"
                       TARGET_FMT_lx "\n",
                       __func__, env->pc, env->CSR_ERA,
                       cause, env->CSR_BADV, env->CSR_DERA, vector,
                       env->CSR_ECFG, env->CSR_ESTAT);
     } else {
         if (tlbfill) {
             set_pc(env, env->CSR_TLBRENTRY);
         } else {
             set_pc(env, env->CSR_EENTRY + EXCODE_MCODE(cause) * vec_size);
         }
         qemu_log_mask(CPU_LOG_INT,
                       "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
                       " cause %d%s\n, ESTAT " TARGET_FMT_lx
                       " EXCFG " TARGET_FMT_lx " BADVA " TARGET_FMT_lx
                       "BADI " TARGET_FMT_lx " SYS_NUM " TARGET_FMT_lu
                       " cpu %d asid " TARGET_FMT_lx "\n", __func__, env->pc,
                       tlbfill ? env->CSR_TLBRERA : env->CSR_ERA,
                       cause, tlbfill ? "(refill)" : "", env->CSR_ESTAT,
                       env->CSR_ECFG,
                       tlbfill ? env->CSR_TLBRBADV : env->CSR_BADV,
                       env->CSR_BADI, env->gpr[11], cs->cpu_index,
                       env->CSR_ASID);
     }
     cs->exception_index = -1;
 }
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 21f4db6fbd..36fceb1beb 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -304,24 +304,24 @@ static void loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 static void loongarch_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     switch (ctx->base.is_jmp) {
     case DISAS_STOP:
         tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
         tcg_gen_lookup_and_goto_ptr();
         break;
     case DISAS_TOO_MANY:
         gen_goto_tb(ctx, 0, ctx->base.pc_next);
         break;
     case DISAS_NORETURN:
         break;
     case DISAS_EXIT_UPDATE:
         tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
-        QEMU_FALLTHROUGH;
+        fallthrough;
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
     default:
         g_assert_not_reached();
     }
 }
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3013eb04e6..3da135a353 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1062,81 +1062,81 @@ static bool fold_brcond(OptContext *ctx, TCGOp *op)
 static bool fold_brcond2(OptContext *ctx, TCGOp *op)
 {
     TCGCond cond = op->args[4];
     TCGArg label = op->args[5];
     int i, inv = 0;
 
     if (swap_commutative2(&op->args[0], &op->args[2])) {
         op->args[4] = cond = tcg_swap_cond(cond);
     }
 
     i = do_constant_folding_cond2(&op->args[0], &op->args[2], cond);
     if (i >= 0) {
         goto do_brcond_const;
     }
 
     switch (cond) {
     case TCG_COND_LT:
     case TCG_COND_GE:
         /*
          * Simplify LT/GE comparisons vs zero to a single compare
          * vs the high word of the input.
          */
         if (arg_is_const(op->args[2]) && arg_info(op->args[2])->val == 0 &&
             arg_is_const(op->args[3]) && arg_info(op->args[3])->val == 0) {
             goto do_brcond_high;
         }
         break;
 
     case TCG_COND_NE:
         inv = 1;
-        QEMU_FALLTHROUGH;
+        fallthrough;
     case TCG_COND_EQ:
         /*
          * Simplify EQ/NE comparisons where one of the pairs
          * can be simplified.
          */
         i = do_constant_folding_cond(TCG_TYPE_I32, op->args[0],
                                      op->args[2], cond);
         switch (i ^ inv) {
         case 0:
             goto do_brcond_const;
         case 1:
             goto do_brcond_high;
         }
 
         i = do_constant_folding_cond(TCG_TYPE_I32, op->args[1],
                                      op->args[3], cond);
         switch (i ^ inv) {
         case 0:
             goto do_brcond_const;
         case 1:
             op->opc = INDEX_op_brcond_i32;
             op->args[1] = op->args[2];
             op->args[2] = cond;
             op->args[3] = label;
             break;
         }
         break;
 
     default:
         break;
 
     do_brcond_high:
         op->opc = INDEX_op_brcond_i32;
         op->args[0] = op->args[1];
         op->args[1] = op->args[3];
         op->args[2] = cond;
         op->args[3] = label;
         break;
 
     do_brcond_const:
         if (i == 0) {
             tcg_op_remove(ctx->tcg, op);
             return true;
         }
         op->opc = INDEX_op_br;
         op->args[0] = label;
         break;
     }
     return false;
 }
@@ -1424,46 +1424,46 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
 static bool fold_exts(OptContext *ctx, TCGOp *op)
 {
     uint64_t s_mask_old, s_mask, z_mask, sign;
     bool type_change = false;
 
     if (fold_const1(ctx, op)) {
         return true;
     }
 
     z_mask = arg_info(op->args[1])->z_mask;
     s_mask = arg_info(op->args[1])->s_mask;
     s_mask_old = s_mask;
 
     switch (op->opc) {
     CASE_OP_32_64(ext8s):
         sign = INT8_MIN;
         z_mask = (uint8_t)z_mask;
         break;
     CASE_OP_32_64(ext16s):
         sign = INT16_MIN;
         z_mask = (uint16_t)z_mask;
         break;
     case INDEX_op_ext_i32_i64:
         type_change = true;
-        QEMU_FALLTHROUGH;
+        fallthrough;
     case INDEX_op_ext32s_i64:
         sign = INT32_MIN;
         z_mask = (uint32_t)z_mask;
         break;
     default:
         g_assert_not_reached();
     }
 
     if (z_mask & sign) {
         z_mask |= sign;
     }
     s_mask |= sign << 1;
 
     ctx->z_mask = z_mask;
     ctx->s_mask = s_mask;
     if (!type_change) {
         ctx->a_mask = s_mask & ~s_mask_old;
     }
 
     return fold_masks(ctx, op);
 }
@@ -1471,40 +1471,40 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
 static bool fold_extu(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask_old, z_mask;
     bool type_change = false;
 
     if (fold_const1(ctx, op)) {
         return true;
     }
 
     z_mask_old = z_mask = arg_info(op->args[1])->z_mask;
 
     switch (op->opc) {
     CASE_OP_32_64(ext8u):
         z_mask = (uint8_t)z_mask;
         break;
     CASE_OP_32_64(ext16u):
         z_mask = (uint16_t)z_mask;
         break;
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extu_i32_i64:
         type_change = true;
-        QEMU_FALLTHROUGH;
+        fallthrough;
     case INDEX_op_ext32u_i64:
         z_mask = (uint32_t)z_mask;
         break;
     case INDEX_op_extrh_i64_i32:
         type_change = true;
         z_mask >>= 32;
         break;
     default:
         g_assert_not_reached();
     }
 
     ctx->z_mask = z_mask;
     ctx->s_mask = smask_from_zmask(z_mask);
     if (!type_change) {
         ctx->a_mask = z_mask_old ^ z_mask;
     }
     return fold_masks(ctx, op);
 }
@@ -1835,75 +1835,75 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
 static bool fold_setcond2(OptContext *ctx, TCGOp *op)
 {
     TCGCond cond = op->args[5];
     int i, inv = 0;
 
     if (swap_commutative2(&op->args[1], &op->args[3])) {
         op->args[5] = cond = tcg_swap_cond(cond);
     }
 
     i = do_constant_folding_cond2(&op->args[1], &op->args[3], cond);
     if (i >= 0) {
         goto do_setcond_const;
     }
 
     switch (cond) {
     case TCG_COND_LT:
     case TCG_COND_GE:
         /*
          * Simplify LT/GE comparisons vs zero to a single compare
          * vs the high word of the input.
          */
         if (arg_is_const(op->args[3]) && arg_info(op->args[3])->val == 0 &&
             arg_is_const(op->args[4]) && arg_info(op->args[4])->val == 0) {
             goto do_setcond_high;
         }
         break;
 
     case TCG_COND_NE:
         inv = 1;
-        QEMU_FALLTHROUGH;
+        fallthrough;
     case TCG_COND_EQ:
         /*
          * Simplify EQ/NE comparisons where one of the pairs
          * can be simplified.
          */
         i = do_constant_folding_cond(TCG_TYPE_I32, op->args[1],
                                      op->args[3], cond);
         switch (i ^ inv) {
         case 0:
             goto do_setcond_const;
         case 1:
             goto do_setcond_high;
         }
 
         i = do_constant_folding_cond(TCG_TYPE_I32, op->args[2],
                                      op->args[4], cond);
         switch (i ^ inv) {
         case 0:
             goto do_setcond_const;
         case 1:
             op->args[2] = op->args[3];
             op->args[3] = cond;
             op->opc = INDEX_op_setcond_i32;
             break;
         }
         break;
 
     default:
         break;
 
     do_setcond_high:
         op->args[1] = op->args[2];
         op->args[2] = op->args[4];
         op->args[3] = cond;
         op->opc = INDEX_op_setcond_i32;
         break;
     }
 
     ctx->z_mask = 1;
     ctx->s_mask = smask_from_zmask(1);
     return false;
 
  do_setcond_const:
     return tcg_opt_gen_movi(ctx, op, op->args[0], i);
 }
-- 
2.39.2


