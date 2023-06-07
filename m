Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 781D67258E7
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 10:57:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6oyM-0008VC-RQ; Wed, 07 Jun 2023 04:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6oyL-0008Uo-Pj
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6oyK-00071y-5B
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686128211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GG0NJmxaWRj5JKbUAQk9HoU+pOvK6FkwqMIPJ7WpAdI=;
 b=IYftmBFdHO9hnxCuHP4eCOfBOlCCAgNiRhCPeXpwC11S5RVhQ3WhjKsp7dGlDOOTX6MW+2
 GrKJ6LbxHhjt0NSO6jqRGKrfTcH4H20bMN9TrBVdMjP8EtDAp5rGGYmAP3grV4vBaXuI4i
 gJqvvxQw3vbqyh5CzciA5OVl04xAksg=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-40dHAK_UP_6bvDuRhMNPcA-1; Wed, 07 Jun 2023 04:56:50 -0400
X-MC-Unique: 40dHAK_UP_6bvDuRhMNPcA-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-43b2cce3dfbso921486137.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 01:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686128209; x=1688720209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GG0NJmxaWRj5JKbUAQk9HoU+pOvK6FkwqMIPJ7WpAdI=;
 b=bmzLtAWb/PEHGFUCjZSDlblvaI9+G7FT8Bethjo5HNqPR5LDgL+MfCOP0QFC+rO66h
 e/pvm3Dpp9aOfP6D9qY4C9RQzl1mV+SgnFooT9P819Hii8HwQNviVhTuu835PhxZhDvs
 zoHhqJLwNNZQNIG1C/Ou3L2QxLzXYMvV96OynwWR8cNTldaA6eCUHdWAEnEPM9ZSsfIc
 zNJNNCxTMTp0Ir+us/eY7xCcmQqJ3INq9drq9Lz12kjKk8ydRxkYjLIOoUJvDuHvY403
 CinOn/aqzFYvdU3lRoXmW35sgMsi1acof3CH6mXUbexrLtzbu3oyGNWe2fObGSG2x53/
 P7Vw==
X-Gm-Message-State: AC+VfDwYHnLUGPwuOO3SiSXYsOt/iRtMzVOMGRh8QTXXN8TSjojDT1Xh
 a1R5U4P59SHXXrxumOPl+bmpApKTSquL+pc5BaCEIvlp8QKcx6VP+olB9amkab4bBJALG3nXzG9
 KdOUNfHLZf+WbKBIeuJv09vne9lyJY8g=
X-Received: by 2002:a67:f789:0:b0:43b:3399:547 with SMTP id
 j9-20020a67f789000000b0043b33990547mr795751vso.15.1686128209619; 
 Wed, 07 Jun 2023 01:56:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Dqk8mF3SgdLVgUVjy4iQ/arohCV9zMCpMv0ApLD+qSo5ocHHHNIwiOotCDu2P+vvgtC9adhnPLlmpwfMnLMc=
X-Received: by 2002:a67:f789:0:b0:43b:3399:547 with SMTP id
 j9-20020a67f789000000b0043b33990547mr795750vso.15.1686128209361; Wed, 07 Jun
 2023 01:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <e9efc1a4-b292-10a1-9058-76f7c8ac9867@redhat.com>
 <ZIA1/5KQC15t47Sp@redhat.com>
 <a629ed09-1bfd-5ead-9b18-089d74f67e95@redhat.com>
In-Reply-To: <a629ed09-1bfd-5ead-9b18-089d74f67e95@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 7 Jun 2023 10:56:38 +0200
Message-ID: <CABgObfakD4rm05px3QvT-zOeMnbkumhSzXJsfDn8sb2Q2o7Zcg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] meson: replace submodules with wrap files
To: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

No, Michal is correct. Patch "meson: subprojects: replace
berkeley-{soft,test}float-3 with wraps" did not remove the submodules.

Paolo

On Wed, Jun 7, 2023 at 10:54=E2=80=AFAM Michal Pr=C3=ADvozn=C3=ADk <mprivoz=
n@redhat.com> wrote:
>
> On 6/7/23 09:47, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Jun 07, 2023 at 09:41:40AM +0200, Michal Pr=C3=ADvozn=C3=ADk wr=
ote:
> >> On 6/5/23 11:52, Paolo Bonzini wrote:
> >>> This series replaces git submodules for bundled libraries with .wrap
> >>> files that can be used directly by meson for subprojects.
> >>
> >> Pardon my lack of knowledge, but even after I clone new repo and run:
> >>
> >>   ./configure --enable-donwload && make && make test
> >>
> >> I still see berkeley-softfloat-3 submodule missing:
> >>
> >>   git submodule status
> >>   ...
> >>   0c37a43527f0ee2b9584e7fb2fdc805e902635ac roms/vbootrom
> >>   fatal: no submodule mapping found in .gitmodules for path
> >> 'tests/fp/berkeley-softfloat-3'
> >>
> >> Is this expected?
> >
> > Yet another example of submodules sucking. Once we removed the submodul=
es
> > from .gitmodules, git doesn't know what to do with the existing chcked
> > out submodules from before this time.
> >
> > Best thing todo is purge all existing submodules, eg
> >
> >   git submodule deinit --all --force
> >
> > and if there are stale directories left over, manually delete those too=
,
> > so you get back to a more pristine checkout state.
>
> I'm not sure that helps. I mean:
>
>   git clone https://gitlab.com/qemu-project/qemu.git qemu2.git && \
>   cd qemu2.git/ && \
>   git submodule status
>
> still complains:
>
>   fatal: no submodule mapping found in .gitmodules for path
> 'tests/fp/berkeley-softfloat-3'
>
> Michal
>


