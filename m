Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E77C77BB6B8
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:42:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9L-00059S-4C; Fri, 06 Oct 2023 07:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8w-00051s-VV
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8t-0000A0-8V
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B7A1/6yu6677WxLat5yg/pN/jN8LiDjpr3rH9i+lSaQ=;
 b=RbwaSWx6yu7B5NF8rPPZfhjyYeLIf61AHtY0ujszE5kOzW8ryRqPQ99dk0vLz6moe1WHyY
 xmOtNjunOEuiSiHb/UbrVZLuI3vIuMH23cuJIpHu84uIZZcBTLq4dLXZHCoT9gscouGu+d
 9/qYtr2g9UJsxJx5bF26swlucojNmOg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-BFMu70v_N3uHpPxO6vuk9g-1; Fri, 06 Oct 2023 07:37:01 -0400
X-MC-Unique: BFMu70v_N3uHpPxO6vuk9g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAAD8185A797;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A321215671F;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9483121E6886; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/32] semihosting/arm-compat: Clean up local variable shadowing
Date: Fri,  6 Oct 2023 13:36:47 +0200
Message-ID: <20231006113657.3803180-23-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

  semihosting/arm-compat-semi.c: In function ‘do_common_semihosting’:
  semihosting/arm-compat-semi.c:379:13: warning: declaration of ‘ret’ shadows a previous local [-Wshadow=local]
    379 |         int ret, err = 0;
        |             ^~~
  semihosting/arm-compat-semi.c:370:14: note: shadowed declaration is here
    370 |     uint32_t ret;
        |              ^~~
  semihosting/arm-compat-semi.c:682:27: warning: declaration of ‘ret’ shadows a previous local [-Wshadow=local]
    682 |                 abi_ulong ret;
        |                           ^~~
  semihosting/arm-compat-semi.c:370:9: note: shadowed declaration is here
    370 |     int ret;
        |         ^~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004120019.93101-14-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 semihosting/arm-compat-semi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 29c5670fdf..ec959b3e01 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -367,7 +367,6 @@ void do_common_semihosting(CPUState *cs)
     target_ulong ul_ret;
     char * s;
     int nr;
-    uint32_t ret;
     int64_t elapsed;
 
     nr = common_semi_arg(cs, 0) & 0xffffffffU;
@@ -725,6 +724,9 @@ void do_common_semihosting(CPUState *cs)
 
     case TARGET_SYS_EXIT:
     case TARGET_SYS_EXIT_EXTENDED:
+    {
+        uint32_t ret;
+
         if (common_semi_sys_exit_extended(cs, nr)) {
             /*
              * The A64 version of SYS_EXIT takes a parameter block,
@@ -752,6 +754,7 @@ void do_common_semihosting(CPUState *cs)
         }
         gdb_exit(ret);
         exit(ret);
+    }
 
     case TARGET_SYS_ELAPSED:
         elapsed = get_clock() - clock_start;
-- 
2.41.0


