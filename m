Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D225178C0A6
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:41:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qauH0-0003pk-5k; Tue, 29 Aug 2023 04:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qauGu-0003n2-P9
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:40:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qauGo-0004NB-KH
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693298417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=30TWRvtV0LzAFRH9ZKYnRNdavxd+YNNeR7JdSbUN4yA=;
 b=eTDxNo+iJ6j1YvkxojFaXvsJwvQsGZSp1HhPye8B6KJ/21bVnNS+orVBRDDBtmhUcAEIlV
 O8SoEa/UL+UsJgOsd/fvWuGfWipL8bqDeGsJXjQswFgOSnAXQLU3QmGUrQxgyh7wZF8jCL
 fvMYHMaty0n11+dXY4zgvvYZVHeWFvQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-7ReqlNndPoafalyDphOJGw-1; Tue, 29 Aug 2023 04:40:16 -0400
X-MC-Unique: 7ReqlNndPoafalyDphOJGw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31c5cc5537dso2528531f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693298414; x=1693903214;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=30TWRvtV0LzAFRH9ZKYnRNdavxd+YNNeR7JdSbUN4yA=;
 b=fmXsADU5QSEhw5ht0nt345QJCK7W982fCo2D0ubsmAvt2z1DUQtEHGGrnnVeS5N3gK
 I9uL8AgETMQP42BMCYGx/1VgMKOCTZLfZ2iLJuttA+zCLrg2Lq+W2CLKtDuqdeNPnlWR
 ZiflbxOvgFBY81CXuEPTP/QEQLo659Cvom6Lporg0YGqf/4OiCQCCkyBIm3t9xtXztLW
 pDNoOmPq4IP5zsUeCCwmacV+fF78fy9pNt5QBDkqYMo73hQqm3clifeq0Czcf3f89Ggy
 RbW7oOijxXXl/uIALZP5Nti7qQ1W+0AzZAP6nRqHhORj3qXbJb6IsnRV8pFXzP7eNEPL
 WSBw==
X-Gm-Message-State: AOJu0YwOrCnQwG7Zf12hbE/1wNEQrVr/Lq+2vBePV6/aWQJIL4R8v0nk
 v1nxzN9gnP1BJTvVQSLi9kwrI1w2YJ6wMp6Zx1Key/msoIFUSqY1ZCarQtMWi9xwQnmfXk/afBs
 kVGM+BkxR8Oc2k8wxQ7kWCFpmh5DSoqgzP8CoBIn7aAAUmzNjc/3EkNs2m/FHsQzQPdHYu0zHus
 s=
X-Received: by 2002:a5d:6508:0:b0:317:558c:c15e with SMTP id
 x8-20020a5d6508000000b00317558cc15emr1271746wru.27.1693298414688; 
 Tue, 29 Aug 2023 01:40:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLHguTRViRBAFPGPiJcXMCPUzmoyb7eLaI627XMgT1W2T1mIUttWxdx+/9IfPPjyndeEn3JQ==
X-Received: by 2002:a5d:6508:0:b0:317:558c:c15e with SMTP id
 x8-20020a5d6508000000b00317558cc15emr1271736wru.27.1693298414296; 
 Tue, 29 Aug 2023 01:40:14 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a1cf308000000b003fe2de3f94fsm13174424wmq.12.2023.08.29.01.40.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 01:40:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user,
 bsd-user: disable on unsupported host architectures
Date: Tue, 29 Aug 2023 10:40:07 +0200
Message-ID: <20230829084007.69019-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Safe signal handling around system calls is mandatory for user-mode
emulation, and requires a small piece of handwritten assembly code.
So refuse to compile unless the common-user/host subdirectory exists
for the host architecture that was detected or selected with --cpu.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/configure b/configure
index 40729a6d5f5..64d501ef710 100755
--- a/configure
+++ b/configure
@@ -856,30 +856,36 @@ fi
 default_target_list=""
 mak_wilds=""
 
-if [ "$linux_user" != no ]; then
-    if [ "$targetos" = linux ] && [ -n "$host_arch" ]; then
-        linux_user=yes
-    elif [ "$linux_user" = yes ]; then
-        error_exit "linux-user not supported on this architecture"
+if [ -n "$host_arch" ] && [ -d "$source_path/common-user/host/$host_arch" ]; then
+    if [ "$linux_user" != no ]; then
+        if [ "$targetos" = linux ]; then
+            linux_user=yes
+        elif [ "$linux_user" = yes ]; then
+            error_exit "linux-user not supported on this architecture"
+        fi
+        if [ "$linux_user" = "yes" ]; then
+            mak_wilds="${mak_wilds} $source_path/configs/targets/*-linux-user.mak"
+        fi
     fi
-fi
-if [ "$bsd_user" != no ]; then
-    if [ "$bsd_user" = "" ]; then
-        test $targetos = freebsd && bsd_user=yes
+    if [ "$bsd_user" != no ]; then
+        if [ "$bsd_user" = "" ]; then
+            test $targetos = freebsd && bsd_user=yes
+        fi
+        if [ "$bsd_user" = yes ] && ! [ -d "$source_path/bsd-user/$targetos" ]; then
+            error_exit "bsd-user not supported on this host OS"
+        fi
+        if [ "$bsd_user" = "yes" ]; then
+            mak_wilds="${mak_wilds} $source_path/configs/targets/*-bsd-user.mak"
+        fi
     fi
-    if [ "$bsd_user" = yes ] && ! [ -d "$source_path/bsd-user/$targetos" ]; then
-        error_exit "bsd-user not supported on this host OS"
+else
+    if [ "$linux_user" = yes ] || [ "$bsd_user" = yes ]; then
+        error_exit "user mode emulation not supported on this architecture"
     fi
 fi
 if [ "$softmmu" = "yes" ]; then
     mak_wilds="${mak_wilds} $source_path/configs/targets/*-softmmu.mak"
 fi
-if [ "$linux_user" = "yes" ]; then
-    mak_wilds="${mak_wilds} $source_path/configs/targets/*-linux-user.mak"
-fi
-if [ "$bsd_user" = "yes" ]; then
-    mak_wilds="${mak_wilds} $source_path/configs/targets/*-bsd-user.mak"
-fi
 
 for config in $mak_wilds; do
     target="$(basename "$config" .mak)"
-- 
2.41.0


