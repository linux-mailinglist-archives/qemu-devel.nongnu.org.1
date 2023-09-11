Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA1879A736
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 12:20:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfe1s-0002cB-OE; Mon, 11 Sep 2023 06:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qfe1n-0002bi-5W
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:20:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qfe1g-0002d5-2v
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:20:21 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38AMZiDC020018; Mon, 11 Sep 2023 10:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xYmg6HsIN8s8Klz7HLTsSWHsaskW/LUrh+110qSD/VY=;
 b=aBce9bJMQ1dPKgGvzQB7RiGkhIbjCQ58F3i8uppSZOE06vq1sC9OqXOVUA/wtAedZPuC
 WT6bfT/kArxh1vGQP/69oWWm4G4bLscOoXTtP3bhwXRKC4SoXwddUniuazqjPNen3TxA
 UqKTeT6JYlkeVNpxhFYt/oMQftHl6zFHwDmyhpxcISAJW5p4ZwV+VjDeZ98spqLHvER+
 TQuz7NB7Z1wpsXLqRd81QcKEWwO+sQ/rAd7wA7YDKOHA8ho7izQieW0Z3tUiuiLbXxaC
 G2btGU2zFsIRMC2N5yMyjO562FbOMTeYQ9QkMAsN7xk4UC8j+xXPKTVG3nGUezmtbJVz cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1k4c93un-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 10:20:09 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38B8OfRc004543; Mon, 11 Sep 2023 10:20:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f54rka8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 10:20:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3Y5Iz4VfDn8Y9v7kJ94S6WL+fkUPT0fzv2piCChBOACkP2V/J/olGfM85tyTpnEjatvFETeOikkLh2wyjz7R2nyRQ+TVaONREV2H02JT6+qLK5BT8+RFy3Oaxty1oHm24VDP9L1qufdeXW1Q2yoJf7oNoQZMlMGY6R7d0uEn+hSNLaOik5hbct6AIimmh+5l4oOzUeEOKin5B4cNJe1ggLT6dmspTMHzdp/cHTouFZ4wtT8iuh0DX2YnIjFM0SXxPbDA2ToR9DHYxsfrMCa8oSe9BbnVDFxI7nqkwYtKN+HdUJXs/hprZpeFcnFBtIGxvQoMzm5u3N5k3ybRTRzvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYmg6HsIN8s8Klz7HLTsSWHsaskW/LUrh+110qSD/VY=;
 b=mYY6N7RdroU67knnXnObMlDTZFZq1W5CQZajJMbwPd5/spTYxflL6UEyPNjc4dJ6ywwa7dFwUuevPS5I560p41IguZFKg8JgtTJKsb1/Kcy1Y+xRW8DMnvF2KD0SJ2Fc+fWfH/JVjNM9WU8ts64FrGocst+IASavEf4Ck3bGSpaJJwTKO6vtD06kqvYAJI0IYKE7IcwS2EomeJsPkOSIbawz5kX4+VE8zHTqlFsPfpvKhHxigTzMOvItW113mCxVERO0JJmvoIPSFgzrjdXifV1mM4i5wFM54au2EHkOZ3Sy02oFbn7xsYXUqQDu4gL0K5XTalO3/PrEH9y/4tO3aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYmg6HsIN8s8Klz7HLTsSWHsaskW/LUrh+110qSD/VY=;
 b=Go0U1kHJVkFq2LxIAUIzhBchSonBrQXozaxMYlz3FM4rRkLXS4CNONOySIGzjx6UBQ5IngZWZxK07EuXzG3FGrcIWGiX5ti8nEm9DB3ADoXRTHpGzm4R1icrWoeEJJIwjrtIshFGfOTT3dH6Ri42ZRDiWpgvn/5hNWZr1uOZo6o=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH0PR10MB4408.namprd10.prod.outlook.com (2603:10b6:510:39::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 10:20:06 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 10:20:06 +0000
Message-ID: <fe912dcb-4080-8ab5-71f5-ce2ed2fae782@oracle.com>
Date: Mon, 11 Sep 2023 11:20:01 +0100
Subject: Re: [PATCH v1] vfio/common: Separate vfio-pci ranges
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20230908092944.47589-1-joao.m.martins@oracle.com>
 <SJ0PR11MB67441FE6EAE5A0AB8992FEF792F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <83d2de3c-7a3d-4943-d4b5-1f4a86030512@oracle.com>
 <SJ0PR11MB6744CC7FE6F48E7D17ABC3CC92F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744CC7FE6F48E7D17ABC3CC92F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0028.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::19) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH0PR10MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: b503301a-db70-48d6-acb8-08dbb2b0ab73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4luc6ygEyf+E1aO48ytYjlX11AY0Lsb1pgG7/sODmmbhdA2s/ot/SsJh0DXfVMLzDn3B5/aH7GfLObva0R48oI2rzv0jVgffgyxrJ4SF6IhQ7J9tzGKSEG4cXWGgHAe3oaJSFTGoRnffUwttoxj2PL7r9q52NNpbCdCNv8KL5S2i7cOtqC/CcC0RkJZVUcH6/b897OXAsmO/YJOYGt94g/6T5ueh9ZC76xA8sejK9K8Kg6SUsDjaFbLjsBgIAo9CR3VqjmSI/7hk1mUZvyF06DaPdrXrKf8/8jQDMUzVPSE26qmW3DwbQZHlSSorc6+Xn0YwJpYcN58cG7FxMKnGK+3SjjmzgSYMZt+09zw7C89IYtd6ri2/YKC/Pew0I+Ou6OieBuW6YaO9dZtkoXytZ2syg1wklnytwJwA/nyZCL1Xlwnye7Fws2B+e7BwF9BTpBfyWpQDFnF9XuNxVmebNKmxVTppYFX6JVBKv/wayhFjeTPBaACJOrKO8wKa8VL3poSJCyA8r7ynqTEfpiapzuS2tDQhAc38JP5DiISdvwI4EGl60EIe0xeo/BORGaMMwxP4FF89rFacOnHCSFfmOqoKrLeKd0GYuXW9KzOfJI2MEwA0Deyc5lMpuFOSANp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(186009)(451199024)(1800799009)(36756003)(4326008)(8676002)(8936002)(31686004)(53546011)(6666004)(6506007)(6486002)(31696002)(5660300002)(86362001)(38100700002)(2906002)(26005)(110136005)(41300700001)(66556008)(2616005)(6512007)(66476007)(54906003)(316002)(66946007)(478600001)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjBaVmgxMlZhVWZydDY4Rkk0cmxsR29zeE1MM1FhcjBoT0JHajYyZWVzTEVW?=
 =?utf-8?B?c3JoQmJwUDF0UmJkeExpazU0OE9MSS9mSTF3V0Q0VlRRU3J0QlUyM0lkcVlz?=
 =?utf-8?B?MFE1VUx3NUlRN3VCdDFCRXpSM1NxaGtjc3BxbjdIYWNlV2g5ZmJqY1E4Q0VV?=
 =?utf-8?B?emtHa0w4RkRUanhxcmtEYTUwS1g2UmREKzZiNkJYT3pQVlh0bGhOTjJRRm0r?=
 =?utf-8?B?YVladUFSTE9mUVd3cmJiR1h2dE03NjRTby9GRnkrQytvWEFSS2dENGlpeWpP?=
 =?utf-8?B?WFdGMnRJZkhGYmVlRVZ3T1B1V2JsZkxTY1poQlY3YVYrK2hFL2FzR21TSGRw?=
 =?utf-8?B?Mjk5cytxNlpidlllWGhnM2Q3NTFlVVRoY1FYMXFzNk1TTTRLbjJ5L1g4alda?=
 =?utf-8?B?aVBSS2tuOGxRL3VGUDBzVUkvV0RSckU1Ym5KbW0wNnBjWEZQQ250VlJNTTVN?=
 =?utf-8?B?QnZDVVJQZmRIa0JnSFJYNXFiaXRUNlo3WEJ5c200QkpDV2RtM09Bbldnb0hC?=
 =?utf-8?B?U0lkRkhXQk9IWmZVc0NiNyt1dEpzbmVzTlF4UG5uYkRVSWp4MnNsUC9CRUZI?=
 =?utf-8?B?Wi81dDhwVC9VT0Y5cEhqdUZxaVpReUZuaHZ2QmtzU0JNZTFEU0YzQk9WRnpO?=
 =?utf-8?B?WUNVWXUyQlBaTlNtSWYvVVM2aVVXZnkrSGE5Mm5kdlQwTUJWdGZ1Nk1jSXo4?=
 =?utf-8?B?cGJzUytxN3hpaEJBb0h2OTFPYS9iRHh3eGZXZHl0M0ZORjg5dlJlYkdMNGV2?=
 =?utf-8?B?Y09ma3p0bnBoZmdabk9JN3RZTzluTFlYOTRSUnFTQ3RIYndyaVZZSXdsWTMx?=
 =?utf-8?B?M2F0KzJmT1ZFTXpEbkxXcGhkbk4zNEl1MUpnOEQ1SHBlR01UQ2ZCM0txWDVR?=
 =?utf-8?B?YndRZUcySHhYKzBzTnFrOTNsL0tQem4xQi9NU3JiRFZMbTJLMFN4ejFPRnA3?=
 =?utf-8?B?akFQdVFrbUhqdVZCUkNoWTZIU0g3SGxYeEZqTGJFS3dESE1jL3lmdDgzTmNS?=
 =?utf-8?B?K0NHelYvL21xc2dlVG5JMDJRVHowTFVUQzVxaC9vaFBvMVU4UHA5SlVCYWtD?=
 =?utf-8?B?VFBwL0NaMm5VS1pCTXJhN25pSFU0YUFNVHYzN0tTUSs1M3BMbm5aV3VLOC92?=
 =?utf-8?B?SVpPQi9FZXlrUDZLekFLSjl2dWZQbmlJb0VGWGpCVVBlZXVYRjZ6angwNmJ0?=
 =?utf-8?B?Sll3bXBpQk9FRFpzSU5RcVlldENJVU42K3FYajc4Z3M3b1lpS2NmOER5UkJN?=
 =?utf-8?B?ZWwydnRpcTg1VG1UN0JSVitoNEVzalFHaGtxSS9vV28wUHZjQkcwNE0zZzVs?=
 =?utf-8?B?S25XNCtWdmlrT1NqaGVZdHZkWkwxUmJibmg3WTEranh5OUFlRXJJN21HUGFK?=
 =?utf-8?B?Zkw2ZDh6Ny9LKzlQcWt3TVhOdGNVU0FnMmllTTllSVUvZTIvK1RFUzdPZzdU?=
 =?utf-8?B?RG9oTjlnMFhDelU3dXFFdnRQOWNkVUViYnp4WTVhOEpLeHM5c1FRWW4vc2ts?=
 =?utf-8?B?T1Y5c3hacWRBUGFRK0EwY2JOTGw2OTYvNEZwbUdtYjBGVVZDTERINFBjZlRI?=
 =?utf-8?B?YTZveTNRYk1qMDd5MUxjTjlnLzRZR0E4RE1MNG1tUEovQ3c0RWVGOWJQaHUz?=
 =?utf-8?B?cSs5TUVlQW1hK1VnKzd2b1krQmVaUHk0WEJaMUtwRncrNmJrbU9kSjMrRHVX?=
 =?utf-8?B?QTRJSGo3clByMlBOa2VFUnJqRmhzVEMrL2dOeXBRRUxUMWdVVlhFNndISlZq?=
 =?utf-8?B?b3VyQW9ZczV0bldpUktKbUNWb3UzeElhSlU3eWt1ZmE3YjUyakJqZ290Yzkv?=
 =?utf-8?B?czZRUy9vUDM1YmpSOXFJK0RqYklvZHhXSkxUWGV4NUhzMXVYNURiVml0TmFh?=
 =?utf-8?B?N1lsM0VkSmFHRXdJY0dDWXlnWld5emo3aFB6NjBlYzBIMWw0TlNsc3hTRlQ0?=
 =?utf-8?B?dnhRc1huZ2RDWkZFUmM0ZkZxblgveVJBdHM0aGtEK0lEakp4akJCZlFrSzdT?=
 =?utf-8?B?U0p5OHNHMEF2VG5JVjdwYUJ5OHc0R21jbFFURHdseUovRmhqejFQRSt3UlFM?=
 =?utf-8?B?a0c5MUNya2luaEN2aE04RjZqa3BFL3RNQ1BJY1B6dXQ3cmcwQTBFZHk2Q3NF?=
 =?utf-8?B?b0ppNHZhaHBhTjNyM21sL1ZJM3FEM3FNYys2M20wRndFaGhweU5URTgvVGk3?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F378FyjoCDJ51BNK3cK+yZ3Ze8jiKYbioSebSqjtvSu/UqHDFrl2Gd/OcnUu1TQBzRv87uDsjNRlNao99Q8H04Mpi75048IxUqp/6XRkxDyjMzg8sADBDTJnvLXvMIbpgsYNhU0zTTT+sFIkPo2z62ntC50axNxdrwBi/karDLPWRJjYJjYikwxZyJ9w5e/T0DZwshCEt/cEPA7z79ruSCxXkwAReqlyQBUP1OExkF24nLHuEufWlpE8j1UNTxNTq+YGKYC+7D5YlH73smwsG3/yed6Yem6wRfRr62ehxE3YGhiT/HenuZu8dQV1wQjLg/M05hUJt+eva/RRyloXtG2EOEJpi6Z5QgT2fm+Y5cfefTYTeuHy1OGHqP0d6bxj/uC1wh9RrTUL86YxIfbd9rl/8xQNQJ6ps0IPVGIeitwJFawMxc66gQXjk4uOCMIztYTP+QJGej+uPs1HCR/S3rZrceC1HlreMSn4tka/zdg5SBnibPZJVxh61BrstJp+ZC10/LWmy914Y0XkYYNexSIhjLBrB9GU4Y26lvl9vm52rKt4yrlDml5jeTGuU5mp8sLjylOUTMYbz3cQmNHmemh7Q5vGRArGNAihB5gq2Zco/42TkBwZcELLcn+ju/jjIJNMKtkoejFE/HazA3XEruqOhU/yCSwe6S//L+MGB3u/lWuYFHlnIyXVCAsGcpkmIuoZmA5yUSMMnouYkgF//7KLu/7hlayQ9wsdwYB2dvh/5q6Fyb/8A8uWhYzl0UA8/z05/rLwq1Ydijp+yHuOWoghrmhAMCwx35oiwjsYYgPeZucLZYXnSIiFgXs5Q2y+qfZyoAreUVJHXm5XCsqOJw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b503301a-db70-48d6-acb8-08dbb2b0ab73
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 10:20:06.5792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/bI0GnAJw2NPPyULGWxcFUM3FI3wFSWlZOPUnWk2qA4Ja8UXmegkhJjVewAHRQ3CBNKeuVPU4r4eJv9hOv0z+9ChrNmTx/7JLBjuMBhZbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4408
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110094
X-Proofpoint-GUID: Uc25LFkALvWT6JAdMnAwCuS_aQgDlQWj
X-Proofpoint-ORIG-GUID: Uc25LFkALvWT6JAdMnAwCuS_aQgDlQWj
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 11/09/2023 10:48, Duan, Zhenzhong wrote:
>>>> +static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
>>>> +                                     VFIOContainer *container)
>>>> +{
>>>> +    VFIOPCIDevice *pcidev;
>>>> +    VFIODevice *vbasedev;
>>>> +    VFIOGroup *group;
>>>> +    Object *owner;
>>>> +
>>>> +    owner = memory_region_owner(section->mr);
>>>> +
>>>> +    QLIST_FOREACH(group, &container->group_list, container_next) {
>>>> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>>>> +            if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
>>>> +                continue;
>>>> +            }
>>>> +            pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>>>> +            if (OBJECT(pcidev) == owner) {
>>>> +                return true;
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return false;
>>>> +}
>>>
>>> What about simplify it with memory_region_is_ram_device()?
>>> This way vdpa device could also be included.
>>>
>>
>> Note that the check is not interested in RAM (or any other kinda of memory like
>> VGA). That's covered in the 32-64 ranges. But rather in any PCI device RAM that
>> would fall in the 64-bit PCI hole. Would memory_region_is_ram_device() really
>> cover it? If so, I am all for the simplification.
> 
> Ram device is used not only by vfio pci bars but also host notifier of vdpa and vhost-user.

My only concern is whether this is all part of the pci-hole64 or not e.g. if we
expand to general memory_region_is_ram_device() would we go back to the initial
bug where we create an enourmous range. The latter that you mentioned should be
mainly virtio-net devices as presented to the guest (regardless of backend is
vdpa, or vhost-user) and perhaps they are all in the hole32 PCI hole?

	Joao

