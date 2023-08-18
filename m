Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E755B78115C
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:14:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX32b-0000C4-5c; Fri, 18 Aug 2023 13:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX324-0008OG-5Y
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:08 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX322-000888-Nu
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:07 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bbff6b2679so8857105ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378785; x=1692983585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eX7UbTtp2FKEl6qFq7PUJtVbZ6Ita44vPDDEXKDHPg0=;
 b=lVT6TDsvgBeXc9GhiloNeJDVsWw8NpnT5ahjvF0tncObtjjwI8wL3ft22Tp6RA82i8
 8+OIrXvRiw+6dg9YwxogUdCfOVkip1YJRvOP28qyOUb7u7ePPGq94Jm7QzwYB2mS1For
 Ye0J/C8iWDZYTvoKn9k40AdpS0oBGAatTCG8PMPhcE+ljowk3WQnSQGhd6cqbRm+GDjs
 60yKxMEl9CL3wlKATG10enN0ixpcfJg3+Ab8oPEHbZKgXENq26NTURhVSIhO/+5oF8AI
 GsT6hhLSN1VGCrEwALyexU+ZvTh/R+6zlYrLt6eE9dSvwMlR6NjPePwADJzCAw6C8zCz
 EeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378785; x=1692983585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eX7UbTtp2FKEl6qFq7PUJtVbZ6Ita44vPDDEXKDHPg0=;
 b=fkOET0yMUR1x5RhuEjXBwtAbUlJHqilS0Ue29O82orK+3DGKlHZK1Lam6NhqWkoF88
 hmfhE0fyjVioGzEb0wG2WUx35E+nZKhO9IsDeU6vxAtrnN85l64WH09ow3eFcvRPy+gS
 MtiRvvuS6ye2OrHIXfEoSUV6vwwkeI3vW750O1oUk/tPxnE8D6S6fQ0ppinQ3YWaRoR+
 I8dyC3iV9q5maluoWNQPrqbKw2v+CPjOQ6++6oYLsx702fErFP++vEd4aRMQyHUNJpYd
 VASGBxghK/675Kl7+2IwN8MCDquyKHFcASzCEKur86YPc58T3y9G7rUYrKDa33mSBzWO
 s99Q==
X-Gm-Message-State: AOJu0YwN6A3kE0Q6TUxLLEnbmEqAdlR+H448NNIRzLO49EA1xmHmH6Ao
 EflskTyLUqJEPqaI+82n0j89sYGsrUdL9AEkaa4=
X-Google-Smtp-Source: AGHT+IF8ypgOa4JtxMMUj5qxbuw6RxP+5zzlXsFTrHxiLW7Gqgn7UdAauGOvTxAmH4G1KVYnyUM/5g==
X-Received: by 2002:a17:902:8688:b0:1bd:d141:f02d with SMTP id
 g8-20020a170902868800b001bdd141f02dmr2711161plo.68.1692378785437; 
 Fri, 18 Aug 2023 10:13:05 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.13.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:13:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 32/33] target/ppc: Enable TARGET_PAGE_BITS_VARY for user-only
Date: Fri, 18 Aug 2023 10:12:26 -0700
Message-Id: <20230818171227.141728-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Since ppc binaries are generally built for multiple
page sizes, it is trivial to allow the page size to vary.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu-param.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 0a0416e0a8..b7ad52de03 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -31,6 +31,13 @@
 # define TARGET_PHYS_ADDR_SPACE_BITS 36
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
-#define TARGET_PAGE_BITS 12
+
+#ifdef CONFIG_USER_ONLY
+/* Allow user-only to vary page size from 4k */
+# define TARGET_PAGE_BITS_VARY
+# define TARGET_PAGE_BITS_MIN 12
+#else
+# define TARGET_PAGE_BITS 12
+#endif
 
 #endif
-- 
2.34.1


