Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F4D7E6AA4
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:34:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r14E4-0006Wn-4k; Thu, 09 Nov 2023 07:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r14E1-0006SF-Le; Thu, 09 Nov 2023 07:33:33 -0500
Received: from mail-vi1eur04on072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::72e]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r14Dz-0000vE-Q9; Thu, 09 Nov 2023 07:33:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXR6/CjH1Bwi7PXXbC/a1HQQg+3cGd6Yd7p4Au+Qs/enZ4dgBm16g4D3tJ9nBlJ9eA/OQ8aDNvNm9xoif6YJ6ecxOSVMYpUWTQjx4028NqV2F8IC0esLjvqH2O97tiNyLS0jU1DxV8mwDAq0fohYJQWxavnu1VIRUJ2fdRLT+vUOKKaK7U1YUlF19qqnA9ECD/B7iXjl8K4od3ih/KkFIqVPmUeXHM7dmPNq4Te0bRwKJBNQSOuI8o4xD+5q6bgYG/od58ESERYY7lX9xRbSJfZvvhRFEiBDN6M0g930pDDV6GbbSAql2SXzDWvEhOhRzgF8TOi+JtcGQOPfatV/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qi5PWEX0X2m5DAEFvREYCS0GB6bTCc7DQC0YpGsfXRk=;
 b=L5WDfC7C+SpbK0By8f1DliKQJpybf9iHdS/SAV4g+H+tUJtlxdFVW7l/JruwBiorOs+BWt5qfK3Jtd8LGmx6yXpL96Qo6NdqyNL85ki89qp7suLQUYklbEq/wrVK8D7e2tv55+EURsdGHB9jvisNt6WYjEiepPa9xaYVywpKNjv8nfZcFNWQQMgfsBiJSh8ynHVTEXVIdyTHrjKLbyMTnRWT5f/8UnAIjVDnf3GeAuhdFde0BOD4VK6tiWaNCbyQlb8EPMh4Y0g4t6Oca9zKmIV2FgScEl/Ba9arqxQ2UPJ7F1G08O4aVunSfv7mTznwSDbWvRzDQFRHCTpUdaHD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qi5PWEX0X2m5DAEFvREYCS0GB6bTCc7DQC0YpGsfXRk=;
 b=wSMljafjx5NFK7HKYrK8I8fR8wHmNgg0LxKTB5jp0d2D4yx8I8rblR0AxWCeb9iXHC+w3TYfCTrwsq3UJuraQGLxvaxn9erRYLsMt8QgBOZLL7Jar2gGDAD733mAKBQBr5iknHrx+wQ41eBK8GNRNtr8cGzzdwAy1WDJK4d1qOiuIrJi3a9SukiU4Cskc6i3kK28+fTPZ5YYApGHE9U9E4QKrhAJ5Y3KzQNgdAUMVy0vffxH8DI/y7Bax7ZnFzGk+yJSLVs7vKFXIrJDuGa8/Xhm+9UI9DtyFkw+DkmG2saH6TRABCwxJjVqPAeHotWI+wio5+x+L/3mYFR7OIGszw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV1PR08MB10606.eurprd08.prod.outlook.com
 (2603:10a6:150:165::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 12:33:27 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352%6]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 12:33:27 +0000
Message-ID: <857ac821-4ce3-442f-9890-8530b78f0764@virtuozzo.com>
Date: Thu, 9 Nov 2023 14:35:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] iotests/common.rc: add disk_usage function
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-7-andrey.drobyshev@virtuozzo.com>
 <0b4f4294-8b01-4d6e-84a1-462d8b802062@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <0b4f4294-8b01-4d6e-84a1-462d8b802062@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV1PR08MB10606:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ec20dc-245d-4173-fa14-08dbe1201288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zuk1Mj0kTdxuFLO+xTBo+9fNOXNQThTTuseBwT84c0Fqd4WtM5dKRvsyt4XmRoyS649J5zgHkCVfTCSG4gJsSnNBfCCC8CYiIg7gQdIn0I21eHBH7sycgmaW7eioFZ5jUtmTB9J2JOrzZFFJ3LLMLy4f7KnGDFhCPgOTWU6Fp3vjHqS8/fjGpkkpWnFn2ad2KTRBeKF7PXOlFzhWbapFSTQWmruH1jhA0HanPm5UvmT1uCucpqDo4/QsprXRBLtIOECgPwGI9znj/lqGgiB5vFnzT1l9IX9VyrjrkK5zpANO3xv05W+q3XZK85OgJwE9Jer7EAerQG7oqrryaQbxgx+mTBWSivpzIH7jTVt28GVlq2uKSXBG51E3X0094U38TCk3lsuNd7GGSGpX+kbvjxe1VFkSz1dKIL4N3IcZUlsZJvWOeyv6bLxpVlfKQZI8sCQxPmaH5m5CRQr6v1M2ldly3osABoBfB97VEwDRDHnTW3hXjOOckt+2UXicOJvg91G8anXik+LhlAk7ejrRBWZESM7evCxiRjIsFQGcMhe2IrAazDzDbw0x+PQ4kxKPx0/ZVkI4XUmuCS6KnBxzWeiUncJzxeLq7NLc2H2skoncRjpJcQD6B82v9nrJfaQ7FtwTIDdXpfgroEdukfSLpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(136003)(39850400004)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2616005)(8936002)(86362001)(5660300002)(44832011)(2906002)(31696002)(316002)(41300700001)(38100700002)(6666004)(6506007)(107886003)(26005)(53546011)(8676002)(6486002)(6512007)(4326008)(55236004)(83380400001)(66556008)(66476007)(478600001)(66946007)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1Q1YWQ1R1N5SUlVS0s5MStERjhpUFFaMzJxQzRqV3JHRXI3OGQvaFdJRjhG?=
 =?utf-8?B?T1NxMUgzdjVnbzdQM1VWMXVJNzRRZXBoSXpjNkFmSDFMa1o4bUdNS3lJV00y?=
 =?utf-8?B?ZHJJNXpaM0Y5R0I5UHJmSzlWTm1ta3doNnBvVXpqLzZQdHZPU0d0TkhpOE1h?=
 =?utf-8?B?ME56TmdhSC9BM21NdzRVV084WDd2UWhvdHZxZDFGYUtqMXRIM1FWSlFVZkZo?=
 =?utf-8?B?RlRnV0Npa1crWnozbnNvS09KbThpTmtWSk9nclhXSzFzbDFXcEdkM01HWnc1?=
 =?utf-8?B?Z1JVdUN4TGxFakl4MUh5bDRYWDhIa24vRk15d3Vtd3FHbDRCVkFpcm5xcWVq?=
 =?utf-8?B?d2F4ZjFSR0JON0JFalArOUJ6K2s4TnEyYS8rUDhENDQ3V2FhNUc4dWYxdTl2?=
 =?utf-8?B?RkdMdlY4WEtJZjd5bFB3YnpyTUxOdndaK2pmWEFwTmp0TEZLSjJtdkdzUlJM?=
 =?utf-8?B?WHlaR3V0N0tEKzdCaVBsLytwMTlRd2hWTWRtQStvaVAzWmlNZ1hzUmJDSGJY?=
 =?utf-8?B?U0grZ01QUWZ2T0dnUU5TUkV5SHFOOUlDalJHL28ycGdRYnhiNC9WU2ZKL2la?=
 =?utf-8?B?K3o5K2xaRytwOTNLNGJ4VFVOOUZEUC9VYTk4aVBBOURrbEk4ZHJpZFhPblhC?=
 =?utf-8?B?VGxpWlhiM1BtaXBpZlNHTjBka2JCY0RneVY0b1JoeTk1K01tWDIzQUVxdzRX?=
 =?utf-8?B?dTFXbk1Ec3k0bXNhNUtkQUFjNTBTM0tsVUxBVkttb1UrQTRBUDdZbFY5a0ZY?=
 =?utf-8?B?dXk1UUIvQ0V4L3hhNVdtcVFBdFF3UkVJSFZnSVhVYlg5NDlMUUM4aFQ4V2hp?=
 =?utf-8?B?WTBlaVFVUGt3TkhRRTVWam1sci8vNjVlNXRFVlU0dXVxSWJiSlJRRGw4Z0Mv?=
 =?utf-8?B?WmdyV0ZwT1ZGczJyb2o1VHFYbm5tdVY2R3VuTThnK0h5dGd5a0UzVlF1MUVo?=
 =?utf-8?B?eEdlN1NRK3BtVGZaNngrTWF2UEh3RW9tZkI1VHhPZWdGTDFyMCt5MTQrVUR6?=
 =?utf-8?B?a0VJd0NMRGRkLzFoUGxqenVCNFlpUklsRS9iVExyZVJrYTZpaFliRUJ4Vzdr?=
 =?utf-8?B?eVFBMkFqdTE2elU2a1VlSmgvWWpUcXNUKzBzMnoxUFRuTU9ScFVOYmVDTE1Y?=
 =?utf-8?B?NnRVOU9PRFhLcTFkRGRkKzNkVy9XcUp5Mks4UWx2RDk5SjRjUGl2WG5BMk5o?=
 =?utf-8?B?a2pYbjRpbHpGZTFtZzdIK2JtZkhVOWZmS1hNbDdvdWMvZlhqSjhzL0piVzhN?=
 =?utf-8?B?NENOWGRoL2JjSjU1YS9KV0RQTW80TER2MEttOHg1ODNUNWViWVFHSmt3T3Zs?=
 =?utf-8?B?ZTFYL1hISC9Oc2NsNFlRNlFNNmpqNTFtcFBNaTN5MHVLbHh0a0VMZ2N6ZjhN?=
 =?utf-8?B?VjVkdTBmV1NoeXoxZEU2S2IvNy9tWjhYdUFsY1dFNjJmNTlmNXIzckFIM1d6?=
 =?utf-8?B?QzNtM016YUx6S1dMYTVadGdwV1ErdHllRWg1eE9qT0JIRVpueHdwNktGNWpG?=
 =?utf-8?B?UFpEZ3RWcys0V0k1dU1kUzhoNVpaRFJ0RWhnMWgvaXA2SjhQSVBYY2EzWHdr?=
 =?utf-8?B?VzNjZmxqakVPKzYzNkZJYUp3STk5aWU1QlluMWJueEN3WTdYWW45bTJMZWFC?=
 =?utf-8?B?TmJFejZOWXovcm04NElXVzJyQjZyMXJsVjRLVXZqb0owUTBxS1FTbE4xb0VF?=
 =?utf-8?B?RDU4TTVRNDBJcjBjcmNweEM0b3AvLzZGb2VlZ3gxRnRydVF2bHQyekFNa01T?=
 =?utf-8?B?OVdmSStET1F2ZG9TVjg5d0g3NGxFdFB3anJhVDhJeTZmcDhWNDdMeEZhaEJu?=
 =?utf-8?B?cnBiVUtWdGhSWjgwUjFPWHpyZkhtYjh5MXZFdW52ZlBMSGI4YkREUG0xdm1X?=
 =?utf-8?B?WXpRcDVaVzhxWTIxeTM0Qmt0dnJab1Z4NWxVT1dEYWREUU51TWV6SmRRRW02?=
 =?utf-8?B?SG5yUzhhS0wxaTNlQmp2NjRDeEZMYjRnc2p3c2V6VysxZmc3TDRRMDYxOG1W?=
 =?utf-8?B?YTFUd3RZVmQ5NVhSTGV1U1c1Qy9SaytMM1haa0Vob1c2SGsxa3FBbUVINUoy?=
 =?utf-8?B?aHI3NVdaVTdqQ0Z2ZDRka1RSMXZ3L3k3WGl2RVUweVhhT3BSNEVDbzlOSmFS?=
 =?utf-8?B?SHdMalZpdnpIczB5RTJWVTRFUUxYVVhrL3VlaTROckpiT1BxeVFKOG1ESzhJ?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ec20dc-245d-4173-fa14-08dbe1201288
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 12:33:27.0634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EdcEx96R8UcMDlf8trpw4bfFRhYl7rp6n4K+HuJznMwZgNQN8foI99k3YxTtKdk5daeCj7KgNW4I8y4OKp1VoGrP9Ii5bNo7BAPKh7bjoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10606
Received-SPF: pass client-ip=2a01:111:f400:fe0e::72e;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 11/3/23 17:20, Hanna Czenczek wrote:
> On 20.10.23 23:56, Andrey Drobyshev wrote:
>> Move the definition from iotests/250 to common.rc.  This is used to
>> detect real disk usage of sparse files.  In particular, we want to use
>> it for checking subclusters-based discards.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/250       | 5 -----
>>   tests/qemu-iotests/common.rc | 6 ++++++
>>   2 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/250 b/tests/qemu-iotests/250
>> index af48f83aba..c0a0dbc0ff 100755
>> --- a/tests/qemu-iotests/250
>> +++ b/tests/qemu-iotests/250
>> @@ -52,11 +52,6 @@ _unsupported_imgopts data_file
>>   # bdrv_co_truncate(bs->file) call in qcow2_co_truncate(), which
>> might succeed
>>   # anyway.
>>   -disk_usage()
>> -{
>> -    du --block-size=1 $1 | awk '{print $1}'
>> -}
>> -
>>   size=2100M
>>     _make_test_img -o "cluster_size=1M,preallocation=metadata" $size
>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
>> index 95c12577dd..5d2ea26c7f 100644
>> --- a/tests/qemu-iotests/common.rc
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -140,6 +140,12 @@ _optstr_add()
>>       fi
>>   }
>>   +# report real disk usage for sparse files
>> +disk_usage()
>> +{
>> +    du --block-size=1 $1 | awk '{print $1}'
> 
> Pre-existing, but since you’re touching this now: Can you please change
> the $1 to "$1"?
>

Sure, will do in v2.

> Hanna
> 
> [...]

