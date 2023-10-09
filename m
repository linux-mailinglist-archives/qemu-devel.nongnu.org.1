Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A58587BE302
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:37:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprNX-0003lH-Ac; Mon, 09 Oct 2023 10:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNU-0003bd-A8
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:37:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNR-000371-RQ
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:37:00 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 399DaBN4001999; Mon, 9 Oct 2023 07:36:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=hiagJbDxaOWw+mSoz4vuahAgX1fl4GCP5/vxSvd5Z
 zA=; b=nKSt4Ah3rrdt/oKJFPsvloYMTzMYPWyV85Arz0LTklmjNIDupSGw7Mq65
 0Qaxt02iRG7l0IEbBRuTozRj65iG1KzVhGpK0bh35JXMQNoGFG0I9N/iegXc1p65
 JJukZjZ6/6YC8bXmpgjrMhCE+uClc5NETg6UdvF07DPsQryfWfwq1xxFh0t7fMPx
 OS+hsVg3INikobhfF8tnceKBhW1wWfNuJN7udOP/fC73wGj6fmNgrVAg00jxh8fZ
 yMEVxEW3GVdfcNsOwFtw9WDL9eP5ln73S2EgET+d5kt7cyCgVnMoCkQtG0yZH1sL
 LBgEUrHOW0RhVhdTzeDz7OdgpAImg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhv02tkw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 07:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXc825U2pkGBbz/BlBD4mVha5hauxzKc1/ntF08zdcR8oLvTdre7hzTLlqeTGVReugwBYwuyNXonGU2jXK+FTg4f2iPc1tCzmzbFVQt9cwe6CXS1r78IIcUVmvjwPpAN59W9YrEFfTHUBV9fa1gJqJ5lihUnevEJZ5Igb8P9hYhA8m9dslDJ4Y6tWjZpSdF4CyuiSgwqHu7uKPslqQPMnyIdLcaH5vAk8uCc+z+xyuAfjxZvbYQs7/YRiUw+KgA6lgdyFe8kv5JuMXVvO2mw6xqe95Y6GL9FQ0jYwKrnVsOX+EdJEzP8o7hVdtHsB0PxK68mLHPMkN/W8+uybuZAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiagJbDxaOWw+mSoz4vuahAgX1fl4GCP5/vxSvd5ZzA=;
 b=aTe5fq6xs8W1Zo0FOFZy+HUixrdlLJdHWqD8z/o7SJn+ZXyowDhx6mkRE7zkDAxT5egdaSFcG8YWjbOLcfmx5VVJ+F4j3FXagIUCq6sWgdJGjDNg+M92lhvJJmt2v9pDzUIIXTCySr3MvgFUf6QrR8EJyPV3+X4A/7gIrLCuHnBGebrlLgnwhpHVb+sTz9JDqvW/ycsK/YCrXha+Py6mDgDTql3WhMIKsaN1zuCbPB99o4tL7OlHz/NGDRowVxnwX9GK5QUgiYRoPKRvo937h4ANhUO1rActasnGIHWmgvdx3+l2sLXqxwyHVgRGeAnBCMPpco/4fpnBWJBXQizD8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiagJbDxaOWw+mSoz4vuahAgX1fl4GCP5/vxSvd5ZzA=;
 b=apRIAvhNJKFO8HwcTQftPmtjyGr7bi0r0VOroXzyP6dZjcOwJXCcytqcwTORGN4iktfGNCd2u9maRV3rh44YUkm47sFH3J3doEGX4atVUWu/NlnfZU7rt1c69UVj5JZJ9mZ0j1qO7LRzEoAszjeecPxZVyYKjUEAiI3XsDR0SbQRVq3cxSRZ1P/+HXy2qpQqGF1xFHR1r/+OK3gIwFURFPG5bO13FrIUm55WQRrihOn+p6JG9jCFZt1KZ7dD7+hecMWfGYMOh+sk62QlrmidWdCJYWCpzFFvImfep57mmk1eADm6fd7gsDYtkPhBIVWTtkcW8npIukdhAIT4jJnIFg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BN0PR02MB7888.namprd02.prod.outlook.com (2603:10b6:408:160::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 14:36:53 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:36:53 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v12 07/10] migration: modify
 migration_channels_and_uri_compatible() for new QAPI syntax
Date: Mon,  9 Oct 2023 14:36:12 +0000
Message-Id: <20231009143615.86825-8-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231009143615.86825-1-het.gala@nutanix.com>
References: <20231009143615.86825-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BN0PR02MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 99731c1b-dc94-48ce-123e-08dbc8d52e82
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Is6JzNfYwCxBTKwQx+ViD5ss+8gh2eOlsFeYU503qDLCD0gN6M8l1VY6POOgsC3NMH0c6F/oIu9biuQ/Q44i6pHZbWZuy4hmYrm9G0HxOixj1CjkQH9WR9Wkl0Qg+ksgr8F8PsvJguSa7MdFfKQASHE7fh9vN1RVxuO04HEoEONc7TPkvEmPfJFFmT5y7KdJWN++wMf0B1o6pJoaMb2NPH/ayz78Cy+vhPsF++Nw4Oiklj+Tt8r5GiS3DSB60XoaCcYBFoj+QOYtCCoVmpJSrlq6sljwNijsVOdPbepjFRpgVotmEUT0OhsMYavY0zpbkRnIQrLcdd2dHDPqZYlwPCjZ4Nqb6A5kLHGoI8ydiahwfTMLD4OU2RdRY0z4E8hPaJ8xX5fYrDVDe8JOFRZXIEUdFxJRjQ9W9RV2T7qWZOPWdcsWBuAN0TOODvcny2aOFLWm8acyKmj5EWeRCKcJkRm1Gak6mPk9mYGENhwHpH25X4yPKHoveCtSzkI+31lpYn8Dsjk+4JIlBUylECF5qKOPDRMXzK1L3yawOYDO+hdXrWpSGljzdsRxCIdYHxXHDVT5UbwDXLJXVJcZQa5N6RnEUlp0QFUlTzHe5J4LDXt8rJdndvb9cDrobA/8Hwk9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(1076003)(52116002)(26005)(2616005)(38350700002)(38100700002)(86362001)(36756003)(107886003)(83380400001)(6506007)(2906002)(4326008)(478600001)(6512007)(8676002)(6666004)(44832011)(5660300002)(6486002)(41300700001)(8936002)(6916009)(316002)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?USt6YzJJVDJZZ3V6UGFpeEFQZWlkUzlPTVpjN2pBTjRLVVlzOFZjMnBSa2pv?=
 =?utf-8?B?cTRqdmxtVDJGNWhxdUVaek1iay96aVU4L1RQRkc2ZUdoRjlRc3VqRHIrUFhC?=
 =?utf-8?B?MC9mNU8rMGFZY1BQWVoyajRFK0JkeGRHUTFKTTZDL1plYVZ5NUJoUm84Rll3?=
 =?utf-8?B?bmtLbEhLMnVvY1NDdmpPUjlyRkxza1o0OFB6M1pSd2pGeElzRFJsK3FHcS8x?=
 =?utf-8?B?TndjMVBLekp4bTNUd3VERm5XRzI2cVVCYXFmTGpxTVA3aW52VEdoUTlLT3Ni?=
 =?utf-8?B?ek5wcG1kZnM5SSs4L2J1WFpCUktpVzdxeGdyK3FZNHpDdXhQWTljMjFTc1N0?=
 =?utf-8?B?UmFpVGFVdVk4bzJjZ2JrUXpHVkhwWmRpRU81R2dDcS80SlRNL1RtdCt1cEkv?=
 =?utf-8?B?YjdQYTZqd3IybXN4OWhqS0EyNE5BK1VzeVprWVhCNCt0M09sY0k3S0FTaXV2?=
 =?utf-8?B?alliQ05wUHdVSVJyY3I3SGIwZTBQUWRYdURVckFtaURQNkM5Vi9tZk9TZmlk?=
 =?utf-8?B?VGxGeitjWDlvQnNYT05aYmgxU0I2OC9mcEQvNXdDdDZCaGdEbXduakdoMFBv?=
 =?utf-8?B?WGlXWVFIbnVlaWhQT1p5Y292eEsvcyszYUszVlQ5akZPWDEvN0E2M0haeTVW?=
 =?utf-8?B?QW1UYmo0b3JtUzNnZ2hVeVNUWFlKazBRdHBOaEFQRjNnUHM5RmFRQkoxQXpT?=
 =?utf-8?B?T3Y1WENIY2Z3QlZnekdXKy9sZktieWQrS3QzWUwwWUVFT3FESHZpZTBTN29u?=
 =?utf-8?B?bi9jVjdTbGFqT3pUV09wcDRxSi8wNWtZZHFNS0JEM0tEcnh0UWk5RDROM1BN?=
 =?utf-8?B?akIrcVBNRzcyeldZOG1ldG1sUncrU05xeWJpNjk5VlJVZG1rbmlyeXRUVDMz?=
 =?utf-8?B?VWlHdDVBRXVTQUhpcCtPc3RHL016dkxKQXZSMEkxT3JIUnhHaHpPUytqQW16?=
 =?utf-8?B?aEFHbDVqNGFHNlBRZFNuOXFrMExGaHlsektscGlBV0RJamp4cmxjSnhzdXpJ?=
 =?utf-8?B?dnpmUFkwUEhrUkVEM3dWTjhieHA0Z0FpUHpuRjBWNTNlU0t0cGJFVFYxYWJI?=
 =?utf-8?B?UlpXZmRhRkZQL0lCSFFwL1hLU01UZXpUYXRHakJlRTBDbVEra3RoUVpTN3lL?=
 =?utf-8?B?VXhQWGxTeXd4emJ4QmE1Rm9PZmd6TUJXU1MyNjE2amMrKzQ2WHhscmJoampC?=
 =?utf-8?B?Snc0bFBsM2NzazJGQWFKQmxaTDQ5QnJoTGJBTFhlTFRQUU9UcXhiRDBINE95?=
 =?utf-8?B?TzNoOGoxRmZIdUZvYVlZOEhRdUZiZDAxbDdLSWJLRXlOY2NVL0FTU2IxcTh4?=
 =?utf-8?B?MVY0YVE2Tm4rakdwZzROTzF1Q1AxM1pQeVBhTFZkYVk3YURMcW1USnpUdmpy?=
 =?utf-8?B?UnNoVjlCNlQyWWpWdGpHNVdOMTVBaHBjTEdtN2hmUjdlaUR4OWtlSkZGWjFS?=
 =?utf-8?B?azhoSEpjVStTeFUvNmx5Yk5tQTYzRUdMRE1vZUtqU3N4RzcvTUhtWkJQUjlR?=
 =?utf-8?B?V21QYVhQREMwYlMvd0I4aThWTml2Z0YxTnVsUytLVVJmWkJ3TnJpNlBIQ3Ur?=
 =?utf-8?B?c2IyWHlTZG9lVUx0SzZ3QkFtYUx6VDY4cjBXSU13Ym9aVzQyNUNHUnh4T0wy?=
 =?utf-8?B?NWFuRU8zYzI0UVhjWDU2V2ZRMThJNEFXZDFZbFNkYnFCZGZ5TXlnS2ZKTmlQ?=
 =?utf-8?B?cnBaQzl1dFhqcEdyZVlnWmdkOUphVGZOVURici9hSmMyTThKS2NuWitSTEtR?=
 =?utf-8?B?ckJ5VWZhNk8wdEo2aFJTQmQ2d3RUazFZSXB0SC90TUozM2Y3cjFMN2tQWURK?=
 =?utf-8?B?R2dXR0J5M3RhUG54WDRvanQ0M2t5dEprelI2TUJNTXZ2NnplUmVabnk4T28y?=
 =?utf-8?B?NTkzVytpczJCQjhCbmZ2a3lTcFErS0lVR1Z1c2grZWltVk5MQ3V5ZWVlUW03?=
 =?utf-8?B?ZVlwODZKVms0MGV1NU9Wams3ZER3czlrZWNJdllEb21ZSFl3QVN2UVk4SUwr?=
 =?utf-8?B?a2FvTkxpTXJqMEZPUm14SzlOWURuSW8xa09VeFB6NTVWbFRhekFUN2FLTjVT?=
 =?utf-8?B?QmdPc1pPaUgwSkZEVXQvQ28vNVBGNzlzN0ExZ29UUXk3OFBEcHowUm8wWXRZ?=
 =?utf-8?Q?8koZcVwRaY8TKNvxzqrnXzr2k?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99731c1b-dc94-48ce-123e-08dbc8d52e82
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:36:53.8144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvoiy8hpDBGSZNThRzeHfBTUS0NV6GoTHS00cNKf0kmKhJuWitwKnHxHB9hXTjM//T4VfN72jIBEfzsDaAfNnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7888
X-Proofpoint-ORIG-GUID: imv4NkUkQxT0ij93DHBCc71Ye9L7uO5Y
X-Proofpoint-GUID: imv4NkUkQxT0ij93DHBCc71Ye9L7uO5Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_12,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

migration_channels_and_uri_compatible() check for transport mechanism
suitable for multifd migration gets executed when the caller calls old
uri syntax. It needs it to be run when using the modern MigrateChannel
QAPI syntax too.

After URI -> 'MigrateChannel' :
migration_channels_and_uri_compatible() ->
migration_channels_and_transport_compatible() passes object as argument
and check for valid transport mechanism.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/migration.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f3e7c338ec..23c3a1079f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -107,17 +107,20 @@ static bool migration_needs_multiple_sockets(void)
     return migrate_multifd() || migrate_postcopy_preempt();
 }
 
-static bool uri_supports_multi_channels(const char *uri)
+static bool transport_supports_multi_channels(SocketAddress *saddr)
 {
-    return strstart(uri, "tcp:", NULL) || strstart(uri, "unix:", NULL) ||
-           strstart(uri, "vsock:", NULL);
+    return saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+           saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+           saddr->type == SOCKET_ADDRESS_TYPE_VSOCK;
 }
 
 static bool
-migration_channels_and_uri_compatible(const char *uri, Error **errp)
+migration_channels_and_transport_compatible(MigrationAddress *addr,
+                                            Error **errp)
 {
     if (migration_needs_multiple_sockets() &&
-        !uri_supports_multi_channels(uri)) {
+        (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) &&
+        !transport_supports_multi_channels(&addr->u.socket)) {
         error_setg(errp, "Migration requires multi-channel URIs (e.g. tcp)");
         return false;
     }
@@ -502,12 +505,12 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         return;
     }
 
-    /* URI is not suitable for migration? */
-    if (!migration_channels_and_uri_compatible(uri, errp)) {
+    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
         return;
     }
 
-    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
+    /* transport mechanism not suitable for migration? */
+    if (!migration_channels_and_transport_compatible(channel, errp)) {
         return;
     }
 
@@ -1776,12 +1779,12 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
-    /* URI is not suitable for migration? */
-    if (!migration_channels_and_uri_compatible(uri, errp)) {
+    if (!migrate_uri_parse(uri, &channel, errp)) {
         return;
     }
 
-    if (!migrate_uri_parse(uri, &channel, errp)) {
+    /* transport mechanism not suitable for migration? */
+    if (!migration_channels_and_transport_compatible(channel, errp)) {
         return;
     }
 
-- 
2.22.3


