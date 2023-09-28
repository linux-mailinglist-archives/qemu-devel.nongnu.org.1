Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A10EE7B1E75
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:32:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlr7P-0004Aa-VQ; Thu, 28 Sep 2023 09:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qlr7L-0004AO-LH
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:31:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qlr7I-0002UF-I4
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:31:46 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38S8qGtn005330; Thu, 28 Sep 2023 13:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DcjeyXW/MoVfgnU8w5mh1YnIzkBJs1THxLZJdJF/0qA=;
 b=MSCF05NN3lkAaRSw56z5FOf1dyHV9AvV9ktMpNeWkENDKWp0uZEKfpiySfmfOAqgRCij
 tZ+uoSTYRMmcIcQ/YwvwqW5AjNM5pwhUj/3eWhTVzaH/oj9PQAO6BthSlLkAFXo4yAMe
 uETjGA7zLgPg0CvD0/Wm2L1xy/jkYPLJK+qgvn3MJy14vaMVLH0tWyMaPhCMujrQIMwp
 NgF5P9fQGXVmuHiyjVW9Zikl3kiRklydB5kOBKM51HNlpRXFUvrd4gFyTDkOe2+g/fZ9
 7ta/+Jn8VfWEGSkey9NxEFeRgu8Ys6otulyI/6Pujqp7vbZoL6CIp0d1SghELYZcBOgR gQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjumfk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Sep 2023 13:31:39 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38SCNkgi037521; Thu, 28 Sep 2023 13:31:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t9pfa3krm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Sep 2023 13:31:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2XgnsAVyIKKllj16TAfMg9XwMmbN6BfXw05S2vLC3D2OrmfQPB3uGOipwE7f8vZlPFFu1DVcPNG+q98ZKQ5+tfFaf9XGK9UlytKa4yZjSUDP9lh1FzTZNceFwF2a0BIFpEf2bRisD9BuMTXzaAJNF9Ib1GRzX1Yvi9/RFgBDdOVgG0M/OhWmw9xe6V/8KGX2q3QeQZTk+VIUVPHSpZpbBenRgG3IdvQSrF6jWc9E5wUwWJLn9kXW4BOTGcOd3Eyb+TJTtnVZzXXT8HriKp448GpqhVweIGVO3kHCsBTlmPR4SKRTWxvygYSqZtX7x9O7U8QbjNkedXGcLc0wD7WUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcjeyXW/MoVfgnU8w5mh1YnIzkBJs1THxLZJdJF/0qA=;
 b=BgcfNE+3EbLD1MBdDbP2FWpjWO6LtQY+sHqas5YFTLeqtquNJm93nqeZH2AO/9FF29JIHnaiXTt/gHUWzgy8t8AS9y70ND33aUXxxn+46BusYQF032cH+EvHUEhHWVZfLrlgzUPebBWIuNSExqkkANeEQ4hCuHjIOtGdEE5V3GIPBEseqZlRSwwiWD1sIQn7nu9uTDFCIurDOWX93OkijBtSv3xGsO3l5sadkgMf7GeSMnasmfDEflml9rhTPAw9WzBBkeiXJQz1FAy/Fu4A/Icw5kOebfbkmFBXoYS3rrSLgZu7tLDM4bFiTQ7xvPT+8e7xGBKiUTHd2UGNehW7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcjeyXW/MoVfgnU8w5mh1YnIzkBJs1THxLZJdJF/0qA=;
 b=Q8iZuU94S5pp93KgecrqPgfzEdtHj88IN6CRXc5OabFL1NZtwisePiCX7cOSY3D7UJCWehmouVb8yvP6w5f8gujhdkuh/TSYAuRsASkO2hVG0XY9YyG3EU8jfvJea4Jl1dhU5rXJE0t6J1m17feTSNnqfUwuBrCG5YmQhZcdkRI=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by MN2PR10MB4141.namprd10.prod.outlook.com (2603:10b6:208:1df::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 13:31:36 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8adc:498c:8369:f518]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8adc:498c:8369:f518%3]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 13:31:36 +0000
Message-ID: <b3d6178e-a4c4-4145-b99b-1fd1cb22242c@oracle.com>
Date: Thu, 28 Sep 2023 14:31:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] migration: Store downtime timestamps in an array
Content-Language: en-US
To: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
References: <20230926161841.98464-1-joao.m.martins@oracle.com>
 <20230926161841.98464-2-joao.m.martins@oracle.com>
 <35b4b8d2-3cb1-819f-28d2-5eeff3db789c@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <35b4b8d2-3cb1-819f-28d2-5eeff3db789c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0264.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::36) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|MN2PR10MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 2967f2a8-89b0-44e5-8981-08dbc0273cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDUfpRBUcJMP/RgjRawvTIKS5O96roC03KBLb/VWwnKNAhKSw/5yq7xuBDKmFgcMCtVX55bvumqiFJ6q5aL26vtpIPgkHP0ND1fohKetTo+pXJDQl9tG+NW+ZDhwk8Ptua4dQAe57evD/Q0to1K/YNNKSZG9vVk81PmShoBLrHoFkL7GKjxkQVWtdq7Zo4O4X152yUbHppvG4e2Ji5cIfl+gAhozE517WzKjZ6NphKAurbmoU2O2owURfJcSa8IbJTkKacuI51K+j3pjQIm1hhVlZ9ScYSJZmw7g1+v5/5OI9bCG6oNR0O4E7mu7xM792KYdkBci1Gq9g5EVlPN+A8GLLSxg568cmqKgr5oNBrooeUkU8PJSkWhRW8jV2iDzqCjMhd1b3kh9wnra6lxKL12vs4qnZgPns9T7cwxJgwik+Tu3w8/WV5aC7nBVmujYmIsby3ZO9ZhkDf2hvl65E6al78Eqt//3amNTcP5Lpqf0i2Ify5T0f/fGQL293lF6tAxUexNSlY7pzFr/16YE3LGKvMXWlKsM81dfHhcdgk+wW6D5wOu7Vjv6wrqQaOzELg9QD0Zi9RIvLh0ixP35p91UZHSdD0d5WkcshPnN8/A5dFb8O0UzVH28qlkh4fPPy+aTod9igTfsHGYo7zflZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(26005)(6486002)(478600001)(2616005)(107886003)(83380400001)(36756003)(86362001)(31696002)(6666004)(53546011)(5660300002)(38100700002)(6506007)(6512007)(8676002)(4326008)(31686004)(41300700001)(316002)(54906003)(2906002)(66556008)(66476007)(66946007)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmFiT2xiQnNNNUdxTHlDU01XOFUxeityeUpkNkZYdEp2aEpIcGFGczN4YVUw?=
 =?utf-8?B?akNiSXZJSkJYaDFxVjduVDFnSWpyYmtROVQ2V1JTUEVFbXRuWTJHZFROeGxr?=
 =?utf-8?B?Q1dvWVZPWGFhTmt5eDZJakc4cHlNTDRrSnhVeVhMYzN2QVg1RTRwaVJ1MVJx?=
 =?utf-8?B?dVd5MnN1c09PN2ZSTy9OdHpRemRiR1U0TThSNUhSZXk0RWltOGJJQ2d0OUZJ?=
 =?utf-8?B?U3BheFlacDRsTVN3NTNrSVVDTE1mQzdrUFBtY1NxK0JEVUZScW1KNUxCMkcz?=
 =?utf-8?B?NzJKbVdSREd1NmpMUmVoQ0JzT1JPL3dVd1RQQis4Q01VdXN1MzBNN1Y3eCtt?=
 =?utf-8?B?aExDbmRCMzZ0K1l5Sk9xSUhHTC9tMEtZaW9oRUlTQUZrSXZ1VGxNVWtnbWJY?=
 =?utf-8?B?RXBVVzFlVEI3aHc2ci9LMHZlMG5jdGpqcDgxRmE4NGpkRjc1WVYxUW94eCti?=
 =?utf-8?B?MGN1ZzcxRlQ4NXVwSTZlSldRRERqZWJQdUdNaGJvckxVY1MzcEFRMVUrRDBC?=
 =?utf-8?B?NWxHK2x1M0Z5a0prdUlEZFlqa2lTZkFjNmk2cEN4VCsrVnN3bzlhRjVmejlG?=
 =?utf-8?B?c2VFSUxsUDJlV0lkR21wd0RPMDV0R0RTWWVoVUxOYnBPWHFQWS9RTVBHUms4?=
 =?utf-8?B?RGtPNXl4VlZZVENLUDV6bUJzUTJuaFFqa2xndlVnS2FyTVl6bVRnZ2NmTnBp?=
 =?utf-8?B?d2I4b3NaRm40WjZPakcvREFqS1JmU2JuMUN3VG53K2xwdTF6WVh1S2s2ZGV0?=
 =?utf-8?B?YlFPMDh5RHdzSFpwclRTWTROWk4vWjZXSENTRi9Vb2JOU2hqb0l6eTNlSXJE?=
 =?utf-8?B?OTVGWGs5M01OUjJVa1ZPV0lZQ0FlaFZ5UXRRQURzRmZpZTdqNVlvdG0vaThy?=
 =?utf-8?B?Y3pZdXdQeFVlTXJXNHExYkowZjk3aURwTXVvak9CaGVudVdJU29mV3Mxait1?=
 =?utf-8?B?eFd6eTZQMWNVdDlSMlZFOW8yalE4SCtlYVhxQ2xjbEdyeEptSGJzZzh6Y09G?=
 =?utf-8?B?M2psUnEyUThwMktwWnhOMnVGU2JINGdsVFQ5bkJMc3JVTGRkSkYvczZRdXNV?=
 =?utf-8?B?NmhDdVlsYUxMQXArbDRBSkYwK2lPUTVuMG5XNjV3UFhMNU1PdU43bS8yRGNp?=
 =?utf-8?B?VDV4OWtvZmdRY2NPMEg0eFBvZkJ4czRUMm12UEY0MWZoeHBqbW5JMzlDWkdu?=
 =?utf-8?B?VDNjVDJCVUVKbmQzeDFkWVFRY0I3V3A2UXNSRk5vU2Y3QkRwNGZaeW11NUdV?=
 =?utf-8?B?Ujk5MU9aenVWWWJ4ZW5RV09CVDhCbG91YU9rK0N2MFQwazdpN0lsUm9DbFpm?=
 =?utf-8?B?MVArTHpYV1p2TG9kZ3JYMDVraE4wRjlGYkFubkpOTjFmdS9TTmJILy80Yk5k?=
 =?utf-8?B?Ny85OEVaNmRzWTJMVmlVd2ZrQVBiUTNVNTh4VHp2bHVQZ0xOZTVMVWdic09I?=
 =?utf-8?B?anNFeG9RajdxWnA4Sy9Yc2JnNnVZM3U4MUpLcnh6OS9YaHFJVFVMbmxFaUNu?=
 =?utf-8?B?akxvdGdXaWdOeWh0a0NmMDREeklPY3hvL0s3dHRZT2VtWjJ1b3M5c2ovSndW?=
 =?utf-8?B?cHBaa3ZVS05KZUllckpjWHlnQ25vQkc5YlVRNTR6WUIzOXhkUnJSZVoySHE3?=
 =?utf-8?B?N05nVTZWak9LcXZBWCtEdVVzRmc4b05lS1hnLzlsbGZuRW9ZOTdmRldzZEhv?=
 =?utf-8?B?U293ViswOE1FNkg3NXIrKzFPT3o4SFZiczFBQTM1WHdTdXk1ZFMzTzNoanll?=
 =?utf-8?B?RjErN0ZJUmxnUGE4RWxaZHFEYlRxckRjVVdxWGxnNmdsQlF3WktWbllFd0V1?=
 =?utf-8?B?ZnNIWFZzQmYvSzFQbi9GV24vb3VXY2xMdEFJOWRjWVZYVkxBMG1PbU9zRnp2?=
 =?utf-8?B?eS9KK0hPdlg5NWxIOTdaZDBHNkNIR1FaWVZPcUNhTnNHTldFRGlrSVAram9n?=
 =?utf-8?B?ODZEb1Q0Vmo0UXdSZEVKZlBxTmNuc1psdXJnQitMS0FxWXVpVkJvaVZ1Nlk1?=
 =?utf-8?B?dHBVR2V6V3h6U1BrQ3NVT3ZYUDRHdUNQRWE4V0NqZXNFODh0U0d3RGhzRDI2?=
 =?utf-8?B?NmY2emYvU0RiSXBMWDZBV3ZUZnNJNThOaUI5am9QYk9XNDBaTm1kRXFLNllI?=
 =?utf-8?B?RDVqVVRVb01RdDFKVFNSbDZ6eE9Cdm1HcTJONExmSU16V1Q0eGlSVGcvU1Nn?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /ctKlxaHDnIWG75YS/OHIfem8cG/0BRBFjneICy/G6d7qJigBb6GnwlqYXnpBHbd3QyEdTVUU3UNNhslkH+VNx6PYVSaYvnofMNLI+OtK20QokvhYDY2CSRU8ddonx5SJ9PsWkSm4hmJ9DBPrjSIw6pIGVFsTNP8EqZEaIGVb0Aw4aA/Xxz12ZfMc1u+HyuersBeQqPnwLK4VW9f3NdQkkgiSXsBLTaqQOmA9oLlZQVgE95jh3j8VT2Nba8WOJsSKbpPf/9LiseCiw9lihPsjNHQbyGoAiC+SPxrzpIkg+jx3YCwY2gZS4vtY2ctqE8QQxYrZ2kNYGWSF0TSyYf99BlRXVXSxwBwYuaWlcBq/GamUMyKl9wZZTbTfemSyIguHpSHXro0/A6odQWFbtW4gqCe1pDIp6510m+lPtoSt6jRaO4xqhQ+G03QyhUsUDHFrcr2aUpV/GSF5I6jzkSduzkjVc5I5yDx/lnHvZ6F+RG1WIDP28E/5RojhlOzXsxOsKC2fSR7aIY3u11zqiCYS9wYyAKv2OBeTWSC0+U16lkdY3CV3EsXX1lcYCpZ/f3ya3zIYZn6paMGLiPodeUebA5ifnaxUzPaRC8OCH2j2QCEKx0AFh7lHExBGX5SrFd7izRdF5/0IV0Y8yXjbenQvegtlUUxRJk04wud5CJ0KgE1IiFg9vtTnNtUpaXScFlJIqQxasDvWtINlPvrf4vdsDOo+9csgVCdq0hClv7J0bMtKhdHha7PYcIZsqk6xCFqRRm4P9XL32HwgkBqhyqbaS8p4MOViepbfWAYDm+GA9xmXeqcdW0pTuYtvyCkKcqzhUAtu4VOp2rz0Cm1q5zZ8w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2967f2a8-89b0-44e5-8981-08dbc0273cf6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 13:31:36.4958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msIr307h4x3a5xTedCgV586rVvi4KcJaN+DmwAGFXss1cBikeur4DAWmDAi55i/rqejNDqFNvBv+4WjESKexzW1kDz3ci5o82fL+3SfR7ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_13,2023-09-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=913 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280116
X-Proofpoint-ORIG-GUID: JRGnYW_MPJB6Ec1xP7UHLDqN3wst3LNO
X-Proofpoint-GUID: JRGnYW_MPJB6Ec1xP7UHLDqN3wst3LNO
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 28/09/2023 02:55, Wang, Lei wrote:
> On 9/27/2023 0:18, Joao Martins wrote:
>> Right now downtime_start is stored in MigrationState.
>>
>> In preparation to having more downtime timestamps during
>> switchover, move downtime_start to an array namely, @timestamp.
>>
>> Add a setter/getter surrounding which timestamps to record,
>> to make it easier to spread to various migration functions.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  qapi/migration.json   | 14 ++++++++++++++
>>  migration/migration.h |  7 +++++--
>>  migration/migration.c | 24 ++++++++++++++++++++----
>>  3 files changed, 39 insertions(+), 6 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 8843e74b59c7..b836cc881d33 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -190,6 +190,20 @@
>>  { 'struct': 'VfioStats',
>>    'data': {'transferred': 'int' } }
>>  
>> +##
>> +# @MigrationDowntime:
>> +#
>> +# An enumeration of downtime timestamps for all
>> +# steps of the switchover.
>> +#
>> +# @start:Timestamp taken at the start of the switchover right before
>            ^
> Suggest adding a space here to keep consistent with other attributes.
> 
Yeap, will do for v2

