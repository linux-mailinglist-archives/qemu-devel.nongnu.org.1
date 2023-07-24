Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 528EC75FECA
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 20:05:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNzvE-0005OP-0d; Mon, 24 Jul 2023 14:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qNzvC-0005O3-4M
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 14:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qNzv9-00016K-M1
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 14:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690221874;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SreYiWPl+BqDwZAb3f1Pf+oWEp4b8G38jvPt6l5Cbco=;
 b=MQ7ifuX0DQRFKQUp3W50smlFQZHQJcXi1EIlCk63r2JvmPj8OkrH9LDFGaIBTVkwB+w0tA
 j1gmm6ca4JuPUURD2LB4ArmUzifjtxQWvW+pWlTMG0jyE2Q/Iv7JQnQBFJMfqRJDY+LiYi
 ibJa7AqEQ4INyStsjOhwW7r/hlmL5VQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-lOOXSfc1MkKRis3fLoAKQg-1; Mon, 24 Jul 2023 14:04:33 -0400
X-MC-Unique: lOOXSfc1MkKRis3fLoAKQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1DF11C03DA7;
 Mon, 24 Jul 2023 18:04:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D342C2C7D3;
 Mon, 24 Jul 2023 18:04:31 +0000 (UTC)
Date: Mon, 24 Jul 2023 19:04:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Chensheng Dong <chdong@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
Message-ID: <ZL69LTVHhNzEjqGM@redhat.com>
References: <20230724170755.1114519-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724170755.1114519-1-peterx@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jul 24, 2023 at 01:07:55PM -0400, Peter Xu wrote:
> Migration bandwidth is a very important value to live migration.  It's
> because it's one of the major factors that we'll make decision on when to
> switchover to destination in a precopy process.

To elaborate on this for those reading along...

QEMU takes maxmimum downtime limit and multiplies by its estimate
of bandwidth. This gives a figure for the amount of data QEMU thinks
it can transfer within the downtime period.

QEMU compares this figure to the amount of data that is still pending
at the end of an iteration.

> This value is currently estimated by QEMU during the whole live migration
> process by monitoring how fast we were sending the data.  This can be the
> most accurate bandwidth if in the ideal world, where we're always feeding
> unlimited data to the migration channel, and then it'll be limited to the
> bandwidth that is available.

The QEMU estimate for available bandwidth will definitely be wrong,
potentially by orders of magnitude, if QEMU has a max bandwidth limit
set, as in that case it is never trying to push the peak rates available
from the NICs/network fabric.

> The issue is QEMU itself may not be able to avoid those uncertainties on
> measuing the real "available migration bandwidth".  At least not something
> I can think of so far.

IIUC, you can query the NIC properties to find the hardware transfer
rate of the NICs. That doesn't imply apps can actually reach that
rate in practice - it has a decent chance of being a over-estimate
of bandwidth, possibly very very much over.

Is such an over estimate better or worse than QEMU's current
under-estimate ? It depends on the POV.

From the POV of QEMU, over-estimating means means it'll be not
be throttling as much as it should. That's not a downside of
migration - it makes it more likely for migration to complete :-)

From the POV of non-QEMU apps though, if QEMU over-estimates,
it'll mean other apps get starved of network bandwidth.

Overall I agree, there's no obvious way QEMU can ever come up
with a reliable estimate for bandwidth available.

> One way to fix this is when the user is fully aware of the available
> bandwidth, then we can allow the user to help providing an accurate value.
>
> For example, if the user has a dedicated channel of 10Gbps for migration
> for this specific VM, the user can specify this bandwidth so QEMU can
> always do the calculation based on this fact, trusting the user as long as
> specified.

I can see that in theory, but when considering a non-trivial
deployments of QEMU, I wonder if the user can really have any
such certainty of what is truely avaialble. It would need
global awareness of the whole network of hosts & workloads.

> When the user wants to have migration only use 5Gbps out of that 10Gbps,
> one can set max-bandwidth to 5Gbps, along with available-bandwidth to 5Gbps
> so it'll never use over 5Gbps too (so the user can have the rest 5Gbps for
> other things).  So it can be useful even if the network is not dedicated,
> but as long as the user can know a solid value.
> 
> A new parameter "available-bandwidth" is introduced just for this. So when
> the user specified this parameter, instead of trusting the estimated value
> from QEMU itself (based on the QEMUFile send speed), let's trust the user
> more.

I feel like rather than "available-bandwidth", we should call
it "max-convergance-bandwidth".

To me that name would better reflect the fact that this isn't
really required to be a measure of how much NIC bandwidth is
available. It is merely an expression of a different bandwidth
limit to apply during switch over.

IOW

* max-bandwidth: limit during pre-copy main transfer
* max-convergance-bandwidth: limit during pre-copy switch-over
* max-postcopy-banwidth: limit during post-copy phase



> This can resolve issues like "unconvergence migration" which is caused by
> hilarious low "migration bandwidth" detected for whatever reason.
> 
> Reported-by: Zhiyi Guo <zhguo@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/migration.json            | 20 +++++++++++++++++++-
>  migration/migration.h          |  2 +-
>  migration/options.h            |  1 +
>  migration/migration-hmp-cmds.c | 14 ++++++++++++++
>  migration/migration.c          | 19 +++++++++++++++----
>  migration/options.c            | 28 ++++++++++++++++++++++++++++
>  migration/trace-events         |  2 +-
>  7 files changed, 79 insertions(+), 7 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 47dfef0278..fdc269e0a1 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -730,6 +730,16 @@
>  # @max-bandwidth: to set maximum speed for migration.  maximum speed
>  #     in bytes per second.  (Since 2.8)
>  #
> +# @available-bandwidth: to set available bandwidth for migration.  By
> +#     default, this value is zero, means the user is not aware of the
> +#     available bandwidth that can be used by QEMU migration, so QEMU will
> +#     estimate the bandwidth automatically.  This can be set when the
> +#     estimated value is not accurate, while the user is able to guarantee
> +#     such bandwidth is available for migration purpose during the
> +#     migration procedure.  When specified correctly, this can make the
> +#     switchover decision much more accurate, which will also be based on
> +#     the max downtime specified.  (Since 8.2)
> +#
>  # @downtime-limit: set maximum tolerated downtime for migration.
>  #     maximum downtime in milliseconds (Since 2.8)
>  #
> @@ -803,7 +813,7 @@
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'cpu-throttle-tailslow',
>             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
> -           'downtime-limit',
> +           'available-bandwidth', 'downtime-limit',
>             { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
>             'block-incremental',
>             'multifd-channels',
> @@ -886,6 +896,9 @@
>  # @max-bandwidth: to set maximum speed for migration.  maximum speed
>  #     in bytes per second.  (Since 2.8)
>  #
> +# @available-bandwidth: to set available migration bandwidth.  Please refer
> +#     to comments in MigrationParameter for more information. (Since 8.2)
> +#
>  # @downtime-limit: set maximum tolerated downtime for migration.
>  #     maximum downtime in milliseconds (Since 2.8)
>  #
> @@ -971,6 +984,7 @@
>              '*tls-hostname': 'StrOrNull',
>              '*tls-authz': 'StrOrNull',
>              '*max-bandwidth': 'size',
> +            '*available-bandwidth': 'size',
>              '*downtime-limit': 'uint64',
>              '*x-checkpoint-delay': { 'type': 'uint32',
>                                       'features': [ 'unstable' ] },
> @@ -1078,6 +1092,9 @@
>  # @max-bandwidth: to set maximum speed for migration.  maximum speed
>  #     in bytes per second.  (Since 2.8)
>  #
> +# @available-bandwidth: to set available migration bandwidth.  Please refer
> +#     to comments in MigrationParameter for more information. (Since 8.2)
> +#
>  # @downtime-limit: set maximum tolerated downtime for migration.
>  #     maximum downtime in milliseconds (Since 2.8)
>  #
> @@ -1160,6 +1177,7 @@
>              '*tls-hostname': 'str',
>              '*tls-authz': 'str',
>              '*max-bandwidth': 'size',
> +            '*available-bandwidth': 'size',
>              '*downtime-limit': 'uint64',
>              '*x-checkpoint-delay': { 'type': 'uint32',
>                                       'features': [ 'unstable' ] },
> diff --git a/migration/migration.h b/migration/migration.h
> index b7c8b67542..fadbf64d9d 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -283,7 +283,7 @@ struct MigrationState {
>      /*
>       * The final stage happens when the remaining data is smaller than
>       * this threshold; it's calculated from the requested downtime and
> -     * measured bandwidth
> +     * measured bandwidth, or available-bandwidth if user specified.
>       */
>      int64_t threshold_size;
>  
> diff --git a/migration/options.h b/migration/options.h
> index 9aaf363322..ed2d9c92e7 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -79,6 +79,7 @@ int migrate_decompress_threads(void);
>  uint64_t migrate_downtime_limit(void);
>  uint8_t migrate_max_cpu_throttle(void);
>  uint64_t migrate_max_bandwidth(void);
> +uint64_t migrate_available_bandwidth(void);
>  uint64_t migrate_max_postcopy_bandwidth(void);
>  int migrate_multifd_channels(void);
>  MultiFDCompression migrate_multifd_compression(void);
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 9885d7c9f7..53fbe1b1af 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -311,6 +311,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
>              params->max_bandwidth);
> +        assert(params->has_available_bandwidth);
> +        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_AVAILABLE_BANDWIDTH),
> +            params->available_bandwidth);
>          assert(params->has_downtime_limit);
>          monitor_printf(mon, "%s: %" PRIu64 " ms\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
> @@ -556,6 +560,16 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          }
>          p->max_bandwidth = valuebw;
>          break;
> +    case MIGRATION_PARAMETER_AVAILABLE_BANDWIDTH:
> +        p->has_available_bandwidth = true;
> +        ret = qemu_strtosz_MiB(valuestr, NULL, &valuebw);
> +        if (ret < 0 || valuebw > INT64_MAX
> +            || (size_t)valuebw != valuebw) {
> +            error_setg(&err, "Invalid size %s", valuestr);
> +            break;
> +        }
> +        p->available_bandwidth = valuebw;
> +        break;
>      case MIGRATION_PARAMETER_DOWNTIME_LIMIT:
>          p->has_downtime_limit = true;
>          visit_type_size(v, param, &p->downtime_limit, &err);
> diff --git a/migration/migration.c b/migration/migration.c
> index 91bba630a8..391ddfd8ce 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2671,7 +2671,7 @@ static void migration_update_counters(MigrationState *s,
>  {
>      uint64_t transferred, transferred_pages, time_spent;
>      uint64_t current_bytes; /* bytes transferred since the beginning */
> -    double bandwidth;
> +    double bandwidth, avail_bw;
>  
>      if (current_time < s->iteration_start_time + BUFFER_DELAY) {
>          return;
> @@ -2681,7 +2681,17 @@ static void migration_update_counters(MigrationState *s,
>      transferred = current_bytes - s->iteration_initial_bytes;
>      time_spent = current_time - s->iteration_start_time;
>      bandwidth = (double)transferred / time_spent;
> -    s->threshold_size = bandwidth * migrate_downtime_limit();
> +    if (migrate_available_bandwidth()) {
> +        /*
> +         * If the user specified an available bandwidth, let's trust the
> +         * user so that can be more accurate than what we estimated.
> +         */
> +        avail_bw = migrate_available_bandwidth();
> +    } else {
> +        /* If the user doesn't specify bandwidth, we use the estimated */
> +        avail_bw = bandwidth;
> +    }
> +    s->threshold_size = avail_bw * migrate_downtime_limit();
>  
>      s->mbps = (((double) transferred * 8.0) /
>                 ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
> @@ -2698,7 +2708,7 @@ static void migration_update_counters(MigrationState *s,
>      if (stat64_get(&mig_stats.dirty_pages_rate) &&
>          transferred > 10000) {
>          s->expected_downtime =
> -            stat64_get(&mig_stats.dirty_bytes_last_sync) / bandwidth;
> +            stat64_get(&mig_stats.dirty_bytes_last_sync) / avail_bw;
>      }
>  
>      migration_rate_reset(s->to_dst_file);
> @@ -2706,7 +2716,8 @@ static void migration_update_counters(MigrationState *s,
>      update_iteration_initial_status(s);
>  
>      trace_migrate_transferred(transferred, time_spent,
> -                              bandwidth, s->threshold_size);
> +                              bandwidth, migrate_available_bandwidth(),
> +                              s->threshold_size);
>  }
>  
>  static bool migration_can_switchover(MigrationState *s)
> diff --git a/migration/options.c b/migration/options.c
> index 5a9505adf7..160faca71a 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -121,6 +121,8 @@ Property migration_properties[] = {
>                        parameters.cpu_throttle_tailslow, false),
>      DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
>                        parameters.max_bandwidth, MAX_THROTTLE),
> +    DEFINE_PROP_SIZE("available-bandwidth", MigrationState,
> +                      parameters.available_bandwidth, 0),
>      DEFINE_PROP_UINT64("x-downtime-limit", MigrationState,
>                        parameters.downtime_limit,
>                        DEFAULT_MIGRATE_SET_DOWNTIME),
> @@ -735,6 +737,13 @@ uint64_t migrate_max_bandwidth(void)
>      return s->parameters.max_bandwidth;
>  }
>  
> +uint64_t migrate_available_bandwidth(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->parameters.available_bandwidth;
> +}
> +
>  uint64_t migrate_max_postcopy_bandwidth(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -872,6 +881,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>                                   s->parameters.tls_authz : "");
>      params->has_max_bandwidth = true;
>      params->max_bandwidth = s->parameters.max_bandwidth;
> +    params->has_available_bandwidth = true;
> +    params->available_bandwidth = s->parameters.available_bandwidth;
>      params->has_downtime_limit = true;
>      params->downtime_limit = s->parameters.downtime_limit;
>      params->has_x_checkpoint_delay = true;
> @@ -1004,6 +1015,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>          return false;
>      }
>  
> +    if (params->has_available_bandwidth &&
> +        (params->available_bandwidth > SIZE_MAX)) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                   "available_bandwidth",
> +                   "an integer in the range of 0 to "stringify(SIZE_MAX)
> +                   " bytes/second");
> +        return false;
> +    }
> +
>      if (params->has_downtime_limit &&
>          (params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> @@ -1156,6 +1176,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>          dest->max_bandwidth = params->max_bandwidth;
>      }
>  
> +    if (params->has_available_bandwidth) {
> +        dest->available_bandwidth = params->available_bandwidth;
> +    }
> +
>      if (params->has_downtime_limit) {
>          dest->downtime_limit = params->downtime_limit;
>      }
> @@ -1264,6 +1288,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>          }
>      }
>  
> +    if (params->has_available_bandwidth) {
> +        s->parameters.available_bandwidth = params->available_bandwidth;
> +    }
> +
>      if (params->has_downtime_limit) {
>          s->parameters.downtime_limit = params->downtime_limit;
>      }
> diff --git a/migration/trace-events b/migration/trace-events
> index 5259c1044b..fffed1f995 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -184,7 +184,7 @@ source_return_path_thread_shut(uint32_t val) "0x%x"
>  source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
>  source_return_path_thread_switchover_acked(void) ""
>  migration_thread_low_pending(uint64_t pending) "%" PRIu64
> -migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
> +migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " avail_bw %" PRIu64 " max_size %" PRId64
>  process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
>  process_incoming_migration_co_postcopy_end_main(void) ""
>  postcopy_preempt_enabled(bool value) "%d"
> -- 
> 2.41.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


