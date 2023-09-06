Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D2C793A30
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 12:47:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdq3R-0007cv-Qi; Wed, 06 Sep 2023 06:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qdq3J-0007WN-2T
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 06:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qdq3F-0007L2-Rl
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 06:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693997185;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0MpFgV4WHywhWdM5SnYO7w2kcF3nd4t5RAnz0sToFrY=;
 b=fajvy36ZTGiHgQQyXkXdSvMmfZ2fPuVJNMkDsD3pl6epOH6sXW16zP0rIvq5Hn1Z4xVfSz
 Y84ym9EVw/xsPeW6JmekfU8b0v7oWHpxZhITDL3BfiO3AtlRyGOUZK32VtMWz9McPOYlO4
 pJ1g1A7MCybNqMTQYMzS06GYAGAJuhk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-tmGTc_-mOUeEia2eSDF1lA-1; Wed, 06 Sep 2023 06:46:19 -0400
X-MC-Unique: tmGTc_-mOUeEia2eSDF1lA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A37A805BFB;
 Wed,  6 Sep 2023 10:46:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C7DF140E950;
 Wed,  6 Sep 2023 10:46:18 +0000 (UTC)
Date: Wed, 6 Sep 2023 11:46:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 4/4] migration/qapi: Drop @MigrationParameter enum
Message-ID: <ZPhYeLjiOV3eq/4f@redhat.com>
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-5-peterx@redhat.com>
 <c5937e59-e267-519a-cf57-bf051b07304f@linaro.org>
 <ZPg/xagpvBW62h4w@redhat.com>
 <2edd3a6f-f23d-9a77-db47-4288fe3dbb44@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2edd3a6f-f23d-9a77-db47-4288fe3dbb44@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 06, 2023 at 12:14:54PM +0200, Philippe Mathieu-Daudé wrote:
> On 6/9/23 11:00, Daniel P. Berrangé wrote:
> > On Wed, Sep 06, 2023 at 06:42:16AM +0200, Philippe Mathieu-Daudé wrote:
> > > On 5/9/23 18:23, Peter Xu wrote:
> > > > Drop the enum in qapi because it is never used in QMP APIs.  Instead making
> > > > it an internal definition for QEMU so that we can decouple it from QAPI,
> > > > and also we can deduplicate the QAPI documentations.
> > > > 
> > > > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >    qapi/migration.json            | 179 ---------------------------------
> > > >    migration/options.h            |  47 +++++++++
> > > >    migration/migration-hmp-cmds.c |   3 +-
> > > >    migration/options.c            |  51 ++++++++++
> > > >    4 files changed, 100 insertions(+), 180 deletions(-)
> > > 
> > > 
> > > > diff --git a/migration/options.h b/migration/options.h
> > > > index 124a5d450f..4591545c62 100644
> > > > --- a/migration/options.h
> > > > +++ b/migration/options.h
> > > > @@ -66,6 +66,53 @@ bool migrate_cap_set(int cap, bool value, Error **errp);
> > > >    /* parameters */
> > > > +typedef enum {
> > > > +    MIGRATION_PARAMETER_ANNOUNCE_INITIAL,
> > > > +    MIGRATION_PARAMETER_ANNOUNCE_MAX,
> > > > +    MIGRATION_PARAMETER_ANNOUNCE_ROUNDS,
> > > > +    MIGRATION_PARAMETER_ANNOUNCE_STEP,
> > > > +    MIGRATION_PARAMETER_COMPRESS_LEVEL,
> > > > +    MIGRATION_PARAMETER_COMPRESS_THREADS,
> > > > +    MIGRATION_PARAMETER_DECOMPRESS_THREADS,
> > > > +    MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD,
> > > > +    MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD,
> > > > +    MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL,
> > > > +    MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT,
> > > > +    MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW,
> > > > +    MIGRATION_PARAMETER_TLS_CREDS,
> > > > +    MIGRATION_PARAMETER_TLS_HOSTNAME,
> > > > +    MIGRATION_PARAMETER_TLS_AUTHZ,
> > > > +    MIGRATION_PARAMETER_MAX_BANDWIDTH,
> > > > +    MIGRATION_PARAMETER_DOWNTIME_LIMIT,
> > > > +    MIGRATION_PARAMETER_X_CHECKPOINT_DELAY,
> > > > +    MIGRATION_PARAMETER_BLOCK_INCREMENTAL,
> > > > +    MIGRATION_PARAMETER_MULTIFD_CHANNELS,
> > > > +    MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE,
> > > > +    MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH,
> > > > +    MIGRATION_PARAMETER_MAX_CPU_THROTTLE,
> > > > +    MIGRATION_PARAMETER_MULTIFD_COMPRESSION,
> > > > +    MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL,
> > > > +    MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL,
> > > > +    MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING,
> > > > +    MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD,
> > > > +    MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT,
> > > > +    MIGRATION_PARAMETER__MAX,
> > > 
> > > MIGRATION_PARAMETER__MAX is not part of the enum, so:
> > > 
> > >     #define MIGRATION_PARAMETER__MAX \
> > >         (MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT + 1)
> > 
> > IMHO the way it currently is written is better, because the
> > __MAX value is guaranteed to always have the right max value
> > without needing to be manually changed when new params are
> > added. Note this matches the code style used by the QAPI
> > enum generator too.
> 
> This concern comes from a previous discussion with Richard (which I
> can't find now in the archives) where he explained to me __MAX is not
> part of the enum set, thus reduces the coverage of compiler sanitizers
> / optimizers, and could introduce subtle bugs.
> 
> This motivated this series:
> https://lore.kernel.org/qemu-devel/20230315112811.22355-4-philmd@linaro.org/
> which should have changed that generated QAPI enum.
> 
> (I didn't respin that series because I couldn't find an easy way to
>  handle conditionals, see
>  https://lore.kernel.org/qemu-devel/87sfdyaq0m.fsf@pond.sub.org/)

Oh, I completely forgot about that series.

So the original problem is that with '-Wswitch' present, if  the
switched variable is an enum type, the compiler complains if you
don't list all possible enum values, or have a default: clause.

Thus the existance of __MAX forces use to add case ...__MAX, or
have a default, and you wanted to eliminate that requirement.

Or the surface that sounds reasonable, but I actually think that
is the conceptually wrong approach from a robustness POV.

C (and some other languages) are terrible wrt enum declared
constants vs actual stored values.

You can have a variable declared KeyValueKind and it can store
absolutely any integer value at all, whether intentionally,
or by a code mistake or by data corruption.

In your example you modified:

        switch (key->key->type) {
        case KEY_VALUE_KIND_NUMBER:
            qcode = qemu_input_key_number_to_qcode(key->key->u.number.data);
            name = QKeyCode_str(qcode);
            trace_input_event_key_number(idx, key->key->u.number.data,
                                         name, key->down);
            break;
        case KEY_VALUE_KIND_QCODE:
            name = QKeyCode_str(key->key->u.qcode.data);
            trace_input_event_key_qcode(idx, name, key->down);
            break;
        case KEY_VALUE_KIND__MAX:
            /* keep gcc happy */
            break;
        }

to remove KEY_VALUE_KIND__MAX.

What we should actually do IMHO is to either change it to

   default:
       g_assert_not_reached();

Or get extra paranoid and  -Wswitch-enum too and list both
together

   case KEY_VALUE_KIND__MAX:
   default:
       g_assert_not_reached();

This forces us to validate every enum case, and also protect
against out of range values.

This is a little more verbose to code, but I can't say it
has been a maint problem in libvirt where we've followed
this approach with -Wswitch-enum and _MAX constants.

> Back to this patch, I don't object to having MIGRATION_PARAMETER__MAX
> in the enum, but I'd rather have the suggestion below considered.

I just prefer to see consistency in approach across the codebase, and
currently we use __MAX approach.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


