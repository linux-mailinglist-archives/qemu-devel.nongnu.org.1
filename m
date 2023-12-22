Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 625F281CAD9
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 14:46:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGfqx-0007wf-Ks; Fri, 22 Dec 2023 08:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqg-0007Ya-8Y
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:46:02 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqd-0004Jp-Hu
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:45:57 -0500
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-40c60dfa5bfso20267535e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 05:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703252752; x=1703857552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ECeycGat9s8XZNxmyA3FvGD40nY/ZSCvilF5u+LI1Sg=;
 b=jdrZsccdBJd5iAnq/ZBjUOxbDhHBT5xMAnoWm3W6vaFd+Q4UrSNWRQ6Mn6AztYsMWX
 h/tK7LotbFfBMBvxfoiHHFbSmAJFlH8oEp0zuZKI/wiL7T2v7MN7eIXKpWUV4J2TXJ6C
 1vXuqeey87p8seQqUPBBYyutW+E6y55RxlzT0cTLRXFsiFH85dlOT6G5G6Qc8SPz2n2j
 aqryWChfPyLIlDKR/IzXXYjpFB0aBHFu8vl4Hyvih1L/bpYBdkC+MdVp7riZMCj3A7nk
 VSw0simRZODDzuHgiNfooAWeuWy5E4Cb9YLwI635QTHhO8JTmjafYYnaPsH76FEURNu5
 /riQ==
X-Gm-Message-State: AOJu0Yzm+ByYWQwgK6+geWXiCP8F+HAA9IcIxSWuh4J2k8KPHpLioWIt
 GFaXL3WU+4HlCJdhpjnLa3KOmhCTjNw=
X-Google-Smtp-Source: AGHT+IGg/hTxEocofQP4M5S6FDSDgY+ywD1rfVi2f0Ya+s88R+1j/KQd00KWldaXh23l1rm/Q+LXVQ==
X-Received: by 2002:a05:600c:1987:b0:40d:12ad:e0c9 with SMTP id
 t7-20020a05600c198700b0040d12ade0c9mr710621wmq.10.1703252752491; 
 Fri, 22 Dec 2023 05:45:52 -0800 (PST)
Received: from fedora.. (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm7047333wmq.27.2023.12.22.05.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 05:45:51 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 06/11] next-cube.c: move static led variable to NeXTPC
Date: Fri, 22 Dec 2023 14:45:22 +0100
Message-ID: <20231222134527.15705-7-huth@tuxfamily.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222134527.15705-1-huth@tuxfamily.org>
References: <20231222134527.15705-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.128.42; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f42.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The state of the led is stored in the SCR2 register which is part of the NeXTPC
device.

Note that this is a migration break for the NeXTPC device, but as nothing will
currently boot then we simply bump the migration version for now.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20231220131641.592826-7-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index be4091ffd7..bcc7650cd9 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -92,6 +92,7 @@ struct NeXTPC {
     uint32_t scr2;
     uint32_t int_mask;
     uint32_t int_status;
+    uint32_t led;
     uint8_t scsi_csr_1;
     uint8_t scsi_csr_2;
 
@@ -123,7 +124,6 @@ static const uint8_t rtc_ram2[32] = {
 
 static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
 {
-    static int led;
     static int phase;
     static uint8_t old_scr2;
     uint8_t scr2_2;
@@ -137,10 +137,10 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
 
     if (val & 0x1) {
         DPRINTF("fault!\n");
-        led++;
-        if (led == 10) {
+        s->led++;
+        if (s->led == 10) {
             DPRINTF("LED flashing, possible fault!\n");
-            led = 0;
+            s->led = 0;
         }
     }
 
@@ -926,13 +926,14 @@ static const VMStateDescription next_rtc_vmstate = {
 
 static const VMStateDescription next_pc_vmstate = {
     .name = "next-pc",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(scr1, NeXTPC),
         VMSTATE_UINT32(scr2, NeXTPC),
         VMSTATE_UINT32(int_mask, NeXTPC),
         VMSTATE_UINT32(int_status, NeXTPC),
+        VMSTATE_UINT32(led, NeXTPC),
         VMSTATE_UINT8(scsi_csr_1, NeXTPC),
         VMSTATE_UINT8(scsi_csr_2, NeXTPC),
         VMSTATE_STRUCT(rtc, NeXTPC, 0, next_rtc_vmstate, NextRtc),
-- 
2.43.0


