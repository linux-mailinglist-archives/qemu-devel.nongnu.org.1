Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EAC7BF21A
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 07:13:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq51s-0007cg-9A; Tue, 10 Oct 2023 01:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qq51q-0007by-Dr; Tue, 10 Oct 2023 01:11:34 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qq51o-00048D-Ue; Tue, 10 Oct 2023 01:11:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c8a1541232so20324405ad.0; 
 Mon, 09 Oct 2023 22:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696914690; x=1697519490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WV9AkVTnT7qJnOXg2rK1+Py2iUYtqFqMHogJvXkRmiI=;
 b=nSK6skCAqnwescJFBA3eq0lpM+B38BwuSFrAIqhniAJDOOwQYzu0I3nAzQg/cTuQph
 b4JEH/9008wWwgc6VM5QjlUi0vOrOm/MN+P+PwIIHBc7GFh7H31J+CKgJu5Yu3eJZNkU
 aTP9QXDOy2njc189cTHvUiPbZa7VXscCU/5OK4juQifK7XebQ01896D07FqvTNDIWUT1
 cRuNZROIyhPECuqkmRr8YP16A7aXwhN6GZc4u78aARQaVwL7Ypj+2ge0oGt0bA0NCyJC
 5P8NbMwj+U1DMu2whnFHIR8Pf62rvPHNapLbfl/7YTU1w95J3LpLoUshZheHuzjdNHqc
 X1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696914690; x=1697519490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WV9AkVTnT7qJnOXg2rK1+Py2iUYtqFqMHogJvXkRmiI=;
 b=E86q3zgF9UTWqZOQZmFswdyi95a5s5aH00wTE6s57ms3pQuf+hQ2/VuSQFFRaemiah
 pcJNCOUKIhwvCVv+QAFYLFfnHgFpxDTsMKSbONYzzDy4B0iuPgKHJs2A8KV+Zo1l2cGQ
 spknWpa0+g8HwD6nv10usdMzEXu4ocCKht7o4U7bIgMHnKdq3MCHqTTN0bA0SFulh6Aa
 0fEuQZ9Fbr+HtHkKpxHtfs5crY/ucsmByHPNcpJ704L+9jWkFE9oZRv46k8csFDZwZWx
 2mhCC5PoNm+Bo5yrVCLs0WfbbCIJVpSlS809JXZ9QZP7SPCGqx02IYkPFHkqaYC/KA5Z
 ZQkQ==
X-Gm-Message-State: AOJu0YyG07WaAE/TV0YQ6LJujuipt9r06WmLB8mCpNdtGpyBSM4l7GQM
 XcUyj65Cbg5fTf+np9JLH1U9TkUnp+zbeA==
X-Google-Smtp-Source: AGHT+IFkGjCbCJuLixAq0Kcrt2w+I5gpvfIShKNYLi0ChUsm2dBVkGslcwvKx2TzD0ZIy91WfHmrAg==
X-Received: by 2002:a17:902:7207:b0:1c1:dbd6:9bf6 with SMTP id
 ba7-20020a170902720700b001c1dbd69bf6mr15446518plb.41.1696914690570; 
 Mon, 09 Oct 2023 22:11:30 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 jh13-20020a170903328d00b001bba7aab822sm10698611plb.5.2023.10.09.22.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 22:11:30 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, pbonzini@redhat.com, qemu-block@nongnu.org,
 stefanha@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 bmeng.cn@gmail.com
Subject: [PATCH] hw/ufs: Fix incorrect register fields
Date: Tue, 10 Oct 2023 14:11:13 +0900
Message-Id: <99bfcf6de904357e6b07084b99193bb16309d46a.1696914208.git.jeuk20.kim@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

This patch fixes invalid ufs register fields.
This fixes an issue reported by Bin Meng that
caused ufs to fail over riscv.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 include/block/ufs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/block/ufs.h b/include/block/ufs.h
index fd884eb8ce..7631a5af10 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -111,14 +111,14 @@ REG32(UECT, offsetof(UfsReg, uect))
 REG32(UECDME, offsetof(UfsReg, uecdme))
 REG32(UTRIACR, offsetof(UfsReg, utriacr))
 REG32(UTRLBA, offsetof(UfsReg, utrlba))
-    FIELD(UTRLBA, UTRLBA, 9, 22)
+    FIELD(UTRLBA, UTRLBA, 10, 22)
 REG32(UTRLBAU, offsetof(UfsReg, utrlbau))
 REG32(UTRLDBR, offsetof(UfsReg, utrldbr))
 REG32(UTRLCLR, offsetof(UfsReg, utrlclr))
 REG32(UTRLRSR, offsetof(UfsReg, utrlrsr))
 REG32(UTRLCNR, offsetof(UfsReg, utrlcnr))
 REG32(UTMRLBA, offsetof(UfsReg, utmrlba))
-    FIELD(UTMRLBA, UTMRLBA, 9, 22)
+    FIELD(UTMRLBA, UTMRLBA, 10, 22)
 REG32(UTMRLBAU, offsetof(UfsReg, utmrlbau))
 REG32(UTMRLDBR, offsetof(UfsReg, utmrldbr))
 REG32(UTMRLCLR, offsetof(UfsReg, utmrlclr))
-- 
2.34.1


