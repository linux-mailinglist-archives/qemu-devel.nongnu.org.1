Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BFE719362
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 08:39:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4bxS-0002ZD-5C; Thu, 01 Jun 2023 02:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1q4bxK-0002Ka-QD; Thu, 01 Jun 2023 02:38:43 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1q4bxD-0004g8-QL; Thu, 01 Jun 2023 02:38:39 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXYNbfPXhkisA8AQ--.47883S2;
 Thu, 01 Jun 2023 14:42:39 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
 by mail (Coremail) with SMTP id AQAAfwD3JV_iPHhkoIgAAA--.5009S3;
 Thu, 01 Jun 2023 14:38:27 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: rad@semihalf.com,
	peter.maydell@linaro.org
Cc: quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH v2 0/1] hw/arm/sbsa-ref: add XHCI controller on PCIe
Date: Thu,  1 Jun 2023 14:37:36 +0800
Message-Id: <20230601063737.464751-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3JV_iPHhkoIgAAA--.5009S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQARAWR3nCkBFgACsi
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Please review the change.
 - sbsa-ref: Add an XHCI on PCIe bus to provide an availiable
             usb controller.

Yuquan Wang (1):
  hw/arm/sbsa-ref: add XHCI controller on PCIe

 hw/arm/sbsa-ref.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.34.1


