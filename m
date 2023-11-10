Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BE57E7C64
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 14:11:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1RGe-0005OO-G8; Fri, 10 Nov 2023 08:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1r1RGc-0005O1-2H
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 08:09:46 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1r1RGY-0007Bu-TZ
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 08:09:45 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AABp9Nt022404; Fri, 10 Nov 2023 13:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=k8JbSt4/Cds9kEmGFMiNBQ1dfirN1B2fGhViwROSimo=;
 b=q06aAAeEpVq80ORAOzQORR+Jm7xzR04iJUCDLZhvxH2l0Omdcz1fEdCta0ixiAIrqywK
 YTnTsQSF2GHFFUmIFs3f+fyf/pIYDwTCVzlQ2jrJGsY9cChuJdJ4Jlb7wFURiEM7HE72
 d6eb4KAQYOqK8dEPjFeFi2FZnRkOTTkWsIgjwqJuDKXNtkHIPtt7jyjlwRH91Fk5gEFY
 fuPnlfvvAjuRga2/GIPWxJk0j9hKd/lr8UKye8j7/wJsMIBXDyuKSDiKVTM1PVmjQsKG
 TaUO6/4cE6Oo3QlLGtqU4ERNsKREdOVqnszerDoRYD0ID7vHwYHcmGSyKPeYC7S+RMvd NQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w216bds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Nov 2023 13:09:34 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AABEp5d018243; Fri, 10 Nov 2023 13:09:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u8c01ur4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Nov 2023 13:09:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+2/CcOlGJ3COm/pTz1Zgz1TDv0g384nXhy/MdnXkbjIcfyKP97O63EDb2MewebxGNKfYcglCKK6076ETuZPfvO7SyF+Kc04by/Jwa48V/QNe9g1QxEsb5IwcjzwnrQ4+6oEnvqNuyrozdz/WTiZN1bGwneeCP0fQKKRbGfBiZL/H2U9mkgwmvCLvZvaWplF6w4jq/NbFdtO/Pg0xMTtj2F0ZbLaJh25c17II0+9dKtN94K2noPdTtBcFMuNDEPM77+Pnpxdz2vPB7a1Qp7qDcB71CgVKDgCdBoIm0rtPk8C0QDMmnu/CGuPtY1G2k5rI6bNX5Gy9Zcx6iGhZcfHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8JbSt4/Cds9kEmGFMiNBQ1dfirN1B2fGhViwROSimo=;
 b=JSQJM+y5DCcxh1gL6g5W8dEWfBkescKhuTsAXY5KmfgW2aej6tecu3A9+7BuoGb6GoxaJuMCagJTFPpF8f7cJ6T7ZM81JjneGnYEpurAgfYQ2J28rMzT3pYPl8ZVHLiWtTiiQvgrV9pf0B06TspM4sd9YrHVQoK9LF485DGUcoVe6Et2wicVQIN0GV6SHfdJOmhqkEM6GvF/XvextDtYkPnziLTjZksA/SOpYDS+t7TKqU249vb8Dj0Uv7pygBDgUruC5lCF9KfeabE1jY5u++YxpjyollMtqheYLjhcz39pDi9O7kzxta9+/CRJ+lmFtzR2ferbMGnJLhTah2kHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8JbSt4/Cds9kEmGFMiNBQ1dfirN1B2fGhViwROSimo=;
 b=RNi1XMYfBpf1NjbhiVbpMlOyEycm3OQkhpVxiQv/T+oVycpo5YGjgYO0cOXZvoYPdf9mVm3sfIUHxqAs5jwDllSBV5lHWSChCtiULzWvuRSj/a8MccZnbIS/Xs6vploArM1/AQAfQIfkKLGf9aXBK9k1+BYnDo761eDy6Oxcs6Y=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH7PR10MB6083.namprd10.prod.outlook.com (2603:10b6:510:1f9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 10 Nov
 2023 13:09:31 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 13:09:31 +0000
Message-ID: <3b2faf27-493e-4b8b-92c5-1542399267c6@oracle.com>
Date: Fri, 10 Nov 2023 13:09:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
References: <20231102071302.1818071-29-zhenzhong.duan@intel.com>
 <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
 <SJ0PR11MB6744D87FD3CBB3380647E68792A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231108124817.GS4488@nvidia.com>
 <b6f22a3a-84cc-44ab-947b-b7e12656fe87@oracle.com>
 <20231109125700.GZ4488@nvidia.com>
 <592a04c2-0b4e-4bb2-80e4-f4c2dfacf00c@oracle.com>
 <d7475721-2388-4b9c-a47f-1891e82a635e@oracle.com>
 <20231109130921.GC4488@nvidia.com>
 <c761227b-360e-47d5-868d-2cfb71080a46@oracle.com>
 <20231109143434.GI4488@nvidia.com>
 <SJ0PR11MB6744A33106EC2DFA66D397B692AEA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744A33106EC2DFA66D397B692AEA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH7PR10MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b033a4-39c9-4d54-3eb1-08dbe1ee46db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZEVhZNTU4ezcLAAtpfhTWvJkGEffKC/hL+nFoK/xftZsZAMo1k3RJd9unkhBByfmr/k2D9CjVoBTBxhrHR5KRjAevAHaqyNwr6aUPHL/93Aj6j2C0hnIycA0yazjk0q40NYaqN/gpNls+KDIeiaqZctbvV3/ybr6K6ymPwhKKYxBU4vVQiot+xMkzFnzsiNiJ2IVbJOpxzCQ0xLb0S0zmAliUk0TbtCFbTCR1K6G0/NpRupOL/RkqUzQ3Mn1UcEkqV//HEAPVvQCGbknMtDgehmrrQ//I+mRem+45pIU6hNFaT4ygEOnkLaQKMV41JRSvo/OIblnfZtDgjDvd7McMzBa3DCCKpi0q7vXEbZoyV0RZlvYkHZ6JmkbAujjCsD8iiQ/ZiBx8RXCyUj8Zh4c/bDPnDexrEhqJnjjJn6co66Z0zGIqFI0BqR/LoAU/tPN+g806kQxJZ4/dKfUUNGTeitF17+tE2PRDuK/UXQp4o5zAF5wuNLj+MeRQ2wh4KsRuZpkeL4xuEyexbRdx/MUVP4+zLJw3eF07R6fv5guXmVzJ9DAEo6xq0pwq6FMtImDdeM4mqgTji+L0bk1VmyIIpHN4zeuUH9b67Dfp2mXvLk7pG4UIE+x6fGxrOYN5v+5AY/0V4XVQ8+UYnasUGufA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(31686004)(38100700002)(31696002)(66946007)(66556008)(66476007)(6506007)(6512007)(26005)(4326008)(110136005)(5660300002)(6486002)(2616005)(8676002)(8936002)(6666004)(316002)(41300700001)(53546011)(83380400001)(86362001)(478600001)(36756003)(54906003)(7416002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0c1NE43UjljeDJ4NTkrY0F3OW5xM0ZvMSt2ZjRFQjZWTS9aMUlVbitUczVK?=
 =?utf-8?B?OWU2Q08vL1NaNThRNERVN3FaVmx3V3pPaWJWMTZiZjdyTndrcVQvRSs5NFJF?=
 =?utf-8?B?SVgvdFhlSlQ5OWVSclJBSXRLRnZCTUgyTnJ2YTR0WHZJSnVCQmhiS2NaU0ZH?=
 =?utf-8?B?V2ppWGpzMzZWMng2NWwxR0kwUVVXUWtkeng0dlNMaTlPTnF0TWE5TnV1d0dK?=
 =?utf-8?B?WExjWXA5VmpabG4xL3JrZGdFdHlCZDNKeWU3d3RMb0tnVHM5R25Ia0hHVGhW?=
 =?utf-8?B?bnMzQzltK0xOOHBOcVI3VjJCVXh4VWoyMU0wWTI5ckM4ZWdBeVd4TGZKUWwv?=
 =?utf-8?B?R1BWVDdjN3ZKbTZvQ0k4ZFdrY1VzMURNb0picFAzNUUvRHFXQklCN1dXbkRv?=
 =?utf-8?B?MFFQYnVMU3ZlTzloWWRCR24rVWlUb1lQSWVWaWJRNVFwS052ampQQXlXanpG?=
 =?utf-8?B?RlRhTHZ4WXVqNVVvcjhSV3hObUlFUFBsemxYdjJGS2RDLzUySkJjQm9wY2sr?=
 =?utf-8?B?U0FhYzBackRKaVVEMjliT3VIMy9iUWZQL3Racyt1NU8wc0Iwdjd0U0hyK2RO?=
 =?utf-8?B?L1c3bExadDZPYzcwOFY4TC9qQUI2eEpLOVBQbzI0NEZiMmgyL2RncTE5cHcz?=
 =?utf-8?B?cXNwLzFQTGJsWkVrRW90NktyaVVvY05RTXQxS0VTUDhhNmJGZGVPa2xjdUJD?=
 =?utf-8?B?S2FySFNnM29HQjZuNzRmMjFlMXNlaW9mcXBmMTlSWjBuc2xSRDlHNFNoSG9T?=
 =?utf-8?B?ZHRVbm5IYzhJZnhGSmlYVlVFcy9uZ29KV0tlQmtTa3c2QWVRdUU1dWdTRCtP?=
 =?utf-8?B?WDFsV213UUlzajhiam1hV2x0cmNreDZTN25zVzZjZkwreHlCZ1lRS3lURm0w?=
 =?utf-8?B?amg0YytvbmRFSnZzSVAyajRpQjU1K0MwR1RNa1V0TjFaN2VmZ1ZUR1NEUmh3?=
 =?utf-8?B?WHowWVV3MFUxT3UwUjlZbjlvQWtCdkVNS0ZJTlB1WlY5alpLblpYSDFvSFM4?=
 =?utf-8?B?M1VVMkJNZlpKNk4wZXVzdmg4eDdEeUN0NS9iNW5tQ1MwemtQRHhEbE9rSmNq?=
 =?utf-8?B?bUw3cVY2YVJ4aTYraCsxRysrd2JUUU15S2ZlK21VdE5idjN3N3FqZ3QwTmVQ?=
 =?utf-8?B?TlA3VWQwRWtrU01oeGFLS3NucXNTNXM1d0VLRnJZeHhIcktWeHlraUJ0dTZE?=
 =?utf-8?B?SFVUc3BhWkRDM21qSVk3U3AwaXdXYmdqLzVqVXMxaGNQVmdlMnE1OEJwWXVz?=
 =?utf-8?B?bG40ZG43Vk4wdEF1c25lZG9PY211SlErc0xpcDFNc3hvcUJqclNhb0pHKzZj?=
 =?utf-8?B?NUdqV0hqL1ZXR3pkSFJ5akhIRzVMdmFMcFg1NWNaeTJHeVAxR0hIdDZIWDRZ?=
 =?utf-8?B?eUxTQ0g3WVFpbjZaRXZFZXYwWnNORmtSbDhnanJRaXlpclYzVzcwTGtHd1J0?=
 =?utf-8?B?UnJNR2djV2ZpcUxkWlhJTGY2a0lYRjZPTlZoMyszVmdvTEVoZXBkMzZzQlJu?=
 =?utf-8?B?T2lwT3h2Z0NMeWIwVDdTM3lkdnRNODdqUWJGbWQ5WGh3dHJiVTJpRG9YdVFJ?=
 =?utf-8?B?UnNnNW5DOUxUOVhFbURyZ3E5L3FTa2JJZ3lTblJ5TWViTHAwREpyQjZBazd5?=
 =?utf-8?B?d1VoalgwSU9jeUd3UnVFN1RQczVkem1HaVczS3d4SzUyUEI1eVdHL1ZiNE9K?=
 =?utf-8?B?Z3p0RXRSVlhGYzhEMnNaU29XY011ajdqY1NEaEhra0FHWCtnUVdBY3E5YWJ2?=
 =?utf-8?B?SGVVMnFieEhmb2lpM0orSEhocVZkNU1WM0ZKdXdsdFN5TmpFVENKS05kcmV4?=
 =?utf-8?B?SUw0ZldJNDQyYWxiYmM3Rll5Vy9oKzNrcS9YTG51UitFNUZndmU2QWJxY3Uw?=
 =?utf-8?B?QXd5R1Bta1dISXUvd28rcldOc1NzdkhueWQrVFp4c2tLM1BkNG5YZEh4TnFy?=
 =?utf-8?B?bjlKUUZScmNrbkFiQjFCY0ZWanR3S2Y3NzdRajZFbFBnRk1ac1U5WDMzM0Rt?=
 =?utf-8?B?T2hGQlRWZFk5SWpSY3dKZFVWUUlpMWp1cktnWXU3cTRVeGpaQlNOcGU5dUV2?=
 =?utf-8?B?Ykh3WVF0Rk1na0RqaFpGdXJhK2pIcFR3ck1FVVdpQklHUGZ3RSszaVgrZENL?=
 =?utf-8?B?TVR1QnZMWERBdUswN1MzVHR2MkREcVZpQnlsUTBoSDFRUi9ROERYTHNtOEZh?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eBXhAc9OxxUktuvGEnXNu9TjNiSXGHSupKjzeyQ8F7Daq0KBYVw1wXNezmPtLGvHZDxAjIsfwGPw2xn0loWKkIrtkLTLjnixhJcLpokEU7D9wh/Kb6MzTFyJ0FrZhY66KzIN3WAvu1VKoN3TGMUoTYPNUHosP5gWiyAVX1kA9Wgfb4wU7puCOawzpXzNyJ3ENf8gCWjmtrwTFGFDShwfZpPm7gsQHSGVNCxji66QtGEhFDATfZ2Em1F103Xz0wMRZePckIVDfxr2av8Lh995A+rLZfU2BlOWjmHNG0yowqSGgLbFSUFJpH4JxSK3ciDNkaPBKSQR6AFSj8Rz3Az7heDgkPKQgM4iVJONHvBBaMJEzmTe9ZMABl3I7SZtrVdU0BevXBQjUTnLZbU3x1slQpPZRxZ9TNHqMyJU2QXo9r5KxnhBrhCbxGaet/rTUni33O4Bf98tQtg9ydFbWUCcTAZU8X6vgtijGICMZdFfe/gzJ6bKIelDMPHDmlfmXaTuG5gdORYcCLyGxxTtZjW0JDgz5ZtnzZIoYoVld1/Xj5E33zeS/+y3fyKYuMIcEbEtyEUtu8izqHZxvx/+uCo8ZfKsKvpQmtYzW1pcJeKSCvzk17Fq45cL54vgZ/IdCIpyDBAz2e+0bCRjqV8PgFlgaEszH0XaGx+b0xMgenL6xUR6loK2QPF5ZH6kT29Arx+kCFNt0a9/ZSU1+U4qIM77vINw1nKfTHQ21dIXuj+z5KnXd6mjltcw7ltcwKMfrrRYgV3sk8C2BrPRY/uWyxaS5/Ybm7AX26g4Ja8dC2TJJarDjIMlQZ1dIrAgwhCb7Aw+Fg60tvwZ0aQ6I/VdIPe4jOmQWczhT8P3CXvvGE6D6Vga3TxXoxgLlr0c4ImxTs8O
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b033a4-39c9-4d54-3eb1-08dbe1ee46db
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 13:09:31.3552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vY6c21bkGrmq52ZRPhBqJR+TLeFaISy7MvxJMwlCsxYiIHDX2R/8bF/BZ8U8VguFbj19NTSqav9EwmDgtr+15AEpti1PxBNK18Jv9jtHZA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6083
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_09,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100108
X-Proofpoint-GUID: RedTWpKeuDKl0vjCO2TmOqiIvE4iKJ59
X-Proofpoint-ORIG-GUID: RedTWpKeuDKl0vjCO2TmOqiIvE4iKJ59
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

On 10/11/2023 03:15, Duan, Zhenzhong wrote:
> Hi Jason, Joao,
> 
>> -----Original Message-----
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Thursday, November 9, 2023 10:35 PM
>> Subject: Re: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
>>
>> On Thu, Nov 09, 2023 at 01:21:59PM +0000, Joao Martins wrote:
>>> On 09/11/2023 13:09, Jason Gunthorpe wrote:
>>>> On Thu, Nov 09, 2023 at 01:03:02PM +0000, Joao Martins wrote:
>>>>
>>>>>> I am not talking about mdevs; but rather the regular (non mdev) case not
>> being
>>>>>> able to use dirty tracking with autodomains hwpt allocation.
>>>>>
>>>>> ... without any vIOMMU.
>>>>
>>>> Ah, well, that is troublesome isn't it..
>>>>
>>>> So do we teach autodomains to be more featured in the kernel or do we
>>>> teach the generic qemu code to effectively implement autodomains in
>>>> userspace?
>>>
>>> The latter is actually what we have been doing. Well I wouldn't call
>> autodomains
>>> in qemu, but rather just allocate a hwpt, instead of attaching the IOAS
>>> directly. But well mdevs don't have domains and we overlooked that. I would
>> turn
>>> the exception into an exception rather than making the norm, doesn't look to
>> be
>>> much complexity added?
>>
>> Autodomains are complex because of things like mdev and iommu
>> non-uniformity's. Qemu can't just allocate a single HWPT, it needs to
>> be annoyingly managed.
>>
>>> What I last re-collect is that autodomains represents the 'simple users' that
>>> don't care much beyond the basics of IOMMU features (I recall the example
>> was
>>> DPDK apps and the like). You could say that for current needs IOMMU
>> autodomains
>>> suffices for qemu.
>>
>> Yes, that was my intention. Aside from that it primarily exists to
>> support vfio compatibility
>>
>>> Connecting autodomains to this enforcing on the hwpt is relatively simple btw,
>>> it just needs to connect the dirty tracking flag with same semantic of
>>> hwpt-alloc equivalent and pass the hwpt flags into the domain allocation.
>>
>> Yes
>>
>>> It's more of what of a question should be the expectations to the user when
>>> using ATTACH_HWPT with an IOAS_ID versus direct manipulation of HWPT. I am
>>> wondering if dirty tracking is alone here or whether there's more features that
>>> start to mud the simplicity of autodomains that would approximate of hwpt-
>> alloc.
>>
>> This is why I had been thinking of a pure HWPT based scheme
>>
>> So it seems we cannot have a simple model where the generic qmeu layer
>> just works in IOAS :( It might as well always work in HWPT and
>> understand all the auto domains complexity itself.
> 
> Let me know if there is anything I can do in this series to facilitate
> future qemu dirty tracking support of iommufd. Not clear if I should
> restore to the manual HWPT_ALLOC method in v4.

If we want to have the closest support as type1-iommu, from what we have been
discussing... it sounds like IOAS is the easiest first step to get barebones
iommufd support. Which sort of makes sense since this is the introduction of
iommufd and it already requires a lot of churn & refactoring to get there.

For the new iommufd-only features (nesting/dirty-tracking) we will need the auto
domains done by Qemu IIUC -- unless nesting is meant to coexist with autodomains
with its own hwpts somehow (?)

Right now I don't have the autodomains QEMU equivalent structure in mind to
suggest a path in alternative to v5; Looking at the kernel autodomains path,
aside from mdev I am not sure yet what annoyances the autodomains path in qemu
is going to generate: more worringly whether we have enough information to
tackle the non-uniformity e.g. if we are talking about features or whether
different devices are behind different IOMMUs.

