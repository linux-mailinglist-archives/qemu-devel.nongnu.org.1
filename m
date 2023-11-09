Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B15E7E6AE2
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:01:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r14dU-0000Pl-NL; Thu, 09 Nov 2023 07:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1r14dP-0000PO-BP
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:59:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1r14dL-00076A-Br
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:59:46 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A91iLat018988; Thu, 9 Nov 2023 12:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bWpxtU6KN3h/v/AatyKNPUoIXHnXBbmLB2ietWnOCDA=;
 b=lFiap2zpNRm4HiMprpppaUH8yBwlFQYjz415gDqVzJ3pIdrT73fj35WrhWVDY1VNQERK
 4bprx3KBzKDlYjhLtaang7aCDUMqxdSCF6Rp7BbgnJ/PqMHvh65JcczdJ85wSNhMVZJG
 wew0jfRAG/I46juDZQmyuL7xyaVbRwQmzYT8edLPxWp1xiQP5q8NA0P6JEVdoyDFVLPG
 F0usUdh7uGLC6GhXsV/8lNwONgcvey62V3mrmDgd5ZEYyrtHn4W5DZZB4vXXyMZ7hcHW
 rOMhHAtPc09MH98/WXeu7HuR7KYbPNYr3jwOxnG/ipoPJt3IHbSbxpETWDzCavEafc13 iw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w233vfk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Nov 2023 12:59:38 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A9Cb0av011171; Thu, 9 Nov 2023 12:59:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3u7w1wcvu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Nov 2023 12:59:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfXoNfm99hFn4J2gTpvjUF3/rakBRbOlknbkEw3VuBmV50w9N8xGFjYaq2b2bslceV/6yO3fkA2qcoSlFJVQmfvH9XvXw203LvBfWftlQYLffG0HmDyx5JKK2oT//61I+Im2pSHtc7yp/RGqbAT4J1vv97uaD9eHeNyAfYg9K38fBg6N5Nf1hEXZrpkepO7f0ffr1nvmhMY1LYU1OmnLu7hA3mhhuIEQVICv/kh8xl1HBiEpyUklZro1ICsaIXAHb1Awytz/VRZobiR9Q6vBvQzZlr7YkYvqRKasXFJzsGze0kcAmk5Rj19LXo3GCjeodhGhNS2tQQvwGFO4MGeoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWpxtU6KN3h/v/AatyKNPUoIXHnXBbmLB2ietWnOCDA=;
 b=RK8opMF0E03B4o5PTxH26yRuYaZfZD65RXWjNTubvSzEBbmnunllV/H7sBReBNKn1Teb+03e4Aso1gQ/a0Fpv2XVMZ8rPyIjpO9g/OsrnuPlaKBVH8U3KI49UDJEeKBUI8LNfJwLabV6/COnU9tm+qbUnUW60OC5we/V7UiVx2KLLxhnvuzFfVeFCwODbCcDjSCrhtk2Ws+KxIaa0xA7WZK4CBaFvnCNwQbAnQksx46E5+02XhQhJFlS/vZIviW9yJ1ykoOMGvkklmT8YacFdOuIBeF4MEAyuCyxvwUGnTWiC9BV2YIr6yY2da8LDf0uWBwqhrxBduRaKyG6kADFaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWpxtU6KN3h/v/AatyKNPUoIXHnXBbmLB2ietWnOCDA=;
 b=C0Q6PEtzD2TO4mChAOhePLyjAPPjj1TAAh9bYZm3EqZCSPjEHlGLB/GJ0nCGNs6BjnQy4LR375U32l9t5Zo88EVqNAOTB3k8gEbocFIHFqbyCHlnhRnGVIMiSra0pnUTt4g1TG91NbHC/cBgf4xupUj0t+pwm/xxSynGcfup1qY=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CY5PR10MB6213.namprd10.prod.outlook.com (2603:10b6:930:32::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 12:59:35 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 12:59:35 +0000
Message-ID: <592a04c2-0b4e-4bb2-80e4-f4c2dfacf00c@oracle.com>
Date: Thu, 9 Nov 2023 12:59:29 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
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
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-29-zhenzhong.duan@intel.com>
 <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
 <SJ0PR11MB6744D87FD3CBB3380647E68792A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231108124817.GS4488@nvidia.com>
 <b6f22a3a-84cc-44ab-947b-b7e12656fe87@oracle.com>
 <20231109125700.GZ4488@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20231109125700.GZ4488@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0663.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::10) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CY5PR10MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3a783b-852e-4a03-fbc8-08dbe123b974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evwB2P3H0539BXLaETCWtxAfdG0RwMvaDim2nxwMoC1cDoYa+W0SHsvvuEdxttHjsYt30OoO82RHRKwBn6shyBbXC8p5nz6HzYUl8pGK7A8RrNR/9mR23293zePaOb1+Eg3pMM/MzSSXF2DA2j+eYVdZ4H+wH6Trwm0xplNlH1SFMcTPHBKppxAEP+GGu0F502CXI9zjvOXAllm6vwXzDOTiIHLPI+ob1Un5tBUK4bTtwwpXOLSVO7MlKI118nC4SCFE72r4gzQlqEOnRJgjN0UKge3x72ZVfSim+jtEuKmck+yW1Fs33MDHCznkMvEp1nkl4zEt2b6tPGIW5sZxInRSH3oTEHQ8yZ3XO7pAyZvJtcnTMQiLnikMTQ1pMX+nZtge5gXz241qNhAaz+uUlHiKkYF4G0QTtgojvPrL5blzl+GVoEYa2Sb3Ee169bCuB6v4cBS/jsO4GFjTLJ/sxD8IyVjSvTIPJVv5fI7NgyDlS8QeKcqxcEBs574K5SEb4MSsktr1O0TKumaadKpUJV930ocGMegmTHg6/YPt8/sGxgn4DNUfZsiOTOEKSpnrvjmGe4fliqgNpo2vvYmF6cHFhgRxF11YsH+gaET7DsceSfp+bk1zPCWtBAo6lkc8Idp0oJu5Us2f5ufk2Dwrgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(4326008)(2616005)(8676002)(8936002)(26005)(66476007)(66946007)(66556008)(54906003)(83380400001)(316002)(6916009)(6506007)(53546011)(7416002)(5660300002)(478600001)(6486002)(6512007)(2906002)(31696002)(86362001)(6666004)(41300700001)(38100700002)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDRMYTNkbGtQRnJrQ1NNUTY4TEc3YnBDVkRyWHJRczAxNjUvZEc5eFc4cThR?=
 =?utf-8?B?ZW5ZS093TTl6c3RVL1JwMkdNOTNVZFFjSlhGcXNEMWFtNTB3RnhRbUJlS2lB?=
 =?utf-8?B?UVFxemlHakNsU1NzaDI1ZE1sRVZDMFgrWDVLY1VXSjZMY0ZqUWhlWnBCMEVl?=
 =?utf-8?B?SXp0SFpzRE5iNkVBVWs1Q0ZjcVZZR0Y1Q1lwaVhLU3c3ODZTOEJNMEp0aW1M?=
 =?utf-8?B?SWdLMVlFOXlLa3Evdm9DWkdveUFieTR6Z0xWWDZ4ZGNMSFF5UDd0eVlORXEz?=
 =?utf-8?B?UWl5QVVlL2c2aVJab0luNzVISE55SVU3SjNscHlTUzMwM24zS3RtdThJbnZI?=
 =?utf-8?B?VDUyUEN2amsyQzltY0RhSFFiM3N4OWpabEhxbEVjRm0rNE1aOUJEbmg2bk9n?=
 =?utf-8?B?S2cvVU14bEdOS3p3K0EzQmhqVFhydXhCbHYyN1h0cHJoL2FTQkRZYXVpV3R0?=
 =?utf-8?B?NzAvYWtRR042ZHJ4N3FWZHc4QUg1eE9UWW9KNGlQOUJUWVhaczdwVXVkOElH?=
 =?utf-8?B?aTlKZXN3RlFGVkZ6S1p2dTExTjV2eEpoR3NLRGlMVVhBTE1aTzIxSWt2c3c3?=
 =?utf-8?B?OVJ2YzJFbithN3V0d0tBRGkrSW1SKyt6ZzNSdUp3YlkwUTlRSXcrdHV0Tk1V?=
 =?utf-8?B?NlhiS3BjMm8xbk4vTFd4SXpiek5ZVThrWDNhKzREQjR2ZU1BT3BRQURwakNK?=
 =?utf-8?B?VmIxUDJycWN2YzZYaUVObVE1ZXdsb1owcUhqYkZUU2txUmlxUTJPR0cwek5j?=
 =?utf-8?B?MExPdGNJc096K2l5YUY5cm9jUU9FL0MxRkNZeXY4aFEyUjVpdXpJcFF5OFpl?=
 =?utf-8?B?VldIZnNHUVQ0ZGdIUmNML29VcVlTTnRuclhMM0J1cTVyVzdYREV6TnlUMFA3?=
 =?utf-8?B?c2lLR3p5OEdOVFl3UEpTSHBqeXl0aVVUaGE5aFk0SHNTQVZiK2NUQ0N6LzNX?=
 =?utf-8?B?eVlZQlRxME1LVWhmYzM2b2pLbDkrYXlqcGRmNTdJMXRYbEI0Q0hGTjhqS0Fh?=
 =?utf-8?B?OVBKMHhZeE5nb0YrSEZZVm91QWFVcGVoMEJJcVNVdHN2MU1WajF5QUVoUnFQ?=
 =?utf-8?B?bTVrTGF0UnJWN2dpUFZDak1xeUJKSGFlQ1NtMHgxYWE5Sjhtb3JGUTUyR1lE?=
 =?utf-8?B?MGhSUXduK3NYRTduZW1VcmdRaHVvQmxWNG50NktWT1l1SXNjZ0VKZXBOL2tL?=
 =?utf-8?B?SWJ6ejVvRTlhSm9pdkw0cERoMTlZS1FkR0JYVEhyVlNncHY1M1RqMVJ1dGFX?=
 =?utf-8?B?bnhuQkQ2Yk1KSE9KbWt1ditieDdWOFVLT1prSE0rYUN0QWJVVlpXNjQvYkdL?=
 =?utf-8?B?bHdUdDZxdm1mSXpETG53TmFoQnJZY05KMVcvbTVNSjFQandQT254S0ZjSEsw?=
 =?utf-8?B?UHNDbHBpVXRLczVUNi9VcHZlS1ltcDl6WTRTTm9vM1RDMFZsUm1TWmh5bUpP?=
 =?utf-8?B?WWlseGc0cWNBa2x0S2xFS2ljKzRRc1UwcW9UZm83TlhadkExeFpoMHA3L2ox?=
 =?utf-8?B?MHhFTlJEangzTENSZmM2WU0ybVNHRnFsdzluZzcyQSs5Ri91STc0MmR4NUJH?=
 =?utf-8?B?S1VpZWIrSTc2cll4SkZnWWkwMGVTVExtTW9RWC9vSjRuSXN2ZDRoZnUzcFFH?=
 =?utf-8?B?MC8rL2J0dUVGNmVlOG96U2V2cjNuSUoreXhNU051K29oUHdYOXBySUs3ODRN?=
 =?utf-8?B?VXlzQmROcFpjcWFkRjRBVGlrYmpudWtqV0JlelAvRitYdGJac3JYVG53empr?=
 =?utf-8?B?UzJqS3hQbWZpYlZ1c0M0cExrcTUxZkdvQzJRUEI0RmR4R1NXV3VHdEVkOG1O?=
 =?utf-8?B?M3ZJS2k0V2wxcVU1U01KdkJuMWJTeWJUME1CUXg3NWdhejVQRnJCZENtZzZa?=
 =?utf-8?B?NVJPRC9LQ2xwTnBZd3NxS2dtTjdIT3lqZ1d0Q2xwREtmNWlqVWJYSkpOVnVU?=
 =?utf-8?B?aDhlQ1FPRkp4dktJZURkLzNmOVBlNytNZis1a3VFL3BtSVRNeTg1SXpwSGVR?=
 =?utf-8?B?TmxvYVhUQnZ6WTk4T3k5ZnZudU1JTStpSkFPQVJoOEI4WmJLQk9ad1BrN2k5?=
 =?utf-8?B?ZDFFVFZLWGVqQjBNNXJOZ21DVUk1eHY4eEc3RnB3a0JzbWFScWpXdlUzOHB6?=
 =?utf-8?B?Wk9FaEF1RUt1aUFTSy9PZmpyMjdzL1dQaWlpd200Q2Jxcm83R1hGdDhTOHdH?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hH+y+1uq/XCky16xLOgFCJPQ+prscvv2FmXwZczXm6Of3mSadQqtC4t7IYJ31kXbP10CKtDbH5InUEBF0ROKkXLTdRC4qPWHO9rzPYGOxSuiul25i4UgY8Yrzif2+CxdfPB7cVHoDkke3qp05Uq0sk9GeSLoKaM7hwIPrtE79r8si8/l8/8rktFIh2Z0C0CcuVd/b6US8qfvmy93gPQHFz1AHh/UEo1n6sYV00wBQ3ax5NLIagKgIjtkQ7ta+4zRh73ThTac9HT7KZ0kx2Q5gIMY6dM6N9mVZmMYe9MZjpeFlLnmzjVhwU8Oz1RyBmoD8Cdl6FCvaVSZzpsJzBf2Y30SydmVPQT9iCaT1TTUsmBmj//fdVOgyzs577nCUBLZ/XbiOle0/C8qKJy9RiIwLHDaCkbSA9rynublOav8X87uHMXYh8miwg+GkQHdkVCb8On6sq4UyQKXxpzLw8WOsE2LminRzMtiRDDOzrAa+/6EelghKrdDlkVwiySHky0HcxuKTyWpiRatgBpuPcSjOTxu3ym0xO1YbcmbK/DuUh6dW3Sz1+gWIwnCoHjNRmbMhhUbSk+ukA/YVWSdgtK74sad9JYZyAGRGiHb7dSpiMVs/vZ8z+NbpzalsxcdixKGm8KdIpuLUD2wpFHB6obimYm/LyAMRkjwRJHVy7gmGGpMgfLT7b71UAQQJBkJyucOeTZ5gXc75G1cCce/0InUba2uA45WRFP9S5A1WUWX3CWR6+Y21krkqdOWuAUTAPJDe4IGGsI3sL/G89vJZjLxuweAOaPDEHaksRYG98Z/0SPLbjvFj8jf0+bJ/IBQkSTG75P/7QfBrwgBWWs+O2tKOmvOVrKpbNGa2Gxi26yvCKOk/A+7r+mwcHEk4sia5dwv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3a783b-852e-4a03-fbc8-08dbe123b974
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 12:59:35.6377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmoVg6Nvb/XrO2V9PN69ZBl/XpwnOspGvg9LKoGVT2h9ZEkuhhUjUfJPgXkbT3i10y7/zJJ6hxZ0MFFhcXrSOav78owQ663oLlWKCyvY2iQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311090097
X-Proofpoint-GUID: da5ioN9Q-DsA4whSIOKZs1kAIJvNCsO_
X-Proofpoint-ORIG-GUID: da5ioN9Q-DsA4whSIOKZs1kAIJvNCsO_
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 09/11/2023 12:57, Jason Gunthorpe wrote:
> On Thu, Nov 09, 2023 at 12:17:35PM +0000, Joao Martins wrote:
>> On 08/11/2023 12:48, Jason Gunthorpe wrote:
>>> On Wed, Nov 08, 2023 at 07:16:52AM +0000, Duan, Zhenzhong wrote:
>>>
>>>>>> +    ret = iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>>>>> +                                     container->ioas_id, &hwpt_id);
>>>>>> +
>>>>>> +    if (ret) {
>>>>>> +        error_setg_errno(errp, errno, "error alloc shadow hwpt");
>>>>>> +        return ret;
>>>>>> +    }
>>>>>
>>>>> The above alloc_hwpt fails for mdevs (at least, it fails for me attempting to use
>>>>> iommufd backend with vfio-ccw and vfio-ap on s390).  The ioctl is failing in the
>>>>> kernel because it can't find an IOMMUFD_OBJ_DEVICE.
>>>>>
>>>>> AFAIU that's because the mdevs are meant to instead use kernel access via
>>>>> vfio_iommufd_emulated_attach_ioas, not hwpt.  That's how mdevs behave when
>>>>> looking at the kernel vfio compat container.
>>>>>
>>>>> As a test, I was able to get vfio-ccw and vfio-ap working using the iommufd
>>>>> backend by just skipping this alloc_hwpt above and instead passing container-
>>>>>> ioas_id into the iommufd_cdev_attach_hwpt below.  That triggers the
>>>>> vfio_iommufd_emulated_attach_ioas call in the kernel.
>>>>
>>>> Thanks for help test and investigation.
>>>> I was only focusing on real device and missed the mdev particularity, sorry.
>>>> You are right, there is no hwpt support for mdev, not even an emulated hwpt.
>>>> I'll digging into this and see how to distinguish mdev with real device in
>>>> this low level function.
>>>
>>> I was expecting that hwpt manipulation would be done exclusively
>>> inside the device-specific vIOMMU userspace driver. Generic code paths
>>> that don't have that knowledge should use the IOAS for everything
>>
>> I am probably late into noticing this given Zhenzhong v5; but arent' we
>> forgetting the enforcing of dirty tracking in HWPT is done /via/
>> ALLOC_HWPT ?
> 
> The underlying viommu driver supporting mdev cannot support dirty
> tracking via the hwpt flag, so it doesn't matter.
> 
> The entire point is that a mdev doesn't have a hwpt or any of the hwpt
> linked features including dirty tracking.

I am not talking about mdevs; but rather the regular (non mdev) case not being
able to use dirty tracking with autodomains hwpt allocation.

	Joao

