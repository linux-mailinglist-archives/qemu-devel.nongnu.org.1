Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF3D7251C5
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 03:48:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6iGI-0006Tc-44; Tue, 06 Jun 2023 21:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6iGG-0006TS-Dt
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 21:46:56 -0400
Received: from mail-bn7nam10on20608.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::608]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6iGD-0007KU-Sr
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 21:46:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LePP46/5drD3nDGslLiHHZZJ0dAKLVt5pKifHwrNJzKJOu52oCcXbgmODh5Dvhi9XdgcSWhZUuacGBgSP+C2aQ4VK3lbUsZzx4yCJ+cdPC+6DfRSGVRsXKIVuffcZNgKiACtyoUMrlqLeVoAwvLSIiyIVjPhRkdZgTA4mvgZl8rnDhs+WA44T8otioobGTWTZSqGfuDr3RLCjEs7l7y/Fo4kiWrMRm2iP+NbOL+2VUk+77hSdgIF1ulXsACyPLPA9ShErfX5mD09rVWM3GH0sXOhBpRHXowax8OQ0QlEsjawDQT28GsiEO7mqzyAJge7kkcgZl23G3WEnTFdArH5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSpOBPS65ePQvgBHizfpVjwR+2HWsd+wZT54sEB4gxM=;
 b=BmDcfyUcmRiZdNtlTiquXLhUSSaRT+evQZgolreguOHhfc5MWv3NvprnxVsQSfpSU0jz1l/GDED0HbZBNvtN7kKq++Q+FDzsGMFLIwcG1VBX7oZMasGy2w7/MrDhspwqA11Lo9xp/Wb88e9PJKF/9ZL/YkoJy9RcC0VXrAdGBbkeCPgDwcDedaTLpUPkFF8m5gP3g+x2FVhjhQiAJJwRjRrg9lK1ACO9l39CcPaj/c8x7JZe9WLtAh4xClAyV84Nrp8Y+1ngleqZ/gu9NStgDDeOsyTcFoSfEq/BWlKK9p6gTNZ0LOOIRxQeCg1bYl5cSGLj8A0YafWjPSdvw6MJFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSpOBPS65ePQvgBHizfpVjwR+2HWsd+wZT54sEB4gxM=;
 b=p512PJtpYvbw47EYRw8bLPPvhoiQwx/0t5Z+uy3dOzuHwtIcvTXMQ36qfRV5zAXWPtI5hP+XkKVAsAFAHnCD0Ii9hK5e418wHp5vVp52xxww1lcT4tRaoQ+Igv+i+JNGXdZ5Dh2HbjW+5HNLgcGDM0jJCFn3LwjAVaYhwVuLbQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 01:46:50 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 01:46:50 +0000
Message-ID: <d30179ed-2b94-f922-6e9d-2d9f567da18c@amd.com>
Date: Tue, 6 Jun 2023 18:46:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/3] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 berrange@redhat.com, jusual@redhat.com, dfaggioli@suse.com,
 joao.m.martins@oracle.com, jon.grimm@amd.com, santosh.Shukla@amd.com
References: <20230605213906.644883-1-suravee.suthikulpanit@amd.com>
 <20230605213906.644883-3-suravee.suthikulpanit@amd.com>
 <20230606093541.5a2e6b87@imammedo.users.ipa.redhat.com>
 <20230606101124.7d252fae@imammedo.users.ipa.redhat.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20230606101124.7d252fae@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::25) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 80cb3858-9cfd-4268-6f06-08db66f90f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DxLfwXPksFeT4ZpJZ9OQz/XiBUhGWqYYsHMNdRCsTipyPCOfapuB3DwZKYPkqRYv6FzRCODN8kJpe4AaROjSJ1ewWty2aNekRBTk5YMiYAQT3hNuD51fU/6m3VlhSLSCedhxOdeQzkj2Rt5i8lDHeNQWU9yw0Em0qO2qNcMhtqGRXcXtmQmlkLc/idvC/CykJskJnYSW8iEXAEuJlWjE56N8Fdx2xeJc2SJ5EJF4CuV92sVjYB97qBjBd074SbTy93n89nHg7F2a1N24U22TA8X5LW88BLf2Qzen1EchehoAyyiD5wG+VB6GeG6NJOICt3wivfIcfJoK3KUIldm54y5kojfkL66Wbrt26JcNMoTOgQDnGWfENy3k2mjY3Y6rauEDVpBus54DUzTvxFNhL/d+yInwBhK4BSpqnXmyTJ1sGCTzGa+V7Z3GdvCF7QeLH0Ged99tt5FswNr6gCguu51ZkerU/zhxyFeXpm0rVA9nRFaSfE3mVJvQmMPYpdHpEVnAS7KPNl4fGNoT/hwwEky6oJuYKsYm4gn5z+dRPP69HdAzDP0uPn+sU4SB+yWO/0JN38JiLU3pKkROYqCsgfTHf5VdGEGg+XD4Dievd2nu/6+IXj3RPihpu/RT/dzmtXbkrRsXTSZ+s42yeFkGoHKfaRa0ZoQxC6WEqLi76JzN63HoRIvDA1aNoCOb5csh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199021)(478600001)(8936002)(8676002)(7416002)(5660300002)(36756003)(86362001)(2906002)(31696002)(66946007)(6916009)(66556008)(66476007)(316002)(4326008)(38100700002)(31686004)(41300700001)(2616005)(53546011)(6506007)(6512007)(26005)(186003)(6666004)(6486002)(170073001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MysxYXh4N1NKZkZaamJoRytPTTE4RDY3Z0xoVU1oQVJuNGZKUS9VZVFNNXFZ?=
 =?utf-8?B?L1VzbFRwRmVPSXFLNHo0N2llMVVqVlJwZ1A0UTRleUdFNUhvMXdYUGM3UExr?=
 =?utf-8?B?SkMwQW9KRHpEdjAwbDM3N3NRVU1ma1NvOUt1MEh2OGh2VnZubVRNNUErL3hJ?=
 =?utf-8?B?Qjg0YkpyZVdZZFFNS0R3WlVHUlBsZmM0Z25tSnA2VEhvVXliTUpBWWUzWGVa?=
 =?utf-8?B?bktuZisxbWFPSmlDb1JHSzYxcWlSeEpMWUt3NHI2NHRHYmhzaFQrbFM0RUtr?=
 =?utf-8?B?ajQyQUQ2ODl5a2pVcGgxYWZQc3VGSWhKd1lqYXdpOVlCYlhlVWNucGxmbWtq?=
 =?utf-8?B?Z3pmVGc3VHNtaitLV29xYUpvSjFhaUc4bXBMM1FoUVVLN1dpR3NhZDdDK2gz?=
 =?utf-8?B?MWwra29QeklNUlNscHFpbndCNlFYUlpaeFU4TGZyL1JZajhlUlQxZUdnZEtw?=
 =?utf-8?B?VUt1N3hxZEJzaDhpcUtEQ0REZXdIUElmVkFudTZpVTFqSko3YUxzc2U4K204?=
 =?utf-8?B?K0YvN2NyaGlRcmEweVhUaTl0WHRuOVRHejhTUGx2QkYwQTN3eE5oZnMyeWdh?=
 =?utf-8?B?MlcrMStZK1NZeTRKQjhKUjkwZHYvZGpEVmY3eFkzcVVZY1o5SEYyN3FRWVQ1?=
 =?utf-8?B?Q2M0UHVHQ1pkZGh2ZjFVMWRjY3RIQndrYjFMSXJJUEgwZUpqWmhuR1k0c1ho?=
 =?utf-8?B?Q3N1aWZlOXBWQ0hRODd4NEViUGxhQnR3TWFMd1NhejJUMXNvSW01YmNLN3ND?=
 =?utf-8?B?bklhRDdjNWV6dDk1STVHc3FRSmZITmsxT2hvYmdZM2Q5WmxQRXdpbUZ6Wmtw?=
 =?utf-8?B?ZDdxNXc5Mk9nQ3poVnFpTDZpTEpXVXllSitxMlBBNkg4cW5MbXBBbGE5cjBB?=
 =?utf-8?B?d1hLQnpVZU1LenRUS2h3MjB3Rmc1Wnh3dVlzVy82aWg4QmcyeUJudkhSSkY4?=
 =?utf-8?B?TkFvZjU4bXQzYk84Vm1xbUtKWWtNa043ZkRaS29BVEVQcGFXbUV0SittaVBu?=
 =?utf-8?B?eHBSMjd5ajlkeFdMeklaS1pkcy9NUWVLZ3BYbE82WW83NUIxUjdncFhjVEZo?=
 =?utf-8?B?Z3dPWk1tT3gwOWR3YUdLT0l0bjZQczBKUEQ3OFdwbnB4K2pCUitZSEE0MktY?=
 =?utf-8?B?ekt1VFRacUJoV3lEN2JYSXo0OXRMZzM4cFF6OGZycEJyNVlBQ2pqcmFNMzhG?=
 =?utf-8?B?ZzlSUE1POTcralBJOFZZZkI3NCtKcU5VcFNOWWlJR2kzWkxwakhHNGhURTd6?=
 =?utf-8?B?dnM1UHJ0cDdXaEdmMUNnckE0TmFmdld6ZFViSXpxY1YxYlhLWHpRSy9IeEpP?=
 =?utf-8?B?Y2J5SXRpaU05cFpQV0Q2Q1Y0cFhkaDF3YnhDYkdZZEFlS2V1ZnJHbWVQY3RY?=
 =?utf-8?B?YVNnMnRMUThEK1U4QkVLUjlsUjdNaUNUb0dqb3JmVHUxL1ltQ0YrWmROR0Jr?=
 =?utf-8?B?TkRTUk11UkhQWmE5L3JiNHNlMHluNWl6dmpwTGFoS2ZVYTEycnFaSVNKLzB6?=
 =?utf-8?B?Q1VMbzgxVDcvR0FWK2lQZ0NiSE1MMmpZeHE4WEgzanN5RW1lUXBXajFxUmVR?=
 =?utf-8?B?c0l2TzNnUWwwZTJXK3diUHcrMmxVT3UxOTVyWTRCV1VEWUdjYnpnNnZUcjht?=
 =?utf-8?B?VnNZRHN5SmRLSm14a1ZJeG9hMjV0SFBMaGw1SkR0KzAwRlB4WmVhaDUwSUlj?=
 =?utf-8?B?azZoekIrWlhvKzJiOC9QbnJIa05DRzVBTUJOWFRERmh2ZW15NUFKb3NpMzBV?=
 =?utf-8?B?N05kWVFsNENhcVNmSmo3d25OenRZRTFxOVdSYk9aSG9yc3I3SVdpV2FSOTM1?=
 =?utf-8?B?TTE4Vkc4UFp3R3oxYmdQb0F2U0pSaHFESWhta2NMcXp0YUJxdkZFdys2OWNS?=
 =?utf-8?B?M3FBd1JZTFUxOHZGdE9Kd0RkQk81T1JMZzlreVAzT0FyU0prb0kydXBvLzEw?=
 =?utf-8?B?bjl4WFRCdFp5cEJ4bktFK0Y1ejQ4UjRuZU0ybjV3NTQxTHlIRkd6b1RBSEhh?=
 =?utf-8?B?T3NiRTRIZ2RQZW5xRmJCYk1DcVYvNWxIL0FZZnBxRVB5U25vcDRoUW15VlBI?=
 =?utf-8?B?M1cwL2pJb29GaW92aFdpanFRYTJYd0ZPbmw4QjI1VkVrTXFObitsZG5KZXh6?=
 =?utf-8?Q?q/mdcegOjmxQRw96jDiQafYlF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cb3858-9cfd-4268-6f06-08db66f90f9f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 01:46:49.9478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkQVuwB9MVGENgnoKUDCd/IIlt9fnwl3Zceoqu1ve1eqW24/AjluVb2SKHbEPP/7ZYO5BvCUtwhWm5wjw66IPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::608;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Igor,

On 6/6/2023 3:11 PM, Igor Mammedov wrote:
> On Tue, 6 Jun 2023 09:35:41 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
>> On Mon, 5 Jun 2023 16:39:05 -0500
>> Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
> [...]
>>> +    /* For pc-i44fx-8.0 and older, use SMBIOS 2.8 by default */
>>> +    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
>>>   }
> [...]
>>>   static void pc_q35_8_0_machine_options(MachineClass *m)
>>>   {
> [...]
>>> +    /* For pc-q35-8.0 and older, use SMBIOS 2.8 by default */
>>> +    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
>>>   }
> [...]
> 
> what Michael referred to as duplication is probably these lines,
> however "smbios-entry-point-type: is machine property so we can't
> use device compat machinery here (pc_compat_8_0).
> What we can do is override "default_machine_opts" value, but then
> again it has to be opencoded in  piix4/q35_machine_options, so
> don't see a point in doing so.
> As you wrote here is what typically do for machine compat knobs,
> so it should be fine.

Ok

> I just doubt that we need extra default_smbios_ep_type field.

I introduce pcmc->default_smbios_ep_type because I could not get to 
pcms->smbios_entry_point_type from these functions. Any suggestions?

Anyhow, I'll send out v5 with some more clean up.

Thanks,
Suravee

