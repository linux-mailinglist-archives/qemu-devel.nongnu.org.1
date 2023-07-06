Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF5A74924B
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 02:15:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHCcv-0003Gw-K6; Wed, 05 Jul 2023 20:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qHCcs-0003GF-Um
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 20:13:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qHCcp-0001lb-LO
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 20:13:38 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 365LaoN0017417; Thu, 6 Jul 2023 00:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wFZYWbh/Gacndgs1rq1QqR95vvz7eCdDTZb8rX3nFnw=;
 b=Udh7VtfGqAaIuT1BAETKUpIDPx/OqWJQN1PzOlUlTRLmSlG456Zd66dp39TWJGmRmldV
 kevRgX+2SsC8CErvoQPYIaalrPN07qJLZOrAuXiFNDnXsQMrvJRBjEWu0JFSExabXWI3
 7gJCD9GIUSxcaZsITRSFUgUlw/Rg7C4TvrgU7S6BAxiSGGw2L4amKICafEB/XZ7TD5YJ
 6UkZO/YqOD0e49vGoFbBajJexOrnLiefOzyuVQ3rALzoiDfmZUsDtjsQEFa51gwd3SGo
 CUdw4yM6wcyLpXgXPEBlz5dg5NRg0gzjhm1c/SOig2gzqh9VUO8Lr96nuqi4+oxqGbps cQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rnfkug813-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Jul 2023 00:13:26 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 365NA1QO007187; Thu, 6 Jul 2023 00:13:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rjakc8u44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Jul 2023 00:13:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8I0+rjaZZOMnOvBqrwp9ua//VBmv20/HIQu4Wldi24+o8sxba+0apUKp953B4NTYhADn2W3YhHAOnq89L4ufceQHKlWAAbFG9bsTkkIt28gKFK05wrNTwiwVl9CiaViS4/9rnNfGnzVAYswlsCxXaR0GKtN3Z41mUxw9uF8ZyD7+pTalL7Z6SeXMRtUJpeZjLe9pDKxhbToAEl+nD+LPs96GZjVNFgFOKEtmOpEmtbp7/l3q9UNfpUGtYiy7PWO7GKoxsa6esDJqpe+pu6AEzmAelaYZDdL1u5AiadIiLfw9O0z/BRYsMJCAQOlWcrbq3Zt8cPig7UpWLDZxpDACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFZYWbh/Gacndgs1rq1QqR95vvz7eCdDTZb8rX3nFnw=;
 b=itkAPha2oEDMPLTRgUERyqof0rrPcin2tKdjheG+FD//SV4ft3HLTejqI5RqR/D6vrumBc6wwlkdCCluCN652cND9FZPDFOM5hN8emIFqbuwugRTtX9/M7W/RT0OShVlBCETQKzogWMFBrgQ+0j86NsUJtIEUmytNjVL5Zn2LwOgtVgqDhaAJoPZIyBoRFPuSHEeIRwdo/Kl9iL3hgB3Bog8iRrPzME2OKrJsGq0+oc3h28jJiRzWDuEIOphifD7LJa1dL1OBIxFn7ruyGzIL+nboqrNwmgAeyQwDMOxSVInWGkczTVJJ8ERyGDAMjq+CbhvaXlFHeMIC1RJ/s6HXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFZYWbh/Gacndgs1rq1QqR95vvz7eCdDTZb8rX3nFnw=;
 b=uzps/cbfCrEprTyTkp9NnezTrEOsQJLiMPR3qGg98PgxJOlXoTan+xlmwTPVoNxxh2VpQ6mnF4zxlaqae0Mjozqv/EswD9r+EK+EQJ3/EHSHYo89MteWB8CnHEhtQyxFwigcd4dXokZyD49/e3XUMClFYl/F3M2OurtoXspBBSE=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH8PR10MB6624.namprd10.prod.outlook.com (2603:10b6:510:220::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 00:13:23 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9842:10ce:30cd:cd06]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9842:10ce:30cd:cd06%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 00:13:22 +0000
Message-ID: <a73797a7-a71d-9ac9-f92b-6bfad2c79058@oracle.com>
Date: Wed, 5 Jul 2023 17:13:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Reducing vdpa migration downtime because of memory pin / maps
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Michael Tsirkin <mst@redhat.com>, Longpeng <longpeng2@huawei.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eli Cohen <elic@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Juan Quintela <quintela@redhat.com>, David Gilbert <dgilbert@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <CAJaqyWdV6pKP0SVZciMiu_HN86aJriZh0HBiwHNkO7+yErXnBA@mail.gmail.com>
 <c59d2d67-d31a-b6e6-54c5-5b81c18d9547@oracle.com>
 <CAJaqyWegsVHEVZt2_mf4wA8MuF7UXmU=UbHJfwyzURDRxfRgmg@mail.gmail.com>
 <bff286b8-0103-1698-c77d-736417396405@oracle.com>
 <CAJaqyWcwFgEH3MCOAhHe20P3oy2_aq2BUkTA9_7wePsT8=GoAg@mail.gmail.com>
 <8db2b6cf-1e32-67eb-f6c0-fe3a4175b410@oracle.com>
 <CAJaqyWd_wb5eXcTi2R+-n=AriP=rwKTCwObz1sZ45eRrpLw_wQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWd_wb5eXcTi2R+-n=AriP=rwKTCwObz1sZ45eRrpLw_wQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0067.namprd17.prod.outlook.com
 (2603:10b6:a03:167::44) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH8PR10MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: edad8d25-b394-4cf3-95b3-08db7db5cf48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aheH3zsbcOZc1iX6KnTxJ6adklUfaJtMQn6M/hW7AxD9E0IviMg+TndD6Vv7cTlg8/5rnA2jMuuF31wVi5Xm+wOM+m75OgVaMeaSMwba2bsRxg7kJsgKpTE7lvYVADzJmsHrBUuR3tNFubuem2JQjyF1ehoP9LjijzE8REwTU0/v0NGhfVObE8I03+NDYlOCxLnRRDX4dnsTRZhdETrU/2onZaiwYwfiT5aNIjJNf+UIRuAmb3ilqnTRpPSaGAiNZz0Rrlo4Ou0BShuLRmSX6nZ+tJ5kkA3GsYukhwhLf/Yhm7cgLYAS2X7EtxWpM3VBFhGw4LJ3SX6rLU7/3Vleykt0GwhN6yHm6JHhhdD5TukXN+WGM2b/eIereDUtbEGunh6qB9dGwcNk7GZxILOmbNSwye+vsUTh5Q2OBV91GmfTHy5sP6LVz4Pbqv5i5dshFWoEyymAfope2vI3LGIUakZwyV2ZBt0UBHuk6ERJ/cc46JzsruCfh/Hj3L8XrWAE8t/g0SFs4BfNCgxK5ccM6LSWM9mJeTf46EAdMRg/prTHJdgVr2YwepGBYCfWbgbcPokBL4kDWOfL6yhqjcdEApEOVDn6U74+8d1gLnc6u+wO5jelOrv3WS8AhUNek6uUy4K8RsFAsuWiEsh93pCRrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(31686004)(26005)(36756003)(30864003)(5660300002)(38100700002)(7416002)(66476007)(6916009)(8676002)(8936002)(41300700001)(66556008)(4326008)(316002)(86362001)(31696002)(66946007)(966005)(6512007)(6506007)(2906002)(6486002)(186003)(54906003)(53546011)(478600001)(36916002)(6666004)(83380400001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVJYTmNwd3ZsOWVVb2tCbUs3bnJWWmljTDJLVTMrUkZVL3RPL0ZDWWw3SGxi?=
 =?utf-8?B?YldGR2E1R1JyTStuSG1HL3NTNFFzMVdTK2JHc0svWFhoVEk2V2RNSnlkWFNt?=
 =?utf-8?B?QU1oR0F6aU40dFd6RitLdE1WSE1uNUlmQjlvMFBNdHZGRDQ1UEM2S2tSaDN1?=
 =?utf-8?B?cGxRU3JmZE0vUzltWWQxMTByTmlFb3k1dzRCTW5sclIwQ3l1UGFOdWx0eC9Y?=
 =?utf-8?B?b1VMVkh1R2tHeDFaVFNyNnB5TEREQVRhaFRIZWt4UmlOUGxjNmdqY1MyVTJa?=
 =?utf-8?B?NzhrMFZzLzI0NVpMVGJGQTNNaFkzSUZEaVVMRm5sSGJySU02QUlveHFBOCs5?=
 =?utf-8?B?MmZhQnJzclpVWHF6aUNlQjczbEJhS0M5R3R3WHhEeHpuemRZb3dBOHNkRE5a?=
 =?utf-8?B?enU1akNoODdwVjFkQiswL0dhWGpiQU5MYWNGWTBwM3NNYVV6L0JXbDY1bXRZ?=
 =?utf-8?B?ZHVjMXBwNXpwc0hsd2FOSEpYR3dkRmtaYmZkSVpIcHdkUTFXdExXRXUyYXBn?=
 =?utf-8?B?d0hkWkVvZDNiWVMwSlMxWkw2TWFWd0oyd1hVakJrUlFFekxqOXN2MzFLdnRJ?=
 =?utf-8?B?YVRWdFJGK0QyV25TdEk1NjhadXRNY0tULzFTaXZZY09Cenh5ZEdmbEVObnBh?=
 =?utf-8?B?K2RRcVVWdEM1RlN1bnUvM1gvNVY3d0NVbjlML3BvL0drRWo0N0VKcjZtMXlh?=
 =?utf-8?B?UE4xZUl4dk1tbWdaYmNwTm1qOVRVcDMzWVdxRWxzcWptUThRQmlJYVRoSE9q?=
 =?utf-8?B?VXhXaTh2M2MwM1F6b21OSWt4aGlqOGdzREI1ejA5MVpOc2crMnFPWXFVMUth?=
 =?utf-8?B?djZUSHFVS0pMVm8yVk9LRjBueWxMWjR2STEwbkhaVjJ1b3ljeXhRUmpZYzFi?=
 =?utf-8?B?UUQ2eUluMmJkMWpudVl3U05hQzVNcnk0azlkemZndXZZTkpTSk5NQ1RTeGNS?=
 =?utf-8?B?bFc0T1IrVk4rS3FPU2RPODBZN1FqS2h4UHdqeTBFZFhBcHE3MXZadmpvcWF1?=
 =?utf-8?B?SDltN2ZUOGNFNUJZaHVzYm1TWEZ5NUM4anRncDh4Qi9zR3hwUjRTUk4wRHYw?=
 =?utf-8?B?eVFiTjRERVZrb1BRZEhuZXNZbEpINmNZVFFwOWk1ZURPWFl4QS9CV3ZFZmhJ?=
 =?utf-8?B?QVlUVzQ5ZlJydWpLYVBQcHM0N1BpcVBIbWtWRFJwaUo1S29oenNuaHBWRnZy?=
 =?utf-8?B?QndjSTRUUnJDUkFrRzZISVF3SFJQb2FpYXZJTHltWEsxaUQvWmp3UnB5V1Zw?=
 =?utf-8?B?Qnk4YjNqOXRmVkZOSExSazRqRjBvbzZ6dWdkWW9uMDkxaHl6M0RPUmJtaWg2?=
 =?utf-8?B?US9zZW0vbGZ3dXZ2QW5GMTJJSGtkSFovTURDSXkwaVZvTlkwdXZsZ1Mrd21B?=
 =?utf-8?B?QVpVVlh5NWdWc3ZWZHhFVkZlZkp2dCtuUG9lNmRrYkRPd0JEZGJvUmh3MWhZ?=
 =?utf-8?B?N2JOWFFYc3lTZnh5SG9NYkZOUTFFWDBOWmsvelQ5emsvTm5TZjdjYkt5SURQ?=
 =?utf-8?B?aHhiYzBaTEJBRUJ4bXBuaXRXdFBqRFl5YlB1WTFTWHI1S2NmSUxqMkR6dUVl?=
 =?utf-8?B?NUd0b0EyQUV3eFRrYlFtWThUcDltN3U5QS9mYnZvTFFUVEFMVUd5a1JQcFJr?=
 =?utf-8?B?YzJCRWZ6NVgydkRKTEZrekxLNVdKMlg0N1dveWpjdWdHZDd4b2tWc3UxZk4x?=
 =?utf-8?B?R2hBMmhYRDFqQzVrcFl4ZTRFMitocU9VQTJtRm8wK0l5UUtOLzBxSmZDNnlQ?=
 =?utf-8?B?YkhmNUtKQzVJV05SQ1oxOG9YS01pV09EcVVhQThybG5XZlVCcElUT0ZLT2tV?=
 =?utf-8?B?M2tReHZhKzhNSXJkN0xUV0cwMDJUU0kzZzQyUUVoaWs3NFNqV01TQ2FmT2FZ?=
 =?utf-8?B?a05BWFhCYi9JdzNCeGVsMi9QNVRNUlo2OWJsZGtBcHU4RU9Id0ZDdEU4UDgz?=
 =?utf-8?B?UjdPT2ZWVktuTUZXaHlDMWJMQkJpd1l1WE9sUk5Kc0VZN2YwamluR0Y5WkxR?=
 =?utf-8?B?c2ZuelZGYmZCTjN5Wm5yNEJEN3R0YUhmL1pOWnVXQlZvZFYzMlk1VkRnZVll?=
 =?utf-8?B?V0tIV0pJcEZzK0lXNTIrK3lCM0RoalMzZG41OXdGYjRaR0lnMDBJREFLQlBz?=
 =?utf-8?Q?whEOSx1GvLI7ggQfdrqOj2chg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hMllpG73lwBlp4mfHN4PASINxA9wIo/FCc/0K+ZPmG/mOVEW68rH1iNVu98ZkoJq/fc+Zx9PWTCSO99Joyb+cI5NNCueVwlzIWbH/95I9xOmuTy/whLzx0Ty5RoReyBvQCSgBO8U30/V6iqkvwQZFai5+Y/Q5BMNxzp6TPYUk1q4B0y8e1e70XYGY6Dnw10gygsatYcVfu5IFualIie3GWU/1I1CEBeLrtErXZcmwGNsIy75UFdmSM4oL4zfg9768WVzzfDqzwtULyhWTZjjaa0RnV9txZRisaYkI8lItYuJMMAAM043SKJYutNOgmiZSePXgsBrNBRxkL5JvAQQuVSNT15auxQ11bIsxJsqTKRnQeQNjR+AW3vIZe3Xth3ZGKEDcWSJC7LcoR9QK8LnktkXbQHE84fAhkZ3wrHb2lwwnGabXafwuEbpW+yErLjflJs0ioTd4nTDly0/gSAD8uxTUSuHCTSXyDaHn8Sq47zCqSLAQgO/LMXs83mJFGj6ftqwiHU8WmNVHHuxfGowhUjuKl9H/ss87deHprNX5aE2/1GAy682ZnbIUx5cGro+QTZOUL57vmhM8ZosAguZz/NxjWyOrGfdUoO3ME7mgDi6FNaZAb5F8+1jiGD7eIP+Tb0LcL3Z7yIzxrkrcS2iD/DrL14FgPPklBbxHziakJahrydJE1RH4xvr7G0aQ2PfmF/xeVoLiZnHrVDjVdSjndBANKwtEU8J62tDeesRV5BP/s5H6P1Fa1dzZrbI1+lDLOpYo3ADtKxdpW9teG5n3crWWlkMx+caFQKca7IaVgogolWR0UkohOihKEk3OGwaN/f2eI36p9X1lo4r4BBD5g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edad8d25-b394-4cf3-95b3-08db7db5cf48
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 00:13:22.5144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKGePDHPNMcAH2FBZdIHDMDmrDcBS4evp6SM6l6seK+yPWVQM6QV0DnJ/Lq7Pn1jlQYL9PNrSklVVdQbARVh9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6624
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060000
X-Proofpoint-ORIG-GUID: IemHgYDerWqdPHYxVhKSVDM3ibVnP5ZA
X-Proofpoint-GUID: IemHgYDerWqdPHYxVhKSVDM3ibVnP5ZA
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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



On 7/5/2023 11:03 AM, Eugenio Perez Martin wrote:
> On Tue, Jun 27, 2023 at 8:36 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 6/9/2023 7:32 AM, Eugenio Perez Martin wrote:
>>> On Fri, Jun 9, 2023 at 12:39 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>> On 6/7/23 01:08, Eugenio Perez Martin wrote:
>>>>> On Wed, Jun 7, 2023 at 12:43 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> Sorry for reviving this old thread, I lost the best timing to follow up
>>>>>> on this while I was on vacation. I have been working on this and found
>>>>>> out some discrepancy, please see below.
>>>>>>
>>>>>> On 4/5/23 04:37, Eugenio Perez Martin wrote:
>>>>>>> Hi!
>>>>>>>
>>>>>>> As mentioned in the last upstream virtio-networking meeting, one of
>>>>>>> the factors that adds more downtime to migration is the handling of
>>>>>>> the guest memory (pin, map, etc). At this moment this handling is
>>>>>>> bound to the virtio life cycle (DRIVER_OK, RESET). In that sense, the
>>>>>>> destination device waits until all the guest memory / state is
>>>>>>> migrated to start pinning all the memory.
>>>>>>>
>>>>>>> The proposal is to bind it to the char device life cycle (open vs
>>>>>>> close),
>>>>>> Hmmm, really? If it's the life cycle for char device, the next guest /
>>>>>> qemu launch on the same vhost-vdpa device node won't make it work.
>>>>>>
>>>>> Maybe my sentence was not accurate, but I think we're on the same page here.
>>>>>
>>>>> Two qemu instances opening the same char device at the same time are
>>>>> not allowed, and vhost_vdpa_release clean all the maps. So the next
>>>>> qemu that opens the char device should see a clean device anyway.
>>>> I mean the pin can't be done at the time of char device open, where the
>>>> user address space is not known/bound yet. The earliest point possible
>>>> for pinning would be until the vhost_attach_mm() call from SET_OWNER is
>>>> done.
>>> Maybe we are deviating, let me start again.
>>>
>>> Using QEMU code, what I'm proposing is to modify the lifecycle of the
>>> .listener member of struct vhost_vdpa.
>>>
>>> At this moment, the memory listener is registered at
>>> vhost_vdpa_dev_start(dev, started=true) call for the last vhost_dev,
>>> and is unregistered in both vhost_vdpa_reset_status and
>>> vhost_vdpa_cleanup.
>>>
>>> My original proposal was just to move the memory listener registration
>>> to the last vhost_vdpa_init, and remove the unregister from
>>> vhost_vdpa_reset_status. The calls to vhost_vdpa_dma_map/unmap would
>>> be the same, the device should not realize this change.
>> This can address LM downtime latency for sure, but it won't help
>> downtime during dynamic SVQ switch - which still needs to go through the
>> full unmap/map cycle (that includes the slow part for pinning) from
>> passthrough to SVQ mode. Be noted not every device could work with a
>> separate ASID for SVQ descriptors. The fix should expect to work on
>> normal vDPA vendor devices without a separate descriptor ASID, with
>> platform IOMMU underneath or with on-chip IOMMU.
>>
> At this moment the SVQ switch is very inefficient mapping-wise, as it
> unmap all the GPA->HVA maps and overrides it. In particular, SVQ is
> allocated in low regions of the iova space, and then the guest memory
> is allocated in this new IOVA region incrementally.
Yep. The key to build this fast path for SVQ switching I think is to 
maintain the identity mapping for the passthrough queues so that QEMU 
can reuse the old mappings for guest memory (e.g. GIOVA identity mapped 
to GPA) while incrementally adding new mappings for SVQ vrings.

>
> We can optimize that if we place SVQ in a free GPA area instead.
Here's a question though: it might not be hard to find a free GPA range 
for the non-vIOMMU case (allocate iova from beyond the 48bit or 52bit 
ranges), but I'm not sure if easy to find a free GIOVA range for the 
vIOMMU case - particularly this has to work in the same entire 64bit 
IOVA address ranges that (for now) QEMU won't be able to "reserve" a 
specific IOVA ranges for SVQ from the vIOMMU. Do you foresee this can be 
done for every QEMU emulated vIOMMU (intel-iommu amd-iommu, arm smmu and 
virito-iommu) so that we can call it out as a generic means for SVQ 
switching optimization?

If this QEMU/vIOMMU "hack" is not universally feasible, I would rather 
build a fast path in the kernel via a new vhost IOTLB command, say 
INVALIDATE_AND_UPDATE_ALL, to atomically flush all existing 
(passthrough) mappings and update to use the SVQ ones in a single batch, 
while keeping the pages for guest memory always pinned (the kernel will 
make this decision). This doesn't expose pinning to userspace, and can 
also fix downtime issue.

>   All
> of the "translations" still need to be done, to ensure the guest
> doesn't have access to SVQ vring. That way, qemu will not send all the
> unmaps & maps, only the new ones. And vhost/vdpa does not need to call
> unpin_user_page / pin_user_pages for all the guest memory.
>
> More optimizations include the batching of the SVQ vrings.
Nods.

>
>>> One of the concerns was that it could delay VM initialization, and I
>>> didn't profile it but I think that may be the case.
>> Yes, that's the concern here - we should not introduce regression to
>> normal VM boot process/time. In case of large VM it's very easy to see
>> the side effect if we go this way.
>>
>>>    I'm not sure about
>>> the right fix but I think the change is easy to profile. If that is
>>> the case, we could:
>>> * use a flag (listener->address_space ?) and only register the
>>> listener in _init if waiting for a migration, do it in _start
>>> otherwise.
>> Just doing this alone won't help SVQ mode switch downtime, see the
>> reason stated above.
>>
>>> * something like io_uring, where the map can be done in parallel and
>>> we can fail _start if some of them fails.
>> This can alleviate the problem somehow, but still sub-optimal and not
>> scalable with larger size. I'd like zero or least pinning to be done at
>> the SVQ switch or migration time.
>>
> To reduce even further the pinning at SVQ time we would need to
> preallocate SVQ vrings before suspending the device.
Yep. Preallocate SVQ vrings at the start of migration, but before 
suspending the device. This will work under the assumption that we can 
reserve or "steal" some ranges from the GPA or GIOVA space...

Thanks,
-Siwei

>
>>>> Actually I think the counterpart vhost_detach_mm() only gets
>>>> handled in vhost_vdpa_release() at device close time is a resulting
>>>> artifact and amiss of today's vhost protocol - the opposite RESET_OWNER
>>>> call is not made mandatory hence only seen implemented in vhost-net
>>>> device today. One qemu instance could well exec(3) another new qemu
>>>> instance to live upgrade itself while keeping all emulated devices and
>>>> guest alive. The current vhost design simply prohibits this from happening.
>>>>
>>> Ok, I was not aware of this. Thanks for explaining it!
>>>
>>>>>>>      so all the guest memory can be pinned for all the guest / qemu
>>>>>>> lifecycle.
>>>>>> I think to tie pinning to guest / qemu process life cycle makes more
>>>>>> sense. Essentially this pinning part needs to be decoupled from the
>>>>>> iotlb mapping abstraction layer, and can / should work as a standalone
>>>>>> uAPI. Such that QEMU at the destination may launch and pin all guest's
>>>>>> memory as needed without having to start the device, while awaiting any
>>>>>> incoming migration request. Though problem is, there's no existing vhost
>>>>>> uAPI that could properly serve as the vehicle for that. SET_OWNER /
>>>>>> SET_MEM_TABLE / RESET_OWNER seems a remote fit.. Any objection against
>>>>>> introducing a new but clean vhost uAPI for pinning guest pages, subject
>>>>>> to guest's life cycle?
>>>>>>
>>>>> I think that to pin or not pin memory maps should be a kernel
>>>>> decision, not to be driven by qemu.
>>>> It's kernel decision for sure. I am with this part.
>>>>
>>>>> I'm not against it if needed, but
>>>>> let me know if the current "clean at close" address your concerns.
>>>> To better facilitate QEMU exec (live update) case, I propose we add new
>>>> vhost uAPI pair for explicit pinning request - which would live with
>>>> user mm's, or more precisely qemu instance's lifecycle.
>>>>
>>> Ok I see your problem better now, but I think it should be solved at
>>> kernel level. Does that live update need to forcefully unpin and pin
>>> the memory again,
>> No, it should avoid the unpin&pin cycle, otherwise it'd defeat the
>> downtime expectation. The exec(3)'d process should inherit the page
>> pinning and/or mlock accounting from the original QEMU process, while
>> keeping original page pinning intact. Physical page mappings for DMA can
>> be kept as is to avoid the need of reprogramming device, though in this
>> case the existing vhost iotlb entries should be updated to reflect the
>> new HVA in the exec(3)'d QEMU process.
>>
>>>    or that is just a consequence of how it works the
>>> memory listener right now?
>>>
>>> Why not extend the RESET_OWNER to the rest of devices? It seems the
>>> most natural way to me.
>> Not sure, I think RESET_OWNER might be too heavy weighted to implement
>> live update, and people are not clear what the exact semantics are by
>> using it (which part of the device state is being reset, and how
>> much)... In addition, people working on iommufd intended to make this a
>> "one-shot" ioctl e.g. CHANGE_OWNER instead of RESET_OWNER+SET_OWNER:
>>
>> https://lore.kernel.org/kvm/Y5Ibvv9PNMifi0NF@ziepe.ca/
>>
>> New uAPI to just change ownership of mm seems a better fit to me...
>>
> I'm not sure about the right solution here, but there are other
> proposals to batch ioctls. But maybe creating a new one fits better.
>
> Thanks!
>
>> Thanks,
>> -Siwei
>>
>>> Thanks!
>>>
>>>
>>>>>> Another concern is the use_va stuff, originally it tags to the device
>>>>>> level and is made static at the time of device instantiation, which is
>>>>>> fine. But others to come just find a new home at per-group level or
>>>>>> per-vq level struct. Hard to tell whether or not pinning is actually
>>>>>> needed for the latter use_va friends, as they are essentially tied to
>>>>>> the virtio life cycle or feature negotiation. While guest / Qemu starts
>>>>>> way earlier than that. Perhaps just ignore those sub-device level use_va
>>>>>> usages? Presumably !use_va at the device level is sufficient to infer
>>>>>> the need of pinning for device?
>>>>>>
>>>>> I don't follow this. But I have the feeling that the subject of my
>>>>> original mail is way more accurate if I would have said just "memory
>>>>> maps".
>>>> I think the iotlb layer in vhost-vdpa just provides the abstraction for
>>>> mapping, not pinning. Although in some case mapping implicitly relies on
>>>> pinning for DMA purpose, it doesn't have to tie to that in uAPI
>>>> semantics. We can do explicit on-demand pinning for cases for e.g.
>>>> warming up device at live migration destination.
>>>>
>>>>
>>>>> I still consider the way to fix it is to actually delegate that to the
>>>>> kernel vdpa, so it can choose if a particular ASID needs the pin or
>>>>> not. But let me know if I missed something.
>>>> You can disregard this for now. I will discuss that further with you
>>>> guys while bind_mm and per-group use_va stuffs are landed.
>>>>
>>>> Thanks!
>>>> -Siwei
>>>>
>>>>
>>>>
>>>>> Thanks!
>>>>>
>>>>>> Regards,
>>>>>> -Siwei
>>>>>>
>>>>>>
>>>>>>> This has two main problems:
>>>>>>> * At this moment the reset semantics forces the vdpa device to unmap
>>>>>>> all the memory. So this change needs a vhost vdpa feature flag.
>>>>>>> * This may increase the initialization time. Maybe we can delay it if
>>>>>>> qemu is not the destination of a LM. Anyway I think this should be
>>>>>>> done as an optimization on top.
>>>>>>>
>>>>>>> Any ideas or comments in this regard?
>>>>>>>
>>>>>>> Thanks!
>>>>>>>


