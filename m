Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 587FD8C0B44
	for <lists+qemu-devel@lfdr.de>; Thu,  9 May 2024 07:59:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4wo5-0006ra-2Q; Thu, 09 May 2024 01:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4wo0-0006rE-5H; Thu, 09 May 2024 01:59:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4wnx-0001kH-1n; Thu, 09 May 2024 01:58:59 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ed96772f92so3993035ad.0; 
 Wed, 08 May 2024 22:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715234334; x=1715839134; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Msw3yMNt09dpy0EpHwPl7f/EyCepMzXGNFkvIh20Bdk=;
 b=NYEGJEaeHdoBOOr0JZun838ETZMvMM9bVbAAf0iOQ/jy7mXJ20N7wTqXw89dJyJy89
 Ya+NC/X8TaDzvO4cpMuE7U31lG1hBb4gUxH8bVclr/X9CqBkUySroFqGhREvxbRi+U0+
 83wbJ5mp1/pDXf5ilAtAGV6YGh3HnQi5MsFUhkFj2bFgpvHPL6/oKGJXyUsyvs/Idt42
 7yKcktS8IHan+zxoa/lXDIg1QVFms4wvOJxd+3oQjhJ01xeiIthjvtG+rUAfATEMIkKo
 eFsXB3ek3XzrXMjTpIS7q6SVhlCBeummuaGd2wY2AugQhSwjy12O0qX6ugGB3u6pPwfp
 HQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715234334; x=1715839134;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Msw3yMNt09dpy0EpHwPl7f/EyCepMzXGNFkvIh20Bdk=;
 b=MTeo0W/tkEKeO0sZfmJfTc1TbhI+po8GpHFEpfl4G6spsgtLT6L8apUuK364OikN1s
 ly5AWZuRn4ptpr8KQckKSDbkc0+rgzKOU+srSEfnWmFOJZVgdLQZzRYZ3uaN7QayBI+x
 DT+7HM/7FthR4sh3OSyNLVNPiVZ09R+PO80i4zBgqg2feOtA/urmtPb1i73MsXjm8u7I
 RQZM5LpsvhcquUJX0pK4BIrkCbz/+Ag66gy/jUO44rveqqnhCbyA5oPUk/XTomuVqU8P
 BJK7a8a5SN/4NN8gYMhsAO0eq+XsOseDd5GhuK/6LOiP47QdmGtZaMwizBYaI1m/v+d5
 AdRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURikRuGhk3uS2tOrHsDmfOnDoLKyGQcLKAxljSsds2zjlssqX5DaIM97gRXbntM79ByvMK2mTqYQEMBOgsP+4D5zKG
X-Gm-Message-State: AOJu0YyA64Sasfv+j/GOTgeu+vm1Rn27pKz6ivCr0oBYaDSpxs+sIzVe
 s8HrsvuYrNXprNKEx6la2lOTXoVgqWQy2d+LEh4Z90h0YzkxlmgH
X-Google-Smtp-Source: AGHT+IFrb8Vojuz2lrDAGSxMJaKalda7zthPGQ39rDXL7lnJkO88HP1psL+D2Jj2R4NS2zz74jwGhQ==
X-Received: by 2002:a17:903:1c7:b0:1eb:fb02:c454 with SMTP id
 d9443c01a7336-1eeb059f16dmr55492045ad.53.1715234334217; 
 Wed, 08 May 2024 22:58:54 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c13805asm5487525ad.264.2024.05.08.22.58.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 22:58:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 May 2024 15:58:49 +1000
Message-Id: <D14VTP1B4TNR.M9SZAKYV0101@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 33/33] target/ppc: Add a macro to check for page
 protection bit
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <a91a1b9455f88cbbeff2652fc4f44acd89e98215.1715125376.git.balaton@eik.bme.hu>
 <D14ASGGTNSQB.3TX66EXAL001R@gmail.com>
 <7c4e51de-fdff-37b6-ffe5-2e7e26cffc17@eik.bme.hu>
In-Reply-To: <7c4e51de-fdff-37b6-ffe5-2e7e26cffc17@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu May 9, 2024 at 9:35 AM AEST, BALATON Zoltan wrote:
> On Wed, 8 May 2024, Nicholas Piggin wrote:
> > On Wed May 8, 2024 at 10:15 AM AEST, BALATON Zoltan wrote:
> >> Checking if a page protection bit is set for a given access type is a
> >> common operation. Add a macro to avoid repeating the same check at
> >> multiple places and also avoid a function call. As this relies on
> >> access type and page protection bit values having certain relation
> >> also add an assert to ensure that this assumption holds.
> >>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >>  target/ppc/cpu_init.c    |  4 ++++
> >>  target/ppc/internal.h    | 20 ++------------------
> >>  target/ppc/mmu-hash32.c  |  6 +++---
> >>  target/ppc/mmu-hash64.c  |  2 +-
> >>  target/ppc/mmu-radix64.c |  2 +-
> >>  target/ppc/mmu_common.c  | 26 +++++++++++++-------------
> >>  6 files changed, 24 insertions(+), 36 deletions(-)
> >>
> >> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> >> index 92c71b2a09..6639235544 100644
> >> --- a/target/ppc/cpu_init.c
> >> +++ b/target/ppc/cpu_init.c
> >> @@ -7377,6 +7377,10 @@ static void ppc_cpu_class_init(ObjectClass *oc,=
 void *data)
> >>      resettable_class_set_parent_phases(rc, NULL, ppc_cpu_reset_hold, =
NULL,
> >>                                         &pcc->parent_phases);
> >>
> >> +    /* CHECK_PROT_ACCESS relies on this MMU access and PAGE bits rela=
tion */
> >> +    assert(MMU_DATA_LOAD =3D=3D 0 && MMU_DATA_STORE =3D=3D 1 && MMU_I=
NST_FETCH =3D=3D 2 &&
> >> +           PAGE_READ =3D=3D 1 && PAGE_WRITE =3D=3D 2 && PAGE_EXEC =3D=
=3D 4);
> >> +
> >
> > Can you use qemu_build_assert() for this?
>
> I've changed it to qemu_build_assert and seems to work.
>
> >>      cc->class_by_name =3D ppc_cpu_class_by_name;
> >>      cc->has_work =3D ppc_cpu_has_work;
> >>      cc->mmu_index =3D ppc_cpu_mmu_index;
> >> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> >> index 46176c4711..9880422ce3 100644
> >> --- a/target/ppc/internal.h
> >> +++ b/target/ppc/internal.h
> >> @@ -234,24 +234,8 @@ void destroy_ppc_opcodes(PowerPCCPU *cpu);
> >>  void ppc_gdb_init(CPUState *cs, PowerPCCPUClass *ppc);
> >>  const gchar *ppc_gdb_arch_name(CPUState *cs);
> >>
> >> -/**
> >> - * prot_for_access_type:
> >> - * @access_type: Access type
> >> - *
> >> - * Return the protection bit required for the given access type.
> >> - */
> >> -static inline int prot_for_access_type(MMUAccessType access_type)
> >> -{
> >> -    switch (access_type) {
> >> -    case MMU_INST_FETCH:
> >> -        return PAGE_EXEC;
> >> -    case MMU_DATA_LOAD:
> >> -        return PAGE_READ;
> >> -    case MMU_DATA_STORE:
> >> -        return PAGE_WRITE;
> >> -    }
> >> -    g_assert_not_reached();
> >> -}
> >> +/* Check if permission bit required for the access_type is set in pro=
t */
> >> +#define CHECK_PROT_ACCESS(prot, access_type) ((prot) & (1 << (access_=
type)))
> >
> > We don't want to use a macro when an inline function will work.
> >
> > Does the compiler not see the pattern and transform the existing
> > code into a shift? If it does then I would leave it. If not, then
> > just keep prot_for_access_type but make it a shift and maybe
> > comment the logic.
> >
> > I would call the new function check_prot_for_access_type().
>
> That would be too long and does not fit on one line. Long names with=20
> underscore and 80 char line limit does not go well together. I've left=20
> this unchanged for now and wait for your reply on this.

Just split the line at the second argument. Better name is more
important than minimising line count.

Thanks,
Nick

