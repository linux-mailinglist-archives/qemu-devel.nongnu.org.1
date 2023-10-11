Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 380F57C4A9E
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 08:32:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqSlM-00022A-WB; Wed, 11 Oct 2023 02:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qqSlC-0001y0-KG
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qqSlA-0006wx-UU
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697005916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQ2NwFRR4WHYGU0xF7Yq73z3DjZ8+wH2HJ0y6d4oYgc=;
 b=UntguH6CI2iGFf+wnjKDiYbvJo7fwU0l75AfHFRYtsoQ+uuABmL569858bbutizmBlXWLH
 mwr2IrB7gP9B9ItbB0R17YWuEhMsq675A81y/60wAmQZODohLvOcfr7UIf5R3s0Rh72mvZ
 0PKwwRWWKhsxtTW0HOXrdo1mDEwYeKE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-dugO3877NxGTowrB33lx6Q-1; Wed, 11 Oct 2023 02:31:36 -0400
X-MC-Unique: dugO3877NxGTowrB33lx6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E0AD8F5DA3;
 Wed, 11 Oct 2023 06:31:36 +0000 (UTC)
Received: from localhost (unknown [10.39.208.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E53C111CD23;
 Wed, 11 Oct 2023 06:31:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	stefanha@redhat.com,
	vr_qemu@t-online.de
Subject: [PULL 7/8] hw/audio/es1370: change variable type and name
Date: Wed, 11 Oct 2023 10:31:00 +0400
Message-ID: <20231011063101.258955-8-marcandre.lureau@redhat.com>
In-Reply-To: <20231011063101.258955-1-marcandre.lureau@redhat.com>
References: <20231011063101.258955-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Volker Rümelin <vr_qemu@t-online.de>

Change the type of the variable temp to size_t to avoid a type
cast. While at it, rename the variable name to to_transfer. This
improves the readability of the code.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20230917065813.6692-7-vr_qemu@t-online.de>
---
 hw/audio/es1370.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index b4c00df189..b47794f786 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -605,6 +605,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
                                    int max, int *irq)
 {
     uint8_t tmpbuf[4096];
+    size_t to_transfer;
     uint32_t addr = d->frame_addr;
     int sc = d->scount & 0xffff;
     int csc = d->scount >> 16;
@@ -616,16 +617,16 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
     }
     int left = ((size - cnt + 1) << 2) + d->leftover;
     int transferred = 0;
-    int temp = MIN (max, MIN (left, csc_bytes));
     int index = d - &s->chan[0];
 
+    to_transfer = MIN(max, MIN(left, csc_bytes));
     addr += (cnt << 2) + d->leftover;
 
     if (index == ADC_CHANNEL) {
-        while (temp > 0) {
+        while (to_transfer > 0) {
             int acquired, to_copy;
 
-            to_copy = MIN ((size_t) temp, sizeof (tmpbuf));
+            to_copy = MIN(to_transfer, sizeof(tmpbuf));
             acquired = AUD_read (s->adc_voice, tmpbuf, to_copy);
             if (!acquired) {
                 break;
@@ -633,23 +634,23 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
 
             pci_dma_write (&s->dev, addr, tmpbuf, acquired);
 
-            temp -= acquired;
+            to_transfer -= acquired;
             addr += acquired;
             transferred += acquired;
         }
     } else {
         SWVoiceOut *voice = s->dac_voice[index];
 
-        while (temp > 0) {
+        while (to_transfer > 0) {
             int copied, to_copy;
 
-            to_copy = MIN ((size_t) temp, sizeof (tmpbuf));
+            to_copy = MIN(to_transfer, sizeof(tmpbuf));
             pci_dma_read (&s->dev, addr, tmpbuf, to_copy);
             copied = AUD_write (voice, tmpbuf, to_copy);
             if (!copied) {
                 break;
             }
-            temp -= copied;
+            to_transfer -= copied;
             addr += copied;
             transferred += copied;
         }
-- 
2.41.0


