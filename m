Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FEA815FED
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 15:43:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEsLd-0005WK-73; Sun, 17 Dec 2023 09:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLY-0005Uq-08; Sun, 17 Dec 2023 09:42:24 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLV-0003NC-4s; Sun, 17 Dec 2023 09:42:22 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a2358c1bb99so6698766b.1; 
 Sun, 17 Dec 2023 06:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702824138; x=1703428938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UXgxyYazGtFHJXgLwHHblycanpLAmGhn25UftXLVRw=;
 b=dLMqZohKN9ypQ0OSDCEAgXmxE7sRsplRr6X5jVuZDi9lAO4z7AXuebLgEYx/kKOPae
 LbC3QiGktbzSmv1d6DiTLmbUD5xjKIgTtHXruVGk323LHq/SQfEDJY8XIi/GofPhWRKP
 CoEo32sTwac6C1Euyd1GV4aSI96uyqnBPY4ACM7klP3IWtvmmmsJjEA/sLNByaxBtKDR
 UHVb+l36nLeyOAdUwhmef3LSN/6IxqQIEZcwMkFvrPn6NgjCHRGqviHf6SF47WKv8vTa
 gEA05K1TWevsgwJF5CKRyoWocktv7NcgvXpbFLgAM8Z871X0szWVFC/IHrzsdSFZPN+a
 DprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702824138; x=1703428938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UXgxyYazGtFHJXgLwHHblycanpLAmGhn25UftXLVRw=;
 b=jgce2rZUceXuybEBvZRkmBMyj1hazjnHCCKWKgf7UILZP6oZAQMf2Z+/v8zITC2Evi
 L5x98dQPUrEJ5onbXiV7/vLb5S0NlgLF71kXy7+U80sG3nA25viBxePheosItOgAi+Pn
 6kDbyPLSRRgBkp5c6+tSNOP7DHhr6U8lpHN6gfFwzaHk7KQv4Z18gVUzKPYM3VLP+2BK
 yNdHJ+IMxLC9yrgGZP930S7HMFxbKKGNUFf1vzs6VBs8UppD9OR0GUo0f+nacRokDV0/
 dDXSu4oCJnmfiQaizb8PRR+U8h3KDgya4PaXmYrVWa3C1oCQUqHmSUpuY1mRTOi4vz4q
 XaXw==
X-Gm-Message-State: AOJu0YyiznVy0s0SPHrG2e7VejzhsuFrc4YJSdImda0d1s0NhGEK1S47
 TImC44sLgCGYDshahMvZ9OdzSaTFj2A=
X-Google-Smtp-Source: AGHT+IFlw9voTOF2j8k/bcfVtfiUuveLtLK1KfxClpMFjFqgE5NyTij7iTZcDv2NNKTRZznua0lg5Q==
X-Received: by 2002:a17:906:530b:b0:a23:5595:9f0f with SMTP id
 h11-20020a170906530b00b00a2355959f0fmr207469ejo.84.1702824138283; 
 Sun, 17 Dec 2023 06:42:18 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-162-117.77.11.pool.telefonica.de.
 [77.11.162.117]) by smtp.gmail.com with ESMTPSA id
 vv6-20020a170907a68600b00a1dff479037sm12996632ejc.127.2023.12.17.06.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 06:42:17 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 07/12] MAINTAINERS: Add include/hw/char/serial*.h to the "PC
 Chipset" section
Date: Sun, 17 Dec 2023 15:41:43 +0100
Message-ID: <20231217144148.15511-8-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217144148.15511-1-shentey@gmail.com>
References: <20231217144148.15511-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
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

The source files are already in this section. Add the headers, too.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 939f518701..69135a45b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1827,6 +1827,7 @@ F: hw/watchdog/wdt_ib700.c
 F: hw/watchdog/wdt_i6300esb.c
 F: include/hw/display/vga.h
 F: include/hw/char/parallel*.h
+F: include/hw/char/serial*.h
 F: include/hw/dma/i8257.h
 F: include/hw/i2c/pm_smbus.h
 F: include/hw/input/i8042.h
-- 
2.43.0


