Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA337C63D8
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:16:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn3k-00029D-D5; Thu, 12 Oct 2023 00:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3g-00024m-6r
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:24 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3e-0002Qi-F1
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:23 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-690f7bf73ddso433286b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083941; x=1697688741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqjiGsaDz9UWEJHOVnhfJCCD27Btz2De7qpxl32G050=;
 b=D9oQyTgGuVouF6Ivxn5wQ0zohNivGFqJ2h7o3BTS53mep2nURMPJgr9VHKpoA3CI1u
 rzhMcSGAwbSndtKhRHiUokoVV22ZAxy3S9yyfh6FCzeawy+aLaN929ldOnhzZWH7z+vb
 pl4FI8wyJjih7gYBRfz4TDCIuQpKtDrXbeSnjLuDnxk8RKlao9NVMOYLmUm7NOQ3KHJa
 lVEJleMObjX8J2Y+uoiaKQZRlCGBqF3KKDjUuXA4YnOtOljcVSewwmQ1V/ozS7LaFrUy
 6K37p8RJydAuS6DjEjzBeoiGk3EtsoRJWtARNZyjjAndWtHhMJ0ZzlgEHUSDQ6VEdK1b
 RSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083941; x=1697688741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EqjiGsaDz9UWEJHOVnhfJCCD27Btz2De7qpxl32G050=;
 b=nFflpUhOjQSTbSPI7unfyFzc27Im4T5lvyrG51fJ9wHQE52BpMF8oDKJzvAXoRrlNo
 2K1lGtuVWmelpERHrw1NyA6oqIhbse4S1JJBfEqYMzXgzbmEQNVEMX5tIa+hVfFC9wt8
 9FmpgjaMoGVp/8lopNFiAtkCU+voya71oEEDaQyr9dYICvrCMKQr7qWMJopFAhldRD7U
 7B9pX6Im10uxM0LZTQBJR5DruMBXFMu4wpjByBDwn46CRKuxr9T9x8118Uhf43xtXM94
 QURqZQ+w+82X1cmNJAaOF9SUNL2A1auKrJmw5wIK6aURvCrz5ThxOBF7QtIyfIIHZi7Y
 5YTQ==
X-Gm-Message-State: AOJu0YwxiiTOaJuq+v1/BrfUxWoDF88zQ+S28687VT2PblTVDbn2c4el
 MZMRJnPhkAToju8eiG7/Ln4pEMx7csxipA==
X-Google-Smtp-Source: AGHT+IH9wLHiAZkHjMw6i02YR7OFID3VZ44pkPikeZvJHI8MzmBUrc8HmR+1RanNwJSH9b9X7TPsgw==
X-Received: by 2002:a05:6a20:1584:b0:155:2359:e28c with SMTP id
 h4-20020a056a20158400b001552359e28cmr24641595pzj.9.1697083940743; 
 Wed, 11 Oct 2023 21:12:20 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:12:19 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alvin Chang <vivahavey@gmail.com>,
 Alvin Chang <alvinga@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/54] disas/riscv: Fix the typo of inverted order of pmpaddr13
 and pmpaddr14
Date: Thu, 12 Oct 2023 14:10:19 +1000
Message-ID: <20231012041051.2572507-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alvin Chang <vivahavey@gmail.com>

Fix the inverted order of pmpaddr13 and pmpaddr14 in csr_name().

Signed-off-by: Alvin Chang <alvinga@andestech.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230907084500.328-1-alvinga@andestech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 3873a69157..8e89e1d115 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2116,8 +2116,8 @@ static const char *csr_name(int csrno)
     case 0x03ba: return "pmpaddr10";
     case 0x03bb: return "pmpaddr11";
     case 0x03bc: return "pmpaddr12";
-    case 0x03bd: return "pmpaddr14";
-    case 0x03be: return "pmpaddr13";
+    case 0x03bd: return "pmpaddr13";
+    case 0x03be: return "pmpaddr14";
     case 0x03bf: return "pmpaddr15";
     case 0x0780: return "mtohost";
     case 0x0781: return "mfromhost";
-- 
2.41.0


