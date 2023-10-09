Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5695B7BDE74
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:19:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpq9K-0004QJ-6z; Mon, 09 Oct 2023 09:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qpq9H-0004Q9-0N
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:18:16 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qpq9C-00054x-Eh
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:18:14 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 399Co7UF010562; Mon, 9 Oct 2023 06:18:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=5MXJ/s8TtjS+
 Gmvh6ZzrlF8t9HriAICYt++zNDsCjZk=; b=es/zvs84Fky843Z5w6ey84okbf+Z
 RqzgZRDK51+m+bmPRN6sWC4Cp2nCx8NELEqaXMmfi5e2Fep2UdXj8DA7S+wvrqr9
 mrtJhzKGMPPfutYWS7LmdsyBy3X58O/w7Whj5S/upBLvkjBQCXX+xBmdE0I/RrVH
 5urx0ZDFimPo9bh4MG7R2Zw2DGYVZBRJa9uLRyxSS3jZE9QHAQWgXUGPvcxO2hg2
 zv6t2yOvXA3f59LsWXwTziWh3cFCQBNLeEfZJv+qeV7A7O/+qS693VfUsiyBQ0uh
 6IBOQF7OXkPey/TKPRsE7MZaP5VCpfd9tlS8KpC1/nJT/ai/pH/Z4Jb5DA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkj0qtkyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 06:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoNhzoeT0csITXb2PjiAUb3RT+7ejAxr4ggkNMYDQTRXUgdjYzVsI5u32jEKXPIXGKE6/A3EE1TVDPPawGJqGszTHVPROJXlLalAdmXwbxmtj0a4MMJ1W+rYupU8lCJFNLXILSTE7JK7xJUsExsTguFqthzMz3qlSHVZCOe9na9H8km0Hyu0Z2WvLdrkWgWxjmubFPIORWjI5pPciL/2Lv4FZx4zytjdDQNrIA3TsGgCuwsJHA71UgGOoQwJOtGkO7SL7aAKCCXz0oegvWl3NZ11PMp9X+HxjS91xtvNDxyfie0Np/osudgRebl5H7XOX4S8EvOeBFcvAUM+otS3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MXJ/s8TtjS+Gmvh6ZzrlF8t9HriAICYt++zNDsCjZk=;
 b=khhY0dumHzFwQejTo29H8VHkPGyKh3Cd5RMcvagjRfdZOIgIdyJfxyBrj0Fo85TcMJETTowdfRu7mxrvA6PAcedVcgj7rCXIyobv9lF1XdBjqwFZe3ZDYiqJh1AR3S9YoybD1roqbg0Tj51Nq0FkOrLJP9X3NOQUEPuGdYtBZoStJvoZpaqwF3ZBDQPXkwf5dcBldST13SYYuyvLcY9yiapcywZYSaCdeMVrJWsiWBB8LPpTRLaXoK/0qqCUxM2jONwGrri6HWA3APcZJDGgt0IJEuKF0flXk/j72ZIsr6DDATzI++i65i/fulcUZ7hKgbFUx6Z1HFQ+07aROignNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MXJ/s8TtjS+Gmvh6ZzrlF8t9HriAICYt++zNDsCjZk=;
 b=tVVMgRJNFJSPrXbh1n4ohWs4Fl/xUgGmrxh2MF/x/kpbKGg5GhSkPiAd/HzI2rGI+KRbAeYLGxN1QeWoCc7D4aJ4n72bo0XbRyYV1YUELdcbe+nN1p8MuAvCgjwdWvmV81VSJ0gesqdv4PxkHL0pj7L499gWwXC+A4Rg3eWAmEq1FRq5T5Ltau9dVF7clj+yjxO10olszxde0PwZ8b/T4VyoS6t8VYvv3s8G/ka9lKBEyY+EHkXholsXqIUWsVGWSG0gE35tpJvmvOQtlAoZwMev0njFwW5es005+I4JHWrEywtzb0RtZMwwSAAqeXc/kE5AQo7fEhk0bWCLV1n1Cg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SN7PR02MB9302.namprd02.prod.outlook.com (2603:10b6:806:34d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Mon, 9 Oct
 2023 13:17:58 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 13:17:58 +0000
Content-Type: multipart/alternative;
 boundary="------------d0BitAF6b7JW51tqgjLjAYNs"
Message-ID: <9afc363b-537f-441c-a960-83d6478a65fb@nutanix.com>
Date: Mon, 9 Oct 2023 18:47:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/10] migration: modify test_multifd_tcp_none() to
 use new QAPI syntax.
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-11-het.gala@nutanix.com> <878r8ipfy1.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <878r8ipfy1.fsf@suse.de>
X-ClientProxiedBy: BYAPR07CA0069.namprd07.prod.outlook.com
 (2603:10b6:a03:60::46) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SN7PR02MB9302:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ffe2fd3-beb9-4cb8-584a-08dbc8ca27eb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xR1LJ/jcE1lj7SwdZ22whPsv9DnJP1+1I0OFTfhLvjXHI8/PLYvNIstkOcxIiIjR6JXUtY/ZeKjSMlGIE0P7PgpBPw96IfDoKvJrUq2zjXq7MtlM7JKQdrDw/bFmPcUuVcyhjVsbFf6FsLdLscFZyWzyPXK1DUt51+Ki441dWFQWpz0srzEPu+sbVvr0hysuVV6l/qVffFM8way3qw0yxJlcsEPx2MBzQfQePU4YWhaxmcZVAJX1RQz3iFhBFuL4Vr91Knjte9HO3drBybNtqJ1zCy9O18GaMvytFx4IzBVGqZwZHGEX3fG6s+/KJZUQ7W+4EXFlXLG5XvDQVs0Mx+lLTLUQB8b59d8CPiC8NXs0bDV1U+7zBGE5PVECrUnnsZK5nAcTO0UcUTT6klciN8Z0c2SGLo6motqlzWTh7NOe8epGcQGELEykyV6RfUGuCFqBZ2Tr8mkq3vZq87ocWRT0DTP8V84NambC+pFMzYES5EsVMgXpe7btpRmkuDIinWamZbs6mQsnQuJ5DPnPzpr27nuwLCU5/A7uwI1v2EhG0ng7ZPGHwup7S898/jw1I5oOODpOy/+K2gq0QnBLTQz3g924vHsRxveQj/4z58BC411w+N7rnfrmcB9NPVV5kx+alFnRQnbpH//L545RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(6512007)(33964004)(53546011)(6506007)(478600001)(2616005)(6486002)(2906002)(83380400001)(8676002)(66946007)(5660300002)(44832011)(66556008)(41300700001)(4326008)(8936002)(66476007)(316002)(38100700002)(26005)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXVzbVgvQlVOdUJrSU9uY3ZadlZNbjFENDNzWG9OcTUwOXBrZ1Z1MzVOTit5?=
 =?utf-8?B?OUNLb0VSVmFzWWJDM2o2MkNiN0NMaGRsTVBKNHJCK2pUSTQ2eFo2OFJSVWxV?=
 =?utf-8?B?TlE1ekpaT1FDR0dqWnRvL0xyeHU2b015bFc1LzU3QTlxdXhybXVURFllU2Ez?=
 =?utf-8?B?N3crd2xPemQyMDVFaTQ4TjdDME0waHc1d2c3amJyM2RBaERHWlB4U0R2RlQy?=
 =?utf-8?B?Vkc1M0ZNMFBnenVXcnlTMUNsbHJzbTVkNjFjNUN2V3FpenpjWTcvMEg0dXVL?=
 =?utf-8?B?d2dKZ1RpVGFLTjVGZDZBWWpOcG9FdXkwOE5pUnIzM3hCQUQ0N245RitYZVg2?=
 =?utf-8?B?b05rUy9UUnNMdWVUdWdLWDVTMDZEdmVwcTFJZzNqRFNtUXAwZTJ3ZWl3U2Rl?=
 =?utf-8?B?ZEJnSitIbzRxSERxV1E0UFhERTJ3U3BJUlcveUhTdUF2VGlxZWdHMlJ6V01Q?=
 =?utf-8?B?eXZUQ0s1RGdnZmRPUDY1MlVIVVJJcW5wMzgySG10cVdld1J4M0dNSmtQYzZF?=
 =?utf-8?B?UmdVR0ZOUEwzcnBEUFZmOW9pdi9wYUhFTjQwTE16cHFFWHZvcTY2UWllb29R?=
 =?utf-8?B?OVB0bFIzVXlaNW95ZHRMTDY4UXdCNkdabGdpSnpNSFg1VWNIbnFrMDZyeFpS?=
 =?utf-8?B?bzBwY2t0NzRmOGJTT1A5ZUxQWWcrbHJQVkRueWV4QnFIMllJTFpLay9yQUdw?=
 =?utf-8?B?SVZRTDZBYVdjczdPYURGNU5EVVIvWTRSZTU1eWp0SW03ZzUxbTlaandWZk5J?=
 =?utf-8?B?Sm5HaXFqeDVCbnlabkFxUDZvc0djblgwZVIzUUt0RVNFcGp4WGEyNno2NC9k?=
 =?utf-8?B?ZU1JRFNzQy8xRGJLTFBGM1dydUhqd3pZVXVFTUR2RkczN1Z1V0tnUGNibits?=
 =?utf-8?B?NE1DMkNYVVFCQm0ra0lXelJJcHZvN1JTdElxZ2hmem1qWjMrdE1BbWtXOXFR?=
 =?utf-8?B?cXc2bHdpYy9rMUpxa0xlY3l0VGpXV0kzSkh2TTR5RnVKSFhHYVlveXpYd0cv?=
 =?utf-8?B?Tm5hMmFWKzdMeldKTG1hWWQvZHk2Q2ZrOStQZnRldC9EUUNTdk5NMUh0RnpT?=
 =?utf-8?B?TU9mcTRxVGU4SEx4ZmxDTHhJd2NvRXAyZmorY2wySVBTQXhOdWxYdEUxM3ZT?=
 =?utf-8?B?K2psbVh4aGY3c0RTZVNlRTc3Rk5ZWHpsQWNqbTNWOHRvL1JCRGVNUXVpZXo3?=
 =?utf-8?B?UEM5UGcvL1NLRmxUTFpQTGdwK1ZrekpZMGNQRmUraEFOdEFCZlhoUS83Rzg0?=
 =?utf-8?B?QXh4VzNoMjBMWkxiN0lPQTVhNGpGaGMwSE1lOE1nUkJZclVJaXFlVTFLeWhn?=
 =?utf-8?B?cmFSOWxYZmxBWU9KVWlaYmE4VG4yZlNnWXFGRjFqRnNMSFJEWmRDS1gvY1pP?=
 =?utf-8?B?VVBZYkpiNEFtYWptWmZZTktSUnE5bkkxN3cwZTJJS1o5YmdGSmtocnh4bUxD?=
 =?utf-8?B?SHB2QkVydkZvU2FWSysyTzh1VEF0NDZnVHdwa3NienZnNGNPdEtSUDVWSmhY?=
 =?utf-8?B?aFRYSFhTYUVsaThNUWNkcU5hZ2RjdERmRzN0enRJMGliWVVheldKUUJ2THFO?=
 =?utf-8?B?VVFrNFZQaXQwMi9PYlVGM2hEK0Vkem9XRi9ialBkL28wRzVxTnZIU0xndzZx?=
 =?utf-8?B?YW41VENoRFkrQ0EyWUYxV0UvUnNROEJNbmxIbjVKTlB4RDJqTUhQcjZuTXFV?=
 =?utf-8?B?VFJCU3V3a3JMc1RoRmxabGhFaHdlY1hac3E2eGZkWisrak1yWVBQeHBuWG1s?=
 =?utf-8?B?L0tPc0NqUkdmMWxqaUtUbkpxeGFndTQvQ2FtV3lNNFNjSmhtSG82RlZ2SXMr?=
 =?utf-8?B?N0M3UkJwZ3dnajBNektQRDd1RlJOT0RIK1kxRFh4dWQrWnpVdUhlckhVbDFO?=
 =?utf-8?B?OXdTTUc5dFFSLzlTNXJxc0ZMOXVxZFBFZTdTRit0QUFJQ2xHUURtSW5VWStS?=
 =?utf-8?B?SDg1Tk5VOS9CVjZQNHZxVlF4WkJMZ2dCaS8xRENyaGpCNkl1SDh4TFREQmNl?=
 =?utf-8?B?RVhzaVF1b2FZdFFmc0Vkdk1wdEMrNFlqbDlZMW1JN0xaZk9qaHI0c0RHanlE?=
 =?utf-8?B?WDR6aEJZQWk1TWVaQnJSYSs4YytSRjZMUnp5SjRaS3ZldElrL1YxZll3b0g3?=
 =?utf-8?Q?NepRru6/guloIizJEdHPReXh9?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffe2fd3-beb9-4cb8-584a-08dbc8ca27eb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 13:17:58.3458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oo7P3DTre07oTBjp+Qq5WdP6xJ7iw6KXXkKPQq2wnEGoEixtMBYfzXWzI75JvSWbrlJB4NzpsTU2GSAMNK0BkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB9302
X-Proofpoint-GUID: k3Izc2Vf6YtX8-JyrlqwfmM2llIRUKdT
X-Proofpoint-ORIG-GUID: k3Izc2Vf6YtX8-JyrlqwfmM2llIRUKdT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_11,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--------------d0BitAF6b7JW51tqgjLjAYNs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/4/2023 8:55 PM, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> modify multifd tcp common test to incorporate the new QAPI
>> syntax defined.
>>
>> Suggested-by: Aravind Retnakaran<aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
>> ---
>>   tests/qtest/migration-test.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 46f1c275a2..246cab6451 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -2205,7 +2205,12 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
>>   
>>       /* Start incoming migration from the 1st socket */
>>       qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
>> -                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
>> +                             "  'arguments': { "
>> +                             "      'channels': [ { 'channeltype': 'main',"
> channel-type
Ack.
>
>> +                             "      'addr': { 'transport': 'socket',"
>> +                             "                'type': 'inet',"
>> +                             "                'host': '127.0.0.1',"
>> +                             "                'port': '0' } } ] } }");
>>   
>>       return NULL;
>>   }
Regards,
Het Gala
--------------d0BitAF6b7JW51tqgjLjAYNs
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/4/2023 8:55 PM, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:878r8ipfy1.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">modify multifd tcp common test to incorporate the new QAPI
syntax defined.

Suggested-by: Aravind Retnakaran <a class="moz-txt-link-rfc2396E" href="mailto:aravind.retnakaran@nutanix.com">&lt;aravind.retnakaran@nutanix.com&gt;</a>
Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Reviewed-by: Daniel P. Berrangé <a class="moz-txt-link-rfc2396E" href="mailto:berrange@redhat.com">&lt;berrange@redhat.com&gt;</a>
---
 tests/qtest/migration-test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 46f1c275a2..246cab6451 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2205,7 +2205,12 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
 
     /* Start incoming migration from the 1st socket */
     qtest_qmp_assert_success(to, &quot;{ 'execute': 'migrate-incoming',&quot;
-                             &quot;  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}&quot;);
+                             &quot;  'arguments': { &quot;
+                             &quot;      'channels': [ { 'channeltype': 'main',&quot;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
channel-type</pre>
    </blockquote>
    Ack.<br>
    <blockquote type="cite" cite="mid:878r8ipfy1.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+                             &quot;      'addr': { 'transport': 'socket',&quot;
+                             &quot;                'type': 'inet',&quot;
+                             &quot;                'host': '127.0.0.1',&quot;
+                             &quot;                'port': '0' } } ] } }&quot;);
 
     return NULL;
 }</pre>
      </blockquote>
    </blockquote>
    Regards,<br>
    Het Gala<span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------d0BitAF6b7JW51tqgjLjAYNs--

