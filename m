Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECC37F1F55
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:39:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Byy-0003Zh-As; Mon, 20 Nov 2023 16:39:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Byw-0003ZG-VU
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:39:03 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Byv-0004hC-DL
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:39:02 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-332c7d4a6a7so848313f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516339; x=1701121139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LccZbSfVbRBJBP3hDaCoexHeaPDYfSMKOISo4dOr+pE=;
 b=MADWJtaXVoHsCWOD+zESN/3a8CQwB8y6UkhtV7nLTVfXU3i2kP7GfweaI+eeaiQR3+
 Frwu/P2NeKpWy9e4KUEAxvacAnGmHx1Q8+R4oNJh/nK8Vsm1Bz5sjCCXmbrkAUqpsUqk
 Ur19VJKguk4i8gqRs6TR8iyjj4PLZelZ0YKUJP/lQIIMty4mKWFdamF6egri1XG7bjy0
 v9krfBWO3Zz1H9ACxpFWzMWCdbyauTAiarahT4BL8IxHDoDeKFeXkzh+Fm9aFhBcFvyA
 q0jYHHFpM6BRV824gmgzF3gvPhpucgOpZsnSocLyd0lpYktmZslluLmD2ZWbgYAOQLq3
 nkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516339; x=1701121139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LccZbSfVbRBJBP3hDaCoexHeaPDYfSMKOISo4dOr+pE=;
 b=td6QJmM/cms23XynU+Qx2/oGR9TRez5uQ7LPgxEWeVUeW+7F0dV+zx0rG4llv7SCTk
 nYMNlfGQBRdXF3sH73EnWwvoSGl6t7w4lKaXCl3xnmFV5iAkTFK40YtvavdO1t1AkzDu
 j8jHc7CRtf2GCWhAdSnRMkDayZ3QYXOhiyQpiwvbNQSfMFa0GT8imos+S+iOq3JIGiYp
 K2risk8rprsgBelq4BQWNqypFqTlAT/yBLHsN7VktpQYtVmsTjaZbAjs5pfIXZ5KPIS/
 j4NXOy4NeEhMkjjAKw6mFwI1dbBw+njYr54LV9NcegLvxpZ/3oli7nhQn8MMQi42ilje
 WyKQ==
X-Gm-Message-State: AOJu0YzmxBLVQuwBbAWOPJoWQ1Y25e0xTVSmpsnyGH39b6F34V8G7Zz8
 1e+RETGXiwYPUdyj3ev3XJbvi5/TKDmIaP4dI94=
X-Google-Smtp-Source: AGHT+IFuC5KpbudFIGEI1t98ppu9xYnyNZcQbOHvVTAB0mfWOCjKv5jzgnanuXJ3VFe99/4jqBQgfg==
X-Received: by 2002:a5d:59a3:0:b0:332:c4ce:5347 with SMTP id
 p3-20020a5d59a3000000b00332c4ce5347mr3132687wrr.48.1700516339396; 
 Mon, 20 Nov 2023 13:38:59 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a5d6404000000b0032fc5f5abafsm12233916wru.96.2023.11.20.13.38.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:38:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-9.0 23/25] hw/misc: Simplify
 memory_region_init_ram_from_fd() calls
Date: Mon, 20 Nov 2023 22:32:57 +0100
Message-ID: <20231120213301.24349-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Mechanical change using the following coccinelle script:

@@
expression mr, owner, arg3, arg4, arg5, arg6, arg7, errp;
@@
-   memory_region_init_ram_from_fd(mr, owner, arg3, arg4, arg5, arg6, arg7, &errp);
    if (
-       errp
+       !memory_region_init_ram_from_fd(mr, owner, arg3, arg4, arg5, arg6, arg7, &errp)
    ) {
        ...
        return;
    }

and removing the local Error variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/ivshmem.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 0447888029..9a8b9e2fd3 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -476,7 +476,6 @@ static void setup_interrupt(IVShmemState *s, int vector, Error **errp)
 
 static void process_msg_shmem(IVShmemState *s, int fd, Error **errp)
 {
-    Error *local_err = NULL;
     struct stat buf;
     size_t size;
 
@@ -496,10 +495,9 @@ static void process_msg_shmem(IVShmemState *s, int fd, Error **errp)
     size = buf.st_size;
 
     /* mmap the region and map into the BAR2 */
-    memory_region_init_ram_from_fd(&s->server_bar2, OBJECT(s), "ivshmem.bar2",
-                                   size, RAM_SHARED, fd, 0, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!memory_region_init_ram_from_fd(&s->server_bar2, OBJECT(s),
+                                        "ivshmem.bar2", size, RAM_SHARED,
+                                        fd, 0, errp)) {
         return;
     }
 
-- 
2.41.0


