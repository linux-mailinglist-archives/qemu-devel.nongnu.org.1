Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7EDB13AA6
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Jul 2025 14:39:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugN7m-0000ad-Iy; Mon, 28 Jul 2025 08:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ugMOk-0007K6-14
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ugMOi-0004Ao-5m
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753703523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pVtIasSIO1whlGH6OE9X6z7Twiezig7uP2gbURPfn8Q=;
 b=MZ1a5UYN2gLrpeK2w/1v26QpHpxgs6sioMgdMAohjvBTMz5u42A4QB5z2wNyiI8KgnyJOr
 oywLJoqILEFkx7S0KlpjEvRPnlA3Kn9ZG5FnOGX14o41una8FdpFIbZqJE/8QKtTWPYiHD
 SeagegBqN9jgyl8gRfRPaB7kXADK0bI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-WsTdgRSRMAmxFpUv9oLQIA-1; Mon,
 28 Jul 2025 07:51:58 -0400
X-MC-Unique: WsTdgRSRMAmxFpUv9oLQIA-1
X-Mimecast-MFC-AGG-ID: WsTdgRSRMAmxFpUv9oLQIA_1753703517
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3E291800258; Mon, 28 Jul 2025 11:51:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 056D619560A2; Mon, 28 Jul 2025 11:51:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-trivial@nongnu.org
Subject: [PATCH] hw/mips/malta: Silence warning from ubsan
Date: Mon, 28 Jul 2025 13:51:51 +0200
Message-ID: <20250728115152.187728-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When compiling QEMU with --enable-ubsan there is a undefined behavior
warning when using the malta machine:

 hw/mips/malta.c:1200:32: runtime error: addition of unsigned offset
  to 0x7fb620600000 overflowed to 0x7fb6205fffff
 SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior hw/mips/malta.c:1200:32

To fix the issue, check the bios_size whether we really loaded the
firmware before trying to byte-swap the instructions here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/mips/malta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index cbdbb210568..47dd4016cfd 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1190,7 +1190,7 @@ void mips_malta_init(MachineState *machine)
          * In little endian mode the 32bit words in the bios are swapped,
          * a neat trick which allows bi-endian firmware.
          */
-        if (!TARGET_BIG_ENDIAN) {
+        if (!TARGET_BIG_ENDIAN && bios_size > 0) {
             uint32_t *end, *addr;
             const size_t swapsize = MIN(bios_size, 0x3e0000);
             addr = rom_ptr(FLASH_ADDRESS, swapsize);
-- 
2.50.1


