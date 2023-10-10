Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 664417BF4DF
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:53:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7Y2-0004aM-8i; Tue, 10 Oct 2023 03:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7Xz-0004Yi-G3; Tue, 10 Oct 2023 03:52:56 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7Xx-0005Fv-FN; Tue, 10 Oct 2023 03:52:54 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7b5fd3d0d7eso199053241.0; 
 Tue, 10 Oct 2023 00:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696924372; x=1697529172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqOeK0/4KlKokdTq+gvtYVKstLq2Zxm+SQKNVRGnoUw=;
 b=elog3bUZmKk1Hn4JITSbCXtrQON1b9cta5647ZML9mnXV+ZdykLr80IuhpFuIGvMG+
 OEV7R9/1eGQcKvhLuYrdEP6e1UsTy/B2KMfuqp4LA0wnWjV2vO/ek/K3kF9DdejoR1EK
 1lEUdFlEir6ZUEkNqhbI1ex+JFoCFG0wIXnxAurP02ymt9n+J776f4o7S6PRGnMLNTJp
 nG35TEe3DQUpB56iQhlSltVX15KPXfsaSpk/1N33tnEKxqLV3URGZ1dWfbOiyJJbOdJW
 3X4Frn3RKtBXtMA4/wLNUtzhiXGvaHG35E5unLSzHqfms52CG0ErTclvvvZfULIXeLIy
 CVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924372; x=1697529172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqOeK0/4KlKokdTq+gvtYVKstLq2Zxm+SQKNVRGnoUw=;
 b=g+xuEm8s3Q+G5y5YqyAHzmunbhgOf0UGYdZa15ryyzCWiAdEfBUCmXcl9JDBkxl2NG
 YIFW8MIGoBGvq1f9O3CCKijxxnIeIUvsVA0DS1NuF/0En9abk0MpMjlERr4BfrigvTd4
 YiIAXQZidHUfgb5Y7BHGuK/qJN410R5GpCiQ1XTicOhx9+sZ2H6m7/eRfSqLbxKFPTWs
 MwLc8x4rTjn8/2NUa8s4QPWwspEHJrBF/1+LZoi3V887aztmmTvYKX5p/nyzLMwNM73S
 v9RlPxuoth5kmDAYtiSlpV0ONsUNPZ18zx7OLu6WdMUGv+AA4YXmTSkRHvFvv7IwVJtw
 Fr2g==
X-Gm-Message-State: AOJu0YyIyChOnA2TdFjMa5pLgBXXKgznL5OuuVrMs7o6x2bwByQgd5uM
 QGxwnNTk1QMIi7CvkiTskvZlao0WvEY=
X-Google-Smtp-Source: AGHT+IGSxfNKGu2U1uIoBjwkp81iseKPFUM6R9ESwpnxxVH4M+PutpazvrFa3PGHu7/G5wiwE0MOOg==
X-Received: by 2002:a1f:ddc2:0:b0:49a:36e4:5565 with SMTP id
 u185-20020a1fddc2000000b0049a36e45565mr13319788vkg.16.1696924371714; 
 Tue, 10 Oct 2023 00:52:51 -0700 (PDT)
Received: from wheely.local0.net (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a62e215000000b0069353ac3d3esm7548102pfi.38.2023.10.10.00.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 00:52:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 01/11] tests/avocado: ppc add powernv10 boot_linux_console
 test
Date: Tue, 10 Oct 2023 17:52:28 +1000
Message-ID: <20231010075238.95646-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010075238.95646-1-npiggin@gmail.com>
References: <20231010075238.95646-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=npiggin@gmail.com; helo=mail-ua1-x936.google.com
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

Add a powernv POWER10 variant for boot_linux_console.py.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/boot_linux_console.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 01ee149812..9434304cd3 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1393,6 +1393,14 @@ def test_ppc_powernv9(self):
         """
         self.do_test_ppc64_powernv('P9')
 
+    def test_ppc_powernv10(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv10
+        :avocado: tags=accel:tcg
+        """
+        self.do_test_ppc64_powernv('P10')
+
     def test_ppc_g3beige(self):
         """
         :avocado: tags=arch:ppc
-- 
2.42.0


