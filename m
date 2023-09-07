Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D234A796F56
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 05:43:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe5un-0008VP-GF; Wed, 06 Sep 2023 23:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qe5uk-0008Um-UG
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 23:42:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qe5ug-0007Su-Qt
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 23:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694058158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P542PCZwa+R/o7KVrUDx18xI3nQx1VMZvSz6Sb/UXfc=;
 b=Bf7SQy9/ktNO6cXanBYLHfsthW5ZKsiJyl7RS/GKtrY5QR/J1VAVlYgDOl1fjU/22/p0zJ
 a0i0MnQZgE8PL25ESzmL9hj3C6cRAk86Y863KMAzizlGViYirps/HQWbGyxfQVBNNJjFUg
 B0sL+20p98X0OLMLXjehEnIAIA32vVw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332--Wci9MwuN-2plfEUPHTsEw-1; Wed, 06 Sep 2023 23:42:32 -0400
X-MC-Unique: -Wci9MwuN-2plfEUPHTsEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEAF61C0758F;
 Thu,  7 Sep 2023 03:42:31 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D01763F6C;
 Thu,  7 Sep 2023 03:42:31 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL for-6.2 7/7] hw/ide/ahci: fix broken SError handling
Date: Wed,  6 Sep 2023 23:42:28 -0400
Message-ID: <20230907034228.4054839-8-jsnow@redhat.com>
In-Reply-To: <20230907034228.4054839-1-jsnow@redhat.com>
References: <20230907034228.4054839-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Niklas Cassel <niklas.cassel@wdc.com>

When encountering an NCQ error, you should not write the NCQ tag to the
SError register. This is completely wrong.

The SError register has a clear definition, where each bit represents a
different error, see PxSERR definition in AHCI 1.3.1.

If we write a random value (like the NCQ tag) in SError, e.g. Linux will
read SError, and will trigger arbitrary error handling depending on the
NCQ tag that happened to be executing.

In case of success, ncq_cb() will call ncq_finish().
In case of error, ncq_cb() will call ncq_err() (which will clear
ncq_tfs->used), and then call ncq_finish(), thus using ncq_tfs->used is
sufficient to tell if finished should get set or not.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230609140844.202795-9-nks@flawful.org
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index ef6c9fc378..d0a774bc17 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1012,7 +1012,6 @@ static void ncq_err(NCQTransferState *ncq_tfs)
 
     ide_state->error = ABRT_ERR;
     ide_state->status = READY_STAT | ERR_STAT;
-    ncq_tfs->drive->port_regs.scr_err |= (1 << ncq_tfs->tag);
     qemu_sglist_destroy(&ncq_tfs->sglist);
     ncq_tfs->used = 0;
 }
@@ -1022,7 +1021,7 @@ static void ncq_finish(NCQTransferState *ncq_tfs)
     /* If we didn't error out, set our finished bit. Errored commands
      * do not get a bit set for the SDB FIS ACT register, nor do they
      * clear the outstanding bit in scr_act (PxSACT). */
-    if (!(ncq_tfs->drive->port_regs.scr_err & (1 << ncq_tfs->tag))) {
+    if (ncq_tfs->used) {
         ncq_tfs->drive->finished |= (1 << ncq_tfs->tag);
     }
 
-- 
2.41.0


