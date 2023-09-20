Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 428F47A7EA6
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:19:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwAO-0000ou-TU; Wed, 20 Sep 2023 08:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qiwAK-0000Zi-W4
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:18:49 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qiwAI-0005qC-3l
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695212326; x=1726748326;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8i3SY7xpd8BkW2dFLVRxRCtVeNyBdD4G6Z5qYyWtv3I=;
 b=Oyle8OoADyakMC5ED1KhhGN5n4f6qtajAOAcb2nwS05rQra1RfeRG1cd
 PcpX7W81L2r/5WciIeEAH447Gt/MTcE55SEePOyL7sxwyGaUNdfYbWuhY
 w5JYgw9S//8D2A6n1ToeWxgd1U6VzWCyXvLr356nh1jfi2YhI10EzMSmp
 sDvczs/Ja1avuLrSdEKPBnHS0OHlFxSomh00lKC9ru6hZQZGfiL/0/AX9
 YxmmNeLElIG8cem0ojZNOxcJiiGPnwWrpHRSq33AopI+qVX9VhKUF2lMG
 Iv4ztPMimkstJfPOVTGI4IomzDqfwOdutH9zIUcqs0SUg1DtrZYYorY5V g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360463234"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; d="scan'208";a="360463234"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 05:18:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="775980917"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; d="scan'208";a="775980917"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 05:18:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 05:18:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 05:18:42 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 05:18:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlO1xqy3x5bG+0MJJCBCOkBR9qN3VqlLtix3Ac0lxGmkt+NTGp03+8WriadK5NwoqvfYHgY5+f+jYqI6qVB8IdCQdhoG7E+yt2MxjMVreQwwWonNhhU4UBD3TnbLdOboJj91r5FggPwV4NMzZryBeepiHbVtpr//cpKvHqNYTWoGMcOE4aRA9Rpvdg4TU2ZNqsXDnbxZtcQJuP8eA4uraG0As10KuQalZ/AeNSqRlaZb0jshnY7yU/EcxS2lQO38tF24LN3Fdn91dgYcNBvfTxzGi2/9BN/Q9op6ulNVSqEgrX18WpHnL+l0FroAVnHpxXYwq1sXiAJj2n3Pl1HPNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i3SY7xpd8BkW2dFLVRxRCtVeNyBdD4G6Z5qYyWtv3I=;
 b=i+aAk84Jncm5WsIyvTWpXt0RT0H7zcqojKdmSUtP/EPNcFs1khToMTxleiM2xltZjDu24PxHmsXVxTDTRSWGIWafnCwpqV569QBmQN0IHzKqRXhuk0l3p4563YvMd0C49SQOpnVT2xXq4ywIt+d368zOXbYeMNPYoVv+4W/0YU7fRw1J+f8yvc39jnE0pO8gDKfAC7g9ulfrCinKwrC5egBvPvCUlIh0lbsF7lm/p+udyhFu7gM9duduiPfyx4j4LZ6pqnUQIy7Ut8r0im2fZSNcnCvZDj/scLNKsN1NC54hLCdq1qOTWVWdrYbXpw3LWEdfpAsz3KIQ2FAM7qSoww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB5765.namprd11.prod.outlook.com (2603:10b6:510:139::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 12:18:40 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 12:18:40 +0000
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
Subject: RE: [PATCH v1 04/22] vfio/common: Introduce
 vfio_container_add|del_section_window()
Thread-Topic: [PATCH v1 04/22] vfio/common: Introduce
 vfio_container_add|del_section_window()
Thread-Index: AQHZ2zAehlbwdht3pk2TTCWy8hx+WrAjs04AgAAO0GA=
Date: Wed, 20 Sep 2023 12:18:39 +0000
Message-ID: <SJ0PR11MB6744298608A17EF91A7DB90592F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-5-zhenzhong.duan@intel.com>
 <9c12db4c-439f-463c-76d6-fddc131e1f5a@redhat.com>
In-Reply-To: <9c12db4c-439f-463c-76d6-fddc131e1f5a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB5765:EE_
x-ms-office365-filtering-correlation-id: c0b8580d-9861-4048-bb8e-08dbb9d3b929
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OlxDapqEhvc/ILrGjFzYFaxr2xn1hOv2kAcCoAK7q8b8sXPCao8PAqW8Iuh0uQtZ93cnt4sklAEDGEe7MLQrWVt6ShadxQf0RuWI8gCtWEkMM/DN2ps/H9w39pwpq9Woj7dCMcX5gSmUFjQbPGXMVZb52pT6zq+dP3yUPV/a1DqHxaeUZjtNEnHRdqZdWpkGBfvkOO4sCJyesuQSCYujYofXDEeXvCkUxvZGOpFPs9CILYHszaGCOlXXsiLeKzuTi6wYio7+C/hf0brH3SRt6YgfWdDrPSoz8tbAsvaM0vbwKtFcu6OXMj4O1tKmcSua8yoGWlNBOzeZK71Zeg7RnfxwlKs9dJKMbGeo+Ce4hCNd1kmsN1jcVuskEkN1wcCfwcxT+J/HzsMZ3I4At6MMcsvfoMdWQ8ra0ZaJaWJFIQDn3nMSBk9HDxaD4DePPD+eJqCwqIJrCa1Y3UF9EhK0Y1jOHNjUn50vQkacX4EGuPrtoNlc6vzAZRpqfV3Q/eqOSDgWHrF9qdW1PsrzGzdxgfdUES7yUJOxWGEHeqpvbze9kkZ2U5CiMyx/LkgEz8n/AVo8geO/eTUquoq9LLX/EYMXt1sbvpDGWQc7M1xbUBs6VSqAMmtRBg8vXPEdPscP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199024)(1800799009)(186009)(33656002)(8676002)(55016003)(52536014)(6506007)(5660300002)(83380400001)(86362001)(41300700001)(8936002)(7696005)(107886003)(4326008)(71200400001)(82960400001)(9686003)(122000001)(66946007)(478600001)(38100700002)(2906002)(4744005)(76116006)(38070700005)(54906003)(110136005)(66446008)(66556008)(64756008)(66476007)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFNmMEpxTXZJZ2FaN2NDbDR1cHZUcDh0aDJnNzN4KzBGVEtEQ1ZQWmdyS2dO?=
 =?utf-8?B?WUh5TU9xSFdGbVd2YlVaeTFIU2h1SEpVVTlzRkNJTmJoWlYzMlFVbUpBclZa?=
 =?utf-8?B?MVIvS0JhNmw4ejA2dUF1KzNEczZBc3YrUEU5SjZ5TG9tZENUT0RhRkUzOXVR?=
 =?utf-8?B?UjltNXhONlJRVE0vQ0hSaXluQ0ROR0Z0UjBJYmIzQVZ1bE1JQUh1M2cvOHRh?=
 =?utf-8?B?TFdqYnVPK2ZkbkNpZXF3UGhEWmMrb2dqckFUWml0NE92QnlQRUEwd2pCWlFP?=
 =?utf-8?B?d1lYRzRGeERNTlJsMmc0b2RQUURCaUxQR3BiaHVJeDFka3Evem1BcHVCc0Iv?=
 =?utf-8?B?eTZGaDNMWjVDTTdyZ3FJM1BPV0RwdDRIckhmalBhYmJpNXhBL3Y1UFNuVVJQ?=
 =?utf-8?B?L1V3OS8waE5PQW9iYWQzSjFFYVdlOVRoR1JySmZsNU9PSDY1dFBGTXg1L0ZL?=
 =?utf-8?B?eGRkbmVmUFUrbllVUWpIQmJhcmVZTkpiKzNKRTdlT0JDZTFrbGIzeGF2dEw2?=
 =?utf-8?B?NytqcTR1a3FaN1BRaU42NDdPM3FONmxjOWlXK3ptZFRmVzFDMHBNck4zbmpS?=
 =?utf-8?B?ZEFjRUJDK1ZiQitHM0FQVXJiMTU4UE9YTXI4TlJaUTQrNXg5bTg2eCtFOGJ6?=
 =?utf-8?B?dUcrQXVqVngwd0FoQUFwQTdrWisrYVRYRm9pWms3dHZFL3BuT0xzc09WUmQ4?=
 =?utf-8?B?T1cxTzViVXVNZng0Nld6dDFMZ0dLVzVONi9SWWQ1MVZucmt2NnB0bHZ6Z3Iv?=
 =?utf-8?B?aUE1eURJUFU1bERDbWdrZEFscHM0YWpvRUJGSnVUT0U0WFB5dS9BZHMxalha?=
 =?utf-8?B?U09YSkJLTXV5M1U4empXU01Bak0reEdnajRuRzY2Y1Q3Y2UvdG5WczBnalpP?=
 =?utf-8?B?QnF1eDI1WE92S3V2NTVkL0VqRjI1alFPUHNMd0c1M3NEUkl4WUNJb3JKbWxr?=
 =?utf-8?B?MWxOK1JjQUNERzN4L1hkQU5IVE5CT0ZDMnVBTTR1Tng0OGxHbFhBbHNhM2wy?=
 =?utf-8?B?b0dlYmsyOGRocW9GNDVBYlRNMDRBRTlGMk82bDhDVUtpWGxnZnozT3IzRjN6?=
 =?utf-8?B?WThzNlFva0U4UzREYUxyZTJvMVlMVnhyZ0t5ajloMzhkSUlMRTlIdlNhS3V5?=
 =?utf-8?B?OFBRWmtvQXlqTmhPTzhiOFNBOU9PTDZTT05XZFhyNU1PL0tLaG5aK2o3cmJj?=
 =?utf-8?B?dU42M3pkL25qaXJHdnphdUdvRWEvNlArK082WWgxQzFtcGdUNGJsaWE2dVpF?=
 =?utf-8?B?WFZTZlJpaHgyQVhpMmFIKzF3MEloNFdWYjY3SW5rZ3NtSGMrUk93VG1hWStB?=
 =?utf-8?B?STNXY0JzenVrbUFLOFNxbjhNd2RmM0ovOVBMa2Irais0bFVqdzM4NS8rVE1H?=
 =?utf-8?B?bHhJRy9FbDB3bzg5RzdKdzNaeGd0eWpUaVhrWkZPVm9Uc0l3dWdEYUFjZ0U0?=
 =?utf-8?B?YWJCYTFwWEwwOVNFTTFIQWhNdUtiQzdHSzdONDU4bC8zZWlqQ1UydjA3M3lu?=
 =?utf-8?B?UTdrcVV2YmZIWWo4dVdsSW9QWmZSeHdIdHlXVllQalprbUpCdExwYklhWjRZ?=
 =?utf-8?B?NEs4MEYyTHJxWjZCQ1RXK0hjUFNDbzJYNFpPNTl1a0JkRG9hOUxWWmsrNjJS?=
 =?utf-8?B?MUwrTGgrYzN5bm8wK2JVUHVVZy9pT3RybHUvbFJhaE5kTjZ3aWVudUFWd3pO?=
 =?utf-8?B?SmUxNDIxUFAxSXFUcmlGdGlmSXhlbVlCTm9KZDVwZVZwTGQyVy9iUnJTTHZp?=
 =?utf-8?B?YlkyM1RqWGFraFNqTmsvbVpMb2FVNFlUdGQ2U2FKMFBPZ1I5UTdYbWlrWUVs?=
 =?utf-8?B?ek1JV2ZONWo3ZGZnbjRPYmFEZm5EcVp4NTVQSStucnNBbC9tcS9zR2VUREhB?=
 =?utf-8?B?L0dXSGcyckc3akp4YVB2MlFJZTJZOHhsbjVESzBuWWRtNyt3bDZtM2lHYzNB?=
 =?utf-8?B?eWJ6cVdVUGZzaWgvKzFpalN1VmppUTNnU2VRc2tUdzhVcHlOUEhiOWxsV1U2?=
 =?utf-8?B?dmhEVnZWOXduMUV4ZjQzYnRsN0I0TitiNkg1NitjQjA4d25aM0h3R3VlQUtz?=
 =?utf-8?B?U1dVVUVNNFhBbDVZQWFxcTVacnhnU1p0MXR5bnNRK25QM2RUanFiWlhscnd4?=
 =?utf-8?Q?6K3Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b8580d-9861-4048-bb8e-08dbb9d3b929
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 12:18:39.8548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwmjYTClQqzWwtKgCf5/JgEl2f1GMSnemzjQBHJmTpjLysq4swuj+3Zuq76EZz849iRYnOQOoOZbiql8auXswr7Rwt7sZN/h0dShLaHjK+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5765
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyA3
OjIzIFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAwNC8yMl0gdmZpby9jb21tb246IEludHJv
ZHVjZQ0KPnZmaW9fY29udGFpbmVyX2FkZHxkZWxfc2VjdGlvbl93aW5kb3coKQ0KPg0KPkhpIFpo
ZW56aG9uZywNCj5PbiA4LzMwLzIzIDEyOjM3LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEZy
b206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+DQo+PiBJbnRyb2R1Y2Ug
aGVscGVyIGZ1bmN0aW9ucyB0aGF0IGlzb2xhdGUgdGhlIGNvZGUgdXNlZCBmb3INCj4+IFZGSU9f
U1BBUFJfVENFX3YyX0lPTU1VLiBUaGlzIGNvZGUgcmVsaWFuY2UgaXMgSU9NTVUgYmFja2VuZA0K
Pj4gc3BlY2lmaWMgd2hlcmVhcyB0aGUgcmVzdCBvZiB0aGUgY29kZSBpbiB0aGUgY2FsbGVycywg
aWUuDQo+dGhpcyBsYXN0IHNlbnRlbmNlIHNob3VsZCBiZSByZXBocmFzZWQgaW50byBzb21ldGhp
bmcgbGlrZQ0KPlRob3NlIGhlbHBlcnMgaGlkZSBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzIGJlbmVh
dGggdGhlIGNvbnRhaW5lciBvYmplY3QNCj5hbmQgbWFrZSB0aGUgdmZpb19saXN0ZW5lcl9yZWdp
b25fYWRkL2RlbCgpIGltcGxlbWVudGF0aW9ucyBtb3JlDQo+cmVhZGFibGUgKCBJIHRoaW5rKS4g
Tm8gY29kZSBjaGFuZ2UgaW50ZW5kZWQuDQoNClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uLCB3
aWxsIHVzZSBpdCBpbiB2Mi4NCg0KQlIuDQpaaGVuemhvbmcNCg==

