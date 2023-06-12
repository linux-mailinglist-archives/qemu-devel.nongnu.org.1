Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB2D72B6DA
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 06:52:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8ZWA-00032s-Ng; Mon, 12 Jun 2023 00:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1q8ZW8-00032c-KR
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 00:51:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1q8ZW6-0000pi-D1
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 00:51:00 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35BLSA4u008856; Sun, 11 Jun 2023 21:50:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=PVc3x/Yq5laaclGPPPtLX6eY8ARerVYdcE33yxx8iyI=;
 b=Bs+6J2rte3qTle/iQQUd5k5QpHSqaWVwVEVibym36PpD8yr48OnUbyTAxO0cwi/GM4z+
 69Puqt/JjzIcrii7879rSuzqB40Z5BdQsOHYipSGsyFNV+qSfDD2nn/zlvS+UEKvRN/z
 ljiYMmVSoYnolwkC1H1ooiwV2T3mndY4pDGpOvxdiqY09y33e3LMP/XQ14OCSWQX/teT
 rzt5eJm8XyBYIUI/BPN1pUfWwCCdjwV78D4P/FvPUcE0rOJllgOW933a44GjtL2BbeJv
 utoeeBhuE8XmhQov+GNLuST/VJP4JyeW+mpI6qnyERPU0XWtvG32ewsynrdP9ukw5R3h RA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3r4rgd282b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 11 Jun 2023 21:50:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isP2ZOYSTXTVpovXHobKhR1UBythW2r6XiAL4JCHLhQlEBprELNVorUFssCaJr+MRPKlO1KBH8+E8kEoWQafMXg/va8mkD0c/NmEutATc3KwqmYA6syAjZQWCmlqKDhDZ7WdST/930fdmD55ueW4C69s9VLVvyj8DZJ9AhDRwaSxHtQ6JN8sLPKuw4OZiUDGiKYtDT0Bb3o/d+mLHss8Lb76iZJHArsMHfg7f/DWZvdaZFAyhvOJ4+0SLzyJ6PrznTHb+2I5Vko2jsXKEc5/yYeK2lSh4ZePfOwpeOgMQ3waai3q0vg65I7bMD9MdHqZ7rciiFAXLpIvG7BFQu8/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVc3x/Yq5laaclGPPPtLX6eY8ARerVYdcE33yxx8iyI=;
 b=mo0ucz5clnWYBKKBYnTZb89AbL51I6LrN5xzcOzmeF4M/9inOayaDTGeyuoeQpzVd8r1v3pETN6IFfugCi/kWDYl6A4VwIrnWUsX1DalRDkp2VjVJeka+B/e081nj4fPl0kQq/df5aazVyQbuESorT3SRTp2jbqUEVGmWapU5aLoXYIhJw7tHC16GaxDlME5SUIIdKQ26LCMtAE1/LpVofdQeZqS2TC+ICuvmso0UkXna5ZoICC6pjFAFp0Ib+FzrSvAlXGWaBdCgRYyQEKkdF7l6AefDUbP4fKzs70xuRqd4aNqPgf/kkzZrcC8V9LO5mI08Z9xvR0vlJUSRT4uXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVc3x/Yq5laaclGPPPtLX6eY8ARerVYdcE33yxx8iyI=;
 b=ysKwTLCDnDyCxPiREOjq/gDgSiDDTJo/M1NWpIHkVhIp5fbOKKQjPoifk41OHFgEDr1b+rd9mnbThSyQl8vYOPQmmWnazoZ5OTSAU3jdnBkVGE5daYsxRT8Ow3EnMP9g/GePkAgDGnvzzTBHXnfREY0EpGdm0EgS1L+3mpDJXiuCJBylnOf2BRq8jrov+vh8XyuP4C+CFSuU1qfX5GaRYKBQuyQ55QtgEXPPcz/qGxVYTLUPIwNAViQO/xFqhUW3upHZ4iCErR6D2ICUNy0iyh6Yn7Bb5Cxv650Slo1dxiF1G+YavOjTKZQkerslZ+eAz9C8gvGJlmdiO5q9RDXdCQ==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by IA1PR02MB8897.namprd02.prod.outlook.com (2603:10b6:208:38b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Mon, 12 Jun
 2023 04:50:52 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7%6]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 04:50:52 +0000
Message-ID: <476feab2-63e4-1d26-ea8c-6a7f7418b3f2@nutanix.com>
Date: Mon, 12 Jun 2023 10:20:38 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 0/2] migration: Update error description whenever
 migration fails
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: peterx@redhat.com, leobras@redhat.com, berrange@redhat.com
References: <20230523124638.16270-1-tejus.gk@nutanix.com>
Content-Language: en-US
From: Tejus GK <tejus.gk@nutanix.com>
In-Reply-To: <20230523124638.16270-1-tejus.gk@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::16) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|IA1PR02MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: bd103c74-cb66-4510-c59f-08db6b009942
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omfieBrJCUQzHzes74xb2XVEpMO2VWh8tyK852KAc777q4wATvOTZEniq7IwY77sIMdGzBfycQHSybG3iD/7gMJaAH9MxrgSGy4MnEdjMi7bE5Asz1nXQ6Vey3cWlXpH2mzHhaheqxQpaPSnOTtIfj0rw9DTtPNsxZTo8Q0z3jFIwwZ3fflxQmdnFRr+8ZgAvzNpHMU+demK+MurIexit4LVuCm5fgb0JBZypFnuEIZ/8vdamgyaSG/sVjfVXqgpWh6Gr9m3NGbpiodsajdL2xmp6lFGe/Gi7afq6X1VGCSmMdLqwAR8UFVXABzDfu7nUmlWu2nHmllUbyh8wmkR3pdjZpgM1sHgiKcxhJEC55M78Bu2J6SaWZ11LQ13DbXPMi3RbYgwcX7RC22W38HnvyyEmRTDdW8OU9EABX5nT9m2FCADapZ9mzGOIHJ9v3RCjN89EfS06dxLPSHQVFPyWVQCiU9n8C2TEUr/rGGOz13WVnRz6/SC+JtSanHfT7eOVGl5lMP5ivHYtsCgrly7PsWFYFl+t8LfkPLZuQOe8KlN4WQH5N/vmDWbYcWk4GIPXu5mKCfin34NErdksKDgH3u4MDP2FS19OGfI6uCGSemaQ+gfPwndxLLl7td0/MuDgRLcIjt+M7/AYsicaiu6T9Xh/eF0LCvUM1UyxHWNHTxvNsS3rn0pFuzBoFRxv5thR1i35m7ztjjJRrmg7ZiBAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(478600001)(38100700002)(66946007)(36756003)(6666004)(4326008)(66556008)(66476007)(31696002)(86362001)(38350700002)(6486002)(316002)(2906002)(2616005)(15650500001)(186003)(41300700001)(8936002)(966005)(31686004)(8676002)(6506007)(6512007)(53546011)(5660300002)(83380400001)(52116002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW9iMW5XN2FHc2NpTzYxeG05NFF3TXUwL09ueXVSODRjZzNGV2Z5MnF2dnM0?=
 =?utf-8?B?R0VnTDBOUVBFZlk1NjlUYTNXeWhsZklGU3RIcXhxYytheWk0a0YwWm54NkEw?=
 =?utf-8?B?ZmxPMTVmZFBLOVhEaUV6dm1hWkRTakhEVStlYndNVHNPRGZrZHRUQkVmZ0o0?=
 =?utf-8?B?TUxhMTkzUHU3emVuMnRlU291US9NUlp1WUk3bzMxWWFHMk5nVjdTTS83UmJy?=
 =?utf-8?B?dUxMYzNCa0EzR1ZhR2RudzRFWTh0U3lKcW1NRWdIdjZlMk1LeDhrN1M5MVoz?=
 =?utf-8?B?RmVzRVBldVJrazcwTEpVRDBEN0s0cEhab2JydzVORGUxWm95NW5tYlVhRENX?=
 =?utf-8?B?ZVB6eXY3NXdlQUdWVmZnOTB6WVVLbEdocWtYWVYrMEdtNE5FOEVmWWdvK1Fr?=
 =?utf-8?B?V1pVU1ViNXJLMFZzdlh0MnlpcjNtM0dhYm5ERzN5U0NyN2lvWlRTTDFHU0c1?=
 =?utf-8?B?d3NYMnQ5RDJJbk5raWJibkt6LzJsWitZVVlKaGVzTmdCNzRFcmRxUGo3U1lw?=
 =?utf-8?B?YVhXTDRYWUJxM3VXTmF4SDk4Q1YyUXhybTVXZ3o2MGMwMG0rQjgzSCtaMm16?=
 =?utf-8?B?SzBZNStlVVJQTHVaZ3EvV1NRdVVBckRVaEZnd2IyTnlzaG16ckNoTkcrMnFh?=
 =?utf-8?B?SVRyWG5QWjZYRGltSy85WUk5MTBQTnUwZHZxOGc1clJMZkRPMEZuYXAyY0s0?=
 =?utf-8?B?TzA2SzZ6aEFuSER4UmVuampweDdRNGY4SHRFck9WTXh4STlhS202dUdiZXV6?=
 =?utf-8?B?REhQK2N0QWluVjdLSTVTN1Nod3JFMXJFNkNNb2poaEVQTFB2Qkc2bm5JakFk?=
 =?utf-8?B?U2x4bnExUGIwcWdCV1dQdEp5YitJcERUZVU3RHkrV1pLWG9TWk52TFFObXNj?=
 =?utf-8?B?ZkhxSkdTMmRaTk4zL3hTVm5FRlhGTU9qYk5OcEdWd0hEbE9aM1N4eXhuZlJG?=
 =?utf-8?B?Y3U2M2tOaWpMSTgyR3BsNWpRZ0hONTErZUp0NE0vSFpoZ1FTNis0ZWl3NGhF?=
 =?utf-8?B?M29oQUwrWU0wMzZlME9XTUs4TkphQ0EwZnhCelZMcXVLODhmZjJweWJpbXpP?=
 =?utf-8?B?eE1MR1NuRzFlNmNTTmJ1d1NIS3pCMXpPL0xIM0hwL0RjWDc0N2c3Slo1WWdu?=
 =?utf-8?B?dHZWa1JFM2pDb1VjL1drV3o2K2M0TlpCbTJQTFBOekcxNlg1elZ6aUU3TXVI?=
 =?utf-8?B?N1Q2UDdHa0VUd3FxeEFZb3cwdUhZUk9iQ1BEU3FDeEVORTJkNXhXbHRMUk53?=
 =?utf-8?B?cjdINXJ0QjQ4akp0MHZ0UWFKa3Q3SmlxR2hjcENQVlRDQUlnZmY5M1dicnZq?=
 =?utf-8?B?ZEF1MEU1UUFVMG1tWWtUa2t1NlpyRnNuendXTm5wdEhXdnd2U20rck9tMWV0?=
 =?utf-8?B?L2ovZTA3RW1PejVHb2JmdmdRVmZQNGo5WEUxMS9iMGtMVFR1UlFqeTdNeTdO?=
 =?utf-8?B?b0FJdVpuclFSQ29YQUZyT0ovY0Q4QTVhL0o4RG03TW5xaDcrYkpHdWJXVTlK?=
 =?utf-8?B?ZEl0WU1BNzZUaDNvQVhuY2dkc0RMcFg1SWl2d282czQ4ak96TUpoYzEvcnlk?=
 =?utf-8?B?djNnSDVYQWdTOGdTZ2xBZ3d1emh3YjVmZ0hpbTN5V0U3V25PSDhZUWVRN2Vx?=
 =?utf-8?B?QklkT3NrcUNORURWL0hKYmRCK2VqUGo5QkFHYkZYZHNsb2F1TFF1czM3L2dJ?=
 =?utf-8?B?MTJMTERQWmwrU3lVU1ZGc0EzVzg2dXhVeHhmNmwzdU5ETTVzS1VwRnVUZnpw?=
 =?utf-8?B?cjdjYkN5dnV6MHhVdWxSOHlhcHFUYUU3dlNtbkU5YXl6WEE2Y0xwMXcrNWVI?=
 =?utf-8?B?UmF4cnVhYnlBaElRQnhBWDB1dDFZVm5CWGt1dWZUbE1ZQUxWcVJpZ0JNcXNR?=
 =?utf-8?B?STlIVHJhU3VzVHY4Q0E1bGNDTk1MZjhSUEpkV0VpUGdLK0kySGtTdkxqM2lq?=
 =?utf-8?B?UEYzV2cyeWgzclg5QXVKWDNHYUgrb3o0VUZGbWU1MmNUOHlGT3R1NEVzNkVs?=
 =?utf-8?B?WjhmeWlBKzQ5S1hldWNpRkFFZzhBRHFKMG13ak42dEhRQU9GSGRtTldaK1Vm?=
 =?utf-8?B?QjZGVVg4c1FhQzRVZnlEQXpPSkhMdld3SllGQjJad0RTNW52U2ZoZEVNUFhB?=
 =?utf-8?Q?rMz7MWaCSVntNoL1rZm3Zlxjk?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd103c74-cb66-4510-c59f-08db6b009942
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 04:50:51.9998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzS7czjlmx1qGgXYJs9OU64jmfCe+2FvYiJ4MUhBLGJ2Nk6N3PGYq2/Uc0JWmKeWEfaksbR8pCANI4TFPwQN4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB8897
X-Proofpoint-GUID: IDjGILSy2stB0mw28gBN-Ci22TcoJCBY
X-Proofpoint-ORIG-GUID: IDjGILSy2stB0mw28gBN-Ci22TcoJCBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_02,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23/05/23 6:16 pm, Tejus GK wrote:
> Hi everyone, 
> 
> Thank you for the reviews, this is the v4 patchset based on the reviews
> received on the previous ones.
> 
> Links to the previous patchsets:
> v1: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg00868.html
> v2: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg01943.html
> v3: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04463.html
> 
> I've broken down this patchset into two	parts, the first, which updates
> the error description in migration.c, and the second which refactors a
> repeated call of yank_unregister_instance(). I've also added the 
> reviewed-by as asked. 
> 
> A thing	to note	here, in the patchset previously sent, the second patch	
> which handled the updation of error descriptions outside of migration.c,
> was breaking a unit-test and hence breaking the build. I've removed that 
> patch here and will  be sending that out as part of a different 
> patchset.
> 
> Regards, 
> Tejus
> 
> 
> Tejus GK (2):
>   migration: Update error description whenever migration fails
>   migration: Refactor repeated call of yank_unregister_instance
> 
>  migration/migration.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
Hi Juan, 

Can this be queued for merge, as the patches have already been reviewed? If they require any further changes, please do let me know. 

Regards,
Tejus

