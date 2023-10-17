Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEDC7CC091
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 12:20:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsh9b-0006Ju-8G; Tue, 17 Oct 2023 06:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qsh9X-0006Go-6k; Tue, 17 Oct 2023 06:18:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qsh9T-0001Ze-Gl; Tue, 17 Oct 2023 06:18:18 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8qcm1gJKz6K6ZD;
 Tue, 17 Oct 2023 18:15:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 17 Oct
 2023 11:18:11 +0100
Date: Tue, 17 Oct 2023 11:18:10 +0100
To: Alistair Francis <alistair23@gmail.com>
CC: <cbrowy@avery-design.com>, <wilfred.mallawa@wdc.com>, <mst@redhat.com>,
 <lukas@wunner.de>, <kbusch@kernel.org>, <hchkuo@avery-design.com.tw>,
 <its@irrelevant.dk>, <jiewen.yao@intel.com>, <marcel.apfelbaum@gmail.com>,
 <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 <qemu-block@nongnu.org>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 3/3] hw/nvme: Add SPDM over DOE support
Message-ID: <20231017111810.00004a84@Huawei.com>
In-Reply-To: <20231017052155.173577-4-alistair.francis@wdc.com>
References: <20231017052155.173577-1-alistair.francis@wdc.com>
 <20231017052155.173577-4-alistair.francis@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Tue, 17 Oct 2023 15:21:55 +1000
Alistair Francis <alistair23@gmail.com> wrote:

> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Setup Data Object Exchance (DOE) as an extended capability for the NVME
> controller and connect SPDM to it (CMA) to it.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  docs/specs/index.rst        |   1 +
>  docs/specs/spdm.rst         | 114 ++++++++++++++++++++++++++++++++++++
>  include/hw/pci/pci_device.h |   5 ++
>  include/hw/pci/pcie_doe.h   |   3 +
>  hw/nvme/ctrl.c              |  53 +++++++++++++++++
>  5 files changed, 176 insertions(+)
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
> index 0000000000..dfdc3cbb4d
> --- /dev/null
> +++ b/docs/specs/spdm.rst
> @@ -0,0 +1,114 @@
> +======================================================
> +QEMU Security Protocols and Data Models (SPDM) Support
> +======================================================
> +
> +SPDM enables authentication, attestation and key exchange to assist in
> +providing infrastructure security enablement. It's a standard published
> +by the `DMTF`_.
> +
> +QEMU supports connecting to a SPDM Responder implementation. This allows an
> +external application to emulate the SPDM Responder logic for an SPDM device.
> +
> +Setting up a SPDM server
> +========================
> +
> +When using QEMU with SPDM devices QEMU will connect to a server which
> +implements the SPDM functionality.
> +
> +SPDM-Utils
> +----------
> +
> +You can use `SPDM Utils`_ to emulate a Responder.
> +
> +SPDM-Utils is a Linux applications to manage, test and develop devices
> +supporting DMTF Security Protocol and Data Model (SPDM). It is written in Rust
> +and utilises libspdm.
> +
> +To use SPDM-Utils you will need to do the followoing:

Spell check needed. following

> +
> + 1. `Build SPDM Utils`_
> + 2. `Generate the certificates`_
> + 3. `Run it as a server`_
> +
> +spdm-emu
> +--------
> +
> +You can use `spdm emu`_ to model the
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
> +It is worth noting that the certificates should be in compliance with
> +PCIe r6.1 sec 6.31.3. This means you will need to add the following to
> +openssl.cnf
> +
> +.. code-block::
> +
> +    subjectAltName = otherName:2.23.147;UTF8:Vendor=1b36:Device=0010:CC=010802:REV=02:SSVID=1af4:SSID=1100
> +    2.23.147 = ASN1:OID:2.23.147
> +
> +and then manually regenerate some certificates with:
> +
> +.. code-block:: shell
> +
> +    openssl req -nodes -newkey ec:param.pem -keyout end_responder.key -out end_responder.req -sha384 -batch -subj "/CN=DMTF libspdm ECP384 responder cert"

For these no need to have on oneline maybe some \ ?
to make it easier to read if someone looks at the rst file.

> +    openssl x509 -req -in end_responder.req -out end_responder.cert -CA inter.cert -CAkey inter.key -sha384 -days 3650 -set_serial 3 -extensions v3_end -extfile ../openssl.cnf
> +    openssl asn1parse -in end_responder.cert -out end_responder.cert.der
> +    cat ca.cert.der inter.cert.der end_responder.cert.der > bundle_responder.certchain.der
> +

Otherwise this all looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

