Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A2F74206C
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 08:37:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qElGW-0006IY-Jk; Thu, 29 Jun 2023 02:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1qElGO-0006IF-TU; Thu, 29 Jun 2023 02:36:22 -0400
Received: from smtpout2.mo529.mail-out.ovh.net ([79.137.123.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1qElGM-000081-Bq; Thu, 29 Jun 2023 02:36:20 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.141])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 7734720B29;
 Thu, 29 Jun 2023 06:36:13 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Jun
 2023 08:36:12 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002bc5539fe-ec9e-4790-8209-e60a71a887e4,
 3572DC45CCAD587926D7956B888079DA14C9F13E) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Thu, 29 Jun 2023 08:36:11 +0200
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, "=?UTF-8?B?Q8OpZHJpYw==?= Le
 Goater" <clg@kaod.org>, <qemu-ppc@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>, <kvm@vger.kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>
Subject: Re: [PATCH v3 4/6] target/ppc: Define TYPE_HOST_POWERPC_CPU in
 cpu-qom.h
Message-ID: <20230629083611.3ba82988@bahia>
In-Reply-To: <20230627115124.19632-5-philmd@linaro.org>
References: <20230627115124.19632-1-philmd@linaro.org>
 <20230627115124.19632-5-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: e29b3c8e-1a4e-4c65-a97d-5e7d78dff95b
X-Ovh-Tracer-Id: 2764365747181230383
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrtdefgdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepueeuieejtdelleeutdfhteejffeiteffueevffeffeetvdeifeeujefgudegteeunecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrdeljedpjeekrdduleejrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoghhrohhugheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdgurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghupdgurghnihgvlhhhsgegudefsehgmhgrihhlrdgtohhmpdhqvghmuhdqphhptgesnhhonhhgnhhurdhorhhgpdhpsghonhiiihhnihesrhgvughhrghtrdgtohhmpdhkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhnphhighhgihhnsehgmhgrihhlrdgtohhmpdgtlh
 hgsehkrghougdrohhrghdpoffvtefjohhsthepmhhohedvledpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout2.mo529.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 27 Jun 2023 13:51:22 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> TYPE_HOST_POWERPC_CPU is used in various places of cpu_init.c,
> in order to restrict "kvm_ppc.h" to sysemu, move this QOM-related
> definition to cpu-qom.h.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/cpu-qom.h | 2 ++
>  target/ppc/kvm_ppc.h | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index c2bff349cc..4e4061068e 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -36,6 +36,8 @@ OBJECT_DECLARE_CPU_TYPE(PowerPCCPU, PowerPCCPUClass, PO=
WERPC_CPU)
>  #define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
>  #define cpu_list ppc_cpu_list
> =20
> +#define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
> +
>  ObjectClass *ppc_cpu_class_by_name(const char *name);
> =20
>  typedef struct CPUArchState CPUPPCState;
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 49954a300b..901e188c9a 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -13,8 +13,6 @@
>  #include "exec/hwaddr.h"
>  #include "cpu.h"
> =20
> -#define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
> -
>  #ifdef CONFIG_KVM
> =20
>  uint32_t kvmppc_get_tbfreq(void);



--=20
Greg

