Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC37741019
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:31:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETOT-0003Ji-63; Wed, 28 Jun 2023 07:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bacchus@kaod.org>) id 1qETOM-0003Ht-7B
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:31:23 -0400
Received: from 2.mo548.mail-out.ovh.net ([178.33.255.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bacchus@kaod.org>) id 1qETOJ-0007gI-0G
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:31:21 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.243])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 0774D22123;
 Wed, 28 Jun 2023 11:31:08 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG1EX2.mxp5.local (172.16.2.2)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Jun
 2023 13:31:07 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G0040818923a-32b9-4dc8-b9d0-dce4e9fd8d71,
 ECA248B0662CCBC5FD2A863FA940125219941A6B) smtp.auth=bacchus@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b34d64df-36fc-fd55-ce1f-7a72ba96ef07@kaod.org>
Date: Wed, 28 Jun 2023 13:31:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] net/vhost-net: do not assert on null pointer return from
 tap_get_vhost_net()
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
CC: <peter.maydell@linaro.org>, <lvivier@redhat.com>, <clg@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20230628112804.36676-1-anisinha@redhat.com>
From: Bacchus <bacchus@kaod.org>
In-Reply-To: <20230628112804.36676-1-anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG1EX2.mxp5.local
 (172.16.2.2)
X-Ovh-Tracer-GUID: 641de568-b73d-4c28-aa58-aaaa0f882b69
X-Ovh-Tracer-Id: 1872090072230768233
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgdegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeeurggttghhuhhsuceosggrtggthhhusheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpefhteeuuedvkedtueekieeigeeukeelvedufeeukeffhfelteejkeegtddvlefhvdenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtuddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegsrggttghhuhhssehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheprghnihhsihhnhhgrsehrvgguhhgrthdrtghomhdpmhhsthesrhgvughhrghtrdgtohhmpdhjrghsohifrghnghesrhgvughhrghtrdgtohhmpdhpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdplhhvihhvihgvrhesrhgvughhrghtrdgtohhmpdgtlhhgsehrvgguhhgrthdrtghomhdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhoheegkedpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=178.33.255.19; envelope-from=bacchus@kaod.org;
 helo=2.mo548.mail-out.ovh.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.089,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/28/23 13:28, Ani Sinha wrote:
> When 'vhost=off' or no vhost specific options at all are passed for the tap
> net-device backend, tap_get_vhost_net() can return NULL. The function
> net_init_tap_one() does not call vhost_net_init() on such cases and therefore
> vhost_net pointer within the tap device state structure remains NULL. Hence,
> assertion here on a NULL pointer return from tap_get_vhost_net() would not be
> correct. Remove it and fix the crash generated by qemu upon initialization in
> the following call chain :
> 
> qdev_realize() -> pci_qdev_realize() -> virtio_device_realize() ->
> virtio_bus_device_plugged() -> virtio_net_get_features() -> get_vhost_net()
> 
> fixes: 0e994668d00c9c ("vhost_net: add an assertion for TAP client backends")
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>

Thanks !

C.


> ---
>   hw/net/vhost_net.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 6db23ca323..6b958d6363 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -507,7 +507,12 @@ VHostNetState *get_vhost_net(NetClientState *nc)
>       switch (nc->info->type) {
>       case NET_CLIENT_DRIVER_TAP:
>           vhost_net = tap_get_vhost_net(nc);
> -        assert(vhost_net);
> +        /*
> +         * tap_get_vhost_net() can return NULL if a tap net-device backend is
> +         * created with 'vhost=off' option, 'vhostforce=off' or no vhost or
> +         * vhostforce or vhostfd options at all. Please see net_init_tap_one().
> +         * Hence, we omit the assertion here.
> +         */
>           break;
>   #ifdef CONFIG_VHOST_NET_USER
>       case NET_CLIENT_DRIVER_VHOST_USER:


