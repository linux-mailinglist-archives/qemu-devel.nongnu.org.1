Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02107BE4BE3
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Oct 2025 19:01:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RHw-0000og-7p; Thu, 16 Oct 2025 12:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RHp-0000lx-4R
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:09 -0400
Received: from p-east2-cluster3-host4-snip4-10.eps.apple.com ([57.103.77.171]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RHg-0001Yh-82
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:08 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 EC75D180076E; Thu, 16 Oct 2025 16:56:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=hPQ3K0b5QowzqJ6moa7Kn8eMt6874wlqxsFHGAQGuIo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=T3wbYzlANMH499iguv1V6EQLexIO4r8EPrXPY56Ljj3J3FF/yLi17qXrLXqK/jtdygYxDGwA2aMSRUMy4lj/otocMBGputBN+rTNrhVqlj9Q0JkjuMMN9JtzLfCxIV3r5X3YOghLIZiUvO/1v316w3y5jtoVu3qsrhXv7EX6/ih1L0w7cMqL1iU9cSbpIZTCkJdxvhZmES3d9dHMil/nTqokJsKtBtwWC/Wyya9iSfrDkerzKceCq3vvL3u6F+qhvhseRpGQy/yP7RoReuyC6tEFV21NgKRP4s6W+Jg5ahdzB9DPfUqZaBXok6+FUH7v13YdF0zhzirCbSCb/LJh9Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 7291318015C3; Thu, 16 Oct 2025 16:55:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v7 03/24] qtest: hw/arm: virt: skip ACPI test for ITS off
Date: Thu, 16 Oct 2025 18:54:59 +0200
Message-ID: <20251016165520.62532-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016165520.62532-1-mohamed@unpredictable.fr>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMiBTYWx0ZWRfX5SoMHJ5KySiR
 7tbhiHXaokgGogxYq8qi5y5Tat0qmuaf6NvWQ9mqCePYVI88DujsbpzbiUrK2RcF1zErCSmg2sA
 8EJQaMQ1V3XOVnMyxqUfrBWAqjttz5iXXqKPax5ak4MFPnHK2owwCWL0nCMpu6G1je/uYO8zY1W
 xgTkvxgZ0TZjg5PsCqCYE2ikfPv7WbVMOAiS1ru2FUknotfe+PC4otLREdd56EtLasZ/Q17yX2n
 As+AGizOMAvzytQxgoIHMdZSl5LZY2RSm8lOOR2qEUo+4q7r/RRDAk4VdsvW11kAyHCbULd+0=
X-Proofpoint-GUID: xU8fVLDo-Z0VEG1uLwGIG3k48I3tEAOl
X-Proofpoint-ORIG-GUID: xU8fVLDo-Z0VEG1uLwGIG3k48I3tEAOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=976
 mlxscore=0 spamscore=0 clxscore=1030 suspectscore=0
 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510160122
X-JNJ: AAAAAAABMBYzCKUSSHR/2AfLTYvAI73MYIQGYa8jxNNte8xv/Ws0smA27ZT0evdTGKMR34flVUf33BWno1JmF/bLB9QDKktnjulbknnFY/MA/g1Rg25o+n0/fCcWrWZiP32yTqFAIjdWY++sqQXAn6iZ9o3Rb0+CCtaCWJOd8aLNW3/n7QuTgKINtgSHhbHqhB3W0OmuvNHbR6GTq3h880iE7aYiD3IH5CtiskspJBwgJ74ClOCAmxLOaPVsaKtYfxI992G0Aq5ZlMNpznRLB/OGd2CrficOEjQ3TS6jT7YdP0HXNNWmV3kQk7P7QWRQgGIUS/7ol4iK1bU0t3x9T1Uchylnk98F5bc9V8Mbm/hz+8VqXfNPlqU3jRo5KlgAeAkglX6UVYFYHzc2ps9Vl9JSt13/dEsZDhRAsCSrjua0iAk6OwE4uhKLQpIsnVnhLZwvMB+kA/KUylGuV197pA8dpg14l8RhYog7iZU9OGDNfILfYz6sfgxb5v1/9lyyVwDb/zT1OFcXNQmpNX5fTwaXITrovJ0sIuj9ucjaUD3W+lm7tYG1Mq1iMGfvzIPxyinL9yLoKd0/PIFR2OwE15mxE37TEmp9Kf8D4pJBHAEcHHJn2KMGHMdU+xpObaMNJR2yN8G9PYmA/MuS5AQf9MRfxcVMlqzrxcexhGfpf+q0iMGRg510MiMIpM06h3ZujzXu5FibtOYbZp+9kZWJ2VRVDqYR3NA5b20gcXJBcVhlGBsMurF2Ff2ROXzlTX8tCo7yJNz6VyukQwcQrwwk1nU084bK9AfhwNrZIGN9eCcPhL9MIqLGxP7lxe7M4bzUqAevgfuFYgonyjGeObq9OVKX1oAR4PHEhZsr0v7ZbV8P/HOZlbupr6HkaP4mTUm9xry+oDFBSdZ1axpYZMOh7Du4
Received-SPF: pass client-ip=57.103.77.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..bfc4d60124 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/APIC.its_off",
-- 
2.50.1 (Apple Git-155)


