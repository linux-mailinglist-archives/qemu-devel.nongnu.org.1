Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AE4815FE9
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 15:43:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEsLU-0005T9-RS; Sun, 17 Dec 2023 09:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLR-0005Po-5M; Sun, 17 Dec 2023 09:42:17 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLP-0003LQ-24; Sun, 17 Dec 2023 09:42:16 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a234205785dso55750966b.0; 
 Sun, 17 Dec 2023 06:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702824131; x=1703428931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FV1MBDBXespX2d6W0/chCL4K0RVTNUu9w1SmuUwBMtc=;
 b=fdUp4K5DDqieVjTtGBiyIXjgFLcAUelDplkIu7lt5z4s5gvenX64jPakPuq3e/Kv5f
 u9DhaVpjxwz2Fd0RvY0G7mhLXZnCgl7EjhIVlzpMrVFrGphpRnsr96uts6lPgZ94tKll
 HXshlOMwRbiYBgQA1DhY8V1soq3SLBLqVoQYQCVpI1e7cixg/886R8T6Sn/DzyLKwCqP
 7gfXWkXP7cDHaWAgr2rUEYI3Kk1XrH50j2KFRruzd2b4BxVPUifMXgWkJbvnRJaQ3N1N
 IcidYjMSWJOWnnEUVG98Qd9rPhn0poYEZ2rjIakzpZIJseku/LxBGZ5b6MQaIbEejU1u
 OXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702824131; x=1703428931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FV1MBDBXespX2d6W0/chCL4K0RVTNUu9w1SmuUwBMtc=;
 b=vilZouzp59IzJuw/zWAz9kUhjlHGmVRss6ZcKh39nwwlnejfRYfm3qV+ZVI62wbvII
 +7fknt9gaEdZ4oxd7RNrJnjZzanZz1uCCicucnyK+XvvA/LLhV0uN0n/Mwu0MEtczeTH
 sshxJsCYYTUh7y6J8CoA4E+9C+vEjxtz5WLrNyM3mFlLL/dfxeEw/6lOoRgDVZwh1qft
 7H+t4lTQAx0tmPc5TpDtFxBGjhNO/HnzavfLrMoYvLiH0HZfgWySCa3u4WI8tyTn4hUJ
 lE5WkMYjuPD+qrj8oghFebGpuDrwgZPSChb+ZyRH2owbA2XATrHifjYJ6/03wJGs6YIk
 48Eg==
X-Gm-Message-State: AOJu0Yxef7jmmWP5gqpAiZjy0IbWO9wMrVEa6CMmw2JCRmZ9QeBIq1D5
 LvANnOTWDO9A6R//jKctEdbYDVZ1UJQ=
X-Google-Smtp-Source: AGHT+IEpRNbR2RlNeXZtLKe0+gyqn5g/AtXn23hLVt9lmKfci9hslrFiAb1lF/4KgpF3slNZpB5Cog==
X-Received: by 2002:a17:907:c30f:b0:a23:59ea:764 with SMTP id
 tl15-20020a170907c30f00b00a2359ea0764mr2066ejc.242.1702824131450; 
 Sun, 17 Dec 2023 06:42:11 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-162-117.77.11.pool.telefonica.de.
 [77.11.162.117]) by smtp.gmail.com with ESMTPSA id
 vv6-20020a170907a68600b00a1dff479037sm12996632ejc.127.2023.12.17.06.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 06:42:10 -0800 (PST)
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
Subject: [PATCH 04/12] hw/block/fdc: Expose internal header
Date: Sun, 17 Dec 2023 15:41:40 +0100
Message-ID: <20231217144148.15511-5-shentey@gmail.com>
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

Exposing the internal header allows for exposing struct FDCtrlISABus which is
encuraged by qdev guidelines.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                                       | 2 +-
 hw/block/fdc-internal.h => include/hw/block/fdc.h | 4 ++--
 hw/block/fdc-isa.c                                | 2 +-
 hw/block/fdc-sysbus.c                             | 2 +-
 hw/block/fdc.c                                    | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)
 rename hw/block/fdc-internal.h => include/hw/block/fdc.h (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index b4718fcf59..939f518701 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1945,9 +1945,9 @@ M: John Snow <jsnow@redhat.com>
 L: qemu-block@nongnu.org
 S: Odd Fixes
 F: hw/block/fdc.c
-F: hw/block/fdc-internal.h
 F: hw/block/fdc-isa.c
 F: hw/block/fdc-sysbus.c
+F: include/hw/block/fdc.h
 F: include/hw/block/fdc-isa.h
 F: tests/qtest/fdc-test.c
 T: git https://gitlab.com/jsnow/qemu.git ide
diff --git a/hw/block/fdc-internal.h b/include/hw/block/fdc.h
similarity index 98%
rename from hw/block/fdc-internal.h
rename to include/hw/block/fdc.h
index 1728231a26..acca7e0d0e 100644
--- a/hw/block/fdc-internal.h
+++ b/include/hw/block/fdc.h
@@ -22,8 +22,8 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
-#ifndef HW_BLOCK_FDC_INTERNAL_H
-#define HW_BLOCK_FDC_INTERNAL_H
+#ifndef HW_BLOCK_FDC_H
+#define HW_BLOCK_FDC_H
 
 #include "exec/memory.h"
 #include "exec/ioport.h"
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index 6387dc94fa..7058d4118f 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -39,6 +39,7 @@
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "hw/block/block.h"
+#include "hw/block/fdc.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
@@ -47,7 +48,6 @@
 #include "qemu/module.h"
 #include "trace.h"
 #include "qom/object.h"
-#include "fdc-internal.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(FDCtrlISABus, ISA_FDC)
 
diff --git a/hw/block/fdc-sysbus.c b/hw/block/fdc-sysbus.c
index f18f0d19b0..cff21c02b3 100644
--- a/hw/block/fdc-sysbus.c
+++ b/hw/block/fdc-sysbus.c
@@ -28,8 +28,8 @@
 #include "qom/object.h"
 #include "hw/sysbus.h"
 #include "hw/block/fdc-isa.h"
+#include "hw/block/fdc.h"
 #include "migration/vmstate.h"
-#include "fdc-internal.h"
 #include "trace.h"
 
 #define TYPE_SYSBUS_FDC "base-sysbus-fdc"
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 2bd6d925b5..0e2fa527f9 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -39,6 +39,7 @@
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "hw/block/block.h"
+#include "hw/block/fdc.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
@@ -47,7 +48,6 @@
 #include "qemu/module.h"
 #include "trace.h"
 #include "qom/object.h"
-#include "fdc-internal.h"
 
 /********************************************************/
 /* debug Floppy devices */
-- 
2.43.0


