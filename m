Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BD170E134
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:58:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UNk-0005f2-9a; Tue, 23 May 2023 11:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q1UNd-0005cS-9V; Tue, 23 May 2023 11:56:57 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q1UNb-0000YF-6L; Tue, 23 May 2023 11:56:56 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 76A6E260BC6;
 Tue, 23 May 2023 17:56:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xqiAijcehyI1; Tue, 23 May 2023 17:56:50 +0200 (CEST)
Received: from applejack.lan (83.21.125.167.ipv4.supernova.orange.pl
 [83.21.125.167])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 07777260B85;
 Tue, 23 May 2023 17:56:49 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH 2/2] docs: sbsa: document platform version changes
Date: Tue, 23 May 2023 17:56:44 +0200
Message-Id: <20230523155644.678524-2-marcin.juszkiewicz@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523155644.678524-1-marcin.juszkiewicz@linaro.org>
References: <CAFEAcA9GamGybSzd8FKBtmZ2qMgjRFy6D=Vhu1y0dL8m9Sa80w@mail.gmail.com>
 <20230523155644.678524-1-marcin.juszkiewicz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=no autolearn_force=no
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

We plan to start using sbsa-ref platform version fields
in DT so firmware does not have to use hardcoded values.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 docs/system/arm/sbsa.rst | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
index fea4992df2..fb17744e95 100644
--- a/docs/system/arm/sbsa.rst
+++ b/docs/system/arm/sbsa.rst
@@ -6,16 +6,35 @@ any real hardware the ``sbsa-ref`` board intends to look like real
 hardware. The `Server Base System Architecture
 <https://developer.arm.com/documentation/den0029/latest>`_ defines a
 minimum base line of hardware support and importantly how the firmware
-reports that to any operating system. It is a static system that
-reports a very minimal DT to the firmware for non-discoverable
-information about components affected by the qemu command line (i.e.
-cpus and memory). As a result it must have a firmware specifically
-built to expect a certain hardware layout (as you would in a real
-machine).
+reports that to any operating system.
 
 It is intended to be a machine for developing firmware and testing
 standards compliance with operating systems.
 
+Platform versions
+"""""""""""""""""
+
+QEMU 7.1 brought support for "platform version major/minor" fields in
+DeviceTree.
+
+Version 0.0
+'''''''''''
+
+It is a static system that reports a very minimal DT to the firmware for
+non-discoverable information about components affected by the qemu
+command line (i.e. cpus and memory). As a result it must have a firmware
+specifically built to expect a certain hardware layout (as you would in
+a real machine).
+
+Version 0.1
+'''''''''''
+
+Additional data are provided in DT to the firmware:
+  - address and size of GIC Distributor
+  - address and size of GIC Redistributor
+
+Simple "/intc/reg" field is used.
+
 Supported devices
 """""""""""""""""
 
-- 
2.40.1


