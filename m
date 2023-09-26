Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BDA7AF04E
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:09:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAcj-0002pH-46; Tue, 26 Sep 2023 12:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlAcK-0002bS-BL
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlAcH-0001h8-GQ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695744531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmUSQEsUJJocMad8FUbFm+c9a+I32jc3FI67r2VXCVA=;
 b=FTGPyf4thXh2ypZ1HWXXYPr8NlFfrdS20649Tw6/nFX8oBsjWhycNkmbEF5tcHO9caBXhU
 wnG32pw1/4gG8j5/vo0huoYmJmEYTdHSuCqQhwWtMFNarys+jkbZ3u6IhKSG6lyKl/mCrB
 hIJlIj3KROjFmRJrTnIWOm/0sp71rVM=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-vEGJb0ZnPy-ldnavsyJAjA-1; Tue, 26 Sep 2023 12:08:45 -0400
X-MC-Unique: vEGJb0ZnPy-ldnavsyJAjA-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-45266ea607eso5040854137.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695744522; x=1696349322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nmUSQEsUJJocMad8FUbFm+c9a+I32jc3FI67r2VXCVA=;
 b=JiBEfQVBc3XN3uEL/2r6C++KHgDIllNJzQL7PFfUpgeBg0LH8+Y/qzXYbnuvRiXAKC
 sKi1117qJ8iKHLqFrk81oTDQ7GnP5cR1gq5PU67Cxag6gntVo7q7SU6DT+K5XAYlUn+R
 hAH3kiqJHgIKbpytuiqpsBjBcUNLdPabgisO5QiTkLBMqqFNX5+zUUUqRFdfMDnsW91V
 w97qNxKTkuN4u5luge6OOaOwrUcXvXiMgM4yy7IG2D3xJ8ZwnMMeur8zEKGcIIwtpbRh
 eqpY2ael6JZW22VJBGrTpqG1PTVL37l6zbkQJbfoUFqvI0BcJlIek5KW+417Oc1PLwcJ
 GmkQ==
X-Gm-Message-State: AOJu0YwdFM5PaKnpSwMsB7K/iuazocT2TjNZ1iJzOeoAgmR5ZcCiWYFl
 oUtWJasmXqsKeHlxEkk8cLkW7FUKo4bBREDVGcuFCpzKQBgUAAJqytwaXYgY6SJaZEFfj29irix
 OaotaHNURPswpNw3OXZqLgpE3xbrPcvrubHkGDmc=
X-Received: by 2002:a67:fe54:0:b0:452:5b2d:7787 with SMTP id
 m20-20020a67fe54000000b004525b2d7787mr7303665vsr.0.1695744522573; 
 Tue, 26 Sep 2023 09:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6h+G6wNbI5Ktw4yGgqF+vBy+oN7x5Fv284bEW7ZZyCUzoWkYvT0YZ1jiKOoVHYbDO7oXm1r6XSEN7ez4vtpg=
X-Received: by 2002:a67:fe54:0:b0:452:5b2d:7787 with SMTP id
 m20-20020a67fe54000000b004525b2d7787mr7303652vsr.0.1695744522303; Tue, 26 Sep
 2023 09:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230926144149.715750-1-pbonzini@redhat.com>
 <CAFEAcA_8EfEnh+-7JnN88KUWWxu1eQzJTH4Q7f-Tdf3dzDMwxw@mail.gmail.com>
In-Reply-To: <CAFEAcA_8EfEnh+-7JnN88KUWWxu1eQzJTH4Q7f-Tdf3dzDMwxw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 26 Sep 2023 18:08:30 +0200
Message-ID: <CABgObfZ0dRH82UC-923vjasSG4GanA+bvYgnT3eRaLf-Y1AOkQ@mail.gmail.com>
Subject: Re: [PATCH] make-release: do not ship dtc sources
To: Peter Maydell <peter.maydell@linaro.org>, "Weil,
 Stefan" <weil@mail.berlios.de>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 26, 2023 at 6:00=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
> > Keep the wrap file so that it can be used with --enable-download,
> > but do not ship the sources anymore with either archive-source.sh
> > or make-release.
>
> Can you explain this use case in a little more detail? I'm
> clear on the two poles of:
>  (1) dependency isn't in all our supported distros, so we need
>      to provide sources and handle building it ourselves
>  (2) dependency is in all our supported distros, so we don't
>      need any special support because meson will find the
>      system library and headers
>
> but I'm not sure when we'd want something in the middle, which
> is what this sounds like?

I kept the .wrap file because --enable-fdt=3Dinternal, currently, forces
the build to use an embedded static libfdt and I wasn't sure if
anybody was using it.

If there is anyone it could be Stefan's win32 builds. I didn't want to
mess those up. If he's not, I'm happy to drop it as well.

Paolo


