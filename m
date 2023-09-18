Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F7E7A45BD
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 11:19:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiAOv-0002tI-D9; Mon, 18 Sep 2023 05:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiAOi-0002la-Su; Mon, 18 Sep 2023 05:18:28 -0400
Received: from mail-db3eur04on0718.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::718]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiAOa-0004Hk-LT; Mon, 18 Sep 2023 05:18:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDDcVEayGECaLTu3Dqt4zOj4IummJ3rd1SVqMEfZTEChO7PPcN21sml0KweKGAX4FIwuuv0tF8UVQdRB6EM6MNMPxwvU7G2E/bkhlUE/hRkEufvFKRnqKYlayLw2n90cp+nGRQQcRmoo2ZTG6HMEAyDqAo8VCG65H2tjkf1BPcm6KJ3uI/2S9l4baVFN+ZXdCrajLfBfNrjtRtORVKOl4IU271TcZmW3EhFLq5LyZZ7BYpDG3WVv/xA5VxOoWuG1kSV+kjn7wM1msmi32ST4Xusg3nb2B2WVLQRWm6EkMPHq8Mdor2K/ceIK5K0DtOXDdO12dfTXVfT0oCn/DbtxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IN4/pUzQIsqg+rOd/dv42zsQ1iqrlDl7H6MBEhiomeI=;
 b=D0hN4dvCwzmKnBeLfoSk5MqupiRLPtxBDRvavesEOad4Aps+/sOo9Eai3C6yYDBUUgMp6/7dUwsi1ZLOvkc/u4My+tcBTNnTUFekd0IbcmT15Zr9UfZSiMTSYljFhg7FpS5SWOD7KevvRzNzeCQYsZcsaYAuuWhGdIm/QvbiE4HjxYTRcY5udZl0neqbiYzjQDj1p0tX298u+G7LSW+B/nDbZh12sSx2VJ3vKRpytlYo350HbVJeREZAo6nH5rtQZpWlZJVh5bB71hgzmypk75/tQpHLcTEIZt0/DzMrTiKs7eR++6G8C4VJW34JyXAuazRw+NXwirQndtwCDT2k4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN4/pUzQIsqg+rOd/dv42zsQ1iqrlDl7H6MBEhiomeI=;
 b=e2yoFDNYWTrgB+ieLRqfV/npQOJwlN8NJGI0I6via24mh9Gm2lp/+Ap51gjw3YvNYE9ibNV5+ya0oABTOYEREaQJ+olkZRDF0571rMkRT3eFC0NO7kqklphNxfQTJRfX08TQkY8PncJyyEhnsDcAB+NNlLvO3YaQA85VR3GeIwkbgTbtJ70A46CS2b/Cm6DfwRttaJR4kVdMQ0t26kzHLwdloizfy+8S3sVLjgZczIDfd7OgcNQW3kmtf1ic3lEe94pMuZ5zS1KyfWWupxgU1KDwVuN7uMmNO58Zji4XwkGHWyJ580Rz8bqVlelvlVubvnZXK4RygwdUjekoMhDGIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAWPR08MB8816.eurprd08.prod.outlook.com (2603:10a6:102:338::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 09:18:16 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 09:18:16 +0000
Message-ID: <0512587e-8926-382c-7cb1-4f2769678b9d@virtuozzo.com>
Date: Mon, 18 Sep 2023 11:18:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 10/21] parallels: add test which will validate data_off
 fixes through repair
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-12-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-12-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0024.eurprd08.prod.outlook.com
 (2603:10a6:803:104::37) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAWPR08MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ed52d8-42a4-4384-717c-08dbb82830f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTyAgMfi9TDQ3FstP+k9TkYhznK26a0RaDP+05hwll0QUStjt0EsPCZ6dThVQDKpUYauVMyqoyJsJ49KIwbUThmvV/5VBTq7lZ7FeoOQRDeu3XKFCaQGQbWbbLMe7ZC5CafT/L8Vg9ViGCLshWz9eK/zmrVvPzaDfea6SwKjYOGrAsbzljPNICMBhwSJASwrVBfUBdbI2xJkJc4Ln+xC2JkqBkMEEYwS3xIre/5YDChsJG+iUomDNoZ/rL8iVUrPC5eeU41/csyU8l3qjRh3QSbPpJYlPu8ttLvWqM3F503eM7N3CXEkEouXntedmdcvJGgls17WnFCr8XqVADz/gp1FRKQStGN14deXQhLnTEHDaRQ50/WzCTNFnXR63Q3Yn2B3vEJBwo5PEAt/ltOARFRZObtho2mAGsbQn7saNbnYGSZl/1Yj3LrAOv6MUgcMX2SXG29fMmPg5WfCLVY7ua/kK94UEPONfIpXmIog8fGxIDn1gsyt51iN4i6FMGi0vW2F1IqO1zDugHnN07GFcQrPxyJ7fxEY59VrPkeLCvL7Q+lBxxIAMU66Lv7vFc+rHXhg0KUlbn/1DhIKTPKtvNJcNHioO2AF326wqo9RSnTvJTp5bKkL3YOhnae4vrCjAkIGXEGn1i62E34PZbnNbp7OtENoQyLFyKysXv+jpea77sb/45uZIG7OhywMvVLgxgqxjbt6zL/mq+N5VAZkyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(136003)(366004)(396003)(376002)(346002)(1800799009)(186009)(451199024)(26005)(2616005)(8936002)(4326008)(8676002)(2906002)(36756003)(31696002)(5660300002)(44832011)(86362001)(53546011)(52116002)(6506007)(6486002)(478600001)(31686004)(6666004)(316002)(6512007)(66946007)(38100700002)(38350700002)(66556008)(41300700001)(66476007)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1c3b3JuNkhTSjN5WmVJdzlPbjdmRVJwNlcweWFOcTYrMVQyd1pOeWZHR3d5?=
 =?utf-8?B?NW1vMDE1TENMS1NBVEJYYzlyY2lVdWs4WFQ2UUNhMmVhajlRMGh5dm81TStH?=
 =?utf-8?B?b2F4UWh1TGQyUUpWUEZ3azMxUGdjL1pETVBWOUVvUTBGM2lvQzUydWEyRndl?=
 =?utf-8?B?ZzZYK1NXUTZFVzlUY2ljQ3lLbWFnOHBDU3c3ZXB5ZWlCU3dSOVBwYkltcGE0?=
 =?utf-8?B?VUNCbjFWRU43V0tFSzB1a3VRMk5HbWdRVWF0WVU4Y3JKcEMveUVYcW5vWk1O?=
 =?utf-8?B?MWk5WlJCR1J0ZlFuNythMk0wTTdGYlFxa1paeUtTV0orWVF5eFRFdlYxSnVi?=
 =?utf-8?B?dzlEZ09sdkNHM1RZM0NWeUJRT2EwcThHbkFiRkJ6d0V2TlpIY1h0QXdnbXNF?=
 =?utf-8?B?TE1Ib2Vhc2NnSWJ2M0dJTWJKWVFSeFJVVlI3K2dHQTJRYjVsbm40bmRYaFhY?=
 =?utf-8?B?R0QvQTg3d2pmbUwxbTFWVFVXMlB5QzZoOWdqWndLN2Qzc2piZzRXbzlHYnl4?=
 =?utf-8?B?Z1dTZEhuZjZCcmExS2V5THBwdklwWEJuWDhOSUxQNTRVQlcvLytRNVpqRzZS?=
 =?utf-8?B?bXIvUDluazVUZmVOTFdkZWRJZjNxYmtnWFpZdzlNMHlRYWUrcFZtUXdSS0hH?=
 =?utf-8?B?VzY4aS9xbncySzFIYzYwcVhoVUNFSHhGSlNHNGpzUkpjMUhGTzAvd201akhk?=
 =?utf-8?B?MVc1ekhpSGt6MXhoaHZlSjFVQ2w0b25DcTFwQ0ZWY2s5UXc5VnpKOU1IMkF2?=
 =?utf-8?B?VTk1ck1EUGdHZW9kVTNlNG52QWN3UTNyNGF4M3BJR3J2VmVOa1NDM0hoVWxL?=
 =?utf-8?B?R3YxWG16enNISml1VmJ5aGwvYStFR0NUVmpVdysrT2xnSWxjTVkrWWkxSXNO?=
 =?utf-8?B?U1c1eElFaGcvaGhrSnQ5aWdDVENhZGVRYU1laGIveHVwNHhqZGpNd29ESnJs?=
 =?utf-8?B?SzJNOXVXQmFFSTRkR2Q5QnVYWlhzbUlRUjgySktmRVRGOGszU1E2eElsTUVm?=
 =?utf-8?B?bE1uMVVud2tiTkhJc0UzM3lhRTVCU3p5bVBOZy9wdVpMRE42dHZmYWNsSHpu?=
 =?utf-8?B?Z2FtaExFWnBUR25qbEd1dkNLQ2daQ0ZzUlhkb3NJbVVPWnQrOHhvOVVnZ2di?=
 =?utf-8?B?OXZlN3d4aFZGSjJOMnJkbHZyek1uMUMvbC9uRWJJaTcxM3hVMDVMN1hVcE9V?=
 =?utf-8?B?bndwaUZtNXBIanc1UlMvQmpjOVZVYWN2L1BvQVUwWXNrYTlQS2FWQ0l4RXo2?=
 =?utf-8?B?L0xDcEpKeXM1TmREOUljN2lKVUFVYWVlcDUyMVNFdVdaY3VoclVaTmxjdFZO?=
 =?utf-8?B?dk9oSDEyTG5iY3VVOHRsbndJZUNKL01henVoSGxPL0tXdzl5K3FrUlAvRDRn?=
 =?utf-8?B?RUNSQUxreno0bVozT29DOTgzQU5aZTh6N2NVQmowR1FLdmZhc1RzQUFMNmto?=
 =?utf-8?B?U0dZZXEyYk5GY0xROXdndi9jWGxNbTdYNGJXdWV5VlhWcTZYRndWRFVjcnJU?=
 =?utf-8?B?eDFyU2NXem9Ic3VnVm11ZVFkdjZUZGtRQ0NaUzQ3Y0Ivc1V2NllkYWw2bFh4?=
 =?utf-8?B?WFNpQ3Q3UEQxK2JKbWZ2bTFjWXBCblhDckt3bHM4REQwTUlMR284U0N5NVZn?=
 =?utf-8?B?N1U1Rzk2NG5QbkJobS9pcHhxanFvMzgxYjYybDhWTEpUY0YzeXVyM2E1VXZR?=
 =?utf-8?B?WXQvYzFWeFM3RzNEbVNPRnQrMzI5UlJlRG9rdkNacmw5aDFPaGNqZVROSmgz?=
 =?utf-8?B?c0VvazliZC85MFlGUWdNWEZ5RXpFQU9aUzE4SzJOL09WTFdQTm15T1JqUGRH?=
 =?utf-8?B?eVdIQitPbmlWRkhCRStoaHI4N2FqdmEwbU1Jelp3L2pFU0l1YkJyd056b1pB?=
 =?utf-8?B?amRFWkFvRWxjNjJvbUxBZ3VNWWFkTEhPcG5MZ2N4Si9rOVhISU95YmlUMTN4?=
 =?utf-8?B?bmsxOGpJTk9FNFJBNVVPV21INk5IaG02ZHFveUhVSGkyNUNzdjM2ZFptSHda?=
 =?utf-8?B?cmMxdVlxRzVqdHdhdmMxZm01b0dqaG12R1A3bUpSblZtZnBOeFVFNUd6OWJU?=
 =?utf-8?B?RmpxZjZZaStDalRsNnBsb09FMWxiTzRWaVUxV3RSamduVFNsMHB2aVB4aUdC?=
 =?utf-8?B?UzAzWVBGRGp6dFAwZFB6ZEkvNGh4MHdoSmJaZVJ3ODlIOW10bnI4YjdlTVMz?=
 =?utf-8?Q?A5lw1wm9h1Kfc+00sMe9/yM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ed52d8-42a4-4384-717c-08dbb82830f4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 09:18:16.3537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdU5U8am/bFTXJwV3/phkZ8yYolJtZZZxih/rzuxD9AXM3F/jIg67ewTzSSoE+aD0nvVJkErjp5FiEUekiDL52UbOfHM8fzkdcnJ/jpqPyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8816
Received-SPF: pass client-ip=2a01:111:f400:fe0c::718;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> We have only check through self-repair and that proven to be not enough.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   tests/qemu-iotests/tests/parallels-checks     | 17 +++++++++++++++++
>   tests/qemu-iotests/tests/parallels-checks.out | 18 ++++++++++++++++++
>   2 files changed, 35 insertions(+)
>
> diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
> index 5917ee079d..f4ca50295e 100755
> --- a/tests/qemu-iotests/tests/parallels-checks
> +++ b/tests/qemu-iotests/tests/parallels-checks
> @@ -140,6 +140,23 @@ poke_file "$TEST_IMG" "$DATA_OFF_OFFSET" "\xff\xff\xff\xff"
>   echo "== check first cluster =="
>   { $QEMU_IO -c "read -P 0x55 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
>   
> +# Clear image
> +_make_test_img $SIZE
> +
> +echo "== TEST DATA_OFF THROUGH REPAIR =="
> +
> +echo "== write pattern to first cluster =="
> +{ $QEMU_IO -c "write -P 0x55 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +echo "== spoil data_off field =="
> +poke_file "$TEST_IMG" "$DATA_OFF_OFFSET" "\xff\xff\xff\xff"
> +
> +echo "== repair image =="
> +_check_test_img -r all
> +
> +echo "== check first cluster =="
> +{ $QEMU_IO -r -c "read -P 0x55 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
>   # success, all done
>   echo "*** done"
>   rm -f $seq.full
> diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
> index 98a3a7f55e..74a5e29260 100644
> --- a/tests/qemu-iotests/tests/parallels-checks.out
> +++ b/tests/qemu-iotests/tests/parallels-checks.out
> @@ -72,4 +72,22 @@ wrote 1048576/1048576 bytes at offset 0
>   Repairing data_off field has incorrect value
>   read 1048576/1048576 bytes at offset 0
>   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
> +== TEST DATA_OFF THROUGH REPAIR ==
> +== write pattern to first cluster ==
> +wrote 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== spoil data_off field ==
> +== repair image ==
> +Repairing data_off field has incorrect value
> +The following inconsistencies were found and repaired:
> +
> +    0 leaked clusters
> +    1 corruptions
> +
> +Double checking the fixed image now...
> +No errors were found on the image.
> +== check first cluster ==
> +read 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   *** done

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

