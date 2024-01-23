Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA37838A41
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 10:26:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSD1z-0008Ql-K4; Tue, 23 Jan 2024 04:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSD1v-0008Qc-Gk
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 04:25:15 -0500
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSD1s-0003F8-TS
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 04:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706001912; x=1737537912;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7AznJK1o+ksVXn5Ff+zY3XOJffL7YM344fe/8l2weWI=;
 b=VOaefWq7wDn0I1TCm38DIl9V8btM7z+idd6T24JFqh7bk5Tg21UHppkt
 J6FJdmrNsBNz+YDl6HYht2vP29HD6NfXwH29WBS9rYVtHYbfAL9PstoQF
 EqzrZB/LV58JwQVyaTKngj5Kp/ZpB7uiLkRPy+EdpOK3XDdx+McRpa+Fq
 nPv418mgFBYi6ZXDmAkPvD3REC36xAquT2MchAngka2RFAimgQ9ONqa7J
 bXSQU61QS5NJJxYTTHeQef6GUl+CiqNQysWpU2YiGLH4psFCPPZYRUwxH
 ihhfurL1Pgv/oBEqVR9nlD5Y0QShCKIR04rjmcR8cCEd9ofcRnSE4VsSk A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="432626016"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; d="scan'208";a="432626016"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2024 01:25:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; d="scan'208";a="27956708"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jan 2024 01:25:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 01:25:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 01:25:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 01:25:07 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 01:25:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nx+IYmsONFR/f+69FAqO56kklJZqq5NV7WAx41kdRFoWgs3QBE4XS9FvARD4BcEjTXS+wo/q69DCd8BDlQLLNyrO3QWp86oVdM5/+wQQIDS9jnxRXJCrFecpQ0Oa+beUtPeq9WRVYlZ03Sg78YhJUziQlQ9Y6/RIpjYhCv9ALzNRIOVX/c/bvqAiOMdi/yFTe91bPW24XqY0b4G7k6q2LEWVThH7csthsmamgDMG/ob/v9yDiQOa4g8hcW2nTujr/6aahe1guSfbDTripUG11lVRt26hojXL8q8Uiy7xL+WkrP6z0x3+aon5RijWeztp5Sj8EPAGqgYxmueax3Kixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AznJK1o+ksVXn5Ff+zY3XOJffL7YM344fe/8l2weWI=;
 b=aRKllP4hjUSg3ARYzxJMUcQ2wlgN0oToEeTCSTDPo0DAFycM/0uLOFNZ7V/Pku9CsMBZjXPZKa2oqCl5mZrNd40oT3ROTroEmVG91WARHtJNkPIymnX7u3cCRQYKQNXp6GGero9TO/TZuRh9zP3HuXxyY6tPASXpkauSwF9+pWz3KATXdsPgqlV6JgaKrj9e5TAHIFfnj8d8ecmBWJLLohkJzl8IcV676CrkCpSoninq+fjKn3TY4JwFMqCR51wW9dNNUg7rd0k//GMhvvGtvOE1+gfIxFO8qb2K9tSl2suaD6ldepWOh1E3rtpdqeapl5g/QW9OcaMe/N7vGz75cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6651.namprd11.prod.outlook.com (2603:10b6:510:1a9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 09:25:05 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 09:25:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH rfcv1 2/6] hw/pci: introduce
 pci_device_set/unset_iommu_device()
Thread-Topic: [PATCH rfcv1 2/6] hw/pci: introduce
 pci_device_set/unset_iommu_device()
Thread-Index: AQHaR5vrPb8w/pVxfEGbuNI7QgnDG7DmGFKAgADgPYCAABb/AIAAFRcw
Date: Tue, 23 Jan 2024 09:25:05 +0000
Message-ID: <SJ0PR11MB6744254204FF8E9D3E1169C892742@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-3-zhenzhong.duan@intel.com>
 <f2ca6b36-922c-42e4-98d6-59616099980a@redhat.com>
 <SJ0PR11MB6744075B12BE080F9BBEC37792742@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <1560b289-3389-4027-8c93-4e71b2c6cd77@redhat.com>
In-Reply-To: <1560b289-3389-4027-8c93-4e71b2c6cd77@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6651:EE_
x-ms-office365-filtering-correlation-id: 2d3a98a6-be02-442e-4b28-08dc1bf52f3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZY0kk1ZuNqOjNi8/RxTHBSr0wJXTONP67WfOVYniOk5lYs+EX7l56jzY8ZNNo+NT0tyGpFbaT3qUPoMS3gFvB9M1AYhI+HD27H3S6pSY/T5CUHtEeepdGlltvZIcD1755tHYfMLuz8s9ObCq7Yd5OUr7KxA0IA30Bp3FavNhkr4hsvAS9IAV1WaUN1hq6EaijhRUE4LcP/qa3G7l5DWxcMVTPtpU6wVZ2G4IW0vODH3Kuhvww2mRT0+gMtyYGyS8M15MsTHBrIZnVmgWlrSdaQ1+1G9b9eQWdSrJUiXaxr1fXk3mKRosKxX77UuV+oC5Eyj7iUOiItDnYd/8rH1SDfFOS/5lLC0qUmke88no4AXAnaHyY1giFslj5u7tZsYNQOh3rS9wtgdLgQONaNxXU3DA9ULsPMj5kCEXu8KTEzYNxmRDR7VQR2PbxRZc5HIGDb/b4zVURiPTmpG707ZRBbO9wyibcdEtpFSkBDb2Y7JM7tzCflLUzD7IXC07yfYV9bFMOHDc87zNjXeyFUhdKu6iAxBctJ3NQS5XkYUdMTIkUMquvbFCxqs5O4Eauflk8H+AwX62KIcql03KnBlPjv2MZpZFCh3dAoAR3XsOFTC+trdCT191Z96aEey7p+USXd8X2TSFM1zW1chU3+xyOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(55016003)(66574015)(26005)(71200400001)(6506007)(7696005)(53546011)(9686003)(122000001)(82960400001)(38100700002)(86362001)(33656002)(38070700009)(41300700001)(478600001)(2906002)(83380400001)(5660300002)(7416002)(52536014)(8936002)(110136005)(8676002)(54906003)(76116006)(66476007)(64756008)(66446008)(4326008)(66556008)(66946007)(316002)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlZLU1ladG1HTEs1ZWtRQ0wwZVZEZE9yZXNlbXc0ejlTMDdxQVBZVlJnemRj?=
 =?utf-8?B?Y1JOZUxHdVN6b2NDVzhBVVlGM1NNVWpnSllhR1hJa0FnU0dGdmN2RzR3SEpD?=
 =?utf-8?B?WXJONU5PS3Nuaisvd0pVcEpybmhJVWpCOWZxOHJFMkFuN1dubGJCUWNVWDdY?=
 =?utf-8?B?TGhURVRGVHllU0l4VDN3VTIvdVprSUZHcmUweHZLWnFsQmhUWmU0OVJXM0k0?=
 =?utf-8?B?ZmxZK2JxWWx0TWJjWklOMDZVUGlmREs4MzdwZHFyQ2hNc2RPeGdEeDZyc0RI?=
 =?utf-8?B?dk00dGswYlNSWHVRMzZCNGhMU0RCaGFvd2s0VnhYdG1qTTFFSFlNbzh2clg1?=
 =?utf-8?B?VzlHQUxqem12ZEloeDdwOE9VNXVZL0J0UFo0VEFiTy9udWxDOGdjbU8zT2NO?=
 =?utf-8?B?RzBBaGwvbGo5S1BrRVdiTE5melVpQzQxTEhOMTdrK3JtWk1nMmVxc0ZiY05Z?=
 =?utf-8?B?VjNBaFZGcFN0NEQrekM3Vzhqb2FQVW1XM3V0amRGUklMeDhOaFlGTVlucTUz?=
 =?utf-8?B?bnZVTHowWmNzRGppZU5wR20xQkVDM0ljOW5HY09WaFBtNEZ0bkNjUE1Wc2Zn?=
 =?utf-8?B?c1NVWjdPTTgyTnRqUHBMR2dOeklHVjRhY2hob21NSVUxNk9wR1Q5bGxLTWVr?=
 =?utf-8?B?TytyMU43SjBNWXNjN3hYZ0hEcXpqK3hnbk8xOGtBa2l1elhZbnUySnJueXlz?=
 =?utf-8?B?YmkzS0hjMGdUNUNibDVYU2J4SVQ0cmIwNzF3MllLekZZbjBEc1JSTE9KL1dn?=
 =?utf-8?B?cVB0WHF6KzZwWjE3ZWxjb0tKZGFqVCtlMnZaaDA1MkwzS25yd2FOOFVVOVI3?=
 =?utf-8?B?a2l5L2dYWmJKNnJnWnpyWkVqcUkwejd1Vld6bHdwM3dpT1RNd2xVU3FTTURr?=
 =?utf-8?B?eGJsdmhWaW1CWmt1RmIyQ1V5amNuelZkZ0V3UGVpbndtVGRNQ3NSdDRqSkg1?=
 =?utf-8?B?aGl0OExLUkVUL3MrcEpKSXhMZkhSWnlvb241bjdoTUhObTdYdHBNRXU5SVRI?=
 =?utf-8?B?MG9meWZTbmtMODBDQnJMTWE4ejY5aG9pUnFCNmF5WFQ2Nkd0aTRQNllkem1v?=
 =?utf-8?B?bzl3d1lUdnJldG9RYmhFUWlHUTcxcWMxT1B2R2tSMng4azU1MHFtRHBUSXpY?=
 =?utf-8?B?YjFyWndkOHVIOXpEMG1OSk4xdVBjNTFJZ0J5UzdJNnprMDZ5RmxuWmpJZTRu?=
 =?utf-8?B?ZFgyVVZPWVpUOWxnRDhPTWk4VFYzZDN0VG93ak53OWgvbVZ0QjdRUlEwR0Zt?=
 =?utf-8?B?dXVKTnAyeWFQdS85cXlOYUN2U2FiQ3g4NC81Y01FeDNCazFCOTRKbFQ5UkNQ?=
 =?utf-8?B?MVdjc1lhSUxmRE9nemF6QzJhcHVCQ3Q1UFBEQ3g3ZFZET0VvTXhrOWdvVDhU?=
 =?utf-8?B?Uzd0b3ErWFh4SWNXN1d0ckVXN2cweWgzMDluREVoS0VkeUdIM05IQnNQTFJl?=
 =?utf-8?B?cFJ4ZW9WYTd1YlJmSFNFL2psY2FsVjREZjJ1cmpKWkRTd1Z2SFI4eXpqc2Z3?=
 =?utf-8?B?UHE3YnNuQWY2SzhWNjhxcDhaRTU2MUNoL1d1UUU2ZWdDUlFIZUQ0MVlqNlNX?=
 =?utf-8?B?VmtGb3NGRUcvMzlBUzFraFp2cUxiRzB2Z1U2ZHAzZjRsYjhibS9yOXZJR090?=
 =?utf-8?B?c25LdUJCdlpmOG1TRFVZQ0dmQkpyWVVJekRXTjlGbjAxTU1OMUswZEgvTkVa?=
 =?utf-8?B?d04rUHhtMnZQVkNQZ3ZRdnAyb2QxYzZpcGQyUU5VOWx1RVV3cVk0NjdJU1Rl?=
 =?utf-8?B?eGhFb3J5d2Q4T2xnSDcyL2pybm9EeEJiOEx4U3Urd1ZVeWhlSUFVRmx2M01S?=
 =?utf-8?B?TjRCVThPWkxjdWxzWDVWdzR1SE9QQ09CU09xU3B2dGhSZ3JZS3VDREZ6eStB?=
 =?utf-8?B?NDhLMERiRUNxYzd3eFk4ZE1RbUNpOGMxQkxRMFVQYVhQL3FEV1VCb2xXWCsy?=
 =?utf-8?B?ZlVjRXUxMEV3aTM0OERIbEwvRDVodnBaZCtxYUdKa3R2ZWFKZ01iZG1uMFRF?=
 =?utf-8?B?dVFtOHZJNnVmWHhXSUhEaDEzTnN1K204KytodTlHMWxMNUczVUE3cDY3akc3?=
 =?utf-8?B?OURQQVVJSzY2a0hjSFBNK25YTk5nZHZienFueVFnaVlOMkFMOEZDcE1WN1Ja?=
 =?utf-8?Q?2/0ob996mXKNe0lNU2S0Nuxws?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3a98a6-be02-442e-4b28-08dc1bf52f3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 09:25:05.3005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eZKt2BdPQFj9MIY+1tjCD+Cucvr5KoQ2bENB/fKiNP12v927Hf1isXC77zEmabK2FzGTVA8LcrjIP1NWJy5wSKk5D8qHWoA9hRnI8oloAKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6651
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDIvNl0gaHcvcGNp
OiBpbnRyb2R1Y2UNCj5wY2lfZGV2aWNlX3NldC91bnNldF9pb21tdV9kZXZpY2UoKQ0KPg0KPk9u
IDEvMjMvMjQgMDc6MzcsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+DQo+Pg0KPj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0By
ZWRoYXQuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggcmZjdjEgMi82XSBody9wY2k6IGlu
dHJvZHVjZQ0KPj4+IHBjaV9kZXZpY2Vfc2V0L3Vuc2V0X2lvbW11X2RldmljZSgpDQo+Pj4NCj4+
PiBPbiAxLzE1LzI0IDExOjEzLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4gRnJvbTogWWkg
TGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+DQo+Pj4+IFRoaXMgYWRkcyBwY2lfZGV2aWNl
X3NldC91bnNldF9pb21tdV9kZXZpY2UoKSB0byBzZXQvdW5zZXQNCj4+Pj4gSU9NTVVGRERldmlj
ZSBmb3IgYSBnaXZlbiBQQ0llIGRldmljZS4gQ2FsbGVyIG9mIHNldA0KPj4+PiBzaG91bGQgZmFp
bCBpZiBzZXQgb3BlcmF0aW9uIGZhaWxzLg0KPj4+Pg0KPj4+PiBFeHRyYWN0IG91dCBwY2lfZGV2
aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oKSB0byBmYWNpbGl0YXRlDQo+Pj4+IGltcGxlbWVudGF0
aW9uIG9mIHBjaV9kZXZpY2Vfc2V0L3Vuc2V0X2lvbW11X2RldmljZSgpLg0KPj4+Pg0KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+Pj4gU2lnbmVkLW9m
Zi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1i
eTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4gLS0tDQo+
Pj4+ICAgIGluY2x1ZGUvaHcvcGNpL3BjaS5oIHwgMzkNCj4rKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLQ0KPj4+PiAgICBody9wY2kvcGNpLmMgICAgICAgICB8IDQ5DQo+Pj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4+Pj4gICAgMiBmaWxl
cyBjaGFuZ2VkLCA4NiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9wY2kvcGNpLmggYi9pbmNsdWRlL2h3L3BjaS9wY2kuaA0K
Pj4+PiBpbmRleCBmYTYzMTNhYWJjLi5hODEwYzBlYzc0IDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNs
dWRlL2h3L3BjaS9wY2kuaA0KPj4+PiArKysgYi9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KPj4+PiBA
QCAtNyw2ICs3LDggQEANCj4+Pj4gICAgLyogUENJIGluY2x1ZGVzIGxlZ2FjeSBJU0EgYWNjZXNz
LiAgKi8NCj4+Pj4gICAgI2luY2x1ZGUgImh3L2lzYS9pc2EuaCINCj4+Pj4NCj4+Pj4gKyNpbmNs
dWRlICJzeXNlbXUvaW9tbXVmZF9kZXZpY2UuaCINCj4+Pj4gKw0KPj4+PiAgICBleHRlcm4gYm9v
bCBwY2lfYXZhaWxhYmxlOw0KPj4+Pg0KPj4+PiAgICAvKiBQQ0kgYnVzICovDQo+Pj4+IEBAIC0z
ODQsMTAgKzM4Niw0NSBAQCB0eXBlZGVmIHN0cnVjdCBQQ0lJT01NVU9wcyB7DQo+Pj4+ICAgICAg
ICAgKg0KPj4+PiAgICAgICAgICogQGRldmZuOiBkZXZpY2UgYW5kIGZ1bmN0aW9uIG51bWJlcg0K
Pj4+PiAgICAgICAgICovDQo+Pj4+IC0gICBBZGRyZXNzU3BhY2UgKiAoKmdldF9hZGRyZXNzX3Nw
YWNlKShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQNCj4+PiBkZXZmbik7DQo+Pj4+ICsg
ICAgQWRkcmVzc1NwYWNlICogKCpnZXRfYWRkcmVzc19zcGFjZSkoUENJQnVzICpidXMsIHZvaWQg
Km9wYXF1ZSwNCj5pbnQNCj4+PiBkZXZmbik7DQo+Pj4+ICsgICAgLyoqDQo+Pj4+ICsgICAgICog
QHNldF9pb21tdV9kZXZpY2U6IHNldCBpb21tdWZkIGRldmljZSBmb3IgYSBQQ0kgZGV2aWNlIHRv
DQo+Pj4gdklPTU1VDQo+Pj4+ICsgICAgICoNCj4+Pj4gKyAgICAgKiBPcHRpb25hbCBjYWxsYmFj
aywgaWYgbm90IGltcGxlbWVudGVkIGluIHZJT01NVSwgdGhlbiB2SU9NTVUNCj4+PiBjYW4ndA0K
Pj4+PiArICAgICAqIHV0aWxpemUgaW9tbXVmZCBzcGVjaWZpYyBmZWF0dXJlcy4NCj4+Pj4gKyAg
ICAgKg0KPj4+PiArICAgICAqIFJldHVybiB0cnVlIGlmIGlvbW11ZmQgZGV2aWNlIGlzIGFjY2Vw
dGVkLCBvciBlbHNlIHJldHVybiBmYWxzZSB3aXRoDQo+Pj4+ICsgICAgICogZXJycCBzZXQuDQo+
Pj4+ICsgICAgICoNCj4+Pj4gKyAgICAgKiBAYnVzOiB0aGUgI1BDSUJ1cyBvZiB0aGUgUENJIGRl
dmljZS4NCj4+Pj4gKyAgICAgKg0KPj4+PiArICAgICAqIEBvcGFxdWU6IHRoZSBkYXRhIHBhc3Nl
ZCB0byBwY2lfc2V0dXBfaW9tbXUoKS4NCj4+Pj4gKyAgICAgKg0KPj4+PiArICAgICAqIEBkZXZm
bjogZGV2aWNlIGFuZCBmdW5jdGlvbiBudW1iZXIgb2YgdGhlIFBDSSBkZXZpY2UuDQo+Pj4+ICsg
ICAgICoNCj4+Pj4gKyAgICAgKiBAaWRldjogdGhlIGRhdGEgc3RydWN0dXJlIHJlcHJlc2VudGlu
ZyBpb21tdWZkIGRldmljZS4NCj4+Pj4gKyAgICAgKg0KPj4+PiArICAgICAqLw0KPj4+PiArICAg
IGludCAoKnNldF9pb21tdV9kZXZpY2UpKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludDMy
X3QgZGV2Zm4sDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVGRERldmlj
ZSAqaWRldiwgRXJyb3IgKiplcnJwKTsNCj4+Pj4gKyAgICAvKioNCj4+Pj4gKyAgICAgKiBAdW5z
ZXRfaW9tbXVfZGV2aWNlOiB1bnNldCBpb21tdWZkIGRldmljZSBmb3IgYSBQQ0kgZGV2aWNlDQo+
ZnJvbQ0KPj4+IHZJT01NVQ0KPj4+PiArICAgICAqDQo+Pj4+ICsgICAgICogT3B0aW9uYWwgY2Fs
bGJhY2suDQo+Pj4+ICsgICAgICoNCj4+Pj4gKyAgICAgKiBAYnVzOiB0aGUgI1BDSUJ1cyBvZiB0
aGUgUENJIGRldmljZS4NCj4+Pj4gKyAgICAgKg0KPj4+PiArICAgICAqIEBvcGFxdWU6IHRoZSBk
YXRhIHBhc3NlZCB0byBwY2lfc2V0dXBfaW9tbXUoKS4NCj4+Pj4gKyAgICAgKg0KPj4+PiArICAg
ICAqIEBkZXZmbjogZGV2aWNlIGFuZCBmdW5jdGlvbiBudW1iZXIgb2YgdGhlIFBDSSBkZXZpY2Uu
DQo+Pj4+ICsgICAgICovDQo+Pj4+ICsgICAgdm9pZCAoKnVuc2V0X2lvbW11X2RldmljZSkoUENJ
QnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50MzJfdA0KPj4+IGRldmZuKTsNCj4+Pj4gICAgfSBQ
Q0lJT01NVU9wczsNCj4+Pj4NCj4+Pj4gICAgQWRkcmVzc1NwYWNlICpwY2lfZGV2aWNlX2lvbW11
X2FkZHJlc3Nfc3BhY2UoUENJRGV2aWNlICpkZXYpOw0KPj4+PiAraW50IHBjaV9kZXZpY2Vfc2V0
X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRldiwgSU9NTVVGRERldmljZQ0KPj4+ICppZGV2LA0K
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KPj4+
PiArdm9pZCBwY2lfZGV2aWNlX3Vuc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRldik7DQo+
Pj4+DQo+Pj4+ICAgIC8qKg0KPj4+PiAgICAgKiBwY2lfc2V0dXBfaW9tbXU6IEluaXRpYWxpemUg
c3BlY2lmaWMgSU9NTVUgaGFuZGxlcnMgZm9yIGEgUENJQnVzDQo+Pj4+IGRpZmYgLS1naXQgYS9o
dy9wY2kvcGNpLmMgYi9ody9wY2kvcGNpLmMNCj4+Pj4gaW5kZXggNzYwODBhZjU4MC4uMzg0ODY2
MmY5NSAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvcGNpL3BjaS5jDQo+Pj4+ICsrKyBiL2h3L3BjaS9w
Y2kuYw0KPj4+PiBAQCAtMjY3Miw3ICsyNjcyLDEwIEBAIHN0YXRpYyB2b2lkDQo+Pj4gcGNpX2Rl
dmljZV9jbGFzc19iYXNlX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0KPj4+
PiAgICAgICAgfQ0KPj4+PiAgICB9DQo+Pj4+DQo+Pj4+IC1BZGRyZXNzU3BhY2UgKnBjaV9kZXZp
Y2VfaW9tbXVfYWRkcmVzc19zcGFjZShQQ0lEZXZpY2UgKmRldikNCj4+Pj4gK3N0YXRpYyB2b2lk
IHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbihQQ0lEZXZpY2UgKmRldiwNCj4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQ0lCdXMgKiphbGlhc2Vk
X3BidXMsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
UENJQnVzICoqcGlvbW11X2J1cywNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50OF90ICphbGlhc2VkX3BkZXZmbikNCj4+Pj4gICAgew0KPj4+PiAg
ICAgICAgUENJQnVzICpidXMgPSBwY2lfZ2V0X2J1cyhkZXYpOw0KPj4+PiAgICAgICAgUENJQnVz
ICppb21tdV9idXMgPSBidXM7DQo+Pj4+IEBAIC0yNzE3LDYgKzI3MjAsMTggQEAgQWRkcmVzc1Nw
YWNlDQo+Pj4gKnBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZShQQ0lEZXZpY2UgKmRldikN
Cj4+Pj4NCj4+Pj4gICAgICAgICAgICBpb21tdV9idXMgPSBwYXJlbnRfYnVzOw0KPj4+PiAgICAg
ICAgfQ0KPj4+PiArICAgICphbGlhc2VkX3BidXMgPSBidXM7DQo+Pj4+ICsgICAgKnBpb21tdV9i
dXMgPSBpb21tdV9idXM7DQo+Pj4+ICsgICAgKmFsaWFzZWRfcGRldmZuID0gZGV2Zm47DQo+Pj4+
ICt9DQo+Pj4+ICsNCj4+Pj4gK0FkZHJlc3NTcGFjZSAqcGNpX2RldmljZV9pb21tdV9hZGRyZXNz
X3NwYWNlKFBDSURldmljZSAqZGV2KQ0KPj4+PiArew0KPj4+PiArICAgIFBDSUJ1cyAqYnVzOw0K
Pj4+PiArICAgIFBDSUJ1cyAqaW9tbXVfYnVzOw0KPj4+PiArICAgIHVpbnQ4X3QgZGV2Zm47DQo+
Pj4+ICsNCj4+Pj4gKyAgICBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oZGV2LCAmYnVz
LCAmaW9tbXVfYnVzLA0KPiZkZXZmbik7DQo+Pj4+ICAgICAgICBpZiAoIXBjaV9idXNfYnlwYXNz
X2lvbW11KGJ1cykgJiYgaW9tbXVfYnVzLT5pb21tdV9vcHMpIHsNCj4+Pj4gICAgICAgICAgICBy
ZXR1cm4gaW9tbXVfYnVzLT5pb21tdV9vcHMtPmdldF9hZGRyZXNzX3NwYWNlKGJ1cywNCj4+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW9tbXVfYnVzLT5pb21tdV9vcGFx
dWUsIGRldmZuKTsNCj4+Pj4gQEAgLTI3MjQsNiArMjczOSwzOCBAQCBBZGRyZXNzU3BhY2UNCj4+
PiAqcGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3NwYWNlKFBDSURldmljZSAqZGV2KQ0KPj4+PiAg
ICAgICAgcmV0dXJuICZhZGRyZXNzX3NwYWNlX21lbW9yeTsNCj4+Pj4gICAgfQ0KPj4+Pg0KPj4+
PiAraW50IHBjaV9kZXZpY2Vfc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRldiwgSU9NTVVG
RERldmljZQ0KPj4+ICppZGV2LA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBFcnJvciAqKmVycnApDQo+Pj4+ICt7DQo+Pj4+ICsgICAgUENJQnVzICpidXM7DQo+Pj4+ICsg
ICAgUENJQnVzICppb21tdV9idXM7DQo+Pj4+ICsgICAgdWludDhfdCBkZXZmbjsNCj4+Pj4gKw0K
Pj4+PiArICAgIHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbihkZXYsICZidXMsICZpb21t
dV9idXMsDQo+JmRldmZuKTsNCj4+Pj4gKyAgICBpZiAoIXBjaV9idXNfYnlwYXNzX2lvbW11KGJ1
cykgJiYgaW9tbXVfYnVzICYmDQo+Pj4NCj4+PiBXaHkgZG8gd2UgdGVzdCBpb21tdV9idXMgaW4g
cGNpX2RldmljZV91bi9zZXRfaW9tbXVfZGV2aWNlDQo+cm91dGluZXMNCj4+PiBhbmQNCj4+PiBu
b3QgaW4gcGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3NwYWNlKCkgPw0KPj4NCj4+IGlvbW11X2J1
cyBjaGVjayBpbiBwY2lfZGV2aWNlX2lvbW11X2FkZHJlc3Nfc3BhY2UoKSBpcyBkcm9wcGVkIGlu
DQo+PiBiZWxvdyBjb21taXQsIEkgZGlkbid0IGZpbmQgcmVsYXRlZCBkaXNjdXNzaW9uIGluIG1h
aWwgaGlzdG9yeSwgbWF5YmUNCj4+IGJ5IGFjY2lkZW50PyBJIGNhbiBhZGQgaXQgYmFjayBpZiBp
dCdzIG5vdCBpbnRlbnRpb25hbC4NCj4NCj5DYW4gaW9tbXVfYnVzIGJlIE5VTEwgb3Igc2hvdWxk
IHdlIGFkZCBhbiBhc3NlcnQgPw0KDQpJIGRpZyBpbnRvIHRoZSBoaXN0b3J5IGNoYW5nZXMgb2Yg
cGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3NwYWNlKCkgYW5kDQpiZWxvdyBjb21taXQgYWRkZWQg
aW9tbXVfYnVzIGNoZWNrLg0KDQo1YWYyYWUyMzA1MTQgIHBjaTogRml4IHBjaV9kZXZpY2VfaW9t
bXVfYWRkcmVzc19zcGFjZSgpIGJ1cyBwcm9wYWdhdGlvbg0KDQpJbiB0aGVvcnksICFpb21tdV9i
dXMtPnBhcmVudF9kZXYgdGFrZSBwcmVjZWRlbmN5IG92ZXIgIWlvbW11X2J1cywNClNvIHdlIG5l
dmVyIHNlZSBpb21tdV9idXMgTlVMTCwgYXNzZXJ0IG1heSBiZSBiZXR0ZXIuDQoNClRoYW5rcw0K
Wmhlbnpob25nDQoNCg==

