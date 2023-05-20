Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA87270A933
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:31:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PPn-0003Wq-S3; Sat, 20 May 2023 12:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PPl-0003VA-PK
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:26:41 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PPi-000349-I9
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:26:41 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ae507af2e5so14196295ad.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684599997; x=1687191997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qoslcpBGrNylzkKTGRsE4PymBBD7m5mdTsORg0M/q+0=;
 b=T64ArRbUugSqIW7icPZKpZ9mqaN+wHRWLTFNW+h7CUqPl8ADdAGpTHdprrVGukBILX
 HKp4EAvdyZRK6GTkExyn3zJU9f1bfajV/tOTa9JYHgC2iO42w4BkODy8ShVHlIPGvhwL
 zow1U/aif9AhGdkFlMYiGXPHNuIHpUdBMVjg7neSb9/UP9ZCFmc+LsyA1tB0+NNw+gdm
 XtyXJ62o7QRIO0btYuaCxr4StKwEHqJWiMl19/Bj1n8VPTMReQv222t1T5hxEayH4/Z+
 hoUh7ZTkFceww5lYUJF0AaFnFCAkKAxoUiZkttYzzvgSOtqj4Ce5KxhSyR3wg7PT7weB
 MtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684599997; x=1687191997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qoslcpBGrNylzkKTGRsE4PymBBD7m5mdTsORg0M/q+0=;
 b=GpNUS/VqMOd+1euOWqD1Dj0XeUDsyJi+2+GyFJokXRPaGG8GvXlAxhcCqXFZFmigZX
 NGjFhYAA43L5kN4qvxKpBfA0TKyPJSR8PIXPsYdD3FayA9FdlJWB4YtKzzy9KMoThj58
 4gKge1WA4b0PbeUV+nUlII+cP91n7ies4r00KEeWKaOiQT+M3A/gWc0eepxnEEwBmpUm
 PfPyXHaNe9OLWcMbADJOGlP/AJ0Uw4gq3j9UOAnADm+DnY3WHd1KkbRPxH7+wznHdYv6
 fgd4YNso6X2tYp/LN8xIRr9B/aCTZLJQtmJRICzyEFSZRmZmJiWUNB/0yB/+XRkhEvPw
 Ukgg==
X-Gm-Message-State: AC+VfDzvhODP1RBVGwz9HsnRz5rJiatEs8i726ONDF0oN7IJ1rwiBJY1
 5YUoRMlFrTx7UN4QqN5eztYPUllUzXRKXGKOBk4=
X-Google-Smtp-Source: ACHHUZ689Mni3gG8M7PnRO5LuwZ4g+5X4CreDUibKeiRIWAosQkCoylbIs3JdFAdgyolIdpN5+l9Eg==
X-Received: by 2002:a17:903:2444:b0:1a6:9762:6eed with SMTP id
 l4-20020a170903244400b001a697626eedmr7579258pls.22.1684599997354; 
 Sat, 20 May 2023 09:26:37 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:26:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Juan Quintela <quintela@redhat.com>
Subject: [PATCH 01/27] util: Introduce host-specific cpuinfo.h
Date: Sat, 20 May 2023 09:26:08 -0700
Message-Id: <20230520162634.3991009-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520162634.3991009-1-richard.henderson@linaro.org>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/cpuinfo.h | 4 ++++
 meson.build                         | 8 ++++++++
 2 files changed, 12 insertions(+)
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
index 0a5cdefd4d..4ffc0d3e59 100644
--- a/meson.build
+++ b/meson.build
@@ -512,6 +512,14 @@ add_project_arguments('-iquote', '.',
                       '-iquote', meson.current_source_dir() / 'include',
                       language: all_languages)
 
+host_include = meson.current_source_dir() / 'host/include/'
+if fs.is_dir(host_include / host_arch)
+  add_project_arguments('-iquote', host_include / host_arch,
+                        language: all_languages)
+endif
+add_project_arguments('-iquote', host_include / 'generic',
+                      language: all_languages)
+
 sparse = find_program('cgcc', required: get_option('sparse'))
 if sparse.found()
   run_target('sparse',
-- 
2.34.1


