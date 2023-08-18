Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F087804D7
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 05:39:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWqJE-0003e0-Ho; Thu, 17 Aug 2023 23:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqJB-0003Ls-V7
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:37:58 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqJ9-00065G-Oe
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:37:57 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a81437be28so322600b6e.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 20:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692329874; x=1692934674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qO1yEdU7iS/VbjYRRavbUpYLAuQ3emAAsFT33khNfis=;
 b=CmkVxrz1XH8qJyY+4IOjD9gm0PoSJmvFTVi6NPQl6yVuCLxBD+6oLa/I0jny/BkCoc
 6/u3m2jKp+VCnQZrYHI/RqB1whFiTh0c0BLknPyAdHNLGDQaxv/aiyCwQnaWEfeZwSqG
 vfHusMpGLOLTIQN+QP1dF09qjaT8xmYPhbvGVdPlfbMl2890K5fTAJ8t2+wuhYcGueZa
 y2dadY7/4WTXdSzQ/RYFoEGr1ITqH/B5tCOeJJScFEhl/RwXlmOpN0kobcGPUhrttMCf
 kHQC5Cvg23Dkf2qKQCjfsSzypX/EcsFvVkts38GIn4hpo/5tw6jtE07XhxQiNDIK0wuv
 CylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692329874; x=1692934674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qO1yEdU7iS/VbjYRRavbUpYLAuQ3emAAsFT33khNfis=;
 b=Obyx9v5TtkpIkqcespgmn3ZpXUDkaOsjqdPXWGCSg3HjtTiz3b2a49pJG+XReN3Jyz
 6LK3+5Oqlvcsh6Hy5ayu8U2jTwpjrXL66oJ6UvZ5flN/swluxi9ebfdeSwaxnDkYPMzt
 bTNSwXhf/67thfKjV1k9CP/52RQ+KfPSAaHjs0IOn35j1jC/EXeCa/h+Mvo9fAoh3dm2
 SRddf3Ezz3F7q8zKwzgLFhb/bqKkxfIu1D6frF0JIPANaJMRXfegW11w2PxZkv99c9XY
 u+pr5HHNl7R6VChKedjoo6VlhrfJ4qzCxW9Z+I31lgtQ0Bl32JHefdcQRf7/8XCzcBtz
 4dVg==
X-Gm-Message-State: AOJu0YyNuYk6ve+0bGDs10WFvoFrA35DuObk/qYYnk2l0Rek5shtaUOM
 34nVtAzFU4lfmdyXJVGu8EI/sw==
X-Google-Smtp-Source: AGHT+IH6yG2mD3G6f3oUGtEDm+3qr0tweiOldEreaegPLzsko2oXjV8Hknc7n2+QjG9x9CHZbkBElg==
X-Received: by 2002:aca:f08:0:b0:3a8:1c07:17d3 with SMTP id
 8-20020aca0f08000000b003a81c0717d3mr1531581oip.19.1692329874792; 
 Thu, 17 Aug 2023 20:37:54 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c24-20020aa781d8000000b00686a80f431dsm484135pfn.126.2023.08.17.20.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 20:37:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PATCH RESEND v5 19/26] target/ppc: Remove references to gdb_has_xml
Date: Fri, 18 Aug 2023 12:36:38 +0900
Message-ID: <20230818033648.8326-20-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818033648.8326-1-akihiko.odaki@daynix.com>
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::236;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

GDB has XML support since 6.7 which was released in 2007.
It's time to remove support for old GDB versions without XML support.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/ppc/gdbstub.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index c86b7055ca..7e3b67a234 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -54,12 +54,6 @@ static int ppc_gdb_register_len(int n)
     case 0 ... 31:
         /* gprs */
         return sizeof(target_ulong);
-    case 32 ... 63:
-        /* fprs */
-        if (gdb_has_xml) {
-            return 0;
-        }
-        return 8;
     case 66:
         /* cr */
     case 69:
@@ -74,12 +68,6 @@ static int ppc_gdb_register_len(int n)
     case 68:
         /* ctr */
         return sizeof(target_ulong);
-    case 70:
-        /* fpscr */
-        if (gdb_has_xml) {
-            return 0;
-        }
-        return sizeof(target_ulong);
     default:
         return 0;
     }
-- 
2.41.0


