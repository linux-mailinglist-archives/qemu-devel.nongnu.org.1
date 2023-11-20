Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE997F1F3F
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:35:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5BvU-0002sF-Jt; Mon, 20 Nov 2023 16:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Buc-0001vy-Kt
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:34:35 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bua-0003ao-Uz
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:34:34 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c87903d314so26309481fa.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516066; x=1701120866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIex8QjcVHMzUQGfRlZtiLonUpnm8G6I3FWEQ6zYP+4=;
 b=CFXuIQnsSbbPfKf+1+Ki7L0fZ7WmHCfWo2WgW/tfU+ikZbqAJ6m8Oy0Wwjeyl97Gxq
 SrFoivpcSewRLeH1NXDfI4a6a4H7j2z8buwcrVrBssYP9P+Iim+tb3i4ctSrEeX7H7MJ
 8+TfQudvl+vLXkQGPGHfyvAK3HFeIkevnz0UrVrPjbyqAvRkchaNo89VCKWbZmNUg86H
 dwxMRw5m2vcK6gmgAQI8hBff8ZU9C+ZTCFUfz51T0SM1DjuIxnKwoInxS9wa6nQrbmAp
 9bnmQKBPsmQIAVzvO7twOCUpgW0tprSQBO+esxVpjI8t5zRlXjgYpi7AFhq/hEtn2L9J
 tZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516066; x=1701120866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIex8QjcVHMzUQGfRlZtiLonUpnm8G6I3FWEQ6zYP+4=;
 b=WIJUrNHMUR0pjn8v+ivLKBthhWoJn5DGnWLyKxkuS7V75DnRja1sJJgxHubjP6kfVL
 d36acLJ+xbRtM/mmAh5n26sVIjvIOMb8pDcrGZYJAjPw9iu4hrQOT6jcy1FMmC1GhyWM
 zCg2uydFOlTc7ovnBRZPPfaVtp7A6V6X3wogXnMS/HCHmcuj7mlyiQZ15vYNVco3i3RM
 K+vop5z+L4nNzZWijwdhwCmn/cAGVjG7eYPF03L/uhhlwsaEKocyhhS/yD8iP3MGQker
 kT14sQqaDh9PoQjG+cPSPcwFlG/xVYXJSIzdEtCJ6IGR91W+6rvUCSj+JUU9Q7LK7arJ
 2wxA==
X-Gm-Message-State: AOJu0YyayL6CioflM6QLRqHwMkXkj8lW6CpPEODngYY4f4qtb7xNtbDX
 SNl+a3FVdq74Gg3iFSAAQrcJCcD5pStf/f6XVfM=
X-Google-Smtp-Source: AGHT+IEKwyStgC/1RuCdQLc7MNsMAQyl+TNdJH8aV+M6L+dpnANNsaETUJqoKnZMqncm+jtfCfXqiQ==
X-Received: by 2002:a05:651c:210:b0:2c0:20e3:990f with SMTP id
 y16-20020a05651c021000b002c020e3990fmr5660346ljn.10.1700516065839; 
 Mon, 20 Nov 2023 13:34:25 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a05600c198800b0040531f5c51asm14963797wmq.5.2023.11.20.13.34.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:34:25 -0800 (PST)
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
Subject: [PATCH-for-9.0 09/25] memory: Simplify
 memory_region_init_rom_device_nomigrate() calls
Date: Mon, 20 Nov 2023 22:32:43 +0100
Message-ID: <20231120213301.24349-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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
expression mr, owner, arg3, arg4, arg5, arg6, errp;
@@
-   memory_region_init_rom_device_nomigrate(mr, owner, arg3, arg4, arg5, arg6, &errp);
    if (
-       errp
+       !memory_region_init_rom_device_nomigrate(mr, owner, arg3, arg4, arg5, arg6, &errp)
    ) {
        ...
        return;
    }

and removing the local Error variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 1cccc4b755..6d1d315d0e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3654,12 +3654,9 @@ void memory_region_init_rom_device(MemoryRegion *mr,
                                    Error **errp)
 {
     DeviceState *owner_dev;
-    Error *err = NULL;
 
-    memory_region_init_rom_device_nomigrate(mr, owner, ops, opaque,
-                                            name, size, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_rom_device_nomigrate(mr, owner, ops, opaque,
+                                                 name, size, errp)) {
         return;
     }
     /* This will assert if owner is neither NULL nor a DeviceState.
-- 
2.41.0


