Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2DE804BB9
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 09:04:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAQPe-0000gp-T7; Tue, 05 Dec 2023 03:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rAQPZ-0000gW-JZ
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 03:04:09 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rAQPS-0001VJ-Aa
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 03:04:08 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3B561Tjt009679; Tue, 5 Dec 2023 00:03:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=QZsffV/QlMiJ
 HEqwAo3HR9Hw8ro5HAQT4F4nbKfqzO4=; b=n9diKl4NmtbQQpyi4TKSpUt+1P9u
 HREjJPuofF2gs+Y8e521EI0sJBEnaxFNgHlsILjyWcKLKZ4MFsL6kbnzevIu0Gsh
 e1nTcd9S4fCA5joycCQ84yjRTZEOs4xf0knMILZR/d/gycieSK1DhuMRp+nDy19K
 ceHcnJGpy6ic5mw2QDL5riZyZVZEY/i+bc424nFato9pqxBadUp5kCe3CUxLUeKA
 j/aJJlGllJIH9AQFiuJBAVHRP42jOTw3pgpsFHDeDUDdw+4AY87KYdokRlIpKpUS
 KMAOsEU5ju9jIDJRN7l9ArVTGnVzYn4QHr4dYc5AE66pK/NRP44KKKeK7g==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3ur4hgmw5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Dec 2023 00:03:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VH1FrxaBLyvrDNbq1Cmv8m4jS1vZoSdMngEfEes6jmHZjy4Vli03ZPyLSJ2Ag4Mwfl3WxzQUrpx4HT6TQXWfhAsyXUWbrF65Yk68v1ZBH97qaMhMn2Aq3ebWTkn94p02/WGumHM+t/sF0QR3DcdMMQ+5EaK7MYF1LLyFO4+gAXEa4khdphRH0nh/yc+UjsqXYGFLD3aJpiYDJFRu+zGqvouPZumx8XdkKOXtLUltLyKc89W4P5F3c1x02GZlruEC60i8iwvwplu5jQBZBdYRhn9600vAiaNxK31XEXLxutFPIUmMFo6dd3k3G1oeIeJgDNuW2I0K1lEeDeQoqFjPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZsffV/QlMiJHEqwAo3HR9Hw8ro5HAQT4F4nbKfqzO4=;
 b=S6dLq/X0BX1tSM4nm+toTB6ZyeXxxskBGR0K9aMAPNU/C8oddKfo+Vnww73ZdMnUwzsFscGD5EmUOuztBemd/bkmtWdq6avKvOebhQwQEEkZm03KmK35jv5VFPnAuHqg1NxvDy1+m5Qe7Ino8o3UMmFvVSE33/TKaPp/2rt3YD8pF/VWLPOhdO2+ZRWMDwgUC9i0wwDL1fCgoeYNurHFYZiHQNHik66Sefqy/JX6lzCSwssAY9Q3kjtqWt+ditT22Kv9qzuWxM+fNqvjhdYBDZlVAevdygjQ1uTCs8t4hQV+o9mArVr+IXKYdkFJnlhF2Bmo1FI8F+Kk9rd3M9C50w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZsffV/QlMiJHEqwAo3HR9Hw8ro5HAQT4F4nbKfqzO4=;
 b=QmIBvA6liGdpGnd1U0nDgO4E9ykZRYLH4niR83G+7hHqaenc9SeDC8HBQfY2Nv/Al9T8cWj/OAGqTtioRBzV7Te4AoYkURVPONAfDUa1xnEacAdsWHzQn0qjE231WiXsTLsaNlHxQePv8pgJvWk2TF9IXm3DpN3HWMWJvhy34xMkFI76I79q9pM4couZ+KLsnXhM7BakJyQcv2Ot/1tw0PcwAIhA45+IIpR2WbiKcgp05fEbYWM2KPZtDDGhvGgQMAVJqQa4SH43Gy4fB+loqf12//379uvGrYAaUMJY2wkx08O2c0kJEzgLnN4KBBPvlEpSWJbYyDslj0gkCQivhg==
Received: from PH7PR02MB9944.namprd02.prod.outlook.com (2603:10b6:510:2f7::8)
 by BL0PR02MB6499.namprd02.prod.outlook.com (2603:10b6:208:1c5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 08:03:57 +0000
Received: from PH7PR02MB9944.namprd02.prod.outlook.com
 ([fe80::603d:1f11:4db4:cb17]) by PH7PR02MB9944.namprd02.prod.outlook.com
 ([fe80::603d:1f11:4db4:cb17%3]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 08:03:56 +0000
Content-Type: multipart/alternative;
 boundary="------------WDqUGYSfKGX5CMUtYq2nF2Ri"
Message-ID: <2cd91132-d6e4-4c98-8150-f7a0116bcf7c@nutanix.com>
Date: Tue, 5 Dec 2023 13:33:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Simplify initial conditionals in migration for
 better readability
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, farosas@suse.de, armbru@redhat.com
References: <20231205080039.197615-1-het.gala@nutanix.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20231205080039.197615-1-het.gala@nutanix.com>
X-ClientProxiedBy: MA0P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::6) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR02MB9944:EE_|BL0PR02MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: e951e287-330b-4fed-ab0e-08dbf568baae
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4AhVh+AwlrC2pAP3Q8xHIiBZVIf0JeUdn/BK13+FKhCVLTlsMdEFBDzEtPx56NBJSEPWTe//uGf8z741+rpZVrPZQJ3QyxiqfBtilCGcu8Woxrq0eD34RLrKOOfiKNJfvDzuOSzbaIIV2ZmzpXYtiBXp4IkAhcfQrSFvAvHFSISgq29NG7piPxLniZBh4T3UW+cUMSSOBhK0NFHLbBkO++nUV8iYczhTQJEiJHCCP0VZrV/D07S2ceN0fY6YmuSdEaQzCRR1ZRnzvHPUKq379Rr+EWtpc1FNEA8n1UfKbFu3ia3XdRwskYchieUGzEaNXxla+LsL5eTY2zMHoFHWK3K3aR39Ta8j1g6bdTak0gQJ3pU/vYV6HR9yY8rqToU7ebjZXWGVr9pM+0BW0SWqGRTUV5ImxLKVE2TwBF85Qb5bR9VF086SZUem7YT9Qf26z2lb6ek1Wf7yFLt/QovYJzxbTbZSGhsv8r1i/aVobVVD7nYYisX63gsMnVmkEC83CqhGzW8ebeGCwzdAU67uLnmI9H3tf1ncalqZtsARtZFi/dvtsk6viI1riyNLDrbSqDZVxK5Qj89rkxTyjeOnWs+zOtk2L3+UeCjPZdJZ5GilBXPmkDAOQ/G48IBbw9hypc/Q/FsLI6CvzbysESm8fI66Gv6L+UQZfkUZdtkQndCHP9PqKDprPnTVCRLc8YCE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR02MB9944.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39850400004)(346002)(396003)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6512007)(5660300002)(38100700002)(2906002)(44832011)(31696002)(86362001)(36756003)(166002)(41300700001)(53546011)(966005)(2616005)(26005)(6666004)(33964004)(6506007)(478600001)(6486002)(8676002)(4326008)(66946007)(66556008)(66476007)(6916009)(316002)(8936002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alR2Z1pGKzVRY1ErYnlvejVhajgzQVNOUVc4QzVMcUl5YkozN1hiQ1RLaXdG?=
 =?utf-8?B?MWlybTRCT3Z2U3hDTDN1WmtvUGQ4MVpHdWlVbVcxRlZaTlZnWWwycXN1eVlV?=
 =?utf-8?B?MU8xOGdqTys2Nkl3OFRXNFN1cjJocVVlNkdxMnlNRVAzVXBCWW5YL3oreWNP?=
 =?utf-8?B?T0ZPZVpPL3A5bkFqSEhOQTJUajJSSjlaVEJsTWxOMWFHZTdpTm1BU0cyaVd6?=
 =?utf-8?B?cTd5QlkxNEVuWGp6cWRuTzA4RUx6b0o3QTh1c0hoRUdjc2V6RUNyeklvb3E4?=
 =?utf-8?B?d2hhYVJvcVY4QmhRL2loQnRHaXR0Q3ZnMWRFZ3Raa3RXeUVSV3d0NGpBWFp3?=
 =?utf-8?B?RnpYZHFFeEpwZllvU2hkeDE3c3FEK21peGMvRWRoUFQxYWo0UmtxM2lnQmEw?=
 =?utf-8?B?Mi9OYXVGZVlHbzN2eEU4UEFreUR3OXV6UEpqSkxNUkZDNUlaMXJ4NCtNd1p2?=
 =?utf-8?B?ZkI1anpoWFMzaktsYnYrREtmblZidWpYdlJIbEplSlg3eldobGw2UFUzNFdB?=
 =?utf-8?B?SDluSGoxRHdDdXVFTzN0d0d2Qmk2ZDBvenlSdzdIYTJXSEc3WUJWTzZuWUIv?=
 =?utf-8?B?dE4xZUQ4ZHdNUUprZHhOV2JzNzVjMkNoR2g1dE9wYWovWk91WWtGRVdsLzZE?=
 =?utf-8?B?ZmJxSUE3Z3paQ2tsdnhwNEExc2tYcHA4OEpiY2JWZ05DRjg0NG56b1pGbHZM?=
 =?utf-8?B?UnFKMjk2VzVlWGJkMHR5alBhdXRrUzhBNWhEVzNZTUNYZENJM3NGUHNndFB5?=
 =?utf-8?B?SXlhZGs0NFIwN0xOR3M1QkJZbkxWai9FQXdCUnJLMitBOHJhMVo2b3NJNlJa?=
 =?utf-8?B?dWdSMU5zNEFtMmloci9OdWZ6VDkzUUY3K2owL1A2SVoyVGtERXlsVnkzcjhH?=
 =?utf-8?B?V1B0ZlZhMW1xY2VxVnJvQnhFSE41ZVlkZnVWZC9Na3BjamlDMDFIL3dtWCt2?=
 =?utf-8?B?WFRDZThhZzVZT2Y5RFgyd1F1b0hkMzJTenRMd3E1YUE3N3BqeHd4dW9YTk5w?=
 =?utf-8?B?R3ZmeDQxOFVFNHNNeEo1cGRUSFY4N2o1SXdNR2h1aTd6UjBZRit6dFBKV3RS?=
 =?utf-8?B?OXFCMVRtSzZwcmFqa3JyZlNpZmtFS3pXekZvZkxLajhpVmNwNDV5NEt3RlUr?=
 =?utf-8?B?MkxJZ0QzK2kxMk1naFM1dm1Cb25qWEVhb1pOWlEzcjFqVUNqcTNidmhZQm1h?=
 =?utf-8?B?UFJGVE9uQ0xkNWh3Q1MrL09mOFVOaCthWXhkWVBXaWNOeGdzNWN4UFl6cFdo?=
 =?utf-8?B?M05DQW42ZFQ0eHdPUE1zeTltcm91UDhMS3pZQ05VZWJSRitDTVNGdU81U0p5?=
 =?utf-8?B?MHdNODI2S1F4OHJFU3YyeW9mTVR5eXpCL2ZDU1hGV29XaXNMbUpOZXpRT09C?=
 =?utf-8?B?bmJEeGRFRVdIcHJ5bnFwSlp0a3NrREkwMVhiUnJpa0syTEEwY3Y0dEM0NVgy?=
 =?utf-8?B?YWowSVJqaGZqWkh1QzJPd1dXMVhRcHdMRWNYTXZTSnQ3Um1IdllmVUx2bGpC?=
 =?utf-8?B?Njd4cEg3QkplbXRwbjVML1VtTjRkWi80VHM1cGM1bHFndzVPTmF6Sk0rY2Fj?=
 =?utf-8?B?dzZvOWpTaXk1Wm9OeVJzb2dVU2x2bklTQTRTSjNGbHRMVy93WS9Pczk2SUxq?=
 =?utf-8?B?T0NUSk1LOWpqblZyaGI0WkRtb2tzL2U2bGI1cWhHMC93ZHFYbkRNNDY4WmI2?=
 =?utf-8?B?N1ZqMFloYmtjL3lxb2VnWXF2eHY2TjF3SGNoTkVBZTdDa0JnRW1YVVdLTHAw?=
 =?utf-8?B?Z2UvbmxoVHY1NVZNdUZ0U3Z4eURTTVA2TzFSYzdkVnNVYk44dnBKanBHYUVu?=
 =?utf-8?B?QkRRQ1MwOU5VWWh5TnJ1bnFOdGNjWWovdGh4bW5HcUlGOFJZYU1nRkF0b3R2?=
 =?utf-8?B?NXZBNjZ5UWlMbnBjYUtJMHRsSFg5TmpWclJ4RUhIQm15anpLMUxhTHdPeWdY?=
 =?utf-8?B?YXlKanpnbEpBRXdpbmxBL2xpSVFvTzhMODB5em9JZnJEMWhvRWI0NGp0YlV0?=
 =?utf-8?B?dEtRdk8vbnljMDdPdkc3M2toVEVOeVg2cVlLUEVqamxObmo5SWF1RGYweHBa?=
 =?utf-8?B?VnJRWnlFMmJBOGJieVVhVWZSSVppeVdpTUhDaVlOYjZzeFljZ2JCUllZMHNq?=
 =?utf-8?Q?btvfwX/XrKHuSuao5X1DZnhxK?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e951e287-330b-4fed-ab0e-08dbf568baae
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 08:03:56.9497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdYrvVSU5ZJJNos8UyLHhKagFYsoBzwvCzte07KLC9GpO6Av0VSgbHJFD2Tz9L44vp+R5KHUJdC6t4kZJ6+mbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6499
X-Proofpoint-GUID: 6yc8ZOKWSBLLp0ilpN_viHOTgqmgGKGn
X-Proofpoint-ORIG-GUID: 6yc8ZOKWSBLLp0ilpN_viHOTgqmgGKGn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--------------WDqUGYSfKGX5CMUtYq2nF2Ri
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 05/12/23 1:30 pm, Het Gala wrote:
> The inital conditional statements in qmp migration functions is harder
> to understand than necessary. It is better to get all errors out of
> the way in the beginning itself to have better readability and error
> handling.
>
> Signed-off-by: Het Gala<het.gala@nutanix.com>
> Suggested-by: Markus Armbruster<armbru@redhat.com>

I have also tested this patch on the Qemu CI/CD, ref :https://gitlab.com/galahet/Qemu/-/pipelines/1094304060

Regards,

Het Gala

--------------WDqUGYSfKGX5CMUtYq2nF2Ri
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 05/12/23 1:30 pm, Het Gala wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20231205080039.197615-1-het.gala@nutanix.com">
      <pre class="moz-quote-pre" wrap="">The inital conditional statements in qmp migration functions is harder
to understand than necessary. It is better to get all errors out of
the way in the beginning itself to have better readability and error
handling.

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Suggested-by: Markus Armbruster <a class="moz-txt-link-rfc2396E" href="mailto:armbru@redhat.com">&lt;armbru@redhat.com&gt;</a></pre>
    </blockquote>
    <pre>I have also tested this patch on the Qemu CI/CD, ref : <a class="moz-txt-link-freetext" href="https://gitlab.com/galahet/Qemu/-/pipelines/1094304060">https://gitlab.com/galahet/Qemu/-/pipelines/1094304060</a></pre>
    <pre>
</pre>
    <pre>Regards,</pre>
    <pre>Het Gala</pre>
  </body>
</html>

--------------WDqUGYSfKGX5CMUtYq2nF2Ri--

