Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF15C243FE
	for <lists+qemu-devel@lfdr.de>; Fri, 31 Oct 2025 10:49:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElkG-0000cb-Mq; Fri, 31 Oct 2025 05:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEljv-0000Se-9O
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEljl-0006hC-2b
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761904077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=34HmCnMUqTvnhx+xaokQcuVyWzhJW6ajIqNpUrgpBts=;
 b=ack01Q3A4l0G4Sf51BdtAZ2/gI9yoTjVdJuOTX+PuthnNsgN1+fOmoKt9llHWgQZe0RHxd
 IOP2tYGMq4VZeoM695YYc7Ke7hJHhvvxRcBnZdr3iX8ZqTqS9xEKy0NQGJ6HZ+4uwr6IoZ
 lM7B9RKvrEvou3eT6UdetMpyVdWNxCc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-KHHW4-1wPqmAj06neNVpTw-1; Fri,
 31 Oct 2025 05:47:56 -0400
X-MC-Unique: KHHW4-1wPqmAj06neNVpTw-1
X-Mimecast-MFC-AGG-ID: KHHW4-1wPqmAj06neNVpTw_1761904074
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8A1A195399B; Fri, 31 Oct 2025 09:47:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED49E180057E; Fri, 31 Oct 2025 09:47:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3910B21E6773; Fri, 31 Oct 2025 10:47:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, berrange@redhat.com, philmd@linaro.org,
 kchamart@redhat.com, mst@redhat.com, sgarzare@redhat.com
Subject: [PATCH 4/8] qga/qapi-schema: Refill doc comments to conform to
 conventions
Date: Fri, 31 Oct 2025 10:47:47 +0100
Message-ID: <20251031094751.2817932-5-armbru@redhat.com>
In-Reply-To: <20251031094751.2817932-1-armbru@redhat.com>
References: <20251031094751.2817932-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Sweep the entire documentation again.  Last done in commit
7270819384c (qga/qapi-schema: Refill doc comments to conform to
current conventions).

To check the generated documentation does not change, I compared the
generated HTML before and after this commit with "wdiff -3".  Finds no
differences.  Comparing with diff is not useful, as the reflown
paragraphs are visible there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 87 ++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 40 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 8162d888bb..af75f12a28 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -2,8 +2,8 @@
 # vim: filetype=python
 
 ##
-# This manual describes the commands supported by the QEMU Guest
-# Agent Protocol.
+# This manual describes the commands supported by the QEMU Guest Agent
+# Protocol.
 #
 # For locating  a particular item, please see the `qapi-qga-index`.
 #
@@ -96,8 +96,8 @@
 # In cases where a partial stale response was previously received by
 # the client, this cannot always be done reliably.  One particular
 # scenario being if qemu-ga responses are fed character-by-character
-# into a JSON parser.  In these situations, using `guest-sync-delimited`
-# may be optimal.
+# into a JSON parser.  In these situations, using
+# `guest-sync-delimited` may be optimal.
 #
 # For clients that fetch responses line by line and convert them to
 # JSON objects, `guest-sync` should be sufficient, but note that in
@@ -153,9 +153,9 @@
 # This command tries to set guest's System Time to the given value,
 # then sets the Hardware Clock (RTC) to the current System Time.  This
 # will make it easier for a guest to resynchronize without waiting for
-# NTP. If no @time is specified, then the time to set is read from
-# RTC. However, this may not be supported on all platforms (i.e.
-# Windows). If that's the case users are advised to always pass a
+# NTP.  If no @time is specified, then the time to set is read from
+# RTC.  However, this may not be supported on all platforms (i.e.
+# Windows).  If that's the case users are advised to always pass a
 # value.
 #
 # @time: time of nanoseconds, relative to the Epoch of 1970-01-01 in
@@ -444,8 +444,8 @@
 # Returns: Number of file systems currently frozen.
 #
 # .. note:: On Windows, the command is implemented with the help of a
-#    Volume Shadow-copy Service DLL helper.  The frozen state is limited
-#    for up to 10 seconds by VSS.
+#    Volume Shadow-copy Service DLL helper.  The frozen state is
+#    limited for up to 10 seconds by VSS.
 #
 # Since: 0.15.0
 ##
@@ -482,9 +482,9 @@
 # Returns: Number of file systems thawed by this call
 #
 # .. note:: If the return value does not match the previous call to
-#    `guest-fsfreeze-freeze`, this likely means some freezable filesystems
-#    were unfrozen before this call, and that the filesystem state may
-#    have changed before issuing this command.
+#    `guest-fsfreeze-freeze`, this likely means some freezable
+#    filesystems were unfrozen before this call, and that the
+#    filesystem state may have changed before issuing this command.
 #
 # Since: 0.15.0
 ##
@@ -513,7 +513,8 @@
 ##
 # @GuestFilesystemTrimResponse:
 #
-# @paths: list of `GuestFilesystemTrimResult` per path that was trimmed
+# @paths: list of `GuestFilesystemTrimResult` per path that was
+#     trimmed
 #
 # Since: 2.4
 ##
@@ -557,16 +558,16 @@
 #
 # This command does NOT return a response on success.  There is a high
 # chance the command succeeded if the VM exits with a zero exit status
-# or, when running with --no-shutdown, by issuing the `query-status` QMP
-# command to to confirm the VM status is "shutdown". However, the VM
-# could also exit (or set its status to "shutdown") due to other
+# or, when running with --no-shutdown, by issuing the `query-status`
+# QMP command to to confirm the VM status is "shutdown".  However, the
+# VM could also exit (or set its status to "shutdown") due to other
 # reasons.
 #
 # Errors:
 #     - If suspend to disk is not supported, Unsupported
 #
-# .. note:: It's strongly recommended to issue the `guest-sync` command
-#    before sending commands when the guest resumes.
+# .. note:: It's strongly recommended to issue the `guest-sync`
+#    command before sending commands when the guest resumes.
 #
 # Since: 1.1
 ##
@@ -586,7 +587,7 @@
 # - manual write into sysfs
 #
 # IMPORTANT: `guest-suspend-ram` requires working wakeup support in
-# QEMU. You should check QMP command `query-current-machine` returns
+# QEMU.  You should check QMP command `query-current-machine` returns
 # wakeup-suspend-support: true before issuing this command.  Failure
 # in doing so can result in a suspended guest that QEMU will not be
 # able to awaken, forcing the user to power cycle the guest to bring
@@ -602,8 +603,8 @@
 # Errors:
 #     - If suspend to ram is not supported, Unsupported
 #
-# .. note:: It's strongly recommended to issue the `guest-sync` command
-#    before sending commands when the guest resumes.
+# .. note:: It's strongly recommended to issue the `guest-sync`
+#    command before sending commands when the guest resumes.
 #
 # Since: 1.1
 ##
@@ -622,7 +623,7 @@
 # - pm-utils (via pm-suspend-hybrid)
 #
 # IMPORTANT: `guest-suspend-hybrid` requires working wakeup support in
-# QEMU. You should check QMP command `query-current-machine` returns
+# QEMU.  You should check QMP command `query-current-machine` returns
 # wakeup-suspend-support: true before issuing this command.  Failure
 # in doing so can result in a suspended guest that QEMU will not be
 # able to awaken, forcing the user to power cycle the guest to bring
@@ -638,8 +639,8 @@
 # Errors:
 #     - If hybrid suspend is not supported, Unsupported
 #
-# .. note:: It's strongly recommended to issue the `guest-sync` command
-#    before sending commands when the guest resumes.
+# .. note:: It's strongly recommended to issue the `guest-sync`
+#    command before sending commands when the guest resumes.
 #
 # Since: 1.1
 ##
@@ -1048,10 +1049,11 @@
 #
 # @used-bytes: file system used bytes (since 3.0)
 #
-# @total-bytes: filesystem capacity in bytes for unprivileged users (since 3.0)
+# @total-bytes: filesystem capacity in bytes for unprivileged users
+#     (since 3.0)
 #
-# @total-bytes-privileged: filesystem capacity in bytes for privileged users
-#     (since 9.1)
+# @total-bytes-privileged: filesystem capacity in bytes for privileged
+#     users (since 9.1)
 #
 # @disk: an array of disk hardware information that the volume lies
 #     on, which may be empty if the disk type is not supported
@@ -1171,7 +1173,8 @@
 ##
 # @GuestMemoryBlockResponse:
 #
-# @phys-index: same with the 'phys-index' member of `GuestMemoryBlock`.
+# @phys-index: same with the 'phys-index' member of
+#     `GuestMemoryBlock`.
 #
 # @response: the result of memory block operation.
 #
@@ -1491,10 +1494,11 @@
 #
 # .. note:: On POSIX systems the fields @id, @name, @pretty-name,
 #    @version, @version-id, @variant and @variant-id follow the
-#    definition specified in os-release(5). Refer to the manual page for
-#    exact description of the fields.  Their values are taken from the
-#    os-release file.  If the file is not present in the system, or the
-#    values are not present in the file, the fields are not included.
+#    definition specified in os-release(5).  Refer to the manual page
+#    for exact description of the fields.  Their values are taken from
+#    the os-release file.  If the file is not present in the system,
+#    or the values are not present in the file, the fields are not
+#    included.
 #
 #    On Windows the values are filled from information gathered from
 #    the system.
@@ -1639,7 +1643,7 @@
 # @guest-ssh-remove-authorized-keys:
 #
 # Remove public keys from the user .ssh/authorized_keys on Unix
-# systems (not implemented for other systems). It's not an error if
+# systems (not implemented for other systems).  It's not an error if
 # the key is already missing.
 #
 # @username: the user account to remove the authorized keys
@@ -1862,10 +1866,10 @@
 #
 # Retrieve CPU process load information
 #
-# .. note:: Windows does not have load average API, so QGA emulates it by
-#           calculating the average CPU usage in the last 1, 5, 15 minutes
-#           similar as Linux does this.
-#           Calculation starts from the first time this command is called.
+# .. note:: Windows does not have load average API, so QGA emulates it
+#    by calculating the average CPU usage in the last 1, 5, 15 minutes
+#    similar as Linux does this.  Calculation starts from the first
+#    time this command is called.
 #
 # Returns: load information
 #
@@ -1881,9 +1885,11 @@
 #
 # Route information, currently, only linux supported.
 #
-# @iface: The destination network or host's egress network interface in the routing table
+# @iface: The destination network or host's egress network interface
+#     in the routing table
 #
-# @destination: The IP address of the target network or host, The final destination of the packet
+# @destination: The IP address of the target network or host, The
+#     final destination of the packet
 #
 # @metric: Route metric
 #
@@ -1899,7 +1905,8 @@
 #
 # @use: Route usage count (not for windows)
 #
-# @window: TCP window size, used for flow control (not for windows, IPv4 only)
+# @window: TCP window size, used for flow control (not for windows,
+#     IPv4 only)
 #
 # @mtu: Data link layer maximum packet size (not for windows)
 #
-- 
2.49.0


