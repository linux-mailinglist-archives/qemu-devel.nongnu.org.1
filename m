Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D41E490FC7A
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jun 2024 08:01:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKAqc-0004B3-05; Thu, 20 Jun 2024 02:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sKAqY-00046a-GK; Thu, 20 Jun 2024 02:00:36 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sKAqW-0004hK-OD; Thu, 20 Jun 2024 02:00:34 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id EE8AF2619AC;
 Thu, 20 Jun 2024 08:00:28 +0200 (CEST)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id coPoNOgnA0W0; Thu, 20 Jun 2024 08:00:27 +0200 (CEST)
Received: from applejack.lan (83.11.22.244.ipv4.supernova.orange.pl
 [83.11.22.244])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 34F132619F3;
 Thu, 20 Jun 2024 08:00:25 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH v2 2/2] tests/avocado: update firmware for sbsa-ref
Date: Thu, 20 Jun 2024 08:00:14 +0200
Message-ID: <20240620060014.605563-3-marcin.juszkiewicz@linaro.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240620060014.605563-1-marcin.juszkiewicz@linaro.org>
References: <20240620060014.605563-1-marcin.juszkiewicz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Update firmware to have graphics card memory fix from EDK2 commit
c1d1910be6e04a8b1a73090cf2881fb698947a6e:

    OvmfPkg/QemuVideoDxe: add feature PCD to remap framebuffer W/C

    Some platforms (such as SBSA-QEMU on recent builds of the emulator) only
    tolerate misaligned accesses to normal memory, and raise alignment
    faults on such accesses to device memory, which is the default for PCIe
    MMIO BARs.

    When emulating a PCIe graphics controller, the framebuffer is typically
    exposed via a MMIO BAR, while the disposition of the region is closer to
    memory (no side effects on reads or writes, except for the changing
    picture on the screen; direct random access to any pixel in the image).

    In order to permit the use of such controllers on platforms that only
    tolerate these types of accesses for normal memory, it is necessary to
    remap the memory. Use the DXE services to set the desired capabilities
    and attributes.

    Hide this behavior under a feature PCD so only platforms that really
    need it can enable it. (OVMF on x86 has no need for this)

With this fix enabled we can boot sbsa-ref with more than one cpu core.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 tests/avocado/machine_aarch64_sbsaref.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index 136b495096..e920bbf08c 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -37,18 +37,18 @@ def fetch_firmware(self):
 
         Used components:
 
-        - Trusted Firmware 2.11.0
-        - Tianocore EDK2 stable202405
-        - Tianocore EDK2-platforms commit 4bbd0ed
+        - Trusted Firmware         v2.11.0
+        - Tianocore EDK2           4d4f569924
+        - Tianocore EDK2-platforms 3f08401
 
         """
 
         # Secure BootRom (TF-A code)
         fs0_xz_url = (
             "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
-            "20240528-140808/edk2/SBSA_FLASH0.fd.xz"
+            "20240619-148232/edk2/SBSA_FLASH0.fd.xz"
         )
-        fs0_xz_hash = "fa6004900b67172914c908b78557fec4d36a5f784f4c3dd08f49adb75e1892a9"
+        fs0_xz_hash = "0c954842a590988f526984de22e21ae0ab9cb351a0c99a8a58e928f0c7359cf7"
         tar_xz_path = self.fetch_asset(fs0_xz_url, asset_hash=fs0_xz_hash,
                                       algorithm='sha256')
         archive.extract(tar_xz_path, self.workdir)
@@ -57,9 +57,9 @@ def fetch_firmware(self):
         # Non-secure rom (UEFI and EFI variables)
         fs1_xz_url = (
             "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
-            "20240528-140808/edk2/SBSA_FLASH1.fd.xz"
+            "20240619-148232/edk2/SBSA_FLASH1.fd.xz"
         )
-        fs1_xz_hash = "5f3747d4000bc416d9641e33ff4ac60c3cc8cb74ca51b6e932e58531c62eb6f7"
+        fs1_xz_hash = "c6ec39374c4d79bb9e9cdeeb6db44732d90bb4a334cec92002b3f4b9cac4b5ee"
         tar_xz_path = self.fetch_asset(fs1_xz_url, asset_hash=fs1_xz_hash,
                                       algorithm='sha256')
         archive.extract(tar_xz_path, self.workdir)
-- 
2.45.1


