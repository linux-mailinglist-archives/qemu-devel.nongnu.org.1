Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CFDA2364E
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Jan 2025 22:05:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdbi9-0000lg-1A; Thu, 30 Jan 2025 16:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tdbi6-0000l9-Mc
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 16:04:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tdbi4-0004Pt-Dm
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 16:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738271062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SJGXCeEPQsqG7eDg8JthAtKLlI3+2a6jIci8B1A70Vo=;
 b=UX4dcLQyF4zJxBaTYw6i3JJf7KuJ4g8za/faXXp1BhPDlr785uJJAlLaysM8Ar65t+nL8D
 Qc6lahybVs/QopajMg0c4mEeJEIKBaPiS+cxsdJzELBO7Zx2kx2Dznvpgm+yAYvZp87a/w
 xB62GMIk4Rl2ohxncmtj/fUqDFSBzBk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-l7Fd4ZO5NNKzDEJCl5NWmA-1; Thu, 30 Jan 2025 16:04:20 -0500
X-MC-Unique: l7Fd4ZO5NNKzDEJCl5NWmA-1
X-Mimecast-MFC-AGG-ID: l7Fd4ZO5NNKzDEJCl5NWmA
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7be6ccb09f9so127467485a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738271060; x=1738875860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJGXCeEPQsqG7eDg8JthAtKLlI3+2a6jIci8B1A70Vo=;
 b=mUgGZ9srNDDTBw4aWDNo3DKzFjXLycMca6cmAhZWvTGHKFR6Keyd35RSJZYvGZlrMO
 MBg8UttrQ4yKG9xnuvULwGldbeBm8Sz59G0eKM8cPLnH7oX1re+DcyY85kVhbwARymC7
 xgvleMjOyXW3IhDSJosJDJ/wuuDEam93Z042ZVld/jvZMPsrWr90Z8tMQjmHoObosfS2
 RzYjj9MmuxOx2PgoEEbMiVmG9x1tIxVoOM3bGF+1TFgJYT5BuSpEOaMJscOmKSnL43uh
 lKRob7PZb8HmeCEP31gVwBSlMllDJsYh3HAbH3wMIaE/NO6zHCmvQ1/zyDlkuyG/H11I
 fRRQ==
X-Gm-Message-State: AOJu0YzFisXJQSvolKgVDXSfxHNWZDGx0RILqaIuuHOnAgzzGlg4BGvT
 /wyM/14cBvkmAIvpZo6dj3ldONN8FfpyZD6PaTtcvJacmpbiaf06OvEe+Gn330nOCeeQLq8OKue
 eZshIBpsQq1ATPrQeQ5IXOUUeffpeCGbnNBp246EQzcewOR/Gl3bB
X-Gm-Gg: ASbGncsN2PS/DUrBbK6S+0HTZuCbxZXl2byFbX4XnJ+9GvW4Td+KXLE0cE0CW4j+Qcz
 eDuBkoJmqYWGle6ppU+qVs5IQCgO9nJcydWbKTV8V7h44iOhaRTKQsGDKac49ytIWxEAmJaz48i
 SEKONhL3sjhTtl6/8jtGEB+JlZSvBsoBWcpCdkmzKRWldN/4/aUVqW5F+nLmm7hZlxq0wneYhgw
 uKvkj6clOyOeR/mrVLIdezjIBNS23cBAPkhExaSrm6woe6HDbnLIPgHQUEcTyNb2nbP8Tq8U4em
 iJrWHVca2FQQrqs/qh13rYAfiQOiM7SLFEH1OvpHF1WISVH3
X-Received: by 2002:a05:620a:2942:b0:7b7:24b:dc58 with SMTP id
 af79cd13be357-7bffcd9018fmr1180574285a.43.1738271059837; 
 Thu, 30 Jan 2025 13:04:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9wm4mFEXKorYSEmtbgqQXgjAzMUL6X79rHrRuobspiW3dRURhj+a3tPH5Ij258EUehpsBfg==
X-Received: by 2002:a05:620a:2942:b0:7b7:24b:dc58 with SMTP id
 af79cd13be357-7bffcd9018fmr1180569985a.43.1738271059341; 
 Thu, 30 Jan 2025 13:04:19 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8c8eaasm112548485a.36.2025.01.30.13.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 13:04:18 -0800 (PST)
Date: Thu, 30 Jan 2025 16:04:15 -0500
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Add keepalive messages from dst to src during
 postcopy
Message-ID: <Z5vpTx3d3MYQL2pi@x1.local>
References: <20250130161139.548078-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250130161139.548078-1-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jan 30, 2025 at 05:11:36PM +0100, Juraj Marcin wrote:
> When there are no page requests from the destination side and the
> connection breaks, the destination might not be aware of it. This is
> the case for example with a TCP connection, which by default remains
> open unless it is explicitly closed or the TCP stack fails to
> successfully send a packet.
> 
> Such situation without any traffic from the destination to the source
> side can happen for multiple reasons. For example, if all pages accessed
> at idle are already migrated, but there are still non-migrated pages
> that are accessed very infrequently, or if the destination QEMU is
> started with '-S' option and the management application does not run
> the 'cont' QMP command right away.
> 
> Due to this, the destination side might not know about the network
> failure and stays in the postcopy-active state instead of switching
> to the postcopy-paused state, informing the destination management
> application about the issue.
> 
> This patch resolves this by sending a keepalive message on the return
> path to the source if there is no page fault (thus page request message)
> in a certain amount of time. This wait time can be configured with new
> 'postcopy-rp-keepalive-period' migration parameter, by default it is
> 60000 ms. By setting this parameter to 0, sending keepalive messages
> can be disabled completely.

Hmm, I see.. Does it mean it would also work if we leverage tcp keepalive
events?  I just checked on my system, indeed it can at least be too large a
default value:

$ sysctl net.ipv4.tcp_keepalive_time
net.ipv4.tcp_keepalive_time = 7200

I wonder if it makes more sense to set it to a smaller value.  What you
proposed here (60s) as default sounds more reasonable indeed at least to
me.

Is that a concern (e.g. tcp keepalive not enabled, or timeout too large) so
that maybe it's better we have our own way to timeout the session?  If so,
maybe worthwhile to add some comment on that.

> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  migration/migration.c    | 12 ++++++++++++
>  migration/migration.h    |  1 +
>  migration/options.c      | 35 +++++++++++++++++++++++++++++++++++
>  migration/options.h      |  1 +
>  migration/postcopy-ram.c | 15 ++++++++++++++-
>  migration/trace-events   |  2 ++
>  qapi/migration.json      | 35 ++++++++++++++++++++++++++++++++---
>  7 files changed, 97 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 2d1da917c7..ef049efd0a 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -89,6 +89,8 @@ enum mig_rp_message_type {
>      MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
>      MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do switchover */
>  
> +    MIG_RP_MSG_KEEPALIVE, /* Keepalive message from destination to source */
> +
>      MIG_RP_MSG_MAX
>  };
>  
> @@ -471,6 +473,12 @@ static int migrate_send_rp_message(MigrationIncomingState *mis,
>      return qemu_fflush(mis->to_src_file);
>  }
>  
> +void migrate_send_rp_keepalive(MigrationIncomingState *mis)
> +{
> +    trace_migrate_send_rp_keepalive();
> +    migrate_send_rp_message(mis, MIG_RP_MSG_KEEPALIVE, 0, NULL);
> +}
> +
>  /* Request one page from the source VM at the given start address.
>   *   rb: the RAMBlock to request the page in
>   *   Start: Address offset within the RB
> @@ -2399,6 +2407,10 @@ static void *source_return_path_thread(void *opaque)
>              trace_source_return_path_thread_switchover_acked();
>              break;
>  
> +        case MIG_RP_MSG_KEEPALIVE:
> +            trace_source_return_path_thread_received_keepalive();
> +            break;
> +
>          default:
>              break;

So we ignore unknown messages on return path.  I didn't expect it, but
looks like it means we can enable this without worrying about compatibility
with older QEMU binaries, am I right?

If so, worth add a sentence in the commit message for it too.

>          }
> diff --git a/migration/migration.h b/migration/migration.h
> index 0df2a187af..4ec7c63fc4 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -503,6 +503,7 @@ void migrate_send_rp_shut(MigrationIncomingState *mis,
>                            uint32_t value);
>  void migrate_send_rp_pong(MigrationIncomingState *mis,
>                            uint32_t value);
> +void migrate_send_rp_keepalive(MigrationIncomingState *mis);
>  int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
>                                ram_addr_t start, uint64_t haddr);
>  int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
> diff --git a/migration/options.c b/migration/options.c
> index b8d5300326..4df973467f 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -85,6 +85,12 @@
>  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
>  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
>  
> +/*
> + * Time in milliseconds for periodic keepalive message from destination to
> + * source during postcopy if there is no other traffic, 0: no keepalive messages
> + */
> +#define DEFAULT_MIGRATE_POSTCOPY_RP_KEEPALIVE_PERIOD 60000
> +
>  const Property migration_properties[] = {
>      DEFINE_PROP_BOOL("store-global-state", MigrationState,
>                       store_global_state, true),
> @@ -172,6 +178,9 @@ const Property migration_properties[] = {
>      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
>                         parameters.zero_page_detection,
>                         ZERO_PAGE_DETECTION_MULTIFD),
> +    DEFINE_PROP_UINT32("postcopy-rp-keepalive-period", MigrationState,
> +                       parameters.postcopy_rp_keepalive_period,
> +                       DEFAULT_MIGRATE_POSTCOPY_RP_KEEPALIVE_PERIOD),
>  
>      /* Migration capabilities */
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> @@ -837,6 +846,13 @@ ZeroPageDetection migrate_zero_page_detection(void)
>      return s->parameters.zero_page_detection;
>  }
>  
> +uint32_t migrate_postcopy_rp_keepalive_period(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->parameters.postcopy_rp_keepalive_period;
> +}
> +
>  /* parameters helpers */
>  
>  AnnounceParameters *migrate_announce_params(void)
> @@ -922,6 +938,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->zero_page_detection = s->parameters.zero_page_detection;
>      params->has_direct_io = true;
>      params->direct_io = s->parameters.direct_io;
> +    params->has_postcopy_rp_keepalive_period = true;
> +    params->postcopy_rp_keepalive_period = s->parameters.postcopy_rp_keepalive_period;
>  
>      return params;
>  }
> @@ -956,6 +974,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_mode = true;
>      params->has_zero_page_detection = true;
>      params->has_direct_io = true;
> +    params->has_postcopy_rp_keepalive_period = true;
>  }
>  
>  /*
> @@ -1142,6 +1161,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>          return false;
>      }
>  
> +    if (params->has_postcopy_rp_keepalive_period &&
> +        params->postcopy_rp_keepalive_period > INT_MAX) {
> +        error_setg(errp,
> +                   "Parameter 'postcopy-rp-keepalive-period' must be less than %d",
> +                   INT_MAX);
> +        return false;
> +    }
> +
>      return true;
>  }
>  
> @@ -1255,6 +1282,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_direct_io) {
>          dest->direct_io = params->direct_io;
>      }
> +
> +    if (params->has_postcopy_rp_keepalive_period) {
> +        dest->postcopy_rp_keepalive_period = params->postcopy_rp_keepalive_period;
> +    }
>  }
>  
>  static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
> @@ -1387,6 +1418,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_direct_io) {
>          s->parameters.direct_io = params->direct_io;
>      }
> +
> +    if (params->has_postcopy_rp_keepalive_period) {
> +        s->parameters.postcopy_rp_keepalive_period = params->postcopy_rp_keepalive_period;
> +    }
>  }
>  
>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
> diff --git a/migration/options.h b/migration/options.h
> index 762be4e641..c941806413 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -85,6 +85,7 @@ const char *migrate_tls_creds(void);
>  const char *migrate_tls_hostname(void);
>  uint64_t migrate_xbzrle_cache_size(void);
>  ZeroPageDetection migrate_zero_page_detection(void);
> +uint32_t migrate_postcopy_rp_keepalive_period(void);
>  
>  /* parameters helpers */
>  
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 6a6da6ba7f..26db4e2d22 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -960,6 +960,10 @@ static void *postcopy_ram_fault_thread(void *opaque)
>      int ret;
>      size_t index;
>      RAMBlock *rb = NULL;
> +    int poll_timeout = migrate_postcopy_rp_keepalive_period();
> +    if (poll_timeout == 0) {
> +        poll_timeout = -1; /* wait forever with no keepalive messages */
> +    }
>  
>      trace_postcopy_ram_fault_thread_entry();
>      rcu_register_thread();
> @@ -995,7 +999,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
>           * an eventfd
>           */
>  
> -        poll_result = poll(pfd, pfd_len, -1 /* Wait forever */);
> +        poll_result = poll(pfd, pfd_len, poll_timeout);
>          if (poll_result == -1) {
>              error_report("%s: userfault poll: %s", __func__, strerror(errno));
>              break;
> @@ -1010,6 +1014,15 @@ static void *postcopy_ram_fault_thread(void *opaque)
>              postcopy_pause_fault_thread(mis);
>          }
>  
> +        if (poll_result == 0) {
> +            /*
> +             * No page to request, send at least a keepalive message to check
> +             * that the connection is not broken.
> +             */
> +            migrate_send_rp_keepalive(mis);
> +            continue;
> +        }
> +
>          if (pfd[1].revents) {
>              uint64_t tmp64 = 0;
>  
> diff --git a/migration/trace-events b/migration/trace-events
> index b82a1c5e40..64ffbc271f 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -161,6 +161,7 @@ migrate_pending_exact(uint64_t size, uint64_t pre, uint64_t post) "exact pending
>  migrate_pending_estimate(uint64_t size, uint64_t pre, uint64_t post) "estimate pending size %" PRIu64 " (pre = %" PRIu64 " post=%" PRIu64 ")"
>  migrate_send_rp_message(int msg_type, uint16_t len) "%d: len %d"
>  migrate_send_rp_recv_bitmap(char *name, int64_t size) "block '%s' size 0x%"PRIi64
> +migrate_send_rp_keepalive(void) ""
>  migration_completion_file_err(void) ""
>  migration_completion_vm_stop(int ret) "ret %d"
>  migration_completion_postcopy_end(void) ""
> @@ -188,6 +189,7 @@ source_return_path_thread_pong(uint32_t val) "0x%x"
>  source_return_path_thread_shut(uint32_t val) "0x%x"
>  source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
>  source_return_path_thread_switchover_acked(void) ""
> +source_return_path_thread_received_keepalive(void) ""
>  migration_thread_low_pending(uint64_t pending) "%" PRIu64
>  migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size %" PRId64
>  process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
> diff --git a/qapi/migration.json b/qapi/migration.json
> index a605dc26db..b4553aedfc 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -844,6 +844,15 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @postcopy-rp-keepalive-period: Time (in milliseconds) in which if no page
> +#     request message is sent from the destination side to the source side, a
> +#     keepalive message is sent instead.  Allows the destination to detect
> +#     network failure that would not be detected otherwise in case there is no
> +#     other communication to the source side (no page requests).  Should be less
> +#     than platform INT_MAX, 0 means no keepalive will be sent.
> +#     Default is 60000 ms.
> +#     (Since 9.3)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and
> @@ -870,7 +879,7 @@
>             'vcpu-dirty-limit',
>             'mode',
>             'zero-page-detection',
> -           'direct-io'] }
> +           'direct-io', 'postcopy-rp-keepalive-period'] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1025,6 +1034,15 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @postcopy-rp-keepalive-period: Time (in milliseconds) in which if no page
> +#     request message is sent from the destination side to the source side, a
> +#     keepalive message is sent instead.  Allows the destination to detect
> +#     network failure that would not be detected otherwise in case there is no
> +#     other communication to the source side (no page requests).  Should be less
> +#     than platform INT_MAX, 0 means no keepalive will be sent.
> +#     Default is 60000 ms.
> +#     (Since 9.3)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and
> @@ -1066,7 +1084,8 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*direct-io': 'bool' } }
> +            '*direct-io': 'bool',
> +            '*postcopy-rp-keepalive-period': 'uint32' } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1235,6 +1254,15 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @postcopy-rp-keepalive-period: Time (in milliseconds) in which if no page
> +#     request message is sent from the destination side to the source side, a
> +#     keepalive message is sent instead.  Allows the destination to detect
> +#     network failure that would not be detected otherwise in case there is no
> +#     other communication to the source side (no page requests).  Should be less
> +#     than platform INT_MAX, 0 means no keepalive will be sent.
> +#     Default is 60000 ms.
> +#     (Since 9.3)

s/9.3/10.0/

We don't have 9.3. :)

Thanks for looking into this!

> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and
> @@ -1273,7 +1301,8 @@
>              '*vcpu-dirty-limit': 'uint64',
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
> -            '*direct-io': 'bool' } }
> +            '*direct-io': 'bool',
> +            '*postcopy-rp-keepalive-period': 'uint32' } }
>  
>  ##
>  # @query-migrate-parameters:
> -- 
> 2.48.1
> 

-- 
Peter Xu


