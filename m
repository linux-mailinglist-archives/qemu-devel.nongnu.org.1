Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F4D797E9B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 00:10:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeNCD-0005yI-SP; Thu, 07 Sep 2023 18:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qeNCB-0005xT-91; Thu, 07 Sep 2023 18:09:51 -0400
Received: from mail-vi1eur04on0702.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::702]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qeNC8-0002Fw-4g; Thu, 07 Sep 2023 18:09:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ja5JhBBj2JgzG1VI18V3h0F7XFM/wf/pk963R1omzwXm2979stE/O8PyQ0+VAi2TgRmzWVWGxn9WJNEIECBNXTGLrlfCAUDFALJMUpE585W0sJSvu/vAMNkh/ba40DFgnlb+dKK/uVdbEKsRzewYMUkKEV2CM2QEFF0hi2OIi3XygvPnbkyep0n4tgwQFrnKGp1QO9iUSzwCZ/BiWn0Nwf2LvgtSMJyLPOfc1RjOSZlrO+0BMNxGBxgMLNXolrfL2DCcRy/vAGkZC0q1jroVJaXbEoJKHuxGxym+qpyGyHR3dxNaDu7bwhbrP8TPHCZ0a7RZEuIIYV+X3CmZ36RVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLS33s4EHZHDSJWiNQMy5kapIF/fJS/oVl8Mf3GbCoE=;
 b=jnycjLc4yb0LG9Licj2Mqf9L8Ry2NkUDr2N2i+pbw0JDL+tvtW4aIceNlZ5fPvjyefDvjxeDmpt5ZNt0ZOagEG/TbdNS9d+vZFzImIYIjGJPlImfJd3O7sY4mJW/S/tBRhQJlTcrz4DuQC82DwNDYFK1M3WkFIxzqpaMv1UTxqP+Gweryw47dMbyoC3mq8lhjeMBPEMmrolrL0SgtxWqGnNFtFMLZNsSo6kR2t/0+G6Ahg4Dh+MIzAcJjwWtUt2fzT4zpni+uakEMOxSCFCe21Ik8bSLNUgNGdTiPCiSbuj5VCigJFG5fsF9CxnEaDDzdo3DN3SOxUZGYp3eT9DUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLS33s4EHZHDSJWiNQMy5kapIF/fJS/oVl8Mf3GbCoE=;
 b=ue/rWX1uwNJ3QnaG88KXSA0fhBFYjXTLTtE7tijRbMAUuKZxGY/0wYbImxDZzfayIGNI7+i92lKfr6m3+rvY6IA7fVnVP9bX1wU8qw9LDnOYHxMi6cTlF7J/zIQX1zKtvjkSS9rOvcDDT+dIxs1OrEG8ZaxzDh5IWH1eE5QVNvYhKaClJWVj2o32TeeNqpie8psq3ST9uf19IiDC+BgeKleHDrABMjxK+cmKX+GsHctlL7RUxNUgpCoClS3MTVzPptAoccVC/8QwOTBAFYpvwa/VeMNBbynmht0mhG1PsOW/S0sYoHEEiENCvfswFZMQCmgV/BtAFTdwnCOFJpP9pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by PR3PR08MB5804.eurprd08.prod.outlook.com (2603:10a6:102:83::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 22:09:43 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4b14:4628:9a1c:b28]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4b14:4628:9a1c:b28%5]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 22:09:43 +0000
Message-ID: <7c590cac-1d73-4f61-88b6-d4ef5dbd9726@virtuozzo.com>
Date: Fri, 8 Sep 2023 01:11:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tests/qemu-iotests/197: add testcase for CoR with
 subclusters
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com, den@openvz.org
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
 <20230711172553.234055-4-andrey.drobyshev@virtuozzo.com>
 <4db472ce-8932-3dca-3572-5dcef391b227@virtuozzo.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <4db472ce-8932-3dca-3572-5dcef391b227@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|PR3PR08MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 941a4046-c6ea-4b8b-fe11-08dbafef238d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pv/lPUKteTgYsFSItBsdXGBikoS/T9hHZ+kfDWmPJks4tJeZg6XQ+nsbtabGJsJq2WVGPiyaEv5MC71vgmddXYLDHdVGcREBZ3tOsDNIa1M1W5T16UBSPghwKxng0kp2J+ZlmzJwnDNCiQUtro3m4mQ3fusfELyk4mQdJ2Fmw8ESgeECHwW5iw5tpcTxwUaaCl+PaNOcZ/gUNFoUMwhvbn+IbCdBF1d//F50h6akLMaQjNTuyGuh1ufepfWPDUGJ96XqL2+eV3Gh7uGJzhr1DjvG4Pl6n1XWFUSLldDAbxi+Ybbidsuo0PqkD6MsO9HMwNUDmRQ0OQYZvfOkfNwOw8D7L4EuYMYvujUnku+v694L57C3r/AgEk1LIG9KHtDVY3TWQEDJut2VBAI4TQwSUoPIRmCwNhUbie1mEkb7INLJcyofGgsvaz8FFzxFa9L6OLDSXauiGUXxdn8FwrGGwhqfFmRzqu3+UJP6/OKbM+1NwItzXv19wsVU5UHVJ9urMJh4sQOgqskYvAR2omfQcCzT2hbl2NA5bPddijApDFK+ivIJHpNyqz28VwyUlEc03HEU8g9JDuUERri0vG0XH/VnLbkBdfngEex4ybXm77nlcTK3SEqczDOLOwhfFOezR+kpQe39WH8NJQn7cL+dkTX2TxT2ADtEjjMIbfmNAaxRtUYVScigAMnPz44kWOZVQ1sm/9iVrq55RZzk8868RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39850400004)(376002)(366004)(346002)(186009)(1800799009)(451199024)(6666004)(2616005)(53546011)(31686004)(6512007)(86362001)(26005)(107886003)(2906002)(83380400001)(31696002)(478600001)(6506007)(6486002)(38100700002)(66556008)(66946007)(66476007)(36756003)(316002)(41300700001)(8936002)(4326008)(8676002)(5660300002)(44832011)(21314003)(43740500002)(33290500001)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDk0aTY1azFwS0N6VmRvQjBKT1ZpTzRUVjl6Zzdzc2NmbklXMnp4RGZ1RFJh?=
 =?utf-8?B?UGgvZmRiU1pMaXBGYnEwaGlMbW90UjFScnFBckwzVTllKzBmRHNHSWNEQk1T?=
 =?utf-8?B?dEtSdXJlYXQ0SEVZSzNXQ29qSEN2dS9JVURpMnBHS09pdEJSZW8xWmhTUy9Z?=
 =?utf-8?B?MkVxZEJNbWwrVDlsYUNlbHpvcnpaTGIvbm1hcDBmaHhzMzR1YkwrQUZMUVNl?=
 =?utf-8?B?NHpacTFaaUNvVk1oZjZUMUwwTDJkQUtxVkE4MU1tbGZrT3BtNEFzelFDMjNE?=
 =?utf-8?B?aXBaalhLempKL2FvRXlFMEt5QUVJWllyZUF1bGsrYXpoWFlNRDBPS3I2bkZU?=
 =?utf-8?B?ZDRBaVB1QVdydFhWc2RHdE1hem1HOGdwckk1TXM3VGJIUDlKOTJVTFMxc2tE?=
 =?utf-8?B?SjBTckNTR3ZQTU5ZdlFpY29PL3JQazFPSlhMb2JpaXZLb2hra1NGWGdNN0hW?=
 =?utf-8?B?ZzhpR05yMndWSW9Ua2F5YTlTTzcra3NhTHBqY3lYenlENjNMM2cwRFhWcnNW?=
 =?utf-8?B?TEw5TlpVVFVXTkFaaTBwMEhtQXU5ZkN1d1hydnFsYWNaMXRSY2VjM1ZKdE5Q?=
 =?utf-8?B?WE53aFI2REsrMHh3Ym9PWVpTZFhqV05FZExtSXAzbU84Z3p2NGl2eDVvOGpP?=
 =?utf-8?B?azBBKytpUU10VDhQM1dzUXVXZXgvbWZMUklSMFg4YVgxTmpLaFIyN0dmaUtC?=
 =?utf-8?B?Rmwvd0prZis2bTMxbmIrcnhTYllYWFRtekhBeWllcDh6MVRta0l4ZDlPYUk5?=
 =?utf-8?B?TDBNRHZsS0VKSXBENlBNME8wdW45S0V3WS96RElGZ3cvZ2Z5TzFMRzhkRUw3?=
 =?utf-8?B?YVFmVlptTHg3NmZwcFd2VHlLaDA3S0xqMWRvV3QvSWhXYlFxNVBZRUdUYlNl?=
 =?utf-8?B?c2NoWGFObW4xL011ZlFiTzVwU05IY084OFdmQlFiZy9HZzBtVWlEeDEvQU04?=
 =?utf-8?B?VUtML3F5UVhsR3VLNUZwU3hualVMUXNXWUl5NXZQRGQzT0w2YnB6OUwrVlgv?=
 =?utf-8?B?Z1BwM3lnSnhteURGalhLUXZNcEQzRzZxK1VzdFRuTHFvZkVwTkFzY2JvNGF4?=
 =?utf-8?B?S3RaYTlJQ1RWYmx2Q1RUM3hlZHNZUXQybHZMWmIzbzEra3pBclZvTS9HTFdT?=
 =?utf-8?B?NitxcGFvZWQ3emZnUG5HL3JWQVVmTWZVZWhvQndhSVFGUFhIYTdHYTlYOTlQ?=
 =?utf-8?B?QVZrSGhaVzE2NTJEUTJ5TnBtTmhCL2E4UU1keUlUeVdXWjE5cE50WlU2REg3?=
 =?utf-8?B?STA3YlZDRlNLbDc1cFpTRUpEV0FpbVV2bFQ5c2pOenA4anhOejBLSDJLRzJH?=
 =?utf-8?B?OXBJWDVSRlB5NDczR01nLzVjYStVZHJxMkpIY3FSdVVOZDRqVDhobWQ4RmNK?=
 =?utf-8?B?S2JrWS92M280Nk1vdDd5UDIrMDV0NjhITnkyMDVGT1JtK3RZRlFnclg1c1ls?=
 =?utf-8?B?Ykc0OUtrR0szSEgyZTZxV1NjM2I2Mnl1RE4wQnZzMGxJZmFBTlducU8yTmo1?=
 =?utf-8?B?K3J5M1Q3djBKMXhqendOZHA0c3VPRlEvVDRGT001VkcxT21zRUVaaDVseUJN?=
 =?utf-8?B?Z21yUlFHbHRIOVFEZ01ubkdCbTFCMGk3ZU9RUmE0ZmlZaFF0aloxRFQ4Sk9w?=
 =?utf-8?B?NjRTbDI3KzIwbzl6WEdIaFhqSUIzdUx1alhOdC9sWEtOc0QwbTMzNks2NzBv?=
 =?utf-8?B?aTZLNzB6Zld0U2hiMGU1UDdnYUZOamdjSXJUZExHZ3VYbEtPUkZNYzFDZm5u?=
 =?utf-8?B?RWh1QndsL2M1MVJ1QmdCaUpBeUhtb2xrdWVFODhJdUZYeXdtZFEyaUZYbEJV?=
 =?utf-8?B?RFZlWDVCSWpCV1ZBVFAzQTJjcGtKWGR1TGoySW9GKzJ4dGJjWjcrMVppNndx?=
 =?utf-8?B?VDdyRXJxZmRMQzJSdEIvTTlnaW1CdDI2UFkzbkFYQXVGVnpoTUJFTG02UTZS?=
 =?utf-8?B?dGIxQkxyajFPc0piS2tHWkdhYlZFSFROdVFJR25UQXhBZ1NvcVRyVVVWUnov?=
 =?utf-8?B?MHRPbkxUUS9LL2VGSmlUa3JMRjRhYmxGMW1BUHY0YWF6YXJYOXo4eWh0WU9q?=
 =?utf-8?B?eEUwZ3VNTmNld1ZFdSs0WTBaS2FsYUZCSkQxdzhTWjFYT01YMVBhVEtlMmFI?=
 =?utf-8?B?SjdWU0wwdjg3elVjMmVIVVFyM3cycDhjVEp2RnJBSWhPY3NKSlZuM25aS1hh?=
 =?utf-8?Q?NF3FMBjkL9n0swAySQJiggI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941a4046-c6ea-4b8b-fe11-08dbafef238d
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 22:09:43.3427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVlKelMsja2DfbHPdeqcymAwdTO7vkMyhuCVOeK0J/tPIvLu9cQbfe2VBIToanzzX/KJdSjYfJcNdCd6QIfQjQdDOyEnv8xfYW4qfrNb+M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5804
Received-SPF: pass client-ip=2a01:111:f400:fe0e::702;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 9/6/23 12:43, Denis V. Lunev wrote:
> On 7/11/23 19:25, Andrey Drobyshev wrote:
>> Add testcase which checks that allocations during copy-on-read are
>> performed on the subcluster basis when subclusters are enabled in target
>> image.
>>
>> This testcase also triggers the following assert with previous commit
>> not being applied, so we check that as well:
>>
>> qemu-io: ../block/io.c:1236: bdrv_co_do_copy_on_readv: Assertion
>> `skip_bytes < pnum' failed.
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Denis V. Lunev <den@openvz.org>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/197     | 29 +++++++++++++++++++++++++++++
>>   tests/qemu-iotests/197.out | 24 ++++++++++++++++++++++++
>>   2 files changed, 53 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
>> index a2547bc280..f07a9da136 100755
>> --- a/tests/qemu-iotests/197
>> +++ b/tests/qemu-iotests/197
>> @@ -122,6 +122,35 @@ $QEMU_IO -f qcow2 -C -c 'read 0 1024'
>> "$TEST_WRAP" | _filter_qemu_io
>>   $QEMU_IO -f qcow2 -c map "$TEST_WRAP"
>>   _check_test_img
>>   +echo
>> +echo '=== Copy-on-read with subclusters ==='
>> +echo
>> +
>> +# Create base and top images 64K (1 cluster) each.  Make subclusters
>> enabled
>> +# for the top image
>> +_make_test_img 64K
>> +IMGPROTO=file IMGFMT=qcow2 TEST_IMG_FILE="$TEST_WRAP" \
>> +    _make_test_img --no-opts -o extended_l2=true -F "$IMGFMT" -b
>> "$TEST_IMG" \
>> +    64K | _filter_img_create
>> +
>> +$QEMU_IO -c "write -P 0xaa 0 64k" "$TEST_IMG" | _filter_qemu_io
>> +
>> +# Allocate individual subclusters in the top image, and not the whole
>> cluster
>> +$QEMU_IO -c "write -P 0xbb 28K 2K" -c "write -P 0xcc 34K 2K"
>> "$TEST_WRAP" \
>> +    | _filter_qemu_io
>> +
>> +# Only 2 subclusters should be allocated in the top image at this point
>> +$QEMU_IMG map "$TEST_WRAP" | _filter_qemu_img_map
>> +
>> +# Actual copy-on-read operation
>> +$QEMU_IO -C -c "read -P 0xaa 30K 4K" "$TEST_WRAP" | _filter_qemu_io
>> +
>> +# And here we should have 4 subclusters allocated right in the middle
>> of the
>> +# top image. Make sure the whole cluster remains unallocated
>> +$QEMU_IMG map "$TEST_WRAP" | _filter_qemu_img_map
>> +
>> +_check_test_img
>> +
>>   # success, all done
>>   echo '*** done'
>>   status=0
>> diff --git a/tests/qemu-iotests/197.out b/tests/qemu-iotests/197.out
>> index ad414c3b0e..8f34a30afe 100644
>> --- a/tests/qemu-iotests/197.out
>> +++ b/tests/qemu-iotests/197.out
>> @@ -31,4 +31,28 @@ read 1024/1024 bytes at offset 0
>>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
>>   No errors were found on the image.
>> +
>> +=== Copy-on-read with subclusters ===
>> +
>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
>> +Formatting 'TEST_DIR/t.wrap.IMGFMT', fmt=IMGFMT size=65536
>> backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
>> +wrote 65536/65536 bytes at offset 0
>> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 2048/2048 bytes at offset 28672
>> +2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 2048/2048 bytes at offset 34816
>> +2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +Offset          Length          File
>> +0               0x7000          TEST_DIR/t.IMGFMT
>> +0x7000          0x800           TEST_DIR/t.wrap.IMGFMT
>> +0x7800          0x1000          TEST_DIR/t.IMGFMT
>> +0x8800          0x800           TEST_DIR/t.wrap.IMGFMT
>> +0x9000          0x7000          TEST_DIR/t.IMGFMT
>> +read 4096/4096 bytes at offset 30720
>> +4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +Offset          Length          File
>> +0               0x7000          TEST_DIR/t.IMGFMT
>> +0x7000          0x2000          TEST_DIR/t.wrap.IMGFMT
>> +0x9000          0x7000          TEST_DIR/t.IMGFMT
>> +No errors were found on the image.
>>   *** done
> It is revealed that this patch seems to break unit tests if run for NBD
> format
> 
> iris ~/src/qemu/build/tests/qemu-iotests $ ./check -nbd 197
> QEMU          --
> "/home/den/src/qemu/build/tests/qemu-iotests/../../qemu-system-x86_64"
> -nodefaults -display none -accel qtest
> QEMU_IMG      --
> "/home/den/src/qemu/build/tests/qemu-iotests/../../qemu-img"
> QEMU_IO       --
> "/home/den/src/qemu/build/tests/qemu-iotests/../../qemu-io" --cache
> writeback --aio threads -f raw
> QEMU_NBD      --
> "/home/den/src/qemu/build/tests/qemu-iotests/../../qemu-nbd"
> IMGFMT        -- raw
> IMGPROTO      -- nbd
> PLATFORM      -- Linux/x86_64 iris 6.2.0-31-generic
> TEST_DIR      -- /home/den/src/qemu/build/tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/tmpzw5ky8d3
> GDB_OPTIONS   --
> VALGRIND_QEMU --
> PRINT_QEMU_OUTPUT --
> 
> 197   fail       [11:41:26] [11:41:31]   5.7s   (last: 3.8s)  output
> mismatch (see
> /home/den/src/qemu/build/tests/qemu-iotests/scratch/raw-nbd-197/197.out.bad)
> --- /home/den/src/qemu/tests/qemu-iotests/197.out
> +++
> /home/den/src/qemu/build/tests/qemu-iotests/scratch/raw-nbd-197/197.out.bad
> @@ -43,16 +43,11 @@
>  wrote 2048/2048 bytes at offset 34816
>  2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  Offset          Length          File
> -0               0x7000          TEST_DIR/t.IMGFMT
> -0x7000          0x800           TEST_DIR/t.wrap.IMGFMT
> -0x7800          0x1000          TEST_DIR/t.IMGFMT
> -0x8800          0x800           TEST_DIR/t.wrap.IMGFMT
> -0x9000          0x7000          TEST_DIR/t.IMGFMT
> +0               0x10000         nbd+unix://?socket=SOCK_DIR/nbd
> +Pattern verification failed at offset 30720, 4096 bytes
>  read 4096/4096 bytes at offset 30720
>  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  Offset          Length          File
> -0               0x7000          TEST_DIR/t.IMGFMT
> -0x7000          0x2000          TEST_DIR/t.wrap.IMGFMT
> -0x9000          0x7000          TEST_DIR/t.IMGFMT
> +0               0x10000         nbd+unix://?socket=SOCK_DIR/nbd
>  No errors were found on the image.
>  *** done
> Failures: 197
> Failed 1 of 1 iotests
> iris ~/src/qemu/build/tests/qemu-iotests $
> 
> it is good for QCOW2 format.
> 
> iris ~/src/qemu/build/tests/qemu-iotests $ ./check -qcow2 197
> QEMU          --
> "/home/den/src/qemu/build/tests/qemu-iotests/../../qemu-system-x86_64"
> -nodefaults -display none -accel qtest
> QEMU_IMG      --
> "/home/den/src/qemu/build/tests/qemu-iotests/../../qemu-img"
> QEMU_IO       --
> "/home/den/src/qemu/build/tests/qemu-iotests/../../qemu-io" --cache
> writeback --aio threads -f qcow2
> QEMU_NBD      --
> "/home/den/src/qemu/build/tests/qemu-iotests/../../qemu-nbd"
> IMGFMT        -- qcow2
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 iris 6.2.0-31-generic
> TEST_DIR      -- /home/den/src/qemu/build/tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/tmpe1qldhs9
> GDB_OPTIONS   --
> VALGRIND_QEMU --
> PRINT_QEMU_OUTPUT --
> 
> 197   pass       [11:42:14] [11:42:17]   2.8s
> Passed all 1 iotests
> iris ~/src/qemu/build/tests/qemu-iotests $
> 
> Regards,
>     Den

Thanks for pointing out, apparently I didn't realize that this test
should accept ANY format as a backing file.  I've sent a fixup as patch 4/3.

Andrey

