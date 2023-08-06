Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9917A7714A6
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:01:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQm-0001lh-Oh; Sun, 06 Aug 2023 08:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQg-0001eM-R3
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:16 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQZ-0005dm-9f
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323204; x=1691928004; i=deller@gmx.de;
 bh=AAhlFKdhCBg0rP4mi0eaKNbjFV2RubxTJe69zIRETsY=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=TBl9TO+aNjsa6htxDzlOSLeoHKgxmuzvt2GLYClistcfhwHvJ1g5XisJlM2bsa8MXGYKUtX
 G2Q8npeDEzz4HeTdieHxzlLJMvu3JFQ+gl8tieLX8RDGI14tmGl2rYBJzTXSWpeD30kweGXm0
 oVDtzLAb4Bd4PQaGeL/kvcnYiK8FXQ32GDpk7LsJm9P/7CzapXLcEz63q2BxqD9GMRO7w/dI3
 05U/Uc6sOFIa5IksM9uAqeKnPb+qtHS/eSKZ+dGhZPoM6P5oWz5fI8ZRxHbBpU4m0Nvk8RQg0
 swWO9OemtXXDUjHea5v7DAptT3G5xn21+nxEbTO1WATBcDRYieOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYux-1pYiWV0val-00u2vQ; Sun, 06
 Aug 2023 14:00:04 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 18/23] target/m68k: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:56 +0200
Message-ID: <20230806120001.89130-19-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IaRb577QcAhFb1FCi1kCy/K8OVeUGIPObwR4Cn3lWMn/M8XzHeU
 3PbGvjfbJEErTJlSkz29wQrmz6Hng9zp97hNYGMRn3ANpJqFbwGdz4hXnY2ONQ8VTqdoGVo
 lV3kVVvvgEWRITqWT4oHEsoXVfEZLo8dtKJC+72TfdthUKnpz16Bvblt6AG5LtpSCR8Ozqs
 psoxRCxYTGL6gXj3lJrZg==
UI-OutboundReport: notjunk:1;M01:P0:kvjfawt7yvE=;XHX9ly1NNUqO7eoeltL1lyWkppb
 JP5Z3nI9gDl0GE2VATqeEOYL0qt+uGzYTMv61ACujwWG3BMHqKTs9KFckeGBDgAJ9AutXSs3K
 d+9T4Olz4qSJbiKSwAUw70tMgBZeUE5Nm8oXBcOXtytLLMFDBL77BpSwUJjsy6IRJMld7IW3P
 YE0rmZuSIq/OodRV3+/L/wOQRMQjPn6n0kTOsNOEruAWBl2ht5kCDXhSLaBRCJ9C1bu9y424I
 OSGu44Rsrif5aKOaD7YyW5+xM+mkfu7aN5TgidFS8tIj0ki91tA8ONPVWyw546TLr/yo/KjYb
 WQLFqB1vrC7fYR+i4f2gS8m9k4RsyRQphFkg2h8eHD8aCzU04Q0KVbKZyMQVNEIcWSsSyvV2P
 gvPYQiOlyZqtRrSAeLL+WLdJiaG1waAUZSWTcR1hgIsUhPZJXRFzZ/+HCaK2QoLD9uCxiUDzR
 p3x5D1ihVFpo3WWinkHnx9RB6X0gCQdxMvwdRgCpcimyazjoF9a0Iv5YvAlJub9PB7EQAb+uS
 KxfGU56OxlJzmN21ziWl0G45qtScFDe0gKuXvXNyPozsaMknrGunFkkFT6R3Q7LZ0MFY4LdXx
 kiTvFNMc7+ytlsc+hVRZR7F2Mj448CBEmtobuk0e+oe8a2c6NXspLnwu+dKw0rcWg+mSjdCN7
 e6Mg7nmbbUKmWm7f5nVZtXWgYmxQDgB5RP2awuy3U064phpVONZQTBAe6Oc+v8ScUt5D2u+G0
 TgFfe/ko31MOF+Ub7P3zaP6VZUQHzaKv6+jYm7G/l6jnXXCT+3rJYX6PFyL/+7RdlQIKd7RUq
 SAcIeoQYcy+3dkl3dwPVH+7ZzRrPwiMAVwIxnh0IHi+tFWKZoJj+HVwNtYWaj0kD2e2cAMXvr
 9p8GscdUuZ6Xep70ksLB7isxg0IS9HZZEwb2LcV3Xr+PIsRFohEa3TTPFVLxCF06uTFr8tuTd
 RjLPJUsBz3WTv0eWB9+4W4YuRTE=
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
 target/nios2/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 477a3161fd..77f9e3803e 100644
=2D-- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -277,8 +277,8 @@ void do_nios2_semihosting(CPUNios2State *env);
 #define CPU_SAVE_VERSION 1

 /* MMU modes definitions */
-#define MMU_SUPERVISOR_IDX  0
-#define MMU_USER_IDX        1
+#define MMU_SUPERVISOR_IDX  MMU_INDEX(0)
+#define MMU_USER_IDX        MMU_INDEX(1)

 static inline int cpu_mmu_index(CPUNios2State *env, bool ifetch)
 {
=2D-
2.41.0


