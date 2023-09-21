Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B43387A9593
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 17:36:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjLhc-0001yF-V6; Thu, 21 Sep 2023 11:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjLha-0001y5-G5
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 11:34:50 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjLhY-0000xa-Su
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 11:34:50 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-530ce262ab2so1220498a12.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 08:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695310487; x=1695915287; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vrnpursJUmK4b5ucv9p1aLhIFHikMQ4PmzLXpkRJ7mQ=;
 b=MBlnIZluKL2aaArMMVFu33YnL5UwO1heLvmx2jSPqqUnse3G1Doi/JWWQGKMq3dbyl
 CAalrvdjXITGyQL/9WvjRURRfxOiqesghEgigwHIZF+V/igKeJ3+xWwuy0ZOxRU513lX
 OXwK3uXSji1NsqR5NuFh9rxfFsZTCLFYS0lZCXLKyBs/p6/pmENhWW6bvQY7oTJIGDo4
 rs0aRQxY53y+7a3y+YlZ1IafJq5nQhiagrhEkZtTzOGc3oK9DPL0hHRMjqYp3ptmWDeD
 CFe694TBO+YSbvAEIcd8GMTJ9zA4rpXpEyj1cdJRbP/s6RFIxJlE1CJBq5Tgu/zxlYuM
 Cn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695310487; x=1695915287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vrnpursJUmK4b5ucv9p1aLhIFHikMQ4PmzLXpkRJ7mQ=;
 b=hMHxuBNkyUYzviwY8zpRhtaZaZRnmOMTpw7Zw1Tc9G50wE0+SwlRSdpZ0Atc9QW53z
 P/q8tZ9oKzvq1X1bR12HuL+sQbWFoo9gymdGTkGl92xT93yrH/45uvPa4kbn1P6N1y62
 BZDlcv8dQUu7+q+0aDIe2iPMbAq7Urg+X9GaJNzH9G8uCVRC+yRRIkqLrCTmJVfDN5kt
 6jzhc4g/aIZc9CFXkCwBIIX58MvVGcERpU3f9aTjPMUsmGR4XIF4MKKEtpmEqSFKgIL1
 OYdMnRr6ay/GhOceNIfronfqq4H68kEzbuEl/v2djVEF6usoTfaU5LyVGpnpxvi6Vlsg
 RG3g==
X-Gm-Message-State: AOJu0YynNWeWPObf0rGnWW+t9jkA/yzibn89DJdmfc5mSSeobEcNXCAk
 vpYUXSQ9dkaEqV7ozxihacPoROq8x/57/5j9gobAOA==
X-Google-Smtp-Source: AGHT+IEwhSs3RR1HnAlbDw/MAxwRgMgT87bR+FVZT6N32waSAp/z7gudW7kART65XX6xJVAQ7R/ZhtT5cH3ZeBD3ut8=
X-Received: by 2002:aa7:ca46:0:b0:523:2e30:aaee with SMTP id
 j6-20020aa7ca46000000b005232e30aaeemr4755630edt.32.1695310486673; Thu, 21 Sep
 2023 08:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_P5aOTQnM2ARYgR5WvKouvndMbX95XNmDsS0KTxMkMMw@mail.gmail.com>
 <b7wuvs5qtdvjzb5getkggsi772gqvmb4xnuhq4ssxdu5lgiyi7@nprpol5z2t5u>
In-Reply-To: <b7wuvs5qtdvjzb5getkggsi772gqvmb4xnuhq4ssxdu5lgiyi7@nprpol5z2t5u>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2023 16:34:27 +0100
Message-ID: <CAFEAcA8LMmWTEJB3jsUEn_pPnUDanWgdUurFu=vRRFxn4X8S2Q@mail.gmail.com>
Subject: Re: EDK2 ArmVirtQemu behaviour with multiple UARTs
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, devel@edk2.groups.io, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Ard Biesheuvel <ardb+tianocore@kernel.org>, 
 Sami Mujawar <sami.mujawar@arm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 21 Sept 2023 at 16:26, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Sep 21, 2023 at 11:50:20AM +0100, Peter Maydell wrote:
> > Hi; I've been looking again at a very long standing missing feature in
> > the QEMU virt board, which is that we only have one UART. One of the
> > things that has stalled this in the past has been the odd behaviour of
> > EDK2 if the DTB that QEMU passes it describes two UARTs.
>
> Note that edk2 recently got support for virtio-serial, so you can use
> that for the console and leave the uart for debug logging.  The prebuild
> edk2 binaries in qemu have been updated days ago and these already
> support for virtio-serial..

As long as EDK2 does something sensible when the DTB says "two
UARTs here and here" and it also finds a virtio-serial PCI
device, I don't mind what exactly it does. The problem here is
more that EDK2 currently does strange things when told that
the hardware is present, rather than that anybody specifically wants
EDK2 to use multiple serial outputs.

Though given there's no way to say in the DTB "use a PCI card
for your console" I think the virtio-serial approach is likely
to be awkward for users in practice.

-- PMM

