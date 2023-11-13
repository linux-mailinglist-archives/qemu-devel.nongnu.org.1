Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 491BA7E9E54
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 15:14:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2XhD-0008KW-OL; Mon, 13 Nov 2023 09:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r2Xh9-0008J0-Q0; Mon, 13 Nov 2023 09:13:43 -0500
Received: from mail-bn7nam10on20630.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::630]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r2Xh3-0004rI-6j; Mon, 13 Nov 2023 09:13:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXAFUYDRKmgv1vmhK2/Xu5aYek5/ID4VVV1pI3gJsJekBJNP6MoF3Qah3sh+ZVn1Do0Go6OD1LxmP7j2My1fw5mrDe3ZpEKikbCq7AJ2rzM4l0GXbFTaBVYgUh21gkOW83zTlZSX5BZOEjgQeMcCrf1co2IfsjMiXil2b3APZEMALipJKMo6pmAx2zLWflbv/V0GuQ4o2olHyppv0aj3oWQ5HdUCTabV05X+vLOAASc8VpIhaccoenvC7hqIMMymRTbRKiruYo+3VQEq9uSixMGgbA1g3cEAnClaaF59S76IuLFHEFBCLkhpyH14XjkimkmMt+yKl2pedlRQy+c62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1a+P0lr9U6TlL6jzuefzjfKKvYWimGcHBZ0AFHoQ0OM=;
 b=eZ0eOlJfYzjB4Vusp+y0wUFDNN05+Sj58/vlAn/lMMAmriUM2QGzhkxYR4nR6bWKbz/7Oe0auS3YfhKKCzMTG8uZOmE0KajB5tmGsLQLasE/U6znrGkQJhbEo1EpMI/lcnzVJrsExUyToE1OPZ4XnebYj6FKbyFt6SniJJsomfoGo05piJqHDbDj2HX7PILgZoOsj+DN1zIfVSjgEALqXqa6OUnKqRKBbkSgkZknrDxAat5cTLtNFcRjgoOkIGEt6XaWi0+w8+hlOCel2y7AT8ljMBKtgl6BYcqn10NGYPSm2phmgT6gVvT3hz2ykHOLLMw53RXQKKR2eQ6h7GMjbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1a+P0lr9U6TlL6jzuefzjfKKvYWimGcHBZ0AFHoQ0OM=;
 b=iIy/OKtvA2Qb2A048sdocGkDHpS1/7xAmrnjQHsGqIPCeHVTvO0PDKYKBBUKRwbqGyVIEkrXztQIniXBt57ahHoLyI/iXq1wrCbyPtwLlQa6AlN3bRlWPrF1LJPJ6+FvdPVV8nnF3E5yJNPwSdWxpxrsT23nydtXCrtJzEAiuF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by PH7PR12MB8179.namprd12.prod.outlook.com (2603:10b6:510:2b8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 14:13:28 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::5f66:ae33:b947:c68b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::5f66:ae33:b947:c68b%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 14:13:28 +0000
Message-ID: <14f467ae-c9ed-4301-a034-6c64b0da12e3@amd.com>
Date: Mon, 13 Nov 2023 15:13:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw: Replace anti-social QOM type names (again)
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair@alistair23.me, edgar.iglesias@gmail.com,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20231113134344.1195478-1-armbru@redhat.com>
 <20231113134344.1195478-3-armbru@redhat.com>
From: Francisco Iglesias <francisco.iglesias@amd.com>
In-Reply-To: <20231113134344.1195478-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0060.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::9) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|PH7PR12MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: d47165a5-954b-496b-3ada-08dbe452b547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8Wju98q8z0X1K/WMTl8Ss3Xx+F9zpnqfIuyNn2zLFqKANoHV3WXUxKA6wXSy6VfIGEiw+1ZE8uvg913qXd5Q4Um2KYm3kby9q1RbPiXXjpcIYCF9GdqYe9QOpRvU5e79XT1zP2Sw3HuOrbG63HXaZwfWlnCsfLYT366yWrea+42KrOLNS0Zrtwh86LYdhtpk7ZMjCE2hzs/dGadUxarTa0MBCFod6lgiPfFXAu0cieH5tflO+kxk8anH1iwV2xiHDGJK9zU3folP5xh9i00iSw4JnFAZi3AuwNzFIbWZpsgbmNhT5pNAumP+lvigR/vljuPJiMS8zrBbWwg1sdpT7f02Ics2Wd+cPpGg4sarJO8hceqr4G7KxtxmDKA3FUatBbrcprhs1TDKF9et0J7mr4E8E+0J7zpJ19W0QlbmWIW/oKqaLZ4CYxtWQGhK1BpRIn2OuQaDlu/VicaKif6MSsV0OP/hu0paF0dQQJZFgOY+aFHoS5/zi2R2xqy68ohmGLefLnwhWGx3LLzguCvx7zckACRjqodrCIJwX+ZL/qtYVBGa5T7VaQnc4Pt3mj1gxCyQs0VBrFMUqPMiLDVPjPOn2WhS1czjk/PAhv05g+eT1KNAdcWnlpXquFcOCLDqRhFhKRwfxsCE4xLIb/l8FhC6wwY1KTcyS6EvcnUeq0nAoTOUtIEVrhYbxjkLAtC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(316002)(66946007)(66556008)(66476007)(478600001)(6486002)(6666004)(86362001)(5660300002)(31696002)(4001150100001)(41300700001)(36756003)(2906002)(4326008)(8676002)(8936002)(44832011)(2616005)(38100700002)(83380400001)(26005)(31686004)(53546011)(6506007)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEQrd1ZTL1FxTG84UHhvRWFGNTVnZUtxanp3ZDBtZ0pIRHE5eGUvbU9YcWVB?=
 =?utf-8?B?M2d1RWJsc3dJeHpISHhWNEJ0cmpXMEVIZ2c1UDk3bDBPZ2ViTGZoVlhzWUpJ?=
 =?utf-8?B?WmNicWdMQ3NmbHFQZVgzcDUxMkxyeE9lY2RmN3VIRFd1dlgybmVWN0JTQVhX?=
 =?utf-8?B?cC96a1c0a1dWYi9FTUxBMmtxbHJkZElxS3VDQlBHMzMrRTZZeGM4K0FWZGdX?=
 =?utf-8?B?eWVoWEN0YWZiaGlWM01sK1IzZFhPKzBqOS82UFZvNUx1dEJ5NThKZDlSZThH?=
 =?utf-8?B?aENHSzUyMEFLdXY2YURDeThqY1A1YlNMNUtmMm90aGd6UTNJMjAzM0VHR0p4?=
 =?utf-8?B?REhGMFNtQXJYWUc1Tm5XOEh3NGxwSXdDeDUvUFNxSCtNZDNaWXVFMkhKQ3dQ?=
 =?utf-8?B?NUhvcG1LdU5ESW9BR1NEdXY3a0puQ05QYVJoMXZtMEsxSXBHTzFWTERxRjIy?=
 =?utf-8?B?THU4enBIZHNzS3ZOcDhzblZaeENIT2p5V016cHRpdnU4N3dvdWpJTGNWYVBs?=
 =?utf-8?B?RVg2U1I4ejlYc0ZXTDdQR3FJU2lvdThaSUZZanFacHZHYWJSaXFqMWczKzVL?=
 =?utf-8?B?cnJkeVNpbnhCTG5IaEJQWHlLRE1ReEp5Ym9mTm45dmhsNEIrbzRGQTZwS3lL?=
 =?utf-8?B?SWxVZ0NHQkpqQ2NiWVBJNHM4ZWZYRXZsZVhuOXFnNlZScThuSTAwRE1ubDFN?=
 =?utf-8?B?SXI3K0k5blI3OXZTYUNzUkpuSmxJcEpVaTVXY0lyb3ZQbzVNdGZ5WUtrVkVH?=
 =?utf-8?B?OUNMRGh3bjc2NENYb0dpRTh5ay9nZnEwZlV2bmszdjgyR3RONUZjNzBQazMy?=
 =?utf-8?B?UlhPdWs5RjNETGIvNFZRQ2lMZ05vcDAwZ1duSlp1RFNpaEgrMzZlVHdTUkNR?=
 =?utf-8?B?aGpUK0xEVmMxbjlqUUZMS0o5dnk0OVJBaHpJTTVyNjVzNkpGN3Q5NGNnUGVw?=
 =?utf-8?B?WjlqMnU1ZTF4UStZUkxZSlYxRkR4elZCSkpUajE5OFRjbWNyUVk3ZTgwOEJU?=
 =?utf-8?B?QWFtOG1LenRPcmlyeHBWRUpIaklrUTNITlEyQkpUTWtyR3Q2bEZMb3ZjWVZo?=
 =?utf-8?B?OTdzUUM3MjRWd1pESlNpQVVFMng1aGlyOU81QlVCWUNURWovWW9pMEgxYllX?=
 =?utf-8?B?V0FwYkxyRTZUakh4U0ZsaEw1SHBOWW9GQ1Bhb2V5UVZ1K2xiK2IvT1Q5L1JL?=
 =?utf-8?B?cE10K1lRQjFhT2tDaVdNK01tcmVZMHBiTWxoRmlUbVliMnAyOW81blhoTHAz?=
 =?utf-8?B?ckY5Z2FtV0dsdlk1RW11UUliTlhJUHY2NlNyblRoTWllRytGQlYwQ0dXUjdj?=
 =?utf-8?B?SkhhV2tNcE0zcTVmOXozN24rTnR2ZklpRC91M1JxY202QnB0clVNQ3l4VGZZ?=
 =?utf-8?B?Tmc3K2s4SXFMaFJIWmdyRlY0QU5HemIzMENHa0JtcEFmNU1pbVdVTTluUEV1?=
 =?utf-8?B?VG5MUVpsRCtlSjl1cytMZVRkNFR3YVJZRUEzTU5JYWQzclJObGNpd0VVMTRS?=
 =?utf-8?B?d0VHUS9Gb2hOQW8wcHl2NFMwa2IrN3ZUUmY2VXZsUFR2M2Q4a2owT0loeDdS?=
 =?utf-8?B?d2JpaUpJMVRGL016TUs0WWFHVk1saGE2alh5N0k2WVFEMlB2OEY3TzlJV09O?=
 =?utf-8?B?MlBEcW90bEFiYXdYaDB4WGdLVWZ6VUtCSFZYeWRzc2VPcEVMK1Vrd0FmRXVw?=
 =?utf-8?B?RXg1RDR0TFR1bXpGa3NwN3hrT0xuclF6bDZPVGtZZnRUdFJYeWRpaWR2YkVW?=
 =?utf-8?B?RlR2SGZ5dU9PMmFnNWhEZFpKTGcxSFhkVnNxVVFqS2pjVm8xVEFsTndNamN2?=
 =?utf-8?B?eFRTQlUrQmFzVlRLYjREVWJCR05VWXFzZmdzdFdrc1UrOVk4ZVIrb1AwSk0r?=
 =?utf-8?B?MGQrSEpZTFA5UE51Ym1obGdadDZGdmNoVzNSQnV0bHdPa3FEZE4vTzFxdmlX?=
 =?utf-8?B?UkxMVXIvdW5TOVA5Z3B4OG8zZk13Z3NxTDhyMXMveitFeUpCUXlFbnBORUhn?=
 =?utf-8?B?bkoyVDZHSDY3dVVEcWo0cWRkSk8zYTc5ZW5xZW1xZk9qODBIN3pyY2srd2I2?=
 =?utf-8?B?WHp6bE1hMnUvbW1iRURPNktvcnVNN3gyVFh0ZG5uY0g2bEQySW51cG1ZdmMx?=
 =?utf-8?Q?qBROG6MXi04ToHV54wi0z9qfZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47165a5-954b-496b-3ada-08dbe452b547
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 14:13:28.5243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxX3QCc1VN7LNmtGRebxyyzbEA+LVvi792WrA4g902ayOpNzjckNCSSI8ML8eiJMx5NRCw40wSWe5dt9nkma7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8179
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::630;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 2023-11-13 14:43, Markus Armbruster wrote:
> QOM type names containing ',' result in awful UI.  We got rid of them
> in v6.0.0 (commit e178113ff64 hw: Replace anti-social QOM type names).
> A few have crept back since:
> 
>      xlnx,cframe-reg
>      xlnx,efuse
>      xlnx,pmc-efuse-cache
>      xlnx,versal-cfu-apb
>      xlnx,versal-cfu-fdro
>      xlnx,versal-cfu-sfr
>      xlnx,versal-crl
>      xlnx,versal-efuse
>      xlnx,zynqmp-efuse
> 
> These are all device types.  They can't be plugged with -device /
> device_add, except for "xlnx,efuse" (I'm not sure that one is
> intentional).
> 
> They *can* be used with -device / device_add to request help.
> Usability is poor, though: you have to double the comma, like this:
> 
>      $ qemu-system-aarch64 -device xlnx,,pmc-efuse-cache,help
> 
> They can also be used with -global, where you must *not* double the
> comma:
> 
>      $ qemu-system-aarch64 -global xlnx,efuse.drive-index=2
> 
> Trap for the unwary.
> 
> "xlnx,efuse", "xlnx,versal-efuse", "xlnx,pmc-efuse-cache",
> "xlnx-zynqmp-efuse" are from v6.2.0, "xlnx,versal-crl" is from v7.1.0,
> and the remainder are new.
> 
> Rename them all to "xlnx-FOO", like commit e178113ff64 did.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>   docs/system/arm/xlnx-versal-virt.rst     | 2 +-
>   include/hw/misc/xlnx-versal-cframe-reg.h | 2 +-
>   include/hw/misc/xlnx-versal-cfu.h        | 6 +++---
>   include/hw/misc/xlnx-versal-crl.h        | 2 +-
>   include/hw/nvram/xlnx-efuse.h            | 2 +-
>   include/hw/nvram/xlnx-versal-efuse.h     | 4 ++--
>   include/hw/nvram/xlnx-zynqmp-efuse.h     | 2 +-
>   7 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
> index a6a77b3799..edf2e48109 100644
> --- a/docs/system/arm/xlnx-versal-virt.rst
> +++ b/docs/system/arm/xlnx-versal-virt.rst
> @@ -212,7 +212,7 @@ To use a different index value, N, from default of 1, add:
>   
>   .. code-block:: bash
>   
> -  -global xlnx,efuse.drive-index=N
> +  -global xlnx-efuse.drive-index=N
>   
>   .. warning::
>     In actual physical Versal, BBRAM and eFUSE contain sensitive data.
> diff --git a/include/hw/misc/xlnx-versal-cframe-reg.h b/include/hw/misc/xlnx-versal-cframe-reg.h
> index a14fbd7fe4..f403b00e31 100644
> --- a/include/hw/misc/xlnx-versal-cframe-reg.h
> +++ b/include/hw/misc/xlnx-versal-cframe-reg.h
> @@ -23,7 +23,7 @@
>   #include "hw/misc/xlnx-versal-cfu.h"
>   #include "qemu/fifo32.h"
>   
> -#define TYPE_XLNX_VERSAL_CFRAME_REG "xlnx,cframe-reg"
> +#define TYPE_XLNX_VERSAL_CFRAME_REG "xlnx-cframe-reg"
>   OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFrameReg, XLNX_VERSAL_CFRAME_REG)
>   
>   #define TYPE_XLNX_VERSAL_CFRAME_BCAST_REG "xlnx.cframe-bcast-reg"
> diff --git a/include/hw/misc/xlnx-versal-cfu.h b/include/hw/misc/xlnx-versal-cfu.h
> index 86fb841053..8c581c0797 100644
> --- a/include/hw/misc/xlnx-versal-cfu.h
> +++ b/include/hw/misc/xlnx-versal-cfu.h
> @@ -22,13 +22,13 @@
>   #include "hw/misc/xlnx-cfi-if.h"
>   #include "qemu/fifo32.h"
>   
> -#define TYPE_XLNX_VERSAL_CFU_APB "xlnx,versal-cfu-apb"
> +#define TYPE_XLNX_VERSAL_CFU_APB "xlnx-versal-cfu-apb"
>   OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUAPB, XLNX_VERSAL_CFU_APB)
>   
> -#define TYPE_XLNX_VERSAL_CFU_FDRO "xlnx,versal-cfu-fdro"
> +#define TYPE_XLNX_VERSAL_CFU_FDRO "xlnx-versal-cfu-fdro"
>   OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUFDRO, XLNX_VERSAL_CFU_FDRO)
>   
> -#define TYPE_XLNX_VERSAL_CFU_SFR "xlnx,versal-cfu-sfr"
> +#define TYPE_XLNX_VERSAL_CFU_SFR "xlnx-versal-cfu-sfr"
>   OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUSFR, XLNX_VERSAL_CFU_SFR)
>   
>   REG32(CFU_ISR, 0x0)
> diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
> index 2857f4169a..dfb8dff197 100644
> --- a/include/hw/misc/xlnx-versal-crl.h
> +++ b/include/hw/misc/xlnx-versal-crl.h
> @@ -13,7 +13,7 @@
>   #include "hw/register.h"
>   #include "target/arm/cpu.h"
>   
> -#define TYPE_XLNX_VERSAL_CRL "xlnx,versal-crl"
> +#define TYPE_XLNX_VERSAL_CRL "xlnx-versal-crl"
>   OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCRL, XLNX_VERSAL_CRL)
>   
>   REG32(ERR_CTRL, 0x0)
> diff --git a/include/hw/nvram/xlnx-efuse.h b/include/hw/nvram/xlnx-efuse.h
> index 58414e468b..cff7924106 100644
> --- a/include/hw/nvram/xlnx-efuse.h
> +++ b/include/hw/nvram/xlnx-efuse.h
> @@ -30,7 +30,7 @@
>   #include "sysemu/block-backend.h"
>   #include "hw/qdev-core.h"
>   
> -#define TYPE_XLNX_EFUSE "xlnx,efuse"
> +#define TYPE_XLNX_EFUSE "xlnx-efuse"
>   OBJECT_DECLARE_SIMPLE_TYPE(XlnxEFuse, XLNX_EFUSE);
>   
>   struct XlnxEFuse {
> diff --git a/include/hw/nvram/xlnx-versal-efuse.h b/include/hw/nvram/xlnx-versal-efuse.h
> index a873dc5cb0..86e2261b9a 100644
> --- a/include/hw/nvram/xlnx-versal-efuse.h
> +++ b/include/hw/nvram/xlnx-versal-efuse.h
> @@ -29,8 +29,8 @@
>   
>   #define XLNX_VERSAL_EFUSE_CTRL_R_MAX ((0x100 / 4) + 1)
>   
> -#define TYPE_XLNX_VERSAL_EFUSE_CTRL  "xlnx,versal-efuse"
> -#define TYPE_XLNX_VERSAL_EFUSE_CACHE "xlnx,pmc-efuse-cache"
> +#define TYPE_XLNX_VERSAL_EFUSE_CTRL  "xlnx-versal-efuse"
> +#define TYPE_XLNX_VERSAL_EFUSE_CACHE "xlnx-pmc-efuse-cache"
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalEFuseCtrl, XLNX_VERSAL_EFUSE_CTRL);
>   OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalEFuseCache, XLNX_VERSAL_EFUSE_CACHE);
> diff --git a/include/hw/nvram/xlnx-zynqmp-efuse.h b/include/hw/nvram/xlnx-zynqmp-efuse.h
> index 6b051ec4f1..f5beacc2e6 100644
> --- a/include/hw/nvram/xlnx-zynqmp-efuse.h
> +++ b/include/hw/nvram/xlnx-zynqmp-efuse.h
> @@ -29,7 +29,7 @@
>   
>   #define XLNX_ZYNQMP_EFUSE_R_MAX ((0x10fc / 4) + 1)
>   
> -#define TYPE_XLNX_ZYNQMP_EFUSE "xlnx,zynqmp-efuse"
> +#define TYPE_XLNX_ZYNQMP_EFUSE "xlnx-zynqmp-efuse"
>   OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPEFuse, XLNX_ZYNQMP_EFUSE);
>   
>   struct XlnxZynqMPEFuse {

