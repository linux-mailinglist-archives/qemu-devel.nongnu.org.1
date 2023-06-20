Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F527371F0
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:42:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBeQA-0003if-K8; Tue, 20 Jun 2023 12:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBeQ6-0003i3-PU
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:41:31 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBeQ5-0002Le-3d
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:41:30 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5186a157b85so6813303a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687279288; x=1689871288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gLInNtPN0vC6dKWb43kvEsfo/g0LGqljKuSCRcS4h6k=;
 b=h9iAB0c4WSq6kYSah46GKggocaU+lmUQWaWDfmD11uymTeYeLnmM/IDxndxLO2TRWd
 FKB+DvS4DxACxrv3xXjfqhoHBgzbsFO8a7ElHPflZ9+FLrbh5+qnySUKsn1C5fHwEC1G
 EfhNkWAyNtv0zayBS3nbCXLyb+bq2CwyLmofhBn1G/HIZ+XWBOPrIkyqT4keVIRmjxb2
 erq6ilNrPHKd+8u/epEZtHrF5K3vz/Pu3Ssccp1WcNkFvafkVEHnMg89oV0JIlsuBWee
 XXmIeGjHXj5XhqM8pibIZZKJO6QwYpeiJFfafsa+DkKR33K9RQ2PM+kfY9Ia0L2Ai13h
 0xNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687279288; x=1689871288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gLInNtPN0vC6dKWb43kvEsfo/g0LGqljKuSCRcS4h6k=;
 b=UkpjYIecSgk1ZtL7pfe/IHl+VTNgQVI4WCd93IkmJvNcpR6yYSN+4dGELTaHS9J33G
 gS59iJ2yDae/ZXv4cWEcDhhK66fH7obQhHg19cdpvaJvUEVb2uQWUfcWvFPxK/7NBze3
 V6j80dZjF/3Gk5Uc2y8FEtaqPOSEnJ9p7kfwcYi1KEA/jrVkn9YsIs6NFMfx6Lc/bIRq
 JienyMdBKLcce/SuDWsQ9PKqWrmg4urJRUWzLopWIIjElQoK9R5EKTccNWH0rOXWkx8F
 9reRf7RBoYd/7iTzUdRQhO0PWGv/FOzKyDOOIEZP2d662PX6yDreaewMU4Zy98g+QV5B
 HkWw==
X-Gm-Message-State: AC+VfDw3RFNp3B4HhdTDx35t3kaVSAZJ5gVKDkF8Iw3jWoGWtzdxjKwH
 CowW8g1Oc3t+6GH3fkxyT8k4AQp/Vo6p8vQOeyi2DQ==
X-Google-Smtp-Source: ACHHUZ55ovVaqMnZyzeQFrFjHBKDtShK00jgFs4PqdotBVhh57+pgsLZtMY83xwxX3CZOqSrDHYTNxp5jvf+XZquo8Q=
X-Received: by 2002:aa7:c2c9:0:b0:51a:5ac3:4df3 with SMTP id
 m9-20020aa7c2c9000000b0051a5ac34df3mr4776713edp.5.1687279287774; Tue, 20 Jun
 2023 09:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230620124418.805717-1-richard.henderson@linaro.org>
 <CAFEAcA91RPvuC_GArpu=x3rEpv1-HsfdEOTGf50N7VY9ZwgtjA@mail.gmail.com>
 <66f83d87-6314-8173-cfb5-47917584a1ee@linaro.org>
In-Reply-To: <66f83d87-6314-8173-cfb5-47917584a1ee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2023 17:41:16 +0100
Message-ID: <CAFEAcA_ckBzGz2rqgntF7m6D8-T3oAk=z00ASc6iF_nSav+RZw@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] target/arm: Implement FEAT_RME
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 20 Jun 2023 at 17:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/20/23 17:57, Peter Maydell wrote:
> > On Tue, 20 Jun 2023 at 13:46, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Changes for v5:
> >>    * Enabled only by cpu property x-rme=on, not -cpu max.
> >>    * Rebase vs SecEL2 fixes, now in master.
> >>
> >> This doesn't have the magic RMM memory, which previous patch sets
> >> included for booting Huawei's forked TF-A.  Upstream TF-A does not
> >> have sufficient code to build either PLAT={qemu,qemu_sbsa} with
> >> the RMM enabled, so that can't be tested either at the moment.
> >>
> >> All I can say is that this doesn't appear to break anything else
> >> with x-rme=on.  Which is less than satisfying.
> >
> > Have you tried 'make check-tcg' ? I get:
> >
> > make: Leaving directory
> > '/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang'
> > make: Entering directory
> > '/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang'
> >    BUILD   arm-softmmu guest-tests
> >    RUN     arm-softmmu guest-tests
> >    TEST    test-armv6m-undef on arm
> >    BUILD   arm-linux-user guest-tests
> >    RUN     arm-linux-user guest-tests
> >    TEST    semihosting on arm
> >    SKIPPED semiconsole on arm because MANUAL ONLY
> >    TEST    convd on arm
> >    DIFF    float_convd.out with
> > /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/tcg/arm/float_convd.ref
> >    TEST    convs on arm
> >    DIFF    float_convs.out with
> > /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/tcg/arm/float_convs.ref
> >    TEST    madds on arm
> >    DIFF    float_madds.out with
> > /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/tcg/arm/float_madds.ref
> >    TEST    munmap-pthread on arm
> > **
> > ERROR:../../plugins/core.c:221:qemu_plugin_vcpu_init_hook: assertion
> > failed: (success)
> > make[1]: *** [Makefile:174: run-munmap-pthread] Error 124
> > make: *** [/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/Makefile.include:56:
> > run-tcg-tests-arm-linux-user] Error 2
> > make: Leaving directory
> > '/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang'
> >
> > But I haven't run 'check-tcg' recently, so maybe that's an
> > existing bug rather than something in this series.
>
> Not today -- I only tried system mode because, obviously.  :-)
> Let me double-check...

I get the same error on current head-of-git, so whatever it
is it's not this patchset's fault.

thanks
-- PMM

