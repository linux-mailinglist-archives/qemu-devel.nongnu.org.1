Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0760972D939
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 07:31:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8wb0-0006IC-Sb; Tue, 13 Jun 2023 01:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q8wai-0006GE-KG
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 01:29:21 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q8waf-0002Ll-LH
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 01:29:16 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35D2d4kk009115; Mon, 12 Jun 2023 22:29:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=zvP9wuUtra/3OpNjcvdIcsrp7ne0J6vVoZxLOAm0AbY=;
 b=UEdsbqEcivnxaBHzd+hjSuo8mim07Lm8vQLgbg47PQ9AUQpQpoT1XJVocgFi2Y+RrCz8
 4DOfnzd8/Qus1y19HENuJzD6glGfEYuZpiR2+eEwbezeN5ltYyu4mwWNsDeams11f0Qw
 GbxK6uN7q3i9aYPUO+GEMBTJ9vdK0s8ZlLxLepVmi0EFB2Tb87jUg3TwNCULapLUjFiv
 r2qmNxWjA91DcWWUPAM6GV5CQwtLyBawlk6k3XV/YmyvOy4AOnH/kbGpKwF/E/yv0Ypc
 +qFIZruUw4ZNh3qlQLOyXLcdD0eturGJ53ybKTZblPuy8YTsRTt1OBrgIabhveE2ovBP mQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3r4rgd4qr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jun 2023 22:29:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYv5QLPyjkb/KyV8UmpcMFBEvhZr2a6IdO27J4OeEV061kbOMqTn6XcxZLa0wJnc+FJQqopEdKo3gCbkSXKhSydtos5yljih2zmoUns8/Zzp+5hEYRNVlFE3pdUKyvvI5Z/qvVc/UkLlAlUCPpRQUsl265B4rWU/LpUgdjBYJLKZ9W6huUgnXOOZkU1qXCq8Gt3Imjf8fyDISfXctS4K5s09a0PxYUiAIp9BfopLzPNQ5NAfr8UAkbAJ6C2nLHkdz5I65p3dAPTuKvI2lQWoTNtPRF2k2bf5SdAvDFrcaR2znk8hFDCoNA1xdBbkRaKl7u4LXtIC0c6Et664hsCA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvP9wuUtra/3OpNjcvdIcsrp7ne0J6vVoZxLOAm0AbY=;
 b=PueEhQb3yDuELOgCTW0+BcbAy9PXzh0uG+WCjhkQl4cwdc0IqoOAKxiXLjraygdAhro16qElX4rLgTS+YyvKztn7NY1mdMbFg8SJpVTJCl1GRwLgLZPjd1gJWlKMmP6OYuQeDr7DfLCdNSO+gKbsuxv8wfXMeSP+qfuVxu2W5txCjmUZtbpzipkxzclM5vtUCZj4k4c4a+tQOJNEMTXYFCJuYlEXWMzPkjiWjrHFIZcXTODHE3dFsN8WI9hk8ewK6nRHUa+WpR4Mq6gq6XdSspM1Fp2weQAFiixabYil46mK8hnZ5sJEvDP7pnfhi9BGSHg5waUo0D4wLCL++Kou7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvP9wuUtra/3OpNjcvdIcsrp7ne0J6vVoZxLOAm0AbY=;
 b=u0OsMORuAcw0qpT/SuCaGS42x1jZIbNtWlnzWEdPPzwMycY+vNhfNNhtocDgmeSLdc6sqGMCxLvmhNMZDfk7kSWR7nImr0s5O4XdKNGa35o2Chio7u13RfxLMPfNSj2Sqk7SG5qJvDKgGvf0s0Eg1HhuK4WON6ee9iZsL3Tb4Pi4GAc52VADeDKwOOom1YO/1FmeY8+viJdElZojWgGA8J9a02cknpt/EVQDmcUiEIjURHjidZHevb4RW3jOGM36/R++sWaOsG7DjxwKmdQRJCdv/iEgdBiTx8R+LWoDcI3+sr2GbMQa6m2h/lFtXJ9i15l382mbRRpyXLs87eSoiQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SJ0PR02MB7471.namprd02.prod.outlook.com (2603:10b6:a03:296::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 05:29:04 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 05:29:04 +0000
Message-ID: <119c9352-e93f-cb77-f2b0-935d808b0f1e@nutanix.com>
Date: Tue, 13 Jun 2023 10:58:49 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v6 1/9] migration: introduced 'MigrateAddress' in QAPI for
 migration wire protocol.
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230606101557.202060-1-het.gala@nutanix.com>
 <20230606101557.202060-2-het.gala@nutanix.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20230606101557.202060-2-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::18) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|SJ0PR02MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 8acce16f-7d63-4093-0b6b-08db6bcf1977
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EySdyqt7KIr/X9EiWLwzJh7PTBq4hMwTVtNWmhxvCc0ixQcXKK7JpYKfzvzd6Xi64anWO6UUG2iHOeT762EsQA4+thACnmmeikHIvI/r0fcCHtMktElWoY1rc4W2i4uJFJccyhEcdnI3faYmzWgyd5BSmlsCs+j8vSZiIDf+ZXPp/L/G0d09VQ/LzWLw00LnEeC7ZgG2E8/F6qC3dDADojj8UFSZQ9e+MI2+CmkdtQKtdFuMdISYPG426UOHiZxFRgZsPV7v4ndByj3krLVRwFPqfB8LVgAUp1hqavIEJO+0K1yr5J5MiR9MPC19X4+u9xsoJjeaQPSi72j334GQmnbA23V0loqE0aztR9Yo4sHcPVr5Dfy3OyZ3dxmnWe1/FSf/GhUEaKDlkMb9cEFmzaiLQXMFRqDNtkRigd7ZzlG4NDH10XP6WqnOuIHTFpxx2qVuGipxyS47t4jlTc4owgXXhwyuk2m9fYfTpE4HAXtK5KbpDnkK2tmtS1U3GMS+75lHAPgKUXx973SNh5kf1fl6DSwh0RDO8ko27NGR6aVaINtroKcdt0yG1kgP2sRvYM12L5NBFWGt0AWiZc7Yngoge3H8qq2kgxbxzLLT1U8dLn/W/GnI1LtRTfDsVukefnZwLWGklRIJvOfJRmT+Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(31696002)(36756003)(86362001)(66556008)(478600001)(6916009)(4326008)(66946007)(66476007)(6666004)(316002)(107886003)(6486002)(5660300002)(44832011)(2906002)(8936002)(8676002)(41300700001)(38100700002)(2616005)(26005)(53546011)(6512007)(186003)(83380400001)(6506007)(66899021)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUJ5V2N2WUJySnZNZC9HU0EzTTByOTdwdTRycEYybU0rNllQc3VqZmhEN0x3?=
 =?utf-8?B?ZDkzSlhCVnBoL2ZwUjVsWXlyaEdqQzFIWHR0cDJ2aWhNUFlNdHozd3dhN0k2?=
 =?utf-8?B?S2VVTjlTMDhYTEV3b0gwODB0dmFwVjI0ZnpYQ0RtckdsRlVDK0dCaHFTRDZz?=
 =?utf-8?B?bnFzREhsY1l5WkJDMzNZbkp3dks1V0ZIWTRNOFpYYkZaY0JNbE1TbTltek5h?=
 =?utf-8?B?Z1BmQURDdEJpWU1DTHNNOFNpSUllcDA4S0JwR3hkVndrNXlUUW5jaGRBeDlX?=
 =?utf-8?B?dVA2QTlMWFpTclUvVkVIOTR2RnBwS0k5cmtVN3Y3WXptcmxETWR5Q0FGaWJI?=
 =?utf-8?B?dytSdnh4ZjhLQ1h3ZnZCcDV5S0tTUkZZWHpiMVBhaDUxNktRano1bFRPNEZv?=
 =?utf-8?B?R1FGZTZMcVk1cmlTOHp5TTRKWm40Q1hqTzFWVS8zZmVsaE1TOGNpU2E5Nloy?=
 =?utf-8?B?N0JBTGJ2R3d3VXhpOUNrTW1Qd3VXU2tOVEVSNHZGT2owYnphVXBMeSt2dmxN?=
 =?utf-8?B?RzN4bENEQjdDS1JYbXRsM2ZKUHVCd1NvZjd2bEp4d0c0Q1QzOUhVVzI4bFY1?=
 =?utf-8?B?U0tWZVorVklPaXQvYVdYdzZSUmRScEpvUDNmWXF0UzZKWjF1di84VWdISXJX?=
 =?utf-8?B?UTluOGU2M0ZOLzM2MlVDVkdtbkU2azUxeVAzRkhlNmROVnU0aTVxUGxLc3Jw?=
 =?utf-8?B?NmFyUHFjbFZlUVdqOXlOdjFXSm5rTE8rYksxUjFIWXN4UVVVUStGTU1hb3Ns?=
 =?utf-8?B?MmtySk45RVFwdklRdXZiWnNscVY0WTFZdnQ5V1FmcWpWOFBYMnZYRVJXVE4x?=
 =?utf-8?B?d3k0WDZLc2Nta2Y0azlzYmxxelFOYnM4bUtQdGpOOG1kNHZ2T0J1NzlTQXZy?=
 =?utf-8?B?emRVQUFXTDlQL1hQaGlTdGVxVElkUDdSVUlPU0hFRHh4SWRud2pBQTRJV0hD?=
 =?utf-8?B?ZXluTkljSmxsbWlpNloxOTZyUnNLVmM2d2ZpVXJrSmRoSVNDdjdtakxGNEoz?=
 =?utf-8?B?Z3JHS0hLcHRsRDVjeFVQNmR0Y0ZRaks0b21QZW1qMEhxN1hRREMvQUg5cHF4?=
 =?utf-8?B?NldXMXVRTE1FejYrWHFkbUVvaVdjQ1JyclRNY3Z4RW5PY1duTWN5b0grTENJ?=
 =?utf-8?B?amNuUm5BMHpMd0FZNmV6cXVIeS9NdUFWalJsemVaRFU4MndpNlB0RXNFYzd5?=
 =?utf-8?B?VHRMMnNCYWNEWk9IUmVVWS9URXV2MXFQY3FNaUtpb2RPMWNVRnR1YVlwQkdF?=
 =?utf-8?B?OU9sbGQyb3hDckp1TzA2UkN6THpWYk5Da3NpNi9uMERJVGtKWG5EVkZJWjNj?=
 =?utf-8?B?NzBHU3lxQkZwUkZ3MEcvSGJWVm9MV2tzTmU2NUVLZWpEWWFoaDdnaUdJYjV0?=
 =?utf-8?B?dkd2dzVMZGdOczZiQ2UyUjR5SExKT25LdzZmcTZqK0p0RmVkeDZzQkh4TW8z?=
 =?utf-8?B?RjMwVEUxN25keS9SQVBLSHRTbDlYMGJRS3BTMnFuUmdwb0lYb2x5N25LUHpI?=
 =?utf-8?B?REN4ZjRnTHNvMUpEbTdLRFJjbFFFaFppRDdHTUloUXhvYzN5L3dCTDFhamRy?=
 =?utf-8?B?MHNIUUZmZjJqc29BZ2YrSkREY1JmNVBtem1UVGV4WEQ4WWtKOE5MUkpFTC9M?=
 =?utf-8?B?c1czMmIrMUhGMmJFeTBoQ2x0bEUya1I3LzBhUm9XbW4wU3dPbTVOS1NjMkFw?=
 =?utf-8?B?bTVDZTVvTUk1SE8yWW1SRmRiY1UrcEFWbFJlUjVEaU9qVHVIQXRyNFYzSms2?=
 =?utf-8?B?NXFaNGEyQWFyY0p1MjVFZXVsaE9TRGFFRFpQZjRKb0QrVlh4LzB4aExDdTdD?=
 =?utf-8?B?RFMweEVsdHZ1b0dyOE9La0Q2QXBIZDZWYXZPWVVVVjNPeWltQ2RlTGtkU3dv?=
 =?utf-8?B?VWx1ZWx1c0xmLzBEa3NvZldkd2p0NFM4TnlmYWZsTzl0cDFrcGxod0tQWEx6?=
 =?utf-8?B?QlorVVdmMmdZRjNoRGNnTk1iSEFmTFpqdlJ1WU1rMWZEa1FlN0lwVkpqWTRl?=
 =?utf-8?B?QUppVnlrNVo3dHpzQ2l6Q0dqZ2luVktnMmhpeEs2VmdDbU0wMndXUWxlckZJ?=
 =?utf-8?B?T2JGOWZ3VXo0TUN4NzZMcWh1SmloT0JGV1BHTDE5RUZVVnpvRXVWTTZkQWxh?=
 =?utf-8?Q?6LDXIEC/MaME3+asmtXyWl5CS?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acce16f-7d63-4093-0b6b-08db6bcf1977
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 05:29:03.7358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehHh6l8ei857gcnMLc3sGDj+J2gH/cUMggCS53ArzZwMZr0AnHkpR91uSJtYKn6fvHIKa9vyCwxWRzF1QYYrzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7471
X-Proofpoint-GUID: fUwmY3QL0m9af4vSdJArPQhOXquWyYqB
X-Proofpoint-ORIG-GUID: fUwmY3QL0m9af4vSdJArPQhOXquWyYqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_02,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 06/06/23 3:45 pm, Het Gala wrote:
> This patch introduces well defined MigrateAddress struct and its related
> child objects.
>
> The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri'
> is of string type. The current migration flow follows double encoding
> scheme for  fetching migration parameters such as 'uri' and this is
> not an ideal design.
>
> Motive for intoducing struct level design is to prevent double encoding
> of QAPI arguments, as Qemu should be able to directly use the QAPI
> arguments without any level of encoding.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qapi/migration.json | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 179af0c4d8..e61d25eba2 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1407,6 +1407,51 @@
>   ##
>   { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
>   
> +##
> +# @MigrationAddressType:
> +#
> +# The migration stream transport mechanisms.
> +#
> +# @socket: Migrate via socket.
> +#
> +# @exec: Direct the migration stream to another process.
> +#
> +# @rdma: Migrate via RDMA.
> +#
> +# Since 8.1
> +##
> +{ 'enum': 'MigrationAddressType',
> +  'data': ['socket', 'exec', 'rdma'] }
> +
> +##
> +# @MigrationExecCommand:
> +#
> +# @args: list of commands for migraton stream execution to a file.
> +#
> +# Notes:
> +#
> +# 1. @args[0] needs to be the path to the new program.
> +#
> +# Since 8.1
> +##
> +{ 'struct': 'MigrationExecCommand',
> +  'data': {'args': [ 'str' ] } }
> +
> +##
> +# @MigrationAddress:
> +#
> +# Migration endpoint configuration.
> +#
> +# Since 8.1
> +##
> +{ 'union': 'MigrationAddress',
> +  'base': { 'transport' : 'MigrationAddressType'},
> +  'discriminator': 'transport',
> +  'data': {
> +    'socket': 'SocketAddress',
> +    'exec': 'MigrationExecCommand',
> +    'rdma': 'InetSocketAddress' } }
> +
>   ##
>   # @migrate:
>   #

Hi maintainers, this is just a reminder mail for v6 patchset for 
modification the QAPI design for migration qapis - 'migrate' and 
'incoming-migrate'. From the last discussion, I have modified 
definitions specifically around QAPIs in patch 1 and 6, and have tried 
to make it short and consice and meaningful. Please have a look at it 
and suggest if any changes required. Tagging maintainers who have 
actively participated in the discussion in last few iterations : Markus, 
Daniel, Eric, Juan - but regardless other maintainers are also very well 
welcomed to share their opinions.

Regards,
Het Gala

