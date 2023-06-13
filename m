Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D757372E187
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:26:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90Ur-0005ew-Cn; Tue, 13 Jun 2023 05:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Up-0005eZ-SB
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:27 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Uj-0005df-SQ
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:27 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9745d99cfccso937839466b.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649159; x=1689241159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eupMI3Meu8cffWS+qjznZxnt/lkJ4Ptq7I5pw8yZlMY=;
 b=K2Vb46ASF7WJ45/pWoE+CvyqBsi3zplG7pR4R2HR8XgsS2gLwQatnABew+2l3dLof6
 Qt/X4cnfNlq0xpKVhZaADfy6XfTiEJLjguRDeMSHd4ztui73693xVi21mEiF3Uhqx0pR
 YRKirmzTgX1GertNwhFYaosB4qTLbxJMFTJPXwIi2uh5WlLKtfSZCVFc76KMjoCpqa2S
 v+JhWM0wZaHHZgyDBzGpIAtp3DRhGyqLzwxCm+CCsFuNSRyC3mcF1RbSmbExTOYscn9C
 2JwNAWJHHLB02mCN05ZqkoybJbblASlRNnOSmlA9etqxksl6DHDQvtNa/2+aO+d9AH67
 UGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649159; x=1689241159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eupMI3Meu8cffWS+qjznZxnt/lkJ4Ptq7I5pw8yZlMY=;
 b=ZIYvoKvIC6/lwYAafAbPzdwwIMbBhoaHsBptW53XNciBjsnxJP+ehI7PgAA1L0Of/9
 oS4kZY4/EygVbDoyWySnGGvMVhsw27es09AUXjmDHqOebL82aNXU2jb96FZuy8pUVoAu
 X682xcKVQLv778Gfsb3bmZaGYKSIiI/S2HYMEZOK8uHcMcLurTBZ72lULG+LDbP3O6Qp
 oxpw/4lw08Y0iZ5yB9b3fTi4czHeh+j92QKnC+PRJxCqH8R6qnPJVobctQfkR4MsgEG5
 /b2K7JGwUiaF8lp3IpJf/Gs2wHfd/SVBDQstLsHQK9AHo742kZ0sonvVWTa2Cf/iiaen
 BbUw==
X-Gm-Message-State: AC+VfDwzXMeYFvh0Vc6rQUulCUhpFC3y3XKmVFKP32BE8waCx0y2tfK7
 kSpYIcnQJfHqWTyVwjQnTuMO1tY//bGsDsMK+ejEHA==
X-Google-Smtp-Source: ACHHUZ6pm/AFHadErPXK5opeCQmLb9IdiBtBTVr4LWpI0tTohdISQqo3tdvQ2rkU3fpu+Ve672F1qQ==
X-Received: by 2002:a17:907:7da9:b0:973:93d6:189f with SMTP id
 oz41-20020a1709077da900b0097393d6189fmr14472263ejc.61.1686649159550; 
 Tue, 13 Jun 2023 02:39:19 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 m25-20020a1709062b9900b0096637a19dccsm6318257ejg.210.2023.06.13.02.39.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:39:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hannes Reinecke <hare@suse.de>
Subject: [PULL 12/17] hw/scsi/megasas: Silent GCC duplicated-cond warning
Date: Tue, 13 Jun 2023 11:38:17 +0200
Message-Id: <20230613093822.63750-13-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

GCC9 is confused when building with CFLAG -O3:

  hw/scsi/megasas.c: In function ‘megasas_scsi_realize’:
  hw/scsi/megasas.c:2387:26: error: duplicated ‘if’ condition [-Werror=duplicated-cond]
   2387 |     } else if (s->fw_sge >= 128 - MFI_PASS_FRAME_SIZE) {
  hw/scsi/megasas.c:2385:19: note: previously used here
   2385 |     if (s->fw_sge >= MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
  cc1: all warnings being treated as errors

When this device was introduced in commit e8f943c3bcc, the author
cared about modularity, using a definition for the firmware limit.

However if the firmware limit isn't changed (MEGASAS_MAX_SGE = 128),
the code ends doing the same check twice.

Per the maintainer [*]:

> The original code assumed that one could change MFI_PASS_FRAME_SIZE,
> but it turned out not to be possible as it's being hardcoded in the
> drivers themselves (even though the interface provides mechanisms to
> query it). So we can remove the duplicate lines.

Add the 'MEGASAS_MIN_SGE' definition for the '64' magic value,
slightly rewrite the condition check to simplify a bit the logic
and remove the unnecessary / duplicated check.

[*] https://lore.kernel.org/qemu-devel/e0029fc5-882f-1d63-15e3-1c3dbe9b6a2c@suse.de/

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Message-Id: <20230328210126.16282-1-philmd@linaro.org>
---
 hw/scsi/megasas.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 9cbbb16121..32c70c9e99 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -42,6 +42,7 @@
 #define MEGASAS_MAX_FRAMES 2048         /* Firmware limit at 65535 */
 #define MEGASAS_DEFAULT_FRAMES 1000     /* Windows requires this */
 #define MEGASAS_GEN2_DEFAULT_FRAMES 1008     /* Windows requires this */
+#define MEGASAS_MIN_SGE 64
 #define MEGASAS_MAX_SGE 128             /* Firmware limit */
 #define MEGASAS_DEFAULT_SGE 80
 #define MEGASAS_MAX_SECTORS 0xFFFF      /* No real limit */
@@ -2356,6 +2357,7 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
     MegasasState *s = MEGASAS(dev);
     MegasasBaseClass *b = MEGASAS_GET_CLASS(s);
     uint8_t *pci_conf;
+    uint32_t sge;
     int i, bar_type;
     Error *err = NULL;
     int ret;
@@ -2424,13 +2426,15 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
     if (!s->hba_serial) {
         s->hba_serial = g_strdup(MEGASAS_HBA_SERIAL);
     }
-    if (s->fw_sge >= MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
-        s->fw_sge = MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE;
-    } else if (s->fw_sge >= 128 - MFI_PASS_FRAME_SIZE) {
-        s->fw_sge = 128 - MFI_PASS_FRAME_SIZE;
-    } else {
-        s->fw_sge = 64 - MFI_PASS_FRAME_SIZE;
+
+    sge = s->fw_sge + MFI_PASS_FRAME_SIZE;
+    if (sge < MEGASAS_MIN_SGE) {
+        sge = MEGASAS_MIN_SGE;
+    } else if (sge >= MEGASAS_MAX_SGE) {
+        sge = MEGASAS_MAX_SGE;
     }
+    s->fw_sge = sge - MFI_PASS_FRAME_SIZE;
+
     if (s->fw_cmds > MEGASAS_MAX_FRAMES) {
         s->fw_cmds = MEGASAS_MAX_FRAMES;
     }
-- 
2.38.1


