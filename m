Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 108C67714F4
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:20:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScht-0000N1-MM; Sun, 06 Aug 2023 08:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScha-0000GT-FK
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:42 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchV-0001o0-33
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324255; x=1691929055; i=deller@gmx.de;
 bh=n/huR/PDfIZmE2vJlsMRDdZqS2ZoTWD5gTvGV/Fer4Q=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=qIxPTp3dnhmLzq81U7I2/VoLAB0DjL/zQDBlONyx0oWYER/QrwRTd+VteY5J0dwm0Y0sjQK
 VVM8u1DQ0Q+s/YlyBJ3phspsd89viKs4hgzY99FF+YAU9k/0TRi0tdLgN/IeJ6zWeNYSte6bz
 eRQjRqVwfs8qD/OH2cWmE3oXsXeZaPUFDwXKnGJjBZ5NPcqPqaVT/6FUkmqyaaTwcIS5htD50
 WN0Dwgsjbjqf5YY6lalMSP0oJs8i/n/s0WkfTUn3wg3IYSDZ3vNplqlFfrcz79UTlh7M3Oa+u
 AOR+Aukt7MRY1x88yKSxje6dMgHwrryZnUysaL9a95EZTlnfFf0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hzZ-1piexU0yOd-011ith; Sun, 06
 Aug 2023 14:17:35 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 20/23] target/rx: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:29 +0200
Message-ID: <20230806121732.91853-21-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:COSfa20NP1dtSuIOAPxncWi+KEEmauA6Gabq63z2eiwZGeskQhW
 uwQGGs3Nc6ssIB130zxb3rC6FIvTqT2XZDvvyMLRRv0lktI5nOjuvBDgdPjDXx2dcDtaITY
 BUWdSvONkth5kQWm929/xNixTBHFNlBNVG/hFzYtSVtihEfm7H7tlrbWVA7F3SAAMr/URIi
 o86RFwfSvvQmWM+dA11gA==
UI-OutboundReport: notjunk:1;M01:P0:8s6YZDn5zo0=;6kHfIY8QPaRaSjUV5Sc1BG3Lnay
 bm9OvnEf2ZLiEwkft2nTu6TbBr+ylvVi9X8MvmldDbERTNnPWCTkyCfR8Hv3BMR79d2rN2u7+
 Mv7lL5hRjMNAlbc3c7ZplV4UVJCt1wD+WZaG/UhHj6cRrAPiEF3AqCc0EgVI5t0UQMq/lo5Ar
 FJJNOVdVV72dlXWGkw3HcVQlV8Vko05pJV7g6EMu8Z5zfWRsTjSUs05RR8R20x2bvxaeuUuHK
 Or8sRcn0tw2oWWwZOQCLF+8dI4AKHoG4ywOHcA9AXSIxvlV4XGBlGksFBvN1geCLSUoOmRP9S
 C4zBeTzT0dPhwlI5sK4xI+70lHnX0QMtgGy9pcqSoZUkL072FUPRj8xLbfzaVLfgRiW4JbCFV
 iiyxYyZXGj8cbUKnJwnNNhcol6oQ7IxpSzhS6JqOOcVOAZL/ZNXzp1tXiA0kv7FjzUsxfLrx5
 qJyjwedBTeHQMbKQK5pmEJK2I4xSK/0ZGTjsRukVuY1KhN7levFsEbQlW5cxXSc0cnK8pAQF6
 c1fUP/M+ziylYrkOSzLrbEn9UzllZrw5NsB9/SbParLBKcs25zcLwyRNMEq6RZYuVwV5ONNrq
 IW9Yo3rXikHW/95qUKl9ncsU3RPKelNhiEaugnKrJeZ3CABCMIp0/oKdpq31oD/IWhrONALes
 ycWRUVf085AJV1EyQE5UExV+R/vy48rstwW2k5Lw20C3SWy1JyTQHMUL5akNQnOa0bHC+6u+b
 DkFuwHkw0tOn4A0OH7/IT6hiu+o8Wpzg8+j8nZpKZLKBbMov6jv0CI0mlcCGrLM30vM5I0fJN
 28i9IAUhs5Xkc0hFK0VACeI6b+9ulsN2eJxHNLDv4r+afoR6kiahghuiVVquE4AzfdszKr2c9
 yVS6dsjGF6auodFrdSLaQAuNVJDdt//oPGAc8f2RtBlz3+70W+gLzTeO4u+miVqV4UKL68qqW
 XHidsG67h/SRSqRuHuLkmewlkv8=
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
 target/rx/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 7f03ffcfed..bb19a456d3 100644
=2D-- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -154,7 +154,7 @@ static inline void cpu_get_tb_cpu_state(CPURXState *en=
v, vaddr *pc,

 static inline int cpu_mmu_index(CPURXState *env, bool ifetch)
 {
-    return 0;
+    return MMU_INDEX(0);
 }

 static inline uint32_t rx_cpu_pack_psw(CPURXState *env)
=2D-
2.41.0


