Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 921877D8987
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 22:11:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw6ga-00011T-P7; Thu, 26 Oct 2023 16:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qw6gZ-00010a-AC
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:10:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qw6gS-0000xC-ON
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:10:31 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QJsPkP025622; Thu, 26 Oct 2023 20:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Hkg7qVkPtHlwSm+jbELV7jM4iUlFZCjzK1sz3fJkyEg=;
 b=ZpuiTsxIGuMIbRAWvMCgq4F+YyC9jPyDwYB/9qFXWJ7J2dkBAtVxfHbuJ+PRBVlM1n8L
 /ABnjWxSV18ZqrXhOlzluxC3OMoeJ7vb7VlD1VpZ5g+hCh5CI0CyNoQsPDz066FYbaR7
 EFWc3g5sa9b2BpHNp41qwWJGfxVtZBOQC2kLXKg3X9kORhRfXQeFwtvWf9NideFbh+cn
 YOpqwm+3P1LURHeghXJpuTlUhWVvOR4t/WtTGy07vRdReP1Az34N8rnB6JMfCokBwpP+
 KnUX50sa/GZvoeJR7pEZl9X5qd2XaWxoWlvcPmgEtIZi8WTIfAoemoZMkODGfBCN4OCG VA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx3ng3dy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 20:10:22 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39QImqEj020103; Thu, 26 Oct 2023 20:10:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tywqjaykt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 20:10:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYZSiguYXFJ5zUuzO/qS/CuRl1/Mh6Sxr/kT5K0R5UGsQW46bxvXc3Jnz/wqPVURvo0YB24B4ZNCwtn5LutivYOC2IsLYcnOx3LcJfQiXZf8UTxkjxfN9byZJrpFnx+CZ1VRuXMX3bvYmHo4kXiJMFAHBaXJjTl0/xLWFTGv2ObnOr2yNlreWqVLcrQq49QWt8zGB8GAPuPmbv56jttri6xQmFInpty2dWSfbMTHiEZ7EwLXVPoWKnNxeFb/W6M5f4k1/7DaXy603gB7stt18cdIagis+eejdtghy+SJ3vaaCr+joeLW5XOG8W1mJMzD403pBTQGe9K7TBl8v+d/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hkg7qVkPtHlwSm+jbELV7jM4iUlFZCjzK1sz3fJkyEg=;
 b=R2BV7Rz5tIjYVlVPmzCR4wMcq3WfwEUNwGhekbRhbQRZi0koEZ4eK3izahu8t988M3peBGzvu564f8Tpym3Fq3ICquyXWojMxEONKbMEGE1OWMpw8Hpg3xDBOQ2LkSauB3b1PHr0lP3RXkMI5r+wK5ulL/C0vuR4E5j/obtv8PB4EDvJ/tFEPFrAB3IiAtpgordGdvULP51ktKaHQDMznLe9Mb+J4ggjuKiIeSAKkL+sCo4xkVWDlwbMr7ZHmIJbTINOpjKf10AyOrWHeflkJPDo/FOr8RUs+oIT/yClVvf7noTI69RMHa7Iu40GQwJKOZuCV9LDJ1F+N71ssf2mjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hkg7qVkPtHlwSm+jbELV7jM4iUlFZCjzK1sz3fJkyEg=;
 b=msZd1fC51uOqZ8ifoC4KPHFYw3K075gk0zgT1xfFy7sYi3T1yP3q2fzLLz5Kh2OAr+izSueOj1hCsfg08W9OPB4N61BHIJWWmY8YT9qLFv7L/cwgTlLMP6aOh+qNp/jL6Hw2r3/QcHdBuvgfHPssaBwjLyERS4+gDXUpfaE/ryM=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 20:10:18 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6933.022; Thu, 26 Oct 2023
 20:10:18 +0000
Message-ID: <7331cea3-58b0-4be1-bed5-ebf4441096b5@oracle.com>
Date: Thu, 26 Oct 2023 16:10:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/6] Live Update reboot mode
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <1698350913-415926-1-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1698350913-415926-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::16) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 3410a74c-d7a3-4e1a-45cf-08dbd65f936f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOGkXbi7r1z1h5NKQI7DmTLmaAF8bWMEobtzKRGnYB4X8bHM8iNrM7ilCqYQZH2RoHU24aH7JBM0/Ai3acN7EbMB+YsL47RxM/S/ODedq+35Kagb4hpW9TVg9A1qy5t4X2t58GOBU0CtI0Deg34YlxJAB0w5tCoLRkiyh7ZgiABdBvpBqJGk+o/pGYx07F0J+4989WeHMipuLtVYjLZkE+AgrYIFYkgjvD8h6WTKEmcs/oi/TZ4CJkxuo4VkfKJ/J0wGWtPVGuIMwbFwkE3zoXpVMxLbYXrrXXbn/2LMKn/1/38u7DoF2aCDmYik2R4bbOqPIeVdu2rNwfH7QB5aP6hM3xGxK5WBXq/Ji7ZjcI2R/1ODrVrG9L9Z0bx3XLo9IJwyRw+ddr7/r0XTWhg+/oszHBKU/OpXa/y62i6Qm6injGgtFWk7jwJMK+eXD+LZNfp6iqkrFfnp4hdQvBcRoeihEYE71F+XA1kMl/h2BXwRUUn2ExeEFHuGWhwQpWmGhcmRlp6hDzx0P5VtXFsgwGABrZdtmrRZl56BgeSbHDvV8fXbW9zKOtxCdxkzob+NnAJOSaddwyAcI2NjBRpCg3zOu1goReySXj3KLj13Vd7dt9FBCGvUyH8uzkTkWhXDV0xSnxYllFr5b19jODaHpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(478600001)(36916002)(53546011)(6486002)(6512007)(6666004)(966005)(6506007)(2616005)(26005)(2906002)(15650500001)(41300700001)(6916009)(316002)(54906003)(44832011)(8676002)(5660300002)(66946007)(8936002)(4326008)(83380400001)(66476007)(66556008)(38100700002)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGpOTnRxYTZYY2l0eVBKcWpMK1ovN2h3TlZRa0pYbjgxU0xTZ1VSbXBPM0Zl?=
 =?utf-8?B?OGhjbXJoZVZlTTNjWHhaNm5yTGljQkJjRVRHNGFsSG16VVZ4REk4K25WYm5k?=
 =?utf-8?B?Z3hqa25OY2hnMGlRWXliY3Z6QjBwMG83MWtaZmtwMDVXeWt3akpINXBUVUd5?=
 =?utf-8?B?SnBZck1mYWw0WVlGdDVqS0RYQmVVcFhVWmkzUjhFTEVhdGhrOStDMXdQMXZz?=
 =?utf-8?B?ZlBqOEtkQkZRdmc0MVlFaDNpRyszMDlCSFM2a2J4dnhIKzB5M3lYNnBYY1dY?=
 =?utf-8?B?c2RENjlKcEFLN0F5TnB5U1FGa0xWbTgwcGRSemRvOFF3ekJaa3EvV2tMdFA3?=
 =?utf-8?B?V1A5b2Q3NjdVditOUDhrUlk0SVJqNkJQUUVNMjN2VzJZamZ3WXZHRzNBcEtF?=
 =?utf-8?B?U2wzNC9LaVVtTlF5QkMxM0lWdFFnUDdVRUx5aG9MZy8wNEJxK0IyQU0wcEVj?=
 =?utf-8?B?QXFrekNLNC95UXErTUdxQkpNRU9ZcmlGVzVJT1VZTThzYkJZMWJwWXZWbWpm?=
 =?utf-8?B?TlJQRXBYYVBFTkJ5ZituQjd5WndLRjJZOFJ4SW5ZbVNrZ05sZGc2UURPa3c3?=
 =?utf-8?B?d0VnRmlzWUVWdlVReVpkRmlFRkZ4T1JvQWVNdTk2UlhpejZKR0dzMENyV2h5?=
 =?utf-8?B?SlYzNXE5dkdpK2VURUF1bGdqWlkrZzVTZ2ZKL0c5VEVyaTBVN1prL3RqR1lI?=
 =?utf-8?B?NXJDcWt0V0VKenpiK1FERElqYmVPM1phQVo3K2tlM0ZaMXhkVThVbitWWGJU?=
 =?utf-8?B?OU5lZCtITEhaUU1pU2hOMHR2M1NCSEhCNlJLM1FmR0hJd05nWXQveVpjcVo3?=
 =?utf-8?B?WFkwMUFYdTU5V1Z1N0NlaWl1Y01YalZqTFZtZ3lsM1REbEk1dytxNEt2Y1VX?=
 =?utf-8?B?UjJsaFVwc1FCenp4bThaTjNYeXRoY0Y0K1ZuV1hUK0xsY2ZmejZvN0pjc0hF?=
 =?utf-8?B?WlNFUDJtcXQzZ1pDSTJPRHRncktkaVZOVTFPbXBVeVcvMjM5ODBFWUVaZ0ZN?=
 =?utf-8?B?T09ZUUgwRTNsdFliOWUvY2k5RWI2cm50Ymd1anArTVZEcGtiT01BR0IwM0Z5?=
 =?utf-8?B?ZS9hR3RiT3pPOHZOanI1dWFFOGRhbXdoYmI3K1gwWjdPZTYzTmhvQ2VXRHg2?=
 =?utf-8?B?dkloVXFuNy9xZTBjQm1zenFHY2JXbUN1TU5nanpFYmVyOVF3MjFISU1pYkM4?=
 =?utf-8?B?MTZuVkNsNk1kb3V0bDd6c0FXZkttZVZFV1VwRWJxS2NYWjl3dUo1Z0UyQTNx?=
 =?utf-8?B?ZmRVek4zdStLb1kyV3F3MDVwcDZxV2lKNGozZmZiQTl1Qm85aGRkTFZFN1RR?=
 =?utf-8?B?UEV0TWttcVYxWkhJTDZzVG91TlZPdkUzOVlMZy94dWY5eEJDUG5JNWdqSzhw?=
 =?utf-8?B?UllEaDRUV1kxaGt0cmFzSGJWbHZaeVQ5cHgvOUk3ZTVxWVAyKzViQzlUT09n?=
 =?utf-8?B?cVNRS1pzSTN5LzFoMk1JcjNkR1FYd2xFRjBGMm90T2RJSUxoUjVkeFNBaWo4?=
 =?utf-8?B?R3BUMjdQc0YyTWUxb2VpQVJJVjQzV1NDdmNFZUhGenlPdVdiejJrK2k0OTZO?=
 =?utf-8?B?SWUxeCtSY1NMKzNOcXF6cW14UktjWFVQTVkxRk5RdGtlOXBMWnFMYUY3Z0JE?=
 =?utf-8?B?NFhVdjUxalp1eExMZDY0bmgyTE4reXFZWGhnTldSc2psdTF1a21GdFNKQUd5?=
 =?utf-8?B?Y3Nma1ZCcDlZVFVJOERqckpKZ3Y3QmFsZDhTbmpOOER6UlY3YjNPcHorT1dQ?=
 =?utf-8?B?eHh0b3FwMVUwZFRRZHJ3MStXYVZNTlNDVHUzQjRMMkJuYW9vb1drT1JaMlcv?=
 =?utf-8?B?TndWM2Urb21icWFSc1JIWktWNXVaK1c1L3ltZlhCODFJWGZLNm00Nk1LblUr?=
 =?utf-8?B?VzAyK0JoVGNpNFBjaHRFUFliTmM3NkZKWG5hM2VFUG1LQXpxUzlYNVlpMVFN?=
 =?utf-8?B?SzNsVDlhUHpWSklWUlNCQXdBUm9PWmVNbTlCeldKYzdlNmR0QVJ5S0JQekQv?=
 =?utf-8?B?bDJUaTM4VlVlNDFyeTV3cnVJaEpXMm01bmxYcncvN0V0cW1BRk4wRmxzSVMy?=
 =?utf-8?B?aWY2N0xmbndpUGp2YXFpN1lNZWd1NFBseUlNN1B1bjVVTmdHbDdFUkZVL3lX?=
 =?utf-8?B?Z2htTTlqK1REWFRLc0N4WDNOenphZlFSYklKak16MHI2QnBtWXBHam16L2J2?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DMCQnncbyn8PWGhvjRm5iyoUOrnq8HNbnAuUjB9LXJnlN/o0S/4M6r2pUzcz32k2/gdraiBQQHGkm0c7xNnqhyPmbp3GcoXTaPGrEHe6DH4kOlCR5XX9yIkrRNHZ3vbbqVz7dAJYzLUhATTNOVuZOnHVUjs36DTs6hJ6cZtKegEbinYNXEye5OCSaLmhujt5Pl9mz6p53SkT7toUNr6v4DV5CHs671T2dJ4YkOBZCAEquiCLMdRF8zsrXpRjXjXT/ADmyT24WadrOk3fGxklbC5ZPe2oxxI+ZRFRA1l5y+KXnWaPwOIugejKfjDb2NIMxsIYpt5VgfWi2dSGp0saZQ2NOhYfmesW91ZMntz4hCNeoqiLh/oY3BGSCK+JHDJaQa94WVa/h4RgSQLfB6C7G0PeyvNHtY13qZpuNfft/nEhTyWLdrRTrGQFhd4Oifz0OmqecNDa4VW8wXRmvbv5p8/8QaCqlqB7/WF+6Yj1hjG1HO3MYIma5O0rJTX4WV8v3ep+RWLqpt2hiu3XT0lADER7IUaDs0rDdyY3PCqPNV6EU1fhTBX5ueKo3CmRN+SXdgWJD12ujL6ZqZAWf267fnvKh2fDYVGvwNEJQktl0r22NdeUDMn5IGD4I5rZcR0iptdpDFrruK7BBMG2xBzMFL/98rXCwtwjdkiWMMp7bqvoJO8iJe/h+OiG7BlGHlgwTtoAMhAmlS9yA+LHzRK5vqJ4JFHOxt3ieX+TJBvqNkGVWunuR2mMiSWMcTTVDR8cRxbqxhSulboML6BUarwtCj4JCOC1A4I5Wq6e4lo7fb0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3410a74c-d7a3-4e1a-45cf-08dbd65f936f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 20:10:18.8074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHRbVdsycK18r6l1q8jZxBZ75mWz/cyeocpHR7Lwsbvk56bC1cVGJJrBkHzIpWiO98/JL30H8snR2Iy+mVxW4AwZATO0JDuJ9r/q/Qj1ZsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_19,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310260174
X-Proofpoint-ORIG-GUID: iAAeQ5wNqRETL5vd6zAmQ_T03jlLzQBY
X-Proofpoint-GUID: iAAeQ5wNqRETL5vd6zAmQ_T03jlLzQBY
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

SORRY for the noise, I type the wrong send-mail command, please ignore this resend of V2 - steve

On 10/26/2023 4:08 PM, Steve Sistare wrote:
> Add a mode migration parameter that can be used to select alternate
> migration algorithms.  The default mode is normal, representing the
> current migration algorithm, and does not need to be explicitly set.
> 
> Provide the cpr-reboot (CheckPoint and Restart) migration mode for live
> update, which saves state to a file.  This allows one to quit qemu, reboot
> to an updated kernel, install an updated version of qemu, and resume via
> the migrate-incoming command.  The caller must specify a migration URI
> that writes to and reads from a file, and must set the mode parameter
> before invoking the migrate or migrate-incoming commands.
> 
> Unlike normal mode, the use of certain local storage options does not block
> cpr-reboot mode, but the caller must not modify guest block devices between
> the quit and restart.  To avoid saving guest RAM to the state file, the memory
> backend must be shared, and the @x-ignore-shared migration capability must
> be set.
> 
> Guest RAM must be non-volatile across reboot, which can be achieved by
> backing it with a dax device, or /dev/shm PKRAM as proposed in
> https://lore.kernel.org/lkml/1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com
> but this is not enforced.  The restarted qemu arguments must match those used
> to initially start qemu, plus the -incoming option.
> 
> This patch series contains minimal functionality.  Future patches will enhance
> reboot mode by preserving vfio devices for suspended guests.  They will also
> add a new mode for updating qemu using the exec system call, which will keep
> vfio devices and certain character devices alive.
> 
> Here is an example of updating the host kernel using reboot mode.
> 
> window 1                                        | window 2
>                                                 |
> # qemu-system-$arch -monitor stdio              |
>   mem-path=/dev/dax0.0 ...                      |
> QEMU 8.1.50 monitor - type 'help' for more info |
> (qemu) info status                              |
> VM status: running                              |
>                                                 | # yum update kernel-uek
> (qemu) migrate_set_capability x-ignore-shared on|
> (qemu) migrate_set_parameter mode cpr-reboot    |
> (qemu) migrate -d file:vm.state                 |
> (qemu) info status                              |
> VM status: paused (postmigrate)                 |
> (qemu) quit                                     |
>                                                 |
> # systemctl kexec                               |
> kexec_core: Starting new kernel                 |
> ...                                             |
>                                                 |
> # qemu-system-$arch -monitor stdio              |
>   mem-path=/dev/dax0.0 -incoming defer ...      |
> QEMU 8.1.50 monitor - type 'help' for more info |
> (qemu) info status                              |
> VM status: paused (inmigrate)                   |
> (qemu) migrate_set_capability x-ignore-shared on|
> (qemu) migrate_set_parameter mode cpr-reboot    |
> (qemu) migrate_incoming file:vm.state           |
> (qemu) info status                              |
> VM status: running                              |
> 
> Changes in V2:
>   - moved "migration mode" code and comments to more appropriate places
>   - clarified the behavior of non-shared-memory backends
>   - split blocker patches and reverted some blockers
>   - added a test
> 
> Steve Sistare (6):
>   migration: mode parameter
>   migration: per-mode blockers
>   cpr: relax blockdev migration blockers
>   cpr: relax vhost migration blockers
>   cpr: reboot mode
>   tests/qtest: migration: add reboot mode test
> 
>  block/parallels.c                   |  2 +-
>  block/qcow.c                        |  2 +-
>  block/vdi.c                         |  2 +-
>  block/vhdx.c                        |  2 +-
>  block/vmdk.c                        |  2 +-
>  block/vpc.c                         |  2 +-
>  block/vvfat.c                       |  2 +-
>  hw/core/qdev-properties-system.c    | 14 ++++++
>  hw/scsi/vhost-scsi.c                |  2 +-
>  hw/virtio/vhost.c                   |  2 +-
>  include/hw/qdev-properties-system.h |  4 ++
>  include/migration/blocker.h         | 44 +++++++++++++++--
>  include/migration/misc.h            |  1 +
>  migration/migration-hmp-cmds.c      |  9 ++++
>  migration/migration.c               | 95 ++++++++++++++++++++++++++++++++-----
>  migration/options.c                 | 21 ++++++++
>  migration/options.h                 |  1 +
>  qapi/migration.json                 | 40 ++++++++++++++--
>  stubs/migr-blocker.c                | 10 ++++
>  tests/qtest/migration-test.c        | 27 +++++++++++
>  20 files changed, 255 insertions(+), 29 deletions(-)
> 

