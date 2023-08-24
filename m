Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAE6787455
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:34:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCKI-0001TM-4f; Thu, 24 Aug 2023 11:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCK0-0001Qd-PT
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:32:32 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCJw-0003RK-6i
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:32:32 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31c5327e5e8so682439f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692891146; x=1693495946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+p4+7OBfarchATd3tFruYfwM1HUum7CKIwxdMycnIKM=;
 b=rjEdiZuvlGmaAlCSjOgehf8AnR+PPGiHqtfxMBDODCEBuGswKVHLOipVpPHxJ1wQte
 8nvGZTRf3fBY/SNRthg3Ti2ktm0/dgqWA6rLHyAr+2txhydN2pVP7+Hit2i9SVVzb0PX
 g65Si9hmz8Amk6DgGynJHYx/lE6VsUuIQycW7z2F+gyR72uzHppZOkaD+EdwrVzrHzJt
 Jk9n5aI4iAvSqdR7XFdVWSEn+6Ijh/s9zVK/lvtyrkdK2qu/OCWskAervwodVofONOKk
 JUUR/iYW4PrPOcRMmTz97FRPxupRh7G/Z5k+Bo9reN0s6YdBQ+ntT+/Q7POu8WeHwl80
 7sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692891146; x=1693495946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+p4+7OBfarchATd3tFruYfwM1HUum7CKIwxdMycnIKM=;
 b=iaJSPwx/8R4DwEcFN3PkrmzzEHNChD6ZcHMVV605SERSgtiQRVS/LzrgBzhUY53bXd
 GM1cOtLBNqdCStDcKpapJNr9kMDkzgsE6zUmBxCRXJq7vBUsjHfVikfZ2n/HneRrU6/z
 0xqnj3vf4+8+HPWSjuoGroi9gCoI/tsZbix85vGeW8Er7Mlum1DsG4OCRC94jpkKMh+B
 i7vPe9aH/clnRw6CjbRoA+24rKrj893Vp6pkAQPgasg58N9tQH8dfUktBHfoszgxyxDS
 fbiK7uS0sLGf0Rg1ABqozdyBQFWEk2VG4NUGnND7e7fzcDapdgU/7D/gaDsw/cRaMMKb
 fPiA==
X-Gm-Message-State: AOJu0Yx5seNI6aiN7Pof1riv/HRWSK1Ta3Cdg1/6WssqdUxlnorITVJq
 nxFSnKkR/+Njq8r+RUSFfxJHGiAcOgdoTD3fkjs=
X-Google-Smtp-Source: AGHT+IHpIdFP676ocbdhQb1AMHameThAhSaFK8hRjB5+lE+E/aJpzvdt8A/yJ8plO+JBHU0RzqZLng==
X-Received: by 2002:a5d:688a:0:b0:317:e68f:e1af with SMTP id
 h10-20020a5d688a000000b00317e68fe1afmr12101385wru.20.1692891146209; 
 Thu, 24 Aug 2023 08:32:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x4-20020adff0c4000000b003180fdf5589sm22918640wro.6.2023.08.24.08.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 08:32:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 qemu-ppc@nongnu.org
Subject: [PATCH 1/4] hw/net/fsl_etsec/rings.c: Avoid variable length array
Date: Thu, 24 Aug 2023 16:32:21 +0100
Message-Id: <20230824153224.2517486-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824153224.2517486-1-peter.maydell@linaro.org>
References: <20230824153224.2517486-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

In fill_rx_bd() we create a variable length array of size
etsec->rx_padding. In fact we know that this will never be
larger than 64 bytes, because rx_padding is set in rx_init_frame()
in a way that ensures it is only that large. Use a fixed sized
array and assert that it is big enough.

Since padd[] is now potentially rather larger than the actual
padding required, adjust the memset() we do on it to match the
size that we write with cpu_physical_memory_write(), rather than
clearing the entire array.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/fsl_etsec/rings.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
index 788463f1b62..2f2f359f7a5 100644
--- a/hw/net/fsl_etsec/rings.c
+++ b/hw/net/fsl_etsec/rings.c
@@ -372,6 +372,12 @@ void etsec_walk_tx_ring(eTSEC *etsec, int ring_nbr)
     etsec->regs[TSTAT].value |= 1 << (31 - ring_nbr);
 }
 
+/*
+ * rx_init_frame() ensures we never do more padding than this
+ * (checksum plus minimum data packet size)
+ */
+#define MAX_RX_PADDING 64
+
 static void fill_rx_bd(eTSEC          *etsec,
                        eTSEC_rxtx_bd  *bd,
                        const uint8_t **buf,
@@ -380,9 +386,11 @@ static void fill_rx_bd(eTSEC          *etsec,
     uint16_t to_write;
     hwaddr   bufptr = bd->bufptr +
         ((hwaddr)(etsec->regs[TBDBPH].value & 0xF) << 32);
-    uint8_t  padd[etsec->rx_padding];
+    uint8_t  padd[MAX_RX_PADDING];
     uint8_t  rem;
 
+    assert(etsec->rx_padding <= MAX_RX_PADDING);
+
     RING_DEBUG("eTSEC fill Rx buffer @ 0x%016" HWADDR_PRIx
                " size:%zu(padding + crc:%u) + fcb:%u\n",
                bufptr, *size, etsec->rx_padding, etsec->rx_fcb_size);
@@ -426,7 +434,7 @@ static void fill_rx_bd(eTSEC          *etsec,
         rem = MIN(etsec->regs[MRBLR].value - bd->length, etsec->rx_padding);
 
         if (rem > 0) {
-            memset(padd, 0x0, sizeof(padd));
+            memset(padd, 0x0, rem);
             etsec->rx_padding -= rem;
             *size             -= rem;
             bd->length        += rem;
-- 
2.34.1


