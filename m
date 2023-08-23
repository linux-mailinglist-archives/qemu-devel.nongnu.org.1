Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 266F47850E3
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 08:55:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYhlj-0004FO-R8; Wed, 23 Aug 2023 02:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYhlg-0004F1-7L
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 02:55:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYhle-0001MJ-95
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 02:55:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5DE701C40C
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 09:54:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D37A0212AE;
 Wed, 23 Aug 2023 09:54:02 +0300 (MSK)
Received: (nullmailer pid 1919487 invoked by uid 1000);
 Wed, 23 Aug 2023 06:54:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 18/24] audio: spelling fixes
Date: Wed, 23 Aug 2023 09:53:29 +0300
Message-Id: <20230823065335.1919380-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230823055155.1917375-1-mjt@tls.msk.ru>
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 audio/mixeng.h            | 2 +-
 hw/audio/fmopl.c          | 8 ++++----
 hw/audio/fmopl.h          | 2 +-
 hw/audio/gusemu_hal.c     | 4 ++--
 hw/audio/intel-hda-defs.h | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/audio/mixeng.h b/audio/mixeng.h
index f9de7cffeb..a5f56d2c26 100644
--- a/audio/mixeng.h
+++ b/audio/mixeng.h
@@ -39,5 +39,5 @@ typedef void (t_sample) (struct st_sample *dst, const void *src, int samples);
 typedef void (f_sample) (void *dst, const struct st_sample *src, int samples);
 
-/* indices: [stereo][signed][swap endiannes][8, 16 or 32-bits] */
+/* indices: [stereo][signed][swap endianness][8, 16 or 32-bits] */
 extern t_sample *mixeng_conv[2][2][2][3];
 extern f_sample *mixeng_clip[2][2][2][3];
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 8a71a569fa..a63ad0f04d 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -356,5 +356,5 @@ static void set_algorithm( OPL_CH *CH)
 }
 
-/* ---------- frequency counter for operater update ---------- */
+/* ---------- frequency counter for operator update ---------- */
 static inline void CALC_FCSLOT(OPL_CH *CH,OPL_SLOT *SLOT)
 {
@@ -641,5 +641,5 @@ static int OPLOpenTable( void )
 	}
 
-	/* make sinwave table (total level offet) */
+	/* make sinwave table (total level offset) */
 	/* degree 0 = degree 180                   = off */
 	SIN_TABLE[0] = SIN_TABLE[SIN_ENT/2]         = &TL_TABLE[EG_ENT-1];
@@ -1076,5 +1076,5 @@ FM_OPL *OPLCreate(int clock, int rate)
 	FM_OPL *OPL;
 	int state_size;
-	int max_ch = 9; /* normaly 9 channels */
+	int max_ch = 9; /* normally 9 channels */
 
 	if( OPL_LockTable() ==-1) return NULL;
@@ -1093,5 +1093,5 @@ FM_OPL *OPLCreate(int clock, int rate)
 	OPL->rate  = rate;
 	OPL->max_ch = max_ch;
-	/* init grobal tables */
+	/* init global tables */
 	OPL_initialize(OPL);
 	/* reset chip */
diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index e008e72d7a..89086b93f4 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -70,5 +70,5 @@ typedef struct fm_opl_f {
 	OPL_CH *P_CH;		/* pointer of CH                     */
 	int	max_ch;			/* maximum channel                   */
-	/* Rhythm sention */
+	/* Rhythm section */
 	uint8_t rhythm;		/* Rhythm mode , key flag */
 	/* time tables */
diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
index 5b9a14ee21..f159978b49 100644
--- a/hw/audio/gusemu_hal.c
+++ b/hw/audio/gusemu_hal.c
@@ -155,5 +155,5 @@ unsigned int gus_read(GUSEmuState * state, int port, int size)
             {
                 int             offset = 2 * (GUSregb(FunkSelReg3x3) & 0x0f);
-                offset += ((int) GUSregb(VoiceSelReg3x2) & 0x1f) << 5; /* = Voice*32 + Funktion*2 */
+                offset += ((int) GUSregb(VoiceSelReg3x2) & 0x1f) << 5; /* = Voice*32 + Function*2 */
                 value_read = GUSregw(offset);
             }
@@ -354,5 +354,5 @@ void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
                         break;  /* reset flag active? */
                     offset = 2 * (GUSregb(FunkSelReg3x3) & 0x0f);
-                    offset += (GUSregb(VoiceSelReg3x2) & 0x1f) << 5; /*  = Voice*32 + Funktion*2 */
+                    offset += (GUSregb(VoiceSelReg3x2) & 0x1f) << 5; /*  = Voice*32 + Function*2 */
                     GUSregw(offset) = (uint16_t) ((GUSregw(offset) & readmask) | writedata);
                 }
diff --git a/hw/audio/intel-hda-defs.h b/hw/audio/intel-hda-defs.h
index 2e37e5b874..261bdb48ff 100644
--- a/hw/audio/intel-hda-defs.h
+++ b/hw/audio/intel-hda-defs.h
@@ -419,5 +419,5 @@ enum {
 #define AC_UNSOL_RES_CP_READY		(1<<0)	/* content protection */
 
-/* Pin widget capabilies */
+/* Pin widget capabilities */
 #define AC_PINCAP_IMP_SENSE		(1<<0)	/* impedance sense capable */
 #define AC_PINCAP_TRIG_REQ		(1<<1)	/* trigger required */
@@ -484,5 +484,5 @@ enum {
 #define AC_PWRST_D3			0x03
 
-/* Processing capabilies */
+/* Processing capabilities */
 #define AC_PCAP_BENIGN			(1<<0)
 #define AC_PCAP_NUM_COEF		(0xff<<8)
-- 
2.39.2


