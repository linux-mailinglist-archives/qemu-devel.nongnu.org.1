Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C157ACE46
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:38:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbSp-0003IT-Hl; Sun, 24 Sep 2023 22:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSl-0003Hy-KP
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:43 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSk-00005g-4l
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:43 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3232be274a0so212539f8f.1
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609400; x=1696214200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBa86IcvJ8qZLQPEGuLU5XUlSMmhHoCVoEZs2NT+SAc=;
 b=LEgVtk6+B+aPAqCD3kANPC5cSqrcNp/9tuj5lC/yKsqtiKyp/8r0jTlpvucF5TcXRZ
 5Aei5zkFKDoXjC0inv4NQgHGhEME+DokBszHIcjT6v97Ov2RkOFGHOAvxWTi9BaEh8JP
 IZD7XL4QjxgJ4Z/WZwoRp/8p4kFH9bKvkMFcBzVZUAtvxLx6OLugichHdbPHuvGKcmh2
 UhlC7KDcK0tjcZUC6sa5Cs9j9uCTmL4VLlb4VI6FcubAeP2YWtt8GKEYOMWzz6uhs9jp
 1tMXvFQ72vQs4UroPFXEA99bUio3ukwjd+LDceuJCJdc0bOTWYS7S+B+pka9UloxrnT6
 35Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609400; x=1696214200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBa86IcvJ8qZLQPEGuLU5XUlSMmhHoCVoEZs2NT+SAc=;
 b=qwOyGraMXzjs7kenJT2deMakiJmG9V/aV9OKGpquvPDjztnMZMQtePDeyQmcRJdtwW
 jOF+sAL5yso9JNWGsCrz7Q7OzhBoBEjew7wbN06hff50wOHPYWPklV8r54VOHEbmVc8/
 RlK7Caa+B7oQjMeNWT7xcv7ClBNcuHxTZ7pf1Zp7i9ucI1ISBGKgsIC+WtBxI8WFBvyl
 JJyEAbVUTYDHSHsn3UXmQhUoSShsE1WIUHlzs+0j4GYPiqyzO5lvVs+LqoQCtHoIYijx
 nHHlVCNbwJBGc5KHq+tCOEERjzcg10Uq3F+LfIvmdr+R0d8WiGg+T5d5PBYODYKxPhDR
 qMbQ==
X-Gm-Message-State: AOJu0YxUQ8WhI2uw4CvuajWdQU4ByOfaQth01DScrO/LB2rzhrnch+qU
 9u2rPE2nTsi9s7olsUTO2y3UtxgLK+c=
X-Google-Smtp-Source: AGHT+IFCXUVtYSV7eoDl+Ir2u2V11Luw4Z/Gbo7DmwFKoMkqPtbG4k6neAyXVE6BIGAaemV8TeZitA==
X-Received: by 2002:adf:dcc7:0:b0:31f:c89b:91fc with SMTP id
 x7-20020adfdcc7000000b0031fc89b91fcmr6561142wrm.7.1695609400379; 
 Sun, 24 Sep 2023 19:36:40 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:40 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 09/28] bsd-user: Implement host_to_target_waitstatus
 conversion.
Date: Mon, 25 Sep 2023 00:01:17 +0300
Message-ID: <20230924210136.11966-10-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
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


