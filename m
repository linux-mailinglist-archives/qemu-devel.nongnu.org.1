Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 437FF78237A
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 08:14:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXyAP-0006n4-VC; Mon, 21 Aug 2023 02:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qXyAI-0006lA-1W
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:13:26 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qXyAD-00054i-96
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:13:24 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37L0fruj004731; Sun, 20 Aug 2023 23:13:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=RPWpO96xfbF6f0BoVD5ZqayrEwUuPSNwLO3ZDFWOE
 Io=; b=j9QYIzkQkwwojT+wVQ8vuyu/qtxov2Y86GUTXysdzdxRevNIHRnVKOodG
 aGwP2LtF3cpzHAvdSwYnG+olfjj8Bu08snxPnQq5Kn3Myq2YuMfLJmmRnp4UJrPn
 H15qUNBL3/7jfOdiJ8gVNN/ZO/8xGKWmICm30c5M00cl0H9FH8rR2lZAYe2kxWaq
 zOJTXoaJq/2DMfVZuYvEoR8naNvq85SxFNSOD4Ez0FqsGh/XFFLfzdhXNJ75J1tF
 DPa2Gg7In2TWWMv0lroA5zcJpCwaH7wHU0aed8DKhpn7NmALuf2SJVN1ftXgV1Hk
 wbg1iQqbs4FlVYNtJo8zuGKbj5LlA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3sktp1ghy1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Aug 2023 23:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkKveiUHWzwralIXee/GxUf/ZZWNo2BeRrdstVJAGrNfzDfq8TyTECbTYjWszDpivx24Q0kiW6Yqnm1DXMp/od29wiLcxuWZ3hCXlUJxPNptfj/ARzUTz+ckNztPWnc7fwhiaFSma1DFvpFLn7moLUx2OotmKGGkjkcTlykLuUNtN1Z97e1KRW8O9QK0JsD2Lf0bZ11+KhAeyAYt8Ve8gFrlg4MsqiNGuK0h0Me+6RdQlAcRhG50pC8wPtcEKACCjFC5QIz6oARlPKbzePXZxOSCz0QuQDiQAHpD4oR+JDPUe4B335NDWwlRCd6HTlD8/444lE5uTsa8SyMfZZww0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPWpO96xfbF6f0BoVD5ZqayrEwUuPSNwLO3ZDFWOEIo=;
 b=SIUv/liGnK7q4U07I6cCG3Xe7fmbuBcZ4cOEQc6YU0dlYRljb6g5lVHzSA/Ah1jbvk6GpdcQgrXqrh8miC8HRcC4PvlY3Lz3k7Bgj32SBYsTvN2g8NvLp241cn/w+O/Q8yb8mvNyFr/Rk7sQtPtgJcfdWYIlaJsMfpQwlCa6lC6H3IyeADH+HCuGIRELnH0iEpCoA1csWpVTcOA78bFUZb+wxzHs8fbckk8HkIEFMjcGtXw5g9ZzhmLKwLxhRcmojWzD8hk4fSt1cXbOxKJmKpEaB4LEoCBMWuOOeLybN/wE4SgQP72IxBqaCwgSFLACSeDFpDEMt0ZC8vRmFnfOmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPWpO96xfbF6f0BoVD5ZqayrEwUuPSNwLO3ZDFWOEIo=;
 b=sOFRHVubb/ngmTflfSEI5bS89PUIAz3WyusgaKC1PwKkNwBdKKWQggxsfHrSWTsDQyz5ROKcgKy1jHReSzRPPpNmwTR+OCzzlvR6A2KMvCVfso5OBu0Uw4YGZcYvOcnBxN02yF/jkLt7SSa+NA92bLH4vdETowd8JFfBvTtLxmzZUGNCwPDN8tdHu7TU9Z9C2g/KmBjU2S70awPndVApLZ9f0yyHqRZYr4RZKcJGPpbjSLrdOQ8lXe6Lp23WiR9M6/8vJCMgAAqZLHEpeAfx+tzWSJjuc/Uzq6A3Qx2zJp4pgtYFIWYwUXQa+jc+cBk+26PnBbeaXY0Rzsdtv5JfAw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DM8PR02MB7880.namprd02.prod.outlook.com (2603:10b6:8:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 06:13:15 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::a44b:ccca:7793:30c]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::a44b:ccca:7793:30c%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 06:13:15 +0000
Message-ID: <3fb6b8c1-7790-3ad6-62b1-81642e878f7d@nutanix.com>
Date: Mon, 21 Aug 2023 11:43:02 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v10 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20230726141833.50252-1-het.gala@nutanix.com>
 <30cffa41-3e39-205f-5119-d84d6303f58c@nutanix.com>
 <a81add8b-f08b-6589-e9f5-779a4a7bd63f@nutanix.com>
In-Reply-To: <a81add8b-f08b-6589-e9f5-779a4a7bd63f@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::17) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|DM8PR02MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: f8316a2c-ace0-4d2f-fad0-08dba20db412
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IADEdrqqb0CloE28LNRpoIVncnFLaYKg8xr087CNIL0qOFZrZgxSE1/3rsrYjy27Ia6Abjp9ynsJnry1D/CkcAfSacVrKyghRqNy/l1g+hf3rv7Kh2olDrmSD8A1XBKXfr4+6DcO50UhQXVt+M0NDsFd8uWHC2yTnfTk1BY6Ukc80ulPzJlBJSpdOdI0E1jkaA7pfs1AHHRZTHtXPNBUV6WvtSnEMjIoIa67IwqHL4xqbfTCJbKCalJRHD5+g5RXI+75z3iUeGyqanS8lUyphw93fmlZDQ8Gxv6DMgnu1TnjvqNqE3c4ZSNewKumJ2k8Dh0IjJFl4Cq1b7U9b/CugBVgg1Si8+iGY/v0hTQYqCBCeuS2qiW/HZD2jctwkUmOIAh2iA3x2EGKovVJr1mTc9aGBLuyRqeh7emXiIOiZFkRdk9blXs7eyucst0YD87kAu1XOriata+MYWNF1VOEE0z34B6PQYUaQJbjua7Mv1pjoAztpl1aIVAj4FgPipGhAkCJn3k3EeJopG7nMJ7Wms9cjp80LNzzEL7ZRV2QXcjo0zl47JBGtaAVuxHma99Ks+MiXyidfRuPyDwoZBHutsax4fBrv/oRbj8J0VYaRvmafhzi5agJ6SMo23ojf+voPQQ9vom1av4wnVc7HyE+SQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(136003)(39850400004)(366004)(451199024)(1800799009)(186009)(5660300002)(66946007)(66556008)(54906003)(66476007)(2616005)(8936002)(8676002)(4326008)(26005)(966005)(44832011)(478600001)(6512007)(316002)(6506007)(6486002)(6916009)(53546011)(31686004)(6666004)(41300700001)(83380400001)(31696002)(86362001)(36756003)(38100700002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1owejZQc2htZVkrTFN1YnpNQmlDQzM2b3gwaTFycm5sUXRMRXZrdXRQTHdR?=
 =?utf-8?B?dVlQQThvWWllSjVuTXE3U3BIZitEY0F1dGJrOGhkMEI1SUpvYTJoVU1wWFZR?=
 =?utf-8?B?di82NHBYV09LWGRsZjhKRmJFaGg0UzBQYysyc1YyaUFHbWtLQWNFVk5hcjk2?=
 =?utf-8?B?bG10Q1FBYU1pNnlFVVhwcmQ4UFhkYm04dkpjako0Q2Jha3pSQzFKbGdtVDBD?=
 =?utf-8?B?aENkR2tRRk5IU3NZU0U5RXkyTVN2anBhMkJIeXpXWmxNMmFtOFg1ZGp0S0lp?=
 =?utf-8?B?aW9Qa2lvZWpXN2lLdityckthQ3ZLd29EeEtDTFhCenhQN1BYRms2eTBWQWVL?=
 =?utf-8?B?a3U2MlNGZmJZRVBCSUZXNG5kNVNZaHFCaW9TWkhoeUhzc2VjZHdNQU93UFhK?=
 =?utf-8?B?ZDB4bkk4Yi9lVFZRSmQzYlc5VUpVNVJZOE0wQnI1TjIxK29PaXFKcTBMN2pp?=
 =?utf-8?B?d0g5L0tpQ3ZjbjBieldueUQxOTVQdzVRZHp2ZGJhTlEwZWJtZ2ZCVm9BQUhW?=
 =?utf-8?B?Y3JGYkJPN1VOd2FqTHdkZTNaZEd1ZlFvUmpyUjd3R0dPejdyaGdZY25UTy9N?=
 =?utf-8?B?Uy9RR0NpRVIwaHlKVGpjemxEa3FxUk5ycFhnVGpTL0EzcFBWbFNZTHpmaC9L?=
 =?utf-8?B?bFYwUjB3UEFxL1NMM2gxQWhXQnY5S3dOSm54TWd1dHgxbUdNVUZ5aWhSZkZj?=
 =?utf-8?B?MlRUcCtWZDJ6U3AzbzNJd3JnRHUxazZtSGN1RnlmbGVsUWE0Q0dVenh5UW8y?=
 =?utf-8?B?STJPQWNrV25hMGtjNllvMHBKbnNLNjkxVi9hU3lCUEhsWGxmOXAxQjFzb2Vj?=
 =?utf-8?B?REczMGxxSmplRVNNS0ZPcnAzM0FaNWlEOUE5QjhTd2QwZVp3THB1WEFRUmsz?=
 =?utf-8?B?WHdVRGFHNFllc3JTTWpLdW92OFlzMit1VFJIV3dQWkduSmhFNy91VmhsT3Iw?=
 =?utf-8?B?OCthSThDNEdxZ0puMXliNDZPOWJjWS9OV2I4UW03SSswVythZUNOeGtBZVNQ?=
 =?utf-8?B?ZGtTd01uSG9JNXg2L1pDUjVhWUk3Nko0K2RGcjVmMmdoNDgzNVh3MU8wTTJm?=
 =?utf-8?B?dVVJVEJ2NHNFL1lmZ3RnSHJHdmI3TEpCMXF5VnhMcFV5MStaaUVaakVxTUNC?=
 =?utf-8?B?MWZvUXQwbFpMYytmd0dhb2ZrbW85ZndwN0JzWXJneWFlblFNaHFhTGNzTlMz?=
 =?utf-8?B?YXlxUk44dHJ1bTFpTDRvTDdoM1RraFl2STlTUktqMzFJR1ZUaTAwSjUwc2RI?=
 =?utf-8?B?QldTRjlBeGhzbFA3aGorYWJ1ZEd0ZUhZdnVPemw0MWNFdkRFSGltWWhMQkwv?=
 =?utf-8?B?Qk5LY3pFYVJ2Wm9PMmcvL2gweElhR2dVTlBBeUltTkhvUnpDWDczTGNtMFJh?=
 =?utf-8?B?cDcybFhMWWdFZFBWRExnM3gzUUx0bUtIUktMMzFoMTZxQzVKakNxOG0wL0Nr?=
 =?utf-8?B?Q2pFdVFGNVE3VkwxRkRnM2ZHUUlUZ2VqbCtTNjdWNTY2TDV2bWUrcGZzOEJy?=
 =?utf-8?B?a2lpUlpRLzZ5cmZzOHdZck44WkxqMzRMT2YrVVJWd0IvZzREYnVYQVkzam0w?=
 =?utf-8?B?R2QxK2JENThWZTVLUm1UbHpZWmRCVHZ3SmY3Zk5EdHQ4RmNwYnZkajh2eFZF?=
 =?utf-8?B?QVJYRER3VHByaWZ4a2FMQ3lYcGc2bWU2bE1ITHE3bjZHZXRHY21MZG8wb09m?=
 =?utf-8?B?d1ZBSDlRdzY4alpJellHamNLMVRmbzhjbUhNeE01RjF0WUoyZVVUczgyeWQx?=
 =?utf-8?B?d2FBYmNncjEvYzBORWNlZGtUaXFWZ28wU21RcHllNzlHWWRBTm5nSVJSZzNC?=
 =?utf-8?B?WXhCVHZHWnFyNHJPbVFpbmk4dHpIN01SK29Ccmw1K3ZkeWtxVyt3bVdiNGk2?=
 =?utf-8?B?OUg0Y291MGV4Sk9EVnJNL1JLdldVL0RZZVRMcnFteEhsNHFGMGJzNTA3TnJW?=
 =?utf-8?B?ZzR5U0VaRFZrRlZXWTc5Z3VIeEdxS1BNTUFYcTloVmlMeUtUTUhGQytxUnJI?=
 =?utf-8?B?Tk1Qa3RldElxeUdzTFlVb05YSUF5RGVOTmtWM0VWZk9CRlYvVHRKSitEL2Ju?=
 =?utf-8?B?ZEpFR2tUWTdEUFBtTnZySTFvZkpxMHoyZ2h0L3dldSs1dUxMUTZiRXlLM2N2?=
 =?utf-8?Q?d2d6B1ouft8BGYZ1XkqskCeB5?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8316a2c-ace0-4d2f-fad0-08dba20db412
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 06:13:14.4285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QY1oq5vhqoqTJ3xT8LtW3I4lwyIG9I+y9Nexj6pw6rn/+euYFnMiHTlbF9g/2MBkq/CdGn62CqlJ3XGHhKaB9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7880
X-Proofpoint-ORIG-GUID: d63t4xV1PZl2htxB2z57nbGznlKOZxnu
X-Proofpoint-GUID: d63t4xV1PZl2htxB2z57nbGznlKOZxnu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.279, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi qemu-devel community,

A gentle reminder and request for all migration maintainers - Peter, 
Juan, Dr. Gilbert and others too for review of the patchset series. 
Received reviewed-by from Daniel on migration implementation patches but 
need final approval from migration maintainers before getting it merged. 
Also got acked-by tag from Markus on the QAPI patches. This is Part1 of 
the 4 patchset series. Ultimate goal of the whole 4 series is to 
'introduce multiple interface support on top of existing multifd 
capability'. Hope to get approval or comments from migration maintainers 
on the patches soon.

Thankyou :)

On 03/08/23 11:13 am, Het Gala wrote:
> Hi,
>
> A gentle reminder for Juan and other migration maintainers for the 
> review of this patchset series if any changes are required or give to 
> queue them. There are more patchset series coming after this. As 
> discussed earlier, we have broken down it into 4 different patchset 
> series. This is just Part1 of the 4 patchset series. Ultimate goal is 
> to 'introduce multiple interface support on top of existing multifd 
> capability'.
>
> On 27/07/23 4:59 pm, Het Gala wrote:
>> This is just a ping for Juan and other migration maintainers, if it's 
>> possible to have a look at the migration patches for new QAPI design 
>> and suggest some review comments if any.
>>
>> Update till now : Have got acked-by label from Markus for the new 
>> migrate QAPI design, and reviewd-by label from Daniel on the QAPI 
>> implementation side patches.
>>
>> On 26/07/23 7:48 pm, Het Gala wrote:
>>> This is v10 patchset of modified 'migrate' and 'migrate-incoming' 
>>> QAPI design
>>> for upstream review.
>>>
>>> Would like to thank all the maintainers that actively participated 
>>> in the v9
>>> patchset discussion and gave insightful suggestions to improve the 
>>> patches.
>>>
>>>
>>> Link to previous upstream community patchset links:
>>> v1: https://lists.gnu.org/archive/html/qemu-devel/2022-12/msg04339.html
>>> v2: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02106.html
>>> v3: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02473.html
>>> v4: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03064.html
>>> v5: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04845.html
>>> v6: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg01251.html
>>> v7: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02027.html
>>> v8: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02770.html
>>> v9: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg04216.html
>>>
>>> v9 -> v10 changelog:
>>> -------------------
>>> - Patch6 : Added extra checks for migration arguments.
>>> - Patch8 : Added checks for 'uri' and 'channels' both not present.
>>> - Patch9 : Missed adding hmp_handle_error call to print error messages.
>>> Abstract:
>>> ---------
>>>
>>> Current QAPI 'migrate' command design (for initiating a migration
>>> stream) contains information regarding different migrate transport 
>>> mechanism
>>> (tcp / unix / exec), dest-host IP address, and binding port number 
>>> in form of
>>> a string. Thus the design does seem to have some design issues. Some 
>>> of the
>>> issues, stated below are:
>>>
>>> 1. Use of string URIs is a data encoding scheme within a data 
>>> encoding scheme.
>>>     QEMU code should directly be able to work with the results from 
>>> QAPI,
>>>     without resorting to do a second level of parsing (eg. 
>>> socket_parse()).
>>> 2. For features / parameters related to migration, the migration 
>>> tunables needs
>>>     to be defined and updated upfront. For example, 
>>> 'migrate-set-capability'
>>>     and 'migrate-set-parameter' is required to enable multifd 
>>> capability and
>>>     multifd-number of channels respectively. Instead, 
>>> 'Multifd-channels' can
>>>     directly be represented as a single additional parameter to 
>>> 'migrate'
>>>     QAPI. 'migrate-set-capability' and 'migrate-set-parameter' 
>>> commands could
>>>     be used for runtime tunables that need setting after migration 
>>> has already
>>>     started.
>>>
>>> The current patchset focuses on solving the first problem of 
>>> multi-level
>>> encoding of URIs. The patch defines 'migrate' command as a QAPI 
>>> discriminated
>>> union for the various transport backends (like socket, exec and 
>>> rdma), and on
>>> basis of transport backends, different migration parameters are 
>>> defined.
>>>
>>> (uri) string -->  (channel) Channel-type
>>>                              Transport-type
>>>                              Migration parameters based on transport 
>>> type
>>> ------------------------------------------------------------------------------ 
>>>
>>>
>>> Het Gala (10):
>>>    migration: New QAPI type 'MigrateAddress'
>>>    migration: convert migration 'uri' into 'MigrateAddress'
>>>    migration: convert socket backend to accept MigrateAddress
>>>    migration: convert rdma backend to accept MigrateAddress
>>>    migration: convert exec backend to accept MigrateAddress.
>>>    migration: New migrate and migrate-incoming argument 'channels'
>>>    migration: modify migration_channels_and_uri_compatible() for new 
>>> QAPI
>>>      syntax
>>>    migration: Implement MigrateChannelList to qmp migration flow.
>>>    migration: Implement MigrateChannelList to hmp migration flow.
>>>    migration: modify test_multifd_tcp_none() to use new QAPI syntax.
>>>
>>>   migration/exec.c               |  72 +++++++++----
>>>   migration/exec.h               |   8 +-
>>>   migration/migration-hmp-cmds.c |  17 ++-
>>>   migration/migration.c          | 190 
>>> ++++++++++++++++++++++++++-------
>>>   migration/migration.h          |   3 +-
>>>   migration/rdma.c               |  34 +++---
>>>   migration/rdma.h               |   6 +-
>>>   migration/socket.c             |  39 ++-----
>>>   migration/socket.h             |   7 +-
>>>   qapi/migration.json            | 150 +++++++++++++++++++++++++-
>>>   softmmu/vl.c                   |   2 +-
>>>   tests/qtest/migration-test.c   |   7 +-
>>>   12 files changed, 409 insertions(+), 126 deletions(-)
>> Regards,
>> Het Gala
> Regards,
> Het Gala
Regards,
Het Gala

