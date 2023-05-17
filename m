Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B820706239
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:08:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC70-0003PI-94; Wed, 17 May 2023 04:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6o-0002s5-Vq
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:07 -0400
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1pzC6i-0000v3-WB
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:02:05 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MV5G4-1pYM541pF0-00SBNt; Wed, 17
 May 2023 10:01:56 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 5/9] linux-user/main: Use list_cpus() instead of cpu_list()
Date: Wed, 17 May 2023 10:01:48 +0200
Message-Id: <20230517080152.108660-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517080152.108660-1-laurent@vivier.eu>
References: <20230517080152.108660-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qimp3/uAReEsbHbhFU2YOHSkDqU6jHjSlSbkY0eaE87bhnH/D+k
 A4lepgYeW4zaBZmGXI542UwO2BJP+CUXLbnMiRaYFqkgeIsUKWQ1Dvpb3QxnJigDDklC/9d
 4pDPYZgDsSZFS8rpjIiBqqV1RaHLQpVMThB4/wxl4imhjJFtPpwgUPEIGuf4gU57VQCIC6P
 8jsdHFEdzeLi4xnlP0VcA==
UI-OutboundReport: notjunk:1;M01:P0:njDmsY3RH40=;+0FP3SsRfGR4gCl0rYQhgVpTAwb
 H4cpIZDTjH9PFMegWAtxkS66vHxtu7JcHo7duWfSzl7VHJ3fs7Ju3IFJvdY4EzgDLpp9uHYZr
 7UNanRXp5C9lKGSVPseSUShllYuXVU7CVm+/7Z8vRyJa8g57TWenCCIed+t1W/nRCvyCjVGul
 7GIt29FXG3HJsauDcuWJgYEzzzBz/XwdJnPfvKjxApAfHKTDBw5hNTL0TOordknRl5lMd9H2e
 Y43KaJgVt0ycjBSspKxEaFcolCkZ90LkXLLcmSn0aVMZIOllssOoNe/Ns/yX0qu73kYFcIpr1
 tgLk7yESatCL9LN9bvbtJ0wQLhLsnbsxdMTCCvNHKl+VWMZlCKQshS0+FqdeWdGcPVdhCXdms
 9rcZLyMX3bvvOAdI8bcd9Iam73eg37kGPkxYgLY2au0wVg00plTxI6ryefqdF5omYGxOqvbpQ
 NclIXeCRyAM4rT8x3xGNqWJzNoMIzq2BVUFCjzxo4QYSR7I0u7l2tPpAPhtws+JRZ9xS7h1qt
 8FCMgo/cVZXGieFq+rInAnt/LN5VXfLZC2Lw0yTuDCmCKqMJ/W2eE8CazeLqx+yjoP2aSK6Xk
 GS0DW/DzRNJ/IRw3/Pbe+4hWd8HYv68vBARF1WG/h5WPUGf6l75yDUmStg+JAeP1LQrVVpYfQ
 jvrPosj3h/54nBWXMui14SCw2lSJe5yXBd9aIMZc/g==
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
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


