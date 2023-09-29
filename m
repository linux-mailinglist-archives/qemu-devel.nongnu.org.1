Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD7C7B2E86
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:56:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9DW-00050q-9l; Fri, 29 Sep 2023 04:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DN-0004xt-E5
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DA-0005bv-Ph
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5OSnQuURtOEaWDZzPXgID5euxSqDLR06RTAy/I5xWro=;
 b=cd23FgNveUtco/KFCx8Qy+aUgZiu2mmdgb+/+m3OQ9mwHD04xVoFzVigg8TjSo2ggG3uGL
 DZoApKu03HQ6FkfcsSiDO0RbO3FQRW6Sf69ElomgeoGpXU/oVfPNMH/1JnFInMs8xf/V7m
 SC8dX0MW56LLDg78XxcsPwAMdVbZnQU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-Z0a2Tsd5NtKGD3QgQRxF_Q-1; Fri, 29 Sep 2023 04:50:58 -0400
X-MC-Unique: Z0a2Tsd5NtKGD3QgQRxF_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03E548030A9
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 08:50:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB0E714171CA
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 08:50:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E2CC121E68A6; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 49/56] seccomp: avoid shadowing of 'action' variable
Date: Fri, 29 Sep 2023 10:50:46 +0200
Message-ID: <20230929085053.2789105-50-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

From: Daniel P. Berrangé <berrange@redhat.com>

This is confusing as one 'action' variable is used for storing
a SCMP_ enum value, while the other 'action' variable is used
for storing a SECCOMP_ enum value.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20230922160644.438631-3-berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 softmmu/qemu-seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/softmmu/qemu-seccomp.c b/softmmu/qemu-seccomp.c
index d66a2a1226..4d7439e7f7 100644
--- a/softmmu/qemu-seccomp.c
+++ b/softmmu/qemu-seccomp.c
@@ -283,9 +283,9 @@ static uint32_t qemu_seccomp_update_action(uint32_t action)
     if (action == SCMP_ACT_TRAP) {
         static int kill_process = -1;
         if (kill_process == -1) {
-            uint32_t action = SECCOMP_RET_KILL_PROCESS;
+            uint32_t testaction = SECCOMP_RET_KILL_PROCESS;
 
-            if (qemu_seccomp(SECCOMP_GET_ACTION_AVAIL, 0, &action) == 0) {
+            if (qemu_seccomp(SECCOMP_GET_ACTION_AVAIL, 0, &testaction) == 0) {
                 kill_process = 1;
             } else {
                 kill_process = 0;
-- 
2.41.0


