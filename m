Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2440B7BCC97
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:25:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNCz-00089Y-Gj; Sun, 08 Oct 2023 02:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCx-00088g-W4
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:08 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCw-0007p8-AW
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:07 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N94qX-1rciY72iYR-0167ep; Sun, 08
 Oct 2023 08:24:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 18/20] q800: add ESCC alias at 0xc000
Date: Sun,  8 Oct 2023 08:23:47 +0200
Message-ID: <20231008062349.2733552-19-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vw+iz5BEXXobm8IH3FdHr+I+rMOfjc2Op2xLhAK5La5DmrIZelH
 weyZYpZbYNQzAs6IGfmkNjpFrf6MGYL3U0c97aLe87HQUebUSRwRUvCi1Pz8EDbYdTZSkwL
 LJXryU/f6eK4A2WJxRvn09JhDlVUc2pVr+oHakXGNXOQaKg3DWJd0+28JHPsx6LL9rNFrK8
 2Xr6OsdpBbLbBKhlU8Klg==
UI-OutboundReport: notjunk:1;M01:P0:+aUfgHWY+1A=;Ym33FCTJFlzpCLLvrX8K/Mf7slB
 jNoE7iWOkMCF+EYP9bWLAosmbFEOj+iJeK+ZyQ6F4Uv14FtdZygIbHvTupUNgMpjMur9V7OA4
 eqTQiRn4/I+EhSMVFiPthzBztzHvqhwxsURuLh09WTYSs+yWbX9I6nGByGQZfLX8OFNOBT5dR
 bglEnBN/bufwR4f7RggF1Rdy1DqiQqO6ZSk4OOtNIlcFFMxe9HdZ7an8JnB+Vfgx6suipsAB7
 QsNBzk2W1652zeJgLJdLs9UQqq2DywCrH0+jaDN/z5mp6OYNmUYCgsi1RwrRWvk/kf6lrjsTL
 8BXR9f1cY6vIE+Bbfx9eWXUzkIx/71NR+NzAAUec/R9sHJ7bsUuJxpCDCxJaMpIYw7mBO2XfL
 wuGD0FJNtsw2B0PH8Y6oYs8pJ0jRVGnnNmgL5LUcEnGSdJCmFEFTyBEzz3Ei8z8yMx33C0aAD
 Ef3zgYYWVZjkVRix1MtI18A7noKDVkOIDJue5ir+QZtI1+UaDDt45e23ECvNCjEoZPkeytnPd
 mMuRJUiXZbxLg0HsUwF1YVhoRvTXMiAixnYns7PkLAZg8TFYb2AlyznAqa4yex1V8DOimJQQm
 nT7otXXjs+HlT6VINwtpQ3weFD2esfr8vl55dKVdtdkCJhP49et21dOiz6WxOKTV8KfF3HAiv
 zKFUhpOv2FSpPqiAA2nYzpI2v8S47bYSQWvdE2ghuKXXHKpuYIDY4cxg/Se1+Qf4HOPsZ0GHH
 xt03ysYOYPcfsWv21srIYoRBEB6O8ryLI2zANuCwN8ZHXeV6GwB+PJf+JpKpYSqRsWxoeapZp
 SAKwk7LoEZ3s2XzWuLJ5r9tYEXpRGs4NXVGhnSMQT/FwQCaAGtmjD6LLeR4T96oem2eI0eJpz
 0pGi6D/wPO/+SXQ==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.376, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Tests on real Q800 hardware show that the ESCC is addressable at multiple locations
within the ESCC memory region - at least 0xc000, 0xc020 (as expected by the MacOS
toolbox ROM) and 0xc040.

All released NetBSD kernels before 10 use the 0xc000 address which causes a fatal
error when running the MacOS booter. Add a single memory region alias at 0xc000
to enable NetBSD kernels to start booting under QEMU.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231004083806.757242-19-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h | 1 +
 hw/m68k/q800.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index fbaacd88bd57..348eaf4703d0 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -67,6 +67,7 @@ struct Q800MachineState {
     MemoryRegion macio;
     MemoryRegion macio_alias;
     MemoryRegion machine_id;
+    MemoryRegion escc_alias;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ac3115d32844..27a0b3c08a98 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -451,6 +451,12 @@ static void q800_machine_init(MachineState *machine)
     memory_region_add_subregion(&m->macio, SCC_BASE - IO_BASE,
                                 sysbus_mmio_get_region(sysbus, 0));
 
+    /* Create alias for NetBSD */
+    memory_region_init_alias(&m->escc_alias, OBJECT(machine), "escc-alias",
+                             sysbus_mmio_get_region(sysbus, 0), 0, 0x8);
+    memory_region_add_subregion(&m->macio, SCC_BASE - IO_BASE - 0x20,
+                                &m->escc_alias);
+
     /* SCSI */
 
     object_initialize_child(OBJECT(machine), "esp", &m->esp,
-- 
2.41.0


