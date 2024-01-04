Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F14823CE7
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 08:45:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLIOn-0001X5-T7; Thu, 04 Jan 2024 02:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rLIOl-0001WP-S0
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 02:44:16 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rLIOd-0007HO-Gq
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 02:44:15 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 403Ki0tp028333; Wed, 3 Jan 2024 23:43:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:from:to:cc:references
 :in-reply-to:mime-version; s=proofpoint20171006; bh=BdceHG+1k/vY
 XKybPPdLVlhnCbUXWLf38YdHUIyvrqM=; b=yEZZo5voF4Z0atOHVQ6KQ3NJJsvp
 4VooiNJ7n2G6R6+pYYNDzUM4xaKNHe853fLgfEySLrFYEjFgKagEgCUfqpK3d9B6
 9nWN2LfADB6jmctJBoqQIGeViIA8J05UPBzGM2AKboD4FnPiDGxE9BI4T2HIY1Py
 4V7yf4UoCzgEc+5Ktru1XLPVCBLWrXyfqcMB1tnKa7yv5Btj5IBo6uckRZHJYKb4
 7fa5w8F0pZgCa7TflGffB8XdFYapZyrqVGRARh64fUrqt4ddDU/w03SWVo2G/Jgz
 QOV+A6clbiQdI6nsaDqcv7oD0IdguVvnetRCGwKWSiiRtykpKWQPw7Tdug==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3vc20ww4jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jan 2024 23:43:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDbqGTOcEt2BkT/a40ln/Q6NWWWQqYpLO3qhOx3t4zl0rgKPdCrkIrVySL+0z0ecHmmdozUI3LGE+QtoTvF6AGWOu2yHtDcm0mTMAA27haoEBViypP6Pb2j6xZTpwaFhX1kRucE4VQ9UqvV9aKbbgeBibHpohS6gHpcR2aQDsY6Z+7z9VDavwqf7sU7YKR32hA3Ra2ZG6xLc6fIGtb+N6wPFWt3IpR9gPZGmb5dATMqUp2Fc57+5q6BCtbAvFQyo2s/t2kPrrkSmj0lEutSTrUrZzqbY5WRKIB7q7lvKqIn5DOT9XE9iL2eYqrV593VaZ/SLKqDq7UwO6bYb6yWWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdceHG+1k/vYXKybPPdLVlhnCbUXWLf38YdHUIyvrqM=;
 b=ZqB1+JbvuWSMMdkHsLsnnahykFheECStdOozHczNxVhBFh4Rrq1LkmJauWr87G/yQyOt5d4IdhYr/3ZGkrtD60pCvf6FvK9InHko0Trbz1pIvD3A80y7Zlnn+l9fgZ9eIbe9Tr8PhaZ2P4iR97jZnErLL/p8SaJDg29DeZmbV3/XaEkKL2qpWGfMs7fX1MWExd3xjGJ+97JSVnhXbJgEXj07NtqCBn9eQ3+VacVyRqIsls0sIoxGrNiOKXf4GxqGPFKEKqR8NgNE/qcR7pYoZvMPd5bStJGVGkVnNLXNTkaLlwNTg/WQidF5pelvYIANHWgoGtHw6fdDvxs6QJvl9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdceHG+1k/vYXKybPPdLVlhnCbUXWLf38YdHUIyvrqM=;
 b=YDkkfrzWyURfxSWkGIUvFuGm8KotDvC2ruPsq5YNFyX2F9nicDNS0/zrdVlJx1UWmdJRi0+r5uq3YJBy4gdBtojqn7z6LlCsHbWKlxd2d87opDKe17xdsA/qxnfIqc0dtnJtUI4ct+e31fYFFXqt6NHVqAtMD8usmwhKwKoAK+sLhuR0dZSSpX0p20kxpQu3wGrkbDmyAGZ0Byr4ZNCR3CcXQr1BjfNG0wtpfYBoCpoWemUJi/QGPToGWoaDvsCt3jDpD7X/x7Ea45E+kdvNAMUJnuKiZ/qC2hJ9g1nWFlVNo7bXYQsMcnR8qzK7ZGw6GdF0iJOk+DRQs+RQeqC0oA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CO6PR02MB7793.namprd02.prod.outlook.com (2603:10b6:303:a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 07:43:57 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5%2]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 07:43:56 +0000
Content-Type: multipart/alternative;
 boundary="------------zZT9ymqwhJvlU3KvyGNX3zgz"
Message-ID: <0db9854c-4e4f-4f2a-a143-16d3ca62f44a@nutanix.com>
Date: Thu, 4 Jan 2024 13:13:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Simplify initial conditionals in migration for
 better readability
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, berrange@redhat.com, peter.maydell@linaro.org, 
 armbru@redhat.com, Peter Xu <peterx@redhat.com>
References: <20231205080039.197615-1-het.gala@nutanix.com>
 <87a5qon6vj.fsf@suse.de> <62ae7ae7-76bd-4526-a002-515cd9660ed4@nutanix.com>
In-Reply-To: <62ae7ae7-76bd-4526-a002-515cd9660ed4@nutanix.com>
X-ClientProxiedBy: PN0PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::15) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CO6PR02MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: f4888b90-feaf-413f-d674-08dc0cf8e7df
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7e3dotcrneh2NQvyNXcHg05RjIOiqu6mKsk9nCX3sv9r+E3HM+00koEckiRz4PvhNNoVM2jkY19/t2C+N5iC14mBJWSQi//1uyLFH8VLLfHCMK29eYacG7161bFoV9nyL58xrhI2Bjj3DIgn6UaEDZlvu7S4PBR7lX6S4q27Cm3maxGnrNVW1icGcXNrwZrURnN4JWnFnJlLA4nqAUmrMlVnCkoeUwaBjVHLGU4EFEgw5qGJUNr8qDk6gvSPW01TnJ5Do0dKSb4jlxx+PzrezarutVjGyQFM1QPdQz9o5HM4bOjcC5TMESbbV+kJG9bz+4TejU+5qe8SUCOybvDtD5DR5LI9G6o6KG+/HG2m80g632N4XZ/TkkY78+1siWLbPGluK0MQeNB25i06+pwJuzLIP1jniNuueBp3X7NOSjYtM0COi6SZfe1IOWZtBJT08Upcr3lrB22neXzPMywTXV2oawGnkW4f0hQc+K87VlQjtW36F1Eo2Xc/okfWEUyAr9J08uYQlZUeC5EpYsfrUzJYwEf5Q0jKGGsAEnwtK/btyHytvpo5sXDrvSBjWfIVBG5lLfgX9m09qdwal263bur7o6TPKJOfZNGpJFGkPa501qlKUxVwz3s2Y6Fd6PaZ63pCsviCJh12L+QgKJYuMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(2616005)(38100700002)(41300700001)(8676002)(8936002)(316002)(5660300002)(2906002)(4326008)(44832011)(6666004)(478600001)(6512007)(6506007)(53546011)(33964004)(66556008)(66946007)(66476007)(6486002)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0pkejFiamo2VjBYcHhBU3F0QW5KSjBJK0NTbzVlbkVRaFVpVGMvbWFSZDYz?=
 =?utf-8?B?M1BsTW9VWURWbWlydWVNUm1ZVjNmdzQwQmtTMlFEN0pQSmlsRHZ5bWVZN0gx?=
 =?utf-8?B?bnpLU09yS2xDL1Rkc3kyMWZDdXlqcVEwZGkwMVBLcW5mTDFoWlFuYU1YVjBW?=
 =?utf-8?B?dGdidWk4Y0o4TDNmVlRDVW9jVE5IUEVFM0s4V2ttMTRPSVk0aldEdXg4QnNG?=
 =?utf-8?B?SUlwL0hGWnpCRVVlWFNZaVp6YUVjVjh4a1lrQ3hSSzliUTdqOWd6YWZ4c2lp?=
 =?utf-8?B?amVJTmpxeHNMRXBJcWRlT3M4MzA3eXIzZGtpeFVKMmVrTU1EeUdSRllHNlhD?=
 =?utf-8?B?MndsU0lEQk5DNXRuV2xBS0l3TWplY3BwVFFienhaaWpka3pBYklKWHlQVjJY?=
 =?utf-8?B?bWxGVzBrZ1M1NVhjemJIZi9DV2lZeWluUUNMMjNLKzgyUGhJRHNyejYwdEdR?=
 =?utf-8?B?M0N5blpiUnl4ZCtVNFFwKys0ZnpZS3pyaXlidFNDS1ZBNFFHano4OU5qaWlI?=
 =?utf-8?B?aytFRUJ3N2RIMzlSamRydzVxb0RabEtxcFFZMURKQXRSQVZpWFVZdXBxZGNY?=
 =?utf-8?B?ZTBQT3hBU0txbkI4c1EraHl4b25ZQ2hDd09JZjFJVzNUNUhBVTkzK2dqQXM4?=
 =?utf-8?B?VjNtTTJIaStPZGk2TGo3ZUpBTFpYWnJrM0dIWjVxMlozclZONzJGS1VyQ2ls?=
 =?utf-8?B?THI5QnBIVFNwcGdneUVwRVIrOVFpaGp5VExLcUM5dEh6cG5UUVR2a3JOUStV?=
 =?utf-8?B?a2lJOStydnFRcDZiaUJDNGFmU2dZa2kzVUU2NEZzd09oVjhGYlo1NzhrcDZu?=
 =?utf-8?B?UVBpb2NKTkwwNlo2LzlNSzQzOFVDeUNJbk1pYkVyZVJJNUdSVk5oT0dubXY4?=
 =?utf-8?B?SDZiMm1YeHUwdXQwSWp5bzNrVDFVeFlWdk9saXgrYlFWRmpCbFFISEFhWW9u?=
 =?utf-8?B?d1dOSytGdTdrSFVjazBTQjlUdGR6T3pYWWFtdkp1ays3MDlMSjVjcXJraXBU?=
 =?utf-8?B?dkhybm9TNlM5d2tINkRsT3RSdUdJbUdRdnk1bHpkSHQ3WHB6bkJ3aGl0NktD?=
 =?utf-8?B?bXVLRU5ja0sxVCtLOUNXSnBkek9JSTMrT2RCZTRNcG9lb2FYWmJkMzRUZkl0?=
 =?utf-8?B?SjN5ZUpwVHhSaVpydEdIS2dtcnJ1cnhCdEpUbEgzb1NBRzFIMzVCMjFYVkNq?=
 =?utf-8?B?dXlvbEdnRE03Qms5REpZMEFpRjVMcS9MMXA0dHlCcXlUeUpRVkQwalVJYVh3?=
 =?utf-8?B?SFdpaE9EMnVYeGxZM0RCemtsZk1VWmFMNE5oUTdNTnU3UnJKeHd0QjQ5dDRt?=
 =?utf-8?B?cWU3TkdEK250UmcrcDJsNGszT20yOUoveFNKdXZpZktyV1BUcWl5M2kzT0Yy?=
 =?utf-8?B?U2E4RVdaeVFNRTZONDh2elpLNXJpd0oySnc0d1lOYzY1YmF2dDhVZDRkK3Ju?=
 =?utf-8?B?L0M0VHVEblNwT1RQbXB5UVJVbEtla3RFL24ra1NTdW1VUFROSG9rb1VsbmRH?=
 =?utf-8?B?RHVYbjg4bnFXZEZKMVJBSzMrS3ZBZ01qVkl1S3ByejFQWXN3UEtSZ0VNclNL?=
 =?utf-8?B?MVV6UndobzVVZWNKUVdFWU1hQUYxWUFQSDVTQWJsT2g2Y1JnL01yclV2eU5q?=
 =?utf-8?B?NTVCL3AyeFdGQjVkRmMrTm9EbDhhUUU1OTdTcWNrTFZrb3EvS0N3eEM3T25K?=
 =?utf-8?B?bjA1RG41ZGV3dXZWR2RKUmJnenZyWkNxVkRjRWJlYjJlQ01HMFJxM0xZN2Ry?=
 =?utf-8?B?NGM1MVFOTjlra1Y2YUhQcEtTM2NBVnN1WE1tNkhtUTFpWUc5RmRNYi82RmZF?=
 =?utf-8?B?ZVAxMG1NbDhwcGk2bUNtQk9jVkloM0MvekI0aUlROElGZi9kSzVJMFlyaXNN?=
 =?utf-8?B?YWVUQU11cHE0NGhhZitxeFg4alVFRHptdkNKUkdQUnZyNHVYMkVsQUFwdElG?=
 =?utf-8?B?TEpEZ3VsNUpVK011eXozcDJWdUlJT3F6UWpEZWtpM3JpMC80ZSt1VFVSZys2?=
 =?utf-8?B?OUovd2ZmL2lzY1FZblRFU2ZpNVBId0FON3FiMUROSGFaWWNDUU1obTNaS21J?=
 =?utf-8?B?aitFVk12TUR1c3hxczhoR1V4RE94cXltUW9PWTBxeUdZNHMzdTlQaUF4SlNX?=
 =?utf-8?Q?TIdDArtX+NUpBhatV6NDy0DDc?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4888b90-feaf-413f-d674-08dc0cf8e7df
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 07:43:56.4882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqKN4eEbhiJg8rURfwjsEkerMOJSgtgYhmt7zCh5W8zg98M0JidKzaPcR9NcmNuGnaHzsXs5qxb2Kisb5JgOmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7793
X-Proofpoint-GUID: HYNisQkHaaKBQrUoq3GvNd7N4E-BGBAi
X-Proofpoint-ORIG-GUID: HYNisQkHaaKBQrUoq3GvNd7N4E-BGBAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--------------zZT9ymqwhJvlU3KvyGNX3zgz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ping. In-case this patch has been missed out. Waiting for other maintainers to respond. Thanks!

On 11/12/23 6:43 pm, Het Gala wrote:
> Ping? Waiting for other maintainers to respond on this patch
> On 05/12/23 6:28 pm, Fabiano Rosas wrote:
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> The inital conditional statements in qmp migration functions is harder
>>> to understand than necessary. It is better to get all errors out of
>>> the way in the beginning itself to have better readability and error
>>> handling.
>>>
>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>> Suggested-by: Markus Armbruster<armbru@redhat.com>
>> Reviewed-by: Fabiano Rosas<farosas@suse.de>
>>
> Regards,
> Het Gala

Regards,

Het Gala

--------------zZT9ymqwhJvlU3KvyGNX3zgz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>Ping. In-case this patch has been missed out. Waiting for other maintainers to respond. Thanks!
</pre>
    <div class="moz-cite-prefix">On 11/12/23 6:43 pm, Het Gala wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:62ae7ae7-76bd-4526-a002-515cd9660ed4@nutanix.com">
      
      <pre style="color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; margin: 0em;">Ping? Waiting for other maintainers to respond on this patch
</pre>
      <div class="moz-cite-prefix">On 05/12/23 6:28 pm, Fabiano Rosas
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:87a5qon6vj.fsf@suse.de">
        <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com" moz-do-not-send="true">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">The inital conditional statements in qmp migration functions is harder
to understand than necessary. It is better to get all errors out of
the way in the beginning itself to have better readability and error
handling.

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com" moz-do-not-send="true">&lt;het.gala@nutanix.com&gt;</a>
Suggested-by: Markus Armbruster <a class="moz-txt-link-rfc2396E" href="mailto:armbru@redhat.com" moz-do-not-send="true">&lt;armbru@redhat.com&gt;</a>
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Reviewed-by: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de" moz-do-not-send="true">&lt;farosas@suse.de&gt;</a>

</pre>
      </blockquote>
      <pre>Regards,</pre>
      <pre>Het Gala</pre>
    </blockquote>
    <pre>Regards,</pre>
    <pre>Het Gala</pre>
  </body>
</html>

--------------zZT9ymqwhJvlU3KvyGNX3zgz--

