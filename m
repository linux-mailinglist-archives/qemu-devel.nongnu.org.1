Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B88B278F5E6
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 00:58:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbqaP-0003sd-4J; Thu, 31 Aug 2023 18:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqaM-0003rm-I1
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:56:22 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqaJ-0002ov-3F
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:56:22 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9a58dbd5daeso168500266b.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 15:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693522577; x=1694127377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IhXUeI4Vxb8/8XVWSOD9CuNhg7dP6BSEsnXwUzw0chc=;
 b=h4TVqjCiUoPAAL9NKP3pvD8CJnd+kSGZwhjZW0ZJwZuKd02OwA4jhSQ/BUN36Ii4+e
 4RWIenZyCI1HVxJgH9XKFlrSernhL8TchkYkYxGtYe0DlYKyICK542yoInGTssPbi9Lx
 NaPfDamMer6iTQm+Mxuc1ANT7GnA7VIO/ujcRJUqemWgIAvYzBRF14eLh7s91HvHxWol
 WCbCecqoJ+kZmqgRJKF2F4PZJNajN5phngIC1mtHuZmFT+1vT7LAOTcY0puK+L8S1i7e
 tf7vpqGm0N2NuAazW1ucrMOjhHnNgBdMBnLjT0ZIqjNpHooFwNMLiWimC7hjRbBDCd7y
 12gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693522577; x=1694127377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IhXUeI4Vxb8/8XVWSOD9CuNhg7dP6BSEsnXwUzw0chc=;
 b=JMX/kMEmdi5lEW+DnwuzAPV/AaP9tLG0Sr/28Sk6F81VeMCy0e4h5U38c+nESXK9WU
 jONqRLrEsNf6TVgMlHJV4i1uhiKQFnGil/onpFh9leIWCP7M1Tg761S6hBi9KNyj3snP
 5j5xgS2C+tejQOn3Jq+qtahnKGt37XXOGWAzU1YhQ2/Ri6Bzqa8EvpLh8PgXsopAQD29
 +/f3SogOT+RsbMNQea8c0R70SgLXzxPXgyFKhE23GoLhnIe8lCg3dA66ckxBf+T9GPjm
 jEzrpg6E2Gqd8M4aKqaBOpKoZX+6U0/f4jzlVkLhCbmK+G0vBZKu5fQsKZFzbmqxdPVx
 XQ+A==
X-Gm-Message-State: AOJu0YyxS8aeYlOgB8kDoT0b2NA/RIlOCGFWs+dvPBYRPqM7yZq4WDcl
 qVfIUEjzsvzjEWtbyaUuCTfG7ij3fnu/di9Y2uA=
X-Google-Smtp-Source: AGHT+IEnjwV6KL5laWf7e5/xvKo1HePWGOJgOXtP3GD5ZnAXmO07p3XZ4EatBgJDWGQ3x4c8YehCHw==
X-Received: by 2002:a17:907:75d7:b0:99e:39d:4fa7 with SMTP id
 jl23-20020a17090775d700b0099e039d4fa7mr507867ejc.22.1693522577289; 
 Thu, 31 Aug 2023 15:56:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 m26-20020a170906259a00b0099ca4f61a8bsm1265876ejb.92.2023.08.31.15.56.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 15:56:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 01/11] tcg: Clean up local variable shadowing
Date: Fri,  1 Sep 2023 00:55:56 +0200
Message-ID: <20230831225607.30829-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831225607.30829-1-philmd@linaro.org>
References: <20230831225607.30829-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

Fix:

  tcg/tcg.c:2551:27: error: declaration shadows a local variable [-Werror,-Wshadow]
                    MemOp op = get_memop(oi);
                          ^
  tcg/tcg.c:2437:12: note: previous declaration is here
    TCGOp *op;
           ^
  accel/tcg/tb-maint.c:245:18: error: declaration shadows a local variable [-Werror,-Wshadow]
        for (int i = 0; i < V_L2_SIZE; i++) {
                 ^
  accel/tcg/tb-maint.c:210:9: note: previous declaration is here
    int i;
        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tb-maint.c |  3 +--
 tcg/tcg.c            | 16 ++++++++--------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index c406b2f7b7..f1cf3ad736 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -207,13 +207,12 @@ static PageDesc *page_find_alloc(tb_page_addr_t index, bool alloc)
 {
     PageDesc *pd;
     void **lp;
-    int i;
 
     /* Level 1.  Always allocated.  */
     lp = l1_map + ((index >> v_l1_shift) & (v_l1_size - 1));
 
     /* Level 2..N-1.  */
-    for (i = v_l2_levels; i > 0; i--) {
+    for (int i = v_l2_levels; i > 0; i--) {
         void **p = qatomic_rcu_read(lp);
 
         if (p == NULL) {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 620dbe08da..46a3a231b8 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2548,21 +2548,21 @@ static void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                 {
                     const char *s_al, *s_op, *s_at;
                     MemOpIdx oi = op->args[k++];
-                    MemOp op = get_memop(oi);
+                    MemOp o = get_memop(oi);
                     unsigned ix = get_mmuidx(oi);
 
-                    s_al = alignment_name[(op & MO_AMASK) >> MO_ASHIFT];
-                    s_op = ldst_name[op & (MO_BSWAP | MO_SSIZE)];
-                    s_at = atom_name[(op & MO_ATOM_MASK) >> MO_ATOM_SHIFT];
-                    op &= ~(MO_AMASK | MO_BSWAP | MO_SSIZE | MO_ATOM_MASK);
+                    s_al = alignment_name[(o & MO_AMASK) >> MO_ASHIFT];
+                    s_op = ldst_name[o & (MO_BSWAP | MO_SSIZE)];
+                    s_at = atom_name[(o & MO_ATOM_MASK) >> MO_ATOM_SHIFT];
+                    o &= ~(MO_AMASK | MO_BSWAP | MO_SSIZE | MO_ATOM_MASK);
 
                     /* If all fields are accounted for, print symbolically. */
-                    if (!op && s_al && s_op && s_at) {
+                    if (!o && s_al && s_op && s_at) {
                         col += ne_fprintf(f, ",%s%s%s,%u",
                                           s_at, s_al, s_op, ix);
                     } else {
-                        op = get_memop(oi);
-                        col += ne_fprintf(f, ",$0x%x,%u", op, ix);
+                        o = get_memop(oi);
+                        col += ne_fprintf(f, ",$0x%x,%u", o, ix);
                     }
                     i = 1;
                 }
-- 
2.41.0


