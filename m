Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B37029AC023
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Oct 2024 09:24:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Vj6-0002M8-HD; Wed, 23 Oct 2024 03:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3Vj4-0002Lt-5S
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3Vj1-0006SI-R2
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729668250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lg1cK11UyUr2YjlwC5rqSgQC0PQiCQPtbQFrNWRQdHo=;
 b=QI+4oy2JoqhEQPg/xBD99g6jwl3ixEZS4hx9KrpxfFFBqP3NbNMOL5HIB7etb59X+GEBF5
 ULJBB/BI0HUW4TMQqrHqbTgD7vTTtt51kX2gatsaNlYQve9LtTtZWH7BxTbR0OVYKijZEG
 JpfwSaterlYdU/1+HPu1bT3SrD93gDA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-JuMxaNotNj-PIeG9szFzEA-1; Wed,
 23 Oct 2024 03:24:04 -0400
X-MC-Unique: JuMxaNotNj-PIeG9szFzEA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 293511955E9D; Wed, 23 Oct 2024 07:24:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED8CA1956088; Wed, 23 Oct 2024 07:24:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Brad Smith <brad@comstyle.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/vm/openbsd: Remove the "Time appears wrong" workaround
Date: Wed, 23 Oct 2024 09:23:58 +0200
Message-ID: <20241023072358.827714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Seems like the server now reports the right time again, so we have
to drop the workaround to get the installer working again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/openbsd | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index dfd11c93f0..5e4f76f398 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -159,7 +159,6 @@ class OpenBSDVM(basevm.BaseVM):
 
         self.print_step("Installation started now, this will take a while")
         self.console_wait_send("Location of sets",        "done\n")
-        self.console_wait_send("Time appears wrong.  Set to", "\n")
 
         self.console_wait("successfully completed")
         self.print_step("Installation finished, rebooting")
-- 
2.47.0


