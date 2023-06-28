Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEA6741489
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:06:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEWjl-0004km-Mj; Wed, 28 Jun 2023 11:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1qEWjj-0004k2-Oa; Wed, 28 Jun 2023 11:05:39 -0400
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1qEWjh-00030j-P7; Wed, 28 Jun 2023 11:05:39 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.2])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 11F1020DA8;
 Wed, 28 Jun 2023 15:05:33 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Jun
 2023 17:05:32 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0020e5ded94-c5c7-4954-a50f-3f051277f602,
 BB93B6AC372DD556F16E72057DB7D6FCEC78780F) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Wed, 28 Jun 2023 17:05:31 +0200
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, "=?UTF-8?B?Q8OpZHJpYw==?= Le
 Goater" <clg@kaod.org>, <qemu-ppc@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>, <kvm@vger.kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>
Subject: Re: [PATCH v3 3/6] target/ppc: Move CPU QOM definitions to cpu-qom.h
Message-ID: <20230628170531.09d2e648@bahia>
In-Reply-To: <20230627115124.19632-4-philmd@linaro.org>
References: <20230627115124.19632-1-philmd@linaro.org>
 <20230627115124.19632-4-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: a03afced-7f07-4827-bdb3-3c1eddfc4e27
X-Ovh-Tracer-Id: 5493265648697710895
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeuueeijedtleeluedthfetjeffieetffeuvefffeeftedvieefueejgfdugeetueenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleejpdejkedrudeljedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehgrhhouhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruhdpuggrnhhivghlhhgsgedufeesghhmrghilhdrtghomhdpqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrghdpphgsohhniihinhhisehrvgguhhgrthdrtghomhdpkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpnhhpihhgghhinhesghhmrghilhdrtghomhdptghlgh
 eskhgrohgurdhorhhgpdfovfetjfhoshhtpehmohehvdelpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=46.105.54.81; envelope-from=groug@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
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

On Tue, 27 Jun 2023 13:51:21 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/ppc/cpu-qom.h | 5 +++++
>  target/ppc/cpu.h     | 6 ------
>  2 files changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 9666f54f65..c2bff349cc 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -31,6 +31,11 @@
> =20
>  OBJECT_DECLARE_CPU_TYPE(PowerPCCPU, PowerPCCPUClass, POWERPC_CPU)
> =20
> +#define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
> +#define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
> +#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
> +#define cpu_list ppc_cpu_list
> +
>  ObjectClass *ppc_cpu_class_by_name(const char *name);
> =20
>  typedef struct CPUArchState CPUPPCState;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index af12c93ebc..e91e1774e5 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1468,12 +1468,6 @@ static inline uint64_t ppc_dump_gpr(CPUPPCState *e=
nv, int gprn)
>  int ppc_dcr_read(ppc_dcr_t *dcr_env, int dcrn, uint32_t *valp);
>  int ppc_dcr_write(ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
> =20
> -#define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
> -#define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
> -#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
> -

These seem appropriate to be moved to "cpu-qom.h".

> -#define cpu_list ppc_cpu_list

This one is much older according to git blame :

c913706581460 target/ppc/cpu.h (Igor Mammedov                 2017-08-30 14=
69) #define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
c913706581460 target/ppc/cpu.h (Igor Mammedov                 2017-08-30 14=
70) #define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
0dacec874fa3b target/ppc/cpu.h (Igor Mammedov                 2018-02-07 14=
71) #define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
c913706581460 target/ppc/cpu.h (Igor Mammedov                 2017-08-30 14=
72)=20
c732abe222795 target-ppc/cpu.h (Jocelyn Mayer                 2007-10-12 14=
73) #define cpu_list ppc_cpu_list

It is some plumbing used for `-cpu help`, not exactly QOM stuff.
Maybe keep it in "cpu.h" as all other targets do ?

> -
>  /* MMU modes definitions */
>  #define MMU_USER_IDX 0
>  static inline int cpu_mmu_index(CPUPPCState *env, bool ifetch)



--=20
Greg

