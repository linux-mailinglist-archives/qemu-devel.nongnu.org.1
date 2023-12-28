Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E9281FA87
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 19:45:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIvNX-0008Dm-U7; Thu, 28 Dec 2023 13:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rIvNU-0008Dc-DM
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 13:45:09 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rIvNR-0002Rs-2M
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 13:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703789105; x=1735325105;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yngjOE5xJrwSOdFj0jHSWtDj/RSAklekkACWsorWF8s=;
 b=Ye+saZ5wbou3D3xIJg2bfET9xTCh61RVfT9PKZudLI5EnWUZYkTyCy1k
 VezAzCF/mcnmpvwiak/vclf6eRVZbhcdiBm613T2Gsb+5mZ1BkIZWlcye
 3lOHyiXRgIo7BiLo3MZYwoojj05Ci4I0NLz6QUpqbFhP8C2pxGBm/NFc5
 CA8W8nktwbGNZKWtKFzDZMfDJf1COMsRxnranXuZmBZw43wPx+uyxIqlo
 gm2PevhpoXE3+VXrO0P4aQfx448veuqZascZXLbYC4jX/XTzzxT5h70h+
 gSea95RvEDg1jbogahAzkM8dF6AGS4L/FwcmZ+cB2Rr+eykxUGJ9XaIaF A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="9969716"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="9969716"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Dec 2023 10:40:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="1109973110"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; d="scan'208";a="1109973110"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Dec 2023 10:40:36 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 10:40:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 10:40:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 10:40:35 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 10:40:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH5GvVKwOqcyT+TnOch1Plz5+Opy7SrhK+N7DDpZuAw4M0k5KHpyJbkuYk4G8wcdalqEpWq67rpZcHkq4Ko1TSdGNHJfbUWQz0LCYACGs3wAE3Gyytq+FPFMvLWN35FgXdYl7JvNr7/9PVfxjTDDG6dX8pkPNpM0zvCwCuW35Re4Hxa+3qivY9TnaQqJ7im+++fF+tDgw4XrKra3epSXZbqZSa0GcqUsxPbkDQ3Hl/7PIIbr1ai4irpwk916jqeed3r5Dw7/i8U2roxhJZWJxycK7W4I0ACVWgkoblmcTpWoi8r6Ikt9gnjrLQr6/8055Leek1Lc5ftL1/rCwp5D2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yngjOE5xJrwSOdFj0jHSWtDj/RSAklekkACWsorWF8s=;
 b=HKpoopVZ7gEFBAmJJERSH9sHyWUvsJO3fPRZgA+EhtO2/+wy2iQokup6QxAxQJrij4rie4LdZofZN2tf6X+ajElL4UzzbetdKM2zIt3M+5pl8gom7kvS4G650+hCCdQBvCVis8Te6HDofi5Mxh3s0lCcrG6j6LQ4gcWyLwphlLJX6WofBPsw0AGcYEYQ9iXmxm5KZ6Y6LK11Z+N2OsJxp59G8x9g+RcaSSpJTDDRDrQluPGn9Jeyn3TXFA1F79dYartgkHPhjdZPP764iLEI+nRQ2zRyNTUHUqu216cPgkqKQ5U92Cv92u2pD5ksBSTPCUAkz78nY+sD/iwAZd7mDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by DM8PR11MB5686.namprd11.prod.outlook.com (2603:10b6:8:21::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Thu, 28 Dec
 2023 18:40:33 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::1332:70db:38b7:437d]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::1332:70db:38b7:437d%7]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 18:40:33 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Kasireddy, Vivek"
 <vivek.kasireddy@intel.com>
Subject: RE: [PATCH 2/3] ui/gtk: unblock pipeline only if fence hasn't been
 signaled yet
Thread-Topic: [PATCH 2/3] ui/gtk: unblock pipeline only if fence hasn't been
 signaled yet
Thread-Index: AQHaLkWDisfQQn+HVUaF7uq6tGO1ObCqBxMAgBUFvMA=
Date: Thu, 28 Dec 2023 18:40:33 +0000
Message-ID: <PH8PR11MB6879390DA21D2D4FE9A45284FA9EA@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20231204184051.16873-1-dongwon.kim@intel.com>
 <20231213202419.15459-1-dongwon.kim@intel.com>
 <20231213202419.15459-2-dongwon.kim@intel.com>
 <CAJ+F1C+GR7gEO2SktenXpRUHtFAvF-ZrW_QGe0-nSErZESbjtQ@mail.gmail.com>
In-Reply-To: <CAJ+F1C+GR7gEO2SktenXpRUHtFAvF-ZrW_QGe0-nSErZESbjtQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|DM8PR11MB5686:EE_
x-ms-office365-filtering-correlation-id: 04fb7617-27eb-4f4c-d662-08dc07d479c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g1mHAWRVtE3okgrsujQVXLg8pwQ4nnVystowrI37Z/+tNBSq9T90XCbNTFZAL4bB5koGPpB30MYMgA28+AVrdFIrOrOy/ScWMA68Zy0GW9YJunGTFhuejBZOIAy5KIDYtQXgaemUXqOhgsCYtnK1i8WVbOYhcUDQxPHPVBYNUwQ467u4aNH5Dpf2PLuoqNutWSPdSEev4iRBFBt3WXBFmxPZUwk7ZKkPZEVUfQqG1B1qBvgwX7nrcN8hURLuriC3KKKhMzWIpTpRuKpe+LiKvxWoNxXSJIR0hDbkYoyq6FdPQHCCajLmCOINFpc5yDFww6YfHV5mOmyyK7/KjVlGhEhMOfKFT7BBkDIBOn6kxciyyuhoa5lhNEIA6qrF/yiMQJwCbE8daWcSF0sNZZnHOyXSro8p1KL/bdEJZe9hfXcqs/odrVXhcN57rGn2nVNfWqIoEtPjvpm9khjNEcm1rQav1vBVziV5+K1OfBowfN8VdDfL9mB3LtHOsB0IuC0y/rnuIa2opwBgdpWrcFxUUfi/O/JXOk/hIIbA47As2tOaPucbsCiSu4J4/qOtk3KuwTdHQvgv0zTlo0cowKtJ0Cs9+Zt/U/A18KHTupEQhNz17yVscYv5PIOmxm0Q6qNk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6916009)(66446008)(66556008)(66946007)(66476007)(64756008)(76116006)(316002)(8936002)(54906003)(8676002)(107886003)(4326008)(26005)(83380400001)(478600001)(6506007)(9686003)(53546011)(7696005)(52536014)(71200400001)(41300700001)(2906002)(5660300002)(33656002)(38070700009)(82960400001)(38100700002)(122000001)(86362001)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3hyajEvV0FIYXpIbVNoRFFNNnNJTWxZQmt0ZlgyQ1pMYlpxNXlndTlxZHo5?=
 =?utf-8?B?Y3VsRXhVSWRHR2tRRWY4YzV3MnMya21maVNZbnY5aXExYXROYWxiMWhoc1hw?=
 =?utf-8?B?Y0EybHJKekpZTHA4WUt4NDl5eURLSitsbFBYVlRodW5aenVtVmxKSmFMdU9s?=
 =?utf-8?B?UzVibzJFUlZvd0g1M2NYQ1JpTmJjdlgxYWtFNUJ4RUtVTnhTVGF2alg3V05O?=
 =?utf-8?B?RzgrRVdndEpzdWVlbFJBVWozZlRqUnZaTDhHVU9MSWF6NXBpOWp0YnZMRUsv?=
 =?utf-8?B?ZjM3ODRyR3Zxc3BPRmZpVlRRQVNNVnhjUW9PMVdMeVJlcVhIdkMxZ1U2TUQy?=
 =?utf-8?B?bkhhR1VWclBPWE1sdXNsajNzZWZybytHVWVibjRaSTRGY2M2MDBYVHREai96?=
 =?utf-8?B?L0Z0QUFZS21sanN6dHpEN3AzTCs2Q0p3Y2J5YjFGcEtBU0QxM3lzUUpPZU9H?=
 =?utf-8?B?STVrMVNBbnoxOXltRThpZ1dRSWdSWXFGb255UnhFeTRveU9GLzdUZ015OW1T?=
 =?utf-8?B?b1hwdlA4cHUyYkViOWx3SjZxVW8yRjN6WU0xYjRyZUxtRVJDeVJTdGhLZXhV?=
 =?utf-8?B?eHdpSlloNG9Pa2k1QTJvMkF6NHZaWUtPc3JETTlHdmt4L1llK2J6ejhVWXVu?=
 =?utf-8?B?UXhZdGFoUFg5ZGtKWnFGT3g1OFpiVERTNUJycnM4WURFa09iTzQ2c3R3QjJV?=
 =?utf-8?B?R0pja2FVdWJLK2RKZXh5bzZGRkg3V3hxdGtTRTRHdUh6WlMzbWZ6ak54d1dn?=
 =?utf-8?B?K1JlYXFmZkJENCtSc1pNUUxJNG1teDliVUdJRHRVZWtwRlJDNHMyV3RXVUU4?=
 =?utf-8?B?RUN0UDdvUFRZVEc2dTYvQlNYOWQrVWVoNWVlV3lNVC9lNWczbHhzdUhlb3I1?=
 =?utf-8?B?a05Rby9JbnlNN0tTS1dqdCtPU3pHdkwwSXhZMUM5RGwzVUZpSnVDaXdCLzZW?=
 =?utf-8?B?bTdUNG9WUjVMYzBtMi9uTW9tQ3BHNS94Yko4YlVBTXRmZlI2K25peGhmWVBS?=
 =?utf-8?B?SnJiUVhpOUh3RTkvNnk1OE5pSEtuRDY5UTlETXF1SXdBQWR3eHBzdS9UMTNO?=
 =?utf-8?B?NElOYWwvV0Qzc0hRa1U4b056MnF3azZuQmpjbzJXeWYxdlgwSzliWTRzSHN4?=
 =?utf-8?B?d0FzaTdJS2svQzF6VjRYK2dmNllhRFp1OFl6cHJZSEFEdmJJcEZEK3FkUUNy?=
 =?utf-8?B?eGpvdXk5NDNPditVRlgzaWpWVTRjT05xOTBIVW4ybFpEQnpzWUlUL2lEMTlZ?=
 =?utf-8?B?ZDV4S3BROElaUjhTNTJBdE1Da1FuejFubEhicEJjNlZZbzZvY2dPa29xUGs0?=
 =?utf-8?B?TlRueDE3SUdNLzVqVGNadm9YY2dFSU0wdy9iNHJJaVMvMUhaL3RLRng0NW1D?=
 =?utf-8?B?TEp3aGF2RHhlbHRVODgxQzZuYll2YlBhUCt0MTl6a256eEFRb1pIZldnVVN2?=
 =?utf-8?B?cGFLSUFkZHNLS1dGVkZSV1dLNWE5dUp2dndublRHV1VzcHZiakF5ZWJNUU10?=
 =?utf-8?B?SmNNM0ZEUGJRQnROS0ZlTGFhNU5sbjVmV2xpREJhcUxTY0ZnK1FrTXBxMUQv?=
 =?utf-8?B?VnE1bGl3cktpV2hORUgzWERVNmNxSmorL3dCRlZVc1FiS3pUZGI5ZWp1dklV?=
 =?utf-8?B?UkFYWmgyZlBGN1ZBMDh2emR6SEtrR1c1NVg0QTg4d3AyVjF4dmxyUFRnaG1Z?=
 =?utf-8?B?UG1BTXJjRFhIZ01IU3loV2I2VTU4SlFhaTUva2ZyM3poQnd4WHZ5OFhETVBX?=
 =?utf-8?B?b20ra00zK0c4ZkpEdEhJRXU4bG9lWVB5UC9SQU1jMVpvZUl3YjgwbWcyQXFq?=
 =?utf-8?B?WGhWUjBtQi9NSEhBMHJibnN3blFqUDZ6R09LV2twbVJLLzdQekhKVUpWRnpQ?=
 =?utf-8?B?R2FCY0w3YlJHZVZaK1ZkYllOVTJzQ1RhczVDenVwS1N1WkZQT0dFdE1TeFlk?=
 =?utf-8?B?aDR4Ulh0MzRJNmRra3k3bnNHaHJYL1VOUms4aGt2R1dsMnVheG1udk5ySktR?=
 =?utf-8?B?Y0QyMkphck5HckhzLzNaYkVuZjFTdWZRNFFPVlRzbWxaTGhIWEdkamtSN2dJ?=
 =?utf-8?B?dTdUcTZmWTRBWkczR3lrQ2ljbXhsWkQ2SGl6eWpZRndlNEhONU1pczJKWmQz?=
 =?utf-8?Q?UL4HLmcxZmxFpLIOgdfpRroVD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fb7617-27eb-4f4c-d662-08dc07d479c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 18:40:33.6911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aiKIB+NtZyA6LWjzw7qWs5TjPunQrfTJ0flBORLx+9REvjPSWOLIqnhLScO7vazktCxVT/wPDRGzmpcLxgnlcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5686
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.981,
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

SGkgTWFyYy1BbmRyw6ksDQoNCkkgcmV2aWV3ZWQgYW5kIHJlYWxpemVkIHRoZXNlIGNvbmRpdGlv
bnMgd29uJ3QgYmUgbWV0IGluIG5vcm1hbCBzaXR1YXRpb25zIGluIGdpdmVuIHVwc3RyZWFtIGNv
ZGUuIEJ1dCB3ZSd2ZSBpbml0aWFsbHkgYWRkZWQgdGhvc2UgY29uZGl0aW9ucyBpbiBvdXIgaW50
ZXJuYWwgY29kZSBiYXNlIGZvciBkZXYgYmVjYXVzZSB3ZSBvZnRlbiBoYWQgdG8gY2FsbCBnZF9o
d19nbF9mbHVzaGVkIHRvIGZvcmNlZnVsbHkgdW5ibG9jayBmcm9tIEhQRCBjb2RlIChpLmUuICdj
b25uZWN0b3JzJyBwYXJhbS4gTm90IFVwc3RyZWFtZWQgeWV0KSB3aGVuIFZNIGRpc3BsYXkgaXMg
ZGlzY29ubmVjdGVkLiBJbiBzdWNoIGNhc2VzLCBpdCBpcyBuZWVkZWQgdG8gbWFrZSBzdXJlIHRo
ZXJlIGlzIGEgZnJhbWUgaW4gdGhlIHBpcGVsaW5lIGFscmVhZHkuIEFueXdheSwgSSB0aGluayB3
ZSBjYW4gY2hlY2sgZG1hYnVmPT1OVUxMIGFuZCBmZW5jZV9mZCA8IDAgYmVmb3JlIGNhbGxpbmcg
Z2RfaHdfZmx1c2hlZCBpbiBIUEQgY29kZSBqdXN0IGFzIGluIGdkX2NoYW5nZV9ydW5zdGF0ZSAo
W1BBVENIIDEvM10gdWkvZ3RrOiBmbHVzaCBkaXNwbGF5IHBpcGVsaW5lIGJlZm9yZSBzYXZpbmcg
dm1zdGF0ZSB3aGVuIGJsb2I9dHJ1ZSkuIA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSB1
aS9ndGs6IHVuYmxvY2sgcGlwZWxpbmUgb25seSBpZiBmZW5jZSBoYXNuJ3QgYmVlbg0KPiBzaWdu
YWxlZCB5ZXQNCj4gDQo+IEhpDQo+IA0KPiBPbiBUaHUsIERlYyAxNCwgMjAyMyBhdCA4OjI24oCv
QU0gRG9uZ3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4g
PiBJdCBpcyBuZWVkZWQgdG8gdW5ibG9jayB0aGUgcGlwZWxpbmUgb25seSBpZiB0aGVyZSBpcyBh
biBhY3RpdmUgZG1hYnVmDQo+ID4gdG8gYmUgcmVuZGVyZWQgYW5kIHRoZSBmZW5jZSBmb3IgaXQg
aXMgbm90IHlldCBzaWduYWxlZC4NCj4gPg0KPiA+IENjOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1h
cmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gPiBDYzogVml2ZWsgS2FzaXJlZGR5IDx2aXZl
ay5rYXNpcmVkZHlAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERvbmd3b24gS2ltIDxk
b25nd29uLmtpbUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIHVpL2d0ay5jIHwgMTQgKysrKysr
KysrKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdWkvZ3RrLmMgYi91aS9ndGsuYw0KPiA+IGlu
ZGV4IGVhOGQwNzgzM2UuLjA3M2M5ZWFkYjggMTAwNjQ0DQo+ID4gLS0tIGEvdWkvZ3RrLmMNCj4g
PiArKysgYi91aS9ndGsuYw0KPiA+IEBAIC01OTcsMTAgKzU5NywxNiBAQCB2b2lkIGdkX2h3X2ds
X2ZsdXNoZWQodm9pZCAqdmNvbikNCj4gPiAgICAgIFZpcnR1YWxDb25zb2xlICp2YyA9IHZjb247
DQo+ID4gICAgICBRZW11RG1hQnVmICpkbWFidWYgPSB2Yy0+Z2Z4Lmd1ZXN0X2ZiLmRtYWJ1ZjsN
Cj4gPg0KPiA+IC0gICAgcWVtdV9zZXRfZmRfaGFuZGxlcihkbWFidWYtPmZlbmNlX2ZkLCBOVUxM
LCBOVUxMLCBOVUxMKTsNCj4gPiAtICAgIGNsb3NlKGRtYWJ1Zi0+ZmVuY2VfZmQpOw0KPiA+IC0g
ICAgZG1hYnVmLT5mZW5jZV9mZCA9IC0xOw0KPiA+IC0gICAgZ3JhcGhpY19od19nbF9ibG9jayh2
Yy0+Z2Z4LmRjbC5jb24sIGZhbHNlKTsNCj4gPiArICAgIGlmICghZG1hYnVmKSB7DQo+ID4gKyAg
ICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiANCj4gV2hlbiBpcyB0aGlzIGZ1bmN0aW9uIGNh
bGxlZCB3aXRoIGRtYWJ1ZiA9PSBOVUxMIG9yIGZlbmNlX2ZkIDwgMD8NCj4gDQo+ID4gKw0KPiA+
ICsgICAgaWYgKGRtYWJ1Zi0+ZmVuY2VfZmQgPiAwKSB7DQo+IA0KPiB0aGlzIHNob3VsZCBiZSA+
PSAwDQo+IA0KPiA+ICsgICAgICAgIHFlbXVfc2V0X2ZkX2hhbmRsZXIoZG1hYnVmLT5mZW5jZV9m
ZCwgTlVMTCwgTlVMTCwgTlVMTCk7DQo+ID4gKyAgICAgICAgY2xvc2UoZG1hYnVmLT5mZW5jZV9m
ZCk7DQo+ID4gKyAgICAgICAgZG1hYnVmLT5mZW5jZV9mZCA9IC0xOw0KPiA+ICsgICAgICAgIGdy
YXBoaWNfaHdfZ2xfYmxvY2sodmMtPmdmeC5kY2wuY29uLCBmYWxzZSk7DQo+ID4gKyAgICB9DQo+
ID4gIH0NCj4gPg0KPiA+ICAvKiogRGlzcGxheVN0YXRlIENhbGxiYWNrcyAob3BlbmdsIHZlcnNp
b24pICoqLw0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCj4gPg0KPiANCj4gDQo+IC0tDQo+IE1h
cmMtQW5kcsOpIEx1cmVhdQ0K

