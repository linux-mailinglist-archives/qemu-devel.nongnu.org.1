Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBAE939B55
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jul 2024 09:04:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9YY-00067N-A8; Tue, 23 Jul 2024 03:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9YW-00061f-Id
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9YU-0000q8-Ud
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721718206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDm+bALEuRyr/I6SUsJtjqWPSF0aymjvBOySRpCpJs8=;
 b=PRFZE4wnHIlVNgWcMtpCGjnZtsnFNIq0xOnAEUzaavekuCZ6rIuLEQme77V/Nef60IL39a
 fD4qSH9skpZUsd4dl6LCtaqAOYY9ExGxgqsyKqh9kQIkaTTFwJ/cD7WTbiawMqMACWvcCv
 zAbgw4Y4DsTWcplRLR72Y4XCdyZNplQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-a384r1u9OJCQJclz191afQ-1; Tue,
 23 Jul 2024 03:03:21 -0400
X-MC-Unique: a384r1u9OJCQJclz191afQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74AFD1955D4A; Tue, 23 Jul 2024 07:03:20 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.211])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F06873000192; Tue, 23 Jul 2024 07:03:18 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 12/25] qga: conditionalize schema for commands only
 supported on Windows
Date: Tue, 23 Jul 2024 10:02:38 +0300
Message-ID: <20240723070251.25575-13-kkostiuk@redhat.com>
In-Reply-To: <20240723070251.25575-1-kkostiuk@redhat.com>
References: <20240723070251.25575-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Rather than creating stubs for every command that just return
QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
fully exclude generation of the commands on non-Windows.

The command will be rejected at QMP dispatch time instead,
avoiding reimplementing rejection by blocking the stub commands.
This changes the error message for affected commands from

    {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}

to

    {"class": "CommandNotFound", "desc": "The command FOO has not been found"}

This has the additional benefit that the QGA protocol reference
now documents what conditions enable use of the command.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20240712132459.3974109-13-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-posix.c |  9 ---------
 qga/qapi-schema.json | 15 ++++++++++-----
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 838dc3cf98..b7f96aa005 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1207,8 +1207,6 @@ GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
     blockedrpcs = g_list_append(blockedrpcs, g_strdup("guest-fstrim"));
 #endif
 
-    blockedrpcs = g_list_append(blockedrpcs, g_strdup("guest-get-devices"));
-
     return blockedrpcs;
 }
 
@@ -1419,13 +1417,6 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
     return info;
 }
 
-GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-
-    return NULL;
-}
-
 #ifndef HOST_NAME_MAX
 # ifdef _POSIX_HOST_NAME_MAX
 #  define HOST_NAME_MAX _POSIX_HOST_NAME_MAX
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 9bd5aa53bc..de3fc46d2e 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1527,7 +1527,8 @@
 # @pci: PCI device
 ##
 { 'enum': 'GuestDeviceType',
-  'data': [ 'pci' ] }
+  'data': [ 'pci' ],
+  'if': 'CONFIG_WIN32' }
 
 ##
 # @GuestDeviceIdPCI:
@@ -1539,7 +1540,8 @@
 # Since: 5.2
 ##
 { 'struct': 'GuestDeviceIdPCI',
-  'data': { 'vendor-id': 'uint16', 'device-id': 'uint16' } }
+  'data': { 'vendor-id': 'uint16', 'device-id': 'uint16' },
+  'if': 'CONFIG_WIN32' }
 
 ##
 # @GuestDeviceId:
@@ -1553,7 +1555,8 @@
 { 'union': 'GuestDeviceId',
   'base': { 'type': 'GuestDeviceType' },
   'discriminator': 'type',
-  'data': { 'pci': 'GuestDeviceIdPCI' } }
+  'data': { 'pci': 'GuestDeviceIdPCI' },
+  'if': 'CONFIG_WIN32' }
 
 ##
 # @GuestDeviceInfo:
@@ -1574,7 +1577,8 @@
       '*driver-date': 'int',
       '*driver-version': 'str',
       '*id': 'GuestDeviceId'
-  } }
+  },
+  'if': 'CONFIG_WIN32' }
 
 ##
 # @guest-get-devices:
@@ -1586,7 +1590,8 @@
 # Since: 5.2
 ##
 { 'command': 'guest-get-devices',
-  'returns': ['GuestDeviceInfo'] }
+  'returns': ['GuestDeviceInfo'],
+  'if': 'CONFIG_WIN32' }
 
 ##
 # @GuestAuthorizedKeys:
-- 
2.45.2


