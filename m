Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 420D7716A6B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 19:03:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42kg-0005IJ-83; Tue, 30 May 2023 13:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q42kN-00052C-8E; Tue, 30 May 2023 13:03:05 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q42kI-00078p-S3; Tue, 30 May 2023 13:02:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 820A36111C;
 Tue, 30 May 2023 17:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61ADC433A0;
 Tue, 30 May 2023 17:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685466170;
 bh=bZixs7nkFVC8ORerRLmRoiL6KtRrGjYzvtjjGE4ZH0E=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=MMoJVDWMjFoDHhVqgzj5lQBTF+bwW3UpchbmOwQcb9PT9fjXNE1CMQUBAHImhe4n9
 GPgJPNZEpyiw1yaEgEHy5L6gClYuIO8ODBHDyAZQrElv3JExRswFV7F4v4l7F8h6S3
 H5eLhzCp4HL59b+jzcyI/XexyTIXRZSAtQDSPmGtyzrFuw632NN5Qu3Hc12llsPJTl
 agfU9c7bTXuDKFcbG7yutgqGqpirN4sDRrZzkJJtcy80bXzRWIJ54gRmn3SDZFefGK
 +FrUy591JmRzZdZ4Up5bmUHcae4y7sl4y8ToRJWQGWdgtkf/cm3shRWk+kLrUR1de6
 kgOmAb8dSpyLg==
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-2af29e51722so51697701fa.1; 
 Tue, 30 May 2023 10:02:50 -0700 (PDT)
X-Gm-Message-State: AC+VfDzxowDm/Undrg/aImXwBsZh65Dm0/ErlLHGNxcJyYBYiHqp2oyn
 kvGLtac7lGdGYEwzDHG9Jl8hQe6raxCitZRuqFk=
X-Google-Smtp-Source: ACHHUZ7UzWymoWGffUas/RiF+LF6NZl5JZAtdTFvXzmooNX2mwc21/xi8tRIWIqSaDl4I/egh6Hy5l7Fsmz2pSuoXpE=
X-Received: by 2002:a2e:9f0d:0:b0:2ac:7889:3aa3 with SMTP id
 u13-20020a2e9f0d000000b002ac78893aa3mr1253687ljk.18.1685466168935; Tue, 30
 May 2023 10:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230530135204.2903761-1-ardb@kernel.org>
 <CAFEAcA-RwXQWx4RhMhWk_xQLsJ0a1+MDKDXyKHdCmguqsuNKzQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-RwXQWx4RhMhWk_xQLsJ0a1+MDKDXyKHdCmguqsuNKzQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 30 May 2023 19:02:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFMnsAnXcUgnZjncwa8h0eHeJfR2F1dxMn=-sHrErQr-Q@mail.gmail.com>
Message-ID: <CAMj1kXFMnsAnXcUgnZjncwa8h0eHeJfR2F1dxMn=-sHrErQr-Q@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: use x86 intrinsics to implement AES
 instructions
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 30 May 2023 at 18:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 30 May 2023 at 14:52, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > ARM intrinsics for AES deviate from the x86 ones in the way they cover
> > the different stages of each round, and so mapping one to the other is
> > not entirely straight-forward. However, with a bit of care, we can still
> > use the x86 ones to emulate the ARM ones, which makes them constant time
> > (which is an important property in crypto) and substantially more
> > efficient.
>
> Do you have examples of workloads and speedups obtained,
> by the way?
>

I don't have any actual numbers to share, unfortunately.

I implemented this when i was experimenting with TPM based measured
boot and disk encryption in the guest. I'd say that running an OS
under emulation that uses disk encryption would be the most relevant
use case here.

Accelerated AES is typically at least an order of magnitude faster
than a table based C implementation, and does not stress the D-cache
as much (the tables involved are not tiny).

