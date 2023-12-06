Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F6C806380
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 01:37:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAftx-0002MT-FY; Tue, 05 Dec 2023 19:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rAftv-0002ML-AX
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 19:36:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rAfts-0003qI-Kl
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 19:36:31 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B5NIr0s026461; Wed, 6 Dec 2023 00:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=l5/C316m4FtrwCwrkSGAHgkGc6b4W4kfDz1cpqHK+NI=;
 b=n1iH3AUlnwLREAk8bmxqcp3kVg60DnuY1qKyupLpeFXQPHF93usgMOQF9F8bm0adSteN
 7L4CTYrL17fzsyBpqt3seNkxbgUYnf7q3NyskafWodxNmDaZuGmNja3CH9QqmmjjfusJ
 xru9zzaQk7wqOfLPFo6zJ1xsgcUEziu4dlpLZIf8EDeVKJWDLowrpEHCE51HDMOu34Vb
 zoFX91iI8uz6sLUrbIQAvd9HHzOoBmqorVpdSNb6j0jovIqzrxp9XbmNMBz+A4pgtXT8
 WYexGnwdfPn0fhojVUhfbgczHDUI0+Tc0yQlWC9AThS0ncyCQXZRzQyNQxKqO281K59N jA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0hg3pw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 00:36:18 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B6072em037908; Wed, 6 Dec 2023 00:36:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3utanb1kur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 00:36:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4oRKi8c6utSMPR9dxABSgEr+OYd+IN+pjl4PK6tSfNUiDpwPPoSyMilSZZAhdoS85STVBcjlwPGi0+8kWTE/MDMn+6G/WSqlfhGBwoV9XI+OVzc1sOQfrURl3QLKnBX3ucIwfRPcQ5rU/Fd1zc/Zii5Xbx9VU8hskql+x8ivJhooDSV0bg8IlqyCZUJQny60cTtz4tQLhZLBGXkZksBYHfTwoa4FQonymQ6Zv6m5CRcZAT4Q1Kzw8qY0nld+RZrH5OfHvM00JegncMhJ6tGh+vx16RIJoeWJ9bBwD58Iuhf+4uOiii7D2MePTEkwLUv9b7LVjrI1+266ksu9pClkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5/C316m4FtrwCwrkSGAHgkGc6b4W4kfDz1cpqHK+NI=;
 b=N7w/eF9bemn8vjWFbe5eVUAIdaOMN7YlQFNlYar67xjVnVSv+OGQI1D4CYjsPW0G14HvUjoGLqRFprYAejrXslRYbgPNPhQqUOyTY3A/PHnje3XtPFrWJxpyOlmULVrLhk2lB0YufxQ8s7Tu/Vnj/Jym4DLDZ39U8ThWGM5hBrZLjvoJu0WP78/UVRvvlFlaRBq/bPb+eEnzRYK9ICW3z0TjZtVpj6vItArsnQyVT5wilxsnoj1oy7VNMzduJ5gZZW0fNhXgCVu7WwrI6VifXaalnFkiqgcLU8ZhZVh2r6x52jwejJ5xCP/UvGGXD3YlD1NL98B63iboAZ6mGDiN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5/C316m4FtrwCwrkSGAHgkGc6b4W4kfDz1cpqHK+NI=;
 b=GVWtl76ogL5Nl1P3NKixZOlVu5fRZiYFHtiNNyMtKJBAz5+SXh8mG6TKyWzNFGtGdTjTgh/IM31zWvwrp+0bqs42xPBm26LmPak1CGTLH0H/fUY9RSO11EameuaKDPcrJgYkO/9AcjvnrhBtNDVCfQq5y8sTg7wJZdz7qMxuEHY=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by IA1PR10MB7336.namprd10.prod.outlook.com (2603:10b6:208:3ff::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 00:36:15 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 00:36:15 +0000
Message-ID: <75a8dbf1-4c9a-4765-8efd-5aa99aa5a909@oracle.com>
Date: Tue, 5 Dec 2023 16:36:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/18] Map memory at destination .load_setup in
 vDPA-net migration
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Shannon <shannon.nelson@amd.com>,
 Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, yin31149@gmail.com,
 Jason Wang <jasowang@redhat.com>, Yajun Wu <yajunw@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gautam Dawar <gdawar@xilinx.com>
References: <20231019143455.2377694-1-eperezma@redhat.com>
 <1e565b27-2897-4063-8eff-e42cfd5934c2@oracle.com>
 <CAJaqyWeOG0Eoc8W9FYFzJ9r1ENd3Cd1oLGF=ggJvWth2xD6u9A@mail.gmail.com>
 <b4cdaabd-45b1-4ff7-a267-05230a754588@oracle.com>
 <CAJaqyWe0Umnazu2dBGCWd36BC2yFWzXPg4r_Ak4erGiwmqgCGQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWe0Umnazu2dBGCWd36BC2yFWzXPg4r_Ak4erGiwmqgCGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0009.namprd22.prod.outlook.com
 (2603:10b6:208:238::14) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|IA1PR10MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 517706ae-a5d2-4d33-4dfd-08dbf5f35a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JzZXudYw0WTRv3vi8ngbJTMousaAUlAA7f10sUvYlADg+AQtyy0WxaE0p06axkwc+9HPabcnMa3D39tioMAPf2WaE95gdRl7VUh5YJtHlWDMiU596A9mW8/cezgv8UFSupflhD8E0mY9UULrlID2pS4LgED3+crYDohgUdQsyT3i12GNaA1pXi0M9uBTnosSrAvZSaaY/jTBU+gDlnuUkqE5K/uroMHzjWuIyelzechJ4MPJvAlLD7ZgkUnTo5QhWiy2zHQeD62I7rWfX1+UB4bHwAySFllRXF/EpuLWEFVsn7YPHsOSjH95jNN4j29bBUCec6Y2hnLUVi78Ry3w25G6S+1PBt3kEuge2hwGyrlPBmAdka6lL6ZhLIT7rkwkKfjvl1Talfd/1GU654630bzb2PFQDZgq9K0fNk6fjOkdBs1o7dYuS1B65wAWQFqbTjVe3nwsRKPtLe8eYdaBj9D9DpbmL+UUIXq8ziE3zT6Z49Z4vVxX2O2z532MoZDC+/0WNNiqboLZOS9uOu5fRikCwPmBqoOtr1qSyj+BNCKxrUUUAlrxOPwMbgekA8RxqHjZb5OBied46dfNbG3MAGJJMYz5tICM0TvJaR5bLNOaj1OcoYcifGWYGN/DrkkyQO/xXfROic6+m293BNQA4+7oy6ozQaE3NVavNGGUDyOrg6w2I7y0CXvtGnGRAwTmfzskS1hqmPKe/7rxONKjGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(36756003)(66899024)(5660300002)(7416002)(86362001)(31696002)(2906002)(2616005)(36916002)(6506007)(6512007)(53546011)(83380400001)(26005)(66574015)(966005)(6486002)(6666004)(478600001)(38100700002)(31686004)(8936002)(4326008)(66946007)(8676002)(316002)(54906003)(66476007)(66556008)(6916009)(142923001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEJESmxzaGJlV2lzZFliNnVZaTBBaGxIL213VTZ2dDI2a2xHTUlJc3pYYnZL?=
 =?utf-8?B?QXBzSG9HZ1Q2SmlNcWEwRElncFh6OFp4alV6ajUrcTFsQkpPL29vY1pHSEFK?=
 =?utf-8?B?NGQ3YUxMRnhHQ0w0d1BOL2ZBOStHRXljWThvTzVhOWFnb21HMDJHa3QzaFZI?=
 =?utf-8?B?NVJhMjFVQ0tCQXNVYjYybjFSMS8rWlVGWk9MczZzK2REZDNNRHBRT3RwelJ3?=
 =?utf-8?B?T0JVbEFSWTdLUE13d3FrNHRzSUh4OHdYbi96TURCQTFmMTJhNWlzUG5TbDBx?=
 =?utf-8?B?Qm5oWStPZkVqcW5FSUh3MEVMVThXdE5EUHduVzcyTVpSNUwzRElEQmI3Sisz?=
 =?utf-8?B?SUJUWEd1MSsxV0VNK3E1aSt6ZWg4bEVaTEJ1SlZkNmIrZFdhelh0aW5DbSs0?=
 =?utf-8?B?bkZWaDRrZ2tvbTBpa05hMG1nVWNZSFViRE9vNGpybmhtb0hiaVlTeWVaZWVa?=
 =?utf-8?B?T0RwdXlxNUNoTEtiMkd5Z28wZDl3SUNoUFRYR1RKWFpUSHNMV0JZUGp6eGZh?=
 =?utf-8?B?RERQaEYwZlZCUFNRWWNNaUh5MzdvcHJ6RVFFMlVwa0dhWThTTUV5S2FkdFha?=
 =?utf-8?B?alJXMTBaQ0dvSUdoOUYzMExiaXdaR3E4UHE2T0dTcFp4aWJ4YkdWOGZLOXh0?=
 =?utf-8?B?NnRqVnV1REUxSThScWJvQmIwcnNGRjE0ZU83MkUveWk4U1gySW1OajM0ZmdG?=
 =?utf-8?B?M1dTK25EUy9PRVlEbDcraW1LdUlJMjNOU3ZRbkQwQk5KRzZwTjV1bVpGZlZE?=
 =?utf-8?B?MENtRW1FZFpJeHBmeENwVm1IczZLZjZsL0k4UHdMc0p1RkJUbGVoYm1UWDVn?=
 =?utf-8?B?Q2padTV2ZjU1WWdtWkU1b2xUNnVKUmZ0Nk00MkxyM2dOR2YzOFVKVk5ST00w?=
 =?utf-8?B?Q3lWeEluSFZkYUpRVjRDMnZ0VlVheHpSWlRYTW56ZXZhdjR4YTlZRkl2NmdM?=
 =?utf-8?B?VjFpa3hrd1oxSlpReW5jZ1UwTHRDY0lYY2I5dUhmRkJHTVdMMHBKWjM0QVRD?=
 =?utf-8?B?ajRHUkpNNjIyMVZpUSs2bXFNQUkwUHJwS290eTAxRFdmWmZiTmQ5L0g5YmZU?=
 =?utf-8?B?a1FaRlc5cHhiQitxdi9NdU9HTnhLc0V2NGhSS3lndXVENG5BajBYd2JBUEpK?=
 =?utf-8?B?cTlDUDJFeHBTSVNIQkgzMk16TU1HY2ZIQ1REVGV1alJ3YTFBQjZNa1JreWNK?=
 =?utf-8?B?NVI1UG5MTU1TYzM3ZEpUZ2oyOCtOekhJWHZkK1ZjM2dZV3ZLSG40cS9FWkFv?=
 =?utf-8?B?RXVrclJFT2lWdlRKT252WmVZT2NRSjAzZWk2TFlHbFpvck9pSTZGZlF5eFlS?=
 =?utf-8?B?bzVlY0RidFRtUTVzU2NkTlk0Nkp6UVcveXpBdzFRa0xrYlJuM3RwcmZnRjl1?=
 =?utf-8?B?TmF4RlVyYzRRaGdkZHdscWNhOVVJOStLN2ZmRDJReDBaMHZvOE9YODQ1OCtm?=
 =?utf-8?B?bjRMVi9qYXRJWlBtMWI4dkw1YnRXUTdFYitCU2o5eXZmZkx3cHd3blMrei9h?=
 =?utf-8?B?VnB1dzJ0UUtMSTlGMm9USzZobDZwT3Uwd0JiWXRDTVdTRm5wL0p2dTRKc28z?=
 =?utf-8?B?RDhaclJLVGJtT0RNYUNaOXBWeHYvNjVUcFh3TzJieDN5VlVxRCsrckVudVdh?=
 =?utf-8?B?NVV5eVUzYmF6VzN1eDFSbzlYSzgvN1ZwTUMzM1I4c0VQdDY0dEV2c0NwTEc2?=
 =?utf-8?B?M0h0UVozVWEyY3FXSzBpRnY5UmpyT1VyUGhMYkVYQXZpSVREVThVRDBFNVFY?=
 =?utf-8?B?VFByaUpvWW1pQS9JOEwzTFl3bWJUSm0xL0hhNDQ4REpaSHRuOFcrMjhWN1dx?=
 =?utf-8?B?d3NVb1dlL0ZDMFpGN3hCMDBpWmVDT1NpOU5VNm56b1RKd1dWQktQV1Zyb3ZX?=
 =?utf-8?B?NFVIVURuM1BPOS9pdTBldTd4WVFqbnpSQ0N0NXBNaEhyQTJLOEpCRDZRejZJ?=
 =?utf-8?B?M1E0NUJxekxqSnNjQ1VBU0g5VDBZaENBL1d1RzVBYk5FYWNESzR1ekplQzZ6?=
 =?utf-8?B?UWpwT3RodUEvQ3ZaSVJuSWZPOTFxMEtqYjBGMGFmeVd0WENRbkpOTWlkWDFT?=
 =?utf-8?B?M0xyME1IYVViSVA0Qm05QUU1T0NtaEM4OFJIZ3J5SmQ5Y1c2S2hRM3YvdUhl?=
 =?utf-8?Q?HFHWCZy/eb+9ZURp1ihyvKBQU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U0w0d2E3WTNoQXczMnhlU0JNbkFiUERCS1ZEQmxUZnZiTzc0WkhGZnVjZ2hT?=
 =?utf-8?B?Y29SWUdQRVdxY1ZSZGd3UjJpdWZLb2ZJdXJLcldvb1pXKzJlODdrK0FSdVUy?=
 =?utf-8?B?TVlWQ09adTZwV1pWZHpLMlFUL1dSNmQwbmFjeTMrSnBMbTBGNGZMM25EdjZD?=
 =?utf-8?B?emtMQkkrZnJ1UVR1V2VITE1nZzQ3cUwwc0pIWldJMWF5ZVZlbllPdk9zU3Rl?=
 =?utf-8?B?dHcvTnd6blBKcXpyY2Noa3kyUVJ6cEVnQVhKQ1F0WXpDU21Wb3NUNHNiZjNy?=
 =?utf-8?B?QU8yQnVsYmZNM1NTNG5OeTdiTE0zc0VNb2oyaWc0d1BTNW1LV29tUTl0cWhU?=
 =?utf-8?B?czRpSExObEVVcHIvcEJtQ29udnpkQ0d4b2FnOWJDa2tGTlFMRFlxMUlpRlQ5?=
 =?utf-8?B?dFMwOGdRdk1heVk0QW5sSFJmUlRPVkU4dEs4Qkh3UzFaQTRDdVRzYXRVQUZz?=
 =?utf-8?B?eGlXRmpqcE15RmQwM2RoOFU5bVV3aDAveDMxZkRLNUtnSDhrRFBzbWx3cGcv?=
 =?utf-8?B?cUk0U3dMQWtBU093RThGVjcwZWNVR0dvM1A4K2hjeitsb3drWktsTGhVQ0hL?=
 =?utf-8?B?bzVWcDBDUjdlV0tOYXNPRVdmV1U5N0hqdGNDdGtVdHJoV3h2YUV3OE13d3Vi?=
 =?utf-8?B?V2FHQ1hzTStpeEQ4SXpiMk5XRnN4Um1XaGNxVjc1ZEFqNGJRSzBucURab3Js?=
 =?utf-8?B?M2RvUXlxKzBVbExyaTlKU3N6amViUW1sK0ZHNGtCQlFmUG5GTXFCTUY2ZERl?=
 =?utf-8?B?MEJ3dVBUY25yS0JjblJvZHo3b1hrbWk5OUQvcStZUEtyUlVvTElyQUUwVTg5?=
 =?utf-8?B?bUZTREU0M1BaWWVabUk4QnVmd0ZUQTVNSEtXVXlGai8vOGUxbkV6VXN6cHhO?=
 =?utf-8?B?K25CNHVtcmtZbzFEUEJDQjB5aXJSOXk0TWlxWGxuZWJDWHcyUmdjb05LS3d0?=
 =?utf-8?B?N1BEZkQ5bUxrWHFwQ3JXdjJ1Vy9FdzlUeUExZGJML2MrS3NnRVdWUXBBdytR?=
 =?utf-8?B?bmQ5dVUwbjZKR3JZSjN4SGhCa2lPdjJxRXZGaElSR2krUExhQkptZHRhWGpX?=
 =?utf-8?B?YldQWHlkL2w1aUhtc0wrTlJqWS9nTXhtOUQ5dHJzNUs4N1EwQkZUdElDNlpF?=
 =?utf-8?B?eitkTXRnUXBET0dwT3oxMUQxdGlid1RkcWMvbjhIVmhrVDVKcElLWFNoK1ha?=
 =?utf-8?B?R3N5QU1HeWgyaGNwOGh3MWxoSmRrTXZlSjE1N2I5NisxbnVOVmxvN0owRFdj?=
 =?utf-8?Q?WzRkfgz3JtEuVdk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517706ae-a5d2-4d33-4dfd-08dbf5f35a8a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 00:36:14.9663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /F2TkPVhDpzGijBTKDchNwtFFDHBRk1/2Fa3BNJOZUSrqUA4/GZGTkE4DcQEQsroSNimuDr9zBx9wN2v4hgJBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_20,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060002
X-Proofpoint-GUID: csUMYfY-V8I5OSuh-TWciC0lP6tASZw7
X-Proofpoint-ORIG-GUID: csUMYfY-V8I5OSuh-TWciC0lP6tASZw7
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 12/5/2023 6:23 AM, Eugenio Perez Martin wrote:
> On Fri, Nov 3, 2023 at 9:19 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 11/2/2023 5:37 AM, Eugenio Perez Martin wrote:
>>> On Thu, Nov 2, 2023 at 11:13 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 10/19/2023 7:34 AM, Eugenio Pérez wrote:
>>>>> Current memory operations like pinning may take a lot of time at the
>>>>>
>>>>> destination.  Currently they are done after the source of the migration is
>>>>>
>>>>> stopped, and before the workload is resumed at the destination.  This is a
>>>>>
>>>>> period where neigher traffic can flow, nor the VM workload can continue
>>>>>
>>>>> (downtime).
>>>>>
>>>>>
>>>>>
>>>>> We can do better as we know the memory layout of the guest RAM at the
>>>>>
>>>>> destination from the moment the migration starts.  Moving that operation allows
>>>>>
>>>>> QEMU to communicate the kernel the maps while the workload is still running in
>>>>>
>>>>> the source, so Linux can start mapping them.  Ideally, all IOMMU is configured,
>>>>>
>>>>> but if the vDPA parent driver uses on-chip IOMMU and .set_map we're still
>>>>>
>>>>> saving all the pinning time.
>>>> I get what you want to say, though not sure how pinning is relevant to
>>>> on-chip IOMMU and .set_map here, essentially pinning is required for all
>>>> parent vdpa drivers that perform DMA hence don't want VM pages to move
>>>> around.
>>> Basically highlighting that the work done under .set_map is not only
>>> pinning, but it is a significant fraction on it. It can be reworded or
>>> deleted for sure.
>>>
>>>>>
>>>>> Note that further devices setup at the end of the migration may alter the guest
>>>>>
>>>>> memory layout. But same as the previous point, many operations are still done
>>>>>
>>>>> incrementally, like memory pinning, so we're saving time anyway.
>>>>>
>>>>>
>>>>>
>>>>> The first bunch of patches just reorganizes the code, so memory related
>>>>>
>>>>> operation parameters are shared between all vhost_vdpa devices.  This is
>>>>>
>>>>> because the destination does not know what vhost_vdpa struct will have the
>>>>>
>>>>> registered listener member, so it is easier to place them in a shared struct
>>>>>
>>>>> rather to keep them in vhost_vdpa struct.  Future version may squash or omit
>>>>>
>>>>> these patches.
>>>> It looks this VhostVDPAShared facility (patch 1-13) is also what I need
>>>> in my SVQ descriptor group series [*], for which I've built similar
>>>> construct there. If possible please try to merge this in ASAP. I'll
>>>> rework my series on top of that.
>>>>
>>>> [*]
>>>> https://github.com/siwliu-kernel/qemu/commit/813518354af5ee8a6e867b2bf7dff3d6004fbcd5
>>>>
>>> I can send it individually, for sure.
>>>
>>> MST, Jason, can this first part be merged? It doesn't add a lot by
>>> itself but it helps pave the way for future changes.
>> If it cannot, it doesn't matter. I can pick it from here and get my
>> series posted with your patches 1-13 applied upfront. This should work,
>> I think?
>>
>>>>>
>>>>> Only tested with vdpa_sim. I'm sending this before full benchmark, as some work
>>>>>
>>>>> like [1] can be based on it, and Si-Wei agreed on benchmark this series with
>>>>>
>>>>> his experience.
>>>> Haven't done the full benchmark compared to pre-map at destination yet,
>>>> though an observation is that the destination QEMU seems very easy to
>>>> get stuck for very long time while in mid of pinning pages. During this
>>>> period, any client doing read-only QMP query or executing HMP info
>>>> command got frozen indefinitely (subject to how large size the memory is
>>>> being pinned). Is it possible to unblock those QMP request or HMP
>>>> command from being executed (at least the read-only ones) while in
>>>> migration? Yield from the load_setup corourtine and spawn another thread?
>>>>
>>> Ok, I wasn't aware of that.
>>>
>>> I think we cannot yield in a coroutine and wait for an ioctl.
>> I was wondering if we need a separate coroutine out of the general
>> migration path to support this special code without overloading
>> load_setup or its callers. For instance, unblock the source from sending
>> guest rams while allow destination pin pages in parallel should be
>> possible.
>>
> Hi Si-Wei,
>
> I'm working on this, I think I'll be able to send a new version soon.
> Just a question, when the mapping is done in vhost_vdpa_dev_start as
> the current upstream master does, are you able to interact with QMP?
Hi Eugenio,

Yes, the latest version works pretty well! Did not get to all of the QMP 
commands, but at least I can do read-only QMP without a problem. That is 
able to address our typical usages. Thanks for the prompt fix!

I've rebased my series on top the .load_setup series instead of the top 
13 patches for 9.0, as there are some other dependent patches from this 
series to avoid duplicate work. Am debugging some problems I ran into 
after the code merge. Once they are sorted out I'll post my patch series 
soon!

Thanks,
-Siwei



>
> Thanks!
>
>> Regardless, a separate thread is needed to carry out all the heavy
>> lifting, i.e. ioctl(2) or write(2) syscalls to map&pin pages.
>>
>>
>>> One
>>> option that came to my mind is to effectively use another thread, and
>>> use a POSIX barrier (or equivalent on glib / QEMU) before finishing
>>> the migration.
>> Yes, a separate thread is needed anyway.
>>
>>>    I'm not sure if there are more points where we can
>>> check the barrier and tell the migration to continue or stop though.
>> I think there is, for e.g. what if the dma_map fails. There must be a
>> check point for that.
>>
>>> Another option is to effectively start doing these ioctls in an
>>> asynchronous way, io_uring cmds like, but I'd like to achieve this
>>> first.
>> Yes, io_uring or any async API could be another option. Though this
>> needs new uAPI through additional kernel facility to support. Anyway,
>> it's up to you to decide. :)
>>
>> Regards,
>> -Siwei
>>>> Having said, not sure if .load_setup is a good fit for what we want to
>>>> do. Searching all current users of .load_setup, either the job can be
>>>> done instantly or the task is time bound without trapping into kernel
>>>> for too long. Maybe pinning is too special use case here...
>>>>
>>>> -Siwei
>>>>>
>>>>> Future directions on top of this series may include:
>>>>>
>>>>> * Iterative migration of virtio-net devices, as it may reduce downtime per [1].
>>>>>
>>>>>      vhost-vdpa net can apply the configuration through CVQ in the destination
>>>>>
>>>>>      while the source is still migrating.
>>>>>
>>>>> * Move more things ahead of migration time, like DRIVER_OK.
>>>>>
>>>>> * Check that the devices of the destination are valid, and cancel the migration
>>>>>
>>>>>      in case it is not.
>>>>>
>>>>>
>>>>>
>>>>> [1] https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/
>>>>>
>>>>>
>>>>>
>>>>> Eugenio Pérez (18):
>>>>>
>>>>>      vdpa: add VhostVDPAShared
>>>>>
>>>>>      vdpa: move iova tree to the shared struct
>>>>>
>>>>>      vdpa: move iova_range to vhost_vdpa_shared
>>>>>
>>>>>      vdpa: move shadow_data to vhost_vdpa_shared
>>>>>
>>>>>      vdpa: use vdpa shared for tracing
>>>>>
>>>>>      vdpa: move file descriptor to vhost_vdpa_shared
>>>>>
>>>>>      vdpa: move iotlb_batch_begin_sent to vhost_vdpa_shared
>>>>>
>>>>>      vdpa: move backend_cap to vhost_vdpa_shared
>>>>>
>>>>>      vdpa: remove msg type of vhost_vdpa
>>>>>
>>>>>      vdpa: move iommu_list to vhost_vdpa_shared
>>>>>
>>>>>      vdpa: use VhostVDPAShared in vdpa_dma_map and unmap
>>>>>
>>>>>      vdpa: use dev_shared in vdpa_iommu
>>>>>
>>>>>      vdpa: move memory listener to vhost_vdpa_shared
>>>>>
>>>>>      vdpa: do not set virtio status bits if unneeded
>>>>>
>>>>>      vdpa: add vhost_vdpa_load_setup
>>>>>
>>>>>      vdpa: add vhost_vdpa_net_load_setup NetClient callback
>>>>>
>>>>>      vdpa: use shadow_data instead of first device v->shadow_vqs_enabled
>>>>>
>>>>>      virtio_net: register incremental migration handlers
>>>>>
>>>>>
>>>>>
>>>>>     include/hw/virtio/vhost-vdpa.h |  43 +++++---
>>>>>
>>>>>     include/net/net.h              |   4 +
>>>>>
>>>>>     hw/net/virtio-net.c            |  23 +++++
>>>>>
>>>>>     hw/virtio/vdpa-dev.c           |   7 +-
>>>>>
>>>>>     hw/virtio/vhost-vdpa.c         | 183 ++++++++++++++++++---------------
>>>>>
>>>>>     net/vhost-vdpa.c               | 127 ++++++++++++-----------
>>>>>
>>>>>     hw/virtio/trace-events         |  14 +--
>>>>>
>>>>>     7 files changed, 239 insertions(+), 162 deletions(-)
>>>>>
>>>>>
>>>>>


