Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B99D793EAC
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:23:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtRF-0006US-PZ; Wed, 06 Sep 2023 10:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qdtRD-0006Te-Os
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:23:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qdtRA-0003QW-HV
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:23:23 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 386E55Wn032407; Wed, 6 Sep 2023 14:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : references : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1/mxkWvQLeAMN7T/ifm5nBX01wOpuW+Kt/DjbWyEg3M=;
 b=CVhzt+20dYPjGAZX4N11nvtJV1OnBN7a3kPizo34tqT5OQCwVjd/SKC9X3g+5XmxICAQ
 wm5Dpespxacmaef8m+Za2/ut/1DnK1WCAMGwIW8ed+vRKVzrk5O8V0ILlob8h4aSzD+V
 Kj/Se0tJDsRo7EElFwWqUTVcvfC91uiHBeAfSHDqOFyoSqU1ljLvcSBYcWazReushLfm
 pTQCSLFMtYU0WlexExMtffP3W5n6q0lWlLhHAa4R6hv7SXgmF53JXxK/+rkH6vx56v0v
 I8AL/9lWX3DV50sIX9mt2EFoF6c5e/E6jRK+n+rZ+LDkyTqUbhWoqEnmz5uxKrw77L4r gg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxtvc02bp-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Sep 2023 14:23:16 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 386DXUg2037080; Wed, 6 Sep 2023 14:19:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3suugcjbty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Sep 2023 14:19:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUR9Mts71Rjxc6PKGQyYCEUeuna8FNeAJF5D5vp318vjWAdwmy/9dIaD10pjx+GAFuk7bDC9jnzDG4JkJB5S8o0g4ZKEyg8xQ4t8SiGbbBhw1AZXoZvrXlknOggwVQ1GSWsIdDk7myK2jmqmrM7nlDhxv/CFyWkFLzJn9AYeZgisL2D6CVSf8kjTgUQcMnNrHeIM1Whb2X+pvarFIL9C5lokyzujilvi81o9Px4dziaLgiCQNcEKhF/zpxe8hl0Rp7vhXHeFDYGQ1H2fgumfWYvpkdK97IdZFk5smOD3D1CxOi8MObepfTkVf7EcCn9VFJMrSHI8TzlwFYlqbPDNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/mxkWvQLeAMN7T/ifm5nBX01wOpuW+Kt/DjbWyEg3M=;
 b=oXD13oe9u/+QTQfLxQts5zpjUGWZIqq1MuVebMamQCvN0YfLbOX/DpZ1iATHxWe3dv31KlLrQNOcAv7YGw5bSJ3NEIyvunm6GPMDWnzI1HL2Qa0I9Mao3+6fQqcnsfucYJ4agPf/gXKNFeZDU/aDZGn9EN++o3AYRO/r5zEY+NwwMc6ITK3IclaEzxsT6q/O7cackg2Tsif9v4y5Gcs1rQLc0Q94jBnpT1m2nhBlIbLo/C7CknWQTzcgVatbUGVVxGB96G9FnwOVHaaOAwmTe+hQGEWy4ebMbLJ+fv7jl7WP68IqaS9LVVEM4cNhQD8deSQpXJqDPRzXFed7YtVJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/mxkWvQLeAMN7T/ifm5nBX01wOpuW+Kt/DjbWyEg3M=;
 b=CrsmcXcMNDS+7SumI0EWvR13kF8PSwU7kpTD+DvS7CXb2B86tWYzSPRgYG7KuPJqCj9niFpMvUnPbpeh5/ovoH9unwaK9EdxiDSoc7Q6ycgPQRl65uuvknZPCj51IAKqrumTjQmPbdr6hYOqeLlSpgWouEpam5pH5/g8uZWd3iE=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SJ2PR10MB7758.namprd10.prod.outlook.com (2603:10b6:a03:56f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 14:19:37 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 14:19:37 +0000
Message-ID: <e2adce18-7aef-5445-352a-01e789619fac@oracle.com>
Date: Wed, 6 Sep 2023 15:19:32 +0100
Subject: Re: [PATCH 1/1] migration: skip poisoned memory pages on "ram saving"
 phase
Content-Language: en-US
To: William Roche <william.roche@oracle.com>
References: <20230906135951.795581-1-william.roche@oracle.com>
 <20230906135951.795581-2-william.roche@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230906135951.795581-2-william.roche@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0425.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::16) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SJ2PR10MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: c33cc9ab-d078-4602-2cd6-08dbaee44d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVSy5nFsy5tweCyVd9FRly/r2p7gPn4uQq3qQTvgSoHJhrqO6ujakTbWMmBp40zbZNzPctTjidNv79bfMp9YhPGDWqCmkIv7an4JRIOsOt0/fUE74PhUkWaRGv0vXBeitnCYfjVXZcFpRzb0Xyod+UcsxiuoqC6x8fVeu6Shf5zNwMSG+i+42xwlYwuQSx1fiMGQ3sddwGGbKRuFW4od35OUDDqQlvzP/OIru5WTmqMQt1nBc+ZdWtNd5WeVVaHe7JOhw5e06N/TQlyEY2AG+nq7yKCgHKwB+mV7sD1qx4B2NYvE5hnSJV0ph/m/0qyo+UYIZ0HsmextQNQd4RHCtqPvaActW6nYtrPDi1ZbPYvjgwqY0h/Jne6TQlszxtCbaPGqB6vU5ueRMI09ooowij+Wi6ZyFXPHAHBi7LsrlkujyogOWwWSL/i8/DoeMpkkMtTq5GB0PXRZPpONu3JtFqAw1uwon0VhgBcLCLOiYolO/rpE4fwMzNDM/yhp8vJ1P4SaLh6xF2ojsa/UIQoapiKJGFDUbgYhjFKsktH/ewRLT5ULh8tSs0gkiwZP9vPxWvYCgLsIV3+Dhr3THXLkv6Xe9CNyAP6MZv79DWC4nt+CsbosResK/EaVrMsgY5FK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199024)(1800799009)(186009)(6666004)(6486002)(6506007)(6512007)(53546011)(83380400001)(478600001)(2906002)(26005)(66476007)(6636002)(37006003)(54906003)(41300700001)(66556008)(2616005)(4326008)(316002)(66946007)(6862004)(8936002)(8676002)(5660300002)(31696002)(86362001)(36756003)(38100700002)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXpzd0xPaTJ2R2h6TzkxZ1Y3em9kMWVkblA3ODVJbW1sN20vR21HdUozelZu?=
 =?utf-8?B?VHdRWE9md3I4Qmlid0d1aWxjMEdmS21jMzlZRWNMQWJ3TEFNUzdaTDZoejNS?=
 =?utf-8?B?RjRmNjFadmpJNTl2TjRqV0xrcEJyeDhMSUpmT3k0MWRhbVc4YVVGbnVaUTZ6?=
 =?utf-8?B?MmhTOWs0aGRJTWF6YWo4TVBOYmVmRjU4MFFHV3FUNGNMaDljZE9BSm1nL0tS?=
 =?utf-8?B?QmVQbExqYU5saHNmaWN5RlZyMFl0TVdoeU9OM1R6S0hlRTFHc1JiVGJHNXpL?=
 =?utf-8?B?L2ZvakE5dmtSbVo3TEwxNzAxTVJHbmdHeWQxbVhlVkdIbFZORXdWRDVpMGtn?=
 =?utf-8?B?UDZYOFVrQ0pydXdsSUcrNlRkRlpuT3NlQXFSaUpBR3NKUUZoRFZYY3ZRVlFD?=
 =?utf-8?B?aTk5VDBBbUZaOFhiOWovR0pzaFBjczlRb0NZbFRpaWVzQllrVTR4ak9ldVpr?=
 =?utf-8?B?SU1VL3ZBR3UrcDRFVHFOTk9aTVNSM0xGWkFBM0E0WTBkWmdLT2tENFF2cnBa?=
 =?utf-8?B?N3hqMUFzRzNqNmd4bVNmN3lUMGI3bkh1Q1FVTDZaV3NJWFpWYXRPejZyZ3lP?=
 =?utf-8?B?OGhJbnpiQ3E1LytpZmdsZ2JvSXUvYTFSMzNIbUlIWHZxazBHRUVBeXd1U1d0?=
 =?utf-8?B?dndkTktLREc4cStXUDh2OENkRXQzZDBudUxLajJrbHhBcnkzaWFGRmk1bGEy?=
 =?utf-8?B?SEZ1MGN5Rzh1VGxydVIxQldEMEc3czV6TlBMV1Zkb3dueUErcjJFSXkzOE5N?=
 =?utf-8?B?S2YvdFpaVURJSURwcWlJNXBtUDVBbC9zZTZJVE1zbWhpTUoyMVBqeHE2b0RN?=
 =?utf-8?B?dzlmTUlWZWoyeVg3WldGYVBLM2JBUmhKc3hYbzBNMC9mRndMczd4UnR3Z3JH?=
 =?utf-8?B?ZVUyRHE3U3gya2puZDRrNzBnOVRjNjFkSElsY3VRa2RiZ0RMa29xMHFodjNw?=
 =?utf-8?B?OXRReGRwc0F4T0x1elA2TXNHOWgzdEh2cEp1OVI2MWFacllmTkxveFhWamhr?=
 =?utf-8?B?M3VROVpaWjAxL0xlVDBNRkRWRS9mMGN6UkZURE1lY3ZOZWNLV3ZjancyMHF2?=
 =?utf-8?B?RkhUNWI2bVVDbUFxVGpQdTFjNTN6cTNyLzkrWFBTZEt3V29HSlI2OFlhQmJJ?=
 =?utf-8?B?cCtKR1o3aHBWSkQvL1dZWXVIa0g2WS9sNFNaVE5WQ1ozREk4UmZCUDF4aUJy?=
 =?utf-8?B?QXVWS1gvSk9za1ZLS2xrZGsxNU5hZEVyMy9jTkNiWDhqalFJNHNCeTBRc0Y5?=
 =?utf-8?B?RThLZDRiNzB2eGtvNlc3dG9yS25mUFdqVFRRSkZiT2Q5Zi9tMGIraDd2TjZQ?=
 =?utf-8?B?TllxZUptRGJnbkcwaGpqRXcyRWNHc0NjYkxmejJjQ1pGNmxRRytXTjMxQzI3?=
 =?utf-8?B?WDNZcDN4SHNhL0V3c210bUpkTWdDclFTS0VBS0ZZeW9nK0J4aWlzcGFCMDRM?=
 =?utf-8?B?OWM3eVhzMGY4ZXM5TzNSR2hXbmFhZzZucm9sZGR0akcvZlhMVXplV290emt0?=
 =?utf-8?B?MTJQOElEWVFnVjVUdzl2MWN1UkpBek9uSFRxM3NMTUR3ZnhtemZ5eG9sTXd1?=
 =?utf-8?B?ZEozR0ZsOUNaVlFqMExXWGtiVXN1OGU0bEozcWg1YkErNDVycXN1WjFUZ3E3?=
 =?utf-8?B?Uy9XUjE2QnNnM2tmYWR5VzNwbHF0dE41cWl6WGw3RWptN0FWWXRVdUlGSEN3?=
 =?utf-8?B?VEVRWEVHVkJ5TUlWcVBXUlpjOUpSdEZNR2t5RU5UcGpHYmY5SHlUQmgrb2di?=
 =?utf-8?B?K3ZiaHFVMzRqWWRVbXBsYnpwUjB5NDE1UGRwQWpUeWQ0Q21FY3dPcmZiK2Ix?=
 =?utf-8?B?Z3c2L2JNWVk1VHpPR1FORHpXQldyelJrQTVUN3RCTkNDTlVsWTFtMHdDOXYv?=
 =?utf-8?B?eHVIMmIrR0NpbGdBYmpnNDBaN2RLS2Rjbi9tRWVxTW9LTUliR0RPL2s0bEhx?=
 =?utf-8?B?blRIZFBKWnZjamFSTEl0YjRpV2VUVXNqZTJZRi96QUl2Vi9tRGVCam1jbzg4?=
 =?utf-8?B?dlByOXU1RGxqSzBwaDBDN0NWcEFiODJhNVoyei9YRVI4Y3c0TEFNanJETDZU?=
 =?utf-8?B?bUpKdmR0ZEJEdEFtRnRmOHd3dTVxVkRtVGNaUUZ4S2FoRndHbjhObFoxV3hY?=
 =?utf-8?B?QjZCdlVCUklEZzFtRDNXT2c4bHpVd25VYTVnb1lMMUxKRFZuMUROdFdQcTRx?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OLhLVgPUstRcltRnnIb9b6SJfoc1RSJtjr+QuYtZWWZqceAe/Ota72ofaQyDCgFURdE5jaCu8MlSkbVvuVq3J2mYNT5FmKkK7Z1+lKgYBS8drTjcoJZR0z2Pb/MYE+j9Bp1rz9GjpIgn+Z/sm8rzF5YGccerXw808mbNiuTFzKZ9Ws6DTj/4s2nSJ6zyx4a938fduwyeJjmnVp4A3EGvJ86G3fpqNPV+LAeVRwf+5zXGLY36jcInPCt7s8ShMdQa2chpOSY4AY/CZ594IdPkiSvpZXwjgsTsfIuBvHEiV5HwOIXtpRraUcLxB+x4WUUMgRU74iqz6EOk9QUvPYzhcw0lHbQtGHYhm0rIXgrmrcXoVrx/6pM0J+D0jVzOTZYZV9aqBK66BZ/mIJmTlIGraSBPONIT1AC3GDPKutSkKb4zx772fiHDFW92t+AvIQZhMQD3Dh65NUjWn0p2Tf30E5JeNb3IJVff74EEfV9ijpCQQrZr8BnqPGTFfx7Cbs3q8mjWPseu0WtiJD7tbs3jdYh2cqmIj3znfJiniTr8PXTdgPgCa6nyxKz+CUoIG7A/8btteFnLmIpNk1H4a/rm/vcq6BsGQkZ/n/57sMG2XRc4qcC24YDI0lMl/elVz2+Mm17nZdMuWKppobuY+NTDIC/m7XOpOm16i3QnbKRAhB5xOboCS8gzuTt6/0MQaV2f+a5byET/w3cr3tlPoKfonUEv7P5cEhHCEmvs5pPwy9O1RADMdoP/LEMiZXd47n4WhzuCDyOpKy5BiYXLtK7ovA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33cc9ab-d078-4602-2cd6-08dbaee44d1a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:19:37.4354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQbv/D0BvQqcsS2TusZgLJVjed/tv8tbZvvvLv7G7vm/NdBEp9zPoePQ/PiX9se+JdosJDdbtFgCHMfvDaT8tkf5t+Inq07ZUlPi6KrZi7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060124
X-Proofpoint-GUID: obNU9ZeW9ncrcMl1VE4usLBLMtfp0jDf
X-Proofpoint-ORIG-GUID: obNU9ZeW9ncrcMl1VE4usLBLMtfp0jDf
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 06/09/2023 14:59, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> A memory page poisoned from the hypervisor level is no longer readable.
> Thus, it is now treated as a zero-page for the ram saving migration phase.
> 
> The migration of a VM will crash Qemu when it tries to read the
> memory address space and stumbles on the poisoned page with a similar
> stack trace:
> 
> Program terminated with signal SIGBUS, Bus error.
> #0  _mm256_loadu_si256
> #1  buffer_zero_avx2
> #2  select_accel_fn
> #3  buffer_is_zero
> #4  save_zero_page_to_file
> #5  save_zero_page
> #6  ram_save_target_page_legacy
> #7  ram_save_host_page
> #8  ram_find_and_save_block
> #9  ram_save_iterate
> #10 qemu_savevm_state_iterate
> #11 migration_iteration_run
> #12 migration_thread
> #13 qemu_thread_start
> 
> Fix it by considering poisoned pages as if they were zero-pages for
> the migration copy. This fix also works with underlying large pages,
> taking into account the RAMBlock segment "page-size".
> 
> Signed-off-by: William Roche <william.roche@oracle.com>

You forgot to CC the maintainers; Adding them now

./scripts/get_maintainer.pl is your friend for the next version :)

> ---
>  accel/kvm/kvm-all.c    | 14 ++++++++++++++
>  accel/stubs/kvm-stub.c |  5 +++++
>  include/sysemu/kvm.h   | 10 ++++++++++
>  migration/ram.c        |  3 ++-
>  4 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 2ba7521695..24a7709495 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1152,6 +1152,20 @@ static void kvm_unpoison_all(void *param)
>      }
>  }
>  
> +bool kvm_hwpoisoned_page(RAMBlock *block, void *offset)
> +{
> +    HWPoisonPage *pg;
> +    ram_addr_t ram_addr = (ram_addr_t) offset;
> +
> +    QLIST_FOREACH(pg, &hwpoison_page_list, list) {
> +        if ((ram_addr >= pg->ram_addr) &&
> +            (ram_addr - pg->ram_addr < block->page_size)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
>  void kvm_hwpoison_page_add(ram_addr_t ram_addr)
>  {
>      HWPoisonPage *page;
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 235dc661bc..c0a31611df 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -133,3 +133,8 @@ uint32_t kvm_dirty_ring_size(void)
>  {
>      return 0;
>  }
> +
> +bool kvm_hwpoisoned_page(RAMBlock *block, void *ram_addr)
> +{
> +    return false;
> +}
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index ebdca41052..a2196e9e6b 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -580,4 +580,14 @@ bool kvm_arch_cpu_check_are_resettable(void);
>  bool kvm_dirty_ring_enabled(void);
>  
>  uint32_t kvm_dirty_ring_size(void);
> +
> +/**
> + * kvm_hwpoisoned_page - indicate if the given page is poisoned
> + * @block: memory block of the given page
> + * @ram_addr: offset of the page
> + *
> + * Returns: true: page is poisoned
> + *          false: page not yet poisoned
> + */
> +bool kvm_hwpoisoned_page(RAMBlock *block, void *ram_addr);
>  #endif
> diff --git a/migration/ram.c b/migration/ram.c
> index 9040d66e61..48d875b12d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1145,7 +1145,8 @@ static int save_zero_page_to_file(PageSearchStatus *pss, QEMUFile *file,
>      uint8_t *p = block->host + offset;
>      int len = 0;
>  
> -    if (buffer_is_zero(p, TARGET_PAGE_SIZE)) {
> +    if ((kvm_enabled() && kvm_hwpoisoned_page(block, (void *)offset)) ||
> +        buffer_is_zero(p, TARGET_PAGE_SIZE)) {
>          len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
>          qemu_put_byte(file, 0);
>          len += 1;

