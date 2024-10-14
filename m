Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4226299D12A
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Oct 2024 17:11:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0MiS-0007LE-BE; Mon, 14 Oct 2024 11:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t0MiQ-0007Ks-Ch
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t0MiO-0007d8-R2
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728918631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tatJhW1uqhERX+GEQHiFhh7w1BJntOTMvbo0xwCTZQ8=;
 b=QH0+VjyO7CX9MO/ev3MexXn8nYGEYly7Dd+998r53DyWFnvsH3Za7Eb0ph1knnd0Gy/45e
 m69/vAqUaUZh/Zluzf3upLRNDcFuB2FS4U/LWLSU9sfysLV1IQK+1kVz9C/ZfVN/XRWnd1
 qeuGjysybDZa1+Dlt2KQF+w+CRwnjXI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-w-RqUK13Pc-0aEe2Np6SBg-1; Mon,
 14 Oct 2024 11:10:28 -0400
X-MC-Unique: w-RqUK13Pc-0aEe2Np6SBg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEFCB19560B2; Mon, 14 Oct 2024 15:10:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.161])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 926AF19560A2; Mon, 14 Oct 2024 15:10:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH] ui/console-vc: Silence warning about sprintf() on OpenBSD
Date: Mon, 14 Oct 2024 17:10:23 +0200
Message-ID: <20241014151023.85698-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The linker on OpenBSD complains:

 ld: warning: console-vc.c:824 (../src/ui/console-vc.c:824)([...]):
 warning: sprintf() is often misused, please use snprintf()

Using snprintf() is certainly better here, so let's switch to that
function instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 ui/console-vc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 8393d532e7..336a1520eb 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -821,9 +821,9 @@ static void vc_putchar(VCChardev *vc, int ch)
                     break;
                 case 6:
                     /* report cursor position */
-                    sprintf(response, "\033[%d;%dR",
-                           (s->y_base + s->y) % s->total_height + 1,
-                            s->x + 1);
+                    snprintf(response, sizeof(response), "\033[%d;%dR",
+                             (s->y_base + s->y) % s->total_height + 1,
+                             s->x + 1);
                     vc_respond_str(vc, response);
                     break;
                 }
-- 
2.46.1


