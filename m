Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7417B6FC7
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:32:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjEw-0008Lh-Vf; Tue, 03 Oct 2023 13:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEi-0008Fw-Rt
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:18 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEg-0007Ss-DU
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:08 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57bb6a2481fso650103eaf.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354265; x=1696959065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3wrIxgr2m5oHMVkH4v8wSAkRBNGt7xc6AFyiVFHwxo=;
 b=ZtoABmUtIrXDFvVTVJsSXPZ8klkFsGAczdU7RZhe6k4uNKZH0vqbl0xuro4/inI+KL
 Mxm8zJiNuZwknkE0oah1jSnbq7bwi7CIOXKrYtSNvftEhyxmvrU9a91RfPW6wm0H9zTI
 h9Lg87TRUrw5pettygtkRk5VzOi3EfjSqKT6qnMciDaSpi/7SKHWRhVLS4l9Mrlub47h
 l9tPy80rBFlVdOOeDcwNULbqnD9EC5oqL3VlNEe4cknEMV82ZpThyEz7c/8/Gfny6+qH
 BG6qHtnEgo1YLEF2YK3F2yHR4+riy5YhKk3k7ATqydRxnOE8QE7Bw3X1Dv9CS/y4sG0/
 W8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354265; x=1696959065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i3wrIxgr2m5oHMVkH4v8wSAkRBNGt7xc6AFyiVFHwxo=;
 b=kAZxKcV+42NlLOrzbEMQNx4t13PpWSrGf48czUI0KSNiCRZf4ibjwtnN26fLX06kk3
 9OGAfycjitMUv+ViFH1SscGD/jXNXsqphdyvy+Qcjd93jBeezJ+BEkWoElGmOwZi5DDn
 2b2qZSMFsM+V1cu71PvObXDYXLdtiIEyU2Y6IPpiK5gpAfLRgxu6UQ3wx7SmxwERAe1J
 vjWc/E2TmqOklh7IvvXYaaDbidyPo5iIdpI9oprQo6ZErn4UdvGjrkgKLBnl7F/wL2gR
 kOSF6BKrS3xou6E9JVb7mduyN/ozDt0r8ZfS/RD8jrb9sc0UGtTABanxjWhhbxinE4zb
 I7RA==
X-Gm-Message-State: AOJu0Yw3YaHdxKDELQuBaHKVjFBVi7HJJAYscKK1OoZRbhW8UxcabAyO
 QN2Uy9wWcZM0JSeiDymSzDbTEV7m9fxk17TdzMc=
X-Google-Smtp-Source: AGHT+IGSmQIacppaytt8AKctsYAV1IxSWjsvHjqVHzBtBgXUEZ2jNRgDnItZlP1BzbutaQxO6LeIgQ==
X-Received: by 2002:a05:6358:720c:b0:141:162:b0d8 with SMTP id
 h12-20020a056358720c00b001410162b0d8mr59585rwa.30.1696354265314; 
 Tue, 03 Oct 2023 10:31:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/47] qom: Propagate alignment through type system
Date: Tue,  3 Oct 2023 10:30:15 -0700
Message-Id: <20231003173052.1601813-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

Propagate alignment just like size.  This is required in order to
get the correct alignment on most cpu subclasses where the size and
alignment is only specified for the base cpu type.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 qom/object.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index e25f1e96db..8557fe8e4e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -220,6 +220,19 @@ static size_t type_object_get_size(TypeImpl *ti)
     return 0;
 }
 
+static size_t type_object_get_align(TypeImpl *ti)
+{
+    if (ti->instance_align) {
+        return ti->instance_align;
+    }
+
+    if (type_has_parent(ti)) {
+        return type_object_get_align(type_get_parent(ti));
+    }
+
+    return 0;
+}
+
 size_t object_type_get_instance_size(const char *typename)
 {
     TypeImpl *type = type_get_by_name(typename);
@@ -293,6 +306,7 @@ static void type_initialize(TypeImpl *ti)
 
     ti->class_size = type_class_get_size(ti);
     ti->instance_size = type_object_get_size(ti);
+    ti->instance_align = type_object_get_align(ti);
     /* Any type with zero instance_size is implicitly abstract.
      * This means interface types are all abstract.
      */
-- 
2.34.1


