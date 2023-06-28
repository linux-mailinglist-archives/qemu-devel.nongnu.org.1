Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7277414BF
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:19:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEWvc-0007s6-NA; Wed, 28 Jun 2023 11:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEWvY-0007qO-AR
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:17:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEWvV-0000Ix-Qj
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:17:51 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35SBT3h0001805; Wed, 28 Jun 2023 15:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CV2cPk1Aojs3W10QGGDvw/NsuPOdMahjKVVQnf6xZcc=;
 b=A7/s0sz47vXfLdW3N0pcwoCB5CykeP47xLzmpWgHQH7BffoSkkN6ZIAC+Pr6+HSFgkWB
 mYZ0Bz8zo2uswMZKaFWD2oXrLAdVTRsilZ8zH9GGvDjdXD+Gz19Kj7oQoT4K4+ks3xNJ
 8uQQMXMOTiqJ6TkOhMtTrnmR5nxLvY1cwqnL/sAeYdfqQTDfe9V4KefVnCfMJ7ImP9Yc
 eizUnpZVVHhF/a5++s07QZYgzzQlI8Vcu/skLJj2ClN9FcYentSOpGPxA3VVogtvrf6a
 UsKQG8SfQtWAYtzWwyzW+OBbgqi+2aWXa5M9gu4cOhDgjYRkPR5OWHqLvw44V+MRmRzM NA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdfrxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Jun 2023 15:17:28 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35SEk4Aj003957; Wed, 28 Jun 2023 15:17:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpxc5hc2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Jun 2023 15:17:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciM3DsPqEDopZspPP+hyIqCr2I0/gNf+byKp+f8xQAok9eFCgUhzJQTWtGmPfmiYpRfAQJjk6rGLaPJfbJr9y5NwBbuGGEjNxbOF4BvJ+4F+ujurxw562sMQ6rDmOZsoo+8pkUWVHCvyn49OpQT/h1eqtI3owKl0cwSdRS7/edyTHcZiuqNYwpDM9zpcqM/v2UUvs0BOHEKZYvLP/yHFjpjyzTwa1ztEjTbqRI37ae11raf/hh2NsF4JkrTDtLNd6SlNYm0RzbolCkdzc4O0DY9qsKNogOUz2JJZbqCtvz7L+34afZv4xza3LRuqMn7Jhg7O6GIbqrBxJ8Wx5vgPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CV2cPk1Aojs3W10QGGDvw/NsuPOdMahjKVVQnf6xZcc=;
 b=objmMyWVUCOxpUiHo6HECgh6aDVsJ055gwBzP7zOLU2Yy/9bgtPKmOgvwfG8nnbFZ7C/9Yl8erHfBLJ/0sG66FxVLFCep0I2ZGOePljDXBFOf7AupUvOp99AtYZTUEs9kl1uDtfmVayZlSmUxGmKztCxqRh4Gj52L+GwRGO/BiTfgqZfrHGgiJeKNl33BWUplkhorZE5jVDiwDobxVxdTBncM6Thw5BHAI3Ryy76DMfFt3FXGdv8Tdwe0+3qGwSp4CST82ABbKmKX/nLBPoutpUu3ibzeN4xR3pu0nAzGmk2gKyPIeSxhtXZJRmZ2FdCUfLiZFoHBaGZz0l2TwAa+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV2cPk1Aojs3W10QGGDvw/NsuPOdMahjKVVQnf6xZcc=;
 b=uCY4pgPTqa4aeI3235JpON3Jqv/FQZyq+9KhjdtM2Iqf665jWLPWrmiu2qWlnPBEo/YboJdVSsYP4RYAdtKQTSvBp9kRHeuB3Q5D4QRY1sISgTHet1gXz2S+OxyRPP+IZfNRde6RoA7p19v6XaGpj7v6jSQ182dlMzAJiIOqEcs=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by IA0PR10MB6842.namprd10.prod.outlook.com (2603:10b6:208:436::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 15:17:24 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 15:17:24 +0000
Message-ID: <853822bc-aa37-bb49-23ca-42cf73cd30f1@oracle.com>
Date: Wed, 28 Jun 2023 16:17:17 +0100
Subject: Re: [PATCH v2 2/2] vfio/migration: Make VFIO migration
 non-experimental
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>
References: <20230628073112.7958-1-avihaih@nvidia.com>
 <20230628073112.7958-3-avihaih@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230628073112.7958-3-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0103.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::18) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|IA0PR10MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aed1634-70ab-44ad-5cfb-08db77eac68d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8aREQlk8rBpgsdltufqyTYQLM3VjHZsviud5WMkfwPpXINSlZRohFLbPrM0aGvJHmruDIGoTg/Ne2YiuUEWxJZQZU5w1TpEx5dGqhqkyqWKRDf1IORldyjvdyRvVgOxER5hQ5U5ipcpWsQNGbTnulKmqSZLXPuF6nBGEYuB31eQRORrFHyX1Rml+djJ4hY77BKv89iazN40InagU/ns4rqvJgFBrCKmxfxcd7CcXtoQQ1kvQSszwa9HgoJVyOajhIBh83iLhxvDXCrUY31dy6IxKcvPwhzR+6aBlFFBxsEEi6UAN7eTh5dcJ0LtkV1bXna+zyJq6akTjWOAkr3WxFT4DVM/XJCudKxdZEvUdi6RYSIsNqVMPovaJcu93w8C2DlcYE0nreHnDnleDA/5RAZ8Y5YfTmUqtblDz+55BgtcN77aCQj/GtlCVMqqJKdGBN7gL7GszZDW+Egg1iQb/B+fjNGkBwACHT+ZHsiUcMv+oJlR7gxZbvOpiFigB/DBevdmkKbfDHtqkMuApGF61wy3UdEwzvR9s0iePKRorBJrkQZop/DEHXob12egxyl3D1xzkf5XBeWTBEaw0WaDOWUuG9d4HJ2CTpZE3APCpoHOICqX9iirSKBxLYC2+DmY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199021)(66476007)(5660300002)(26005)(2906002)(186003)(38100700002)(2616005)(6506007)(83380400001)(6512007)(53546011)(41300700001)(66946007)(66556008)(8936002)(7416002)(36756003)(6666004)(31696002)(6486002)(8676002)(54906003)(86362001)(4326008)(478600001)(316002)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGhtR25PelJ5bEk3b3BSU2xnbFozSEwrVk5TOFlOaXRIbEptY1MyS1V1STlo?=
 =?utf-8?B?RERuNHgyM0hHN2FVdnl2VXRvL2wyNU9mcUVzVUgvYzNZNEtBalBaZ2x3RHdG?=
 =?utf-8?B?SDloaFRJc0ZDa3VZcjhhU3g3NlV0R3Jod3pxRFJhc095QzNIM0J5Kzd6R0dp?=
 =?utf-8?B?aWxPU0dNYy9EUjhhOFYxVW9KS2taOEJ3NytNY3RNVmNyQ1lHc0o3aHNMc2c2?=
 =?utf-8?B?UzllclAzU3NMN0JHNGtBS3BoRGRaNUtQWmFDb2EySGoxOHFVNmtEV1c2cGJH?=
 =?utf-8?B?Qy9YVG04T093QXFCTi9lQjVkd0pvWjREU3F6L2luUVY0RTV4RFBVQ3VtL25q?=
 =?utf-8?B?U3dwZ3E5cDZnS09GL1lMSWx5aDl2Q1VCNmhMaEpYT0lsdUNuMlVzS1R5cHJ2?=
 =?utf-8?B?d3RaREhESjRqbmQ1NkxIRWlCTGtvQURIRklmTm5yQWorQWYyZGRDWWpVUGI4?=
 =?utf-8?B?aGdLWFNwS21UMks1U2lMZXI2TGlJSmx6bkYxQjhrMnA4NmVRZjRSWnI4andB?=
 =?utf-8?B?TXpmNFdtb1VSaGZKc2JwOTFGVlpJRU9lYlJ6MjB4SjkvMVlwVjVkUXdiN2ky?=
 =?utf-8?B?TlBiN0lpWWhScUE5QXc5TWRta09qTytjd2czL2FrYnVrNHJGbWRZQnY2WDVB?=
 =?utf-8?B?YjRTMDRaNGdqVE1wanVYTEc1RHQ3OGlzV21jN21yTnRTUzZHUVRneU1VNGlj?=
 =?utf-8?B?cng4VFdpMHNnVEJ6TzdBb3crN00yL3pKem1RMFBMYnRXTzVnYVRmRE9jTEVy?=
 =?utf-8?B?YlZBb1Yrd2h6OVovWTFISHE4emFNNE5RV1ZMR1d6Vk10Z2RZUTA3aWwwTzhR?=
 =?utf-8?B?K29DYVFGSjZIN2IzT0JteTBLZndpTld3NmpmbWEvQkZqUjgybS81ME9xMHFj?=
 =?utf-8?B?YkJCY2RyUXJkZGRTRWJDektaS1JBRVNaWk5waUtNRkNRMW54eGxoYnVRU3Na?=
 =?utf-8?B?UDVEbXFEc2V1Q1VicitDT2h6RGpZQlRPUHEyQTFGaU5BMFB2czBYWDZSbWFo?=
 =?utf-8?B?ZlB4VVF4VWJGTitNVy9KNW5FRk1LK3d5OTQrZXU1bGtuUUNPN3h2bW5ySFN1?=
 =?utf-8?B?RWdrZTJNZWd0YzdCWEJVc3lKcFhCNkpwZFJ1eWY1RlBLWFZCaVVHUllPZjRr?=
 =?utf-8?B?NjVuZEhJQ1F6dFYwWXB5UDNCTjlqOHA5aEY4MzJ5TGNCbHg4Y0RqcEFiRDZ2?=
 =?utf-8?B?c2JRcXkyd3dWaXpJR3hWL0svUmZxS0NnbVVreVRwVEZXSVFrYW94aDE2cDRi?=
 =?utf-8?B?WHFTcjFrRHdYVVVpRUZOSjNvT2hZdmZ4SjFCbmlHaXViT1lNUFYzYzJWSlh6?=
 =?utf-8?B?MnhucDZQa0dJdnZ0UFdyTnB5TWhsbG5zaHU4S2I2c1QzVSttVTdBcTBtTXA1?=
 =?utf-8?B?SzV1LzQ5ZzJ6T1YrMTgvbFhGaHlTeVE0M01RSnlzU1lBR1dCSFNBMlkyT2Q4?=
 =?utf-8?B?NCtBYTJtMGlJZ0RCdFBDcjhNWVhWVnlUbEovci80UzV5UlUwaFBFTVJNWXNQ?=
 =?utf-8?B?MlJFMU1Ic2ZIVHlucVptOXpoeHh4cVNXM3lhMkY0UVdiRWl0RHFhRzhQdmdH?=
 =?utf-8?B?NUFvV3p2cVpHa2d0WmduZ3ROb2UxNkkvN2pKNWd6QkhncUg0KzdvSThNUDJz?=
 =?utf-8?B?TjhveWplek52WjhXck9mdjVkS1l5QzAxTzBhTitERmVCU0VlNG1FMUZmUGtB?=
 =?utf-8?B?dkV4aFZQY21SR29YN3BjaVBjTUkwZlZJZ3IzQ3VKOG0zUXJsTXI2K0xqYThJ?=
 =?utf-8?B?emlmT2wyUVp6NXhFd09mMnQvcmRaTC9yam1ncEkxcjFRcjdVUVdPZzgxYmhR?=
 =?utf-8?B?dmlCZE9HVXJQZllZZ2liaklWZUhDbHF5UmtUZzkzenBsTnduMGxOLzNPWGtQ?=
 =?utf-8?B?bHI0RE1wamVXbkY5YnlhaU9jK1ZaSHdXUWZvc3B2TG1zNmRwNHh4NWIwR1g2?=
 =?utf-8?B?Ukk1bG5QNDdRR3BPVHgzRHRlQmw5WExaSFZIQkx0QkJiL1RjbldjVEpjMEJO?=
 =?utf-8?B?SUFzRkNKZUhsZkw0RUdGcE1iTkJ5V1hUZTdDVVZ0cE9VajJUOHJZYU1Hanp1?=
 =?utf-8?B?Q0JjNnczelJhV05Lc2ZiN29VbmNuYVVPWENZSHlMRlZLNXI2dmJkR1k5ODV5?=
 =?utf-8?B?ZVNmL3BCbzJkci9jbnlIYjdCSUhkMWk2K3JPVzBUUU9wRnp1WmJaN3RwbHBP?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JKnuN10hDNKf4G9ImDmQes3pKJXBgHQhY0gfpVr3Ztfqg+cwErhZy/hc+EwmuoJCmJHvHHgrPTPAeiNlArE/DjVWtHK8SjL6bx19Zq9eYOl3LoBnbs3Bgyz6RJctIXSAs4NkRk3UPayF+VJvm7OIj+xZcRe4Zp2ya8e5Zt+ekgM30Y4SShxgos3cdVxOW8F7Rg5FnJXX9hHJVyFXYdeEKjFGYHAkyyHQbO8wVdJOgIvuiuvjpdJTsYviSdZnX3/cNN26rdzB6WUXMgqHXTeGG/WW8H1htVOz7PKc/x4krQQiUBkImvBBCcu+jLk8DsrbKsvfrgUo2YY8v6rusdWgCTWyE41mXLWEon0PvjD5S8Oei40eLRVtFoONyu31w9+52YShz4LwgOmXvdxvygI3bo4DMEpiYm3WxPVqHDMx5b1ytvxXkNw35Vq8ffQiFgf7OMupvqo1Y2olR1EhaALSTmLYrvJJxfxSIeeWb6sWynhQrz0+NhidvTDoMuVm00ERs80T/+u1VojlDDfPAYA3acf19TzvfIn6ie1OauTFJ/ftTIkLIs2KyuujclbSqgrtQhu1d4FhaJfnj/ZxUGgveduVkAEEUp+44bZ76ymHJ77OB1t5f9w6kRbw8zF4r8RzeXbVgpgm3n2e0tXz6NXBWlwet5zOanDkinNk/qQaFbhZJLqdDDe04Tj20ytO6PNUwor6V8phd+mjsaM/H3iIOSLcA543JSxUinJqft1+7m5YxV6IJwObZbv6fEtLLPbqFH8pLXZsul9g8TmjckeFoGuciO577d2RrjExibclor+xc+97HITiQtnIgCaM5+7RDUgNlhgm8PRHjToatBPrDw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aed1634-70ab-44ad-5cfb-08db77eac68d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 15:17:24.3687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKclBuW9tc9Jjtmw1/lhKKhH9nIjB4CJZ09K7vxiBm6xYa6qeOz0alabDkwCmGN+lY9m/WCdNC3wifLFfqaf8gheb0YzgBRP4ttyX2KZC88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=988 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280136
X-Proofpoint-GUID: NXihlzxz_BvbBO-g6yP2k9EYn8VooiPI
X-Proofpoint-ORIG-GUID: NXihlzxz_BvbBO-g6yP2k9EYn8VooiPI
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

On 28/06/2023 08:31, Avihai Horon wrote:
> The major parts of VFIO migration are supported today in QEMU. This
> includes basic VFIO migration, device dirty page tracking and precopy
> support.
> 
> Thus, at this point in time, it seems appropriate to make VFIO migration
> non-experimental: remove the x prefix from enable_migration property,
> change it to ON_OFF_AUTO and let the default value be AUTO.
> 
> In addition, make the following adjustments:
> 1. When enable_migration is ON and migration is not supported, fail VFIO
>    device realization.
> 2. When enable_migration is AUTO (i.e., not explicitly enabled), require
>    device dirty tracking support. This is because device dirty tracking
>    is currently the only method to do dirty page tracking, which is
>    essential for migrating in a reasonable downtime. Setting
>    enable_migration to ON will not require device dirty tracking.
> 3. Make migration error and blocker messages more elaborate.
> 4. Remove error prints in vfio_migration_query_flags().
> 5. Rename trace_vfio_migration_probe() to
>    trace_vfio_migration_realize().
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

