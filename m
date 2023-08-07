Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C90BA771E2B
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 12:34:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSxXx-0004Yy-Fu; Mon, 07 Aug 2023 06:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=576e22132=Niklas.Cassel@wdc.com>)
 id 1qSxXt-0004YC-TM; Mon, 07 Aug 2023 06:33:06 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=576e22132=Niklas.Cassel@wdc.com>)
 id 1qSxXp-0005Kl-Ns; Mon, 07 Aug 2023 06:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1691404381; x=1722940381;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PrK10sp3/0t14Nuu0I7J3VzGTseecN9pEEx97iXmFl0=;
 b=qb+vQOmRnXyRfNW7eYV1gpxJ9Khn5iYMi03EMdqV/reBnsZBoRW3SuI3
 K+mmtLgfXy8Hqaz5Jn7eVXNvXB/UgUpN57qJsbkNTf6r/ybPCQZIGlEpI
 qbL0wVIuslzwdZqBkLl7PYutwSGsIcYViCwunzjJS1Dt23eVloEBlEkOv
 xt1gNEQ5/J1YioX+97R92/jfh6rB38UG0rLBtPjHdNPpOeGqe7SMPwLXh
 L7D8lJLrm20wBA3G/9FVfgFCTwsDBE44iIkb23ARNM8kxTo5t/ghmxpBs
 dlQJiqF7zvz8ViYvyDxm2UwPPYh+RQzo0sZRrlA9ZuIYs9i0ca+D2zeOG A==;
X-IronPort-AV: E=Sophos;i="6.01,261,1684771200"; d="scan'208";a="238628607"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2023 18:32:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeRjblMaYzx9tMLKFB4JEnoRvEiq8mudn3TXDejV0Yj32qh96wKo1sIoBOw8dokarB5VWdeXFPbawOHglKMnzGPtUEo0KsKKFqGKS/0kaOu7hdppt8NSFSZkjjOEF0OEPca7EfvbsM9/O683qEHe74i4qzBgnVIYb5X/2hbMv2mtl0duB0RZUAlUKpJdXFqxi2j5rfyd9aFUbqDtu2MMIYlhnJMRr7xCIRN/KYZzDxDmY4/f5NjrsbKU6mhMSWBhncwUDnY1DZp50Tkh/YrYkAdscYonNBKfuci2+JSPuVifqhwPcmWC4BTIXMm7V9XJql26EtF74H5f9v3cmELVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrK10sp3/0t14Nuu0I7J3VzGTseecN9pEEx97iXmFl0=;
 b=HjY9c/SJd00EpwueUErDdtIbks3AfLiKxMk5jtbqYqbD9ld9rgtHSMFiMYJ2VAEjqG+v1k65/446Fc2Fa529NKT8HMlFREYkmD1azLyBDka86zysQagstnKFNDJvndejfp0QViKLgpQ/6Pk+IXKVGi1B6/BPC8nosPzQAk5Tqh1IJ8BjCvzRsfzkiGDbD1tuGESswIcQGDqMyRU1nPFD5yzySnyGr9tVJjuewUVvbRAaVq7XLqu9uOP+DovElCbZ6ZYEcY88UTiXjQdL56COYAa2frg9OSpwvboeGkocnd0DMf5VXOaWPw/xa3ZcwDVyJB0/WuzfddwzXkXGdl4ZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrK10sp3/0t14Nuu0I7J3VzGTseecN9pEEx97iXmFl0=;
 b=SE3M0tR/86hu+wEIWUZFwxTQadWHWjIRLOR7GyVDhiPmpveN8vQYsQ5LwE0J/SpLVGQZnPmoqShP40LxeYdsFvf0d38Qmeh2lMdIsM6e36acT1da3VYbiTtDLxtV0iqapOsYehNfx4RH1lZPSAfwY+H78SjuUNDd+OhRmpsDOOY=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MN2PR04MB6304.namprd04.prod.outlook.com (2603:10b6:208:1a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 10:32:53 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9%6]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 10:32:53 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: John Snow <jsnow@redhat.com>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/8] misc AHCI cleanups
Thread-Topic: [PATCH v3 0/8] misc AHCI cleanups
Thread-Index: AQHZmtwyWx1FN3NYV0CC4hKYUmTqRa/BJzEAgAmSn4CAAGUmAIAT4FqA
Date: Mon, 7 Aug 2023 10:32:53 +0000
Message-ID: <ZNDIUzyB9hmt+E1I@x1-carbon>
References: <20230609140844.202795-1-nks@flawful.org>
 <ZLe/VG5d6TEdp/MT@x1-carbon>
 <b58779ed-cecb-824b-019e-bc34e6b2258a@linaro.org>
 <CAFn=p-Y4Tw0eY=8yXxnzSA3kzwb36H0oysag=HD_8eMsPNwuDg@mail.gmail.com>
In-Reply-To: <CAFn=p-Y4Tw0eY=8yXxnzSA3kzwb36H0oysag=HD_8eMsPNwuDg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MN2PR04MB6304:EE_
x-ms-office365-filtering-correlation-id: 83575601-6cfd-4d48-3125-08db9731a809
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P9LN3HwbHrkvLj6lJnEkFRKgU6/54L661TroxOQtQQM33wxWPdoWWMDwv10RPXLJ099EZ1NWdA76B4JmjCnG9mzD+VMP5LJdnwa6lKiCn0IHIw6jMEkcb7K+YvsM+Dv/3TDLc8zRCHX1uIssTtbqMIeYvRW1N5Us84ihvk8MBRKw/47axKsE98ixFF6xYtKnNzEZInYJx/WXbR1MAmQEpianIbFMaxug7CBgiV8oGp6AXj3lVQlcyX2wLGxg0TCL4TtKLfsNmbMeEbGBtT49+K2q8qj6W6IjiyE/YB7HvJmlLX/mD4bR8oBDtgwK/FhDIZf+KpMQOQH8jIfQGrpTSC2EfrvvOkMrdQfVC1Hkmki6PcstSAUuUnLmEXCzpJoQ4VEhj6OwibsQOcg0D80ZDVsH40yttsw7ub1nWrcwxaIR1LOmkDJCARDDLU9anTqGSYksEmQfrf9JWsmVJAaL/CJjLUI7fR7BqKmQJip+pMJaD2NYO0vX4K8qvvIgln5INVi0PT+HB/2QnAj8zNI3NdfhcelDyJjp0jf8mfjA79lYduVeMIZLoRhR99PBqwLH1a+nwEPC9fhkS5fbgrzy3BdRxPrmKuek7tOnfS2T3pebyS3p+fTvtey0uOERSHc/qgvjnnpbsjAlK91nmq2ufA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(7916004)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(1800799003)(186006)(83380400001)(2906002)(38100700002)(76116006)(66446008)(64756008)(91956017)(54906003)(6916009)(66476007)(66556008)(66946007)(38070700005)(4326008)(316002)(8676002)(8936002)(41300700001)(6512007)(6486002)(86362001)(478600001)(122000001)(71200400001)(9686003)(33716001)(5660300002)(53546011)(6506007)(26005)(82960400001)(67856001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXVKZzYyVDNoYmpmRXRJeERReHduajh5YSt6RXlqWG5aUmNJeDdmSm1LbmFi?=
 =?utf-8?B?K3IzQkRqcUZqMnh3MlR3WlNDRFV6TW55WWpEd1RLbzJ6c2ZmQTV0NjlubFpZ?=
 =?utf-8?B?N25kaHh5T1lhY0E0N1d6Y3BRalBXVndOWEErbkdVWUUxOUtsV1Fob1JEd050?=
 =?utf-8?B?ajFwMGVMeEh2V0dKQzdJTS9hMVMyOCswYjFKMGUvRi80RCt4RFFJTHkyVW5k?=
 =?utf-8?B?eXhpQnpsNHFKdGFWaWtrNDZwS2NMRWJISEpDM2lqNUZ3WlRNMkYwZXByTjZE?=
 =?utf-8?B?SVVhVzIyZzlCSWZxNC9JQmg2eXZiYjNGaXpUalluNGNhZDJlRlBkUkViL1VY?=
 =?utf-8?B?dWhyUGp3ZHhzTjlGL21tRUx2TDQvNFRscWE4WU1hamgwWkp6NVRKTXR4U05Q?=
 =?utf-8?B?SnFlNDJBZWlwYzBqYlY1aGF3QnBYWjJhQXcxc0NWcnNiNUVDSDdQTGhCNmRZ?=
 =?utf-8?B?QU1mOXdKTUJDWHdld3V2NkZYY0FXVjBPWk85UFRwY2Rid3JJRytEMGNQSFJa?=
 =?utf-8?B?anhPTEpOcXF4YjVkOFFvQVZSVEdlaXo1bDVLYUFkMVM1aWRwcHdRdXlscitU?=
 =?utf-8?B?MlBtUkFuMjlVRTRzZ3N4U3R0MVoyRXpOOWtxRGVldEkrZ3hJa3ozc0U4Y0Zp?=
 =?utf-8?B?eUoxcm1LTEROM2l2SC8vYzloZTMxRkxQbjRHUzVLVVlTSEhveFJ2WUM5RlJm?=
 =?utf-8?B?WXNuanE0UVNYWjU1a0xwcHNtbzhPRklkZGlrcVdOcDJwTWh0QzZneVNZTXVZ?=
 =?utf-8?B?b2E3MEhIaVo2dzdYMmJ4ZzJib2lSRlZDWDFmYm1WNmx2WndiVHJyOHk1bEZv?=
 =?utf-8?B?eVpzS0VwZFdpQ3B4Z3psdWVNM3FlZjBiZTVLc3M4ZGVvSERwVzZZbW1EQWx3?=
 =?utf-8?B?MzZ1MkNJK28ySTltd0p0ZE5tTlQzeDhuSDN4WmZLcWt0QWpDNndYTzF1R2My?=
 =?utf-8?B?K0ZsdTFjZmpzeWVaZ0hqQzZJemtySjIyNWErN25GRUlZZk4xYmNJSEkrVHBI?=
 =?utf-8?B?a0FraUhpaE1TRUZyWlFjUVJac0ZrcG9PZW91T1hNRTducVFndUN6SFpZVlBj?=
 =?utf-8?B?dStLMnloTE1qa1JmU0Z5YUpmL0RsejRyNThiME90OXJ5Q2s2MDdieUUxN3dO?=
 =?utf-8?B?QjQ3dzhPVEpDYzVaK0lRSGs2VURUenFEelRwTWUyTkthSHFsQkdacFFQRTVu?=
 =?utf-8?B?N0NLbjRPOWlQZDVEVHFNUklXb2hVa3JQMXJDYXp2SENxV3VENEk5Si83ZkY3?=
 =?utf-8?B?RjE3dUtkUzZnanpIa1pndmRIK3Jxa0Fmd2xXZVl1cHhPTCt5WHlQdisxSytM?=
 =?utf-8?B?VnRUVmhBdlRaTEtzemMwRE90ZVMzamhIT2puV1k5Q29IWU0zQUZseXBCaFRi?=
 =?utf-8?B?c1VLYmkzcmNiRjBSSG56bmtoOXlJOWdxRlljQ1pGOG5tK3pBamRkUUVzdlVB?=
 =?utf-8?B?b0toV1lxZUpoRjZvUU1vekxwKzNpc3hFSDVFMFJtQ1BxOWJjU0FKU092STN6?=
 =?utf-8?B?VTNwaHhZTUNxdU5MajM0K21ReDl1SGdwdXRoc1ovUkl1VkdCQ09kWEd5MmZX?=
 =?utf-8?B?NHQ5NjcrTU5qOERWWWJ4RkZHaXNJdEpsREhZRHhkZVV1WTA1RWMwdVc2dUNF?=
 =?utf-8?B?bi81VGtVVVdDMjJHVUF4NnB2MDdEVFlvZjd6WkQzWWtiTHBOWnhERlZMMkZn?=
 =?utf-8?B?dCtXelpObVE5SGJocXJ1SnZDeVc0WjVqc2I3QXVvT1I0U0JwRnZ5cTFSN0U4?=
 =?utf-8?B?M2J3K0JQK2h3ODVWOVJBcWlpeEhyVE11aUVvRU43YWY4bWx6ajNTK2NZSWxo?=
 =?utf-8?B?SVpIN3dWbkI4c0hHc0JGZHB1ejJyQUhQMU1RWCs1ZE9wUEZQYnNMdzI2QlJ2?=
 =?utf-8?B?M0xVcHI4cHdZTW5TWjBDem1qa1J5K0RoMVMvNEZCcmppS0Rla09CaFd3a3ZX?=
 =?utf-8?B?Mm4vZHVRclhGRXZXS09zQm95d2djeGZtZ2kwdlF3MlFyYlQvT1dqZWIrcU4x?=
 =?utf-8?B?OTUrWTNySnBBRGk0UXFsR2NLVXQ3eWxENUdJS3UvV2YrYTR5UFh2U1hYbDVs?=
 =?utf-8?B?MmVOUkp1WjdBaWlqTDJTaHBObjE0VEIvbHppWWxoamRuODlPclpHay9sWGNl?=
 =?utf-8?B?a2M4NVVvTGFFRVNPcGd2Wk4xOUhlUm1DalJrbFFYMXRvUlozU1BmM2tsazdj?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FCA56CECD578742AF08DA1D5A7D50DA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2cUCmnF7ExRYKU48O7qyJT08J1RcOx3NVgd5n0gN6Wx13f8ncfRJdK30Oozo0w/IrouZFgCKphMb5RdrIQwGvFvH9fYAmzzBs1XKXtjroTUYqAfY/N61JFb7oiSuECxS1j4CuNteuPEykX2JsBh1KdAzlKvqIKINLeA8O7QWMV+U3rW/tNfoWd0fms8M6dJ0YVhRDa8IOg/vMXHxLAvunZsk186q3oAi93EtJwFBeQm3xa44qN5apSswIu7r8XNVM5m3vJOFcmO8NHOvtTrq74IktijJoZqjYw6JLf5LIEVFmXdMJAMD8/BqXLITcm8QylQ7MlaT90MeMOT1x3vMAuoGSoY1qfZ/vKMGsMrwx0FwBNNu1LHOFny7BevEAVPuZUCzlaM69rNkUobSU/2XWv9eWN/db7HNu1Hz00CG0gdbo6KujGLcmlcWm0M6E9keYZn30TzaZ+gOmCUgYKSe35GplrgdCuV1L6Zd6p1ujEoafxLeTyh0v38sVO7CryyCcFixsh7ARJPAYaWLC9xVpUVVIbUnXYPCya72BClyvGdGakzxiq1mLni6k6gEGZ7LEGVrdxnDQvvCnI90uaVksZxx3mveqm8eZOuaXyRrD00QZNm6B2Rpbux63p/VaocfBec1uFVjOUPdZ9WWMK40hGZ9TBwid4ev+wT6mGExmkzow8oMn50RtCH+IQAclajCFQvC4F+6z2N03GFfVu5VPnNc8xWUVDPTK5ZMBTdj7mFdp+z+Db4F1oFBIMhGImCJDyq9lfsoHLiCWkkc5yjSug8mEzR86eH4C8u309iFGOayMonbDMrnz/1HwHZBJ8UC3anRdWSE8BlaGbq9sDXL6RUghB2bTomhK5BEYMHeJg4=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83575601-6cfd-4d48-3125-08db9731a809
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 10:32:53.1212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SojNUq4XaNdCAwfdcI7qhYRgR0aPFSbZcJ7Yf4l9AWKMh4vOn5Yjg8HobhNOdqZzbv8Mp6sPLaY9RAisFPj11w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6304
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=576e22132=Niklas.Cassel@wdc.com; helo=esa4.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMDM6MDA6NTZQTSAtMDQwMCwgSm9obiBTbm93IHdyb3Rl
Og0KPiBPbiBUdWUsIEp1bCAyNSwgMjAyMyBhdCA5OjA04oCvQU0gUGhpbGlwcGUgTWF0aGlldS1E
YXVkw6kNCj4gPHBoaWxtZEBsaW5hcm8ub3JnPiB3cm90ZToNCj4gPg0KPiA+IEhpIE5pa2xhcywg
Sm9obiwgUGFvbG8sIEtldmluLA0KPiA+DQo+ID4gT24gMTkvNy8yMyAxMjo0NywgTmlrbGFzIENh
c3NlbCB3cm90ZToNCj4gPg0KPiA+ID4+IE5pa2xhcyBDYXNzZWwgKDgpOg0KPiA+ID4+ICAgIGh3
L2lkZS9haGNpOiByZW1vdmUgc3RyYXkgYmFja3NsYXNoDQo+ID4gPj4gICAgaHcvaWRlL2NvcmU6
IHNldCBFUlJfU1RBVCBpbiB1bnN1cHBvcnRlZCBjb21tYW5kIGNvbXBsZXRpb24NCj4gPiA+PiAg
ICBody9pZGUvYWhjaTogd3JpdGUgRDJIIEZJUyB3aGVuIHByb2Nlc3NpbmcgTkNRIGNvbW1hbmQN
Cj4gPiA+PiAgICBody9pZGUvYWhjaTogc2ltcGxpZnkgYW5kIGRvY3VtZW50IFB4Q0kgaGFuZGxp
bmcNCj4gPiA+PiAgICBody9pZGUvYWhjaTogUHhTQUNUIGFuZCBQeENJIGlzIGNsZWFyZWQgd2hl
biBQeENNRC5TVCBpcyBjbGVhcmVkDQo+ID4gPj4gICAgaHcvaWRlL2FoY2k6IFB4Q0kgc2hvdWxk
IG5vdCBnZXQgY2xlYXJlZCB3aGVuIEVSUl9TVEFUIGlzIHNldA0KPiA+ID4+ICAgIGh3L2lkZS9h
aGNpOiBmaXggYWhjaV93cml0ZV9maXNfc2RiKCkNCj4gPiA+PiAgICBody9pZGUvYWhjaTogZml4
IGJyb2tlbiBTRXJyb3IgaGFuZGxpbmcNCj4gPiA+Pg0KPiA+ID4+ICAgaHcvaWRlL2FoY2kuYyAg
ICAgICAgICAgICB8IDExMiArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0K
PiA+ID4+ICAgaHcvaWRlL2NvcmUuYyAgICAgICAgICAgICB8ICAgMiArLQ0KPiA+ID4+ICAgdGVz
dHMvcXRlc3QvbGlicW9zL2FoY2kuYyB8IDEwNiArKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0NCj4gPiA+PiAgIHRlc3RzL3F0ZXN0L2xpYnFvcy9haGNpLmggfCAgIDggKy0tDQo+
ID4gPj4gICA0IGZpbGVzIGNoYW5nZWQsIDE2NCBpbnNlcnRpb25zKCspLCA2NCBkZWxldGlvbnMo
LSkNCj4gPiA+Pg0KPiA+ID4+IC0tDQo+ID4gPj4gMi40MC4xDQo+ID4gPj4NCj4gPiA+Pg0KPiA+
ID4NCj4gPiA+IEhlbGxvIFBoaWxpcHBlLA0KPiA+ID4NCj4gPiA+IENvbnNpZGVyaW5nIHRoYXQg
eW91IHBpY2tlZCB1cCBteSBwYXRjaCwNCj4gPiA+ICJody9pZGUvYWhjaTogcmVtb3ZlIHN0cmF5
IGJhY2tzbGFzaCIgKHBhdGNoIDEvOCBpbiB0aGlzIHNlcmllcyksDQo+ID4gPiBhbmQgc2luY2Ug
Sm9obiBzZWVtcyB0byBoYXZlIGdvbmUgc2lsZW50IGZvciA0MCsgZGF5cywNCj4gPiA+IGNvdWxk
IHlvdSBwbGVhc2UgY29uc2lkZXIgdGFraW5nIHRoaXMgc2VyaWVzIHRocm91Z2ggeW91ciBtaXNj
IHRyZWU/DQo+ID4NCj4gDQo+IDQwIGRheXMsIG91Y2guIEkga2VwdCB0aGlua2luZyBpdCBoYWQg
YmVlbiBhIHdlZWsuIERvbid0IHRydXN0IG1lIHdpdGggdGltZS4NCg0KV2VsbCwgaXQgaXMgc3Vt
bWVyIHZhY2F0aW9uIHRpbWVzLCBzbyB0aGUgZGF5cyB0ZW5kIHRvIGZseSBieSBxdWl0ZQ0KcXVp
Y2tseSA6KQ0KDQoNCj4gDQo+ID4gKEZpcnN0IHBhdGNoIHdhcyBhIGNsZWFudXApDQo+ID4NCj4g
PiBOaWtsYXMsIEkgZG9uJ3QgZmVlbCBjb25maWRlbnQgZW5vdWdoIDovDQo+ID4NCj4gPiBKb2hu
LCBQYW9sbywgS2V2aW4sIGRvIHlvdSBBY2s/DQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+DQo+ID4g
UGhpbC4NCj4gDQo+IEknbSBzdGFnaW5nIGl0LCBidXQgaXQncyBmb3IgbmV4dCByZWxlYXNlLiBX
ZSdsbCBnZXQgaXQgaW4gZWFybHkgYW5kDQo+IGl0IGdpdmVzIHVzIGEgY2hhbmNlIHRvIGZpeCBh
bnl0aGluZyB0aGF0J3MgYW1pc3MgYmVmb3JlIHRoZSBuZXh0IFJDDQo+IHdpbmRvdy4NCj4gDQoN
ClRoYW5rIHlvdSBKb2huIQ0KDQpJIGRvbid0IGV4cGVjdCBhbnkgKGZ1cnRoZXIpIGlzc3Vlcywg
YnV0IEkgd2lsbCBvZiBjb3Vyc2UgYmUgYXZhaWxhYmxlDQppbiBjYXNlIHNvbWV0aGluZyB1bmV4
cGVjdGVkbHkgcG9wcyB1cC4NCg0KDQpLaW5kIHJlZ2FyZHMsDQpOaWtsYXM=

