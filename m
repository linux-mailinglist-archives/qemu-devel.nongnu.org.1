Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF67743D70
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 16:26:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFF3y-0005qC-NY; Fri, 30 Jun 2023 10:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFF3w-0005p8-3J
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 10:25:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFF3u-0004fa-EV
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 10:25:27 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UBOPEk028367; Fri, 30 Jun 2023 14:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CdViTgipb5vOGEoLR16J3igi8sBMSB0SgkesHyIOm5I=;
 b=K6xBJ7TxDfUvEOPlnrgE0ioFrmMxY+tyFHpkPJixQ+RAqt0W3Y2VYzJP7KEqM2eA/AtF
 wcwq3+8z3W/zNTDAsSI/IWudbBjqDpAKpJ+HeuYi/B66zcvNLaKhkPw8gTodSaPSQnEB
 mZfOR8hjSrj909/gCr5WL/jij9sDDL02ISPZwcD1owVwm1bDxm6pd9Lcu1vk9nnV6pGb
 8wZntMIPB4BJIwP+txsd/DwszEwaoGlk8oTNwAPnADaPEPv+5xjXysUtB83H7O1Ix/vV
 4t5/My04BR1aZPUlEUOVdzaGkIlfMfNbOb0PNqFmFViVtyCMLZk0GIPmo6h0AulDJmUp 5A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrhd14yt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 14:25:25 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35UD4gmh008668; Fri, 30 Jun 2023 14:25:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx8wc56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 14:25:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTSSXCX+LNO2rD9H7eV+rpaXWSSEn7I3ZwKkV36I9yjL+4Mh7waRScEKJYLbr+0YV2cTAlPhD6Mm4+CiElyoAn83+2/NUMUuQpKK9Ijg9437gOarnJxyzvOKqPSLT7wqmlFy0Q4HVp+kMwh3mruCg9De/0dgjUZBzTWzl60vObRyN07mlSsj+STyKmoNvRmVRA43whyVqgaC3CcsTFEJVz8obGaabNBMs9qkrFpKov+aaDovGH9pA7J1uD5a+wMFpK+RmUjNFQtNEA0qddTfnkKN9++heFpfpOH8h3aysR7RClhibOMXLNeVSqxTP4LnJi95z7cBGX9inVj6OSo5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdViTgipb5vOGEoLR16J3igi8sBMSB0SgkesHyIOm5I=;
 b=Z69qHQ7H9DYeyIj8w5xIXJZt8BnsJVGqETXg5dpvDeA+6ytGoFY2W4s5bKZ35S4Vu8GHyU8Ju5c8Kx51RWRA2uvIPGr/GHcJSsKPUuQSwpkPZCTWSAnHk4OSJjr3tFy9kwD2c4pH32euq1SpmnIH0Hp9sDK/2dHQY5RozoYji81Va+Qog0UX6MwUPdsBQr31fmci6k4g6ZVVC1as5FatkE2ekMNKiiPh7TEt3bPWdFLg+ilc/OcZxNRr2bP1Xf/1gXeBrhA4W7DfuzL+pXnVsXjou/RxnjJK5edPpPJi8ovaNKpxlLkxLHil8Nlnjw2MaI2+wCdNb6MPhbeH4QaudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdViTgipb5vOGEoLR16J3igi8sBMSB0SgkesHyIOm5I=;
 b=ETELr8//cRJqkjO1D2X8EYCFJOSyzZMJd/RFNvOgOoaZ+D+7QdEk0I0tw1eojPR350iKxWt2fOjb4epJ2G5ZvZGIQpYFsaSqszO+8/1vXBp9vSdGvuRE+70rA+98XH5DmRJRJ6kT8mPJ31FYOlF0C0+La3mPCIqTRGkEvA1K9cw=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CH0PR10MB4908.namprd10.prod.outlook.com (2603:10b6:610:cb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 14:25:20 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 14:25:20 +0000
Message-ID: <a236b00a-a6ac-bdaf-651c-3ac76f807ce8@oracle.com>
Date: Fri, 30 Jun 2023 10:25:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V3 2/2] migration: file URI offset
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1687466251-310524-1-git-send-email-steven.sistare@oracle.com>
 <1687466251-310524-3-git-send-email-steven.sistare@oracle.com>
 <ZJ358gdjNdxsZsEa@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZJ358gdjNdxsZsEa@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::25) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CH0PR10MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: 4719c6d7-aed4-4f1e-49e5-08db7975d574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51np751puw+i92IU6oLXbdiPr+lDiIR9cFggW8OxZaWSF7mNs0Ed+DmpW/nAnTo7m5c3eVHXAyw+at+OBUAnFacmzhiEIOkiAH1NwMdyQh/vSB/424wbNor+mhveUB4YyTs6mF8fNdNsEHvfjXfuvk7rN8bM9dGTKH/A32nhOCnbp2I2u8e6L0OgIDzudAkGxafm2KC3JScwRpSo5MewpwaVTKQZGu3T8pgL9J4yBedfA2zsH+3scDohc9x27yHddLD8MKMHREDXc5VPlMEmmcOi8fhOYoZkKB0RuRGyjl9p6pjGLeZXFNzaGHyHAw9ozh+eYNCQRFCrX2i7IurDZhAmSbxaWSxOVQNdmcnzf2Rk6aVy4DBvy+9iumAy9I9aiwYeO7qfDRCKJuSDKObUzUEq4TSlwdvw/T7p33+MVu3qMvtU4ab4GH+0seedqs+R3XPLM5h2Ijb7w4X6AK3Dzhd6ZtV5vYKcQ3hsAse0yCvvNsNykiusdgdpGafNCg/0guyutpaZLTWLlT8+FsN4bWX8akdgW/4ad3HFLMFaQ/p5EP//6J/pdSG1YPqJQCuOxeTJU5KCRVhBtLPXcSVW0sQXqQSqOrPJcvfyMHobvu2qKumq5saBpnUkbR9dIvvxYuBPDRCMeMqkElm7r56KYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199021)(2616005)(2906002)(4744005)(38100700002)(36756003)(8936002)(8676002)(5660300002)(86362001)(31686004)(54906003)(6512007)(41300700001)(66946007)(66556008)(66476007)(6916009)(4326008)(316002)(6486002)(36916002)(478600001)(186003)(31696002)(53546011)(44832011)(6506007)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cThlTkpOMlZ0dzZ4Rjh4Mzh4ZGtHV2Zhd1N6SmcxalYreDdGaUt1OXdvM3ZH?=
 =?utf-8?B?ZktyUXBENjUvamdDbkNRdy8raDJib2dJNUd0K1AxalVMeWtVNDB2UnRtT0dE?=
 =?utf-8?B?VHlHRXRwWjdVTFZVRnVyaUVkbk5aeURqZlFwRWJZdkxvaFlIZlYwQ3ovdUts?=
 =?utf-8?B?dGYvaGxjTXp6NTZXamlEMWlmWENsblZvRTE0d2JzdzRoRHFFRFhrUTFJeDI2?=
 =?utf-8?B?WlRZVWRldEhTQTVxdHFHcStIMFMzdkNjWVJLR3c4Z1p0cWhkb0FyK3FIZjVy?=
 =?utf-8?B?dlJkVmdmMUJ2NENMbE9vbUN0V05sY2t0RXo4eHpYVHJHb3JXRVZONTBsRE1v?=
 =?utf-8?B?WVBOU21mbk1xZ1k0eWNibmRjUlliVWlybHBtMlJQL3gwS2NYUUc5c2RPK1J2?=
 =?utf-8?B?S2graFdVQXJQeHVzbzdpang0T2NjclArYlFiTk9KbnN0bVM1Nmc0R0poUWRt?=
 =?utf-8?B?ZlBuTG9xZGxWbXR1amtpYXMra3cwdXlyZGpLYU5UVXR4a1ZBM1k1TitJcHVU?=
 =?utf-8?B?bEQvR1BpVDdKN28vTzNRelFWanl4dHJDdExKb2k2enNRQTNFT0JiRzgrYjB1?=
 =?utf-8?B?SDUrenlUZytGRFdtR0N3bkdWbWtieDh1bldPWFZuajlLNVJXVGR6Ym1jNnd3?=
 =?utf-8?B?M0g0N09Lc0J6eGNZeEdENkhWU200OWgvVGJIZUh2UlFXazJPOG84M1JpRlYw?=
 =?utf-8?B?d2N2RVdlV3JkN2lBc0FaR25YeitRWk1FZWV2dDNycmR4Y3B6MEVoME5XS0VY?=
 =?utf-8?B?aExDRlBPaCtyRHN0Y3U1Q2xHUmxhK3RKR3EwTlZIN0RpY0dscEtFQXd5TUdn?=
 =?utf-8?B?cVFjVERvTzhVc3luNThoMHdWbWptR29HMzY1Nzh5cTc3cC9zMG9FbndXMXA0?=
 =?utf-8?B?UjYwT0xvdHNkZ3k1c3pDOGwyRHJNckNLQTNTVmVGMW0rOHBzeGV4T0FMcCsr?=
 =?utf-8?B?c3N6UXJteEQrV0w5SENsZVRWaDMyWjJNMDBlVldUSDI5U3g2TmN6eWRPaXA3?=
 =?utf-8?B?Z1F2WDRieFFWSmJGenQrYVYwUTgxMVFqbTc1TTZKejh3VmY5elVxTXNIcnBm?=
 =?utf-8?B?WlMreEZ1OWtnTE1lVXBuMUdYVmJYdk5tTURBSzYwdm5hOG1XVEVLWjNWcVdj?=
 =?utf-8?B?T3BMS2JSWFZMZW9vV083MjZBMmlmTlgxVm5xc1BtbGd3SVZSRWF5K2lVbGhB?=
 =?utf-8?B?eGdlcHFxeVNpRDNTejlRNi9EcFNaU0R1MTFZRkZuSG9nV0lhU1ZOS2xVVjlj?=
 =?utf-8?B?V0RPdFEwYTIxcWJxUG5ESkJNV3o0S0FoRmUyTFBmbEJ4M3h4K1U0UzBWMEVF?=
 =?utf-8?B?TTMzZ1RPQ01naW5DNjRFT1FMZ2RrNEtHTWw2WHlXNjNwUERSTk00T1pUNzZ4?=
 =?utf-8?B?RUJldzFLdjhmanVNNzNYSjc5SExHNERvVXhVeVhxU053eDlLTVcvRmJ1T05j?=
 =?utf-8?B?YVpxajhJZmVseTNCdlN1MHo4Q1B1ZVp1LzU5czZWdDB6Qks3d2pOVE45Z2JR?=
 =?utf-8?B?Vmk5c2s0Y3dVNTV5Y28xKzlUeUlIZEdGeGFWR21zUStORHhQMW5UN3Z0RHpG?=
 =?utf-8?B?TW81VEFCWnhOR3lybGkvcVRYMjhSNDd4SnB3VEZabFBmZGRaSTRZVC9xZmZO?=
 =?utf-8?B?Y2Z5bzU1SktrRzVubGRGcERENUpGYWVmRGk0L3k4bXp1dWMwK3pwWXpMNEtj?=
 =?utf-8?B?MWlibGlrRzczMFlJOFJUWmwxd1djSUtSQ2h2Uis4a3VwRHMzT0hlMHc0eEhZ?=
 =?utf-8?B?MFBFSXlFWkx1dTJZRUgxSDU1WjhhbDUwbkZXeElnUzlxdnRDTEZBSHdtWEFQ?=
 =?utf-8?B?VzgyQjVzV3k3SU9NMk9FbFNiZzRPVjkyQk9RWUl0cEE2M1ZPWU5QUG9lVnpl?=
 =?utf-8?B?dU8rZXJKd2liK1l1T3VJQkdtTWNqeENGTkZtaG9jZFhieVJ6aEZKOE5rSkZM?=
 =?utf-8?B?allYODRGRmZSekUvaHBPOFord0laNXNJTk9tbld5aEc5YVR3QjVkQ1lJaE9L?=
 =?utf-8?B?eDRIWElJeWZDSzRNNnRJdEo0d2RkZzhta1B3R281blJYVUJ0R0NDNGJSakJG?=
 =?utf-8?B?MWlGVXhwakFvbFIrcndEWkptUkc3SVp2NjRzdmRJT1F1bjV0WldKK0YwQm9J?=
 =?utf-8?B?MHl3a2lQYUhLa01sVm04TDVRQXJocnhOTFRmWE4wYi9ZVjAyZ21ta3BxWDdz?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZdfkMCDW6ZF1PJKP7avXP0lz8VeHpQPaweQGPPlvQ4H8HrffTHXB7acDpzeEpF6m5aALqbmTyQqIA4jOL7N4Hdfu9/6+8cbOyBAt+o4ub+ARv8A01TUo+2P27XN9+FsAJhBl8Ikb6UClwHcNWUbmo3gfrQ1u2ORvmaymBSXVIsSJ2s5NE9tBrm4lc2RSc7GWpfO4gDFBo+zR75OVOJMjKqEnVM1NcyhtNtJNoG+7rua86rREICpkeLWElJEqPjkWnaZ278PBAXWNgYCh9cWlE7Dtg9bkyWi7LTnAKngisqDOwzbbqheI4jJfnJY6ft7Usui+ArH/JuP8cK+EFqhYOmswszprFRJ6ckQwhRNYEe1hmlzF6IfNaUBXt+Coml/69TurCrqtCWHvQezjEnFr6xTVv6MmcLOR2SvFRn2bnEbshLSMQGxqE/BXxNNsi8NyZMLlNusyTxcXqZ9gZDjddPCp27OXRRCrHY517tF5k+HK9h8tP2FtKtGNjywEd4dhvyqhOd+HGSp6zlvXWO+fQwwW2GMYFLm87r+QBCD8RxbR+GLvdcaHGu+dfXcs3jM1G9SYLM1Ny15CNySpNySxxRKlmqIItuMmLeq5/EvfUo8NoDb2XeXUQVCJYXVRbohbSh1oq6vLJHch4gElC7iNrdoVGEu6o7s7TvSdOrhrBNTgzIK8KBO0nyihBBCUkkTjf8PhH9dyCjPSDoKw2Wuh0q1QWdwl8lEjH9Dv8cxGwa/ykzl1GkLrnTcP/+H3mMJRoKvBeKVePBC+k61n4K+GgaujbfsJytoYwDnRZxr7GQE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4719c6d7-aed4-4f1e-49e5-08db7975d574
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 14:25:20.3734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7e7McBqlnw8EOC/7LmEbfHR5cRilGfivvtkU4qOKYSEFE2V36tEm4TJaicra5oVQbhXb55WvjGdBl7wNNFJJSQcJJ+TjOgwLjD7+KBHwxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300123
X-Proofpoint-GUID: nwh871bTBF40EVxpd2KZNiAhszsmTx7R
X-Proofpoint-ORIG-GUID: nwh871bTBF40EVxpd2KZNiAhszsmTx7R
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/29/2023 5:38 PM, Peter Xu wrote:
> On Thu, Jun 22, 2023 at 01:37:31PM -0700, Steve Sistare wrote:
>> +static int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
>> +{
>> +    char *option = strstr(filespec, OFFSET_OPTION);
>> +    int ret;
>> +
>> +    if (option) {
>> +        *option = 0;
>> +        option += sizeof(OFFSET_OPTION) - 1;
>> +        ret = qemu_strtosz(option, NULL, offsetp);
>> +        if (ret) {
>> +            error_setg_errno(errp, ret, "file URI has bad offset %s", option);
> 
> Probably "-ret" here.

Yes, thanks.

I have submitted V4 with this fix and your RB's appended.

- Steve

