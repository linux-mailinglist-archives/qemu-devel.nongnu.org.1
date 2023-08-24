Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 920F2787634
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:58:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDeW-0004Wa-CU; Thu, 24 Aug 2023 12:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZDeU-0004Vq-CJ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:57:46 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZDeR-0003Iv-HB
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:57:46 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b9338e4695so107089011fa.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692896261; x=1693501061;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6btm2bj7axX72krV93gy9BGEHB1Ne2PaEfLnWDePLQI=;
 b=OCGZKtGUjmv5dysmUo9GNgnrfY6JWjn6xuNCIt4xh5nL7gDMKkbf4XSFeczipVelgX
 LOu1uoZayQkT7muUU/0NJ6y3p/bekz8U26oULy8ffH25x9yI5lFuWsRc/e5SfrZFL7Gm
 KRT/X2n78biO24zcXHJt37UjgjcsmSEm3kiKQjApQenwyfwdg59cQzsp2I2YherZUIHw
 qF2p4BPfTK0Sda/Oufg+Goi4O+H3Re2/XZef4GyiktxCAOpTMxD4Hh8MjcBGLN8QMbGN
 J9GVSz1GtJrNa9YDNczVNcP/dCfyO1mFuaFewCuGFNQ9F+jlhIvhdS0Fjb6SaL7NEzeT
 sj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692896261; x=1693501061;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6btm2bj7axX72krV93gy9BGEHB1Ne2PaEfLnWDePLQI=;
 b=QgOp0/ugrAESj6yigDosUYgLAUNnxgfhvXynY+M/Vz1Gg2QtxvlVk37EbTW6Suh6zD
 8DiTzmovQXH1mLtvXf91a1LgK0Y0UPgVCcUcxQgry2kAkAGGgZN8+9K0mjQXe3dcn4ZA
 WJDo3oLq7sctt8ro28LID1xeZB/eEGm7I6WFg2qhRgy6QsIn+7oqq9B8WiMWQ4Ay9Cb6
 34i+TiiCiVY6yyXVG0TngqXpA40rqnCVNw1OT7YwlAhlVx1oBAeBZmj/18BI9wF5JsbW
 ujCjY2kBcsWEhVgkqxS9ipBwzAgI0is5sKS3+SV9q8L0NpVnR+EW8pQsVKcL0z6JTuxD
 s1ug==
X-Gm-Message-State: AOJu0YzbeiU14Qs+wQf2g993K1MHT4ti7I1iII+HXkXkHG5t5gQHdxyw
 eV+splfSI0Mo+MvWQuam5PYGwufZX+09DdtOS6o=
X-Google-Smtp-Source: AGHT+IEJWtZ+gpBDMEAZkTUBYEB+8hHHm9FrdffmhVz6nOirAgz+b7Rrj2uIruwpypct106xRVaBdQ==
X-Received: by 2002:a2e:94c3:0:b0:2bc:b46b:686b with SMTP id
 r3-20020a2e94c3000000b002bcb46b686bmr11777121ljh.34.1692896261447; 
 Thu, 24 Aug 2023 09:57:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a1c4c10000000b003fe215e4492sm3173133wmf.4.2023.08.24.09.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:57:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] hw/block/dataplane/virtio-block: Avoid dynamic stack
 allocation
Date: Thu, 24 Aug 2023 17:57:40 +0100
Message-Id: <20230824165740.2653919-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Instead of using a variable length array in notify_guest_bh(), always
use a fixed sized bitmap (this will be 128 bytes).  This means we
need to avoid assuming that bitmap and the s->batch_notify_vqs bitmap
are the same size; the neatest way to do this is to switch to using
bitmap.h APIs to declare, copy and clear, because then we can specify
the length in bits, exactly as we did when creating
s->batch_notify_vqs with bitmap_new().

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
In discussion on Philippe's attempt at getting rid of this VLA:
https://patchew.org/QEMU/20210505211047.1496765-1-philmd@redhat.com/20210505211047.1496765-7-philmd@redhat.com/
Stefan suggested getting rid of the local bitmap array entirely.
But I don't know this code at all and have no idea of the
implications (presumably there is a reason we have the local
array rather than iterating directly on batch_notify_vqs),
so I have opted for the more minimal change.

Usual disclaimer: tested only with "make check" and
"make check-avocado".
---
 hw/block/dataplane/virtio-blk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index da36fcfd0b5..f31ec79d0b2 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -59,11 +59,16 @@ static void notify_guest_bh(void *opaque)
 {
     VirtIOBlockDataPlane *s = opaque;
     unsigned nvqs = s->conf->num_queues;
-    unsigned long bitmap[BITS_TO_LONGS(nvqs)];
+    DECLARE_BITMAP(bitmap, VIRTIO_QUEUE_MAX);
     unsigned j;
 
-    memcpy(bitmap, s->batch_notify_vqs, sizeof(bitmap));
-    memset(s->batch_notify_vqs, 0, sizeof(bitmap));
+    /*
+     * Note that our local 'bitmap' is declared at a fixed
+     * worst case size, but s->batch_notify_vqs has only
+     * nvqs bits in it.
+     */
+    bitmap_copy(bitmap, s->batch_notify_vqs, nvqs);
+    bitmap_zero(s->batch_notify_vqs, nvqs);
 
     for (j = 0; j < nvqs; j += BITS_PER_LONG) {
         unsigned long bits = bitmap[j / BITS_PER_LONG];
-- 
2.34.1


