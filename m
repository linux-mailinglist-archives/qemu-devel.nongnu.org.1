Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EE4AD6FC1
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Jun 2025 14:09:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPghe-0003xW-Vb; Thu, 12 Jun 2025 08:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uPgfE-0003Wc-Lj
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 08:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uPgf9-0003EZ-QS
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 08:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749729843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VXQXv5GWA/KTHpWL70FokWZ/X1l7pl5rkDK1qK3hSaw=;
 b=fu5pwB1D6Cr0G8cA3uq2JcBz4zxJF6cn0KHTiJy0+drqGtXaCAYnAZm04B/6xwcNcop3A1
 uyFzZ2Wwnz0IznqqSgE1zYmGOXi/KnSMGJd+suczdVRaLDT2tGg/AXl1WueJQ8RTwyc4sK
 bfPLEoIXWuAfmEXXrvtE1osGSWs2MlU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-atpWSt34MfmpDz7zCUm9Zw-1; Thu, 12 Jun 2025 08:04:01 -0400
X-MC-Unique: atpWSt34MfmpDz7zCUm9Zw-1
X-Mimecast-MFC-AGG-ID: atpWSt34MfmpDz7zCUm9Zw_1749729841
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-31315427249so1054952a91.1
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 05:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749729841; x=1750334641;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VXQXv5GWA/KTHpWL70FokWZ/X1l7pl5rkDK1qK3hSaw=;
 b=D2jt6o7McFcM0HQTPN0qSKVXucm2LlektNMmwctJk4bBLN/VMUw6wNApWduOLXCcTz
 6a1JtJiDVx+sGPJSKHtIZyU78oHu9LueOmvRuKvRN+sYxBulZ7sEFuB4tyFwIlr1k/Tb
 fRaX7h67DKc+TBl1SBKs8UUL7gehtYob4wFV7j1WCp1n6IM3od0R8JznfQoux45PRp4G
 aseSfD5h00FTqFgkDDLKWaVaGhRxHgZpVMpKVm5K63UxFgJkF+BhzXPH1ZOxucB/ekK6
 MGJsQEGBACzc73+KZFvGNsxGIJptcE2Tg1eGm9ARR0TlfOwFq3vKqeBuKDzM1BER1BHx
 pu1A==
X-Gm-Message-State: AOJu0Yxb17laKhjSq0xODvE6/8gDVW1pJzKs2E6c0Pz4F7qHO7MSret9
 Ms0h7D2Vzv1/K2Bv7u3lIP7fg+hqVLAYllStLmvQRXMFbrPCjhjkLqSL/CEpNPgU0Zemas5fYD5
 lMN6N7Hnb1fi31rnstybOR2gJuWyxdij2z1u17WDl/o1iT2eEQAUBJ6BU
X-Gm-Gg: ASbGncsRR+bZStRLoaeMT3P+hCON9dPqlF4UhNCHzxSy3f18hxI2ye0NMuNX/oqjp+M
 s5dyfpYdWitglulD3H44mvZD0jIqRAbB7o7XRsXUQ9lPtYyOQozSLSDWHzIOL0YZSTTbbJKBWgV
 ZuV6lgG5aKOkhvhDq5rne2XIc4Q62jNgnJuc3h1tzIbZGhmMc/zFnpVdZlMpZvIX8jaV4YqB8Wb
 3heRFwVRWEF/32e0Okh962XqjmTHKejXt0EgqFq89QvDK6TiVxCwrZmarKbolQsz8SL2rzJ+/XG
 kU/Aeyc16uecnpCyQ9qBp1uwjtsu/4n1bz39SA==
X-Received: by 2002:a17:90b:3fc5:b0:2fe:85f0:e115 with SMTP id
 98e67ed59e1d1-313af2035camr7716292a91.26.1749729840821; 
 Thu, 12 Jun 2025 05:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2JstazmYPfI51Wyt0ATLT4l9lT/2JBL0cVggZf1ljpJhG00BZh6+vCsuXCjuwdvNj4MK7HQ==
X-Received: by 2002:a17:90b:3fc5:b0:2fe:85f0:e115 with SMTP id
 98e67ed59e1d1-313af2035camr7716045a91.26.1749729836600; 
 Thu, 12 Jun 2025 05:03:56 -0700 (PDT)
Received: from smtpclient.apple ([122.163.100.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-313c19b771esm1287076a91.9.2025.06.12.05.03.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Jun 2025 05:03:56 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.4\))
Subject: Re: [PATCH v7 08/16] i386/sev: Refactor setting of reset vector and
 initial CPU state
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <b43aa3fa.AUoAAGOlyUYAAAAAAAAAA9cBm3AAAYKJZwAAAAAAAC5ATwBnwHdy@mailjet.com>
Date: Thu, 12 Jun 2025 17:33:38 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Berrange <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Joerg Roedel <jroedel@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CBF546AD-51DD-467C-B338-642AF5D915A6@redhat.com>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
 <b43aa3fa.AUoAAGOlyUYAAAAAAAAAA9cBm3AAAYKJZwAAAAAAAC5ATwBnwHdy@mailjet.com>
To: Roy Hopkins <roy.hopkins@randomman.co.uk>
X-Mailer: Apple Mail (2.3776.700.51.11.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



> On 27 Feb 2025, at 7:59=E2=80=AFPM, Roy Hopkins =
<roy.hopkins@randomman.co.uk> wrote:
>=20
> When an SEV guest is started, the reset vector and state are
> extracted from metadata that is contained in the firmware volume.
>=20
> In preparation for using IGVM to setup the initial CPU state,
> the code has been refactored to populate vmcb_save_area for each
> CPU which is then applied during guest startup and CPU reset.
>=20
> Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>

I am not sure if I am responding to the latest version of this patch =
series, but ...

> ---
> target/i386/sev.c | 323 +++++++++++++++++++++++++++++++++++++++++-----
> target/i386/sev.h | 110 ++++++++++++++++
> 2 files changed, 400 insertions(+), 33 deletions(-)
>=20
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 7d91985f41..1d1e36e3de 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -49,6 +49,12 @@ OBJECT_DECLARE_TYPE(SevSnpGuestState, =
SevCommonStateClass, SEV_SNP_GUEST)
> /* hard code sha256 digest size */
> #define HASH_SIZE 32
>=20
> +/* Convert between SEV-ES VMSA and SegmentCache flags/attributes */
> +#define FLAGS_VMSA_TO_SEGCACHE(flags) \
> +    ((((flags) & 0xff00) << 12) | (((flags) & 0xff) << 8))
> +#define FLAGS_SEGCACHE_TO_VMSA(flags) \
> +    ((((flags) & 0xff00) >> 8) | (((flags) & 0xf00000) >> 12))
> +
> typedef struct QEMU_PACKED SevHashTableEntry {
>     QemuUUID guid;
>     uint16_t len;
> @@ -88,6 +94,14 @@ typedef struct QEMU_PACKED SevHashTableDescriptor {
>     uint32_t size;
> } SevHashTableDescriptor;
>=20
> +typedef struct SevLaunchVmsa {
> +    QTAILQ_ENTRY(SevLaunchVmsa) next;
> +
> +    uint16_t cpu_index;
> +    uint64_t gpa;
> +    struct sev_es_save_area vmsa;
> +} SevLaunchVmsa;
> +
> struct SevCommonState {
>     X86ConfidentialGuest parent_obj;
>=20
> @@ -106,9 +120,7 @@ struct SevCommonState {
>     int sev_fd;
>     SevState state;
>=20
> -    uint32_t reset_cs;
> -    uint32_t reset_ip;
> -    bool reset_data_valid;
> +    QTAILQ_HEAD(, SevLaunchVmsa) launch_vmsa;
> };
>=20
> struct SevCommonStateClass {
> @@ -371,6 +383,172 @@ static struct RAMBlockNotifier sev_ram_notifier =
=3D {
>     .ram_block_removed =3D sev_ram_block_removed,
> };
>=20
> +static void sev_apply_cpu_context(CPUState *cpu)
> +{
> +    SevCommonState *sev_common =3D =
SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> +    X86CPU *x86;
> +    CPUX86State *env;
> +    struct SevLaunchVmsa *launch_vmsa;
> +
> +    /* See if an initial VMSA has been provided for this CPU */
> +    QTAILQ_FOREACH(launch_vmsa, &sev_common->launch_vmsa, next)
> +    {
> +        if (cpu->cpu_index =3D=3D launch_vmsa->cpu_index) {
> +            x86 =3D X86_CPU(cpu);
> +            env =3D &x86->env;
> +
> +            /*
> +             * Ideally we would provide the VMSA directly to kvm =
which would
> +             * ensure that the resulting initial VMSA measurement =
which is
> +             * calculated during KVM_SEV_LAUNCH_UPDATE_VMSA is =
calculated from
> +             * exactly what we provide here. Currently this is not =
possible so
> +             * we need to copy the parts of the VMSA structure that =
we currently
> +             * support into the CPU state.
> +             */
> +            cpu_load_efer(env, launch_vmsa->vmsa.efer);
> +            cpu_x86_update_cr4(env, launch_vmsa->vmsa.cr4);
> +            cpu_x86_update_cr0(env, launch_vmsa->vmsa.cr0);
> +            cpu_x86_update_cr3(env, launch_vmsa->vmsa.cr3);
> +            env->xcr0 =3D launch_vmsa->vmsa.xcr0;
> +            env->pat =3D launch_vmsa->vmsa.g_pat;
> +
> +            cpu_x86_load_seg_cache(
> +                env, R_CS, launch_vmsa->vmsa.cs.selector,
> +                launch_vmsa->vmsa.cs.base, =
launch_vmsa->vmsa.cs.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.cs.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_DS, launch_vmsa->vmsa.ds.selector,
> +                launch_vmsa->vmsa.ds.base, =
launch_vmsa->vmsa.ds.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.ds.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_ES, launch_vmsa->vmsa.es.selector,
> +                launch_vmsa->vmsa.es.base, =
launch_vmsa->vmsa.es.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.es.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_FS, launch_vmsa->vmsa.fs.selector,
> +                launch_vmsa->vmsa.fs.base, =
launch_vmsa->vmsa.fs.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.fs.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_GS, launch_vmsa->vmsa.gs.selector,
> +                launch_vmsa->vmsa.gs.base, =
launch_vmsa->vmsa.gs.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.gs.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_SS, launch_vmsa->vmsa.ss.selector,
> +                launch_vmsa->vmsa.ss.base, =
launch_vmsa->vmsa.ss.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.ss.attrib));
> +
> +            env->gdt.base =3D launch_vmsa->vmsa.gdtr.base;
> +            env->gdt.limit =3D launch_vmsa->vmsa.gdtr.limit;
> +            env->gdt.flags =3D
> +                =
FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.gdtr.attrib);
> +            env->idt.base =3D launch_vmsa->vmsa.idtr.base;
> +            env->idt.limit =3D launch_vmsa->vmsa.idtr.limit;
> +            env->idt.flags =3D
> +                =
FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.idtr.attrib);
> +
> +            cpu_x86_load_seg_cache(
> +                env, R_LDTR, launch_vmsa->vmsa.ldtr.selector,
> +                launch_vmsa->vmsa.ldtr.base, =
launch_vmsa->vmsa.ldtr.limit,
> +                =
FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.ldtr.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_TR, launch_vmsa->vmsa.tr.selector,
> +                launch_vmsa->vmsa.ldtr.base, =
launch_vmsa->vmsa.tr.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.tr.attrib));
> +
> +            env->dr[6] =3D launch_vmsa->vmsa.dr6;
> +            env->dr[7] =3D launch_vmsa->vmsa.dr7;
> +
> +            env->regs[R_EAX] =3D launch_vmsa->vmsa.rax;
> +            env->regs[R_ECX] =3D launch_vmsa->vmsa.rcx;
> +            env->regs[R_EDX] =3D launch_vmsa->vmsa.rdx;
> +            env->regs[R_EBX] =3D launch_vmsa->vmsa.rbx;
> +            env->regs[R_ESP] =3D launch_vmsa->vmsa.rsp;
> +            env->regs[R_EBP] =3D launch_vmsa->vmsa.rbp;
> +            env->regs[R_ESI] =3D launch_vmsa->vmsa.rsi;
> +            env->regs[R_EDI] =3D launch_vmsa->vmsa.rdi;
> +#ifdef TARGET_X86_64
> +            env->regs[R_R8] =3D launch_vmsa->vmsa.r8;
> +            env->regs[R_R9] =3D launch_vmsa->vmsa.r9;
> +            env->regs[R_R10] =3D launch_vmsa->vmsa.r10;
> +            env->regs[R_R11] =3D launch_vmsa->vmsa.r11;
> +            env->regs[R_R12] =3D launch_vmsa->vmsa.r12;
> +            env->regs[R_R13] =3D launch_vmsa->vmsa.r13;
> +            env->regs[R_R14] =3D launch_vmsa->vmsa.r14;
> +            env->regs[R_R15] =3D launch_vmsa->vmsa.r15;
> +#endif
> +            env->eip =3D launch_vmsa->vmsa.rip;
> +            env->eflags =3D launch_vmsa->vmsa.rflags;
> +
> +            cpu_set_fpuc(env, launch_vmsa->vmsa.x87_fcw);
> +            env->mxcsr =3D launch_vmsa->vmsa.mxcsr;
> +
> +            break;
> +        }
> +    }
> +}
> +
> +static int sev_set_cpu_context(uint16_t cpu_index, const void *ctx,
> +                               uint32_t ctx_len, hwaddr gpa, Error =
**errp)
> +{
> +    SevCommonState *sev_common =3D =
SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> +    SevLaunchVmsa *launch_vmsa;
> +    CPUState *cpu;
> +    bool exists =3D false;
> +
> +    /*
> +     * Setting the CPU context is only supported for SEV-ES and =
SEV-SNP. The
> +     * context buffer will contain a sev_es_save_area from the Linux =
kernel
> +     * which is defined by "Table B-4. VMSA Layout, State Save Area =
for SEV-ES"
> +     * in the AMD64 APM, Volume 2.
> +     */
> +
> +    if (!sev_es_enabled()) {
> +        error_setg(errp, "SEV: unable to set CPU context: Not =
supported");
> +        return -1;
> +    }
> +
> +    if (ctx_len < sizeof(struct sev_es_save_area)) {
> +        error_setg(errp, "SEV: unable to set CPU context: "
> +                     "Invalid context provided");
> +        return -1;
> +    }
> +
> +    cpu =3D qemu_get_cpu(cpu_index);
> +    if (!cpu) {
> +        error_setg(errp, "SEV: unable to set CPU context for out of =
bounds "
> +                     "CPU index %d", cpu_index);
> +        return -1;
> +    }
> +
> +    /*
> +     * If the context of this VP has already been set then replace it =
with the
> +     * new context.
> +     */
> +    QTAILQ_FOREACH(launch_vmsa, &sev_common->launch_vmsa, next)
> +    {
> +        if (cpu_index =3D=3D launch_vmsa->cpu_index) {
> +            launch_vmsa->gpa =3D gpa;
> +            memcpy(&launch_vmsa->vmsa, ctx, =
sizeof(launch_vmsa->vmsa));
> +            exists =3D true;
> +            break;
> +        }
> +    }
> +
> +    if (!exists) {
> +        /* New VP context */
> +        launch_vmsa =3D g_new0(SevLaunchVmsa, 1);
> +        memcpy(&launch_vmsa->vmsa, ctx, sizeof(launch_vmsa->vmsa));
> +        launch_vmsa->cpu_index =3D cpu_index;
> +        launch_vmsa->gpa =3D gpa;
> +        QTAILQ_INSERT_TAIL(&sev_common->launch_vmsa, launch_vmsa, =
next);
> +    }
> +
> +    /* Synchronise the VMSA with the current CPU state */
> +    sev_apply_cpu_context(cpu);

Ok so here you are not only saving the vmsa but also applying it.

> +
> +    return 0;
> +}
> +
> bool
> sev_enabled(void)
> {
> @@ -1005,6 +1183,16 @@ static int
> sev_launch_update_vmsa(SevGuestState *sev_guest)
> {
>     int ret, fw_error;
> +    CPUState *cpu;
> +
> +    /*
> +     * The initial CPU state is measured as part of =
KVM_SEV_LAUNCH_UPDATE_VMSA.
> +     * Synchronise the CPU state to any provided launch VMSA =
structures.
> +     */
> +    CPU_FOREACH(cpu) {
> +        sev_apply_cpu_context(cpu);
> +    }
> +
>=20
>     ret =3D sev_ioctl(SEV_COMMON(sev_guest)->sev_fd, =
KVM_SEV_LAUNCH_UPDATE_VMSA,
>                     NULL, &fw_error);
> @@ -1787,40 +1975,110 @@ sev_es_find_reset_vector(void *flash_ptr, =
uint64_t flash_size,
>     return sev_es_parse_reset_block(info, addr);
> }
>=20
> -void sev_es_set_reset_vector(CPUState *cpu)
> +
> +static void seg_to_vmsa(const SegmentCache *cpu_seg, struct vmcb_seg =
*vmsa_seg)
> {
> -    X86CPU *x86;
> -    CPUX86State *env;
> -    ConfidentialGuestSupport *cgs =3D =
MACHINE(qdev_get_machine())->cgs;
> -    SevCommonState *sev_common =3D SEV_COMMON(
> -        object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON));
> +    vmsa_seg->selector =3D cpu_seg->selector;
> +    vmsa_seg->base =3D cpu_seg->base;
> +    vmsa_seg->limit =3D cpu_seg->limit;
> +    vmsa_seg->attrib =3D FLAGS_SEGCACHE_TO_VMSA(cpu_seg->flags);
> +}
>=20
> -    /* Only update if we have valid reset information */
> -    if (!sev_common || !sev_common->reset_data_valid) {
> -        return;
> -    }
> +static void initialize_vmsa(const CPUState *cpu, struct =
sev_es_save_area *vmsa)
> +{
> +    const X86CPU *x86 =3D X86_CPU(cpu);
> +    const CPUX86State *env =3D &x86->env;
>=20
> -    /* Do not update the BSP reset state */
> -    if (cpu->cpu_index =3D=3D 0) {
> -        return;
> +    /*
> +     * Initialize the SEV-ES save area from the current state of
> +     * the CPU. The entire state does not need to be copied, only the =
state
> +     * that is copied back to the CPUState in sev_apply_cpu_context.
> +     */
> +    memset(vmsa, 0, sizeof(struct sev_es_save_area));
> +    vmsa->efer =3D env->efer;
> +    vmsa->cr0 =3D env->cr[0];
> +    vmsa->cr3 =3D env->cr[3];
> +    vmsa->cr4 =3D env->cr[4];
> +    vmsa->xcr0 =3D env->xcr0;
> +    vmsa->g_pat =3D env->pat;
> +
> +    seg_to_vmsa(&env->segs[R_CS], &vmsa->cs);
> +    seg_to_vmsa(&env->segs[R_DS], &vmsa->ds);
> +    seg_to_vmsa(&env->segs[R_ES], &vmsa->es);
> +    seg_to_vmsa(&env->segs[R_FS], &vmsa->fs);
> +    seg_to_vmsa(&env->segs[R_GS], &vmsa->gs);
> +    seg_to_vmsa(&env->segs[R_SS], &vmsa->ss);
> +
> +    seg_to_vmsa(&env->gdt, &vmsa->gdtr);
> +    seg_to_vmsa(&env->idt, &vmsa->idtr);
> +    seg_to_vmsa(&env->ldt, &vmsa->ldtr);
> +    seg_to_vmsa(&env->tr, &vmsa->tr);
> +
> +    vmsa->dr6 =3D env->dr[6];
> +    vmsa->dr7 =3D env->dr[7];
> +
> +    vmsa->rax =3D env->regs[R_EAX];
> +    vmsa->rcx =3D env->regs[R_ECX];
> +    vmsa->rdx =3D env->regs[R_EDX];
> +    vmsa->rbx =3D env->regs[R_EBX];
> +    vmsa->rsp =3D env->regs[R_ESP];
> +    vmsa->rbp =3D env->regs[R_EBP];
> +    vmsa->rsi =3D env->regs[R_ESI];
> +    vmsa->rdi =3D env->regs[R_EDI];
> +
> +#ifdef TARGET_X86_64
> +    vmsa->r8 =3D env->regs[R_R8];
> +    vmsa->r9 =3D env->regs[R_R9];
> +    vmsa->r10 =3D env->regs[R_R10];
> +    vmsa->r11 =3D env->regs[R_R11];
> +    vmsa->r12 =3D env->regs[R_R12];
> +    vmsa->r13 =3D env->regs[R_R13];
> +    vmsa->r14 =3D env->regs[R_R14];
> +    vmsa->r15 =3D env->regs[R_R15];
> +#endif
> +
> +    vmsa->rip =3D env->eip;
> +    vmsa->rflags =3D env->eflags;
> +}
> +
> +static void sev_es_set_ap_context(uint32_t reset_addr)
> +{
> +    CPUState *cpu;
> +    struct sev_es_save_area vmsa;
> +    SegmentCache cs;
> +
> +    cs.selector =3D 0xf000;
> +    cs.base =3D reset_addr & 0xffff0000;
> +    cs.limit =3D 0xffff;
> +    cs.flags =3D DESC_P_MASK | DESC_S_MASK | DESC_CS_MASK | =
DESC_R_MASK |
> +               DESC_A_MASK;
> +
> +    CPU_FOREACH(cpu) {
> +        if (cpu->cpu_index =3D=3D 0) {
> +            /* Do not update the BSP reset state */
> +            continue;
> +        }
> +        initialize_vmsa(cpu, &vmsa);
> +        seg_to_vmsa(&cs, &vmsa.cs);
> +        vmsa.rip =3D reset_addr & 0x0000ffff;
> +        sev_set_cpu_context(cpu->cpu_index, &vmsa,
> +                            sizeof(struct sev_es_save_area),
> +                            0, &error_fatal);
> +        sev_apply_cpu_context(cpu);

Is the above call ^^^^^^ sev_apply_cpu_context() needed? Since in =
sev_set_cpu_context() you already call it?

>     }


