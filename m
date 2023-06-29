Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1774E742070
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 08:37:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qElHV-0007cN-2t; Thu, 29 Jun 2023 02:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qElHS-0007YL-5a
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 02:37:26 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qElHQ-0000Hi-1A
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 02:37:25 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.235])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 057EB20C31;
 Thu, 29 Jun 2023 06:37:21 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Jun
 2023 08:37:20 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004c370ffe2-ae87-4a34-8a0f-ef655ed00a39,
 3572DC45CCAD587926D7956B888079DA14C9F13E) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Thu, 29 Jun 2023 08:37:19 +0200
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, "=?UTF-8?B?Q8OpZHJpYw==?= Le
 Goater" <clg@kaod.org>, <qemu-ppc@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>, <kvm@vger.kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>
Subject: Re: [PATCH v3 6/6] target/ppc: Remove pointless checks of
 CONFIG_USER_ONLY in 'kvm_ppc.h'
Message-ID: <20230629083719.783058ee@bahia>
In-Reply-To: <20230627115124.19632-7-philmd@linaro.org>
References: <20230627115124.19632-1-philmd@linaro.org>
 <20230627115124.19632-7-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 9e90e5d8-24f6-4ae1-a5ec-92a5b968bee2
X-Ovh-Tracer-Id: 2783224573549713711
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrtdefgdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepueeuieejtdelleeutdfhteejffeiteffueevffeffeetvdeifeeujefgudegteeunecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutddupdejkedrudeljedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehgrhhouhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruhdpuggrnhhivghlhhgsgedufeesghhmrghilhdrtghomhdpqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrghdpphgsohhniihinhhisehrvgguhhgrthdrtghomhdpkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpnhhpihhgghhinhesghhmrghilhdrtghomhdptg
 hlgheskhgrohgurdhorhhgpdfovfetjfhoshhtpehmohehvdelpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 27 Jun 2023 13:51:24 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/kvm_ppc.h | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 901e188c9a..6a4dd9c560 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -42,7 +42,6 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
>  target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
>                                       bool radix, bool gtse,
>                                       uint64_t proc_tbl);
> -#ifndef CONFIG_USER_ONLY
>  bool kvmppc_spapr_use_multitce(void);
>  int kvmppc_spapr_enable_inkernel_multitce(void);
>  void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
> @@ -52,7 +51,6 @@ int kvmppc_remove_spapr_tce(void *table, int pfd, uint3=
2_t window_size);
>  int kvmppc_reset_htab(int shift_hint);
>  uint64_t kvmppc_vrma_limit(unsigned int hash_shift);
>  bool kvmppc_has_cap_spapr_vfio(void);
> -#endif /* !CONFIG_USER_ONLY */
>  bool kvmppc_has_cap_epr(void);
>  int kvmppc_define_rtas_kernel_token(uint32_t token, const char *function=
);
>  int kvmppc_get_htab_fd(bool write, uint64_t index, Error **errp);
> @@ -262,7 +260,6 @@ static inline void kvmppc_set_reg_tb_offset(PowerPCCP=
U *cpu, int64_t tb_offset)
>  {
>  }
> =20
> -#ifndef CONFIG_USER_ONLY
>  static inline bool kvmppc_spapr_use_multitce(void)
>  {
>      return false;
> @@ -322,8 +319,6 @@ static inline void kvmppc_write_hpte(hwaddr ptex, uin=
t64_t pte0, uint64_t pte1)
>      abort();
>  }
> =20
> -#endif /* !CONFIG_USER_ONLY */
> -
>  static inline bool kvmppc_has_cap_epr(void)
>  {
>      return false;



--=20
Greg

