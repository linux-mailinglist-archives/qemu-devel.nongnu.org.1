Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF520710AE7
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:29:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q299z-00030M-Bp; Thu, 25 May 2023 07:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q299s-0002zb-Hh; Thu, 25 May 2023 07:29:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q299k-0001BS-KV; Thu, 25 May 2023 07:29:28 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QRm4l5l75z67GF9;
 Thu, 25 May 2023 19:27:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 25 May
 2023 12:29:16 +0100
Date: Thu, 25 May 2023 12:29:15 +0100
To: Klaus Jensen <its@irrelevant.dk>
CC: <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>, Jeremy Kerr
 <jk@codeconstruct.com.au>, <qemu-arm@nongnu.org>, Peter Delevoryas
 <peter@pjd.dev>, Keith Busch <kbusch@kernel.org>, "=?ISO-8859-1?Q?C=E9dric?=
 Le Goater" <clg@kaod.org>, Jason Wang <jasowang@redhat.com>, Lior Weintraub
 <liorw@pliops.com>, <qemu-block@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Matt Johnston <matt@codeconstruct.com.au>, Klaus
 Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v2 2/3] i2c/mctp: Allow receiving messages to dest eid 0
Message-ID: <20230525122915.00001493@Huawei.com>
In-Reply-To: <20230425063540.46143-3-its@irrelevant.dk>
References: <20230425063540.46143-1-its@irrelevant.dk>
 <20230425063540.46143-3-its@irrelevant.dk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Tue, 25 Apr 2023 08:35:39 +0200
Klaus Jensen <its@irrelevant.dk> wrote:

> From: Matt Johnston <matt@codeconstruct.com.au>
> 
> The Null Destination ID, 0, is used for MCTP control messages when
> addressing by physical ID. That is used for Get Endpoint ID and
> Set Endpoint ID when querying/assigning an EID to an endpoint.
> 
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
Seems to work though maybe just squash into previous and add
a note to thank Matt for the fix?

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  hw/i2c/mctp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i2c/mctp.c b/hw/i2c/mctp.c
> index 0f4045d0d685..db42dc72264b 100644
> --- a/hw/i2c/mctp.c
> +++ b/hw/i2c/mctp.c
> @@ -242,7 +242,8 @@ static int i2c_mctp_event_cb(I2CSlave *i2c, enum i2c_event event)
>              goto drop;
>          }
>  
> -        if (pkt->mctp.hdr.eid.dest != mctp->my_eid) {
> +        if (!(pkt->mctp.hdr.eid.dest == mctp->my_eid ||
> +              pkt->mctp.hdr.eid.dest == 0)) {
>              trace_i2c_mctp_drop_invalid_eid(pkt->mctp.hdr.eid.dest,
>                                              mctp->my_eid);
>              goto drop;


