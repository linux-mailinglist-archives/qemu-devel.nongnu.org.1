Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5C37174F7
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:14:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D7I-0003cA-QC; Wed, 31 May 2023 00:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D7B-0003Da-OL
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:14 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D79-0006wV-9J
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:13 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-33b89956cccso11265485ab.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685506030; x=1688098030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nI2w8QPEk+92crMZ+axm4/ERglLN4PhhZ5orQ1/925g=;
 b=Cq/ick6QqV21lNpPIiztpihzt90oE0OQ9olUycH7V6jW2qet34KzeBexM++Xw9AW5A
 0gQ6uYUwjwG6vtL5O5nr02EZvDwHpu/usUztxaPrLOAxgg91w1iIXdfl5MBLmssO4wDh
 Pzp8WzFOX6/Div3exW3xy5Rn3+RIHPN4zAfZcQrYRwleEEAolyqKGH0R/IM1WMLRTcjo
 eV0YN02MlXe6AXBxY15Fk7J3XFYVkkTuY+mhlaHrDTiQjrBpxMkbF1TJ3j1jOGsJVODc
 l6mgNt6N1s+ZubIxWshEE43IXgLJ62wMlt2ZA4mNc+foiRwF+us82aaJQRHJubn5agkn
 A2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685506030; x=1688098030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nI2w8QPEk+92crMZ+axm4/ERglLN4PhhZ5orQ1/925g=;
 b=GHmAl3/b848OUF91BDAca+Z0ybey1yRqzS1lKGVfsleDJKOtnaxFY5CayvJfjas2Wk
 ik3L/FD8WRCXzanig6JW47XrEdxMRxGzKHxzZy99AcMqsxSXBKlZHMtpCBYizi/ud8HZ
 5Di/k/H99MSTNrTbGxp+cPEzmu3Vq34EpdG4Gayw5KA+i8NMkEoi7eaLpwToaOFnIr6u
 XNEMqQ1o8f2TYEfLef1/iwGOH6Sp2BPk0v6D4mNIsPhP6WMV2kqY1aep4TOFhhXCpffk
 Yx4+B8IgER94as3vlph6pTIgd9nlwst/VEIxHOOctjwseKvehKMYyd2IJZf0M4b9lZhG
 JkCw==
X-Gm-Message-State: AC+VfDzCvsjoyLdCwrdJc9mCrJVWX6ovSdH1/hZV6cqIcqR4jIX7U0+7
 a38NhofEfsaqndL4wd97vXE5aR3uCoNGhVJC6IA=
X-Google-Smtp-Source: ACHHUZ6/NS44O30FprAJBKwGVxpu3dqlwwtmV6b6+M+FS6xCc4JhVZxy220LvcUl/VVnvzwUi5OYgg==
X-Received: by 2002:a92:d7c2:0:b0:33b:ed95:26df with SMTP id
 g2-20020a92d7c2000000b0033bed9526dfmr819572ilq.32.1685506030138; 
 Tue, 30 May 2023 21:07:10 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170902f7cd00b001aadd0d7364sm151797plw.83.2023.05.30.21.07.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:07:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 48/48] tcg: Build once for system and once for user-only
Date: Tue, 30 May 2023 21:03:30 -0700
Message-Id: <20230531040330.8950-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x134.google.com
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

Create two static libraries for use by each execution mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/meson.build | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tcg/meson.build b/tcg/meson.build
index bdc185a485..565c60bc96 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -1,3 +1,7 @@
+if not get_option('tcg').allowed()
+   subdir_done()
+endif
+
 tcg_ss = ss.source_set()
 
 tcg_ss.add(files(
@@ -14,8 +18,28 @@ tcg_ss.add(files(
 if get_option('tcg_interpreter')
   libffi = dependency('libffi', version: '>=3.0', required: true,
                       method: 'pkg-config')
-  specific_ss.add(libffi)
-  specific_ss.add(files('tci.c'))
+  tcg_ss.add(libffi)
+  tcg_ss.add(files('tci.c'))
 endif
 
-specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
+tcg_ss = tcg_ss.apply(config_host, strict: false)
+
+libtcg_user = static_library('tcg_user',
+                             tcg_ss.sources() + genh,
+                             name_suffix: 'fa',
+                             c_args: '-DCONFIG_USER_ONLY',
+                             build_by_default: have_user)
+
+tcg_user = declare_dependency(link_with: libtcg_user,
+                              dependencies: tcg_ss.dependencies())
+user_ss.add(tcg_user)
+
+libtcg_softmmu = static_library('tcg_softmmu',
+                                tcg_ss.sources() + genh,
+                                name_suffix: 'fa',
+                                c_args: '-DCONFIG_SOFTMMU',
+                                build_by_default: have_system)
+
+tcg_softmmu = declare_dependency(link_with: libtcg_softmmu,
+                                 dependencies: tcg_ss.dependencies())
+softmmu_ss.add(tcg_softmmu)
-- 
2.34.1


