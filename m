Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB96831C1F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:14:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQU2O-00046u-VJ; Thu, 18 Jan 2024 10:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0H-0000Cm-Qj; Thu, 18 Jan 2024 10:08:27 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0E-00089G-MO; Thu, 18 Jan 2024 10:08:25 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d70b0e521eso4106805ad.1; 
 Thu, 18 Jan 2024 07:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590499; x=1706195299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rk+uoSRvrBIH9TvmGVZBjV+QTWZEk05mSjA1QL8Ws5A=;
 b=nNq8eeLhHh7kd5e71vm5aztsdC+492F1+0tcjtIBKNc1JtmKG5hSo2C2F9L2I3/7vl
 dq69y0771tqesbfecvgGp9WVw8BcR9J4wBfgBKhTJZDEorld8B70vibOkYyuMJeosoVz
 Dy5oYOroONnzik6gbrPt1mlzBcvpXXExqvaQg7171JOOK+XKywvkoGdx+G6hnhzgD+f+
 PKWMZ1YCByFclBAZhQhLiDkTk7IZeiDts4C9HLtBz8wFwLAkkZHKSSqEwY5M2kbDQ2QH
 AOpAA5BjwPFS/XR90CeVRDa8zrjkO+sgUmf1ciqE7fnQhEf104Yz2+10Yrs2Fa/pmS8K
 iqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590499; x=1706195299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rk+uoSRvrBIH9TvmGVZBjV+QTWZEk05mSjA1QL8Ws5A=;
 b=LqVC8k0WfCFAu9gOOecdRL0Fnh/qmlfA34BoeLJ1YP9YLaQUrUcyxBNuVWMGONzOqI
 vrOhPcq9Cqa0V0xZHtgrq6B5+xvMljspe5HVkEdJPa13DqlmBev1KHCHqpo05PGn531o
 9UO42Mc8br8XgUAw3ZMln8iRsy92IpwpXyf/a+lN4ngPubT/bW+p1cTSTHus4a/SE1f+
 q4kBxGkJTr+CgAPVChhCZ3ddJAY/J1iM4AWjc4Fjk6BOxHeIu65aSKf2aTiPGQQ3dwPd
 y7d4hnzDzvnsiiOSlRc0n83RWRL9DecsbhNRDMNp9fpV6Dy44FbaDQqfhFloo7/fO09t
 T4Pg==
X-Gm-Message-State: AOJu0YybHZ/9S8NDrowUus+lpivXNx1JscU/4pOjZvEBvdkmLiUaZYVt
 0RjVlmPLtQV/Y1YbnR7i5c6FfuaIRUrZggkjVL1sfiH5iARH0Pju2iCUHDJF
X-Google-Smtp-Source: AGHT+IGmAlbjeyOCE26DNjxxnMb/YzBtMAYQ2d3amMFvXSpznKDr66norf5cTtaLjZD8SP+xtRuwjw==
X-Received: by 2002:a17:902:b211:b0:1d5:e89a:cd90 with SMTP id
 t17-20020a170902b21100b001d5e89acd90mr932908plr.137.1705590499062; 
 Thu, 18 Jan 2024 07:08:19 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:08:18 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 18/26] target/ppc: BookE DECAR SPR is 32-bit
Date: Fri, 19 Jan 2024 01:06:36 +1000
Message-ID: <20240118150644.177371-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

The DECAR SPR is 32-bits width.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 421900cd11..8287494c39 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -792,7 +792,7 @@ static void register_BookE_sprs(CPUPPCState *env, uint64_t ivor_mask)
                  0x00000000);
     spr_register(env, SPR_BOOKE_DECAR, "DECAR",
                  SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, &spr_write_generic,
+                 SPR_NOACCESS, &spr_write_generic32,
                  0x00000000);
     /* SPRGs */
     spr_register(env, SPR_USPRG0, "USPRG0",
-- 
2.42.0


