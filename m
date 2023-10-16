Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9480F7CAE6B
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:03:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQ0a-0002fE-1m; Mon, 16 Oct 2023 11:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qsQ0V-0002dG-CY
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:59:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qsQ0S-0002CC-SI
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:59:51 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8MFM4b1Lz6K6SZ;
 Mon, 16 Oct 2023 23:57:27 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 16 Oct
 2023 16:59:44 +0100
Date: Mon, 16 Oct 2023 16:59:43 +0100
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
 <mst@redhat.com>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Gregory Price <gregory.price@memverge.com>, "Klaus
 Jensen" <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>, "Klaus
 Jensen" <k.jensen@samsung.com>
Subject: Re: [PATCH 03/19] hw/cxl/mbox: Pull the CCI definition out of the
 CXLDeviceState
Message-ID: <20231016165943.000067f7@huawei.com>
In-Reply-To: <20230925161124.18940-4-Jonathan.Cameron@huawei.com>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
 <20230925161124.18940-4-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 25 Sep 2023 17:11:08 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Enables having multiple CCIs per devices. Each CCI (mailbox) has it's own
> state and command list, so they can't share a single structure.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

I made a mess of reordering patches, so some of Davidlohr's BG ops
patch ended up in this one and the next patch. I'll put that back
where it should be in v2.

>  
> +typedef struct CXLCCI {
> +    const struct cxl_cmd (*cxl_cmd_set)[256];
> +    struct cel_log {
> +        uint16_t opcode;
> +        uint16_t effect;
> +    } cel_log[1 << 16];
> +    size_t cel_size;
> +
> +    /* background command handling (times in ms) */
> +    struct {
> +        uint16_t opcode;
> +        uint16_t complete_pct;
> +        uint16_t ret_code; /* Current value of retcode */
> +        uint64_t starttime;
> +        /* set by each bg cmd, cleared by the bg_timer when complete */
> +        uint64_t runtime;
> +        QEMUTimer *timer;
> +    } bg;
We don't have bg ops yet!

> +    size_t payload_max;
> +    /* Pointer to device hosting the CCI */
> +    DeviceState *d;
> +    /* Pointer to the device hosting the protocol conversion */
> +    DeviceState *intf;
> +} CXLCCI;
> +

