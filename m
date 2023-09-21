Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E357A931C
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 11:32:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjG1o-0007gX-Ux; Thu, 21 Sep 2023 05:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjG1l-0007f8-4u
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:31:18 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjG1i-0004Qf-Ob
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695288674; x=1726824674;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=L5G5/+Fpu+dEjPvNp8pYiyn5g8TiTeUyzdfavirPASE=;
 b=T34RDQoorizZEH46lLdhsH1eDDZGzAwXGYq8I+AW7LvfIBSoiGfUAvco
 diBBz0x9p+mT32q7m+GLWzEp3TFYdbEru76QLsSe04sswSO0uRheCaF+A
 WELHdYg6wEgWtyv78+LKwnRLVZduDqnEen6z0cRNeV4yeXU38Q9TFMtTP
 2klNQb3WNjL1kB9kFk3wQp1TzOcFEU9+iEkHQYlV4lR78yDq6pD6e7BrM
 aPp1j20z4nB1Dsis5nLVsJv2vxJ6ejF9+t+KfJlJsiaXeWVgazte0xwtv
 DV+kpjDTuZzehdvj8MNxC662pnBKFJNbPKo7og0Sovw2HMYwiGQCEjiGb A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="7166984"
X-IronPort-AV: E=Sophos;i="6.03,165,1694703600"; 
   d="scan'208";a="7166984"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 18:31:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbhN/HLDAI5RCB8sCCXz9hGzL0ASRSaTqCQ9SGh48/AzcvwGuvCQ8ijeuAJyvJrLAj9//lie5+S7FHn5V0KPA4gpYBa53pU7hREH+LOMhrpH0Ii/WP4pWsMdiXGLxteZZUhUnPm/oODgxaSrK/l8IYusaMS49UhJtf4vTFw3EQG3nGZhn+dcEyiaU87FPxOL7n7/dJ8SL2FWsY5GoaS+Mv0eaJChlTPkQyvwyzMlfhpJgozeC2ShgTgVYqH/anMvJl7zBREJwdqwkRwAaXjoykrti9MhO2xJ+/09/GEwDWSY/A69s46lgjLTRvpPR54RJWJ5OBGpXa2g0ezmBVT1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5G5/+Fpu+dEjPvNp8pYiyn5g8TiTeUyzdfavirPASE=;
 b=JZG/XfxMM06RXekxEpNnwAr6sRye43tq7Zw9lmyUqM7Vj+LjYmK2oX3ncUy2qj+Xmi7j9NPqj1a1lFDHN1MYv8Ku5Ln8mYECzcPVtYMlItMrcyfUT6Z9Wgfiufs6KNFhAm2vrKIDp0x888a7QSmQcga0yPnG1350kyrzxLMFT4hg9RBnvUBrCRv8gzm8fGnkOy5onozsi3/CfrpJBaVICcBq+lbZ5n/QX+fy5scMbIpINQhii7SXQ8J5Rl1Gdjx4501cnH7RWnTlioxVaptszYlk0BLvaEch6PbtfmCjrGXAvm+f2Fe9S81/JPcjvWvInfyIeDPlH10c0AqIcr81BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB11785.jpnprd01.prod.outlook.com (2603:1096:400:3e0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 09:31:06 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 09:31:06 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 10/52] migration/rdma: Eliminate error_propagate()
Thread-Topic: [PATCH 10/52] migration/rdma: Eliminate error_propagate()
Thread-Index: AQHZ6j8+6W+lW2ql0ke/hxJlC3AyN7AlCC+A
Date: Thu, 21 Sep 2023 09:31:06 +0000
Message-ID: <3306b110-58a1-6a28-3fb6-d866c3b2b44a@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-11-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-11-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB11785:EE_
x-ms-office365-filtering-correlation-id: 906c7c08-feca-4499-4ced-08dbba857b60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pFgjmhdKzo6kICyzuw9eiLC4m/tbYDOSqNNIpn/KKbELuFYAuv8RHPKqec/IrOUakoYc8LXJVinTMJAFVjS/tWTZ/E4icC45ptNKmldhAHnPoY7/ND15EZ9rl2C3R9M7VsrftbTcpKkLRlmBrETXgPp0RCIJ2YB9Vs1n5Hmxf4ijNE6oQT4Elh8yl/P9KWTvXh0z0eoHdqR73YG0Cf26+awuLAr1/zghJMVSb8ykb5qOpRZZxSSRMle3RT1QijXZ21fL3wNKRxNUEQlKG9eVyN9azMtLlCnaTur6Jjo8ycfFvOt10F5dLZevohOKldhLsC7sJ899JjAYSOrWT92RLi9/uuQvzCSeA6SaVK3wpfHS7oG4peGFSIcsIFlKCV82DD+ydJKKmCaTT/jd2YOQ2B3cu92ioeMWUcCrQtd2rZ7FDSllADMhWYdag/JrYEhaDrcbQf/3GM1JRo8SNrysRwhM1O2uiXSMpXCniWQpQ6I9pnPFqr+ch3d4E6DBkWytIpY8aSVVkrmSjy6iQV4onwN/IWy9w2ExLLWDE+M3CUhAKDWtMaMhBXV6ID0QA66OBN0bAUxn99KGZRYNrS/cuha5Xi7uSa0tUREkj8bWpuZrScF+nZ1jKr+DhLnm+6AvzjjxmD4dhVTQ3saglOK1li93gJzlHe4SydoXVpsrYYHVrhuqIN7ncro1Inr9KU/KnA7xqRY5Z8HYqLJTwuDsNA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(1590799021)(451199024)(1800799009)(186009)(2616005)(6512007)(1580799018)(83380400001)(26005)(122000001)(478600001)(53546011)(31686004)(71200400001)(6486002)(6506007)(41300700001)(38070700005)(38100700002)(110136005)(91956017)(316002)(66946007)(66556008)(66476007)(66446008)(82960400001)(8936002)(76116006)(8676002)(2906002)(5660300002)(4326008)(36756003)(31696002)(85182001)(54906003)(86362001)(64756008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjRVazcrK01uUTQ3ckFLMkd1OHIyVzI4OWRhOWZpNS9JZ2ZFK3c4SHV3NE41?=
 =?utf-8?B?dll3bGU4QllEMVYwM2N2ZHhZS3ZmYnBxQU9iWGIyckpFMW41dWxacnRhc1da?=
 =?utf-8?B?NVUzSHRDZmY3aTl0STlxVHpFSENJUlE1Y1V5RVZ0SjJ4aVE0bERDV3hTRFFK?=
 =?utf-8?B?dFpzaitDUVg3OWRzSjNZZUNPNWNPK3VKTU15S2hIakNXM1kxUTFuYXNWVFRC?=
 =?utf-8?B?SXFNRlBPV0ttZE1jRWoxTnh4WmVjTlhSQ0tBYXZPNmlBWmQyenFVQjRXQnda?=
 =?utf-8?B?cEc2WTdhMVI2SUhtZkI1akliMTFvaG1za0YwcnFJU2VaSSs4UkpadG5QOHhr?=
 =?utf-8?B?VkdDd1FTVEF0UklSZFpzTmVLRFVsbXBSTFd0Mk5TaEpBWk4zZTZtVGFpZWJH?=
 =?utf-8?B?UDc2UXAwZU9nUmoxbDE1T0lMMDEydnU2ZnRwdzJYTHVJK0VaLzhKblZXN0o0?=
 =?utf-8?B?NXNEcytqMmN5cVRoa3cxMFUvbXZlYmI0K1NEbitiMEV6T2hZODRTZXNHakVt?=
 =?utf-8?B?NXpqZFVmZU5vbHZjVXltTDZIUDc0OEJSdW1PV29XQmo5Uk9LM0dtMTFCNlRq?=
 =?utf-8?B?aXpZZG9lcm9DY0NhVnNyMDRLNTBDNmRTaTlXTkFta2Q0RnpSTmhwb0ZmQncy?=
 =?utf-8?B?WnB3b2lYZUVxeEtrYVNnRFQwb2lZUU90aVdWeUhwSTRpZzlaUTAxeklGWS90?=
 =?utf-8?B?ajFpczFTb1J3bXJQVXRqczg5NG13NW94VnRqaEpLd3E3ZGFpNzNTbE95eUhJ?=
 =?utf-8?B?Tkg1NUZkNUExSUp5WHVwWjBmT29VMnZ1N3RheG5OTkVnQXJSeUNyZmN4WGxR?=
 =?utf-8?B?QWw3K3dTL3ZsdHc4UzFuYWk4OVdNcW80ZmJLNnRwV1AzL0FOUCtHaUVMZVVR?=
 =?utf-8?B?Mmtnd093OERVREVGakt2c0RicEtwdXF5TXhzRWZGRmNlSjlLK3BwMGh4d0g0?=
 =?utf-8?B?SWVPZHlORmFwcjQ4b3VITnZoZ3Y3NFA0SmUzQ085SWZoOGtPYmxVZVprRWJT?=
 =?utf-8?B?blZVWjl5K3NzNWFoM0M4SVBvaXlvZWxxM2J4V1JvbFdQck14WG5BMjFhRXRS?=
 =?utf-8?B?cEEzbURUVGYyUHRoeTZoeUl6OFZQQTBKS2s3WHJjSWljNit6TlhQRGNvMk9J?=
 =?utf-8?B?RTNzcFhZSWFEWkhxckJ0MU92SUZDVUFLVDBxQmk0TDdIVnVQa3huRUdINCtX?=
 =?utf-8?B?UWM4V2c5OTdWYjNBRUpRYlUrUTdicEhSVVZmWGF5VWs3d2pHM3VqZWcvSk9u?=
 =?utf-8?B?NkpZdEJ1YUMrZmRxc3ppRmRIUXU1cjNmTG4vbDBtSDEvR09Pa2Fja2lOTUVm?=
 =?utf-8?B?V3VITEQwTDIxbGRZNWdPL0ZCTEVLMGUwZldFdVB2SUxoL1BxdEJ0ZWJQdzE3?=
 =?utf-8?B?ZFRWMDZEMUw1YVdFQ01RS0lYSitoaFo2K3BucHBVZ283UGVVenlMeVRBeC9t?=
 =?utf-8?B?eEZES3JBMTZOOEpJaHllTi96RndsRUNzZ2Q1MnpvWk5kbW1nVm8rM1ZIcU1x?=
 =?utf-8?B?Q05YUmVHUHVWbEM5NEc0R0JrTDREdjluVmpJNWthRW5lVzY2enVCY1N3OHlt?=
 =?utf-8?B?eFdselRYcGpibG9raVIwNEVjSkpqVWhyd200RURjcDhOUFA5c09Pd05vU1gv?=
 =?utf-8?B?VGdoa3g2ZGlSWWRtbThTS3FsTnlFSHhwWlE4WHpOMUZKWDBWOUdIZkw3c0ty?=
 =?utf-8?B?SDFkdlpnZjc0Z2pkSi9lS3l0MGt2RnYyL3E5TjJ2UkU2V0hzVlpmSm5SZmd6?=
 =?utf-8?B?cTN6Tnd4dzc0TjEzUG9pOFNheGxDaFJXMEVaTTNtaHdyRUE3OVVWeFdObXF5?=
 =?utf-8?B?ZTZsWjJQcWpFcWNrM3ZOM0ozYnpJeG1lK2lRcUtKRXJ4RWpaOGNVQUhBQXhS?=
 =?utf-8?B?cThHd1dBRVdBb2dIOEdRQkpCUlVBeU9rTUpGcVNQR0Y5S28xV3RicnZTMXBo?=
 =?utf-8?B?Um8rZUYybUY3SUwrRE13YmlRL1Q5R1ZWUGhIelhYbGRNVDdNSTlDdGpRbWJn?=
 =?utf-8?B?aEZ4VFdvbGxzM2JlVm52ZkRHUUVCVFIwQmFVQjBOcFFaa2xKS1BnYk9JY3Jv?=
 =?utf-8?B?VHpBWktFankrbWZwTklCbmNZdWlqdFEzenY3Z0ZKdy90dURwT1Q1ckVjaHBX?=
 =?utf-8?B?MElkbXdoYjdMeTg4d3BJNzJQS04rUHZyaGhCWmJJZzhBTTllQTNkU0dOazkx?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B70BAC5EE015C44F9B6A1F623AE82F73@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PbGrSjXDWqN22boU/dwrK1of1WyvoTmsVwUjIJAV9EJKXA48qqbakt2sJVkzCPtMFNoCfClrIZPC13julS6PM5R/u33FeMqKqCQ5AnFsnFVoOIU/hRkGCpvWzPDjp5cKAx9wzVlebdmPYE50n6m48guvYevoUf+vZQ1z6d8h5E4Js87oZo30Z22Qcrxb7DlI4nNUCxWDjNX8Qsw3UUiAYwZtcBqJnB1FhyeeG9+JqCEPRHEJPeZ3XmpiHJdOTw31NnJWrmA7HShx8JjVhVp9B48jTk0KASdoHZ3OSZOI7q6VD35egdVWC9WX5+nWGxkax6j03T2oj3qXHBbmcIO01QXo0mUrNEs9sTVsifFfmHw+ICG+oyEn2GSSmnUx9Yp/p2ndhHUmZIRnhG1qXidfpbUu2ge3F8WufxHsZraOFihLTTm/D+xNN6dlVPa2q8Mj2ScgO7f07BGlmBCCWWfw70Yi5ZDUof9HOrO2XxL4SlMwQfWYnTn61Q5QLY6xYUvRAAwRVC4LQ9tAn/CXN236S63S1lJJM8MtZCnaqdWiHEae44H2qqJzedd2D8ncrKvEg9AppxArhNB32oW/EZpPzFmJJx6EDLqTGPSbrEL27w2kd/owhELcdylPkri5oP+UiKc8oThlw7ll0DiLX56HCO7xG91IAsz9525y+SBJGPk0sxkEG8Y1iSbaA6jQatj0d/ww21m6EdbWar0lc2Xs7uZJWQeuCyEXnbG1mtHivcBxWlFcpeQxJC0CZdgYeHQZOu/6oh8xP14HCzJ9sxiIZ2x6mRplc/ASqX4u9x889EM=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906c7c08-feca-4499-4ced-08dbba857b60
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 09:31:06.6064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4F3no2FKOzD2ytSJodsVb70amjYVKrIvnZEIpWdvhDss1L5uIJ0onB2nU902WDP11jXjdRZ9E7jedCMGGTpvTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11785
Received-SPF: pass client-ip=68.232.151.212;
 envelope-from=lizhijian@fujitsu.com; helo=esa3.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBXaGVu
IGFsbCB3ZSBkbyB3aXRoIGFuIEVycm9yIHdlIHJlY2VpdmUgaW50byBhIGxvY2FsIHZhcmlhYmxl
IGlzDQo+IHByb3BhZ2F0aW5nIHRvIHNvbWV3aGVyZSBlbHNlLCB3ZSBjYW4ganVzdCBhcyB3ZWxs
IHJlY2VpdmUgaXQgdGhlcmUNCj4gcmlnaHQgYXdheS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1h
cmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IExpIFpo
aWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCg0KDQo+IC0tLQ0KPiAgIG1pZ3JhdGlvbi9y
ZG1hLmMgfCAxOSArKysrKysrLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9u
L3JkbWEuYyBiL21pZ3JhdGlvbi9yZG1hLmMNCj4gaW5kZXggMmI0MGJiY2JiMC4uOTYwZmZmNTg2
MCAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL3JkbWEuYw0KPiArKysgYi9taWdyYXRpb24vcmRt
YS5jDQo+IEBAIC0yNDQ1LDcgKzI0NDUsNiBAQCBzdGF0aWMgdm9pZCBxZW11X3JkbWFfY2xlYW51
cChSRE1BQ29udGV4dCAqcmRtYSkNCj4gICBzdGF0aWMgaW50IHFlbXVfcmRtYV9zb3VyY2VfaW5p
dChSRE1BQ29udGV4dCAqcmRtYSwgYm9vbCBwaW5fYWxsLCBFcnJvciAqKmVycnApDQo+ICAgew0K
PiAgICAgICBpbnQgcmV0LCBpZHg7DQo+IC0gICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEwsICoq
dGVtcCA9ICZsb2NhbF9lcnI7DQo+ICAgDQo+ICAgICAgIC8qDQo+ICAgICAgICAqIFdpbGwgYmUg
dmFsaWRhdGVkIGFnYWluc3QgZGVzdGluYXRpb24ncyBhY3R1YWwgY2FwYWJpbGl0aWVzDQo+IEBA
IC0yNDUzLDE0ICsyNDUyLDE0IEBAIHN0YXRpYyBpbnQgcWVtdV9yZG1hX3NvdXJjZV9pbml0KFJE
TUFDb250ZXh0ICpyZG1hLCBib29sIHBpbl9hbGwsIEVycm9yICoqZXJycCkNCj4gICAgICAgICov
DQo+ICAgICAgIHJkbWEtPnBpbl9hbGwgPSBwaW5fYWxsOw0KPiAgIA0KPiAtICAgIHJldCA9IHFl
bXVfcmRtYV9yZXNvbHZlX2hvc3QocmRtYSwgdGVtcCk7DQo+ICsgICAgcmV0ID0gcWVtdV9yZG1h
X3Jlc29sdmVfaG9zdChyZG1hLCBlcnJwKTsNCj4gICAgICAgaWYgKHJldCkgew0KPiAgICAgICAg
ICAgZ290byBlcnJfcmRtYV9zb3VyY2VfaW5pdDsNCj4gICAgICAgfQ0KPiAgIA0KPiAgICAgICBy
ZXQgPSBxZW11X3JkbWFfYWxsb2NfcGRfY3EocmRtYSk7DQo+ICAgICAgIGlmIChyZXQpIHsNCj4g
LSAgICAgICAgRVJST1IodGVtcCwgInJkbWEgbWlncmF0aW9uOiBlcnJvciBhbGxvY2F0aW5nIHBk
IGFuZCBjcSEgWW91ciBtbG9jaygpIg0KPiArICAgICAgICBFUlJPUihlcnJwLCAicmRtYSBtaWdy
YXRpb246IGVycm9yIGFsbG9jYXRpbmcgcGQgYW5kIGNxISBZb3VyIG1sb2NrKCkiDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAiIGxpbWl0cyBtYXkgYmUgdG9vIGxvdy4gUGxlYXNlIGNoZWNrICQg
dWxpbWl0IC1hICMgYW5kICINCj4gICAgICAgICAgICAgICAgICAgICAgICJzZWFyY2ggZm9yICd1
bGltaXQgLWwnIGluIHRoZSBvdXRwdXQiKTsNCj4gICAgICAgICAgIGdvdG8gZXJyX3JkbWFfc291
cmNlX2luaXQ7DQo+IEBAIC0yNDY4LDEzICsyNDY3LDEzIEBAIHN0YXRpYyBpbnQgcWVtdV9yZG1h
X3NvdXJjZV9pbml0KFJETUFDb250ZXh0ICpyZG1hLCBib29sIHBpbl9hbGwsIEVycm9yICoqZXJy
cCkNCj4gICANCj4gICAgICAgcmV0ID0gcWVtdV9yZG1hX2FsbG9jX3FwKHJkbWEpOw0KPiAgICAg
ICBpZiAocmV0KSB7DQo+IC0gICAgICAgIEVSUk9SKHRlbXAsICJyZG1hIG1pZ3JhdGlvbjogZXJy
b3IgYWxsb2NhdGluZyBxcCEiKTsNCj4gKyAgICAgICAgRVJST1IoZXJycCwgInJkbWEgbWlncmF0
aW9uOiBlcnJvciBhbGxvY2F0aW5nIHFwISIpOw0KPiAgICAgICAgICAgZ290byBlcnJfcmRtYV9z
b3VyY2VfaW5pdDsNCj4gICAgICAgfQ0KPiAgIA0KPiAgICAgICByZXQgPSBxZW11X3JkbWFfaW5p
dF9yYW1fYmxvY2tzKHJkbWEpOw0KPiAgICAgICBpZiAocmV0KSB7DQo+IC0gICAgICAgIEVSUk9S
KHRlbXAsICJyZG1hIG1pZ3JhdGlvbjogZXJyb3IgaW5pdGlhbGl6aW5nIHJhbSBibG9ja3MhIik7
DQo+ICsgICAgICAgIEVSUk9SKGVycnAsICJyZG1hIG1pZ3JhdGlvbjogZXJyb3IgaW5pdGlhbGl6
aW5nIHJhbSBibG9ja3MhIik7DQo+ICAgICAgICAgICBnb3RvIGVycl9yZG1hX3NvdXJjZV9pbml0
Ow0KPiAgICAgICB9DQo+ICAgDQo+IEBAIC0yNDg5LDcgKzI0ODgsNyBAQCBzdGF0aWMgaW50IHFl
bXVfcmRtYV9zb3VyY2VfaW5pdChSRE1BQ29udGV4dCAqcmRtYSwgYm9vbCBwaW5fYWxsLCBFcnJv
ciAqKmVycnApDQo+ICAgICAgIGZvciAoaWR4ID0gMDsgaWR4IDwgUkRNQV9XUklEX01BWDsgaWR4
KyspIHsNCj4gICAgICAgICAgIHJldCA9IHFlbXVfcmRtYV9yZWdfY29udHJvbChyZG1hLCBpZHgp
Ow0KPiAgICAgICAgICAgaWYgKHJldCkgew0KPiAtICAgICAgICAgICAgRVJST1IodGVtcCwgInJk
bWEgbWlncmF0aW9uOiBlcnJvciByZWdpc3RlcmluZyAlZCBjb250cm9sISIsDQo+ICsgICAgICAg
ICAgICBFUlJPUihlcnJwLCAicmRtYSBtaWdyYXRpb246IGVycm9yIHJlZ2lzdGVyaW5nICVkIGNv
bnRyb2whIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpZHgpOw0KPiAgICAgICAgICAgICAgIGdvdG8gZXJyX3JkbWFfc291
cmNlX2luaXQ7DQo+ICAgICAgICAgICB9DQo+IEBAIC0yNDk4LDcgKzI0OTcsNiBAQCBzdGF0aWMg
aW50IHFlbXVfcmRtYV9zb3VyY2VfaW5pdChSRE1BQ29udGV4dCAqcmRtYSwgYm9vbCBwaW5fYWxs
LCBFcnJvciAqKmVycnApDQo+ICAgICAgIHJldHVybiAwOw0KPiAgIA0KPiAgIGVycl9yZG1hX3Nv
dXJjZV9pbml0Og0KPiAtICAgIGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBsb2NhbF9lcnIpOw0KPiAg
ICAgICBxZW11X3JkbWFfY2xlYW51cChyZG1hKTsNCj4gICAgICAgcmV0dXJuIC0xOw0KPiAgIH0N
Cj4gQEAgLTQxMDMsNyArNDEwMSw2IEBAIHZvaWQgcmRtYV9zdGFydF9pbmNvbWluZ19taWdyYXRp
b24oY29uc3QgY2hhciAqaG9zdF9wb3J0LCBFcnJvciAqKmVycnApDQo+ICAgew0KPiAgICAgICBp
bnQgcmV0Ow0KPiAgICAgICBSRE1BQ29udGV4dCAqcmRtYTsNCj4gLSAgICBFcnJvciAqbG9jYWxf
ZXJyID0gTlVMTDsNCj4gICANCj4gICAgICAgdHJhY2VfcmRtYV9zdGFydF9pbmNvbWluZ19taWdy
YXRpb24oKTsNCj4gICANCj4gQEAgLTQxMTMsMTMgKzQxMTAsMTIgQEAgdm9pZCByZG1hX3N0YXJ0
X2luY29taW5nX21pZ3JhdGlvbihjb25zdCBjaGFyICpob3N0X3BvcnQsIEVycm9yICoqZXJycCkN
Cj4gICAgICAgICAgIHJldHVybjsNCj4gICAgICAgfQ0KPiAgIA0KPiAtICAgIHJkbWEgPSBxZW11
X3JkbWFfZGF0YV9pbml0KGhvc3RfcG9ydCwgJmxvY2FsX2Vycik7DQo+ICsgICAgcmRtYSA9IHFl
bXVfcmRtYV9kYXRhX2luaXQoaG9zdF9wb3J0LCBlcnJwKTsNCj4gICAgICAgaWYgKHJkbWEgPT0g
TlVMTCkgew0KPiAgICAgICAgICAgZ290byBlcnI7DQo+ICAgICAgIH0NCj4gICANCj4gLSAgICBy
ZXQgPSBxZW11X3JkbWFfZGVzdF9pbml0KHJkbWEsICZsb2NhbF9lcnIpOw0KPiAtDQo+ICsgICAg
cmV0ID0gcWVtdV9yZG1hX2Rlc3RfaW5pdChyZG1hLCBlcnJwKTsNCj4gICAgICAgaWYgKHJldCkg
ew0KPiAgICAgICAgICAgZ290byBlcnI7DQo+ICAgICAgIH0NCj4gQEAgLTQxNDIsNyArNDEzOCw2
IEBAIHZvaWQgcmRtYV9zdGFydF9pbmNvbWluZ19taWdyYXRpb24oY29uc3QgY2hhciAqaG9zdF9w
b3J0LCBFcnJvciAqKmVycnApDQo+ICAgY2xlYW51cF9yZG1hOg0KPiAgICAgICBxZW11X3JkbWFf
Y2xlYW51cChyZG1hKTsNCj4gICBlcnI6DQo+IC0gICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxv
Y2FsX2Vycik7DQo+ICAgICAgIGlmIChyZG1hKSB7DQo+ICAgICAgICAgICBnX2ZyZWUocmRtYS0+
aG9zdCk7DQo+ICAgICAgICAgICBnX2ZyZWUocmRtYS0+aG9zdF9wb3J0KTs=

