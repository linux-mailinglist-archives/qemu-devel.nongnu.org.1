Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FA988A40D
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Mar 2024 15:17:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rol7T-0007ym-UJ; Mon, 25 Mar 2024 10:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rDMc=K7=kaod.org=clg@ozlabs.org>)
 id 1rol7E-0007h5-Jb; Mon, 25 Mar 2024 10:15:59 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rDMc=K7=kaod.org=clg@ozlabs.org>)
 id 1rol7A-0006Ny-2p; Mon, 25 Mar 2024 10:15:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4V3FMk0P7Zz4wb0;
 Tue, 26 Mar 2024 01:15:46 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4V3FMd3qZVz4wcg;
 Tue, 26 Mar 2024 01:15:41 +1100 (AEDT)
Message-ID: <225449ea-475c-40a6-abf6-e2aba8dc3201@kaod.org>
Date: Mon, 25 Mar 2024 15:15:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] pnv/phb4: Implement read-only and write-only bits
 of registers
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com
References: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
 <20240321100422.5347-5-saif.abrar@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240321100422.5347-5-saif.abrar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=rDMc=K7=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/21/24 11:04, Saif Abrar wrote:
> SW cannot write the read-only(RO) bits of a register
> and write-only(WO) bits of a register return 0 when read.
> 
> Added ro_mask[] for each register that defines which
> bits in that register are RO.
> When writing to a register, the RO-bits are not updated.
> 
> When reading a register, clear the WO bits and return the updated value.
> 
> Tested the registers PHB_DMA_SYNC, PHB_PCIE_HOTPLUG_STATUS, PHB_PCIE_LMR,
> PHB_PCIE_DLP_TRWCTL, PHB_LEM_ERROR_AND_MASK and PHB_LEM_ERROR_OR_MASK
> by writing all 1's and reading back the value.
> The WO bits in these registers should read back as 0.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> ---
>   hw/pci-host/pnv_phb4.c              | 77 ++++++++++++++++++++++++++---
>   include/hw/pci-host/pnv_phb4.h      |  7 +++
>   include/hw/pci-host/pnv_phb4_regs.h | 19 +++++--
>   tests/qtest/pnv-phb4-test.c         | 60 +++++++++++++++++++++-
>   4 files changed, 150 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index b3a83837f8..a81763f34c 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -735,6 +735,10 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>           return;
>       }
>   
> +    /* Update 'val' according to the register's RO-mask */
> +    val = (phb->regs[off >> 3] & phb->ro_mask[off >> 3]) |
> +          (val & ~(phb->ro_mask[off >> 3]));
> +
>       /* Record whether it changed */
>       changed = phb->regs[off >> 3] != val;
>   
> @@ -808,7 +812,7 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>       case PHB_TCE_TAG_ENABLE:
>       case PHB_INT_NOTIFY_ADDR:
>       case PHB_INT_NOTIFY_INDEX:
> -    case PHB_DMARD_SYNC:
> +    case PHB_DMA_SYNC:
>          break;
>   
>       /* Noise on anything else */
> @@ -846,7 +850,7 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>       case PHB_VERSION:
>           return PNV_PHB4_PEC_GET_CLASS(phb->pec)->version;
>   
> -        /* Read-only */
> +    /* Read-only */
>       case PHB_PHB4_GEN_CAP:
>           return 0xe4b8000000000000ull;
>       case PHB_PHB4_TCE_CAP:
> @@ -856,18 +860,49 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>       case PHB_PHB4_EEH_CAP:
>           return phb->big_phb ? 0x2000000000000000ull : 0x1000000000000000ull;
>   
> +    /* Write-only, read will return zeros */
> +    case PHB_LEM_ERROR_AND_MASK:
> +    case PHB_LEM_ERROR_OR_MASK:
> +        return 0;
> +    case PHB_PCIE_DLP_TRWCTL:
> +        val &= ~PHB_PCIE_DLP_TRWCTL_WREN;
> +        return val;
>       /* IODA table accesses */
>       case PHB_IODA_DATA0:
>           return pnv_phb4_ioda_read(phb);
>   
> +    /*
> +     * DMA sync: make it look like it's complete,
> +     *           clear write-only read/write start sync bits.
> +     */
> +    case PHB_DMA_SYNC:
> +        val = PHB_DMA_SYNC_RD_COMPLETE |
> +            ~(PHB_DMA_SYNC_RD_START | PHB_DMA_SYNC_WR_START);
> +        return val;
> +
> +    /*
> +     * PCI-E Stack registers
> +     */
> +    case PHB_PCIE_SCR:
> +        val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
> +        break;
> +
>       /* Link training always appears trained */
>       case PHB_PCIE_DLP_TRAIN_CTL:
>           /* TODO: Do something sensible with speed ? */
> -        return PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
> +        val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
> +        return val;
> +
> +    case PHB_PCIE_HOTPLUG_STATUS:
> +        /* Clear write-only bit */
> +        val &= ~PHB_PCIE_HPSTAT_RESAMPLE;
> +        return val;
>   
> -    /* DMA read sync: make it look like it's complete */
> -    case PHB_DMARD_SYNC:
> -        return PHB_DMARD_SYNC_COMPLETE;
> +    /* Link Management Register */
> +    case PHB_PCIE_LMR:
> +        /* These write-only bits always read as 0 */
> +        val &= ~(PHB_PCIE_LMR_CHANGELW | PHB_PCIE_LMR_RETRAINLINK);
> +        return val;
>   
>       /* Silent simple reads */
>       case PHB_LSI_SOURCE_ID:
> @@ -1712,6 +1747,33 @@ static PCIIOMMUOps pnv_phb4_iommu_ops = {
>       .get_address_space = pnv_phb4_dma_iommu,
>   };
>   
> +static void pnv_phb4_ro_mask_init(PnvPHB4 *phb)
> +{
> +    /* Clear RO-mask to make all regs as R/W by default */
> +    memset(phb->ro_mask, 0x0, PNV_PHB4_NUM_REGS * sizeof(uint64_t));
> +
> +    /*
> +     * Set register specific RO-masks
> +     */
> +
> +    /* PBL - Error Injection Register (0x1910) */
> +    phb->ro_mask[PHB_PBL_ERR_INJECT >> 3] =
> +        PPC_BITMASK(0, 23) | PPC_BITMASK(28, 35) | PPC_BIT(38) | PPC_BIT(46) |
> +        PPC_BITMASK(49, 51) | PPC_BITMASK(55, 63);
> +
> +    /* Reserved bits[60:63] */
> +    phb->ro_mask[PHB_TXE_ERR_LEM_ENABLE >> 3] =
> +    phb->ro_mask[PHB_TXE_ERR_AIB_FENCE_ENABLE >> 3] = PPC_BITMASK(60, 63);
> +    /* Reserved bits[36:63] */
> +    phb->ro_mask[PHB_RXE_TCE_ERR_LEM_ENABLE >> 3] =
> +    phb->ro_mask[PHB_RXE_TCE_ERR_AIB_FENCE_ENABLE >> 3] = PPC_BITMASK(36, 63);
> +    /* Reserved bits[40:63] */
> +    phb->ro_mask[PHB_ERR_LEM_ENABLE >> 3] =
> +    phb->ro_mask[PHB_ERR_AIB_FENCE_ENABLE >> 3] = PPC_BITMASK(40, 63);


These constant values should be defined in an array under PnvPhb4Class

Thanks,

C.

> +    /* TODO: Add more RO-masks as regs are implemented in the model */
> +}
> +
>   static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
>   {
>       STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
> @@ -1782,6 +1844,9 @@ static void pnv_phb4_instance_init(Object *obj)
>   
>       /* XIVE interrupt source object */
>       object_initialize_child(obj, "source", &phb->xsrc, TYPE_XIVE_SOURCE);
> +
> +    /* Initialize RO-mask of registers */
> +    pnv_phb4_ro_mask_init(phb);
>   }
>   
>   void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb)
> diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
> index 3212e68160..91e81eee0e 100644
> --- a/include/hw/pci-host/pnv_phb4.h
> +++ b/include/hw/pci-host/pnv_phb4.h
> @@ -94,6 +94,13 @@ struct PnvPHB4 {
>       uint64_t regs[PNV_PHB4_NUM_REGS];
>       MemoryRegion mr_regs;
>   
> +    /*
> +     * Read-only bitmask for registers
> +     * Bit value: 1 => RO bit
> +     *            0 => RW bit
> +     */
> +    uint64_t ro_mask[PNV_PHB4_NUM_REGS];> +
>       /* Extra SCOM-only register */
>       uint64_t scom_hv_ind_addr_reg;
>   
> diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
> index df5e86d29a..391d6a89ea 100644
> --- a/include/hw/pci-host/pnv_phb4_regs.h
> +++ b/include/hw/pci-host/pnv_phb4_regs.h
> @@ -180,9 +180,11 @@
>   #define PHB_M64_AOMASK                  0x1d0
>   #define PHB_M64_UPPER_BITS              0x1f0
>   #define PHB_NXLATE_PREFIX               0x1f8
> -#define PHB_DMARD_SYNC                  0x200
> -#define   PHB_DMARD_SYNC_START          PPC_BIT(0)
> -#define   PHB_DMARD_SYNC_COMPLETE       PPC_BIT(1)
> +#define PHB_DMA_SYNC                    0x200
> +#define   PHB_DMA_SYNC_RD_START         PPC_BIT(0)
> +#define   PHB_DMA_SYNC_RD_COMPLETE      PPC_BIT(1)
> +#define   PHB_DMA_SYNC_WR_START         PPC_BIT(2)
> +#define   PHB_DMA_SYNC_WR_COMPLETE      PPC_BIT(3)
>   #define PHB_RTC_INVALIDATE              0x208
>   #define   PHB_RTC_INVALIDATE_ALL        PPC_BIT(0)
>   #define   PHB_RTC_INVALIDATE_RID        PPC_BITMASK(16, 31)
> @@ -395,8 +397,8 @@
>   #define PHB_PCIE_SCR                    0x1A00
>   #define   PHB_PCIE_SCR_SLOT_CAP         PPC_BIT(15)
>   #define   PHB_PCIE_SCR_MAXLINKSPEED     PPC_BITMASK(32, 35)
> +#define   PHB_PCIE_SCR_PLW_X16          PPC_BIT(41) /* x16 */
>   #define PHB_PCIE_BNR                    0x1A08
> -
>   #define PHB_PCIE_CRESET                 0x1A10
>   #define   PHB_PCIE_CRESET_CFG_CORE      PPC_BIT(0)
>   #define   PHB_PCIE_CRESET_TLDLP         PPC_BIT(1)
> @@ -405,7 +407,14 @@
>   #define   PHB_PCIE_CRESET_PIPE_N        PPC_BIT(4)
>   #define   PHB_PCIE_CRESET_REFCLK_N      PPC_BIT(8)
>   #define PHB_PCIE_HOTPLUG_STATUS         0x1A20
> +#define   PHB_PCIE_HPSTAT_SIMDIAG       PPC_BIT(3)
> +#define   PHB_PCIE_HPSTAT_RESAMPLE      PPC_BIT(9)
>   #define   PHB_PCIE_HPSTAT_PRESENCE      PPC_BIT(10)
> +#define   PHB_PCIE_HPSTAT_LINKACTIVE    PPC_BIT(12)
> +#define PHB_PCIE_LMR                    0x1A30
> +#define   PHB_PCIE_LMR_CHANGELW         PPC_BIT(0)
> +#define   PHB_PCIE_LMR_RETRAINLINK      PPC_BIT(1)
> +#define   PHB_PCIE_LMR_LINKACTIVE       PPC_BIT(8)
>   
>   #define PHB_PCIE_DLP_TRAIN_CTL          0x1A40
>   #define   PHB_PCIE_DLP_LINK_WIDTH       PPC_BITMASK(30, 35)
> @@ -433,7 +442,7 @@
>   
>   #define PHB_PCIE_DLP_TRWCTL             0x1A80
>   #define   PHB_PCIE_DLP_TRWCTL_EN        PPC_BIT(0)
> -
> +#define   PHB_PCIE_DLP_TRWCTL_WREN      PPC_BIT(1)
>   #define PHB_PCIE_DLP_ERRLOG1            0x1AA0
>   #define PHB_PCIE_DLP_ERRLOG2            0x1AA8
>   #define PHB_PCIE_DLP_ERR_STATUS         0x1AB0
> diff --git a/tests/qtest/pnv-phb4-test.c b/tests/qtest/pnv-phb4-test.c
> index 708df3867c..0c8e58dd5f 100644
> --- a/tests/qtest/pnv-phb4-test.c
> +++ b/tests/qtest/pnv-phb4-test.c
> @@ -75,7 +75,8 @@ static void phb4_sticky_rst_test(QTestState *qts)
>        * Sticky reset test of PHB_PBL_ERR_STATUS.
>        *
>        * Write all 1's to reg PHB_PBL_ERR_INJECT.
> -     * Updated value will be copied to reg PHB_PBL_ERR_STATUS.
> +     * RO-only bits will not be written and
> +     * updated value will be copied to reg PHB_PBL_ERR_STATUS.
>        *
>        * Reset PBL core by setting PHB_PCIE_CRESET_PBL in reg PHB_PCIE_CRESET.
>        * Verify the sticky bits are still set.
> @@ -83,7 +84,59 @@ static void phb4_sticky_rst_test(QTestState *qts)
>       pnv_phb4_xscom_write(qts, PHB_PBL_ERR_INJECT, PPC_BITMASK(0, 63));
>       pnv_phb4_xscom_write(qts, PHB_PCIE_CRESET, PHB_PCIE_CRESET_PBL); /*Reset*/
>       val = pnv_phb4_xscom_read(qts, PHB_PBL_ERR_STATUS);
> -    g_assert_cmpuint(val, ==, (PPC_BITMASK(0, 9) | PPC_BITMASK(12, 63)));
> +    g_assert_cmpuint(val, ==, 0xF00DFD8E00);
> +}
> +
> +/* Check that write-only bits/regs return 0 when read */
> +static void phb4_writeonly_read_test(QTestState *qts)
> +{
> +    uint64_t val;
> +
> +    /*
> +     * Set all bits of PHB_DMA_SYNC,
> +     * bits 0 and 2 are write-only and should be read as 0.
> +     */
> +    pnv_phb4_xscom_write(qts, PHB_DMA_SYNC, PPC_BITMASK(0, 63));
> +    val = pnv_phb4_xscom_read(qts, PHB_DMA_SYNC);
> +    g_assert_cmpuint(val & PPC_BIT(0), ==, 0x0);
> +    g_assert_cmpuint(val & PPC_BIT(2), ==, 0x0);
> +
> +    /*
> +     * Set all bits of PHB_PCIE_HOTPLUG_STATUS,
> +     * bit 9 is write-only and should be read as 0.
> +     */
> +    pnv_phb4_xscom_write(qts, PHB_PCIE_HOTPLUG_STATUS, PPC_BITMASK(0, 63));
> +    val = pnv_phb4_xscom_read(qts, PHB_PCIE_HOTPLUG_STATUS);
> +    g_assert_cmpuint(val & PPC_BIT(9), ==, 0x0);
> +
> +    /*
> +     * Set all bits of PHB_PCIE_LMR,
> +     * bits 0 and 1 are write-only and should be read as 0.
> +     */
> +    pnv_phb4_xscom_write(qts, PHB_PCIE_LMR, PPC_BITMASK(0, 63));
> +    val = pnv_phb4_xscom_read(qts, PHB_PCIE_LMR);
> +    g_assert_cmpuint(val & PPC_BIT(0), ==, 0x0);
> +    g_assert_cmpuint(val & PPC_BIT(1), ==, 0x0);
> +
> +    /*
> +     * Set all bits of PHB_PCIE_DLP_TRWCTL,
> +     * write-only bit-1 should be read as 0.
> +     */
> +    pnv_phb4_xscom_write(qts, PHB_PCIE_DLP_TRWCTL, PPC_BITMASK(0, 63));
> +    val = pnv_phb4_xscom_read(qts, PHB_PCIE_DLP_TRWCTL);
> +    g_assert_cmpuint(val & PPC_BIT(1), ==, 0x0);
> +
> +    /*
> +     * Set all bits of PHB_LEM_ERROR_AND_MASK, PHB_LEM_ERROR_OR_MASK,
> +     * both regs are write-only and should be read as 0.
> +     */
> +    pnv_phb4_xscom_write(qts, PHB_LEM_ERROR_AND_MASK, PPC_BITMASK(0, 63));
> +    val = pnv_phb4_xscom_read(qts, PHB_LEM_ERROR_AND_MASK);
> +    g_assert_cmpuint(val, ==, 0x0);
> +
> +    pnv_phb4_xscom_write(qts, PHB_LEM_ERROR_OR_MASK, PPC_BITMASK(0, 63));
> +    val = pnv_phb4_xscom_read(qts, PHB_LEM_ERROR_OR_MASK);
> +    g_assert_cmpuint(val, ==, 0x0);
>   }
>   
>   static void test_phb4(void)
> @@ -101,6 +154,9 @@ static void test_phb4(void)
>       /* Check sticky reset of a register */
>       phb4_sticky_rst_test(qts);
>   
> +    /* Check write-only logic */
> +    phb4_writeonly_read_test(qts);
> +
>       qtest_quit(qts);
>   }
>   


