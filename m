Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EF5A3E951
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Feb 2025 01:47:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlHC0-0003Iu-Uk; Thu, 20 Feb 2025 19:47:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1tlHBy-0003FU-30
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 19:46:58 -0500
Received: from mail-mw2nam12on2077.outbound.protection.outlook.com
 ([40.107.244.77] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1tlHBw-0004yh-6Z
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 19:46:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQxnXniyMwenl9i1LhyVMjD4l8hd8YWZWLXoXFt3JUqRrep+kRtKMWV4T5hoUnDGzm2BUNx3eOSyuEWuwF/N6e7xKNn9/I6KSFmHd7JZY6woS3U1AH3Mv1qT1jrLSAqFjFW4LEbpiq61V17aL1V4LH3PjonXMLY5uxQSi+C5zYzM2brN7sGOmyOeWka7uqhMj7SswYXzSGjx9LD+oVJ59+ToitFbd9UZEcwkdxqwsYl8j2HyaI2pp6oh4L52B3fxlIIMeb4SBwondFGZgABqC+NJUXuA1x48AgH+GGg2Ykfn7J9jyHWdkJSvgkVHet3kdkrOSNTzy1LNdsbDNF1AZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5uNbvtmaC0ziHws7fp3f9VYVBqHRBgNhy5PDGXuj8g=;
 b=LlpKVLq9aSAcYcApuqoHLnUpsHt/Tp9yOjqNtgiwLf2cPu3ljV8tCQzcZRtS3q4jbUwj/66E0rFsysM90T3sz9vKWi6sPPJRCySYOMnwQScg57vp1HlVpLbku1J2S38hQvMfPY1yawBLYXelQ5vHDSR/ODiHmHZVySa0jXSsAdSQuegnHwJ2N3TjbzAVEbNcVdBNGB5NSJY7asCHumW8Ftz56OBEJOWzkxNrNIjSioiLcZF/QQ7o5WBMHQt3cR5I8T/Kc7VVjKcAri48nKuy665yMj2LyIDNqbo6LSg8ShwX09tQNlLMSrefc43xH73nmzcU/U+rUpv80NsX2gV6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5uNbvtmaC0ziHws7fp3f9VYVBqHRBgNhy5PDGXuj8g=;
 b=VjDwHUW0ZvgflfTJN+miw8eLbD7qsSSEnkdoe6LgcRLC5sXBi7RxQwy29DiL43+nhgysPdqGTTK/b9PWsDzL/tjnUZTayiON0vpKPc9gUZThphzJVi3y8hfzOBeapxY11muhw9tAsG7JSPrHxQPgpXAh1MKxjogHNvtoisYLKg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 21 Feb
 2025 00:41:49 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 00:41:49 +0000
Message-ID: <7c7c27d5-679f-4f5c-9919-f8172d50ec3a@amd.com>
Date: Thu, 20 Feb 2025 18:41:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] target/i386: Update EPYC-Rome CPU model for Cache
 property, RAS, SVM feature bits
To: Zhao Liu <zhao1.liu@intel.com>, Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 davydov-max@yandex-team.ru
References: <cover.1738869208.git.babu.moger@amd.com>
 <8e40e18b433d2d152433724a15bddcacdecbf154.1738869208.git.babu.moger@amd.com>
 <Z7cPeyLAuNDL0Oc4@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <Z7cPeyLAuNDL0Oc4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:806:121::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 54713038-9576-4d58-fc83-08dd521086bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THFGN3VHUHoybHJnWTNUbk01S3NGaFFobndCaUcwS3MvakFFenRldzJNTmZS?=
 =?utf-8?B?bDNORUJPempjUFcwTUdSL04wOXhyOExPb04xYW14OThodlMvQkVNeFhNV2c3?=
 =?utf-8?B?NTlLSlNWakZzUE9jUUY0bysxdjBQQ2IycjRlbXZhTTc5WFFrR0lvc1pQc2xy?=
 =?utf-8?B?YWtqUy9tcnU2ekl6TW41bU5tNHJSdnM5YU1oeWJmbjVtdmhUMG9Lb3Q1a3NO?=
 =?utf-8?B?dGJtcFg4dzEzVGdXeTEzUEZwc090ZzFVUnBFVW9zaFhoZlM1NkJTMHlkUFhE?=
 =?utf-8?B?REgwdkNQM1VGbEdlVHVaNkI1M3pYd1p4UlUxMnREZ2Fta3h4ZDZwakFwcG10?=
 =?utf-8?B?eG5Oa2o4aHprSTE5U1J6K3RSMXFjYmdYZFBoc09XREs5RjVIV3NjblJoUkE5?=
 =?utf-8?B?QlNqd2Mwc053Q1VFdEhjZTNoMkZjR1dWR05HNFlwbVJteHJCeXJlRlI1VTJZ?=
 =?utf-8?B?V2FJM0U1dXRQaVJzOGt1WWJWSjFwVjl6ZVAyS05MalpGT0xmNDNMRDZvSER5?=
 =?utf-8?B?Wkg5aE9ZYTZxVDVMWEVEcW9zWXc2UEl0SnN1SjFucEplZm0rU2pSVEdXbHpj?=
 =?utf-8?B?OVEwVGpBVVhhczEwZ0JHSEtjSWdKdEpUTDVIamgzYlVocE5YbmtWSFk5cS9K?=
 =?utf-8?B?NE1rNGNSaUtKeS82amZPZTlmT0Z2aVc5dER0ZjhUakJydnl5MkYrZGJCRGk4?=
 =?utf-8?B?U0UxS1JldEpqSVpFbncyTHBLMkYzU3YxdlZKT3pmanVCMVd0emI1Y1FjMG9l?=
 =?utf-8?B?S1F2Rkc5N0ovVks4d2VjbHU2dGtMTDZibms3Y3NpcGd5YS9kRVJIbW5zN1FD?=
 =?utf-8?B?K2c4U3ZUVEVETVZaM0twR2tZVUY4WjBPMm9DVXRjbmpVQmhWUlU4OFFSRUNt?=
 =?utf-8?B?SURmOG5mYjd5RU1jbFJaMURBK2VjcWVxV1kzSW9XdG9kRFdMMUtmaHNGWnE4?=
 =?utf-8?B?ZElRTXhPZWp4ZngwV1pBbDNJeWU5bXVqaGMrUk0zc2lhRDAxcm4zdEc0bFBW?=
 =?utf-8?B?SmVOL29hS2wyN0UyZ3hDWUhHMm55NFJzYzNaZGRRN1RiWGFubGNUQ1Nnd3lq?=
 =?utf-8?B?V2pxRGxJSW9qV0E1QUpsL2RYL2xGTmNHKzhrRVRqWVhESG52NU1FRnJmdjhq?=
 =?utf-8?B?SHBnbHQ1RTBHSlVKY1hpM2dLSXJYeTcrenlBYkIwSXl5ZkxWZTdkazJLMFdk?=
 =?utf-8?B?UkxhQ01UMUYwSXRhV2hzdkdGbmtJYXpOeHdFRVFnQTNBb3c5cHlidURMRG1i?=
 =?utf-8?B?ZDI5QkJGa1Q4d0ljbWs2VVlaYjB1cnZHS1VqOHBBV0VBUmI4MmFkckxHMkJQ?=
 =?utf-8?B?RWxCSjNUR0gwMk5zOEI0MjhHWEVidS9IalNINnU0RWp5TDVIS1JBcThKbWJy?=
 =?utf-8?B?ZW0va0JPaXgxRlZGaklDYTJUcjlPcEQwQXFwS1VncWlwa3Nld3B6SGJUOFQ3?=
 =?utf-8?B?ZUlSTUg5czN5eHNHYXRyM0VBNHc2L3NlWjlvRncxYUQwSDBMd0tEOVR5d1Ar?=
 =?utf-8?B?ZTM5S2hlbmFlbXFDeElwOWJOa1hlanl4cWpnQUVzUGlRaUVNay9xVW1kVnRn?=
 =?utf-8?B?ZzRLZEFFRHlZSUlGenNKUlkwZVRXcXZoNXRTamIrdEVydGNBOW9RS1VHbWFQ?=
 =?utf-8?B?cVVqZEw5eE1INTMvMlh3SitVWnBEZFlQcGpkWGRsQ1dsQVhUZEtRRHVMTThv?=
 =?utf-8?B?eWhtZlRpa09sdjRJejRZS3pHQkQ2dzZLOHlXRXNSZzFUTC9VenJQL2JneHZG?=
 =?utf-8?B?aDdYZ0xlOEhLM0NSTm9sR0RyQzRpUWJxNDZQajUvQXBQQURreDNrVjBlcHZP?=
 =?utf-8?B?SUtWSnBKcDQ3ZkxrMGZDdDcrMmRXbTluL3I0dmJFUFRodE1Ka0FOYWk1ZzF5?=
 =?utf-8?Q?F9BoaY3Ovhzq9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUxkNGlFOHE3TE9yQmtQYW91MGc4R2xxYkRwQzVCdDNSblMvZlVWb01SOTRG?=
 =?utf-8?B?N1NUWTZyMWU0UlNreWFlTm9WZTNtZ1lOa0pyaDJzL3pPb2hoZ2RNdWpjbm5J?=
 =?utf-8?B?aGpkUFh4Y2JVcDZIajcxcjZGRkZ5QmQrcEhTWXdVYnp1NTlxb3lCUlhGcUtM?=
 =?utf-8?B?UTI0V0tvaGkrSGd1SHZ5cER1amQxUkxGTmcrZDNjRVBuMHkzdVFzbUN1dTZk?=
 =?utf-8?B?OVlWMmJnK0hodEZoeE9yc3F4WlNxcG1DcjBhaXpEOHNBNmhiQ3VWUzhudVky?=
 =?utf-8?B?VzQ4RVZLY2JlRGQ2by84SFlHTS9FYkRuK0dtTmYxOWVZajZpOVQvd00vNksr?=
 =?utf-8?B?a21wVjZGeE9rQnVyNWJvK0pnYkZKdGNOZzQrTUh3Sk4vaFBGWUEwMGpvdjkw?=
 =?utf-8?B?TWExYlB5M1M1K3BvVURrZllOSURNYmhnSnlMSWRMSUh4TWdzRzgvRm02eU5L?=
 =?utf-8?B?RnZBdkQ5bnhEcjJjNGJTQjZWMkQ5bzd5MXFvZTBONlo1eEt1WEFwZkVxNXgx?=
 =?utf-8?B?bmVvcms2cHcycHU0UHMxSk5YRW9kQU56TlU3eXpMaDdpRFQvakozMGdBSXp2?=
 =?utf-8?B?S21WRjdGS2xPd1Z2YUdYV2lNYWgrRVNIc282VkZEaFJqK3kyd1JNRWIwTGZw?=
 =?utf-8?B?eHcrQlZLRmdRMC80ZXRqUmwzNGF3c0dCaFBlc2w0WEwrRVJGMjVNK3ptRit4?=
 =?utf-8?B?MmFESzMvT1NFNHgwY2FwQXhqdXd3NVljckxENktWd1didURob3FlUHJVQ1Vs?=
 =?utf-8?B?VTlYQjNoT3pNN1dHcmRWYUNBQ2YyS2duR0FKV1RvbDEvdFA1ejdlNU5jbUcz?=
 =?utf-8?B?UTNQOWlURTlxZzZxQ3VLc0IraEVtRjRkWXlxTWZIODExdzlGSVBIUTJ1eHpj?=
 =?utf-8?B?UndvWmkvdHM4RHFuOVB2d0FyR3Z1d05HVlh2Z3E0Z3pCekhyS1A1QUdSVGV2?=
 =?utf-8?B?K1dSY1ZRTXU1Tkwxem01bTZLbkhKOWpmUGkwWi93eGMrdkhRRzBqaFlHK1hp?=
 =?utf-8?B?c2lqMm9saEh2RjB0aUNvTjhLYUVPbWFWcVhWOTcwN0ZQOFZtSmF5WkIvb1Ro?=
 =?utf-8?B?TW1yaFFUV09MYXNJbVFPbHp3SmpMdk9rbzU0VkxVejVyZFRkb1poL25neGxJ?=
 =?utf-8?B?VlNCSjdrSytncUNvckh5UTZOUnVzT2NGM2MyQnZMYVRMZTgwZW5wVVd3NWpH?=
 =?utf-8?B?bFpPbGoyb1Z6ZE1pb3piY2RNNC91eGhITDBhcDlVemVpZ3RUenhUcE9HOUc5?=
 =?utf-8?B?YUR0V2czWnppalcvbGxKb3hnRFcwSHdTR2diNm8xYlpmMTdwL3FEblZLMnJz?=
 =?utf-8?B?b3NtbytRVWk0RDhySFQ0Vm1KdmZQdmc1VzU3MXl3TmxKajl2ZEZBVDI0WTBa?=
 =?utf-8?B?SlVoU216TnY0REFUZ3pOMkxIV0I1bjk4Y2FQKzI0eGtlV0lubzdzbnU0Tytw?=
 =?utf-8?B?ZHRLREJ3WnJqTTNadElHZWFYbFpXM1Z3cnd3aS9TSHN0Ym92OC85cDRXa1lv?=
 =?utf-8?B?bktrZjZwOWpoMGFHTVBJY2pMY0JxOE9sNFh2clo2NWhPc1lRbUlUdXgyOVpo?=
 =?utf-8?B?Nlc2WkdlaDZFUU1CeGFWZWF3ZFp2R1lXajl0Unh2ZHZQQmRsOTNHMy81Kys1?=
 =?utf-8?B?dXlaQXJTdUJLZ05JOHVmd0xWZ0VFU0JsR3M2NlNOakhneUFqQkRyR29yYWFQ?=
 =?utf-8?B?OWJxQk11MHBONFBNK3dUUThzZFl3UnhxNzhITWxFdWU5QWNhTkVFeERqd0N5?=
 =?utf-8?B?L1lSajRqSmh2SStqVnBGQ3hoSDcwLzVucUJVY3VCS3I2VTZ2S0ozV1JPY2tN?=
 =?utf-8?B?UzdiRnBRL0ZMdkZ4dE5VRC85WjdXYVBSYXdjL2tUekRXQ0Urb3BxQm52R3Ar?=
 =?utf-8?B?RmhxTEFPdXJmNU02VzY1ZEN0d2FzSU9RS1hsM1VjRk9DcjE1QS92R3J2V1Bk?=
 =?utf-8?B?OHAwNnhxeVRramR0amp5S2ZuQVZBZFV0cFU5S0YrdUxnc0lZMnZUN1RMVEky?=
 =?utf-8?B?UWJvdEttVWdpUXp3WFF2VmpJNzg3TzNsMC92blBLUkNuK3NrbUJkWmVDTjJO?=
 =?utf-8?B?RG42U0dFRllCOUFRZzFrTkRUMG85WTkxcXBvUmppaGFLQlQwcWpXdTJXV0RV?=
 =?utf-8?Q?LPGg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54713038-9576-4d58-fc83-08dd521086bd
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 00:41:49.2026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIJ8K6xD0SLrBANRpB8KXVs+s1RvrW1dm7zMgmpEvkalpbBDqUg5qaFasjGtpy8W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
Received-SPF: permerror client-ip=40.107.244.77;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Zhao,

On 2/20/2025 5:18 AM, Zhao Liu wrote:
> On Thu, Feb 06, 2025 at 01:28:35PM -0600, Babu Moger wrote:
>> Date: Thu, 6 Feb 2025 13:28:35 -0600
>> From: Babu Moger <babu.moger@amd.com>
>> Subject: [PATCH v5 2/6] target/i386: Update EPYC-Rome CPU model for Cache
>>   property, RAS, SVM feature bits
>> X-Mailer: git-send-email 2.34.1
>>
>> Found that some of the cache properties are not set correctly for EPYC models.
>>
>> l1d_cache.no_invd_sharing should not be true.
>> l1i_cache.no_invd_sharing should not be true.
>>
>> L2.self_init should be true.
>> L2.inclusive should be true.
>>
>> L3.inclusive should not be true.
>> L3.no_invd_sharing should be true.
>>
>> Fix these cache properties.
>>
>> Also add the missing RAS and SVM features bits on AMD EPYC-Rome. The SVM
>> feature bits are used in nested guests.
>>
>> succor		: Software uncorrectable error containment and recovery capability.
>> overflow-recov	: MCA overflow recovery support.
>> lbrv		: LBR virtualization
>> tsc-scale	: MSR based TSC rate control
>> vmcb-clean	: VMCB clean bits
>> flushbyasid	: Flush by ASID
>> pause-filter	: Pause intercept filter
>> pfthreshold	: PAUSE filter threshold
>> v-vmsave-vmload	: Virtualized VMLOAD and VMSAVE
>> vgif		: Virtualized GIF
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
>> ---
>>   target/i386/cpu.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 94292bfaa2..e2c3c797ed 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -2342,6 +2342,60 @@ static const CPUCaches epyc_rome_v3_cache_info = {
>>       },
>>   };
>>   
>> +static const CPUCaches epyc_rome_v5_cache_info = {
>> +    .l1d_cache = &(CPUCacheInfo) {
>> +        .type = DATA_CACHE,
>> +        .level = 1,
>> +        .size = 32 * KiB,
>> +        .line_size = 64,
>> +        .associativity = 8,
>> +        .partitions = 1,
>> +        .sets = 64,
>> +        .lines_per_tag = 1,
>> +        .self_init = 1,
> 
> This field could be true,

Sure.

> 
>> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
>> +    },
>> +    .l1i_cache = &(CPUCacheInfo) {
>> +        .type = INSTRUCTION_CACHE,
>> +        .level = 1,
>> +        .size = 32 * KiB,
>> +        .line_size = 64,
>> +        .associativity = 8,
>> +        .partitions = 1,
>> +        .sets = 64,
>> +        .lines_per_tag = 1,
>> +        .self_init = 1,
> 
> ditto,

Sure.

> 
> Compared to the previous cache model version, the differences can be
> checked. I feel that in the future, when we introduce a new cache model,
> it's better to avoid omitting items that default to false. This way, the
> cache model can correspond to the output of the cpuid tool, making it
> easier to compare and check.

Sounds good.

> 
> Overall, LGTM,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> 
Thanks
Babu


