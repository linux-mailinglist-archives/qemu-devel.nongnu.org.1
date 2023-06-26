Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C636873EE43
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:04:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuFI-0002cU-8Z; Mon, 26 Jun 2023 17:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuFD-0002ZT-Uk
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:35 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuF9-0004ra-NV
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:35 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-313f2a24cb6so1564719f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 14:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687816770; x=1690408770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UiwEwjAi6lomr9E2iVsjR5pQJHgLNYXOTgd+ktx/cfE=;
 b=QkOu34Yveyl8EiKH6w1I+VpWN75HOx78BZ1f3bRxys7JRSBcYpRQDaubEmoDaD/1S2
 ly36S4aKVBzALA0WbqzrX4gQM9SbW7SDmG1FLCCTQ4Bp9mh72aELgwCiI4jb1imBhGCW
 wEJsNTJTJzZQ8o89uKQX8czAt4GgUVKKBJimGqI83NfBGU+M77/sOkP5ZRt3pW1CvocU
 h4vdapLDWWdG1Jcs7dSB7hiMuruutsiJbZ+sP8GwclBf3uRJ3i11hbF3EnzjRS1nX/K7
 Vh9RY/1Z5PyEdaAG43p4NMyuM2DoTZGAV/8ZJJoSQRkYNP5eKCvFAP5i9/dWgznEJj1g
 YkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816770; x=1690408770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UiwEwjAi6lomr9E2iVsjR5pQJHgLNYXOTgd+ktx/cfE=;
 b=lBcI6Rc5IPxUH3QBlQrBvj+wrZW/JsLwKIRYFvq2c+4FDrCSfBRQKjWhlbyU2f5Qgg
 2ISCxTwgw2VjfpiA5e116XcCk6/DY4ARoZIFBwb1zBmBWvW1dnao7JIvM/Mok+u3xZy+
 J8jvEgVBondci1fbELLAvFB8HiPDQHX3OjiTRVtQ+90riZifr8qqqKwfxfNSpOn0maY9
 oNCFq0qCudLTPDnHoO7WNM51iOkKnTdcFZtvLBQxrYoa0Akvuc8vs+Sr45oZdtVgdzZG
 xwvSiF2gj1mnw59v1HEixTjFTBkfY83P2zjwGc7ohUS5J+ZGE10G90lP7/2/XwMVzZ+5
 zrwg==
X-Gm-Message-State: AC+VfDytNlTRPMlVXGKsdBkEr75hi+GwaMoNXVeyma5HzeB8wecNSqCV
 AUwYyem05lr85D1FqmwtmgGNUw==
X-Google-Smtp-Source: ACHHUZ5+90AgbGSbEQx8QQ2p95E9Q3UFHzBJvvrd7HRe+5XUss5bBysuLUDYuK4WAGEITpeQ6kY3aA==
X-Received: by 2002:a05:6000:d0:b0:313:fca6:5f56 with SMTP id
 q16-20020a05600000d000b00313fca65f56mr212679wrx.8.1687816770334; 
 Mon, 26 Jun 2023 14:59:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a0560001b0400b00307a86a4bcesm8511640wrz.35.2023.06.26.14.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 14:59:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 863FA1FFC1;
 Mon, 26 Jun 2023 22:59:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 06/26] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
Date: Mon, 26 Jun 2023 22:59:06 +0100
Message-Id: <20230626215926.2522656-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215926.2522656-1-alex.bennee@linaro.org>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


