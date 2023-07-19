Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7FC758CC3
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 06:47:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLz4Z-0001nl-7S; Wed, 19 Jul 2023 00:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qLz4X-0001nF-AR; Wed, 19 Jul 2023 00:45:57 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qLz4T-0005KT-SP; Wed, 19 Jul 2023 00:45:57 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b8ad8383faso51477115ad.0; 
 Tue, 18 Jul 2023 21:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689741952; x=1692333952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ATO9Xwc/nXiXTWCBg94xeSj5Sbg9vHjnKWEy2MsvNyA=;
 b=gtn95oqGKXIL7HRNsiKHYcM9D4NMhxcY1wquPI1ZMXBG7vnKYbnv1WfBnWrlxsfeTq
 2x61FXbodRUWRwEUam0ZpQj9+Tb/XEZGoODvlDe68a+S/ZTw6SWlVPsZ4ATcGaMW2+Za
 zr3fzM39ETuQ71n3RbrgE3kPEtav32HO2JPDVuVO6mvMb3p67qopbe+F5d4qzsdqopRh
 vz1Bj0EVymXXolqVPJm4+jDT0r5BlvD+xYIFJ3hp14pJ8+EhR5OGmZkc4o6RfxbRqVR0
 LYykhBjwlxogsEF5pkqy/mJgOl5a7ilRxIRZFM32E2lm+lkqyw1NYX0HlYsJyfR3mxxG
 Iepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689741952; x=1692333952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ATO9Xwc/nXiXTWCBg94xeSj5Sbg9vHjnKWEy2MsvNyA=;
 b=a/MCXVKj1HJkc/zLgE7nUtP6+ZxupwpTYS/qTumtMK99y2niGSr2ZVxfxQsWwgK2Ov
 eJ8HFk/aDHcwHIYZBS1BwWUXOrozWJwpx/JcHc/Qw0ZIZjjskCVr1SZwGPlspZDyTyCK
 cAIkhxp+COow1nVg71hM07XBqFNXlMr5qGY9QGJ4hEV1jCpZN80MA6qp9sl3EZTLlT2c
 OHobBDWsARR0aETV8lby9iZElMvzMI736ZVLFekbUZWiJ6/N/eQIM+p8dyrUrKQ+NXo9
 rjeM3oNoG4LeP4hvbBMMVuI9dz+3N7m/JFAK6ztm2EuV8LEvRf1LNroqwRITS4HgFV5J
 TSeA==
X-Gm-Message-State: ABy/qLawSA1/Ay4/DQ7GubBzsaV1DttsX/3IqtELoDyFyfv4FwCCUtF3
 +XEZOeiixBG3zQ5Xg/irTlU2/GgV8XLkYLWZ
X-Google-Smtp-Source: APBJJlFDcYjv0+PgpZPlyEILUuN/sRsmpUCpgO+puiIKk0KgerETMGVwohKSxVMPmQAgwL24VzkbFA==
X-Received: by 2002:a17:902:bc8a:b0:1b3:cac7:19cd with SMTP id
 bb10-20020a170902bc8a00b001b3cac719cdmr16477785plb.18.1689741951867; 
 Tue, 18 Jul 2023 21:45:51 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001b890009634sm2731080plh.139.2023.07.18.21.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 21:45:51 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-trivial@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 1/5] docs/system/target-riscv.rst: tidy CPU firmware section
Date: Wed, 19 Jul 2023 14:45:34 +1000
Message-Id: <20230719044538.2013401-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719044538.2013401-1-alistair.francis@wdc.com>
References: <20230719044538.2013401-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

This is how the content of the "RISC-V CPU firmware" section is
displayed after the html is generated:

"When using the sifive_u or virt machine there are three different
firmware boot options: 1. -bios default - This is the default behaviour
if no -bios option is included. (...) 3. -bios <file> - Tells QEMU to
load the specified file as the firmware."

It's all in the same paragraph, in a numbered list, and no special
formatting for the options.

Tidy it a bit by adding line breaks between items and its description.
Remove the numbered list. And apply formatting for the options cited in
the middle of the text.

Cc: qemu-trivial@nongnu.org
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230712143728.383528-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/target-riscv.rst | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 89a866e4f4..ba195f1518 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -76,11 +76,19 @@ RISC-V CPU firmware
 
 When using the ``sifive_u`` or ``virt`` machine there are three different
 firmware boot options:
-1. ``-bios default`` - This is the default behaviour if no -bios option
-is included. This option will load the default OpenSBI firmware automatically.
-The firmware is included with the QEMU release and no user interaction is
-required. All a user needs to do is specify the kernel they want to boot
-with the -kernel option
-2. ``-bios none`` - QEMU will not automatically load any firmware. It is up
-to the user to load all the images they need.
-3. ``-bios <file>`` - Tells QEMU to load the specified file as the firmware.
+
+* ``-bios default``
+
+This is the default behaviour if no ``-bios`` option is included. This option
+will load the default OpenSBI firmware automatically. The firmware is included
+with the QEMU release and no user interaction is required. All a user needs to
+do is specify the kernel they want to boot with the ``-kernel`` option
+
+* ``-bios none``
+
+QEMU will not automatically load any firmware. It is up to the user to load all
+the images they need.
+
+* ``-bios <file>``
+
+Tells QEMU to load the specified file as the firmware.
-- 
2.40.1


