Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5E070E9D9
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:59:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1btL-00048V-IF; Tue, 23 May 2023 19:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btJ-000486-WB
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:10 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btI-0001lW-Cx
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:09 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64d41d8bc63so123776b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886287; x=1687478287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aakLzzWxnODN03CeAWkwF35STfpMNitCSr/+QT2v02E=;
 b=daGukKKAqTHYk8i4H0mEXfHFnA8qwm91DqbBbnvIvFNf/AGCKQkZ34TjB/gt3C6gzV
 Fk1VgYCebp9mu8WfkdPMm9Tw2GOeyyayyuyJQf6E8afF/XYIjYSNhlRfO8yGzZYirWDP
 9RXH9zVECj5d5SD8fuz7FDowG4QP8rUDprtBDPt/GmWfWrHhyL1jjcYyTwhnP8i51L+W
 52D4O1q+QOqci1/iunADc2EmEUGjomFC33zQhEiWpHYa09SeqoslDDcu70/Rvf/SB5jj
 pJGYGl3rMW/fj7r3NVX21kOEPbySkSt8WHWiqwIXaS/4/l7X5jgsxAakrwR25z8RYMyW
 nLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886287; x=1687478287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aakLzzWxnODN03CeAWkwF35STfpMNitCSr/+QT2v02E=;
 b=VdQrLLyUmrJYETPXfsYwnURXpjuTrQEmop5fyxYDxfv14hhB3b9eao3XxN3pWRSDOy
 ybNyYrEdfdnJ32ZgLsZofuH83pCFon1/DcCxHujCCbljXIVdMjG9PbEvxJc1ReBM6U20
 /GllVDfEVINoSWGe2+vHTmW0J3w34Xj/Fjwl72fBk5z04PnTT6roX1AEWlHe2UP6yXGq
 CmTj5G1AcpbIdEHasss4FrvaL4V0pBseF0enzb2LULt0JnEn7r+v6Kgvj1/pzjfG6yKw
 WFY4Y+7SO6E7McXMA18NxRecRk1470PXFzwKtEcU0mygt6vo8w8mlZa8+kHdX61qEEGW
 uEIw==
X-Gm-Message-State: AC+VfDxfrsBRcEld8K9GnwPG0eMhxdYkwk5zXQ/HTmdwQ2jCHDXjKiUm
 KOI//yYDJXngTSNqIqPu9cQID8pvYjdhWKgZ/Qk=
X-Google-Smtp-Source: ACHHUZ4gJsHOUEHRD0QO3Q5dXQ6sgILp9a0/6JC6cZ5qWjr0QyKswJVg9WRSQOvAbyzRgU4VKKEqBA==
X-Received: by 2002:a05:6a00:2341:b0:643:b489:246d with SMTP id
 j1-20020a056a00234100b00643b489246dmr901213pfj.3.1684886287131; 
 Tue, 23 May 2023 16:58:07 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PULL 01/28] util: Introduce host-specific cpuinfo.h
Date: Tue, 23 May 2023 16:57:37 -0700
Message-Id: <20230523235804.747803-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

The entire contents of the header is host-specific, but the
existence of such a header is not, which could prevent some
host specific ifdefs at the top of the file for the include.

Add host/include/{arch,generic} to the project arguments.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/cpuinfo.h |  4 ++++
 meson.build                         | 10 ++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 host/include/generic/host/cpuinfo.h

diff --git a/host/include/generic/host/cpuinfo.h b/host/include/generic/host/cpuinfo.h
new file mode 100644
index 0000000000..eca672064a
--- /dev/null
+++ b/host/include/generic/host/cpuinfo.h
@@ -0,0 +1,4 @@
+/*
+ * No host specific cpu indentification.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
diff --git a/meson.build b/meson.build
index 0a5cdefd4d..c516b911d9 100644
--- a/meson.build
+++ b/meson.build
@@ -512,6 +512,16 @@ add_project_arguments('-iquote', '.',
                       '-iquote', meson.current_source_dir() / 'include',
                       language: all_languages)
 
+# If a host-specific include directory exists, list that first...
+host_include = meson.current_source_dir() / 'host/include/'
+if fs.is_dir(host_include / host_arch)
+  add_project_arguments('-iquote', host_include / host_arch,
+                        language: all_languages)
+endif
+# ... followed by the generic fallback.
+add_project_arguments('-iquote', host_include / 'generic',
+                      language: all_languages)
+
 sparse = find_program('cgcc', required: get_option('sparse'))
 if sparse.found()
   run_target('sparse',
-- 
2.34.1


