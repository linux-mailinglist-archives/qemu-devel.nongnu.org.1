Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F2D7714F1
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:20:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchs-0000LV-95; Sun, 06 Aug 2023 08:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchb-0000H1-8y
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:43 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchV-0001o8-8q
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324255; x=1691929055; i=deller@gmx.de;
 bh=woNxUkQ9IJtCMZI7LjFWB0Pz+7giVXBRlYTwrlmAgvI=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=OGOafRbrbqoiOdYdgJwvTLxvYpNyJYmChUlXLzmU2lqUurveraVTBWmgyfGfvLJpWQ1Od58
 m8usdjFptnzRijOxa2uj/Yk6psDOsm1qUM1ULS3y71G+x+HCuxQanE93hspn2qfdS6G6ODaP3
 8yhq7iEVbKLABkqsFDO+GDxPkkhI+PMbvsoVIsWRxHQ/RwQkYeWQyrSKM3zRCFXxBM3+zCWtQ
 NwyicuivV9DM7CAt9IEc5q2VCpH+aBQP3/viTIr9eUCHUHAIp87sUum714NPoWt+V4m0KrtQo
 q0AthFQgjk12sWmWzXGVrRAtl9KH0LO4EqZSWdvkPFWnGcISCt6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1qCkVB1tQw-00OkR6; Sun, 06
 Aug 2023 14:17:35 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 22/23] target/tricore: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:31 +0200
Message-ID: <20230806121732.91853-23-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qmua3fd5SjSlSaUe8qQmkAonWj2AT/+oDI3jy3OVM+VTMUnWwIs
 ZxS1KF8mqnYSQmbk/r5Ad9vEqZcB+1OxqdvgeWOf+Iu6N09rfgWW0vB4kwjJGg1gajWI3/z
 S/Rb7+wlOwqd74BX48UvPTAMIcTcKvRlE+FyDpwT/NqmoeRuQJxjyanxAxBkn55g+hUN0ZR
 IqCT//97Vg4e8BjIn9HCQ==
UI-OutboundReport: notjunk:1;M01:P0:30qOVr4YxkQ=;iX3VuXpsYKQ6On21dZUERGly3fz
 I45YUEBWJUudTtE1LtiaiaDKi5hH6DhBaPbbVPAf10gszroCEqhQW6s204h+Hs+K+1AVeKT1g
 lbaZ4WDxji9OQ3rekmm9ibZHafFQPpvKodGw3zAZpHHyGhzeRQRJs7i3fbVaNmO/0Nwsdb/Q5
 k99FUlDzl1CK2W2zV7WCzScuJz3Fq13yRSifrU1DbghaVF2oii1bIBFwEuPPvIte9Tg38fuax
 3/0I3g2+MBCNu4f6+U9u99mMDzza/ka75q23J35yucHXycGUs9eBW4p3YJR8ghuFUqe28pzFi
 sbbNGk7RX2cL9nxSCXDGdbVy7VjwUmV7Gf1Qb87OrXbKmey6ynqtquhH6Oq8Ej84NfDWPCLir
 0IQa5vXn3txm56+cEwVJo12p4tIHd+3XkCEmnMP4HhCm5jIf1eszfXwQ+Sd6Vmg79oe3WfH2E
 uMkwtU0mLuUO23hspIPpJGh9bGC9WS55bop8qKlXEIfQM0dEgmguYjpz8EldJQ7oPtxPsB+gs
 +64lPm/2+tYk3JOHPabqm6n1ukYJqNhc0EQ2OPfWEfjYxswSNWmszWM9Br3ysdAd+2+fILo3o
 OLRh352QgagzZd2X4UAAJJMHn9b0ORv7wpmj9Sh1jwEfwAOGXUWmnWoPnfXZ+Bqxhzbr/5aPe
 Men+SNigQOH30HwtbgrPQ44vf4gfWxiR6oWz6SGPxHvuB8BJiBp19KY5LYfd8anKTNHbnNdUp
 bFN9udxb8UCcpNl2WlD+Z5J0hZw2VU4C14FJL+VjkaCyGQmYzRUbuawh1P8MNW26XYf84h5WS
 XvEhz20/h8WKsQZ8tz2reUAp6c2w4NvIJ1nivblB+0vvo+kn0gPJ+GeAVoQNTYxXlCjf0i8b0
 fcKaw0nic7B2JZgHh3/bx50cuzDGySB2xNAlDf0FShwveaIzVJKBY6wUZyzp+Aa7kp1wHi/LT
 f/4JLwnHhm8z69YylJp/yLDhfXU=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
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
 target/tricore/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 3708405be8..6c8ba27737 100644
=2D-- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -366,7 +366,7 @@ int tricore_cpu_gdb_write_register(CPUState *cs, uint8=
_t *mem_buf, int n);

 void fpu_set_state(CPUTriCoreState *env);

-#define MMU_USER_IDX 2
+#define MMU_USER_IDX MMU_INDEX(2)

 void tricore_cpu_list(void);

@@ -374,7 +374,7 @@ void tricore_cpu_list(void);

 static inline int cpu_mmu_index(CPUTriCoreState *env, bool ifetch)
 {
-    return 0;
+    return MMU_INDEX(0);
 }

 #include "exec/cpu-all.h"
=2D-
2.41.0


