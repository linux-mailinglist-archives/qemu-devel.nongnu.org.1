Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF559751A6F
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 09:55:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJr9G-000753-81; Thu, 13 Jul 2023 03:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJr9E-00074m-2p
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 03:54:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJr8z-0002wV-Dw
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 03:53:59 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36CG1ZEH008216; Thu, 13 Jul 2023 00:53:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=lsrE/pKl9JlLJFQDofnYpYt1A0vJed7oJIzGyDVTt
 bI=; b=ncGl0Pa2YhTOBzOX+cSF1CDId/2QB2Qjih9w3tkCWxuTjLd+6/P3ykUax
 G2saDyNLvI+1UsOkpEISqxsQgSY+9Z6vyziCv78f7ePx0n1XCxgGnL+ZLzQP8A2x
 PlrtvoUZjgpq29awdR+CwBO1FTqUwg+e5Av54NmGFcwmh7DC6QyErvKYBfxpq3sR
 bmNwTHuvxPgcqOs8ULKqnO6rFvzlpNdsYUf4Ft4Ef8etNAPw2YxxlpNiFYndFEQa
 Nu93sVqC40rq9IMYJds2xb2ZFQnZBQYc6ALNdUnMqULsY2axcNApC8lgXSQnlA/7
 TRK3z5+opof77qKLtJg5/1IjlX4vA==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3rsyb39h84-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 00:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkMbKFAFe6Vs58M6of90NQGEs3tAyerGLoDAhLuBWfH6QJEpyGKtk9spTa/L7N8c7G/a0llsAamMlb4JrxlDBiL//rtR44AytEXIWhZ2XeWX+Eh4iAJTTwNtsub+pB7B8KccLmzQDTgPsV5fthABfgCc6Iv7Bb2pUG71QrYumJNp6dFYg0iV3Xwj7bWChSNvYliBdZV2Bd0enNxII1uWH8XvuqZuTOGjXkJTaskCE9ymd2amwPH00qYyXlYzqOO52XSrxASx4/1JNYqDrromnD6pvp7CKDRYjdhoohUJLDwhWHo4W9GP2bB+jztVFeRLj0QkmqLNDtlWRb7ZwXbT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsrE/pKl9JlLJFQDofnYpYt1A0vJed7oJIzGyDVTtbI=;
 b=G6X+m3m8Xhga9YFnJ+0Fkm+oJO2Q32TKIHRUEXt/RsgddI/vT0dZBk4u7vv4i3wDZknZq5l1aIN/jtwCnG7StaY5Coc1pwQKvrrmn4D7inq6g6oruGoagKAMXEFP+NYYcndVwur2p9Rn2qXsFTS5goe4h5m3SRrsa/c9ZD2A4yxtW2lDSBfLcZnQT3BRfDfrHjeBKCDoOkrgGbK3U6YvLPHR99Sfzm10LxTQtPSmJa4vjdAoxz1wi6aSiJFc2Oo9ONIN1JAI4eEpUUkVVyv1mWjnPBtRnhFD6MDaqOMHBttY35t0T5YH4rCKZCyHQg9GSEDLV2t9TxGQdM166tvbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsrE/pKl9JlLJFQDofnYpYt1A0vJed7oJIzGyDVTtbI=;
 b=bEF5xrQJKl+WQvhiL9RRyddXtTysUKXjOV500CODwiUimtRMm5GQpkSCHqFN48owRoDFssTiL/WkMzeBRrX1BrPT5e+C/V5Lmta8qq8NvSRvAG7DEE19ESkx89sjyTA2PlqYwo4zlaBo77Kr0wdPynco9J2eYZhP/Txi3Ia0sffMxxZwq3vwQ2Tej/3UoCL563pp1ozWcuM/yPjVM6ZHKD99QYuftWyo+gDo+6s9XZO3iLOBWi0YRyPHbGwpNPDPvBFg9NXRXg3hJXY0vk3aoaTANfYQE6sYhYhjr9/Jaao9I1Kdt6sPiJwQFgdln+Iwoa9J6aMdpI591CbM90BM9A==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by PH7PR02MB10092.namprd02.prod.outlook.com (2603:10b6:510:2eb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.14; Thu, 13 Jul
 2023 07:53:39 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 07:53:38 +0000
Message-ID: <f8faa85c-7947-2b24-7338-9adfedbb94c2@nutanix.com>
Date: Thu, 13 Jul 2023 13:23:26 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v7 1/9] migration: introduced 'MigrateAddress' in QAPI for
 migration wire protocol.
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230710122750.69194-1-het.gala@nutanix.com>
 <20230710122750.69194-2-het.gala@nutanix.com> <878rblqog3.fsf@pond.sub.org>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <878rblqog3.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::15) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|PH7PR02MB10092:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f04fc8-8b63-48d3-41b8-08db83764463
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yS/XLyoSjZYwH0o+yrg+YLnsbMONGZpu9IRYamAThPxnztBHBXFJYar1mrzIoLg0lrusVotXKAK6yJ1vMZNYjANd95i6nmaM/Gsqooxy8sg38I2n1RPkyzMTd/kpgtn/sqKSnBhbcQLQ+FxkbS2GjYI9//8rJjl/nUpi7lv62zrgQa0wsWH81zHj4Pk1ui6H3XlK8IBkFpUrf7JW5gU01v6213Yjc18td75LKLgSTSS2MButnQAFT3PqPayV4Ej3c7M02gszGzPxWktdmvCNrvNOU7oCT32eFcL2LQ3VFmjbn2l/0JZ6+zVYwDoeZoHM9GqwSO+0qgqHLVB/pvTgxJnSFDxZIi4RQDBr0lFh3KlSxwncFcBPi8NdPbEQdF6B8j2C+4PCKF08f/4e6Dnwkh8JSDKdMdW6sQe3650zo2fbq2rO+nrVwSvwpz/aIm95C7nzdQQvvGijp5QPKwsG2kAYTdsxwHFwf8OVJuTENszm6BCNhkiBHVfx8A16rdMAxf9lTFWZZdPJh9Xus6jbWm/R2nadT3bPbyxdOC410MpcDfUMoK3AH3SXOc15l3opnomJfcGlPro7IlWMGr6KSCGYt7i6o5jE6Y2rtFq1fmZxKZe1dJFMvrKHcgg4URWBZ1eezpsMf7kaSmOBPw0vKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199021)(31686004)(66899021)(478600001)(6666004)(6486002)(36756003)(83380400001)(53546011)(86362001)(2906002)(2616005)(26005)(41300700001)(31696002)(6512007)(6506007)(107886003)(38100700002)(186003)(5660300002)(316002)(66476007)(8936002)(8676002)(6916009)(44832011)(4326008)(66556008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXJmT1dtdkhjWGlpWTJQQlMyVFdlZ01rSVV2R1d5aytSSzBvQ3FMS3ZieHVP?=
 =?utf-8?B?RHFzNjhZbjBhV3dmVXg3R202Nm5Nb0toVEtJWWdON1l5QTJBUEdneWMzWXdI?=
 =?utf-8?B?cjR2UjV1OXRBdUpYNzBVNC9KSWZIWmVqNHRHN1QwVjUyOTd6bDkxVjY2Tjhk?=
 =?utf-8?B?THphZlpITlJYSHErbWJGSHhqYUxoeWJBalpxU0NiS3NEYWtwUUZDZkdDcWpZ?=
 =?utf-8?B?Y09GSmJVYW44ZDJjSTZZa0hUeTFvenhZc1RnS1djQkhDWEZxRTFBQzJuUldP?=
 =?utf-8?B?WVhYRy9DazJLdytLWW1FTlVONk1VVko3cHFWQjZoTUNoZlVVcFViTUhwYStP?=
 =?utf-8?B?VFk3Y0FjOElNcHFZS3N0N2wvcjcybDB1eVJVOGZpeXhOVytmTWc1RXFNQjhF?=
 =?utf-8?B?ZEk0a1pUeEdZczFrMG9HMmNsUlNnN0ZwWmJEVVlQbkR4NXdUZHBDdGlwejdP?=
 =?utf-8?B?dFZiaVpDMDFuNGF5VHdvK243WGFzQUt4WDdsbXZBSTFOWTNFRXlUVmdzdERB?=
 =?utf-8?B?d3hOUkpaQVNFTFlRNHcwTGZKb1ZURHZqclNReEd1RFJSaWdFTmt2ZEpKNG9Q?=
 =?utf-8?B?UmlkTjBWa3V2QktwOVZTMEdHclhyajJvOWYyRnhydmJoejV3WFlPZEVkZUpR?=
 =?utf-8?B?RXQ2RXBJMDMzZkl4YjVMZUg0cmZEeFBnckpwNXIxM3ZBc0RxUUtNaVRFTFov?=
 =?utf-8?B?U3p4SXpmRTBmSUxtZ1ZlSVEzMzE4T0x1UlFXdW5ZTWg0dlNnRXhzekkwYmhs?=
 =?utf-8?B?SGN6YWFQMGlhd0s0Ui9yLzVVdWx0OVpOeW92Q1pnbENmQ1R5WElselZ0dHE1?=
 =?utf-8?B?enc0d2Z3OXNwOWFud3pxVDkzWU1EUGF5Q3Y5clFJeGUxL3RiNVN2WWtLWkpk?=
 =?utf-8?B?bE4zTHhKU0phNW5ZOXpHSmNUa3lCN1BBUzJMVS9HTktyWUQzWnQra3UxSEtC?=
 =?utf-8?B?NWMxUjhmNUdkOHNpN2kxeTVYU2oxc1RPempPZDRVZTczV09ndkZUQlBoTGRx?=
 =?utf-8?B?d1Rpdmh3d05TeDRaTGpPKzlRalpMbE5RRllsVDFJR2M4NUtXc1BZZTV6U1Vv?=
 =?utf-8?B?UUxrOGxlNU40MGk2elZ5YWxaWkRTdDhnS2ZpaHRHTjBlVW5mNUdhYVVkRklG?=
 =?utf-8?B?ZlFnVHVPRFExSHlaVCsyajg5Q3c5ZG1kcXIyUmRqZ0pKR09vMFRvS2xiUlNK?=
 =?utf-8?B?NXpJRis4dFpFdUszY0w2NnM4M042VjF5cDlwMzhkNjc2SXE2dnk4dlBSMnVu?=
 =?utf-8?B?b0s4TDZkSTl5N2xYVWtsVE4wcGQ1OE5PZStWNXpDMmxBVWwvbko1Kzk2b05G?=
 =?utf-8?B?V0EveUJhbkJPdkxiek4rSjkzaG84NkNjenFUQlJlYithbEd4YUJsQlp1NDJl?=
 =?utf-8?B?aWRHTFFJZ0pyVHRVWFhKS2d4OWVtSUhhY2lPSEpuV005TE8zOFJXL3lvaXRR?=
 =?utf-8?B?ZStuM01WamxUcVE2YmRWQWpsWnVWNTRHZ0gxRzhraU1nNDl6RjZUc1dkU1g0?=
 =?utf-8?B?eGIrU1JPc0dlNEladzViQzRsWnpNL1RxZXRSeTNjOXUrTmlaMyt4bnk2bVRz?=
 =?utf-8?B?L3huVHQ3bU9vTjVJVHlOTVMrV2ZIUFlJYnQ5bTJrb1RNUEZMcnJvdDhWa1R0?=
 =?utf-8?B?SG5HK0lKRFN3ZVRVTjFRZmczcExZZXBrT1Bqc1BSWTl2ZFpEcjl6NzZ1WHdG?=
 =?utf-8?B?a1k0WmhvemhLV1RFNXhWakRqT29DU1ZiRThKQ0p1UytwUDFoTmg2TXNCNU1i?=
 =?utf-8?B?dWt1d3cybVQ5OUhkVTZZR0JYY0gzM1MxUnFYMGpsSi8zOW9IeUJLV3ZVVUVF?=
 =?utf-8?B?T2EvbExOTVdnYVlBZlhQNFlPK0pVY0RtQzRCbm9pb1paNFV2MmxXV2hZRUUy?=
 =?utf-8?B?UVdoeWR5dzBBN1lSaFBUMndHV2d2NnZTUUI1WlcvblBXelhEakxSeFU1SWFI?=
 =?utf-8?B?YkxDaVp5R3dkR3pRaVJPUGdVRGZQbDVHTWlhaDRkR1MvYXhxZ1NTRnlmaEh0?=
 =?utf-8?B?a2dyVGQwbkpKNUwwa1FQYkFBdURKWGQxK3JPSjY1bFdPMzdCV0l4MkpDMDFi?=
 =?utf-8?B?WmNFZFZHVEV0bUNZeGQxK0lPclI2ZTdrS1FtNTVOTnNZc2xIVjNtSmV5ekdY?=
 =?utf-8?Q?FKuPYXVnM2RLGhxwWXkZYYnQJ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f04fc8-8b63-48d3-41b8-08db83764463
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:53:38.3888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgO6bGifK++T1IBr8VXLK0bJPRyKPKO4PDVtbR/AXpfeWxgc88F4U+1A58xRV/GysrX3soaLD1BfIo7OXm1z7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10092
X-Proofpoint-GUID: 2PFj6blelyTofSJ8gqepXL-i46arbeKU
X-Proofpoint-ORIG-GUID: 2PFj6blelyTofSJ8gqepXL-i46arbeKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.11, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 12/07/23 6:25 pm, Markus Armbruster wrote:
> The subject
>
>      migration: introduced 'MigrateAddress' in QAPI for migration wire protocol.
>
> is rather long.  Try to limit subjects to about 60 characters.  Easily
> done here:
>
>      migration: New QAPI type 'MigrateAddress'
Ack. Thanks for the suggestion Markus.
> Het Gala <het.gala@nutanix.com> writes:
>
>> This patch introduces well defined MigrateAddress struct and its related
>> child objects.
>>
>> The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri'
>> is of string type. The current migration flow follows double encoding
>> scheme for  fetching migration parameters such as 'uri' and this is
>> not an ideal design.
>>
>> Motive for intoducing struct level design is to prevent double encoding
>> of QAPI arguments, as Qemu should be able to directly use the QAPI
>> arguments without any level of encoding.
> Suggest to mention that this commit only adds the type, and actual uses
> come in later commits.
Ack.
>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   qapi/migration.json | 41 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 47dfef0278..b583642c2d 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1417,6 +1417,47 @@
>>   ##
>>   { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
>>   
>> +##
>> +# @MigrationAddressType:
>> +#
>> +# The migration stream transport mechanisms.
>> +#
>> +# @socket: Migrate via socket.
>> +#
>> +# @exec: Direct the migration stream to another process.
>> +#
>> +# @rdma: Migrate via RDMA.
>> +#
>> +# Since 8.1
>> +##
>> +{ 'enum': 'MigrationAddressType',
>> +  'data': ['socket', 'exec', 'rdma'] }
>> +
>> +##
>> +# @MigrationExecCommand:
>> +#
>> +# @args: command (list head) and arguments to execute.
>> +#
>> +# Since 8.1
>> +##
>> +{ 'struct': 'MigrationExecCommand',
>> +  'data': {'args': [ 'str' ] } }
>> +
>> +##
>> +# @MigrationAddress:
>> +#
>> +# Migration endpoint configuration.
>> +#
>> +# Since 8.1
>> +##
>> +{ 'union': 'MigrationAddress',
>> +  'base': { 'transport' : 'MigrationAddressType'},
>> +  'discriminator': 'transport',
>> +  'data': {
>> +    'socket': 'SocketAddress',
>> +    'exec': 'MigrationExecCommand',
>> +    'rdma': 'InetSocketAddress' } }
>> +
>>   ##
>>   # @migrate:
>>   #
> The issues I'm pointing out don't justfy yet another respin.  But if you
> need to respin the series for some other reason, plase take care of them.
Ack. I think from QAPI side, the patches look good. But from code 
implementation side, I haven't received acked-by or reviewd-by from the 
maintainers. So would anyway need to respin the series I think. Cc'ing 
Daniel, Peter, Juan and other migration maintainers for reviews on other 
patches too.
> Acked-by: Markus Armbruster <armbru@redhat.com>
>
Regards,
Het Gala

