Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F206E8311C6
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 04:26:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQJ1j-0004G7-4w; Wed, 17 Jan 2024 22:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ1Y-00042V-Vs
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:25:01 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ1X-0003Nu-CB
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:25:00 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-337cf4ac600so138287f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 19:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705548291; x=1706153091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+unRKaCSDZUa7wMcF5VMrkBGXnAvyrlpB3hgAdHK8PY=;
 b=QthVr5L/3rgKmJxTYz75EZDpeU+dLr0d1/PtCF7YUznvW3jDp6oCJXyJsMA9LG9VUh
 sMAXozJyAqbd2zjG1RSf8IuuyXdyiJiGY126MW7vQCrsWf6xx4qqvvESQlZK9AQu9Coh
 pzrI5GggKb+176XMObIsqd4W99i1UEQrD50xz5VEPGI4uN0dCE2ckBC3fTTF0rZMTFUy
 qzt528FYD5IZeC4zdPnATsacx79uuMwZz9dsaHf59uFGWHWpFor14tNU+PsisZ93VGUV
 olehHEfyOx5vVan+QyItkDVwTcQHlbrpEj87Sor7zzbIbLq2eMUYUc15tvZl8rGv0K4B
 qXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705548291; x=1706153091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+unRKaCSDZUa7wMcF5VMrkBGXnAvyrlpB3hgAdHK8PY=;
 b=ExKSn4bCHhQyFYf/eAS6xk4VhEywMcv9nZzTfPvKTWhRFQ2AK3VOQY3xcPxpXrBHeE
 qisjubwQyJABPiXBlxJGIlN7gEDodX61Z7LYnUoUv7HLw4UGq0sh8PwPFwdYKD/WDZcd
 d3DzLBElEWVCIebsbfRyPBaopSl4zlYTQ/BC3vdF+f239PON5Hs27hu4q/o8vJlMdv3O
 f3Lw1C3+C7yedtgARS3sN9SIvUtHjrrAwC2QXCkRsE0RH5JBnrUae+fpvsXd6NLSexD+
 kWMqhodGhw8hrvAvdXUKhJHRyvi7m4LThBiyhl8dJBNcwQu8fblW/dR+UT2qHpzfLBao
 Z9cA==
X-Gm-Message-State: AOJu0YwBprz5wf06OzyTSmG1e/iuaZ4ke3Z7wIFLIM0J1vsm/lpVxl7u
 qwbzh45jEUEqGIshXi7J20jJndk5rAmiBA8OPNwzFCQ25L07nUyWzqfhI4fMJWYCyWsdvDMvc5e
 C1bQ=
X-Google-Smtp-Source: AGHT+IFV0Em1wRTe1Kx+/W8PvRT4YiCDXPR49XTYRGqIJy5thoHK+AUPqqsQ6hGk51MA2bKDnqe9eg==
X-Received: by 2002:adf:fa8a:0:b0:337:9953:5183 with SMTP id
 h10-20020adffa8a000000b0033799535183mr76562wrr.64.1705548291695; 
 Wed, 17 Jan 2024 19:24:51 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 i2-20020adff302000000b0033788e357e1sm2894292wro.108.2024.01.17.19.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 19:24:51 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 14/14] contrib/plugins/execlog: fix new warnings
Date: Thu, 18 Jan 2024 07:23:59 +0400
Message-ID: <20240118032400.3762658-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42f.google.com
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

‘g_pattern_match_string’ is deprecated,
Use 'g_pattern_spec_match_string' instead.

passing argument 2 of ‘g_ptr_array_add’ discards ‘const’ qualifier from
pointer target type

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/execlog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 5a4de1c93be..d12137ce5c0 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -336,8 +336,8 @@ static void registers_init(int vcpu_index)
             for (int p = 0; p < rmatches->len; p++) {
                 g_autoptr(GPatternSpec) pat = g_pattern_spec_new(rmatches->pdata[p]);
                 g_autofree gchar *rd_lower = g_utf8_strdown(rd->name, -1);
-                if (g_pattern_match_string(pat, rd->name) ||
-                    g_pattern_match_string(pat, rd_lower)) {
+                if (g_pattern_spec_match_string(pat, rd->name) ||
+                    g_pattern_spec_match_string(pat, rd_lower)) {
                     Register *reg = init_vcpu_register(vcpu_index, rd);
                     g_ptr_array_add(registers, reg);
 
@@ -345,7 +345,7 @@ static void registers_init(int vcpu_index)
                     if (disas_assist) {
                         g_mutex_lock(&add_reg_name_lock);
                         if (!g_ptr_array_find(all_reg_names, reg->name, NULL)) {
-                            g_ptr_array_add(all_reg_names, reg->name);
+                            g_ptr_array_add(all_reg_names, (gpointer)reg->name);
                         }
                         g_mutex_unlock(&add_reg_name_lock);
                     }
-- 
2.43.0


