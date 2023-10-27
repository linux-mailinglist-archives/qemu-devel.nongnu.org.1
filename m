Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECABB7D9401
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:42:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJLo-0001GZ-G5; Fri, 27 Oct 2023 05:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qwJLm-0001GI-5F
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:41:54 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qwJLj-0003y8-CJ
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698399711; x=1729935711;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AcVx4Rzi+BUEMcVD3qJgVDF8o2DF8AroTMy6zpvi87Q=;
 b=TeSOK/fZSBY6mBCUI9z4XOEBYxl0b2sRt86U2rQC5R63J06hiL4pMWiI
 ZDrXHmcrynKQTmfg/Kj8LELaGRMGsECtCTMobB74H7ce821Qa+6Ljtfnq
 QQZORzrofZ9UIyaIb8g4+CbJYeQHuWUOtyiXohzXuBskY4jpUm+yx35VX
 KERDEfDxKwQE71qDpNEdqoSlMwwnWQrEQ9+2/7Uvpw3tpTtBv5tDpyqX5
 E17sWAsIl50imP12fhpA5F7ydvMCCU1W07PrGEm/auQSB6TmCjI188w3H
 w7aYve8vyJCfJAtGhtehC8xLW4M9pR/KdCL4alCy1n3yB5h7QaTRczJCr Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="367952905"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; d="scan'208";a="367952905"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2023 02:41:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="933018781"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; d="scan'208";a="933018781"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Oct 2023 02:41:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 02:41:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 02:41:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 02:41:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 02:41:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0H7YT2NJUTOyTcUYuhl3E+UT2ZEjX6qQMMghu9pw/ASShWgYfWgo3fHIFB9CfzSpDqo83AX3ltP49qrvE9n762yNugc3o+L6+l3ZPON9iMVRp/4KoeZqGUS6yF/VYb8gAJb9eyysJWzwff4rKMDpYs6EaBSKEpk5aoBeApqdXFfHVGu7Y3gUYbuKVGvy6fXj6HMYW/xI9A1gX2g4em4uGjt9Z535OKjhJ8HmC+u8nE4wDSovzpKNnpH9j9qN6w/PTQDcRybKzSkacRUsC6mp1jwJwE7ScZtPHd6FvfHycACSguWsCa2V0nz+NKFqSZgFCCGKdx3w+6yu0ToiReJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcVx4Rzi+BUEMcVD3qJgVDF8o2DF8AroTMy6zpvi87Q=;
 b=CzmLmuzFyjbK7ni3MU8eoURaX9fsLo0UP5LAFsmHhuXvAWdQCdsivdtWopsGUBh73+biikTjpbEPwEd6NEuLVQkdU6RVfHcFpOTAjDo3I0NK7pEf8CYeAhTTm2EMWEC6ClxG1Pk+FRCvK7xyXKBP/ee/l9ube0I/QBHLyvBsIh/M+bhtW0WEyrFkmUWekLnGkuLSgSUfx2lqi2jYc6p0pdXwWAuA5xgEGylG+/7d2X6vs2R39W/qbKu7MoXtirmev8gJuBcpXF1WFFAw9hRw3UBhODgBnc9kvIeSCIXJ5mLR3XMeBx7VVpXBNjd/wVgnaatMXAd2kyfle5KcqC44mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by DM4PR11MB5518.namprd11.prod.outlook.com (2603:10b6:5:39a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 09:41:44 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::f30c:1dcb:ea42:650e]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::f30c:1dcb:ea42:650e%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 09:41:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?B?RGFuaWVsIFAuQmVycmFuZ8Op?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Eric Blake
 <eblake@redhat.com>
Subject: RE: [PATCH v3 24/37] backends/iommufd: Introduce the iommufd object
Thread-Topic: [PATCH v3 24/37] backends/iommufd: Introduce the iommufd object
Thread-Index: AQHaB/nlJZm1rfRcfUK2ik07RuZx6rBcENfJgAEtQpCAABH0ZIAAE15Q
Date: Fri, 27 Oct 2023 09:41:44 +0000
Message-ID: <PH7PR11MB6722305E1C2AFE0AECBD97EA92DCA@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-25-zhenzhong.duan@intel.com>
 <87msw5a4z3.fsf@pond.sub.org>
 <SJ0PR11MB6744685EB6B526484F334AB692DCA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <87ttqc31s8.fsf@pond.sub.org>
In-Reply-To: <87ttqc31s8.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|DM4PR11MB5518:EE_
x-ms-office365-filtering-correlation-id: 6a6697f9-0f73-432f-0d60-08dbd6d0ee36
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zpPg4JQdfY0YJ0XytJrD9ex+7rIEtVdsJ9DNO+nXAGJmkYUs0jf6q35eqdVz9b/Vd3WkzNC5Ia0OAfhzMVbZXTKaWnHu0uKJPA54VssHu749wULLgaj+8imFOGvOCzioZZZO7qrEMMxAqbX5gErLU8u9CcXDiFbojmCE/MlvzgoOp/dhLH5DDZEz2fE+zLG5EElzOcUmZ6IDd50pAndmNViitLaPNbRcjRHTDnkZogYvqVbeUobFv8ljXZZHGDFL1RxnGeD4eISjUMv9pzhKgvPlFw8kg6aVMHJF/vNKRZTvBwwTsQT8Mu5/bxqOfQm0zedP15U9SIEeeTOlQp9iXF0qU2jWGPfBZ0rkqCZMpA4s6D/taAYDLXkgMqKFrxuHS5bo7hDibq8smeoVyx7TCmof4iJ9LGe7vXp6j6/tgbseQoLT74iBGV/o9GNZZeyVK1tQyxBpWvvrTtCZalNDA0E5+OTl57d2csTHbID1bMs/GaVJa91wBCYssElto7CYYnGkJegNWg15HJM4sd1lLkdBlDhWiwaDZr5ebKu0WCCZDj0jnSEz6Lb4jglCIWvWKEZNuptG3dwQrHoHm0hiD5MubuYUAuJwC61VrcC49fXilBry5LvU83XTQzoowydc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(122000001)(55016003)(66899024)(33656002)(86362001)(8936002)(4326008)(8676002)(52536014)(82960400001)(38070700009)(478600001)(83380400001)(71200400001)(6506007)(7696005)(53546011)(9686003)(6916009)(64756008)(54906003)(66476007)(66946007)(66556008)(76116006)(66446008)(316002)(26005)(41300700001)(2906002)(7416002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHBPS2VlV3FrZzlHYk1NdzFlSVhYSkNneVdlMXdXSzVFbWdXcmcrK2s1cmVO?=
 =?utf-8?B?bVBkNXgvRUdlVThrQ0NRN0RwMWZyMTRDbjBCMTE4ZFo5b2ZYUStKcXV4dFFa?=
 =?utf-8?B?azA2K01RekVST2ptbG14NllwVjdSMWd0V2JFSURibkpjcC9SMGxIZ1hxb1E2?=
 =?utf-8?B?c2llZlczMDFLelZ0WThHMS9LM0xPTEdFeGkwMm9pYWdwVFo4aDhzVU1KT01U?=
 =?utf-8?B?T1VibDUzQkJtYWxLM21rSHJ1ajV1dCt2b1FySW1QdEpKbzF6bUZvVzlTMWZv?=
 =?utf-8?B?bVB0WUJpV0dFRks5YW9qNzBXZkZwQUZic0N6WGN0bS96NW5ROGx4Z0Z6cFYw?=
 =?utf-8?B?bGI5OUN6Z1lQemVxQjVkelRrQ1U1VlhHVTBDaHU4MEFCSnpkZnZiMGZCNTdx?=
 =?utf-8?B?bFVDT0FxZ01CK3ZiS1VZUjVubUlBUkxQMGdxdm9iQ1g2V3o1MnZIeHRiUDVR?=
 =?utf-8?B?TWdlczQ4UzV6aWVSdnA4UDhsTmFDZlpUS01DSnUyRDNjaG8zMWhvVDArdEo5?=
 =?utf-8?B?anZ1NnVVTUFTR2hHQUpPQnc3bGtYeFBkQURYOVJobmRnK3pXN1o0aEZON2lk?=
 =?utf-8?B?TzdRSktTd3pqMG1Kckh4N2xuMk55VmwydWNOMVJOWEVCNDVIeFU1b25qMXV5?=
 =?utf-8?B?a1RNZ0VQK3BZVU10UDZ3MHI5QUp4akVlWkVFNEZINVRwT1FzT1NYUUU4cG1L?=
 =?utf-8?B?Y1VCU0F5WFZybEF3MVB3N3pDMVlOWmJCdFZmYk9UZURKdlF4RDhhL29CcnRK?=
 =?utf-8?B?cUgvODZsVFlWend6a2UrMGo3b3AyTXQ5dUtzZjNuQVpBY09ZOUcxSVdSbXRy?=
 =?utf-8?B?NmtlM1IxOHpaM2hTMkpmaGlqZ2xlOEx0T05EQkN2M2dKNVpwZUFpSE5qemxR?=
 =?utf-8?B?SFZwTEhybE5hUW0rNVFjLzAzRmpVbUlCOHBYRFN1TTVucmVBUEkzNWJPN0xz?=
 =?utf-8?B?Mmc5SlNadElYSi8wencxVDRXTlVQdVBQcmhqanNjdzF4aCtlcTkrWmZlU3Fq?=
 =?utf-8?B?aUlLUXVGc3RJZW41dXhyUEM3SHBrbjBYMTJqMHdxNU9hbzltU0ttR2hrU1Mr?=
 =?utf-8?B?OWVsV1p2Nm1LQVBuRVNucmJYc0R0eHhlMUJSeUZpaENqbGpQaEN3QjJWUFVs?=
 =?utf-8?B?R1NRaHVwVEZVL2FuQVpEcXZxUEp3RVNDSytmNG4zZE9RVlNHT1dBMVVOelZr?=
 =?utf-8?B?bERmeHhuM3AyY0J6VmE1bnVZdTZGeUJZYkZpczNCUGY3aVpRUE9yUTVXTWhT?=
 =?utf-8?B?VEU0Z2Q1NUtmaS9WN0k1OElkYjhJY2pYc1VBOTFzbFRIRVgvVUF3ZDVhamp1?=
 =?utf-8?B?aGROME01KzIxRG51YldmM051Q1FraWNNNnNSdTlqeDlSRUJKTFZ3R0tJZHF5?=
 =?utf-8?B?NUZwTjNqTno1Uk5SOGh5bDdTd3lHRHh3MDQvZC9Tb3RzcTdSRHgwRkk2Wmdm?=
 =?utf-8?B?ZGh3NTdYUi96cFBoRFJ1aWV5bE5lVUoxVCt0dXhVcDZTVG5aZ0c4cDFpdTA1?=
 =?utf-8?B?QkxNOFE0aUtsamdmTG8vRXR4cjkrZm1oU0s3d2FHTjBNVGdqY1JqUFFZZWhJ?=
 =?utf-8?B?aUpwMHNFNHNrb0kyV0FUQng2RktDZDRDcjVTYXNsTXd2WmpzSEFUQ0gwUnRZ?=
 =?utf-8?B?V1J5OUF6OXlsV2FxMEM4TWR4b3g5RlY2blRtRWdWR0hRYUoxbUJ0OXF5MXdn?=
 =?utf-8?B?VlNYQk5uL21EemxGOUhIVjh0STdNMllxK2hycXY2UUwwd2YxZG5ySFk4eFdM?=
 =?utf-8?B?QjlWMzhkdlJNa1lqa1RoeXI4QXpPQnc0NG9XWXFDL1VvKzhTUFpSQ0dLM0lk?=
 =?utf-8?B?eFBuRjcwQ3IzM3NlSFE3eEJ4SjhZcmlpdDY4bVE1eVZGVytRNERsb294elJ0?=
 =?utf-8?B?ZXBHWnBFb1JRVUtiVEhLNUVpWmpMN0NPNi9wc3pqVFhNRDVOOXIrWTRzUzgx?=
 =?utf-8?B?SzJFNGVwT1hEcXMzaUFFRTM1VmlmT09KUmhod1BDZW5Scmx1TVBBc2lvSFVJ?=
 =?utf-8?B?YW0zY2FsQnFEa1cwWkdHYmI0OE93ZWVpWmZHM0V3bXJjMEpHdkJtc1NraU4w?=
 =?utf-8?B?UzFoQlpLanNQeG95ekFJZnBOUnBzaGNyZG5KTDJBWUJqVkRpTjhkc3R2bnBE?=
 =?utf-8?Q?9LY5Bx5ruR8t/CzLVHXemRjx2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6697f9-0f73-432f-0d60-08dbd6d0ee36
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 09:41:44.0620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxT0Pv7Fg29QGa9e1Tj1Sf/n63ITphAf5p9FuDnFiVKhvkStMhEKUJa42sbf/+Fg0pFVI3jJZ4k5MeJNZajZfJuZznxeVW42mcEjgbpfxx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5518
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.151;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1hcmt1cyBBcm1icnVzdGVy
IDxhcm1icnVAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIE9jdG9iZXIgMjcsIDIwMjMgNDoz
MSBQTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMjQvMzddIGJhY2tlbmRzL2lvbW11ZmQ6IElu
dHJvZHVjZSB0aGUgaW9tbXVmZCBvYmplY3QNCj4NCj4iRHVhbiwgWmhlbnpob25nIiA8emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tPiB3cml0ZXM6DQo+DQo+Pj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPj4+IEZyb206IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4+
PiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAyNiwgMjAyMyA5OjI4IFBNDQo+Pj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MyAyNC8zN10gYmFja2VuZHMvaW9tbXVmZDogSW50cm9kdWNlIHRoZSBpb21t
dWZkDQo+b2JqZWN0DQo+Pj4NCj4+PiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPiB3cml0ZXM6DQo+Pj4NCj4+Pj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckBy
ZWRoYXQuY29tPg0KPj4+Pg0KPj4+PiBJbnRyb2R1Y2UgYW4gaW9tbXVmZCBvYmplY3Qgd2hpY2gg
YWxsb3dzIHRoZSBpbnRlcmFjdGlvbg0KPj4+PiB3aXRoIHRoZSBob3N0IC9kZXYvaW9tbXUgZGV2
aWNlLg0KPj4+Pg0KPj4+PiBUaGUgL2Rldi9pb21tdSBjYW4gaGF2ZSBiZWVuIGFscmVhZHkgcHJl
LW9wZW5lZCBvdXRzaWRlIG9mIHFlbXUsDQo+Pj4+IGluIHdoaWNoIGNhc2UgdGhlIGZkIGNhbiBi
ZSBwYXNzZWQgZGlyZWN0bHkgYWxvbmcgd2l0aCB0aGUNCj4+Pj4gaW9tbXVmZCBvYmplY3Q6DQo+
Pj4+DQo+Pj4+IFRoaXMgYWxsb3dzIHRoZSBpb21tdWZkIG9iamVjdCB0byBiZSBzaGFyZWQgYWNj
cm9zcyBzZXZlcmFsDQo+Pj4+IHN1YnN5c3RlbXMgKFZGSU8sIFZEUEEsIC4uLikuIEZvciBleGFt
cGxlLCBsaWJ2aXJ0IHdvdWxkIG9wZW4NCj4+Pj4gdGhlIC9kZXYvaW9tbXUgb25jZS4NCj4+Pj4N
Cj4+Pj4gSWYgbm8gZmQgaXMgcGFzc2VkIGFsb25nIHdpdGggdGhlIGlvbW11ZmQgb2JqZWN0LCB0
aGUgL2Rldi9pb21tdQ0KPj4+PiBpcyBvcGVuZWQgYnkgdGhlIHFlbXUgY29kZS4NCj4+Pj4NCj4+
Pj4gVGhlIENPTkZJR19JT01NVUZEIG9wdGlvbiBtdXN0IGJlIHNldCB0byBjb21waWxlIHRoaXMg
bmV3IG9iamVjdC4NCj4+Pj4NCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBBbGV4IFdpbGxpYW1zb24gPGFs
ZXgud2lsbGlhbXNvbkByZWRoYXQuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIEF1Z2Vy
IDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWku
bC5saXVAaW50ZWwuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhl
bnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdv
YXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgTUFJTlRBSU5FUlMgICAgICAg
ICAgICAgIHwgICA3ICsNCj4+Pj4gIHFhcGkvcW9tLmpzb24gICAgICAgICAgICB8ICAyMCArKysN
Cj4+Pj4gIGluY2x1ZGUvc3lzZW11L2lvbW11ZmQuaCB8ICA0NiArKysrKysrDQo+Pj4+ICBiYWNr
ZW5kcy9pb21tdWZkLXN0dWIuYyAgfCAgNTkgKysrKysrKysrDQo+Pj4+ICBiYWNrZW5kcy9pb21t
dWZkLmMgICAgICAgfCAyNjgNCj4rKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4+Pj4gIGJhY2tlbmRzL0tjb25maWcgICAgICAgICB8ICAgNCArDQo+Pj4+ICBiYWNrZW5k
cy9tZXNvbi5idWlsZCAgICAgfCAgIDUgKw0KPj4+PiAgYmFja2VuZHMvdHJhY2UtZXZlbnRzICAg
IHwgIDEyICsrDQo+Pj4+ICBxZW11LW9wdGlvbnMuaHggICAgICAgICAgfCAgMTMgKysNCj4+Pj4g
IDkgZmlsZXMgY2hhbmdlZCwgNDM0IGluc2VydGlvbnMoKykNCj4+Pj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBpbmNsdWRlL3N5c2VtdS9pb21tdWZkLmgNCj4+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBi
YWNrZW5kcy9pb21tdWZkLXN0dWIuYw0KPj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJhY2tlbmRz
L2lvbW11ZmQuYw0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJ
TkVSUw0KPj4+PiBpbmRleCA3Zjk5MTJiYWEwLi43YWE1N2FiMTZmIDEwMDY0NA0KPj4+PiAtLS0g
YS9NQUlOVEFJTkVSUw0KPj4+PiArKysgYi9NQUlOVEFJTkVSUw0KPj4+PiBAQCAtMjEwOSw2ICsy
MTA5LDEzIEBAIEY6IGh3L3ZmaW8vYXAuYw0KPj4+PiAgRjogZG9jcy9zeXN0ZW0vczM5MHgvdmZp
by1hcC5yc3QNCj4+Pj4gIEw6IHFlbXUtczM5MHhAbm9uZ251Lm9yZw0KPj4+Pg0KPj4+PiAraW9t
bXVmZA0KPj4+PiArTTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+ICtNOiBFcmlj
IEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4+ICtTOiBTdXBwb3J0ZWQNCj4+Pj4g
K0Y6IGJhY2tlbmRzL2lvbW11ZmQuYw0KPj4+PiArRjogaW5jbHVkZS9zeXNlbXUvaW9tbXVmZC5o
DQo+Pj4+ICsNCj4+Pj4gIHZob3N0DQo+Pj4+ICBNOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPg0KPj4+PiAgUzogU3VwcG9ydGVkDQo+Pj4+IGRpZmYgLS1naXQgYS9xYXBpL3Fv
bS5qc29uIGIvcWFwaS9xb20uanNvbg0KPj4+PiBpbmRleCBjNTNlZjk3OGZmLi5lZjBiNTBmMTA3
IDEwMDY0NA0KPj4+PiAtLS0gYS9xYXBpL3FvbS5qc29uDQo+Pj4+ICsrKyBiL3FhcGkvcW9tLmpz
b24NCj4+Pj4gQEAgLTc5NCw2ICs3OTQsMjIgQEANCj4+Pj4gIHsgJ3N0cnVjdCc6ICdWZmlvVXNl
clNlcnZlclByb3BlcnRpZXMnLA0KPj4+PiAgICAnZGF0YSc6IHsgJ3NvY2tldCc6ICdTb2NrZXRB
ZGRyZXNzJywgJ2RldmljZSc6ICdzdHInIH0gfQ0KPj4+Pg0KPj4+PiArIyMNCj4+Pj4gKyMgQElP
TU1VRkRQcm9wZXJ0aWVzOg0KPj4+PiArIw0KPj4+PiArIyBQcm9wZXJ0aWVzIGZvciBpb21tdWZk
IG9iamVjdHMuDQo+Pj4+ICsjDQo+Pj4+ICsjIEBmZDogZmlsZSBkZXNjcmlwdG9yIG5hbWUgcHJl
dmlvdXNseSBwYXNzZWQgdmlhICdnZXRmZCcgY29tbWFuZCwNCj4+Pj4gKyMgICAgIHdoaWNoIHJl
cHJlc2VudHMgYSBwcmUtb3BlbmVkIC9kZXYvaW9tbXUuIFRoaXMgYWxsb3dzIHRoZQ0KPj4+DQo+
Pj4gVHdvIHNwYWNlcyBiZXR3ZWVuIHNlbnRlbmNlcyBmb3IgY29uc2lzdGVuY3ksIHBsZWFzZS4N
Cj4+DQo+PiBQcmVzdW1lIHlvdSBtZWFuICIgICdkYXRhJzogeyAnKmZkJzogJ3N0cicgfSB9IiBs
aW5lLCBub3QgYWJvdmUgbGluZS4NCj4NCj5JJ2QgbGlrZSB5b3UgdG8gZm9ybWF0IHRoZSBkb2Mg
Y29tbWVudCBsaWtlIHRoaXM6DQo+DQo+DQo+ICAgICAjIEBmZDogZmlsZSBkZXNjcmlwdG9yIG5h
bWUgcHJldmlvdXNseSBwYXNzZWQgdmlhICdnZXRmZCcgY29tbWFuZCwNCj4gICAgICMgICAgIHdo
aWNoIHJlcHJlc2VudHMgYSBwcmUtb3BlbmVkIC9kZXYvaW9tbXUuICBUaGlzIGFsbG93cyB0aGUN
Cj4NCj5Ob3RlIHRoZSB0d28gc3BhY2VzIGFmdGVyIHRoZSBwZXJpb2QgaW4gIi9kZXYvaW9tbXUu
ICBUaGlzIGFsbG93cyIuDQoNClVuZGVyc3Rvb2QuDQoNCj4NCj4+Pg0KPj4+PiArIyAgICAgaW9t
bXVmZCBvYmplY3QgdG8gYmUgc2hhcmVkIGFjY3Jvc3Mgc2V2ZXJhbCBzdWJzeXN0ZW1zDQo+Pj4+
ICsjICAgICAoVkZJTywgVkRQQSwgLi4uKSBhbmQgZmlsZSBkZXNjcmlwdG9yIHRvIGJlIHNoYXJl
ZCB3aXRoDQo+Pj4NCj4+PiBDb21tYSBiZWZvcmUgImFuZCBmaWxlIi4NCj4+Pg0KPj4+IEVpdGhl
ciAidGhlIGZpbGUgZGVzY3JpcHRvciIsIG9yICJmaWxlIGRlc2NyaXB0b3JzIi4NCj4+Pg0KPj4+
PiArIyAgICAgb3RoZXIgcHJvY2VzcywgZS5nOiBEUERLLg0KPj4+DQo+Pj4gZS5nLg0KPj4+DQo+
Pj4gQWx0ZXJuYXRpdmVseSAic3VjaCBhcyBEUERLLiINCj4+DQo+PiBXaWxsIGZpeC4NCj4+DQo+
Pj4NCj4+Pj4gKyMNCj4+Pj4gKyMgU2luY2U6IDguMg0KPj4+PiArIyMNCj4+Pj4gK3sgJ3N0cnVj
dCc6ICdJT01NVUZEUHJvcGVydGllcycsDQo+Pj4+ICsgICAgICAgICdkYXRhJzogeyAnKmZkJzog
J3N0cicgfSB9DQo+Pj4NCj4+PiBAZmQgaXMgb3B0aW9uYWwuICBIb3cgZG9lcyB0aGUgaW9tbXVm
ZCBvYmplY3QgYmVoYXZlIHdoZW4gQGZkIGlzIGFic2VudD8NCj4+DQo+PiBJZiBubyBmZCBpcyBw
YXNzZWQgYWxvbmcgd2l0aCB0aGUgaW9tbXVmZCBvYmplY3QsIHRoZSAvZGV2L2lvbW11DQo+PiBp
cyBvcGVuZWQgYnkgdGhlIHFlbXUgY29kZS4gTGV0IG1lIGtub3cgaWYgdGhpcyBhbHNvIG5lZWRz
IHRvIGJlIGRvY3VtZW50ZWQuDQo+DQo+V2hlbiBzb21ldGhpbmcgaXMgb3B0aW9uYWwsIHdlIHBy
ZXR0eSBtdWNoIGFsd2F5cyBuZWVkIHRvIGRvY3VtZW50DQo+YmVoYXZpb3Igd2hlbiBpdCdzIGFi
c2VudC4NCj4NCj5JZGVhbGx5LCBiZWhhdmlvciB3aGVuIGFic2VudCBpcyBpZGVudGljYWwgdG8g
YmVoYXZpb3Igd2hlbiBwcmVzZW50IHdpdGgNCj5hIGNlcnRhaW4gZGVmYXVsdCB2YWx1ZS4gIFRo
ZW4gZG9jdW1lbnRpbmcgdGhlIGRlZmF1bHQgdmFsdWUgc3VmZmljZXMuDQo+V2UgY29tbW9ubHkg
ZG8gdGhpcyBsaWtlIChkZWZhdWx0OiBWQUxVRSkuDQoNCkdvdCBpdC4NCg0KVGhhbmtzDQpaaGVu
emhvbmcNCg==

