Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F24C8922F3
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Mar 2024 18:45:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqGHF-0005AM-OQ; Fri, 29 Mar 2024 13:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rqGHD-00058S-3h; Fri, 29 Mar 2024 13:44:27 -0400
Received: from zproxy3.enst.fr ([137.194.2.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rqGHA-0007O4-0i; Fri, 29 Mar 2024 13:44:26 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id D12A3A07C8;
 Fri, 29 Mar 2024 18:44:19 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id u0m_qgr1_nz3; Fri, 29 Mar 2024 18:44:19 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 45999A07F1;
 Fri, 29 Mar 2024 18:44:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 45999A07F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1711734259;
 bh=XSURM/Qi4bZtj+sY2xjV40uZw5oec5n11aG4URJHBuY=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=yBS+pWyExbvL/kfJohL7crUhP2WJLp2Yhxn5sKsxd2cDJocftJe8D/c+GJQ2dBoEp
 IA45ANyDsNyGiapcz6X38KBr3z2m2s8ojHLPN/8hG2RlmHqU9JGl0FqPE5X30wdmQm
 Yu50FIQ8CRv2fIFRaLLBSj+uEyQuJmS0Uc/cTjso=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id hw7ef6Kbf_96; Fri, 29 Mar 2024 18:44:19 +0100 (CET)
Received: from AM-Inspiron-3585.. (unknown [78.209.135.136])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id 123C8A07C8;
 Fri, 29 Mar 2024 18:44:17 +0100 (CET)
From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 2/5] hw/char/stm32l4x5_usart: Enable serial read and write
Date: Fri, 29 Mar 2024 18:43:59 +0100
Message-Id: <20240329174402.60382-3-arnaud.minier@telecom-paris.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329174402.60382-1-arnaud.minier@telecom-paris.fr>
References: <20240329174402.60382-1-arnaud.minier@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.222;
 envelope-from=arnaud.minier@telecom-paris.fr; helo=zproxy3.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Implement the ability to read and write characters to the
usart using the serial port.

The character transmission is based on the
cmsdk-apb-uart implementation.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/stm32l4x5_usart.c         | 140 ++++++++++++++++++++++++++++++
 hw/char/trace-events              |   7 ++
 include/hw/char/stm32l4x5_usart.h |   1 +
 3 files changed, 148 insertions(+)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index 13ce0eb89d..b948a89c13 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -154,6 +154,120 @@ REG32(RDR, 0x24)
 REG32(TDR, 0x28)
     FIELD(TDR, TDR, 0, 9)
=20
+static void stm32l4x5_update_irq(Stm32l4x5UsartBaseState *s)
+{
+    if (((s->isr & R_ISR_WUF_MASK) && (s->cr3 & R_CR3_WUFIE_MASK))      =
  ||
+        ((s->isr & R_ISR_CMF_MASK) && (s->cr1 & R_CR1_CMIE_MASK))       =
  ||
+        ((s->isr & R_ISR_ABRF_MASK) && (s->cr1 & R_CR1_RXNEIE_MASK))    =
  ||
+        ((s->isr & R_ISR_EOBF_MASK) && (s->cr1 & R_CR1_EOBIE_MASK))     =
  ||
+        ((s->isr & R_ISR_RTOF_MASK) && (s->cr1 & R_CR1_RTOIE_MASK))     =
  ||
+        ((s->isr & R_ISR_CTSIF_MASK) && (s->cr3 & R_CR3_CTSIE_MASK))    =
  ||
+        ((s->isr & R_ISR_LBDF_MASK) && (s->cr2 & R_CR2_LBDIE_MASK))     =
  ||
+        ((s->isr & R_ISR_TXE_MASK) && (s->cr1 & R_CR1_TXEIE_MASK))      =
  ||
+        ((s->isr & R_ISR_TC_MASK) && (s->cr1 & R_CR1_TCIE_MASK))        =
  ||
+        ((s->isr & R_ISR_RXNE_MASK) && (s->cr1 & R_CR1_RXNEIE_MASK))    =
  ||
+        ((s->isr & R_ISR_IDLE_MASK) && (s->cr1 & R_CR1_IDLEIE_MASK))    =
  ||
+        ((s->isr & R_ISR_ORE_MASK) &&
+            ((s->cr1 & R_CR1_RXNEIE_MASK) || (s->cr3 & R_CR3_EIE_MASK)))=
  ||
+        /* TODO: Handle NF ? */
+        ((s->isr & R_ISR_FE_MASK) && (s->cr3 & R_CR3_EIE_MASK))         =
  ||
+        ((s->isr & R_ISR_PE_MASK) && (s->cr1 & R_CR1_PEIE_MASK))) {
+        qemu_irq_raise(s->irq);
+        trace_stm32l4x5_usart_irq_raised(s->isr);
+    } else {
+        qemu_irq_lower(s->irq);
+        trace_stm32l4x5_usart_irq_lowered();
+    }
+}
+
+static int stm32l4x5_usart_base_can_receive(void *opaque)
+{
+    Stm32l4x5UsartBaseState *s =3D opaque;
+
+    if (!(s->isr & R_ISR_RXNE_MASK)) {
+        return 1;
+    }
+
+    return 0;
+}
+
+static void stm32l4x5_usart_base_receive(void *opaque, const uint8_t *bu=
f, int size)
+{
+    Stm32l4x5UsartBaseState *s =3D opaque;
+
+    if (!((s->cr1 & R_CR1_UE_MASK) && (s->cr1 & R_CR1_RE_MASK))) {
+        trace_stm32l4x5_usart_receiver_not_enabled(
+            FIELD_EX32(s->cr1, CR1, UE), FIELD_EX32(s->cr1, CR1, RE));
+        return;
+    }
+
+    /* Check if overrun detection is enabled and if there is an overrun =
*/
+    if (!(s->cr3 & R_CR3_OVRDIS_MASK) && (s->isr & R_ISR_RXNE_MASK)) {
+        /*
+         * A character has been received while
+         * the previous has not been read =3D Overrun.
+         */
+        s->isr |=3D R_ISR_ORE_MASK;
+        trace_stm32l4x5_usart_overrun_detected(s->rdr, *buf);
+    } else {
+        /* No overrun */
+        s->rdr =3D *buf;
+        s->isr |=3D R_ISR_RXNE_MASK;
+        trace_stm32l4x5_usart_rx(s->rdr);
+    }
+
+    stm32l4x5_update_irq(s);
+}
+
+/*
+ * Try to send tx data, and arrange to be called back later if
+ * we can't (ie the char backend is busy/blocking).
+ */
+static gboolean usart_transmit(void *do_not_use, GIOCondition cond, void=
 *opaque)
+{
+    Stm32l4x5UsartBaseState *s =3D STM32L4X5_USART_BASE(opaque);
+    int ret;
+    /* TODO: Handle 9 bits transmission */
+    uint8_t ch =3D s->tdr;
+
+    s->watch_tag =3D 0;
+
+    if (!(s->cr1 & R_CR1_TE_MASK) || (s->isr & R_ISR_TXE_MASK)) {
+        return G_SOURCE_REMOVE;
+    }
+
+    ret =3D qemu_chr_fe_write(&s->chr, &ch, 1);
+    if (ret <=3D 0) {
+        s->watch_tag =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_=
HUP,
+                                             usart_transmit, s);
+        if (!s->watch_tag) {
+            /* Most common reason to be here is "no chardev backend":
+             * just insta-drain the buffer, so the serial output
+             * goes into a void, rather than blocking the guest.
+             */
+            goto buffer_drained;
+        }
+        /* Transmit pending */
+        trace_stm32l4x5_usart_tx_pending();
+        return G_SOURCE_REMOVE;
+    }
+
+buffer_drained:
+    /* Character successfully sent */
+    trace_stm32l4x5_usart_tx(ch);
+    s->isr |=3D R_ISR_TC_MASK | R_ISR_TXE_MASK;
+    stm32l4x5_update_irq(s);
+    return G_SOURCE_REMOVE;
+}
+
+static void usart_cancel_transmit(Stm32l4x5UsartBaseState *s)
+{
+    if (s->watch_tag) {
+        g_source_remove(s->watch_tag);
+        s->watch_tag =3D 0;
+    }
+}
+
 static void stm32l4x5_usart_base_reset_hold(Object *obj)
 {
     Stm32l4x5UsartBaseState *s =3D STM32L4X5_USART_BASE(obj);
@@ -167,6 +281,22 @@ static void stm32l4x5_usart_base_reset_hold(Object *=
obj)
     s->isr =3D 0x020000C0;
     s->rdr =3D 0x00000000;
     s->tdr =3D 0x00000000;
+
+    usart_cancel_transmit(s);
+    stm32l4x5_update_irq(s);
+}
+
+static void usart_update_rqr(Stm32l4x5UsartBaseState *s, uint32_t value)
+{
+    /* TXFRQ */
+    /* Reset RXNE flag */
+    if (value & R_RQR_RXFRQ_MASK) {
+        s->isr &=3D ~R_ISR_RXNE_MASK;
+    }
+    /* MMRQ */
+    /* SBKRQ */
+    /* ABRRQ */
+    stm32l4x5_update_irq(s);
 }
=20
 static uint64_t stm32l4x5_usart_base_read(void *opaque, hwaddr addr,
@@ -209,6 +339,7 @@ static uint64_t stm32l4x5_usart_base_read(void *opaqu=
e, hwaddr addr,
         retvalue =3D FIELD_EX32(s->rdr, RDR, RDR);
         /* Reset RXNE flag */
         s->isr &=3D ~R_ISR_RXNE_MASK;
+        stm32l4x5_update_irq(s);
         break;
     case A_TDR:
         retvalue =3D FIELD_EX32(s->tdr, TDR, TDR);
@@ -235,6 +366,7 @@ static void stm32l4x5_usart_base_write(void *opaque, =
hwaddr addr,
     switch (addr) {
     case A_CR1:
         s->cr1 =3D value;
+        stm32l4x5_update_irq(s);
         return;
     case A_CR2:
         s->cr2 =3D value;
@@ -252,6 +384,7 @@ static void stm32l4x5_usart_base_write(void *opaque, =
hwaddr addr,
         s->rtor =3D value;
         return;
     case A_RQR:
+        usart_update_rqr(s, value);
         return;
     case A_ISR:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -260,6 +393,7 @@ static void stm32l4x5_usart_base_write(void *opaque, =
hwaddr addr,
     case A_ICR:
         /* Clear the status flags */
         s->isr &=3D ~value;
+        stm32l4x5_update_irq(s);
         return;
     case A_RDR:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -267,6 +401,8 @@ static void stm32l4x5_usart_base_write(void *opaque, =
hwaddr addr,
         return;
     case A_TDR:
         s->tdr =3D value;
+        s->isr &=3D ~R_ISR_TXE_MASK;
+        usart_transmit(NULL, G_IO_OUT, s);
         return;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -336,6 +472,10 @@ static void stm32l4x5_usart_base_realize(DeviceState=
 *dev, Error **errp)
         error_setg(errp, "USART clock must be wired up by SoC code");
         return;
     }
+
+    qemu_chr_fe_set_handlers(&s->chr, stm32l4x5_usart_base_can_receive,
+                             stm32l4x5_usart_base_receive, NULL, NULL,
+                             s, NULL, true);
 }
=20
 static void stm32l4x5_usart_base_class_init(ObjectClass *klass, void *da=
ta)
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 689bed9e02..f22f0ee2bc 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -109,6 +109,13 @@ sh_serial_write(char *id, unsigned size, uint64_t of=
fs, uint64_t val) "%s size %
 # stm32l4x5_usart.c
 stm32l4x5_usart_read(uint64_t addr, uint32_t data) "USART: Read <0x%" PR=
Ix64 "> -> 0x%" PRIx32 ""
 stm32l4x5_usart_write(uint64_t addr, uint32_t data) "USART: Write <0x%" =
PRIx64 "> <- 0x%" PRIx32 ""
+stm32l4x5_usart_rx(uint8_t c) "USART: got character 0x%x from backend"
+stm32l4x5_usart_tx(uint8_t c) "USART: character 0x%x sent to backend"
+stm32l4x5_usart_tx_pending(void) "USART: character send to backend pendi=
ng"
+stm32l4x5_usart_irq_raised(uint32_t reg) "USART: IRQ raised: 0x%08"PRIx3=
2
+stm32l4x5_usart_irq_lowered(void) "USART: IRQ lowered"
+stm32l4x5_usart_overrun_detected(uint8_t current, uint8_t received) "USA=
RT: Overrun detected, RDR=3D'0x%x', received 0x%x"
+stm32l4x5_usart_receiver_not_enabled(uint8_t ue_bit, uint8_t re_bit) "US=
ART: Receiver not enabled, UE=3D0x%x, RE=3D0x%x"
=20
 # xen_console.c
 xen_console_connect(unsigned int idx, unsigned int ring_ref, unsigned in=
t port, unsigned int limit) "idx %u ring_ref %u port %u limit %u"
diff --git a/include/hw/char/stm32l4x5_usart.h b/include/hw/char/stm32l4x=
5_usart.h
index 8d38a85a6e..dd3866682a 100644
--- a/include/hw/char/stm32l4x5_usart.h
+++ b/include/hw/char/stm32l4x5_usart.h
@@ -55,6 +55,7 @@ struct Stm32l4x5UsartBaseState {
     Clock *clk;
     CharBackend chr;
     qemu_irq irq;
+    guint watch_tag;
 };
=20
 struct Stm32l4x5UsartBaseClass {
--=20
2.34.1


