Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D49761399
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 13:11:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOFvg-00005Q-9v; Tue, 25 Jul 2023 07:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOFvc-00005I-G5
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOFva-0001fC-07
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690283404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z77whvrv2oseI15PJDazIoJZV26ULNoNV14OozRL1zc=;
 b=ZuF3htdslT2OH7WI494ja7bue9DsD6YKNE06A8psSF/qcjJK4LfyKp3zO+Zic2rrZ8kYzR
 I6O5MolLe1kbqCbIgpqK0+584ILHgT1MyL4j1amy9gv9MruHiQLGotnm7KtHv02lM8oeyY
 Jn/xcpwty9fMj4IRgru1qjmXHQeE7MU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-NMGaknLtNea_mZonIAyv5A-1; Tue, 25 Jul 2023 07:10:03 -0400
X-MC-Unique: NMGaknLtNea_mZonIAyv5A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFFB485A58A;
 Tue, 25 Jul 2023 11:10:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A42434A9004;
 Tue, 25 Jul 2023 11:10:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9EA2721E6690; Tue, 25 Jul 2023 13:10:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Leonardo Bras Soares Passos
 <lsoaresp@redhat.com>,  Eric Blake <eblake@redhat.com>,  Juan Quintela
 <quintela@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Chensheng
 Dong <chdong@redhat.com>,  Zhiyi Guo <zhguo@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
References: <20230724170755.1114519-1-peterx@redhat.com>
Date: Tue, 25 Jul 2023 13:10:01 +0200
In-Reply-To: <20230724170755.1114519-1-peterx@redhat.com> (Peter Xu's message
 of "Mon, 24 Jul 2023 13:07:55 -0400")
Message-ID: <87351cfdrq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> writes:

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
>
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

Humor me: break lines slightly earlier, like

   # @available-bandwidth: to set available bandwidth for migration.  By
   #     default, this value is zero, means the user is not aware of the
   #     available bandwidth that can be used by QEMU migration, so QEMU
   #     will estimate the bandwidth automatically.  This can be set when
   #     the estimated value is not accurate, while the user is able to
   #     guarantee such bandwidth is available for migration purpose
   #     during the migration procedure.  When specified correctly, this
   #     can make the switchover decision much more accurate, which will
   #     also be based on the max downtime specified.  (Since 8.2)

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

For better or worse, we duplicate full documentation between
MigrationParameter, MigrateSetParameters, and MigrationParameters.  This
would be the first instance where we reference instead.  I'm not opposed
to use references, but if we do, I want them used consistently.


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

Suggest to scratch "user".

>       */
>      int64_t threshold_size;
>  

[...]


