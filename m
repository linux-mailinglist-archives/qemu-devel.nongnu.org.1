Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3472B7A2230
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:21:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhAbk-0001H1-SR; Fri, 15 Sep 2023 11:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qhAbh-0001GJ-U9; Fri, 15 Sep 2023 11:19:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qhAbf-000409-8C; Fri, 15 Sep 2023 11:19:45 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnHsG37mmz6K6CB;
 Fri, 15 Sep 2023 23:18:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 15 Sep
 2023 16:19:38 +0100
Date: Fri, 15 Sep 2023 16:19:37 +0100
To: Alistair Francis <alistair23@gmail.com>
CC: <lukas@wunner.de>, <wilfred.mallawa@wdc.com>, <jiewen.yao@intel.com>,
 <qemu-devel@nongnu.org>, <kbusch@kernel.org>, <its@irrelevant.dk>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <hchkuo@avery-design.com.tw>, 
 <cbrowy@avery-design.com>, <qemu-block@nongnu.org>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: Re: [PATCH 2/3] backends: Initial support for SPDM socket support
Message-ID: <20230915161937.00005da0@Huawei.com>
In-Reply-To: <20230915112723.2033330-2-alistair.francis@wdc.com>
References: <20230915112723.2033330-1-alistair.francis@wdc.com>
 <20230915112723.2033330-2-alistair.francis@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Fri, 15 Sep 2023 21:27:22 +1000
Alistair Francis <alistair23@gmail.com> wrote:

> From: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>

Great to see you taking this forwards!


> 
> SPDM enables authentication, attestation and key exchange to assist in
> providing infrastructure security enablement. It's a standard published
> by the DMTF [1].
> 
> SPDM currently supports PCIe DOE and MCTP transports, but it can be
> extended to support others in the future. This patch adds
> support to QEMU to connect to an external SPDM instance.

It supports way more that that these days.  I'd just say 'multiple'
transports.

> 
> SPDM support can be added to any QEMU device by exposing a
> TCP socket to a SPDM server. The server can then implement the SPDM
> decoding/encoding support, generally using libspdm [2].
> 
> This is similar to how the current TPM implementation works and means
> that the heavy lifting of setting up certificate chains, capabilities,
> measurements and complex crypto can be done outside QEMU by a well
> supported and tested library.

Is this sufficient for usecases beyond initial attestation flows?
How does measurement work for example?  We need settings from the
emulated device to squirt into the SPDM agent so that it can be
encrypted and signed etc.

Measurement reports often need to include the status of various config
space registers + any device specific additional stuff - not sure
what is defined for NVME but I suspect the list will grow, particularly
when tdisp is included.  There are some things called out in the PCIe
state as must haves, like any debug features must be reported.
Also we need a way to mess with firmware revisions reported
as those are likely to be checked.

I'm not sure that model will work with the spdm-emu approach.

Anyhow, I think we need to have gotten a little further figuring that
out before we merge a solution.  I've been carrying this on the CXL
staging tree for a long time because I couldn't figure out a good solution
to the amount of information that needs to go between them.

For those not familiar with the fun of libSPDM it is a pain to work with
which is why Huai-Cheng instead connected with the demo app.

Any more luck getting a reliable build to work?

> 
> 1: https://www.dmtf.org/standards/SPDM
> 2: https://github.com/DMTF/libspdm
> 
> Signed-off-by: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> Signed-off-by: Chris Browy <cbrowy@avery-design.com>
> Co-developed-by: Jonathan Cameron <Jonathan.cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> [ Changes by AF:
>  - Convert to be more QEMU-ified
>  - Move to backends as it isn't PCIe specific
> ]
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Alistair, you sent this so I think your sign off should be last
+ some indication of Wilfred's involvement would be good?
Probably another Co-developed-by



> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---

I've looked at this code too much in the past to give much
real review.  Still a few comments inline.
I'm very keen to get a solution to this upstream, though I think
we do need to discuss a few general points (no cover letter so I'll
do it here).


...

> diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
> new file mode 100644
> index 0000000000..2f31ba80ba
> --- /dev/null
> +++ b/backends/spdm-socket.c
> @@ -0,0 +1,215 @@


> +
> +int spdm_socket_connect(uint16_t port, Error **errp)
> +{
> +    int client_socket;
> +    struct sockaddr_in server_addr;
> +
> +    client_socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> +    if (client_socket < 0) {
> +        error_setg(errp, "cannot create socket: %s", strerror(errno));
> +        return -1;
> +    }
> +
> +    memset((char *)&server_addr, 0, sizeof(server_addr));
> +    server_addr.sin_family = AF_INET;
> +    server_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
> +    server_addr.sin_port = htons(port);
> +
> +
> +    if (connect(client_socket, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
Wrap the line.

> +        error_setg(errp, "cannot connect: %s", strerror(errno));
> +        close(client_socket);
> +        return -1;
> +    }
> +
> +    return client_socket;
> +}



