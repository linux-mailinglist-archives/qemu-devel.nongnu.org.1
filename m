Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0E1763DA1
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 19:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOhaI-0004wl-Nx; Wed, 26 Jul 2023 12:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOhWt-0003AY-8z
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:38:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOhWr-0006UG-DI
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:38:27 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36QCbvBa024178; Wed, 26 Jul 2023 09:38:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=nbeKCw14TslpvfB973OinIdzJGmWFBqj+ZboKrC/J
 7I=; b=wvi0PMDmmoPDz2lqL8xz3V1cmiThpyDXSCUVDNTAuk0d48nwN9sKT/MOZ
 /kT6ZKzOO3ymP7Z6PoptYs7SQ2aVawE30cDPqh8/pUXbudNMYITCTKYtS0s4Uht4
 LXmNmEute7L7f8yLGB/blbOC9/QcsF3VDS+HBxUhoBXZmI50KPeQqd0pWXN2ysoU
 Cc1THrkwrj1Wn3CBxrywhuICA7Ppyo7RtcrkwLH6pVyuVXuyMlzyYc20KpYJi3zy
 qLcdyaqzbdRtG8bXfk07/PBcpMH2Itpe3Mvyj2nIENBdW1aTbrd+/XcVHeVdi8GR
 ydvYRviy815EQyadpdp2qekvobmIw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0d7f0n8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 09:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLu7u3B/VO3IEgYhw/CNzlEWZydFQXkRhJ0h1+HBiUfQ63WUAyC3IaxZBn71TbiiCfDIMHaZIneE8GqQv878SivbONrnlFcCITmhxmTQv8MS4nCmuJ+8Ny10neobfXI6K12GB1DQ1c+Qxl5p95t0rSq/ZU7SRakxPy87eVUhtr6PB6Vuja+9UbB3GI0MM1mEg2yP18alysl/rZMo1dCzDI4zS3Nk4C4B/DNLVfk1Yvm6vwLa5wYXKKIIQr366Hn4Au7eXCX5lVEqUD9YKwWeFg+OTvmA2klrZ9kc4dRz+5svYFd/K/edyHxY6y+cEhX+l+MwBUBJEgwTEh+F4l0fhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbeKCw14TslpvfB973OinIdzJGmWFBqj+ZboKrC/J7I=;
 b=Yhxc+wOhWXG6n85zxEPlBOO7fFN21SdqweaRDC2MtCJ2j3kbaFu93oA45sVkPsZgBx40sPnRJp3khE/X5k08GmnEKnbAdxj6c+FYcfYLhHmbjhRJMfQ2BWpXjakZ9frjIU83H4tago8+5qIXJrtn91Ox1ysJy/oPP9XguLvEBAULWOK4ZdETTsvex/ML1q51eOmZHUVtTrWyIhB7wTG7QTeRAAid5HIRFGbk4d+EcbYpDEm1dvarYG7ge2QoA50yJRF/raU3qke9wwCW4wGYwTDvvaO327ACj58ALCUsW3qGTMZUGXMEYgV/p7+4/jZooFvdQ+fPxMtrwh6YgVRChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbeKCw14TslpvfB973OinIdzJGmWFBqj+ZboKrC/J7I=;
 b=uBIAuHtw/uEfFXTET6BCXNeQx1efVpSIhvSEuQKDdjsgsNsjes/cMZbi+Y9W/NwHOuOBtuMI+re27Qwh5O2BKEeBDGhuMHvQaAhtaZD2+doaNLxeu4jIm/PJmgnT+Kfr9ZUaB3c2WSLkeuX9UlLWa/3Zd8Vqwn87APfOX9EJs1nT13QpwVCswKSofxtdYlAvrmQ1soiWgrFCWD57tpj5SkKRoWfdIyBRTvSwX0Hz659MCwxWH9z3LyRj1ngh9NVj9zqNjKhUdd4oexSgztaHQ+2TaqqkQ8cNmQdXUHtVCDH/TeElHHjKRI3Q9QhvBa6tIXBi2rkWl5pv2n9JFVy7lg==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by BY5PR02MB6980.namprd02.prod.outlook.com (2603:10b6:a03:235::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 16:38:18 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 16:38:17 +0000
Message-ID: <94950119-ea11-4c9b-e50f-09741f100040@nutanix.com>
Date: Wed, 26 Jul 2023 22:08:05 +0530
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
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZMEz1SRK3QhJZG4X@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::10) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|BY5PR02MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 947a5fd8-9e61-4101-c2c6-08db8df6b6cc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cELto2Y+nngby7JjyiJgeSqQ2l3e4/KNnl0XRjlRZltsMeoO1TC1J4Mi8LQ9QsMLNlUoe1JULQJ+45Sf+BRrwuJGS7W97fkS72Kc+tvCKgMvuZtJWOOZJtLm0TB6fQmNYDFXAV1zd0nK5EeeYM5oBR046RzT0DX5sqVhc7gq/lOD0AduhexMWtQObXbK2xMjbRlG9otwb+8rHHu15B4JsYmwHBrjzOLqblpmtjNZpmh1IauUTbqiuCy5NZgJyl0wzYWbp/GNI4D7GRZZh3uftGHxtEX7hF1nipRWGqvkcX7wTe82d7AxHC+rorPAg+iszR0bsxRxJ7+lwv51WWZkBH3bRPoDDuSIgbq+MZ4xYjn+iQ76l4wSOVtZenqalcwU6r++38+C3gTvWgysNkDiJi98RavdRdUCBuQR2LSe6AJ6sI++/nTUXBl11LO5t5X+a0zJRo+sbdqTqUsOwJsd4BQgoxLxB7AlqQ2C488oOEUFuAK/PQQBkdk41Z7a3WGKmSuI9Xgy78nMZ3nZZlB0C49MZgCiatVuxvSBTMkhc7WArZEVK708r0pZN9Nl38T7dKcouFutL7NbZwtxEcUo8TqrvaJhH/4vtaP8qW0Em0Xdta+crmMd0q65LFFpqgnT/LbllnP7ezx02qfqY78xgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(39850400004)(346002)(366004)(396003)(136003)(451199021)(316002)(53546011)(6506007)(26005)(8936002)(41300700001)(8676002)(107886003)(478600001)(6916009)(66556008)(66946007)(6512007)(66476007)(4326008)(6666004)(6486002)(38100700002)(36756003)(4744005)(2616005)(2906002)(83380400001)(86362001)(31696002)(31686004)(44832011)(186003)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFNHNVVYYm4xUmh5NHdFTTMrTzBRb3luUTlKaG9oeXZXK0lWdzRhSTNZVnRW?=
 =?utf-8?B?MkJVODdCNklEaldYc1RDQ3RRQ2syamZQeGN5OHBjN3VKNERMWFdxMHM2QnNo?=
 =?utf-8?B?NzZvd1hDZEJ6dFBodWFleDEvQzlKR2JjSnRac2xTdzhaenVWQ2E2T3BrOUYy?=
 =?utf-8?B?TlVBYXJFaW12VmorWURyOFZQSFk2UjdnSUZ5ZUJlZnhaejUvWW1INWlpVHFt?=
 =?utf-8?B?UjljaTdKVlV2YkNveG9ZeTVCbE11UVBZS2lJMnhNUkNqZVoxMXhhL2YzdE4v?=
 =?utf-8?B?dkpTMFdhZGFxcjJTY1Y5R21yd1lKUkRFZlFhWFU4QloydDVuQUxkWi9DYllP?=
 =?utf-8?B?N2twSUx1Tml1THVlSlNuN2U3K25sWXBiM3JmWlZpWlk3U3Z6WlArR0RPWEhu?=
 =?utf-8?B?c3dIaDUwZ3UvdVVIWTVHQ1htdldmYzlDeFA3d3EybTFVRlViVHBxbGM5Mmdx?=
 =?utf-8?B?NXM5Y1U1bWxOYWp1NmtHbUdyY2kxcy9SU25JVE9oMGMxWkhWMmVkWVVjTDAy?=
 =?utf-8?B?RkhMSDFWMmJvaWRiSjVLN2RHNncvRkdDWkxZTE5lb1plSUkwOXlYMVU1VE5S?=
 =?utf-8?B?M1puU2lJVWc0ZTFPZjJMNEFQR1NPUkw3SkN3eVFWUWl0VCsyTUJKbkJxeUE4?=
 =?utf-8?B?aEFMcVJibmRxemJwbXJPamcxRlJqMUVoYWF6SjZpdUtOajNZQTlLSmtLcUZh?=
 =?utf-8?B?NEd3dTZKa2VPSXhDRWNqZ0F4NjA0NUJjQngzTGxzUFNEQzR4R0k0eHRYY2Vs?=
 =?utf-8?B?QkR1Z2xlMjFmVzl3ZlRMQzkxQjlscHlONS93RG9VU0pxUUliN2JiaVpXYlNy?=
 =?utf-8?B?R28xT1djVUdmZk9KcG1oOU1CbkRIZ01kZndwbUlnVm5qYnVkTGRVOHBnL010?=
 =?utf-8?B?a0V3Wk95RTJ3N2Q1N3BtdWZNZ3ByVWc0b2pDa01udVRENHloWElCcFhVb2pr?=
 =?utf-8?B?ZlVRUERRNjB2M3FTOENlUE9PdU54T2x6Rzl2Rjh6ZDNxSEZMSlhjbnNaZE05?=
 =?utf-8?B?clg1TzNvNE1VUXZteGZMcHJ3K3diVHN6ZjBhSHhaQzU4ZEIyN2pXOE00TUZL?=
 =?utf-8?B?YkMrMlc1aHdDOEllVWZXaERROFcrZHN0R2JFS3Z1SWtOTGNHejRGWWJEZ25S?=
 =?utf-8?B?R0g3ZDVKU2ZlZHl1RnBiZ29sTVNrRU1DY1ZxSEpKYm5JZjFHbXMyWURnZlVH?=
 =?utf-8?B?UFhqZXAxMlc4WFlkRnBRcWdiTlNlNitxajZDYnZzdnEvNDl6Z01NbVM4SGxz?=
 =?utf-8?B?cFJucml3dXpnR1VZekJCcEY0WWZKZG1sb1VMWnc0TzlHYk1pV2hFdy95Q0kr?=
 =?utf-8?B?djRFUVNKSnR5cTFhQkNRd2w5OWRNYUZUaGszYUhYdEQva2JHWUlRdzlJTzdD?=
 =?utf-8?B?Y0dZUnVKcVJjdy9sSjV0Q0RQbnZhUHlhOHEySWdydlZnOGp3UHVRVDl2Njhl?=
 =?utf-8?B?MzNLRW4wQ3VPa2lYWXhIQmxXRG1YZlFJaEY3Tk14aEwreHdETSthWjQ0c1hS?=
 =?utf-8?B?c0VDQ29tbkhKbUdaMksra3Q2d2QxNkl5U3RMME45dlkrWE1JbzZWREdSWTVS?=
 =?utf-8?B?aW5BcE5pTkNJaXoydXlOeWNMUDUycnpHaVZpV0RvZ0xvSmdCa0gzdUlkL3Rz?=
 =?utf-8?B?cWh3S2d3bFBXbktrU21zVVkrSFRYSVZCTVJOV2FOVjNGdHkzdDQweFE0OXpX?=
 =?utf-8?B?cUhuVXdLSk4wRkFnc1JpcGpoUzhlaVdjeTQvaC9IdE5vWUx5UFl1MDMxbVNZ?=
 =?utf-8?B?Z3FZK1hBcmpqQ09CWEQvNDBxWCthYXRsK0VYdTAycHpGU1JOZnovMFRxRkQr?=
 =?utf-8?B?K213VUtNRElvMzFiY1hOYkFSQnhDbWZLOHlTMTVmanVyaTBnaFJBWG1GY3h3?=
 =?utf-8?B?dm4xMm1tNktmMDVua0VZLzV5NExGTFlmV29sS0xJemw1T0oydWc0RFJjTVAx?=
 =?utf-8?B?bVFZdDRuYjE3YndubjRuRzYraEdDNjc2TlhSc05mck1kYkxmSHNNTS9XSWVF?=
 =?utf-8?B?enE3UXpPblNTSVJ6Rmc5VUd3K25JUjk3WFpJQUp3RnVNUmNLMUp3TU9Zak1y?=
 =?utf-8?B?OGhDMXhaUzFEUXJjTlVoN3Y4bEZGZWNQWFNyMnNNWjhwaXRZWGpOR3dBNk9y?=
 =?utf-8?Q?3j58TbNfbAHQ/bPFGRBSJ0oqb?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947a5fd8-9e61-4101-c2c6-08db8df6b6cc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 16:38:17.5455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+U8u4fvXZcc9KrohqKqvF/t/jABkHx8M/1lA4vfuzvN9l6HJN+ShJq31DylB9MKGw9XfXNR6XVtvicdeabQ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6980
X-Proofpoint-GUID: MgGaZBQT3m8e8kqDcqjjrYlNNUvk96iE
X-Proofpoint-ORIG-GUID: MgGaZBQT3m8e8kqDcqjjrYlNNUvk96iE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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


On 26/07/23 8:25 pm, Daniel P. Berrangé wrote:
> On Wed, Jul 26, 2023 at 02:18:32PM +0000, Het Gala wrote:
>> Integrate MigrateChannelList with all transport backends
>> (socket, exec and rdma) for both src and dest migration
>> endpoints for hmp migration.
>>
>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> ---
>>   migration/migration-hmp-cmds.c | 15 +++++++++++++--
>>   migration/migration.c          |  5 ++---
>>   migration/migration.h          |  3 ++-
>>   3 files changed, 17 insertions(+), 6 deletions(-)
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>
Daniel, I have got reviewed-by / Acked-by from Markus (patch 1 & 6) and 
you (remaining patches). What should be the next steps here ? Do I need 
to send a new patchset / wait for more maintainers for their reviews ? 
Please advice.
> With regards,
> Daniel
Regards,
Het Gala

