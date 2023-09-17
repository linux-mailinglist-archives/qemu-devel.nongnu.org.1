Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B43C07A3DE9
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:40:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUU-0004Wr-6V; Sun, 17 Sep 2023 17:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUT-0004WW-2Y
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUR-0004Fr-HV
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:40 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40472c3faadso37676805e9.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986778; x=1695591578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tytbz2GrtArc4cKJgoRBdOuRp5xjR4etKhXFM07GeUo=;
 b=Hv3E8NtpzPBBpGO2XaHdvLdqwhfMgjiYcjh6Kry9zQCUQ4LjS9wSQW03pB+Ph0quk+
 NLKnkCPEshhM/ith6EkmJU5gi9EIomoAZFR6XV+KdYM/zdYdMAIElj7G69wlYUSRLUPf
 WaKXdbO3so3aUJmFWoRy3ZkPG8lWLU0UAgPJ5ojlhOnCmEOMD9ODo0xrGpOnm5MblzJm
 cJcaZCmRsbsL+eNRlAT9zWSdEhjJSn6iKmQ/yG9mzXBu48rEI905dp0aGUa0HlzK3FEM
 q6nXHIceuMwBL8VIlXOfS5n/kGZiYK07h8qVLft6ZoNG/JsxedymghafmSAyxasVDwGt
 Yg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986778; x=1695591578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tytbz2GrtArc4cKJgoRBdOuRp5xjR4etKhXFM07GeUo=;
 b=nHSlQC6rddig3dQkebql4N1Sp+mzKcKXwKECna1LgOZ2CbpOLBriYTySe+r+yunffx
 kOjuM4fJS2JnwyyIlo1hTzOvI5S3Ktqx6J+L0B4gvDUOORWEHavlAbLlS7WGbp4NWxfM
 Pp7kl96qzuJ/JNOX0tBf7lOAvFew3WUIgs2ti4Mzn9M7Z94zsBENkbLcBmiCO43dkIFc
 GVNfJiDTrL9Rih4ES+jv8rk1fVH/YVuysdy/mG5da4TuUplEHqSarxxljLM98XrcatuH
 4F1okEzrZXgJHeWBatP+moROTEG8cA5833C+5P/3JFVHkBury2RP7TY8ZHJ61sDB6/qA
 BiyA==
X-Gm-Message-State: AOJu0Yz1Q97zb1lP2lyiAW0OgbS+SBHQGa8DFWnl1VXy9OSUIib71Vz5
 qo+MkgPctZ0NAxAkPqqAb8e5/dm38Sk=
X-Google-Smtp-Source: AGHT+IHt4uUBFNrEaijztUUb4iWZ2YF+gMHIV0bqXr6ekBn5jUOUsWGt53D8+uIvhvdiasJaRKDj0w==
X-Received: by 2002:a5d:53d0:0:b0:31c:84e9:20fd with SMTP id
 a16-20020a5d53d0000000b0031c84e920fdmr5331640wrw.13.1694986777926; 
 Sun, 17 Sep 2023 14:39:37 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:37 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 09/28] bsd-user: Implement host_to_target_waitstatus
 conversion.
Date: Mon, 18 Sep 2023 00:37:44 +0300
Message-ID: <20230917213803.20683-10-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x333.google.com
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


