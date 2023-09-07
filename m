Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE64797281
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:02:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEcp-0002l8-6I; Thu, 07 Sep 2023 09:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcl-0002jq-KW
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcj-0007FL-FH
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pyHPuQhAMnD4vefU4v6HxJjdvupVxPNtPBr93+Lu97A=;
 b=L5QQ25GA3rUAuw0uTl0OucFaNIKmhUoJFix90RuBabDquf4vgTr70dwChRA+UrSsR9Ttll
 BdhM1JX0xPq1MaXy28sAMOB1f2WVN116g+sOi2x83jJhC9QiH2rAmIlhQbh5XRNoJVQAFZ
 Tr3jjFVzPNDuU1E7I1CnOQYXn9oI7HI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-47_sljUYN7i1taHaEjmqCA-1; Thu, 07 Sep 2023 09:00:39 -0400
X-MC-Unique: 47_sljUYN7i1taHaEjmqCA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3180237cef3so625112f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091629; x=1694696429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pyHPuQhAMnD4vefU4v6HxJjdvupVxPNtPBr93+Lu97A=;
 b=ieaD3Gu98mHKimu7Ri0QcQw9XqrH1V/bwBJKJDhfLX7SGDwiQKcqCAp3d4fYcNPwbT
 5Oi095fLF1+7JK985OBwWh1y6oHXGieH2vhK83vpNvz+XEo4x1vhhw3qjewcyn6+Z6xD
 1pq96Gy0tnz2PoIEpjJSwF4HZD5+WaKnqZp2dWEbA9ddmq97F32qwpxCzlS54OrqRm0b
 ya533bfkbMbMS/0fsI35/kDWrcWIzMvP1UOcMW8X0cDEgbO3DZhjWOYhGYByo+QkQdDA
 P+tbYn5daAryEQInYYfRzRFs0Ft95Y3vn90qQzRbLciN6m0HDPynpHvIuj7+RmD/wiYR
 Vc6A==
X-Gm-Message-State: AOJu0YyUnjNi4Gt00ysZJvBqeNiBYFQj4E78S1ar603AN+KGlYTx1K3F
 OyjO+Tx82LlL5R65DU3YDMzWxJg7comkkT/9JpgOJZ/H0gtH54dZdhkKPyMjAQHsUUdYAC+fZh/
 AS7aPbtLafSzBX8W/XvfHiAfRHWUFNH3CjArpaJ3yOPnhiWhUZNTUZPrJi7UTyCjt37WKLVoG0s
 w=
X-Received: by 2002:adf:f3ca:0:b0:317:57f0:fae with SMTP id
 g10-20020adff3ca000000b0031757f00faemr4579499wrp.63.1694091629583; 
 Thu, 07 Sep 2023 06:00:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeKfdZCrgpDmY3US/XX3FWfc14Cmx8ibPKB8YZB+34k8Stpm3l2Ju6hGg/f6HO9WiqrNdTKQ==
X-Received: by 2002:adf:f3ca:0:b0:317:57f0:fae with SMTP id
 g10-20020adff3ca000000b0031757f00faemr4579463wrp.63.1694091629151; 
 Thu, 07 Sep 2023 06:00:29 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 m6-20020adfa3c6000000b0031f300a4c26sm18184768wrb.93.2023.09.07.06.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 10/51] os-posix.c: move code around
Date: Thu,  7 Sep 2023 14:59:19 +0200
Message-ID: <20230907130004.500601-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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

From: Michael Tokarev <mjt@tls.msk.ru>

this moves code blocks so that functions and variables which
belongs to the same concept are now close to each other.
There's no actual code changes in there.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20230901101302.3618955-6-mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 os-posix.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/os-posix.c b/os-posix.c
index fc2883ff82c..a8e38c02988 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -40,17 +40,6 @@
 #include <sys/prctl.h>
 #endif
 
-/*
- * Must set all three of these at once.
- * Legal combinations are              unset   by name   by uid
- */
-static struct passwd *user_pwd;    /*   NULL   non-NULL   NULL   */
-static uid_t user_uid = (uid_t)-1; /*   -1      -1        >=0    */
-static gid_t user_gid = (gid_t)-1; /*   -1      -1        >=0    */
-
-static const char *chroot_dir;
-static int daemonize;
-static int daemon_pipe;
 
 void os_setup_early_signal_handling(void)
 {
@@ -97,6 +86,15 @@ void os_set_proc_name(const char *s)
 #endif
 }
 
+
+/*
+ * Must set all three of these at once.
+ * Legal combinations are              unset   by name   by uid
+ */
+static struct passwd *user_pwd;    /*   NULL   non-NULL   NULL   */
+static uid_t user_uid = (uid_t)-1; /*   -1      -1        >=0    */
+static gid_t user_gid = (gid_t)-1; /*   -1      -1        >=0    */
+
 /*
  * Prepare to change user ID. optarg can be one of 3 forms:
  *   - a username, in which case user ID will be changed to its uid,
@@ -174,6 +172,9 @@ static void change_process_uid(void)
     }
 }
 
+
+static const char *chroot_dir;
+
 void os_set_chroot(const char *optarg)
 {
     chroot_dir = optarg;
@@ -194,6 +195,21 @@ static void change_root(void)
 
 }
 
+
+static int daemonize;
+static int daemon_pipe;
+
+bool is_daemonized(void)
+{
+    return daemonize;
+}
+
+int os_set_daemonize(bool d)
+{
+    daemonize = d;
+    return 0;
+}
+
 void os_daemonize(void)
 {
     if (daemonize) {
@@ -287,17 +303,6 @@ void os_set_line_buffering(void)
     setvbuf(stdout, NULL, _IOLBF, 0);
 }
 
-bool is_daemonized(void)
-{
-    return daemonize;
-}
-
-int os_set_daemonize(bool d)
-{
-    daemonize = d;
-    return 0;
-}
-
 int os_mlock(void)
 {
 #ifdef HAVE_MLOCKALL
-- 
2.41.0


