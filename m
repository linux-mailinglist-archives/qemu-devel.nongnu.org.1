Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D26A7D0360
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 22:50:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtZxt-0002gx-MV; Thu, 19 Oct 2023 16:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qtZxp-0002fQ-R6
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 16:49:53 -0400
Received: from 3.mo552.mail-out.ovh.net ([178.33.254.192])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qtZxn-0004sv-6U
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 16:49:53 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.124])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 171E32C550;
 Thu, 19 Oct 2023 20:49:39 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 19 Oct
 2023 22:49:37 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S004e4e44197-2c7d-41ce-abad-59af31aa2463,
 40A84FA1BFAB306571EA24E7D640879C68C08F1A) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Thu, 19 Oct 2023 22:49:35 +0200
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
Message-ID: <20231019224935.03232495@bahia>
In-Reply-To: <20231019190831.20363-8-quintela@redhat.com>
References: <20231019190831.20363-1-quintela@redhat.com>
 <20231019190831.20363-8-quintela@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: b8ab38fa-49a4-4d46-b91e-e57b645b5a28
X-Ovh-Tracer-Id: 10836223656682035575
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeigdduhedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejfedtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnheptefffeehgfegueetteeghfeufffhveeuudegtdefieeftdehveegvdduhfeggefgnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrdduuddtpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehgrhhouhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepqhhuihhnthgvlhgrsehrvgguhhgrthdrtghomhdpuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruhdpmhhsthesrhgvughhrghtrdgtohhmpdhpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdpthhhuhhthhesrhgvughhrghtrdgtohhmpdhlvghosghrrghssehrvgguhhgrthdrtghomhdpmhhinhihrghrugesrggtmhdrohhrghdpjhgrshhofigrnhhgsehrvgguhhgrthdrtghomhdpqhgvmhhuqdgrrhhmsehnoh
 hnghhnuhdrohhrghdpshifseifvghilhhnvghtiidruggvpdhmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdgsohhrnhhtrhgrvghgvghrsehlihhnuhigrdhisghmrdgtohhmpdhmrghrkhdrtggrvhgvqdgrhihlrghnugesihhlrghnuggvrdgtohdruhhkpdhqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhjshhnohifsehrvgguhhgrthdrtghomhdpphgrshhitgeslhhinhhugidrihgsmhdrtghomhdphhgrrhhshhhpsgeslhhinhhugidrihgsmhdrtghomhdpfhgrrhhmrghnsehlihhnuhigrdhisghmrdgtohhmpdhfrghrohhsrghssehsuhhsvgdruggvpdhiihhisehlihhnuhigrdhisghmrdgtohhmpdgurghvihgusehrvgguhhgrthdrtghomhdprhhitghhrghrugdrhhgvnhguvghrshhonheslhhinhgrrhhordhorhhgpdhsrghmuhgvlhdrthhhihgsrghulhhtsegvnhhsqdhlhihonhdrohhrghdptghmihhnhigrrhgusehmvhhishhtrgdrtghomhdpkhhrrgigvghlsehrvgguhhgrthdrtghomhdpqhgvmhhuqdhsfeeltdigsehnohhnghhnuhdrohhrghdpnhhpihhgghhinhesghhmrghilhdrtghomhdpqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrghdpmhgrrhgtvghlrdgrphhfvghlsggruhhmsehgmhgrihhlrdgtohhmpdhsthgvfhgrnhgssehlihhnuhigrdhvnhgvthdrihgsmhdrtghomhdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpphgvthgvrhi
 gsehrvgguhhgrthdrtghomhdpuggrnhhivghlhhgsgedufeesghhmrghilhdrtghomhdpoffvtefjohhsthepmhhoheehvddpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=178.33.254.192; envelope-from=groug@kaod.org;
 helo=3.mo552.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Juan,

On Thu, 19 Oct 2023 21:08:25 +0200
Juan Quintela <quintela@redhat.com> wrote:

> Current code does:
> - register pre_2_10_vmstate_dummy_icp with "icp/server" and instance
>   dependinfg on cpu number
> - for newer machines, it register vmstate_icp with "icp/server" name
>   and instance 0
> - now it unregisters "icp/server" for the 1st instance.
> 

Heh I remember about this hack... it was caused by some rework in
the interrupt controller that broke migration.

> This is wrong at many levels:
> - we shouldn't have two VMSTATEDescriptions with the same name

I don't know how bad it is. The idea here is to send extra
state in the stream because older QEMU expect it (but won't use
it), so it made sense to keep the same name.

> - In case this is the only solution that we can came with, it needs to
>   be:
>   * register pre_2_10_vmstate_dummy_icp
>   * unregister pre_2_10_vmstate_dummy_icp
>   * register real vmstate_icp
> 
> As the initialization of this machine is already complex enough, I
> need help from PPC maintainers to fix this.
> 

What about dropping all this code, i.e. basically reverting 46f7afa37096 ("spapr:
fix migration of ICPState objects from/to older QEMU") ?

Unless we still care to migrate pseries machine types from 2017 of
course...

> Volunteers?
> 

Not working on PPC anymore since almost two years, I certainly don't have time,
nor motivation to fix this. I might be able to answer some questions or to
review someone else's patch that gets rid of the offending code, at best.

Cheers,

--
Greg


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



-- 
Greg

