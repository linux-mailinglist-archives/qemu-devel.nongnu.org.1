Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD5F81C817
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 11:24:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGcgV-00032w-5D; Fri, 22 Dec 2023 05:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGcgT-00032Z-JU
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 05:23:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGcgS-00032m-0t
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 05:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703240590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fk43sdYvwkW1uu/f38dMMvmYOLb0i2yUd/ULLlxe9m0=;
 b=MUMxyJBMhzm3w71co+jdFa+woQhaE2ocOMewqRRACP8TU5iekYlpX/nq6YEaGciFWql+zJ
 evgD96Klw8ONeJlxJnwNRfAy7mEs12s0flOnAn6Albg3dL+j8R7D/UjS0uV4UEqlwJPKbJ
 PrtH+CGISj6hDiYtWVgRIJGWeBO1ah4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-XN3P91atNdKTzlOxz4LYuQ-1; Fri, 22 Dec 2023 05:23:08 -0500
X-MC-Unique: XN3P91atNdKTzlOxz4LYuQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC30488CDCA;
 Fri, 22 Dec 2023 10:23:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B58A492BE6;
 Fri, 22 Dec 2023 10:23:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A365F21E6920; Fri, 22 Dec 2023 11:23:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: hw: Audit of qdev properties with same name but different types
In-Reply-To: <d12434ff-1832-4673-9818-68ab302f26f9@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 24 Nov 2023 14:28:37
 +0100")
References: <d12434ff-1832-4673-9818-68ab302f26f9@linaro.org>
Date: Fri, 22 Dec 2023 11:23:06 +0100
Message-ID: <87h6kav8mt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Hi,
>
> I just did an audit of QDev properties from different
> models sharing the same name, but of different types
> (as of v8.2.0-rc1).
>
> Nothing wrong, but some having the same meaning could
> use the same type :)

Yes.

> Just sharing:
>
> ---
>    2 addr
>
> hw/core/generic-loader.c:183:    DEFINE_PROP_UINT64("addr", GenericLoader=
State, addr, 0),
> hw/core/guest-loader.c:115:    DEFINE_PROP_UINT64("addr", GuestLoaderStat=
e, addr, 0),
> hw/ide/macio.c:469:    DEFINE_PROP_UINT32("addr", MACIOIDEState, addr, -1=
),
> hw/pci/pci.c:71:    DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),

"addr" is kind of vague, because the address space is anybody's guess.
Width depends on the address space.

Similar naming sins in the QAPI schema at least come with documentation,
e.g.

    ##
    # @PCDIMMDeviceInfo:
    [...]
    # @addr: physical address, where device is mapped

>    2 base
>
> hw/arm/armv7m.c:630:    DEFINE_PROP_UINT32("base", BitBandState, base, 0),
> hw/dma/i8257.c:589:    DEFINE_PROP_INT32("base", I8257State, base, 0x00),

"base" is even more vague than "addr".

If it's a base *address*, width again depends on the address space, and
use of signed is fishy.

>    2 bus_nr
>
> hw/pci-bridge/pci_expander_bridge.c:412:    DEFINE_PROP_UINT8("bus_nr", P=
XBDev, bus_nr, 0),
> hw/pci-host/xilinx-pcie.c:160:    DEFINE_PROP_UINT32("bus_nr", XilinxPCIE=
Host, bus_nr, 0),

If these are PCI bus numbers: correct width is 8 bits.

>    2 clock-frequency
>
> hw/timer/altera_timer.c:218:    DEFINE_PROP_UINT32("clock-frequency", Alt=
eraTimer, freq_hz, 0),
> hw/timer/mss-timer.c:284:    DEFINE_PROP_UINT32("clock-frequency", MSSTim=
erState, freq_hz,
> hw/timer/sifive_pwm.c:409:    DEFINE_PROP_UINT64("clock-frequency", struc=
t SiFivePwmState,
> hw/timer/stm32f2xx_timer.c:302:    DEFINE_PROP_UINT64("clock-frequency", =
struct STM32F2XXTimerState,
> hw/timer/xilinx_timer.c:246:    DEFINE_PROP_UINT32("clock-frequency", Xps=
TimerState, freq_hz, 62 * 1000000),

Appropriate width depends on valid frequency range.

>    2 config
>
> hw/intc/pnv_xive2.c:1939:    DEFINE_PROP_UINT64("config", PnvXive2, confi=
g,
> hw/isa/pc87312.c:332:    DEFINE_PROP_UINT8("config", PC87312State, config=
, 1),

Are these two related?  "config" could be anything...

>    2 core-id
>
> target/i386/cpu.c:7788:    DEFINE_PROP_INT32("core-id", X86CPU, core_id, =
0),
> target/i386/cpu.c:7794:    DEFINE_PROP_INT32("core-id", X86CPU, core_id, =
-1),
> target/s390x/cpu.c:302:    DEFINE_PROP_UINT32("core-id", S390CPU, env.cor=
e_id, 0),

CPU core IDs are non-negative.  Why signed?  Perhaps to encode "N/A" as
-1?


I think we can see already any improvements would need to be made case
by case.

[Quite a few more...]


