Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8097679379F
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:01:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdoPJ-0008Hp-Bk; Wed, 06 Sep 2023 05:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qdoPH-0008Db-Fh
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qdoPE-0002MU-TP
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693990860;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Vu9NlWJz+jXJauoorEmtagNUvO5RxaQ68sAtMsIgYo=;
 b=Pk6lhmQoXorM6vFD8+FYRvdH7VKH7dg6TifrjzG21nBHYPPQkCR9TTrT3+HROyaWK4TqH1
 BDJA9SfxlejzDE/rjxpDeJcBiTU+pT0B8lIU42NvZEnM0GxdZi239zDx13GDtv9/edDsmU
 vAWk7I817KHtD3bDwItdVN8Nw3y6XkI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-IqBbIihcOOus29zqqCltGw-1; Wed, 06 Sep 2023 05:00:57 -0400
X-MC-Unique: IqBbIihcOOus29zqqCltGw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE12291BC29;
 Wed,  6 Sep 2023 09:00:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C99746F520;
 Wed,  6 Sep 2023 09:00:55 +0000 (UTC)
Date: Wed, 6 Sep 2023 10:00:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 4/4] migration/qapi: Drop @MigrationParameter enum
Message-ID: <ZPg/xagpvBW62h4w@redhat.com>
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-5-peterx@redhat.com>
 <c5937e59-e267-519a-cf57-bf051b07304f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5937e59-e267-519a-cf57-bf051b07304f@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

On Wed, Sep 06, 2023 at 06:42:16AM +0200, Philippe Mathieu-Daudé wrote:
> On 5/9/23 18:23, Peter Xu wrote:
> > Drop the enum in qapi because it is never used in QMP APIs.  Instead making
> > it an internal definition for QEMU so that we can decouple it from QAPI,
> > and also we can deduplicate the QAPI documentations.
> > 
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   qapi/migration.json            | 179 ---------------------------------
> >   migration/options.h            |  47 +++++++++
> >   migration/migration-hmp-cmds.c |   3 +-
> >   migration/options.c            |  51 ++++++++++
> >   4 files changed, 100 insertions(+), 180 deletions(-)
> 
> 
> > diff --git a/migration/options.h b/migration/options.h
> > index 124a5d450f..4591545c62 100644
> > --- a/migration/options.h
> > +++ b/migration/options.h
> > @@ -66,6 +66,53 @@ bool migrate_cap_set(int cap, bool value, Error **errp);
> >   /* parameters */
> > +typedef enum {
> > +    MIGRATION_PARAMETER_ANNOUNCE_INITIAL,
> > +    MIGRATION_PARAMETER_ANNOUNCE_MAX,
> > +    MIGRATION_PARAMETER_ANNOUNCE_ROUNDS,
> > +    MIGRATION_PARAMETER_ANNOUNCE_STEP,
> > +    MIGRATION_PARAMETER_COMPRESS_LEVEL,
> > +    MIGRATION_PARAMETER_COMPRESS_THREADS,
> > +    MIGRATION_PARAMETER_DECOMPRESS_THREADS,
> > +    MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD,
> > +    MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD,
> > +    MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL,
> > +    MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT,
> > +    MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW,
> > +    MIGRATION_PARAMETER_TLS_CREDS,
> > +    MIGRATION_PARAMETER_TLS_HOSTNAME,
> > +    MIGRATION_PARAMETER_TLS_AUTHZ,
> > +    MIGRATION_PARAMETER_MAX_BANDWIDTH,
> > +    MIGRATION_PARAMETER_DOWNTIME_LIMIT,
> > +    MIGRATION_PARAMETER_X_CHECKPOINT_DELAY,
> > +    MIGRATION_PARAMETER_BLOCK_INCREMENTAL,
> > +    MIGRATION_PARAMETER_MULTIFD_CHANNELS,
> > +    MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE,
> > +    MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH,
> > +    MIGRATION_PARAMETER_MAX_CPU_THROTTLE,
> > +    MIGRATION_PARAMETER_MULTIFD_COMPRESSION,
> > +    MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL,
> > +    MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL,
> > +    MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING,
> > +    MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD,
> > +    MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT,
> > +    MIGRATION_PARAMETER__MAX,
> 
> MIGRATION_PARAMETER__MAX is not part of the enum, so:
> 
>    #define MIGRATION_PARAMETER__MAX \
>        (MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT + 1)

IMHO the way it currently is written is better, because the
__MAX value is guaranteed to always have the right max value
without needing to be manually changed when new params are
added. Note this matches the code style used by the QAPI
enum generator too.

> 
> > +} MigrationParameter;
> > +
> > +extern const char *MigrationParameter_string[MIGRATION_PARAMETER__MAX];
> > +#define  MigrationParameter_str(p)  MigrationParameter_string[p]
> 
> Hmm this is only used once by HMP. Following our style I suggest here:
> 
>  const char *const MigrationParameter_string(enum MigrationParameter param);
> 
> And in options.c:
> 
>  static const char *const MigrationParameter_str[MIGRATION_PARAMETER__MAX] =
> {
>     ...
>  };
> 
>  const char *const MigrationParameter_string(enum MigrationParameter param)
>  {
>      return MigrationParameter_str[param];
>  }
> 
> > +
> > +/**
> > + * @MigrationParameter_from_str(): Parse string into a MigrationParameter
> > + *
> > + * @param: input string
> > + * @errp: error message if failed to parse the string
> > + *
> > + * Returns MigrationParameter enum (>=0) if succeed, or negative otherwise
> > + * which will always setup @errp.
> > + */
> > +int MigrationParameter_from_str(const char *param, Error **errp);
> > +
> >   const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void);
> >   bool migrate_has_block_bitmap_mapping(void);
> 
> With the changes:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


