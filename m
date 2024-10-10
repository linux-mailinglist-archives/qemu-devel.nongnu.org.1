Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCA0998DE2
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Oct 2024 18:57:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sywT9-000072-IU; Thu, 10 Oct 2024 12:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sywSx-00005l-IV
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sywSw-0000bf-1U
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728579400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=C7FaVE6EH7XBkqNtCES1SEsciaiaJFdQ2HrRn+cpnCI=;
 b=dOL66Uim9ltqNoyR6cseJzFYnHwp7od1hD8ll8fg5uUhOkhV14XHQgvVEe8pocEcM02jIY
 GQZ6iiOllXiUfctVh8j+dkUkTCGr4Dk5zaUxXPrLYkDLDLs3nZBDBnKoFl0p1gSs4JSLyW
 /biGwjyQVdDFLPtGf3y1cHmbZSwnh3E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-tkyQmQZ_MfugpRkVWi_pMg-1; Thu,
 10 Oct 2024 12:56:34 -0400
X-MC-Unique: tkyQmQZ_MfugpRkVWi_pMg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7EA31956046; Thu, 10 Oct 2024 16:56:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DB3919560A3; Thu, 10 Oct 2024 16:56:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4636121E6A28; Thu, 10 Oct 2024 18:56:28 +0200 (CEST)
Resent-To: michael.roth@amd.com, xieyongji@bytedance.com,
 Coiby.Xu@gmail.com, eduardo@habkost.net, mark.cave-ayland@ilande.co.uk,
 philmd@linaro.org, qemu-block@nongnu.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Thu, 10 Oct 2024 18:56:28 +0200
Resent-Message-ID: <87plo7hp6r.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Thu Oct 10 17:01:44 2024
X-Original-To: armbru
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A00D21E6891; Thu, 10 Oct 2024 17:01:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: xieyongji@bytedance.com, kwolf@redhat.com, hreitz@redhat.com,
 Coiby.Xu@gmail.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, mark.cave-ayland@ilande.co.uk, michael.roth@amd.com,
 kkostiuk@redhat.com, qemu-block@nongnu.org, philmd@linaro.org
Subject: [PATCH v2 6/7] hw/intc/openpic: Improve errors for out of bounds
 property values
Date: Thu, 10 Oct 2024 17:01:43 +0200
Message-ID: <20241010150144.986655-7-armbru@redhat.com>
In-Reply-To: <20241010150144.986655-1-armbru@redhat.com>
References: <20241010150144.986655-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Lines: 37
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The error message doesn't matter much, as the "openpic" device isn't
user-creatable.  But it's the last use of
QERR_PROPERTY_VALUE_OUT_OF_RANGE, which has to go.  Change the message
just like the previous commit did for x86 CPUs.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/intc/openpic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 32bd880dfa..cd3d87768e 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -41,7 +41,6 @@
 #include "hw/pci/msi.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
@@ -1535,9 +1534,7 @@ static void openpic_realize(DeviceState *dev, Error **errp)
     };
 
     if (opp->nb_cpus > MAX_CPU) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
-                   TYPE_OPENPIC, "nb_cpus", (uint64_t)opp->nb_cpus,
-                   (uint64_t)0, (uint64_t)MAX_CPU);
+        error_setg(errp, "property 'nb_cpus' can be at most %d", MAX_CPU);
         return;
     }
 
-- 
2.46.0



