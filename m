Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AF68311CA
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 04:26:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQJ1e-00045n-OU; Wed, 17 Jan 2024 22:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ1X-0003yH-KC
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:59 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ1O-0003Fv-PF
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:52 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-337b71a0240so2209959f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 19:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705548289; x=1706153089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gY1HvrcRK/jb3DOwoSe5cKTH6nvlDdjohKhPFmwO/ik=;
 b=CEuUsMTqe4kEKady6Yx/3J7/s0FeyHCskAsv4vvSRTwOqLiAt4/xd+QMg8O3Q0ZcWD
 /WfR49Mc/kSAg13XMxFQhEQOjcOoDSX4YBuXQGBLHYQU2/FKic2tJV0c+997a6Kqde/T
 6L2Fm1cUucOcOoKcaUbm/ZxhpNcMLXri5Miq8MaDPmFtA1cYL9hVW4IETfKNTqIKiqOC
 9+mC1CbpT73svLXKeZuWxG8e18gcxPQYWADDSFqq9qiA7yNCXV8/wpFfEliwRxjYR6ui
 zt5/WHWMe8ghVEIcIb+4YpU2zjkZJrYFxUV4nZOxHVFjV5kcSkCOGjRAPER82xLnghtE
 E5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705548289; x=1706153089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gY1HvrcRK/jb3DOwoSe5cKTH6nvlDdjohKhPFmwO/ik=;
 b=oRrR1OJjaW2UZjj9wAS0mdFzhxCxz8UfhlxT4pyTU19i0FxeWX7coIq+IRff6Xrtwb
 bqq/SY3dgMU5+ir1wl+s9q9t4KqQ9g2rGlQnGee2u2OWIgFAyLqTazAiBl40fSb36tCi
 1iStZodbV2y/lnTtaWc3ca8ZIsIbKbpuakGfSUmhv/E5EkdCOq9S7rRQ2OK4dccT/xAp
 koUe98EjxHYn6XaIj/Z9rO0Psae8DMEjOMdGD9jUKdEBgWXPKONMu/wEjxG/+njE8s0k
 7wVI5+wuNK/wpQ4guQZarbfenF/4fV9jwLUZLBSo8jb299pY2aj1F3XvGIbGH3AZejwd
 bAdw==
X-Gm-Message-State: AOJu0Yw8DH9BfuZP+rNVRhovkc/iyd1Kv5df3G13RsQbDi4m+/ktcloO
 MHDspmwT7YiFNPF4A5BVoUSF1u6iod+WHk6ZHAnCpZPKRCZvfRFnGILPDoZlPYnWz+kFUhL/YLn
 M/r0=
X-Google-Smtp-Source: AGHT+IEA734t+UkU+45d5yZH/WkWNiJhR0hRNtZfoVrYGmN7qsOBuFn2954VLj9/uj5bz553GUoABg==
X-Received: by 2002:adf:f4ca:0:b0:337:c2fa:3d22 with SMTP id
 h10-20020adff4ca000000b00337c2fa3d22mr75747wrp.139.1705548289125; 
 Wed, 17 Jan 2024 19:24:49 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 i2-20020adff302000000b0033788e357e1sm2894292wro.108.2024.01.17.19.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 19:24:48 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 13/14] MAINTAINERS: Add myself as reviewer for TCG Plugins
Date: Thu, 18 Jan 2024 07:23:58 +0400
Message-ID: <20240118032400.3762658-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x435.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b406fb20c05..206d813ea5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3675,6 +3675,7 @@ TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
 R: Alexandre Iooss <erdnaxe@crans.org>
 R: Mahmoud Mandour <ma.mandourr@gmail.com>
+R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 S: Maintained
 F: docs/devel/tcg-plugins.rst
 F: plugins/
-- 
2.43.0


