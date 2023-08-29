Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E59878C39C
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 13:50:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaxDp-0002VC-DJ; Tue, 29 Aug 2023 07:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qaxDh-0002Ui-SE
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 07:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qaxDd-0004Mg-BD
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 07:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693309752;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SH/JCDjl+MmT0z/kQiH4z/5LXmUfgXKAETeUfn1ds0A=;
 b=a9mdiLVSr44GODB/HTeHSARshXts1S2XwOnVHwk0jDF05aPGDtj9ZNkZuA1L9mt6PuIMgk
 XvjwJsxJ11Rrs7F0TtXeXVEK3ktWEOdXYcbOPGlKXzdE+lRURulZ+r1zZf31n5ZiB4huD1
 V1TxZZ6Dk9gkeiNUsi4inJEKWlJgS3Q=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-oL4iRpVvNlelWzTSR0x4jg-1; Tue, 29 Aug 2023 07:49:10 -0400
X-MC-Unique: oL4iRpVvNlelWzTSR0x4jg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 213D33C11C6E;
 Tue, 29 Aug 2023 11:49:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AAFF40C2070;
 Tue, 29 Aug 2023 11:49:08 +0000 (UTC)
Date: Tue, 29 Aug 2023 12:49:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 3/4] migration/qapi: Replace @MigrateSetParameters
 with @MigrationParameters
Message-ID: <ZO3bMgs83E+cFBcR@redhat.com>
References: <20230825171517.1215317-1-peterx@redhat.com>
 <20230825171517.1215317-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230825171517.1215317-4-peterx@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

On Fri, Aug 25, 2023 at 01:15:16PM -0400, Peter Xu wrote:
> Quotting from Markus in his replies:
> 
>   migrate-set-parameters sets migration parameters, and
>   query-migrate-parameters gets them.  Unsurprisingly, the former's
>   argument type MigrateSetParameters is quite close to the latter's
>   return type MigrationParameters.  The differences are subtle:
> 
>   1. Since migrate-set-parameters supports setting selected parameters,
>      its arguments must all be optional (so you can omit the ones you
>      don't want to change).  query-migrate-parameters results are also
>      all optional, but almost all of them are in fact always present.
> 
>   2. For parameters @tls_creds, @tls_hostname, @tls_authz,
>      migrate-set-parameters interprets special value "" as "reset to
>      default".  Works, because "" is semantically invalid.  Not a
>      general solution, because a semantically invalid value need not
>      exist.  Markus added a general solution in commit 01fa559826
>      ("migration: Use JSON null instead of "" to reset parameter to
>      default").  This involved changing the type from 'str' to
>      'StrOrNull'.
> 
>   3. When parameter @block-bitmap-mapping has not been set,
>      query-migrate-parameters does not return it (absent optional
>      member).  Clean (but undocumented).  When parameters @tls_creds,
>      @tls_hostname, @tls_authz have not been set, it returns the
>      semantically invalid value "".  Not so clean (and just as
>      undocumented).
> 
> Here to deduplicate the two objects: keep @MigrationParameters as the name
> of object to use in both places, drop @MigrateSetParameters, at the
> meantime switch types of @tls* fields from "str" to "StrOrNull" types.
> 
> I found that the TLS code wasn't so much relying on tls_* fields being
> non-NULL at all.  Actually on the other way round: if we set tls_authz to
> an empty string (NOTE: currently, migrate_init() missed initializing
> tls_authz; also touched it up in this patch), we can already fail one of
> the migration-test (tls/x509/default-host), as qauthz_is_allowed_by_id()
> will assume tls_authz set even if tls_auths is an empty string.
> 
> It means we're actually relying on tls_* fields being NULL even if it's the
> empty string.
> 
> Let's just make it a rule to return NULL for empty string on these fields
> internally.  For that, when converting a StrOrNull into a char* (where we
> introduced a helper here in this patch) we'll also make the empty string to
> be NULL, to make it always work.  And it doesn't show any issue either when
> applying that logic to both tls_creds and tls_hostname.
> 
> With above, we can safely change both migration_tls_client_create() and
> migrate_tls() to not check the empty string too finally.. not needed
> anymore.
> 
> Also, we can drop the hackish conversions in qmp_migrate_set_parameters()
> where we want to make sure it's a QSTRING; it's not needed now.
> 
> This greatly deduplicates the code not only in qapi/migration.json, but
> also in the generic migration code.
> 
> Markus helped greatly with this patch.  Besides a better commit
> message (where I just "stole" from the reply), debugged and resolved a
> double free, but also provided the StrOrNull property implementation to be
> used in MigrationState object when switching tls_* fields to StrOrNull.
> 
> Co-developed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/migration.json            | 191 +---------------------------
>  include/hw/qdev-properties.h   |   3 +
>  migration/options.h            |   3 +
>  hw/core/qdev-properties.c      |  40 ++++++
>  migration/migration-hmp-cmds.c |  20 +--
>  migration/options.c            | 220 ++++++++++-----------------------
>  migration/tls.c                |   3 +-
>  7 files changed, 125 insertions(+), 355 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


