Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A594763F3E
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 21:09:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOhzK-00073q-GO; Wed, 26 Jul 2023 13:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOhz8-00073Z-7N
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:07:38 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOhz6-0000pR-1Y
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:07:38 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36QDBNaD028592; Wed, 26 Jul 2023 10:07:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=jfkbcfyH6mfoGLUeksPudWUYARPB4GBZN45Cy5Ps/
 CE=; b=phmaq02pXAkY+L60MB/b/v8rSo+73RgOhpKRHARLZTcdv1tWiMjSmFlki
 +5EHvgDaPtXXhl8sdoKIunNAUho/VlRAd1hkcrLLt1YRZx4APn2MIj93yFEm2nzK
 dzH8qseQHPycPAs9XIxdtxIWAF16kJK1GUTN1Ai5lp0pUCGzRCC1Zs0soa4Xmo6d
 r8clU1eDTzYTztL9rY9qzoNk/C7NCqyT/YiThKcLTbux83l6C+JipWsFCFGaSy7W
 wS0psZEyaUwIO2wHw32eAC7msSQfGvQ6bBvFmm9GldDCCCG5d9nrZmsKWOrn2Gp9
 yAG+VIslhanmS0bLOcIcPlttjjulw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0envgamb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 10:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpg6D99zZOhmvRNVS8SV00K3qyyiILK5tUlFDdjMg5B/G2e/zIBUZAeQsJvM249W/HrJAUlA/9qi5lfixY76FuM1xNeCtvtIzyXVRahYX+5aW1w2qj4m8W3k58RomcUggH7ACTVGFXEsdN29kTlIJaqHhZ9IzpQbOQNJqqIij49QRoTajq12rt4X/OgSOur122iRXxaaK2dXUM87taeLA81NDIJAJWjHevf1fy+9XrkwSlsQVUiWvVeCbsB8twqZEdXNwtABqqjxHZJOapAvu0YpqGmPnm5zeUJr8nKrYY358VTETWYJlQnqFKBxcw/x2T1rfbFlbS5d4fNcIRfARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfkbcfyH6mfoGLUeksPudWUYARPB4GBZN45Cy5Ps/CE=;
 b=h7WquZ9vleeWumbO9/mCugu3RF3xTmbwpuujZ1E2fU4uG9A3rk76KccDJoXPrTCoj7UD5gelTcvlHdYj49Qk9tWb5Tb8GEBfYzD4CbUZnj6jW+S5AmVUFtRYn3y2ZWR8NVCISQPOMFHBet43V2wnsPivtfEEsljUyVfMn42UACTmllhlPCdAIL1iwhxdLBRLvkhAvm68sI87f7NXHIjBmSPgaAk3A/08lKIbeiTQ6LciPwVjf027BjOn6CFfVpISDn9pTSXLrQ6/96f+hiS2x7IOXOlSw8naikn9562C/+GdCTaUNRLtvpTjPMXEYRs7FJmTvhnjSy6gW9Cf/2FT0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfkbcfyH6mfoGLUeksPudWUYARPB4GBZN45Cy5Ps/CE=;
 b=y3uDivl9aDlemxAV/89wmLhhO+XFa032dt1uykTebHO+ORL9qFLqxqj/6jcjJqlaRuZbNQOhRkEmNEXgV+lGX/RHHfHpRBHSoxkmEBPjyzKgSRDY1YxfWR1Chzb7UKPtHUnPpxv3QcPcCCgNNXp2OAUi1NTExUG+46usmmF3kLjbSGRihLoNV3sTWAk2nhBKd8YPtAhitqfgV17LHK+v5LfJFQCcdoSZFH5CxhDGyR+vNfx0WipDzCBW39yawHiuL355L2yo9Yxof6LPhW787a7TMgzPLs5uo64zPUX/OGGg8Q6U0E0pu9gNws387jryuQdkOe0qOa2DvtAnj7urKA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by IA1PR02MB9206.namprd02.prod.outlook.com (2603:10b6:208:426::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 17:07:30 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 17:07:29 +0000
Message-ID: <a03da9a6-9f72-8714-e6d0-3ab9cc6c40d4@nutanix.com>
Date: Wed, 26 Jul 2023 22:37:17 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v10 09/10] migration: Implement MigrateChannelList to hmp
 migration flow.
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230726141833.50252-1-het.gala@nutanix.com>
 <20230726141833.50252-10-het.gala@nutanix.com> <ZMEz1SRK3QhJZG4X@redhat.com>
 <94950119-ea11-4c9b-e50f-09741f100040@nutanix.com>
 <ZMFMqRC8WlB3mXD0@redhat.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZMFMqRC8WlB3mXD0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::20) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|IA1PR02MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: 667b728d-e303-4763-0814-08db8dfacb28
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAWyGDtnrpdVmxNqI/wgJugBmWF64vdT+UR+r2QKK6l9b53guBKonXJBdGHZJ+VZqx2L8Q/1EIgLf3w0/Ap5PL03dP3tfcoLOw36GfOTjtPx4wZsR+rgEj9PNhLmRQlkBKEYZsjq3ZkoycHPNoQLoEd9QFZ4615fnDpDkDXrp44mzvF9LLaWberA4HAjUCd/bI6whJySJLoxL3hHxNL+TxX7RlmJtV6Ml60oFBmwFGkuZhoDum8kg5OIdsdKvSSDyNyJ1qK1EWlBaOYDxyixpcmBsqzJD98A5xxsLwX8chZVNK1NftYTnSlz+ddTDn7ywXeJ8JchKsPq5r8oob9BNkiBGvxlJSJ1uiZWmUBasR1Jwq5OVwWJlr8RDm+Y4rZb1kX2CcavJewh41Gj/2r7qSdHieA+RaJaCozbaPZFgacalC6n37QL8+gs6zx+9A61swOA/6hPm0YRQ2+zOxNhQUBWIsr8YA6XrIhuKl0GV3ddzgrd0y2zT2V3q9G6STkArdcq6ZNBtZi0KCIhIc7YddSU9kkQGf1zSJ/fPev5mm50GYMewM7LAMdKhykdMLgySK4HWuMSOCQDKlinn41DyhhReJ3OtaNt64GmrzY37Kx1TPATr7inDDAmArWHj3PXWEoAiS6tRgAvrbPOXEm4Hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(83380400001)(2906002)(2616005)(478600001)(36756003)(107886003)(31686004)(8676002)(8936002)(6486002)(6666004)(31696002)(316002)(86362001)(6916009)(26005)(66476007)(6512007)(44832011)(186003)(66946007)(38100700002)(66556008)(6506007)(41300700001)(4326008)(53546011)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3dZK09lOGlwL1RRTXc5dW9nYjJackR3QWxjcDJPSUdURW1SUTRzaGtzVnpl?=
 =?utf-8?B?QzZna0hRQ2h2MHRLU3NpUEdzQi85dncwRTZJY2hmNVIyeEdCYUlNYXdOMlEz?=
 =?utf-8?B?OXhLbDJRVURwRURTOXBlUGd1ZzV6Y3JReml3Wm1abkZ6NzltdG1waXlPVXMw?=
 =?utf-8?B?ZW5WMUdiRTlKZndHaFo3ME1RQjlZOFBtZVJCRmNvSHJyU0xJQUdaMktSTlBH?=
 =?utf-8?B?cTk2Qm9jN1hQTzRCUTdESmNaUVdlUERJK210cWRNTjFkVm5HcW9PeEQ4WXFT?=
 =?utf-8?B?TUNvQzJRbitsUWVXcnBDMU0wb1YxRGJpUUhhUnpHTW96OGxiTHN3S2pjWHBK?=
 =?utf-8?B?cnhObVlnMHlyd1BoVUhIcnlXcVorNUV0NCtvb1ptS0JGSk01T3ZDZmZBenY4?=
 =?utf-8?B?YS94bjJoVkhYRHBxd05XVWtod25lOVFzSml3R3l5NWJkYUlSVnpvZ0FQc1JD?=
 =?utf-8?B?NnNUZUk0ckY4YjBWbm1UV2RPTXN5a0c4R1pCRnNZN2xwdXVnYW1wRGh5N25F?=
 =?utf-8?B?TFVwRk9yYkJRZmtXdWVXallXeENxd3hqU0orNnh3dHQwbm9yaTBNOVVJZjEy?=
 =?utf-8?B?OTA0K2NYR3NKeHU3d05XM3JTSkpsYUJ5N0dlQUdrSFovRUpXRTVYZGdhQnI5?=
 =?utf-8?B?cHlmOVlGK3UvbTdtS3JVU2dqZVpwWlVJZXE0L1BIV2lSTHBPN09ORzBoWC81?=
 =?utf-8?B?RFd4QkQ1dHRjdE5jVUVFczRKWkhuOTRsZ1dkTEw5b3dBTm1jUmFqY0dLWDJL?=
 =?utf-8?B?QTMranlwclVFY0hhUmtSOUVNVjkvUjFPK2VUMmE1dEx1dFdoZyt4aW1MbWlu?=
 =?utf-8?B?ekVteW43dkNoNlJpL3ExSDFPZmczb1U3enloWStRR2xhb0F2MEpCUmZObFEv?=
 =?utf-8?B?dGpUVldLM2VGS0tST3hjQnNJRFQrVzZRaUJySDlFdXZqVE5IOWowbllJczJN?=
 =?utf-8?B?MUJNWW9JbjY4SDZxWFV0aWdNSFVNR1BhVGNlZzZzKzU5VjFZdWN3UnVTZVM2?=
 =?utf-8?B?RHFYTFB4ZGxWYWlFbm1kWEhvRGRIa2pIZFNXWXN0ejVCYitvcWZPZjBsYUZa?=
 =?utf-8?B?dHNsNnQ1ZlgxL1ZINWY4azlmWGU4aThuOXFsR2VrdDl0MXp6ck1sL0kyeEdD?=
 =?utf-8?B?QlBmL1l6V250cVZsSzltbmRPRG9QY1B0L1liUmFUR21PcVJOdUxaNzVLT1dr?=
 =?utf-8?B?ZjFWQnZEUFh2MzhzUjhOQ2NReUhoNUtDeDR0L3E4YklhcWtleVlGRmVkcGpk?=
 =?utf-8?B?eEY2T0tySFM2ODZWVjRpeWtRQkdveE9BMzlvbTNZOHRSdUc1NE14eTE1VHZC?=
 =?utf-8?B?ZlJ4WUZ4c2o5NkZrY1htVmxDMTBTL3hza2pXUEp1aG5jSTAzamFpelhUL2oy?=
 =?utf-8?B?K0RMMHRHRVlTY3hyZ0ZQQk0vWm96aExCckFNVHNmQzhHbC9DZUNKMnpsN1ll?=
 =?utf-8?B?ZmlWZWJxMWowUVEwTDFwYTRlT20yc2tRQTZFaEFudmdlMjJyRHhFY210RlU5?=
 =?utf-8?B?VnRUeUxESjAwRythNmhIZXh2dkZPZ1RxdzA4T2pHN25jcHd5dVhXYUM4ZnNE?=
 =?utf-8?B?YjFVTDRhM3RLTitTY1ZtcHk0QXoxbndlOE5xQ00zQWxONnI0aS9PT0N4bjZy?=
 =?utf-8?B?bHppVnF0RnhtaGF6Q2g2MzNvWUNhVUtxR3dVTHBkNHM1Q09qRjF4bnBkSWRk?=
 =?utf-8?B?SDNMWGhVMU1UZWZWVUNUVWxaQWtNRFA0YThJM3V3cVNYZUphdVI1RU5sNDlN?=
 =?utf-8?B?Rmo4YWNhZW5Td0RyTGc5dUxHYWgyK0ZjYW5OUGkxbmNpeUZnZWJuNE1Dckcv?=
 =?utf-8?B?SDVvdjU1Uk1IdDM1NkFmekJaa3h0RUVEb2k1UHBnYUxpSFNuWFVvaDN5OEZN?=
 =?utf-8?B?Rlo3OThiWUxBdEE0S3RwUUV0NWE1RWFSVjA5ZnVhMS9ra3JCRzZJcjY3bktH?=
 =?utf-8?B?THphZE83REhnbWFQam90Sy83V01ibkRYZ1RuQzFkNUVRMDdtYTBOWFNzYzVD?=
 =?utf-8?B?d05Gb3BWRXJFeDFmTC9kTm5tK2trQnhoamlGY0RZU2gzdXA2NkZ1S0RUQk9P?=
 =?utf-8?B?L1RYc0FwZ3JJekJML1VFQUsvQXVmdnk3TFlwUTcvTnR6T3lFMi9tNzgvVGpt?=
 =?utf-8?B?TG1oMTU3UVY2QjhwS1RJcHhYMGJqdSt6S250M0JNeU12Y25YWWV2NEtRODNz?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667b728d-e303-4763-0814-08db8dfacb28
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 17:07:29.5818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EF4SmctfwGpoYyiLOGqlXcYjS38e+ghl8PpMfup3gdUXnB2EL9qlg1Awyj+qBbPSTFPdaP5X0mcvmIB2YBdhgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9206
X-Proofpoint-GUID: XPMH68KInEcdZXwLHBKnk-q6X_bn9PtS
X-Proofpoint-ORIG-GUID: XPMH68KInEcdZXwLHBKnk-q6X_bn9PtS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 26/07/23 10:11 pm, Daniel P. Berrangé wrote:
> On Wed, Jul 26, 2023 at 10:08:05PM +0530, Het Gala wrote:
>> On 26/07/23 8:25 pm, Daniel P. Berrangé wrote:
>>> On Wed, Jul 26, 2023 at 02:18:32PM +0000, Het Gala wrote:
>>>> Integrate MigrateChannelList with all transport backends
>>>> (socket, exec and rdma) for both src and dest migration
>>>> endpoints for hmp migration.
>>>>
>>>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>>>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>>>> ---
>>>>    migration/migration-hmp-cmds.c | 15 +++++++++++++--
>>>>    migration/migration.c          |  5 ++---
>>>>    migration/migration.h          |  3 ++-
>>>>    3 files changed, 17 insertions(+), 6 deletions(-)
>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>>
>> Daniel, I have got reviewed-by / Acked-by from Markus (patch 1 & 6) and you
>> (remaining patches). What should be the next steps here ? Do I need to send
>> a new patchset / wait for more maintainers for their reviews ? Please
>> advice.
> At this point it is for Juan (as the migration primary maintainer) to
> either queue it, or send you more review comments.

Ack. Thanks for your review comments on the patches.

> With regards,
> Daniel
Regards,
Het Gala

