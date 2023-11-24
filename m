Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4B57F7374
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 13:10:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6V0t-0002Fr-De; Fri, 24 Nov 2023 07:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1r6V0j-0002F6-3H
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 07:10:20 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1r6V0g-0001Pm-5P
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 07:10:16 -0500
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1700827809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=d4K9yBttWKRcX/M52Ej2Xmg3qT+50zWuCWKVuDCuEVw=;
 b=VHEw/CyO16JqCv6ksv3uSlBS4LFwl/NLwJJcBFckHcCZnkb+Tlp7KAnAyrpxhrcBLDsspm
 PxgrXL9tsUp8pHnuk6jtuQAhGVZNBHpk3UmtNQNiYNc7oeke+mUVKqZrPlENAS1cKYVW4R
 eF7hTADJHBNbvTyLSwFopAoPNwxzkxw=
To: mst@redhat.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [RFC PATCH] hw/virtio: fix confusing comment
Date: Fri, 24 Nov 2023 15:08:47 +0300
Message-Id: <20231124120846.2499854-1-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It seems that comments to transitional/non-transitional devices are
mixed up.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 include/hw/virtio/virtio-pci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 5a3f182f99..45be10d694 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -229,13 +229,13 @@ typedef struct VirtioPCIDeviceTypeInfo {
     /*
      * The transitional device type.  Optional.
      *
-     * Implements both INTERFACE_PCIE_DEVICE and INTERFACE_CONVENTIONAL_PCI_DEVICE.
+     * Implements INTERFACE_CONVENTIONAL_PCI_DEVICE only.
      */
     const char *transitional_name;
     /*
      * The non-transitional device type.  Optional.
      *
-     * Implements INTERFACE_CONVENTIONAL_PCI_DEVICE only.
+     * Implements both INTERFACE_PCIE_DEVICE and INTERFACE_CONVENTIONAL_PCI_DEVICE.
      */
     const char *non_transitional_name;
 
-- 
2.34.1


