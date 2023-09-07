Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC01796F5C
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 05:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe5un-0008Vg-Sm; Wed, 06 Sep 2023 23:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qe5uk-0008Tq-Pa
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 23:42:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qe5ud-0007LG-Mp
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 23:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694058155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEnMEz2MyNT1yW1MOP5px/rjLqN8e6I9lEZ5awzrYtk=;
 b=WsWzY2rqYmdMHRbAIgaaee2GrBJwaOsI4kikEGx2uxi21N8M1z1vTe0sFrITk0tV+NGWBl
 k+m4QZT2PKv3UrTnukklES/slsHhJHcx/okrjBPvg8GAhaVPnCks6yXUqnkqtEDuRHcwG8
 VoNT0QyFp2+g4If01GkCPDc/kZCKCH0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-OASMrh_sNdeqwWF3h8kpHw-1; Wed, 06 Sep 2023 23:42:31 -0400
X-MC-Unique: OASMrh_sNdeqwWF3h8kpHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 504F389CB00;
 Thu,  7 Sep 2023 03:42:31 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE53110EA0;
 Thu,  7 Sep 2023 03:42:30 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL for-6.2 6/7] hw/ide/ahci: fix ahci_write_fis_sdb()
Date: Wed,  6 Sep 2023 23:42:27 -0400
Message-ID: <20230907034228.4054839-7-jsnow@redhat.com>
In-Reply-To: <20230907034228.4054839-1-jsnow@redhat.com>
References: <20230907034228.4054839-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

When there is an error, we need to raise a TFES error irq, see AHCI 1.3.1,
5.3.13.1 SDB:Entry.

If ERR_STAT is set, we jump to state ERR:FatalTaskfile, which will raise
a TFES IRQ unconditionally, regardless if the I bit is set in the FIS or
not.

Thus, we should never raise a normal IRQ after having sent an error IRQ.

It is valid to signal successfully completed commands as finished in the
same SDB FIS that generates the error IRQ. The important thing is that
commands that did not complete successfully (e.g. commands that were
aborted, do not get the finished bit set).

Before this commit, there was never a TFES IRQ raised on NCQ error.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230609140844.202795-8-nks@flawful.org
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 12aaadc554..ef6c9fc378 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -806,8 +806,14 @@ static void ahci_write_fis_sdb(AHCIState *s, NCQTransferState *ncq_tfs)
     pr->scr_act &= ~ad->finished;
     ad->finished = 0;
 
-    /* Trigger IRQ if interrupt bit is set (which currently, it always is) */
-    if (sdb_fis->flags & 0x40) {
+    /*
+     * TFES IRQ is always raised if ERR_STAT is set, regardless of I bit.
+     * If ERR_STAT is not set, trigger SDBS IRQ if interrupt bit is set
+     * (which currently, it always is).
+     */
+    if (sdb_fis->status & ERR_STAT) {
+        ahci_trigger_irq(s, ad, AHCI_PORT_IRQ_BIT_TFES);
+    } else if (sdb_fis->flags & 0x40) {
         ahci_trigger_irq(s, ad, AHCI_PORT_IRQ_BIT_SDBS);
     }
 }
-- 
2.41.0


