Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B6C7311D3
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 10:12:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9i4s-0001I5-Gx; Thu, 15 Jun 2023 04:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q9i4l-0001Cb-8r; Thu, 15 Jun 2023 04:11:27 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q9i4j-0003zT-16; Thu, 15 Jun 2023 04:11:26 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9745ba45cd1so219329266b.1; 
 Thu, 15 Jun 2023 01:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1686816682; x=1689408682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jc3bGs7n8LGJfGG9OcFyn2jHuE4ZH06NRDgfF5l5LjU=;
 b=DeLazfIC3InLlnc+CbN7u3tKeBgHiyvNu9e/jNH3WftMrgPB8g8Nm8trECi2KONeGZ
 uf3lWDYbRqTYPo0TVAcyEuFtq7s9eO4TbZ8HkZ0Zo2uvlysLQyGKYZ4tw2gr7KzCTIpj
 SgMSEMZGFaHUpnALuimbilC8pr1x3qSHGxIzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686816682; x=1689408682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jc3bGs7n8LGJfGG9OcFyn2jHuE4ZH06NRDgfF5l5LjU=;
 b=TxBW7kp5oGlR4+v5Fv4YDhCOvCHo2iNfr6p7xjAKG4OPIMggxbhIuMMyiCkAMgmaK4
 c4+EZ8OwVwvJISRHKYFhrMoxkSJz5uW6mBevLF6FwG78usfpK3CW0TWKQDtv7zZ5kMsT
 DQtxBFj6vp0LUmrMrhy8NYSA5ShLFk0xqlViHVXPGcYCEGDYBE4jP/Tnyt79L21a6rNf
 ARUDe33y2U+TT+T4t5yc34Wbui5QBGhIdzPMDksY4yhXYumUPnGvAPz8BTrlyFONI6d4
 g9PPLfhL6EVPd8vucE9TYOlSZcHas4f4/q67rqURH08Bv1GqzqssITNAjjU28kjh/JAW
 ej+A==
X-Gm-Message-State: AC+VfDwpRvT0tr5TRrDF5ivYSZtvRPH9U4ZkOqOp5eABJrN1ncCFwJ24
 4aCBponayv21VFNtEaPRD5O4sFD2zQDy7oiHbBo=
X-Google-Smtp-Source: ACHHUZ4bUFGFP77ZcF3kMaZOJhG6wTzBNRglO1RF+tVoIeHKdwBZFicWiHALQYaEk74qIyu3OSniSMlM/E6RZ+LZRhQ=
X-Received: by 2002:a17:906:d553:b0:970:c9f:2db6 with SMTP id
 cr19-20020a170906d55300b009700c9f2db6mr17756450ejc.63.1686816681651; Thu, 15
 Jun 2023 01:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230608075826.86217-1-npiggin@gmail.com>
 <CACPK8XdpAxjvP+bFNFJzQQzBYvEwsE69QkbNWRumZtUW2wOrrA@mail.gmail.com>
 <CTCW1ILCXTMA.24T7LU9PQBTDA@wheely>
In-Reply-To: <CTCW1ILCXTMA.24T7LU9PQBTDA@wheely>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 15 Jun 2023 08:11:09 +0000
Message-ID: <CACPK8XdOv4j5y6ADrxfvW_iDLLT0UT6Dwb_-J3mTA1Rq9s4xtQ@mail.gmail.com>
Subject: Re: [kvm-unit-tests v4 00/12] powerpc: updates, P10, PNV support
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kvm@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 linuxppc-dev@lists.ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, 15 Jun 2023 at 03:02, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Wed Jun 14, 2023 at 11:09 AM AEST, Joel Stanley wrote:
> > On Thu, 8 Jun 2023 at 07:58, Nicholas Piggin <npiggin@gmail.com> wrote:
> > >
> > > Posting again, a couple of patches were merged and accounted for review
> > > comments from last time.
> >
> > I saw some failures in the spr tests running on a power9 powernv system:
> >
> > $ TESTNAME=sprs TIMEOUT=90s ACCEL= ./powerpc/run powerpc/sprs.elf -smp
> > 1 |grep FAIL
> > FAIL: WORT      ( 895):    0x00000000c0deba80 <==> 0x0000000000000000
>
> This is just TCG machine? I'm not sure why WORT fails, AFAIKS it's the
> same on POWER8 and doesn't do anything just a simple register. I think
> on real hardware WORT may not have any bits implemented on POWER9
> though.

Yeah, just the TCG machine. Now that you point it out all of the
failures I reported are for ACCEL=<blank>, so they are running in tcg
mode.

run_migration timeout -k 1s --foreground 90s
/usr/bin/qemu-system-ppc64 -nodefaults -machine pseries,accel=tcg
-bios powerpc/boot_rom.bin -display none -serial stdio -kernel
powerpc/sprs.elf -smp 1 -append -w # -initrd /tmp/tmp.61XhbvCGcb


>
> > $ MIGRATION=yes TESTNAME=sprs-migration TIMEOUT=90s ACCEL=
> > ./powerpc/run powerpc/sprs.elf -smp 1 -append '-w' | grep FAIL
> > FAIL: SRR0      (  26):    0xcafefacec0debabc <==> 0x0000000000402244
> > FAIL: SRR1      (  27):    0xc0000006409ebab6 <==> 0x8000000000001001
> > FAIL: CTRL      ( 136):            0x00000000 <==>         0x00008001
> > FAIL: WORT      ( 895):    0x00000000c0deba80 <==> 0x0000000000000000
> > FAIL: PIR       (1023):            0x00000010 <==>         0x00000049
> >
> > Linux 6.2.0-20-generic
> > QEMU emulator version 7.2.0 (Debian 1:7.2+dfsg-5ubuntu2)
> >
> > On a power8 powernv:
> >
> > MIGRATION=yes TESTNAME=sprs-migration TIMEOUT=90s ACCEL= ./powerpc/run
> > powerpc/sprs.elf -smp 1 -append '-w' |grep FAIL
> > FAIL: SRR0      (  26):    0xcafefacec0debabc <==> 0x0000000000402234
> > FAIL: SRR1      (  27):    0xc0000006409ebab6 <==> 0x8000000000001000
> > FAIL: CTRL      ( 136):            0x00000000 <==>         0x00008001
> > FAIL: PIR       (1023):            0x00000060 <==>         0x00000030
>
> Hmm, seems we take some interrupt over migration test that is not
> accounted for (could check the address in SRR0 to see where it is).
> Either need to prevent that interrupt or avoid failing on SRR0/1 on
> this test.
>
> Interesting about CTRL, I wonder if that not migrating correctly.
> PIR looks like a migration issue as well, it can't be changed so
> destination CPU has got a different PIR. I would be inclined to
> leave those as failing to remind us to look into them.
>
> I'll take a look at the others though.
>
> Thanks,
> Nick

