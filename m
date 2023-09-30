Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F03B77B4071
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 15:25:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmZxb-0007ea-QU; Sat, 30 Sep 2023 09:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qmZxX-0007eF-E8
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 09:24:39 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qmZxT-0007f1-Ot
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 09:24:39 -0400
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so2039871566b.3
 for <qemu-devel@nongnu.org>; Sat, 30 Sep 2023 06:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696080271; x=1696685071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YtxjMd25yBMyDgtsYv1lyFY28EVXaHYsePcXASZSNTo=;
 b=MxEMG16G8XM+ajSAUFxH8E9wrgI/hwICay9orh/U6YNQK2lLsv8T7g2Se0MvSosyiQ
 PmQeNC3fUmMahxD4a+qBkHg+KF6oCv/Rza5wmtu2JQFhkHwul3/v8vQdWJ8LDIYDAlOV
 k97IkSnfILEwzuDPlSVaPd9SC46YJPMoetM9+iPn3IYQqYo4wXQsuaVpYBV10doJFa5D
 Gr8OVCpoQoHnus0GfI8yBg/oE349CYivTRs4merSiOq1uNapk62ZV8jIQQtgEzurzNl4
 8qvRobTJc12qjjH8iNEgpzKGDTy7fUf0UeOJedhXQP38o2IkZG1QVbBNS7KOvHxKDkW4
 CTbw==
X-Gm-Message-State: AOJu0YwVipMy97hXukXvKX0l00DYhRSYDEtYLOE7W9OE/K4/AzgQTe+D
 6EOBblFVfEhNABL8JfZYA6NAkDa6oU8=
X-Google-Smtp-Source: AGHT+IHREaVrUg84PwdFqYgDJxaH0ayDb6Io8V/2bueLog634QKrukoDz2fsYTXs2K4qL/WyIK6hDg==
X-Received: by 2002:a17:907:9724:b0:9b0:169b:eedf with SMTP id
 jg36-20020a170907972400b009b0169beedfmr8377377ejc.7.1696080271385; 
 Sat, 30 Sep 2023 06:24:31 -0700 (PDT)
Received: from fedora.. (ip-109-43-177-123.web.vodafone.de. [109.43.177.123])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a170906944f00b00993928e4d1bsm13919471ejx.24.2023.09.30.06.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 06:24:31 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 2/5] hw/scsi/esp: Work around problem with PIO data read for
 the NeXT-Cube machine
Date: Sat, 30 Sep 2023 15:23:48 +0200
Message-ID: <20230930132351.30282-3-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230930132351.30282-1-huth@tuxfamily.org>
References: <20230930132351.30282-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.47; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f47.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.708, SPF_HELO_NONE=0.001,
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

The NeXT-Cube bios uses this mode in its selftest, and without
decreasing the amount of bytes in the fifo here, the selftest
fails.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index e52188d022..0d54efe826 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -961,7 +961,7 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
                 (s->rregs[ESP_RSTAT] & STAT_PIO_MASK) == 0) {
             /* Data out.  */
             qemu_log_mask(LOG_UNIMP, "esp: PIO data read not implemented\n");
-            s->rregs[ESP_FIFO] = 0;
+            s->rregs[ESP_FIFO] = esp_fifo_pop(&s->fifo);
         } else {
             if ((s->rregs[ESP_RSTAT] & 0x7) == STAT_DI) {
                 if (s->ti_size) {
-- 
2.41.0


