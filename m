Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 296C27BB6C2
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:43:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj97-00051J-CJ; Fri, 06 Oct 2023 07:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8o-0004zE-6S
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8h-00006U-KA
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WeDsGMFtz4asvODucopxPE5YKxApxjds6GXhzdwffeM=;
 b=IOIGS9hMfoKyzsS7YG/ImVP6gEUrckauKKwzOH2Q/v2e8pHq5pgrE2DrFpB9YKdE0c6RPA
 cDMPdHnRAILplv4SCzLrI9pHOEnFZ1nC7VDMJiNP7mmvg1jZF33S0K0DZG40da3lprEBw0
 KQ5/Cw2BR/kiNkKLediWhANgXfLGpXE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-vnqYtYC4OMm7mYa7zGU1_Q-1; Fri, 06 Oct 2023 07:37:00 -0400
X-MC-Unique: vnqYtYC4OMm7mYa7zGU1_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC3AC1C06370;
 Fri,  6 Oct 2023 11:36:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AEAB20268CB;
 Fri,  6 Oct 2023 11:36:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 71B2C21E6913; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 10/32] hw/audio/soundhw: Clean up global variable shadowing
Date: Fri,  6 Oct 2023 13:36:35 +0200
Message-ID: <20231006113657.3803180-11-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

  hw/audio/soundhw.c:86:33: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  void select_soundhw(const char *optarg, const char *audiodev)
                                  ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004120019.93101-2-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/audio/soundhw.h | 2 +-
 hw/audio/soundhw.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/audio/soundhw.h b/include/hw/audio/soundhw.h
index 270717a06a..474c5ff94e 100644
--- a/include/hw/audio/soundhw.h
+++ b/include/hw/audio/soundhw.h
@@ -8,6 +8,6 @@ void deprecated_register_soundhw(const char *name, const char *descr,
 
 void soundhw_init(void);
 void show_valid_soundhw(void);
-void select_soundhw(const char *optarg, const char *audiodev);
+void select_soundhw(const char *name, const char *audiodev);
 
 #endif
diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
index 94d9463e42..b387b0ef7d 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -83,7 +83,7 @@ void show_valid_soundhw(void)
 static struct soundhw *selected = NULL;
 static const char *audiodev_id;
 
-void select_soundhw(const char *optarg, const char *audiodev)
+void select_soundhw(const char *name, const char *audiodev)
 {
     struct soundhw *c;
 
@@ -92,7 +92,7 @@ void select_soundhw(const char *optarg, const char *audiodev)
     }
 
     for (c = soundhw; c->name; ++c) {
-        if (g_str_equal(c->name, optarg)) {
+        if (g_str_equal(c->name, name)) {
             selected = c;
             audiodev_id = audiodev;
             break;
@@ -100,7 +100,7 @@ void select_soundhw(const char *optarg, const char *audiodev)
     }
 
     if (!c->name) {
-        error_report("Unknown sound card name `%s'", optarg);
+        error_report("Unknown sound card name `%s'", name);
         show_valid_soundhw();
         exit(1);
     }
-- 
2.41.0


