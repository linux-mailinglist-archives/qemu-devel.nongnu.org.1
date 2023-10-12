Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 850107C69D0
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 11:40:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqsA1-000261-15; Thu, 12 Oct 2023 05:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farrah.chen@intel.com>)
 id 1qqs9y-00025q-Q9
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 05:39:14 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farrah.chen@intel.com>)
 id 1qqs9v-0008Mu-KD
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 05:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697103551; x=1728639551;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1I2Yptz1x42hFQSbl3nrdY0ORgKDqT5ajb09pQty3jg=;
 b=AuzZZRDMzxqgqBPrq+fdvNgjctPMG/5kJFMunJx2opDOhBiIb62NwMpn
 RqUrfS3bV8tVl30wBapnZcJVFzg15GI6ToKmeeIteJN+G0pGnKZ7xgcPj
 5Ih3vaiauIG/oeze2N3vKoTm2WocaGNR5rA6rD3KTd133C03e8XKOh6rJ
 EIiVNL9UH0JvWYVRax8LpQrOtBNHxKrrV+njFBvBUVdMTqCCOQ5h3ZZxJ
 XWV3rqQXctR3gSweI65lJZShDrO2dChFC59n5ezydVqXlOQZP44jdxe03
 IPSB/MDEd03cev/n6B3qK2H5zh5ASFTeLYlH9QmjTGUW2+SJqXDIgMEHU Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="388740053"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; d="scan'208";a="388740053"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 02:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="747820893"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; d="scan'208";a="747820893"
Received: from emr-120485.sh.intel.com ([10.112.230.86])
 by orsmga007.jf.intel.com with ESMTP; 12 Oct 2023 02:39:04 -0700
From: Farrah Chen <farrah.chen@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: mtosatti@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 farrah.chen@intel.com
Subject: Re: [PATCH] targer/i386/cpu: Fix CPUID_HT exposure
Date: Thu, 12 Oct 2023 17:39:08 +0800
Message-Id: <ZSe84OlMUgCKkevt@emr-120485.sh.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231010060539.210258-1-xiaoyao.li@intel.com>
References: <20231010060539.210258-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=farrah.chen@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2023-10-10 at 02:05:39 -0400, Xiaoyao Li wrote:
> When explicitly booting a multiple vcpus vm with "-cpu +ht", it gets
> warning of
>=20
>   warning: host doesn't support requested feature: CPUID.01H:EDX.ht [bit =
28]
>=20
> Make CPUID_HT as supported unconditionally can resolve the warning.
> However it introduces another issue that it also expose CPUID_HT to
> guest when "-cpu host/max" with only 1 vcpu. To fix this, need mark
> CPUID_HT as the no_autoenable_flags.
>=20
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c     | 1 +
>  target/i386/kvm/kvm.c | 2 ++
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index cec5d2b7b65e..32c077455f04 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -778,6 +778,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] =3D {
>          },
>          .cpuid =3D {.eax =3D 1, .reg =3D R_EDX, },
>          .tcg_features =3D TCG_FEATURES,
> +        .no_autoenable_flags =3D CPUID_HT,
>      },
>      [FEAT_1_ECX] =3D {
>          .type =3D CPUID_FEATURE_WORD,
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index f6c7f7e26869..ab72bcdfad13 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -373,6 +373,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, ui=
nt32_t function,
>      if (function =3D=3D 1 && reg =3D=3D R_EDX) {
>          /* KVM before 2.6.30 misreports the following features */
>          ret |=3D CPUID_MTRR | CPUID_PAT | CPUID_MCE | CPUID_MCA;
> +        /* KVM never reports CPUID_HT but QEMU can support when vcpus > =
1 */
> +        ret |=3D CPUID_HT;
>      } else if (function =3D=3D 1 && reg =3D=3D R_ECX) {
>          /* We can set the hypervisor flag, even if KVM does not return i=
t on
>           * GET_SUPPORTED_CPUID

Tested-by: Farrah Chen <farrah.chen@intel.com>

>=20
> base-commit: cea3ea670fe265421131aad90c36fbb87bc4d206
> --=20
> 2.34.1
>=20
>=20

