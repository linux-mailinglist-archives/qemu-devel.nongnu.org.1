Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A87DB728EA7
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 05:42:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7T0I-0006z4-4X; Thu, 08 Jun 2023 23:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7T0G-0006yj-Er
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 23:41:32 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7T0D-0005AC-Fp
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 23:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686282089; x=1717818089;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZbENfAB3HjMblVP4KZtDPO1uID/+5+xMxBhZCGrx/Kg=;
 b=ij62My5Kitc4pevyWWm7aQkHtJOTiELaeo75l0DLpGp+XIFtgkCTJR4b
 t1SABqhY7oRL5O8t4rGpUXKLOCFcnHj6p4d7goneEVoPPYaLpPoettiFM
 TR/dVoxxsk8T7KGQHftPQ+S7mQ/FjEU5b0bOWYhxTtGtnx+SCAyGq7B0f
 MggWY+3ZhIdya9rit//2zmAMAmjQl4uSfzOCIV18e1/6BC/NkzfEB0/vM
 bM91nqLTOnjipmfEda4Hngrpra/SS4Cwd18CyLL7lItxt3Cns/xTRii0A
 01/WYnj46qRjfj5HUrF/LmlPIzhRTylDMRnJI1mbGmuts4aR0OK8Ny2Eb g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="356393061"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="356393061"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 20:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="884440828"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="884440828"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga005.jf.intel.com with ESMTP; 08 Jun 2023 20:41:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 20:41:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 20:41:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 20:41:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZ4/CReZh9RXnas75LMZ8+1C06wm096X7YfHcEJh6+MGQAOpcz7jJdl1ptrlGkdQdtFijnFLnGSWmHPVj5RN1qZR+zPaSR/OEghVll5jbXUSllko82lDA6r9z0/YnQNfr5oJevllv7fImpA2yP/6h5DELy+d00Xjb0Bp2VYzmvbtkU4H5diLovSIf9Wb98GvHOFum82HJWIEaJoOY6723ueVYlLEz6UERsrv3Ga/ZUnzGdSU4HX3to+3sgXtWJQJzqPFWCVAMpNCytrL4oPNhKPGfL+G306ffjxTfEkwQHAkRNU1L0zDs9k70I+bePZREIcfqJBKWke74+nmh66xpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbENfAB3HjMblVP4KZtDPO1uID/+5+xMxBhZCGrx/Kg=;
 b=Yu+EMmRJWK1vOO5Gi+4kjZgzhlnBwP+P0fB88d5he2pmvhHN0IeEii5Zu5la9DmEB1w3Mb50MBXYwtnBHqvsVnRG6tAgh+YONZd1JA/3ilHKhOVDv77ktiJh2h/aEdss8NaWakEkeXcNK8pXX8+azYU45MGTT5j2g1SyfLR4HGUEWW1NQ/4rHSWRWLvkziR+E++cdbYYKCDveO8iv9enE/ZbXgKBSraWNbCdcDJfd9UCnlmT63ksY7zN6IkAiGw5GH3ewBqJQ4J+wdvJbgR4HCazxfZFd4Bi3u2dDRRD6ddroLbUF+8MtGcj614sLu4soUps1hP4XMtxe0ontL6toQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB6470.namprd11.prod.outlook.com (2603:10b6:8:c2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.19; Fri, 9 Jun 2023 03:41:21 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 03:41:20 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, 
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Thread-Topic: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Thread-Index: AQHZmfDNwmLmlvy/GkmXR1XRJDGDhq+A8JUAgADialA=
Date: Fri, 9 Jun 2023 03:41:20 +0000
Message-ID: <SJ0PR11MB67446F02249DBC771BE83D849251A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-6-zhenzhong.duan@intel.com> <ZIHgFFSaBJWFUNd7@x1n>
In-Reply-To: <ZIHgFFSaBJWFUNd7@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB6470:EE_
x-ms-office365-filtering-correlation-id: fcfc19e6-d8a0-4571-ddfc-08db689b63f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X2qgTDXpSP3EQliGTI/8wZE8WAiOs/1pOfXYfDNPSu9cft1IReXXevNErpgcxdYTpG9xLSMGh/tNCwapB5CEd/RnIvEZPUhtfGH/7A/UrAQwcdbT+9p0U6UmSoN6vfT7j3NvN//xcVs33jAyTvZaPs+DDyVdI5t4IMykrwMfDqdUGgFZvxMSESCYRaVJ07XNdnOV7zwIfsKiKg9FV5AneJy+5WDSiv+DeeyWujtfbkbWm9gjV8RE95fxp4egF12eT16kYq/YIollmgLoC8COFmqdnxO6ObduxIX8IuhxJrIqTKXPT57hLRwEu2mIVdp42p4x6Q+bgnexGnpE7uTaZHGD1AT05GZwHldlpUWyYv33QElh9wUsXgLz7tkyZvl1kZoV9OROe5qlxKd+C629bFvXNq6AgXww0XUppOtKDpcYN0HkHmwIlw5OveKZxjlrPd3p+MzwwsMEpgAJIMG6whNmQVtGBm0zsj41b8ivwxWZQAC2a209RjezSDI2UkjI2dijViKnNIOObndMyDgYJGF2/LCPNtQTuZpC0d7SWIfKoZd/uNuMIhFJgrdono9vxHLNUL2danX9DZdYfuPCxdY+lP2KfSDvtZ9Y0e1bk2Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199021)(478600001)(5660300002)(38070700005)(110136005)(54906003)(52536014)(8936002)(71200400001)(8676002)(316002)(4326008)(64756008)(66446008)(66476007)(122000001)(76116006)(66556008)(66946007)(41300700001)(38100700002)(2906002)(7416002)(82960400001)(6506007)(33656002)(26005)(55016003)(9686003)(107886003)(86362001)(186003)(83380400001)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE5iMHZQM3lWb1NEVzQ5bWcrN2VWazJhdVFlUkFheWdmRHJOaXRVbFVyM3Q3?=
 =?utf-8?B?UkhyVDdSNXJGNTJBOE9ydEFyaC84YmNwVzhOY3doVFBCemdiY2Qva2o5TzRx?=
 =?utf-8?B?cU01ZmJXNDdFRVNZcHNPKzd3WStWN3QrLyt3dytKQkFGdzlrT3V3dHdXbDl5?=
 =?utf-8?B?TzIwekdnL3hGR2NBUHRwNFIwNGx0bnUxNEZiSzRqb01keUllcWxhYTBrOHl4?=
 =?utf-8?B?Q3FUSHZzUUdFWjdsWWpPVHNRaFY0RGtDUVRCRmhWUnFidUc5QWV0QXBoSXNH?=
 =?utf-8?B?ek5nRWRsZFFBYmNlMWtIY0QzQUJ6V3BORjB0cDg2RjNXYzZIUGl5RnlrdHBQ?=
 =?utf-8?B?UU82VmhXWGZ2RzFZYlgvdGFDOVVxdis4bk1qdTFtRFJGUUdFWVgxZ2VKVWtU?=
 =?utf-8?B?V1FxSlIxSmFsKzhJRERtMnhZMzlzS1o2TllGQllrQy8rWHV6TTh2UTdaZjJC?=
 =?utf-8?B?Q1FDUUNxTzd0cXVIT2xSb1lWN3dNUmZ6bEZxYU5UZ0h4Qk11T21vTVpFYjFj?=
 =?utf-8?B?ejJJalN0SlhpWFd5NFpITGd6WkZKTk1rRVUxRGxuT0N5d3lqYWlzd25XbFRm?=
 =?utf-8?B?bUNqSG9UL2lnWHZ0MFdzTmorRVNoSm5oa0RGV3FJR296L0FGTEFHZUlURmVu?=
 =?utf-8?B?VS8zMG9rL0R5WWp6NlFKT1l4MUJmR2ZzdG04MVYyMU0vSzRIMDFjQ1BhdThU?=
 =?utf-8?B?TW9UenAvdThuQVE3dDVkVEpKQmsvRU9UaVBQbUJNb1NPNzI2VWx4QjkwUHVE?=
 =?utf-8?B?aGd0ZHUrcUttL0thRDR1NFQzTVNXeUtvZktKZ1k2Zld0akFqaU1UMjZJRVBU?=
 =?utf-8?B?NzMrc0JuRytyVXJVS3hoTDVKOW0zV3VIUUtreUpGU1I5UEp0bnZlS3JHY0d4?=
 =?utf-8?B?ZUp4ZTc1YjMwZ3Z3NEdWRmZnL0lSOUJqNVlPek5hSHRwREREVGlQdjA1dEYv?=
 =?utf-8?B?WkxsU3VHS3Y3S3J1b1c5RmpaWUxPRktQZzRvQWJPL3hqU2NMNG9iNjNHRHk2?=
 =?utf-8?B?RE9hWjBZaDZnekJ4OVpGejUrSHJDVEVoNjZkZjVoK2h0eFF1ellIM3M5TzZj?=
 =?utf-8?B?OUxQTlJOUDVzbTRjemJTc3FwWm5CQXoxYk9uZWp4aHQ3SFlyMUJoSmRkeHhM?=
 =?utf-8?B?VDRXWExUekplazRTdHo1aU1OWkl2Y3BXRGg2dDdieUNBZ0c4Rk5xU0dBeGda?=
 =?utf-8?B?dHpZNm1QN25lbXYyTWZUbVpkVHJscXVEQ2JlRnpBVEdyTHBESENZd0JVM1RI?=
 =?utf-8?B?MjdPVUE4UjdyblNuaUwyMXp2WitRSUlSZStqSDk1N09JZjZvWTVRa0hBSjJF?=
 =?utf-8?B?QjZ1UytKOXJYb0JrKzRWNlVuWXBUL29JSzkxKzBMaEoyZlpneERodVZEUnBF?=
 =?utf-8?B?YzRFT1QyYko3eUtkMXMwNzhIRjY3UStkNUJRUWZ6L2JkcitjSTNTWWM4ZjYy?=
 =?utf-8?B?dXNmUlhpa3dKK3B0M3YrVkhyMTNTbGRUWDJ5N08wVVdnaDgwdjZKWlAxM2Mv?=
 =?utf-8?B?YVNXbjZDQjh1NWZYc2dxS1JEdmFBdFhRZzNMblg4K3dLbEF3cjR1d3Zid3FI?=
 =?utf-8?B?TTZkWVNoeXVybTNmYjJpWDNla01sZ0g3bTRYMlJ2SkhwVytHNWxqcFpLdXZk?=
 =?utf-8?B?Q3lCbnNWc0lqM1ZubE56VThmalFwK2F0cXFGVitEM1dOSFdWbjFCWUFkbG9H?=
 =?utf-8?B?cGI4Uk9WWEFGWXVIcy9KVG9TUWs5SFhFa09yZ2tPZjZiK255Z1RkcGtCWkFY?=
 =?utf-8?B?dkJvQVlNamZ1S1JrSWFvZ1N1dGpSdmhxeXlTcHEyYVFtQmM0T3dLdWJ5elRl?=
 =?utf-8?B?VEIxL2NGbTZ2QlFJamZMOTluMHVYLy9zL2wrbGNlTlJTRUkyeHFZYVVkV29p?=
 =?utf-8?B?aDdZWGF5T3RKVkZmWkpzajgyVlNXNzR2ZGJBeHA5VmVEd2tiSWNTQkhoWk1O?=
 =?utf-8?B?L0g5aTBYbHhyUkpvUzZTaEhvTmVjZHVZSTl1dTRTR1ZVZnNyci9mOEo0c2h4?=
 =?utf-8?B?dnJud0pDb2RvdWJhamx4SUtDS3F6dytMbGxtVlRXbU9tN01QKzRLcjNUZGxy?=
 =?utf-8?B?R2RuWmhabGV2cjhGVmhVbjA3N3o0MHR2ZWhGQ1lraENONDl5MDQrd3ltNTJR?=
 =?utf-8?Q?os8jnngYsUv/9AouosPlbt4ii?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfc19e6-d8a0-4571-ddfc-08db689b63f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 03:41:20.8860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ILX3JbBOuajsI+cIYQTjNjwRzVsFV0FBPJy6n9tbMI8ZI9dEAZqtkL1Q6zPVsjQyuUH/f0XOB8lEFTMD5lxMXPN09X7Px0fYrkNUjFnhxlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6470
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mga04.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJl
ZGhhdC5jb20+DQo+U2VudDogVGh1cnNkYXksIEp1bmUgOCwgMjAyMyAxMDowNSBQTQ0KPlRvOiBE
dWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT47IEphc29uIEd1bnRob3Jw
ZQ0KPjxqZ2dAbnZpZGlhLmNvbT4NCj5DYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBtc3RAcmVk
aGF0LmNvbTsgamFzb3dhbmdAcmVkaGF0LmNvbTsNCj5wYm9uemluaUByZWRoYXQuY29tOyByaWNo
YXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOyBlZHVhcmRvQGhhYmtvc3QubmV0Ow0KPm1hcmNlbC5h
cGZlbGJhdW1AZ21haWwuY29tOyBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsNCj5jbGdAcmVk
aGF0LmNvbTsgZGF2aWRAcmVkaGF0LmNvbTsgcGhpbG1kQGxpbmFyby5vcmc7DQo+a3dhbmtoZWRl
QG52aWRpYS5jb207IGNqaWFAbnZpZGlhLmNvbTsgTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5j
b20+OyBQZW5nLA0KPkNoYW8gUCA8Y2hhby5wLnBlbmdAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjMgNS81XSBpbnRlbF9pb21tdTogT3B0aW1pemUgb3V0IHNvbWUgdW5uZWNlc3Nh
cnkNCj5VTk1BUCBjYWxscw0KPg0KPk9uIFRodSwgSnVuIDA4LCAyMDIzIGF0IDA1OjUyOjMxUE0g
KzA4MDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gQ29tbWl0IDYzYjg4OTY4ZjEgKCJpbnRl
bC1pb21tdTogcmV3b3JrIHRoZSBwYWdlIHdhbGsgbG9naWMiKSBhZGRzDQo+PiBsb2dpYyB0byBy
ZWNvcmQgbWFwcGVkIElPVkEgcmFuZ2VzIHNvIHdlIG9ubHkgbmVlZCB0byBzZW5kIE1BUCBvcg0K
Pj4gVU5NQVAgd2hlbiBuZWNlc3NhcnkuIEJ1dCB0aGVyZSBpcyBzdGlsbCBhIGNvcm5lciBjYXNl
IG9mIHVubmVjZXNzYXJ5DQo+VU5NQVAuDQo+Pg0KPj4gRHVyaW5nIGludmFsaWRhdGlvbiwgZWl0
aGVyIGRvbWFpbiBvciBkZXZpY2Ugc2VsZWN0aXZlLCB3ZSBvbmx5IG5lZWQNCj4+IHRvIHVubWFw
IHdoZW4gdGhlcmUgYXJlIHJlY29yZGVkIG1hcHBlZCBJT1ZBIHJhbmdlcywgcHJlc3VtaW5nIG1v
c3QNCj5vZg0KPj4gT1NlcyBhbGxvY2F0aW5nIElPVkEgcmFuZ2UgY29udGludW91c2x5LCBlLmcu
IG9uIHg4NiwgbGludXggc2V0cyB1cA0KPj4gbWFwcGluZyBmcm9tIDB4ZmZmZmZmZmYgZG93bndh
cmRzLg0KPj4NCj4+IFN0cmFjZSBzaG93cyBVTk1BUCBpb2N0bCB0YWtpbmcgMC4wMDAwMTR1cyBh
bmQgd2UgaGF2ZSAyOCBzdWNoIGlvY3RsKCkNCj4+IGluIG9uZSBpbnZhbGlkYXRpb24sIGFzIHR3
byBub3RpZmllcnMgaW4geDg2IGFyZSBzcGxpdCBpbnRvIHBvd2VyIG9mIDINCj4+IHBpZWNlcy4N
Cj4+DQo+PiBpb2N0bCg0OCwgVkZJT19JT01NVV9VTk1BUF9ETUEsIDB4N2ZmZmZkNWM0MmYwKSA9
IDAgPDAuMDAwMDE0Pg0KPg0KPlRoYW5rcyBmb3IgdGhlIG51bWJlcnMsIGJ1dCBmb3IgYSBmYWly
IGNvbXBhcmlzb24gSU1ITyBpdCBuZWVkcyB0byBiZSBhDQo+Y29tcGFyaXNvbiBvZiBiZWZvcmUv
YWZ0ZXIgb24gdGhlIHdob2xlIHRpbWUgdXNlZCBmb3IgdW5tYXAgQVMuICBJdCdsbCBiZQ0KPmdy
ZWF0IHRvIGhhdmUgZmluZXIgZ3JhbnVsZSBtZWFzdXJlbWVudHMgbGlrZSBlYWNoIGlvY3RsLCBi
dXQgdGhlIHRvdGFsIHRpbWUNCj51c2VkIHNob3VsZCBiZSBtb3JlIGltcG9ydGFudCAoZXNwZWNp
YWxseSB0byBjb250YWluICJhZnRlciIpLiBTaWRlDQo+bm90ZTogSSBkb24ndCB0aGluayB0aGUg
VU5NQVAgaW9jdGwgd2lsbCB0YWtlIHRoZSBzYW1lIHRpbWU7IGl0IHNob3VsZCBtYXR0ZXINCj5v
biB3aGV0aGVyIHRoZXJlJ3MgbWFwcGluZyBleGlzdCkuDQoNClllcywgYnV0IHdoYXQgd2Ugd2Fu
dCB0byBvcHRpbWl6ZSBvdXQgaXMgdGhlIHVubWFwcGluZyBuby1leGlzdGVudCByYW5nZSBjYXNl
Lg0KV2lsbCBzaG93IHRoZSB0aW1lIGRpZmYgc3BlbnQgaW4gdW5tYXAgQVMuDQoNCj4NCj5BY3R1
YWxseSBpdCdzIGhhcmQgdG8gdGVsbCBiZWNhdXNlIHRoaXMgYWxzbyBkZXBlbmRzIG9uIHdoYXQn
cyBpbiB0aGUgaW92YSB0cmVlLi4NCj5idXQgc3RpbGwgYXQgbGVhc3Qgd2Uga25vdyBob3cgaXQg
d29ya3MgaW4gc29tZSBjYXNlcy4NCj4NCj4+DQo+PiBUaGUgb3RoZXIgcHVycG9zZSBvZiB0aGlz
IHBhdGNoIGlzIHRvIGVsaW1pbmF0ZSBub2lzeSBlcnJvciBsb2cgd2hlbg0KPj4gd2Ugd29yayB3
aXRoIElPTU1VRkQuIEl0IGxvb2tzIHRoZSBkdXBsaWNhdGUgVU5NQVAgY2FsbCB3aWxsIGZhaWwg
d2l0aA0KPj4gSU9NTVVGRCB3aGlsZSBhbHdheXMgc3VjY2VlZCB3aXRoIGxlZ2FjeSBjb250YWlu
ZXIuIFRoaXMgYmVoYXZpb3INCj4+IGRpZmZlcmVuY2UgbGVhZHMgdG8gYmVsb3cgZXJyb3IgbG9n
IGZvciBJT01NVUZEOg0KPj4NCj4+IElPTU1VX0lPQVNfVU5NQVAgZmFpbGVkOiBObyBzdWNoIGZp
bGUgb3IgZGlyZWN0b3J5DQo+PiB2ZmlvX2NvbnRhaW5lcl9kbWFfdW5tYXAoMHg1NjIwMTJkNmI2
ZDAsIDB4MCwgMHg4MDAwMDAwMCkgPSAtMiAoTm8NCj4+IHN1Y2ggZmlsZSBvciBkaXJlY3Rvcnkp
IElPTU1VX0lPQVNfVU5NQVAgZmFpbGVkOiBObyBzdWNoIGZpbGUgb3INCj4+IGRpcmVjdG9yeSB2
ZmlvX2NvbnRhaW5lcl9kbWFfdW5tYXAoMHg1NjIwMTJkNmI2ZDAsIDB4ODAwMDAwMDAsDQo+PiAw
eDQwMDAwMDAwKSA9IC0yIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KSAuLi4NCj4NCj5NeSBn
dXQgZmVlbGluZyBpcyB0aGUgbWFqb3IgbW90aXZhdGlvbiBpcyBhY3R1YWxseSB0aGlzIChub3Qg
dGhlIHBlcmYpLg0KPnRlbnMgb2Ygc29tZSAxNHVzIGlvY3RscyBpcyByZWFsbHkgbm90aGluZyBv
biBhIHJhcmUgZXZlbnQuLg0KDQpUbyBiZSBob25lc3QsIHllcy4NCg0KVGhhbmtzDQpaaGVuemhv
bmcNCg0KPg0KPkphc29uIFdhbmcgcmFpc2VkIGEgcXVlc3Rpb24gaW4gcHJldmlvdXMgdmVyc2lv
biBhbmQgSSB0aGluayBKYXNvbkcncyByZXBseSBpcw0KPmhlcmU6DQo+DQo+aHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci9aSFRhUVhkM1p5Ym1oQ0xiQG52aWRpYS5jb20NCj4NCj5KYXNvbkc6IHNv
cnJ5IEkga25vdyB6ZXJvIG9uIGlvbW11ZmQgYXBpIHlldCwgYnV0IHlvdSBzYWlkOg0KPg0KPiAg
ICAgICAgVGhlIFZGSU8gZW11bGF0aW9uIGZ1bmN0aW9ucyBzaG91bGQgZG8gd2hhdGV2ZXIgVkZJ
TyBkb2VzLCBpcyB0aGVyZQ0KPiAgICAgICAgYSBtaXN0YWtlIHRoZXJlPw0KPg0KPklJVUMgd2hh
dCBWRklPIGRvZXMgaGVyZSBpcyBpdCByZXR1cm5zIHN1Y2NlZWQgaWYgdW5tYXAgb3ZlciBub3Ro
aW5nIHJhdGhlcg0KPnRoYW4gZmFpbGluZyBsaWtlIGlvbW11ZmQuICBDdXJpb3VzIChsaWtlIEph
c29uVykgb24gd2h5IHRoYXQgcmV0dmFsPyAgSSdkDQo+YXNzdW1lIGZvciByZXR1cm5pbmcgImhv
dyBtdWNoIHVubWFwcGVkIiB3ZSBjYW4gYXQgbGVhc3Qgc3RpbGwgcmV0dXJuIDAgZm9yDQo+bm90
aGluZy4NCj4NCj5BcmUgeW91IHByb2JhYmx5IHN1Z2dlc3RpbmcgdGhhdCB3ZSBjYW4gcHJvYmFi
bHkgaGFuZGxlIHRoYXQgaW4gUUVNVSBzaWRlDQo+b24gLUVOT0VOVCBoZXJlIGZvciBpb21tdWZk
IG9ubHkgKGEgcXVlc3Rpb24gdG8gWWk/KS4NCj4NCj5JZiB0aGF0J3MgYWxyZWFkeSBhIGtlcm5l
bCBhYmksIG5vdCBzdXJlIHdoZXRoZXIgaXQncyBldmVuIGRpc2N1c3NhYmxlLCBidXQganVzdCB0
bw0KPnJhaXNlIHRoaXMgdXAuDQo+DQo+LS0NCj5QZXRlciBYdQ0KDQo=

