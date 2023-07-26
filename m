Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C73D763EE9
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 20:49:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOjSv-0002Vu-Ue; Wed, 26 Jul 2023 14:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qOjSt-0002Vi-Q4
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 14:42:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qOjSr-0001kt-Mn
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 14:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690396943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xEFRUBIGZXh8Tl1pSSZCoXm7cZLy+yGYlx3uOrbLuyA=;
 b=Loq0u5WmtABD1K4YDk42nTRR1J/BYWReEgEiR1H/LCmzLM2NPku5fSkGk7M24KR8oMtq+3
 QEVoE3ymqTCLq/FMOEibgsh+JdJq+nYo3nOrr/ibgRnLiew5pvvLkvVGV5+Gi++23XUIkz
 9uobAsJjiRzIg0y0aj9qINlz7HoUiZA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-_TGmhtF_PLWAzk0IEyYfvg-1; Wed, 26 Jul 2023 14:42:21 -0400
X-MC-Unique: _TGmhtF_PLWAzk0IEyYfvg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b961c3af8fso531021fa.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 11:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396940; x=1691001740;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xEFRUBIGZXh8Tl1pSSZCoXm7cZLy+yGYlx3uOrbLuyA=;
 b=Q25JgwiTqSKV2KMKWW2peu8Ie3oewOcLLxgc+RWTIP9euPpQD8KyrV9OOaNAFQDUX4
 7UsXhE545n2QASlRrT5JzvKqsLJYbapriZ/ZYd0kGoNKnRT/dN+612PCnCloeOwKjnIR
 iCJF5QPd3RPGuWEcqN5UuSMcQH4B0cSVbt80QSUEYjVPYon5Rhrz5VYpFxUYWSLPjj/M
 94PSO4bnL9j/Hp+UXEURV/4xd5zSyVSISogALkKHdxc1+mX5ranF8k5C04gtNUccZdwq
 r7xl1Uy44vjXaQzX5xhHEOzc1z2uE72Q2cSfsKHGc6YXefgJn27zBeeyeRE+v9HBmhhb
 Z8Mw==
X-Gm-Message-State: ABy/qLZi+sKfR2X3gYyo1QUSkqhHfVY9xlDKgeLjmFoIB2l5OxjNydjM
 BJGTFUwsRAZQMBEDEhyjQIgJKIquoQ+tktuTNg9qbgZ8PZDQUxp6/mSkaHR/i/EVBCxk9qsSPn2
 MVQlTPs+xx/IPjNIW2Gg0Tl2VjuiP59A=
X-Received: by 2002:ac2:4f0c:0:b0:4fe:c40:3583 with SMTP id
 k12-20020ac24f0c000000b004fe0c403583mr19954lfr.39.1690396940486; 
 Wed, 26 Jul 2023 11:42:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEVWgJbrQMIHIQlTvztRmSSTUmuea8YU+s81vqUN5BCDDc20N5nfi1Nlf34bD1QmIJEGq5BnGO7Maig2GXrJjI=
X-Received: by 2002:ac2:4f0c:0:b0:4fe:c40:3583 with SMTP id
 k12-20020ac24f0c000000b004fe0c403583mr19940lfr.39.1690396940195; Wed, 26 Jul
 2023 11:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230726161942.229093-1-berrange@redhat.com>
 <0d0f9f65-2ead-6852-20c2-a83e256eecac@redhat.com>
In-Reply-To: <0d0f9f65-2ead-6852-20c2-a83e256eecac@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Jul 2023 22:42:08 +0400
Message-ID: <CAMxuvaxrBSw7nNr=3WEwACcwhnJ4XhT2_o4mTwuCojhr3U_TFw@mail.gmail.com>
Subject: Re: [PATCH] gitlab: remove duplication between msys jobs
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Beraldo Leal <bleal@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi

On Wed, Jul 26, 2023 at 10:21=E2=80=AFPM Thomas Huth <thuth@redhat.com> wro=
te:
>
> On 26/07/2023 18.19, Daniel P. Berrang=C3=A9 wrote:
> > Although they share a common parent, the two msys jobs still have
> > massive duplication in their script definitions that can easily be
> > collapsed.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   .gitlab-ci.d/windows.yml | 132 +++++++++++++++-----------------------=
-
> >   1 file changed, 49 insertions(+), 83 deletions(-)
>
> We originally had different sets of packages in the 32-bit and 64-bit job=
s,
> to distribute the load between the two jobs ... but it got unified in com=
mit
> 14547e0877f3522. Now considering that we are facing timeouts again, we
> should maybe rather revert that commit instead of unifying the lists fore=
ver?
>
> Anyway, before we unify the compiler package name suffix between the two
> jobs, I really would like to see whether the mingw Clang builds QEMU fast=
er
> in the 64-bit job ... but so far I failed to convince meson to accept the
> Clang from the mingw package ... does anybody know how to use Clang with
> MSYS2 properly?

I checked it this week (because of bug #1782), and it compiled
successfully. Although I think we may have some issues with clang on
windows, as it doesn't pack struct the expected way. See also:
https://discourse.llvm.org/t/how-to-undo-the-effect-of-mms-bitfields/72271.

It may be a good idea to add some extra static checks about our packed
struct padding expectations..

Eh, it didn't feel much faster to compile with clang :)


