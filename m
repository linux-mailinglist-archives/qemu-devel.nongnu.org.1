Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1BA7CD678
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:30:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1vB-00020w-F5; Wed, 18 Oct 2023 04:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1v1-0001tZ-Ug
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1v0-0003h1-02
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LNvcZL7dzJpk+WxEGf93CDtkxQYWrnxI3lWgosy3qaE=;
 b=M76EbZFds6vJI2shCtJ8jEsb+tMe7cfGDx8N4er8I8nCqeg7ISV+8bi3l3FYd+D7vIluM5
 HllqPDiFqB/PgbzhopRh6MnUUWZnnImV3lsPrVqqMhwdpJwSAYi4hgY2oNc4ttd94L2H2x
 vdZipJ46YX9Dz7hykAXUWO0qBx0Dtxs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-n4VuPriXNEKjLxUSTtYAIQ-1; Wed, 18 Oct 2023 04:28:40 -0400
X-MC-Unique: n4VuPriXNEKjLxUSTtYAIQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9ae0601d689so435262166b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617718; x=1698222518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LNvcZL7dzJpk+WxEGf93CDtkxQYWrnxI3lWgosy3qaE=;
 b=VRDKXchXpeY8r2pFFwt+xs5Yz175YQ9LqIMFg2ALik7nnedpyc/794WQJs3yTrljhl
 hxNbVJlxiUVggEfZS9A6EEpI7ZZ/pB99kltLwsfGxN5aCyWsvMGCU6LixSKTVzgSNwWf
 1SfM1gM/HVcisRburPsCPxKuA9sNC4Ldlpa04BLZOrPaNU3UeodNQ22tyUQ37Ug2hwic
 P3qe/GjiDfH/L4xlGAtpPKaNJgTg9YCf+cWjxFMAPMrWQmJFA0DfVKaymsO2VT61KFbC
 yNS1mTWP16WjoSbuAaS/CruQM5lfItWmBAsS5H5g4hyiZTdm0mTcROY3LDnzpdekj4Lw
 EYIA==
X-Gm-Message-State: AOJu0YyYPJzyCL21XujylVrhMsBebsNeez1LkBqqvXyfZt9aE9nlzmud
 aZYema9jaZPL0LLgL4AIiUqoe0FLBp4VjAjFodS1HIs5xt9cdF/43XrNp7iLBFdOQ5GroJkj/mx
 oIfC+ZGWXBBl5uSFZ6+LKsRjYYG5Y42Mls4bQg+uKSHemg91rl3EOJNSoa+SZ0sjgQMH6ZjmVTa
 Q=
X-Received: by 2002:a17:907:6096:b0:9aa:63d:9ede with SMTP id
 ht22-20020a170907609600b009aa063d9edemr4289440ejc.9.1697617718653; 
 Wed, 18 Oct 2023 01:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNreSK9S+6wPWqVdy4ny6GN5VKMLe6u7qfMlKrWgo7CaZ336+VXnI8/lBzBhZ1wt4vYFBqPg==
X-Received: by 2002:a17:907:6096:b0:9aa:63d:9ede with SMTP id
 ht22-20020a170907609600b009aa063d9edemr4289430ejc.9.1697617718403; 
 Wed, 18 Oct 2023 01:28:38 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 os20-20020a170906af7400b009ad89697c86sm1199439ejb.144.2023.10.18.01.28.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/32] configure: clean up PIE option handling
Date: Wed, 18 Oct 2023 10:27:44 +0200
Message-ID: <20231018082752.322306-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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
index 688577bebd8..5c1d618f102 100755
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
@@ -1088,19 +1077,23 @@ static THREAD int tls_var;
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


