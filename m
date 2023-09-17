Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 367E47A3E75
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:26:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Bl-0006We-3b; Sun, 17 Sep 2023 18:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bh-0006VF-Be
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:21 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bf-0002vI-Rn
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:21 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32001d16a14so1238193f8f.1
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989458; x=1695594258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tytbz2GrtArc4cKJgoRBdOuRp5xjR4etKhXFM07GeUo=;
 b=OEIfn2kPA61Rn7T30JSvLssohG75wCbkw2Dh9GeiuF+dQEslWU9brnswaqI4kRfCb6
 /t+y5nFtoI5SFYUcM5HfHp1HLhlVX++t1JQpsoUDjuNty0Jsb3N2uV42rU8HCdTpwD0N
 IF0tGUsi8lYjHVTe+tQMiZq8k9w1Lr40Kt85NdkcYaSlFUMhAMp5yx7IOgtDLyC2m1ym
 9mAgFj4zqQ2Dy16fZgbjLefUqQpfOR5U/5Mnom01qrVEwGS6zVq8gu2Ud3mY1Wbm4Ms4
 f+cmqlJL/x6BRax8y3Wr3eo5NNiuzE0cHPLZkpgs/TLWL3CE0EGQ/3BWMNCpQXoKKkZI
 lxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989458; x=1695594258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tytbz2GrtArc4cKJgoRBdOuRp5xjR4etKhXFM07GeUo=;
 b=WpbLN0FKs75QSQtTneDo/IqRhaSDv/iHRFnkaYsINdrfovrrUJk20FR28iUfa0aR/w
 eAkzfnlskU4VcGKwr+2oWuy9ur7Js7mdrUwVaf1W8WZHqzttOA8XnQZ55yFfNtyk5NuR
 gELkuYKouWLtoxMfqHN7gkVX8+DjHGr5j/HbTd0Y7uiyp3wSchoSsM4OWqpiZUkQKtsk
 1Qfaomt/n/5cAgj9GVzxD34qRahlwnP9+I2OVpMeoq4fROKb7d5tYNGJziQ9J+3hg/O9
 hs8g0aRPY0J8Ga3u9ouarUkyp/0bxjqcgPPz6pRfssYLrO33LfwG6bEwLgs/IPY7O+Y8
 OJmg==
X-Gm-Message-State: AOJu0YzCc2HBGxE2LcmXmRYExOPPEl9OPudsnhhfkLGRWAYJyazrLC6e
 3CAl/y/bJsJK4fCmcDil5SRdkJiGeY8=
X-Google-Smtp-Source: AGHT+IFh/9s15b9YDjig29WinbWxgitEh5pMXub215cgCFIE2D29GZuF2HIaB4xHV3+21LL6O2efpQ==
X-Received: by 2002:a5d:60c5:0:b0:31f:eb88:e3c8 with SMTP id
 x5-20020a5d60c5000000b0031feb88e3c8mr6040559wrt.32.1694989458209; 
 Sun, 17 Sep 2023 15:24:18 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:17 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 09/28] bsd-user: Implement host_to_target_waitstatus
 conversion.
Date: Mon, 18 Sep 2023 01:22:26 +0300
Message-ID: <20230917222246.1921-10-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-proc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index aa386ff482..19f6efe1f7 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -102,3 +102,20 @@ abi_long host_to_target_wrusage(abi_ulong target_addr,
     return 0;
 }
 
+/*
+ * wait status conversion.
+ *
+ * Map host to target signal numbers for the wait family of syscalls.
+ * Assume all other status bits are the same.
+ */
+int host_to_target_waitstatus(int status)
+{
+    if (WIFSIGNALED(status)) {
+        return host_to_target_signal(WTERMSIG(status)) | (status & ~0x7f);
+    }
+    if (WIFSTOPPED(status)) {
+        return (host_to_target_signal(WSTOPSIG(status)) << 8) | (status & 0xff);
+    }
+    return status;
+}
+
-- 
2.42.0


