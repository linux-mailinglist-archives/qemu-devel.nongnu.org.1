Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7DC710B29
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:35:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q29FJ-0008CA-S5; Thu, 25 May 2023 07:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q29FA-0007jn-PZ; Thu, 25 May 2023 07:34:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q29F9-0002KH-1q; Thu, 25 May 2023 07:34:56 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QRm7S1g4vz6J652;
 Thu, 25 May 2023 19:30:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 25 May
 2023 12:34:50 +0100
Date: Thu, 25 May 2023 12:34:49 +0100
To: Klaus Jensen <its@irrelevant.dk>
CC: <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>, Jeremy Kerr
 <jk@codeconstruct.com.au>, <qemu-arm@nongnu.org>, Peter Delevoryas
 <peter@pjd.dev>, Keith Busch <kbusch@kernel.org>, "=?ISO-8859-1?Q?C=E9dric?=
 Le Goater" <clg@kaod.org>, Jason Wang <jasowang@redhat.com>, Lior Weintraub
 <liorw@pliops.com>, <qemu-block@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Matt Johnston <matt@codeconstruct.com.au>, Klaus
 Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v2 3/3] hw/nvme: add nvme management interface model
Message-ID: <20230525123449.00001d60@Huawei.com>
In-Reply-To: <20230425063540.46143-4-its@irrelevant.dk>
References: <20230425063540.46143-1-its@irrelevant.dk>
 <20230425063540.46143-4-its@irrelevant.dk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 25 Apr 2023 08:35:40 +0200
Klaus Jensen <its@irrelevant.dk> wrote:

> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add the 'nmi-i2c' device that emulates an NVMe Management Interface
> controller.
> 
> Initial support is very basic (Read NMI DS, Configuration Get).
> 
> This is based on previously posted code by Padmakar Kalghatgi, Arun
> Kumar Agasar and Saurav Kumar.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

I don't have time to do too much spec diving so this is very superficial...

Mostly commenting because it gave me a build error.

> diff --git a/hw/nvme/nmi-i2c.c b/hw/nvme/nmi-i2c.c
> new file mode 100644
> index 000000000000..81738f185bba
> --- /dev/null
> +++ b/hw/nvme/nmi-i2c.c
> @@ -0,0 +1,382 @@
...

> +static void nmi_handle_mi_config_get(NMIDevice *nmi, NMIRequest *request)
> +{
> +    uint32_t dw0 = le32_to_cpu(request->dw0);
> +    uint8_t identifier = dw0 & 0xff;
> +    uint8_t *buf;
> +
> +    trace_nmi_handle_mi_config_get(identifier);
> +
> +    switch (identifier) {
> +    case NMI_CMD_CONFIGURATION_GET_SMBUS_FREQ:
> +        buf = (uint8_t[]) {
> +            0x0, 0x1, 0x0, 0x0,
> +        };
> +
> +        break;
> +
> +    case NMI_CMD_CONFIGURATION_GET_HEALTH_STATUS_CHANGE:
> +        buf = (uint8_t[]) {
> +            0x0, 0x0, 0x0, 0x0,
> +        };
> +
> +        break;
> +
> +    case NMI_CMD_CONFIGURATION_GET_MCTP_TRANSMISSION_UNIT:
> +        buf = (uint8_t[]) {
> +            0x0, 0x40, 0x0, 0x0,
> +        };
> +
> +        break;

No default, which gave me a build error as buf is uninitialized.

> +    }
> +
> +    memcpy(nmi->scratch + nmi->pos, buf, 4);
> +    nmi->pos += 4;
> +}
> +
> +enum {
> +    NMI_CMD_READ_NMI_DS         = 0x0,
> +    NMI_CMD_CONFIGURATION_GET   = 0x4,
> +};
> +


> +static size_t nmi_get_message_types(MCTPI2CEndpoint *mctp, uint8_t *data,
> +                                    size_t maxlen)
> +{
> +    uint8_t buf[] = {
> +        0x0, 0x1, 0x4,

PLDM?  Are you using that so far?  Maybe keep it for when you
add PLDM support?

> +    };
> +
> +    memcpy(data, buf, sizeof(buf));
> +
> +    return sizeof(buf);
> +}


