Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BBF738E87
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:24:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2US-0003yn-DG; Wed, 21 Jun 2023 14:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC2UQ-0003xe-Nb; Wed, 21 Jun 2023 14:23:34 -0400
Received: from mail-dbaeur03on2070c.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::70c]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC2UO-00064R-Sy; Wed, 21 Jun 2023 14:23:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR/e2Mssz2/dh2c5yfOE5pzYtuHg+ik9NQtherYI6C2WygeiZXJL4XrOvLZrxN/krCD7rGs9CdzV3zdT+cEgpsP106YLesAZHueatphtktCbzdsb9M8hK3rMS26YTJJEscVoDmNMus+IrSO0mQtqChBKk0Ik6SF+odRFXDr0ug1JUZMP8+vaQMKwmcFwQM88UZmzsCE7mY+UNfYeUVWzahXZhcJC9IhTumrgLjRWmeUE6vxELYgrAZVssIlzZ+1xy5rPPzxMx3jq2P5855Wyk1U2sOEKFcK6/7pGFGP9Ye5LQT6tQjEZqDMk1WgeRIDiH75s+JEHjDxoPAhcJVYB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irx8eo9gDzx8mrVmvaPmZwG/D8Rg5SKLOI4C5L2phkA=;
 b=CsV9a7nNxeSW0V/SXghSrHaPEIwuDEOALJi1Qt73m/aXsUHrhT23UNkA3EHsbuZ7rGZ/V/S87fR6C0o+CWqc02vtmpNHxKKqdSeXKNEshEK/5NEpDA6+yaF61G8yEloCsaURk12MrV70o1bUu7f+3NH4waqPcLzhQzw9UXuCuqmeNiwiuzCTmm0+NYPruq/4KZ45dtAG+wlfyufFvyTxzkq0/1pofHn2OdBRWWs9Cp9DDD7vldbjikEJdxl/KNBMAKA8QqKCtaoaNZX5O0Q7ALXbIfpuAxkF6mA8AbtPyviX6xmtdY+W13ICpWWZJ4U4VHXBhVjPBd1pQCcyG/hlPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irx8eo9gDzx8mrVmvaPmZwG/D8Rg5SKLOI4C5L2phkA=;
 b=MZlaryJcIlKjfsMwBlDgUfxEvu7h/MEtr+WkNnX6MFvS/FneTropon3nh6D4SHO7zHND6cTWlAKMDgMGEREEZd+NMbqyIxh37iBnUrRcNTTGj7NrvR753bJwE3Ht2r7jUf4vDA8/xOUGVX6c9jGAUZjWpMQi1pKRdE7YZAEBknBubLngLI72NwinLRDdr6p3TxW80xIkslObUFf2A9gz5cXMLHf3GDyZsCaxNlO6L5q/Ytcstrvld9AgYXGEUUDXZhti0Y7QOoRQPoyh59xXUnMfoZBf4Fy9vV0fBNS4H1iGgojpxJiKSICVTkFOYIP90MGUU0xAmcxSsiDIHb4iqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB6946.eurprd08.prod.outlook.com (2603:10a6:20b:345::17)
 by PAWPR08MB9806.eurprd08.prod.outlook.com (2603:10a6:102:2e2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 18:23:28 +0000
Received: from AS8PR08MB6946.eurprd08.prod.outlook.com
 ([fe80::1e80:70d8:d23c:9b65]) by AS8PR08MB6946.eurprd08.prod.outlook.com
 ([fe80::1e80:70d8:d23c:9b65%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 18:23:28 +0000
Message-ID: <639f8a34-89a6-f8c1-99bc-180857837b22@virtuozzo.com>
Date: Wed, 21 Jun 2023 20:23:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/6] qemu-iotests: 024: add rebasing test case for
 overlay_size > backing_size
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-3-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230601192836.598602-3-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::27) To AS8PR08MB6946.eurprd08.prod.outlook.com
 (2603:10a6:20b:345::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB6946:EE_|PAWPR08MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd2a338-08e7-45d7-275f-08db72849be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PUXWZFYro0In2Bz4LcQwSOcbrNcjXR7N+H/upfpRgN77saBC80lPwkFyrmTODLfw9T0tnbvUaCjA968bZvux/9KgIw8TEBMEebWyP5r8DzsSecQTRusedOl1nPGtCV/mMGODiSjKcxZr0W2HnIrD9wYmwrbzkuciPNYqLbQHFRQgi+RQRZ5GM6k36Bl1GLCiRHDiW56GTlzhkwGM/wLe+MdshEZWLLs5BDXWHqXsKeL9cuNl7PdsntXStMxiefUbtcYKUYf3pmXu3bhd8pJGqcn3ctFjxZUpXWGED98ExoyUOujAdDevvXgdonq0V6/mfZkTeWvsFh/LGTbbTt/mtj8199C3O8yUxRxG4Azce8ZO1HHZKEQTHT4TQhU2uwlV8vqKov6h6vElePKZU6Qtn41mWlnNr4qp7tjnaveQ7C7+RlsDybiGPKDn5z2PDmJVgqAy9+VJMb+PA/Luhg6LtBFfOnq7j46Gtz3cltPT8uPN8BG9LwhX8z/e0r3agY4lfa9OIIESYBli0QAnhj73aRail5tmrmg2z1ZiDvABFTQ433HuoyxRAaZuhfMCX21oIVJFf5rWMDGvtKacf5MGiHw0C1jtlxpm5LWwMJONZbC0wW9qo2OCYx+Coy4YBpPn4nuS0qxvhOZ+UTLCMMnFU1Zo2K8utOrCTSllPLSo7ZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB6946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39850400004)(376002)(396003)(366004)(346002)(451199021)(5660300002)(31686004)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(41300700001)(2906002)(6486002)(478600001)(26005)(53546011)(186003)(83380400001)(6506007)(36756003)(2616005)(6512007)(38100700002)(86362001)(31696002)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTV3SHBRWWs3N3dJYXczVHdwd2RWOG5hSTdQbEVVNEV0OXl3MUxrVTl0SnJo?=
 =?utf-8?B?UUVqem4wQ1RmTnVCRXZIejJWbjNXc00zVnk3ZE9zR3U4YXZyN2hZS0x3TUpX?=
 =?utf-8?B?c0U1NldsM3JqbmI1eC9uUk1XK09HY2xUWitwU3IzM1I4N0NtajhuNjJZYzhM?=
 =?utf-8?B?TDE0T2hMQ0plb1YzdUFRdmRKa1d1VDBQa3A3d3pHWm5QbURWR2VUdG5YaTFW?=
 =?utf-8?B?Q2h4ZFJtcklTM2UvNzBwYXhHVFN1UUwwZnZ1V2Z3dms0WjdOWFZ0ZkdPc28v?=
 =?utf-8?B?NDFyMWJWQ2w5bk5LSWFrL1dROWJDdXBhT2hvTlpsS0dQcll0Q3diZzlnczJD?=
 =?utf-8?B?ZjZLQ2NNSFQ5TU9HTzR4L2NEOGk2Sk5LOVZ5bjFwM20yQ2l6L3N5V3g3dVlp?=
 =?utf-8?B?VGtnNjd2LytuK2pRQ0U1Rk1KZVpIOWpUcUt1dHQ3WnE4cHVYaEs1TldhUXZu?=
 =?utf-8?B?MTBVRGRGeHZnU25hTDJSWjV0RHEvd21NMnY2YVEyVjg4UVphSHZPSmNKMWVw?=
 =?utf-8?B?SUZBWXNneGdJMElhV2h0VGYrTnVWV2dCaWNnNzkyeXpVNmRCQkQzZjJFMlNN?=
 =?utf-8?B?VVpOektheGFKeFFGajRnQS85WE44OElBSEFRSVp4Q3dWaXAzVzNtMUR5MnNB?=
 =?utf-8?B?bGllRCtKZkcvdkZ0b1N3RmttWkl1cktBemIrVno1TzJwNFVjNXhIM0hpeFp5?=
 =?utf-8?B?dy8wMGNOMlVRWTBCbittcFN4SndFTmFzR09wbjJmd0pGVEZ4dExCekRFbEpv?=
 =?utf-8?B?eWcxdWRvQW03MUY5ZExiSHVwWTc4eXNJMFNnaVlwQk1lYUdlc0RlRnRkb0pv?=
 =?utf-8?B?a3BPa3ExVjV0aGo3M2FtNkJ6T3RlcEhnZ3RyTG9BSHp6UG9BcE9salJOVXZP?=
 =?utf-8?B?cllNWW1ZRHM0Z09leDZuaHdZSGM3UXFENGJVOW90di9oakx4Ty91d2prZnZM?=
 =?utf-8?B?K2U2Mk9sQ0dna0lMSVV2cXF0NXpvMVZwZFJzSktxWk9mcGRxOFFaZjBUVEo0?=
 =?utf-8?B?UFJXVWhyZjAxdmRaR2UrREJRMWxNR08vL1pxOWc3L1ZGV2RnazRrQVhuS2JP?=
 =?utf-8?B?N1poNUhWUnd4cnZhUnk1OUdNby9tM29EUFpoY0p2WUVpWFo5OFhWTjV6OTBw?=
 =?utf-8?B?MmpGa2k4blNRcE1FZkNNaU92OWQ4U29sVm42M3ppTExLSWg2VUJETVN0cm1l?=
 =?utf-8?B?Vkx1MUMxRVQ5bjRMNEtkU3FRbWE0Y3BxTWVacFJndXMvUVZWNE5vbUJjRTMy?=
 =?utf-8?B?SVEzamsvVE5RNS8xQTVNNlY2TkZEbkNRbnE0UXozOGdmOFJPNSthdkkrSVR1?=
 =?utf-8?B?NjZWd3huVUZHK1lEYVJyamtJSVlKZmF4djFuSmdEckI1VURhcHdlSEFyaE1t?=
 =?utf-8?B?eElRTG5rdkQ1eGlaNEdseStRMXZZRWRreWlJbUFTVTh1eDZCTDNpWThUNTFG?=
 =?utf-8?B?eVlNbERHd0hKdXFlVXR1RWVrYXdVekxBdHVZQkpMbjYrVm5rcW9IZDBBZURB?=
 =?utf-8?B?OS94V2VUd1ArNzZQcm1ONEhLNGtMNVp1WnhSeGhvTVB0cHNSRXQyYkJONzNn?=
 =?utf-8?B?N1BjTEs4UkkwVDVLVHcwclhIUEYvQ2xLNXVCbGZtOSs2SmVrODlXeU85ZEtZ?=
 =?utf-8?B?dzNyQnYrZXZrRFNZRnpYdktJcDV0SmJFSW1yWEg5N2RlOHpHenpPMndRVHhU?=
 =?utf-8?B?K2VqdmFpR3lCWGQxaTFRWkhrNFI2ditNb0I0dTExcXVZK0ExdkZ1ODY3NWVP?=
 =?utf-8?B?RTk3N2M3eUxrTHpFRnhyNWh1ZmtVYmJtU256cWwwMWhJQzMwalFTcTJGU3Z1?=
 =?utf-8?B?ajArU2V2S25hSUE4YUJLSTVxaTZacWNrUHFIWGpxSVpDZFJpbUd6ZUdWLzBT?=
 =?utf-8?B?blNJRG90ZjVsUHpGKzJ0Z2xxTVgxZlN2NW4wS1hQOE83WWhmV2ZrWmt1NzFR?=
 =?utf-8?B?ZytmUUVlUStubnZLeUNCQWY3U3J1ZDZuM0piaU9rR0E3S3k4bGwzRzVKelZw?=
 =?utf-8?B?eUJzd1NCNVRMcmtNWXZjK3d2cGh2VjcvYUdtK3JQVGdGWG5hekNVMitUZEZ1?=
 =?utf-8?B?TmkvVVY1ZXcyNDlHUXpJVHliRklWMTJjckJyQm5iNUorOE9GUEtzZFNBRnlh?=
 =?utf-8?Q?1vlbSj7W6RR03Lp0qlx4Zn1ja?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd2a338-08e7-45d7-275f-08db72849be4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB6946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 18:23:28.0685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0a/zwLdwEsSjVprG57M8bkYxi4dPKgnTNRI8HwPiqxMNRtHtUpCrH4E1WHTZ684jGviO8Lg0nO5Bxj/LIH1GEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9806
Received-SPF: pass client-ip=2a01:111:f400:fe1a::70c;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/1/23 21:28, Andrey Drobyshev wrote:
> Before previous commit, rebase was getting infitely stuck in case of
> rebasing within the same backing chain and when overlay_size > backing_size.
> Let's add this case to the rebasing test 024 to make sure it doesn't
> break again.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   tests/qemu-iotests/024     | 57 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/024.out | 30 ++++++++++++++++++++
>   2 files changed, 87 insertions(+)
>
> diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
> index 25a564a150..98a7c8fd65 100755
> --- a/tests/qemu-iotests/024
> +++ b/tests/qemu-iotests/024
> @@ -199,6 +199,63 @@ echo
>   # $BASE_OLD and $BASE_NEW)
>   $QEMU_IMG map "$OVERLAY" | _filter_qemu_img_map
>   
> +# Check that rebase within the chain is working when
> +# overlay_size > old_backing_size
> +#
> +# base_new <-- base_old <-- overlay
> +#
> +# Backing (new): 11 11 11 11 11
> +# Backing (old): 22 22 22 22
> +# Overlay:       -- -- -- -- --
> +#
> +# As a result, overlay should contain data identical to base_old, with the
> +# last cluster remaining unallocated.
> +
> +echo
> +echo "=== Test rebase within one backing chain ==="
> +echo
> +
> +echo "Creating backing chain"
> +echo
> +
> +TEST_IMG=$BASE_NEW _make_test_img $(( CLUSTER_SIZE * 5 ))
> +TEST_IMG=$BASE_OLD _make_test_img -b "$BASE_NEW" -F $IMGFMT \
> +    $(( CLUSTER_SIZE * 4 ))
> +TEST_IMG=$OVERLAY _make_test_img -b "$BASE_OLD" -F $IMGFMT \
> +    $(( CLUSTER_SIZE * 5 ))
> +
> +echo
> +echo "Fill backing files with data"
> +echo
> +
> +$QEMU_IO "$BASE_NEW" -c "write -P 0x11 0 $(( CLUSTER_SIZE * 5 ))" \
> +    | _filter_qemu_io
> +$QEMU_IO "$BASE_OLD" -c "write -P 0x22 0 $(( CLUSTER_SIZE * 4 ))" \
> +    | _filter_qemu_io
> +
> +echo
> +echo "Check the last cluster is zeroed in overlay before the rebase"
> +echo
> +$QEMU_IO "$OVERLAY" -c "read -P 0x00 $(( CLUSTER_SIZE * 4 )) $CLUSTER_SIZE" \
> +    | _filter_qemu_io
> +
> +echo
> +echo "Rebase onto another image in the same chain"
> +echo
> +
> +$QEMU_IMG rebase -b "$BASE_NEW" -F $IMGFMT "$OVERLAY"
> +
> +echo "Verify that data is read the same before and after rebase"
> +echo
> +
> +# Verify the first 4 clusters are still read the same as in the old base
> +$QEMU_IO "$OVERLAY" -c "read -P 0x22 0 $(( CLUSTER_SIZE * 4 ))" \
> +    | _filter_qemu_io
> +# Verify the last cluster still reads as zeroes
> +$QEMU_IO "$OVERLAY" -c "read -P 0x00 $(( CLUSTER_SIZE * 4 )) $CLUSTER_SIZE" \
> +    | _filter_qemu_io
> +
> +echo
>   
>   # success, all done
>   echo "*** done"
> diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
> index 973a5a3711..245fe8b1d1 100644
> --- a/tests/qemu-iotests/024.out
> +++ b/tests/qemu-iotests/024.out
> @@ -171,4 +171,34 @@ read 65536/65536 bytes at offset 196608
>   Offset          Length          File
>   0               0x30000         TEST_DIR/subdir/t.IMGFMT
>   0x30000         0x10000         TEST_DIR/subdir/t.IMGFMT.base_new
> +
> +=== Test rebase within one backing chain ===
> +
> +Creating backing chain
> +
> +Formatting 'TEST_DIR/subdir/t.IMGFMT.base_new', fmt=IMGFMT size=327680
> +Formatting 'TEST_DIR/subdir/t.IMGFMT.base_old', fmt=IMGFMT size=262144 backing_file=TEST_DIR/subdir/t.IMGFMT.base_new backing_fmt=IMGFMT
> +Formatting 'TEST_DIR/subdir/t.IMGFMT', fmt=IMGFMT size=327680 backing_file=TEST_DIR/subdir/t.IMGFMT.base_old backing_fmt=IMGFMT
> +
> +Fill backing files with data
> +
> +wrote 327680/327680 bytes at offset 0
> +320 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 262144/262144 bytes at offset 0
> +256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +Check the last cluster is zeroed in overlay before the rebase
> +
> +read 65536/65536 bytes at offset 262144
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +Rebase onto another image in the same chain
> +
> +Verify that data is read the same before and after rebase
> +
> +read 262144/262144 bytes at offset 0
> +256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 65536/65536 bytes at offset 262144
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
>   *** done
For the clarity:
Reviewed-by: Denis V. Lunev <den@openvz.org>

