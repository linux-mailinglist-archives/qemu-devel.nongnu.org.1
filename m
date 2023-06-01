Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABFB719F03
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:04:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4iuc-0007Vo-HF; Thu, 01 Jun 2023 10:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5095203fe=Niklas.Cassel@wdc.com>)
 id 1q4iuQ-0007UI-QV
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:04:16 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5095203fe=Niklas.Cassel@wdc.com>)
 id 1q4iuB-0003cG-Jh
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1685628235; x=1717164235;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=DhxDorlfTWB82JoBKw771S3Xz+aIptfXw8JM08wOIcQ=;
 b=BtBsL4cKFx3iJy4YygI21wjx8UZRM/Jq58dhg6Kyn3Y2DV5MfMGYa/Fr
 VVcp6g3bJ0ZcwD02q88mZ3ZsvGae/2Ovp+OgboTh9Uxv9qRiLpR07Ev4F
 spab61ZZYsBA5DRpdz/YFN0dZuqqVNILvU+2jFPzyWRO8Ajx23YrGmK2e
 215HjITNg/1Bii2mq8AUlzD2SJRxgxze6zhAuKSC+ip44UMjpdP3A184s
 +6bkHUTdCVc7QbKuSsV6TtzP6CkiMfAIfYQWBAXDsal2WXVFDXFDEYCeK
 0zaRngwTVW/3YjSUeowCb3SShqNzQ5VnvhNm5TpuvlK1d9SuPAkGDliow A==;
X-IronPort-AV: E=Sophos;i="6.00,210,1681142400"; d="scan'208";a="230310537"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2023 22:03:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJ3/Y8hi4oikZb1xbPiJIhYlC6FmqPB2JXUTQZyDNTmyYwLwpJNTcOQ8J/pW59LZC+ulDZlztU7wGnTqDfJ5EInTWh0IYZv1xOp4bzdGzyD0ElhlYMIAfIqsQaqnkO86QQvEGEFP0s9bNwooJMnIWSMPaGat38tLwMG1qReCvzJQrhnVlwOu+K9tUlgPYVBpaKsMwb6PHLLtNT8M8iT3YzAWLffnM5R/rxgay8lSuKUvbQlQw3OaLCT6cpyx7yuoQ4E6oS32UaKyDEaolKGjmj6+h5QUFCXrIPg6wyBWHJGVXVRAin4S1jGVQvKai6a6YfRwaHNREE9iG5hemce9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhxDorlfTWB82JoBKw771S3Xz+aIptfXw8JM08wOIcQ=;
 b=aLlVI5KeXQHqD/cXVl4rABkj0H4Vev8FPsQ4tfXJsNKlMK22ua83xhz7UHMgUZFy/RMIG3s1bzk/hpy6jtdH8uKDlDl4duUvckH87a+zaByhTv61UUDQU6mmT7nUq1IXioDOl1EoKBd2ZEK9LBw7tTTNeU7XOzmJyUfc5SkOuvR3h4hdnBHvDjll2zTFlnaNuFW58oD01e25EWBT39WZQBODKNnH+dklrbeKu4VshPTO3KX3sjSsxSDcBrvk6RkiwUJA7uywcPseMIQP9t74MgsongRPslbbTC73fcYCRaX3ewCTZc6ETuiEzOrnTFt1En8xrGNBCXn3WbTAVgaZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhxDorlfTWB82JoBKw771S3Xz+aIptfXw8JM08wOIcQ=;
 b=aKDesTTo2kKu76kzMq2br6klOp5lEoCU1nO5dVX4k0yFFUsG7xiTOTcA+i8e5f9xGHRujm8KfDfQgqYa/aES/S8j9ljjyg7jLoGxOWPr2BsmbxRes0xhM3MtaEuB5k8mYHKIbm/lu+bZn6IS7jB1GEKwh0rNZxRLAIdqCQk73rQ=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BL3PR04MB7962.namprd04.prod.outlook.com (2603:10b6:208:341::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:03:42 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9%4]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 14:03:42 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: John Snow <jsnow@redhat.com>
CC: Niklas Cassel <nks@flawful.org>, Mateusz Albecki
 <mateusz.p.albecki@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Mateusz
 Albecki <mateusz.albecki@outlook.com>
Subject: Re: [PATCH 1/1] hw/ide/core.c: fix handling of unsupported commands
Thread-Topic: [PATCH 1/1] hw/ide/core.c: fix handling of unsupported commands
Thread-Index: AQHZiQcxQRCdXBLmFEqSuG5cGbWzva9m00OAgAEicwCAASijgIAAdjKAgAx9I4A=
Date: Thu, 1 Jun 2023 14:03:42 +0000
Message-ID: <ZHilPUjfC/lJ2ubA@x1-carbon>
References: <20230416222838.36642-1-mateusz.p.albecki@gmail.com>
 <20230416222838.36642-2-mateusz.p.albecki@gmail.com>
 <CAFn=p-bcAW9aMymmWeVSMeyuT88YDZ2iYVh-t1GoogbBBPFjSw@mail.gmail.com>
 <CAGe=PKEvnnjBQVx-rNDXjmwvQ272S2DLw-xEDjp1vVuU30i4Hw@mail.gmail.com>
 <CAFn=p-bVdQ6E10F9FmapMcBvEUMX7hOjr-kz7FgfQL+cdJHV+A@mail.gmail.com>
 <ZG3II3qlIjmuSZzm@flawful.org>
 <CAFn=p-bJM4GpAg=U308EftJCzjAUYOh1exm4Cuz=6FDFgUuHHQ@mail.gmail.com>
In-Reply-To: <CAFn=p-bJM4GpAg=U308EftJCzjAUYOh1exm4Cuz=6FDFgUuHHQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BL3PR04MB7962:EE_
x-ms-office365-filtering-correlation-id: c4419e5c-6e87-40d9-59df-08db62a9021a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vkXwRo2rv3Qhhigitox2WOA2Grb3+aHtB2bwuUZdGZJXOCJ64y52Sx7mQDGouABasT+DMUHxeuBxNqGBQdNzFwIj7wy5s5tVFBjd4KCEl8hd0UWzPG7H45qhmFfeHok+5TMuYfIpognc7u424F/dWpd27kC72QUy07QQBjoollkRMbj36RuAVxgKYlSe+x6/VM0rvZ/Pr1cZoVQ4t+jYpW0IeKzpSNjXYl0A3L+vEU3frUePFY8vCBqdTMtfCKiR5qZ8/pGzs1VytXPrhwlRaBgQ8sWd9eabuu8eOqOa9Wm2Om2hMsWuZykcAd4GjPmiuqEaeyb+SUUcMoktTPuTVk0NgkkWyFOTMky/mGgMSEf98DCie+oqLnWwGth6VEg7xWJvhSXyMViFP0qn42aVEL+GwMfH2oSY/pZ0WUuY8MNWBgtOWYc3Fkp0qcJIopQ2jrauN/PFjpkxStTAYvmcwSjLIM4c1fibijuP4EO8XFLyGkZaFd3iq+eS2YUqmG9ZrrNV6nHVD7RQe6hDsY8QYJSj9UxWUhUnvRSq+EsT27HHPWrQg1WnILeRQrg0ypdmNgHxy8HE4BIWNDWRciOKEnSRkX2Ngmssel8pDRSUIsc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(41300700001)(33716001)(6486002)(5660300002)(71200400001)(186003)(8936002)(8676002)(6916009)(9686003)(38100700002)(26005)(6506007)(966005)(6512007)(64756008)(4326008)(66446008)(66476007)(66556008)(66946007)(316002)(91956017)(2906002)(54906003)(76116006)(122000001)(83380400001)(478600001)(82960400001)(86362001)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FYYiCooG0eo6OmUugYbOhH2MXGNVjceGBIdI+Svtov8ktOHt0N3FLdtmygej?=
 =?us-ascii?Q?XBnEeZ1tsF2Yp6awOaJbFUzMmF94rxZf1Vp4d2d6WREhBJ0Wl1HVYoevWKdV?=
 =?us-ascii?Q?yrdsT4W1AyAoYjcyK3+UfbPKJlIx3MHYoBd//ulmVgDYVJCBiG878lIkeT+U?=
 =?us-ascii?Q?Fs8JJbUwRExptaX5vJZ6fCSwEb7xEqJZYDNBjlvLsq9gPGC9mDf3c5Bu5n2G?=
 =?us-ascii?Q?QEre3D5WIxFZFLmBqJxdBxc6V5KcklOqW8Cp7hUTzB0r0Y/SOeCNOg+jUwsc?=
 =?us-ascii?Q?x6xI/k/tMWgrdPT2eu1Y/sgEGwHkn12F+UD5k3VWfW4kbno60dAOUMYPPO0g?=
 =?us-ascii?Q?dM+0yTFOLMQCKqyuV9W6d0XM44s8FAZxIuJ8HpRoNseYFMYaNJkEn5o9+nHj?=
 =?us-ascii?Q?UOUzL41Hu7rU3cwv3nOSOlYimO31lQjJLu6kUE6RHQ74R6sIpPPrh/aBDKC+?=
 =?us-ascii?Q?ggDnmhag3+d0QlW/k4voJtbJPcGd5Vo7H2EEbzXlaFAB0VRDFVyDPJXILcDK?=
 =?us-ascii?Q?0mju4ZjAVGVFi4RJgtr+WFUU86tpiPLRhqECt62O/0bzd0+7S291oPE1XpjW?=
 =?us-ascii?Q?cXAvyUBrtwNFrZyHWGdGrcfF12LF9bCV0LBCuO4wzzYIzU3NXqnWgBAU6g8J?=
 =?us-ascii?Q?8g7S8LGI5fAiWUjt5dPnMXGCiZRJQxS4SbdFLFANfRcpH9lHON9G8lz96Cuh?=
 =?us-ascii?Q?q8M6eoTEwS/FOafFvkwEDSPSjmqJNOzMppWF96mvQLVlIx/QXleVx25lz25Y?=
 =?us-ascii?Q?ZN9liDzNwBKHPXXyOA2V+NTcfUEpcPyQdck+eSH+eQhsL2wpnm8+W/NuvHnB?=
 =?us-ascii?Q?9fyk/rY16FdtDp0JmigboS5JfQHPRpSsDSZUPJG/JG3jHl3V6ruAq6qfIQWn?=
 =?us-ascii?Q?JXesSzyKs2M0M6S1tYrZfo57hxTG3u1EFNtcSTa9MaGK+cJBEUdCqh8Ir17t?=
 =?us-ascii?Q?LItrV3sPKqd7Wt9r7Rjotq4M28pedBA/XtBkYKMnTZvhvmy0YRosJNCrqT80?=
 =?us-ascii?Q?MDPdC+95UJwZdVyuyYD518CPodavYSy5dQxD9ICaZINYbyEkvcX2dlh2d27c?=
 =?us-ascii?Q?yHZMaoDrsgMJa0ZLL8hIz4yK87Pp7W1eSvmtvRf3+iJspivkr8tW/JgG6tiq?=
 =?us-ascii?Q?whP9OEYWP7iKurhwpEcRTfipxbwgdXIDRWOGK205nWZx6uV3ZoMDrFy84nWO?=
 =?us-ascii?Q?mdaaWrvsT+5Y5dUSpJ5aHd8Wol+2n2o68netokDH2tcHtpyCYkAEtxnMB8TV?=
 =?us-ascii?Q?JNq3LAc0poEvtH7KU6Pq5YeoM0018E20UdfIJc4gdixlwNKDMw77VKQfJFRC?=
 =?us-ascii?Q?dWC8kL8PLCyJx2YjB9aDoTJYKwq4qTITNLpUIo+4PTjXePDknjt41Axtikbn?=
 =?us-ascii?Q?kISau+FM0jgw/A+2d4EQsdci78FIQY47Beb60EB90fF6VRnyqsw9PzBDqz+o?=
 =?us-ascii?Q?4oSrQ66vAryyLXtetmf+Qmz8jOxQJada5MJ3jEvkdBccOL2BQc9cwhmP0TVM?=
 =?us-ascii?Q?REw+7LVXcPq5KSySunKxkCkMPP0sz5s8p9rz/gAaR4BsUtXOdjdygbwFUUYc?=
 =?us-ascii?Q?Rp2YZGpMRILWv34wPnOx8Sfkx9O1TiNwZ9OUbWxnE9MveV900vGUPRoXBiwp?=
 =?us-ascii?Q?2A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <951772299248D04C99D4163A0A05FD2A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PZny6psQX0OAfCZ60kCvpcxXk4bwCzHkcTpf6rCXN9QtZVec/u9nRnfm0gxLcBRh/FUve0jfcSNRIZVjaM0tHUpUPcmRovQQY19bWTIc7HE+QWVs/tDYTahC2ALMr2srN1zHt33tbJZQvqEz7hEkQ3Zv3ylkNeKBh6RZWyfcUt7mzCcW0NgZNPhG+v5CaWrNo3OMHyEGYCMA5OqI9Ia/oTp/U92uY+PtnNz7YASPmnqmlfAQFMHJ5/ERR5K2/evqrYMy5AcVIlaelObIY7eYqrBAYlJF2W1sNVnRM33SQ2KNVcwpW5utZwjTS+yd/Nv5Z4snq9oyWtsOe7S5BJSkkGg7bLSzuiPggAQ87LBxwZTGTKaPQkzDE7QssQa9r/hlFdazIjnQztg2KtSykIB1iKilivDXRkE+E/Whcslpf28ERGtkl3xUa+61hnLI6tVvW2BxgqmHaz8jAOVyMFxdejuNw++wPCcbxrBG3vFwqxlDemDkEHPksjw0VLKGRSYnJQjaWe1WbvwOOjOikxQ+gaNYrtTZKlFextpFuwtmpq0bTMBIF630H2NiXlRQNcz7dhf77363id+2hNlh6HXuf4IRV0Xkhfm6YHSQOvhg7MfeFVEiAK7gbj3u8l6eOhHfN3RBVpEiR7KmoJjwygMypoJQK5Srx2YndHLIRFocabND4vW2NS0ZRcxvt50GvQG7wQlRql6EpwkWt6ulOZ0sMe/ok/GuvqmwJBWDz/8iZWCsE2BwMJU6y5xOBR3aAZRPYdIt6gs7OeLxJAwkS6Hctqu0RV8v/HESLYlJBkjjZE9GybaiDfliQt/6Hft4WE5Pi74b/oegcJ4cc3Vh8bpYTXjwTz0GJV4WQrNM4OrIGuqxglSTcYNOZVIKLei453Ah
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4419e5c-6e87-40d9-59df-08db62a9021a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 14:03:42.6808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lndyegvso8YchwVPrYyKhYHDUAMYH+nK9bJgVNsrBoQk9ALdKhgGbIa0333M+Guw16Ivmqta4gyD7mHkKk1hUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7962
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=5095203fe=Niklas.Cassel@wdc.com; helo=esa4.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Wed, May 24, 2023 at 11:20:41AM -0400, John Snow wrote:
> On Wed, May 24, 2023, 4:17 AM Niklas Cassel <nks@flawful.org> wrote:
>=20
> > On Tue, May 23, 2023 at 10:35:56AM -0400, John Snow wrote:
> > > On Mon, May 22, 2023 at 5:16???PM Mateusz Albecki <
> > mateusz.p.albecki@gmail.com>
> > > wrote:
> > > >
> > > > Certainly seems like my patch is wrong as it will make the abort pa=
th
> > > execute ide_cmd_done twice. During debug I came to the conclusion tha=
t
> > > ide_cmd_done is not called at all as I was getting timeouts on the dr=
iver
> > > side while waiting for D2H FIS. I am still not sure how I was getting
> > this
> > > behavior if the problem was actually with setting correct error bits.
> > Even
> > > so I think it can be safely assumed that Niklas' change will solve th=
e
> > > issue, I will try to verify it in a couple of days and if I see any
> > problem
> > > I will come back to you.
> > > >
> > > > Mateusz
> > >
> > > Great, thanks :)
> > >
> > > I'm waiting to hear back from Niklas, but I'm hoping to take their
> > patches
> > > this cycle as I think they look quite good.
> >
> > Hello John,
> >
> > Unfortunately, I've noticed an increase in boot time during
> > the initial SeaBIOS part of QEMU with my changes.
> >
> > Will need to debug to see which change is causing this.
> >
> > I'm at a conference this week, so it might take until next
> > week until I have time to figure out why this is happening.
> >
> > So unfortunately, I think we need to hold off with my series
> > for now.
> >
>=20
> Shame. Feel free to resend it once you've isolated the problem and I'll t=
ry
> to fast-track it, since it'd be nice to have my more embarrassing mistake=
s
> for NCQ fixed :)
>=20
> (If I become hard to reach, please ping me with a direct, non-patch email
> so it bubbles up to the top of my inbox.)
>=20
> ((...by the way, what are you working on? What motivates the interest in
> AHCI/SATA now? Can you say?))

Hello John,

It is simple, Western Digital is still selling a lot of SATA drives :)

And we used QEMU to verify some of the support for Command Duration Limits
in linux:
https://lore.kernel.org/linux-scsi/20230511011356.227789-1-nks@flawful.org/

Right now, I don't intend to upstream all my hacky patches to QEMU,
just the things that might be useful for everyone, e.g. GPL and NCQ error l=
og
(and possibly Sense Data Reporting feature set support, and NCQ autosense).


Kind regards,
Niklas=

