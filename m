Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F097281B3E8
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 11:41:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGGS0-0003sv-JK; Thu, 21 Dec 2023 05:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRo-0003jr-E8
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:37 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRd-0003q7-In
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:34 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3365424df34so471933f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 02:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703155100; x=1703759900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdsiaowAjsV2VhJV7X+uJO6SS3PjKGOvNs318qpxEnc=;
 b=smoqC5XBHIKRLdCzjk3C+N3c7Npc7lkVyPWKOvabPiCS7DrFTW9enRo7alMKR5yHGQ
 MEwSok6GxE0ShU2VqtOpNOBHrhyGB7d7O8chqqN7qxbAUuppL/udGWJXfdB+/WqZdTwh
 4e291lO2YA7o7fupbrfgmuPUsyTeI7wDXlSNhpG3tRh3jL1tdyqLrUy6TKnEnS3Is9mG
 rKOGRoZJHqRP+SNVjJL5jHySlcAdIZd5omdxsQwKaLcNsg46ahaJWL65DP5q5AS6PU4I
 lwNt+/axVQl0k5UhaeFhz7uzvR4lYsCqUlyIgB3rHwoacPCZ+k1uehnUGi5vqF3PEViy
 dYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703155100; x=1703759900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RdsiaowAjsV2VhJV7X+uJO6SS3PjKGOvNs318qpxEnc=;
 b=NvCfo6/x8X/q8tS4afoMj7c/b+xukmWTGDucPhkkNoGPgjsfgQ+g5Zvn0t8hXhQeY5
 4hBAEMVBHL14ufBhoF3N6BeJaVUBgnIpPZlEGHr+sOcMon4kJZdef+P3HXyb7SK69/mr
 sf+udMbicGj/B+YIoFEpHKHyKCbolZg1jhlh3OqqP9d68NRl1NLEbo6btnItaklXK4Cw
 H9GwCYmo/uGro/7pOJL+EStD8Qtvy0IS3QEg085es/uUsYaNxdrBLVH6xedVpHGPUx4v
 omTDvp2sOWmuPxS8cXCrALKwCqJpbBiV878aUZQPtbgwR5pe3Crt154BMKN8GfnzFDYf
 0IAg==
X-Gm-Message-State: AOJu0YyraJi+WdoIliH6GCiKoZQ66M1tZBoV8ewqI7JHu2du6R+r/v6A
 TqQ5P1lOUFay3xv7gT3PiYJwGg==
X-Google-Smtp-Source: AGHT+IGNQvXI1TaGTd5rITt67gBKkdTgtOk28s10TrQMNaMkVZnKYF8g1lcS1QVjmQIWgMwv/uml1w==
X-Received: by 2002:a05:600c:3108:b0:40c:29fb:2c4b with SMTP id
 g8-20020a05600c310800b0040c29fb2c4bmr624080wmo.148.1703155099929; 
 Thu, 21 Dec 2023 02:38:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c18-20020a05600c0a5200b0040c6d559490sm2887676wmq.3.2023.12.21.02.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 02:38:19 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0FE0E5F8AF;
 Thu, 21 Dec 2023 10:38:19 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Brian Cain <bcain@quicinc.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-s390x@nongnu.org,
 David Woodhouse <dwmw2@infradead.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Bin Meng <bin.meng@windriver.com>
Subject: [PATCH 01/40] tests/avocado: Add a test for a little-endian
 microblaze machine
Date: Thu, 21 Dec 2023 10:37:39 +0000
Message-Id: <20231221103818.1633766-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221103818.1633766-1-alex.bennee@linaro.org>
References: <20231221103818.1633766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We've already got a test for a big endian microblaze machine, but so
far we lack one for a little endian machine. Now that the QEMU advent
calendar featured such an image, we can test the little endian mode,
too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215161851.71508-1-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/avocado/machine_microblaze.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/avocado/machine_microblaze.py b/tests/avocado/machine_microblaze.py
index 8d0efff30d2..807709cd11e 100644
--- a/tests/avocado/machine_microblaze.py
+++ b/tests/avocado/machine_microblaze.py
@@ -5,6 +5,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
+import time
+from avocado_qemu import exec_command, exec_command_and_wait_for_pattern
 from avocado_qemu import QemuSystemTest
 from avocado_qemu import wait_for_console_pattern
 from avocado.utils import archive
@@ -33,3 +35,27 @@ def test_microblaze_s3adsp1800(self):
         # The kernel sometimes gets stuck after the "This architecture ..."
         # message, that's why we don't test for a later string here. This
         # needs some investigation by a microblaze wizard one day...
+
+    def test_microblazeel_s3adsp1800(self):
+        """
+        :avocado: tags=arch:microblazeel
+        :avocado: tags=machine:petalogix-s3adsp1800
+        """
+
+        self.require_netdev('user')
+        tar_url = ('http://www.qemu-advent-calendar.org/2023/download/'
+                   'day13.tar.gz')
+        tar_hash = '6623d5fff5f84cfa8f34e286f32eff6a26546f44'
+        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        archive.extract(file_path, self.workdir)
+        self.vm.set_console()
+        self.vm.add_args('-kernel', self.workdir + '/day13/xmaton.bin')
+        self.vm.add_args('-nic', 'user,tftp=' + self.workdir + '/day13/')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
+        time.sleep(0.1)
+        exec_command(self, 'root')
+        time.sleep(0.1)
+        exec_command_and_wait_for_pattern(self,
+                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
+                '821cd3cab8efd16ad6ee5acc3642a8ea')
-- 
2.39.2


