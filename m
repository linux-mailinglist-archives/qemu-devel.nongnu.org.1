Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F577C810C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:57:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDpe-0007Sz-0E; Fri, 13 Oct 2023 04:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpX-0007Kj-4t
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:36 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpS-0000mN-Qs
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:34 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b9d07a8d84so23603551fa.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186848; x=1697791648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JcZTSQIpbpwyV8p0pRSuuu/VA6jNLdNli4zn1qzWBPs=;
 b=IfW9zeAVlWL8qoMu6FR5kIY+zObWXsK1zofQs2iegBZLIjnkC0uSF1CcwrVKoVhrfM
 RX19yDja3+XgxzhFK268TELLMJPS/2hco1dMIgfqbWx51XhEVwGY91NozghIKI+8SNu/
 UJ80TwbnDzouHX2UW6C3RFADCajpDopcWtKhLL4WLvdgQY4CVgD2aiYPYjmFSpI5p9po
 ZycYd8akni0EL+RS/05kdD3jYY94JRnWeW3Dhl5AHvb7PZYoL0cMIUb0kZgYkmvflC4Q
 L3riwKRPxxX3S1AcDSWNScv7LS3jXp39Jy4JTqQ4kzBT9qEGzvJcMwKCqVwgyFpoO+UH
 0vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186848; x=1697791648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JcZTSQIpbpwyV8p0pRSuuu/VA6jNLdNli4zn1qzWBPs=;
 b=nvbO4d6F/z/ya3+1tuL11mnGzca0BYQ1HToey2PZTlLurvyfJ9ze/ZOq4qHPSIgKjo
 bKBp8TdXHJLDLpK2yjCl/xwLAiI/f6xVRCqmBIvzbbjCRSRRjONuen5Jn4EvVv2xFj4H
 t0hc/qMxo6jHgGgoT6ELdAyGweq3vYFvMQdq82I/rqQjZQKw4CptEQQ/67mw2+/+ZFnv
 TGj1V2dWmIqLKiTNOhXbUbJ4g+062cpbEo/xKoqjDlcwA7L1tWIcYAO16n6ZTACrViRt
 wXB0sDfxF1Mn6jT84LWLC/NtS9d68HJWm8bj6++/qk4FlQSuXgOUcfflGBunWm/m7aF+
 6FzA==
X-Gm-Message-State: AOJu0YynMvEH1+33pyOmxc1BR1nQ/jeTJWlRp7AuBju3CLYNZ7KkAYZB
 8GrNqVeazyjyPRvNLAWz6q7zKxgAdGAzlNMg8/U=
X-Google-Smtp-Source: AGHT+IGLuC9HKW/QNYVooLucDlhbrhXRUmiwPIIyaiW89GtG8Q02ZXeqgArmC7ch07Ic5cPqZPab5A==
X-Received: by 2002:a2e:9a84:0:b0:2c2:8e57:24a7 with SMTP id
 p4-20020a2e9a84000000b002c28e5724a7mr24325725lji.21.1697186848424; 
 Fri, 13 Oct 2023 01:47:28 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:27 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org (open list:virtio-blk),
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [RFC PATCH v3 08/78] hw/block: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:36 +0300
Message-Id: <88122696480ffb58fa39af81d254aa656afbcd64.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x236.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/block/dataplane/xen-block.c | 4 ++--
 hw/block/m25p80.c              | 2 +-
 hw/block/onenand.c             | 2 +-
 hw/block/pflash_cfi01.c        | 1 +
 hw/block/pflash_cfi02.c        | 6 ++++--
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 3b6f2b0aa2..1ae25a73b2 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -159,7 +159,7 @@ static int xen_block_parse_request(XenBlockRequest *request)
         if (!request->req.nr_segments) {
             return 0;
         }
-        /* fall through */
+        fallthrough;
     case BLKIF_OP_WRITE:
         break;
     case BLKIF_OP_DISCARD:
@@ -299,7 +299,7 @@ static void xen_block_complete_aio(void *opaque, int ret)
         if (!request->req.nr_segments) {
             break;
         }
-        /* fall through */
+        fallthrough;
     case BLKIF_OP_READ:
         if (request->status == BLKIF_RSP_OKAY) {
             block_acct_done(blk_get_stats(dataplane->blk), &request->acct);
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index afc3fdf4d6..523c34da71 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1462,7 +1462,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
             s->state = STATE_COLLECTING_DATA;
             break;
         }
-        /* Fallthrough */
+        fallthrough;
 
     default:
         s->pos = 0;
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index 50d3d1c985..87583c48a0 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -564,7 +564,7 @@ static void onenand_command(OneNANDState *s)
         break;
     case 0x95:  /* Multi-block erase */
         qemu_irq_pulse(s->intr);
-        /* Fall through.  */
+        fallthrough;
     case 0x94:  /* Block erase */
         sec = ((s->addr[ONEN_BUF_BLOCK] & 0xfff) |
                         (s->addr[ONEN_BUF_BLOCK] >> 15 ? s->density_mask : 0))
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 62056b1d74..cb58f08f53 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -276,6 +276,7 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr offset,
          */
         pfl->cmd = 0x00;
         /* fall through to read code */
+        fallthrough;
     case 0x00: /* This model reset value for READ_ARRAY (not CFI compliant) */
         /* Flash area read */
         ret = pflash_data_read(pfl, offset, width, be);
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 2a99b286b0..711f978d7c 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -328,6 +328,7 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
         trace_pflash_read_unknown_state(pfl->name, pfl->cmd);
         pflash_reset_state_machine(pfl);
         /* fall through to the read code */
+        fallthrough;
     case 0x80: /* Erase (unlock) */
         /* We accept reads during second unlock sequence... */
     case 0x00:
@@ -359,6 +360,7 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
                 break;
             }
             /* Fall through to data read. */
+            fallthrough;
         default:
             ret = pflash_data_read(pfl, offset, width);
         }
@@ -368,7 +370,7 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
     case 0x30: /* Sector Erase */
         /* Toggle bit 2 during erase, but not program. */
         toggle_dq2(pfl);
-        /* fall through */
+        fallthrough;
     case 0xA0: /* Program */
         /* Toggle bit 6 */
         toggle_dq6(pfl);
@@ -582,7 +584,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                 pfl->cmd = 0x98;
                 return;
             }
-            /* fall through */
+            fallthrough;
         default:
             trace_pflash_write_invalid(pfl->name, pfl->cmd);
             goto reset_flash;
-- 
2.39.2


