Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 756247714AB
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:02:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQl-0001kR-DY; Sun, 06 Aug 2023 08:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQg-0001eL-HI
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:16 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQZ-0005dq-B8
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323204; x=1691928004; i=deller@gmx.de;
 bh=Oh0k3yvvWbtkEZ2WV4849UsfR6Tag1RdVubVNLc9CMY=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=mngojv5m9Nkv2Uv3waKumXEOBnPU0SS3k4+XwLt0TqaVRT51bfRjNz5xAp8Q5EA7xRIO82o
 YdtmAxH+fKlZruvS4azRv9WJPkTcE9IS/EDEQk90rzO02emfzctUQJ5Nq4QU9T2+c3zOSQdO1
 cb0cbTfdClw0d5/shbwS907qgcRua2s/tMmsvFK7dpsZDXqjnQI/lJQOzuMQosH91v0fIgKBi
 0lgVMSq57OKocRfIwDS2kemfaXKuyFKQIjxLPjVCyhDLqJmTEt4/BLuttWWd+WtQMKYIw06FQ
 9kjCw80xDy0TFUOD8by+ZyXT0TXP41ysa5Jc7Y+eEIyu1Qbi/ecQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC34X-1qXsAD1Jev-00CQic; Sun, 06
 Aug 2023 14:00:04 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 19/23] target/ppc: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:57 +0200
Message-ID: <20230806120001.89130-20-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WGlDk8V2Vl+GK3F9ymgQhMv7+T0+qT2ei4ZNiughiez+BCcAJdz
 2hpt24bQ488YbbI/zIRPflPlfr6yfOvWPbU+TDv3KqApFj1Z0kfc9S2/hA//eFYiXk/njF+
 5wIvHGVS/YLr8R3p9ksQDgtkHAUwfCP1o1Dbgh7CvTqCWQaS+ZemJTy0wuI2cKYlVqhk1Ph
 gQGEEOoIoO7i82BMsJ7oA==
UI-OutboundReport: notjunk:1;M01:P0:APCimso2qnU=;8YpGPdMe95HKUkogpC6kN4DEwqi
 Dqo6+fajRS43BBMu/kB/fUkpYdY2eC3D4KQ/aykFyZj7em4uzm9YjVW9GTA+RvuwZf0DinVDn
 SuKsF83IPg+OKazPn2FueBkUeHizy/ssb9THZeFoFx9jjD4PAAUEUNmMpqbBQfk6u3+b2NeVf
 dlEl4uzG6icKHCufn+vjhryteLQUuFyBFyPlp/h+Qd4sMXSJfU27dxnDjqOgqjlXwcJYHxESG
 b69yvUrfrrxROdy6rsoiVI2VIFUC9RS1Tn+1o8PwTqKgr79bZ5aUMXZuc6JS8jUkchD6MVc86
 4ninMbpKpDSf9tkJerdVkeiqsBbsHa4XD1HCrwiB0hqx9W3h1z1bCpLGsHVwWzNPS/PgCTsKG
 Vmd/mOrryBk2h2tLbKLBBhaILC6gXkPSz2Yt0skdU3FSe/OVLhGXK/S9WA7MDUx6ocmbPXGFu
 +8Sm41b1ygwS41ZfvzAlR2J8Q2o/zvwJvNX0wkwOWuWjHDDR6d976creQAx2QazEQLUeFsejQ
 OGB2mlzVk0+cQ7EDW6n3jAhKshidMI/VaONWnEUxvj+wktXWfXmy/Vns4KRE8TQOh7RgH8utJ
 yrnQ1NRqrxLZIU5W9aqDAV+fXGfB+47NCn/4uiVnRJ1W8+vhWC/chpZOF9fNS8ftNZ8stHjOu
 PmQCjLJ2EhUfYQsb3jO9q0MkHOOdhILW8OX6yFQtL7eTA4XVdGFyS+950JISzetJAIpQHZHa9
 vmfhwezhCA9GK/o4XAH7qtNe18ex3hDnGy+d+PH/H04C/CHPShEyMxODLyHY3UyBFd6t3qqMz
 fMiOxN3QTDOjRy0o9W8+4BiHWXPoes/EUceKPFnh0K5bpGGB4vjt4x/npoDfDTxOb7b5MfdSo
 p9WM2wvJEatcS95h7ca/+Bk+KFs01JXjiwmy2mHAmLksXUytLwsFCfMdn3uuciksr+m6zN6X0
 RXwaTw==
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Use the new MMU_INDEX() helper to specify the index of the CPUTLB which
should be used.  Additionally, in a follow-up patch this helper allows
then to optimize the tcg code generation.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 target/ppc/cpu.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 25fac9577a..dfd9ba2518 100644
=2D-- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1474,13 +1474,14 @@ int ppc_dcr_write(ppc_dcr_t *dcr_env, int dcrn, ui=
nt32_t val);
 #define cpu_list ppc_cpu_list

 /* MMU modes definitions */
-#define MMU_USER_IDX 0
+#define MMU_USER_IDX MMU_INDEX(0)
 static inline int cpu_mmu_index(CPUPPCState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
     return MMU_USER_IDX;
 #else
-    return (env->hflags >> (ifetch ? HFLAGS_IMMU_IDX : HFLAGS_DMMU_IDX)) =
& 7;
+    int idx =3D (env->hflags >> (ifetch ? HFLAGS_IMMU_IDX : HFLAGS_DMMU_I=
DX)) & 7;
+    return MMU_INDEX(idx);
 #endif
 }

=2D-
2.41.0


