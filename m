Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50255742363
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 11:43:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEoAO-0007oA-6i; Thu, 29 Jun 2023 05:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEoAI-0007nP-MK; Thu, 29 Jun 2023 05:42:15 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEoAG-0002zY-UV; Thu, 29 Jun 2023 05:42:14 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6689430d803so304299b3a.0; 
 Thu, 29 Jun 2023 02:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688031725; x=1690623725;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G0s18dLUYxAa1cUjKB48Cq/5C70u01WO4q9a3tcWJoc=;
 b=OzJtgJIPcEPHnl8ABZ6ZpKy6x/z21m3RT0iIRSNhNfVMUxLDpOjw4GN99lv6Ai4SfY
 RSyUtM2ejbLJg6752XvP20EH8ZfNymsbgWqyWtf0Wjy7B5INrLf9howrk0orylyc7W2O
 LXDvCwzyZ2+WJ297cPuwkV1UFosufD/Oe6tmEP4F+yNVZRRX4/tisivaRLRcOr839OkQ
 GUaQ64Zpk9CDVJE22HMSMYhjYWEVD/J94aPU+rSbWa/TNLmhtcWXe9qJ56iFmRS+uO4Y
 L+vad230pKt8xf2Gw+6TbBHgwiqQraRev4g/X52aWQqU6cCRd0HB0gQR31xmgUMyIpvn
 IqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688031725; x=1690623725;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G0s18dLUYxAa1cUjKB48Cq/5C70u01WO4q9a3tcWJoc=;
 b=fKMk7MmEkPrcXtc2YflkknzQev/ZC+PN4XFX8gowFrFuebt+LBj4fb1p8//MPpTS6a
 jAzZmEH34jzku2W/T/yzI/m3VlevhreuEWgiUf2abJepG4WP6T8+NfV7BSZGGt1YK7xC
 9XsalsnvAi81a4GR5ZqDUUEU55UfPUDwnhqfYazkS+ONC98aCfSpPDHXv/rqvzUybBLc
 IzOg3S0rxRKgQM/N6USaEViCdOCJnthSiuRKqZiAbvCV9aE3UPikPk6i3rWN3THZCxFz
 FCgteQuejr8sjIOWPiSrLwYmNL9akst3ITLlP3kP0rl7acWwmOTdQ1qlBO03dR0mB19w
 ILhQ==
X-Gm-Message-State: AC+VfDy50f9EJgHsRwUjtCMqEyjAoThtIYwTpB/kt0nIYP+eDs/myy6W
 /KOPuf4MwE0cNZYr01DeLFU=
X-Google-Smtp-Source: ACHHUZ7Sn5NeCZQCYHvfsouTAiihpn5XA+veO//XQTxjbdW775Bleof9ifF2h4pbse+603ARYoy4mw==
X-Received: by 2002:a05:6a00:10cf:b0:668:681f:ca98 with SMTP id
 d15-20020a056a0010cf00b00668681fca98mr28759585pfu.27.1688031724880; 
 Thu, 29 Jun 2023 02:42:04 -0700 (PDT)
Received: from localhost (203-219-179-91.tpgi.com.au. [203.219.179.91])
 by smtp.gmail.com with ESMTPSA id
 k6-20020aa790c6000000b00681be8ebc00sm1726070pfk.95.2023.06.29.02.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 02:42:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Jun 2023 19:41:56 +1000
Message-Id: <CTP1AX4GL23R.COPAG8FJT61G@wheely>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>, "Mark
 Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Howard Spoelstra"
 <hsp.cat7@gmail.com>
Cc: "Peter Maydell" <peter.maydell@linaro.org>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>, "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "BALATON Zoltan" <balaton@eik.bme.hu>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>,
 "Frederic Barrat" <frederic.barrat@fr.ibm.com>, "Richard Henderson"
 <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
 <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
 <966b3fce-512d-f122-e76e-efded0db9731@kaod.org>
 <cefdeb3f-3442-ede4-3e5d-6a4a99b38293@ilande.co.uk>
 <CABLmASF92ux10=D5MJ4Ax3FbCi4digWJajHy4VE1fNUL9bOJxA@mail.gmail.com>
 <8e3010d8-9ca7-c834-3348-e11060c53f8a@ilande.co.uk>
 <CABLmASFsWK9Bg_bo=kC9C_8EnLpoVJKtqg0ca8gv1YdrffQSAw@mail.gmail.com>
 <d9b7499f-f462-79b3-e9e8-25a14a3b538d@redhat.com>
 <840c34e7-0f5c-89fa-2dfa-f8de3da4d643@ilande.co.uk>
 <7e596b48-c631-34d5-2b63-0aac1922de93@kaod.org>
 <2bc2ca94-c1ba-a9de-0b81-6f9d3d4ad333@redhat.com>
 <bfbfafe6-1a28-8514-a3bb-cf289c7b7200@ilande.co.uk>
 <1f6e63f1-d17d-c81c-cecb-3d9129c24360@redhat.com>
In-Reply-To: <1f6e63f1-d17d-c81c-cecb-3d9129c24360@redhat.com>
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

On Thu Jun 29, 2023 at 7:05 PM AEST, C=C3=A9dric Le Goater wrote:
> On 6/29/23 10:29, Mark Cave-Ayland wrote:
> > On 28/06/2023 08:17, C=C3=A9dric Le Goater wrote:
> >=20
> >>>>>> qemu-system-ppc.exe -M mac99,via=3Dpmu -cdrom C:\mac-iso\9.2.2.iso=
 -boot d -L pc-bios
> >>>>>> crashes Mac OS with an address error. (with unpatched and patched =
builds).
> >>>>>
> >>>>> Same on Linux. I get an invalid opcode. QEMU 7.2 work fine though.
> >>>>>
> >>>>> C.
> >>>>
> >>>> That certainly shouldn't happen, and if it worked in 7.2 then there'=
s definitely a regression which has crept in there somewhere. I'll try and =
bisect this at some point soon, but feel free to try and beat me ;)
> >>>
> >>> bisect points to :
> >>>
> >>> commit e506ad6a05c806bbef460a7d014a184ff8d707a6
> >>> Author: Richard Henderson <richard.henderson@linaro.org>
> >>> Date:=C2=A0=C2=A0 Mon Mar 6 04:30:11 2023 +0300
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 accel/tcg: Pass last not end to tb_invalidat=
e_phys_range
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 Pass the address of the last byte to be chan=
ged, rather than
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 the first address past the last byte.=C2=A0 =
This avoids overflow
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 when the last page of the address space is i=
nvolved.
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 Reviewed-by: Philippe Mathieu-Daud=C3=A9 <ph=
ilmd@linaro.org>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Richard Henderson <richard.he=
nderson@linaro.org>
> >>>
> >>> =C2=A0=C2=A0include/exec/exec-all.h=C2=A0=C2=A0 |=C2=A0 2 +-
> >>> =C2=A0=C2=A0accel/tcg/tb-maint.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 31 +=
+++++++++++++++---------------
> >>> =C2=A0=C2=A0accel/tcg/translate-all.c |=C2=A0 2 +-
> >>> =C2=A0=C2=A0accel/tcg/user-exec.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +=
-
> >>> =C2=A0=C2=A0softmmu/physmem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> >>> =C2=A0=C2=A05 files changed, 20 insertions(+), 19 deletions(-)
> >>>
> >>>
> >>> I think the instruction is fnmadds. Needs more digging.
> >>
> >> the invalid opcode is just a symptom of something bad happening.
> >>
> >> C.
> >=20
> > Indeed, it appears to be a copy/paste error within that commit. I've ju=
st posted a proposed fix for this: https://lore.kernel.org/qemu-devel/20230=
629082522.606219-1-mark.cave-ayland@ilande.co.uk/T/.
>
> Looks good. I could boot macos 9.2.1 from an iso and 9.2.2 from disk.
>
> > Nick: you may wish to try your series again with this fix applied to se=
e if there are still problems with the CPUs used in the Mac machines.
>
> Looks good too, with these :
>
>   [PATCH v2 1/4] target/ppc: Machine check on invalid real address
>   [PATCH v2 2/4] target/ppc: Move common check in machine check
>   [PATCH v2 3/4] target/ppc: Make checkstop actually stop the system

In the v2 series I removed the machine check for 970 btw so there
might still be invalid memory access.

Thanks,
Nick

