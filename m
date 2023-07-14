Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB21753841
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 12:34:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKG6V-0007a9-BD; Fri, 14 Jul 2023 06:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qKG6S-0007Z7-Pw; Fri, 14 Jul 2023 06:32:48 -0400
Received: from mail-vi1eur02on20706.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::706]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qKG6P-00054B-6q; Fri, 14 Jul 2023 06:32:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZtjR5ZpZzLMvR94NdQk1NvBt3+dtAGUWPYeKqJcde2IvMLkxz925DOakpq3sCHPMuC4ANRWqTf0+ak6SBWJY9XCongHRdBeaNz65GmfJErTBaVzGKJssjpZhwB6FjUlAsNxPpjiK75MiygVPiUT8NRZl+2k9aFl3psoPzhbWQk3+CkBrjMSa7t1w5pCB227ZZzKKuD+3QaHGv0rOJdP0VDFUkJvvwQF9d2prlGG6NeRpdowFG20+Gsk4pvvhL50w8+7WCATKvjeFQkqfs2ZzEaFqd+sxGCqhtGw1cOgo9+Z4HAllWPx92w2kmPYXADm9ZA55GugcDWoh4Amc4cuZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcmzZBDFj5gH1WTOe8KWvxvmfQ1Td1Iv82tpm8SUQ6s=;
 b=cFRrASXTZFe+UnIk+s/w9Obk/fU1/su22oqVMbgbbBZlvG68BL5lpA1KPjh6J9g7V/NNvmUDlbANjLpEg14aLoNE8qKabQW8TVooCUVysBdNAIJfhqrS+Pjt5uy/ZRJXAw/MrBE9IFb/0kGE7ITbhGaf9JdG7L8DZU/bGJ6pQLDqioB6zdcmE3f40siftvB42mmgIntLM700mEvreno8xrTENBoWzTV0FL7mpqki54rFdraRZ/QWC955Qh2BBy0HD6NF5Y7zpZa6KvFOlcL+xbioYdB7G+3/3Ef5ePD7ZCDbs7K8WgmnZyD7qqKFv4GVs17vR/PtPqqN9+ZJrvH9mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcmzZBDFj5gH1WTOe8KWvxvmfQ1Td1Iv82tpm8SUQ6s=;
 b=XEpW1+wUSeAOZLrRJz0odNZy8c/WW3fLTc5Bn+KdUk+p8YxtJ6P8casJEan6ffpch+WAQnSV6AQ9Av4d6OAS/TFNkGPpJpQclewHV1zGjyldR8spVpTzgPtVE9N/creQzMWxh/nK73iAJQzeEnOjVwwBasAD4nhmd32nu8bfdjbffbXrIXDQcaa/HvAXk/59CICi7B8CWSw5tmEnsUu687LdjaFK43UQjlFLMct+MQknSS+CojH4o1lf8GVYm6XVDgyGavoMU5tOg42LTNTLTqDABOzVnx8Mg1rj4PxdINxUggNus7O76J572cZsAi2ESN1K7czSZKMNqqGZBuXEQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB6946.eurprd08.prod.outlook.com (2603:10a6:20b:345::17)
 by DB5PR08MB9969.eurprd08.prod.outlook.com (2603:10a6:10:48d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 10:32:39 +0000
Received: from AS8PR08MB6946.eurprd08.prod.outlook.com
 ([fe80::1e80:70d8:d23c:9b65]) by AS8PR08MB6946.eurprd08.prod.outlook.com
 ([fe80::1e80:70d8:d23c:9b65%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 10:32:38 +0000
Message-ID: <7060adc2-d5de-297c-8c49-21c67d5ce02a@virtuozzo.com>
Date: Fri, 14 Jul 2023 12:32:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [ping] [PATCH 1/1] qemu-nbd: fix regression with qemu-nbd --fork
 run over ssh
Content-Language: en-US
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>
References: <20230706191545.130087-1-den@openvz.org>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230706191545.130087-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0066.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::43) To AS8PR08MB6946.eurprd08.prod.outlook.com
 (2603:10a6:20b:345::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB6946:EE_|DB5PR08MB9969:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbedcc8-bf8b-4a59-f972-08db8455a57d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYhbi3ljZtZ6m6GYpDoxPbAUs3JY9nLJsxwSiXR1WLoR2dXeayRPmNeqHe8m9De00IXDKrbGB29sngAWtjVXIQH0iita50v99LefjzqDu4gxKpmVSUzt700yeIBKZUczmbEkmvpKyWCDBXaI6kx2at0We1F35z6zgrtDZkAKiHNngbtp5MALDBgG/D2tmWsPMZ77u81te6W5tZQXw6VgT8PhxmEKRdkJvnFtAkkj6WCCzSIRtYYa42C4IX1Yw4zY7Ulsv17W6iU2NxAXYu65GAV+lXwdihuSj5J8YBF1fb14EDn5NKdaJWRjMCBx0150WfW990bVSK/xfSdQadny/JzAn/carm7J0djvkTcdbPBxo5Yt4HSplshkrM+1TkCvtslcdFxQIh0WnV4WiZuAYBXNTfzqljTwibY79MIikoLO3uSN0cUVg2A10PsSnO27kTeJw8l+sNL76fV4T0x6zh3czUXB66Mv6nOPYPDtuYBXSOc7BZilrdwXSMlld1VPVxwXsEs628YhuszTyqyduyrbZoxS8idRSA8VSn6xh4M/ggBFkiN3yw2tVkrnu6Z/76fMSIPJm1TFdP8gFYhLGuL01wIzYyQeLsW51dLKQqx3iIh9czsXYNeNMmJE0MFXLJoP7T5jYnCttJgrBmMlaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB6946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(136003)(396003)(366004)(376002)(346002)(451199021)(316002)(41300700001)(5660300002)(38100700002)(8676002)(8936002)(86362001)(31696002)(36756003)(2906002)(6486002)(6512007)(478600001)(2616005)(83380400001)(186003)(26005)(6506007)(53546011)(31686004)(4326008)(66556008)(66476007)(66946007)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QThwbm5UU1h4cXl4Qit4Nk1oQk5PcXNIWHMreVk1TDdhWGhNYkU4RmVBdUZR?=
 =?utf-8?B?NHJYYUNTNHkrKzZIQ1k1NWxCK0xML2JPdElmSFpkb0lKRkhjNXpGcitZa0Rj?=
 =?utf-8?B?UldxbzExWjNaWjlQejAvQzB6MzlkbkpxRGU0MkZwT2FjME5JUCtZMWtjejE4?=
 =?utf-8?B?MlNIUXlxMUMwNjAxbVZ1bGNGV0lBYzBMWVhwc3U4Z3ZhZFphRjJiY0JyS0VU?=
 =?utf-8?B?REFLODZQbDRrTXJtalZhL1YzeWwzQ2dQc0dqMitKaVEwTWw1ODA2dDFBeFRs?=
 =?utf-8?B?ckRpTGRrYklwTTJXV3Bzb01NSmNTSWVTdjkrbWdmcEtPZEdVWTJDc1dHVjN0?=
 =?utf-8?B?amhOY1RkSk1uSnErNGpISFczNGZLWUFXL0ZrTkVyWHBVYWZjVU5uajUzbjNm?=
 =?utf-8?B?T0ZNNzdLeFVTM0JlVUlCZWRqWDNlSTgwWDZmVmdydzlYN1JTUWF5UDBpcGJL?=
 =?utf-8?B?azdyaVhJTlU3ZHVSR0cySXF1YWZSR2V0QzNEUzZ2eW1idnljc2FPK1lFcDlC?=
 =?utf-8?B?MUZBdkJHejkrbGJDS3kvUzNxSmNUdlhDYXJ1dTl2NExuUE1PSEpIVHgrOGlX?=
 =?utf-8?B?Z0JsZkpHKzg2ZDFScitPeTBEYm02WWdzSFZFRm9RaHozdmwyOVJaNUVqb3I3?=
 =?utf-8?B?N1RReC9mcUNrRmIwN1pDQ0IrWis5UFdiSWxYN2k0M3h6cVBFNnpLZ1FHNElV?=
 =?utf-8?B?MmRlSGpIL0pUUGxUT1NqMTZDQUpWK2o1NDJvakR3M0JzZTR1MmtVWHpVbkJy?=
 =?utf-8?B?a1pid0s2NlpGekhlTFZVajd3TzFtTzQ0b1c1bGFPT3ZIOHY5MzFKWVAyTnZu?=
 =?utf-8?B?dWFiY1krWTBqMU1yTnZ0MFFNeDhuTXdySUZ3aHgvV2ZNVzJsbkVhc2gyWEEv?=
 =?utf-8?B?N3ZibURLeXJReXNLdDBhRndCcURvWkZTcnFoOWgyYTNmU2lHUGRIdUNJWW54?=
 =?utf-8?B?SUhCNURjY1V5YStwdmpHNm9SRWVaK281bml3SFdaN0U2MEVGSDdudUROVkps?=
 =?utf-8?B?Z3RxaENsaUdSWkhEQ1ZwczUyMDl5ZkxyWURlSWpLVWhzMVRhTlRMTjlYSzM1?=
 =?utf-8?B?S0UrQjVQZnh3ci9ubkNpSHRYRlRXYUFNSllEVWc1ZERvUm9DQWZhUGU0RG9E?=
 =?utf-8?B?VmJ2MTdXNmtUdEpBUjVpNG9OdFdJZ1lPRmFTcUUrbng3U3FMOFBNcDcrTm90?=
 =?utf-8?B?VW02M3lTckZUenZYVS9naFZ4ZEpJUnVJd1NvTlNQS0R4elgxTVdIcXIzbFU5?=
 =?utf-8?B?a2h5dm5KOEhVbFN5eFlhZ21FWVY1dlh4Z1VNWVUwN1F0aEpiL1czSGFQUnZ4?=
 =?utf-8?B?eU9uVHpaSUhiVFdSb3NiQnR4U3RpRDg3OUltL2VpeWlNb2dkNjVDWWNaU1RT?=
 =?utf-8?B?WndONXZVbDQ4QVFtWW42UGs1Zkw1bjd0WmpEOEttc1ZGQzErd2MyUmUzeEFX?=
 =?utf-8?B?MVB2ZTdoSnJKcExkeldCVEM0eWY3TVhVdHFOUjB2TmoyNW9PZ2hqOURCWGd5?=
 =?utf-8?B?TEhpZUlvYk5KamNDV0hjWjFDdS9xU1dveGhlYUgzSnB0aGlaTTl6WVdVdURC?=
 =?utf-8?B?dnJEeU95b244VGZlQkRTRW5EUytjQzZGR2JRK0tRVnhna0ZybzBlTWpMTWFC?=
 =?utf-8?B?SDhDZm55aUROZ1JoTytKM0t6WGt6SlFhKy9ETTE3V05rd0hkVk5STkhMRXBt?=
 =?utf-8?B?bE1QMnk4MlVVdERjTFhURlZKbUtNdHdTS2ZubldSNDBQMWY5eEh4ZndDZ2lr?=
 =?utf-8?B?ZGxEUTNWNnNLN2ZFeHZtdmFLYlRIUjdNK0MzR1cvaUlvdzFiWUE0VTR5MEo1?=
 =?utf-8?B?REJrandIWXRGN1lJbW5VaDYwWjhLSXRYQVp5YzZHU3NXbDBkeC80aFl2UENU?=
 =?utf-8?B?cUtRNjdrNkJvcCsxaEoxU0lvYnFYRXI0R2syTURWc2lUeGVkUCsxL1lRQkNi?=
 =?utf-8?B?V003NUdaN0xJd3p5cDY4R2lJVDlScTlwbGpRTGNKT1ZDUjVJdGpnS0NLejE5?=
 =?utf-8?B?VFV1MDlZWDRqZXFvZGRqV1JBWEZSeXhuOXJMY3hxeGkwd0NYVTdJNStHSW11?=
 =?utf-8?B?M0lXK0FxNnpYNGZFaWwyVWRZTXVRRTFKdVUrT3Yrc2dycWtCTS9DNUVwM3h3?=
 =?utf-8?Q?Dyh/INN36OlKhI7TeBN1hc+Iw?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbedcc8-bf8b-4a59-f972-08db8455a57d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB6946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 10:32:38.8066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3z75Fk7WeU6qh4fiAoAjXu1U1iey8Nv6xYD3QLKLf42SccTPxyNS2w73KHzndT9Axi5guPTYatBIy1HqKtgqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB9969
Received-SPF: pass client-ip=2a01:111:f400:fe16::706;
 envelope-from=den@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 7/6/23 21:15, Denis V. Lunev wrote:
> Commit e6df58a5578fee7a50bbf36f4a50a2781cff855d
>      Author: Hanna Reitz <hreitz@redhat.com>
>      Date:   Wed May 8 23:18:18 2019 +0200
>      qemu-nbd: Do not close stderr
> has introduced an interesting regression. Original behavior of
>      ssh somehost qemu-nbd /home/den/tmp/file -f raw --fork
> was the following:
>   * qemu-nbd was started as a daemon
>   * the command execution is done and ssh exited with success
>
> The patch has changed this behavior and 'ssh' command now hangs forever.
>
> According to the normal specification of the daemon() call, we should
> endup with STDERR pointing to /dev/null. That should be done at the
> very end of the successful startup sequence when the pipe to the
> bootstrap process (used for diagnostics) is no longer needed.
>
> This could be achived in the same way as done for 'qemu-nbd -c' case.
> STDOUT copying to STDERR does the trick.
>
> This also leads to proper 'ssh' connection closing which fixes my
> original problem.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
>   qemu-nbd.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 4276163564..e9e118dfdb 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -575,7 +575,6 @@ int main(int argc, char **argv)
>       bool writethrough = false; /* Client will flush as needed. */
>       bool fork_process = false;
>       bool list = false;
> -    int old_stderr = -1;
>       unsigned socket_activation;
>       const char *pid_file_name = NULL;
>       const char *selinux_label = NULL;
> @@ -930,11 +929,6 @@ int main(int argc, char **argv)
>           } else if (pid == 0) {
>               close(stderr_fd[0]);
>   
> -            /* Remember parent's stderr if we will be restoring it. */
> -            if (fork_process) {
> -                old_stderr = dup(STDERR_FILENO);
> -            }
> -
>               ret = qemu_daemon(1, 0);
>   
>               /* Temporarily redirect stderr to the parent's pipe...  */
> @@ -1152,8 +1146,7 @@ int main(int argc, char **argv)
>       }
>   
>       if (fork_process) {
> -        dup2(old_stderr, STDERR_FILENO);
> -        close(old_stderr);
> +        dup2(STDOUT_FILENO, STDERR_FILENO);
>       }
>   
>       state = RUNNING;
ping

