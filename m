Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D39378066F1
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 07:06:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAl1G-000881-Uv; Wed, 06 Dec 2023 01:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rAl1F-00087o-83
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 01:04:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rAl13-0002Fe-Hl
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 01:04:24 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B63n0rf014067; Wed, 6 Dec 2023 06:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GK7TeGttNbeLF1bJoSlxOFXlaAPiZuqa+MEn2GQGkO8=;
 b=gAKevteTvmpUoq7FoVLb0oiClzBRCb8Lk1JnyFGy4fwgVRVSEd5TjtnQNCxKosEUkLxL
 ZlE2kFVQ5Crdi5iBDP2r0xVQs5Nt5SinIg6m5qDm4d29xqPIsCaUILqBtjCLOVcJYBBx
 HgxywX2uqI62W155sLPaknYyB4r/aCd4mWxuKk7qE4aGAp7CnE2GEVvp10U10HA96iSX
 qBuMknQC0/b3+K1KaGnXrc/ZtYZ0rNjU+g2DVQWQOU1GHvd9KZuS1FOSzPjDzhLRfEAG
 z2oo7IVevHiFrGbCUVRZnnQYgHr7BpGeUeof73QiJaim+kdGdvCOwFnyFg2C7SPTSfQo GQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdrvgg2d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 06:04:09 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B650AfU035307; Wed, 6 Dec 2023 06:04:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan9bu22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 06:04:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNlpEsMW1o9cxjkpJBJ8hXs5TQlnZnTGsC9wVFKuBQJsyqu/I03LQS6jJ3/vd2jH7D30j4kn2WcaIycE9gQLJ/AzIFr0vNpoVWi+6GklOWAYNW9trJQ8dmTkTPVFZui6yrOY/oQMGbaS+u2k9VnoNCSguNKTtf2mTQkYewcoYsGHOSHdVCv9xRqanp5YzSGGYA5hOZTU2iBh95aERom7sGfjiuiCm5kLiJcB+p7i5xqAqhBQNQx8uBq6KrQ8ojiHxSDvEPsYGa3mkLWnNXxh+o+ad4yY4TdJ4ggRf+wFxyxv5/yRCxNgnTXFERAFtN+6qtCBFRZPkHfjAclZG9wSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK7TeGttNbeLF1bJoSlxOFXlaAPiZuqa+MEn2GQGkO8=;
 b=KNwdMP7OGHzAsFkvhdEzmSzED38btUbbSvpbKJ1Yj36/MMH2rDI56KNMZZy2pnkIm3uJH+XJ3QAPD+8aUWgIGNoQrrJiJSGcQ2tjR5qYW3B9ALKwzPpoe0fBrAYZjXm/YLq9ykrCeybVfHGF1+hFxM5AzMzxkhS2+VmicNB8YAwmDuohRnNan+GFrnbmLKl4rAXHhPpj7imwjcqt1SNdoU0mu4y5p2q2xICqad6UpmcLzjeQn+5zhgiByQkc+cECfgITvFG0Q0v0fzFaVTrJcFVbOjC13OpY/hlTnCo3xb2KQspewhfaiBaV+9XvnDgKxgYwKxiBoZr2uyQM8JLrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK7TeGttNbeLF1bJoSlxOFXlaAPiZuqa+MEn2GQGkO8=;
 b=wnPmyebKB1Tkr/svPltIgYWRm2kcvgZ84cq5pwaq8kLOSNSUTxcBECsTj23jNcY+sm0P3QqVQv1jF4E9/RKXlGXOvRoKe0nRX/wT0dmUApGCOyAqwcVPHvRAZGmEX8jCEidyZVBQrWMbDivZWq0O+4KSDcLKX9dcG//nCw9gPjw=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH0PR10MB5730.namprd10.prod.outlook.com (2603:10b6:510:148::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 06:04:05 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 06:04:05 +0000
Message-ID: <2da28fe6-4019-4a74-a5c5-e335414162aa@oracle.com>
Date: Tue, 5 Dec 2023 22:04:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9.0 04/13] vdpa: move shadow_data to vhost_vdpa_shared
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20231124171430.2964464-1-eperezma@redhat.com>
 <20231124171430.2964464-5-eperezma@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231124171430.2964464-5-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0200.namprd05.prod.outlook.com
 (2603:10b6:a03:330::25) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH0PR10MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fa7a20-dd16-4562-8fab-08dbf6212715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LdIJfntpeGu+LynXGoCX6wqjgH0a3qgGm0keTIE5W3JubO9Jj6XBCtwj1TgiQL3lsqND/vdUGAUf2WsB24wRIwXnEjA2WgDUVMdimBtP58pkNkmXysXUSGy+Y4a3PZx3g2E7KwDgj2OovKOwkN9H4j2wmPS3tWr2yJMjwHJcjrz0NjMuOSyNTURuurkT8C9KOdIokPClLL1Wun0d4IgDL3STssxqtT/Z1i1ncAGkYQdVGGfb+cj83OQFTpCrZWba+uc/4i6crZe+gD8e5SNTw4hrQQdY+rxXO808OTU081esK2LKGtOIrXprvNXycO6EkeNYHztzseiynLSIbYrxalAL9Woh187AHc+CbZazwJNuMiILdunlAta+VG7O+M5BSvLjs07kwWQQ1/G0dP3VeYdR8khUFKRYR9L+AJqZZvF9UQNBgL3gfCfpXd06RSD6vNbgnsMuobEZZAi3Ad2+8jeQHt5pCDe5ruvOxwSKund/6TkyukY7PelhGuWCuALN5imVez005n9NvOjIlPOretpIhlswPuxeR2wo2/3LiQ+C/ToqYWqMvUCRnXPgJdYiK2xPx2rgYdGFFsJmNvHcwE0ljsofYe6mG0m5PZeFC5Oab+KSTRvxHn9fB6h+829Ec1uYllW/u/qYjSLBdysIfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(6512007)(36916002)(53546011)(6506007)(8936002)(2616005)(6486002)(6666004)(26005)(54906003)(66556008)(66476007)(66946007)(8676002)(66574015)(4326008)(316002)(83380400001)(7416002)(38100700002)(31696002)(478600001)(36756003)(2906002)(5660300002)(41300700001)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czl6eWpCMjNwU3hvNzhnQ0UrRFVzRDY4ampxT0gzakJ3WktpZE5rcVREa0Q3?=
 =?utf-8?B?U3VxZDZ2WTNWdXJ2NHhSM3E4ZkRZZGVXdGVaNkVsU05XNWdBRGxEZk5GU3U1?=
 =?utf-8?B?UU9vUE52cTh4ZjRwUHRNbHN0YVlhSTZtVEtiSlhYRHBDUGpwNXhkaUlpMmp0?=
 =?utf-8?B?QlZZZ3BLMkZIdkplV1A4REZLOWNRTTJibjQ1d1Z1OC9FblZwWHlLODU0bEdD?=
 =?utf-8?B?YTFEWHBwdFFUclU0T1JTN2MyemNsZ1dBVTIzR0ZYZTFmRXpIVEtqTU03cXJM?=
 =?utf-8?B?ODlXODArUHgvOFEzZ3FUQnhYOGx0QmJhS0hKVndWSUFRVW1nMFJYZnE4MS9V?=
 =?utf-8?B?TFZmcG1IKzFzblIxSUd5cXU2NTkrVGRYQ2RZT0tmS1ZxWldpaHZKOFhWOXdl?=
 =?utf-8?B?KzZMR3EwSGVpMU5VdjRKbUVSNDJJYlBaSUZDSzhKdHRXVVJNZzZlSHdXRjQx?=
 =?utf-8?B?Zk4ybVVOT3ZGdDYwc0tERDIwSGRHL2ZFS3YrZkxYVS8wcWhGWG9RTWdqUWhD?=
 =?utf-8?B?REl2SVlwaGE4NnlhdmxDb3IzQ2R3azhtKzVWaDN5Rm90OTFqTFY0Q3RCWGFL?=
 =?utf-8?B?S3gxUHhVdTA3UkpnM2ZIRURtalR6MVRrTG52SFJ3ZzNucmlJWDRkNHZlTXl6?=
 =?utf-8?B?YXdQeGpLK2w2V1NsNXF4UHNPUHZOWUJDWngxQk9NdkRuVzRYWWE5UVM5R0tV?=
 =?utf-8?B?clZTR1lTeVJjZVlSSzkzb2luV1REejc2NTNTNHM0dGxlYlozQ1ZrekFoak1W?=
 =?utf-8?B?cXg5aElTTldneFZMdE0xWFZVc2JJbVk0ZVdFOTk3U1JualRyMU5PVThnWkIx?=
 =?utf-8?B?YXlXZEhJV0ZwNUFZWmtuTFdTOXNhRnl6U3F5ZTZ1cHBORXloK1J5WDhONUpT?=
 =?utf-8?B?K2NpOWk4UWhob3ZoeWp2KzJyZTk3NHRJTWQ2bWVmSnlPZ0lXekVYNE9yaG1v?=
 =?utf-8?B?d0s5UEJxNmIvWHU5QndjR2pDanlHa1BkcnAzbnp6RE56M2tOYW4wTk1qTkkx?=
 =?utf-8?B?dVBCbzFmb2lZU1licVA2RnBjdGxFNVhBZWtsbTV2Z1ljQXdEbGFiRWkxUHhr?=
 =?utf-8?B?cEhzZW9pdUk4NFozYTNla241YzI0Q3ZDdzN4c2VnRkErbHAvaDc0RHVGMFpB?=
 =?utf-8?B?UHdnbUQ0TFZnT0dudnQ3bnRNQkJQUWxIeDlvNGVpS2o1RXdyZ0NlVThUWTVH?=
 =?utf-8?B?S2NzbU9JM1RQZkcxend4UE9oeC9UQnUwQ3NOcWVyS1VpYlRDcktzd1VZcTZN?=
 =?utf-8?B?UThyRWJCbHl0TUVrRWtsYjNwNHl2bVNpY0FJN2dhK3R6MGtBc2pSTmtiUjhu?=
 =?utf-8?B?MksyeXhEZVlDQjBHODB5RUgzRXRHN0k5Mklmb0V3OVhCMFJKQzFpOVZQWGVZ?=
 =?utf-8?B?cU81T3A0d1JQZ3FZQ05vR3k0T0hCUnAyckFCMkQwenpXVDRaV0ZJOHArMld3?=
 =?utf-8?B?Vm51UGYxSC9rZGNHdk1SbCtwT3dxQUJ6ZWlQQ0o2cUhJWHRVb1lsYVVVMlFt?=
 =?utf-8?B?b3czM1RmZGVHSUplTnVvSGVUSGtBQ0JUSUhvRmhmVGYvdERlaCsycmdIWVJt?=
 =?utf-8?B?dU51dFZwTnRuV0JQeWo1dDU0TnB5U242b3BJMnJDenk1WElCNllqUkVOeW8y?=
 =?utf-8?B?a0xYaG85Y0M2L25HVjllQVRJemlTbzlsM1J0Q2ZrdjZ1bVhUZG9wRkZZbmtR?=
 =?utf-8?B?T1Q3dkh6Z29yOG56bEQwaU1tdzNFcVFSd29mYlpyV2tib3NTMytIR3RwNWhV?=
 =?utf-8?B?Qkthb0ZBL2xFOXY5a3l0Qk03MTg2ZXBKNlV2amI1Q0dNazdJTVFuMXU1bFBF?=
 =?utf-8?B?bnNPeDN2amt4UEpXbDBvY1BNcFVhYlRmU2pPdWdtYm5PUCsreTNSc3c2WkpO?=
 =?utf-8?B?RXd1WnlOT0I0V2h5WkExcGFtbUlSdjBTWlFmQ1lwaDJrRC9sdUFzNEN0cVpt?=
 =?utf-8?B?bnI5d3NKT2FLRnJ4Q1BkL2tjM01BM0szcU03R0xPQ3JhVVIxa296Y2xzNkRN?=
 =?utf-8?B?TkRuRk1hY3NPdXhRZ3BzMmpzR01YUHBwNWtPUmFLc1EzcGNmb1M3OUZ3UGJs?=
 =?utf-8?B?NTAyL2tTZUFmVEgrSWhtMDdCd05pK0dCSVQwY1pwQzdxRDZGeCtrK0x0bExx?=
 =?utf-8?Q?zPqLL7D19WlOKyQdOXf17nXRU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1uTpklzS85AkvVgWa7070me++1RmayxCpj3JMkzDtcsjyJX+7qecdsXnkFLkavuxhH50NokbR/obVcDyqe2+KEdxH75x0xCTM/DYrKud8XKBKGediWfbNVaD1FA6etnvhWbhBXDaivsK4a6orSyv5P5LSukKTnOIllOORIV6nToVyk1p5KEH77kMUeye0HYynwoalhMIFeQU8/LjchUUujarEqLHZMod6KnlU/CYjImoYcJfATw2iVz6fGhP/ZcPfmjlVkYJM5+bUeHZGScyMtgMj/9xTIgE6bCKdA5l6n9+Yp88d3f9I2fwuYBAzwoAblhwiDvLLPF3W0ROLQhW4fZXvCgJx15GkjPlfuQWqic/R3+Y7P0ddQkHXxz+zCunuAaT1+Gmyf8GAXC/SeERPOXiPvIz37s+fJPxkZMDfu6GXzBudoykBtDNO2ZYb0NCf+0Jer0QHlOgajWoiVd9XYyJ/q4ALj7rKtt8ciPyaZ5MVGQqz3BWK5wBtBo85PiTD90iWgyB7atWcrhkLO69l8ddeuN53pJz+rpxlYoXiui/o4Iur8hTOSa5Ng31wb/877/7tdwIvLjRLDUCAFZemYdoCMSbMf/lkh0wskLhTmmpAbD+/6UQjqoJKw1qjiYZ5MB5Bto9xzxyEWR5WwiCtnArCSyjTNerK3k8AuANjzduhnfTlB80uBw/X1SUnQhXTMzgnWXvSTNYGPwahyxM990mq6e+JF7K/urV2rEGYtZ5cve4FRlU20qdjXw+zVJs6a7tCqrbPO6JAvRSoROR9bcJa+6/9j1rlrEpL5Nek76ONRFtuVk/Yu7dprbuWhPT42kkkBSJSugEcLXbkbP9j5NxpzuUDXRnNsZA3OzIfDJqayjorDItuNa/y59wLSoj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fa7a20-dd16-4562-8fab-08dbf6212715
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 06:04:05.4364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7loUZlFDtcva9zHJH/7Fd8ST3FJ/89pl5q7lfK647iUpAXo8nsAY9AQv93se6n+9cTHf/0FP798aa+fOlbrxnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_04,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060048
X-Proofpoint-GUID: AqFSzCmO_XaZJc9RtGMBD_W600vFc9rF
X-Proofpoint-ORIG-GUID: AqFSzCmO_XaZJc9RtGMBD_W600vFc9rF
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 11/24/2023 9:14 AM, Eugenio Pérez wrote:
> Next patches will register the vhost_vdpa memory listener while the VM
> is migrating at the destination, so we can map the memory to the device
> before stopping the VM at the source.  The main goal is to reduce the
> downtime.
>
> However, the destination QEMU is unaware of which vhost_vdpa device will
> register its memory_listener.  If the source guest has CVQ enabled, it
> will be the CVQ device.  Otherwise, it  will be the first one.
>
> Move the shadow_data member to VhostVDPAShared so all vhost_vdpa can use
> it, rather than always in the first or last vhost_vdpa.
>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
> v1 from RFC:
> * Fix vhost_vdpa_net_cvq_start checking for always_svq instead of
>    shadow_data.  This could cause CVQ not being shadowed if
>    vhost_vdpa_net_cvq_start was called in the middle of a migration.
> ---
>   include/hw/virtio/vhost-vdpa.h |  5 +++--
>   hw/virtio/vhost-vdpa.c         |  6 +++---
>   net/vhost-vdpa.c               | 23 ++++++-----------------
>   3 files changed, 12 insertions(+), 22 deletions(-)
>
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
> index 8d52a7e498..01e0f25e27 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -36,6 +36,9 @@ typedef struct vhost_vdpa_shared {
>   
>       /* IOVA mapping used by the Shadow Virtqueue */
>       VhostIOVATree *iova_tree;
> +
> +    /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
> +    bool shadow_data;
>   } VhostVDPAShared;
>   
>   typedef struct vhost_vdpa {
> @@ -47,8 +50,6 @@ typedef struct vhost_vdpa {
>       MemoryListener listener;
>       uint64_t acked_features;
>       bool shadow_vqs_enabled;
> -    /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
> -    bool shadow_data;
>       /* Device suspended successfully */
>       bool suspended;
>       VhostVDPAShared *shared;
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 2bceadd118..ec028e4c56 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -353,7 +353,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>                                            vaddr, section->readonly);
>   
>       llsize = int128_sub(llend, int128_make64(iova));
> -    if (v->shadow_data) {
> +    if (v->shared->shadow_data) {
>           int r;
>   
>           mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr,
> @@ -380,7 +380,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>       return;
>   
>   fail_map:
> -    if (v->shadow_data) {
> +    if (v->shared->shadow_data) {
>           vhost_iova_tree_remove(v->shared->iova_tree, mem_region);
>       }
>   
> @@ -435,7 +435,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
>   
>       llsize = int128_sub(llend, int128_make64(iova));
>   
> -    if (v->shadow_data) {
> +    if (v->shared->shadow_data) {
>           const DMAMap *result;
>           const void *vaddr = memory_region_get_ram_ptr(section->mr) +
>               section->offset_within_region +
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 7be2c30ad3..2376d9989a 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -290,15 +290,6 @@ static ssize_t vhost_vdpa_receive(NetClientState *nc, const uint8_t *buf,
>       return size;
>   }
>   
> -/** From any vdpa net client, get the netclient of the first queue pair */
> -static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s)
> -{
> -    NICState *nic = qemu_get_nic(s->nc.peer);
> -    NetClientState *nc0 = qemu_get_peer(nic->ncs, 0);
> -
> -    return DO_UPCAST(VhostVDPAState, nc, nc0);
> -}
> -
Fine with the removal as the only caller is gone. However, in my series 
I will resurrect this function for fields that are not shared and vq 
specific. Not sure there's sort of way not failing the build while 
keeping unused function around.

>   static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
>   {
>       struct vhost_vdpa *v = &s->vhost_vdpa;
> @@ -369,10 +360,10 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
>       if (s->always_svq ||
>           migration_is_setup_or_active(migrate_get_current()->state)) {
>           v->shadow_vqs_enabled = true;
> -        v->shadow_data = true;
> +        v->shared->shadow_data = true;
Noted this shared shadow_data needs to be set only once. I will also 
change this in my series. No actual code change is requested.

>       } else {
>           v->shadow_vqs_enabled = false;
> -        v->shadow_data = false;
> +        v->shared->shadow_data = false;
>       }
>   
>       if (v->index == 0) {
> @@ -523,7 +514,7 @@ dma_map_err:
>   
>   static int vhost_vdpa_net_cvq_start(NetClientState *nc)
>   {
> -    VhostVDPAState *s, *s0;
> +    VhostVDPAState *s;
>       struct vhost_vdpa *v;
>       int64_t cvq_group;
>       int r;
> @@ -534,12 +525,10 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
>       s = DO_UPCAST(VhostVDPAState, nc, nc);
>       v = &s->vhost_vdpa;
>   
> -    s0 = vhost_vdpa_net_first_nc_vdpa(s);
> -    v->shadow_data = s0->vhost_vdpa.shadow_vqs_enabled;
> -    v->shadow_vqs_enabled = s0->vhost_vdpa.shadow_vqs_enabled;
> +    v->shadow_vqs_enabled = v->shared->shadow_data;
This new code looks fine.

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>

>       s->vhost_vdpa.address_space_id = VHOST_VDPA_GUEST_PA_ASID;
>   
> -    if (s->vhost_vdpa.shadow_data) {
> +    if (v->shared->shadow_data) {
>           /* SVQ is already configured for all virtqueues */
>           goto out;
>       }
> @@ -1688,12 +1677,12 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
>       s->always_svq = svq;
>       s->migration_state.notify = NULL;
>       s->vhost_vdpa.shadow_vqs_enabled = svq;
> -    s->vhost_vdpa.shadow_data = svq;
>       if (queue_pair_index == 0) {
>           vhost_vdpa_net_valid_svq_features(features,
>                                             &s->vhost_vdpa.migration_blocker);
>           s->vhost_vdpa.shared = g_new0(VhostVDPAShared, 1);
>           s->vhost_vdpa.shared->iova_range = iova_range;
> +        s->vhost_vdpa.shared->shadow_data = svq;
>       } else if (!is_datapath) {
>           s->cvq_cmd_out_buffer = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(),
>                                        PROT_READ | PROT_WRITE,


