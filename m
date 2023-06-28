Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D97D274144F
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:54:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEWXJ-0008AW-CK; Wed, 28 Jun 2023 10:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEWXH-0008AH-Lf
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:52:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEWXF-0005m5-CW
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:52:47 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35SBT84T024951; Wed, 28 Jun 2023 14:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+pm+Xfbi6cxCR/ynm8Hp0RwrbevkDAMa9sME4fqWtA4=;
 b=Szwo7FuBZ2+BZRHyUoV1bawbze1bwdiEhL2TzplZ3T8oylwqPmEEwG0cC5AVA56W9ohM
 lvFY6Rly3463ks4bhaEUEKJuMhKNc4cWRlXh9iTA5+l4wk27o29q6BzJ7IqlQd3W/xL4
 tOUtynSimY9wt8qYGIoBYLjF+aiCtfmdqf8lZh72YK0MYCmt9pFhcyfT+cdf1jQpZdZI
 OUMLx5SAyb2UqnJg726dOnAADFT+WdgRHS84yOfWZpERzgQAj61dUrRV6xU7eLC3rnQM
 6DItYz5KtEXRfDx46GwbH73xSfcH85Kvj/3mZ7uHAydVMt6URYE9LONAd+59fKKeUaIq tQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40e5xsn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Jun 2023 14:51:54 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35SEoG59008588; Wed, 28 Jun 2023 14:51:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx63tpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Jun 2023 14:51:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eORw5ko0SXXQI5oD58D58OIikBBaO29xpDH70rNBPkjq8rSEP877Y5Gyi64ma/iNLm9uKduaYnmv/sa4gG+5+fslCa3hammwuKDe9SmKJwkJT0wEWgU3PDofB9FokDiAUop1jJCN2vuzwaSNl9f+usBL4iAyEQIYz49IXfq4VWRHg4KgIFROl9FCKO6Ov/jFIle4XmTNfTjQR+nj+U9VUWZUFRFgXvTK6m4oSdFiCPO+9DFUYSg8QBHaFbkl0gK4ldzzdCwcdKT6stYK36vxE28inTZifDFELV2wVaw3Xz/rr0Ghpm7UkxgzFbUwg+3EPKfxNTh/YaCTHuxOZPb+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pm+Xfbi6cxCR/ynm8Hp0RwrbevkDAMa9sME4fqWtA4=;
 b=YAKxt1ZRss0gfWO04m6YnENlPsfdsWpOGEtag5fUPFVMiig9LtXdiymUGPed1EHuhzBE2LsmdLByqEqBKjnP98mlkvQeicEyF3GN2AowhiASGoyz3Fr9lJxu8Qal/AgjyErbybZD+pGRMnO7cvuSW+eIEOHA+qebs9E2N1qiccVAwR2UVELYuOIxx2JixwQa+A2Lwm8yZ7JmmNvV6xfola25ne9YsGlNvqmmT9MLKBIK7T++PvC5MD5nZs2rxLU3lRCIaeKowqB0r4jsc6yphYoPqtc/MeBND4p3mIYZqGCbQOEohax1H0cc2eNoeABjKz6+lUhquLiIom24B9qi2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pm+Xfbi6cxCR/ynm8Hp0RwrbevkDAMa9sME4fqWtA4=;
 b=KRNPi6II6LPPr+/T0pN0zT2JmZt39pMESdvQyN9lyWaQSclVyC8qYFrAsXkcVNPzp3QRFSnTz9NyDmBuUTADt0Ui3+4Fi3OmzvQpdFmA/0RYM8BN1v65n2LMa+F0qJcP7zrUzaxDdG44sxtEhKNFSo5O28cA6PvWbxzsJdZ2KJA=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SA0PR10MB6426.namprd10.prod.outlook.com (2603:10b6:806:2c0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Wed, 28 Jun
 2023 14:51:51 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 14:51:51 +0000
Message-ID: <b9c42787-0f8b-b458-0d8f-c691f7be5276@oracle.com>
Date: Wed, 28 Jun 2023 15:51:45 +0100
Subject: Re: [PATCH v2 2/2] vfio/migration: Make VFIO migration
 non-experimental
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, qemu-devel@nongnu.org
References: <20230628073112.7958-1-avihaih@nvidia.com>
 <20230628073112.7958-3-avihaih@nvidia.com>
 <0b6b4262-5782-bdc1-428e-2b106411afd3@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <0b6b4262-5782-bdc1-428e-2b106411afd3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0212.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::32) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SA0PR10MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: a52cd332-0254-4471-c9ff-08db77e734db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gqn9vNV5ohDZz6z7NTHScakYZswB71O7RjRqjHpi85B9LXGeLxrYU71Vmx3RdU2cdQgUGBixttrFsT3FxxNqRjrSxh37FSEHsP9bj4HfKFjTP7QPpZvYY5jecbmp3/tT1ImOHv+nej0OG76V+lglxIpCOYGdZcwS5U1K938oj059jYwTZPylGF1OmkW1c300mQnW+DXs6dt2uCtotQNiC0DFFrSZssCABf/FM6h9aykCirj4NwmtrKZBC9cgOZAcFJEue75eN/vNxlvlps7VPeJQuZh9RZFDdyfcAReKwyCzuwzqMNQzCCjgudUEGehmP7sEHB5EiI+6WSDyKzsDum0wqUhHI5Eiid0dF5avi8oQZzsMMzltMEyYNqM43IkBUe5EioXuR1RkhZbFHm9q6kfdcfTYwzwU6PKNikaDdO+ugc0OdueEFAZxexe/julhqLTfm7YGSYhJMX4tGUmlFTTtsFq/CHIkScrrUOEvkBNF0KinG53xYXeKupcZXjt1dTtImqS5yVOFI+w/zcT/5TTPIT47eZuuu3Gawc/OvXfDicZ575YDGYQ/E/QHFW13ccgcRkHfcflUxFGQYaTBqG13eQw6gSd1nhPfOKhiFgyo+FNmmTUM2JiWt7Jlu6bR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(36756003)(4326008)(54906003)(110136005)(478600001)(66556008)(66946007)(66476007)(186003)(26005)(53546011)(6512007)(6666004)(6486002)(2906002)(8936002)(41300700001)(8676002)(6506007)(7416002)(5660300002)(316002)(38100700002)(66574015)(83380400001)(2616005)(31696002)(86362001)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3IyMzBQMWltTXIxVFhQZ0swNGswdHpFbWdlMmlWeStUSU8wWHZrekNEVDFS?=
 =?utf-8?B?ZVNoVlQ0SmNOTUZyK3BHRC9CSWxRb0hhK3lNcDgwSSsxTWtpanRtbkplYTJu?=
 =?utf-8?B?Y0RPZkRxT0g3T0ZBaHRFbXlNMVVabUdRTFN1dUxmZEZsZlpyTTk5ZjVtRUZG?=
 =?utf-8?B?L0hCMzlSSm1OSGdDbDFBTFh4TEVmWTJCRkgxZGlXbjNvU1l6eHIvVHB2anBi?=
 =?utf-8?B?Szc0dVlaOVUzR2MrRGJlR0Y3bG1lQkNYMjhkZ3FGbDhDQ2k5UkhuVnRyWWxo?=
 =?utf-8?B?MmowWlpYbFdrMGsweXRkV2VWZXREVzZQNG1abmdMb1ZnaVVQd3R4dko3a1FO?=
 =?utf-8?B?VnpHQlQ5dVkwUnRuYTY2NnBHNU9lM2NaUTE5VGZjb0hVWXNwTytwZlZUaFRa?=
 =?utf-8?B?SSs5TGhhRjVNNEQ4T2h3VVFrcFdiZzN3VmlzU0xZellENFhPaVhoaTYwUmJN?=
 =?utf-8?B?ajZveHA1WTlyRWdHMmxIVTZrSmxOeUgvNmlGc3BMbmRWZGxUek5KSVRNcmhM?=
 =?utf-8?B?MGxzN0hLaXR1YmU3OXA2R0dYTXYwR244TEhuZDFKMjdOVHRSQkZVSXh3OE1X?=
 =?utf-8?B?SWtuNVoybk9CcnVQbHE5VDdlVEw1MGxSRzcwNWpMMlU2dzJCalVVTTFnYUVY?=
 =?utf-8?B?eCtnbTVBOW5PK00zMFJkMzdIMGhPMnpNaEwzWHR2M2hQZ0ovK1dseW1Yb1dL?=
 =?utf-8?B?MHd0aEFGQkFqalZKZGZsZEExaGpWckI1MXRtVGlneFRqb0xLTzdHVEp5SUhq?=
 =?utf-8?B?dEQwS1kzbDFlS1lneXBmT2g2QWx1dGtwTkxia0U5RU5EbjdreVNhS2t1Y1ZB?=
 =?utf-8?B?Rnl1b1BjTENaOHdJRUM3eERScmdXR2YzeEs1Ni91Y3JZbysrNlJNSjNGSVBh?=
 =?utf-8?B?OGlHM0ptWmhZMEl1emwyT0gyWVcwNjVkVVFVamhROU5kVlh2T242cDRpYUkw?=
 =?utf-8?B?TzlXNGp2N1VVeVFOWU9xZ2hDcHVXTGh1NExPWHdKTVNTcEZtZTI0ZWdKU2pP?=
 =?utf-8?B?YnNOVmxaYzFQQTZmUzZvY0hzNEZvZXVOY2RGeW9CTEhCbTJham1mY1dPV3NY?=
 =?utf-8?B?WXNTc29ubGVPcW5EaGN0bDB0dndmYWJwdUdhZUpVWjNJczk5eW1Rb3ZlVG5o?=
 =?utf-8?B?VmNKZE5nanFuempNQkJ4WHlQWmwyc0N5N2FXbWxqV2phbVUyU01SVks3YkZw?=
 =?utf-8?B?WmtJcGJkYmlVWWwxU0NZTnNwVGlFbVkvYWZFZEZpVGRZVjhVV2tLQ1k4cjZJ?=
 =?utf-8?B?eXdRYU5HMzdURFExcEdBSnF1ampRTmtNWDAxOEkxVmNCa0hEUmV2R05vZEgx?=
 =?utf-8?B?VU9jSm4rd3g1UzBDTjkxWnowWm5RMlc4elJON29ockpxZmM4NzZmV1JEQkNE?=
 =?utf-8?B?WUpIL0drSGdIRXJ2Zm1mU1R5emFHYWZLeGs5VTF4bEE5QmxFNGFMMkhxaFB0?=
 =?utf-8?B?cm1QbHI2OTl6K2hYWTBQSDY0Nk5sSDdDR09OR2F0cXd4SUtYdHpXWFlmZWhC?=
 =?utf-8?B?VW5tcklMbVQ3ZmhZbUF3TDdsVlJuSHNUR0hpWEFQZStjR0p3SFU5aGpWdTNU?=
 =?utf-8?B?MklPTmtPUi84STNxM0t0aUt6c0ZIaG8xSWRSYkZzNUNzQkh3U0I1bU1TOFZK?=
 =?utf-8?B?VzNUQlo0RXordHNFYVBPV3FkQjA5bFBIQ3lHbUpwaHVUampnZDd3ZndYUUpJ?=
 =?utf-8?B?TWJHcHY4Ynl6RzM5WHJRdWc0SGhtbGVLYk5xL28wN3FxNW1FcVBNRzBUTFRC?=
 =?utf-8?B?aUhhNjFITUFBcTFncGl4dUY0YjNxS3hEdkJ2eUtKNE5MOEtuenFYVkxLcHJt?=
 =?utf-8?B?MmlQWHByOEZ1QTlEOURTK1IyV2sxdlF2b3c1NFpKeFFZenp2MmlMU3pvWTVI?=
 =?utf-8?B?ZWVDTzc3dGVtcWxQd2Q5NEQzSkFFaWJyclRpNnNPV1dZeHhKZWUvaDlvU2pP?=
 =?utf-8?B?cjFvbFMwV3dBRDhFb2xTMEllZ0dNbFVaOU0zcWFsZzU2cmhyL0MxRXNJSWRD?=
 =?utf-8?B?OFp3bkhSc0IvQkNscDBNc2xPS0NoMjZZZFN6VXkrdlRRRkFJVnVQM2hMcXVG?=
 =?utf-8?B?MlZKck5Fc2I4NjNPQ050Z2NORUlTNVF6cGFhM1BvQWFlTkk2dFFTSDlBZGd1?=
 =?utf-8?B?RXg2NnFLVjR0ZGJEWEtENU9qQWZLcDRzbVNaS0VCQUpTeW9aRzZXNmNxZURZ?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pawb8l9xriHUdImVgZMpbx9FHnZZeZCnAdPfUR5LIvL7t/QsxvgaOw/QAGHBj24eJruQxCVerhNE48ZEHbwMvU1Gi0a3+3B81dUECPoohevZlAym995EKjxC4s8e5zhkqofWzS71jgfAm5hbWQczMk31Oeo0Lhbng8DgXx/y1VRCdYaml94IchYNhLhr3Sk0lO+fkIxFeZHey9PZUHdiZ9Fn1V3esM3SEGO1H7GFz0bMmqdumauXZ5zwhIinTXxfR0AseELY8nAC5PgB4Pj5A1F/7TdZ/PX3yjfcHw1x8AqKqirLm63lhM5kzbn3VR4nH8nLY9rwaHuuHtTfCMizcGivpyjLNzgAhViomf1oE6RMCLla07XqU22bJqxkJW1NQ6qvNdl3EzR45GDpUThCX5TBNQRLrLfEebrj6fVLknSAwD3/VAx8cvy37e+WBPEqh2fkqYQK0ddDmznFx1p20XxX2IAuWDLm5HEhJoL+MyvZSo86UmpKEq5Rax6CVyk0XHs9+FI7v+6us4K2tQVaQayxPrHd+6HvnWImSIBL/ozlMnYZYxsnjjPTAnfXVVsDLIzLVcpkgrEXeXm6kDkoFKbRrej9QYQtH7PMcxTvDakg1t+F5VdBzYEPIjLaHFI2sH0IZ0/MXmNyQJuXuKmjQBv+dfzr7ThEfuexAW0nMj6iIEqqqcm0QArh8P3j1NGyxl4XZJOo4BdVE26jIWV0Ble3YHAj5N/UgXOtGpw3/nZ/onRmySKGOqh2yPkFNA9Yi4tjaYMQYmiomrXszF77KhUlUleTZF9OZfKO7EbdaYVFHyvACQRld2iQrwjzRPmvB/2FHS8lJry+aHKn8n/Rtw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52cd332-0254-4471-c9ff-08db77e734db
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 14:51:51.3177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5xQu3oHKUamP38aBswBUvsARpS7TR4o0H7t+K6yjcISKfOSMBgl92e8I5Q1MGC8o2g1EmKEO3b+RFb9QsRJYqUshFKmstOxJ6IS83pw5Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=993
 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280132
X-Proofpoint-GUID: PBJNlrVSck0rdrP9Ah0IBZV5fSr_N_9C
X-Proofpoint-ORIG-GUID: PBJNlrVSck0rdrP9Ah0IBZV5fSr_N_9C
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

On 28/06/2023 13:54, Cédric Le Goater wrote:
> On 6/28/23 09:31, Avihai Horon wrote:
>> The major parts of VFIO migration are supported today in QEMU. This
>> includes basic VFIO migration, device dirty page tracking and precopy
>> support.
>>
>> Thus, at this point in time, it seems appropriate to make VFIO migration
>> non-experimental: remove the x prefix from enable_migration property,
>> change it to ON_OFF_AUTO and let the default value be AUTO.
>>
>> In addition, make the following adjustments:
>> 1. When enable_migration is ON and migration is not supported, fail VFIO
>>     device realization.
>> 2. When enable_migration is AUTO (i.e., not explicitly enabled), require
>>     device dirty tracking support. This is because device dirty tracking
>>     is currently the only method to do dirty page tracking, which is
>>     essential for migrating in a reasonable downtime. Setting
>>     enable_migration to ON will not require device dirty tracking.
>> 3. Make migration error and blocker messages more elaborate.
>> 4. Remove error prints in vfio_migration_query_flags().
>> 5. Rename trace_vfio_migration_probe() to
>>     trace_vfio_migration_realize().
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> 
> 
> We should rework the return value of most of the routines called by
> vfio_migration_realize() and simply use a bool. I think Zhenzhong is
> working it.
> 
> Zhenzhong,
> 
> When you resend v4 of the "VFIO migration related refactor and bug fix"
> series, please rebase on this patch since it should be merged.
> 

This, and his switchover-ack series from Avihai that preceeds it.

Perhaps it might be easier to point to your tree:branch where you are queueing
all the patches?

