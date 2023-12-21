Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A6081BA47
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:11:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGKf8-0008WQ-VX; Thu, 21 Dec 2023 10:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKet-0008Hr-Im; Thu, 21 Dec 2023 10:08:24 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKeq-0004OV-EA; Thu, 21 Dec 2023 10:08:23 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5534abbc637so1083996a12.0; 
 Thu, 21 Dec 2023 07:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703171296; x=1703776096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BO3joJYDTtGUerfBs3WaLe5gIZcBp9HzTmPOq+TE/bA=;
 b=G1ocIemBrYqYRIWuhSebdpusH+cbQw7h+1bdj+rzaLMdV/NpKv+KVZ8xIRtrPS3wSk
 oC9GqkNcuhH960eo7O2raNAyP8rXvOuh7kXxTTyI791kx2pjuqnDOAx6fiUHPgmjepr1
 FyvbwNFDHouy8hRshuG06Lt623TujYUdYEmOvCotMvkXpPi7IS7u/+sacoIuvRoxOMiO
 NyEpVG04lCY5I22Upb+XhyuHJ8Yp731RX2PtFxRfYtLnRO3lf23P0nCRGLY6I+Cnd6kq
 1HeCL5kJ4VSdNp/jvcJAshCB0ZrfrEUmFsc78P4H/weONGrNcdxu6nwPVp0WLj+ChspI
 2Iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171296; x=1703776096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BO3joJYDTtGUerfBs3WaLe5gIZcBp9HzTmPOq+TE/bA=;
 b=dHj2k5gYnC0Hd+oSuxhR73pNPzfYyVlTCLMzf1c6BCOblgnJm3IKPeYC4iRDV7/VxY
 WbtsCY7+VxY2/TNGxunkBlN95NU/trA+mZ2rA93yYkkhis2qaoxI1GIAITtOmzWSckw5
 NSVJ/HP0RaGCr7rrpGuJlXFgWQneZ2qUzvBTRPZGInVukd6PzoBdLCH0xWnRSuLEQAEU
 duP7qfwF/lAO9+tPSwx1gOJLixlHNFavMX+Sa6+bbv9jSITTCFVsj1YtHbcqn/YMI6Fh
 8DDUXJtdnHLUhEN+WhBCWedyYqJn5pB1mmuI7LBVcd8IZTLeZbgLT8a+aZEa6OSy2PKv
 5dVA==
X-Gm-Message-State: AOJu0Yyug/iPYd4gsIYz5B6zCAOGPuIYfKXwYAL8WchbTUcrWIia+p6D
 4+j/oTyJWdsZmpNKlsXIGmu2Y8BFptzlng==
X-Google-Smtp-Source: AGHT+IEBB87s9FCGSUtqFl4nYjhemJodzncrkMjNs40N8le6X5tLHi5sDdECFZ/KT72OO+I19DHysg==
X-Received: by 2002:a50:c908:0:b0:551:12f7:84e with SMTP id
 o8-20020a50c908000000b0055112f7084emr9254468edh.28.1703171295970; 
 Thu, 21 Dec 2023 07:08:15 -0800 (PST)
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a056402241900b00553b6b5bb44sm1264264eda.67.2023.12.21.07.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 07:08:15 -0800 (PST)
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
Subject: [PATCH v3 09/11] hw/char/parallel-isa: Implement relocation and
 enabling/disabling for TYPE_ISA_PARALLEL
Date: Thu, 21 Dec 2023 16:07:48 +0100
Message-ID: <20231221150750.5435-10-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221150750.5435-1-shentey@gmail.com>
References: <20231221150750.5435-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x531.google.com
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


