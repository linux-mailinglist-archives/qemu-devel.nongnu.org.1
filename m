Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD59B8C9FA
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Sep 2025 16:04:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzyAf-0006T1-BJ; Sat, 20 Sep 2025 10:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyAG-0006Nh-OI
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:02:12 -0400
Received: from p-east3-cluster7-host5-snip4-9.eps.apple.com ([57.103.84.180]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyAF-0007rE-3G
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:02:12 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 0BDA0181708E; Sat, 20 Sep 2025 14:02:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=ZmarROfccVXE3MoqDaCGs6A/zz89R52aHcMDgziuwlw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XbUVz4bvnYK8BHXa7LjQa5l/3ZYevhiUthHlrxgA/mc+7y2zy+t+4d/5fhQG2MsnTOcaxp33jix9omRxRk5saJtQcQIO7oEPmJR0KeLmuAUCYU6Spk5jmhz3MlRMsa4tvj4gTlT2cq3DYax31TqUkkAOggZ4VOWUwkELX1zaiC2wbeRMIxMBgGofwn3zLy4uWA0oAlN6XC+VbI8sR4zJKjraKjq3nMTYkEe0t18lUYXjoQWQ1Va0+Hzq3vdZE+O/G9LOTC4Ou+k04NOLTVPYTQyZ069ggpNjcb7BsqB4dICsQud4hTEU2oUcui6FNKwlbWhqol44AtLpfR4peW8Jtg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 886DB18170AB; Sat, 20 Sep 2025 14:01:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 04/23] tests: data: update AArch64 ACPI tables
Date: Sat, 20 Sep 2025 16:01:05 +0200
Message-ID: <20250920140124.63046-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250920140124.63046-1-mohamed@unpredictable.fr>
References: <20250920140124.63046-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: djF-JSZCK828MqRTo6EAoXqSZirY_e9j
X-Proofpoint-ORIG-GUID: djF-JSZCK828MqRTo6EAoXqSZirY_e9j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDEzNiBTYWx0ZWRfX6/ioemKx+qSZ
 SUXlW6MYez2m87J3lr2XDcF+/nnneQPqLI5O/DwQYAgugDhVL/G+fRSUuS/EbpeYY+8VoWo+upy
 x67/xiuareZ1nhIwZ0pAN5V3zSW4/0XmgUNsHCQvOq98zH4fOuZRG1oeTRKvg9FW/frBrwCl01Y
 sAo+NqLvDPZc9k6bc6FwhLn6AhLvn2VR/pgWZrdqzXDSVlvlN3F46Eq4wwArBPrAxaBB1klpbg6
 0RrmR8mtTOCYTh3WXQ7vAT6TA93M8NVgxmpzoLBIUW23Cx28rQf0+kb+a4DhXYtfGB78Nw41g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_05,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=995 phishscore=0 malwarescore=0
 mlxscore=0 clxscore=1030
 adultscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509200136
X-JNJ: AAAAAAABci34xKK3lGTzxryQ8lO9fPG5/erK1+LboxL0XxPCzONyIe1Qnc8/ib3mNp/XklIWXo/U/GK/AKyodF5OGIItmoZllFRBYa/YKyWimYKYV9pi6jLEHh+bowOO90OmzmkuGlgygp3X0TMeA5tDWCi/8McBkAe2bkaxhyEuSBca+f1BULpxDXw9kNcyXtC3k+0PoQSHFLJ6n2XkcuiuPPkbO51zcpvzyvFTqB5lT26jVfIrBWYTfvB45JomKrBCP8MslBACSuB+a5PH/mWoB9A9PlF2t/9H5H72LksFz+sSzOaka1uJtQSjeEici8Boqnu+pEeMLC82AKcaSzG0LPViXY02ZLx8UGrEPGh0D1AuSR0aQmzK7DQwXxao+LVQMVtuc+cCqSdPmn0T+pSdR/60A2YjO8SmcVHk7f15W5owS3e1ldfLkt3NbUlnlzj3q+hhnksIgaAetpQT46JKdIScTnSPWq/mv/Gf63P8LSEY6j/26FXDsD7XwzsdgksljPyjzR2w4J2nJTvLpE9g2Dvl63U6A+w0gU5H3Pes2OmRji0V20XqT05HDjZR48B6g3q2VRf/SXPdg6qDPsEmbupFB2eiVG0m5P+eaOT5v/SqJnw5cRnHk/2NYI1WDGEFwwHYInrKPWtUirkz/K9IhsYYyce1qoFHRZNvBLtx/eqAoyWICQxm79euVVeLUVLlqGtMBgnKA+OWo67e2W+XHbdgRWMDSYlX6jjNHHGPYX33wbERWqWiOXH6HuxQGMZTZ2AN0PC7+xPUJlTuF+tMN+KwgSu9a+T4OYCy6J9Q4jM/li8dXwLoPvCNuM7L/MYu56zfpUh5TIXuRdVVo5zdM+pOqYKotxlhzTYQQI5eEL/sxfj8ZlJ0qZNzUD9n
Received-SPF: pass client-ip=57.103.84.180;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

After the previous commit introducing GICv3 + GICv2m configurations,
update the AArch64 ACPI tables.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 tests/data/acpi/aarch64/virt/APIC              | Bin 172 -> 148 bytes
 tests/data/acpi/aarch64/virt/APIC.acpihmatvirt | Bin 412 -> 388 bytes
 tests/data/acpi/aarch64/virt/APIC.its_off      | Bin 164 -> 188 bytes
 tests/data/acpi/aarch64/virt/APIC.topology     | Bin 732 -> 708 bytes
 4 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/APIC b/tests/data/acpi/aarch64/virt/APIC
index 179d274770a23209b949c90a929525e22368568b..f9b1f98ce7b7712b40bfbd87c355e009a84d97f8 100644
GIT binary patch
delta 18
ZcmZ3(IE9hRF~HM#3IhWJi~K~cE&wX|1V#V=

delta 43
qcmbQjxQ3C-F~HM#4FdxMi~B^bE(u-<AQKFjI6xF55IZmgFaQ9hI|W_<

diff --git a/tests/data/acpi/aarch64/virt/APIC.acpihmatvirt b/tests/data/acpi/aarch64/virt/APIC.acpihmatvirt
index 68200204c6f8f2706c9896dbbccc5ecbec130d26..67f9d26285623a7862eb4e3ed78f1d8652673a81 100644
GIT binary patch
delta 19
acmbQk+``P|7~tvL!pOkDlDv_tiV*-VVFYjh

delta 44
qcmZo+p2N)L7~ttVhmnDSrF$b+6{7^N1OpT>aex>=83qT200sc8{RM~s

diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/acpi/aarch64/virt/APIC.its_off
index 6130cb7d07103b326feb4dcd7034f85808bebadf..16a01a17c0af605daf64f3cd2de3572be9e60cab 100644
GIT binary patch
delta 43
qcmZ3&xQCI;F~HM#4+8@Oi@`*$SrWVwKqeS4aeydBAa-B~U;qHCpaq8j

delta 18
ZcmdnPxP+0*F~HM#2?GNI3&%vRSpY3v1aANU

diff --git a/tests/data/acpi/aarch64/virt/APIC.topology b/tests/data/acpi/aarch64/virt/APIC.topology
index 3a6ac525e7faeaec025fa6b3fc01dc67110e1296..f8593abc9002e21cad80af4320a7f74968fa724a 100644
GIT binary patch
delta 19
acmcb^dW4nBF~HOL2onPX%an~=yO;nwqy?t{

delta 44
qcmX@YdWV(EF~HOL4if_d%btx~yO<<+B^aQ9i37x71Y!q<00scqp9a4G

-- 
2.50.1 (Apple Git-155)


