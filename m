Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B46CF817A22
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:54:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIie-0006GT-2Q; Mon, 18 Dec 2023 13:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiU-00069i-3P; Mon, 18 Dec 2023 13:51:51 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiI-0008PT-7r; Mon, 18 Dec 2023 13:51:43 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40c68c1990dso41314295e9.0; 
 Mon, 18 Dec 2023 10:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702925494; x=1703530294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wCng+HnlULotarDqMS+lgXh7Jru+e0piPZCemAKRA4=;
 b=X6tRYI1LZwIg/34WKnMDylRud+L5Udshn+TSAugj92Q/YNTodQCKeluR5QdbKRYzb2
 OeJhCsPI/XqDyb6E3sOdJwsi1hPFmEfGow0CZ2dqyyhTSM5HnFFiNlzeKE8uaigUp9rx
 qJJEjKGeVLVG1eZ2J4ISgPTA8wN1+x40Z/kR7wb0nNhGMilbOPDab1FYDrtqNcReS0az
 nDWaqitaJuEtrpnVbvovUq/sqkvKK55/99aFa1+/OlpdX1yke7DFVM5AVDG0YokSa4JM
 IMzrK5pgT4C1TETS7teWJWIylfAgqOZQOL2FUb2xXLwmDZSG/3aMSrPp0WLL/kb/tLx+
 7Llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702925494; x=1703530294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wCng+HnlULotarDqMS+lgXh7Jru+e0piPZCemAKRA4=;
 b=CqMC//9y5X5utUDcARnVixOKUBMBVzmKY6i6qzxbbnguUf18MYbI2yft6JhYcgaOF4
 fHA5cZM0cmHQcwzY85Pxdn6YtRwm7lPeXJ03DCkeQ3B1h/BemVfSDdIFwMXr342Lh02S
 15BCzd7ytS+/nR/e7HuESKVawb34zVETXs2w1EdXofDmI4J9SAkFVOiz5Mp/MUdw7uqN
 ciM6qHTPUq0RaCjE0muSfjNWA+6u+PKbkk08EI81ftF1FhGT1rXVWXyf+7iLcaYaIGCk
 cEDm+i57pSGYSAj89CR6/IYx59ATRLUQeAZ+wnuYuggMIwjy1A7SS+n5b3TaP9qX0G9a
 RsAQ==
X-Gm-Message-State: AOJu0YzzsNrtrsTuM6shN2TN5PykHWUG9XbxtzhVknPH7RoInFQW90tG
 Uza+JogyjctUAtzfbtWwzd3B6/55lT8=
X-Google-Smtp-Source: AGHT+IHC0cN/2De5xen7ibNy+y6BllughOWYn6gEOWGq7LIQ0F28AK/jX+PE+yQRk6cY2E2tx8stBA==
X-Received: by 2002:a05:600c:3794:b0:40c:32b3:f297 with SMTP id
 o20-20020a05600c379400b0040c32b3f297mr6064574wmr.55.1702925493665; 
 Mon, 18 Dec 2023 10:51:33 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-092-224-039-156.92.224.pool.telefonica.de. [92.224.39.156])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c45c700b0040c45071c18sm35134091wmo.39.2023.12.18.10.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:51:32 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 04/12] hw/char/parallel: Free struct ParallelState from
 PortioList
Date: Mon, 18 Dec 2023 19:51:06 +0100
Message-ID: <20231218185114.119736-5-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218185114.119736-1-shentey@gmail.com>
References: <20231218185114.119736-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

ParallelState::portio_list isn't used inside ParallelState context but only
inside ISAParallelState context, so more it there.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/char/parallel-isa.h | 2 ++
 include/hw/char/parallel.h     | 2 --
 hw/char/parallel.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/char/parallel-isa.h b/include/hw/char/parallel-isa.h
index d24ccecf05..3b783bd08d 100644
--- a/include/hw/char/parallel-isa.h
+++ b/include/hw/char/parallel-isa.h
@@ -12,6 +12,7 @@
 
 #include "parallel.h"
 
+#include "exec/ioport.h"
 #include "hw/isa/isa.h"
 #include "qom/object.h"
 
@@ -25,6 +26,7 @@ struct ISAParallelState {
     uint32_t iobase;
     uint32_t isairq;
     ParallelState state;
+    PortioList portio_list;
 };
 
 #endif /* HW_PARALLEL_ISA_H */
diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
index 7b5a309a03..cfb97cc7cc 100644
--- a/include/hw/char/parallel.h
+++ b/include/hw/char/parallel.h
@@ -1,7 +1,6 @@
 #ifndef HW_PARALLEL_H
 #define HW_PARALLEL_H
 
-#include "exec/ioport.h"
 #include "exec/memory.h"
 #include "hw/isa/isa.h"
 #include "hw/irq.h"
@@ -22,7 +21,6 @@ typedef struct ParallelState {
     uint32_t last_read_offset; /* For debugging */
     /* Memory-mapped interface */
     int it_shift;
-    PortioList portio_list;
 } ParallelState;
 
 void parallel_hds_isa_init(ISABus *bus, int n);
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 147c900f0d..c1747cbb75 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -532,7 +532,7 @@ static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
         s->status = dummy;
     }
 
-    isa_register_portio_list(isadev, &s->portio_list, base,
+    isa_register_portio_list(isadev, &isa->portio_list, base,
                              (s->hw_driver
                               ? &isa_parallel_portio_hw_list[0]
                               : &isa_parallel_portio_sw_list[0]),
-- 
2.43.0


