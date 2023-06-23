Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DED73B708
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:22:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfo1-0004Vt-Tu; Fri, 23 Jun 2023 08:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmv-0003oA-K5
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:18 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmo-0003hO-Hj
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:15 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f870247d6aso706492e87.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687522864; x=1690114864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UiwEwjAi6lomr9E2iVsjR5pQJHgLNYXOTgd+ktx/cfE=;
 b=u4t/Tgi8JNEuzIancjMufZUWhxuNov8a4Y93qN9/0qphNFe21QqNLKzQykIBIlUZvo
 bVB9HvJT6CgfPh7M1SaClNkKi8buyRlhhUXAxJpKYUbk1LF6hUApYb77S1rSRV/Yu6Xb
 vAScRVQU5irjrkcB2TtZotE3taJDDXgFzlTZvXgzKv42PbOKBs9mFN2yo+Z8kPWiEdQw
 TZbVH2vmk4b9ymnZ8FU/+DniKH9TURSyNaICHiZstfNzi0u2Wp2unPPD90lZMDtQs0CK
 AMIIt2OMRZP0ZIpO6Us2oVpZl0nM3WxqHlDM7E7l1B4txjhBrf0jhmvYWTch8mxeZXwK
 ZQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522864; x=1690114864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UiwEwjAi6lomr9E2iVsjR5pQJHgLNYXOTgd+ktx/cfE=;
 b=ai2Aq9biaspCO8GQ7THcF5vWNydviZJvaTeznlteJ5zHTkBk4JKuwxOcx1q2neKM+a
 ko9JT5ZIOzRt6qER1NFkYEYP6eQhh1F/VkA0bk73b0rgPhROkr2E9MCImR1V5Hv3QqRt
 zE6JhEx3U6PjpFifG3n4v3TLv6il7rgieji9y4QxtIastRkou4DKaL/DT3qqPSMxZG2N
 muOx/YPu1QdQvC9ED4LjWZYY9iA0eGzi6WdKzi3ejouH4aR4Im+1X9M2g2bPxCCAf+Qa
 88w5S9iwSM3G34mwUPcC1gR1aRE91RMj5raL94tdpLm9Tv6qtGYLSm84maWrqqWmJXtX
 VWIw==
X-Gm-Message-State: AC+VfDzqHA9onhdOvRjehLOG1bVkoJjAH2pot9Ldchv1WkidCsnITQBC
 mbl0Dyb+cQYmfrCqHhrzC8yEbQ==
X-Google-Smtp-Source: ACHHUZ6KP5rN8gQgkBisVzuzyc9GNFTcPs0ncHYSDgSyb5LCquBwJPvPmc53ZTLha/ZNGXIe2sbt4Q==
X-Received: by 2002:a19:ca02:0:b0:4f9:586b:dba1 with SMTP id
 a2-20020a19ca02000000b004f9586bdba1mr4956649lfg.4.1687522864472; 
 Fri, 23 Jun 2023 05:21:04 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q19-20020a7bce93000000b003f9b53959a4sm2159572wmj.43.2023.06.23.05.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:21:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 494361FFC2;
 Fri, 23 Jun 2023 13:21:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Riku Voipio <riku.voipio@iki.fi>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 07/26] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
Date: Fri, 23 Jun 2023 13:20:41 +0100
Message-Id: <20230623122100.1640995-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12e.google.com
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


