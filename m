Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB687413D8
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:34:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEWEA-0002He-96; Wed, 28 Jun 2023 10:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qEWE8-0002Gm-5Z
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:33:00 -0400
Received: from 2.mo548.mail-out.ovh.net ([178.33.255.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qEWE0-0003gD-IL
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:32:56 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.141])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 95CB421DFA;
 Wed, 28 Jun 2023 14:32:48 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Jun
 2023 16:32:47 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R00251fd099f-a3b2-4094-a20f-9957b0343cc3,
 BB93B6AC372DD556F16E72057DB7D6FCEC78780F) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Wed, 28 Jun 2023 16:32:44 +0200
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, "=?UTF-8?B?Q8OpZHJpYw==?= Le
 Goater" <clg@kaod.org>, <qemu-ppc@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>, <kvm@vger.kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>
Subject: Re: [PATCH v3 2/6] target/ppc: Reorder #ifdef'ry in kvm_ppc.h
Message-ID: <20230628163244.089c45a2@bahia>
In-Reply-To: <20230627115124.19632-3-philmd@linaro.org>
References: <20230627115124.19632-1-philmd@linaro.org>
 <20230627115124.19632-3-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 078596cc-cc74-4e51-b0a3-166a44172237
X-Ovh-Tracer-Id: 4940448794191501615
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeuueeijedtleeluedthfetjeffieetffeuvefffeeftedvieefueejgfdugeetueenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleekpdejkedrudeljedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehgrhhouhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruhdpuggrnhhivghlhhgsgedufeesghhmrghilhdrtghomhdpqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrghdpphgsohhniihinhhisehrvgguhhgrthdrtghomhdpkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpnhhpihhgghhinhesghhmrghilhdrtghomhdptghlgh
 eskhgrohgurdhorhhgpdfovfetjfhoshhtpehmohehgeekpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=178.33.255.19; envelope-from=groug@kaod.org;
 helo=2.mo548.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Tue, 27 Jun 2023 13:51:20 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Keep a single if/else/endif block checking CONFIG_KVM.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/ppc/kvm_ppc.h | 62 ++++++++++++++++++++------------------------
>  1 file changed, 28 insertions(+), 34 deletions(-)
>=20
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 2e395416f0..49954a300b 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -93,7 +93,34 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t=
 tb_offset);
> =20
>  int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run);
> =20
> -#else
> +#define kvmppc_eieio() \
> +    do {                                          \
> +        if (kvm_enabled()) {                          \
> +            asm volatile("eieio" : : : "memory"); \
> +        } \
> +    } while (0)
> +
> +/* Store data cache blocks back to memory */
> +static inline void kvmppc_dcbst_range(PowerPCCPU *cpu, uint8_t *addr, in=
t len)
> +{
> +    uint8_t *p;
> +
> +    for (p =3D addr; p < addr + len; p +=3D cpu->env.dcache_line_size) {
> +        asm volatile("dcbst 0,%0" : : "r"(p) : "memory");
> +    }
> +}
> +
> +/* Invalidate instruction cache blocks */
> +static inline void kvmppc_icbi_range(PowerPCCPU *cpu, uint8_t *addr, int=
 len)
> +{
> +    uint8_t *p;
> +
> +    for (p =3D addr; p < addr + len; p +=3D cpu->env.icache_line_size) {
> +        asm volatile("icbi 0,%0" : : "r"(p));
> +    }
> +}
> +
> +#else /* !CONFIG_KVM */
> =20
>  static inline uint32_t kvmppc_get_tbfreq(void)
>  {
> @@ -440,10 +467,6 @@ static inline bool kvmppc_pvr_workaround_required(Po=
werPCCPU *cpu)
>      return false;
>  }
> =20
> -#endif
> -
> -#ifndef CONFIG_KVM
> -
>  #define kvmppc_eieio() do { } while (0)
> =20
>  static inline void kvmppc_dcbst_range(PowerPCCPU *cpu, uint8_t *addr, in=
t len)
> @@ -454,35 +477,6 @@ static inline void kvmppc_icbi_range(PowerPCCPU *cpu=
, uint8_t *addr, int len)
>  {
>  }
> =20
> -#else   /* CONFIG_KVM */
> -
> -#define kvmppc_eieio() \

Arguably the kvm and non-kvm implementations will now come from
different commits in git blame. I personally favor keeping the
git blame consistency over bare code movement that doesn't fix
any actual bug.

Also this patch doesn't seem to be strictly needed to reach the
goal of kicking "kvm_ppc.h" out of user emulation.

> -    do {                                          \
> -        if (kvm_enabled()) {                          \
> -            asm volatile("eieio" : : : "memory"); \
> -        } \
> -    } while (0)
> -
> -/* Store data cache blocks back to memory */
> -static inline void kvmppc_dcbst_range(PowerPCCPU *cpu, uint8_t *addr, in=
t len)
> -{
> -    uint8_t *p;
> -
> -    for (p =3D addr; p < addr + len; p +=3D cpu->env.dcache_line_size) {
> -        asm volatile("dcbst 0,%0" : : "r"(p) : "memory");
> -    }
> -}
> -
> -/* Invalidate instruction cache blocks */
> -static inline void kvmppc_icbi_range(PowerPCCPU *cpu, uint8_t *addr, int=
 len)
> -{
> -    uint8_t *p;
> -
> -    for (p =3D addr; p < addr + len; p +=3D cpu->env.icache_line_size) {
> -        asm volatile("icbi 0,%0" : : "r"(p));
> -    }
> -}
> -
>  #endif  /* CONFIG_KVM */
> =20
>  #endif /* KVM_PPC_H */



--=20
Greg

