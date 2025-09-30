Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B4DBADED1
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Sep 2025 17:39:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3cPf-0007dc-60; Tue, 30 Sep 2025 11:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3cPc-0007d5-4C
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:37:08 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3cPQ-0003vz-8G
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:37:07 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cbhtr4yMhz6L4wr;
 Tue, 30 Sep 2025 23:34:28 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 4DED71402ED;
 Tue, 30 Sep 2025 23:36:39 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 30 Sep
 2025 16:36:38 +0100
Date: Tue, 30 Sep 2025 16:36:36 +0100
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <ira.weiny@intel.com>, <lucerop@amd.com>, <a.manzanares@samsung.com>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <armbru@redhat.com>,
 <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 4/5] hw/cxl: Support type3 HDM-DB
Message-ID: <20250930163636.00006770@huawei.com>
In-Reply-To: <20250930032153.1127773-5-dave@stgolabs.net>
References: <20250930032153.1127773-1-dave@stgolabs.net>
 <20250930032153.1127773-5-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 29 Sep 2025 20:21:52 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add basic plumbing for memory expander devices that support Back
> Invalidation. This introduces a 'hdm-db=on|off' parameter and
> exposes the relevant BI RT/Decoder component cachemem registers.
> 
> Some noteworthy properties:
>  - Devices require enabling Flit mode.
>  - Explicit BI-ID commit is required.
>  - HDM decoder support both host and dev coherency models.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Hi Davidlohr,

Comments inline mostly focus on the bi parameter.  I think flipping
it to true for components where we are hard coding it as true will
move that logic decision up a layer and make the code easier to follow.

Thanks,

Jonathan

> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index a43d227336ca..2098e9999a88 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c

> @@ -235,7 +309,7 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
>  }
>  
>  static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> -                            enum reg_type type)
> +                            enum reg_type type, bool bi)
>  {
>      int decoder_count = CXL_HDM_DECODER_COUNT;
>      int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
> @@ -260,7 +334,9 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>                       UIO_DECODER_COUNT, 0);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 0);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> -                     SUPPORTED_COHERENCY_MODEL, 0); /* Unknown */
> +                     SUPPORTED_COHERENCY_MODEL,
> +                     /* host+dev or Unknown */
> +                     type == CXL2_TYPE3_DEVICE && bi ? 3 : 0);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
>                       HDM_DECODER_ENABLE, 0);
>      write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
> @@ -271,8 +347,7 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>          write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc] = 0xffffffff;
>          write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] = 0x13ff;
>          if (type == CXL2_DEVICE ||
> -            type == CXL2_TYPE3_DEVICE ||
> -            type == CXL2_LOGICAL_DEVICE) {
> +            type == CXL2_TYPE3_DEVICE || type == CXL2_LOGICAL_DEVICE) {

Unrelated change? Or am I missing something real here?

>              write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * hdm_inc] =
>                  0xf0000000;
>          } else {
> @@ -283,9 +358,43 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,


>  void cxl_component_register_init_common(uint32_t *reg_state,
>                                          uint32_t *write_msk,
> -                                        enum reg_type type)
> +                                        enum reg_type type,
> +                                        bool bi)

I wonder if we shouldn't set bi for all 3 component types that actually
have the BI related capability?   For Type3 we keep it controllable
and for DSP and RP hard code the parameter to true.

>  {
>      int caps = 0;
>  
> @@ -325,7 +434,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>      case CXL2_LOGICAL_DEVICE:
>          /* + HDM */
>          init_cap_reg(HDM, 5, 1);
> -        hdm_init_common(reg_state, write_msk, type);
> +        hdm_init_common(reg_state, write_msk, type, bi);
>          /* fallthrough */
>      case CXL2_DOWNSTREAM_PORT:
>      case CXL2_DEVICE:
> @@ -340,6 +449,26 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>          abort();
>      }
>  
> +    /* back invalidate */

With bi set true in cases where there is anything to do here, could wrap
this in an if (bi)

> +    switch (type) {
> +    case CXL2_UPSTREAM_PORT:
> +        init_cap_reg(BI_RT, 11, CXL_BI_RT_CAP_VERSION);
> +        bi_rt_init_common(reg_state, write_msk);
> +        break;
> +    case CXL2_ROOT_PORT:
> +    case CXL2_DOWNSTREAM_PORT:
> +    case CXL2_TYPE3_DEVICE:
> +        if (type == CXL2_TYPE3_DEVICE && !bi)  {

With the values for the other types tweaked this check becomes unnecessary

> +            break;
> +        }
> +
> +        init_cap_reg(BI_DECODER, 12, CXL_BI_DECODER_CAP_VERSION);
> +        bi_decoder_init_common(reg_state, write_msk, type);
> +        break;
> +    default:
> +        break;
> +    }
> +
>      ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
>  #undef init_cap_reg
>  }

>  
>  static uint64_t get_lsa_size(CXLType3Dev *ct3d)
> diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
> index f8d64263ac08..e0593e783803 100644
> --- a/hw/pci-bridge/cxl_downstream.c
> +++ b/hw/pci-bridge/cxl_downstream.c
> @@ -42,7 +42,7 @@ static void latch_registers(CXLDownstreamPort *dsp)
>      uint32_t *write_msk = dsp->cxl_cstate.crb.cache_mem_regs_write_mask;
>  
>      cxl_component_register_init_common(reg_state, write_msk,
> -                                       CXL2_DOWNSTREAM_PORT);
> +                                       CXL2_DOWNSTREAM_PORT, false);
This false briefly confused me and is the reason for comment above.
DSPs and RPs have BI support and it's odd to set a parameter here called
bi to false, only to enable it always.

>  }
>  
>  /* TODO: Look at sharing this code across all CXL port types */
> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
> index f3472f081707..1c0087d3f111 100644
> --- a/hw/pci-bridge/cxl_root_port.c
> +++ b/hw/pci-bridge/cxl_root_port.c
> @@ -106,7 +106,8 @@ static void latch_registers(CXLRootPort *crp)
>      uint32_t *reg_state = crp->cxl_cstate.crb.cache_mem_registers;
>      uint32_t *write_msk = crp->cxl_cstate.crb.cache_mem_regs_write_mask;
>  
> -    cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT);
> +    cxl_component_register_init_common(reg_state, write_msk,
> +                                       CXL2_ROOT_PORT, false);

Same here.  Also I think under 80 chars with CXL2_ROOT_PORT, on first line


>  }
>  
>  static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index e5a0d1fb308c..4bc185df8c87 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -136,7 +136,7 @@ static void latch_registers(CXLUpstreamPort *usp)
>      uint32_t *write_msk = usp->cxl_cstate.crb.cache_mem_regs_write_mask;
>  
>      cxl_component_register_init_common(reg_state, write_msk,
> -                                       CXL2_UPSTREAM_PORT);
> +                                       CXL2_UPSTREAM_PORT, false);

Obviously different structure but still seems odd that bi is false yet we create
BI_RT structure in this call.

>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 8);
>  }

> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index cd92cb02532a..0ff9f5b0fddf 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -67,6 +67,8 @@ CXLx_CAPABILITY_HEADER(LINK, 2)
>  CXLx_CAPABILITY_HEADER(HDM, 3)
>  CXLx_CAPABILITY_HEADER(EXTSEC, 4)
>  CXLx_CAPABILITY_HEADER(SNOOP, 5)
> +CXLx_CAPABILITY_HEADER(BI_RT, 6)
> +CXLx_CAPABILITY_HEADER(BI_DECODER, 7)
>  
>  /*
>   * Capability structures contain the actual registers that the CXL component
> @@ -211,10 +213,55 @@ HDM_DECODER_INIT(3);
>      (CXL_IDE_REGISTERS_OFFSET + CXL_IDE_REGISTERS_SIZE)
>  #define CXL_SNOOP_REGISTERS_SIZE   0x8
>  
> -QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET +
> -                    CXL_SNOOP_REGISTERS_SIZE) >= 0x1000,
> +#define CXL_BI_RT_CAP_VERSION 1
> +#define CXL_BI_RT_REGISTERS_OFFSET \
> +    (CXL_SNOOP_REGISTERS_OFFSET + CXL_SNOOP_REGISTERS_SIZE)
> +#define CXL_BI_RT_REGISTERS_SIZE   0xC
> +
> +REG32(CXL_BI_RT_CAPABILITY, CXL_BI_RT_REGISTERS_OFFSET)
> +    FIELD(CXL_BI_RT_CAPABILITY, EXPLICIT_COMMIT, 0, 1)
> +REG32(CXL_BI_RT_CTRL, CXL_BI_RT_REGISTERS_OFFSET + 0x4)
> +    FIELD(CXL_BI_RT_CTRL, COMMIT, 0, 1)
> +REG32(CXL_BI_RT_STATUS, CXL_BI_RT_REGISTERS_OFFSET + 0x8)
> +    FIELD(CXL_BI_RT_STATUS, COMMITTED, 0, 1)
> +    FIELD(CXL_BI_RT_STATUS, ERR_NOT_COMMITTED, 1, 1)
> +    FIELD(CXL_BI_RT_STATUS, COMMIT_TMO_SCALE, 8, 4)
> +    FIELD(CXL_BI_RT_STATUS, COMMIT_TMO_BASE, 12, 4)
> +
> +/* CXL r3.2 8.2.4.27 - CXL BI Decoder Capability Structure */
> +#define CXL_BI_DECODER_CAP_VERSION 1
> +#define CXL_BI_DECODER_REGISTERS_OFFSET \
> +    (CXL_BI_RT_REGISTERS_OFFSET + CXL_BI_RT_REGISTERS_SIZE)
> +#define CXL_BI_DECODER_REGISTERS_SIZE   0xC
> +
> +REG32(CXL_BI_DECODER_CAPABILITY, CXL_BI_DECODER_REGISTERS_OFFSET)
> +    FIELD(CXL_BI_DECODER_CAPABILITY, HDM_D, 0, 1)
> +    FIELD(CXL_BI_DECODER_CAPABILITY, EXPLICIT_COMMIT, 1, 1)
> +REG32(CXL_BI_DECODER_CTRL, CXL_BI_DECODER_REGISTERS_OFFSET + 0x4)
> +    FIELD(CXL_BI_DECODER_CTRL, BI_FW, 0, 1)
> +    FIELD(CXL_BI_DECODER_CTRL, BI_ENABLE, 1, 1)
> +    FIELD(CXL_BI_DECODER_CTRL, COMMIT, 2, 1)
> +REG32(CXL_BI_DECODER_STATUS, CXL_BI_DECODER_REGISTERS_OFFSET + 0x8)
> +    FIELD(CXL_BI_DECODER_STATUS, COMMITTED, 0, 1)
> +    FIELD(CXL_BI_DECODER_STATUS, ERR_NOT_COMMITTED, 1, 1)
> +    FIELD(CXL_BI_DECODER_STATUS, COMMIT_TMO_SCALE, 8, 4)
> +    FIELD(CXL_BI_DECODER_STATUS, COMMIT_TMO_BASE, 12, 4)
> +
> +QEMU_BUILD_BUG_MSG((CXL_BI_DECODER_REGISTERS_OFFSET +
> +                    CXL_BI_DECODER_REGISTERS_SIZE) >= 0x1000,
>                     "No space for registers");
>  
> +/* track BI explicit commit handling for route table and decoder */
> +enum {
> +    CXL_BISTATE_RT = 0,
> +    CXL_BISTATE_DECODER,
> +    CXL_BISTATE_MAX
> +};
> +
> +typedef struct bi_state {
> +    uint64_t last_commit;  /* last 0->1 transition */
> +} BIState;
> +
>  typedef struct component_registers {
>      /*
>       * Main memory region to be registered with QEMU core.
> @@ -260,6 +307,7 @@ typedef struct cxl_component {
>  
>      CDATObject cdat;
>      CXLCompObject compliance;
> +    BIState bi_state[CXL_BISTATE_MAX];
>  } CXLComponentState;
>  
>  void cxl_component_register_block_init(Object *obj,
> @@ -267,7 +315,7 @@ void cxl_component_register_block_init(Object *obj,
>                                         const char *type);
>  void cxl_component_register_init_common(uint32_t *reg_state,
>                                          uint32_t *write_msk,
> -                                        enum reg_type type);
> +                                        enum reg_type type, bool bi);
>  
>  void cxl_component_create_dvsec(CXLComponentState *cxl_cstate,
>                                  enum reg_type cxl_dev_type, uint16_t length,
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 0abfd678b875..75603b8180b5 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -841,6 +841,9 @@ struct CXLType3Dev {
>      CXLMemSparingReadAttrs rank_sparing_attrs;
>      CXLMemSparingWriteAttrs rank_sparing_wr_attrs;
>  
> +    /* BI flows */
> +    bool hdmdb;
> +
>      struct dynamic_capacity {
>          HostMemoryBackend *host_dc;
>          AddressSpace host_dc_as;


