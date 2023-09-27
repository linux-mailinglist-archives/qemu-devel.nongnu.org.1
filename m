Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C047B01FE
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 12:37:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlRux-0006tM-Cr; Wed, 27 Sep 2023 06:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qlRuu-0006tC-B3
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:37:16 -0400
Received: from mail-he1eur04on2115.outbound.protection.outlook.com
 ([40.107.7.115] helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qlRur-0007vV-JC
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:37:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmzcLLy44G6gLMBx7ZlgTAdDIDrm3l26Qc7n8+acD0eguX8lj7jfC16ijrYGvNsfusDXJCwtxIwXlwo4T8LJTHTKItyB/exIeX4SihmTPuw4SKcqYOSKI8z6ymQoVUKcbxXpUnnga9J+W0bmYwe2qZkhZutToq+LFdhxb+PpF/LEQJhXPiTjKFdHTUmYufUMYy50Z7by6gLGagp9C2gyZMyjp1+1DYy2fDIo1Pn8zl1dnUTWmYDxJVSGB7AK/t2Z9VVC0ST0BG0HAVZFb22BXI5p0keNC0YkVn1FPJXY37w34019wtEB+VRStaie1gvAGOVKEeOIwULl5e5wZdS6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4B1df9Ig5BApzHAoZXkipA8Rwn6UBhb9XtPgFUuPTs=;
 b=CAWPDHYWzgQofHtvEq6T7KnCenvcLS3agaDBRldzB8U4bke26QHqS8cuBej/wUeZMP/40fSVgrrTKOwQnubmyx7MdWffgaLUVNDmFQh9V/d46WIPjECJMJzWnyG4YCrR6DXEHTID26TFqydGKwTYBMiCpLXn42MZYKf/KFHSHrc8fculcqzEHsT8lVkez+49X7Rqs3bLiCsE1ZmeInocY/MSUPAcYEtJbOygeXu2WUeXdp+LLYAwRiOVFkcSsMezeyrLowf/aUbuTY8ShXvWj0z3eotUdTokE2hs5zES4La/LeKfMu8WWsT1ZuiigvDrYqfrYwvUd8pUBwes5uylJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4B1df9Ig5BApzHAoZXkipA8Rwn6UBhb9XtPgFUuPTs=;
 b=sx+W7qBWSLz+bTqBSsOdyHzi5iKiVaeNwus37O1+ZJuXrKVu9okOtV507Scvcqz84j7WVPGblqmGzmjm6m9DinWkOfK1n+G878IHIZdzKpghhjmvAsAHX3H3DBHTzrmnsC33hA8M1HpYb8NMuzNgTUeZTjsnDMDXOtrtNddalEdY1OMskxA+YzS6w+e40wsiUPEyvctikRfA8ZkaTps+A52hANWdOvXS40EeL/PXmXXnvZQ2FhUCxNjpn0jjw7oqnTmNUVwsKUFTjk3bE8wjV7CNcbVxvOVwb82+T/0aMwkmC+irXozNfhgWhqOwd3pPvAJ7RZQ/N6Uxb3ODqBRhAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0802MB2331.eurprd08.prod.outlook.com (2603:10a6:3:c1::13)
 by AM8PR08MB6386.eurprd08.prod.outlook.com (2603:10a6:20b:362::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 10:32:05 +0000
Received: from HE1PR0802MB2331.eurprd08.prod.outlook.com
 ([fe80::4190:cf8e:abd7:68c8]) by HE1PR0802MB2331.eurprd08.prod.outlook.com
 ([fe80::4190:cf8e:abd7:68c8%11]) with mapi id 15.20.6838.016; Wed, 27 Sep
 2023 10:32:05 +0000
Message-ID: <a8d61378-3dcb-45e5-95dd-95fb9e1e0da8@virtuozzo.com>
Date: Wed, 27 Sep 2023 13:34:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maint: Tweak comment in mailmap to sound friendlier
Content-Language: en-US
To: eblake@redhat.com, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20230926203946.3303600-2-eblake@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20230926203946.3303600-2-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::9) To HE1PR0802MB2331.eurprd08.prod.outlook.com
 (2603:10a6:3:c1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2331:EE_|AM8PR08MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 02773b6a-995c-4f55-6f8c-08dbbf44fe3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ijtC6yxIJbyrvho1xOl1TNAfojvK17ZjV+GvflI7BT+GPVyZeYirhWjBw5by8ml1FK4SmZ33QpHRjJPe2Xg0n1zsYDFWEPgJPlaPFwlN3hnZx6lriyoKF7vPq//c24Z3cvUhd7sTvAT0u9aysZz8kFryGXFYPNU4oUAR1NakN3dE5ND0iXAsjo5qi/Y1J9k5WW/n6bLzQ36m6AEww8T23EvOfUhT1kHXu2Eru3mSgnw6hEZVlmvC137alhT8/p6HH4P6OSB4PNB6DVnNumXupbh44co8pc8AcYT8ls49I0Twz0ZAeMw2/FGNZ/T+jBnYlvDTErdw9HbhKmT65azMebTrrm6v6hk1aR4CARYXYeyVH29oI+pbCHfwjFMrW9+yOmF9pbYuZnJAV7MOV6Qb8mAGSGC5vCzXPKDriyW/J6ofKyB35nskzhwP4fwreCLQB71CmMr5STCVtdyeiwRIbw8y/uFr2LtG76jWrqy1jNfB2X6t6UCw/6/kjUiLeT+DaF1mXczEMDAVKR8rneWMmftn/Iq/JF+OuEyYDTkOpgTGq2bXrb7J4okT2NBmQQW56UuCp1IN2TWiZMiFBaCqK0QgSleyXpopzahrlhYVk70u+bMIdHTgFwSIseiDsmAWilm4yik1QEqITeCOVVXBAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0802MB2331.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39850400004)(376002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(316002)(41300700001)(26005)(2906002)(8676002)(5660300002)(478600001)(66556008)(966005)(8936002)(66476007)(44832011)(66946007)(4326008)(31686004)(6486002)(53546011)(66899024)(6666004)(6506007)(6512007)(2616005)(36756003)(83380400001)(31696002)(38100700002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUJHWTBGNU1VOVlkM0FieThXRDNGdmdZOU1oTnJlWFAyRzZqRU5QaElUQ3Ni?=
 =?utf-8?B?MlZabzh3UFRXMVBBSnkyWWgyWExqQngyTWhJUUcvdVJhOXlKSTZ5M25ldURZ?=
 =?utf-8?B?dTZRTE9YV1JMWUpzeDV4V0NZTGU0aW43K243d0ZaVjl3SlJycm0xcVlCK3RZ?=
 =?utf-8?B?WW1JRHZwU1F3T21NYm9IeVZ2VnliUkpCWTBVcE5rdThWck82YWEvWlNOYVRJ?=
 =?utf-8?B?YTdYZzR2ekhPcVAzcGczZ2FkUDhMZllaQW03eitvaVAwRVYzMkV6VjZPQjNm?=
 =?utf-8?B?bFM0Nklic3k5bkgzSHM3Sy93OTNHVmx1cWRMOHh2VzkwTjNQYTgzKzUzOW5j?=
 =?utf-8?B?ck5vWHRudkJnUzh4c1Y1ejEyVk5TTWhXM2MxZFc5c3dMUkx0OEt6a05Henlw?=
 =?utf-8?B?SjNIWXNPRDdjSHFiZ3hEbnM1Ynlxd0dZWloyRmtnMFVva2Vpc0VWK3RXbXhP?=
 =?utf-8?B?Ym8xZHBTTjB0ZEN2azB5UEc4MGlrL2NZdFl4UUdXOFExN0NUUnduQ2ZONWZX?=
 =?utf-8?B?a0kyYVBmY0dnN1BLNHB6dEcvdGRqMjFnbi94OGt2QVpDSm5ycVcyc2NXNE1r?=
 =?utf-8?B?ZUpOM1RnY2RNSUFTUkFTRVBzVkhnVjhDNEhRZk9XQzJQaVNHSktWZDBCRjhU?=
 =?utf-8?B?UUQwSXRleDVRVjJTZ1FNaGJaMEM0cTVNem8xMkhxdWJ1RHhDMWdSR0dFUi83?=
 =?utf-8?B?cFZjLzhMK2Z0am1XY0RnTVRWaUkxeitBWk1udlJUb0JEYTFsYkFjTmFacmhZ?=
 =?utf-8?B?S05hTWJmNFd4VGRjNGt6ZnFZSW1SRldGM3YyRVk2MDQ0NkYyTDVDQjd2Q2tW?=
 =?utf-8?B?UUJyN29UME9CMldJQnB5OTVzelk0U21BdEx4R1NvWHBWK2lIcHdnYitjK3VS?=
 =?utf-8?B?Vmp2Nk9DR29tdjB6dys1ZFVaWmprV0NxaEo3ZFZaK3ZaUFNhc0tjZkRhNDZ1?=
 =?utf-8?B?bjB5Y1ZTQll3dGYzRVVxM2FPREFjVUVyZTZTK3hXK0UrWGZjUTRDT2daL1hZ?=
 =?utf-8?B?d1JPVWNaVU93UzQyNnc4MFZlNWptZkUxR0YyZEpnU1B6WXB4RktaMTlrcnE3?=
 =?utf-8?B?TGJ5VGVjZVhyQVY4aUJua0oyYkp2U0F6cXlKdy9QK1VLSXJpQmlSdTI4ZTRh?=
 =?utf-8?B?dVlJUnJYQUVkT294WGtoWlZqeXlmbHoxKzlaWnN2bktUTjNWNVl2T2tkYWVk?=
 =?utf-8?B?N0pPSG9YVXFqT1NYWTJjSmQ3L2NyNk5jZzFIRU13bHNMVXFKcWF4eUg0bHN3?=
 =?utf-8?B?TlUyalpzV1NCVVJLQ0NzU044SHNIdW90TnJXanlPTUxaM21jNjM1OHp2SGVa?=
 =?utf-8?B?UXNsR1VMZERtbDhyVkdYSmpDTysrNzlmNmxwK0JZMG9DYnRVd2FQRVRyWnhx?=
 =?utf-8?B?UjVYR0MrK0JWNVh4S1p1b3RDZzNDVTlFc2s4cVI4eHdRUXZxMlJhU3RZbC90?=
 =?utf-8?B?VTV2SGdYdForckZCOG5RV2UvNVBxN21QNjdZM2IzODkxMjFOWlFmYlgzK0RL?=
 =?utf-8?B?Njh3N3VaaGFRVnkrS1NlcFNCSFpuYXJwY2ZBZXQzWTRIeHh2R2ZudjZNVlJN?=
 =?utf-8?B?UGRMOTBZVG8wWVpjelRMRmhRNHJCNi96MXYwTGFUajV6N28yT0hPcDQvUGFP?=
 =?utf-8?B?cyt6NFE2QzZ0d0Mvejk5OU4vVEJOdFhsWU5RYjZremdOZkYzdEhVV1ZvMWZz?=
 =?utf-8?B?enhBL1IyZW94WG1UMnZ5Y3YxS3NmWWxML1ZuQndqNENma09EcnRWcmpITGlM?=
 =?utf-8?B?SkFONjUvSXA0RkR5MjJIcWpncmkweEowcE50Rzg4d2k4K2JGK3NyRytnLzVj?=
 =?utf-8?B?RHI5TFhkNExoNmxHQ0h5eVUxTE5MUUtnNmZFRUtVR2pqdWM1OUhaYVB2Zlhy?=
 =?utf-8?B?ZGtTTDdNUlk2bWhxdWNjZEszZ2VNc1dacytEam1iL3kyaWR5YkxlbDd5cHNG?=
 =?utf-8?B?MjZqbVZqNldJUzBNT3MrbWRGRWtRSFg2c1RmQ2FRL2s4cHAvUmVpNHRhSmpH?=
 =?utf-8?B?M2hHV1pwajhQZ1phVmVlZWNJMHR4enVLMTJHSC9heDlzY0VkSGdOdDNiczlr?=
 =?utf-8?B?U3NrR3dQRVlzMkRsL0hxUVpJMk9jc0tFeUIyTEtncnlxL1JpekczMFpreGU5?=
 =?utf-8?B?aWhYMjdCREp5bnB6Qk1QWkJ5cEUxT0pSV1J0YVFtaGpYSlFxOVRRYjlOajE1?=
 =?utf-8?Q?f983OBIQ25nuBGJ0Zd0A+PM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02773b6a-995c-4f55-6f8c-08dbbf44fe3c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2331.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 10:32:04.8964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eKO76zjdTSdmVOHKhmLDRZc7+mWQ2xjKoCgG5aUyWRQCWYhvcBA50Snuf1RFZqzaZGXAwX05Fbuft1RNvpM+sITWrqvVTcdfQzaY8GQYVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6386
Received-SPF: pass client-ip=40.107.7.115;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

On 9/26/23 23:39, eblake@redhat.com wrote:
> From: Eric Blake <eblake@redhat.com>
> 
> Documenting that we should not add new lines to work around SPF
> rewrites sounds foreboding; the intent is instead that new lines here
> are okay, but indicate a second problem elsewhere in our build process
> that we should also consider fixing at the same time, to keep the
> section from growing without bounds.
> 
> Mentioning DMARC alongside SPF may also help people grep for this
> scenario, as well as documenting the 'git config' workaround that can
> be used by submitters to avoid the munging issue in the first place.
> 
> Fixes: 3bd2608d ("maint: Add .mailmap entries for patches claiming list authorship")
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> I'm sending this email with a temporary 'git config sendemail.from
> eblake@redhat.com', to see if the added advice actually adds the extra
> line. It did not show up in my editor window, though, so this patch
> may need further tweaking to get the instructions right.  Since I
> don't normally suffer from SPF/DMARC munging, I may not be the best
> person to test the right workaround.  Or maybe 'git config' does not
> yet have the right workaround already available as a turnkey solution
> we can suggest.
> 

The only drawback of this approach is that mail clients, as well as
tools like patchew.org now only show your "<email>" in From/Author
field.  You can see it here:

https://patchew.org/search?q=project%3AQEMU+from%3ABlake

In your email there're 2 "From:" fields now:

> Headers...
> From: eblake@redhat.com
> More headers...
> From: Eric Blake <eblake@redhat.com>
> Actual patch

Apparently, mail clients prefer to pay attention on the very first
"From:" entry, while tools like "git am" -- on the last.  If we managed
to make those entries both be in the format "name <email>" -- that'd be
ideal.  However, as I pointed out in another thread, if we set
sendemail.from to "name <email>", the 2nd entry doesn't get added since
they're now identical.  So you figure out the way to get 2 identical
"From:" entries -- please let us know.

Having all that said, it would still be nice to have additional checks
for "qemu-block@nongnu.org" authorship, as Peter mentioned in the
previous thread.

Andrey

