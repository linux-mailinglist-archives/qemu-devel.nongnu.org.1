Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A86A67714EC
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:19:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchY-0000CZ-0j; Sun, 06 Aug 2023 08:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchV-0000Bp-FF
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:37 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchT-0001me-DK
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324253; x=1691929053; i=deller@gmx.de;
 bh=e7nRBaVId/NKKdFKNPTa2RSz+uD+L1T38x0l/JeC4YY=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=P7I7NCTwMzsKibyN2BceE4byryd2wcWXQ88hzDDkxyIktXA+9f4/sIHXweWOKX9hLUNYQPs
 wiJUdYray1VGmgXpDQEE2lLq7q4Kb6CaDb0qcl76rexPeN01QSU26S+Pqpm3XHrYvnXdn+P+h
 b7mfrzyL+ue0s51tXXNb2SMcBHbgQfP5H0kh/YsQHVV3f1u9C1WvLFdpZNS3UFOZa5Rpu0GU6
 ducnhS9rjVd9b1+Sy0SCZGGM7zxFDbOrDZPmq+tPcIgZ0NG5w9nEV4in5thA1N7dD7DoFnQgr
 8o7bmLJySMszgYqJGUitWNmHADS5UIh5J0TmcDel+qWnnVwuR9tA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwfac-1pdPkd1bcQ-00y71W; Sun, 06
 Aug 2023 14:17:33 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 04/23] target/alpha: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:13 +0200
Message-ID: <20230806121732.91853-5-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mg5amwIhV9g1wdDRzjUqt5Xn+2oxmxun5GQOyMIEQLyllVcwMXU
 bhj4QK71YjzItTN7I8fOkkdoOJjID2CVGUCSpEzaVltH8RoFH+awAeLKyKZk9fRn9iq8Rla
 PHPaSQRbLhTQtcgE0DWrJ6HlslkxYBnrE4WxoMImcmAvu+K5tOzCXGrN3H9fw8jbXE+MQbg
 yI+vU8etlRHNA4UWMPPzQ==
UI-OutboundReport: notjunk:1;M01:P0:9tXbL2/hUmM=;fcQxq16dFmk7RmNCJMtX0TtVcKY
 b3EAWiS/DYS0qXC+AbnkpYWJYQuhvMBTqKV0uF92dEhP75tGH4s1jM45XexjtPKR6XnZrDnTP
 Ckz1qrEwLKOf0Bcas2zpa92ajK84IklKgQPYgH+Jdyr8BH1E22HWTFE/VoFn1WwDrqj+jfMKM
 SRQk+1rDlzMucXK7QVaUreTmz6uhG88Z2N6rFYSyDNPYvxOSBlgEdYIKgeA/ZrAAMKJTko8y4
 9/xdvABC6+LqSjQcJgVJ4erFJTc4ewRVSv2yUKsfyKQVTQs2lcuScKTq3uTPt7lQdZj7D4L8Y
 hv7xiOvEt2dKY/qQldFp+j4y8uqUNrRoOR8JTfeZl0yS8Xj/AR9h7JMj+PndqjothN2HEjqym
 62J5+V+/rwkT9jx1NwdY5kN5XV2W5DiBoZMprPVU8pjEDbn84RNdEaBjjj3OWS2kJR2h6PDtZ
 y4z3AYpkidN4nyJeXLvJdjwjYG+CINyn7vMHrxjLgj6WD5V6OZveYM3EkihrZQ32tZsa8MSFa
 dcPbcURAAEqP8/Vgit7OvPke5mV9B8jswogGtD9iEc7zxn/oeUOd2PCgbQL7qVA8KmPw1P3OX
 /geC31vJyNvwLjRkf4ne2UeBkl6dZJez4ACYnoWt0zcnodurapDyO0NJ7LE0nqCNRw7Xwwxw4
 eW5Ei8tP5AFMg+phFF6UQDoP6oH4eWZBLoUhe7fzmYzRMiWf/8AGTjCQbqtzcdGEZwuP2EPf9
 jHdDLuEEW9RTeTyzMGi6MvTee7MGoYV0mR5ywwiX/Af9VqPleOnjuCsl5hS49TcM30txYFvKA
 FIX0teDZFcJ5IQNz467rH/SCbbFHOV3sXyCJK8cLFiQaPsiD+RRLUKfcYtLb2uMZJ332n3inl
 1q6tmR3jo4vblfyVd509jKu+elGlbeauL8vxUiXuCIA95TVjY1SP6lIPkU30lazGL3h8QVDGK
 1gNdmrH5J5hJ9s0roRxNcQgTmiE=
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
 target/alpha/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 13306665af..9bf80cdb35 100644
=2D-- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -194,9 +194,9 @@ enum {
    PALcode cheats and uses the KSEG mapping for its code+data rather than
    physical addresses.  */

-#define MMU_KERNEL_IDX   0
-#define MMU_USER_IDX     1
-#define MMU_PHYS_IDX     2
+#define MMU_KERNEL_IDX   MMU_INDEX(0)
+#define MMU_USER_IDX     MMU_INDEX(1)
+#define MMU_PHYS_IDX     MMU_INDEX(2)

 typedef struct CPUArchState {
     uint64_t ir[31];
=2D-
2.41.0


