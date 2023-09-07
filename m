Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D62796F5B
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 05:44:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe5wH-0002kU-0Z; Wed, 06 Sep 2023 23:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qe5wE-0002PF-9Z
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 23:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qe5wB-0002yf-Dd
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 23:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694058250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Mv7YG307vWPPBwU5GGd2dIhAylyU7Oj/CupyElh5hk=;
 b=YuF8oMMaRxUHNgfv5P77do1dBgXbjI5xecdcTcDLTsgvKTQ6VUoxYf23+tMVN8Gnrr75SY
 BBSDo56O4+iTO6IK8QB2Vi1o0XvCzZO35JSeFIz1jddnUNCzblzPVwO9ic+C+t4lcGJwNw
 JEHTfpF17BwYAl7NK4HFrvLLePOU8OM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-IAqBogYTNyCOU0UIDvMKKw-1; Wed, 06 Sep 2023 23:44:09 -0400
X-MC-Unique: IAqBogYTNyCOU0UIDvMKKw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-26f6ed09f59so672325a91.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 20:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694058248; x=1694663048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Mv7YG307vWPPBwU5GGd2dIhAylyU7Oj/CupyElh5hk=;
 b=QAUbIaR7Nio3YRQj5SeSn3ISl07x00lw45UXpGd5YHQWsGBFZUOl0zN59nddPV27jV
 SpeYwEougJmvF2+jxvqg2k+jUp+jS3Pr6vYVHixiAfaYGtnXd0GQd+fpXRSSdRLeX1Ae
 /yD3No7WjNzjntmYRQ6JoYqHndSKsZf/+dMdR4JfR5NnqaHn2wXsVJWbf1VFfnrO6uas
 RxhX60/2GmvUJlaVSXFRkvtBcjTZL+xr0ZqETT61tjEziND0oSb0aVq6dFt8O3c7VKnj
 /KZH0LBYDzLL2DzF3648dnEpLVxQWVAVyir/HXbOU2DRPcs1W+IjPQC3XoI7I8CvS7Vh
 0uBw==
X-Gm-Message-State: AOJu0Yyv8eEYqnIdixS83pxI16MHOsDXVEsjd00cTT6EGBqBoQaViNF9
 A4MEa6Y4ph4a1sFsMFmdhGKCtQkXdKGpsvmq3jtHYIMzm+u+KadsyWGcGgP1QLQSzH3vRvPaKdO
 ZxR3g6gj8+m5NiO4DSh3jOu1y2X8+HYEByBzG4sg=
X-Received: by 2002:a17:90a:bd95:b0:267:f7eb:f12e with SMTP id
 z21-20020a17090abd9500b00267f7ebf12emr14163665pjr.39.1694058247765; 
 Wed, 06 Sep 2023 20:44:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFj6tv1lJtohAMT/ctwDJOEEDtCUMBBQYV8PPm1jOj+/keKenb0l9t0EoUGsaYDUSukqIqHVyjgOOtogNu7Yw=
X-Received: by 2002:a17:90a:bd95:b0:267:f7eb:f12e with SMTP id
 z21-20020a17090abd9500b00267f7ebf12emr14163654pjr.39.1694058247518; Wed, 06
 Sep 2023 20:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230907034228.4054839-1-jsnow@redhat.com>
In-Reply-To: <20230907034228.4054839-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 6 Sep 2023 23:43:56 -0400
Message-ID: <CAFn=p-ZJYBNX_ZDbHynmK1Hv-PQHgx7n++1bvEn3Oa7sysRNRQ@mail.gmail.com>
Subject: Re: [PULL for-6.2 0/7] Ide patches
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

I guess the last time I sent IDE patches was for 6.2 and that tag got
stuck in my git-publish invocation, oops. I am not suggesting we break
the laws of causality to merge these patches.

On Wed, Sep 6, 2023 at 11:42=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit c152379422a204109f34ca2b43ecc538c7d738=
ae:
>
>   Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu=
 into staging (2023-09-06 11:16:01 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/jsnow/qemu.git tags/ide-pull-request
>
> for you to fetch changes up to 9f89423537653de07ca40c18b5ff5b70b104cc93:
>
>   hw/ide/ahci: fix broken SError handling (2023-09-06 22:48:04 -0400)
>
> ----------------------------------------------------------------
> IDE Pull request
>
> ----------------------------------------------------------------
>
> Niklas Cassel (7):
>   hw/ide/core: set ERR_STAT in unsupported command completion
>   hw/ide/ahci: write D2H FIS when processing NCQ command
>   hw/ide/ahci: simplify and document PxCI handling
>   hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared
>   hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
>   hw/ide/ahci: fix ahci_write_fis_sdb()
>   hw/ide/ahci: fix broken SError handling
>
>  tests/qtest/libqos/ahci.h |   8 ++-
>  hw/ide/ahci.c             | 110 +++++++++++++++++++++++++++-----------
>  hw/ide/core.c             |   2 +-
>  tests/qtest/libqos/ahci.c | 106 +++++++++++++++++++++++++++---------
>  4 files changed, 163 insertions(+), 63 deletions(-)
>
> --
> 2.41.0
>
>


