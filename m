Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA5381BD19
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:23:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMjD-0007nU-CV; Thu, 21 Dec 2023 12:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMjB-0007lF-AY
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMix-0004Zr-3m
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1m2wPSj7DrnfvV9Gjd90UAkjCJ7uIusEMq8OUj5cMGw=;
 b=Sa1DmLKAQPsVfiiOUcNSqmaXN4I3j4JWyPYfG3yWw6jkoetvuZydriUgOM3Ga5kNMQhDut
 VxKQHy45Uzt+4jQVsLshnEPQsZPtmzypHuptbDV0XuQphxAT/TbhyKq1ulG0OC+4jcJIW1
 8ND5DM3+KWQNbVgKI6UeNOiUhoYjopw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-6gaTSKL4PNyfZoCIUV3qWA-1; Thu, 21 Dec 2023 12:20:40 -0500
X-MC-Unique: 6gaTSKL4PNyfZoCIUV3qWA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33680148d24so714931f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179239; x=1703784039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1m2wPSj7DrnfvV9Gjd90UAkjCJ7uIusEMq8OUj5cMGw=;
 b=jWadr3nwi6AIA94febbrYNlF80Qd3MXL0pb6e+T2AW5Hvklq9JHU9LiX2LrKyRexrW
 WIK4k5WACADrBm74loZ61A0/tkylh2WnpEBBP6pjfBOF3Rnz6mChYvphyrG2AmpFqNle
 6KC8DnR5I4xWXVqXUeVcbWAX33f4Dn/NWiBvGaQRISyMDxfCJ/FUzWxC7rnQz466HgYv
 GfAly+V4km4gd5EjkUPvPi+7SMEehi99sLcuKkYnAAQjrhDq74uovLtL3kXzdeUV0HCQ
 baBJGVAawXfyeLsV9cGATPVJ6zMK5qTqQ5rTIRO0bcMeIwNEzLtEm2YK9TQzCIFyyV9k
 bXZg==
X-Gm-Message-State: AOJu0Yw6Qij/qjspme3xbPDA+WhV7WfvraHIG/h6eaKgpJ1eWIunVtBR
 mNuq5J+y0afjCueUvd64a7RkZ+MdYKT9qqQWlO+8QfLm8rPpz2y7mDo6dRjo4Jja8o9GJRREW8t
 D5pN1MITbHPm7O4lpBxvaSuKkdPQxxzd0ZpLqHHsGI//vJNRR/lsCxofHgGd574B5Rq9fGanAKr
 4/UFlL7FI=
X-Received: by 2002:a1c:4b18:0:b0:40c:3c72:608f with SMTP id
 y24-20020a1c4b18000000b0040c3c72608fmr34947wma.17.1703179238773; 
 Thu, 21 Dec 2023 09:20:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVtDstDJqDQdErwglKsxecDlXUosCEksWmHUgOJndXe8rkPJ2vokCqT9GCrKBjp3MkNkZxIw==
X-Received: by 2002:a1c:4b18:0:b0:40c:3c72:608f with SMTP id
 y24-20020a1c4b18000000b0040c3c72608fmr34944wma.17.1703179238498; 
 Thu, 21 Dec 2023 09:20:38 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c4fd400b0040b37f1079dsm11811388wmq.29.2023.12.21.09.20.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/21] meson: move subdirs to "Collect sources" section
Date: Thu, 21 Dec 2023 18:19:57 +0100
Message-ID: <20231221171958.59350-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221171958.59350-1-pbonzini@redhat.com>
References: <20231221171958.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 66 ++++++++++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/meson.build b/meson.build
index 57821069e91..6cf70cbfb89 100644
--- a/meson.build
+++ b/meson.build
@@ -3221,39 +3221,6 @@ foreach d : hx_headers
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
@@ -3368,6 +3335,39 @@ if have_system or have_user
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


