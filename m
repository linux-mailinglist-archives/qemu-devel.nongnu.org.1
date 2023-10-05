Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C34B57B9D29
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 15:01:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNyN-0002Um-HC; Thu, 05 Oct 2023 09:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qoNxp-0001oy-Vt; Thu, 05 Oct 2023 09:00:32 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qoNxn-0008Q1-4D; Thu, 05 Oct 2023 09:00:25 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1dd5b98d9aeso493148fac.0; 
 Thu, 05 Oct 2023 06:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696510820; x=1697115620; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/hry7yvsrUX9AY9lc7Ad7j6izjLZyOCwqbTVZ9IttW8=;
 b=NQXTb67nZWAQ/Bk5dOcSZiOoLY99/3SQ89zwEbFnL0mRyFlnXh1kXVGQvIJ5GjOsZZ
 EBRrfjAQ5biuuVgR3nY5KqwBYaTbLm1OYV1+BV3wo1i/4Ygr+eVZLFgMnfxEZnaIA4oC
 VUz1dL9d2xtWz73fVLWYWtz7dCOxJO2j3SOplN/N55aXOqjSYR8Yg/BkrVGNQwlrktlM
 WC+qAXiCgyoDANWUHKjFgbesYuekx/eAsmKo3+B0ygZayfuUF36JUUnWt6nrcNCkYYgH
 g6gZzXUnEbOsFAyCoewoe5MHG2HRunPZUmkqTC1ZLcEbsvioRi2+1pU1i0erzNNRF7fD
 4wRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696510820; x=1697115620;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/hry7yvsrUX9AY9lc7Ad7j6izjLZyOCwqbTVZ9IttW8=;
 b=CxlZMxrv2x6Vt6T3MJxDEHAS2DifRxIHKhaBHq3wnrptbmgEVZ/1PRko2U3Mt8xI+P
 uge355UaluWUvDlJoKKMjgsq+j2/vIJudKTQVLwfVLF+V1TBKzp5HP7GTkSMFwNXVymq
 WawPSKnUYOyoIhJ6RRGq4AVY3whPKew7uCJR0SkUxGnPr2d3t6D/DRX2VSwf7KSRSApU
 3UJmVJuVrONe1InLccTpN9R7yXLnl4XV5KneRxeffNtRstGdKKHC0ErFDRmC6BxA0zSB
 ScCm3XtlG0KJJspgI+w+YT9glRuf7wT0Y0wWivrSIHvw0rCwsHBgDxzpVbVoqN1PCYIF
 wAig==
X-Gm-Message-State: AOJu0YyoM597jiJlYMJtDRmj3T812b7zZS9d/8foZt+HOwwzvbUbfCDy
 8TNLf6jVrBQMdO7vADVKywDX8LzLRw1AsKQBmRc=
X-Google-Smtp-Source: AGHT+IGmaFr+QMQU5ZEENrMaJ3T3MYfr5AxPq5UnmExBjnkMtHGqpPqdxWkFZoQJkvjbY5ljpubLq7dUTGV/D97fjJw=
X-Received: by 2002:a05:6870:2195:b0:1dd:611e:d404 with SMTP id
 l21-20020a056870219500b001dd611ed404mr671355oae.21.1696510820195; Thu, 05 Oct
 2023 06:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231004194613.2900323-1-jsnow@redhat.com>
 <3984cd72-931b-fa9b-e7ac-3d60487ac442@linaro.org>
In-Reply-To: <3984cd72-931b-fa9b-e7ac-3d60487ac442@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 5 Oct 2023 09:00:08 -0400
Message-ID: <CAJSP0QUYd58Q03Ugm2ULh=aiA8jUni2XM0aZAvxE1CoYbaW5cQ@mail.gmail.com>
Subject: Re: [PULL 0/9] Python patches
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, 
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-block@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Thomas Huth <thuth@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, 5 Oct 2023 at 00:49, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Hi John,
>
> On 4/10/23 21:46, John Snow wrote:
> > The following changes since commit da1034094d375afe9e3d8ec8980550ea0f06=
f7e0:
> >
> >    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into sta=
ging (2023-10-03 07:43:44 -0400)
> >
> > are available in the Git repository at:
> >
> >    https://gitlab.com/jsnow/qemu.git tags/python-pull-request
> >
> > for you to fetch changes up to 4d7a663cbe8343e884b88e44bd88d37dd0a470e5=
:
> >
> >    Python: test Python 3.12 (2023-10-04 15:19:00 -0400)
> >
> > ----------------------------------------------------------------
> > Python pullreq
> >
> > Buffering improvements for qemu machine, minor changes to support the
> > newly released Python 3.12
> >
> > ----------------------------------------------------------------
> >
> > John Snow (9):
> >    Python/iotests: Add type hint for nbd module
> >    python/machine: move socket setup out of _base_args property
> >    python/machine: close sock_pair in cleanup path
> >    python/console_socket: accept existing FD in initializer
> >    python/machine: use socketpair() for console connections
> >    python/machine: use socketpair() for qtest connection
> >    python/machine: remove unused sock_dir argument
> >    python/qmp: remove Server.wait_closed() call for Python 3.12
> >    Python: test Python 3.12
>
> Is that a pull request or a patch series to be reviewed?

Strange, some of the patches have Reviewed-by tags but others do not.
I could not find a "Add type hint for nbd module" patch on the mailing
list before this pull request, so I guess it hasn't been reviewed.

I'll hold off from merging this series for now.

John: Please make sure all patches have been on the mailing list for
review before sending a pull request.

Stefan

