Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAE5797569
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 17:51:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHHB-0000ZU-35; Thu, 07 Sep 2023 11:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qeHH1-0000ZD-6v
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 11:50:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qeHGw-0004tu-Ss
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 11:50:25 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 387FlHDM000314; Thu, 7 Sep 2023 15:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=TAHxrt7+13GxrHEKkrZ78aQkCo7zZC4IwT0YyfR9gMY=;
 b=r8nGvgVgKzVLjDrAteGlPxRDzAo97FjWUE+k7ZGKE0rclKZI2fREcr54FDto31C7g9yC
 ig8aUVuuPuCJ0gAspm4t3k/3C74SEk5XrNaV5K+ej4dISHPJxiatIs3E2PKwpaKWJizK
 PLmZDBFQvheQvGv9IFKhyjBaKFNK2UfhYugq1JwcZmhrtV15+SMWrTUvP4FFJWk64DD7
 IJPDb0R+ryWv3Jjs49p4UDSyk0YyIpmSGK+mnIc00vnrred/zg7sSsaWo8Caxv2i3ooj
 el2QVLgWneUgPaOxhuknroKMlprbrggj3Kc7ZFHlZPYnbuOu92J1Cv0+Ho6FuiSsSaS9 kQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sygfrg69e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Sep 2023 15:50:16 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 387FhKn7009735; Thu, 7 Sep 2023 15:50:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3syfy048ha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Sep 2023 15:50:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMQE9PdLQyZo1yWh8/kxvj40JD77m60HCrvBlyo1iuRebZvLoPfsSa2byHSLpgLhF8iSPBBhrTdqm2Da9Du1CrzFR4nBtzF0vPqsD9ieKMbhPZ/oGVG+rS5jXyl8tOW1tLkCM7pD+MQb5A4XYeBCzdfYjIINad60mEvwu8zo6MCKvEG8oPrU97hVl3Boszg/ynLLOgwmW2BLqBXKxDo9Ndde+8+gERetXD6sADDrID4Db3ehU+MiAI9OU8W99EQTGzQipsZvxUH71cWPxtM04f+W1kdECMHA+9J4b7NL43HPF29p2pbp8ecY8hUiWAUGXphusnQJeKVwp0WroWoTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAHxrt7+13GxrHEKkrZ78aQkCo7zZC4IwT0YyfR9gMY=;
 b=ICxN5m99vFxPMekePMGeyok3p2YM5yEAcvvEhs42Lwo+wdhmVHYk/P8XrA/FUbSXSR7yWtNxF921WyVcTh6t+qjic/Zz9sAAK369L/leCn3aGzB9BkK5CV/NO33fC0TLEUBDUaeweYD4OiufAFegPTwpVvSwpBSNmnkzyMmSkFtcPDqGyysOsd+JFFDQItEDu8X8oU9IUfz8NxYyPifx4TC2L06iC9z3klRi/MWYnDfo16unH04ZiSpSWtog4DBl76tStBEGCjXRrcDO6lqsKNyuaMoPjtwntmqHTj/FJXmkGl6KAtqGeXLQHRd57dTsu9ed9R4idv3GB/Q6VRsAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAHxrt7+13GxrHEKkrZ78aQkCo7zZC4IwT0YyfR9gMY=;
 b=p1wFDPldeCiKfyh4Fk/NQSEs2gl8CEuTOZITdz1qe2UZJ/LJ+MrdVsNFKvtvRPVA3QE7Z8Jpn6comjw0iBQkDojSgiYMgRJ30oRFKQUWqbPZhYZVvsgCaLbXcqBsuqbrVUuWldCqbZ0JT0UUEZE1RVQ+BBYwNuGArMS5JqaCjTM=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH0PR10MB7064.namprd10.prod.outlook.com (2603:10b6:510:280::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 15:50:13 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0%7]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 15:50:12 +0000
Message-ID: <916837b8-276f-f669-ed0d-b27e60784a1e@oracle.com>
Date: Thu, 7 Sep 2023 11:50:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V4 06/11] migration: preserve cpu ticks if suspended
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
 <1693333086-392798-7-git-send-email-steven.sistare@oracle.com>
 <ZO9yumiyrNdAkHjG@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZO9yumiyrNdAkHjG@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH0PR10MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ce129e-7c87-475e-af88-08dbafba1f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4i5zTkZH1Z0t6A3Lx2IFY9kV+KdwjUhCKZ1TySoP+rnvRX1FgJciJhtT7RuP8nPyhnzSJkcXaaKcS/bjSR/Uy6kysvO/rDuILGFTNLgs4azYl1sbmyJlxj0Fdg0joIpOWKSZnyFGGRBW0IUSdyAa2aauORyEN4j/XPjJrgjpbG2dTAbx9cFsqdh6uoZJpEIgzbgSYQUcAAt5dMDj2hCxuB1XY88qp57hpQZLLpPhA41LsWqcDA7Y/+Hf42QKZAQl0CzCZqyXQffxqua7hYk4dzwBlcEKI/HMEir9dulci/4WEZKkrVJFnQj2bxbb1PV6sR2GJkBCpBYS88guF5WVK75hZ6A0cne+EJv2vt/0TKKrS8Us1NKfZWk8ALV7SvpX/nwnDHt/fhbPWAgazN0tne04aNMXoGO4snGvLS5bSpI52lEl18sTLfz/DJEio2khTQE49LMyBM+RyR27d13r0drZ3OgJzqcKZh4ISDBm96Gyj6msRf4mNHZVS4qFfCdo9dYPk/PB6XvQaHhc0BTSD0Fqg3Er6uwgTE8E6ZOkA60AcwJ6Mn4+6b5LvZe8I9UugerwsU2pG4OaA5j7onxAmUlg4T9P1KquULD/y28En0KxybqdKReOVFMHB/CDZt9J2pxOu+stdrbQ4gYcVG+5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(186009)(1800799009)(451199024)(26005)(6506007)(36916002)(53546011)(6486002)(6512007)(2616005)(86362001)(36756003)(31696002)(38100700002)(83380400001)(41300700001)(15650500001)(478600001)(6916009)(66556008)(54906003)(316002)(66476007)(66946007)(44832011)(5660300002)(8676002)(4326008)(8936002)(31686004)(6666004)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXFFd3ZMVVpFVHp4NWRKTFA3T0xPanZzdzl4eFpmV2pNUUpzbm9vekdtK1N2?=
 =?utf-8?B?YnV0QitRYXd1WlJXRDQyUk5nblk4R283SHEvMnVXT21TdytUdUk5NlhZT2xm?=
 =?utf-8?B?N1NpbEN6ZnEvMWdtSlgrL29Xa043cDI0OHpRUFlyQUd2d0hjZUhScytkRVdu?=
 =?utf-8?B?VFY5WkZmVWFLVkdLdHpxeXhidTdxMnNMbGtQWjRpM0JWVlRZK3cyczRBZ1lu?=
 =?utf-8?B?VGpEQm1admFQTElzd0FmU0xwbGxzK1ZYeFBTSUQyci9jVDRRVzBxUmdrd2xw?=
 =?utf-8?B?Z2J0ZzJiM1kvUEpCM1ZvQ3BNK2NPYi8ra2huVk5kNjRpRGpzSVlnT0s1SUFm?=
 =?utf-8?B?blhRSFJLRGE5NjVxZWRNbGs4cjNqQ3M1aW5XbTN6anQ3NkJReW5HL0s1Mm4r?=
 =?utf-8?B?bGE1UGdSOEMyTVREejJiL0dSZHlkSDJQdk0vMjN6R0tpVjRBcDZDbDgvaS9O?=
 =?utf-8?B?WTFnUUVvdHpaRHhoQ25QOXNrQW40TUk3WGFCUG13SXdmY0tWWnloWVByZVdX?=
 =?utf-8?B?YStLaWNqTmMzRDYvbzh5S2ZaMXlJRmJRRVltZlU5TEJSZjVnRndlR1NxS0tO?=
 =?utf-8?B?a0xyUHlQbTVQU0cxVUhDeTJBVktKaElUWnk4U1hGMW4zMVR4QXRKb01hb2NE?=
 =?utf-8?B?c1k2RXo5RUVpZXoyZ3pOMTlGQXBhRitrdTFmcU5ldC8zSEFLdkdvcnFjajVY?=
 =?utf-8?B?WE01aHhtL3NXVWpiV05hZFhZYnRsa0hGT1kvTUhwZGVra3RyTjlCZE5oUWYx?=
 =?utf-8?B?R0daV0dSUElnKzdiZmhmMC9FSnpRQm9SQS91cFBmQlNZZTBWOWRTNDJlazQ3?=
 =?utf-8?B?d3loQmZQZlc2cEVPR3hoVGRSSXg2S0Z2NHoyaG9LVmVNbU1JeGw4SHNNQytL?=
 =?utf-8?B?cDV5RVBIYjVqeHdwVnE0dVZkMi9PZ2U5d3lHRkdxSkM4YXN3NStwVHJVTU92?=
 =?utf-8?B?S3JFR0lEblE3UjdxQkdBaHZMQ28xK2VtSUFpL25rMnZQZm5HSjJaU3l3L0Nj?=
 =?utf-8?B?ZTc3eHFVWEd3bE9CL21CSDFxRnkwbytzZ0hJZ3dmWHpQaWpaSmIxaGUzSG9h?=
 =?utf-8?B?T29OSFAySzNDeGtVTXhKVnNzVVdTcDJnV2FPbzQvNDdSdHJ1QWZBUEFpa1Yy?=
 =?utf-8?B?Q2RTbUltYWVhZkZtMU9RQ3Z3R0ZhRVd1cnJMU0NrYytsQ3JWS2Fud0xpK3dr?=
 =?utf-8?B?WkVZTEVpYkJURURxSEJtQ3RHWmF6K3d2VG0rcW5YZEpPWXZwNHRhRk1DK01Q?=
 =?utf-8?B?a1pxMFNINHl1WHdIbG9PL3YrOXpYM0JGb2lQZTVBdnNhakZLYnl4Szg3QUgv?=
 =?utf-8?B?UnBJb1JNRG9vOEFybGI5VUpXSml3aGlrMVdNOE9WdmlQanQ5OHFmaVVTSFE4?=
 =?utf-8?B?OG9PTTUxZmh2TzhSNUxJU2NSZ0NXMkx4cXRSbnphYTdPYUJXcG8zUDhTcmpI?=
 =?utf-8?B?UzhsUWhWWVBIWmdlRElndGhjU0VjbWgrZkQ4K21IR2dLaW5sc2k4UElVTFFt?=
 =?utf-8?B?N2owMFFFak1kYUhBajRyN0U3N1hwMjNwR01jNHZSS2Y5UncvN3k1Wkp5Zkoz?=
 =?utf-8?B?VnNnc1I2bXhTd2dxVTk4Tm5JSzdTTDR1WU9GdXNkNTdSWlRPWXF4dHgrVHpC?=
 =?utf-8?B?dXU2dUJqVEFRVzQzODk0MGcvanQ1ZFJvbzdLYkZJb0pxS04wTVU2Z0pET3Z2?=
 =?utf-8?B?b2tvS2JYQ2dUL0ZSekhyMHFtanFWTzZQZk9SS0tYNlkrclZSeDNDaGt3RVJI?=
 =?utf-8?B?V2ZLZlp5VG1IUnNPNVhsOEZjMXFvbkRKVjg0S25RL0RwdlZNRzIyTWl0eDIx?=
 =?utf-8?B?MFVBSzc0SGt1SS9kc0JyQlA5ZVVvMk5nRVd5SWRIWEFmWVlmemlHMWcySngw?=
 =?utf-8?B?d3VHYnhINFQwWlIwak1mNjVuRitRQWMwc1VsQ0MraGluc081QkdXOUFIcWIx?=
 =?utf-8?B?clFIL2xuNDFWRU1kNFFLWlA4dER6WWRMSFByTXFUSzlRMEFxRDN0NTRLUi9V?=
 =?utf-8?B?NjZQSm9QRFkxVmdUTWk0RFVFWDRQNmRsWEFaSVZXTEhTeEFGWHFVVS95VXRV?=
 =?utf-8?B?ZWJLWWw2cVV6bkNCUXN0UVY5dkVZb1dIOWdxRlZZRjdsYmxPVUZkU3pNby8y?=
 =?utf-8?B?c2g3dE9zUGxmOFNJUGdSajJrdjAyVER2YkNPWnhDWWI4VFF0ZmVFOCtycnJt?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lx78dNZU0i9/vmFKVJrrBxwUokLrRqfT2e8x8XFxRAwTy/yflUClbnMhUiIH3l1zNF77Y+MoYKsQORVUbrsQKCYZx6NKMOWLlqT8mLPboZhVOQJQow5snhKUASWIVykYh+MrnhxpvUvYX7bBa8LCfL9LJNqGqSDm1cJDc1NXZo5oEjFimgXR+noSo8Pa9BaHSvd+2pXKPi0Z0zdCTPKKZhY8v8Vp5dq39J4kJp+Nf+tGzIjnOgW0ZjzKGfnLnUKgOQrXXkrHR4Y9XaYLme+kchIZ7vo7W5BHXOy0A0rI9SzuD8xAfL7vwE1PmRjvWp++SbESYSm+eWFkT2gOQtAguNm/22dWLxUenM0gpXhEfB3qlITdjHjqJ6eyMDT1vfuZW/4PRaXRstUuUlZ2Kfy5Vvqbqci5StSGvNZubKUyUHO46WOgabTdMhRPkslOvdWTVHXngqjeqLBOjUU5WubeWqbu5W7WlBxytRI3VMxXY4QM9rERjaZ5nXmYh1skGFFSTKdG4Bew8l5LAclGR8De4prNwhdKV0WH6N8PncGGXo5OfiheKc0UfP8T6zNEx9cZ5AvZ/IFkqfrfyzIo0Qi4xRr9mcARcXtwjsGh3Ew8k4YcVLCMGXCIg03zDRUzK4ofw3POHSUcP2uICNg7V6o1FUGn1lJIlXbO0+R4fFu+pkMgwxiwhWdAiSMXdE5QeEaDKsknDfLAlKTR5pSliussXckYVzWWcYvq3pWeu5BgDk2yabAH2yh+LQU8kaufA3Oimc65jc5iUJSj0WkC2zj38g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ce129e-7c87-475e-af88-08dbafba1f56
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 15:50:12.9506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 151HYcmu323lDZo699D3QZm9AnUxdXseG41WiScHeBGpilXbzwkwFxia9p1EQR3io5OzqPgmC/+ent4tq/wMu0qYEBIhSwL6ZZFdGmwSlI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7064
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 mlxlogscore=831
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070141
X-Proofpoint-GUID: NL__rGDgWMhCAnT-fF8yO0CGstNLmHcX
X-Proofpoint-ORIG-GUID: NL__rGDgWMhCAnT-fF8yO0CGstNLmHcX
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 8/30/2023 12:47 PM, Peter Xu wrote:
> On Tue, Aug 29, 2023 at 11:18:01AM -0700, Steve Sistare wrote:
>> During RUN_STATE_SUSPENDED, the cpu clock remains enabled, so the
>> timers_state saved to the migration stream is stale, causing time errors
>> in the guest when it wakes from suspend.
> 
> Instead of having this, I'm wondering whether we should just let:
> 
>         ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
> 
> stop the vm for suspended too - I think we reached a consensus that
> SUSPENDED should be treated the same as running here (except the vcpu
> beingg running or not).
> 
> So the more risky change is we should make runstate_is_running() cover
> SUSPENDED, but of course that again can affect many other call sites.. and
> I'm not sure whether it's 100% working everywhere.
> 
> I think I mentioned the other "easier" way, which is to modify
> vm_stop_force_state() to take suspended:
> 
> int vm_stop_force_state(RunState state)
>  {
> -    if (runstate_is_running()) {
> +    if (runstate_is_running() || runstate_is_suspended()) {
>          return vm_stop(state);
> 
> That resides in cpus.c but it really only affects migration, so much less
> risky.  Do you think this should be the better (and correct) way to go?

Hi Peter, thanks for your careful review.  I have some other work to do, but
I will get back to this soon.

- Steve
 

