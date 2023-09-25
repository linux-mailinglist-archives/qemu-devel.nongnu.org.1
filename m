Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 448007ADF1D
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:38:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHZ-0001Gm-RN; Mon, 25 Sep 2023 14:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHV-0001Fi-V0
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:05 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHU-0007IL-8y
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-405621baba7so41372255e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666362; x=1696271162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBa86IcvJ8qZLQPEGuLU5XUlSMmhHoCVoEZs2NT+SAc=;
 b=P1lent43JdfbHELfcAIjCDVFP7n45YP+ThabRZuCABz1ViZWi9K1cn67zKuSYB1rv8
 pFvekM0+cMCRWHdVkfe4BPTJ/XY9qc72WYGbdOoLVzlZHx92gJuIbaK1O8t5Ou6nVLRh
 VEbfGovSumpbzQJvvONYxqI/SK2aZbe0yfJXpn8poNbAc5vsNdrHl/csh7YpYblr+TZi
 O1otSFirhIPX7f8IuXRtZVevYjXRpV3GkLLCx4z9paD9Z4RMcb+XGyELs6Lwv+uci3rX
 ndB9Kvu1R4+cP0RpFZuFFTOMjrPKxgFNLWGLCHbb0mYDqiWFuaWKZScTh3BEo/uAJelX
 XCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666362; x=1696271162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBa86IcvJ8qZLQPEGuLU5XUlSMmhHoCVoEZs2NT+SAc=;
 b=sglowUTYLDyOGgFqKe3i8CtQNv0ZUUJCZ9hvneTs7fnW7ZUY459/HEuZxcXPihLTlZ
 eT5fLblMOS4CcnlLGJhVpJmlW4UOfGAE+GIHjJOs+NvG6dhi4geNBpEIpG+/bLzvAWVX
 26sl2ppo6Du2u0oZ3aLfwWRE+xcY9sjs7bgMQVi6SpgrVpcdF3xuHBFGDIw/50yP0jzm
 8UNhFFwNfNd5NG/azaSTPacdDoTK/eEb9i4Tvykr3RYZYnmIHb9LH0YZ69XFxqHq4VTD
 kw/QBfnzkjP9CyCIa+kDkdHVZszWqOmxhmd8Mx3r6i8O1Uwc79bxZsowuQFL3MEin9cZ
 a1AQ==
X-Gm-Message-State: AOJu0YwkYiccuggbhM80zTC6KOaP/DIgyXDFFUNCrjHztfKnQ2fzz3YH
 xpzKQsRObX72ufrnBho52RPtYImXK2Q=
X-Google-Smtp-Source: AGHT+IHVIfblWPZvfzpxxWQGWDBvnbFzaL6cUaTrPAeABujGcZOxjoNpZfS808GmUM3Yen7/f7xhbQ==
X-Received: by 2002:a05:600c:c1:b0:401:bdd7:49ae with SMTP id
 u1-20020a05600c00c100b00401bdd749aemr6497431wmm.18.1695666362501; 
 Mon, 25 Sep 2023 11:26:02 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:26:02 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 09/28] bsd-user: Implement host_to_target_waitstatus
 conversion.
Date: Mon, 25 Sep 2023 21:24:06 +0300
Message-ID: <20230925182425.3163-10-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32c.google.com
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


