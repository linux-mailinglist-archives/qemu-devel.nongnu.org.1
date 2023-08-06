Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D397714A8
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:01:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQl-0001lN-NP; Sun, 06 Aug 2023 08:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQf-0001e5-3Z
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:16 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQY-0005bT-7e
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323203; x=1691928003; i=deller@gmx.de;
 bh=h9yd8rngpT0I0RPSFORtYiuKz7zcmMDvTe2DL8IxR4U=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=eeQkR9xIJ4jOy8BF+nAuOCZW+Y7khaP1ovj40ejecw008dPENUKOflxUR/NOMge8604+GoC
 lD7Err0i7BXu3QYC87m9fIJnuy4eWLxVW9Wjz3zSsEk/vUDSXe3Ul7PS4W+S98Se6tliCq/YD
 Z9V9Kbdbqzksgc0PHeufOgPpUK9t+xL7dD7aM1/psge5OpjngQZfdNw9XMvGozFBOtZwrGe45
 HOzmqw+UT82CPyOwIfUIX3mhJaldM6rlDceUW15q4pvt4PiVUcfP0y7txkcCFEPqAO8tPtFn4
 DOCzSCI+EIrhevTZUHyQXulnA3y2LEiTwj1MGdnd1538lgb/S/wQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6R1-1psSKP3dGV-00aBh2; Sun, 06
 Aug 2023 14:00:02 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 05/23] target/avr: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:43 +0200
Message-ID: <20230806120001.89130-6-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GPFZTzSIaUmWEzfXsgXPyKqjxBFQ6V25TNOe6h9KocnGHY87A5B
 TM33tdNDBz2T7rJCWCjgLO2MazKLPINVHZNv1dkEXwD6CkuupQ7K6OBoSDCFB3L0AcER1Eb
 O31HRG0385XNOJvMNilqTgFgHjuI7QKzdm5i8G9ZeK/O4OSsQiXEzWGu6hnxM8/EsiMd+cI
 2rY/+npXpPmRAdTCfkzDg==
UI-OutboundReport: notjunk:1;M01:P0:eSKX4sRfDGQ=;pWCOVB4ZruN4pl8nFBJqhrS8xkB
 zPg/aTfTQrE98CRwQ9YPZXIfubvSYjTwAoVmstqXptPYaq6rPXdqYgVeqFYjPNnoJCLiF9oac
 T4ykICJvhzjU74NRCmXxUu4WgBo0eoPF0xlg51fEktc92f8lJNJOhaHooB0PqjLZzfyT38eVZ
 4ZQ1OUCwgbC9q0IU/loeQPdjUfRClcdeVBrvY+1AKEN1fIahNtDEvgm7Lo8hkHxG87Uql2Zdw
 Yrap4hmcYOjNwtOzhYfeojiAbj66Maa2H+JcpUxLbK+dvpXKPA/zujAKOhwAs8u7epKxYnOWb
 FJuMFIuapWoTeLwl9kXO2ZedChe5oC3efeGXnwmCGx6xJrPT3XJQnKKDRzj217pkWP1f4T8N6
 fcMoco8zwzZ8UqhslwFaV3tobi+cDuYNhVB8QJ6woYsEDfXpTOm/mQ1KWuSpkA3OFliIdjo59
 LK3lbqEJQummGej2EjtuQR26roJP/QYdHZKBZAcswgndlHHo5g1Q+d+UquaBgAcVMZM6+FkPT
 S/ih22z+e80r8MiGxul1/aq1ytn5kYpvTomuA85Dxv1PCX+D6hwKe3/5kxEAC2rMXHcyOP3Vz
 CnteIWhLfdMIQRk6wy7CTKoyfaoteRdfpqGKE4+HbqIQmHLnImgzszRmXdqKo4VozhRq6bEBs
 5TPD6IIsXc27zAyXPKMlYRsfk5TVQijLn0Wq0oSKdiafxav6bIR868HtziwMR4IDrbTZBU5i6
 29faLpbzLhWl+frKiOhPny0ozC5pv4GOuaco7Zn5wBdeWhhGzjDQRfhaUdV90IIeO1ydkogg0
 W7c/uMHUBq6I7Y8yoEJk7l6Z1RxhzvlHyCIkPuVdFfvsJJBL0zk/0vV0yn/ckqABazDo/c6b7
 84CxXVnANLYXzHWQUKj/SMZsLCIof6034rIvEaes8uCPo3bWt1jhbjHpbvHIBaPGSPUqrbIy3
 rmqPNzT5n/wr3mOSxW4lstKwY2w=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Use the new MMU_INDEX() helper to specify the index of the CPUTLB which
should be used.  Additionally, in a follow-up patch this helper allows
then to optimize the tcg code generation.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 target/avr/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 7225174668..8b5916d243 100644
=2D-- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -40,8 +40,8 @@
  * ST/LD instructions access data space
  * LPM/SPM and instruction fetching access code memory space
  */
-#define MMU_CODE_IDX 0
-#define MMU_DATA_IDX 1
+#define MMU_CODE_IDX MMU_INDEX(0)
+#define MMU_DATA_IDX MMU_INDEX(1)

 #define EXCP_RESET 1
 #define EXCP_INT(n) (EXCP_RESET + (n) + 1)
=2D-
2.41.0


