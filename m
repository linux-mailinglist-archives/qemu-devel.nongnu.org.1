Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B54473989A
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFAk-00048S-3w; Thu, 22 Jun 2023 03:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAf-00040z-9T
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:01 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAY-0002rT-87
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:55:58 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MMX9b-1qU2lg0x5b-00JbmL; Thu, 22
 Jun 2023 09:55:47 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/24] q800: add missing space after parent object in GLUEState
Date: Thu, 22 Jun 2023 09:55:22 +0200
Message-Id: <20230622075544.210899-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XUjuaBJpzmtiWOzS+HYYjXv5V/I5TY1IZwv2Un+Rrw+llsRULLe
 45BLI8K8jAbVCq10Z7QEaoT8kYj5fV6hZJKwai2n0WJyDigO//deDKOy9+tecvs4gC0buSh
 uYUNveMfVDVeFuw5SHyqekE0OCK/ngLksKhRopAeH13cVFuvSAOoQ3jD31Fi4EjOLJuRa8L
 LV7JruZ1smYcsVI+EUYtg==
UI-OutboundReport: notjunk:1;M01:P0:PdGh3UCiYWg=;KnGCQLhF04VRVsUKIjN013NtsZ9
 Gth8+CfVFihhcpoFS14TPPAghuNgCh6maWljaUUrh3OQX++aQ0kC2rK8jLuXPRrTph4gm3cxu
 Aif5brm08HYG4O/g8lK7SPLdDcfdq77xMhzx383xD5zlfEsIO2F/U+KQ7DPIeSKc1lhBrMVLa
 8MKcuvK+KCTKlMvv9yO0BctZ5nExFDo5XZjExum2ZSzgtVf4j5Z2GCYi6O+fCZo5wqeSErS+X
 KRbnyuR4hvABH7DmY0eENKaB78Vu+cBE/838qt53rnodZ1IxZqfln7jOALS4dB/darEUs7FMh
 qTEndASGv7Sip86Fnc7SJRKkKysXuyWtGqMY4D6ZP4Amt6KA4cxIpAg/xGKZmjK5CkTGpWzDX
 H5fKHLaQK/g9B8CCWQO7SEZkcdwO+fesLiHDV/jS/Tl4iiwLpi9ww/9/GNzekTdgXio1TqSWo
 VarGuitkj6i3X1JNkt9Ct4VwrhKRfnp7h3TWC+0/dtK4qC6KtBFry9DIXF+2kfaCjlC50Dvw+
 vHHh0bdgDUAV/QU83xPLNLAFTgTPjYYQ0+m5PK0ffKS19poaFf9uvQOfNntnZjRQBxJB7Hbkh
 D6FmwElb529LfUtU0viWE+mXPGjN/zfkkBmi/URGK/aNAL0ziHttjoUjbsUt/4VNVYhXyr58Z
 LA3Vxq5Cv8FYIU/JWv0PBia/2V3ST7YlO/eqcfpXyA==
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This brings GLUEState in line with our current QOM guidelines.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230621085353.113233-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index dda57c60bfd9..465c510c186e 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -100,6 +100,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(GLUEState, GLUE)
 
 struct GLUEState {
     SysBusDevice parent_obj;
+
     M68kCPU *cpu;
     uint8_t ipr;
     uint8_t auxmode;
-- 
2.40.1


