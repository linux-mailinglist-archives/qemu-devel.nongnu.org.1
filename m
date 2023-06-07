Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4F3726D85
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 22:43:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6zz5-00031z-5i; Wed, 07 Jun 2023 16:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6zz2-00031p-QL
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 16:42:20 -0400
Received: from mail-dm6nam10on20617.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::617]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6zyp-0008QA-2n
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 16:42:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVDKKuvp+JPU+FHAhpNbcQV88ldfaafgpOyGb9qVYqtqLC6jiagwOwOzM3tYR+6cRq6zpveB4HrBV4wEKwH+dAmSelowSlEzKEIrrVCZtKzNCY3p2zXXBtuDKEyWEofAKe1tme75/6hXxBxsYUx0jEriYdjTxfExvATPNC6RbLgcrebcgCS3i9PhwPvLelTZD4NoxVyC0H537vEewmAtLKI0Qpal/zFxMGDobh5VGEov5QsjxOZB45TeAIHSADTon45rZRjk3GTJ4yNPA0MMHHVakdhkIBN7k+3yozHn+/U7T3oTkEkfWeba99LHaOMBI0flSoR6/iB1hoURUUmKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0qUxkd5i8X16G79w7yQCujOnz42fTmNRpijl0Muk/Q=;
 b=OmSQrIMS1noLkacPiN20hOZ2toIJ9xwSRmXA5rebJcFEcjf+208WeK/7G7YyCV7EHnYkL0GdHbZe/luBJ2d2m6Fcu11tz7D6+A6Bb+DGX6OwNEe0THwUThUfnpERqQv9z9f6xtksaah9Ilh7trmnKHHdD/Msbsz+0bNd24eRNE71se/NVWEw79Gci6DQtDkQVlT4FowKrr7U6BZxy5M1Tde4pKXpn8QI8aaNoq6w/Bzx73uzOqGrAV6uCUwPX8BK0gMG2v56GHM5oq1Yi21UNbfnJ/SLOvLU09N5OusnRWEMewXF4rVJs3ft+yype29lrGOE+Jmv2ABrU1OoBWVwKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0qUxkd5i8X16G79w7yQCujOnz42fTmNRpijl0Muk/Q=;
 b=2nletneCqBVOA20/haCwHN3VkYkqFy1y4Xj7UAN9wBWrKb59Bdj+ciRubLoS8uCD0wFrVRLOn0M3rVcIEDzVqiIA4kiw8pOul4eg/JW163JYAa95gOvqbo74xdfR6PCTPNDuiLTWpIzTZeehlcJDnulV80HzObQ7Dl2+SplRZWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 SJ2PR12MB8061.namprd12.prod.outlook.com (2603:10b6:a03:4cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 20:42:00 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 20:42:00 +0000
Message-ID: <3db80bc1-d64a-a1ad-e404-4d629061fa28@amd.com>
Date: Wed, 7 Jun 2023 13:41:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 2/3] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 berrange@redhat.com, jusual@redhat.com, dfaggioli@suse.com,
 joao.m.martins@oracle.com, jon.grimm@amd.com, santosh.Shukla@amd.com
References: <20230607024939.703991-1-suravee.suthikulpanit@amd.com>
 <20230607024939.703991-3-suravee.suthikulpanit@amd.com>
 <20230607154913.2a1cb2f8@imammedo.users.ipa.redhat.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20230607154913.2a1cb2f8@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:217::15) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|SJ2PR12MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: c2cc32e5-c9f4-47e2-eae8-08db6797a49a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5EfE3USaiq0oYV0Er5uHGbO/u3Ogdi4pFzblmslgU7h5lxpJCWrCcm8VHsSTCUU15kUD7onGlE7R7soDT6X0dAoDG+Acqh1WQyPgGE+yHtoQfYzzbxHRZlpOzD4kYA74hN+P8sGtuDtkuyS0sgqNohuv8ZYV7sT67JXnvaDHv/V+cJ/gYE1zJaeYCsNy1H+QrkW2VNiJ8IXM//C/fEaklLXnkOTVyA8BIEUuWtiTR9zM99WIJQSS9C4vV6eb91htB4CT3n9dXM+1IcBAbZ0PufNryPVkKLwmSojNxlnu8Vxa1SUAOvEFXpXSs5zMxojNqTHPMLnQOFqgIPxBr9PF2F1cD6qMB04wjaBRHQEfwr2D8IeoB9s1jbH5Ycdtbm853PPPwD/JpQDh+sbUyMu0XoWGFy3RgrvQV7zXow08bG6hzQ0K34n+vgwRk2/inCD7oNJ7WM2Y10cQx7QU7U/CDpDgF4tvhedsEpvF8nVPi6myvHOWoGy8VFkD357I5M6Js0JFV09dV+4oQB7xY5w5AVojZrhqu378KATnA8D8daoNlPelaKfgTZN4Ench0iN+WIcZTYXCecOrcaD+nrMUFkFsx63KWGFLH9TfRio9kzi3plg1s3/v4OJ1lj3ChgCIyOdXltBpwpJU3PeeoAzjRAKHxG53roiVydjK0bLP61yVn6vUeERONHpRoGp/5l1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(186003)(53546011)(2616005)(86362001)(316002)(6486002)(38100700002)(36756003)(31686004)(7416002)(26005)(6506007)(6512007)(31696002)(2906002)(5660300002)(41300700001)(6916009)(4326008)(66556008)(66476007)(66946007)(6666004)(478600001)(8676002)(8936002)(170073001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGQ1Qm82WENmT1NTNWY2bXlaU0ZNSHF4OGtOS1BUWUZsZ3BDUU83UFNINmRz?=
 =?utf-8?B?NEFuSlhOdksyMG10ZUh2NWJ1OE1lTThueVFSalJQQmlhd2dDcnBSS1JEZEZF?=
 =?utf-8?B?RmNLaXN6Zi9oZnFnTHBLNG90dG0xT3pKa1hxaHBhWTZJLzVNc3ljak1LZWVl?=
 =?utf-8?B?S0tLNDBzdnI2NTVQTG5kYTRFaUVaS1JGOGRQaGw2eW11djBEVXZRc0dHZTdI?=
 =?utf-8?B?M2YwZDFGUGlzakFOQzRQdlZlS3RpTXlLeE1wLzFOMllPaWh3dVZpOGg4L2dQ?=
 =?utf-8?B?Wkh2MSt4OFlQR0pYMmtFaWZkSnVyVkE0NnNzbmpvTHBaMFpkekZVQmd6ZEFY?=
 =?utf-8?B?ZWM3QkJSMkt5aDNjSk5ERVlwblpQSU9VbXMrVkhmQTJYOWFpQ0pkNTJKZDgw?=
 =?utf-8?B?MzQ1TTlOYTFkemg5aHJiekIzQlhPdVlYbWtCZndnNjFKUkxyTmYyaVpPUmJq?=
 =?utf-8?B?RHBaR21IQkVPRndGWGhhNlR4WndOMTc3MGcxdW05NU1PaHQ0aE1rOFNyc3RU?=
 =?utf-8?B?eUduSWZHRGQzcVlyenBydzg5NkxTM3E3Tm93TDhsRXRxeXRYNHI3aFMwcnA0?=
 =?utf-8?B?STRNclJTWng5SGFuaWtxNW9OUTVyMURFWFQ4QWdHSnNhdDI2Z05jRmpsNVI3?=
 =?utf-8?B?VGU4d013N09BNTZzdXRCc2xRRW1pSlhtVjRBbXdtcTNKVGxOQkc2b2J0Mnhy?=
 =?utf-8?B?dlYraEEwUlV5a2NhcC9pQ2oxTzRFRXZmRWxPcUQwTE16Qm8wVTllNzNLblJJ?=
 =?utf-8?B?Rk1OeExCWEhURDZtNVI1V2c0eVhnTDduMDNTdXdNbWRPZVJKS0hlQnE3dlRU?=
 =?utf-8?B?VFF5d3FQenQyRmJYcjJlRjBJNzdacDczdWZacHFoT3BoVEZWYiszemhtSDBZ?=
 =?utf-8?B?TDNSYzZEYVQyNks1STRnWTVQamlOMkJGRnBzK1RnWE0rN0NuTHdoenBlWVVt?=
 =?utf-8?B?S09WMlF2VUdmdXp0aUYycExxQzFpaGtxWlk5Uk9ta01GbUN0ZFZSbTJyN0pD?=
 =?utf-8?B?R1h3MlBpSUhCajIxemJKakRjdTNIdC8zMkxPVHhoMkZ0UitQamNBRlQrS05j?=
 =?utf-8?B?ZGkyYVZzQ2Uyb0tuWHY0RTg1a3RvRDhja3NycWZUTEVySk5idDlMS0R1Sldk?=
 =?utf-8?B?RCtZVlhZY1NIa3BPK0NPUkovU2JaNDhKeFFEU2hMMTFHK0ZnbG9kNm4ySmJO?=
 =?utf-8?B?RVlJbEJ5QTJhK21JK1czZ1BCell2ZVFPTE4rNXoxbEpRRUNvd2R1Z1B6RCtD?=
 =?utf-8?B?YkZ6UER4UTdCMWZBR0FoNytZcEJqQVRoaVZhQzFpbHlXNS80UkJNdGlDSzQ3?=
 =?utf-8?B?dHkrNU5CL3FTMjdnRWxndU1BUFdqWjIrb2xLeVFYL1dRWWR2aEpoYXRqUEY2?=
 =?utf-8?B?Y3lHQW1qa3RvVkRXeXNMT1hlYWRYMEh3NUE3S09qSXpUeGNncGxLcmoyWjgr?=
 =?utf-8?B?S2tpMWlxL01DdEZDRnBoN2c2M0xyYUNMVEVQR1l2aWVjQitNZTRrQ1hWS0tr?=
 =?utf-8?B?THNud0JYRW9ubVhaSE4xUHBrZUk1a08xS2owSUkzc202VjNPeHljR2NnYXhW?=
 =?utf-8?B?eWlkT3RRRUUwUHgzTDNNNzFkVXRvVWdjV0l4UDZFamt3SEVqYW9sRmcyb2RJ?=
 =?utf-8?B?UExNQ2xVRDdPL2lyQW9WRXdGRmRuZkZNTTJaWjBVODNnellkbmFuQzd6ZWxi?=
 =?utf-8?B?c0VKajZ3K0VvVThZWXhNbGczYUJPZ0FzWUpXMnBtVGNodURMRVlVOFByRFA1?=
 =?utf-8?B?blZMMWM1YVVEdmExQ2kzbElGRVIvNkxpQVdoaVBJVlRPRWNVMUJqdFRUSk9G?=
 =?utf-8?B?SDZMVDd2Qy9WWG1UZEpsZXRFT2htUE1PZlBkYitQU3lCQkFkYko4emtFMGM3?=
 =?utf-8?B?bWhoajlaRkk4NFBjN1pwczJNcGJKN2lrOUUrYmhoTTNOYm9YdG1raWtKeGlR?=
 =?utf-8?B?ejlScXM4OWw5QzlGbXY0YlNFQmNZbUc1dFFWMXNOWnBiMnVtVXJXZTkvUS9w?=
 =?utf-8?B?SlYzajh6bFIrMTBPa2MvUGc2OEpPVDFyOEZJWXZFSE50d0V1QmxpNkJCRVB4?=
 =?utf-8?B?elFiekpudURVTWExUThERzRCUFpQM3JMTURaeklKL0pEYjJsSW9qVkhtMXRv?=
 =?utf-8?Q?0ybZo2iHhd+yr1SwqoZXdBg7H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cc32e5-c9f4-47e2-eae8-08db6797a49a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 20:42:00.4340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYXU9D+iHGcGf0bU/6gg2fkE0ipht31YH0TMYYlvgjPAAEGOZflmmxspHas5tyQno1xNf5edTPrmGYPFYafysg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8061
Received-SPF: softfail client-ip=2a01:111:f400:7e88::617;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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



On 6/7/2023 8:49 PM, Igor Mammedov wrote:
> On Tue, 6 Jun 2023 21:49:38 -0500
> Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>  wrote:
>
> ....
>
> and use this with the rest of your patch
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index b3d826a83a..c5bab28e9c 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1859,7 +1859,7 @@ static void pc_machine_initfn(Object *obj)
>       pcms->vmport = ON_OFF_AUTO_OFF;
>   #endif /* CONFIG_VMPORT */
>       pcms->max_ram_below_4g = 0; /* use default */
> -    pcms->smbios_entry_point_type = SMBIOS_ENTRY_POINT_TYPE_32;
> +    pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;

Ah, I missed this part. Thanks for suggestions. I'll send out v6.

Suravee

>       /* acpi build is enabled by default if machine supports it */
>       pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
> @@ -1979,6 +1979,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>       mc->nvdimm_supported = true;
>       mc->smp_props.dies_supported = true;
>       mc->default_ram_id = "pc.ram";
> +    mc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
>   
>       object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
>           pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g,
> 
> 

