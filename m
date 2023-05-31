Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5127174DB
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:09:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D44-0007Ld-R5; Wed, 31 May 2023 00:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3s-00075E-68
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:48 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3q-0006CC-F4
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:47 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-556d7ac7c7eso1407959eaf.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505825; x=1688097825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AcrCNc6GHVuEoru3kSHnYFGlGWejrWeSQLskEC2DiQ4=;
 b=ZVs2mlXtRioh3s+VQ+Yt8aejz2w3FWWBFXkOnOaDBapiS0C9gGUJDU3xjwpuh4vt04
 avSOhSRvs7vcZwpfx+dLwlHmJ12T8qFVlRD+yv+wG17DaKcLN6VvnpxbpJ54QwSG+0mc
 46A1FKh8rfXT0CAlcy+k9xW4mJJfWrTuOLxLlxOplSSJA8U/56WoLI/pQBZNSyJtRZmH
 95B2sdhgVL2B3CP2tSh64cvAtDxcB01zvvfgRzFZZTH4jcLq/4jtx7EnAIeVc/guCB5w
 FGki7nZCFp5Zu0tfnfSRUde6tVxsVBHjzQ7r1xSWG32snIMW40+Tcbp6SmyupBw3s9Pl
 ysEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505825; x=1688097825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AcrCNc6GHVuEoru3kSHnYFGlGWejrWeSQLskEC2DiQ4=;
 b=U7omXdqkkVnRGJEF2c9tpOsb9eYjd9fccECigIelAPvGUhP2gq+ts3v/b360M9THIa
 TtXsJHnUbsx+Z45M7N7WAbY4J5gm/2FK22MsJWnGdkwXyvlmp82Py64wLmWry2hMM+ne
 b4boCURTK79HapmFUDsWRmlbDBjy36lUKBKO0qsSILDNsH6weO5EsdG/Zk761FBjD3Wg
 QXi86eC+oYf5oCMz8xGIpnNpcmiIfVO021Yq9U4KUlxe1QKsrKzZRkk6Lt7NBEBaU0Zt
 L3A6BPMAsyV2tTYnMjbyPZgz92eVB0j3InPS2F2M3I4mAy8swO6KJa6lMX8kJ85PVhW3
 TnRA==
X-Gm-Message-State: AC+VfDyHszrHQLIZGhv1Ejn1TMSnYZSSmmyula57St4YFEcjOaRByZ5/
 G46moIV9Xh4Wy71lQoKSL9eLT5qaVXZKZPs5jkU=
X-Google-Smtp-Source: ACHHUZ51UU6UBlVaMgxyklOiJJodHxP9FdU+AbqWrYEzUJj94Ud3aUAQqI1VrcGPQzYjxEpZnwQgTg==
X-Received: by 2002:a05:6808:1691:b0:38e:8990:663b with SMTP id
 bb17-20020a056808169100b0038e8990663bmr2686134oib.52.1685505825364; 
 Tue, 30 May 2023 21:03:45 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/48] tcg: Remove outdated comments in helper-head.h
Date: Tue, 30 May 2023 21:03:00 -0700
Message-Id: <20230531040330.8950-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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


