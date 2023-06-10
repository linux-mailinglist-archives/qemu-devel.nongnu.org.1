Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A56B272AFB5
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 01:49:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q88JW-0000Mq-LJ; Sat, 10 Jun 2023 19:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc94@poolhem.se>) id 1q88JU-0000Mh-Eh
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 19:48:08 -0400
Received: from mailout12.inleed.net ([2a0b:dc80:cafe:112::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc94@poolhem.se>) id 1q88JR-0001FV-KQ
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 19:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=poolhem.se; 
 s=x;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2OaaZ9SuEhtAP9GBSwMES1v51Iml7iKGu+ysH+iFaJQ=; b=FFUFHKxwAhFkJcxTynzPUdnwB8
 a/RnJ+2GQI8axe9sBe74tqpvX0UEJQZ63fE83lHX4g1Ws9IQoXgALu98Qjm9CAsG0ahTBwCOXlcjf
 DZnRKykaas4GJDQ0sSYfvytgvLO7ytN4v9YotShFbd0+bMAWWZPCL60wHf5aaSn949izrHSDWfyCk
 oh7Rzj5qrdQngK6KsDedlTuXV7OpgVuuXGj+0e0zfUk07BA7nmSY1n7I3QuLaSNe/zV88pmoqXF75
 3Xr/Rm40uLBMz1vips2SHY9leLXXpQ6SXfSpHG37YTDKRVHWE+XnYO9H3aCvLB5fMYxQ0cA15KbvH
 8AvqSFbQ==;
Received: from [213.115.245.47] (helo=balrog.lkp.se)
 by ns12.inleed.net with esmtpa (Exim 4.96-58-g4e9ed49f8)
 (envelope-from <hc94@poolhem.se>) id 1q88JP-00FYPA-0e;
 Sun, 11 Jun 2023 01:48:03 +0200
Date: Sun, 11 Jun 2023 01:47:51 +0200
From: Henrik Carlqvist <hc94@poolhem.se>
To: Henrik Carlqvist <hc981@poolhem.se>
Cc: mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 qemu-devel@nongnu.org, hc981@poolhem.se
Subject: [PATCH v7] Emulate dip switch language layout settings on SUN keyboard
Message-Id: <20230611014751.22f22674.hc94@poolhem.se>
In-Reply-To: <20230610122912.0fc157de.hc981@poolhem.se>
References: <167305907804.10652.2746409341903316717-1@git.sr.ht>
 <d2850ef0-d825-bb03-09d4-0d1427cf6577@ilande.co.uk>
 <20230123200937.32eb19eb.hc981@poolhem.se>
 <20230304220754.0c6ae562.hc981@poolhem.se>
 <ZCLzUyiDeKLfQqWT@redhat.com>
 <20230328191958.3e3eb5e4.hc981@poolhem.se>
 <ZCMq/imcAq0ApLQp@redhat.com>
 <20230328221608.328ab80f.hc981@poolhem.se>
 <20230430225533.1a57879a.hc981@poolhem.se>
 <20230608181439.7ea3a5c5.hc981@poolhem.se>
 <4e8f027a-ca00-c54f-ef2f-f0df1f5b2f9e@ilande.co.uk>
 <20230610122912.0fc157de.hc981@poolhem.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: henrik@poolhem.se
Received-SPF: none client-ip=2a0b:dc80:cafe:112::1;
 envelope-from=hc94@poolhem.se; helo=mailout12.inleed.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I have now changed the patch to instead use

-global escc.chnA-sunkbd-layout=

and documented in docs/system/keyboard.rst which I have linked from 
target-sparc.rst. Unfortunately, I am not very used to these .rst files
and have not found out how to create html files from them, so I don't know 
for sure if my formatting is correct. Typing "make help" seems to indicate
that it should be possible to type "make html", but that did not seem to work.

SUN Type 4, 5 and 5c keyboards have dip switches to choose
the language layout of the keyboard. Solaris makes an ioctl to query the
value of the dipswitches and uses that value to select keyboard layout. Also
the SUN bios like the one in the file ss5.bin uses this value to support at
least some keyboard layouts. However, the OpenBIOS provided with qemu is
hardcoded to always use an US keyboard layout.

Before this patch, qemu allways gave dip switch value 0x21 (US keyboard),
this patch uses a command line switch like
"-global escc.chnA-sunkbd-layout=de" to select dip switch value. A table is
used to lookup values from arguments like:

-global escc.chnA-sunkbd-layout=fr
-global escc.chnA-sunkbd-layout=es

But the patch also accepts numeric dip switch values directly:

-global escc.chnA-sunkbd-layout=0x2b
-global escc.chnA-sunkbd-layout=43

Both values above are the same and select swedish keyboard as explained in
table 3-15 at
https://docs.oracle.com/cd/E19683-01/806-6642/new-43/index.html

Unless you want to do a full Solaris installation but happen to have
access to a Sun bios file, the easiest way to test that the patch works 
is to:

qemu-system-sparc -global escc.chnA-sunkbd-layout=sv -bios /path/to/ss5.bin

If you already happen to have a Solaris installation in a qemu disk image
file you can easily try different keyboard layouts after this patch is
applied.

Signed-off-by: Henrik Carlqvist <hc1245@poolhem.se>
---
 docs/system/keyboard.rst     | 127 +++++++++++++++++++++++++++++++++++
 docs/system/target-sparc.rst |   2 +-
 hw/char/escc.c               |  76 ++++++++++++++++++++-
 include/hw/char/escc.h       |   1 +
 4 files changed, 204 insertions(+), 2 deletions(-)
 create mode 100644 docs/system/keyboard.rst

diff --git a/docs/system/keyboard.rst b/docs/system/keyboard.rst
new file mode 100644
index 0000000000..b489c607f8
--- /dev/null
+++ b/docs/system/keyboard.rst
@@ -0,0 +1,127 @@
+.. _keyboard:
+
+Sparc32 keyboard
+----------------
+SUN Type 4, 5 and 5c keyboards have dip switches to choose the language layout 
+of the keyboard. Solaris makes an ioctl to query the value of the dipswitches 
+and uses that value to select keyboard layout. Also the SUN bios like the one 
+in the file ss5.bin uses this value to support at least some keyboard layouts. 
+However, the OpenBIOS provided with qemu is hardcoded to always use an 
+US keyboard layout.
+
+With the escc.chnA-sunkbd-layout driver property it is possible to select
+keyboard layout. Example:
+
+"-global escc.chnA-sunkbd-layout=de"
+
+Depending on type of keyboard, the keyboard can have 6 or 5 dip-switches to
+select keyboard layout, giving up to 64 different layouts. Not all
+combinations are supported by Solaris and even less by Sun OpenBoot BIOS.
+
+The dip switch settings can be given as hexadecimal number, decimal number
+or in some cases as a language string. Examples:
+
+-global escc.chnA-sunkbd-layout=0x2b
+-global escc.chnA-sunkbd-layout=43
+-global escc.chnA-sunkbd-layout=sv
+
+The above 3 examples all select a swedish keyboard layout. Table 3-15 at
+https://docs.oracle.com/cd/E19683-01/806-6642/new-43/index.html explains which
+keytable file is used for different dip switch settings. The information
+in that table can be summarized in this table:
+
+.. list-table:: Language selection values for escc.chnA-sunkbd-layout
+   :widths: 10 10 10
+   :header-rows: 1
+
+   * - Hexadecimal value
+     - Decimal value
+     - Language code
+   * - 0x21
+     - 33
+     - en-us
+   * - 0x23
+     - 35
+     - fr
+   * - 0x24
+     - 36
+     - da
+   * - 0x25
+     - 37
+     - de
+   * - 0x26
+     - 38
+     - it
+   * - 0x27
+     - 39
+     - nl
+   * - 0x28
+     - 40
+     - no
+   * - 0x29
+     - 41
+     - pt
+   * - 0x2a
+     - 42
+     - es
+   * - 0x2b
+     - 43
+     - sv
+   * - 0x2c
+     - 44
+     - fr-ch
+   * - 0x2d
+     - 45
+     - de-ch
+   * - 0x2e
+     - 46
+     - en-gb
+   * - 0x2f
+     - 47
+     - ko
+   * - 0x30
+     - 48
+     - tw
+   * - 0x31
+     - 49
+     - ja
+   * - 0x32
+     - 50
+     - fr-ca
+   * - 0x33
+     - 51
+     - hu
+   * - 0x34
+     - 52
+     - pl
+   * - 0x35
+     - 53
+     - cz
+   * - 0x36
+     - 54
+     - ru
+   * - 0x37
+     - 55
+     - lv
+   * - 0x38
+     - 56
+     - tr
+   * - 0x39
+     - 57
+     - gr
+   * - 0x3a
+     - 58
+     - ar
+   * - 0x3b
+     - 59
+     - lt
+   * - 0x3c
+     - 60
+     - nl-be
+   * - 0x3c
+     - 60
+     - be
+
+Not all dip switch values have a corresponding language code and both "be" and
+"nl-be" correspond to the same dip switch value. By default, if no value is
+given to escc.chnA-sunkbd-layout 0x21 (en-us) will be used.
diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
index b55f8d09e9..d5418c32d0 100644
--- a/docs/system/target-sparc.rst
+++ b/docs/system/target-sparc.rst
@@ -38,7 +38,7 @@ QEMU emulates the following sun4m peripherals:
 -  Non Volatile RAM M48T02/M48T08
 
 -  Slave I/O: timers, interrupt controllers, Zilog serial ports,
-   keyboard and power/reset logic
+   :ref: `keyboard` and power/reset logic
 
 -  ESP SCSI controller with hard disk and CD-ROM support
 
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 17a908c59b..463b3d2e93 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -31,6 +31,8 @@
 #include "qemu/module.h"
 #include "hw/char/escc.h"
 #include "ui/console.h"
+
+#include "qemu/cutils.h"
 #include "trace.h"
 
 /*
@@ -190,6 +192,7 @@
 #define R_MISC1I 14
 #define R_EXTINT 15
 
+static unsigned char sunkbd_layout_dip_switch(const char *sunkbd_layout);
 static void handle_kbd_command(ESCCChannelState *s, int val);
 static int serial_can_receive(void *opaque);
 static void serial_receive_byte(ESCCChannelState *s, int ch);
@@ -846,6 +849,75 @@ static QemuInputHandler sunkbd_handler = {
     .event = sunkbd_handle_event,
 };
 
+static unsigned char sunkbd_layout_dip_switch(const char *kbd_layout)
+{
+    /* Return the value of the dip-switches in a SUN Type 5 keyboard */
+    static unsigned char ret = 0xff;
+
+    if ((ret == 0xff) && kbd_layout) {
+        int i;
+        struct layout_values {
+            const char *lang;
+            unsigned char dip;
+        } languages[] =
+    /* Dip values from table 3-16 Layouts for Type 4, 5, and 5c Keyboards */
+            {
+                {"en-us", 0x21}, /* U.S.A. (US5.kt) */
+                                 /* 0x22 is some other US (US_UNIX5.kt)*/
+                {"fr",    0x23}, /* France (France5.kt) */
+                {"da",    0x24}, /* Denmark (Denmark5.kt) */
+                {"de",    0x25}, /* Germany (Germany5.kt) */
+                {"it",    0x26}, /* Italy (Italy5.kt) */
+                {"nl",    0x27}, /* The Netherlands (Netherland5.kt) */
+                {"no",    0x28}, /* Norway (Norway.kt) */
+                {"pt",    0x29}, /* Portugal (Portugal5.kt) */
+                {"es",    0x2a}, /* Spain (Spain5.kt) */
+                {"sv",    0x2b}, /* Sweden (Sweden5.kt) */
+                {"fr-ch", 0x2c}, /* Switzerland/French (Switzer_Fr5.kt) */
+                {"de-ch", 0x2d}, /* Switzerland/German (Switzer_Ge5.kt) */
+                {"en-gb", 0x2e}, /* Great Britain (UK5.kt) */
+                {"ko",    0x2f}, /* Korea (Korea5.kt) */
+                {"tw",    0x30}, /* Taiwan (Taiwan5.kt) */
+                {"ja",    0x31}, /* Japan (Japan5.kt) */
+                {"fr-ca", 0x32}, /* Canada/French (Canada_Fr5.kt) */
+                {"hu",    0x33}, /* Hungary (Hungary5.kt) */
+                {"pl",    0x34}, /* Poland (Poland5.kt) */
+                {"cz",    0x35}, /* Czech (Czech5.kt) */
+                {"ru",    0x36}, /* Russia (Russia5.kt) */
+                {"lv",    0x37}, /* Latvia (Latvia5.kt) */
+                {"tr",    0x38}, /* Turkey-Q5 (TurkeyQ5.kt) */
+                {"gr",    0x39}, /* Greece (Greece5.kt) */
+                {"ar",    0x3a}, /* Arabic (Arabic5.kt) */
+                {"lt",    0x3b}, /* Lithuania (Lithuania5.kt) */
+                {"nl-be", 0x3c}, /* Belgium (Belgian5.kt) */
+                {"be",    0x3c}, /* Belgium (Belgian5.kt) */
+            };
+
+        for (i = 0;
+             i < sizeof(languages) / sizeof(struct layout_values);
+             i++) {
+            if (!strcmp(kbd_layout, languages[i].lang)) {
+                ret = languages[i].dip;
+                return ret;
+            }
+        }
+        /* Found no known language code */
+
+        if ((kbd_layout[0] >= '0') && (kbd_layout[0] <= '9')) {
+            unsigned int tmp;
+            /* As a fallback we also accept numeric dip switch value */
+            if (!qemu_strtoui(kbd_layout, NULL, 0, &tmp)) {
+                ret = (unsigned char)tmp;
+            }
+        }
+    }
+    if (ret == 0xff) {
+        /* Final fallback if keyboard_layout was not set or recognized */
+        ret = 0x21; /* en-us layout */
+    }
+    return ret;
+}
+
 static void handle_kbd_command(ESCCChannelState *s, int val)
 {
     trace_escc_kbd_command(val);
@@ -867,7 +939,7 @@ static void handle_kbd_command(ESCCChannelState *s, int val)
     case 0xf:
         clear_queue(s);
         put_queue(s, 0xfe);
-        put_queue(s, 0x21); /*  en-us layout */
+        put_queue(s, sunkbd_layout_dip_switch(s->sunkbd_layout));
         break;
     default:
         break;
@@ -976,6 +1048,8 @@ static Property escc_properties[] = {
     DEFINE_PROP_UINT32("chnAtype",  ESCCState, chn[1].type, 0),
     DEFINE_PROP_CHR("chrB", ESCCState, chn[0].chr),
     DEFINE_PROP_CHR("chrA", ESCCState, chn[1].chr),
+    DEFINE_PROP_STRING("chnA-sunkbd-layout", ESCCState,
+		       chn[1].sunkbd_layout),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index 7e9482dee2..5669a5b811 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -45,6 +45,7 @@ typedef struct ESCCChannelState {
     ESCCChnType type;
     uint8_t rx, tx;
     QemuInputHandlerState *hs;
+    char *sunkbd_layout;
 } ESCCChannelState;
 
 struct ESCCState {
-- 
2.30.4


