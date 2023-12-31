Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A7C820A94
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:52:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUw-0008BE-1n; Sun, 31 Dec 2023 03:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrTD-0005On-NZ
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrT6-0000sM-61
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKXmM8oXPCPksLCP66tG+EIx4J0iQKzlOhC0Ov9a3p0=;
 b=WaI5r2GyeURyL3fYrke8fTRc93td6Y4Bc1FmLYbGd30+6tv90V/qSPPMV2ZkGGcd8a7Ey8
 UA6F99wwe47m78zkoM8UT7OMSF/Cq9aAczkwgTorqzwvEBf8Iu47x7jurbHxwkeIhHppq/
 qRfhLQhwgr3RE/PU6a+b/g5fd4OjTkw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-3gwouVUZPZewJu2_opyzNQ-1; Sun, 31 Dec 2023 03:46:43 -0500
X-MC-Unique: 3gwouVUZPZewJu2_opyzNQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40d3b0783beso74149785e9.3
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012402; x=1704617202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WKXmM8oXPCPksLCP66tG+EIx4J0iQKzlOhC0Ov9a3p0=;
 b=huYdSQfwOobcupWwSQq92AFkIu8L2vVjyVlMbkliEHSxtburX3TpoVXxNrzQCb2ps2
 LYoHaC7T+jDzswafRV87P2eNFroGvo7jyx/6vB7TcUdj8zN7Zfa2wlXXkq9fyAd5ou/j
 ZqLM3s2annUlkTNkLRhVDxSdeXYM/hLZhHbhRWmN8ZJD+/MV+7pgOLRtzbWLFWYWPA7B
 tAZQiJbPqmf8ZQmyXINja3VTlVEZxOyjdfAn+bxJzmj0jyyi6MfBZyEqbXME3i9AOVO/
 QLRtfjLWSYHwgB3hbsaS6r93ucLS6dE4UimNi2C34RbxEdouInKFnAKDaw8VUDU6WRBa
 bm9Q==
X-Gm-Message-State: AOJu0YyutChXV56xr6By/v69RzoG0hCN8M/HS0t1OszPpAcDzjq4OdWc
 rIoWaY8+JRoMb5gO0zSrduuuiFqi4Tdsxdj6zcmzFVztTeudvoJ22pzgOetJi8bLqF6SoFSEVGU
 VFRfHFxm4gbjKYo7tj5t+Xr3vVwJNEzNnDxmQfCrujzRGnX25WlSXgur3RNJAxH+TMMXKKxTO17
 GZIYRgnh4=
X-Received: by 2002:a05:600c:4e8f:b0:40d:5f55:5d4 with SMTP id
 f15-20020a05600c4e8f00b0040d5f5505d4mr2977005wmq.13.1704012402224; 
 Sun, 31 Dec 2023 00:46:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELzC4w8dPQXmZk21UjrlQjDLW1/CFHEqvlacawel/03VVNfqxeWRcuFucV2CSxSHWTZ2eMxQ==
X-Received: by 2002:a05:600c:4e8f:b0:40d:5f55:5d4 with SMTP id
 f15-20020a05600c4e8f00b0040d5f5505d4mr2976999wmq.13.1704012401885; 
 Sun, 31 Dec 2023 00:46:41 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 bg42-20020a05600c3caa00b0040d6b91efd9sm11301036wmb.44.2023.12.31.00.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/46] meson: move subdirs to "Collect sources" section
Date: Sun, 31 Dec 2023 09:44:54 +0100
Message-ID: <20231231084502.235366-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 66 ++++++++++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/meson.build b/meson.build
index 151db21c038..21335055ef8 100644
--- a/meson.build
+++ b/meson.build
@@ -3257,39 +3257,6 @@ foreach d : hx_headers
 endforeach
 genh += hxdep
 
-###################
-# Collect sources #
-###################
-
-authz_ss = ss.source_set()
-blockdev_ss = ss.source_set()
-block_ss = ss.source_set()
-chardev_ss = ss.source_set()
-common_ss = ss.source_set()
-crypto_ss = ss.source_set()
-hwcore_ss = ss.source_set()
-io_ss = ss.source_set()
-qmp_ss = ss.source_set()
-qom_ss = ss.source_set()
-system_ss = ss.source_set()
-specific_fuzz_ss = ss.source_set()
-specific_ss = ss.source_set()
-stub_ss = ss.source_set()
-trace_ss = ss.source_set()
-user_ss = ss.source_set()
-util_ss = ss.source_set()
-
-# accel modules
-qtest_module_ss = ss.source_set()
-tcg_module_ss = ss.source_set()
-
-modules = {}
-target_modules = {}
-hw_arch = {}
-target_arch = {}
-target_system_arch = {}
-target_user_arch = {}
-
 ###############
 # Trace files #
 ###############
@@ -3404,6 +3371,39 @@ if have_system or have_user
   ]
 endif
 
+###################
+# Collect sources #
+###################
+
+authz_ss = ss.source_set()
+blockdev_ss = ss.source_set()
+block_ss = ss.source_set()
+chardev_ss = ss.source_set()
+common_ss = ss.source_set()
+crypto_ss = ss.source_set()
+hwcore_ss = ss.source_set()
+io_ss = ss.source_set()
+qmp_ss = ss.source_set()
+qom_ss = ss.source_set()
+system_ss = ss.source_set()
+specific_fuzz_ss = ss.source_set()
+specific_ss = ss.source_set()
+stub_ss = ss.source_set()
+trace_ss = ss.source_set()
+user_ss = ss.source_set()
+util_ss = ss.source_set()
+
+# accel modules
+qtest_module_ss = ss.source_set()
+tcg_module_ss = ss.source_set()
+
+modules = {}
+target_modules = {}
+hw_arch = {}
+target_arch = {}
+target_system_arch = {}
+target_user_arch = {}
+
 # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
 # that is filled in by qapi/.
 subdir('qapi')
-- 
2.43.0


