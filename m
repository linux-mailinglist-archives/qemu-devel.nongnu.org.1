Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E8174D804
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 15:45:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIrCJ-0002DC-7Y; Mon, 10 Jul 2023 09:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qIrCG-0002CE-HA
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:45:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qIrCA-00026y-5I
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:45:00 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36ABCpVk028181; Mon, 10 Jul 2023 13:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Fb1bG7VF8SEDBzGvYRUJ80qSSlj6kE94ieUgsy0m7uA=;
 b=slHaLUBowK6ZHxdXCEemLM9bh6ZN1zSnE6xdxvVTnBHGXbAi0vn4c6zN6BVnWgvoblen
 tmNSI0O/8kxKP+a8AQNWueQH75QqLgt6EKBK/+SlZS2Ut4plDGQnB7lOD4BPqsMIB9hf
 PUH+CFieD7X+JM/lhEeoJyXvUDA7f4JaqBSAeCioscBtiAQdUONAA0qTp+DfgqMYlw9z
 JvgRYpD4ZhWa3BVBxOGOrtAKW0JTqJcpwNduXFz7GNlDoL3Ds1NaUunfRSHqqwaNpFfp
 QtOq85Cvj853ddPuamnVa2Q8OGnMYYM2w6H98Q/DKvyrNrW1QZvWtb9XF54fOhASIFao YA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrfj60e4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jul 2023 13:44:45 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36ADanc0016117; Mon, 10 Jul 2023 13:44:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rpx8402vd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jul 2023 13:44:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVRUWqRX8OMdOwcmLcp5hIfmQfPD47vIvVEZUk/6Lt9zb1xDh9/BtxxP6KnyV6gEf6UThqY3280/9XfMHNDs0MPk9yAKcEVIeqXtTvqfWIsO+rzp0hPaf1oJovpZtlAZi6xCxyJqTcJM2JIKOrgb5mMtCQQfeNG9y72xkOZY8HTJdb5AEZjwriDQTLI3TMPFfs7atDf7wMz5qzobGP+7pfve/uDOkmJ7aj31G6fUo7BVUWDPSaH8il96f+4cVvPheLNAB28hdPwe6cWxhY5o6Btyp/lah1XtvLERfNBfs+nEnnXKYNIiVRjdmPwCppwbRkHtx2x5N6XdXVJAS1cBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb1bG7VF8SEDBzGvYRUJ80qSSlj6kE94ieUgsy0m7uA=;
 b=XkjSZODSZAif6ZuBsxnxx1bjOzvI/cwhqknL2n8WHY37t7ydWSkPBuYrUWIEvQp7VKqNIUfT3ZTIUjh1XRDNEzhtXb+IQ60uX6rED4CeZ6lYwIa02/No2fRd1T7fDIi4d+qFaVZ8PEu2VMt2GkSQV/iJvROxHffreJ8590rv/SOpIpdhz9llOIKwCnDFgk3VAvdHtpwaqig4xyG710vtVDyPaFQ0lVp2m/r/1OaoMwmZonr3PAUM06OZXm7CcCUShRw1zycdeo20VqJamgKxhvU6upoXjxQvCX9XRODN6ML4clLiM5x/ZQIieUZVQy42Ez8j9bFhC/QZJZM5BYmuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb1bG7VF8SEDBzGvYRUJ80qSSlj6kE94ieUgsy0m7uA=;
 b=bwKegE4VdiRkW8f8kYLZCJIAbamiESN09fCKIM5N+HBnLXgVB7Ge7LIigiALTzYkyVvJs2QiM4kAy30zqUI40aivtT5C2NqdbQrUd1kV/FRcF4EZkewkkCJMYjcyoutSp81W9IwTIAysbEhc/AP+0o9AFuzA6Uba3uNfnyR/Izs=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BN0PR10MB5160.namprd10.prod.outlook.com (2603:10b6:408:115::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 13:44:41 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::6db1:c2a8:9ec4:4bbf]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::6db1:c2a8:9ec4:4bbf%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 13:44:41 +0000
Message-ID: <c6886d7d-9453-b46c-5ccd-8f8c8dc76e20@oracle.com>
Date: Mon, 10 Jul 2023 14:44:33 +0100
Subject: Re: [PATCH v4 07/15] vfio/common: Track whether DMA Translation is
 enabled on the vIOMMU
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-8-joao.m.martins@oracle.com>
 <a9702678-496e-8519-8280-ae003440829e@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <a9702678-496e-8519-8280-ae003440829e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0020.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::7) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BN0PR10MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: 91208fd6-265b-4f8f-6d97-08db814bd00e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPuTU1heO7wC7ePzpC83nLf4wFqZdf7vDkpmupvH7HJZeQSApAJ3YqBSiINeNdKY+9bK/rIBal6S0VQPM6vqpHsyAWTzXx2RhoTHUF51rBlh3CcM2KSSy6v/0fngLyypZwra5NHpEEQ+zYTQZVxQ5qlRTbYl0ge4FFh3eOpUAjrDILWj6btvOpNLqNsv4iiVgqYoIpJB9HjEzNS7niN5mdYJX44T1/f8aSyeLgpk3nPwi+DIz+rMDUnkt/aN3vlup5BmXa464xBXjw/UbEnOhZISnaspUwpytdsCcvoRcs/28q7zo5CMMB3anaD4pFJm51Eg455z+FX1ibLzzfCbexyezYfWgKbIb87y522MchGSEzQ8BOW7LgN/A82EPzoIkuVav/gklj51/0EW4dOqNLv2W3AF3TmCnVfFcw/WZ1CSzUfcFQYRDTlLasclxmrciaIl0et0YHnHlobwcTF/COoTZxcj1kO17D62thN6o+oZnfE5YRY89yc1H7h4ftg8vlqYgRgoeunjwaxjcw6RDlzru2ztXRn0DdnoGV4Hbfp9mSOtkcxY165J6opUWdW2Hu0QUj3zP/AD0NLRPgrFexTkHWUBsLBaLOlLoDzZHwG1GiBgZqGUWTlUKf+tKmnw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199021)(316002)(4326008)(53546011)(66476007)(66946007)(83380400001)(186003)(66556008)(6506007)(26005)(2616005)(36756003)(2906002)(38100700002)(6666004)(6512007)(6486002)(31696002)(86362001)(478600001)(54906003)(31686004)(7416002)(5660300002)(8936002)(8676002)(41300700001)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTJwM0o3NFd1WDUwOEhYSlVveC8vc1dOSmFkQnk0QUVtTDhaQkc2Q0JQMDFj?=
 =?utf-8?B?WTYvVWdFd1FKWGNZdTdtWTFsWmsrb1ltOXdTc3dTbTRYcjJiaG14U2doSzN1?=
 =?utf-8?B?SXB5M2FndG9PL0NFYmQvM2ZraXQxQ3FzNFBEdC9EblJlTkluUERjWjVGMy9K?=
 =?utf-8?B?WDRmOHY1ZE5EQTN4ellHQnBxeTYyd01welF1YVVxdkdIWnJ4WityUDFiTmFu?=
 =?utf-8?B?VWNjQk9pQmwyeHlWNmx6UHFPSjVnL2IvVS9HRytNRWNTVlRPOHI4M2lKWGFv?=
 =?utf-8?B?V0tsREU2NHNuN3NnVjhzbzN1WmIxSldZUUJkR2VkMTdGcXNVaWRoSjZZYzZT?=
 =?utf-8?B?Z0JySCtKWFF2cnpzUlZiVTdmT1RNSzQwQnB1a2d2TlBXN211dU1sS2tlVEM0?=
 =?utf-8?B?YUVJVHpycHNzekVOeFRRR09PbkFjY0Q3OElQQmtydzhSSEUyLzZlelMvbVFH?=
 =?utf-8?B?aS9rRUdXUHVMRGlJVDcwUW00djBXRW00UHYwWkJrR2NFM3Rqbm13eUE4THZx?=
 =?utf-8?B?RTlZeXFCemhaOVJjTnlnRm1lbTA0SHJJVjNERE1hdXdYNy9uV2ZuWFA1THJh?=
 =?utf-8?B?VDE1VVFOMHBXUGZZZkFVdmhleHA0SWwzTWZiOG0wblluMDJwUDhaSUNyRFll?=
 =?utf-8?B?ZDRLUlI3WktUTDRMWWZxc1I4MjkrOWtBVi8rVmF6em0zWTZqMlZFYjE5WjVv?=
 =?utf-8?B?bUd6eGV5V0tyNnAzKzFoSk5ENmRVU0lrT1hGMXVBYkxWRFNPdHNybDcyMGhG?=
 =?utf-8?B?M0FUZE14TlA4aUIzTnE4dzE5Um1uZHZzN3c2cnpoWUZhNnZtWExHVWhCNmhM?=
 =?utf-8?B?YzErWFVmWnkvMHdNeTZraWJxdDdtdHlNeHA4RnBuYU9wak1vbUNFQjk5eFZT?=
 =?utf-8?B?b1ZIbGo2S29KMytYSjRXUGo2NEdBanhLenZNR05LdVFvc21pY2liUVoxMnND?=
 =?utf-8?B?OUtXNjhYcFRFeWR2NFUreDFBOS9Ec1dBQjQ1YzJUVXYrR1l6My9od0pkUVBa?=
 =?utf-8?B?UXJTSkN5QlRlS1BNY3FOYlR2MTFrYUJ4eDZKOHgycCtuc0c5TTFiZ21OVDJ1?=
 =?utf-8?B?eHp6YVI2UWF5VDVCZ21pUERCWWMxYW5qMDMxNVo2bTZEY0xGUlF3cHBSZTk4?=
 =?utf-8?B?Y2FHT2Vmd2J5RHlvOVRxS3Q1SWk4QzN2by81eXBHSk96OGE3Y2RYNkI4YjU2?=
 =?utf-8?B?QkpVdGVNR0ZaY0ZMNW13dHgvNXFxUmc0K1NyWDhpWUFiZmxETHdHRE9LeUw3?=
 =?utf-8?B?WDl6ZUtTazNaa2w1cEg4Y0M5VVFiU2JvclVXWE0rcFN5QnNqR09KSVdWQVVr?=
 =?utf-8?B?bEt5ZmVlRytWaEFhQlpKdHE5SlIwSXVSZjFHWVZkNG12Z0s3WTNXS2g3aFhH?=
 =?utf-8?B?bThPSVdOMGhKUmt4bXNBTVdJb2lpUVBKdE1WcFYvcDFaaFFHWTBrOWdsVG9K?=
 =?utf-8?B?VVBGQnFNd1hrVEp1czVoTHhaY2N1Y3ZWYy9WcGNwYnVDdVNPZVB6djBubE0v?=
 =?utf-8?B?ZmNKY2g3UnNYclowKy9xRzc2VWJRZUtnVUdJSzgrMjl4NHRkTHcxTmhiSnFM?=
 =?utf-8?B?MDZPRzI0S01nbjhBWHlBVFZ2TElPTjVMRkRFczM5elh5NnlreGJ3YjBjakRQ?=
 =?utf-8?B?bXBNMHMvaVVub2srUmIxajlEcHlOcFFvREQ1czFWL2wrTDJlR2VxSlphaWVF?=
 =?utf-8?B?eWUzcHZYN3hoaHpkb3FGcFV4NVduM3ByR2E5WVJkOW9aeFg0SUJyeEdoaXNi?=
 =?utf-8?B?cVVIOENLWndrbENNYXRuRTNkRVF4QmVFU2xCcFBnS1NzZGprM1o5SUE4NWF5?=
 =?utf-8?B?Qm03a005Z2VJSmVvU2dnemRJYnpxbStVcUtYOTB2MnEzdTMwc2R3WStnSVF6?=
 =?utf-8?B?VWQyamxxWjZwS3VCSU4xMWhhSE51VUVpWGloQ25QSTRwd2xnWXRicVhZN0dl?=
 =?utf-8?B?UTRCa2FzS05ZODZCL2Qxc2FXQVJEWHF2Y1RDVkRwaTg1YjFCcUZBNGVLVCtm?=
 =?utf-8?B?cTY0V2I1YUVzaWFMeFRLODRtQnkwS2hrK1FuRzE2R2k2UU8rSEdFa3J6RkdR?=
 =?utf-8?B?ZGpjYWJSQXN2UkxlZDFqcVhGNEJNc2x0L1U4WGFwZnZ2T0szcyt2RWFBVU9V?=
 =?utf-8?B?NjlqUllsR3NkQ2dpenNZVjR3TWtRd2Z2djlFcVp4QzY0b0lHZ0k4bnllNUxD?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dfACjRpSKAg5jeR8QZE9FbgCR7jMBQulwujEoZr65YJbSkT7hmURx2zJVjanRUHukV2r4UK+Vv+V4cGTT9koELLAWho8Rgv6c0yD96ZbBxS0VCPVx0U4dHghti5zYylBVvMaxaHidMCYX4AP7YBCaEqLm5c5wLOTOb0EEfz0dDyzbTcRuXZerMmJplgJr62eMoYlpfjSH1UssTVUxDujfG+WFTc1Uc/W8WjkQT7qy9kzLeM7+sNtAZUBLUjj1U688/7nFYtMJJKlmFUCsOiugegaesFB1yKUVfdreYnrkqhGNKzXmiN4cZVaY7vI4SUqEJR6h4Vc+ubM1vF1HOtplBYcl79FndndARfhFFY6k9mFaNszGKzaikZ/bGsVSXSspqxAA+ANaufkxaLn3uwmG7CAwv0wrXGdzNiJwUKmx02OR2MQ52y/kGbupumtdbAPCEzxU4XASlh4aD/V7Rbp4dZsZiWvHvALnyBgMM4WkeyyOwcyMPY81WwS3LdkkhEPrxG/cvXWbDOjxJviwpAVuOCVef1w+w4qWY22/AlaEAaKYyFKIyu3b4j0TVBHRzW6M7QkGcdFmBQIA7magLloEET+WssEJmNckIV+rU4+MKRpObw9qheQrWqiC/sMdtd2oAcHWEmQUOffB0E7DNq3OFBywtp57CLVJKZp7q+QZuzImhoPNIvfb0kiQte4R72e9L/OzyJ0QzT3sQeIEA29Dp7E1TOenJ42IY0jpmB1luDyicRV1P52k5a/JYFg/PfaOy4KyMd0dbezAXrWAgt4jIRfIFmM8sAmYksxeP+AUQ3yio1saaZfRC68+6nx0AaS3+mjyJgXyozog8BNcpKgdh/PX8krnNM/oFNTYFkgo9UIdhOF7kR8MqMXVFp7CY0vE19dKHuj47esrZC8G0EQEA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91208fd6-265b-4f8f-6d97-08db814bd00e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 13:44:41.8336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3O4HUYtoYF6eSGdR850PlEU6t8fm2JU4KdrQHrNnjZSczZTGuStkXaS3LB/0zERaTKI9T4iVmo3PaxaXP5uCFfBx+aSe+kNkVmtfxD6+0u8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100124
X-Proofpoint-GUID: pvNCsBCVKVB7U6W_X_xOb_oA-9YrdI4k
X-Proofpoint-ORIG-GUID: pvNCsBCVKVB7U6W_X_xOb_oA-9YrdI4k
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 09/07/2023 16:10, Avihai Horon wrote:
> On 23/06/2023 0:48, Joao Martins wrote:
>> vfio_get_group() allocates and fills the group/container/space on
>> success which will store the AddressSpace inside the VFIOSpace struct.
>> Use the newly added pci_device_iommu_get_attr() to see if DMA
>> translation is enabled or not. Assume that by default it is enabled.
>>
>> Today, this means only intel-iommu supports it.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   include/hw/vfio/vfio-common.h |  1 +
>>   hw/vfio/pci.c                 | 15 ++++++++++++++-
>>   2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index eed244f25f34..f41860988d6b 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -70,6 +70,7 @@ typedef struct VFIOMigration {
>>
>>   typedef struct VFIOAddressSpace {
>>       AddressSpace *as;
>> +    bool no_dma_translation;
> 
> I find this negation a bit confusing, especially when below local variable is
> "dma_translation" (there is also double negation in next patch).
> Maybe rename to "dma_translation" or "have_dma_translation"?
> 

Good idea -- I can switch to that.

> Thanks.
> 
>>       QLIST_HEAD(, VFIOContainer) containers;
>>       QLIST_ENTRY(VFIOAddressSpace) list;
>>   } VFIOAddressSpace;
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 73874a94de12..8a98e6ffc480 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2900,6 +2900,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>       VFIOPCIDevice *vdev = VFIO_PCI(pdev);
>>       VFIODevice *vbasedev = &vdev->vbasedev;
>>       VFIODevice *vbasedev_iter;
>> +    VFIOAddressSpace *space;
>>       VFIOGroup *group;
>>       char *tmp, *subsys, group_path[PATH_MAX], *group_name;
>>       Error *err = NULL;
>> @@ -2907,7 +2908,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>       struct stat st;
>>       int groupid;
>>       int i, ret;
>> -    bool is_mdev;
>> +    bool is_mdev, dma_translation;
>>       char uuid[UUID_FMT_LEN];
>>       char *name;
>>
>> @@ -2961,6 +2962,18 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>           goto error;
>>       }
>>
>> +    space = group->container->space;
>> +
>> +    /*
>> +     * Support for toggling DMA translation is optional.
>> +     * By default, DMA translation is assumed to be enabled i.e.
>> +     * space::no_dma_translation is 0.
>> +     */
>> +    dma_translation = true;
>> +    pci_device_iommu_get_attr(pdev, IOMMU_ATTR_DMA_TRANSLATION,
>> +                              &dma_translation);
>> +    space->no_dma_translation = !dma_translation;
>> +
>>       QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>>           if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
>>               error_setg(errp, "device is already attached");
>> -- 
>> 2.17.2
>>

