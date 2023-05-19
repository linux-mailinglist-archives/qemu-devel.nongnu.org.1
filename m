Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32988709401
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:47:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwhE-0000E1-SC; Fri, 19 May 2023 05:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwh8-0000CC-W0
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:45 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwh7-0008Sw-2W
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:42 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34J923xu028216; Fri, 19 May 2023 02:46:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=WZHyegdihqSgcUIZLMoRoLOBn351tr/V+Ov5iI36Abk=;
 b=fmxolm1be8F8VItX90FH9ZaF3EX+p9A7CkqIvdRzVJGDzMEryo6IQQmvbfaXEWJtGyaq
 RbPzhJYi9rwuwpINZWboJQsbsD709wp/LpJkllNAtXLEv9hnFs6uQ+jjEEKnSaZEn79D
 yQQi738DIXW1oYDupX+6UbqtY65LH/bGR94GR+KqgEcnDU3I9BwxQ7s+aI2LEKOM3sx3
 duamwOEjqvj5oBH71tDrVLVQaDWtsK2wTyD18q/vcF7J5t+7UQNXTlwU2cewgMRXO7KH
 q+0GKNFBSvGSzMmZ1ROIcMfh5Ft7yFjoDRpcoGSOuZ/D0zdJrbZyxxC5HzaXmZbwJaDm lQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qmw97vjcb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 May 2023 02:46:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhzrO30CA077J2tQasV1zoBnYjLrjjaWkPWJZCxlMOI3VOBhbzyME9UAyDm9VkSvo3l49wH9pOzdp1G1DBxFSFACLxlzZi4eMZMc+3Zydfe48zXf9cnLvUDWEdR0YG2vffQsOSrDR597Km98WqJq0HxFQ61QBdegMlAgNnlHIGr9bOzSjQHLIvESB3NtAeXGmeWAQWPVUhf9N6GKjayEcd6RfK2MZDZOyntmxd8krp757b1XDlzkjHsC4OdiHBo5ZLU5ybV8rHLnybWOGKl7lJ7jHJnRR0la2SyM4XfuSQcTSEaLYK16OTbl4NmiPeBCoCUac3wB4UQR6r8OpFpC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZHyegdihqSgcUIZLMoRoLOBn351tr/V+Ov5iI36Abk=;
 b=LzHumy4oJ7UikdiuOVCCitWw6CSHE3cEHMSLzDTzMs5XzPU+g0/DHdprMEC/+TxwTD/cTqhvhTxS+2MXJPdoWny17w2XuGZ4PeoR24V1jeqov163fuS4VXNtAlsaWhxz5IiH6b98RU2Dc9ITU6+l+93mS3PfGAuGxKTxwV1P+7FWdjzmZ/DISRS3tU9xuYsvxLCdnQTfOwRE1c9RNMNXvsYDIrPbnwDzjzBObZ7w2MKYbW0DamH2ei6RhDSKVRWy25YFoWO9byfdUVUX+1A4nL/+syAw9EGpfNrytM5Ok1tTOYsMYDs52fAflLdYgjcMocIE93r4sHA3R6KhxJ5kqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZHyegdihqSgcUIZLMoRoLOBn351tr/V+Ov5iI36Abk=;
 b=PfLu0zI9v+Gaa4yUus/AG2qkxcNOboDP+37/0tQ4Qkd8ZAxkeSuVE1xpfAaIzibdC2njEmVUM5Zpa2p7V7euKMramj3LxAlgA6t3kXGaQwU6UfugPQvfzjedv/WHXNFwWkJVooEHHe3qU8GX5LSoDLscWU6ySkzt9FoHAamRH4xg7SIjC5YsZlXqkSTiE6ZJVWMz3haT50sBFd7AlHsoWDay6zKsPXpaXnhV0Z8j3vTsZlLhgjARDEnJJOjOC/KdSacbWf2ldvLjGZEnCx2bCYjerVXtIVpuS4KgvznDtJRjvPCVw4ws6ig6kvLSh9XG0JBte1BwjBDIZHRsh5mmsw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DM8PR02MB7912.namprd02.prod.outlook.com (2603:10b6:8:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:46:37 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 09:46:37 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 9/9] migration: adding test case for modified QAPI syntax
Date: Fri, 19 May 2023 09:46:17 +0000
Message-Id: <20230519094617.7078-10-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230519094617.7078-1-het.gala@nutanix.com>
References: <20230519094617.7078-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:180::44) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|DM8PR02MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd5267f-ee89-4328-a571-08db584df084
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KocDfK2IEK997sMX/SXRYDIhzKrDNOjfo3AdObNyYSs1HNpwB8kzQzZqdIrzxOdrQ1L7bhcpPBGLlwj7YBzxihwnde/3jPyB+qIXCT9VzTaU0GZ3CBYGjJ9WRACCyN2qpEpDENasslGm439vIZyXDrHu9y6cQZKc3TN21r33mNjJ0x4+11ig/2zYigIfKcfYprPXCsoG7tYuVkc5V/GpBYVupiNdXtwMdyc1tW5YfcQH0n7yaWJLKd3/xxGYFRDa3yiYugyf9EL/Fh5xVQfLWo2RsPgws8+zmUcIBnYqsoADvwvAJYazOWbGoWMTpgHOCga5IE/vpqkVNIOh1RZuYLOGQ4jtflgTUf5YxmxjnnC+kE5YFzlW3hVF+nsUXmFO//e3q/iqvr2wrQXZRZAQPIUcgVfycd4P5Yi6XsbPjvOwG9HSMJI3+rdXZ4sCcf76f+90cvapdOdykijn26qvfLQ+WvYS3F1Hmq8SQ6CorobuyaYrEv0VPAtK+7Te0mqqm2XASD4MvFay8nbaPLpnD4CtwiP1/07WtF9RqEldbnVmTiAtBPtfLNBhBzb1FH+oTpHcF9dYUto1JvLN3nZblrEAfPSjHBFBsBEoQ7p4Bkfm20AXM4tmtCQsT99t9F0o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(36756003)(44832011)(8676002)(8936002)(5660300002)(316002)(41300700001)(66476007)(38350700002)(4326008)(38100700002)(6916009)(86362001)(66556008)(66946007)(107886003)(6512007)(6506007)(1076003)(26005)(2906002)(186003)(52116002)(6486002)(478600001)(6666004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YxQhU8bgGE13T/Jlf99tLcGIE1XzX1heq4rt/KhJRUMHPPQ4eCEdsGnUJ6te?=
 =?us-ascii?Q?IglcJXpRRUsbK0cA7KW2/e/+EurNPJgOWgsr2IRn8Xz0TtI6JmQt611uXXAR?=
 =?us-ascii?Q?Ko0tUQsi3wAvFiyYDf0Q50n1cFRt2HKkc51YOsJzBsE0qAPwsBFpRO9Ezla8?=
 =?us-ascii?Q?fUaRY5fKvYayZiy0Ro03CybtvTClvXJtlXtPlR2lhYuz7fjRe1UP5ZW/D2H+?=
 =?us-ascii?Q?QmZA0TRor5Y/Bw25AVpsiELGYWNT0dqhkrZcA57xBs9M6VU1J7UuKIEkt0C1?=
 =?us-ascii?Q?XhQ+/wZLrFLyoFAo+m9SN78sSotWeDM3bYHkPeymM9kb5+UIpAmzuhQ2ENL6?=
 =?us-ascii?Q?lGQt9dAhscy1GetjqLncNraVQHHbfd4hcRC6qizX52DdlQVNO4pQVG6cRmI9?=
 =?us-ascii?Q?ieTeBRBjR/Ifx+q9jtRn1sAW21bPOxIMypFNfn4zHNQXDfJcIRTx956y/IqD?=
 =?us-ascii?Q?bSMI7sR10a+OvjPv8Dyqi1lpoDAJz55l+RMpJXw0s1jwtTBwGcJDGr5kq/Kl?=
 =?us-ascii?Q?R5CT0qnLohgtU3BMcEXGefjVZ4CTOJDhafP/fx+ZAouXYSyqYtJKBWBbDXdT?=
 =?us-ascii?Q?1HOS4VRa6nQDR4LEVMny/fN1xdWuXtnjUypt1vASXrMCrJaR/IrE14ig6umx?=
 =?us-ascii?Q?Lw+WJt5r2RCv5zd53thvrIcoPF3HrJ1atkPvZwV19T+p2oRG9G2Mv8SAjLxN?=
 =?us-ascii?Q?IODqmEQlmYb6hv9NiCrCy748WO9hwRssDaLneKRRv5CgmP6RA7NemA3YAhd+?=
 =?us-ascii?Q?QXMMN/NsiwBl/RZ+t3GMW+nc0EduLGr6a0RhQEtHr3sTTSORvHr7tVHI9uiw?=
 =?us-ascii?Q?7jCgtOBDlqlR3wGKbv8sgnhFVuP3QMEcbHvWhdbnQQwyDdCee5j+2ke17r+u?=
 =?us-ascii?Q?0U0KIJ7u3Scbhih7issKJzS9qbflprQvv2eLFUZp+LQBhlBZC4A6fINeO743?=
 =?us-ascii?Q?7nkyTNPoSytmYU5WohcbRo6vemU787H3D6uokYWAq7V9OEe3rW3cnwr4ukE+?=
 =?us-ascii?Q?DHXAIxHcJy6sFogb4Le9siLG6/qH4+L4unTfSlZbhXmbZHWeyrXmrN+eefa5?=
 =?us-ascii?Q?Wdtl+vT4xuJ392sOeWcpWkzYqANzN8fWZ72hu6hQLtKkqJ3orYqZ1n/A8vWU?=
 =?us-ascii?Q?SMbT5ngUKwPQcQeOhfpQB99neMexLqjblSA/7yV7FrdTgi1BODP7MovFxYAJ?=
 =?us-ascii?Q?u8QrITLtkL1OElOLtROBDHoltASW6oODyoThhZPJCc6Mz5EOcoN5yPKOC+vC?=
 =?us-ascii?Q?4gdwc/LafijwmL9fxDaUBhg02uV7KZIA8AX2EEdYyyKNj4NsPVuQraMq8HKt?=
 =?us-ascii?Q?Vu3Q4dbDHGm30AW52DmeLsM1X+SkmoOJ5Tl788Ni9EVIxjmmVpUkiOf9Phfo?=
 =?us-ascii?Q?d/UqLowWVas+0UzykBKgumWxsDVhn1EkJyCzPEZ6W0iVDLORJrtksU9LMQu9?=
 =?us-ascii?Q?v1k1vURNkw6b6hRZEPukavTMwCsEC4OMuK0GOZyOIyQnGRw16OG8KRnHKeCM?=
 =?us-ascii?Q?3tLB0TIUvdBXv+JW7Q7q4LxErvgR686T6Y9o3mJy2ILWKHfe9Oe/CRc+1IfG?=
 =?us-ascii?Q?gIIlIS8+4z+tnfAnM5hgyms2m8O3WsKN4OgBlGPo?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd5267f-ee89-4328-a571-08db584df084
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:46:37.6592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxm07RBvXNA4R4nSfgkT57JUBOdThOS6TUgSfryGeJ+iXO9r0zArEAPQEqHd0+SwCqVjh93XctfD4tqXTPaGvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7912
X-Proofpoint-GUID: 8z35C9Ypm94aPirWXa3Y4bLYPhtHBScq
X-Proofpoint-ORIG-GUID: 8z35C9Ypm94aPirWXa3Y4bLYPhtHBScq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Adding multifd tcp common test case for modified QAPI syntax defined.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-test.c | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b99b49a314..ef6f9181da 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2021,6 +2021,34 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
     return NULL;
 }
 
+static void *
+test_migrate_precopy_tcp_multifd_start_new_syntax_common(QTestState *from,
+                                                         QTestState *to,
+                                                         const char *method)
+{
+    QDict *rsp;
+
+    migrate_set_parameter_int(from, "multifd-channels", 16);
+    migrate_set_parameter_int(to, "multifd-channels", 16);
+
+    migrate_set_parameter_str(from, "multifd-compression", method);
+    migrate_set_parameter_str(to, "multifd-compression", method);
+
+    migrate_set_capability(from, "multifd", true);
+    migrate_set_capability(to, "multifd", true);
+
+    /* Start incoming migration from the 1st socket */
+    rsp = wait_command(to, "{ 'execute': 'migrate-incoming',"
+                           "  'arguments': { "
+                           "    'channels': [ { 'channeltype': 'main',"
+                           "     'addr': { 'transport': 'socket',"
+                           "               'type': 'inet','host': '127.0.0.1',"
+                           "               'port': '0' } } ] } }");
+    qobject_unref(rsp);
+
+    return NULL;
+}
+
 static void *
 test_migrate_precopy_tcp_multifd_start(QTestState *from,
                                        QTestState *to)
@@ -2028,6 +2056,14 @@ test_migrate_precopy_tcp_multifd_start(QTestState *from,
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
 }
 
+static void *
+test_migrate_precopy_tcp_multifd_new_syntax_start(QTestState *from,
+                                                  QTestState *to)
+{
+    return test_migrate_precopy_tcp_multifd_start_new_syntax_common(from,
+                                                              to, "none");
+}
+
 static void *
 test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
                                             QTestState *to)
@@ -2053,6 +2089,15 @@ static void test_multifd_tcp_none(void)
     test_precopy_common(&args);
 }
 
+static void test_multifd_tcp_new_syntax_none(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_new_syntax_start,
+    };
+    test_precopy_common(&args);
+}
+
 static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
@@ -2736,6 +2781,8 @@ int main(int argc, char **argv)
     }
     qtest_add_func("/migration/multifd/tcp/plain/none",
                    test_multifd_tcp_none);
+    qtest_add_func("/migration/multifd/tcp/plain/none",
+                   test_multifd_tcp_new_syntax_none);
     /*
      * This test is flaky and sometimes fails in CI and otherwise:
      * don't run unless user opts in via environment variable.
-- 
2.22.3


