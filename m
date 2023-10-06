Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 857707BB6B4
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:42:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qojDB-00078R-TJ; Fri, 06 Oct 2023 07:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qojCh-0006sr-Jn; Fri, 06 Oct 2023 07:41:11 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qojCT-0001Sy-JS; Fri, 06 Oct 2023 07:41:10 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id BC67275721D;
 Fri,  6 Oct 2023 13:40:09 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 779987571FE; Fri,  6 Oct 2023 13:40:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 75B9E756BF9;
 Fri,  6 Oct 2023 13:40:09 +0200 (CEST)
Date: Fri, 6 Oct 2023 13:40:09 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, 
 Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v2] pc-bios/meson.build: Silent unuseful DTC warnings
In-Reply-To: <20231006064750.33852-1-philmd@linaro.org>
Message-ID: <0038faf2-3e3e-57df-5ed4-9d4b53c8df75@eik.bme.hu>
References: <20231006064750.33852-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-404833588-1696592409=:39939"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-404833588-1696592409=:39939
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 6 Oct 2023, Philippe Mathieu-Daudé wrote:
> QEMU consumes some device tree blobs, so these have been committed
> to the tree in as firmware, along with the device tree source used
> to generate them. We know the blobs are "good enough" to have QEMU
> boot a system, so we don't really maintain and rebuild the sources.
>
> These blobs were generated with older 'dtc' binaries. We use the
> v1.6.1 version since 2021 (commit 962fde57b7 "dtc: Update to version
> 1.6.1").
>
> Since commit 6e0dc9d2a8 ("meson: compile bundled device trees"),
> if dtc binary is available, it is directly used to compile the
> device tree sources. New versions of 'dtc' add checks which display
> warnings or errors. Our sources are a bit old, so dtc v1.6.1 now
> emit the following warnings on a fresh build:
>
>  [163/3414] Generating pc-bios/canyonlands.dts with a custom command
>  pc-bios/canyonlands.dts:47.9-50.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
>  pc-bios/canyonlands.dts:210.13-429.5: Warning (unit_address_vs_reg): /plb/opb: node has a reg or ranges property, but no unit name
>  pc-bios/canyonlands.dts:464.26-504.5: Warning (pci_bridge): /plb/pciex@d00000000: node name is not "pci" or "pcie"
>  pc-bios/canyonlands.dts:506.26-546.5: Warning (pci_bridge): /plb/pciex@d20000000: node name is not "pci" or "pcie"
>  pc-bios/canyonlands.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
>  pc-bios/canyonlands.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
>  pc-bios/canyonlands.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
>  pc-bios/canyonlands.dts:268.14-289.7: Warning (avoid_unnecessary_addr_size): /plb/opb/ebc/ndfc@3,0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>  [164/3414] Generating pc-bios/petalogix-s3adsp1800.dts with a custom command
>  pc-bios/petalogix-s3adsp1800.dts:258.33-266.5: Warning (interrupt_provider): /plb/interrupt-controller@81800000: Missing #address-cells in interrupt provider
>  [165/3414] Generating pc-bios/petalogix-ml605.dts with a custom command
>  pc-bios/petalogix-ml605.dts:234.39-241.5: Warning (interrupt_provider): /axi/interrupt-controller@81800000: Missing #address-cells in interrupt provider
>  [177/3414] Generating pc-bios/bamboo.dts with a custom command
>  pc-bios/bamboo.dts:45.9-48.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
>  pc-bios/bamboo.dts:87.13-154.5: Warning (unit_address_vs_reg): /plb/opb: node has a reg or ranges property, but no unit name
>  pc-bios/bamboo.dts:198.3-50: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
>  pc-bios/bamboo.dts:87.13-154.5: Warning (interrupts_property): /plb/opb: Missing interrupt-parent
>  pc-bios/bamboo.dts:100.14-108.6: Warning (interrupts_property): /plb/opb/ebc: Missing interrupt-parent
>
> From QEMU perspective, these warnings are not really useful. It is
> the responsibility of developers adding DT source/blob to QEMU
> repository to check the source doesn't produce warnings, but as
> long as the blob is useful enough, QEMU can consume it. So these
> warnings don't add any value, instead they are noisy and might
> distract us to focus on important warnings. Better disable them.
>
> 'dtc' provides the '--quiet' option for that:
>
>  $ dtc --help
>  Usage: dtc [options] <input file>
>
>  Options: -[qI:O:o:V:d:R:S:p:a:fb:i:H:sW:E:@AThv]
>    -q, --quiet
>          Quiet: -q suppress warnings, -qq errors, -qqq all
>
> Update meson to disable these unuseful DTC warnings.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Acked-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> v2: Complete $Subject
>
> Note, meson outputs "Generating dts" instead of "Generating dtb".
> ---
> pc-bios/meson.build | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> index e67fa433a1..162663fed6 100644
> --- a/pc-bios/meson.build
> +++ b/pc-bios/meson.build
> @@ -95,7 +95,8 @@ foreach f : [
>         output: out,
>         install: get_option('install_blobs'),
>         install_dir: qemu_datadir,
> -        command: [ dtc, '-I', 'dts', '-O', 'dtb', '-o', '@OUTPUT@', '@INPUT0@' ])
> +        command: [ dtc, '-q', '-I', 'dts', '-O', 'dtb',
> +                        '-o', '@OUTPUT@', '@INPUT0@' ])
>   else
>     blobs += out
>   endif
>
--3866299591-404833588-1696592409=:39939--

