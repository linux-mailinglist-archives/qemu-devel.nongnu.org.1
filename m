Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE0B815FF4
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 15:45:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEsLO-0005O0-T6; Sun, 17 Dec 2023 09:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLM-0005Mk-3x; Sun, 17 Dec 2023 09:42:12 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLK-0003K9-Bm; Sun, 17 Dec 2023 09:42:11 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3363aa1b7d2so2004412f8f.0; 
 Sun, 17 Dec 2023 06:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702824127; x=1703428927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+HNw7Ppj1pyazd33OYLXTw6Gr10jgLyGzuUCcv7qrv8=;
 b=IPVsi/JYeDE7EyjpNsTm9PQWMZCuVDUtZm/u8IdAlmaeum61YcPcc6GtzyvPID9ivn
 Vaj8SnYbOIF9W24YF7Pn9xJNr59rYB3ora1KDPeBJwhY9nGK1lp09yrwt0osi5UdnYZE
 IJR5cwsgT3Ct8lFcjICt2XPbEoUwX1dAgIG6yGgmvJNVucuGc7NGPT8Vj++djPW3Oyvc
 93dXjIBtGdXaf4iDDENv4LQ6Ml2SJ2ZDV7Z0MZ4wYcUIHyGcP1VCbEGRbdKFx4Eq8qNG
 X7E43PdIYJh5PyTsUU61MSzNmGrIQz9BkqXkCg9ctc/bc0Dq7igvuoEm3aG4d+MffxkG
 hn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702824127; x=1703428927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+HNw7Ppj1pyazd33OYLXTw6Gr10jgLyGzuUCcv7qrv8=;
 b=S0PWV1XtluRSCr4PLoBynD6aXTnab9W+cs3y938gyZ42YzwKCAJPjiUdU/Q9fQ/Fmj
 6g1l8lSxFScf+l0ybgG8ZwI++JQqs1h9WqIMxTR6mKRJrAOsY/upExpMBycGx7bK/ZHX
 8k5vxD+dUCzq/wVFgoj54+k9q+t1vpkoc5w0U93/9D3eH29HiEyNLMHh/Tt6ond+cx6I
 ITugfeZV22lo7K+SLYiG34IrN6WjP4BD+fi9UBzf8q0GrYT1H6hs+1iul4ShLl6B1B9c
 sKYsgJ+uyASCZFdj57qct3XDLEgnNXE8Y9bmRph3qJxFa5TWQjHoplG8mrIz7MpzfL62
 GRbQ==
X-Gm-Message-State: AOJu0YwfJus2op2hw1sxvVHNlXl6LYQWQ/fbPcK7Dp9lQ7/IMiePPI2H
 VGnxbm9mhXnPPYUxAKoG7/sMAIun1NE=
X-Google-Smtp-Source: AGHT+IGz7VZqldVQXWluuJ0g5lP3e2P1GjNIeOz+D1Z62VGFY2RRLSa+5W3PRSyNVVfOXntsFNxOEA==
X-Received: by 2002:a7b:c8c8:0:b0:40b:5e59:99b7 with SMTP id
 f8-20020a7bc8c8000000b0040b5e5999b7mr5370524wml.215.1702824126964; 
 Sun, 17 Dec 2023 06:42:06 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-162-117.77.11.pool.telefonica.de.
 [77.11.162.117]) by smtp.gmail.com with ESMTPSA id
 vv6-20020a170907a68600b00a1dff479037sm12996632ejc.127.2023.12.17.06.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 06:42:06 -0800 (PST)
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
Subject: [PATCH 02/12] hw/i386/pc: No need to include hw/block/fdc.h in header
Date: Sun, 17 Dec 2023 15:41:38 +0100
Message-ID: <20231217144148.15511-3-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217144148.15511-1-shentey@gmail.com>
References: <20231217144148.15511-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x429.google.com
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

Only the source file uses fdc.h but not the header, so remove it from the public
interface.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/pc.h | 1 -
 hw/i386/pc.c         | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index a10ceeabbf..48097c9124 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -5,7 +5,6 @@
 #include "qapi/qapi-types-common.h"
 #include "qemu/uuid.h"
 #include "hw/boards.h"
-#include "hw/block/fdc.h"
 #include "hw/block/flash.h"
 #include "hw/i386/x86.h"
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 29b9964733..0d732b7530 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/i386/pc.h"
+#include "hw/block/fdc.h"
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
 #include "hw/hyperv/hv-balloon.h"
-- 
2.43.0


