Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA97B5838D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Sep 2025 19:24:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyCvW-0001vJ-Qe; Mon, 15 Sep 2025 13:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=keIv=32=kaod.org=clg@ozlabs.org>)
 id 1uyCvR-0001tB-Lf; Mon, 15 Sep 2025 13:23:37 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=keIv=32=kaod.org=clg@ozlabs.org>)
 id 1uyCvH-0006hl-DL; Mon, 15 Sep 2025 13:23:35 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4cQX1L74Dgz4wBL;
 Tue, 16 Sep 2025 03:23:18 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4cQX1F4XVGz4w9b;
 Tue, 16 Sep 2025 03:23:13 +1000 (AEST)
Message-ID: <65d001ce-72c7-42ad-a96d-7c71075a3a57@kaod.org>
Date: Mon, 15 Sep 2025 19:23:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v2 10/14] hw/pci-host/aspeed: Add AST2700 PCIe
 config with dedicated H2X blocks
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, nabihestefan@google.com, wuhaotsh@google.com,
 titusr@google.com
References: <20250911072452.314553-1-jamin_lin@aspeedtech.com>
 <20250911072452.314553-11-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250911072452.314553-11-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=keIv=32=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 9/11/25 09:24, Jamin Lin wrote:
> Introduce PCIe config (H2X) support for the AST2700 SoC.
> 
> Unlike the AST2600, the AST2700 provides three independent Root Complexes,
> each with its own H2X (AHB to PCIe bridge) register block of size 0x100.
> All RCs use the same MSI address (0x000000F0). The H2X block includes
> two different access paths:
> 
> 1. CFGI (internal bridge): used to access the host bridge itself, always
>     with BDF=0. The AST2700 controller simplifies the design by exposing
>     only one register (H2X_CFGI_TLP) with fields for ADDR[15:0], BEN[19:16],
>     and WR[20]. This is not a full TLP descriptor as in the external case.
>     For QEMU readability and code reuse, the model converts H2X_CFGI_TLP
>     into a standard TLP TX descriptor with BDF forced to 0 and then calls
>     the existing helpers aspeed_pcie_cfg_readwrite() and
>     aspeed_pcie_cfg_translate_write().
> 
> 2. CFGE (external EP access): used to access external endpoints. The
>     AST2700 design provides H2X_CFGE_TLP1 and a small FIFO at H2X_CFGE_TLPN.
>     For reads, TX DESC0 is stored in TLP1 and DESC1/DESC2 in TLPN FIFO
>     slots. For writes, TX DESC0 is stored in TLP1, DESC1/DESC2 in TLPN
>     FIFO[0..1], and TX write data in TLPN FIFO[2].
> 
> The implementation extends AspeedPCIECfgState with a small FIFO and index,
> wires up new register definitions for AST2700, and adds a specific ops
> table and class (TYPE_ASPEED_2700_PCIE_CFG). The reset handler clears the
> FIFO state. Interrupt and MSI status registers are also supported.
> 
> This provides enough modeling for firmware and drivers to use any of the
> three PCIe RCs on AST2700 with their own dedicated H2X config window,
> while reusing existing TLP decode helpers in QEMU.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

I thinks this implementation has endianess issues when accessing the
descriptors.

C.


> ---
>   include/hw/pci-host/aspeed_pcie.h |   3 +
>   hw/pci-host/aspeed_pcie.c         | 158 ++++++++++++++++++++++++++++++
>   2 files changed, 161 insertions(+)
> 
> diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
> index c0d46e6a03..d7b4b66f75 100644
> --- a/include/hw/pci-host/aspeed_pcie.h
> +++ b/include/hw/pci-host/aspeed_pcie.h
> @@ -89,6 +89,7 @@ struct AspeedPCIERcState {
>   
>   /* Bridge between AHB bus and PCIe RC. */
>   #define TYPE_ASPEED_PCIE_CFG "aspeed.pcie-cfg"
> +#define TYPE_ASPEED_2700_PCIE_CFG TYPE_ASPEED_PCIE_CFG "-ast2700"
>   OBJECT_DECLARE_TYPE(AspeedPCIECfgState, AspeedPCIECfgClass, ASPEED_PCIE_CFG);
>   
>   struct AspeedPCIECfgState {
> @@ -99,6 +100,8 @@ struct AspeedPCIECfgState {
>       uint32_t id;
>   
>       AspeedPCIERcState rc;
> +    uint32_t tlpn_fifo[3];
> +    uint32_t tlpn_idx;
>   };
>   
>   struct AspeedPCIECfgClass {
> diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
> index bc491aa7bf..4adf17e40b 100644
> --- a/hw/pci-host/aspeed_pcie.c
> +++ b/hw/pci-host/aspeed_pcie.c
> @@ -336,6 +336,11 @@ static const TypeInfo aspeed_pcie_rc_info = {
>    * - Registers 0x00 - 0x7F are shared by both PCIe0 (rc_l) and PCIe1 (rc_h).
>    * - Registers 0x80 - 0xBF are specific to PCIe0.
>    * - Registers 0xC0 - 0xFF are specific to PCIe1.
> + *
> + * On the AST2700:
> + * - The register range 0x00 - 0xFF is assigned to a single PCIe configuration.
> + * - There are three PCIe Root Complexes (RCs), each with its own dedicated H2X
> + *   register set of size 0x100 (covering offsets 0x00 to 0xFF).
>    */
>   
>   /* AST2600 */
> @@ -365,6 +370,31 @@ REG32(H2X_RC_H_MSI_EN1,     0xE4)
>   REG32(H2X_RC_H_MSI_STS0,    0xE8)
>   REG32(H2X_RC_H_MSI_STS1,    0xEC)
>   
> +/* AST2700 */
> +REG32(H2X_CFGE_INT_STS,         0x08)
> +    FIELD(H2X_CFGE_INT_STS, TX_IDEL, 0, 1)
> +    FIELD(H2X_CFGE_INT_STS, RX_BUSY, 1, 1)
> +REG32(H2X_CFGI_TLP,         0x20)
> +    FIELD(H2X_CFGI_TLP, ADDR, 0, 16)
> +    FIELD(H2X_CFGI_TLP, BEN, 16, 4)
> +    FIELD(H2X_CFGI_TLP, WR, 20, 1)
> +REG32(H2X_CFGI_WDATA,       0x24)
> +REG32(H2X_CFGI_CTRL,        0x28)
> +    FIELD(H2X_CFGI_CTRL, FIRE, 0, 1)
> +REG32(H2X_CFGI_RDATA,       0x2C)
> +REG32(H2X_CFGE_TLP1,        0x30)
> +REG32(H2X_CFGE_TLPN,        0x34)
> +REG32(H2X_CFGE_CTRL,        0x38)
> +    FIELD(H2X_CFGE_CTRL, FIRE, 0, 1)
> +REG32(H2X_CFGE_RDATA,       0x3C)
> +REG32(H2X_INT_EN,          0x40)
> +REG32(H2X_INT_STS,         0x48)
> +    FIELD(H2X_INT_STS, INTX, 0, 4)
> +REG32(H2X_MSI_EN0,          0x50)
> +REG32(H2X_MSI_EN1,          0x54)
> +REG32(H2X_MSI_STS0,         0x58)
> +REG32(H2X_MSI_STS1,         0x5C)
> +
>   #define TLP_FMTTYPE_CFGRD0  0x04 /* Configuration Read  Type 0 */
>   #define TLP_FMTTYPE_CFGWR0  0x44 /* Configuration Write Type 0 */
>   #define TLP_FMTTYPE_CFGRD1  0x05 /* Configuration Read  Type 1 */
> @@ -382,6 +412,15 @@ static const AspeedPCIERegMap aspeed_regmap = {
>       },
>   };
>   
> +static const AspeedPCIERegMap aspeed_2700_regmap = {
> +    .rc = {
> +        .int_en_reg     = R_H2X_INT_EN,
> +        .int_sts_reg    = R_H2X_INT_STS,
> +        .msi_sts0_reg   = R_H2X_MSI_STS0,
> +        .msi_sts1_reg   = R_H2X_MSI_STS1,
> +    },
> +};
> +
>   static uint64_t aspeed_pcie_cfg_read(void *opaque, hwaddr addr,
>                                        unsigned int size)
>   {
> @@ -606,6 +645,8 @@ static void aspeed_pcie_cfg_reset(DeviceState *dev)
>       AspeedPCIECfgClass *apc = ASPEED_PCIE_CFG_GET_CLASS(s);
>   
>       memset(s->regs, 0, apc->nr_regs << 2);
> +    memset(s->tlpn_fifo, 0, sizeof(s->tlpn_fifo));
> +    s->tlpn_idx = 0;
>   }
>   
>   static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
> @@ -679,6 +720,122 @@ static const TypeInfo aspeed_pcie_cfg_info = {
>       .class_size = sizeof(AspeedPCIECfgClass),
>   };
>   
> +static void aspeed_2700_pcie_cfg_write(void *opaque, hwaddr addr,
> +                                       uint64_t data, unsigned int size)
> +{
> +    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(opaque);
> +    AspeedPCIECfgTxDesc desc;
> +    uint32_t reg = addr >> 2;
> +
> +    trace_aspeed_pcie_cfg_write(s->id, addr, data);
> +
> +    switch (reg) {
> +    case R_H2X_CFGE_INT_STS:
> +        if (data & R_H2X_CFGE_INT_STS_TX_IDEL_MASK) {
> +            s->regs[R_H2X_CFGE_INT_STS] &= ~R_H2X_CFGE_INT_STS_TX_IDEL_MASK;
> +        }
> +
> +        if (data & R_H2X_CFGE_INT_STS_RX_BUSY_MASK) {
> +            s->regs[R_H2X_CFGE_INT_STS] &= ~R_H2X_CFGE_INT_STS_RX_BUSY_MASK;
> +        }
> +        break;
> +    case R_H2X_CFGI_CTRL:
> +        if (data & R_H2X_CFGI_CTRL_FIRE_MASK) {
> +            /*
> +             * Internal access to bridge
> +             * Type and BDF are 0
> +             */
> +            desc.desc0 = 0x04000001 |
> +                (ARRAY_FIELD_EX32(s->regs, H2X_CFGI_TLP, WR) << 30);
> +            desc.desc1 = 0x00401000 |
> +                ARRAY_FIELD_EX32(s->regs, H2X_CFGI_TLP, BEN);
> +            desc.desc2 = 0x00000000 |
> +                ARRAY_FIELD_EX32(s->regs, H2X_CFGI_TLP, ADDR);
> +            desc.wdata = s->regs[R_H2X_CFGI_WDATA];
> +            desc.rdata_reg = R_H2X_CFGI_RDATA;
> +            aspeed_pcie_cfg_readwrite(s, &desc);
> +        }
> +        break;
> +    case R_H2X_CFGE_TLPN:
> +        s->tlpn_fifo[s->tlpn_idx] = data;
> +        s->tlpn_idx = (s->tlpn_idx + 1) % ARRAY_SIZE(s->tlpn_fifo);
> +        break;
> +    case R_H2X_CFGE_CTRL:
> +        if (data & R_H2X_CFGE_CTRL_FIRE_MASK) {
> +            desc.desc0 = s->regs[R_H2X_CFGE_TLP1];
> +            desc.desc1 = s->tlpn_fifo[0];
> +            desc.desc2 = s->tlpn_fifo[1];
> +            desc.wdata = s->tlpn_fifo[2];
> +            desc.rdata_reg = R_H2X_CFGE_RDATA;
> +            aspeed_pcie_cfg_readwrite(s, &desc);
> +            s->regs[R_H2X_CFGE_INT_STS] |= R_H2X_CFGE_INT_STS_TX_IDEL_MASK;
> +            s->regs[R_H2X_CFGE_INT_STS] |= R_H2X_CFGE_INT_STS_RX_BUSY_MASK;
> +            s->tlpn_idx = 0;
> +        }
> +        break;
> +
> +    case R_H2X_INT_STS:
> +        s->regs[reg] &= ~data | R_H2X_INT_STS_INTX_MASK;
> +        break;
> +    /*
> +     * These status registers are used for notify sources ISR are executed.
> +     * If one source ISR is executed, it will clear one bit.
> +     * If it clear all bits, it means to initialize this register status
> +     * rather than sources ISR are executed.
> +     */
> +    case R_H2X_MSI_STS0:
> +    case R_H2X_MSI_STS1:
> +        if (data == 0) {
> +            return ;
> +        }
> +
> +        s->regs[reg] &= ~data;
> +        if (data == 0xffffffff) {
> +            return;
> +        }
> +
> +        if (!s->regs[R_H2X_MSI_STS0] &&
> +            !s->regs[R_H2X_MSI_STS1]) {
> +            trace_aspeed_pcie_rc_msi_clear_irq(s->id, 0);
> +            qemu_set_irq(s->rc.irq, 0);
> +        }
> +        break;
> +    default:
> +        s->regs[reg] = data;
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps aspeed_2700_pcie_cfg_ops = {
> +    .read = aspeed_pcie_cfg_read,
> +    .write = aspeed_2700_pcie_cfg_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void aspeed_2700_pcie_cfg_class_init(ObjectClass *klass,
> +                                            const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedPCIECfgClass *apc = ASPEED_PCIE_CFG_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2700 PCIe Config";
> +    apc->reg_ops = &aspeed_2700_pcie_cfg_ops;
> +    apc->reg_map = &aspeed_2700_regmap;
> +    apc->nr_regs = 0x100 >> 2;
> +    apc->rc_msi_addr = 0x000000F0;
> +    apc->rc_bus_nr = 0;
> +}
> +
> +static const TypeInfo aspeed_2700_pcie_cfg_info = {
> +    .name = TYPE_ASPEED_2700_PCIE_CFG,
> +    .parent = TYPE_ASPEED_PCIE_CFG,
> +    .class_init = aspeed_2700_pcie_cfg_class_init,
> +};
> +
>   /*
>    * PCIe PHY
>    *
> @@ -846,6 +1003,7 @@ static void aspeed_pcie_register_types(void)
>       type_register_static(&aspeed_pcie_root_device_info);
>       type_register_static(&aspeed_pcie_root_port_info);
>       type_register_static(&aspeed_pcie_cfg_info);
> +    type_register_static(&aspeed_2700_pcie_cfg_info);
>       type_register_static(&aspeed_pcie_phy_info);
>       type_register_static(&aspeed_2700_pcie_phy_info);
>   }


