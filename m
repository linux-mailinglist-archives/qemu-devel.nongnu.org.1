Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FEA70315A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 17:19:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyZyD-0006bz-T2; Mon, 15 May 2023 11:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pyZxX-0006bF-ED
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:17:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pyZxV-0008Jb-MS
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:17:59 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34FAPfAP016874; Mon, 15 May 2023 08:17:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=EGMB/1qyYX2gkYRfnqu7wgpLC38V5CJDOxGoNR5ytHE=;
 b=gcTmd7p3GYd70lpKJl2EOBe5rkV2spcLn/Nc3jiuYsuw3B9oVSyRK4BGffFpzZ4RBXW+
 qzAMVOits3xCyRJpVAXRTR3vDN7tlHQTkWktAt/LfYjRS0hVw6PG4FIZPCEsabQH7HYP
 tnES6bsHktiedopI10IXsE1tPxJd/n6TZ3m0n2hB2ZPX8Xb+LmhofmuYQnUkiVATldfT
 31DLc468+EjYRmeeAmgB27pNu7CXWqhpUyd5v4SZcWsRKMOQ9PdQFOS+EIo6jFmpFhod
 1GxkhyMHjqOYc0xAVUthqY1BYn7zA/3usyNpp4YvGnX+NG76HemEQISLDhAm1DrKjV8l xQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qj9vebtq0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 May 2023 08:17:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JY4AWd0+n/HKaBjAQFj1yEoVkex+D+smdBgDyswElU0YONCyrtWk/6DWeijllRubpY+iXsLUbmSxY3aszDYTDOaA7IlStlUtIG6uwgpcuiPWm5A2QJr3gRtX6Maa5jYUX7FkAJo82Q9emNLgdSPvNPvjSxkwszN+w7zvkSibbjVJd5STZnnGCFyUoqZV2Ey/h6aniuzkKokmryHExJrf+lqPAAiBRQX9oI23hme8yQKemS7NQYWvWYdTQbLWAGxB890o2in5+H7DfbJm4xSECqoWC72XnkaL2A5+r50TnfJViCuw3npL8aTT30/5Z5eJYFX7Kcw8DxgL2bamhAu3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGMB/1qyYX2gkYRfnqu7wgpLC38V5CJDOxGoNR5ytHE=;
 b=WR45KLVKb/tIfex3LVElXWgY0fZF3Almp63um9lowROjPmU9Wx5YPPO6N5ro9znCHsWV9Pwdznok0JhIhHTfRg+Wjz0z/eOsWIHrumkp1P7R1q7Kco9xWqk0WLonwYhacZVp71zRzC2xfVevliNYyDL2ZpHzjbRRmLg3GIIubpWeUuJbBc5VhZKQFGdSk8JMxiPQ8yhW+FdnmA6iH510tk9bDx77xtCzHXi/gNsKNMZJvt8dMqmDo4q2O1N1HiFM7hzb0OQZUxL/EGT/EwCJ2MGs0ss0QnDX/PnY4w5sWwr6ywq61iRjY9KzGWhXlO6auQzzGh00UlVzDDiVUexF2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGMB/1qyYX2gkYRfnqu7wgpLC38V5CJDOxGoNR5ytHE=;
 b=Qg/ipBTlV1lZgOkuIoA/KeQHudai4XhxXEWE53QAkMtBJKnm3xLfDTJCsxJ8ekMN7dtNtCaKE36ILy5zvXBTzSzNSJ/r5ZQx23LBIhyBCDMx8Z1am4/bO1GelxM0opqtW2CqePUcT338xQe3ntD8oO+1oLLilqtjRCuXJmasyHg8qX+0JLymPblsw6VSKtXhVPh2xAyw7FH+cpEfXdzSrc8qD9o267Awx1vZzsLEsJ1Xs4s9lpYz9o6vysNxiv5dYShKixDow4MmbqGck2ok5c+cRJS/X65JKpvzsnDw8+lRWHVyUWc+FO4nL29x3iQNPyGmI8JAr286Ppn0kLYopQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by IA1PR02MB9017.namprd02.prod.outlook.com (2603:10b6:208:3ab::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Mon, 15 May
 2023 15:17:53 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:17:53 +0000
Message-ID: <ef0e47ea-4860-8842-07f4-26d6a3144631@nutanix.com>
Date: Mon, 15 May 2023 20:47:42 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 4/8] migration: converts rdma backend to accept
 MigrateAddress struct
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230512143240.192504-1-het.gala@nutanix.com>
 <20230512143240.192504-5-het.gala@nutanix.com> <ZGIIVc83VbEMgUhB@redhat.com>
 <ae609793-7d9b-a305-d0bf-e8e9eb59d66c@nutanix.com>
 <ZGJIiJADoEOrLUVn@redhat.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZGJIiJADoEOrLUVn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::20) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|IA1PR02MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: 569f179d-db49-4692-fa14-08db55578dba
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mux/fPQ6VwC3fj3x/8SGLbGhDKX8k7lULBL6zUgTWlADP5acdVMtlXVtPhQZrpm/z1Cx0HVpaZyX9bBWDs6WbZTKgtqfrBevI7sLcYCihUkoQYC1KEH43AikeU630b+3TlEj3Bnoq7vyWiK/SPQR/JU5UulRWA0VDNlQuClv9I6YkZaePrPRBxfLKWXkYZgjM37XiO0/ek56ICN86v66GEjn0UUDUh+MBvirvhzItIw9m1CECtRv22F9GSJCStxduBlSTZY9fVPYuNxskZAtNZfDqxJ4nzXFVqCTh+ShC9QmdNWYSL4A76xi+c6wCL8yUWw4GcS21f1oiEsEOKHQs3Jjh9VFFrypfqOngWCQ0mShmX/cZ5WW4ymBZUAqR0BuM1aPFG3G4h7Hxp6xwgdM5Tjs3lOnDMYwjuOfVdVLQ6zr4zvbvY/FRptZMBu8d3FXc1OGDnLzMre6uwjePB08rtDF+zYIDv8wg53Scw8g8mdehR3AFyGzHCO6naBcUrTIr5YiingaN3K7BNnlW5TpidiV/a7PaYbCCaPUqoTcARtyaumA9GNL5FtM82mIp9XNSko/hrREVWe1fQeOyveK9wEPs41WTzoEBfs69bi9zaB0xCoZSR/ZLGEAatBdtgxVaceOVrPs51469QNa58c0Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(2906002)(6512007)(26005)(6506007)(53546011)(2616005)(186003)(6666004)(316002)(66946007)(66476007)(41300700001)(8676002)(8936002)(66556008)(6486002)(4326008)(31696002)(36756003)(31686004)(38100700002)(86362001)(107886003)(83380400001)(6916009)(5660300002)(44832011)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTk0bmZBVXFKNFJ2aE5zaUlEL2YzMHRLMlRkTUlhZjdLQ1d5eDFJcVB5ZHhC?=
 =?utf-8?B?dTYzWGJydisybmhYODhZcEM5MkZPSTFLR0tNVmdnWTVXczQ0cTA2S1NGb1la?=
 =?utf-8?B?RTAvaktPa1BkMmt5aTcvV0Fmb0RRSjVOWVM3QS9vVHhpU2pjU1QzbGZMcDJD?=
 =?utf-8?B?TlYvWTlMOUlIclFlTUVJR3ozV3dhTFdHdFFsczlwa3pxU0JMbjZCSjVyNmww?=
 =?utf-8?B?WHJReFlqVjB1UytMOGI1SW9hVDVqT3N2cDNtMHdZNWxOcUw5ZjRYSGlKSUFT?=
 =?utf-8?B?bWlESXNEWW9PeVRSSHZPbmMrZ05TU2dYUmtIa2swQzdzdGxTbGFyd1VVNlJR?=
 =?utf-8?B?RzJ0SVg5cHpRbk5jMWV4c0kzOEJhamh2T25UNk56YzhtMlVUdVVpakRyQ250?=
 =?utf-8?B?Nkd4aXVhNTVLRnFZOUE2NmtxNzFFSkRMa2RsOEFqTmhYV3o3WHUyOEJHTEQ5?=
 =?utf-8?B?aHFjeHJ5OFNVOUp2MVM1Q3RpY3VvWUNSWldmUDRjajl6R3F0cDJFV2xKTEYx?=
 =?utf-8?B?Ujg5WWFiNTF4OGdsVjAwdEFGbmY0TEluY1JMWUxRT2ZLc1VkSElHL0V2OXpn?=
 =?utf-8?B?alU0MisyRU82UitjSGNKUDdVTmhabHllUldEb0plY1oxZ3NHM2dPRW1CdnZo?=
 =?utf-8?B?cVI3TEY5dzJZUFBLUTVkRTJqbDZvc1pPb1RJdEFPSkJRZkhDWDB5eEY2YmFw?=
 =?utf-8?B?UW45WVBtV3p1L2FJNXRiOE5zTEppYU0zSEk1OHJPNVU5dDhzazBGY1V4ZjI0?=
 =?utf-8?B?a1Rqb2NmOXZQSURnN25mRzBUVEJIWnMxdlRuN3JvbWxpUkJpdVhNWGJiNC80?=
 =?utf-8?B?amdQSmVDaXZZemRjYmhzZHRWWm9vc1ZJMFpjdVJJNnBzQ2liejNzVFVibDNr?=
 =?utf-8?B?N25kcUxVSHhvN3p4YmVLVUIzajZUQnpuZkVvRWU0QlZHOG1BSXdUNVo0Wi90?=
 =?utf-8?B?RW0rcGVBTUFsRFFjcGpwN1V4N1MyVlhTTjFJUERtRWlZaVR2UjlTUVlaUE1J?=
 =?utf-8?B?RG1qVENhTWJiTmRoSVRlZFAxSDh5aWVVRWgwTFVwU2lSQmh2UmRqT0dnRmVD?=
 =?utf-8?B?SE4wbWZidU9Jdjl6VS9rQVBORlF2REFoR01qQngzV09RSDc1c1J5UnZ6NmN0?=
 =?utf-8?B?dGNMR25pUEcrOHQ4OVNQRlV6MCtDUkV5Y3o0ZmFPOXFXY3FWaVNhMGhZeFJr?=
 =?utf-8?B?T1lTUDVJcDRib3I0VmI2N3pQNi9mR0JVdEtEa1VjNXc5T1NnQ1pEU05NcEpt?=
 =?utf-8?B?U20yWFBKelpaL3ZFNVovS0hBc2M5dTNraEtxckRINUxIZHpYbVhvNmxuSVBa?=
 =?utf-8?B?cEtaTmEzMU0zZ21PUDE5QTYxZTdvZSs1elNHbDdWOEc3TmNxVDV3WmUrMy9o?=
 =?utf-8?B?SlM0OHNzTWRyMnpUQUhFQVFyaDFObmh3RzdCdTJDMmllNlJselFjS3VwSEVq?=
 =?utf-8?B?MGJOb21ZM1crM1F1azFmamFrRTNUTGRTL045d090c0RiRHhnL0h2SEsvenRJ?=
 =?utf-8?B?TFZmSFltY2ZrRnZiV25zNlFnZURiK1oxVzR5UGNLYWR0bCtzMXNJZ2tMZUNQ?=
 =?utf-8?B?bEZjeU1zN1E5aXJrSm91dFUySU15bFg4aUs1VWJ2WUEyZUJRbTBLWUN1Tnhp?=
 =?utf-8?B?SEJjL0tJaFRoYW41VkpvSm9ZTjN5WEJrUzZxeFNnRlpJWUp6ekV1cjJIT0sw?=
 =?utf-8?B?U01UN0NGQjhNNjlUK2NZWEVmUlo1R2s2MnRGUzY5VUtjRVk2d2JvU0RmU1lO?=
 =?utf-8?B?S05kOHRRZ2RTNmFONi8zQ1BiRko1cDZUWHQ2b3FWVDVjY2JEd0Z4N294NXhm?=
 =?utf-8?B?c3hqUEVLTmZwRHg5eHdLbWZhSnZqZVliUXhhd0M1ckNlYkdNbjBvRmsrK01I?=
 =?utf-8?B?TUpSbEZtTGxDMlIvblZIU1FaMEtLaEIxY2RNTDJEOWZ1N2tDWU0rK1EyOGZt?=
 =?utf-8?B?RHhxUldsc1VLTjVtNVA4TDJ0STVLRHQ1Zk1ZQVkxNnJVb0NjVmF1YlhtY0VC?=
 =?utf-8?B?bUM1aTFNNXIwZFEzWlJwQXF4bGZvM1krSWJFL29rWDM2OWNwdStxMjM1MVZw?=
 =?utf-8?B?S1k0bDF6VG9KZERnajZ0Mk9Gbzd4QjBlSk9FSWRqVFQzYXpURUJybzV6WHIz?=
 =?utf-8?Q?vy6y6OC+d6OY/4Hs7z46YVhy1?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569f179d-db49-4692-fa14-08db55578dba
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:17:53.5307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRW/oVjNinp1E1l/eAEPWMHd3/9BKVkp7azeyOQsj5tQy1nKC4cctaxAH0W8lWGf3UJyPLkkcQGnGbJKsR2o9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9017
X-Proofpoint-ORIG-GUID: mJaWxxuY99C6n0JC8J3MOs7EH0zB-Ykt
X-Proofpoint-GUID: mJaWxxuY99C6n0JC8J3MOs7EH0zB-Ykt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_12,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.811, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 15/05/23 8:28 pm, Daniel P. Berrangé wrote:
> On Mon, May 15, 2023 at 08:08:57PM +0530, Het Gala wrote:
>> On 15/05/23 3:54 pm, Daniel P. Berrangé wrote:
>>> On Fri, May 12, 2023 at 02:32:36PM +0000, Het Gala wrote:
>>>> RDMA based transport backend for 'migrate'/'migrate-incoming' QAPIs
>>>> accept new wire protocol of MigrateAddress struct.
>>>>
>>>> It is achived by parsing 'uri' string and storing migration parameters
>>>> required for RDMA connection into well defined InetSocketAddress struct.
>>>>
>>>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>>>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>>>> ---
>>>>    migration/migration.c |  8 ++++----
>>>>    migration/rdma.c      | 38 ++++++++++++++++----------------------
>>>>    migration/rdma.h      |  6 ++++--
>>>>    3 files changed, 24 insertions(+), 28 deletions(-)
>>>>
>>>> @@ -3360,10 +3346,12 @@ static int qemu_rdma_accept(RDMAContext *rdma)
>>>>                                                .private_data_len = sizeof(cap),
>>>>                                             };
>>>>        RDMAContext *rdma_return_path = NULL;
>>>> +    InetSocketAddress *isock = g_new0(InetSocketAddress, 1);
>>>>        struct rdma_cm_event *cm_event;
>>>>        struct ibv_context *verbs;
>>>>        int ret = -EINVAL;
>>>>        int idx;
>>>> +    char arr[8];
>>>>        ret = rdma_get_cm_event(rdma->channel, &cm_event);
>>>>        if (ret) {
>>>> @@ -3375,13 +3363,17 @@ static int qemu_rdma_accept(RDMAContext *rdma)
>>>>            goto err_rdma_dest_wait;
>>>>        }
>>>> +    isock->host = rdma->host;
>>>> +    sprintf(arr,"%d", rdma->port);
>>>> +    isock->port = arr;
>>> While Inet ports are 16-bit, and so 65535 fits in a char[8], nothing
>>> at the QAPI parser level is enforcing this.
>>>
>>> IOW, someone can pass QEMU a QAPI config with port = 235252353253253253232
>>> and casue this sprintf to smash the stack.
>>>
>>> Also this is assigning a stack variable to isock->port which
>>> expects a heap variable. qapi_free_InetSocketAddress() will
>>> call free(isock->port) which will again crash.
>>>
>>> Just do
>>>
>>>     g_autoptr(InetSocketAddress) isock = g_new0(InetSocketAddress, 1);
>>>
>>>     isock->port = g_strdup_printf("%d", rdma->port);
>> Thanks Daniel. Will change this in next version of patchset. Is a protection
>> for isock->host and isock->port needed here ?
> This will be validated later by getaddrinfo() so IMHO QEMU doesn't
> need todo anythgin
Yes. I will keep it as it is for now. Thanks
> With regards,
> Daniel
Regards,
Het Gala

