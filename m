Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 255CA789CDA
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 12:00:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaCYI-0001Lm-Un; Sun, 27 Aug 2023 05:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qaCYH-0001LO-25
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 05:59:25 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qaCYE-0004NQ-CN
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 05:59:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31aeedbb264so2035700f8f.0
 for <qemu-devel@nongnu.org>; Sun, 27 Aug 2023 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693130360; x=1693735160;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEV7brxMh/aoI3eqF094b6xXLfjbC3NPicbnj5kT/2U=;
 b=KTXWPCxbY/PoIdrDfvRwadgbsCujh33wEwnzEB6ZgYi/s5lK9qHx/m6mu10hEgWv8w
 v47ZhRFFHXdiAIhtYnOLXbiBpeo/f0PlD2EUp0Ya36aVGr7tgzDXrlQ0sllNkaSHPTEW
 JH/c5otFwhR4mI9g1v6xq9BzE2UOfF4y+YzL/yd5qrCjMPPUSb6GZmgqI0ktjNFpjsvR
 DeINXZ363D1eQAwJUCdfXy5p1/1NUWPL2NivIoEJNqhAD5kHDnXDlfNfFRVypr/Tzl7s
 VgIZfmBnkFbrghROU40FPZCTVaWypaYtU7fR4KkmUZ2TMs/MzGhcGxjjLu5aOpkL8Zvr
 ZzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693130360; x=1693735160;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pEV7brxMh/aoI3eqF094b6xXLfjbC3NPicbnj5kT/2U=;
 b=avuKNxKNTiQBJMD00JsVOT52KKR8d4ELGwDCqf1jgfVbGzRCb/EgHBHeQZaX6t8Wup
 6BMhcdrkmtz9mEu3lTQ/h8SitN9CSZWbuFhzTvKq/ogWK3LoaiVgo4xon2/2BNsSR+r7
 qID8l8V4vPmt624MPPj9nQXd4T0I2A25/T/qA49OiXajR/AEQoZywXehIy+pqOYO2lRW
 7mMPfwf5qK9kstNUamwc/HpIEjGdyAxsdP9qcJq/2Xhlko/P6cl0gG57E7SqLAhCaeL8
 eypuoP5NpkOtm/2HylFSgXccKeWuZ1+aFF+4yOA8BXAxqLddof8qLV5wPrGCL441b+YS
 +m+Q==
X-Gm-Message-State: AOJu0YyyyzytOjzIojuPSmU3nkSBddbRGh37CNExVHMwpVb4elBxWiiu
 qb1KjwyfTU1gTVtkPEtmhIFPwA==
X-Google-Smtp-Source: AGHT+IFWpWwt63LQ83Gs7FCttwD4R8TtRQDowzpDozQEVKAA69CuY/oXK6OccQOM4fBta3b+64QW0g==
X-Received: by 2002:adf:f30d:0:b0:317:3c89:7f03 with SMTP id
 i13-20020adff30d000000b003173c897f03mr17609254wro.5.1693130360295; 
 Sun, 27 Aug 2023 02:59:20 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o21-20020a05600c379500b003ff3b964a9asm10597520wmr.39.2023.08.27.02.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Aug 2023 02:59:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 80CD91FFBB;
 Sun, 27 Aug 2023 10:59:19 +0100 (BST)
References: <20230826232415.80233-1-richard.henderson@linaro.org>
 <20230826232415.80233-3-richard.henderson@linaro.org>
User-agent: mu4e 1.11.15; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH 2/3] softmmu: Use async_run_on_cpu in tcg_commit
Date: Sun, 27 Aug 2023 10:58:19 +0100
In-reply-to: <20230826232415.80233-3-richard.henderson@linaro.org>
Message-ID: <87wmxg4xhk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


Richard Henderson <richard.henderson@linaro.org> writes:

> After system startup, run the update to memory_dispatch
> and the tlb_flush on the cpu.  This eliminates a race,
> wherein a running cpu sees the memory_dispatch change
> but has not yet seen the tlb_flush.
>
> Since the update now happens on the cpu, we need not use
> qatomic_rcu_read to protect the read of memory_dispatch.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1826
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1834
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1846
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  softmmu/physmem.c | 40 +++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 7597dc1c39..18277ddd67 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -680,8 +680,7 @@ address_space_translate_for_iotlb(CPUState *cpu, int =
asidx, hwaddr orig_addr,
>      IOMMUTLBEntry iotlb;
>      int iommu_idx;
>      hwaddr addr =3D orig_addr;
> -    AddressSpaceDispatch *d =3D
> -        qatomic_rcu_read(&cpu->cpu_ases[asidx].memory_dispatch);
> +    AddressSpaceDispatch *d =3D cpu->cpu_ases[asidx].memory_dispatch;
>=20=20
>      for (;;) {
>          section =3D address_space_translate_internal(d, addr, &addr, ple=
n, false);
> @@ -2412,7 +2411,7 @@ MemoryRegionSection *iotlb_to_section(CPUState *cpu,
>  {
>      int asidx =3D cpu_asidx_from_attrs(cpu, attrs);
>      CPUAddressSpace *cpuas =3D &cpu->cpu_ases[asidx];
> -    AddressSpaceDispatch *d =3D qatomic_rcu_read(&cpuas->memory_dispatch=
);
> +    AddressSpaceDispatch *d =3D cpuas->memory_dispatch;
>      int section_index =3D index & ~TARGET_PAGE_MASK;
>      MemoryRegionSection *ret;
>=20=20
> @@ -2487,23 +2486,42 @@ static void tcg_log_global_after_sync(MemoryListe=
ner *listener)
>      }
>  }
>=20=20
> +static void tcg_commit_cpu(CPUState *cpu, run_on_cpu_data data)
> +{
> +    CPUAddressSpace *cpuas =3D data.host_ptr;
> +
> +    cpuas->memory_dispatch =3D address_space_to_dispatch(cpuas->as);
> +    tlb_flush(cpu);
> +}
> +
>  static void tcg_commit(MemoryListener *listener)
>  {
>      CPUAddressSpace *cpuas;
> -    AddressSpaceDispatch *d;
> +    CPUState *cpu;
>=20=20
>      assert(tcg_enabled());
>      /* since each CPU stores ram addresses in its TLB cache, we must
>         reset the modified entries */
>      cpuas =3D container_of(listener, CPUAddressSpace, tcg_as_listener);
> -    cpu_reloading_memory_map();
> -    /* The CPU and TLB are protected by the iothread lock.
> -     * We reload the dispatch pointer now because cpu_reloading_memory_m=
ap()
> -     * may have split the RCU critical section.
> +    cpu =3D cpuas->cpu;
> +
> +    /*
> +     * Defer changes to as->memory_dispatch until the cpu is quiescent.
> +     * Otherwise we race between (1) other cpu threads and (2) ongoing
> +     * i/o for the current cpu thread, with data cached by mmu_lookup().
> +     *
> +     * In addition, queueing the work function will kick the cpu back to
> +     * the main loop, which will end the RCU critical section and reclaim
> +     * the memory data structures.
> +     *
> +     * That said, the listener is also called during realize, before
> +     * all of the tcg machinery for run-on is initialized: thus halt_con=
d.
>       */
> -    d =3D address_space_to_dispatch(cpuas->as);
> -    qatomic_rcu_set(&cpuas->memory_dispatch, d);
> -    tlb_flush(cpuas->cpu);
> +    if (cpu->halt_cond) {
> +        async_run_on_cpu(cpu, tcg_commit_cpu, RUN_ON_CPU_HOST_PTR(cpuas)=
);
> +    } else {
> +        tcg_commit_cpu(cpu, RUN_ON_CPU_HOST_PTR(cpuas));
> +    }
>  }
>=20=20
>  static void memory_map_init(void)


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

