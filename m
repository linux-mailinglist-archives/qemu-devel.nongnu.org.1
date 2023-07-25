Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A44B7622B2
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 21:52:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOO4o-00025X-UD; Tue, 25 Jul 2023 15:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOO4l-00025P-V6
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:52:08 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOO4k-0002un-31
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:52:07 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36P9rP91030033; Tue, 25 Jul 2023 12:52:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=kSuixKHDnuqWQG4u4OgoioS6k3Yobv2UcG4PUs+dT
 lM=; b=akksAbJwdXPVbLWBLsRD7se3Ewz8IFTVxn1/N6NQk8gWtqOP1zYJV38i7
 Dg9C7xGx5zcqZTiEBz5fsJvRpjtG7764bQ7UK3dmjTkTel1Oo3LVGmHLmvYLtaod
 c36cv4qeh1DPlGoI7nNmhdZfxdDqKtXaYTeo5BLQsfR344EfMew8Qh91PCTdl3OO
 kRkZRDh5mRjJKUgTbqnsS+ZHZsg7IqbQh6JCUS3pEoPjLolAlzYCwJdfdTaZ6km8
 1c3T0hVKuflhVZA/emXFJMyq+7qfTYQhY9MnX+dVGzR3boQ3yuaVb1hy43xdSyha
 DwNlxJme3wQnlVSPqmxZDOcN9K/7w==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0e6deb7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jul 2023 12:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvuAi/ANZ1Fys3IvjCJP7N0NXFxbby1G+4IZ/pUK3VcqsU/EmNy4rVOc7IDf67zvR4GWH8WV1LXlrH34ALZKsS5sbQhZd2CUyN1bs5VmLoh8Tk1Tl20pO+t9VYJc6eu9non5uUnv8qMolRhoSu6+rNdcJi8LHrtJ6l5d0JgonIi2/Yzt2RTnBQn63Z3tzoqGBsSO0wF0jvRdCh/fCo3jeZoSgFwb5hBUdWbBpHYeto7s32tiXnv/TSBNQn+2+w4VAJlcDoufqbJjD8kE7QnISuXEJ7XFJtzwgqGB703mT7gs14Bh6TRMBxUHgdUuPbjk/PN4NAJnawVYhx0qHCRyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSuixKHDnuqWQG4u4OgoioS6k3Yobv2UcG4PUs+dTlM=;
 b=QMvufFZ45twqp+3mAh40eccLThjTdV3cao+zQZMvf9KrZRQfZe6PKm/LKroVKcIA4j0GckqBIcapKMaaHvhP/YyrKi4V7Dvutni4gVgBV9aBlUM5kUlWyiHdeHxHv6wAORvkJYVa7K1v/kGeaE3/E9banG1C7owDv93WgsIvIk2LS5fPCm1+pZgB7JcjHhhkxOYsbg1aLDWgCuiBTlLVUEplB6u/UJ+pQzPkl63KVASzdQf8KkgqsiOjuSIu+NW2RzuBpulnTjZ14KHtnPbRtKGy0wTp91bHyPUh6gHpw5QAWAb8xG96Yec3WrMJN9KrJf8rlS6meaqv/rvpmnp7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSuixKHDnuqWQG4u4OgoioS6k3Yobv2UcG4PUs+dTlM=;
 b=RM1M46L9TQPDLehKyzye23FmtZG/f3tmxjGv5GER2+UguCIi3idv1KZUQynPLnIcfmZD+7lBqvmY7UO6ORgD+aqWCu9ogaRaZ1EUKpl0vb7Spdwg8Jwfkv6VmOuodNaFG8z0HxEMPhZE2hzVeQku94Og6qaMidoHWlBT7C64lfLuqktNg2/MNtTYdnoAxu1SxcyUHblszmKO4BfNvRbECy5PEYdQyZgysjf/Ynf207J+Z+XPoLJG0xCSWCp5QbNWCl156W97vEyofuvgeJOuL/ezvzU+7LnCvksnssd0BCY163WWsSAB2l7q3U35Xw0wC4X0fwNFplABSEO1BdE8Qg==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by LV8PR02MB9951.namprd02.prod.outlook.com (2603:10b6:408:18c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Tue, 25 Jul
 2023 19:52:01 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e%7]) with mapi id 15.20.6631.023; Tue, 25 Jul 2023
 19:52:01 +0000
Message-ID: <db98e231-9019-1afd-3612-27500aee735f@nutanix.com>
Date: Wed, 26 Jul 2023 01:21:49 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v9 09/10] migration: Implement MigrateChannelList to hmp
 migration flow.
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Prerna Saxena <prerna.saxena@nutanix.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>,
 Manish Mishra <manish.mishra@nutanix.com>,
 Aravind Retnakaran <aravind.retnakaran@nutanix.com>
References: <20230721144914.170991-1-het.gala@nutanix.com>
 <20230721144914.170991-10-het.gala@nutanix.com> <ZMAfUtLLcjr+6JRQ@redhat.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZMAfUtLLcjr+6JRQ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::26) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|LV8PR02MB9951:EE_
X-MS-Office365-Filtering-Correlation-Id: c7384afd-ba59-467d-7525-08db8d489cf7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nEsgi83gC+PXQLP6sT1mUt2C+EFVbocuhFUKpYRg3MvIdEBlQiet5s/UeLuBdm64MO8bK8Vkg8idT9UT/lD9kug8tUEOKdjRlitqiZKgfZCBBh3ywovdrS7BZSv6YwrZyUBhhyGEJslPlBdRxHB8fjtF7QeukmUUR6Jw4TuxWaSrf6JF+eUZHyrKKQ1c1UY61qGSNpvVU5l/SdNKYlgy9iuMu8MRKdTwE0+8+Y8Ipu70JoP94zYkzm9Dh5jk/89UAjCu+RAHw3U0dAAklhLCjrPwKf4zZA9MzRrXxh3VkMCljZCZyKt3pTJX1j1Be3xcuEqJeYMPlEfDI3KsrRWkIfePjCmpV5pPtN8R3fsfMCtL+vrFqZKEunbfCMp4sukNTEqDoDQOUm/RzlWO6Bo6Y9saWrzg564l1ajhic1CKjcU/GFwe+O0Z3VOFESJKubH/c6xz5Q9Trrza2Nz/QQc4MXZ+C7mFQF/80SjIVCq2vogN4XBJrwIalB3f28WxukG5boOI8PtBVtPclFBvHAosLTRykRv51QzzUxu7hp9C9xB/Un8mr5lrVTCrayaMl0N7kRPpfH0lPNg5g/6pYXu5nH9t18yY2kuCW6+1v3dl+mePJwl/1n/YRz2rcCeLe80ICz2rnf5HKpUTkb3iATE3rIxpAfw5QWQVWt0ezCRURWOxpBPPz5dakpH2IY7eg5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199021)(2616005)(66946007)(66476007)(83380400001)(66556008)(6916009)(4326008)(316002)(6486002)(6512007)(54906003)(478600001)(2906002)(186003)(53546011)(107886003)(6506007)(26005)(44832011)(6666004)(36756003)(41300700001)(31696002)(86362001)(38100700002)(5660300002)(8676002)(8936002)(31686004)(66899021)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTJOejRFcVdwTTA2MFpHblppT2RLMFZTQnlsbzF6N2dQZFlHOUhWRHl6Mlpv?=
 =?utf-8?B?enhKUThKRkRNOGE3RGloZU9WTTZiTzU2S29mdG5hQXBpemxxY205cTJuK2Zi?=
 =?utf-8?B?VVE3MEQ3bndIM3grQ2dPRDJuZ2p4SkZLRFQ3OWt3cCtnYW1VbC82ZGFyc0tE?=
 =?utf-8?B?dEdXQTh4VnZVOXJKL0Q4bjhBUnFmQ3JSeG1VSlljeG1lVENuZ3ZBamJXMmNH?=
 =?utf-8?B?ZUxTU096SnNVdTVVQTJlTG1hRXlsU1AwV3RDcGpRdnpZc1A3emhKaU8vWFhy?=
 =?utf-8?B?RjNnbWk0emJzd0IyZGRjbklMNjlYZDJ1ajkrdHlzOFQ3bll2VU50M3NzaDdk?=
 =?utf-8?B?S1JFSjFoS2lFVFNtUTR6alQrTndieUhadlh3YkQ1MStZeGVJK1Blek5ZSmVL?=
 =?utf-8?B?SE9wbkhPb0FwOTFCUE91RmxnT1hpTDZLR1BVVFkrNHB4U3p5YjVPZG5KR29Z?=
 =?utf-8?B?eFA1TGZJMDNZRTNBbzQraklhTmlqeDhGV3hYYk9lV1VZWXY3VFNmVUhxczh0?=
 =?utf-8?B?bWNGcGcxMVVtRGJpdzNLQ1RUbmNoUW5pL0lGRk5WMEQyRGZFY2REUTRoV2Z6?=
 =?utf-8?B?UFVYUUtKTWJmNXNLU0tRWjNZSXdXRVR3YWw0T0ZkdVU2bFZUY21jb2VHekcw?=
 =?utf-8?B?WTdLV21vWkFiUytkSjFoYVl3b0krZitUL3pjbG1WRG5QRUk4R3F1LzNJTFZ4?=
 =?utf-8?B?eXJydW9DclpJNGs2RU9JcjhOWXVaNUVqSnZud3FlSGpBMUxtMiswcVFhdmhK?=
 =?utf-8?B?Y1FubVRCcjQxSGthS3FRSzZPN1g5Y2pKV2s1eGVOaWplMm9YV3pFU2VEK1ZX?=
 =?utf-8?B?WVVUOXF3WEY4d0JtZXdQR2lIVi80eVg2Rm92dWtSeXM2blZBcndjckNpQ2s0?=
 =?utf-8?B?NnQzYXFOcHVCcjhUemlCM20xSHYvV2IzV3dpQTMxQUdyRHhnS0hONFMrSDdq?=
 =?utf-8?B?b0dEdTJrek0xNmEwMUVlWExhM2xSV1ZZZWxQcXRuUGNpMExrT0lZMmhibzQ5?=
 =?utf-8?B?anR1dWVjM0VRUXZWb1F2dG5WMGJld085MXJXdnRPN3VVTlNLRWZESkFveHdK?=
 =?utf-8?B?aFhWWFZVcXRYY1YyVmc3Rml0TWRmY0ljdEh4RlBJck1GeEQ1STFuU0VWMWl1?=
 =?utf-8?B?ZDVzNEVub1drZFFrTk1mSEZ2SFRqa1ZrTHNFQmRmMjJrMGN6SEZtdXFvSlhp?=
 =?utf-8?B?bmcvOHJJUERMamdTQ0VnQi8wZ2NNM2UvenNxazJiM1VYZDdDRXppVEJUZFF2?=
 =?utf-8?B?NCtVcDAvNlZJTGxTM0thbnB4M0h5a1NxdlRpL1F1a0VaNTRoT05Ud1RVeWU5?=
 =?utf-8?B?VExUdkJKWDhUb2VJUTZ5aGRUT2drRTFnN2xIZlM2VVdLQkdlSGtoWmpqMDdp?=
 =?utf-8?B?RFM5WVdpUnNuWkgyNUxDNWR0UGZSbjBFcmVMYTBkQ1UzaUJYWFUxQzNaTG1C?=
 =?utf-8?B?dUNyQ29LTnpwRTZRQlc2WkltRHdDa282amdNTEN2R3hEYW4zSXlkM3NjdzNN?=
 =?utf-8?B?Q3VvZkhCNW1kYkphMXJ4UU1jTHNDUGtaMVYvU1UzcGhsZnlpb2lrcWcyeERz?=
 =?utf-8?B?dnMrVG9OMXpIVzdqWTd2cEFweVpweEFKeEk2WnhlYnhnZ2cxNmV5QkJrY0dx?=
 =?utf-8?B?QjAyc0FSU1RJankwa2lIZ1ZpWEFocW9rR3pCYkFlRndXMitDbXZrMXlyUFlG?=
 =?utf-8?B?K0JFWlpyZzV3cFlxNzlLKzBYRVZyUEk5VnNWWkpjOFZqL3B2dnBlSUYreVNT?=
 =?utf-8?B?U0F3Y1dyeVdEcG5lQ3dQUWxhM0xiRWc0U0VWeHNxTnJ2UXVxZGtXUW96L0tL?=
 =?utf-8?B?dVZJOVA4MEZXdVpOazB1Y0I5azZ0VDZIcjdLQ2ZKei9FcDdjclJxNDhIN3R5?=
 =?utf-8?B?VTYvTDFzZ2dIdEI3YlIxT3VHWHhoUEdudlQ5U2xHWUR4SlpKMGJtR0VIMm5s?=
 =?utf-8?B?cmphU3lvRFRSS2tsb0YzZ2RvNnE3R0xDUFEvSFVJVGlCTEpZYklVUE9SdzhH?=
 =?utf-8?B?VTF6TCtVVlVZTHg0TVZFUnFLbURTbm5vYSt2OEUvaUpyWFBEWENJNUdLU285?=
 =?utf-8?B?MWgyQko1dVJXWU5HODRBckRrSFJ5cTI1V0xyeTlmMVJuZ2REWTQ0dWZPd09H?=
 =?utf-8?Q?VneQQcGqXra1p8fTwkqp9YRnh?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7384afd-ba59-467d-7525-08db8d489cf7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 19:52:01.7233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: re2ovcE5x5ZgdGMIMFL2imH8LxHq3EU086Pe3FLDwjvHQpYK9F8+F2+PhlLsg2nCT9PVCflss1A83DxhaOj8Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB9951
X-Proofpoint-GUID: N3RpHNx2DdEemW9ukYdtmxxoO4TCd2ew
X-Proofpoint-ORIG-GUID: N3RpHNx2DdEemW9ukYdtmxxoO4TCd2ew
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_11,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 26/07/23 12:45 am, Daniel P. Berrangé wrote:
> On Fri, Jul 21, 2023 at 02:49:35PM +0000, Het Gala wrote:
>> Integrate MigrateChannelList with all transport backends
>> (socket, exec and rdma) for both src and dest migration
>> endpoints for hmp migration.
>>
>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> ---
>>   migration/migration-hmp-cmds.c | 16 +++++++++++++---
>>   migration/migration.c          |  5 ++---
>>   migration/migration.h          |  3 ++-
>>   3 files changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index 49b150f33f..25f51ec99c 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -423,10 +423,14 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
>>   {
>>       Error *err = NULL;
>>       const char *uri = qdict_get_str(qdict, "uri");
>> +    MigrationChannelList *caps = NULL;
>> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
>>   
>> -    qmp_migrate_incoming(uri, false, NULL, &err);
>> +    migrate_uri_parse(uri, &channel, &err);
>> +    QAPI_LIST_PREPEND(caps, channel);
>>   
>> -    hmp_handle_error(mon, err);
>> +    qmp_migrate_incoming(NULL, true, caps, &err);
>> +    qapi_free_MigrationChannelList(caps);
> IIRC, you still need the hmp_handle_error call to print any
> error message.
Yes, sorry, I missed that out while adding the statements. Will add 
hmp_handle_error call here.
>>   }
>>   
>>   void hmp_migrate_recover(Monitor *mon, const QDict *qdict)
>> @@ -704,9 +708,15 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>>       bool resume = qdict_get_try_bool(qdict, "resume", false);
>>       const char *uri = qdict_get_str(qdict, "uri");
>>       Error *err = NULL;
>> +    MigrationChannelList *caps = NULL;
>> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
>> +
>> +    migrate_uri_parse(uri, &channel, &err);
>> +    QAPI_LIST_PREPEND(caps, channel);
>>   
>> -    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
>> +    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
>>                    false, false, true, resume, &err);
>> +    qapi_free_MigrationChannelList(caps);
>>       if (hmp_handle_error(mon, err)) {
>>           return;
>>       }
>> diff --git a/migration/migration.c b/migration/migration.c
>> index acf80b3590..cf063a76df 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -425,9 +425,8 @@ void migrate_add_address(SocketAddress *address)
>>                         QAPI_CLONE(SocketAddress, address));
>>   }
>>   
>> -static bool migrate_uri_parse(const char *uri,
>> -                              MigrationChannel **channel,
>> -                              Error **errp)
>> +bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>> +                       Error **errp)
>>   {
>>       g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
>>       g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>> diff --git a/migration/migration.h b/migration/migration.h
>> index b7c8b67542..a8268394ca 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -501,7 +501,8 @@ bool check_dirty_bitmap_mig_alias_map(const BitmapMigrationNodeAliasList *bbm,
>>                                         Error **errp);
>>   
>>   void migrate_add_address(SocketAddress *address);
>> -
>> +bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>> +                       Error **errp);
>>   int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
>>   
>>   #define qemu_ram_foreach_block \
>> -- 
>> 2.22.3
>>
> With regards,
> Daniel
Regards,
Het Gala

