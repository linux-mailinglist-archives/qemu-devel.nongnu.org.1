Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A52742520
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 13:47:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEq6M-0005eW-4s; Thu, 29 Jun 2023 07:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEq6H-0005eJ-RQ
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:46:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEq6F-00079O-Ky
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:46:13 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35TAoaVL023536; Thu, 29 Jun 2023 11:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=V7xea8I3CZLIcakZyBSu3RThU4wH7WSmGZQlsriOtKE=;
 b=DYOzsnmai+GGldRf7r/AZJvVZIQ+L+s38DV1YwMxIsJKcU1POJ0PwTjuoTqNB/TaMZIp
 oNAXGV9j4sa0biVFZ2uXjBLBThCWZAtw72GRs1atDTS8KntviAGV+/JhLU8y75IB+5MP
 kBofv0DPQgH+xL7DjLs0xyT4QHWIeRCqXD9F7TqSnGo7XQO95pB5QyfMNCZNeHBhEtd1
 fmVdutvUXPfs9gM3JAhaXsyaPRKxdbasZzIsDq+LNdlgjuKauOXQ59TBP0vMXAetkoAx
 Eda0PuoGnLtxLbGEgA4g/C1JR8vWdKTcwRyJDZe44gTjS/AqK1ExslhBgDgwrJiAFI1F xQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdkr92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 11:46:07 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35TAKOpn029607; Thu, 29 Jun 2023 11:46:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx79e4u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 11:46:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpf7QRTgUYuzZnFf3rsTqn6gdwwnV34V5rhk6Pf82UYhtt0+2SH2Qzbj2okinT58jl40w+hhoDXb2DYhDpgx/1HTFLFYQaX7ZY4SNxPmbn0OhIryAGlKiotLuPZCVH67dlN91gFcKtBye49/PIVkfVf1wVdWQfTUV/v2V3Js9mVY8gKJw+3jr68YQghatcC6Y1a2VUdMzibkR+1kI6KuXzoyUodVTa10IkT+ODU+TBydbHOgfSc7+gXAajwWtlFxPetjAmBN1GVjJMf8F1h8z5xj+PUzgcTz7zQAXLqr5Xt3TD7L7WQ2aLHgS0PsWhaPHhKJiaVl9f11Cjz8dq/ufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7xea8I3CZLIcakZyBSu3RThU4wH7WSmGZQlsriOtKE=;
 b=IZyPU4AyhNlX8UAiwhYYAncYrYqjY7dsCsh4opl6dV+iuBYDG1uf3VhQP65SetccxUzirAtnriD8sHQclsDSooJ2QBUK39EAuPtxGD86Efc67nDVTifZZet9362nATiFygJg1F65EDXuxQVTwyE1onR66JxnW7DZa0OyIHQCNPrrKfIB85kUwKjvWVm0nAOFiUbGzAtDywYC0Xow/6LUiAj1CBStdGcUYKmUL69sx2gZ9wd74qz04Q+Jti7iYlqfl0UHD+WlRhwQkGycXbBuqcg3UJ2VJQGQbuIhNdSxfIEejrgWid4oy2Prux6I0l9Xk4IyJllsVkRrApAMawk0Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7xea8I3CZLIcakZyBSu3RThU4wH7WSmGZQlsriOtKE=;
 b=GenDjgYwh9HKOaoZFCasprBYQeSEQotrMtLJXWtSTtGUHJ+c5fmbmyt+NDpU7qNGGKyUnuLjjfFIY4H+cJPiQCfLFVxmUKyCbwPGwJ0kJ+2bNziAeDjZ7OpZJfUxIDwd16bQUfN+2LrdAU0sZiYv8WxCP3AxdwBTd5tQRl2eglo=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SN7PR10MB6306.namprd10.prod.outlook.com (2603:10b6:806:272::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 11:46:04 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 11:46:04 +0000
Message-ID: <346b1c73-0efb-e339-dbbf-c4ae41e85861@oracle.com>
Date: Thu, 29 Jun 2023 12:45:58 +0100
Subject: Re: [PATCH v4 4/5] vfio/pci: Free resources when
 vfio_migration_realize fails
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, avihaih@nvidia.com,
 chao.p.peng@intel.com
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-5-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230629084042.86502-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0280.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::28) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SN7PR10MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 21da7b97-f3d2-45b4-2ba1-08db78966af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6Z4NKhtf2PBwAkrtuRkZN1qTV21THHjLLSQ6BbI2Nq5bds27tksKbTUrBn9BDssW5ftdBBqkKQmzaSNWGbDeXxjU8uBjkreQIGIQ5/b/5CxXZPsLdY9DGruKi/SqvJFpX6BIbDqwE8Mtytvzj+Gyh0P6k5WSqQbXpYkX7oVud1FIPoeIY/BY192SSylkwKTDGfi9QCyvxflgEAcvwmzD5dkHhyE6ku/o5vCuHwEL1PjEFSO0nmJHFWFbnXHvOlZoFsnLGdK5K23CjFGPwVqeNYhFy+XiZ5vhPzvBKl/6Ca9y9GobFaU9+5rENAKYoBy7mnistiCTU2BHc/mUhyqMLk4m30DVKqSl8IfPGJM1Mf9wspHr8DkTh+3MkJVXBuiMnepj3x11c3eDQahUW4dyC3rL5XCcC65YghCGIMdkZmulqDIH1jEQ7Kaf6K7oJHJEvEJqwCtEIy3FSfG+ENQJWfmLOjvGMcN95lLWdC53Y3Dikzg1rUpZI3p/8WsDrCqpPuJLdDJgT1U4Nxmv38iIkeF6pHxlUgT7rdquG6MhpjKYCjxgsFKYIVBzn/z+wKIzdxOqvUh90WBoxrY5llDQd6FzNtGku0ebXF6MRKJWENGwQO9eKP9t9/dZvkuoHLS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(66476007)(8676002)(41300700001)(66556008)(316002)(8936002)(66946007)(6506007)(26005)(186003)(6512007)(53546011)(478600001)(6666004)(4326008)(2616005)(6486002)(2906002)(5660300002)(38100700002)(36756003)(31696002)(31686004)(86362001)(83380400001)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnFiOUk0TkVKQndFbkhROEdCSW1KYVlvZEZPS1pZYXhyUEpucVVxZHhpdHpi?=
 =?utf-8?B?ZGtOTmVRRTBobldOWkY2eGVzajdFZHpDYnZ2bU5CYStDSUgwRFpOOTlhcjZP?=
 =?utf-8?B?VEpieitwdDZicThOY1FvODdaQ2tPM2RxNldJa09ydmN3NTRkOU8wUVBxTDg4?=
 =?utf-8?B?YzRydVp4NjczVW4xWEI0bG9KbHM5bjAxMGYwQ0NkVER1Qjg4ZkJ1YllucGEx?=
 =?utf-8?B?R2gyMjdxUWMwZjN4aW5HWklqeDF0WnNidUZ4VDNGSUpnZjRBK3hhMVUrc1lS?=
 =?utf-8?B?dzJ3ZDlpY3pzMHlTL242UStSYTBObko2dTlJcm4wZ0VoQVgwN055STkyS0NM?=
 =?utf-8?B?WnBqNFpvQSsvR0RLRXBJM0dKN3BHWERIS3A5d2RmZ1RiYy9XYWhCQ0xTV1kw?=
 =?utf-8?B?QUVrdWFpeWNrcG5vMzZXajgyaStmY082UzAvZzJ3cUFmL001UUdOdExac3g0?=
 =?utf-8?B?ZG92YXlxWFJkaGRKOXYxVDNLN3BBSnJHaldQQnIxOCt1RXM3UFNGQWNVeW9w?=
 =?utf-8?B?THI2S0JHMWNHcUtwemRRZWlleXJFT2VLeTF4RjZrWWt6UXBsSXh2UXB6bFhk?=
 =?utf-8?B?eHRDTForUTZwdXBWanZ4Tkhidmo1SU15VVlDa3ZLTUdrM0JSWC9VeXUvRnN6?=
 =?utf-8?B?WEVhMGFJY0hpV2dDSEtUTnRXTm9DalFlcm9JSzZXVUdFakdyZWZJTkdYck5x?=
 =?utf-8?B?RWJveitTUmhGVERrZ2dLYUhxZXlwbG05V2VIcnBRUHIxOVcxTkFyZmFWS2do?=
 =?utf-8?B?RGc4T2VDTm5wK2d3MExtekJWVW1oS1RGU1pydU40Q0l1SG1oSUlwR1plQ1VS?=
 =?utf-8?B?bTlyaFAwWUwzcEhBK01DdmUxcGtUMEpGUGxzam8xVTFMaEV2bG8wRXJMRlhL?=
 =?utf-8?B?cHdnU1BFNmRhMm5BSkZoNGdQRmRsUHNDMEZqMElOVHl0ZExUVDU5UzJmVG43?=
 =?utf-8?B?dmtIU0NTTnNFWXErTVVrUi8rbjFHNUU3Y0pKemJQYlJoSXdhSHRZdEtoR045?=
 =?utf-8?B?dkJYeVdLd0ltcGU0ZTZSNXhyT3dUQTM1bHNPcTBJUXc3STgzOUJoeXdsU014?=
 =?utf-8?B?N0NNcitPaDArY2JYd2Yvd2ZPZ1FZZGNQLzE1eFZyWHBRZUZlN2ZvYnN1eXlt?=
 =?utf-8?B?RlBncU1Jb3I3TzJrL0F4QmRDRnNTaTRqcWlTLyt6dFNaTmlKeC9FV3E5R1A0?=
 =?utf-8?B?TmRueFNJbmFackZLU3FzNVYyZGxzeXk1Z1Z2NWd0MmRBT09WcnF1SEZwRGR6?=
 =?utf-8?B?Ynd4U29uZWhZa3ZFZ0dFcXd3dHNjeHl6V0M0REUyYzdHSlV0MkM0UXFYNWVZ?=
 =?utf-8?B?VERocjlTSEx4ajdKRHdNa0I3M1NPMThPNHp0b1grM056dmlGV3E1Y014ZjR6?=
 =?utf-8?B?K0ZGakI5VmNQbmU4MHNEMlpPeE9NUTZpT2lMYUpNcmRXRkZaRDU1bEpFbDdR?=
 =?utf-8?B?enpFZ1hRam04dFdNdVA4VkVFVlZYY1M4OWpVaXhjalZyOWViaUI5cGROSnhK?=
 =?utf-8?B?SU9jWmFucHFWcUlnWkJ4OGdlOEFXRWxoeFVQWEQvNXFxbnNmd0lDNklySkx0?=
 =?utf-8?B?eHFKTFQ0UzJkUVdpQWlXVXJMWEJxMHBVTDc1bDVtR0IrcmJ3emdyTlhCSkVr?=
 =?utf-8?B?ZW80WnYrdloxSHZOa3dQWXhHYkdWSHhkOGdadlBwcExaZnJNOWlYWXNOcHpO?=
 =?utf-8?B?NmJ3NFdNODhqYmQ2a1g0TGFXMFJYN3hyNDRvL1d5SUZHOHpWNFd5ajcwZFBD?=
 =?utf-8?B?cGQ4dGl2QTFPalBleTNmd1R4Y1ZJV1dLQTZkUzRjb3YyNmliZTJ1SE9uMjdL?=
 =?utf-8?B?NFcwOTlVcFlPYU9KQW9sL2xkTlZlVEFhWW8vNmJRb0tldktaM1IwN3QyTGFu?=
 =?utf-8?B?V2ZYeUg4WktHWE9vYVYrelA3SHdLT0FodDJFb01HeXpnT3JKd2J1YWZXWFNZ?=
 =?utf-8?B?Y3JCeE05TUU0Y05iMkozMVFYUWFPUWtjMVVhNDU1K3ZzYkgrUWNmdTNBaWJ4?=
 =?utf-8?B?Vks5bjBqbDB3dk9kZVhCVzdHWnQzVG5YSkREaUZlRjBVUXVWOEcrTmNPTk5q?=
 =?utf-8?B?VGFyYVZwdThaUG1GZ0UwOThLWmZCZDBta3hzd21Ya2M2dXl6amtudXFWS3VJ?=
 =?utf-8?B?ZUNvM0xRN1A0cmdmTWx0Zk9DUEhuTGJGY0RaaWIvZWVRb25NdDBRS2JqVTk0?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jQGhk/hiUGAS97d08dBBfei+WyYoFrPgZ/59xTs1AsPlmfSe8VLPEq1abe6b0HFDfJSHPsVFumBTfuz8CapwSF06MpM60OBkHyLbxsTMEPIOAt/9qPJPbfDZxEQKuHP/WuLdqHEIAZH5EmElY+ygfIQIJugNUWjStogDpNVDIACMdGYThXc30Z5+gbzEK7+YGGWKjttXl4wUrR2KjGQtYi+RlKxOrTEWADtCq+kbhJT9wHjlkc2qQizJNE4iYhfY1c5hJyEbqhB3GFit6kECNJI4ihpcs9TT1ds695RVWWPkFD1jgTJZfXSkRhTbO29awEFyhqg0eFm+VhRQ1vk0ay4Uvw2IWFWuoNrjh4EBCsXOmvSvF6M4A+sf4tJBWc9Q/J8/MTcUCYzJ1rYj/3YPUed6vDM/w4QMYd+Fm807BHYjPZ9tEPG4imeSPGw+XV+HeiRbPNsNVBj8wygioFK4BGTqPMrjmgmhRtroi6BdQ5eS8fn6XIyYHg24Ba11eBpSva/CflI0MHvd9G5VKihyF+MkdA4G5PIBlsr4TZK2piL2puzxF/LhLzlo8D5QUoa9AWnbEwQOQOxi/TM2WAgK1qAI13f5VktReiTHloYhXlVohsT+mRAqh+/rirCxZ6U8iTeenBAJevA6OQ1z4jbGhL6ZNTRiASz+ALUGRzdvmNtK3pwc+WVOkYXlUpccI68mFfRq4YmYSraaFuIsB+4wZTeKyri/ZQVTv1uS7ZQ9ZuwlKft9QuJFlWYQw5q3qUxwQpnLtHgnsD0rXAf9eQ3KDwfWaIsHyvzP90pxaLtBxIKONslTStpw9VQGQCXWixqbfG/J/AfwZFJysikqt08y7A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21da7b97-f3d2-45b4-2ba1-08db78966af7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 11:46:03.9616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHnH08zqxN1pCXv9gHRT178Pp82v1yyjBoCaim3Kuf/7RH62uqE8xQ8oVFntiwPEeQ2ej7IA0MPZF0NbROgESbS6gz9bmlut3wPRXGuTzzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290105
X-Proofpoint-GUID: YrXndKdj9bDVcYAXczZuKKRwa7wo7Bg0
X-Proofpoint-ORIG-GUID: YrXndKdj9bDVcYAXczZuKKRwa7wo7Bg0
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

On 29/06/2023 09:40, Zhenzhong Duan wrote:
> When vfio_realize() succeeds, hot unplug will call vfio_exitfn()
> to free resources allocated in vfio_realize(); when vfio_realize()
> fails, vfio_exitfn() is never called and we need to free resources
> in vfio_realize().
> 
> In the case that vfio_migration_realize() fails,
> e.g: with -only-migratable & enable-migration=off, we see below:
> 
> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,enable-migration=off
> 0000:81:11.1: Migration disabled
> Error: disallowing migration blocker (--only-migratable) for: 0000:81:11.1: Migration is disabled for VFIO device
> 
> If we hotplug again we should see same log as above, but we see:
> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,enable-migration=off
> Error: vfio 0000:81:11.1: device is already attached
> 
> That's because some references to VFIO device isn't released,
> we should check return value of vfio_migration_realize() and
> release the references, then VFIO device will be truely
> released when hotplug fails.
> 
> Fixes: a22651053b59 ("vfio: Make vfio-pci device migration capable")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 54a8179d1c64..dc69d3031b24 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3210,6 +3210,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          ret = vfio_migration_realize(vbasedev, errp);
>          if (ret) {
>              error_report("%s: Migration disabled", vbasedev->name);
> +            goto out_vfio_migration;
>          }
>      }
>  
> @@ -3219,6 +3220,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>  
>      return;
>  
> +out_vfio_migration:
> +    vfio_migration_exit(vbasedev);
>  out_deregister:
>      vfio_disable_interrupts(vdev);
>  out_intx_disable:

I agree with the general sentiment behind the change.
Clearly vfio::migration and vfio::migration_blocker are leaking from inside the
migration_realize() function.

But it is kinda awkward semantic that vfio_migration_realize() (or any realize)
failures need to be accompanied with a vfio_migration_exit() that tears down
state *leaked* by its realize() failure.

It sounds to me that this should be inside the vfio_migration_realize() not on
the caller? Unless QEMU ::realize() is expected to do this.

