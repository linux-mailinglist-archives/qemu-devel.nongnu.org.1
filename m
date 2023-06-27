Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 383527400A4
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:17:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBMR-0001CV-2t; Tue, 27 Jun 2023 12:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBMK-00016f-8o
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:16:04 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBMB-0008A1-QQ
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:16:03 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fba66f3e1dso8276105e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882554; x=1690474554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JwYXISrmUwYEeEBYbvf+rC+BgUtqy99AwD9pTl/rVpc=;
 b=xlQSGBHAk2dlQ/9WRsnCMFXkgv65KdRtfZR8wjkzDURh0rA+Xn0rOje23/4U6kR/+L
 /8Gd657+oq0w80zVTq3nu6bWy6yIRE2/7yngjIiNfQOUiVixGQTiDC8/AYkug6nTMXVW
 Rstq4ZxyztYo+QnejsGgUFBN/iDbNski2GM9N+UoooKZi3lyAaRozGGRKT+FeLLMdTrq
 ExS7hzKhbbABjo//yXgml79yariHWw2P1f1x+Qbhp/iESC4m6isPc7Xdv7Qkk/GY8gw7
 F2UI0foP2pD8zWkmq4EkM/DEezcqsX+IJOkegLgZ9iBaShHhE/Lg2n/UdSz3mzrqSYni
 /98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882554; x=1690474554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JwYXISrmUwYEeEBYbvf+rC+BgUtqy99AwD9pTl/rVpc=;
 b=H6EO0ie2C+7BQrcV9Z4IDWI0U5TF0ePogtBF+NxwtFyCg9XQeD8MdRgocv4w+YzQ/Q
 jV+c0a1AS1TocBwVs+C9JK4yXeG4YwPyncX55ejgzjR7PPmL3paP1xbttpnGXGFgrK5K
 qWqnwMUUd+w+A3dnJmjTk97Wdc3QTnEztNt4Z+nIWf1ipzZrHbOUXeQx2KddBOoyWFt3
 a8IcSVh7mqJ7TkCEtTq2CajDQHdTzI240Nl3DhHzddWuJQwvdwpgjX2raP3zvHXymZYy
 6m3UrCH/eBeOhAYpd0R00hWncdoo4hrpfxV/fvdHJZY51CDAQWNaILIitwX3BhVNM8Fj
 7o1g==
X-Gm-Message-State: AC+VfDyTNFVHhZdoIOjXUjZlw0fCHuNlMWNoNHs0FBpkcyjUdMDkNxUv
 8W6dTdPu4VCamymYgN7uwOeAgg==
X-Google-Smtp-Source: ACHHUZ6efj6LGsOF9SSn2mQu7dy2KflCNP2V0k5tcHo4/kfC68OhmW8/d2D8rbZ5Rpr5Q9WHy6vAVw==
X-Received: by 2002:a05:600c:2903:b0:3fa:7fb1:11df with SMTP id
 i3-20020a05600c290300b003fa7fb111dfmr7395796wmd.19.1687882554404; 
 Tue, 27 Jun 2023 09:15:54 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a7bcb8d000000b003fba97b1252sm1302569wmi.1.2023.06.27.09.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:15:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8A6EC1FFC2;
 Tue, 27 Jun 2023 17:09:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 06/36] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
Date: Tue, 27 Jun 2023 17:09:13 +0100
Message-Id: <20230627160943.2956928-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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


