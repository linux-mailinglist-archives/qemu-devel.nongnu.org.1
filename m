Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 188E074005F
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:08:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBDm-0000DL-83; Tue, 27 Jun 2023 12:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDi-0000AT-5n
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:10 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDd-00056c-Qh
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:09 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-313f3a6db22so2318764f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882023; x=1690474023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JwYXISrmUwYEeEBYbvf+rC+BgUtqy99AwD9pTl/rVpc=;
 b=LIJa8T/zlasl7a+2JlP0u6PEaw3nKQzMEaYwVuJjnL7qMpS3ibTjBE0Yu5buCy9Y8I
 gGQv72WZReSg2PR6g94UQAlAZQbucKAAMEmHYmZqsl87TuaPlkngR4u5mW3xDQFwSTTV
 YGt2bxvchx7aYR8z1CAyT5JZHO2gWEjH3VrXVfX3Sm/1GPymmdpJzB36Q2f50f5fi1dk
 0cKeKzOpXc61qPtQHlYyocaMc3YeQSAbbUJ6HZ9yNMaeY4IYmXGDyTZ49Y0NoATX6gl9
 9PrO/ZG1XC/UCl+DApg0KuPQRCYWZU/FrKyP/FVykDBcb3pu2/Lp1ARDZ19OwMppSCRY
 Kl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882023; x=1690474023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JwYXISrmUwYEeEBYbvf+rC+BgUtqy99AwD9pTl/rVpc=;
 b=GGguAuYq/ebEiefd/2x8cp4HUcaDc6ddQjto8xCa+1f1zoHTQsk7TGU+IEC8Ko8lCm
 TLLIioqzAV4/1Zf2sqnj+VNMXNsnnLoY4FLb9eFahI2HW86S7JgZwHAUUSz96SL/ayC6
 CzEc0v1vt97+KQMdKi6nX8awlo2HvRgy6LQ7LW/ko41QfOX5bQWCT6MOkWcg4s0izIyt
 Cc44RTQ8eDxipeMVGW0RIgUXW/FPoLc9A/EmbSHOcS4AhcY3WXglJGhe3XdvoRwfMLwW
 yGEs+rSH5MvpqzIG45R7Lp+m5eiH51W/+BV5Z9TuJaN+YYm0anE1Ehuv5LlOH8agZ5Jf
 L65Q==
X-Gm-Message-State: AC+VfDwuf7awsl5QuD7/gmssojsJMZ4iekkpkdMn9SB6AqIbsICpzvum
 Ab4bN1j4T1U9iaSbzHUa/GvYpQ==
X-Google-Smtp-Source: ACHHUZ5ha1PZ85+cv5ooNAcB86Dkb9AZ2ZLxhBNifBBAcOCOh3NkNsxLj6wWYf0DRgL2E6ea/4w9hg==
X-Received: by 2002:a05:6000:42:b0:313:e2c4:7bc2 with SMTP id
 k2-20020a056000004200b00313e2c47bc2mr9321794wrx.53.1687882023743; 
 Tue, 27 Jun 2023 09:07:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s7-20020adfeb07000000b0030ae901bc54sm10780158wrn.62.2023.06.27.09.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:07:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7154C1FFC1;
 Tue, 27 Jun 2023 17:07:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Leonardo Bras <leobras@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bandan Das <bsd@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Juan Quintela <quintela@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v3 06/36] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
Date: Tue, 27 Jun 2023 17:06:30 +0100
Message-Id: <20230627160700.2955547-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160700.2955547-1-alex.bennee@linaro.org>
References: <20230627160700.2955547-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

We can return XKB_MOD_INVALID for AltGr which rightly gets flagged by
sanitisers as an overly wide shift attempt. Properly check the return
type and leave the bitmap as zero in that case. Tested output before
and after is unchanged with the gb and ara keymaps.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
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


