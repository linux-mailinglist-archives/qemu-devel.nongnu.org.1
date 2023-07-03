Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81141745FC7
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 17:25:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLQP-0004ch-Tf; Mon, 03 Jul 2023 11:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qGLQC-0004Z9-5W
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:25:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qGLQA-0001qt-4l
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:24:59 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 363EnaRW023322; Mon, 3 Jul 2023 15:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NVYkLEO75TKEfcKr+1OtcgsNW7KR3B8zaozE+KvF2T4=;
 b=PfAUon7I9ylz9fic6UZxgNSrSHXhy/OqgbK5pftpHFszRSKYaygFKOzOR6kWDtxGeSjZ
 rgoYt/r6itqxvtJlXcWZAZH/JF5b4E6lU4N2oYqaKb0MC/ZlvgB4iPAauswmDCgj98WS
 oS8r+bL3JnNqgY6QG2adGWb1NbK4wbGVvcc4Y+p9KS9NL/TzWggeuRQnK5eTEy4pG55Z
 31ptDNJWYKvbbk5S+SFl1CtbPRjeftWTkFngEWPuOBBh4UVKwhz7gi5g3AisROZkC9AC
 5ddzAcDRUn4HjWHSqN2Cm40NaXnvTJ09gLskcYjON3ekMh0+dQiGXxgRyTLiyQpcVJgb FQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjax3ayw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Jul 2023 15:24:54 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 363E0lmN004132; Mon, 3 Jul 2023 15:24:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rjak3q8rq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Jul 2023 15:24:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCY2JBmSOpcNYCiR8WkTL0xg8vO7pTpdB8A3mSyUqfP7DxLdjt15ymms0rrKm0Rc1dUwHXthq/eRsSkzOvc1AXzewWPj5qVQyYAQeHp7LN0n+8b9m6MtEOV937sdC3S3FzLOYuqIf9RWbuDwbxD+5GWfwXLhJdx/N1lOR2eFA+kQNaSr+9oDHSt4sl66KpY5fvbb3ZlGcVvQUKv7EN8LEwZ0NkOduzoE9i52bMT/GYga1w3Ej/XJZxV5gAZaGpFqHtySQAOz/QuEiof7NSSRyu/8bMW0li0sUZclkE4zvuehCK9OMDaw7qnnit1EObGAYtwjJV6sK6p1dQt+sAN56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVYkLEO75TKEfcKr+1OtcgsNW7KR3B8zaozE+KvF2T4=;
 b=jnTSBK/BuKK3cRt0V9JxV2Hd9Hg3C/59od132CavbfjZDUrSFtSbM6n2ffIddvrfgwJCIdFwwAyD09z9h2QUghZURQQjX380x5ASUkwMQWU2dJtfJwKdgYOGL3Smleg7gxSEmujQKAu23er5VTj2vP3VK579LLtKzX654KBW/VL/6OY+rsYJaXu9SdC20FQ+7c2Eef+a5mGFt551DkSPPoAr4jXqlFjtkM6TUB/merNVQu9ETgkyT8vOUsAL3fL36HITVY8+/qO105YpkRBijrTLI/r+hShTNsmt5t4l9xIp/RQ00r1UbhczS5vLnrQGMc/ARON6oSjs6yT5wOF5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVYkLEO75TKEfcKr+1OtcgsNW7KR3B8zaozE+KvF2T4=;
 b=oyRuOmCWvxmR51yOO1VQ7tekVK2ok0bcDMLTk6r/mgLxNnzQd8aDOJTqTEmaghESfpyXY4edny6rwfXnGWVoy7mjdnQdgqty7MtT/xZexsCWqTwCw6LPUfzQ01VtgNHOipiPCvQH9wJvY4JYB+LOdjO5iJIvZmZ63bNXo96mAJ0=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by MW4PR10MB5809.namprd10.prod.outlook.com (2603:10b6:303:185::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 15:24:51 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 15:24:51 +0000
Message-ID: <3a4865de-da3d-f012-377c-94d2ba0988ce@oracle.com>
Date: Mon, 3 Jul 2023 16:24:45 +0100
Subject: Re: [PATCH v6 7/7] vfio/migration: Return bool type for
 vfio_migration_realize()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, avihaih@nvidia.com,
 chao.p.peng@intel.com
References: <20230703071510.160712-1-zhenzhong.duan@intel.com>
 <20230703071510.160712-6-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230703071510.160712-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::16) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|MW4PR10MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: b6028355-f402-49b6-5f89-08db7bd9a51b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3aYdNrOCFejLiTKsECvy2enFA0mJVDMBhT51Xt+lz51L1yE6BHJqKBKghFjfH9cQpyrFzuPok7lBU/YQrB/Nxon9GybYP0rnNPagllmq8R+Wp9eQkP9F8oqjzTs4Hz7UQOjSIwiFFUuJwpE48EtEKpU3vX+xqDdoFfazQKzAr6n2xgq9WpjdmRPMCr0uBdNDitM2RIVEfr14ZGu+uBrEtATFQR64d9H1jAOZ1gRiG9nvdc2f9Zn94873Z4NqyaJD/yI7X7IDyMjorwmsPFMBtfIjttolklU0VrX3BiSIQg+/QDdG5XzAeF30yIPdvEHAbGbofs3yeNLVoD6JbWbhNp6z3prdxxkx5pOoHvzDEXzYr/zXz0QyU5F314zi1TiGf9xFZPUVkt0e17RCe/1FHTUshBkDFo4S0gNc/BxH6jqGP0QjuVurBFF5vd8zzasa6PZKjHUJ6hAeVhejnI7yjGKDv5VpeIlzcR5A58PDwIzHa6/Ml6yAy2U5EFXMoft53wC2s9f0tCwODgMZqmtakCaoJVEweKXcOK185pGME2kxQuNiBRbZVOYeyf2Q42HIFcfsOG9R4FUFQc+vzvNu2tlHJtK+fkqQh9QQ74KMv0GuTwRNtGy27B3xEccnXKk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(31696002)(41300700001)(38100700002)(6486002)(6666004)(2616005)(83380400001)(6506007)(26005)(186003)(53546011)(66574015)(6512007)(86362001)(478600001)(316002)(2906002)(36756003)(66556008)(66476007)(4326008)(66946007)(8936002)(8676002)(31686004)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVhuZDk4U2cyeHFwMENjU3dJNlMyUUhadkFjMERMeGFjdFpkbjdpZXozYkVi?=
 =?utf-8?B?SUNOZWhEbklkN1hQYmVOTG4zZE5aUzNKS2JVVmExUFRuVXFJR0Z6MXg4bUJI?=
 =?utf-8?B?cnlsa0Z5bWJ0VEJKZG91enp5amFqNzlXTFFpNTJsUkxVVDZhNDR5dUowdmsv?=
 =?utf-8?B?WnhFTHBYZ2dHOEd5WlRGQ3lPMTkzMEh4RVVlZHJsOW0xd205dHByTzVmUnFs?=
 =?utf-8?B?Wmx2UGNHTGI5U3MxZlhWYXBaSFF4NmNYL1dFOUprbjhVOGorQi9weGUzdXFY?=
 =?utf-8?B?SUlsU0RKMGNxVjVIVlJEZ0V1Z2FRaWtCTWEwMk1QZlNUYktCc3YwZ20ySUVM?=
 =?utf-8?B?TVo3SElEUm1vVUxPQ2k0L0NTVW9VTVc5bkdWWGpQLzJuM0VIV0R4bjZFZVhM?=
 =?utf-8?B?eDNoWmF2ZjhZeTZ4eVNOQWo0MnRrN3pZWGlQTWJ5VDMzS2dNU0k4WEZ1TE5z?=
 =?utf-8?B?T3RVUUlGUlozZzBPT042b0xpSXNHamJPRkliSXpKQzUyK0N2UFhPREVyQTNp?=
 =?utf-8?B?bGwzYUhxTHdkUnRySEZwcmxNNEsxMTl1S2JVVmJjUVJsRmcwYzBqeSs0eXk2?=
 =?utf-8?B?ei9EaUJmZ3dYSHdSM0I3TTZRRlVnZlcraUdmWkZKeXdHYWhXbXFWOXUwNXMr?=
 =?utf-8?B?NHZvS1FsNFNSMjJQM0ZWRmIzSnRuRjgzNmFjcHZGOVo0VHEzUHF6QUNKUENU?=
 =?utf-8?B?MStHcWRIWFc2NDFjNzdjMGVSUTd6RnIvT2Y0ZUtXMkNOOXJZb25CdHJNa2Jl?=
 =?utf-8?B?aVlvOUY3cDYzMUFpZUdtQWs3WXkwcUszblU5N3VkUjduUXhaWFE1YTVzQ1pz?=
 =?utf-8?B?TGdSeExRR1pkbWxYVnY1Z2l1aEwxci9jSG9MWXE0czBGZmhRS1VwbTRoRTB0?=
 =?utf-8?B?bU16bXVzZnFKeklZSjEzczRFOEpydjFFbFZQVVAzekVkUGxHdGQ3ZWVyL2Mv?=
 =?utf-8?B?Ukpxc3B1cktqVzIyWkVkYTE1MVBFSnppbE9ZdFIvcDhXVnBBVjVUTVRjUHc0?=
 =?utf-8?B?d2N6TWJRMGxVVis1c3pZZjFGcUcxY21CNnY3WmVpeDQ0b3MrdW8zUDJtaU1Q?=
 =?utf-8?B?ZWlGR3R0UnJLT1hIMkFINnk0a1VhRUJHNjk2MTRvbENpSi9BZlU4MDFDekZi?=
 =?utf-8?B?YzZVckJGOVVZNGo0aUJFUGJzZXVoWDR5UDJVSmtoSWJodS9lZ2E0a1N2MmJE?=
 =?utf-8?B?Y3ljVkZuOVlvV0U4MHZSQWNwMHJRVkZWVjcvWlBMQWJkZ0hDQzFpMk5EcGsw?=
 =?utf-8?B?dlBac2hyNjAzSDBaWWh5SHBVOXZocDVPZHhoazgxWGxEWGZCWEZUYVNMbi9L?=
 =?utf-8?B?bUhvTm84bjA2T2cwR3piWE5vYVFsKzBrczg5OElCVlpRUGhPS1B5bHk1YnM3?=
 =?utf-8?B?c3N6ekdFVDU0SUtXc1h0RGIzMysydlVBMXRUNnVSSjZhT1RxMkUweFNjTERY?=
 =?utf-8?B?ZDl3d2gvZmVDRmdueXRYUUlITXdtTzZDdEJSL1BkbG53ZWF5RFVjYnFIYmZi?=
 =?utf-8?B?RldlUGhRR1c2YjgrZVpIWFJkQWJOQll5QzZxdEN3YmZtSjhyem1yeUdaNzJ1?=
 =?utf-8?B?Mml3b1IzN25aaENxTStSbG9lTXNpWFVFa0dOeUZnQ2FocEJVaEZuK2VRb3dP?=
 =?utf-8?B?aHo1ZDJ3M1dwVG5nNVNqV09KYWZTSU9iSHQyR2FiUi9OaE5udm51RFE3M1p6?=
 =?utf-8?B?M3J3ajRkTXdPZHZXS0hWSVFBYTYxUmljbVZDQnBxMEVhbEtGSllMaUpqZVI4?=
 =?utf-8?B?TDZvdTByeGdQTEJjMitqLzBSMjFmSnJVVkwwTjRDSGdSWkFtYk5iQ2FUQ2tt?=
 =?utf-8?B?NG41MllROGtUc0pmd0FwNzlaU2xyMkErK0RQVUdIVWQwdUZjM2hPTGtiZEtH?=
 =?utf-8?B?bVlaSGFIc1h4WGZCOUpFTkViVStQOUxpR01VZFlmZUo3WDRIQll1RGpla0xn?=
 =?utf-8?B?dFd4bkV1TVdvZjhSSmsxaCtEOWF2SWg5THEzMTRVaXhVVG11c0VOQXpGZUly?=
 =?utf-8?B?WE1pMTBxMENyUTVROWRWbHluWm80UVpNeFZKVDJUWk5oeFVGT3QyK0g3azhr?=
 =?utf-8?B?KzZiWjA0ZGIxSUg0NzhMVEpKRVpsdXFKSG8yRW1qTmZnbm1mcXF5Wm4rOXVT?=
 =?utf-8?B?VjFKa29ZOGtySVBiQ2JnK0lTNnlzbm9lckkxVGh0VVdrTzRLV2EvMGVEaDRM?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GMrr/fWt+YFCtGgLoz9m2b7Xj7WVGtxdZA8ogD+nBEXJIZjHSQsMgjd24cR/cN9TynQttJp8iJezX/tuS6c8bCOvd5f6NHrCPmIMvqL3vXzzA938V77urvB3wquXTPd/32GAfekImzlqMbZ7kly57z1d1P8AtLU18FSqxaR37JvLaOYkS6yUkXSFr1MXojK0bnnAdp50lVaMDjTzo7njzTUG1MjpCJJ0JoFxNQQKJJrEiTBlZCJ4KCP5rht3ph78SPxWwqtIAUBbsxk9SgRgs5022j09QGeb0wWvplm4PeOvH0th9CRS21ROu2GfhjWrKDBaHA1ALuHlCQJ7xxcf0dB6JRsl/3hQQ5nSDTUIvIisxg3PsTs+bLlP9Dt5P7XOlvzXj2apSSD3Iau1p4ccTizRuaUKUmSRssTH9LbgK4D5gfe52zdVz5Tt5y89jqh4jik+bJ2EGNFX7skUnB233ogthHzh/J7ykkUcgI91CZmAXwlDuGN/pAoFGP54ELqyDTIq9Cj59wYkLlLAPjK8YXbzxRVl81k4jhB21+uUJq0FjFQUK27j4PVH3wXu2N92iVPAReqJCilbk10LMx4G4cENS4N9+6Olyq2iWiEBaSFMUZo+O1gRboM6DR7CFQknkaQtvF1RLiDPs8+BihQNUBy9UPOoQvH3rbZlMnIUZkaeH1j3OxM9nZdDS36LmJ2CNkK5knh7Hgq9/i6jn48Uf07SRZXFtd3ESuML756urA+AOF8NV64/ynNjuMEa0aK+5B/sdrXCewF1+VQ4TS5+iFJVlNSXgEx5YpYPp5lA1wFG8SGFpXKoX8cq6XmzU7mq+GNmx6tYfYZjgnQ7TAZAww==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6028355-f402-49b6-5f89-08db7bd9a51b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 15:24:51.2833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RdYl9mIvMvjh/OnDvcicC9BI1xSQV4Ha6wqz6aal9AlWI7IW917LzT2DMHZJxcQrqGRXbVN8SJbRax3FGBDER0t46YKWG7E2TjbTfONicI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030139
X-Proofpoint-GUID: 7aOgkQd23FGFd8hVZ4Lq4PWs2183ro13
X-Proofpoint-ORIG-GUID: 7aOgkQd23FGFd8hVZ4Lq4PWs2183ro13
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 03/07/2023 08:15, Zhenzhong Duan wrote:
> Make vfio_migration_realize() adhere to the convention of other realize()
> callbacks(like qdev_realize) by returning bool instead of int.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Suggested-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/migration.c           | 15 ++++++++++-----
>  hw/vfio/pci.c                 |  3 +--
>  include/hw/vfio/vfio-common.h |  2 +-
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index e3954570c853..2674f4bc472d 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -846,7 +846,12 @@ void vfio_reset_bytes_transferred(void)
>      bytes_transferred = 0;
>  }
>  
> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
> +/*
> + * Return true when either migration initialized or blocker registered.
> + * Currently only return false when adding blocker fails which will
> + * de-register vfio device.
> + */
> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>  {
>      Error *err = NULL;
>      int ret;
> @@ -854,7 +859,7 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>      if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
>          error_setg(&err, "%s: Migration is disabled for VFIO device",
>                     vbasedev->name);
> -        return vfio_block_migration(vbasedev, err, errp);
> +        return !vfio_block_migration(vbasedev, err, errp);
>      }
>  
>      ret = vfio_migration_init(vbasedev);
> @@ -869,7 +874,7 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>                         vbasedev->name, ret, strerror(-ret));
>          }
>  
> -        return vfio_block_migration(vbasedev, err, errp);
> +        return !vfio_block_migration(vbasedev, err, errp);
>      }
>  
>      if (!vbasedev->dirty_pages_supported) {
> @@ -896,7 +901,7 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>      }
>  
>      trace_vfio_migration_realize(vbasedev->name);
> -    return 0;
> +    return true;
>  
>  add_blocker:
>      ret = vfio_block_migration(vbasedev, err, errp);
> @@ -904,7 +909,7 @@ out_deinit:
>      if (ret) {
>          vfio_migration_deinit(vbasedev);
>      }
> -    return ret;
> +    return !ret;
>  }
>  
>  void vfio_migration_exit(VFIODevice *vbasedev)
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index eefd4ec330d9..68dd99283620 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3207,8 +3207,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      }
>  
>      if (!pdev->failover_pair_id) {
> -        ret = vfio_migration_realize(vbasedev, errp);
> -        if (ret) {
> +        if (!vfio_migration_realize(vbasedev, errp)) {
>              goto out_deregister;
>          }
>      }
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 45167c8a8a54..da43d273524e 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -252,7 +252,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>  int vfio_spapr_remove_window(VFIOContainer *container,
>                               hwaddr offset_within_address_space);
>  
> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>  void vfio_migration_exit(VFIODevice *vbasedev);
>  
>  #endif /* HW_VFIO_VFIO_COMMON_H */

