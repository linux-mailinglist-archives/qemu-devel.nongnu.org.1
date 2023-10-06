Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0287BB6A5
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:40:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9L-00059P-3m; Fri, 06 Oct 2023 07:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8w-00051o-Di
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8q-00008C-Df
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CzR+RMIq811dbSevTYmjOhuBh9GlyIdCm7XlyB+I4OM=;
 b=Ox7UCq0cCbu1jCnw/0KNPMy3bPA++oD0eYQHsmVKCBDY24YulQcBmvPhSvOS2qlHeC6YNW
 qNWwZh+oqCPZchQTtqMqsXFj2VgrWDQY5emlTFNspjO6PB1nIdgbiKw1In83sFY/DSLKFi
 gyDmSVNaYAUJLE7upc0FhyeABUpMHCY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-aoflsY0cPHOD4_tY0WV8rg-1; Fri, 06 Oct 2023 07:37:00 -0400
X-MC-Unique: aoflsY0cPHOD4_tY0WV8rg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D708629A9D40;
 Fri,  6 Oct 2023 11:36:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5DB540C6EA8;
 Fri,  6 Oct 2023 11:36:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7A90021E6916; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/32] os-posix: Clean up global variable shadowing
Date: Fri,  6 Oct 2023 13:36:38 +0200
Message-ID: <20231006113657.3803180-14-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Fix:

  os-posix.c:103:31: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  bool os_set_runas(const char *optarg)
                                ^
  os-posix.c:176:32: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  void os_set_chroot(const char *optarg)
                                 ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004120019.93101-5-philmd@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/sysemu/os-posix.h |  4 ++--
 os-posix.c                | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index 6dfdcbb086..dff32ae185 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -49,8 +49,8 @@ void os_setup_signal_handling(void);
 int os_set_daemonize(bool d);
 bool is_daemonized(void);
 void os_daemonize(void);
-bool os_set_runas(const char *optarg);
-void os_set_chroot(const char *optarg);
+bool os_set_runas(const char *user_id);
+void os_set_chroot(const char *path);
 void os_setup_post(void);
 int os_mlock(void);
 
diff --git a/os-posix.c b/os-posix.c
index f90dfda9b0..52ef6990ff 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -94,13 +94,13 @@ static uid_t user_uid = (uid_t)-1; /*   -1      -1        >=0    */
 static gid_t user_gid = (gid_t)-1; /*   -1      -1        >=0    */
 
 /*
- * Prepare to change user ID. optarg can be one of 3 forms:
+ * Prepare to change user ID. user_id can be one of 3 forms:
  *   - a username, in which case user ID will be changed to its uid,
  *     with primary and supplementary groups set up too;
  *   - a numeric uid, in which case only the uid will be set;
  *   - a pair of numeric uid:gid.
  */
-bool os_set_runas(const char *optarg)
+bool os_set_runas(const char *user_id)
 {
     unsigned long lv;
     const char *ep;
@@ -108,14 +108,14 @@ bool os_set_runas(const char *optarg)
     gid_t got_gid;
     int rc;
 
-    user_pwd = getpwnam(optarg);
+    user_pwd = getpwnam(user_id);
     if (user_pwd) {
         user_uid = -1;
         user_gid = -1;
         return true;
     }
 
-    rc = qemu_strtoul(optarg, &ep, 0, &lv);
+    rc = qemu_strtoul(user_id, &ep, 0, &lv);
     got_uid = lv; /* overflow here is ID in C99 */
     if (rc || *ep != ':' || got_uid != lv || got_uid == (uid_t)-1) {
         return false;
@@ -173,9 +173,9 @@ static void change_process_uid(void)
 
 static const char *chroot_dir;
 
-void os_set_chroot(const char *optarg)
+void os_set_chroot(const char *path)
 {
-    chroot_dir = optarg;
+    chroot_dir = path;
 }
 
 static void change_root(void)
-- 
2.41.0


