Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B9C78B931
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:12:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiZC-0008K2-W2; Mon, 28 Aug 2023 16:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYx-0008Ei-Tl
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:16 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYv-0007aQ-LS
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:15 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99c136ee106so467362466b.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253411; x=1693858211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uXUwd7KLSf4xksoT9hSYDjHq1uy0u6BKwi1S++lsL2o=;
 b=HWvH3HmErDnNrL9I/Wp3YTLHptNCr3Sl/xMeP2DIvwueQbz5imLGtL8RlrPnzQuAT7
 GV/meGQMb7c4qLU4IvyX1kr/VRxYDQzSPYiw7fQvrAOd6/HJTmM6uV8oEZtRrTKkV3fI
 mWfVJS99Dbr891AvC3hghaUz55ClyWMWzk8rwEK0QB2+8+JWmQD5I9+lRmlFYK0Z8mx0
 KgYKvrRS8pHSpXWVDvj2Lu/Sfzstgs5dlJ4+XFzdsho/4R27IF8Oh4pIlfle/nvv9Kh5
 6i5047AhqvYL2vJVRyOI0xYoPyGGHfWo4BhHnIw59EOnpyCPuGgs6MhocT4JRlY2n8kc
 Rwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253411; x=1693858211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXUwd7KLSf4xksoT9hSYDjHq1uy0u6BKwi1S++lsL2o=;
 b=R80SpATwMr0r+nK+adTnrWQGKIArU+RmvKJiNVp6tFTrU25GBcCPxym5GRWNcFHVbl
 aaIZALosTG5mDfE0Xmmnd0A3m36unWXocxVXvlxHAMd+6IhNswbONwVBB4xnI+XrsbX6
 wfyu8JnlQN13yARpyiNeZBCHoz/arFmBG8++5AcBxZhW07SwTVa6Q95U0hw7ZlRg0X4t
 ZDGlZZMKnLkfvEd8QqjtZ2CIBJ/VZwCXCsgzAW3vMBT/hQkHzPESVjlCCM396nVQRvrX
 +QDRKDBDt3HXXygMIA8ptzqNbCa/VNyxVWsPt6N89Uj7L/nBtCnMXMyizHg5BF01ifbh
 tJuQ==
X-Gm-Message-State: AOJu0Yw05EEiOmL+d9O/Rp9NuXbGYXlRba6cXRVS/n/7tpXKKx/nGg89
 JCoB7KyfIX9LTBZO4IGtpHS2W2z9ILEyDQ==
X-Google-Smtp-Source: AGHT+IGQWz9vyORvyQ/H5HDxMmwd9Y5rXLPutJrGjnbEajWzlDEJyL3dXZKCAKE7sZNntIGNkSMllQ==
X-Received: by 2002:a17:907:c299:b0:9a1:ff2f:28f1 with SMTP id
 tk25-20020a170907c29900b009a1ff2f28f1mr11127426ejc.40.1693253411564; 
 Mon, 28 Aug 2023 13:10:11 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:10:11 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 10/32] bsd-user: Implement host_to_target_waitstatus
 conversion.
Date: Sun, 27 Aug 2023 17:57:24 +0200
Message-Id: <20230827155746.84781-11-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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
---
 bsd-user/bsd-proc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index 8e6dd5e427..49c0fb67d0 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -168,3 +168,20 @@ abi_long host_to_target_wrusage(abi_ulong target_addr,
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
2.40.0


