Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A79722DCC
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 19:43:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6EDZ-0007v8-43; Mon, 05 Jun 2023 13:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6EDP-0007ue-6w
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:41:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6EDN-0006RT-F9
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:41:58 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30ae5f2ac94so5165886f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685986915; x=1688578915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDoCbhsufW2eRl22gg8xlV8Kc4+eIikw7TA4BupcukI=;
 b=aeakblhWU69P9wRHL4KzEqhhsudA30rD8oaT6lDIvrOphR5RRoz03lyCIcuSd7sAVJ
 xLFi+VjkktfEOWimQ4Aknbucj3i8ZaSnhurtm/yqkJC68uVtF/KLAEB+qtVGfW4fOU1I
 UU2oGQHLgRbHfC5bmgAILFdCZUJI++PpJ/w3BlYVcuVvs9Axkm/M5tzEnQyiO3jN+rb6
 Nirqj6dCyczSrpRJY6f0HG1tH6kuoYaDn916Vlfw/f1boI0oq4+JlPWibRWNh7b8IWT9
 LN4EMLfRhpprZbgnocFDMjK0TvuNwQiMoG7IiVb5zlu2bgIMfwtjV0Tx3Gl318K7ABXa
 5bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685986915; x=1688578915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bDoCbhsufW2eRl22gg8xlV8Kc4+eIikw7TA4BupcukI=;
 b=MaeH+9grNCr1Djq/xsdy7UqW4gRSuht2tYBX1HuwI9Mw1LmAFOHBsbmlOCWSeU+8u/
 NURECaE06KUPUTSGdT9RTBNP8yv+PbYK9FzkVqC3DDpo5Ps9BUF5FYTCz0DKH0q9Sm3k
 k7+nJfDayCR57SrwK0YC195okLHd2zvICbYm5a0tB2FVj6drjeLz3AOyDquNMO/2sZ1+
 FrX96E91V0HmEVhSOOlhKcOzhhvvQmYexPpY0k8eeYIOBThjv9dQfrznNkgv9b402JOd
 +sa1rvxR06AIlhqP9Rqax7hM8qz8cJnPFKWyvyjjrNXtDgTDMTzPtdyZf6MbD7WE1Cja
 317w==
X-Gm-Message-State: AC+VfDwiM922n80uJjcjYibtRLa8G/dio0w56bAI0QwKu2/YvL0kaI15
 8pfzzsCHE+UpZg7XO53We8R1Ilg/TBofhNA25Jg=
X-Google-Smtp-Source: ACHHUZ4AsQhlEUKKjNSlCz/Ma1JApoQ0HaStdooi6PPvU82rKObSaVuRZOY7Y/472+A+6LYoCKgCcg==
X-Received: by 2002:a05:6000:1d1:b0:30a:ea8a:7a6d with SMTP id
 t17-20020a05600001d100b0030aea8a7a6dmr7077092wrx.16.1685986915639; 
 Mon, 05 Jun 2023 10:41:55 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 w1-20020a5d6081000000b0030adc30e9f1sm10286897wrt.68.2023.06.05.10.41.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jun 2023 10:41:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 1/2] scsi/qemu-pr-helper: Drop support for 'old' libmultipath
 API
Date: Mon,  5 Jun 2023 19:41:45 +0200
Message-Id: <20230605174146.87440-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230605174146.87440-1-philmd@linaro.org>
References: <20230605174146.87440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Commit 1b0578f5c4 ("qemu-pr-helper: Fix build on CentOS 7") added
code to probe for 'old' libmultipath API on CentOS 7. However since
merge commit 8c345b3e6a (June 2021) we don't build/test CentOS 7 as
it felt out of our list of supported distrib versions. Therefore we
can safely remove the 'old' API check (mostly reverting commit
1b0578f5c4, except the code got converted to meson in commit
6ec0e15d95 "meson: move libmpathpersist test").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build           | 19 ++-----------------
 scsi/qemu-pr-helper.c |  4 ----
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index a61d3e9b06..8468b8e379 100644
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
@@ -2104,7 +2090,6 @@ config_host_data.set('CONFIG_GCOV', get_option('b_coverage'))
 config_host_data.set('CONFIG_LIBUDEV', libudev.found())
 config_host_data.set('CONFIG_LZO', lzo.found())
 config_host_data.set('CONFIG_MPATH', mpathpersist.found())
-config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
 config_host_data.set('CONFIG_BLKIO', blkio.found())
 if blkio.found()
   config_host_data.set('CONFIG_BLKIO_VHOST_VDPA_FD',
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index a857e80c03..ae44a816e1 100644
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
2.38.1


