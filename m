Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B75477BB5F0
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:07:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoifQ-0000ZQ-Je; Fri, 06 Oct 2023 07:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qoifF-0000VY-NM
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:06:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qoif0-0006hB-8G
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:06:37 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3969Dwb9032260; Fri, 6 Oct 2023 11:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ovHDMSF8UvOOizXd9oeSjVLM94UvNwbRiw+YKlMIKKc=;
 b=qYCBRdmadAgPR+ap9t3C4BgOd8WKI7kcHOymliM69hm8duoyrI7IjjqfczMShKFSbZkE
 Pofw9IYTIYA12Ds6HV6sMkgRyRBVJXyGbWAoPa6kmRbrbFfuyHhoFHu4/oEvlIvpttVJ
 XzqD6F1iHxTcvlOC31lRnqap99fRGWyeD9ZPqLwXF1lXLZsHog1QSLQ1DvBlUKo9/CUB
 LaZzN2F4lpy8pzqX8fnXyb39EIGH3Xe4AOG7Kc6Lve3pFv8/mFrksEHP+Y+gwI7N99+k
 iHVsLdx1hAk9keYUOZ2YriYKeuIdOZJQEjuxYUbdeE2YCEw38iWjQgSff6NexoTJeYho LA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqe3p56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 11:06:17 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3968oPZk005854; Fri, 6 Oct 2023 11:06:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tea4ahf0k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 11:06:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ma1zhowLA1C0QXCCeunroEySc1Gu+6s052NA3opStkhqE92FB6cIwwBctaXvKXvGFyv3XabVi7la41dscNw+Fad8wMpB/Ivfoqip334CdCA7FDy85F0OxcGQsYabdo2VBS4ZTtxRWSpfrRjNsb7/IjXtO7e/HbMGISC3pTlGCVbdPV55H4BU3VM68EddStsUiFMVIYB/1KnqKX12sPR0jOz+ifQQbuj3svUVc2fvTrQ8MfnlMtc7s0UUqv+lnrQ/YfWetkunquvxtxXNwvwkWf4GLM8YEYyWjJcu2/o6FJytuIgIo3n6zvZX0VRhPVlzGJE1sZQxLhKSwrTSTLuQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovHDMSF8UvOOizXd9oeSjVLM94UvNwbRiw+YKlMIKKc=;
 b=B1AznJtmKqbzPaufP2c1UDVSv5la229GX9JsqdSeN9bUwWX5ylGNGxeAYwaZtw7Eerpl/XRdoJbeqg7KrNu9n92r6eotunfMndbFG0ou4WB+IOzv8gKt8zMjUAjKOz7Wxt6oUUe6vHMgkpx/M5rl2D7EJjZs/RVxbSF3pufl7TQ8+eaWYVhE2pvHssLIRhcByOXgBZ2LYewgQHs1yO7f41seIWhNNtJ006Dxo0otNllqADMlhEemwSV5qvZSXpisP8TyMNuxdh/rw8rk2qchA42HYlcEDMVJT5ue8nzpyKLYjYLcaI9N2QzKBY4WG6M99FfpXoP+vZlKDMEGC0HNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovHDMSF8UvOOizXd9oeSjVLM94UvNwbRiw+YKlMIKKc=;
 b=L5m3JKQ8LGD16H/de76PXgSXNBW52Ege0Zw7YToOKFF2D/Unt9WvsZ7MqzfjXd8dvmlCs1wawRuxwJsiJ1exN3OkKt0uliur+CAbqH1I0sst35cWa37z6opr8vBA7Xlht/MGa7sZtyvzXUGtRmjeGXQInoI5InG3giQbohZ7Z14=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BN0PR10MB5285.namprd10.prod.outlook.com (2603:10b6:408:12e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Fri, 6 Oct
 2023 11:06:13 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d%5]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 11:06:13 +0000
Message-ID: <4f3eccb0-a3ff-4acf-a849-d54ee8d66eaf@oracle.com>
Date: Fri, 6 Oct 2023 12:06:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] hw/pci: Add a pci_setup_iommu_ops() helper
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-2-joao.m.martins@oracle.com>
 <18343982-d554-61b4-fb17-b6955245e9b0@redhat.com>
 <db965f35-e568-44bb-9da4-2c2888928eb8@oracle.com>
 <d09a2778-8097-b6a7-b570-7d36bf29d9d5@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <d09a2778-8097-b6a7-b570-7d36bf29d9d5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0147.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::16) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BN0PR10MB5285:EE_
X-MS-Office365-Filtering-Correlation-Id: e2956b76-7add-46ab-05af-08dbc65c40eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cO4o9APd8C7gIfq2Zjcc66pl0zero5qG8D9vQCbosbH+rXV3rRTEd90umv8HJ5XUh0oCCKZrbmEbeLBs958tSrAHEZdC1ZUfhHT5785/B6fFPsve7J/v+Oym1ZrfVZzLlcXtCkCeY7XAa+E9UCiuN4PlG9W7EbrC2w6+Y828LG1ZVgq9ggnZcLSdmguVthOpGJk48LyfIprFdQFA54S9zynCDXmoHKKl+dAC2kEahL65eMVtntZb/9/F0saR3XC8TUzWar5t3o2VWCGYuhkribC4OZIZvzPT60Ho8TV94/aL2DDEu9cZ981ateiPMLjcvsyYu31XxLH1XUS7FLcPwsDhJMbGcXdMyllCgcaWUGQeQ/dQSgL6FQaolOL2/QZzQIvttikdAr98X8tmV5fE6/H+deDjRn8katUTVU2uqkeZi4gTOE4RqTA62anDi5wZ5J7r/Q9Ie19EpQraW0S3H00QTvkXURXQHcwmx3scOFSGLPB/msIi8sGA9LVnu5DjxCKKvNX6fo7gc4jYSTKD20CO4I4xn5Qm3e990rqD1NiXgTCjfJGc0jvPjYiPuhA8iufUuZRI7TO+/vHL4PsejYbdNLraSRx1fJU9vbUfF5NEEM7bMxqImO4VLFBR3WhVfi4DDDwspVhofp6AZatnuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(53546011)(6506007)(6666004)(478600001)(966005)(6486002)(6512007)(66574015)(83380400001)(2616005)(26005)(2906002)(7416002)(316002)(41300700001)(54906003)(66476007)(66556008)(66946007)(5660300002)(8936002)(4326008)(8676002)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk9sOE5wYW9lTkIrblpvd2NvdGNiNnpzVHhtTHVJVnM0YVBYUGFHSk5CdGdh?=
 =?utf-8?B?dDkxMHdDNmptR1RyNytXbG55Q0JwcG5GTmhSYVNRdXlRamliV1VQVVZWY0hX?=
 =?utf-8?B?YXQvYzJhTzAxLzNJQzNiZjlpL1NQdDVRSkdKemtaZ2xLa0lsRXlBT1dRc3dN?=
 =?utf-8?B?d2xMY21vMzg0SkNVUnlHcGNjc0RIaDVwNG5KTitiVG9odW1HcGdtb1BRY2pX?=
 =?utf-8?B?UEZVZW5kMDZuMUVBVHdIc2YvUk5GcVEwdUVybGdsOTJLR0lsS0MyNXIrUVp2?=
 =?utf-8?B?VHZZY01GT3EzT1R1bmgwS3ozNDdYZ1pSUHBndGlRQ1lZVUhkV2l0VCtuYU00?=
 =?utf-8?B?RDBHTVZYNVMwUjUwb3FIRXVRcUNmSWJYd1I3UHlWd0RTN3M3Y0hMMllJSkNa?=
 =?utf-8?B?UEY1S0dtUWgwYzM2a1RhQXZMc1RkY05xQWdBbE5ENS9KM2ZhM21NdlkxSFlP?=
 =?utf-8?B?ZTZnRS9ab2t6VS9lMm9ZSHhMMWovNktyTG1ueHVsbmJrWUp4TlM2NDUzT2xt?=
 =?utf-8?B?TEtCdG9IcndId0tYQ1drTTBrQ1gwbVZ6djNEcXUzWnVXdVZHM09LOWhjVmZ4?=
 =?utf-8?B?ZXY0emRQY2FCK2EvREhJN05PcDNNdG5NUWVLa0FiSnlvRWN3Y3ZRb1J1WjFP?=
 =?utf-8?B?aUlGUFFFamwyLzRFTVZ3VmJuOEQ1ajNhWGNqZ2RMUUhlNlFheFErdjhBQTV0?=
 =?utf-8?B?S0dLNEorOWxpZHdqaDQxYjhHbDRMYllOSStETm5uZDRRUkVVTnd5Wit1LzBQ?=
 =?utf-8?B?TE03Wjk5M28zWmprTWJJSHVXM05BY3JhS0d5UEF6QTNzamFZZWxwR2g5WCth?=
 =?utf-8?B?ZUh3SFpkNEc4ZzFFd0trRk1saXlRWXZyYTBkU2xUNjNBdEFUNDVSRDJ6VE9R?=
 =?utf-8?B?TjNmaE1hMnh0MkYvd2U1VWhzTmVLaWRsR0UvZ1ZOSEZjdmcxNUFkelhPVHQx?=
 =?utf-8?B?aVFSaU9ta3RTSnRhTEMvbTlhSlBvd2VDV2RPb2RZd2thcDNsRVVXNXQxeTds?=
 =?utf-8?B?UHltYXZFOWNMaTBra1Z3TEZrWUlFQmlSanMrN3dRWFFTa1N5WmhCM256WEtG?=
 =?utf-8?B?QlRENkFlUVpTU3JLS3RCWVUvbkxvcGdQcTkvaVlhTGp3NG9wV2N0TEZxSDJ5?=
 =?utf-8?B?TFNLcHQ4cE1JeVE5UDY4azZSM1RPZHl2aVgzSjdBYUFLZ1dMRFpwQnBmWFRo?=
 =?utf-8?B?cVZLMFdiaklLOHFJc0VhRDZXamRhNGdEcGFrdG1WWmd3cGpIcTVZNS9SM0pz?=
 =?utf-8?B?NEVRMldDbDlNRVFZaWI0OWVBanNneWxPbDBUcDQ3STZyNldWU29OUHl5cERj?=
 =?utf-8?B?NFpmZFRDREVUWWxTeGRhRE10enh6NzJMd1ZCOFBGa3JLTXExZm5UVFVWS3Yv?=
 =?utf-8?B?SXZuL3hmd3dqSVhFaGk5aHUwQm14Z3ZMTmdVbzZzL1Y4b0pUSWFiL3A5WDJa?=
 =?utf-8?B?VUlnTzhGcXNTbXBURzRXS3pGdEI0RmRIUFp2RWRYUDFCNThKc2JWS25Nd1Qv?=
 =?utf-8?B?SEMwWnNVV05veHFMTncweG15OHlEcU05ZFJOOFNpdWFBS25XL1V0QVFnTGQ3?=
 =?utf-8?B?djgvbTNYSHZheVBGUCtweHRBN3B4WDZXQ0NObkFZU2F1YnhiQ0FIRUxHeVlF?=
 =?utf-8?B?Y0xzbVpWWE9ac3ZHZU80R3lIWVJFTUViVElScCtkdi9Gd0NZamVNTi9NQmdF?=
 =?utf-8?B?d3dSdFJMUThLd2gyZCtQcVpXcTZuajBCUGRpU3BBV01WeUUrS0VGQUpTWGtj?=
 =?utf-8?B?MklwQVhDVU11QWVxck94ZnMxdG4zbFd1TWkxUjZHdkxXeUp6QWVhdTlybkxo?=
 =?utf-8?B?L0M4NUF6R2h4a2hRRm0vdzVOSzlhNzl6MmhJaXNVdGo5eUR0Y05tT0NneU93?=
 =?utf-8?B?cS9HUEdCbVdqTTBLck4zS1BPUXBvQTR5d2RuT3JyYUpHRFVKL1JnUzd4am1B?=
 =?utf-8?B?Q3JBaGZvUVhKTFFjVG5KcDM1blVzTkx5QkdQcTJnM1FPb3IzZkl0cjYvR1hT?=
 =?utf-8?B?aXQ0Y1NLRXNhb2ZmU2NKZVc3UnA2dFhrQmlwNU5CSjBWd3F3NFEzclI0TUFz?=
 =?utf-8?B?ZmFiZTZ2U1VhZ1JvOUdHUkk5cFJNY2pSMVJIR3U3STNyN3BHUDRkK1BTNFd2?=
 =?utf-8?B?WVpvZ0RHQ244Ui93UlRVM041c2xtUUdLMmVQU1FzZ2xLNXBxMWRDM2c1NTVD?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ka5HgZIQSqJAbLRez+XEGqickg7sLLgR1cXJNEIYDXNMPv0OpYGJ5xh1bGfqiw614JUJph+S91i2UH6k/B3MmUpIis2TaD9SkKZvnPBdJRLIBrTwQdPjRb47hn5xRQaxx9qcoT4EVMGY4ILnasqzf/15kbGaa4Nb+fb+7v/j5jmK9Z5Po2wpbGBC3PToyBWibbT3nMFb+kWfxj5F2E+BEmKo4QmlVyOwCkLPJ1MQ2dPmP+H/HUBS25gCVLwdip8Wx/FXluZpLFj+XNmiHLncc0nwlUlbtQ2OjYDyN0j44BQc32dr7uX6zzX0tG+j00c0MHhUqOamq/wv1LTVQ5oXpWrScPVyNW8ydZ5s9wNj8Zyi9A9BtOrNJP+XpH92ylCY57BvrNomQNfh/Gni1TJtdzTDX8reE2+R1BKiJwHbGBM1h+TfXk9/mXSQ1rkf+QJxbUpUGL4fSIap6B4Nu3Buik0RbkyCuvyh30RvvPMQoZsULwu+tUyt/mK9XKdNDH1CH8hYbeJQwXyEE3ckIzXfuseJTUxwLWunjy8To5E4+9HVxE16el24p2RxGkahVKi2WueN8nTKVu2skxApI8vcIBbJiSmaYXbGCnpg5Qclov3/mTOK3wv5XwYXblUDXhEK4ECAs8gIhp6DKr5IHhAScHcTOa8/EGZgXMhZEuqEpD6i4rkda5sJwQtpN/yngtU6dRrEib96p7OZhKkRn2c1e1r0Rz3d6aZmlbMylS733Pa2Ka3dme5ndPlBHP7P8KGH27qwt/A2936cxX7yXxXWEw7yhXI8DRuRoCETuBZ/uLRjQnUwlzpqd36o9i2l294+fnqQbDpjexJhr0+TYyUbCThMfZIpLvdr3gcnXG0C+rJ03PDOLp8zRpno0StOW0pfe6KC5SAoFIFaZLohUPbod4WG8Ng/5hQ3o/gSpKHJcVY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2956b76-7add-46ab-05af-08dbc65c40eb
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 11:06:13.4637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNbzCHrG0D8QttLkWnH0LcWWEe+JNybSC2yxfW+oz+F/UGao2kB9crFSd/NvI7i3J3b288bjCbFJsa0Uw2OWXaqSbcdnJX1E/EmMqZdMZbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_08,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060081
X-Proofpoint-GUID: 4TXEr0vIP_86UCUrQSLmHQVIGgayVPhc
X-Proofpoint-ORIG-GUID: 4TXEr0vIP_86UCUrQSLmHQVIGgayVPhc
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 06/10/2023 09:50, Cédric Le Goater wrote:
> On 10/6/23 10:38, Joao Martins wrote:
>> On 02/10/2023 16:12, Cédric Le Goater wrote:
>>> Hello Joao,
>>>
>>> On 6/22/23 23:48, Joao Martins wrote:
>>>> From: Yi Liu <yi.l.liu@intel.com>
>>>>
>>>> Add a pci_setup_iommu_ops() that uses a newly added structure
>>>> (PCIIOMMUOps) instead of using PCIIOMMUFunc. The old pci_setup_iommu()
>>>> that uses PCIIOMMUFunc is still kept for other IOMMUs to get an
>>>> an address space for a PCI device in vendor specific way.
>>>>
>>>> In preparation to expand to supplying vIOMMU attributes, add a
>>>> alternate helper pci_setup_iommu_ops() to setup the PCI device IOMMU.
>>>> For now the PCIIOMMUOps just defines the address_space, but it will
>>>> be extended to have another callback.
>>>>
>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>> [joao: Massage commit message and subject, and make it a complementary
>>>> rather than changing every single consumer of pci_setup_iommu()]
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> ---
>>>> v1: https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/
>>>> ---
>>>>    include/hw/pci/pci.h     |  7 +++++++
>>>>    include/hw/pci/pci_bus.h |  1 +
>>>>    hw/pci/pci.c             | 26 +++++++++++++++++++++++---
>>>>    3 files changed, 31 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>>> index e6d0574a2999..f59aef5a329a 100644
>>>> --- a/include/hw/pci/pci.h
>>>> +++ b/include/hw/pci/pci.h
>>>> @@ -368,6 +368,13 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *,
>>>> int);
>>>>    AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>>>>    void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
>>>>    +typedef struct PCIIOMMUOps PCIIOMMUOps;
>>>> +struct PCIIOMMUOps {
>>>> +    AddressSpace * (*get_address_space)(PCIBus *bus,
>>>> +                                void *opaque, int32_t devfn);
>>>> +};
>>>> +void pci_setup_iommu_ops(PCIBus *bus, const PCIIOMMUOps *iommu_ops, void
>>>> *opaque);
>>>> +
>>>
>>> I think you should first convert all PHBs to PCIIOMMUOps to avoid all the
>>> tests as below and adapt pci_setup_iommu_ops() with the new parameter.
>>>
>>
>> OK, that's Yi's original patch:
>>
>> https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/
>>
>> I went with this one is that 1) it might take eons to get every single IOMMU
>> maintainer ack; and 2) it would allow each IOMMU to move at its own speed
>> specially as I can't test most of the other ones. essentially iterative, rather
>> than invasive change? Does that make sense?
> 
> I think it is ok to make global changes to replace a function by a struct
> of ops. This is not major (unless the extra indirection has a major perf
> impact on some platforms). 

It should be a mechanical change. As the pci_setup_iommu_ops() should be
functionally equivalent to pci_setup_iommu() [...]

> Getting acks from everyone will be difficult
> since some PHBs are orphans.

[...] This is what gets me a bit hesitant

