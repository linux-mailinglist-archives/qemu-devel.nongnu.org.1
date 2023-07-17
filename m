Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F23FB756993
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:51:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLRQZ-0006D4-A5; Mon, 17 Jul 2023 12:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLRQK-0006CK-Ix; Mon, 17 Jul 2023 12:50:16 -0400
Received: from mail-dbaeur03on2070c.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::70c]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLRQI-0006CR-Fn; Mon, 17 Jul 2023 12:50:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JItU42bUcgm6zGnf0sl2dQXZOiyhEerVGIClx7mWcK7h4kydtmQeopxW3xwx7uXuA6oeEl+zY1+ukR+k1iOT1h8iDWWPol3PRY2SDihYh/aH61Qp9eSkoMpRECxB/E7yXmnnjVGEd40Xt/XiXNWGo2b7LDymK2SSwjByKAZ0Xk3JeNaLPOkH6TuBUqO0xHfYXi+EBr/TlGWe1YpQm9Ol3BJ9MYZmXZvi0V1b8V8VQEMgk5kPeppw9w86we8HMGrdn/wZAVE+TNjw+SQPR8q59vycyXP52V36l0Jixw19AzWbf7on3u6ZBS9zEWSG87nB4ByFWk+Fs6dVebkiee7j4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wju0YsSA1fQ/0P15QSidewwkpRVU+oelXgOZm/I9I3o=;
 b=mzu7MdoTdm+hD6p+5IW4t/qNd+U5gL77UrbaGEpRWFStbTt25WHiAjtdy9jd+FydAzZX4UsYY2eCqI3yPmQ+8wqDGGzCKoHLTsti3NDJwTcXqRbj3dnkTLlOU0C/Sy78PK5ku6qrZ4PpsKo/HlKP1T9G4eC2R0/gLxXffeJee+7TA+9wcQglAVx37xDk8SJD6I0z50Fi3bQ2PGJl2xqKK0+UdjWqfvViVutwRI7lB7cI6Om4lO3Q/qMUv7eFSwhiFD85qTZQ6FP0vHAz/Chr3/26JpydHYeORzMhzK/tTorqrkFmOjuz4sat1Yyb5+hy7n9xPeT6sXmFsH7SqRP/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wju0YsSA1fQ/0P15QSidewwkpRVU+oelXgOZm/I9I3o=;
 b=P3zmvqkjoIYYgzujR6t6krYJSk98vdM0sZFeMOHfh3oMq/ZRTmVo1NQKJQSCR0XLFEiMproNoCij3KFWvEj+FOc122GeBAfJNW5T1M/1yJR5Wx6g4ytTwVznAFmV71AJna9gbpPZhPSDjShJjQ2mhspuw8Ohy/c7KljgGkpc777QMpboQC0tnbZ4qyf+pKuNpNYL0F0r5JFLq8yBshgwEMIsRdeK3WgTTHlTX+cu15/FNH1lwyqA+VSqyxzxXi2tSlOywHmowWCmfwUncsxgdGu3q9TIIgMEBHJ2ADcWUg86Y24eUN2iK/LtVa/dQWNKOS+3dJiG1bpJN3a5u164BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB9573.eurprd08.prod.outlook.com (2603:10a6:20b:61b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 16:50:06 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:50:06 +0000
Message-ID: <0084d49f-434e-4997-6190-014fa1b7cddd@virtuozzo.com>
Date: Mon, 17 Jul 2023 18:49:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 7/8] parallels: Use bdrv_co_getlength() in
 parallels_check_outside_image()
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
 <20230701100759.261007-8-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230701100759.261007-8-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0053.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::17) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ade5724-6659-46a2-cf11-08db86e5dfa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ut3v2rjO+mU5hJoowzt9vLKinX3QV7a+LAj4ynn5Sw/sdI5h6qU5tbatsXKiuxAQzYhht2pXhHvkCh4hfdrbr/ER0zTcaGOfKaxPd/wzj6hlmTb2iSEWUTxZnF9JP50rdPtexz0NZzJJ2x4Nv2+ROAVtwB2lG0eq1IJZ3uIFQpKwaHQPNTXNDv9vHSfGwsMPC5Tmmuk5Y/2fbMzkVLKYHI2LMraR0ECxOXKBg+VA41Li0GcTZrZpojB/VBZBmsUw4ptra+qbtlMXUntJyFSXOAwQufoGLZyiRtJyHYI8kbMKSt/TwbrW7sTzhcNrVO5/U9xkFkYHuaWw6kZsl2WMzogbGkjPlTHh1oXkxOYppsdlJ0trMZzdvjkhLjAFfpWOqnxWWTkF0zOtbnc0xUdoJop+qauFUbGzdDW9wSQECDQlr/55xG5xg8x0PwITWHWLoYToHf8Z7Jnnwve52mnSRtS7TugnZ220T0J79YuACtBz4pwokVnlPv2lrbzrnxv8E/gMyNXpnUzczwN7uYnn3Q5AbZfLfvjze9k/su8zcc+jfOM5q6U0Xy1bt2/BSDcMktB9J+d3RZJEDsTM1M1YMByhtxiCG7RPkp0xkIRrhmEA50hz8eoGuFSRyQVB9/S/CwwSuRXCgSJEURvt0i/4cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(376002)(366004)(396003)(346002)(136003)(451199021)(31686004)(478600001)(6486002)(6666004)(83380400001)(31696002)(86362001)(2906002)(4744005)(53546011)(186003)(36756003)(6506007)(6512007)(2616005)(316002)(26005)(66556008)(38100700002)(66476007)(66946007)(41300700001)(4326008)(8676002)(8936002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk5JNnhYeTI0TzM1eDBTQUExdUZRek9NQWRzUWxNVG1QdlFVWml6U2tXVDAx?=
 =?utf-8?B?aXpkYURsQ2tIVFpVT0RBR0N2RHh2K3Y5cGV4Qzk3dEd4b3BpMmtvN3RTWDUr?=
 =?utf-8?B?Uk9QSUpUSnVNODdBekRoV1lsVDE3bVBmSGlXVU5oTEw3WS9yYUcxeTJVV0wz?=
 =?utf-8?B?MlYyQ2lTTXJiekF3NHI1cERsZ2lsU3Q1Q3hmWlNZYzdvRTUyamwyazZPRG9U?=
 =?utf-8?B?bEtodGc3SW9UT21yU1YzQXRvd2liVndUYTdVb0xpdnUwcGd3VGFKM0tITXVG?=
 =?utf-8?B?R1EzMHBFTEJua2FxWDNNKzFvMStNdXNnZUhkS1hSeUM2enN6N1k3YkthR25z?=
 =?utf-8?B?cDUrWVcrTXhJTW9RYzhYQjQxUmdLVkxOQWJnSlFWY0h5Uzl5ay9YaXlwV3d2?=
 =?utf-8?B?bU5TaVRLazgrZXBBb3pTZXVaL1FkcytZTVFrWW01MGFtSjFxeHIvc3poYzRT?=
 =?utf-8?B?QnpEOHpML3BLc3hmdGNieTRBdm84OVhnRHE3bjljWXVhcUJjRkJEaE9pZHAr?=
 =?utf-8?B?SWFCV3JtUmhvSmNieExrcDhxL1V6V1g0amlhOVAvNm15WlYyYkJ6YUh3V2dh?=
 =?utf-8?B?ZVFtUis3SlZwbnRkVUY3VHhpdTV5aW9xODhnV1duUFJhQm5pbnI3SFlJYU9E?=
 =?utf-8?B?MFRRQUx1NVZDQS9yZjRCUFZwZmJDOTU5Z0NCVm1IbDcrTGI4MEN2Qk4zZitp?=
 =?utf-8?B?OExRak54RjZwVDVrTGt1TnBxc1ltZXBTNWs4TldGQXFZNFZpVzdVZU8xNFk1?=
 =?utf-8?B?TVFZWDNlZkhOUThQYldJT0RRUTM2MWo0R3ZadGxaNk55dWdkSUpDclRXZDhV?=
 =?utf-8?B?Y0dZY2pIUmFwQ0hxOTRJNDdIYUJZMmFUOEVEL1VhL25vOHRZdnI1NXVES1ZT?=
 =?utf-8?B?aExCcXJ6SFJkUmhiYnJ6bWF3YWs4MjgzS2g3ZER6bFRVZE56ZUpjUGNOblhM?=
 =?utf-8?B?dCtrUVE4eGQ4RkZEOHNyNG54cEpaNkgxTE9pVm5tNEN2NUdKc2VXR2JrYjds?=
 =?utf-8?B?VmhXNlRKMlM4eCtGME1Ccm5mOUhHSWNPY2t2Kzc1a2NLYVFrZDZiTkM1dUVo?=
 =?utf-8?B?Q3loODlYVUdmSnFuTWpnQnQyTVU5OWhaK2RpT0JaTmVaZUNUUXFaaTdwdDlS?=
 =?utf-8?B?MzlneHdiblBwZG5CVWNNMFNMNnlwQWtHblQ3TnZ1UGVUVVVRZDR1M2w2UDlh?=
 =?utf-8?B?R1pOZW1wQXp5RDRJbldyRFVHQlBDT0VaQ1FvdWFtT0FEbHZzaFVJeE1Qay94?=
 =?utf-8?B?R3ZEY2YzNUtYWW5oWW1SalRtUzFJUGFVODhYLzU3TlBXQWpVaUVnLzJ4QmVw?=
 =?utf-8?B?V2pWejkxb0xYc2RnZlZYRSswTCsxWmM1RkFMajJxRjRXZHRzemxMeTRjRmNs?=
 =?utf-8?B?OXFBZDFkVmVad1YxUWZzemo3VExac3A4aEdrdWM1dGJQTlZzR3dVMFhlQzBq?=
 =?utf-8?B?emMwZ2J2bDRZV3VGbFRvZGNLWjNjWnpMTjhtLzB1c0hURENFU3lGc3hHYW5m?=
 =?utf-8?B?QkdOVHo1WDlFcjZmWjArRURHcmRRSFp5SlNJOTBxUllrU0RjaldZWk1KY1FY?=
 =?utf-8?B?VGVIMHk2UFdlWGpTN1VkMktLQ3pUQW1OeWczUUhGd2pEeThoR3dBdyt5S1BW?=
 =?utf-8?B?dlh0QjdTVUtROUJNcndUck9INDI3VHdZSHNESHp1L2ZNaXNTeElqN2RXTlJF?=
 =?utf-8?B?RGdNbEowOWFLcEJFWWJyYzlEMUloZmhFVVNzdkd2YkZOd2p4VHRhWEpkaUFq?=
 =?utf-8?B?eDNHTHZkWFJvWTZOQnBFTXBmTWQvRy9jZjlIeW10NmYvbXFlb3M3NDl2cGNH?=
 =?utf-8?B?eWhZVzJtVFMyS29DZEFicTFSQ2toUkJ4VWlaaVZwZnZpN1dieTJzSGdoTG9X?=
 =?utf-8?B?OUVJUFIvTkdJMWtCNHlUSU9LQVIrb3l3Z0VIZ3paRVNGMXp4aWpYRk9xRWFH?=
 =?utf-8?B?K0pWU20yT09tNUR2QllZcFpnVXBCR1ZUSTlyR1lSU1VzMUw1c3VkL0lCcTFk?=
 =?utf-8?B?VlJSZy90NXc2YTFYR2tLYmVyM1A3S1J1aEx4YnhvOE45V0dhZ0pDTEhOWGF3?=
 =?utf-8?B?UDRGM0dxSENNUDJmQTlJNXcwMXk3U2RUYTFTSVpqZWl4eEE4dUJ6d1pQT3l3?=
 =?utf-8?Q?GDta89ajhu5aOzvmIaCzifNOu?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ade5724-6659-46a2-cf11-08db86e5dfa0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:50:06.1579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZ2XTP113RT/siPqqPa0yCEpZzY45z1NYsSHXIFi6ozMsAhsMHK9CNSu5NbcF8EfeJinWBVSq0twoI6b13LshA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9573
Received-SPF: pass client-ip=2a01:111:f400:fe1a::70c;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/1/23 12:07, Alexander Ivanov wrote:
> bdrv_co_getlength() should be used in coroutine context. Replace
> bdrv_getlength() by bdrv_co_getlength() in parallels_check_outside_image().
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 51fd8ddf5a..456a13bd28 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -496,7 +496,7 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>       int64_t size;
>       int ret;
>   
> -    size = bdrv_getlength(bs->file->bs);
> +    size = bdrv_co_getlength(bs->file->bs);
>       if (size < 0) {
>           res->check_errors++;
>           return size;
Reviewed-by: Denis V. Lunev <den@openvz.org>

