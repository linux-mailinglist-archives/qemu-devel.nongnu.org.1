Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 275597BBBFA
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 17:44:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qomxf-0006Y5-Lz; Fri, 06 Oct 2023 11:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qomxc-0006UR-Fv; Fri, 06 Oct 2023 11:41:52 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qomxX-0003WH-P3; Fri, 06 Oct 2023 11:41:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3a8c:0:640:ec94:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 9E62B612D8;
 Fri,  6 Oct 2023 18:41:45 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:a512::1:22])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VfbK2W5OrKo0-LcaQGfab; Fri, 06 Oct 2023 18:41:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696606905;
 bh=gvkGZk/k24nZ1JAUhfPf/PBDaBGcGo+bo6/HMxHtkGk=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qBefuczYQrUco14NFznul17B0LRXoZDzSRxfZpqDXqo6AATnSDtyrCvSbTzC39H9r
 07hTanjt2OdFHevSum19R4LQugc9SjxDaJ1uUOLgbKhlv/k0XfCOsJ99liG35R8zSs
 1N2Se9Xk7lokR84OJi4kWoKimz7zBqgzMErJjME4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com,
 crosa@redhat.com, kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com
Subject: [PATCH v7 03/15] scripts/cpu-x86-uarch-abi.py: use .command() instead
 of .cmd()
Date: Fri,  6 Oct 2023 18:41:13 +0300
Message-Id: <20231006154125.1068348-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006154125.1068348-1-vsementsov@yandex-team.ru>
References: <20231006154125.1068348-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Here we don't expect a failure. In case of failure we'll crash on
trying to access ['return']. Better is to use .command() that clearly
raises on failure.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/cpu-x86-uarch-abi.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/cpu-x86-uarch-abi.py b/scripts/cpu-x86-uarch-abi.py
index 82ff07582f..893afd1b35 100644
--- a/scripts/cpu-x86-uarch-abi.py
+++ b/scripts/cpu-x86-uarch-abi.py
@@ -69,7 +69,7 @@
 shell = QEMUMonitorProtocol(sock)
 shell.connect()
 
-models = shell.cmd("query-cpu-definitions")
+models = shell.command("query-cpu-definitions")
 
 # These QMP props don't correspond to CPUID fatures
 # so ignore them
@@ -85,7 +85,7 @@
 
 names = []
 
-for model in models["return"]:
+for model in models:
     if "alias-of" in model:
         continue
     names.append(model["name"])
@@ -93,12 +93,12 @@
 models = {}
 
 for name in sorted(names):
-    cpu = shell.cmd("query-cpu-model-expansion",
-                     { "type": "static",
-                       "model": { "name": name }})
+    cpu = shell.command("query-cpu-model-expansion",
+                        { "type": "static",
+                          "model": { "name": name }})
 
     got = {}
-    for (feature, present) in cpu["return"]["model"]["props"].items():
+    for (feature, present) in cpu["model"]["props"].items():
         if present and feature not in skip:
             got[feature] = True
 
-- 
2.34.1


