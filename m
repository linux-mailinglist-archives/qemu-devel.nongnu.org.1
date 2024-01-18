Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A25858315AD
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 10:25:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQOd9-00065S-7T; Thu, 18 Jan 2024 04:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQOd6-00065C-E8
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 04:24:08 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQOd3-0002oG-Qn
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 04:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705569846; x=1737105846;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VWIsTQQriHAP24zgTfun9IRWa638E90wTOZN8MW/UZ0=;
 b=lKW8werLOiX3ZSFoIO5IQtdealmFsEPAO7wNoDnOnGJ6mDjyianfOYow
 XzQGQmzo0Tsi+WZ+siW4ae/2NX9wR2Pexlds+kiXIaKc+U295wGFSP7Aa
 VdXsaVTS9FpOcD3gGAVu1Lwq3Bxh6s1abcJa2dytE6b5u7FAk44u9Hgtp
 6tf5hx4ZvtZe2sJsDB8zni2o3h3VTEM5zIOPQ7Y/VPqgR77l5NjPVHMYK
 sx4MS7CspncFTWfY2K0evAQFLgi2vJX2CRlOeiuWYQM6a3wES/KGsDdsg
 JCw6yIjNcP34OXNOz48GSWWQA47LS3DTzuaAAJvodHqYcP3urkaD+H/Pv g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7108542"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="7108542"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 01:23:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="777687120"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; d="scan'208";a="777687120"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jan 2024 01:23:57 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 01:23:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 01:23:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 01:23:55 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 01:23:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0tEStp70BlDRIY7gsEHziDZZp5njYs5J1N+6kzwuOfNB5MaDsB5JQV7DwDmDEUAXvPMOElCeOXlHZpzCe4Slt4nYgj4E5iE+Kmy8+dLOGv2D9d4lPpj/rK1P09JfHlj4ZeBTqBrjlaDsglyr9sCXRHdjyXpqEd/ev/1/eUIIY3eA607VGiX4nxX1oF8SPKQ3KQQZnTM/WkcV7k20LiQcC0u2xJCdmyP2x4sMUwxou+qa1Jx2Xxu2LN87qpHixcIuv26KPFz/V/ldZQYjWNCITK38ADyxp/rQNi8cxTH5VmZ59PJ31l2dFN18Q6rhr2WO1LWUmogAEemd8wtfsCcIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWIsTQQriHAP24zgTfun9IRWa638E90wTOZN8MW/UZ0=;
 b=TF+URfFSpkTC6h1hzM0ePiuryzsG09CMGqDYBJrJBlYXsg80tzeP0nYrT69vYKMVzrvKGvr5b3Yr/TGhs27bW+1trpCeoO/oVf52twt5N+bmDZHrE5OtfP2vkFEPSLAO6jhTNg58tMzKPC1PJtOJcI9mzR7LJHq77/cqSFI2YKgkRsFkXZL1yO3UL8ApQiJ4GhOYwhNBySCbKHlZv79TxNXYeRWWfkzdn9I2TTvst5psH2pqHoYhtq/K03T0ap2ftTsI+ZVkoAUfc9mTIf6QS+vAiYknKBdtilyih/xGMpNuFDtE57chKKYS5I4eAnpYhRYMxH97UmuYqV57iMgQaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5938.namprd11.prod.outlook.com (2603:10b6:a03:42d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 09:23:48 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%5]) with mapi id 15.20.7181.020; Thu, 18 Jan 2024
 09:23:48 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
 vIOMMU
Thread-Topic: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
 vIOMMU
Thread-Index: AQHaR5v0AZ3rmcpUu0e+6RYUwmKBmbDeRosAgAD/J0A=
Date: Thu, 18 Jan 2024 09:23:48 +0000
Message-ID: <SJ0PR11MB6744FE42CB001523C7482D1F92712@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-5-zhenzhong.duan@intel.com>
 <d6585044-d743-47eb-ba66-7dc24673df30@redhat.com>
In-Reply-To: <d6585044-d743-47eb-ba66-7dc24673df30@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5938:EE_
x-ms-office365-filtering-correlation-id: 696e383a-2c30-43a5-2a7a-08dc18072d59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJk8NXC0IjYkPZD2lynk0sTptwl7q/Le02lc942B6/5HnQ8VinVeyLYvXqa1YqTybZN96rZhCobQKrJy+NBcIY1HRTy+EtHyJ8A5fVa2OyE6yQpO0iTYN/1qyQRII7Mh9LaJHxxc1lQF3ehgpa1RUmdVRmonbOJkJ0AeROoLgPuh0Pd4lhBz1B0mQ1n6lcweUo/g+5/hjeVjp3yuvVKMm2d8I/6QVG8dBamNYUWtWsymhoK7qs1E/GaxGaiNJerrE5QP437Mzm1hgp3/31JfrX+wZLI2gauG7UJR0pnMzkVZpMwcYN0GlcFubGPh7w87+K3AzEe1mVYYQyVaMxcFkTtGYdI35V5RPX0ki8/CIuiNlSv2r8qHEGvxnHmLJoKST7cty9celAN9Ru5CT+Us7FLrMpsNAEBRWkjPgxzKTgVOs2LM2YLomTd9tW3B7gLthwpyBtKLf653lU5vb65EUH1IIfFUd77ME73q8vgnCI8fNU/XREVRvnGd0T6TZXQ6BF8XNWL6C3N8FBsnbjOYvcAoap40RwUE5hQt9IbpSJspSco7qT6u/063th9dJsQw98pOC3UoSYQj+uMtnzoibc9zScinm1WZ4MEqjDFTZuSVELJDbXimGTapr1X0GKl7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66946007)(66476007)(66556008)(66446008)(82960400001)(122000001)(54906003)(8676002)(4326008)(8936002)(64756008)(76116006)(110136005)(478600001)(38100700002)(9686003)(26005)(55016003)(316002)(52536014)(86362001)(6506007)(71200400001)(7696005)(83380400001)(2906002)(5660300002)(7416002)(33656002)(38070700009)(41300700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkVuOWQrVHpVdk5SOHV4aXR4WHdvSFRRNzZHRDhudlRXR2tjNUNjMTI0a0hy?=
 =?utf-8?B?L0JFcXhhT05qY1o4NkRsOXk2N0I4aURsZS9QMnNMMWhvcXdFSjMrUVZMMFBZ?=
 =?utf-8?B?V3VVRVkrZ1Y1YytubS85UUVSQVNwcTgrZ2MwSEJFZ1pUMXp1SDdSZDZlOXdM?=
 =?utf-8?B?YUJqNVZTVWhMbk94UE9qUU9NN3ljRmhoZ0p6aEpLYkNId091WDBwajVNK29D?=
 =?utf-8?B?NVNSbmI1S1VuUnZTbGsxUG54V1krMEdieVJERFVNbGNMcWZnYlJXcFQzL29F?=
 =?utf-8?B?ZER0TER2NzdwMGUvL0llUUxzRU1yVEc5VzZBWTJqTlc2ZWNUengzOE1mb2Ev?=
 =?utf-8?B?c2xPa0VaaDIxK0NObGs2ODRNR2hZVzJqT050ZmdqSnlDeTdtc0NyRXdWRHB0?=
 =?utf-8?B?UllmemkxV09ZdWxVNzhRZW4xejNJdUNSTDdiZnZiNXZOT0ZSajJEZU9LeUFK?=
 =?utf-8?B?OXNGNytGWkxXYUJXUm5XSkZ1ZHErdis1V1ZlN2VHOTlhUGt0cjhpdE0wVUtm?=
 =?utf-8?B?VHhBTklUb00vSktxbGNwMVk0bjNDQ3RFTWFJR1Q4SG1ETWxDMEs2RkpNQ2xD?=
 =?utf-8?B?YmY3a2F6ZFlRa01xYVZ0NkRvc1VhWWdlYXAyOE41Nzl2c0FwWkNXV2hFcXhS?=
 =?utf-8?B?dE9DZWd4T051RFZEUkFTdFJIdHMrQ2Q2NWFoeG1zc2NITC9mNTlBMytWSDlY?=
 =?utf-8?B?UXNjYjFpMEExR3hCWEQ4OHUxaEJtOHk5SlpPam9zZFpPaDBYQ0MrN1p3TG92?=
 =?utf-8?B?SjhwSDg4aWEzY0FjL2xCZitBWkYyYTFQbEMvUmhPblVYK1BXZU41MndITU8z?=
 =?utf-8?B?ZVZya0EvZkgwZWc5SThBVGlUTzZMK0dKd0lCT2lUZ3NXeHoyTTd3QnF4U1dP?=
 =?utf-8?B?NE9wRHQwd1draVdrVFRkWkU1Vk90L2pZKzlNZ0dUNkVyd2lndE9rdHVHbkU5?=
 =?utf-8?B?eDlCWW5PMHdkR2ovZ2g1Z2xTcDd1cldiZ1FIeU9EbkJWTnFRRGFzQ3ZJNjhT?=
 =?utf-8?B?NFRVWlVKaUthQzlCc2prVU5IWmtqdFhTbDI0UDdqK2c5Z2gwVjlJMjFsVmJn?=
 =?utf-8?B?THV5Nm5kQkJvalpmU2ZNWmRDSnhxWVN3L0lBRUVaaUhKaFZVRXpIRzExWEJy?=
 =?utf-8?B?TWNNN0JNT1FWOFcrOWZldlJDU04zRWtQRUM4LzRDT2FmWkFXMGVxTzE4a1RY?=
 =?utf-8?B?VURaMmpObEcxSHJUZXVQMzk3bjRVTnMxWnp0bFZoMXlhZmtmZHV1a2tLaElZ?=
 =?utf-8?B?VU5sVVpubE52SGNBZ1djL3hIK21ZWjA4WStONXBuUlcxR3hJcVNMMmhUR3N0?=
 =?utf-8?B?bnNMZUhHOHVuMkdlaWdYTFc3dXFNUG4xRmpNTUZleXNEUG1RbXpNUzNuck5T?=
 =?utf-8?B?QS8vWGxEbnZaNTNrZjByc3NSNjBNdzMrK0JSRDAwREFQRjJHVFJkMGlhTDBz?=
 =?utf-8?B?R1J0ejlsUXhaMFZBcVQ4Q09Id0pKSDJNUFQyZnEzQ2VDeXNaZmg5d201Z3pD?=
 =?utf-8?B?NjgzaXkyTitHRjNLZUY3alRKY2hPbkhsRUhUdjQ4UmFxdU5HSlFuQzE3TXM1?=
 =?utf-8?B?MTdJZjQ1WVcwMklXM2YrYmljN2laWk04VWJEMWordDZpeFpFTHQvbHkwOXBx?=
 =?utf-8?B?d3NJL2Y2S04rYXV5ZXdrdVZjV0VpUTZyRGJiYytmcHJYeFdJd0VoRXNaRTBy?=
 =?utf-8?B?emhOckpGVnRPN2N1eGFrcGNuelFzNUV2VE5ieDlmcm9uMzZHNG55UlRocDZ4?=
 =?utf-8?B?Tnhobm5ScUVCdms4cTQvd1o0TEFPTk1uZHY5Vmt3MVZ3Tko4OEIwLzRrUkxi?=
 =?utf-8?B?cjA4QnRSZWNwYzBpYlNhTjNqTDZmelpwTTVlUGlreVM2bDBrbS9oaFVFR0Vp?=
 =?utf-8?B?VnRmV2N6UjZwcGpwOTN1SStpdmZNSk82QThYdUMrN2R3cFBjT09WcUg3bnEv?=
 =?utf-8?B?Nmd3U0VVYkJqK3R3T1hVMEpmMUpDNUI2SGtJMnZ1aXcwVUtxQnpXZTQ1WUJO?=
 =?utf-8?B?L1hJejhpTCtwbGo1MVdubmNPaHo2eVE5SFpacGcraUlONDhGdXMzczdoYkg1?=
 =?utf-8?B?V3lQcW55ZjZQaFBja1lCUWt5RFlCUzAzTU5PVWFVV1lQUGpRNFNIZ2dnK0Jz?=
 =?utf-8?Q?i5kB6VXLAQTO0nD2LQoIF/a5V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696e383a-2c30-43a5-2a7a-08dc18072d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 09:23:48.4295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NBUKU5IE+5KvR/PyCLGD8y3obZFiLC/S1pPuX4Oe2TQJMgUqRoPfRHJiodBoT71UXzmBTU673ci4Vdp/RnBHmnpduKxcm8Qr/JAv6ZzH1o0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5938
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDQvNl0gdmZpbzog
aW5pdGlhbGl6ZSBJT01NVUZERGV2aWNlIGFuZCBwYXNzIHRvDQo+dklPTU1VDQo+DQo+SGkgWmhl
bnpob25nLA0KPg0KPk9uIDEvMTUvMjQgMTE6MTMsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4g
SW5pdGlhbGl6ZSBJT01NVUZERGV2aWNlIGluIHZmaW8gYW5kIHBhc3MgdG8gdklPTU1VLCBzbyB0
aGF0IHZJT01NVQ0KPj4gY291bGQgZ2V0IGh3IElPTU1VIGluZm9ybWF0aW9uLg0KPj4NCj4+IElu
IFZGSU8gbGVnYWN5IGJhY2tlbmQgbW9kZSwgd2Ugc3RpbGwgcGFzcyBhIE5VTEwgSU9NTVVGRERl
dmljZSB0bw0KPnZJT01NVSwNCj4+IGluIGNhc2UgdklPTU1VIG5lZWRzIHNvbWUgcHJvY2Vzc2lu
ZyBmb3IgVkZJTyBsZWdhY3kgYmFja2VuZCBtb2RlLg0KPj4NCj4+IE9yaWdpbmFsbHktYnk6IFlp
IExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogTmljb2xpbiBDaGVu
IDxuaWNvbGluY0BudmlkaWEuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1
bkBsaW51eC5pbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhl
bnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaW5jbHVkZS9ody92ZmlvL3ZmaW8t
Y29tbW9uLmggfCAgMiArKw0KPj4gIGh3L3ZmaW8vaW9tbXVmZC5jICAgICAgICAgICAgIHwgIDIg
KysNCj4+ICBody92ZmlvL3BjaS5jICAgICAgICAgICAgICAgICB8IDI0ICsrKysrKysrKysrKysr
KysrKystLS0tLQ0KPj4gIDMgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9u
LmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby0NCj5jb21tb24uaA0KPj4gaW5kZXggOWI3ZWY3ZDAy
Yi4uZmRlMGQwY2E2MCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1v
bi5oDQo+PiArKysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4gQEAgLTMxLDYg
KzMxLDcgQEANCj4+ICAjZW5kaWYNCj4+ICAjaW5jbHVkZSAic3lzZW11L3N5c2VtdS5oIg0KPj4g
ICNpbmNsdWRlICJody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaCINCj4+ICsjaW5jbHVkZSAi
c3lzZW11L2lvbW11ZmRfZGV2aWNlLmgiDQo+Pg0KPj4gICNkZWZpbmUgVkZJT19NU0dfUFJFRklY
ICJ2ZmlvICVzOiAiDQo+Pg0KPj4gQEAgLTEyNiw2ICsxMjcsNyBAQCB0eXBlZGVmIHN0cnVjdCBW
RklPRGV2aWNlIHsNCj4+ICAgICAgYm9vbCBkaXJ0eV90cmFja2luZzsNCj4+ICAgICAgaW50IGRl
dmlkOw0KPj4gICAgICBJT01NVUZEQmFja2VuZCAqaW9tbXVmZDsNCj4+ICsgICAgSU9NTVVGRERl
dmljZSBpZGV2Ow0KPlRoaXMgbG9va3MgZHVwbGljYXRlIG9mIGV4aXN0aW5nIGZpZWxkczoNCj5p
ZGV2LmRldl9pZCBpcyBzYW1lIGFzIGFib3ZlIGRldmlkLiBieSB0aGUgd2F5IGxldCdzIHRyeSB0
byB1c2UgdGhlIHNhbWUNCj5kZXZpZCBldmVyeXdoZXJlLg0KPmlkZXYuaW9tbXVmZCBpcyBzYW1l
IGFzIGFib3ZlIGlvbW11ZmQgaWYgIT0gTlVMTC4NCj5TbyB3ZSBzaG91bGQgYXQgbGVhc3QgcmF0
aW9uYWxpemUuDQoNCkluZGVlZCwgSSdsbCByZW1vdmUgZGV2aWQgYW5kICppb21tdWZkLiBUaGFu
a3MgZm9yIHN1Z2dlc3Rpb24uDQoNCj4+ICB9IFZGSU9EZXZpY2U7DQo+Pg0KPj4gIHN0cnVjdCBW
RklPRGV2aWNlT3BzIHsNCj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3L3Zm
aW8vaW9tbXVmZC5jDQo+PiBpbmRleCA5YmZkZGMxMzYwLi5jYmQwMzVmMTQ4IDEwMDY0NA0KPj4g
LS0tIGEvaHcvdmZpby9pb21tdWZkLmMNCj4+ICsrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+PiBA
QCAtMzA5LDYgKzMwOSw3IEBAIHN0YXRpYyBpbnQgaW9tbXVmZF9jZGV2X2F0dGFjaChjb25zdCBj
aGFyICpuYW1lLA0KPlZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4gICAgICBWRklPQ29udGFpbmVy
QmFzZSAqYmNvbnRhaW5lcjsNCj4+ICAgICAgVkZJT0lPTU1VRkRDb250YWluZXIgKmNvbnRhaW5l
cjsNCj4+ICAgICAgVkZJT0FkZHJlc3NTcGFjZSAqc3BhY2U7DQo+PiArICAgIElPTU1VRkREZXZp
Y2UgKmlkZXYgPSAmdmJhc2VkZXYtPmlkZXY7DQo+PiAgICAgIHN0cnVjdCB2ZmlvX2RldmljZV9p
bmZvIGRldl9pbmZvID0geyAuYXJnc3ogPSBzaXplb2YoZGV2X2luZm8pIH07DQo+PiAgICAgIGlu
dCByZXQsIGRldmZkOw0KPj4gICAgICB1aW50MzJfdCBpb2FzX2lkOw0KPj4gQEAgLTQyOCw2ICs0
MjksNyBAQCBmb3VuZF9jb250YWluZXI6DQo+PiAgICAgIFFMSVNUX0lOU0VSVF9IRUFEKCZiY29u
dGFpbmVyLT5kZXZpY2VfbGlzdCwgdmJhc2VkZXYsDQo+Y29udGFpbmVyX25leHQpOw0KPj4gICAg
ICBRTElTVF9JTlNFUlRfSEVBRCgmdmZpb19kZXZpY2VfbGlzdCwgdmJhc2VkZXYsIGdsb2JhbF9u
ZXh0KTsNCj4+DQo+PiArICAgIGlvbW11ZmRfZGV2aWNlX2luaXQoaWRldiwgc2l6ZW9mKCppZGV2
KSwgY29udGFpbmVyLT5iZSwgdmJhc2VkZXYtDQo+PmRldmlkKTsNCj4+ICAgICAgdHJhY2VfaW9t
bXVmZF9jZGV2X2RldmljZV9pbmZvKHZiYXNlZGV2LT5uYW1lLCBkZXZmZCwgdmJhc2VkZXYtDQo+
Pm51bV9pcnFzLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmJhc2Vk
ZXYtPm51bV9yZWdpb25zLCB2YmFzZWRldi0+ZmxhZ3MpOw0KPj4gICAgICByZXR1cm4gMDsNCj4+
IGRpZmYgLS1naXQgYS9ody92ZmlvL3BjaS5jIGIvaHcvdmZpby9wY2kuYw0KPj4gaW5kZXggZDdm
ZTA2NzE1Yy4uMmMzYTVkMjY3YiAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZmaW8vcGNpLmMNCj4+ICsr
KyBiL2h3L3ZmaW8vcGNpLmMNCj4+IEBAIC0zMTA3LDExICszMTA3LDIxIEBAIHN0YXRpYyB2b2lk
IHZmaW9fcmVhbGl6ZShQQ0lEZXZpY2UgKnBkZXYsDQo+RXJyb3IgKiplcnJwKQ0KPj4NCj4+ICAg
ICAgdmZpb19iYXJzX3JlZ2lzdGVyKHZkZXYpOw0KPj4NCj4+IC0gICAgcmV0ID0gdmZpb19hZGRf
Y2FwYWJpbGl0aWVzKHZkZXYsIGVycnApOw0KPj4gKyAgICBpZiAodmJhc2VkZXYtPmlvbW11ZmQp
IHsNCj4+ICsgICAgICAgIHJldCA9IHBjaV9kZXZpY2Vfc2V0X2lvbW11X2RldmljZShwZGV2LCAm
dmJhc2VkZXYtPmlkZXYsIGVycnApOw0KPj4gKyAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgcmV0
ID0gcGNpX2RldmljZV9zZXRfaW9tbXVfZGV2aWNlKHBkZXYsIDAsIGVycnApOw0KPj4gKyAgICB9
DQo+PiAgICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgIGVycm9yX3ByZXBlbmQoZXJycCwgIkZh
aWxlZCB0byBzZXQgaW9tbXVfZGV2aWNlOiAiKTsNCj5hdCB0aGUgbW9tZW50IGl0IGlzIHJhdGhl
ciBhbiBJT01NVUZEIGRldmljZS4NCg0KV2lsbCB1c2UgIkZhaWxlZCB0byBzZXQgSU9NTVVGRCBk
ZXZpY2U6ICINCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPj4gICAgICAgICAgZ290byBvdXRfdGVh
cmRvd247DQo+PiAgICAgIH0NCj4+DQo+PiArICAgIHJldCA9IHZmaW9fYWRkX2NhcGFiaWxpdGll
cyh2ZGV2LCBlcnJwKTsNCj4+ICsgICAgaWYgKHJldCkgew0KPj4gKyAgICAgICAgZ290byBvdXRf
dW5zZXRfaWRldjsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gICAgICBpZiAodmRldi0+dmdhKSB7DQo+
PiAgICAgICAgICB2ZmlvX3ZnYV9xdWlya19zZXR1cCh2ZGV2KTsNCj4+ICAgICAgfQ0KPj4gQEAg
LTMxMjgsNyArMzEzOCw3IEBAIHN0YXRpYyB2b2lkIHZmaW9fcmVhbGl6ZShQQ0lEZXZpY2UgKnBk
ZXYsIEVycm9yDQo+KiplcnJwKQ0KPj4gICAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICJjYW5ub3Qgc3VwcG9ydCBJR0QgT3BSZWdpb24gZmVh
dHVyZSBvbiBob3RwbHVnZ2VkICINCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICJkZXZpY2Ui
KTsNCj4+IC0gICAgICAgICAgICBnb3RvIG91dF90ZWFyZG93bjsNCj4+ICsgICAgICAgICAgICBn
b3RvIG91dF91bnNldF9pZGV2Ow0KPj4gICAgICAgICAgfQ0KPj4NCj4+ICAgICAgICAgIHJldCA9
IHZmaW9fZ2V0X2Rldl9yZWdpb25faW5mbyh2YmFzZWRldiwNCj4+IEBAIC0zMTM3LDEzICszMTQ3
LDEzIEBAIHN0YXRpYyB2b2lkIHZmaW9fcmVhbGl6ZShQQ0lEZXZpY2UgKnBkZXYsDQo+RXJyb3Ig
KiplcnJwKQ0KPj4gICAgICAgICAgaWYgKHJldCkgew0KPj4gICAgICAgICAgICAgIGVycm9yX3Nl
dGdfZXJybm8oZXJycCwgLXJldCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJk
b2VzIG5vdCBzdXBwb3J0IHJlcXVlc3RlZCBJR0QgT3BSZWdpb24gZmVhdHVyZSIpOw0KPj4gLSAg
ICAgICAgICAgIGdvdG8gb3V0X3RlYXJkb3duOw0KPj4gKyAgICAgICAgICAgIGdvdG8gb3V0X3Vu
c2V0X2lkZXY7DQo+PiAgICAgICAgICB9DQo+Pg0KPj4gICAgICAgICAgcmV0ID0gdmZpb19wY2lf
aWdkX29wcmVnaW9uX2luaXQodmRldiwgb3ByZWdpb24sIGVycnApOw0KPj4gICAgICAgICAgZ19m
cmVlKG9wcmVnaW9uKTsNCj4+ICAgICAgICAgIGlmIChyZXQpIHsNCj4+IC0gICAgICAgICAgICBn
b3RvIG91dF90ZWFyZG93bjsNCj4+ICsgICAgICAgICAgICBnb3RvIG91dF91bnNldF9pZGV2Ow0K
Pj4gICAgICAgICAgfQ0KPj4gICAgICB9DQo+Pg0KPj4gQEAgLTMyMjksNiArMzIzOSw4IEBAIG91
dF9kZXJlZ2lzdGVyOg0KPj4gICAgICBpZiAodmRldi0+aW50eC5tbWFwX3RpbWVyKSB7DQo+PiAg
ICAgICAgICB0aW1lcl9mcmVlKHZkZXYtPmludHgubW1hcF90aW1lcik7DQo+PiAgICAgIH0NCj4+
ICtvdXRfdW5zZXRfaWRldjoNCj4+ICsgICAgcGNpX2RldmljZV91bnNldF9pb21tdV9kZXZpY2Uo
cGRldik7DQo+PiAgb3V0X3RlYXJkb3duOg0KPj4gICAgICB2ZmlvX3RlYXJkb3duX21zaSh2ZGV2
KTsNCj4+ICAgICAgdmZpb19iYXJzX2V4aXQodmRldik7DQo+PiBAQCAtMzI1Nyw2ICszMjY5LDcg
QEAgc3RhdGljIHZvaWQgdmZpb19pbnN0YW5jZV9maW5hbGl6ZShPYmplY3QgKm9iaikNCj4+ICBz
dGF0aWMgdm9pZCB2ZmlvX2V4aXRmbihQQ0lEZXZpY2UgKnBkZXYpDQo+PiAgew0KPj4gICAgICBW
RklPUENJRGV2aWNlICp2ZGV2ID0gVkZJT19QQ0kocGRldik7DQo+PiArICAgIFZGSU9EZXZpY2Ug
KnZiYXNlZGV2ID0gJnZkZXYtPnZiYXNlZGV2Ow0KPj4NCj4+ICAgICAgdmZpb191bnJlZ2lzdGVy
X3JlcV9ub3RpZmllcih2ZGV2KTsNCj4+ICAgICAgdmZpb191bnJlZ2lzdGVyX2Vycl9ub3RpZmll
cih2ZGV2KTsNCj4+IEBAIC0zMjcxLDcgKzMyODQsOCBAQCBzdGF0aWMgdm9pZCB2ZmlvX2V4aXRm
bihQQ0lEZXZpY2UgKnBkZXYpDQo+PiAgICAgIHZmaW9fdGVhcmRvd25fbXNpKHZkZXYpOw0KPj4g
ICAgICB2ZmlvX3BjaV9kaXNhYmxlX3JwX2F0b21pY3ModmRldik7DQo+PiAgICAgIHZmaW9fYmFy
c19leGl0KHZkZXYpOw0KPj4gLSAgICB2ZmlvX21pZ3JhdGlvbl9leGl0KCZ2ZGV2LT52YmFzZWRl
dik7DQo+PiArICAgIHZmaW9fbWlncmF0aW9uX2V4aXQodmJhc2VkZXYpOw0KPj4gKyAgICBwY2lf
ZGV2aWNlX3Vuc2V0X2lvbW11X2RldmljZShwZGV2KTsNCj4+ICB9DQo+Pg0KPj4gIHN0YXRpYyB2
b2lkIHZmaW9fcGNpX3Jlc2V0KERldmljZVN0YXRlICpkZXYpDQo+VGhhbmtzDQo+DQo+RXJpYw0K
DQo=

