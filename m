Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3965E72224A
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:35:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66ar-00059H-Dq; Mon, 05 Jun 2023 05:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q66aT-00058u-Ft; Mon, 05 Jun 2023 05:33:17 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q66aR-0003TT-Mf; Mon, 05 Jun 2023 05:33:17 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-652426346bbso2046244b3a.3; 
 Mon, 05 Jun 2023 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685957593; x=1688549593;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cl5tkbTX2wg4Wz3syKnGuUFZWBuVy8nZaYgV42QxJL0=;
 b=qQpIuZxjHlDVaGMhPzUQ4k4FwgN6arrGKQY5GS3FLqtmcmbYgdN+9QHEJPsbsYX9eH
 Yfb4wOZvGXXFxzuNI5nlCrZ0ufSQW3REWw24O2/bEnC1NNwcOvktuf5/bQXhBO2SJJao
 7AuA/9cpEdM3aO8/9RQ7D8yOTql3syCRtL/PupNSFXidZ3lqMn6w3xUhwheAwI0laJp/
 Qx6zYLelIixHPHhhIulCKXUpNFy0XoFAYJYM0QYvlgnSSXAukER8X3eRF2Za0vXdBI+W
 33d+TZT6r510uea9bw0TzsnwRqVyPeTaBFGywN6yQUNc11Q5YtxrNbpqCIGw4dxmsrL3
 H2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685957593; x=1688549593;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cl5tkbTX2wg4Wz3syKnGuUFZWBuVy8nZaYgV42QxJL0=;
 b=MT/0cApQuZgttFaL9VGCWw3BnvDbgrJFZgd/OEu9W3TtPE+qJMJXpJnVG+WHH7PfLF
 lTn5dnVTCKvTP+rZLVCtXHP1QVZ7hmMjEqPereuVfw2EtjsYz/Ql1QtyW7FsucA6XuFy
 2bF4ferhIMu0pGDesUDvR68vfAiuJUj+UdiaOSB7rUUfoiQbOd02GFDHOZy047BtgC7T
 wn0o2/m1/BI6nCVwvxiK4DCrTUkPdJLicklxlA8x9WneoKzH8tRextNpjsmDzyZgErsK
 AW/YUubDOgNM9pHDUEtsx54c6VVfv7F1VFAnS3db3q9yvbGfLEY5DNm2Ky3LwtlRGUTf
 83Rg==
X-Gm-Message-State: AC+VfDwuFRQJZ5Crow32/o4npE5MYBOyZiIXBiuB1oJARdw5/5NJ/3hg
 l9axW5EN/6kBt8gsycNReeg=
X-Google-Smtp-Source: ACHHUZ5HzjYBmIc9LXFrH+KptFqsPct4ORnjJMYMHh26+H3vH4NxNJjTKEWk7oYhsYhJiugrddI1Sg==
X-Received: by 2002:a05:6a00:2295:b0:64d:2c61:4b1 with SMTP id
 f21-20020a056a00229500b0064d2c6104b1mr14594198pfe.11.1685957593490; 
 Mon, 05 Jun 2023 02:33:13 -0700 (PDT)
Received: from localhost ([203.221.142.9]) by smtp.gmail.com with ESMTPSA id
 p1-20020a62ab01000000b0065434edd521sm3545531pff.196.2023.06.05.02.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 02:33:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Jun 2023 19:33:05 +1000
Message-Id: <CT4M32J7BZDP.3A311JYRWL4EF@wheely>
Subject: Re: [PATCH v3] target: ppc: Use MSR_HVB bit to get the target
 endianness for memory dump
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Fabiano Rosas" <farosas@suse.de>, "Narayana Murty N"
 <nnmlinux@linux.ibm.com>, <danielhb413@gmail.com>, <clg@kaod.org>,
 <david@gibson.dropbear.id.au>, <groug@kaod.org>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, <npiggin@linux.ibm.com>,
 <vaibhav@linux.ibm.com>, <harshpb@linux.ibm.com>, <sbhat@linux.ibm.com>
X-Mailer: aerc 0.14.0
References: <20230522160242.37261-1-nnmlinux@linux.ibm.com>
 <CSYG8RTMAB5O.2H9DDPSRE7JR0@wheely> <87pm6js06l.fsf@suse.de>
In-Reply-To: <87pm6js06l.fsf@suse.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

On Tue May 30, 2023 at 12:05 AM AEST, Fabiano Rosas wrote:
> "Nicholas Piggin" <npiggin@gmail.com> writes:
>
> > On Tue May 23, 2023 at 2:02 AM AEST, Narayana Murty N wrote:
> >> Changes since V2:
> >> commit message modified as per feedbak from Nicholas Piggin.
> >> Changes since V1:
> >> https://lore.kernel.org/qemu-devel/20230420145055.10196-1-nnmlinux@lin=
ux.ibm.com/
> >> The approach to solve the issue was changed based on feedback from
> >> Fabiano Rosas on patch V1.
> >> ---
> >>  target/ppc/arch_dump.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> >> index f58e6359d5..a8315659d9 100644
> >> --- a/target/ppc/arch_dump.c
> >> +++ b/target/ppc/arch_dump.c
> >> @@ -237,7 +237,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
> >>      info->d_machine =3D PPC_ELF_MACHINE;
> >>      info->d_class =3D ELFCLASS;
> >> =20
> >> -    if (ppc_interrupts_little_endian(cpu, cpu->env.has_hv_mode)) {
> >> +    if (ppc_interrupts_little_endian(cpu, !!(cpu->env.msr_mask & MSR_=
HVB))) {
> >>          info->d_endian =3D ELFDATA2LSB;
> >>      } else {
> >>          info->d_endian =3D ELFDATA2MSB;
> >
> > Oh, and now I see it cpu_get_dump_info just picks the first CPU to test
> > this! So a test that can change at runtime is surely not the right one.
> > If you use MSR[HV] then if you have a SMP machine that is doing a bunch
> > of things and you want to dump to debug the system, this will just
> > randomly give you a wrong-endian dump if CPU0 just happened to be
> > running some KVM guest.
> >
>
> Not sure if you are just thinking out loud about MSR_HV or if you
> mistook MSR_HVB for MSR_HV. But just in case:

Oh, yes I did confuse the MSR from the mask. Apologies, that makes much
of my ranting invalid.

> The env->msr_mask is what tells us what MSR bits are supported for this
> CPU, i.e. what features it contains. So MSR_HVB is not equivalent to
> MSR[HV], but merely informs that this CPU knows about MSR_HV. We then
> store that information at has_hv_mode. The MSR_HVB bit changes only
> once (at cpu_ppc_set_vhyp), after we decide whether to use vhyp. So:
>
> env->has_hv_mode =3D=3D cpu supports HV mode;
>
> MSR_HVB=3D1 =3D=3D cpu supports HV mode AND we allow the OS to run with M=
SR_HV=3D1;
>
> MSR_HVB=3D0 =3D=3D cpu doesn't support HV mode OR
>              cpu supports HV mode, but we don't allow the OS to run with
>              MSR_HV=3D1 because QEMU is the HV (i.e. vhyp);
>
> For the arch_dump code, passing (msr_mask & MSR_HVB) ends up meaning:
> "can this OS ever run with MSR_HV=3D1?", which for emulated powernv would
> be Yes and for pseries (incl. nested) would be No. So for emulated
> powernv we always look at the emulated HILE and for pseries we always
> look at LPCR_ILE.

Well then I agree with that, I think the talk of the KVM guest confused
me. So in that case I agree with the patch.

It does seem like there would be still a problem with a nested KVM guest
on pseries though, since it hijacks LPCR among other SPRs, and may
modify ILE. It seems like you would need a way to ask vhyp for the
host's interrupt endian mode (and would get that from SpaprCpuState's
nested_host_state regs. But that could be fixed later.

Thanks,
Nick

