Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D92FA719C2D
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:31:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hSd-0004Z1-Kb; Thu, 01 Jun 2023 08:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4hSa-0004Wb-EA
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4hSY-0002NZ-Va
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685622677;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OPbGiZXpoCZouy16UC3L3jg1Og+l9FR+1Wa7/lyKwTk=;
 b=WUBxCjhm6/9oVvaqKsuym97AZAnKaIRvgWRoFficB64+2oLXhesZTfDRIKMvPFKt7qXpv8
 f6h5MCvD5tAwu6ZXgbd0muvTYY9YAN2P+49OGxibOoaJXrXJyowVb/01xyB2Pxl1gRLu/r
 MYPz2AwzACKxrCU9MdUi2Bzf6PnOXts=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-wwkLQbrdMPyOZKnGL1DO2g-1; Thu, 01 Jun 2023 08:31:16 -0400
X-MC-Unique: wwkLQbrdMPyOZKnGL1DO2g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30af222c5feso450801f8f.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 05:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685622675; x=1688214675;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OPbGiZXpoCZouy16UC3L3jg1Og+l9FR+1Wa7/lyKwTk=;
 b=LjdWHUDhQK3xnTDRY2Yb5SrtEOBtxIq3oKYgDLDMB1cEdqhhQj4+UYInT5HN4+sW+8
 ib4XThx5olGfUsj2D2vSzF0GS9sB7CG0MvjJFpfPGjoEPVO+v9SaALyCO32t8O17qwfn
 aypiJQfFmRJFDbgmESbc8iFA/QUbzgW0nXvmNTxot1+vtveP2//4B0w2t3LcZqkV/pTp
 V9dc6x9/CUBS3g+cgEshRxJK5Eaw3B82xjl40pzjvZe8MZ7wioGwsKQXgCQ3Em6aAsB5
 BBBWq0NhO5Hg4s0C7JP8+6O6IfQbODqP/8Si0MmEDFrnGkyupFlcIEemFtkDT/7CsIXf
 huDA==
X-Gm-Message-State: AC+VfDw6y6J0sxUzIagOYKqYC72xtK+E9WLwkWQ3gVdIz4TTNo3KvFGk
 HXoS+1VqyCQU9N+74xuon7ubM0jBRuhHAYvBGsJM6IZOG5m1eRgM7KurqdXBAq0+04tzoPIReIC
 +J43ZVbA+f3nyk6k=
X-Received: by 2002:a5d:5742:0:b0:30a:d450:8fae with SMTP id
 q2-20020a5d5742000000b0030ad4508faemr1719193wrw.33.1685622675522; 
 Thu, 01 Jun 2023 05:31:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4mj/co2nlzq5MVHoie28ebKe+Tl408xonaxZ0V04hr132IwPHW4VpWYzFryN/JobX9+xSPPA==
X-Received: by 2002:a5d:5742:0:b0:30a:d450:8fae with SMTP id
 q2-20020a5d5742000000b0030ad4508faemr1719175wrw.33.1685622675253; 
 Thu, 01 Jun 2023 05:31:15 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 p17-20020a056000019100b00306415ac69asm10099066wrx.15.2023.06.01.05.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 05:31:14 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 7/9] tests/qtest: capture RESUME events during migration
In-Reply-To: <20230531132400.1129576-8-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 31 May 2023 14:23:58
 +0100")
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-8-berrange@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 01 Jun 2023 14:31:13 +0200
Message-ID: <87edmvs6su.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> When running migration tests we monitor for a STOP event so we can skip
> redundant waits. This will be needed for the RESUME event too shortly.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qtest/migration-helpers.c | 12 ++++++++++++
>  tests/qtest/migration-helpers.h |  2 ++
>  tests/qtest/migration-test.c    |  5 +++++
>  3 files changed, 19 insertions(+)
>
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-help=
ers.c
> index 884d8a2e07..d50b565967 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -35,6 +35,18 @@ bool migrate_watch_for_stop(QTestState *who, const cha=
r *name,
>      return false;
>  }
>=20=20
> +bool migrate_watch_for_resume(QTestState *who, const char *name,
> +                              QDict *event, void *opaque)
> +{
> +    bool *seen =3D opaque;
> +
> +    if (g_str_equal(name, "RESUME")) {
> +        *seen =3D true;
> +    }
> +
> +    return false;
> +}
> +

I think I am not understanding this.

Can we wait for both RESUME and STOP events?

Or do you want an implementation that can only look for one event?

Later, Juan.


