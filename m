Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B69A78F8C9
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 08:56:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qby3z-0003az-3k; Fri, 01 Sep 2023 02:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1qby3w-0003Uv-Pb
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 02:55:24 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1qby3s-0007nV-Ew
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 02:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693551320; x=1725087320;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=va4WA/2GvBMKbkF/txgT3/8lU1v4C7mB1KcgdymUzLM=;
 b=fJEKoEj4WWLGgkFgVg+e+Kn4cGAMF36lup+E/nZitLxq5e2gAxq7U4aD
 uvVF+xjljHLWXDI84HETdhMR4x/+ZjZETogzE6xa9NTq+LjzbYyakEo+i
 2hQ0NTxTSb0VidVPPwcQmJkJB0zBQ0emK9c0suAFgPvt4mPhAFga0bVaZ
 mMsW0K+A2Kj8KZ8/2z8auccCYITxEVeoSSjjXq6KgS+s3Cs8HfXKv1BRf
 iZ6JMiFdaBrVGl+7RU67NaEUmGrfKTWJImII+SfZextAbSNRmJxmNlqI3
 edD7XfKDyJi+M7SrOKIk2XcQQPmz3K8g0AkyUrWt34dzco/ffMS+TJXES A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="442545673"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; d="scan'208";a="442545673"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2023 23:55:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070624540"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; d="scan'208";a="1070624540"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.93.21.21])
 ([10.93.21.21])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2023 23:55:10 -0700
Message-ID: <8bb36b56-e2f6-ece8-0d8f-90b87a3b5c40@intel.com>
Date: Fri, 1 Sep 2023 14:55:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH for-8.2 v2 2/2] migration: Allow user to specify migration
 switchover bandwidth
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Zhiyi Guo <zhguo@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Eric Blake <eblake@redhat.com>, Chensheng Dong <chdong@redhat.com>
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-3-peterx@redhat.com>
From: "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <20230803155344.11450-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.100; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -78
X-Spam_score: -7.9
X-Spam_bar: -------
X-Spam_report: (-7.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.478, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 8/3/2023 23:53, Peter Xu wrote:
> Migration bandwidth is a very important value to live migration.  It's
> because it's one of the major factors that we'll make decision on when to
> switchover to destination in a precopy process.
> 
> This value is currently estimated by QEMU during the whole live migration
> process by monitoring how fast we were sending the data.  This can be the
> most accurate bandwidth if in the ideal world, where we're always feeding
> unlimited data to the migration channel, and then it'll be limited to the
> bandwidth that is available.
> 
> However in reality it may be very different, e.g., over a 10Gbps network we
> can see query-migrate showing migration bandwidth of only a few tens of
> MB/s just because there are plenty of other things the migration thread
> might be doing.  For example, the migration thread can be busy scanning
> zero pages, or it can be fetching dirty bitmap from other external dirty
> sources (like vhost or KVM).  It means we may not be pushing data as much
> as possible to migration channel, so the bandwidth estimated from "how many
> data we sent in the channel" can be dramatically inaccurate sometimes,
> e.g., that a few tens of MB/s even if 10Gbps available, and then the
> decision to switchover will be further affected by this.
> 
> The migration may not even converge at all with the downtime specified,
> with that wrong estimation of bandwidth.
> 
> The issue is QEMU itself may not be able to avoid those uncertainties on
> measuing the real "available migration bandwidth".  At least not something
> I can think of so far.
> 
> One way to fix this is when the user is fully aware of the available
> bandwidth, then we can allow the user to help providing an accurate value.
> 
> For example, if the user has a dedicated channel of 10Gbps for migration
> for this specific VM, the user can specify this bandwidth so QEMU can
> always do the calculation based on this fact, trusting the user as long as
> specified.
> 
> A new parameter "max-switchover-bandwidth" is introduced just for this. So
> when the user specified this parameter, instead of trusting the estimated
> value from QEMU itself (based on the QEMUFile send speed), let's trust the
> user more by using this value to decide when to switchover, assuming that
> we'll have such bandwidth available then.
> 
> When the user wants to have migration only use 5Gbps out of that 10Gbps,
> one can set max-bandwidth to 5Gbps, along with max-switchover-bandwidth to
> 5Gbps so it'll never use over 5Gbps too (so the user can have the rest

Hi Peter. I'm curious if we specify max-switchover-bandwidth to 5Gbps over a
10Gbps network, in the completion stage will it send the remaining data in 5Gbps
using downtime_limit time or in 10Gbps (saturate the network) using the
downtime_limit / 2 time? Seems this parameter won't rate limit the final stage:)

> 5Gbps for other things).  So it can be useful even if the network is not
> dedicated, but as long as the user can know a solid value.
> 
> This can resolve issues like "unconvergence migration" which is caused by
> hilarious low "migration bandwidth" detected for whatever reason.
> 
> Reported-by: Zhiyi Guo <zhguo@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/migration.json            | 14 +++++++++++++-
>  migration/migration.h          |  2 +-
>  migration/options.h            |  1 +
>  migration/migration-hmp-cmds.c | 14 ++++++++++++++
>  migration/migration.c          | 19 +++++++++++++++----
>  migration/options.c            | 28 ++++++++++++++++++++++++++++
>  migration/trace-events         |  2 +-
>  7 files changed, 73 insertions(+), 7 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index bb798f87a5..6a04fb7d36 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -759,6 +759,16 @@
>  # @max-bandwidth: to set maximum speed for migration.  maximum speed
>  #     in bytes per second.  (Since 2.8)
>  #
> +# @max-switchover-bandwidth: to set available bandwidth for migration.
> +#     By default, this value is zero, means the user is not aware of
> +#     the available bandwidth that can be used by QEMU migration, so
> +#     QEMU will estimate the bandwidth automatically.  This can be set
> +#     when the estimated value is not accurate, while the user is able
> +#     to guarantee such bandwidth is available for migration purpose
> +#     during the migration procedure.  When specified correctly, this
> +#     can make the switchover decision much more accurate, which will
> +#     also be based on the max downtime specified.  (Since 8.2)
> +#
>  # @downtime-limit: set maximum tolerated downtime for migration.
>  #     maximum downtime in milliseconds (Since 2.8)
>  #
> @@ -840,7 +850,7 @@
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'cpu-throttle-tailslow',
>             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
> -           'downtime-limit',
> +           'max-switchover-bandwidth', 'downtime-limit',
>             { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
>             'block-incremental',
>             'multifd-channels',
> @@ -885,6 +895,7 @@
>              '*tls-hostname': 'StrOrNull',
>              '*tls-authz': 'StrOrNull',
>              '*max-bandwidth': 'size',
> +            '*max-switchover-bandwidth': 'size',
>              '*downtime-limit': 'uint64',
>              '*x-checkpoint-delay': { 'type': 'uint32',
>                                       'features': [ 'unstable' ] },
> @@ -949,6 +960,7 @@
>              '*tls-hostname': 'str',
>              '*tls-authz': 'str',
>              '*max-bandwidth': 'size',
> +            '*max-switchover-bandwidth': 'size',
>              '*downtime-limit': 'uint64',
>              '*x-checkpoint-delay': { 'type': 'uint32',
>                                       'features': [ 'unstable' ] },
> diff --git a/migration/migration.h b/migration/migration.h
> index 6eea18db36..f18cee27f7 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -283,7 +283,7 @@ struct MigrationState {
>      /*
>       * The final stage happens when the remaining data is smaller than
>       * this threshold; it's calculated from the requested downtime and
> -     * measured bandwidth
> +     * measured bandwidth, or max-switchover-bandwidth if specified.
>       */
>      int64_t threshold_size;
>  
> diff --git a/migration/options.h b/migration/options.h
> index 045e2a41a2..a510ca94c9 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -80,6 +80,7 @@ int migrate_decompress_threads(void);
>  uint64_t migrate_downtime_limit(void);
>  uint8_t migrate_max_cpu_throttle(void);
>  uint64_t migrate_max_bandwidth(void);
> +uint64_t migrate_max_switchover_bandwidth(void);
>  uint64_t migrate_max_postcopy_bandwidth(void);
>  int migrate_multifd_channels(void);
>  MultiFDCompression migrate_multifd_compression(void);
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index c115ef2d23..d7572d4c0a 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -321,6 +321,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
>              params->max_bandwidth);
> +        assert(params->has_max_switchover_bandwidth);
> +        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_MAX_SWITCHOVER_BANDWIDTH),
> +            params->max_switchover_bandwidth);
>          assert(params->has_downtime_limit);
>          monitor_printf(mon, "%s: %" PRIu64 " ms\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
> @@ -574,6 +578,16 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          }
>          p->max_bandwidth = valuebw;
>          break;
> +    case MIGRATION_PARAMETER_MAX_SWITCHOVER_BANDWIDTH:
> +        p->has_max_switchover_bandwidth = true;
> +        ret = qemu_strtosz_MiB(valuestr, NULL, &valuebw);
> +        if (ret < 0 || valuebw > INT64_MAX
> +            || (size_t)valuebw != valuebw) {
> +            error_setg(&err, "Invalid size %s", valuestr);
> +            break;
> +        }
> +        p->max_switchover_bandwidth = valuebw;
> +        break;
>      case MIGRATION_PARAMETER_DOWNTIME_LIMIT:
>          p->has_downtime_limit = true;
>          visit_type_size(v, param, &p->downtime_limit, &err);
> diff --git a/migration/migration.c b/migration/migration.c
> index 5528acb65e..8493e3ca49 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2684,7 +2684,7 @@ static void migration_update_counters(MigrationState *s,
>  {
>      uint64_t transferred, transferred_pages, time_spent;
>      uint64_t current_bytes; /* bytes transferred since the beginning */
> -    double bandwidth;
> +    double bandwidth, avail_bw;
>  
>      if (current_time < s->iteration_start_time + BUFFER_DELAY) {
>          return;
> @@ -2694,7 +2694,17 @@ static void migration_update_counters(MigrationState *s,
>      transferred = current_bytes - s->iteration_initial_bytes;
>      time_spent = current_time - s->iteration_start_time;
>      bandwidth = (double)transferred / time_spent;
> -    s->threshold_size = bandwidth * migrate_downtime_limit();
> +    if (migrate_max_switchover_bandwidth()) {
> +        /*
> +         * If the user specified an available bandwidth, let's trust the
> +         * user so that can be more accurate than what we estimated.
> +         */
> +        avail_bw = migrate_max_switchover_bandwidth();
> +    } else {
> +        /* If the user doesn't specify bandwidth, we use the estimated */
> +        avail_bw = bandwidth;
> +    }
> +    s->threshold_size = avail_bw * migrate_downtime_limit();
>  
>      s->mbps = (((double) transferred * 8.0) /
>                 ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
> @@ -2711,7 +2721,7 @@ static void migration_update_counters(MigrationState *s,
>      if (stat64_get(&mig_stats.dirty_pages_rate) &&
>          transferred > 10000) {
>          s->expected_downtime =
> -            stat64_get(&mig_stats.dirty_bytes_last_sync) / bandwidth;
> +            stat64_get(&mig_stats.dirty_bytes_last_sync) / avail_bw;
>      }
>  
>      migration_rate_reset(s->to_dst_file);
> @@ -2719,7 +2729,8 @@ static void migration_update_counters(MigrationState *s,
>      update_iteration_initial_status(s);
>  
>      trace_migrate_transferred(transferred, time_spent,
> -                              bandwidth, s->threshold_size);
> +                              bandwidth, migrate_max_switchover_bandwidth(),
> +                              s->threshold_size);
>  }
>  
>  static bool migration_can_switchover(MigrationState *s)
> diff --git a/migration/options.c b/migration/options.c
> index 1d1e1321b0..19d87ab812 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -125,6 +125,8 @@ Property migration_properties[] = {
>                        parameters.cpu_throttle_tailslow, false),
>      DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
>                        parameters.max_bandwidth, MAX_THROTTLE),
> +    DEFINE_PROP_SIZE("max-switchover-bandwidth", MigrationState,
> +                      parameters.max_switchover_bandwidth, 0),
>      DEFINE_PROP_UINT64("x-downtime-limit", MigrationState,
>                        parameters.downtime_limit,
>                        DEFAULT_MIGRATE_SET_DOWNTIME),
> @@ -780,6 +782,13 @@ uint64_t migrate_max_bandwidth(void)
>      return s->parameters.max_bandwidth;
>  }
>  
> +uint64_t migrate_max_switchover_bandwidth(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->parameters.max_switchover_bandwidth;
> +}
> +
>  uint64_t migrate_max_postcopy_bandwidth(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -917,6 +926,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>                                   s->parameters.tls_authz : "");
>      params->has_max_bandwidth = true;
>      params->max_bandwidth = s->parameters.max_bandwidth;
> +    params->has_max_switchover_bandwidth = true;
> +    params->max_switchover_bandwidth = s->parameters.max_switchover_bandwidth;
>      params->has_downtime_limit = true;
>      params->downtime_limit = s->parameters.downtime_limit;
>      params->has_x_checkpoint_delay = true;
> @@ -1056,6 +1067,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>          return false;
>      }
>  
> +    if (params->has_max_switchover_bandwidth &&
> +        (params->max_switchover_bandwidth > SIZE_MAX)) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                   "max_switchover_bandwidth",
> +                   "an integer in the range of 0 to "stringify(SIZE_MAX)
> +                   " bytes/second");
> +        return false;
> +    }
> +
>      if (params->has_downtime_limit &&
>          (params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> @@ -1225,6 +1245,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>          dest->max_bandwidth = params->max_bandwidth;
>      }
>  
> +    if (params->has_max_switchover_bandwidth) {
> +        dest->max_switchover_bandwidth = params->max_switchover_bandwidth;
> +    }
> +
>      if (params->has_downtime_limit) {
>          dest->downtime_limit = params->downtime_limit;
>      }
> @@ -1341,6 +1365,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>          }
>      }
>  
> +    if (params->has_max_switchover_bandwidth) {
> +        s->parameters.max_switchover_bandwidth = params->max_switchover_bandwidth;
> +    }
> +
>      if (params->has_downtime_limit) {
>          s->parameters.downtime_limit = params->downtime_limit;
>      }
> diff --git a/migration/trace-events b/migration/trace-events
> index 4666f19325..1296b8db5b 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -185,7 +185,7 @@ source_return_path_thread_shut(uint32_t val) "0x%x"
>  source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
>  source_return_path_thread_switchover_acked(void) ""
>  migration_thread_low_pending(uint64_t pending) "%" PRIu64
> -migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
> +migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " avail_bw %" PRIu64 " max_size %" PRId64
>  process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
>  process_incoming_migration_co_postcopy_end_main(void) ""
>  postcopy_preempt_enabled(bool value) "%d"

