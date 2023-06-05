Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1F6723127
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:21:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gd1-00020q-EP; Mon, 05 Jun 2023 16:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gco-0001wu-Dt
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:23 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gci-000431-TK
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:22 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-53f7bef98b7so4665074a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996175; x=1688588175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFVirlGNKOWg4+0ZpaYGnVk22AFhf0D/xfLqVNc1goc=;
 b=UKBzzq+68Eh9LXMuxRLI4jpSB5uG6EUUVPJ66GzFKi11XNwnzX69Lfy+PprwqpfUeC
 zHdYfLIIlG7MWhInZgO7ZKp+HV+oUN0NcOC8tlf2hPkUdikAMYZlIwmmt6dweKU05xKF
 9cWt2la8WvNDBqFVPee3ZJO8BQ29AnUKT+udFLZD9K8YtQw464y+FdLH/u6EzWMnavO8
 VVyaO1ukBvFElLGf5A3HRQU7wJDdXK/wZVBBiX68RYcf3QaJVkvnghWXiq/nZ1iqYCmF
 W/pnMqp6r65umOrX3AoftKvIBjHoMxkegJRnMzSY7lnvex3gjh8TZj9e6Hrt29bIo4z+
 JiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996175; x=1688588175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LFVirlGNKOWg4+0ZpaYGnVk22AFhf0D/xfLqVNc1goc=;
 b=FXlUVS3DydE8X01N+TkBP5bX1wpY+jT6YycOMn5yOq0KKw/vJbkgUT5FT/I5J2jOMK
 el+NbHq+ODXco+g0DWJPSD1yLTNfZg1EvCmAp+CLfvNUNSijXjMzSJsIPH/iK8dbncz+
 wBoP4pWHcwc8diK7cging4RYRgkJ8yY3p9gordGf06unqhjj33RsaEPKYfKkowBsKYyJ
 Rq0KjajgKVKh+Zhob4C5xDg+PKEr/7Ds3tAA/uhY2THJoihl/tZ17VjnV0pblYpi0ghw
 6ZLxK1Lv51AXoskdr2g06oDPCzQzQQCe6irJ1K/yHMY14/L1QZoajJxkZgA9XhvEi6xM
 BYgQ==
X-Gm-Message-State: AC+VfDxKLoYw7Y80PdUjI059GjduylohScslIfcMcoQ1qi/gtJXtRy5P
 v4vVieC15LorTul77n1EP6UjZ9EcE1ePOJVkqyY=
X-Google-Smtp-Source: ACHHUZ4uKhAZKV4sG7rZXDm+Kkh7JnujHIWLml6ncGM1BVaTfLZngsaKo6kRT/sR48CT+gq/JNfqHw==
X-Received: by 2002:a05:6a20:12c6:b0:10c:467a:536f with SMTP id
 v6-20020a056a2012c600b0010c467a536fmr204118pzg.14.1685996174977; 
 Mon, 05 Jun 2023 13:16:14 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/52] tcg: Split tcg/tcg-op-gvec.h
Date: Mon,  5 Jun 2023 13:15:25 -0700
Message-Id: <20230605201548.1596865-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Create tcg/tcg-op-gvec-common.h, moving everything that does not
concern TARGET_LONG_BITS.  Adjust tcg-op-gvec.c to use the new header.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec-common.h | 426 +++++++++++++++++++++++++++++
 include/tcg/tcg-op-gvec.h        | 444 +------------------------------
 tcg/tcg-op-gvec.c                |   2 +-
 3 files changed, 437 insertions(+), 435 deletions(-)
 create mode 100644 include/tcg/tcg-op-gvec-common.h

diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
new file mode 100644
index 0000000000..e2683d487f
--- /dev/null
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -0,0 +1,426 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Target independent generic vector operation expansion
+ *
+ * Copyright (c) 2018 Linaro
+ */
+
+#ifndef TCG_TCG_OP_GVEC_COMMON_H
+#define TCG_TCG_OP_GVEC_COMMON_H
+
+/*
+ * "Generic" vectors.  All operands are given as offsets from ENV,
+ * and therefore cannot also be allocated via tcg_global_mem_new_*.
+ * OPRSZ is the byte size of the vector upon which the operation is performed.
+ * MAXSZ is the byte size of the full vector; bytes beyond OPSZ are cleared.
+ *
+ * All sizes must be 8 or any multiple of 16.
+ * When OPRSZ is 8, the alignment may be 8, otherwise must be 16.
+ * Operands may completely, but not partially, overlap.
+ */
+
+/* Expand a call to a gvec-style helper, with pointers to two vector
+   operands, and a descriptor (see tcg-gvec-desc.h).  */
+typedef void gen_helper_gvec_2(TCGv_ptr, TCGv_ptr, TCGv_i32);
+void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
+                        uint32_t oprsz, uint32_t maxsz, int32_t data,
+                        gen_helper_gvec_2 *fn);
+
+/* Similarly, passing an extra data value.  */
+typedef void gen_helper_gvec_2i(TCGv_ptr, TCGv_ptr, TCGv_i64, TCGv_i32);
+void tcg_gen_gvec_2i_ool(uint32_t dofs, uint32_t aofs, TCGv_i64 c,
+                         uint32_t oprsz, uint32_t maxsz, int32_t data,
+                         gen_helper_gvec_2i *fn);
+
+/* Similarly, passing an extra pointer (e.g. env or float_status).  */
+typedef void gen_helper_gvec_2_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
+void tcg_gen_gvec_2_ptr(uint32_t dofs, uint32_t aofs,
+                        TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
+                        int32_t data, gen_helper_gvec_2_ptr *fn);
+
+/* Similarly, with three vector operands.  */
+typedef void gen_helper_gvec_3(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
+void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t oprsz, uint32_t maxsz, int32_t data,
+                        gen_helper_gvec_3 *fn);
+
+/* Similarly, with four vector operands.  */
+typedef void gen_helper_gvec_4(TCGv_ptr, TCGv_ptr, TCGv_ptr,
+                               TCGv_ptr, TCGv_i32);
+void tcg_gen_gvec_4_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t cofs, uint32_t oprsz, uint32_t maxsz,
+                        int32_t data, gen_helper_gvec_4 *fn);
+
+/* Similarly, with five vector operands.  */
+typedef void gen_helper_gvec_5(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
+                               TCGv_ptr, TCGv_i32);
+void tcg_gen_gvec_5_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t cofs, uint32_t xofs, uint32_t oprsz,
+                        uint32_t maxsz, int32_t data, gen_helper_gvec_5 *fn);
+
+typedef void gen_helper_gvec_3_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr,
+                                   TCGv_ptr, TCGv_i32);
+void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
+                        int32_t data, gen_helper_gvec_3_ptr *fn);
+
+typedef void gen_helper_gvec_4_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr,
+                                   TCGv_ptr, TCGv_ptr, TCGv_i32);
+void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t cofs, TCGv_ptr ptr, uint32_t oprsz,
+                        uint32_t maxsz, int32_t data,
+                        gen_helper_gvec_4_ptr *fn);
+
+typedef void gen_helper_gvec_5_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
+                                   TCGv_ptr, TCGv_ptr, TCGv_i32);
+void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t cofs, uint32_t eofs, TCGv_ptr ptr,
+                        uint32_t oprsz, uint32_t maxsz, int32_t data,
+                        gen_helper_gvec_5_ptr *fn);
+
+/* Expand a gvec operation.  Either inline or out-of-line depending on
+   the actual vector size and the operations supported by the host.  */
+typedef struct {
+    /* Expand inline as a 64-bit or 32-bit integer.
+       Only one of these will be non-NULL.  */
+    void (*fni8)(TCGv_i64, TCGv_i64);
+    void (*fni4)(TCGv_i32, TCGv_i32);
+    /* Expand inline with a host vector type.  */
+    void (*fniv)(unsigned, TCGv_vec, TCGv_vec);
+    /* Expand out-of-line helper w/descriptor.  */
+    gen_helper_gvec_2 *fno;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
+    /* The data argument to the out-of-line helper.  */
+    int32_t data;
+    /* The vector element size, if applicable.  */
+    uint8_t vece;
+    /* Prefer i64 to v64.  */
+    bool prefer_i64;
+    /* Load dest as a 2nd source operand.  */
+    bool load_dest;
+} GVecGen2;
+
+typedef struct {
+    /* Expand inline as a 64-bit or 32-bit integer.
+       Only one of these will be non-NULL.  */
+    void (*fni8)(TCGv_i64, TCGv_i64, int64_t);
+    void (*fni4)(TCGv_i32, TCGv_i32, int32_t);
+    /* Expand inline with a host vector type.  */
+    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, int64_t);
+    /* Expand out-of-line helper w/descriptor, data in descriptor.  */
+    gen_helper_gvec_2 *fno;
+    /* Expand out-of-line helper w/descriptor, data as argument.  */
+    gen_helper_gvec_2i *fnoi;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
+    /* The vector element size, if applicable.  */
+    uint8_t vece;
+    /* Prefer i64 to v64.  */
+    bool prefer_i64;
+    /* Load dest as a 3rd source operand.  */
+    bool load_dest;
+} GVecGen2i;
+
+typedef struct {
+    /* Expand inline as a 64-bit or 32-bit integer.
+       Only one of these will be non-NULL.  */
+    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64);
+    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32);
+    /* Expand inline with a host vector type.  */
+    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec);
+    /* Expand out-of-line helper w/descriptor.  */
+    gen_helper_gvec_2i *fno;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
+    /* The data argument to the out-of-line helper.  */
+    uint32_t data;
+    /* The vector element size, if applicable.  */
+    uint8_t vece;
+    /* Prefer i64 to v64.  */
+    bool prefer_i64;
+    /* Load scalar as 1st source operand.  */
+    bool scalar_first;
+} GVecGen2s;
+
+typedef struct {
+    /* Expand inline as a 64-bit or 32-bit integer.
+       Only one of these will be non-NULL.  */
+    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64);
+    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32);
+    /* Expand inline with a host vector type.  */
+    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec);
+    /* Expand out-of-line helper w/descriptor.  */
+    gen_helper_gvec_3 *fno;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
+    /* The data argument to the out-of-line helper.  */
+    int32_t data;
+    /* The vector element size, if applicable.  */
+    uint8_t vece;
+    /* Prefer i64 to v64.  */
+    bool prefer_i64;
+    /* Load dest as a 3rd source operand.  */
+    bool load_dest;
+} GVecGen3;
+
+typedef struct {
+    /*
+     * Expand inline as a 64-bit or 32-bit integer. Only one of these will be
+     * non-NULL.
+     */
+    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64, int64_t);
+    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32, int32_t);
+    /* Expand inline with a host vector type.  */
+    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, int64_t);
+    /* Expand out-of-line helper w/descriptor, data in descriptor.  */
+    gen_helper_gvec_3 *fno;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
+    /* The vector element size, if applicable.  */
+    uint8_t vece;
+    /* Prefer i64 to v64.  */
+    bool prefer_i64;
+    /* Load dest as a 3rd source operand.  */
+    bool load_dest;
+} GVecGen3i;
+
+typedef struct {
+    /* Expand inline as a 64-bit or 32-bit integer.
+       Only one of these will be non-NULL.  */
+    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64);
+    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
+    /* Expand inline with a host vector type.  */
+    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, TCGv_vec);
+    /* Expand out-of-line helper w/descriptor.  */
+    gen_helper_gvec_4 *fno;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
+    /* The data argument to the out-of-line helper.  */
+    int32_t data;
+    /* The vector element size, if applicable.  */
+    uint8_t vece;
+    /* Prefer i64 to v64.  */
+    bool prefer_i64;
+    /* Write aofs as a 2nd dest operand.  */
+    bool write_aofs;
+} GVecGen4;
+
+typedef struct {
+    /*
+     * Expand inline as a 64-bit or 32-bit integer. Only one of these will be
+     * non-NULL.
+     */
+    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64, int64_t);
+    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32, int32_t);
+    /* Expand inline with a host vector type.  */
+    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, TCGv_vec, int64_t);
+    /* Expand out-of-line helper w/descriptor, data in descriptor.  */
+    gen_helper_gvec_4 *fno;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
+    /* The vector element size, if applicable.  */
+    uint8_t vece;
+    /* Prefer i64 to v64.  */
+    bool prefer_i64;
+} GVecGen4i;
+
+void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
+                    uint32_t oprsz, uint32_t maxsz, const GVecGen2 *);
+void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
+                     uint32_t maxsz, int64_t c, const GVecGen2i *);
+void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
+                     uint32_t maxsz, TCGv_i64 c, const GVecGen2s *);
+void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                    uint32_t oprsz, uint32_t maxsz, const GVecGen3 *);
+void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                     uint32_t oprsz, uint32_t maxsz, int64_t c,
+                     const GVecGen3i *);
+void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
+                    uint32_t oprsz, uint32_t maxsz, const GVecGen4 *);
+void tcg_gen_gvec_4i(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
+                     uint32_t oprsz, uint32_t maxsz, int64_t c,
+                     const GVecGen4i *);
+
+/* Expand a specific vector operation.  */
+
+void tcg_gen_gvec_mov(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t oprsz, uint32_t maxsz);
+
+void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+
+void tcg_gen_gvec_addi(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t c, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_muli(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t c, uint32_t oprsz, uint32_t maxsz);
+
+void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_muls(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
+
+/* Saturated arithmetic.  */
+void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+
+/* Min/max.  */
+void tcg_gen_gvec_smin(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_umin(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_smax(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_umax(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+
+void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_or(unsigned vece, uint32_t dofs, uint32_t aofs,
+                     uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_nand(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_nor(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_eqv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+
+void tcg_gen_gvec_andi(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t c, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_xori(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t c, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_ori(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      int64_t c, uint32_t oprsz, uint32_t maxsz);
+
+void tcg_gen_gvec_ands(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_andcs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_xors(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_ors(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
+
+void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
+                          uint32_t s, uint32_t m);
+void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t s,
+                          uint32_t m, uint64_t imm);
+void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
+                          uint32_t m, TCGv_i32);
+void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
+                          uint32_t m, TCGv_i64);
+
+void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       int64_t shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_rotli(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_rotri(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
+
+void tcg_gen_gvec_shls(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_shrs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_sars(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_rotls(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_rotrs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
+
+/*
+ * Perform vector shift by vector element, modulo the element size.
+ * E.g.  D[i] = A[i] << (B[i] % (8 << vece)).
+ */
+void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_rotlv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_rotrv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+
+void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
+                      uint32_t aofs, uint32_t bofs,
+                      uint32_t oprsz, uint32_t maxsz);
+
+/*
+ * Perform vector bit select: d = (b & a) | (c & ~a).
+ */
+void tcg_gen_gvec_bitsel(unsigned vece, uint32_t dofs, uint32_t aofs,
+                         uint32_t bofs, uint32_t cofs,
+                         uint32_t oprsz, uint32_t maxsz);
+
+/*
+ * 64-bit vector operations.  Use these when the register has been allocated
+ * with tcg_global_mem_new_i64, and so we cannot also address it via pointer.
+ * OPRSZ = MAXSZ = 8.
+ */
+
+void tcg_gen_vec_neg8_i64(TCGv_i64 d, TCGv_i64 a);
+void tcg_gen_vec_neg16_i64(TCGv_i64 d, TCGv_i64 a);
+void tcg_gen_vec_neg32_i64(TCGv_i64 d, TCGv_i64 a);
+
+void tcg_gen_vec_add8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
+void tcg_gen_vec_add16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
+void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
+
+void tcg_gen_vec_sub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
+void tcg_gen_vec_sub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
+void tcg_gen_vec_sub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
+
+void tcg_gen_vec_shl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
+void tcg_gen_vec_shl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
+void tcg_gen_vec_shr8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
+void tcg_gen_vec_shr16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
+void tcg_gen_vec_sar8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
+void tcg_gen_vec_sar16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
+void tcg_gen_vec_rotl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c);
+void tcg_gen_vec_rotl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c);
+
+/* 32-bit vector operations. */
+void tcg_gen_vec_add8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
+void tcg_gen_vec_add16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
+
+void tcg_gen_vec_sub8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
+void tcg_gen_vec_sub16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
+
+void tcg_gen_vec_shl8i_i32(TCGv_i32 d, TCGv_i32 a, int32_t);
+void tcg_gen_vec_shl16i_i32(TCGv_i32 d, TCGv_i32 a, int32_t);
+void tcg_gen_vec_shr8i_i32(TCGv_i32 d, TCGv_i32 a, int32_t);
+void tcg_gen_vec_shr16i_i32(TCGv_i32 d, TCGv_i32 a, int32_t);
+void tcg_gen_vec_sar8i_i32(TCGv_i32 d, TCGv_i32 a, int32_t);
+void tcg_gen_vec_sar16i_i32(TCGv_i32 d, TCGv_i32 a, int32_t);
+
+#endif
diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index a8183bfeab..b0a81ad4bf 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -1,447 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Generic vector operation expansion
+ * Target dependent generic vector operation expansion
  *
  * Copyright (c) 2018 Linaro
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef TCG_TCG_OP_GVEC_H
 #define TCG_TCG_OP_GVEC_H
 
-/*
- * "Generic" vectors.  All operands are given as offsets from ENV,
- * and therefore cannot also be allocated via tcg_global_mem_new_*.
- * OPRSZ is the byte size of the vector upon which the operation is performed.
- * MAXSZ is the byte size of the full vector; bytes beyond OPSZ are cleared.
- *
- * All sizes must be 8 or any multiple of 16.
- * When OPRSZ is 8, the alignment may be 8, otherwise must be 16.
- * Operands may completely, but not partially, overlap.
- */
+#include "tcg/tcg-op-gvec-common.h"
 
-/* Expand a call to a gvec-style helper, with pointers to two vector
-   operands, and a descriptor (see tcg-gvec-desc.h).  */
-typedef void gen_helper_gvec_2(TCGv_ptr, TCGv_ptr, TCGv_i32);
-void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
-                        uint32_t oprsz, uint32_t maxsz, int32_t data,
-                        gen_helper_gvec_2 *fn);
-
-/* Similarly, passing an extra data value.  */
-typedef void gen_helper_gvec_2i(TCGv_ptr, TCGv_ptr, TCGv_i64, TCGv_i32);
-void tcg_gen_gvec_2i_ool(uint32_t dofs, uint32_t aofs, TCGv_i64 c,
-                         uint32_t oprsz, uint32_t maxsz, int32_t data,
-                         gen_helper_gvec_2i *fn);
-
-/* Similarly, passing an extra pointer (e.g. env or float_status).  */
-typedef void gen_helper_gvec_2_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
-void tcg_gen_gvec_2_ptr(uint32_t dofs, uint32_t aofs,
-                        TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
-                        int32_t data, gen_helper_gvec_2_ptr *fn);
-
-/* Similarly, with three vector operands.  */
-typedef void gen_helper_gvec_3(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
-void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                        uint32_t oprsz, uint32_t maxsz, int32_t data,
-                        gen_helper_gvec_3 *fn);
-
-/* Similarly, with four vector operands.  */
-typedef void gen_helper_gvec_4(TCGv_ptr, TCGv_ptr, TCGv_ptr,
-                               TCGv_ptr, TCGv_i32);
-void tcg_gen_gvec_4_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                        uint32_t cofs, uint32_t oprsz, uint32_t maxsz,
-                        int32_t data, gen_helper_gvec_4 *fn);
-
-/* Similarly, with five vector operands.  */
-typedef void gen_helper_gvec_5(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
-                               TCGv_ptr, TCGv_i32);
-void tcg_gen_gvec_5_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                        uint32_t cofs, uint32_t xofs, uint32_t oprsz,
-                        uint32_t maxsz, int32_t data, gen_helper_gvec_5 *fn);
-
-typedef void gen_helper_gvec_3_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr,
-                                   TCGv_ptr, TCGv_i32);
-void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                        TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
-                        int32_t data, gen_helper_gvec_3_ptr *fn);
-
-typedef void gen_helper_gvec_4_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr,
-                                   TCGv_ptr, TCGv_ptr, TCGv_i32);
-void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                        uint32_t cofs, TCGv_ptr ptr, uint32_t oprsz,
-                        uint32_t maxsz, int32_t data,
-                        gen_helper_gvec_4_ptr *fn);
-
-typedef void gen_helper_gvec_5_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
-                                   TCGv_ptr, TCGv_ptr, TCGv_i32);
-void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                        uint32_t cofs, uint32_t eofs, TCGv_ptr ptr,
-                        uint32_t oprsz, uint32_t maxsz, int32_t data,
-                        gen_helper_gvec_5_ptr *fn);
-
-/* Expand a gvec operation.  Either inline or out-of-line depending on
-   the actual vector size and the operations supported by the host.  */
-typedef struct {
-    /* Expand inline as a 64-bit or 32-bit integer.
-       Only one of these will be non-NULL.  */
-    void (*fni8)(TCGv_i64, TCGv_i64);
-    void (*fni4)(TCGv_i32, TCGv_i32);
-    /* Expand inline with a host vector type.  */
-    void (*fniv)(unsigned, TCGv_vec, TCGv_vec);
-    /* Expand out-of-line helper w/descriptor.  */
-    gen_helper_gvec_2 *fno;
-    /* The optional opcodes, if any, utilized by .fniv.  */
-    const TCGOpcode *opt_opc;
-    /* The data argument to the out-of-line helper.  */
-    int32_t data;
-    /* The vector element size, if applicable.  */
-    uint8_t vece;
-    /* Prefer i64 to v64.  */
-    bool prefer_i64;
-    /* Load dest as a 2nd source operand.  */
-    bool load_dest;
-} GVecGen2;
-
-typedef struct {
-    /* Expand inline as a 64-bit or 32-bit integer.
-       Only one of these will be non-NULL.  */
-    void (*fni8)(TCGv_i64, TCGv_i64, int64_t);
-    void (*fni4)(TCGv_i32, TCGv_i32, int32_t);
-    /* Expand inline with a host vector type.  */
-    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, int64_t);
-    /* Expand out-of-line helper w/descriptor, data in descriptor.  */
-    gen_helper_gvec_2 *fno;
-    /* Expand out-of-line helper w/descriptor, data as argument.  */
-    gen_helper_gvec_2i *fnoi;
-    /* The optional opcodes, if any, utilized by .fniv.  */
-    const TCGOpcode *opt_opc;
-    /* The vector element size, if applicable.  */
-    uint8_t vece;
-    /* Prefer i64 to v64.  */
-    bool prefer_i64;
-    /* Load dest as a 3rd source operand.  */
-    bool load_dest;
-} GVecGen2i;
-
-typedef struct {
-    /* Expand inline as a 64-bit or 32-bit integer.
-       Only one of these will be non-NULL.  */
-    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64);
-    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32);
-    /* Expand inline with a host vector type.  */
-    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec);
-    /* Expand out-of-line helper w/descriptor.  */
-    gen_helper_gvec_2i *fno;
-    /* The optional opcodes, if any, utilized by .fniv.  */
-    const TCGOpcode *opt_opc;
-    /* The data argument to the out-of-line helper.  */
-    uint32_t data;
-    /* The vector element size, if applicable.  */
-    uint8_t vece;
-    /* Prefer i64 to v64.  */
-    bool prefer_i64;
-    /* Load scalar as 1st source operand.  */
-    bool scalar_first;
-} GVecGen2s;
-
-typedef struct {
-    /* Expand inline as a 64-bit or 32-bit integer.
-       Only one of these will be non-NULL.  */
-    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64);
-    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32);
-    /* Expand inline with a host vector type.  */
-    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec);
-    /* Expand out-of-line helper w/descriptor.  */
-    gen_helper_gvec_3 *fno;
-    /* The optional opcodes, if any, utilized by .fniv.  */
-    const TCGOpcode *opt_opc;
-    /* The data argument to the out-of-line helper.  */
-    int32_t data;
-    /* The vector element size, if applicable.  */
-    uint8_t vece;
-    /* Prefer i64 to v64.  */
-    bool prefer_i64;
-    /* Load dest as a 3rd source operand.  */
-    bool load_dest;
-} GVecGen3;
-
-typedef struct {
-    /*
-     * Expand inline as a 64-bit or 32-bit integer. Only one of these will be
-     * non-NULL.
-     */
-    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64, int64_t);
-    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32, int32_t);
-    /* Expand inline with a host vector type.  */
-    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, int64_t);
-    /* Expand out-of-line helper w/descriptor, data in descriptor.  */
-    gen_helper_gvec_3 *fno;
-    /* The optional opcodes, if any, utilized by .fniv.  */
-    const TCGOpcode *opt_opc;
-    /* The vector element size, if applicable.  */
-    uint8_t vece;
-    /* Prefer i64 to v64.  */
-    bool prefer_i64;
-    /* Load dest as a 3rd source operand.  */
-    bool load_dest;
-} GVecGen3i;
-
-typedef struct {
-    /* Expand inline as a 64-bit or 32-bit integer.
-       Only one of these will be non-NULL.  */
-    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64);
-    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
-    /* Expand inline with a host vector type.  */
-    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, TCGv_vec);
-    /* Expand out-of-line helper w/descriptor.  */
-    gen_helper_gvec_4 *fno;
-    /* The optional opcodes, if any, utilized by .fniv.  */
-    const TCGOpcode *opt_opc;
-    /* The data argument to the out-of-line helper.  */
-    int32_t data;
-    /* The vector element size, if applicable.  */
-    uint8_t vece;
-    /* Prefer i64 to v64.  */
-    bool prefer_i64;
-    /* Write aofs as a 2nd dest operand.  */
-    bool write_aofs;
-} GVecGen4;
-
-typedef struct {
-    /*
-     * Expand inline as a 64-bit or 32-bit integer. Only one of these will be
-     * non-NULL.
-     */
-    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64, int64_t);
-    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32, int32_t);
-    /* Expand inline with a host vector type.  */
-    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, TCGv_vec, int64_t);
-    /* Expand out-of-line helper w/descriptor, data in descriptor.  */
-    gen_helper_gvec_4 *fno;
-    /* The optional opcodes, if any, utilized by .fniv.  */
-    const TCGOpcode *opt_opc;
-    /* The vector element size, if applicable.  */
-    uint8_t vece;
-    /* Prefer i64 to v64.  */
-    bool prefer_i64;
-} GVecGen4i;
-
-void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
-                    uint32_t oprsz, uint32_t maxsz, const GVecGen2 *);
-void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                     uint32_t maxsz, int64_t c, const GVecGen2i *);
-void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                     uint32_t maxsz, TCGv_i64 c, const GVecGen2s *);
-void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                    uint32_t oprsz, uint32_t maxsz, const GVecGen3 *);
-void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                     uint32_t oprsz, uint32_t maxsz, int64_t c,
-                     const GVecGen3i *);
-void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
-                    uint32_t oprsz, uint32_t maxsz, const GVecGen4 *);
-void tcg_gen_gvec_4i(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
-                     uint32_t oprsz, uint32_t maxsz, int64_t c,
-                     const GVecGen4i *);
-
-/* Expand a specific vector operation.  */
-
-void tcg_gen_gvec_mov(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t oprsz, uint32_t maxsz);
-
-void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-
-void tcg_gen_gvec_addi(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       int64_t c, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_muli(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       int64_t c, uint32_t oprsz, uint32_t maxsz);
-
-void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_muls(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
-
-/* Saturated arithmetic.  */
-void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-
-/* Min/max.  */
-void tcg_gen_gvec_smin(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_umin(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_smax(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_umax(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-
-void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_or(unsigned vece, uint32_t dofs, uint32_t aofs,
-                     uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_nand(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_nor(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_eqv(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-
-void tcg_gen_gvec_andi(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       int64_t c, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_xori(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       int64_t c, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_ori(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      int64_t c, uint32_t oprsz, uint32_t maxsz);
-
-void tcg_gen_gvec_ands(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_andcs(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_xors(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_ors(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
-
-void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
-                          uint32_t s, uint32_t m);
-void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t s,
-                          uint32_t m, uint64_t imm);
-void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
-                          uint32_t m, TCGv_i32);
-void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
-                          uint32_t m, TCGv_i64);
-
-#if TARGET_LONG_BITS == 64
-# define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i64
-#else
-# define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i32
+#ifndef TARGET_LONG_BITS
+#error must include QEMU headers
 #endif
 
-void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       int64_t shift, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       int64_t shift, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       int64_t shift, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_rotli(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_rotri(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
-
-void tcg_gen_gvec_shls(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_shrs(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_sars(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_rotls(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_rotrs(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
-
-/*
- * Perform vector shift by vector element, modulo the element size.
- * E.g.  D[i] = A[i] << (B[i] % (8 << vece)).
- */
-void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, uint32_t aofs,
-                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_rotlv(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-void tcg_gen_gvec_rotrv(unsigned vece, uint32_t dofs, uint32_t aofs,
-                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
-
-void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
-                      uint32_t aofs, uint32_t bofs,
-                      uint32_t oprsz, uint32_t maxsz);
-
-/*
- * Perform vector bit select: d = (b & a) | (c & ~a).
- */
-void tcg_gen_gvec_bitsel(unsigned vece, uint32_t dofs, uint32_t aofs,
-                         uint32_t bofs, uint32_t cofs,
-                         uint32_t oprsz, uint32_t maxsz);
-
-/*
- * 64-bit vector operations.  Use these when the register has been allocated
- * with tcg_global_mem_new_i64, and so we cannot also address it via pointer.
- * OPRSZ = MAXSZ = 8.
- */
-
-void tcg_gen_vec_neg8_i64(TCGv_i64 d, TCGv_i64 a);
-void tcg_gen_vec_neg16_i64(TCGv_i64 d, TCGv_i64 a);
-void tcg_gen_vec_neg32_i64(TCGv_i64 d, TCGv_i64 a);
-
-void tcg_gen_vec_add8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
-void tcg_gen_vec_add16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
-void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
-
-void tcg_gen_vec_sub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
-void tcg_gen_vec_sub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
-void tcg_gen_vec_sub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
-
-void tcg_gen_vec_shl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
-void tcg_gen_vec_shl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
-void tcg_gen_vec_shr8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
-void tcg_gen_vec_shr16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
-void tcg_gen_vec_sar8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
-void tcg_gen_vec_sar16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
-void tcg_gen_vec_rotl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c);
-void tcg_gen_vec_rotl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c);
-
-/* 32-bit vector operations. */
-void tcg_gen_vec_add8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
-void tcg_gen_vec_add16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
-
-void tcg_gen_vec_sub8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
-void tcg_gen_vec_sub16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
-
-void tcg_gen_vec_shl8i_i32(TCGv_i32 d, TCGv_i32 a, int32_t);
-void tcg_gen_vec_shl16i_i32(TCGv_i32 d, TCGv_i32 a, int32_t);
-void tcg_gen_vec_shr8i_i32(TCGv_i32 d, TCGv_i32 a, int32_t);
-void tcg_gen_vec_shr16i_i32(TCGv_i32 d, TCGv_i32 a, int32_t);
-void tcg_gen_vec_sar8i_i32(TCGv_i32 d, TCGv_i32 a, int32_t);
-void tcg_gen_vec_sar16i_i32(TCGv_i32 d, TCGv_i32 a, int32_t);
-
 #if TARGET_LONG_BITS == 64
+#define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i64
 #define tcg_gen_vec_add8_tl  tcg_gen_vec_add8_i64
 #define tcg_gen_vec_sub8_tl  tcg_gen_vec_sub8_i64
 #define tcg_gen_vec_add16_tl tcg_gen_vec_add16_i64
@@ -454,8 +28,8 @@ void tcg_gen_vec_sar16i_i32(TCGv_i32 d, TCGv_i32 a, int32_t);
 #define tcg_gen_vec_shl16i_tl tcg_gen_vec_shl16i_i64
 #define tcg_gen_vec_shr16i_tl tcg_gen_vec_shr16i_i64
 #define tcg_gen_vec_sar16i_tl tcg_gen_vec_sar16i_i64
-
-#else
+#elif TARGET_LONG_BITS == 32
+#define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i32
 #define tcg_gen_vec_add8_tl  tcg_gen_vec_add8_i32
 #define tcg_gen_vec_sub8_tl  tcg_gen_vec_sub8_i32
 #define tcg_gen_vec_add16_tl tcg_gen_vec_add16_i32
@@ -468,6 +42,8 @@ void tcg_gen_vec_sar16i_i32(TCGv_i32 d, TCGv_i32 a, int32_t);
 #define tcg_gen_vec_shl16i_tl tcg_gen_vec_shl16i_i32
 #define tcg_gen_vec_shr16i_tl tcg_gen_vec_shr16i_i32
 #define tcg_gen_vec_sar16i_tl tcg_gen_vec_sar16i_i32
+#else
+# error
 #endif
 
 #endif
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 7a9599e49e..95a588d6d2 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -21,7 +21,7 @@
 #include "tcg/tcg.h"
 #include "tcg/tcg-temp-internal.h"
 #include "tcg/tcg-op-common.h"
-#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg-op-gvec-common.h"
 #include "tcg/tcg-gvec-desc.h"
 
 #define MAX_UNROLL  4
-- 
2.34.1


