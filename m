Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F3582AEFF
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 13:55:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNuYo-0008K3-Ls; Thu, 11 Jan 2024 07:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rNuYh-0008JB-OY; Thu, 11 Jan 2024 07:53:20 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rNuYe-0007Yv-85; Thu, 11 Jan 2024 07:53:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IV0x/rLSeiNWJKFPATXOAYVdSPRavHmAN7UED4bz8bcucUH1p0s2NYKnDHoe3jhGVRl6XFRPTSxakTeQLTFdpLX2lLWBACITmJdvDREDhizRpBefE1KwGlKsreXZqBbUb2Ob5wRiOXVAVXbeitiFt8nE0mJWMnDC1NQ9ZwZzAc1F0Mq52GMAUhwI98MCE3U2EwCtss0ghz9HAeBOl5cvGDkfb/w6wTzYSLhZNscNkhUoM1hluLkC8XvP7CI/82NRUUIz8WVhfjusrWQFKVocP0CxeeZyDQRowv1hLbPuUtpa1r8ZEDrYaOaD+oWmKmJlb3jKSOlI9H0XCZClqJl25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/PJW9NDBCQOoZzrANVZqCkblJnqEmnyG5QIqCrSDSo=;
 b=DAgzxKpge3bg+8hyQCaUVkmN6bLQncssULSftOiKTywsMm+ByxlR9NL03hurJ7PcbErNC7chWlIZPjtDLXkxg86/+5c8J7lS2NvP3we71OpSl6bouDoNc4ahmM2n0xJCAb2QQ/1XKFcilXIoLcGymHkoaVsZC52j8CrExO/bnNyOwbsfmn6vZ78iADKGXAObU/+DRNmVf79KF//W4y6IJo8CaSWxx3wn4VBDMgCUbpqoifCSTnCv43xXisdM5jGOTJRMwqSSHhFwYFHfvBl084QRdqIfkEjBWQDTXuI6MrIacKQoJzyKM85czT6mcKq+DFTQ2nLJr/0wdugSKckZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/PJW9NDBCQOoZzrANVZqCkblJnqEmnyG5QIqCrSDSo=;
 b=WsPhFI4fLQscW7K3AAD034FS/skb5Cn+kdr8w8i7QLovBNxxOQdmCEher3aVFcoNuflL251l3Gw1XBdjNITttX5LE3vRVydwXP2cfR/cZJcidOpl2DQkqBvuFq4egYtK/Y3gnGRqnL23rMh14citr9b0TDHfVfKT7G7+MBXCJ9CiCVf+juzTW0VlIyKxokfNhA/b6j5TM9ti/0p/aj05SCGDC4uuwRTTFbVdU+Zgem0nBu2ZmUolixvPeCA6IgdfRJx21SG6e9zooNq4H6xeyIDDtUjCD8J08c6yaAFb98miYuaPSAGy7tB2u2lB3B4RUMhXlYWgCPJ8NIzMN96o0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB5634.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 12:53:10 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e27:1464:bac8:f696]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e27:1464:bac8:f696%5]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 12:53:10 +0000
Message-ID: <cfe9a043-43c1-4054-bc99-5576cd0c34e7@virtuozzo.com>
Date: Thu, 11 Jan 2024 14:53:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests: don't run tests requiring cached writes in
 '-nocache' mode
Content-Language: en-US
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 den@virtuozzo.com
References: <20231211133223.695048-1-andrey.drobyshev@virtuozzo.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20231211133223.695048-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::15) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: e2dbdb50-d7d7-45f4-9dea-08dc12a443cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JxzQ/19k1VV7dlWBN1txV3uVAcjVLGkUiQ3utBQsyh+tGa+cgxjFDW74AQtzqgHTK8fMtsmJSUHrfwLbOGscsBVGRwXvzPuZQ3YtJptalUobH/Td+QbE90TZzoRz3xKafr5L097TowRs2NTOEWWHUBGU9MXG/vd6xaomiSOzD9pyaRt3r44NJJulU2/37C/ysfo/P4xt3ZlojfRoc36bCzDPpewVo1Hc0Apn+Tm4/Bl56pxGIVJsTzDAKXVnePHmiu85ltWpJRJMEKdYK8TXU4eSPx4nxEkHhUF2ZLuFjfE4wbN8ejtCVfSdE6PjJMv6t3IVT+t2UeZIeXdeom3bRTPO2RJV4vJEX08bRqiUmYxqqdHW+lCeOYcZws38yQU3cAI0UWbo8WGr27YMWWv1+NZnGXFHrsZKczSXWbwcZOyl+TirEovqZMIuI0S/+QIF/tj8WCUdYv8Iiy3eFIKypLkThoqjb4E2uDmJH1vigMmRjMGOka5mxbhQn+BiwRodzsW/4dSeECepteir+0bsdjTwrCLyKt2W53l6oHhoham+tzHO5Xj7jGeTGk8VEI+ZkJ+vOdQdj76etyogvkeAruFe/6NUuNLitlTS6qgLNBXOrPHaG/bld69kb/8puD8yw6+1WUdi94G0SQvmbuPmTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(39850400004)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(966005)(38100700002)(478600001)(83380400001)(86362001)(316002)(66946007)(66556008)(66476007)(6916009)(31686004)(6486002)(31696002)(53546011)(6506007)(2616005)(107886003)(26005)(55236004)(6512007)(4326008)(8676002)(8936002)(5660300002)(44832011)(36756003)(41300700001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDl3K2RDT2RkQ0kzK3hYSzMybTc2NTJ1aE5BeUdCbDdQWmxEZmExRjN0d3BC?=
 =?utf-8?B?N3c2YjdiRWsvNkZFcjVrSEpWL3hsZUlpVkk4TzlReERNUDVTejlRRngycTJj?=
 =?utf-8?B?SWhoTW1paDFGalk0NnZVeGYrdEdNcUxWWmR4RFR3TkRUKzlFcWxHamViU0g3?=
 =?utf-8?B?NTZYeXM5Sjk2RzQrWDhEYnQ2cXZHRVB2MzZkVms5NkM1SVhyekg2RVhaclJP?=
 =?utf-8?B?bXduYjBmaFkvRHk1UW5uM1BxN2hkNFh5c080SjlOSzNkZ3hZS2FjQk9Oc01O?=
 =?utf-8?B?SlBNZlZoUXMraTdPMHFFaHI5QXU5L1FYdHZ4dXM0eE9FNVIzNkEwZTUyQnc4?=
 =?utf-8?B?Q3JmdW1KNDlYYmFZQ0JodzdDYTVYcG9HUC90YTBiS1Nldk9VUHljVGhnRUJ4?=
 =?utf-8?B?bHMzMWVWYzEvdnBLMDhKL29uaWxTMituY0pFdnFpRTZLU2tqTWpXWDRqSGkz?=
 =?utf-8?B?T09CRDRMQTBXMDNTdVdkdUVUY2ZiNU1icGdvdHgvNFIrM1lHQmlvTjNycXNW?=
 =?utf-8?B?eFIvdjUzdXkvSGU0RlNCNUlMVHRVeGRFQUJYQXd2RGZEMDJ4OVJmMUdxUlZH?=
 =?utf-8?B?K0I0ZEJTSDdpdEt6YlF1dXN4YVdjZ2pEeG5tV1FMUzIzVDBTR0dBN1dYcWt1?=
 =?utf-8?B?dHNEa0JIZG1WWW93MXpyMlhrWkJjVFZSMEE2MzRreXFMbXVZRDlIcWZSaC9C?=
 =?utf-8?B?WFQ1NFo2TzhTSHBwT2oyaUppaHdyRDNVY1psNFFlZW1yc28vYUc0MFFzMlBl?=
 =?utf-8?B?b2UyQ21wOFhNN2p5cDFYdG11dHJnT0FmUjhkcjRtMjZkYk1RcjNPblh1RitS?=
 =?utf-8?B?eGVqR2Z0VGF3azI2N0hNVVhNMjFsUEU1WFBPa2tSNmFIcjVwYkd1RlA2Z251?=
 =?utf-8?B?dE5RWnQ1Y0wvWllGUVp0WEVSbnNPWHhhN0FkYkZhdkJHZjFNSGYvYmh0My9v?=
 =?utf-8?B?Ky9tTkZ4aWd5am9sWFFOcTJxN0lhUzFqdzJxSEJxSHpiUzEzRkdnOG8rWjFT?=
 =?utf-8?B?clY1UVhCNEhpU3IybEVnOGdLbEYzaklEcWhTRTgwVHhTS1BDRWQrYi9oN1FN?=
 =?utf-8?B?d0ZVNWxrTlN2NWRMTUREd0FsKzkvY05KK05oU29wMytwUkVxRll3bW9LRXp3?=
 =?utf-8?B?dWVtSWFPejhveEk2ZXpxeWdvTGoyM3M1eDNjWHFZRFpMQmt2QzF4K0pkMTRY?=
 =?utf-8?B?TXA2MWhGYmYvVkpORDAxYmRjQWU1Vk9hUGNVZGkyK3FWYml6MG9qQ3RkVVdt?=
 =?utf-8?B?bVJEaXozWU1BMVpYOUtWQUtyY0U1a0M5eTkvSGRETDdFakIrUjYrdS9mV0lO?=
 =?utf-8?B?d3NKWHZBNTZOd0NjaXRFUnM5ZXlEaEF2Z0VwRWFMUGZyUTYrMjB3a2p3REJo?=
 =?utf-8?B?Wmd6bXlxaEN4dTBaSVJta3k5a2RHWCtDQ0g4WDErTk44L1F0cHFYaDJoQmtN?=
 =?utf-8?B?RmE2d2hFMWhiUlJpa3NIWU15TlB6Z2NBZnlJeFg0OFMyVXBUREZVTTkwNWF4?=
 =?utf-8?B?MllTdFVmUzhlV3h4YUtTcmZPYjlEZUVwRklaRkE4OVEvcSsxR3g1NlZ3SXIz?=
 =?utf-8?B?WnoxYmZldy8yeUlzNXppRHBPOERnbHJvRlJJZEgrK3VVdktuTEVKeGJnTUNQ?=
 =?utf-8?B?ZVJPS2xIYTlpMWh0dWxzeEovKzdXNEZnVXVyN2lsa0NFUnFQeWExTHN1RGVN?=
 =?utf-8?B?cGxqdEZnVWQ3WGxSUENGdVBnZGNneVdXNVFZN1VPMkM5OEcxV3dRbWRJTU5O?=
 =?utf-8?B?QXFmcy91UStUbVl2NUhnSE11eko1YTRYUld2b0V0dVA1VFVsQXdyT3VTM2Nn?=
 =?utf-8?B?QmcrSlM0SDU4cHlpQTFhT0ZsVG1Rc3J6T2hPdVpwNC84cldxdy9VOFZiZDE1?=
 =?utf-8?B?SWlLdE05aGxjK3hiSERIQkRzbGkyeFN6K2lXL1JIaVYyUkMwU1BxUzhES0hz?=
 =?utf-8?B?RkFxY0xPWitZdmREemJQc25aSVF2ZHM3MDQ3MnVBNk9KSm96TVNUTkJSWWk5?=
 =?utf-8?B?UFpDSHUvZkx4M2RicEs2Y0RsdE1PdkpjS3lPaEtMdG9RZG16M2FSRCtmNFpw?=
 =?utf-8?B?QythTU8xaHRIcGNUdEQyUm90YW1SWjhUMjIwUXZ2RjM1Q2NKZlBpYTR6RmdK?=
 =?utf-8?B?NUoyNGRiSUNhV0tiaWlvNUZTN2FTRHdyNnNJREoyaDBYL0NzZERxMy9VV0hz?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2dbdb50-d7d7-45f4-9dea-08dc12a443cd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 12:53:10.3211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6lxrSHlYGidaE/arao1IuSeFIX/927h2X8jRVWLWX6WHJul2kUOYKQmJVVXFIiyP8LJJ01Y+o2/zy1V1ETmknEEYfCz2IfA6N69wwyS2xE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5634
Received-SPF: pass client-ip=2a01:111:f403:2612::701;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

On 12/11/23 15:32, Andrey Drobyshev wrote:
> There're tests whose logic implies running without O_DIRECT set,
> otherwise they fail when running iotests in '-nocache' mode.  For these
> tests let's add _require_no_o_direct() helper which can be put in the
> preabmle and which makes sure '-nocache' isn't set.  Use it to skip
> running the following tests:
> 
>   * 271: creates files with unaligned sizes, thus producing multiple
>     errors like:
> 
> qemu-io: can't open device /path/to/t.qcow2.raw: Cannot get 'write'
> permission without 'resize': Image size is not a multiple of request alignment
> 
>   * 308, file-io-error: use fuse exports.  Though fuse does have
>     'direct-io' mode (see https://docs.kernel.org/filesystems/fuse-io.html)
>     we aren't using it yet, thus getting errors like:
> 
> qemu-io: can't open device /path/to/t.qcow2.fuse: Could not open
> '/path/to/t.qcow2.fuse': filesystem does not support O_DIRECT
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  tests/qemu-iotests/271                 | 1 +
>  tests/qemu-iotests/308                 | 2 ++
>  tests/qemu-iotests/common.rc           | 7 +++++++
>  tests/qemu-iotests/tests/file-io-error | 1 +
>  4 files changed, 11 insertions(+)
> 
> diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
> index 59a6fafa2f..1424b6954d 100755
> --- a/tests/qemu-iotests/271
> +++ b/tests/qemu-iotests/271
> @@ -44,6 +44,7 @@ _supported_fmt qcow2
>  _supported_proto file nfs
>  _supported_os Linux
>  _unsupported_imgopts extended_l2 compat=0.10 cluster_size data_file refcount_bits=1[^0-9]
> +_require_no_o_direct
>  
>  l2_offset=$((0x40000))
>  
> diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
> index de12b2b1b9..535455e5b1 100755
> --- a/tests/qemu-iotests/308
> +++ b/tests/qemu-iotests/308
> @@ -52,6 +52,8 @@ _unsupported_fmt vpc
>  _supported_proto file # We create the FUSE export manually
>  _supported_os Linux # We need /dev/urandom
>  
> +_require_no_o_direct
> +
>  # $1: Export ID
>  # $2: Options (beyond the node-name and ID)
>  # $3: Expected return value (defaults to 'return')
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 95c12577dd..f61eae73b4 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -857,6 +857,13 @@ _check_o_direct()
>      [[ "$out" != *"O_DIRECT"* ]]
>  }
>  
> +_require_no_o_direct()
> +{
> +    if [ $CACHEMODE == "none" ] || [ $CACHEMODE == "directsync" ]; then
> +        _notrun "not suitable for cache mode: $CACHEMODE (implies O_DIRECT)"
> +    fi
> +}
> +
>  _require_o_direct()
>  {
>      if ! _check_o_direct; then
> diff --git a/tests/qemu-iotests/tests/file-io-error b/tests/qemu-iotests/tests/file-io-error
> index 88ee5f670c..2b8dc7f009 100755
> --- a/tests/qemu-iotests/tests/file-io-error
> +++ b/tests/qemu-iotests/tests/file-io-error
> @@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  # Format-agnostic (we do not use any), but we do test the file protocol
>  _supported_proto file
>  _require_drivers blkdebug null-co
> +_require_no_o_direct
>  
>  if [ "$IMGOPTSSYNTAX" = "true" ]; then
>      # We need `$QEMU_IO -f file` to work; IMGOPTSSYNTAX uses --image-opts,

Ping

