Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F005680C136
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 07:17:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCZbq-00021H-BB; Mon, 11 Dec 2023 01:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZbd-000213-Lc
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:17:29 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZbc-0001li-1v
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702275448; x=1733811448;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WyTubbGr+lpTDXzm+Oo68lvSgeHlhqV9zRTo1jJf+yQ=;
 b=Wx/bkYs0VLEIwa9XwU7bYsS9D1UpD4RWrZrIYrEidbPr2JqprupoDpUn
 62D2mysx2Uvn+28lc9BrSYXzh6Uuo+cGM93DYL7WHfydyNqdE9DK7Ty/j
 lCPqNg0uazVt4lkCSD+GwUDAA//RspV2Uyeg32o01tTdniJNKpKsUV++G
 39uhsRJ9MnD5IxMUUpuy9Vd/tw2W0Gx14vZgz0W39Ri7VrhoT/3r9mD19
 lSnIkq9o3ZrDos4zFLlIUjT1/ziAEMvWzy7P42CENCYHwF9nbz1HEDVfT
 KyzGEPgfgydQr9JcIkIUQFoRVRDUGZOQ2ZwdEhJaiVptoodWry8U1kpT/ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1410859"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1410859"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2023 22:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1020117504"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; d="scan'208";a="1020117504"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Dec 2023 22:17:25 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 22:17:25 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 22:17:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 22:17:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFGI3Js4L0L6MOiPeRn/LN7EHL4BnpwjBu1EN2T6nEduPo9w05wKy29mpcoRDAvAyGjzmlmZE6D5epVPPL70BKQIiQegu4PU8htzLzEgWn3s57KQNjwPhSSJd4b2ifqiAuB/ly5F+m0P3wwxYdhlyRmhUkdL4/G4AG929LQX7zQxCtYEvWlMfhCG9ayntiaoY0gIqNBc7oBycHvVXCkYVRciPdWKxPF/ANla4LDg8jJNmbamu4k2UPyRpo8XrgbaX/sCkwKoeHuvbKaBuCvhyc0Zqk38DVo2ozbLOFMVOq0vbMoiTXk2XtwS685Y6dWpBVFMblMKYDljYIjFefkpRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyTubbGr+lpTDXzm+Oo68lvSgeHlhqV9zRTo1jJf+yQ=;
 b=FhHQg4y7/lJgytR8G+rczrzLxCGBEuGJlbkUVH4m9E8GSir3GXzKMBJLAQ8zATMSY5pZkv37g3OazjbKjpVcacnLSgPhH3R3kJrzjeWkVHevO8X914plWNS3ay24X8rXsFNT/oEtWIDUknaUDAWQXoqjnhNixv/lgiGoeUoRLHYZH+0pcMeYYYILNp6KHK+/UhiVj4sdP26U/xzekGelezQ6Ql+WSS2TMqZLs/gO8ZKg2jsqUVoUbU27W5AsvJNhjTK7b1reHQM79d/UhHzjSVpq2+tyha/1c28hxXGJpm2uhMZiUacUzL96malSdcE1weqlfZgtM1Sb/i0b0ysdAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7557.namprd11.prod.outlook.com (2603:10b6:8:14d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 11 Dec
 2023 06:17:22 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 06:17:22 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>
Subject: RE: [PATCH for-9.0 06/10] vfio/container: Intoduce a new
 VFIOIOMMUClass::setup handler
Thread-Topic: [PATCH for-9.0 06/10] vfio/container: Intoduce a new
 VFIOIOMMUClass::setup handler
Thread-Index: AQHaKbMnb50tiuWPmkC7TktxctAO3bCjn9lA
Date: Mon, 11 Dec 2023 06:17:22 +0000
Message-ID: <SJ0PR11MB6744EA97210A7F34BC9E1A2C928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231208084600.858964-1-clg@redhat.com>
 <20231208084600.858964-7-clg@redhat.com>
In-Reply-To: <20231208084600.858964-7-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7557:EE_
x-ms-office365-filtering-correlation-id: 6e42eeb0-01de-46e1-b200-08dbfa10d67a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Nql4mmVnFy1CTz9NNeSA+KEBOQa5jH+hz4aZjNewPHMrM2K10E1SDHL/+MXsQGGC8wsgUvdfsvVIVhVT7XpS9yizwVPtn5c7eO6be6aAZUdIu0k0AkSLU9rFDg8l3OJOQP9LwqjeJSLEMwymt/x9LMHfIewF+RFUrKMjB8va+NWgOhwKNh+GZTL42j5ciaoYeSywMXXrSHdIg7BPNZ3on95z6S3TkugaRHeQ5sRV6AhADQdUCq7oF3eDlkWjLMk8CGyIxm+MFv6YfzSufWHSHfbvqEdFHdjFmNggwFe20a4Os3tQG3oQEXLSZnolSGaMXPk8CZ6l3M28rzJHNTmq3d45+p8VBGTtdWsBJKO6zJoYRdeZV3TCVGW794l2AeADC3+aWszpvkSesaPUIe24n7mR8Or6I140qN0/ev3OEPZShz2rH/qQnugKBWOMUerzJ9kxjzMqxIHhp4H6cE9ggL21r/f2Ja7zwWVmNbj7sDCBVeGTohC53rN26dvEKprFkGTShsdB4ODSB1RneHuPDzgJdxW0XApPsXjeST5KKT1OFpEZCKvg2pmZ1Sgb9Fdv7BkA2uCtURoUwYgZhyzciIuO183YJHX6QDvrfeiX3pRI3/ZvS9VrGc7Grxc+S9X
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(52536014)(8936002)(8676002)(9686003)(41300700001)(86362001)(26005)(83380400001)(316002)(54906003)(66946007)(76116006)(110136005)(7696005)(66446008)(64756008)(66556008)(4326008)(66476007)(38070700009)(71200400001)(6506007)(38100700002)(478600001)(82960400001)(33656002)(122000001)(2906002)(55016003)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE1OUGhRVkdUOWtDVFdnMUt4QWRTYnVVSnZTRy9PSGNpcFFzK2E0SDE0ZDJ6?=
 =?utf-8?B?S1AxTGRnVVozYmdPZzRGRHR5WkprbWxldGNYMTZUWW15VVErcHMzTHQrakFW?=
 =?utf-8?B?QWF1bHFjZXZUaXdDUGVHa3BRTzU3U0FSZGVUVkZJN2gzbitSYUloRUJib1dE?=
 =?utf-8?B?RU9HK2NsTEFwZTBIVzdldjJyUm9kUk5xTE9HTE5QZ1VkUWRFZXZUNXRGLzJ2?=
 =?utf-8?B?ZEdUS2VqZXBnV1BHMDBvY2dyUlRkUmpqbTVqeWM1bHlnYjh2TnN6YjRVUG1E?=
 =?utf-8?B?ZlBmVEd6b3lZb255UDFvdzNRaWdmeFVkdjdUcnFhOFNFQ1hOaUdPNlZhRGNk?=
 =?utf-8?B?NG9jNmkxM05ZbzVxVzV5OUhHNWx3RDcwZVNyNHB6QVpkb1VFOThRYTJ6ZElU?=
 =?utf-8?B?SkhsL1dHbnhmZ2RFUHNuTWVzUkk2NGFpY2ZPSmFNZHQvVm5IVVprMnc5WHhF?=
 =?utf-8?B?Mi8xbDYxNzdTVDU4cXVIN3VadkxHdE4rU2pZd3RBSGN0dU1XSFlHd2plZ0VG?=
 =?utf-8?B?VC83bTh0d01rQVBqK3ZkNVlIanR4UForc1VvQVp3aWFrbmFvZUZaTG9CY3JT?=
 =?utf-8?B?d2VPMXI5OE5LclhHN1htWkFWOFdnRG54OW5NRkxUOGN5UU5SZ3d0YmNXUXVh?=
 =?utf-8?B?aGZtRjJyZFloNjVNcVJGdTUvbVpwY1hWMXFNNXJ6UUdVNDdTbDN3UVM4S2ZB?=
 =?utf-8?B?N0FyOGM1SGMweGYrVVdtZ2tIcWtSVVB3RFI5cnptcjA2WGFsRFFxdDB4NjY2?=
 =?utf-8?B?ZDZxbkRUYjlleFZGWm54Y1pvVU9GZHg3N3RwRTl1dU8zZExFZ05TcHVBTmJS?=
 =?utf-8?B?Y2xkSW43d2dqc09rUzZSMDNieGlwanRQbC82eUN0enZyZXVxK2JuVk91MDZl?=
 =?utf-8?B?SnIzR05pMEhSU2lVbjhVenBCTjkyL3ErQmU0MjJ2MjlJdHdORmd3MHFZQUFS?=
 =?utf-8?B?cXlCazRjWmJpZmp1NEZueGRTRUdQOUtnQ0wwbGg4S2Ivc3Y3WnRYUWhJdTlD?=
 =?utf-8?B?NTlOdTl0dmhiOUU4eURGSXVXTk1tVEF6SE5BWVBSbG9pNWJpUmJkYXZ5emdO?=
 =?utf-8?B?ZmZ0dXhaSU4wUW9VZlh3RmRoWG15QkFuTk5XWlR6Qng0VHJ2RzMyeFgxYXlk?=
 =?utf-8?B?RGNWaUNtd2EyL3ZQREJtM0h3MGlXTThIUnBmU1o3VzYrU3dMeHE2MGxXamNl?=
 =?utf-8?B?eXhOVTd3TUtGOTZydmVQbWcrZ1JKeFFxbTN0VWdPcmtTTjd5VHh4SkpIZTZP?=
 =?utf-8?B?TCsvaUJleURXVlpheDdUVkVxQlhwZ1ZVWFVUYUdlYWNUOEJvdUltSzVCZUpk?=
 =?utf-8?B?ZGNKaUtaVDdTaGFjQUhKVFBHYnhQd0lMajMrV0dKdS93MGlGelE5TGd6bDl4?=
 =?utf-8?B?TGtaMC9tMVBkenVpSHE4M3VtdGhWRUpJWEVvb3pRM2MxcWVPR0hwZ0hOZUZ0?=
 =?utf-8?B?WUlUUGlXaHkvOUF3ZklwYko5U2ZEYzNqMkJWQThiQzNLOU15L0Eva0JLOHo0?=
 =?utf-8?B?Yi9kQ1RIRGFZMXdManQwdVU1d05lQS9WR2dGa09uR3hhcTdKdG9NRTYyZUVU?=
 =?utf-8?B?eVlwNmJBSTc5b0daZlFTOGJzSWprcDdXY2N5VFJXbnZWUFcwRWpxcUQzay91?=
 =?utf-8?B?Uko4Sm5mZXpwMGQ1NGI1dzlyY2lGeG5Kblh2dDduZ04zcElMRUVLZGxhTjRB?=
 =?utf-8?B?RXNmVHVJa1Y5MGhmZ2JjRitZOHJwbnFSSkJ1QXN0cStMUnRlbVFxL3h6Z1VM?=
 =?utf-8?B?b3NmWXVUcmxMeWdDNFNHNlplMVZ3ZW03aFlLYS9KNTR5ZDJaSS9taE9xV0Nt?=
 =?utf-8?B?cHBKcnp1V1pyZFJlY1I1czJwRitESDBkNE50KytsR2psUlJvekpBU2M1SnNw?=
 =?utf-8?B?WTVDb1NoWDhlWUtRNk5VVDl6VHM2Qy96a01CcW9rUWVzTGhVdnRVMFdiYnJ6?=
 =?utf-8?B?UEdTbndYK3FWRURFeXhsUzhVZzNBaGpoQnhjdmR2ZXlzYlFRaEdJeFNtc2ZQ?=
 =?utf-8?B?VDdDQ05rc1BMRGlXakxiNEdkVzJzb1lQL0NHYkFjWGV1OUdJY252QlFHcVJH?=
 =?utf-8?B?YVJ0Uy83RjZJMGN0MG80UmJtaVBsOXVWMW1HZzBjMFlZQlphZk5pdy81ak5w?=
 =?utf-8?Q?Li7gJzTQ3bkzFqUYmfT8xHquc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e42eeb0-01de-46e1-b200-08dbfa10d67a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 06:17:22.7819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOQENqPuOu6Haa2aNRlBs9NnISJd/55hJ9iO6dAxsf8ohell+b8wpMzOmvk3oNKJ9brLSPCXIlWYaiNerA867g1+m55mL7vh6e59j5nMdVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7557
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIERlY2VtYmVyIDgsIDIwMjMgNDo0NiBQ
TQ0KPlN1YmplY3Q6IFtQQVRDSCBmb3ItOS4wIDA2LzEwXSB2ZmlvL2NvbnRhaW5lcjogSW50b2R1
Y2UgYSBuZXcNCj5WRklPSU9NTVVDbGFzczo6c2V0dXAgaGFuZGxlcg0KPg0KPlRoaXMgd2lsbCBo
ZWxwIGluIGNvbnZlcnRpbmcgdGhlIHNQQVBSIElPTU1VIGJhY2tlbmQgdG8gYSBRT00gaW50ZXJm
YWNlLg0KPg0KPlNpZ25lZC1vZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNv
bT4NCg0KUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5j
b20+DQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4tLS0NCj4gaW5jbHVkZS9ody92ZmlvL3ZmaW8t
Y29udGFpbmVyLWJhc2UuaCB8IDEgKw0KPiBody92ZmlvL2NvbnRhaW5lci5jICAgICAgICAgICAg
ICAgICAgIHwgMSArDQo+IDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+DQo+ZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmggYi9pbmNsdWRl
L2h3L3ZmaW8vdmZpby0NCj5jb250YWluZXItYmFzZS5oDQo+aW5kZXgNCj5hMzFmZDljMmUzYjlh
NTcxMDgzZWE4OTg3YWMyN2U5MWIzMzJjMTcwLi44NzBlN2RjNDhlNTQyZGRiZmM1MmUNCj4xMmIw
YWI1ZmFiNDc3MWExZWJkIDEwMDY0NA0KPi0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRh
aW5lci1iYXNlLmgNCj4rKysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5o
DQo+QEAgLTEwNCw2ICsxMDQsNyBAQCBzdHJ1Y3QgVkZJT0lPTU1VQ2xhc3Mgew0KPiAgICAgSW50
ZXJmYWNlQ2xhc3MgcGFyZW50X2NsYXNzOw0KPg0KPiAgICAgLyogYmFzaWMgZmVhdHVyZSAqLw0K
PisgICAgaW50ICgqc2V0dXApKFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyLCBFcnJvciAq
KmVycnApOw0KPiAgICAgaW50ICgqZG1hX21hcCkoY29uc3QgVkZJT0NvbnRhaW5lckJhc2UgKmJj
b250YWluZXIsDQo+ICAgICAgICAgICAgICAgICAgICBod2FkZHIgaW92YSwgcmFtX2FkZHJfdCBz
aXplLA0KPiAgICAgICAgICAgICAgICAgICAgdm9pZCAqdmFkZHIsIGJvb2wgcmVhZG9ubHkpOw0K
PmRpZmYgLS1naXQgYS9ody92ZmlvL2NvbnRhaW5lci5jIGIvaHcvdmZpby9jb250YWluZXIuYw0K
PmluZGV4DQo+ZmRmNGUxMTY1NzAwMTM3MzJkNDgwNzFhNTEyMmQyNWIwMmRhNzE1Yy4uNWY1YWQ4
NDc5ZjA4M2RiMGJlNTIwDQo+N2YxNzlmMzA1NmFlNjdjNDljMyAxMDA2NDQNCj4tLS0gYS9ody92
ZmlvL2NvbnRhaW5lci5jDQo+KysrIGIvaHcvdmZpby9jb250YWluZXIuYw0KPkBAIC0xMTI5LDYg
KzExMjksNyBAQCBzdGF0aWMgdm9pZA0KPnZmaW9faW9tbXVfbGVnYWN5X2NsYXNzX2luaXQoT2Jq
ZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0KPiB7DQo+ICAgICBWRklPSU9NTVVDbGFzcyAq
dmlvYyA9IFZGSU9fSU9NTVVfQ0xBU1Moa2xhc3MpOw0KPg0KPisgICAgdmlvYy0+c2V0dXAgPSB2
ZmlvX2xlZ2FjeV9zZXR1cDsNCj4gICAgIHZpb2MtPmRtYV9tYXAgPSB2ZmlvX2xlZ2FjeV9kbWFf
bWFwOw0KPiAgICAgdmlvYy0+ZG1hX3VubWFwID0gdmZpb19sZWdhY3lfZG1hX3VubWFwOw0KPiAg
ICAgdmlvYy0+YXR0YWNoX2RldmljZSA9IHZmaW9fbGVnYWN5X2F0dGFjaF9kZXZpY2U7DQo+LS0N
Cj4yLjQzLjANCg0K

