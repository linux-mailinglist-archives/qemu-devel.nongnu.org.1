Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E30B77C9F9B
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH8w-0003zV-Pb; Mon, 16 Oct 2023 02:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8u-0003yi-Ur
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8t-0005T3-FD
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=igE3z/qNeoB/rMwL7Qq+v4/CnSK2ZONLhR6t8IlRdAw=;
 b=Ci5+aga/2ywCtxk5PrSjvB2nT/mTJurs5tY6/ICU4fZ3VPaLA5tgU2ptLqkfdLmITIqqk/
 IA7TF4Pqr8tn/hsdfECIwRNl5cvFcVnCWbGzRXwhBCtArl5RLmlIkTvhT2uGyTbCVCncW4
 pKElQas4MH5pNp8961yagR+cq0UV9pY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-2RmlmJIuOAmJhh6BlB_NDQ-1; Mon, 16 Oct 2023 02:31:50 -0400
X-MC-Unique: 2RmlmJIuOAmJhh6BlB_NDQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a5d86705e4so295060766b.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437909; x=1698042709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=igE3z/qNeoB/rMwL7Qq+v4/CnSK2ZONLhR6t8IlRdAw=;
 b=oIJmK0c/nWQbx4pJjBz6bICYVbbCLePsVsreBE0pxogHk+N+hvfqAAfnegHgC51Jms
 gfMBL8AatCdGi3Ft5CN/FMtL2t16D26dxaMmcBzo/MT7O3EKHZ7PkSwF8UL0mP9JKJG2
 bOYokDePCROChMzoX1gNzOtSWrFHXkuRoVLXQFsJg5kMocHkbPJ3AmKI9B9kqDBJcXa6
 M999ql51kRLSQ51NYKBCDkybQs+ug8fdWM2PVtHhMNop/LQuVPF8bj9Tnmie62DFd8ml
 DsAa6ZjxbQWF3JvfU7/nheiQexSTmlWnsEwP92FbcjFo6es41K2Z/pzKdtirvQhQ7i7Z
 zPXg==
X-Gm-Message-State: AOJu0YzA79CMPhQKxnilZXTLKqdqkHolAH66X9keKJYeZIMCtFQ5fZdp
 ydhqW4hqUxL0brA4enn8zVzbvjSM1eP/KQISFsBF9bM3iMfbYobGbFlTK3G6F8+XKN+QXC9njKJ
 1Xm93B99WxO59MXP7wMEhOhfBcDwefdQrZbDInXytHI22dk9H/Qpe7/i2khSglMPjSgYcP1ZyHm
 g=
X-Received: by 2002:a17:906:3cb2:b0:9ba:65e:7529 with SMTP id
 b18-20020a1709063cb200b009ba065e7529mr18822091ejh.68.1697437908848; 
 Sun, 15 Oct 2023 23:31:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk0RWCTY/BLOTlvzBGAel54+I+OIWV2SKIJVrhrQ0XNqFwqkSJgt8000QHkbeaplVg9GCuNQ==
X-Received: by 2002:a17:906:3cb2:b0:9ba:65e:7529 with SMTP id
 b18-20020a1709063cb200b009ba065e7529mr18822079ejh.68.1697437908521; 
 Sun, 15 Oct 2023 23:31:48 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 rh9-20020a17090720e900b009ae54585aebsm3345161ejb.89.2023.10.15.23.31.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:31:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/17] configure: clean up PIE option handling
Date: Mon, 16 Oct 2023 08:31:20 +0200
Message-ID: <20231016063127.161204-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016063127.161204-1-pbonzini@redhat.com>
References: <20231016063127.161204-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Keep together all the conditions that lead to disabling PIE.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/configure b/configure
index 7dad78f329b..a713493e9e2 100755
--- a/configure
+++ b/configure
@@ -373,17 +373,6 @@ else
   targetos=bogus
 fi
 
-# OS specific
-
-case $targetos in
-windows)
-  pie="no"
-;;
-haiku)
-  pie="no"
-;;
-esac
-
 if test ! -z "$cpu" ; then
   # command line argument
   :
@@ -1084,19 +1073,23 @@ static THREAD int tls_var;
 int main(void) { return tls_var; }
 EOF
 
-if test "$static" = "yes"; then
-  if test "$pie" != "no" && compile_prog "-Werror -fPIE -DPIE" "-static-pie"; then
+if test "$targetos" = windows || test "$targetos" = haiku; then
+  if test "$pie" = "yes"; then
+    error_exit "PIE not available due to missing OS support"
+  fi
+  pie=no
+fi
+
+if test "$pie" != "no"; then
+  if test "$static" = "yes"; then
+    pie_ldflags=-static-pie
+  else
+    pie_ldflags=-pie
+  fi
+  if compile_prog "-Werror -fPIE -DPIE" "$pie_ldflags"; then
     pie="yes"
   elif test "$pie" = "yes"; then
     error_exit "-static-pie not available due to missing toolchain support"
-  else
-    pie="no"
-  fi
-elif test "$pie" != "no"; then
-  if compile_prog "-Werror -fPIE -DPIE" "-pie"; then
-    pie="yes"
-  elif test "$pie" = "yes"; then
-    error_exit "PIE not available due to missing toolchain support"
   else
     echo "Disabling PIE due to missing toolchain support"
     pie="no"
-- 
2.41.0


