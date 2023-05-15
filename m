Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF46703067
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 16:44:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyZM9-0002xH-Uy; Mon, 15 May 2023 10:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pyZM6-0002de-VS
 for qemu-devel@nongnu.org; Mon, 15 May 2023 10:39:19 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pyZM2-0006SP-OM
 for qemu-devel@nongnu.org; Mon, 15 May 2023 10:39:17 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34FD2O6c031691; Mon, 15 May 2023 07:39:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=I68iekHOXdsVEW1sEbC5llReAJMI5gnVlYpKe4hV0bQ=;
 b=vPPKJ4UsoeXJMAXYKr/1lVA4oCkuwflovXxS/H139VlPJ1rgzu2HkgpvvxGyFlDZj2n1
 pfdiugV5AW8BUNOz/R+1Ls2kp+9us94FhVow+eeYjy95vNKk7Mh0Ekf0EEZflYSquEQP
 OdQ2MmggUJqMsKaR42y6wb42jVVvRh9yULzPk7VXvk2u7TVqAkGGoWql1xzXG5nYhySZ
 nnZt0ZP8ST1wCfzE/2j2A3PBoS1aSyqlU+M0hn+DzzcdszwMmznWwlwPhBx7HxOVCpuq
 1bgKyuvf6FIdff6P03/YbLVuORykX6+JzodDWN6yQne+hbg6U2jpLECAAEJI7xJy0dk7 5w== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qja3wk11y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 May 2023 07:39:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=facUC3zOypVuU+DB114hvVEWu8N7sTfLgu8+MY7cPeQAg5ercM6Vskzdp553SxjzW5RIjUGlaNLfLb//qOqaJS4ZChdKRs3tq/lt44odeZvWBgkLphYbEGT71aKcvkG6aLsJsIthIlmcu0TPagvZRyUeEbeE/LezkpKzcOvoqySJFrdEva+TKtRwhVvLgLuFn7jjBbOIjVcgIqaQP019wyWRSXBsC7z90ccqvKYOwk5TVmvzV7yYEhbZ1nz9e1gPL2jXh/AtBAvMDXrS2XK3qjvqb3cVn590dgHtxujO1wxT/keSJ+9wRnMgviqrRhARBx8+ODSqdHSmtq9/Z+Yo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I68iekHOXdsVEW1sEbC5llReAJMI5gnVlYpKe4hV0bQ=;
 b=e6GJobBsdMX6ewK+LXS9IF2K9dM1FPEqXTo2+A5r3cB65C1BoC97fsyGLT1r4pGdSQFWPA3X/qXBmlsWnn0JAgHWhO4A3ewwswOOygzHK4g5qJBqY8b19sls2EVS9tWR0tzYl+y0sxokgI1aPTCnLs6zWRMntdv9AfQk1Laszq6LSzVxb+A0deauS6LMpuVWYtRiB88b696Pdmxix3/T/wx/Vcsqk79+Lp1M7vSh33Odnc5X113eOUAVt2yWPneqk6Udp2g+jXGn+vIoTbvXoe7OWxbdWoPafFlEZYv2ZB9/4MzcuqXan6fZXsEX2A4cmJb0QSEgdnhvB7ekyP2r+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I68iekHOXdsVEW1sEbC5llReAJMI5gnVlYpKe4hV0bQ=;
 b=wijJdKkBdQUe6eKZrjUjl5p/YgwBsBO3r1aGNLT6nFW6JIKttbwaXvwQcuY1yPFbLcozDg2uizR0n+hM9QntcBm2oJw4dWUcKHgCUpRjZooIOeREPZltGhSVy5bf5rxiCzNRN/CLdJYFrEVw7hTzt+ajg/8nJux+OZu6ICMudoJNcfX2YjQYYTbJMXpbYMemaUlV1wELv8wDgXfQ6UW0MFayW7gfyek5rkQUbXY/f8r/sB5JhWZJ2EygdJKa4fusj5/eWE9eylOSLWT00gVbhYLUeLg7ai8SRCETLmyrrdV13xbOIBJeYdBl50P+FQZxOz9/39LemWZBpDzD/Dgdcg==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CH2PR02MB7048.namprd02.prod.outlook.com (2603:10b6:610:5d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:39:09 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:39:09 +0000
Message-ID: <ae609793-7d9b-a305-d0bf-e8e9eb59d66c@nutanix.com>
Date: Mon, 15 May 2023 20:08:57 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 4/8] migration: converts rdma backend to accept
 MigrateAddress struct
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230512143240.192504-1-het.gala@nutanix.com>
 <20230512143240.192504-5-het.gala@nutanix.com> <ZGIIVc83VbEMgUhB@redhat.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZGIIVc83VbEMgUhB@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::8) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|CH2PR02MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 8998c68a-9f6d-482f-32a2-08db5552245e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2IQuYJfnNPsBHzvhm2OXtSgEKyLTOkoWwtYJqc2yCM7oHXS8oEs/TaVx+/6foi8lLWeos1+mJflfJhLJeYWm5JnPv7rJYbkiv7pnLeHwtbqrpKWrYoNJFBhg8ndps/7X2q6UxSWngFi7JEeIUUrtFYdZzCitXpc76JQLbheO8tudvFY+oVbhvZryFrR26A2JG14UYt0My3ItJRM7FNpRGqzISjYzXlkS+29SPjCJW0aiwE926W61KKUbAmXU9BDScYj+Hle+YOxFOWEI55UJCdvHSZNeDtgq6X6okwLieOXQ5Ert1j/ff3U/MRzRRyIDXgkoaa5BanFqsi4E7fxSXrnWwLO/Bb96ujl4gsu/D8BU+EeMzsXdxlJntKNBNUO5jNcMxbMIoZxSggzzkFxOBdIjXkr6qhTyPWgCDaqWZl7nxRL0dB3+Fdr6pn3HLMkc4KecJoFwscoSW5ESlSyrzOak/BG9WobSQEbesN+qInzkrO/p7nJ3b3rg7TARW/KI9T3pMX4J6o6SQ8HMQdXexHSEE6ct7u3k7YfE6nboXVz05rLh+N8Qz7pt1npisRMcvvxy+Lp9YMGhP/Y4G3ddUfnDg/HDqGeLGz0eI/0O3LViYljdykawSbtctWp9nvm3mcA26L2WDRwbzrSIt1FtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(2906002)(5660300002)(44832011)(36756003)(31696002)(86362001)(38100700002)(31686004)(107886003)(66556008)(4326008)(66946007)(66476007)(2616005)(6916009)(316002)(186003)(478600001)(26005)(53546011)(6666004)(6506007)(6512007)(6486002)(83380400001)(41300700001)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVByTUo5QVdPTTNnOTJwY0YwOE1NSXlva0UxWStITmJqT0hiSUd5cmt1bTk2?=
 =?utf-8?B?Wmlka3lDdjdueTF0RGw0MTZpdTR2VjdnbHVpeFZWTHlPMXF4NjBEVUNVMG42?=
 =?utf-8?B?VHFGMXVDWnFMeTh0OUFuY0R0VExWTnhDc0JieU5FSlRuWTRzeGRkMlFIa0Ns?=
 =?utf-8?B?NUxnYTJScEsrajVqbFV0VldEbmlmU1FVaS9OSk15UExqeVIwZFFIWmF6dEI4?=
 =?utf-8?B?UndPKzV4SWJiYnQ3aDV1NWxsU2NTb3J6V2Zybk1rd2xPKzNMd1NYSTJJYzBs?=
 =?utf-8?B?K1hiNFFnTmJWbWJmVndEUmQ0VUJ5clAyNklycFNrWXpPejlVQjl3clkrRjZ4?=
 =?utf-8?B?Uzc5bW5QNEMyTGNOU2ZVWEVHSWNRL3lsQTRDbjlQK2hFUUUrWGtRMXBiUlRM?=
 =?utf-8?B?Q3FnOGVrWFJWeWVrK2VtcjFkdUg5TnE5YkFEZVdYTDZScVNFMys5aW5iMjNa?=
 =?utf-8?B?cEV3aFV2R1FTODFrR2dJNnRTdVIyU3RIbDE5eElKbDJwM0NKRVFaM1M1YjQ2?=
 =?utf-8?B?QktKaXZoaGk3WUZpR1RUeVJFaHpsM3ZYVjNGS0RYbzNvUkR6eUY1UHd5NGZz?=
 =?utf-8?B?aDNnZDZvQjRGUktLOHdpN3BVejdoMEhmZ0toY0J6K09laXUzMFZEZXo2SlVX?=
 =?utf-8?B?KzF1YU9wdzNkYzJSZ0gvT1VRU3ZhdWRIaGhMcG5OcndOb3FmY0doeXFRYmlD?=
 =?utf-8?B?OHd3MlBxQnNEZE4xVXpjS1p5Z2pzaVZ1VXlYTDJqazdkK2RhcnRCUU1KalZS?=
 =?utf-8?B?cnkzS2hEdTJkQStidVlMM2NPSklISGFhR3I5V0tYMjA3WXkwenJmcVZSaVpJ?=
 =?utf-8?B?UXF4QnR5VWtMeDlSeTllaGJJYmFmMTkyd0l6M2hhT3o5VWhUZ2xqcHF1aC9L?=
 =?utf-8?B?V1p0K2Q4dzhGNXRNbVc0TGR0NWNSTWtxVlZLT2NDYW1PeVI2cC8xdC9DUXp5?=
 =?utf-8?B?K1FSeDU4U2h1VVl3VkRqQ1dSRUpNN0NPVjVyR3R6YzFnUVhwRjlhKzNrQkR0?=
 =?utf-8?B?cHJocHhSNVRrWmd0NXkyOTFKMGIwMVdDVGdURFMwTHY1MTRyRXBsaDVvOUJj?=
 =?utf-8?B?TW9UY1BkbThjM1JnRHkvdERQWUJPLzZxUVJHUmdNQ0ZVSk9lbnNhWXlsdjhV?=
 =?utf-8?B?TzlVbzdZNFNRQUtOWHBHUmRNWlJ5YldMa1JHOERxa2hSNmNEeFh3b2JTSUpH?=
 =?utf-8?B?MWJRYjZabHNhNnJrOXNPVkY5TTJPdGdianM4T3A3OTUvMWtxVDcxYjNXUXZN?=
 =?utf-8?B?MzFvd09PUnJvYzRyMGphbXFaazl4TC9hanhFZlNBKy84Rk82Nm1aVlgyQUZx?=
 =?utf-8?B?MjcwUC9aU1B4TzFKaTBSNFdvUDdtOWZkS2lhTnI2NGVyMXJvYzFRVkltdUtC?=
 =?utf-8?B?NUtpYjFSZXN3dWxDdWE2WEZEeCtwRXZ2ZUtPTUxCMnR6MFowYmJvMGVacTJn?=
 =?utf-8?B?MUFaUEtPS2pmR3o2QTZMSU05V08yT0hMT1N6T2p2aGc4K3dCeWtvc3VNckxR?=
 =?utf-8?B?Uzk1T3AzTVFqK3A1RDdiblhLNnlLcXdjdGpVam9MY1hhQ01wcE00M2lKQnM2?=
 =?utf-8?B?RklZOVNvcXpnd1dkMTRzdktxbkVZRFRXcWRyZzFWL3ZIMEQ0VkpxRWxJcEJR?=
 =?utf-8?B?blg3d3NJdE1NT3BZVVhrdmlQTXBxUEhxWnhQYVpRcHgzcDdUdUgydHdMY3Z0?=
 =?utf-8?B?RzllMjRDZk9EaHQ0L0s5dDRQbEl2U2thcDEwYTUxZGF5TVpnZU1pVjRaNGJK?=
 =?utf-8?B?a1pXWmM4ck5ZK0t2cmkyZHlmWjloZHF6SlRLQXJIVHVocG1vQnB0WjBwUE9v?=
 =?utf-8?B?QWxKc2dVYXJWcDJkOU9QcDhlbER6ci84UDJEYXlKcTh4Zzc5R2pYQVFtT05v?=
 =?utf-8?B?LzVBdkFMNDNhVFBNM2VUelNFSzZON2pNZUsyMjMzNGFHOWErRmd3b3BKU2xU?=
 =?utf-8?B?UjJqQTdIZUY4YmVlanFOTGUxTEl2ZEVpcHZFY0xsRnJ1dVZ0THc0Ti9FZjZX?=
 =?utf-8?B?SDJrTEFZSEhDbzNqWG1CLzhMWHZoaVdKTHArbW5LalR1VktwM2hET2kxaDFC?=
 =?utf-8?B?UWpNM1Z6Y0d3b2ZyQzVlS3dEaDFDSERrbkVsZTcrNG4vNVl1dXZBSCtHSlBa?=
 =?utf-8?Q?jpFEBAdfo5L9/NcAk9OSox0bR?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8998c68a-9f6d-482f-32a2-08db5552245e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:39:09.3037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qfbb5/a5bNhHu4HYLq6PoMPDOhwKmMm3Ktj1VspAXa4BAO/PnlSfDDzy3Qg2PwbOlM9A1DgugO8dnObYRN/wrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7048
X-Proofpoint-GUID: --5pKphuCI0No5YwUO4Bm_tkE87FigEY
X-Proofpoint-ORIG-GUID: --5pKphuCI0No5YwUO4Bm_tkE87FigEY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.811, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 15/05/23 3:54 pm, Daniel P. Berrangé wrote:
> On Fri, May 12, 2023 at 02:32:36PM +0000, Het Gala wrote:
>> RDMA based transport backend for 'migrate'/'migrate-incoming' QAPIs
>> accept new wire protocol of MigrateAddress struct.
>>
>> It is achived by parsing 'uri' string and storing migration parameters
>> required for RDMA connection into well defined InetSocketAddress struct.
>>
>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> ---
>>   migration/migration.c |  8 ++++----
>>   migration/rdma.c      | 38 ++++++++++++++++----------------------
>>   migration/rdma.h      |  6 ++++--
>>   3 files changed, 24 insertions(+), 28 deletions(-)
>>
>> @@ -3360,10 +3346,12 @@ static int qemu_rdma_accept(RDMAContext *rdma)
>>                                               .private_data_len = sizeof(cap),
>>                                            };
>>       RDMAContext *rdma_return_path = NULL;
>> +    InetSocketAddress *isock = g_new0(InetSocketAddress, 1);
>>       struct rdma_cm_event *cm_event;
>>       struct ibv_context *verbs;
>>       int ret = -EINVAL;
>>       int idx;
>> +    char arr[8];
>>   
>>       ret = rdma_get_cm_event(rdma->channel, &cm_event);
>>       if (ret) {
>> @@ -3375,13 +3363,17 @@ static int qemu_rdma_accept(RDMAContext *rdma)
>>           goto err_rdma_dest_wait;
>>       }
>>   
>> +    isock->host = rdma->host;
>> +    sprintf(arr,"%d", rdma->port);
>> +    isock->port = arr;
> While Inet ports are 16-bit, and so 65535 fits in a char[8], nothing
> at the QAPI parser level is enforcing this.
>
> IOW, someone can pass QEMU a QAPI config with port = 235252353253253253232
> and casue this sprintf to smash the stack.
>
> Also this is assigning a stack variable to isock->port which
> expects a heap variable. qapi_free_InetSocketAddress() will
> call free(isock->port) which will again crash.
>
> Just do
>
>    g_autoptr(InetSocketAddress) isock = g_new0(InetSocketAddress, 1);
>
>    isock->port = g_strdup_printf("%d", rdma->port);
Thanks Daniel. Will change this in next version of patchset. Is a 
protection for isock->host and isock->port needed here ?
>> +
>>       /*
>>        * initialize the RDMAContext for return path for postcopy after first
>>        * connection request reached.
>>        */
>>       if ((migrate_postcopy() || migrate_return_path())
>>           && !rdma->is_return_path) {
>> -        rdma_return_path = qemu_rdma_data_init(rdma->host_port, NULL);
>> +        rdma_return_path = qemu_rdma_data_init(isock, NULL);
>>           if (rdma_return_path == NULL) {
>>               rdma_ack_cm_event(cm_event);
>>               goto err_rdma_dest_wait;
>> @@ -3506,6 +3498,8 @@ static int qemu_rdma_accept(RDMAContext *rdma)
>>   err_rdma_dest_wait:
>>       rdma->error_state = ret;
>>       qemu_rdma_cleanup(rdma);
>> +    qapi_free_InetSocketAddress(isock);
>> +    g_free(arr);
> Free'ing a stack variable
Ack, will delete both statements from here.
>>       g_free(rdma_return_path);
>>       return ret;
>>   }
>> @@ -4114,7 +4108,8 @@ static void rdma_accept_incoming_migration(void *opaque)
>>       }
>>   }
>>   
>> -void rdma_start_incoming_migration(const char *host_port, Error **errp)
>> +void rdma_start_incoming_migration(InetSocketAddress *host_port,
>> +                                   Error **errp)
>>   {
>>       int ret;
>>       RDMAContext *rdma;
>> @@ -4160,13 +4155,12 @@ err:
>>       error_propagate(errp, local_err);
>>       if (rdma) {
>>           g_free(rdma->host);
>> -        g_free(rdma->host_port);
>>       }
>>       g_free(rdma);
>>   }
>>   
>>   void rdma_start_outgoing_migration(void *opaque,
>> -                            const char *host_port, Error **errp)
>> +                            InetSocketAddress *host_port, Error **errp)
>>   {
>>       MigrationState *s = opaque;
>>       RDMAContext *rdma_return_path = NULL;
>> diff --git a/migration/rdma.h b/migration/rdma.h
>> index de2ba09dc5..ee89296555 100644
>> --- a/migration/rdma.h
>> +++ b/migration/rdma.h
>> @@ -14,12 +14,14 @@
>>    *
>>    */
>>   
>> +#include "qemu/sockets.h"
>> +
>>   #ifndef QEMU_MIGRATION_RDMA_H
>>   #define QEMU_MIGRATION_RDMA_H
>>   
>> -void rdma_start_outgoing_migration(void *opaque, const char *host_port,
>> +void rdma_start_outgoing_migration(void *opaque, InetSocketAddress *host_port,
>>                                      Error **errp);
>>   
>> -void rdma_start_incoming_migration(const char *host_port, Error **errp);
>> +void rdma_start_incoming_migration(InetSocketAddress *host_port, Error **errp);
>>   
>>   #endif
>> -- 
>> 2.22.3
>>
> With regards,
> Daniel
Regards,
Het Gala

