Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 222787A4572
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 11:05:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiAAF-0004k3-TI; Mon, 18 Sep 2023 05:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiAAE-0004jl-G5; Mon, 18 Sep 2023 05:03:30 -0400
Received: from mail-dbaeur03on20701.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::701]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiAAB-0001Re-UZ; Mon, 18 Sep 2023 05:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmkurA9qLgCmxOLUobv55P4lrCfQYpu1zhSzU2U2crD0f7GgIXp+732XdIlneAft3ZZNbSaZh/Pl76r37VqidDoZjlLqrLB7EnryAf/10UFLdHfsVSq1BgZVVHtx/KrC3cmpoUKDZQ6Q3tobTllst+fAk+pdO8kUqmn4mSbkU4ZUITxHDL7Tc63GvgxsyCVX9OM198iW3E09wJt/geGEDxmWK98t2e5f4aBwHOd6VIvqBYnJ2ppa0eCrymDUqLOQGEP30sgxznIBWHSCIcPX7i8eRhAV/vbuVNRsbGN5cwh/Vvs7GsarOuIOMDAoXl5eL5dYBM7PwHMNIu66DIsnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrwRP782QWzxLW7heUbiM+8mRWdW5v9EIUCPAYnFf3g=;
 b=XqVlSDX/V6oMaR7fPJ5T0pByfjjivP2oePqOePMS6k+sNtTyUdNpl+OQY/htL+jGm1k07+2dg9GxQRiQ33Zio0ghFPaFvJRvdM1xSoFfAFCGTojk9o+gsnwWwNJn1b08q+oDGTqDWAARdWSIlJxMgucLm4EiY4i7JPxfyGvO8lQNdeS5+MdYW7JruFWXaTooYVDbDUKaMF95Iu5SRkPVFzgMJS/MPy0RTjUi+MCSHTQ4deiBSWxDLziHlFy2wxoypREeCVZGlYBR/vwK4RrtdNuGVfFgvjy7dSZcc4gj0/Lbr4zulJPDSrYP6+N9eEocs/9ns2ZUXIaOuQZ+9uKnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrwRP782QWzxLW7heUbiM+8mRWdW5v9EIUCPAYnFf3g=;
 b=xYrhrx5IlOEXA7CVNZzDi2RKmrPg6WjT70nLq9NSwk3DiN1AU4Oe6DwNMQUCjkXmHKiKQBZ9aOHlcerTyy4B79bzZkIi7iF6E4jeXlfr2uo2S/7dB6s5HW0bCpw2Xi8wqlWfgJ1ZCxWP70mejY8fL9uLJQ3xbGkkzxhm/V/O+K16UumaruEQBFMgYtkYZ0axx7f21ILMJ2J5CrQuODN1MGS0PUsjcomwO4PWi/UlaTPOF9b2Vzv56OhL57NGd6WH/8iJNx4Nhpoqen+hKccp3Smumu0L72VB1f/JPC1Ynv60OmDuejVYoVE9ozC5zV2tNzsmPGkhDBP7K9uNpNe71A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by GV2PR08MB8678.eurprd08.prod.outlook.com (2603:10a6:150:b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 09:03:21 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 09:03:21 +0000
Message-ID: <b1ce9640-fc5a-ee2f-ab53-0e75e8dbef61@virtuozzo.com>
Date: Mon, 18 Sep 2023 11:03:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 08/21] tests: ensure that image validation will not cure
 the corruption
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-10-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-10-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0042.eurprd03.prod.outlook.com
 (2603:10a6:803:118::31) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|GV2PR08MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ae030c-50f5-4fff-e6ac-08dbb8261b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XMjQeYEqQNUvIR1keG912A3C8tmIXtE0ntl5Ks9IlWB5lYu0h2oOYjXS4x1aYTJ/NVkc0DpFhDn1Y9QXdohjELxOLYUeGfrS6kzHbQmkebGCQIZ8acDaemLd+qSDvpx6r+DKIsVwKrXvgwoxksnbaBX6Pci2at5dcX7ZvWGADrILWb4CyMPQg+7ptzjQp5gPaIVc16rDKozTv278t2QhBhWAzhF1avUxClaOl8zE88Zk4W9bsMG2RjeHiSA51FITiKwSRSZbCDj+rJXTp2US6BEcpjprAzDK7gMPom4a1pwjciRKzSkMb9fauArAl/LiTinNgubMyhrzT65uCXR4C19KvXK7xa63zmNJv4hN/HL8896A5pXf97K2X0TYjV6oRMTOcbhHBbhSUlLi8TbzeuG1ATX08VqldxkqWYX82+AYIwhphz3TXt0yuSTG+D5Fb3A2EukXy5AIvB+f3Drh7A/v5+Fu2o9ankThaBj1ALEOgjvHT8vymLKTetoqX+o0NvZ1FaK78PNtAo91lPuhomal+8ubp8bXlUIxZPUDVZLqjwAxWjbTNw8RUDMlkh7gV1ozYOaBQQ65hKB2ZR7DHwRS7vk0+HlWfN2o2ksseI32UHwF4l+dp5iG0Cdoya2h1J+ey1NaIHdBMS8EMCrOwqsr7D5HziTh5DaLcZQ6bulpRL1cVt+iqbWKkooG617
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(136003)(366004)(396003)(376002)(346002)(1800799009)(186009)(451199024)(26005)(2616005)(8936002)(8676002)(4326008)(83380400001)(2906002)(36756003)(31696002)(5660300002)(44832011)(86362001)(52116002)(53546011)(6506007)(6486002)(478600001)(31686004)(6666004)(316002)(6512007)(66946007)(38350700002)(66476007)(66556008)(41300700001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW16c3RHSEFSRUtQM2NrSXRUNmw5NksrNko5WGFGWkZibHFKcDFBT2xmNExB?=
 =?utf-8?B?bzVYTWdZcDJGeU5VUy9keXhVOW9iL21xL1JzTVZiVU14RWpUZ1BGVmZERG9o?=
 =?utf-8?B?TUhxSlc5bVIvK0pEdFVYd0pUM2F6M2g1ZG9JYlNNaWVqamg1alRUZWIyRWNj?=
 =?utf-8?B?OTJnS1phNXYxeitDTzJIK25JOUZYMU5kQlFXSy95bUQ0QWFVYW5ibU1TcC9U?=
 =?utf-8?B?TGRxOC8zeFNzb0FoNmhKTElVWFloai90b3RXVHR1VkpEeVFzSGRxZ0pORFdT?=
 =?utf-8?B?dmlyTTNNQ0F2QXMxRUZWY3lFclZJMVdHOC83UXBEZVVPV3Z1YW5MWVpnRnk0?=
 =?utf-8?B?Tkx1dGV6aUpJZ1pSc2lCMVRRRGhreWhrOFUvVm9yS1FNOHRXdUxGelBRVTNU?=
 =?utf-8?B?TCtwRVlhVksxZzFmalFZb1JDdmFpV0hTY09RclZHZ2pnSWtHYkpvSjhkQTJn?=
 =?utf-8?B?Vk1wSytoUTlGL0kvSjVoT05acnFBMGNXZkhrZkZBYkdkY01qVFhBMGhvMmwy?=
 =?utf-8?B?cU5qUG01bTNtZ2pqeXVPNGZuMlg2b09VZTBUc0V6cm5GYWlhNGIvN3lxakNK?=
 =?utf-8?B?clJXN3RabFNlQ3Y2MmZXNjk3ZFlFMERxTjUvSDk0cG9MdHRiSVJmcGNGcGJQ?=
 =?utf-8?B?bHlUK0JSNzZ1Qk8zODVmTmJEN1YxMHlkd0w2bVFhM3RDeWp0MGVCQ095YmVP?=
 =?utf-8?B?c3piS2dJZWppUHRjYlo5R0tDbDFBYldNblBrcTB5QjJGVlZwV0p5c1NHL2N1?=
 =?utf-8?B?ZmN3emlnbndTdXRoUU14QVgwSzZPWFZ3M2ZISkxlZUlTaGVCSlNmM1lNUVFH?=
 =?utf-8?B?WWhYRndhdE1UNGl3c0UrbEYxL1ByekZDQVkwY2NyTit5OFhhRytPTUJMb1Vw?=
 =?utf-8?B?di9kMjhOV25scWQxMzJ4UHhkM29raVgxdnNjd0d4YzNQNkQ2a1U2a0hudjlx?=
 =?utf-8?B?cEIyUGJ5TVVndFp6NjJVOEcxRFJ1Z0Uyc0t3QXZCVjZSUmtRWUtxUWc4NUhH?=
 =?utf-8?B?N3Q5VCtuUllydjZwWkVabnNVaTltaldIWUJ2d2U5OEZocGNQRHhPcmttQk12?=
 =?utf-8?B?M0xyK1NBWStjSUgvc3JzTnI5VGdKSGJVWCtJZUM2V1RBR2U0QkxBLzBoUzYr?=
 =?utf-8?B?RXhGM1RWMzZVVStKK3JOM010UnpaZlFDQ01pUUJOSXlSY0ErWVRSaXJscW9Y?=
 =?utf-8?B?dlN1d1YyUGlWQW1hZFByTWk0N2lEdFp6WExmcUVpODh3dkVlckVMMXJlL3BD?=
 =?utf-8?B?aDZlRndhZUxPUk5YRUx0S2hwRnFSaWwrMjJ3bzZLNFh0MUhBSmN5cVF3Vnhs?=
 =?utf-8?B?VkdxS0xSZEIrRnRmdmVxRmxMMXozODNOcm1tYVl3REdTNjlmNEZ4K1lGTXVz?=
 =?utf-8?B?VmxPTElpbDFoZHNBem1XSzlzTzdyZXNicGdVZVBSWEtDV1ZqWEhlVmIwYXNK?=
 =?utf-8?B?TWlTSTVXdFFnMmd3WDdOTm5uVlI0c3l4dVdnbGhNUzFiU0hubmpRVFVxWFdv?=
 =?utf-8?B?R0s1QVVDUWlKUGJWWU5yanI5NlNJNW41K3dNMk9lZE0xL2pqSEp6dUUyNFVm?=
 =?utf-8?B?YWlDSEJJSzFUU0FBd0xmZEtPay9qRTZDanhWeWlCTHIyY094bDlCbU5OUDNT?=
 =?utf-8?B?bFpSQjlKaXZUL2ZCaHY2QzI5ZHNvWkxXYXI2SjVKMzIrYkp1eTQvbVkwaXFZ?=
 =?utf-8?B?T0NQc1FUVTF4UGtSZEl6UDNPT0ZwYWRIelhxSlFtbTBMWXRoQldEbzF6M3Qy?=
 =?utf-8?B?NnZ3bE8xNVNJZHI3TS9XTG4vSHdVdCtQNmNJS0FrTG1PazJLOFBJdlBKdkR3?=
 =?utf-8?B?TmdTOXEvMEc1ZFl2dWQyZ3dCWVdIYlpUc25xaFpNKytvTXk2Rnhlb0NyR004?=
 =?utf-8?B?TDU0bXRpelpOdmkzbUt3TXVhVG9tWWxlSW5HMWdVajQvVTdPOFN1ZWEyL0RQ?=
 =?utf-8?B?eGR3WGtKYTlIL2hJeHcyUEpWdmRsTU9xY0hJQjdjNHB5cytjNUlKZFJieWpB?=
 =?utf-8?B?UWgvbUs5ZkxjR1NiSldYTGw1Uy9PaHNwYUppL2N0Q2JLVjZLNm5RaDd1d2RM?=
 =?utf-8?B?aUI0ZWR1dVlxYkxFcWd2bk16Y2dTSXF6TEM4dGQvNWNMSXg5d3FmOVo5Qjln?=
 =?utf-8?B?S3pEeWZ6aVN4djZNMU9vU2ZYbXRBUWlvMHRLckNFT21xM3drT25oTHdwNS9t?=
 =?utf-8?Q?hYxQvCla+0QGi/HRQ9PIIhs=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ae030c-50f5-4fff-e6ac-08dbb8261b74
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 09:03:21.2926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fg4PKhz1NFqU4915+UETIIlUnJIIvoWca9hS93cc1w5PxTjZuMowNct2RAIH5a7FuRROGyVWrpsW6wAuiSSEpkzOk4Sq8B7HnUMh9f2nIXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8678
Received-SPF: pass client-ip=2a01:111:f400:fe1a::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/15/23 20:41, Denis V. Lunev wrote:
> Since
>      commit cfce1091d55322789582480798a891cbaf66924e
>      Author: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>      Date:   Tue Jul 18 12:44:29 2023 +0200
>      parallels: Image repairing in parallels_open()
> there is a potential pit fall with calling
>      qemu-io -c "read"
> The image is opened in read-write mode and thus could be potentially
> repaired. This could ruin testing process.
>
> The patch forces read-only opening for reads. In that case repairing
> is impossible.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   tests/qemu-iotests/tests/parallels-checks | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
> index a7a1b357b5..5917ee079d 100755
> --- a/tests/qemu-iotests/tests/parallels-checks
> +++ b/tests/qemu-iotests/tests/parallels-checks
> @@ -91,7 +91,7 @@ file_size=`stat --printf="%s" "$TEST_IMG"`
>   echo "file size: $file_size"
>   
>   echo "== check last cluster =="
> -{ $QEMU_IO -c "read -P 0x11 $LAST_CLUSTER_OFF $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IO -r -c "read -P 0x11 $LAST_CLUSTER_OFF $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
>   
>   # Clear image
>   _make_test_img $SIZE
> @@ -105,19 +105,20 @@ echo "== write another pattern to second cluster =="
>   { $QEMU_IO -c "write -P 0x55 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
>   
>   echo "== check second cluster =="
> -{ $QEMU_IO -c "read -P 0x55 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IO -r -c "read -P 0x55 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
>   
>   echo "== corrupt image =="
>   poke_file "$TEST_IMG" "$(($BAT_OFFSET + 4))" "\x01\x00\x00\x00"
>   
>   echo "== check second cluster =="
> -{ $QEMU_IO -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IO -r -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
>   
>   echo "== repair image =="
>   _check_test_img -r all
>   
>   echo "== check second cluster =="
> -{ $QEMU_IO -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IO -r -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
>   
>   echo "== check first cluster on host =="
>   printf "content: 0x%02x\n" `peek_file_le $TEST_IMG $(($CLUSTER_SIZE)) 1`

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

