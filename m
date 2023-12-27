Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9BC81EFA5
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 16:08:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIVUl-0007cz-I3; Wed, 27 Dec 2023 10:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongyining1480@phytium.com.cn>)
 id 1rIShh-0002Ht-P0; Wed, 27 Dec 2023 07:08:06 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiongyining1480@phytium.com.cn>)
 id 1rIShe-0006Pf-Dr; Wed, 27 Dec 2023 07:08:05 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwA3LEOWE4xlxb1lAg--.19516S2;
 Wed, 27 Dec 2023 20:07:50 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDX+OWSE4xldrYAAA--.2783S4;
 Wed, 27 Dec 2023 20:07:47 +0800 (CST)
From: Xiong Yining <xiongyining1480@phytium.com.cn>
To: rad@semihalf.com, peter.maydell@linaro.org, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, chenbaozi@phytium.com.cn,
 xiongyining1480 <xiongyining1480@phytium.com.cn>
Subject: [PATCH 1/2] hw/arm/sbsa-ref:Enable CPU cluster on ARM sbsa machine
Date: Wed, 27 Dec 2023 12:07:21 +0000
Message-Id: <20231227120722.1683361-2-xiongyining1480@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227120722.1683361-1-xiongyining1480@phytium.com.cn>
References: <20231227120722.1683361-1-xiongyining1480@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDX+OWSE4xldrYAAA--.2783S4
X-CM-SenderInfo: x0lr0wp1lqx0bjrumio6sk53xlxphulrpou0/1tbiAQAGBmWLKugHewAAsR
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=xiongyinin
 g1480@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrZr1kXr4UKF15uw1fKF4UJwb_yoWftrc_Jw
 n7Zw43WF15KwnF9ryYya1SyryrKw4UGFsrKFn7uFyrJw1UKF1UG3Z8JrZ7Xr18ua13XFWS
 ya1UZFZxuwnxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=xiongyining1480@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 27 Dec 2023 10:06:52 -0500
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

From: xiongyining1480 <xiongyining1480@phytium.com.cn>

Enable the CPU cluster on ARM sbsa machine, so user can configure the
cluster hierarchy.

Signed-off-by: Xiong Yining <xiongyining1480@phytium.com.cn>
Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
---
 hw/arm/sbsa-ref.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f3c9704693..e6cd612bc5 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -911,6 +911,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "sbsa-ref.ram";
     mc->default_cpus = 4;
+    mc->smp_props.clusters_supported = true;
     mc->possible_cpu_arch_ids = sbsa_ref_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = sbsa_ref_cpu_index_to_props;
     mc->get_default_cpu_node_id = sbsa_ref_get_default_cpu_node_id;
-- 
2.34.1


