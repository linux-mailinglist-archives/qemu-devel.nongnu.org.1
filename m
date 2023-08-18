Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD802780FC3
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 18:03:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1u8-0008SA-V8; Fri, 18 Aug 2023 12:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qX1u4-0008Pd-Cm
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 12:00:50 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qX1tz-0005Qp-Cq
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 12:00:48 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-52256241c50so1360965a12.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692374441; x=1692979241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n0y4DJQ1eip3rLo9KwweCZCxXb+PVitmEIUerMLkH5M=;
 b=n/19kMT85Akz1UoEwsASZFZ4myyELua5QhNil5BWDcF0Cw1WOndGuQbqeJif7homF4
 y7Gb93vE9G4qEz5GnTpZ8ok8Sca1P08J10NYnC4FFZxhNUspz52O7UtS86UQm0aWEfXe
 gl7PVrOoIFSyAhNcrze5MtSaXTXgrVowJdsgirTKhOGKf5zELPw3ypivA7C/wm6v3H/H
 4TlXswGTThHN+LpmECcoANTLcY3rFbJNDKs/M/IPOjmWeiEbkGMmp3EjQ/SOXRVPXZiY
 P1qiPNmNjqFyTkLNqcNNd58vVzcWTzx5YVrFOBVglt2pwVVZuZSf5M+msXp5I4WvvQoL
 t8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692374441; x=1692979241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n0y4DJQ1eip3rLo9KwweCZCxXb+PVitmEIUerMLkH5M=;
 b=gJuUTrqkUqI882Bp3pFJdPITWlpiBRaAOIy5CfZG8yFLbXHU6uaOaORAZVxNeWp4Wg
 NEtz9Cc4pi4eSJWcnqmmwcRcDvWPEicRD4913bpAg4cKAHqulvfGbkk7pj4rC4EMtHJE
 MP1Lxct8cIbpbXlQWbOKUyD16j7sCtDXFUvNjlOrsHw10OxdQ6ZTILS+gCKApn2IOwsC
 HVxUwmFNqHIkWJt+22N2KGGk8JWA0zHBCRjS8aEQmO1ZkFjTHDCtPEec6k24sOSPMoOu
 GCgHx4/WSnmnYH22KZW6pdNQ+BhmGDEy/yuqJYPdiXpDo/Ygri99V1zKcbPqxafdUlxu
 VZrg==
X-Gm-Message-State: AOJu0YwLlYL3/SiBzOWEmpacR/ntckWaeHL3x1TsGj4R66/XR0cBl20t
 +JDc2mLFNvLhT8v6JJlveStfSgKnbR1EMiZrQd3Xnw==
X-Google-Smtp-Source: AGHT+IGJzRZ8I9J8JqOBsfKwodhk1OxOVVWRvYm/HfC5Ivm529ZiXdrVCF8CJD+EvfYb8VyexaJwtg3+0C9yQYZWPFk=
X-Received: by 2002:aa7:c643:0:b0:522:1bdd:d41a with SMTP id
 z3-20020aa7c643000000b005221bddd41amr2746196edr.4.1692374441474; Fri, 18 Aug
 2023 09:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230727150705.2664464-1-peter.maydell@linaro.org>
 <CAFEAcA-0prmwQ+En=oZnR=AH_v9DBUU=C7qjK+z436WDygBnhA@mail.gmail.com>
 <ZN+UwJ3/D5vKfxEe@redhat.com>
In-Reply-To: <ZN+UwJ3/D5vKfxEe@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Aug 2023 17:00:30 +0100
Message-ID: <CAFEAcA_LTGLA89MhrPS2FhtB71gw1UuZ4ZaZLPYtkCAsd2QKyA@mail.gmail.com>
Subject: Re: [PATCH] block/iscsi: Document why we use raw malloc()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 18 Aug 2023 at 16:56, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 27.07.2023 um 17:15 hat Peter Maydell geschrieben:
> > On Thu, 27 Jul 2023 at 16:07, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > In block/iscsi.c we use a raw malloc() call, which is unusual
> > > given the project standard is to use the glib memory allocation
> > > functions. Document why we do so, to avoid it being converted
> > > to g_malloc() by mistake.
> > >
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > > There aren't many uses of raw malloc() in the codebase
> > > other than third-party library sourcecode. Mostly we have
> > > a comment noting when we're doing it deliberately.
>
> Thanks, applied to the block branch.
>
> > The other option here would be to use scsi_create_task(),
> > if we're OK with requiring libiscsi 1.13 or better (that's
> > 9 years old at this point, so should be OK...)
>
> I wouldn't mind either way, but since this patch exists and the other
> doesn't, I'm applying this one for now.

Thanks. I think scsi_create_task() would be cleaner, but
it's just over the amount of change that I'd want to do without
a test setup to exercise this code, which is why I stuck to
the comment for now.

-- PMM

