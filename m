Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 768E276DFD4
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 07:44:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRR7V-0002og-40; Thu, 03 Aug 2023 01:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qRR7R-0002oS-RC
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 01:43:29 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qRR7P-0003rM-Eo
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 01:43:29 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 372LSSMn007014; Wed, 2 Aug 2023 22:43:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=6XiwNWtWvICQTJ/OtSVPZhzczce+iEvBC8raezP5M
 ww=; b=rtkMHSz9eCut1ndDG4Oym5tHVhIQ6iF8jXU3n3NKvuU2TSgvZloa4FBcI
 GoUg1YEoxVc5o9vP48V7w6moGWHpdrpal9dTd4LqJ0II6mxmbPuaVyPP4jY61TUf
 X+ZigjrYkvvlW7ntziJj3bWg0+O5O6NXQ3VPIUcEna48Ho6k05wBvdzJDWyf2lV3
 /UP1aTAq87F6hGGwGWB1vIE/x5sapoIKqdb2sEELtGMuUZ3hc/fj4pUzvH9BbfXl
 0GJy7/VTqQIRU4Ca7i9ssrSj+mumeO47VvdCsDpKZ2weB8x5HG/bxIwnEClGC8T8
 aycuHfDHf6ZtSCefMGwbF6YBWcESA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s52avskux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Aug 2023 22:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2Y3WzfCUSUMxp+9q0EPETmrhgpUCoI7eoZyuQehtbctr0247FIz1eeUQtrDfoKk8nja/F7sOhBrLCZ/chy/tta8oKyLsLQxyCcCOC/v/zmh7Kt2AlH/yw0unGDZso/pHhVqJZb9MUAR+HtCFNKO2I/PHyvJnqc5FT2dqXWp8OqS1C2Aih2xbGOjBPyz64o5hJWrI3Sy19QSWpi9fivIJws389/NZhtcVZw/tt/pHNpoHuds7GAz0UOJXNkEONXTaivWZluPAKUkSdVVodk1ozpwFmWYHMO3vT3N8gDa5fwx2hSmzWNhO7iIoDOvjFNm7AMLw42I3Df7wLGinSjogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XiwNWtWvICQTJ/OtSVPZhzczce+iEvBC8raezP5Mww=;
 b=jOh6GO4u1rZrGY2KEuZm+a/nzPBxqnkYxz3cDYLOvvLNyTTx0tX6KqBCXHl9GS8W+v1qjJH67dOl4Mh92Iej/AiZS07Z08DDLzjTZcaXeFLsJOoLGhQLqHvKg6XFOaT/8qJ0W4xN7RvlBSQYzAxFJh8UwQNitQWV5u2QdE73tNDmoF88Rxr+RzO0o7+bl6rvMSwumsBzFbldU4SPYxoQ1UfrN8RoC7VNkgeXHN8oyTEbNWqmzsG8Ff8LeeLk2Aa7iqaRDv57IY7N0jedpfD8QnS+80PvSTDSViDTDo98zQEqmvntyNdk4nc4qc4bnJ0cPasQm4KwVMEnr2kVXcCcMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XiwNWtWvICQTJ/OtSVPZhzczce+iEvBC8raezP5Mww=;
 b=Jj7raeGQIQMJtsBeLWalJVQNPJXw5bFrh9z50NI9PGn0zGhHqVbL9KIdTSSOOlgXHewQufIOXO4dvQV/v1HmuZ7aNpmUiYBnv4NRlL8OAZ1iog8O3fmCgjNM+DIvPV2JnGFEjkFc32PXBKKEZs5qLW2zrHQPYS/nJYafMmgQWwcEkAJy/YdvcT81IgEat3Dtzfp2/RbBq0L0HT/DXtpOg+V9teFtCDox5hRDO+y8xjgnC+GdsHxLNihxmJOSabgSnKwMNkMHHPj+vqm7Ksp0LOY97rXRYaclfHOJcF52ogNewuSZagGXW+g5R86RI8nIDNtu2WnXrCVzz9fpwPB+FA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SJ0PR02MB7855.namprd02.prod.outlook.com (2603:10b6:a03:322::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Thu, 3 Aug
 2023 05:43:20 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::c22:9954:465b:87df]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::c22:9954:465b:87df%3]) with mapi id 15.20.6652.019; Thu, 3 Aug 2023
 05:43:20 +0000
Message-ID: <a81add8b-f08b-6589-e9f5-779a4a7bd63f@nutanix.com>
Date: Thu, 3 Aug 2023 11:13:05 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v10 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230726141833.50252-1-het.gala@nutanix.com>
 <30cffa41-3e39-205f-5119-d84d6303f58c@nutanix.com>
In-Reply-To: <30cffa41-3e39-205f-5119-d84d6303f58c@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::13) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|SJ0PR02MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7dbc04-e737-4520-e4f0-08db93e48afc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zwUwcpdzSEMKSq7PIwYtkb+eQie5fgPtNgw2bdXVmGo0TtabyH10KjTEx9y2oWHeHwPSJ3EjMfsBhsS0NmEcOhlWlr1nXGEVIsd5EZEaYds8MTV/HLYLF87uLl1c7j48k+PQLamD13mqM9LAvTahfeqXr4abTgdj/4oUN8SNd6/8acvFtq4ePc02l7Mje1/lAp+hXVq0Ysqk0327naaRxkyu//7BaJ/HaWHLz6JRrmv9ziq9RIfz4SNT61WHZwSL6u/CP96QbJc4yTOCzSfgWRH0iLu7yCP5/+ztoakUvSMhlu88yAZBtPlC/k2rhJyuwbGPpiIILKIt2lbFR397X7MMyIiIEzilQMmTs5fQYH7Ef0loG4+ZU8zMFEVSTCZCklP/gozR2F8FF556o1TPCsf9ebmipr6qbcqg/z0lzu2ALLXdy5oog9ldmzzZiqJJRE0WTbXzyFY3J4UhPpdRG5t12XdXdNaApTISsbVTXG08q/6+Bsi8Oxhp2bnvQ2cSgUL70oIevev2cmSRTV69pbxEj7b/ZMsGORh7389sPf8qCzjJ8Y+fSwsZoVMk5MGtaBxP5LyNDSpL4gIcWaN5bJC+Lw5enDBU+dqvmCO3K59/pQ3Ttd83cfueGqvr9g41i25yFY5c2O8oyZUGtyjuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(2906002)(41300700001)(2616005)(478600001)(6486002)(38100700002)(83380400001)(86362001)(44832011)(31686004)(36756003)(8676002)(8936002)(186003)(316002)(31696002)(6666004)(107886003)(6916009)(26005)(966005)(6512007)(5660300002)(4326008)(66556008)(66476007)(66946007)(53546011)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZS9TMkFhakFERTVEY2RDSW1uLzF1MkZyTElxcXdVaVZ5N25aVitnLzNZZ2Q0?=
 =?utf-8?B?NXB5SnVBZkpPQThlQjlmOXdJZzdTemlTcmpjeFVBRHh4RER0TmdONy9SenZD?=
 =?utf-8?B?QzJlV2Z2L1VHR3BGSlRXY1VrbUFlMlVOV2x1OUtBWml3V2t0eVpzTi9zU0dN?=
 =?utf-8?B?ZHo0ZTdPVnd1Y3RjL1FNWlF4dWZnTmt1UEZrVnFaMEx5RnByRU5UOGVZOFdK?=
 =?utf-8?B?WWQ2K05oU1l5MHk5dmVPcUlzOTNsSXY0eEtaYXVQY0Jra3lndExUKzRKOW9u?=
 =?utf-8?B?TE9aMGZSNEdzOE5pRnBnVStjQmtOY0dJYUhFQlAzM3pvaUkvSTRkdzkxMlRL?=
 =?utf-8?B?dXVDL3NRNXVSZHJLeGhEZ1VpQzUrSVZOZGpHWjhuRzVuMjhWMHVINXNLUEtK?=
 =?utf-8?B?czVJQzZhR00yOWVYZ1VwdGxmSHV3ZDVxeEFpU0NaU2VBem94SldOa2NaQzZC?=
 =?utf-8?B?anBFN0dLL2NueE1wZWhnVXROOXVIcmdZVWhqc2k2YTRpbWhYMXVsTDlENXNu?=
 =?utf-8?B?MVk4dWRrM0pxcHdLV2toVzE4VW9sWUFkazZMdno2MWhkcWZNVllGYXk5akt0?=
 =?utf-8?B?a1h0RU9tSGplcGYxNytRQ2lFaW94MlZmdDBQQ2pjeTJVM1N5ZENpWjJ2TEkx?=
 =?utf-8?B?S0lZZHFJdWxDNFZLSUdJRCtHWHJ6WVRpSnBFYmpxeHFhaEhsblowR1dSU3Jo?=
 =?utf-8?B?bTVoVTVremFVdmVlM3FJRlZKNXVTb0ExTnFwYzZoK281THQ3Q1dTVklQaVJ0?=
 =?utf-8?B?ZGxyMC9wMlM1Q21EY0pTWnlKODdBYUlDQ2hnTEdDaUdGbUp1VkZQZ3AzT1hW?=
 =?utf-8?B?YkpIaXNWMGlzbXUzeExmYnlqRGJzTjcvVXEzOUUxVVpBdzJtUlhYSkxxQ3pu?=
 =?utf-8?B?M2dUdVZQbmxqWmZkQkNjS0Q5L0xKQVp5YUtEYWNocWc0WkdHbFh1ekhRUnBz?=
 =?utf-8?B?N09KMEZFeHUzbG5Ud08rUEVONm85ampYdWJuZHRRL2ZvRCtCM2lVVXpZQmVP?=
 =?utf-8?B?bkM3VERZek44VnBYMTViWkxXNVNuMmJrWFpWVUpxSlhpQ0UyRC8vTGxNWUxI?=
 =?utf-8?B?dnJnZHFVL3RndDdOSmpPOERLcmROelgzY1Mxb2M2K0kwYUcvYkZtS0pUMm1F?=
 =?utf-8?B?MTRyU1hmd2sxc2NjTUVNamZHNHVLY01EUHd5ZlBEa1M5U3Z0YmtpMERsdGNo?=
 =?utf-8?B?N1doZ2NWRGVmdWxBZW56VXdmVnUvWkhpMWZ0alVnWDh6dFdrK1haRi9paDFD?=
 =?utf-8?B?MGRzR01zTXBrNWluWUpGbVJCN2dmMm9lZFBJUkJ0bkNVZkZnUWtLM0xnN2Iy?=
 =?utf-8?B?Q2o5dEhOL3hJdy96UmpxSGRicUYzUmRuZ0ZadnYvemljcGo0cjJHeXdrQ3hs?=
 =?utf-8?B?SVp1elVIT3pUNW1Dc3hSa2U0SmZqUEFUUTNjUzJyQ3BZOWh0TWJwWG5HZFM3?=
 =?utf-8?B?cGdaOXpnTlRsZUhnbWgvU2tsS0dlQ0FTbFFiVkZGR1V6NFZ2QytFREsyOU5r?=
 =?utf-8?B?RVNOQVNCbnQwUVJSUWdjMGh1b3BvK20wRmtWUjFDcmZtSWdIaEM3YndDQXVm?=
 =?utf-8?B?dnMzeENNUFhZZWM0UEowM2lCd3U3Z2tsYklEV0lOSmczMkZoQzh5Wi9Yd2lM?=
 =?utf-8?B?Y2h3eERzZnJDL2xGRTBCbzNETEY3b0tzSnFtbGdpaW9hdnVYMTg0UlNuVGdX?=
 =?utf-8?B?QmYwUjh5czgxSXZCN0tydHdWY0NFWFJoVnQrbnZNZUUvQ0xvazVwZmM3QkFr?=
 =?utf-8?B?YlErYkdNd0F3dzFMYnBuQTdtVWhRWk1ReFF3dlQxWEF6dW5FZTdSci9nMUs5?=
 =?utf-8?B?UmUzNUJWOGFNRmhoVkJ1d1J2NzUwa01OSXZ1ZUluV280b2VmTDl3MmM5YmlJ?=
 =?utf-8?B?UWN6T2Q3bzB1azlNNkUwejNMYXdNTnBERkczaHFaK3phaWcvellYU0VzeG1C?=
 =?utf-8?B?WEZLVmtXWEs3RnBjVktoZFJiNng3bW9XRDE1Z2JQcWdCSFk1VHJES25Wd0VX?=
 =?utf-8?B?R1FXd2EyaTkrWFNaSnM2TFNndldjTUZHNklsczhlZmoxS0h2dFl5djN4YW52?=
 =?utf-8?B?amdReDFndTlJVkRqaXpjQ2FqbHQ3cTBQQ2Y4SzVjWkFLMXlBYnZySEJ3RUdB?=
 =?utf-8?Q?gRdacNAN7xUZkB1pxf54HmrNf?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7dbc04-e737-4520-e4f0-08db93e48afc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 05:43:20.1317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnGWscimtaByJ32g021Q5ax/e/caG1eg7jTiNBqx7/fSuuARI3p3WItOLOXg39FJP3XSQXutn65HONOvc7hPGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7855
X-Proofpoint-GUID: UrEPeoacaAVR0VHiOsjPtMZayyxXzvvc
X-Proofpoint-ORIG-GUID: UrEPeoacaAVR0VHiOsjPtMZayyxXzvvc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.102, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

A gentle reminder for Juan and other migration maintainers for the 
review of this patchset series if any changes are required or give to 
queue them. There are more patchset series coming after this. As 
discussed earlier, we have broken down it into 4 different patchset 
series. This is just Part1 of the 4 patchset series. Ultimate goal is to 
'introduce multiple interface support on top of existing multifd 
capability'.

On 27/07/23 4:59 pm, Het Gala wrote:
> This is just a ping for Juan and other migration maintainers, if it's 
> possible to have a look at the migration patches for new QAPI design 
> and suggest some review comments if any.
>
> Update till now : Have got acked-by label from Markus for the new 
> migrate QAPI design, and reviewd-by label from Daniel on the QAPI 
> implementation side patches.
>
> On 26/07/23 7:48 pm, Het Gala wrote:
>> This is v10 patchset of modified 'migrate' and 'migrate-incoming' 
>> QAPI design
>> for upstream review.
>>
>> Would like to thank all the maintainers that actively participated in 
>> the v9
>> patchset discussion and gave insightful suggestions to improve the 
>> patches.
>>
>>
>> Link to previous upstream community patchset links:
>> v1: https://lists.gnu.org/archive/html/qemu-devel/2022-12/msg04339.html
>> v2: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02106.html
>> v3: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02473.html
>> v4: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03064.html
>> v5: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04845.html
>> v6: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg01251.html
>> v7: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02027.html
>> v8: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02770.html
>> v9: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg04216.html
>>
>> v9 -> v10 changelog:
>> -------------------
>> - Patch6 : Added extra checks for migration arguments.
>> - Patch8 : Added checks for 'uri' and 'channels' both not present.
>> - Patch9 : Missed adding hmp_handle_error call to print error messages.
>> Abstract:
>> ---------
>>
>> Current QAPI 'migrate' command design (for initiating a migration
>> stream) contains information regarding different migrate transport 
>> mechanism
>> (tcp / unix / exec), dest-host IP address, and binding port number in 
>> form of
>> a string. Thus the design does seem to have some design issues. Some 
>> of the
>> issues, stated below are:
>>
>> 1. Use of string URIs is a data encoding scheme within a data 
>> encoding scheme.
>>     QEMU code should directly be able to work with the results from 
>> QAPI,
>>     without resorting to do a second level of parsing (eg. 
>> socket_parse()).
>> 2. For features / parameters related to migration, the migration 
>> tunables needs
>>     to be defined and updated upfront. For example, 
>> 'migrate-set-capability'
>>     and 'migrate-set-parameter' is required to enable multifd 
>> capability and
>>     multifd-number of channels respectively. Instead, 
>> 'Multifd-channels' can
>>     directly be represented as a single additional parameter to 
>> 'migrate'
>>     QAPI. 'migrate-set-capability' and 'migrate-set-parameter' 
>> commands could
>>     be used for runtime tunables that need setting after migration 
>> has already
>>     started.
>>
>> The current patchset focuses on solving the first problem of multi-level
>> encoding of URIs. The patch defines 'migrate' command as a QAPI 
>> discriminated
>> union for the various transport backends (like socket, exec and 
>> rdma), and on
>> basis of transport backends, different migration parameters are defined.
>>
>> (uri) string -->  (channel) Channel-type
>>                              Transport-type
>>                              Migration parameters based on transport 
>> type
>> ------------------------------------------------------------------------------ 
>>
>>
>> Het Gala (10):
>>    migration: New QAPI type 'MigrateAddress'
>>    migration: convert migration 'uri' into 'MigrateAddress'
>>    migration: convert socket backend to accept MigrateAddress
>>    migration: convert rdma backend to accept MigrateAddress
>>    migration: convert exec backend to accept MigrateAddress.
>>    migration: New migrate and migrate-incoming argument 'channels'
>>    migration: modify migration_channels_and_uri_compatible() for new 
>> QAPI
>>      syntax
>>    migration: Implement MigrateChannelList to qmp migration flow.
>>    migration: Implement MigrateChannelList to hmp migration flow.
>>    migration: modify test_multifd_tcp_none() to use new QAPI syntax.
>>
>>   migration/exec.c               |  72 +++++++++----
>>   migration/exec.h               |   8 +-
>>   migration/migration-hmp-cmds.c |  17 ++-
>>   migration/migration.c          | 190 ++++++++++++++++++++++++++-------
>>   migration/migration.h          |   3 +-
>>   migration/rdma.c               |  34 +++---
>>   migration/rdma.h               |   6 +-
>>   migration/socket.c             |  39 ++-----
>>   migration/socket.h             |   7 +-
>>   qapi/migration.json            | 150 +++++++++++++++++++++++++-
>>   softmmu/vl.c                   |   2 +-
>>   tests/qtest/migration-test.c   |   7 +-
>>   12 files changed, 409 insertions(+), 126 deletions(-)
> Regards,
> Het Gala
Regards,
Het Gala

