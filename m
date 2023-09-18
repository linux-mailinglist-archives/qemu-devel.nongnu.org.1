Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A08B27A4332
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 09:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi8vc-0006HC-FO; Mon, 18 Sep 2023 03:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi8vZ-0006Fv-O6; Mon, 18 Sep 2023 03:44:17 -0400
Received: from mail-vi1eur05on2070c.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::70c]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi8vY-0004SH-66; Mon, 18 Sep 2023 03:44:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbE6Dhqe6aUEnzMhPpHQV4hkpG4Jo61DzxjHw/xtVoVo1c9xToU8Ob+KJnA3co29ubQAXMjJuHvYAoReVakzFyUYbw4c4lCqNme39qgRr5C9hJ0m02y1wP49vwHZLJLbOJR3O59NdOGzrREH1XZac6cUEkn5c/AJXbGeJJ3tv12kic3ldk5/lZJcrRMBP5XUX31XT5VkpXdXh/ONwCXsCb6rMXrimLL1OFzrGn6kScHPgTafPMT7q4xZSrtfCnWeADBq3smmTXNHiEKto6XIEV2h25WSCV4VsjkuU3VNWGgpufOgl2bzu/GOQai1Ja+BCkepmZc3N8UIgw5KXq1KNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vEPdDbVFnS47nNaw/wBNmIiteiKq1N9s8qjVgg5M0Y=;
 b=Nq9CqQ3uvhu4SOrLLwCSCgLLjSDgO/ILWG19DF0c5saj9DhSgM7I2wPPOkbc7I7dbeIjpD6vIM13KbOWWx9tPFDXwDpsyJST4U5/5hmh3/BoPCmHm12vqpdXi+0207cOuEHB97qd2rY76S8pNYflzjNvCbbKlPgBatKf6UqeIrZMdeliaywmnytK4Os3hrO5cBw/VnIWuL/DIiz+bDvMqRxxTpDRuBQMuWJmBSxd6NUkMDI29yS/Yatlu3hzjshtTvserbYRRtuJefagKSVYUsaABI/eX28SSybWILT8jDBLUeuD8uOsKvFUloeKIi2ObZrEBxhtZx9nX3nHiMUYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vEPdDbVFnS47nNaw/wBNmIiteiKq1N9s8qjVgg5M0Y=;
 b=mg1oItms6iA45pYiQs81GGfmT1b5xOdeDEQvSWV41M/wuegORJK30wE7Pf65TwYQ5SD/EW05pUio2r9yij2pZTX6sa6KQHhqNgvCm6nSe2uqES7irxS0ys7KtxQGju5F8YrK2if+mruWRi2JLaw9UXxqB59NVFMaVV4e1h+0vDt5VMls+ZqN/paWIocI3ZymqKP9P38CeSQeC2XEqvOvcP6/85HV8rttSHrEp78M/X3Zrn2ULJdNA/kT78iyhZ/gWnd8cUnTJFN9KSixooNsVJnGCKwzMMXdNPE67Htk0JbQ7wsQmEbrU79sV+Q7AyV2LDx8TWeH3jeMEpu4PZnrbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by DU0PR08MB8637.eurprd08.prod.outlook.com (2603:10a6:10:403::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 07:44:11 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 07:44:11 +0000
Message-ID: <f8249f91-1027-aea7-7abe-a2468e037589@virtuozzo.com>
Date: Mon, 18 Sep 2023 09:43:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 02/21] parallels: mark driver as supporting CBT
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-3-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-3-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0076.eurprd03.prod.outlook.com
 (2603:10a6:803:50::47) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|DU0PR08MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: d1cefc70-bcd6-4d0a-273e-08dbb81b0c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1XyUkntkw3VF+OW6jmro1k2Ab4G5xiWR+FAvj0GZN9XpHws5DZfrFbPHKVMojLgkNMvk7AnW8w0wfPuyGCpRh+9Pwj4YdJ6PtC9Yy3ZjSZdcMTv5QYCqHHpykUC7NhrzthHVjX5psNCzu6UH2LbNCLo5P/3LXGBPUPc/lZFBjztweOVtLvPTSMi1GoKhhwLjyVkGQJjAzxNd6DRDp/Y6bBuyLvlDQn60La8g7zqP8fkDM7tPLsH0Kqm0q7rIdUsJ1Wagl4hiZPoFpa3ZsoNTUfzBJfU0pP6Wj4RID414yLSnnfjWeB+urhvwdDxcn39JEsWkJw+zg60DcrjOxc/t6434m2AiD55/qCdJTB51UtxdkbE/F4CqyqHC137kUUW1c59BaiTSh9qTDSHhU+9A2qXhp8HqEuI38xeXdKDoXKiThC1FVcBPGe+QGt7XOTX7EvhpH0ppMFmci3OX8zEdkrA0+1HCvAusqKCb8UPxe62oRz6m8cFcgapKbKnAVK56Hi3eeHL4i5dktaSMEH92i9UPwWgrCj8bzjb9y1e8xB0xk9dbYCdPXk2jowVJAvRvTDGIcjPLsRf33gyZFTVCFsckpLsN/julPHSGwIO4dtog2qSZFriOF285av7O1AFT325MDSeBDnfkqnMWFYCHQqopT4BGgdsJbN9SJBtkxwp5NwqNc2adwaRxAFdWTAw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(39850400004)(346002)(136003)(451199024)(1800799009)(186009)(6486002)(5660300002)(44832011)(6506007)(53546011)(52116002)(86362001)(6512007)(316002)(66946007)(41300700001)(38100700002)(66556008)(66476007)(38350700002)(31686004)(6666004)(478600001)(8936002)(2616005)(8676002)(26005)(2906002)(31696002)(36756003)(4326008)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmFoWGRqcHJOWDJsUHVNcmIreEc5UGNiNWRMSFZlRDhlc00vM0FUR3lIODh6?=
 =?utf-8?B?VzdjZ0JUYkRJU2s5TE5lWHdLS01yMTBtdFdLU0k4aFpsVGpaNUVFKzhVSkYz?=
 =?utf-8?B?Qm5HMU1tT3RucjZwbTJaV25CQ05LRFczTmhINHE0bUxxa2pyVFhDYXFIS1Fn?=
 =?utf-8?B?dkx1M0tLVFZ0NnpnbTdPSnVkYlhGaTdUYklnUDBvdXc5TzZPSVV0K2tQZlJO?=
 =?utf-8?B?UW5NZXB2WUM3R0NIdTNPd2x4blAxVm9tVlM3TVN6aHBzV21mdWZVdjZMdnlG?=
 =?utf-8?B?TldLWVFBSDkwMTlQS2FnTWJWRUtHemxVN2hPMW5yOThHWWlkZ080ODNyaisx?=
 =?utf-8?B?dDBBMmtOL1JwSUYvendKSXJtY1ZEUzBtWGtxUTJRQXdpRDZxUlJFcWprVE1L?=
 =?utf-8?B?SGFJZ0RhcEV2by84bXF3UjV1YURiTm5kbnZvTzBzOXo2bU1oUmFOY3U5dzF4?=
 =?utf-8?B?NHlTQ3lRZms5dXlZQXd0TkNHSHEwa0VQbGs5SFp1c0E1NERUa3pDcDFGeThR?=
 =?utf-8?B?bXZlNTRQbDVRSmI4U203dDFCODNpUVJFUE1YZ0dMTkNiQ3JwbE5CL2dQRDhS?=
 =?utf-8?B?Z2JvVkhRc2VSbm1US2d3eUwrTVFwSmtpdlJpZjBqSldrVWdKQmhKaEVQR3hv?=
 =?utf-8?B?Y3dLaUhrZkhGdWFZUUFGVVppaXlYYm53YVVNRkpYMmxrYll5OHplaCt4UzUy?=
 =?utf-8?B?Z2pjeUNKaWEyK080eW1aOGR3UEVmajZTVkRtR1pTakdWc3ZDalFWRDNLU3FY?=
 =?utf-8?B?MWtoRWhTeXpEMWJEQVZRbi93ZXlYZmdwVzEwUzZXVnBmSThFUC9aWGwvZWRU?=
 =?utf-8?B?L09Xd2hqVVdiQzJNazE1UnBuUjNGK0wxSkdwUktxSlJtT1BsejJ0cE1kR3Bq?=
 =?utf-8?B?TzJYMkFWeHAveHI0MGwyNUczeEFvYm5udHpXZTA5VkdFTVUzTXgwZlFvNFhV?=
 =?utf-8?B?amZ3ZFZWelFLUkFyUFY1S0JseVdwUHJjZVVGaDZBWFo0TnlPTDk2UFlOTEZJ?=
 =?utf-8?B?ZDZiL0pnTFRXWW94Mlg2Zi84ajlvcklIRXdXS2NPaGYyRllTVmpqYTc2ZUkx?=
 =?utf-8?B?T1BTME16OTZLTDIzbHFLQjRYb0MycUo1QWtudWVDUjIwb0w0SDlkL3M3OSts?=
 =?utf-8?B?NFlFcU9UNTlZbkxiM25IRElxNUlRSGE4b1N2ckE2eStYWDhINzV5VlhjTkY3?=
 =?utf-8?B?elpzaTZaWlVEMjJFRUlGQ0lpZ0ltOFBzV3NOdzhXNGphUkg5bVpBNzhoeHQv?=
 =?utf-8?B?QkFIOUNDVkNsWi81Ty90bERHZTZxMk05N1lmSXhxZGRPd29renNwK1krRTJN?=
 =?utf-8?B?dGdSMFFVeThXSldObXlxSHUzMEhSRlE3NUxFQU9yMlV4bEdWNDJBMWxEdllC?=
 =?utf-8?B?b2ljV0FBbXEydDdEV1hCWkdwU3c1bHJNZ1lYaW5Ca1JENHFpdGMxcmpzMk9T?=
 =?utf-8?B?NW1YZHRmYWU1S0dvYW8wb2tXT2hubHpHelpNM3dKV3k5cVBZMnlndTZtNTNH?=
 =?utf-8?B?V3F6WisrbEVRUFNmSTZQY2pta1ZyejhWSEd2ZDN2ZlI2T0ZNY0lva0UyNHdH?=
 =?utf-8?B?ZlRJU0J4QzRYWGFxbVRLUFQwRGt6dlF1d1RmalJ4TkpDdG01VkJtamhENnRO?=
 =?utf-8?B?QUNHT3k5WXl2anl1elVsMnNLbGlpODNxOXRkVm9QSm0vLzc0b0J0LytVQW5C?=
 =?utf-8?B?TU9ES3MvZUxXOGdsdDlSOVpJa2VJNm5nQ2dhbk9YakgxMFh0N2JYNW1CcURl?=
 =?utf-8?B?MFRiUy9GZmFSK1IrZUlsWFVVSDVKbVcwMVZuZHNHZC9sZkZNQXJsV296VHV5?=
 =?utf-8?B?eERPWjVOQU5oUXQ3MytOWEVxeDR1VDlVM0dZYXcvSVNHTk4xdnN5VFZ4SXZX?=
 =?utf-8?B?WlJWa1Nna25GTWozTUJsaXZDWXB4RFZRZTJaWkcwZERCY0VERTVhbUJWTHRl?=
 =?utf-8?B?Q250NTlYOGFFcDE5ZjZDLys3MVZJaHpXWVZHU1lOTHJReHVLUGlwb3UrcGtF?=
 =?utf-8?B?UENLM01sMGV1dGpxYWVkQjIyZWQxWXo1ZVV3WHVTbmlzVEVQWW1jb0V0elFs?=
 =?utf-8?B?SmpPTlhLTmw4VTNpdWJzc1VvTmUrL1oxSFNyZTFzd0hld3l4bnNSekRLalYy?=
 =?utf-8?B?R3AwM0pnUWpTQ2dBRnVvZ29ZREovMFJ1UUNPd0lEYU9kNUxSR2VQS1IwbXg2?=
 =?utf-8?Q?NPsMZnANURkvG8RnB7YuVNE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cefc70-bcd6-4d0a-273e-08dbb81b0c49
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 07:44:11.3691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAwCiarO6dbcMAPHDtnqiN3p5FAnTT0nH3OViARn5SSK3zcp4cmKOW+zYhQ1sXLTJX2DJLfF+ySg9RL++plk/LfL5CFWDOsWoV0w40YvdYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8637
Received-SPF: pass client-ip=2a01:111:f400:7d00::70c;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 9/15/23 20:41, Denis V. Lunev wrote:
> Parallels driver indeed support Parallels Dirty Bitmap Feature in
> read-only mode. The patch adds bdrv_supports_persistent_dirty_bitmap()
> callback which always return 1 to indicate that.
>
> This will allow to copy CBT from Parallels image with qemu-img.
>
> Note: read-write support is signalled through
> bdrv_co_can_store_new_dirty_bitmap() and is different.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 2ebd8e1301..428f72de1c 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1248,6 +1248,11 @@ static void parallels_close(BlockDriverState *bs)
>       error_free(s->migration_blocker);
>   }
>   
> +static bool parallels_is_support_dirty_bitmaps(BlockDriverState *bs)
> +{
> +    return 1;
> +}
> +
>   static BlockDriver bdrv_parallels = {
>       .format_name                = "parallels",
>       .instance_size              = sizeof(BDRVParallelsState),
> @@ -1256,6 +1261,7 @@ static BlockDriver bdrv_parallels = {
>       .supports_backing           = true,
>   
>       .bdrv_has_zero_init         = bdrv_has_zero_init_1,
> +    .bdrv_supports_persistent_dirty_bitmap = parallels_is_support_dirty_bitmaps,
>   
>       .bdrv_probe                 = parallels_probe,
>       .bdrv_open                  = parallels_open,
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

