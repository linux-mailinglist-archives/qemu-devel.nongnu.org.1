Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9F6B26A73
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Aug 2025 17:06:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umZVP-0007Q4-08; Thu, 14 Aug 2025 11:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umZVG-0007PG-Rm
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 11:04:30 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umZVA-0002CR-0s
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 11:04:30 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8261F1F7FB;
 Thu, 14 Aug 2025 15:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755183858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s8TJEu06uFulp/q90zpQLvm7ghobudW6QRB7m4gHlLA=;
 b=yJ3nooMyENy+/AsqqqvEHbiWvgazFZX3BVG3peHoi9hgowtqR3T8n3tTFhpm6qU4z2QlVe
 WbhcDoj5i3XF2rOXAQfgllnBZLXcgO38xOPw+h67HNFScJWH1JiEAZqgLuYbUx9xXlJ7q3
 dFOsOpvrpqGKTGTcz83yPsiRDE2rVTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755183858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s8TJEu06uFulp/q90zpQLvm7ghobudW6QRB7m4gHlLA=;
 b=TYf0ubF3jF/XAjJ0ynDnp4+1hPVr/bmFolHcWq0RvLpZVGgrgvIXcsJtcymJ95aahcmF4F
 UVOO8xxDYvV5vECg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yJ3nooMy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TYf0ubF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755183858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s8TJEu06uFulp/q90zpQLvm7ghobudW6QRB7m4gHlLA=;
 b=yJ3nooMyENy+/AsqqqvEHbiWvgazFZX3BVG3peHoi9hgowtqR3T8n3tTFhpm6qU4z2QlVe
 WbhcDoj5i3XF2rOXAQfgllnBZLXcgO38xOPw+h67HNFScJWH1JiEAZqgLuYbUx9xXlJ7q3
 dFOsOpvrpqGKTGTcz83yPsiRDE2rVTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755183858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s8TJEu06uFulp/q90zpQLvm7ghobudW6QRB7m4gHlLA=;
 b=TYf0ubF3jF/XAjJ0ynDnp4+1hPVr/bmFolHcWq0RvLpZVGgrgvIXcsJtcymJ95aahcmF4F
 UVOO8xxDYvV5vECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0FBB1368C;
 Thu, 14 Aug 2025 15:04:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wzmLK/H6nWhCBwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 14 Aug 2025 15:04:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v2 13/24] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_apply
In-Reply-To: <aJziBqu6H9pnMmE7@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-14-farosas@suse.de> <aJziBqu6H9pnMmE7@x1.local>
Date: Thu, 14 Aug 2025 12:04:14 -0300
Message-ID: <874iua0wsx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 8261F1F7FB
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Spam-Score: -4.51
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Jun 30, 2025 at 04:59:02PM -0300, Fabiano Rosas wrote:
>> Instead of setting parameters one by one, use the temporary object,
>> which already contains the current migration parameters plus the new
>> ones and was just validated by migration_params_check(). Use cloning
>> to overwrite it.
>> 
>> This avoids the need to alter this function every time a new parameter
>> is added.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/options.c | 123 +++-----------------------------------------
>>  1 file changed, 7 insertions(+), 116 deletions(-)
>> 
>> diff --git a/migration/options.c b/migration/options.c
>> index 4564db77f2..6619b5f21a 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -13,6 +13,7 @@
>>  
>>  #include "qemu/osdep.h"
>>  #include "qemu/error-report.h"
>> +#include "qemu/main-loop.h"
>>  #include "exec/target_page.h"
>>  #include "qapi/clone-visitor.h"
>>  #include "qapi/error.h"
>> @@ -1341,123 +1342,13 @@ static void migrate_params_test_apply(MigrationParameters *params,
>>  static void migrate_params_apply(MigrationParameters *params)
>>  {
>>      MigrationState *s = migrate_get_current();
>> +    MigrationParameters *cur = &s->parameters;
>>  
>> -    /* TODO use QAPI_CLONE() instead of duplicating it inline */
>> +    assert(bql_locked());
>>  
>> -    if (params->has_throttle_trigger_threshold) {
>> -        s->parameters.throttle_trigger_threshold = params->throttle_trigger_threshold;
>> -    }
>> -
>> -    if (params->has_cpu_throttle_initial) {
>> -        s->parameters.cpu_throttle_initial = params->cpu_throttle_initial;
>> -    }
>> -
>> -    if (params->has_cpu_throttle_increment) {
>> -        s->parameters.cpu_throttle_increment = params->cpu_throttle_increment;
>> -    }
>> -
>> -    if (params->has_cpu_throttle_tailslow) {
>> -        s->parameters.cpu_throttle_tailslow = params->cpu_throttle_tailslow;
>> -    }
>> -
>> -    if (params->tls_creds) {
>> -        qapi_free_StrOrNull(s->parameters.tls_creds);
>> -        s->parameters.tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
>> -    }
>> -
>> -    if (params->tls_hostname) {
>> -        qapi_free_StrOrNull(s->parameters.tls_hostname);
>> -        s->parameters.tls_hostname = QAPI_CLONE(StrOrNull,
>> -                                                params->tls_hostname);
>> -    }
>> -
>> -    if (params->tls_authz) {
>> -        qapi_free_StrOrNull(s->parameters.tls_authz);
>> -        s->parameters.tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
>> -    }
>> -
>> -    if (params->has_max_bandwidth) {
>> -        s->parameters.max_bandwidth = params->max_bandwidth;
>> -    }
>> -
>> -    if (params->has_avail_switchover_bandwidth) {
>> -        s->parameters.avail_switchover_bandwidth = params->avail_switchover_bandwidth;
>> -    }
>> -
>> -    if (params->has_downtime_limit) {
>> -        s->parameters.downtime_limit = params->downtime_limit;
>> -    }
>> -
>> -    if (params->has_x_checkpoint_delay) {
>> -        s->parameters.x_checkpoint_delay = params->x_checkpoint_delay;
>> -    }
>> -
>> -    if (params->has_multifd_channels) {
>> -        s->parameters.multifd_channels = params->multifd_channels;
>> -    }
>> -    if (params->has_multifd_compression) {
>> -        s->parameters.multifd_compression = params->multifd_compression;
>> -    }
>> -    if (params->has_multifd_qatzip_level) {
>> -        s->parameters.multifd_qatzip_level = params->multifd_qatzip_level;
>> -    }
>> -    if (params->has_multifd_zlib_level) {
>> -        s->parameters.multifd_zlib_level = params->multifd_zlib_level;
>> -    }
>> -    if (params->has_multifd_zstd_level) {
>> -        s->parameters.multifd_zstd_level = params->multifd_zstd_level;
>> -    }
>> -    if (params->has_xbzrle_cache_size) {
>> -        s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
>> -    }
>> -    if (params->has_max_postcopy_bandwidth) {
>> -        s->parameters.max_postcopy_bandwidth = params->max_postcopy_bandwidth;
>> -    }
>> -    if (params->has_max_cpu_throttle) {
>> -        s->parameters.max_cpu_throttle = params->max_cpu_throttle;
>> -    }
>> -    if (params->has_announce_initial) {
>> -        s->parameters.announce_initial = params->announce_initial;
>> -    }
>> -    if (params->has_announce_max) {
>> -        s->parameters.announce_max = params->announce_max;
>> -    }
>> -    if (params->has_announce_rounds) {
>> -        s->parameters.announce_rounds = params->announce_rounds;
>> -    }
>> -    if (params->has_announce_step) {
>> -        s->parameters.announce_step = params->announce_step;
>> -    }
>> -
>> -    if (params->has_block_bitmap_mapping) {
>> -        qapi_free_BitmapMigrationNodeAliasList(
>> -            s->parameters.block_bitmap_mapping);
>> -
>> -        s->has_block_bitmap_mapping = true;
>> -        s->parameters.block_bitmap_mapping =
>> -            QAPI_CLONE(BitmapMigrationNodeAliasList,
>> -                       params->block_bitmap_mapping);
>> -    }
>> -
>> -    if (params->has_x_vcpu_dirty_limit_period) {
>> -        s->parameters.x_vcpu_dirty_limit_period =
>> -            params->x_vcpu_dirty_limit_period;
>> -    }
>> -    if (params->has_vcpu_dirty_limit) {
>> -        s->parameters.vcpu_dirty_limit = params->vcpu_dirty_limit;
>> -    }
>> -
>> -    if (params->has_mode) {
>> -        s->parameters.mode = params->mode;
>> -    }
>> -
>> -    if (params->has_zero_page_detection) {
>> -        s->parameters.zero_page_detection = params->zero_page_detection;
>> -    }
>> -
>> -    if (params->has_direct_io) {
>> -        s->parameters.direct_io = params->direct_io;
>> -    }
>> +    migrate_tls_opts_free(cur);
>> +    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
>
> So we free these without resetting the pointers.  Now, for example,
> cur->tls_creds can point to garbage.  Then..
>
>> +    QAPI_CLONE_MEMBERS(MigrationParameters, cur, params);
>
> How does this patch guarantee cur->tls_creds's garbage pointer being
> updated?  What if params->tls_creds is NULL?  Could it?
>

As you've spotted later in the series, all callers of
migrate_params_apply() provide a MigrationParameters struct with all
has_* fields set.

>>  }
>>  
>>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>> @@ -1487,7 +1378,7 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>>      }
>>  
>>      if (migrate_params_check(&tmp, errp)) {
>> -        migrate_params_apply(params);
>> +        migrate_params_apply(&tmp);
>>          migrate_post_update_params(params, errp);
>>      }
>>  
>> -- 
>> 2.35.3
>> 

