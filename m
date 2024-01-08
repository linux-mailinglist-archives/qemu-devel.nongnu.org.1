Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA878277DD
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:42:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuZ1-0000vA-IC; Mon, 08 Jan 2024 13:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rMuYV-0000pt-16
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:41:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rMuYN-0004PQ-Q7
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:40:57 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 408ITxtO017118; Mon, 8 Jan 2024 18:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TXmJUUt3eZmenKblQswW9wbFV/P9M3tiBtvLQYpkLsw=;
 b=WXMpmFVHjwcIfw/4a7Kd2NzVx+2L8pewTGufGcpCMSre/ybJprJlGxwAoJm8NjQDoAw5
 lpyuCHjlMO+kOf0snLOeN8cAvv7knr6szg7N0SFJIwUPGsIke50v4M8W3ogQfMd4GTdr
 4HCs/V2a9WwBT0P+2J6hJz7BaefZvoU78pyT4TKNtU6g3sGQ8F0c29KgXamWSnjrdMu0
 drrGhMI3QN7vgBfGpLBOK0n34nvlz5fC410dC0XpuHnLVdSoS90iEzFEUyrz7pscXzpY
 MgmkICKHegixphHJ356oQcEPXT0RMrkhkhTi1N3UawHypsFT4GASKY+GuvWGD8Twh5RI bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vgpcs80tn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jan 2024 18:40:46 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 408Hw1It013860; Mon, 8 Jan 2024 18:40:45 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfura3qqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jan 2024 18:40:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnrT6E1QWfdwsMep2z+uY/oOVe2q4msUWC9Zg6r2fSA20biKgWXAiZf6AsZ93BKoBk54tjtNiHOzy8xfRxjMTWygIvKH1T+Ey7hDrODGs0mxbtlnkLTfoXXBKG605PQcF16NHmwOCOS6clf5ovZGHutA+wc9xzlY5hUzTQzr09Rz37WkAq9QxEwuaXYF/RgHvbrKKFanflRkBhds1NS0FUS2Q4QmBqCTa9e9BDoIShGkEsNTGcZvN0wkpMipUU65AYlETPn9RaDRQgw5Rl2i0eNrMtpYHk48ZCPyuMc9QPkRj1Ytcqo+2mJKtxWUxcNj+E8b5Z/w71iNc3xyJjdXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXmJUUt3eZmenKblQswW9wbFV/P9M3tiBtvLQYpkLsw=;
 b=GvxVLZ/YwubR7p1q5Tw2mX2YdAjC81+IsU8KG3N70LSihdOhWOKshwVd0YetYSqMB4Ofbqnxxb1gLtvN4DrWToJ3h/nbflJcnUpaRKXZNhJ6RqNcEzVWILp65cydmllCDOllmrZEi8QG6K8WgDrFqHJOYRgOOM8Av2AlHf2zb6KGpL5IHX3DjhpIXfu5faVYENLNB8f+VXJIdU0N6MeZItcdza7LYh5Q3SH5b9Ej81VYQVDcNRWj0oU1y7iCOqljU7CRJpW4C7zs9aUuhUTUxGwDeeTtj/sSU3+fvDPHxBSPA8VFF2nUTQUiyIVP8XjDAZz6biwJ46sxjcVPxw6NUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXmJUUt3eZmenKblQswW9wbFV/P9M3tiBtvLQYpkLsw=;
 b=csGXixTxthjFh0BBKHPFAeI3EX8NJW1Egcsmi/YZohwD2U05ZnbIEXY6zaFocC4k0D55NA+M3q3PBFcGggnL6fvoiAXWlYiSLpXVU4KSjdyhJJo1PGqr3O5MbtI5PKmw3zoBNt10Jib2XHpbJALvBGB3HQRAyo+nnYBq+vxvc80=
Received: from SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16)
 by SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 18:40:42 +0000
Received: from SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::c538:6e0e:fcc6:a529]) by SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::c538:6e0e:fcc6:a529%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 18:40:42 +0000
Message-ID: <1854ecdd-88d8-462d-aa0f-990c2bbe57ff@oracle.com>
Date: Mon, 8 Jan 2024 12:40:38 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] oslib-posix: refactor memory prealloc threads
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240108151041.529716-1-mark.kanda@oracle.com>
 <20240108151041.529716-2-mark.kanda@oracle.com>
 <2be78fc2-f76a-44de-8db7-fbc1bbdc0d2b@redhat.com>
From: Mark Kanda <mark.kanda@oracle.com>
In-Reply-To: <2be78fc2-f76a-44de-8db7-fbc1bbdc0d2b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:510:323::27) To SA1PR10MB5841.namprd10.prod.outlook.com
 (2603:10b6:806:22b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5841:EE_|SJ0PR10MB4752:EE_
X-MS-Office365-Filtering-Correlation-Id: c17afc48-1b0c-4ce0-5c4a-08dc1079517e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +RQjOiqHENst8KPTxHCOaJ+JwM7/in+Ke7iq5WdWF721uk/hQDZcd3qmGuTOfpU2DNglxwwkEMqH2wCyjWpEaVSJgSJZLq/bbVaakZgWL13pfcrfYa3qTG8qmZXOKmuGniEKE85Sw/LEkTf2y3r8pjNQi0M4xNrblqyTfqEygUtLP3oCHBIgIYzvLZISvR4O6cPSIOmi/J88uL7wW2dd3n8tHAocr6SbnYpAi+/CtaNdPolC/pB1EQbXiWwdiRhCqSDtlvWVx3GYOCWD353X+5h5YcuvCcSsRT8eWIVJU2Bojqqz52xPr+vtU9OUKrDOOSBHF9vr3/DVJ0i4cAwPmoUVJFqY0uHqpP4Dr1EHxiR3lptAXZbctKp54GoMJMCSe9laqW1rcSJvxFSJIR2jxF8/R5nY5ze2IqN/wLGLfzPiaj8vXC1tuzbJNLYTLp9I2mnpzPWtqnHMOKum6BSAUZvUbKAKj6UcA58aJ9YlsLdnwJuawWifPD8W+QS+eoszpcgz7bKzJfZI5C5ZReSh7H9qKNNP/tks9D9f+LtkBNPxsofPICq403ZtO4+wGHItGqSsJwNuKlZpRpkElUX349b7XoItfafd8+cmRwRVCdZdC5avs5up4PYfp0rNYBXC2gSbmXe8A1swh7N3AADq8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB5841.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39860400002)(136003)(376002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6512007)(6506007)(53546011)(83380400001)(2616005)(26005)(44832011)(4326008)(38100700002)(478600001)(6666004)(31686004)(66946007)(316002)(66899024)(66476007)(66556008)(8936002)(8676002)(86362001)(41300700001)(31696002)(36756003)(6486002)(2906002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzRvWWlON0MzVk1mdmZJeVJYNURGN3ZBeS8rUFprdWJteXhyRDZuazVhYzhm?=
 =?utf-8?B?WVdVUVRXSEsydElDOU1kUlkxMWQ2N0JUOFhBYk8rMnBlb0xxMVhXVzFHd0xl?=
 =?utf-8?B?ZGMzVmpyYTh0R2RiVk5jZEVWWmxOMjN1bS84OUFKOG1vWUpTZ1h1K3NDN2hW?=
 =?utf-8?B?L1NVN2pXUnV1QVdzMytwRmZ1TDhPa3lVNWhrcWZkNnNvUHV2V0FYb0pZQUFO?=
 =?utf-8?B?NE1CZVRnSUg4MUdzcm81aUo5RFR4L2FzRmprNHBXQmthekZrcnR1MkhMRzVX?=
 =?utf-8?B?cHFJd3lFM1FHWlRQMW8vN1lDczlXbmZjeFM2cUVnSm9kTkNuMkR3b3JlREhn?=
 =?utf-8?B?ZDkyVGhENHpCeTlTM2taYzdZcUFaRUdsTUhFcjAvVUJNT0FZaHdadHg2Y0pJ?=
 =?utf-8?B?TC83dVJROVZpRzdocVA3cjQxNEU2QWxCUWtnMm9mckE1bkxVc3c0dkRmRnl1?=
 =?utf-8?B?M0pNRDZjbFNYa0ZkRm1oNFpLd05IaVpFN0tBRk1HR3lCZFhKQmpvelQ3Vnhi?=
 =?utf-8?B?QTlYdytMVUZkS0tCdVdKTDlYY1A3WGJEZmhoTmZIcWpqV2RLbmNCVmRtKzM5?=
 =?utf-8?B?dTdiSXZnU3E0NlhBQi9YSWxOSDk4b2dILy85U1RNYytwTWpMaFpxNU83VVI2?=
 =?utf-8?B?ZGNITTFxUzROYnVOR2NOdHUxbXJPajFqT0pZMEFoTWpKU044dnRQWSsrSGJL?=
 =?utf-8?B?bnpMWjRGZC95UHZmamxqUlV0enJqS09qY1A2NWM5VG1hTXdoSmVFenI0dito?=
 =?utf-8?B?VlZWQjZoSVBCTnIwYTBOelNYdDNhdmMrVjIzV1VZa0g0L2tJRFQwbzNMc1ov?=
 =?utf-8?B?MHE4NmVwOWlGSUhSTG9LT1RSdjl2YWd0WDBmQXlrT09sUUVtZUZuUUtlMjdv?=
 =?utf-8?B?MENjOElUcDJ0RDYvR0RWbW5WTkxXMEU1Z2NBR2pFb1loZTFBTng2dnVvTVVt?=
 =?utf-8?B?dThsaHBqdnR3VjUrQlI1VFUrcUsrN054MmVoc1c5UVVjTWZORFpPQ1BpWTFT?=
 =?utf-8?B?TmxBcVlLOXp5aEYrczBSOEErbXBDWjE2Y2duQlVPeUErc1lFMnAvVE5xZ05a?=
 =?utf-8?B?NkxRN1R4a0V6TDBYbkNLU1ZkMWZCY21PK1N1RWxHQ3RjRUJHTmp6cTlKcE9S?=
 =?utf-8?B?bXg5d2FyQUJncW1iRmFBWTNVR2VSMDlXZmZCLytZWk9KTkErTDgzTmljN0V5?=
 =?utf-8?B?eVVaRC9ocFlKVDJKTytjRm1DbHN2d25mQ0lTS29XZnNUYzBJR2h5bUV5NTVF?=
 =?utf-8?B?cGpybkN0a3ZzSTRDRkJJTzJGUkg0eFF2anhQV20wTmhsY3dFblVtZHU2bno0?=
 =?utf-8?B?T2Y4VWlFRmJSYkRrWmtiN1BHVS9iWlFJYzhKNzdUUk8vaHVVbVBzV1dkRXB0?=
 =?utf-8?B?UVZ4R2cvM0dOM3MvU05vTHlGM1NTb093VWRrdmFISlB0d05zYlhGRWtNUzIr?=
 =?utf-8?B?SnFEc3NtQzZsUjMydDBSeTdQVU1sdHJXTmtOdHI5VmJpeGZnNzNrbnVuQ0d3?=
 =?utf-8?B?bStrajZzV1VFd3RBUG13NkREUENQSW5Tay9aM2dzSm5QcHNES1JVSHNpZk9I?=
 =?utf-8?B?d3lwcXNXRnRRM2pEL2ZBYlBLbDZyRHdBWW84bk9rL216UlBKUk9zR1lnNUs0?=
 =?utf-8?B?bGlWZytRaEJBTllhSHhqRUF5S01HbE1vL3lURGtYaUpyY3VZSkZBOEZib01J?=
 =?utf-8?B?K2RBUUhqRGFQNWxMMHB0NDc2Y2hFS2N3aFFBQmUvdHh6T0Q1clBmUFVIY3lJ?=
 =?utf-8?B?bjQxVWowWitYUDlOTXVCNGFJK1plbS8zR0daWnFqcFJ1VzNkOXc3ZExmNGp5?=
 =?utf-8?B?c0tYVWxjekl6eTE5M25DZEJCRm1SS2tyUnd3d0lRRlhtWldyMVlZeUxvTXE3?=
 =?utf-8?B?NTBUSjFFRDVjd1U4VHlJaUh6UFFQUlRhdE9vNGRkdGRIOHZhekV1YkNiUlVT?=
 =?utf-8?B?cnhtNzUwUGgyMU1NSllpSTBwTCt2cEwvd1BjQlduZC8vV1EzQjNGYzBuSTda?=
 =?utf-8?B?T3gyaktSdm9YOHZPaERGUDhpQXh2TGlXQVI3NmZaK1hjVkpBdXFoYXNSK2tN?=
 =?utf-8?B?TEw4SUplSVViN3FwdzI4YmpzNGZsdWNXTlhESXh4aGJPZW5YUHFiYTJSa3RM?=
 =?utf-8?Q?V8d1l3z/Yg1J5JG107LzNPXIP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Sm5j8WrEuxYIEgFlVPCMFEPoQR3sMVtVVjI7D84WfK6xkomta+wLhObCmYBT2VIXi3L9OdJJPEd3a4c64PyDDm2Qd/Lxi6thIJWnUs2+fc7AVx8MuwslVdOobuakgzrKtF0EDDabQFMJmeMU/8XLvYfKgopPBTq8WP9WKDuYUnxujKkFUzUXKzLQ/8dd9CQguGxVhKdn7Xkk5FuI8SPeIPBNT9a2gu/VtFRySLteWkxQQdrdJ//mw2NPlFY7FGlYw0o3XfIXG54pGcXuuXXWK2LOJQLzSoVx63i4dtwP962Wd5SIkFHY8NnYWr6xTxM+AsT5a/xW2szdAGEpG+kshKKsaZpKebDXTZZlxV4TJAO4b9ZZsnOcpPIjKT/nINYfYBKTUzbEnRQChADTmfBeoIkyAsCMucLDR++kjp2lnYG4DzpdZN9cbNgmJpJ5oNMJ1cn6gCVkZg6Lw0aOS9+T6nYHYWFHNgkCDXvypvh95hUbVcpin3BPVCNmwRNPk9QIGgQRl29bvt5wSsdfjHL6dTA7R+VRmUXaINA2RMRUTl7/pOpMl8ApEFEG0owiivUPvmdLCx1xxPizEK6Wr8GWWBsJ7EMNdB5dn8PREvmgSeM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17afc48-1b0c-4ce0-5c4a-08dc1079517e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5841.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 18:40:42.5391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBv3V0nfzyMVzUQnu6C5cxjnu+94Y2cBumgZcGIynH74Hp862E/Wqq8z/FFeEGkrK1vy9M68eqx9GesvIetHxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_08,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401080155
X-Proofpoint-GUID: DPFm9uVYN3SbPfB-r_6jZAyg6QEg2srz
X-Proofpoint-ORIG-GUID: DPFm9uVYN3SbPfB-r_6jZAyg6QEg2srz
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 1/8/24 9:40 AM, David Hildenbrand wrote:
> On 08.01.24 16:10, Mark Kanda wrote:
>> Refactor the memory prealloc threads support:
>> - Make memset context a global qlist
>> - Move the memset thread join/cleanup code to a separate routine
>>
>> This is functionally equivalent and facilitates multiple memset contexts
>> (used in a subsequent patch).
>>
>> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
>> ---
>>   util/oslib-posix.c | 104 +++++++++++++++++++++++++++++----------------
>>   1 file changed, 68 insertions(+), 36 deletions(-)
>>
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index e86fd64e09..293297ac6c 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -63,11 +63,15 @@
>>     struct MemsetThread;
>>   +static QLIST_HEAD(, MemsetContext) memset_contexts =
>> +    QLIST_HEAD_INITIALIZER(memset_contexts);
>> +
>>   typedef struct MemsetContext {
>>       bool all_threads_created;
>>       bool any_thread_failed;
>>       struct MemsetThread *threads;
>>       int num_threads;
>> +    QLIST_ENTRY(MemsetContext) next;
>>   } MemsetContext;
>>     struct MemsetThread {
>> @@ -81,7 +85,7 @@ struct MemsetThread {
>>   typedef struct MemsetThread MemsetThread;
>>     /* used by sigbus_handler() */
>> -static MemsetContext *sigbus_memset_context;
>> +static bool sigbus_memset_context;
>>   struct sigaction sigbus_oldact;
>>   static QemuMutex sigbus_mutex;
>>   @@ -295,13 +299,16 @@ static void sigbus_handler(int signal)
>>   #endif /* CONFIG_LINUX */
>>   {
>>       int i;
>> +    MemsetContext *context;
>>         if (sigbus_memset_context) {
>> -        for (i = 0; i < sigbus_memset_context->num_threads; i++) {
>> -            MemsetThread *thread = &sigbus_memset_context->threads[i];
>> +        QLIST_FOREACH(context, &memset_contexts, next) {
>> +            for (i = 0; i < context->num_threads; i++) {
>> +                MemsetThread *thread = &context->threads[i];
>>   -            if (qemu_thread_is_self(&thread->pgthread)) {
>> -                siglongjmp(thread->env, 1);
>> +                if (qemu_thread_is_self(&thread->pgthread)) {
>> +                    siglongjmp(thread->env, 1);
>> +                }
>>               }
>>           }
>>       }
>> @@ -417,14 +424,15 @@ static int touch_all_pages(char *area, size_t 
>> hpagesize, size_t numpages,
>>                              bool use_madv_populate_write)
>>   {
>>       static gsize initialized = 0;
>> -    MemsetContext context = {
>> -        .num_threads = get_memset_num_threads(hpagesize, numpages, 
>> max_threads),
>> -    };
>> +    MemsetContext *context = g_malloc0(sizeof(MemsetContext));
>>       size_t numpages_per_thread, leftover;
>>       void *(*touch_fn)(void *);
>> -    int ret = 0, i = 0;
>> +    int i = 0;
>>       char *addr = area;
>>   +    context->num_threads =
>> +        get_memset_num_threads(hpagesize, numpages, max_threads);
>> +
>>       if (g_once_init_enter(&initialized)) {
>>           qemu_mutex_init(&page_mutex);
>>           qemu_cond_init(&page_cond);
>> @@ -433,7 +441,7 @@ static int touch_all_pages(char *area, size_t 
>> hpagesize, size_t numpages,
>>         if (use_madv_populate_write) {
>>           /* Avoid creating a single thread for MADV_POPULATE_WRITE */
>> -        if (context.num_threads == 1) {
>> +        if (context->num_threads == 1) {
>>               if (qemu_madvise(area, hpagesize * numpages,
>>                                QEMU_MADV_POPULATE_WRITE)) {
>>                   return -errno;
>> @@ -445,49 +453,74 @@ static int touch_all_pages(char *area, size_t 
>> hpagesize, size_t numpages,
>>           touch_fn = do_touch_pages;
>>       }
>>   -    context.threads = g_new0(MemsetThread, context.num_threads);
>> -    numpages_per_thread = numpages / context.num_threads;
>> -    leftover = numpages % context.num_threads;
>> -    for (i = 0; i < context.num_threads; i++) {
>> -        context.threads[i].addr = addr;
>> -        context.threads[i].numpages = numpages_per_thread + (i < 
>> leftover);
>> -        context.threads[i].hpagesize = hpagesize;
>> -        context.threads[i].context = &context;
>> +    context->threads = g_new0(MemsetThread, context->num_threads);
>> +    numpages_per_thread = numpages / context->num_threads;
>> +    leftover = numpages % context->num_threads;
>> +    for (i = 0; i < context->num_threads; i++) {
>> +        context->threads[i].addr = addr;
>> +        context->threads[i].numpages = numpages_per_thread + (i < 
>> leftover);
>> +        context->threads[i].hpagesize = hpagesize;
>> +        context->threads[i].context = context;
>>           if (tc) {
>> -            thread_context_create_thread(tc, 
>> &context.threads[i].pgthread,
>> +            thread_context_create_thread(tc, 
>> &context->threads[i].pgthread,
>>                                            "touch_pages",
>> -                                         touch_fn, &context.threads[i],
>> +                                         touch_fn, 
>> &context->threads[i],
>> QEMU_THREAD_JOINABLE);
>>           } else {
>> - qemu_thread_create(&context.threads[i].pgthread, "touch_pages",
>> -                               touch_fn, &context.threads[i],
>> + qemu_thread_create(&context->threads[i].pgthread, "touch_pages",
>> +                               touch_fn, &context->threads[i],
>>                                  QEMU_THREAD_JOINABLE);
>>           }
>> -        addr += context.threads[i].numpages * hpagesize;
>> +        addr += context->threads[i].numpages * hpagesize;
>>       }
>>   +    QLIST_INSERT_HEAD(&memset_contexts, context, next);
>> +
>>       if (!use_madv_populate_write) {
>> -        sigbus_memset_context = &context;
>> +        sigbus_memset_context = true;
>
Thanks David,

> Could we just use the sigbus handling alone and support parallel init 
> only when using MADV_POPULATE_WRITE where we don't have to mess with 
> signal handlers?
>

Ideally, we're hoping to support this with earlier kernels which don't 
support MADV_POPULATE _WRITE. But, I will check to see if we really need it.

> Further, how do you changes interact with other callers of 
> qemu_prealloc_mem(), like virtio-mem?
>

I'm not familiar with the intricacies of virtio-mem, but the basic idea 
of this series is to *only* allow parallel init during the start up 
phase (while prealloc_init == false). Once we have parsed all the 
command line args, we set prealloc_init = true 
(wait_mem_prealloc_init()) which causes all subsequent calls to 
qemu_prealloc_mem() to perform initialization synchronously. So, I 
*think* this covers the virtio-mem use case. Am I missing something?

Thanks/regards,
-Mark

