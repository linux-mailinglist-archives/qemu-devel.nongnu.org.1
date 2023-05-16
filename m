Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78896704E08
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 14:49:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyu6M-0004TR-8r; Tue, 16 May 2023 08:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6I-0004LJ-CC
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:22 -0400
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pyu6G-00063u-GB
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:22 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mdf3x-1qXxjb342D-00ZfC5; Tue, 16
 May 2023 14:48:14 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 5/9] linux-user/main: Use list_cpus() instead of cpu_list()
Date: Tue, 16 May 2023 14:48:06 +0200
Message-Id: <20230516124810.90494-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516124810.90494-1-laurent@vivier.eu>
References: <20230516124810.90494-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oPBDiUyh/dXjYMGyATPj7Fk/g2VeGSfktkQFIloMdH8Po+PViqf
 OCM0rm89dM62xlvlx+C3t1Rajy+bFq+NgMEjjyWbRE8AryFHh/01A1K6KZkNjn3gtiVybFb
 th34r1tlLo/LD0R+xuvZEebyyQ1q6WOpjd9q8MPUVIGSb6OIt5jkAtUajWHl2+sQIaQRUHm
 7Jzea8f82xu6Gu/8luzgg==
UI-OutboundReport: notjunk:1;M01:P0:R69Mj1iWK90=;rJwe7ScUWbmHlnOE22aX50oKi3c
 k+8AIFvBLXh+XqxGTtiHSmeWZtLYduNdYfsR+pGtw3jvwkQSe5FYR3hiXcRXIPC+odTYVJ61+
 BVVXPROMzBNX1PQ99ihv0lWxCtdchaqm6OQgBZe3kcXsdFlzGDdbwx/7EeMztTWKaMEvgXXAN
 GeNKrsq7S7/QQlCNy1eRUZ3Cz3i1JsiE5yhI3/qwmK21bM6sQ0KRPfKZLR7x4jNEyp5n73NPp
 0/LbRTvIHezXL7FcrTohKlIkmMm8I4BfU6Ebjkzmi5eo5KcOCSj3Mw4KWIq4n4sL/Zv4RQDgZ
 ru0SYwSxu8xCNa9JNI02mLJ8/MetvX5Qd18ZegUsPpQhZV+xC+lvFequnsBxeofSPOtaNkYNL
 MnEo22GtADB52ktTfC73B9VkoIWbz7YQYP5VdrJhsI4io27Pj5vOMlLpPua5EGP6eQ/GbgFJo
 q8cCGFTXtQBRZuVUT/kvFfJBrm+QU9k8Gslo0xmOYaSrLo+HLmeOlexb2Ain8lmQw8rZ/0/y9
 ZYIqJy6XfgT4AoMK6vEiWJC6VdKEgBMedNPtuArSPWN+wPDhEY6Kgt84Lf1lViLzdhnc10fx6
 E35scS1sOwRuBHei5dZ9h3c/zdElBl5b+w3vQb+zLONvxM+MBa/yuxjRPk6mMwlnp1y1+aMqb
 l9Idej3AR/pFToM89AM7vC9Zo1/ZUvuzKmCR+yWs8A==
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Thomas Huth <thuth@redhat.com>

This way we can get rid of the if'deffery and the XXX comment
here (it's repeated in the list_cpus() function anyway).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230424122126.236586-1-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index fe03293516a5..aece4d9e9119 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -359,10 +359,7 @@ static void handle_arg_cpu(const char *arg)
 {
     cpu_model = strdup(arg);
     if (cpu_model == NULL || is_help_option(cpu_model)) {
-        /* XXX: implement xxx_cpu_list for targets that still miss it */
-#if defined(cpu_list)
-        cpu_list();
-#endif
+        list_cpus();
         exit(EXIT_FAILURE);
     }
 }
-- 
2.40.1


