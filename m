Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 967927D3984
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 16:39:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quw4r-0003IQ-I6; Mon, 23 Oct 2023 10:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1quw4o-0003ID-NF
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 10:38:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1quw4j-0005rJ-In
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 10:38:42 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39NDSqcQ028484; Mon, 23 Oct 2023 14:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=pE4WKyhRqr6gF7GB+KTh/8DGytcVvKrzbg46iIeaOHA=;
 b=WRcA9SM/0fP6ZjqV08W4topKBh1zRHjD4AM0v90fhPPOqkXeUSeNE47EiFr+YilEi2sW
 SEQJJdMWvaf9JKpeuwGxCiX5RhIZiomNoDyRuTk00jGp8cXZIdKN5kFjDy7RrKj4BDBX
 Bqx/1fbh4541fr4MoNjuXhNeL/SHmYOp711w3nZtsgPKPcAfC/S33sAIXexMdAnBPpIT
 qYx1cG3bQOk9Rr/TfuI6HArxwiYY77jG/o0wL0yQQC7vgQ5r76l2EQQlqu/0XfraYJ7j
 T146NE6DD11JtmLcvoRZaZnKWNr9sKLeZ9qKev98cpJHwxDeYtNLDPPT+ovzWLxfzUHT 9Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e338q7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 14:38:30 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39NE9ALi019014; Mon, 23 Oct 2023 14:38:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tv5349bnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 14:38:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhalCOdgqMGP4aPwAC6vrLxifB9UnfCQcE12t+pNYg7t7PMJSziZEhzxi0tBUwUfZhX5J7os62Cc+rem6uOF1K4JxIALWloxKTAF8kok/3edhkqViXFGk+4gSFXZ9PMkM6TBuRZa6vlOqnt6aVo6igT4MKwGVDDgpoNbon/5G2rabWMZOM89TYB+qDNj3w2bgvg91bsW0E+wAlRUbq15BInbX8J/jkttAugW55xMrzEi4VhI2u7YpgSxezDrslptmX8MPhHG3ZaxuUKbEr0RHvnlCho1UoHHCgWz2ZeynVpLx5ASqFqVLYTJyb2ocGiPovK+mtpF6x08yYkiTARuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pE4WKyhRqr6gF7GB+KTh/8DGytcVvKrzbg46iIeaOHA=;
 b=S78z9mbQt5yjsXqy7D+YIA9adRA6mzJg57wV0R4e5XNbPKGHZ1PMS4vtyvC8z9sB13vBe+ro1DBWjJGoQnXrxbov7E2fy2nZr/6DTSrODNCeDyH89dgkXZ6VlraFXAl013FWFNyYKuhteh3n/QAT5JR2qs+ET8f8iPN2Vuw5tqRfFbkIlTHYhEx3LFq5O5hm/p6mQFrYcV413m1y1RIk6sD1HXzd+V14FBn/EflzFF4lOUEMe0BpqFp3lFkDa7/T0eAUQkgBynBtaW1kLBr1IhIfXAcQthxL3NEJLsaqQcMAkNQChptYaOFQ5SkoZsQjGCsUGKpDKwCPOpr0qRp51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pE4WKyhRqr6gF7GB+KTh/8DGytcVvKrzbg46iIeaOHA=;
 b=LAM15ffkhOjMrAwTR3p6NOKSeuKqPGEqePyRPYd7pB5rQdHrRRvnNInUtTwtHwWEd7/Uk4A4SlZ2okaePTiPgc+Lub18qRD7cl7azh3Jwtas1QxNbTckgNf5w6bfOEQypHa2F8jDY4sIIWABHfQ12TAkRgV94I4VPqwyEbGYEW4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS7PR10MB5070.namprd10.prod.outlook.com (2603:10b6:5:3a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 14:38:02 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c305:4801:5bd7:4775]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c305:4801:5bd7:4775%4]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 14:38:02 +0000
Message-ID: <61ccb916-e50f-4b05-a5bd-5fcf8bf0177f@oracle.com>
Date: Mon, 23 Oct 2023 10:37:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/4] migration: per-mode blockers
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-3-git-send-email-steven.sistare@oracle.com>
 <ZTZrOb0XqOWPwFQj@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZTZrOb0XqOWPwFQj@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::21) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS7PR10MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e99a69-a08b-444b-03b8-08dbd3d5a8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0UjUI8nxNWTLGSyw64ui6LAMKGuA4fyocd6YE2PezF8GS/5cOGQdIjlp3Q8d67NjK+QXPRrFF04IM2LR6JF+SPwIXxTTcaM4S5krPSL3YTRx+vDvckUE64xVIgYl+c5uCabD5VasbVm+EC4HfpEcy73VpTNxi0jpIRvtrfikoUHnPAUNfqicnmHiDgN5/9gamu+HaBeLFN91jndxC8aTlis94wKqQmWQE/CCqRQlN4Xik4G3FBcg923vTxOptP+j0y7LxYtgjBSidXCbDawFHELitaFxVMr4KCLoGSriRnqzswlS8GuY8JmGTHUJs6Q7X+lF03JIvOYUax+wqhaVCCW8YHQsKvatBYMo9rXA0TEgTNZ74T04ow8h9UyDxqAJSGbU1WL2COXlFD/VE5Py8/aY8uU7LfHbYckoPtNupNK7TDslDkMl78NyEWI3QdJda9LXi/ohW9Rp6ywxiJv4ZPi7HKCWQFngZ95ZoGVw1OBo7QmSNIXwHUvP3ii8TrjzLcbllTCkH28iQwC0Y00dzCYJSsJ6gn3d0CXJTxKtp5bWAeouWhxuZ8ZYk1zZSErW0TvuoHq1V2IBR8Dyx/mx0JtKpAgb/kc/ggA0qOpPO9W6+s0LMvwrEFcw7lixF55je6uMpmrbYwzWmTTmzd+dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6916009)(316002)(66556008)(54906003)(66476007)(31686004)(478600001)(31696002)(66946007)(38100700002)(86362001)(36756003)(26005)(44832011)(4326008)(8676002)(8936002)(6506007)(83380400001)(6512007)(6666004)(2906002)(41300700001)(30864003)(5660300002)(6486002)(2616005)(36916002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFJRU3ZCMlVwN3VsR3pnZXRhUnNuNDQzVGdld1kzRWxkcVVTZlR6NmNqS3RE?=
 =?utf-8?B?bytpOVF0Tk5RbzVVZzF2SXc0Z2JTTlF2RlRJejh1YnJMWTdFRUczYzl2bENV?=
 =?utf-8?B?ckI2djJQazd3OFltN2dJK2pSNm1KbUdrdVpKdkdldU10T3p5Z2FsQ3VJZnZG?=
 =?utf-8?B?NWJjV0FDbUFpdmFvSGdOZzZDR3RKcWorMmx2b2NnamNxaHVKWXBCck1qVFVx?=
 =?utf-8?B?ZVlhK2FPZ0Qyb2VzZzVFdmdKalg4eDZJNFBHOWRvRHpmVzdxbVVUclAvYllE?=
 =?utf-8?B?WksxRlp4cGFkN0Jwdi9PRFcrMDZwRnpISXBZTEh6VUJUMzBxNTZ4Q0dwWmVD?=
 =?utf-8?B?cHVWcytZcEdzY2cwdmwwMjdqMTVHaE1jUy9wMUNDSFBjVDJTK1hzUXE3Z2ZY?=
 =?utf-8?B?Q0pxWGU0OTNNdkVmYmttL0IxOHhWUTEra1E2UlA5SUcrRVZNSGF5Y242WWl4?=
 =?utf-8?B?VkdZMXdjaUxzclVPZWpFLzYvWVRKL0J4NUxTS3pjSU1tc0FkU2RORUpzR0l5?=
 =?utf-8?B?U1lBbWE2bGNKczlWUGZsY2pkQUMyK3l2alZTbzdxL2pkYnFNK1lRRFN5NlZh?=
 =?utf-8?B?aUU0M1JtM3Rkb0RSK2Y5bHE3bTlMSW5pSE8waitrc1pqUlFoVnNZWGo3QVo2?=
 =?utf-8?B?bkFleC9ncUg4ZVVWUVNTQ1VDTnBOQzQ3c2R4Q2xmRHpXVUU5a1dSbzMyc1U4?=
 =?utf-8?B?UWRJdmlJMGV4aXdneGJTQ3lRaWJWamdwZU5ncmVxUmxQL2ZmUlgrakhJcGNx?=
 =?utf-8?B?OXNaQldhNWIvTFRGQ3gvaUczYjFCUkhkbTNoL2txNUc4WHhGcVNRMFh6QkNS?=
 =?utf-8?B?YmdnK2FCT3dLUldxSld0M3ZpU0NRVmZTMHo1M1piWGlySTVXUGN6dG9mM2E3?=
 =?utf-8?B?OFNYbStVeHJ4UmJIOWZwQkhWVHNjS3JlYk9MYUZkZkVMbzBwcytFZXdyWVpw?=
 =?utf-8?B?Y2dZUnJQQ0duRUdKZzVrdTlmQ3VkUXkweVR1clJRR05remxGZVVvYUZmSWN5?=
 =?utf-8?B?Y29YbXFJSm15WUZ0S3dvY01hTis0b0ZTcVRJMXU0VmVvaDRqdXdXcWsxRkVK?=
 =?utf-8?B?NmR2RFRrcllCVGt2cXFiRnl0QnNLYVJuMElITEhrb2dRT0piTEFiSndLTG9s?=
 =?utf-8?B?T0FHR3pqWFdwM3IxZ2IyZ2Nvbk1ycDlqY3FtYmcxZ3NZcVZCWnNNVmtHZ1hK?=
 =?utf-8?B?bFZlczBiUUZhazVFS1k1Ync2c3pkYUU1Ynh3TzNpOUtXODM1cnBqNGQvcnRn?=
 =?utf-8?B?TFYzZWxVeUIxZjNza3QvN2JjUkY3WStKMVhySFVSdkEzb3U1eTJVQWxqMVls?=
 =?utf-8?B?eGRIQmNOMHNFWjZQZVV1dTY4MzRoZWpVZWdvWHlGcERvQldtWlF4SHZTZHhz?=
 =?utf-8?B?aTZDRUg1RkNwcVQ4ZzlYeUppa3VmSUJrcjhDOEljQTVPZ3ZHUzdOaG1vLzZT?=
 =?utf-8?B?MXI2TklBMFV1cUhHVDFnM3VmaFY5akVJa01vekxUZWpwUzQ3dk1WWC85YjRj?=
 =?utf-8?B?aytjTHBiSTNxZWlFWHNRNzZLTzNQZjlZM2I0ZHc2U3BHb1FYRzd4WnZJUitF?=
 =?utf-8?B?cW9UellWR09FMW9NN3NHK041QmhvWDBuQmRkb0FFVEVnQThHWnFoNFNOWnlw?=
 =?utf-8?B?RDJ6WUkxdG9hbm0wNEs3RHphaGEvZEp1Z29GNENlRmpqaUl0Z1RFUThwWnBu?=
 =?utf-8?B?bXFza3RJaE5jdnJGRngrNmxOcTJKU3FVSHJ6SXdkZWZRVHluVUNSaVgxWlh4?=
 =?utf-8?B?M3A5Vlo1YnkyNGJhRkVXQ0lCMkxPQ2ljYS8vNGozYitVZkR5THdPbHdaU0dh?=
 =?utf-8?B?RTg2SUg3eWJXUnpadkh4R01RTmdFQzQwS3R0bXo2d3hpS2ZOeXliQVNHZkpq?=
 =?utf-8?B?SFZ6aXRQeC9nK2hYTzBtYS9ieXRucEVubldjL1BpNm5WT051NnNWa2sybGha?=
 =?utf-8?B?Um13YzNjMklUbVRtRldwNHVVYUhFOTNGRlZhcDFYVklzYVNaTkV3eU9iMWE5?=
 =?utf-8?B?eHNuckE0dlpWZThSSnB6TWlqYmZwV1FNdkZ6Qzk3L3B4SDNtNFFIeFpvUk81?=
 =?utf-8?B?MGF2QU5sMDJ6NDdtSGZCNTlNL0NVVCtHZUpLckZzaS9xN3RoakpVakJUZEtY?=
 =?utf-8?B?d0pDNVgvcUtUMU5Ta0J2ZnRERURIeFpENHdzbFRvUU9UYTdWL1ErQXNUakV2?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8GBMjMYfXQPI6fw67PkmPLfF1oRYeidv6K55WDluiPzZsQiPFXwxUF/nwziezqtrbDBARAzLFbDQdewdLRbUjFutMWUqzbF7HZalMnZccjoZHwsPixxuPGHhUFRjmCw315VRdtQxC1kYlEwOGsWzpGXAPmhVd4N+Rkq2Ux8Mco1YdWazAwxnjTFPp9NALarmPv0m7cxXg3f+/M+3hs5GhIIRe/8gWZdglAmihBb/Z/HGQBQuoCD9/QEtNZebhWk6qonQHsRFJT7zJxlwYTvSfDKUEQ9kSxpDoaUWYRcby5OuEvidpIW1nxWuwkVbwMZ2X2BGGzFad79SnFx77BvXcpH2pREVyIvZMu69eNo04koQEeJZxt+RTojYkXXWgLlQJ8n2+ed49Y4prkho7bMM5tw4/IKG7Rt+JB9b9WwnyDCL/ScJF3cBahNu9QSFGssQC6GBJ7ltnfciGdeEewrIjojWfG3SH/I3O3Mv30W8bw7iNwuyNOpUa8rG0FysuRCFEU/FmwFI2N+SVPacKZ9nqkNU1f9QOBon7R1t3GGnqMn+HXSoEcfDHylF2BzzInfwe8yAB84yEj46fbtca791tAw1j9zrTulBhSIF5/rPFQ+5I2lNjVdu2ovvemBIueXm8uwxQ1UkrX7UoprwLTILQsEmPt+GJtv9xvCgMFQubzGb0hVN9ioZhqn91nfcTLaKcXXQKlnX+z9slcIpsgweYyCZRefH1MW1194z3MW6M477UfCo/0MrYkE3Jk2wdUh9AaF0hnstSLoJWKErYqY3VkGdIS4KogrHlljI1MC9S80=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e99a69-a08b-444b-03b8-08dbd3d5a8f2
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 14:38:02.1830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kucw0Lxjtiqpkb7NDPVb609cN+zh30QYm73iYqxl+6e6Yo+ub/PrAsd9wXCSTyaW7u1VIr9SHK769TyDM0/MeP9DjhPgOSXqqipQoRTGgAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_13,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230128
X-Proofpoint-GUID: G6lLCFDC0b0bdnUyxfKM64K8Bwkcc9K9
X-Proofpoint-ORIG-GUID: G6lLCFDC0b0bdnUyxfKM64K8Bwkcc9K9
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

On 10/23/2023 8:46 AM, Daniel P. Berrangé wrote:
> On Thu, Oct 19, 2023 at 01:47:44PM -0700, Steve Sistare wrote:
>> Extend the blocker interface so that a blocker can be registered for
>> one or more migration modes.  The existing interfaces register a
>> blocker for all modes, and the new interfaces take a varargs list
>> of modes.
>>
>> Internally, maintain a separate blocker list per mode.  The same Error
>> object may be added to multiple lists.  When a block is deleted, it is
>> removed from every list, and the Error is freed.
> 
> I'm not sure that assocating blockers with migration modes is
> the optimal way to model this.
> 
> IIUC, some of the migration blockers exist because the feature
> relies on state that only exists on the current host.
> 
> This isn't a problem with CPR since the migration is within
> the same host.  At the time though, these blockers should
> likely be redundant for a normal migration that uses "localhost".
> 
> We can't express the distinction between localhost-migrate
> and cross-host-migrate historically, but we should have done.
> This new patch largely enables that I think which is good.
> 
> What I think this means is that we shouldn't tie blockers
> to modes, but rather have different types of blockers as
> a bit set
> 
>   enum MigrationBlockerType {
>      MIGRATION_BLOCKER_LOCAL_HOST = (1 << 0),
>      MIGRATION_BLOCKER_CROSS_HOST = (1 << 1),
>   };
> 
>   #define MIGRATION_BLOCKER_ALL 0xff
> 
> 
> Cpr would check for blockers with MIGRATION_BLOCKER_LOCAL_HOST
> set only.
> 
> Normal migration within localhost only would similarly only
> check MIGRATION_BLOCKER_LOCAL_HOST
> 
> Normal migration between arbitrary host would check for
> MIGRATION_BLOCKER_LOCAL_HOST and MIGRATION_BLOCKER_CROSS_HOST

Or, we could define MIG_MODE_LOCAL to relax the blockers for local migrations. 
The user would add mode explicitly to the migrate command, or we could 
implicitly switch from normal mode to local mode if we infer that the src
and target are the same node. MIG_MODE_LOCAL and MIG_MODE_CPR_REBOOT would 
relax the same blockers for now, but conceivably that could change.

When I add cpr-exec mode, it will have its own mode-specific blockers.  
But, in your scheme, it could map to a new MigrationBlockerType.

I do prefer mode as the way of specifying the type of migration.
The question is whether we map mode directly to blockers, or map mode 
plus other criteria such as locality to MigrationBlockerType(s) which 
map to blockers.  

One consideration is, how will the user specify the equivalent of only-migratable 
on the command line?  I was thinking of adding -only-migratable <mode1,mode2,...> 
in a future patch, but if additional criteria maps to blockers, then we need 
additional options or syntax.

- Steve

>> No functional change until a new mode is added.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  include/migration/blocker.h | 44 +++++++++++++++++++--
>>  migration/migration.c       | 95 ++++++++++++++++++++++++++++++++++++++-------
>>  stubs/migr-blocker.c        | 10 +++++
>>  3 files changed, 132 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/migration/blocker.h b/include/migration/blocker.h
>> index b048f30..a687ac0 100644
>> --- a/include/migration/blocker.h
>> +++ b/include/migration/blocker.h
>> @@ -14,8 +14,12 @@
>>  #ifndef MIGRATION_BLOCKER_H
>>  #define MIGRATION_BLOCKER_H
>>  
>> +#include "qapi/qapi-types-migration.h"
>> +
>> +#define MIG_MODE_ALL MIG_MODE__MAX
>> +
>>  /**
>> - * @migrate_add_blocker - prevent migration from proceeding
>> + * @migrate_add_blocker - prevent all modes of migration from proceeding
>>   *
>>   * @reasonp - address of an error to be returned whenever migration is attempted
>>   *
>> @@ -30,8 +34,8 @@
>>  int migrate_add_blocker(Error **reasonp, Error **errp);
>>  
>>  /**
>> - * @migrate_add_blocker_internal - prevent migration from proceeding without
>> - *                                 only-migrate implications
>> + * @migrate_add_blocker_internal - prevent all modes of migration from
>> + *                                 proceeding, but ignore -only-migratable
>>   *
>>   * @reasonp - address of an error to be returned whenever migration is attempted
>>   *
>> @@ -50,7 +54,7 @@ int migrate_add_blocker(Error **reasonp, Error **errp);
>>  int migrate_add_blocker_internal(Error **reasonp, Error **errp);
>>  
>>  /**
>> - * @migrate_del_blocker - remove a blocking error from migration and free it.
>> + * @migrate_del_blocker - remove a migration blocker from all modes and free it.
>>   *
>>   * @reasonp - address of the error blocking migration
>>   *
>> @@ -58,4 +62,36 @@ int migrate_add_blocker_internal(Error **reasonp, Error **errp);
>>   */
>>  void migrate_del_blocker(Error **reasonp);
>>  
>> +/**
>> + * @migrate_add_blocker_normal - prevent normal migration mode from proceeding
>> + *
>> + * @reasonp - address of an error to be returned whenever migration is attempted
>> + *
>> + * @errp - [out] The reason (if any) we cannot block migration right now.
>> + *
>> + * @returns - 0 on success, -EBUSY/-EACCES on failure, with errp set.
>> + *
>> + * *@reasonp is freed and set to NULL if failure is returned.
>> + * On success, the caller must not free @reasonp, except by
>> + *   calling migrate_del_blocker.
>> + */
>> +int migrate_add_blocker_normal(Error **reasonp, Error **errp);
>> +
>> +/**
>> + * @migrate_add_blocker_modes - prevent some modes of migration from proceeding
>> + *
>> + * @reasonp - address of an error to be returned whenever migration is attempted
>> + *
>> + * @errp - [out] The reason (if any) we cannot block migration right now.
>> + *
>> + * @mode - one or more migration modes to be blocked.  The list is terminated
>> + *         by -1 or MIG_MODE_ALL.  For the latter, all modes are blocked.
>> + *
>> + * @returns - 0 on success, -EBUSY/-EACCES on failure, with errp set.
>> + *
>> + * *@reasonp is freed and set to NULL if failure is returned.
>> + * On success, the caller must not free *@reasonp before the blocker is removed.
>> + */
>> +int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...);
>> +
>>  #endif
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 67547eb..b8b54e6 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -92,7 +92,7 @@ enum mig_rp_message_type {
>>  static MigrationState *current_migration;
>>  static MigrationIncomingState *current_incoming;
>>  
>> -static GSList *migration_blockers;
>> +static GSList *migration_blockers[MIG_MODE__MAX];
>>  
>>  static bool migration_object_check(MigrationState *ms, Error **errp);
>>  static int migration_maybe_pause(MigrationState *s,
>> @@ -1011,7 +1011,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>>  {
>>      MigrationState *s = migrate_get_current();
>>      int state = qatomic_read(&s->state);
>> -    GSList *cur_blocker = migration_blockers;
>> +    GSList *cur_blocker = migration_blockers[migrate_mode()];
>>  
>>      info->blocked_reasons = NULL;
>>  
>> @@ -1475,38 +1475,105 @@ int migrate_init(MigrationState *s, Error **errp)
>>      return 0;
>>  }
>>  
>> -int migrate_add_blocker_internal(Error **reasonp, Error **errp)
>> +static bool is_busy(Error **reasonp, Error **errp)
>>  {
>> +    ERRP_GUARD();
>> +
>>      /* Snapshots are similar to migrations, so check RUN_STATE_SAVE_VM too. */
>>      if (runstate_check(RUN_STATE_SAVE_VM) || !migration_is_idle()) {
>>          error_propagate_prepend(errp, *reasonp,
>>                                  "disallowing migration blocker "
>>                                  "(migration/snapshot in progress) for: ");
>>          *reasonp = NULL;
>> -        return -EBUSY;
>> +        return true;
>>      }
>> -
>> -    migration_blockers = g_slist_prepend(migration_blockers, *reasonp);
>> -    return 0;
>> +    return false;
>>  }
>>  
>> -int migrate_add_blocker(Error **reasonp, Error **errp)
>> +static bool is_only_migratable(Error **reasonp, Error **errp, int modes)
>>  {
>> -    if (only_migratable) {
>> +    ERRP_GUARD();
>> +
>> +    if (only_migratable && (modes & BIT(MIG_MODE_NORMAL))) {
>>          error_propagate_prepend(errp, *reasonp,
>>                                  "disallowing migration blocker "
>>                                  "(--only-migratable) for: ");
>>          *reasonp = NULL;
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> +
>> +static int get_modes(MigMode mode, va_list ap)
>> +{
>> +    int modes = 0;
>> +
>> +    while (mode != -1 && mode != MIG_MODE_ALL) {
>> +        assert(mode >= MIG_MODE_NORMAL && mode < MIG_MODE__MAX);
>> +        modes |= BIT(mode);
>> +        mode = va_arg(ap, MigMode);
>> +    }
>> +    if (mode == MIG_MODE_ALL) {
>> +        modes = BIT(MIG_MODE__MAX) - 1;
>> +    }
>> +    return modes;
>> +}
>> +
>> +static int add_blockers(Error **reasonp, Error **errp, int modes)
>> +{
>> +    for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
>> +        if (modes & BIT(mode)) {
>> +            migration_blockers[mode] = g_slist_prepend(migration_blockers[mode],
>> +                                                       *reasonp);
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>> +int migrate_add_blocker(Error **reasonp, Error **errp)
>> +{
>> +    return migrate_add_blocker_modes(reasonp, errp, MIG_MODE_ALL);
>> +}
>> +
>> +int migrate_add_blocker_normal(Error **reasonp, Error **errp)
>> +{
>> +    return migrate_add_blocker_modes(reasonp, errp, MIG_MODE_NORMAL, -1);
>> +}
>> +
>> +int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
>> +{
>> +    int modes;
>> +    va_list ap;
>> +
>> +    va_start(ap, mode);
>> +    modes = get_modes(mode, ap);
>> +    va_end(ap);
>> +
>> +    if (is_only_migratable(reasonp, errp, modes)) {
>>          return -EACCES;
>> +    } else if (is_busy(reasonp, errp)) {
>> +        return -EBUSY;
>>      }
>> +    return add_blockers(reasonp, errp, modes);
>> +}
>>  
>> -    return migrate_add_blocker_internal(reasonp, errp);
>> +int migrate_add_blocker_internal(Error **reasonp, Error **errp)
>> +{
>> +    int modes = BIT(MIG_MODE__MAX) - 1;
>> +
>> +    if (is_busy(reasonp, errp)) {
>> +        return -EBUSY;
>> +    }
>> +    return add_blockers(reasonp, errp, modes);
>>  }
>>  
>>  void migrate_del_blocker(Error **reasonp)
>>  {
>>      if (*reasonp) {
>> -        migration_blockers = g_slist_remove(migration_blockers, *reasonp);
>> +        for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
>> +            migration_blockers[mode] = g_slist_remove(migration_blockers[mode],
>> +                                                      *reasonp);
>> +        }
>>          error_free(*reasonp);
>>          *reasonp = NULL;
>>      }
>> @@ -1602,12 +1669,14 @@ void qmp_migrate_pause(Error **errp)
>>  
>>  bool migration_is_blocked(Error **errp)
>>  {
>> +    GSList *blockers = migration_blockers[migrate_mode()];
>> +
>>      if (qemu_savevm_state_blocked(errp)) {
>>          return true;
>>      }
>>  
>> -    if (migration_blockers) {
>> -        error_propagate(errp, error_copy(migration_blockers->data));
>> +    if (blockers) {
>> +        error_propagate(errp, error_copy(blockers->data));
>>          return true;
>>      }
>>  
>> diff --git a/stubs/migr-blocker.c b/stubs/migr-blocker.c
>> index 17a5dbf..11cbff2 100644
>> --- a/stubs/migr-blocker.c
>> +++ b/stubs/migr-blocker.c
>> @@ -6,6 +6,16 @@ int migrate_add_blocker(Error **reasonp, Error **errp)
>>      return 0;
>>  }
>>  
>> +int migrate_add_blocker_normal(Error **reasonp, Error **errp)
>> +{
>> +    return 0;
>> +}
>> +
>> +int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
>> +{
>> +    return 0;
>> +}
>> +
>>  void migrate_del_blocker(Error **reasonp)
>>  {
>>  }
>> -- 
>> 1.8.3.1
>>
>>
> 
> With regards,
> Daniel

