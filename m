Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F176741DD2
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 03:58:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEguZ-0007Fv-Kx; Wed, 28 Jun 2023 21:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qEguX-0007FS-2z
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 21:57:29 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qEguU-00056F-6c
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 21:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688003846; x=1719539846;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9kcwpHNENlGRaJ9Jo341gqk4GClQq7NITGzdsh2ofo8=;
 b=Yt1JgoWiqk10eS75AlTbDlfgRQS6/vtVXxLd+DEOysUdytwm2+dvlsLW
 zUebyRmvHcHLrUr5DU5jpIXAnfeGiJpAH/dLkMgL/S7Lyw8crk/UL2TuT
 qEzEC/62LeziCFO3cSQBUWu/mwsoy0PxnsAoFLEIbihvlXPF5ljTQ8OKh
 GhtYaGsuDTNpU+6ZWSuw5FBGU4z9a8/oUNRRTjwBx2a/vR2h5whNBU5j+
 XkqaesmzM3CJsIFxUE5jp/3LAk2WEmRjjfYzS1u+P0nMn26Syhoh7xnEB
 oHluMJpLbGxP0qxy2NCuwNmwh+UBITv1URv008cs+pIarMFZQnkJ0kNmm w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="365465468"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; d="scan'208";a="365465468"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 18:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="667343041"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; d="scan'208";a="667343041"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga003.jf.intel.com with ESMTP; 28 Jun 2023 18:57:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 18:57:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 18:57:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 18:57:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 18:57:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdcyLFRvTLv/0GZx+XxGyk4uquy6TjWo3y33tQwMmlrgrjfccErOLqoNrijA6cWYtQ81IDrwmF3MV4ypcDt58ZyHUbPKLV6Ih0jFn7bP3i4ok+Ka0rojj//45dXx8DTXp6G3t/eD325G1G8z7LbfO4WbASrHc+EvDnAfJ2jSVNAxWyHSA66cS9FtWBtqdNUrxr6ICwgmsKXfnkSgIPWFImaJ7a++n3iN19mmca7tRenNrxxUEkfceFiihxB7u1NbBDy1qYxYHgT9gDC/Y2MB/1vWu1bxTbx8fBWuvWQnZ7yxW6s6ATEBjGIl3IwKLskRnRgfTwalCO6khDX+GMx9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kcwpHNENlGRaJ9Jo341gqk4GClQq7NITGzdsh2ofo8=;
 b=jdVPi73Ij/iDsjx3WNZc6kofkq+h4+o3ikloGQnOWh6/w59ajAIQRPKg+0Sl7htkDQCpBLKgTtnoZIdmSM2ZoBAygHWB8iY3m8EQSeNQJB/AKgDGUYKkxIPVlq2Gv3Re1LZS2jpNeJt7PRCWaQiL0RHXfH7aWBZuXFbH3D55S5M/5rhNwG8VFhy2gfGK3j46ZLvWa4+LGFQ38wNtBorHi1QBOIfL4WskiPGSMM0m/PeSzRWh5We40JEGkRsbsyPgaPBzrOdL0LWOJ6LBe65LBdtYQVnLfEg2+9PSHJRwhC8dbayHHztXtvZSq4la4vss7rskvYSfAsggx++N4GF9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB6890.namprd11.prod.outlook.com (2603:10b6:930:5d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 01:57:05 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%5]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 01:57:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, Avihai Horon <avihaih@nvidia.com>
CC: Alex Williamson <alex.williamson@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2 2/2] vfio/migration: Make VFIO migration
 non-experimental
Thread-Topic: [PATCH v2 2/2] vfio/migration: Make VFIO migration
 non-experimental
Thread-Index: AQHZqZKlebEkBAIx6UmSIGpadg7jk6+gLFcAgAAgoYCAABQigIAApN9g
Date: Thu, 29 Jun 2023 01:57:05 +0000
Message-ID: <SJ0PR11MB67443F06BF48F5DCEC91885D9225A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230628073112.7958-1-avihaih@nvidia.com>
 <20230628073112.7958-3-avihaih@nvidia.com>
 <0b6b4262-5782-bdc1-428e-2b106411afd3@redhat.com>
 <b9c42787-0f8b-b458-0d8f-c691f7be5276@oracle.com>
 <6e5a8ac8-6542-bdbb-473f-15e842902052@redhat.com>
In-Reply-To: <6e5a8ac8-6542-bdbb-473f-15e842902052@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB6890:EE_
x-ms-office365-filtering-correlation-id: 83c929a3-4941-4191-0ca5-08db784423b9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HKAHWP8C/ul2ChvP0Kum0uDI47JXLPcxnEIg4TZDRayw91mue0tkyF+bY2t0ooRdMUQEUrDVHwbDAGbvMO1l+4DKEwuE/+gY0Ga67GMSs+FqNl4LMGwICtXPFDZJXD8S3rUGN95FsRBmqZtGDCwuxwr08looxHuqaKx/tqVah+ptTrW0oF3Vrmto9QLmEYkzyCf/uz49j19hK7oWwUcTKlNmQuKuLZKPo4IDaArhq/d0+RCVwR3hqI6tm8D8sgGc5B0APJ76ZttG/CmOOczxQvf6F9Jmykf52SNhFKb7Xy1YEa7lhOVWYw/4DKvubJFtBkefGddpQy1PlZn0p+7hm8pxLvktbqv0rNhm1clkkizKepGJFyT3ZCXCbQ3XbnNt05OtI2ick48K6VJOTCDul6MIY6wMAXM6JMAxIiXO/p0R9pFhpRzJs+4NmUWbY00rxjYS4VRZgzqj6hdjvuiCNcSu0btjI3SCBFyuD92enfceVQlAiK0nm5+XW0FiALcAX2Hb9yz0uZI6fr47+s0j50ws4HmxszxVQ0qQJbb7x722Zlx7r047x3ligBqjlnVZlZwt/OYA9Ngul+1+C1M5V8R7Thv6NEIkjILXzVOMuOB3FWRTNSr+lFbqH45XyOpHjj9qTBrnsY1MSzaSLfoExw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(55016003)(76116006)(66446008)(64756008)(66476007)(8676002)(41300700001)(66556008)(316002)(8936002)(66946007)(6506007)(26005)(186003)(53546011)(966005)(9686003)(54906003)(110136005)(478600001)(4326008)(7696005)(71200400001)(2906002)(5660300002)(7416002)(52536014)(38070700005)(82960400001)(122000001)(38100700002)(33656002)(86362001)(66574015)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzYzc1FhRVFpVjBMekMzVWdqQkloWDFTV3ZaTTEyOGNjZkh1R01COEtwb21m?=
 =?utf-8?B?VXFhMWQ0dHlMLzRKYUVUUmh2aCtBME1wbFcwOFF2M05GMDRoOHJGSkVGM0JE?=
 =?utf-8?B?RVBzcm9VZHhqb1JodVFSdmcxSHd3RXM1amtIeCtQVVorZ3k3UVJqR3IvU0pw?=
 =?utf-8?B?WmJWZkZwL3FkQ3RXNFJ1OU9SK05ZUDU1c3czY2tack1CdDhFeEE2WWtndm4v?=
 =?utf-8?B?MzBMSi8zbVhLbzUzNlZIdm5hYlFla0JTT0t2MzFHb2h0cDNzU3dLNGFSMkRl?=
 =?utf-8?B?UVRndHpOeEx0dzNRZXVLVWphcHhzK25HbjhnUXVaVU9DRjNMZXNkT0RsZmwx?=
 =?utf-8?B?VWRqb2l2S1R3VXVjZUlNVlpJVC9QUUhWWXhZaWN6ZHJ5RlRoalMzWThJYmdZ?=
 =?utf-8?B?VEdLL0NVWFQ5SGw4UlFuaTVVWUVoQldiVU9STXJ3V081OWQ2L1loOVpBb2JD?=
 =?utf-8?B?OXp6RTA2OGVhOEo5WHhUR04xMzlhcTNCSWZjNy93Y2dUSTBwSktsQTBnc1lW?=
 =?utf-8?B?cG5kRlVpWmtYbGp3T0IwUWtBVVNQcit4V252RWlKeUx6UmZpb2hGR0lRUFFC?=
 =?utf-8?B?WDhjVnh3SDlCOGgxZ05vQ2QraGJZbkpXWTFsbHZQTDFBN2NMTGpPNnNSa2JD?=
 =?utf-8?B?SHJnOUxQVWIrejIzUnhHUWt5d0pzUXl6bFUrbnJJbThLSHpvNHZxTjRIK3dq?=
 =?utf-8?B?MS9WaStUSTh3c1RBVmdNOHI5bVlHaXdRVTVZbHE5NDNrc3VucmczVTV3cm5B?=
 =?utf-8?B?YXV6MzI2dU9uUUlpcUtZOGJESVFGYVg2QzZMV1dSNEpZak9aYkpGK2VxN2xS?=
 =?utf-8?B?dFYwV2hNdFFjUGNEejFQdzNiUVdVRlg0SVNXWHNJUE1uLzI5eDQ4c0VUUFNi?=
 =?utf-8?B?SGU3cHFkVUs3eTFWRy9TUWtjejJXNXBPajJOaWFxeUxhRHQ3QnJXeUtDeklN?=
 =?utf-8?B?eXJ1eGlVckJCSTBpc2R1WXROaWlzV3VEbkhwVTZCWkxVWmdYeis0NnEwK2VC?=
 =?utf-8?B?SEJESVdQSjczNEtvSDg3ZWdXUzhqUGdhZDNUY3BOYTdBdDhENDExdUwvMG9M?=
 =?utf-8?B?bThnV1M5L21abWtFWkR1OVIva0V3OGFITEJGVlF4dzd2UmN2TUZ1YU9lQWtV?=
 =?utf-8?B?SnFDQ2toSWsyd0xwWnFselZtUkNnSUJjdUxuaEdQejZmUmJBaUxqMkhGdndw?=
 =?utf-8?B?YTVhdlpyUmMzaGVqbFN6UWZqVlRXejBjWXNtUmlTOWNITnlQL2cxbnpmc3Fj?=
 =?utf-8?B?c0tId0hBNjhWdy9kT09ZYUhSWHlGcVlJbUZFSUJTd1ZleHhlTlNhRUxFRUNt?=
 =?utf-8?B?N254MDY3RnhoY3lLUzJ5R0UreG1FYVVDT0lVZ1lTV3ZRSHU5eGFURE02VTZz?=
 =?utf-8?B?S1VRamhrdlJzTVllcUFTRWI1eFFWa0dmdHRqSnR6MGRZT2N4bDRxYjJkeFVG?=
 =?utf-8?B?Rkkwd0pwU3M0VGVUZS9zMkVXL3pXQnI5L2xzQnFOck1FcTNuR0RKRzZVeUpT?=
 =?utf-8?B?VDRqd2hXSG1NVVhkaG55NUM3TnlKeEJTMWV2TkE3L0REQUhieWFoMGQ2K0Nx?=
 =?utf-8?B?OGtCZXpOc3lBZkJqaVFCRDR3MmhTU3ZYb1FGZVdZY0JwYVBtdTczbVk1QUlC?=
 =?utf-8?B?YVk5T1J2ZEN0WUY0aEdRZjA2RnM1L3BLM3A4MEFQTmpkWFVnVlpVNHB3c205?=
 =?utf-8?B?RjZsNXFMQXUxU0kzOEM5NXBJVGo5cjdHelIvNW1QMnZRaWhqdFoxMHFIeFFr?=
 =?utf-8?B?RjN0TFZ3T2J1R1FTd3JQWDBnZjI4eFJrdDNuc2tUeGpKbFJpUVQ0cVZYcDBx?=
 =?utf-8?B?a3czeE1qaXhRd1FLTTJBNmJWZWVuR0NYOHRpa1o2M2RBUnlwanJRMFh5Z0g1?=
 =?utf-8?B?WjhFQlk5dHA5eHo2WGJodnRsN1NYQXBEck12SUQ3UldZSkp3MDBXVHZjNTlC?=
 =?utf-8?B?cEhhM3B4MzFYRm1WZzRFWUE5d0pLZWJ1MVF1VCtvdGNtOXJhVzlpSjJCUEFx?=
 =?utf-8?B?L3YyajJ2UE5vL21vbEZiSGVzSHUreWdOWjBmSzhRTkpjSkhpdHVjMTYzVFpE?=
 =?utf-8?B?Y2ZnbjBLK1BKZ1hBMTQ3a0xwQmR0UjBDRXNTcnFZd2FxYzRic29IdElzYXBi?=
 =?utf-8?Q?68B5a6TQUnF3rFyJ7mREpIp/N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c929a3-4941-4191-0ca5-08db784423b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 01:57:05.5026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OwMiFcS/iNTcNqH0onRFsKvZYNhHVFSBFzINp52cOYw4IjXZ+CDbSeUcucrAHKrIU1rC5NLPLZOoB2ws1x5+YraUr514kbBFm+gMgWnZVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6890
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mga03.intel.com
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNs
Z0ByZWRoYXQuY29tPg0KPlNlbnQ6IFRodXJzZGF5LCBKdW5lIDI5LCAyMDIzIDEyOjA0IEFNDQo+
VG86IE1hcnRpbnMsIEpvYW8gPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+OyBBdmloYWkgSG9y
b24NCj48YXZpaGFpaEBudmlkaWEuY29tPg0KPkNjOiBBbGV4IFdpbGxpYW1zb24gPGFsZXgud2ls
bGlhbXNvbkByZWRoYXQuY29tPjsgSnVhbiBRdWludGVsYQ0KPjxxdWludGVsYUByZWRoYXQuY29t
PjsgUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPjsgTGVvbmFyZG8gQnJhcw0KPjxsZW9icmFz
QHJlZGhhdC5jb20+OyBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT47
DQo+WWlzaGFpIEhhZGFzIDx5aXNoYWloQG52aWRpYS5jb20+OyBKYXNvbiBHdW50aG9ycGUgPGpn
Z0BudmlkaWEuY29tPjsNCj5NYW9yIEdvdHRsaWViIDxtYW9yZ0BudmlkaWEuY29tPjsgS2lydGkg
V2Fua2hlZGUNCj48a3dhbmtoZWRlQG52aWRpYS5jb20+OyBUYXJ1biBHdXB0YSA8dGFyZ3VwdGFA
bnZpZGlhLmNvbT47IHFlbXUtDQo+ZGV2ZWxAbm9uZ251Lm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjIgMi8yXSB2ZmlvL21pZ3JhdGlvbjogTWFrZSBWRklPIG1pZ3JhdGlvbiBub24tDQo+ZXhw
ZXJpbWVudGFsDQo+DQo+T24gNi8yOC8yMyAxNjo1MSwgSm9hbyBNYXJ0aW5zIHdyb3RlOg0KPj4g
T24gMjgvMDYvMjAyMyAxMzo1NCwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+Pj4gT24gNi8y
OC8yMyAwOTozMSwgQXZpaGFpIEhvcm9uIHdyb3RlOg0KPj4+PiBUaGUgbWFqb3IgcGFydHMgb2Yg
VkZJTyBtaWdyYXRpb24gYXJlIHN1cHBvcnRlZCB0b2RheSBpbiBRRU1VLiBUaGlzDQo+Pj4+IGlu
Y2x1ZGVzIGJhc2ljIFZGSU8gbWlncmF0aW9uLCBkZXZpY2UgZGlydHkgcGFnZSB0cmFja2luZyBh
bmQNCj4+Pj4gcHJlY29weSBzdXBwb3J0Lg0KPj4+Pg0KPj4+PiBUaHVzLCBhdCB0aGlzIHBvaW50
IGluIHRpbWUsIGl0IHNlZW1zIGFwcHJvcHJpYXRlIHRvIG1ha2UgVkZJTw0KPj4+PiBtaWdyYXRp
b24NCj4+Pj4gbm9uLWV4cGVyaW1lbnRhbDogcmVtb3ZlIHRoZSB4IHByZWZpeCBmcm9tIGVuYWJs
ZV9taWdyYXRpb24NCj4+Pj4gcHJvcGVydHksIGNoYW5nZSBpdCB0byBPTl9PRkZfQVVUTyBhbmQg
bGV0IHRoZSBkZWZhdWx0IHZhbHVlIGJlIEFVVE8uDQo+Pj4+DQo+Pj4+IEluIGFkZGl0aW9uLCBt
YWtlIHRoZSBmb2xsb3dpbmcgYWRqdXN0bWVudHM6DQo+Pj4+IDEuIFdoZW4gZW5hYmxlX21pZ3Jh
dGlvbiBpcyBPTiBhbmQgbWlncmF0aW9uIGlzIG5vdCBzdXBwb3J0ZWQsIGZhaWwNCj4+Pj4gVkZJ
Tw0KPj4+PiAgwqDCoMKgIGRldmljZSByZWFsaXphdGlvbi4NCj4+Pj4gMi4gV2hlbiBlbmFibGVf
bWlncmF0aW9uIGlzIEFVVE8gKGkuZS4sIG5vdCBleHBsaWNpdGx5IGVuYWJsZWQpLA0KPj4+PiBy
ZXF1aXJlDQo+Pj4+ICDCoMKgwqAgZGV2aWNlIGRpcnR5IHRyYWNraW5nIHN1cHBvcnQuIFRoaXMg
aXMgYmVjYXVzZSBkZXZpY2UgZGlydHkNCj4+Pj4gdHJhY2tpbmcNCj4+Pj4gIMKgwqDCoCBpcyBj
dXJyZW50bHkgdGhlIG9ubHkgbWV0aG9kIHRvIGRvIGRpcnR5IHBhZ2UgdHJhY2tpbmcsIHdoaWNo
DQo+Pj4+IGlzDQo+Pj4+ICDCoMKgwqAgZXNzZW50aWFsIGZvciBtaWdyYXRpbmcgaW4gYSByZWFz
b25hYmxlIGRvd250aW1lLiBTZXR0aW5nDQo+Pj4+ICDCoMKgwqAgZW5hYmxlX21pZ3JhdGlvbiB0
byBPTiB3aWxsIG5vdCByZXF1aXJlIGRldmljZSBkaXJ0eSB0cmFja2luZy4NCj4+Pj4gMy4gTWFr
ZSBtaWdyYXRpb24gZXJyb3IgYW5kIGJsb2NrZXIgbWVzc2FnZXMgbW9yZSBlbGFib3JhdGUuDQo+
Pj4+IDQuIFJlbW92ZSBlcnJvciBwcmludHMgaW4gdmZpb19taWdyYXRpb25fcXVlcnlfZmxhZ3Mo
KS4NCj4+Pj4gNS4gUmVuYW1lIHRyYWNlX3ZmaW9fbWlncmF0aW9uX3Byb2JlKCkgdG8NCj4+Pj4g
IMKgwqDCoCB0cmFjZV92ZmlvX21pZ3JhdGlvbl9yZWFsaXplKCkuDQo+Pj4+DQo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEF2aWhhaSBIb3JvbiA8YXZpaGFpaEBudmlkaWEuY29tPg0KPj4+DQo+Pj4NCj4+
PiBXZSBzaG91bGQgcmV3b3JrIHRoZSByZXR1cm4gdmFsdWUgb2YgbW9zdCBvZiB0aGUgcm91dGlu
ZXMgY2FsbGVkIGJ5DQo+Pj4gdmZpb19taWdyYXRpb25fcmVhbGl6ZSgpIGFuZCBzaW1wbHkgdXNl
IGEgYm9vbC4gSSB0aGluayBaaGVuemhvbmcgaXMNCj4+PiB3b3JraW5nIGl0Lg0KPj4+DQo+Pj4g
Wmhlbnpob25nLA0KPj4+DQo+Pj4gV2hlbiB5b3UgcmVzZW5kIHY0IG9mIHRoZSAiVkZJTyBtaWdy
YXRpb24gcmVsYXRlZCByZWZhY3RvciBhbmQgYnVnIGZpeCINCj4+PiBzZXJpZXMsIHBsZWFzZSBy
ZWJhc2Ugb24gdGhpcyBwYXRjaCBzaW5jZSBpdCBzaG91bGQgYmUgbWVyZ2VkLg0KPj4+DQo+Pg0K
Pj4gVGhpcywgYW5kIGhpcyBzd2l0Y2hvdmVyLWFjayBzZXJpZXMgZnJvbSBBdmloYWkgdGhhdCBw
cmVjZWVkcyBpdC4NCj4+DQo+PiBQZXJoYXBzIGl0IG1pZ2h0IGJlIGVhc2llciB0byBwb2ludCB0
byB5b3VyIHRyZWU6YnJhbmNoIHdoZXJlIHlvdSBhcmUNCj4+IHF1ZXVlaW5nIGFsbCB0aGUgcGF0
Y2hlcz8NCj4+DQo+DQo+U3VyZS4NCj4NCj5JIHRyYWNrIFFFTVUgcGF0Y2hlcyBmb3IgdmFyaW91
cyBzdWJzeXN0ZW1zIHVuZGVyIDoNCj4NCj4gIGh0dHBzOi8vZ2l0aHViLmNvbS9sZWdvYXRlci9x
ZW11DQo+DQo+DQo+VkZJTyBjYW5kaWRhdGVzIGFyZSB1bmRlciA6DQo+DQo+ICAgaHR0cHM6Ly9n
aXRodWIuY29tL2xlZ29hdGVyL3FlbXUvdHJlZS92ZmlvLTguMQ0KPg0KPlRoaXMgaXMgYSB3aXAg
dHJlZSwgcGF0Y2hlcyBjb21lIGFuZCBnby4gSXQgY29udGFpbnMgdGhlIFZGSU8gcGF0Y2hlcyBv
ZiB0aGUNCj5kYXkvd2VlaywgZ29vZCBmb3IgdGVzdGluZyBuZXcgaWRlYXMgYW5kIGNoZWNraW5n
IENJLg0KPg0KPg0KPlRoZSB2ZmlvLW5leHQgYnJhbmNoIGNvbnRhaW5zIHdoYXQgSSBhbSA5MCUg
c3VyZSB0byBzZW5kIHVwc3RyZWFtIDoNCj4NCj4gIGh0dHBzOi8vZ2l0aHViLmNvbS9sZWdvYXRl
ci9xZW11L3RyZWUvdmZpby1uZXh0DQoNCkdyZWF0LCBJJ2xsIHJlYmFzZSBvbiB0aGlzIGJyYW5j
aCwgdGhhbmtzIGZvciBzaGFyaW5nLg0KDQpSZWdhcmRzDQpaaGVuemhvbmcNCg0K

