Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AA6826192
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 22:07:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMDrs-0005if-Ti; Sat, 06 Jan 2024 16:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDrp-0005gO-Vq; Sat, 06 Jan 2024 16:06:06 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDro-0001B7-Cb; Sat, 06 Jan 2024 16:06:05 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-554fe147ddeso699752a12.3; 
 Sat, 06 Jan 2024 13:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704575161; x=1705179961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BO3joJYDTtGUerfBs3WaLe5gIZcBp9HzTmPOq+TE/bA=;
 b=dQ6Sbkj/jhYOmhqYCQ7QuApRs9soCMHda5EgaqnFOEl3fCOkE8dw4QpnAOOQbqz3ws
 CzV9MIwzHp9IbeUD1a8AitK9/iX9vv5nAFo1fSdfIFTt7wIeRVRdngc5YYVOlnLBnM8x
 U2s0kwSOGzmSqvf45lIXQ15ngRguHyJv1CSZPHVqGsK9sXkwtxiWN25A2+8Roh72kXiN
 gGm/n/R3DVLNaDYHyvUfWriuZOiLUf185sxiqzwSy+F2qavy9gbNbaFJgjTW4KBc9T2W
 lj4p9XrA3w2hBYxj4go5SAJ7mheqc3xTASG2TT2tU+6XhOmzopXRL0DMb4VCRdxBvxo2
 bO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704575161; x=1705179961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BO3joJYDTtGUerfBs3WaLe5gIZcBp9HzTmPOq+TE/bA=;
 b=D0YQeaLcjWY4hbc15x1ISqCmZEG8X7di1l5+CggMrQJVatJPuNIsgHsogySgJ57PmW
 4thmDwMs0yO/Zz37aK6PzJCbIzcuDNsZHPpawytdPjjnUx3NEjypDZk3T1UB3I57wgGo
 g/Qy1BH0WvUhZWjKHVIs2zRPLMNiv7jjyfIMxJMpfB0cpweRSMxozBPkoKZIzKhSSisS
 nvmhiUh7vs63iTbjHqn4zcjkTMd+fw9WEl2QnVDGFTO1KimPwRrITvEQGff9E/JHg5iM
 ZtQU+5o8Svqapc54p8JDIoiIJTT5pxfq+1KwxDYM68iLIbdIcaN8MblcziuR7rOSgTe0
 8Biw==
X-Gm-Message-State: AOJu0YwUhxuLT2/xjat9qV/eb0rekB1C8Jk2eNegtVNXAVDWUV8TbemJ
 o/eQdRpOsjmEdDC0wQfweb9RePeX61k=
X-Google-Smtp-Source: AGHT+IFifs91QStc18KDRYn+mCVXA1173sWpbHPJyqCQAfvLTfGDTDLiK4Jn9Dbn1N/T5MSrbigOyw==
X-Received: by 2002:a50:8d4f:0:b0:54c:d9c5:f9ef with SMTP id
 t15-20020a508d4f000000b0054cd9c5f9efmr454637edt.8.1704575161062; 
 Sat, 06 Jan 2024 13:06:01 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-174-094.77.11.pool.telefonica.de.
 [77.11.174.94]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056402195400b005576f4471besm624922edz.42.2024.01.06.13.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 13:06:00 -0800 (PST)
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
Subject: [PATCH v4 09/11] hw/char/parallel-isa: Implement relocation and
 enabling/disabling for TYPE_ISA_PARALLEL
Date: Sat,  6 Jan 2024 22:05:29 +0100
Message-ID: <20240106210531.140542-10-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106210531.140542-1-shentey@gmail.com>
References: <20240106210531.140542-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
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


