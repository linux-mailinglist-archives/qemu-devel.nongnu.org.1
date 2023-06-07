Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF8F72627F
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:14:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6tv0-0000hW-2W; Wed, 07 Jun 2023 10:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q6tux-0000gu-EQ
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:13:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q6tuu-0002V3-VA
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:13:43 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3576JojT017995; Wed, 7 Jun 2023 14:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=oKO67H5rx3Uk+dKYy0kwivNKX+8WUL24HKEs9KCvK+o=;
 b=Rs8hjKUqnz2fgYuqECe4e3hAYueXyF3TChuouMDaRJq4VzU4v6CRNfVuOpOOhawEDSBO
 qPs2psFM4P6iw7wojkTowJjDvllKZb/Ko96xPDK4XkltXAnHQtrF+sTWt6OfkawQ6usN
 eXch+sXzNbfRcuNsHWvBBz0HVpyXF1Vzn3IqqtEDngSjui6KDCx8deEUPYY5f5Kk2DGu
 xy8xTqeE7JvvVoYwHTH994Lic8cFJ+/sCl4E+asBSWGIXrECcBT6utJErWJ6JPzYeBN8
 yLrKIjLARuIRgTp7ReLymFp3AbyBJSxVN5X4FvRYrM51cw4o+Rq9z6coDXpCHuH2rJ6p kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u9upv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 14:13:37 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357DoMBu003059; Wed, 7 Jun 2023 14:13:37 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6kac62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 14:13:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7H/vbH/ISd51zluzVRtIT3+MI8nwFE4wch/pDiFnSpJQAP9/aDby4Lwbh9b7uoIfvwgw8ccAyERFqdQra4WaRQJM3mqlVNLKm7uy++CeXV/LN0vlQj6kx59gK3v+A63WLavWKts/1wy4dA0azT7Nr81UV2BhoqBXqB7DRZYVyh1mRyMME14fWL+GIXnB10StRxTt3tCl28T+dqL+T358U/Xukpm1IIIiMEecPTov5Irg90GpytOU8oV1I3/RXnhu+CxbBrVZtpqoX+XYQ3HkdioiZjf84e5jbIHs7CivTu2By9NKDzaaSu1qsdTwrWySVenk+/gT1kpwY0iDvEy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKO67H5rx3Uk+dKYy0kwivNKX+8WUL24HKEs9KCvK+o=;
 b=kV61XJgVkRpbbp5wqxRhGfMDSZ0jLW7EAtRAFbM2he+miNhJAo46Y87ZbX7CC7zKtVUY3BoQgcohUbBnv8yVxnq72I+o4kC/QmQmP6e3CcwKzAG07HM+4E6wKbSn+BChjbzFqTCMP919RV5lMzJE3otfw/CFSXcqOxxsrepPCOIzCpJAR2f1085fto0XqD2D5rQlDS0JLxIMwNP73MerFuYb6nP0sI0Vbhhv8VMXgkSMPe2SkBHRx7o575wUWkX8GF8EgJ6VSFUyUUW0LZ1I48RiA+nOd7+ZED5hWEEKuty8a5lIJHHhChFNENPOqyYspszfLyBgnvnrkQ+ESpa8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKO67H5rx3Uk+dKYy0kwivNKX+8WUL24HKEs9KCvK+o=;
 b=Y6NEoP/T0tsc0eSHEpYznykItQSpD9/JTNsw+pECIIEyIAiIC46hHaeDwYy2KnfqD0z4qVEHD1sBgCUdXHTUjWTeY6ZlObvk5Gwt1bfo9qjut9hXdlI2T99sR7MFams9MDtDVTDkMMEzw2wM6z2zJHQ66X3bUCFY84KsVmvgMns=
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23)
 by PH7PR10MB7108.namprd10.prod.outlook.com (2603:10b6:510:27e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Wed, 7 Jun
 2023 14:13:35 +0000
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120]) by SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120%3]) with mapi id 15.20.6455.027; Wed, 7 Jun 2023
 14:13:35 +0000
Message-ID: <e3e8a8c1-2668-c597-7abb-2fb70e788c27@oracle.com>
Date: Wed, 7 Jun 2023 10:13:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2] migration: simplify blockers
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <1675796593-235541-1-git-send-email-steven.sistare@oracle.com>
 <Y+Ku/zQOoFogmx0j@x1n> <0a757102-0378-db4e-d889-9872f3a2d529@oracle.com>
 <Y+LC082KQ3Gdaghp@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Y+LC082KQ3Gdaghp@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To SJ0PR10MB4686.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:EE_|PH7PR10MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: a153ea47-1b70-4ff6-102d-08db67616183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oA1o3/PVupwBMA+UAFGwq7NYIkGqwcpDc3fy01sPjOHfk8491Bd50oTY3clkK/MMqNttKZHMx4ODzBWSl73OWbFcJRsTxk2sh/iogUwvshOi3cgBAhKNi2CU0cVcqJfc0E4TJbnwfpil6lQXsHOQuAIOzyVkpthSi+sIqo7gb72AOxPHzywliMsPMCxyfNJolgeOLrwjmXRkLL4nifMN2JpflPKFweoxeb5dVfawKR8pUgV1vrh9/240lJ2OZkKKO94eThMZSbNbfQ+w3EDfzCA40zO7X2qqpDq4I2iS1FqHyMWQGENPCVldxraI9cesl4DpoYT6v4To9wQakrBntKkalbnHargCfT1l3ZP3aDbRCsk9JYJsbZGPwaBGQRSVBAm3zT3CB0ezW0DS781VdcgscVOQCnKxuRR66xiw1qU/qqOitkIU8iHGTAP/QZk6lQC7VJOi0V6Y+FGx9RamVJCa5uv6WcbeHEI3ouU/FBGW+HEELGZBIjHZRnpIsJE2yuCFxvqLFQbLLSnaQdCvII1rE4+U2Sjq004H7FWP8H6ifmEdO7hPbT7369dRiqouSKJdrASmfMwIN/5HWjYtb/ow6q7A0F3uFJQpeemFTVH39yABkOtv9iYfPmE+7PnufJeRYyUYXql+TaHa+cg0bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4686.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(36916002)(6486002)(6666004)(4744005)(2906002)(66946007)(66556008)(66476007)(36756003)(54906003)(38100700002)(5660300002)(44832011)(8936002)(8676002)(86362001)(31696002)(41300700001)(6916009)(4326008)(316002)(478600001)(2616005)(53546011)(6512007)(26005)(6506007)(31686004)(186003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2lnUUdLRU40ZzExeGM1QXFoY09Tc1BHLzZrSHZwZFFzT05wK2txWENJZzlL?=
 =?utf-8?B?c25FYldvWjA2K2hZbDZZbkxkS2pTSjhXNGZuaTVUT0VDa2xHQWI0bUJSbS9B?=
 =?utf-8?B?cXlCdU5tRlJxc2ttK3BncEpQT3lKTXE1WnFNdWc2alFNMTUvL1g0YVBNSEM1?=
 =?utf-8?B?MjlSZitNNEh3YTZVdWpYdWM3K3p3Qk53WGZrdWRGaG5udSt5Q09VYkVOWjVJ?=
 =?utf-8?B?dzhNNFRHUGszZ3BmUDBhTWtCZm1YVlNnaHpZWWhsTUNzenlCYUZQUTNZYitr?=
 =?utf-8?B?L0FuUUVyRVY4UXVCNmJ5dkRmbVNGdk5oUFp1alkwRVZlZk13MnA0bDYvaG84?=
 =?utf-8?B?K0lsZTV4d0MwMW1LKzVYN3lVaHRQV0lZbXBETEYzRXMyWDdlRzhsc2tSU1N5?=
 =?utf-8?B?a0FrMHBQY2xNUms1cjh6K0J2NnZ3YXV5TG9ydks1QllXRkNTaXhtUTU1SHF1?=
 =?utf-8?B?cEUrOTNRZDFoV1UwTFNtU3l4TjE2RzlLaXg4cFNOVU5IeTVuaE5Cak1RWHRT?=
 =?utf-8?B?SXUyRXZ3QW05aTcxeEtiV3Z4em04M3AxZ0ZEZ0l6MGVHbDFVYlJOMzlBSVEr?=
 =?utf-8?B?MVJROU1KWkVmaHZ3Wkh5bS9VZGQwWlZTU3lqbEl4NWFWVW0wc0RkTmc4djV6?=
 =?utf-8?B?L1RmV1RZZXQzdnptZGk1bnlLaFR3cVhvbllGamxCUkt5b3hkeGJCNU8rVTR0?=
 =?utf-8?B?enhvZWROSjJQenlCNFBzZG04Z0ViMVN5ajBUeW8yKzlJd1pwaE1LTTMwazlq?=
 =?utf-8?B?K0VKU1A0VXhUNjRGUlVsSjVqMzVCSnZUdDFDUXNKN0dzK0RlMWd2YTdZbTZW?=
 =?utf-8?B?QWo0OVBjUE5lcVppUEUzWFhTbGl4YjJDck9mdWtwS1UyOXVXcVl5aXFPbUFx?=
 =?utf-8?B?TUIybWJNeUc2Sm9GNFBzRFBhdTFEOC9OWTkycE5rdU1HSFgyMUVZdnl1T21X?=
 =?utf-8?B?aUtvR0ZIWFNST0ZMMGp2Z1Z1aU9sZFh5M1pyZ1JhbVBHTStjTzI0M2tYWXkr?=
 =?utf-8?B?ZjNhcStSbnVYelpIU05uckUwMzN0ejk3TjhyTzJiNlNnd3FQNS82NlQzdzE1?=
 =?utf-8?B?MldtOFdJazEyUkZyMGtrWnhuVCtQZlRnbmZBV1VsWjRQa1UwOFJlZWlYWVhx?=
 =?utf-8?B?MlZ6M2FTSFU0Z2dmaGg4QjhsaWo4ZE05U0pCdGgrTHVDY0FxWFRxbm1RWkZK?=
 =?utf-8?B?b1hRNmZkalluRlEyWFF3bW5GY2dLeU9reFhGVW83M1ZFVGhXa1M0WGJLTGpD?=
 =?utf-8?B?NlNDT3hiZ0txb1NRbG5QVzFndW93L2luei9uSzRKb293MzltQitZQXQ2K1RR?=
 =?utf-8?B?RkhEdDB2dWQvVDJFemRZZzF6MXY3VlNXbFRyeFV2ZUc2MjBMYmNuTjVnMCt5?=
 =?utf-8?B?OVp3YWtMUXR0NWVpcitiMXI1b001SmVhUERRK0Jobmc4MXJ6UFBiM3BlRnU5?=
 =?utf-8?B?bGJQY2JxVDErNXc0RGZqYi9ydUdVekYyQXFQK0RTTXpzTXkvN2w0WUhLQW9X?=
 =?utf-8?B?VUM3NTQ2ODBuMDY4OXBOUDdVRHFNZEpUZzNPemtrRStlekt6U2R4VXVWS0RX?=
 =?utf-8?B?OGFNQ1dwdC9DR1pkaGFVTmtpWXZFd1dRckpiQys0dUwwcmkwcVBrM045UGwz?=
 =?utf-8?B?b3habU1kOUszTTdpVy9PL2NxazRhWmlzc0wwL0JkaUxkeXFSb2JqWmM0dEh4?=
 =?utf-8?B?SVlmNU1yM3dOMXVYSEw4WnVqT0tYU2hIaHUyNmg4dmNhRnRURmVFQzg0MEt2?=
 =?utf-8?B?eVpPZ1ZLbXVIQ3NhSzZLenl0QWJ1R1BIQ2Ria0dCeUZid2lacEVjbmZwb1kw?=
 =?utf-8?B?dUdhb29IUnM0bHNQU2k2RnRhMkFXNG9zVlZFdDNRSzRhY00zSk1QQnBVYVlO?=
 =?utf-8?B?dmNGaC9YdzI0anllS3VTNjJoeU5sTXptV2hTbVB6dmovZnl3S29HM0Nvbnkr?=
 =?utf-8?B?MURZN0ZIT2txdUtURkRYTFlHcUFDRSsrY25CNzE2cHBUelZqQ1hhSVlsdnlH?=
 =?utf-8?B?bkZsR0NBTUFDL1Y4SWZEem5icXVOcm1RV2JNWmNVcUpVeWpNTTZ2Yk5ZaDNG?=
 =?utf-8?B?MzZmSHlXMThtZWFQcWlTYS9tUlhJaDBGVG40ZDNlU1pOMXM5ektWVXdBV2R1?=
 =?utf-8?B?QTh5Y3FKbE03ZkxoYWRWblQyM2VHMHRtcEdSRGlpMElYdjZnWVlsdHAwM3Bt?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xE3X95OvSe3Sp63AsbOKc+bXW6hyKcNQd1IXF0jSRSTlv3hPq7XlvQ15xZo7BDAuWPD4KagRTa8WhdnoDU7FhwNvTWH6apqmLyy1qCHSddg+IgVXY7Bd7UTu72shPzhwjyeyD3xEFxxyS6wqvBAgYcY6z+yw0ASu2G5DO/YHDFKXvrDBKyrBzcK/h/MbJcZlmrreMrBf8OqBs+dKeR5P72/MMd4vUHqhtgyvUpotqynWG1Xt0VED4vKrziMCPaj7XF2WEiof4eFK7gftWZVDL82faYRyd/HrJVbjtvbDR7cK6XtrGE3mU5vH3eZPd5rHv3oITORUWg+i4EKGci/4yc8vOQRLu9g7a9ugZ2cSYYi/MjArOP+iq2NiUUzEdMAwXDStbgKVOgyyQihwpnvaKre114g2ndpHFVUszJ0YYJbpqRWRWv8BYYXGgoF22IE+NTKmmL6SsVnIp65fS1LLb1I4KTLoupVc/aEpYSMiUDOL1oCrWOlXvfvddm4H1JvnCzuIb3Alk/Ohqt352psLes6kItFMr4UtzOy+2G32vryY2n2Y3GTO1cibRxeYBph9uxoohjrEokJ4DgmYjugbYTUklHendOlxoBMrTjCF7NpaEGwgAgEkhuc/sgFWqr4bpnmkVevHu+itLq2eQl5YZfAHhtohUl+71bP2hZb5xRvENq8FzLT8GOT5+J1lhvgLt94y+RaHm1uKdOxYQCOKSx6w6XVQY3LLwgYwmQzAYm9oF5ZnSdThrhLeRqkyHtovLhrkgIiHorulAXPwgD/htliR17H9Vv6V/yoxSDc9yjK/8LjrMAqXxLyFh5dmR1h/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a153ea47-1b70-4ff6-102d-08db67616183
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4686.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 14:13:34.9656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oo7CastBGtnk5tWbuO15i5k4d5upzK/qZDE/fylX4dWFjCZbq9ETNHYVv0ySYZzyGhVlRrweXxvSlZdC8HIZIExHly6BGnEcnWNFxuQCr4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070120
X-Proofpoint-GUID: Ae3dJ4fYPVEMTnARLW9wjZyJZ5GpsdHx
X-Proofpoint-ORIG-GUID: Ae3dJ4fYPVEMTnARLW9wjZyJZ5GpsdHx
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 2/7/2023 4:29 PM, Peter Xu wrote:
> On Tue, Feb 07, 2023 at 04:17:34PM -0500, Steven Sistare wrote:
>>>> + * *@reasonp is freed and set to NULL if failure is returned.
>>>> + * On success, the caller no longer owns *@reasonp and must not free it.
>>>
>>> This statement reads weird.  IMHO the caller still owns @reasonp, but if it
>>> succeeded it should only free it with a migrate_del_blocker() later.
>>
>> How about:
>>   On success, the caller must not free @reasonp, except by calling migrate_del_blocker.
> 
> LGTM, thanks.
> 

Hi Peter, I will fix the comment, rebase, and repost.
Please consider upgrading your Acked-By to an RB.

- Steve

