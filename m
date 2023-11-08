Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6317B7E4FBC
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 05:31:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0aCN-00085f-7j; Tue, 07 Nov 2023 23:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0aCL-00085D-EG
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 23:29:49 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0aCI-0000fV-Uh
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 23:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699417786; x=1730953786;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VxtbMPzPh3se1Ymv/D6fdkEjrhAFpAIrqhfRwrO42sw=;
 b=fReSOgsZUV9YMZrH7m5jBFI2qPDmOacQiICjO8iPSp+Hbu4mPvNtNz3o
 VEwLY8lA5UNbG5YdpJnvlxakLPWFaGzIhoHi+8NGw3w7kxwKydAaSz/Qg
 VLToNQCieIoOtRS4AtRxen67Ok6ZeNXtsJ1p9sSi21hhkX8n7ss0vLKEd
 scT1mXMc7EqUg92Y2d1oVVikT94sOIN0SFw5kMhGgNqnGwVaXePKPlYKU
 CLa7RLU+b1QVC5d70L/db1bINeq9c+q2wEbvNEsgkkobSBe5JLOfkzccG
 dBQ0R1V+rUX+k7cfZdZHhHF2Dc0Bx//bZioFR4BURALP0oD6QoGLTrAXb Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="369021291"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; d="scan'208";a="369021291"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2023 20:29:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="906652895"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; d="scan'208";a="906652895"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Nov 2023 20:29:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 20:29:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 20:29:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 20:29:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 20:29:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHhpVLXOidbhxX0yMc+t3IZcd4tOT55xkz9PG1OgaZZ8ZiEiwIP+oazx1AUfBHw7s4UuUi1sTM8w6jsVx/yWnhgxH02+1u/Hd9RQHXD3GH3nJ6O/FTJ8faXI2fTLnvUwBn/34n0+wQ2Nm9iefv5yIYS0odq8uwregqmOfZlYon0VeLftuNgb+ez3/koywE3vEOKYfLFfn9/psSWG/9V4Qqa1UCAXIvUAC1v/7uYLerqnmsctWivC4lEOr4h0Yff1QZq0P1BEEf0+4IkhwNrDRHSUG1D0Upm9IKXER78KhBNk2XxNSgmLTzMs5U86eJKy6e1SULgCsuNuDg4bWSvKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxtbMPzPh3se1Ymv/D6fdkEjrhAFpAIrqhfRwrO42sw=;
 b=P1VWhu7O3BiINiXjw5jnkS/6J1phiU5OnNETuwR+Y4CuMs0j4wi0G7c3iR8FoPuUbAwjnC7G7ggYM5YzWwuVNewyFUUz6AsBH/NftDNKVs7eGTpwrfn62LK0awbSNpJpSxSuQGLwIVrxpG+tplGaFY0/zt3GAlGrW/ubbv4aNCbQmn44XboV8Lyutv+IiXA4rqcDUXec+zDNR/i8jiyivr8fVxwxguODIdc3Z/J2Ial50t090v5NlNNhEReyHHy0faArnn8y99+aOgxEFn+xQxgsQaoj14LL5rNzKjfnbQ8KrXIjumKwy7XoENTcqVAx9IBRRfuBT6KxKREhK7jDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 04:29:38 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 04:29:38 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 27/41] util/char_dev: Add open_cdev()
Thread-Topic: [PATCH v4 27/41] util/char_dev: Add open_cdev()
Thread-Index: AQHaDV58bZcC0coFfkalns+kAZLs5bBu5HWAgAD5DXA=
Date: Wed, 8 Nov 2023 04:29:38 +0000
Message-ID: <SJ0PR11MB674433B76651340CD23870AE92A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-28-zhenzhong.duan@intel.com>
 <2f071396-e3b3-4865-b802-3599a888fd55@redhat.com>
In-Reply-To: <2f071396-e3b3-4865-b802-3599a888fd55@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8081:EE_
x-ms-office365-filtering-correlation-id: 4bca2642-7e08-4a4c-d8c3-08dbe013519c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: clHhjRhv9LlVk+sSSTghRjJXTnzDQENvTZ5a64o1vJInBrvGqrzGB3E7awuE/1Mm+CQ34Dc23aSyZK9xhZ8LlArRxMwLpPyw2nkya6k79Ot7REHecq1kFPWGEAxd+gWxezsBYVkRN6awEwarGDtPHEQ6Z+fTw98jxaLhom7l+sQLTo7vuxxXnZTTYU909/wDIjRXc/WjaRGlL6bkX4PQkcfWIkh72VwRF1bj1Ll8ku/HQ48A4EMImJCzP/+kEiAIJ/SrrkPydXZME0X4Iz5nDuGow4l1kYDe+GtQmcwhej5PPQBNqRqQk/5E6nFZKvjFoonDxs0ZBxAfzUaF6alY5+Db21tKqoRdLFIUoqzsUMQKCWYhzAkhxQiE9aOzIggb/Z5INjm0IqpbADarEzsGfDSO8ncbd0pI9450uEJAq736uJ+RlHsIQjSRi+eGcX/OvXCq6MwXAx3YkA6IG3sEfg5Hxuiw4K2BnJTIXqJO3DEvqKFKEVMdBvXy3MOx0lYTnzaOzDiuHj5viJTDBwMLg01vbgrt7qzKRh/bcOAMIYtVnajkxQEdUB/LcHAeeBV/2KDyg3eyGtOm9lUz11ExL2r9QWmpt9AknmNFakJKoOJicjpk8Gsx8yGFMaI7tc5P
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(107886003)(122000001)(9686003)(52536014)(82960400001)(26005)(478600001)(110136005)(66446008)(64756008)(66476007)(54906003)(66556008)(76116006)(66946007)(316002)(7696005)(6506007)(38070700009)(71200400001)(8936002)(4326008)(8676002)(55016003)(2906002)(38100700002)(41300700001)(33656002)(5660300002)(86362001)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzZhbTlOUWkxc2ZxdDFUZnI4aksrd25QRGdTZTNjZUo3UFJCOUc5MXcya2o2?=
 =?utf-8?B?UVZTUCtadmpaWXFWRmtIaUxXdkZSNTYrQ3hKQmtLUzNUQkx1QktqL0JJU0hU?=
 =?utf-8?B?dW5GRUdid1ord2EvRjJ3UXg0K2hETWdVQmMxRkZaMytlUTNuR040SjBheW5s?=
 =?utf-8?B?RWRic1NSY3VzYllGd1FhbTFzYmx3SUdqM1FXT3VmY2xHVWZQM2RhRWFZQkFo?=
 =?utf-8?B?OTdTNWRoVG9BaTkySzJVcXJFT2FnYUVEK2ZtKy9zeC9rYnp1YVROR1hlSER5?=
 =?utf-8?B?eWhMQ29YOTBiRWlyaHBDL09tQlIvMEVsRWRXcWtORkV2OEE1bkVKcy9ZcUhz?=
 =?utf-8?B?U2NEaGR4RjRZN1dTT3Nhcy8vWlNROTZuWmVhcnF0YnZ2NXYxUHhoUVNKQ0ZJ?=
 =?utf-8?B?N1g5TFp2K2p0RjlheWlDbGxRZXdoNWNVZTdiLzYxbGVQQXBWMHp6LzZMU0I2?=
 =?utf-8?B?Y21jd1kyTkpONjlrblE0NDU0S0NEVUtGZG92cEh4UFdpRzdQVGpoZXBmak9Z?=
 =?utf-8?B?Wnp0YktDS1cvU2xIa2xqV3hvWjJJL09QWTVLQklkY1l5R0ZUV3RMaFRFYUZS?=
 =?utf-8?B?UjJGamhsK2V1VFhYZlAySU5QTXFCNHlsekRLTjVOTHZFU0grMHBJa1p1RkFU?=
 =?utf-8?B?SnFzY2NLUWxPaU5aN2g5WjMvL1EySUdxbm1SU0ZJQ1JCbTVtVUEvalhQNEU2?=
 =?utf-8?B?Vjc1L1ljWjBhS3daYTBpQUdzYzRtSFpHRWRoYUhjek5zbFlYYjZWU044azha?=
 =?utf-8?B?MEVONTFJTEFHOEtWZDlCL1hzTlVDYUVRKzhuK3JjbEduamhDaTlsQnE3R2Jo?=
 =?utf-8?B?Ly9iWFRHSkg1Y0dOeWlUYVJFRDliRzJhMlFFZ1VQOEJCM0xkc1FIVWZOYm5a?=
 =?utf-8?B?SnMvTXBBdUZtczQ0cFFtZU96aERNeDdySFFsbWpWSVhiak53djhmdU5OT2w4?=
 =?utf-8?B?Y2NSTW1kYW95ZzVHdmtMWEExVzBlUEhNRzJBM2NwTmtXbWU3ZDRoS2lLRmEz?=
 =?utf-8?B?bE9OVEYybEgxRW4rY1lFN3g5bUZsTWcrd0FyYm9pL3gwWnNrbXlIZGh1cGJx?=
 =?utf-8?B?SWx6bjZOUG9QaTQ5ZlhNTm9TQ09hd0dNSmpvS2RlMVRmV25qWWxocVdCaFdF?=
 =?utf-8?B?YVNmRDZwTHBiWFdLN3BhT0pvVm9NbzB5Z2MwVEViVGRMLzdGamVzL3VYSkxh?=
 =?utf-8?B?Mk1tNmhOUlFCTlBja09Oa2ZVemFvclZCOHpzUEVpY0JQVlo2enRzR1VwSkQ0?=
 =?utf-8?B?ZnRqTTBZSVdlT2h4aEkzUHRaUzRodWhMb21UOWxEYlpOczVJK1JkRk5vR016?=
 =?utf-8?B?RWpTb0dhSnNNOXhvR0xZMGxLZStlTzBGZUdEcTJRVDFqNG1ibUFPd3ZneHNJ?=
 =?utf-8?B?NmRuU1BPWmt0dVl0Nnd1OXU3OWhwRTJPTjdKeGNSaXEyVFZzdVY0L3F1TzU4?=
 =?utf-8?B?ZEFXV2hBd2pUclBXaHUwYkZ0L3hVdDQ4cnlUOFlJVmpvTFd1YXZ6TXE1NG5B?=
 =?utf-8?B?NkdBU0hwZTFwSE53MyswNko0Yzg1SzZxVEE3QmJzUnFLQ1JhZ3RZRFV5K3Rr?=
 =?utf-8?B?ZUVQMTdudVllOFBHZm1LbWtuQVhBdEVTRUtIMitiVy9HTEpwc2ZVdytzMjhi?=
 =?utf-8?B?Q1dxMnh2T1p0T2VPT3hCZGF0N3dwK0drOXVORHp5bDBkelo1dlZMT0FRaXdI?=
 =?utf-8?B?ZDROWnp1VjhINzEyZnNNOU5GcjNONVlicWhxeVZDOW1ybVJsWUhHRC9RUGZF?=
 =?utf-8?B?cGJBOTBlRllsdDQ2RUJuR1A1dldhNjQ3RVJET3FBaE9qL0hKMVVyVDdtTTdG?=
 =?utf-8?B?UjdLN2ZzS2V0Q2oxQ2tQTjYrdkdYVGdaMzEwZTBveU83bnFTa2lOK3hTMG45?=
 =?utf-8?B?MnNBNDZDS0R1Rm1DTmtoMWh1Y0ZlVlVQdU0rdmRaQWdBb0dFL0Z6d1dKN3Jy?=
 =?utf-8?B?RytQa2REekhDRUF0eUhqQ2huWW1KMzI1UjVxTzFvZ29za2ZjVm45cktoaWVr?=
 =?utf-8?B?RDZaNTdVRWJSS3B6L05jRjNVN0d2RWxYK0g3TGxJQ1Vpb0hHdDVXR013Tndx?=
 =?utf-8?B?T0pBblBaVHFrZkZ3RGY0TTFNL0ZXcWkrYWt1UjZic3NKR2JSZ1orRm1wNy9M?=
 =?utf-8?Q?gylLuV4b8cz6QId/VI0Yrwd5N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bca2642-7e08-4a4c-d8c3-08dbe013519c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 04:29:38.1085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ai9u9XovbnYizaLiyjO5UI1UawX0hpVq0dKr3n6f81yoyE9pmKTT2lgUixCg8SUMzlNG3hJ1T9Ja5VO2tfo0vMKmsp6VQ4ToBXYGyq/LgWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8081
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBOb3ZlbWJlciA3LCAyMDIzIDk6Mzgg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDI3LzQxXSB1dGlsL2NoYXJfZGV2OiBBZGQgb3Bl
bl9jZGV2KCkNCj4NCj5PbiAxMS8yLzIzIDA4OjEyLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+
IEZyb206IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4NCj4+IC9kZXYvdmZpby9kZXZp
Y2VzL3ZmaW9YIG1heSBub3QgZXhpc3QuIEluIHRoYXQgY2FzZSBpdCBpcyBzdGlsbCBwb3NzaWJs
ZQ0KPj4gdG8gb3BlbiAvZGV2L2NoYXIvJG1ham9yOiRtaW5vciBpbnN0ZWFkLiBBZGQgaGVscGVy
IGZ1bmN0aW9uIHRvIGFic3RyYWN0DQo+PiB0aGUgY2RldiBvcGVuLg0KPj4NCj4+IFN1Z2dlc3Rl
ZC1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6
IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25n
IER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4+IC0tLQ0KPj4gICBNQUlOVEFJTkVSUyAg
ICAgICAgICAgICAgICAgfCAgNiArKysNCj4+ICAgaW5jbHVkZS9xZW11L2NoYXJkZXZfb3Blbi5o
IHwgMTYgKysrKysrKysNCj4+ICAgdXRpbC9jaGFyZGV2X29wZW4uYyAgICAgICAgIHwgODEgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICB1dGlsL21lc29uLmJ1aWxk
ICAgICAgICAgICAgfCAgMSArDQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgMTA0IGluc2VydGlvbnMo
KykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvcWVtdS9jaGFyZGV2X29wZW4uaA0K
Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdXRpbC9jaGFyZGV2X29wZW4uYw0KPj4NCj4+IGRpZmYg
LS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+PiBpbmRleCA2ZjM1MTU5MjU1Li5l
YWRhNzczOTc1IDEwMDY0NA0KPj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4+ICsrKyBiL01BSU5UQUlO
RVJTDQo+PiBAQCAtMzQ3Myw2ICszNDczLDEyIEBAIFM6IE1haW50YWluZWQNCj4+ICAgRjogaW5j
bHVkZS9xZW11L2lvdmEtdHJlZS5oDQo+PiAgIEY6IHV0aWwvaW92YS10cmVlLmMNCj4+DQo+PiAr
Y2RldiBPcGVuDQo+PiArTTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiArUzogTWFp
bnRhaW5lZA0KPj4gK0Y6IGluY2x1ZGUvcWVtdS9jaGFyZGV2X29wZW4uaA0KPj4gK0Y6IHV0aWwv
Y2hhcmRldl9vcGVuLmMNCj4NCj5NYXkgYmUgbW92ZSB1bmRlciB0aGUgSU9NTVVGRCBlbnRyeSBp
bnN0ZWFkID8NCg0KU3VyZSwgd2lsbCBkby4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

