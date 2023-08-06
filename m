Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8BB7714A2
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:00:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQi-0001aa-Rn; Sun, 06 Aug 2023 08:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQc-0001Zv-C6
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:10 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQW-0005cF-Sp
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323202; x=1691928002; i=deller@gmx.de;
 bh=e7nRBaVId/NKKdFKNPTa2RSz+uD+L1T38x0l/JeC4YY=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=FudQl/RE4r+asurcsxtnh6b4M+wUe1rgfL0HG9A/UIr6NiAkewKHo8zMT7CM6rZNbgRXqHO
 I3PEfz3lhROcWi/RKkAMZ+PzQqYhewziCvrDGrX6mVTphekAUr+ebRfhi1KxcNpBYQQen8iTB
 29l1zyuGF0SjCBmWn2Oiq3E5/l212ML7I1IZp6Xg/Afgz0wg/z1UiXtqm5IfEe1oRIsETAU9Y
 /26pPCMqoL4EAO3sm/Le7r8JmfZ74Lg1RScHZlVLOS5Df/ztxhJxQodw4y/b8M6OFjc7OQTN6
 oxkWRqQikRjlAW0i8buQzJWCi1lMzh7fir5K6SeM+7KOVcun6kQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsQ4-1qbS8A3D4C-008rPv; Sun, 06
 Aug 2023 14:00:02 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 04/23] target/alpha: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:42 +0200
Message-ID: <20230806120001.89130-5-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bBOxNb0jtamCCfrINlD3s1STcvHNvs889pAlcgL8L3Uap63BPgl
 onQtHOom1XnNHkOeRbgZmNYs9XL2mBPusOm/8ctJpVP7/1A9J8DwnjzIArY+UVa12lcbDvs
 AKWqfzMz4XQzoBksw2WszEvxfiocq54PDtlAFYwiiXQqGX0ueeqFcwx3xeRxjJEz7iCXK5U
 wiM0/FDCMDwyVw7lwg1zA==
UI-OutboundReport: notjunk:1;M01:P0:oI2PRCNWiZQ=;Ax2/SrbLLe9ddBN2cP/LMFnalHe
 HRMJAEvpqDiH7m07FaoSHQEcmRuNdjJYrioAdJ4+aWhtq6iFL2RDHaB+CGMmeIyIJHq8LRbAG
 vV8/MJ4q12OmUaOYqKhr5ZFuSLtaxkHJM9Dz5imhTfAPIl0P8LaMOrOj+4Qk3/mwgXwC08I4a
 pHhDioL8JVUwj7kl/eRD7HRKW4L7Duef8yQjmlXWeLYQ7Na+vEmWUk8wqU8+acantCnDvs6lS
 Ws6Oa2Ro24jxaGklKMurNmVkje6+atPKA2k4/FPjZI3GZ4L4xp4xxO7hiFt0035pdzE7xwKj4
 d8q9G6VrFwIOw5v5xg/KXz38WlZIRWXhotpGXgJ8Zor6kbwousfH24plCviTe5tSBvNLOu9Vx
 c44S6mDFx6wevQ9M4hw3KWczHlZXuJjNaHAdwQFMQvW8C2KMm+3xzEw1fuQ+/joId30PO3ZWG
 1Ae82KuVaiPrd/Osbd7mSaKmcyNHLE+b8xlSRjbnDaoGtqp9cbbCSRFoSDtH0cGoxXpEBuLHB
 MmwR4n8+WEKGnsfixTHol2JM1EQM61OQFqxgmeR30lXNxnqNxJXwtPfF9CbyPG0pq6pEROg6C
 cyFJHF+Cflk6gRHmc01fsEzmvwP0Bk6MdiCyAFNrQxDVHItVJHDDUyNDL20MyAEhcbGdV/PFK
 OH8m7pV0o6G18xfhCqUFQuNduDAjZGdSXpmVhcVW3Cus3PwTfmLvxabTUoyyKkkBU5hNJWwgE
 uG3mhQNFyfxJfxTrnJDSgubmBKlCD/VdJALUax5cZ1btmLZOazR/En3p/itR2547xDG5Lj4Xe
 aI2DYq5KmjM/+0EGAFi8Pw0C1Uuv2Ip7hgQEzi89DqOPvpP8647e8WVmD2NI0ankPVKirRP39
 GvolnWjj6PZrXULqihMNAD6wXncdEk//1cZCWpWRpko666WxM8vMdVT+qfHsO3EF06L1Eo+Eu
 UpnNvA==
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


