Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 386327927E5
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 18:40:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdZ6B-0001G8-Bf; Tue, 05 Sep 2023 12:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qdZ67-0001Bf-0m
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:40:15 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qdZ62-0001f8-K1
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:40:14 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52a4737a08fso3692879a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 09:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693932007; x=1694536807; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BLQ/0ku/rKHSR/4HuYBTPr1PLcYXSgbGA5sAxFARB5M=;
 b=KCJkMDk0OGSAqUOs8Fo36SgrEZBjN0p8Cygy8C5ex/bxTC4Y0KM06NS6FTyER0lQ4/
 vQEaXA4loYGzwcDnSYfNkDoBqJDw45nVYMdNo27n1teTm41ObIMTmMMjWXn/wtCLE5qk
 Fe6CeErvNy0eH4F3GX8wGNBPCffrgrdxJ0ooRXNX7IYashFnQ9TyDDS0Pfzd6l47lLbr
 F8NOgWnIl9iWC1RXQXPrnTT37Z8lFXYnFulPUPjv3+F4/ggrtGAgbLFxAPyTvXfCV6nC
 OITmYmNr19QiAhfo1Qmo4AVJCuqZCO5vFvkOni7njTWOTZqZdXJBwumAEtw3GeFM3VHb
 ipSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693932007; x=1694536807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BLQ/0ku/rKHSR/4HuYBTPr1PLcYXSgbGA5sAxFARB5M=;
 b=jgIo5cj7G77t1Inj2JDb/Ewhcm1lLYCm3+eFkJ5ZL/pGIH/3V73sIVuhpij+CVW6be
 2dyMuoY8nfWaPDUhWYb6nC6CewI4NMprQ5xfmZUzMu4RgTvvvaVE0RUqiceTsA0fR8ax
 zfSUyNEhr4U4YMbmf+iIdHNrTU5KxAeV7dqGQigRchlYP8wZxtwx9KSX8ctrqzrPxrQG
 j3XxmWs0Ccm9zzyKRUuALZywNM6O/6clw/VYErammPOoP7sF9fa4DwjESByfTwsWbUUu
 Jq5iKQ5z+2EghQgwCbVKUrSbWR4FEOS8dPyC53Vc7f368DaWmx0cB1l89twVds7dZ4kp
 Tbng==
X-Gm-Message-State: AOJu0YwGviD2UuR2JAHIHdvgnsmliOV2Vo0C9CiicX6xE5WMZIercanZ
 B91HpuXjGKkjrt70S7nRnymM7JGOgiph/4RT8SiPBw==
X-Google-Smtp-Source: AGHT+IHsdyGtJGLn4OnMIa5Dl1Djhfb5PG8ck+8FsGU0Qv/zaxJaw3x1tzcQAT4t04WDoSsnsLFvoYAE9h5KrVmvIdI=
X-Received: by 2002:aa7:d3c9:0:b0:525:7234:52b7 with SMTP id
 o9-20020aa7d3c9000000b00525723452b7mr305946edr.19.1693932007457; Tue, 05 Sep
 2023 09:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230904161703.3996734-1-peter.maydell@linaro.org>
 <63liuowfkrgvmwipyhb5mpjerjs5nef7ztla5obbh3wsxrna72@ugii6rhgrhb4>
In-Reply-To: <63liuowfkrgvmwipyhb5mpjerjs5nef7ztla5obbh3wsxrna72@ugii6rhgrhb4>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2023 17:39:56 +0100
Message-ID: <CAFEAcA9wXy7RePXe-1VYF7_U9Hc07PgEH50wjbRZhCNcy0H1og@mail.gmail.com>
Subject: Re: [PATCH] docs/devel/loads-stores: Fix git grep regexes
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 5 Sept 2023 at 15:31, Eric Blake <eblake@redhat.com> wrote:
>
> On Mon, Sep 04, 2023 at 05:17:03PM +0100, Peter Maydell wrote:
> > The loads-and-stores documentation includes git grep regexes to find
> > occurrences of the various functions.  Some of these regexes have
> > errors, typically failing to escape the '?', '(' and ')' when they
> > should be metacharacters (since these are POSIX basic REs). We also
> > weren't consistent about whether to have a ':' on the end of the
> > line introducing the list of regexes in each section.
> >
> > Fix the errors.
> >
> > The following shell rune will complain about any REs in the
> > file which don't have any matches in the codebase:
> >  for re in $(sed -ne 's/ - ``\(\\<.*\)``/\1/p' docs/devel/loads-stores.rst); do git grep -q "$re" || echo "no matches for re $re"; done
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  docs/devel/loads-stores.rst | 40 ++++++++++++++++++-------------------
> >  1 file changed, 20 insertions(+), 20 deletions(-)
> >
> > diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> > index dab6dfa0acc..ec627aa9c06 100644
> > --- a/docs/devel/loads-stores.rst
> > +++ b/docs/devel/loads-stores.rst
> > @@ -63,12 +63,12 @@ which stores ``val`` to ``ptr`` as an ``{endian}`` order value
> >  of size ``sz`` bytes.
> >
> >
> > -Regexes for git grep
> > +Regexes for git grep:
> >   - ``\<ld[us]\?[bwlq]\(_[hbl]e\)\?_p\>``
>
> This claims that ldul_be_p() is a valid function name

No, it's not claiming that. It's just claiming that this
regex will catch all the function names defined in this
section, not that it will avoid matching on some non-existent
function names.

The documentation section above tells you what is actually
valid, and that says that "sign" is empty for 32 or 64 bit
accesses.

> (which I would
> expect to take a pointer to a 32-bit integer and produce an unsigned
> result suitable for assigning into a 64-bit value).  But it does not
> exist, and the fact that ldl_be_p() returns 'int' means I had to add a
> cast to avoid unintended sign-extension:
>
> https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg05234.html
>
> cast added in relation to v5 patch at
> https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg04923.html
>
> >   - ``\<st[bwlq]\(_[hbl]e\)\?_p\>``
> >   - ``\<st24\(_[hbl]e\)\?_p\>``
> > - - ``\<ldn_\([hbl]e\)?_p\>``
> > - - ``\<stn_\([hbl]e\)?_p\>``
> > + - ``\<ldn_\([hbl]e\)\?_p\>``
> > + - ``\<stn_\([hbl]e\)\?_p\>``
>
> So as long as we are touching the docs, is it worth considering the
> larger task of auditing whether it is appropriate to have all of the
> ld*_ functions return unsigned values, and/or implement ldu/lds
> variants that guarantee zero or sign extension for widening 32-bit
> values when assigning to 64-bit destinations?

No, I think it clearly is not. All I want to do here is
fix the busted regular expressions.

If you would like to try to tidy up some of the semantics
of the load/store APIs you're welcome to have a go at
that. The major obstacle is the obvious one that there
are an absolute ton of existing uses for all of these
API families.

thanks
-- PMM

