Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B947E9AB8
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 12:08:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2UnZ-0006Wy-CB; Mon, 13 Nov 2023 06:08:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2UnV-0006VG-W8
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:08:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2UnU-0001Is-6C
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699873683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W/51nzd0HeoeHrlTasrIYRHHxkWIrSm/T0mCd7w+SVc=;
 b=HwbNEA2fYm8CI9c630T0NR667XmDZH0IrMpxlJFA8FjtVdvsvsZmTcnIKKiDh/EKeAGkQA
 FAGq21TwkRuXfVPjniE3/bWiWJSLzAOwCbr8BdSMqRfUhElzTQXwKtcHHZ4joKU1c2FRRv
 d8nZ5EVqhDuwHlZRjd8G1w4zahQIqbY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-rRHLXSg3MxqwKFOBIqlL_Q-1; Mon, 13 Nov 2023 06:08:00 -0500
X-MC-Unique: rRHLXSg3MxqwKFOBIqlL_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E711C101A52D;
 Mon, 13 Nov 2023 11:07:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6DD92166B26;
 Mon, 13 Nov 2023 11:07:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: [PULL 12/12] hw/audio/es1370: Clean up comment
Date: Mon, 13 Nov 2023 12:07:40 +0100
Message-ID: <20231113110740.38270-13-thuth@redhat.com>
In-Reply-To: <20231113110740.38270-1-thuth@redhat.com>
References: <20231113110740.38270-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Peter Maydell <peter.maydell@linaro.org>

Replace a sweary comment with one that's a bit more helpful to
future readers of the code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Volker Rümelin <vr_qemu@t-online.de>
Message-ID: <20231110164318.2197569-1-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/audio/es1370.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 91c47330ad..fad5541211 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -670,8 +670,13 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
     cnt += (transferred + d->leftover) >> 2;
 
     if (s->sctl & loop_sel) {
-        /* Bah, how stupid is that having a 0 represent true value?
-           i just spent few hours on this shit */
+        /*
+         * loop_sel tells us which bit in the SCTL register to look at
+         * (either P1_LOOP_SEL, P2_LOOP_SEL or R1_LOOP_SEL). The sense
+         * of these bits is 0 for loop mode (set interrupt and keep recording
+         * when the sample count reaches zero) or 1 for stop mode (set
+         * interrupt and stop recording).
+         */
         AUD_log ("es1370: warning", "non looping mode\n");
     } else {
         d->frame_cnt = size;
-- 
2.41.0


