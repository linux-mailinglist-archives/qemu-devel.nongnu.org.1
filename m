Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AD081BA46
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:11:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGKen-00088m-8Z; Thu, 21 Dec 2023 10:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKeh-00087V-Mv; Thu, 21 Dec 2023 10:08:11 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKeg-0004JD-0H; Thu, 21 Dec 2023 10:08:11 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-54cb4fa667bso1147202a12.3; 
 Thu, 21 Dec 2023 07:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703171286; x=1703776086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7ExFl9Onle82wvecw0jGK0kYbFQMh4wlO/YWeYYimY=;
 b=lqfYn0DvQmzxnbShtGFKkyW8m6qnDeyBGWbKNsOq8qXbLKVVFExvVCwIDz7aueBgDA
 QXWRWbVsY8YHEcx08uNburKKn0VH6IDcNIof3/vzyssIKuCFUoIhCEH3epNVuGlfoqu8
 LiTjSCUBkaa9Cht0NFgnwdVdaBD/8kYAoRzamuztCTyPmiQ9QsV2yKgaKfxJtilByD2r
 8k1ceBbosnJ5xnKEVjbsnvrDguGd19jVULRHp8pXcizl/1/2MP8g9evhnDTHHpIpXMh/
 bTpYeORDFEY88lI31y56Fcyy+FtZCiL6NbIanmbKB/e+6eRr6XkLDaJNz0+JfHkvxIuH
 5MLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171286; x=1703776086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y7ExFl9Onle82wvecw0jGK0kYbFQMh4wlO/YWeYYimY=;
 b=MqzvmQ8aBeZsOwXj49fA8zhZM49aXgh/05AoAaxRU6oddYgZtuffZtK48oJZdjgiQl
 cGIsT+04nrLGNQrtrlKcStOxz+F5/ZgCGzuTqvNkmshc05i4Ie2ccJxUichCEvsQ+KPO
 Ta3Tflw71SwGsPit4VWgnbgOWJp2RnrGoq66zPH9Dg/WAscSEi0GMjipVWoayz2TrmtQ
 EEGeovBKNz1dMoSxLSm4ZabfzuQILpYd0wo6NjEVr3P8QqR72KwFhcZBzFuLhv++PkI9
 fm7DL6dzR5oXq8O9oLAWfp9Q5BRP1D5GEOntLNEBRQ1j3lcv7f2oqESvwCbhksaiv2z/
 3qxw==
X-Gm-Message-State: AOJu0YxsTcqz2WVXvNsiPDNATmThHymOE7/NK4yDBxKf/vEtnhJnjx6g
 qbI3l0fn4JNO+klGcmM7PsE2TQvCuKlCoA==
X-Google-Smtp-Source: AGHT+IGSFmGciZHdvmJpaFDwiIz0Wf3TU2MabbChsT91kf6bhWGAt7sMyWXyFvBS8nreA3s3wc2M8A==
X-Received: by 2002:a50:999a:0:b0:553:6562:be8 with SMTP id
 m26-20020a50999a000000b0055365620be8mr3156874edb.44.1703171286146; 
 Thu, 21 Dec 2023 07:08:06 -0800 (PST)
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a056402241900b00553b6b5bb44sm1264264eda.67.2023.12.21.07.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 07:08:05 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Sergio Lopez <slp@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Hildenbrand <david@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 03/11] hw/char/parallel: Move portio_list from
 ParallelState to ISAParallelState
Date: Thu, 21 Dec 2023 16:07:42 +0100
Message-ID: <20231221150750.5435-4-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221150750.5435-1-shentey@gmail.com>
References: <20231221150750.5435-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
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


