Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7808882D091
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 13:41:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOzmK-0003TG-Kb; Sun, 14 Jan 2024 07:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzmI-0003QN-B0; Sun, 14 Jan 2024 07:39:50 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzmG-0001mv-Oq; Sun, 14 Jan 2024 07:39:50 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40d6b4e2945so91836005e9.0; 
 Sun, 14 Jan 2024 04:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705235986; x=1705840786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BO3joJYDTtGUerfBs3WaLe5gIZcBp9HzTmPOq+TE/bA=;
 b=CgakkSV3E3rN13pvgi1WIQ1IUAdBtGFScyMxa2osmU4H5sWqCUoUcWwcpvYfB3QPRK
 7u2VnoqGAtMsiQA3tu+XP35ZJfSCdghUkru29+y/gRUyDOMa/4t14e1Q6a+/FH1rZc/l
 LMuUluF5z9+S8bNMl5tjGXQEBSQJgJUo6R1qsRFR0UBnxs9Q+roIm2j8rX3huhlrDInU
 qHbYfX4g2ArKGmM8TNsiFIK4m6Pipg9xzBllKt+t/BPJUPx4vSTxKzH7s5qcxM7GWBy8
 GTummwb3iogvm4MpLtQKosBPLLkC54DLtqu3Zq9rAdeZbHb/rdMJRHnHoUTifoe318rQ
 0qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705235986; x=1705840786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BO3joJYDTtGUerfBs3WaLe5gIZcBp9HzTmPOq+TE/bA=;
 b=V0jD6pocAMkMk9Wikjtt8oBp3atxDjzzPmoHSoF+GbMdZaX3XYqOrSLtqDQ7Yb68Cj
 /NbCvaHaTlvJtKFJekypcw+rZZTyK2BxlpgVm2wl4y8QiiOhEjAYf94dugcjEzwHnUnR
 PKoriLbjcmYyoP75atnA196w+WfsgLttvl9kPScR/elyDA8Yk730Tot+Z0DqmmXm1mUB
 5D+gMEXFM+4CNwYHLcf3s461oQ+mWUzJUjpHGNZfVLjmm+N+nsUlRpvlvo5SmlPbaCaf
 d8cTKrmR0ZCFPR3uQI3c4sXpJs9EO75b/Sz4bWY0npCdTiBjLh7XJWeWX7weselGI2yI
 JlLg==
X-Gm-Message-State: AOJu0YyE8mYmJnIA/ojpl1xbf8JzMaXSyj9CyHNlIZeYQwK2RJ70dd/k
 +KPJEXYpICIvlDQy+uuIdq56tYNlCCg=
X-Google-Smtp-Source: AGHT+IFrzxpg8JExJ+T1ucz+AaYLELfrlgkLvIZeKTOJfN2VbWlSVa8tjdL1POEa8MiewSq3fG636A==
X-Received: by 2002:a05:600c:a684:b0:40e:4833:813b with SMTP id
 ip4-20020a05600ca68400b0040e4833813bmr1448393wmb.181.1705235985678; 
 Sun, 14 Jan 2024 04:39:45 -0800 (PST)
Received: from archlinux.. (dynamic-077-183-249-018.77.183.pool.telefonica.de.
 [77.183.249.18]) by smtp.gmail.com with ESMTPSA id
 s2-20020a170906354200b00a293c6cc184sm4023734eja.24.2024.01.14.04.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 04:39:44 -0800 (PST)
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
Subject: [PATCH v5 09/11] hw/char/parallel-isa: Implement relocation and
 enabling/disabling for TYPE_ISA_PARALLEL
Date: Sun, 14 Jan 2024 13:39:09 +0100
Message-ID: <20240114123911.4877-10-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114123911.4877-1-shentey@gmail.com>
References: <20240114123911.4877-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
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

The real SuperI/O chips emulated by QEMU allow for relocating and enabling or
disabling their SuperI/O functions via software. So far this is not implemented.
Prepare for that by adding isa_parallel_set_{enabled,iobase}.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/char/parallel-isa.h |  3 +++
 hw/char/parallel-isa.c         | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/char/parallel-isa.h b/include/hw/char/parallel-isa.h
index 3b783bd08d..5284b2ffec 100644
--- a/include/hw/char/parallel-isa.h
+++ b/include/hw/char/parallel-isa.h
@@ -29,4 +29,7 @@ struct ISAParallelState {
     PortioList portio_list;
 };
 
+void isa_parallel_set_iobase(ISADevice *parallel, hwaddr iobase);
+void isa_parallel_set_enabled(ISADevice *parallel, bool enabled);
+
 #endif /* HW_PARALLEL_ISA_H */
diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
index ab0f879998..a5ce6ee13a 100644
--- a/hw/char/parallel-isa.c
+++ b/hw/char/parallel-isa.c
@@ -41,3 +41,17 @@ void parallel_hds_isa_init(ISABus *bus, int n)
         }
     }
 }
+
+void isa_parallel_set_iobase(ISADevice *parallel, hwaddr iobase)
+{
+    ISAParallelState *s = ISA_PARALLEL(parallel);
+
+    parallel->ioport_id = iobase;
+    s->iobase = iobase;
+    portio_list_set_address(&s->portio_list, s->iobase);
+}
+
+void isa_parallel_set_enabled(ISADevice *parallel, bool enabled)
+{
+    portio_list_set_enabled(&ISA_PARALLEL(parallel)->portio_list, enabled);
+}
-- 
2.43.0


