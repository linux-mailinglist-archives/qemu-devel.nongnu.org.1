Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 466FCADB2E1
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Jun 2025 16:03:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRAPL-0004gN-7U; Mon, 16 Jun 2025 10:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uRAOz-0004PX-6q; Mon, 16 Jun 2025 10:01:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uRAOw-0002iE-KB; Mon, 16 Jun 2025 10:01:32 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G5Sv6l021040;
 Mon, 16 Jun 2025 14:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nzJCdpa6pRup70FRm
 7V2FLPHDBNBprbu8bKymNgtLD4=; b=c4CcbR6mUC4W/kUhojXTaEEl4A59rxiMZ
 5pCfZXebJ8NUoz2se2mWI7R15O47qNmWR6gHed7NDcM9VFgOV5Ja15Xuk+mscInK
 AJIf1FiR7A55i1eEiPHwIYxDWd1qmkyQ2wEfPBR+7XFjQcs0azLN6TajYZKNfKts
 9fF2Y7w/56W903UR14sggUAmWY4GdL6ZMG5HMEpvXz7XHAOye6LwZ7iY7wxTQw9r
 pbTQiBdl+bJ/wW+toQUIXHhPtG3SLId3GsupkdkakZFM95DKsJDHCGu12aYd/1xY
 MkowQDARI+GwosvZ0/own+1qD/FdU/FfMEomfBUHuOrrkuUOo6X8w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790tdt953-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 14:01:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GC79Hj027475;
 Mon, 16 Jun 2025 14:01:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479ksypgnw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 14:01:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55GE1Mex28311828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Jun 2025 14:01:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1159E2004D;
 Mon, 16 Jun 2025 14:01:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C22CE20043;
 Mon, 16 Jun 2025 14:01:21 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Jun 2025 14:01:21 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Cc: Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH v6 1/3] hw/s390x: add SCLP event type CPI
Date: Mon, 16 Jun 2025 16:01:05 +0200
Message-ID: <20250616140107.990538-2-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616140107.990538-1-shalini@linux.ibm.com>
References: <20250616140107.990538-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XQ80_kRPUVUpWH2UF-YhxRlOhiFYM9px
X-Proofpoint-GUID: XQ80_kRPUVUpWH2UF-YhxRlOhiFYM9px
X-Authority-Analysis: v=2.4 cv=c92rQQ9l c=1 sm=1 tr=0 ts=685023b7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=4KQUGMdETVzdB9oGavsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA4NyBTYWx0ZWRfX7uW1gAM9Zdd/
 aizOfjnLuBxui2kqjHgHaPKVZ/R2/VytvOmFENRBIVq40EeCxnrMkYxFLpQOwLhp9X8BAvllUCu
 16L8iLo6gZSeUSo8WQ+bkXSIeYS9EE146hzghU+uQADt+i12sGMolmfUkTX2na8nHznWYQ91G9B
 1GCffmmcV7nPWUEagJEtsuC5+JocCW9Nw2h3eD5mp++vTD5iyGorkcCb+LgVuLyHXXp0BLsIehN
 VoZzVmd3x9iwk/hiCTBv8ViCtVT87jnq7GWsGLsgZQjDPUONPyakU89JkT8slte3/iC5kKzYdFI
 lpwP9VYxSZlDROUQLNTjlzj1B39vJsOcHybBuaNGBUF7JL5ZSeUnG+ONm6cocZctnFR1EUHmqI2
 u/yyLj8TUHGaZ6y65j6PqcM5IzrJwACReZcbXoyXjf79v1zO6lu4PsP3hFiEURcZPRlysz75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160087
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

System type: operating system of the guest (e.g. "LINUX   ").
System name: user configurable name of the guest (e.g. "TESTVM  ").
System level: distribution and kernel version, if the system type is Linux
(e.g. 74872343805430528).
Sysplex name: name of the cluster which the guest belongs to (if any)
(e.g. "PLEX").

The SCLP event CPI is supported only from "s390-ccw-virtio-10.1" machine
and higher.

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/event-facility.c          |   2 +
 hw/s390x/meson.build               |   1 +
 hw/s390x/s390-virtio-ccw.c         |  22 +++++
 hw/s390x/sclpcpi.c                 | 124 +++++++++++++++++++++++++++++
 include/hw/s390x/event-facility.h  |  12 +++
 include/hw/s390x/s390-virtio-ccw.h |   1 +
 6 files changed, 162 insertions(+)
 create mode 100644 hw/s390x/sclpcpi.c

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 7b7bf237fe..fee286ea63 100644
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
index 99cbcbd7d6..1bc8583799 100644
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
index ce3c13defb..a79bd13275 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -260,9 +260,21 @@ static void s390_create_sclpconsole(SCLPDevice *sclp,
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
+    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
     S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
     int ret;
     VirtualCssBus *css_bus;
@@ -323,6 +335,12 @@ static void ccw_init(MachineState *machine)
 
     /* init the TOD clock */
     s390_init_tod();
+
+    /* init SCLP event Control-Program Identification */
+    if (s390mc->use_cpi) {
+        s390_create_sclpcpi(ms->sclp);
+    }
+
 }
 
 static void s390_cpu_plug(HotplugHandler *hotplug_dev,
@@ -783,6 +801,7 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
     DumpSKeysInterface *dsi = DUMP_SKEYS_INTERFACE_CLASS(oc);
 
     s390mc->max_threads = 1;
+    s390mc->use_cpi = true;
     mc->reset = s390_machine_reset;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
@@ -908,6 +927,9 @@ static void ccw_machine_10_0_instance_options(MachineState *machine)
 
 static void ccw_machine_10_0_class_options(MachineClass *mc)
 {
+    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
+    s390mc->use_cpi = false;
+
     ccw_machine_10_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
 }
diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
new file mode 100644
index 0000000000..a0b175c5d5
--- /dev/null
+++ b/hw/s390x/sclpcpi.c
@@ -0,0 +1,124 @@
+ /*
+  * SPDX-License-Identifier: GPL-2.0-or-later
+  *
+  * SCLP event type 11 - Control-Program Identification (CPI):
+  *    CPI is used to send program identifiers from the guest to the
+  *    Service-Call Logical Processor (SCLP). It is not sent by the SCLP.
+  *
+  *    Control-program identifiers provide data about the guest operating
+  *    system.  The control-program identifiers are: system type, system name,
+  *    system level and sysplex name.
+  *
+  *    In Linux, all the control-program identifiers are user configurable. The
+  *    system type, system name, and sysplex name use EBCDIC characters from
+  *    this set: capital A-Z, 0-9, $, @, #, and blank.  In Linux, the system
+  *    type, system name and sysplex name are arbitrary free-form texts.
+  *
+  *    In Linux, the 8-byte hexadecimal system-level has the format
+  *    0x<a><b><cc><dd><eeee><ff><gg><hh>, where:
+  *    <a>: is a 4-bit digit, its most significant bit indicates hypervisor use
+  *    <b>: is one digit that represents Linux distributions as follows
+  *    0: generic Linux
+  *    1: Red Hat Enterprise Linux
+  *    2: SUSE Linux Enterprise Server
+  *    3: Canonical Ubuntu
+  *    4: Fedora
+  *    5: openSUSE Leap
+  *    6: Debian GNU/Linux
+  *    7: Red Hat Enterprise Linux CoreOS
+  *    <cc>: are two digits for a distribution-specific encoding of the major
+  *    version of the distribution
+  *    <dd>: are two digits for a distribution-specific encoding of the minor
+  *    version of the distribution
+  *    <eeee>: are four digits for the patch level of the distribution
+  *    <ff>: are two digits for the major version of the kernel
+  *    <gg>: are two digits for the minor version of the kernel
+  *    <hh>: are two digits for the stable version of the kernel
+  *    (e.g. 74872343805430528, when converted to hex is 0x010a000000060b00). On
+  *    machines prior to z16, some of the values are not available to display.
+  *
+  *    Sysplex refers to a cluster of logical partitions that communicates and
+  *    co-operates with each other.
+  *
+  *    The CPI feature is supported since 10.1.
+  *
+  * Copyright IBM, Corp. 2024
+  *
+  * Authors:
+  *  Shalini Chellathurai Saroja <shalini@linux.ibm.com>
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
+static void cpi_class_init(ObjectClass *klass, const void *data)
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
index ff874e792d..e81bc80498 100644
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
 
@@ -191,6 +193,16 @@ struct SCLPEventClass {
     bool (*can_handle_event)(uint8_t type);
 };
 
+#define TYPE_SCLP_EVENT_CPI "sclpcpi"
+typedef struct SCLPEventCPIClass SCLPEventCPIClass;
+typedef struct SCLPEventCPI SCLPEventCPI;
+OBJECT_DECLARE_TYPE(SCLPEventCPI, SCLPEventCPIClass,
+                    SCLP_EVENT_CPI)
+
+struct SCLPEventCPI {
+    SCLPEvent event;
+};
+
 #define TYPE_SCLP_EVENT_FACILITY "s390-sclp-event-facility"
 typedef struct SCLPEventFacility SCLPEventFacility;
 typedef struct SCLPEventFacilityClass SCLPEventFacilityClass;
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 321b26df30..526078a4e2 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -54,6 +54,7 @@ struct S390CcwMachineClass {
 
     /*< public >*/
     int max_threads;
+    bool use_cpi;
 };
 
 #endif
-- 
2.49.0


