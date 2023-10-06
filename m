Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3227BB1AF
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 08:45:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoeaS-0007BY-NZ; Fri, 06 Oct 2023 02:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoeaQ-0007Am-Jn
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:45:22 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoeaO-0000ef-Oh
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:45:22 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3248aa5cf4eso1732560f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 23:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696574718; x=1697179518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/PHBInfNrklt2UnLo0YEKmQZcK9yf2A2dhTL7mzjD1Y=;
 b=tlewFP5xKq0NyKTMyBozBgUtRy24RucZg28pSejlzjP5APKAqlRD+hv9eFENYsi5dV
 BblyhhnBRzW4yGBXDm7D1Tev0JqoEitJ1RyCwmMfRjElmj/PoH3aoReuW4biS6F3o3j3
 rYvXUVcgzly9bEeLSGeJoGQmVD79Ky4WQlYm7ewXfmLbS4Kbp/y0fuWWZYF97ZzMzvay
 dz+o4/tAAxbM6zK1q3gswEo+Lp8SjcKKxgCqzmvcVGeu8WcxvouFeYJm7LPT5WS4dbfG
 23rKnwFZkAZvDIkcD0FPBPKEqhPL97pFhQ0OFNC8xEG/W2D6QecpKyuq6Gw85uafqwOE
 tD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696574718; x=1697179518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/PHBInfNrklt2UnLo0YEKmQZcK9yf2A2dhTL7mzjD1Y=;
 b=JKS1H9gjGD1cxpahQKcaTyjydZ3U8oGcRtSZSs27WUhxdo4UqJB/yP6DlnVSiYhRWh
 5hwPsb2PK1co0mmBzktHT1rZn718qDbDYVzhUYMSQSKXileySVEKro9pRkVCnuyZakdA
 Tk7DponXlM+JV6wERPyzo9hK+BJU0dOcf/mKZ8d0/10uYFQPrwW73AD2lcXeAxcTWo7u
 ZMWL7oTSBzDyqb/A156m92/Tx6VlvtSPizzjpBC22uq6w/PuLQHeIyNzZd00b/BMm3WC
 R3fIakP1n8pE1Zos1+Qb1QWctlHQ7spb0SCDxvvovBuf1v+uie4xOMs32fJs+FSnMKbn
 HHtA==
X-Gm-Message-State: AOJu0YyokwkAPNLu6peQoCKYBEjGCECkZBO9pE6Xqc/MoyGe5gI/S1lL
 kqUneYVWtM91r0rwcyTuZM9+EsD8WvSo3pumN9k=
X-Google-Smtp-Source: AGHT+IGGqwi/FPwrVYzl/BpvlWk+kU7g7T/Vu7Vp2DslE3kqzc3EbXEJ7N4fGnSNOau0eyTcn7wRCQ==
X-Received: by 2002:adf:f1cb:0:b0:31a:d6cb:7f9e with SMTP id
 z11-20020adff1cb000000b0031ad6cb7f9emr5714956wro.21.1696574718491; 
 Thu, 05 Oct 2023 23:45:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.115.173])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a056000025500b003296beb1436sm281547wrz.18.2023.10.05.23.45.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Oct 2023 23:45:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] dtc
Date: Fri,  6 Oct 2023 08:45:15 +0200
Message-ID: <20231006064515.33487-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

QEMU consumes some device tree blobs, so these have been committed
to the tree in as firmware, along with the device tree source used
to generate them. We know the blobs are "good enough" to have QEMU
boot a system, so we don't really maintain and rebuild the sources.

These blobs were generated with older 'dtc' binaries. We use the
v1.6.1 version since 2021 (commit 962fde57b7 "dtc: Update to version
1.6.1").

Since commit 6e0dc9d2a8 ("meson: compile bundled device trees"),
if dtc binary is available, it is directly used to compile the
device tree sources. New versions of 'dtc' add checks which display
warnings or errors. Our sources are a bit old, so dtc v1.6.1 now
emit the following warnings on a fresh build:

  [163/3414] Generating pc-bios/canyonlands.dts with a custom command
  pc-bios/canyonlands.dts:47.9-50.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
  pc-bios/canyonlands.dts:210.13-429.5: Warning (unit_address_vs_reg): /plb/opb: node has a reg or ranges property, but no unit name
  pc-bios/canyonlands.dts:464.26-504.5: Warning (pci_bridge): /plb/pciex@d00000000: node name is not "pci" or "pcie"
  pc-bios/canyonlands.dts:506.26-546.5: Warning (pci_bridge): /plb/pciex@d20000000: node name is not "pci" or "pcie"
  pc-bios/canyonlands.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
  pc-bios/canyonlands.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
  pc-bios/canyonlands.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
  pc-bios/canyonlands.dts:268.14-289.7: Warning (avoid_unnecessary_addr_size): /plb/opb/ebc/ndfc@3,0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
  [164/3414] Generating pc-bios/petalogix-s3adsp1800.dts with a custom command
  pc-bios/petalogix-s3adsp1800.dts:258.33-266.5: Warning (interrupt_provider): /plb/interrupt-controller@81800000: Missing #address-cells in interrupt provider
  [165/3414] Generating pc-bios/petalogix-ml605.dts with a custom command
  pc-bios/petalogix-ml605.dts:234.39-241.5: Warning (interrupt_provider): /axi/interrupt-controller@81800000: Missing #address-cells in interrupt provider
  [177/3414] Generating pc-bios/bamboo.dts with a custom command
  pc-bios/bamboo.dts:45.9-48.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
  pc-bios/bamboo.dts:87.13-154.5: Warning (unit_address_vs_reg): /plb/opb: node has a reg or ranges property, but no unit name
  pc-bios/bamboo.dts:198.3-50: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
  pc-bios/bamboo.dts:87.13-154.5: Warning (interrupts_property): /plb/opb: Missing interrupt-parent
  pc-bios/bamboo.dts:100.14-108.6: Warning (interrupts_property): /plb/opb/ebc: Missing interrupt-parent

From QEMU perspective, these warnings are not really useful. It is
the responsibility of developers adding DT source/blob to QEMU
repository to check the source doesn't produce warnings, but as
long as the blob is useful enough, QEMU can consume it. So these
warnings don't add any value, instead they are noisy and might
distract us to focus on important warnings. Better disable them.

'dtc' provides the '--quiet' option for that:

  $ dtc --help
  Usage: dtc [options] <input file>

  Options: -[qI:O:o:V:d:R:S:p:a:fb:i:H:sW:E:@AThv]
    -q, --quiet
          Quiet: -q suppress warnings, -qq errors, -qqq all

Update meson to disable these unuseful DTC warnings.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Note, meson outputs "Generating dts" instead of "Generating dtb".
---
 pc-bios/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index e67fa433a1..162663fed6 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -95,7 +95,8 @@ foreach f : [
         output: out,
         install: get_option('install_blobs'),
         install_dir: qemu_datadir,
-        command: [ dtc, '-I', 'dts', '-O', 'dtb', '-o', '@OUTPUT@', '@INPUT0@' ])
+        command: [ dtc, '-q', '-I', 'dts', '-O', 'dtb',
+                        '-o', '@OUTPUT@', '@INPUT0@' ])
   else
     blobs += out
   endif
-- 
2.41.0


