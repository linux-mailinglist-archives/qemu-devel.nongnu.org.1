Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C0183880D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 08:37:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSBL1-00014K-O4; Tue, 23 Jan 2024 02:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rSBKx-00013o-OL; Tue, 23 Jan 2024 02:36:47 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rSBKv-0001FP-Hs; Tue, 23 Jan 2024 02:36:47 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d76943baafso6684135ad.2; 
 Mon, 22 Jan 2024 23:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705995403; x=1706600203; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x9xIuFubM+QfJ7vDMGFwez8k3NzBS+Eqm1HtFax8zXE=;
 b=EEdCVg/CnsZynow8HsRcckIdb4LvgFWrTLl0jkPMvfchhq9dsk8gBqWJ6tcPNVsAEp
 In0vuwORwGtjeK1KVErxjdlrvs9XNpEy8vQgKkbfpezx8Xc/WXorHvlBekHjjShascOf
 +af/gDekU9ZMURraAkAd3ovNw/4eQK7V94nYQB9iHFMJXRdu/TmWDUP1iA/deFrTdRZa
 T4JgnWOPnCk0Sf+TL+WGG6vG/NMBsb4Lx4EmQl5d5RS/t/1g1X+EnQTvquuJAcF2f/Xp
 TuK6pmA8sL6AHVSWD78eCZR6GSiLv5BSh9QWXPQg/LGN9dwtEtzEEZvxPNb6+N1OWzp6
 32rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705995403; x=1706600203;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x9xIuFubM+QfJ7vDMGFwez8k3NzBS+Eqm1HtFax8zXE=;
 b=igcy+eEGegC7AdFScWyACVb0EOQV1qYwXVgrTqGVY7prFU35eg3nTkneO6bI1pKge6
 C5D4LXmS3/Kx3P8sn8EyRRTliwtARd+wiFbquMJOr8NfPwbw4zTbiTgwCV19Nc6J8NGa
 A9yFO3D1JE2FPTm5UNy3CadDrw462jtYkEHqem7aA40UZ/pdm2NYYrjoN31bB0IxOoaa
 hV7/guD/vnOnCgsGe6Vi8QOAsubKLKGNm116YJJYJXk2vmiIGsun2+CMXi/NToOWU85p
 7Q7reEwQhJnPI5jU/5guf6EieBkQmwnCEdl52lw/8kej/UaPAGs41o7RvQl1bWVZU2g+
 r9ug==
X-Gm-Message-State: AOJu0Yz8qtmdLgPrTpjBZuBYnuLwZrPpEaYr9SC9DoA0vnCa59lCsppw
 ZUSMF8c+WktGQAurKgfyLo5eKHTwS98hhwWCRR+tL7TVtNDga4X8
X-Google-Smtp-Source: AGHT+IEQgc7cALziifYTlptEKdDMH3UOdjcPIcwjzZvHCLNOTA9hvSVOU0XFnZEVtS5AHDzH+1TMDw==
X-Received: by 2002:a17:903:22c9:b0:1d4:5fdb:59f9 with SMTP id
 y9-20020a17090322c900b001d45fdb59f9mr3366297plg.127.1705995403431; 
 Mon, 22 Jan 2024 23:36:43 -0800 (PST)
Received: from localhost ([1.146.79.133]) by smtp.gmail.com with ESMTPSA id
 u19-20020a170903305300b001d714a6eff7sm7252285pla.80.2024.01.22.23.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 23:36:43 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 17:36:37 +1000
Message-Id: <CYLWWAEWNXN2.1TJLV7UOK9M6R@wheely>
To: "Thomas Huth" <thuth@redhat.com>, "Junho" <junho920219@gmail.com>,
 <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>
Subject: Re: How can I know Page Table address on RAM?
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <CACrrvNSKQ1du+f40RvcDCvhjojvvDSsHi0FyWoJMMBtt8R+Q3A@mail.gmail.com>
 <20754e51-3100-4eab-a04d-110ca229a38b@redhat.com>
In-Reply-To: <20754e51-3100-4eab-a04d-110ca229a38b@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

On Mon Jan 22, 2024 at 6:54 PM AEST, Thomas Huth wrote:
> On 22/01/2024 05.11, Junho wrote:
> > Hello,
> >=20
> > I'm a QEMU user with PowerPc target architecture.
> > I have some personal modifications related to tb jmp cache and chaining=
=20
> > logic to improve the performance of a specific guest code. To verify th=
e=20
> > safety, I have to guarantee that the page table on RAM does not change =
after=20
> > initialization. Do you have any information related to this work? Curre=
ntly,=20
> > what I need to find is the page table start address on the RAM so that =
I can=20
> > test with the range detected.
> >=20
> > I look forward to your response.
> >=20
> > Thank you
> > Junho
>
>   Hi,
>
> maybe it's best to ask this question on the qemu-ppc mailing list instead=
=20
> (done now), since most PPC folks will rather read than one instead of the=
=20
> high-traffic qemu-devel mailing list.

Hi Junho,

ppc targets have a lot of different MMUs, so it depends what you are
looking at.

The hash MMU has a page table that is linear in physical (real) memory,
so you might feasibly be able to watch it for updates. The SDR1 SPR has
hash table base and size. ISA v3.0 and later use an in-memory table
that is pointed to by the PTCR SPR.

Other types are software loaded and radix page tables which might be
infeasible or impossible to really track.

It would be interesting to know what kind of modifications you're doing,
it's possible they might be achieved another way. For example, there is
no requirement in the architecture for the TLB to be kept coherent with
page table modifications, so you might be able to watch for TLB flush
instructions rather than page table changes.

Thanks,
Nick

