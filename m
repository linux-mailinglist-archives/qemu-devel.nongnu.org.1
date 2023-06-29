Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF9074206D
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 08:37:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qElGq-0006PZ-Ji; Thu, 29 Jun 2023 02:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qElGo-0006PE-8L
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 02:36:46 -0400
Received: from 9.mo548.mail-out.ovh.net ([46.105.48.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qElGm-0000D1-J5
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 02:36:45 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.17])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id A5E232223A;
 Thu, 29 Jun 2023 06:36:41 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Jun
 2023 08:36:41 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G0044fe8cc28-ee85-49e8-8059-ec83b0f83da7,
 3572DC45CCAD587926D7956B888079DA14C9F13E) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Thu, 29 Jun 2023 08:36:33 +0200
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, "=?UTF-8?B?Q8OpZHJpYw==?= Le
 Goater" <clg@kaod.org>, <qemu-ppc@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>, <kvm@vger.kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>
Subject: Re: [PATCH v3 5/6] target/ppc: Restrict 'kvm_ppc.h' to sysemu in
 cpu_init.c
Message-ID: <20230629083633.7e48cedd@bahia>
In-Reply-To: <20230627115124.19632-6-philmd@linaro.org>
References: <20230627115124.19632-1-philmd@linaro.org>
 <20230627115124.19632-6-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: a29bf055-2cb6-44d9-ae14-a11cb6e9bab9
X-Ovh-Tracer-Id: 2772247049428441391
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrtdefgdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepueeuieejtdelleeutdfhteejffeiteffueevffeffeetvdeifeeujefgudegteeunecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutddupdejkedrudeljedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehgrhhouhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruhdpuggrnhhivghlhhgsgedufeesghhmrghilhdrtghomhdpqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrghdpphgsohhniihinhhisehrvgguhhgrthdrtghomhdpkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpnhhpihhgghhinhesghhmrghilhdrtghomhdptg
 hlgheskhgrohgurdhorhhgpdfovfetjfhoshhtpehmohehgeekpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=46.105.48.137; envelope-from=groug@kaod.org;
 helo=9.mo548.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Tue, 27 Jun 2023 13:51:23 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> User emulation shouldn't need any of the KVM prototypes
> declared in "kvm_ppc.h".
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/cpu_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index aeff71d063..f2afb539eb 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -21,7 +21,6 @@
>  #include "qemu/osdep.h"
>  #include "disas/dis-asm.h"
>  #include "gdbstub/helpers.h"
> -#include "kvm_ppc.h"
>  #include "sysemu/cpus.h"
>  #include "sysemu/hw_accel.h"
>  #include "sysemu/tcg.h"
> @@ -49,6 +48,7 @@
>  #ifndef CONFIG_USER_ONLY
>  #include "hw/boards.h"
>  #include "hw/intc/intc.h"
> +#include "kvm_ppc.h"
>  #endif
> =20
>  /* #define PPC_DEBUG_SPR */



--=20
Greg

