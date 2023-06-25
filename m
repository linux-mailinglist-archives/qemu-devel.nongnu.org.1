Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 980A373D042
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 13:08:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDNag-0004Ps-AF; Sun, 25 Jun 2023 07:07:35 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhipeng@cestc.cn>)
 id 1qDNab-0004JY-P4
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 07:07:29 -0400
Received: from [1.203.97.240] (helo=smtp.cecloud.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luzhipeng@cestc.cn>) id 1qDNaV-0001O5-Ru
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 07:07:29 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.cecloud.com (Postfix) with ESMTP id A2D02900112;
 Sun, 25 Jun 2023 19:07:16 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.48.58.13])
 by smtp.cecloud.com (postfix) whith ESMTP id
 P2917246T281458635436400S1687691234016435_; 
 Sun, 25 Jun 2023 19:07:16 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <cdf6824edc609b33efe3ac1942d104cf>
X-RL-SENDER: luzhipeng@cestc.cn
X-SENDER: luzhipeng@cestc.cn
X-LOGIN-NAME: luzhipeng@cestc.cn
X-FST-TO: qemu-devel@nongnu.org
X-RCPT-COUNT: 3
X-SENDER-IP: 111.48.58.13
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From: luzhipeng <luzhipeng@cestc.cn>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhipeng Lu <luzhipeng@cestc.cn>
Subject: [PATCH] contrib/gitdm: add domain-map for Cestc
Date: Sun, 25 Jun 2023 19:06:59 +0800
Message-Id: <20230625110659.428-1-luzhipeng@cestc.cn>
X-Mailer: git-send-email 2.34.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 1.203.97.240 (failed)
Received-SPF: pass client-ip=1.203.97.240; envelope-from=luzhipeng@cestc.cn;
 helo=smtp.cecloud.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, HEXHASH_WORD=1, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Zhipeng Lu <luzhipeng@cestc.cn>

Signed-off-by: Zhipeng Lu <luzhipeng@cestc.cn>
---
 contrib/gitdm/domain-map | 1 +
 meson                    | 2 +-
 qapi/block-core.json     | 3 ++-
 roms/SLOF                | 2 +-
 roms/opensbi             | 2 +-
 roms/qboot               | 2 +-
 roms/seabios             | 2 +-
 roms/seabios-hppa        | 2 +-
 roms/skiboot             | 2 +-
 tests/lcitool/libvirt-ci | 2 +-
 10 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 3727918641..e1c1bf2a31 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -7,6 +7,7 @@
 amd.com         AMD
 baidu.com       Baidu
 bytedance.com   ByteDance
+cestc.cn        Cestc
 cmss.chinamobile.com China Mobile
 citrix.com      Citrix
 crudebyte.com   Crudebyte
diff --git a/meson b/meson
index 3a9b285a55..12f9f04ba0 160000
--- a/meson
+++ b/meson
@@ -1 +1 @@
-Subproject commit 3a9b285a55b91b53b2acda987192274352ecb5be
+Subproject commit 12f9f04ba0decfda425dbbf9a501084c153a2d18
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 95ac4fa634..12af36de07 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4356,7 +4356,8 @@
             '*read-only': 'bool',
             '*auto-read-only': 'bool',
             '*force-share': 'bool',
-            '*detect-zeroes': 'BlockdevDetectZeroesOptions' },
+            '*detect-zeroes': 'BlockdevDetectZeroesOptions',
+            '*media':'str'},
   'discriminator': 'driver',
   'data': {
       'blkdebug':   'BlockdevOptionsBlkdebug',
diff --git a/roms/SLOF b/roms/SLOF
index 6b6c16b4b4..5b4c5acdcd 160000
--- a/roms/SLOF
+++ b/roms/SLOF
@@ -1 +1 @@
-Subproject commit 6b6c16b4b40763507cf1f518096f3c3883c5cf2d
+Subproject commit 5b4c5acdcd552a4e1796aeca6bb700f6cbb0282d
diff --git a/roms/opensbi b/roms/opensbi
index 4489876e93..48f91ee9c9 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit 4489876e933d8ba0d8bc6c64bae71e295d45faac
+Subproject commit 48f91ee9c960f048c4a7d1da4447d31e04931e38
diff --git a/roms/qboot b/roms/qboot
index 8ca302e86d..a5300c4949 160000
--- a/roms/qboot
+++ b/roms/qboot
@@ -1 +1 @@
-Subproject commit 8ca302e86d685fa05b16e2b208888243da319941
+Subproject commit a5300c4949b8d4de2d34bedfaed66793f48ec948
diff --git a/roms/seabios b/roms/seabios
index 3208b098f5..d239552ce7 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit 3208b098f51a9ef96d0dfa71d5ec3a3eaec88f0a
+Subproject commit d239552ce7220e448ae81f41515138f7b9e3c4db
diff --git a/roms/seabios-hppa b/roms/seabios-hppa
index 458626c4c6..bf3404006f 160000
--- a/roms/seabios-hppa
+++ b/roms/seabios-hppa
@@ -1 +1 @@
-Subproject commit 458626c4c6441045c0612f24313c7cf1f95e71c6
+Subproject commit bf3404006fd2c832857eb57e6f853862f97dacea
diff --git a/roms/skiboot b/roms/skiboot
index 24a7eb3596..820d43c0a7 160000
--- a/roms/skiboot
+++ b/roms/skiboot
@@ -1 +1 @@
-Subproject commit 24a7eb35966d93455520bc2debdd7954314b638b
+Subproject commit 820d43c0a7751e75a8830561f35535dfffd522bd
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index e3eb28cf2e..f83b916d5e 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit e3eb28cf2e17fbcf7fe7e19505ee432b8ec5bbb5
+Subproject commit f83b916d5efa4bd33fbf4b7ea41bf6d535cc63fb
-- 
2.31.1




