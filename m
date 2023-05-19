Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB39709406
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:48:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwh2-0000AN-Px; Fri, 19 May 2023 05:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwgx-00009H-KB
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:32 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwgu-0008RH-Sg
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:30 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34J5ECPH005134; Fri, 19 May 2023 02:46:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=PWv0dLSW9skaAjax9Lvcd+8+cGRLygn4rK/llLhQdJQ=;
 b=e3XoJU049PEQigJlbYfBBHzHaAxc5pizBaMUCHwHPMJdgx30xZbHWZYOmxg8ZY3Koznb
 xXv2e0+c0KqRlTj0rwzoKnXDotcE4YDDnOY/gRQn9eR/DDuCD2Xrc2RtOUThQvwN815F
 AcpYvS6AcM7VQA316c83uwsMFAbUwlZ6eHrfxr/7ZSBGiLsDoCrlfUF06gOpmRo4zXwD
 QcK2QG0H5gcpBRRLfMsJTsQUp3vGjhObvPUE9mhesTqWh7LffpbkXozL64d42L89TUl5
 8nNhVzCeDZBFEEVcJNQsYGtY/CNeZYk/5JHPUSOOje9CYRzoo1ctmfML9EeVAiBvvwE3 WA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qmw0vda29-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 May 2023 02:46:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuJ4tiHAjAPSdy7MIOTm7fyexd9Y4dwf071ghQSlDp9Z+bavQ+U5Ufy/JibWqG0S+KaAboDcNrmBbFLCGDHXA1jE68MifHLqHz4UHTLdokB6IwVNPaaGQmQjCBZqmpAnUC02WUkyVtUDTvyK0raf/lv1pG5TES22TYGous6MWLe5dTIFRk0oNNlIzq0obhHfMz5JpXHz1JNWMy6SBJO8FcdgDGk3NUbSk/dAtOvQFy1z9gYbnoE+v9K7o182fagToPYCc5Mt5e8t97G+GhNxYHFWE5SzzllwHWsxrqBa2P69tfiFKa4qc01okP8XOJysLJJS0uGBjVMtEh79m/6r4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWv0dLSW9skaAjax9Lvcd+8+cGRLygn4rK/llLhQdJQ=;
 b=Y7xg3ew4hBrOb6I0b0EET6pavhHrsjSpLbFP5x/Jxlpbv+JYeMit5RnkxxqQ9S9+xmqlEKCeXwHTFLp/Y+b7CUjfOBuFYGgpJFG1xJ+5xSwhI+enu6lk+8Op2ZXbDyQEICIHW5psmQoiA9DlbIZoY7V0amwfeBdV7Cy6vee52TrQcvDQBGpZMPDggexUwtfeJuPwow0aa08Mh5PKl+rZkttwRwchEDfS7pec5hpx2QO3sBBQdWkaZuKcrSn1+wl8alHQM2Shw7W+c5STVkKupuuqes4TMWQ3VO+Se3UKZJzZ529gJP0bzHqGHXYJdrGBt+n5k8+Tv84FGnX0AiqAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWv0dLSW9skaAjax9Lvcd+8+cGRLygn4rK/llLhQdJQ=;
 b=RQhOxibmIPJnXjlaWYNuw0mPXTrjlgRn9Yhf/qCGFlO+FYpAx/wxiOu/FeGthJsMaCo+j+EsGkz4f62lwPxcAT2U3LiwZZ6YtNGS4mwwufVO7CA3mZzkAFz/lbXYaK4zoz4lW9Tec0LAxmcXUH7+YUrTyFLnrKM480izKrqsnBzc4WiX2K33GF2HyRGIsX5NOdgMX9hRsolm4+dgPafJSNzMVdqOEbUj/m2lcFoa8T7EO0GCDdwU3+c6YZ3SYNU6LVh7rnBFTi/WeCCNCN39/PpKuE2gqmuVuosyB8fDPqEobWCQgdkhk4XEEFAri4ZbQiCO/59lBuL1iDao9zdOYw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DM8PR02MB7912.namprd02.prod.outlook.com (2603:10b6:8:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:46:24 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 09:46:24 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 1/9] migration: introduced 'MigrateAddress' in QAPI for
 migration wire protocol.
Date: Fri, 19 May 2023 09:46:09 +0000
Message-Id: <20230519094617.7078-2-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230519094617.7078-1-het.gala@nutanix.com>
References: <20230519094617.7078-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:180::44) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|DM8PR02MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 8350c28a-3208-4189-7a15-08db584de895
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x363LYGamy/23Pib6JotCCGvEKECBgOB4Ah8HPLx7Fuw1F5CIpDgVXjDWE6xAqIwfAmTCJ5COODhb/d5An+kZ7WyUpYvC/7Jx8f9dpmaPpoV2fgU5iJITv7+ebLbNfHDcNvK6wPag3k8DETCQCiMfe58rWysJeTdLN5lDi1KSUx5kGKai8VQDEWdwZMKxJ+ha1szy6CgMEJmXsPP+veAIVbSCl1+MPbGbKqSj5tcLtWyyB6z32M68u2LK6QPAwcsVL2XFBfSct4ps0h703xp+7jmaKR+WGMWvDgXNEbkBPvH9NpbAdERW//x452hzlVSYO6+CYaREeCZNmrIi0LO6JwvlqjY+auyH8RMdvEezJZgCj41dDhK2Q7M/DKMjIJFxrRhbFzSOkyUkDkxZfXD9QC1RBCZ5Zefw0dn3mwTSI1BVCyzZRIVksMZ4PN1n/YAqIpFkP/3lLVuMvvzkmi0KHp0tTyGG7tGnbeWZpQRgaFz66sG7LEEb1m8+TIMI0oYzXHDOxHPFOGexGwJQ4X3M4eW4MUdq/Iqgh8IART3JQISWNQYeajS40BGXo++rbc7P1D/qk3+RjPcOYlAiy9fk6m+QfR0w9P3gLQ+69u6waqyrQjHZbS/Agcn7KRkaGEQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(66899021)(36756003)(44832011)(8676002)(8936002)(5660300002)(316002)(41300700001)(66476007)(38350700002)(4326008)(38100700002)(6916009)(86362001)(66556008)(66946007)(107886003)(6512007)(6506007)(1076003)(26005)(2906002)(186003)(52116002)(6486002)(478600001)(6666004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2lCZ3ZleStkUHAvY043eVFMOVllUERwdEV2OFB2d0pIa2xxK01Ibm4xL3dU?=
 =?utf-8?B?TFU0TU5uNkNRTzZKd2ZabFJmRjZ2dkNjcmRDU21lWmkxMDgxSGJLK2pla0hD?=
 =?utf-8?B?UGUwMEpKY0g0Z3FlaUREUmlIMGpBSHVvbVdUaE5hTll3czZNUHpqRlZVNzY2?=
 =?utf-8?B?dEhHU2JlSTA2MVd6WmZZblp6SlhwbHN6UTFzcXJsLzU3SHpBdGh6ZTMrNnlC?=
 =?utf-8?B?cVRKRjM5Z1FFN2NORGlQeWhBVzZmdlJDckZXdEFYcnI1ajFVUlV1Q1lFZDBI?=
 =?utf-8?B?UHZ3R1VkSzE3cWhReEU4bGJCNUtQY0FISlpXN1hHSmhUU1FocUUyMnQ5RnNP?=
 =?utf-8?B?L1k2SGc5K2krSXN0WjRUQVpESHZsQ0E1YThCam9NU2dyS05lRDl0MzZjWWtI?=
 =?utf-8?B?MDNNbmdkT0Rkc1padUVOTzdidTIxeFBKUm0zQ0w3WStCa1BUYytEVXJSMmo5?=
 =?utf-8?B?TC9SNmJqQmhKR3JUQjZpejN6ZzRwR3d0WmZkaGUxOW53Vk93L3lPRXh4ejA4?=
 =?utf-8?B?R25JVU9pVTZIbGw3SWlJOFpXcUl3M3Z5RDZ5aHBRMXlQVTNTT0dTeW55WEw4?=
 =?utf-8?B?WUw4VVlMTGVVNDVEUlpqbzIxRncyTm9oSm1aRVExdHhnN3gxSm1zdTZvblNQ?=
 =?utf-8?B?dGRZS1c4cDE2amRLSHpGYkhCbTJyRDF3SHJnN3V3K20vVEliU0hoNmk2TThG?=
 =?utf-8?B?UlJ5cFB0cUJhWGhqb1pYcDBGZXdOMk5BT0Rqc2loTENNVmJkQlF3V2tQK1k3?=
 =?utf-8?B?RVl4ejVVQ0pGM0ZTd3MvVXBGd2JiaHdaK2ROMXZXSzE2WWEzZ1dOeERSUWdp?=
 =?utf-8?B?Tmlka01NZUZmT2hEb2JjWjlzeUhnbXhYV1NBbFdvdWJjMlRTK2pxMDEwdEc0?=
 =?utf-8?B?TkxBVTVjQ050UEJBN1RjOHBqL1gxcGV3d054eEFneG9Ed2JIS2ZEay8xVEI2?=
 =?utf-8?B?ZUg0TVdPSk5KZmdUamliS2hMdThDQW5DSWxuc3dzdW9LU1NYK0x4SndzWHBR?=
 =?utf-8?B?YzkvWnVIeXZ5N3RlOVlmZ2J5ODdHdEJnVHpmeU9KNUtYemtzcnJvanMxZFV1?=
 =?utf-8?B?WWpRaE9wVnROREh1RGgvSkZBOUpieTd1dlAxWHhZYkFsbVpYSHlhZHFLOFo5?=
 =?utf-8?B?Ym1SRGxMUExReGd3NFBydEtWakFWaE44RzJTNHZES2NyVDlJY0xYOG5SbW9z?=
 =?utf-8?B?MmxRcFY5cytHWU5YVTNDU1laYlB2ZHNnOHpqQk52VjVzWlZwSzBvaG5kTi9y?=
 =?utf-8?B?aXBTdTRvMy9WcE93MUVYb2VHQ2tMZytuODUxWHF1S3lUamxReHVEUElGMUF0?=
 =?utf-8?B?WTVvQ1hRalBOTWNCWVRnYXpLNFNnbzlDSVozYXorODR4K3BHRUE4M0V1TDlm?=
 =?utf-8?B?OXpvTjE3Q0EvOEN6TTJHeWxGa05vNTBWSG9CODFrUm1YK0l1bHQ5d2dqSG9m?=
 =?utf-8?B?YjdKTGFITm13dFcrODlKdXVrenNMS09YN1NQeXYrY2crVDNLdjBEMk1jRzk5?=
 =?utf-8?B?akpUTWZMQmZvVVhRTkxzQnlCWkdCWG0wbVN4RzlrTDdYcHh6Q29nNUN3bC9k?=
 =?utf-8?B?aU1NL2k1Z1BqT3Y5aDh2eStZbDZncFhmN3EwV0dBbFdidDErdTNHODJqVkg5?=
 =?utf-8?B?emp2b3dDZzkwOU41QXJoak1Rb0VnckVuVjFlbHY4TDNvMEpXdlVBdTRoRnpz?=
 =?utf-8?B?M3VMdmhtOXgzZEtZdTFoR01RdmF6a3N6Q3NlUTg0VmRHYTVBYXNFYkhNTW5l?=
 =?utf-8?B?YmhObFNnRVY1anZqNnJTSW5Ra3RQa0JNdzZqdmlMemtnNlp5T0YrRWdaQlZj?=
 =?utf-8?B?USt2NGsrVkNnOU1yUDlZdFZIaVg1NDRGY0tNTFN2QWlqbzRpSGN0WHh4alNZ?=
 =?utf-8?B?Rk51WENFNHVHMTV2YjhZczh4MlRXMG1qc2xZSGVJdXg0bUtNc0ZaQ2hUUkNQ?=
 =?utf-8?B?ZzZmcmFUVksxLzBxcituNnpaWUo2RlpsbW5PS0g4UGQ4WHY3RjlBUk5wdU56?=
 =?utf-8?B?amRrZHB6K1pscUpBRG85Ym9GeWZ0c2tsNnk0TkpjQ2I2UzlyZ2Z1WFZFZUhq?=
 =?utf-8?B?dCs0TGszN1EwTGx6SzR3clRvVjQxTE1OYUNJQkQyaFFLSXhZM25JQWNTbE0w?=
 =?utf-8?Q?zzHs42+23k+qu23BNFPhIwyB1?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8350c28a-3208-4189-7a15-08db584de895
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:46:24.3380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUVKbLjIHYTmTK8kZ7CraSdecbRVhUkBZYHErSHL2pnDinpk6VDlWvYrNTfwUW37AN/DxdmnhTofrQcHc97EgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7912
X-Proofpoint-ORIG-GUID: t1xgrJC0m_lF783KDlYVBdNEitTnT_9o
X-Proofpoint-GUID: t1xgrJC0m_lF783KDlYVBdNEitTnT_9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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

This patch introduces well defined MigrateAddress struct and its related child
objects.

The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri' is of
string type. The current migration flow follows double encoding scheme for
fetching migration parameters such as 'uri' and this is not an ideal design.

Motive for intoducing struct level design is to prevent double encoding of QAPI
arguments, as Qemu should be able to directly use the QAPI arguments without
any level of encoding.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/migration.json | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index 179af0c4d8..c500744bb7 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1407,6 +1407,47 @@
 ##
 { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
 
+##
+# @MigrateTransport:
+#
+# The supported communication transport mechanisms for migration
+#
+# @socket: Supported communication type between two devices for migration.
+#          Socket is able to cover all of 'tcp', 'unix', 'vsock' and
+#          'fd' already
+#
+# @exec: Supported communication type to redirect migration stream into file.
+#
+# @rdma: Supported communication type to redirect rdma type migration stream.
+#
+# Since 8.1
+##
+{ 'enum': 'MigrateTransport',
+  'data': ['socket', 'exec', 'rdma'] }
+
+##
+# @MigrateExecCommand:
+ #
+ # Since 8.1
+ ##
+{ 'struct': 'MigrateExecCommand',
+   'data': {'args': [ 'str' ] } }
+
+##
+# @MigrateAddress:
+#
+# The options available for communication transport mechanisms for migration
+#
+# Since 8.1
+##
+{ 'union': 'MigrateAddress',
+  'base': { 'transport' : 'MigrateTransport'},
+  'discriminator': 'transport',
+  'data': {
+    'socket': 'SocketAddress',
+    'exec': 'MigrateExecCommand',
+    'rdma': 'InetSocketAddress' } }
+
 ##
 # @migrate:
 #
-- 
2.22.3


