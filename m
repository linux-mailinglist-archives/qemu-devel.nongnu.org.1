Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B47F7DC2
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 19:27:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6ash-0007Po-TL; Fri, 24 Nov 2023 13:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6asf-0007OJ-RB
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 13:26:21 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6asd-0001mS-Gj
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 13:26:21 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-332e40322f0so1193607f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 10:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700850377; x=1701455177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hl3E70c6a9Q8499TAB0+ujpGO1/+WwcO05W9cq9qSTg=;
 b=BkEgRYCAVyHF6B/2QHZAe0sk+q+H28YpSpRi+bJ5Stupp1mtjjejL0eNGdjjR9cciL
 UGAJkHQzBqbYypgfOxx7p1hju0NGlZoi4NiXvWUObdSJIXP/jlD7ytu043JBHig8kIQw
 vJO3I7r1VRsohl+ZCgMAmCU0e5Tq+UZmWhS/pqRWw4WRw+7JrV0FplbH8me5DuV6ekRj
 0TrPv0CJVYLdqSPoE0ZV7RgQZ42EgYNiNSAeL233UO9TbnKqqulK70kcu3NTJg0Xl95F
 GP/eNd1L+0zcmySC8kLPOvnIrq3/Z0RIOUdrmcaBM+P7p71G2Ba95L4Zl1gbI2J05VpV
 632A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700850377; x=1701455177;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hl3E70c6a9Q8499TAB0+ujpGO1/+WwcO05W9cq9qSTg=;
 b=ucCMDdkSxtjvvMbY07E841GelABnq4qOiVRQK0Rsm2FHGPtTUP8bq9w/i1Cpkwi3hA
 t3xm1CEYlIwF4pq2l25Ef6mhRiVHNMlPDTtEeQ68RRfXEZzyWPgBJrCLdRRTEbTl7lAR
 z5ThA49Eiffe5vXrg22igg79exO3BeSU4eCMdaCyOrMj+mly2Fz+cfjZ4pJAuVZdPGGt
 8+ehlik3qYOsCJAD//FqTs4ILkoopNUOkjB+5B1e61aimnFP6EHwlC3jkvDMSYwfwk8/
 y4YPJ8kAmaHtiqd7SpP+/MS2WhOTRzMZs47sJbib5I8Adv0dqzSMVs0EJlpnVXhDvNGL
 MZ1w==
X-Gm-Message-State: AOJu0YzZfQBkvOJ56TrzABdC0U2awSjDqPhyq3nPLt8XFAZdAK3wHDSV
 sgPeK6FeLuYAJuTCOm/ULHy9AKDA1d5VKgCKyB8=
X-Google-Smtp-Source: AGHT+IFjpX6HO911Qd7SQU0JF28ldD9lrfHxQDO2q69wKFwP/DGpB/0vLqHo/Ynam5pFqpLQJojn9A==
X-Received: by 2002:a05:6000:1188:b0:332:ef1e:bb86 with SMTP id
 g8-20020a056000118800b00332ef1ebb86mr334041wrx.1.1700850377533; 
 Fri, 24 Nov 2023 10:26:17 -0800 (PST)
Received: from m1x-phil.lan ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a5d6581000000b00331a55d3875sm4886499wru.38.2023.11.24.10.26.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Nov 2023 10:26:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/audio/sb16: Do not migrate qdev properties
Date: Fri, 24 Nov 2023 19:26:15 +0100
Message-ID: <20231124182615.94943-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Since commit f7b4f61f63 ("qdev/isa: convert soundblaster") these
fields has been converted to qdev properties, so don't need to be
migrated:

  static Property sb16_properties[] = {
      DEFINE_AUDIO_PROPERTIES(SB16State, card),
      DEFINE_PROP_UINT32 ("version", SB16State, ver,  0x0405), /* 4.5 */
      DEFINE_PROP_UINT32 ("iobase",  SB16State, port, 0x220),
      DEFINE_PROP_UINT32 ("irq",     SB16State, irq,  5),
      DEFINE_PROP_UINT32 ("dma",     SB16State, dma,  1),
      DEFINE_PROP_UINT32 ("dma16",   SB16State, hdma, 5),
      DEFINE_PROP_END_OF_LIST (),
  };

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/sb16.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 18f6d252db..be614d7bc3 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1325,11 +1325,11 @@ static const VMStateDescription vmstate_sb16 = {
     .minimum_version_id = 1,
     .post_load = sb16_post_load,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32 (irq, SB16State),
-        VMSTATE_UINT32 (dma, SB16State),
-        VMSTATE_UINT32 (hdma, SB16State),
-        VMSTATE_UINT32 (port, SB16State),
-        VMSTATE_UINT32 (ver, SB16State),
+        VMSTATE_UNUSED(  4 /* irq */
+                       + 4 /* dma */
+                       + 4 /* hdma */
+                       + 4 /* port */
+                       + 4 /* ver */),
         VMSTATE_INT32 (in_index, SB16State),
         VMSTATE_INT32 (out_data_len, SB16State),
         VMSTATE_INT32 (fmt_stereo, SB16State),
-- 
2.41.0


