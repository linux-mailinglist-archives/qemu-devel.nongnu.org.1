Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FFA7A03D1
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:27:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qglQD-0007em-39; Thu, 14 Sep 2023 08:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1qglQ9-0007eB-3V
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:26:09 -0400
Received: from forward101c.mail.yandex.net ([178.154.239.212])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1qglQ4-0006OK-Vv
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:26:08 -0400
Received: from mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1f21:0:640:9366:0])
 by forward101c.mail.yandex.net (Yandex) with ESMTP id 0DD0A60143;
 Thu, 14 Sep 2023 15:25:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id wPfKhxJWqCg0-jliJKFIf; 
 Thu, 14 Sep 2023 15:25:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1694694358; bh=1U95sl2LYBa/fiQImMq0Zf2GaCEqxNyqbA3uR1jkIZQ=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=I1ST0pLWjDgqhATOe+p25pVvihEpR+5OW/ZglsaIEQXZZ/5ma59y5+yAvko0E0gwN
 T0xAO1mlF6NbAX4VlKw2qNVLH4RuvQ4FHviLhU8J1xQ/eUulFf/+1XHEYPHzfaJFss
 w/UbJwioq2OqVxMQ3+wtPHvahZ0dFe49pk+abDxM=
Authentication-Results: mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Nikita Shubin <n.shubin@yadro.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] gdbstub: Fix SEGFAULT in find_cpu_clusters()
Date: Thu, 14 Sep 2023 15:25:58 +0300
Message-Id: <20230914122558.2379-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.212;
 envelope-from=nikita.shubin@maquefel.me; helo=forward101c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Nikita Shubin <n.shubin@yadro.com>

target_xml is a dynamic GString, use NULL to initialize it.

Fixes: 56e534bd11 ("gdbstub: refactor get_feature_xml")

Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
Observed with:
build-qemu/qemu-system-riscv64 -M sifive_u -bios none -nographic -s
Segmentation fault
---
 gdbstub/softmmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
index 9f0b8b5497..42645d2220 100644
--- a/gdbstub/softmmu.c
+++ b/gdbstub/softmmu.c
@@ -292,7 +292,7 @@ static int find_cpu_clusters(Object *child, void *opaque)
         assert(cluster->cluster_id != UINT32_MAX);
         process->pid = cluster->cluster_id + 1;
         process->attached = false;
-        process->target_xml[0] = '\0';
+        process->target_xml = NULL;
 
         return 0;
     }
-- 
2.39.2


