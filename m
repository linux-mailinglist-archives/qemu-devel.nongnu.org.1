Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FCFA84769
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Apr 2025 17:11:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2tXv-0000xW-Bf; Thu, 10 Apr 2025 11:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1u2tXs-0000xC-Pu; Thu, 10 Apr 2025 11:10:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1u2tXq-0003bl-AE; Thu, 10 Apr 2025 11:10:24 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AEEDHh003370;
 Thu, 10 Apr 2025 15:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=MABboR6Rm7+B7kBVq
 ed5pRCFnpozhi3cWwJyGEU8hcA=; b=gkxO9az66ETHkOVz88Mm8KShFGmahCodo
 qAlH19n1kIPbZRY8nFCHWL6oQKGvRNJwfkNdKsCRfv3i4+Rf+4Dy+k4JpJjXQOJ1
 qVK3I+5E920gaIyRz/6+/nJPL/7PH1P6IPyLoqO3oX7KqiRpWImBsiTZ5wVTZQqh
 EEhnLIIjjE6yFzlsUnmJIiZEAdC42NdiLnEBpBz33e/3V9RP3xJypoa8MQTVjxlO
 /mMwT/rD00L5Nppzo/qCgFbtL6l6pDHk2jML24wwaTaYKwTUSjQrg1R1Vl/C6J+B
 kVD0ZeRnVKMpJNJdcSzrkXl8jzn7MC4QT9oJOGPlVkPYpFbZV34QA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x0405dxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 15:10:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53ADke3u017447;
 Thu, 10 Apr 2025 15:10:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2kxcbh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 15:10:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53AFAFCF56230146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 15:10:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEF6320043;
 Thu, 10 Apr 2025 15:10:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70A4B20040;
 Thu, 10 Apr 2025 15:10:15 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Apr 2025 15:10:15 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Daniel Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH v4 1/4] hw/s390x: add SCLP event type CPI
Date: Thu, 10 Apr 2025 17:09:31 +0200
Message-ID: <20250410150934.1331433-2-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410150934.1331433-1-shalini@linux.ibm.com>
References: <20250410150934.1331433-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oCBI1N1qCenq0AbR6g0xexaspvZLYElj
X-Proofpoint-GUID: oCBI1N1qCenq0AbR6g0xexaspvZLYElj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100109
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Implement the Service-Call Logical Processor (SCLP) event
type Control-Program Identification (CPI) in QEMU. This
event is used to send CPI identifiers from the guest to the
host. The CPI identifiers are: system type, system name,
system level and sysplex name.

System type: operating system of the guest (e.g. "LINUX").
System name: user configurable name of the guest (e.g. "TESTVM").
System level: distribution and kernel version, if the system type is Linux
(e.g. 0x50e00).
Sysplex name: name of the cluster which the guest belongs to (if any)
(e.g. "PLEX").

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/event-facility.c         |  2 +
 hw/s390x/meson.build              |  1 +
 hw/s390x/s390-virtio-ccw.c        | 14 +++++
 hw/s390x/sclpcpi.c                | 92 +++++++++++++++++++++++++++++++
 include/hw/s390x/event-facility.h | 13 +++++
 5 files changed, 122 insertions(+)
 create mode 100644 hw/s390x/sclpcpi.c

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 2b0332c20e..60237b8581 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -4,6 +4,7 @@
  *       handles SCLP event types
  *          - Signal Quiesce - system power down
  *          - ASCII Console Data - VT220 read and write
+ *          - Control-Program Identification - Send OS data from guest to host
  *
  * Copyright IBM, Corp. 2012
  *
@@ -40,6 +41,7 @@ struct SCLPEventFacility {
     SysBusDevice parent_obj;
     SCLPEventsBus sbus;
     SCLPEvent quiesce, cpu_hotplug;
+    SCLPEventCPI cpi;
     /* guest's receive mask */
     union {
         uint32_t receive_mask_pieces[2];
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 3bbebfd817..eb7950489c 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -13,6 +13,7 @@ s390x_ss.add(files(
   's390-skeys.c',
   's390-stattrib.c',
   'sclp.c',
+  'sclpcpi.c',
   'sclpcpu.c',
   'sclpquiesce.c',
   'tod.c',
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 75b32182eb..7f28cbd1de 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -260,6 +260,17 @@ static void s390_create_sclpconsole(SCLPDevice *sclp,
     qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
 }
 
+static void s390_create_sclpcpi(SCLPDevice *sclp)
+{
+    SCLPEventFacility *ef = sclp->event_facility;
+    BusState *ev_fac_bus = sclp_get_event_facility_bus(ef);
+    DeviceState *dev;
+
+    dev = qdev_new(TYPE_SCLP_EVENT_CPI);
+    object_property_add_child(OBJECT(ef), "sclpcpi", OBJECT(dev));
+    qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
+}
+
 static void ccw_init(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -323,6 +334,9 @@ static void ccw_init(MachineState *machine)
 
     /* init the TOD clock */
     s390_init_tod();
+
+    /* init SCLP event Control-Program Identification */
+    s390_create_sclpcpi(ms->sclp);
 }
 
 static void s390_cpu_plug(HotplugHandler *hotplug_dev,
diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
new file mode 100644
index 0000000000..13589459b1
--- /dev/null
+++ b/hw/s390x/sclpcpi.c
@@ -0,0 +1,92 @@
+ /*
+  * SPDX-License-Identifier: GPL-2.0-or-later
+  *
+  * SCLP event type 11 - Control-Program Identification (CPI):
+  *    CPI is used to send program identifiers from the guest to the
+  *    Service-Call Logical Processor (SCLP). It is not sent by the SCLP.
+  *    Please refer S390ControlProgramId QOM-type description for details
+  *    on the contents of the CPI.
+  *
+  * Copyright IBM, Corp. 2024
+  *
+  * Authors:
+  *  Shalini Chellathurai Saroja <shalini@linux.ibm.com>
+  *
+  * This work is licensed under the terms of the GNU GPL, version 2 or (at your
+  * option) any later version.  See the COPYING file in the top-level directory.
+  *
+  */
+
+#include "qemu/osdep.h"
+#include "hw/s390x/event-facility.h"
+
+typedef struct Data {
+    uint8_t id_format;
+    uint8_t reserved0;
+    uint8_t system_type[8];
+    uint64_t reserved1;
+    uint8_t system_name[8];
+    uint64_t reserved2;
+    uint64_t system_level;
+    uint64_t reserved3;
+    uint8_t sysplex_name[8];
+    uint8_t reserved4[16];
+} QEMU_PACKED Data;
+
+typedef struct ControlProgramIdMsg {
+    EventBufferHeader ebh;
+    Data data;
+} QEMU_PACKED ControlProgramIdMsg;
+
+static bool can_handle_event(uint8_t type)
+{
+    return type == SCLP_EVENT_CTRL_PGM_ID;
+}
+
+static sccb_mask_t send_mask(void)
+{
+    return 0;
+}
+
+/* Enable SCLP to accept buffers of event type CPI from the control-program. */
+static sccb_mask_t receive_mask(void)
+{
+    return SCLP_EVENT_MASK_CTRL_PGM_ID;
+}
+
+static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
+{
+    ControlProgramIdMsg *cpim = container_of(evt_buf_hdr, ControlProgramIdMsg,
+                                             ebh);
+
+    cpim->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
+    return SCLP_RC_NORMAL_COMPLETION;
+}
+
+static void cpi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SCLPEventClass *k = SCLP_EVENT_CLASS(klass);
+
+    dc->user_creatable = false;
+
+    k->can_handle_event = can_handle_event;
+    k->get_send_mask = send_mask;
+    k->get_receive_mask = receive_mask;
+    k->write_event_data = write_event_data;
+}
+
+static const TypeInfo sclp_cpi_info = {
+    .name          = TYPE_SCLP_EVENT_CPI,
+    .parent        = TYPE_SCLP_EVENT,
+    .instance_size = sizeof(SCLPEventCPI),
+    .class_init    = cpi_class_init,
+};
+
+static void sclp_cpi_register_types(void)
+{
+    type_register_static(&sclp_cpi_info);
+}
+
+type_init(sclp_cpi_register_types)
+
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index ff874e792d..ef469e62ae 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -25,6 +25,7 @@
 #define SCLP_EVENT_MESSAGE                      0x02
 #define SCLP_EVENT_CONFIG_MGT_DATA              0x04
 #define SCLP_EVENT_PMSGCMD                      0x09
+#define SCLP_EVENT_CTRL_PGM_ID                  0x0b
 #define SCLP_EVENT_ASCII_CONSOLE_DATA           0x1a
 #define SCLP_EVENT_SIGNAL_QUIESCE               0x1d
 
@@ -35,6 +36,7 @@
 #define SCLP_EVENT_MASK_MSG             SCLP_EVMASK(SCLP_EVENT_MESSAGE)
 #define SCLP_EVENT_MASK_CONFIG_MGT_DATA SCLP_EVMASK(SCLP_EVENT_CONFIG_MGT_DATA)
 #define SCLP_EVENT_MASK_PMSGCMD         SCLP_EVMASK(SCLP_EVENT_PMSGCMD)
+#define SCLP_EVENT_MASK_CTRL_PGM_ID     SCLP_EVMASK(SCLP_EVENT_CTRL_PGM_ID)
 #define SCLP_EVENT_MASK_MSG_ASCII       SCLP_EVMASK(SCLP_EVENT_ASCII_CONSOLE_DATA)
 #define SCLP_EVENT_MASK_SIGNAL_QUIESCE  SCLP_EVMASK(SCLP_EVENT_SIGNAL_QUIESCE)
 
@@ -191,6 +193,17 @@ struct SCLPEventClass {
     bool (*can_handle_event)(uint8_t type);
 };
 
+#define TYPE_SCLP_EVENT_CPI "sclpcpi"
+typedef struct SCLPEventCPIClass SCLPEventCPIClass;
+typedef struct SCLPEventCPI SCLPEventCPI;
+OBJECT_DECLARE_TYPE(SCLPEventCPI, SCLPEventCPIClass,
+                    SCLP_EVENT_CPI)
+
+struct SCLPEventCPI {
+    DeviceState qdev;
+    SCLPEvent event;
+};
+
 #define TYPE_SCLP_EVENT_FACILITY "s390-sclp-event-facility"
 typedef struct SCLPEventFacility SCLPEventFacility;
 typedef struct SCLPEventFacilityClass SCLPEventFacilityClass;
-- 
2.49.0


