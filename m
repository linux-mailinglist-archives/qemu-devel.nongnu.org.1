Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE90083119E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 04:00:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQIcf-0006cm-71; Wed, 17 Jan 2024 21:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQIcc-0006cW-PF
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 21:59:15 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQIcZ-00017y-2U
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 21:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705546751; x=1737082751;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uDJmPsLcjwzyF6BwegI6wC1B+nx6+gJ1uO2s3pXdi1o=;
 b=apDM0HLkhfD/RbOresvPhOLn2M/ANl6bH1XLCJmmYkzrH/Wk/iCvhXHU
 r5kZGwnH1j08rZGF+TSu3n01sUlpjakSFer4fSyx0Qc4wdl8BvtVwt2da
 ba+4QO1sk0VfjsaEkFdkPiJvbKIpNTAFTa2dLkXY7q9hozXrRpV1klSsb
 z7lMlYge8QMGE+Dhu9d9Oa++Ds1sOd1VVenrxF+QjS8CeVuJf5Vql7d6O
 YlM5eSbTq7R4H5mr7SZO7kz+BhH/lKn70A1ahc4JMppcZZOz32Zu8Jnkq
 lcm8nTCqrbgRf8Kt3tJPg5ZrYzQs57u6GZ6iP9L6E6EWLdIPlfndJbP2C A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="21817428"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; d="scan'208";a="21817428"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jan 2024 18:59:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="818672693"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; d="scan'208";a="818672693"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Jan 2024 18:59:02 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 18:59:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 18:59:02 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 18:59:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOIXQm7AxS+4dQtRmfglsJxSPcbvEHgGSr+Nk5iR95pWTKb9I8oEBMTgnOFkj/hRu278HBDQdLKj+JOTbtTe5oI6RrIdNE7HeJt92BYuQV5PNjEScXDvVE3/vSpI53dAReNATmtq8ot1cIEMIa2++zY2frQk0Uz1EF4eSlP3UVmO9d7C5xko2gNYp3fHOO6ppydUqADntZwJ+1RKGIIr3U4HrVaM4ervkkHXX4Z4wojkWQsMFccUHxdhcKBh7Q5jVcRiXjaULPQCaBZ8JgD659cWs+9bid1aSZaGRUV/MfZVNolOhIvUCqD7B0UYHYlZS2n4Zsg/qmOsLfqkSKUtRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDJmPsLcjwzyF6BwegI6wC1B+nx6+gJ1uO2s3pXdi1o=;
 b=D8SefgoQH/mBFHCr9wM5vOAYfRe7LX4sDB6DJDZR20LB2IgQWqJPqX3bME11dMS2yolhCqyciNk5Gf0IvrC5qGfwTUssYUceZJ2fPXAsZoyPjFS2MLvCqMzLNzodyw7FDQDUYTzoKljQMCU4/l27yh9mujGugKfUkyPAqYVSszGxsJut83OrCJFXtsdMX1PAfz0j+ZeO6k8PITaQng1gUNgKZPkxKzSTKpFvIiGiZqaocyaQLescVTe8+uH5/XDCqZlbOT4rtTQLr/IBRrw7WnphDIY+urYXukbXnI2IIGDGJuGUoM7fTYt3DotN8BYpI2tefeaTEKeHT6QiOMcIOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB7615.namprd11.prod.outlook.com (2603:10b6:510:26e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 18 Jan
 2024 02:58:59 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%5]) with mapi id 15.20.7181.020; Thu, 18 Jan 2024
 02:58:59 +0000
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
Subject: RE: [PATCH rfcv1 1/6] backends/iommufd_device: introduce IOMMUFDDevice
Thread-Topic: [PATCH rfcv1 1/6] backends/iommufd_device: introduce
 IOMMUFDDevice
Thread-Index: AQHaR5vs9PoNqR9b3kO5arx2FhNKM7DeDuKAgADUeGA=
Date: Thu, 18 Jan 2024 02:58:59 +0000
Message-ID: <SJ0PR11MB6744B2E248E84AD11BFDBE8892712@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-2-zhenzhong.duan@intel.com>
 <866c6343-054c-40c7-b331-b41497f5610b@redhat.com>
In-Reply-To: <866c6343-054c-40c7-b331-b41497f5610b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB7615:EE_
x-ms-office365-filtering-correlation-id: 6cd2c51c-02f7-49f1-ead4-08dc17d16b35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HYHOkeogncjstu+sALyHC1P0LXDXuwd/nKaEqenb/T7/HDO62agYC2QJw1AIm5g/5JW7/sZMMVRaojKSSR6SuMl7C0AtmDOl64V1LUpf2ouX22oCdINixHo2d7FhzoP6xXzVSLUbc5a8mGMasWMau1Xu/SxMfERlVaO1APVZgSWEEzxJ/i+K/RmcTCTXQxIN6gSQ+BNyEGh9lwWasocgnUEWHmmQymAGmz2G8tYtFHKl71zzqNMOOAVoTcLseDAzgJr0Ieht3ZRS2HWE5Beknq7feKLeiFVj4LTLvoTl94ZO93x0qZGZmHQumTRl2c7uhTMh1wjuPmpdjGGPsAXMDdapsQG/2s118CYJ5z+0NhoCskhhIiHnkW25tFK3Rfy7qgf7GFEahAtLgIDoyVQJ1DwXfUdBQfRrJ5+nsgkKLOaxnpg7qTz+RB75O2qS4INlX4wcyv7CfsT4HaRC9F3SblYzn2Nyd5W8xqmdmUxX5EZIHSI1lCzLQJiuI2wUD4gWz+tTLeeSSwohVEMyE3TBdyCI4ItfgG0eClkas7riW8WKGzCJuP/aEwNi08E1vMpIZ6Oi1P6EQJhgkr1pmnrRBwgxpI7AhgOkWLVfaJGudfO33bPR6LjsgWdzJFO7ND+C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(110136005)(55016003)(86362001)(33656002)(38070700009)(82960400001)(66476007)(4326008)(38100700002)(7696005)(2906002)(8676002)(71200400001)(6506007)(83380400001)(26005)(122000001)(64756008)(316002)(9686003)(66946007)(66556008)(478600001)(5660300002)(41300700001)(54906003)(66446008)(76116006)(7416002)(52536014)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGNGQzBPcFhuV0pZK3lVdGFUeXBRVGhRV0dYS3RYajZkZEdvMy9ESVd6UXJB?=
 =?utf-8?B?YVhmbzIrZ2FiakFlN1hsN0Y0cDdsd0dJMnlsc1dyV0YrNUlJV0Yya0E0MjVR?=
 =?utf-8?B?VHJkaklhSFU5aE1jbjdQOEhjaGIvVHk0cmxsZmw1elJSM0J1aWQrMjBIaDRN?=
 =?utf-8?B?RnQyTW1DMTUydFhpRTYrb0xmUGJSbU5LOUk4Nk5ORnNiK2xZaG1Sc21PemZ1?=
 =?utf-8?B?am1TQVdPSHdkSGhScno3bnpXcmt0enk5RG5wY1JsQ0ZlVTVXUjBZbnR0Qjk0?=
 =?utf-8?B?dWdoNUo0UnJjUUVzZG5ONlVKWmNvUFRMMnFxY016Y2h6OG5SSjMzaitkN0pO?=
 =?utf-8?B?N3I2bWtveUlRQUNZdkZLYWZJTXdkK0dYOGR1amFvckN3QSt1ZG9hamtHVEtn?=
 =?utf-8?B?WmhKbWswVGlnTjlPOWFLaURZeWFJd0RSQnF4dFV0aVdidFRiRFFvNjl2d2Nr?=
 =?utf-8?B?N1kvWGZtU0o0R3k5Y1pYOGtGUytqZU1qWkNVTFZvRGQ1WFErMDY1b3daVWgw?=
 =?utf-8?B?RE85WW1TbXFia0dycU9Td1BaSkVXNW95ZWZHd0UyNXpBVUtxMC9GK0FraG9W?=
 =?utf-8?B?RTNMU0lqNnpTcDA1bG9ML0U3dm15cWxDS000RGdMOXM4Z25zWXdWT0pZS1FC?=
 =?utf-8?B?b0ZQR1JlTjR2bUw4cHArbmdUL0Z5V0hEckJQa3Y3MGNWUnIrZkc0TEVLOEVB?=
 =?utf-8?B?bi9qbDZVbFAyWGR6c0tNTjk2NnJ6VWdRYjhmK2tJSzRUR3FhY1JMblFiNDg1?=
 =?utf-8?B?SVlMMkE0bUpoQVVLTlFhZm9pai9Pa2tuQnNMekZ3MmhaS0g0UmlJK3N4Qkw0?=
 =?utf-8?B?YWxUMXJnZUpiOEREdC8rbTRaZ0lVVlArNTFPaFFKUWMyQ203MVNhT3o3dHdw?=
 =?utf-8?B?MllRdUdnNHlIaERESEFDVFoyaXRXYzZ0Mk1qVXBRSytZVDA2YThzR1YrYXEv?=
 =?utf-8?B?aDM1SUJUeE9OYncyRmRxS3lsYXVrSXJQRG93YXZvRDhPZmZLVVR3RVY5cndW?=
 =?utf-8?B?RDAxSG11L0t5bFlGYXdiS290bERYOXU2UU5iRjNHMFBTTzdMU09LVitrWmtn?=
 =?utf-8?B?Wmk4YlZ5dDhTc3o3S2tLYTNZK3JKcjBqVTdkS1ZOTGtsM3dXMnc2VEg3eDFB?=
 =?utf-8?B?UUptam10a0k5bUZiVUhPYkdrcGZIL0kyd1BWUENBb2N4dHg1ajZxOHlaR2dJ?=
 =?utf-8?B?MmprNlAvVEtnVk9ETkk5N01wd05STWw5VXYvREltTnZ1VU9sOUhlTzZ6ZWcz?=
 =?utf-8?B?dkRTZUZsNDlWR2llQUdVdWR6aHM4TE9uVml3QklmQ1RQK0lzMXF4MlhrM3Uv?=
 =?utf-8?B?c3I5dkxOZVk0Ry9kWjhnaVp4TTNoUkVyQzY0OGJPbXFmZVhoR2tPSWJqTG9B?=
 =?utf-8?B?V054Wk5LYyt0SjhGZjEwNXljUXEyYWJ5VUpZRFJWN2dQaWVWV2JmMGZNYnlH?=
 =?utf-8?B?UFdxT3hNUFNHT3YxemQ3SDcxelNRY3hzQS9ic3VBOEVXbTZNVWV3b0dCb09M?=
 =?utf-8?B?VHY0NU1lQjFCaEZqU2xXaWc4L0ZSRXJFYktoVUxzdUN0VVJ6OWl5MVhJUmZi?=
 =?utf-8?B?T1BNQ3JqNkVvVVR6RUIvM1FCMGhOZi9lbzA0SHBFK1B5M0M0R1pvYnN3MVpq?=
 =?utf-8?B?VWMybWd5M3dEdlZqNG9JV0Q0aGxLZ3hENCs3c1NVTWwzN3JQRStGbzlOQTRB?=
 =?utf-8?B?MXNtVVZ5NFBzakViMHlGYXo4Z1UwOTVyMHE4a0N1WEM5Y0t0QmxiZzRCZFZV?=
 =?utf-8?B?aGE4TzJtRVZqdUZLdnpmaHJUeGx3VnVPR1RSUWlQRGdqWm41cEFJRjYwRmoy?=
 =?utf-8?B?SURCSFdIY3M1WnZMak1uTWJqZTFqQklvYm1Ga0E1dHMxWjdveG1sdlZDQTZw?=
 =?utf-8?B?VkF1Unl0eFpFQ2ZOZDB2Qk9UNkVZc0NPU3Jhb1QzUC9ENTlncDViOU8xaDc0?=
 =?utf-8?B?MmVIWFc5Tk1SQTFEZ1ppN0NqVkZqUExSVGI0M0pKSDdXb3hlQ1EwTUpJWGxo?=
 =?utf-8?B?WFhjN1ROVkV5SUFaZFk3TXR1NjhPZGIrK0lnR0p0bmVCaEsrL1RaYmVlTVNr?=
 =?utf-8?B?SHhlUkZ1YnBTc2FMVEVtSXcyWWk2d0NDZnJ0QWx2aEg4Q1VLVDZpRFZtOFgr?=
 =?utf-8?Q?r+Owcuw4Tpb0FGEniu/fKnEKI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd2c51c-02f7-49f1-ead4-08dc17d16b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 02:58:59.3569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fyb3K0sZeYzrz7BrLJfB02ZsjbFSWWX2AWFbZ129EJK/+Tk6PMyZIwQS3v0VYMWqmiGKUAFmaPolujT7w8WxPCuHluZQ4NKn5lpTZF2nICM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7615
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDEvNl0gYmFja2Vu
ZHMvaW9tbXVmZF9kZXZpY2U6IGludHJvZHVjZQ0KPklPTU1VRkREZXZpY2UNCj4NCj5IaSBaaGVu
emhvbmcsDQo+DQo+T24gMS8xNS8yNCAxMToxMywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBJ
T01NVUZERGV2aWNlIHJlcHJlc2VudHMgYSBkZXZpY2UgaW4gaW9tbXVmZCBhbmQgY2FuIGJlIHVz
ZWQgYXMNCj4+IGEgY29tbXVuaWNhdGlvbiBpbnRlcmZhY2UgYmV0d2VlbiBkZXZpY2VzIChpLmUu
LCBWRklPLCBWRFBBKSBhbmQNCj4+IHZJT01NVS4NCj4+DQo+PiBDdXJyZW50bHkgaXQgaW5jbHVk
ZXMgaW9tbXVmZCBoYW5kbGVyIGFuZCBkZXZpY2UgaWQgaW5mb3JtYXRpb24NCj5pb21tdWZkIGhh
bmRsZQ0KPj4gd2hpY2ggY291bGQgYmUgdXNlZCBieSB2SU9NTVUgdG8gZ2V0IGh3IElPTU1VIGlu
Zm9ybWF0aW9uLg0KPj4NCj4+IEluIGZ1dHVyZSBuZXN0ZWQgdHJhbnNsYXRpb24gc3VwcG9ydCwg
dklPTU1VIGlzIGdvaW5nIHRvIGhhdmUNCj4+IG1vcmUgaW9tbXVmZCByZWxhdGVkIG9wZXJhdGlv
bnMgbGlrZSBhbGxvY2F0ZSBod3B0IGZvciBhIGRldmljZSwNCj4+IGF0dGFjaC9kZXRhY2ggaHdw
dCwgZXRjLiBTbyBJT01NVUZERGV2aWNlIHdpbGwgYmUgZnVydGhlciBleHBhbmRlZC4NCj4+DQo+
PiBJT01NVUZERGV2aWNlIGlzIHdpbGxpbmdseSBub3QgYSBRT00gb2JqZWN0IGJlY2F1c2Ugd2Ug
ZG9uJ3Qgd2FudA0KPj4gaXQgdG8gYmUgdmlzaWJsZSBmcm9tIHRoZSB1c2VyIGludGVyZmFjZS4N
Cj4+DQo+PiBJbnRyb2R1Y2UgYSBoZWxwZXIgaW9tbXVmZF9kZXZpY2VfaW5pdCB0byBpbml0aWFs
aXplIElPTU1VRkREZXZpY2UuDQo+DQo+K8KgIGlvbW11ZmRfZGV2aWNlX2dldF9pbmZvIGhlbHBl
cg0KDQpXaWxsIGRvLg0KDQo+Pg0KPj4gT3JpZ2luYWxseS1ieTogWWkgTGl1IDx5aS5sLmxpdUBp
bnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVs
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBp
bnRlbC5jb20+DQo+PiAtLS0NCj4+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgIHwg
IDQgKy0tDQo+PiAgaW5jbHVkZS9zeXNlbXUvaW9tbXVmZF9kZXZpY2UuaCB8IDMxICsrKysrKysr
KysrKysrKysrKysrDQo+PiAgYmFja2VuZHMvaW9tbXVmZF9kZXZpY2UuYyAgICAgICB8IDUwDQo+
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgYmFja2VuZHMvbWVzb24uYnVp
bGQgICAgICAgICAgICB8ICAyICstDQo+PiAgNCBmaWxlcyBjaGFuZ2VkLCA4NCBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3N5c2Vt
dS9pb21tdWZkX2RldmljZS5oDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJhY2tlbmRzL2lvbW11
ZmRfZGV2aWNlLmMNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVS
Uw0KPj4gaW5kZXggMDBlYzFmN2VjYS4uNjA2ZGZlYjJiMSAxMDA2NDQNCj4+IC0tLSBhL01BSU5U
QUlORVJTDQo+PiArKysgYi9NQUlOVEFJTkVSUw0KPj4gQEAgLTIxNzEsOCArMjE3MSw4IEBAIE06
IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gIE06IEVyaWMgQXVnZXIgPGVyaWMuYXVn
ZXJAcmVkaGF0LmNvbT4NCj4+ICBNOiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPg0KPj4gIFM6IFN1cHBvcnRlZA0KPj4gLUY6IGJhY2tlbmRzL2lvbW11ZmQuYw0KPj4g
LUY6IGluY2x1ZGUvc3lzZW11L2lvbW11ZmQuaA0KPj4gK0Y6IGJhY2tlbmRzL2lvbW11ZmQqLmMN
Cj4+ICtGOiBpbmNsdWRlL3N5c2VtdS9pb21tdWZkKi5oDQo+PiAgRjogaW5jbHVkZS9xZW11L2No
YXJkZXZfb3Blbi5oDQo+PiAgRjogdXRpbC9jaGFyZGV2X29wZW4uYw0KPj4gIEY6IGRvY3MvZGV2
ZWwvdmZpby1pb21tdWZkLnJzdA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvc3lzZW11L2lvbW11
ZmRfZGV2aWNlLmgNCj5iL2luY2x1ZGUvc3lzZW11L2lvbW11ZmRfZGV2aWNlLmgNCj4+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwLi43OTU2MzAzMjRiDQo+PiAtLS0g
L2Rldi9udWxsDQo+PiArKysgYi9pbmNsdWRlL3N5c2VtdS9pb21tdWZkX2RldmljZS5oDQo+PiBA
QCAtMCwwICsxLDMxIEBADQo+PiArLyoNCj4+ICsgKiBJT01NVUZEIERldmljZQ0KPj4gKyAqDQo+
PiArICogQ29weXJpZ2h0IChDKSAyMDI0IEludGVsIENvcnBvcmF0aW9uLg0KPj4gKyAqDQo+PiAr
ICogQXV0aG9yczogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiArICogICAgICAgICAg
Wmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+ICsgKg0KPj4gKyAq
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+PiArICovDQo+PiAr
DQo+PiArI2lmbmRlZiBTWVNFTVVfSU9NTVVGRF9ERVZJQ0VfSA0KPj4gKyNkZWZpbmUgU1lTRU1V
X0lPTU1VRkRfREVWSUNFX0gNCj4+ICsNCj4+ICsjaW5jbHVkZSA8bGludXgvaW9tbXVmZC5oPg0K
Pj4gKyNpbmNsdWRlICJzeXNlbXUvaW9tbXVmZC5oIg0KPj4gKw0KPj4gK3R5cGVkZWYgc3RydWN0
IElPTU1VRkREZXZpY2UgSU9NTVVGRERldmljZTsNCj4+ICsNCj4+ICsvKiBUaGlzIGlzIGFuIGFi
c3RyYWN0aW9uIG9mIGhvc3QgSU9NTVVGRCBkZXZpY2UgKi8NCj4+ICtzdHJ1Y3QgSU9NTVVGRERl
dmljZSB7DQo+PiArICAgIElPTU1VRkRCYWNrZW5kICppb21tdWZkOw0KPj4gKyAgICB1aW50MzJf
dCBkZXZfaWQ7DQo+PiArfTsNCj4+ICsNCj4+ICtpbnQgaW9tbXVmZF9kZXZpY2VfZ2V0X2luZm8o
SU9NTVVGRERldmljZSAqaWRldiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW51
bSBpb21tdV9od19pbmZvX3R5cGUgKnR5cGUsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVpbnQzMl90IGxlbiwgdm9pZCAqZGF0YSk7DQo+PiArdm9pZCBpb21tdWZkX2RldmljZV9p
bml0KHZvaWQgKl9pZGV2LCBzaXplX3QgaW5zdGFuY2Vfc2l6ZSwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgSU9NTVVGREJhY2tlbmQgKmlvbW11ZmQsIHVpbnQzMl90IGRldl9pZCk7DQo+
PiArI2VuZGlmDQo+PiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvaW9tbXVmZF9kZXZpY2UuYyBiL2Jh
Y2tlbmRzL2lvbW11ZmRfZGV2aWNlLmMNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRl
eCAwMDAwMDAwMDAwLi5mNmU3Y2ExZGJmDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9iYWNr
ZW5kcy9pb21tdWZkX2RldmljZS5jDQo+PiBAQCAtMCwwICsxLDUwIEBADQo+PiArLyoNCj4+ICsg
KiBRRU1VIGFic3RyYWN0IG9mIEhvc3QgSU9NTVUNCj5pdCBpcyB0aGUgYWJzdHJhY3Rpb24gb2Yg
dGhlIElPTU1VIG9yIG9mIGFueSBhc3NpZ25lZCBkZXZpY2U/DQoNCicgUUVNVSBhYnN0cmFjdCBv
ZiBIb3N0IElPTU1VRkQgZGV2aWNlJyBtYXkgYmUgYmV0dGVyLg0KDQo+PiArICoNCj4+ICsgKiBD
b3B5cmlnaHQgKEMpIDIwMjQgSW50ZWwgQ29ycG9yYXRpb24uDQo+PiArICoNCj4+ICsgKiBBdXRo
b3JzOiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+ICsgKiAgICAgICAgICBaaGVuemhv
bmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gKyAqDQo+PiArICogU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4+ICsgKi8NCj4+ICsNCj4+ICsj
aW5jbHVkZSA8c3lzL2lvY3RsLmg+DQo+PiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4+ICsj
aW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCINCj4+ICsjaW5jbHVkZSAic3lzZW11L2lvbW11
ZmRfZGV2aWNlLmgiDQo+PiArDQo+PiAraW50IChJT01NVUZERGV2aWNlICppZGV2LA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBlbnVtIGlvbW11X2h3X2luZm9fdHlwZSAqdHlwZSwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgbGVuLCB2b2lkICpkYXRh
KQ0KPj4gK3sNCj4+ICsgICAgc3RydWN0IGlvbW11X2h3X2luZm8gaW5mbyA9IHsNCj4+ICsgICAg
ICAgIC5zaXplID0gc2l6ZW9mKGluZm8pLA0KPj4gKyAgICAgICAgLmZsYWdzID0gMCwNCj4+ICsg
ICAgICAgIC5kZXZfaWQgPSBpZGV2LT5kZXZfaWQsDQo+PiArICAgICAgICAuZGF0YV9sZW4gPSBs
ZW4sDQo+PiArICAgICAgICAuX19yZXNlcnZlZCA9IDAsDQo+PiArICAgICAgICAuZGF0YV91cHRy
ID0gKHVpbnRwdHJfdClkYXRhLA0KPj4gKyAgICB9Ow0KPj4gKyAgICBpbnQgcmV0Ow0KPj4gKw0K
Pj4gKyAgICByZXQgPSBpb2N0bChpZGV2LT5pb21tdWZkLT5mZCwgSU9NTVVfR0VUX0hXX0lORk8s
ICZpbmZvKTsNCj4+ICsgICAgaWYgKHJldCkgew0KPj4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJG
YWlsZWQgdG8gZ2V0IGluZm8gJW0iKTsNCj55b3UgbWF5IHByZWZlciB1c2luZyBlcnJwIGluc3Rl
YWQgb2YgaGFyZCB0cmFjZXMuDQoNCkdvb2Qgc3VnZ2VzdGlvbiwgd2lsbCBkby4NCg0KPj4gKyAg
ICB9IGVsc2Ugew0KPj4gKyAgICAgICAgKnR5cGUgPSBpbmZvLm91dF9kYXRhX3R5cGU7DQo+PiAr
ICAgIH0NCj4+ICsNCj4+ICsgICAgcmV0dXJuIHJldDsNCj4+ICt9DQo+PiArDQo+PiArdm9pZCBp
b21tdWZkX2RldmljZV9pbml0KHZvaWQgKl9pZGV2LCBzaXplX3QgaW5zdGFuY2Vfc2l6ZSwNCj5u
aXQ6IHdoeSB0aGUgIl8iDQoNClRvIGRpc3Rpbmd1aXNoIHdpdGggbG9jYWwgaWRldi4NCg0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVUZEQmFja2VuZCAqaW9tbXVmZCwgdWludDMy
X3QgZGV2X2lkKQ0KPj4gK3sNCj4+ICsgICAgSU9NTVVGRERldmljZSAqaWRldiA9IChJT01NVUZE
RGV2aWNlICopX2lkZXY7DQo+PiArDQo+PiArICAgIGdfYXNzZXJ0KHNpemVvZihJT01NVUZERGV2
aWNlKSA8PSBpbnN0YW5jZV9zaXplKTsNCj5hdCB0aGlzIHN0YWdlIG9mIHRoZSByZWFkaW5nIGl0
IGlzIG5vdCBjbGVhciB3aHkgeW91IGlucHV0IHRoZQ0KPmluc3RhbmNlX3NpemUuIHdvcnRoIHRv
IGJlIGNsYXJpZmllZC9kb2N1bWVudGVkLg0KDQpWRklPIG9yIFZEUEEgbWF5IGhhdmUgSU9NTVVG
RCByZWxhdGVkIGF0dHJpYnV0ZXMgZm9yIGl0cyBvd24gdXNhZ2VzLg0KSXQgbG9va3MgVkZJTyBk
b2Vzbid0IG5lZWQgdGhpcyBmb3Igbm93LiBJJ2xsIHJlbW92ZSBpdCwgdGhlbiBfaWRldiBjYW4g
YmUNCnJlbW92ZWQgdG9vLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

