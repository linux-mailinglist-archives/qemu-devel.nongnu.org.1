Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 140F3815CB8
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 01:16:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEeoC-000603-RQ; Sat, 16 Dec 2023 19:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1rEeo0-0005xp-Qi; Sat, 16 Dec 2023 19:14:53 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1rEenz-0006ym-An; Sat, 16 Dec 2023 19:14:52 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-203ae9903a6so18359fac.0; 
 Sat, 16 Dec 2023 16:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702772089; x=1703376889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bvzLD6Vwnrwo/4f7Qk4uX9Y71nZI8dp7ZsmYIzGViqg=;
 b=Zcr5HYA4OROV00sAKzG43fV2QP6UrqeSZvXR/lbz6+VEdBfKS0zEOy/xIaqW0Bpp19
 G4QQjGde1EMsO8HOBBK3xENxxperMHfHFNfved4LtlejcwGS9lzLAuKteXHyHMaMTkyH
 MHLjJJ3icQSgH2qxtCYJob1mPeSNgXzfD8IULvE7L4VlexWXd+leHS/covJ8swViaQ4L
 Y0cLj5OX2qUCWo5/NG3IhSohU/kfNh7Dg4PGEfh9l0Tn4SvhqES8XCjG6wFkSxqTajDD
 3JT1WR+aaAgexpZjN9wTyI3HXQwRrjKAnA/T+HWDo+pjvrmVz/JeSTowVQ7SC+SwdYRz
 7i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702772089; x=1703376889;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bvzLD6Vwnrwo/4f7Qk4uX9Y71nZI8dp7ZsmYIzGViqg=;
 b=uT47uRr9xO4LRu2wMvsXS5iFnGWeKrgepLS7Ei1vYHp3PV7aIw7NrFHl3vyl5Z3mAr
 wuyP/FXjE+kuxJ/77sWQxHohC0tBDRQ376f+y5CB2sTxtVA1dMy188MBDO7qNDfYEZBS
 wDYAMsx8waChJDjWHwJDu7/8FCRMC08CAVc4EsHuIkeHMmQ7CFfRKhKV8n5wUuD7YP39
 ZvTjJ8F33BdV/4CEzwtd4uuHNIoYLcUVfkIuvny5G6Nx/s13spQ+ZydL5GP4f/pjXkw3
 /0/9g9i4wpgW60TlxpreRqJr9fVGfMdMQvcy55OI6EDqHPxW2zOmgng5hLW7M7DAkD1C
 YvEw==
X-Gm-Message-State: AOJu0YzXfNay4ekwpAy9p8uZxHkKaV5pUVP2y10u0SkKs0I69e3/auF2
 CtYKvqRSCoOa+6+Z95f7g8Y8fv6qc0I=
X-Google-Smtp-Source: AGHT+IGsFDXoj7RvTv3CFkwjPc9MgfEgDnL3LIAIl9hpEht9Q1+G1VKJbvx7+KRuvR2BuVUpcXdrVw==
X-Received: by 2002:a05:6808:f09:b0:3b8:9dec:1b7f with SMTP id
 m9-20020a0568080f0900b003b89dec1b7fmr14869606oiw.5.1702772088769; 
 Sat, 16 Dec 2023 16:14:48 -0800 (PST)
Received: from dhoffman-NUC13RNGi9.hsd1.or.comcast.net
 ([2601:1c0:577f:e480:d340:aa97:1578:c53f])
 by smtp.gmail.com with ESMTPSA id
 i17-20020aa787d1000000b006d3b2008406sm1425873pfo.50.2023.12.16.16.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 16:14:48 -0800 (PST)
From: Daniel Hoffman <dhoff749@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Daniel Hoffman <dhoff749@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org (open list:Virtual Open Firm...)
Subject: [PATCH] ppc/spapr: Fix ubsan warning with unaligned pointer access
Date: Sat, 16 Dec 2023 16:14:40 -0800
Message-Id: <20231217001441.146344-1-dhoff749@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=dhoff749@gmail.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Found while running QTest with UBsan. Unaligned pointers appear to be
valid, so moving the read to an explicit memcpy to an intermediate.
---
 hw/ppc/vof.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index e3b430a81f4..609a51c645d 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -646,7 +646,10 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
     mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
     g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
     if (sc == 2) {
-        mem0_end = be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof(uint32_t) * ac));
+        /* Pointer may be unaligned */
+        uint64_t mem0_end_copy;
+        memcpy(&mem0_end_copy, mem0_reg + sizeof(uint32_t) * ac, sizeof(mem0_end_copy));
+        mem0_end = be64_to_cpu(mem0_end_copy);
     } else {
         mem0_end = be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof(uint32_t) * ac));
     }
-- 
2.40.1


