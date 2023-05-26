Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2BC712CDF
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 20:54:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2cZB-00072I-1f; Fri, 26 May 2023 14:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1q2cZ9-000721-8d
 for qemu-devel@nongnu.org; Fri, 26 May 2023 14:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1q2cZ0-0007zf-TB
 for qemu-devel@nongnu.org; Fri, 26 May 2023 14:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685127202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kAn2HwbHdsyvFX0tyAYL0RoykzACuXlbehwwoLUZIzo=;
 b=fnbwChfMfOUCjrzNg4f6YE5Rw4/I20IqU5J9Ctyyw/+JN4cxwQlP/i9r3k4Jjs3epDrYha
 +UF2GD+7YiqxNNUpkLZ3knPEgyfsy9IBpIo33VL2ayx+m4X9cyYeu3lEmcSgLNbVSoJwmU
 MAshZEn0Kn9nMX0TtiGK7pMKPFm1esM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-wVEvubGuONKdbCc0LofsVQ-1; Fri, 26 May 2023 14:53:20 -0400
X-MC-Unique: wVEvubGuONKdbCc0LofsVQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f6a96a6170so15647111cf.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 11:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685127200; x=1687719200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kAn2HwbHdsyvFX0tyAYL0RoykzACuXlbehwwoLUZIzo=;
 b=EGJvzW0jJ8zxABZYnLHEpXyzI3U8iqEp3PTl4GJ3ZRFkSNTcaQzX8LgFphkW6ql+fW
 +SYI05eGqlN0ZIf/ga+T9P4H/I9l8RNDS1cXJHM23g+oCOh48WOqIsy2ZJ/A/ra5dfDz
 UdticWtR6nRFxpi2MZE/TcaQFg8iquofKria6rq3pJYPo8B96ZALScbXrwov/aFTSqqx
 IteQpKGMZxsffuxIXiT6XNS01fLOUKj2hEjasJvTF4iZ+94+Rwa/9tKwjOraEiH4k226
 voDiISg34lpBVeGIIXU38v75qPmfzv9h6OCz0u+akAy+VHJ9amEQESheU/CkyKLvQcWG
 c5/A==
X-Gm-Message-State: AC+VfDzqPvMKZcOyQ+Mk3JI0wkSk1kAgQK4ZIHVL3TKOrVtPY3AGFJQ/
 4Xe150RS02ttWXgsg9sw4BMx1eqv1CDKS/HGU8LLMnzGG9lmUGXkHVOzKxXSD39RUbTk+5mvWcb
 GyxqTTUsL6VYpiRpS+paaTnefv36o9RE=
X-Received: by 2002:ac8:5795:0:b0:3f5:4da8:1a83 with SMTP id
 v21-20020ac85795000000b003f54da81a83mr3055202qta.3.1685127200372; 
 Fri, 26 May 2023 11:53:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5GgVhXWCosQnjV8c+Y9oi0gc2dodytb3wX6S049X6BOmDAGs+liJyIecZ5fkHpbjrHj1ydKQCixtVs3auLFUA=
X-Received: by 2002:ac8:5795:0:b0:3f5:4da8:1a83 with SMTP id
 v21-20020ac85795000000b003f54da81a83mr3055182qta.3.1685127200146; Fri, 26 May
 2023 11:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-4-quintela@redhat.com>
 <35a04e2de57e02745c18076990ce63fa6f61f5a4.camel@redhat.com>
 <875y8f4it8.fsf@secure.mitica>
In-Reply-To: <875y8f4it8.fsf@secure.mitica>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Fri, 26 May 2023 15:53:09 -0300
Message-ID: <CAJ6HWG4TY=N56BBq6UmHC_unznHLMd7uwvo4_cT0GTrYUKGRWQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] migration: Move setup_time to mig_stats
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Greg Kurz <groug@kaod.org>, 
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, 
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, 
 David Hildenbrand <david@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, qemu-block@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lsoaresp@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, May 26, 2023 at 5:07=E2=80=AFAM Juan Quintela <quintela@redhat.com>=
 wrote:
>
> Leonardo Br=C3=A1s <leobras@redhat.com> wrote:
> > On Mon, 2023-05-15 at 21:56 +0200, Juan Quintela wrote:
> >> It is a time that needs to be cleaned each time cancel migration.
> >> Once there create migration_time_since() to calculate how time since a
> >> time in the past.
> >>
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >>
> >> ---
> >>
> >> Rename to migration_time_since (c=C3=A9dric)
> >> ---
> >>  migration/migration-stats.h | 13 +++++++++++++
> >>  migration/migration.h       |  1 -
> >>  migration/migration-stats.c |  7 +++++++
> >>  migration/migration.c       |  9 ++++-----
> >>  4 files changed, 24 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> >> index e782f1b0df..21402af9e4 100644
> >> --- a/migration/migration-stats.h
> >> +++ b/migration/migration-stats.h
> >> @@ -75,6 +75,10 @@ typedef struct {
> >>       * Number of bytes sent during precopy stage.
> >>       */
> >>      Stat64 precopy_bytes;
> >> +    /*
> >> +     * How long has the setup stage took.
> >> +     */
> >> +    Stat64 setup_time;
> >>      /*
> >>       * Total number of bytes transferred.
> >>       */
> >> @@ -87,4 +91,13 @@ typedef struct {
> >>
> >>  extern MigrationAtomicStats mig_stats;
> >>
> >> +/**
> >> + * migration_time_since: Calculate how much time has passed
> >> + *
> >> + * @stats: migration stats
> >> + * @since: reference time since we want to calculate
> >> + *
> >> + * Returns: Nothing.  The time is stored in val.
> >> + */
> >> +void migration_time_since(MigrationAtomicStats *stats, int64_t since)=
;
> >>  #endif
> >> diff --git a/migration/migration.h b/migration/migration.h
> >> index 48a46123a0..27aa3b1035 100644
> >> --- a/migration/migration.h
> >> +++ b/migration/migration.h
> >> @@ -316,7 +316,6 @@ struct MigrationState {
> >>      int64_t downtime;
> >>      int64_t expected_downtime;
> >>      bool capabilities[MIGRATION_CAPABILITY__MAX];
> >> -    int64_t setup_time;
> >>      /*
> >>       * Whether guest was running when we enter the completion stage.
> >>       * If migration is interrupted by any reason, we need to continue
> >> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
> >> index 2f2cea965c..3431453c90 100644
> >> --- a/migration/migration-stats.c
> >> +++ b/migration/migration-stats.c
> >> @@ -12,6 +12,13 @@
> >>
> >>  #include "qemu/osdep.h"
> >>  #include "qemu/stats64.h"
> >> +#include "qemu/timer.h"
> >>  #include "migration-stats.h"
> >>
> >>  MigrationAtomicStats mig_stats;
> >> +
> >> +void migration_time_since(MigrationAtomicStats *stats, int64_t since)
> >> +{
> >> +    int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
> >> +    stat64_set(&stats->setup_time, now - since);
> >> +}
> >
> > IIUC this calculates a time delta and saves on stats->setup_time, is th=
at right?
> >
> > It took me some time to understand that, since the function name is
> > migration_time_since(), which seems more generic.
> >
> > Would not be more intuitive to name it migration_setup_time_set() or so=
?
>
> Dropped this.
> Other reviewer commented that this was not a counter, what is right.  So
> I left the times for future work (it don't interfere with current
> cleanups).

Oh, it makes sense.

>
>
> > I could not see MigrationState->setup_time being initialized as 0 in th=
is patch.
> > In a quick look in the code I noticed there is no initialization of thi=
s struct,
> > but on qemu_savevm_state() and migrate_prepare() we have:
> >
> > memset(&mig_stats, 0, sizeof(mig_stats));
> >
> > I suppose this is enough, right?
>
> Yeap.  All migration_stats() are initialized to zero at the start of
> qemu, or when we start a migration.
>
> After a migration, it don't matter if it finished with/without error,
> they are there with the right value until we start another migration (in
> the case of error, of course).

That's great to simplify the code.
Thanks!

>
> Later, Juan.
>


