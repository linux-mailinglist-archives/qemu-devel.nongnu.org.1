Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6872B6F4
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 07:00:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8ZfP-0005Mu-BU; Mon, 12 Jun 2023 01:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1q8ZfM-0005K9-FG
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 01:00:32 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1q8ZfK-00031g-Cg
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 01:00:32 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35C1jAXG020516; Sun, 11 Jun 2023 22:00:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=Z8RGyC3sL9sOJF0dbO3BwpTGlfQpTJloOF16fsR+KKk=;
 b=B0Gjs7McxTIMi9am0iXTHYkgEP1NFxvcx5x4Az1YmkHNuyry0Bzo6URhYX5rHM+pFpsh
 7e/PPHHKEG44OUjuDSSDdsFD/6x4dWSXav/KEeDri+wZjLSfxwIghGEnXrQWQ+mBZ2n6
 BMRpt3w4vNX3Be/SO4DJUn0v/h9GASa8AMDwA6FwGmIdtV4lB6xysJtUvmAqN9EmgUpO
 52HkbSTqilrz7vJvn/3wICcZJtvfu5Y62pRY+jQPxTZKTCKER19BEifzsRLlXJ5hjW5n
 MZ6MCGhIRntU6aWZ1MnDJv28nHI63TExwyzQVbvWIJ4m57uhz5Z3nmq7Eq+Ax89uwvtP Ww== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3r4ngs2bb9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 11 Jun 2023 22:00:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3nkZtxEvBsFCpFU1OZrXfJEowputjODqRn9cMUeNcC6kX/2/q/6B3nbnqzpr6sPbhu1E11skKTIMiDcYQAZkhErxGfILcFw7tX+k1t08oKSMiSlQzK1l4Mtsdqu316rAVYB0AUWLBIzRgmeP+Cy5vZbeJrv/7XnEw9mbdM5B0OqG8wQEIH01RAw5OgsQDyE04nJsv9H8+VSd0CFYfFkF5a4aSoyyyNKEyHKaz7Nt80nhspkjZP9xFjDXONO+WedGMzmkV6dF1wEA9YcImniJs3hypuYdDfUp/A0h2E2AHYaicL6DtMjfwvHEdXn/UqsiGk++5/lslAPJjU+vy203g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8RGyC3sL9sOJF0dbO3BwpTGlfQpTJloOF16fsR+KKk=;
 b=EIyEVscShPy5qUrMwtl/vEc2GQAuTYui+L1adcS4lLLXRQaHeer5QvYife5q/m41sGgn4vnKCExBbt4KllW6puR+/+sc5COkIYSBaxWFNwqsRnxTRlDwcw7sbsDEiivmIeVsM7i8EqKhFlubZy0SzrE4fH+6gFLQSd2rbIztFw4lbYJP0njt+BDYw/cXvb5LF0n5SZg1OkvW761pts1BK0iWLq8vj9Bvws5OYiXcFYWGFH33cDyq8qy3rICLFo3xOOnHqO1wAA2OgR8MHlOGrlUQAAZp6LxzpHHQncJJwAM81bFg9IGANkwPSXPwYIFtdvEwzDlSGaMn3AZT6FXwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8RGyC3sL9sOJF0dbO3BwpTGlfQpTJloOF16fsR+KKk=;
 b=dgo4Lum/3zjsqzOFQJh8H5duFeQ9rABCFh3+weh97rP4mQwRveKUJ/PwgwGa+WvYSMPF99obQ/merWsoB0xH8nlcGMqZ3NnsW1au7C+mUzSE5mmrckKxz9Sf+rrHnCmEnQ9Pp9Z991oI7jlXCWxfL5kLmfrgOxFHGcdaoep0M+Jd+qtoFE9UJK2n50crBeFbEwiq1EwUQ3iio0eqxwYxGuk62wRxTR660cnmWAidCYWKQAXR79PJj1uLqCWI2JfV23AOPHBMHLB9Lu+7f3f582AXCp2hdSUsbfgdvfPmY4Z2DDJ8T2QbKUeEcWfBz49SWr7nVZ/7GpZfS32FNMSExA==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by BY5PR02MB6754.namprd02.prod.outlook.com (2603:10b6:a03:213::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 05:00:25 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7%6]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 05:00:25 +0000
Message-ID: <596399f5-2c27-9615-da0f-2f3003041a97@nutanix.com>
Date: Mon, 12 Jun 2023 10:30:14 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC 0/2] migration: Update error description outside migration.c
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, aravind.retnakaran@nutanix.com,
 shivam.kumar1@nutanix.com
References: <20230526115003.212004-1-tejus.gk@nutanix.com>
From: Tejus GK <tejus.gk@nutanix.com>
In-Reply-To: <20230526115003.212004-1-tejus.gk@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::6) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|BY5PR02MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: cc528b04-0ee6-440e-0d8e-08db6b01eefa
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFgA/uELSONNJ5gbuqr2X3/swDNlcFFZQkRWVTFrSBA8ZPP+Pwn+sCDuBV7gttC8ev7mszah3eUaVEuCkF4ybKvdfdSDidhLjpfb7fJSamx9HhNhxJyld5nW+GYSSAIWe49QVziad7FHptjPnZpCXk7fByhJDC3y6zAxdoF920lKjx5RjPtLGBpGmpSLtLQh95L8pQtsbbrthc8QuSkfT0ZlQaN1YnwLslg5XOYnT1KL3GqsBj8kTW6NWpZFxzK5lfouQAq3F7EAYoV6qINIYVV20Uyv6YXKBjFHOtjPKXOpppsV1RWLfg5JpYJARyDAQ142Om3IeBbREdhNU4uYywnle1OVSCuK0CyTyc+tKsCzdoU2VsXI/zzTsmacDX3nkQ5lp7udjb/tyO4MGk/mbrRAg/JXrrc/6Fop2mSC5sh8yXQa3IFxZbtJAixi3GTw1GftAz7NhtRPLtzUExNCOtQXNZi2FMPr+UVphVrKx2pQvrBSU2tE3aMgjvl4/690kHFW0ES2cIJg8dkVjRoLvoFBOkr+/7yJ3Hjy8O8U+pshWLLy6rnVDaeLAr3RROdt4fFct/jSNEnZ3yy89XHc9SX/UgDbN4zu5zrVxX+eFGKNcJZeqGT7S5BNVcE8Xn9S7VYmCZyjMFQDDyiMjXhN0bvE7lSRO1HOYSeF8Ki/JyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(396003)(376002)(39840400004)(136003)(346002)(451199021)(36756003)(31696002)(86362001)(2906002)(4744005)(15650500001)(31686004)(5660300002)(966005)(52116002)(186003)(6666004)(83380400001)(53546011)(6512007)(107886003)(6506007)(26005)(6486002)(66946007)(66556008)(4326008)(66476007)(2616005)(316002)(38100700002)(38350700002)(478600001)(6916009)(8936002)(41300700001)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEY3cCsrK2NmclFrNkEvdDlDWnZHR2FJRXpGKzV6SVlUMlh3eTd4dUV6Q0Y3?=
 =?utf-8?B?enF6b0podEdJMXoraHVCVVJ3RnltaXdRSlVlSGgyL0EwWWFrN1o2S1RtUjV0?=
 =?utf-8?B?UkFnSS9mM1lCOUVVTkp1WHJXV2gzL3A5UXAvMWN0M3lBMDB5MDFqdnpvbHVL?=
 =?utf-8?B?bnAzZDl5VDRkUjNrKzdFTmdGVk10V2F2THo3Z1dzWnBoVnVoU3FGcU9HNHRm?=
 =?utf-8?B?ZXdSbGFnSVY1RVk1ZTVQUUlPOWJ6TmpjWExyaUZhN3h4T0hUSm1mU3VidHAr?=
 =?utf-8?B?cWJGQzF3WVM3NG5mM2JmdW1nSk55YjNlenZMYlpRRXFibnhmTW5qbFZRd1hj?=
 =?utf-8?B?a0JsUkNvZVRkRk1OaER0bjNET0wxZVJXTHRtVlp4cW5vaXVzbEd3K250ZVRq?=
 =?utf-8?B?RDZCQUlCSFhLRlhqeHM1akFhY3VNVHFQV3ZsRExNK1FpTXR3Ri8rUjF5MHdP?=
 =?utf-8?B?bjJLQzJocklrd1YzVXIzUmc0dzc4QkVuMDFmZDJWaVRFaG1OaDRVdTh4MS9t?=
 =?utf-8?B?SlpMQ0dGRjJ6dGVGZ0NxYWdFdUpzRFJBWjNOTDJXVUU4Y2ZDdlp2S29icE1k?=
 =?utf-8?B?Yk5haTUzSTJDc3MvSVpvWmdoVVQwaUZ1Z0Q1OXVXUERnWU5rTFV1cHNTWTJN?=
 =?utf-8?B?dnFMQUsxU0pXS2pHZXhsU2VDdGwvM0ZNUUY3ZWl4aHRzTFkvb0NUUmJJMFNR?=
 =?utf-8?B?TlJoWE5mcmRjd09oWms3RFh1SWRWTE5PSVdPZ2wvMXo4Q2NuYjB1QnhvN0Jk?=
 =?utf-8?B?QzFFQ2x4ZWN6MEZVUVVSUVhKRWNBU29qWFRxMC8zQWk0TjlFUnFNYllJcnBi?=
 =?utf-8?B?bUNmNnVBa0IwRytKWStyamhwVnNiTHBGaVVuVnRVaWdmY1VGTHJ1UkJXMVho?=
 =?utf-8?B?c1VLaFU0NjVYc1hFNDkvMVEyVTB1ZWlrdXduS2NockV3YTlmSDhqQVN5T3BT?=
 =?utf-8?B?K0k3UkprSFZ1aFlIVXR6aTdTZkhpWFdzMVNLbE1uNi9oTEZCSTM5YXc5M2dG?=
 =?utf-8?B?NUlmNlZSWWFrOVVMQllkTFQ1dXNPaDlmZnk2dU9qbng1Qm9KRm5uTFkvTkFi?=
 =?utf-8?B?Rkd2RkU1bEhRK0dlVi83SzVudTg5STVEeWpaUUkrQXE1UmlYSHdSbllJV0tQ?=
 =?utf-8?B?MmpQdnNkV2RXK1Fmd2tHUVQ0eGRuTVRpNUxHNkJpVUp1WXVZVVpRdHRMRlNy?=
 =?utf-8?B?a3UybmJxWS9SenJSRUFJT0d2b3BESWtkNmlaUmVldTI0MTZJVnE4U3NFckwx?=
 =?utf-8?B?VzNaaVhSaEJENkVmazF0STZodWhWTFRxYld2Tm1uUWtCcDhqbVU2N3d3aTFM?=
 =?utf-8?B?aVNib1F2NVJLYVY0M0ZObWQvMU9qc0dGYjlydDZMWW8xb2ZzdHZLVnl6TVV4?=
 =?utf-8?B?TkxES2xOMlB0K0NCalJnQ0hWb1MxNUpsWkFucXJuWFVXQ0g2WmtxZlVQak5G?=
 =?utf-8?B?V2tBaUIxaCtsWExsYnZWdEJjTGNKR2V6UGxYeEVka0x5ejRQNXYvTzJmUEtE?=
 =?utf-8?B?MFFBTkRteDhvQmtPajVQeWFUa0xuLzFPZm44YUpqeXoyQnUxZlZsdVJFdHBx?=
 =?utf-8?B?bWhSRHU4M1JMK3hDRkJMQUh2RHU0RmM3MGF6dkhHUGxPMFVIdDhRbE9ock9u?=
 =?utf-8?B?MGdHMXRBdXlzdjc3L2pRWkVCKzVVY1N3N2tLTUovZ2o4ZW5zaXRGUkkyd25l?=
 =?utf-8?B?ZkpWU050Z3hEdmpVM3cwSS8yQ3VsakZSR1FaQmtEcnZDeUovY3BqUVpzSERi?=
 =?utf-8?B?cnc0Ty84VnJuQitINGVHZmlJL3NkdHQvd0pvaWplN0tqVTEzSEc4SWNLdnl2?=
 =?utf-8?B?ZkhKTUs0NWVLd0FKbTNLZ1VUVXlndTNsYy9JZkJDUjl4aVJnZVNtNXBTQzZa?=
 =?utf-8?B?bTMxcXBIR0M3UEZtZnYwR3h2a3hHMDZicTRUbnZkQVNuanorc3RtRldKMW5P?=
 =?utf-8?B?QmwwUU9mdWVCUnlQYS9hYlF0b2JqM2dFNlFJOExwTFIwODhicUNKV1RKQnhF?=
 =?utf-8?B?NnlrTnBLV21SUzZLSThQMkp3QTVLVHU3SHpqM1FDL2R0UXRDNGF0bzIvMFVs?=
 =?utf-8?B?dUpFbTdLZTdXWUlXYjlHSlJYMjBSZG9CeDlTK2JSSnk5ZUtMNlQyVWRUUGFF?=
 =?utf-8?Q?J+FLCFY+KjunXODhDONlsn115?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc528b04-0ee6-440e-0d8e-08db6b01eefa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 05:00:25.5015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARUYp8/T5d+wbZwc0JNBX8ZHorADIcVQHwWs0Ho1dowk80NPJ31loizsKuN5xGEdjTnDzxQ/aR8YS+ZksBPhyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6754
X-Proofpoint-GUID: gWo_togpL3Z4BYVC2ah5k4bOu7YQf9MP
X-Proofpoint-ORIG-GUID: gWo_togpL3Z4BYVC2ah5k4bOu7YQf9MP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_02,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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



On 26/05/23 5:20 pm, Tejus GK wrote:
> Hi everyone,
> 
> This patchset aims to cover code paths in the source code where a 
> migration is marked as failed via MIGRATION_STATUS_FAILED, however the 
> failure exists outside of migration.c, and without a call for 
> migrate_set_error at this place. 
> 
> This patchset has been split out from the patchset sent before which 
> covered cases of such gaps in migration.c aswell.
> 
> Previous patchset: 
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04463.html 
> 
> Regards, 
> Tejus
> 
> Tejus GK (2):
>   migration/vmstate: Introduce vmstate_save_state_with_err
>   migration: Update error description outside migration.c
> 
>  include/migration/vmstate.h |  4 +++-
>  migration/savevm.c          | 19 +++++++++++++++----
>  migration/vmstate.c         | 19 +++++++++++++------
>  3 files changed, 31 insertions(+), 11 deletions(-)
> 

Hi everyone, 

Apologies for the delayed ping. Can someone please review this patchset?

Regards,
Tejus

