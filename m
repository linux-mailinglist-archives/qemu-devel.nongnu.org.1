Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7B87714E0
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:18:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchY-0000ED-RV; Sun, 06 Aug 2023 08:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchW-0000C5-LW
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:38 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchT-0001mc-Dx
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324253; x=1691929053; i=deller@gmx.de;
 bh=fHh6ths4U489TH2R2+SXZJdWcst+4HBAcj/Wpwd6H8w=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=Q/y/38X4ITl+kP+AC4gw1e4SDz3u3m18VnSvUda2Cm391UKAur62gALzNRIRjueyg0vsVau
 MH92I+gfw0+JOXsTtluMxFghqnjBpWpZ+8FfIUhyg3VF4i/B0j3/COVT2l7R+YwpS0K1VKIW0
 KsE9C7NMnJTTI+Mlpc3bX0bIZIH2uHA8KZUD0mYiAMq3gTe1lCflZfBpvbkvO78w3dqca9rJ6
 HV+VNLRwmgf86+ru3TCqGsTA1ghdt7bnfwcNfkE6YtbIJ/6A429w0Zbmgm4lkv5KhDXlfmaFx
 JpmNEwwxVpy0c0OR6nazuBQfM7FX3D/8ov/y2f4h+Cakpxsvkfnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1qYQ8E0sYN-00BwBn; Sun, 06
 Aug 2023 14:17:33 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 02/23] target/i386: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:11 +0200
Message-ID: <20230806121732.91853-3-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OhZ70I+rOx7h1Ufo5tMEc5FuTDzDhH2rVx67s7o+MfVRX3+Wwyt
 uE67yu0dYPgBEjXdk+ZdV9VUS2M0Bt+Gct2IZEFZedlhrJ+mcWE7gNpmbb9uig/xe/1OYu5
 +I5KY6WvM/FrB23LTZHMnPlVnxPDWXL98Ct73WRSlB0d7gSt0o/b2z4Cwarka0dJdk2ecu1
 PZzzXgXkWLAVYKPVOc4Xw==
UI-OutboundReport: notjunk:1;M01:P0:/BLc4OhQ5TU=;D2aSb3oe8hWOE48bO6rQU08JwAA
 1NUBiem4/qBwKDLOuV8LbBbnbTxnY51JUcTf4B5SDz2nM2RZ1LuW96c+RzpytEUyxFqIgnsrh
 iVkV/OkfkjTP6Lpih16gM6pjc+hmpHAQADIyKnpyk87Vesb/VfAtsYPTdjFKMbjZ6anYFGKzd
 V4JZ9YeSvO5f9fu25JhNdo9DvDltImzJAlK8dA5WQqkXJD7YVaJOubaESt+EzJUtv/ffsNXH2
 C0+DcOUSTERmfiJwu33fzuHNzVPGxi1lbQhYorMsGCLSnmeWk8PlslHmlYHuD4n8uBLZlH6HQ
 Oc+XQA9ZZgQ4vIzuDKOM9/tjg/lh4yuxQfFZVEChn5yOF8wsz6h+Fb0ym6RUCtCbX49TVTONc
 8sWsDdHLFLbQb26SSb4guWXFUR+322CDvWXQvdDVxAlYPxwEegYdlaZ1o7/vJdgqXUUWbw8xw
 87r8QYU40IbuZF2CCbgCPeRgDXF/+kQD2Xd3+ilXGWdeFpUZYlkzbRYEGH5BIswW+ZCzgcOjM
 U4J2sjaSU+IEMNFJ6ZeTJu++A5agKfaCgv19cqrWDvm6ihBy9V++sbJzx41G74EMQWS4sO7KH
 GfnezjSRN/I6mjtYX/vNeYw1eqPJdHffeDdBDDvYuPiI1Fl6ZzrhTRSLTPuRjTu+LvS1+0gRo
 Iw1fJ170M1glgHouge1I3YDATPMSfIrjSj0pMDy3fGFH5ZdKG+8JhOHxBfX2E8XfnpbN4nSPs
 QuDDBoxrCqGBU4gm5XWqbIq6JEyfcCfmT8l5a8LqPpDPCawjjYL+V6fnq6kQ2NuXTvRR1rgmM
 NZqg50X8jeTuqe4ZLLaw7a3MlAzQjPVblUGcR/h7ka5BKzXV04/RpRYnJMLUNg+pnbDAjOPNY
 WsKLvnoEh7E7r/IsmACWjc6FbcTZ+F0532trXEcPj1H8pFvN4GukGaiAuomyJW4GwE5dfcuss
 0gN7hfbCQM1jR5go2iUQDTQc8n0=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
 target/i386/cpu.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0771a1043..8fb1012346 100644
=2D-- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2251,11 +2251,11 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define cpu_list x86_cpu_list

 /* MMU modes definitions */
-#define MMU_KSMAP_IDX   0
-#define MMU_USER_IDX    1
-#define MMU_KNOSMAP_IDX 2
-#define MMU_NESTED_IDX  3
-#define MMU_PHYS_IDX    4
+#define MMU_KSMAP_IDX   MMU_INDEX(0)
+#define MMU_USER_IDX    MMU_INDEX(1)
+#define MMU_KNOSMAP_IDX MMU_INDEX(2)
+#define MMU_NESTED_IDX  MMU_INDEX(3)
+#define MMU_PHYS_IDX    MMU_INDEX(4)

 static inline int cpu_mmu_index(CPUX86State *env, bool ifetch)
 {
=2D-
2.41.0


