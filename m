Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAD57D3F93
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:53:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv01y-0000EM-SL; Mon, 23 Oct 2023 14:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qv01w-0000Ci-Kw
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:52:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qv01u-0006yI-47
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:52:00 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39NHwjEp030070; Mon, 23 Oct 2023 18:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=k0U4h9gm3IkSFCnArjtFnlD8duN/LdTe+MXT9BL/52k=;
 b=MDNV7mZbeYO2zUvtQiJboVMr15k0cgwE4TRLbzmo1V7qnZHvJVDL5/4+cGnEQgjosPZ1
 Fjw4USocApGEvyQzoQ+vtAbglpVgjcYC8ieF17gBWEP7XvboG/vnpXfM6SoZ+B3ifg9o
 FUdVhvKb/hjTVyUnijZf7v49NOUxEm/lhwcaT2pYO18V8suaRbyMY7ZIWF9tBAuZwFNR
 VgdVTk831ijHYE03n3xmyKUeDso7ObthXIM1qRtgsBgYOQKQtJdBA+MI4hAfw/Xa87Gj
 b6SOY/A4zt/40n7WkLorQh8kodgZWl4jOzXFiHsTdbbYK/V+VkALTQjNTzYA1dAEEW9C xA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e33txn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 18:51:56 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39NIf73s015200; Mon, 23 Oct 2023 18:51:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tv534byxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 18:51:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7+BY7IL+yG3xGBn7tu38Ny5Jep1Q5Jr/aaOgEDX+cDla3Li3LGKKZxDV3eXlI5SNyooJp533p2VR8TuB+zLSjbZ5bPFHZvLDl9lTFVRmlyXbpfntw/mW2p+apqBEJWylYQtIovJ+Mry52RRkPUptCe87R8w4oeIjX4nMsXqpGMKYksc9+1A6yVtTqaXFkqERjzLMTnOR7gw6AbO676PGmLywTZuF+1nnst3hlRH8IKnyB9VBhfN8EYQGS0+fPTqcYUWVkNm/xXDXaJpkvyzJcFHZ+xKlO6g8vJpN+niMexYGvYLMRfwVodANL//56QXbyRLY6IDP5ZFHlVg43MOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0U4h9gm3IkSFCnArjtFnlD8duN/LdTe+MXT9BL/52k=;
 b=Bf5YHmWvMxbPpHwVLOEq4nG2YYEqKUCkhxhVDBdDWLPAMSXJAywqDfTAP15jQDEnKcWAjCQT+kddkB61ccW9Z9znEsAPFafcGJwuaugEKvtQzMqbTiotwlWvLayI9IhoFsDFGkMOEXCCcugZmy5qY9q0tbu48+nmxH0bPDa92MvqS2k2cYcS+9IPluUMu2FEEfk04xoTmIN0B4bUe7NNNSm1ZaZG1JYGZrc5QpSLM5czbUdo5skxnX9lJNJvuZO0EaU27o9PrBDl6rMnyZ+CidUW69mvh69iZ+mCaw4kQoP7eus5pS0C0D/TH8zyBRfpSICCbqSHonEYzyKmPQnymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0U4h9gm3IkSFCnArjtFnlD8duN/LdTe+MXT9BL/52k=;
 b=xhJBMZ/lhwGt5ONvjbqlVBMAJmIphcEjoQV1bxv5KxwvLynMcmZ4BPBvI8vRa4QY4XW0yYsDO7J2LR+MbmA2Hgo9ZOAytlBA/8nSNihGYXKxZ1GcM8bbp7qWVjPeTivOd2LFOazskqjTMrbwMiAT7JMPFvbkHXSMmm7PxOYG0kM=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA1PR10MB6390.namprd10.prod.outlook.com (2603:10b6:806:256::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 18:51:52 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c305:4801:5bd7:4775]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c305:4801:5bd7:4775%4]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 18:51:52 +0000
Message-ID: <17f8d519-f86f-4857-93c4-080f0b18834b@oracle.com>
Date: Mon, 23 Oct 2023 14:51:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 4/4] cpr: reboot mode
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-5-git-send-email-steven.sistare@oracle.com>
 <ZTaTrEPcK2yU8MT5@x1n> <389959d5-6d15-4557-839b-575b43bd2ed4@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <389959d5-6d15-4557-839b-575b43bd2ed4@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0016.namprd22.prod.outlook.com
 (2603:10b6:208:238::21) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA1PR10MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6cdd19-6382-40ab-8d3f-08dbd3f91ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xF+rngW9pzQMKFG/uXr/Qush30En+HX/SbGJ10NsY3HT41LyRchqWMov1/wceVeIWJl+2nDpdbdPgW775YHO4aa1uBuvZSlIrinGu0oJCKo2Hty1Mm9ToplVIpqW0irdDbWJzrKXqVMM4SgiC9qS1WxL2K+EOr9UG2/QvkGA2W4k/IkkK3X0gkdWfEdLKFeV4KhsYIDhP/zm6x0RR1GLuvgihGTgVW5MK2hMNvKA6ORpf6SSLCRmgLHA2xCuRB2hCruqkcEjhCReSBQckzvOxNPFKkN/aMDOLUptv6stNds4VosNE6JyYRoES6JaBpNiLCl15Bwz2pchSCsm4OB7zPXnF50H/SqpdZH7IPhoxOS7bOQZ+7cbOwpR7l9PEdDOJyxPlmN5WyIniVFqPU/y7++NFPwM240eSCM7Sdc9JYzHnybcXkLepbhpddJg0Gle2SQDR1DitqD6K9ogwOtvU1yRAVFInZWD3P02dNp+OxXE89AFv46Cx3l5OLeCrYm5+b+2S9MA7ZHYHsGLIy4gsCidFKclOewWs/la6vnGErPkYFbVW2b4tJgEojOfBtKhkEwmzSeHrlS6MMXhy7wGKnK7309djJZM2mKojYnywnr64XOS+UFu4BhVdmpm2emXG5EyR5Y3/A6pzo7iFtaMCm3sxDam5YGrUZWnLYf97U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(966005)(44832011)(4326008)(8676002)(8936002)(6486002)(41300700001)(66946007)(478600001)(86362001)(36756003)(2906002)(31686004)(54906003)(316002)(66556008)(6916009)(5660300002)(66476007)(31696002)(53546011)(6512007)(36916002)(6506007)(26005)(2616005)(83380400001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0Faeml2ZC9NemptQjkrQytXVGdGcnZ0aUdFVVBYODJWQXZncUJYUWJXQzho?=
 =?utf-8?B?U1IvcjlSOU4zdEJ2d0QzSWJ5emVPdzN2QjVXdmNpSkUzaDQwallDckZHV0tv?=
 =?utf-8?B?NXI0bzc4TWZjemhiZHd4cE1LS0VFZkJNRkRjUndTdG8zbU1vVEZUc2tHQjBB?=
 =?utf-8?B?WlorUEdOTCtXZHFsQ0J5RkFVWmVwYk1JT24weXZVVDdtZ1l4U0tCeHNpbXFC?=
 =?utf-8?B?a1V1RXhTTHdEaG1HM3ZkTTdUcnNOR3lrcCtmaHBVZS9wT09LcTVDSVJmci96?=
 =?utf-8?B?UWVmM0tQMjBaQW40OTh0SjMvM1dFSUpJNmpLWG5idW9hTVZCYkxleE5EbE1s?=
 =?utf-8?B?NWlGVGF4VmozR2hVa0JZd3FEeVYwL2QzTk1qWHl3bUw0eDF4SGRwQlRtb0hQ?=
 =?utf-8?B?UkxtU1UxSk1leDk2MFRQSUdVeVAyMGYwajhzWHp4T2hadUlqL052dWMwU3Fu?=
 =?utf-8?B?VEFObmdFMER0ZER5WjdlUHcydVV6UVM2V1Bod0dzVjdCbTZMRDU2R1NTWXZw?=
 =?utf-8?B?akIycTFmZFdkeW0vVXpvZlFrSEpXZUorM0hnU09ZaEVXdVlKUTZqaHM2OG9C?=
 =?utf-8?B?QW1weFZEanAxZ1FXM0trZC9HeHVVYnRHa3Z0UU0xRlNmWVE4bjRMVlVqMDZU?=
 =?utf-8?B?Qjh5Y29tTG11TmwweHNnSDcrNmdrY1VQOFRIdlBpSGIrRHI0SUFhcUtZU0Qw?=
 =?utf-8?B?Ukd0VHE2M2NaRkpvVG9nVERmWHJBMzA0eHo2U245V2RqZmhjdTBORll0SERk?=
 =?utf-8?B?ZllneC81Rnd1MFR1bHBJRGZ6OWVlRE1iQjV1ZmUxUFhwVTIwS3FHRWdML0w2?=
 =?utf-8?B?L2hTNVljcmlmc1ZLeXRwK0lWblJIRGRzRzdmNERkUE53T0JTV29ncGI0cWhi?=
 =?utf-8?B?T01vRU5UMTRYMEVUN3ErdERVZDNlNzZGME1aTTY2TVVOTjZ6Rm0vNXlNaDZP?=
 =?utf-8?B?aENEVzFveXhLUHhQQ3ZKdFBoOUtvd2lPTFVRNDhaR3hEbXd3c0M0UTdRYTVL?=
 =?utf-8?B?aXlKOHVMc2p3SmJDSGt6elh1NmJ3MkkxcGxkaXUrME85T0V1SXBxRFMrcEs5?=
 =?utf-8?B?TkttZ1FzMFVpaENEV1RJUVBuU0ovREU5TGRVL3hMVWRDTXRyRHVTdnhGaTBq?=
 =?utf-8?B?YmxURGdiRGhSR0IwbTQ1THNGbyswbzJhRTczVi9GcitjZXRzajgrU200U3Nj?=
 =?utf-8?B?VlVWbmI2VlpoVXFLanlmRVZxNE9NZzNVRlQ3VkRHSGdzM0FpbDd2aVNQRXdk?=
 =?utf-8?B?L3owQURBMGRpK3FkdUViaHMzdjRCdExxaU1Nck8wRGFjdXlkMzFCbHQwUVBh?=
 =?utf-8?B?cjZaaEFkcFkyTDlKUzJXQ3NLcVYwakhqekF0dUlFalhSeG5tdjgvQll4RExO?=
 =?utf-8?B?ckRGYUZOdUQ4ZDlrdHVrK1FwditHNUkxSHdTNEd2KzV1NmIzbHM2MFVJZlBP?=
 =?utf-8?B?QnFLQkJDOUcvd3dBRFBMZkZ2Y2NNV1NzVFpDMHNIRnZjS1JSc3dnSmhtQjRs?=
 =?utf-8?B?NTExcVZYdmRiaWhrWHljYTNUdDhxZEhIeiswbUFTTDlpcmorZkhJK0tFb0Nu?=
 =?utf-8?B?OUVPZG5lUXpIMWczVGxCblo2VmNudFp2UjZ1d0tBM040QldYRCtOQ3lSQlIw?=
 =?utf-8?B?c0RhZm8zOXNnTTQxYnBrc3dzMWtIU0trSW5DWjNzTWdrUXRRK3ExcDBCbTFo?=
 =?utf-8?B?ZUZ2MzJvZjlBd285ZitzdmU2T3NmQXhoME5ya2pwNlhCSFpvYnpLTk91Z0dC?=
 =?utf-8?B?cW5WZzFWQ203a0lYOUVBdjhwTTNYanNYK01WeG9TcG1NOVA3R1o1Vk9kb2Vj?=
 =?utf-8?B?T3dyRlc1emZZbElhRlI4T3dRMHN3QWtPODhwcTBxOHo4NzNWZ2dHQXhCaGJs?=
 =?utf-8?B?QSthTXF0N211a20zL20zbHBWNTJteGNMUWFROE1vMFRWR0JlMVRzZVRFNWJE?=
 =?utf-8?B?ZncyLzFkUTBIUnp3ejRXQ0RDcU9LQ09MQ09pWHhNRXRhOCtZT3lyVUplY1U5?=
 =?utf-8?B?NUluakhnRWUvRzNaVENudFJ2eWFqNjBqS2lMc1F2TXFoZ09rcys2Q0pPSUFq?=
 =?utf-8?B?aHV3WkhHRHBTMHM2WlQyd3lJVVZEa05iWXFISFZNd09XL1R6Y05vYWhQdTh4?=
 =?utf-8?B?anArRU1rUFg2akhCRGUrcDhPUmp5aXZvM05tNmJ4MVFrd2N2Rlo5b2dEc1I3?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2gz2dme5h1OECsbj/FWWKadMlrY3m50ql4PJJqZYoRtSzJ8lXTEqxwYfAKrgzrYcMfrgtUWDniSYdQJAcBsDRf6BzZv1UcOHHJtNDHhlwCM++j3j2aQPpMsOCdhus7HHjjXWFdFx8zCQ2juR2B6mR3jOTelaGXwX0XIEHl+0wlH43fftlwXCaGv2JfV1kN2DZ5Gk3di3gxPzdw4G24zi/k5f1ItLL23OZVBNiTzHj//IRV2Sg9U2zGhVSntU/CVHxLKXEqqI27Ju/WHKe/DhaU4D1hxPhXzj6l2csotW1a1++mxHr7v21D5KnrkF1QVpJOUyailfLCCFOFnROy5CZXwHUHeFlYkqVCpO2DLB6AENYl/MBejL1zJDhmgjVL/F2WvAFcLaTKk4zYDGsbROzSyyh6eER0Yso8DiAxIQ+SDGV1z6VcPd/Z4QBzUCrO6nuyvf2wyw67Yelhf7UwxfC+O9UUYpC22yr1o0rReeqRQtoD6OJNg1IXxDfRrORLuqIOrDyPkFShxXnSrMFCi+TCfECJYJXl/GRhFymc846kBnmy7LKumgNaRH7m1FeBKUiLCbdfPSUJEBWGciCfydACMCFQtUdwmYlOtzqb4qSvvUTRkO7Rm2TVE/UotsMv8wDbRgep6dYGrUk7u3LhPmLqEGxqZwp6PMkFGD+QCIXwbDq7VcQA2TiWp5gP8k3tZvbGLv/KL046apC8biG97y3HSQmhYEgRqKJzHqsqqi89oAWNSEPGAF8CYF5pGY9LXbc8gAgLOpBmwtUQ2wTEMpFiGg5s1Yk5PJAKavrpvAHJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6cdd19-6382-40ab-8d3f-08dbd3f91ed4
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:51:52.4088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+w4GVVHYOPqYKl0n6x0P3arwWKRBwzd2OGhp3M/RXOoVi/CrJWfCFjhzJ3tE5P7oINkpFU7TuC6JeVVmzdw2DqW8SgTC8WBxDQOSPqsP+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6390
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_18,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230165
X-Proofpoint-GUID: cb_e9_Ufnai9mPjHwTB9Injh2T1f9XcM
X-Proofpoint-ORIG-GUID: cb_e9_Ufnai9mPjHwTB9Injh2T1f9XcM
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 10/23/2023 2:29 PM, Steven Sistare wrote:
> On 10/23/2023 11:39 AM, Peter Xu wrote:
>> On Thu, Oct 19, 2023 at 01:47:46PM -0700, Steve Sistare wrote:
>>> Add the cpr-reboot migration mode.  Usage:
>>>
>>> $ qemu-system-$arch -monitor stdio ...
>>> QEMU 8.1.50 monitor - type 'help' for more information
>>> (qemu) migrate_set_capability x-ignore-shared on
>>> (qemu) migrate_set_parameter mode cpr-reboot
>>> (qemu) migrate -d file:vm.state
>>> (qemu) info status
>>> VM status: paused (postmigrate)
>>> (qemu) quit
>>>
>>> $ qemu-system-$arch -monitor stdio -incoming defer ...
>>> QEMU 8.1.50 monitor - type 'help' for more information
>>> (qemu) migrate_set_capability x-ignore-shared on
>>> (qemu) migrate_set_parameter mode cpr-reboot
>>> (qemu) migrate_incoming file:vm.state
>>> (qemu) info status
>>> VM status: running
>>>
>>> In this mode, the migrate command saves state to a file, allowing one
>>> to quit qemu, reboot to an updated kernel, and restart an updated version
>>> of qemu.  The caller must specify a migration URI that writes to and reads
>>> from a file.  Unlike normal mode, the use of certain local storage options
>>> does not block the migration, but the caller must not modify guest block
>>> devices between the quit and restart.  The guest RAM memory-backend must
>>> be shared, and the @x-ignore-shared migration capability must be set,
>>> to avoid saving RAM to the file.  Guest RAM must be non-volatile across
>>> reboot, such as by backing it with a dax device, but this is not enforced.
>>> The restarted qemu arguments must match those used to initially start qemu,
>>> plus the -incoming option.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>  qapi/migration.json | 16 +++++++++++++++-
>>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 184fb78..2d862fa 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -620,9 +620,23 @@
>>>  #
>>>  # @normal: the original form of migration. (since 8.2)
>>>  #
>>> +# @cpr-reboot: The migrate command saves state to a file, allowing one to
>>> +#              quit qemu, reboot to an updated kernel, and restart an updated
>>> +#              version of qemu.  The caller must specify a migration URI
>>> +#              that writes to and reads from a file.  Unlike normal mode,
>>> +#              the use of certain local storage options does not block the
>>> +#              migration, but the caller must not modify guest block devices
>>> +#              between the quit and restart.  The guest RAM memory-backend
>>> +#              must be shared, and the @x-ignore-shared migration capability
>>> +#              must be set, to avoid saving it to the file.  Guest RAM must
>>> +#              be non-volatile across reboot, such as by backing it with
>>> +#              a dax device, but this is not enforced.  The restarted qemu
>>> +#              arguments must match those used to initially start qemu, plus
>>> +#              the -incoming option. (since 8.2)
>>
>> What happens if someone migrates with non-shared memory, or without
>> ignore-shared?  Is it only because it'll be slow saving and loading?
>>
>> If that's required, we should fail the mode set if (1) non-shared memory is
>> used, or (2) x-ignore-shared is not enabled.  But I had a feeling it's the
>> other way round.
> 
> Juan also asked me to clarify this.  I plan to resubmit this:
> 
> #                                        ...  Private guest RAM is saved in
> #              the file.  To avoid this cost, the guest RAM memory-backend
> #              must be shared, and the @x-ignore-shared migration capability
> #              must be set.  ...
> 
>>
>> Reading the whole series, if it's so far all about "local storage", why
>> "cpr-reboot"?  Why not "local" or "local storage" as the name?
> 
> The use case is about rebooting and updating the host, so reboot is in 
> the name.  Local storage just happens to be allowed for it.
> 
>> I had a feeling that this patchset mixed a lot of higher level use case
>> into the mode definition.  IMHO we should provide clear definition of each
>> mode on what it does.  It's so far not so clear to me, even if I kind of
>> know what you plan to do.
> 
> I believe I already have, in the cover letter, commit message, and qapi 
> definition, at the start of each:
> 
> # @cpr-reboot: The migrate command saves state to a file, allowing one to
> #              quit qemu, reboot to an updated kernel, and restart an updated
> #              version of qemu.
> 
> The cover letter hints at the cpr-exec use case, and the long V9 patch series
> describes it, and I will make sure the use case comes first when I submit cpr-exec,
> which is:
    * restart an updated version of qemu     (I buried the lead - steve)
>   * much shorter guest downtime than cpr reboot
>   * support vfio without requiring guest suspension
>   * keep certain character devices alive
> 
>> I tried again google what CPR is for and found this:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08541.html
>>
>> I also prefer spell it out, at least make it clear on what that means..  I
>> didn't even see "Checkpoint/restart" words mentioned anywhere in this
>> patchset.
> 
> Will do.
> 
>> Besides: do you have a tree somewhere for the whole set of latest CPR work?
> 
> I have the V9 patch series:
>   https://lore.kernel.org/qemu-devel/1658851843-236870-1-git-send-email-steven.sistare@oracle.com
> and I can re-send my proposal for breaking it down into patch sets that I presented in the
> qemu community meeting, if you did not save it.
> 
> - Steve

