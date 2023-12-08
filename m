Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 588A180A547
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 15:19:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBbgE-0005sk-S4; Fri, 08 Dec 2023 09:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1rBUGX-0007ug-Kj
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 01:23:13 -0500
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1rBUGR-0000oM-91
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 01:23:13 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231208062303epoutp0450b910a17627a0f8be3cdae0377a4a08~exxCqSt8t2409024090epoutp04P
 for <qemu-devel@nongnu.org>; Fri,  8 Dec 2023 06:23:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231208062303epoutp0450b910a17627a0f8be3cdae0377a4a08~exxCqSt8t2409024090epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1702016583;
 bh=/VizRhPWdnwEHZarvVnucnLBlD129cCfPeJvOcB7GSg=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=WoCGe6H2MlUbRHy0N939vHSaf/H/uOn1jlfSj8AjF9J8TcD8mMTENDgLhPCu+amlD
 E5lS3GYMQ0oDiqNaPjDPBaOwb62K93U4gnRpNSUXIzOQu4URBnwX5JQnQGHcjWmKu4
 9SFyHj5PdreTbFda7VjPKV+6yDHJeXmZmfzdz3AU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20231208062303epcas2p1713f4c6e37e394d013eea66e477cbec2~exxCIdft31119911199epcas2p1w;
 Fri,  8 Dec 2023 06:23:03 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.70]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4Smh061bRfz4x9QD; Fri,  8 Dec
 2023 06:23:02 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-33-6572b646bdba
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 94.E6.09607.646B2756; Fri,  8 Dec 2023 15:23:02 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 3/3] tests/qtest: Add tests for Zoned UFS
From: Daejun Park <daejun7.park@samsung.com>
To: "thuth@redhat.com" <thuth@redhat.com>, "lvivier@redhat.com"
 <lvivier@redhat.com>, Jeuk Kim <jeuk20.kim@samsung.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Daejun Park <daejun7.park@samsung.com>
CC: Seokhwan Kim <sukka.kim@samsung.com>, Yonggil Song
 <yonggil.song@samsung.com>, JinHwan Park <jh.i.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p3>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231208062200epcms2p7de0f3ab428a85eff0280225dbd1b1f37@epcms2p7>
Date: Fri, 08 Dec 2023 15:22:00 +0900
X-CMS-MailID: 20231208062200epcms2p7de0f3ab428a85eff0280225dbd1b1f37
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdljTVNdtW1GqwdHfHBYvD2larHoQbnF/
 6zVGi/5/7SwWnxqkLPZv+8dqcbx3B4vFqo65jBYrj9lYTD1/hMmBy+PJtc1MHu/3XWXz6Nuy
 ijGAOSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfo
 ECWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEp
 UGFCdsaKL//YClY6VKxdeoutgfGBfhcjJ4eEgInErbdnmbsYuTiEBHYwStxdu5Cxi5GDg1dA
 UOLvDmGQGmEBS4kZU4+xgthCAkoS6y/OYoeI60nceriGEcRmE9CRmH7iPjvIHBGBZiaJ+63X
 mUESzAKVEscu3GSEWMYrMaP9KQuELS2xfflWsDingJ/Ekp8TmSDiGhI/lvUyQ9iiEjdXv2WH
 sd8fmw81R0Si9d5ZqBpBiQc/d0PFJSVuz90EVZ8v8f/Kcii7RmLbgXlQtr7EtY6NYDfwCvhK
 XHp8Fmwvi4CqxM1LX9lBfpcQcJE40sADcb68xPa3c5hBwswCmhLrd+lDVChLHLnFAlHBJ9Fx
 +C87zIMNG39jZe+Y9wTqQTWJdT/XM01gVJ6FCOdZSHbNQti1gJF5FaNYakFxbnpqsVGBCTxq
 k/NzNzGCU6SWxw7G2W8/6B1iZOJgPMQowcGsJMKbcz4/VYg3JbGyKrUoP76oNCe1+BCjKdCT
 E5mlRJPzgUk6ryTe0MTSwMTMzNDcyNTAXEmc917r3BQhgfTEktTs1NSC1CKYPiYOTqkGpuov
 J+8Gf53qqv2EP2Wava/M0hkNC+3/XY+sn7JNdxKf1NTdVyKqLsxwyzhj2P1AcvmXTzwiq1Z1
 fg1b1Bl6IHR7R+TFsvXrdnyODF5rfUb8PveMOqsFBaaJ6VbpS7IEpm74tTnF2rE/dqOy8S7X
 5I0vWwsPPJSPZ8+d5pkvoaHi/zBxioqE/eN69lXtl56a3qrpWdjOG7RTqvSgq5XLRYFde5kS
 tmy8df773KCg5wtfTV94u1/TyEzn5svXeefe+a7x6XtW/ebszfANktdyJf7Pmfp2fdfv91IM
 7bOCclk3vNR6/f331qz6HVXv1HksNrUHZSuWZBv7rtS39d2qHrjviG81y02Dx91OgqVM95VY
 ijMSDbWYi4oTAVut9hsaBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba
References: <20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p3>
 <CGME20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p7>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=daejun7.park@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 08 Dec 2023 09:17:31 -0500
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
Reply-To: daejun7.park@samsung.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This patch includes the following tests
  Test VPD page and report zones
  Test write and unaligned write error

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 tests/qtest/ufs-test.c | 178 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 5daf8c9c49..798035f45b 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -27,6 +27,11 @@
 #define UTP_RESPONSE_UPIU_OFFSET 1024
 #define UTP_PRDT_UPIU_OFFSET 2048
 
+#define ZONE_SIZE (2 * 1024 * 1024)
+#define MAX_OPEN_ZONE 6
+#define NUM_ZONES (TEST_IMAGE_SIZE / ZONE_SIZE)
+#define REPORT_ZONES_DESC_HD_SIZE 64
+
 typedef struct QUfs QUfs;
 
 struct QUfs {
@@ -534,6 +539,160 @@ static void ufstest_read_write(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_zufs_init(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    const int test_lun = 2;
+
+    uint8_t buf[4096] = { 0 };
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
+        REQUEST_SENSE,
+        0x01,
+        0x00,
+        0x00,
+    };
+    /* VPD 0x00 page */
+    const uint8_t inquiry_vpd_00_cdb[UFS_CDB_SIZE] = {
+        INQUIRY,
+        0x01, /* EVPD */
+        0x00, /* page code */
+        0x00, 0x40, /* length */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+    };
+    /* VPD 0xb6 page */
+    const uint8_t inquiry_vpd_b6_cdb[UFS_CDB_SIZE] = {
+        INQUIRY, 0x01, /* EVPD */
+        0xb6, /* page code */
+        0x00, 0x40, /* length */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+    };
+    /* Report zones */
+    const uint8_t report_zones_cdb[UFS_CDB_SIZE] = {
+        ZBC_IN, ZI_REPORT_ZONES,
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* LBA */
+        0x00, 0x00, 0x02, 0x00, /* length */
+        0x00, 0x00
+    };
+    UtpTransferReqDesc utrd;
+    UtpUpiuRsp rsp_upiu;
+    uint32_t zone_list_len;
+
+    ufs_init(ufs, alloc);
+
+    /* Clear Unit Attention */
+    ufs_send_scsi_command(ufs, 0, test_lun, request_sense_cdb, NULL, 0, buf,
+                          sizeof(buf), &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+
+    /* Inquiry VPD page: 0x00 */
+    ufs_send_scsi_command(ufs, 0, test_lun, inquiry_vpd_00_cdb, NULL, 0, buf,
+                          sizeof(buf), &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
+                     UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(buf[0], ==, TYPE_ZBC);
+    g_assert_cmpuint(buf[7], ==, 0xb6);
+
+    /* Inquiry VPD page: 0xb6 */
+    ufs_send_scsi_command(ufs, 0, test_lun, inquiry_vpd_b6_cdb, NULL, 0, buf,
+                          sizeof(buf), &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
+                     UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(buf[0], ==, TYPE_ZBC);
+    /* ZBC device characteristics */
+    g_assert_cmpuint(buf[1], ==, 0xb6);
+    /* Number of max open zones */
+    g_assert_cmpuint(buf[19], ==, MAX_OPEN_ZONE);
+
+    /* Report zones */
+    ufs_send_scsi_command(ufs, 0, test_lun, report_zones_cdb, NULL, 0, buf,
+                          sizeof(buf), &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
+                     UFS_COMMAND_RESULT_SUCCESS);
+    zone_list_len = ldl_be_p(&buf[0]);
+    g_assert_cmpuint(zone_list_len, ==, REPORT_ZONES_DESC_HD_SIZE * NUM_ZONES);
+
+    ufs_exit(ufs, alloc);
+}
+
+static void ufstest_zufs_write(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint8_t read_buf[4096] = { 0 };
+    uint8_t write_buf[4096] = { 0 };
+    const uint8_t read_capacity_cdb[UFS_CDB_SIZE] = {
+        /* allocation length 4096 */
+        SERVICE_ACTION_IN_16,
+        SAI_READ_CAPACITY_16,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x10,
+        0x00,
+        0x00,
+        0x00
+    };
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
+        REQUEST_SENSE,
+    };
+    const uint8_t write_cdb[UFS_CDB_SIZE] = {
+        /* WRITE(16) to LBA 0, transfer length 1 */
+        WRITE_16, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        0x00,     0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00
+    };
+    uint32_t block_size;
+    UtpTransferReqDesc utrd;
+    UtpUpiuRsp rsp_upiu;
+    const int test_lun = 2;
+
+    ufs_init(ufs, alloc);
+
+    /* Clear Unit Attention */
+    ufs_send_scsi_command(ufs, 0, test_lun, request_sense_cdb, NULL, 0,
+                          read_buf, sizeof(read_buf), &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+
+    /* Read capacity */
+    ufs_send_scsi_command(ufs, 0, test_lun, read_capacity_cdb, NULL, 0,
+                          read_buf, sizeof(read_buf), &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
+                     UFS_COMMAND_RESULT_SUCCESS);
+    block_size = ldl_be_p(&read_buf[8]);
+    g_assert_cmpuint(block_size, ==, 4096);
+
+    /* Write data */
+    memset(write_buf, 0xab, block_size);
+    ufs_send_scsi_command(ufs, 0, test_lun, write_cdb, write_buf, block_size,
+                          NULL, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
+                     UFS_COMMAND_RESULT_SUCCESS);
+
+    /* Unaligned write error */
+    ufs_send_scsi_command(ufs, 0, test_lun, write_cdb, write_buf, block_size,
+                          NULL, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+    /* asc == 0x21 */
+    g_assert_cmpint(rsp_upiu.sr.sense_data[12], ==, 0x21);
+    /* ascq == 0x04 */
+    g_assert_cmpint(rsp_upiu.sr.sense_data[13], ==, 0x04);
+
+    ufs_exit(ufs, alloc);
+}
+
 static void drive_destroy(void *path)
 {
     unlink(path);
@@ -569,6 +728,19 @@ static void *ufs_blk_test_setup(GString *cmd_line, void *arg)
     return arg;
 }
 
+static void *ufs_zufs_test_setup(GString *cmd_line, void *arg)
+{
+    char *tmp_path = drive_create();
+
+    g_string_append_printf(cmd_line,
+                           " -blockdev file,filename=%s,node-name=drv2 "
+                           "-device ufs-lu,bus=ufs0,drive=drv2,lun=2,"
+                           "zoned=on,zoned.max_open=%d,zoned.zone_size=%d",
+                           tmp_path, MAX_OPEN_ZONE, ZONE_SIZE);
+
+    return arg;
+}
+
 static void ufs_register_nodes(void)
 {
     const char *arch;
@@ -582,6 +754,10 @@ static void ufs_register_nodes(void)
         .before = ufs_blk_test_setup,
     };
 
+    QOSGraphTestOptions zufs_io_test_opts = {
+        .before = ufs_zufs_test_setup,
+    };
+
     add_qpci_address(&edge_opts, &(QPCIAddress){ .devfn = QPCI_DEVFN(4, 0) });
 
     qos_node_create_driver("ufs", ufs_create);
@@ -601,6 +777,8 @@ static void ufs_register_nodes(void)
     }
     qos_add_test("init", "ufs", ufstest_init, NULL);
     qos_add_test("read-write", "ufs", ufstest_read_write, &io_test_opts);
+    qos_add_test("zufs-init", "ufs", ufstest_zufs_init, &zufs_io_test_opts);
+    qos_add_test("zufs-write", "ufs", ufstest_zufs_write, &zufs_io_test_opts);
 }
 
 libqos_init(ufs_register_nodes);
-- 
2.25.1


