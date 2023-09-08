Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D10179813B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 06:26:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeT3N-0000hX-C4; Fri, 08 Sep 2023 00:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qeT3J-0000hE-Mt; Fri, 08 Sep 2023 00:25:05 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qeT3H-0007kw-2S; Fri, 08 Sep 2023 00:25:05 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso1379161a12.3; 
 Thu, 07 Sep 2023 21:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694147100; x=1694751900; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMRQBHCavGjbbzDtIvJp7/eJjz1OMTZ9vDu3onZh3S8=;
 b=JKARrrLPFsUDKxHETVQul2VE/mDPsHTqByL934e+hYG/SswFRrIsEaiRESEO1QGZVi
 ab8rmy19jS2+LwvWmllbwVeyQOLmwpy73RdfBrXlhbcIUqw7KYX3Cqp+mie9rgJqHVYC
 ZJo3F/s5j7JzhqWq1Ae1NiYhUHOP2OYe1XbazTeKRSD+pNQXSDyBGELpTf3myeBsbTKO
 zvPrfhsrxEcQgoI5isudbdbo0T1EuH4lvppa+Utge6vYQm9mu26U5aUHQ2Cm5fbVZMA2
 5GhEpOKVkZAaemDS3fN1XePUhp4KiEvh+1mQeUINTprPxfIiryd0X5CXHhHTY8W0H9ik
 b8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694147100; x=1694751900;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kMRQBHCavGjbbzDtIvJp7/eJjz1OMTZ9vDu3onZh3S8=;
 b=m7dpTiTIG9i3P/yST00HBULWR4KG49Dkeje3+pLboVIDH7BkV8kS+fFeOievyXOIb6
 weUX+qAZgRFEQ/tHmz44FJCPv5nLcx9r+ehq0slXPIaJuKusm7gH5zXlGyNY+0deua5K
 SRC12Le58KrFIs6eMZ6TTF1SgP7XSGpp48PX088ER14w48dYCOrrvXWlJ0vHYzkd6U+2
 Ptzrdp8OeX80ezmU8aKpXKAjn1cGmN8hIkDj2JTGFlZ47QkaFzyDxudS6ln0tZRVFziA
 1+lvYf6BHTvM/J5b29AMuVaAqc7OPuLpMa0jT3gg+y5NFELIFhnCj2AqsV+f8pQmSPCl
 TXtQ==
X-Gm-Message-State: AOJu0YyTrGB0yr/os+jgtVCuhIvGK4tjWaDANBFuvFbfKJIjWWx4Et9p
 BIRlKsZrQ/586YB3syqrYL0=
X-Google-Smtp-Source: AGHT+IHT+ys0USg/9SyUfLF0n4672NGZTBSI7IZ9hnb/0uA2SWI9Ao3D7pYD7xjrDy6DCQUZKzXIUg==
X-Received: by 2002:a05:6300:8081:b0:13d:54cd:63e7 with SMTP id
 ap1-20020a056300808100b0013d54cd63e7mr1450928pzc.33.1694147100499; 
 Thu, 07 Sep 2023 21:25:00 -0700 (PDT)
Received: from localhost ([193.114.103.68]) by smtp.gmail.com with ESMTPSA id
 k17-20020aa78211000000b00682d79199e7sm440537pfi.200.2023.09.07.21.24.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 21:25:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Sep 2023 14:24:55 +1000
Message-Id: <CVD90VD3O9W1.1UBFXQ7MSVZEO@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PULL v2 00/35] ppc queue
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Michael Tokarev"
 <mjt@tls.msk.ru>, <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230906143653.54709-1-clg@kaod.org>
 <2b6c3dd1-430a-2e60-ea73-29c507d631d8@tls.msk.ru>
 <ad943b46-0652-8fd1-49a4-c86dd6214827@kaod.org>
In-Reply-To: <ad943b46-0652-8fd1-49a4-c86dd6214827@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
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

On Fri Sep 8, 2023 at 8:15 AM AEST, C=C3=A9dric Le Goater wrote:
> On 9/7/23 21:10, Michael Tokarev wrote:
> > 06.09.2023 17:36, C=C3=A9dric Le Goater wrote:
> > ...
> >> ppc queue :
> >>
> >> * debug facility improvements
> >> * timebase and decrementer fixes
> >> * record-replay fixes
> >> * TCG fixes
> >> * XIVE model improvements for multichip
> >>
> >> ----------------------------------------------------------------
> >> C=C3=A9dric Le Goater (4):
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ppc/xive: Use address_space routi=
nes to access the machine RAM
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ppc/xive: Introduce a new XiveRou=
ter end_notify() handler
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ppc/xive: Handle END triggers bet=
ween chips with MMIOs
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ppc/xive: Add support for the PC =
MMIOs
> >>
> >> Joel Stanley (1):
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ppc: Add stub implementation of T=
RIG SPRs
> >>
> >> Maksim Kostin (1):
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/ppc/e500: fix broken snapshot =
replay
> >>
> >> Nicholas Piggin (26):
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target/ppc: Remove single-step su=
ppression inside 0x100-0xf00
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target/ppc: Improve book3s branch=
 trace interrupt for v2.07S
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target/ppc: Suppress single step =
interrupts on rfi-type instructions
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target/ppc: Implement breakpoint =
debug facility for v2.07S
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target/ppc: Implement watchpoint =
debug facility for v2.07S
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spapr: implement H_SET_MODE debug=
 facilities
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ppc/vhyp: reset exception state w=
hen handling vhyp hcall
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ppc/vof: Fix missed fields in VOF=
 cleanup
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/ppc/ppc.c: Tidy over-long line=
s
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/ppc: Introduce functions for c=
onversion between timebase and nanoseconds
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host-utils: Add muldiv64_round_up
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/ppc: Round up the decrementer =
interval when converting to ns
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/ppc: Avoid decrementer roundin=
g errors
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target/ppc: Sign-extend large dec=
rementer to 64-bits
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/ppc: Always store the decremen=
ter value
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target/ppc: Migrate DECR SPR
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/ppc: Reset timebase facilities=
 on machine reset
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/ppc: Read time only once to pe=
rform decrementer write
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target/ppc: Fix CPU reservation m=
igration for record-replay
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target/ppc: Fix timebase reset wi=
th record-replay
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spapr: Fix machine reset deadlock=
 from replay-record
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spapr: Fix record-replay machine =
reset consuming too many events
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tests/avocado: boot ppc64 pseries=
 replay-record test to Linux VFS mount
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tests/avocado: reverse-debugging =
cope with re-executing breakpoints
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tests/avocado: ppc64 reverse debu=
gging tests for pseries and powernv
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target/ppc: Fix LQ, STQ register-=
pair order for big-endian
> >>
> >> Richard Henderson (1):
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target/ppc: Flush inputs to zero =
with NJ in ppc_store_vscr
> >>
> >> Shawn Anastasio (1):
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target/ppc: Generate storage inte=
rrupts for radix RC changes
> >>
> >> jianchunfu (1):
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target/ppc: Fix the order of kvm_=
enable judgment about kvmppc_set_interrupt()
> >=20
> > Is there anything in there worth to pick for -stable?
> > Like, for example, some decrementer fixes,=20
>
> The decrementer fixes are good candidates but there are quite a few
> patches and you might encounter conflicts.

Decrementer I was nervous about since there were quite a lot of
interacting issues. Decrementer has worked okay for a while, so
even though there are some bugs, they're mostly in edge cases
that most OSes don't hit or care so much about.

Possibly the decrementer migration patch could be a candidate.

In any case I would like them to get more testing upstream for
a while first.

>
> > or some of these:
> >=20
> >  =C2=A0ppc/vof: Fix missed fields in VOF cleanup

vof patch I think is a candidate. Simple and fixes leaks.

> >  =C2=A0spapr: Fix machine reset deadlock from replay-record
> >  =C2=A0hw/ppc/e500: fix broken snapshot replay
>
> I can not tell if replay-record is important for stable. Nick ?

It seems to have been broken in many ways for long enough that
nobody was really using it (at least on pseries). Maybe e500
because an issue was filed for that and the fix looked small.

>  =20
> > or something else?
>
> These are :
>
>    target/ppc: Flush inputs to zero with NJ in ppc_store_vscr
>    target/ppc: Fix LQ, STQ register-pair order for big-endian

Yes definitely these two.

Thanks,
Nick

