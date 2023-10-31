Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CA87DC3A5
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 01:37:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxcje-0001o6-6a; Mon, 30 Oct 2023 20:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxcjW-0001ns-UV
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 20:35:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxcjT-0001Hf-OL
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 20:35:49 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39V0U1wO018743; Tue, 31 Oct 2023 00:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OM0MmV26yPywY7AS4bWdr15u2tcyCImeFLj0GAOTBtg=;
 b=eqv/hmeIW74t1gsg3XD39CG+/FEqZPl6loBUqVkLIoQXerWnCS+H/gZZrFD1fjwb+nhS
 b4TPXzgDdosvuK5j03XjGq+7CHia/NSNOhRMVvCckS54zWzlY/OhXtsIRNzhjAYXAqZb
 P5Gtr9TjayKb5iLZsDtw9YoDJDEchnF6hY2YsLXvIfk2txlce6Cv/Sybei6P6BysFetb
 gkN/Vea3Ic3jFii5Pl+w/WdRlF/2E8phANp21i8sgR674372I9eEQYUVVniD2AhFFdxa
 smBSoCu4YojI2kWUwRUX67Dc5wqzlD9wKkALIGXf/YQt1jmjdJ4nNixIN6zaXG/hEJvG +A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2q3bg5ku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 00:35:43 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39V0U6hT018960;
 Tue, 31 Oct 2023 00:35:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2q3bg5jq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 00:35:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39UMq9kr007726; Tue, 31 Oct 2023 00:35:42 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1dmnct04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 00:35:42 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39V0ZfQj8847896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Oct 2023 00:35:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC96158063;
 Tue, 31 Oct 2023 00:35:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D7F858043;
 Tue, 31 Oct 2023 00:35:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 31 Oct 2023 00:35:41 +0000 (GMT)
Message-ID: <8497cf62-a360-4883-abc0-f6023b1c99b0@linux.ibm.com>
Date: Mon, 30 Oct 2023 20:35:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/14] tests: acpi: updated expected blobs for TPM CRB
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20231029060404.71196-1-j@getutm.app>
 <20231029060404.71196-14-j@getutm.app>
 <b2828199-610a-4b2e-8964-92513e1872e0@linux.ibm.com>
In-Reply-To: <b2828199-610a-4b2e-8964-92513e1872e0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZpisNsQkhc0s64Wtl5XWsVMDMtPZeAS2
X-Proofpoint-ORIG-GUID: 8j0qn-K4KbmqDvl5xjR8L_25VVk0IDwN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310003
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 10/30/23 18:42, Stefan Berger wrote:
>
> On 10/29/23 02:03, Joelle van Dyne wrote:
>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>
> I see this error here with the test cases:
>
>
> | 364/377 ERROR:../tests/qtest/bios-tables-test.c:535:test_acpi_asl: 
> assertion failed: (all_tables_match) ERROR
> 364/377 qemu:qtest+qtest-x86_64 / 
> qtest-x86_64/bios-tables-test                     ERROR 34.83s killed 
> by signal 6 SIGABRT
> >>> QTEST_QEMU_BINARY=./qemu-system-x86_64 MALLOC_PERTURB_=200 
> QTEST_QEMU_IMG=./qemu-img 
> G_TEST_DBUS_DAEMON=/home/stefanb/qemu-tpm/tests/dbus-vmstate-daemon.sh 
> QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon 
> PYTHON=/home/stefanb/qemu-tpm/build/pyvenv/bin/python3 
> /home/stefanb/qemu-tpm/build/tests/qtest/bios-tables-test --tap -k
> --------------------------------------------------------------- 8< 
> ---------------------------------------------------------------
>
> $ diff tests/data/acpi/virt/TPM2.crb-device.dsl /tmp/aml-98C6D2.dsl
> 6c6
> <  * Disassembly of tests/data/acpi/virt/TPM2.crb-device.tpm2, Mon Oct 
> 30 18:30:00 2023
> ---
> >  * Disassembly of /tmp/aml-98C6D2, Mon Oct 30 18:29:29 2023
> 16c16
> < [009h 0009   1]                     Checksum : BA
> ---
> > [009h 0009   1]                     Checksum : C2
> 30c30
> < [044h 0068   8]                  Log Address : 0000000043D10000
> ---
> > [044h 0068   8]                  Log Address : 0000000043C90000
>
> The diff is in the address of the TPM log ... Not good. I don't know 
> how we could have it ignore the address or not build the TPM2 table 
> with an address for a log. It would be good to have test cases.
>
>    Stefan


The log that the TPM2 ACPI table points to is needed for a BIOS, UEFI 
does not need it (but we don't typically know whether BIOS or UEFI will 
run). So we could introduce a property no-acpi-log and have the test 
cases set this to 'on' and get a NULL pointer for the 'Log Address'. You 
could use the following in a patch:


diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index acc654382e..2b2de34201 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2224,6 +2224,7 @@ void build_tpm2(GArray *table_data, BIOSLinker 
*linker, GArray *tcpalog,
      uint32_t start_method;
      AcpiTable table = { .sig = "TPM2", .rev = 4,
                          .oem_id = oem_id, .oem_table_id = oem_table_id };
+    bool acpi_log = true;

      acpi_table_begin(&table, table_data);

@@ -2238,6 +2239,7 @@ void build_tpm2(GArray *table_data, BIOSLinker 
*linker, GArray *tcpalog,
          control_area_start_address = TPM_CRB_ADDR_CTRL;
          start_method = TPM2_START_METHOD_CRB;
      } else if (TPM_IS_CRB_SYSBUS(tpmif)) {
+        acpi_log = !object_property_get_bool(OBJECT(tpmif), 
"no-acpi-log", NULL);
          baseaddr = object_property_get_uint(OBJECT(tpmif), 
"x-baseaddr", NULL);
          control_area_start_address = baseaddr + A_CRB_CTRL_REQ;
          start_method = TPM2_START_METHOD_CRB;
@@ -2253,20 +2255,25 @@ void build_tpm2(GArray *table_data, BIOSLinker 
*linker, GArray *tcpalog,
      g_array_append_vals(table_data, &start_method_params,
                          ARRAY_SIZE(start_method_params));

-    /* Log Area Minimum Length */
-    build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE, 4);
+    if (acpi_log) {
+        /* Log Area Minimum Length */
+        build_append_int_noprefix(table_data, 
TPM_LOG_AREA_MINIMUM_SIZE, 4);

-    acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
-    bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
-                             false);
+        acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
+        bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, 
tcpalog, 1,
+                                 false);

-    log_addr_offset = table_data->len;
+        log_addr_offset = table_data->len;

-    /* Log Area Start Address to be filled by Guest linker */
-    build_append_int_noprefix(table_data, 0, 8);
-    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
-                                   log_addr_offset, 8,
-                                   ACPI_BUILD_TPMLOG_FILE, 0);
+        /* Log Area Start Address to be filled by Guest linker */
+        build_append_int_noprefix(table_data, 0, 8);
+        bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
+                                       log_addr_offset, 8,
+                                       ACPI_BUILD_TPMLOG_FILE, 0);
+    } else {
+        build_append_int_noprefix(table_data, 0, 4);
+        build_append_int_noprefix(table_data, 0, 8);
+    }
      acpi_table_end(linker, &table);
  }
  #endif
diff --git a/hw/tpm/tpm_crb_sysbus.c b/hw/tpm/tpm_crb_sysbus.c
index c10a8b5639..aeeaba512b 100644
--- a/hw/tpm/tpm_crb_sysbus.c
+++ b/hw/tpm/tpm_crb_sysbus.c
@@ -35,6 +35,7 @@ struct TPMCRBStateSysBus {
      TPMCRBState state;
      uint64_t baseaddr;
      uint64_t size;
+    bool no_acpi_log;
  };

  OBJECT_DECLARE_SIMPLE_TYPE(TPMCRBStateSysBus, TPM_CRB_SYSBUS)
@@ -74,6 +75,8 @@ static Property tpm_crb_sysbus_properties[] = {
                         baseaddr, TPM_CRB_ADDR_BASE),
      DEFINE_PROP_UINT64("x-size", TPMCRBStateSysBus,
                         size, TPM_CRB_ADDR_SIZE),
+    DEFINE_PROP_BOOL("no-acpi-log", TPMCRBStateSysBus,
+                     no_acpi_log, FALSE),
      DEFINE_PROP_END_OF_LIST(),
  };

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index dea2a18158..9e8a02f924 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1400,7 +1400,7 @@ static void test_acpi_tcg_tpm(const char *machine, 
const char *tpm_if,
          " %s"
          " -chardev socket,id=chr,path=%s"
          " -tpmdev emulator,id=dev,chardev=chr"
-        " -device tpm-%s,tpmdev=dev",
+        " -device tpm-%s,tpmdev=dev,no-acpi-log=on",
          g_strcmp0(machine, "virt") == 0 ? "-cpu cortex-a57" : "",
          test.addr->u.q_unix.path, tpm_if);



