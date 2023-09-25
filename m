Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A27ADB0B
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:11:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknEX-0008M7-JR; Mon, 25 Sep 2023 11:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qknEM-0008EK-Pu
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:10:39 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qknEJ-0005L7-Se
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:10:38 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M1q8m-1qn09f0wPI-002DAX; Mon, 25
 Sep 2023 17:10:31 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 1/5] linux-user/flatload: clean up local variable shadowing
Date: Mon, 25 Sep 2023 17:10:25 +0200
Message-ID: <20230925151029.461358-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925151029.461358-1-laurent@vivier.eu>
References: <20230925151029.461358-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YdvWlxSvsFN88bfFbM0ccbntFQ0A59rQm2QYYKbqbhkWX16UNYD
 43cZWRw9ABvmyBjHDyAhl1TK+0sFSDpRUWGP/oe4kTEXPx7IUbNggosuwz0MKzrZyOqeDyo
 1x1IOKcuR4Bz89yfBoEqGL7rC9wSegJFMY5t10YUe6A2TwsyOAqvjBZxsBwlMfkXagIk5x0
 6hTHcH16PJI/HtKbRUMKA==
UI-OutboundReport: notjunk:1;M01:P0:5VUufdgRljs=;kK2EZH0HXsWVJqMrOKN49sJSfFN
 L/Bj6ceIj3Py/q/+GLTpPJFWxd1jMjdmNbhlGtx7/DzUOanyCGHPd0Zks+M6qFeV/MW6getsZ
 tzbQE//vBdBSlhf7/mfhsIfrnMk1lCvBPDFUR0zFmYLpbKZAvkIzjWwJNc02w3MuiaUwELVKu
 JhVWpCOF/zR9e4qh4RpoNu09nnmpZxXNfj/W8ZZaTKFbvB5tS8KNkkb22ghh9koohBm+ZYzft
 fcM8HPESV/ubgtPfW2Lk9oje9Yo7kHZAEbOqYsC6XjyZMKmb4637TiUAj4ZnCyrCuHcREUHR1
 DULsRS7LSORQFchodLX5jLqlzdFJOfYvlWTMNmXYHqPV5XgDlqzqKHZGIlV+uHr6hfQEs8a1t
 QYNTt2clpT3i2gl9dbJnl5OMiksCUJnVe+obZaSHu2YOm1XxuNseTZP8jEnnQWPsjIwIjW3Y3
 k0kYlF5CXYDW9Kzrq1saWDCFWQNLNH18IN8u7mDAE95vqknosh02elvbmlGWMlXzDZpjw4aDV
 elDD/0AZZJ94FrBBFMLD0OC2aXgSglUE7HWRRHaP3KYkln1ySS+OMtV5sBQOFxYaiwuzozUas
 ap9XCsiWSqiLnSrYLz8vgXPbEuDEyu59K1UeEYCaiUK6OHPqsrKOEEYWSeo3HkKSuEpIk82oi
 msrM/hlF5tQcvg/ag5WwBZFzH0zGT2aFmKI8NC4byXwpztJVSfBQLXAE9L+VnBOeyXYFHWYrd
 +6IonbiWAvrPpVH+lZFj+30kQDr/kc3O6o7maP34j0FoaY2W00P1lxQ9wLH5DtuFN7qTXmO3L
 9tesst/7pClAn/c5VZNJxuSkRp8DkIVLFZU6JTz5qJN8hsjvkC+WaPMxr4TRv74mDgGos97Vq
 LmIGfn9HxSwIEbw==
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Fix following warnings:

.../linux-user/flatload.c: In function 'load_flt_binary':
.../linux-user/flatload.c:758:23: warning: declaration of 'p' shadows a previous local [-Wshadow=compatible-local]
  758 |             abi_ulong p;
      |                       ^
../../../Projects/qemu/linux-user/flatload.c:722:15: note: shadowed declaration is here
  722 |     abi_ulong p;
      |               ^

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/flatload.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 4331a11bf010..fdcc4610fa30 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -755,15 +755,15 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
     /* Update data segment pointers for all libraries */
     for (i=0; i<MAX_SHARED_LIBS; i++) {
         if (libinfo[i].loaded) {
-            abi_ulong p;
-            p = libinfo[i].start_data;
+            abi_ulong seg;
+            seg = libinfo[i].start_data;
             for (j=0; j<MAX_SHARED_LIBS; j++) {
-                p -= 4;
+                seg -= 4;
                 /* FIXME - handle put_user() failures */
                 if (put_user_ual(libinfo[j].loaded
                                  ? libinfo[j].start_data
                                  : UNLOADED_LIB,
-                                 p))
+                                 seg))
                     return -EFAULT;
             }
         }
-- 
2.41.0


