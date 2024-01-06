Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DB1826199
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 22:08:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMDrg-0005bF-V8; Sat, 06 Jan 2024 16:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDre-0005aF-Fg; Sat, 06 Jan 2024 16:05:54 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDrc-00018w-SR; Sat, 06 Jan 2024 16:05:54 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55778f7662bso443992a12.1; 
 Sat, 06 Jan 2024 13:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704575150; x=1705179950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cBLwkrwr8Jj7XdQH7raQa9Nj1TEuOiCXih1DV9ONnp0=;
 b=MNiJfEmSezxWQKi6ifbpvLqhZPRwT05aXo9RuVFC8WZMypV514YTtR6xjqgl2k7mXW
 8DPArYBitmsFJerzVWW1cjP/S7SoJhhjqkz3VuW011UkUtamWxEQY2gx51cw14xBQYHI
 gNVwYAC8RVwGeYpaS0q7s+23G5zJEj3j/u0IKDk+kNTXQfjP0aMJEhH4Y7zuUGIYpKzA
 pqusrY8MmMhZ7wqzgPdY0hOoafqdRUsBMEQoGqzvSRtlMK8THn/drv6KvFR4vIr11adD
 wKtTkJfZnN7AXv8rb+uz/st41zSCNjew1rfRPpTNevpdjhSSrf4hOS6oT7lV3FcWvpgL
 VMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704575150; x=1705179950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cBLwkrwr8Jj7XdQH7raQa9Nj1TEuOiCXih1DV9ONnp0=;
 b=LsqUDRX/GGhxiPh/hMbmiqHN1FRFNZPTTAPbDWiC6kST9SMxgJ4oV6pQztAPuFJ5Im
 VzdPlR4rESqJQZJoZgB2foypfCXA0VIPfc7Pki1KJcbPN9UH7KXaHZDcUn84YJWCscvT
 05e/X3+XA/bd8SCaBxMoYrIW0Cq0XfbozhSnjip0BWmkhCrcSfYmu1D/Usv6vrRkH0wR
 kRSWsA1g6BXP7lbu/uSVulFv4miPUJsDeWn2eO4tarPOZljIcdzqnGTeTR+DFUPXHAW+
 0klcdJ/FIfU+i+qY8Rv9elOBrxgiPnRgYa+Pz8HXENgArvgsiI4PJQrANvPpBFr75tZ2
 IbCw==
X-Gm-Message-State: AOJu0Yyt0t975PSt9CRtu8JSmHh+yHk3bMDgOz6RrzAcjwZPawmH0UzS
 Ub9s8K3cB6bslH8L//9rPRTT6a8BNKo=
X-Google-Smtp-Source: AGHT+IEPygpyBoxm/Okl0EbRqcvKq1fg2xBH35wVgGDfSoYMFXQq4sFNMTleAKNtjAaafowjmLssWg==
X-Received: by 2002:a05:6402:3584:b0:557:1cde:812f with SMTP id
 y4-20020a056402358400b005571cde812fmr3781465edc.8.1704575149956; 
 Sat, 06 Jan 2024 13:05:49 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-174-094.77.11.pool.telefonica.de.
 [77.11.174.94]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056402195400b005576f4471besm624922edz.42.2024.01.06.13.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 13:05:49 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Peter Xu <peterx@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v4 03/11] hw/char/parallel: Move portio_list from
 ParallelState to ISAParallelState
Date: Sat,  6 Jan 2024 22:05:23 +0100
Message-ID: <20240106210531.140542-4-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106210531.140542-1-shentey@gmail.com>
References: <20240106210531.140542-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
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
inside ISAParallelState context, so move it there.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
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
index bd488cd7f9..c394635ada 100644
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


