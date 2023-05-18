Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D252970793E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 06:44:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzVRt-00066h-IH; Thu, 18 May 2023 00:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzVRr-00066G-KF
 for qemu-devel@nongnu.org; Thu, 18 May 2023 00:41:07 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzVRm-000771-RF
 for qemu-devel@nongnu.org; Thu, 18 May 2023 00:41:05 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1aaef97652fso12626555ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 21:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684384861; x=1686976861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+ScMm8RFAy9abD2OYSsuUTJ0MCbN7DfgykRl5CDnnQ=;
 b=iqm5RAMSsA1ukUGs634BKvHD1LhxdaUqvqXv8dY6719b9d/SDa/PciLRJWk1NY5JS1
 l2oSD7QqWde8Hewr1Itw/6B5eTybnrv9D8DjESr5rA7O6P2wSI6fxD5ehibVPCytDSVa
 RTr+grAMVEQ4MfMVd1XJ7Q87MvlQOgCKM6lnSwUIkY315BfihHSre6JsmrudYZp1/cbQ
 zWgFAmURH3wDNkTYQwE8zR/+gojPf+MnXFiKO+bqu/68NqzJiLrlTZ4ZfJwt/Qb0siDj
 bNYkfbVS1Mjwve778ueHPRSu3Tr8QYatnBRNUjIXP2rIwejnKQhsgbWOvz+L63OpSPI8
 rXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684384861; x=1686976861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+ScMm8RFAy9abD2OYSsuUTJ0MCbN7DfgykRl5CDnnQ=;
 b=NAmtiQv1tSyOt7i/HSFY3cTEosSuZkuR0OdyNRNY2KS3viTC4px1DztMYqdCveHkTP
 qe/LKWZtI5Jgr//ur0AjJ5uEPMy/wL83v5ZanbLoymXYjeuwFqK1tJdrCUowfxUhZMj4
 tZ/aodF2BUNMwgWBTO3qccVQ83nBxpTf18TkRknE7yyRnTz5+cxvkSGVw6udthf73d2U
 V7tfZjNx1hmXWP05XLlKn5tx+ZLRHOeKc3EgR5QS/mR5iKI/FU5zTlmZKQuf2/ZJFNPm
 At8PTO/owW5w4Ay+5dFoB8f5rtltaV0GL9C7TMADPTFbIySoJUGb+HywurYzeqRtunvh
 o10A==
X-Gm-Message-State: AC+VfDw0NhMwM+KKw1U56WIThkjcN/E9rg6ktwbXzN95JnXM8wa4pQjx
 9Gsx5EJwdA19PnzIne8BO95DbSJq032/7eSsQBo=
X-Google-Smtp-Source: ACHHUZ64Gj/vll5hY4LzMz7NuhglArzWOt8GXlMognEW6BiQs/5ah0JCjkoRyuarS154oFhs7jHppA==
X-Received: by 2002:a17:902:d2c2:b0:1ac:61ad:d6bd with SMTP id
 n2-20020a170902d2c200b001ac61add6bdmr1314610plc.65.1684384861405; 
 Wed, 17 May 2023 21:41:01 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001ab1d23bf5dsm225592plg.258.2023.05.17.21.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 21:41:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/9] util: Introduce host-specific cpuinfo.h
Date: Wed, 17 May 2023 21:40:50 -0700
Message-Id: <20230518044058.2777467-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518044058.2777467-1-richard.henderson@linaro.org>
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Add include/host/{arch,generic} to the project arguments.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: Paolo Bonzini <pbonzini@redhat.com> (maintainer:Meson)
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com> (reviewer:Meson)
Cc: "Daniel P. Berrangé" <berrange@redhat.com> (reviewer:Meson)
Cc: Thomas Huth <thuth@redhat.com> (reviewer:Meson)
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org> (reviewer:Meson)
---
 include/host/generic/cpuinfo.h | 4 ++++
 meson.build                    | 8 ++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 include/host/generic/cpuinfo.h

diff --git a/include/host/generic/cpuinfo.h b/include/host/generic/cpuinfo.h
new file mode 100644
index 0000000000..eca672064a
--- /dev/null
+++ b/include/host/generic/cpuinfo.h
@@ -0,0 +1,4 @@
+/*
+ * No host specific cpu indentification.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
diff --git a/meson.build b/meson.build
index 4dddccb890..0dd806e8a5 100644
--- a/meson.build
+++ b/meson.build
@@ -292,6 +292,14 @@ add_project_arguments('-iquote', '.',
                       '-iquote', meson.current_source_dir() / 'include',
                       language: all_languages)
 
+include_host = meson.current_source_dir() / 'include/host/'
+if fs.is_dir(include_host / host_arch)
+  add_project_arguments('-iquote', include_host / host_arch,
+                        language: all_languages)
+endif
+add_project_arguments('-iquote', include_host / 'generic',
+                      language: all_languages)
+
 sparse = find_program('cgcc', required: get_option('sparse'))
 if sparse.found()
   run_target('sparse',
-- 
2.34.1


