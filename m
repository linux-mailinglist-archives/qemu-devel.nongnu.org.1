Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A789B392A
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Oct 2024 19:29:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5UTR-0003Nv-RA; Mon, 28 Oct 2024 14:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1t5UTP-0003Ne-2O
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 14:28:15 -0400
Received: from mail-dm3nam02on20622.outbound.protection.outlook.com
 ([2a01:111:f403:2405::622]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1t5UTL-0004FZ-QI
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 14:28:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=id8GBJi51Uui3vESA5e+t91GZbJFBr8I35qgr4pRulEw4lhybn65Ofk6i3yYM1AzQRqIXgT1cSWPz8sf23/USCRgrq/B2qv0YIUH5JlQFBm6uKSTxGTrkxygC6fLNW3YPYNBb8vbqno7/kg6kvk0p4q2CeMWvnoKaaLJZ4PDpGV+1CHMO18lTkSNKieOqGkdUtNtHJXM6cKdA/W8TMl44Ago4nAYtEwnuyby/QHBfaCvj5vGwu98r/G1C39/n4pC2jEV4B/ldCNFdqnwIMGDslrQPU34QMp6Jl7F+Tvy2MAD/t4fePo5e0pl0y/EH1tVt/DRdLkJwIZbKhGMzOsrWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leKMKdEveFa6c0xuzQOYDw2QEgFWfNoqZC+k+GUhess=;
 b=BpETuHv/+P2/84LRiSwvpUJvsFOkdRen1kqeASp7NiZYrWhwx4RTiybAlsluEpUJ3pXlwtuJ7rczkbj/c83dHqift8QzXOSiUD5No42aZuPq+57Bk81AS6AXUL2l8ldQe2rxc8mO6sL5VtApgWM/z1eL9JP/ajOmiAGMdyhb5aWzkAX95ml44qnr+kyH0Bww8wAD5OS0Q5lDELNyvs4y+V6yxjjeUYNENyNBLzaRNoTwRO7yOPIlrgG7vnYo39fdYizHUSrguXFH62ufAiFtkK0OqpBGOykYxOnGguo2pBvISV1BKJo9zTzCOQpvV3tScf7B4W7+K/t5Kda30aAR6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leKMKdEveFa6c0xuzQOYDw2QEgFWfNoqZC+k+GUhess=;
 b=ivbSKfzj9z/QCMJbKjI4eg0FY1Uxix5cf9aUFAkrYCa4bbK9+rGa4X/uf5ijIeUIy+Uao3V64QyhFVidJBrXJijsX7UTFdeAQ2JtucoY2RFCiUSfIRI65udDQ5Tlg0sUzQorfFABNAVUhnOxr9VU4HzbI2w2cfvI6wQhduQB+ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 18:28:00 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8093.023; Mon, 28 Oct 2024
 18:27:59 +0000
Message-ID: <12139e09-f586-4101-92ad-0ed6ef02ec51@amd.com>
Date: Mon, 28 Oct 2024 13:27:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] target/i386: Add support for perfmon-v2, RAS bits
 and EPYC-Turin CPU model
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <cover.1729807947.git.babu.moger@amd.com>
 <b4b7abae-669a-4a86-81d3-d1f677a82929@redhat.com>
 <24ea79dc-1a15-4e54-a741-e88332476646@amd.com>
 <CABgObfZ6hCjs35Z8JDLonsRB=7RAdxhBK5a+pr0qja=6LpEdFg@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CABgObfZ6hCjs35Z8JDLonsRB=7RAdxhBK5a+pr0qja=6LpEdFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:806:20::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 197ca910-5c82-4fd0-6693-08dcf77e405a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MW1ZcDdpSks4R0FuWlV3dkRiV1l2ZWlGU1FLMkxXd1c3a1o0ZmdodTVnRWho?=
 =?utf-8?B?S0RWMjhwUDdzYU8zWTVxWFNTVDcrSUF6QzFXUGtTb05yRGY4cGhSTUhuMCtx?=
 =?utf-8?B?WDZzNUN1U05HTTZRRnQ4aGpMMDV2TmxrS0NCeWRLSzhoNmRMeWVUZnpEMHRF?=
 =?utf-8?B?M1dhM2R6SkNOUzVDT0JMSVRqOURpVnNxYXlPTWsvRHpZT09RMXk0ZWRma0Vv?=
 =?utf-8?B?UlZGZEdtcGkxbUJ1MGZKUHJ6eE5sbmptQjYxcE1mdnFUWUd3WVMvYmNValJZ?=
 =?utf-8?B?WldiRlFoRWEvdEdEck52OThYMGYzZHlXOXJsZm16VU8veFJFcmhkSjg3Tkda?=
 =?utf-8?B?TWgzb2gzVHdLRFpOQnpJTzljckp4MXdoZ2hYL3dzaElLQk9XVWZDWTdSYUI2?=
 =?utf-8?B?OFdiTkNBMmVub3RicXVBbEhnZmhjbVV1VWk4MFB4Uk81T3pqdkxHN04zTkp4?=
 =?utf-8?B?cThodExpc3F3TUtYVkFTT1YyZHdsZFZFT0JobVFHRkk5UGV1cnVhcHlJall6?=
 =?utf-8?B?bS9CMjkxdHVJSjlVbTJ6Z3Y2R1BXeWNGcDd0VXhIY1JmSHhsdmdZbGxhbnhz?=
 =?utf-8?B?NkNKTGllY0VFdnNKNmlYSjN1cjFNZlRFbUwyQkF6bzA5SnJub0lyY0NSU1gw?=
 =?utf-8?B?NjExSjJZL1d3WU9WdUdvVlZOaHQyQkhCNnhjbEVqN0pRNzhMQS9ybWNKRFBZ?=
 =?utf-8?B?TzRFTml3OGZwa3R1eHc2MFVqVzRVVzVPR1NZQUtXc2RBSTFxbHJESDVrOFdo?=
 =?utf-8?B?L1BFSzFscDlxUHBKeXNGaVBRZXpEWHFQeGkzdk9vYWZvNUw1WnFoOEd3aE45?=
 =?utf-8?B?ZzI3ZTBiUnFMVkNwYVhsbW5LWkkrRm1ZczBuSmI0ZXVYSmk3UkNtKzA1bXFm?=
 =?utf-8?B?MEh0OGM2S0thUVkrTy9ySmR1UnhHdlFEenBOQTNXSWhXaUdLZ2FTUXJVSEl5?=
 =?utf-8?B?RlJJNkRGTkJPemFiR2hoWUkzSXp3TG9wUHhuL2o1NlFpNnl5U2FOS2tnczZi?=
 =?utf-8?B?TmdvdHlieXN1aDU1NzRxV2ZFMGRMZnZ2bHJ5M0FpYzFndkRpbjZlQS9ET3BG?=
 =?utf-8?B?d1B3TEptVnloZjJRdmJyZ1RYOWU5bUwzQitRUUR3RGl4YUxrQU5YeDFCN3kv?=
 =?utf-8?B?TWJEbHRtdWRkL2x4WmFNVGZFMWJCOWlJWVZvcXI1RFEyK29aRlFFT1ZscW5x?=
 =?utf-8?B?ZkJneG96STBXbEV6R0lTZ1RYTm9zYjN5VXlLWHJGTk1CZmtVRm5tK2xQQlNG?=
 =?utf-8?B?M1dEdUtuYVNySmN4VEpFVUJ2SzEyd1cyVFU3bVlNTzNHUnJXMFJZNzhIZzll?=
 =?utf-8?B?Q3RqWFRtVkJiRlowaHpjN0h2YzdRKzVKcEwxNFFjc0FzN09BTXdKNlVNOWVp?=
 =?utf-8?B?Y3ZmcWJDRGJTeEpBdzlDOWxLbWZoVGtmaUpJK1Jhai9BSXo5bU1XOEJNcEVP?=
 =?utf-8?B?TitaZWRJcFZDeFYvMVdPV0dBWHRrWE5jRzcrY25GYkI2cnNQT2JFTkNTVTg5?=
 =?utf-8?B?NTMrdExLKzc3TVI5Znc2ZlcrL3ZicldPUmptMTlzUThESDRjalU5cUprbElw?=
 =?utf-8?B?WEh1UnVRTUw1ZVhxZnk4Q0N2YjZ0VWJyaWsxNHhUWFNSZ2xOY3ZIWk5veUl4?=
 =?utf-8?B?UjdWbXdldFp3Zm9YWXFmT3N1Uld6dmYrUkkzT2RxMGsreFZWcWs1MjREVDdo?=
 =?utf-8?B?QTlPb0FOTjFiT0JFUnN4MHB1ZXEralFQNlhtamVKbk44djNiSE9qajN4RW1q?=
 =?utf-8?Q?aLBJLWYtWaQSviTwE4kE5ZtXlfWwYKVL70aiG5a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L202bnVDL1ZzQmV0U2pmMWc0MjNoS1dnUjdNbVBFb0V2YkxwUEZ6REtGY3U4?=
 =?utf-8?B?VzNxYTNlNUVUUUZhRzhDV2dLcDdTQnRPQXFIMSs0U09tOXdkVUZRZy9jRlZi?=
 =?utf-8?B?VEFiblFnd0NqbHYwRU5HZW9ZcWdkc2tuMnFJcklMK2JRNkhHZmdnMkpnUkwv?=
 =?utf-8?B?UVJSbWNrZXhtK2lHcnV4WXNGcGxoc0I1SENsS052NUdQNWhCZ1dDN2ZDVkcz?=
 =?utf-8?B?QUxoWTM5dnQvb3F0ZG84emRtcTBvblBqbDdpL0Z5SXdyclVKdzRhOW94bG1M?=
 =?utf-8?B?V3dvZFFWL09NU2tJMmNQeW9DbElOL3dadEl0bkdYMGpFVkNFeUUzTlROU09z?=
 =?utf-8?B?ZCtpWWIrMmdMalIvTkpuV0pHSlFKNGRxbGFaSHhpeVlUQzU1WDJvVUluOFZJ?=
 =?utf-8?B?d3E0UXZEYlNodTNkeitucXZUeXlxWTZzT0pwL0RjK2R1RWdlQjBxY3hWb2xy?=
 =?utf-8?B?WkJ2QXk4d3ozOU42MFJmTU5VV0kzMG5hVFpvSnFCT1FMRGxId3ZHdDlTUlFr?=
 =?utf-8?B?aEIvM0FrSm5SeTNjbWtobmFNakNQMUtwUGY2bS9EMUx0L08xNWEwQW5QSWtW?=
 =?utf-8?B?V3VpS20xWm1meVFrNERJYXZHOUF1MkVBb3BlL3NXbndxdnZYeXJ0QzlNZEhS?=
 =?utf-8?B?cVI0RUV3WkxVZGg2UnhwWVhjVVRPVVBMWEVici9ENXAwQTBPUUwyRXRwWnhk?=
 =?utf-8?B?THVKYzVJdlE4N2ZDaVZOODhaYjcrdTdWOVhtRjZMK3lZazE2eFNHeFN0NURa?=
 =?utf-8?B?U2YybEVRZmI4ZXd0VThIQWh4ckJGWjVJY1RCcnh1S2RJY0NwWmNremFScVlw?=
 =?utf-8?B?TjNJKzFWS1prN1BpQkw4eVFsbERKVVdVcUM2czFRWnBZV1BWWkoyZ0JDeStZ?=
 =?utf-8?B?RUp2dW1xcEp6ak0ydmxMMkdyem51L2tWTkRBcG9UU1RrVlVqMmxDTld6RjBr?=
 =?utf-8?B?SW9DLzkzRnZaMThKelBzNzBXU1NmTW5MZXNlcWFmMWhzeGFIeW42N0k2WGRs?=
 =?utf-8?B?enhTak05Ym5pcEdhNWVTWjNXVEEvSktSYmNoK2FuZGtCK0NDemJNUzdaL0Y4?=
 =?utf-8?B?d2FTcUNiemI5QlBWUUVRdXppTjUvSWU4eXJxZGIzNVJMVWdMZ1o0TjJBaDZu?=
 =?utf-8?B?T2dEWmplYXNodGJpL09sZTcyQTdid0VVMThka0N2QStjZDhQSmVLYzRxV0tP?=
 =?utf-8?B?MjEzYnhPWkZFSG9VNUNCaW4vWlU4RExwTFhyV1l2OTlMTERDL3JJSlhRUDBD?=
 =?utf-8?B?akZwSnVLUjd0Q0JoM2liQkcwbHg3OVBoeFZBTnNnNXd6QVp5cTl1R3dWM2t6?=
 =?utf-8?B?ejZrUkU3Y01ZWnZNQmpkY3FBZnFZMkVMU3hNdWxqeEs3ZTBMZGhWeXJnSUpI?=
 =?utf-8?B?NHpuN2VjcEw3TG5QRjhjVVVRNWJPbmNWUDFPMTlHS3J0eU1wcXg2MC8zMnBr?=
 =?utf-8?B?bzRjVXBHTXBubGNNZmtVdHIxaWFER3pLK0FTVE1SZEh3OTlBaHA0WUpEY0xV?=
 =?utf-8?B?eWVoS3dpMkVRZCtzeldLa3NOb1FJUkhoUDFFU2cwcUM2UHI4RXZZNjYxZTdB?=
 =?utf-8?B?YlYxbWFxN2RjSWRaQnBja1BOU0xEZ1VuUUFIY0hyYmJxZmsyK01STVZzNmN1?=
 =?utf-8?B?N1hmOGFyVHhkZktmcVFkeWpCMU1DWTh6SU1UaEtTcW1yUHMrV0NYN0ZhanFz?=
 =?utf-8?B?K2VzVExYOEtvMlllVjl3RThPSEFlZFBXNkt3Sjg2RjZpc2duWXJNS08rY0lP?=
 =?utf-8?B?dURjaTZUdUg4bEJVV1dRTG0wTEh1NU9Ybkd2bS9NTUpOc2dTMkZlakhxdENh?=
 =?utf-8?B?UGtzeXR3UXJ2UjdCb29KcHdPaE83bmQ5VkJ4RGNLUXVQWUxnUEVYczRJbFBG?=
 =?utf-8?B?amlRS2piU0lKeVErN2ltSE9iUm0rQno2eHJKRU1KTDdqZFpNeWhDVFlRUWRa?=
 =?utf-8?B?MmlyWDVtdTVJa3V3VWVEZ3MxVHhYaHQ3eGlzeVdZUlAra1BNMGFLOG42bXkz?=
 =?utf-8?B?d0xSNW9zSDBDL2tYUmpNdjVMR1c1MnAyWGhqUzEyT2kxcWgxT05TQVJ0R2VD?=
 =?utf-8?B?OVZVVzZQV0gyL0YxODVjdVFxdFFhTjhnMWQ0alY3dWtnR040b1RMeUhVdzdD?=
 =?utf-8?Q?fBKQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197ca910-5c82-4fd0-6693-08dcf77e405a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 18:27:59.9329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qU+wdOKhG88zpXm9DSweim6G1anoSNZ5dECesaLDduivy48ToU1kf6AX+N+7zvg1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
Received-SPF: permerror client-ip=2a01:111:f403:2405::622;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 10/28/24 09:25, Paolo Bonzini wrote:
> On Mon, Oct 28, 2024 at 3:23 PM Moger, Babu <babu.moger@amd.com> wrote:
>>
>> Hi Paolo,
>>
>> On 10/28/24 03:37, Paolo Bonzini wrote:
>>> On 10/25/24 00:18, Babu Moger wrote:
>>>>
>>>> This series adds the support for following features in qemu.
>>>> 1. RAS feature bits (SUCCOR, McaOverflowRecov)
>>>> 2. perfmon-v2
>>>> 3. Update EPYC-Genoa to support perfmon-v2 and RAS bits
>>>> 4. Support for bits related to SRSO (sbpb, ibpb-brtype,
>>>> srso-user-kernel-no)
>>>> 5. Added support for feature bits CPUID_Fn80000021_EAX/CPUID_Fn80000021_EBX
>>>>     to address CPUID enforcement requirement in Turin platforms.
>>>> 6. Add support for EPYC-Turin.
>>>
>>> Queued, thanks.  I looked at
>>
>> Thanks.
>>
>>> https://gitlab.com/qemu-project/qemu/-/issues/2571 and I think it's caused
>>> by the ignore_msrs=1 parameter on the KVM kernel module.
>>
>> Thanks again.
>>
>>>
>>> However, can you look into adding new CPUID_SVM_* bits?
>>
>> I normally pickup bits when it is added in kernel/kvm. Are you thinking of
>> any specific bits here?
> 
> Yes, KVM already supports vGIF, virtual VMLOAD/VMSAVE, virtual TSC
> rate MSR, vNMI, virtual LBR, virtual pause filter and virtual pause
> filter threshold.

Oh ok. Sure. I will look into this.
-- 
Thanks
Babu Moger

