Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FD1805E25
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 19:53:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAaXC-0001IG-Ao; Tue, 05 Dec 2023 13:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAaX8-0001Hu-PN
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 13:52:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAaX5-0003z7-Ep
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 13:52:38 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B5HO91s009342; Tue, 5 Dec 2023 18:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=wN+hb2biL1ft3Ci0qoRnHBJsxFZQo/hGfqjTJcR+Zro=;
 b=HEZF6nKC9eRcNQEPkb/SfTFFmw1sxqVwaUlr4M+aHH04AsMEJO/PgERL+c7OvN59UaQP
 qIK5JeV3D9k3//16R6Gq7QfRj7yxPTZBroUI/2zlgbdghfO7RTwPwMOMDDXIDEVPLoA0
 hB1Hwr5jW82RO+qYU03vZOhi4E3Dy/mRufshUWEwLlQc+798y5hZqOSoaaQxHjzCWMw7
 vIydYnkZkiqoQ+zid64kUAui9UAodnjIeSN5udQFnvKeX+dnoM1fw3ceyqM/9NWuJnc7
 eZCvFoBpK+Pt9+liguDDL3TKGmGq2IRO5s0fxNep0Az8SW5PxkZYOu4JkvNGIL78Rlm8 Ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ut076sgpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 18:52:31 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B5IR1Ig004881; Tue, 5 Dec 2023 18:52:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu17qjad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 18:52:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkHcDBB33L/9ojJA0xV4f6R6EJqGz5y6wcE3q3Bx5+Q1DTLUopqYStQQEQ333uU/pbmE0M5uqm7/e1GvGflo0He4/+xH2g6N0t4NiHIqKP3yW/Fu+ZuAYOmIq64RyAT7KCystrlk0PuVgq4957A7bcSchM7y9qTrDbXAhDDVHZkuDo0h3S5tMMrfnI2gRzSCoEvbZ5cHaFz+HzB6r6qPNp0pN89dpfIuQqThajRpUUg/mME0drsj+DK+CBkvHWNh/+j717b8gJIYlOQlcoVYzm7HDUwvT9iK4FpfmkFSX8pioFmODsRx40DvBdRbPKwtVAuHJC9tquDuhxJJVpmrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wN+hb2biL1ft3Ci0qoRnHBJsxFZQo/hGfqjTJcR+Zro=;
 b=mFCYgXVcRX1iAKsXbYYPN+cwaNUFzwZrgWQCb6VXi+ZVDFfBJxZJEzE+PKASxaAc7WUXzdGKI5F6s+nj7IMIEkSqrN0L00u87IgKkR2QR52UN7D3os5nPYIvKRUEsdTvNSnJUsS9AL4cjzc6Ga5Y2dj7A/V5hdyzgvZXSkDSylMcOW0ai+c57i23JHhvam/3PQuP+DxDGb8frLgc85TaNo1LzmIg6TvIL55DKEWE40nCZvTNvbQs43omgjPhJM9cu5x47Wmyc7V6hrxNf/GucH2epwh+je2URPD9czE8pdiZ2yRZyTn2DxWre5aDEo4pvjqYSPx2dyU+9MzPGDsFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN+hb2biL1ft3Ci0qoRnHBJsxFZQo/hGfqjTJcR+Zro=;
 b=iClu8PUfNqX9fCsthJlVI+gATBrMzFN3jC1YQbdMjb+Hma9rDePlRJXeaNoVffgt+cr+D+/ZHwHqEQ4M259dzTpHBSbknQIhmsnMTP1yMOgRRME/lSTYJ6vXnM/oBOerIQnijA09bW1oMiKOb2KcAKJcS0pAo4dqYiBuaU2Av0M=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB4591.namprd10.prod.outlook.com (2603:10b6:a03:2af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 18:52:28 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7046.028; Tue, 5 Dec 2023
 18:52:28 +0000
Message-ID: <a0350701-617e-43a2-b856-02c35a203fb8@oracle.com>
Date: Tue, 5 Dec 2023 13:52:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 00/14] fix migration of suspended runstate
Content-Language: en-US
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Leonardo Bras <leobras@redhat.com>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:254::35) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: a94bdabf-56d0-47be-f04b-08dbf5c353cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWTe25712btUoaRnh8nibbMqgf60eiqqN/nMpN8CFCV/tpAQmOmEeGZBch4Y90OfI6h3kbWK/w96Qwr5cz0MC0BmZunKF2Mnn3prMJ8iJYEnvNRuxevNPZgowW7zHRVlm0b2Gv8xrWQA0096fv3p6yQbGWBDfK4nFeAJG6HKahO13VFs12TvvlLv+Reo6uxJAy2QFzJoGA07i6zgsBfePaq5uCufqRW8PCvNIlZNp4I9MK91hIg3+SDtjsNNoFm2wgqGYCev6RYXdo1EotFinLkJyL+EDhYCFODXbE9XCEdD9h5bibVNVtrGTZUHrRSW/GTauFeMy9ki+XSlmnYv11VLXmv6yI1mj8zUL01WuSPLj3ETNiMtsfERzk9pRm0OwjWzGDuDfxEWS+O/DgQ1OZdMPUFBnaYRUPr3K1pxPRBw7p2lV3+zLFdZZS4yjPSUMxd1anQ1QkyifzUuFAXOvqcTBX3x+u7FuP1V0FHmqeu1okVj1bXmuwmJ5oXTlmUAuGm4wQQeabIJQyPe5fC8JJG8NYgNNChJV3uRwvFHg0AmA/pUbFpS2FIKl1FZiJE4Ft0qekvhQfybdeSOFUWMwKPFbR16F/1OpF/Cgf5z3t/d2kRNbq5R7WJ/W+9Dk97od69ZZpbitUZqxKMXwhQtgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(66556008)(316002)(66946007)(86362001)(31696002)(8676002)(8936002)(4326008)(54906003)(44832011)(478600001)(36756003)(66476007)(110136005)(6486002)(41300700001)(15650500001)(5660300002)(2906002)(38100700002)(2616005)(36916002)(26005)(6506007)(6666004)(53546011)(83380400001)(6512007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFk3TFBpYmkxN0RYM3lUSGJrc1MwZUZUZTBtVUFWb2ZvM3phTFVqTnUrcFRZ?=
 =?utf-8?B?NnlteGxUbEZkbFQxQVo3dGRRWlJtRlVQRlowWlBHeEZ3eUU0T3k0RHluUEl2?=
 =?utf-8?B?MWg2andXckI0OXdMQnNaU1BXcFQvaUlBZzFJOXBIQ1JPSktTVzdPODBCWWVF?=
 =?utf-8?B?emIzTm9ndlgyYTNSU3VmWVlneGlzWFk5NGRqUWpreEpxbW5Cd05CUXd4NUdy?=
 =?utf-8?B?SUdvRjg2WTFOSzZnUUQzdHlEc3RKNWhZQVQvNjF2cnZGQ3BBVTJsVG9nYkNT?=
 =?utf-8?B?RndsSEVVVE82VkkrQStaQW45U1Zxb2lNNzNPYkluUE9xVUhRWVhualBVYnRB?=
 =?utf-8?B?NlZRODVhYkUzZ0t4V1ZDSGo2SmtqT1hKRks1UmtLNEQwZmhGK0taV3IwUEwr?=
 =?utf-8?B?cnVvdVdaU25qbi9WOUVDNEhYR3pHWVd6b0RFKzgveGNJRW9oTmVxNCttcUdU?=
 =?utf-8?B?SFpKeDhiVmtIS0pncTFwVW9OcFl4Q0x0eUs3b1dpR1EzRWVkVzV4ODRrRzBZ?=
 =?utf-8?B?aTVxa0Q5MUNTcXpNRUFKeDBJQ2RoRDFsU1ZzRTVhUlNSYXg4NHJBemNENGxp?=
 =?utf-8?B?SXd1VDc5TklYelgySkhnWjdHYUk4NGpYSmF2TjUzQk83aDdtSVorRnlrb2No?=
 =?utf-8?B?QUdMRkRjUlEzMkV3S3BLMUluSkdMMVpUN3c3WXg1WTVUZGZIUkRLTzBXSjFM?=
 =?utf-8?B?U1R3Nkh5dnl0Q0Raa0pWakU0bDJBWmVSNFdRTzNFeGNHTy9EdHZ5a0ZKbDFY?=
 =?utf-8?B?NGs0MTBURzlOemowVGo5c2VEY3hIQVBnbGNMMDREeFVtZ2cvT3dRajlmcnE3?=
 =?utf-8?B?Sy9yV0FUbTg4dlRWeGRRN1BaMWp5QVdxNmhXaXI3VGh0WWVNQXBVbElCZmJD?=
 =?utf-8?B?eitWeFRDK002U0RYMVF0ZE5kZTBtWi9qOHR5YUM1R3RhWFJTVHByTFpjVkdK?=
 =?utf-8?B?UllqSkpBVVhpTXU3S1dNdGlCcm9xbWpFbzhnZ05LU09mSmZCcWNvWDMxUkNk?=
 =?utf-8?B?L3pDT0VyNWRTZEE4QkxYYlJVMzRnT05uRExVNFFOYlREZTRMUmhYRVRPUC93?=
 =?utf-8?B?L2lHaVFGeEdMQ2JqMkhtTElkbWFpQ21QelE2MU1TYTkrdkZrOW9TM3JjZHpj?=
 =?utf-8?B?MUs0ZFdxc1plMnZSV3RSRVg2aVNhU0VhMWloV0tpU2ZNTWEyOXBmZ1lFUHVz?=
 =?utf-8?B?OVllZW5BSytnWmJpdVhaakpPdXBMQTJvUnBPakQ4dHpTVm0va3pkeVd4RnEx?=
 =?utf-8?B?T3JPNnlxb2dhMUdvTGJIVzIzaWFkVzNYOXQ5Y1RXZ3VibE9NL3J1WEV6cERi?=
 =?utf-8?B?SW1GMW83QThaRU1aMDlGeEZMYTRtSm1qREl0bmI0VVBhdC9sdVprUmM5UFRn?=
 =?utf-8?B?QldOY21zbXlYTUYwR3FhQ2Qydk9ydFdQZXVmM3dVeTM3VmhqbTJiYzRkT1d5?=
 =?utf-8?B?WkltYXRSL1JzcVBUNHNjTEFNNUk0Z01raXJmdW9YUlVzNjFxZ2g4YTJMaHFj?=
 =?utf-8?B?cG9QcDl2aFgwRFRaUW9OWXFzYXVRbjBuZ3JpL2RsSTZ2d25DYXMzN2FFVkMw?=
 =?utf-8?B?UG0xTCtzUzFMUXQwMmNuMVIrdXpIVURUZVFRamM0Ulkrb1JpK3FhTVFYNmJU?=
 =?utf-8?B?K1hJa0h0ZkV1Q2c1cHMvVTBGUzBYdzR3cEdJMWlKeUtXL2J6bFRNUUpNdVZT?=
 =?utf-8?B?S3ZYVUhmQ1BSb3JMMVg2RndBb1MvN2RwTHEzRThKOGRFV3RiNzdjQkx5UzN4?=
 =?utf-8?B?dTRyR3ZoZHgyeGV0QTl0bmtwd0tIME56azVSMUcwaDA1MDJWZURZK0tkalNm?=
 =?utf-8?B?WTZZV2NpRGJzbWpSK2U0N0ZPZVlrVUZkSkNEWEVUc1lNSEx6c1pNdG5Qd3li?=
 =?utf-8?B?UjNCckdUaEcxc0ExLzI0SzVDNWFmdEFEb3BWcTNtOVV0aTQxT04wanBSQkRF?=
 =?utf-8?B?WTZNK2c1UjdPc3ozamdWcHBtMGRnY0drUnpaTlh6cXh0MkZFNk5jTUJMSTlP?=
 =?utf-8?B?VWM5bDlqcmJETUw2S01TZ2VWYVQzcm9wMFh5eWRLMXdPQ2Y4NFYvK2ZGdmw1?=
 =?utf-8?B?OWF0b01CdWovV21BaVB4Qk1oWG8vaVlxL0Z3d2tyWkluZ1l4UGM5OFR6Uitq?=
 =?utf-8?B?NzRJVTZJU1RoM3o3V0psaG1EQWZHUlZWY0RMQ2l2ekJjZDRSckhicnlmWmVo?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LWAm502A7Q5zA9j5bmrmphn9apMdmARbKuvUcJMz9yLy4F1022jSFoW9YAMQURr1joLvE9RBvYHO9/JSC5zaSOlpNh0QSAEwGioc8f7HVybK076VhX0yW3OcTm1NdAdjuXB9FhaD2dZog53+9gLSP7Uo2ZLixH+tsJRr96/LlTr1Vlof7F/GS512Nb4KcBvj7GzNLH1wSzVZpB14EbO6Ag3oPpUsIf+3fenzS+9j48CSP6v4PIXNrzcoxgby5XnvL0NKtXrDTmvMNcJcb51dga6LYw2GF6/vzSp4sMBK1E6O5Bp1rRI/YDQ+c7H2uDAg1srDqbPUPp+VRY6JPeJy71aRZEpri02RTSIRLDejuMlyp/o/Nrx2I4jKb084dviuJUq9ScDw92Gn+h7IO/dOhYoB0Kw9Bmh+RRjddgu8fjQCoj6h00Sae7/72wZSPojH/WrP8UoOy2+s0WXLaYXnFhkIRLhhQyofICZ0zRScF55jc0hGick/7e5EZjcuZi6suTddw75u/1fh6oiITu7Cxq2A76Tyaz5DOTF9y4c5HocuaRaaCWy5cz+Mh4/f5+YriV3SgKSeT1BljkLB+78GHtAkDnldDdHqt0ykwZNQwCgiRKEeVtBHM9Kwuhwzmk4n9ksCDAy2sqoSUcBirdV/upBcymsQxp5YzQ1C9UkoT5BBuqu9ztdSvIIlE0qmNqRLETcffmsV6+T+DfAz0seTLFGegUOxBQO4Uk5DgxqsSjrNw3aIbzflRW5K9NqJHcfqDzp24a+otxamLdwArp0cSo/fbfEq5mXEFXg68+KgOzM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94bdabf-56d0-47be-f04b-08dbf5c353cb
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 18:52:28.6137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYbmxharXa30wCjdA9SnJvgAWA15z56jx8wdTK3HenLJcSFa4itYCkZffqfdmSSWbGN48Xa5mptlOiBXQWvQhbR3+/lMj6ebKsY05Mt+Unc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_14,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050149
X-Proofpoint-ORIG-GUID: Bm2JWqtxRfrvyKVKXuEGc92kfuI4nYY5
X-Proofpoint-GUID: Bm2JWqtxRfrvyKVKXuEGc92kfuI4nYY5
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Hi Peter and Fabiano,

Any comments on these patches, before I send V7?  They are not affected by
the other changes we have discussed, except for renaming runstate_is_started
to runstate_is_live.

  [PATCH V6 04/14] cpus: vm_resume
  [PATCH V6 06/14] migration: preserve suspended runstate
  [PATCH V6 07/14] migration: preserve suspended for snapshot
  [PATCH V6 08/14] migration: preserve suspended for bg_migration

- Steve

On 11/30/2023 4:37 PM, Steve Sistare wrote:
> Migration of a guest in the suspended runstate is broken.  The incoming
> migration code automatically tries to wake the guest, which is wrong;
> the guest should end migration in the same runstate it started.  Further,
> after saving a snapshot in the suspended state and loading it, the vm_start
> fails.  The runstate is RUNNING, but the guest is not.
> 
> See the commit messages for the details.
> 
> Changes in V2:
>   * simplify "start on wakeup request"
>   * fix postcopy, snapshot, and background migration
>   * refactor fixes for each type of migration
>   * explicitly handled suspended events and runstate in tests
>   * add test for postcopy and background migration
> 
> Changes in V3:
>   * rebase to tip
>   * fix hang in new function migrate_wait_for_dirty_mem
> 
> Changes in V4:
>   * rebase to tip
>   * add patch for vm_prepare_start (thanks Peter)
>   * add patch to preserve cpu ticks
> 
> Changes in V5:
>   * rebase to tip
>   * added patches to completely stop vm in suspended state:
>       cpus: refactor vm_stop
>       cpus: stop vm in suspended state
>   * added patch to partially resume vm in suspended state:
>       cpus: start vm in suspended state
>   * modified "preserve suspended ..." patches to use the above.
>   * deleted patch "preserve cpu ticks if suspended".  stop ticks in
>     vm_stop_force_state instead.
>   * deleted patch "add runstate function".  defined new helper function
>     migrate_new_runstate in "preserve suspended runstate"
>   * Added some RB's, but removed other RB's because the patches changed.
> 
> Changes in V6:
>   * all vm_stop calls completely stop the suspended state
>   * refactored and updated the "cpus" patches
>   * simplified the "preserve suspended" patches
>   * added patch "bootfile per vm"
> 
> Steve Sistare (14):
>   cpus: pass runstate to vm_prepare_start
>   cpus: vm_was_suspended
>   cpus: stop vm in suspended runstate
>   cpus: vm_resume
>   migration: propagate suspended runstate
>   migration: preserve suspended runstate
>   migration: preserve suspended for snapshot
>   migration: preserve suspended for bg_migration
>   tests/qtest: migration events
>   tests/qtest: option to suspend during migration
>   tests/qtest: precopy migration with suspend
>   tests/qtest: postcopy migration with suspend
>   tests/qtest: bootfile per vm
>   tests/qtest: background migration with suspend
> 
>  backends/tpm/tpm_emulator.c          |   2 +-
>  gdbstub/system.c                     |   2 +-
>  hw/usb/hcd-ehci.c                    |   2 +-
>  hw/usb/redirect.c                    |   2 +-
>  hw/xen/xen-hvm-common.c              |   2 +-
>  include/migration/snapshot.h         |   7 +
>  include/sysemu/runstate.h            |  19 ++-
>  migration/global_state.c             |  10 ++
>  migration/migration-hmp-cmds.c       |   8 +-
>  migration/migration.c                |  15 +--
>  migration/savevm.c                   |  23 ++--
>  qapi/misc.json                       |  10 +-
>  system/cpus.c                        |  49 +++++--
>  system/runstate.c                    |   9 ++
>  system/vl.c                          |   2 +
>  tests/migration/i386/Makefile        |   5 +-
>  tests/migration/i386/a-b-bootblock.S |  50 +++++++-
>  tests/migration/i386/a-b-bootblock.h |  26 ++--
>  tests/qtest/migration-helpers.c      |  27 ++--
>  tests/qtest/migration-helpers.h      |  11 +-
>  tests/qtest/migration-test.c         | 240 +++++++++++++++++++++++++----------
>  21 files changed, 382 insertions(+), 139 deletions(-)
> 

