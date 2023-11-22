Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 404357F3C74
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 04:33:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5dyM-0001AD-OY; Tue, 21 Nov 2023 22:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5dyK-0001A0-IV
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 22:32:16 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5dyH-0000Hd-SH
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 22:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700623933; x=1732159933;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Y0l94+E4E4gWsKiiTRvvgReDYn7afvWV7zPfj53baJA=;
 b=L8FE6C1hzOQxSTiDdSksGEcRmPdf+flGmam+6zxA9VMHzNtdWgr2LoMV
 5sK8jhkKgNgRSJt3RCAmrydjb/nhOySqTav7LR34b1i8jp4vnLpgOGlci
 o7ArloyFizEsR/6p7vo3YPaVt+2vEXdRjG7QNE3EKfoSJWnLlktsMQvAZ
 boYUQmIRIeocCZfJBdyjoE5YccJ0VCBnlw+ToUlP4ddLo3S2QfdjPUAym
 mjZMh2CaYpk4IspfdyUyNz2E28POBVdtXNKnNvK+bEzpDyk675dPa5S/T
 nOxD2SB/C6xmN7uQ0v7fh+TPbpoTpFDbzETDIJvCw/xQhmL6qJiMFCnyp g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="382370031"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; d="scan'208";a="382370031"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 19:32:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="801762874"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; d="scan'208";a="801762874"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Nov 2023 19:32:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 19:32:08 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 19:32:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 19:32:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+2OYIMU9vFqyw7CK7wOZ/No0YUEE3I4lBKqLPUW52fBjMGniAPY5KelpjUPQnm4JHRM+Mo3ymn99QViApzxQvdiCB328sQbxGXZebBqJHUJkPg2+DxvjJxB+luvmlBz14rAr9t6493fIpYyTe2pNdWjtRSNarAT7vWHhi8kb+l4pToHKk5miKVQNs3kL/5p1fPg95sNQy5wnaijYs4xNKlmMCrq57RRhAKzlRpsuCz03j8yDmRGal6Zv9BAdCXUbL4RVAXCyCQLf8IMFVs2btMjbxgMbr1pz9sBTh+fgU33jzJ430MX7d2LsrkeOt+Mho6B3xIqaynDtofT1k3hAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0l94+E4E4gWsKiiTRvvgReDYn7afvWV7zPfj53baJA=;
 b=QQ9Ply/jTvMhIFZoy+qAgBQOnQEMEdDjx6O9H9SLccteRBg2X2zQOO8nQm51thXK/ro4nFGAEhWMhwGnLU5ipuHYcapfu4PnJQCEf4sOR4+Nsixuorwi38Eg6Lj1NyrgMb9LRYItrQ8Um+IbvCO7y5F5zv5pLyc1QjF1omFEaZS9Y1xTFvHAOoImSnStfgCxfAB/8Ks82WWBH28qMBPmo5tWUY0Igp6Z6uaES1QrgCFtn5+MsVz8rR5hxqMZbiciO4/9jfeyXz4CCkC+H0TNYulHVz8qhuLZf54+/t1gjIe3R11R5bNljQDLSqufjA2Zl5/R9xJSDqt8MO3F0YisBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB6758.namprd11.prod.outlook.com (2603:10b6:806:25d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 03:32:05 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 03:32:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v7 08/27] vfio/pci: Introduce a vfio pci hot reset
 interface
Thread-Topic: [PATCH v7 08/27] vfio/pci: Introduce a vfio pci hot reset
 interface
Thread-Index: AQHaHFdLaAZ+YkY1Mk+nCQFhWsx6ULCFG0CAgACSKTA=
Date: Wed, 22 Nov 2023 03:32:04 +0000
Message-ID: <SJ0PR11MB6744CBD65A16F3444654568A92BAA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
 <20231121084426.1286987-9-zhenzhong.duan@intel.com>
 <9c7b820b-3c36-4d39-953b-1e2ba0db63a6@linaro.org>
In-Reply-To: <9c7b820b-3c36-4d39-953b-1e2ba0db63a6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB6758:EE_
x-ms-office365-filtering-correlation-id: bfbd6ddc-ad20-40de-c048-08dbeb0b9934
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ENWkoJglHw2I7ejuzRJDX3kd062lsC0nY7tu8A9VYMEatbox8i302fJITeF9BItPPy7Z1lao/r8oUDP0zr796tNsWGmhtDPr0W2/x3PfAr5x0uedngSS/3r4bB+cgCsFIz3DWznc0e/qBZALXBN2c6WJNr8BKoh347oUkdN/Wbb4xbfnBCm4GTIlaO2Ggz/eQ6zGc0flYSV16EOpLno/omsqeAxTO5evEQfT5F7AdsqBVtm8sr8Ars+LkS0cGG/zR1SOIKhG0ww1Y6yPvMjM2qcp/sRqWbLp3km5Plm+XKK37/jGiyT5j1x04HL0hWdn0LDz7SvkIsBd/7IPKjKMU6JGNE+bydAjwGEY6b1vu3VLwv7cxtTRZIdYDl1whbECoG922w7mZY7k+yi5pM76v6S4JzDJvtM+7yLR2ogp8Zq8lCWOn//hR4rbdOh4qrLuISBclc3coLqk4qmBDGO7mDl/ZVIhtvEO7bSrDnanz5Cgvrz2Su7TouxQsOyRSA964ODBJR+NIvOEoSwok1qQh4z5LKik0h91qoyh9kW0XGlXIpxWB/huG4Bq0LMb74Iyvf8bzCmticsdYSsypZfMeJ77XPtZklpPhH2Dm5SF0e4OnwJulaUVtG4zbT5NvVJn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(7416002)(2906002)(52536014)(8936002)(4326008)(41300700001)(66556008)(54906003)(66946007)(76116006)(64756008)(66446008)(316002)(8676002)(110136005)(66476007)(55016003)(71200400001)(6506007)(7696005)(478600001)(26005)(9686003)(107886003)(83380400001)(66574015)(38100700002)(38070700009)(122000001)(82960400001)(33656002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3RBWGFiYyt5OTZxQzNZZW9wUm1TYnJvMTNEM09CU1pBQ092VEdNNTZCM05r?=
 =?utf-8?B?WmZJYnpZc0xiUkRubEVPUk82TEl1dHhDNWJhaVRTdXExUHZ3VWZBSGFZYUZo?=
 =?utf-8?B?VmJqN3prdERDcDRsVFZOSDlIS0d6SDRFMnlBcUZMaERDR3J6Nk45NDhjdGhC?=
 =?utf-8?B?MlhzTy9KV3hES3pMVlBQSzk2ci82YjE2bUNTSkZJd2NUVEYxTVNjYzJMNkVp?=
 =?utf-8?B?YmVUTC96V29Fem16cGNQcDMvWExsSG1hMlpSdlpRbnBZbjJXK1dFbXBtWW1B?=
 =?utf-8?B?cExvT1lLR09jZUZZdmxsZ3U1TzRQMXFxRjlBOTZRTWxCZ2tua1JrR3FEU2hN?=
 =?utf-8?B?Z2VvcldkNjlJK2gvMEo4aGdNZVRJYisxSjhFMVlFcDlHK29pbEVpdzVmZ0Er?=
 =?utf-8?B?S20wczFiNkl3Vit2WG9rdVBjUUxzT3hhN3dpZkpQUlZaZndRQXRSVlNLNytn?=
 =?utf-8?B?ZFpGcExuWUJLT0gxUEluRkNhN0VybkJtYTgxUnp0RjFja0xXOWFSZGR1c1ha?=
 =?utf-8?B?eXdsTW1LNmdNWS9VQjdSVzNSN3lNYWF1Y0U5YXV2VlZEc0t1Y2RwWnlYMmMr?=
 =?utf-8?B?cTNTd3Z0OUhkdHJzQWhxR2NHK1J1NzZZbmlJOVpyZGk1SHdzL2JxZGYrM21F?=
 =?utf-8?B?L0wxaUVxMjFQNEZrRlQvc1doaDAwMTFpeUNRb1h3UmIvbUV4eU8vZ2FOQ3FT?=
 =?utf-8?B?UldLdU8wVGwrdlRINGRza0RvcGF3WDZ1NW1DMjlzNUZuVlF5UXI1QURtMWp4?=
 =?utf-8?B?Z3Z1eXhDSnA2VFlTZkJLcXBxSmxEUllXemNEa2VoMzRrQnk2V0RBcHNqaFZX?=
 =?utf-8?B?N0ZYZElRblV2UXd0U1ptUE10WWxSZjZVaThoWkZ3L05pQ1I1aWNNRDZKMVIx?=
 =?utf-8?B?VGtlQzliTkhaN25hTC8wVVpQT0JjUkk4aGFuZ1ZuK1lkejV1VkpodFhqYWwy?=
 =?utf-8?B?aTQ5dWgyVmpnaGVneU04Rnk4ZmFqRGZMczFJcXlLK0JzdXo4ZTNNRERPMVJ1?=
 =?utf-8?B?NnhKYnpuUFZEa1NyYjlXNFFGRXB2em1jckJ4WHFsUFk0aFY2cEE2ZWFtTVJG?=
 =?utf-8?B?QkZNZEdmRXN1S21PMHh1TnRPWStNcHQvRE02WVpiaC9oUUtYSE9ZYXV4dUpO?=
 =?utf-8?B?bjFEVDk2NjJ6a0dUaUJWM1lLTjlCUmRlaER5ckIzQXdETisxZEVldDluTDNK?=
 =?utf-8?B?NkVNaUh3eHBlWGZSSXI5ZFpTTjZ6eWthbWhjakVvSUllVUd6MWpoNnFCM1pj?=
 =?utf-8?B?NTd3VkJFWmtOU3VqNDV6aWZBaEhRalV3YXBzVjF2ZlNVa0kzbHpwY1huSS9F?=
 =?utf-8?B?R0hSNTRnRTljNmFRMHNURU9rQy9VaDM1VXN6YngwOGVPN25HUzl1RDBrMWp0?=
 =?utf-8?B?azdkT0Q2K0kyU0p4NEYxVkVzOTBWRWZycHFCV29yQSs2V29TcVUwZkV2dVRk?=
 =?utf-8?B?KzUzVUpSVW9Ybm9JY1JRdDRJSmQzSjUvdHdhR0RCazZyeWdaMXhoalN2bHpY?=
 =?utf-8?B?M2YrSUFYT01pRTdEc1N6VzNOa1NEQVdKc0tJL0drOWFDNHBUTUV2eTJ6VjJp?=
 =?utf-8?B?VGRsMEhXdTRBTi9xcklCekIwd2c0ZkJPa3Y3ZnkyMk9CMzJHaXZhWFpUdTRz?=
 =?utf-8?B?QlEreGNmeTNpQUQyUTQvRElPKzFmb2ZDZ3BncGN2aURZQkZ0eGFkbkQvUHlK?=
 =?utf-8?B?OUhIanlWRXhEUzVYRHJTd1Q3Y3BkZ3dibHgzZG9XSzlNZFg4NTlSa0dQNFZ6?=
 =?utf-8?B?QU14Z1Rzc3VMVnN5MlhNTGdUVFpQRTlUcWJlbXkxK3hoVFlOR3NWNUd0RmxL?=
 =?utf-8?B?MlJNU0FKRjFUdWJSSzZjNEhpQUtrMlp0M0JGaVZmcGFqNWgzTTcvNm81bVQ0?=
 =?utf-8?B?YmhCU0VBVVE2eXRtaUJqMStRZTVVZFgxc2RoTWkrVkV1WHNmRklyZ0hIbXky?=
 =?utf-8?B?dzZHM1FjdDlmMUR0N3N6T2JKMVMrNktnakNwV0t6MzIxMGV5alNST3ZoeFRy?=
 =?utf-8?B?cW9UOEsvSlFwdnU5WHNSREI0NC9HdTFHN1dPWDNoZ3o0TE56cGd3cXFobC94?=
 =?utf-8?B?cThKbVpuN0VLa0FMRkJkTCs2bmxveVZmZWV3SmdXTjRUc2R0SEcwajdKbW9W?=
 =?utf-8?Q?RFYBXduiGtiTFpWDwvQDivmmz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbd6ddc-ad20-40de-c048-08dbeb0b9934
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 03:32:04.9996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVScKPIcHEV2atUQWD8eC/aOPBSsuJ+dNHlnT3eupUFrOmJqtmUUIBrpDZ005ql1793Qr95aJNPY+xdeRyo1BQV1SsGmuTgzRmSp0K5nWCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6758
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

SGkgUGhpbGlwcGUsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj5TZW50OiBXZWRuZXNkYXks
IE5vdmVtYmVyIDIyLCAyMDIzIDI6MzkgQU0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY3IDA4LzI3
XSB2ZmlvL3BjaTogSW50cm9kdWNlIGEgdmZpbyBwY2kgaG90IHJlc2V0IGludGVyZmFjZQ0KPg0K
PkhpIFpoZW56aG9uZywNCj4NCj5PbiAyMS8xMS8yMyAwOTo0NCwgWmhlbnpob25nIER1YW4gd3Jv
dGU6DQo+PiBMZWdhY3kgdmZpbyBwY2kgYW5kIGlvbW11ZmQgY2RldiBoYXZlIGRpZmZlcmVudCBw
cm9jZXNzIHRvIGhvdCByZXNldA0KPj4gdmZpbyBkZXZpY2UsIGV4cGFuZCBjdXJyZW50IGNvZGUg
dG8gYWJzdHJhY3Qgb3V0IHBjaV9ob3RfcmVzZXQgY2FsbGJhY2sNCj4+IGZvciBsZWdhY3kgdmZp
bywgdGhpcyBzYW1lIGludGVyZmFjZSB3aWxsIGFsc28gYmUgdXNlZCBieSBpb21tdWZkDQo+PiBj
ZGV2IHZmaW8gZGV2aWNlLg0KPj4NCj4+IFJlbmFtZSB2ZmlvX3BjaV9ob3RfcmVzZXQgdG8gdmZp
b19sZWdhY3lfcGNpX2hvdF9yZXNldCBhbmQgbW92ZSBpdA0KPj4gaW50byBjb250YWluZXIuYy4N
Cj4+DQo+PiB2ZmlvX3BjaV9bcHJlL3Bvc3RdX3Jlc2V0IGFuZCB2ZmlvX3BjaV9ob3N0X21hdGNo
IGFyZSBleHBvcnRlZCBzbw0KPj4gdGhleSBjb3VsZCBiZSBjYWxsZWQgaW4gbGVnYWN5IGFuZCBp
b21tdWZkIHBjaV9ob3RfcmVzZXQgY2FsbGJhY2suDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhv
bmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IEVyaWMg
QXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+IFRlc3RlZC1ieTogRXJpYyBBdWdlciA8
ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4gLS0tDQo+PiAgIGh3L3ZmaW8vcGNpLmggICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDMgKw0KPj4gICBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250
YWluZXItYmFzZS5oIHwgICAzICsNCj4+ICAgaHcvdmZpby9jb250YWluZXIuYyAgICAgICAgICAg
ICAgICAgICB8IDE3MCArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBody92ZmlvL3Bj
aS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTY4ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxODIgaW5zZXJ0aW9ucygrKSwgMTYyIGRlbGV0aW9u
cygtKQ0KPg0KPg0KPj4gQEAgLTI0ODUsMTY2ICsyNDg1LDEwIEBAIGludA0KPnZmaW9fcGNpX2dl
dF9wY2lfaG90X3Jlc2V0X2luZm8oVkZJT1BDSURldmljZSAqdmRldiwNCj4+DQo+PiAgIHN0YXRp
YyBpbnQgdmZpb19wY2lfaG90X3Jlc2V0KFZGSU9QQ0lEZXZpY2UgKnZkZXYsIGJvb2wgc2luZ2xl
KQ0KPj4gICB7DQo+DQo+PiArICAgIHJldHVybiBvcHMtPnBjaV9ob3RfcmVzZXQodmJhc2VkZXYs
IHNpbmdsZSk7DQo+DQo+QXQgdGhpcyBwb2ludCB2ZmlvX2lvbW11ZmRfb3BzLnBjaV9ob3RfcmVz
ZXQgaXMgTlVMTC4NCj5Xb3J0aCBjaGVja2luZyBmb3Igbm9uLU5VTEwgYmVmb3JlIGNhbGxpbmcu
DQoNClllcywgdmZpb19pb21tdWZkX29wcy5wY2lfaG90X3Jlc2V0IGlzIE5VTEwgaGVyZS4gQnV0
IHdlIGNvdWxkIG9ubHkgdXNlDQpJb21tdWZkIGJhY2tlbmQgYWZ0ZXI6DQoiW1BBVENIIHY3IDEw
LzI3XSB2ZmlvL3BjaTogQWxsb3cgdGhlIHNlbGVjdGlvbiBvZiBhIGdpdmVuIGlvbW11IGJhY2tl
bmQiDQoNCldpdGggIltQQVRDSCB2NyAwOS8yN10gdmZpby9pb21tdWZkOiBFbmFibGUgcGNpIGhv
dCByZXNldCB0aHJvdWdoIGlvbW11ZmQgY2RldiBpbnRlcmZhY2UiDQpzZXQgdmZpb19pb21tdWZk
X29wcy5wY2lfaG90X3Jlc2V0Lg0KDQpMb29rcyBub3QgYW4gaXNzdWUgZm9yIG1lLg0KDQpUaGFu
a3MNClpoZW56aG9uZw0K

