Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA93813563
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 16:55:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDo2l-0005FN-TA; Thu, 14 Dec 2023 10:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rDo2g-0005Es-VR
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 10:54:31 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rDo2d-0006gr-T6
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 10:54:30 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:29a4:0:640:98d3:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 7E533613A3;
 Thu, 14 Dec 2023 18:54:22 +0300 (MSK)
Received: from davydov-max-nux.yandex-team.ru (unknown
 [2a02:6b8:b081:1332::1:18])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id XrmSvb0Gf0U0-9lCEq40u; Thu, 14 Dec 2023 18:54:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1702569261;
 bh=66CpuShpbWajSS35P8ay7B5OuqfNl1/EO7y9Wx9z0zA=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=OPcgyAm47dscau/hiEaVXgpudIwRvqQ7UwYQcVQvi1/G95QCU0NyUgmCz9bwtinIy
 WTGTYsxZQrFZBL39VcgrPmX3M2DqIdRjqI/st0awFY+qzXy+MCikT7qB6azvCaxl+c
 qM7sewB55plpwM2GAjncglk9a3hF1y73i7pNZtag=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: davydov-max@yandex-team.ru, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com, eblake@redhat.com,
 armbru@redhat.com, pbonzini@redhat.com, berrange@redhat.com, alxndr@bu.edu,
 bsd@redhat.com, stefanha@redhat.com, thuth@redhat.com,
 darren.kenny@oracle.com, Qiuhao.Li@outlook.com, lvivier@redhat.com
Subject: [PATCH v7 2/4] qmp: add dump machine type compatibility properties
Date: Thu, 14 Dec 2023 18:53:31 +0300
Message-Id: <20231214155333.35643-3-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214155333.35643-1-davydov-max@yandex-team.ru>
References: <20231214155333.35643-1-davydov-max@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

To control that creating new machine type doesn't affect the previous
types (their compat_props) and to check complex compat_props inheritance
we need qmp command to print machine type compatibility properties.
This patch adds the ability to get list of all the compat_props of the
corresponding supported machines for their comparison via new optional
argument of "query-machines" command.

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/core/machine-qmp-cmds.c  | 23 ++++++++++++-
 qapi/machine.json           | 64 +++++++++++++++++++++++++++++++++++--
 tests/qtest/fuzz/qos_fuzz.c |  2 +-
 3 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3860a50c3b..a49d0dc362 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -66,7 +66,8 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
     return head;
 }
 
-MachineInfoList *qmp_query_machines(Error **errp)
+MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
+                                    Error **errp)
 {
     GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
     MachineInfoList *mach_list = NULL;
@@ -98,6 +99,26 @@ MachineInfoList *qmp_query_machines(Error **errp)
             info->default_ram_id = g_strdup(mc->default_ram_id);
         }
 
+        if (compat_props && mc->compat_props) {
+            int i;
+            info->compat_props = NULL;
+            CompatPropertyList **tail = &(info->compat_props);
+            info->has_compat_props = true;
+
+            for (i = 0; i < mc->compat_props->len; i++) {
+                GlobalProperty *mt_prop = g_ptr_array_index(mc->compat_props,
+                                                            i);
+                CompatProperty *prop;
+
+                prop = g_malloc0(sizeof(*prop));
+                prop->driver = g_strdup(mt_prop->driver);
+                prop->property = g_strdup(mt_prop->property);
+                prop->value = g_strdup(mt_prop->value);
+
+                QAPI_LIST_APPEND(tail, prop);
+            }
+        }
+
         QAPI_LIST_PREPEND(mach_list, info);
     }
 
diff --git a/qapi/machine.json b/qapi/machine.json
index b6d634b30d..15a1d62f42 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -135,6 +135,29 @@
 ##
 { 'command': 'query-cpus-fast', 'returns': [ 'CpuInfoFast' ] }
 
+##
+# @CompatProperty:
+#
+# Machine type compatibility property that uses in machine
+# definitions to specify default values.  It's based on representaion
+# of properties in QEMU and created for machine type comparing
+# (see scripts/compare-machine-types.py)
+#
+# @driver: name of the driver which default value of certain property
+#     is changed in the machine type
+#
+# @property: property name
+#
+# @value: property value that will be assigned as default to
+#     the driver by machine type
+#
+# Since: 9.0
+##
+{ 'struct': 'CompatProperty',
+  'data': { 'driver': 'str',
+            'property': 'str',
+            'value': 'str' } }
+
 ##
 # @MachineInfo:
 #
@@ -166,6 +189,13 @@
 #
 # @acpi: machine type supports ACPI (since 8.0)
 #
+# @compat-props: List of the machine type's compatibility properties.
+#     (since 9.0)
+#
+# Features:
+#
+# @unstable: Member @compat-props is experimental.
+#
 # Since: 1.2
 ##
 { 'struct': 'MachineInfo',
@@ -173,18 +203,48 @@
             '*is-default': 'bool', 'cpu-max': 'int',
             'hotpluggable-cpus': 'bool',  'numa-mem-supported': 'bool',
             'deprecated': 'bool', '*default-cpu-type': 'str',
-            '*default-ram-id': 'str', 'acpi': 'bool' } }
+            '*default-ram-id': 'str', 'acpi': 'bool',
+            '*compat-props': { 'type': ['CompatProperty'],
+                               'features': ['unstable'] } } }
 
 ##
 # @query-machines:
 #
 # Return a list of supported machines
 #
+# @compat-props: if true return will contain information about
+#     machine type compatibility properties (since 9.0)
+#
 # Returns: a list of MachineInfo
 #
 # Since: 1.2
+#
+# Example:
+#
+# -> { "execute": "query-machines", "arguments": { "compat-props": true } }
+# <- { "return": [
+#          {
+#              "hotpluggable-cpus": true,
+#              "name": "pc-q35-6.2",
+#              "compat-props": [
+#                  {
+#                      "driver": "virtio-mem",
+#                      "property": "unplugged-inaccessible",
+#                      "value": "off"
+#                   }
+#               ],
+#               "numa-mem-supported": false,
+#               "default-cpu-type": "qemu64-x86_64-cpu",
+#               "cpu-max": 288,
+#               "deprecated": false,
+#               "default-ram-id": "pc.ram"
+#           },
+#           ...
+#    }
 ##
-{ 'command': 'query-machines', 'returns': ['MachineInfo'] }
+{ 'command': 'query-machines',
+  'data': { '*compat-props': 'bool' },
+  'returns': ['MachineInfo'] }
 
 ##
 # @CurrentMachineParams:
diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
index e403d373a0..b71e945c5f 100644
--- a/tests/qtest/fuzz/qos_fuzz.c
+++ b/tests/qtest/fuzz/qos_fuzz.c
@@ -46,7 +46,7 @@ static void qos_set_machines_devices_available(void)
     MachineInfoList *mach_info;
     ObjectTypeInfoList *type_info;
 
-    mach_info = qmp_query_machines(&error_abort);
+    mach_info = qmp_query_machines(false, false, &error_abort);
     machines_apply_to_node(mach_info);
     qapi_free_MachineInfoList(mach_info);
 
-- 
2.34.1


