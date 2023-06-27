Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C57E573FBC6
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:10:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7WD-00047z-Ok; Tue, 27 Jun 2023 08:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE7W7-00043C-IR
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:09:56 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE7W5-0001Bg-Q3
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:09:55 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so6354875a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687867792; x=1690459792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+DIaJEZZkOj6A00vEClo2ROUXdo+5TvBnx+ed4rFkjo=;
 b=aUf1F8YTSrliqLbZaIwP/C1vZSFnKd5vMbWOYd4Dy46rWyFJJYvdw4PkN8HAgu6CaC
 /F/ORDSELJoXTa/G1XMalSh9UZntJEDIpAdS+zaJQjkyvH9yPXfvcKwVzJ9/DgYBN9pG
 US1L5M8y4/W6gJVGDI9dhrSxC4DU3jkNIkbF1lwjW12m2p84x2KsiLRrKGmwZ5ZnIiBS
 hGvlkb2nBzpRY5A/IrwZslXfoBaeqMG408g74H+iaVmrPSXA1Co1ft606q3YJamVql+G
 mYwpeEib0i9H3pK1EcQvqM5aJkoTCbASMeTnbvKnKOPFOv5UPnyLzLDTSzg0bITBsOOY
 Ap4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687867792; x=1690459792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+DIaJEZZkOj6A00vEClo2ROUXdo+5TvBnx+ed4rFkjo=;
 b=KOdwUBJOFec4xaXK0sc9bgPqLXocG5E/U3kn+FJVaYB8EIfTb8XY+1YsiDzaWMsQJg
 lWleb0yXnq0NeRVINOF04+CqxP/pyx70eL08f2ph97OE+IpOTBZqJGVke0Lk48BTtQXV
 7RKoU5JkuZoUgeKXt1yn49Ce4hM22d21MvnybCyQhANXH4Hon3JMwu852T0k+PbwRnHc
 4yUbOXodppoAJhDH7tqID0b5xXfGrp4y10kEhKOXAwtoUfoxPhGocsqctUkEh8ZuDVDD
 G/uTp2Ot915kSqwSUpd1ScU707x/szfPr9Ld7W1U5sFTylPy1cA5AZWFZtZ3RkpF+aG+
 q8XQ==
X-Gm-Message-State: AC+VfDx8MgHy/ZXITz4cZw4qo5nYWV16dN5gcLGe3imsSIzdn/kOiHW7
 lPjnHD5EhDT66Kfos8803zrIhxnTSMVV+n4hhQQPeFHA9G115lO/
X-Google-Smtp-Source: ACHHUZ5wishnr9HWmj5U+NvuxY0SmTSliAs2eyfFJkb2ZqymO1XafzRtPilb27RqQfXER5h3CHk5eEJsCjog9zsxCSg=
X-Received: by 2002:a05:6402:4302:b0:514:a21b:f137 with SMTP id
 m2-20020a056402430200b00514a21bf137mr34020656edc.6.1687867791961; Tue, 27 Jun
 2023 05:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210510125340.903323-1-anthony.perard@citrix.com>
 <20210510125340.903323-4-anthony.perard@citrix.com>
 <CAFEAcA-ZxRW-+ttyfZj1hSAZyDbYj6Mbvs=KsG6Sfg6QTdKhrg@mail.gmail.com>
In-Reply-To: <CAFEAcA-ZxRW-+ttyfZj1hSAZyDbYj6Mbvs=KsG6Sfg6QTdKhrg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 13:09:40 +0100
Message-ID: <CAFEAcA_NmutsbheVL27d8ZUNZ_MYC+bC6bWjZA+-n+xqdBMKXA@mail.gmail.com>
Subject: Re: [PULL 3/3] xen-block: Use specific blockdev driver
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, 2 Jun 2023 at 18:04, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 10 May 2021 at 13:53, Anthony PERARD <anthony.perard@citrix.com> wrote:
> >
> > ... when a xen-block backend instance is created via xenstore.
> >
> > Following 8d17adf34f50 ("block: remove support for using "file" driver
> > with block/char devices"), using the "file" blockdev driver for
> > everything doesn't work anymore, we need to use the "host_device"
> > driver when the disk image is a block device and "file" driver when it
> > is a regular file.
> >
> > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> > Acked-by: Paul Durrant <paul@xen.org>
> > Message-Id: <20210430163432.468894-1-anthony.perard@citrix.com>
> > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
>
> Hi; Coverity points out (CID 1508722) that this introduces a
> memory leak in the new error codepath:

I just realized I forgot to cc the current Xen maintainers,
so I'm doing that now. I think the fix for this leak should
be fairly straightforward.

> > ---
> >  hw/block/xen-block.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> > index 83754a4344..674953f1ad 100644
> > --- a/hw/block/xen-block.c
> > +++ b/hw/block/xen-block.c
> > @@ -728,6 +728,8 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
> >      XenBlockDrive *drive = NULL;
> >      QDict *file_layer;
> >      QDict *driver_layer;
> > +    struct stat st;
> > +    int rc;
> >
> >      if (params) {
> >          char **v = g_strsplit(params, ":", 2);
> > @@ -761,7 +763,17 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
> >      file_layer = qdict_new();
> >      driver_layer = qdict_new();
>
> You can see here that we allocate file_layer and driver_layer
> as new qdict objects...
>
> >
> > -    qdict_put_str(file_layer, "driver", "file");
> > +    rc = stat(filename, &st);
> > +    if (rc) {
> > +        error_setg_errno(errp, errno, "Could not stat file '%s'", filename);
> > +        goto done;
>
> ...but here if the stat() fails we will bail out to
> the 'done' label, and the code there does not dereference
> these qdicts, so they will leak.
>
> The easy fix is to move the two calls to qdict_new() to
> below this if() rather than above it.
>
> > +    }
> > +    if (S_ISBLK(st.st_mode)) {
> > +        qdict_put_str(file_layer, "driver", "host_device");
> > +    } else {
> > +        qdict_put_str(file_layer, "driver", "file");
> > +    }
> > +
> >      qdict_put_str(file_layer, "filename", filename);
> >      g_free(filename);

thanks
-- PMM

