Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70972808408
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 10:15:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBASq-0004qx-1e; Thu, 07 Dec 2023 04:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rBASn-0004qk-5W
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 04:14:33 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rBASl-0007Dw-D5
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 04:14:32 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6d7fa93afe9so429645a34.2
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 01:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701940470; x=1702545270; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UGjQCd7LVQJ0VtFzIdDdhxzodi3g57d9KV1C6E0+n8=;
 b=WOLc+VKoRDTex8bR9RFvvAcxenbAgATjiOL1ce0mo9spE7vDV4lgsneIAjqO9jvF7i
 HQCB5zO6esRZ085KD7j5eMnmb0wwhOn3YAzUfIj0HcCGC9caHWoLSUDiV1YHQa828Lhs
 8TYOtECBFbbriV367JiLBOCWar8Sg6g4+X4kdH555yMTryz05F0D7sTdAu9w30YXmS0U
 vZSDHOdYSJokbNI3oNALnXcGR3I/0qAfzwWkMxk/ZNmnLxloQ9f9MJTaupEAPJa6Km1A
 7qVW3dJnl7xmu8pM+bhaq1zn4i7klweuTK9cTYDAXIGR/Mqtb0qqv1s6PT3cV5UKM215
 uFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701940470; x=1702545270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4UGjQCd7LVQJ0VtFzIdDdhxzodi3g57d9KV1C6E0+n8=;
 b=kX3bsbHT51Dtgiv7Dhok+FH880229lMROqNfu9AghznBL0uj70rSMo/0DitiVwv6sk
 R4OiZM4XSlTpMQ1nQNaxTFByNhMiiKJD65c4n4Mxk91dbHrWwmd/89Mvn2XxWITucaeF
 ppA4WsXlylwPwrFPALnpoJrw6zEqTVOVRk01hohViA+ezmbqZwBTU5Ho52hZyUhqcDUq
 l3gEW4+W9u/4zInw9csO7O0G6pWQJSG1g2UnzysOnmrZmezYR5hq3WFzpv0S8QmrAV3U
 RX+/YPii/AzRu45sCoJ5+4oLrFD0bqWUnWUMUpabxzBpynhUy5aYy58e8WttBPSjUJRu
 PBMA==
X-Gm-Message-State: AOJu0YwC3G2jKb/kb4bdlxva/yd5jaNS51tIIumWMpBgtZL7g/dShTLk
 xzX3UYJEde6k16E0bUMzijaCFv0RtKYZ9vX7ylI=
X-Google-Smtp-Source: AGHT+IFMAgiw3M79ejSrDddrDQo7MF/CVWsVF5aT0rrGGbQnV8/fVx1NkazPHxw78qtagcKmLyS3kLb5SA3+IsDAzw4=
X-Received: by 2002:a05:6870:3047:b0:1fb:75a:c436 with SMTP id
 u7-20020a056870304700b001fb075ac436mr2173231oau.95.1701940469762; Thu, 07 Dec
 2023 01:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20231206155821.1194551-1-michael.roth@amd.com>
In-Reply-To: <20231206155821.1194551-1-michael.roth@amd.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 7 Dec 2023 04:14:17 -0500
Message-ID: <CAJSP0QUnqJPTL2W9xknEW7Er0SWCcK1kxST1fCvedmqsics_VA@mail.gmail.com>
Subject: Re: [PATCH v3 for-8.2] i386/sev: Avoid SEV-ES crash due to missing
 MSR_EFER_LMA bit
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Lara Lazier <laramglazier@gmail.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 6 Dec 2023 at 10:59, Michael Roth <michael.roth@amd.com> wrote:
>
> Commit 7191f24c7fcf ("accel/kvm/kvm-all: Handle register access errors")
> added error checking for KVM_SET_SREGS/KVM_SET_SREGS2. In doing so, it
> exposed a long-running bug in current KVM support for SEV-ES where the
> kernel assumes that MSR_EFER_LMA will be set explicitly by the guest
> kernel, in which case EFER write traps would result in KVM eventually
> seeing MSR_EFER_LMA get set and recording it in such a way that it would
> be subsequently visible when accessing it via KVM_GET_SREGS/etc.
>
> However, guest kernels currently rely on MSR_EFER_LMA getting set
> automatically when MSR_EFER_LME is set and paging is enabled via
> CR0_PG_MASK. As a result, the EFER write traps don't actually expose the
> MSR_EFER_LMA bit, even though it is set internally, and when QEMU
> subsequently tries to pass this EFER value back to KVM via
> KVM_SET_SREGS* it will fail various sanity checks and return -EINVAL,
> which is now considered fatal due to the aforementioned QEMU commit.
>
> This can be addressed by inferring the MSR_EFER_LMA bit being set when
> paging is enabled and MSR_EFER_LME is set, and synthesizing it to ensure
> the expected bits are all present in subsequent handling on the host
> side.
>
> Ultimately, this handling will be implemented in the host kernel, but to
> avoid breaking QEMU's SEV-ES support when using older host kernels, the
> same handling can be done in QEMU just after fetching the register
> values via KVM_GET_SREGS*. Implement that here.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Lara Lazier <laramglazier@gmail.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Cc: kvm@vger.kernel.org
> Fixes: 7191f24c7fcf ("accel/kvm/kvm-all: Handle register access errors")
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  target/i386/kvm/kvm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks!

Stefan

>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 11b8177eff..4ce80555b4 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -3643,6 +3643,10 @@ static int kvm_get_sregs(X86CPU *cpu)
>      env->cr[4] =3D sregs.cr4;
>
>      env->efer =3D sregs.efer;
> +    if (sev_es_enabled() && env->efer & MSR_EFER_LME &&
> +        env->cr[0] & CR0_PG_MASK) {
> +        env->efer |=3D MSR_EFER_LMA;
> +    }
>
>      /* changes to apic base and cr8/tpr are read back via kvm_arch_post_=
run */
>      x86_update_hflags(env);
> @@ -3682,6 +3686,10 @@ static int kvm_get_sregs2(X86CPU *cpu)
>      env->cr[4] =3D sregs.cr4;
>
>      env->efer =3D sregs.efer;
> +    if (sev_es_enabled() && env->efer & MSR_EFER_LME &&
> +        env->cr[0] & CR0_PG_MASK) {
> +        env->efer |=3D MSR_EFER_LMA;
> +    }
>
>      env->pdptrs_valid =3D sregs.flags & KVM_SREGS2_FLAGS_PDPTRS_VALID;
>
> --
> 2.25.1
>
>

