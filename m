Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3577B7F90
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:45:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1FV-0001Gy-RX; Wed, 04 Oct 2023 08:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qo1FP-0001GY-Fm; Wed, 04 Oct 2023 08:45:03 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qo1FN-0005UE-9p; Wed, 04 Oct 2023 08:45:03 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 12BCD445AC;
 Wed,  4 Oct 2023 14:44:50 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pbonzini@redhat.com, richard.henderson@linaro.org,
 groug@kaod.org, qemu-stable@nongnu.org
Subject: [PATCH] util/log: re-allow switching away from stderr log file
Date: Wed,  4 Oct 2023 14:44:46 +0200
Message-Id: <20231004124446.491481-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Commit 59bde21374 ("util/log: do not close and reopen log files when
flags are turned off") prevented switching away from stderr on a
subsequent invocation of qemu_set_log_internal(). This prevented
switching away from stderr with the 'logfile' monitor command as well
as an invocation like
> ./qemu-system-x86_64 -trace 'qemu_mutex_lock,file=log'
from opening the specified log file.

Fixes: 59bde21374 ("util/log: do not close and reopen log files when flags are turned off")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 util/log.c | 2 ++
 1 file changed, 2 insertions(+)

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



