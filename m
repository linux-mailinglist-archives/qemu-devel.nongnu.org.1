Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AC2835B7F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 08:17:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRoYd-0005NV-C3; Mon, 22 Jan 2024 02:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rRoYb-0005Mj-RI; Mon, 22 Jan 2024 02:17:22 -0500
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rRoYY-0005oW-T1; Mon, 22 Jan 2024 02:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705907838; x=1737443838;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dzB42U9/Hpbn7yzSfIhPEHMEnKvy46Yf2wYTRqorK0E=;
 b=G9yN9oGOk01xQGwJSk7sKz8ykl8OoutGF/xmAeyUNSHh4PgZ29jr7RND
 OZUh6dyHTpWMRGCuhSwgUK5rdstS0Mz0Bc5atZAILvelD1VwdZCr6OO+D
 hds4p++CzckmGfjRJPpo57iNcNgtRy8SJokfHxMBpJYtMEDFSxq5yJjqG
 CeKrTDgllB1Qjn9yoFGIoQKNrVVw1JqVGvFvWrrRcKRlctEn8euZueMEf
 hBASbS8XQ0wbFaA8Ixq9ZKjHqjWndYOPSVGKoTRD+lckXZsa6hc54Vlnq
 PY8mWF1Dw78J9MsdlJ5hMf2akGTG/yP8IINNb8mz2FHPz+KfrqHaCkOrR g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="465393255"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; d="scan'208";a="465393255"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2024 23:17:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1114907"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jan 2024 23:17:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 21 Jan 2024 23:17:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 21 Jan 2024 23:17:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 21 Jan 2024 23:17:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 21 Jan 2024 23:17:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEq4OAyhT7VRCiVWDZxtbYiDL3N3IHydSVz2lMb0k6K9YdY0x3hScld5yDx5zsi9pc66XVErhvkEXWr3kAYU9PZ6LFn++kfNBZ0xFHDH9O8OCc57jzF6k941S1mpUAUuIm3i7LdnJNmCnpyZU/O4gh3pXQS1vpeqO6NuGkHrGk3FFxOBcRP3bqdgdP/OfqBmJdZfNRxOTn7oDIndc4RaCYejO0MmGVqyxFf951LthiiTuNwXK/x5ZdMoOtKipvpM5sZ1usouCDvsqJNqy9NjstiiMJ5XZALcezXCi9/w/ZesBQbUxG9Y1wJ+7jpWE4PvWgYxaA0qmEp6Lt3r/TLJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzB42U9/Hpbn7yzSfIhPEHMEnKvy46Yf2wYTRqorK0E=;
 b=Pm5O9C3B/YJKgzu7B8MPmelfiH/UyPoKvklVw4iD1Le7Ta5Qra0ejkuy5q9cUsGHXQWLdWEdI8kvglhhvKotXRzIVgyJVTIpHEqbMqepk4Hv9RBIgR4+akaDesSFK98ZwlHUrY/R46jT+yXLRyyyOcgiOf4pvLJ/VbgtGnxjkz5sgs328wYoHhjfsiyDbCYaq4ZQ4y04a1IgeNnZM9LOPcvnWpOYQucR8fyS5U5pQzePuNwT4DVc9km8RuivXMIjuY5naQ0MAj1rPuZZ8BXyT6UPQ6g6U1A2fYF+Tm9vbjXbDiw7BTT78i5seml7x5/obC5Yo5GOkBaQucCapwasQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB7204.namprd11.prod.outlook.com (2603:10b6:610:146::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 07:17:11 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 07:17:10 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>, 
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, "yanghliu@redhat.com" <yanghliu@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "clg@redhat.com" <clg@redhat.com>
Subject: RE: [RFC 4/7] virtio-iommu: Implement PCIIOMMUOps
 set_host_resv_regions
Thread-Topic: [RFC 4/7] virtio-iommu: Implement PCIIOMMUOps
 set_host_resv_regions
Thread-Index: AQHaSRvZODIWGRgczkWQzR/Sdm1iRrDfLnswgABSDgCAATT9wIAEvXkg
Date: Mon, 22 Jan 2024 07:17:10 +0000
Message-ID: <SJ0PR11MB674440705683CB68B844001E92752@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240117080414.316890-1-eric.auger@redhat.com>
 <20240117080414.316890-5-eric.auger@redhat.com>
 <SJ0PR11MB67443F1D15B5959A77B60E3F92712@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <307bbfec-005c-4ca8-8c21-cb39f16812f3@redhat.com>
 <SJ0PR11MB674415F01D3C4C46A7B6872392702@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB674415F01D3C4C46A7B6872392702@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB7204:EE_
x-ms-office365-filtering-correlation-id: a15c4b5b-8435-4a92-1054-08dc1b1a2681
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZtOeR1B7XJofHDtf9YaEvQ0/Ue5q7WZZcrBsZ12STXJ/IDTBCtlbY8IdTlYjBvMRvXJkvsPOlWnDQCCdGWyXUKlQ8hG3A/0luQFdUO+Jw1C/nqQMyWVfQm4oE5+5mmRfWNp/tihnWpLP7ZE8G5lQC4ElR5p22coLVgHgfMdBL59FvsBcMohkUMeTvPssxoUOFrpTDcj211cY1ww2AuWkgfFac4QrZT69aCfeDTPHCC1e4//3FBVjTtA1VB0ri+vRR04MxY82TfdxzW9xBkEHPAY/mBi1GWjwViPsisqPtrj0Ct4DE2592qdwSO8QPblME98ZCTp3cXs/P02NGTlh3wWcwyBcw3/IF7hrn6QSguNQ+Oit6hs3ba0l+PJvg6/0bbKfr2NUpjBOcXyixuY/o/Lq8JP0rXa3n33fgDEUD/S3N7xJbry4Ybmkcc5xrIxUp6z4fwotxv6H+fa/SUTcGFFXgI50jY1MvTM+TMGEliwhrPeZ0eBSzwePmR/WngZYl3jXeu8fcXfRWyMrGfWMvPGR4kNDW9dIFWQeXj1WtAWL/bw4etPDgLwmG0cGEA+BWhdUqGOKIyCFqxqpUjm+O1lWxpZ5Ge6TOZ6Yz9i8TRz3at1RWodj9oBbgTJC3vXEUKZk9BlR68D7kE6tu/GXtQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(66946007)(26005)(71200400001)(5660300002)(38100700002)(4326008)(122000001)(8936002)(8676002)(478600001)(52536014)(7416002)(2906002)(41300700001)(66476007)(966005)(9686003)(6506007)(7696005)(66446008)(66556008)(316002)(54906003)(76116006)(110136005)(64756008)(921011)(38070700009)(82960400001)(86362001)(33656002)(55016003)(66899024)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2lFamQ5cVFZTWw5T0dpS0dSOTlZUnpPMklTWTNqdDBrTHFWVFlnQ3hrVjhM?=
 =?utf-8?B?NGw5UDlxcXRpQUNUNUtwQmFKTjF5b09ocEZlK2NpY29pSkR1dXptaTBuc0VD?=
 =?utf-8?B?b1FWQStnUmtmV2FhTzE3aEk3Rlh6dlVJV2ZuL0RVSC9DNG0vSFR2cXRHRCtO?=
 =?utf-8?B?RzlJQ2s2STBNSnhxdUkxZFJzN2NjY3NTcmlQR3ZFenVmdEtXNlpreTRZUndK?=
 =?utf-8?B?WDEwSjZaYVE3Z0dYVTRHVEZkbVdVN2NtdjJ6Y2JrMHJ5NCtNMGVhR2lLZG8w?=
 =?utf-8?B?MENXNzlabmdzdFBKZ0Z4YjJybUF6MUViR3N1cEpJcFk5OHF3Wnc3U0lMNEhL?=
 =?utf-8?B?ek1HTjNBeEg1Y0YrNGJKM3o0K1dHbEE2cHFXWUd6VElLMkNkTlMzQmx0YWdZ?=
 =?utf-8?B?aW5FMDZFRzdVaWRmaFUvTnl4dkYybFh1M2hRRWc5WnIzVTVJbHZTZWJVNVht?=
 =?utf-8?B?Y0ZwUmUvY3N5QXlBMGpkQWdRaTd4OEx5NnJhcnBEUWRPN2dlNHN2ZXV3alpI?=
 =?utf-8?B?RXhQYnpBYVVNeWZTNFhoc0ZSV1pZQ3pSK3JCWnlSdmt0bE02UjFpbElYMDJq?=
 =?utf-8?B?SXFyd0JJWWF6eU9FNkZEZUlZdVphRitqcDhzQlc4WTBxOUhmQThORUNRWjhu?=
 =?utf-8?B?RUVNODg3bkdLUzcwNCszc1JPaStONSt5MWpFTFpnZWFzWGhGSnlMMUVlYW04?=
 =?utf-8?B?Rm5IM2tVV1pmNU5wYnJvbk1MbEJzWXZGOVhRL3diZEhhQ1RBNk5zbzIrbGdH?=
 =?utf-8?B?NXY4STFFMTdlR3o5VHNMc2FDUnFnQ2toclNzRWgydm9qSUZSb1VIaE9PZkFZ?=
 =?utf-8?B?VEtXNlMwMUMvK3pHdVNObGFucDJtZXJsSTRGTmpLSmg5d1Y5L0d4MFJPQnJC?=
 =?utf-8?B?cGlDVURMZjJ1bFJlaUpoa3FOUGVDK3hlalVTZWVkdFpYMHI1RGNhTW9lK250?=
 =?utf-8?B?dm0xdU9BR3hjQ3E4bTc0UkNZUTlVWFRYY2ZBcTl6ODlEZE1NanNYUkJYTDBi?=
 =?utf-8?B?aTJ2TW4yTDAvQTlUR1U5czFEOUYxckNyWmQ4N0ZsRzd6RTBabCtGNTViTUZE?=
 =?utf-8?B?NTF6eHFkQTEzcHVLYWVXOHRPSUlYZVhEc09zMTRnbEFXaUtySUwxdVNENWlP?=
 =?utf-8?B?YzZ0MmI3K1dOeFFhaDE5UXFNYWJFblJRRXpGbFlCNHF5RnpQbVJEUitkaHVT?=
 =?utf-8?B?eGRuU0JqTks2Vm50UlM2aDB4OWY1WVpiQm9RWUtsV0FBYmtnUGtVYUZSREZZ?=
 =?utf-8?B?cm1pbFFFcUpBYUhtTVNlMC9RT1hUaXRtbTZtazVNelE2YUFVbk8vZkNvcHFw?=
 =?utf-8?B?RG16ODM2TXNITElzM016MDNrM0hOZHFIWnFodDB1WVRrSi9QU21KT2Qycy90?=
 =?utf-8?B?Wi82b0FCd1ZXdUhLSW1qc1B0TE43TnZqQWh6dDFoTGRPZ2ZlUHJFRU1iZGRu?=
 =?utf-8?B?VHMzZHZqWjBMTVMvK0VvaXQvbUZXZ2NtdGJHTzF4blhJWWdvTGI1ZjJGekhU?=
 =?utf-8?B?YXVqTWRFSXRXcXQ1K1ZjaUpEczlHZm40Zm9wWTFTWmVwcFlqdkgyRkt4Snkx?=
 =?utf-8?B?S1ZJZGppUGg1eklyRDlLa1N5ZnY5R2dLYncrNE40QkM2UHI5OFBXcXd3STJa?=
 =?utf-8?B?QkdKZ0dBbERPMmoxeFVML0hxUHBVZWNwaktWdkl3d2hqVldTdDBWYXlXNVBR?=
 =?utf-8?B?SjBwV2ZYSE4zT01BbXd3Vy9BYVNKQnVtSXcwckJ5UXluVDB6SU13NUZVZDZp?=
 =?utf-8?B?VG5jQ3pEcXRmamhOaE1za1JCV3lzTjVVQmJ6elNuMVRuZXkxeGFiMWlJUnRp?=
 =?utf-8?B?ZkVYdkt1SHZBUFhvUHlzMTFHV2RCNmhyU3YvcFczWVJkTkhMam9OSkNtWTFX?=
 =?utf-8?B?Y29NYUU3RnQyTkJEQjR1RVhBZWVqMitjeVNvUnp4M0tnblN1ZFFtYTZ5eVlW?=
 =?utf-8?B?UlgrMHZlUjd6WG5wV3NQUjJaVjN1aFRGK0VIM3FseU95ZG5JNFJSRTcrYjlB?=
 =?utf-8?B?eG4rZ3c3Wko5SG9MS1o3dmhHYVltelNUNmRxY2Zpc084ZXliVFVpRHNManNu?=
 =?utf-8?B?cldGM2ZqTmRMSEFOUWNoN1ZBRzFIQUNHcjZ6QmVoVWpGZitoazU3TmRaREZG?=
 =?utf-8?Q?rCPbYuf7stkab/TOoIcjWvAje?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15c4b5b-8435-4a92-1054-08dc1b1a2681
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 07:17:10.8288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7RKB49CnGLsmugusbHsIEokF6kO9Vm3JSTSkfZvsPenzdYvhivPpcA0YjYrpC9hrsASA4txEP9HudAEZEZZjP08i5oVJj7DQvwkXP4fAXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7204
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRHVhbiwgWmhl
bnpob25nDQo+U3ViamVjdDogUkU6IFtSRkMgNC83XSB2aXJ0aW8taW9tbXU6IEltcGxlbWVudCBQ
Q0lJT01NVU9wcw0KPnNldF9ob3N0X3Jlc3ZfcmVnaW9ucw0KPg0KPg0KPg0KPj4tLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPj5Gcm9tOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5j
b20+DQo+PlN1YmplY3Q6IFJlOiBbUkZDIDQvN10gdmlydGlvLWlvbW11OiBJbXBsZW1lbnQgUENJ
SU9NTVVPcHMNCj4+c2V0X2hvc3RfcmVzdl9yZWdpb25zDQo+Pg0KPj5IaSBaaGVuemhvbmcsDQo+
Pk9uIDEvMTgvMjQgMDg6NDMsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+PiBIaSBFcmljLA0K
Pj4+DQo+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+IEZyb206IEVyaWMgQXVn
ZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+Pj4gU3ViamVjdDogW1JGQyA0LzddIHZpcnRp
by1pb21tdTogSW1wbGVtZW50IFBDSUlPTU1VT3BzDQo+Pj4+IHNldF9ob3N0X3Jlc3ZfcmVnaW9u
cw0KPj4+Pg0KPj4+PiBSZXVzZSB0aGUgaW1wbGVtZW50YXRpb24gb2YgdmlydGlvX2lvbW11X3Nl
dF9pb3ZhX3JhbmdlcygpIHdoaWNoDQo+Pj4+IHdpbGwgYmUgcmVtb3ZlZCBpbiBzdWJzZXF1ZW50
IHBhdGNoZXMuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVn
ZXJAcmVkaGF0LmNvbT4NCj4+Pj4gLS0tDQo+Pj4+IGh3L3ZpcnRpby92aXJ0aW8taW9tbXUuYyB8
IDEzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4tLQ0KPj4tLS0NCj4+Pj4g
LQ0KPj4+PiAxIGZpbGUgY2hhbmdlZCwgMTAxIGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygt
KQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jIGIvaHcv
dmlydGlvL3ZpcnRpby1pb21tdS5jDQo+Pj4+IGluZGV4IDhhNGJkOTMzYzYuLjcxNmEzZmNmYmYg
MTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L3ZpcnRpby92aXJ0aW8taW9tbXUuYw0KPj4+PiArKysgYi9o
dy92aXJ0aW8vdmlydGlvLWlvbW11LmMNCj4+Pj4gQEAgLTQ2MSw4ICs0NjEsMTA5IEBAIHN0YXRp
YyBBZGRyZXNzU3BhY2UNCj4+Pj4gKnZpcnRpb19pb21tdV9maW5kX2FkZF9hcyhQQ0lCdXMgKmJ1
cywgdm9pZCAqb3BhcXVlLA0KPj4+PiAgICAgcmV0dXJuICZzZGV2LT5hczsNCj4+Pj4gfQ0KPj4+
Pg0KPj4+PiArLyoqDQo+Pj4+ICsgKiByZWJ1aWxkX3Jlc3ZfcmVnaW9uczogcmVidWlsZCByZXN2
IHJlZ2lvbnMgd2l0aCBib3RoIHRoZQ0KPj4+PiArICogaW5mbyBvZiBob3N0IHJlc3YgcmFuZ2Vz
IGFuZCBwcm9wZXJ0eSBzZXQgcmVzdiByYW5nZXMNCj4+Pj4gKyAqLw0KPj4+PiArc3RhdGljIGlu
dCByZWJ1aWxkX3Jlc3ZfcmVnaW9ucyhJT01NVURldmljZSAqc2RldikNCj4+Pj4gK3sNCj4+Pj4g
KyAgICBHTGlzdCAqbDsNCj4+Pj4gKyAgICBpbnQgaSA9IDA7DQo+Pj4+ICsNCj4+Pj4gKyAgICAv
KiBmcmVlIHRoZSBleGlzdGluZyBsaXN0IGFuZCByZWJ1aWxkIGl0IGZyb20gc2NyYXRjaCAqLw0K
Pj4+PiArICAgIGdfbGlzdF9mcmVlX2Z1bGwoc2Rldi0+cmVzdl9yZWdpb25zLCBnX2ZyZWUpOw0K
Pj4+PiArICAgIHNkZXYtPnJlc3ZfcmVnaW9ucyA9IE5VTEw7DQo+Pj4+ICsNCj4+Pj4gKyAgICAv
KiBGaXJzdCBhZGQgaG9zdCByZXNlcnZlZCByZWdpb25zIGlmIGFueSwgYWxsIHRhZ2dlZCBhcyBS
RVNFUlZFRCAqLw0KPj4+PiArICAgIGZvciAobCA9IHNkZXYtPmhvc3RfcmVzdl9yYW5nZXM7IGw7
IGwgPSBsLT5uZXh0KSB7DQo+Pj4+ICsgICAgICAgIFJlc2VydmVkUmVnaW9uICpyZWcgPSBnX25l
dzAoUmVzZXJ2ZWRSZWdpb24sIDEpOw0KPj4+PiArICAgICAgICBSYW5nZSAqciA9IChSYW5nZSAq
KWwtPmRhdGE7DQo+Pj4+ICsNCj4+Pj4gKyAgICAgICAgcmVnLT50eXBlID0gVklSVElPX0lPTU1V
X1JFU1ZfTUVNX1RfUkVTRVJWRUQ7DQo+Pj4+ICsgICAgICAgIHJhbmdlX3NldF9ib3VuZHMoJnJl
Zy0+cmFuZ2UsIHJhbmdlX2xvYihyKSwgcmFuZ2VfdXBiKHIpKTsNCj4+Pj4gKyAgICAgICAgc2Rl
di0+cmVzdl9yZWdpb25zID0gcmVzdl9yZWdpb25fbGlzdF9pbnNlcnQoc2Rldi0+cmVzdl9yZWdp
b25zLA0KPj5yZWcpOw0KPj4+PiArICAgICAgICB0cmFjZV92aXJ0aW9faW9tbXVfaG9zdF9yZXN2
X3JlZ2lvbnMoc2Rldi0NCj4+Pj4+IGlvbW11X21yLnBhcmVudF9vYmoubmFtZSwgaSwNCj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJhbmdlX2xvYigm
cmVnLT5yYW5nZSksDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByYW5nZV91cGIoJnJlZy0+cmFuZ2UpKTsNCj4+Pj4gKyAgICAgICAgaSsrOw0KPj4+
PiArICAgIH0NCj4+Pj4gKyAgICAvKg0KPj4+PiArICAgICAqIHRoZW4gYWRkIGhpZ2hlciBwcmlv
cml0eSByZXNlcnZlZCByZWdpb25zIHNldCBieSB0aGUgbWFjaGluZQ0KPj4+PiArICAgICAqIHRo
cm91Z2ggcHJvcGVydGllcw0KPj4+PiArICAgICAqLw0KPj4+PiArICAgIGFkZF9wcm9wX3Jlc3Zf
cmVnaW9ucyhzZGV2KTsNCj4+Pj4gKyAgICByZXR1cm4gMDsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+
PiArc3RhdGljIGludCB2aXJ0aW9faW9tbXVfc2V0X2hvc3RfaW92YV9yYW5nZXMoUENJQnVzICpi
dXMsIHZvaWQNCj4+Km9wYXF1ZSwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGludCBkZXZmbiwgR0xpc3QgKmlvdmFfcmFuZ2VzLA0KPj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0K
Pj4+PiArew0KPj4+PiArICAgIFZpcnRJT0lPTU1VICpzID0gb3BhcXVlOw0KPj4+PiArICAgIElP
TU1VUGNpQnVzICpzYnVzID0gZ19oYXNoX3RhYmxlX2xvb2t1cChzLT5hc19ieV9idXNwdHIsIGJ1
cyk7DQo+Pj4+ICsgICAgSU9NTVVEZXZpY2UgKnNkZXY7DQo+Pj4+ICsgICAgR0xpc3QgKmN1cnJl
bnRfcmFuZ2VzOw0KPj4+PiArICAgIEdMaXN0ICpsLCAqdG1wLCAqbmV3X3JhbmdlcyA9IE5VTEw7
DQo+Pj4+ICsgICAgaW50IHJldCA9IC1FSU5WQUw7DQo+Pj4+ICsNCj4+Pj4gKyAgICBpZiAoIXNi
dXMpIHsNCj4+Pj4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCIlcyBubyBzYnVzIiwgX19mdW5jX18p
Ow0KPj4+PiArICAgIH0NCj4+PiBEbyB3ZSBwbGFuIHRvIHN1cHBvcnQgbXVsdGlwbGUgZGV2aWNl
cyBpbiBzYW1lIGlvbW11IGdyb3VwPw0KPj4+IGFzX2J5X2J1c3B0ciBpcyBoYXNoZWQgYnkgYnVz
IHdoaWNoIGlzIGFuIGFsaWFzZWQgYnVzIG9mIHRoZSBkZXZpY2UuDQo+Pj4gU28gc2J1cyBtYXkg
YmUgTlVMTCBpZiBkZXZpY2UncyBidXMgaXMgZGlmZmVyZW50IGZyb20gYWxpYXNlZCBidXMuDQo+
PklmIEkgdW5kZXJzdGFuZCB5b3UgcmVtYXJrIHByb3Blcmx5IHRoaXMgbWVhbnMgdGhhdA0KPj4N
Cj4+dmlydGlvX2lvbW11X3NldF9ob3N0X2lvdmFfcmFuZ2VzIHNob3VsZCB0YWtlIGFzIGFyZyB0
aGUgYWxpYXNlZCBidXMgYW5kDQo+Pm5vdCB0aGUgYnVzLCByaWdodD8NCj4+SSB0aGluayB3ZSBz
aGFsbCBzdXBwb3J0IG5vbiBzaW5nbGV0b24gZ3JvdXBzIHRvby4NCj4NCj5Ob3QgZXhhY3RseS4g
SSB0aGluayB3ZSBzaG91bGQgcGFzcyBkZXZpY2UncyByZWFsIEJERiwgbm90IGFsaWFzZWQgQkRG
LiBPciBlbHNlDQo+d2Ugc2V0dXAgcmVzZXJ2ZWQgcmFuZ2VzIG9mIGFsbCBkZXZpY2VzIGluIHNh
bWUgZ3JvdXAgdG8gYWxpYXNlZCBCREYuDQo+DQo+SSdtIGp1c3Qgc3VzcGVjdGluZyB0aGF0IHRo
ZSBoYXNoIGxvb2t1cCB3aXRoIHJlYWwgQkRGIGluZGV4IHdpbGwgcmV0dXJuIE5VTEwNCj5pZg0K
Pm11bHRpcGxlIGRldmljZXMgYXJlIGluIHNhbWUgZ3JvdXAuIElmIHRoYXTigJlzIHRydWUsIHRo
ZW4gaW92YV9yYW5nZXMgaXMgbmV2ZXINCj5wYXNzZWQgdG8gZ3Vlc3QuDQoNCkkgZ3Vlc3MgaHR0
cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMjQtMDEvbXNnMDQx
NTMuaHRtbA0KbWF5IGhlbHAgb24gdGhlIGRpc2N1c3Npb24gaGVyZSwgaXQncyBhIGNvbXBsZW1l
bnRhdGlvbiB0byB0aGlzIHNlcmllcyB0byBtYWtlDQptdWx0aXBsZSBkZXZpY2VzIGluIHNhbWUg
SU9NTVUgZ3JvdXAgd29ya3MuIENvbW1lbnRzIHdlbGNvbWUuDQoNClRoYW5rcw0KWmhlbnpob25n
DQo=

