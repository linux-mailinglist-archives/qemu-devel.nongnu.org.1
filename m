Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D120271594E
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 11:03:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3vFi-0001iq-6v; Tue, 30 May 2023 05:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q3vFL-0001iC-HG
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:02:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q3vFJ-0005Yo-0l
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:02:27 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34U1aLvU004265; Tue, 30 May 2023 02:02:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=RVkDr6JDq5RIi3xB/2z5CLLqLxdgXWuZJyLI5j61LBc=;
 b=mxXPz+p8xCgC3rjqIU0TF7zTUTooNtFzaDagxKSzubOnT4NkfMX88qFDYICFa0TrxPLz
 AF3xmdKuzs5k2zzAZau/8SwKbeHV39bFGlWAtZmjqf368cMpQGdzgnoXKExlGuB1O87t
 afrwW/5rxLE3zlxgp61MJByqpx4oENxUUAZ2hw2QWpbIvL0Jp9II25ASLSVYb7ASdkVo
 CD/lnht0BnSZUMU6OPit/HMmgnPAIk1RwcBNv3avvwJ7CZ/7ils5CJCpt7m+e3w3dGtV
 2lDVAEy0dpRSQwi6b5ww23OAo2fwAhngcpV1tdZ/Sbui939Foxrox/pztUyJf/AU5db3 Uw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3quh6cequ0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 02:02:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfR9GTnWGS0yfu20f8vYfkLrZF864GEQ7XUvzWVHuAIPzr2tBjGSz8o910GgHCeP1eEfyVKAto33Pd/GVvBLO5Lb88C0U4AarF/6dPjyycPxrsQ5cyxV/CSorFF6Zvpas5DA5KOu4yanhAXQEQw1YwOH81sPxIdh3GrKJyFWXKamsv8oJtZpiNmenuSmnMBUZXys7SItx7AkIDRsyI3/EBcpn3g4/056kpHXCPG6+J0otfz7DNgmDle7LnsYR+M/lGla7+XeaFJBVQcJ7wRA21BiAUWTo0VUvP0ey3YT4tu2W0QwUhEAERQkJWjSnRhgWbAb5dQWGyPp13zYCZ3qFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVkDr6JDq5RIi3xB/2z5CLLqLxdgXWuZJyLI5j61LBc=;
 b=Hf9lrCMqcxyA+FGo+d2EP0TrcWp+6mVDr+KjJ+croyyGSgH/TAIiL+D8mqpFwgBp+R2Z2OwWEHh1DugndYtFOwAQUCzeY9C14/Uqfzsid29tHcnjfgpPWS3zvhOtRBXpsvKKM96tR5gYtf0qtTggEO4YOsp26Ajmd4ve1EJa4T2vrKtvhPQ0wtdBAlLM0BWDQAHhO1oScpKr9BYC94bihgJ61WpmVsfokQT8nyxKXl8wV1wPosna8nZD5y6PwgaQw9Yz/A8P/lJ1A4lEDOI3HgGUeAGhhHxdxk6vOV7fXJ7xBk4O0bHkIWyu+LSTIE5G6AyP+LTeFQN9xRpNMfSFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVkDr6JDq5RIi3xB/2z5CLLqLxdgXWuZJyLI5j61LBc=;
 b=ObVKKaIBsryXySuflXV8PvAwsa1M4tjKn+BhFzvLWm5vlHmq/qta67XgTBGpQ0j5hL9XyC3/FGWbZD3/dn0MC9Vl5VHQIf1mxgy46RvldEyVZ0x0hvntsVAWVXGuhpvX7FDtP2VNw7+ITndiwDPWxmmciWEkVx1tu3R37v2hp/3qCmuG69IMtSvednjvWOBJhd4Jt5IrMVDVm03L4FbQjgKzQBOmlFWgxwRSZmOD1mDsrT9ej7zO5tgqZ/pfBKhL9yR6LEya/ZXorCRnS0q3xcQ22YT0tXoZAH5qqoHiS3vQPYXEZ+HRKhCtA8fteUPyPxOn4X6yMxQO0hzmLgRQ1A==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CH2PR02MB7093.namprd02.prod.outlook.com (2603:10b6:610:85::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 09:02:18 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 09:02:18 +0000
Message-ID: <edeaeab2-aea6-b0e6-da50-817aa10be5c5@nutanix.com>
Date: Tue, 30 May 2023 14:32:06 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/9] migration: introduced 'MigrateAddress' in QAPI for
 migration wire protocol.
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-2-het.gala@nutanix.com> <87sfbkjow3.fsf@pond.sub.org>
 <af2e5fbe-75f5-d6dd-df8c-8894cc5b0056@nutanix.com>
 <87edmyuwzc.fsf@pond.sub.org>
 <99b3e516-2a4a-aa48-8bc2-7bb886b8db52@nutanix.com>
 <ZHW6c5JBK8NYf0nK@redhat.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZHW6c5JBK8NYf0nK@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::6) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|CH2PR02MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c062921-0db6-4e68-e9b8-08db60ec91a6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Elb3mWoA461EGcajnJv4eYauL8J1BVMhD435ZjhS/wCK8gm7Xxc/4egX3rTUAMBDW9w547HVH8VnyAa4LqXfII39te8GE0grXjVoYiGLUUyaM7WpNi7f85F3bSqX6C91qdmvobUhgVLiY2DYwWiNPo9fgyLX6qvEFVNue45ZcZ7a7TBf9wQAwphSMZbeew23dAFi6UDa+hGdW3ePEuY0Rl7e1tPb9x3IIspNGYUwLPJdeBI4FYKGnLqb9UWnJ57BbLMWexCnSx8t5mcarE8q25VL2umfDdH814YF6NJLJ2w8Rs++jrQ6gc8TLgdS31dSjCyf6YXesxU5r3VdIHfZBxuupFsCRqieByPlYa0mU06Wvi+0F/JYzgwiAZEuEPZ416UkKXeXsIcwg5VG7CTJadFtOs7DDANAK61qxVrIb0dNVK4k40yXqlAltQQgTqV+SecpYIut9G9p/0VF4vQgk1KieqEbG6PDEvlZX+7JP8vwkrV/cr20aIXAFqnkgWRS6tD0dKHrp2hmXEINGqHp15tPSaq7ZefpJbqq8HVP6Wl2UvmnfJf9xou8sXIEdErIsPyr/QLJe02lc7vQ9B0VFvjwI2ZGp2PDNJlT0BgiJCJMag8/YchkkQ7c5s/IungG8DAL9Meo/iCtXoMcdSxNZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199021)(6486002)(2906002)(31686004)(41300700001)(186003)(38100700002)(31696002)(86362001)(8936002)(8676002)(2616005)(478600001)(26005)(53546011)(66899021)(6512007)(6666004)(6506007)(316002)(83380400001)(4326008)(66946007)(6916009)(36756003)(66476007)(66556008)(107886003)(44832011)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEdMSjlvZUwzQmhjQ3J1djh3cUFFSnJUaHlDUXJKTkZyM3d3RkpMQklCaVZZ?=
 =?utf-8?B?T0FzTW9YMElWM1JZU2NXaCtFMkJJVlBTZktMVHZBYnhuR3VtR003REwwTTMr?=
 =?utf-8?B?MjVuaHlqQ01VZS9vMTFCQmFHUnNyK25FVkRoTXJOQjdzZU03ejcvSzFaRjQ4?=
 =?utf-8?B?NEpkZllwRzV4Qlp3Wm90NWZNMW5qT3BKOW45ZU5OUmxIeUd5VG8wREVkZHd0?=
 =?utf-8?B?b0FocTBzc0ZuREg5eE5BQkFkcmd2eUd1K2VhbnRKNFhWd2x4S201RkloOUpZ?=
 =?utf-8?B?ZC9OSXhtQWw4TTdqN1I5R2Z4Z0tkUHpTNWNPZkxwV2xSeHk0NzExVlRaTStE?=
 =?utf-8?B?OXovcUtQb0h1Y1E2dVJDR2VsbUF2Ynk1eHlvTjJSUGFudlRUSmMzYVZlNEpZ?=
 =?utf-8?B?RTF1UDNlWkdBRTBaeFFSS3hDV2c3WFF5M0l3aEZUQStmSEZkZEdMWk81cGhh?=
 =?utf-8?B?MndOQXRvMlJvQWFGelZUOG1oNDhqRStnTFhnaGU3bmFEakxJeTJodE9ja3ZI?=
 =?utf-8?B?bzY4MGdKTVJpeVVJckE4YXFBZ1J6d0hmWWdTWkhjbGkvTzIwb01CejAyQWZH?=
 =?utf-8?B?RlFRcTArd1doU3I3Q1M1L0VPcEx3SFkxTFo0ZXlIYU1MWUMraVJ3Y2Job1pZ?=
 =?utf-8?B?SFdGQ3hxOUhlWVBpclpZZmlyN0daa2wxMm5BdDg3T2pPYnhFMGEvOTRINnAr?=
 =?utf-8?B?YXdSOTcxUzIyQjJvSEtwVjY1dXBMU05qZlpWZm1sRUhxUzNxWWgvMk5FcTZx?=
 =?utf-8?B?UWg0YjZGRk1xRkRxSS8yV0VsMEhEQTVNUXJUZGlzQy92ckJOVnBSWTVIci80?=
 =?utf-8?B?MGlYTHR0WHl2L1ZUaWJrb25PS0k1bGRlYmZqeEQ2N3JQN1lUdkp6WWhDcnM2?=
 =?utf-8?B?a1BGejZrMFlUN1V4U0V6UjdISTF5cnZiUXN2cjRwd0grLzNqVWsyN3M5ZnIy?=
 =?utf-8?B?dXJ6R1FZWVhhYzRuUndreFFzZ2RjOXVQMzNaSFFJaTJna0hxVW8wdzJYZ1M4?=
 =?utf-8?B?VFNyY0VRRElqUmRXeVMxckw1QkJ3bkJZUzN6MDdzM0FYQkZWdUNLcy8zTlk0?=
 =?utf-8?B?YVE0cDQ3NWlZZHB2K25zNWhucUtLRXhmcnE5WUdBSWE1TWhPN2ErMWt1WWNM?=
 =?utf-8?B?NXMyYU1NdlErZW5BMldJR0kvY29tTk02OTRNOEJXZFhuSkl0c0k1enh0NXFu?=
 =?utf-8?B?UmhzS2RVRzNEbWhTdlUxUVFISTVGVGlpcXVNeGo5TmFpMDFxbDFrWkgxaHFB?=
 =?utf-8?B?b051S0xUQkxzaTFHU25XR3V1SXZDK3RDS1dtWThnNUVDWExVbzJBNkxZNTc0?=
 =?utf-8?B?Zk1VbHhjS2hodGcrV2h3aHlWYlZSM3JjQXBiemRIaEtpd2ErcGpTZU5KV1JB?=
 =?utf-8?B?RHRjcVlBcXBVeXFJL2MxZWdudmxSYWlLVHE5VTRVaHNIQzVhRVJsMlNuN0s5?=
 =?utf-8?B?Qy9uS3dQQW9FVThEbnZkSnA1RmRWQVA0UzFjYlRIK2tibmdMYjBGNWNoU1BN?=
 =?utf-8?B?bmNmdWs4eW1DUmIxVnVGbDN4YUNrZWtaYmphaFRqRXllOXZOa3dIQUc3N2Ji?=
 =?utf-8?B?QksvWkpwakRqSTVNN1NLdmg2NE5jRUZ1SnJndVBlRG14Kzg5Q0x2SmE3OVZQ?=
 =?utf-8?B?UXBuZTU0T0FrT1FLYTkwTUlTWGNuVXJ4ZTVKOGpIYlVhZ3NWS1I2ZVJlNUlr?=
 =?utf-8?B?dUF6QlpiVGRwaW45dGFRNW1MUEpPd0JBejBQc0lCSDlTcGxzRVpRb05WOGxv?=
 =?utf-8?B?akFyb0pCK1dyeE9TbnZaMDRMQlpzZytjUVN2b0RyV2JTdWpMZW9oemdDVWVp?=
 =?utf-8?B?V2VzL1ZrL0pHWHB1SVdDSzRvM0dCbTRuT1Rtamk2bVZySDJTMWRCZkdzUUFK?=
 =?utf-8?B?cGhIWFFDOXl5MEo2VDJXMitCTFNRU2c0SFlXamU2cExLOEFQdlRMbHY1aksz?=
 =?utf-8?B?SWVqbVc2dFJ2QmNpTVZnb2J5ZERoT1FEZis4eTRnb3BleVVYUUd0ZlVCQWJ5?=
 =?utf-8?B?U3EyanMxVzZXWnlrOWtUcU9yTjB2NVh4alpUOXN4TDZhNjhDQVB0by94MVVu?=
 =?utf-8?B?Sk9xRzB1VzJuUjQyRjBlWkZlU2xldlJQQ3BMK2ZwZVoxQTh2OGFkYkdGYXli?=
 =?utf-8?Q?MDKGAaOPX/NLJ4rXg06Z69/fd?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c062921-0db6-4e68-e9b8-08db60ec91a6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 09:02:17.9912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpXt5+M5InGF3rTVePC9bLmYmxHFbbBMr3De7wRvsxOYh4sdv53IPdAg31lUEZtxc15NyxL02Am7AHr9ZX9Cuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7093
X-Proofpoint-ORIG-GUID: 2QqqMWF43jvWSiwnjAEXem3oJFrNkq32
X-Proofpoint-GUID: 2QqqMWF43jvWSiwnjAEXem3oJFrNkq32
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_06,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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


On 30/05/23 2:27 pm, Daniel P. Berrangé wrote:
> On Tue, May 30, 2023 at 01:02:27PM +0530, Het Gala wrote:
>> On 30/05/23 12:28 pm, Markus Armbruster wrote:
>>> Het Gala<het.gala@nutanix.com>  writes:
>>>
>>>> On 25/05/23 11:04 pm, Markus Armbruster wrote:
>>>>> Het Gala<het.gala@nutanix.com>  writes:
>>>>>
>>>>>> This patch introduces well defined MigrateAddress struct and its related child
>>>>>> objects.
>>>>>>
>>>>>> The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri' is of
>>>>>> string type. The current migration flow follows double encoding scheme for
>>>>>> fetching migration parameters such as 'uri' and this is not an ideal design.
>>>>>>
>>>>>> Motive for intoducing struct level design is to prevent double encoding of QAPI
>>>>>> arguments, as Qemu should be able to directly use the QAPI arguments without
>>>>>> any level of encoding.
>>>>>>
>>>>>> Suggested-by: Aravind Retnakaran<aravind.retnakaran@nutanix.com>
>>>>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>>>>> Reviewed-by: Juan Quintela<quintela@redhat.com>
>>>>>> Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
>>>>>> ---
>>>>>>     qapi/migration.json | 41 +++++++++++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 41 insertions(+)
>>>>>>
>>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>>> index 179af0c4d8..c500744bb7 100644
>>>>>> --- a/qapi/migration.json
>>>>>> +++ b/qapi/migration.json
>>>>>> @@ -1407,6 +1407,47 @@
>>>>>>     ##
>>>>>>     { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
>>>>>>     +##
>>>>>> +# @MigrateTransport:
>>>>> I'd prefer MigrationTransport, because "migration" is a noun, while
>>>>> migrate is a verb.  Verbs are for commands.  For types we use nouns.
>>>>> More of the same below, not noting it again.
>>>>>
>>>>> Actually, I'd prefer MigrationAddressType, because it's purpose is to
>>>>> serve as discriminator type in union MigrationAddress.
>>>>>
>>>> Okay got it. I kept it Transport as they are different transport mechanisms. But 'MigrationAddressType' looks cleaner and comaptible with 'MigrateAddress' union too. Will change that
>>> Transport isn't bad, but I think a type that is only used for a union
>>> discriminator is best named after the union type.
>> Yes I agree with your approach too. Will change it to 'MigrationAddressType'
>> in the next patchset.
>>>>>> +#
>>>>>> +# The supported communication transport mechanisms for migration
>>>>>> +#
>>>>>> +# @socket: Supported communication type between two devices for migration.
>>>>>> +#          Socket is able to cover all of 'tcp', 'unix', 'vsock' and
>>>>>> +#          'fd' already
>>>>> Migration is between hosts, not "two devices".
>>>> Here we are just talking about socket communication right ? So I thought devices might also work.
>>> In QEMU, "devices" are the things you create with device_add.
>>>
>>> Sockets connect "endpoints".  Also called "peers".
>> Ack. 'endpoints' sounds very appropriate to me.
>>>> Will change that to 'hosts' as this is in context of migration i.e. MigrattionAddressType
>>>>
>>>>> The second sentence confuses me.  What are you trying to say?
>>>> I am trying to say that socket is a union in itslef right, so it covers communication transport mechanisms like tcp, unix, vsock and fd already in it.
>>>>
>>>>> Also, missing period at the end.
>>>> Ack.
>>>>
>>>>>> +#
>>>>>> +# @exec: Supported communication type to redirect migration stream into file.
>>>>>> +#
>>>>>> +# @rdma: Supported communication type to redirect rdma type migration stream.
>>>>> What about:
>>>>>
>>>>>       ##
>>>>>       # @MigrationTransport:
>>>>>       #
>>>>>       # The migration stream transport mechanisms
>>>>>       #
>>>>>       # @socket: Migrate via socket
>>>>>       #
>>>>>       # @rdma: Migrate via RDMA
>>>>>       #
>>>>>       # @file: Direct the migration stream to a file
>>>> Should I change from '@exec' to '@file' ?
>>> Uh, that change happened somewhere between my conscious thought process
>>> and the keyboard ;)
>>>
>>> What about
>>>
>>>          # @exec: Direct the migration stream to another process
>> No worries Markus. Seems okay.
>>>> Other than that, it looks better than what I proposed. Will change it.
>>>>
>>>>>> +#
>>>>>> +# Since 8.1
>>>>>> +##
>>>>>> +{ 'enum': 'MigrateTransport',
>>>>>> +  'data': ['socket', 'exec', 'rdma'] }
>>>>>> +
>>>>>> +##
>>>>>> +# @MigrateExecCommand:
>>>>> Documentation of @args is missing.
>>>> Ack. Should the naming '@args' be replaced by '@filepath' or @path' or something similar ?
>>> Depends on what @args means.
>>>
>>> I guess its [program, arg1, arg2, ...].
>>>
>>> You could split off the program:
>>>
>>>       'program: 'str',
>>>       'args': [ 'str' ]
>>>
>>> Try to write clear documentation for both alternatives.  Such an
>>> exercise tends to lead me to the one I prefer.
>> Hmm, basically here the @args means, for example ['/bin/bash', args1, args2,
>> ..., <command>], where command -> /some/file/path.
>>
>> Does it even make sense now to break into 3 different parts ?
>>
>> 	'program': 'str'
>> 	'args': [ 'str' ]
>> 	'command': 'str'
>>
>> This might probably just need to tewak something in the exec file I guess.
>>
>>>>>> + #
>>>>>> + # Since 8.1
>>>>>> + ##
>>>>> Unwanted indentation.
>>>> Not able to see any unwanted indentation here ?
>>> Looks like it got eaten on the way.  The last three lines of the doc
>>> comment are indented:
>>>
>>>       +##
>>>       +# @MigrateExecCommand:
>>>       + #
>>>       + # Since 8.1
>>>       + ##
>>>       +{ 'struct': 'MigrateExecCommand',
>>>       +   'data': {'args': [ 'str' ] } }
>> Yes, you are right. I figured out after replying to you and was looking at
>> the code. Thanks for noticing it out! Will change spurious indentation in
>> the v6.
>>>>>> +{ 'struct': 'MigrateExecCommand',
>>>>>> +   'data': {'args': [ 'str' ] } }
>>>>>> +
>>>>>> +##
>>>>>> +# @MigrateAddress:
>>>>>> +#
>>>>>> +# The options available for communication transport mechanisms for migration
>>>>> Not happy with this sentence (writing good documentation is hard).
>>>>>
>>>>> Is the address used for the destination only, or for the source as well?
>>>>>
>>>>> If destination only, could it be used for the source at least in theory?
>>>>>
>>>>> I'm asking because I need to understand more about intended use to be
>>>>> able to suggest doc improvements.
>>>> This address will be used on both destination and source. In code flow, in later patches, changes on destination as well as source have been made to incorporate same definition.
>>> Does @exec work as source?
>>>
>>> Maybe:
>>>
>>>        # Endpoint address for migration
>>>
>>> or
>>>
>>>        # Migration endpoint configuration
>> I think @exec work as source too, because in exec.c file, there are calls
>> for souce as well as destination.
>>
>> I would like to go with "Migration endpoint configuration" because I feel
>> 'migrate' and 'migrate-incoming' QAPIs are defined in context of live
>> migration.
>>
>>>>>> +#
>>>>>> +# Since 8.1
>>>>>> +##
>>>>>> +{ 'union': 'MigrateAddress',
>>>>>> +  'base': { 'transport' : 'MigrateTransport'},
>>>>>> +  'discriminator': 'transport',
>>>>>> +  'data': {
>>>>>> +    'socket': 'SocketAddress',
>>>>>> +    'exec': 'MigrateExecCommand',
>>>>>> +    'rdma': 'InetSocketAddress' } }
>>>>>> +
>>>>> Aside: a more powerful type system would let us extend SocketAddress
>>>>> with additional variants instead of wrapping it in a union.
>>>> Markus, what do you mean by additional variants here in context of socket? Can you give a small example.
>>> As is, we have a nest of two unions:
>>>
>>> * The outer union has branches @socket, @exec, @rdma.
>>>
>>> * Branch @socket is the inner union, it has branches @inet, @unix, ...
>>>
>>> A more powerful type system would let us extend SocketAddress instead,
>>> so MigrateAddress has everything SocketAddress has, plus additional
>>> branches @exec, @rdma.  Naturally, the type of the discriminator also
>>> needs to be extended, so that it has everything SocketAddress's
>>> discriminator type has, plus additional members @exec, @rdma.
>>>
>> Okay, so you mean something like :
>>
>> +# Since 8.1
>> +##
>> +{ 'union': 'MigrateAddress',
>> +  'base': { 'transport' : 'MigrateTransport'},
>> +  'discriminator': 'transport',
>> +  'data': {
>> +    'inet': 'InetSocketAddress',
>> +    'unix': 'UnixSocketAddress',
>> +    'vsock': 'VsockSocketAddress',
>> +    'fd': 'str',
>> +    'exec': 'MigrateExecCommand',
>> +    'rdma': 'InetSocketAddress' } }
>>
>> Even I agree that directly leveraging this is the best option, but then
>> wouldn't it introduce redundancy ? we would not be able to leverage socket
>> union right in that case or am I missing something.
> The first four are going to have to be packed back into a SocketAddress
> struct immediately, as the internal migration APIs all work in terms of
> a SocketAddress for the inet/unix/vsock/fd case.
Concur, that's what I mentioned in just earlier reply, Daniel.
> With regards,
> Daniel
Regards,
Het Gala

