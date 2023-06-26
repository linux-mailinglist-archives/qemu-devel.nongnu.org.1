Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9441E73EBCE
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 22:26:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDsmH-0005te-UF; Mon, 26 Jun 2023 16:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDsm5-0005d7-7P
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 16:25:25 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDsm2-000567-G4
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 16:25:24 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fa7cd95dacso46160795e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687811119; x=1690403119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UiwEwjAi6lomr9E2iVsjR5pQJHgLNYXOTgd+ktx/cfE=;
 b=iu7d9Ue0an7YMNwlflrR3yzAETx5HgQUv/Y6Q+TSzzSQi8fCCUPoGxY7yBeG+hIYZU
 OZ0O5i4OVltg1k5l5sHWoog895CzR9B/aIct82pQYJnwmT2X59KBk6RxJ8TijccdiHCq
 hVCSMAqrRr9mddIjOUFVs0rJHNWVDlzosPymLYNwdqTvSmVxbmYyoAF+7LnR6UUgfPNX
 7euKiM18I4M9wQpbcmyQH6ku9kDE4XGwjxR0O/VvuyDd48iFA/9JriKUf1Sh7cHWoB8g
 zBKmpkXflTAYgihJ8AIYSNmD1MUR/sdy4waXf2RQFBM0IzzzKAUkOUqez4/d4snknyWk
 i4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687811119; x=1690403119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UiwEwjAi6lomr9E2iVsjR5pQJHgLNYXOTgd+ktx/cfE=;
 b=MJJZ1Sxno1j8S9o7ZCAd1GuItj0cUXYwr5EVo5iUvoPlzIXh77+827NnURwiqMH8cW
 VP0yZBE+U/+A3Tx2vjneJlwm7XA/CRA3yA+QFEt8jUZEpmpFa83Rg6gpD5z3H9AwZkQ9
 fudffK45f7+nCX290mRrwskOBZUUyBTLGsX7L+lx+zizN4XymYh2/XX74mtP22R//PMw
 rhI75nIR6N+U3kCadzkSWEv99QsqafkDVpJPHq3i96WmEqdg3V+jiPy3qLOQKCAPaQRw
 x7W7YlNX1Eah6TaXz8mxTqE5lPrentn2k0CID602wOfsLK2Lje+dPO5+KYHAudJlnL4u
 lhMQ==
X-Gm-Message-State: AC+VfDzkqD60sFh4CF+Unt4GfoCV5HRKfz2AtkssiFnDFGUpz5mgD9I3
 8nFehB5J27veWoyZF6f7JLKXFg==
X-Google-Smtp-Source: ACHHUZ6pChy/Lf/ZiVXPV7+3Sb1tV8HaDxsVOP5x9pGjnWkY7Ppdn2+5g/ZeDJRSUkvTpfYJZmy11A==
X-Received: by 2002:a1c:7c04:0:b0:3fa:85c6:57ff with SMTP id
 x4-20020a1c7c04000000b003fa85c657ffmr5796679wmc.16.1687811119406; 
 Mon, 26 Jun 2023 13:25:19 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a7bcd0a000000b003fa99969e61sm3018272wmj.45.2023.06.26.13.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 13:25:18 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BBFB31FFC1;
 Mon, 26 Jun 2023 21:25:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Qiuhao Li <Qiuhao.Li@outlook.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Xu <peterx@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Cleber Rosa <crosa@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 6/6] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
Date: Mon, 26 Jun 2023 21:25:15 +0100
Message-Id: <20230626202516.2507915-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626202516.2507915-1-alex.bennee@linaro.org>
References: <20230626202516.2507915-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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


