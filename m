Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23614796F5D
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 05:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe5uj-0008Ro-4E; Wed, 06 Sep 2023 23:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qe5uf-0008Qw-Uv
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 23:42:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qe5uc-0007GL-Cd
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 23:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694058153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kml/kC5jLFV7COgE5xZOBrlfjP/Q3rGOoJviKF9qagw=;
 b=CAFAw1AO8P1lbUppeewWs21X+dS+v5PZRuBrK4+FGj5VWihbcfL5ed4s9dP/OxHBWNSTbU
 qiQ6dvk8s+aXCh79sKjzcqEHX8QPiC9ZnEXXnUPjBiJxjhkC9Neb4IbFIwIzjnC9F2Pkpn
 q6ARG7P2AzMAhHBdxH3Shtuiw+gZpF8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-r6VCg9KgPz2dYV6KsRuzmg-1; Wed, 06 Sep 2023 23:42:29 -0400
X-MC-Unique: r6VCg9KgPz2dYV6KsRuzmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D5D81C0758A;
 Thu,  7 Sep 2023 03:42:29 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2C4263F6C;
 Thu,  7 Sep 2023 03:42:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL for-6.2 1/7] hw/ide/core: set ERR_STAT in unsupported command
 completion
Date: Wed,  6 Sep 2023 23:42:22 -0400
Message-ID: <20230907034228.4054839-2-jsnow@redhat.com>
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

From: Niklas Cassel <niklas.cassel@wdc.com>

Currently, the first time sending an unsupported command
(e.g. READ LOG DMA EXT) will not have ERR_STAT set in the completion.
Sending the unsupported command again, will correctly have ERR_STAT set.

When ide_cmd_permitted() returns false, it calls ide_abort_command().
ide_abort_command() first calls ide_transfer_stop(), which will call
ide_transfer_halt() and ide_cmd_done(), after that ide_abort_command()
sets ERR_STAT in status.

ide_cmd_done() for AHCI will call ahci_write_fis_d2h() which writes the
current status in the FIS, and raises an IRQ. (The status here will not
have ERR_STAT set!).

Thus, we cannot call ide_transfer_stop() before setting ERR_STAT, as
ide_transfer_stop() will result in the FIS being written and an IRQ
being raised.

The reason why it works the second time, is that ERR_STAT will still
be set from the previous command, so when writing the FIS, the
completion will correctly have ERR_STAT set.

Set ERR_STAT before writing the FIS (calling cmd_done), so that we will
raise an error IRQ correctly when receiving an unsupported command.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230609140844.202795-3-nks@flawful.org
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index ee116891ed..b5e0dcd29b 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -533,9 +533,9 @@ BlockAIOCB *ide_issue_trim(
 
 void ide_abort_command(IDEState *s)
 {
-    ide_transfer_stop(s);
     s->status = READY_STAT | ERR_STAT;
     s->error = ABRT_ERR;
+    ide_transfer_stop(s);
 }
 
 static void ide_set_retry(IDEState *s)
-- 
2.41.0


