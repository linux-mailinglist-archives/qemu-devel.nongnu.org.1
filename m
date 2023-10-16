Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E797CAEC7
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:17:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQHM-0006Ea-QU; Mon, 16 Oct 2023 12:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsQHD-00061Z-U7
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsQHB-0006fU-Gs
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697473023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xXP3ocXrs6D4ZYny+rMa+D6J1vTROvLbTOY5wKkvWZQ=;
 b=c8uoog+wxBfK9QwyMlzTrCkksWAfVLysz6kkjhsm2OgMvfHB9ivHE5oDwqdt5I839oodA1
 saChGfzDgZcx2gyHBt7t1cGvM7mbFLegGj9tMCpWt954bau431+0tVd1RQ/OoUr/bdpotC
 brL30ZL5thX0rR7zp+b6+xSMKYDaKjU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-HygsToeoOHWMmxDQLedsFQ-1; Mon, 16 Oct 2023 12:17:02 -0400
X-MC-Unique: HygsToeoOHWMmxDQLedsFQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65623d0075aso11122096d6.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697473021; x=1698077821;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xXP3ocXrs6D4ZYny+rMa+D6J1vTROvLbTOY5wKkvWZQ=;
 b=XvQNcF3m1P+9v7Jy3B6VQjNW9lEDpJu4vuYE3aqxaoKl16jogMi5MaGg96o4Ch4Sao
 zTqtcMK8XeKpBz628CU5Otkx/L0rlGdbsCKlhSqy9vkPNe2kTUffPhiC+mdXoTRC99uq
 SwdINMiidJM39bAUJtCudK79a2UODjNwSmkR3KS17iGfyA9v5Mc0WRKO9rYMibsZEVVo
 Waad7Rn6VImDyyijIBmzBU5f7tBksLtxmVROhAKvpJeFme+7rZOkekNTbxX+mt7g61Iv
 7ZcFwAn3E+k54NVWc/dOwNyeEAeJojKKL2GGtiEyhmDsmad3fKnXFfOm+yw+GwwJCAf4
 tQMg==
X-Gm-Message-State: AOJu0YySU+QLRsh5Yyl7/7jO539UfseGweD/mCRfCrFb+uctwZXqPiy6
 sD9Q1hCd7OVXXaGfxaUqisY64N5UH2zYmYqueKuVoJAg5KUGqrdFD4c7VWZ0AITJOODkOJwjV62
 dsphTyqdvXDNVTKw=
X-Received: by 2002:a05:6214:4a07:b0:66d:4994:b79a with SMTP id
 pg7-20020a0562144a0700b0066d4994b79amr5490074qvb.5.1697473021569; 
 Mon, 16 Oct 2023 09:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqARqQl8yCs4DM7/uVnZO0ZhkW9PSc/IIKZmjm2kfLTTsrttn865PmNEiYVCZDsaUNQMdBWQ==
X-Received: by 2002:a05:6214:4a07:b0:66d:4994:b79a with SMTP id
 pg7-20020a0562144a0700b0066d4994b79amr5490050qvb.5.1697473021163; 
 Mon, 16 Oct 2023 09:17:01 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 r3-20020ad44043000000b0065b13180892sm3555915qvp.16.2023.10.16.09.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 09:17:00 -0700 (PDT)
Date: Mon, 16 Oct 2023 12:16:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 4/4] migration/qapi: Drop @MigrationParameter enum
Message-ID: <ZS1h+pNhqyaXHDhW@x1n>
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-5-peterx@redhat.com>
 <87a5t8is2d.fsf@pond.sub.org> <ZRsrG5QdnEh0jiXd@x1n>
 <87ttqqiz5f.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ttqqiz5f.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 16, 2023 at 08:29:58AM +0200, Markus Armbruster wrote:
> Better, because even stupider: drop the feature flags.  They have no
> effect on internal use, and there is no external use.
> 
>     ##
>     # @MigrationParameter:
>     #
>     # TODO: elide from generated documentation (type is used only
>     #     internally, and not visible in QMP)
>     #
>     # Since: 2.4
>     ##
>     { 'enum': 'MigrationParameter',
>       'data': ['announce-initial', 'announce-max',
>                'announce-rounds', 'announce-step',
>                'compress-level', 'compress-threads', 'decompress-threads',
>                'compress-wait-thread', 'throttle-trigger-threshold',
>                'cpu-throttle-initial', 'cpu-throttle-increment',
>                'cpu-throttle-tailslow',
>                'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
>                'downtime-limit',
>                'x-checkpoint-delay',
>                'block-incremental',
>                'multifd-channels',
>                'xbzrle-cache-size', 'max-postcopy-bandwidth',
>                'max-cpu-throttle', 'multifd-compression',
>                'multifd-zlib-level', 'multifd-zstd-level',
>                'block-bitmap-mapping',
>                'x-vcpu-dirty-limit-period',
>                'vcpu-dirty-limit'] }

Didn't work either, unfortunately..  Compile is fine, but I still see the
lines generated in qemu-qmp-ref.7.

        MigrationParameter (Enum)
        Values
        announce-initial
                Not documented

        announce-max
                Not documented

        announce-rounds
                Not documented

        announce-step
                Not documented

        compress-level
                Not documented
        [...]

Patch attached.

Thanks,

===8<===

From 6e9355f2b5e1ad21de1e13114055390077f34ca0 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Mon, 16 Oct 2023 12:00:44 -0400
Subject: [PATCH] migration/qapi: Drop documentation for MigrationParameter

@MigrationParameter shouldn't be exposed in QAPI schema.  It should only be
used in QEMU internally.  Documentation is not required for this object.

Keeping it under qapi/ still makes sense, so as to benefit QEMU from
auto-generated helpers around the object to reduce hand written codes.

After all, the documentation duplicates with @MigrationSetParameters and
@MigrationParameters which are real exported QAPI objects.  It's more
challenging to deduplicate all three into one, but drop the easy one first
by leveraging a loophole in QAPI generator.

When at it, redo the newlines so one parameter per line.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json | 203 ++++++--------------------------------------
 1 file changed, 27 insertions(+), 176 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index db3df12d6c..7b9054433a 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -673,190 +673,41 @@
 ##
 # @MigrationParameter:
 #
-# Migration parameters enumeration
-#
-# @announce-initial: Initial delay (in milliseconds) before sending
-#     the first announce (Since 4.0)
-#
-# @announce-max: Maximum delay (in milliseconds) between packets in
-#     the announcement (Since 4.0)
-#
-# @announce-rounds: Number of self-announce packets sent after
-#     migration (Since 4.0)
-#
-# @announce-step: Increase in delay (in milliseconds) between
-#     subsequent packets in the announcement (Since 4.0)
-#
-# @compress-level: Set the compression level to be used in live
-#     migration, the compression level is an integer between 0 and 9,
-#     where 0 means no compression, 1 means the best compression
-#     speed, and 9 means best compression ratio which will consume
-#     more CPU.
-#
-# @compress-threads: Set compression thread count to be used in live
-#     migration, the compression thread count is an integer between 1
-#     and 255.
-#
-# @compress-wait-thread: Controls behavior when all compression
-#     threads are currently busy.  If true (default), wait for a free
-#     compression thread to become available; otherwise, send the page
-#     uncompressed.  (Since 3.1)
-#
-# @decompress-threads: Set decompression thread count to be used in
-#     live migration, the decompression thread count is an integer
-#     between 1 and 255. Usually, decompression is at least 4 times as
-#     fast as compression, so set the decompress-threads to the number
-#     about 1/4 of compress-threads is adequate.
-#
-# @throttle-trigger-threshold: The ratio of bytes_dirty_period and
-#     bytes_xfer_period to trigger throttling.  It is expressed as
-#     percentage.  The default value is 50. (Since 5.0)
-#
-# @cpu-throttle-initial: Initial percentage of time guest cpus are
-#     throttled when migration auto-converge is activated.  The
-#     default value is 20. (Since 2.7)
-#
-# @cpu-throttle-increment: throttle percentage increase each time
-#     auto-converge detects that migration is not making progress.
-#     The default value is 10. (Since 2.7)
-#
-# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage At
-#     the tail stage of throttling, the Guest is very sensitive to CPU
-#     percentage while the @cpu-throttle -increment is excessive
-#     usually at tail stage.  If this parameter is true, we will
-#     compute the ideal CPU percentage used by the Guest, which may
-#     exactly make the dirty rate match the dirty rate threshold.
-#     Then we will choose a smaller throttle increment between the one
-#     specified by @cpu-throttle-increment and the one generated by
-#     ideal CPU percentage.  Therefore, it is compatible to
-#     traditional throttling, meanwhile the throttle increment won't
-#     be excessive at tail stage.  The default value is false.  (Since
-#     5.1)
-#
-# @tls-creds: ID of the 'tls-creds' object that provides credentials
-#     for establishing a TLS connection over the migration data
-#     channel.  On the outgoing side of the migration, the credentials
-#     must be for a 'client' endpoint, while for the incoming side the
-#     credentials must be for a 'server' endpoint.  Setting this will
-#     enable TLS for all migrations.  The default is unset, resulting
-#     in unsecured migration at the QEMU level.  (Since 2.7)
-#
-# @tls-hostname: hostname of the target host for the migration.  This
-#     is required when using x509 based TLS credentials and the
-#     migration URI does not already include a hostname.  For example
-#     if using fd: or exec: based migration, the hostname must be
-#     provided so that the server's x509 certificate identity can be
-#     validated.  (Since 2.7)
-#
-# @tls-authz: ID of the 'authz' object subclass that provides access
-#     control checking of the TLS x509 certificate distinguished name.
-#     This object is only resolved at time of use, so can be deleted
-#     and recreated on the fly while the migration server is active.
-#     If missing, it will default to denying access (Since 4.0)
-#
-# @max-bandwidth: to set maximum speed for migration.  maximum speed
-#     in bytes per second.  (Since 2.8)
-#
-# @avail-switchover-bandwidth: to set the available bandwidth that
-#     migration can use during switchover phase.  NOTE!  This does not
-#     limit the bandwidth during switchover, but only for calculations when
-#     making decisions to switchover.  By default, this value is zero,
-#     which means QEMU will estimate the bandwidth automatically.  This can
-#     be set when the estimated value is not accurate, while the user is
-#     able to guarantee such bandwidth is available when switching over.
-#     When specified correctly, this can make the switchover decision much
-#     more accurate.  (Since 8.2)
-#
-# @downtime-limit: set maximum tolerated downtime for migration.
-#     maximum downtime in milliseconds (Since 2.8)
-#
-# @x-checkpoint-delay: The delay time (in ms) between two COLO
-#     checkpoints in periodic mode.  (Since 2.8)
-#
-# @block-incremental: Affects how much storage is migrated when the
-#     block migration capability is enabled.  When false, the entire
-#     storage backing chain is migrated into a flattened image at the
-#     destination; when true, only the active qcow2 layer is migrated
-#     and the destination must already have access to the same backing
-#     chain as was used on the source.  (since 2.10)
-#
-# @multifd-channels: Number of channels used to migrate data in
-#     parallel.  This is the same number that the number of sockets
-#     used for migration.  The default value is 2 (since 4.0)
-#
-# @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
-#     needs to be a multiple of the target page size and a power of 2
-#     (Since 2.11)
-#
-# @max-postcopy-bandwidth: Background transfer bandwidth during
-#     postcopy.  Defaults to 0 (unlimited).  In bytes per second.
-#     (Since 3.0)
-#
-# @max-cpu-throttle: maximum cpu throttle percentage.  Defaults to 99.
-#     (Since 3.1)
-#
-# @multifd-compression: Which compression method to use.  Defaults to
-#     none.  (Since 5.0)
-#
-# @multifd-zlib-level: Set the compression level to be used in live
-#     migration, the compression level is an integer between 0 and 9,
-#     where 0 means no compression, 1 means the best compression
-#     speed, and 9 means best compression ratio which will consume
-#     more CPU. Defaults to 1. (Since 5.0)
-#
-# @multifd-zstd-level: Set the compression level to be used in live
-#     migration, the compression level is an integer between 0 and 20,
-#     where 0 means no compression, 1 means the best compression
-#     speed, and 20 means best compression ratio which will consume
-#     more CPU. Defaults to 1. (Since 5.0)
-#
-# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
-#     aliases for the purpose of dirty bitmap migration.  Such aliases
-#     may for example be the corresponding names on the opposite site.
-#     The mapping must be one-to-one, but not necessarily complete: On
-#     the source, unmapped bitmaps and all bitmaps on unmapped nodes
-#     will be ignored.  On the destination, encountering an unmapped
-#     alias in the incoming migration stream will result in a report,
-#     and all further bitmap migration data will then be discarded.
-#     Note that the destination does not know about bitmaps it does
-#     not receive, so there is no limitation or requirement regarding
-#     the number of bitmaps received, or how they are named, or on
-#     which nodes they are placed.  By default (when this parameter
-#     has never been set), bitmap names are mapped to themselves.
-#     Nodes are mapped to their block device name if there is one, and
-#     to their node name otherwise.  (Since 5.2)
-#
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
-#     limit during live migration.  Should be in the range 1 to 1000ms.
-#     Defaults to 1000ms.  (Since 8.1)
-#
-# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
-#     Defaults to 1.  (Since 8.1)
-#
-# Features:
-#
-# @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
-#     are experimental.
+# TODO: elide from generated documentation (type is used only
+#     internally, and not visible in QMP)
 #
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
-  'data': ['announce-initial', 'announce-max',
-           'announce-rounds', 'announce-step',
-           'compress-level', 'compress-threads', 'decompress-threads',
-           'compress-wait-thread', 'throttle-trigger-threshold',
-           'cpu-throttle-initial', 'cpu-throttle-increment',
+  'data': ['announce-initial',
+           'announce-max',
+           'announce-rounds',
+           'announce-step',
+           'compress-level',
+           'compress-threads',
+           'decompress-threads',
+           'compress-wait-thread',
+           'throttle-trigger-threshold',
+           'cpu-throttle-initial',
+           'cpu-throttle-increment',
            'cpu-throttle-tailslow',
-           'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
-           'avail-switchover-bandwidth', 'downtime-limit',
-           { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
+           'tls-creds',
+           'tls-hostname',
+           'tls-authz',
+           'max-bandwidth',
+           'avail-switchover-bandwidth',
+           'downtime-limit',
+           'x-checkpoint-delay',
            'block-incremental',
            'multifd-channels',
-           'xbzrle-cache-size', 'max-postcopy-bandwidth',
-           'max-cpu-throttle', 'multifd-compression',
-           'multifd-zlib-level', 'multifd-zstd-level',
+           'xbzrle-cache-size',
+           'max-postcopy-bandwidth',
+           'max-cpu-throttle',
+           'multifd-compression',
+           'multifd-zlib-level',
+           'multifd-zstd-level',
            'block-bitmap-mapping',
-           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
+           'x-vcpu-dirty-limit-period',
            'vcpu-dirty-limit'] }
 
 ##
-- 
2.41.0


-- 
Peter Xu


