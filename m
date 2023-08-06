Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EC67714E4
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:18:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchj-0000H4-N8; Sun, 06 Aug 2023 08:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchX-0000Dn-QI
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:39 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchT-0001mv-MD
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324253; x=1691929053; i=deller@gmx.de;
 bh=vztxPNZg2Ks81IufpA0WxudElm6LqGuL9zpQKXSpcK0=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=OwFHjgySUB6x6BeOw/lSOGf7RIe7xMOy/mBgPnSXPF59Hy0xW6wrx2hhZ8m+ls8trDlq30t
 q09zvDSi3LQnvadwcqPeOy6GuwM6GheekJ3EnwRNlj3la7ET+r6M6iokYG+yMuqgdIaE4UD9P
 776vVEUpjOOgkA4t1VOM29f5a3FVdXrZliR63HeR6m7A/yeqafw1yN0vuvcQD4x/zCXOrBwwW
 FGGXn1hzLg6q2IrXylOlkEiu5xRu7XUET1iZ+tlWXIaFzCJsPaBfswYNtsUbfUaRr6GWHGyi7
 /UhAG95R10+tNzEUKA7SqowcqSdjR9WxGMsJo6FUoUlvRySyDaLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp9Y-1qL1yT3Q0i-00YA8q; Sun, 06
 Aug 2023 14:17:33 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 08/23] target/mips: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:17 +0200
Message-ID: <20230806121732.91853-9-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lPjaWoH+jAMgQM9yut+T6+n3X0tXtcezWZ1E5ajh9mkfUCFIfdL
 KN2g+yCfy+DGrl9Q+L/urwvHhvqDooec7AMjHP6zpevGr3FShy4OnJB6isRvME9xj7Kyy5X
 KG7i5mQCl9KGxZyFYBuJlq1cVyOpqYVOMWELAo4e165vqiCATCW56Pi+1gT4CuQ35LxzSTX
 ouH7yQzsO3MKsKoBjcIgQ==
UI-OutboundReport: notjunk:1;M01:P0:Z/5YR9OrvK4=;LVqQnFcdtQ6ZLJ0/Va6v35KkweS
 bp3wzjy2vtx5UJA1ij+Eo2gmzJQ5eyJI4SOdyFe/q38iXLRESBzuAop3DaOMe8LMliSIZqkdk
 4gXDHFtE7YP2AtYEel4HgjardCG9BiPdjVLKnIsONgurN6LISJcYPU6+rOY7+ywG064zaOUUG
 jC/Ee6mMr4Pa+INqEtRkZyniYmMlb0F/46VqcuwzbvHSRubhjN/gsF860yKqtj2T09b0o3pID
 WKHqm0H+NEQxDmITBBIQmlUqiX+8opRmD3AAD8N9QT3YrAt0ap4KH8S6+oY/34zd9EGty+94/
 euj5N/3DaOOC7k6QKjZK308yZ3b0Rf7u/wSwJPQ8bT09XacGPdq6abc+U6u4eSItWvU8SnxUk
 WkXYfSKtI8UG5vPEq4dlX7F3pYsAlA841BQvyI0S3oK1UfKIWNxgAXbxygiSTPGrqGiumcfSD
 wAsRjoGf8S4VG/6gvixPyBpFLY29SG7/Mte8RYVKVFv42xLdgzQVNZLYZ0Qe7LqXnnja73nXY
 sHKPQ8CWd0onTj7Pgg2jdSEgsjf7PconXQoviQ7DoRkROJ0gdQNDnSRtBub/Un+xhDe0FwYEd
 wZw8vruZXc64/NHS2hpCNXMMRLumuuX52ToRMIMJUOThKca8U/ZWeigKJbj5fXaCKx6Jn1b3g
 y4n1fDZPKZxaycsJJpZMSCUDGONcxKcdq30tA2lzzsMIqJyB/z+lsUfcEYdtO0KSW0oCZvB2T
 X3Qf7NLe1NRJCfhpebiSVmNnqzDiYdXlK7kHE7f6pUOXUJx3wgAhxLpV14SRkfBz9JHKyhiRO
 e5lkaq5L3iuS37g9HSLRXKp8uFMWloub4Lb6ZPIXVo39Rfz64obJkkaiLBFCkPMZt1DbWuWOu
 Kn6V5rXrNTPgJcXe2MovjIM631hl8EJYWZe5FvO3ww43PDPsW6zf1fSe+7o1+8Ghu4OgKzJmB
 UTGhHN/nw9XeEIfMa4bw02tVsL0=
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
 target/mips/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index f81bd06f5e..4039d59f61 100644
=2D-- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1231,14 +1231,14 @@ extern uint32_t cpu_rddsp(uint32_t mask_num, CPUMI=
PSState *env);
  * MMU modes definitions. We carefully match the indices with our
  * hflags layout.
  */
-#define MMU_USER_IDX 2
+#define MMU_USER_IDX MMU_INDEX(2)

 static inline int hflags_mmu_index(uint32_t hflags)
 {
     if (hflags & MIPS_HFLAG_ERL) {
-        return 3; /* ERL */
+        return MMU_INDEX(3); /* ERL */
     } else {
-        return hflags & MIPS_HFLAG_KSU;
+        return MMU_INDEX(hflags & MIPS_HFLAG_KSU);
     }
 }

=2D-
2.41.0


