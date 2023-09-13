Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D13679EA73
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 16:08:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgQW0-0004F4-Rr; Wed, 13 Sep 2023 10:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qgQVj-0004DE-LM; Wed, 13 Sep 2023 10:06:31 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qgQVe-00036b-Ge; Wed, 13 Sep 2023 10:06:31 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id E8211260B83;
 Wed, 13 Sep 2023 16:06:16 +0200 (CEST)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Pvd2mRImotoE; Wed, 13 Sep 2023 16:06:14 +0200 (CEST)
Received: from applejack.lan (83.21.94.247.ipv4.supernova.orange.pl
 [83.21.94.247])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id E63C126000D;
 Wed, 13 Sep 2023 16:06:13 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH 0/1] sbsa-ref: add non-secure EL2 virtual timer
Date: Wed, 13 Sep 2023 16:06:09 +0200
Message-ID: <20230913140610.214893-1-marcin.juszkiewicz@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

Armv8.1+ cpus have Virtual Host Extension (VHE) which added non-secure
EL2 virtual timer.

This change adds it to fullfil Arm BSA (Base System Architecture)
requirements.

From firmware side information about timer needs to be present in GTDT
acpi table. If it is there with suggested interrupt 28 then BSA ACS test
266 passes:

--------------------------------------------------------------
 226 : Check NS EL2-Virt timer PPI Assignment         START

       Received vir el2 interrupt
       B_PPI_02
                                       : Result:  PASS
         END
--------------------------------------------------------------

On Armv8.0 cpus this timer should not exist as there is no VHE.

I hope this code is correct. Tried to compare with other emulation
targets but only "virt" and "sbsa-ref" use cpu cores newer than v8.0
ones.

Marcin Juszkiewicz (1):
  sbsa-ref: add non-secure EL2 virtual timer

 hw/arm/sbsa-ref.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.41.0


