Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FFE742CE7
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 21:05:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEwvO-0006bg-9G; Thu, 29 Jun 2023 15:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEwvM-0006aZ-4u
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 15:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qEwvJ-0005Pa-Ut
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 15:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688065401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIINR20cLuFy5TfvBjAXL66DCu1Ia2Ayx+1ab1RltGA=;
 b=TQIqGPXWzLMW8Bd9dbRkurwReBmvz/HaExAhisy3xTCW3qMfjUD90vACN5u7Gn4N2C2jn4
 M2M+dyUIRZQsjrHvKVCVTHi5AyqgC9JTNOWkv2g0iOHgn7j5HB2JxYpMg3rFxbDwZpw36/
 nq5qWISHxSvP6F88v6YuzgPXf2fBrwI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-Op289KDgPkauHuhnQHlN0w-1; Thu, 29 Jun 2023 15:03:17 -0400
X-MC-Unique: Op289KDgPkauHuhnQHlN0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 670E0185A793;
 Thu, 29 Jun 2023 19:03:16 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 693A8140E952;
 Thu, 29 Jun 2023 19:03:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/8] pc-bios/s390-ccw: Get rid of the the __u* types
Date: Thu, 29 Jun 2023 21:03:04 +0200
Message-Id: <20230629190310.337850-3-thuth@redhat.com>
In-Reply-To: <20230629190310.337850-1-thuth@redhat.com>
References: <20230629190310.337850-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The types starting with double underscores have likely been
introduced into the s390-ccw bios to be able to re-use structs
from the Linux kernel in the past, but the corresponding structs
in cio.h have been changed there a long time ago already to not
use the variants with the double underscores anymore:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/drivers/s390/cio/cio.h?id=cd6b4f27b9bb2a

So it would be good to replace these in the s390-ccw bios now, too.

Message-Id: <20230627114101.122231-1-thuth@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/cio.h      | 232 ++++++++++++++++++------------------
 pc-bios/s390-ccw/s390-ccw.h |   4 -
 2 files changed, 116 insertions(+), 120 deletions(-)

diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index 88a88adfd2..8b18153deb 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -17,32 +17,32 @@
  * path management control word
  */
 struct pmcw {
-    __u32 intparm;      /* interruption parameter */
-    __u32 qf:1;         /* qdio facility */
-    __u32 w:1;
-    __u32 isc:3;        /* interruption subclass */
-    __u32 res5:3;       /* reserved zeros */
-    __u32 ena:1;        /* enabled */
-    __u32 lm:2;         /* limit mode */
-    __u32 mme:2;        /* measurement-mode enable */
-    __u32 mp:1;         /* multipath mode */
-    __u32 tf:1;         /* timing facility */
-    __u32 dnv:1;        /* device number valid */
-    __u32 dev:16;       /* device number */
-    __u8  lpm;          /* logical path mask */
-    __u8  pnom;         /* path not operational mask */
-    __u8  lpum;         /* last path used mask */
-    __u8  pim;          /* path installed mask */
-    __u16 mbi;          /* measurement-block index */
-    __u8  pom;          /* path operational mask */
-    __u8  pam;          /* path available mask */
-    __u8  chpid[8];     /* CHPID 0-7 (if available) */
-    __u32 unused1:8;    /* reserved zeros */
-    __u32 st:3;         /* subchannel type */
-    __u32 unused2:18;   /* reserved zeros */
-    __u32 mbfc:1;       /* measurement block format control */
-    __u32 xmwme:1;      /* extended measurement word mode enable */
-    __u32 csense:1;     /* concurrent sense; can be enabled ...*/
+    u32 intparm;        /* interruption parameter */
+    u32 qf:1;           /* qdio facility */
+    u32 w:1;
+    u32 isc:3;          /* interruption subclass */
+    u32 res5:3;         /* reserved zeros */
+    u32 ena:1;          /* enabled */
+    u32 lm:2;           /* limit mode */
+    u32 mme:2;          /* measurement-mode enable */
+    u32 mp:1;           /* multipath mode */
+    u32 tf:1;           /* timing facility */
+    u32 dnv:1;          /* device number valid */
+    u32 dev:16;         /* device number */
+    u8  lpm;            /* logical path mask */
+    u8  pnom;           /* path not operational mask */
+    u8  lpum;           /* last path used mask */
+    u8  pim;            /* path installed mask */
+    u16 mbi;            /* measurement-block index */
+    u8  pom;            /* path operational mask */
+    u8  pam;            /* path available mask */
+    u8  chpid[8];       /* CHPID 0-7 (if available) */
+    u32 unused1:8;      /* reserved zeros */
+    u32 st:3;           /* subchannel type */
+    u32 unused2:18;     /* reserved zeros */
+    u32 mbfc:1;         /* measurement block format control */
+    u32 xmwme:1;        /* extended measurement word mode enable */
+    u32 csense:1;       /* concurrent sense; can be enabled ...*/
                         /*  ... per MSCH, however, if facility */
                         /*  ... is not installed, this results */
                         /*  ... in an operand exception.       */
@@ -50,24 +50,24 @@ struct pmcw {
 
 /* Target SCHIB configuration. */
 struct schib_config {
-    __u64 mba;
-    __u32 intparm;
-    __u16 mbi;
-    __u32 isc:3;
-    __u32 ena:1;
-    __u32 mme:2;
-    __u32 mp:1;
-    __u32 csense:1;
-    __u32 mbfc:1;
+    u64 mba;
+    u32 intparm;
+    u16 mbi;
+    u32 isc:3;
+    u32 ena:1;
+    u32 mme:2;
+    u32 mp:1;
+    u32 csense:1;
+    u32 mbfc:1;
 } __attribute__ ((packed));
 
 struct scsw {
-    __u16 flags;
-    __u16 ctrl;
-    __u32 cpa;
-    __u8 dstat;
-    __u8 cstat;
-    __u16 count;
+    u16 flags;
+    u16 ctrl;
+    u32 cpa;
+    u8 dstat;
+    u8 cstat;
+    u16 count;
 } __attribute__ ((packed));
 
 /* Function Control */
@@ -117,42 +117,42 @@ struct scsw {
 typedef struct schib {
     struct pmcw pmcw;     /* path management control word */
     struct scsw scsw;     /* subchannel status word */
-    __u64 mba;            /* measurement block address */
-    __u8 mda[4];          /* model dependent area */
+    u64 mba;              /* measurement block address */
+    u8 mda[4];            /* model dependent area */
 } __attribute__ ((packed, aligned(4))) Schib;
 
 typedef struct subchannel_id {
     union {
         struct {
-            __u16 cssid:8;
-            __u16 reserved:4;
-            __u16 m:1;
-            __u16 ssid:2;
-            __u16 one:1;
+            u16 cssid:8;
+            u16 reserved:4;
+            u16 m:1;
+            u16 ssid:2;
+            u16 one:1;
         };
-        __u16 sch_id;
+        u16 sch_id;
     };
-    __u16 sch_no;
+    u16 sch_no;
 } __attribute__ ((packed, aligned(4))) SubChannelId;
 
 struct chsc_header {
-    __u16 length;
-    __u16 code;
+    u16 length;
+    u16 code;
 } __attribute__((packed));
 
 typedef struct chsc_area_sda {
     struct chsc_header request;
-    __u8 reserved1:4;
-    __u8 format:4;
-    __u8 reserved2;
-    __u16 operation_code;
-    __u32 reserved3;
-    __u32 reserved4;
-    __u32 operation_data_area[252];
+    u8 reserved1:4;
+    u8 format:4;
+    u8 reserved2;
+    u16 operation_code;
+    u32 reserved3;
+    u32 reserved4;
+    u32 operation_data_area[252];
     struct chsc_header response;
-    __u32 reserved5:4;
-    __u32 format2:4;
-    __u32 reserved6:24;
+    u32 reserved5:4;
+    u32 format2:4;
+    u32 reserved6:24;
 } __attribute__((packed)) ChscAreaSda;
 
 /*
@@ -160,37 +160,37 @@ typedef struct chsc_area_sda {
  */
 struct tpi_info {
     struct subchannel_id schid;
-    __u32 intparm;      /* interruption parameter */
-    __u32 adapter_IO:1;
-    __u32 reserved2:1;
-    __u32 isc:3;
-    __u32 reserved3:12;
-    __u32 int_type:3;
-    __u32 reserved4:12;
+    u32 intparm;      /* interruption parameter */
+    u32 adapter_IO:1;
+    u32 reserved2:1;
+    u32 isc:3;
+    u32 reserved3:12;
+    u32 int_type:3;
+    u32 reserved4:12;
 } __attribute__ ((packed, aligned(4)));
 
 /* channel command word (format 0) */
 typedef struct ccw0 {
-    __u8 cmd_code;
-    __u32 cda:24;
-    __u32 chainData:1;
-    __u32 chain:1;
-    __u32 sli:1;
-    __u32 skip:1;
-    __u32 pci:1;
-    __u32 ida:1;
-    __u32 suspend:1;
-    __u32 mida:1;
-    __u8 reserved;
-    __u16 count;
+    u8 cmd_code;
+    u32 cda:24;
+    u32 chainData:1;
+    u32 chain:1;
+    u32 sli:1;
+    u32 skip:1;
+    u32 pci:1;
+    u32 ida:1;
+    u32 suspend:1;
+    u32 mida:1;
+    u8 reserved;
+    u16 count;
 } __attribute__ ((packed, aligned(8))) Ccw0;
 
 /* channel command word (format 1) */
 typedef struct ccw1 {
-    __u8 cmd_code;
-    __u8 flags;
-    __u16 count;
-    __u32 cda;
+    u8 cmd_code;
+    u8 flags;
+    u16 count;
+    u32 cda;
 } __attribute__ ((packed, aligned(8))) Ccw1;
 
 /* do_cio() CCW formats */
@@ -234,31 +234,31 @@ typedef struct ccw1 {
  * Command-mode operation request block
  */
 typedef struct cmd_orb {
-    __u32 intparm;    /* interruption parameter */
-    __u32 key:4;      /* flags, like key, suspend control, etc. */
-    __u32 spnd:1;     /* suspend control */
-    __u32 res1:1;     /* reserved */
-    __u32 mod:1;      /* modification control */
-    __u32 sync:1;     /* synchronize control */
-    __u32 fmt:1;      /* format control */
-    __u32 pfch:1;     /* prefetch control */
-    __u32 isic:1;     /* initial-status-interruption control */
-    __u32 alcc:1;     /* address-limit-checking control */
-    __u32 ssic:1;     /* suppress-suspended-interr. control */
-    __u32 res2:1;     /* reserved */
-    __u32 c64:1;      /* IDAW/QDIO 64 bit control  */
-    __u32 i2k:1;      /* IDAW 2/4kB block size control */
-    __u32 lpm:8;      /* logical path mask */
-    __u32 ils:1;      /* incorrect length */
-    __u32 zero:6;     /* reserved zeros */
-    __u32 orbx:1;     /* ORB extension control */
-    __u32 cpa;    /* channel program address */
+    u32 intparm;    /* interruption parameter */
+    u32 key:4;      /* flags, like key, suspend control, etc. */
+    u32 spnd:1;     /* suspend control */
+    u32 res1:1;     /* reserved */
+    u32 mod:1;      /* modification control */
+    u32 sync:1;     /* synchronize control */
+    u32 fmt:1;      /* format control */
+    u32 pfch:1;     /* prefetch control */
+    u32 isic:1;     /* initial-status-interruption control */
+    u32 alcc:1;     /* address-limit-checking control */
+    u32 ssic:1;     /* suppress-suspended-interr. control */
+    u32 res2:1;     /* reserved */
+    u32 c64:1;      /* IDAW/QDIO 64 bit control  */
+    u32 i2k:1;      /* IDAW 2/4kB block size control */
+    u32 lpm:8;      /* logical path mask */
+    u32 ils:1;      /* incorrect length */
+    u32 zero:6;     /* reserved zeros */
+    u32 orbx:1;     /* ORB extension control */
+    u32 cpa;        /* channel program address */
 }  __attribute__ ((packed, aligned(4))) CmdOrb;
 
 struct ciw {
-    __u8 type;
-    __u8 command;
-    __u16 count;
+    u8 type;
+    u8 command;
+    u16 count;
 };
 
 #define CU_TYPE_UNKNOWN         0x0000
@@ -271,12 +271,12 @@ struct ciw {
  */
 typedef struct senseid {
     /* common part */
-    __u8  reserved;   /* always 0x'FF' */
-    __u16 cu_type;    /* control unit type */
-    __u8  cu_model;   /* control unit model */
-    __u16 dev_type;   /* device type */
-    __u8  dev_model;  /* device model */
-    __u8  unused;     /* padding byte */
+    u8  reserved;   /* always 0x'FF' */
+    u16 cu_type;    /* control unit type */
+    u8  cu_model;   /* control unit model */
+    u16 dev_type;   /* device type */
+    u8  dev_model;  /* device model */
+    u8  unused;     /* padding byte */
     /* extended part */
     struct ciw ciw[62];
 }  __attribute__ ((packed, aligned(4))) SenseId;
@@ -342,9 +342,9 @@ typedef struct SenseDataEckdDasd {
 /* interruption response block */
 typedef struct irb {
     struct scsw scsw;
-    __u32 esw[5];
-    __u32 ecw[8];
-    __u32 emw[8];
+    u32 esw[5];
+    u32 ecw[8];
+    u32 emw[8];
 }  __attribute__ ((packed, aligned(4))) Irb;
 
 /* Used for SEEK ccw commands */
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index f849fba74b..f68a832718 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -17,10 +17,6 @@ typedef unsigned char      u8;
 typedef unsigned short     u16;
 typedef unsigned int       u32;
 typedef unsigned long long u64;
-typedef unsigned char      __u8;
-typedef unsigned short     __u16;
-typedef unsigned int       __u32;
-typedef unsigned long long __u64;
 
 #define true 1
 #define false 0
-- 
2.39.3


