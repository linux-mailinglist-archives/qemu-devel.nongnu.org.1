Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 633CC7E1B8D
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:55:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzuQH-0007xa-JD; Mon, 06 Nov 2023 02:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qzuQB-0007xH-Pd
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:53:20 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qzuQA-0003o7-7J
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:53:19 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.128])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 48AE920365;
 Mon,  6 Nov 2023 07:53:07 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 6 Nov
 2023 08:53:06 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R00621b0714a-0b6f-49ae-baa3-d73507d54f05,
 210A19B55432F04E894651E454F511AC748DDD6E) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Mon, 6 Nov 2023 08:53:03 +0100
From: Greg Kurz <groug@kaod.org>
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, <quintela@redhat.com>, <peterx@redhat.com>,
 <farosas@suse.de>, <leobras@redhat.com>
Subject: Re: [PATCH 20/71] hw/9pfs: Constify VMState
Message-ID: <20231106085303.3a309407@bahia>
In-Reply-To: <20231106065827.543129-21-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-21-richard.henderson@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 1f73c948-7cb8-4a8d-92eb-eb0688e6311f
X-Ovh-Tracer-Id: 11196793099747825958
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddufedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejtdevgeekieelffdvtedvvdegtdduudeigffhhffgvdfhgeejteekheefkeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtiedpkeekrddujeelrdelrdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoghhrohhugheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpqhhuihhnthgvlhgrsehrvgguhhgrthdrtghomhdpphgvthgvrhigsehrvgguhhgrthdrtghomhdpfhgrrhhoshgrshesshhushgvrdguvgdplhgvohgsrhgrshesrhgvughhrghtrdgtohhmpdfovfetjfhoshhtpehmohehvdelpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Sun,  5 Nov 2023 22:57:36 -0800
Richard Henderson <richard.henderson@linaro.org> wrote:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Acked-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/virtio-9p-device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 5f522e68e9..efa41cfd73 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -237,7 +237,7 @@ static const VMStateDescription vmstate_virtio_9p = {
>      .name = "virtio-9p",
>      .minimum_version_id = 1,
>      .version_id = 1,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_VIRTIO_DEVICE,
>          VMSTATE_END_OF_LIST()
>      },



-- 
Greg

