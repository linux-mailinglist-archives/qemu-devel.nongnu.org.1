Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C65736FBB
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:04:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBctX-000587-PO; Tue, 20 Jun 2023 11:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBctV-00057Y-SA
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:03:45 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBctT-0004Mt-Ah
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:03:45 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f9b627c1b8so13090575e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687273421; x=1689865421;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UiwEwjAi6lomr9E2iVsjR5pQJHgLNYXOTgd+ktx/cfE=;
 b=b3HJ05u6frj/MRZXkB19HJGxUZkLcKjWuG8Ol+5vFqTuO5e2lPsZOdRHOA+QVYkycC
 vqjr3rHyvcX5fbjKzKLPidNQDj1RZrgqtxzrw9MhLvAbh51OQWJ3czKKkMi/YCFVXTQ7
 Q9Ywsn5eBSgZpbRwDXAefObDDqW1lnwAlQjs7ziHIxTeznx2bzGbB70yskgz/oRgTVo0
 YCqeSeOi4VhKZLPSFN4YmtBMFhLLtdGG2IbM8plX1hQKLR457bUQqcfD/diabZvxdaV7
 cKha7KePEEVvzKcDdTX3QUksohG5gRbUiHeyGoiWjERHHsiPQuDJ50298I4vfWJ5n2/u
 tFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687273421; x=1689865421;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UiwEwjAi6lomr9E2iVsjR5pQJHgLNYXOTgd+ktx/cfE=;
 b=XKtzM7hYijv+9swDRKBGSLTS8ftOiO4QJLU5/9mInqe61sk9Ho9zjdTGsi8N8wmudM
 oRkpa4Fzac0qZsgW4YSTL2lSSVAor9kPs7FmQdEBJp+VZE6C2zsex6QHuN+TzPMiibVA
 eqt3zqFJyvzZmryqPTmgtOGIDMMjKdxNy4ceT6FmoPHkdjgwPqPUcwY0Um9GNUAhhxx9
 HNukFeIRc0fnVPyBMoKWZhZ7mr3NXVxJG7Sp//MsZBMvnrYxx3O2wCvozKQRmrnO8AxK
 hj5OOygsYai0lozcli48SBeEfyuziquhxwuuj0mqdjNz9wRokNcc6tELpVnwJC6riRC6
 s9qw==
X-Gm-Message-State: AC+VfDz+GmNjG2v2t7NJNlqXTaNkq0hE1r+JhwnaCVuxvvCreT1szYkN
 fFGbMOPfWOvR1Qe0QstBsc01a9CvRhGhVMzUuvA=
X-Google-Smtp-Source: ACHHUZ7Az30ly7rnBWwRRxRPU1koeDxgTM8OYAcPXxu86+2yQAFfTA7JGQZDx1opv7+9IrTqMml2NA==
X-Received: by 2002:adf:fd82:0:b0:30f:ce87:9db3 with SMTP id
 d2-20020adffd82000000b0030fce879db3mr11057461wrr.23.1687273421571; 
 Tue, 20 Jun 2023 08:03:41 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a5d498b000000b00307a86a4bcesm2187467wrq.35.2023.06.20.08.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:03:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B6DFD1FFBB;
 Tue, 20 Jun 2023 16:03:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
Date: Tue, 20 Jun 2023 16:03:35 +0100
Message-Id: <20230620150335.814005-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

We can return XKB_MOD_INVALID which rightly gets flagged by sanitisers
as an overly wide shift attempt.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 qemu-keymap.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/qemu-keymap.c b/qemu-keymap.c
index 229866e004..8c80f7a4ed 100644
--- a/qemu-keymap.c
+++ b/qemu-keymap.c
@@ -140,6 +140,18 @@ static void usage(FILE *out)
             names.options ?: "-");
 }
 
+static xkb_mod_mask_t get_mod(struct xkb_keymap *map, const char *name)
+{
+    xkb_mod_index_t mod;
+    xkb_mod_mask_t mask = 0;
+
+    mod = xkb_keymap_mod_get_index(map, name);
+    if (mod != XKB_MOD_INVALID) {
+        mask = (1 << mod);
+    }
+    return mask;
+}
+
 int main(int argc, char *argv[])
 {
     struct xkb_context *ctx;
@@ -215,14 +227,10 @@ int main(int argc, char *argv[])
                 mod, xkb_keymap_mod_get_name(map, mod));
     }
 
-    mod = xkb_keymap_mod_get_index(map, "Shift");
-    shift = (1 << mod);
-    mod = xkb_keymap_mod_get_index(map, "Control");
-    ctrl = (1 << mod);
-    mod = xkb_keymap_mod_get_index(map, "AltGr");
-    altgr = (1 << mod);
-    mod = xkb_keymap_mod_get_index(map, "NumLock");
-    numlock = (1 << mod);
+    shift = get_mod(map, "Shift");
+    ctrl = get_mod(map, "Control");
+    altgr = get_mod(map, "AltGr");
+    numlock = get_mod(map, "NumLock");
 
     state = xkb_state_new(map);
     xkb_keymap_key_for_each(map, walk_map, state);
-- 
2.39.2


