Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5D3744865
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:11:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXZG-0007yl-B8; Sat, 01 Jul 2023 06:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qFXZD-0007xO-WD; Sat, 01 Jul 2023 06:11:00 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qFXZB-0007mH-VA; Sat, 01 Jul 2023 06:10:59 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3456fda4ed1so13106695ab.0; 
 Sat, 01 Jul 2023 03:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688206256; x=1690798256;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uv9EPkTuwkw/ofplV8Yr7/QP/w7XdI0ael8JiBSfQRA=;
 b=iqey0fIIMpScHacf/McnKGP+Vz7qD8Pqf04qnxrqR1/162LxvoCc2e/9MybsKADMM8
 mwmUUhM5u5fMk1gGtlIlXMvb/hAWZv8h472eNlP0RKZVyDBmVHgv9h/eqlfwP5iaHR1o
 TcGKzsG0hUAv0vTgi6ZaA2eZLDj1PTfMGLj3h8/hZL+9TLGqk0QEiO61ouxlyLSd0/We
 au2xEiHKfjozExUZnh1HkjK93sA1OYcaWZVXeTWvCfip/HxqM5DqKG5iqC8/cjZrEDAH
 s+qzQw9Y9NHDZoxnK960+RCRpd9ytpsmpvWKfDFSwQBpNEQj2NfEb2FXLJzVJxZ24ksn
 caqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688206256; x=1690798256;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uv9EPkTuwkw/ofplV8Yr7/QP/w7XdI0ael8JiBSfQRA=;
 b=hQmIX0puU7ksaK+kbuHppzjpX9ouD5gO/NzfH4SZE8OXytAIC0nuP7/3fFsHvYhG52
 Nlpge5gO5vJs2azFpNyP2JqSA+zCVVitSVj+buw1RvpSu7t3b32kVzbHQTgD7/6Soj11
 4B7KYGKTGSeNsdsLFSkcyb5saIosqDlY3Y/98y0bQy+uob1w0dsiVFRyYv9fAIOy3o1t
 RAZ9/2x2pUYwhHtUxXOK0+4zrBFw4RN914nkkGAEPMxzh1LLbGpRjcDp7Y2KT2ZNBrnw
 lkoKiOlE05Q25Cr+cQHyKsStnf5BbcjG/5UTW8PyT+F2/pX3BjrQ27G+rAmJL6CkZ4l5
 S88A==
X-Gm-Message-State: ABy/qLYUjRvpAUG06lGmyEfSCC59uKZ9UrOTxDq4x7hfzp+RbMN8utly
 6FMdVc/vqv1NRQTEpcYbPr8=
X-Google-Smtp-Source: APBJJlFX60PXCf95vMf1JSiTz+sSuwWG/RlvoyoEXfcTRoaRf8OMCeoTQ7ngO3iXFzN/PahSml4n3g==
X-Received: by 2002:a92:d48e:0:b0:345:aba5:3777 with SMTP id
 p14-20020a92d48e000000b00345aba53777mr4958285ilg.25.1688206256279; 
 Sat, 01 Jul 2023 03:10:56 -0700 (PDT)
Received: from localhost (220-244-154-206.tpgi.com.au. [220.244.154.206])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a63e607000000b004fab4455748sm11832416pgh.75.2023.07.01.03.10.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 03:10:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Jul 2023 20:10:51 +1000
Message-Id: <CTQR655TPDZR.1BIPQKV0ERXJR@wheely>
Subject: Re: [PATCH 0/4] ppc/pnv: Extend "quad" model for p10
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Joel Stanley" <joel@jms.id.au>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230630035547.80329-1-joel@jms.id.au>
In-Reply-To: <20230630035547.80329-1-joel@jms.id.au>
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x136.google.com
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

On Fri Jun 30, 2023 at 1:55 PM AEST, Joel Stanley wrote:
> The quad model implements the EC xscoms for the p9 machine, reusing the
> same model for p10 which isn't quite correct. This series adds a PnvQuad
> class and subclasses it for P9 and P10. Implement the core thread state
> xscom as an example. I expect more function to be implemented in future
> patches.
>
> There's one outstanding question. Skiboot has this for the p10 scom:
>
>  #define P10_EC_CORE_THREAD_STATE        0x412
>
> However the read that comes is for 0x28412. I suspect the upper 0x28000
> are addressing bits, so we're really reporting the core thread state for
> the given core. Should the model instead wired so one is created for
> each chiplet? Or should we report the value for all possible cores, like
> the P9 code does for P9X_EX_NCU_SPEC_BAR?
>
>     switch (offset) {
>     case P9X_EX_NCU_SPEC_BAR:
>     case P9X_EX_NCU_SPEC_BAR + 0x400: /* Second EX */

Yes you're right, 0x28000 is addressing within the quad. The 0x2 selects
core/cache/NCU/etc and the 8 is a one-hot encoding to select the core.

So this access should actually be redirected to the pnv core scoms. I
think to make that work, those regions have to be a subregion of the
quad, right now they seem to overlap (the sizes are a bit wrong too,
they end up overlapping).

0x412 is then a register in a particular core's "PC" unit. I assume PC
is probably 0x800 or 0x1000 in size.

The quad itself has a QME engine, so you might address that with the
quad registers.

IIRC the actual topology is something like

EQ +--- EX +--- ECL2 +--- EC
   |       +--- L3   +--- L2=20
   +--- QME          +--- NCU
   +--- maybe some scom and sensor stuff

No point modeling all that of course, just per-core and per-quad regions
like it already has for now. But if for example we wanted to model some
registers in the L2, it would not be contiguous with the core addresses
so we'd have to add it.

Thanks,
Nick

>
> Joel Stanley (4):
>   ppc/pnv: quad xscom callbacks are P9 specific
>   ppc/pnv: Subclass quad xscom callbacks
>   ppc/pnv: Add P10 quad ops
>   ppc/pnv: Return zero for core thread state xscom
>
>  include/hw/ppc/pnv_core.h |  12 +++-
>  hw/ppc/pnv.c              |  11 ++--
>  hw/ppc/pnv_core.c         | 114 +++++++++++++++++++++++++++++++-------
>  3 files changed, 113 insertions(+), 24 deletions(-)


