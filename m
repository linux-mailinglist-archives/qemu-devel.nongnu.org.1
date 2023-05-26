Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A93712CF5
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 21:00:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2cew-00015e-Hf; Fri, 26 May 2023 14:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1q2ceu-00014Q-02
 for qemu-devel@nongnu.org; Fri, 26 May 2023 14:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1q2ces-00026d-9i
 for qemu-devel@nongnu.org; Fri, 26 May 2023 14:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685127565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jCksdv77Y4XLdOGGXxGAMVOJQFLHTDhZI8K3aG7sZsU=;
 b=WRg9Zean8zn0lXqW3FJXKa8Xx/1fUK+atEZW19FES86X4zEBBuSv9fr0hTP788yLOVxrIu
 AZZqvh/zdupXAyHpQrnuypvko0LwqTbKyrMucV7o5HFW5LWlPIY8IyqMV5qEnUDHkWUL2I
 HXNGzBMOTOXcE//EhIkuAodlBHY9V2s=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-QtqeUK7UPp-0NCGP20YHZg-1; Fri, 26 May 2023 14:59:24 -0400
X-MC-Unique: QtqeUK7UPp-0NCGP20YHZg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f6b0c739adso7075781cf.3
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 11:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685127563; x=1687719563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jCksdv77Y4XLdOGGXxGAMVOJQFLHTDhZI8K3aG7sZsU=;
 b=U8XhD3GkSerjk/XqBf2jhQ53mURR5rH2VOw8IUcMgOmnQdMlisj1KCzKuKC9cgJE9q
 zWq77bLHsmDVf1H7Yw/Y4XPs6xQTtAhDdZBtfn7vZ/04cEIluf/+TDkhfOm6P2bb2rSr
 MkUwOS/Otb58QdZwb/Xxb0wi6mu87pxpg9k5kzsJwJUBs+y7nq81sHF+ktUiQHFJEzVy
 wAP/PJsN3AMuU2mI8IS89sDYfNWKIIudSbZmAOPgEM85+7EoSf7jFqaDvOXgSvhOZyG6
 hTN/WNM/zOBTBf4RRVhvmGbg7btmGAAst/QTyne3lFL8OwkuTdA34gNcJkQQaWVhYROU
 yZ5Q==
X-Gm-Message-State: AC+VfDwc+XxoJppE2rqdhnmFlSYUnRp6L7aPZbGled2vZRdDNqEGJ1Ea
 qcpPz5Xahd7HJipkoJTu2SapRZxi2ez9fEG7nD+LsPAuNnLlg4JpKIFkVzrPCcwS53Qm0vkNT6y
 mDvju2bevHZ8TRlxFOEQ2WutWG9DmzlCNso6SJekOKg==
X-Received: by 2002:a05:622a:86:b0:3f6:a490:49c0 with SMTP id
 o6-20020a05622a008600b003f6a49049c0mr2838285qtw.49.1685127563392; 
 Fri, 26 May 2023 11:59:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5yWl4xEudEtTjqQMeMXSVZw1eUWLkgxX+qZf1nYePbIExzq2MCSYmjk/ezaUhVQU75kbyN1Zau/2uXGILqWyE=
X-Received: by 2002:a05:622a:86:b0:3f6:a490:49c0 with SMTP id
 o6-20020a05622a008600b003f6a49049c0mr2838271qtw.49.1685127563137; Fri, 26 May
 2023 11:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-9-quintela@redhat.com>
 <6f0660992a1bab629c52f5c3a869e730e299a0e8.camel@redhat.com>
 <87wn0v33sv.fsf@secure.mitica>
In-Reply-To: <87wn0v33sv.fsf@secure.mitica>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Fri, 26 May 2023 15:59:12 -0300
Message-ID: <CAJ6HWG6XO_LUSnny-Nj-wuE2YpsYnN97dakirUfdOnDn1UX4qw@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] migration: Use migration_transferred_bytes() to
 calculate rate_limit
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lsoaresp@redhat.com;
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

On Fri, May 26, 2023 at 5:17=E2=80=AFAM Juan Quintela <quintela@redhat.com>=
 wrote:
>
> Leonardo Br=C3=A1s <leobras@redhat.com> wrote:
> > On Mon, 2023-05-15 at 21:57 +0200, Juan Quintela wrote:
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> ---
> >>  migration/migration-stats.h | 8 +++++++-
> >>  migration/migration-stats.c | 7 +++++--
> >>  migration/migration.c       | 2 +-
> >>  3 files changed, 13 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> >> index 91fda378d3..f1465c2ebe 100644
> >> --- a/migration/migration-stats.h
> >> +++ b/migration/migration-stats.h
> >> @@ -81,6 +81,10 @@ typedef struct {
> >>       * Number of bytes sent during precopy stage.
> >>       */
> >>      Stat64 precopy_bytes;
> >> +    /*
> >> +     * Amount of transferred data at the start of current cycle.
> >> +     */
> >> +    Stat64 rate_limit_start;
> >>      /*
> >>       * Maximum amount of data we can send in a cycle.
> >>       */
> >> @@ -136,8 +140,10 @@ uint64_t migration_rate_get(void);
> >>   * migration_rate_reset: Reset the rate limit counter.
> >>   *
> >>   * This is called when we know we start a new transfer cycle.
> >> + *
> >> + * @f: QEMUFile used for main migration channel
> >>   */
> >> -void migration_rate_reset(void);
> >> +void migration_rate_reset(QEMUFile *f);
> >>
> >>  /**
> >>   * migration_rate_set: Set the maximum amount that can be transferred=
.
> >> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
> >> index 301392d208..da2bb69a15 100644
> >> --- a/migration/migration-stats.c
> >> +++ b/migration/migration-stats.c
> >> @@ -31,7 +31,9 @@ bool migration_rate_exceeded(QEMUFile *f)
> >>          return true;
> >>      }
> >>
> >> -    uint64_t rate_limit_used =3D stat64_get(&mig_stats.rate_limit_use=
d);
> >> +    uint64_t rate_limit_start =3D stat64_get(&mig_stats.rate_limit_st=
art);
> >> +    uint64_t rate_limit_current =3D migration_transferred_bytes(f);
> >> +    uint64_t rate_limit_used =3D rate_limit_current - rate_limit_star=
t;
> >>      uint64_t rate_limit_max =3D stat64_get(&mig_stats.rate_limit_max)=
;
> >
> > So, IIUC, instead of updating mig_stats.rate_limit_used every time data=
 is sent,
> > the idea is to 'reset' it to migration_transferred_bytes() at the begin=
ning of a
> > cycle, and read migration_transferred_bytes() again for checking if the=
 limit
> > was not crossed.
> >
> > Its a nice change since there is no need to update 2 counters, when 1 i=
s enough.
> >
> > I think it would look nicer if squashed with 9/16, though. It would mak=
e it more
> > clear this is being added to replace migration_rate_account() strategy.
> >
> > What do you think?
>
> Already in tree.

My bad.
After I ended up reviewing the patchset I noticed a lot of it was
already in the PULL request.

>
> Done this way because on my tree there was an intermediate patch that
> did something like:
>
>
>     uint64_t rate_limit_used =3D stat64_get(&mig_stats.rate_limit_used);
>     uint64_t rate_limit_start =3D stat64_get(&mig_stats.rate_limit_start)=
;
>     uint64_t rate_limit_current =3D migration_transferred_bytes(f);
>     uint64_t rate_limit_used_new =3D rate_limit_current - rate_limit_star=
t;
>
>     if (rate_limit_used_new !=3D rate_limit_used) {
>         printf("rate_limit old %lu new %lu\n", ...);
>     }
>
> So I was sure that the counter that I was replacing had the same value
> that the new one.

Oh, I see.
You kept both to verify the implementation.
Makes sense

>
> This is the reason why I fixed transferred atomic in the previous patch,
> not because it mattered on the big scheme of things (migration_test was
> missing something like 100KB for the normal stage when I started, that
> for calculations don't matter).  But to check if I was doing the things
> right it mattered.  With that patch my replacement counter was exact,
> and none of the if's triggered.
>
> Except for the device transffer stages, there I missed something like
> 900KB, but it made no sense to go all over the tree to fix a counter
> that I was going to remove later.

Yeah, it makes no sense to invest time on stuff that will be removed later.

Thanks for helping me understand this :)

>
> Regards, Juan.
>


