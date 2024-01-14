Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A92CC82D09E
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 13:44:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOzm4-0003Ez-Eg; Sun, 14 Jan 2024 07:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzm2-0003Dp-LH; Sun, 14 Jan 2024 07:39:34 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzm1-0001c0-30; Sun, 14 Jan 2024 07:39:34 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a2821884a09so661176966b.2; 
 Sun, 14 Jan 2024 04:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705235970; x=1705840770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cBLwkrwr8Jj7XdQH7raQa9Nj1TEuOiCXih1DV9ONnp0=;
 b=LcVVTIPdvsWkbmWzE3fw4M4DLx83zOYWUKWI264Do+ahvd9BUA21P19S2Cdb9JOL/h
 rBoZGjDlg3Ljw4FqTv3NL8Z9yA5+xXH37q8xv6HKgEu1fJtBQdWHFRBVKtwmlN8IzJ38
 M8OI0necIwv7/Xofy9XwvfzyVJQsboGfLS15B9iqhka08XdF05v6rxnLYkI75U9B9w2T
 7X456ODOGRjK4SseBYDGkt7QDX6wUfnJeB63awv8opVpVkGRFfCMnTwGOnQfzihZqfon
 bdynABoTEPN4KDCDX0ZrypOpxcmqaNDJZfcmFTKgeHfvyj0ou7rvmLtjnf49insUrB1m
 Lj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705235970; x=1705840770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cBLwkrwr8Jj7XdQH7raQa9Nj1TEuOiCXih1DV9ONnp0=;
 b=FDF3Vzi5Giop8iaxiEhPt9hfA3XFnBIcA64pswf98OK5m+tthnqlMhJ6ZCdvw83Md3
 nLGxRG0+2BlXBj2sb4uDqvF2HWY70GTZx6NmVwgAs1swtYUiJ+zxvukt/Yx0wdDwSHuS
 LqdvkpOA/1+RHu2zghbrayLePE/VcU2HJoM31BwEU7NHL5Cc28NMFrc328rUzs+4dQE3
 m25rUq4IulOWWr0hVkndcBYwm/wz6/ssBGnMtCBQ00sYNGlliM1+j+dVhUWS7bRuUxex
 D1xek3Fr6oI0sI/I+Zbgl/A7ljgWR1WZwaqkCS6xVWsAyDLcfwxQj7QdiiSUr1WVR2gU
 uXtg==
X-Gm-Message-State: AOJu0Yy0kasWLQDWzlO5UfNHO3LAwQhCXBa8VBEqrVLagE1hnheGWYjA
 LBrhx0mRNanMbBKNsat/cNdlU8lXyI8=
X-Google-Smtp-Source: AGHT+IHYk9nCkTF+HhCXDlLk1qqNAtlMtHVac3SFDz5o/jdJpjcMzan3+2q6qfrfV0CB9dYFBKwohQ==
X-Received: by 2002:a17:906:591:b0:a28:b6b6:af90 with SMTP id
 17-20020a170906059100b00a28b6b6af90mr2132368ejn.71.1705235970083; 
 Sun, 14 Jan 2024 04:39:30 -0800 (PST)
Received: from archlinux.. (dynamic-077-183-249-018.77.183.pool.telefonica.de.
 [77.183.249.18]) by smtp.gmail.com with ESMTPSA id
 s2-20020a170906354200b00a293c6cc184sm4023734eja.24.2024.01.14.04.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 04:39:28 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 03/11] hw/char/parallel: Move portio_list from
 ParallelState to ISAParallelState
Date: Sun, 14 Jan 2024 13:39:03 +0100
Message-ID: <20240114123911.4877-4-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114123911.4877-1-shentey@gmail.com>
References: <20240114123911.4877-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
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


