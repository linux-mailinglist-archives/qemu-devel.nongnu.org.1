Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4DB745DC1
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:51:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJrC-0007f5-JO; Mon, 03 Jul 2023 09:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr2-0007TG-T1
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:38 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJqy-0005gJ-Re
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:34 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbc12181b6so49639635e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391871; x=1690983871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fbp/Zw9eE5uqY/m4aZkgwxvYT/8MMMAgvc/DfnALRqM=;
 b=kOc5lwjDXSZXbSVA4d/hKjBWUIE95aGT/ECqqJ+ApG6I4OXbn+YTNpTYAH0HHXQVRP
 ZOOApXAEcUxxT1bQV/MxGQonWYqACm3H54qsAYmzeDXuQnSZ1IQ+a7JTgPUGSHMLxmkB
 dmATo651J7hFQ3dJ/OvSu4fd5EnAUjZxO4jD1U+FRlf0YD/cuQjQzg+1c8cuXa9sqxtU
 Z8DgrOnqlpQTNuy+7tfmhn06ub3CqZVyMSYRVo2tYAWth+AxTkyorTbKQjghSqZ3KsBh
 mBCv8yunUtiXjK7lo8nvYC9clmnlSTp2wup6R9QvII/1K7dLreZrpdsXPk2BSpQuK04S
 fioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391871; x=1690983871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fbp/Zw9eE5uqY/m4aZkgwxvYT/8MMMAgvc/DfnALRqM=;
 b=BQVZSQ1VsQd0JCNEvJQlfzlPMdnjQbksi59Y1Ia21G1bMZ7bZXkmEdNCJCJnz4Khxa
 ShkGW/S48bvKC6J9M6MONbQuzZQ6UxPxnXkRptRun9Qv3o/rb89gwS0zTzy9aLBhQlkk
 krvMqMDkVGbZhzPtgWf6wb8g7NsxOnHxnB+nQrZ8kRv6Q1PE6ZLeNk8cza3O8mrvLqZy
 VUjkjAPClye2Dq5bSsc9vZc8fFMiFeA8cUE9hxE3GO9W3dN+YjYImsIRCJSvO+5pEeP1
 8ouwvfnAPXlb0AQ9hEuOzNiIWALlam0JugvM/JpD/tCgSLHf3a7j9uHy21D+zh0yxhPh
 wD6Q==
X-Gm-Message-State: AC+VfDwVHdR2jeRx/N4+44Z9Y0fiizsWlCe6aWQmUXwKNKacSKaxchN9
 QgSmc4VxNQp87bIM7gMiYM/2xw==
X-Google-Smtp-Source: ACHHUZ7i/mGf2oW0ScX2ML0nYmVY6L9AVbTvOJO2vyPnnGYuHU+2pZMshbgps1Uim9ldvkOz2hA3rg==
X-Received: by 2002:a05:600c:364f:b0:3f9:ba2:5d19 with SMTP id
 y15-20020a05600c364f00b003f90ba25d19mr8842130wmq.33.1688391871164; 
 Mon, 03 Jul 2023 06:44:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a1c7718000000b003fba9db141esm16768715wmi.38.2023.07.03.06.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7664C1FFC1;
 Mon,  3 Jul 2023 14:44:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PULL 06/38] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
Date: Mon,  3 Jul 2023 14:43:55 +0100
Message-Id: <20230703134427.1389440-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-7-alex.bennee@linaro.org>

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


