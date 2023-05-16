Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7B87057A6
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yz-0006oB-99; Tue, 16 May 2023 15:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yx-0006nn-3o
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:23 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yu-0002pV-VW
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:22 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-52867360efcso10426459a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266140; x=1686858140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ribAH55dCyxFTDrwMfk5QxSVbH9673DY11IGNIerYiI=;
 b=abX5yocFee4UDT2vYAewOC+0jxhncuaSSM5uf7sz4gkaJAbCDTvfb2IQTT94PukY4S
 mUsN1dHdw6rAntXCpal8Ya9pCfzgFx73OTb2IUiuIxkb4U4LuNBvptBeosNdZuDIAsNF
 5eQZMElB0gzhQmVKvzTPPxcB4u3k43daj7WxaU1hk0h81J6tGSA7Dcc9Ax6jClpn4EpI
 SV8sGTbJvbp3n87tYfQbyUZPx2IvdjnmzK0KqhtYjX0Rg2DXc+EU989Y4fJPiZu497rs
 v+4iEQOhqaXTKNMt31pXrkeQNPhVNdROsLulMuEkqAX9kLaO1qZ+C5vu5sWDdUps8FKh
 JAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266140; x=1686858140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ribAH55dCyxFTDrwMfk5QxSVbH9673DY11IGNIerYiI=;
 b=LyuDY3RS11VO4aAKrkLqBuhfv/LIxmaWXSv7+iUTTthBeXb4VBPjRqDATTmqNsEAUI
 iE1Kdhv3ZCZkv4OSXHpC5NH9XOFktBf31wmDep3DW6z2Fep73v8/ekSmc9PS+1mDcna5
 X8R+e1VVkn+Z8mBHUv8eAXzLpgK9lYKDHRvgWyqM4ZLPkb/y/3edgjdpzP7slkUr7LFR
 1UJL84MX7HPFcpTkdGZ+P49jVJfM4Xw6v58p+w4+kAPiE+gijaz6x6CLSVHdl+xaT6sQ
 ncsdjwabZT5sGkOM5h5v3U8szj3lMO/Ez2XpHSBSnVLiH3PWSwpNlVQ5c876+cKnZGUs
 lmog==
X-Gm-Message-State: AC+VfDxJwX/vClJkVzWlyjTRrn73t9VD8xDCzKh0oPuVIKJFGEW68YMN
 kAEeERNrUk0EUe2/nR5OTe8xQ2DbGQzQwQ8o4dw=
X-Google-Smtp-Source: ACHHUZ4HkO7Y8XhRvtcg03nDkdqZPjExsDHtC0fk5jQFTMtk3q8crTdmiesUfIY7JkUXxRkM4U49xg==
X-Received: by 2002:a05:6a20:1448:b0:105:55a7:d5ff with SMTP id
 a8-20020a056a20144800b0010555a7d5ffmr14185514pzi.28.1684266140276; 
 Tue, 16 May 2023 12:42:20 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 37/80] tcg: Introduce atom_and_align_for_opc
Date: Tue, 16 May 2023 12:41:02 -0700
Message-Id: <20230516194145.1749305-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Examine MemOp for atomicity and alignment, adjusting alignment
as required to implement atomicity on the host.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 582fd1b36d..878e780cfa 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -220,6 +220,15 @@ static void * const qemu_st_helpers[MO_SIZE + 1] __attribute__((unused)) = {
 #endif
 };
 
+typedef struct {
+    MemOp atom;   /* lg2 bits of atomicity required */
+    MemOp align;  /* lg2 bits of alignment to use */
+} TCGAtomAlign;
+
+static TCGAtomAlign atom_and_align_for_opc(TCGContext *s, MemOp opc,
+                                           MemOp host_atom, bool allow_two_ops)
+    __attribute__((unused));
+
 TCGContext tcg_init_ctx;
 __thread TCGContext *tcg_ctx;
 
@@ -5228,6 +5237,92 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
     }
 }
 
+/**
+ * atom_and_align_for_opc:
+ * @s: tcg context
+ * @opc: memory operation code
+ * @host_atom: MO_ATOM_{IFALIGN,WITHIN16,SUBALIGN} for host operations
+ * @allow_two_ops: true if we are prepared to issue two operations
+ *
+ * Return the alignment and atomicity to use for the inline fast path
+ * for the given memory operation.  The alignment may be larger than
+ * that specified in @opc, and the correct alignment will be diagnosed
+ * by the slow path helper.
+ *
+ * If @allow_two_ops, the host is prepared to test for 2x alignment,
+ * and issue two loads or stores for subalignment.
+ */
+static TCGAtomAlign atom_and_align_for_opc(TCGContext *s, MemOp opc,
+                                           MemOp host_atom, bool allow_two_ops)
+{
+    MemOp align = get_alignment_bits(opc);
+    MemOp size = opc & MO_SIZE;
+    MemOp half = size ? size - 1 : 0;
+    MemOp atmax;
+    MemOp atom;
+
+    /* When serialized, no further atomicity required.  */
+    if (s->gen_tb->cflags & CF_PARALLEL) {
+        atom = opc & MO_ATOM_MASK;
+    } else {
+        atom = MO_ATOM_NONE;
+    }
+
+    switch (atom) {
+    case MO_ATOM_NONE:
+        /* The operation requires no specific atomicity. */
+        atmax = MO_8;
+        break;
+
+    case MO_ATOM_IFALIGN:
+        atmax = size;
+        break;
+
+    case MO_ATOM_IFALIGN_PAIR:
+        atmax = half;
+        break;
+
+    case MO_ATOM_WITHIN16:
+        atmax = size;
+        if (size == MO_128) {
+            /* Misalignment implies !within16, and therefore no atomicity. */
+        } else if (host_atom != MO_ATOM_WITHIN16) {
+            /* The host does not implement within16, so require alignment. */
+            align = MAX(align, size);
+        }
+        break;
+
+    case MO_ATOM_WITHIN16_PAIR:
+        atmax = size;
+        /*
+         * Misalignment implies !within16, and therefore half atomicity.
+         * Any host prepared for two operations can implement this with
+         * half alignment.
+         */
+        if (host_atom != MO_ATOM_WITHIN16 && allow_two_ops) {
+            align = MAX(align, half);
+        }
+        break;
+
+    case MO_ATOM_SUBALIGN:
+        atmax = size;
+        if (host_atom != MO_ATOM_SUBALIGN) {
+            /* If unaligned but not odd, there are subobjects up to half. */
+            if (allow_two_ops) {
+                align = MAX(align, half);
+            } else {
+                align = MAX(align, size);
+            }
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    return (TCGAtomAlign){ .atom = atmax, .align = align };
+}
+
 /*
  * Similarly for qemu_ld/st slow path helpers.
  * We must re-implement tcg_gen_callN and tcg_reg_alloc_call simultaneously,
-- 
2.34.1


