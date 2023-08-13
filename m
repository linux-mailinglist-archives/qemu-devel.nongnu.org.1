Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9338977A6E3
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:20:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpv-0008G6-4Z; Sun, 13 Aug 2023 10:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpp-0008DR-UI
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:49 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpn-0000vK-GW
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:48 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-317dcdae365so3036562f8f.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935966; x=1692540766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AudXPKhwqDesJedmS1mxJoP3DgO9Vt4WYBDjn+bY3BU=;
 b=Znbbk236c+rg0hN+iUpSz1B/EgASskGnHIWHnNiO+PeLihMjihLYEiVQbhHlEb2OIE
 xwsakqoKh7TMgmab7WOJrJ6z/NMFtP3kDXyVhnhH7SJ7H5w90qkcuj4Li8vI6KF8oFph
 xhHVLdUwAezLxA8K091qL4MMiQ6XqQdcE6cNdsDAo0W0tBXUD5GcT8QMI/u2TmJGpYwA
 l6FTGAcf95SjRgSvBjBjUSEr8EZyfEew9jXR3JIK9qfm+dPbIhwlP9WY7D0LzQdjOXuW
 SD2rf+Mp5bW3EaUViW40ejEmImw+Yd511NUJNpYfAwPYgd/V4BrVrnWZhu3tyainWxhB
 WHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935966; x=1692540766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AudXPKhwqDesJedmS1mxJoP3DgO9Vt4WYBDjn+bY3BU=;
 b=bgFkbdDyEt/WteObAxVpUXUMjAh2H7bXd+IL/kIXJjzqtKRShOJl6fQGI28floNpvn
 ZftEYOyI6hFnglLMRy9DCKuIU63Wb8g2Y7QOkGh/AcgOeyAKj2psx3ab/vgIGQdRrbXh
 COkR/VwltgfjSxlADuGUxyZdqjCEhpjI/SnmCFh9miN3q5RS97sbSoHMSR0UamFjvYvN
 aZjRq32WOZaOJsfhUmJUiQfz0Y+wgHKinjRlm3as9ARlDb/d5vEe2GKdNtnarlDYtlWG
 p0ze4RDQuhQl6eXtV67TvG3AVqLsJLe9kNoPiucKmxlzZce4DjHV5BAbTgMEJymBhNqm
 Ibmw==
X-Gm-Message-State: AOJu0YzYolzWm4XMv15zGIHiKM/QAeRnZq96IwElYgxQ8nOM5wUEsKMt
 NqbqYpcFt3VkpAy/+2h769YexyN2e6o=
X-Google-Smtp-Source: AGHT+IEAkaLurJSecLo9ogIJi2Wpas0vJfJ4oMB8m6PM0usqbWoYysAjap0aHPHEdQxIzLdmacnZHw==
X-Received: by 2002:adf:f349:0:b0:317:3d6c:5b27 with SMTP id
 e9-20020adff349000000b003173d6c5b27mr5301619wrp.46.1691935965753; 
 Sun, 13 Aug 2023 07:12:45 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:45 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 31/32] Add glue to call the following syscalls to the
 freebsd_syscall function:
Date: Sun, 13 Aug 2023 05:10:12 +0200
Message-Id: <20230813031013.1743-32-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Warner Losh <imp@bsdimp.com>

freebsd11_statfs
statfs
freebsd11_fstatfs
fstatfs
freebsd11_getfsstat
getfsstat

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-syscall.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 73616a5be0..916a754bf8 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -552,6 +552,30 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_fhstatfs(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_freebsd11_statfs: /* statfs(2) */
+        ret = do_freebsd11_statfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_statfs: /* statfs(2) */
+        ret = do_freebsd_statfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fstatfs: /* fstatfs(2) */
+        ret = do_freebsd11_fstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fstatfs: /* fstatfs(2) */
+        ret = do_freebsd_fstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_getfsstat: /* getfsstat(2) */
+        ret = do_freebsd11_getfsstat(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getfsstat: /* getfsstat(2) */
+        ret = do_freebsd_getfsstat(arg1, arg2, arg3);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.40.0


