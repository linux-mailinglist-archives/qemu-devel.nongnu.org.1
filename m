Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8E37DFF73
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 08:41:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyont-00040k-IA; Fri, 03 Nov 2023 03:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyonp-0003yL-MR
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyonm-0005xS-In
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698997268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WC25SUxoF23y3N1ZFIJ6QvNkCcgXX5I2NUEAA1iwDLk=;
 b=fFIfCY/PuYrqEkVR8FDZdWNudxYe7FbdNX+h2DkhWLoymA4L2Y437r4iVw1mANPDHU0wPA
 MBiygzwRkekJ9afr3G7aSiyLtf92pNGH+lKxHJvAtxXIQ08OyLc+A9vRUMJ8QZiylJ8JZg
 ptjgvdOlZ9kzFgz1Bb6iGnFaeL4tJ2o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-r7nqxWnbMM61U_gp5UT-MQ-1; Fri,
 03 Nov 2023 03:41:00 -0400
X-MC-Unique: r7nqxWnbMM61U_gp5UT-MQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 604423813F2B;
 Fri,  3 Nov 2023 07:41:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09BCB1C060BA;
 Fri,  3 Nov 2023 07:41:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F0F9E21E6A1F; Fri,  3 Nov 2023 08:40:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Luc
 Michel <luc.michel@amd.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>,  qemu-ppc@nongnu.org,  "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>,  "Daniel P . Berrange"
 <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/5] hw/ppc/e500: QOM-attach CPUs to the machine container
References: <20231030143957.82988-1-philmd@linaro.org>
 <20231030143957.82988-4-philmd@linaro.org>
Date: Fri, 03 Nov 2023 08:40:58 +0100
In-Reply-To: <20231030143957.82988-4-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 30 Oct 2023 15:39:54
 +0100")
Message-ID: <874ji32sj9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Instead of having CPUs dangling in the /unattached/device
> bucket, attach them to the machine container.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/ppc/e500.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index e04114fb3c..f8177c0280 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -946,6 +946,7 @@ void ppce500_init(MachineState *machine)
>              exit(1);
>          }
>=20=20
> +        object_property_add_child(OBJECT(machine), "cpu[*]", OBJECT(cs));
>          /*
>           * Secondary CPU starts in halted state for now. Needs to change
>           * when implementing non-kernel boot.

A peek at "info qom-tree" confirms the CPU is in /machine/unattached/.
Along with most onboard devices.  Details below.

Quick test...  I count 563 machines.  394 seem to have CPU(s) in or
below /machine/unattached/, 129 elsewhere, and 40 I can't easily
examine, because they don't start to monitor without additional CLI
arguments.

Where should CPUs be?

Is /machine/unattached/ basically where we dump products of lazy
modelling?

If yes, should we try to empty it out?

If we shouldn't, then why move this one out?



$ qemu-system-ppc -nodefaults -S -display none -M ppce500 -monitor stdio
QEMU 8.1.50 monitor - type 'help' for more information
(qemu) info qom-tree
/machine (ppce500-machine)
  /e500-ccsr (e500-ccsr)
    /e500-ccsr[0] (memory-region)
    /e500-pci-bar0[0] (memory-region)
  /pci-host (e500-pcihost)
    /bm-e500[0] (memory-region)
    /pci bus memory[0] (memory-region)
    /pci-conf-data[0] (memory-region)
    /pci-conf-idx[0] (memory-region)
    /pci-container[0] (memory-region)
    /pci-pio[0] (memory-region)
    /pci.0 (PCI)
    /pci.reg[0] (memory-region)
  /peripheral (container)
  /peripheral-anon (container)
  /pic (openpic)
    /cpu[0] (memory-region)
    /glb[0] (memory-region)
    /msi[0] (memory-region)
    /openpic[0] (memory-region)
    /src[0] (memory-region)
    /summary[0] (memory-region)
    /tmr[0] (memory-region)
    /unnamed-gpio-in[0] (irq)
    /unnamed-gpio-in[100] (irq)
    /unnamed-gpio-in[101] (irq)
    /unnamed-gpio-in[102] (irq)
    /unnamed-gpio-in[103] (irq)
    /unnamed-gpio-in[104] (irq)
    /unnamed-gpio-in[105] (irq)
    /unnamed-gpio-in[106] (irq)
    /unnamed-gpio-in[107] (irq)
    /unnamed-gpio-in[108] (irq)
    /unnamed-gpio-in[109] (irq)
    /unnamed-gpio-in[10] (irq)
    /unnamed-gpio-in[110] (irq)
    /unnamed-gpio-in[111] (irq)
    /unnamed-gpio-in[112] (irq)
    /unnamed-gpio-in[113] (irq)
    /unnamed-gpio-in[114] (irq)
    /unnamed-gpio-in[115] (irq)
    /unnamed-gpio-in[116] (irq)
    /unnamed-gpio-in[117] (irq)
    /unnamed-gpio-in[118] (irq)
    /unnamed-gpio-in[119] (irq)
    /unnamed-gpio-in[11] (irq)
    /unnamed-gpio-in[120] (irq)
    /unnamed-gpio-in[121] (irq)
    /unnamed-gpio-in[122] (irq)
    /unnamed-gpio-in[123] (irq)
    /unnamed-gpio-in[124] (irq)
    /unnamed-gpio-in[125] (irq)
    /unnamed-gpio-in[126] (irq)
    /unnamed-gpio-in[127] (irq)
    /unnamed-gpio-in[128] (irq)
    /unnamed-gpio-in[129] (irq)
    /unnamed-gpio-in[12] (irq)
    /unnamed-gpio-in[130] (irq)
    /unnamed-gpio-in[131] (irq)
    /unnamed-gpio-in[132] (irq)
    /unnamed-gpio-in[133] (irq)
    /unnamed-gpio-in[134] (irq)
    /unnamed-gpio-in[135] (irq)
    /unnamed-gpio-in[136] (irq)
    /unnamed-gpio-in[137] (irq)
    /unnamed-gpio-in[138] (irq)
    /unnamed-gpio-in[139] (irq)
    /unnamed-gpio-in[13] (irq)
    /unnamed-gpio-in[140] (irq)
    /unnamed-gpio-in[141] (irq)
    /unnamed-gpio-in[142] (irq)
    /unnamed-gpio-in[143] (irq)
    /unnamed-gpio-in[144] (irq)
    /unnamed-gpio-in[145] (irq)
    /unnamed-gpio-in[146] (irq)
    /unnamed-gpio-in[147] (irq)
    /unnamed-gpio-in[148] (irq)
    /unnamed-gpio-in[149] (irq)
    /unnamed-gpio-in[14] (irq)
    /unnamed-gpio-in[150] (irq)
    /unnamed-gpio-in[151] (irq)
    /unnamed-gpio-in[152] (irq)
    /unnamed-gpio-in[153] (irq)
    /unnamed-gpio-in[154] (irq)
    /unnamed-gpio-in[155] (irq)
    /unnamed-gpio-in[156] (irq)
    /unnamed-gpio-in[157] (irq)
    /unnamed-gpio-in[158] (irq)
    /unnamed-gpio-in[159] (irq)
    /unnamed-gpio-in[15] (irq)
    /unnamed-gpio-in[160] (irq)
    /unnamed-gpio-in[161] (irq)
    /unnamed-gpio-in[162] (irq)
    /unnamed-gpio-in[163] (irq)
    /unnamed-gpio-in[164] (irq)
    /unnamed-gpio-in[165] (irq)
    /unnamed-gpio-in[166] (irq)
    /unnamed-gpio-in[167] (irq)
    /unnamed-gpio-in[168] (irq)
    /unnamed-gpio-in[169] (irq)
    /unnamed-gpio-in[16] (irq)
    /unnamed-gpio-in[170] (irq)
    /unnamed-gpio-in[171] (irq)
    /unnamed-gpio-in[172] (irq)
    /unnamed-gpio-in[173] (irq)
    /unnamed-gpio-in[174] (irq)
    /unnamed-gpio-in[175] (irq)
    /unnamed-gpio-in[176] (irq)
    /unnamed-gpio-in[177] (irq)
    /unnamed-gpio-in[178] (irq)
    /unnamed-gpio-in[179] (irq)
    /unnamed-gpio-in[17] (irq)
    /unnamed-gpio-in[180] (irq)
    /unnamed-gpio-in[181] (irq)
    /unnamed-gpio-in[182] (irq)
    /unnamed-gpio-in[183] (irq)
    /unnamed-gpio-in[184] (irq)
    /unnamed-gpio-in[185] (irq)
    /unnamed-gpio-in[186] (irq)
    /unnamed-gpio-in[187] (irq)
    /unnamed-gpio-in[188] (irq)
    /unnamed-gpio-in[189] (irq)
    /unnamed-gpio-in[18] (irq)
    /unnamed-gpio-in[190] (irq)
    /unnamed-gpio-in[191] (irq)
    /unnamed-gpio-in[192] (irq)
    /unnamed-gpio-in[193] (irq)
    /unnamed-gpio-in[194] (irq)
    /unnamed-gpio-in[195] (irq)
    /unnamed-gpio-in[196] (irq)
    /unnamed-gpio-in[197] (irq)
    /unnamed-gpio-in[198] (irq)
    /unnamed-gpio-in[199] (irq)
    /unnamed-gpio-in[19] (irq)
    /unnamed-gpio-in[1] (irq)
    /unnamed-gpio-in[200] (irq)
    /unnamed-gpio-in[201] (irq)
    /unnamed-gpio-in[202] (irq)
    /unnamed-gpio-in[203] (irq)
    /unnamed-gpio-in[204] (irq)
    /unnamed-gpio-in[205] (irq)
    /unnamed-gpio-in[206] (irq)
    /unnamed-gpio-in[207] (irq)
    /unnamed-gpio-in[208] (irq)
    /unnamed-gpio-in[209] (irq)
    /unnamed-gpio-in[20] (irq)
    /unnamed-gpio-in[210] (irq)
    /unnamed-gpio-in[211] (irq)
    /unnamed-gpio-in[212] (irq)
    /unnamed-gpio-in[213] (irq)
    /unnamed-gpio-in[214] (irq)
    /unnamed-gpio-in[215] (irq)
    /unnamed-gpio-in[216] (irq)
    /unnamed-gpio-in[217] (irq)
    /unnamed-gpio-in[218] (irq)
    /unnamed-gpio-in[219] (irq)
    /unnamed-gpio-in[21] (irq)
    /unnamed-gpio-in[220] (irq)
    /unnamed-gpio-in[221] (irq)
    /unnamed-gpio-in[222] (irq)
    /unnamed-gpio-in[223] (irq)
    /unnamed-gpio-in[224] (irq)
    /unnamed-gpio-in[225] (irq)
    /unnamed-gpio-in[226] (irq)
    /unnamed-gpio-in[227] (irq)
    /unnamed-gpio-in[228] (irq)
    /unnamed-gpio-in[229] (irq)
    /unnamed-gpio-in[22] (irq)
    /unnamed-gpio-in[230] (irq)
    /unnamed-gpio-in[231] (irq)
    /unnamed-gpio-in[232] (irq)
    /unnamed-gpio-in[233] (irq)
    /unnamed-gpio-in[234] (irq)
    /unnamed-gpio-in[235] (irq)
    /unnamed-gpio-in[236] (irq)
    /unnamed-gpio-in[237] (irq)
    /unnamed-gpio-in[238] (irq)
    /unnamed-gpio-in[239] (irq)
    /unnamed-gpio-in[23] (irq)
    /unnamed-gpio-in[240] (irq)
    /unnamed-gpio-in[241] (irq)
    /unnamed-gpio-in[242] (irq)
    /unnamed-gpio-in[243] (irq)
    /unnamed-gpio-in[244] (irq)
    /unnamed-gpio-in[245] (irq)
    /unnamed-gpio-in[246] (irq)
    /unnamed-gpio-in[247] (irq)
    /unnamed-gpio-in[248] (irq)
    /unnamed-gpio-in[249] (irq)
    /unnamed-gpio-in[24] (irq)
    /unnamed-gpio-in[250] (irq)
    /unnamed-gpio-in[251] (irq)
    /unnamed-gpio-in[252] (irq)
    /unnamed-gpio-in[253] (irq)
    /unnamed-gpio-in[254] (irq)
    /unnamed-gpio-in[255] (irq)
    /unnamed-gpio-in[256] (irq)
    /unnamed-gpio-in[257] (irq)
    /unnamed-gpio-in[258] (irq)
    /unnamed-gpio-in[259] (irq)
    /unnamed-gpio-in[25] (irq)
    /unnamed-gpio-in[260] (irq)
    /unnamed-gpio-in[261] (irq)
    /unnamed-gpio-in[262] (irq)
    /unnamed-gpio-in[263] (irq)
    /unnamed-gpio-in[26] (irq)
    /unnamed-gpio-in[27] (irq)
    /unnamed-gpio-in[28] (irq)
    /unnamed-gpio-in[29] (irq)
    /unnamed-gpio-in[2] (irq)
    /unnamed-gpio-in[30] (irq)
    /unnamed-gpio-in[31] (irq)
    /unnamed-gpio-in[32] (irq)
    /unnamed-gpio-in[33] (irq)
    /unnamed-gpio-in[34] (irq)
    /unnamed-gpio-in[35] (irq)
    /unnamed-gpio-in[36] (irq)
    /unnamed-gpio-in[37] (irq)
    /unnamed-gpio-in[38] (irq)
    /unnamed-gpio-in[39] (irq)
    /unnamed-gpio-in[3] (irq)
    /unnamed-gpio-in[40] (irq)
    /unnamed-gpio-in[41] (irq)
    /unnamed-gpio-in[42] (irq)
    /unnamed-gpio-in[43] (irq)
    /unnamed-gpio-in[44] (irq)
    /unnamed-gpio-in[45] (irq)
    /unnamed-gpio-in[46] (irq)
    /unnamed-gpio-in[47] (irq)
    /unnamed-gpio-in[48] (irq)
    /unnamed-gpio-in[49] (irq)
    /unnamed-gpio-in[4] (irq)
    /unnamed-gpio-in[50] (irq)
    /unnamed-gpio-in[51] (irq)
    /unnamed-gpio-in[52] (irq)
    /unnamed-gpio-in[53] (irq)
    /unnamed-gpio-in[54] (irq)
    /unnamed-gpio-in[55] (irq)
    /unnamed-gpio-in[56] (irq)
    /unnamed-gpio-in[57] (irq)
    /unnamed-gpio-in[58] (irq)
    /unnamed-gpio-in[59] (irq)
    /unnamed-gpio-in[5] (irq)
    /unnamed-gpio-in[60] (irq)
    /unnamed-gpio-in[61] (irq)
    /unnamed-gpio-in[62] (irq)
    /unnamed-gpio-in[63] (irq)
    /unnamed-gpio-in[64] (irq)
    /unnamed-gpio-in[65] (irq)
    /unnamed-gpio-in[66] (irq)
    /unnamed-gpio-in[67] (irq)
    /unnamed-gpio-in[68] (irq)
    /unnamed-gpio-in[69] (irq)
    /unnamed-gpio-in[6] (irq)
    /unnamed-gpio-in[70] (irq)
    /unnamed-gpio-in[71] (irq)
    /unnamed-gpio-in[72] (irq)
    /unnamed-gpio-in[73] (irq)
    /unnamed-gpio-in[74] (irq)
    /unnamed-gpio-in[75] (irq)
    /unnamed-gpio-in[76] (irq)
    /unnamed-gpio-in[77] (irq)
    /unnamed-gpio-in[78] (irq)
    /unnamed-gpio-in[79] (irq)
    /unnamed-gpio-in[7] (irq)
    /unnamed-gpio-in[80] (irq)
    /unnamed-gpio-in[81] (irq)
    /unnamed-gpio-in[82] (irq)
    /unnamed-gpio-in[83] (irq)
    /unnamed-gpio-in[84] (irq)
    /unnamed-gpio-in[85] (irq)
    /unnamed-gpio-in[86] (irq)
    /unnamed-gpio-in[87] (irq)
    /unnamed-gpio-in[88] (irq)
    /unnamed-gpio-in[89] (irq)
    /unnamed-gpio-in[8] (irq)
    /unnamed-gpio-in[90] (irq)
    /unnamed-gpio-in[91] (irq)
    /unnamed-gpio-in[92] (irq)
    /unnamed-gpio-in[93] (irq)
    /unnamed-gpio-in[94] (irq)
    /unnamed-gpio-in[95] (irq)
    /unnamed-gpio-in[96] (irq)
    /unnamed-gpio-in[97] (irq)
    /unnamed-gpio-in[98] (irq)
    /unnamed-gpio-in[99] (irq)
    /unnamed-gpio-in[9] (irq)
  /unattached (container)
    /device[0] (e500v2_v30-powerpc-cpu)
      /unnamed-gpio-in[0] (irq)
      /unnamed-gpio-in[1] (irq)
      /unnamed-gpio-in[2] (irq)
      /unnamed-gpio-in[3] (irq)
      /unnamed-gpio-in[4] (irq)
      /unnamed-gpio-in[5] (irq)
      /unnamed-gpio-in[6] (irq)
    /device[1] (mpc-i2c)
      /i2c (i2c-bus)
      /mpc-i2c[0] (memory-region)
    /device[2] (ds1338)
    /device[3] (unimplemented-device)
      /esdhc[0] (memory-region)
    /device[4] (generic-sdhci)
      /sd-bus (sdhci-bus)
      /sdhci[0] (memory-region)
    /device[5] (mpc8544-guts)
      /mpc8544.guts[0] (memory-region)
    /device[6] (e500-host-bridge)
      /bus master container[0] (memory-region)
      /bus master[0] (memory-region)
    /device[7] (e500-spin)
      /e500 spin pv device[0] (memory-region)
    /device[8] (mpc8xxx_gpio)
      /mpc8xxx_gpio[0] (memory-region)
      /unnamed-gpio-in[0] (irq)
      /unnamed-gpio-in[10] (irq)
      /unnamed-gpio-in[11] (irq)
      /unnamed-gpio-in[12] (irq)
      /unnamed-gpio-in[13] (irq)
      /unnamed-gpio-in[14] (irq)
      /unnamed-gpio-in[15] (irq)
      /unnamed-gpio-in[16] (irq)
      /unnamed-gpio-in[17] (irq)
      /unnamed-gpio-in[18] (irq)
      /unnamed-gpio-in[19] (irq)
      /unnamed-gpio-in[1] (irq)
      /unnamed-gpio-in[20] (irq)
      /unnamed-gpio-in[21] (irq)
      /unnamed-gpio-in[22] (irq)
      /unnamed-gpio-in[23] (irq)
      /unnamed-gpio-in[24] (irq)
      /unnamed-gpio-in[25] (irq)
      /unnamed-gpio-in[26] (irq)
      /unnamed-gpio-in[27] (irq)
      /unnamed-gpio-in[28] (irq)
      /unnamed-gpio-in[29] (irq)
      /unnamed-gpio-in[2] (irq)
      /unnamed-gpio-in[30] (irq)
      /unnamed-gpio-in[31] (irq)
      /unnamed-gpio-in[3] (irq)
      /unnamed-gpio-in[4] (irq)
      /unnamed-gpio-in[5] (irq)
      /unnamed-gpio-in[6] (irq)
      /unnamed-gpio-in[7] (irq)
      /unnamed-gpio-in[8] (irq)
      /unnamed-gpio-in[9] (irq)
    /device[9] (platform-bus-device)
      /platform bus[0] (memory-region)
    /io[0] (memory-region)
    /non-qdev-gpio[0] (irq)
    /sysbus (System)
    /system[0] (memory-region)


