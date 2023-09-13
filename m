Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8A479DE9C
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 05:27:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgGWJ-0003Tf-Hg; Tue, 12 Sep 2023 23:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qgGWH-0003TP-FF
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 23:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qgGWF-0008Be-0h
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 23:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694575581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3FjuWfA8s4iDxFnf90P/CcVNDkI117j10HliD2W7zoA=;
 b=Zp8kgAXu8iecr6Erf8yW/kpHEErxuhJy+vQ3VYrQd/gp0mdsk2BaOdE+3/LA3rnnP+Ahoj
 wRd5gw1ZM/9kUxE+5taHqw0NUKOC8waLlUAqCcW02nmwFtT5yTgM8e62mEQYlj19p9RAnF
 p26VvGdlJ4NPmpThqlN/FJgCWuHvO4I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-Fyg33EvANgi9NTUFCSDCxg-1; Tue, 12 Sep 2023 23:26:19 -0400
X-MC-Unique: Fyg33EvANgi9NTUFCSDCxg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5009121067cso6634914e87.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 20:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694575578; x=1695180378;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3FjuWfA8s4iDxFnf90P/CcVNDkI117j10HliD2W7zoA=;
 b=ZX7lSAS2ij/sTv7Tyhhm/zjNZwsvqVbrtQZCQUXBWlu6A7fip+UpwbRSGJbfO97g4d
 tV++iom5J+vK4GrLxY5dbTg8l1B+mzwnp6lRdvSSYZntyp8MUhhCoW2gVCWVNRnmZ7b3
 /UkDuz57GrnE2yq+p9UpxdJLcFho6XC/yCvT+EqTYBcMDZoLGNIrfbSwzfNE8qRGq+Wk
 9t6p+jqWDbHrPQbcqx7kzA9R1EzoFAvYnG0+x1PYRuwixFG00HLqx2jT6UXRk+D0xcft
 jzkcOpq6SVkvTNPHyfUd9VGrrYHVb+ybokUc9AfvlRt0KWhq1LZYryLfhNn+Mrm1QdIU
 bdng==
X-Gm-Message-State: AOJu0YyeHIW9tym1lEZof/iA9CdNwIheosvFozGj7ppNu4UaudKM8YmV
 RL996LP2qENvVGtuSdJAj1DcueMmFyzZ1MHT57CTeus/7qokGDT9Znkfzpl4L+F+0LOvPW4Lb3s
 g3z/8ICFFda8Ll007S5GcHvRBq75NA1KrnSlguEUnKQ==
X-Received: by 2002:a19:5f56:0:b0:4fd:d538:b97b with SMTP id
 a22-20020a195f56000000b004fdd538b97bmr898872lfj.29.1694575578027; 
 Tue, 12 Sep 2023 20:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUKPvgdHxv2sN8GJf/he30V8L/EoJKgEujDCIMePyFkc9qpJb/wwPR5rRt9Bcu5BM4PBvazedMXtnbtVd7l4g=
X-Received: by 2002:a19:5f56:0:b0:4fd:d538:b97b with SMTP id
 a22-20020a195f56000000b004fdd538b97bmr898862lfj.29.1694575577669; Tue, 12 Sep
 2023 20:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230824153224.2517486-1-peter.maydell@linaro.org>
 <CAFEAcA9Btq5W4+WD3go6JLEL+0ZNu8hW5Q16GB5MLSXyNwJDOA@mail.gmail.com>
In-Reply-To: <CAFEAcA9Btq5W4+WD3go6JLEL+0ZNu8hW5Q16GB5MLSXyNwJDOA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 13 Sep 2023 11:26:06 +0800
Message-ID: <CACGkMEv2yOJWPb2HcSqoXsASm-r6jh6SM9wq-_za8AMWdPPCqQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] net: avoid variable length arrays
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jiri Pirko <jiri@resnulli.us>, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 12, 2023 at 10:20=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> Hi, Jason. This patchset has been reviewed -- do you want to
> pick it up via the net tree?

Yes, I've queued this.

Thanks

>
> thanks
> -- PMM
>
> On Thu, 24 Aug 2023 at 16:32, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > This patchset removes the use of variable length arrays in a couple
> > of network devices and the net/ core code.  In one case we can switch
> > to a fixed-sized array on the stack; in the other three we have to
> > use a heap allocation.
> >
> > The codebase has very few VLAs, and if we can get rid of them all we
> > can make the compiler error on new additions.  This is a defensive
> > measure against security bugs where an on-stack dynamic allocation
> > isn't correctly size-checked (e.g.  CVE-2021-3527).
> >
> > Philippe had a go at these in  a patch in 2021:
> > https://patchew.org/QEMU/20210505211047.1496765-1-philmd@redhat.com/202=
10505211047.1496765-16-philmd@redhat.com/
> > but these are re-implementations, mostly.
> >
> > Usual disclaimer: I have tested these patches only with
> > "make check" and "make check-avocado".
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (4):
> >   hw/net/fsl_etsec/rings.c: Avoid variable length array
> >   hw/net/rocker: Avoid variable length array
> >   net/dump: Avoid variable length array
> >   net/tap: Avoid variable-length array
> >
> >  hw/net/fsl_etsec/rings.c      | 12 ++++++++++--
> >  hw/net/rocker/rocker_of_dpa.c |  2 +-
> >  net/dump.c                    |  2 +-
> >  net/tap.c                     |  3 ++-
> >  4 files changed, 14 insertions(+), 5 deletions(-)
>


