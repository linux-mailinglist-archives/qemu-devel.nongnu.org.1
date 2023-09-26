Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E177AEAD7
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:55:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5iX-0000Kn-AY; Tue, 26 Sep 2023 06:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5iU-0000KM-Tl
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:54:58 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5iT-0004wB-8Y
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:54:58 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5345a3dfe3bso1657111a12.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 03:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695725696; x=1696330496; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V2glTBHJP7/FSMa9svQXV04jv0pEj1gaY/7UPynEdJw=;
 b=iM0yUizI6TfdAOTlx25UnzkRBk07AorqQBBLNwRbg3HuRH4xTuxRXWYCHl212lGuN4
 xUvvsamMVOBSET9f2Wo6X9jLMTBi5XJhR3a9WIruluVDgIg+y2fhhMyAOuCN1VGoee9l
 cHzacTE+E5vvKrl4auzMgDP6tObsKgJDxfOOEkfGVae7M6hZpfPPe/Y3PzDDpgbMYh4P
 bJAPLHuFIwGntKJRpVDoMlthVO7tdSCPzfaGcFS1z3x5pw+MV3URNu3VAT0aUE2w3Crq
 ZR5Mi8qbpoG4e0+K4/saHZVstGbMm1VSSJpYGa25BA+4x1zOhonznLYUHm+f5Ds/93Is
 fJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695725696; x=1696330496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V2glTBHJP7/FSMa9svQXV04jv0pEj1gaY/7UPynEdJw=;
 b=lvqwSEI88nlotrMs1G+++ConFqCAE01EJJnDF8KbPE7HVdApXM5UUa7URd3P6AzbJ5
 57YL1uL2bG8fPl4YktWbED8pKEt59fqbLqXkiiAu4+gEdLr6rZ3Eu8WYNIk8LSYvxNxL
 Jj2KgDyqScjBnzbntoHwc6XWdZ2CihfmurFYunTc0vxSNwZK6gCGO/jZscjWHPMoNvm5
 DLepe1gtLjkPq2aP5tQDA4xOGEulyYqHfA5PQv7+f+FHJNII3q+RUQbxQgm3KhCAO8Bl
 CYx2tTCPaUqcibI9BJIkeBMkTOFUKTe+8PIArCzvSPcVjqHBWQp11MFt7BM+Zy/xmCQN
 PB2g==
X-Gm-Message-State: AOJu0YxB1X7N3gra9Vu7WCBaOaj+7QDFSi4wvM9QfmB2lk8UfIGh09RF
 KqdJ1HC81O42GHIoDXUquLdxqEq4LBcF3ZlB21LQ7w==
X-Google-Smtp-Source: AGHT+IF0sZJ07RzhZrGdCr//CqoZFvyaLd8GcxHXe7l8YfUrBQYhHQZcegyvJ6L8D43wAzNPOcBC4XcsR4hmqW7M2gI=
X-Received: by 2002:a50:d716:0:b0:533:efc3:91b6 with SMTP id
 t22-20020a50d716000000b00533efc391b6mr6905809edi.11.1695725695890; Tue, 26
 Sep 2023 03:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-2-vsementsov@yandex-team.ru>
 <CAFEAcA8MeLs5fz+PjLsL351OHv3vr8+4_tnD97guZHXs76iTog@mail.gmail.com>
 <43de490c-3e66-0703-4cb7-2fba306fc970@yandex-team.ru>
In-Reply-To: <43de490c-3e66-0703-4cb7-2fba306fc970@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 11:54:37 +0100
Message-ID: <CAFEAcA9YT5q=M_udwypv6EYW4W0VbMCFYBGgrNZbyswfK44tLg@mail.gmail.com>
Subject: Re: [PATCH 01/12] hw/core/loader: load_at(): check size
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 26 Sept 2023 at 11:51, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 26.09.23 13:33, Peter Maydell wrote:
> > On Mon, 25 Sept 2023 at 20:41, Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> >>
> >> This @size parameter often comes from fd. We'd better check it before
> >> doing read and allocation.
> >>
> >> Chose 1G as high enough empiric bound.
> >
> > Empirical for who?
> >
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> >> ---
> >>   hw/core/loader.c | 17 ++++++++++++++++-
> >>   1 file changed, 16 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/core/loader.c b/hw/core/loader.c
> >> index 4dd5a71fb7..4b67543046 100644
> >> --- a/hw/core/loader.c
> >> +++ b/hw/core/loader.c
> >> @@ -281,11 +281,26 @@ ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
> >>
> >>   /* ELF loader */
> >>
> >> +#define ELF_LOAD_MAX (1024 * 1024 * 1024)
> >> +
> >>   static void *load_at(int fd, off_t offset, size_t size)
> >>   {
> >>       void *ptr;
> >> -    if (lseek(fd, offset, SEEK_SET) < 0)
> >> +
> >> +    /*
> >> +     * We often come here with @size, which was previously read from file
> >> +     * descriptor too. That's not good to read and allocate for unchecked
> >> +     * number of bytes. Coverity also doesn't like it and generate problems.
> >> +     * So, let's limit all load_at() calls to ELF_LOAD_MAX at least.
> >> +     */
> >> +    if (size > ELF_LOAD_MAX) {
> >>           return NULL;
> >> +    }
> >> +
> >> +    if (lseek(fd, offset, SEEK_SET) < 0) {
> >> +        return NULL;
> >> +    }
> >> +
> >>       ptr = g_malloc(size);
> >>       if (read(fd, ptr, size) != size) {
> >>           g_free(ptr);
> >
> > This doesn't really help anything:
> >   (1) if the value is really big, it doesn't cause any terrible
> > consequences -- QEMU will just exit because the allocation
> > fails, which is fine because this will be at QEMU startup
> > and only happens if the user running QEMU gives us a silly file
> >   (2) we do a lot of other "allocate and abort on failure"
> > elsewhere in the ELF loader, for instance the allocations of
> > the symbol table and relocs in the load_symbols and
> > elf_reloc functions, and then on a bigger scale when we
> > work with the actual data in the ELF file
>
> Reasonable..
>
> Don't you have an idea, how to somehow mark the value "trusted" for Coverity?

In the web UI, I just mark it "false positive" in the dropdown, and
move on. Coverity has an absolute ton of false positives, and you
really can't work with it unless you have a workflow for ignoring them.

thanks
-- PMM

