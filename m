Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C28B82227A
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 21:20:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKlER-00066D-AB; Tue, 02 Jan 2024 15:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1rKlEO-00065j-60
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 15:19:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1rKlEK-0005dC-V7
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 15:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704226754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQRTBLiB5sCWPY/SSBV8dpy8QCL1auf0MVKDKGE0e9Q=;
 b=P9Jf4DWObZo0EoPmOxLp3/xDtIoTg5nePPKKpWR3STnuRQd960ZugBsxHygOMskBxXCneW
 xaM+KWcPWdyuUoM4ZNrCLVJJheFMaAWjECY16iGi1jNwBq65IVl57NOLHz3iTBaOeI24NQ
 M473kkc9mnrgJLwCr4Q13TKta980Xgw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-K9t77doPNtKhOFjVW3aPmg-1; Tue, 02 Jan 2024 15:19:12 -0500
X-MC-Unique: K9t77doPNtKhOFjVW3aPmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B83A85A58A;
 Tue,  2 Jan 2024 20:19:11 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3F3F1121306;
 Tue,  2 Jan 2024 20:19:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@trasno.org,
	Juan Quintela <quintela@redhat.com>
Subject: [PATCH 1/1] Leaving Migration
Date: Tue,  2 Jan 2024 21:19:07 +0100
Message-ID: <20240102201908.1987-2-quintela@redhat.com>
In-Reply-To: <20240102201908.1987-1-quintela@redhat.com>
References: <20240102201908.1987-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

I am leaving Red Hat, and as part of that I am leaving Migration
maintenarship.

You are left in good hands with Peter and Fabiano.

Thanks for all the fish.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 MAINTAINERS | 3 ---
 .mailmap    | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 395f26ba86..56464cd916 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -70,7 +70,6 @@ R: Daniel P. Berrangé <berrange@redhat.com>
 R: Thomas Huth <thuth@redhat.com>
 R: Markus Armbruster <armbru@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
-R: Juan Quintela <quintela@redhat.com>
 W: https://www.qemu.org/docs/master/devel/index.html
 S: Odd Fixes
 F: docs/devel/style.rst
@@ -3355,7 +3354,6 @@ S: Odd Fixes
 F: scripts/checkpatch.pl
 
 Migration
-M: Juan Quintela <quintela@redhat.com>
 M: Peter Xu <peterx@redhat.com>
 M: Fabiano Rosas <farosas@suse.de>
 R: Leonardo Bras <leobras@redhat.com>
@@ -3375,7 +3373,6 @@ F: util/userfaultfd.c
 X: migration/rdma*
 
 RDMA Migration
-M: Juan Quintela <quintela@redhat.com>
 R: Li Zhijian <lizhijian@fujitsu.com>
 R: Peter Xu <peterx@redhat.com>
 R: Leonardo Bras <leobras@redhat.com>
diff --git a/.mailmap b/.mailmap
index e12e19f691..d94572af05 100644
--- a/.mailmap
+++ b/.mailmap
@@ -81,6 +81,7 @@ Greg Kurz <groug@kaod.org> <gkurz@linux.vnet.ibm.com>
 Huacai Chen <chenhuacai@kernel.org> <chenhc@lemote.com>
 Huacai Chen <chenhuacai@kernel.org> <chenhuacai@loongson.cn>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
+Juan Quintela <quintela@trasno.org> <quintela@redhat.com>
 Leif Lindholm <quic_llindhol@quicinc.com> <leif.lindholm@linaro.org>
 Leif Lindholm <quic_llindhol@quicinc.com> <leif@nuviainc.com>
 Luc Michel <luc@lmichel.fr> <luc.michel@git.antfield.fr>
-- 
2.43.0


