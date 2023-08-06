Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D73977714F3
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:20:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchs-0000Lq-Jg; Sun, 06 Aug 2023 08:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchZ-0000Fl-DX
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:41 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchU-0001nO-7m
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324254; x=1691929054; i=deller@gmx.de;
 bh=ssg8jQPKMpMEyj4XWfdcML4VNlGF+SIF4/0Fv2zswF4=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=NkmVIN0j1vZ3pODkOBrdWQHLWGoRRWzprEjjBrC1XPpfo5hIVIiob21J5/OTTvOYH1GT5x4
 zP70QBcMS3wFZDEJLZS+GM9sfgGvuQqrzeQaKI2u4inRYVjLnIALTSV0P8xaYJvm/KUAE0Yyv
 t0hDucD6hB9HsZNPITY6hHqT4J2vy7WuFxPAEsXfErBkA6em+qeyUxxWqyfy5aQ3R76Dtwv8c
 4L+LK2Bb+LKq6rffqTGdALfX4wZzoPqQL7wn5xv4HaKXkZEG1kdFpIXsoADpr463dYiP9N68e
 9EWvRrU8kT0pudyzYhC7e2SKu913oa3jGNASAaDtHSN2OnDlgPGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE27-1q83Xh23Lv-00KdKt; Sun, 06
 Aug 2023 14:17:34 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 15/23] target/cris: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:24 +0200
Message-ID: <20230806121732.91853-16-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UPG9aiWFLYOpxhFVYmJk74qmEZhTDDfCleSoPldJOiybhk1XsbK
 Wcf7Yz/NveXkaSWfUxc8LyOhQt7tEEAdEyxQIHTFX5XAl+WG/JM/hfupJPENUgruxLM24Js
 6nSlZ/X8oUXtw8vQiBZeeaeQbTc+zTFDJQtKFtAtkyBfTdgNhjdgBThPfVQc1IehPmuguQG
 5X5hNU6O9qXEsmkHDvRhQ==
UI-OutboundReport: notjunk:1;M01:P0:q4+mXxAjM+4=;Rzui0Kd/AvZ9Xg97JcfbL6p2CTQ
 7opTQdq2nOxKW2/RqDp/L5UYIuBWkz4ELGBvJf/t2X97vUtdebZCAZgHTwlyyfo2BPIqjHPzK
 JVVIHova8CbqNF3F6uS49z1a/p9Mlf0D3deiHOhOJXXOCzYFlOFVnjqMOv3AtcNBHL+/i6LRn
 6HqFTPsTSDwGzkVgcKlZd95pUzzPo+45dwqfMEoe4lF/63t6mCZ/ykF/9asm3U1JNFSjzRd6g
 dbwoozN74ABExQ9Pov6stdkupLpDCjxGwGk9lkOXJKmEUWCaj88tLZzho+CRMB6p+cGFbhfb4
 L4iE5vl35E/aOFAgnZgP/DoGZIhTWETKDFJr+Z2wFFSn2XyWGtnWapF8I5kKEgCHKeIaQtbvT
 v/eqss1WyrZ94dbOsKWu3/MqjiEB4w+pHmlPuSRuBsyRNdAEq3R72PvIJBpp2c9HOKntAB14y
 gYs/IJ7yPnwvHoRA+1pxtRhjgA5dNF3mvGdnKlkXrGcGSvhd2Mo2ZTjiiPOeeBAzZmTfepUlP
 xq74ATqJmkXB2WqaFNdF+U89Wl5/00cUj357S+SZH2lLDJ1MjO/2irKjxsAMSuu1OgAI89L5G
 8uKzmVD3sEP8ENc6vQ8xyviKxE0OVIOBwopRU/zlBmesAcLlgUniOyo0vVdf8LeEB3/je0lfC
 kGSZKuoI6Uhf3kc8fSjIHBFlg4LZgFAf64oHWCG4PDa+nM/0ZM/NmEZixtyZ6Y5a059lfTVT+
 0YhJZM7SK3FgLIshLfNXVeRIlzucL5LYkmfj6Eg94R1TR9DzWG/oTAVLxNWq12i1eRePCt0qf
 hPIGcEQyvNqZwLVobtR4GO4m3L+ni8bHVvnbZc+xDzMLCFvh44gAit9WPYn21U/aEM7DeurcT
 zK4XX5sWDKX9yuaQeRz1h/vcpcb+hhEQvEkj+G6rzf8+G/rHPxmv52/rWpGnATVQqWF9YkMI9
 Rhy9vtsuXlXRH0DObPbk+m1FC7U=
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
 target/cris/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 8e37c6e50d..4064a16564 100644
=2D-- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -248,10 +248,10 @@ enum {
 #define CPU_RESOLVING_TYPE TYPE_CRIS_CPU

 /* MMU modes definitions */
-#define MMU_USER_IDX 1
+#define MMU_USER_IDX MMU_INDEX(1)
 static inline int cpu_mmu_index (CPUCRISState *env, bool ifetch)
 {
-	return !!(env->pregs[PR_CCS] & U_FLAG);
+	return MMU_INDEX(!!(env->pregs[PR_CCS] & U_FLAG));
 }

 /* Support function regs.  */
=2D-
2.41.0


