Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9967A9479
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:03:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJJV-0002Oy-Hq; Thu, 21 Sep 2023 09:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qjJEP-0003k6-Sm
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:56:35 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qjJEN-0001Ex-KX
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:56:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9C80D61E5B
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 12:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF49C4E661
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 12:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695297777;
 bh=if8V2JMGlxpLYmWhHfCzwOJbS+f+69rhI3/WPpNRtTI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=vONtci/u3cZfwXwdmRdb0Iug/aFB3MDpTbi5oy3RX7WUTCdx17evOQejzcoY8esaJ
 TNPyf5FCRfCT4veaBhv8l2P45wAk6Ju94a30n1yuun/6PSZv3Op5nARAsH30J5tJZD
 oDJvt2GjuCvrhTMp5JdthZWKk97TgXEiMLulkBC/eODjQ2lpSGo48kr9v6SInn0SJd
 ZUCGMn1TSQTaEy0YTKgyhXVcghQHWlqz4srDjuqje+gXfO92jL5bAmzYWtEuXTtzul
 2xZ/GWFO0IkPE9LNTAuyuB489GyQz1dHvoZKcvEGRjgUoRlKW1X4AAtva8Uh5bYo4d
 HlHXef7ltWD+A==
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2c135cf2459so2122331fa.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 05:02:56 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz1IzFIFoD3zfKjnLBp5cJI+H68ZFiihWSnSWdB5V68r8MvN6gZ
 0w6V/DHoMk69/k4ooO5vEId2eLPOGitPYuvKb4w=
X-Google-Smtp-Source: AGHT+IGJphnsDO/V4bxyK7pG7FfcOYufXP7FFVUmC6pS7esnWfGUsjR8Wy0u3MoXi8utAw5zAsbjZGHYkNWN9FadFlY=
X-Received: by 2002:a2e:7a0d:0:b0:2bf:f84e:c1ec with SMTP id
 v13-20020a2e7a0d000000b002bff84ec1ecmr4959712ljc.13.1695297775232; Thu, 21
 Sep 2023 05:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_P5aOTQnM2ARYgR5WvKouvndMbX95XNmDsS0KTxMkMMw@mail.gmail.com>
In-Reply-To: <CAFEAcA_P5aOTQnM2ARYgR5WvKouvndMbX95XNmDsS0KTxMkMMw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 21 Sep 2023 12:02:43 +0000
X-Gmail-Original-Message-ID: <CAMj1kXETcFPr_rkuNizUxSxNTvhPDBa_3ZTjeHwYxbgjRY4NpQ@mail.gmail.com>
Message-ID: <CAMj1kXETcFPr_rkuNizUxSxNTvhPDBa_3ZTjeHwYxbgjRY4NpQ@mail.gmail.com>
Subject: Re: EDK2 ArmVirtQemu behaviour with multiple UARTs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, devel@edk2.groups.io, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Ard Biesheuvel <ardb+tianocore@kernel.org>, 
 Sami Mujawar <sami.mujawar@arm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Thu, 21 Sept 2023 at 10:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Hi; I've been looking again at a very long standing missing feature in
> the QEMU virt board, which is that we only have one UART. One of the
> things that has stalled this in the past has been the odd behaviour of
> EDK2 if the DTB that QEMU passes it describes two UARTs.
>
> I'm going to describe the behaviour I see in more detail below, but to
> put the summary up front:
>  * EDK2 puts some debug output on one UART and some on the other
>    (the exact arrangement depends on ordering of the dtb nodes)
>  * EDK2 doesn't look at either stdout-path or the serial* aliases,
>    so its choices about how to use the UARTs differ from those
>    made by the guest kernel it is booting (and it also seems to be
>    iterating through the dtb in the opposite order to the kernel)
>
> The current proposal for adding a second UART is that it only happens
> if you explicitly add one on the command line (with a second "-serial
> something" option), so whatever we do won't break existing user
> setups. So we have scope for saying "if you want to use a second UART,
> you're going to want a newer EDK2 which handles it better". Exactly
> what "better" means here is up for grabs, but honouring stdout-path
> and the serial aliases would be the ideal I think. It would also be
> possible to select a particular ordering for the DTB nodes to produce
> "least-worst" behaviour from an existing EDK2 binary, but I'm not
> sure if that's worth doing.
>
> What do the EDK2 folks think about what the correct behaviour
> should be for a 2-UART setup?
>

Hi Peter,

Thanks for the elaborate analysis.

EDK2's DEBUG output is extremely noisy, so being able to redirect this
output to a different UART would be very useful.

The stdout-path is the intended console, and so we should honour that.
This also means that we should parse aliases. But the console is
actually configurable [persistenly] via the UEFI menu, and so it would
be nice if we could take advantage of this flexibility. This means in
principle that the UARTs should be represented via different device
paths (which would include the base address so they are
distinguishable) with perhaps a magical alias which is the default and
is tied to whatever stdout-path points to. This way, all the logic we
introduce is spec compliant and reusable on physical platforms with
multiple UARTs.

The DEBUG output is a different matter. On physical hardware, this is
typically configured at build time, as the info is needed extremely
early and on a physical platform, the debug port generally doesn't
change. Currently, we just grab the first UART that we encounter in
the DT, but the logic used by the DEBUG code and the ordinary console
driver are mostly separate.

What we might do is use stdout-path as well, unless a certain DT alias
exist perhaps? We should probably align here with other projects,
although this a distinction of the same nature may not exist there.

-- 
Ard.

