Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A60ACBE33
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Jun 2025 03:39:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGbj-0006QA-36; Mon, 02 Jun 2025 21:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGbg-0006Pw-Hc
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:24 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGbe-0001QO-Ge
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:24 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 13256218E7;
 Tue,  3 Jun 2025 01:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZiChYRCokoaodw33wlx/YS1OZ3Lr7Ka+lZ1U2wYHt8=;
 b=pYeW9bvZubJqw5qECvEeFLOAxAixZzHUWeg0suZQykoQTMYa5Q+CNi7JbFm2ygWxIzGqbD
 tnFpk5JUd93nOyuLjffndnYr90quMIR6EiFlUWZWKMzWEwU9g2/8zFR09m2Pflhthru798
 Gi2mwqck4O1YdwEIlaeJLVHMKC8ZlPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZiChYRCokoaodw33wlx/YS1OZ3Lr7Ka+lZ1U2wYHt8=;
 b=RfPjfgUnGoc6RU3tlidcT0PoNPB1SrkL94YhOzaTMAxVLyawd2OFinfjYl7DI103Z+KhND
 4z7Y2NzgrldNDoBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZiChYRCokoaodw33wlx/YS1OZ3Lr7Ka+lZ1U2wYHt8=;
 b=pYeW9bvZubJqw5qECvEeFLOAxAixZzHUWeg0suZQykoQTMYa5Q+CNi7JbFm2ygWxIzGqbD
 tnFpk5JUd93nOyuLjffndnYr90quMIR6EiFlUWZWKMzWEwU9g2/8zFR09m2Pflhthru798
 Gi2mwqck4O1YdwEIlaeJLVHMKC8ZlPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZiChYRCokoaodw33wlx/YS1OZ3Lr7Ka+lZ1U2wYHt8=;
 b=RfPjfgUnGoc6RU3tlidcT0PoNPB1SrkL94YhOzaTMAxVLyawd2OFinfjYl7DI103Z+KhND
 4z7Y2NzgrldNDoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 854F413700;
 Tue,  3 Jun 2025 01:38:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YPWnEQtSPmiNLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 01:38:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 03/21] qapi/migration: Don't document MigrationParameter
Date: Mon,  2 Jun 2025 22:37:52 -0300
Message-Id: <20250603013810.4772-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603013810.4772-1-farosas@suse.de>
References: <20250603013810.4772-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The MigrationParameter (singular) enumeration is not part of the
migration QMP API, it's only used for nicely converting HMP strings
into MigrationParameters (plural) members and for providing readline
completion.

Documenting this enum only serves to duplicate documentation between
MigrationParameter and MigrationParameters.

Add an exception to QAPIs pragma.json and stop documenting it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 qapi/migration.json | 152 +-------------------------------------------
 qapi/pragma.json    |   3 +-
 2 files changed, 3 insertions(+), 152 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 080968993a..452e6dedaa 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -734,157 +734,7 @@
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
-# @throttle-trigger-threshold: The ratio of bytes_dirty_period and
-#     bytes_xfer_period to trigger throttling.  It is expressed as
-#     percentage.  The default value is 50.  (Since 5.0)
-#
-# @cpu-throttle-initial: Initial percentage of time guest cpus are
-#     throttled when migration auto-converge is activated.  The
-#     default value is 20.  (Since 2.7)
-#
-# @cpu-throttle-increment: throttle percentage increase each time
-#     auto-converge detects that migration is not making progress.
-#     The default value is 10.  (Since 2.7)
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
-#     rather than TLS.  (Since 2.7)
-#
-# @tls-hostname: migration target's hostname for validating the
-#     server's x509 certificate identity.  If empty, QEMU will use the
-#     hostname from the migration URI, if any.  A non-empty value is
-#     required when using x509 based TLS credentials and the migration
-#     URI does not include a hostname, such as fd: or exec: based
-#     migration.  (Since 2.7)
-#
-#     Note: empty value works only since 2.9.
-#
-# @tls-authz: ID of the 'authz' object subclass that provides access
-#     control checking of the TLS x509 certificate distinguished name.
-#     This object is only resolved at time of use, so can be deleted
-#     and recreated on the fly while the migration server is active.
-#     If missing, it will default to denying access (Since 4.0)
-#
-# @max-bandwidth: maximum speed for migration, in bytes per second.
-#     (Since 2.8)
-#
-# @avail-switchover-bandwidth: to set the available bandwidth that
-#     migration can use during switchover phase.  NOTE!  This does not
-#     limit the bandwidth during switchover, but only for calculations
-#     when making decisions to switchover.  By default, this value is
-#     zero, which means QEMU will estimate the bandwidth
-#     automatically.  This can be set when the estimated value is not
-#     accurate, while the user is able to guarantee such bandwidth is
-#     available when switching over.  When specified correctly, this
-#     can make the switchover decision much more accurate.
-#     (Since 8.2)
-#
-# @downtime-limit: set maximum tolerated downtime for migration.
-#     maximum downtime in milliseconds (Since 2.8)
-#
-# @x-checkpoint-delay: The delay time (in ms) between two COLO
-#     checkpoints in periodic mode.  (Since 2.8)
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
-#     more CPU.  Defaults to 1.  (Since 5.0)
-#
-# @multifd-qatzip-level: Set the compression level to be used in live
-#     migration. The level is an integer between 1 and 9, where 1 means
-#     the best compression speed, and 9 means the best compression
-#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
-#
-# @multifd-zstd-level: Set the compression level to be used in live
-#     migration, the compression level is an integer between 0 and 20,
-#     where 0 means no compression, 1 means the best compression
-#     speed, and 20 means best compression ratio which will consume
-#     more CPU.  Defaults to 1.  (Since 5.0)
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
-#     limit during live migration.  Should be in the range 1 to
-#     1000ms.  Defaults to 1000ms.  (Since 8.1)
-#
-# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
-#     Defaults to 1.  (Since 8.1)
-#
-# @mode: Migration mode.  See description in @MigMode.  Default is
-#     'normal'.  (Since 8.2)
-#
-# @zero-page-detection: Whether and how to detect zero pages.
-#     See description in @ZeroPageDetection.  Default is 'multifd'.
-#     (since 9.0)
-#
-# @direct-io: Open migration files with O_DIRECT when possible.  This
-#     only has effect if the @mapped-ram capability is enabled.
-#     (Since 9.1)
+# Migration parameters enumeration. See @MigrationParameters for more info.
 #
 # Features:
 #
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 023a2ef7bc..58133907b6 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -76,7 +76,8 @@
         'X86CPURegister32',
         'XDbgBlockGraph',
         'YankInstanceType',
-        'blockdev-reopen' ],
+        'blockdev-reopen',
+        'MigrationParameter'],
     # Externally visible types whose member names may use uppercase
     'member-name-exceptions': [     # visible in:
         'ACPISlotType',             # query-acpi-ospm-status
-- 
2.35.3


