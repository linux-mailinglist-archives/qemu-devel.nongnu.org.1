Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8B47B253E
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 20:28:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlvjf-0004RW-BE; Thu, 28 Sep 2023 14:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@gmx.us>) id 1qlvjd-0004R2-EI
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 14:27:37 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@gmx.us>) id 1qlvjb-0003KR-J7
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 14:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us; s=s31663417;
 t=1695925631; x=1696530431; i=fan.ni@gmx.us;
 bh=BY5/Yi6hpYhJcOvd/lg8K4i4ioKWF2ZBhExNg1EG9ac=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XRRoEVHynCzU2fomvFD9C/2I90LVZEQ9HY2lxWiJTXosnr6Vk5QofY55Ame6R/8hJwxF8w+w9cT
 ntfi4d2PofvOV8ZnbQIg+PQvK+z85TfKQ48WUgQOemjGjMMT9kQRv33TtcefYZWEu3Qwp1CU6L26H
 AwxLirzDUNNXPDQ2/VJzpRaW3odHG6zWAazQjNhPD/YqF39wBkxZWNarzgesowtU0s7UbIPtyhsbp
 HAk6xsK6DUuUJoHVOmLpheCBtNWHVGPMAnhO0cYL1Y9Cxqt5rnf5yRCZnOuDZwfVt1t++vXUuKN+r
 bI/iARqQqB5Zt5PS33Q/b0aWZsEeYMu9IFWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([99.13.228.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHXBj-1qq6Zz1P7Z-00DU7L; Thu, 28
 Sep 2023 20:27:11 +0200
Date: Thu, 28 Sep 2023 11:26:57 -0700
From: Fan Ni <fan.ni@gmx.us>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Michael Tsirkin <mst@redhat.com>, linuxarm@huawei.com,
 Fan Ni <fan.ni@samsung.com>, Philippe Mathieu-Daud? <philmd@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Gregory Price <gregory.price@memverge.com>,
 Klaus Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 05/19] hw/pci-bridge/cxl_upstream: Move defintion of
 device to header.
Message-ID: <ZRXFcX0-3UnqycYe@debian>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
 <20230925161124.18940-6-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925161124.18940-6-Jonathan.Cameron@huawei.com>
X-Provags-ID: V03:K1:DBvQ3XVtw87a1DwgOnKvweizGDOHaBqEWkQBkYt5Cr0wejGYIal
 HzqZsVdZzkSmmxI8QuU3chBgP6eMUQ3bhs0klLH5JgTVECdvaGoFsfOEjZfWNn8OSH4E7ml
 HbQqQt4IYoXqiCLofIAoZzEkLlHXJxVtLKgcGA67shiYw2oM7DoMUClq16BkBJkhO71dwtJ
 VzluIOaPmP5BiEByGfi1w==
UI-OutboundReport: notjunk:1;M01:P0:d7iw3oy8PFk=;fbg16xwDAkVrk+jDxf+dLu+8XLw
 PQ7jUJwzwg+Hvun9JB9DwItwRwMS3J9DdeEnfvEtVr1Z2HhpZKRz+krNqLhOH/9IDCqatFbl2
 CsdL3lYS1nm5eotrRL7U///OfZVVsijy3Ilt+2iFi9/9M48gAnneSQiJoSUjEoejky5fKqSu4
 7Qggha7KEygwKsEDX1evuBZh/FT2XxB5m6e2IwnEpFWEboxDX7GrSyoqIZI9K/AbBSm+Lu4Uc
 O+DmdQlUB0ki9n9Si+7NWfwJT4MtvBU3vxR2nAC/NABgQTWmevO0O6t6DdzEZ0UqfYETqgpdc
 Dnan9wGFZFo61KxZPv/0O0HOM8Wo6PYK6IqKXRyRlb2OrAbnkP7KgOda4JOQ4/Mq6YD7i9pJD
 fPrGfZ1V13TmiqKa818JYQpWhfYeArXYBn4Q4bCL313UX4H5airFZT3TtuepTz+llsBAFNgJC
 bXXYP8nFaVN6Aw9NsjIWm5EKsURuo/8ZMwG9SzO/3wFAdpOt6YdWiLajFpRTr++51QN6hTkP4
 N4weGJwDu11DPW8O6+ZEl99UFAYVNCpslcsDvKvRPzuJfB6Sajpfd55jTDKA7tExViu6at96n
 67WwFUMUjAPBZlEgnOJGl2HCoRJjY517F7bBAM9UKJw1g/9Tf5eCqEcYx9v4XTGlkDXjbsqEW
 1Y5HeYtXj9sfX2PnYed5p78hVdYv4whuxBEYM0DxhMKE3YH/pwJYaUKuifV0cQyie2Q4ph/ex
 XddiCnpSBbMXKT5O42Wvyoi7/8V9E+R8dmGmd4cOzgYMbQ+GHNa6FJyXFRil8sRYwJ5LnaiJF
 ybtGgVXOkK6KNuPxk9TGQHszdTZ1q0mZtqVjzHgKbZcBLZSjYCVB/YyhhNElfAeWvlqiW51hd
 C1ldlPJu98nchnEeX0ne3kj/+jOG2QverPA9lc5O0D5/EP6hyS6r+7yS0X/S3TFZVE91dCEsA
 WUKP3kdzfNGv2b3RPsYFDgqa4Hs=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.15; envelope-from=fan.ni@gmx.us;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 25, 2023 at 05:11:10PM +0100, Jonathan Cameron wrote:
> To avoid repetition of switch upstream port specific data in the
> CXLDeviceState structure it will be necessary to access the switch USP
> specific data from mailbox callbacks. Hence move it to cxl_device.h so i=
t
> is no longer an opaque structure.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/pci-bridge/cxl_upstream_port.h | 18 ++++++++++++++++++
>  hw/pci-bridge/cxl_upstream.c              | 11 +----------
>  2 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-=
bridge/cxl_upstream_port.h
> new file mode 100644
> index 0000000000..b02aa8f659
> --- /dev/null
> +++ b/include/hw/pci-bridge/cxl_upstream_port.h
> @@ -0,0 +1,18 @@
> +
> +#ifndef CXL_USP_H
> +#define CXL_USP_H
> +#include "hw/pci/pcie.h"
> +#include "hw/pci/pcie_port.h"
> +#include "hw/cxl/cxl.h"
> +
> +typedef struct CXLUpstreamPort {
> +    /*< private >*/
> +    PCIEPort parent_obj;
> +
> +    /*< public >*/
> +    CXLComponentState cxl_cstate;
> +    DOECap doe_cdat;
> +    uint64_t sn;
> +} CXLUpstreamPort;
> +
> +#endif /* CXL_SUP_H */
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index b81bb5fec9..36737189c6 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -14,6 +14,7 @@
>  #include "hw/pci/msi.h"
>  #include "hw/pci/pcie.h"
>  #include "hw/pci/pcie_port.h"
> +#include "hw/pci-bridge/cxl_upstream_port.h"
>  /*
>   * Null value of all Fs suggested by IEEE RA guidelines for use of
>   * EU, OUI and CID
> @@ -30,16 +31,6 @@
>  #define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
>      (CXL_UPSTREAM_PORT_SN_OFFSET + PCI_EXT_CAP_DSN_SIZEOF)
>
> -typedef struct CXLUpstreamPort {
> -    /*< private >*/
> -    PCIEPort parent_obj;
> -
> -    /*< public >*/
> -    CXLComponentState cxl_cstate;
> -    DOECap doe_cdat;
> -    uint64_t sn;
> -} CXLUpstreamPort;
> -
>  CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp)
>  {
>      return &usp->cxl_cstate;
> --
> 2.39.2
>

