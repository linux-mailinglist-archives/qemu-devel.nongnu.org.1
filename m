Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C66AD6B94
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Jun 2025 11:04:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPdql-0002Iu-GB; Thu, 12 Jun 2025 05:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uPdqi-0002I5-JV
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 05:03:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uPdqf-0000JM-4q
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 05:03:52 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Axx2nul0pogrcUAQ--.15934S3;
 Thu, 12 Jun 2025 17:03:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxzxvZl0poBIYXAQ--.19666S6;
 Thu, 12 Jun 2025 17:03:40 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v3 4/5] tests/acpi: Fill acpi table data for LoongArch
Date: Thu, 12 Jun 2025 17:03:20 +0800
Message-Id: <20250612090321.3416594-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250612090321.3416594-1-maobibo@loongson.cn>
References: <20250612090321.3416594-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzxvZl0poBIYXAQ--.19666S6
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

The acpi table data is filled for LoongArch virt machine with the
following command:
  tests/data/acpi/rebuild-expected-aml.sh

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 tests/data/acpi/loongarch64/virt/APIC          | Bin 0 -> 108 bytes
 tests/data/acpi/loongarch64/virt/APIC.topology | Bin 0 -> 153 bytes
 tests/data/acpi/loongarch64/virt/DSDT          | Bin 0 -> 4641 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp    | Bin 0 -> 5862 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem  | Bin 0 -> 4647 bytes
 tests/data/acpi/loongarch64/virt/DSDT.topology | Bin 0 -> 4943 bytes
 tests/data/acpi/loongarch64/virt/FACP          | Bin 0 -> 268 bytes
 tests/data/acpi/loongarch64/virt/MCFG          | Bin 0 -> 60 bytes
 tests/data/acpi/loongarch64/virt/PPTT          | Bin 0 -> 76 bytes
 tests/data/acpi/loongarch64/virt/PPTT.topology | Bin 0 -> 176 bytes
 tests/data/acpi/loongarch64/virt/SLIT.numamem  | Bin 0 -> 48 bytes
 tests/data/acpi/loongarch64/virt/SPCR          | Bin 0 -> 80 bytes
 tests/data/acpi/loongarch64/virt/SRAT          | Bin 0 -> 104 bytes
 tests/data/acpi/loongarch64/virt/SRAT.memhp    | Bin 0 -> 144 bytes
 tests/data/acpi/loongarch64/virt/SRAT.numamem  | Bin 0 -> 144 bytes
 tests/data/acpi/loongarch64/virt/SRAT.topology | Bin 0 -> 152 bytes
 16 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/data/acpi/loongarch64/virt/APIC.topology
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.memhp
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.numamem
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.topology
 create mode 100644 tests/data/acpi/loongarch64/virt/PPTT.topology
 create mode 100644 tests/data/acpi/loongarch64/virt/SLIT.numamem
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.memhp
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.numamem
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.topology

diff --git a/tests/data/acpi/loongarch64/virt/APIC b/tests/data/acpi/loongarch64/virt/APIC
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..3477789f422cad54f16734b3ec9ad1ff5135165d 100644
GIT binary patch
literal 108
zcmZ<^@N~{$U|?YU>g4b25v<@85#X!<1dKp25F12;0Eiakhw;E%5ne`ShX4P;(hQ=)
ZK)Db4AdUkN9{^%8L6C9*AO@2T3;;5a3;_TD

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/APIC.topology b/tests/data/acpi/loongarch64/virt/APIC.topology
new file mode 100644
index 0000000000000000000000000000000000000000..da0089d57f608aca230a76b67e72f9f0ad8e71f2
GIT binary patch
literal 153
zcmZ<^@N}NZz`(#5=H&0}5v<@85#X!<1dKp25F12;0Eiakhw)%s5FdttvP?iO2tyS!
r1DPNU;)?JxGBf=D4`cy>s4!6IgFcAq0K^A?SWFP4N&tw#qyqy0Q#cF(

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..f32e732b11a557ae01c7f383625d3b6f459ac9f7 100644
GIT binary patch
literal 4641
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
M8;N0Ag|`*<4+RY*Jpcdz

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.memhp b/tests/data/acpi/loongarch64/virt/DSDT.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..f19eae7d00f9c0eefc9e92de2c8a24863bf309d6
GIT binary patch
literal 5862
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
F@gG>(gG>Mb

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.numamem b/tests/data/acpi/loongarch64/virt/DSDT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..9b462869cd4911714e7c2a22025c465afa2a7d52
GIT binary patch
literal 4647
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
Q2sMrAMq*f2;hly318s{XJpcdz

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.topology b/tests/data/acpi/loongarch64/virt/DSDT.topology
new file mode 100644
index 0000000000000000000000000000000000000000..65111aa822663a907b83487cb496be38a4bdff05
GIT binary patch
literal 4943
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
O>qs*>>X-Po6Mq98?PEOv

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/FACP b/tests/data/acpi/loongarch64/virt/FACP
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..04d8d4c26fa2be24af40cd7a72959ec6b12790e5 100644
GIT binary patch
literal 268
zcmZ>BbPnKQWME+Ra`Jcf2v%^42yj*a0-z8Bhz+8t3Rnaf7&sUh<QVvX44@rUHJnJp
PfcDEk?FYF<7Rm+yEcXWi

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/MCFG b/tests/data/acpi/loongarch64/virt/MCFG
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..5f93b05abe1669fe4239edbba8aaf4fe666f5b95 100644
GIT binary patch
literal 60
rcmeZuc5}C3U|?XJ<K*w`5v<@85#X!<1dKp25F11z0R<?#9z+8GC8Y-e

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/PPTT b/tests/data/acpi/loongarch64/virt/PPTT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..7a1258ecf123555b24462c98ccbb76b4ac1d0c2b 100644
GIT binary patch
literal 76
zcmWFt2nq3FU|?Wc;pFe^5v<@85#X!<1dKp25F11@h%hjKX%HI*fMQ%gwhD|7qyeJ>
B2LS*8

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/PPTT.topology b/tests/data/acpi/loongarch64/virt/PPTT.topology
new file mode 100644
index 0000000000000000000000000000000000000000..d91e55b2399d9949dbb8e4c8cf634af1a0e56df4
GIT binary patch
literal 176
zcmWFt2npH1z`($y@8s|75v<@85#X!<1dKp25F11@h%hjKX%HI*fMOt^0-+!zP>c`A
cvcMq*Hv>s8vKUBj2@o^E^h3=9i7`XP0J3}u0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SLIT.numamem b/tests/data/acpi/loongarch64/virt/SLIT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..67f00813af7b2356fe74eed943ab8dcf2291578b
GIT binary patch
literal 48
scmWIc@eDCwU|?W;;pFe^5v<@85#X!<1dKp25F11@0Wk=0iHdRo0OYg>0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..3cc9bbcfb8051e632592d9db0fe3dba0af53ed8d 100644
GIT binary patch
literal 80
zcmWFza1IJ!U|?W6=;ZJ05v<@85#X!<1dKp25F12;fdT{L1I7pP5RMa&VrKx#G5-ew
Ih!}(f071qL0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SRAT b/tests/data/acpi/loongarch64/virt/SRAT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..ff234ce45cbdd32f57fc0668aba135992e5ca887 100644
GIT binary patch
literal 104
zcmWFzatz5}U|?We=j89~5v<@85#X!<1dKp25F12;FdPV=@)<SYGB5@QjDf5V0BFYt
A0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SRAT.memhp b/tests/data/acpi/loongarch64/virt/SRAT.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..525321890138de509ceaf9723f0a4565048e823f
GIT binary patch
literal 144
zcmWFzatxWkz`(%h<>c?|5v<@85#X!<1dKp25F12;FdPV=@)<SYGB5@QjDf5VNgYfc
LMl&$OGyrJ;Y8D3p

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SRAT.numamem b/tests/data/acpi/loongarch64/virt/SRAT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..2972a9abdcface5b943078d61b4946da80176ea2
GIT binary patch
literal 144
zcmWFzatxWkz`(#5?&R<65v<@85#X!<1dKp25F12;FdPV=@)<SYGB5@UjDf6=Q3K9{
J$-`(A^8s%|2LS*8

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SRAT.topology b/tests/data/acpi/loongarch64/virt/SRAT.topology
new file mode 100644
index 0000000000000000000000000000000000000000..4a44831f475b5fda1db9bed12c2e63a79d6d6e71
GIT binary patch
literal 152
zcmWFzatxWlz`(%h>g4b25v<@85#X!<1dKp25F12;FdPVA@EOtMnb7#m$b3c(xJfVu
J2aJKN4gjE82LS*8

literal 0
HcmV?d00001

-- 
2.39.3


