Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D852D7B499B
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 22:48:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qn3L5-00034w-4e; Sun, 01 Oct 2023 16:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qn3L2-00034d-3T; Sun, 01 Oct 2023 16:46:52 -0400
Received: from mail-am0eur02on2070a.outbound.protection.outlook.com
 ([2a01:111:f400:fe13::70a]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qn3Kz-0000O9-W1; Sun, 01 Oct 2023 16:46:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8icfojvFb7Ppws5BsJYOu5bcWR8zTYi403j/h7N0VSdGmSoZHtRtPHChp8C7vnGgCogLX2f01xOi+XbDUV6iR+9+4/Hlphc1nOMNZgbcKm41NY3oS3+p+x75GgwvuNYXr0hkvhSTZ7VFk0hFPnRm/FX4TZUxyxJ984fd70LX56tb0mSyR2/Rs/ZGVVHgovVYhdZg6ivInhNy4MVrGc8Wwma7vaBSpJ/fI3Eu8wN4su7zcP5BbiimNmHTuH/rHRYkxaOrJRVnRilgVoivKjvtL5IdADAAEfZPxhnX0FDYFmHWREhmBUKNqdzAkGi6n8coCmXVa4aD7hPEfIQxV9Mew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaSnFNBneVlaarll53uQ1vhIMi2mIzCG97IZQoCnUlU=;
 b=gB/j4PdhyzNaZ3d7onbCbqwj/TlsBOTvbHxEzApvzRWOO2TZkf8Gv8N0ZQ27k4hrGeLEMhCTDNzcitRg/cYMgb+eBsMbGl3BWcO4P/oGGIA0mp8Gvq3agOemyDsWc05ggzKBIX/H16E7NuEd+MaiGQypgWpKXDFUwoi+NG0Nx7XPa0CEknAsK3W5wklEtA8FtSe2pqKj+6E7rY2/vA4bHZxWq61lAzVgm9lXTAXawZdsQ61teYy2kllxj1S8qFGc0fTtQLDxbgDkMzrc4UVJQwAivarTFzWeakFJ1IVk+PGmXqXdVI2ELt9fBqvtkhX6NxoaFDVoaLqyvm0XtRrcXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaSnFNBneVlaarll53uQ1vhIMi2mIzCG97IZQoCnUlU=;
 b=ghXTAHZbL0uoygc6Rrzpyi8i7b7Bwu0jdqh/qoa7DyJiQgHYVKcsNBgIHArCyyMAIuQWqX/1VPIgpgyfPd5lCh8IRxJBF2EYQ0VLIm7QDyY1SW9VkMZabDxdvqmRHlHN8bhxrqYhSTuGtEnD4euYs78b95kvOmFCIkedEJXNvXrxYhUoxb244vQUPeh+inNi3Isbe0Yryy+6JJpW0jonOWqaCxzOEp+iohaxp8e3+slhmxy0Mi07XNxsEKFFOwN1eMlePudOxakQZ6lXFRs5n8Wc5su3rYW7PwvMH+PtmvzB4eyZU0Ol/4goah5z0WoksovkpbsV8AVIXJMhjp4NJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS2PR08MB8950.eurprd08.prod.outlook.com (2603:10a6:20b:5f9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sun, 1 Oct
 2023 20:46:44 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f%5]) with mapi id 15.20.6838.028; Sun, 1 Oct 2023
 20:46:44 +0000
Message-ID: <d29be9a0-3765-10b1-24f1-6aa053e4213f@virtuozzo.com>
Date: Sun, 1 Oct 2023 22:46:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/1] qemu-img: do not erase destination file in
 qemu-img dd command
Content-Language: en-US
To: Mike Maslenkin <mike.maslenkin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, den@openvz.org
References: <20230930203157.85766-1-mike.maslenkin@gmail.com>
 <15609bb5-95d0-3d38-4c44-bcd313dc723b@virtuozzo.com>
 <CAL77WPAHSG-B3J_G8JzJHS5OhjsnsDs_wjYyGyPcBbeyS0z8=A@mail.gmail.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <CAL77WPAHSG-B3J_G8JzJHS5OhjsnsDs_wjYyGyPcBbeyS0z8=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::47) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS2PR08MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: d914d5ca-425c-4071-0660-08dbc2bf8596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XY9v5gBXiPOZ5fKB9KBXdSezIu6XyWsqUhrkKuMlXYCXK+Fl0zsoR5lAdRdQ+xV2Vs5a2YnvZKJZHxelKkssvnNLbplGTmqxgZu/6Ql5/eG0oyD6fOL8/3DuhvfsEQ643yqxhfeSCkDZxN6/C1mxTUHFT7GyTa5bEkp0jd70CfqWziR5mqTv8XhTObMH02G0dMyl0/TkZwyEXzaIngTIf12DWfjPsIplPfBtssQH3MWzxJ/0GCLfBsEX9Q61jgXhcz+uvGtQOuas7v6PFQ+l/icloI9tFEKuIu32cnO46XJOg+JPZ/3+65Vzo9a/IqLHV/4W4GMLmy3CLjRwyyjISks2LPSzmhetCB/5G29gYclej/QwhT+8CHkm5rSa+UCRLD3Cd09u8qfn21UE8OPDYZmC3xbo4FNGiKx8ORzz/R9s7xcgK62y/WgVyM0xIQ02iC6Bdx5d/bbk+L5yI0N8hIMWsuQUFR1MUDzTMffP6QbcSFTICHzYkU+QWVWtUpliZhb6ZLlt16HyPcw3hMauNgsWIxQT4cI/F5dbo/fd5bEBE91ZDetzgfUNADlWgRu5l9E/L0BRyqi21iXjb6o6tDIBifAvEHhp9/7ot/wn6DJN4JGbkWFXPclQthWCkwCRCXmdzRRIwODVcfdHaEU+nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(39840400004)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(41300700001)(6916009)(316002)(66556008)(66946007)(66476007)(38100700002)(6666004)(478600001)(31696002)(86362001)(36756003)(2906002)(8676002)(8936002)(4326008)(5660300002)(83380400001)(2616005)(26005)(107886003)(31686004)(53546011)(6486002)(6512007)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW16MU4zT0hHSUluZmt2OFAxSy80S1hrRFlNSHIzSE9kbUprYldUYm1CeS9o?=
 =?utf-8?B?alhYNWdHSnhtdGpTb1c4cjlYNENOd094UFN2WWt2SEFia2hraEtJN1pxbWRj?=
 =?utf-8?B?WHdJOVAzQVduNEFBeFpZZjVZcmFKdE95bGtaOHNVN1VKanlzNldTTDlwQm1H?=
 =?utf-8?B?eVBVVFRZK3ZkSC9XQWN3YVl1Z2duQk52ZEpSeUNrNWVGQVJaSzVOek10WWdR?=
 =?utf-8?B?ZWF5YVdHb1FUMDJROXRqU1haOG9HeXA0ZFBPNXA3aE1Hb3lIV3ZwNEVFaDZD?=
 =?utf-8?B?TVZPTERoeVZMYmVUS0tpQjdabXZrNG9PV2N2cnRyWkg5azF4cWtCY3krY1kz?=
 =?utf-8?B?TzVtOVJ5b1A2VTR6SjhFbUNQMzZLdklMbUsxeVNRSGRDM0lrMUp4S0NpSUk5?=
 =?utf-8?B?WUlsMXUvUzk5TFZOWGZ0V0FhVzExUEwreEZuZ1h4S3ZJNnZLMFZTUDZlWHlE?=
 =?utf-8?B?L0IyY1hvTkhna3pFU1dJamdjeUJjckFFRGQ0TzhOOVpZMkoyWXFkZ3lGTHVW?=
 =?utf-8?B?TUhzMUlNRWthc1kySEU3VjgyOEc0cHNBL1dodWV6WU5CNnlZUGJSOW9kd1ZB?=
 =?utf-8?B?T2ZjcyswM2N0ZmdnWnY3bTRuSjU3OHBtV0xOdU4rVy93THRrVkgxNHB2R21X?=
 =?utf-8?B?OHVDV3hsT1RYMVFhb0RBbVI2K3hrUCtQSXRQaFRnYlN5RlgycnRlWU5UMzdj?=
 =?utf-8?B?US9YRlFGSEhuTDJMRWUwNHFjb2NXRnJ0WUJhTENzeU55VnhFYlBSRUlVVHhE?=
 =?utf-8?B?aXYyYVNkeEU2QXM2MlpIODJpUzcyK0dVclJOVENHc1p5Q0ljbCtiSFh3OVhI?=
 =?utf-8?B?UjU4SVEvQ0l1NW1CaTZLdVVDaHk3QnoxTjlrbzl6ek45NE1vSXdtejVSdlFz?=
 =?utf-8?B?aGhOT1ZFYlFmRjJ2eXhuWU9tY1F1OHEvVTNhWHQzaE55NzhiQUlwVmpFd2R1?=
 =?utf-8?B?dVREWEpYK1pRUkZPTkN6QnFNZlNNNkJtZVZ0S1QyMlJFMXY2UnhNd2dJaVJD?=
 =?utf-8?B?TTdvN01lVDJDZlpoV0hqZ3l6d29zTTdLTDdURG8wVXFSWFVrVS9ldi94WXU4?=
 =?utf-8?B?WnU4dmJoN2psU1Q5YzNhaDA2Ump4M0owdFk5SjIwUWtCMnZPWDVZMEhKSXg2?=
 =?utf-8?B?ditVQjFhMkhQUFI2L0plVjVNVmJkYXExU1NlL09JL1MxSDZ0NGpyTW9IZndM?=
 =?utf-8?B?UkREQWZ3WE9lRlF4YTZGQTgzRWdQNERBQkhNNWx5N3RVL1o3blJNQXVuckwx?=
 =?utf-8?B?enVlMFlvZ1NQNlFCbnBDczk1S01hUk9uVHBxZ1V3Y1Fibk1Rdlh1RkVLeU9Q?=
 =?utf-8?B?dGZXdHdhdVpmWFA3eG9ySjZhTSs5bGxUekFMOGMvQzRnZ0Vmc1R1RWNjWTBr?=
 =?utf-8?B?bTkvalZnYlpubG95M01rbDVaM1hiNDZTdDhmN0RveGFhTTBDWkxnNWFPdlQz?=
 =?utf-8?B?cHc5S1RSaC93MCt4NkF3UVRNNXVXSU5PQU0xNjRtV2p6azdXelNLSGhKS3pE?=
 =?utf-8?B?b2hTcjZpYkhTOFBRZjAwS1VhOXBvakdIMGZ4T3J5ZzlMSlZGWTRld1hpSEpY?=
 =?utf-8?B?UEh3dDFMb2hvWVVpMWd5cDVtaTF6NGZ4RnlQYnhNYkNhK1p5cEtSV085dUdT?=
 =?utf-8?B?c1g4MlhXak5pQUNYN1N3dzB4bU8yaWJHRUJ6QnB6ZXlvbndrTEc0SkV5dDli?=
 =?utf-8?B?R01IK0Q0dDgxYW1KSnIwYXVEZGxJamdRVGNONks0NTY3bDJBd2t5alJxSlhn?=
 =?utf-8?B?THlNWVU4MUkxMXdkUjhaUnNDSk9zMTdJRWZXcWxTNFExRnU4STlMUXM0YW14?=
 =?utf-8?B?aERXT1BBeHhQRkJiR1lQVUhjbGFCc1doYzhhQWdtTVE0ZlpoRGxQcm80bUtx?=
 =?utf-8?B?cUtYeFV3c1h1K0hRNHU4YmpTMnRzdjJHSHR6MXNmY0hRNmJsZDFhSU5XaFlq?=
 =?utf-8?B?NUcrVlZPYlBqSGtEWGN5bUZkNVk1RndEdzFXdmFMRDFkbUZNUTRGdThJL1Z0?=
 =?utf-8?B?UjJUaGFFRVdpNnFnQTVZSm9Ic2dqS0pmYk5tRjJOa3prSm9rTDZvbzJib2Nx?=
 =?utf-8?B?ZVh5Vi9leFFTZStkYWR3Y3pCK2NSRklyOEM5TjVOZ2FidXVnL1lrL1p6ZW1V?=
 =?utf-8?Q?kLzxPwq/xJDCxgB5AIcWtQZl2?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d914d5ca-425c-4071-0660-08dbc2bf8596
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 20:46:44.0155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvUROiN8ewqJ/ucpSUclyNxV0AlPBfWbSMAPEH86T2rhZiInEbNEw5MHuA4iCJok9zGDPdW/bsjUZe+fXx2zxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8950
Received-SPF: pass client-ip=2a01:111:f400:fe13::70a;
 envelope-from=den@virtuozzo.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.058,
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

Can you please not top-post. This makes the discussion complex. This
approach is followed in this mailing list and in other similar lists
like LKML.

On 10/1/23 19:08, Mike Maslenkin wrote:
> I thought about "conv=notrunc", but my main concern is changed virtual
> disk metadata.
> It depends on how qemu-img used.
> May be I followed to wrong pattern, but pros and cons of adding "conv"
> parameter was not in my mind in scope of the first patch version.
> I see 4 obvious ways of using `qemu-img dd`:
> 1. Copy virtual disk data between images of same format. I think disk
> geometry must be preserved in this case.
> 2. Copy virtual disk data between different formats. It is a valid
> pattern? May be `qemu-img convert` should to be used instead?
> 3. Merge snapshots to specified disk image, i.e read current state and
> write it to new disk image.
> 4. Copy virtual disk data to raw binary file. Actually this patch
> breaks 'dd' behavior for this case when source image is less (in terms
> of logical blocks) than existed raw binary file.
>      May be for this case condition can be improved to smth like
>     if (strcmp(fmt, "raw") || !g_file_test(out.filename,
> G_FILE_TEST_EXISTS)) . And parameter "conv=notrunc" may be implemented
> additionally for this case.
My personal opinion is that qemu dd when you will need to
extract the SOME data from the original image and process
it further. Thus I use it to copy some data into raw binary
file. My next goal here would add ability to put data into
stdout that would be beneficial for. Though this is out of the
equation at the moment.

Though, speaking about the approach, I would say that the
patch changes current behavior which is not totally buggy
under a matter of this or that taste. It should be noted that
we are here in Linux world, not in the Mac world where we
were in position to avoid options and selections.

Thus my opinion that original behavior is to be preserved
as somebody is relying on it. The option you are proposing
seems valuable to me also and thus the switch is to be added.
The switch is well-defined in the original 'dd' world thus
either conv= option would be good, either nocreat or notrunc.
For me 'nocreat' seems more natural.

Anyway, the last word here belongs to either Hanna or Kevin ;)

Den

> Three of above do not require  "conv=" parameter from my point of view.
>
> I would be glad to hear other opinions.
>
> Regards,
> Mike.
>
>
> On Sun, Oct 1, 2023 at 3:25 PM Denis V. Lunev <den@virtuozzo.com> wrote:
>> On 9/30/23 22:31, Mike Maslenkin wrote:
>>> Add a check that destination file exists and do not call bdrv_create for
>>> this case.
>>>
>>> Currently `qemu-img dd` command destroys content of destination file.
>>> Effectively this means that parameters (geometry) of destination image
>>> file are changing. This can be undesirable behavior for user especially
>>> if format of destination image does not support resizing.
>>>
>>> Steps to reproduce:
>>>     1. Create empty disk image with some non default size.
>>>          `qemu-img  create -f qcow2 $DEST_IMG 3T`
>>>        Remember that `qemu-img info $DEST_IMG` returns:
>>>          virtual size: 3 TiB (3298534883328 bytes)
>>>          disk size: 240 KiB
>>>          cluster_size: 65536
>>>     2. Run `qemu-img dd -O qcow2 of=$DEST_IMG if=$SRC_IMG bs=1M count=100`
>>>     3. Check `qemu-img info $DEST_IMG` output:
>>>          virtual size: 100 MiB (104857600 bytes)
>>>          disk size: 112 MiB
>>>          cluster_size: 65536
>>>
>>> Parameters of $DEST_IMG were changed. Actually `qemu-img dd` has created
>>> a new disk based on current default geometry for particular format.
>>> For example for "parallels" format default BAT for 256GB disk is written
>>> to empty file prior writing disk image data.
>>>
>>> With this patch virtual disk metadata and geometry of a destination image
>>> are preserved. As another visible change of `qemu-img dd` behavior is that
>>> if destination image is less than source it can finish with error (similar
>>> to "dd" utility):
>>>     qemu-img: error while writing to output image file: Input/output error
>>>
>>> Signed-off-by: Mike Maslenkin <mike.maslenkin@gmail.com>
>>> ---
>>>     diff from v1: removed additional fprintf call leaved in patch by accident
>>> ---
>>>    qemu-img.c | 17 ++++++++++-------
>>>    1 file changed, 10 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/qemu-img.c b/qemu-img.c
>>> index a48edb71015c..1a83c14212fb 100644
>>> --- a/qemu-img.c
>>> +++ b/qemu-img.c
>>> @@ -5150,13 +5150,15 @@ static int img_dd(int argc, char **argv)
>>>                                size - in.bsz * in.offset, &error_abort);
>>>        }
>>>
>>> -    ret = bdrv_create(drv, out.filename, opts, &local_err);
>>> -    if (ret < 0) {
>>> -        error_reportf_err(local_err,
>>> -                          "%s: error while creating output image: ",
>>> -                          out.filename);
>>> -        ret = -1;
>>> -        goto out;
>>> +    if (!g_file_test(out.filename, G_FILE_TEST_EXISTS)) {
>>> +        ret = bdrv_create(drv, out.filename, opts, &local_err);
>>> +        if (ret < 0) {
>>> +            error_reportf_err(local_err,
>>> +                               "%s: error while creating output image: ",
>>> +                               out.filename);
>>> +            ret = -1;
>>> +            goto out;
>>> +        }
>>>        }
>>>
>>>        /* TODO, we can't honour --image-opts for the target,
>> may be it would be worth to follow conventional
>> 'dd' approach, i.e. add conv=nocreat option which
>> will do the trick?
>>
>> Den


