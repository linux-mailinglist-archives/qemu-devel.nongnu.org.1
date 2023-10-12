Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3A57C662A
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 09:18:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqpw4-000743-KR; Thu, 12 Oct 2023 03:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqpvv-0006zJ-8Q; Thu, 12 Oct 2023 03:16:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqpvt-0000tG-My; Thu, 12 Oct 2023 03:16:35 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 843B729AC5;
 Thu, 12 Oct 2023 10:16:34 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 39A862E9B1;
 Thu, 12 Oct 2023 10:16:27 +0300 (MSK)
Received: (nullmailer pid 25944 invoked by uid 1000);
 Thu, 12 Oct 2023 07:16:26 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 59/61] util/log: re-allow switching away from stderr
 log file
Date: Thu, 12 Oct 2023 10:16:15 +0300
Message-Id: <20231012071626.25905-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231012101342@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231012101342@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Fiona Ebner <f.ebner@proxmox.com>

Commit 59bde21374 ("util/log: do not close and reopen log files when
flags are turned off") prevented switching away from stderr on a
subsequent invocation of qemu_set_log_internal(). This prevented
switching away from stderr with the 'logfile' monitor command as well
as an invocation like
> ./qemu-system-x86_64 -trace 'qemu_mutex_lock,file=log'
from opening the specified log file.

Fixes: 59bde21374 ("util/log: do not close and reopen log files when flags are turned off")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20231004124446.491481-1-f.ebner@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit f05142d511e86d8e97967d21f205d990dfc634de)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/log.c b/util/log.c
index def88a9402..d36c98da0b 100644
--- a/util/log.c
+++ b/util/log.c
@@ -298,6 +298,8 @@ static bool qemu_set_log_internal(const char *filename, bool changed_name,
             r->fd = logfile;
             qatomic_rcu_set(&global_file, NULL);
             call_rcu(r, rcu_close_file, rcu);
+        }
+        if (changed_name) {
             logfile = NULL;
         }
     }
-- 
2.39.2


