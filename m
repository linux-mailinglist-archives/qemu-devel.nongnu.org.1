Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A5F80E33C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 05:16:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCuB6-0007lx-Gz; Mon, 11 Dec 2023 23:15:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCuAy-0007hs-Dk
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 23:15:22 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCuAu-0007hx-FZ
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 23:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702354516; x=1733890516;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BPj+iFBcKctJEUlIJgXT4VhlJMNk69WMGBJS1WshASo=;
 b=Hi14v6wCGcWic77lXpCioZjdcwXDC3SV+sRsfnbPt/wWkLZrfveNDAcR
 y+3eGFyjhQZvVu/qiBGcYNP1VabJqc9mcP3EbdelnpEKfqdR7ryVjmOco
 I2ZzrsGb+bSE+DSL5rDQr6qucTVh1WeGHnXCsSy/i3dS0NyP0948W+xRC
 dJQjuATtEL8tINh/tTHWZ9605i41ZqjrS1N2mzRzovFsAS0h/tsfnUqx8
 zGIUJQ1MsvGBjJVI1cqzesQvXd/HR+WwbigI4c8U5jM014Xl6xg3BiewL
 ZaslDgtp1UYFYtm4aKjuov6XXwjulU5Re9MQL4FfJlhyafyd5CMBG5Cu1 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="374256916"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; d="scan'208";a="374256916"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2023 20:15:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; d="scan'208";a="21363342"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Dec 2023 20:15:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 20:15:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 20:15:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 20:15:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tq3vpyo6RqiH8Tj/AGHdAUUP18sWrXZHI2ylLx5oJffQWZg48TM7yCO+hYPMSKO3KEtkyjlwPLeiW9Hxa1vc1zrFhiEdWp7gtYTKo1AiEn70+vfp9LTdtysnYsXrfTKAfHq4lEvoEANsD2lCEYSPQ2o1vfVkpSXXqgzrJHPRR9jsqXHtF6pKvZghFFu0vkZtQkdqpVuQKQVV3JbmhXBaVu37ZX/SMvxzd1Zwh9M5YLnqa7u/C8u1Ki67LaFGK7jCxxILbJj0l+nkV54awBsQjYyYU3mgwzdU7n0A+tBsdkuQfEG+UF2g3Kvdw1pfYUVDlRx1iR97ddBV3IeFr+Loww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPj+iFBcKctJEUlIJgXT4VhlJMNk69WMGBJS1WshASo=;
 b=SgsOdhrGy2zCFBo8YX39Auges0tPEINOiu558iujZQEzSu0K8inRKR65tvzLj6mtO0MTEOy4pEvqQVkuza1Ed4ZGjLtNkPofvluGLtDRcj0tc5zKxbyBzjqZjRV5hH0HUaeU+9gNpTLA0hoNBoZvH0Xk/pXXwyZhZijv7nZxE31zksILznh4i8Ylsq6OopL9+8eXIH/En9ermPLJP+n2rfGPmiMj8vHIb330qnwrU9vQ5xAe2WPipzLZfDBHuJTgRHOqBZ0tOADfHfIrAfUU4GOPtZWf20hHoSeL8O0c3tqJkFfixfDCylXZFNS4wK9D60hztR30jAPAC2uVmRNUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7826.namprd11.prod.outlook.com (2603:10b6:930:76::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 04:15:08 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 04:15:07 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>
Subject: RE: [PATCH for-9.0 03/10] vfio/container: Initialize VFIOIOMMUOps
 under vfio_init_container()
Thread-Topic: [PATCH for-9.0 03/10] vfio/container: Initialize VFIOIOMMUOps
 under vfio_init_container()
Thread-Index: AQHaKbMoNBt6I0DuEUW5IKl+t8GtULCjmW+AgACHNYCAAO4bEA==
Date: Tue, 12 Dec 2023 04:15:07 +0000
Message-ID: <SJ0PR11MB6744D7AA6AA500F9CF9AF078928EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231208084600.858964-1-clg@redhat.com>
 <20231208084600.858964-4-clg@redhat.com>
 <SJ0PR11MB6744ADC5CD40D8CF8013EEA8928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <a86f5186-9600-4360-8f4d-4133c57ea5cf@redhat.com>
In-Reply-To: <a86f5186-9600-4360-8f4d-4133c57ea5cf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7826:EE_
x-ms-office365-filtering-correlation-id: c4e8054b-852a-4ee1-c42b-08dbfac8ecf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NhGxaGmlPbU8VYx7bKf2htHBBKnDSy2ooc6MSZVJlTRxexixedsvSCv1RV3lEyKi+6OptdnLfE6ejLp+t+dm20WkkCVCJhEJg+azTnCQGS1gLQo47Dk6tA7vBYICkWlcEcR+EnGjaff089WywOCW89O5r8PqgkoUQ24/Y+ZlHO3ZKeWQpMnArlD9xSDfIep1ZenF+PnyUACTigq3Vfo9MhOvDvu2TrvkfJlXqlD86m+pns2AeJbDDc25VAMZCMfmSlKJ3xzTgAy0b9wA1M1dyDpCtMSsDGpXKsgZhsv2NzQ3yogmbbk+lhModf1L4aMtCy93tyRwtUIBOrTtwUsKm8vv/xqIv37dadGdbjhnRhqh84PbCJcv+ICkurecbIlaGJrMJaOcdlk8LerWReIwr41TLVqFxyJP5F55D/x4tn6OF/FlwbopvQ0tFBnkBXoCvxY+s16LobXA1UNa4kx7spEaAOE2IKoJ1BVyiQVF13Gcqg8HeIuE65kjeDneByNUqnCcRzCdWcLy8NdzA+bUxhZjba1SaRgd7/tQDKm1d6fIg5VLD875r0onQUTtQmqZ1po4mVQvTVxZfylTZfH0vBZf53T96r+HxmZV8NRUCNEKDqe/7Vbb7F4z2HCdDiep
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(55016003)(110136005)(66946007)(76116006)(66446008)(66476007)(64756008)(54906003)(66556008)(2906002)(5660300002)(52536014)(122000001)(71200400001)(6506007)(7696005)(8676002)(8936002)(4326008)(316002)(38100700002)(478600001)(86362001)(38070700009)(82960400001)(9686003)(26005)(41300700001)(53546011)(66574015)(33656002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1A4bnl1M3FFdC9wa2RHaDJ2cFNuZm5PR1VkRjd2K1kyRHArOXM0QnNLN21p?=
 =?utf-8?B?alZrczZhWEc4MHdBQzNmUU54bGVOZGd6WGtFcFRJOEhYay9LZjM0QmJWMVh0?=
 =?utf-8?B?Ni9rZVRib0pJZlVMNUROanNIWVR3VmVyQkJSQWpKUytoT080SUU0UE9hSzNt?=
 =?utf-8?B?cVB0TkwwQUtDd0dOeG0wRk1lRWdnamZiTm9ZRm9EanArSXZoNXBQWHJKVWVr?=
 =?utf-8?B?a0ZyRHRPSUFCMjRvL0h4ZEh6MUtpYUlXL3d3am9iYXZ5MndoM3A5aENXeUpD?=
 =?utf-8?B?UXNpSmVKMXd6aXRoSTdwdUc2S2xNdGJ1OG40ZkZ6WCtaaXRRWXRSeGllNkYy?=
 =?utf-8?B?VmFxZjFYWnZKRjBnVlVPWjVvQklKTU1PUkRjb3RmdjErSHNORGp4eVVZblNa?=
 =?utf-8?B?Q1R1N2t1WjYvZEFHc3BIeWhUZEJrSW16TFBhUFVDaHhTRit2M0d6ajd1d0RW?=
 =?utf-8?B?dmlQa08wMjB0cGRMcDc0VW1xUHVna3RmTkNkNHIzekxXekRUY3NyU0x2dEI3?=
 =?utf-8?B?Mk9jVmlyTHc3QTRaMVdkeHFrSXFEckFGVUhBb2FsOVF3NmNrTlpqRXNBOTE2?=
 =?utf-8?B?Z2JpWW8wVzZCd2l2RGsyditjaFlWeHI0b3FYS1NBSzYvMHN3UmszakUrTkVw?=
 =?utf-8?B?UTE2bXBIYmhMM3VSU1ZFZHVqU1RJdHhiTGI1VjVNSlRkOVpTb0p2ZEFJVk1p?=
 =?utf-8?B?UG9vNFp0L1pSUG1JL21yTmhub29XUjNIWWZMeWNhQ0YwODEzRU8reVFrdWVi?=
 =?utf-8?B?Y1FxdHZSdnNuVzJoVnNpaVpoYWZsT3hDOXpOTlAwNEpIWDBtblBLY3lUZG0y?=
 =?utf-8?B?ZzJ0RFQ1K2ZYYnNpVXcralF0eGRYb2RZc1FuWGgrc1NEK3pOVFpxaGNWRzhQ?=
 =?utf-8?B?cG9vNVYzSUVPSFVpTVdpWmtBOW51cVlhYldLRW1yU3NFL3M4ZXZ2WlJqQ3lp?=
 =?utf-8?B?MW15MFQvbHNoNDRGSFJDUWVvQ0F4V08rTm9JcGl5K3JScng4SWNMVzR5QzdF?=
 =?utf-8?B?ODVsNUF3MUhnMEhKTUJHMWdid1g4bHI5VjhaQ2IwVFowTTM2ZTFBY2t5cU9E?=
 =?utf-8?B?dHJ4ZlAvMGJMQ09aVDNUOFBqVFU2VXc3aW1pQmlwT0Ira2l1ckhtVmsyYk9h?=
 =?utf-8?B?ZWhQSDRiNVJUSnRNa3J1VDdOdTlZWDRDSDRRcnhaOWRpRWVMN2p3d3gxVjI5?=
 =?utf-8?B?Q0pNekMwTVBTVUk1c1hMZ3JKam1Mai9pTHJXRmhTYWo4MHZnYlFBaU1peWJ6?=
 =?utf-8?B?c1pNcUgvSTBGeGxxSzQzRFRRNXpUOE9LTk5NMHcweTdnQ1h3K3NFQXpVL09X?=
 =?utf-8?B?K01PS3dWcDFQL1RzVCtrak1OZnFHMC9lMmF0ZUp0TFBKc0c1bUFyZG9KMEIx?=
 =?utf-8?B?QUMxR05UMUR1WGJCTXNkMXpvMU9JWnJtWGs5dTRrT2RlZzdWZ3NBM3E0L1p0?=
 =?utf-8?B?N3N4ZjlDaytEUEZPcUxNQ25teG85SzFaSU1BRXV6bVNkcnMxbXBPVTk5NW1Z?=
 =?utf-8?B?WFhydk9EVDcwNW0zMVNxWUh4RHR0QzN4K2ZCN1JMaC9vRHNnMVVCamxvLzFY?=
 =?utf-8?B?cHdXcjJJcVQxVlBweFE0TW9xd0tMNEFUcUd2WmUxdjFOUy9Wb3V0c1RONmJU?=
 =?utf-8?B?SEJqZmlDcGxXQmJCL0J3U0F1QzVCdi96aGRWVStUdVZBdTRSSllxUVgzRStF?=
 =?utf-8?B?aGpzSFhnS2tKS0xDSWd3VUpFUmtvYjdLNVBmNW1DM1B3ejUrYkdVWXhEaWkz?=
 =?utf-8?B?aGRKVlE1Tm9EdWtWWUxzWE01ZVhtZGxpaGZ0VmErdGFTYmljWlhkOWgwby9w?=
 =?utf-8?B?b29MQVpkL00vbFZIYm8yc0RSQmlRUlY3ZWtYRnJjQWprWlpFQjFoNXprM2Zo?=
 =?utf-8?B?V3h2Tk4wbWF2cnIvcC9qN2FKQmlDUjd2MUVHczBSQmZhREs0MG1taFErZ2pY?=
 =?utf-8?B?OElla0pjU2J5TnJUVDJSZ3NRZzRlTEFtbWM0UjJUT21TSlhKazhWVUxGWk94?=
 =?utf-8?B?bHNnZ2VueFNnMXpwb2N3YjUxd1FpRWg3T0l6eVhkTTdRUDVrck5PcEMyY1Jk?=
 =?utf-8?B?TU5EenRNRVJJVnlEUlZhNVlQcmpDMGVKd29ORHY2MUlNWDFma29TcU5GUXo5?=
 =?utf-8?Q?vNHtbh4nUTrv1aRLDtaCfp9xN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e8054b-852a-4ee1-c42b-08dbfac8ecf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 04:15:07.8817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ANPnetkZ+RU6hDL4I4QftWOWMHPHvAqw9IqnJq09/MR8nTAefXan/wuZCUDovE/SwmX7U65IR8rDX/gwn3jRXObbaMbGQZdHD7c2TwnVJ/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7826
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIGZvci05LjAgMDMvMTBdIHZm
aW8vY29udGFpbmVyOiBJbml0aWFsaXplIFZGSU9JT01NVU9wcw0KPnVuZGVyIHZmaW9faW5pdF9j
b250YWluZXIoKQ0KPg0KPk9uIDEyLzExLzIzIDA2OjU5LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6
DQo+Pg0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEPDqWRy
aWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+PiBTZW50OiBGcmlkYXksIERlY2VtYmVy
IDgsIDIwMjMgNDo0NiBQTQ0KPj4+IFN1YmplY3Q6IFtQQVRDSCBmb3ItOS4wIDAzLzEwXSB2Zmlv
L2NvbnRhaW5lcjogSW5pdGlhbGl6ZSBWRklPSU9NTVVPcHMNCj4+PiB1bmRlciB2ZmlvX2luaXRf
Y29udGFpbmVyKCkNCj4+Pg0KPj4+IHZmaW9faW5pdF9jb250YWluZXIoKSBhbHJlYWR5IGRlZmlu
ZXMgdGhlIElPTU1VIHR5cGUgb2YgdGhlIGNvbnRhaW5lci4NCj4+PiBEbyB0aGUgc2FtZSBmb3Ig
dGhlIFZGSU9JT01NVU9wcyBzdHJ1Y3QuIFRoaXMgcHJlcGFyZXMgZ3JvdW5kIGZvciB0aGUNCj4+
PiBmb2xsb3dpbmcgcGF0Y2hlcyB0aGF0IHdpbGwgZGVkdWNlIHRoZSBhc3NvY2lhdGVkIFZGSU9J
T01NVU9wcyBzdHJ1Y3QNCj4+PmZyb20gdGhlIElPTU1VIHR5cGUuDQo+Pj4NCj4+PiBTaWduZWQt
b2ZmLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+Pj4gLS0tDQo+Pj4g
aHcvdmZpby9jb250YWluZXIuYyB8IDYgKysrLS0tDQo+Pj4gMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9ody92Zmlv
L2NvbnRhaW5lci5jIGIvaHcvdmZpby9jb250YWluZXIuYw0KPj4+IGluZGV4DQo+Pj4NCj5hZmNm
ZTgwNDg4MDVjNTgyOTFkMTEwNGZmMGVmMjBiZGM0NTdmOTljLi5mNGEwNDM0YTUyMzliZmI2YTE3
YjkxYzgNCj4+PiA4NzljYjk4ZTY4NmFmY2NjIDEwMDY0NA0KPj4+IC0tLSBhL2h3L3ZmaW8vY29u
dGFpbmVyLmMNCj4+PiArKysgYi9ody92ZmlvL2NvbnRhaW5lci5jDQo+Pj4gQEAgLTM3MCw3ICsz
NzAsNyBAQCBzdGF0aWMgaW50IHZmaW9fZ2V0X2lvbW11X3R5cGUoVkZJT0NvbnRhaW5lcg0KPj4+
ICpjb250YWluZXIsDQo+Pj4gfQ0KPj4+DQo+Pj4gc3RhdGljIGludCB2ZmlvX2luaXRfY29udGFp
bmVyKFZGSU9Db250YWluZXIgKmNvbnRhaW5lciwgaW50IGdyb3VwX2ZkLA0KPj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgVkZJT0FkZHJlc3NTcGFjZSAqc3BhY2UsIEVycm9yICoqZXJycCkN
Cj4+PiB7DQo+Pj4gICAgICBpbnQgaW9tbXVfdHlwZSwgcmV0Ow0KPj4+DQo+Pj4gQEAgLTQwMSw2
ICs0MDEsNyBAQCBzdGF0aWMgaW50IHZmaW9faW5pdF9jb250YWluZXIoVkZJT0NvbnRhaW5lcg0K
Pj4+ICpjb250YWluZXIsIGludCBncm91cF9mZCwNCj4+PiAgICAgIH0NCj4+Pg0KPj4+ICAgICAg
Y29udGFpbmVyLT5pb21tdV90eXBlID0gaW9tbXVfdHlwZTsNCj4+PiArICAgIHZmaW9fY29udGFp
bmVyX2luaXQoJmNvbnRhaW5lci0+YmNvbnRhaW5lciwgc3BhY2UsICZ2ZmlvX2xlZ2FjeV9vcHMp
Ow0KPj4NCj4+IFJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPg0KPj4NCj4+IE5vdCByZWxhdGVkIHRvIHRoaXMgcGF0Y2gsIG5vdCBjbGVhciBpZiBp
dCdzIGRlc2VydmVkIHRvIHJlbmFtZQ0KPj4gdmZpb19jb250YWluZXJfaW5pdCBhcyB2ZmlvX2Jj
b250YWluZXJfaW5pdCB0byBkaXN0aW5ndWlzaA0KPj4gd2l0aCB2ZmlvX2luaXRfY29udGFpbmVy
Lg0KPg0KPkkgYWdyZWUsIHRoZSB2ZmlvX2NvbnRhaW5lcl9pbml0KCkgYW5kIHZmaW9faW5pdF9j
b250YWluZXIoKSBuYW1lcw0KPmFyZSBjb25mdXNpbmcuIEkgd291bGQga2VlcCB2ZmlvX2NvbnRh
aW5lcl9pbml0KCkgYmVjYXVzZSBpdCBpcw0KPmNvbnNpc3RlbnQgd2l0aCBhbGwgcm91dGluZXMg
aGFuZGxpbmcgJ1ZGSU9Db250YWluZXJCYXNlIConIG9wcy4NCg0KT2gsIHllcywgdGhhdCdzIGJl
dHRlci4NCg0KPg0KPkkgd291bGQgYmUgdGVtcHRlZCB0byByZW5hbWUgdmZpb19pbml0X2NvbnRh
aW5lcigpIHRvIHZmaW9fc2V0X2lvbW11KCkgPw0KDQpTb3VuZHMgZ29vZC4NCg0KVGhhbmtzDQpa
aGVuemhvbmcNCg0KPg0KPkFsc28sIEkgd2lsbCBpbnRyb2R1Y2UgYSB2ZmlvX2Nvbm5lY3Rfc2V0
dXAoKSBoZWxwZXIgaW4gdjIgZG9pbmcgdGhlDQo+YXNzZXJ0IGFzIHRoZSBvdGhlciByb3V0aW5l
cy4NCj4NCj5UaGFua3MsDQo+DQo+Qy4NCj4NCj4NCj4NCj4NCj4NCj4+DQo+PiBUaGFua3MNCj4+
IFpoZW56aG9uZw0KPj4NCj4+PiAgICAgIHJldHVybiAwOw0KPj4+IH0NCj4+Pg0KPj4+IEBAIC01
ODMsOSArNTg0LDggQEAgc3RhdGljIGludCB2ZmlvX2Nvbm5lY3RfY29udGFpbmVyKFZGSU9Hcm91
cA0KPipncm91cCwNCj4+PiBBZGRyZXNzU3BhY2UgKmFzLA0KPj4+ICAgICAgY29udGFpbmVyID0g
Z19tYWxsb2MwKHNpemVvZigqY29udGFpbmVyKSk7DQo+Pj4gICAgICBjb250YWluZXItPmZkID0g
ZmQ7DQo+Pj4gICAgICBiY29udGFpbmVyID0gJmNvbnRhaW5lci0+YmNvbnRhaW5lcjsNCj4+PiAt
ICAgIHZmaW9fY29udGFpbmVyX2luaXQoYmNvbnRhaW5lciwgc3BhY2UsICZ2ZmlvX2xlZ2FjeV9v
cHMpOw0KPj4+DQo+Pj4gLSAgICByZXQgPSB2ZmlvX2luaXRfY29udGFpbmVyKGNvbnRhaW5lciwg
Z3JvdXAtPmZkLCBlcnJwKTsNCj4+PiArICAgIHJldCA9IHZmaW9faW5pdF9jb250YWluZXIoY29u
dGFpbmVyLCBncm91cC0+ZmQsIHNwYWNlLCBlcnJwKTsNCj4+PiAgICAgIGlmIChyZXQpIHsNCj4+
PiAgICAgICAgICBnb3RvIGZyZWVfY29udGFpbmVyX2V4aXQ7DQo+Pj4gICAgICB9DQo+Pj4gLS0N
Cj4+PiAyLjQzLjANCj4+DQoNCg==

