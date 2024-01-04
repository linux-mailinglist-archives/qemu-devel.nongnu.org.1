Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D38823A64
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 02:55:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLCvy-00066X-S4; Wed, 03 Jan 2024 20:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rLCvw-00066O-Qh
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 20:54:08 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rLCvs-0001Gu-Tk
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 20:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704333244; x=1735869244;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vmkWYgXwoY3kvlEsiLIy7N6feCAR0g+1OLm31Pdk3fM=;
 b=gW1k4yLarjOBmWodrK3xonY03RmX8bZpkSJuh+wuTKaAk8v8DXgZoFYW
 sDMcHsY06gWI9BmEKMXXECHeboFvdJMsDAg6T/9I6tmD+fFmOIUVHOIyx
 XtRh1+ScfwirfxF+oOPoHIg6HZCdOxXlYB1uELRTb70ZRP9PWP8cxho/M
 d1IM7rKFCmy8bUMp4dH5VHbZXCdjebfl1xFJIZNI7MpGahrjuFdDSUvfY
 xJEPWaFxr7BQhZb7DBmsdZz4YbHPqmiSRITg3jHxzPQdyyIk5AxNE6sck
 Y6b6rnlMxXZfEf28DMjakqRsHTLIOaXWCaid30yJSlt0trusfSlWaErK/ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="387566290"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; d="scan'208";a="387566290"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2024 17:53:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="1111551658"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; d="scan'208";a="1111551658"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jan 2024 17:53:51 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 17:53:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 17:53:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 17:53:50 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 17:53:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9yjYqhARLo4FCN85bEk0DmoyTlMv9o8Cj/Na/B/vTsfBXzr+TfA8n857DpRyI1gzKdrVsJBVltxU0sXBMou+Vjs8wQ+ZxYUKPCiesqd4Fb/t9C33gYgM2rRmuDx8j76Qsq8rlRjKS5W2KULxFAqqZLLdQboLSst7zHQN23pJF4gQB1lLcTKwL0fKICL5tcHUROYffKIl4/zuaKDAt4v9Z9zJ0neWelfUHaP/+dqLJ2wScXy0/IK3Gp47tyYUQ0YbNdThSsXmndR28I+JxvUYOdpzyfi1SEcddGQuIkY058osZOPhL1bpcWyCdnPFCARkS5zvtttaTOdiBffck0smA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmkWYgXwoY3kvlEsiLIy7N6feCAR0g+1OLm31Pdk3fM=;
 b=e4vGv7X2i7bfPKFQajN7Ka4dpQkJR57V+IM0ABQfTpkZV4RImk8GRDISlEe8+79dsMlzfhWsBfXEXZ1D+5qxlZjw1iy46yE+fqNhYay3eXFGorTFmy4Rf1Tt6ZOLXN6QpZczB6CFmRxe4YPFrZicAOXZlk3x+hqffzeRldbxzhJKrfCenNbv0liCgPaWxA++MYQhiEYqgPqoV3l18+VkylkMGZvZ89l87O8OwtdUaD5KPNGwfxDoKhFJ8eVWTjC/MWMdeOS/v79FEykTPTUG/xHwte97HD0MPZI0AlH462+TtwUd1pavxN1ZYgih6nCqEDOBExTxY2ovUeSoxWS9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5940.namprd11.prod.outlook.com (2603:10b6:a03:42f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Thu, 4 Jan
 2024 01:53:48 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%4]) with mapi id 15.20.7135.026; Thu, 4 Jan 2024
 01:53:48 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH 1/2] backends/iommufd: Remove check on number of backend
 users
Thread-Topic: [PATCH 1/2] backends/iommufd: Remove check on number of backend
 users
Thread-Index: AQHaPXfBokplEuoqS0imKe8596uEI7DHTVQAgADNewCAAMtfkA==
Date: Thu, 4 Jan 2024 01:53:47 +0000
Message-ID: <SJ0PR11MB6744E2CA117219F50FCF37A09267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240102123210.1184293-1-clg@redhat.com>
 <20240102123210.1184293-2-clg@redhat.com>
 <SJ0PR11MB6744F8F025A15F98773483E99260A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <17266259-b7ac-4a76-9939-1bd244d43130@redhat.com>
In-Reply-To: <17266259-b7ac-4a76-9939-1bd244d43130@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5940:EE_
x-ms-office365-filtering-correlation-id: f0e2ec16-ec5f-41e3-4ef7-08dc0cc7fe14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lmcs756W74lEN2/JixiSPuMHFvZLA7hFOy7iYN+ZIk3ECzKR1Ny3TYpRUeHdImwcl5WNeUAucYgdN7kCB19RYwAezKrd+PGMUTocIr9UzyB7vCYVEIalcS1Pr4YigSW6eCQ16AmOPKG7pQ/A2xYAQQODjX/9D1tZy896gLSZCfoyqYCM1ei9C63/IWslcXWQRCCMOd/G4+eQbcGBsBJlz69F+uRyLY2eEzaNPyewsiiWfWVBS6SW0Z6e2TXRPCkPi71TDRpSYC3H+3LClYiAr5bytrW4/KQOoZkmDk5wifNdy43cPfHQv1azwGO5cUXbplCA7NXoWiah01XwBQKdpWcgv4RfJUNlBvGWsI2WqNpXGlU6hDrot3ivoVCVLYfUoFjf1z+hnP7wHAxrRhw2eRJirX/yiH234ZhWAkH8JPqXTs1UcBXKxztZUMGMt2TwLToApc8nKkT9z/RXV7c0BeONmlvr6S9rdYzFmjxGHrxD0Dfg913E9heLuMnAhqp4AZgDCxQeZqnsaL/JEeFaqQGE3lsXYaUXbYY9RPmbo0URpUjJZjoDoPkr1s7X5nKw5K68gRy/ha6cizhnmeOkq4hugHiaQTI7ekpxJAXBSqHhUqAgqfkSCWExpNHS0qO2P0VRJv/b78uB/WCIxjFESSNxhTewFUTlFNm0PACfgfRV8pu3ZPL92l9lN6AavfgR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(366004)(136003)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(53546011)(66446008)(71200400001)(66556008)(64756008)(66476007)(9686003)(6506007)(7696005)(110136005)(66946007)(76116006)(316002)(478600001)(54906003)(8676002)(8936002)(38070700009)(5660300002)(4326008)(52536014)(86362001)(83380400001)(122000001)(55016003)(66574015)(38100700002)(26005)(2906002)(82960400001)(33656002)(41300700001)(26730200005)(19860200003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emloUm9Sc2pVVXFZMlh4VHJ4UmV2cFU1VkEwZ1F3cXVmSVpnd1pwU29UMUVa?=
 =?utf-8?B?V3NOVnRmZ0lrRER2OTh4V0FtSDNITHl2VDNhY3UxSnpiTTcyT2JkVi9mRjhM?=
 =?utf-8?B?amM1MWFwOVdNRmhXL0swNzRKS2orcWIwdWt3R25GNGx6OEJTcjBZVTNaNVpr?=
 =?utf-8?B?RmRNUEUvbmk5VURuWkVkNjZkakZ5WmEzdHY3dEJvd3labFhUbmc1Wk91TG9o?=
 =?utf-8?B?V0lOTlFWc0JtOWlFOVd2S205NXgrM1JTSkpxNWhDcGE4c2ZvL0JXN0haVEU1?=
 =?utf-8?B?Yy8ycVRtZE5XNFd4KzNFQlhxaE9MQ1U1SmxScS8zdkY3WjJDY0lCM3RleDdN?=
 =?utf-8?B?cnh4TDdRM1pta2xBWXBkaSsyS0NqdExIc1VJTGhMdVl6ZGxxUjJmeWFlQlNM?=
 =?utf-8?B?Z3I0Z1p1MVEzaXRzcmNzRE5GcmFKLzZQMkNIeC9RVnk0SHh3S1orUURwSDA3?=
 =?utf-8?B?c3pRV1Y3NmdHc1NLMjAvK0pEeTJaQmt2THdLcS9FUE80Y0dEUnhldHcwNWM4?=
 =?utf-8?B?ODZOaFRCYlJsVkE4NXloQzBXVVNHdUpoZy9WcDJqbGF4YmZTTVFmY3pSM0F1?=
 =?utf-8?B?a0tPb2FEYXczamlDTXg5MWR1ZWhnQjJKTU9OeE5Da2pRNnkxa2dweDNwOTZQ?=
 =?utf-8?B?bUZQdXBkelZaZE9UWUJLUE84aXVrUTZrd1RvNE9PZWxMVVU1K2h5NERsOGt0?=
 =?utf-8?B?dDhLSXNvOHFSdmhwU0t2UnlwVzFPcWlZNk5IS0pnNHlMK0VMMnZpNGEwUHNl?=
 =?utf-8?B?elQ3WmNPVHpmdWQ0NlFkWDNhQlRCek0xNHZ0RjNJbzA1RjBVQnpaUjZvaVQ3?=
 =?utf-8?B?eDBlQ2t2bWFkT0dMS241SVkrTkFGU0w1SGM0Q2MzazY5QUgxYjhWeE8yanRQ?=
 =?utf-8?B?VllDZFdvQ3oyb0YxMlpDVHhtWEFhUGlBQ2trREZWcFFjMFJVYmorTFM4MXhj?=
 =?utf-8?B?OWdqOXlxWkROOVlUcHV5WUxDMDk0MzZVdGdndUwrUXJkbnFGcUVpOVhjS2tp?=
 =?utf-8?B?dk9jMFNvcmRWdmZrZ0plaUVZc3A3L0k3ZEpFaFZtcXp2UFZYaFpSMTcwaDhx?=
 =?utf-8?B?Ry84T2JNd2xYaEc4dmRqNmRsMllxZDRDTFUxQ0pjZk9Lc2tGanZFcnQwVnVS?=
 =?utf-8?B?RkRweFltR0JIOVVOWGVleW5hQkdKQ0VialhyK2VUNmFSRDZYb1ZGU05hc1Ro?=
 =?utf-8?B?L0pEazVrSitkSEcrN1RYRUN2OEtwbjBCeUg1cUlQYjZGV1FmZVVlRFJhdE9x?=
 =?utf-8?B?T2FWMnhJRndXdm12aGNPaXpFS3htd1dWNVN5cXRJTG43SnErWHI5RHZtT3B4?=
 =?utf-8?B?K3NqOWRGQUplYmJ2M1M4VUpIN1hIQ3lqN2lhSU8zZE9tSSt3dEplOXdKRHVD?=
 =?utf-8?B?aUpWVVErRWhKa0tOL2FPbTgzVVlNZ21nY2RacFh5a1JwbGMvb29BeW1ld2xS?=
 =?utf-8?B?dWFxeXVRSjdHYkFKYlBabnJuTHhtVVlxamxxbjk3Z1dsaTlRN1lsYWkwalgw?=
 =?utf-8?B?UFhLVm13VlNVSU1PbHhVZ0NTbjlZNmR2dldNMjZPSS9Id0ZGVE83dFQ3MTdI?=
 =?utf-8?B?UERrOUMxdTFZRDFEbXdHYXQ5UzRRb3V6Ym50bTdGL0xST0tlQzZpaklsc0NM?=
 =?utf-8?B?U3Fxd2xOVHU3L0FlSzJ3Kys2eUptNlVBanNsZG4wZVp4Z05UKzNBMlBoK25M?=
 =?utf-8?B?Q3M4a0VUTlVQaWRuUWpWdlIrTFVyVmthSWpOV0F6UWY4VkV0dGtZYUxJSDN0?=
 =?utf-8?B?VEVjVS9FYnk4VXZFZCtuWmc0MXczY0o2OFZNb05xYVExa0p6MXU1T0FiWGdN?=
 =?utf-8?B?dFRyeWJFcXU3TXhSZWFZZzAvSSsxWmNuVDJTMUhmcDUvV3RSNkdZOSs4WHJl?=
 =?utf-8?B?SStacjUwRnRwK1lOY1VTMFBCbXAyRVlFbG9LSTBTRjNRNWdabHAxMVZOMTk5?=
 =?utf-8?B?Ritqc1VXNkFGOGlEMHR3TmRKc0J0K2hKVlUwVWpTZWNMUmt1b3d1RWl6UDFq?=
 =?utf-8?B?Y0NkTTNGNjhDeDRoNGhPUUM4ZkN4bE9HWXNkTkFYVyt1QUtiOVdXbXg4bTho?=
 =?utf-8?B?MVVoRlBWd1NLeVQwVXRydGVMTXI2dVBsSm5ERjN4blJLVzA1MWhNeERGZ0wy?=
 =?utf-8?Q?NwVTrTtDrq9B8sCOY5NRrIZwp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e2ec16-ec5f-41e3-4ef7-08dc0cc7fe14
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 01:53:48.0295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NgtbdVJwJ1eJ5KBCa4mG/m6xg9GLUD0Qudn0rCOp+274G+BnG+xoVQ+wWxLAkZju4PjNMevh30StOSkUcse/xWIWAukDgIvM4cHp/gSVqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5940
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gYmFja2VuZHMvaW9t
bXVmZDogUmVtb3ZlIGNoZWNrIG9uIG51bWJlciBvZg0KPmJhY2tlbmQgdXNlcnMNCj4NCj5IZWxs
byBaaGVuemhvbmcsDQo+DQo+T24gMS8zLzI0IDAyOjQwLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6
DQo+PiBIaSBDw6lkcmljLA0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+
IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+PiBTZW50OiBUdWVz
ZGF5LCBKYW51YXJ5IDIsIDIwMjQgODozMiBQTQ0KPj4+IFRvOiBxZW11LWRldmVsQG5vbmdudS5v
cmcNCj4+PiBDYzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+OyBFcmljIEF1Z2VyIDxl
cmljLmF1Z2VyQHJlZGhhdC5jb20+Ow0KPkR1YW4sDQo+Pj4gWmhlbnpob25nIDx6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb20+OyBDw6lkcmljIExlIEdvYXRlcg0KPj4+IDxjbGdAcmVkaGF0LmNvbT4N
Cj4+PiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBiYWNrZW5kcy9pb21tdWZkOiBSZW1vdmUgY2hlY2sg
b24gbnVtYmVyIG9mDQo+Pj4gYmFja2VuZCB1c2Vycw0KPj4+DQo+Pj4gUU9NIGFscmVhZHkgaGFz
IGEgcmVmIGNvdW50IG9uIG9iamVjdHMgYW5kIGl0IHdpbGwgYXNzZXJ0IG11Y2gNCj4+PiBlYXJs
aWVyLCB3aGVuIElOVF9NQVggaXMgcmVhY2hlZC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEPD
qWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+DQo+PiBJSVVDLCAvZGV2L2lvbW11
IGlzIG9wZW5lZCBvbiBkZW1hbmQsIGJlLT51c2VycyBpcyB1c2VkIHRvIGNhdGNoDQo+dW5kZXJm
bG93DQo+PiBvciBvdmVyZmxvdyBkdWUgdG8gbWlzbWF0Y2hlZCBpb21tdWZkX2JhY2tlbmRfY29u
bmVjdC9kaXNjb25uZWN0DQo+PiBwYWlycy4NCj4+DQo+PiBJdCBsb29rcyBkaWZmZXJlbnQgZnJv
bSBvYmplY3QgcmVmIGNvdW50IGluIHB1cnBvc2UsIGJ1dCBJIGFncmVlDQo+PiBhIGNvcnJlY3Rs
eSB3cml0dGVuIGNvZGUgd2lsbCBuZXZlciB0cmlnZ2VyIHN1Y2ggb3ZlcmZsb3cvdW5kZXJmbG93
Lg0KPg0KPldlbGwsIHdlIGNvdWxkIGxpbWl0IHRoZSBudW1iZXIgb2YgZGV2aWNlcyBzaGFyaW5n
IHRoZSBzYW1lIGlvbW11ZmQNCj5iYWNrZW5kIGJ1dCBVSU5UMzJfTUFYIHNlZW1zIHJlYWxseSB0
b28gbGFyZ2UgYW5kIHRoZSBvYmplY3QgcmVmY291bnQNCj53aWxsIGZhaWwgZWFybGllciBhbnlo
b3cuIFRoZSBtYXggb3BlbiBmaWxlcyBwZXIgcHJvY2VzcyBsaW1pdCB3aWxsDQo+YWxzbyBiZSBy
ZWFjaGVkIGJlZm9yZSwgc2luY2UgdmZpbyBvcGVucyBhIC9kZXYvdmZpby9kZXZpY2VzL3ZmaW94
DQo+ZmlsZSBwZXIgZGV2aWNlLg0KDQpDbGVhciwgdGhhbmtzIEPDqWRyaWMuDQoNCj4NCj5Tbywg
dGhpcyBjaGVjayBkaWRuJ3Qgc2VlbSBuZWNlc3NhcnkgYWZ0ZXIgYWxsLg0KPg0KPj4gU28sIGZv
ciB0aGUgc2VyaWVzOg0KPj4gUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb20+DQo+DQo+WW91IHNob3VsZCByZXBseSB0byB0aGUgY292ZXIgbGV0dGVy
IHdpdGggeW91ciBSLWIgdGFnIHNvIHRoYXQNCj5pdCBhcHBsaWVzIG9uIHRoZSB3aG9sZSBzZXJp
ZXMuDQoNClN1cmUuDQoNCkJScy4NClpoZW56aG9uZw0K

