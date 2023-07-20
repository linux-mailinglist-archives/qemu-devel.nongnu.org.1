Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0211075B517
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:58:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMWwx-0006uN-NQ; Thu, 20 Jul 2023 12:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMWwu-0006u3-Rh
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:56:20 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMWwt-0004at-4k
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:56:20 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5216569f9e3so1456807a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689872177; x=1690476977;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TrIYzqALrOSGanJz4cMckuEd1b5FwV1mYa1dVb0hydg=;
 b=aYftpLTk1LafghUNVzV+TgYQR31Amuu33FlhWHhWcZqxBDRyyx+C055SXz874/vCLj
 hWVEbT/E7RHhkWuV/FpgkvGcmAtyQLtvMXX6dcmvlq2XmFle342y1moLe2bsdS9uAh1T
 9BZNmSyVYIlMrMwr24S6sltx9nQfjxnMBGcyh1Ocyv4q6k5KbXfyvr/ePVAbmqyOM41g
 gWe4BTl1hYRp3yIpPMhlBO/NojSTThlaEwte3LoZKBpsP6caSEpn/KP/gkAloTgqq0L0
 hYD3GTACB2H+Btzg4XvlDpAV6eJnB3MqWLZP0NR5Bw+A0brzyTimUKTredP4YYkll6hX
 rbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689872177; x=1690476977;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TrIYzqALrOSGanJz4cMckuEd1b5FwV1mYa1dVb0hydg=;
 b=NctFd83vqmman0Vne1Oce62f7TfHBpYQIxHlaV1Vt3CwaMbCdPThZzbrc4SpIXTZs7
 WjTemKlm4cDFdJnrkJWZxMS2Ifvid3Eqc9YMXFpE5S8IuWnYTk3Mv28NTT0MqSk50hJX
 xTJ3kYV46dSVdQI7nZKN8qqw7fa5kVRES8Cs4o9sllKMYdA+D/yCDviScxPAmhy6jbSv
 TYClXGLT/l4sNLc23fg2MSZ7y58FFPa6FCcgD0N+vsdG5z5Ft96NkZp7+IbsN0bdCyNV
 ZtiXShpddxbUAdkvsahTavef4jdhSPDmqKPRhaE1Nn9N0of832f/+WrM2G56fe0CvxuN
 TVLw==
X-Gm-Message-State: ABy/qLbMDfKOtOyNR7LE05ktp2rNCQocFvmjV6Cs4ubBQzHArbmTGjdl
 fhqO3yUppwYqY8E2C9Ys5zI7bczS0S2xkQEm4fgK1A==
X-Google-Smtp-Source: APBJJlH3BTKSLNRn8PRzSCVxqAs/lkWiQl1RATy5OTITXRJ9SztPx/kft3bFB1txmNbe/dO3jowf4B5BOqA0O51ssXY=
X-Received: by 2002:aa7:cd63:0:b0:51d:979d:623a with SMTP id
 ca3-20020aa7cd63000000b0051d979d623amr5428827edb.28.1689872177419; Thu, 20
 Jul 2023 09:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230719153018.1456180-2-jean-philippe@linaro.org>
 <20230719153018.1456180-5-jean-philippe@linaro.org>
 <CAFEAcA8e_-r6b4iaeDUv64iydFe7iAb4Y0eObyO4tUYizcYLVA@mail.gmail.com>
In-Reply-To: <CAFEAcA8e_-r6b4iaeDUv64iydFe7iAb4Y0eObyO4tUYizcYLVA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2023 17:56:06 +0100
Message-ID: <CAFEAcA-ja9Wfwr2w+iue976FbQ-FTF3yL9WS7t9zDeo-FEo0iw@mail.gmail.com>
Subject: Re: [PATCH 3/5] target/arm: Skip granule protection checks for AT
 instructions
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 20 Jul 2023 at 17:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 19 Jul 2023 at 16:56, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > GPC checks are not performed on the output address for AT instructions,
> > as stated by ARM DDI 0487J in D8.12.2:
> >
> >   When populating PAR_EL1 with the result of an address translation
> >   instruction, granule protection checks are not performed on the final
> >   output address of a successful translation.
> >
> > Rename get_phys_addr_with_secure(), since it's only used to handle AT
> > instructions.
> >
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > This incidentally fixes a problem with AT S1E1 instructions which can
> > output an IPA and should definitely not cause a GPC.
> > ---
> >  target/arm/internals.h | 25 ++++++++++++++-----------
> >  target/arm/helper.c    |  8 ++++++--
> >  target/arm/ptw.c       | 11 ++++++-----
> >  3 files changed, 26 insertions(+), 18 deletions(-)
> >
> > diff --git a/target/arm/internals.h b/target/arm/internals.h
> > index 0f01bc32a8..fc90c364f7 100644
> > --- a/target/arm/internals.h
> > +++ b/target/arm/internals.h
> > @@ -1190,12 +1190,11 @@ typedef struct GetPhysAddrResult {
> >  } GetPhysAddrResult;
> >
> >  /**
> > - * get_phys_addr_with_secure: get the physical address for a virtual address
> > + * get_phys_addr: get the physical address for a virtual address
> >   * @env: CPUARMState
> >   * @address: virtual address to get physical address for
> >   * @access_type: 0 for read, 1 for write, 2 for execute
> >   * @mmu_idx: MMU index indicating required translation regime
> > - * @is_secure: security state for the access
> >   * @result: set on translation success.
> >   * @fi: set to fault info if the translation fails
> >   *
> > @@ -1212,26 +1211,30 @@ typedef struct GetPhysAddrResult {
> >   *  * for PSMAv5 based systems we don't bother to return a full FSR format
> >   *    value.
> >   */
> > -bool get_phys_addr_with_secure(CPUARMState *env, target_ulong address,
> > -                               MMUAccessType access_type,
> > -                               ARMMMUIdx mmu_idx, bool is_secure,
> > -                               GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
> > +bool get_phys_addr(CPUARMState *env, target_ulong address,
> > +                   MMUAccessType access_type, ARMMMUIdx mmu_idx,
> > +                   GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
> >      __attribute__((nonnull));
>
>
> What is going on in this bit of the patch ? We already
> have a prototype for get_phys_addr() with a doc comment.
> Is this git's diff-output producing something silly
> for a change that is not logically touching get_phys_addr()'s
> prototype and comment at all?

Looking more closely, that does seem to be what's happened, so

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

