Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 951B27A9119
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 04:53:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj9oO-0004Vl-GU; Wed, 20 Sep 2023 22:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qj9oM-0004V1-KF
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 22:53:02 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qj9oC-0004TL-O8
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 22:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695264772; x=1726800772;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4mJ9faB7dEoBj6EJh2PnwkbTvjO/wl3B0qCAy62635c=;
 b=fs5OfVfAxlVo8hJzRnU5nTfnTEGcVW38bUrMeLNd7zcMpHgv83dT3G5Y
 YnfkAa2jTOxBJaq////fRLdIIgThJ8yxjz+6bfM21FuIjiOyYlqk/T+BT
 pHD9yhcDcLb0Vb2aKhKXnC8mB7MZI/n0zdKS6B7lAIK3cu726HvuXxTvc
 vgINCwM2IdsU7+KzHiWP1CMfOOuk0xBGDxSW+8RL2t5A49we8A3G81nSX
 vXpH6eeU1sZirFqjGZSs7yMFnJmIiLYhD05OyuDiEXSRwmozqh28D6hlN
 N8gCBw+HH2bHet5j7DJ9ZJ3dmo9P0bin2YBe9DDRTCtm5G0GZTnNIcnqg Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="446873243"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="446873243"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 19:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812436966"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="812436966"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 19:52:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 19:52:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 19:52:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 19:52:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 19:52:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwbS/7akZwU3v0QJ5I9cXtxvUA7KEDaGUfVNJZe6nSLg3epKDSLCHC6iCHgdJ1KB5zBS0e0E3O/Ik+Fopezwoxr1pcToVUUilk6geMOW0yShfRQQdum5bmMWj03HdL7D9x0xTPH2qOLCw5kEkCBsDRAkz9Zs/pL70Z5CxUm1DPXKWOCQ0gpqGYAqIDjMJUBxT68RnLxdJu02nmuBpu1G8y/dbAG9SKlAFc52Y4bV557wvQB3h6iEJHWs9kL8JYdeDO3Y3KzktRJxGGs12Ost/qNc4LUc/36gUwgF0GsFi5Kzdjm3p1qNfLSpGF0baG7sJgn/2BlNKjJ+KY8rpI7cyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mJ9faB7dEoBj6EJh2PnwkbTvjO/wl3B0qCAy62635c=;
 b=lIzJoQxcQOc6v654dn1blNkhE1a9HfkSUfEcWo8sG1tAb66rDyO7ygilwI8KUnJqaZFz+NVcNi2V7rHNmrUU+WHCJqHBaPwp5GKiZYm+06tdKd9N5Kxy2ckc1l+PNJiCrfHkvAKQ4yjMd52/7gwQSY/Y4SH9bfE9uuQFUgnA71gyK3AAuiT/VkDoE9RPfIt/TimbQXyqeS3SxaB+iPeoA6vUfsnbwavJUsH2oAfoJrcDwhiv6+Of4/Iev1r6f52QrNEgHcy3vuSS9KEt8rOdCuE+gdZeHElhYqkuu2LDdYg5ACK0fKGz5d4jJjs+KpxJNYDvKCnFSjJdjJJPqVrI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 02:52:44 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 02:52:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 07/22] vfio/common: Refactor vfio_viommu_preset() to be
 group agnostic
Thread-Topic: [PATCH v1 07/22] vfio/common: Refactor vfio_viommu_preset() to
 be group agnostic
Thread-Index: AQHZ2zAo3NsMmQdR20Og0Ie/MXHDX7AjzoCAgADoOxA=
Date: Thu, 21 Sep 2023 02:52:43 +0000
Message-ID: <SJ0PR11MB67448BFA48D35E19BE8FB4B592F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-8-zhenzhong.duan@intel.com>
 <768ee6c3-8278-53e8-aa31-ee3fa11399cc@redhat.com>
In-Reply-To: <768ee6c3-8278-53e8-aa31-ee3fa11399cc@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5949:EE_
x-ms-office365-filtering-correlation-id: a3323a94-6589-466b-ac68-08dbba4dd3fe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TNZ5na4fcts+dAtIJJHiG0A3OQffaa1XvpF9psljtjvUa90shbEPYd9NMyF0jrSx5JHRMaPiyC7r0zPN242bq6ePUzDLE6UO48IMYUEy+nAZ/nGQ+3MtJlr3a6UnPXyZvdE3G/H04Is2wPeg2RDMpWCj/Jlxq6Lrp3g007TjTv1rdIsZAF1k3Ob+uqj/u9rMHem+lED0avtUcxjP/Ef3ldBbA99PGk7YvHCwRO6I03upR+BygShPMw3il+JrT2S7/Ydk/ZExOGM1dCUIJ8OaNTG3vkoQ4nVBczNv1f74tOzRLyngoIARksq8ix/YpA4wf9X46C7X2Xyln3+aXgw4rIHuIUh8CTxXampCUJVHFObVRj8w44K9ja8TNem80XO1Q4mglU2cQIyGg4SwDjwX07oC/H3wq6BSnJTlvav1lQNuyuHrQqhSgOLo8cjYRATPdwDELsNy9TBfh5GIk50uxjIQUJDdCRO+vVaCjfobOmCklMt5GcM84/4+uyay6TQDKUTBLXvV8zvBPQQBQ4GRJAgvLfukGADFEU1+HKPX0gI+aOWjReiNhfZJTx+qxdq2+Th+QdGKvTNIj1kuzMMVQ1iAog07ykcIFov4iaYC3FhG2LxCNBva0NK1xaWz+aQQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(186009)(1800799009)(451199024)(54906003)(66946007)(41300700001)(76116006)(66476007)(66446008)(66556008)(4326008)(8676002)(122000001)(8936002)(316002)(7696005)(9686003)(6506007)(83380400001)(110136005)(478600001)(71200400001)(26005)(107886003)(82960400001)(2906002)(38070700005)(33656002)(5660300002)(38100700002)(4744005)(86362001)(64756008)(52536014)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm83dFAwZkJxcGRMME9seFVOSzlEYktmZEQ3b0ZQWnIxOFMwVlJxdUtTaGFV?=
 =?utf-8?B?Z24ybVkxUnNmdTJlTHZxN01sNjBtUEdYUG9vWGw0YWpoZXVVcEpIbUNhbytV?=
 =?utf-8?B?RXlPdFpRZXRlYThWdFoxZy82ci9UUDcxY2VjTUY5c2tZeno2TFBiWjN5TFRa?=
 =?utf-8?B?WVNLOEJBdUt5akRrRCt2MFI4a0FtRVRyQVhzS0M1YzZOSUpwTm5udkFVQWV1?=
 =?utf-8?B?VmZxSFErd3gzZzk1cHRpK3Z6WVNndjNPcURJSUx6VVd5UlJnRzdOWTVRUndT?=
 =?utf-8?B?QjM3Z2NMaXZPOTcxU1VwblQ4bnBmSHRGYmdqQUlTckJtSVZsMnZuRWVHVHhw?=
 =?utf-8?B?d3UyRmJYcW83cFhWTld2VWJRMDVLMUZhRllxYW5OV0cwMWVQWnNESkJ6MmxM?=
 =?utf-8?B?bGVPTkpPalJhcFppck4zZFVlL0ZBWVdSV0RWNUcreksxOHE2MXd3Uy8yRmRX?=
 =?utf-8?B?REs3cjZyUzRCWGRwV1Y3REZTUmJHYUN0ckRnWWtqdHAwQjJ3dE11ZjU5Vmxn?=
 =?utf-8?B?S3RUaCt6RFJ4dloxajEvWUhva2R2bWc1TVJ5cnVoSmlNclNZVG9lTVdrMk1E?=
 =?utf-8?B?dXMxNVRWbWI5VEdRVTVTVEJCS1hTWlNZSGNKWUNWZHplNHI3UnpUQ2MvMURG?=
 =?utf-8?B?UzFnMEU3RnMxQTBZMFpXMUNpSjBUenRPVUp3ZGF0WWkyYkQ3VkpUcVRWZHho?=
 =?utf-8?B?QmkwTlRpY0NOUGpCejc2d3A5aThUdEt1NFk4ZENtZTZ2L3BZWkpKMjlpTWN0?=
 =?utf-8?B?cTVpS1pKVHZ2SkNRZUl2Ni94R1MvQjZLYXdwbW52NmU1ZkRpcERnbEErKzR1?=
 =?utf-8?B?OTMyWmZ6amxyUlBwakhVb1FXTTFEUmVGaVdpQXdPckEyc3dNRmZmYVQ1QVRX?=
 =?utf-8?B?OVprSVZaSTBzWmF1T3Y3VXU1RmRxMHFaYUpsK3J1L3FpbEFSTDl6UlUrY2c2?=
 =?utf-8?B?cFBZYXBGRHNOeWJYb3dUU0dhenR0cCtsQVdReGZaOUMzNU55SzRpZTJQSzF0?=
 =?utf-8?B?cWZvQ1EzTjlaVnlMcXpERy82ZnAvS2srYTQxL0NxWVJGZzlsSUFIQ1hvSkkz?=
 =?utf-8?B?THVMMWFWT3NTYVVwV1ZuRzhjeExrK2tZYVhKaFdxRXJ3ZG5qR2xYU0V6SHQ1?=
 =?utf-8?B?dTVMUWVRRXRPK1R2ZHJEMDFoTVAxdVdzclN3c01qVWw1eng4WkhDUE9CWUJE?=
 =?utf-8?B?OVBEckxxSCtqU2UwZmxGMHpYWHp5YWJyMXc0RVZwR21VTVVGYUw1b1Q1ZXhJ?=
 =?utf-8?B?OHBiWHcxWUMxM0pkdC9QeTI5QjQ3MDZnV1dXQ0xHNDJOTHdXNURiTENZd2xn?=
 =?utf-8?B?T0x3RGxyYzgrODJSV1BaSllIaWxiQVpDT0JXT0o1eExWbFNKUVQ4ZnFVZnlL?=
 =?utf-8?B?OTByd2drU0tiQy8ybDQ5RDdNWnZMUU0xWngxUmRMUmY0bFNkN3VmWDI5bytV?=
 =?utf-8?B?TkRBRkhzc0U3WWp0dG1GZW02K2liMUkwNWpTaEM0U1ljeHB5eE45MCtkQXIv?=
 =?utf-8?B?SDNodnhvK290U3BCRm43MGhqZHVzSk0rYVgzMW5uWXhoMWRKMTA3ekRYU1Ju?=
 =?utf-8?B?a2gxa2NrbTRweXhtWUhwYk8ybXBhSHV2VG5vN05DSUpYYVRyb3lwL1lXaUY1?=
 =?utf-8?B?UGhYWVFmRUErR0VQekJwbC90NDZTVlBoY1ZnSTFseVJ2T0pUWGtTWXNwVlZo?=
 =?utf-8?B?bzZ1ai9EOHhYb0NpS0ZzNXh6WG9RR0xuQnYxeWtiSFptOUV1dDg1Q0JpT1RL?=
 =?utf-8?B?T1pLd2hyQUg4aE85UGRGckIyN2pSTjNKQmpLSWFxb2hYZUxNMGNnVDJ4TFl3?=
 =?utf-8?B?ZENkdlBnekJRcG5aMEtKVEwrNWR5VDhGNCs2NnNHdW5CUTgyRXJQYTNMRmNF?=
 =?utf-8?B?YUszYXdqTTFUeEV6OW1CeUlmdnptZzlXRUlXTVN1cGVJQkFlU3JnVjd0V1F5?=
 =?utf-8?B?WUNQaDY1a2lMazhMNlgzSmE5MEY0NFVBNGxNK2JGNUtXTXZlU3BIZTJod0Vq?=
 =?utf-8?B?Y3FFYXM3dkIyZDY0K1RHOHU2KzM3amdPTEIvZ0lRM2RJNERlbGI2TlhzMVBa?=
 =?utf-8?B?MDFnYU1ZR0pVUnRrbzFyNERQTEcxOEU1dDNhYkNTMDdXS2F6S2dXOTNkU09z?=
 =?utf-8?B?M1dhckcydkFacFhTa1R4Q05VQWk2ZGxtMG5UUDdwN1VDME5rTVBIUEd1QnJT?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3323a94-6589-466b-ac68-08dbba4dd3fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 02:52:43.4582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajpQ2lsOnNTjGeQ8oBJpC4Ph+nHkYRzUTBQfAMNDgyr4ebDf87caJqBxyFA+qJiBdOlD7D7PIl1JMoZwgZ2ouEoRAJwrZgBPlI1U2apSAVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5949
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyA5
OjAxIFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAwNy8yMl0gdmZpby9jb21tb246IFJlZmFj
dG9yIHZmaW9fdmlvbW11X3ByZXNldCgpIHRvDQo+YmUgZ3JvdXAgYWdub3N0aWMNCj4NCj4NCj4N
Cj5PbiA4LzMwLzIzIDEyOjM3LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFNvIHRoYXQgaXQg
ZG9lc24ndCBuZWVkIHRvIGJlIG1vdmVkIGludG8gY29udGFpbmVyLmMgYXMgZG9uZQ0KPj4gaW4g
Zm9sbG93aW5nIHBhdGNoLg0KPlRoaXMgaXMgYSBiaXQgd2VpcmQgdG8gcmVmZXIgdG8gY29udGFp
bmVyLmMgd2hpY2ggaXMgbm90IHlldCBjcmVhdGVkLiBJDQo+d291bGQgc3VnZ2VzdGVkIGp1c3Qg
cmV1c2UgdGhlIGNvbW1pdCB0aXRsZSBhcyBhIGNvbW1pdCBtc2cgKyB0aGlzIHdpbGwNCj5iZWNv
bWUgZWFzaWVyIHRvIGhhbmRsZSBtdWx0aXBsZSBJT01NVSBCRXMNCg0KV2lsbCBmaXgsIHRoYW5r
cyBFcmljLg0KDQpCUnMuDQpaaGVuemhvbmcNCg==

