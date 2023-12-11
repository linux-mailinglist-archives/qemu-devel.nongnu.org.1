Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6176A80C16B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 07:35:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCZsJ-0006Xi-Mg; Mon, 11 Dec 2023 01:34:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZsB-0006VS-BF
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:34:36 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZs9-0004wG-N0
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702276474; x=1733812474;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Q8bBXSmSYVwyw4Xn8X9vMujWgmcH/F/0UQhNBv0CyC8=;
 b=N0T9tb0s5ctklgiVm1Q9JuHbMLbxmcAUGHcmY/B4PuCydRKiXn6B3ZiK
 pfe7kisUEgaknGre/IpGOZnUEnqBWxB3dVPY9K6eXUXH4YmPSMJwLcyQJ
 LJbFnXkx5YIkVuf17l1lSWVsTCmOHbkZMYr+Jxp3gAShqB+TD2J8nIjeV
 2Hddi+sdm3xszooDNuAktewFMPEheGMh6XJiIov2IgWfV+lggdTmeXBet
 LEbFoRXUKai9j0fky2O3V8rXqYNWjFGLiDvmi4VZnvDhVnEWBSKw9plcn
 enr4pq1uKi1CpLWqlSvhra4cifcIfgqW/YXZZ9IJuJ0bPk99sfmBA7LqZ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1438568"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1438568"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2023 22:34:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="807181555"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; d="scan'208";a="807181555"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Dec 2023 22:34:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 22:34:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 22:34:31 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 22:34:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axZviGJ1pHF+PZigJ2ZCBL3sDfnjlzpAekexbGg1KBW9DYwDnFO23Snx9BMlFkBGC50TT000S9ZWo2YcXAKjQiMHxPP5nYmWaGOxl1qLwuSV+hg1f4f76FQiJKei399ihTDDrRM57OPedoqdPHrdijH9KBmriCOk6fNE76vXSHRxNqbFG+z+aHX57MjNTWZC0+aZEpBkppr/fWLUfMc+yxfXukosoCHYF0I7Fopv8LwsG3+6hcT4WER9IKIwINwfMm9BHBFIrp2Qo9pfJ8npvwMiDjV1E0n8PdI4MCUlpWgA9njU5cqkIeuqVG1vRU2S7uKNTjRoFbH1bKs+ycNuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8bBXSmSYVwyw4Xn8X9vMujWgmcH/F/0UQhNBv0CyC8=;
 b=Dsu0eXVLZ/x64sB/be9viTvUGGWz7FAvgS32gUrt4pDGfcF5MtUTlEQve7hMEOQbdBmyRhrxfFmpEmX739H2CBb6vT0lVPkD83qrFCSSSbptb0fnOVWHCvgUqNSKWpjCVz1uImYS3GWGnwxYbJX8O+7b4ZmCr3Yf/jyW3OZisXv+0qrNyQQ5MWdKNyuCfztQ08cvGA0JifSHy3gTV10ktZeS1d9+vXDkNWUAxJnQMpUGCKxJTCV1jPWon4lI7Y/fbs4hBRo3YpjMQngiqpNZ4VVzdHj8KYPMf8bqIvgnLlfXezVeEmEL1AwCpGK236d5/5zqID1tRrqXknt/IaeeTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB7372.namprd11.prod.outlook.com (2603:10b6:610:145::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 06:34:28 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 06:34:28 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>
Subject: RE: [PATCH for-9.0 09/10] vfio/spapr: Only compile sPAPR IOMMU
 support when needed
Thread-Topic: [PATCH for-9.0 09/10] vfio/spapr: Only compile sPAPR IOMMU
 support when needed
Thread-Index: AQHaKbMvCyylyePhp0eg3165VzYUNrCjpGkg
Date: Mon, 11 Dec 2023 06:34:28 +0000
Message-ID: <SJ0PR11MB6744671E461D10C6632ECFEE928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231208084600.858964-1-clg@redhat.com>
 <20231208084600.858964-10-clg@redhat.com>
In-Reply-To: <20231208084600.858964-10-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB7372:EE_
x-ms-office365-filtering-correlation-id: 508d0453-b5a7-4a93-4368-08dbfa133a0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30r3bXv+bu8kdXK6gy82BSgReDzcQzmYxL+Fj8n5BWrQBBBPEuv+K3YBe5ameYqantwEvUV7PSnOmubjfX2xwJvulqtKg6M33yyHokYHHIHdQr9yuwms3cnLcopJBGMK2grzWu6et0y/fCgHG3klegzqqXP26e+3MSiRt+rzKUzpEiTXZMI5EdWnGbXm774JNgr2UzTes8oUFbpddVbevW4zsL3n0Im023/OpV2pLJGFJzO1eaX6VoupoBf3XEwikuaJmcWvlgp39N0ooB6Qd4EwMVI+CcrvEHYGpp3PjP5FROj6OGTitliocemNfgx8BF1a0E31JAnxB8OIv9knVNw46XdCO9JdMSHJcSo+rcksKWv7MlBNNdr8zB40DoDDW2lhUmPFpN7s1mGAHAhhhdH1pF0iXee4JhNBnF/EKjPRl0Py+swuL3Y2D0hb3VzxjW9IOjTlpN8Qu/pNNwH8hZ3ORZehQ3h/fsJPbG6aDOumyuR5LImtm2vQ69ctY9RxKI684S1NBo1su7zTzcMuvcQML4PcVdMM8yOrdEMupc9AEydbeLroCufzKlHbMJEvNKlCPdK8k/87JchY+26COHt4Os5UzNDJerSxk783aj6UbHtapMdvIX/IygTHjius
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(9686003)(52536014)(6506007)(5660300002)(26005)(33656002)(55016003)(38070700009)(66946007)(4744005)(76116006)(54906003)(66446008)(66476007)(66556008)(64756008)(66574015)(2906002)(83380400001)(82960400001)(41300700001)(478600001)(7696005)(86362001)(8676002)(8936002)(4326008)(122000001)(110136005)(316002)(38100700002)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmtESWVXNGlLRS9UV1dJd0ZSOC8vWmR4VWx2c1VZeHVMUWpHWUsyZTJUcGNz?=
 =?utf-8?B?dnJBdzBLSmVabm96TkM5eE4ydjFIVGJ4SXkyeHcvZ2VOaFZiR0NnSHZRS04y?=
 =?utf-8?B?Q1lrb3RPdnZIZnRCVFU5bGEwSWVjWnlFK2VUc09kaVB6UllNMTdSdWZCNmY3?=
 =?utf-8?B?elpGMGtIL0h3dEdWUkhnV1JRckUyN1pjb01oNHlPdERwTDNkaW9IOXlpc0lP?=
 =?utf-8?B?clRPNTZucGI4RjBwdTJEaXhYTnp5SHQvS3NpS0hxcEVMd0JmcmVMQmo2WG81?=
 =?utf-8?B?akhRRS9Vb09RUEpMT3RmU2NBb0N1aXFMdHdxeWRFY1dDZUNXU3pBR3VIM0pN?=
 =?utf-8?B?M3lnU1dWM1EwSDB6MDh5MTBkamo3aGs3UFlhR0JNWGpUeWV1UlF5eE0yMEJQ?=
 =?utf-8?B?UUdWZThDaGIwdGIrOTJCd2dzUEdDWEJHUVNENmN5cFNDZFY2d2lJejVEaVhr?=
 =?utf-8?B?YmNnR1JKdVpKRnRCN0d3YzNoS1RRam4ydmZoSVAzdUNVblhWMlhKU3VXWXBW?=
 =?utf-8?B?MWlMWmpOUEs0bmJuZmMveWJhazcvWER2WEo4UUxxN3VLUDA0MUFiaEtteVpC?=
 =?utf-8?B?akpnempKV0NWTnc3SHNXeEhyRlNNeDRaMzU5cUcwZmlLZjQxT3ZtNXdTM0V0?=
 =?utf-8?B?a2JsYnAxbFZBdWtxQTA0aXZoWXVLRmpQMXlrWGgrdGVBQ0QvUFY2Rkl5NERw?=
 =?utf-8?B?eGdrNUZueW85bXdHOUhIRWdZcUJDWTZTWitKQnVPdGRqZWU1R25zVGdIb3Nm?=
 =?utf-8?B?cEM1U2pndTQyQ1ZxTjlObXZkNm12ckh2RUlHRDhES1hCZzBKQTJ6N3EvUmJX?=
 =?utf-8?B?elc1Z2ZFYVhBUDBrdzdmNUR6Q09hR3hwdE9mUk5BNjRVVUR6RGlKTC80R296?=
 =?utf-8?B?VjV1Y0V2TkVwK3FTbmx6ejVUMm44a1FQWXlvSk5hR2RWVWV0UUg1U1VwdTFp?=
 =?utf-8?B?Y2plaG0xbDRHZVhDUUdxTVAyZENzVWs3NlUrNlNLZmxPMUVhMjcvcHFyN3Uw?=
 =?utf-8?B?cVliUzhVUmh6dHMwcVZZdTE4QmpjNTRFaUUrMzlyOWtiVkhkcGpSTWkxYUx2?=
 =?utf-8?B?cnRNaGNsaWNCQ2o2Y1dwM0kycmlKb2poNHdseDBLZjd0ZG1DUCtObnNjeUZI?=
 =?utf-8?B?dlNBa0ZVc00xWXdlRmxNY2NqTVRMUEh4V3RwbWh4QmpHTVlwNjJkWXMxUFlK?=
 =?utf-8?B?L2xaRGptaWNUa2Z4cC92U1RmT2JrSXR3eEQ2Wit4N0VEanJGSmVtQ3FmZ2Jj?=
 =?utf-8?B?eERrNmVUdHZQdHdSU3BrV05vcFNNMzFwL2VRdTFtU2xzYW1PeVM3YTlXTytW?=
 =?utf-8?B?UEF1YUtFOGgxaHc2cWVUa3RqU0tHSDExMFVVNzhpS1JMMXVJVFVwWU02VWNP?=
 =?utf-8?B?YlRtdjdYRUxFTWV1ejJyYXlQR1h0b2lYVUlUUnJxckIrU01zNEFVWGNLYWtN?=
 =?utf-8?B?RU4ySUZGc2xXUVVoUEdHRFdHSUhZajlYV1ZYcGxQTFIzNHB2Nkc3RFhMZUZL?=
 =?utf-8?B?a0R1azllMzdRbnhXR0U5cnduZ1FuZkRySnVZSFFoNHFnb3E0SW4rdWNlRmcv?=
 =?utf-8?B?WGZONnR1QlVDYXdEUkNyU3dlK1RiejRFdk1PR1d3RUJZdm9NK0ZVU0ZUVnhl?=
 =?utf-8?B?S2VtMzJETHVDVzk1Q0p5TVlTMFFkK1NkQlZYK1FXV2VtTXIrT0RCVUszZE8z?=
 =?utf-8?B?VFdhOUxGRjdhbnhaNld5ZktSdU8wVlpMaGd4Y3lUZlV4L3pVNzZoaGlVM01M?=
 =?utf-8?B?bnBsU2w2N0RpZmV3RHMwT09tWmsyc0FqUGhQNUFMbGlJR2I1UVA4emU2M0di?=
 =?utf-8?B?WjVpMmtWUkdZUHloQzdyVWxKMCtZZysxSmVjckM4TUR6VFFDUXJPamNOa1dH?=
 =?utf-8?B?ZlRwSU5Ya1gySDc0VGZWdnZLUXFlK0F1WVphQzNMd1dvTTJKV2RzeFZrZFFR?=
 =?utf-8?B?aHlrWlplN1BZeTVmQmZ6a0EyYXJrZC9MOXkyRFgySXp1cFhrckI3QUh3cVla?=
 =?utf-8?B?eU1XaTE1ZjF1M0tCeUlWWENKN1Vhb3NzbEozMlN0b1F3VHpwL0o1LzVudUxD?=
 =?utf-8?B?UUl5M3VsSml5bDFXYnBscUpORlFDbmpKa250cUo0Sm9IVCsvNkNuMDNaWjRE?=
 =?utf-8?Q?uLJBFoenCZWeEPVU4fRc1yliD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508d0453-b5a7-4a93-4368-08dbfa133a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 06:34:28.8164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEj20WfUNg52PTswFXJgznUbX33P4alVTP2mgpf7LViK65qp4p1gI/VmIv7m2oWYuiKschntdaO367DJHkmyjenD1v7cPiuLjs70+doJ/W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7372
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
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
TQ0KPlN1YmplY3Q6IFtQQVRDSCBmb3ItOS4wIDA5LzEwXSB2ZmlvL3NwYXByOiBPbmx5IGNvbXBp
bGUgc1BBUFIgSU9NTVUNCj5zdXBwb3J0IHdoZW4gbmVlZGVkDQo+DQo+c1BBUFIgSU9NTVUgc3Vw
cG9ydCBpcyBvbmx5IG5lZWRlZCBmb3IgcHNlcmllcyBtYWNoaW5lcy4gQ29tcGlsZSBvdXQNCj5z
dXBwb3J0IHdoZW4gQ09ORklHX1BTRVJJRVMgaXMgbm90IHNldC4gVGhpcyBzYXZlcyB+N0sgb2Yg
dGV4dC4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5j
b20+DQoNClJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+LS0tDQo+IGh3L3ZmaW8vbWVzb24uYnVpbGQg
fCAyICstDQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
Pg0KPmRpZmYgLS1naXQgYS9ody92ZmlvL21lc29uLmJ1aWxkIGIvaHcvdmZpby9tZXNvbi5idWls
ZA0KPmluZGV4DQo+ZTVkOThiNmFkYzIyMzA2MWY2YjBjM2UxYTdkYjNiYTkzZDRlZWYxNi4uYmI5
ODQ5M2I1M2U4NThjNTMxODFlDQo+MjI0ZjljYjQ2ODkyODM4YThiZSAxMDA2NDQNCj4tLS0gYS9o
dy92ZmlvL21lc29uLmJ1aWxkDQo+KysrIGIvaHcvdmZpby9tZXNvbi5idWlsZA0KPkBAIC00LDkg
KzQsOSBAQCB2ZmlvX3NzLmFkZChmaWxlcygNCj4gICAnY29tbW9uLmMnLA0KPiAgICdjb250YWlu
ZXItYmFzZS5jJywNCj4gICAnY29udGFpbmVyLmMnLA0KPi0gICdzcGFwci5jJywNCj4gICAnbWln
cmF0aW9uLmMnLA0KPiApKQ0KPit2ZmlvX3NzLmFkZCh3aGVuOiAnQ09ORklHX1BTRVJJRVMnLCBp
Zl90cnVlOiBmaWxlcygnc3BhcHIuYycpKQ0KPiB2ZmlvX3NzLmFkZCh3aGVuOiAnQ09ORklHX0lP
TU1VRkQnLCBpZl90cnVlOiBmaWxlcygNCj4gICAnaW9tbXVmZC5jJywNCj4gKSkNCj4tLQ0KPjIu
NDMuMA0KDQo=

