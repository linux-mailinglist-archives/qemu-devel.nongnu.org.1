Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C0E764E45
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 10:56:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOwMe-0002Sb-On; Thu, 27 Jul 2023 04:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qOwMc-0002SM-CZ
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 04:28:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qOwMa-0007Rv-Bf
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 04:28:50 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36R2S0qX028768; Thu, 27 Jul 2023 01:28:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:references:cc:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=Sxit//dXsFuPDPEneEEmP6ob+XHcZwIIeVW+4GZ+u
 oI=; b=K7WinLDZ8Z91BbgdeFTowcqhQbU48SU6LqoGSWMAqZbXUvpPZqvZ2J6eO
 UORu2dPH/xSor0TYq+jHvQOa9Lrcvw22ZJihwiNQDvtzrbJC/KM5vrdCVYBaS6+p
 CskHiEZ5mfKG38tCpZuN46UdvujDLyvzlQpQOILTxw1ymHPxs3igK7U/lG9qgMhd
 9GDB5+QJ2l3JW7eb/v4rAom7TaonodSwrByYAoQdZQI1BJJrp6ug5RA4xMEyQs86
 LYCPLcuSz4sH7lb8dVfifUxlcvfnGcfiD8ryXMeXwym6Soqy/RH1VbeHYpUymF7z
 fJ3fyiAWiPeHh/l1eyaNYQYnEEX7w==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0b1721mb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 01:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCrFnC+AMr9nRWvKGghEqHgtO98s95Rubj8U0/WBw+MjrBsvBJEgjLLRhr43faILTEnUlWVQDTSQDLGZ8CPYcMKI9j1SlObuS2UneI7lBbcS2b9Yc669SVCLsQmf/AFIp1TeV5uo8cOAcoFl0Hjm3jyDVRtnCybtarnAv+qLUqwxE7dPct9eS80pYpII86Rrt8GMong8OYAeRd1qDavEy0CibR6IvQnRf4zFlkpTd6Zstl89XxtVpuEBdk5vmLfuRPU47ONUUuog/ke0yPjz9J0iW/VYgAbUZ3sfZyX3tar4OA0k6+s+EY3is4nPtU85y+FVsol8f/TQl1pxOwvZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sxit//dXsFuPDPEneEEmP6ob+XHcZwIIeVW+4GZ+uoI=;
 b=ZQSkJ7FDhpKCU0nQWPxsGOSFMMYfVITkT5xcgycJBQ4EHsRufamfQTu7GobjxjKFbiAH7vWwLd+8FQwHL9JwHenceA1DpeCJg4XSveuddXGDBIRVueQDgvQtBk9Q9mjjuwlcwQLIvNQxmLguonS1ztFBjWwoBZXOleUivbC7wRtEpBd7DeunNPrtZnUpQqDj9W8JAKLNOlZPT22jcOdI9UWsEc4/TlNxxg3yicebV6Ai9eQWoNaabQZkj+8J31xZyw3R2fRkYBYVDiUag32hDezA3G7AjthwQbo4hQnOD5H7C3uALp9HHR3qHIsK7/GwJuqf9ZM2fccEkLXuE3o9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sxit//dXsFuPDPEneEEmP6ob+XHcZwIIeVW+4GZ+uoI=;
 b=DXeRHhQdskQZKs/mLuvhJoWtefk+zxYUefhMdRX7G1oISwhZBsTkhkZ7+10AUKxXDXVFsiNdwOnE3gwSiAj4UKzpjcAWG1tIAcFD+dvLtDIwuXKfk2xSIbX5hBemVsb+HbM4aq5VF8A1G0iGlF1eW0DnCW/KV53QNqLBT5yjoOG7BPgeSZ/Ywe0UaSSifHaE2UcXaukVBtEgoYkbraVgaa1uculHnAWrM7QWf8PwpDaLmEC1YqMBWA5j3V9HBy+ZWAmo7nwCYhT1fAeYWeIa84nCryA0yiDWCFIIgdQ3aiAIMIFGzXdYm93TVlqymxIE8JXSpAXruTqEAZmQeKSi4Q==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by MW4PR02MB7380.namprd02.prod.outlook.com (2603:10b6:303:74::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Thu, 27 Jul
 2023 08:28:38 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::82a3:a948:abf6:8676]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::82a3:a948:abf6:8676%2]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 08:28:38 +0000
Message-ID: <cd6dda76-c622-56ad-c007-195d64feda01@nutanix.com>
Date: Thu, 27 Jul 2023 13:58:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 21/30] migration: Refactor repeated call of
 yank_unregister_instance
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>
References: <20230622165527.2417-1-quintela@redhat.com>
 <20230622165527.2417-22-quintela@redhat.com>
Cc: qemu-devel@nongnu.org
From: Tejus GK <tejus.gk@nutanix.com>
In-Reply-To: <20230622165527.2417-22-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::6) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|MW4PR02MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4a4d8a-be5b-422a-16ab-08db8e7b799b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8xXk5niX6R9mzATEoCIiOi/mShyUMTxjio+/bab1VlKkUZ1Y2SD13D9ZkpMOn6SXftSMRO/U7g8YC8/VasOyPK/ep0+Yq+2yYffwCAOnzG5WWEchsiDaCMMkpD8/oCl62fubBWkpKVXGLyO8FjVAwsAENJKMk5crdHXAgkWLdXXMDmZOA21gPgjWzD5lLPi519XNh51S63S6GV+6QupgdT9ZClsqNgUG3FuBK1dyerXkDr9UrOAWp7eI0AU4U+9SWHb17FhQRZXLSJbKtc5azbatcvEtrsa7vyVM7qdMM6Ky4ClRCVu9ZaISnNv+Ad0admdw4WncyB5G8kPKrqMlb/WECgzv3kvr9Gd5SKWCqAj/J7yF3ra397HR32um+tuVRg1R16fEIVcIthFZMQy3w9Zv7LLBtrdNCuJEhMxI8GI1VsY2R2gTFiQJm5xQs3fEGNLSuFTNt2S4zPFcsM3Z1E2VHuMNANltQkpHlO8YIIyIIHhGe+HpZRkubCVcjxfJcaxhIarzszgJmdiNPmfrWrXwIVF2/mPbwxrb0OezbzJxix62/YLVPWDsFn9a5RqtbSV4fMh2mNtrnA8vljVbhGUUdBUhYCWEr5uk1I8M5h6+kWZRtLQBjIXMtm52q/4OLVeRNKqVejv3KdV/GFHo2l4R3NpqF4TQcyTWgFy1/dtaVKgIpBLLrc1kHWFByT7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199021)(6506007)(26005)(478600001)(53546011)(186003)(52116002)(6666004)(6486002)(66556008)(6916009)(66476007)(4326008)(2616005)(83380400001)(31686004)(6512007)(38350700002)(38100700002)(66946007)(5660300002)(41300700001)(316002)(2906002)(8676002)(8936002)(86362001)(31696002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0NvWVdXTGQvNHhSOXdmZGVJelU5VXdPaExrL0RuS3pwUWNveFNjNW0yNWJu?=
 =?utf-8?B?NnN0Q3ArbksyNjhvY2x0QnpXTnRVbVp4dHpQdEVZZmExMExRdERFVjYwUWQr?=
 =?utf-8?B?WlNQdkRmNmlWQkZlSmZSbENVUXBxNXl4N3lpdVp6RUt4S2RNSFhpVmEvTTBI?=
 =?utf-8?B?K1FKU1JEWlNzNVBteEpoR0ZvRHZ1cEhLQ3JVMEVwUm1ZYkN0SlBIWnplOUMy?=
 =?utf-8?B?SFNxS0d0bGdmLzVmN0NIQ3JrRDRNc3prYnNac3VZQU8zQ3VqSXpWc3JxNmJs?=
 =?utf-8?B?Zy9IT3RpTnBWaVFJcFphSUdscDJGZEZhdHVzTCtCWWVlWUFydGNUVlZ1YTA1?=
 =?utf-8?B?L2dSbTVnVHphRmQ1a2xOYXlBb3gwL2RLRm5TaXBBQ3ZPcEw3Wnl1R1N0T2wx?=
 =?utf-8?B?Uis3U1pndlFmSnI3eWo2U0k4V2Fib1BBQnRiejYyQzArcTdDWStXYVd3b0pL?=
 =?utf-8?B?SnF5OGR3bVE2Y0IwK2FudjJmS2pNdmtXQjFVQU5RQzhESHNqMkVrZ1NScjh5?=
 =?utf-8?B?R2tPSHJrRmlrY0JsNitodXN0dERXejdhaHNlYUpBUGFIb0NDZldiUzN1bDM2?=
 =?utf-8?B?eWNwUWN2QzRLRzcrck8zUjA4WG9qRHNpQ0hjaFgvNWt2TjV3NWhKRE1MRDk3?=
 =?utf-8?B?cHlacnA3WEpIWklSRHVRY0JMVVNIK2xNYU5BWk9TeiswVDVwWU5udVBXR2RB?=
 =?utf-8?B?WFE5Q2lHQzBLK3pZVUp1QUZ6ZTJ1WVlZdGRvT1ZDYTRrc1dyNGhKUHlXTkdY?=
 =?utf-8?B?WXpoYXdKeEpBQVR2Qys1Z0pSeTYycVQzOW56R1ZPQXlaWTJyYnZ5SW40bXZQ?=
 =?utf-8?B?ZmFDMXB4R3h2T0RlUzVjZEpnVXdQR0t1ZitKaEI1NGZkMmwrT1RiYUJjNldE?=
 =?utf-8?B?T2RPc1cxbGYxcjRoUUFqM2tHcWlNNUVEcEI5SWp2bmIvcFpmSW9YWU1IY0NO?=
 =?utf-8?B?V2t4aVlyYmY5bjdEaVFMaHZaZmZFdERTUFgxd1FhaUVIM0RxUlNBR2pVT0ZX?=
 =?utf-8?B?RkEva2dQR3huSTJldVRVcVVZOStFMjI3ZjcyUG4zV2NONlBNRkxoRCtKZ3Bo?=
 =?utf-8?B?ZDN5S0FvNUcrWW84ZEsxcVRJanJzWmhRY2hzYW11NnkvWDVGVGpwM2FlYzFi?=
 =?utf-8?B?Yy9wdmlCVmZWM21nK1cyOXBURzNIaFROMDhxVlVXSHhGM0FGNFZkRzh3aERM?=
 =?utf-8?B?YnllYjRsT2hNWC9xMTV5elFBbDRxSkwvVkxucm5wOTFrS2w4TllweFJscndz?=
 =?utf-8?B?UGwrSklZb2NWRitPWGY0UU5CUTVZSHMyV1BDeXkxK0R5alY1KzdhMktvR2w0?=
 =?utf-8?B?T0plRllyYW5mczc3T3NUUDJmdDgwMnhXMythWmFDZHdqT2dQbjVtQXAxM1NF?=
 =?utf-8?B?VStpNFVaRDdGTGZKNEhYQWNWS1ZKU05RTjlEN0lKRVdOQUJ3VUhnN252eWlI?=
 =?utf-8?B?VGxlMXBjU3V0ak1nelIyM09jVENIcUwvenBhS0h5ODdqOWZHbGlXeGJ5eXo1?=
 =?utf-8?B?RDJDYjVaRy93bVV4Vy9CYnZSeWc0UGdHOFlLaTlFdi9sR2h3UHVnd1RqYmVt?=
 =?utf-8?B?NGtuTVFGbFlEc0wzeklHOXh0Lzh6alV6L1VwZ09CeHVseVl4dmdTdW9zODNi?=
 =?utf-8?B?cWZaRUhwOGR5VjJaVFQzZUx3Smh6M1MxMzBkNmVQaTRhNnRrVHdudFNtOWZh?=
 =?utf-8?B?SWswMEFPWjRUOWxXU1lLWlR2NitmN3l6QXpXM1ROOFBkdkQ0dUhoTVZZMTBk?=
 =?utf-8?B?b0pkYVNhbTVIWE55YlBjTjVQMy9TaWg0NFpMb1d0SWY1RjkwRFpHcU51Wjc5?=
 =?utf-8?B?OGNmUWpnSlg3aWJrWU9Yd2VnQnJoMDMvaUhrZUx4R0JRZDlFY0hrNDM4TENU?=
 =?utf-8?B?Y1J1cWtVSjV1WmcxQ2hZSHFza2hPZzJ3NmIvWmg2MnQvazhLREdWK1hIREZi?=
 =?utf-8?B?TkVUMmVBUGsvT1JVNGJFeS9TK2U3R3RiWk11RkUydDdtWGRGUU52VzRmSFhz?=
 =?utf-8?B?Q2EyNFp2dmlhY0RmN2h3dW1yeUt0TFcvall2c0FQeFVqZEFSbDlLRzVnNHp2?=
 =?utf-8?B?YjlOME5GTFRuRC9aL0lrZEdKamlEK2RFM1BxdlBrS3pCVU1CRU1UeTZ5NVZm?=
 =?utf-8?Q?O4wM45/rwT/4dutzEG4MfWpYP?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4a4d8a-be5b-422a-16ab-08db8e7b799b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 08:28:37.9485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xtjO6sJSg8OcOBHaAvhGCkhTu7Bbvy91BKdqi1DL0LtqasCPRDy+aiOwkt/QEnR7RC5utW5YrsKPVFhYgV56g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7380
X-Proofpoint-GUID: iiNppWQc1DUm_JCqijYsoXRqGHyQSSTB
X-Proofpoint-ORIG-GUID: iiNppWQc1DUm_JCqijYsoXRqGHyQSSTB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 22/06/23 10:25 pm, Juan Quintela wrote:
> From: Tejus GK <tejus.gk@nutanix.com>
> 
> In the function qmp_migrate(), yank_unregister_instance() gets called
> twice which isn't required. Hence, refactoring it so that it gets called
> during the local_error cleanup.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
> Message-ID: <20230621130940.178659-3-tejus.gk@nutanix.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   migration/migration.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index e6bff2e848..7a4ba2e846 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1676,15 +1676,11 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>       } else if (strstart(uri, "fd:", &p)) {
>           fd_start_outgoing_migration(s, p, &local_err);
>       } else {
> -        if (!(has_resume && resume)) {
> -            yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> -        }
>           error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
>                      "a valid migration protocol");
>           migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>                             MIGRATION_STATUS_FAILED);
>           block_cleanup_parameters();
> -        return;
>       }
>   
>       if (local_err) {

Hi Juan,

I saw that this patch wasn't queued in yesterday's migration PULL, is 
there any reason why?. Without this refactor, it makes the error
description change (which got merged yesterday), in this function, quite
redundant.

Regards,
Tejus

