Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0C97E6C1D
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:08:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15g2-0006Wz-5M; Thu, 09 Nov 2023 09:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r15dC-0005kB-PA; Thu, 09 Nov 2023 09:03:43 -0500
Received: from mail-db3eur04on071f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::71f]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r15dA-00075p-2U; Thu, 09 Nov 2023 09:03:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jg5bdDDio5jtNg38heEINTs+60cKoM8Lor5yOSfHYeWudKZBwoJAlflARw/v5s74m7GTA7b3MYy1PvyVwS9DKn86mzbgEXKho0WKHYV3iXCz1EppX4hdxcrtKS595GvmYJJor/ZwSAKGXI9n1lityd1WHiHCxs66Fp62GkhQkHzHGyNwHSs0kiASJo1ECESpiLIvPbcVJ+W7nxbtPGuPYPaOVFfTxtGRFfVDD32yNTbZHIu81cxpcJzmCeR2sPU9BsIzfXpe19fKov94fhc/ktaLN6J4nqSQKj4XUCmu5YiQHSVfInPK80yHvGn7Wy8k4IQzYR6mrbnGrtKOtPK9mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v37dFoAODuqQNOVIOgpQK6bYar5D4/jGI3xICwlMFVo=;
 b=ITkzvJ1DQX1JIXfBXX/onxsy6lvlU58yl7yV67AjyIdX+MM92XIRm8E7mMtqWXEiMVbFwCyqHjO+9v4xZD10KHPocH/D+QCZSwde/JqMSGEsbwcfKVW2IFNoM+4M7STUFbrI+/mXY+iwW50pkI1KOnMgmadMDJl8Obi40oI2DAfpCuVPAPrS178qvBSn3Th+SdvyPHQaWQ3XN3cauM1v6az6kdpjNom/X0EEY7d3Ux8E+NzVMKWq4cTdV7aL8tyBYHaukJjZlnrYgft2t/9zqWPKjG2fMnwjcYiYGBOWoPeCsJR5P6qhBo9RUAU1FtMHxet3NLWS+g5aE0bfxI0iqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v37dFoAODuqQNOVIOgpQK6bYar5D4/jGI3xICwlMFVo=;
 b=GUSe+/w2theZt82pQQHtQ0CjIVbWv3WWWwSIvImILSqYOeIKxn5A6bK1Si1LMTKsskUe6pYdXGcf3HNrahK3O5v0hSKVvo/Yn2Z1oj35FEa8KJafFyNVEPPMk7urqsDFc3iuruMqaDcn93MtVODv3pYvJ2OYl5ms7JU8L8a8eX6j66SdocXgKr9aIJz5rG+IE1krtRiXHBg3VUxWnXn8bfEU3quiEE2MlXhk0aJoNpXvoQaXqXt1il0hYbbEj8Lc6jGAaLfhj3NqQ/2JtGfw4Qk9eJgQdA19xiRz5Jsxe2+D8pOvZ/B4FQ/2/z/u/eghDfUmmls+gSuXJ+EWOs+8PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM9PR08MB6657.eurprd08.prod.outlook.com
 (2603:10a6:20b:308::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 14:03:31 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352%6]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 14:03:31 +0000
Message-ID: <63116ac9-3a21-4640-84b4-d03612ebe78d@virtuozzo.com>
Date: Thu, 9 Nov 2023 16:05:24 +0200
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
 <ee9a27a6-732f-4f3d-90ad-9fe059919c7d@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ee9a27a6-732f-4f3d-90ad-9fe059919c7d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::17) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM9PR08MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 174b4d86-576f-4d2b-9610-08dbe12ca7fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: il52AJrWLG0wIfvedHEzNKRGDHCSuUWfHUu+HhFK0/nycVelkzJ5OeTXPvKQAj7N9ew9oYvM0AAPggsG5QKLUDa4DUReoridlk6KvUuEbkRsTNSYfOdvT9gd4g2fJosbAycfopZCJVbbXtDqA/XZLKZ7dQc1urrotpR1Bv3QIZglyysgta420QNsmBZyh6zX/cNhdgH8qP/p8GdJ4ztZW2NmoCUlCLSrp/4tau7s7CJl1e5zNLGacTPrXyxfQKnERgD5T3r8WstvhYl5jJQefngRPKVgolMXNlDTwa1OCFIXoKGmPQGgila2/THRuIgUMQF89yzi4Jbv4M+GUnNTcj3MaZHfX2cPHK5C9YtTvHxxSS3Rm1Tn6I3gMCmYwbGvVE2716VKQwiFhp+BK95XffEJCpo2IpMuX5aig947jpcQHmkAzGbZWVmcYJ0a87WEvAo2iGKqvM7bEDjWe8w3UQUrPmVFyFFulopNcpMv8pp3DSidDlX40hpljzWp9p8Jja9l0ZNeMSYsm9EsZkscAcORtHc93DCPT5naNsEAdJNrhx4XX5STUIkr7sWPe32Qe/a7haYcBPcC1OWCAOvdDxQIqvFm9C+JQGfA04aQEH5ELhSamuVcw1bB/yE5DIjpOhtj+tHlZZ3Y+gfzk7IPiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(346002)(396003)(39850400004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(31696002)(41300700001)(5660300002)(2616005)(31686004)(107886003)(478600001)(2906002)(26005)(86362001)(44832011)(6512007)(6506007)(55236004)(4326008)(8676002)(6666004)(83380400001)(8936002)(53546011)(36756003)(66946007)(6486002)(316002)(66556008)(66476007)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vi80U0R0UkJtQmFZaHVpcGM5SXhtUWcvekpQWmczak1zbWIwTzFjVGN6Z1FS?=
 =?utf-8?B?ZWlsVUhhVGdySTVGTStybkdManR3TTZiOFpaVnc2V2F0RkcwOVNHRnMwb1Y2?=
 =?utf-8?B?MFhaYnhzNzNsQ3Q2aHp4OEFvYTNOZ092dlBCeEgxWlhzQ0V6MHY4Z3EwM2Fl?=
 =?utf-8?B?NHREeFlhRWw5QUVlUGxhcEFJL2dWTU94Q3l6N1BhTWg3dyt6bmI5RFhOcEFO?=
 =?utf-8?B?WlhseGZDamJINVJ6SU9JTlVQWFpxVHBlWllLSUxubmRsbmRKdWg2Q1U1Qmkz?=
 =?utf-8?B?cXdXRkIvZTVpSjk0WU1oVmsvY28vOW9FcXpUd0NodTdsNmdTSWJaZjVsMDJN?=
 =?utf-8?B?Q0dCWDBSWUlVdXh0R210WGRKYW1EeWNKcUFOK1B3bi9RdUhHaEJISmxiTFM4?=
 =?utf-8?B?VGdxT3dHQncydkI5cWFNZHNnOWVxQ05SSzlwMjdBa1pyZzFJRmNaYzdHVEI3?=
 =?utf-8?B?Uk9qZGdBMFpsRExCRGFTemVqM2FCaUFRRSt4b21QWitoc3gzR2FRbGwrdHdK?=
 =?utf-8?B?dnZVdTFVNklWcDk1NCtuZFNENG96L3l3SmVBcmsxTksyTzRtbWlnZjIzQzhS?=
 =?utf-8?B?MVJTTmVIRjl0cHlKalF4VTE1SzVqL2RiRlpaYTRJa212dDFUOXJhUE9RbDV4?=
 =?utf-8?B?Z2J0WENUNlVxYm5JUjVwalY4dk9DbHFQQWFnV0pSWDUrQXVWOHlYNjNhUVJB?=
 =?utf-8?B?cCszb0RNYmpVbTBzZWJTRGM0cFRJZDFFUGVjYkNGUWZQbGtpNmg3aWxBK0JT?=
 =?utf-8?B?YnlDamU2eWRMQjlnQi9NTlZYa0J0SXhZWFRWK0NzOGl6TWNQam1nRnREeFgy?=
 =?utf-8?B?b0I0aVJ2L3M3NTVOMFppNWlDZlVIalJqcHJYY3NsNEtIVzIrZXBtbGw4ZWta?=
 =?utf-8?B?aHBpRFJFWjBKMWRuZ2VlY092NzFSTHMxTll0YzUxaU1WL0FwaXJLYU5sdVpy?=
 =?utf-8?B?aUcrRTEzc0JmOUNRMTFmL0FjaHoyK0U3b2ZOSk9BM3o5RTN2cWduWEJ6RE1I?=
 =?utf-8?B?dmdLdjhBM2xLbk8wY1RqdHh4bElNQWtOWVJRbnZnMW4vYWVwS1dhdk5WZWRo?=
 =?utf-8?B?L3dPbU5jdFhKNFUzUnNCUm5TaFRqanZxRGlYblp0bzlGcytQWkpvWmNCQUkr?=
 =?utf-8?B?aTNIY1JUWnZQMDdKUmpPTUQrc05oZmhucW9lcGIycE14YXp2QW92b2NmaC81?=
 =?utf-8?B?eTRvYit3UVowR2RKL1ZLd1QxRlRubEo2djNsNythSVdhaGxVTVhjWFdSV2FE?=
 =?utf-8?B?MXEzMUx3dFl5dzNsQk5Mbm5IVG96Q1Q5MjhiWlNtM1ljbFl6RXMyUS9IZ2ZG?=
 =?utf-8?B?ZllHeG5mcHVrelRSdzYzeWtRUjFRTGorSGpFVUFueGVSZmdUKzdZRUQ5SGZO?=
 =?utf-8?B?TnQ3RElLUyt1U1FGbmVIU0M2eFcyRWVYVzJYVTBBNFdQblprc0ErWkNRY1lN?=
 =?utf-8?B?QXVZWWhOUy9NbG1tekkrempuK2dhUnJRaTVZNUhWVi9LNDBFTGxNc0tIbDFy?=
 =?utf-8?B?V1NNdWN0YjFMYTZRdHp6M2JLRHIySmFmMFluTHNrRnY2dkE0YzNyNU1GZ09H?=
 =?utf-8?B?OTJOalVYSXMxbjNCYmlmQzgvQU5yTm1CM2tXUUR3bWJIcGdhMVdmY1dRQ1A2?=
 =?utf-8?B?VG1pdDRacUpQY3o2aFh4K2h0bW9tN1IvRWs3RFFEY3RZNVVxUytoZEdERkJy?=
 =?utf-8?B?U3ZsaTE0eHZ2cjZtdDl1VmtYdWJVMUZKQXRrUWNkRU9iNThvekNZVVdwZDJM?=
 =?utf-8?B?V3ozTjYrZG5CK3JiWXF6Nm13Z0ptbEJuOVJIL05YSVMrWUVrZUdQRFIrdEgy?=
 =?utf-8?B?WC9sYndwNnN5MWhYNXh6WDREQUZPUll0S3I3cHBvQXdTSW9xbVpFaU5XOERj?=
 =?utf-8?B?cFZwdHE0cVVXVVZPK2o2QjlyT0M5dFRmUDJER2QxRmtaSE0rQVBhRkxmMDhM?=
 =?utf-8?B?Q1pRNEJwMUhYYjR0ZUR0aFUvZXFHVEVlaVA4enJMaUhkcFF2M0ljN0p5ZXY1?=
 =?utf-8?B?SGlvb0U5cVFTT0tpb2Y3ZTFmNkJoZk9PSG52YUZsN29HUnlMTm04VXpEU3N6?=
 =?utf-8?B?NnovaFpvN0xhcWtZeng5K1B4R2cxZnF6V1JGaXZXL2E0dGwvTnZscmlOYXIy?=
 =?utf-8?B?OVJyVkZDWDFjRmF3NFUyNU95OHBybUsyaHV4aDlnSFpiRTluOXdFSjBUeUhX?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174b4d86-576f-4d2b-9610-08dbe12ca7fa
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 14:03:31.7174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCYFR4+ygfc3w1sZ3Z2hC+MwwZR2Z+9NpZlg8U0f0QQGXhk0WwnTr0oU/4XIfs41gguQc+3WvhQGyQTSamSIVpDnBRHBqy6U6RlsMXkf/8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6657
Received-SPF: pass client-ip=2a01:111:f400:fe0c::71f;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
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

On 11/3/23 17:59, Hanna Czenczek wrote:
> On 03.11.23 16:51, Hanna Czenczek wrote:
>> On 20.10.23 23:56, Andrey Drobyshev wrote: 
> 
> [...]
> 
>>> @@ -528,6 +543,14 @@ for use_backing_file in yes no; do
>>>       else
>>>           _make_test_img -o extended_l2=on 1M
>>>       fi
>>> +    # Write cluster #0 and discard its subclusters #0-#3
>>> +    $QEMU_IO -c 'write -q 0 64k' "$TEST_IMG"
>>> +    before=$(disk_usage "$TEST_IMG")
>>> +    $QEMU_IO -c 'discard -q 0 8k' "$TEST_IMG"
>>> +    after=$(disk_usage "$TEST_IMG")
>>> +    _verify_du_delta $before $after 8192
>>> +    alloc="$(seq 4 31)"; zero="$(seq 0 3)"
>>> +    _verify_l2_bitmap 0
>>>       # Write clusters #0-#2 and then discard them
>>>       $QEMU_IO -c 'write -q 0 128k' "$TEST_IMG"
>>>       $QEMU_IO -c 'discard -q 0 128k' "$TEST_IMG"
>>
>> Similarly to above, I think it would be good if we combined this
>> following case with the one you added, i.e. to write 128k from the
>> beginning, drop the write here, and change the discard to be “discard
>> -q 8k 120k”, i.e. skip the subclusters we have already discarded, to
>> see that this is still combined to discard the whole first cluster.
>>
>> ...Ah, see, and when I try this, the following assertion fails:
>>
>> qemu-io: ../block/qcow2-cache.c:156: qcow2_cache_destroy: Assertion
>> `c->entries[i].ref == 0' failed.
>> ./common.rc: line 220: 128894 Aborted                 (core dumped) (
>> VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec
>> "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>>
>> Looks like an L2 table is leaked somewhere.  That’s why SCRI should be
>> a g_auto()-able type.
> 
> Forgot to add: This single test case here is the only place where we
> test the added functionality.  I think there should be more cases. It
> doesn’t really make sense now that 271 has so many cases for writing
> zeroes, but so few for discarding, now that discarding works on
> subclusters.  Most of them should at least be considered whether we can
> run them for discard as well.
> 
> I didn’t want to push for such an extensive set of tests, but, well, now
> it turned out I overlooked a bug in patch 4, and only found it because I
> thought “this place might also make a nice test case for this series”.
> 
> Hanna
> 

I agree that more coverage should be added.  Based on the previous
email, I see the following cases:

1. Direct 'discard' on the subclusters range (discard_l2_subclusters()).
2. Direct 'discard' on the subclusters range, complementary to an
unallocated range (i.e. discard_l2_subclusters() -> discard_in_l2_slice()).
3. 'write -u -z' on the subclusters range (zero_l2_subclusters() ->
discard_l2_subclusters()).
4. 'write -u -z' on the subclusters range, complementary to an
unallocated range (zero_l2_subclusters() -> discard_l2_subclusters() ->
discard_in_l2_slice()).

Would also be nice to test the zero_l2_subclusters() ->
zero_in_l2_slice() path, but we'd have to somehow check the refcount
table for that since the L2 bitmap doesn't change.

Please let me know if you can think of anything else.

