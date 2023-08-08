Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 912BA7740D5
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:11:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDa-00027a-Fo; Tue, 08 Aug 2023 13:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDY-000247-61
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:00 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDW-0003LD-Ef
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:59 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-317716a4622so4653497f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514597; x=1692119397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7aUKmSfj9WhcL+W2nPwX0/ITlfa9OEYC/UkmBUVyTQ=;
 b=RGQ0QYqGWzLlz+LNsMVQnenQ9AYF6AVLoFdLu0S8G8L5jKM+arQaC4rGZdlj6DoOat
 dJhcmbxSIkVODFUZ83sG5zbcAB714DNGLWIH3SdWm8RAEm/nPU8LSAk5fp8Od+DYxuwY
 z+MvmJbxLjXXLP3Siq9Nai9mov10z2Da8EO1FrDaaHNCquQL/1U7/pmbEBevy9cGoQbi
 fZYrkE/BHqIciiY4kiavWI9xCDKzfUJqDVVskjWPfAv4j+DjtT1vStRN/4NMCnOa/QxV
 JF76BYiqt+80gGB7rSg1xw+EnrBJEqv2iTOwmyblAWhoT85vylwVX9R5a24pKrv8cu6D
 Na+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514597; x=1692119397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7aUKmSfj9WhcL+W2nPwX0/ITlfa9OEYC/UkmBUVyTQ=;
 b=Ykmbd38PYeb6QMltSuNArNoGNqe5R7pYmninpwhd0o5iXJ7jUzpTgQdPAOtgFvmgN4
 PnCasipoVlJyYY38KMgvGqUQd+IJGyzvZ+r6EmWPQgx43HlHNJDTDPwaH2RA40dmJvX6
 3ECAUoUJP9XYnJb26ttw2qEpMvB0m403z01kzPspoSN0cG8WGnP3/AmklQLSW8vCnEW/
 Gh0AmVFXLl/nDVXiSEQxHiezr1OHgwfW8eMkuYIvkBO/ZJ1N+9H1e9qusBbuRpZidupK
 tsfmdcZKLpeldjrjRbPv4Mb9/QhzMk9dVR/ocYRGwjT5OJ5cWVJiLrJNe5CUEy5fKgQB
 HhEA==
X-Gm-Message-State: AOJu0YwX+lbGE7gTsiqdYDi0irsfA820ad4CoS96h2lY6+w98wsIv4X5
 xJZZea9cIwWVrg0T11Oh+XbEfUoxfahGzg==
X-Google-Smtp-Source: AGHT+IFVxSdUFMRMgYo/siGY868MYmAUIxdHU6FcnuLm5PFGtdEdn5wWMRo2qkEIULYPseSJfCep9A==
X-Received: by 2002:a5d:58d9:0:b0:317:6681:e426 with SMTP id
 o25-20020a5d58d9000000b003176681e426mr68532wrf.25.1691514596581; 
 Tue, 08 Aug 2023 10:09:56 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:56 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 16/33] Implement host-target convertion functions
Date: Tue,  8 Aug 2023 08:07:58 +0200
Message-Id: <20230808060815.9001-17-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x432.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Implement the stat converstion functions:
target_to_host_fcntl_cmd

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-stat.c | 71 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
index 9eb01bf664..f5b4ded8bb 100644
--- a/bsd-user/freebsd/os-stat.c
+++ b/bsd-user/freebsd/os-stat.c
@@ -170,3 +170,74 @@ abi_long h2t_freebsd11_statfs(abi_ulong target_addr,
     return 0;
 }
 
+/*
+ * fcntl cmd conversion
+ */
+abi_long target_to_host_fcntl_cmd(int cmd)
+{
+
+    switch (cmd) {
+    case TARGET_F_DUPFD:
+        return F_DUPFD;
+
+    case TARGET_F_DUP2FD:
+        return F_DUP2FD;
+
+    case TARGET_F_GETFD:
+        return F_GETFD;
+
+    case TARGET_F_SETFD:
+        return F_SETFD;
+
+    case TARGET_F_GETFL:
+        return F_GETFL;
+
+    case TARGET_F_SETFL:
+        return F_SETFL;
+
+    case TARGET_F_GETOWN:
+        return F_GETOWN;
+
+    case TARGET_F_SETOWN:
+        return F_SETOWN;
+
+    case TARGET_F_GETLK:
+        return F_GETLK;
+
+    case TARGET_F_SETLK:
+        return F_SETLK;
+
+    case TARGET_F_SETLKW:
+        return F_SETLKW;
+
+    case TARGET_F_READAHEAD:
+        return F_READAHEAD;
+
+    case TARGET_F_RDAHEAD:
+        return F_RDAHEAD;
+
+#ifdef F_DUPFD_CLOEXEC
+    case TARGET_F_DUPFD_CLOEXEC:
+        return F_DUPFD_CLOEXEC;
+#endif
+
+#ifdef F_DUP2FD_CLOEXEC
+    case TARGET_F_DUP2FD_CLOEXEC:
+        return F_DUP2FD_CLOEXEC;
+#endif
+
+#ifdef F_ADD_SEALS
+    case TARGET_F_ADD_SEALS:
+        return F_ADD_SEALS;
+#endif
+
+#ifdef F_GET_SEALS
+    case TARGET_F_GET_SEALS:
+        return F_GET_SEALS;
+#endif
+
+    default:
+        return -TARGET_EINVAL;
+    }
+}
+
-- 
2.40.0


