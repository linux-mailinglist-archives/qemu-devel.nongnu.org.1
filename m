Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F4A8313AD
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:59:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNIE-00070p-H3; Thu, 18 Jan 2024 02:58:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQNI8-0006nG-Lb
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:58:26 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQNI6-0008BF-GN
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705564703; x=1737100703;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uhdkCAgPQ0dN8IO7y5C2xRMiefDACnJdFgZYuEevPOo=;
 b=lHS3u32CxPT27ITvnZoTm3/Z2ohd9ewuxXqnH/MYSeYajoEx3qR8KN7K
 oDB53ULxkIv9QziIWAz6maBPZIxWb7TO/Gi5ftSXD9UOc74VKD4zLjhEP
 zCpeyP70Szvps9LTJEuGEEnvfqn9knmr9tysBpgAU4VNRdLcVfxKkHK4K
 KfviVIrvfweCA4sY6ehuZFUldeaysgfpNnAQai7IZmEfv+VRE5v7Gb9/1
 TzD/Y+mef7qSeRc8avZ1o1u0kvPP7hxf30XmZrXamEIMLvGiajWwwfPP+
 /LgKmNubYRZMHbTdg+fldSBFjKihWfwZGS9MiwOeivWVGHFvkTMc6W4vw A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7748795"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="7748795"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jan 2024 23:58:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="777662753"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; d="scan'208";a="777662753"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Jan 2024 23:58:19 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 23:58:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 23:58:19 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 23:58:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQbQXUgEzSxqzJ/5xmXpA6ANjSDtua3xg48Xsp3t0CvOrmXHWlSakjOfW++hORAC+cUJvb7KBeMOdMXD0DJ626oJHpd4SmKrJZtFaJs7Hg3rMHSZOdf95+tD4UT1RC1BLrnzAIjo4KLEdTLhOBQ8XOlyN+IHUk336efOYSXyztin/FJUbXM9N/XcPa7WaE0vrmJYhhtNTpL92JWRoflrv0J6QvUftP0NRC/tbK/E4xd06hWOZz9UOYbfbFRtkAJCC741wiZoAygsciiykUXdj0+7HDIeZGO0k8CrAaIyncKr0B5cYdh9s9Ct+pXx8B5Zyb9tAJz10bvisusgGw/gRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhdkCAgPQ0dN8IO7y5C2xRMiefDACnJdFgZYuEevPOo=;
 b=KN7Ki+fCSHvxqw/vcnD9m9xRs9V6H4jQGjr1rb5kS/vv8vZl+WF+5b5Ta/7GuDQEM/6DkRFcnbzvWfpJygI8wMIBbTqM+gUoSQcNUonzmUTu/ddSxGNPONpt0tk1cU+AwxqVxjAa8Bou6gGL41EfbMJ8NTF2UgttyRQFeSeIrTaLxHPSOTpTYZstyCosTW/yImGi/2ue1yH9F+Azgx2r18lKEDecHE3ranAVF5LvcFpfP/CM4neLSJXiNHGfxDOeYwU192qvqCbWtFCdx4Ldf3Nj1vF82UPcbnR9/mbuF5VlXByQ1vJaV6w1go9Fh8DW4P5OXn2aU8scaulp5qC8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB7764.namprd11.prod.outlook.com (2603:10b6:610:145::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 07:58:11 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%5]) with mapi id 15.20.7181.020; Thu, 18 Jan 2024
 07:58:11 +0000
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
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH rfcv1 2/6] hw/pci: introduce
 pci_device_set/unset_iommu_device()
Thread-Topic: [PATCH rfcv1 2/6] hw/pci: introduce
 pci_device_set/unset_iommu_device()
Thread-Index: AQHaR5vrPb8w/pVxfEGbuNI7QgnDG7DeDuAAgAEpv3A=
Date: Thu, 18 Jan 2024 07:58:11 +0000
Message-ID: <SJ0PR11MB67446AF8FA067454C28563A792712@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-3-zhenzhong.duan@intel.com>
 <ba280754-665e-49af-9442-9a37a1f5ce75@redhat.com>
In-Reply-To: <ba280754-665e-49af-9442-9a37a1f5ce75@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB7764:EE_
x-ms-office365-filtering-correlation-id: 347bfda7-c90f-48e1-9870-08dc17fb3755
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Y4nwTvG0u2Kc6LUqVXsO9n1dgQqMF0o8fFr97FBuUSARWTplfvKT5j+s3s2ICWhSkybcIB3ZAqoo4kqxqKmXrsQS8Y+YmzU2B8lpmEnGKxiwSEixuVX7HTyzLjULDrh82tmlqnhfqCm+FttlhXE0dBg4ITnn11BIhfcTS87GIBUfY6kqyDx/1AezZd0F3DzGAa9LMh2mzEv96aUJbHu/26jFD6Na+G4bmLek17HA240dGvxVCy3L3/fhcFNrm02V8sClTDoNtq2c7I0K14/VqlI+pw2QaTbCztBdEuMxXmw1dUJDSpUQiSCk2QnpFGmLEK+2NYNr33IWeq9LdeBL0P9NuQiSbRVQziIox4VWRHyKKBDinvXmFGmxvjmi3BhhvBU53wKAY9fOqfZIAJd8G/8Vfh67auXkV4qZs9+kLry0eEsc7Qa0PJp3qj5MSIU89S/QBeTHXAv17VAGIqzMSayqKLdbSUFsRfAufvfhgCgw+2bFlUe2MYon20qLG/ccBOeHdO1EIWB0qvq+Xn/pvLmMU+8hmyXD8rJWt3Ii/E63f/tj2e+sSUR9FgEtwnizmKOjOeCgY09FMhRGerXcTgrxK5N2rySmMe0nLH5pLm3yvk0lauBBg7U+wK8iX9E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(71200400001)(26005)(38100700002)(122000001)(8936002)(4326008)(8676002)(5660300002)(52536014)(7696005)(7416002)(2906002)(41300700001)(66446008)(478600001)(9686003)(66556008)(6506007)(54906003)(64756008)(316002)(66476007)(66946007)(76116006)(110136005)(33656002)(83380400001)(86362001)(82960400001)(38070700009)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDRxU2srUFcyV2l5Mk1SZ1dMZ2VmUUpIYVhzb0crWU9LL0s2VW1TS0Y2eTho?=
 =?utf-8?B?dUttVU12ZUNCcThwMjNYRGpVekJvVFIyTUdBNlpIMmRVSG4rSEpHa1VNbDd0?=
 =?utf-8?B?VkV5TmYvZlk0c2hYQlgwdmdtTXFlNVg1QVpqK04wMUllTGpIeGsrTWVLOHRj?=
 =?utf-8?B?ODNFbmF6Tkp5Z0FRMFZqbTBZclBNa0hEZ25UKzZNcnk5bUtSNW81ajJyU1Nm?=
 =?utf-8?B?MG5iekpNTkVsVWt6R0kzdlppWnlnOXAySHRBNEZTS2xnNzdpME9lQUhVMGVK?=
 =?utf-8?B?eThmUUlnNnBXSXozRUZNZ3FmTkxidy9vY0R4c3Q0YWRNTU9SSDcrVWtRTk5a?=
 =?utf-8?B?Y1ZubHV6NUI0aEkrN29xSVY4UERuTmVmdzRDcDZGcEhTV2lWc3lEWCs5ODd1?=
 =?utf-8?B?RGFRc2ovcG1reWJENmlsU1FmeTMxcWlrYWVvWEJKTEEwdGVvQjcrQk5kVVlD?=
 =?utf-8?B?eW1KRzR5Z1JUekhXMU5WZktWZG0rQzN6cXV6NUVGOVVpbEJNQXBmc29SeGg2?=
 =?utf-8?B?NmFSNjJsM0ROekR6MkJMVlljMWFLK2M4QWltSmpXTkVmT1ZWL29PK3o4eTI0?=
 =?utf-8?B?SW5pMVdmYU5KbU43Q1Q5WFpqOFM3UDNxeHhjRG1LdFAyNnZPZmhBNFNrczJL?=
 =?utf-8?B?ZnJxUmkvTUdteGxmY0lTaEQ0NytyRG1TdFE3djgvZkdYOGw3K2NGQ0VxMlZm?=
 =?utf-8?B?WDFvZ0ZIMG01QUljMGY0dEVkWlR3V21VTkpSSTArTStPWm1oR2pyY1lWOU9o?=
 =?utf-8?B?dVN2SEtEMkpWZGVtTVdTUFpFSGRxaTVXUUVvcjFNS1hsY21TN0FBYlhMUzlB?=
 =?utf-8?B?aGl5NmI4OWhLNEdjeGVtbjUrK0o2VkZ2am9xcGNOcDRickZPSFZxK3U2Vnpv?=
 =?utf-8?B?WFVTbVNyWWVHZExzOVlDMEg5dmduN2NUaHJFVWhKaHhxZVRnZm94Sy8wK2lY?=
 =?utf-8?B?ZVJ3UVBtM0lvNm1xK2NKSnE3WFJ5L1JsekxwTlNaNHBjaU15ZjJpN1IycVU4?=
 =?utf-8?B?OGd5OElaUW9zaXRsOHpLaVdGbURXaTJMV2oyaytXTExSSWhXcEpNbXZTeENR?=
 =?utf-8?B?NS81c1FvcnNLcENLaXFlRVBqVW44QnFnSTZNdzZJd3lUZVoybmt1NmdwSEJl?=
 =?utf-8?B?VGhGS2ZCZmQrVmtrRFlCYjRmSDdCTWNHSUhzcjdzK095UTQ0ZlB0amZvVHBm?=
 =?utf-8?B?Rk1GOVY5QzEyM3ZJRXlRNHhhcWo4Z1lJK1lPVXZ4NFhMay9XOXEyNW50citU?=
 =?utf-8?B?WHYwN05Ic2QrVnc5SU0yZ2hGTjBTYStYSm5HSTZuMHdDYmRzQkhDa1ZEOVhB?=
 =?utf-8?B?UFZpZGtEb0RRMUtlM0NCN1JlbllwS3Nsa3dFemNXM1lvMDdxUTBWNTVnOXFI?=
 =?utf-8?B?RDkzY2tXMDhWNjZWL2Nwc3FOdXFUZmpXNlpWZnRkNUdTWEx6cWwwa0ZLbXIr?=
 =?utf-8?B?UmhKRmpMZnpEZ1M5cnhzS3NSM1BpZ2NBVklmTjBIaDNzMGF1S0pPZnc5aUtk?=
 =?utf-8?B?V2ZxQTFjUjZFNkVwSlN2dTY2YTlPcGk2aWhSZklsaU1Wdll3YXRLd05BM0lu?=
 =?utf-8?B?TVBnZmxFYmx5YXY1eTdPb2JDMmRjNVFraUhEQXV5Q0xma0h0cFp3a3l2VVY3?=
 =?utf-8?B?WGorVzFhUG9OTmlhcGZiMm9mb3pCYWxVWjZHZXowWW1hZE5ucTQ3ZDVpdk5h?=
 =?utf-8?B?bFlXWUxRSy9UZXVvb2RMMHRVTkJvY3BLQllpRjE2ZDQrN0IydXhZQVRUcUVH?=
 =?utf-8?B?Y0wxTzJ5alcvcTNLeks3K2c5LzU1Z2pVNy9UL0lRb0YrU3o2eUlqUE1pbi9P?=
 =?utf-8?B?UlhzWkxYazVjM1FCU2xhZnhKS3R1SmJDM1lDM1RuOU8wRmVHMUo4WGNDdDlJ?=
 =?utf-8?B?VU9HbjBKbmo5WFpwT1RncnNodlNFTVZDK2JIcyt3clJrZ3dCZ3hOL0JVTHNk?=
 =?utf-8?B?N0ptck1tWnNwUGRUdlR6SmY4YktYZjhKZzhEYXVpRVl5ci9GTUpqSFJVYWlU?=
 =?utf-8?B?ZXZUK3I4cktkR1VpYm13Sm5oMWdQWHpILzYzUmNhVW9wU2JVN0dVSVcrcmlr?=
 =?utf-8?B?UGJWWHU5VHhPS3FkZC9FUVZQejBHOXAyWi84TkFORXVjdWlCN1hLeERramll?=
 =?utf-8?Q?XzOO8LPva0Ix2MTyvAvbuqGeE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347bfda7-c90f-48e1-9870-08dc17fb3755
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 07:58:11.2333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xsRzEU7VW1WAp+3yzAsEicbKAsguf9tfIRlulnFj36HmqL5RPTHM+Ko/soBxGah5NnFJy/ATwo6OFbh6PeS8zMp8ZLxzOcJ+ILyyjeOtc1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7764
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDIvNl0gaHcvcGNp
OiBpbnRyb2R1Y2UNCj5wY2lfZGV2aWNlX3NldC91bnNldF9pb21tdV9kZXZpY2UoKQ0KPg0KPkhp
IFpoZW56aG9uZywNCj4NCj5PbiAxLzE1LzI0IDExOjEzLCBaaGVuemhvbmcgRHVhbiB3cm90ZToN
Cj4+IEZyb206IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4NCj4+IFRoaXMgYWRkcyBw
Y2lfZGV2aWNlX3NldC91bnNldF9pb21tdV9kZXZpY2UoKSB0byBzZXQvdW5zZXQNCj4+IElPTU1V
RkREZXZpY2UgZm9yIGEgZ2l2ZW4gUENJZSBkZXZpY2UuIENhbGxlciBvZiBzZXQNCj4+IHNob3Vs
ZCBmYWlsIGlmIHNldCBvcGVyYXRpb24gZmFpbHMuDQo+Pg0KPj4gRXh0cmFjdCBvdXQgcGNpX2Rl
dmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKCkgdG8gZmFjaWxpdGF0ZQ0KPj4gaW1wbGVtZW50YXRp
b24gb2YgcGNpX2RldmljZV9zZXQvdW5zZXRfaW9tbXVfZGV2aWNlKCkuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZ
aSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IE5pY29s
aW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9u
ZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICBpbmNsdWRlL2h3
L3BjaS9wY2kuaCB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+PiAg
aHcvcGNpL3BjaS5jICAgICAgICAgfCA0OQ0KPisrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA4NiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9wY2kuaCBi
L2luY2x1ZGUvaHcvcGNpL3BjaS5oDQo+PiBpbmRleCBmYTYzMTNhYWJjLi5hODEwYzBlYzc0IDEw
MDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpLmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcv
cGNpL3BjaS5oDQo+PiBAQCAtNyw2ICs3LDggQEANCj4+ICAvKiBQQ0kgaW5jbHVkZXMgbGVnYWN5
IElTQSBhY2Nlc3MuICAqLw0KPj4gICNpbmNsdWRlICJody9pc2EvaXNhLmgiDQo+Pg0KPj4gKyNp
bmNsdWRlICJzeXNlbXUvaW9tbXVmZF9kZXZpY2UuaCINCj4+ICsNCj4+ICBleHRlcm4gYm9vbCBw
Y2lfYXZhaWxhYmxlOw0KPj4NCj4+ICAvKiBQQ0kgYnVzICovDQo+PiBAQCAtMzg0LDEwICszODYs
NDUgQEAgdHlwZWRlZiBzdHJ1Y3QgUENJSU9NTVVPcHMgew0KPj4gICAgICAgKg0KPj4gICAgICAg
KiBAZGV2Zm46IGRldmljZSBhbmQgZnVuY3Rpb24gbnVtYmVyDQo+PiAgICAgICAqLw0KPj4gLSAg
IEFkZHJlc3NTcGFjZSAqICgqZ2V0X2FkZHJlc3Nfc3BhY2UpKFBDSUJ1cyAqYnVzLCB2b2lkICpv
cGFxdWUsIGludA0KPmRldmZuKTsNCj4+ICsgICAgQWRkcmVzc1NwYWNlICogKCpnZXRfYWRkcmVz
c19zcGFjZSkoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50DQo+ZGV2Zm4pOw0KPj4gKyAg
ICAvKioNCj4+ICsgICAgICogQHNldF9pb21tdV9kZXZpY2U6IHNldCBpb21tdWZkIGRldmljZSBm
b3IgYSBQQ0kgZGV2aWNlIHRvDQo+dklPTU1VDQo+PiArICAgICAqDQo+PiArICAgICAqIE9wdGlv
bmFsIGNhbGxiYWNrLCBpZiBub3QgaW1wbGVtZW50ZWQgaW4gdklPTU1VLCB0aGVuIHZJT01NVQ0K
PmNhbid0DQo+PiArICAgICAqIHV0aWxpemUgaW9tbXVmZCBzcGVjaWZpYyBmZWF0dXJlcy4NCj4+
ICsgICAgICoNCj4+ICsgICAgICogUmV0dXJuIHRydWUgaWYgaW9tbXVmZCBkZXZpY2UgaXMgYWNj
ZXB0ZWQsIG9yIGVsc2UgcmV0dXJuIGZhbHNlIHdpdGgNCj4+ICsgICAgICogZXJycCBzZXQuDQo+
PiArICAgICAqDQo+PiArICAgICAqIEBidXM6IHRoZSAjUENJQnVzIG9mIHRoZSBQQ0kgZGV2aWNl
Lg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBAb3BhcXVlOiB0aGUgZGF0YSBwYXNzZWQgdG8gcGNp
X3NldHVwX2lvbW11KCkuDQo+PiArICAgICAqDQo+PiArICAgICAqIEBkZXZmbjogZGV2aWNlIGFu
ZCBmdW5jdGlvbiBudW1iZXIgb2YgdGhlIFBDSSBkZXZpY2UuDQo+PiArICAgICAqDQo+PiArICAg
ICAqIEBpZGV2OiB0aGUgZGF0YSBzdHJ1Y3R1cmUgcmVwcmVzZW50aW5nIGlvbW11ZmQgZGV2aWNl
Lg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKi8NCj4+ICsgICAgaW50ICgqc2V0X2lvbW11X2Rldmlj
ZSkoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50MzJfdCBkZXZmbiwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgSU9NTVVGRERldmljZSAqaWRldiwgRXJyb3IgKiplcnJwKTsN
Cj4+ICsgICAgLyoqDQo+PiArICAgICAqIEB1bnNldF9pb21tdV9kZXZpY2U6IHVuc2V0IGlvbW11
ZmQgZGV2aWNlIGZvciBhIFBDSSBkZXZpY2UgZnJvbQ0KPnZJT01NVQ0KPj4gKyAgICAgKg0KPj4g
KyAgICAgKiBPcHRpb25hbCBjYWxsYmFjay4NCj4+ICsgICAgICoNCj4+ICsgICAgICogQGJ1czog
dGhlICNQQ0lCdXMgb2YgdGhlIFBDSSBkZXZpY2UuDQo+PiArICAgICAqDQo+PiArICAgICAqIEBv
cGFxdWU6IHRoZSBkYXRhIHBhc3NlZCB0byBwY2lfc2V0dXBfaW9tbXUoKS4NCj4+ICsgICAgICoN
Cj4+ICsgICAgICogQGRldmZuOiBkZXZpY2UgYW5kIGZ1bmN0aW9uIG51bWJlciBvZiB0aGUgUENJ
IGRldmljZS4NCj4+ICsgICAgICovDQo+PiArICAgIHZvaWQgKCp1bnNldF9pb21tdV9kZXZpY2Up
KFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludDMyX3QNCj5kZXZmbik7DQo+PiAgfSBQQ0lJ
T01NVU9wczsNCj4+DQo+PiAgQWRkcmVzc1NwYWNlICpwY2lfZGV2aWNlX2lvbW11X2FkZHJlc3Nf
c3BhY2UoUENJRGV2aWNlICpkZXYpOw0KPj4gK2ludCBwY2lfZGV2aWNlX3NldF9pb21tdV9kZXZp
Y2UoUENJRGV2aWNlICpkZXYsIElPTU1VRkREZXZpY2UNCj4qaWRldiwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCk7DQo+PiArdm9pZCBwY2lfZGV2aWNl
X3Vuc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRldik7DQo+Pg0KPj4gIC8qKg0KPj4gICAq
IHBjaV9zZXR1cF9pb21tdTogSW5pdGlhbGl6ZSBzcGVjaWZpYyBJT01NVSBoYW5kbGVycyBmb3Ig
YSBQQ0lCdXMNCj4+IGRpZmYgLS1naXQgYS9ody9wY2kvcGNpLmMgYi9ody9wY2kvcGNpLmMNCj4+
IGluZGV4IDc2MDgwYWY1ODAuLjM4NDg2NjJmOTUgMTAwNjQ0DQo+PiAtLS0gYS9ody9wY2kvcGNp
LmMNCj4+ICsrKyBiL2h3L3BjaS9wY2kuYw0KPj4gQEAgLTI2NzIsNyArMjY3MiwxMCBAQCBzdGF0
aWMgdm9pZA0KPnBjaV9kZXZpY2VfY2xhc3NfYmFzZV9pbml0KE9iamVjdENsYXNzICprbGFzcywg
dm9pZCAqZGF0YSkNCj4+ICAgICAgfQ0KPj4gIH0NCj4+DQo+PiAtQWRkcmVzc1NwYWNlICpwY2lf
ZGV2aWNlX2lvbW11X2FkZHJlc3Nfc3BhY2UoUENJRGV2aWNlICpkZXYpDQo+PiArc3RhdGljIHZv
aWQgcGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKFBDSURldmljZSAqZGV2LA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQ0lCdXMgKiphbGlhc2Vk
X3BidXMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBD
SUJ1cyAqKnBpb21tdV9idXMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVpbnQ4X3QgKmFsaWFzZWRfcGRldmZuKQ0KPm5pdDogSSB3b3VsZCBkcm9wIHRo
ZSBwIGluIGFsaWFzZWRfcGJ1cyBhbmRhbGlhc2VkX3BkZXZmbi4gTWF5YmUgeW91DQo+c2hvdWxk
IGFsbG93IHRoZSBjYWxsZXIgdG8gcGFzcyBOVUwgZm9yIGFsaWFzZWRfcGJ1cyBhbmQgYWxpYXNl
ZF9wZGV2Zm4NCj5hcyBpdCBpcyB0aGUgY2FzZSBmb3IgcGNpX2RldmljZV9zZXRfaW9tbXVfZGV2
aWNlKCkgSSBtYXkgcmVzdWUgdGhhdA0KPmhlbHBlciBpbiBbUkZDIDIvN10gaHcvcGNpOiBJbnRy
b2R1Y2UgcGNpX2RldmljZV9pb21tdV9idXMNCg0KR29vZCBzdWdnZXN0aW9uLCB3aWxsIGRvLg0K
DQpUaGFua3MNClpoZW56aG9uZw0KDQo+PiAgew0KPj4gICAgICBQQ0lCdXMgKmJ1cyA9IHBjaV9n
ZXRfYnVzKGRldik7DQo+PiAgICAgIFBDSUJ1cyAqaW9tbXVfYnVzID0gYnVzOw0KPj4gQEAgLTI3
MTcsNiArMjcyMCwxOCBAQCBBZGRyZXNzU3BhY2UNCj4qcGNpX2RldmljZV9pb21tdV9hZGRyZXNz
X3NwYWNlKFBDSURldmljZSAqZGV2KQ0KPj4NCj4+ICAgICAgICAgIGlvbW11X2J1cyA9IHBhcmVu
dF9idXM7DQo+PiAgICAgIH0NCj4+ICsgICAgKmFsaWFzZWRfcGJ1cyA9IGJ1czsNCj4+ICsgICAg
KnBpb21tdV9idXMgPSBpb21tdV9idXM7DQo+PiArICAgICphbGlhc2VkX3BkZXZmbiA9IGRldmZu
Ow0KPj4gK30NCj4+ICsNCj4+ICtBZGRyZXNzU3BhY2UgKnBjaV9kZXZpY2VfaW9tbXVfYWRkcmVz
c19zcGFjZShQQ0lEZXZpY2UgKmRldikNCj4+ICt7DQo+PiArICAgIFBDSUJ1cyAqYnVzOw0KPj4g
KyAgICBQQ0lCdXMgKmlvbW11X2J1czsNCj4+ICsgICAgdWludDhfdCBkZXZmbjsNCj4+ICsNCj4+
ICsgICAgcGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKGRldiwgJmJ1cywgJmlvbW11X2J1
cywgJmRldmZuKTsNCj4+ICAgICAgaWYgKCFwY2lfYnVzX2J5cGFzc19pb21tdShidXMpICYmIGlv
bW11X2J1cy0+aW9tbXVfb3BzKSB7DQo+PiAgICAgICAgICByZXR1cm4gaW9tbXVfYnVzLT5pb21t
dV9vcHMtPmdldF9hZGRyZXNzX3NwYWNlKGJ1cywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBpb21tdV9idXMtPmlvbW11X29wYXF1ZSwgZGV2Zm4pOw0KPj4gQEAgLTI3MjQs
NiArMjczOSwzOCBAQCBBZGRyZXNzU3BhY2UNCj4qcGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3Nw
YWNlKFBDSURldmljZSAqZGV2KQ0KPj4gICAgICByZXR1cm4gJmFkZHJlc3Nfc3BhY2VfbWVtb3J5
Ow0KPj4gIH0NCj4+DQo+PiAraW50IHBjaV9kZXZpY2Vfc2V0X2lvbW11X2RldmljZShQQ0lEZXZp
Y2UgKmRldiwgSU9NTVVGRERldmljZQ0KPippZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4gK3sNCj4+ICsgICAgUENJQnVzICpidXM7DQo+
PiArICAgIFBDSUJ1cyAqaW9tbXVfYnVzOw0KPj4gKyAgICB1aW50OF90IGRldmZuOw0KPj4gKw0K
Pj4gKyAgICBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oZGV2LCAmYnVzLCAmaW9tbXVf
YnVzLCAmZGV2Zm4pOw0KPj4gKyAgICBpZiAoIXBjaV9idXNfYnlwYXNzX2lvbW11KGJ1cykgJiYg
aW9tbXVfYnVzICYmDQo+PiArICAgICAgICBpb21tdV9idXMtPmlvbW11X29wcyAmJiBpb21tdV9i
dXMtPmlvbW11X29wcy0NCj4+c2V0X2lvbW11X2RldmljZSkgew0KPj4gKyAgICAgICAgcmV0dXJu
IGlvbW11X2J1cy0+aW9tbXVfb3BzLQ0KPj5zZXRfaW9tbXVfZGV2aWNlKHBjaV9nZXRfYnVzKGRl
diksDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW9tbXVfYnVzLT5pb21tdV9vcGFxdWUsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2LT5kZXZmbiwgaWRldiwgZXJycCk7
DQo+PiArICAgIH0NCj4+ICsgICAgcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gK3ZvaWQgcGNp
X2RldmljZV91bnNldF9pb21tdV9kZXZpY2UoUENJRGV2aWNlICpkZXYpDQo+PiArew0KPj4gKyAg
ICBQQ0lCdXMgKmJ1czsNCj4+ICsgICAgUENJQnVzICppb21tdV9idXM7DQo+PiArICAgIHVpbnQ4
X3QgZGV2Zm47DQo+PiArDQo+PiArICAgIHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbihk
ZXYsICZidXMsICZpb21tdV9idXMsICZkZXZmbik7DQo+PiArICAgIGlmICghcGNpX2J1c19ieXBh
c3NfaW9tbXUoYnVzKSAmJiBpb21tdV9idXMgJiYNCj4+ICsgICAgICAgIGlvbW11X2J1cy0+aW9t
bXVfb3BzICYmIGlvbW11X2J1cy0+aW9tbXVfb3BzLQ0KPj51bnNldF9pb21tdV9kZXZpY2UpIHsN
Cj4+ICsgICAgICAgIHJldHVybiBpb21tdV9idXMtPmlvbW11X29wcy0NCj4+dW5zZXRfaW9tbXVf
ZGV2aWNlKHBjaV9nZXRfYnVzKGRldiksDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpb21tdV9idXMtPmlvbW11X29wYXF1ZSwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGRldi0+ZGV2Zm4pOw0KPj4gKyAgICB9DQo+PiArfQ0KPj4gKw0KPj4gIHZvaWQgcGNpX3NldHVw
X2lvbW11KFBDSUJ1cyAqYnVzLCBjb25zdCBQQ0lJT01NVU9wcyAqb3BzLCB2b2lkDQo+Km9wYXF1
ZSkNCj4+ICB7DQo+PiAgICAgIC8qDQo+VGhhbmtzDQo+DQo+RXJpYw0KDQo=

