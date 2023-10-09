Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A337BDF13
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:26:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpqG6-0006N9-KT; Mon, 09 Oct 2023 09:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qpqG4-0006Mn-TX
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:25:17 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qpqFz-0006D1-C8
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:25:16 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3992QesN017937; Mon, 9 Oct 2023 06:25:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=JTDx6wfNdOmA
 s33yVxDtDWRQG9YTb2KYUXo9b60OyqI=; b=tF212OijJBtTFYNbGYM4LH85DSu3
 62dd0x6Wddnw1SDjlCidVctNNr1UJUcd6NIa0NPoSMNoFGotD3ndWNXpAgkBKUB/
 FncWOP+R8y8JtpAH1v85f3nNxBjf7mcap0+59wMG9IhDXTuE8Ybt4j5TW6ri82Af
 w8VPF824VIKZStcmbbNG/AmdCaTJp8SJrumJ7YPnrnr7QBJSWFGJTngoOpwr9JMU
 O2LHR4PCzSsMkzln/j0ljffcZjWlm+RgS9is0014/EAnloq3Cc1y2spdNjw1YSRB
 gYwq9zCi7b3GVxMtWsQtvsv+kUfx9hW9R47frqGkmQwGKEqFZBIezk/SYg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhv02n17-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 06:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJxdpOYrmhXD7FIFSoLoGPM32i0M9uJ//2GminDuTQvIMJBFJ4JAm1dhDnrPxhgoJmK3+4Mu/2NI3FuECQPohv2w49N9Xv1zjyIl7RW9bNF90jNYq85ja3E2RxjBvLIZP69p5WmOjbZ8P8G/WEFVuu34Sr3Y0s9IwSbYmlGjIQd/bMT4JEfFadqSZSxqZZuoDDe9f3eRSIy257sc3BlyuptsCxwYRJrTPu6jUKaVHB3fr7LrN3TWoFZPk33MOuyHkrUC/hqGB0ywmRYazX913Dd5gdk6xtbF6hVHhg3Pn9shxYigUAPN+QyB/XqS9gv7AnYvq8R6u8vSTxA3kcmDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTDx6wfNdOmAs33yVxDtDWRQG9YTb2KYUXo9b60OyqI=;
 b=QR7/rNhN5M6RfXb7Tn6WwVhxMvtXEsuwWIXQQQdvWfqzlem31cPeH0lpDvNhz2mq83BswNG70gqME/4FW4Hkd2+K2CbvDgI6XQcQ2F33JOYsxOKAXm9063/+gvHM5XapbJF7Ht5LVoD7zEVNLOozzUN7REI7SvbHs/lOqRTXJZdwRdFSvr5ajW0OT7zKoQ4kKh+qxSNrCjVW+aYQYnkqrUjHkPzJY/KK242TAyHoGzfl8AdiQyMzv9whOttJXXgJQMO97anqxJvr///29neXRb0wKLi8VNXMoXkXUxQdC61dpJ6k3zFtE+7q7WDVR1Q7FQhzBG6FixTA+rcLdOAg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTDx6wfNdOmAs33yVxDtDWRQG9YTb2KYUXo9b60OyqI=;
 b=bnsx3LEW3Fx/EpSGjgEan+lD1PIzZ2tP4auHYaoJ0NYDwi6U1W0+7/M9eABrtcuQzbrZnRRNgDNB/pfbpQjniq8ZkX/YXyi6LqSO1mFBn9aRXUjikGWXJUnWBR/oRnpPuERow6VHvbIBODFDvwipWDUxgV9Co0OU1lqeZqjtJyV/oLawA33Bc8DSr0s295J8FVxzO1C117G4ooStdlJ49qmU6fnY9DmAu260VdLVveHl8CnucC8QWfjoJ9SwipRuybmiJggdbhbU91Q3LzHzqzXcjnezepFYw2FjCU9BT9n+BASStRNfJoA+6BKWeZimiHPA+YD/S+sAqeoZlRvznw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SJ0PR02MB7360.namprd02.prod.outlook.com (2603:10b6:a03:29a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 13:25:04 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 13:25:04 +0000
Content-Type: multipart/alternative;
 boundary="------------0SXbD2JaoV9gVBxQJjZASuPS"
Message-ID: <2a15e4a0-2a07-44d1-8e75-f9081ba4375d@nutanix.com>
Date: Mon, 9 Oct 2023 18:55:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <871qea5x7w.fsf@suse.de> <ec1a8f2e-ec10-46e2-1a2c-1ae593080ad4@nutanix.com>
 <87sf6qpjrz.fsf@suse.de> <875y3mpfn7.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <875y3mpfn7.fsf@suse.de>
X-ClientProxiedBy: SJ0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::26) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SJ0PR02MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d23950-23d5-4e6d-43a5-08dbc8cb258a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVQI9HR0RZXmYYv8L+ZjNeFJLTDXWSQB8FrnPSB+bovwYYVwpf9UucTRitlz1sxH7C3dMstGXqaGZ2PEL/paUzNgiYkwVD7C2zebmoHPpNdCdy5y3sJ2EJV+UB03UwX9HEu+nYDusIzZPZEHeq5mvDpEpu03a6si2jM0HeGrKChqn03FfbnduGceav6AxSA77pdr46DuoijodlYFEaL+KzMU5tZR36GOQnvDwdM+s8o/xjOSwL1xqgQp30Fm0gN8UHR5e9PlfOiFfEDiETHmlF6SyX6Mb4Ruspfo/MM5mTVWyQlkY8F1u79wY+5/86eW7q26M4hhcs8mvkphiABu8IaXXdP/lTWYb3ikrapR/v2CgCjct97/cNqAgddJhGAA8zb02niQkgrNuk+h3APUwElIFToN2BhJEPPTlFSF33g9b9lpeQWncfm63MQg0lcCgZidcWQnNrwboS3lg8la+zcSMtZxqQItv4G+FnNszZbxi7PSZXBVq+v//PK623E30+Xw5eMMpYVQZ0uIWxnQyRYEtMHSjuABldoO6CWgnFWMo9tjVPqytfbeqclPQDCwfl5e/1tj5xkFGwI4CIczr/l50MCE1CGBkdH8H7+pEO7ocTVdAv2jCWuuO6/dv1AUx5lwVTkzGcHWQyeaLnzI0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(33964004)(31686004)(26005)(2616005)(53546011)(86362001)(31696002)(36756003)(166002)(38100700002)(107886003)(83380400001)(4326008)(2906002)(30864003)(478600001)(6506007)(8936002)(8676002)(6512007)(44832011)(316002)(6486002)(41300700001)(966005)(66946007)(5660300002)(66476007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjdFSHJQQjUvMUJtUHdneWlIb3lmMGZNVkdrK25ieFlYcjhjTVFkWWtuR1J2?=
 =?utf-8?B?aE54U0tYdEFsL3hwVldQY3hzZzcyUXdnL0diUUNid3VZTlkyelNodExSMHlQ?=
 =?utf-8?B?NjZ3cHVWMVozQUZzTUswd21pcmQ2eDZqNEh0TFJyZkVqb1hpTUQ2dUlQcEJt?=
 =?utf-8?B?TjF0YjRUSnNQRkh4VFRBZFVVQ3Y0NytCc0hsYWRXYlZuTm1EZitXNnRaMGxp?=
 =?utf-8?B?bmxVc0YyRnhuQWszNHptQzNDRitvNjlQcUhUV2RwaVFqNnk2UjZYcHpzQlR3?=
 =?utf-8?B?d1FZV05pODB6bEtRbFA5SThhU1poL0dkTUlGZzBMdWJxcEwwRWxaKzgzSUlZ?=
 =?utf-8?B?eVdUZ1ZMUDk5S0pUaFo5RzN5TVVaRzZSa2Y2eFZQMmczay92UzR2ek1Uby9x?=
 =?utf-8?B?UExXaHV4Ym0zZG9LZXhFNVY0V1l1S2gvMDB0cFZhUEV6ZEIrem40ZkF0bFZN?=
 =?utf-8?B?dkdoQ0UvVWl6ZVg3cHZvMFJKOCtWdXY3NzYyUU1ibW5abnFZUVdtWXdnL1dE?=
 =?utf-8?B?MkZBWXNYakNNZEVRVXBtZXU0dnRJclI2ZEFjL3JRTmp4Mlc3eEVkc083Z29N?=
 =?utf-8?B?ZGVYemJSUnpWU2JCR24xQnNBRmF4Nms5UksvWnFKZmQwSUV3YXo1MmxSK3Z2?=
 =?utf-8?B?eFZXYTUva2lwN0ZaM2dmcXI1cEJjbGhhRTlYd2RtWHNwZEJqTVN0OFhUTm0w?=
 =?utf-8?B?R0JPaEdhOWQ4dHJiMWZCT1A1THp3cWZpM0xIK3dzTUVDV1RXYU1tS0tPTGJj?=
 =?utf-8?B?Q0RQckhnMGh6WW03YzRjTldEQ0JNbk5icXRYRUgwSGpvKzdkakVtNjA0SXRS?=
 =?utf-8?B?d0RRZGt1dkdqVlRyZVZzZ0diTHNiRHVjM0lUSW5sT0REazBDOVdqVEQvTFda?=
 =?utf-8?B?QnV6Z0xqcFc3blRsM01ZQVdqdUhRTEZ6ODlBZytYZ29qd0ZPbTNENTBwQjNq?=
 =?utf-8?B?R24yK1JUVHlIMkxseXRTUkRnVHRLb21GTFFCYU5lSHBvaVQ3eFF4UXBUL0c5?=
 =?utf-8?B?S0lzV3NWcVJ2bDB2R3JKZ1drVkw5c2k4cENLc3VuN0FvcnAwTTlUNTB5aXdw?=
 =?utf-8?B?cFh4ZWJPcWdNWitDZUIrS2FsZklLL3BmSGlyeStJOWhrUGdaNll1SWIrQXJB?=
 =?utf-8?B?NFdVYnZZcE5sL0JVcU5uUTl1RzBpWjNFcmFsS284L3RWNHdOR3RXb2l5eVNY?=
 =?utf-8?B?akRsaS9zNTllZE9sRG5XTmNRM1JCMHpXNmJLbzVFUmxVS0ZCQWZULzdmWks0?=
 =?utf-8?B?N2xQZXU0bUhILzFWKzEvRnJoWHBxQXdWU3N6T0d0UXlKVE9tcGxuUE1VR2Fq?=
 =?utf-8?B?cTl0NEVUc2pLcnJpZTJPTE9ZTzQ0d2ROTGlHT0VjVkZ5M2x1NGJzVFZlM1Y2?=
 =?utf-8?B?L0tVRlJqZHNOMCtTM09DcW1mOVhYd0ZzblhzZnNlamxNL1drbk83NnVyQ3px?=
 =?utf-8?B?MXhST0xpQ0pENDJnbTFuKzhtRHpkWEl2a0J2Q1RXK3pKTmdwalRSblQ1Z0Jr?=
 =?utf-8?B?TUxFL2lvMmQ2RDVUMERwUHpNYW1haTNHQks2emtDdjVZK2Z4RkpickNrSm9q?=
 =?utf-8?B?ZkVwaHIrWUtIeG1lRXJ6Zjg4VXNiRTRZVy9PTGRrenhLMzRGeExaRnpUbXBY?=
 =?utf-8?B?eTRrMGl3TWQ0U1VyRVNWUG03Ynpmd1RwR1BYM3FvM0w3WU5ybU11VVVGYnlF?=
 =?utf-8?B?c0Vza2UvcXNFdGQ1VkhQL1QrbWUxTkRUYk53MXNhVG1JR1RwcGVMc0lKdk9C?=
 =?utf-8?B?Ym5XLzQ3Q055TWc2L3YzRWUrL3VwMVptQUFlNXZDL1JyazhwYS9lUUJsdkFN?=
 =?utf-8?B?QlN0UjVsNmIrcXdlbGIzOTFjZ3Y4d3FjOXNEQmZWTVNINVFKRGJINlM5c1hO?=
 =?utf-8?B?SVRuM2tqQjIzZlVmNWRCeHpiV3VpTitYRDFpWkdqMzNKcnYvU0orTEVkRk13?=
 =?utf-8?B?Y0NtWjhORFFiVnJEbE9RNGFacWMyYWdkdXRuankrTFV6TGdqV0FTSmIxeHJJ?=
 =?utf-8?B?NUF0V29GRWY2UUNMUy8yQjdGT0o2SDJodVJrL0RhUlIzSHMwVldjVGR2bEVv?=
 =?utf-8?B?b3AxU2FmdWt5ZlBESmx0a2NCaEtLdDUyUXlVR2dZeE5uejdJYThPNFJ2czVs?=
 =?utf-8?Q?FznaMkahAP+CsQsFejb26vc5O?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d23950-23d5-4e6d-43a5-08dbc8cb258a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 13:25:03.8266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1k3+ltxHIAvUck92rdkjplwb02w2TP7BYyIPGJIx4OF5NnVAegVJ6tYmZE8LHk7g4A0/QuxqnVKB3nfAusodag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7360
X-Proofpoint-ORIG-GUID: 87-Mw22j1ciWcOXcCwSPJZwxo6JRCMy4
X-Proofpoint-GUID: 87-Mw22j1ciWcOXcCwSPJZwxo6JRCMy4
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

--------------0SXbD2JaoV9gVBxQJjZASuPS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/4/2023 9:02 PM, Fabiano Rosas wrote:
> Fabiano Rosas<farosas@suse.de>  writes:
>
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> On 04/10/23 7:03 pm, Fabiano Rosas wrote:
>>>> Het Gala<het.gala@nutanix.com>  writes:
>>>>
>>>>> This is v11 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
>>>>> for upstream review.
>>>>>
>>>>> Update: Daniel has reviewed all patches and is okay with them. Markus has also
>>>>>           given Acked-by tag for patches related to QAPI syntax change.
>>>>> Fabiano, Juan and other migration maintainers, let me know if there are still
>>>>> improvements to be made in this patchset series.
>>>>>
>>>>> Link to previous upstream community patchset links:
>>>>> v1:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=jsRvKRy1JOiy05KX1CtLqWN1su5XNmKPKuJTSx5sZpU&e=
>>>>> v2:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=mzt3n5PD1QclHfpZEh-VMoLkkwT8xqjPYN-1r7MOly0&e=
>>>>> v3:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=fa9W71JU6-3xZrjLH7AmElgqwJGUkPeQv3P7n6EXxOM&e=
>>>>> v4:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=Xr1y3EvBzEtWT9O1fVNapCb3WnD-aWR8UeXv6J6gZQM&e=
>>>>> v5:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=OtK10W2Z0DobrktRfTCMYPxbcMaaZ6f6qoA65D4RG_A&e=
>>>>> v6:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=XH-4qFQgdkAKmRsa9DuqaZgJMvGUi1p4-s05AsAEYRo&e=
>>>>> v7:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=RwvfliI4wLm7S0TKl5RMku-gSSE-5fZPYH0MkzJdoPw&e=
>>>>> v8:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=BZsKBJGVPDWXwGgb2-fAnS9pWzTYuLzI92TmuWBcB3k&e=
>>>>> v9:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=YcWFU9I2u-R6QbVjweZ3lFvJlllm-i9o5_jtLBxC_oc&e=
>>>>> v10:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=JQt63Ikbz21vmsLmSensQu8zknGuS9bls-IFpndor78&e=
>>>>>
>>>>> v10 -> v11 changelog:
>>>>> -------------------
>>>>> - Resolved make check errors as its been almost two months since v10
>>>>>     version of this patchset series went out. Till date migration workflow
>>>>>     might have changed which caused make check errors.
>>>> Sorry, there must be a misunderstanding here. This series still has
>>>> problems. Just look at patch 6 that adds the "channel-type" parameter and
>>>> patch 10 that uses "channeltype" in the test (without hyphen). This
>>>> cannot work.
>>> Ack. I will change that.
>>>> There's also several instances of g_autoptr being used incorrectly. I
>>>> could comment on every patch individually, but this series cannot have
>>>> passed make check.
>>> Are we allowed to run the make checks ? I am not aware from where these
>>> failures are arising. It would be helpful if you could point out to me
>>> where g_autoptr is incorrectly used ?
>> I mean just the project's make check command:
>>
>> cd build/
>> ../configure
>> make -j$(nproc)
>> make -j$(nproc) check
Yes, I got it now. Thanks
>>>> Please resend this with the issues fixed and drop the Reviewed-bys from
>>>> the affected patches.
>>> How to verify which are the affected patches here ?
>> I'll comment in each patch individually.
> Done.
>
> We had some double-frees when using g_autoptr in structures that are
> nested into another. The qapi code already descends and frees the
> children.
>
> There were also issues with allocating memory and later overwriting the
> pointers.
>
> This might still not put us in the most correct situation regarding
> memory, but I think it will at least get make check passing. Feel free
> to investigate the errors with make check and propose alternative
> solutions. It has been a while since I looked at this series, I might
> have missed something further.
Yes, for now I have tried to address all the comments made in the 
individual patches and tried to fix issue of pointer overwriting 
wherever I could spot, also double frees in the hmp code workflow. By 
doing this, I have passed all the make checks, but if there are places 
which needs to be re-looked for the above issues you mentioned, please 
let me know.
>> We'll also have to add compatibility with the new file: URI that's
>> included in the latest migration pull request. I'll add comments on
>> where I think we'll need to add code to support that feature.
> I'll actually defer here until you post your series with the
> fixes. It'll probably be easier if I just send individual additions to
> your patches.

Ack, thanks for reviewing patches and giving valuable feedback. Sending 
new patchset series within sometime.

Regards,
Het Gala
--------------0SXbD2JaoV9gVBxQJjZASuPS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/4/2023 9:02 PM, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:875y3mpfn7.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On 04/10/23 7:03 pm, Fabiano Rosas wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">This is v11 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
for upstream review.

Update: Daniel has reviewed all patches and is okay with them. Markus has also
         given Acked-by tag for patches related to QAPI syntax change.
Fabiano, Juan and other migration maintainers, let me know if there are still
improvements to be made in this patchset series.

Link to previous upstream community patchset links:
v1: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=jsRvKRy1JOiy05KX1CtLqWN1su5XNmKPKuJTSx5sZpU&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=jsRvKRy1JOiy05KX1CtLqWN1su5XNmKPKuJTSx5sZpU&amp;e=</a>
v2: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=mzt3n5PD1QclHfpZEh-VMoLkkwT8xqjPYN-1r7MOly0&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=mzt3n5PD1QclHfpZEh-VMoLkkwT8xqjPYN-1r7MOly0&amp;e=</a>
v3: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=fa9W71JU6-3xZrjLH7AmElgqwJGUkPeQv3P7n6EXxOM&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=fa9W71JU6-3xZrjLH7AmElgqwJGUkPeQv3P7n6EXxOM&amp;e=</a>
v4: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=Xr1y3EvBzEtWT9O1fVNapCb3WnD-aWR8UeXv6J6gZQM&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=Xr1y3EvBzEtWT9O1fVNapCb3WnD-aWR8UeXv6J6gZQM&amp;e=</a>
v5: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=OtK10W2Z0DobrktRfTCMYPxbcMaaZ6f6qoA65D4RG_A&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=OtK10W2Z0DobrktRfTCMYPxbcMaaZ6f6qoA65D4RG_A&amp;e=</a>
v6: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=XH-4qFQgdkAKmRsa9DuqaZgJMvGUi1p4-s05AsAEYRo&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=XH-4qFQgdkAKmRsa9DuqaZgJMvGUi1p4-s05AsAEYRo&amp;e=</a>
v7: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=RwvfliI4wLm7S0TKl5RMku-gSSE-5fZPYH0MkzJdoPw&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=RwvfliI4wLm7S0TKl5RMku-gSSE-5fZPYH0MkzJdoPw&amp;e=</a>
v8: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=BZsKBJGVPDWXwGgb2-fAnS9pWzTYuLzI92TmuWBcB3k&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=BZsKBJGVPDWXwGgb2-fAnS9pWzTYuLzI92TmuWBcB3k&amp;e=</a>
v9: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=YcWFU9I2u-R6QbVjweZ3lFvJlllm-i9o5_jtLBxC_oc&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=YcWFU9I2u-R6QbVjweZ3lFvJlllm-i9o5_jtLBxC_oc&amp;e=</a>
v10: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=JQt63Ikbz21vmsLmSensQu8zknGuS9bls-IFpndor78&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=JQt63Ikbz21vmsLmSensQu8zknGuS9bls-IFpndor78&amp;e=</a>

v10 -&gt; v11 changelog:
-------------------
- Resolved make check errors as its been almost two months since v10
   version of this patchset series went out. Till date migration workflow
   might have changed which caused make check errors.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Sorry, there must be a misunderstanding here. This series still has
problems. Just look at patch 6 that adds the &quot;channel-type&quot; parameter and
patch 10 that uses &quot;channeltype&quot; in the test (without hyphen). This
cannot work.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Ack. I will change that.
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">There's also several instances of g_autoptr being used incorrectly. I
could comment on every patch individually, but this series cannot have
passed make check.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Are we allowed to run the make checks ? I am not aware from where these 
failures are arising. It would be helpful if you could point out to me 
where g_autoptr is incorrectly used ?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I mean just the project's make check command:

cd build/
../configure
make -j$(nproc)
make -j$(nproc) check</pre>
      </blockquote>
    </blockquote>
    Yes, I got it now. Thanks<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:875y3mpfn7.fsf@suse.de">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Please resend this with the issues fixed and drop the Reviewed-bys from
the affected patches.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">How to verify which are the affected patches here ?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I'll comment in each patch individually.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Done.

We had some double-frees when using g_autoptr in structures that are
nested into another. The qapi code already descends and frees the
children.

There were also issues with allocating memory and later overwriting the
pointers.

This might still not put us in the most correct situation regarding
memory, but I think it will at least get make check passing. Feel free
to investigate the errors with make check and propose alternative
solutions. It has been a while since I looked at this series, I might
have missed something further.</pre>
    </blockquote>
    Yes, for now I have tried to address all the comments made in the
    individual patches and tried to fix issue of pointer overwriting
    wherever I could spot, also double frees in the hmp code workflow.
    By doing this, I have passed all the make checks, but if there are
    places which needs to be re-looked for the above issues you
    mentioned, please let me know.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:875y3mpfn7.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">We'll also have to add compatibility with the new file: URI that's
included in the latest migration pull request. I'll add comments on
where I think we'll need to add code to support that feature.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I'll actually defer here until you post your series with the
fixes. It'll probably be easier if I just send individual additions to
your patches.</pre>
    </blockquote>
    <p>Ack, thanks for reviewing patches and giving valuable feedback.
      Sending new patchset series within sometime.</p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <span style="white-space: pre-wrap">Regards,</span><br>
    <span style="white-space: pre-wrap">Het Gala
</span>
  </body>
</html>

--------------0SXbD2JaoV9gVBxQJjZASuPS--

