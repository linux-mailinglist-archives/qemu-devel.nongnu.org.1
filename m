Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C748A7BB6BA
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:42:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9H-00056v-Nb; Fri, 06 Oct 2023 07:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8q-0004zn-L4
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8m-00007u-9j
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+n7FavU8lRQasqyJ6zeG5ii/6CvqBflzCFUIfyjdja4=;
 b=Qef8mxynfu2Lf9YbP4OVntVCuEAsPq1RocHnHMMKCM3g7KGU/+BOPjwKHOs5ROyTdw3RIi
 blTSDU+LNJ34Hs+JEpDLsgD5EG3jwfRveLrwpkAWyJw8Htmmyysr2OYC+eP5yGkTm4zTRJ
 jBlqpEBoq4NN2yCO0C8c0euN86btBC0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-X-hnvj4XOtCa_kcywqJiXA-1; Fri, 06 Oct 2023 07:37:01 -0400
X-MC-Unique: X-hnvj4XOtCa_kcywqJiXA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA32029A9D42;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97D2240D1EA;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 91BEB21E6885; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/32] util/guest-random: Clean up global variable shadowing
Date: Fri,  6 Oct 2023 13:36:46 +0200
Message-ID: <20231006113657.3803180-22-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Fix:

  util/guest-random.c:90:45: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  int qemu_guest_random_seed_main(const char *optarg, Error **errp)
                                              ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004120019.93101-13-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/guest-random.h | 8 ++++----
 util/guest-random.c         | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/qemu/guest-random.h b/include/qemu/guest-random.h
index 09ff9c2236..5060d49d60 100644
--- a/include/qemu/guest-random.h
+++ b/include/qemu/guest-random.h
@@ -13,16 +13,16 @@
 #define QEMU_GUEST_RANDOM_H
 
 /**
- * qemu_guest_random_seed_main(const char *optarg, Error **errp)
- * @optarg: a non-NULL pointer to a C string
+ * qemu_guest_random_seed_main(const char *seedstr, Error **errp)
+ * @seedstr: a non-NULL pointer to a C string
  * @errp: an error indicator
  *
- * The @optarg value is that which accompanies the -seed argument.
+ * The @seedstr value is that which accompanies the -seed argument.
  * This forces qemu_guest_getrandom into deterministic mode.
  *
  * Returns 0 on success, < 0 on failure while setting *errp.
  */
-int qemu_guest_random_seed_main(const char *optarg, Error **errp);
+int qemu_guest_random_seed_main(const char *seedstr, Error **errp);
 
 /**
  * qemu_guest_random_seed_thread_part1(void)
diff --git a/util/guest-random.c b/util/guest-random.c
index 9465dda085..33607d5ff2 100644
--- a/util/guest-random.c
+++ b/util/guest-random.c
@@ -87,11 +87,11 @@ void qemu_guest_random_seed_thread_part2(uint64_t seed)
     }
 }
 
-int qemu_guest_random_seed_main(const char *optarg, Error **errp)
+int qemu_guest_random_seed_main(const char *seedstr, Error **errp)
 {
     uint64_t seed;
-    if (parse_uint_full(optarg, 0, &seed)) {
-        error_setg(errp, "Invalid seed number: %s", optarg);
+    if (parse_uint_full(seedstr, 0, &seed)) {
+        error_setg(errp, "Invalid seed number: %s", seedstr);
         return -1;
     } else {
         deterministic = true;
-- 
2.41.0


