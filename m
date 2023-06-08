Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA64F728718
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 20:22:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7KGX-00079P-TE; Thu, 08 Jun 2023 14:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1q7KGR-000790-A9
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 14:21:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1q7KGP-0005IM-JI
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 14:21:39 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 358HhuwE013257
 for <qemu-devel@nongnu.org>; Thu, 8 Jun 2023 18:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mww0Qs6rc3TCkcuukEXOOQrcS46PKXrJjQ7+E3WbxAM=;
 b=xmBuHHbthklYa9Dpj1wTduqWp1I8zobtf5DjdMDkLD56Mxu6/AgSc2RhgIR7BH/J+EVF
 FzxRJR45nFzQxlc0SEGCBDuccrCm5Eai0+dvjh5H3igzgX7U5uok+C0WeGzv/dpNqtBh
 pMyS+M2F/ws9I68u5zqOoQ17AgJTPaYSjZ7MDYF3X7bmATHqdXCr99HzyRsi7xeZmX+S
 +MirHkeTuTxD7HXz1O35oO4hjcqjk8HoWTj2OOOkWl8ZbQuzzU9lveIbOYq8lqusSp5v
 uAhe/FevFnWF0ZBI5Oz5E5PPDChiU6SiKn1+O02+D84mLJmg3fi9XGGiythgmpMwH+ix 2g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6pn05d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 18:21:36 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 358HFZCO002962
 for <qemu-devel@nongnu.org>; Thu, 8 Jun 2023 18:21:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6myxwd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 18:21:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mu8gDGncuAEu8CuBuoYPlfPtUDl2Skv+Mq7ucjOMbXPgpeFvCcnSDcnPluNemPEbTky+b3aZARkHb1Y9ww2SRrAwP3yctL7erVwG8x8lBe++1B6vuLqp6325J2LbZsOjJEFVde91OIQvdJLccOCwvqcFuutym6LlVf3M7D7BzSkPM2V2LFztRZzfWAcQ9e0UiTTpTrw3nLXP9LTk9zg8K2vY8Lp3+G2V/6tLMmYHhAjBkdY6DN5Vhdeb3nUebzh4KN9q4TOLWytVw5so0ohM8zKbQ91rqGH25xd6Bf/1WW3ukKtOqrsXLD0aC8WWFHiAISTvV+t99yjwKx2nEJdbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mww0Qs6rc3TCkcuukEXOOQrcS46PKXrJjQ7+E3WbxAM=;
 b=NBfWz86io9pBfdz11iVd7sG7qp1VkOpkBWh7zfjIx6Sfp4pG6tzUegGA7iRuVZdEGM6R8XwC9+btXXdnrY9N2DeFPtFlAeDrKpJ5bvNcyUA7wU+AK2ibaLwntVkQaqolZRNHXW7mhMc8WDeEhNwzw8w2z29Ug5EWLoJp1bHAXMYGSNOoa+QQ5QBkql0aiS5vepBH1VeoXLfX9E0Xqe0RSL6jORkCG24M1mstIxiQOnoOnxgo8oRWlILOP7BOOUN2P16WKRCjIhpYB98Nmt8XkxgItHIsg9nYlRffc/QMii18kqUH9XRdkqes3WehG7NdDO880sZJWDSyUg9nsapS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mww0Qs6rc3TCkcuukEXOOQrcS46PKXrJjQ7+E3WbxAM=;
 b=Mh2MCEpGk5ykwKc7MKtu1sgDOtLmnUQ8Q+2ILxjzG4UWj9CzhL8wfrr0HyUSHgJnOqP8ZaEh7h2G0tV+opC9fxr+H1i/eQ5R7vBvI9UxuHBS90iUOocpwftMu6Jl6Pueg1NJ0Pmf+Io+M6JSYCcERWUFlsH131mTxJIgs5P+tcg=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by CH3PR10MB7260.namprd10.prod.outlook.com (2603:10b6:610:12e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 18:21:33 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 18:21:33 +0000
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] maintainers: update maintainers list for vfio-user &
 multi-process QEMU
Date: Thu,  8 Jun 2023 18:21:22 +0000
Message-Id: <20230608182122.1794691-2-jag.raman@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230608182122.1794691-1-jag.raman@oracle.com>
References: <20230608182122.1794691-1-jag.raman@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0427.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::31) To MN2PR10MB4013.namprd10.prod.outlook.com
 (2603:10b6:208:185::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4013:EE_|CH3PR10MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d8186a-6063-4821-0258-08db684d3073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXd4C2M0Mv8dgJZinISkZhdanY8Yamz+DYaUfUnG24QfRHkGsevo+/nAIEX/EDCG/ItvJEl+s62pCPnYCVH7U/MXEsNhPdLU0JTckn8EYFhWUFMeC0SBSO0PJUpY8iGmRjBlLeP15szY68t+L8hfLjLXH8nNopStjMCe1ynTHmRtBlJEHpPNM5txDUImekt8C1bffoa0wTcruo9CUWJjoMlIIIc7efqPBJ+5eKO286HW5/RpJkwcXOQ2+ZvxFTepDQyrN035AvwZM8SWr+TEwrnCSXK8h6nOjg0GNedbjznlR5Gd0xSdQdxSax6X3G/GYr5zqJ8EoSvfWn+9RuGUt1R7PHAylDjKARxC+EKEgxUnY+S6bFao8cZFX9mr3xyTJ10WCWO2mMVVqvQ1PXegadvidVMfgLVnZjw9O4JmmRVnwsNSj62l+9YnEEsU4IM88OCy0Bvhbr9ebbzmZueiOc0umE19MT2DIwgMwYhsyP81vcIO3F0+C/cCqUVCN2E9o321+D8bIPQorXN4OvM125qdqDWPhzEHTp03fwj3R8H40NwqhFZqPbauvix5OE0G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(41300700001)(8676002)(66556008)(66476007)(6916009)(8936002)(66946007)(5660300002)(316002)(2906002)(4744005)(478600001)(6512007)(38100700002)(1076003)(26005)(86362001)(186003)(6506007)(36756003)(6486002)(83380400001)(2616005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHNaaGplMXZvQUVRMThIeWU5SFVpVzJsSHplNVFEYXpoZ0FUWFd3emlnZmVP?=
 =?utf-8?B?azg0aFIvaFVBa0szelhTTHBvOHlDeEd1VXhsajdBSDh0UlRxMkdjZVE4R0Jz?=
 =?utf-8?B?SmFkYmJNM1pYVzZtWk05bkppZGtTVGtUTkVyb1VYWlp6UVpvQ3hra2ZBVjUr?=
 =?utf-8?B?c2tQWHJ6bUNJSW1Tak4xdmszeGFFcEhpNEp4clZHNGtoc0tVQjdhd3JYWWR5?=
 =?utf-8?B?Q0pTbU05QVRSbm9QTFNBMW40c2xETVdVTXNZQWJGZllCK1FTcXcrbFk4b0RN?=
 =?utf-8?B?cldTVDNvQjVvQ3NSdkNtOCtQdXgyVWczN3pLb2svbjFZSWlZMjcxbWtOaXov?=
 =?utf-8?B?THdxM2tVdnZ2TXd2dUhZVTExM1dubnV4VW1scDdPZEk2cHp4WnVuYUdzYUxN?=
 =?utf-8?B?UmZRRGtHQlVPZ0s2Z2llcW9GVXdHd0REOUNUNFJtV3BOSFR3blhTNlFxZUNP?=
 =?utf-8?B?VzNwWGM1WDVSY2g2Uy9zUmZGeG90Wk5ZZVVTZXJXVVQyRXF4cVV2RkVxZXg2?=
 =?utf-8?B?SVNudnpvYWJxWE1jUGRTS1lNRStYYXE4NFB2bE1WSFlEVGkvbjdYa2FuK3d5?=
 =?utf-8?B?RU56Kzg0em9YWmNoZnNucVRkMkpnZlo5enhBUXlraFFlb2lLV200ZTk2VFlJ?=
 =?utf-8?B?N1NtWnhHUURvYmhONTBneTVxYXZZbFlMRVlXZ0VyamgvazJiLzFXb1BoNXFv?=
 =?utf-8?B?TkhGYTRTVVVMRVI0V3BWUW5IUEFMbkJQMDRTVkpJeFdDOGdHcVBpanU5RndD?=
 =?utf-8?B?YjQycEJBOHFlNXVoeitCSzg4MkZ5N3d1TXg2c0E0SEgyam9uWFhoTWJaT1Fo?=
 =?utf-8?B?dHJrbWFPVkx6L0xzZDlBZ0t2YXltTkZpL3E5alZOQ1pqVVlyTUZVdXorVEJU?=
 =?utf-8?B?NXVMMU5ISi96cE1hQVJYZWY5K0NUQmVEYVZLYnBPNXVDY1Q1UjNWRkJvY3dM?=
 =?utf-8?B?TTJqck53Uk02N1ZNRHhUVVlEcUNucWw0UDFxM093emUxVG92NDN0eE5NZi9X?=
 =?utf-8?B?d2x4RG1GK1g3SUVDakhEYlRoOWFOV1ppazVhcGxGd1dUNjNmMzYyRjZXV3hQ?=
 =?utf-8?B?aGhTcENLYTZHZ2s2RTFXbktSQ1Z6K0xGOStERWo3eUpzbC8wcU8xYTd1UHY0?=
 =?utf-8?B?ZGk1alMzbHFlMG1aek9STWQ2d0ovbWh6aUNGMFpvelN0M0R1M0Rvc3lGUUxO?=
 =?utf-8?B?S0llWDRQNCtEQ3FMVFQzOTAwUkJmU295dDVlc0ZYMGlDeHdKZ3d3Nktubmg3?=
 =?utf-8?B?NjAzcFpIZ3I3SkJweFZ5d0prQ0RjSFFGZUxHVkZhM3pUNlFiU3lXaStGeGFV?=
 =?utf-8?B?Wm9SKzQ3WWp5MzFEWGJYL1dKSGtiM21HN09kMHZSQytsVkNMT0czQUp4MXZk?=
 =?utf-8?B?dGo0dGU0a3VFRHBONUxwbzRkSE9pWVF4KzdCZUVsd0pBU3JTdVdaMEx5SGFC?=
 =?utf-8?B?MklJdTVCV3RybTNmU2dZTDZ4K1ptRnNCQ3pjWklXc2ZENkpqL1RLWkpzS01T?=
 =?utf-8?B?R2NzcGtrSkpXVWkyTkM5NnEvSFhoUWJmNC9wRFF2K0FFNmxEK0QwL3FWZ0FZ?=
 =?utf-8?B?QjIrRXliUXVCc0RWMlQ1aGMzM2tFWnMwOC8vZkJ2MHBXYkNGclFXdnBQeExm?=
 =?utf-8?B?U3gxVld4a2ZMdS83T2loT1N1eGlEekZOYW9sZGtUOHd0RWY0NHFrdnFVVnRs?=
 =?utf-8?B?U0tDUkxKdEhpRStza1NFVjhHWnlMNmtkNU1SeTJoTFg4NFZGRlNucytZS2R2?=
 =?utf-8?B?U0p6eDdXUUhmVUVKcFR6am12MWtxRThrL1ZiRHArc203VllOMlh3Z1JXU0Z5?=
 =?utf-8?B?eGp1RXhVcUw2aC9PSUpOQU9ZNVZqQ2FuTlBBMzVKbnNTcEZUc2g1MGlkdkdE?=
 =?utf-8?B?eFRrNWZ2VWM5Wis1c3RBS1dlNFJWWEpoRVlsdFhMMXNIMy9hUzYyek9iU1Uy?=
 =?utf-8?B?cWlXVXlYdzFwZGVJQTBQNm10N3NRcFRrTEh0c3g3K2d4WGpFNk9XL3lhNFgy?=
 =?utf-8?B?UHByWThkVE5hOVBYeEFiQUlJWnE3UUxhQ1c1aUlVQVNEM3hDRlB3YTZlQy9X?=
 =?utf-8?B?K2kxM2xqMG1NcHF0ZWY3aDlIQlJqNUNvcmEzRTd4ZWo3WnVNWStGeXVDbEwy?=
 =?utf-8?Q?BZmixjLnTspSVyZ7FKCR0UVc7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PNI880Sl4e2+k07jTTNSm9ydnHMSZoL3TxWDJmk+XFGc2RlFrHZXJmdyiC4j64tHzRYcu6T9nZw1l2Vdp4dYz69b2txL3Lw5OgnU6vPx38wPCFa1kbMalG41zj4/DQKYwXwIA9/euE5p3oA6zNX7pORVfpjBywlt+S7cDH/3tJOEGr5b82WJrljQqOaYeFMWR+Wy6cHbtfWpR2wXdhetd+zQKIuKjUopD7clgYMV6bnMh3H6ewBfXlMuThSC6CmeBP4U+ZRmTvIu6bPgxwWlWAx3Tuvzfa8Aeu951+2096/7a8fU/K8rcj3VnitLqMVP/rP6tqP3lP5wQ7dAjSlBDVE2IBj41KW/MWM39GXNw732a+TKjFuiwx/wzTklZnPgIKV6yf0WEm7QmAmbAhVsrc4nLKEGasAZsHiNIbqwBzZFn/4E1bx5vTAWvVYjgVs+M+T66GVCk5qS+0PAwS1Wjiju+R7bkdL19TDyukeOngDPeZS3mY6XKRoEQUfeu5NrXptUMm3+9HYXxNY/q31nv+dDRmw3WP6Jj4aLZkYXt/lrl+GkwKPQRycXiaPZ0+zuwe6JvMTZDHW9PSIWIzj84ni7PtQC8KPTXWE9DZgfdo+mNpyMqBEIF1q2z7ZHxTntS4gwDYvskDTHfDeK8273WjUSf/ezDwI5zmeVitSXvQ5non6atkx6UhikZhBt2eeHAT37nmdSv945U6XEy2Zjtjb4ro3oKzdpysaF5OBWfs/6qpA3EaSFizD0QyHSOFCP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d8186a-6063-4821-0258-08db684d3073
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 18:21:33.8816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dH+M7oRi/l+db9xPrZrHn74kI0m5eA6eJy8QOfNSI9U/uhL1kOVzWQDKqMI/2DPQvS32kRst0mCtkTI+6g8SEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_13,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080159
X-Proofpoint-ORIG-GUID: OoNP4MObbg7tv7YluajsX45RATNHPJNs
X-Proofpoint-GUID: OoNP4MObbg7tv7YluajsX45RATNHPJNs
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
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

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 436b3f0afefd..4a80a385118d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3786,7 +3786,6 @@ F: tests/tcg/aarch64/system/semiheap.c
 Multi-process QEMU
 M: Elena Ufimtseva <elena.ufimtseva@oracle.com>
 M: Jagannathan Raman <jag.raman@oracle.com>
-M: John G Johnson <john.g.johnson@oracle.com>
 S: Maintained
 F: docs/devel/multi-process.rst
 F: docs/system/multi-process.rst
-- 
2.20.1


