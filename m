Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9337EC9D8
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 18:43:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Jtk-0000Q0-1u; Wed, 15 Nov 2023 12:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r3Jtd-0000Ne-Ka
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:41:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r3JtY-0004pE-4X
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:41:49 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AFHNsX9011959; Wed, 15 Nov 2023 17:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=IcZK4obKdt/KSai2BIevigkGfbgfwn6Hvpho+eOEOlE=;
 b=kHx4j/RN48NKxyaDNkOm3HnGY3mfIgJ3clYOtdd8gxumG4jY3046DJNx/8FXdDIJGTzJ
 e1L8zeTCZOACQv3ufSYs9Qudl4vQoaEQF0Q/857jeq74fZM3WApcVWDsAl63J8KvJaXy
 hmk6l6ThBKG0vK72q65c7a/FZt2SlZPON1uWGpH64End+aIF36bTVWaNWtzct1vvgbDn
 /23v4P/a9LFqZ9ObAb5NdG65jAcpnpCpBDS2vTNl03aa54hIdDBK5XzOPZuBbWN3VjQK
 JihfmL0aTxGENH/7czHPdrGvuhlrwQg0xCDlIwGSARyoRx/ECLJufix7x3EfU3rT85h0 Nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2mdsbu0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Nov 2023 17:41:41 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AFHVLcq003938; Wed, 15 Nov 2023 17:41:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uaxj484tw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Nov 2023 17:41:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipTrqnnLXlpdHIQhN6mIni/lwnx7FT/iery5pRi/d9Mk3sqMZhc9M4hCQmdnt36wzJur/Vx9VSkRUWsgzzP0VPxgjAW3uVKmQwnKg0TzmQEqCZb8ukKLif7mWphvyGRHUu8bF2n4Fg1oNK94JmwSr64x7tMoaEpKqasVMz6jphsJm6fIXHMtVyEvgOxENKptgKaYNJ7ekxWVAjAbAYikJV02DeQ8UErWYtT9msWjMvYDC4XsKp3TT7TNNQecAQYaBnwSg93UyXzzSESiAN5D4i/1otLVWoSlbRa4pWyXFrwiYzXK3kSwMHdggn3HCV5bbtnq40o/edhxENadxfm7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcZK4obKdt/KSai2BIevigkGfbgfwn6Hvpho+eOEOlE=;
 b=DWyhF9sSnMm/pt82R1797HSC7ghf0JldgLI9qDQnyQ6Hr3193vO2KJti39bMSBiED0UXSshIlExAyNfKrcUG7g0w3FyP1SzOU7cC/a2tBT9M211zmR93BDCDO4b9FLa9NsnWz4rhXD8R8UVYx9pr/APxTbTOkPDv0KzuYw1Fuo2JeqTBII0zNDvR61uebVkzee+yH5F843AZD9uRqcf4jcyW8ZEACK3eAOSP8sFUc5b2v4Sy3UXhdepech3CFsGexDqvubGY/fJNoGuZVIopq9pC8IvCflk/Rgq57eopL1e0mP8vFt5dqtytJq0YD1078xJLoA4rRzn4VbcAmvlhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcZK4obKdt/KSai2BIevigkGfbgfwn6Hvpho+eOEOlE=;
 b=QfNRlVWbvE5SFIfRJygwi5ybNJD5aCOqfd+fT0WYHzMsDUcr6Eps6FhHzcbhZUimoiSVLbD4q/92f1kfqJ/onb0xYVHP6T4tRhRxlk+Zd8EP/suX1+ZK9PaeD2QQ5gAcj25Y4XoKymapFO4wohG3lohnp4oLBPOpCjeIBZiUxfY=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MW4PR10MB5882.namprd10.prod.outlook.com (2603:10b6:303:18f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 17:41:38 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 17:41:38 +0000
Message-ID: <1f51f77e-6793-49a8-b6a2-4f3b1d6a761c@oracle.com>
Date: Wed, 15 Nov 2023 12:41:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: flush messages on abort
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1699027289-213995-1-git-send-email-steven.sistare@oracle.com>
 <ZUUu2IuUQ/Od7+Vr@redhat.com>
 <3d45ebc0-de9f-4051-9c08-47e40fea65da@oracle.com>
 <ZUi7izJoVpU+iiuC@redhat.com> <875y23s918.fsf@pond.sub.org>
 <17078387-f782-42dc-a5bf-25ee22bc518a@oracle.com>
 <87a5rfkn73.fsf@pond.sub.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87a5rfkn73.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:208:d4::49) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MW4PR10MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b93212-4df4-40dd-47ba-08dbe6021e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qz/28Z8OLhfHBscGwedft9t9aTFCRifCsjiCrTWp/NIOs75PaGXoeK033ofjH41Yjdvux47Pthb7Bda17kIWAPt0XnPTzcsI77//Hq2I99FCf3RTO0c0eD+jcz0BmdyziDsJFgkUHBa+d1i6UjKsinQ2kCi3vkB0NfTNgXz8nkgycN+XZikHgMbcSPMlQvCMLXZQJrZldpfp46/bdqsgndpAm42/jICk07xhE1SV/zenPdhhwD9PepfeyiJlxCAEVKAfFllrgeFwhCXPd1sy9ybq43IGSovttJR6Sx6kn4/d9NXXevoLxnxHxR1w+kjluv5yzrjdG974iYq2a8PAuw5bw3voB5sFqW6RsgtX76sbGo4DZaABvXYoWiVVcTTJmKvwwjHkPZB0AvsTTh/+8ubICHkvmuiqGjEc7toJ4tmz0f605q/sn00qwSJziKjv/QPx1CAyPKNedrlfiTzaJjgo03Vi/OvW7vC4V1CEuBwhoszjjooZx5Pjw5dMxVWvWH9zJ6RLBTzEZG2ZRiKw5NVeVWlwyF3dCsDV4rpBiBFqOFrghJHMSaOnH/EGlkBOsc19DuW5jXEEZd+ubyHibVkErf5I4MrQvMJcqSsF4waOrAsSLDu2vaA2VpRI6/KVKOrYHVg7+S9mA3UAiN4c7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(38100700002)(41300700001)(66476007)(6916009)(66556008)(31696002)(36756003)(66946007)(54906003)(86362001)(6486002)(478600001)(2616005)(2906002)(26005)(15650500001)(6512007)(6506007)(6666004)(5660300002)(83380400001)(53546011)(36916002)(31686004)(316002)(44832011)(4326008)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDRuTnFmUVlSS0ZlSnl3akt3UmxSQUtmbllPdFhKS0grMGJYR1RqN3Y5Wkpz?=
 =?utf-8?B?eERyYVExVGtKQ3Nta2pWd2dlWlRYNGVtZFVSKzJHbi9RVnk2bTBXTWRBK0xC?=
 =?utf-8?B?dHhZNEc5ZHNpRktWVUtCWEp6U0YrZWYrYkZNTHlyZkRUaG8yT3dQcm5QbitR?=
 =?utf-8?B?aHdKOU5YTEg0MzQ3T204WExzeVBreEZqNWZCUTZXb2hlVkdpNnBJL25OeTRx?=
 =?utf-8?B?M3BFV1lvY2dsRDUvUWFvRXk2b1A2eHJHNGR2a2E2S0dMbG9jZUtGdk1TNG91?=
 =?utf-8?B?YngvRjBFbVNsL2lHN3daQnY1M0FxbWQrcEErZ1RQREh5UlU4a1h5NGxVcWVW?=
 =?utf-8?B?aVVuTUQwa1FVR3ZEV0lGMUJ5aFJaQStDT0Y2TzAxbE9vN1pxWU1VY3NLSExN?=
 =?utf-8?B?OG1sSDJyZzYxZHBhUGYrc0l4ZmJuWU9tbXN3cUIzK0dDck5iRXZtQ3g1WFNG?=
 =?utf-8?B?MTF3UVFYd0xKSnI1Ui9uZVBzZG5leVdXcE5EbjNFQ3QvYWlXUDdIaFZoQW1h?=
 =?utf-8?B?TmU2WlBkVjBLeTVmT1N3a3ZNaXMxS2hSRnZOVXQ2WG80WGlsN0szUzYrdTVV?=
 =?utf-8?B?VW8rQWNZSThJRkJTRVJIV0tIMTVJWFJVWWJQaEp5eHhYdUxoaHM2U2ZXRk9P?=
 =?utf-8?B?VnM0L2FlbGw4MXBaL2tBbkdvd3pQUGhiSkg3R2dsRDlsSEszdE4ycEZpUFVk?=
 =?utf-8?B?RVVMRDhRb3N2bE9FckJJTVZwMWhVZGhPZUM3Q0pudnp4T1FSLy9zbm9va20x?=
 =?utf-8?B?SGhTUEpTOXJqeW43STNQdUNJWG1aOVc1RkJTZnBZYk5XZGQxT0UvNStiLzEx?=
 =?utf-8?B?elQ3MkkyNElPTEk5WlUzOGg0VVVkMVc5WjNwUVl6SDVkaGtrNlhWbCs1em8r?=
 =?utf-8?B?ZmVDWU96VEZVYXl3a1lnQ2pVSjRTaUw0MEEramVtSXlsQkZ4dGszZm5xVnkw?=
 =?utf-8?B?ZmV1eU9rS1NDaTBhc0tCemVkR21tbVNkNldNNFl4QU42MTIzMFA3aGhXVmVp?=
 =?utf-8?B?MGtTdjNmc2oxbXhsb0lYd1JYR3BKb1pyNHkra2xBdXcvYXJDVFdYUUZpSEJu?=
 =?utf-8?B?Y3NGMjN0K3g0SlhlSGdTWCtPMXpTUU40VGZlR1ZFaUtjbzFGTlppM0EzYU5m?=
 =?utf-8?B?QXdmaUhDc3lhR09DbmV4TG00dnB2WVFiOEljdmx0ckx0ZFhkbkRMNnYwcTVr?=
 =?utf-8?B?a0hHM2hteVNpU25BQjUxeUc2M1RnenJXRGRxZ1R0T2gyQ2dReUZ6TkE3ZFVU?=
 =?utf-8?B?YWcyMFJyWGx5djVnTnFSMi94VzYvSXRTbnVYeFhQWW1xenBXYmFMTTJFRDZD?=
 =?utf-8?B?TFd3TFdTbjNlQnlzNlp1VUtXUTdabnEzMTJwRmhScGoyR1JBdVh1bXN2OU80?=
 =?utf-8?B?VmFhVVFsSXJJMytkRjhKUE5pUzhMZWRwdGcyK1MrT2xJdmJuQm5jMUI2Nmh0?=
 =?utf-8?B?N05TNFk0b3ZXeXF5anRTZFk0blJSc1V3eVMrTWREOHNWS045WmdVaXZmODM2?=
 =?utf-8?B?dU4yVnE4Z3VyRFgzdm5nQzVidys1eEFSeTNMWGZnTEVoVmloa2NyZkVJajhx?=
 =?utf-8?B?MEJIalBONjVYUGhpWXZsMXlhVUtCMGUxcUhIMWJCV2JLRXgwNjBEai9hakw0?=
 =?utf-8?B?Sk15VHhHc1A0NUppY0lSVGU2RS8xenduZjRXa0dCTjBZbklBQ1J0OUY5TitD?=
 =?utf-8?B?RVp4bVRvbGVUeEFFTjlOTzhwYll1UWFBZGhEbjkvOEFYVnFZQmw4RU56SmUv?=
 =?utf-8?B?SjQzOEZWYnVSRW40YUh2c05XcFpsRC8yZzdLcE9tVkZ3bmxtRy8vTzBKZXE5?=
 =?utf-8?B?cDdyMjFmRmQ0M2pXQU50UjEzZGZBQzY3bjk0ZUt5OWxndVdNeC9rOHBXYzFG?=
 =?utf-8?B?UGU3Y1dQM2xFMXFUd1pJYm5UNDdyNUUwaGxwVlY0T1lvd3FVZDErNEpGT1NQ?=
 =?utf-8?B?S0FjUzI1d0VEL0tjMlRWSlMrblVoKzR2YTB4OVIrRzhvdW9pWHRXNW5kbFdu?=
 =?utf-8?B?TVRUWFBqWnZheHNQQVdFaEc2bFB3TnA3VVNmZmdaU3h2SlhBSHFpQUovZm5u?=
 =?utf-8?B?VEoza1ZONnFPQTZBWXZBaHZrZVlaMU1Wdm9xOTZ0enNISGhmMll0ZVkwdFJZ?=
 =?utf-8?B?bEVEMnVPbWMxZS9WVkkvSzJId0E5M29XSGhkUTJNVXVtRFRyU2tQQ1plSzdF?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dL+nvl7/01IhFo3aels5L8963hUFoCkyDzK0ypXoCbghEMRoesbk525GWRfFtuHzjTv43Pn8zWkjwGezfSHX18IdiUex50sIhWhoBOiKJqLs8f+kVBZ6BNdAC8Lupf6yeDmax0bnxtwOIzMARUu0p8970uLaVhMhLSIzIq7+XdPgJiF37pHPXo9zSvcCcn20oBydKwS22QCmDyclqohB0GKWuYzgAD73ErBNfKPrmgdbiRZ1kJkcACKJN2TVHWtbWXumcjMgOQWcO3qbS3jdHqF63DG3SsRk/QATx5lB8JlTqLp2ZkNI6aJ/z6VknaqNT4uhnan49nBpl0yai+esjJL31Y4sIDFIDS01CR8tV3gLKZd8Gjo6vUMcN5X7bo5y9cZ0gy795gU7U9Y23m7OQMSRAPX5Tk21hcOS+0hWKFcnCQ+OigotdZzZHIFT3G9rjs/2LGmG85DkmksKxszTYalwdV1Q/yrd50DdbKnJOQcdo5wtxW1r/EZyRJBJ3dzcQNE4H7EH5CT2w3n/Bu93lDF1gTQ1fa8Ld8VehClu71DCAw/zakPaquqATCaiN840lbsHmsUgapoTgPySD8asLqMe6f52SOBBYpLqjDtfyh8/uoXG6qwY0kFhlde5A0jbOK8o8rG7SxVzWAriID3wcpab2eKHivB8zN/O6qBT8IRa+iNtum2dxVkQe0OLEqCEkKOHasn5ou0PoBdNyUJ6IvMM485/uT7qYV4FF19mxrt7lPEoW6hM/3gmqviD2IHjqCHke1ZJ5KVzqahiRdIbA5fVNFJVLZ7yochf8S0KhuRAnTboQajHZPZ8XQ92VJCcHyrJ1zE9wI4sqGxq2K3ptA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b93212-4df4-40dd-47ba-08dbe6021e9f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 17:41:38.2351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2SyckIyRKNe5MhTvA4zmUjRTLOBVjeM5MKXBmE78QePf23DRDCV8yuB/Mrz+g0vSGrHkcLj16t4jEnwbgy1EOgVKKqLahtQIkvYokmpkNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_17,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150137
X-Proofpoint-GUID: pNfA1oPgjjQ9h91lZJm_To1Sm3rXa2xz
X-Proofpoint-ORIG-GUID: pNfA1oPgjjQ9h91lZJm_To1Sm3rXa2xz
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 11/15/2023 11:15 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
>> On 11/15/2023 3:41 AM, Markus Armbruster wrote:
>>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>>
>>>> On Fri, Nov 03, 2023 at 03:51:00PM -0400, Steven Sistare wrote:
>>>>> On 11/3/2023 1:33 PM, Daniel P. Berrangé wrote:
>>>>>> On Fri, Nov 03, 2023 at 09:01:29AM -0700, Steve Sistare wrote:
>>>>>>> Buffered monitor output is lost when abort() is called.  The pattern
>>>>>>> error_report() followed by abort() occurs about 60 times, so valuable
>>>>>>> information is being lost when the abort is called in the context of a
>>>>>>> monitor command.
>>>>>>
>>>>>> I'm curious, was there a particular abort() scenario that you hit ?
>>>>>
>>>>> Yes, while tweaking the suspended state, and forgetting to add transitions:
>>>>>
>>>>>         error_report("invalid runstate transition: '%s' -> '%s'",
>>>>>         abort();
>>>>>
>>>>> But I have previously hit this for other errors.
>>>
>>> Can you provide a reproducer?
>>
>> I sometimes hit this when developing new code.  I do not have a reproducer for upstream
>> branches. The patch is aimed at helping developers, not users.
> 
> I'm asking because I can't see how the error message could be lost.  A
> reproducer would let me find out.  "Apply this set of broken patches,
> then do that" would serve.

$ patch -p1 << EOF
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index b0f948d..c9a3aee 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -47,8 +47,12 @@ void qmp_quit(Error **errp)
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_QMP_QUIT);
 }

+#include "qemu/error-report.h"
+
 void qmp_stop(Error **errp)
 {
+    error_report("injected failure");
+    abort();
     /* if there is a dump in background, we should wait until the dump
      * finished */
     if (qemu_system_dump_in_progress()) {
EOF

# This example loses the error message:

$ args='-display none -chardev socket,id=mon1,server=on,path=mon1.sock,wait=off -mon mon1,mode=control'
$ qemu-system-x86_64 $args < /dev/null &
[1] 18048
$ echo '{"execute":"qmp_capabilities"} {"execute":"human-monitor-command","arguments":{"command-line":"stop"}}' | ncat -U mon1.sock
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 8}, "package": "v8.1.0-2976-g4025fde-dirty"}, "capabilities": ["oob"]}}
{"return": {}}
Ncat: Connection reset by peer.
$
[1]+  Aborted                 qemu-system-x86_64 $args < /dev/null


# This example preserves the error message. I include it to show the ncat-based test is valid.

$ qemu-system-x86_64 $args < /dev/null &
[1] 18060
$ echo '{"execute":"qmp_capabilities"} {"execute":"stop"}' | ncat -U mon1.sock
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 8}, "package": "v8.1.0-2976-g4025fde-dirty"}, "capabilities": ["oob"]}}
{"return": {}}
injected failure                <============= qemu stderr
Ncat: Connection reset by peer.
$
[1]+  Aborted                 qemu-system-x86_64 $args < /dev/null

- Steve

