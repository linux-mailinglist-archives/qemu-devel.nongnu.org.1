Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A6E7D0420
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:41:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtakX-0003b0-3U; Thu, 19 Oct 2023 17:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qtakV-0003Yg-Fk
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:40:11 -0400
Received: from 6.mo548.mail-out.ovh.net ([188.165.58.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qtakQ-0008QT-GH
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:40:11 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.250])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id A5679203E7;
 Thu, 19 Oct 2023 21:40:00 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 19 Oct
 2023 23:39:59 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006070d8609-c87f-452f-983d-aa90b36fabe4,
 40A84FA1BFAB306571EA24E7D640879C68C08F1A) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Thu, 19 Oct 2023 23:39:58 +0200
From: Greg Kurz <groug@kaod.org>
To: Juan Quintela <quintela@redhat.com>
CC: <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, <qemu-ppc@nongnu.org>,
 Nicholas Piggin <npiggin@gmail.com>, <qemu-s390x@nongnu.org>, Gerd Hoffmann
 <kraxel@redhat.com>, Corey Minyard <cminyard@mvista.com>, Samuel Thibault
 <samuel.thibault@ens-lyon.org>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>, "Ilya
 Leoshkevich" <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>, "Eric
 Farman" <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>, "Harsh Prateek
 Bora" <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 <qemu-block@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, =?UTF-8?B?TWFyYy1BbmRy?=
 =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>, Stefan Weil
 <sw@weilnetz.de>, <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Corey Minyard <minyard@acm.org>, Leonardo Bras <leobras@redhat.com>, "Thomas
 Huth" <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael
 S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Halil Pasic
 <pasic@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 07/13] RFC migration: icp/server is a mess
Message-ID: <20231019233958.17abb488@bahia>
In-Reply-To: <20231019190831.20363-8-quintela@redhat.com>
References: <20231019190831.20363-1-quintela@redhat.com>
 <20231019190831.20363-8-quintela@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 788fb555-ab1a-435b-9d14-6f76b08a239c
X-Ovh-Tracer-Id: 11686841037111007607
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjeejgddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejtdevgeekieelffdvtedvvdegtdduudeigffhhffgvdfhgeejteekheefkeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtiedpkeekrddujeelrdelrdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoghhrohhugheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehquhhinhhtvghlrgesrhgvughhrghtrdgtohhmpdgurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghupdhmshhtsehrvgguhhgrthdrtghomhdpphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhthhhuthhhsehrvgguhhgrthdrtghomhdplhgvohgsrhgrshesrhgvughhrghtrdgtohhmpdhmihhnhigrrhgusegrtghmrdhorhhgpdhjrghsohifrghnghesrhgvughhrghtrdgtohhmpdhqvghmuhdqrghrmhesnhhonh
 hgnhhurdhorhhgpdhsfiesfigvihhlnhgvthiirdguvgdpmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhhgrthdrtghomhdpsghorhhnthhrrggvghgvrheslhhinhhugidrihgsmhdrtghomhdpmhgrrhhkrdgtrghvvgdqrgihlhgrnhgusehilhgrnhguvgdrtghordhukhdpqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdpjhhsnhhofiesrhgvughhrghtrdgtohhmpdhprghsihgtsehlihhnuhigrdhisghmrdgtohhmpdhhrghrshhhphgssehlihhnuhigrdhisghmrdgtohhmpdhfrghrmhgrnheslhhinhhugidrihgsmhdrtghomhdpfhgrrhhoshgrshesshhushgvrdguvgdpihhiiheslhhinhhugidrihgsmhdrtghomhdpuggrvhhiugesrhgvughhrghtrdgtohhmpdhrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhrghdpshgrmhhuvghlrdhthhhisggruhhlthesvghnshdqlhihohhnrdhorhhgpdgtmhhinhihrghrugesmhhvihhsthgrrdgtohhmpdhkrhgrgigvlhesrhgvughhrghtrdgtohhmpdhqvghmuhdqshefledtgiesnhhonhhgnhhurdhorhhgpdhnphhighhgihhnsehgmhgrihhlrdgtohhmpdhqvghmuhdqphhptgesnhhonhhgnhhurdhorhhgpdhmrghrtggvlhdrrghpfhgvlhgsrghumhesghhmrghilhdrtghomhdpshhtvghfrghnsgeslhhinhhugidrvhhnvghtrdhisghmrdgtohhmpdhqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhpvghtvghrgie
 srhgvughhrghtrdgtohhmpdgurghnihgvlhhhsgegudefsehgmhgrihhlrdgtohhmpdfovfetjfhoshhtpehmohehgeekpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=188.165.58.48; envelope-from=groug@kaod.org;
 helo=6.mo548.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 19 Oct 2023 21:08:25 +0200
Juan Quintela <quintela@redhat.com> wrote:

> Current code does:
> - register pre_2_10_vmstate_dummy_icp with "icp/server" and instance
>   dependinfg on cpu number
> - for newer machines, it register vmstate_icp with "icp/server" name
>   and instance 0
> - now it unregisters "icp/server" for the 1st instance.
> 
> This is wrong at many levels:
> - we shouldn't have two VMSTATEDescriptions with the same name
> - In case this is the only solution that we can came with, it needs to
>   be:
>   * register pre_2_10_vmstate_dummy_icp
>   * unregister pre_2_10_vmstate_dummy_icp
>   * register real vmstate_icp
> 
> As the initialization of this machine is already complex enough, I
> need help from PPC maintainers to fix this.
> 
> Volunteers?
> 
> CC: Cedric Le Goater <clg@kaod.org>
> CC: Daniel Henrique Barboza <danielhb413@gmail.com>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Greg Kurz <groug@kaod.org>
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/ppc/spapr.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cb840676d3..8531d13492 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -143,7 +143,12 @@ static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
>  }
>  
>  static const VMStateDescription pre_2_10_vmstate_dummy_icp = {
> -    .name = "icp/server",
> +    /*
> +     * Hack ahead.  We can't have two devices with the same name and
> +     * instance id.  So I rename this to pass make check.
> +     * Real help from people who knows the hardware is needed.
> +     */
> +    .name = "pre-2.10-icp/server",
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .needed = pre_2_10_vmstate_dummy_icp_needed,

I guess this fix is acceptable as well and a lot simpler than
reverting the hack actually. Outcome is the same : drop
compat with pseries-2.9 and older.

Reviewed-by: Greg Kurz <groug@kaod.org>

-- 
Greg

