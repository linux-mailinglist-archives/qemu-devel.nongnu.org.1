Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D66B8703E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Sep 2025 23:10:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzLsT-0003ES-NU; Thu, 18 Sep 2025 17:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzLsN-0003CK-37; Thu, 18 Sep 2025 17:09:11 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzLsK-0001jP-AU; Thu, 18 Sep 2025 17:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=LhWN4GakC5t8EOZd54ULHPw2fMtGJr0dzevkrc10VNk=; b=JYoSdxS/B3j4YSklT094IwEl5C
 2sWMCJYekL3rsV1sNwJBpCKLK3cIbl6R63w364pazmVPlGm7JmuoI3KC/yuqMP57cNHibNCYwy7yr
 Tvpydbx6y2MzPleLgaF/u6u4ZxnccDPWc2OAmhvv+V5SVTwj0UOIyyoqxKFi7IGUBR0AwildhiFdl
 YcMAmH7InfJ6vs7zcF29NPOGVeWcTllGJM9gQlz6ku6XrYMteVuopx6W3UxgwgDO42OTxWL5U3be9
 uudNEbN2+FijcdYIB0b261tRHwSqmWvubqosEi9mAA3f8rJvLgvwUzR4wqvqVwpSWpcu9XNe2P2Vj
 uuLZ8weJcnvUKA/hzbJzRq7ULwIg12jFqx6JRzQfzT2IAraGcugiyzyziHCrIzLLYvGzO4z+I1D85
 Tt5plPpxyn8xef9KCnPQklkWh9gfCKZoNqi45wJxjB9fcJMeWzxkxrOYM2HdQFjl7oyrCoTxffm4K
 7BbvDw0IKk1/+rR2rAHPVTgYU64rVnbnKrzG6Rnsq6JHiphpH8MdEZPbXX1p0JEMqfuqOS5tigxG9
 73OpGGugPmRYE+kX+NkzEavk91FTV3++fwIzQ3by17PzHOp3xdMXoHbWcF/Zu7zJybFSrdwWUFJRE
 vpuRt7Xx37Vzp8GBiAcnetGgf01jFXVJWzd0moAso=;
Received: from [2a02:8012:2f01:0:4825:8e53:bc9c:58e6]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzLqH-00073c-My; Thu, 18 Sep 2025 22:07:02 +0100
Message-ID: <f61fbc4b-596c-4325-88ac-8c800794f92b@ilande.co.uk>
Date: Thu, 18 Sep 2025 22:09:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <9a9564915bf57a6c7e5dae2cfcf147081525e900.1758219840.git.balaton@eik.bme.hu>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <9a9564915bf57a6c7e5dae2cfcf147081525e900.1758219840.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:4825:8e53:bc9c:58e6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 14/14] hw/ppc/prep: Fix non-contiguous IO control bit
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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

On 18/09/2025 19:50, BALATON Zoltan wrote:

> The bit that is supposed to control if ISA IO ports are accessed with
> discontiguous addresses was not connected so it did nothing. We can
> now directly enable or disable the discontiguous region so allow the
> bit to function. This did not cause a problem so far as nothing seems
> to use this bit or discontiguous IO addresses.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c    |  9 ---------
>   hw/ppc/prep.c          |  3 +++
>   hw/ppc/prep_systemio.c | 17 +++++++++++------
>   3 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index 0c4eca04bb..fd45acb7eb 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -161,13 +161,6 @@ static const PCIIOMMUOps raven_iommu_ops = {
>       .get_address_space = raven_pcihost_set_iommu,
>   };
>   
> -static void raven_change_gpio(void *opaque, int n, int level)
> -{
> -    PREPPCIState *s = opaque;
> -
> -    memory_region_set_enabled(&s->pci_discontiguous_io, !!level);
> -}
> -
>   static void raven_pcihost_realize(DeviceState *d, Error **errp)
>   {
>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
> @@ -176,8 +169,6 @@ static void raven_pcihost_realize(DeviceState *d, Error **errp)
>       Object *o = OBJECT(d);
>       MemoryRegion *mr, *bm, *address_space_mem = get_system_memory();
>   
> -    qdev_init_gpio_in(d, raven_change_gpio, 1);
> -
>       memory_region_init(&s->pci_io, o, "pci-io", 0x3f800000);
>       memory_region_init_io(&s->pci_discontiguous_io, o,
>                             &raven_io_ops, &s->pci_io,
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 23d0e1eeaa..678682fdd2 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -358,6 +358,9 @@ static void ibm_40p_init(MachineState *machine)
>           dev = DEVICE(isa_dev);
>           qdev_prop_set_uint32(dev, "ibm-planar-id", 0xfc);
>           qdev_prop_set_uint32(dev, "equipment", 0xc0);
> +        object_property_set_link(OBJECT(dev), "discontiguous-io",
> +                                 OBJECT(sysbus_mmio_get_region(pcihost, 1)),
> +                                 &error_fatal);
>           isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
>   
>           dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
> diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
> index 41cd923b94..6ef9b91317 100644
> --- a/hw/ppc/prep_systemio.c
> +++ b/hw/ppc/prep_systemio.c
> @@ -44,9 +44,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(PrepSystemIoState, PREP_SYSTEMIO)
>   
>   struct PrepSystemIoState {
>       ISADevice parent_obj;
> +
>       MemoryRegion ppc_parity_mem;
> +    MemoryRegion *discontiguous_io;
>   
> -    qemu_irq non_contiguous_io_map_irq;
>       uint8_t sreset; /* 0x0092 */
>       uint8_t equipment; /* 0x080c */
>       uint8_t system_control; /* 0x081c */
> @@ -206,8 +207,8 @@ static void prep_port0850_write(void *opaque, uint32_t addr, uint32_t val)
>       PrepSystemIoState *s = opaque;
>   
>       trace_prep_systemio_write(addr, val);
> -    qemu_set_irq(s->non_contiguous_io_map_irq,
> -                 val & PORT0850_IOMAP_NONCONTIGUOUS);
> +    memory_region_set_enabled(s->discontiguous_io,
> +                              !(val & PORT0850_IOMAP_NONCONTIGUOUS));
>       s->iomap_type = val & PORT0850_IOMAP_NONCONTIGUOUS;
>   }
>   
> @@ -257,10 +258,10 @@ static void prep_systemio_realize(DeviceState *dev, Error **errp)
>       PrepSystemIoState *s = PREP_SYSTEMIO(dev);
>       PowerPCCPU *cpu;
>   
> -    qdev_init_gpio_out(dev, &s->non_contiguous_io_map_irq, 1);
> +    assert(s->discontiguous_io);
>       s->iomap_type = PORT0850_IOMAP_NONCONTIGUOUS;
> -    qemu_set_irq(s->non_contiguous_io_map_irq,
> -                 s->iomap_type & PORT0850_IOMAP_NONCONTIGUOUS);
> +    memory_region_set_enabled(s->discontiguous_io,
> +                              !(s->iomap_type & PORT0850_IOMAP_NONCONTIGUOUS));
>       cpu = POWERPC_CPU(first_cpu);
>       s->softreset_irq = qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_HRESET);
>   
> @@ -288,6 +289,8 @@ static const VMStateDescription vmstate_prep_systemio = {
>   static const Property prep_systemio_properties[] = {
>       DEFINE_PROP_UINT8("ibm-planar-id", PrepSystemIoState, ibm_planar_id, 0),
>       DEFINE_PROP_UINT8("equipment", PrepSystemIoState, equipment, 0),
> +    DEFINE_PROP_LINK("discontiguous-io", PrepSystemIoState, discontiguous_io,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>   };
>   
>   static void prep_systemio_class_initfn(ObjectClass *klass, const void *data)
> @@ -296,6 +299,8 @@ static void prep_systemio_class_initfn(ObjectClass *klass, const void *data)
>   
>       dc->realize = prep_systemio_realize;
>       dc->vmsd = &vmstate_prep_systemio;
> +    /* Reason: PReP specific device, needs to be wired via properties */
> +    dc->user_creatable = false;
>       device_class_set_props(dc, prep_systemio_properties);
>   }

Making a device non-user-creatable seems to be a step backwards: why not keep the 
gpio for signalling the non-contiguous IO configuration?


ATB,

Mark.


