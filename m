Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E8973CFAC
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 11:19:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDLth-0003jn-Qj; Sun, 25 Jun 2023 05:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDLtf-0003hY-Es; Sun, 25 Jun 2023 05:19:03 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDLtd-0004Ir-Ni; Sun, 25 Jun 2023 05:19:03 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-39ec45b22f6so1646088b6e.0; 
 Sun, 25 Jun 2023 02:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687684740; x=1690276740;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJf+voi6N+YE8Sch4FS4fD8XrRSVJhfO0na4gXb66tM=;
 b=Jqv5Z/D48TqFQhiAv+fc0FgSIPohyydVnrzlvOM3nbStkOtvXfMr1nQCFhjgyKti1N
 lqdvdEkLrJtPyMDwmLTLEU9wJMpJbDc7W+BYP5QT1g6h6iASFa4j+fUSTDs3IaSs1tM9
 J1ARcVdIUp/AeGxtlXovRtb2mxgZf4sjo9W1d2dh5RF9T72JIa/KTY/xR5DHPIZhB2sk
 +vsgpieBA212rLaKCTQSzCpNPtIcMu3v82H954gikRo8qkvVTh4LD0JekqSKZ5/+4Doe
 id9H1qNgdsxrd9JI7dClXRMWCyhqNyKF4TmuMq4R67x4M2oGZo8zQStcQ3Q44MFlhwFK
 TPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687684740; x=1690276740;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TJf+voi6N+YE8Sch4FS4fD8XrRSVJhfO0na4gXb66tM=;
 b=UB4NtFioO3o+Pin1ElRDWj7/a2RPmBIqa844VoA6sMmUmIEOJjkqr/8nvURHCMjEfO
 JW9gfaXNSIvFq3x+E6E77r3XXLf+Rd39gpovuS6GQ/+pPX0GQlK2j3ug+ClXCrDwNKbG
 oDpfx3nfS/HZbnSz3KiPcuX7TPGf/j/TDBY1SvK+UDG5bDWzeXL3/U+UAmNn2XoMIz/W
 JHnLa4qXQBcXJJmdyoUiYA08PQ822iZUJw3xv9iQ8eWN4uCWRzg6C+XL8ruL1RBNoN0/
 NsXLBJ/4SjJLf3fWpdilKFwRHBs0jzcyqquIQTcM19IDqCdtpIdnRcipIlCzjsum/OeE
 qNFQ==
X-Gm-Message-State: AC+VfDzaV6FUZQKBeyHIgQ3NvRc3xSS9pF5PNXPgL7yDeZ0ofJW0Gk+j
 3ax6b9RHOjoa+rkFpJ+jKiE=
X-Google-Smtp-Source: ACHHUZ5N4RRdDHRAM/5ufkfYGJSqabXcikKI6VWSk76TFB0H597CrEb72y6KH74CzrdPjY8AYmYdwg==
X-Received: by 2002:a05:6808:179c:b0:3a1:b50d:6c9 with SMTP id
 bg28-20020a056808179c00b003a1b50d06c9mr7503182oib.7.1687684740218; 
 Sun, 25 Jun 2023 02:19:00 -0700 (PDT)
Received: from localhost (193-116-198-102.tpgi.com.au. [193.116.198.102])
 by smtp.gmail.com with ESMTPSA id
 ip4-20020a17090b314400b0025374fedab4sm4095370pjb.22.2023.06.25.02.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jun 2023 02:18:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Jun 2023 19:18:53 +1000
Message-Id: <CTLMB3E3JHJ2.FXPTKDYPPTJO@wheely>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, "Christophe Leroy"
 <christophe.leroy@csgroup.eu>, "BALATON Zoltan" <balaton@eik.bme.hu>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Peter Maydell" <peter.maydell@linaro.org>
X-Mailer: aerc 0.15.2
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
In-Reply-To: <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x231.google.com
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

On Fri Jun 23, 2023 at 7:10 PM AEST, Peter Maydell wrote:
> On Fri, 23 Jun 2023 at 09:21, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > ppc has always silently ignored access to real (physical) addresses
> > with nothing behind it, which can make debugging difficult at times.
> >
> > It looks like the way to handle this is implement the transaction
> > failed call, which most target architectures do. Notably not x86
> > though, I wonder why?
>
> Much of this is historical legacy. QEMU originally had no
> concept of "the system outside the CPU returns some kind
> of bus error and the CPU raises an exception for it".
> This is turn is (I think) because the x86 PC doesn't do
> that: you always get back some kind of response, I think
> -1 on reads and writes ignored. We added the do_transaction_failed
> hook largely because we wanted it to give more accurate
> emulation of this kind of thing on Arm, but as usual with new
> facilities we left the other architectures to do it themselves
> if they wanted -- by default the behaviour remained the same.
> Some architectures have picked it up; some haven't.
>
> The main reason it's a bit of a pain to turn the correct
> handling on is because often boards don't actually implement
> all the devices they're supposed to. For a pile of legacy Arm
> boards, especially where we didn't have good test images,
> we use the machine flag ignore_memory_transaction_failures to
> retain the legacy behaviour. (This isn't great because it's
> pretty much going to mean we have that flag set on those
> boards forever because nobody is going to care enough to
> investigate and test.)
>
> > Other question is, sometimes I guess it's nice to avoid crashing in
> > order to try to quickly get past some unimplemented MMIO. Maybe a
> > command line option or something could turn it off? It should
> > probably be a QEMU-wide option if so, so that shouldn't hold this
> > series up, I can propose a option for that if anybody is worried
> > about it.
>
> I would not recommend going any further than maybe setting the
> ignore_memory_transaction_failures flag for boards you don't
> care about. (But in an ideal world, don't set it and deal with
> any bug reports by implementing stub versions of missing devices.
> Depends how confident you are in your test coverage.)

Thanks for the background, interesting and helpful. So I think
it is the right place for powerpc BookS 64 to hook into. Point
taken about adding a global option for it. Will try to fix the
known problems first, maybe it won't be too hard.

Thanks,
Nick

