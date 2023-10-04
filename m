Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F0B7B7969
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:01:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwn6-0005Bt-8G; Wed, 04 Oct 2023 03:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwn3-00057Y-R6
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:29 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmo-0006Mg-TF
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:29 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39418rdg001163; Wed, 4 Oct 2023 00:59:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=oJ5EX9EKG0HkvFwRHhF2aiRbWcNp9jX3HMH++lQaC
 iQ=; b=mBa6fe5RsN8/VUsJfuMJKtZ+dsqiHfO1tF9jHvVnaypzM6HEyWhM8U/iK
 vGJg03w1pu2uxWj8dtxe+tTgzmxItLMhi3c8/0jvofoQhoVup+KKBtIm4TrjExsG
 LHq6ErHWDnL42GRHSbNk9RnVqUQtQasRN96nUa7RwfeiN6otTMjFYvdltC8duyNT
 TpYU1nSPdrQlJuD9nlXafN2OULFS0A1AoMtyYtJepnFvTMQ760USOdwT+h/jYKlm
 gerBGnRQJ/dBRIZPBBqqcBjRaezSaq6yj+/BX6VbmGDawz1dFKCXop8oW0SNOLn+
 F8A2RLmrW/1/YWc/ZTeSyw4d7hTMw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3tejrdeh9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 00:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnEOJOgV4caIqhTm0WZODRCgTZodlQP667xZoz55xdhdtjhvcoKUtgVd6qY3lDLbxYenf7VfzUAiMWeBktyli2Fo8XIupcDVjqrglpUnU9R/uZk4fjf9UuiOV8fbNg5zEBwpKHj6UWDnG2tu2NwE4273OUhuUVT4qujPUw/HtRJAu0PKoHej/pP0yt4jiLbjdtW1rBPlnbG0rndRA2EvkxjSg1R7DXuLp75oXsJC+cSCgSaxeMNP7kxl7IbySd/wt7Ww/sspPtDA4j7qIqTSTqI6vgDSboonczeCsjDkGnSCSjte68cDr1W/uEckRa/hBSQAiovPtrqB7+fwu46ZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ5EX9EKG0HkvFwRHhF2aiRbWcNp9jX3HMH++lQaCiQ=;
 b=AsIvnxkHR7K354j5vmj8n0MDK555y8wuRYo4Ph1i5w5jdw83JyNeHT/Lf1DCPR2NxufO5kI2FcmE82PKPuMaH+zxhts1tiB4SbT0ywbgklz0ykmCMcJdTwHNz4NBC5uVuL2Uoxk5gnMFFDfEmuFs1eWwUymq1ZQx+u5oqh6msB+qvSDtZIbxkMfngEsN7Ln7ASjUOr4bZmF3JI/GdAVCBj67/r3y2CHZowUw+E6JSUe2ccxjofKjx508YGScvZgIG0zjH1lJqCycMQ82+0H6Mxtkq652FV8JIfCXzv5213Wm8v3a8ArcDaNtLvBEQx3OIIk4oHGs2fc9t0HnrnBmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ5EX9EKG0HkvFwRHhF2aiRbWcNp9jX3HMH++lQaCiQ=;
 b=mmI0xGMPApSBKzzZsa9U7sVSp3xAZPTC6gtxZgVRgM0jqqfvFNV4/UWA9AHiAPE1EnnyOiUygx9F9AUqO81fs7eCz1Ox6544dN6Uy8aclszLP+BfT+FPFPsx9a9+a8eVqSEpIr+BPTD9xnjSsIazOh0tnjbdPJHfnHRBIcvCuHVjmpzMVuF+4/4ev/yAa08GjihSlfHxeSiw9e8e6aDiAxsglIBrtcnmFdBAy5ezcIcqX30S7oUAxjcKiD/3X2YS1xcQ9D2YewpKiwC3ApAFGZMBnBRvhRtiJId7ggWbjnpeWcQPsWfp5N+z/d7zZRekTaMTwtRZsLb5hHmtrVelTA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM8PR02MB8294.namprd02.prod.outlook.com (2603:10b6:8:9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 07:59:11 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 07:59:11 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v11 08/10] migration: Implement MigrateChannelList to qmp
 migration flow.
Date: Wed,  4 Oct 2023 07:58:49 +0000
Message-Id: <20231004075851.219173-9-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231004075851.219173-1-het.gala@nutanix.com>
References: <20231004075851.219173-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::19) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM8PR02MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 593a0a56-7db5-4143-e5aa-08dbc4afcb38
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jq7cCV7sPvmKJk9b983VPur9Dp0e0ycJqVxYsxp4LfeT6jBnLrEuXYWlsqttLMo1/SKWzeDiTBsMYjN7BjtStAPVvALkrSQGjb00suSlwDZEU7v+naN/eHg6/PCc60/yEXvRy4TW3b9qkCWk76tCGZ8x4T72UhtYMfafSxljy2Y6GTKwCMIqpOtwEGp4k5eAL1+lW8L9RlRgHlRHjXB7zFZfK6fZqVPvKquK6WVo+BkNpFxf/EPntxfJaKnagRrjyuyP0KtJ7aS2VMdSTAWah4+jTIl9SohGr+2dTcgLHiP6fh873mFeKeB15xt14A1spMXzO9N9dWrJeDAwVBkH2CRNlzQTjAgoi05vyqnkkGv27ikcYYhisxH7E+y1Fg8DMeNoHN1CVNcVA9qWYB/anZfZ4uB1YDWxrtBTKWHY+yNV2Nf/EWHB+2aoIHjSJrDnob1svPYmPXUr8CoBhDKjtVxz0A++uoeFulh+bIZPpy5diGCiNmO66FybuWNPYkO5fgKtfFSxFdKv9o0T3lqW+JUraFnpVFudavO9K1xf98ei98YgKdsasjgQnWw1M461/RHbLj/zHKAkK6uG5JhSdaAVtsuBHntVXi0pNypn6xa6ti+ZBGrk7KyuwC3d3MUw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(1076003)(41300700001)(107886003)(6486002)(2616005)(52116002)(6916009)(66946007)(6506007)(6512007)(316002)(44832011)(66556008)(66476007)(8676002)(4326008)(5660300002)(8936002)(26005)(478600001)(6666004)(2906002)(83380400001)(38100700002)(36756003)(38350700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUVoSkRiekhrYVRqRkMxd0NpNGlFdDQzdGF3TFdYVEwwN3d3dSs0TlQ5LzBz?=
 =?utf-8?B?ZGllVnVISUpYL3ZhVGpESDRMbUppUk4wbXJiZTBhMkJVWlovNkFETnZBN3U4?=
 =?utf-8?B?K0ZOVUp5bTVpa080VWxaY1dyOUtxQ3FNb1J6L2I1OUZuTEd0dnl6dDFqZWV6?=
 =?utf-8?B?V3hjSjB2SHp1TnhtYnFsazNGRXhaalZyWkRrYWx6cUEzeXlqbjI0Y3dpRm56?=
 =?utf-8?B?RWp1NVo0OXYwdFNhMkJtSFZsYzRTN0RyR3pJb0h6Q29jbHZpR3NBaWJwN0Zk?=
 =?utf-8?B?aEZMNFFEWjV3WDhmUU8xRmVvbEpFckhoT0FPZms5MVdMMXR5eWY1WVViM1Vi?=
 =?utf-8?B?Y1NhU2hoaVdHc2VWL3NPU1dUSVI2TkZ4MEtqakxJV3gzck1OK3p4ZndzQTFa?=
 =?utf-8?B?dlNMTWYyeWllSnV5YlB3U2xQZE9uallVK3laem40UmxCWXpWZWNlbUZMN2VP?=
 =?utf-8?B?RnhIYWxsSzJLYTgxTGFrdDhLSVhqWlBFUFlDeWo4T1BSeGwvc1gxYndvOEtt?=
 =?utf-8?B?NU9TdXBJUi9QNEp0c2FzZ0FCM2x0U0lsSjlrb0VDYkxmVXpIVWJVUWFTSUhY?=
 =?utf-8?B?bVhSVWpHckZmZ3ZYeFJlcWF1bGJGeHpvY296RUZRUDRON0VZZ0RLNkpOZ01G?=
 =?utf-8?B?QWVYYVR2RXBPVGJ1bG9oZkVyT1lVTTloS2hGU29RR3JCZ2ZNZEg0QnRRV3Fu?=
 =?utf-8?B?SFNJNmduOSt3OVlGSWs3MWhkVFBDdXkxTHRreW5ZNUVaamZZSzk4TnF3UmVx?=
 =?utf-8?B?UUNNbHRLOUh3TGljclBjNk1pT1owck5ZcTF2T0ZjTjg2MVMrYXVDbi91U0or?=
 =?utf-8?B?dmRueXZjOHpWRGVWQ01pVE9HaDFVVVhFUllkUCtiTzFtUURUNFplUHRhTTlj?=
 =?utf-8?B?aXpIVWFtNWk0RWhXd0Y1M2FOTVJVajhLdVJ1MGZRL2VSTUlISDBPeEtGUDE5?=
 =?utf-8?B?OXN4Y0h4QW8xREwwMmZrR0FkU0VwN2JOQmZJWVg0TjgwNzJvUFE0VTAvVHdG?=
 =?utf-8?B?aWtmcmJQTW1Kck5FYWpBeUY3S2tyc0NPc3c5SUtuSENjNGZtN0s5cVY4Qit1?=
 =?utf-8?B?bkxHWmY1NDVvM2ZvL0x0cThDWWRCVVdxcDUvV090SXFNMkE3ZjRsOW5aRW50?=
 =?utf-8?B?eHZuWEZ0dFVFbkJlU054bzVBdW51UFM0TXlFS01WVjlGY0Y1b1Q1RXVqd0hw?=
 =?utf-8?B?Rkl6cHFDeE9helVNRTJJNE5QNTExMnhzWGtVMFZRVVNZQUgwLzMrT1E5QTVv?=
 =?utf-8?B?V2l4RWNJM2oxRXMxWkVqKy91OUo4ZG9yY2d1UlJyWW5IbElyWU1ka1EzbHBK?=
 =?utf-8?B?ZHRkWGJEL1RzeC82aU42ZHN2U1l0dXJna0ppZFZIdU10T1RPa0ZySmJsNklR?=
 =?utf-8?B?cTJGS044akNYa1BGSDdFQkZ4Z1VzQWIxVUliQWptYWV4cmQvUlVUTnVlTE1m?=
 =?utf-8?B?WWpOSlV1TmVlZE56QXhobnphSmJ0N0c1QUw1alFaSUFOVktWOWplK2ZtMU5T?=
 =?utf-8?B?WTYzWGVsampOZWxBbWVCSEtLTXBlWlMwNkVyNUsxWktvRyt4SVNKQjVXYWhh?=
 =?utf-8?B?T0pLNlNaYUFjR0g5ckQrS2syUlFLYStDcmRGeUQ3bzBCbFZrMmt6Tjg1NXVh?=
 =?utf-8?B?cEEvN3VRNmoxc2hUSGltMERaclZHRXJXNTdielRrYVRDNHcwUVRCOVd3TVNy?=
 =?utf-8?B?WVF6Tld6ZUpXNC9xVzJGRFhXM0hLdkhzd05nMEp2Ly9PVjExUVAvN09HZUdy?=
 =?utf-8?B?MWdvTzA4bGh2SC9teWNaU1QzOHpDREVxQTNSK3NtOWlZUDhSVnpRc3NNNC9B?=
 =?utf-8?B?T050MDlUN1ZoUHRJVkdrMFcyNWxYMmE4d3EvT1dDSlAra1pjUW5OWGk3WG9y?=
 =?utf-8?B?TlVhNGpkdmxWR1M5VkZmWEFvZXczeUp0dkoxMzc4eUF2NzYxVkQ2L1FuRE80?=
 =?utf-8?B?OGxsUjZKbGNyQ2tBaUk4M1gweHcydjJvV01CUVV3TFgxc0JtdlZOSFB3c1FY?=
 =?utf-8?B?dlZwK2dRczhSMDBoSVJuK2dKZi8yZ24rUVdKZk5iUEJNRVJ3TEk1VnkzNVg5?=
 =?utf-8?B?Mmt3Smx0aUJPVktWMFE1Y1hRTzJHSkVWYlZXaUdacWJUdHhiTGMwa2FLMDBJ?=
 =?utf-8?B?dDdBNVAyajZlYUR6cjVOODZ3Szc5R2pMTjlNR1VKRzkyY3FVMTN1algwWGg1?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593a0a56-7db5-4143-e5aa-08dbc4afcb38
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:59:11.2399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4HdMRM+JYsiRScraTVJSfh6p45ow8SqOff+rq0YAey+MVbzxt++kJIa1zvCxc0O1+bbP0GIpHCLXaoCC0rrbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8294
X-Proofpoint-GUID: ZDTYD-Op4AXSZBiJPgB8hnCkxy2fg-Fj
X-Proofpoint-ORIG-GUID: ZDTYD-Op4AXSZBiJPgB8hnCkxy2fg-Fj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Integrate MigrateChannelList with all transport backends
(socket, exec and rdma) for both src and dest migration
endpoints for qmp migration.

For current series, limit the size of MigrateChannelList
to single element (single interface) as runtime check.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/migration.c | 95 +++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 43 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 6f948988ec..3eae32e616 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -432,9 +432,10 @@ void migrate_add_address(SocketAddress *address)
 }
 
 static bool migrate_uri_parse(const char *uri,
-                              MigrationAddress **channel,
+                              MigrationChannel **channel,
                               Error **errp)
 {
+    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
     g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
     SocketAddress *saddr = &addr->u.socket;
     InetSocketAddress *isock = &addr->u.rdma;
@@ -471,7 +472,9 @@ static bool migrate_uri_parse(const char *uri,
         return false;
     }
 
-    *channel = addr;
+    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
+    val->addr = addr;
+    *channel = val;
     return true;
 }
 
@@ -479,41 +482,44 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
 {
-    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
 
     /*
      * Having preliminary checks for uri and channel
      */
-    if (has_channels) {
-        error_setg(errp, "'channels' argument should not be set yet.");
-        return;
-    }
-
     if (uri && has_channels) {
         error_setg(errp, "'uri' and 'channels' arguments are mutually "
                    "exclusive; exactly one of the two should be present in "
                    "'migrate-incoming' qmp command ");
         return;
-    }
-
-    if (!uri && !has_channels) {
+    } else if (channels) {
+        /* To verify that Migrate channel list has only item */
+        if (channels->next) {
+            error_setg(errp, "Channel list has more than one entries");
+            return;
+        }
+        channel = channels->value;
+    } else if (uri) {
+        /* caller uses the old URI syntax */
+        if (!migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
+    } else {
         error_setg(errp, "neither 'uri' or 'channels' argument are "
                    "specified in 'migrate-incoming' qmp command ");
         return;
     }
-
-    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
-        return;
-    }
+    addr = channel->addr;
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addr, errp)) {
         return;
     }
 
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
-    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -522,11 +528,11 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
             fd_start_incoming_migration(saddr->u.fd.str, errp);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_incoming_migration(&channel->u.rdma, errp);
-#endif
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_incoming_migration(channel->u.exec.args, errp);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_incoming_migration(&addr->u.rdma, errp);
+ #endif
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_incoming_migration(addr->u.exec.args, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1750,35 +1756,38 @@ void qmp_migrate(const char *uri, bool has_channels,
     bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
 
     /*
      * Having preliminary checks for uri and channel
      */
-    if (has_channels) {
-        error_setg(errp, "'channels' argument should not be set yet.");
-        return;
-    }
-
     if (uri && has_channels) {
         error_setg(errp, "'uri' and 'channels' arguments are mutually "
                    "exclusive; exactly one of the two should be present in "
                    "'migrate' qmp command ");
         return;
-    }
-
-    if (!uri && !has_channels) {
+    } else if (channels) {
+        /* To verify that Migrate channel list has only item */
+        if (channels->next) {
+            error_setg(errp, "Channel list has more than one entries");
+            return;
+        }
+        channel = channels->value;
+    } else if (uri) {
+        /* caller uses the old URI syntax */
+        if (!migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
+    } else {
         error_setg(errp, "neither 'uri' or 'channels' argument are "
                    "specified in 'migrate' qmp command ");
         return;
     }
-
-    if (!migrate_uri_parse(uri, &channel, errp)) {
-        return;
-    }
+    addr = channel->addr;
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addr, errp)) {
         return;
     }
 
@@ -1795,8 +1804,8 @@ void qmp_migrate(const char *uri, bool has_channels,
         }
     }
 
-    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -1805,11 +1814,11 @@ void qmp_migrate(const char *uri, bool has_channels,
             fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_outgoing_migration(s, &addr->u.rdma, &local_err);
 #endif
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_outgoing_migration(s, addr->u.exec.args, &local_err);
     } else {
         error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
-- 
2.22.3


