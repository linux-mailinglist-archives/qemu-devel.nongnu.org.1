Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 476B57DEF91
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:13:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUhE-0000hI-Ot; Thu, 02 Nov 2023 06:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qyUhA-0000h0-HJ
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:13:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qyUh7-0005QK-N9
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:13:00 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A283NMu015638; Thu, 2 Nov 2023 10:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dzsN4qm/5yYwTyV3F1gm5I3wGT1BL//r/MpL6S4NZ4k=;
 b=lUi5vVZWyJdQ8LwGsqd3igTVbtFgaoWwhnVqm2V+/VQEN+t6T+zF1DxPFiRr7Rro+gfs
 lNiEdzU/rx6ImFW0Vy1jtNNHvquq3tBvvxCKW4eM3TLy5qIRNhc6E6bSyYWb84QiLM5U
 n/8bprURwyG7Py0smxNN6meJH8jD3EB3BnSHJVLIypGFMp01zQWubD97z/OBLp+PMR+V
 vfQbMilHPPL3XEZOoGT8hnjAVvWX1CX7phWR01/vhVddFnx4yrvCAKj8Gdcnj8J61XBV
 a3gjdYgmUp8fsMKz8IMVt+eYNSMmIHQp+sEgoYcSONbB/ucLOL1dsp1qVVQ9Mfci2DSx SQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7c1bjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Nov 2023 10:12:50 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A291VCt020116; Thu, 2 Nov 2023 10:12:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3u0rr8c2q1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Nov 2023 10:12:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lk7Md6lSMvlKnYSqCPKV/JXcsm/SmB/xjjDZw1VcZxBvEUzZ0ehFSLeI6KtVcAgz+IVZ71L7GSPR9O6XvMVpJhHM99iNEARMD3Hwc1uFb2Zc1aPI69K8hvV9NN+kR9Yd1CMm2PiItQYc831oBY5hUPhhoFrSe1NT9DMI/+zdgpiMM4AjRqzn8CIvG+Cny17ysgymrBJmANpafZD0Amtqms7IJx5IDXa4usDZ8+MTevgkUhsEGfVKXu6KnJpeX9YHXhlHsQ3qvQbGto021kLt8dYNkv3KxXVyg6OPmvgdAP87sQSgs01KjLXQi6GuvHgHXWXaLfmOAHjG3LQortdtlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzsN4qm/5yYwTyV3F1gm5I3wGT1BL//r/MpL6S4NZ4k=;
 b=BOrP4VK3xFXOh+W3ZXi3c3Bs6k3npa+U1yrwuEeIVnbKTjq72yCZDw/H0N5Ffew5MeWAPJqhXF3eV1baBPZcI5hZSAch1a3uXNSrcTEebsaCxACKvJEvLcfwB7LFpSy6z+dbJB8adDb5iQwfW6B/Xg5OvzIgGQI44vQj8J7Xipzs2vK1IlAGTU3Ixk/goc9i/bEpznivkesfdOf7SfPJnaDMyfpdSwfvj3Jm1ATlzqQUGkq2CwcYP/VLDQh830Kw+rKM+kfUjhKaSHHLoTA18oUsrOzn331FjwFu1ydy7+33iBBScdfdWzjXLenNeh0F6JH8EvcCYrpSTR/mSkuZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzsN4qm/5yYwTyV3F1gm5I3wGT1BL//r/MpL6S4NZ4k=;
 b=ZTKKuiMBbkpf5mo+dNfP3UKAX6rN5/PND33n2fTkwyG+i9F21WyYpoHCtH3LxGtHgCjYnNp7Nihhz+k3q4vDlcsBR6FIHOEw/GkUvTcTZkbPDJ1tdu6vzIk/PvbN3bDaipeYoE/wBtShTrh56Unz/xD5frM/w1D2hBEAtOa3bxM=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BY5PR10MB4147.namprd10.prod.outlook.com (2603:10b6:a03:20e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 10:12:47 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 10:12:46 +0000
Message-ID: <1e565b27-2897-4063-8eff-e42cfd5934c2@oracle.com>
Date: Thu, 2 Nov 2023 03:12:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/18] Map memory at destination .load_setup in
 vDPA-net migration
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: Shannon <shannon.nelson@amd.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, yin31149@gmail.com,
 Jason Wang <jasowang@redhat.com>, Yajun Wu <yajunw@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gautam Dawar <gdawar@xilinx.com>
References: <20231019143455.2377694-1-eperezma@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231019143455.2377694-1-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:510:324::15) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BY5PR10MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: f48bd838-fec9-4bcd-9869-08dbdb8c42ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsBTVSS+h1F2VorGdWP15xBmGF6FqTeaHe3cFby6np0w0Pb1MYvrDDCYDF2Vh5frksZ0tvbZSt0aK+XI36AW8Xb/OGtMqJ4YKz9iqLKUhchLz+clbVH9kv4TRGrzuoy4Ah+JogdqSKnIRPNVDhXVwvWhXWfDcjHYRsnPL9AhzSnaU6Z8ua+DGJg9y+d2RAAspCTN44uTDbJFVHJwTHZ6s2kWpUm6fxlwMsHsylg18VtJaZjJrkns11vh6CTFH7zl6es9eQa4xh0Kk9IGARq007SDfNE/gNirnpleGs0jf36KAqpvyWYF02IlavSpNn9WkWbGnuFjXdtHfBte0OJUN6zhexSFSrN8+X31nt2wyBPbgT5oq43sMSJuNFAomEoxINUHVTKcpKjjZ2vsKAsCqHHis/FONT0X9bE8V9eaiDDGg3PcfYNknteySM1yt2QnT+tIctRve58C2GV8C3eic5but2iU/8lhMB8FkYhtL5nvIsPt1mbasdrlpy1PADs9Cl1dSL8rcIlGMT2SJKwOTDmmP8fll1qZOOLR6ZM/JuEs2ZmwL3PrG4cIc7L8ins6OFdC6XA/5rw8bxK/7QbC9XPo5sEwOrQ9bCgnm0zytWlKmamHMnnmfsfdT07yp5y5ZJekdKLIyWfHh/5qPPowzK8VDEWN4tDI7qkH2MLmu3irYRquB9D7dpey5jjpdO9Ssi1AF1/cSDmC1uYIshFicQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(4326008)(8676002)(8936002)(41300700001)(7416002)(5660300002)(36756003)(2906002)(66899024)(26005)(66574015)(2616005)(83380400001)(53546011)(6506007)(6512007)(6666004)(36916002)(31686004)(31696002)(38100700002)(86362001)(6486002)(54906003)(966005)(66946007)(66476007)(66556008)(478600001)(316002)(142923001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEVJYXNpTE5TRWQ1S2ZKUVh3K3BndWNtdkxlb2JwZ21yUFREd1cyeE1BRmxs?=
 =?utf-8?B?WXhNUmRyMnVDUzNnTXlEZndwWkhadThhWXBRdmFiT1NsNEhOM3M3R3lxd25l?=
 =?utf-8?B?UTczTkRRN2RTems3NTV4dTNSL1UwdzVwNlh3alZ0MTJteE9TVG4yUlBPcnBp?=
 =?utf-8?B?ZVZ0b2VXSTdlbnNUdU16OGlPOVJYa3MrdmdzRjlmVTNkQmJucTJZUHhnT29u?=
 =?utf-8?B?a3p1bGcwWkdFbHJmUk9ibVhyY2kvSlp6TzhMei9VUDFjOFdqeDRMcW5sNU1B?=
 =?utf-8?B?ZnVHcElkazJiVVVuQVRGcVZUN0ppRFA3U0JrUUkySldybFFCeWlSbDRQNUpm?=
 =?utf-8?B?MVh6Z3NFMUpobjZWaTBpd0puZWNEeW95WHFqbHpySFJuMVJSejN4ZTBSRFg2?=
 =?utf-8?B?aEFKcytqNUxsU0pVZWNiMFlxRFR2THBrVVZPRGlUYU10SjBHc1ZtSHEvbXFD?=
 =?utf-8?B?WnFoODlkUUphMW05QjFaT21IenhFQ2VuREVvQ2o4SklrRWtPN0dUc2M5VmYv?=
 =?utf-8?B?bnEyWktHZ0JZYit4K3k2Tmt3enk5MkRVdlRmWmg3b0MwOXFUbm5pMFAyM0FM?=
 =?utf-8?B?cmJmRzNkejA4YVFpV0J4d2FxVDg2di9paVhoL1hlWnJsQW9KVFgrQUNkbURB?=
 =?utf-8?B?eUtHK3BOM2xvclVUTnJhMTZ6cFQ4c1FGall5VlFlZU9Ia2k1NGVaMWZHZXVp?=
 =?utf-8?B?Ly9XTmtrNGFhVTIxWElkNEdBVHVEblkvcGxaeG9UMHp6d0VkSGJXbkQxMU5s?=
 =?utf-8?B?ZFJRVk9FOVM4MzRHWktvNmFqSlFyMkVOWFZreVZuYUwrSWhORThaWlIzK2dj?=
 =?utf-8?B?N2o5anBHWkdCNFVuUkloR2tDVzl0VGVqMUJuY2lFMzJMOVN3OXJMdzFFa1dP?=
 =?utf-8?B?d2NDOWxkTDlpMTRVcmdZUkhYWERmWFp3UURkUE4yRHZ2YTAzMVZYVmQ4OGJn?=
 =?utf-8?B?Ymwzakxjazc3aWx2ZEZWTlFKS255UVdveEhCT0RxRU5xb3hJeTNtYmcxcUlx?=
 =?utf-8?B?bUlMaU5LMTVIbzB4NURML1pUVk4ycGI4VGJHaTVpSHpZeE5HaDc4RzRiZWFP?=
 =?utf-8?B?N09iMmtWMHJ4MnZCeTQ2elptNXV0QWgvZGk0ZVhMeWZ1RHBmNENUVlhQRnhW?=
 =?utf-8?B?Ym9sSkZJU2NyYXYzQXdDeS9OcnBKdDh6OGN1MG1Vd0JHcEI1OE5pamJBem5L?=
 =?utf-8?B?alRtUnZCdUQvTzR5QjNQQi92ViswOXppTFJUY3RqRlZOemFsaSt5K1pjd3lK?=
 =?utf-8?B?Q3BRTXJ4ZkxadXUyTllEY0xqNmhJdTNvOXFOR3FLK2FJRkhzaEtreHZ2bjFt?=
 =?utf-8?B?Vmxhbm5RTTRFMHozMHMxS2ZEbnA3M29HZDRqZEdrR3hLMjJhK2lOVlY4Q0hn?=
 =?utf-8?B?N3l1WW5LcWdZWGs1N2pGV1FUZXBkZ3RJb01qOFhFN3dhV1RYcHYxZS85UFdM?=
 =?utf-8?B?Y2w3bE5NcGxKQ3kvU2ZUYW1iKzBVenJTSGJkR0NYczhVSlFNVklJUGtrWFBT?=
 =?utf-8?B?TVQyTUJ1RmlCekR0QjlLektidW52SUtrN0lBcnRkQUJKanNwVnpjaHRNdnln?=
 =?utf-8?B?NTA0L3RkOThSV2ZhdmVRSjQ4N2FyeE9YWXk4OUQvYnRSMEg0L1NkRVhoU3VV?=
 =?utf-8?B?aFJtU0wxdHpUSm0ybGVid203OTIrdC9qVEVGVWdDN3p4ajRmS1pGYXdVYWoz?=
 =?utf-8?B?dkZ6Zmhua2NPcDJsa0FGcS93WGZIb1RzTDJNZk5ocnlEbmUwWnVmSVJDa3ky?=
 =?utf-8?B?TGdEclQvWCtLVUc2NVcrMC9DTlR3Vm9DOFdjTDN1T3JFME03TVFaYnRzRHZm?=
 =?utf-8?B?RTNOK2FvcHhDNm1qajZDVldFbU1pSHVGVExCQmVyaklEcnFJUGFYREZ4aHVv?=
 =?utf-8?B?QUdUcndDeEVnMUpJUG5qcWkrMnU4V25CZkRNSHRyYWlvdG5hbHFSTGNJNE5O?=
 =?utf-8?B?K0xURjJ3S3c4ZTIzNks2eGcxM3lwb2MxV2JNZmY0c2N5azRBaktNNXVYYlhG?=
 =?utf-8?B?TzFPeEpsTytYSU9sRUJCTGNPamE5WE9qZ3BnbjdySHA0SU11NzJpNTBNNE9s?=
 =?utf-8?B?azZoOWpQRU14ZXV0MVlIZk5PcXByNWl2Tk5Xcm01alc2SUQvSmdLRzJMNFh4?=
 =?utf-8?Q?U07EFBPH7NBYaQWBBtWoOEkR7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MmplK3Bpek9vQWhkWEdOemZKQkd5QzVjcXBUV0IyeFlpUVcvQXJwVTVKK0x5?=
 =?utf-8?B?QW1uME5vRU01Qkx2R2dUelhHSkJoaTlwUGRHQmZNR2V1djRBR2x0bTZRdkQz?=
 =?utf-8?B?LzkvRnFvdG94cFhRUTBCNnYyZTVWK2lNLytTSmtkRkZPSStQcXlSVEhuTGdm?=
 =?utf-8?B?WGx1elhFMjlYNFpoK21UVWEzUHp3SU5mTXU3ZFBUMXJzVHR0SGRDcS9BaXRP?=
 =?utf-8?B?cnNGbi9OcGJSa2x6b3YzRmpxZDJjS0h3cG9YU2FLaTh1cjdtZHJTQ1huSnll?=
 =?utf-8?B?S09oaisyMnJ5cUJwbFJNdXFxOGFZTm9QZ2xiS2Y1SXpJLzl3dVlPRDVEVWh0?=
 =?utf-8?B?amNPTWtLeXZuaGoxVUdnamlBc29YYkN0cEVtKzhhOVFQYVNKMEpzWStvMHVt?=
 =?utf-8?B?RzRuRm1vSU5aRThnWjkycVl1OEVpMlo0aHJ0MkFjVEhHWGxXc3NIVGI1UG9Y?=
 =?utf-8?B?Qm5QU08wTWtYb3BtWXo4QmtnUzlBbkVjQXJPRzdUUlAwZ3V4M09QS3UrbmVm?=
 =?utf-8?B?Q2VOdkJCbm9ReTdJT1oxUlh4TmdkMUJnN2czQzBIdGE1UkNBNm1ibkxya3Ro?=
 =?utf-8?B?SkFKcnV6OFpsT3JVY3FlaXFBbEEvdkpHTnpFQjlONEJ1T3ZJTVlGd0pSaUxY?=
 =?utf-8?B?eGlMMDFNTmdqUFlPZnJSRXVEeXI1SmRMSGw3SWl4YzFJenhmb2s4UjFWbXJY?=
 =?utf-8?B?aTZBZVp5UGFxTkdWMm90TThhcGU3ZlNsdVFZR285MFZTTVlSbmVGTVArQWVq?=
 =?utf-8?B?blQ2Sk8rZkJyaFUxeW4wTGFmV2RJWVJFc3I4VVcyVkl0RUNkR1UrRXNHRGxB?=
 =?utf-8?B?b2xVUGxOVUpDanp2NHJlL1E4bGlGSVJZSTVwYVhiaUNvTFFvelphbGpBOFkw?=
 =?utf-8?B?U0QzQytoV3dNcGtjUjNuRFU3cEZCc3NPaXVvVEhXT21aclBXcFYreHNKMDdp?=
 =?utf-8?B?T1hiNDNYaUx3clpBekpwOHRGYjFjZzlxR1dUS09ZQ200bllrbEJwdXBsZG9H?=
 =?utf-8?B?eFE4L1lhaHZVN1NjQjlnYW5XMlNEMkE4NFduaTlzMndoblQyOVE1RjZia21t?=
 =?utf-8?B?UzdnU0xBTzM5TUFDbDNuUWVjMVoydzV5VHVlTDhWeXY1czI4bUJBTW1GNFlB?=
 =?utf-8?B?bTVPdTYreTRnS1UvamRSa1FLaW9IVHlaRktPcjZXRkxEd09ud0VRQk5mUzNm?=
 =?utf-8?B?UURIL0E3QW9tYkRsU0FJbWtKSE5OL0tIblowRjQvVlIwakhEZTloY0lnNkwv?=
 =?utf-8?Q?1TwzyWl+ax9YnMN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48bd838-fec9-4bcd-9869-08dbdb8c42ee
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 10:12:46.9127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jj+QTPYOydR8DT4BoMqWrctX2b/XtT0hbXefHhCHWy5huilVoZotGRwBgETpk9EGd0lCQ2W1cqZEcA0AacNiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020080
X-Proofpoint-GUID: LHEDimU1F1jgcoO_OWJey9gwnTYlSlsE
X-Proofpoint-ORIG-GUID: LHEDimU1F1jgcoO_OWJey9gwnTYlSlsE
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 10/19/2023 7:34 AM, Eugenio Pérez wrote:
> Current memory operations like pinning may take a lot of time at the
>
> destination.  Currently they are done after the source of the migration is
>
> stopped, and before the workload is resumed at the destination.  This is a
>
> period where neigher traffic can flow, nor the VM workload can continue
>
> (downtime).
>
>
>
> We can do better as we know the memory layout of the guest RAM at the
>
> destination from the moment the migration starts.  Moving that operation allows
>
> QEMU to communicate the kernel the maps while the workload is still running in
>
> the source, so Linux can start mapping them.  Ideally, all IOMMU is configured,
>
> but if the vDPA parent driver uses on-chip IOMMU and .set_map we're still
>
> saving all the pinning time.
I get what you want to say, though not sure how pinning is relevant to 
on-chip IOMMU and .set_map here, essentially pinning is required for all 
parent vdpa drivers that perform DMA hence don't want VM pages to move 
around.
>
>
>
> Note that further devices setup at the end of the migration may alter the guest
>
> memory layout. But same as the previous point, many operations are still done
>
> incrementally, like memory pinning, so we're saving time anyway.
>
>
>
> The first bunch of patches just reorganizes the code, so memory related
>
> operation parameters are shared between all vhost_vdpa devices.  This is
>
> because the destination does not know what vhost_vdpa struct will have the
>
> registered listener member, so it is easier to place them in a shared struct
>
> rather to keep them in vhost_vdpa struct.  Future version may squash or omit
>
> these patches.
It looks this VhostVDPAShared facility (patch 1-13) is also what I need 
in my SVQ descriptor group series [*], for which I've built similar 
construct there. If possible please try to merge this in ASAP. I'll 
rework my series on top of that.

[*] 
https://github.com/siwliu-kernel/qemu/commit/813518354af5ee8a6e867b2bf7dff3d6004fbcd5

>
>
>
> Only tested with vdpa_sim. I'm sending this before full benchmark, as some work
>
> like [1] can be based on it, and Si-Wei agreed on benchmark this series with
>
> his experience.
Haven't done the full benchmark compared to pre-map at destination yet, 
though an observation is that the destination QEMU seems very easy to 
get stuck for very long time while in mid of pinning pages. During this 
period, any client doing read-only QMP query or executing HMP info 
command got frozen indefinitely (subject to how large size the memory is 
being pinned). Is it possible to unblock those QMP request or HMP 
command from being executed (at least the read-only ones) while in 
migration? Yield from the load_setup corourtine and spawn another thread?

Having said, not sure if .load_setup is a good fit for what we want to 
do. Searching all current users of .load_setup, either the job can be 
done instantly or the task is time bound without trapping into kernel 
for too long. Maybe pinning is too special use case here...

-Siwei
>
>
>
> Future directions on top of this series may include:
>
> * Iterative migration of virtio-net devices, as it may reduce downtime per [1].
>
>    vhost-vdpa net can apply the configuration through CVQ in the destination
>
>    while the source is still migrating.
>
> * Move more things ahead of migration time, like DRIVER_OK.
>
> * Check that the devices of the destination are valid, and cancel the migration
>
>    in case it is not.
>
>
>
> [1] https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/
>
>
>
> Eugenio Pérez (18):
>
>    vdpa: add VhostVDPAShared
>
>    vdpa: move iova tree to the shared struct
>
>    vdpa: move iova_range to vhost_vdpa_shared
>
>    vdpa: move shadow_data to vhost_vdpa_shared
>
>    vdpa: use vdpa shared for tracing
>
>    vdpa: move file descriptor to vhost_vdpa_shared
>
>    vdpa: move iotlb_batch_begin_sent to vhost_vdpa_shared
>
>    vdpa: move backend_cap to vhost_vdpa_shared
>
>    vdpa: remove msg type of vhost_vdpa
>
>    vdpa: move iommu_list to vhost_vdpa_shared
>
>    vdpa: use VhostVDPAShared in vdpa_dma_map and unmap
>
>    vdpa: use dev_shared in vdpa_iommu
>
>    vdpa: move memory listener to vhost_vdpa_shared
>
>    vdpa: do not set virtio status bits if unneeded
>
>    vdpa: add vhost_vdpa_load_setup
>
>    vdpa: add vhost_vdpa_net_load_setup NetClient callback
>
>    vdpa: use shadow_data instead of first device v->shadow_vqs_enabled
>
>    virtio_net: register incremental migration handlers
>
>
>
>   include/hw/virtio/vhost-vdpa.h |  43 +++++---
>
>   include/net/net.h              |   4 +
>
>   hw/net/virtio-net.c            |  23 +++++
>
>   hw/virtio/vdpa-dev.c           |   7 +-
>
>   hw/virtio/vhost-vdpa.c         | 183 ++++++++++++++++++---------------
>
>   net/vhost-vdpa.c               | 127 ++++++++++++-----------
>
>   hw/virtio/trace-events         |  14 +--
>
>   7 files changed, 239 insertions(+), 162 deletions(-)
>
>
>


