Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 029F57F7655
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 15:27:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6X7w-0003Wy-Vu; Fri, 24 Nov 2023 09:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xun794@gmail.com>)
 id 1r6O5i-0007cT-OZ; Thu, 23 Nov 2023 23:46:58 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xun794@gmail.com>)
 id 1r6O5e-0000Qe-3S; Thu, 23 Nov 2023 23:46:58 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-1ce95f96edcso11860105ad.0; 
 Thu, 23 Nov 2023 20:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700801211; x=1701406011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MtJVk2t0ZiUZRp1NcR4sQFVlC02vgXTc2F1VqikjWYY=;
 b=B3bu8weO5Un7vVMAN/MxWmy4pyNhFiOwFYtIAXPvQqvjBKFBBeupI3Ug+Os27cKl+8
 2jK0zTzoQtulOBDOVT6AzLGNh0PUqadnc925Z1SKSEmJGDCGTi+VXDgwy6xEmcEeGG49
 31Lk4BxclcGSppcyPouutyGKx4QcVCrV7NBJuIEt27hFeqg7Wlp+cgu0QWQPDGF0juuo
 efuDYUnRv7na82vats/UG/Wvd5uHJAuy4rIrB0KGeVISapb2e/uzhlHo0q2SnN+o5YDI
 6wS1k0FevWYAL4EVNivJnbj0vb04hlPk9PVceMxff5EvKxEmhQg1PXWKUL2dRpJkw3EJ
 TYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700801211; x=1701406011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MtJVk2t0ZiUZRp1NcR4sQFVlC02vgXTc2F1VqikjWYY=;
 b=La1fcjEWBNWpSZm1WSlMkqcUXhOLUAvelfDwDiwvF7ppgEUZ1JEE5Eqy7kG/f87jVJ
 uH1VNZ66QehM6a2zAU0oJWnUUxWkVAZOYWt/rzsZheno3Il1TKunHuvUAs87Gk8bOARA
 Mo6SGao6G0MXkoWEbrtbkm5hNpffMWddwobB6p1urE82j/hFrHgCYGaFBAUh2i1Q8EB1
 2Yy2Tm8OY3mbi20xJSHDecYHenqraPRC9f0W+1U9M97FJh2adq8UhAoc1HH+4+Sz5DFz
 cM8yGPKx913c/PPaW1f+Hoxe0NmZAbtCrMbY1tA0Rkpl/fzHlTATFIWjRFlCiL4QFdOY
 h2QQ==
X-Gm-Message-State: AOJu0YyBYppArVBagIOKg7iaJhZeEtOZtzCQQRVyNL9BSsDfnqTOYt14
 U21xYe41TgzPOr9NoVCVp60brclDFtHhtLMJ
X-Google-Smtp-Source: AGHT+IGgprPT265NEOohSggoFC8aYsk2W7jCts+682yzZt4/451WXRwDxFPop4cA1fIlcRZWDjLjIg==
X-Received: by 2002:a17:903:244e:b0:1cf:677d:964d with SMTP id
 l14-20020a170903244e00b001cf677d964dmr1559336pls.25.1700801210187; 
 Thu, 23 Nov 2023 20:46:50 -0800 (PST)
Received: from localhost ([52.140.197.67]) by smtp.gmail.com with ESMTPSA id
 q3-20020a170902bd8300b001cf68e9f5d5sm2192705pls.165.2023.11.23.20.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 20:46:49 -0800 (PST)
From: xun <xun794@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Yihuan Pan <xun794@gmail.com>
Subject: [PATCH] sh4: Coding style: Remove tabs
Date: Fri, 24 Nov 2023 12:45:54 +0800
Message-ID: <20231124044554.513752-1-xun794@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=xun794@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Nov 2023 09:25:50 -0500
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

From: Yihuan Pan <xun794@gmail.com>

Replaces TABS with spaces to ensure have a consistent coding
style with an indentation of 4 spaces in the SH4 subsystem.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/376
Signed-off-by: Yihuan Pan <xun794@gmail.com>
---
 linux-user/sh4/termbits.h |  204 +++---
 target/sh4/cpu.h          |   80 +-
 target/sh4/helper.c       |  236 +++---
 target/sh4/op_helper.c    |   70 +-
 target/sh4/translate.c    | 1466 ++++++++++++++++++-------------------
 5 files changed, 1028 insertions(+), 1028 deletions(-)

diff --git a/linux-user/sh4/termbits.h b/linux-user/sh4/termbits.h
index eeabd2d7a9..28e79f2c9a 100644
--- a/linux-user/sh4/termbits.h
+++ b/linux-user/sh4/termbits.h
@@ -39,86 +39,86 @@ struct target_termios {
 #define TARGET_VEOL2 16
 
 /* c_iflag bits */
-#define TARGET_IGNBRK	0000001
-#define TARGET_BRKINT	0000002
-#define TARGET_IGNPAR	0000004
-#define TARGET_PARMRK	0000010
-#define TARGET_INPCK	0000020
-#define TARGET_ISTRIP	0000040
-#define TARGET_INLCR	0000100
-#define TARGET_IGNCR	0000200
-#define TARGET_ICRNL	0000400
-#define TARGET_IUCLC	0001000
-#define TARGET_IXON	0002000
-#define TARGET_IXANY	0004000
-#define TARGET_IXOFF	0010000
-#define TARGET_IMAXBEL	0020000
-#define TARGET_IUTF8	0040000
+#define TARGET_IGNBRK  0000001
+#define TARGET_BRKINT  0000002
+#define TARGET_IGNPAR  0000004
+#define TARGET_PARMRK  0000010
+#define TARGET_INPCK   0000020
+#define TARGET_ISTRIP  0000040
+#define TARGET_INLCR   0000100
+#define TARGET_IGNCR   0000200
+#define TARGET_ICRNL   0000400
+#define TARGET_IUCLC   0001000
+#define TARGET_IXON    0002000
+#define TARGET_IXANY   0004000
+#define TARGET_IXOFF   0010000
+#define TARGET_IMAXBEL 0020000
+#define TARGET_IUTF8   0040000
 
 /* c_oflag bits */
-#define TARGET_OPOST	0000001
-#define TARGET_OLCUC	0000002
-#define TARGET_ONLCR	0000004
-#define TARGET_OCRNL	0000010
-#define TARGET_ONOCR	0000020
-#define TARGET_ONLRET	0000040
-#define TARGET_OFILL	0000100
-#define TARGET_OFDEL	0000200
-#define TARGET_NLDLY	0000400
-#define TARGET_NL0	0000000
-#define TARGET_NL1	0000400
-#define TARGET_CRDLY	0003000
-#define TARGET_CR0	0000000
-#define TARGET_CR1	0001000
-#define TARGET_CR2	0002000
-#define TARGET_CR3	0003000
-#define TARGET_TABDLY	0014000
-#define TARGET_TAB0	0000000
-#define TARGET_TAB1	0004000
-#define TARGET_TAB2	0010000
-#define TARGET_TAB3	0014000
-#define TARGET_XTABS	0014000
-#define TARGET_BSDLY	0020000
-#define TARGET_BS0	0000000
-#define TARGET_BS1	0020000
-#define TARGET_VTDLY	0040000
-#define TARGET_VT0	0000000
-#define TARGET_VT1	0040000
-#define TARGET_FFDLY	0100000
-#define TARGET_FF0	0000000
-#define TARGET_FF1	0100000
+#define TARGET_OPOST   0000001
+#define TARGET_OLCUC   0000002
+#define TARGET_ONLCR   0000004
+#define TARGET_OCRNL   0000010
+#define TARGET_ONOCR   0000020
+#define TARGET_ONLRET  0000040
+#define TARGET_OFILL   0000100
+#define TARGET_OFDEL   0000200
+#define TARGET_NLDLY   0000400
+#define TARGET_NL0     0000000
+#define TARGET_NL1     0000400
+#define TARGET_CRDLY   0003000
+#define TARGET_CR0     0000000
+#define TARGET_CR1     0001000
+#define TARGET_CR2     0002000
+#define TARGET_CR3     0003000
+#define TARGET_TABDLY  0014000
+#define TARGET_TAB0    0000000
+#define TARGET_TAB1    0004000
+#define TARGET_TAB2    0010000
+#define TARGET_TAB3    0014000
+#define TARGET_XTABS   0014000
+#define TARGET_BSDLY   0020000
+#define TARGET_BS0     0000000
+#define TARGET_BS1     0020000
+#define TARGET_VTDLY   0040000
+#define TARGET_VT0     0000000
+#define TARGET_VT1     0040000
+#define TARGET_FFDLY   0100000
+#define TARGET_FF0     0000000
+#define TARGET_FF1     0100000
 
 /* c_cflag bit meaning */
-#define TARGET_CBAUD	0010017
-#define TARGET_B0	0000000		/* hang up */
-#define TARGET_B50	0000001
-#define TARGET_B75	0000002
-#define TARGET_B110	0000003
-#define TARGET_B134	0000004
-#define TARGET_B150	0000005
-#define TARGET_B200	0000006
-#define TARGET_B300	0000007
-#define TARGET_B600	0000010
-#define TARGET_B1200	0000011
-#define TARGET_B1800	0000012
-#define TARGET_B2400	0000013
-#define TARGET_B4800	0000014
-#define TARGET_B9600	0000015
-#define TARGET_B19200	0000016
-#define TARGET_B38400	0000017
+#define TARGET_CBAUD   0010017
+#define TARGET_B0      0000000 /* hang up */
+#define TARGET_B50     0000001
+#define TARGET_B75     0000002
+#define TARGET_B110    0000003
+#define TARGET_B134    0000004
+#define TARGET_B150    0000005
+#define TARGET_B200    0000006
+#define TARGET_B300    0000007
+#define TARGET_B600    0000010
+#define TARGET_B1200   0000011
+#define TARGET_B1800   0000012
+#define TARGET_B2400   0000013
+#define TARGET_B4800   0000014
+#define TARGET_B9600   0000015
+#define TARGET_B19200  0000016
+#define TARGET_B38400  0000017
 #define TARGET_EXTA B19200
 #define TARGET_EXTB B38400
-#define TARGET_CSIZE	0000060
-#define TARGET_CS5	0000000
-#define TARGET_CS6	0000020
-#define TARGET_CS7	0000040
-#define TARGET_CS8	0000060
-#define TARGET_CSTOPB	0000100
-#define TARGET_CREAD	0000200
-#define TARGET_PARENB	0000400
-#define TARGET_PARODD	0001000
-#define TARGET_HUPCL	0002000
-#define TARGET_CLOCAL	0004000
+#define TARGET_CSIZE   0000060
+#define TARGET_CS5     0000000
+#define TARGET_CS6     0000020
+#define TARGET_CS7     0000040
+#define TARGET_CS8     0000060
+#define TARGET_CSTOPB  0000100
+#define TARGET_CREAD   0000200
+#define TARGET_PARENB  0000400
+#define TARGET_PARODD  0001000
+#define TARGET_HUPCL   0002000
+#define TARGET_CLOCAL  0004000
 #define TARGET_CBAUDEX 0010000
 #define TARGET_B57600 0010001
 #define TARGET_B115200 0010002
@@ -135,44 +135,44 @@ struct target_termios {
 #define TARGET_B3000000 0010015
 #define TARGET_B3500000 0010016
 #define TARGET_B4000000 0010017
-#define TARGET_CIBAUD	  002003600000	/* input baud rate (not used) */
-#define TARGET_CMSPAR	  010000000000		/* mark or space (stick) parity */
-#define TARGET_CRTSCTS	  020000000000		/* flow control */
+#define TARGET_CIBAUD    002003600000 /* input baud rate (not used) */
+#define TARGET_CMSPAR    010000000000 /* mark or space (stick) parity */
+#define TARGET_CRTSCTS   020000000000 /* flow control */
 
 /* c_lflag bits */
-#define TARGET_ISIG	0000001
-#define TARGET_ICANON	0000002
-#define TARGET_XCASE	0000004
-#define TARGET_ECHO	0000010
-#define TARGET_ECHOE	0000020
-#define TARGET_ECHOK	0000040
-#define TARGET_ECHONL	0000100
-#define TARGET_NOFLSH	0000200
-#define TARGET_TOSTOP	0000400
-#define TARGET_ECHOCTL	0001000
-#define TARGET_ECHOPRT	0002000
-#define TARGET_ECHOKE	0004000
-#define TARGET_FLUSHO	0010000
-#define TARGET_PENDIN	0040000
-#define TARGET_IEXTEN	0100000
+#define TARGET_ISIG     0000001
+#define TARGET_ICANON   0000002
+#define TARGET_XCASE    0000004
+#define TARGET_ECHO     0000010
+#define TARGET_ECHOE    0000020
+#define TARGET_ECHOK    0000040
+#define TARGET_ECHONL   0000100
+#define TARGET_NOFLSH   0000200
+#define TARGET_TOSTOP   0000400
+#define TARGET_ECHOCTL  0001000
+#define TARGET_ECHOPRT  0002000
+#define TARGET_ECHOKE   0004000
+#define TARGET_FLUSHO   0010000
+#define TARGET_PENDIN   0040000
+#define TARGET_IEXTEN   0100000
 #define TARGET_EXTPROC  0200000
 
 
 /* tcflow() and TCXONC use these */
-#define TARGET_TCOOFF		0
-#define TARGET_TCOON		1
-#define TARGET_TCIOFF		2
-#define TARGET_TCION		3
+#define TARGET_TCOOFF          0
+#define TARGET_TCOON           1
+#define TARGET_TCIOFF          2
+#define TARGET_TCION           3
 
 /* tcflush() and TCFLSH use these */
-#define TARGET_TCIFLUSH	0
-#define TARGET_TCOFLUSH	1
-#define TARGET_TCIOFLUSH	2
+#define TARGET_TCIFLUSH    0
+#define TARGET_TCOFLUSH    1
+#define TARGET_TCIOFLUSH   2
 
 /* tcsetattr uses these */
-#define TARGET_TCSANOW		0
-#define TARGET_TCSADRAIN	1
-#define TARGET_TARGET_TCSAFLUSH	2
+#define TARGET_TCSANOW          0
+#define TARGET_TCSADRAIN        1
+#define TARGET_TARGET_TCSAFLUSH 2
 
 /* ioctl */
 #define TARGET_FIOCLEX         TARGET_IO('f', 1)
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 360eac1fbe..031dc0b457 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -107,19 +107,19 @@
                                   TB_FLAG_GUSA_MASK)
 
 typedef struct tlb_t {
-    uint32_t vpn;		/* virtual page number */
-    uint32_t ppn;		/* physical page number */
-    uint32_t size;		/* mapped page size in bytes */
-    uint8_t asid;		/* address space identifier */
-    uint8_t v:1;		/* validity */
-    uint8_t sz:2;		/* page size */
-    uint8_t sh:1;		/* share status */
-    uint8_t c:1;		/* cacheability */
-    uint8_t pr:2;		/* protection key */
-    uint8_t d:1;		/* dirty */
-    uint8_t wt:1;		/* write through */
-    uint8_t sa:3;		/* space attribute (PCMCIA) */
-    uint8_t tc:1;		/* timing control */
+    uint32_t vpn;        /* virtual page number */
+    uint32_t ppn;        /* physical page number */
+    uint32_t size;       /* mapped page size in bytes */
+    uint8_t asid;        /* address space identifier */
+    uint8_t v:1;         /* validity */
+    uint8_t sz:2;        /* page size */
+    uint8_t sh:1;        /* share status */
+    uint8_t c:1;         /* cacheability */
+    uint8_t pr:2;        /* protection key */
+    uint8_t d:1;         /* dirty */
+    uint8_t wt:1;        /* write through */
+    uint8_t sa:3;        /* space attribute (PCMCIA) */
+    uint8_t tc:1;        /* timing control */
 } tlb_t;
 
 #define UTLB_SIZE 64
@@ -139,44 +139,44 @@ typedef struct memory_content {
 } memory_content;
 
 typedef struct CPUArchState {
-    uint32_t flags;		/* general execution flags */
-    uint32_t gregs[24];		/* general registers */
-    float32 fregs[32];		/* floating point registers */
+    uint32_t flags;             /* general execution flags */
+    uint32_t gregs[24];         /* general registers */
+    float32 fregs[32];          /* floating point registers */
     uint32_t sr;                /* status register (with T split out) */
     uint32_t sr_m;              /* M bit of status register */
     uint32_t sr_q;              /* Q bit of status register */
     uint32_t sr_t;              /* T bit of status register */
-    uint32_t ssr;		/* saved status register */
-    uint32_t spc;		/* saved program counter */
-    uint32_t gbr;		/* global base register */
-    uint32_t vbr;		/* vector base register */
-    uint32_t sgr;		/* saved global register 15 */
-    uint32_t dbr;		/* debug base register */
-    uint32_t pc;		/* program counter */
+    uint32_t ssr;               /* saved status register */
+    uint32_t spc;               /* saved program counter */
+    uint32_t gbr;               /* global base register */
+    uint32_t vbr;               /* vector base register */
+    uint32_t sgr;               /* saved global register 15 */
+    uint32_t dbr;               /* debug base register */
+    uint32_t pc;                /* program counter */
     uint32_t delayed_pc;        /* target of delayed branch */
     uint32_t delayed_cond;      /* condition of delayed branch */
-    uint32_t mach;		/* multiply and accumulate high */
-    uint32_t macl;		/* multiply and accumulate low */
-    uint32_t pr;		/* procedure register */
-    uint32_t fpscr;		/* floating point status/control register */
-    uint32_t fpul;		/* floating point communication register */
+    uint32_t mach;              /* multiply and accumulate high */
+    uint32_t macl;              /* multiply and accumulate low */
+    uint32_t pr;                /* procedure register */
+    uint32_t fpscr;             /* floating point status/control register */
+    uint32_t fpul;              /* floating point communication register */
 
     /* float point status register */
     float_status fp_status;
 
     /* Those belong to the specific unit (SH7750) but are handled here */
-    uint32_t mmucr;		/* MMU control register */
-    uint32_t pteh;		/* page table entry high register */
-    uint32_t ptel;		/* page table entry low register */
-    uint32_t ptea;		/* page table entry assistance register */
+    uint32_t mmucr;             /* MMU control register */
+    uint32_t pteh;              /* page table entry high register */
+    uint32_t ptel;              /* page table entry low register */
+    uint32_t ptea;              /* page table entry assistance register */
     uint32_t ttb;               /* translation table base register */
-    uint32_t tea;		/* TLB exception address register */
-    uint32_t tra;		/* TRAPA exception register */
-    uint32_t expevt;		/* exception event register */
-    uint32_t intevt;		/* interrupt event register */
+    uint32_t tea;               /* TLB exception address register */
+    uint32_t tra;               /* TRAPA exception register */
+    uint32_t expevt;            /* exception event register */
+    uint32_t intevt;            /* interrupt event register */
 
-    tlb_t itlb[ITLB_SIZE];	/* instruction translation table */
-    tlb_t utlb[UTLB_SIZE];	/* unified translation table */
+    tlb_t itlb[ITLB_SIZE];      /* instruction translation table */
+    tlb_t utlb[UTLB_SIZE];      /* unified translation table */
 
     /* LDST = LOCK_ADDR != -1.  */
     uint32_t lock_addr;
@@ -186,13 +186,13 @@ typedef struct CPUArchState {
     struct {} end_reset_fields;
 
     /* Fields from here on are preserved over CPU reset. */
-    int id;			/* CPU model */
+    int id;                     /* CPU model */
 
     /* The features that we should emulate. See sh_features above.  */
     uint32_t features;
 
     void *intc_handle;
-    int in_sleep;		/* SR_BL ignored during sleep */
+    int in_sleep;               /* SR_BL ignored during sleep */
     memory_content *movcal_backup;
     memory_content **movcal_backup_tail;
 } CPUSH4State;
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index e02e7af607..5a6f653c12 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -84,60 +84,60 @@ void superh_cpu_do_interrupt(CPUState *cs)
 
     if (do_irq) {
         irq_vector = sh_intc_get_pending_vector(env->intc_handle,
-						(env->sr >> 4) & 0xf);
+                                                (env->sr >> 4) & 0xf);
         if (irq_vector == -1) {
             return; /* masked */
-	}
+        }
     }
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
-	const char *expname;
+        const char *expname;
         switch (cs->exception_index) {
-	case 0x0e0:
-	    expname = "addr_error";
-	    break;
-	case 0x040:
-	    expname = "tlb_miss";
-	    break;
-	case 0x0a0:
-	    expname = "tlb_violation";
-	    break;
-	case 0x180:
-	    expname = "illegal_instruction";
-	    break;
-	case 0x1a0:
-	    expname = "slot_illegal_instruction";
-	    break;
-	case 0x800:
-	    expname = "fpu_disable";
-	    break;
-	case 0x820:
-	    expname = "slot_fpu";
-	    break;
-	case 0x100:
-	    expname = "data_write";
-	    break;
-	case 0x060:
-	    expname = "dtlb_miss_write";
-	    break;
-	case 0x0c0:
-	    expname = "dtlb_violation_write";
-	    break;
-	case 0x120:
-	    expname = "fpu_exception";
-	    break;
-	case 0x080:
-	    expname = "initial_page_write";
-	    break;
-	case 0x160:
-	    expname = "trapa";
-	    break;
-	default:
+        case 0x0e0:
+            expname = "addr_error";
+            break;
+        case 0x040:
+            expname = "tlb_miss";
+            break;
+        case 0x0a0:
+            expname = "tlb_violation";
+            break;
+        case 0x180:
+            expname = "illegal_instruction";
+            break;
+        case 0x1a0:
+            expname = "slot_illegal_instruction";
+            break;
+        case 0x800:
+            expname = "fpu_disable";
+            break;
+        case 0x820:
+            expname = "slot_fpu";
+            break;
+        case 0x100:
+            expname = "data_write";
+            break;
+        case 0x060:
+            expname = "dtlb_miss_write";
+            break;
+        case 0x0c0:
+            expname = "dtlb_violation_write";
+            break;
+        case 0x120:
+            expname = "fpu_exception";
+            break;
+        case 0x080:
+            expname = "initial_page_write";
+            break;
+        case 0x160:
+            expname = "trapa";
+            break;
+        default:
             expname = do_irq ? "interrupt" : "???";
             break;
-	}
-	qemu_log("exception 0x%03x [%s] raised\n",
-		  irq_vector, expname);
+        }
+        qemu_log("exception 0x%03x [%s] raised\n",
+                  irq_vector, expname);
         log_cpu_state(cs, 0);
     }
 
@@ -149,8 +149,8 @@ void superh_cpu_do_interrupt(CPUState *cs)
 
     if (env->flags & TB_FLAG_DELAY_SLOT_MASK) {
         /* Branch instruction should be executed again before delay slot. */
-	env->spc -= 2;
-	/* Clear flags for exception/interrupt routine. */
+        env->spc -= 2;
+        /* Clear flags for exception/interrupt routine. */
         env->flags &= ~TB_FLAG_DELAY_SLOT_MASK;
     }
 
@@ -191,19 +191,19 @@ static void update_itlb_use(CPUSH4State * env, int itlbnb)
 
     switch (itlbnb) {
     case 0:
-	and_mask = 0x1f;
-	break;
+        and_mask = 0x1f;
+        break;
     case 1:
-	and_mask = 0xe7;
-	or_mask = 0x80;
-	break;
+        and_mask = 0xe7;
+        or_mask = 0x80;
+        break;
     case 2:
-	and_mask = 0xfb;
-	or_mask = 0x50;
-	break;
+        and_mask = 0xfb;
+        or_mask = 0x50;
+        break;
     case 3:
-	or_mask = 0x2c;
-	break;
+        or_mask = 0x2c;
+        break;
     }
 
     env->mmucr &= (and_mask << 24) | 0x00ffffff;
@@ -213,16 +213,16 @@ static void update_itlb_use(CPUSH4State * env, int itlbnb)
 static int itlb_replacement(CPUSH4State * env)
 {
     if ((env->mmucr & 0xe0000000) == 0xe0000000) {
-	return 0;
+        return 0;
     }
     if ((env->mmucr & 0x98000000) == 0x18000000) {
-	return 1;
+        return 1;
     }
     if ((env->mmucr & 0x54000000) == 0x04000000) {
-	return 2;
+        return 2;
     }
     if ((env->mmucr & 0x2c000000) == 0x00000000) {
-	return 3;
+        return 3;
     }
     cpu_abort(env_cpu(env), "Unhandled itlb_replacement");
 }
@@ -231,7 +231,7 @@ static int itlb_replacement(CPUSH4State * env)
    Return entry, MMU_DTLB_MISS or MMU_DTLB_MULTIPLE
 */
 static int find_tlb_entry(CPUSH4State * env, target_ulong address,
-			  tlb_t * entries, uint8_t nbtlb, int use_asid)
+                          tlb_t * entries, uint8_t nbtlb, int use_asid)
 {
     int match = MMU_DTLB_MISS;
     uint32_t start, end;
@@ -241,17 +241,17 @@ static int find_tlb_entry(CPUSH4State * env, target_ulong address,
     asid = env->pteh & 0xff;
 
     for (i = 0; i < nbtlb; i++) {
-	if (!entries[i].v)
-	    continue;		/* Invalid entry */
-	if (!entries[i].sh && use_asid && entries[i].asid != asid)
-	    continue;		/* Bad ASID */
-	start = (entries[i].vpn << 10) & ~(entries[i].size - 1);
-	end = start + entries[i].size - 1;
-	if (address >= start && address <= end) {	/* Match */
-	    if (match != MMU_DTLB_MISS)
-		return MMU_DTLB_MULTIPLE;	/* Multiple match */
-	    match = i;
-	}
+        if (!entries[i].v)
+            continue; /* Invalid entry */
+        if (!entries[i].sh && use_asid && entries[i].asid != asid)
+            continue; /* Bad ASID */
+        start = (entries[i].vpn << 10) & ~(entries[i].size - 1);
+        end = start + entries[i].size - 1;
+        if (address >= start && address <= end) { /* Match */
+            if (match != MMU_DTLB_MISS)
+                return MMU_DTLB_MULTIPLE; /* Multiple match */
+            match = i;
+        }
     }
     return match;
 }
@@ -265,7 +265,7 @@ static void increment_urc(CPUSH4State * env)
     urc = ((env->mmucr) >> 10) & 0x3f;
     urc++;
     if ((urb > 0 && urc > urb) || urc > (UTLB_SIZE - 1))
-	urc = 0;
+        urc = 0;
     env->mmucr = (env->mmucr & 0xffff03ff) | (urc << 10);
 }
 
@@ -297,11 +297,11 @@ static int find_itlb_entry(CPUSH4State * env, target_ulong address,
 
     e = find_tlb_entry(env, address, env->itlb, ITLB_SIZE, use_asid);
     if (e == MMU_DTLB_MULTIPLE) {
-	e = MMU_ITLB_MULTIPLE;
+        e = MMU_ITLB_MULTIPLE;
     } else if (e == MMU_DTLB_MISS) {
-	e = MMU_ITLB_MISS;
+        e = MMU_ITLB_MISS;
     } else if (e >= 0) {
-	update_itlb_use(env, e);
+        update_itlb_use(env, e);
     }
     return e;
 }
@@ -518,7 +518,7 @@ uint32_t cpu_sh4_read_mmaped_itlb_addr(CPUSH4State *s,
 }
 
 void cpu_sh4_write_mmaped_itlb_addr(CPUSH4State *s, hwaddr addr,
-				    uint32_t mem_value)
+                                    uint32_t mem_value)
 {
     uint32_t vpn = (mem_value & 0xfffffc00) >> 10;
     uint8_t v = (uint8_t)((mem_value & 0x00000100) >> 8);
@@ -601,7 +601,7 @@ uint32_t cpu_sh4_read_mmaped_utlb_addr(CPUSH4State *s,
 }
 
 void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
-				    uint32_t mem_value)
+                                    uint32_t mem_value)
 {
     int associate = addr & 0x0000080;
     uint32_t vpn = (mem_value & 0xfffffc00) >> 10;
@@ -612,48 +612,48 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
 
     if (associate) {
         int i;
-	tlb_t * utlb_match_entry = NULL;
-	int needs_tlb_flush = 0;
+        tlb_t * utlb_match_entry = NULL;
+        int needs_tlb_flush = 0;
 
-	/* search UTLB */
-	for (i = 0; i < UTLB_SIZE; i++) {
+        /* search UTLB */
+        for (i = 0; i < UTLB_SIZE; i++) {
             tlb_t * entry = &s->utlb[i];
             if (!entry->v)
-	        continue;
+                continue;
 
             if (entry->vpn == vpn
                 && (!use_asid || entry->asid == asid || entry->sh)) {
-	        if (utlb_match_entry) {
+                if (utlb_match_entry) {
                     CPUState *cs = env_cpu(s);
 
-		    /* Multiple TLB Exception */
+                    /* Multiple TLB Exception */
                     cs->exception_index = 0x140;
-		    s->tea = addr;
-		    break;
-	        }
-		if (entry->v && !v)
-		    needs_tlb_flush = 1;
-		entry->v = v;
-		entry->d = d;
-	        utlb_match_entry = entry;
-	    }
-	    increment_urc(s); /* per utlb access */
-	}
-
-	/* search ITLB */
-	for (i = 0; i < ITLB_SIZE; i++) {
+                    s->tea = addr;
+                    break;
+                }
+                if (entry->v && !v)
+                    needs_tlb_flush = 1;
+                entry->v = v;
+                entry->d = d;
+                utlb_match_entry = entry;
+            }
+            increment_urc(s); /* per utlb access */
+        }
+
+        /* search ITLB */
+        for (i = 0; i < ITLB_SIZE; i++) {
             tlb_t * entry = &s->itlb[i];
             if (entry->vpn == vpn
                 && (!use_asid || entry->asid == asid || entry->sh)) {
-	        if (entry->v && !v)
-		    needs_tlb_flush = 1;
-	        if (utlb_match_entry)
-		    *entry = *utlb_match_entry;
-	        else
-		    entry->v = v;
-		break;
-	    }
-	}
+                if (entry->v && !v)
+                    needs_tlb_flush = 1;
+                if (utlb_match_entry)
+                    *entry = *utlb_match_entry;
+                else
+                    entry->v = v;
+                break;
+            }
+        }
 
         if (needs_tlb_flush) {
             tlb_flush_page(env_cpu(s), vpn << 10);
@@ -661,18 +661,18 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
     } else {
         int index = (addr & 0x00003f00) >> 8;
         tlb_t * entry = &s->utlb[index];
-	if (entry->v) {
+        if (entry->v) {
             CPUState *cs = env_cpu(s);
 
-	    /* Overwriting valid entry in utlb. */
+            /* Overwriting valid entry in utlb. */
             target_ulong address = entry->vpn << 10;
             tlb_flush_page(cs, address);
-	}
-	entry->asid = asid;
-	entry->vpn = vpn;
-	entry->d = d;
-	entry->v = v;
-	increment_urc(s);
+        }
+        entry->asid = asid;
+        entry->vpn = vpn;
+        entry->d = d;
+        entry->v = v;
+        increment_urc(s);
     }
 }
 
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index ada41ba0a2..54d390fe1f 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -114,12 +114,12 @@ void helper_movcal(CPUSH4State *env, uint32_t address, uint32_t value)
     {
         memory_content *r = g_new(memory_content, 1);
 
-	r->address = address;
-	r->value = value;
-	r->next = NULL;
+        r->address = address;
+        r->value = value;
+        r->next = NULL;
 
-	*(env->movcal_backup_tail) = r;
-	env->movcal_backup_tail = &(r->next);
+        *(env->movcal_backup_tail) = r;
+        env->movcal_backup_tail = &(r->next);
     }
 }
 
@@ -129,12 +129,12 @@ void helper_discard_movcal_backup(CPUSH4State *env)
 
     while(current)
     {
-	memory_content *next = current->next;
+        memory_content *next = current->next;
         g_free(current);
-	env->movcal_backup = current = next;
-	if (current == NULL)
-	    env->movcal_backup_tail = &(env->movcal_backup);
-    } 
+        env->movcal_backup = current = next;
+        if (current == NULL)
+            env->movcal_backup_tail = &(env->movcal_backup);
+    }
 }
 
 void helper_ocbi(CPUSH4State *env, uint32_t address)
@@ -142,21 +142,21 @@ void helper_ocbi(CPUSH4State *env, uint32_t address)
     memory_content **current = &(env->movcal_backup);
     while (*current)
     {
-	uint32_t a = (*current)->address;
-	if ((a & ~0x1F) == (address & ~0x1F))
-	{
-	    memory_content *next = (*current)->next;
+        uint32_t a = (*current)->address;
+        if ((a & ~0x1F) == (address & ~0x1F))
+        {
+            memory_content *next = (*current)->next;
             cpu_stl_data(env, a, (*current)->value);
-	    
-	    if (next == NULL)
-	    {
-		env->movcal_backup_tail = current;
-	    }
+
+            if (next == NULL)
+            {
+                env->movcal_backup_tail = current;
+            }
 
             g_free(*current);
-	    *current = next;
-	    break;
-	}
+            *current = next;
+            break;
+        }
     }
 }
 
@@ -169,10 +169,10 @@ void helper_macl(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
     env->mach = (res >> 32) & 0xffffffff;
     env->macl = res & 0xffffffff;
     if (env->sr & (1u << SR_S)) {
-	if (res < 0)
-	    env->mach |= 0xffff0000;
-	else
-	    env->mach &= 0x00007fff;
+        if (res < 0)
+            env->mach |= 0xffff0000;
+        else
+            env->mach &= 0x00007fff;
     }
 }
 
@@ -185,13 +185,13 @@ void helper_macw(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
     env->mach = (res >> 32) & 0xffffffff;
     env->macl = res & 0xffffffff;
     if (env->sr & (1u << SR_S)) {
-	if (res < -0x80000000) {
-	    env->mach = 1;
-	    env->macl = 0x80000000;
-	} else if (res > 0x000000007fffffff) {
-	    env->mach = 1;
-	    env->macl = 0x7fffffff;
-	}
+        if (res < -0x80000000) {
+            env->mach = 1;
+            env->macl = 0x80000000;
+        } else if (res > 0x000000007fffffff) {
+            env->mach = 1;
+            env->macl = 0x7fffffff;
+        }
     }
 }
 
@@ -199,9 +199,9 @@ void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
 {
     env->fpscr = val & FPSCR_MASK;
     if ((val & FPSCR_RM_MASK) == FPSCR_RM_ZERO) {
-	set_float_rounding_mode(float_round_to_zero, &env->fp_status);
+        set_float_rounding_mode(float_round_to_zero, &env->fp_status);
     } else {
-	set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
+        set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
     }
     set_flush_to_zero((val & FPSCR_DN) != 0, &env->fp_status);
 }
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 220a06bdce..81f825f125 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -136,10 +136,10 @@ void sh4_translate_init(void)
                                       offsetof(CPUSH4State, fpul), "FPUL");
 
     cpu_flags = tcg_global_mem_new_i32(tcg_env,
-				       offsetof(CPUSH4State, flags), "_flags_");
+                                       offsetof(CPUSH4State, flags), "_flags_");
     cpu_delayed_pc = tcg_global_mem_new_i32(tcg_env,
-					    offsetof(CPUSH4State, delayed_pc),
-					    "_delayed_pc_");
+                                            offsetof(CPUSH4State, delayed_pc),
+                                            "_delayed_pc_");
     cpu_delayed_cond = tcg_global_mem_new_i32(tcg_env,
                                               offsetof(CPUSH4State,
                                                        delayed_cond),
@@ -252,9 +252,9 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
 static void gen_jump(DisasContext * ctx)
 {
     if (ctx->delayed_pc == -1) {
-	/* Target is not statically known, it comes necessarily from a
-	   delayed jump as immediate jump are conditinal jumps */
-	tcg_gen_mov_i32(cpu_pc, cpu_delayed_pc);
+        /* Target is not statically known, it comes necessarily from a
+           delayed jump as immediate jump are conditinal jumps */
+        tcg_gen_mov_i32(cpu_pc, cpu_delayed_pc);
         tcg_gen_discard_i32(cpu_delayed_pc);
         if (use_exit_tb(ctx)) {
             tcg_gen_exit_tb(NULL, 0);
@@ -263,7 +263,7 @@ static void gen_jump(DisasContext * ctx)
         }
         ctx->base.is_jmp = DISAS_NORETURN;
     } else {
-	gen_goto_tb(ctx, 0, ctx->delayed_pc);
+        gen_goto_tb(ctx, 0, ctx->delayed_pc);
     }
 }
 
@@ -411,103 +411,103 @@ static void _decode_opc(DisasContext * ctx)
        TB, or if we already saw movca.l in this TB and did not flush stores
        yet.  */
     if (ctx->has_movcal)
-	{
-	  int opcode = ctx->opcode & 0xf0ff;
-	  if (opcode != 0x0093 /* ocbi */
-	      && opcode != 0x00c3 /* movca.l */)
-	      {
-                  gen_helper_discard_movcal_backup(tcg_env);
-		  ctx->has_movcal = 0;
-	      }
-	}
+    {
+        int opcode = ctx->opcode & 0xf0ff;
+        if (opcode != 0x0093 /* ocbi */
+            && opcode != 0x00c3 /* movca.l */)
+        {
+            gen_helper_discard_movcal_backup(tcg_env);
+            ctx->has_movcal = 0;
+        }
+    }
 
 #if 0
     fprintf(stderr, "Translating opcode 0x%04x\n", ctx->opcode);
 #endif
 
     switch (ctx->opcode) {
-    case 0x0019:		/* div0u */
+    case 0x0019: /* div0u */
         tcg_gen_movi_i32(cpu_sr_m, 0);
         tcg_gen_movi_i32(cpu_sr_q, 0);
         tcg_gen_movi_i32(cpu_sr_t, 0);
-	return;
-    case 0x000b:		/* rts */
-	CHECK_NOT_DELAY_SLOT
-	tcg_gen_mov_i32(cpu_delayed_pc, cpu_pr);
+        return;
+    case 0x000b: /* rts */
+        CHECK_NOT_DELAY_SLOT
+        tcg_gen_mov_i32(cpu_delayed_pc, cpu_pr);
         ctx->envflags |= TB_FLAG_DELAY_SLOT;
-	ctx->delayed_pc = (uint32_t) - 1;
-	return;
-    case 0x0028:		/* clrmac */
-	tcg_gen_movi_i32(cpu_mach, 0);
-	tcg_gen_movi_i32(cpu_macl, 0);
-	return;
-    case 0x0048:		/* clrs */
+        ctx->delayed_pc = (uint32_t) - 1;
+        return;
+    case 0x0028: /* clrmac */
+        tcg_gen_movi_i32(cpu_mach, 0);
+        tcg_gen_movi_i32(cpu_macl, 0);
+        return;
+    case 0x0048: /* clrs */
         tcg_gen_andi_i32(cpu_sr, cpu_sr, ~(1u << SR_S));
-	return;
-    case 0x0008:		/* clrt */
+        return;
+    case 0x0008: /* clrt */
         tcg_gen_movi_i32(cpu_sr_t, 0);
-	return;
-    case 0x0038:		/* ldtlb */
-	CHECK_PRIVILEGED
+        return;
+    case 0x0038: /* ldtlb */
+        CHECK_PRIVILEGED
         gen_helper_ldtlb(tcg_env);
-	return;
-    case 0x002b:		/* rte */
-	CHECK_PRIVILEGED
-	CHECK_NOT_DELAY_SLOT
+        return;
+    case 0x002b: /* rte */
+        CHECK_PRIVILEGED
+        CHECK_NOT_DELAY_SLOT
         gen_write_sr(cpu_ssr);
-	tcg_gen_mov_i32(cpu_delayed_pc, cpu_spc);
+        tcg_gen_mov_i32(cpu_delayed_pc, cpu_spc);
         ctx->envflags |= TB_FLAG_DELAY_SLOT_RTE;
-	ctx->delayed_pc = (uint32_t) - 1;
+        ctx->delayed_pc = (uint32_t) - 1;
         ctx->base.is_jmp = DISAS_STOP;
-	return;
-    case 0x0058:		/* sets */
+        return;
+    case 0x0058: /* sets */
         tcg_gen_ori_i32(cpu_sr, cpu_sr, (1u << SR_S));
-	return;
-    case 0x0018:		/* sett */
+        return;
+    case 0x0018: /* sett */
         tcg_gen_movi_i32(cpu_sr_t, 1);
-	return;
-    case 0xfbfd:		/* frchg */
+        return;
+    case 0xfbfd: /* frchg */
         CHECK_FPSCR_PR_0
-	tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_FR);
+        tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_FR);
         ctx->base.is_jmp = DISAS_STOP;
-	return;
-    case 0xf3fd:		/* fschg */
+        return;
+    case 0xf3fd: /* fschg */
         CHECK_FPSCR_PR_0
         tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_SZ);
         ctx->base.is_jmp = DISAS_STOP;
-	return;
-    case 0xf7fd:                /* fpchg */
+        return;
+    case 0xf7fd: /* fpchg */
         CHECK_SH4A
         tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_PR);
         ctx->base.is_jmp = DISAS_STOP;
         return;
-    case 0x0009:		/* nop */
-	return;
-    case 0x001b:		/* sleep */
-	CHECK_PRIVILEGED
+    case 0x0009: /* nop */
+        return;
+    case 0x001b: /* sleep */
+        CHECK_PRIVILEGED
         tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next + 2);
         gen_helper_sleep(tcg_env);
-	return;
+        return;
     }
 
     switch (ctx->opcode & 0xf000) {
-    case 0x1000:		/* mov.l Rm,@(disp,Rn) */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_addi_i32(addr, REG(B11_8), B3_0 * 4);
+    case 0x1000: /* mov.l Rm,@(disp,Rn) */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_addi_i32(addr, REG(B11_8), B3_0 * 4);
             tcg_gen_qemu_st_i32(REG(B7_4), addr, ctx->memidx,
                                 MO_TEUL | UNALIGN(ctx));
-	}
-	return;
-    case 0x5000:		/* mov.l @(disp,Rm),Rn */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_addi_i32(addr, REG(B7_4), B3_0 * 4);
+        }
+        return;
+    case 0x5000: /* mov.l @(disp,Rm),Rn */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_addi_i32(addr, REG(B7_4), B3_0 * 4);
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx,
                                 MO_TESL | UNALIGN(ctx));
-	}
-	return;
-    case 0xe000:		/* mov #imm,Rn */
+        }
+        return;
+    case 0xe000: /* mov #imm,Rn */
 #ifdef CONFIG_USER_ONLY
         /*
          * Detect the start of a gUSA region (mov #-n, r15).
@@ -521,178 +521,178 @@ static void _decode_opc(DisasContext * ctx)
             ctx->base.is_jmp = DISAS_STOP;
         }
 #endif
-	tcg_gen_movi_i32(REG(B11_8), B7_0s);
-	return;
-    case 0x9000:		/* mov.w @(disp,PC),Rn */
-	{
+        tcg_gen_movi_i32(REG(B11_8), B7_0s);
+        return;
+    case 0x9000: /* mov.w @(disp,PC),Rn */
+        {
             TCGv addr = tcg_constant_i32(ctx->base.pc_next + 4 + B7_0 * 2);
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx,
                                 MO_TESW | MO_ALIGN);
-	}
-	return;
-    case 0xd000:		/* mov.l @(disp,PC),Rn */
-	{
+        }
+        return;
+    case 0xd000: /* mov.l @(disp,PC),Rn */
+        {
             TCGv addr = tcg_constant_i32((ctx->base.pc_next + 4 + B7_0 * 4) & ~3);
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx,
                                 MO_TESL | MO_ALIGN);
-	}
-	return;
-    case 0x7000:		/* add #imm,Rn */
-	tcg_gen_addi_i32(REG(B11_8), REG(B11_8), B7_0s);
-	return;
-    case 0xa000:		/* bra disp */
-	CHECK_NOT_DELAY_SLOT
+        }
+        return;
+    case 0x7000: /* add #imm,Rn */
+        tcg_gen_addi_i32(REG(B11_8), REG(B11_8), B7_0s);
+        return;
+    case 0xa000: /* bra disp */
+        CHECK_NOT_DELAY_SLOT
         ctx->delayed_pc = ctx->base.pc_next + 4 + B11_0s * 2;
         ctx->envflags |= TB_FLAG_DELAY_SLOT;
-	return;
-    case 0xb000:		/* bsr disp */
-	CHECK_NOT_DELAY_SLOT
+        return;
+    case 0xb000: /* bsr disp */
+        CHECK_NOT_DELAY_SLOT
         tcg_gen_movi_i32(cpu_pr, ctx->base.pc_next + 4);
         ctx->delayed_pc = ctx->base.pc_next + 4 + B11_0s * 2;
         ctx->envflags |= TB_FLAG_DELAY_SLOT;
-	return;
+        return;
     }
 
     switch (ctx->opcode & 0xf00f) {
-    case 0x6003:		/* mov Rm,Rn */
-	tcg_gen_mov_i32(REG(B11_8), REG(B7_4));
-	return;
-    case 0x2000:		/* mov.b Rm,@Rn */
+    case 0x6003: /* mov Rm,Rn */
+        tcg_gen_mov_i32(REG(B11_8), REG(B7_4));
+        return;
+    case 0x2000: /* mov.b Rm,@Rn */
         tcg_gen_qemu_st_i32(REG(B7_4), REG(B11_8), ctx->memidx, MO_UB);
-	return;
-    case 0x2001:		/* mov.w Rm,@Rn */
+        return;
+    case 0x2001: /* mov.w Rm,@Rn */
         tcg_gen_qemu_st_i32(REG(B7_4), REG(B11_8), ctx->memidx,
                             MO_TEUW | UNALIGN(ctx));
-	return;
-    case 0x2002:		/* mov.l Rm,@Rn */
+        return;
+    case 0x2002: /* mov.l Rm,@Rn */
         tcg_gen_qemu_st_i32(REG(B7_4), REG(B11_8), ctx->memidx,
                             MO_TEUL | UNALIGN(ctx));
-	return;
-    case 0x6000:		/* mov.b @Rm,Rn */
+        return;
+    case 0x6000: /* mov.b @Rm,Rn */
         tcg_gen_qemu_ld_i32(REG(B11_8), REG(B7_4), ctx->memidx, MO_SB);
-	return;
-    case 0x6001:		/* mov.w @Rm,Rn */
+        return;
+    case 0x6001: /* mov.w @Rm,Rn */
         tcg_gen_qemu_ld_i32(REG(B11_8), REG(B7_4), ctx->memidx,
                             MO_TESW | UNALIGN(ctx));
-	return;
-    case 0x6002:		/* mov.l @Rm,Rn */
+        return;
+    case 0x6002: /* mov.l @Rm,Rn */
         tcg_gen_qemu_ld_i32(REG(B11_8), REG(B7_4), ctx->memidx,
                             MO_TESL | UNALIGN(ctx));
-	return;
-    case 0x2004:		/* mov.b Rm,@-Rn */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_subi_i32(addr, REG(B11_8), 1);
+        return;
+    case 0x2004: /* mov.b Rm,@-Rn */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_subi_i32(addr, REG(B11_8), 1);
             /* might cause re-execution */
             tcg_gen_qemu_st_i32(REG(B7_4), addr, ctx->memidx, MO_UB);
-	    tcg_gen_mov_i32(REG(B11_8), addr);			/* modify register status */
-	}
-	return;
-    case 0x2005:		/* mov.w Rm,@-Rn */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_subi_i32(addr, REG(B11_8), 2);
+            tcg_gen_mov_i32(REG(B11_8), addr); /* modify register status */
+        }
+        return;
+    case 0x2005: /* mov.w Rm,@-Rn */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_subi_i32(addr, REG(B11_8), 2);
             tcg_gen_qemu_st_i32(REG(B7_4), addr, ctx->memidx,
                                 MO_TEUW | UNALIGN(ctx));
-	    tcg_gen_mov_i32(REG(B11_8), addr);
-	}
-	return;
-    case 0x2006:		/* mov.l Rm,@-Rn */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_subi_i32(addr, REG(B11_8), 4);
+            tcg_gen_mov_i32(REG(B11_8), addr);
+        }
+        return;
+    case 0x2006: /* mov.l Rm,@-Rn */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_subi_i32(addr, REG(B11_8), 4);
             tcg_gen_qemu_st_i32(REG(B7_4), addr, ctx->memidx,
                                 MO_TEUL | UNALIGN(ctx));
-	    tcg_gen_mov_i32(REG(B11_8), addr);
-	}
-	return;
-    case 0x6004:		/* mov.b @Rm+,Rn */
+            tcg_gen_mov_i32(REG(B11_8), addr);
+        }
+        return;
+    case 0x6004: /* mov.b @Rm+,Rn */
         tcg_gen_qemu_ld_i32(REG(B11_8), REG(B7_4), ctx->memidx, MO_SB);
-	if ( B11_8 != B7_4 )
-		tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 1);
-	return;
-    case 0x6005:		/* mov.w @Rm+,Rn */
+        if ( B11_8 != B7_4 )
+                tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 1);
+        return;
+    case 0x6005: /* mov.w @Rm+,Rn */
         tcg_gen_qemu_ld_i32(REG(B11_8), REG(B7_4), ctx->memidx,
                             MO_TESW | UNALIGN(ctx));
-	if ( B11_8 != B7_4 )
-		tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 2);
-	return;
-    case 0x6006:		/* mov.l @Rm+,Rn */
+        if ( B11_8 != B7_4 )
+                tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 2);
+        return;
+    case 0x6006: /* mov.l @Rm+,Rn */
         tcg_gen_qemu_ld_i32(REG(B11_8), REG(B7_4), ctx->memidx,
                             MO_TESL | UNALIGN(ctx));
-	if ( B11_8 != B7_4 )
-		tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 4);
-	return;
-    case 0x0004:		/* mov.b Rm,@(R0,Rn) */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_add_i32(addr, REG(B11_8), REG(0));
+        if ( B11_8 != B7_4 )
+                tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 4);
+        return;
+    case 0x0004: /* mov.b Rm,@(R0,Rn) */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_add_i32(addr, REG(B11_8), REG(0));
             tcg_gen_qemu_st_i32(REG(B7_4), addr, ctx->memidx, MO_UB);
-	}
-	return;
-    case 0x0005:		/* mov.w Rm,@(R0,Rn) */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_add_i32(addr, REG(B11_8), REG(0));
+        }
+        return;
+    case 0x0005: /* mov.w Rm,@(R0,Rn) */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_add_i32(addr, REG(B11_8), REG(0));
             tcg_gen_qemu_st_i32(REG(B7_4), addr, ctx->memidx,
                                 MO_TEUW | UNALIGN(ctx));
-	}
-	return;
-    case 0x0006:		/* mov.l Rm,@(R0,Rn) */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_add_i32(addr, REG(B11_8), REG(0));
+        }
+        return;
+    case 0x0006: /* mov.l Rm,@(R0,Rn) */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_add_i32(addr, REG(B11_8), REG(0));
             tcg_gen_qemu_st_i32(REG(B7_4), addr, ctx->memidx,
                                 MO_TEUL | UNALIGN(ctx));
-	}
-	return;
-    case 0x000c:		/* mov.b @(R0,Rm),Rn */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_add_i32(addr, REG(B7_4), REG(0));
+        }
+        return;
+    case 0x000c: /* mov.b @(R0,Rm),Rn */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_add_i32(addr, REG(B7_4), REG(0));
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx, MO_SB);
-	}
-	return;
-    case 0x000d:		/* mov.w @(R0,Rm),Rn */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_add_i32(addr, REG(B7_4), REG(0));
+        }
+        return;
+    case 0x000d: /* mov.w @(R0,Rm),Rn */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_add_i32(addr, REG(B7_4), REG(0));
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx,
                                 MO_TESW | UNALIGN(ctx));
-	}
-	return;
-    case 0x000e:		/* mov.l @(R0,Rm),Rn */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_add_i32(addr, REG(B7_4), REG(0));
+        }
+        return;
+    case 0x000e: /* mov.l @(R0,Rm),Rn */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_add_i32(addr, REG(B7_4), REG(0));
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx,
                                 MO_TESL | UNALIGN(ctx));
-	}
-	return;
-    case 0x6008:		/* swap.b Rm,Rn */
-	{
+        }
+        return;
+    case 0x6008: /* swap.b Rm,Rn */
+        {
             TCGv low = tcg_temp_new();
             tcg_gen_bswap16_i32(low, REG(B7_4), 0);
             tcg_gen_deposit_i32(REG(B11_8), REG(B7_4), low, 0, 16);
-	}
-	return;
-    case 0x6009:		/* swap.w Rm,Rn */
+        }
+        return;
+    case 0x6009: /* swap.w Rm,Rn */
         tcg_gen_rotli_i32(REG(B11_8), REG(B7_4), 16);
-	return;
-    case 0x200d:		/* xtrct Rm,Rn */
-	{
-	    TCGv high, low;
-	    high = tcg_temp_new();
-	    tcg_gen_shli_i32(high, REG(B7_4), 16);
-	    low = tcg_temp_new();
-	    tcg_gen_shri_i32(low, REG(B11_8), 16);
-	    tcg_gen_or_i32(REG(B11_8), high, low);
-	}
-	return;
-    case 0x300c:		/* add Rm,Rn */
-	tcg_gen_add_i32(REG(B11_8), REG(B11_8), REG(B7_4));
-	return;
-    case 0x300e:		/* addc Rm,Rn */
+        return;
+    case 0x200d: /* xtrct Rm,Rn */
+        {
+            TCGv high, low;
+            high = tcg_temp_new();
+            tcg_gen_shli_i32(high, REG(B7_4), 16);
+            low = tcg_temp_new();
+            tcg_gen_shri_i32(low, REG(B11_8), 16);
+            tcg_gen_or_i32(REG(B11_8), high, low);
+        }
+        return;
+    case 0x300c: /* add Rm,Rn */
+        tcg_gen_add_i32(REG(B11_8), REG(B11_8), REG(B7_4));
+        return;
+    case 0x300e: /* addc Rm,Rn */
         {
             TCGv t0, t1;
             t0 = tcg_constant_tl(0);
@@ -701,8 +701,8 @@ static void _decode_opc(DisasContext * ctx)
             tcg_gen_add2_i32(REG(B11_8), cpu_sr_t,
                              REG(B11_8), t0, t1, cpu_sr_t);
         }
-	return;
-    case 0x300f:		/* addv Rm,Rn */
+        return;
+    case 0x300f: /* addv Rm,Rn */
         {
             TCGv t0, t1, t2;
             t0 = tcg_temp_new();
@@ -715,42 +715,42 @@ static void _decode_opc(DisasContext * ctx)
             tcg_gen_shri_i32(cpu_sr_t, cpu_sr_t, 31);
             tcg_gen_mov_i32(REG(B7_4), t0);
         }
-	return;
-    case 0x2009:		/* and Rm,Rn */
-	tcg_gen_and_i32(REG(B11_8), REG(B11_8), REG(B7_4));
-	return;
-    case 0x3000:		/* cmp/eq Rm,Rn */
+        return;
+    case 0x2009: /* and Rm,Rn */
+        tcg_gen_and_i32(REG(B11_8), REG(B11_8), REG(B7_4));
+        return;
+    case 0x3000: /* cmp/eq Rm,Rn */
         tcg_gen_setcond_i32(TCG_COND_EQ, cpu_sr_t, REG(B11_8), REG(B7_4));
-	return;
-    case 0x3003:		/* cmp/ge Rm,Rn */
+        return;
+    case 0x3003: /* cmp/ge Rm,Rn */
         tcg_gen_setcond_i32(TCG_COND_GE, cpu_sr_t, REG(B11_8), REG(B7_4));
-	return;
-    case 0x3007:		/* cmp/gt Rm,Rn */
+        return;
+    case 0x3007: /* cmp/gt Rm,Rn */
         tcg_gen_setcond_i32(TCG_COND_GT, cpu_sr_t, REG(B11_8), REG(B7_4));
-	return;
-    case 0x3006:		/* cmp/hi Rm,Rn */
+        return;
+    case 0x3006: /* cmp/hi Rm,Rn */
         tcg_gen_setcond_i32(TCG_COND_GTU, cpu_sr_t, REG(B11_8), REG(B7_4));
-	return;
-    case 0x3002:		/* cmp/hs Rm,Rn */
+        return;
+    case 0x3002: /* cmp/hs Rm,Rn */
         tcg_gen_setcond_i32(TCG_COND_GEU, cpu_sr_t, REG(B11_8), REG(B7_4));
-	return;
-    case 0x200c:		/* cmp/str Rm,Rn */
-	{
-	    TCGv cmp1 = tcg_temp_new();
-	    TCGv cmp2 = tcg_temp_new();
+        return;
+    case 0x200c: /* cmp/str Rm,Rn */
+        {
+            TCGv cmp1 = tcg_temp_new();
+            TCGv cmp2 = tcg_temp_new();
             tcg_gen_xor_i32(cmp2, REG(B7_4), REG(B11_8));
             tcg_gen_subi_i32(cmp1, cmp2, 0x01010101);
             tcg_gen_andc_i32(cmp1, cmp1, cmp2);
             tcg_gen_andi_i32(cmp1, cmp1, 0x80808080);
             tcg_gen_setcondi_i32(TCG_COND_NE, cpu_sr_t, cmp1, 0);
-	}
-	return;
-    case 0x2007:		/* div0s Rm,Rn */
+        }
+        return;
+    case 0x2007: /* div0s Rm,Rn */
         tcg_gen_shri_i32(cpu_sr_q, REG(B11_8), 31);         /* SR_Q */
         tcg_gen_shri_i32(cpu_sr_m, REG(B7_4), 31);          /* SR_M */
         tcg_gen_xor_i32(cpu_sr_t, cpu_sr_q, cpu_sr_m);      /* SR_T */
-	return;
-    case 0x3004:		/* div1 Rm,Rn */
+        return;
+    case 0x3004: /* div1 Rm,Rn */
         {
             TCGv t0 = tcg_temp_new();
             TCGv t1 = tcg_temp_new();
@@ -779,80 +779,80 @@ static void _decode_opc(DisasContext * ctx)
             tcg_gen_xori_i32(cpu_sr_t, t1, 1);
             tcg_gen_xor_i32(cpu_sr_q, cpu_sr_m, t1);
         }
-	return;
-    case 0x300d:		/* dmuls.l Rm,Rn */
+        return;
+    case 0x300d: /* dmuls.l Rm,Rn */
         tcg_gen_muls2_i32(cpu_macl, cpu_mach, REG(B7_4), REG(B11_8));
-	return;
-    case 0x3005:		/* dmulu.l Rm,Rn */
+        return;
+    case 0x3005: /* dmulu.l Rm,Rn */
         tcg_gen_mulu2_i32(cpu_macl, cpu_mach, REG(B7_4), REG(B11_8));
-	return;
-    case 0x600e:		/* exts.b Rm,Rn */
-	tcg_gen_ext8s_i32(REG(B11_8), REG(B7_4));
-	return;
-    case 0x600f:		/* exts.w Rm,Rn */
-	tcg_gen_ext16s_i32(REG(B11_8), REG(B7_4));
-	return;
-    case 0x600c:		/* extu.b Rm,Rn */
-	tcg_gen_ext8u_i32(REG(B11_8), REG(B7_4));
-	return;
-    case 0x600d:		/* extu.w Rm,Rn */
-	tcg_gen_ext16u_i32(REG(B11_8), REG(B7_4));
-	return;
-    case 0x000f:		/* mac.l @Rm+,@Rn+ */
-	{
-	    TCGv arg0, arg1;
-	    arg0 = tcg_temp_new();
+        return;
+    case 0x600e: /* exts.b Rm,Rn */
+        tcg_gen_ext8s_i32(REG(B11_8), REG(B7_4));
+        return;
+    case 0x600f: /* exts.w Rm,Rn */
+        tcg_gen_ext16s_i32(REG(B11_8), REG(B7_4));
+        return;
+    case 0x600c: /* extu.b Rm,Rn */
+        tcg_gen_ext8u_i32(REG(B11_8), REG(B7_4));
+        return;
+    case 0x600d: /* extu.w Rm,Rn */
+        tcg_gen_ext16u_i32(REG(B11_8), REG(B7_4));
+        return;
+    case 0x000f: /* mac.l @Rm+,@Rn+ */
+        {
+            TCGv arg0, arg1;
+            arg0 = tcg_temp_new();
             tcg_gen_qemu_ld_i32(arg0, REG(B7_4), ctx->memidx,
                                 MO_TESL | MO_ALIGN);
-	    arg1 = tcg_temp_new();
+            arg1 = tcg_temp_new();
             tcg_gen_qemu_ld_i32(arg1, REG(B11_8), ctx->memidx,
                                 MO_TESL | MO_ALIGN);
             gen_helper_macl(tcg_env, arg0, arg1);
-	    tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 4);
-	    tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
-	}
-	return;
-    case 0x400f:		/* mac.w @Rm+,@Rn+ */
-	{
-	    TCGv arg0, arg1;
-	    arg0 = tcg_temp_new();
+            tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 4);
+            tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
+        }
+        return;
+    case 0x400f: /* mac.w @Rm+,@Rn+ */
+        {
+            TCGv arg0, arg1;
+            arg0 = tcg_temp_new();
             tcg_gen_qemu_ld_i32(arg0, REG(B7_4), ctx->memidx,
                                 MO_TESL | MO_ALIGN);
-	    arg1 = tcg_temp_new();
+            arg1 = tcg_temp_new();
             tcg_gen_qemu_ld_i32(arg1, REG(B11_8), ctx->memidx,
                                 MO_TESL | MO_ALIGN);
             gen_helper_macw(tcg_env, arg0, arg1);
-	    tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 2);
-	    tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 2);
-	}
-	return;
-    case 0x0007:		/* mul.l Rm,Rn */
-	tcg_gen_mul_i32(cpu_macl, REG(B7_4), REG(B11_8));
-	return;
-    case 0x200f:		/* muls.w Rm,Rn */
-	{
-	    TCGv arg0, arg1;
-	    arg0 = tcg_temp_new();
-	    tcg_gen_ext16s_i32(arg0, REG(B7_4));
-	    arg1 = tcg_temp_new();
-	    tcg_gen_ext16s_i32(arg1, REG(B11_8));
-	    tcg_gen_mul_i32(cpu_macl, arg0, arg1);
-	}
-	return;
-    case 0x200e:		/* mulu.w Rm,Rn */
-	{
-	    TCGv arg0, arg1;
-	    arg0 = tcg_temp_new();
-	    tcg_gen_ext16u_i32(arg0, REG(B7_4));
-	    arg1 = tcg_temp_new();
-	    tcg_gen_ext16u_i32(arg1, REG(B11_8));
-	    tcg_gen_mul_i32(cpu_macl, arg0, arg1);
-	}
-	return;
-    case 0x600b:		/* neg Rm,Rn */
-	tcg_gen_neg_i32(REG(B11_8), REG(B7_4));
-	return;
-    case 0x600a:		/* negc Rm,Rn */
+            tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 2);
+            tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 2);
+        }
+        return;
+    case 0x0007: /* mul.l Rm,Rn */
+        tcg_gen_mul_i32(cpu_macl, REG(B7_4), REG(B11_8));
+        return;
+    case 0x200f: /* muls.w Rm,Rn */
+        {
+            TCGv arg0, arg1;
+            arg0 = tcg_temp_new();
+            tcg_gen_ext16s_i32(arg0, REG(B7_4));
+            arg1 = tcg_temp_new();
+            tcg_gen_ext16s_i32(arg1, REG(B11_8));
+            tcg_gen_mul_i32(cpu_macl, arg0, arg1);
+        }
+        return;
+    case 0x200e: /* mulu.w Rm,Rn */
+        {
+            TCGv arg0, arg1;
+            arg0 = tcg_temp_new();
+            tcg_gen_ext16u_i32(arg0, REG(B7_4));
+            arg1 = tcg_temp_new();
+            tcg_gen_ext16u_i32(arg1, REG(B11_8));
+            tcg_gen_mul_i32(cpu_macl, arg0, arg1);
+        }
+        return;
+    case 0x600b: /* neg Rm,Rn */
+        tcg_gen_neg_i32(REG(B11_8), REG(B7_4));
+        return;
+    case 0x600a: /* negc Rm,Rn */
         {
             TCGv t0 = tcg_constant_i32(0);
             tcg_gen_add2_i32(REG(B11_8), cpu_sr_t,
@@ -861,15 +861,15 @@ static void _decode_opc(DisasContext * ctx)
                              t0, t0, REG(B11_8), cpu_sr_t);
             tcg_gen_andi_i32(cpu_sr_t, cpu_sr_t, 1);
         }
-	return;
-    case 0x6007:		/* not Rm,Rn */
-	tcg_gen_not_i32(REG(B11_8), REG(B7_4));
-	return;
-    case 0x200b:		/* or Rm,Rn */
-	tcg_gen_or_i32(REG(B11_8), REG(B11_8), REG(B7_4));
-	return;
-    case 0x400c:		/* shad Rm,Rn */
-	{
+        return;
+    case 0x6007: /* not Rm,Rn */
+        tcg_gen_not_i32(REG(B11_8), REG(B7_4));
+        return;
+    case 0x200b: /* or Rm,Rn */
+        tcg_gen_or_i32(REG(B11_8), REG(B11_8), REG(B7_4));
+        return;
+    case 0x400c: /* shad Rm,Rn */
+        {
             TCGv t0 = tcg_temp_new();
             TCGv t1 = tcg_temp_new();
             TCGv t2 = tcg_temp_new();
@@ -888,10 +888,10 @@ static void _decode_opc(DisasContext * ctx)
             /* select between the two cases */
             tcg_gen_movi_i32(t0, 0);
             tcg_gen_movcond_i32(TCG_COND_GE, REG(B11_8), REG(B7_4), t0, t1, t2);
-	}
-	return;
-    case 0x400d:		/* shld Rm,Rn */
-	{
+        }
+        return;
+    case 0x400d: /* shld Rm,Rn */
+        {
             TCGv t0 = tcg_temp_new();
             TCGv t1 = tcg_temp_new();
             TCGv t2 = tcg_temp_new();
@@ -910,12 +910,12 @@ static void _decode_opc(DisasContext * ctx)
             /* select between the two cases */
             tcg_gen_movi_i32(t0, 0);
             tcg_gen_movcond_i32(TCG_COND_GE, REG(B11_8), REG(B7_4), t0, t1, t2);
-	}
-	return;
-    case 0x3008:		/* sub Rm,Rn */
-	tcg_gen_sub_i32(REG(B11_8), REG(B11_8), REG(B7_4));
-	return;
-    case 0x300a:		/* subc Rm,Rn */
+        }
+        return;
+    case 0x3008: /* sub Rm,Rn */
+        tcg_gen_sub_i32(REG(B11_8), REG(B11_8), REG(B7_4));
+        return;
+    case 0x300a: /* subc Rm,Rn */
         {
             TCGv t0, t1;
             t0 = tcg_constant_tl(0);
@@ -925,8 +925,8 @@ static void _decode_opc(DisasContext * ctx)
                              REG(B11_8), t0, t1, cpu_sr_t);
             tcg_gen_andi_i32(cpu_sr_t, cpu_sr_t, 1);
         }
-	return;
-    case 0x300b:		/* subv Rm,Rn */
+        return;
+    case 0x300b: /* subv Rm,Rn */
         {
             TCGv t0, t1, t2;
             t0 = tcg_temp_new();
@@ -939,68 +939,68 @@ static void _decode_opc(DisasContext * ctx)
             tcg_gen_shri_i32(cpu_sr_t, t1, 31);
             tcg_gen_mov_i32(REG(B11_8), t0);
         }
-	return;
-    case 0x2008:		/* tst Rm,Rn */
-	{
-	    TCGv val = tcg_temp_new();
-	    tcg_gen_and_i32(val, REG(B7_4), REG(B11_8));
+        return;
+    case 0x2008: /* tst Rm,Rn */
+        {
+            TCGv val = tcg_temp_new();
+            tcg_gen_and_i32(val, REG(B7_4), REG(B11_8));
             tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_t, val, 0);
-	}
-	return;
-    case 0x200a:		/* xor Rm,Rn */
-	tcg_gen_xor_i32(REG(B11_8), REG(B11_8), REG(B7_4));
-	return;
+        }
+        return;
+    case 0x200a: /* xor Rm,Rn */
+        tcg_gen_xor_i32(REG(B11_8), REG(B11_8), REG(B7_4));
+        return;
     case 0xf00c: /* fmov {F,D,X}Rm,{F,D,X}Rn - FPSCR: Nothing */
-	CHECK_FPU_ENABLED
+        CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
             int xsrc = XHACK(B7_4);
             int xdst = XHACK(B11_8);
             tcg_gen_mov_i32(FREG(xdst), FREG(xsrc));
             tcg_gen_mov_i32(FREG(xdst + 1), FREG(xsrc + 1));
-	} else {
+        } else {
             tcg_gen_mov_i32(FREG(B11_8), FREG(B7_4));
-	}
-	return;
+        }
+        return;
     case 0xf00a: /* fmov {F,D,X}Rm,@Rn - FPSCR: Nothing */
-	CHECK_FPU_ENABLED
+        CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
             TCGv_i64 fp = tcg_temp_new_i64();
             gen_load_fpr64(ctx, fp, XHACK(B7_4));
             tcg_gen_qemu_st_i64(fp, REG(B11_8), ctx->memidx,
                                 MO_TEUQ | MO_ALIGN);
-	} else {
+        } else {
             tcg_gen_qemu_st_i32(FREG(B7_4), REG(B11_8), ctx->memidx,
                                 MO_TEUL | MO_ALIGN);
-	}
-	return;
+        }
+        return;
     case 0xf008: /* fmov @Rm,{F,D,X}Rn - FPSCR: Nothing */
-	CHECK_FPU_ENABLED
+        CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
             TCGv_i64 fp = tcg_temp_new_i64();
             tcg_gen_qemu_ld_i64(fp, REG(B7_4), ctx->memidx,
                                 MO_TEUQ | MO_ALIGN);
             gen_store_fpr64(ctx, fp, XHACK(B11_8));
-	} else {
+        } else {
             tcg_gen_qemu_ld_i32(FREG(B11_8), REG(B7_4), ctx->memidx,
                                 MO_TEUL | MO_ALIGN);
-	}
-	return;
+        }
+        return;
     case 0xf009: /* fmov @Rm+,{F,D,X}Rn - FPSCR: Nothing */
-	CHECK_FPU_ENABLED
+        CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
             TCGv_i64 fp = tcg_temp_new_i64();
             tcg_gen_qemu_ld_i64(fp, REG(B7_4), ctx->memidx,
                                 MO_TEUQ | MO_ALIGN);
             gen_store_fpr64(ctx, fp, XHACK(B11_8));
             tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 8);
-	} else {
+        } else {
             tcg_gen_qemu_ld_i32(FREG(B11_8), REG(B7_4), ctx->memidx,
                                 MO_TEUL | MO_ALIGN);
-	    tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 4);
-	}
-	return;
+            tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 4);
+        }
+        return;
     case 0xf00b: /* fmov {F,D,X}Rm,@-Rn - FPSCR: Nothing */
-	CHECK_FPU_ENABLED
+        CHECK_FPU_ENABLED
         {
             TCGv addr = tcg_temp_new_i32();
             if (ctx->tbflags & FPSCR_SZ) {
@@ -1016,108 +1016,108 @@ static void _decode_opc(DisasContext * ctx)
             }
             tcg_gen_mov_i32(REG(B11_8), addr);
         }
-	return;
+        return;
     case 0xf006: /* fmov @(R0,Rm),{F,D,X}Rm - FPSCR: Nothing */
-	CHECK_FPU_ENABLED
-	{
-	    TCGv addr = tcg_temp_new_i32();
-	    tcg_gen_add_i32(addr, REG(B7_4), REG(0));
+        CHECK_FPU_ENABLED
+        {
+            TCGv addr = tcg_temp_new_i32();
+            tcg_gen_add_i32(addr, REG(B7_4), REG(0));
             if (ctx->tbflags & FPSCR_SZ) {
                 TCGv_i64 fp = tcg_temp_new_i64();
                 tcg_gen_qemu_ld_i64(fp, addr, ctx->memidx,
                                     MO_TEUQ | MO_ALIGN);
                 gen_store_fpr64(ctx, fp, XHACK(B11_8));
-	    } else {
+            } else {
                 tcg_gen_qemu_ld_i32(FREG(B11_8), addr, ctx->memidx,
                                     MO_TEUL | MO_ALIGN);
-	    }
-	}
-	return;
+            }
+        }
+        return;
     case 0xf007: /* fmov {F,D,X}Rn,@(R0,Rn) - FPSCR: Nothing */
-	CHECK_FPU_ENABLED
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_add_i32(addr, REG(B11_8), REG(0));
+        CHECK_FPU_ENABLED
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_add_i32(addr, REG(B11_8), REG(0));
             if (ctx->tbflags & FPSCR_SZ) {
                 TCGv_i64 fp = tcg_temp_new_i64();
                 gen_load_fpr64(ctx, fp, XHACK(B7_4));
                 tcg_gen_qemu_st_i64(fp, addr, ctx->memidx,
                                     MO_TEUQ | MO_ALIGN);
-	    } else {
+            } else {
                 tcg_gen_qemu_st_i32(FREG(B7_4), addr, ctx->memidx,
                                     MO_TEUL | MO_ALIGN);
-	    }
-	}
-	return;
+            }
+        }
+        return;
     case 0xf000: /* fadd Rm,Rn - FPSCR: R[PR,Enable.O/U/I]/W[Cause,Flag] */
     case 0xf001: /* fsub Rm,Rn - FPSCR: R[PR,Enable.O/U/I]/W[Cause,Flag] */
     case 0xf002: /* fmul Rm,Rn - FPSCR: R[PR,Enable.O/U/I]/W[Cause,Flag] */
     case 0xf003: /* fdiv Rm,Rn - FPSCR: R[PR,Enable.O/U/I]/W[Cause,Flag] */
     case 0xf004: /* fcmp/eq Rm,Rn - FPSCR: R[PR,Enable.V]/W[Cause,Flag] */
     case 0xf005: /* fcmp/gt Rm,Rn - FPSCR: R[PR,Enable.V]/W[Cause,Flag] */
-	{
-	    CHECK_FPU_ENABLED
+        {
+            CHECK_FPU_ENABLED
             if (ctx->tbflags & FPSCR_PR) {
                 TCGv_i64 fp0, fp1;
 
                 if (ctx->opcode & 0x0110) {
                     goto do_illegal;
                 }
-		fp0 = tcg_temp_new_i64();
-		fp1 = tcg_temp_new_i64();
+                fp0 = tcg_temp_new_i64();
+                fp1 = tcg_temp_new_i64();
                 gen_load_fpr64(ctx, fp0, B11_8);
                 gen_load_fpr64(ctx, fp1, B7_4);
                 switch (ctx->opcode & 0xf00f) {
-                case 0xf000:		/* fadd Rm,Rn */
+                case 0xf000: /* fadd Rm,Rn */
                     gen_helper_fadd_DT(fp0, tcg_env, fp0, fp1);
                     break;
-                case 0xf001:		/* fsub Rm,Rn */
+                case 0xf001: /* fsub Rm,Rn */
                     gen_helper_fsub_DT(fp0, tcg_env, fp0, fp1);
                     break;
-                case 0xf002:		/* fmul Rm,Rn */
+                case 0xf002: /* fmul Rm,Rn */
                     gen_helper_fmul_DT(fp0, tcg_env, fp0, fp1);
                     break;
-                case 0xf003:		/* fdiv Rm,Rn */
+                case 0xf003: /* fdiv Rm,Rn */
                     gen_helper_fdiv_DT(fp0, tcg_env, fp0, fp1);
                     break;
-                case 0xf004:		/* fcmp/eq Rm,Rn */
+                case 0xf004: /* fcmp/eq Rm,Rn */
                     gen_helper_fcmp_eq_DT(cpu_sr_t, tcg_env, fp0, fp1);
                     return;
-                case 0xf005:		/* fcmp/gt Rm,Rn */
+                case 0xf005: /* fcmp/gt Rm,Rn */
                     gen_helper_fcmp_gt_DT(cpu_sr_t, tcg_env, fp0, fp1);
                     return;
                 }
                 gen_store_fpr64(ctx, fp0, B11_8);
-	    } else {
+            } else {
                 switch (ctx->opcode & 0xf00f) {
-                case 0xf000:		/* fadd Rm,Rn */
+                case 0xf000: /* fadd Rm,Rn */
                     gen_helper_fadd_FT(FREG(B11_8), tcg_env,
                                        FREG(B11_8), FREG(B7_4));
                     break;
-                case 0xf001:		/* fsub Rm,Rn */
+                case 0xf001: /* fsub Rm,Rn */
                     gen_helper_fsub_FT(FREG(B11_8), tcg_env,
                                        FREG(B11_8), FREG(B7_4));
                     break;
-                case 0xf002:		/* fmul Rm,Rn */
+                case 0xf002: /* fmul Rm,Rn */
                     gen_helper_fmul_FT(FREG(B11_8), tcg_env,
                                        FREG(B11_8), FREG(B7_4));
                     break;
-                case 0xf003:		/* fdiv Rm,Rn */
+                case 0xf003: /* fdiv Rm,Rn */
                     gen_helper_fdiv_FT(FREG(B11_8), tcg_env,
                                        FREG(B11_8), FREG(B7_4));
                     break;
-                case 0xf004:		/* fcmp/eq Rm,Rn */
+                case 0xf004: /* fcmp/eq Rm,Rn */
                     gen_helper_fcmp_eq_FT(cpu_sr_t, tcg_env,
                                           FREG(B11_8), FREG(B7_4));
                     return;
-                case 0xf005:		/* fcmp/gt Rm,Rn */
+                case 0xf005: /* fcmp/gt Rm,Rn */
                     gen_helper_fcmp_gt_FT(cpu_sr_t, tcg_env,
                                           FREG(B11_8), FREG(B7_4));
                     return;
                 }
-	    }
-	}
-	return;
+            }
+        }
+        return;
     case 0xf00e: /* fmac FR0,RM,Rn */
         CHECK_FPU_ENABLED
         CHECK_FPSCR_PR_0
@@ -1127,348 +1127,348 @@ static void _decode_opc(DisasContext * ctx)
     }
 
     switch (ctx->opcode & 0xff00) {
-    case 0xc900:		/* and #imm,R0 */
-	tcg_gen_andi_i32(REG(0), REG(0), B7_0);
-	return;
-    case 0xcd00:		/* and.b #imm,@(R0,GBR) */
-	{
-	    TCGv addr, val;
-	    addr = tcg_temp_new();
-	    tcg_gen_add_i32(addr, REG(0), cpu_gbr);
-	    val = tcg_temp_new();
+    case 0xc900: /* and #imm,R0 */
+        tcg_gen_andi_i32(REG(0), REG(0), B7_0);
+        return;
+    case 0xcd00: /* and.b #imm,@(R0,GBR) */
+        {
+            TCGv addr, val;
+            addr = tcg_temp_new();
+            tcg_gen_add_i32(addr, REG(0), cpu_gbr);
+            val = tcg_temp_new();
             tcg_gen_qemu_ld_i32(val, addr, ctx->memidx, MO_UB);
-	    tcg_gen_andi_i32(val, val, B7_0);
+            tcg_gen_andi_i32(val, val, B7_0);
             tcg_gen_qemu_st_i32(val, addr, ctx->memidx, MO_UB);
-	}
-	return;
-    case 0x8b00:		/* bf label */
-	CHECK_NOT_DELAY_SLOT
+        }
+        return;
+    case 0x8b00: /* bf label */
+        CHECK_NOT_DELAY_SLOT
         gen_conditional_jump(ctx, ctx->base.pc_next + 4 + B7_0s * 2, false);
-	return;
-    case 0x8f00:		/* bf/s label */
-	CHECK_NOT_DELAY_SLOT
+        return;
+    case 0x8f00: /* bf/s label */
+        CHECK_NOT_DELAY_SLOT
         tcg_gen_xori_i32(cpu_delayed_cond, cpu_sr_t, 1);
         ctx->delayed_pc = ctx->base.pc_next + 4 + B7_0s * 2;
         ctx->envflags |= TB_FLAG_DELAY_SLOT_COND;
-	return;
-    case 0x8900:		/* bt label */
-	CHECK_NOT_DELAY_SLOT
+        return;
+    case 0x8900: /* bt label */
+        CHECK_NOT_DELAY_SLOT
         gen_conditional_jump(ctx, ctx->base.pc_next + 4 + B7_0s * 2, true);
-	return;
-    case 0x8d00:		/* bt/s label */
-	CHECK_NOT_DELAY_SLOT
+        return;
+    case 0x8d00: /* bt/s label */
+        CHECK_NOT_DELAY_SLOT
         tcg_gen_mov_i32(cpu_delayed_cond, cpu_sr_t);
         ctx->delayed_pc = ctx->base.pc_next + 4 + B7_0s * 2;
         ctx->envflags |= TB_FLAG_DELAY_SLOT_COND;
-	return;
-    case 0x8800:		/* cmp/eq #imm,R0 */
+        return;
+    case 0x8800: /* cmp/eq #imm,R0 */
         tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_t, REG(0), B7_0s);
-	return;
-    case 0xc400:		/* mov.b @(disp,GBR),R0 */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_addi_i32(addr, cpu_gbr, B7_0);
+        return;
+    case 0xc400: /* mov.b @(disp,GBR),R0 */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_addi_i32(addr, cpu_gbr, B7_0);
             tcg_gen_qemu_ld_i32(REG(0), addr, ctx->memidx, MO_SB);
-	}
-	return;
-    case 0xc500:		/* mov.w @(disp,GBR),R0 */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_addi_i32(addr, cpu_gbr, B7_0 * 2);
+        }
+        return;
+    case 0xc500: /* mov.w @(disp,GBR),R0 */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_addi_i32(addr, cpu_gbr, B7_0 * 2);
             tcg_gen_qemu_ld_i32(REG(0), addr, ctx->memidx, MO_TESW | MO_ALIGN);
-	}
-	return;
-    case 0xc600:		/* mov.l @(disp,GBR),R0 */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_addi_i32(addr, cpu_gbr, B7_0 * 4);
+        }
+        return;
+    case 0xc600: /* mov.l @(disp,GBR),R0 */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_addi_i32(addr, cpu_gbr, B7_0 * 4);
             tcg_gen_qemu_ld_i32(REG(0), addr, ctx->memidx, MO_TESL | MO_ALIGN);
-	}
-	return;
-    case 0xc000:		/* mov.b R0,@(disp,GBR) */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_addi_i32(addr, cpu_gbr, B7_0);
+        }
+        return;
+    case 0xc000: /* mov.b R0,@(disp,GBR) */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_addi_i32(addr, cpu_gbr, B7_0);
             tcg_gen_qemu_st_i32(REG(0), addr, ctx->memidx, MO_UB);
-	}
-	return;
-    case 0xc100:		/* mov.w R0,@(disp,GBR) */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_addi_i32(addr, cpu_gbr, B7_0 * 2);
+        }
+        return;
+    case 0xc100: /* mov.w R0,@(disp,GBR) */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_addi_i32(addr, cpu_gbr, B7_0 * 2);
             tcg_gen_qemu_st_i32(REG(0), addr, ctx->memidx, MO_TEUW | MO_ALIGN);
-	}
-	return;
-    case 0xc200:		/* mov.l R0,@(disp,GBR) */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_addi_i32(addr, cpu_gbr, B7_0 * 4);
+        }
+        return;
+    case 0xc200: /* mov.l R0,@(disp,GBR) */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_addi_i32(addr, cpu_gbr, B7_0 * 4);
             tcg_gen_qemu_st_i32(REG(0), addr, ctx->memidx, MO_TEUL | MO_ALIGN);
-	}
-	return;
-    case 0x8000:		/* mov.b R0,@(disp,Rn) */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_addi_i32(addr, REG(B7_4), B3_0);
+        }
+        return;
+    case 0x8000: /* mov.b R0,@(disp,Rn) */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_addi_i32(addr, REG(B7_4), B3_0);
             tcg_gen_qemu_st_i32(REG(0), addr, ctx->memidx, MO_UB);
-	}
-	return;
-    case 0x8100:		/* mov.w R0,@(disp,Rn) */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_addi_i32(addr, REG(B7_4), B3_0 * 2);
+        }
+        return;
+    case 0x8100: /* mov.w R0,@(disp,Rn) */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_addi_i32(addr, REG(B7_4), B3_0 * 2);
             tcg_gen_qemu_st_i32(REG(0), addr, ctx->memidx,
                                 MO_TEUW | UNALIGN(ctx));
-	}
-	return;
-    case 0x8400:		/* mov.b @(disp,Rn),R0 */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_addi_i32(addr, REG(B7_4), B3_0);
+        }
+        return;
+    case 0x8400: /* mov.b @(disp,Rn),R0 */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_addi_i32(addr, REG(B7_4), B3_0);
             tcg_gen_qemu_ld_i32(REG(0), addr, ctx->memidx, MO_SB);
-	}
-	return;
-    case 0x8500:		/* mov.w @(disp,Rn),R0 */
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_addi_i32(addr, REG(B7_4), B3_0 * 2);
+        }
+        return;
+    case 0x8500: /* mov.w @(disp,Rn),R0 */
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_addi_i32(addr, REG(B7_4), B3_0 * 2);
             tcg_gen_qemu_ld_i32(REG(0), addr, ctx->memidx,
                                 MO_TESW | UNALIGN(ctx));
-	}
-	return;
-    case 0xc700:		/* mova @(disp,PC),R0 */
+        }
+        return;
+    case 0xc700: /* mova @(disp,PC),R0 */
         tcg_gen_movi_i32(REG(0), ((ctx->base.pc_next & 0xfffffffc) +
                                   4 + B7_0 * 4) & ~3);
-	return;
-    case 0xcb00:		/* or #imm,R0 */
-	tcg_gen_ori_i32(REG(0), REG(0), B7_0);
-	return;
-    case 0xcf00:		/* or.b #imm,@(R0,GBR) */
-	{
-	    TCGv addr, val;
-	    addr = tcg_temp_new();
-	    tcg_gen_add_i32(addr, REG(0), cpu_gbr);
-	    val = tcg_temp_new();
+        return;
+    case 0xcb00: /* or #imm,R0 */
+        tcg_gen_ori_i32(REG(0), REG(0), B7_0);
+        return;
+    case 0xcf00: /* or.b #imm,@(R0,GBR) */
+        {
+            TCGv addr, val;
+            addr = tcg_temp_new();
+            tcg_gen_add_i32(addr, REG(0), cpu_gbr);
+            val = tcg_temp_new();
             tcg_gen_qemu_ld_i32(val, addr, ctx->memidx, MO_UB);
-	    tcg_gen_ori_i32(val, val, B7_0);
+            tcg_gen_ori_i32(val, val, B7_0);
             tcg_gen_qemu_st_i32(val, addr, ctx->memidx, MO_UB);
-	}
-	return;
-    case 0xc300:		/* trapa #imm */
-	{
-	    TCGv imm;
-	    CHECK_NOT_DELAY_SLOT
+        }
+        return;
+    case 0xc300: /* trapa #imm */
+        {
+            TCGv imm;
+            CHECK_NOT_DELAY_SLOT
             gen_save_cpu_state(ctx, true);
-	    imm = tcg_constant_i32(B7_0);
+            imm = tcg_constant_i32(B7_0);
             gen_helper_trapa(tcg_env, imm);
             ctx->base.is_jmp = DISAS_NORETURN;
-	}
-	return;
-    case 0xc800:		/* tst #imm,R0 */
-	{
-	    TCGv val = tcg_temp_new();
-	    tcg_gen_andi_i32(val, REG(0), B7_0);
+        }
+        return;
+    case 0xc800: /* tst #imm,R0 */
+        {
+            TCGv val = tcg_temp_new();
+            tcg_gen_andi_i32(val, REG(0), B7_0);
             tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_t, val, 0);
-	}
-	return;
-    case 0xcc00:		/* tst.b #imm,@(R0,GBR) */
-	{
-	    TCGv val = tcg_temp_new();
-	    tcg_gen_add_i32(val, REG(0), cpu_gbr);
+        }
+        return;
+    case 0xcc00: /* tst.b #imm,@(R0,GBR) */
+        {
+            TCGv val = tcg_temp_new();
+            tcg_gen_add_i32(val, REG(0), cpu_gbr);
             tcg_gen_qemu_ld_i32(val, val, ctx->memidx, MO_UB);
-	    tcg_gen_andi_i32(val, val, B7_0);
+            tcg_gen_andi_i32(val, val, B7_0);
             tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_t, val, 0);
-	}
-	return;
-    case 0xca00:		/* xor #imm,R0 */
-	tcg_gen_xori_i32(REG(0), REG(0), B7_0);
-	return;
-    case 0xce00:		/* xor.b #imm,@(R0,GBR) */
-	{
-	    TCGv addr, val;
-	    addr = tcg_temp_new();
-	    tcg_gen_add_i32(addr, REG(0), cpu_gbr);
-	    val = tcg_temp_new();
+        }
+        return;
+    case 0xca00: /* xor #imm,R0 */
+        tcg_gen_xori_i32(REG(0), REG(0), B7_0);
+        return;
+    case 0xce00: /* xor.b #imm,@(R0,GBR) */
+        {
+            TCGv addr, val;
+            addr = tcg_temp_new();
+            tcg_gen_add_i32(addr, REG(0), cpu_gbr);
+            val = tcg_temp_new();
             tcg_gen_qemu_ld_i32(val, addr, ctx->memidx, MO_UB);
-	    tcg_gen_xori_i32(val, val, B7_0);
+            tcg_gen_xori_i32(val, val, B7_0);
             tcg_gen_qemu_st_i32(val, addr, ctx->memidx, MO_UB);
-	}
-	return;
+        }
+        return;
     }
 
     switch (ctx->opcode & 0xf08f) {
-    case 0x408e:		/* ldc Rm,Rn_BANK */
-	CHECK_PRIVILEGED
-	tcg_gen_mov_i32(ALTREG(B6_4), REG(B11_8));
-	return;
-    case 0x4087:		/* ldc.l @Rm+,Rn_BANK */
-	CHECK_PRIVILEGED
+    case 0x408e: /* ldc Rm,Rn_BANK */
+        CHECK_PRIVILEGED
+        tcg_gen_mov_i32(ALTREG(B6_4), REG(B11_8));
+        return;
+    case 0x4087: /* ldc.l @Rm+,Rn_BANK */
+        CHECK_PRIVILEGED
         tcg_gen_qemu_ld_i32(ALTREG(B6_4), REG(B11_8), ctx->memidx,
                             MO_TESL | MO_ALIGN);
-	tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
-	return;
-    case 0x0082:		/* stc Rm_BANK,Rn */
-	CHECK_PRIVILEGED
-	tcg_gen_mov_i32(REG(B11_8), ALTREG(B6_4));
-	return;
-    case 0x4083:		/* stc.l Rm_BANK,@-Rn */
-	CHECK_PRIVILEGED
-	{
-	    TCGv addr = tcg_temp_new();
-	    tcg_gen_subi_i32(addr, REG(B11_8), 4);
+        tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
+        return;
+    case 0x0082: /* stc Rm_BANK,Rn */
+        CHECK_PRIVILEGED
+        tcg_gen_mov_i32(REG(B11_8), ALTREG(B6_4));
+        return;
+    case 0x4083: /* stc.l Rm_BANK,@-Rn */
+        CHECK_PRIVILEGED
+        {
+            TCGv addr = tcg_temp_new();
+            tcg_gen_subi_i32(addr, REG(B11_8), 4);
             tcg_gen_qemu_st_i32(ALTREG(B6_4), addr, ctx->memidx,
                                 MO_TEUL | MO_ALIGN);
-	    tcg_gen_mov_i32(REG(B11_8), addr);
-	}
-	return;
+            tcg_gen_mov_i32(REG(B11_8), addr);
+        }
+        return;
     }
 
     switch (ctx->opcode & 0xf0ff) {
-    case 0x0023:		/* braf Rn */
-	CHECK_NOT_DELAY_SLOT
+    case 0x0023: /* braf Rn */
+        CHECK_NOT_DELAY_SLOT
         tcg_gen_addi_i32(cpu_delayed_pc, REG(B11_8), ctx->base.pc_next + 4);
         ctx->envflags |= TB_FLAG_DELAY_SLOT;
-	ctx->delayed_pc = (uint32_t) - 1;
-	return;
-    case 0x0003:		/* bsrf Rn */
-	CHECK_NOT_DELAY_SLOT
+        ctx->delayed_pc = (uint32_t) - 1;
+        return;
+    case 0x0003: /* bsrf Rn */
+        CHECK_NOT_DELAY_SLOT
         tcg_gen_movi_i32(cpu_pr, ctx->base.pc_next + 4);
-	tcg_gen_add_i32(cpu_delayed_pc, REG(B11_8), cpu_pr);
+        tcg_gen_add_i32(cpu_delayed_pc, REG(B11_8), cpu_pr);
         ctx->envflags |= TB_FLAG_DELAY_SLOT;
-	ctx->delayed_pc = (uint32_t) - 1;
-	return;
-    case 0x4015:		/* cmp/pl Rn */
+        ctx->delayed_pc = (uint32_t) - 1;
+        return;
+    case 0x4015: /* cmp/pl Rn */
         tcg_gen_setcondi_i32(TCG_COND_GT, cpu_sr_t, REG(B11_8), 0);
-	return;
-    case 0x4011:		/* cmp/pz Rn */
+        return;
+    case 0x4011: /* cmp/pz Rn */
         tcg_gen_setcondi_i32(TCG_COND_GE, cpu_sr_t, REG(B11_8), 0);
-	return;
-    case 0x4010:		/* dt Rn */
-	tcg_gen_subi_i32(REG(B11_8), REG(B11_8), 1);
+        return;
+    case 0x4010: /* dt Rn */
+        tcg_gen_subi_i32(REG(B11_8), REG(B11_8), 1);
         tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_t, REG(B11_8), 0);
-	return;
-    case 0x402b:		/* jmp @Rn */
-	CHECK_NOT_DELAY_SLOT
-	tcg_gen_mov_i32(cpu_delayed_pc, REG(B11_8));
+        return;
+    case 0x402b: /* jmp @Rn */
+        CHECK_NOT_DELAY_SLOT
+        tcg_gen_mov_i32(cpu_delayed_pc, REG(B11_8));
         ctx->envflags |= TB_FLAG_DELAY_SLOT;
-	ctx->delayed_pc = (uint32_t) - 1;
-	return;
-    case 0x400b:		/* jsr @Rn */
-	CHECK_NOT_DELAY_SLOT
+        ctx->delayed_pc = (uint32_t) - 1;
+        return;
+    case 0x400b: /* jsr @Rn */
+        CHECK_NOT_DELAY_SLOT
         tcg_gen_movi_i32(cpu_pr, ctx->base.pc_next + 4);
-	tcg_gen_mov_i32(cpu_delayed_pc, REG(B11_8));
+        tcg_gen_mov_i32(cpu_delayed_pc, REG(B11_8));
         ctx->envflags |= TB_FLAG_DELAY_SLOT;
-	ctx->delayed_pc = (uint32_t) - 1;
-	return;
-    case 0x400e:		/* ldc Rm,SR */
-	CHECK_PRIVILEGED
+        ctx->delayed_pc = (uint32_t) - 1;
+        return;
+    case 0x400e: /* ldc Rm,SR */
+        CHECK_PRIVILEGED
         {
             TCGv val = tcg_temp_new();
             tcg_gen_andi_i32(val, REG(B11_8), 0x700083f3);
             gen_write_sr(val);
             ctx->base.is_jmp = DISAS_STOP;
         }
-	return;
-    case 0x4007:		/* ldc.l @Rm+,SR */
-	CHECK_PRIVILEGED
-	{
-	    TCGv val = tcg_temp_new();
+        return;
+    case 0x4007: /* ldc.l @Rm+,SR */
+        CHECK_PRIVILEGED
+        {
+            TCGv val = tcg_temp_new();
             tcg_gen_qemu_ld_i32(val, REG(B11_8), ctx->memidx,
                                 MO_TESL | MO_ALIGN);
             tcg_gen_andi_i32(val, val, 0x700083f3);
             gen_write_sr(val);
-	    tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
+            tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
             ctx->base.is_jmp = DISAS_STOP;
-	}
-	return;
-    case 0x0002:		/* stc SR,Rn */
-	CHECK_PRIVILEGED
+        }
+        return;
+    case 0x0002: /* stc SR,Rn */
+        CHECK_PRIVILEGED
         gen_read_sr(REG(B11_8));
-	return;
-    case 0x4003:		/* stc SR,@-Rn */
-	CHECK_PRIVILEGED
-	{
-	    TCGv addr = tcg_temp_new();
+        return;
+    case 0x4003: /* stc SR,@-Rn */
+        CHECK_PRIVILEGED
+        {
+            TCGv addr = tcg_temp_new();
             TCGv val = tcg_temp_new();
-	    tcg_gen_subi_i32(addr, REG(B11_8), 4);
+            tcg_gen_subi_i32(addr, REG(B11_8), 4);
             gen_read_sr(val);
             tcg_gen_qemu_st_i32(val, addr, ctx->memidx, MO_TEUL | MO_ALIGN);
-	    tcg_gen_mov_i32(REG(B11_8), addr);
-	}
-	return;
-#define LD(reg,ldnum,ldpnum,prechk)		\
-  case ldnum:							\
-    prechk    							\
-    tcg_gen_mov_i32 (cpu_##reg, REG(B11_8));			\
-    return;							\
-  case ldpnum:							\
-    prechk    							\
-    tcg_gen_qemu_ld_i32(cpu_##reg, REG(B11_8), ctx->memidx,     \
-                        MO_TESL | MO_ALIGN);                    \
-    tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);		\
+            tcg_gen_mov_i32(REG(B11_8), addr);
+        }
+        return;
+#define LD(reg,ldnum,ldpnum,prechk)            \
+  case ldnum:                                                        \
+    prechk                                                           \
+    tcg_gen_mov_i32 (cpu_##reg, REG(B11_8));                         \
+    return;                                                          \
+  case ldpnum:                                                       \
+    prechk                                                           \
+    tcg_gen_qemu_ld_i32(cpu_##reg, REG(B11_8), ctx->memidx,          \
+                        MO_TESL | MO_ALIGN);                         \
+    tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);                     \
     return;
-#define ST(reg,stnum,stpnum,prechk)		\
-  case stnum:							\
-    prechk    							\
-    tcg_gen_mov_i32 (REG(B11_8), cpu_##reg);			\
-    return;							\
-  case stpnum:							\
-    prechk    							\
-    {								\
-	TCGv addr = tcg_temp_new();				\
-	tcg_gen_subi_i32(addr, REG(B11_8), 4);			\
-        tcg_gen_qemu_st_i32(cpu_##reg, addr, ctx->memidx,       \
-                            MO_TEUL | MO_ALIGN);                \
-	tcg_gen_mov_i32(REG(B11_8), addr);			\
-    }								\
+#define ST(reg,stnum,stpnum,prechk)                \
+  case stnum:                                                        \
+    prechk                                                           \
+    tcg_gen_mov_i32 (REG(B11_8), cpu_##reg);                         \
+    return;                                                          \
+  case stpnum:                                                       \
+    prechk                                                           \
+    {                                                                \
+        TCGv addr = tcg_temp_new();                                  \
+        tcg_gen_subi_i32(addr, REG(B11_8), 4);                       \
+        tcg_gen_qemu_st_i32(cpu_##reg, addr, ctx->memidx,            \
+                            MO_TEUL | MO_ALIGN);                     \
+        tcg_gen_mov_i32(REG(B11_8), addr);                           \
+    }                                                                \
     return;
-#define LDST(reg,ldnum,ldpnum,stnum,stpnum,prechk)		\
-	LD(reg,ldnum,ldpnum,prechk)				\
-	ST(reg,stnum,stpnum,prechk)
-	LDST(gbr,  0x401e, 0x4017, 0x0012, 0x4013, {})
-	LDST(vbr,  0x402e, 0x4027, 0x0022, 0x4023, CHECK_PRIVILEGED)
-	LDST(ssr,  0x403e, 0x4037, 0x0032, 0x4033, CHECK_PRIVILEGED)
-	LDST(spc,  0x404e, 0x4047, 0x0042, 0x4043, CHECK_PRIVILEGED)
-	ST(sgr,  0x003a, 0x4032, CHECK_PRIVILEGED)
+#define LDST(reg,ldnum,ldpnum,stnum,stpnum,prechk)                \
+        LD(reg,ldnum,ldpnum,prechk)                               \
+        ST(reg,stnum,stpnum,prechk)
+        LDST(gbr,  0x401e, 0x4017, 0x0012, 0x4013, {})
+        LDST(vbr,  0x402e, 0x4027, 0x0022, 0x4023, CHECK_PRIVILEGED)
+        LDST(ssr,  0x403e, 0x4037, 0x0032, 0x4033, CHECK_PRIVILEGED)
+        LDST(spc,  0x404e, 0x4047, 0x0042, 0x4043, CHECK_PRIVILEGED)
+        ST(sgr,  0x003a, 0x4032, CHECK_PRIVILEGED)
         LD(sgr,  0x403a, 0x4036, CHECK_PRIVILEGED CHECK_SH4A)
-	LDST(dbr,  0x40fa, 0x40f6, 0x00fa, 0x40f2, CHECK_PRIVILEGED)
-	LDST(mach, 0x400a, 0x4006, 0x000a, 0x4002, {})
-	LDST(macl, 0x401a, 0x4016, 0x001a, 0x4012, {})
-	LDST(pr,   0x402a, 0x4026, 0x002a, 0x4022, {})
-	LDST(fpul, 0x405a, 0x4056, 0x005a, 0x4052, {CHECK_FPU_ENABLED})
-    case 0x406a:		/* lds Rm,FPSCR */
-	CHECK_FPU_ENABLED
+        LDST(dbr,  0x40fa, 0x40f6, 0x00fa, 0x40f2, CHECK_PRIVILEGED)
+        LDST(mach, 0x400a, 0x4006, 0x000a, 0x4002, {})
+        LDST(macl, 0x401a, 0x4016, 0x001a, 0x4012, {})
+        LDST(pr,   0x402a, 0x4026, 0x002a, 0x4022, {})
+        LDST(fpul, 0x405a, 0x4056, 0x005a, 0x4052, {CHECK_FPU_ENABLED})
+    case 0x406a: /* lds Rm,FPSCR */
+        CHECK_FPU_ENABLED
         gen_helper_ld_fpscr(tcg_env, REG(B11_8));
         ctx->base.is_jmp = DISAS_STOP;
-	return;
-    case 0x4066:		/* lds.l @Rm+,FPSCR */
-	CHECK_FPU_ENABLED
-	{
-	    TCGv addr = tcg_temp_new();
+        return;
+    case 0x4066: /* lds.l @Rm+,FPSCR */
+        CHECK_FPU_ENABLED
+        {
+            TCGv addr = tcg_temp_new();
             tcg_gen_qemu_ld_i32(addr, REG(B11_8), ctx->memidx,
                                 MO_TESL | MO_ALIGN);
-	    tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
+            tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
             gen_helper_ld_fpscr(tcg_env, addr);
             ctx->base.is_jmp = DISAS_STOP;
-	}
-	return;
-    case 0x006a:		/* sts FPSCR,Rn */
-	CHECK_FPU_ENABLED
-	tcg_gen_andi_i32(REG(B11_8), cpu_fpscr, 0x003fffff);
-	return;
-    case 0x4062:		/* sts FPSCR,@-Rn */
-	CHECK_FPU_ENABLED
-	{
-	    TCGv addr, val;
-	    val = tcg_temp_new();
-	    tcg_gen_andi_i32(val, cpu_fpscr, 0x003fffff);
-	    addr = tcg_temp_new();
-	    tcg_gen_subi_i32(addr, REG(B11_8), 4);
+        }
+        return;
+    case 0x006a: /* sts FPSCR,Rn */
+        CHECK_FPU_ENABLED
+        tcg_gen_andi_i32(REG(B11_8), cpu_fpscr, 0x003fffff);
+        return;
+    case 0x4062: /* sts FPSCR,@-Rn */
+        CHECK_FPU_ENABLED
+        {
+            TCGv addr, val;
+            val = tcg_temp_new();
+            tcg_gen_andi_i32(val, cpu_fpscr, 0x003fffff);
+            addr = tcg_temp_new();
+            tcg_gen_subi_i32(addr, REG(B11_8), 4);
             tcg_gen_qemu_st_i32(val, addr, ctx->memidx, MO_TEUL | MO_ALIGN);
-	    tcg_gen_mov_i32(REG(B11_8), addr);
-	}
-	return;
-    case 0x00c3:		/* movca.l R0,@Rm */
+            tcg_gen_mov_i32(REG(B11_8), addr);
+        }
+        return;
+    case 0x00c3: /* movca.l R0,@Rm */
         {
             TCGv val = tcg_temp_new();
             tcg_gen_qemu_ld_i32(val, REG(B11_8), ctx->memidx,
@@ -1478,23 +1478,23 @@ static void _decode_opc(DisasContext * ctx)
                                 MO_TEUL | MO_ALIGN);
         }
         ctx->has_movcal = 1;
-	return;
-    case 0x40a9:                /* movua.l @Rm,R0 */
+        return;
+    case 0x40a9: /* movua.l @Rm,R0 */
         CHECK_SH4A
         /* Load non-boundary-aligned data */
         tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx,
                             MO_TEUL | MO_UNALN);
         return;
-    case 0x40e9:                /* movua.l @Rm+,R0 */
+    case 0x40e9: /* movua.l @Rm+,R0 */
         CHECK_SH4A
         /* Load non-boundary-aligned data */
         tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx,
                             MO_TEUL | MO_UNALN);
         tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
         return;
-    case 0x0029:		/* movt Rn */
+    case 0x0029: /* movt Rn */
         tcg_gen_mov_i32(REG(B11_8), cpu_sr_t);
-	return;
+        return;
     case 0x0073:
         /* MOVCO.L
          *     LDST -> T
@@ -1558,182 +1558,182 @@ static void _decode_opc(DisasContext * ctx)
             tcg_gen_movi_i32(cpu_lock_addr, 0);
         }
         return;
-    case 0x0093:		/* ocbi @Rn */
-	{
+    case 0x0093: /* ocbi @Rn */
+        {
             gen_helper_ocbi(tcg_env, REG(B11_8));
-	}
-	return;
-    case 0x00a3:		/* ocbp @Rn */
-    case 0x00b3:		/* ocbwb @Rn */
+        }
+        return;
+    case 0x00a3: /* ocbp @Rn */
+    case 0x00b3: /* ocbwb @Rn */
         /* These instructions are supposed to do nothing in case of
            a cache miss. Given that we only partially emulate caches
            it is safe to simply ignore them. */
-	return;
-    case 0x0083:		/* pref @Rn */
-	return;
-    case 0x00d3:		/* prefi @Rn */
+        return;
+    case 0x0083: /* pref @Rn */
+        return;
+    case 0x00d3: /* prefi @Rn */
         CHECK_SH4A
         return;
-    case 0x00e3:		/* icbi @Rn */
+    case 0x00e3: /* icbi @Rn */
         CHECK_SH4A
         return;
-    case 0x00ab:		/* synco */
+    case 0x00ab: /* synco */
         CHECK_SH4A
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
         return;
-    case 0x4024:		/* rotcl Rn */
-	{
-	    TCGv tmp = tcg_temp_new();
+    case 0x4024: /* rotcl Rn */
+        {
+            TCGv tmp = tcg_temp_new();
             tcg_gen_mov_i32(tmp, cpu_sr_t);
             tcg_gen_shri_i32(cpu_sr_t, REG(B11_8), 31);
-	    tcg_gen_shli_i32(REG(B11_8), REG(B11_8), 1);
+            tcg_gen_shli_i32(REG(B11_8), REG(B11_8), 1);
             tcg_gen_or_i32(REG(B11_8), REG(B11_8), tmp);
-	}
-	return;
-    case 0x4025:		/* rotcr Rn */
-	{
-	    TCGv tmp = tcg_temp_new();
+        }
+        return;
+    case 0x4025: /* rotcr Rn */
+        {
+            TCGv tmp = tcg_temp_new();
             tcg_gen_shli_i32(tmp, cpu_sr_t, 31);
             tcg_gen_andi_i32(cpu_sr_t, REG(B11_8), 1);
-	    tcg_gen_shri_i32(REG(B11_8), REG(B11_8), 1);
+            tcg_gen_shri_i32(REG(B11_8), REG(B11_8), 1);
             tcg_gen_or_i32(REG(B11_8), REG(B11_8), tmp);
-	}
-	return;
-    case 0x4004:		/* rotl Rn */
-	tcg_gen_rotli_i32(REG(B11_8), REG(B11_8), 1);
+        }
+        return;
+    case 0x4004: /* rotl Rn */
+        tcg_gen_rotli_i32(REG(B11_8), REG(B11_8), 1);
         tcg_gen_andi_i32(cpu_sr_t, REG(B11_8), 0);
-	return;
-    case 0x4005:		/* rotr Rn */
+        return;
+    case 0x4005: /* rotr Rn */
         tcg_gen_andi_i32(cpu_sr_t, REG(B11_8), 0);
-	tcg_gen_rotri_i32(REG(B11_8), REG(B11_8), 1);
-	return;
-    case 0x4000:		/* shll Rn */
-    case 0x4020:		/* shal Rn */
+        tcg_gen_rotri_i32(REG(B11_8), REG(B11_8), 1);
+        return;
+    case 0x4000: /* shll Rn */
+    case 0x4020: /* shal Rn */
         tcg_gen_shri_i32(cpu_sr_t, REG(B11_8), 31);
-	tcg_gen_shli_i32(REG(B11_8), REG(B11_8), 1);
-	return;
-    case 0x4021:		/* shar Rn */
+        tcg_gen_shli_i32(REG(B11_8), REG(B11_8), 1);
+        return;
+    case 0x4021: /* shar Rn */
         tcg_gen_andi_i32(cpu_sr_t, REG(B11_8), 1);
-	tcg_gen_sari_i32(REG(B11_8), REG(B11_8), 1);
-	return;
-    case 0x4001:		/* shlr Rn */
+        tcg_gen_sari_i32(REG(B11_8), REG(B11_8), 1);
+        return;
+    case 0x4001: /* shlr Rn */
         tcg_gen_andi_i32(cpu_sr_t, REG(B11_8), 1);
-	tcg_gen_shri_i32(REG(B11_8), REG(B11_8), 1);
-	return;
-    case 0x4008:		/* shll2 Rn */
-	tcg_gen_shli_i32(REG(B11_8), REG(B11_8), 2);
-	return;
-    case 0x4018:		/* shll8 Rn */
-	tcg_gen_shli_i32(REG(B11_8), REG(B11_8), 8);
-	return;
-    case 0x4028:		/* shll16 Rn */
-	tcg_gen_shli_i32(REG(B11_8), REG(B11_8), 16);
-	return;
-    case 0x4009:		/* shlr2 Rn */
-	tcg_gen_shri_i32(REG(B11_8), REG(B11_8), 2);
-	return;
-    case 0x4019:		/* shlr8 Rn */
-	tcg_gen_shri_i32(REG(B11_8), REG(B11_8), 8);
-	return;
-    case 0x4029:		/* shlr16 Rn */
-	tcg_gen_shri_i32(REG(B11_8), REG(B11_8), 16);
-	return;
-    case 0x401b:		/* tas.b @Rn */
+        tcg_gen_shri_i32(REG(B11_8), REG(B11_8), 1);
+        return;
+    case 0x4008: /* shll2 Rn */
+        tcg_gen_shli_i32(REG(B11_8), REG(B11_8), 2);
+        return;
+    case 0x4018: /* shll8 Rn */
+        tcg_gen_shli_i32(REG(B11_8), REG(B11_8), 8);
+        return;
+    case 0x4028: /* shll16 Rn */
+        tcg_gen_shli_i32(REG(B11_8), REG(B11_8), 16);
+        return;
+    case 0x4009: /* shlr2 Rn */
+        tcg_gen_shri_i32(REG(B11_8), REG(B11_8), 2);
+        return;
+    case 0x4019: /* shlr8 Rn */
+        tcg_gen_shri_i32(REG(B11_8), REG(B11_8), 8);
+        return;
+    case 0x4029: /* shlr16 Rn */
+        tcg_gen_shri_i32(REG(B11_8), REG(B11_8), 16);
+        return;
+    case 0x401b: /* tas.b @Rn */
         tcg_gen_atomic_fetch_or_i32(cpu_sr_t, REG(B11_8),
                                     tcg_constant_i32(0x80), ctx->memidx, MO_UB);
         tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_t, cpu_sr_t, 0);
         return;
     case 0xf00d: /* fsts FPUL,FRn - FPSCR: Nothing */
-	CHECK_FPU_ENABLED
+        CHECK_FPU_ENABLED
         tcg_gen_mov_i32(FREG(B11_8), cpu_fpul);
-	return;
+        return;
     case 0xf01d: /* flds FRm,FPUL - FPSCR: Nothing */
-	CHECK_FPU_ENABLED
+        CHECK_FPU_ENABLED
         tcg_gen_mov_i32(cpu_fpul, FREG(B11_8));
-	return;
+        return;
     case 0xf02d: /* float FPUL,FRn/DRn - FPSCR: R[PR,Enable.I]/W[Cause,Flag] */
-	CHECK_FPU_ENABLED
+        CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_PR) {
-	    TCGv_i64 fp;
+            TCGv_i64 fp;
             if (ctx->opcode & 0x0100) {
                 goto do_illegal;
             }
-	    fp = tcg_temp_new_i64();
+            fp = tcg_temp_new_i64();
             gen_helper_float_DT(fp, tcg_env, cpu_fpul);
             gen_store_fpr64(ctx, fp, B11_8);
-	}
-	else {
+        }
+        else {
             gen_helper_float_FT(FREG(B11_8), tcg_env, cpu_fpul);
-	}
-	return;
+        }
+        return;
     case 0xf03d: /* ftrc FRm/DRm,FPUL - FPSCR: R[PR,Enable.V]/W[Cause,Flag] */
-	CHECK_FPU_ENABLED
+        CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_PR) {
-	    TCGv_i64 fp;
+            TCGv_i64 fp;
             if (ctx->opcode & 0x0100) {
                 goto do_illegal;
             }
-	    fp = tcg_temp_new_i64();
+            fp = tcg_temp_new_i64();
             gen_load_fpr64(ctx, fp, B11_8);
             gen_helper_ftrc_DT(cpu_fpul, tcg_env, fp);
-	}
-	else {
+        }
+        else {
             gen_helper_ftrc_FT(cpu_fpul, tcg_env, FREG(B11_8));
-	}
-	return;
+        }
+        return;
     case 0xf04d: /* fneg FRn/DRn - FPSCR: Nothing */
-	CHECK_FPU_ENABLED
+        CHECK_FPU_ENABLED
         tcg_gen_xori_i32(FREG(B11_8), FREG(B11_8), 0x80000000);
-	return;
+        return;
     case 0xf05d: /* fabs FRn/DRn - FPCSR: Nothing */
-	CHECK_FPU_ENABLED
+        CHECK_FPU_ENABLED
         tcg_gen_andi_i32(FREG(B11_8), FREG(B11_8), 0x7fffffff);
-	return;
+        return;
     case 0xf06d: /* fsqrt FRn */
-	CHECK_FPU_ENABLED
+        CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_PR) {
             if (ctx->opcode & 0x0100) {
                 goto do_illegal;
             }
-	    TCGv_i64 fp = tcg_temp_new_i64();
+            TCGv_i64 fp = tcg_temp_new_i64();
             gen_load_fpr64(ctx, fp, B11_8);
             gen_helper_fsqrt_DT(fp, tcg_env, fp);
             gen_store_fpr64(ctx, fp, B11_8);
-	} else {
+        } else {
             gen_helper_fsqrt_FT(FREG(B11_8), tcg_env, FREG(B11_8));
-	}
-	return;
+        }
+        return;
     case 0xf07d: /* fsrra FRn */
-	CHECK_FPU_ENABLED
+        CHECK_FPU_ENABLED
         CHECK_FPSCR_PR_0
         gen_helper_fsrra_FT(FREG(B11_8), tcg_env, FREG(B11_8));
-	break;
+        break;
     case 0xf08d: /* fldi0 FRn - FPSCR: R[PR] */
-	CHECK_FPU_ENABLED
+        CHECK_FPU_ENABLED
         CHECK_FPSCR_PR_0
         tcg_gen_movi_i32(FREG(B11_8), 0);
         return;
     case 0xf09d: /* fldi1 FRn - FPSCR: R[PR] */
-	CHECK_FPU_ENABLED
+        CHECK_FPU_ENABLED
         CHECK_FPSCR_PR_0
         tcg_gen_movi_i32(FREG(B11_8), 0x3f800000);
         return;
     case 0xf0ad: /* fcnvsd FPUL,DRn */
-	CHECK_FPU_ENABLED
-	{
-	    TCGv_i64 fp = tcg_temp_new_i64();
+        CHECK_FPU_ENABLED
+        {
+            TCGv_i64 fp = tcg_temp_new_i64();
             gen_helper_fcnvsd_FT_DT(fp, tcg_env, cpu_fpul);
             gen_store_fpr64(ctx, fp, B11_8);
-	}
-	return;
+        }
+        return;
     case 0xf0bd: /* fcnvds DRn,FPUL */
-	CHECK_FPU_ENABLED
-	{
-	    TCGv_i64 fp = tcg_temp_new_i64();
+        CHECK_FPU_ENABLED
+        {
+            TCGv_i64 fp = tcg_temp_new_i64();
             gen_load_fpr64(ctx, fp, B11_8);
             gen_helper_fcnvds_DT_FT(cpu_fpul, tcg_env, fp);
-	}
-	return;
+        }
+        return;
     case 0xf0ed: /* fipr FVm,FVn */
         CHECK_FPU_ENABLED
         CHECK_FPSCR_PR_1
@@ -1808,10 +1808,10 @@ static void decode_opc(DisasContext * ctx)
 
         tcg_gen_movi_i32(cpu_flags, ctx->envflags);
         if (old_flags & TB_FLAG_DELAY_SLOT_COND) {
-	    gen_delayed_conditional_jump(ctx);
+            gen_delayed_conditional_jump(ctx);
         } else {
             gen_jump(ctx);
-	}
+        }
     }
 }
 
-- 
2.43.0


