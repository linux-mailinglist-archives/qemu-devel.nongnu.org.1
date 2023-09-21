Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCDB7A90E5
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 04:28:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj9PY-0008OQ-E9; Wed, 20 Sep 2023 22:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qj9PR-0008OD-UO
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 22:27:20 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qj9PO-0006Yu-04
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 22:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695263234; x=1726799234;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gb+PQlQN8CmEhNOi12SdXoCaMtJ60Sb6zz6fn+JlK0Q=;
 b=RxEUmsCX7VmfiNjuj9qz8PFXRtX07L4ZnEAVvPn67zEf+Y0fAsjz/NeX
 76vhs/DQF9EC6HcVLHeck7zJ7wzdUAzkIm1YCZ1YMyE7NXNImLds7Lpgq
 e9UR7MOMsgqVYehwiwmS1NOJgHYrAuM5n+F9G6HTRtJwK+VF96Q1lhmaM
 z1/zPg+A6btbmiYtuy1RaONPwwdjVpHF3B9tzVUVSlYPfxQV1tL73cYNx
 eeWJi2hsWQmqN7JMyzrIf6EAHUekmYeJnpGkNNWpMzcKoN32Xc5XpWOa2
 0i+766IAfwjfg4TTgKwKgTGTZw7CvL24UGHniesXddzaTW5VA4nHYOd0g g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359785708"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="359785708"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 19:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="920549058"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="920549058"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 19:27:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 19:27:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 19:27:10 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 19:27:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekxqrxvum+dpCxNlKhLBvdomL+N7WRCotdEtiUDJHjOob9KUMI11Ab4YwfGMJc1Vl0DJgqXbWSrmVeHBifhAhdRRFWeyPd3SI9g0yx6rdwebM+tt0EK3NNfewCvBAFmmlW/pSRLspMuZ/1KO9byHQ1zkg2dOyLiheU6Kod8niDMJOQdIIxfFVNF6LIVD+5Wcc8lo/8MRdfyvcMwSTuKHFQBqtqs/XJtKxDWwkILJUgZ6wAxutRMaulxcS7CuG8ARpj/5nI6pNCtdwAAdzrQTJYcmvCOBtt+h/4BzVSfeXClUo/LznmLr3SNY4Pj7kUWKy9pbhX3fLzGLB8UokaQjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gb+PQlQN8CmEhNOi12SdXoCaMtJ60Sb6zz6fn+JlK0Q=;
 b=IEpVOj6BCm+bKYVPxlE/tjE4ITQaMWxPOfgxDl8PIDndAw+iRanFbvo4+QxCLJkeM8SjvqpkKWaw1UaU2BqlRHmYOhxcvZ42+2/qIBTg/UQK7AqQRCSWIDb9wggZ1RE8v/nqyLp2UCk6uyF0g4l0umZFDQx+Q/9P/LfzyT9K/w9xQU7uL5JJLS+6vgw2qAM+DpFPkyhPZw8nzMXYA/eQVTYeoIuCmkOqi18ET/Vu0oN7s4u1KAQOEYVxlk2RgPTGeGrLMmSmdHHbwaORYh8cXs8G4VKsjz9uOPYRt8/KsCZcVLmqN5G6zNOuBWD3iKfsU1R6+ISYDfWCwjobpUaqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN0PR11MB6133.namprd11.prod.outlook.com (2603:10b6:208:3cb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30; Thu, 21 Sep
 2023 02:27:05 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 02:27:05 +0000
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
Subject: RE: [PATCH v1 06/22] vfio/common: Add a vfio device iterator
Thread-Topic: [PATCH v1 06/22] vfio/common: Add a vfio device iterator
Thread-Index: AQHZ2zAmb8M8reSSS0+IP/LBpi8W2LAjxMqAgADmyOA=
Date: Thu, 21 Sep 2023 02:27:05 +0000
Message-ID: <SJ0PR11MB67446FD836EA0AA5376B658192F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-7-zhenzhong.duan@intel.com>
 <7a8611de-eef9-9e11-766e-77c20d6973b7@redhat.com>
In-Reply-To: <7a8611de-eef9-9e11-766e-77c20d6973b7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MN0PR11MB6133:EE_
x-ms-office365-filtering-correlation-id: 3b36baa8-f0a2-486b-f731-08dbba4a3f1f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ru4/1GWKFd/FTo/+Bk+0bcng8vLuDvExE6YM/9Eqg8d2o7jq+OTHgSl2zGFtDtkUyyuf4DT8eB9KA4FQ0C/WkpGioVcBw8P32mk8uJlamMOVnuPABaEodrgPceRpOz1hazIuXpBct17Zd0SWzYR6e7mH8QKO+ZUPBqHWz2+PEsWEj5eGWf/vX4QuG98qYRuG9dwJLjfz4Ui1K/nqzI3/DMI42OrQ5qR0ULTvX3Zgl6dzCRyw5eM0OHPo+jGRd6XlSCJcJOfwvaVZzIl88zyiCnMFBRLtAPzcXCz9oGRPJ7QS1k7AK6VmqCKaYuqlE2pRvfuK6+P5tnIMZfiBSETp/AF1bGby69eSpFfPZ0/dvO7iMZaK5htCkbhAmXkDQrlKKb+2xRz/rYteqrxkpsD1LJ4Si5lnJXc6pDgimURe0/fYXcXw2nGyHSSwfkQVLNblUpoD/DGZX9NxVzY0bAvQL2FOYiLz1Wp5V7iaItGl3XPkmxjmN064SYpc2EUEgiic2VvOyyQSsvgn/zyuE9XGDMUpTI6uRxDvUGqWvNq+gRIPFGDATTcrHw25iI8WqwrCXCSGOrNb1jXKl/16t97+mz3gZgAbCzF8pMbajDXZCiToFvQL7qfx8n6TROy45Dh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199024)(186009)(1800799009)(6506007)(7696005)(33656002)(122000001)(38070700005)(38100700002)(55016003)(82960400001)(86362001)(26005)(2906002)(9686003)(478600001)(83380400001)(5660300002)(52536014)(8676002)(110136005)(4326008)(76116006)(8936002)(66556008)(66446008)(316002)(64756008)(66476007)(41300700001)(54906003)(107886003)(71200400001)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFVMOVNwK25SME9FUEVkMjh6alB6UHVKWlhhNjBnU2ZlR1ZHVE5lSTRCK0xv?=
 =?utf-8?B?My8vVzRNZzIrNFhiblJDdVhkKzZtdlZic2hpNWlHMEx1c0tQZmxtZ3F3ditD?=
 =?utf-8?B?VW5QVGg4YmlXczUxaGNjMVVCQzdvMWYreFUxUVFDUXZ5VnZKYlg3eWhwYmRV?=
 =?utf-8?B?Z0hpZFZ0NWo4M0x5QTgrRzJUdG5FYlVKOVlvcDNRUVNxa2sycUpUK1JGckd6?=
 =?utf-8?B?c3hTejRwOEMxVTRvR2xUdTdtWXQwSFFRQVowcGp0WGNvemFyc2wxSkdqdUJE?=
 =?utf-8?B?UktqaVdDaTY5WWhNTDlNYTNWTkR1QlFwZGN0UEdEM0NpM21EaHVUajBBMUVD?=
 =?utf-8?B?dmlxSE5CeitOQ1daMGdQQVY3VWhWcGgvWG9GOEpsc3NFMFlSQk42ZDhsd0Vu?=
 =?utf-8?B?dEtHSGxKNVB1M3kxMXVRZW4vWUpBTzBjV0FqbSszYXBsQ212dDVyb3l0T1Nr?=
 =?utf-8?B?bHVhcis0eEQvWWZ6R1JuRU9BSWxLOU1TaVhkL3Z0WWdEWjdYSmYreWRVOGR3?=
 =?utf-8?B?T3ByaVB1K2xab2tuQWxSRWNla0NmVnhBNDhJUGcxNndwa0REWks1Q2haRnFo?=
 =?utf-8?B?eHVYZXZuSStmZjZ6Sk81WlhCaFM4R04vc2RiTC91KzFiR2Q3Tlg3dkNYaCs5?=
 =?utf-8?B?bWNiSXZIL2h4V2VqVUI1VTZJc2ZOcyt2NU1MMGFBNXpwNmdndmVxRWJoMDNs?=
 =?utf-8?B?ajgzOHVlMnJ3cjYrSXZaVVBSMXBldml3QnlVK1kzWVFaRkx0ZGRiK05nVUpH?=
 =?utf-8?B?TFdwMFFENXdQNCtNeXorWmU5Tkt0eEZlbmV0TlZNaEs2RXFSOUVOMlh3cE5H?=
 =?utf-8?B?ZGRXQ0hRN2NVYW1tZXozWm9UUHJrdnJhNFQzSEpFMHJjcXl2TzJZcDJ4RGh3?=
 =?utf-8?B?dnJmSkJ5ZUtjVkFUMUlnUkl1eU5yUnVYTUdEVG5rSURsOHpxbUNwVDRteWpH?=
 =?utf-8?B?K0s2NWtpdHRibFkwdU0zekVBcXFSVmNaVVRYOFdhSXRCclBqcGhTM28zQTNZ?=
 =?utf-8?B?dGZKWUVGbGcxZTJBQlVoVEd0d3JqdTY0MWVHZTMxV1JZSjM5RHUwUTFaOTNv?=
 =?utf-8?B?dzloTWtYTlF4M05OOE5nTEUrczVLUmFGWFV3bUxLWjlIelVKdVRvVWcrUG9K?=
 =?utf-8?B?aUFDdkNOaEgyMHoxL0FRTHdYd09IRksyRXRtV2tpbVlCdGVrOXI2Y3FqVnpi?=
 =?utf-8?B?V2NaZXYzdXVUUHpUc3ZPajBrS0U1RlhFdGZnODRtdEZCdG5kdVQxQ3NCZUQr?=
 =?utf-8?B?U0YyRi9BdFBJY09PR2xLS01KTUgvQ1lZYkx6STYwVzk3Yjd1TDNKajJtdEpP?=
 =?utf-8?B?eFUwN1EzTkVMVExtVXRMRk1jdUNPVU45WnNDSTZqNGF3WWxabFpNd0VWVkRz?=
 =?utf-8?B?T0JFR1pxSnIvaHpVYlhneXAwSG1yd0dhMVYzaEI1RWlvaUJ2Q25YMXlYcUY5?=
 =?utf-8?B?OWZCZWlUNTB4ZzdLRmR2RmZhcHZRR095TExIQ2RNK2o5RDFOTi9aVUdDYnRO?=
 =?utf-8?B?WlJvd0l3L2N5a0VNRnhZNkRscnIrTE5iWE53NkszNWJJNzZJRGF6YTQrNVA5?=
 =?utf-8?B?OWlYWGFvbnRzQnkyeXVnMldMRTJISk4vR1Zpa3FFb2ovWDJGMmJUMzRPekhz?=
 =?utf-8?B?Y3RQdFh1Q202SytqQWlnWHJ4VHNqUVZpZkxZK2ErTW9jcTFTWUs2eHYwenFH?=
 =?utf-8?B?bWlMY2N0YWl2ZElLRHkwWlJxRnV3dmV4QnJBVG5TeVdncFVscFhiKy96NXNr?=
 =?utf-8?B?SUxBZmdBT1lPWGdzRXhjY3ZhcVdFR2ZZZnJDeTdyYXFVZi9tcEFEcFFVOGpp?=
 =?utf-8?B?UCt0VWxMRnN6ZjJxMDlSV1BKaC9XK1pvTFlGSzBPdEo3cXVnbm9PK2o4NFBj?=
 =?utf-8?B?NWR3VXNZY1BuZzRPUW9pa0FoOS9acC9mSlo5RWFzMHBIUTFtM1R1NVVSWVlH?=
 =?utf-8?B?eTRVaG1uU3pscEN1MXV4QTFyM3F3RlJJMHJsd3F0YkR6OXdVMVVsMDBsbnVk?=
 =?utf-8?B?OUpvaDFvbWRuUEtxd2EzdzNWL0VrYjY5dVpLRU56Q0pSejBoNVhkeFpBWkV1?=
 =?utf-8?B?OGI4NE9ZWjR1TXZ6UC92L2xWK1pnNS9jazFkUFVVYTVhdER4VWk0VTl1YmZp?=
 =?utf-8?Q?GqQ1eLC+uIQKNGJD6rapS9llC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b36baa8-f0a2-486b-f731-08dbba4a3f1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 02:27:05.2061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSXUvcx53h5asInIsm+r1rTRpRNVUMuyXsDH3thIK+hY8NXpZi+8xR8A+c/agsJCAfiJ01XGPEP75lfDYNft8wd5j8Q8VEjI1g5KpPUGbSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6133
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIw
LCAyMDIzIDg6MjYgUE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDA2LzIyXSB2ZmlvL2NvbW1v
bjogQWRkIGEgdmZpbyBkZXZpY2UgaXRlcmF0b3INCj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+T24g
OC8zMC8yMyAxMjozNywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBXaXRoIGEgdmZpbyBkZXZp
Y2UgaXRlcmF0b3IgYWRkZWQsIHdlIGNhbiBtYWtlIHNvbWUgbWlncmF0aW9uIGFuZCByZXNldA0K
Pj4gcmVsYXRlZCBmdW5jdGlvbnMgZ3JvdXAgYWdub3N0aWMuDQo+PiBFLng6DQo+PiB2ZmlvX21p
Z19hY3RpdmUNCj4+IHZmaW9fbWlncmF0YWJsZV9kZXZpY2VfbnVtDQo+PiB2ZmlvX2RldmljZXNf
YWxsX2RpcnR5X3RyYWNraW5nDQo+PiB2ZmlvX2RldmljZXNfYWxsX2RldmljZV9kaXJ0eV90cmFj
a2luZw0KPj4gdmZpb19kZXZpY2VzX2FsbF9ydW5uaW5nX2FuZF9taWdfYWN0aXZlDQo+PiB2Zmlv
X2RldmljZXNfZG1hX2xvZ2dpbmdfc3RvcA0KPj4gdmZpb19kZXZpY2VzX2RtYV9sb2dnaW5nX3N0
YXJ0DQo+PiB2ZmlvX2RldmljZXNfcXVlcnlfZGlydHlfYml0bWFwDQo+PiB2ZmlvX3Jlc2V0X2hh
bmRsZXINCj4+DQo+PiBPciBlbHNlIHdlIG5lZWQgdG8gYWRkIGNvbnRhaW5lciBzcGVjaWZpYyBj
YWxsYmFjayB2YXJpYW50cyBmb3IgYWJvdmUNCj4+IGZ1bmN0aW9ucyBqdXN0IGJlY2F1c2UgdGhl
eSBpdGVyYXRlIGRldmljZXMgYmFzZWQgb24gZ3JvdXAuDQo+Pg0KPj4gTW92ZSB0aGUgcmVzZXQg
aGFuZGxlciByZWdpc3RyYXRpb24vdW5yZWdpc3RyYXRpb24gdG8gYSBwbGFjZSB0aGF0IGlzIG5v
dA0KPj4gZ3JvdXAgc3BlY2lmaWMsIHNheWluZyBmaXJzdCB2ZmlvIGFkZHJlc3Mgc3BhY2UgY3Jl
YXRlZCBpbnN0ZWFkIG9mIHRoZQ0KPj4gZmlyc3QgZ3JvdXAuDQo+SSB3b3VsZCBtb3ZlIHRoZSBy
ZXNldCBoYW5kbGVyIHJlZ2lzdHJhdGlvbi91bnJlZ2lzdHJhdGlvbiBjaGFuZ2VzIGluIGENCj5z
ZXBhcmF0ZSBwYXRjaC4NCg0KR290IGl0Lg0KDQo+YmVzaWRlcyzCoCBJIGRvbid0IGNhdGNoIHdo
YXQgeW91IG1lYW4gYnkNCj4ic2F5aW5nIGZpcnN0IHZmaW8gYWRkcmVzcyBzcGFjZSBjcmVhdGVk
IGluc3RlYWQgb2YgdGhlIGZpcnN0IGdyb3VwLiINCg0KQmVmb3JlIHBhdGNoLCByZXNldCBoYW5k
ZXIgaXMgcmVnaXN0ZXJlZCBpbiBmaXJzdCBncm91cCBjcmVhdGlvbiwNCmFmdGVyIHBhdGNoLCBp
dCdzIHJlZ2lzdGVyZWQgaW4gZmlyc3QgYWRkcmVzcyBzcGFjZSBjcmVhdGlvbi4NClRoZSBtYWlu
IHB1cnBvc2UgaXMgdG8gbWFrZSB0aGlzIGNvZGUgZ3JvdXAgYWdub3N0aWMuDQoNCkZvciB0aGUg
ZGV2aWNlIGl0ZXJhdGlvbiBwYXJ0IG9mIHRoaXMgcGF0Y2gsIEkgcGxhbiB0byBmb2xsb3cgQWxl
eCdzDQpzdWdnZXN0aW9uIHRvIHVzZSB2ZmlvX2RldmljZV9saXN0IGZvciBib3RoIEJFcy4gVGhh
bmtzIGZvciB5b3VyDQp0aW1lIG9uIHRoaXMgcGF0Y2guDQoNCkJScy4NClpoZW56aG9uZw0K

