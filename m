Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7264BCF665
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:08:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aAQ-00010N-UI; Sat, 11 Oct 2025 10:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a8N-0006Tz-S0
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:43 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7q-0004oy-20
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9B3F5C01A0;
 Sat, 11 Oct 2025 16:58:29 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-ODzUNXSf; Sat, 11 Oct 2025 16:58:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191109;
 bh=jF5DMz7FK770rPiy+6De6nFoweGddyCi1itUtDW1KO8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=zRO3/jRVNNTpcy3R1wuFkj/u8k2kxL6lOgdKS0nMyy8cMrXN31B4V29FenuNb15BW
 Lu8mtS/myiMot4c8lykeVv/SFsVPB0HbDfJLmPACp0HsTwix9Kcjj0Nvk8cKlH/yWh
 patOyMp9KVdm0W0KFczXipnbq+7puLA6tGxUA7Js=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH 32/33] qga/qapi-schema.json: reflow docs to width=70 and two
 spaces between sentences
Date: Sat, 11 Oct 2025 16:57:44 +0300
Message-ID: <20251011135754.294521-64-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011135754.294521-1-vsementsov@yandex-team.ru>
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qga/qapi-schema.json | 83 ++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 38 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 8162d888bb..9e3fd1eee5 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
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
+#     command before sending commands when the guest resumes.
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
+#     command before sending commands when the guest resumes.
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
+#     command before sending commands when the guest resumes.
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
+#     by calculating the average CPU usage in the last 1, 5, 15
+#     minutes similar as Linux does this.  Calculation starts from the
+#     first time this command is called.
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
2.48.1


