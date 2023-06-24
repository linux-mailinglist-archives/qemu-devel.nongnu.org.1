Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E7273CA9C
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 13:30:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD1Sm-00043R-R0; Sat, 24 Jun 2023 07:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qD1SG-0003sB-1y
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 07:29:25 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qD1SB-0001ro-P1
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 07:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687606156; x=1688210956; i=deller@gmx.de;
 bh=mmwc0+YeydBHhttdFF+mzdvUAK2itNPp02vAtTkY3c8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sqSxLZ7GumeLKKRmAcc2+zvBgtjoURyxIdMjkRFVzK4CXWROzYBlY85me+LqUVwCSlE+lIF
 3DXQuBy22SXqvHYLCujKJAApXXYbeFHzmjSk/e2vJHSvyqtheTou5UKPpjPdGI07pfbsCdlJ3
 k+n73hjO6CT73Mk/0I0bZJ1PvAEuruZ1Gi2kuhh2o9mLJ2x6561fk8ESLYK1L/f5ZAEpvLdj5
 ckiQUAlOuau9S8WHa2PGBbIy/KKYv3dcucWeGItCRcx3/JgAOUJwK/xe34rJ6tKnilZB7vaMy
 vDbvoH4mWEm6SOLcDBYmkHO+FD2Id462R9wRlT7b0fxiqpScdf6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.156.152]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KPq-1q3Uze1T62-010I6E; Sat, 24
 Jun 2023 13:29:16 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 2/3] target/hppa: Provide qemu version via fw_cfg to firmware
Date: Sat, 24 Jun 2023 13:29:14 +0200
Message-Id: <20230624112915.27033-3-deller@gmx.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230624112915.27033-1-deller@gmx.de>
References: <20230624112915.27033-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oziMcfP3VPeXOUFqVcUYMaqNl1PCekiE/nxmbrTDvqkIUkhJR1t
 rIGZt6blbf+9iSep0yEW0RuxfdtD9FC6kh3tK5R+jvphjX7ds706NSBk+eevALOfE5XTnjU
 dbVjv6S3b4tbIQi952E7ZtY+XE+7TqudFvA0gwKlMJOJgh3tm0DGeMLqPWg2quAXBLZxVZk
 T1pLQktUZzC57Q2bFNdEA==
UI-OutboundReport: notjunk:1;M01:P0:eQDdyYTXSOQ=;depJLbZPPXHE7CSRKkMPS/HER0N
 xZMKJx3FZ/MNCKp+VmH1cBTzJRnLskjsWd8gGfnwxQFZssRBz1C70lkJ99El87s3N8BFjOf5X
 nw6JcufhIq2kTRnJ0RFE9+RbvIoHj9E96jNtwYonq2Zpgq7WZiuN2Qjsopq5IVX3c85EwhXAq
 YMW1LTycMEOLcmAe2kXoaHQgNNDOM8GvFIZ0kaCc8QLK9Ao+8LLlzJ78hj5ZjX4pzau0gRlwz
 k1CreGHgYTKkrWeCRAWCWPenqPt8gvWUUnC7g4sl8a5cCkJDI/3g8c0dBmfvNMJMdsnkFDPLY
 pvoSqwhc9vG3PDtOCNiv4Zw1MvQuYVNMFYu3rZ1i4XRbpkIQQRcI1Xowk4zWqITfe2Plw54pp
 MAHpROi2W5vqJ99WXgjCdWhGH7dMeWFgl3MZPqOqYhwwmXpsbTV5abLJwu9Hbk9PG7r9za6Sq
 fDMqMXgqXM/xnPw2Z3zCmkLPJZvnETOgq1Eg/LR2FubzLaVM0ZcRdHUpguAeRnRZY+RNb1m1t
 gZrhgfmM3zmgxm98TyY/x9YRshf6aJNhG2gBsLh0PNe/faASBmIYe31F71yY9LEYw6Cm6NO7W
 4eGtGqM8yQXd9/7iWD8GdKIKAG6emlPoaNCA1x/hgqlFe0pIkIAAa6+zjiAA/cj5/j+2a/7Fe
 WANRz4zMLB+ZErRjL/F7G+jOChivBIHFCslg9Kk2ZwcDK86HJB8jBsZ5LKgT2pKc7QbFcKt3v
 UTzvdQ9uXlx1fWAx6AVALUbOFCOhcheFG1KCdJoucTM2cQF9gUgkJxIIfpFupCqkpdSdpDc6a
 FGvFnwcAw0e2h3ddY+VZZvzPRu+r6lxJhwa50YeNrA+tVkGPkeg1aFjibShs0eDyN6qtpsOXu
 vL2uGPodf9szvr3R3WrT45IaBbFbwlfx3cao1/c54cFrUwc5330tkJlqs7oKuQUuykL7jVRHr
 rLI9Qg==
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Give current QEMU version string to SeaBIOS-hppa via fw_cfg interface so
that the firmware can show the QEMU version in the boot menu info.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/machine.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 9facef7f14..866e11d208 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -122,6 +122,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
 {
     FWCfgState *fw_cfg;
     uint64_t val;
+    const char qemu_version[] =3D QEMU_VERSION;

     fw_cfg =3D fw_cfg_init_mem(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus);
@@ -147,6 +148,10 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ms->boot_config.order[0]);
     qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);

+    fw_cfg_add_file(fw_cfg, "/etc/qemu-version",
+                    g_memdup(qemu_version, sizeof(qemu_version)),
+                    sizeof(qemu_version));
+
     return fw_cfg;
 }

=2D-
2.38.1


