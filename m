Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AB074D570
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:30:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq0B-0008LF-3q; Mon, 10 Jul 2023 08:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq08-0008JP-T9
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIpzy-0000jw-Ip
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:24 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36A6g0PY002141; Mon, 10 Jul 2023 05:28:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=yE8QNBoBo1yNhXkzaJo4kdSTJRNOhJiLF7qssFTcp
 p4=; b=zNGwQ68YkupVX+xYpBPaXmFv7y3obfX4ntjEpWd/tqSCH2nj7bfvLFImY
 JK8tdKYZpDUj2vTmUnmRg1YaKRHsm4bobeeAGXMsgFlvg5EQxmRQKZSvLHKUJvu4
 Y/RvYvqx6a/XTwxziZm11XSs0reJ5pt1DXG8QZk/fsiyi2h9pYh32hexJIZwqKSM
 FQUu6GhUZQUFjdFdpwlrUpNvaDqa5VIWXhNpKaPrVv60ECKKIgYPLIlsTWpSUoln
 sLt2x/a4auz/4GLm+rRZgDcuCjz/BYQkxZ6PBOELomDANQWOK7j1tGHDmh2zYnoZ
 3V9lHmZexYXMJHLYlDbKnV6dIJddA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3rq5b5b2te-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jul 2023 05:28:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRwCY24YMAyv/SvunnFQEmpJkKRecknftpFwA4GjwOmMUUYQlRK7OfIpXpk3x0cl6qI64T9AKf0m/nvfSOiyK50xjcFVdWBsUjrqWJF1h/R5oYG3WSlJLJ4K+JehC9yvoSvcA5GvBVTS/ltgc7IeyzjP7FSMCSG152Bnu95ZYXXHaglVSUhL5t1LjDdu1ya7FCF9tsJQmgypw34yjTExTBFeKZ2+HSzX7D9aAkWAMaMVZRyoF+J6NWCQ8YKnjFxbxffj/rMBV4umod7DRgIBJ93yq/9PB4hwYlm4WBbazIIflGeR63p+U6rnPHDLUfejStV4rXPdVQASQjEh99YgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yE8QNBoBo1yNhXkzaJo4kdSTJRNOhJiLF7qssFTcpp4=;
 b=Q48lwgwiuYGhiPUG6neWfUppGRnDhmU6fV7ZCOnigdi0+XxgrSGVTe/7/c72KqKp8rWDk8Ps9p8kCpKa6yt4tZAOYxCrBuz+AomsZiIErPJoQGHprEuxgbUHJ8dZmCmHqWscAnEnMmunZJ71cJfgBMRmKipXUTvmff6kUWab7AAlI6E09XATGoi2TDjr5/zPj+WFHsN0tkwXdqqpav+fKx/sk/jUqf4z8swUs0oIQgdt66VZDusFcktkKGGD6Rfga4xRw41QFmJ6ICLtuheKJ6iszmT7HoDkOhqFKFtJXgtPzKM4SAlrsr2VCbO5Xznq/JPda83c+MF/xMgliCf8bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE8QNBoBo1yNhXkzaJo4kdSTJRNOhJiLF7qssFTcpp4=;
 b=iOVsX8PST/Dsr4VM8SqXE2U6HUdj+nlXQAtLrqmheGyXiwgYIqoNYvqX9DJK3QCqjPVs2yB0D1bvSJgF6wXWoxNOUXM5IupCYPXx8DCAnhQ7lXcEO+HNIldHiw8lx9Yq87IHBXrG9lAAUSe2STTzBX1KLj2rrgFkBBZd/koImLDthW6lbwP2xSuSmCi38Et/xo7z4OpRV1VQ+ZeJ2kD9KyPG9QjhROBUo5vy0mnRwr9fi/5mqlCD5R8nR//TxWKbkRZ/J1eQGNS6+7daIRNBNw0O/6Hh2UaIfBQCcKaCoeOGCDryTTsEppJ39sQKciZK7yxe5VnLQ65Pa/Md9NABkQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MW6PR02MB9934.namprd02.prod.outlook.com (2603:10b6:303:23d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.13; Mon, 10 Jul
 2023 12:28:09 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.017; Mon, 10 Jul 2023
 12:28:09 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 1/9] migration: introduced 'MigrateAddress' in QAPI for
 migration wire protocol.
Date: Mon, 10 Jul 2023 12:27:42 +0000
Message-Id: <20230710122750.69194-2-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230710122750.69194-1-het.gala@nutanix.com>
References: <20230710122750.69194-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR15CA0003.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::25) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|MW6PR02MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: eb343ff1-30a8-4b89-6f40-08db81411ebf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzJFUpILrq6GBPKOQzT8gNAblI1YYkLwOPA0awmRqr3wLYLSTigEyWxxWcUSDjajQmNq8BB2d0fcrN5U95grWVBhLHcin1f3DW7aNTGqO/BSnYH5Ntr/qtcr7kwmwVb8NhCK7/7yh1Gsw7t/KaPZuKDDJs5P7AaKrlQ14Svf8twytUllJ70XSQ2NZvxkeq00m6YrvIc+gQt0Z+21hZqUEsXquKqo4+Gw9Tzj469JZLFsrF+uersgH07jtz9vTRz/81fvxCfOU545ImknkOa8iTxF4xmelCB9599gGE+MminQVfFZo7B3ObtAXn8809fARUMOWmTBKt9Wg5tLmJp57OLyrdCWy+jG1qsb+Po/2yFgTXkTlQLIouq2QZiA1FBTs5KFfEEp9D6bylgPKs4KEW0MZ3UA2v7ed51M7BpFlQb3PYwFaby8x0uNd3Z9IgEFVSS80XtKrskpqMvDBDjAM9IK1bfSLG9bUn1JwmJydeVvKipNcaVHqQyrjmBEaio8tKO3tJg1LzwZMGW+uI/2V12UapIWIoHkIh3c9s2mEdBk5aLv1T/sFvIFbiyqeWCjTd8FW2AOu+RHraQO2/sqUREaA09lPTmzGJecKwHhqb6hoCxPg8/2YFAj8ql0hGBp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(38350700002)(5660300002)(66476007)(8936002)(8676002)(44832011)(38100700002)(66946007)(66556008)(36756003)(2906002)(478600001)(6916009)(86362001)(4326008)(41300700001)(316002)(6666004)(6512007)(6486002)(66899021)(1076003)(52116002)(186003)(6506007)(107886003)(26005)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkRXTkpxQ0NaMXFvOGxlblpxc3dZRVcrTWpZazhZQk8xVzhkZmdlak5tVndt?=
 =?utf-8?B?SllibmI2amtCU0g0NGRCZVd3bVRjYklrL1pndnJyRm9sWUg3YjlqTGpsYVZB?=
 =?utf-8?B?SzFXb2xRR3pkU3BKa1JYcCs2VmpNMFAwQVNSMVRqNlJCUE8wL3NTbE92Qndv?=
 =?utf-8?B?dkFTR0UwNjc4b3JjRzVTeU5nK0tCVmFJMnlieGRvYjFsdkVLSG9jY2RqUGFa?=
 =?utf-8?B?OFpmNDBzZU1scTUzL0FJQ3VvU2luTXp2SVpuZ01xN2N2QkxwSkYyVHlpcERl?=
 =?utf-8?B?cElybkd6Qmp3T0J3RFJzbUtnVEhqZ1VXZGJNYkhQL2dWUUdBUXdRK3g5RkU2?=
 =?utf-8?B?RjhSSVplK05yZytzR2ptWStGalczRHNVT0FGTnBzTHgxVEtvZ0p5Rk1McWVl?=
 =?utf-8?B?dUxkY2lRcWk4SUd6Y0RtTndMVFNQQlpML1pDTkx1ZnIyVUlQSUhUM0VTZ3VD?=
 =?utf-8?B?RkVZaUJUbkdaYVl1QnZmT2RyVCtIWW15L0hvSGlKNXRvMDB4K0FtOExwbHkv?=
 =?utf-8?B?U1JGOHcvQzVtdGNMNlJPTUN2N1AzMyttSkFTUklXSU5vTmZjd3NUbGd1UTVo?=
 =?utf-8?B?SUo0RWtuLzg2SlVVWkgwZ2hlQlRUUW5ZZCs0NUxZSkR0RnhxWjFCRlBhYkNM?=
 =?utf-8?B?M0VpUis1VFdKaG5NMEhmS3VFY1ZHbE1LcDlXbTM1SkZ5cG56MCtWN28reS82?=
 =?utf-8?B?QU5EOU1TR01PdlFrSVkvY2M3eDdGWUl0c2dRTTZKVUxzYnFSODNzZEw3WGdL?=
 =?utf-8?B?ajR2UFR6eEFWdUpuSUg5NlEwZUJFaEJLVnU1cWpCazBYcXBJREJnSzd0TXJp?=
 =?utf-8?B?YmdoQTNWdWw0MmRwMVpCSmk0NGhEdkxiZ0l2MXpqVWlzTGVBVXU0YlU4TVMr?=
 =?utf-8?B?K3dpZTNnRmRES2dQWndBSXNMNVhscyt0U0VXZFJXQldKNndIKy9kWEg1cXNI?=
 =?utf-8?B?blB6aUh5dVVlR0E5MERLWTRwV0FCeklqaDVNM0pWZDNyMy9kbGdERmlwbHJo?=
 =?utf-8?B?azQ2WDBpNUV5eDdZaDhCSnMwbnVGdVZIdVVVNFplOWM3bC9xT2xtVE9FOHA5?=
 =?utf-8?B?RmtWd25lRWs1aFlDWmtYTVYrd0w4SFBwdWRJK0RSV1MwS0d0d0RHWTdxeXd1?=
 =?utf-8?B?eGJwSExWbVRjcS9XK2htcXZlT3FZcDE1Nk1ZeTFRTVR1dXNtcG04c0htK3Ix?=
 =?utf-8?B?ZjlUbE94b2E3YWFucVo1bkZIUFh2L2FRUGFRdjhjWllqa3grejVCVkJ0M3hp?=
 =?utf-8?B?cHJrVnhucHAva05VZThpUVdLeVV1MTdnMVZQdHRDWFQ4QmF2YmxrR0R1YzFE?=
 =?utf-8?B?UncwZENzTWRXaVEwM29oQkg1Y0FjeVdaRTYyc0I1WUlIWVpUR1FFL0tKWWRa?=
 =?utf-8?B?eDFoUTB0VlhtS3R2d1pvb29IcUJSTUxuVzNYRjVmdzVuSitqcEZrbmpKOUdn?=
 =?utf-8?B?VXh1TjFvTFExUVdLQTJ5QTdSVUxzaE54Z1U4Nm5KRzZ2QU1SSnRpS0pVWGQz?=
 =?utf-8?B?eVh0MThlNXNMc25OMkxJbzJPVElyOW5KYkpZWThaMk1ZaFdtTzdyZ0l6WmdG?=
 =?utf-8?B?aWhKcmRzR09oUEU4SVRvN003MThvOWF5REMxcGRNRFpVbk1vRDBQVG1pOEhK?=
 =?utf-8?B?Vm5WSDJNM1k0SndyeXJkZGtMNlk0VnFEY2dYUTM1ZURaZnlKUUUwc0o1Z2pX?=
 =?utf-8?B?Mk1XQXlrbi9Kd3dUNWwydzIvRUZWcUY1TENQMTZLNGR4VDlKUTRxMjdZb29L?=
 =?utf-8?B?RjdPQXZTQU1sZ3hsaGwrWkd5SDBzalE3NTQxbEFyMnE4b2VKeFFyU3UvV0hS?=
 =?utf-8?B?OWdKR0t4L0xYWHJMQXNlejJ0TnBobENtcW5BRVhZUkhDRzdDbW9ORkJYWDZG?=
 =?utf-8?B?TkNsSGF6d3NnNTRVZHNmTEtPaEFxUi9zWjI5UDM0am81MEtjOUU1a3lmWDlP?=
 =?utf-8?B?QytJSFhJM0tWL2xvV0xITjF2WUJrZG1tb1RhdE9jMzk5a3NEWFQ0RnhHZzdo?=
 =?utf-8?B?bGRhODhsdlJGVTdibHdjOC95WmRJcTZ1b2dLam41dTQwbTRjMEtGbHo1QW5u?=
 =?utf-8?B?SitabmRrT21TWHRobmhWcTJ5V3RqeUdaU0t3WUpOOGhtaU1TeDVJcmhyTEhG?=
 =?utf-8?Q?pPzxv5MREuFP/FbuoTJoJLd/z?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb343ff1-30a8-4b89-6f40-08db81411ebf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 12:28:09.2985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukV9CRLd9AgBxIB4he5DozFSYmsrIZvIw92B0usezJgwAzLonrBXTGxniWbjLqJ3iaNWeO8av49lKUO69qSFfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9934
X-Proofpoint-ORIG-GUID: MIaDcasKt4Uv6X_htx_25kUwFJ0AGUhD
X-Proofpoint-GUID: MIaDcasKt4Uv6X_htx_25kUwFJ0AGUhD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_09,2023-07-06_02,2023-05-22_02
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

This patch introduces well defined MigrateAddress struct and its related
child objects.

The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri'
is of string type. The current migration flow follows double encoding
scheme for  fetching migration parameters such as 'uri' and this is
not an ideal design.

Motive for intoducing struct level design is to prevent double encoding
of QAPI arguments, as Qemu should be able to directly use the QAPI
arguments without any level of encoding.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/migration.json | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index 47dfef0278..b583642c2d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1417,6 +1417,47 @@
 ##
 { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
 
+##
+# @MigrationAddressType:
+#
+# The migration stream transport mechanisms.
+#
+# @socket: Migrate via socket.
+#
+# @exec: Direct the migration stream to another process.
+#
+# @rdma: Migrate via RDMA.
+#
+# Since 8.1
+##
+{ 'enum': 'MigrationAddressType',
+  'data': ['socket', 'exec', 'rdma'] }
+
+##
+# @MigrationExecCommand:
+#
+# @args: command (list head) and arguments to execute.
+#
+# Since 8.1
+##
+{ 'struct': 'MigrationExecCommand',
+  'data': {'args': [ 'str' ] } }
+
+##
+# @MigrationAddress:
+#
+# Migration endpoint configuration.
+#
+# Since 8.1
+##
+{ 'union': 'MigrationAddress',
+  'base': { 'transport' : 'MigrationAddressType'},
+  'discriminator': 'transport',
+  'data': {
+    'socket': 'SocketAddress',
+    'exec': 'MigrationExecCommand',
+    'rdma': 'InetSocketAddress' } }
+
 ##
 # @migrate:
 #
-- 
2.22.3


