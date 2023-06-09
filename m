Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F3B729705
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:37:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ZTk-0006gS-Uc; Fri, 09 Jun 2023 06:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q7ZTc-0006fw-0h; Fri, 09 Jun 2023 06:36:16 -0400
Received: from mail-db8eur05on2071f.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::71f]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q7ZTa-0007K3-2p; Fri, 09 Jun 2023 06:36:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjzcooiGEq3oRZqX/ZMmQI8bOdPwPU20UkAfk1pig90De4bL3iv+8gP9gx311SS9B95YzGVpY9K1l1MiFNEovodmPJebo+6GigxRQ/XU53nMYk1A9HGYZH7tvXoy1b0xfEGK5audnC0aKakPsVnJU7Kz94Ou35B0I/1LijHjY/rxHFbPLmdA/dp8eTbtnYw67opfFW7suMG9CBa6C1PbYWjO8RA8MzI+0/NMrxWZlgAZnjMI0guuj7ZayadAxqHiOHs1VdzUGKdIsFvW9wi/u6C7z66zo0OzcQFy8MCl+vsMUocTy2sbPO3OVY5qHMa0cD1eXwsaul2EZzWYqPltmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPEa3Ces/6clPRXd5kIMJFrdAFfzydcs1/fyfttLDiI=;
 b=SUTyzmogtKjDxSbz8KmRM3kYUsY2azzvRAdyXT2iCjcORhZWQvBUU9kEp4bhJD+vex99+FnCqVCRRCtTEndBurbdvRXlp198Sc4HNrcIVI5XjXsEhtwSOLhinP/H0DTdQOVDaTOSKe0Esmel7jE6cHXEg7sJnX+19nKHgiKFzDLWs3K/19t/dH1Q1+NQnVXc8ogQeA557OwCNhXzSCSLSX6N644mg42Gi0O73S6I+DyTMNAaMPPqjvwyJXxuPJeZwcLNSAb1rAV79LVoLEpyFlA/goCqyn4FszR+OEk0uwzVt1tv0TAg1Wc/Y/mYLBLwUV9b642Ry7ZseRzPlMJf0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPEa3Ces/6clPRXd5kIMJFrdAFfzydcs1/fyfttLDiI=;
 b=FxSq4gQYJKVv2P47mG8BUh2FzcpdwdkuyNPMN1/asibR+C8HrLxx1qy1pNYKwyGsruUXGHDaLAoSOJL8NFQC8LC0ciFxdnmluz21ehkz2dwrZvoLU96kwG4hFVimpB/3nbAg1fDZ4Bf0Xrr6qYUHaA4Qtvhe8wijGp96MkIhv0ziFizfXAoZnsvDGU1v0CnG4f2p+Z0eP3ky2t2IXiluq1iVu5RiMMfklJG5w0v75qams55rxRAXGluQxcry7XUvmA9z6TyQAtrorRtidz0YnNKrHtTKZ+6ON7VgQek4js6Ard6LqCC+Nep8safxCVEeV6ce9lxDnSB3lpj7z29bog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS1PR08MB7515.eurprd08.prod.outlook.com (2603:10a6:20b:482::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 10:36:09 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%6]) with mapi id 15.20.6477.016; Fri, 9 Jun 2023
 10:36:09 +0000
Message-ID: <867a5cc6-db43-643e-5e40-def1e24cc5d8@virtuozzo.com>
Date: Fri, 9 Jun 2023 12:36:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 4/5] parallels: Replace fprintf by qemu_log in check
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com
References: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
 <20230529151503.34006-5-alexander.ivanov@virtuozzo.com>
 <9c89f136-4ab9-d6bc-e4c4-2dda3505cdff@redhat.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <9c89f136-4ab9-d6bc-e4c4-2dda3505cdff@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR08CA0012.eurprd08.prod.outlook.com
 (2603:10a6:803:104::25) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS1PR08MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c57e942-38eb-4258-2e80-08db68d55679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2oAgWqLPDnmpxtSZ/g0DvmW6hnySW4p58p76UG4gi3JrPIDg3+dUQJ93lxe4MGSVk6VlFjuivqU9FZP77gQ+I3gtASmAXZCj70hmodom3rJ50FGWW5Lv2QvnmwElq2gvfZzjE8Qa+X2QohGEMhgVFGXhoOG3Wlv731qQOkOc/dvqFVrA8oQ4BSCjpYOA37NlEW2REhort7z7nywK9HwEjLFW+IAgpDNrXpxey44u3sLV8wOWq9SnjO2dljpzAzCeDCbhBUN8/6QPchIsT04mXPeoJIK9VatdqMjpzqtaYpzaoNZVhmfALlR8UTJs+AqY118nERnNfJIcqOgYCKCRzFvjpX4AzTILPGCH7BdWT+luHueVeSmHXyzVgfJpvH5rH24p3r2FeeF7TkHFiVPze+o9HyYezeK1pH+23jclhEfEGCeY4OFqKxsqzgDRs2eLmEkCd27r8HpTC78OeSnM9UJSVct/NMk1SUsxsnZa+gaT1hFY4+0j/nHrgCja/gDMjOyeO4/cnp6I5OB+C6Kzthtuqs73vWl8I3CX6h+lAyNfBen5W65kVPqQyf3OwXqtrVEqZpogzdzZKUX8epU6u1je/stAOyTgGf6B9uRTXAVxDmV0EhO0nGKE/vh/KyXx5F13hp20nMG+EB7f4buCGX93sVQ1+xWazo/4sUny0HzAcyfx0laxcO7JFLJOIn8R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(451199021)(41300700001)(31686004)(316002)(478600001)(83380400001)(4744005)(2906002)(66476007)(86362001)(66556008)(31696002)(66946007)(8936002)(5660300002)(8676002)(38100700002)(38350700002)(4326008)(36756003)(6666004)(44832011)(6486002)(186003)(52116002)(2616005)(6512007)(53546011)(26005)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amg4YitPaHFOZGNLU1lSSFJMbzJWV1Jveksvc3B6aTFJdkN5eDNISG4rOHhP?=
 =?utf-8?B?MUVRVzN5NWNxNDB1VUQ2dW8zaFh3UUcxR1lydWxMaTNYaVV0ejZWdUk1R3pw?=
 =?utf-8?B?bk9EMjZ0K0FvY05tQ09KVnh0NWhVek5LUEJ2b3JscFBVLzAvQjBRRGpybFUy?=
 =?utf-8?B?Z0I1V29sSHJvK3owMkNudytwd2dHT0Y1cEhraU9xVDNnUC9NSHpjWm55dEZX?=
 =?utf-8?B?N20rZVBzTVNYVFdGS1dPcWxuMVgxU1ZHY09oNXNJdnpjajBpcnZrdis3SktR?=
 =?utf-8?B?MklLWGNUMmdqQUhpMkg2TVdiSHdVWHNXeUsxWjRpdm5jd0VVbHQ0YWZjZm44?=
 =?utf-8?B?T2padmFmWVRBR1FkVHZHMzAzK2dnMVlmSjBQeUhwZnlTMzZZbVRPQlZrT1dr?=
 =?utf-8?B?N3NKQW5ZNEZnc1BZSkZXU3Bydmo4L1YrVUtoMkxtbHFTTHo2Z3VUSEN4aSto?=
 =?utf-8?B?aCs4NDFaeTFVK05OeGo5R3M0MzFPZ1NjeTk0L1F1RnVRMDQwaVVKMHEyN3Bs?=
 =?utf-8?B?czNzb3F5WU1nTHdjQTRtWi9GT2RESkE1KzQzWFhpY3gvVDduZjZ3Vjh5SXRu?=
 =?utf-8?B?R1dSZDFhV2ViaGU3bEpCU01CeVV4VWxJR0x0STlBL1o3bDV4UzlQSHpOVkJq?=
 =?utf-8?B?Z0ltSGJIM0R5cHJmeVlqUTZOSWw1UHVwM2g3a0xuWjBNUyttRjNjV1cyZEh1?=
 =?utf-8?B?MEM4TmFVbFhzRkphZXZOL0Q0bjhkVUlHWUUxWXBLdGlpZzNpSEQ1SGpHN0tu?=
 =?utf-8?B?WCtTaGt4K1EzZEZxYlZCSUdCQlh3em1hKytGRElYcWQzdEJTU0k2T3EwNEpq?=
 =?utf-8?B?WDYrTW1GWStLU0JkcUY4cXk2TDBQR3NaWjhFY1ZVWlk0K3hjTEdUcEd2YkRQ?=
 =?utf-8?B?RWovcVN1ZGdOT255NjEvOU5zckJKOE5wZm1zaVpnNlNVN05hV1A1R1A1dUJV?=
 =?utf-8?B?Mm9FZjBDT2UwejdKL1hWYk13U2FVcC9GZENTRUVOZ0FTUWVMVXp4NVhzV01j?=
 =?utf-8?B?YzVxbWdIK252c0VUZFFsUjBtTXRzNllrTWxJcjNoTGxKdzJRVE9QbHZ5WmdB?=
 =?utf-8?B?VlBqQnU3VnEyNyt6T0NVbjhHd1dNUFMvMGpobVhpdFBqVzlvZlBBVHRrTjdm?=
 =?utf-8?B?ZklHa1UwVTNLOXlEcXRCYXF5VUFQdDJibzE1K0RZVnFZNTlYNlpEb3FUSHFT?=
 =?utf-8?B?ZHdXMUVDMWZCYlZpZy9DREJwc0NwZXJScEVpSlNaMzF0ZU93TGc2Ui9DY3FY?=
 =?utf-8?B?Tlc0N1RpVHh2aGFOSGt2bkUrK2gxTkFqRVJmeUF3VWxVL0FJMkNqeGk4SEhU?=
 =?utf-8?B?OU4rZUN4ckQvYXR4VGJXMkRWZXh6WTVhbmRTZTl6c1RINE5Jc0RyZjVIM054?=
 =?utf-8?B?V3FxYVFqUlFTSHp4aEowaDlzeTlrQWo2U3ViaFRDaWljVWRaSWFrSVlsVlN6?=
 =?utf-8?B?cEw2cWk0K2pmK0NTTjVCcFJZSzJOTHRzNzFGc2RWdHZpSjFPc2ttWkRUZ3Z2?=
 =?utf-8?B?Q2FhR01ZL1FpZVM3cDZkWTNmN0hIL1lJRHJYcyt6cXJlcjV4amx1eklndHU5?=
 =?utf-8?B?a1RHSWZ0SGJERGIvN25JZURUZDZrcWN4TFlWcUVVZlpiVjN6TkZPWG9PNzl3?=
 =?utf-8?B?S0hjMUVVTjBZd1N5MkJTcjdFelhDK2syaDRhOFdmdmF1REpiWExOUGtDblY0?=
 =?utf-8?B?UmdRRG1sUUdMUHN6TGRLZjZhekZVaFNUc3d1WFpHbmFLMUF0S2RZU1ZIbTlo?=
 =?utf-8?B?eW5wQ3JPVmY1M0Y1bVcxYTRoT3krbmVENWtBM1Y1QllGSjJqelAzS3JBSU5X?=
 =?utf-8?B?QTZIQUkwcVdncDNFeTQyaWFVUDkrbFBtTk5rQm9qLzR0ZHI3dWJIVGhMNllS?=
 =?utf-8?B?akxjYXhzcGRySkh1QytTM1JTdGMxb2svREtyWU1GdHhHam9ZTkcxVElnMTZj?=
 =?utf-8?B?UkRPRmRBa01ERXRURU1ieVBFNmd6UllxdmRuMnR3T3ZRQ08vb01mSWNjcDQv?=
 =?utf-8?B?dWlTSlVzOE1KbDQ1YUxMK0hPcitXYlZEWU9ITEFoWTNMRUdYYit0UW5KbEY0?=
 =?utf-8?B?Y0VWTCtINmltSDJ0R1ZHL0hRT3Q2ejJ2RnJPemJiWlNwSTBIWkFyb3VLMnJN?=
 =?utf-8?B?RHgwRXZXa2VOTDd3SnBSWjhNUEdTZDZxRDk0SkE1UnBIMDlrMDRCT0ZHeExG?=
 =?utf-8?Q?nYg31amH4LagVFfAOoR0ctA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c57e942-38eb-4258-2e80-08db68d55679
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:36:09.2411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdBWDxmaw1aQp/DLq8dxCOmvAZOjpHJZjzLz+JV7t33lqGG9QBYfAt0vR4hcwLUnvG9GM8tFmmY10dqX2ULv57AG2r3rIMb65fJMZrHH7Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7515
Received-SPF: pass client-ip=2a01:111:f400:7e1a::71f;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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



On 6/2/23 16:48, Hanna Czenczek wrote:
> On 29.05.23 17:15, Alexander Ivanov wrote:
>> If the check is called during normal work, tracking of the check must be
>> present in VM logs to have some clues if something going wrong with 
>> user's
>> data.
>
> I understand stderr counts as part of the VM log, doesn’t it?  I 
> thought stderr is generally logged, and naïvely, it seems like the 
> better fit to me, because it conveys more urgency than the standard 
> log (which, judging from its callers, looks mostly like a debug log).
>
> Hanna
We want to add some image checks to parallels_open(). It means that it 
will be used not only in qemu-img and we may lose these messages if a 
log file is specified. Stderr is not duplicated to the log file.
>
>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> Reviewed-by: Denis V. Lunev <den@openvz.org>
>> ---
>>   block/parallels.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>

-- 
Best regards,
Alexander Ivanov


