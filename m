Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6625E7A9126
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 05:09:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjA3h-0008LE-4Z; Wed, 20 Sep 2023 23:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjA3f-0008L3-3S
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 23:08:51 -0400
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjA3d-0000qD-0T
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 23:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695265729; x=1726801729;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+hdf8r1+uAk3PeNrdAmCbU4pKcvCvQ1W6HhfAfH+Y+4=;
 b=PzbtJ9dwSOHGLoYt8zQJLB1siWNqA5fvrcNlc2mbhHYY8GiRCtO+PzJB
 3jEgKnTyS+gyd2R0KEXIowrx7E+PSkSEVUNKdz3n5aoRTGWMj5AjQOLk7
 DjZUr/OieCu9qGO62wTNJhDTAmU0HxAEvbXE0Qn1hU67iEL51Kuv91Imo
 t2ihyUOqWo+fLAjz8Vlt+w9sMpLdKoEHdU6sEvi8ku3SHGIcK2y7SQP84
 jZm+x7CLF6Xi6fnGyUGlNfgZ3zlpn3sUiaxR/JLE/O3YXc8TYbSlO3n5r
 Ra8x5vRADtopbYa0Bx7nqwC2By927OWWy80i7X3c+/EREVZ7Bl11XTQRj A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="370720218"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="370720218"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 20:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723572856"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="723572856"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 20:08:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 20:08:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 20:08:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 20:08:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSAIm4HdCnD43XTHbzvUXadOBDGlAWBMgugHGcChs4EnHNP2qBaGBJuJcC+f+GSJgTsW+NUkviuTZ0Q45GzcoWPZOIRa1USLfuYHib3KKXWeLKxtrYxhvMxVgTpTJGEap5lBBmwE5o3c8v7kB8SAXUzFsRSggFgYy3mfqmzTnQzhMg321A1hzPiRlO0i6aS4uP2UCKJimXmHNUHHh/vNo3xF0OA1HUVayIVAl73zRNWU0tc+gYzGBI6Mv107rMfrat6EymfGvgRysEYB4MUL86B9ZlOq1Tbg9ATLFjvHU8u6GatyVlR+obiF/zAQRy5m5rU6ZeqIqI1NnYgxe/+4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hdf8r1+uAk3PeNrdAmCbU4pKcvCvQ1W6HhfAfH+Y+4=;
 b=WtQwN3PrcwPBdaohLf8Nve1UEvb79ISyZPR6UHVzaR6n56VAXYe3Bx5KJ/S+3xjoThiZeNKKNcxTQ+UF5ACNLbV0bX+pBeMBDaD2S2juXYoVdNXF2dwN248fwbYbVb7VxOcdJyvVXGFNGtSXCmQiS9N2nBSuxHpDyhZFRnM+LlQxU99tjAN29p4TJgdwINflDMcDe/lUNme1AxgZE8W1z2f5icj2krsjUXqZI5Eyob+TZ7NC2V1yCAl1SF+1E9z6rtInKCV/K5vnpdfguqijWwDte46+8JuobM3Hshe2A6epmQwJfTZ4Sb1kv/iDesJvFJxAJh0KW/3Bjbdz4eD6bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB8188.namprd11.prod.outlook.com (2603:10b6:610:15e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 21 Sep
 2023 03:08:26 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 03:08:26 +0000
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
Subject: RE: [PATCH v1 09/22] vfio/container: Introduce
 vfio_[attach/detach]_device
Thread-Topic: [PATCH v1 09/22] vfio/container: Introduce
 vfio_[attach/detach]_device
Thread-Index: AQHZ2zAt41ZDXvCO40WspZxldOFEyrAj15sAgADiYMA=
Date: Thu, 21 Sep 2023 03:08:26 +0000
Message-ID: <SJ0PR11MB6744198167604BCA7690B74B92F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-10-zhenzhong.duan@intel.com>
 <87da12f7-eaf4-e095-9282-e99d6ad12bc4@redhat.com>
In-Reply-To: <87da12f7-eaf4-e095-9282-e99d6ad12bc4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB8188:EE_
x-ms-office365-filtering-correlation-id: 0b6a6f00-4bee-4eda-c35e-08dbba5005e8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8UkwtGaGYcU7UEff8yhR08s4Dt9OIGXxHHDHFvFQTLNkOk3SH4gRRbo8e3G7SOTIz2uebgQiAg5m2EiNK2+8qbK+fnL1OEHrFopRBF8xLWdGSOLl5fu4ksk+yhytYyHiU7Tu4+DSDYBWmbxMC5EOAOBkVTWjdlycZzyVjTkTt7EzBD19gpbkfxgq7g7qzubWlLOpZAyt8kHCY5QPi/oyCgiWVqEC7bUuoxuLI/w3UfR0t3KRMagsvfQfHe2yVnZyUAguj6pVbaA93uWGkwKJfu5Rcej32dH9NPDr3Yxw6J+D4+9vmuJwWilnMTEM1Rc5x5365oS4q+3Nmsclki32olfB3F9yIAXKdlUielsIqVV/QS6veTeAMQunHXKnabIHFTLg5CKdp5Aoc9jC97Y0rrrMCHupsY+dzX4Qd3C1aPlMUWP/IB/b+xdMJvWypKzcvuacvfEcBuoH4eAT1xmz24TadF2TSTSdao1JSFK5pCrCesAeiCFkC0Gz4XbJjT8yMRvrEMgrh5PD1bptcEhlC9Fyn3gar4wXqbUCzXQrPlklgARJ5rQ11V8w0vDVuXp6V9QxBuDQon8IHbzZ2VbkkH/LHq7DQ0MyBQBXp/q4yA+v6GG+flaMM6c4zlOy8uDC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199024)(1800799009)(186009)(26005)(107886003)(83380400001)(55016003)(54906003)(66556008)(66446008)(110136005)(4326008)(38100700002)(66946007)(8676002)(8936002)(41300700001)(2906002)(66476007)(38070700005)(33656002)(52536014)(86362001)(478600001)(316002)(64756008)(7696005)(5660300002)(76116006)(9686003)(71200400001)(6506007)(82960400001)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGpseG9tb21Eakt5U2VjeUkrZE1uSUx0UzljdTE1cURpSlN1RGpBUk9TaUs5?=
 =?utf-8?B?djM5dUwrWlpLSUtydXJiaFZFM21qZVdxVzhMMlV4YlNJcHJud2pYbUpsWG0y?=
 =?utf-8?B?djE5SmprYkpoSXZJcWR3U1UxL0RkTUZmSXZmR0RUdCtidWlnNklXZ0pFMjI1?=
 =?utf-8?B?dFo5aTFmYmNlOTk2bTVEdHF4L2NCak9meDJrM2hSZHQzYmlnV09ZOGl6MEFB?=
 =?utf-8?B?NU5KQ0RwN2NiNHppOUFNY3Q5WnF3aUhXTnArdVprMWZZUzZOb2R2bXpUVS9h?=
 =?utf-8?B?SlZYczNrcy82eTdHdGo0YVJ1aTJuOS9Lay91N1NrcGFQVTFLREg2M3dibkFS?=
 =?utf-8?B?NXcwc0FGam84OGxHdVhVTTlnUXk2QlBsY05wNnVER045STlKM2dsSU1rcWsv?=
 =?utf-8?B?NTA2OCtYSmhzVm5DbHkyb0JMazBPVUdjNFNxZ0djWnpMWkNOWTRLQng2TFFL?=
 =?utf-8?B?TFlMOHlYSElvQ3RLWUcrYTlxNWFJMHROeElNUGpDbmsxdVFOM3hsMk52OEgw?=
 =?utf-8?B?UFd1UVNLODlZRTBkYXIzZWlZSzZhTkZ4YTlCZG9LVWtuckt6TGRTZ1J4Nkg4?=
 =?utf-8?B?NUhYWTJsM0dlYnd4UkRCRUJ4WEpSWE9ZTjdFaTdhbjJLVzcxdU1ldUkwTFBM?=
 =?utf-8?B?MHgvRmVSaG91MWZCT0N1MXBIbU11NVhJTnUyOXBWc0x2K0JUVFUvNTkyZ1or?=
 =?utf-8?B?emZSWHFxVGRDK1NuajJrTXlqR1V1WG90Y3ZnMndkZnk0NGJDelVRUjFwVm9F?=
 =?utf-8?B?ZVZHY2ZMZEYzSHFoNzBSSmt5ZGJoUXBBV2llcEpOWWZHZjFFSlFPbmNEdnhK?=
 =?utf-8?B?U1F6VjRZRnBaa3RvdDhGTkRTVDZ1WGxrUTlBZUZQb011SVBlUFlzNWc4SmNC?=
 =?utf-8?B?aGdZZFZ5VnhuOTNxRFg0NjFiMTVqN08rSEdCWVdtTnBtcUtoWXJQYnQ0Uis5?=
 =?utf-8?B?UjNHaHFPS2JhT01GaHZNZzZCdlNES21DK1B1TnBKcVJmTldpOEhUbHhMVGRJ?=
 =?utf-8?B?eklBR3lvbXVIc0hoMVhmRnRJeWZJakQ1ZmRZbUw5cWxMektvaDIxeFNEcGdW?=
 =?utf-8?B?ZllOR2JNYVVBdTdtK2lCZmJhTUx2aVovdlQ0aW1TZVd5QnVvd2lVWk9ocjh0?=
 =?utf-8?B?QzFWQ1B1VzJCejRoQ1JqRTBjYU4wUnZKZVgwL1ZPQktCdzg0dmVxR2I5WVBo?=
 =?utf-8?B?dUwyYlVoT3Y5aFlnanNyU1l2T04vOEhFYUlHY2dVQW50TW9xZ0wrclFEaXVU?=
 =?utf-8?B?OVJaTWk2SnFxWGJwLzJGaWNYeTVtVkQ5UlMzT3RSV2pkTXhMQ0dESzF1NmlQ?=
 =?utf-8?B?TmhRTk8velVsd2xrUEVQaXROdjd4eWlPM2cxZzdPUldaNXBDRU5rYy9xb3hj?=
 =?utf-8?B?c3Q4WTA1ZWlUOStXS0hqYlJkSHV4M3doVlFlU1VhaWFCYjR4eTA2RWZmQS9m?=
 =?utf-8?B?L2VSckdVdklLRDJHd2hmcmE4YVhTQURWV3FacnZZRlEwNTVEZ1d3SmRtODd0?=
 =?utf-8?B?M1J2OTRNQkdoaVAyT2dEVlFzYkQ1d2NSNnZsTG9sbm1JdFRSN2ZVakJQVVY2?=
 =?utf-8?B?R05XQlBvckJ0TmpZTVRNSnBPdHFxc0V6OW9HeE5TUDcyK1UwZkZXOE02Y2Ji?=
 =?utf-8?B?bTFQWlFUdkJ5b2hSSC9GcW5LenhrRElqYUdiV3lLL21CYnZLNWpIZFVLbHdK?=
 =?utf-8?B?TmtDT1Y4U1RuWTFqZG95S1pNKzJ2eFJVZFpydStncnN3anVhWHpESG5wT0Zl?=
 =?utf-8?B?N1orYTN5YTVWbzh3aXE3elBYVzNkTHVvVEc4bUIvcUFLbE5ESTJuZ2p5RFVt?=
 =?utf-8?B?Wko4NmtSWTFkRnNPK3dqcER5bWQzR3hjYjZiZjNKdVNmTGcxUXdyRHZPQkps?=
 =?utf-8?B?aEtIREFwblNBV1FLZldramlSbzFYNm81RlZCbUlNYkl4cEU5Q0xrY1lBTitr?=
 =?utf-8?B?ZjFBRUo0Z0VSSnR3YW1lemNDa2pBNFltM2R1eUJ3cTBDRzMvK2dYVU1PZFBO?=
 =?utf-8?B?L0xQV0lCMWhzT3JiSXNqR2tSZkhKQ1ZtYkJjUFF6L3IwMm9nTDltNmRnNEhC?=
 =?utf-8?B?bythYkp6WHB4TllJbUE4c2g2TkF5SC9zaGVZa2lkWm9HYUIyWTlwRUhKemZZ?=
 =?utf-8?B?OHVNZlVyck9sSWd4WUJhWGNPTlU5TG9xWmdVVkQ1ZWxXRlh1d1d2djJhd0FM?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6a6f00-4bee-4eda-c35e-08dbba5005e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 03:08:26.2142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXQptKjsE/fL6BEd+PCJS2V8fRb9mYKtO4YFONsAzgysD4WY8U/pKuEpT6YUsTK2BXmJzUxYZ3TiZjQAjCRvv4rvIJmwVgX/H5dQZLn9w6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8188
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyA5
OjMzIFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAwOS8yMl0gdmZpby9jb250YWluZXI6IElu
dHJvZHVjZQ0KPnZmaW9fW2F0dGFjaC9kZXRhY2hdX2RldmljZQ0KPg0KPkhpIFpoZW56aG9uZywN
Cj4NCj5JbiB0aGUgY29tbWl0IHRpdGxlIEkgd291bGQgcmVwbGFjZSB2ZmlvL2NvbnRhaW5lciBi
eSB2ZmlvL3BjaSB0byBtYXRjaA0KPm5leHQgcGF0Y2hlcw0KDQpNYWtlIHNlbnNlLCB3aWxsIGRv
Lg0KDQo+DQo+T24gOC8zMC8yMyAxMjozNywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBGcm9t
OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pg0KPj4gV2Ugd2FudCB0aGUg
VkZJTyBkZXZpY2VzIHRvIGJlIGFibGUgdG8gdXNlIHR3byBkaWZmZXJlbnQNCj4+IElPTU1VIGNh
bGxiYWNrcywgdGhlIGxlZ2FjeSBWRklPIG9uZSBhbmQgdGhlIG5ldyBpb21tdWZkIG9uZS4NCj5z
L2NhbGxiYWNrcy9iYWNrZW5kcw0KPj4NCj4+IEludHJvZHVjZSB2ZmlvX1thdHRhY2gvZGV0YWNo
XV9kZXZpY2Ugd2hpY2ggYWltIGF0IGhpZGluZyB0aGUNCj4+IHVuZGVybHlpbmcgSU9NTVUgYmFj
a2VuZCAoSU9DVExzLCBkYXRhdHlwZXMsIC4uLikuDQo+DQouLi4uLi4NCg0KPj4gZGlmZiAtLWdp
dCBhL2h3L3ZmaW8vdHJhY2UtZXZlbnRzIGIvaHcvdmZpby90cmFjZS1ldmVudHMNCj4+IGluZGV4
IGVlNzUwOWU2OGUuLjgwMTZkOWYwZDIgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL3RyYWNlLWV2
ZW50cw0KPj4gKysrIGIvaHcvdmZpby90cmFjZS1ldmVudHMNCj4+IEBAIC0zNyw3ICszNyw3IEBA
IHZmaW9fcGNpX2hvdF9yZXNldF9kZXBfZGV2aWNlcyhpbnQgZG9tYWluLCBpbnQgYnVzLCBpbnQN
Cj5zbG90LCBpbnQgZnVuY3Rpb24sIGludA0KPj4gIHZmaW9fcGNpX2hvdF9yZXNldF9yZXN1bHQo
Y29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqcmVzdWx0KSAiJXMgaG90DQo+cmVzZXQ6ICVz
Ig0KPj4gIHZmaW9fcG9wdWxhdGVfZGV2aWNlX2NvbmZpZyhjb25zdCBjaGFyICpuYW1lLCB1bnNp
Z25lZCBsb25nIHNpemUsIHVuc2lnbmVkDQo+bG9uZyBvZmZzZXQsIHVuc2lnbmVkIGxvbmcgZmxh
Z3MpICJEZXZpY2UgJXMgY29uZmlnOlxuICBzaXplOiAweCVseCwgb2Zmc2V0OiAweCVseCwNCj5m
bGFnczogMHglbHgiDQo+PiAgdmZpb19wb3B1bGF0ZV9kZXZpY2VfZ2V0X2lycV9pbmZvX2ZhaWx1
cmUoY29uc3QgY2hhciAqZXJyc3RyKQ0KPiJWRklPX0RFVklDRV9HRVRfSVJRX0lORk8gZmFpbHVy
ZTogJXMiDQo+PiAtdmZpb19yZWFsaXplKGNvbnN0IGNoYXIgKm5hbWUsIGludCBncm91cF9pZCkg
IiAoJXMpIGdyb3VwICVkIg0KPj4gK3ZmaW9fcmVhbGl6ZShjb25zdCBjaGFyICpuYW1lKSAiICgl
cykiDQo+SSBhbSBub3Qgc3VyZSB0aGlzIHRyYWNlIHBvaW50IGlzIHVzZWZ1bCBhbnltb3JlLCB3
aXRob3V0IHRoZSBpZC4gU29tZQ0KPnRyYWNlcG9pbnRzIHNoYWxsIGJlIEJFIHNwZWNpZmljIHRv
IGtlZXAgdGhlaXIgdXNlZnVsbmVzcyBhbmQgc2hvdWxkIGJlDQo+Y2FsbGVkIGZyb20gY29udGFp
bmVyLmMvaW9tbXVmZC5jIGluc3RlYWQgb2YgaW4gdGhlIGdlbmVyaWMgZnVuY3Rpb24uDQoNClBy
ZXZpb3VzbHkgSSB1c2UgdGhpcyB0cmFjZSBldmVudCBqdXN0IHRvIGhpbnQgdmZpbyByZWFsaXpl
IHN0YXJ0aW5nLg0KSSBhZ3JlZSB3aXRoIHlvdSB0aGF0IGJlaW5nIEJFIHNwZWNpZmljIGNvdWxk
IHNob3cgbW9yZSB1c2VmdWwgaW5mb3JtYXRpb24uDQpJJ2xsIGZpeCBpdCBpbiB2Mi4NCg0KVGhh
bmtzDQpaaGVuemhvbmcNCg0K

