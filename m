Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CC479857E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 12:12:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYSb-0006fa-Rh; Fri, 08 Sep 2023 06:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeYSZ-0006fS-Je
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:11:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeYSW-0001O6-GS
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:11:31 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3889j0A3012404; Fri, 8 Sep 2023 10:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=i9bj6qVNwFhKLlwgtfDXk/ftt86V7bp9L6iLLYZ3d1o=;
 b=Tk4UrZ7RF/31Gwfky0Go3KrJsjVTBNnEUf8DcxnNa864QL+Rh+2E0HiTZOudjj9s+Bv/
 QZRMFrW1Al/XghsILlJvGEn4bcdeYDzzA3x9e1BvUrHRmiMGikTWjGn+AUaoxXimzVf8
 dI+2iJeeQIO59gMkYBTJaWIxSMGs8wHyQlupKwNMVOFVZlcovEEUnO8QYOmNCKIy+mMf
 AoqvDtqs3NI/+Auh4sAkuB/LCXAcolvV43+5yzI3yBbrb8lGk4wamVMYghgGlhrCF5xr
 3FWCzWhKh6Y0Jv9VHlPCgMPGZICC6Dk/T6WTl4C+JWrBb7kYknjg6RDSv6RtRJ1uvz39 8A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t018jg1ma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 10:11:15 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3888DWtF039892; Fri, 8 Sep 2023 10:11:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3suug8y52c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 10:11:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWlQ0WnXW9b7Rvf1akA8mye5/04/U+ial8T4Raullt3/cCSLdh4zl+YgAtNF766l5ueJo2fznqvlFw1B/e79UW2BQe9sROlgglv31LOdEyvYeJuNo/V+ZZjG1GV9FBF4yC/ID7jRsg9kvTKuGH0i5QSULPsWNb9p8mCXKJUEDXnumGEyp83fnMG0+J8+5ESi46Uc4GXVXjmc2suAR8gCVO7cQ3EBHUWxnaoIKWUDW8FTJSEPHMJWYQqAHz0AvwayeV40Q3EDPy964Pcx8DlYfQwAQx7LtkfL1uE/dXiytbs75+RZ0oja6IlfaXmXtTifztH/hCZwlW1xIwrhCGMRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9bj6qVNwFhKLlwgtfDXk/ftt86V7bp9L6iLLYZ3d1o=;
 b=i/Oor3rF8wUovhmhwBDaaazNOEOb6ZJvA8NLV+mjRcw4w1FwSjNtWt+edu8blIAqPbvElbdoOKAwwULnmvzNeDI6ORgWpNHAeejKn05ZH+9jRAYN0UQCukiD6jH2IGAAs+sldLvOmX/FfuZOQvxkdoPzsXLih2ocLZOZLriKxQ3cP2JXc8LmiYhLmfSQp3XYL7sZm/cQxX4iOyz/ZKPXcNt5OIt2cXLdTUVNoNmb8ALwR0eFcbzY/SK5XMzP0aKUWrm1APG/GzBsSTLtl/YrNdVIoc68/3m5zYA7XZu+vCBz7ZDW7n4W4/in8ycMeFw0XOKXIVz2JWemzdT2yVYj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9bj6qVNwFhKLlwgtfDXk/ftt86V7bp9L6iLLYZ3d1o=;
 b=aWLJBHahL0GR977phO+tJblWAjk3DyXYe1cMd+j5jcZo9lz8MaSFTTPceOvuWTeKSMQ1Kj0fCEE+1J3C2uP+Bd5alKtZGIvmDO+Tuyc9mXUYA/W/L/9G6CD/nTkZV065pqJyQ+PQVeStQCV9z7GenTbgn5fEWKDDP+YLh8GyodA=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BLAPR10MB4900.namprd10.prod.outlook.com (2603:10b6:208:30c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 10:11:12 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 10:11:12 +0000
Message-ID: <7b60c81f-8f6b-8835-b668-dc58bbfbe140@oracle.com>
Date: Fri, 8 Sep 2023 11:11:04 +0100
Subject: Re: [PATCH v4 06/15] intel-iommu: Implement get_attr() method
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-7-joao.m.martins@oracle.com>
 <e6e27cb1-88c4-5b1a-dce4-b4f31ecb68c1@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <e6e27cb1-88c4-5b1a-dce4-b4f31ecb68c1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0103.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::44) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BLAPR10MB4900:EE_
X-MS-Office365-Filtering-Correlation-Id: cf965b0c-160a-4582-8680-08dbb053ed95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kt8lFWfavAld+Llqbid4gVChZKaD3zNI+/NYJ2InFk2bPQT320m8XimRbWes+Ks/FgToP3B+b9TPrBZt/2+2kn+6fz0pi/OK5kVcmW0JMO6U74R2ey4Ar7N+zJGjg7koVpnHJx8K+dnmqY7xtGEOdOWXixDu3BJ+u35dL2Nvy/QCsHCzdH7uBmM6Xw0MHNTiQf1Orab6TIPOkhaZXte9jjKjIStjNA3wmCvN0NhYRVkL0tkWP6f60pKoNc7A+LHk2dn4ElE/Apqf76R54gu2m5Ys5s3lOj6+MZw4VtzswZFxTBzV6T7u4kfRNJNkpLpyA9arSS9Kmiu8pxbQilmcDcgmr37y3UogPNEjOirKmpKwXyOF1+ETx3kDTal8xNYcyZV3vMX4WDYirYAVrkRMS2UC70M7iNfZWxRuErSQ9PJlH9GrqznXtclgEEgKbeRDdsVG6p0jdgoQ7ez1DxfzTEykDNVxyv6QLHOlOo31QWuhkfocHcZ/J8He7YYVnQuaDQrSe+HlVi2tqMIH+l1dAeI0bSegjcy4fBcvwdbeKxajlEhyb0/P8TgvmKO14kvm0YtBaSqn5TfDFqQuUK6I+rKGfIHvwLztb6DdPkRcRunc28mBPSg/WiWmTr1ChKMP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199024)(1800799009)(186009)(6486002)(6666004)(6506007)(53546011)(6512007)(478600001)(41300700001)(2616005)(26005)(7416002)(2906002)(66946007)(66476007)(316002)(54906003)(66556008)(4326008)(5660300002)(8936002)(8676002)(86362001)(31696002)(36756003)(38100700002)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bitzSVd2VHVpeTR3TmE4Z3YzRHdwMStpTWxRYmpDTUM0MDlmVU9jYTJTVUwx?=
 =?utf-8?B?NyszY1A3MUg3eEhSRytVLzVOOGdOL0dDeW92YUd6SzBWQmFpYnBLV3A1Mldz?=
 =?utf-8?B?cTE4VXRjNmY2TkttVmQ4R2pId3VFbWIxUVJ1eEZWc0o3TTVMTGtJQnJOeXBh?=
 =?utf-8?B?RlU2bDVZYmxwOURlUWQwOE8xSEFiWURDTGF3aW5oMUorRG9TL0k0YjBxdnQy?=
 =?utf-8?B?eWszTE43dXdla0tXalVFVHF2YTE3cHVkQnZOR2pydzIwQ3R3TlkweFlOaHZi?=
 =?utf-8?B?NTEwQzkwdXB2dFU1VzN6Y2JBbSszVHZQYmZIQzRqVC9GeGNLTHBzUm9PZnQ0?=
 =?utf-8?B?ZWd5ZDQzeGxVVVJ0Ulg1ZHg4L1NlZHByNURSSHdUWFVIRlhnVWxLWDJZbzVn?=
 =?utf-8?B?b3RiWnVYVGRmdkpIMkNDbEhRRkY0ejBZbGJUNGVFbzg3SGVobDBValdiKzZu?=
 =?utf-8?B?MjAxbG1qV09INFgyQVhvMGxUakVFdjlYYXRvSjlYUjFUT1pGREdqdVBMNWJY?=
 =?utf-8?B?ZzUwbjdkZkF0dStqZlUrZVdrZkcyWUhpTnZCOXJQSE9LRFlMQzcxUm9sVVpn?=
 =?utf-8?B?RFl6cE4ybitkbWs1VXl2N0pMWDRrRHQ3NnFZVW1NUi8wTzViVm1nVDJBbnkv?=
 =?utf-8?B?Z1VUZ05yMy9xNUtqQnUvU0hMQkFkL1ZFQStZUzJReEhqUUtPY2VkZ2dsWGI5?=
 =?utf-8?B?VU9GdWlzdGZzR3o3ZlczMDVMT2NwM2pWT0tocFAxckJZdVQwV1ViRE9GYjQv?=
 =?utf-8?B?bWxVNWwzYk9mR1U0NUlBcDY2eUFWUWxUV3VQaXY5djVqNStVNkJqVE1GaVRx?=
 =?utf-8?B?eEthSDQrb1NjRkdXckt2ditwZG56Z1BPVHcwTzhmQjRCQVVKQnROKzRpUllK?=
 =?utf-8?B?Vjk4OFpzRm16bmNkclFHbkFYcVVPQ09YRTJpcDJRQnIvM0JFUXVMVVFVOTRR?=
 =?utf-8?B?N3RNMGt0Q0RuWElDaEp6UWpDd3VtdGpyVmNUc0VHVWhpSXFDaE15QVVFRDJk?=
 =?utf-8?B?Q2gzQjVwdmNobmJOUS9sTUpmcUhjcm1jWU9LYUNjcFEvS21SbTVZMHlzVURU?=
 =?utf-8?B?TlFLNDFDRW93MDBsdGZTYTBiY2l0Ump0dG9yajhsU1RRSVRsSlhwN0tHS2tz?=
 =?utf-8?B?WVBxb2h2RU80YWRzOE5TMDY3SGRLb3hzZHlwNnUxd21WeUFJSzQxaGRSTjJH?=
 =?utf-8?B?T0d3M0oyUGpnVTFkaHR1NXJVNENSbWFNcXozYUZXNzhKZW90aTdDZHkvWTFX?=
 =?utf-8?B?UExvWjErWWJLNDYxSGY1bTkxK3ZLVTBrMGVnQlBrSG1rV3ZUT1J4by9EYTVL?=
 =?utf-8?B?eW1IbXN0SWxqTjEvTXBmR0xJWlA3QVVkdjlLQ0krYk1lWVZtRG5CbHBJdk1U?=
 =?utf-8?B?SHpXNEdoek1XVE5CYTByM1BJSTE5bkszZE4yVXVoL0Q4NnE5R3ZpcFpva0pB?=
 =?utf-8?B?TDc5Y3pnQjZwNVR3K2Q1NnQzcXYxSitlQ1RLZXU1dU5EMjZUQmdkby9CcTVV?=
 =?utf-8?B?V1FCYWNiTjBrVGtFOHAyVEZnSm9zYVFhQTU2YjNTbHcxSXRPTjJCMEpReC9t?=
 =?utf-8?B?d2dhNGloazZxKzMzQjhtaDNaVmhyeDgwODd4NWdMMzdFQkNHYW4wR3lJeFdl?=
 =?utf-8?B?TVZMbTBQMzVpODl3RDJsYXRIQUhDeUNyeFF6K1pDUUdocVlEWGVBWmFZZ2dQ?=
 =?utf-8?B?eE4renVwUnE2YTJQUUJiVndhN2lKU3I0UjJjdVNMeFJNclozZGtvUmhBeTZt?=
 =?utf-8?B?YkZBamw0WTJvZjZUVm5zcWxFWnM2QTIxNCtyVnFFamZFS3MwVEoxRGFLR0Nh?=
 =?utf-8?B?NU1GcWkyc1pUU2JtenhPazBmS2tER05kMDEwZDduVUhtd1VmbnJKTWRHbGRM?=
 =?utf-8?B?eUFxRVQwUUMwRFBaUDJhUWhoT3JvVGhuRHg0VTBRdjJyWTkrdEpDR2poQTg4?=
 =?utf-8?B?amdLRFA1NWRzVzhLdkRESHpYTllIQ0RTRVNyTUFabGh3TnI1dGVyNWJQOFZj?=
 =?utf-8?B?R09UYzZ0VGJxRGE2TDg2ejJIbWZwZ05Bd1lzMjNocXhHYUlnQ1BwZTJvcXNU?=
 =?utf-8?B?MEtBT0orbzJUOGg1bEQ3R2J5REVRSWxWcWtjOElYdlhjYUM0VUNlb0ttaXNa?=
 =?utf-8?B?ZDJtWVFGcDBQbEVYMUR3QzNVNHRVNVR0SDA5NXF6ajlNd2pCVFdwUVFzUTVM?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AnnI9XivPg7vXioApU2zL2P4lBjboupIiEqWx5uWzIymHmFOL+PLGzCS7EvKgAMTdbIHmMiv/6l+d8wcywza+L3xpsMx8oeCiQTU2JkHvjGEQ3RW3ivhpr2cPzGnpD5/E9jNqSufVedfRUt+8lW1DLLJxD4V8Ai55i1XI0UvdgVIXfgn2SFzsNKbEw4S/IA6SWHHMBulsWVGrOWdRMgmAb2Y19AT+UCHTAUeqp0JKCMbuRGpsH9SIKJeRnRqpE6jQ9vva76jW59ZHfzvhSybQ3t6bjISxV4GFqKJsdfwp+8+0BgqRguyISJUX4y+h8WB61cXg4ImhajKsPmvlfQCNaqkPCsIUSSnHW1l3mMHbMqIhzEOh3ZcJXz7CWefW+sL+DOvOrYp8Jx+3ohM2+tk96Vd8mDSqeQp0o+lx2Ty3dCg5QqooCTqfa9s6Ta1QJTy0vY4RTCqcaC3927DKCeoGqcu0mXfFMyJD7cowaOwefIjWGb0aEmlqjYZhSrtd9T8NjN701XiMijIufnIA7KA6216WxaIzVQsdziySHTtbMSjZ2r9wc2svWvtpF9IWlotiVExhGP7efC0JVTLgxdNJSN01XiCvTqly7DGuB6k3uuTKAIm1Yj8W6Yn59sFGqllESLb0gxKp88N2zLP5Y+DUM7eOjf2x+vzXHVVYqJChHUfsq2wdAhh8bTHSyN7LRq1qQ+K8jnrdl0xIaqdlAHal20vCvlbkkg/yt2gtbMsflXSr5tKBy5kj9ubKf9TK7SgabxYXkK/VlruyRO+l0GSakAKp4N3xflJORt09H6IhDjm63mkQACS+UXSSdWWWTdm8YctSCEsTwk0jESAfCcEM7f8XHyPPx/t45S+Kg7WPg6rt8pe+TsflFvl3RHwTYWG/8IxtkOS0BwrzXOCin89zlFITXu3/ghvLv68hMsytm4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf965b0c-160a-4582-8680-08dbb053ed95
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 10:11:12.0518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bW3B1gb5zx97Q2enPnWCSiF66SjDnjLITpsHW345C05NbY2un3SUBPJGYoVo91+Ct0T2cTiYppEm6hAZAiaBDGhJScVxRQoF0AeVljT5x1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080093
X-Proofpoint-ORIG-GUID: PBQFwYYYIWoqjQAHq2Rvzqr0At5kepOf
X-Proofpoint-GUID: PBQFwYYYIWoqjQAHq2Rvzqr0At5kepOf
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 08/09/2023 07:23, Duan, Zhenzhong wrote:
> 
> On 6/23/2023 5:48 AM, Joao Martins wrote:
>> Implement IOMMU MR get_attr() method and use the dma_translation
>> property to report the IOMMU_ATTR_DMA_TRANSLATION attribute.
>> Additionally add the necessary get_iommu_attr into the PCIIOMMUOps to
>> support pci_device_iommu_get_attr().
>>
>> The callback in there acts as a IOMMU-specific address space walker
>> which will call get_attr in the IOMMUMemoryRegion backing the device to
>> fetch the desired attribute.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   hw/i386/intel_iommu.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 1606d1b952d0..ed2a46e008df 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -3861,6 +3861,29 @@ static void vtd_iommu_replay(IOMMUMemoryRegion
>> *iommu_mr, IOMMUNotifier *n)
>>       return;
>>   }
>>   +static int vtd_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
>> +                              enum IOMMUMemoryRegionAttr attr, void *data)
>> +{
>> +    VTDAddressSpace *vtd_as = container_of(iommu_mr, VTDAddressSpace, iommu);
>> +    IntelIOMMUState *s = vtd_as->iommu_state;
>> +    int ret = 0;
>> +
>> +    switch (attr) {
>> +    case IOMMU_ATTR_DMA_TRANSLATION:
>> +    {
>> +        bool *enabled = (bool *)(uintptr_t) data;
>> +
>> +        *enabled = s->dma_translation;
>> +        break;
>> +    }
>> +    default:
>> +        ret = -EINVAL;
>> +        break;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   /* Do the initialization. It will also be called when reset, so pay
>>    * attention when adding new initialization stuff.
>>    */
>> @@ -4032,8 +4055,24 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus,
>> void *opaque, int devfn)
>>       return &vtd_as->as;
>>   }
>>   +static int vtd_get_iommu_attr(PCIBus *bus, void *opaque, int32_t devfn,
>> +                              enum IOMMUMemoryRegionAttr attr, void *data)
>> +{
>> +    IntelIOMMUState *s = opaque;
>> +    VTDAddressSpace *vtd_as;
>> +
>> +    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
>> +
>> +    vtd_as = vtd_find_add_as(s, bus, devfn, PCI_NO_PASID);
>> +    if (!vtd_as)
>> +    return -EINVAL;
>> +
>> +    return memory_region_iommu_get_attr(&vtd_as->iommu, attr, data);
>> +}
>> +
>>   static PCIIOMMUOps vtd_iommu_ops = {
>>       .get_address_space = vtd_host_dma_iommu,
>> +    .get_iommu_attr = vtd_get_iommu_attr,
>>   };
>>     static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>> @@ -4197,6 +4236,7 @@ static void
>> vtd_iommu_memory_region_class_init(ObjectClass *klass,
>>       imrc->translate = vtd_iommu_translate;
>>       imrc->notify_flag_changed = vtd_iommu_notify_flag_changed;
>>       imrc->replay = vtd_iommu_replay;
>> +    imrc->get_attr = vtd_iommu_get_attr;
> 
> Do we have other user of imrc->get_attr? If not, what about squashing
> 
> vtd_iommu_get_attr into vtd_get_iommu_attr and have imrc->get_attr removed?
> 

There's an user, and that's VFIO, but it's later in the series. It felt more
natural for bisection to do things this way.

