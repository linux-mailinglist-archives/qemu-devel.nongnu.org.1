Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B901D9C2CEC
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 13:26:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kU0-0005qX-4u; Sat, 09 Nov 2024 07:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kRt-00031a-90; Sat, 09 Nov 2024 07:20:18 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kRr-0005nZ-Gz; Sat, 09 Nov 2024 07:20:16 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EA1DDA165D;
 Sat,  9 Nov 2024 15:08:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B09A7167FE3;
 Sat,  9 Nov 2024 15:09:04 +0300 (MSK)
Received: (nullmailer pid 3296286 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Igor Mammedov <imammedo@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 51/58] acpi/disassemle-aml.sh: fix up after dir reorg
Date: Sat,  9 Nov 2024 15:08:52 +0300
Message-Id: <20241109120901.3295995-51-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: "Michael S. Tsirkin" <mst@redhat.com>

We moved expected files around, fix up the disassembler script.

Fixes: 7c08eefcaf ("tests/data/acpi: Move x86 ACPI tables under x86/${machine} path")
Fixes: 7434f90467 ("tests/data/acpi/virt: Move ARM64 ACPI tables under aarch64/${machine} path")
Cc: "Sunil V L" <sunilvl@ventanamicro.com>
Message-ID: <ce456091058734b7f765617ac5dfeebcb366d4a9.1730729695.git.mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
(cherry picked from commit feb58e3b261db503ade94c5f43ccedeee4eac41f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/data/acpi/disassemle-aml.sh b/tests/data/acpi/disassemle-aml.sh
index 253b7620a0..89561d233d 100755
--- a/tests/data/acpi/disassemle-aml.sh
+++ b/tests/data/acpi/disassemle-aml.sh
@@ -14,7 +14,7 @@ while getopts "o:" arg; do
   esac
 done
 
-for machine in tests/data/acpi/*
+for machine in tests/data/acpi/*/*
 do
     if [[ ! -d "$machine" ]];
     then
-- 
2.39.5


