Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DADB76EEBA
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:54:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRaeB-0004T1-06; Thu, 03 Aug 2023 11:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRae9-0004Sf-5P
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRae6-00040L-R3
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691078030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3m5H2oFcIwGjkMMwsUf9REVOz7PT+Z4cqrMgkaNtcg=;
 b=dm43/bn2v+UgSrI+11UJWrLCaoRw9syNDgDx3S21U/g374J2JQbFVEmKJAdd8Ds8rSRss4
 YoaR6oiVfq3fYAlDDNZNZc90YvKhdLL5sSMiT1PzS1WpzQDuWj/LCZ5YIGthTHFKC8VzcX
 IujdRwHfa/t2rSGb2BNAaX7UQ10OjY0=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-I1X9KfG4P76OvaQOT8yKdw-1; Thu, 03 Aug 2023 11:53:48 -0400
X-MC-Unique: I1X9KfG4P76OvaQOT8yKdw-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-4865ca8678dso18082e0c.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 08:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691078028; x=1691682828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X3m5H2oFcIwGjkMMwsUf9REVOz7PT+Z4cqrMgkaNtcg=;
 b=YfDhb+6FVefygrON4UKzBaACr/rKlbNHs9NGjZHJ03v4yFyifdAAFKx6j9RY9wwvT/
 6OFuWOYH0Z8L0rbB7+9eh3QqQav0oPJYNiSshzF8Iyz20M26YSw19jkMsMiMaKFScBh8
 mz6qMD7YhTd7IhqlrcSuTNua8rtfEGk3rwPRBXjtoC/wrv3WALiOteFh0MAa9iFGT2pG
 OBDJvPrrwZpSjQqhD7IDTwSdO5T0i++M6bO1YnDENvPdif5Uvf5peXjIBgffYfYSZVcc
 AP3Tq7r7OZOsm7iieCTjYfGhS4z7OsTWehLU4iVHyDNl2kH8uL2dqJ7NO4aXH/W/TU0/
 GT9Q==
X-Gm-Message-State: ABy/qLZzFCaOcClKlKoP5s2ia2d+426OuGzzbZun6jmXwxODEDTzXhD5
 BA5BUeCctv1sy1yRw2Ku8XuDJabDmXIzACFbKOTcCdgiFLw5y8crz/lHO4wtWhtOvwGS/cIxVL4
 XmdeS2Yijm1p6Sv+Vk/Uvsxoil2JyWf4XLMA0aKe4mAMhFPgIixAPLT8S/88ybr9MXYJLwmYZ
X-Received: by 2002:a1f:b210:0:b0:47e:9d33:6da1 with SMTP id
 b16-20020a1fb210000000b0047e9d336da1mr7753516vkf.0.1691078027683; 
 Thu, 03 Aug 2023 08:53:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGOuR3aYHe67wXvccaaoDN+ohEllN1r168XeJArwpcdYQWoQhVPztWieR9AabzICKKFVkuXXg==
X-Received: by 2002:a1f:b210:0:b0:47e:9d33:6da1 with SMTP id
 b16-20020a1fb210000000b0047e9d336da1mr7753485vkf.0.1691078026988; 
 Thu, 03 Aug 2023 08:53:46 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 iw2-20020a05622a6f8200b00403f5873f5esm23682qtb.24.2023.08.03.08.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 08:53:46 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhiyi Guo <zhguo@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Eric Blake <eblake@redhat.com>, Chensheng Dong <chdong@redhat.com>
Subject: [PATCH for-8.2 v2 1/2] qapi/migration: Deduplicate migration
 parameter field comments
Date: Thu,  3 Aug 2023 11:53:43 -0400
Message-ID: <20230803155344.11450-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803155344.11450-1-peterx@redhat.com>
References: <20230803155344.11450-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

We used to have three objects that have always the same list of parameters
and comments are always duplicated:

  - @MigrationParameter
  - @MigrationParameters
  - @MigrateSetParameters

Before we can deduplicate the code, it's fairly straightforward to
deduplicate the comments first, so for each time we add a new migration
parameter we don't need to copy the same paragraphs three times.

Make the @MigrationParameter the major source of truth, while leaving the
rest two to reference to it.

We do have a slight problem in the man/html pages generated, that for the
latter two objects we'll get a list of Members but with all of them saying
"Not documented":

   Members
       announce-initial: int (optional)
              Not documented

       announce-max: int (optional)
              Not documented

       announce-rounds: int (optional)
              Not documented

       [...]

Even though we'll have a reference there telling the reader to jump over to
read the @MigrationParameter sections instead, for example:

   MigrationParameters (Object)

       The object structure to represent a list of migration parameters.
       The optional members aren't actually optional.  For detailed
       explanation for each of the field, please refer to the documentation
       of MigrationParameter.

So hopefully that's not too bad.. and we can leave it for later to make it
even better.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json | 283 ++------------------------------------------
 1 file changed, 7 insertions(+), 276 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 8843e74b59..bb798f87a5 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -854,142 +854,9 @@
 ##
 # @MigrateSetParameters:
 #
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
-# @compress-level: compression level
-#
-# @compress-threads: compression thread count
-#
-# @compress-wait-thread: Controls behavior when all compression
-#     threads are currently busy.  If true (default), wait for a free
-#     compression thread to become available; otherwise, send the page
-#     uncompressed.  (Since 3.1)
-#
-# @decompress-threads: decompression thread count
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
-#     credentials must be for a 'server' endpoint.  Setting this to a
-#     non-empty string enables TLS for all migrations.  An empty
-#     string means that QEMU will use plain text mode for migration,
-#     rather than TLS (Since 2.9) Previously (since 2.7), this was
-#     reported by omitting tls-creds instead.
-#
-# @tls-hostname: hostname of the target host for the migration.  This
-#     is required when using x509 based TLS credentials and the
-#     migration URI does not already include a hostname.  For example
-#     if using fd: or exec: based migration, the hostname must be
-#     provided so that the server's x509 certificate identity can be
-#     validated.  (Since 2.7) An empty string means that QEMU will use
-#     the hostname associated with the migration URI, if any.  (Since
-#     2.9) Previously (since 2.7), this was reported by omitting
-#     tls-hostname instead.
-#
-# @max-bandwidth: to set maximum speed for migration.  maximum speed
-#     in bytes per second.  (Since 2.8)
-#
-# @downtime-limit: set maximum tolerated downtime for migration.
-#     maximum downtime in milliseconds (Since 2.8)
-#
-# @x-checkpoint-delay: the delay time between two COLO checkpoints.
-#     (Since 2.8)
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
-# @max-cpu-throttle: maximum cpu throttle percentage.  The default
-#     value is 99. (Since 3.1)
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
+# Object structure to set migration parameters.  For detailed
+# explanation of each of the field, please refer to the documentation
+# of @MigrationParameter.
 #
 # Features:
 #
@@ -1053,146 +920,10 @@
 ##
 # @MigrationParameters:
 #
-# The optional members aren't actually optional.
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
-# @compress-level: compression level
-#
-# @compress-threads: compression thread count
-#
-# @compress-wait-thread: Controls behavior when all compression
-#     threads are currently busy.  If true (default), wait for a free
-#     compression thread to become available; otherwise, send the page
-#     uncompressed.  (Since 3.1)
-#
-# @decompress-threads: decompression thread count
-#
-# @throttle-trigger-threshold: The ratio of bytes_dirty_period and
-#     bytes_xfer_period to trigger throttling.  It is expressed as
-#     percentage.  The default value is 50. (Since 5.0)
-#
-# @cpu-throttle-initial: Initial percentage of time guest cpus are
-#     throttled when migration auto-converge is activated.  (Since
-#     2.7)
-#
-# @cpu-throttle-increment: throttle percentage increase each time
-#     auto-converge detects that migration is not making progress.
-#     (Since 2.7)
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
-#     credentials must be for a 'server' endpoint.  An empty string
-#     means that QEMU will use plain text mode for migration, rather
-#     than TLS (Since 2.7) Note: 2.8 reports this by omitting
-#     tls-creds instead.
-#
-# @tls-hostname: hostname of the target host for the migration.  This
-#     is required when using x509 based TLS credentials and the
-#     migration URI does not already include a hostname.  For example
-#     if using fd: or exec: based migration, the hostname must be
-#     provided so that the server's x509 certificate identity can be
-#     validated.  (Since 2.7) An empty string means that QEMU will use
-#     the hostname associated with the migration URI, if any.  (Since
-#     2.9) Note: 2.8 reports this by omitting tls-hostname instead.
-#
-# @tls-authz: ID of the 'authz' object subclass that provides access
-#     control checking of the TLS x509 certificate distinguished name.
-#     (Since 4.0)
-#
-# @max-bandwidth: to set maximum speed for migration.  maximum speed
-#     in bytes per second.  (Since 2.8)
-#
-# @downtime-limit: set maximum tolerated downtime for migration.
-#     maximum downtime in milliseconds (Since 2.8)
-#
-# @x-checkpoint-delay: the delay time between two COLO checkpoints.
-#     (Since 2.8)
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
+# The object structure to represent a list of migration parameters.
+# The optional members aren't actually optional.  For detailed
+# explanation for each of the field, please refer to the documentation
+# of @MigrationParameter.
 #
 # Features:
 #
-- 
2.41.0


