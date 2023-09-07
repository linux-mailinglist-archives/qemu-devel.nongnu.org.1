Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F301796F5A
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 05:44:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe5uk-0008TT-T2; Wed, 06 Sep 2023 23:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qe5ug-0008Qy-2z
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 23:42:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qe5uc-0007HV-JY
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 23:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694058154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hSq/Q6p6zY46YcV2htNwmTEKVoVPDETglkXl1ZqtCw0=;
 b=L/+FEW3zfVzzGXbcrv1+QsgqwQHHkXGBn+dlCAo0hMl5+6iTqR3J981aAhgb7vLHl4ihPc
 BiH1HI1ii//nMtYzlImcxtRgQcvL58OAxxKjWeyFYLPeT6BS0E64Z9uUKgIn1kNwDCaOGX
 H/s+X5FItIYLDXDSEe2eT2PNrg1ab/k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-iQZpO-o3NL2I6UzM44lkqA-1; Wed, 06 Sep 2023 23:42:31 -0400
X-MC-Unique: iQZpO-o3NL2I6UzM44lkqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84EE53806704;
 Thu,  7 Sep 2023 03:42:30 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DA7810EA0;
 Thu,  7 Sep 2023 03:42:30 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL for-6.2 4/7] hw/ide/ahci: PxSACT and PxCI is cleared when
 PxCMD.ST is cleared
Date: Wed,  6 Sep 2023 23:42:25 -0400
Message-ID: <20230907034228.4054839-5-jsnow@redhat.com>
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

According to AHCI 1.3.1 definition of PxSACT:
This field is cleared when PxCMD.ST is written from a '1' to a '0' by
software. This field is not cleared by a COMRESET or a software reset.

According to AHCI 1.3.1 definition of PxCI:
This field is also cleared when PxCMD.ST is written from a '1' to a '0'
by software.

Clearing PxCMD.ST is part of the error recovery procedure, see
AHCI 1.3.1, section "6.2 Error Recovery".

If we don't clear PxCI on error recovery, the previous command will
incorrectly still be marked as pending after error recovery.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230609140844.202795-6-nks@flawful.org
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 3deaf01add..a31e6fa65e 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -329,6 +329,11 @@ static void ahci_port_write(AHCIState *s, int port, int offset, uint32_t val)
         ahci_check_irq(s);
         break;
     case AHCI_PORT_REG_CMD:
+        if ((pr->cmd & PORT_CMD_START) && !(val & PORT_CMD_START)) {
+            pr->scr_act = 0;
+            pr->cmd_issue = 0;
+        }
+
         /* Block any Read-only fields from being set;
          * including LIST_ON and FIS_ON.
          * The spec requires to set ICC bits to zero after the ICC change
-- 
2.41.0


