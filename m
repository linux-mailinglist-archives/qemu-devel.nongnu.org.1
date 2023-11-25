Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7037F8C0F
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Nov 2023 16:29:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6uZX-0006oX-Lx; Sat, 25 Nov 2023 10:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1r6uZU-0006o9-4O
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 10:27:52 -0500
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1r6uZS-0000FN-0m
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 10:27:51 -0500
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTP id 2C3F4DA0EEF;
 Sat, 25 Nov 2023 16:27:46 +0100 (CET)
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id 944374668C8; Sat, 25 Nov 2023 16:27:45 +0100 (CET)
To: Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org,
	Stefan Weil <sw@weilnetz.de>
Subject: [PATCH for-8.2] Fix broken build for QEMU guest agent
Date: Sat, 25 Nov 2023 16:27:40 +0100
Message-Id: <20231125152740.584224-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.120.169.71; envelope-from=stefan@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Meson setup failed:

    qga/meson.build:148:4: ERROR: Unknown variable "project".

Fixes commit e20d68aa ("configure, meson: use command line options [...]").

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 qga/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/meson.build b/qga/meson.build
index 940a51d55d..ff7a8496e4 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -146,7 +146,7 @@ if targetos == 'windows'
       libpcre = 'libpcre2'
     endif
     qga_msi_version = get_option('qemu_ga_version') == '' \
-      ? project.version() \
+      ? meson.project_version() \
       : get_option('qemu_ga_version')
     qga_msi = custom_target('QGA MSI',
                             input: files('installer/qemu-ga.wxs'),
-- 
2.39.2


