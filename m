Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CB982BEE0
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:06:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFLD-0005Zi-GZ; Fri, 12 Jan 2024 06:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFL9-0005YK-OH
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:43 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFL7-0008TM-E2
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:43 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-336746c7b6dso5301974f8f.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057476; x=1705662276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k81yQlX3wvc395BPHkrCFS01tpkFIigqHjpyjf7aVqM=;
 b=EfqfU5ZU/BFboi6sPHRq+8ux/a8ffcSsDL8MNfgIHbvbhlGTOHqttsjO/XcHivvNBa
 cSV+5AZTqxZ6GrGc6eMkuGFqKYvE0YkxkAsW6nnPcwJumBP/D8fBtynz46XfWuS/TFWM
 2c6RYjghmlY5D4Rd16d+CLtfyxBI576WHgNH9Orp9h++e4zeGRPJc8+4ibHZ+GR4C2BO
 RmV97hBkUf+1cOmYlvNpYX4QZOFFgC2v34a00i5cV6s9mi32OEFQdIJ3GSZ588ydpSlU
 r90qHU0TN3ub4c9bFV0qpW8NtlhzDmLOgAkvWugHzLTh+S1jjEYmGDbafTsfTepdBf6L
 gzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057476; x=1705662276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k81yQlX3wvc395BPHkrCFS01tpkFIigqHjpyjf7aVqM=;
 b=G0U7z1PK2jUubZTAGZEhbluPOjxdQTwUfV9w6Zq950TxRYDd7sbMD2EuU7do0HIHH3
 z1izfgVP81Oh1+PELv8hmUmLeSUtdidZVEV/RyxSKexaBzEs1WHcflvMV+mCLQUpbPmK
 H+8FZWpIgQHNVFCRnfkQy3Mp1QGboOEnxI2aVUVHuTTMQDiCtAirCqKEfjyOxX7nqm2H
 j9ZzrezkjfgRBZUdlOoueHj6vOcbXfWmXeM3LVFau7/hFuOdLhm7jG3xu39DdRwEhIKU
 k1M9cj8FzzAzEMNTi50XhPp2bWLcC6N5knahrmGP8LkW/NMly24A126favvLm5522dOe
 DXbQ==
X-Gm-Message-State: AOJu0YwbJDv6GFPoveavZDw8/2b3t8tldkdjKat2pwuLgjlPCahVapVR
 LhJSBOL9iCzQayTj4BnWVvqx9QUoUkM6sA==
X-Google-Smtp-Source: AGHT+IF4+8J1eJy59u4y7vDX6mfS4N50KPr1eRwO218VszZUaHoUYi0QgSVEoEa1LoGcsRXLCkRudA==
X-Received: by 2002:a5d:618d:0:b0:337:4a1d:8944 with SMTP id
 j13-20020a5d618d000000b003374a1d8944mr573029wru.70.1705057475806; 
 Fri, 12 Jan 2024 03:04:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d29-20020adfa35d000000b003375009accesm3550234wrb.50.2024.01.12.03.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:04:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 287C05F7A9;
 Fri, 12 Jan 2024 11:04:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 01/22] tests/avocado: Add a test for a little-endian microblaze
 machine
Date: Fri, 12 Jan 2024 11:04:14 +0000
Message-Id: <20240112110435.3801068-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


