Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A56C70DDF7
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:51:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SMW-0008A1-MO; Tue, 23 May 2023 09:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMV-00089S-5J
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:39 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMT-000136-J4
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:38 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d2b42a8f9so4260844b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849656; x=1687441656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2ONWtUa3lpwntXaI3kn7ynLd1Z1O2L+f7C0TvCO4wU=;
 b=cqzGhOzm1eS7GSolGIZ6egzVxNRnL09T2h/sjV+t8QzzkvNM7ZTjqMCRy1T4GjmM/z
 a7KXwAkl+f5ZKNcfLK9irey1pbEShZn1+i6RtnypD8saI65zwlcFFkthVUxS3w8dbJzN
 UgGm+b/f2w7MI82AJCE8g35fOqzH0DOcz1FZaNetBPKSJ3QW4/Ig7Cu2/4Dh6mt61/NT
 2uuaTlkbB/SWHsJGGmjixYwdNjKxDoM1AcMKb9s97qgy2M5T5UK61OoQGSSEJdn+xmjs
 Gnd/NvHYD2Bw3cGjx8HMAIMJy9aCOb/lMxFkNRW37s9amzUd8VaX61UA69eYvqSUVXX6
 ddFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849656; x=1687441656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S2ONWtUa3lpwntXaI3kn7ynLd1Z1O2L+f7C0TvCO4wU=;
 b=dAhkmUWFvfs7tgXqVwMtimQWro21vkNHNrnmSa/vQ6q8MYeOcd3U2VVtRc2pf+EJUg
 gsXQI+gVlAvzgGa/LlGNjv8u1oFfMa9XxbHJMtPPqZuntd9E509b0kOlLiQr/XUmxQAm
 +aE8XCbDJT3whzgWpRk72TEU36+wGfbaTtpDOPy5m7tlMDi33UwXaUVtstQOAby7l8sr
 OACUJFkZlwxt+gQqytzgwDQZ3dd1Ksd/rpISbCjTWP1EeccsfPgcPN5/jFAWzzmxA7T1
 y/yf3ivlWPuwBR6srrQMsvs3uQ1h+eRZM4H/TlXlfmeKg/4PROTFaoN5nIqI1ZiotvQs
 TjuQ==
X-Gm-Message-State: AC+VfDyiMVOdRBRmnK5P/fuDrUaEg/rfaEs6VnfL20RzX4TA39L9vJjJ
 Nsz9m0rEmK8K5kZXcu17cUyfWHpp2YxAd+F0Rck=
X-Google-Smtp-Source: ACHHUZ6AaIxgOUXtKL0+zW7SVb8rmUMNcEEh0OEslKzOvZRRDK1x0+OBvQHRhkGJ3jetJVJDvc63fA==
X-Received: by 2002:a05:6a00:2d26:b0:643:b489:246d with SMTP id
 fa38-20020a056a002d2600b00643b489246dmr18078532pfb.3.1684849655941; 
 Tue, 23 May 2023 06:47:35 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm5737122pfa.199.2023.05.23.06.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:47:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 01/27] util: Introduce host-specific cpuinfo.h
Date: Tue, 23 May 2023 06:47:07 -0700
Message-Id: <20230523134733.678646-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523134733.678646-1-richard.henderson@linaro.org>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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


