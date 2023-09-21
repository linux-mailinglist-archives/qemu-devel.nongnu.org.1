Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CEC7A90C7
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 04:06:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj93a-0003yI-5P; Wed, 20 Sep 2023 22:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qj93V-0003yA-NQ
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 22:04:37 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qj93R-00010f-82
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 22:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695261873; x=1726797873;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bo6s3ypUjFB0eZ5x+LMN0xuYiIL1GhY5TwmviQIBp9g=;
 b=GJhN0A0yjtAa6JoztgIKc/eUxaqh7g1CC7TsVvsa7PUvhCPOXA9JDtBt
 6ieKb0dXMnN5IxsIOVhlR/9F2fiBP/M1upTeHhIHS1pbKRJ2bgIOejrft
 ARjaA6WgqH12NXFsQk/cryQ5YVTs//2qbAnu2a4LJLM9S62tfe/e0V3/H
 V7GTxDWYltC0r8wl+NAaSG/xLdWCgS1RRytty/xZMvde56WTVXpta4/Mh
 7UkachsKshS1g3jjkv9hI2qNVsYsNdIs4AMTvVynbRy02bGzWImXSDQgj
 zhJoHnS+hLPuocR/32lg/+J3ek8nFWpmfqAedLwJwOyjqf4aCeCske+Yi Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="383140014"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="383140014"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 19:04:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="890187238"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="890187238"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 19:03:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 19:04:18 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 19:04:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 19:04:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 19:04:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiIP7YVptYZjUAVDSbXnIcwGlkiUjGC0ZqdHL5bixT4BSk/NAFX9aSZM55EUH1mHyufqpMuddPT7scKJi86dm8WGuYzUcm9vxmdCb5Glr4YPK6WKB33WHkFicn2Z8beTO6IlNtGCx7KVYHgmCqqeoWp2ykZRRXAT7FUr14RuPLGn2TWVhQjXws3XEgPTkXgLAlMDBUi71gZD5gq+uUog3zSlLHS6VFLJBqPPz4I+yx6rqY15kp8hGi7V6eIJ0YMzPVDbwb0H+jKtwb/sO2/S27OVSA2AGVu/QU7dbicUw9s+sdDjztIIK6ZAnemVuL0IFUFe8XMMOxyPvOgLh6+NyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bo6s3ypUjFB0eZ5x+LMN0xuYiIL1GhY5TwmviQIBp9g=;
 b=dXb9KFWNrWL4YwtKqcnc0vzIdy/+NgF1msn3qJEqxN7olgeE77QKOvZdTKlkRHGTrOy5T/IPo2AJM3e8M/P1NZKZ0B40JvHYNN/+D3/IKUdJooWOKq6842HtxFsA3YGa9AbJ+ESm+dY6ADQHpv8toT3rqEeu1r8F56XFCO0m1uMEepU9g7zZ4Ymr4zIBtSKU4SEQ1w/QE4w7YILIgqFt2akiW2bfUjAD6u2SAkZMDY+DgMxaFyAKSWiufEagweuyZrKTpdWUYMkt3NhfHCOBFoiLgsYa1n9kBO+jI1jUw9JhQRDVWnf9TLNL3A5NFttC3dVBofu+kKsHjAssT2LAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB8501.namprd11.prod.outlook.com (2603:10b6:510:308::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 02:04:15 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 02:04:15 +0000
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
Subject: RE: [PATCH v1 05/22] vfio/common: Extract out
 vfio_kvm_device_[add/del]_fd
Thread-Topic: [PATCH v1 05/22] vfio/common: Extract out
 vfio_kvm_device_[add/del]_fd
Thread-Index: AQHZ2zAjqlgYZoGXuEGtL1+wwj7B+LAjupQAgAAIUVA=
Date: Thu, 21 Sep 2023 02:04:14 +0000
Message-ID: <SJ0PR11MB67446D9EE5F986BF5086424892F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-6-zhenzhong.duan@intel.com>
 <127c3104-44e0-f19f-6339-43182fbf6db1@redhat.com>
In-Reply-To: <127c3104-44e0-f19f-6339-43182fbf6db1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB8501:EE_
x-ms-office365-filtering-correlation-id: abc44ae7-0b76-441f-2d1b-08dbba470e8a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TM9cz0ppeGe9cwoccjr0mCxpxmiiFvqoDAjf+9rcXw6Z89ruOu5GxuhdwnuGE+/ajq7WEpMdrhZIMSPWEOVmr/XuEMeEGhW/In5sUNiDfFMFmtdL1iTQQuchQEyOQVUgPiA2qO64pw48YNdbn9RJpxxyoKwNgmcozA/v1iny1xorhwutA7YuFVADSY1u4EPFgYsB0JZRGPwCEy8ZTQhxhJXweJ+fd3u4JfQQy/fIfAu+zUF3KWJMpA/YsMENytoACogkj+d19RKlN5bfOg7Z9cepV0+ckYE0YPRpBVY9E7lUxMrw0bSc0crOJ05yZiN3HhzoA/SBU9y67OJqoElk+14RCnNG66ID54xuJHKqCDRs7eU0FOEKFUXmW+nRaXwJ8lo0ktwzU8eg/Y3wxhGqFK4LLOoJ48gfx2kY0v+3MsZpaQhPZfWCHQbUHh4TAY5h6ADuta0QasW8sZqKBtY5Y1OC+Ex3eWCT31KFV30IcQl8t/2v09c8FdBKjGiUKQ/wwo/DnjV8LG+rw5dWqi1Qxtx7XwlBG/0M36b3Hy2CvkvsOG0AQR1IVptz6nvCEKCXOhiRYk0x4ryQ4b2ZgETHdloH5+aq+yzBWH6BlTkvkx6gd4tlKYAIM2bLP3MTuJk3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(186009)(451199024)(1800799009)(55016003)(5660300002)(107886003)(41300700001)(26005)(2906002)(122000001)(82960400001)(33656002)(86362001)(38070700005)(38100700002)(4326008)(8936002)(8676002)(52536014)(83380400001)(7696005)(6506007)(9686003)(478600001)(316002)(110136005)(64756008)(54906003)(76116006)(66946007)(66446008)(66556008)(66476007)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajFRLzdreE84SDYza05DaU40enpTdDE3ZnBMQVdxUnphZnBrRk1UaGFuYmZw?=
 =?utf-8?B?WUUrU2lKTzR5VFBpUnhOK1Z3elpXTDRDY01nZXViOW1MWDRMeGFKOEZkM2Vo?=
 =?utf-8?B?d3E5eU5OY0w4NndYMlpWTnJRUlhlZHFyNW16eVQvVXgwdlR5SElCODUyV2kv?=
 =?utf-8?B?ZGtPM1RROFBMaWRWRnN0cUcycGRDMWFPNWEvRSt2TlFkd3lsMXJyYjV5QlFu?=
 =?utf-8?B?c2hnMEVLVnc4Z2dqNkorRmVLQnVJUHJuR2FuUEQraUp5Q1dUZEdCNDdvZ1NK?=
 =?utf-8?B?d2J1ZC9SVFV6bitTVWV4ODRReDFHYmwrd01WallNdHRxOTNCdSs2bHZmYXJy?=
 =?utf-8?B?SGxIWURBUGdwcFB2Smo4VllYUDRjZEs0NU5rbzVqUnZDQmVHNFJsMDV2VHc5?=
 =?utf-8?B?Q1hxVVlkcTl1R0JsbjNUOUlDRnBVdnBOT1dMU1dveEVZQWNMZTlpZEpSRUNK?=
 =?utf-8?B?cjhUc1FRd1JuMU9nVU40dk54MTlISTBqZEFIOWJQK3ArZVI4TG92cWtmTE1s?=
 =?utf-8?B?eEhScWZFcUZxZ0NKaDNpRVZrZk1NdFllUm1sa3RhamhZYm44ZWVxWnUvRFBQ?=
 =?utf-8?B?ZW5XOENUeTU3cW4rMDNMQTB3OGpCUC9uZ3I4QzRqT29qeFJ5UnB5WitVMW5I?=
 =?utf-8?B?dnY1NkVFVVZhbFFqMXNIMXlIYmFWT0JidDJXUlc0SGhYQzUxYWx0RTB3NGtH?=
 =?utf-8?B?WkR1Z3hsU3VjRWxEblAzNWdYNVlhOFFmVGJGRm9SU3dFSTRuRFBGN2w5OS9P?=
 =?utf-8?B?K3kwZXk2dm82dDBSY2VvaU9uNVhPYjJDVmxUeStWbEJwekVOajlONTJCcHlL?=
 =?utf-8?B?aHF6ZlFGM1dZaGJvTm9UdE1xK2NyK1d1bEZ0VjlPMXFud3RrRXhSWXQ2Q1BC?=
 =?utf-8?B?UmRUd3REZXN6N0ZnYzk4eDRKZUh0ajc5SDlNOFc2Q2llUGhjd3hWMXh6WWsy?=
 =?utf-8?B?dWdoSkxUaXlUWDc4encraFNOWVNrYXY1enF1L2JWZkduMW9jRXBmREcrSzUr?=
 =?utf-8?B?MDVJS2o5MDV2RTN3OVIwcVJZT1ZkeTZ2OWdVSTdwNmxSN1hRRHh3MEhPU3kv?=
 =?utf-8?B?VFJiQklQMG9OalNNT1hRbHc0RGh2OXFXSTZNK3JNdjlGaDRiUHJBV0JiR2Y0?=
 =?utf-8?B?MitnSVhuMG5SdjlWUGdDZkFkcUxlcWpkRlh3S21JOFUzL3ZMUWMyNFVlQ0pO?=
 =?utf-8?B?MGV1ZVpZWEJnTVpwRFJadURoZnoxYkIydXNVZUlWdEVKNlNOVzk5MVlyWDYy?=
 =?utf-8?B?K3BuVWRiVE5uNTVvM0tWU2tpZkRMZmgvc1kwODFGOVlSaUpRQlVNZDhTeHZj?=
 =?utf-8?B?M2tMMDIydTExVXo2UU0xL29lNktLQWgxdmtSSlEvWEpyRFU3YlltVE9IUENi?=
 =?utf-8?B?SG5KYVV2OFhwdkNQNkRyTVZKblVlb201R2FuNEgyQ2VoT3plMW82eVNDdHRE?=
 =?utf-8?B?cDg0UExocjBGNEdmUmxMZVVQZkZiOW1Ub0ZiOEs0dUhVbjc2SitvTHJRWi9i?=
 =?utf-8?B?RFVmVDZxUEY0S1ZXVzhBZm1lYm85WUZHUUZvNFAxRmttakJhRnYrbFZ3ZTlE?=
 =?utf-8?B?WlFuTG5yekxTUTRNUTArMTZpOVdWNWVwc2FHalRwRDhRTGZVMnNmTXRqVTI3?=
 =?utf-8?B?TENzdVltVFBIclZLUnZmWW0vZnRUcUxOMnJvMEVZNVhyNDdOV0F4eDR3bVY1?=
 =?utf-8?B?UXJKUmRIcnRsUWlHVWF4S01RQTh3Wi9ZUVNxQ3k2NGE0MkxJc1NSQXVoQ1ZT?=
 =?utf-8?B?cDExcjhQajloVFAyeE1TdjNMeW5ldGpYWWpNOGJjRU9mY1VOSXhtSlA1ejNE?=
 =?utf-8?B?TmJ0Rmo1QytxN3Y2dmowWkpncEpVeUNyRWVSQ05NbU8yTzdiOEptMXB3dHQ4?=
 =?utf-8?B?ZlFHUXVqdHFrNXdCU0pnVEJ0M1RYTjNLV1QxUzlEMUgweXdCTXQxZHNCWWtq?=
 =?utf-8?B?bnVzamxDN0dWR0FZRzM1MUxtTGVmaS9KUTZSeThVQzJtWnJvVzhORVI2K0Rp?=
 =?utf-8?B?ZGdpamNqZVBPRDZOUW9YS3o5M0puN1BzeXIwV1YxWWQwdG1LNWlqWFk0VWVR?=
 =?utf-8?B?OU5UUXhoTlVuTFd5MHR1dmdnUTQ0YTh4dGx6MEgrZjVGdi9oUkphTWRwUjQ3?=
 =?utf-8?Q?vvf55v2BIHAbHFbDfjPtXYiQZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc44ae7-0b76-441f-2d1b-08dbba470e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 02:04:15.0327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/5hFel7jxJkfreemtaz8NtUdDtZOBCLbNd2/oNtUybbkqPNBYqP+Nq0KztfKBiQYIKsdfISo4c1G26cAEOvN0/4tmgZFOAzGlXsx5BR7HA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8501
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyA3
OjQ5IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAwNS8yMl0gdmZpby9jb21tb246IEV4dHJh
Y3Qgb3V0DQo+dmZpb19rdm1fZGV2aWNlX1thZGQvZGVsXV9mZA0KPg0KPkhpIFpoZW56aG9uZywN
Cj4NCj5PbiA4LzMwLzIzIDEyOjM3LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IC4uLndoaWNo
IHdpbGwgYmUgdXNlZCBieSBib3RoIGxlZ2FjeSBhbmQgaW9tbXVmZCBiYWNrZW5kLg0KPkkgcHJl
ZmVyIGdlbnVpbmUgc2VudGVuY2VzIGluIHRoZSBjb21taXQgbXNnLiBBbHNvIHlvdSBleHBsYWlu
IHdoYXQgeW91DQo+ZG8gYnV0IG5vdCB3aHkuDQo+DQo+c3VnZ2VzdGlvbjogSW50cm9kdWNlIHR3
byBuZXcgaGVscGVycywgdmZpb19rdm1fZGV2aWNlX1thZGQvZGVsXV9mZA0KPndoaWNoIHRha2Ug
YXMgaW5wdXQgYSBmaWxlIGRlc2NyaXB0b3Igd2hpY2ggY2FuIGJlIGVpdGhlciBhIGdyb3VwIGZk
IG9yDQo+YSBjZGV2IGZkLiBUaGlzIHVzZXMgdGhlIG5ldyBLVk1fREVWX1ZGSU9fRklMRSBWRklP
IEtWTSBkZXZpY2UgZ3JvdXAsDQo+d2hpY2ggYWxpYXNlcyB0byB0aGUgbGVnYWN5IEtWTV9ERVZf
VkZJT19HUk9VUC4NCj4NCj52ZmlvX2t2bV9kZXZpY2VfYWRkL2RlbF9ncm91cCB0aGVuIGNhbGwg
dGhvc2UgbmV3IGhlbHBlcnMuDQoNClRoYW5rcywgd2lsbCB1cGRhdGUgaW4gdjIuDQoNCj4NCj4N
Cj4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+
IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+
DQo+PiAtLS0NCj4+ICBody92ZmlvL2NvbW1vbi5jICAgICAgICAgICAgICB8IDQ0ICsrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+PiAgaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29t
bW9uLmggfCAgMyArKysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDE1
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2NvbW1vbi5jIGIvaHcv
dmZpby9jb21tb24uYw0KPj4gaW5kZXggNjcxNTBlNDU3NS4uOTQ5YWQ2NzE0YSAxMDA2NDQNCj4+
IC0tLSBhL2h3L3ZmaW8vY29tbW9uLmMNCj4+ICsrKyBiL2h3L3ZmaW8vY29tbW9uLmMNCj4+IEBA
IC0xNzU5LDE3ICsxNzU5LDE3IEBAIHZvaWQgdmZpb19yZXNldF9oYW5kbGVyKHZvaWQgKm9wYXF1
ZSkNCj4+ICAgICAgfQ0KPj4gIH0NCj4+DQo+PiAtc3RhdGljIHZvaWQgdmZpb19rdm1fZGV2aWNl
X2FkZF9ncm91cChWRklPR3JvdXAgKmdyb3VwKQ0KPj4gK2ludCB2ZmlvX2t2bV9kZXZpY2VfYWRk
X2ZkKGludCBmZCkNCj4+ICB7DQo+PiAgI2lmZGVmIENPTkZJR19LVk0NCj4+ICAgICAgc3RydWN0
IGt2bV9kZXZpY2VfYXR0ciBhdHRyID0gew0KPj4gLSAgICAgICAgLmdyb3VwID0gS1ZNX0RFVl9W
RklPX0dST1VQLA0KPj4gLSAgICAgICAgLmF0dHIgPSBLVk1fREVWX1ZGSU9fR1JPVVBfQURELA0K
Pj4gLSAgICAgICAgLmFkZHIgPSAodWludDY0X3QpKHVuc2lnbmVkIGxvbmcpJmdyb3VwLT5mZCwN
Cj4+ICsgICAgICAgIC5ncm91cCA9IEtWTV9ERVZfVkZJT19GSUxFLA0KPj4gKyAgICAgICAgLmF0
dHIgPSBLVk1fREVWX1ZGSU9fRklMRV9BREQsDQo+PiArICAgICAgICAuYWRkciA9ICh1aW50NjRf
dCkodW5zaWduZWQgbG9uZykmZmQsDQo+PiAgICAgIH07DQo+Pg0KPj4gICAgICBpZiAoIWt2bV9l
bmFibGVkKCkpIHsNCj4+IC0gICAgICAgIHJldHVybjsNCj4+ICsgICAgICAgIHJldHVybiAwOw0K
Pj4gICAgICB9DQo+Pg0KPj4gICAgICBpZiAodmZpb19rdm1fZGV2aWNlX2ZkIDwgMCkgew0KPj4g
QEAgLTE3NzksMzcgKzE3NzksNTEgQEAgc3RhdGljIHZvaWQNCj52ZmlvX2t2bV9kZXZpY2VfYWRk
X2dyb3VwKFZGSU9Hcm91cCAqZ3JvdXApDQo+Pg0KPj4gICAgICAgICAgaWYgKGt2bV92bV9pb2N0
bChrdm1fc3RhdGUsIEtWTV9DUkVBVEVfREVWSUNFLCAmY2QpKSB7DQo+PiAgICAgICAgICAgICAg
ZXJyb3JfcmVwb3J0KCJGYWlsZWQgdG8gY3JlYXRlIEtWTSBWRklPIGRldmljZTogJW0iKTsNCj4+
IC0gICAgICAgICAgICByZXR1cm47DQo+PiArICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+
Y2FuJ3QgeW91IHJldHVybiAtZXJybm8/DQpXaWxsIGZpeC4NCg0KPj4gICAgICAgICAgfQ0KPj4N
Cj4+ICAgICAgICAgIHZmaW9fa3ZtX2RldmljZV9mZCA9IGNkLmZkOw0KPj4gICAgICB9DQo+Pg0K
Pj4gICAgICBpZiAoaW9jdGwodmZpb19rdm1fZGV2aWNlX2ZkLCBLVk1fU0VUX0RFVklDRV9BVFRS
LCAmYXR0cikpIHsNCj4+IC0gICAgICAgIGVycm9yX3JlcG9ydCgiRmFpbGVkIHRvIGFkZCBncm91
cCAlZCB0byBLVk0gVkZJTyBkZXZpY2U6ICVtIiwNCj4+IC0gICAgICAgICAgICAgICAgICAgICBn
cm91cC0+Z3JvdXBpZCk7DQo+PiArICAgICAgICBlcnJvcl9yZXBvcnQoIkZhaWxlZCB0byBhZGQg
ZmQgJWQgdG8gS1ZNIFZGSU8gZGV2aWNlOiAlbSIsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ZmQpOw0KPj4gKyAgICAgICAgcmV0dXJuIC1lcnJubzsNCj4+ICAgICAgfQ0KPj4gICNlbmRpZg0K
Pj4gKyAgICByZXR1cm4gMDsNCj4+ICB9DQo+Pg0KPj4gLXN0YXRpYyB2b2lkIHZmaW9fa3ZtX2Rl
dmljZV9kZWxfZ3JvdXAoVkZJT0dyb3VwICpncm91cCkNCj4+ICtzdGF0aWMgdm9pZCB2ZmlvX2t2
bV9kZXZpY2VfYWRkX2dyb3VwKFZGSU9Hcm91cCAqZ3JvdXApDQo+PiArew0KPj4gKyAgICB2Zmlv
X2t2bV9kZXZpY2VfYWRkX2ZkKGdyb3VwLT5mZCk7DQo+U2luY2UgdmZpb19rdm1fZGV2aWNlX2Fk
ZF9mZCBub3cgcmV0dXJucyBhbiBlcnJvciB2YWx1ZSwgaXQncyBhIHBpdHkgbm90DQo+dG8gdXNl
IGl0IGFuZCBwcm9wYWdhdGUgaXQuIEFsc28geW91IGNvdWxkIGZpbGwgYW4gZXJycCB3aXRoIHRo
ZSBlcnJvcg0KPm1zZyBhbmQgdXNlIGl0IGluIHZmaW9fY29ubmVjdF9jb250YWluZXIoKS4gQnV0
IHRoaXMgaXMgYSBuZXcgZXJyb3INCj5oYW5kbGluZyB0aGVyZS4NCg0KV2hhdCBhYm91dCBoYXZp
bmcgdmZpb19rdm1fZGV2aWNlX2FkZF9mZCByZXR1cm4gdm9pZCBhcw0KdmZpb19rdm1fZGV2aWNl
X2FkZF9ncm91cC4gSSBqdXN0IHJlYWxpemUgdmZpb19jb25uZWN0X2NvbnRhaW5lcigpDQpkb2Vz
bid0IGdldCBhbnkgZmFpbHVyZSBvZiB2ZmlvX2t2bV9kZXZpY2VfYWRkX2dyb3VwLCBwcm9wYWdh
dGluZw0KZXJyIHRvIHZmaW9fY29ubmVjdF9jb250YWluZXIoKSBpcyBqdXN0IHRvIHByaW50IGl0
IG91dCB0aGVyZSB3aGljaCBJIGhhdmUNCmRvbmUgaW4gdmZpb19rdm1fZGV2aWNlX2FkZF9mZC4N
Cg0KPj4gK30NCj4+ICsNCj4+ICtpbnQgdmZpb19rdm1fZGV2aWNlX2RlbF9mZChpbnQgZmQpDQo+
bm90IHN1cmUgd2Ugd2FudCB0aGlzIHRvIHJldHVybiBhbiBlcnJvci4gQnV0IGlmIHdlIGRvLCBJ
IHRoaW5rIGl0IHdvdWxkDQo+YmUgbmljZXIgdG8gcHJvcGFnYXRlIHRoZSBlcnJvciB1cC4NCg0K
U2FtZSBxdWVzdGlvbiBhcyBhYm92ZS4NCg0KPj4gIHsNCj4+ICAjaWZkZWYgQ09ORklHX0tWTQ0K
Pj4gICAgICBzdHJ1Y3Qga3ZtX2RldmljZV9hdHRyIGF0dHIgPSB7DQo+PiAtICAgICAgICAuZ3Jv
dXAgPSBLVk1fREVWX1ZGSU9fR1JPVVAsDQo+PiAtICAgICAgICAuYXR0ciA9IEtWTV9ERVZfVkZJ
T19HUk9VUF9ERUwsDQo+PiAtICAgICAgICAuYWRkciA9ICh1aW50NjRfdCkodW5zaWduZWQgbG9u
ZykmZ3JvdXAtPmZkLA0KPj4gKyAgICAgICAgLmdyb3VwID0gS1ZNX0RFVl9WRklPX0ZJTEUsDQo+
PiArICAgICAgICAuYXR0ciA9IEtWTV9ERVZfVkZJT19GSUxFX0RFTCwNCj4+ICsgICAgICAgIC5h
ZGRyID0gKHVpbnQ2NF90KSh1bnNpZ25lZCBsb25nKSZmZCwNCj4+ICAgICAgfTsNCj4+DQo+PiAg
ICAgIGlmICh2ZmlvX2t2bV9kZXZpY2VfZmQgPCAwKSB7DQo+PiAtICAgICAgICByZXR1cm47DQo+
PiArICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+ICAgICAgfQ0KPj4NCj4+ICAgICAgaWYgKGlv
Y3RsKHZmaW9fa3ZtX2RldmljZV9mZCwgS1ZNX1NFVF9ERVZJQ0VfQVRUUiwgJmF0dHIpKSB7DQo+
PiAtICAgICAgICBlcnJvcl9yZXBvcnQoIkZhaWxlZCB0byByZW1vdmUgZ3JvdXAgJWQgZnJvbSBL
Vk0gVkZJTyBkZXZpY2U6ICVtIiwNCj4+IC0gICAgICAgICAgICAgICAgICAgICBncm91cC0+Z3Jv
dXBpZCk7DQo+PiArICAgICAgICBlcnJvcl9yZXBvcnQoIkZhaWxlZCB0byByZW1vdmUgZmQgJWQg
ZnJvbSBLVk0gVkZJTyBkZXZpY2U6ICVtIiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICBmZCk7
DQo+PiArICAgICAgICByZXR1cm4gLUVCQURGOw0KPi1lcnJubz8NClN1cmUuDQoNClRoYW5rcw0K
Wmhlbnpob25nDQo=

