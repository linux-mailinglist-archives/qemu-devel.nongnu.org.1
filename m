Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D4B7F4834
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 14:50:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5nbE-0000Ab-OO; Wed, 22 Nov 2023 08:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1r5nbC-00009o-3q
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 08:49:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1r5nb8-0002Px-2Y
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 08:49:01 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AMDmrdv030582; Wed, 22 Nov 2023 13:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8JO26CivK0OOnnOetV6x5IZuT3fq4iDEuIfCt1mdeZ0=;
 b=mxQ8lp7oaiIyIh31Wsvj94n0NK1GjUMhBSkzH+qdTuNgG4COmNo44dkNhwylHJ954T6y
 G3ukLzO+feVxqV0klWv81nz/KIxpSim2tYWggOu6MRcYeljDWfKPE1/6uLx1k2CNr1uS
 HrUkXymga4uC3bSunPj3I04zaM1eV9Rshc1PTwTL0tzaAbzHds5CbjzbDQFiBdMDm62z
 8MCM1WTUR5rFh5WI0MHVw+hAA06Ls+kryblyYxC368+9IY0Om3zYtX9YOw42CDUBJC+W
 +SPYKQ24e1LC/A58tEW2sBfmJrdB9auHfAs572tIx3aBQIWchSxlv+4EXurkKCdLtcQm nA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uem24ygf3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Nov 2023 13:48:53 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AMDF9fR002355; Wed, 22 Nov 2023 13:48:37 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uekq8s7d7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Nov 2023 13:48:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7OMxzOryyBx9fjgW482s0/e5U7/ceZtjaeClDPQGQFaS6xnc+RSEzGaNkYq4CgD4ndu4QMkzqaY9157OGbEGDGmACxJGK+rYizq94Y2J+wrD+myIFBXMe2KT6TrBQ/MxE+5NfXvsg2ACa7MkVIOdeG3yjwFChvdvyNaLyVwg2D32fJMh9Dmv4QHQXuWR73zyjrDcbrgzqIWRELGjDThJ09ocTq000S4LkvHxiTocF79oori1QDOMwoWWBADw2um5+cG6cFcZwRh+7iEIeecBIapchpJYsV2zIY+ewAu/Ho4rpmKz6Yj6gFeySy8PLekmv1U61YhrL15r+0tqdGxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JO26CivK0OOnnOetV6x5IZuT3fq4iDEuIfCt1mdeZ0=;
 b=T9MfHfn4WZqod3D2M2TewAImy0JhLNz3lbC1lfLWLVNUMFoYnkW0FUZLRGwKZLElzHk4SJpW04G+5T+oEYMrUrxg0PoHc+3GnGjUfyNPspIf2RyngmK5tOOVdCy4+UjxkrdAUbniFocF+PRr3uCNmB9+xXLGbREW3gWgbb/HX/i1eCEbjIpTRYBBmRvcV8y7OkxpjRWCQE8W/V588b7AdEQUMFn3vJpYO+Hk1d00YIrW54P+kUMF0hGmwYWr9f+UFisOCzzrDQNqjAbbv2Guj0++mkukh8cMW0kU0RytNqi3RtUKVSPmaOyHT0skVt7f3/2Ev1gQqPzyVH2gB84FCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JO26CivK0OOnnOetV6x5IZuT3fq4iDEuIfCt1mdeZ0=;
 b=DANClOzc/bZs5ABwmGIGGawO6i0qeGCKnIPKbaMokZO0mWI5m/F5nJ1KgaCjvzHylzN6K9l30ssCgavdmgebN2E52CIIWjrZfGK9LXdtozm3kps1uOXh8M86J2Oq1clNFGhFWqNi7oXY7MOEVMxVVX/UpDvP5yGRH9SkbWc/3xo=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SJ2PR10MB7706.namprd10.prod.outlook.com (2603:10b6:a03:56f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Wed, 22 Nov
 2023 13:48:35 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46%4]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 13:48:35 +0000
Message-ID: <b2d44b66-97f0-4ee2-8849-32167edd2ef5@oracle.com>
Date: Wed, 22 Nov 2023 13:48:29 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/27] vfio: Adopt iommufd
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, jgg@nvidia.com, clg@redhat.com
Cc: alex.williamson@redhat.com, nicolinc@nvidia.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 qemu-devel@nongnu.org
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0141.eurprd04.prod.outlook.com
 (2603:10a6:208:55::46) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SJ2PR10MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: fa80c019-01c9-49b5-c5ad-08dbeb61b919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BEFCA/kG8qttIkwfG2rnalr5od+VfbpyQe+0Jn1hNTitT5t4HNEjNRqvaRINyg873VewVdrAOFcCsoMN3yKa0z9aMCkCUk/dCJYJDj3GM7yPbJg5BygrybWxoYF2IvPTZT0oB6lZwHkpf7RkVNZid/2PdxvOxh8f2B2sE/nBX9R+wDZ474PkLdVo2Voj0uSmkdH+dH+FqG4BLPu0fC3+xTgIYEgwLtUrp8neX+zvEu96kP4qEnMENz9VgQU30Y03o71pvkBRjFt2kgdeCal8QVpK/LDQjxEiLhJGAO1bo8R8SOYy5rLgbtOHXeDXPwiM9aileidUWSIQLHsF1wZUXjw8uDATDP/ZFChh5zepxjhkHt9VH+tAkoQpLAMRUP9PHh1eJNzYg5HdrvvwDW2Ufcpg9l4MmvHo2ZR32gOmn8a6Eqrzp9knaRO7c2GE/bVTkDF5KIrviihz2FeIE+0qFJXSb66icSV/z+jH4Mwgjfszpu1FxcvRx9lGdSuLcm6Mc0/+pazov6ft66KDjjhJd11jU5GOQaW/20VZ+It2AiP9yJ8BjK6dlsTLk71KFxr/WfGQm2r8GVg1Ly34CvN84hL48unUUvU0Cm6neTBi/T7Wcy5+ACPb3zIwHIXZ0EwCQkv5qpiHPEkLmIdNfFZYDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(5660300002)(7416002)(6666004)(38100700002)(478600001)(4326008)(6486002)(8936002)(31696002)(8676002)(86362001)(2906002)(66556008)(66946007)(316002)(26005)(2616005)(66476007)(36756003)(53546011)(31686004)(41300700001)(83380400001)(6506007)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXNZRVpYak05V3MrVFg0Y3JDTWUzbTA5K2ZCK1FQUm5ZcXBYZG8xeHF2dmVp?=
 =?utf-8?B?S2xnc2g0QllwSU5FZkxGeDFYbVl4c20rc0QrYysvMjVuQnpRaUNSVFJMNXVi?=
 =?utf-8?B?aWlSbUZWZm02MXVaVWNxczY3bVJ0TkhQSjdpNS9RZ0RKU2tWbE5oZ0lHZ2Ix?=
 =?utf-8?B?dnE1c0JuYVJSQ0t1bWwyZ3R5TXFoZWtpQVpkbldUZWtOMzJXYlFsRCtUWk1p?=
 =?utf-8?B?Z1FQdHVPRzJIb3hJV0xSc2FYK1cvRDdRZ2N3MHlIZXpzaHkvTkJmTmV2T2Uy?=
 =?utf-8?B?RmNKVDlVME5RaG1oZ1ZiZ0NrZVk1RXRiSyt3TlFod3pSNzVYeUEwSUhpd0Vy?=
 =?utf-8?B?eTBEM1VMRS9hcmNzMjNFN2ptSEJHUVZXMkdWME1vcVBQNWIxSEx3c1B3cS9y?=
 =?utf-8?B?U0QzSjd1Y2tTR1BpYTBpVEdKSzRmOWF2Uy9MVFBaZ2U0SW1EeEFOVVM1RGcx?=
 =?utf-8?B?aVBqY2RBb2R0bGlrMVNqRkpQOFl2a2FNeWVBTkR4V0xDaUdrUHlJYmNhUjZ6?=
 =?utf-8?B?WklmaUc2MHVPbHZzWld3c01tU29QNXZEa1ZTRFNIQVdkVDVVSEhoTkloRjBI?=
 =?utf-8?B?S2ZoZmtqbmJYU3IxOHcrWkFnYXR0bVVBYko4YzQyMnVXdXl0cUhRclZTem1z?=
 =?utf-8?B?MGNVYzFOcWZKNUY4Z1plbkFMV2xZR1JPYUd3RG5DUEZpNDdNcVlSaGZXVFVI?=
 =?utf-8?B?TEczdnpGb2Zma3VwTll6bmg5aFdlUEVoSzJVbGtrOTh6anJ5cm8yYlVIZm5x?=
 =?utf-8?B?eE9JS1BHRVRxRU9xbmFzVWV2V3Y1Z1ZBV2hJaGlacDlYRUFhT3VUcTRqTWda?=
 =?utf-8?B?Ykp5RnpCRFE0RURTbi9pZE5MREpBUEdHaFQveTN0cDFMeU5nQmpJU3FJV2tG?=
 =?utf-8?B?clFUZTJGaEZuUDRudDFacU1ubXIxaDdGbWZWcnl3S3R2QkdHZ1VPRUQwdjlh?=
 =?utf-8?B?eks0MXNkaFhqbm5TUEhkUUdXalJyWXhCa0dJWEFhNjhLdm0wUUptTDFMNXVx?=
 =?utf-8?B?bUhydFB3OGRSSVQ3MDRPRG1pWklVYkd1V2hpZ1BMcWNqRGpSVXh2QkovUGZU?=
 =?utf-8?B?QVpGZXdNbWE1YWllSVF5Mm1KNTRWQnl0cTZPQWlHRElKSkhyaStaYTdPNkxV?=
 =?utf-8?B?VUhTNmF4VEhIT3VSMVNaM2JrbjVaS0w3dENCcnFkaFoxSk5QSmRUb1dUWHJs?=
 =?utf-8?B?MU9DTlhON0N6US9wN2laeUx3MFF2SnhXY3AwTkJBc2RUSjZqTjQ3b2lhWjRV?=
 =?utf-8?B?QXpoanpyendCQkRFT3kvSEVVRE1oL3BjbU9pMWROcWtPWmVVMmhyZVh2RU9R?=
 =?utf-8?B?WFRpKytMbFBibm9GQXdBSTNQQ01uRjZyYTYrbzZJSE1qaVVaaW5vdGhtbFJa?=
 =?utf-8?B?aTFkRnBuektabVlUdXFlMTVybUlwamNSZmsxV3BGblpubzNxTDU2T2xkYkhH?=
 =?utf-8?B?dkIra2VWYXVrVmdScXE4THJsSXVRN1pRU1d1WHMwRjlzd2ZBVlZUYVc1VXlx?=
 =?utf-8?B?ZXhVUE54aCs3NXBhK2JIa2FWSXV2Y3NFQ3VNYjZhaGFrYXU3QlUyV0pRWkJi?=
 =?utf-8?B?Tk9BMVhQUGphRDVyQ2ZaQWhaOGZuK2VZYnBYUDlmSm5XU3VuUFR2dlc5WENN?=
 =?utf-8?B?NFNkcTJ2MVVEaUJnQjhBYlczRksrSlZwdGNpT3p5QjdNL1JGcFRWSGVDT2hG?=
 =?utf-8?B?L1oyK0Uza1BNdFJyUmtDRGpiUVEwSFAzZXNBcDhBMkZFd1FGTU1yOXcvRVpU?=
 =?utf-8?B?TkZiT0hWMHc5WlpDbDRtTWRPUEJYZEpMY3JDNDhJVkxadDM1R2tpKzgzVFhJ?=
 =?utf-8?B?dFhJRG9YTWo2ZnBXZzVFODIzSDhiMWpUR1dOQ0RseWYrTjFkd2U4NjJLZE5Z?=
 =?utf-8?B?Wnlwa0lsOVZtMVBUWi9sUlQrcGJPUGZWOUtyVWNJdVZyMzg0V0lkVFlrTHpX?=
 =?utf-8?B?S045N3d1MzVYa1JhWjlEanRQdm10a0ludlhpRGZ0eE81NkdoVDU4T0V3cFFU?=
 =?utf-8?B?U3BaSEtQSnJ4UVNkZlRDNmNvWkdMQkgrUjJQdHRUUjR6ZWRZb25kbkJyRG5k?=
 =?utf-8?B?N3drbDVkK1pBY0xXVERSQVNjQW12bzZ3TDA2UlVZVzUrYzNxU01kbEZVM2kx?=
 =?utf-8?B?RlQ0dzRmVFFLSnova09RYmlOQmVNT2JXaUFiWmc1Z1N4RGRwUFpCUStTKzZG?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 82DGWJDjOMX/PczYOLogwcJp4fe49A9G4/U0jvdC4YatQ5vY8/n7FZmKXxPQFP7pyt53l1Vx9q0zIStzh5FhjG4/84/dNmQc8FspnJJfs/4R4sr9mb8733BEYme8hLarVT65TeZvrNKPqG+FOnQ7hNJTbmZxHz/nJbbqDSNygbP6N1VdeVYYUaHDoXicFw0i1reP9w4el4C3NecwCUEOTibTlktQK8DPQKFuHSBdBSZYxqFIbbmxbi9LaDPYPxKzukO1IhInApq1c3s84cQbfgtSG3753+KWD1o5ggVA6Mms1bSQ7e9rJa2vkmkt9UAy167RY0JG3JDNX8BjiXQnzedcZCShip0PYUiBfM01Ti7V/Hw+aAWX1fPV1lXhzMorXB+X2KXMYLoemj2Lz+JQzZkyOzhaqcaHD1cydmCrzl+MjJ5ACd/r0gQrUa3gPV4VCJ+9bEjT0LoVwTqvfqVrFEk7RbFlaEwnxj/iWEYgSO6afm+ZE2lzEQonwNjBWgct7OdXPGKHGX2kYcvS9llBR0E6KebGl6uxw9t77+bOoeMPOYEBnoWYIF6R9lbCsG0Sdf6eZauK43qbVJsFLaEl7dwTZtER+jr5A4kw3gB8ZYWznMPWsS9yhCCx5ShEhlg6ipZ2GknLvbHIIOVcWqrAR630xWedns8LYSQxbl5LROuga3eKGNFMUUAPPrau8T1bUxdbhDEM0OkLrxnciWP8g2fkppMqucVSOYXO9zAIOBAtIxOoaYkr2RcpJInQZb3sTucNK0xxZH1HfhUvaA8rZkHhxGHUo0OT5IZ97WAlrbltaeY/ZBInT/Q25BOflOq7IyQrQwWSPY5D32u1jGtI+Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa80c019-01c9-49b5-c5ad-08dbeb61b919
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:48:35.5054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFMk++OVwEe/N2kTmIpKy1gUSHDOV2afYzirtApbzWyH9pnMKENc/jow/oVB7XvZXw92z2tecUh52xvwd/U3vcu9oeBFY+lOGwmBHdYCxAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311220098
X-Proofpoint-GUID: Klv2JmbANPejIiUQz-_t2Dv0OdGtnKKF
X-Proofpoint-ORIG-GUID: Klv2JmbANPejIiUQz-_t2Dv0OdGtnKKF
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

On 21/11/2023 08:43, Zhenzhong Duan wrote:
> Hi,
> 
> Thanks all for giving guides and comments on previous series, this is
> the remaining part of the iommufd support.
> 
> Besides suggested changes in v6, I'd like to highlight two changes
> for final review:
> 1. Instantiate can_be_deleted callback to fix race where iommufd object
>    can be deleted before vfio device
> 2. After careful re-thinking, I'd like to follow Nicolin's suggestion in v5,
>    remove is_ioas check which indeed looks heavy just for tracepoint.
>    In fact we can get corresponding info by looking over trace context.
> 
> PATCH 1: Introduce iommufd object
> PATCH 2-9: add IOMMUFD container and cdev support
> PATCH 10-17: fd passing for cdev and linking to IOMMUFD
> PATCH 18: make VFIOContainerBase parameter const
> PATCH 19-21: Compile out for IOMMUFD for arm, s390x and x86
> PATCH 22-26: vfio device init code cleanup
> PATCH 27: add iommufd doc
> 
> 
> We have done wide test with different combinations, e.g:
> - PCI device were tested
> - FD passing and hot reset with some trick.
> - device hotplug test with legacy and iommufd backends
> - with or without vIOMMU for legacy and iommufd backends
> - divices linked to different iommufds
> - VFIO migration with a E800 net card(no dirty sync support) passthrough
> - platform, ccw and ap were only compile-tested due to environment limit
> - test mdev pass through with mtty and mix with real device and different BE
> - test iommufd object hotplug/unplug and mix with vfio device plug/unplug
> 
> Given some iommufd kernel limitations, the iommufd backend is
> not yet fully on par with the legacy backend w.r.t. features like:
> - p2p mappings (you will see related error traces)
> - dirty page sync

Just as a quick update: I intend to follow-up with this (alongside my other
debt) when I am back from vacation ~2weeks from now. The one thing needed before
dirty tracking enabling is a userspace autodomains that's equivalent to the kernel.

I don't know what to do about mdevs tbh, considering there's no hw domain going
on it's just telling iommufd that 'hey I am accessing these pages' (IIUC I could
be missing something). Right now it just falls back to IOAS attach instead of
hwpt-id attach if it all fails;

Here's a partial snip below that is trying to match kernel
iommufd_device_auto_get_domain(). It's not that far from Zhenzhong v5
implementation, except that we handle the -EINVAL from the attach to allocate a
new hwpt for said device, and if that fails then just bail out like the kernel.

 static int iommufd_cdev_attach_container(VFIODevice *vbasedev,
                                          VFIOIOMMUFDContainer *container,
                                          Error **errp)
 {
-    return iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
+    uint32_t pt_id;
+
+    if (!iommufd_cdev_autodomains_get(vbasedev, container, &pt_id, errp)) {
+        return 0;
+    }
+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, &err);
+        if (ret) {
+            /* -EINVAL means the domain is incompatible with the device. */
+            if (ret == -EINVAL) {
+                continue;
+            }
+            return ret;
+        } else {
+            vbasedev->hwpt = hwpt;
+            *hwpt_id = hwpt->hwpt_id;
+            return 0;
+        }
+    }
+
+    ret = iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
+                                     container->ioas_id, 0, 0, 0,
+                                     NULL, hwpt_id);
+    if (ret) {
+        error_setg_errno(errp, errno, "error alloc shadow hwpt");
+        return ret;
+    }
+
+    hwpt = g_malloc0(sizeof(*hwpt));
+    hwpt->hwpt_id = *hwpt_id;
+    QLIST_INIT(&hwpt->device_list);
+
+    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, &err);
+    if (ret) {
+        iommufd_backend_free_id(vbasedev->iommufd, hwpt->hwpt_id);
+        g_free(hwpt);
+        return ret;
+    }
+
+    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
+    return 0;
+}
+
 static int iommufd_cdev_attach_container(VFIODevice *vbasedev,
                                          VFIOIOMMUFDContainer *container,
                                          Error **errp)
 {
-    return iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
+    uint32_t pt_id;
+
+    if (!iommufd_cdev_autodomains_get(vbasedev, container, &pt_id, errp)) {
+        return 0;
+    }
+
+    pt_id = container->ioas_id;
+    return iommufd_cdev_attach_ioas_hwpt(vbasedev, pt_id, errp);
 }


