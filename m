Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9F279842C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:37:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeWyB-0007SE-2E; Fri, 08 Sep 2023 04:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeWxu-0007Rw-Ci
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:35:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeWxo-0002jh-QN
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:35:45 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3888Zaho010003; Fri, 8 Sep 2023 08:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Rfv1BmPX4JoAsPZxOpByi7MBN547JGfR57xQ0+nQ9dc=;
 b=oumizpBRCtwcGRkO7rE2G9tHwuwMhtPaIzDxanE5cRM+Tx2tiTwuF75TvUWWf0NwW1TI
 BDdPoz2HyFq2wOoDcBU303sT2h5Onx+oatMsvW3YtQgXqjIX/waCPiqwvdj6AtLmel+K
 RZRPr0D+5Tva9V57mIxAp81qfgECbWbKF0XSUJBz+1RcyyCRgdzwSlMhlczPVQmwjiWU
 ewhDO/9wyqOGe3MN+Hzx2yXj7FYYGMZuyHeA5aFAqG2s5gkbd3COqAz4t6TBn1ykfT9m
 bbSWwkWa86ty3v3CWUx+qCN7qim2Ld5mOl+G3R3uyMJCwk9DBwynVoTA/zo442a6jJ4z Wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t007r000p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 08:35:37 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3888DXPP017318; Fri, 8 Sep 2023 08:35:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3suug9bxf8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 08:35:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfIrTAy254ph6XREryEDgqmKA6az9HX6+X/BT9cc9w38z+7Hour9Ea8e6QCRCKJeXLrdLwxllHgWBT9rIMS7+wv53S7ZmhkHmYa0fCEMRwu3hN1Nnt3Pt1C9jdGccX79PZZJLWlBJuYK4vUxfrOi9WEVo52ui/9E7J/hOl+sYY7QGuIW/yT7RUGfYkqJqhTxMs3RB0/WDDlpjRI0DumCavpuSk3BY63ytHq/uhzvLSyz7bvtuBeL+D1vGXb4ahSpsi85F4Wjt4DF2BaCLJNYxSecNuQpbhLK1crvgqzR+1BEFJuMz+4h+dJIhODmn9ya54oOJOaL6KINQdPK6lCaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rfv1BmPX4JoAsPZxOpByi7MBN547JGfR57xQ0+nQ9dc=;
 b=ea6xgPzzjueoKZkUzYRxjibvdsaeGKG5wLz0cEoY4r2HhIgPxQksurZwOXL6vnroVKr7BjHIZ6cQdHv76cx+dZZeamgT6/eE4LCD9vREmKyZMXPvTQeSVwkLvuO2GpU2zMDA2anNIcoZpGwEsp5Kd2D316Ly3q5IbZIdKP1SORf/zNeoOOFU6TpDBbTgcY03g7ki2HGXBMD39UGToHMR1dtokF8itUZV1wn6a79uIoEywEAN/h4dlQPbB3/I08/KJSPJWmh+0LkDZ3XU8VhUqSZcB8Tgo0lUPPTx8kj6wJKwTfuaRucSArvLuUGAB6QRGIMLi3OIuvtFPxBjG2IBaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rfv1BmPX4JoAsPZxOpByi7MBN547JGfR57xQ0+nQ9dc=;
 b=uy1vHVtsBxeaxyQSI7N5IBMSToG+bEOvjqwVJAQyknsDhH5IjHGh3dQRB38Itt4ZYOEUHQQF/giX4766UD3YLvAt4Hdra+oMMFFM4+H0NX5lR2ClFK9wExb7dVzPlyo2otfDvS0/ai1edgZj8nSDDtcyRDjeBfQX0avZh5nxR0c=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by IA1PR10MB5972.namprd10.prod.outlook.com (2603:10b6:208:3ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 08:35:35 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 08:35:35 +0000
Message-ID: <002da1e6-929e-3681-eb3c-1fea30c7adc0@oracle.com>
Date: Fri, 8 Sep 2023 09:35:29 +0100
Subject: Re: [RFC PATCH] vfio/common: Separate vfio-pci ranges
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
References: <20230908071438.86136-1-clg@redhat.com>
 <77ff66f4-ef7e-119e-40b3-d7352918166c@oracle.com>
 <519bd11b-3dcb-65fe-eed8-2138e4a81944@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <519bd11b-3dcb-65fe-eed8-2138e4a81944@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::19) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|IA1PR10MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e0ddd0-5abf-4c3d-6b57-08dbb046920e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xk0nnI6jl1rLT8jcY/sSVS//NQIKkif7Zj+JZJ5btLgY1kXRtJBkhAfeROfNC4PKDWeVuOf8OCJPBRMsnRqMDqKxnR/9eJiTEYv18CqpLOLYzOIaW9q0Ck3pj0ZI230yIgieg1vgLZZUXNH7nNGLWNMamXoh9hC1wVROBHCM5PuK/6XaXdrof3I544QQ3IVOYXwupBMM7NCysfM+9fCTLCJLJfzDRAQa+blfEdaw74QWyxAeuOWzCVOWSP0AwzurNejn2iCsafhZ7U50juSNYIw6YWwuJ6uMDEIGyjIiuTsUI2jeGbrNBxyBLDj5VvKiWAli4IagzCGlawi+BpqPzQ/ZsdWw2mbRsu+CvTzXgV9JusFw7PTWoVqGpF5pr/Sn3m+Z9yp75TywNnWaH0AeKrK2XBxtIDgWY8SRvkQrsSLPomQtSMrw79iMnlB/q5DZla/VTIy4ATpSj7Tfktp9s+pJtnAgENheMAPPyn5ecIR2OpIk1LlAtk5R7VSAtRjUxdVyqWVmgu80MSL6BuiGTROKvwwWgOaPO5hnQZFwJTKojVYVe57K0RNN+cLMRgZ93c15FarfxL8FfdvS+DniyMQ/tFcNqCg30zwfZsFw5IHoMiqyYK9k7YYInU+YYd/DHTkN33lI5rOuil7WmCIYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(186009)(1800799009)(451199024)(66574015)(2906002)(83380400001)(6666004)(6506007)(53546011)(6916009)(66476007)(54906003)(6486002)(66556008)(316002)(66946007)(478600001)(5660300002)(26005)(4326008)(8936002)(6512007)(2616005)(8676002)(41300700001)(36756003)(86362001)(31696002)(38100700002)(31686004)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1hkMy9JMFgyRjMwRXhMaTlpdFVsdncyVzBRb2pBcW1yRVBrRVNLbTVzYitP?=
 =?utf-8?B?YVVPdjJNcjFLNmNiNERZWXl2V2JIOEdQb2k4WW5PeEJVbjVLdjNiMVg5T0VT?=
 =?utf-8?B?RnlzV2pwTHo5eVJIQ2lRMzhhYlNZQVQ1RWtSTFovWnlSd3g5ZnJqNUt4bURC?=
 =?utf-8?B?T3JqaEZZZnFRMXhheHRRRTlGTUJqL3hNalVaV0lDVlpyM0Uyc2pwVHd2ZDVk?=
 =?utf-8?B?cko2NUpKcXArUTRsVk51cy9zUllXdDNCT3RvLzltVUhzK1NCOWxHNVN3WTNV?=
 =?utf-8?B?dkxGOE5KQ09Ndzd4emdjbEMzRmxpcFE5YjRKVi9wKys2RFU3dmZRYy9jenFO?=
 =?utf-8?B?dnJ6dTM2c2FWb1RadERrSmhOSUZ2TmNFNlA0L3REbFIxMzJBU20xaDF2OFpt?=
 =?utf-8?B?UVVjUHEwNFA0RVV2aEVjMXpYUmNRU3YzaXdJUEVHYkxpV2l0c3JGY3dNbXY4?=
 =?utf-8?B?QitSZVVoSGJLeHVrWEs5QjZTdmlweEUyTFBCVTdUMmRjVTZpZEhOQ1NzcElM?=
 =?utf-8?B?UUlRcjl3ZWYvVjhybUxaMm9mWndMT0luR3d6QmQ1Ulo1dGg3VzVhU3drdW42?=
 =?utf-8?B?cGJxdmhVK0hURDNDZ25od2hWYjZyY0IrSG1DTDRHMkNuT3d5V3ZYUkVxS1ZN?=
 =?utf-8?B?RkZzbUc3NWd5cVE5ckZTN1JyY2VWclAxRnNnME43Yzc3a3NnMFNQRk8vNmls?=
 =?utf-8?B?bStQcVptcGdMMHFZcDZvU1lOYWxCZFhqdlc1ZmpQZGxicklIZzVxRzBxZ3hm?=
 =?utf-8?B?WWZsM0twckhPWHV0dStJc2xhdUlwUW5IQ2VzUWVZK3JteG9zR0tIU0FHZlRv?=
 =?utf-8?B?c2ZaMmE4YUlQNWRQV2dvL3pJbGZZSi9wVmE2cUs1ZlpJT3E2eFUrMVdVYjNS?=
 =?utf-8?B?YUkzVFRjNFRIVjR5T1ppQWtqaXFIbHBBekRSNmM3MkduZHBhY3hNMVQxWFox?=
 =?utf-8?B?UWgyVnl2blc2UlpLMXhyaU95VEJJOFkydnJ3cUlKa2VYMGxLY0hKZUovTjY0?=
 =?utf-8?B?dVhuVlhCWFF1UFVGdExrQjlpUC9VN3hrc1FPYmVwWWYrRS9Yd0tMU2I2dnpS?=
 =?utf-8?B?OS9aMHVtdGNaZEtLeXc3SGZIdG1zMEFlcUhpMERnWThJRWNuTHNFYngwcEl5?=
 =?utf-8?B?QnE2bERTYkVudWlCbzVDSzNtczdnTWp1YUpoemkvWTR2elFyR2JUWVNpOWg4?=
 =?utf-8?B?Wm1mdlFOR25CcUdUR1NtUmZSMExFQ0grd3RTV3hvZ2lGZjZwakVENXBjQzAr?=
 =?utf-8?B?RVBZWUZGcTFSSEtmOG1LL3Y5MjFNWTdlRXlRVjFxNDZIVFVBR3ZSWGd5V0Nx?=
 =?utf-8?B?SFhsekVUajJEa3RzajVWOVYzcU1PdC9WMjZscDdNMlV3Rk5BMXV1cjhLMHJV?=
 =?utf-8?B?MlowS0VrcGVUSjFzZGhucVJxL1ZpV2lOQk5BZDBOZmQ0VUx6aVBTTFNmY3lE?=
 =?utf-8?B?Tlg2dWs0ZW4zLzZyS24xSFNXYnkrVjIrUUZrUjZmTDhwdU04SWdGRkwwaWF0?=
 =?utf-8?B?WlNHekJRV3RDbFQ2R3dFZ2dGRlYrRmlNamNtUE5MSEkwWUN5UmtRNSt1T2NW?=
 =?utf-8?B?SzVtNS9ZY0l3OCttYkl1UG54ZndWN1dtU1owY1lIdVA0aWFFeGszbWg3Y3o3?=
 =?utf-8?B?QVVCbWt1bTRjWU05SU5nVW5BZDNMREhUQ1NvT0VpMk1tVWlpV253am9NWGNi?=
 =?utf-8?B?RndLcjZ6T0UxeGE3bW5xQktYNW81bm5UUk1PUXRkcnNsc2VPam15OFFIV0lX?=
 =?utf-8?B?N3IxYXR2dFNJdUVSa0doRUNUblJvQUo3ams2Wm4ycnA0Q2JBcThFaittTVdj?=
 =?utf-8?B?MTZYdHVlOFJPcTVGK2RNSlUyQ1hsNnBGSmd5Z0oxanV1QmtsaW0xOEUvVS81?=
 =?utf-8?B?alN0SnVjWU1yaXpWVDdyb3R0dXV5QWoyYU15cGhGajhFRThEc0xDSmFNS00y?=
 =?utf-8?B?SVhsOTNKY0xJM1FKaW5GUjlLM3dyL0xLOExSTWw4V0lpbFMvK3A2dVczZURC?=
 =?utf-8?B?NHBFYi9URmhsTmdkTFhqY01xbGhBQXdCVENvbmQraFFJYmR0OWV2bHpYa3U5?=
 =?utf-8?B?eEdqZzNQYzFEZlZyaFVvdXNnRjRmTXA3ZE1tRzJIeG1GSjdCRk9ZbGZuZVgv?=
 =?utf-8?B?cnE3aE41d0o5M3NneThLQXBiOUQ0TlNKRjUrUjdCU1IwM2F1Q0VoZncvSzRp?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: blY9wPthSiem92J40U3D+e9XJJloLzg/3B0sd6Lx23mCNr/VF82rVu1cRN11BB0gdseHB00urgb2mVyvBnrzKDiqLLjXmxzYHpPKkTc9nATyb2zUW8XYR4HIM5FadR/DUqnzdYeMQylbV+kqdNAurPX483D0HQDaI+0hoLOIK4TWHniLVlN4Vbnqlmzd8MJZGLtJ+p5XdoCCdIRciWOmBbwupWszL+2npCS6yuYhEBQWPLB1BWP1jZsOyfZVy8wRMmsrzcp65ws10H8rtiV60gGKw0eEariVfv/4Dk1xoxEWM2bjv10Qefc4Qt95n0hiVHDYR+zlJF2DQk8OU2RAs9YJv7jrUaDEZKXFwofeJm4NVQP28xr+/WRQLvwavPeimKcj+8vtGlL9U5yOjHOfaLc8fDQIDMtqdcTfWafUPpraJAiHgZaHXlnFHytJ3gjDQPuiapuEopuY4QDmmo4moBV3O/mzOkZkHQ+qr6cecgaG5emoVvQ6/X2MeF2wUrYW+h5cxzJ07/qK/fwSHZfIZXxSdIQTmNRlFUCC5LN3yW0SfATV/HreTolEw5nWjov3Joo2TAd3r8Pc/XTgIH+2t64gqNeX2R/GewAVhlaJjp/wtZAg0y4+CuVC8DEe5Ze0A/ZcKA5w8WMcIpHnkTCpS1nF52ofSZ+L8JrpMiYQxROWU6NMJFFiIk/A3e7bpVbfQJilVqfpQl4TyLP2AONQL97uI/pMkWBOriD+DmmdLCwhstsV7yV+L66Y57bYZgCb0K+Ba8EyActg5DptC+TF0EO8EG+zcJmRL9UOOW5GTk8F4s0kEDyn4rVjcPBjENYF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e0ddd0-5abf-4c3d-6b57-08dbb046920e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 08:35:34.9493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8kyslcfSCJTuCRu0xEI+ExgtliFse1PYitDN24e3S6830kcQjvKjXadGIp/VAM3Bm7G+0dRjNYEKCEaX+Js/kh6YRMhY1CWNKFOzVl3nqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080079
X-Proofpoint-ORIG-GUID: YlUjZJa3JT5mmrj5ntbm3MFp46teXw7G
X-Proofpoint-GUID: YlUjZJa3JT5mmrj5ntbm3MFp46teXw7G
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

On 08/09/2023 09:28, Cédric Le Goater wrote:
> On 9/8/23 10:16, Joao Martins wrote:
>> On 08/09/2023 08:14, Cédric Le Goater wrote:
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>
>>> QEMU computes the DMA logging ranges for two predefined ranges: 32-bit
>>> and 64-bit. In the OVMF case, when the dynamic MMIO window is enabled,
>>> QEMU includes in the 64-bit range the RAM regions at the lower part
>>> and vfio-pci device RAM regions which are at the top of the address
>>> space. This range contains a large gap and the size can be bigger than
>>> the dirty tracking HW limits of some devices (MLX5 has a 2^42 limit).
>>>
>>> To avoid such large ranges, introduce a new PCI range covering the
>>> vfio-pci device RAM regions, this only if the addresses are above 4GB
>>> to avoid breaking potential SeaBIOS guests.
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> [ clg: - wrote commit log
>>>         - fixed overlapping 32-bit and PCI ranges when using SeaBIOS ]
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   hw/vfio/common.c     | 51 +++++++++++++++++++++++++++++++++++++++-----
>>>   hw/vfio/trace-events |  2 +-
>>>   2 files changed, 47 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index
>>> 237101d03844273f653d98b6d053a1ae9c05a247..a5548e3bebf999e6d9cef08bdaf1fbc3b437e5eb 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -27,6 +27,7 @@
>>>     #include "hw/vfio/vfio-common.h"
>>>   #include "hw/vfio/vfio.h"
>>> +#include "hw/vfio/pci.h"
>>>   #include "exec/address-spaces.h"
>>>   #include "exec/memory.h"
>>>   #include "exec/ram_addr.h"
>>> @@ -1400,6 +1401,8 @@ typedef struct VFIODirtyRanges {
>>>       hwaddr max32;
>>>       hwaddr min64;
>>>       hwaddr max64;
>>> +    hwaddr minpci;
>>> +    hwaddr maxpci;
>>
>> Considering this is about pci64 hole relocation, I wondered post-reading your
>> feedback, that maybe we should rename {min,max}pci to {min,max}pci64 (...)
> 
> yes.
> 
>>
>>>   } VFIODirtyRanges;
>>>     typedef struct VFIODirtyRangesListener {
>>> @@ -1408,6 +1411,31 @@ typedef struct VFIODirtyRangesListener {
>>>       MemoryListener listener;
>>>   } VFIODirtyRangesListener;
>>>   +static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
>>> +                                     VFIOContainer *container)
>>> +{
>>> +    VFIOPCIDevice *pcidev;
>>> +    VFIODevice *vbasedev;
>>> +    VFIOGroup *group;
>>> +    Object *owner;
>>> +
>>> +    owner = memory_region_owner(section->mr);
>>> +
>>> +    QLIST_FOREACH(group, &container->group_list, container_next) {
>>> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>>> +            if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
>>> +                continue;
>>> +            }
>>> +            pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>>> +            if (OBJECT(pcidev) == owner) {
>>> +                return true;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +    return false;
>>> +}
>>> +
>>>   static void vfio_dirty_tracking_update(MemoryListener *listener,
>>>                                          MemoryRegionSection *section)
>>>   {
>>> @@ -1434,9 +1462,14 @@ static void vfio_dirty_tracking_update(MemoryListener
>>> *listener,
>>>        * would be an IOVATree but that has a much bigger runtime overhead and
>>>        * unnecessary complexity.
>>>        */
>>> -    min = (end <= UINT32_MAX) ? &range->min32 : &range->min64;
>>> -    max = (end <= UINT32_MAX) ? &range->max32 : &range->max64;
>>> -
>>> +    if (vfio_section_is_vfio_pci(section, dirty->container) &&
>>> +        iova >= UINT32_MAX) {
>>> +        min = &range->minpci;
>>> +        max = &range->maxpci;
>>
>> (...) specially considering this check of making sure we skip the pci-hole32 (as
>> that one is fixed)
> 
> yep. That check above might deserve a comment also.
> 
> Could you resend please ?
> 

yes. This is on top of your vfio-8.2 branch right?

> Thanks,
> 
> C.
> 
> 
>>
>>> +    } else {
>>> +        min = (end <= UINT32_MAX) ? &range->min32 : &range->min64;
>>> +        max = (end <= UINT32_MAX) ? &range->max32 : &range->max64;
>>> +    }
>>>       if (*min > iova) {
>>>           *min = iova;
>>>       }
>>> @@ -1461,6 +1494,7 @@ static void vfio_dirty_tracking_init(VFIOContainer
>>> *container,
>>>       memset(&dirty, 0, sizeof(dirty));
>>>       dirty.ranges.min32 = UINT32_MAX;
>>>       dirty.ranges.min64 = UINT64_MAX;
>>> +    dirty.ranges.minpci = UINT64_MAX;
>>>       dirty.listener = vfio_dirty_tracking_listener;
>>>       dirty.container = container;
>>>   @@ -1531,7 +1565,8 @@
>>> vfio_device_feature_dma_logging_start_create(VFIOContainer *container,
>>>        * DMA logging uAPI guarantees to support at least a number of ranges that
>>>        * fits into a single host kernel base page.
>>>        */
>>> -    control->num_ranges = !!tracking->max32 + !!tracking->max64;
>>> +    control->num_ranges = !!tracking->max32 + !!tracking->max64 +
>>> +        !!tracking->maxpci;
>>>       ranges = g_try_new0(struct vfio_device_feature_dma_logging_range,
>>>                           control->num_ranges);
>>>       if (!ranges) {
>>> @@ -1550,11 +1585,17 @@
>>> vfio_device_feature_dma_logging_start_create(VFIOContainer *container,
>>>       if (tracking->max64) {
>>>           ranges->iova = tracking->min64;
>>>           ranges->length = (tracking->max64 - tracking->min64) + 1;
>>> +        ranges++;
>>> +    }
>>> +    if (tracking->maxpci) {
>>> +        ranges->iova = tracking->minpci;
>>> +        ranges->length = (tracking->maxpci - tracking->minpci) + 1;
>>>       }
>>>         trace_vfio_device_dirty_tracking_start(control->num_ranges,
>>>                                              tracking->min32, tracking->max32,
>>> -                                           tracking->min64, tracking->max64);
>>> +                                           tracking->min64, tracking->max64,
>>> +                                           tracking->minpci, tracking->maxpci);
>>>         return feature;
>>>   }
>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>>> index
>>> ce61b10827b6a1203a5fe1a87a76d96f25c11345..ab52c6bb7f0c11e51fefef231c108d0c9381547e 100644
>>> --- a/hw/vfio/trace-events
>>> +++ b/hw/vfio/trace-events
>>> @@ -104,7 +104,7 @@ vfio_known_safe_misalignment(const char *name, uint64_t
>>> iova, uint64_t offset_wi
>>>   vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova,
>>> uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64"
>>> size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
>>>   vfio_listener_region_del(uint64_t start, uint64_t end) "region_del
>>> 0x%"PRIx64" - 0x%"PRIx64
>>>   vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t
>>> min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64"
>>> - 0x%"PRIx64"]"
>>> -vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t
>>> max32, uint64_t min64, uint64_t max64) "nr_ranges %d 32:[0x%"PRIx64" -
>>> 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"]"
>>> +vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t
>>> max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci)
>>> "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"],
>>> pci:[0x%"PRIx64" - 0x%"PRIx64"]"
>>>   vfio_disconnect_container(int fd) "close container->fd=%d"
>>>   vfio_put_group(int fd) "close group->fd=%d"
>>>   vfio_get_device(const char * name, unsigned int flags, unsigned int
>>> num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
>>
> 

