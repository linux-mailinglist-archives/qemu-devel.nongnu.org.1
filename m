Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 085AB7C6B88
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:52:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtHC-00017C-Hj; Thu, 12 Oct 2023 06:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtGv-000101-5t; Thu, 12 Oct 2023 06:50:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtGo-0004vQ-Lt; Thu, 12 Oct 2023 06:50:28 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CAlJSH020562; Thu, 12 Oct 2023 10:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=5IrHtPsYX9wdFKbxZNtjx/Xpvv3e6f3slbo8RoyqlzA=;
 b=BjEGM5qZQIYxpLXhkBpbDBKhWoR91a3AyqBW/7p7+iLTGUJTdItzR6xhbBAlhTmHuLXf
 MbIhRQtriKXw2m5LAWK1wcjCsRfs6mnWQ9OGMAmiK/zcZnyffKlNnfx7IWE/grEyXw2r
 +d9+f7oxGiTQ3cGAUpOy3SDGVpICWPDZyByGFcXErStHtNHC+h+NlWvDuY+1inKYH1sq
 LXSUoYIZBUZbxjdTsOuSa0xGMQ5GI9mYk/zfjFCPk0HKLGQkAgkQavs0fwgTl4LE9u9P
 MXqJE5Bwhp5cP97bdJ4DLuCeEGBe8CVl3AgA945AjX/we+lfV3AUcn30RAmRfYIW/kcq 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfbp02jr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:18 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CAlRFh020922;
 Thu, 12 Oct 2023 10:50:17 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfbp02j9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:17 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39C8cUFR024452; Thu, 12 Oct 2023 10:50:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkhnsy8yw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:16 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CAoC0t27197700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 10:50:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3712220043;
 Thu, 12 Oct 2023 10:50:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C25D20040;
 Thu, 12 Oct 2023 10:50:10 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 10:50:10 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, qemu-devel@nongnu.org, mikey@neuling.org,
 vaibhav@linux.ibm.com, jniethe5@gmail.com, sbhat@linux.ibm.com,
 kconsul@linux.vnet.ibm.com, danielhb413@gmail.com
Subject: [PATCH v2 03/14] spapr: nested: Document Nested PAPR API
Date: Thu, 12 Oct 2023 16:19:40 +0530
Message-Id: <20231012104951.194876-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231012104951.194876-1-harshpb@linux.ibm.com>
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s51a3jJNx3IEh7r8QP99F0ht_YKoXPkf
X-Proofpoint-ORIG-GUID: TkXyqejFPrrY1s19zDsO0nWnbIaLMsbk
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120088
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Adding initial documentation about Nested PAPR API to describe the set
of APIs and its usage. Also talks about the Guest State Buffer elements
and it's format which is used between L0/L1 to communicate L2 state.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 docs/devel/nested-papr.txt | 500 +++++++++++++++++++++++++++++++++++++
 1 file changed, 500 insertions(+)
 create mode 100644 docs/devel/nested-papr.txt

diff --git a/docs/devel/nested-papr.txt b/docs/devel/nested-papr.txt
new file mode 100644
index 0000000000..3884794296
--- /dev/null
+++ b/docs/devel/nested-papr.txt
@@ -0,0 +1,500 @@
+Nested PAPR API (aka KVM on PowerVM)
+====================================
+
+This API aims at providing support to enable nested virtualization with
+KVM on PowerVM. While the existing support for nested KVM on PowerNV was
+introduced with cap-nested-hv option, however, with a slight design change,
+to enable this on papr/pseries, a new cap-nested-papr option is added. eg:
+
+  qemu-system-ppc64 -cpu POWER10 -machine pseries,cap-nested-papr=true ...
+
+Work by:
+    Michael Neuling <mikey@neuling.org>
+    Vaibhav Jain <vaibhav@linux.ibm.com>
+    Jordan Niethe <jniethe5@gmail.com>
+    Harsh Prateek Bora <harshpb@linux.ibm.com>
+    Shivaprasad G Bhat <sbhat@linux.ibm.com>
+    Kautuk Consul <kconsul@linux.vnet.ibm.com>
+
+Below taken from the kernel documentation:
+
+Introduction
+============
+
+This document explains how a guest operating system can act as a
+hypervisor and run nested guests through the use of hypercalls, if the
+hypervisor has implemented them. The terms L0, L1, and L2 are used to
+refer to different software entities. L0 is the hypervisor mode entity
+that would normally be called the "host" or "hypervisor". L1 is a
+guest virtual machine that is directly run under L0 and is initiated
+and controlled by L0. L2 is a guest virtual machine that is initiated
+and controlled by L1 acting as a hypervisor. A significant design change
+wrt existing API is that now the entire L2 state is maintained within L0.
+
+Existing Nested-HV API
+======================
+
+Linux/KVM has had support for Nesting as an L0 or L1 since 2018
+
+The L0 code was added::
+
+   commit 8e3f5fc1045dc49fd175b978c5457f5f51e7a2ce
+   Author: Paul Mackerras <paulus@ozlabs.org>
+   Date:   Mon Oct 8 16:31:03 2018 +1100
+   KVM: PPC: Book3S HV: Framework and hcall stubs for nested virtualization
+
+The L1 code was added::
+
+   commit 360cae313702cdd0b90f82c261a8302fecef030a
+   Author: Paul Mackerras <paulus@ozlabs.org>
+   Date:   Mon Oct 8 16:31:04 2018 +1100
+   KVM: PPC: Book3S HV: Nested guest entry via hypercall
+
+This API works primarily using a signal hcall h_enter_nested(). This
+call made by the L1 to tell the L0 to start an L2 vCPU with the given
+state. The L0 then starts this L2 and runs until an L2 exit condition
+is reached. Once the L2 exits, the state of the L2 is given back to
+the L1 by the L0. The full L2 vCPU state is always transferred from
+and to L1 when the L2 is run. The L0 doesn't keep any state on the L2
+vCPU (except in the short sequence in the L0 on L1 -> L2 entry and L2
+-> L1 exit).
+
+The only state kept by the L0 is the partition table. The L1 registers
+it's partition table using the h_set_partition_table() hcall. All
+other state held by the L0 about the L2s is cached state (such as
+shadow page tables).
+
+The L1 may run any L2 or vCPU without first informing the L0. It
+simply starts the vCPU using h_enter_nested(). The creation of L2s and
+vCPUs is done implicitly whenever h_enter_nested() is called.
+
+In this document, we call this existing API the v1 API.
+
+New PAPR API
+===============
+
+The new PAPR API changes from the v1 API such that the creating L2 and
+associated vCPUs is explicit. In this document, we call this the v2
+API.
+
+h_enter_nested() is replaced with H_GUEST_VCPU_RUN().  Before this can
+be called the L1 must explicitly create the L2 using h_guest_create()
+and any associated vCPUs() created with h_guest_create_vCPU(). Getting
+and setting vCPU state can also be performed using h_guest_{g|s}et
+hcall.
+
+The basic execution flow is for an L1 to create an L2, run it, and
+delete it is:
+
+- L1 and L0 negotiate capabilities with H_GUEST_{G,S}ET_CAPABILITIES()
+  (normally at L1 boot time).
+
+- L1 requests the L0 to create an L2 with H_GUEST_CREATE() and receives a token
+
+- L1 requests the L0 to create an L2 vCPU with H_GUEST_CREATE_VCPU()
+
+- L1 and L0 communicate the vCPU state using the H_GUEST_{G,S}ET() hcall
+
+- L1 requests the L0 to run the vCPU using H_GUEST_RUN_VCPU() hcall
+
+- L1 deletes L2 with H_GUEST_DELETE()
+
+More details of the individual hcalls follows:
+
+HCALL Details
+=============
+
+This documentation is provided to give an overall understating of the
+API. It doesn't aim to provide full details required to implement
+an L1 or L0. Latest PAPR spec shall be referred for more details.
+
+All these HCALLs are made by the L1 to the L0.
+
+H_GUEST_GET_CAPABILITIES()
+--------------------------
+
+This is called to get the capabilities of the L0 nested
+hypervisor. This includes capabilities such the CPU versions (eg
+POWER9, POWER10) that are supported as L2s.
+
+H_GUEST_SET_CAPABILITIES()
+--------------------------
+
+This is called to inform the L0 of the capabilities of the L1
+hypervisor. The set of flags passed here are the same as
+H_GUEST_GET_CAPABILITIES()
+
+Typically, GET will be called first and then SET will be called with a
+subset of the flags returned from GET. This process allows the L0 and
+L1 to negotiate a agreed set of capabilities.
+
+H_GUEST_CREATE()
+----------------
+
+This is called to create a L2. Returned is ID of the L2 created
+(similar to an LPID), which can be use on subsequent HCALLs to
+identify the L2.
+
+H_GUEST_CREATE_VCPU()
+---------------------
+
+This is called to create a vCPU associated with a L2. The L2 id
+(returned from H_GUEST_CREATE()) should be passed it. Also passed in
+is a unique (for this L2) vCPUid. This vCPUid is allocated by the
+L1.
+
+H_GUEST_SET_STATE()
+-------------------
+
+This is called to set L2 wide or vCPU specific L2 state. This info is
+passed via the Guest State Buffer (GSB), details below.
+
+This can set either L2 wide or vcpu specific information. Examples of
+L2 wide is the timebase offset or process scoped page table
+info. Examples of vCPU wide are GPRs or VSRs. A bit in the flags
+parameter specifies if this call is L2 wide or vCPU specific and the
+IDs in the GSB must match this.
+
+The L1 provides a pointer to the GSB as a parameter to this call. Also
+provided is the L2 and vCPU IDs associated with the state to set.
+
+The L1 writes all values in the GSB and the L0 only reads the GSB for
+this call
+
+H_GUEST_GET_STATE()
+-------------------
+
+This is called to get state associated with a L2 or L2 vCPU. This info
+passed via the GSB (details below).
+
+This can get either L2 wide or vcpu specific information. Examples of
+L2 wide is the timebase offset or process scoped page table
+info. Examples of vCPU wide are GPRs or VSRs. A bit in the flags
+parameter specifies if this call is L2 wide or vCPU specific and the
+IDs in the GSB must match this.
+
+The L1 provides a pointer to the GSB as a parameter to this call. Also
+provided is the L2 and vCPU IDs associated with the state to get.
+
+The L1 writes only the IDs and sizes in the GSB.  L0 writes the
+associated values for each ID in the GSB.
+
+H_GUEST_RUN_VCPU()
+------------------
+
+This is called to run an L2 vCPU. The L2 and vCPU IDs are passed in as
+parameters. The vCPU runs with the state set previously using
+H_GUEST_SET_STATE(). When the L2 exits, the L1 will resume from this
+hcall.
+
+This hcall also has associated input and output GSBs. Unlike
+H_GUEST_{S,G}ET_STATE(), these GSB pointers are not passed in as
+parameters to the hcall (This was done in the interest of
+performance). The locations of these GSBs must be preregistered using
+the H_GUEST_SET_STATE() call with ID 0x0c00 and 0x0c01 (see table later
+below).
+
+The input GSB may contain only VCPU wide elements to be set. This GSB
+may also contain zero elements (ie 0 in the first 4 bytes of the GSB)
+if nothing needs to be set.
+
+On exit from the hcall, the output buffer is filled with elements
+determined by the L0. The reason for the exit is contained in GPR4 (ie
+NIP is put in GPR4).  The elements returned depend on the exit
+type. For example, if the exit reason is the L2 doing a hcall (GPR4 =
+0xc00), then GPR3-12 are provided in the output GSB as this is the
+state likely needed to service the hcall. If additional state is
+needed, H_GUEST_GET_STATE() may be called by the L1.
+
+To synthesize interrupts in the L2, when calling H_GUEST_RUN_VCPU()
+the L1 may set a flag (as a hcall parameter) and the L0 will
+synthesize the interrupt in the L2. Alternatively, the L1 may
+synthesize the interrupt itself using H_GUEST_SET_STATE() or the
+H_GUEST_RUN_VCPU() input GSB to set the state appropriately.
+
+H_GUEST_DELETE()
+----------------
+
+This is called to delete an L2. All associated vCPUs are also
+deleted. No specific vCPU delete call is provided.
+
+A flag may be provided to delete all guests. This is used to reset the
+L0 in the case of kdump/kexec.
+
+Guest State Buffer (GSB)
+========================
+
+The Guest State Buffer (GSB) is the main method of communicating state
+about the L2 between the L1 and L0 via H_GUEST_{G,S}ET() and
+H_GUEST_VCPU_RUN() calls.
+
+State may be associated with a whole L2 (eg timebase offset) or a
+specific L2 vCPU (eg. GPR state). Only L2 VCPU state maybe be set by
+H_GUEST_VCPU_RUN().
+
+All data in the GSB is big endian (as is standard in PAPR)
+
+The Guest state buffer has a header which gives the number of
+elements, followed by the GSB elements themselves.
+
+GSB header:
+
++----------+----------+-------------------------------------------+
+|  Offset  |  Size    |  Purpose                                  |
+|  Bytes   |  Bytes   |                                           |
++==========+==========+===========================================+
+|    0     |    4     |  Number of elements                       |
++----------+----------+-------------------------------------------+
+|    4     |          |  Guest state buffer elements              |
++----------+----------+-------------------------------------------+
+
+GSB element:
+
++----------+----------+-------------------------------------------+
+|  Offset  |  Size    |  Purpose                                  |
+|  Bytes   |  Bytes   |                                           |
++==========+==========+===========================================+
+|    0     |    2     |  ID                                       |
++----------+----------+-------------------------------------------+
+|    2     |    2     |  Size of Value                            |
++----------+----------+-------------------------------------------+
+|    4     | As above |  Value                                    |
++----------+----------+-------------------------------------------+
+
+The ID in the GSB element specifies what is to be set. This includes
+archtected state like GPRs, VSRs, SPRs, plus also some meta data about
+the partition like the timebase offset and partition scoped page
+table information.
+
++--------+-------+----+--------+----------------------------------+
+|   ID   | Size  | RW | Thread | Details                          |
+|        | Bytes |    | Guest  |                                  |
+|        |       |    | Scope  |                                  |
++========+=======+====+========+==================================+
+| 0x0000 |       | RW |   TG   | NOP element                      |
++--------+-------+----+--------+----------------------------------+
+| 0x0001 | 0x08  | R  |   G    | Size of L0 vCPU state            |
++--------+-------+----+--------+----------------------------------+
+| 0x0002 | 0x08  | R  |   G    | Size Run vCPU out buffer         |
++--------+-------+----+--------+----------------------------------+
+| 0x0003 | 0x04  | RW |   G    | Logical PVR                      |
++--------+-------+----+--------+----------------------------------+
+| 0x0004 | 0x08  | RW |   G    | TB Offset (L1 relative)          |
++--------+-------+----+--------+----------------------------------+
+| 0x0005 | 0x18  | RW |   G    |Partition scoped page tbl info:   |
+|        |       |    |        |                                  |
+|        |       |    |        |- 0x00 Addr part scope table      |
+|        |       |    |        |- 0x08 Num addr bits              |
+|        |       |    |        |- 0x10 Size root dir              |
++--------+-------+----+--------+----------------------------------+
+| 0x0006 | 0x10  | RW |   G    |Process Table Information:        |
+|        |       |    |        |                                  |
+|        |       |    |        |- 0x0 Addr proc scope table       |
+|        |       |    |        |- 0x8 Table size.                 |
++--------+-------+----+--------+----------------------------------+
+| 0x0007-|       |    |        | Reserved                         |
+| 0x0BFF |       |    |        |                                  |
++--------+-------+----+--------+----------------------------------+
+| 0x0C00 | 0x10  | RW |   T    |Run vCPU Input Buffer:            |
+|        |       |    |        |                                  |
+|        |       |    |        |- 0x0 Addr of buffer              |
+|        |       |    |        |- 0x8 Buffer Size.                |
++--------+-------+----+--------+----------------------------------+
+| 0x0C01 | 0x10  | RW |   T    |Run vCPU Output Buffer:           |
+|        |       |    |        |                                  |
+|        |       |    |        |- 0x0 Addr of buffer              |
+|        |       |    |        |- 0x8 Buffer Size.                |
++--------+-------+----+--------+----------------------------------+
+| 0x0C02 | 0x08  | RW |   T    | vCPU VPA Address                 |
++--------+-------+----+--------+----------------------------------+
+| 0x0C03-|       |    |        | Reserved                         |
+| 0x0FFF |       |    |        |                                  |
++--------+-------+----+--------+----------------------------------+
+| 0x1000-| 0x08  | RW |   T    | GPR 0-31                         |
+| 0x101F |       |    |        |                                  |
++--------+-------+----+--------+----------------------------------+
+| 0x1020 |  0x08 | T  |   T    | HDEC expiry TB                   |
++--------+-------+----+--------+----------------------------------+
+| 0x1021 | 0x08  | RW |   T    | NIA                              |
++--------+-------+----+--------+----------------------------------+
+| 0x1022 | 0x08  | RW |   T    | MSR                              |
++--------+-------+----+--------+----------------------------------+
+| 0x1023 | 0x08  | RW |   T    | LR                               |
++--------+-------+----+--------+----------------------------------+
+| 0x1024 | 0x08  | RW |   T    | XER                              |
++--------+-------+----+--------+----------------------------------+
+| 0x1025 | 0x08  | RW |   T    | CTR                              |
++--------+-------+----+--------+----------------------------------+
+| 0x1026 | 0x08  | RW |   T    | CFAR                             |
++--------+-------+----+--------+----------------------------------+
+| 0x1027 | 0x08  | RW |   T    | SRR0                             |
++--------+-------+----+--------+----------------------------------+
+| 0x1028 | 0x08  | RW |   T    | SRR1                             |
++--------+-------+----+--------+----------------------------------+
+| 0x1029 | 0x08  | RW |   T    | DAR                              |
++--------+-------+----+--------+----------------------------------+
+| 0x102A | 0x08  | RW |   T    | DEC expiry TB                    |
++--------+-------+----+--------+----------------------------------+
+| 0x102B | 0x08  | RW |   T    | VTB                              |
++--------+-------+----+--------+----------------------------------+
+| 0x102C | 0x08  | RW |   T    | LPCR                             |
++--------+-------+----+--------+----------------------------------+
+| 0x102D | 0x08  | RW |   T    | HFSCR                            |
++--------+-------+----+--------+----------------------------------+
+| 0x102E | 0x08  | RW |   T    | FSCR                             |
++--------+-------+----+--------+----------------------------------+
+| 0x102F | 0x08  | RW |   T    | FPSCR                            |
++--------+-------+----+--------+----------------------------------+
+| 0x1030 | 0x08  | RW |   T    | DAWR0                            |
++--------+-------+----+--------+----------------------------------+
+| 0x1031 | 0x08  | RW |   T    | DAWR1                            |
++--------+-------+----+--------+----------------------------------+
+| 0x1032 | 0x08  | RW |   T    | CIABR                            |
++--------+-------+----+--------+----------------------------------+
+| 0x1033 | 0x08  | RW |   T    | PURR                             |
++--------+-------+----+--------+----------------------------------+
+| 0x1034 | 0x08  | RW |   T    | SPURR                            |
++--------+-------+----+--------+----------------------------------+
+| 0x1035 | 0x08  | RW |   T    | IC                               |
++--------+-------+----+--------+----------------------------------+
+| 0x1036-| 0x08  | RW |   T    | SPRG 0-3                         |
+| 0x1039 |       |    |        |                                  |
++--------+-------+----+--------+----------------------------------+
+| 0x103A | 0x08  | W  |   T    | PPR                              |
++--------+-------+----+--------+----------------------------------+
+| 0x103B | 0x08  | RW |   T    | MMCR 0-3                         |
+| 0x103E |       |    |        |                                  |
++--------+-------+----+--------+----------------------------------+
+| 0x103F | 0x08  | RW |   T    | MMCRA                            |
++--------+-------+----+--------+----------------------------------+
+| 0x1040 | 0x08  | RW |   T    | SIER                             |
++--------+-------+----+--------+----------------------------------+
+| 0x1041 | 0x08  | RW |   T    | SIER 2                           |
++--------+-------+----+--------+----------------------------------+
+| 0x1042 | 0x08  | RW |   T    | SIER 3                           |
++--------+-------+----+--------+----------------------------------+
+| 0x1043 | 0x08  | RW |   T    | BESCR                            |
++--------+-------+----+--------+----------------------------------+
+| 0x1044 | 0x08  | RW |   T    | EBBHR                            |
++--------+-------+----+--------+----------------------------------+
+| 0x1045 | 0x08  | RW |   T    | EBBRR                            |
++--------+-------+----+--------+----------------------------------+
+| 0x1046 | 0x08  | RW |   T    | AMR                              |
++--------+-------+----+--------+----------------------------------+
+| 0x1047 | 0x08  | RW |   T    | IAMR                             |
++--------+-------+----+--------+----------------------------------+
+| 0x1048 | 0x08  | RW |   T    | AMOR                             |
++--------+-------+----+--------+----------------------------------+
+| 0x1049 | 0x08  | RW |   T    | UAMOR                            |
++--------+-------+----+--------+----------------------------------+
+| 0x104A | 0x08  | RW |   T    | SDAR                             |
++--------+-------+----+--------+----------------------------------+
+| 0x104B | 0x08  | RW |   T    | SIAR                             |
++--------+-------+----+--------+----------------------------------+
+| 0x104C | 0x08  | RW |   T    | DSCR                             |
++--------+-------+----+--------+----------------------------------+
+| 0x104D | 0x08  | RW |   T    | TAR                              |
++--------+-------+----+--------+----------------------------------+
+| 0x104E | 0x08  | RW |   T    | DEXCR                            |
++--------+-------+----+--------+----------------------------------+
+| 0x104F | 0x08  | RW |   T    | HDEXCR                           |
++--------+-------+----+--------+----------------------------------+
+| 0x1050 | 0x08  | RW |   T    | HASHKEYR                         |
++--------+-------+----+--------+----------------------------------+
+| 0x1051 | 0x08  | RW |   T    | HASHPKEYR                        |
++--------+-------+----+--------+----------------------------------+
+| 0x1052 | 0x08  | RW |   T    | CTRL                             |
++--------+-------+----+--------+----------------------------------+
+| 0x1053-|       |    |        | Reserved                         |
+| 0x1FFF |       |    |        |                                  |
++--------+-------+----+--------+----------------------------------+
+| 0x2000 | 0x04  | RW |   T    | CR                               |
++--------+-------+----+--------+----------------------------------+
+| 0x2001 | 0x04  | RW |   T    | PIDR                             |
++--------+-------+----+--------+----------------------------------+
+| 0x2002 | 0x04  | RW |   T    | DSISR                            |
++--------+-------+----+--------+----------------------------------+
+| 0x2003 | 0x04  | RW |   T    | VSCR                             |
++--------+-------+----+--------+----------------------------------+
+| 0x2004 | 0x04  | RW |   T    | VRSAVE                           |
++--------+-------+----+--------+----------------------------------+
+| 0x2005 | 0x04  | RW |   T    | DAWRX0                           |
++--------+-------+----+--------+----------------------------------+
+| 0x2006 | 0x04  | RW |   T    | DAWRX1                           |
++--------+-------+----+--------+----------------------------------+
+| 0x2007-| 0x04  | RW |   T    | PMC 1-6                          |
+| 0x200c |       |    |        |                                  |
++--------+-------+----+--------+----------------------------------+
+| 0x200D | 0x04  | RW |   T    | WORT                             |
++--------+-------+----+--------+----------------------------------+
+| 0x200E | 0x04  | RW |   T    | PSPB                             |
++--------+-------+----+--------+----------------------------------+
+| 0x200F-|       |    |        | Reserved                         |
+| 0x2FFF |       |    |        |                                  |
++--------+-------+----+--------+----------------------------------+
+| 0x3000-| 0x10  | RW |   T    | VSR 0-63                         |
+| 0x303F |       |    |        |                                  |
++--------+-------+----+--------+----------------------------------+
+| 0x3040-|       |    |        | Reserved                         |
+| 0xEFFF |       |    |        |                                  |
++--------+-------+----+--------+----------------------------------+
+| 0xF000 | 0x08  | R  |   T    | HDAR                             |
++--------+-------+----+--------+----------------------------------+
+| 0xF001 | 0x04  | R  |   T    | HDSISR                           |
++--------+-------+----+--------+----------------------------------+
+| 0xF002 | 0x04  | R  |   T    | HEIR                             |
++--------+-------+----+--------+----------------------------------+
+| 0xF003 | 0x08  | R  |   T    | ASDR                             |
++--------+-------+----+--------+----------------------------------+
+
+Miscellaneous info
+==================
+
+State not in ptregs/hvregs
+--------------------------
+
+In the v1 API, some state is not in the ptregs/hvstate. This includes
+the vector register and some SPRs. For the L1 to set this state for
+the L2, the L1 loads up these hardware registers before the
+h_enter_nested() call and the L0 ensures they end up as the L2 state
+(by not touching them).
+
+The v2 API removes this and explicitly sets this state via the GSB.
+
+L1 Implementation details: Caching state
+----------------------------------------
+
+In the v1 API, all state is sent from the L1 to the L0 and vice versa
+on every h_enter_nested() hcall. If the L0 is not currently running
+any L2s, the L0 has no state information about them. The only
+exception to this is the location of the partition table, registered
+via h_set_partition_table().
+
+The v2 API changes this so that the L0 retains the L2 state even when
+it's vCPUs are no longer running. This means that the L1 only needs to
+communicate with the L0 about L2 state when it needs to modify the L2
+state, or when it's value is out of date. This provides an opportunity
+for performance optimisation.
+
+When a vCPU exits from a H_GUEST_RUN_VCPU() call, the L1 internally
+marks all L2 state as invalid. This means that if the L1 wants to know
+the L2 state (say via a kvm_get_one_reg() call), it needs  to call
+H_GUEST_GET_STATE() to get that state. Once it's read, it's marked as
+valid in L1 until the L2 is run again.
+
+Also, when an L1 modifies L2 vcpu state, it doesn't need to write it
+to the L0 until that L2 vcpu runs again. Hence when the L1 updates
+state (say via a kvm_set_one_reg() call), it writes to an internal L1
+copy and only flushes this copy to the L0 when the L2 runs again via
+the H_GUEST_VCPU_RUN() input buffer.
+
+This lazy updating of state by the L1 avoids unnecessary
+H_GUEST_{G|S}ET_STATE() calls.
+
+References
+==========
+
+For more details, please refer:
+
+[1] Kernel documentation (patches accepted upstream):
+    https://lore.kernel.org/linuxppc-dev/169528846875.874757.8861595746180557787.b4-ty@ellerman.id.au/
-- 
2.39.3


