Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7939715900
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 10:49:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3v1y-00052Z-RC; Tue, 30 May 2023 04:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q3v1w-00051Z-7E
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:48:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q3v1t-0000gM-LU
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:48:35 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34U5l37w022460; Tue, 30 May 2023 08:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NBsC5dwka55cUgW9ffOLNVTo8cOOevgxHToXWQNwba8=;
 b=DR/h0rJuOhfqgTfDlSJvHC0nGhkwZKmj1wkshcH26CfRVnA/1vmkw8aXklODRFOJjTOV
 PIVIb+GhwDYGXDtCdtmLXyu5JdLVZ0b6kdZSHXOimk3PCQMtLnX34xT2bvh4InRk+SRI
 /ZKMXnikP0KWullDSMOLpRR4Iu/vDVImSVL9X6dg/bUFmjVkbNdFwJVe6CyX4Z5Vaaex
 pXgYlrl60ZSMrMzoejS3cuusCuH4D41ghVxOovLVPstqsZRW4xkxNmJAQxjKi52NFo/w
 8ixFoFOydjoNIbbl3oZmepPdrGFu+6QtkiQwaqH/qp8LEOEJViOiySNUKGdIsNj5NgY3 vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhj4t62a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 08:48:30 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34U8GL0T014639; Tue, 30 May 2023 08:48:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a3g51p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 08:48:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBoxTLy4evyAPjv8lpmZlfgkFGPtFqcMEF7wyqRO5P0DcLwTlWmDwmWglY+d6VXy8iw6HQH6i+DH0nD23IygYvtyBR4+dzCYvI7y7NVM5ZPo8Zfi5v6kkOGndkasBbLzm1VkTnnqWL8kpLEYsfgSYpEBiIJayLX+kVFJ37Ih2dVQxpvcGQQmg0XrTZdvqc8DGw0sDky0N3FUBLo6Si/wHlkba+KEWogm+W/maJQ+6XMy8GyONOGh8Fgjv0YRHhP7uv4Ng9n9KV+20W99ELFjT8qEh/l+KVVgpAyWgn7O/d/u6THolX6A1Kad0fWwuXvlHtQFkrHwAKh/4nkauLrs7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBsC5dwka55cUgW9ffOLNVTo8cOOevgxHToXWQNwba8=;
 b=U9D4IPOk+4e7GigFv18uRwJNFn7sV6lqIZyetByWcI9vIiK/UYIrUxFYq3vvyd7YskdJ8daflkKE8uLh4c2UBRpahdh3WVyD5MBfLYSUMvVRenmIDwxsNlQWrl5y9GfAW90ITK/cpYjKS47wcwkDT2XdKjJPq9IJXLJxMT8Cl6gf0e3JzVp2wVSbW+Yp5oYxE+nA8esFkcYsgpCmoci+dCpL6+PJ1f2P7m3oMjq21jqftKTJTmlyuiLRdSBb7bhYVXq8+Dou9NhzwxSkh6kuVEiM7sjs35BThkCsqM2mENBvUj5PfJQ/1Zeb0s6JaWaKVdLMiMQmT42yjBatlmSJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBsC5dwka55cUgW9ffOLNVTo8cOOevgxHToXWQNwba8=;
 b=bHiwmoafDSP22t+4Atvv5R4n2OY6p6ekwh6nB8I9eajc5xjUJDVV4YIGu3BChayrWnVOnr4zUyw9BQYnTDfh/n+BZ3cijxNVBCJIV3ljxGu/pzcDdvFR5ouzp7mdXb4T8AXHXyJZLoThNqL5dQdEeVi2mL5idC8ewCL2f+CpScw=
Received: from DS7PR10MB4846.namprd10.prod.outlook.com (2603:10b6:5:38c::24)
 by PH0PR10MB4742.namprd10.prod.outlook.com (2603:10b6:510:3f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 08:48:26 +0000
Received: from DS7PR10MB4846.namprd10.prod.outlook.com
 ([fe80::df3:10ce:b3a0:c597]) by DS7PR10MB4846.namprd10.prod.outlook.com
 ([fe80::df3:10ce:b3a0:c597%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 08:48:26 +0000
Message-ID: <11050c0d-7263-b086-943f-18288f98c7a5@oracle.com>
Date: Tue, 30 May 2023 09:48:18 +0100
Subject: Re: [PATCH v3 1/2] exec/ram_addr: return nr of dirty pages in
 cpu_physical_memory_set_dirty_lebitmap()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>
References: <20230529121114.5038-1-joao.m.martins@oracle.com>
 <20230529121114.5038-2-joao.m.martins@oracle.com>
 <dd66848d-d1c0-e428-7a49-97751f7f62b3@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <dd66848d-d1c0-e428-7a49-97751f7f62b3@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::7) To DS7PR10MB4846.namprd10.prod.outlook.com
 (2603:10b6:5:38c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4846:EE_|PH0PR10MB4742:EE_
X-MS-Office365-Filtering-Correlation-Id: 5456f214-b8ce-48a4-18aa-08db60eaa1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XAv6TCb3ajfOM/3wD/O/U8plTMsHkR66mt30ESmml2C8UaqzAvN44eQl918sDxUILVBEkssHD0kSkznyaLFWLUIoDmFWmAbfYcAx+lr2uhhYZ32C3SiYzSh+n9voSbrbmHPQ3FiyGNXppXNoYcXuouTBtpkTvi2ydVbRjaXOrlPJLhfybTfvDZVGS963co6AIoJ2OEbRMLFqmm2eY1knCqzqq69mHy3xlUdkKk4ed3SMVmwrK+S78U2u2FG2IsN9hvGcwf790NFerB7N5y7B7a84lg0I1cBmXOsTg4ro9rtRt4Ja7wsVr7GV6Be8xrTkKdlkt15mmf2GutO29zfTEsLwrdOlcqA0/oFenKdBZQTOCjmIYqQcEqwAnCALod1JG8XMH1YMYY85N1M7QmqedXBm89dzSV27QoGkDEH+vZMliGMscWn6xJEFJ+HjkCm6dT2Jt1bftPDpAdyNIsarwkmD0lLtCcMUR69NdzAUMl7EFFTFqvfeQn+36v993hVeetDn2c05RQ2xkcZpd3X9lKxUa9jU9d2HlEYIqRaTm9/VtzeLwCMjdD22F1oJDpDxkTZqQ7+U0x0HpteFWQCOFWUiXB+Wqq6xMvc5i49D4p1gAycKTAH170ae/MeiqrT1FrK8WhZCOGYSNDJsSzu6TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB4846.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199021)(86362001)(83380400001)(316002)(5660300002)(6666004)(66946007)(66476007)(66556008)(4326008)(36756003)(31696002)(41300700001)(8676002)(8936002)(38100700002)(6486002)(54906003)(2616005)(2906002)(53546011)(6506007)(6512007)(186003)(31686004)(478600001)(26005)(14143004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cng0aEQ0dWNOQXhyaytrRURNOGw5aXhBZktkbTF4TklHeG1JT3A5Qk9DbTFJ?=
 =?utf-8?B?NzY5d29mYXkzMVRYQWJkUFBhcDlubnZpNjdjOGR3NHVtZnFCUktXTmtzM2Rh?=
 =?utf-8?B?bEdscUFDeDg5amswN3FXbExoUm11Z0Jja2RyMG8wRGYwaFVRUHNCUWtHSkFw?=
 =?utf-8?B?RW1Gcmh2cCtTNDF0dGtlSEZFZVVwT3FtQ01lODFoZ2RxSmNyYjV6aHUyQ3ha?=
 =?utf-8?B?dzkraHo0UnFxWFBkRmprTjIzSkZKak9qSnozZGdJcDdreDJzbXQwQnp5ejRF?=
 =?utf-8?B?R21MdXo5dzRMVXdvelJzVWdSM1JSWDBXNklwc3kzbEJ5V2o5MTdCd1NzeXQy?=
 =?utf-8?B?UmNnK3BLL04yTnYvL3FFbFlrTDVNdXhDMUdEaWNsVjlpWU5jQW05OUNMd3Ir?=
 =?utf-8?B?RlM3cjJ3U3Z6WUpFWDhGM2ZPUk5GbCtMUmlQM1BRcDVnTURhUEk0QlVPdUlq?=
 =?utf-8?B?OS9jZlBaelRtcTdQOWdpVktmUWtFZUx2Z0VDazBUZGNXOE5RUitwUXREeU9T?=
 =?utf-8?B?SFYyTzg0bHZLcFlUMWJSVStnbGRZUXUwN0UyTXl6WlR3SGJ3NUhPSktEVkZD?=
 =?utf-8?B?OG1PZlhJajlXUDVNNjVyeDhLRU9FWnh6YmkrdGpCUlhCalpoMGJYb2plSnVT?=
 =?utf-8?B?ekxuUWJVY2V5RlpBT2ZMMWVxWGIrTjFJcXFvbjNRclVqTFZGdHVPVlZ0blRC?=
 =?utf-8?B?UVlRenRKWE0zMExDbE5CRzJtMmhVaVpVU0l4THgreDN1VnIxaDJaUTI3aWN5?=
 =?utf-8?B?dXhJYll3Wk04R2pYVWI0Mkxzb1Y1K1ZvMUQ1WEYza1loNkFJUnRTd1llNzZz?=
 =?utf-8?B?TUpzSXAzNDlEVkY5OGlMVFh5VDB4U2F4ZmExRDJnampVUXAxMVhqQlNseHFS?=
 =?utf-8?B?Rk81QXRrMW5ONFNqSUpobjhEWHRhbG0yREVDZVp0WVoxS0ZnRmM0ZElHNXpL?=
 =?utf-8?B?NEYycXlWL2tDVHFjSjI1elIycmxQZ3BYclR5SENlSlpjbkZ3SE5yRzNQdjE4?=
 =?utf-8?B?UWY4RW9IZk5uMGh2Q2RFSGFIYVhPZFJWS1daVjNrTnpvRUlPeUNXMkFwOTAx?=
 =?utf-8?B?Wm5sWlRWb1N2Y3pRb0FQZnBZbjdXUW9UTTRuQmk5ZDRqN2FHWHYyWlg4bHBw?=
 =?utf-8?B?RktTRmFmeWFoQnNaWWFQNWRFaTlqMTFJajY1MzA0ZXBkanBxZ2I5RksxZlkv?=
 =?utf-8?B?Z3U5UTNEaDlyWi9zT01BOXV2OERZNGVjUHNId3Yrcm1JYzIwR0pYbkxWcWZ1?=
 =?utf-8?B?N1M0SGpWdk1SYXk1R2lYbDczUXRZRFVTdVd1NjFOSGtwdDhQaEtPMzFLNU1L?=
 =?utf-8?B?dlFMWXhlOEltNVI2YW94MDVWKzZjZG9STnNCQzVnL1o5NTk1TGFJekIyZHM4?=
 =?utf-8?B?ODd0TE4waVhpdWF0NDFzSFB2V3lmRExpQ3JWQ3duMi9vVEVUR3NCRFJRdVlw?=
 =?utf-8?B?OUNBbjhLS0ZFTU9mV0t6aUtMOXhoZmN0M3NqL3c2OG9SeFRuS3p0TEJZbkZl?=
 =?utf-8?B?VGlvbUtSNWs0bE05YXhsc3pITmROYWtEa2xGbDk0QlBoNXNnQklLSDhSazNs?=
 =?utf-8?B?ZEVCVjd0ZFc3K0QycGZCWmo2b1o2dDdtcm5VcU9XTFprWjBmdDZJalFyeU5T?=
 =?utf-8?B?WnlkRngyaDh5WDExTFN3bXU5ZEhoaFZhbk9vWDdsOHJveDloK0pEeXVDNXRh?=
 =?utf-8?B?d21OMHFaRGRqWDNzUWJaZ3V3SU4xWUFuOCtKNGZWSHlBYTRTdGZrZW1ITDcz?=
 =?utf-8?B?UmdjUUxrR0tpbjRRMTV4QUY5TkJUb3hxNkZETkpFWjVPZUJrL0g0K1VWalk4?=
 =?utf-8?B?YlNKV0NEamR0ZHpvWDNkNlFVSkRTdCtMUzc0bmwwcTUrUUk3WnZsY1E0bS9p?=
 =?utf-8?B?T1grSEJaRHI1NndSK0tkN0YySUl4ZHk5d0l1OC9WL1p0NWxRWHVwdXdnSGVo?=
 =?utf-8?B?TFVJaVBTeGl2UjBuYkFicGRjUTZLNCtZZjczZEV0Z3BiRmtIcHp1MU8rTlBh?=
 =?utf-8?B?Kzh0UjhIV1lTdjUyN0JIR1I3SnlZTVFMNXBONmUyRVVFZWlmZ21DcnUxbnd3?=
 =?utf-8?B?Wm5HYUE0bXdQSE9MZ3hHc0RPaGoxV1lyOUpyTWRlVnVpUWo5anFlc2JXTTFy?=
 =?utf-8?B?U2t2WHZ2Nkl3UzVSbWY4UGNaUktrYkwwUEQySWV5dmxha3FCbGo4Q3RXL3Vy?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MwNd6SVtoqwbPq5eJULe0B/Z+yjbTvKuxdPlGPl8RGrS8LTuJi6BCVSaqsW/Lvdd3DWtq2GKRDREgUBvqjhqZSLSxJqkGDLV2LcyGtd6w/r2KBA+jrEuQWmWsUiZLxztzqnUc5wB6GCOFU1iEF3JIFQ4UdpqfxqXf99ZfKeHiwg9Lna7SjdaylWVKaccXtzOAmt3CpPKFaYnmyC9ha9YQsb1ncOV5G/a3lUJp4AlLLYZ9DN4zQEHbw6L0P3Cs54PFsYw+HGJnFenHOc9cJvVCi1XzRY8f+7yogrSdsDm2QczKq/X8NFs3szRuLYvhDnCr4F0BaXI+vVpdVA+Nmgj0HXMtvt0s1oLDwokoeKCmJvn2bco0JMNJOU74vTCQqOntvLi4XaCrGllwjanRUIrNV/oLroqVLzJMUngzdV5QQpgzZBgm8EYvmMQcj9cLur4Qcxro3C37Kl3QvfqU4Fs2iJGq9W40ncCs1zXWXLoTO1F3bfAp9B6StHizo58FKY3/+KNyIMKg4VHcqTf2T7oZJnI33+bWLIQcCxuj8WFjov1HROUEnn32O+OZHr+zR4Qz7G2z04TaRdsrSYM6HmASdu7XXmgrb6uzT8Q2XIKcYcCaDbHSh+aJe48nvtPIpPH75djUD9S+T6cDghyOnUN8O+GEA0Klu9bjxoCIooKRB1adsAWmAI6Ki3oEzjMas/jIHUSHqzYE8sgz/UzEvlAOf4IPvlupV9twXMv5qsXuhFD/Zmha6LBdnUVlfTroKGWa+dlmYQuGrJkEH7DTNJf/iIEVlqfCyOPa3VagPLzDfvH5qXvlvm0S3oLbEPoWGQ1ViqpEBU8PPVx3BcEe8kWeQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5456f214-b8ce-48a4-18aa-08db60eaa1a0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4846.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 08:48:25.9549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8hye3a/EipDdu2ViIMd4JM2t7wenEUIJBEHvKWvhN3U70FQ2hU9jwkG/o9udDQP37EaPNo7P67ZqUtQP0++3brpVzF5cjgb5gkuHtBTvj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_06,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300073
X-Proofpoint-GUID: J8R9k2Sr9whfS9uyvtxqi7j6zVrJfljI
X-Proofpoint-ORIG-GUID: J8R9k2Sr9whfS9uyvtxqi7j6zVrJfljI
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



On 30/05/2023 09:37, Avihai Horon wrote:
> 
> On 29/05/2023 15:11, Joao Martins wrote:
>> External email: Use caution opening links or attachments
>>
> Nit, s/nr/number in the subject.
> 

Fixed (this was instinctly just trying to fit 80 columns)

>> In preparation for including the number of dirty pages in the
>> vfio_get_dirty_bitmap() tracepoint, return the number of dirty pages in
>> cpu_physical_memory_set_dirty_lebitmap() similar to
>> cpu_physical_memory_sync_dirty_bitmap().
>>
>> To avoid counting twice when GLOBAL_DIRTY_RATE is enabled, stash the
>> number of bits set per bitmap quad in a variable (@nbits) and reuse it
>> there.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> ---
>>   include/exec/ram_addr.h | 28 ++++++++++++++++++++++------
>>   1 file changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>> index 90a82692904f..9f2e3893f562 100644
>> --- a/include/exec/ram_addr.h
>> +++ b/include/exec/ram_addr.h
>> @@ -334,14 +334,23 @@ static inline void
>> cpu_physical_memory_set_dirty_range(ram_addr_t start,
>>   }
>>
>>   #if !defined(_WIN32)
>> -static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>> -                                                          ram_addr_t start,
>> -                                                          ram_addr_t pages)
>> +
>> +/*
>> + * Contrary to cpu_physical_memory_sync_dirty_bitmap() this function returns
>> + * the number of dirty pages in @bitmap passed as argument. On the other hand,
>> + * cpu_physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
>> + * weren't set in the global migration bitmap.
>> + */
>> +static inline
>> +uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>> +                                                ram_addr_t start,
>> +                                                ram_addr_t pages)
>>   {
>>       unsigned long i, j;
>> -    unsigned long page_number, c;
>> +    unsigned long page_number, c, nbits;
>>       hwaddr addr;
>>       ram_addr_t ram_addr;
>> +    uint64_t num_dirty = 0;
>>       unsigned long len = (pages + HOST_LONG_BITS - 1) / HOST_LONG_BITS;
>>       unsigned long hpratio = qemu_real_host_page_size() / TARGET_PAGE_SIZE;
>>       unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
>> @@ -369,6 +378,7 @@ static inline void
>> cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>>                   if (bitmap[k]) {
>>                       unsigned long temp = leul_to_cpu(bitmap[k]);
>>
>> +                    nbits = ctpopl(temp);
>>                       qatomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
>>
>>                       if (global_dirty_tracking) {
>> @@ -377,10 +387,12 @@ static inline void
>> cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>>                                   temp);
>>                           if (unlikely(
>>                               global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
>> -                            total_dirty_pages += ctpopl(temp);
>> +                            total_dirty_pages += nbits;
>>                           }
>>                       }
>>
>> +                    num_dirty += nbits;
>> +
>>                       if (tcg_enabled()) {
>>                           qatomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],
>>                                      temp);
>> @@ -409,9 +421,11 @@ static inline void
>> cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>>           for (i = 0; i < len; i++) {
>>               if (bitmap[i] != 0) {
>>                   c = leul_to_cpu(bitmap[i]);
>> +                nbits = ctpopl(c);
>>                   if (unlikely(global_dirty_tracking &
>> GLOBAL_DIRTY_DIRTY_RATE)) {
>> -                    total_dirty_pages += ctpopl(c);
>> +                    total_dirty_pages += nbits;
>>                   }
>> +                num_dirty += nbits;
>>                   do {
>>                       j = ctzl(c);
>>                       c &= ~(1ul << j);
>> @@ -424,6 +438,8 @@ static inline void
>> cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>>               }
>>           }
>>       }
>> +
>> +    return num_dirty;
>>   }
>>   #endif /* not _WIN32 */
>>
>> -- 
>> 2.39.3
>>

