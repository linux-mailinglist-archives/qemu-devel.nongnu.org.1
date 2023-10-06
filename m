Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 719D47BB1B5
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 08:48:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoed9-0000Da-Ky; Fri, 06 Oct 2023 02:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoed5-0000CC-5C
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:48:08 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoecu-00013q-NS
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:48:06 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso337179066b.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 23:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696574874; x=1697179674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/QYA1QVFm3sWS8vbj3Xn8oXF/VbdAqbXXMEgN6tWhTQ=;
 b=IT/1dEQGwx26hpAdsLi0g/FjYdU4tOHlv2FT3UI9oeg2tq2K/4lSTNUQbXHa1HxJLb
 mxJ0O2xJw+IZlUh8MVsdp6paTrEY+GaZoNW/oMukwfWpJjUJ2vEz3cWGgS8lu5Qwx0vc
 VH7wL2gBeUTB20AbtPnXxwau9MCMql/vgOhsUmT0fW46dLshSNP94Y2u8tp0S5hV2xFb
 Hnb7v9ADxtwI5XIuQjVzKO/t4PuXrZdhed+RX2aSihcx7KOAof5ieed8/7nCAETiWaHq
 kf5THLSGalCywKL3n35hCzJREUwC1pUpsV430v1zWWL4lTnwGHpu/wclKF9+gtDembK4
 deYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696574874; x=1697179674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/QYA1QVFm3sWS8vbj3Xn8oXF/VbdAqbXXMEgN6tWhTQ=;
 b=eRL0EqH5CIID0vNYN69N8B60IYTPm5p9h9MrhXvfYVWGlqILJadlAamlkloXZsA+8S
 Kv+jGgyOByQGJd6AjQTbJbEwT7UZzI4aTNKaOcoMZ9X8PZWtkfdtvodZwDPmsO7r5TU/
 JjpjvH16/AF/hdNz8wW+LnRF9TH1bMltvT/bK9jxO0Qz2gFS3I3N0o2NbLMC4ixuEHu3
 MqwQ+XvtLvkyOgFywp12UycqoA3V8+FFJkae6/V0la8SiaCgXrAcUG//KbKCE0msCNH5
 xKvnbMuNlQ4EfHNMGeoW4GVC9UF/kEiCJm2fLlU0WpVJLCaoPQN+UA4nNGs8HSpOq9u4
 FSzw==
X-Gm-Message-State: AOJu0YwhXFjJUNpBUcwcevaRR3ZVOjBz4reYVbU7I0fnua0Pd/4hVTS5
 7R1v0i+l3wG8zmQCrPNgD8eHYIZ6xim0J9jQJ3A=
X-Google-Smtp-Source: AGHT+IEWNCYOghAHmZW3ohtd60seTl1dBKrJZCwoZyCWhFKgW8BPlaQkbLWCcdwAEybrjn5QwFc2DQ==
X-Received: by 2002:a17:906:24d:b0:9a5:ca42:f3a9 with SMTP id
 13-20020a170906024d00b009a5ca42f3a9mr7149047ejl.2.1696574874054; 
 Thu, 05 Oct 2023 23:47:54 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.115.173])
 by smtp.gmail.com with ESMTPSA id
 st12-20020a170907c08c00b009b9f87b34b6sm985068ejc.189.2023.10.05.23.47.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Oct 2023 23:47:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] pc-bios/meson.build: Silent unuseful DTC warnings
Date: Fri,  6 Oct 2023 08:47:50 +0200
Message-ID: <20231006064750.33852-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
v2: Complete $Subject

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


