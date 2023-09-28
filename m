Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F9A7B1080
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 03:57:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlgGB-000865-Te; Wed, 27 Sep 2023 21:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1qlgGA-00085s-66
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 21:56:10 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1qlgG6-0002sd-24
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 21:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695866166; x=1727402166;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=jYj34lHMlpX2nyMfcx4cQQAoc7BTejPkU9uIuTWTVr0=;
 b=CRZekgsaXIYHipzOMSroyirhhghQMBLV1hxOP50xRa++JepWmhm1WqeK
 wz4bnGRSlJIt8RIr0IlqyUQmpEklR88A5eOGuY040ilN89rbEzOBw2wzW
 UX3kdU6HtMOK4X3wnsd6qVYCSzMbnxM7VFJYu/n2MVFkDVzsuiCxQfZJH
 p4m1mYIirDyl7eAZBnBy/5A8roAJmjVGoiWTUo8x60EYgtoQMu/xbIaAf
 zcA2O1T2ZaXv6rgim9AylrCNXpul2p6j4w5gPFUnnzvgsxV/Wn6Q4hSuq
 mAn8bLpCHq3ss9MGcuYh7mSvVCvtTHIwkLbKpFeiy1holICwUj59yPs1+ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="575605"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="575605"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2023 18:55:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="819678592"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; d="scan'208";a="819678592"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.93.8.73])
 ([10.93.8.73])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2023 18:55:49 -0700
Message-ID: <35b4b8d2-3cb1-819f-28d2-5eeff3db789c@intel.com>
Date: Thu, 28 Sep 2023 09:55:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH 1/5] migration: Store downtime timestamps in an array
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
References: <20230926161841.98464-1-joao.m.martins@oracle.com>
 <20230926161841.98464-2-joao.m.martins@oracle.com>
From: "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <20230926161841.98464-2-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, SPF_HELO_NONE=0.001,
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

On 9/27/2023 0:18, Joao Martins wrote:
> Right now downtime_start is stored in MigrationState.
> 
> In preparation to having more downtime timestamps during
> switchover, move downtime_start to an array namely, @timestamp.
> 
> Add a setter/getter surrounding which timestamps to record,
> to make it easier to spread to various migration functions.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  qapi/migration.json   | 14 ++++++++++++++
>  migration/migration.h |  7 +++++--
>  migration/migration.c | 24 ++++++++++++++++++++----
>  3 files changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8843e74b59c7..b836cc881d33 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -190,6 +190,20 @@
>  { 'struct': 'VfioStats',
>    'data': {'transferred': 'int' } }
>  
> +##
> +# @MigrationDowntime:
> +#
> +# An enumeration of downtime timestamps for all
> +# steps of the switchover.
> +#
> +# @start:Timestamp taken at the start of the switchover right before
           ^
Suggest adding a space here to keep consistent with other attributes.


> +#        we stop the VM.
> +#
> +# Since: 8.2
> +##
> +{ 'enum': 'MigrationDowntime',
> +  'data': [ 'start' ] }
> +
>  ##
>  # @MigrationInfo:
>  #
> diff --git a/migration/migration.h b/migration/migration.h
> index c390500604b6..180dc31c5306 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -319,8 +319,8 @@ struct MigrationState {
>      int64_t start_time;
>      /* Total time used by latest migration (ms) */
>      int64_t total_time;
> -    /* Timestamp when VM is down (ms) to migrate the last stuff */
> -    int64_t downtime_start;
> +    /* Timestamps e.g. when VM is down (ms) to migrate the last stuff */
> +    int64_t timestamp[MIGRATION_DOWNTIME__MAX];
>      int64_t downtime;
>      int64_t expected_downtime;
>      bool capabilities[MIGRATION_CAPABILITY__MAX];
> @@ -516,4 +516,7 @@ void migration_populate_vfio_info(MigrationInfo *info);
>  void migration_reset_vfio_bytes_transferred(void);
>  void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
>  
> +void migration_set_timestamp(MigrationDowntime tm);
> +int64_t migration_get_timestamp(MigrationDowntime tm);
> +
>  #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index d61e5727429a..dd955c61acc7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2312,6 +2312,21 @@ static int migration_maybe_pause(MigrationState *s,
>      return s->state == new_state ? 0 : -EINVAL;
>  }
>  
> +void migration_set_timestamp(MigrationDowntime type)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    s->timestamp[type] = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +}
> +
> +int64_t migration_get_timestamp(MigrationDowntime type)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->timestamp[type];
> +}
> +
> +
>  /**
>   * migration_completion: Used by migration_thread when there's not much left.
>   *   The caller 'breaks' the loop when this returns.
> @@ -2325,7 +2340,7 @@ static void migration_completion(MigrationState *s)
>  
>      if (s->state == MIGRATION_STATUS_ACTIVE) {
>          qemu_mutex_lock_iothread();
> -        s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +        migration_set_timestamp(MIGRATION_DOWNTIME_START);
>          qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>  
>          s->vm_old_state = runstate_get();
> @@ -2670,7 +2685,7 @@ static void migration_calculate_complete(MigrationState *s)
>           * It's still not set, so we are precopy migration.  For
>           * postcopy, downtime is calculated during postcopy_start().
>           */
> -        s->downtime = end_time - s->downtime_start;
> +        s->downtime = end_time - migration_get_timestamp(MIGRATION_DOWNTIME_START);
>      }
>  
>      transfer_time = s->total_time - s->setup_time;
> @@ -3069,7 +3084,8 @@ static void bg_migration_vm_start_bh(void *opaque)
>      s->vm_start_bh = NULL;
>  
>      vm_start();
> -    s->downtime = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - s->downtime_start;
> +    s->downtime = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) -
> +             migration_get_timestamp(MIGRATION_DOWNTIME_START);
>  }
>  
>  /**
> @@ -3134,7 +3150,7 @@ static void *bg_migration_thread(void *opaque)
>      s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
>  
>      trace_migration_thread_setup_complete();
> -    s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    migration_set_timestamp(MIGRATION_DOWNTIME_START);
>  
>      qemu_mutex_lock_iothread();
>  

