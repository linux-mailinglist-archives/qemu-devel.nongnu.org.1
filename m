Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D4EA317B4
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Feb 2025 22:28:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thxn3-0002l4-FO; Tue, 11 Feb 2025 16:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1thxmt-0002iz-Fw; Tue, 11 Feb 2025 16:27:23 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1thxms-0002Hz-21; Tue, 11 Feb 2025 16:27:23 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BLMW1M017125;
 Tue, 11 Feb 2025 21:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=hflNbyH6lqrBbhJFdWxyjVN4SWygAxbiQutO7Xl1hww=; b=
 P9gG3nEKTO+uXOrkYFJEUMgbXHjxmirZpEWmh7c5iZhv/ldHMme4ERgFGdAnC8MU
 vpULCAWoJsAUQ/+Ewl04wffEoB1MhahAESH3KQu86Di8BZ5HoxkPn/kEteVq4pea
 pJavPPkznHXNt0LAlEg8GbSWV9LtBuadNVU/OtU4/6Gbi8GN1Y3Dwff7mH++mZyC
 Wrw9kpRRvftYSif2FTVU4Nx4649jHwCgS9CnQKyA5YdEq+zButYNxDicM5KKMuez
 e4SvG4lF7AlRC/4v2Y7V6ZLUV5oGJZeK9mW81rGKNWfHKQr0IlZOS/zROtIhBWiM
 3ijLRakirxJRDnI2xvB5sg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn63y1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Feb 2025 21:27:20 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51BKgECW026948; Tue, 11 Feb 2025 21:27:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwq9cdsb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Feb 2025 21:27:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lr8Zdpb/3tx/9SqmI2CrlOAm7w8zSBn+LOmJMkeGtVPssEWeJDkax07toiiVAEcxauDscHDb8PVOqNzAmoosdf2C0cYPWfGmWOnjidpDgoRHkRaI7Jd2Z6sN1Q4Eqb5KGkQGx1yWS7moZPFGC5d/1kCOatdc256tZrmDjPIwQBpyJmq1qjyhQcWQ0xeKDSZz8R84kPyU/GToq1Yo+3fq1FK5ZU+Pnhnb72EAtILvtTrk4/Vl+Qzrf2IZTkSEgT5mhbDJetruE3PbiTfVFnYKU6L7j1K2zvIwHa/fO+qHJFZ7upuyJyAh8FsjkHZBOXo8aU+oN8vgvNskCxpaHjuN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hflNbyH6lqrBbhJFdWxyjVN4SWygAxbiQutO7Xl1hww=;
 b=BLm5cUHScaJwxXpSq+201eHsDgjiFi3UPBxC3Jh2Jbn1VetL/Tcmv47ixuqbKpIbDY5IE+diIySak9n2d/Fv2k5E0Y//DVaySzUeR10UCHy5R0SjxZOHWiukr6UHpxtRYN+wia08YqN3MxNzHy7ul1MZUNX3kPnYM/B8eE/sI3h+mED4m3r8D8Q0uI00eXUK4sfA7gJ5COx5GR/QcijlevQSlEvbv2u7X/PoVlEuUicBfSgxbLmXDMjMXk8lmLMCoXdCkjZgtYMq7IJBGnv6K9fsnd/T1nzEuo5lsU9xGj5ReLWSd7g2g0yzv/1iUNlITyxOwTSt8VXuHcqGPFfgdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hflNbyH6lqrBbhJFdWxyjVN4SWygAxbiQutO7Xl1hww=;
 b=Ny9ZGhy8VsxAp0ocjLGHydNbdXWb+3ltmobHwvxmlWc+9eAQwcoNy5oBDx5wu/m3oASGEbHgr6/Ay6u2/lfBDjVGbelX50MugwD5Dn4AqxItPHDSOlxMSXhQG3OCF2COb5yZ6kTL0IYpzRcPBYd2ixXmhJwR71zsDlnjZkrlbCA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB7538.namprd10.prod.outlook.com (2603:10b6:208:44b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 21:27:16 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 21:27:16 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: peterx@redhat.com, david@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: william.roche@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, joao.m.martins@oracle.com
Subject: [PATCH v8 3/3] target/arm/kvm: Report memory errors injection
Date: Tue, 11 Feb 2025 21:27:07 +0000
Message-ID: <20250211212707.302391-4-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250211212707.302391-1-william.roche@oracle.com>
References: <20250211212707.302391-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e04fca-5fad-4d0e-6c96-08dd4ae2db98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qJVAi5qgJHH9q8hXMb58R8vWCXbhdLZnq+iN2HJjyd/cDtN0VuiJ1CwxGiyo?=
 =?us-ascii?Q?ofSrw+KUwQ464T6l1ftcV5+cM4WQWpLgLi6/QeliP8ivIrWWMv6MndGdq6yZ?=
 =?us-ascii?Q?jO8HABUSKbBYIg2fi2LgkFDfzcH13FjlEwDqa09gElGW2tI7ZpekMPkTmmSf?=
 =?us-ascii?Q?2lJMIfMVsT1nWUAVnmMwlQI5vRGCKC15Rf0zwW1xaa1DPaOES7HECvf2rqyN?=
 =?us-ascii?Q?5czdm4tKrdAmSlsw/jqFBKZ/2ntlyY2ISgt9VsYfKHLaePzJOTqG+LPcUDA6?=
 =?us-ascii?Q?heQ97g/Qggz0cbsgwR+GnhCWaNaYwNXNug74Meec3ukZoX/tpWrHWKBGUWyv?=
 =?us-ascii?Q?FhYYLW9+8ALvSxptXI6GmGz6IA1qtuj2iV8Ln/atPkWb0EpAEyTokvxEtrtu?=
 =?us-ascii?Q?XbTCBRcYF6hGs/RZ1uJOVibR0lSO6sx+/CZvIBF4a3GYq9DiNjQ+TrLGhKM2?=
 =?us-ascii?Q?BSR7UIBSi0O065a8lQh4F9o5pIuK+/p5jMytsavELuTcHp7nfx513D2R3C1U?=
 =?us-ascii?Q?S/rYhhonwRW2oWO55JNdrdGZ89AHyLdIaT6s0iD3i8ENsLqudTz3s+TVBmcJ?=
 =?us-ascii?Q?yQe0IWJjqvChTxOS13+T/CJHbFVsVhymcsT8zvMrbtIuSbY1KOgMnKY/kxPh?=
 =?us-ascii?Q?2kZ61qp1ncX/MACfK0UUxkiNqFOPJ9kWIDYCFR80Fcs06FhKCaVfh7J7Qfak?=
 =?us-ascii?Q?G3cMSUu6pNpq2sJA8jBMUnK57MG9sQbhAMlIWa1U8rpG7XNPmsFofBX23D94?=
 =?us-ascii?Q?ajzYwTvf9tOY4GAYuPmhUE5kp6MTx5oncbDPgWe14SHD0SRnPfZAWMJvB8AX?=
 =?us-ascii?Q?+F5acnnXI/6la6EeGaCnUgItiZ6h0tuXucQvSPH6NvaQa8iG71RHvhUj6/Zg?=
 =?us-ascii?Q?Yrx/MXP0ryqlhRfdj2S5zoYUHLQRHJXUL2ydO1McVyB7PDdGT7djlDy0JVGm?=
 =?us-ascii?Q?6w6g6FKWJxjLd6I129IRbn+J4YTeDlRGvdvfk8CnEBYuRNce1xNyTHP9qM/E?=
 =?us-ascii?Q?7Rm1q6OLmYkHMNhbyzyG0r9v+4qLKtOe16axn7sKRTTyWDwvEl6jm83LRtX1?=
 =?us-ascii?Q?aWUKtu5uje/bmSKTMkIG6lZIO+goMV9378CQIrOTOqYpfTqRZziLF6u7Mi5H?=
 =?us-ascii?Q?YXWjqS/8100/w7W7JjQE5jNNCidE2hyw879IeVGDWEb50cT9IVXG7F23uDdr?=
 =?us-ascii?Q?Lr88BDr44U1yZOiQtQG1l49+1yUPYP6dMfVGY0vpxuXhs0XkXJAb1Sxlw6j5?=
 =?us-ascii?Q?MzKK5ErWfogcozmoZMW04vRvKlkkY2za0D4z1SVAtFmU2Szw+X1TOpk7uRqL?=
 =?us-ascii?Q?YQb/1m+MnyWzgjAPrsaBzi543ZijkATOfPMspgwuekkNGhFNGmp5NZfv0Bim?=
 =?us-ascii?Q?Q/KPbStu1JeuIoW5qS1Kl2HcpMJm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xn2brJg0Ap7ZW3VCe29T1vpv/NtbhVzIFBkBePUBVxxLSahzLuH4e480LGcn?=
 =?us-ascii?Q?oHp3ewTB6cFkv/vgVobWr5RB4CxxOwc3SviI784iFQlgZQeZGhKvKYLB85iV?=
 =?us-ascii?Q?5qSxsCSuYCVGjmT7gp6IUipR+A8VTY/dpTWJI8BCuCG3PHBQvxc6hHHaCVwm?=
 =?us-ascii?Q?EtY6eys26wffp0aIpcjYy2jiMFe2GTCO2PJY7u0YsB+y029LBZqhPD5dLuxb?=
 =?us-ascii?Q?TSiVuEOgzq61IC1J5dxzT/WGk0/enFSmgJJLPot1UbTjwpylZV9dlynzKuG+?=
 =?us-ascii?Q?uFiyc0GGueNEDoS2pODRi5oEcngsOXencZxjh/UCTFrmUgfJ1gZoq+MmKkA7?=
 =?us-ascii?Q?DCf8rqPO09OBpVjYIWVukM5Y9zoo4ANkcmiN1RcKaMhDWXcR8o5YhwOvk+tD?=
 =?us-ascii?Q?bRgZejjXzryDDBO4qMWZ5AZ0v7IzbodgZg21C66MVF9sck4B/LA7yGy/6lc4?=
 =?us-ascii?Q?PSQICuShY+6CsaF/t3JNK4HJwsj5cdnvdVqJTMGFQw23jFxzQWcx2QfAfPzK?=
 =?us-ascii?Q?E/hcNxIZ5izH355IpLfAXGD43gwdFIU1NMZEhWEihN193ZMFgfUPw+g2c/f8?=
 =?us-ascii?Q?o1zh+ciC7Uj+5S/O6aWq4elJnHmPPE//jL1vdxpuVFxoyR2RiVwM+jJ9pSco?=
 =?us-ascii?Q?Li/p5k4u7iG9EeNklTQe9tsqhXGQj9Ol/gD4vJZvLdP0BW6k8mknjodVHTox?=
 =?us-ascii?Q?ZeCV7HlDfHcTDHL93VnrfwDIxeE8wr5VhT9fIPA0Atqw5hk88etJzcwq1W/b?=
 =?us-ascii?Q?clWrSe9M6TpM7sVNkUqaygvqL5ILuaISUQSg0xaMuizG6XMwSBu7HZFv4mz0?=
 =?us-ascii?Q?DBnWN9AHcg9B5qOiEsmfl0CVOFwFCcIaK7V+gyAgBbMw3fmn3mso15iZdLWW?=
 =?us-ascii?Q?hwypYHCPVhTWo4DSj73fS4xyXcaOVZ1h3AL5f2bYwPtJPP4y9LHQxPaUcMcN?=
 =?us-ascii?Q?8CnvJOn7g2aUComVSLrX4YX5p4xtmgF9lLElC60xwMtr9NtEh2I0cSQVeU/n?=
 =?us-ascii?Q?I7o/lypj65h6hD8K1AGZARKYkVfdybKQCCCZ7T6T4IrIsmON7N6j9uHA9dFJ?=
 =?us-ascii?Q?+G3YlHhCT00Hc8bch0+GAgo5brkiLF+XlTXNfiLbGiA2tObegezi0I5vmNsT?=
 =?us-ascii?Q?EMZgeCn7FPSlAfWurRgMY3p2qaAuAOtbQefoT0HadWMMJsLfTNOtznz3/ra0?=
 =?us-ascii?Q?9KgLL6d7RSrTA8Hnax4isU/e3H+vT7zR0yEe5MSGA6Zpnm6r1C9OV8AqcN0k?=
 =?us-ascii?Q?gbn1EtfspILSBeDR3B97J5Fj8tnnVIhlLYgGmxnetpknY4TUq406r0d3PHJ5?=
 =?us-ascii?Q?BBDF7xD/D6W6uW68qeXfOoydDnrpEiBkyOFqGyLwLq4Lmq3NnX+92Y+qrksr?=
 =?us-ascii?Q?1SPwO0cM4Kodib1RApDYbj3CQ5NBn0Pe6mAG4As89inR6xznKxTVBhoXr6Mo?=
 =?us-ascii?Q?LW5ayduTFcucxZVn9D4Hcu38XeG1oKbfbaHpbzthq9OpKuAKFy6dS6PG68sv?=
 =?us-ascii?Q?wzT19x/tEaeQkx90SNcX4vd6H94T87FHLUyn47Ru8pBvcBnAo/DTiJa4XfUB?=
 =?us-ascii?Q?fVhCEuzVi1C9/NtquE7G1mQu4+3VNHIJNFuDDXdAEvRzmEOImR7w4uifs7fX?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BTY5ojp1mOIL2ychbE6JMzEwXvsZl3ARf2eO+k6xRQeLegZgEw5V4ztddcanJz+rD1estmgIzFSyO3EdjaXhbUrFOrDtzy+ShGOITa3/SULvwDFtVZZLAW0ny3Wf29DvBTujEIurpatQDUh38ayqK7X1BzHtFEIXdweGtHZojcV4BvLYr8R22cqey3E1u8a3jd57HRRmj0QU11d0pM4cB5dgfZwWY2ItP7dEIUKk0vY6Hch+GFQ6fNH0bhlFfq8Vlq/8ebvzlGNGBWY6yYugTVfR+A7suvgC1YB6QajEVb0lbOdT/THGSYF61qkD1fkE+6T0cD+8JTVcRkRyKR5T83fSH8lzMeBGvv7yU5Nw6Vdg1KowFZejzn0Dk0MBBO5bvmCvp5yYIZy6TMBw+QRdYamY73jUM0L16oAD0Hd57tdSd/mt4bq7pCHa7Xg9eTUFsrb4uL+9DCE8KtfHtp6hqD1+UAc4TmO4+Ysgm69143I5HvaDxkftwpEElGUs8kcA1B0IP7XYFnrKqNoBcNKhOq5Cqni9bsukOpmHbOq92pRU4StXBhIihYn7RHIC77/JEVqPMKum7QkRRFuV7P9sRk9LexJ7yl129P9QUWU2j0k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e04fca-5fad-4d0e-6c96-08dd4ae2db98
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 21:27:16.6512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HV+e6bh9XnditVLWJ+2QXLPLhf69MU2iiw9N2R2ZFL2T6Y9lN94BxVKD6JBxSlRqVmgebaP8GBomDUTwQri6U8ByknHoPoL4uvFOfQ4/gI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_09,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502110141
X-Proofpoint-GUID: scoj_I5vAxRtUTkZC0oSbg0hRmsLisj7
X-Proofpoint-ORIG-GUID: scoj_I5vAxRtUTkZC0oSbg0hRmsLisj7
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: William Roche <william.roche@oracle.com>

Generate an x86 similar error injection message on ras enabled ARM
platforms.
ARM qemu only deals with action required memory errors signaled with
SIGBUS/BUS_MCEERR_AR, and will report a message on every memory error
relayed to the VM. A message like:
Guest Memory Error at QEMU addr 0xXXX and GUEST addr 0xYYY of type BUS_MCEERR_AR injected

Signed-off-by: William Roche <william.roche@oracle.com>
---
 target/arm/kvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index da30bdbb23..d9dedc6d74 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2389,6 +2389,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
                 kvm_cpu_synchronize_state(c);
                 if (!acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
                     kvm_inject_arm_sea(c);
+                    error_report("Guest Memory Error at QEMU addr %p and "
+                        "GUEST addr 0x%" HWADDR_PRIx " of type %s injected",
+                        addr, paddr, "BUS_MCEERR_AR");
                 } else {
                     error_report("failed to record the error");
                     abort();
-- 
2.43.5


