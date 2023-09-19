Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A865D7A6397
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 14:47:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qia7z-0005kS-6k; Tue, 19 Sep 2023 08:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qia7u-0005k5-BR
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qia7s-0003Ye-K6
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695127607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2v+vXlSq95ZgkF13KcJ6vVR52coEcPm2Fm8xNjMAt8=;
 b=BamN2ovGB/xoVvW6h2NWBd5Wj+NTyhsWJWYThkHiIoP0CT85mq8kIks6RHpEtmbW3YyTIB
 l5iW50roML2UCDGeYPAJeUPg5xzXCjBSLpbg/NOxa8heUsGQX2rCsyrjU/K+WnW781oV5L
 +ih1ZOlE9IzXNoX3GyF3pSr8ZA62MjQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-C_NRNtbTMO66FQuVrpV_OQ-1; Tue, 19 Sep 2023 08:46:36 -0400
X-MC-Unique: C_NRNtbTMO66FQuVrpV_OQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9ad73eb9668so991879966b.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 05:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695127594; x=1695732394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u2v+vXlSq95ZgkF13KcJ6vVR52coEcPm2Fm8xNjMAt8=;
 b=i3OLefDt56lxRRrrnxrPmdm6CJUt93K69crVZAvynlFTIxUqwQrVUnFOQdq4Hvyxf9
 Gzn15IiLLkQbnz7nj01ZlUfTc6YRqfhY6p+4rsMHSatVosIAicD6gbyR7R9RpLI909wO
 ZWAFcdv32OfA+iXeT/bz8h4GqXkliCS5/eRYHTPGzAWBEP1QyNo04jUWl0YphsJc311L
 EF+WfRy826bqgS6UFzRyuJoV5Wpu6uoS268lhlmLTXp2iR2mbSFwEbk7rr27nU/vPp+t
 IMKioMc7eI1/kUl71Y68Ag0BYLPyQLp559C4tdMYGwY70kG1mmMk7BOX0A2G8rg3dD+W
 m/iA==
X-Gm-Message-State: AOJu0Yya6L0wNCDRAXDXS2AkrSjnIfTARZs/vgTPpI6ndY6etaAEPffi
 RCYFFwFvTfGzVYNG7tw4y9iEQJvcT0xpTTaGNM3JsKQQ6dZVxyfUkCvDBJLuXaBJy0aXRFSIML6
 2b+MJT5GVrlOSwICzXgKjg3gRPyqiWF/keEO7YaM=
X-Received: by 2002:a17:907:7e90:b0:9ad:87df:4126 with SMTP id
 qb16-20020a1709077e9000b009ad87df4126mr3353823ejc.1.1695127594704; 
 Tue, 19 Sep 2023 05:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFyGI7H38I7He/mlmjjowDm4Tl0ffBZ/6cPhytp6X+wVTuu47uDW2gf3l8B3vz0iLY3mbmmqUfG6iHxd19JZI=
X-Received: by 2002:a17:907:7e90:b0:9ad:87df:4126 with SMTP id
 qb16-20020a1709077e9000b009ad87df4126mr3353802ejc.1.1695127594393; Tue, 19
 Sep 2023 05:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230919103838.249317-1-anisinha@redhat.com>
 <CAK3XEhPqRTjSCuvsUHkdfH+1Yi=5TPREB3VWA0Chr+c_jdTiKQ@mail.gmail.com>
 <ba34ed0a-96a1-2563-425c-1642b031459f@redhat.com>
In-Reply-To: <ba34ed0a-96a1-2563-425c-1642b031459f@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 19 Sep 2023 18:16:22 +0530
Message-ID: <CAK3XEhNH_g4tXg+VS-BaxOumtg9ig-59eKzhn_xLiY9ZCFSzJQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/i386/pc: improve physical address space bound check
 for 32-bit systems
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, philmd@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 19, 2023 at 6:10=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 19.09.23 13:52, Ani Sinha wrote:
> > On Tue, Sep 19, 2023 at 4:08=E2=80=AFPM Ani Sinha <anisinha@redhat.com>=
 wrote:
> >>
> >> 32-bit systems do not have a reserved memory for hole64 and memory hot=
plug is
> >> not supported on those systems. Therefore, the maximum limit of the gu=
est
> >> physical address coincides with the end of "above 4G memory space" reg=
ion.
> >> Make sure that the end of "above 4G memory" is still addressible by th=
e
> >> guest processor with its available address bits. For example, previous=
ly this
> >> was allowed:
> >>
> >> $ ./qemu-system-x86_64 -cpu pentium -m size=3D10G
> >>
> >> Now it is no longer allowed:
> >>
> >> $ ./qemu-system-x86_64 -cpu pentium -m size=3D10G
> >> qemu-system-x86_64: Address space limit 0xffffffff < 0x2bfffffff phys-=
bits too low (32)
> >>
> >> After calling CPUID with EAX=3D0x80000001, all AMD64 compliant process=
ors
> >> have the longmode-capable-bit turned on in the extended feature flags =
(bit 29)
> >> in EDX. The absence of CPUID longmode can be used to differentiate bet=
ween
> >> 32-bit and 64-bit processors and is the recommended approach. QEMU tak=
es this
> >> approach elsewhere (for example, please see x86_cpu_realizefn()) and w=
ith
> >> this change, pc_max_used_gpa() also takes the same approach to detect =
32-bit
> >> processors.
> >>
> >> Finally, a new compatibility flag is introduced to retain the old beha=
vior
> >> for pc_max_used_gpa() for macines 8.1 and older.
> > typo - will fix in v3                   ^^^^^^^^
> >
> > btw, does this patch break it for processors < 32-bit? For them clearly
> >
> > x86ms->above_4g_mem_start =3D 4 * GiB;
> >
> > does not work.
> >
> >
> >>
> >> Suggested-by: David Hildenbrand <david@redhat.com>
> >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >> ---
> >>   hw/i386/pc.c         | 17 ++++++++++++++---
> >>   hw/i386/pc_piix.c    |  4 ++++
> >>   include/hw/i386/pc.h |  3 +++
> >>   3 files changed, 21 insertions(+), 3 deletions(-)
> >>
> >> changelog:
> >> v2: removed memory hotplug region from max_gpa. added compat knobs.
> >>
> >> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >> index 54838c0c41..fea97ee258 100644
> >> --- a/hw/i386/pc.c
> >> +++ b/hw/i386/pc.c
> >> @@ -907,10 +907,20 @@ static uint64_t pc_get_cxl_range_end(PCMachineSt=
ate *pcms)
> >>   static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hol=
e64_size)
> >>   {
> >>       X86CPU *cpu =3D X86_CPU(first_cpu);
> >> +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> >>
> >> -    /* 32-bit systems don't have hole64 thus return max CPU address *=
/
> >> -    if (cpu->phys_bits <=3D 32) {
> >> -        return ((hwaddr)1 << cpu->phys_bits) - 1;
> >> +    /*
> >> +     * 32-bit systems don't have hole64 and does not support
> >> +     * memory hotplug.
> >> +     */
> >> +    if (pcmc->fixed_32bit_mem_addr_check) {
> >> +        if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM))=
 {
> >> +            return pc_above_4g_end(pcms) - 1;
> >> +        }
>
> I think you should use the logic from v1.
>
> My comment regarding memory hotplug was primarily about (Linux) guest
> support.
>
> We should not optimize for 32bit processors (e.g., try placing the
> device memory region below 4g), but you can still consider the region
> and properly account it.

I am confused. So maybe you can send a patch.


