Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B48570DE32
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:56:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ST5-0006Rk-VA; Tue, 23 May 2023 09:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSN-0004xx-JT
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:45 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSL-00033g-B4
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d30ab1ef2so3629540b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850020; x=1687442020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AcrCNc6GHVuEoru3kSHnYFGlGWejrWeSQLskEC2DiQ4=;
 b=JjWvy5SWQ9Hbp0Jn6RSz8Jh91K485QojHlGqMJ2JlQfR2BPMC4y2NFRjDrICnPhq2R
 yDe9/yuYWeVDVVc2jI7zdJdP7Te+flS1QnDWYNl0r8w6pB/qDRaCKX/N30YxBSwow1SM
 re2XlsnAKdgTCMC6IAA9ZYNPH7B9jD/J7QyTz46MB99eEXsqYTno3Bpdr2mim3OdQ7UQ
 Pyn2T+A/64HVoMAjrPI6f/nhEZYAaEcgq66aNTjAGBJ3quTH6irf1koz5eicS1EGJafL
 c57IC7fWFI1dcIfPHZCQi1yGls43diSReva2N0OVrAEWy6DhdzRVC5S8sdLya3+X8F/+
 rBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850020; x=1687442020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AcrCNc6GHVuEoru3kSHnYFGlGWejrWeSQLskEC2DiQ4=;
 b=a4k36KuLCeR40UMCQV12GiYFFy3pKNO3v0Wb3bzqMhwDsXi2hsGDk8bS9zGhubePda
 /KvJiEmo9RP9tvr89Kcm7y5XdrOBxqdgnSQ+XAFX53Q19MEF+1vfoaFK+hFd2oDj07KW
 gk20M+YGIbJGoDgfiJp+QMCVF8Dv2E0zEei3vaPQszDJ58Di8AYEJFrX8nlP3IH0ZiL5
 K/TN1L3asVNgk+mHVpWF0Y8rzRvsKcxjJ5c0hV/vLd4vnTrTVZk3/lI4bIJmUgE0+gjx
 YC0BQTjU1k1/MeKfN38L/+eJCS8NHwFJfZ+nUMDqECuc4SwSb+d0hXQmMSk7OpME/LZ1
 iS8g==
X-Gm-Message-State: AC+VfDxbUqrpDY9mqcA+xVqx5OyZkN/crG5Vf/zKcDMZHkrD5l2BbOpe
 AtdEpXVGwDMNMegpc3WAzjEubSP9nSTAkyBKDwo=
X-Google-Smtp-Source: ACHHUZ4rKJN6kTVggyWkUxKh18TLMoL0hEqNIqo9f9AVhcrrSyPQxAKp+qDl03SGlHhtOoEYofutxw==
X-Received: by 2002:a05:6a00:804:b0:647:d698:56d2 with SMTP id
 m4-20020a056a00080400b00647d69856d2mr19243743pfk.27.1684850019920; 
 Tue, 23 May 2023 06:53:39 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/52] tcg: Remove outdated comments in helper-head.h
Date: Tue, 23 May 2023 06:52:49 -0700
Message-Id: <20230523135322.678948-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-head.h | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
index f863a6ef5d..a355ef8ebe 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -1,18 +1,6 @@
-/* Helper file for declaring TCG helper functions.
-   Used by other helper files.
-
-   Targets should use DEF_HELPER_N and DEF_HELPER_FLAGS_N to declare helper
-   functions.  Names should be specified without the helper_ prefix, and
-   the return and argument types specified.  3 basic types are understood
-   (i32, i64 and ptr).  Additional aliases are provided for convenience and
-   to match the types used by the C helper implementation.
-
-   The target helper.h should be included in all files that use/define
-   helper functions.  THis will ensure that function prototypes are
-   consistent.  In addition it should be included an extra two times for
-   helper.c, defining:
-    GEN_HELPER 1 to produce op generation functions (gen_helper_*)
-    GEN_HELPER 2 to do runtime registration helper functions.
+/*
+ * Helper file for declaring TCG helper functions.
+ * Used by other helper files.
  */
 
 #ifndef EXEC_HELPER_HEAD_H
-- 
2.34.1


