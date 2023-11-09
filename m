Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F31A07E6BC2
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:55:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15U8-0006Au-G3; Thu, 09 Nov 2023 08:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r15U5-00068M-U0; Thu, 09 Nov 2023 08:54:14 -0500
Received: from mail-dbaeur03on2072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::72e]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r15U3-0003pN-6H; Thu, 09 Nov 2023 08:54:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCV+Iv5TyivHhvgZtgF5uHYdRSvJ+aRY9PNtHwT9DQVy13LNAXW6wMry/emLw4joPoyfwdylG2vwuSShcuaD67JcSjWf0+/OUfjN0+ODN13WUDZJmlbuA1o/zMSJJvTvChZSUqCXCEn/bcl7Wo7RgqH7HmA5a33LUjl8VgZJCwv08wE1bSWuC7mCAUyhbepaai4+eVvyveWr460Kkupk8FIZcl5EyLNYGmkj3ZVCyW5iii6tIiowO3i1Db/EmaEUg9Cp11xxR4iLoGD9GlbcG2Z4cY1rQGkD2FhrVdweIn3jFbtODzuqz/p7SG21bl7NY5X5/QPpTU/r+xOdb/OBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Qm1CMauLgG88ucFQ9CsTbrwblcboTAgZHvhojWVk0U=;
 b=FJId6jiLmZ5Uo4dyvFlgKIo7WQLtMngoXMKIX9BknfwoY+pDY+v4UHxCl/4amSJjtjAPTrd74XktXTQMabcb+XeNNozCGLHkfpXQKKzoUQSntMk3lK6wBVbn+QzOZqsWcG1+Jl55liAgqwaTiHo5f5xs2EoojS8ZFECea0q39mM324o5pgpUjuiMsJDgM8PmCIX85Oz/MXT1c1DPdbG04Gj0RyeJyROlc0epFzeMx+MaqsqD7MIAbSWTNE8O8VRosBcZNLwBeJz+MDQU4tzzPlZCkt+RhfvlIdGpeCurEWMPJLXK+RhI72GmZ+ttbEhztB+ZNXW5/FpJTKY9CJGX3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Qm1CMauLgG88ucFQ9CsTbrwblcboTAgZHvhojWVk0U=;
 b=vuOugmmatXfkgn7IOy0Iy9obWiwRa/Z1b5F/LGFOd3v16G1k23g2Ja8OrwsfZhmPDNUSer5L7VF0kvjuSrhHoKoX4uwGrJ9YwXcc3JWj0oqw0mHzUK9KFUWO16Nc09qDFUTilvwMYDkc7lVQUwIFCpl9wGOG9nVgC6VHsJPHD7HKrQulZKmfVK37REG/4N89KReqAk9O9N4DyE6BPFhGSNA03aM9l5ytByFNpOVuCVaAQb0msQiXQ9R2JS0qOz+Z7El/T5yWpoIsLh8MGURgZeaebJkGdJMVWYQg29iVAfk8xKU5+hefgwuw1CRlZbfX/7maagmQbHqHqXk3pQg0Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PA4PR08MB6288.eurprd08.prod.outlook.com
 (2603:10a6:102:f3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 13:54:07 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352%6]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 13:54:07 +0000
Message-ID: <59f3903e-e9a2-45cb-bd5d-49d2d46af945@virtuozzo.com>
Date: Thu, 9 Nov 2023 15:55:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] iotests/271: check disk usage on subcluster-based
 discard/unmap
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-8-andrey.drobyshev@virtuozzo.com>
 <90298f38-fe14-4659-87a3-9b4bd2f516df@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <90298f38-fe14-4659-87a3-9b4bd2f516df@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PA4PR08MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1acf91-8854-4cf0-42f6-08dbe12b5755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vp05/jqls+Z5vlfI+r7LbSRkVQMgRSHT4zRMogFoI0N0YqtEWiZvoMTmgRUq7eWgISxWsT8xTm46ftNX7eq1UCQYwJWBY2XiwQXvo+VAT96sEvU5sVqfcl5R3pEYIwDQqY8m5xoLlHRux+yDLKFJOwL6KRRIMHqXQTe+JGyfagd24nW0jTgKgCW120d5fccMkMAXk4ZCaa1ucqkHYcubVC+peo+PFPR7pXbU2cpy+iI8zory3SkcY7+wUc4AWty4fvpiTTvGF7Tudg5hPPu6HoecWABBCDIb+V29LLvSp7xywX2cmxRQtPyQdL1tOzbpAtSE85BQbAR+dURpqz46j24xJNuR/OZZVqRYyTLKZXABSlb5F+iBITaOY+iwd+oH3sk5b5DkZcd4FXw1MS70HaEWqQxOZqGeRavai49EtV8OyXhPrxFF9fFyvWSreVZqQNtkxK2pwgmNWvWxucIhl50ouijfZhKHvq5EKSqUwIBQgeLTqJMDOdMKuTh5aCJV6s4SzHScx04QpuAhbRWk0EJbMN0Z2dM708Q/s0AUZ0+Fb11uU12hHZnnh73i3u4CFo4VGa9Elizq4Eel1/Xibwu3FDXNjgwSYt4d4/AHPj9OsRm1R0mJviR241cOUJixHC+dKqPoIwaeq+kfZBzj8Xpc9jJ+MYvGajsTLgMFwxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(39850400004)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(86362001)(6512007)(31696002)(66476007)(36756003)(66556008)(6506007)(66946007)(8936002)(8676002)(38100700002)(6666004)(55236004)(4326008)(44832011)(53546011)(26005)(5660300002)(31686004)(316002)(2616005)(6486002)(107886003)(478600001)(2906002)(41300700001)(83380400001)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnpndE5xL2krd0FucDdwMjh3akRLUXB2RnBiSkU5WUI1TVltRUJzSzB5YXN2?=
 =?utf-8?B?YzFzSUdhNTN6VU82K09VRlhEb1EvZXVCSW1HOUgxamN5dTY2N08wN29ZME5S?=
 =?utf-8?B?SU8xdW5DRGtFdmZ6MDgwT2l3NUt0TU8zZlVMandsb2FtU1BDQWwya0dZbTlt?=
 =?utf-8?B?YzJSbnRnQ01mbVZ6Tmh4WmlzeE10QWl5OFNzTFhWcGNKRGgxbFQ0M2ttSEJP?=
 =?utf-8?B?K2ZlWk00TjNwVGQzQjc3VjRNQ3QwRkkvOXZCNk91WDlOV3cwMmxvR0NVWFRm?=
 =?utf-8?B?dG50OFVnRFBZSGVDRWJlcTRVd3F2bGJIemdtUHlLTThxQzQ2VlJzcGg3N1Fl?=
 =?utf-8?B?QTdsSy9XV0lOemprbkJYeGlzQkxraTVYb21ybXBxNXVHTVNJdXArM3RCSFlW?=
 =?utf-8?B?L0FDNFh6aDBGckdUM3orbVU2SUo0UmVJWE1VYjNwQkllakI5bzlQVFo4TUt3?=
 =?utf-8?B?UGZUYnMvZmkzaWltR2VhSlBJMHEzU2N5ZVNjWjFiZGhhSTlsU0NPai9Kc0dr?=
 =?utf-8?B?a0lVT1hzM3NvVFZpNWpGakRoYkdvNnd2NkkxaU5yQ3N2L2JvY2RiWkN1cVdH?=
 =?utf-8?B?cGxqdFZ1YXhlMzU4ZmpENWpDVHVpZUhMaVI3OFBlNlpVY3BSOHAwQkFjaUpm?=
 =?utf-8?B?U0Z0R2ZZdzJzeTd4eEtLRWJtenM1OVFvWFVjVmZBdndKUHJKTEFRdmFqaTIv?=
 =?utf-8?B?TFpzdWl0QXR3L2FLVXZQeEttbXpLTzY0T21rbG9qVkRzL0QrMkpNQXhlZDRF?=
 =?utf-8?B?aWlLMkJMRjZ4NmFEWmEwUXJFVExLZ2JRbUZDUitXV2lydUU4Qzk4M1JEU2dk?=
 =?utf-8?B?RTNlU3BuWXVneGVvOVBDVER5aGtRMmQzb1EyM2NndERUbzlqM2JRRFBzRzVZ?=
 =?utf-8?B?T0JzWm9RWFNPY2xzODUwVE5UMnpqUE1MT0N2U1AwVU8xMUdyZ2wxRm1uYTl0?=
 =?utf-8?B?cXNpeHdLOGN2OEpEc0JEUmNwZlN0UGRCbGlKKzBFV2QwWlN4TVBRdkpSOHRB?=
 =?utf-8?B?RW5uaDdZazRmVTJGb1F3bGNLRnYycEgrVDZHenJkWVlKa0hwV2s0V2VPY29y?=
 =?utf-8?B?dUt1KzZPKzJWVXJibkQxS0RnUTYrV1U1SCtTUEdPS3BtVW0rWmJrczlIemRC?=
 =?utf-8?B?TzIxc0ZtV1ArSFpjY09EUlI2bzc1OXAweVJDUEtJNS9VSDVmbHJqMFhyS0t3?=
 =?utf-8?B?WmVleXVlTHJIV21uaTVTWGY3RlU3U1BFOXV4cVFlQW85NmVjNm9EVUI0c01G?=
 =?utf-8?B?UkF4am9JRDcyTmMwY2h5TU9YUkd6T1crM1ZQektNbUtqRWZ6T0U1a2RzSndC?=
 =?utf-8?B?ZDdveU1RMnNvN0dhT2swV3A0ZHI3RkVLYVU3YXB5ekU4YnU4WitJYk1SVWNX?=
 =?utf-8?B?MlhYdlVQRW40VForc3pyNFhNUm52R2lWbi9tUEIycE9kdTBrOW9jbkZ5RGd6?=
 =?utf-8?B?bEF4TnhCbmtkcFFqcmhLM0Z3b0lnQzh5NFlmamltWHRrbDdBNEVQR01JL1U2?=
 =?utf-8?B?aXBwUTIvU3lVUm0vLzlsMnhOWVc1TjcwQUt2TzFqM1ZTWWxvN01RNzJ0ZzVF?=
 =?utf-8?B?SDJMa1I2dXNRaEh0VHM2RG95NHNYeWNTTjFDeFFTNWVEMHZzM1JKd0tWVjZV?=
 =?utf-8?B?Z2t0aWJzNCtIbENjUklJY1FFckRnaXBQRHBBQ1d5MlRlb0JUdGcrMDV1blpC?=
 =?utf-8?B?OEQzeEszaDhwc3VQb0hZRDlYbUJiWnhTWk9vbkxubENLc09QRytkR1FxSjRO?=
 =?utf-8?B?NHROZDMxVU9mMzJIYThuUFNOczJQblM2Q3Zjc3NpdzZDbjkyeFRxZnJoRThI?=
 =?utf-8?B?TzdUYzRaRHREUERoMnRwL1ZFQk5LOWFkSGF4VkVaSFh3WU9SR3ljcGFYWkJP?=
 =?utf-8?B?cnFENTEweUo1cjBEUS92WGJOVDI4YnZ4dFl3clA2RHJBYUpTN1B0Q1dzVjlC?=
 =?utf-8?B?bTFKMm1kK1dDZmhNSG1wR2JvSlpVVEY4L3dwd2ZNTVB1dG9VaDBpRkJpcGV5?=
 =?utf-8?B?RE5BVUx4RUg4UjF4NkR0Um9jS1FaL2dpSUlxWGxOWGJuZ3BLRkxWQzZoWXor?=
 =?utf-8?B?YThINElZU0F3OXc5TDYwMkpWTFhqNit2M2NmMU1GTWlaZFhGaG9vRlpzbXEv?=
 =?utf-8?B?VGtoWmRKUm10aGFwajR4L00yaWpTL3plaGd1NklmRTM4RWxocDI4ekpiWlda?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1acf91-8854-4cf0-42f6-08dbe12b5755
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 13:54:06.9532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jHpIgnN5q+TK5yOb5IP3uQ/19rhULcDsBZBSVpOhUiBzvRQogmksMy/WHkHORGgD88YIC9N+Gjsif/L+k1cN0+hHWxi16kddbo98Ol6Mr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6288
Received-SPF: pass client-ip=2a01:111:f400:fe1a::72e;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/3/23 17:51, Hanna Czenczek wrote:
> On 20.10.23 23:56, Andrey Drobyshev wrote:
>> Add _verify_du_delta() checker which is used to check that real disk
>> usage delta meets the expectations.  For now we use it for checking that
>> subcluster-based discard/unmap operations lead to actual disk usage
>> decrease (i.e. PUNCH_HOLE operation is performed).
> 
> I’m not too happy about checking the disk usage because that relies on
> the underlying filesystem actually accepting and executing the unmap. 
> Why is it not enough to check the L2 bitmap?
> 
> …Coming back later (I had to fix the missing `ret = ` I mentioned in
> patch 2, or this test would hang, so I couldn’t run it at first), I note
> that checking the disk usage in fact doesn’t work on tmpfs.  I usually
> run the iotests in tmpfs, so that’s not great.
> 

My original idea was to make sure that the PUNCH_HOLE operation did
indeed take place, i.e. there was an actual discard.  For instance,
currently the discard operation initiated by qemu-io is called with the
QCOW2_DISCARD_REQUEST discard type, but if some other type is passed by
mistake, qcow2_queue_discard() won't be called, and though the
subclusters will be marked unallocated in L2 the data will still be
there.  Not quite what we expect from discard operation.

BTW checking the disk usage on tmpfs works on my machine:

> # cd /tmp; df -Th /tmp
> Filesystem     Type   Size  Used Avail Use% Mounted on
> tmpfs          tmpfs   32G  2.5M   32G   1% /tmp
> # BUILD=/root/src/qemu/master/build
> # $BUILD/qemu-img create -f qcow2 -o extended_l2=on img.qcow2 1M
> Formatting 'img.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=on compression_type=zlib size=1048576 lazy_refcounts=off refcount_bits=16
> # $BUILD/qemu-io -c 'write -q 0 128k' img.qcow2
> # du --block-size=1 img.qcow2
> 397312  img.qcow2
> # $BUILD/qemu-io -f qcow2 -c 'discard -q 0 8k' img.qcow2
> # du --block-size=1 img.qcow2
> 389120  img.qcow2
> # $BUILD/qemu-io -f qcow2 -c 'discard -q 8k 120k' img.qcow2
> # du --block-size=1 img.qcow2
> 266240  img.qcow2

I'm wondering what this might depend on and can't we overcome this?

>> Also add separate test case for discarding particular subcluster within
>> one cluster.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/271     | 25 ++++++++++++++++++++++++-
>>   tests/qemu-iotests/271.out |  2 ++
>>   2 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
>> index c7c2cadda0..5fcb209f5f 100755
>> --- a/tests/qemu-iotests/271
>> +++ b/tests/qemu-iotests/271
>> @@ -81,6 +81,15 @@ _verify_l2_bitmap()
>>       fi
>>   }
>>   +# Check disk usage delta after a discard/unmap operation
>> +# _verify_du_delta $before $after $expected_delta
>> +_verify_du_delta()
>> +{
>> +    if [ $(($1 - $2)) -ne $3 ]; then
>> +        printf "ERROR: unexpected delta: $1 - $2 = $(($1 - $2)) != $3\n"
>> +    fi
>> +}
>> +
>>   # This should be called as _run_test c=XXX sc=XXX off=XXX len=XXX
>> cmd=XXX
>>   # c:   cluster number (0 if unset)
>>   # sc:  subcluster number inside cluster @c (0 if unset)
>> @@ -198,9 +207,12 @@ for use_backing_file in yes no; do
>>       alloc="$(seq 0 31)"; zero=""
>>       _run_test sc=0 len=64k
>>   -    ### Zero and unmap half of cluster #0 (this won't unmap it)
>> +    ### Zero and unmap half of cluster #0 (this will unmap it)
> 
> I think “it” refers to the cluster, and it is not unmapped.  This test
> case does not use a discard, but write -z instead, so it worked before. 
> (The L2 bitmap shown in the output doesn’t change, so functionally, this
> patch series didn’t change this case.)
> 

From the _run_test() implementation:

> # cmd: the command to pass to qemu-io, must be one of                           
> #      write    -> write                                                        
> #      zero     -> write -z                                                     
> #      unmap    -> write -z -u           <-------------                                       
> #      compress -> write -c                                                     
> #      discard  -> discard                                                      
> _run_test()

So it actually uses 'write -z -u', and we end up with an actual unmap.
I agree that the l2 bitmap doesn't change, that's why I specifically
added disk usage check to catch the changed functionality.

>>       alloc="$(seq 16 31)"; zero="$(seq 0 15)"
>> +    before=$(disk_usage "$TEST_IMG")
>>       _run_test sc=0 len=32k cmd=unmap
>> +    after=$(disk_usage "$TEST_IMG")
>> +    _verify_du_delta $before $after 32768
>>         ### Zero and unmap cluster #0
>>       alloc=""; zero="$(seq 0 31)"
> 
> For this following case shown truncated here, why don’t we try
> “_run_test sc=16 len=32k cmd=unmap” instead of “sc=0 len=64k”?  I.e.
> unmap only the second half, which, thanks to patch 3, should still unmap
> the whole cluster, because the first half is already unmapped.
> 

Agreed.  And the interesting part is that here we'd be calling 'write -u
-z', thus following the zero_l2_subclusters() ->
discard_l2_subclusters() -> discard_in_l2_slice() path...

>> @@ -447,7 +459,10 @@ for use_backing_file in yes no; do
>>         # Subcluster-aligned request from clusters #12 to #14
>>       alloc="$(seq 0 15)"; zero="$(seq 16 31)"
>> +    before=$(disk_usage "$TEST_IMG")
>>       _run_test c=12 sc=16 len=128k cmd=unmap
>> +    after=$(disk_usage "$TEST_IMG")
>> +    _verify_du_delta $before $after $((128 * 1024))
>>       alloc=""; zero="$(seq 0 31)"
>>       _verify_l2_bitmap 13
>>       alloc="$(seq 16 31)"; zero="$(seq 0 15)"
>> @@ -528,6 +543,14 @@ for use_backing_file in yes no; do
>>       else
>>           _make_test_img -o extended_l2=on 1M
>>       fi
>> +    # Write cluster #0 and discard its subclusters #0-#3
>> +    $QEMU_IO -c 'write -q 0 64k' "$TEST_IMG"
>> +    before=$(disk_usage "$TEST_IMG")
>> +    $QEMU_IO -c 'discard -q 0 8k' "$TEST_IMG"
>> +    after=$(disk_usage "$TEST_IMG")
>> +    _verify_du_delta $before $after 8192
>> +    alloc="$(seq 4 31)"; zero="$(seq 0 3)"
>> +    _verify_l2_bitmap 0
>>       # Write clusters #0-#2 and then discard them
>>       $QEMU_IO -c 'write -q 0 128k' "$TEST_IMG"
>>       $QEMU_IO -c 'discard -q 0 128k' "$TEST_IMG"
> 
> Similarly to above, I think it would be good if we combined this
> following case with the one you added, i.e. to write 128k from the
> beginning, drop the write here, and change the discard to be “discard -q
> 8k 120k”, i.e. skip the subclusters we have already discarded, to see
> that this is still combined to discard the whole first cluster.
> 

...and here we'd be calling discard directly, thus following the
discard_l2_subclusters() -> discard_in_l2_slice() path.

> ...Ah, see, and when I try this, the following assertion fails:
> 
> qemu-io: ../block/qcow2-cache.c:156: qcow2_cache_destroy: Assertion
> `c->entries[i].ref == 0' failed.
> ./common.rc: line 220: 128894 Aborted                 (core dumped) (
> VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec
> "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
> 

Yes, I should've added qcow2_cache_put() when going
discard_l2_subclusters() -> discard_in_l2_slice(), same as I did on the
zero_l2_subclusters() -> zero_in_l2_slice() path.  Thanks for catching.

> Looks like an L2 table is leaked somewhere.  That’s why SCRI should be a
> g_auto()-able type.
> 

In this case this indeed makes sense, since when we extend the operation
from the subclusters range to the entire cluster, SCRI is no longer
needed.  The only question with this approach is the
zero_l2_subclusters() -> discard_l2_subclusters() path.

> Hanna
> 
> [...]

