Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B0C72461B
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:32:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xij-000558-FI; Tue, 06 Jun 2023 10:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xih-00054p-Dp
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xif-0001Fg-SQ
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zqk+QExzrBAqR8/1ekneq8mDE9m3pRgVPOwGF6GaSgk=;
 b=Ve4oKCDizWxyaSKW2AZcibJLGzkVmupJVMBy6gUNPHEJhIdnGJwvCpRbLt8ZoWBJLPMVp7
 gEolTJHvH2hSovPUMmWW4OfSu0erjowH7LgRoZJ/DBgk0aOHfzFA97Qg6Xr424GdRf4yBY
 FotAFBXT7UjacgypGkHU9K71enO3ehQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-ClFcDMnTNvGJv-FA5UvKQQ-1; Tue, 06 Jun 2023 10:31:32 -0400
X-MC-Unique: ClFcDMnTNvGJv-FA5UvKQQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4edc5526c5fso4064507e87.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061890; x=1688653890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zqk+QExzrBAqR8/1ekneq8mDE9m3pRgVPOwGF6GaSgk=;
 b=a5JYh/1HjK5xYMHnbC4TxevTMI6h+VlPivoLBebcU6qLhrrVz/fypvwO68l+pN3C6c
 sEh4lzqhW16gHIWwPwu6cIaaXqnH8S/D3nW9Ib/FWJ3P8cL4KZKFxxTk3Vyo0IPl1pgN
 j0Pi85QLGYJWbck8N4zRGs9JLJpeiBJYdHxDgVVqk6gxN2kKclUxantPtqAFxgLLSZ+n
 NGZCeSzWqtuWFObfoqFKqpoC7VZVHGgcyTKAiV1xypGphNNl2iYeYRdL85MnkpVXei2U
 ufqT/Uzv6ysSG32hzscLbrUsxcO+0Fg6I7RTJUWF7mdGqAa1JgGP9TJ8m6ON4F3Fd/hN
 Cjqw==
X-Gm-Message-State: AC+VfDybNuuEN6qUBvxHSp7pNqbf1nE4pqGToJWIDXVXTFNDbPzxmWLw
 Ea5urK2JTW6jnUjjvnabqxpi0YdGHRUqxoC7ZIFoSkJ6/fRrwBawubW4TssK0iBANnmlcdtrb+U
 b0W+8NDvaugNok85zFE+zUBwPrMPi7h4DergdOuhkTzeiz0u0jSWUcdeAbAk8lIBXQKnWBRzN0x
 o=
X-Received: by 2002:a19:ae05:0:b0:4f3:dd96:bf55 with SMTP id
 f5-20020a19ae05000000b004f3dd96bf55mr1113336lfc.11.1686061890314; 
 Tue, 06 Jun 2023 07:31:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4LoSdYThBPSINmEIH/kalRYWNDTtDOO1sZfXQyIrereG5VyMp4WBABU1u/jTmTLSU8uLzxIQ==
X-Received: by 2002:a19:ae05:0:b0:4f3:dd96:bf55 with SMTP id
 f5-20020a19ae05000000b004f3dd96bf55mr1113324lfc.11.1686061889926; 
 Tue, 06 Jun 2023 07:31:29 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 r9-20020a056402018900b0051056dc47e0sm5258559edv.8.2023.06.06.07.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/21] scsi/qemu-pr-helper: Drop support for 'old' libmultipath
 API
Date: Tue,  6 Jun 2023 16:31:03 +0200
Message-Id: <20230606143116.685644-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit 1b0578f5c4 ("qemu-pr-helper: Fix build on CentOS 7") added
code to probe for 'old' libmultipath API on CentOS 7. However since
merge commit 8c345b3e6a (June 2021) we don't build/test CentOS 7 as
it felt out of our list of supported distrib versions. Therefore we
can safely remove the 'old' API check (mostly reverting commit
1b0578f5c4, except the code got converted to meson in commit
6ec0e15d95 "meson: move libmpathpersist test").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230605174146.87440-2-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build           | 19 ++-----------------
 scsi/qemu-pr-helper.c |  4 ----
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index 6bbeffe5711..6767a0d3faa 100644
--- a/meson.build
+++ b/meson.build
@@ -1092,9 +1092,8 @@ endif
 
 mpathlibs = [libudev]
 mpathpersist = not_found
-mpathpersist_new_api = false
 if targetos == 'linux' and have_tools and get_option('mpath').allowed()
-  mpath_test_source_new = '''
+  mpath_test_source = '''
     #include <libudev.h>
     #include <mpath_persist.h>
     unsigned mpath_mx_alloc_len = 1024;
@@ -1111,16 +1110,6 @@ if targetos == 'linux' and have_tools and get_option('mpath').allowed()
         multipath_conf = mpath_lib_init();
         return 0;
     }'''
-  mpath_test_source_old = '''
-      #include <libudev.h>
-      #include <mpath_persist.h>
-      unsigned mpath_mx_alloc_len = 1024;
-      int logsink;
-      int main(void) {
-          struct udev *udev = udev_new();
-          mpath_lib_init(udev);
-          return 0;
-      }'''
   libmpathpersist = cc.find_library('mpathpersist',
                                     required: get_option('mpath'))
   if libmpathpersist.found()
@@ -1139,10 +1128,7 @@ if targetos == 'linux' and have_tools and get_option('mpath').allowed()
     endforeach
     if mpathlibs.length() == 0
       msg = 'Dependencies missing for libmpathpersist'
-    elif cc.links(mpath_test_source_new, dependencies: mpathlibs)
-      mpathpersist = declare_dependency(dependencies: mpathlibs)
-      mpathpersist_new_api = true
-    elif cc.links(mpath_test_source_old, dependencies: mpathlibs)
+    elif cc.links(mpath_test_source, dependencies: mpathlibs)
       mpathpersist = declare_dependency(dependencies: mpathlibs)
     else
       msg = 'Cannot detect libmpathpersist API'
@@ -2094,7 +2080,6 @@ config_host_data.set('CONFIG_GCOV', get_option('b_coverage'))
 config_host_data.set('CONFIG_LIBUDEV', libudev.found())
 config_host_data.set('CONFIG_LZO', lzo.found())
 config_host_data.set('CONFIG_MPATH', mpathpersist.found())
-config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
 config_host_data.set('CONFIG_BLKIO', blkio.found())
 if blkio.found()
   config_host_data.set('CONFIG_BLKIO_VHOST_VDPA_FD',
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index a857e80c038..ae44a816e17 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -280,11 +280,7 @@ void put_multipath_config(struct config *conf)
 static void multipath_pr_init(void)
 {
     udev = udev_new();
-#ifdef CONFIG_MPATH_NEW_API
     multipath_conf = mpath_lib_init();
-#else
-    mpath_lib_init(udev);
-#endif
 }
 
 static int is_mpath(int fd)
-- 
2.40.1


