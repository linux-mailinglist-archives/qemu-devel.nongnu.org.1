Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D17763A54
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:08:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOfNC-00047s-L7; Wed, 26 Jul 2023 10:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfLp-0003Me-Uc
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:18:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfLn-00019J-Bs
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:18:53 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36QDC32N032511; Wed, 26 Jul 2023 07:18:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=KpbfUwO7Oi3gEYNbedNRcrtCbcQe2tSGM2vh6Nqxv
 mw=; b=TMeoiB4oOngWVC50yNk/cL2ttZ7nclYgax5PcQ/rrXenlhzaM1C77O06d
 PTmtXLvkaAjhYUDAF6r5o7YwgU7F4thHvdr+qME5bbqaxD07/fhFgE6y0YqvTw4E
 dOVjHLm+fkaWbffdcK0wm5N6zrSlGOuXW6VQ6JeY6JBN6o9b7B5oFfBrIEfqeLDY
 cMRNBFuWDlHuJyzgoD4xhUmcfTGzdg/kaKcPimMSm/JsQtAI5VYVYkL5pcQIh40w
 U91/EE89JTKbNzzOO83mzl2PAXTZPA/ClSD9F2hOi5c/NFBySZYMipnUFjC1zj5y
 dDv9tcKb+W5mR0409zEDUkDDfPLFg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0b1707wq-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 07:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hygiJGg51ckTg9LULLzQ2Fr0wwM+0vMlTOZqCGNBPhiPrnCFAmgDEck320gnkdV1IB+AI90FyuKJWc6XRHcMR9Nrg+Ap2rp/vUVjCPWOLDDkOEvgEVlMl4VdOmgGjIwRDT9+/2bdiZBkE78NNkaE105WDxIxCh/0hbeRJ+yO5m8hAiBr96XlrcNxMCQ6gZdAHuWAuW1MPYTNrr9Nj61lSxob6hlfUh9/yQVbSe7TkJcYSIp+6/y+5/JONk2ZQqCun+XOXLApZ2EbRtyCcyet0mfRgJskw+jCrnRqqgea7z3V1lYYYdRuD3MoRQdjpOugA/trpCLz1G2YkfmQGf3sJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpbfUwO7Oi3gEYNbedNRcrtCbcQe2tSGM2vh6Nqxvmw=;
 b=KHqDlwlUYjEpGzAnuQNaSScZQ7zI35701nu3c7DFLvEDG7Bh5L08nCMe02mk45eJXAVocAij2BQxFqpdYJ8t8Ncv1l+huEeuoUJKq2sEhMAqBjEVL9irOUZx6Wq8tQclSNCS+k4RfoodmvjKdIfXYI00HjniXJmkjysryfCs9LX8sD1bf2a+U0mRlLUEIc2yTb3KcEL75wdS8bwvKZaA7kV12vl7heAM8BYzKBlY3rfmyvFgDJGoc+BSV4aTmsV+GgmrZ4jtnvshGUyfhUuRuq4zBcIJpjsZdnWyoF33K5Cy9XQicG3NVaqJ5FtbM4CqETuksz7QbqWXq2CvFmxVkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpbfUwO7Oi3gEYNbedNRcrtCbcQe2tSGM2vh6Nqxvmw=;
 b=yaYCO7z60FKjhPpUZKlFbraHqD9QpFkytMTqrpqsNlku3dhcKzhTMZd9Wi9LxVo0GULX6d+sAULZC0QexZ/7nQT94ke3QKzS67OtElyOgbc4weoi+nLAAvlawIJhVI7sV4nBSqBT2F/ucirzPr0G8FA/s32faHYn+28yN9qNDMdZ0tN2mWw5ClbP9IggByAWy9dtI4pH63oaq3XgYJC1KZkSjF5eSc+6rT2jk5JqxZIM6flKT0sQbZ04vWSG8wL+SAlB2DH+9yWAoTbyvIhAe4oJplaLd8yvECAvoY3ELmn6BnEPYwaBdJL9JNBn2lwsMTr2xqA7Fp/4lC5y9nYDbQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MN2PR02MB6861.namprd02.prod.outlook.com (2603:10b6:208:15f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24; Wed, 26 Jul
 2023 14:18:45 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 14:18:45 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v10 03/10] migration: convert socket backend to accept
 MigrateAddress
Date: Wed, 26 Jul 2023 14:18:26 +0000
Message-Id: <20230726141833.50252-4-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230726141833.50252-1-het.gala@nutanix.com>
References: <20230726141833.50252-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0096.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::37) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|MN2PR02MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: cb690939-0cf8-4de6-c2c4-08db8de33831
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KMASVc3SBSjP/dW1FCu96CYoEDRimOdg83HEGLSO0BmPTSaDsJBWP2wq17gfJQoiWEqbwrbkKxhuId0ar3scHTRYBrCQdBm/RMuNgO4x66c6gTD3TOx7kOdQbmR0GhWt0txUwLyBHxtY89z07FJ6a36zbMX/DKC4jjIGqxsFjN6Do1opzdIhnlbDrrmXK+1Y3THQ97gge5CwYxaNFTUJ+KLbEAzxqKv6JwFlQkbE+Be6B7Ms2fk0q1Mig/cAQC2kizieyU7rEEB0L5JZ4p/VJRro8/mOrxAb3P4xkU6LT4XYzVx77F0T4PlUow+upTMizzEn3dZwtBDX5yF/Z9KULUxcDiG1EM9f+FnkhaLPmdo7J1Rq5R21IfngHfBftD10/HqBm0ppuHL0TyA1RH2CpnSFlLzJuGGURYvJBYgbYURspuzmIJFVdgBghPukOaYDa3ZKax01qUE7zthXMHZ/sRUpr4Xlrlvp/8Qig3CYx3I4H+TgveipbjglNS8DwNGIKuE+9quVWdjLvQuFKC2LjrL1k/n1wHbY0rtuUUXYH43dVfVW+bg5Ci3hyPzRRmdZvB1IJSZNwYoOv1lcPn3J1Ty/Ec2nugOQFXGRV7t+Bmx69Jm2x3IkFbketldZ8LD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(1076003)(26005)(38100700002)(86362001)(38350700002)(6506007)(36756003)(186003)(2906002)(44832011)(8676002)(8936002)(5660300002)(2616005)(83380400001)(41300700001)(107886003)(6916009)(4326008)(316002)(66476007)(66946007)(66556008)(6486002)(6512007)(6666004)(478600001)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blppeW90WTl3NTF6ZmFoSDJLUnpBeVlNODV2RUFiU2ZHUUVmenljajBWRVBq?=
 =?utf-8?B?U0l5UVY3NFNsZ3gzVFREdThSd251V3dHQjE5MUJWVmV6RHFMYzRXaHJCLzlh?=
 =?utf-8?B?dkFRWE54c1VOYjdmN0pUcXBoZHRUTkRoQk9WUWVJTXdiZDVPMEhSRHFTSEc5?=
 =?utf-8?B?RnFSMzhtbENEcU1GcDF1TFBjT1Y5Y2lIcDNHWVpYdXZ2eWFSZVFFM2lpd3E0?=
 =?utf-8?B?VC82TFBNbS9DVmpEYitZWUdkdWoxK3pQRlBTdDJTbWp6TW83N1VXek1sSFhL?=
 =?utf-8?B?OU1lcUpSa24ydmdxeGlkbHFWUDQ4eG41TklGWktMSk4xQW1pTUZvZlNZQ0gz?=
 =?utf-8?B?YXlBZW1kSzJDTG45M3lQTHNxRHlUYUJOSG8yL0RZNVVnZTQ5MmZKNWQ0YnJx?=
 =?utf-8?B?YlV2Vy9SQVN4TEtJL0lvdlQ2K1UxZVhkanVCdXBjd0JvL3dFWlRZZE5MNk1E?=
 =?utf-8?B?VVBtVGNuWFdvcVM4R0wya0Q1RzBnR1FISHlGcnc4MU5wMkQyZnUrSkxQbGxk?=
 =?utf-8?B?MXdrNE9qQmlUQXlZVjU0b3M3NVJLZ1Vqc0tDN05YanNBUUh3RVErUzJnYnVE?=
 =?utf-8?B?MUQvTVd6U2lvcjhPQlA1MDRmZVJQc2ZhTytBMjBXQjZMWWFSWjZjUGVXaWNC?=
 =?utf-8?B?dGlZSHBDYkg1ZHVzRVI3QXEzWkRBOTRVWkVRR2J5WHVlZUxza2JjUEc3Z2c4?=
 =?utf-8?B?MklGa09sbkQ2VXVjdWVpQkRjZ3hZbGI0bWtENDZKNHNwV0Q1RVdrK0VEQzVG?=
 =?utf-8?B?NVJNSDY2T2U3QU9MUXl1WThyUXFiMy9GaU5DQXExWkhpTEtjbUU0aEhod1hV?=
 =?utf-8?B?R280OVkzblAyS3VveVhPWDd5Sm8vZE9ZbERReWhuNG1zTzdVWDhTcVE4UVRv?=
 =?utf-8?B?bzhSblJEZHExeC84UjczbW1WOTAxWWpHNmluRkg0TS9HUTRQaHhoN1N1Ny95?=
 =?utf-8?B?Slh2TytSMmxXa2ZUUHBEUWJZTlZ3NzJCMUZhM2dzYmk4N1lPa3BIMW1FQlA1?=
 =?utf-8?B?cXZIVE0vdjNaZU5adUVjUjFLODNjcSszeVlCbGx5ckVzaXgzZ0ZWMVh4L08y?=
 =?utf-8?B?eDlING41eU1mK0dKTEE3S1VaOUNZT0JpcXZPelRudmFxUG9kMGFyT3dUWE91?=
 =?utf-8?B?TE1BTWF1ckQrdmJBMWVTYzhYOUhkTkxnUFVTQ0lDaWVCTzZJaXZZWmc5SDhV?=
 =?utf-8?B?K2NCYXNLUzVmTjJ4aVVtYWR3MHNsWWFNa0tEUlJNTnRXQ0JOQytEZmRFajRK?=
 =?utf-8?B?elJrVG5OWndqbTdZMzNOLzF0OWQ3T3ZDS1lUT1BwV2hZNVhPWUFJbjZ5eVRV?=
 =?utf-8?B?M2JIUmlJRkNKT1B2UU5CVUllbDJSNkxmbU9sdy9YQmlGUFlacDhiM0VkNzhO?=
 =?utf-8?B?a21GQ3NJRVk3RHNtTm1CRmNyRkVFakpBYkhoYmJ5YWxhTFJnN2xQT2RwWXpi?=
 =?utf-8?B?NU9wOUh6YnVXSldZM1RqeTdZRDJ1MkNaZXh4R1ArNVQwQ0FSSmdsWGxhSXRX?=
 =?utf-8?B?N2Q0ZngzZ0xyWTRKVFl5QWw1Ykk1TU5ZbmJLaEExY1JRdE5XZUhIK2U4MHo4?=
 =?utf-8?B?aFAxZUZkVnpqZGFQNGxoaTJJalFweTQvUjBERlBBNHNRay9aaTdpVzBJeWM1?=
 =?utf-8?B?NlJWa3ViNFBuVXFoL3BBRXNJenZsN1U2MHJUOHFoSllLNVlZL2ZpR055NGNU?=
 =?utf-8?B?Z2hJSUtiQUR6Ky95NUM4aGEyYUFDZDlsOFcvYzJSNmJtVzUrNkhvZENrL3Uy?=
 =?utf-8?B?S0ZBMnBXNUdHRW8xWFZiSlhUbmtDeG9sS2x3MjlXbEFFU0RHK1ZrRE5qWGFM?=
 =?utf-8?B?Wk5BMjBkVTZXRC90YUt4bnBOSWowYWF0VlF4d2h6YjV1bVFTeVl0SWtVdGtD?=
 =?utf-8?B?ck5OQzluR0t3d0ZwWVdEY1V3WkExaXFxOU8wamFhNWE2QlpCOGV6V2JUZ3B5?=
 =?utf-8?B?dm5YTVdpbGo0RGg3RnlNWUd5d3ZQRDlXaEpYUUF5eTFJVkxPRHBlb0ZzV293?=
 =?utf-8?B?M2IxWGF3dmxHUk12M2tsR1pURm94UHhRN2FvbC9UTUN2ZmVKZVM4VUx3NmJQ?=
 =?utf-8?B?VVIvRGU3dVlJbjl6eGdDdExQUElHM3RIbVc2TmZTTytLUzBsR1ovNmRXMTI0?=
 =?utf-8?B?Q2tncGdNMnhtUU9HY0pmOE8vQmxVV3RyMnJ2UDF5SE5uajNpdmc4TjJScjlY?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb690939-0cf8-4de6-c2c4-08db8de33831
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:18:45.0668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkeCb8S+95VjD8HlOr0u+YQdH8SDcS+6onLO8W3WlQ07AUmfV5aabxru0SGYdZqllFRw91oMEWGayYQqRj8zWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6861
X-Proofpoint-GUID: 4FPNTMH3ZWUXqtmuysZMyEMtNoQAUilk
X-Proofpoint-ORIG-GUID: 4FPNTMH3ZWUXqtmuysZMyEMtNoQAUilk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
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

Socket transport backend for 'migrate'/'migrate-incoming' QAPIs accept
new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for socket connection into well defined SocketAddress struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/migration.c | 30 ++++++++++++++++++------------
 migration/socket.c    | 39 +++++++++------------------------------
 migration/socket.h    |  7 ++++---
 3 files changed, 31 insertions(+), 45 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5b3be767f0..c4bcf8bbd7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -481,18 +481,21 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
     }
 
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
-    if (strstart(uri, "tcp:", &p) ||
-        strstart(uri, "unix:", NULL) ||
-        strstart(uri, "vsock:", NULL)) {
-        socket_start_incoming_migration(p ? p : uri, errp);
+    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &channel->u.socket;
+        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+            socket_start_incoming_migration(saddr, errp);
+        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd_start_incoming_migration(saddr->u.fd.str, errp);
+        }
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
         rdma_start_incoming_migration(p, errp);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_incoming_migration(p, errp);
-    } else if (strstart(uri, "fd:", &p)) {
-        fd_start_incoming_migration(p, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1715,18 +1718,21 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         }
     }
 
-    if (strstart(uri, "tcp:", &p) ||
-        strstart(uri, "unix:", NULL) ||
-        strstart(uri, "vsock:", NULL)) {
-        socket_start_outgoing_migration(s, p ? p : uri, &local_err);
+    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &channel->u.socket;
+        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+            socket_start_outgoing_migration(s, saddr, &local_err);
+        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
+        }
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
         rdma_start_outgoing_migration(s, p, &local_err);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_outgoing_migration(s, p, &local_err);
-    } else if (strstart(uri, "fd:", &p)) {
-        fd_start_outgoing_migration(s, p, &local_err);
     } else {
         if (!resume_requested) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
diff --git a/migration/socket.c b/migration/socket.c
index 1b6f5baefb..98e3ea1514 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -28,6 +28,8 @@
 #include "trace.h"
 #include "postcopy-ram.h"
 #include "options.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-sockets.h"
 
 struct SocketOutgoingArgs {
     SocketAddress *saddr;
@@ -108,19 +110,19 @@ out:
     object_unref(OBJECT(sioc));
 }
 
-static void
-socket_start_outgoing_migration_internal(MigrationState *s,
-                                         SocketAddress *saddr,
-                                         Error **errp)
+void socket_start_outgoing_migration(MigrationState *s,
+                                     SocketAddress *saddr,
+                                     Error **errp)
 {
     QIOChannelSocket *sioc = qio_channel_socket_new();
     struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
+    SocketAddress *addr = QAPI_CLONE(SocketAddress, saddr);
 
     data->s = s;
 
     /* in case previous migration leaked it */
     qapi_free_SocketAddress(outgoing_args.saddr);
-    outgoing_args.saddr = saddr;
+    outgoing_args.saddr = addr;
 
     if (saddr->type == SOCKET_ADDRESS_TYPE_INET) {
         data->hostname = g_strdup(saddr->u.inet.host);
@@ -135,18 +137,6 @@ socket_start_outgoing_migration_internal(MigrationState *s,
                                      NULL);
 }
 
-void socket_start_outgoing_migration(MigrationState *s,
-                                     const char *str,
-                                     Error **errp)
-{
-    Error *err = NULL;
-    SocketAddress *saddr = socket_parse(str, &err);
-    if (!err) {
-        socket_start_outgoing_migration_internal(s, saddr, &err);
-    }
-    error_propagate(errp, err);
-}
-
 static void socket_accept_incoming_migration(QIONetListener *listener,
                                              QIOChannelSocket *cioc,
                                              gpointer opaque)
@@ -172,9 +162,8 @@ socket_incoming_migration_end(void *opaque)
     object_unref(OBJECT(listener));
 }
 
-static void
-socket_start_incoming_migration_internal(SocketAddress *saddr,
-                                         Error **errp)
+void socket_start_incoming_migration(SocketAddress *saddr,
+                                     Error **errp)
 {
     QIONetListener *listener = qio_net_listener_new();
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -213,13 +202,3 @@ socket_start_incoming_migration_internal(SocketAddress *saddr,
     }
 }
 
-void socket_start_incoming_migration(const char *str, Error **errp)
-{
-    Error *err = NULL;
-    SocketAddress *saddr = socket_parse(str, &err);
-    if (!err) {
-        socket_start_incoming_migration_internal(saddr, &err);
-    }
-    qapi_free_SocketAddress(saddr);
-    error_propagate(errp, err);
-}
diff --git a/migration/socket.h b/migration/socket.h
index dc54df4e6c..5e4c33b8ea 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -19,13 +19,14 @@
 
 #include "io/channel.h"
 #include "io/task.h"
+#include "qemu/sockets.h"
 
 void socket_send_channel_create(QIOTaskFunc f, void *data);
 QIOChannel *socket_send_channel_create_sync(Error **errp);
 int socket_send_channel_destroy(QIOChannel *send);
 
-void socket_start_incoming_migration(const char *str, Error **errp);
+void socket_start_incoming_migration(SocketAddress *saddr, Error **errp);
 
-void socket_start_outgoing_migration(MigrationState *s, const char *str,
-                                     Error **errp);
+void socket_start_outgoing_migration(MigrationState *s,
+                                     SocketAddress *saddr, Error **errp);
 #endif
-- 
2.22.3


