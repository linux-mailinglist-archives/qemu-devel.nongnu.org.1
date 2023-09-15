Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 149AA7A21A8
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:01:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhAIp-0008OX-Hi; Fri, 15 Sep 2023 11:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qhAIj-0008NT-Sv; Fri, 15 Sep 2023 11:00:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qhAIh-0008BS-6q; Fri, 15 Sep 2023 11:00:09 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnHQf35b0z6K6YD;
 Fri, 15 Sep 2023 22:59:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 15 Sep
 2023 16:00:01 +0100
Date: Fri, 15 Sep 2023 16:00:00 +0100
To: Alistair Francis <alistair23@gmail.com>
CC: <lukas@wunner.de>, <wilfred.mallawa@wdc.com>, <jiewen.yao@intel.com>,
 <qemu-devel@nongnu.org>, <kbusch@kernel.org>, <its@irrelevant.dk>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <hchkuo@avery-design.com.tw>, 
 <cbrowy@avery-design.com>, <qemu-block@nongnu.org>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/3] hw/nvme: Add SPDM over DOE support
Message-ID: <20230915160000.00000ea0@Huawei.com>
In-Reply-To: <20230915112723.2033330-3-alistair.francis@wdc.com>
References: <20230915112723.2033330-1-alistair.francis@wdc.com>
 <20230915112723.2033330-3-alistair.francis@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, 15 Sep 2023 21:27:23 +1000
Alistair Francis <alistair23@gmail.com> wrote:

> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Setup Data Object Exchance (DOE) as an extended capability for the NVME
> controller and connect SPDM to it (CMA) to it.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
A few comments inline.  

> ---
>  docs/specs/index.rst        |  1 +
>  docs/specs/spdm.rst         | 56 +++++++++++++++++++++++++++++++++++++
>  include/hw/pci/pci_device.h |  5 ++++
>  include/hw/pci/pcie_doe.h   |  3 ++
>  hw/nvme/ctrl.c              | 52 ++++++++++++++++++++++++++++++++++
>  hw/nvme/trace-events        |  1 +
>  6 files changed, 118 insertions(+)
>  create mode 100644 docs/specs/spdm.rst
> 
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index e58be38c41..c398541388 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -24,3 +24,4 @@ guest hardware that is specific to QEMU.
>     acpi_erst
>     sev-guest-firmware
>     fw_cfg
> +   spdm
> diff --git a/docs/specs/spdm.rst b/docs/specs/spdm.rst
> new file mode 100644
> index 0000000000..0f96d618ef
> --- /dev/null
> +++ b/docs/specs/spdm.rst
> @@ -0,0 +1,56 @@
> +======================================================
> +QEMU Security Protocols and Data Models (SPDM) Support
> +======================================================
> +
> +SPDM enables authentication, attestation and key exchange to assist in
> +providing infrastructure security enablement. It's a standard published
> +by the DMTF https://www.dmtf.org/standards/SPDM.
> +
> +Setting up a SPDM server
> +========================
> +
> +When using QEMU with SPDM devices QEMU will connect to a server which
> +implements the SPDM functionality.
> +
> +spdm-emu
> +--------
> +
> +You can use spdm-emu https://github.com/dmtf/spdm-emu to model the
> +SPDM responder.
> +
> +.. code-block:: shell
> +
> +    $ cd spdm-emu
> +    $ git submodule init; git submodule update --recursive
> +    $ mkdir build; cd build
> +    $ cmake -DARCH=x64 -DTOOLCHAIN=GCC -DTARGET=Debug -DCRYPTO=openssl ..
> +    $ make -j32
> +    $ make copy_sample_key # Build certificates, required for SPDM authentication.
> +
> +The responder can then be launched with
> +
> +.. code-block:: shell
> +
> +    $ cd bin
> +    $ ./spdm_responder_emu --trans PCI_DOE
> +
> +Connecting an SPDM NVMe device
> +==============================
> +
> +Once a SPDM server is running we can start QEMU and connect to the server.
> +
> +For an NVMe device first let's setup a block we can use
> +
> +.. code-block:: shell
> +
> +    $ cd qemu-spdm/linux/image
> +    $ dd if=/dev/zero of=blknvme bs=1M count=2096 # 2GB NNMe Drive
> +
> +Then you can add this to your QEMU command line:
> +
> +.. code-block:: shell
> +
> +    -drive file=blknvme,if=none,id=mynvme,format=raw \
> +    -device nvme,drive=mynvme,serial=deadbeef,spdm=2323
> +
> +At which point QEMU will connect to the SPDM server.

try to connect.

...

>  
>  void pcie_doe_init(PCIDevice *pdev, DOECap *doe_cap, uint16_t offset,
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 90687b168a..1ff30a9ad4 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -203,6 +203,7 @@
>  #include "sysemu/hostmem.h"
>  #include "hw/pci/msix.h"
>  #include "hw/pci/pcie_sriov.h"
> +#include "sysemu/spdm-socket.h"
>  #include "migration/vmstate.h"
>  
>  #include "nvme.h"
> @@ -8077,6 +8078,28 @@ static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
>      return 0;
>  }
>  
> +static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
> +{
> +    void *req = pcie_doe_get_write_mbox_ptr(doe_cap);
> +    uint32_t req_len = pcie_doe_get_obj_len(req) * 4;
> +    void *rsp = doe_cap->read_mbox;
> +    uint32_t rsp_len = SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
> +    uint32_t recvd;
> +
> +    recvd = spdm_socket_rsp(doe_cap->socket,
> +                             SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE,
> +                             req, req_len, rsp, rsp_len);
> +    doe_cap->read_mbox_len += DIV_ROUND_UP(recvd, 4);
> +
> +    return (recvd == 0) ? false : true;

return recd != 0;

> +}
> +
> +static DOEProtocol doe_spdm_prot[] = {
> +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_CMA, pcie_doe_spdm_rsp },
> +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_SECURED_CMA, pcie_doe_spdm_rsp },
> +    { }
> +};
> +
>  static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
>  {
>      ERRP_GUARD();
> @@ -8133,6 +8156,23 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
>  
>      nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
>  
> +    pcie_cap_deverr_init(pci_dev);

Unrelated. Or I can't tell why it is related anyway.

> +
> +    /* DOE Initialisation */
> +    if (pci_dev->spdm_port) {
> +        uint16_t doe_offset = n->params.sriov_max_vfs ?
> +                                  PCI_CONFIG_SPACE_SIZE + PCI_ARI_SIZEOF
> +                                  : PCI_CONFIG_SPACE_SIZE;
> +
> +        pcie_doe_init(pci_dev, &pci_dev->doe_spdm, doe_offset, doe_spdm_prot, true, 0);
> +
> +        pci_dev->doe_spdm.socket = spdm_socket_connect(pci_dev->spdm_port, errp);
If going to carry on anyway, which is a valid choice, I'd put the result of this
in a local variable and only set pci_dev->doe_spdm.socket on success perhaps?
Also, don't register the DOE if that happens.

Better still - error out as if someone asked for it and the socket connect failed.
 
> +
> +        if (pci_dev->doe_spdm.socket < 0 ) {
> +            trace_pci_cma_err_openspdm_conn();
> +        }
> +    }
> +
>      if (n->params.cmb_size_mb) {
>          nvme_init_cmb(n, pci_dev);
>      }
> @@ -8419,6 +8459,7 @@ static Property nvme_props[] = {
>                        params.sriov_max_vi_per_vf, 0),
>      DEFINE_PROP_UINT8("sriov_max_vq_per_vf", NvmeCtrl,
>                        params.sriov_max_vq_per_vf, 0),
> +    DEFINE_PROP_UINT16("spdm", PCIDevice, spdm_port, 0),
>      DEFINE_PROP_END_OF_LIST(),


