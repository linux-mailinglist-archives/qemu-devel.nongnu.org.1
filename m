Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73867715D7C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:41:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xhG-000846-SE; Tue, 30 May 2023 07:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q3xhB-0007yo-0E
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:39:21 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q3xh8-00048h-0g
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:39:20 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34U8jPCJ002772; Tue, 30 May 2023 04:39:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=content-type :
 message-id : date : subject : from : to : cc : references : in-reply-to :
 mime-version; s=proofpoint20171006;
 bh=VSCdDueMIzxTEKMujx/gZTpDO9P/2F1O/5iLOHk2AB0=;
 b=Qn92a+8Z9wF+6Bz//YAjgYpCgVt00Evd6pY3G4FNcoJRsnC2qAg0kRhKPCh3C7I1mS90
 EUy9LsBiirF48szaYY5IXbiMXLsnGkLLu9J2xr+uxD44zgVvFcFFw8UV2QvSNpmWghtC
 kuMOsu+ttWbEtPZ0o5eddSd5s2rFQKkh7hdzfCKY7DuCsbC9K4IxmtOJMJH7cI+G4ob0
 RnSyXoLdq/7vni2VwhANgJWwIgeXelR5KWnG1E15V231LyoO+73+sMEw3GfvfZByoO58
 l+BsAGLDcyxVDJdCfvYgYFL17FvDDel1DzZ9N92Hm3NCWHHC1A4Jpx5O6OaLPBOdGlFH Kg== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qufyf6vwe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 04:39:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hh/mYexStYGEibt72eKcgy4TGGWmbPMlOu4UMMN1kJjfzbyBBZk3wOOyc4dL0e25yQIgDwzajYmRFOkuZqBEfsFyMrNDBCBkzFjc+a4KemLhN+VLtSqzYUpq5pUWkEpz9MCWwcPIEnRyUJfP4pI/UkBMoSCJ3IL/Tv+6OJu6uOBExWmIa6Dx5fgraQ/ocsE01q1ImSvm8RuaGkaOTm80VqCfpl8FvTedzRC1Rr8SLsxI5IWAzkn0Wt/ysIJEPvBkIOpmIeNL96MV6ozfy9RaujcFx1Ykiv6mO7tyUwgG1IuLAjFX+eVEf2G6pmwO+nydSdBTJjLEWsc9lMJZyAxr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSCdDueMIzxTEKMujx/gZTpDO9P/2F1O/5iLOHk2AB0=;
 b=K9dANG3Zvsjzc0Bc1RpZsJl4DktQ3WL3402ibNuthwEdYAklRp9zPwsAuXnMxZ1YrJhf0R9+Qh3wjeKlPtPxsulJ4vlQlj2C3nLU4nUb8w2QeBuWxoPiaje+6Cys0Y318hQmHA3yGI5QRhhukwJzsYzSlK7I7ap3we2uMNQCIQmhZ8m+F4hnopxLksqf62ivk5CQ1C6NjRY5BAo+1kVw4EZDcpdG8V7uGahlPiuh5GqQr0eYx5WUjPWp/XvLRSlKMuQcWyQsvgiiJYKUgFUuLHdS6z6qiQ+yOD8wPUj2rXRY1KOj1DoA7HJTxewPh9Qf9Tvim9eqP0fImXO2Py4euQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSCdDueMIzxTEKMujx/gZTpDO9P/2F1O/5iLOHk2AB0=;
 b=X0rZc6V9pkzxXnay/+exO30I/cGzZWv8BHSME38mpox3DxwTAfpYs1KU2Yi1N0gOIgSCDx8x8OxoJVWwUB4ENwdyWidupAvfZ+j+U0YdXcnu6oRv7pNtR0cZIUo1iEf+bHJ5mMWe8AF20g2L4lyEqCRGNT+ny6r47aEZKVifaPi4T9Gf8OsxYv4dLVl8GgqSYjbjqU6gbWogrfCjQJJgUYRLkPRD3MWCrYBOOGozfe5J9ge6wDwBnb8i/WtYZIZUkPDyfBrK2DhrKFla4lT0KQ5pGlnBQ7Q8IdYO1bsCXS9Vs80XSKhV+h+r+HAZStLMO77LIr4VisiTgfJiIvd8rQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CO6PR02MB7538.namprd02.prod.outlook.com (2603:10b6:303:a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Tue, 30 May
 2023 11:39:11 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 11:39:10 +0000
Content-Type: multipart/alternative;
 boundary="------------VE640ro2Yppzq8wxv0rm0HqT"
Message-ID: <d3627b53-4e90-e58d-0ef0-a5584612ce39@nutanix.com>
Date: Tue, 30 May 2023 17:08:58 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/9] migration: introduced 'MigrateAddress' in QAPI for
 migration wire protocol.
From: Het Gala <het.gala@nutanix.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-2-het.gala@nutanix.com> <87sfbkjow3.fsf@pond.sub.org>
 <af2e5fbe-75f5-d6dd-df8c-8894cc5b0056@nutanix.com>
 <87edmyuwzc.fsf@pond.sub.org>
 <99b3e516-2a4a-aa48-8bc2-7bb886b8db52@nutanix.com>
In-Reply-To: <99b3e516-2a4a-aa48-8bc2-7bb886b8db52@nutanix.com>
X-ClientProxiedBy: MA0PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::9) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|CO6PR02MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f84a2e-bfa1-45e5-5f26-08db61027bcc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mI2vcrBCw3U44FVzUqSVtWgiwLI1qqeeXDuF59GF8mnufA0Zj04SI6+CeM8HNCSvH03VwTwGCzCPoDqoGT8oByPXutbLmjAPidd3e5tDprifnvOTTGX33NzF++mAdVB0ZtRYWx68OblsvQ72/S7nu9VuV7m59fCWJ9oFNSHY1waJwhmGjDx2EH/e43QPoK+jDkbFpB9/X724D97AE/skZynvmfwELAhS2EzZNwkuXvLmybFsXHX3zyA373je5Q9mppl7Q6HZxm1iwDfg6RCtVDjqTJV3ZlgXbjkPYVhay/ONhZannLY1cus4oMs9ReIKCcRUtwBhckAd6zPoER6EIEHxAShLLeCvSayCYGqfSC1itRb8luHAqTf2OsYykE28ZZrjXuf6yvmcHJKLoiJj1Z0ecdkEav+iWi1FayB9ehJdwVTfdRJDKlaAYm84X9Lb0+P/jE8/nAXyCl+ABrA4UmZG77xoUg7Kfee9Tg8jIALiYpEj9gzRARt6LyTxShXcttczUIGmfahAB2tWl82Xoa1Cbn6nUb5edB0Wv8p8QJAvt+E8BxFdrWuGodB8G5aT+arEa50btDcAkSHpkGRKO4XnK7msayR//6R9bKLoL4M+Z/AtW679alw6rQg2NvZA6Z+Fq+44FMQqweXXFkcAmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(41300700001)(31696002)(86362001)(33964004)(6486002)(316002)(6666004)(4326008)(6916009)(36756003)(66946007)(66476007)(66556008)(66899021)(478600001)(31686004)(44832011)(107886003)(5660300002)(186003)(2906002)(53546011)(8676002)(8936002)(6512007)(26005)(2616005)(38100700002)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDA5dHk3Z3VBM1B3RVpVYTQvaFRNZ0V6OUxoWi83cG1QOXM1NzBlV0QzenZD?=
 =?utf-8?B?SzlyNllLdFZMMDJRRGtYcHpTN2dxZWoxUHVRN1A0QUlaeGZsbGdSKy9iRnZr?=
 =?utf-8?B?UFpvQnFwcWNoM1pYVVM0aVJ0RlQvMFg0bTJXQ0ZMdTFKVjVVOU9mMWpGNVNm?=
 =?utf-8?B?RTZWdEgwaXZoQXoyR2VFa0ZyK1Q2V2NyTlF6ZzFVU2dMajluaW5rUnlWT0Zo?=
 =?utf-8?B?bDRYU1FrbXhiaFZ4MDZHVStQeEFRZG5GY1RIZTFiYVhoUHFDTjl2N2dVSmta?=
 =?utf-8?B?Zmt2Rzcwc3JtSkFqNlRHODVNQmJKTlptaFpSa2FLOWo0QjJNSmlBZG82WkV0?=
 =?utf-8?B?c0Z2aWNRTEgwczNvcEtmZXF4N29vRlNIMi9BMXYreUlnK1phZmJEbXRkejc4?=
 =?utf-8?B?OVVjaFJVbHI5bVlSWmFzWm5HTXh3SHdmdFBNcTBuaW9sMk1NTURCUHVBaVJo?=
 =?utf-8?B?VlFBVXdncG90RDBySUR5S1lOWjhqb1FMUm4wN3FlV0c1RXZnRC9vR29LaTRV?=
 =?utf-8?B?NFBoY3djOFoxMy8wMi9WZU9aNHNDS0VPd1dGMlFTS2dLSWgyaE9iTE1rQ3RD?=
 =?utf-8?B?U3ovZVAydWxqZHFGZC9ab2t3RFl5QzJ3aDJPcFkwZEdnUHVUaEhSRGZVeEl2?=
 =?utf-8?B?THV6US9FSWhmNy8wb1EvL09MczVZcFlkWWtwQ3NDQTNWNjlSYk9PbklzRExE?=
 =?utf-8?B?VWtBTXVyVmtvb3dFY0RtSlgvQ2hqNkhRSzdrdUpVTmdGMmZGV0ZIVUhPcnQz?=
 =?utf-8?B?SE1VbitrMk82SXhTVXEraUtpeGhVK25EUnhSWDBiQWdOWWpUUkpuaHRQQSs1?=
 =?utf-8?B?aHlwTDBIK2ZJRnpqeXJiZmhSRHZVTkdDNzF5NEVrVjgzbU9jS0QzS1VCOVh1?=
 =?utf-8?B?azU1VTZweGJqVkljWkQ1WWh0UUNPdWdUVWNyQ2VsaFBNYUtXa2s0ZnoyMWVa?=
 =?utf-8?B?c1l5NjlaN1hqK3d6WS9kcTc4NHJ6ZTVzamEvWXc5TEVqdGFHWFRPdGpsVi9x?=
 =?utf-8?B?dXhJb2pPYWw5bGxSTkliLyt0eHJ6WkwwZ0pvN3FDZVNqMjZiWng1VU9aQlc1?=
 =?utf-8?B?bmQ5amZ5ZkF3Q1MwQnpOQzV2WFlVTDJ1SEVDMFNuQWxuSVY0cU5DUXptU3VM?=
 =?utf-8?B?U0pKQXB6UHI2UWNrcmt0QVBBMEdYVExtdng0Z3Z5UDFLa3VkL2RXMHFQSzJ4?=
 =?utf-8?B?Y3VMalB5SFc3N09SSFR0eXBIN1g2M3d6cmx2R0FEUDJ1Sjlnb3Jzd2lRZFpQ?=
 =?utf-8?B?S0xqaHBGOG45Z3EwTFJpdncvZTR6NTIyVWRDNXRtQVM0dkZNRkdPYXpiaWVa?=
 =?utf-8?B?T2JHK0ptcUFQWEpqNytocyswZ2RmN0JxOS9XVDFNNHdqTnU1UTZhUnRaNlM5?=
 =?utf-8?B?UWRKaVFOaWNFbk1ZeDBXelhoR2xXcFFIcmFxMG1hRmVOMG1sZWwzOGRHUmlO?=
 =?utf-8?B?c290M3FTVGN6TzdwZGZidDZ5TW1LTWlCbjZveUZXRmcrZDdYSDlnVWZPNUhy?=
 =?utf-8?B?NitiYUFjQWk4dEtzOWd4RnJmMHd1RUgzWVMwbmluSnE4dlRadlRGLzNHSGZW?=
 =?utf-8?B?ODBTdjBFMUJxcmloWEdSRzl0NWZhMEg0WVpYam5aMlhEL0FDVkhPVFR5TWsv?=
 =?utf-8?B?amVTUkt0eFozTDFnaTVGcDQ1a0FWajRrNDcyVVVQZmpSaGVabWIzVkwzNjF2?=
 =?utf-8?B?aThtb3QvMlVhYk82enZoRVlCRS80bUpWc1VlSUIrUEw5ei9xbmU3OGtLYlo3?=
 =?utf-8?B?WUNHSHpIMHdVcUcyTkx5NUh6QnloYWxiZnpqWEk1bGVHS3IvS0RTSnpDNkhl?=
 =?utf-8?B?TTZNOVBEU21YbzNpVFZMSlcreEErSHI3MEJzSlNWZ2VUUituS3RHNFNEb0hh?=
 =?utf-8?B?L2lFb2NCVjVHd20rVFE0RjI1azFvbThySWNVa1ZNTXY4RFFrSEVUYU9PbnBD?=
 =?utf-8?B?TWNTZFMrTGlpenlVRHlzcTBtRE9oRjAyWEwzc3lPNkhDT3p3OWFWZDVKOUlX?=
 =?utf-8?B?VHRyMGNPSE5YSm5DK0hKWCtyOG5OZ3MwamVsb0tYQVlWYVNEcFVjV3J0aVJw?=
 =?utf-8?B?d3pqVmhaYnVtWWVoUFdDRnl1dmJEL2hTOXVSWEFIN3cwa3Nrd0svRVpFV0FT?=
 =?utf-8?Q?6JNM4zSt8QrKR2Dj6HdckXA0q?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f84a2e-bfa1-45e5-5f26-08db61027bcc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 11:39:10.1274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uF+ylEl4Mg5cLmbMx9J8pyRwErcX79QcK3TMUQrMajLKa+o5FIA7LfksNPyRxtP+zTLmUZp9Hf5zzQWjBM0/sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7538
X-Proofpoint-GUID: P6ED4uxQOsFs0eSeu8rmGaibSoX_B4AB
X-Proofpoint-ORIG-GUID: P6ED4uxQOsFs0eSeu8rmGaibSoX_B4AB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_07,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-0.09, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--------------VE640ro2Yppzq8wxv0rm0HqT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 30/05/23 1:02 pm, Het Gala wrote:
>
>
> On 30/05/23 12:28 pm, Markus Armbruster wrote:
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> On 25/05/23 11:04 pm, Markus Armbruster wrote:
>>>> Het Gala<het.gala@nutanix.com>  writes:
>>>>
>>>>> This patch introduces well defined MigrateAddress struct and its related child
>>>>> objects.
>>>>>
>>>>> The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri' is of
>>>>> string type. The current migration flow follows double encoding scheme for
>>>>> fetching migration parameters such as 'uri' and this is not an ideal design.
>>>>>
>>>>> Motive for intoducing struct level design is to prevent double encoding of QAPI
>>>>> arguments, as Qemu should be able to directly use the QAPI arguments without
>>>>> any level of encoding.
>>>>>
>>>>> Other than that, it looks better than what I proposed. Will change it.
[...]
>>>>> +# Since 8.1
>>>>> +##
>>>>> +{ 'enum': 'MigrateTransport',
>>>>> +  'data': ['socket', 'exec', 'rdma'] }
>>>>> +
>>>>> +##
>>>>> +# @MigrateExecCommand:
>>>> Documentation of @args is missing.
>>> Ack. Should the naming '@args' be replaced by '@filepath' or @path' or something similar ?
>> Depends on what @args means.
>>
>> I guess its [program, arg1, arg2, ...].
>>
>> You could split off the program:
>>
>>      'program: 'str',
>>      'args': [ 'str' ]
>>
>> Try to write clear documentation for both alternatives.  Such an
>> exercise tends to lead me to the one I prefer.
>
> Hmm, basically here the @args means, for example ['/bin/bash', args1, 
> args2, ..., <command>], where command -> /some/file/path.
>
> Does it even make sense now to break into 3 different parts ?
>
> 	'program': 'str'
> 	'args': [ 'str' ]
> 	'command': 'str'
>
> This might probably just need to tewak something in the exec file I 
> guess.
>
Markus, Daniel - any comments on this ?
>>>>> + #
>>>>> + # Since 8.1
>>>>> + ##
>>>> Unwanted indentation.
>>> Not able to see any unwanted indentation here ?
>> Looks like it got eaten on the way.  The last three lines of the doc
>> comment are indented:
>>
>>      +##
>>      +# @MigrateExecCommand:
>>      + #
>>      + # Since 8.1
>>      + ##
>>      +{ 'struct': 'MigrateExecCommand',
>>      +   'data': {'args': [ 'str' ] } }

[...]

Regards,
Het Gala
--------------VE640ro2Yppzq8wxv0rm0HqT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 30/05/23 1:02 pm, Het Gala wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:99b3e516-2a4a-aa48-8bc2-7bb886b8db52@nutanix.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 30/05/23 12:28 pm, Markus
        Armbruster wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:87edmyuwzc.fsf@pond.sub.org">
        <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com" moz-do-not-send="true">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On 25/05/23 11:04 pm, Markus Armbruster wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com" moz-do-not-send="true">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">This patch introduces well defined MigrateAddress struct and its related child
objects.

The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri' is of
string type. The current migration flow follows double encoding scheme for
fetching migration parameters such as 'uri' and this is not an ideal design.

Motive for intoducing struct level design is to prevent double encoding of QAPI
arguments, as Qemu should be able to directly use the QAPI arguments without
any level of encoding.

Other than that, it looks better than what I proposed. Will change it.
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    [...]
    <blockquote type="cite" cite="mid:99b3e516-2a4a-aa48-8bc2-7bb886b8db52@nutanix.com">
      <blockquote type="cite" cite="mid:87edmyuwzc.fsf@pond.sub.org">
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+# Since 8.1
+##
+{ 'enum': 'MigrateTransport',
+  'data': ['socket', 'exec', 'rdma'] }
+
+##
+# @MigrateExecCommand:
</pre>
            </blockquote>
          </blockquote>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Documentation of @args is missing.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Ack. Should the naming '@args' be replaced by '@filepath' or @path' or something similar ?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Depends on what @args means.

I guess its [program, arg1, arg2, ...].

You could split off the program:

    'program: 'str',
    'args': [ 'str' ]

Try to write clear documentation for both alternatives.  Such an
exercise tends to lead me to the one I prefer.</pre>
      </blockquote>
      <p>Hmm, basically here the @args means, for example ['/bin/bash',
        args1, args2, ..., &lt;command&gt;], where command -&gt;
        /some/file/path.</p>
      <p>Does it even make sense now to break into 3 different parts ? <br>
      </p>
      <pre>	'program': 'str'
	'args': [ 'str' ]
	'command': 'str'
</pre>
      <p>This might probably just need to tewak something in the exec
        file I guess. </p>
    </blockquote>
    Markus, Daniel - any comments on this ?<br>
    <blockquote type="cite" cite="mid:99b3e516-2a4a-aa48-8bc2-7bb886b8db52@nutanix.com">
      <blockquote type="cite" cite="mid:87edmyuwzc.fsf@pond.sub.org">
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+ #
+ # Since 8.1
+ ##
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Unwanted indentation.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Not able to see any unwanted indentation here ?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Looks like it got eaten on the way.  The last three lines of the doc
comment are indented:

    +##
    +# @MigrateExecCommand:
    + #
    + # Since 8.1
    + ##
    +{ 'struct': 'MigrateExecCommand',
    +   'data': {'args': [ 'str' ] } }</pre>
      </blockquote>
    </blockquote>
    <p>[...]</p>
    Regards,<br>
    Het Gala<br>
  </body>
</html>

--------------VE640ro2Yppzq8wxv0rm0HqT--

