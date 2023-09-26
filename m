Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D24BE7AF17F
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:01:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBQa-0003yn-25; Tue, 26 Sep 2023 13:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPk-0002Bz-DT
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 13:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPi-0006ka-M2
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 13:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=191HqQRlJVK6YDjgA38pPiD49wHIVPYKaP2RWYAVpb8=;
 b=XMRPxxKLi+zSqeOzxIZ/DyyxO3XtFsUa5fzLrmI/F/4zbnZ81trxuxqpkT4WBHBRy8Zwjz
 QKp8oy6jw8/S+mQ/9r3m/JvUTSLFCXCmZN0+Tl07WzT5fFfSi5sRyw9IPhVGhVU2VrKbhE
 OCCgrHz0mKXRgQXy2vZXvG3XtOkJ2tE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-cxcDDWSGOXS8jYgT9lNHgw-1; Tue, 26 Sep 2023 12:59:51 -0400
X-MC-Unique: cxcDDWSGOXS8jYgT9lNHgw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40554735995so65838015e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747590; x=1696352390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=191HqQRlJVK6YDjgA38pPiD49wHIVPYKaP2RWYAVpb8=;
 b=PTGBiFmnWJ5WtSOCh4JaImYZjqI3hvKVfOLdzO6wQMZYv/chxi/axzTROLGyI5TXhy
 tBhqEPbtNDkpmgVNqlnzlDYZW5gUX9eVOuah9tubUjvztTSQvWG8V8hP8fE2pfUHv+n+
 HClup23YsLL86ILaeEwzzBSznd4LWExNPQQ07WmUvM2PytDJ2dmj5I/ifvCxTnErnzKG
 H+zIWPHeH+aLJxnUMHqMnaqbHcP7wn9siD9LRg0kr1xLeyq3agn5+/JSN3QcSOFRqZ8D
 s2Qqdhep0yR+wo5lWyz0LK+z8UGRXU894aqpJbyDRmM1oROeu7pj7ZweHJF1Ta4rtxFC
 icjw==
X-Gm-Message-State: AOJu0Yyi9EXd1+ntBH6dQF7u5uUhLdVjKtNNYQ/tKuVcmmu8Lsspl8wt
 Ni5CPBF7lWm+fhor7ZjugTf+29GyNBhtcqu7HF0HvlD0SnJ/7p/nRLddUlJqtk0frVXpNGqhTz0
 uAkMQDsO6wWMO27SykJVcBxGs+qN25FJKHGgx5MgNd/mKC2nwPO+xpObrC8zGHsu87p9N0rj8zh
 s=
X-Received: by 2002:a7b:c4cb:0:b0:404:f9c1:d5d7 with SMTP id
 g11-20020a7bc4cb000000b00404f9c1d5d7mr10400167wmk.25.1695747590073; 
 Tue, 26 Sep 2023 09:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAPaIhKxxf8F4Ru+UCrWr330RF1Uwa+n+I14EoWwVfWcxfnLq68quEZ54aTV3hZMUqz0ohGw==
X-Received: by 2002:a7b:c4cb:0:b0:404:f9c1:d5d7 with SMTP id
 g11-20020a7bc4cb000000b00404f9c1d5d7mr10400157wmk.25.1695747589754; 
 Tue, 26 Sep 2023 09:59:49 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 g16-20020adfa490000000b003232380ffd5sm7075818wrb.106.2023.09.26.09.59.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/19] compiler: introduce QEMU_ANNOTATE
Date: Tue, 26 Sep 2023 18:59:14 +0200
Message-ID: <20230926165915.738719-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allow a more shorter syntax when defining wrapper macros for
__attribute__((annotate(...))).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/compiler.h | 6 ++++++
 include/qemu/osdep.h    | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index a309f90c768..7fda29b445f 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -197,4 +197,10 @@
 #define BUILTIN_SUBCLL_BROKEN
 #endif
 
+#if __has_attribute(annotate)
+#define QEMU_ANNOTATE(x) __attribute__((annotate(x)))
+#else
+#define QEMU_ANNOTATE(x)
+#endif
+
 #endif /* COMPILER_H */
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 2897720facd..e4a4eb2d613 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -185,7 +185,7 @@ extern "C" {
  *   }
  */
 #ifdef __clang__
-#define coroutine_fn __attribute__((__annotate__("coroutine_fn")))
+#define coroutine_fn QEMU_ANNOTATE("coroutine_fn")
 #else
 #define coroutine_fn
 #endif
@@ -195,7 +195,7 @@ extern "C" {
  * but can handle running in non-coroutine context too.
  */
 #ifdef __clang__
-#define coroutine_mixed_fn __attribute__((__annotate__("coroutine_mixed_fn")))
+#define coroutine_mixed_fn QEMU_ANNOTATE("coroutine_mixed_fn")
 #else
 #define coroutine_mixed_fn
 #endif
@@ -224,7 +224,7 @@ extern "C" {
  *   }
  */
 #ifdef __clang__
-#define no_coroutine_fn __attribute__((__annotate__("no_coroutine_fn")))
+#define no_coroutine_fn QEMU_ANNOTATE("no_coroutine_fn")
 #else
 #define no_coroutine_fn
 #endif
-- 
2.41.0


