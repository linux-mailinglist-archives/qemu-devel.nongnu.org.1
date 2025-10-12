Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDADBBD0514
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Oct 2025 17:14:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xlm-00019F-1b; Sun, 12 Oct 2025 11:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xlT-000135-Pe; Sun, 12 Oct 2025 11:13:43 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xlR-0002VP-O7; Sun, 12 Oct 2025 11:13:39 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBXXJidxeto1VagAA--.18S2;
 Sun, 12 Oct 2025 23:13:33 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwD3WuicxetoTHhMAA--.3018S3;
 Sun, 12 Oct 2025 23:13:33 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 15/21] hw/arm/smmuv3: Determine register bank from MMIO offset
Date: Sun, 12 Oct 2025 23:13:31 +0800
Message-Id: <20251012151331.4130048-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3WuicxetoTHhMAA--.3018S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBbgAAsf
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3AFy7Gr47CF4DXF18uFW8Crg_yoWxXryfp3
 yDJF1Sgr1DKa1SqwsxJa1UC3WfCan7Kr1akr9xK34Du3y2kw1xtayvy34fur1DGFy3Zrs8
 JFW5GrW7ur4DZ3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Modify the main MMIO handlers (smmu_write_mmio, smmu_read_mmio)
to determine the security state of the target register based on its
memory-mapped offset.

By checking if the offset is within the secure register space (>=
SMMU_SECURE_REG_START), the handlers can deduce the register's
SEC_SID (reg_sec_sid). This SID is then passed down to the register
access helper functions (smmu_writel, smmu_readl, etc.).

Inside these helpers, the switch statement now operates on a masked,
relative offset:

    uint32_t reg_offset = offset & 0xfff;
    switch (reg_offset) {
        ...
    }

This design leverages a key feature of the SMMU specification: registers
with the same function across different security states
(Non-secure, Realm, Root) share the same relative offset. This avoids
significant code duplication. The reg_sec_sid passed from the MMIO
handler determines which security bank to operate on, while the masked
offset identifies the specific register within that bank.

It is important to distinguish between the security state of the
register itself and the security state of the access. A
higher-privilege security state is permitted to access registers
belonging to a lower-privilege state, but the reverse is not allowed.
This patch lays the groundwork for enforcing such rules.

For future compatibility with Realm and Root states, the logic in the
else block corresponding to the secure offset check:

if (offset >= SMMU_SECURE_REG_START) {
    reg_sec_sid = SMMU_SEC_SID_S;
} else {
    /* Future Realm/Root handling */
}

will need to be expanded. This will be necessary to differentiate
between the Root Control Page and Realm Register Pages, especially since
the Root Control Page is IMPLEMENTATION DEFINED.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 61 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index f161dd3eff..100caeeb35 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1675,12 +1675,13 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
 }
 
 static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
-                               uint64_t data, MemTxAttrs attrs)
+                                uint64_t data, MemTxAttrs attrs,
+                                SMMUSecSID reg_sec_sid)
 {
-    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
+    uint32_t reg_offset = offset & 0xfff;
 
-    switch (offset) {
+    switch (reg_offset) {
     case A_GERROR_IRQ_CFG0:
         if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
             /* SMMU_(*_)_IRQ_CTRL.GERROR_IRQEN == 1: IGNORED this write */
@@ -1745,12 +1746,13 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
 }
 
 static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
-                               uint64_t data, MemTxAttrs attrs)
+                               uint64_t data, MemTxAttrs attrs,
+                               SMMUSecSID reg_sec_sid)
 {
-    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
+    uint32_t reg_offset = offset & 0xfff;
 
-    switch (offset) {
+    switch (reg_offset) {
     case A_CR0:
         bank->cr[0] = data;
         bank->cr0ack = data & ~SMMU_CR0_RESERVED;
@@ -1985,12 +1987,33 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
     /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
     offset &= ~0x10000;
 
+    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
+    /*
+     * The security state of the access (MemTxAttrs attrs) may differ from the
+     * security state to which the register belongs. Future support will include
+     * Realm and Root security states.
+     *
+     * The SMMU architecture specifies that Realm, Root, and Non-secure
+     * registers share the same offset layout within the last 4 hexadecimal
+     * digits (16 bits) of the address. Only Secure state registers are
+     * mapped to a higher address space, starting from
+     * SMMU_SECURE_REG_START (0x8000).
+     *
+     * Therefore, we can directly use the offset to distinguish Secure
+     * registers. When Realm and Root support is needed in the future, we
+     * only need to enhance the 'else' block of the corresponding 'if'
+     * statement to handle those specific security states.
+     */
+    if (offset >= SMMU_SECURE_REG_START) {
+        reg_sec_sid = SMMU_SEC_SID_S;
+    }
+
     switch (size) {
     case 8:
-        r = smmu_writell(s, offset, data, attrs);
+        r = smmu_writell(s, offset, data, attrs, reg_sec_sid);
         break;
     case 4:
-        r = smmu_writel(s, offset, data, attrs);
+        r = smmu_writel(s, offset, data, attrs, reg_sec_sid);
         break;
     default:
         r = MEMTX_ERROR;
@@ -2002,12 +2025,13 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
 }
 
 static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
-                               uint64_t *data, MemTxAttrs attrs)
+                               uint64_t *data, MemTxAttrs attrs,
+                               SMMUSecSID reg_sec_sid)
 {
-    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
+    uint32_t reg_offset = offset & 0xfff;
 
-    switch (offset) {
+    switch (reg_offset) {
     case A_GERROR_IRQ_CFG0:
         /* SMMU_(*_)GERROR_IRQ_CFG0 BOTH check SMMU_IDR0.MSI */
         if (!smmu_msi_supported(s, reg_sec_sid)) {
@@ -2036,12 +2060,13 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
 }
 
 static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
-                              uint64_t *data, MemTxAttrs attrs)
+                              uint64_t *data, MemTxAttrs attrs,
+                              SMMUSecSID reg_sec_sid)
 {
-    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
+    uint32_t reg_offset = offset & 0xfff;
 
-    switch (offset) {
+    switch (reg_offset) {
     case A_IDREGS ... A_IDREGS + 0x2f:
         *data = smmuv3_idreg(offset - A_IDREGS);
         return MEMTX_OK;
@@ -2165,13 +2190,17 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
 
     /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
     offset &= ~0x10000;
+    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
+    if (offset >= SMMU_SECURE_REG_START) {
+        reg_sec_sid = SMMU_SEC_SID_S;
+    }
 
     switch (size) {
     case 8:
-        r = smmu_readll(s, offset, data, attrs);
+        r = smmu_readll(s, offset, data, attrs, reg_sec_sid);
         break;
     case 4:
-        r = smmu_readl(s, offset, data, attrs);
+        r = smmu_readl(s, offset, data, attrs, reg_sec_sid);
         break;
     default:
         r = MEMTX_ERROR;
-- 
2.34.1


