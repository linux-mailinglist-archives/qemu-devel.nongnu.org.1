Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F08137DC014
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 19:54:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxXNr-0001uT-6q; Mon, 30 Oct 2023 14:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1qxXNn-0001tz-EH
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 14:53:03 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1qxXNk-0005mL-UF
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 14:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698691980; x=1730227980;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZfoUSYzF6Di+eDdQ93z2X2BdbnH86ocVlcDh2h4N3rU=;
 b=HQCFbhyGgN5L4qwE07hBffVsUFeKJz6vwXZeHF1ckUBdVh6YBQXE2lNk
 gAIOPBpfz3GpdJHLPRYb3G1dhfK0lsHqRSq+je6Ny6dDgFfrSm9hdLvlk
 sTSj9T0DF+uB332xNx8UHJ8TM3DKM5+mmpu9F4oYl80SugMxFXfbpatEZ
 GqlVqVG0/eCoLug5bMIZJ77a8up51U08cFfYK2ksmwScpptR8EhKTwoU1
 t1CmB0kKUbC92UeHojCSekUJH8ABVIPNSdW+KOxfGNooIe/NaErLBcg2Y
 uafNA+532dq6KT+TSNrG8i2d2tloVTSxIpTinf3ZIMVVKf6AhuA5GpDlk g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="391997710"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; d="scan'208";a="391997710"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2023 11:52:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="1581741"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Oct 2023 11:52:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 11:52:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 11:52:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 11:52:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHSb1DtqtJRbfP4gWIet9jCf4iR4BdF63hvKPPgOfBo5/dxnlR1jsET85oZ9fk+MN4EsztqXCSWNv/4MxpjegSPCrAfONoP0CO3P0y83C+j8O27VjwMu9wCTvp1Y0fi0lj1dCbBHhWO0lmx7pKPUXoTMivoA8nGwb0x2CdmX8jYRugKBK8mx0BZRUtidWkMavdK+tud0mPIrEYzjfLUXc7DWkOF7ql8I1qZ+7ECn3oAi4GpEtZEtv1woLkXc4a7rLE2bh5Mya15KI47+oak8CmFX+kHerhq0jI9M10kPj/CwLHGkD7uh/+Poi8tI+llRu3WlQxzuSnz73kzDbv3iEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8roUcXw36HnUT9ndXNdeHCbgNm5+u5wAkI/CsUZI89w=;
 b=HuMAmt5EIno+dLv/YIQmV5fIOTjTDtzBZEqBQFei1a90NBrrc1iiun03ls6bl5A11HtOBOQYk9m/KzHl2uBM6YNkWHVZ9swsYRAXFXXs5AVuTmPaRap0a/haV7oKvOrjnYmB+DKzP6O28NtuZApzwHxVi/AGu8vqNvhiF1UrDuoMyaD/NX7AyQ7vWYe1nPjRwV0dIPmkIE7+qCeD59J52A+mdHQtNWE9zs5v0xbYpKwz6FvfUdm6Xy9OXlIkV/VDA1n8hfLB/XLk8AWtVCusLwgAYJODkFO+OeFmBcUtLLqcqKZdnY9/R9zX/wQd5gwW+QBbNIHAdeIfJWHriruqFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8)
 by MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 18:52:49 +0000
Received: from CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::bb1a:e610:1da4:e04e]) by CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::bb1a:e610:1da4:e04e%2]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 18:52:49 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Yuri Benditovich
 <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH v6 05/21] tap: Remove tap_receive()
Thread-Topic: [PATCH v6 05/21] tap: Remove tap_receive()
Thread-Index: AQHaCvAzWHK9yIuzeEiWZshrd9xuT7Biq4yA
Date: Mon, 30 Oct 2023 18:52:49 +0000
Message-ID: <CYYPR11MB8432F991FBE071C91C4CCB179BA1A@CYYPR11MB8432.namprd11.prod.outlook.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-6-akihiko.odaki@daynix.com>
In-Reply-To: <20231030051356.33123-6-akihiko.odaki@daynix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8432:EE_|MW5PR11MB5787:EE_
x-ms-office365-filtering-correlation-id: fc9f40bc-2c82-4e93-d570-08dbd9796a11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5KL/C1TDM8g0SGleRA7BjQ5Op6Wv697yxecQNLtfUeL/xBRnYXLYdrkgkN7tme68ZQGU/RHMrkun0Rl2QGjojhyWY3pamXOLxDee9evSpyFzfWE3ynv7occTBTGHpPat2/OAcR/2mJHr1FBRb3mHjqusJVcuufcjywvZ5mM8lyLCM4UKfSUExf+7mPjsgEYZgS9JI8ismeSdGoZxOE418VedGwS+mXR02vd8sF5VyxmQzojcBFgsOT5HsNRRPnL2ALwiKr7Kv97A3I1yGApZ4L73llRb74WWIgga02mDj8NzX0KoWBhgP3cEt7pnnJHVRJ5Qc6xi6AtOKYeyNuJEjFUCO5Tf3i8/aGgh/0yPhU/gPyREB9qDzAnGXSzfee46TcJH2c8f/Yxxd6yKHIo0PuoNSQ6s87b5+RfYO59ewzSq39PNh7M1oiowajHyKXiIaGjftQgBoz6iQKkIe+S6yOyTaKIO9TY3Q5M3Jnbpy//ZmlKqXDej+5R64hA23ncIQI1J6wOYwzwvjNUX4XpvHCA9b/YxI6OKPcSRupVfl/7/od3Hfxvz0Vad/gjZRjdYOLHHCAUctMexFRk9o3Q6UBhAzTxRPw8hgIEwILIRGuDkpO82VhLZPhgls9EiIr2c
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(55016003)(9686003)(71200400001)(122000001)(6506007)(7696005)(38100700002)(478600001)(76116006)(66946007)(26005)(82960400001)(83380400001)(66556008)(6916009)(64756008)(66446008)(66476007)(54906003)(316002)(52536014)(8936002)(8676002)(4326008)(5660300002)(33656002)(2906002)(86362001)(41300700001)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?udqmjV91BiqHp4XsXhJYguD+0IvPPM7oThJbDtqXj/3m9xMQ/rnapjbKeSUm?=
 =?us-ascii?Q?YxQP3Ax5we1tQyfCrlH55YX6bjpoH0ARSi6mecysZyhCIYwe77hncig8i5AG?=
 =?us-ascii?Q?yJrqpcXU4nZjEG2aeYETgAcjF49WOsoKudBsHnCqEEQUSHnnWX8oMCyUsqdW?=
 =?us-ascii?Q?V5Hwr0S91rs2tLFsxtnu0NUT0jYlgd21/OQp8NpML9bJDtyUwWhLSHhbRQOG?=
 =?us-ascii?Q?PFC0i36583Z4hUPRXP7z6X7QcVrBPQ/e1oxg1SZ9XxqORUghcGWuS7MPbMsE?=
 =?us-ascii?Q?BjMSsgKQFKrf2o28JEDN8KEQL+ceXnxpenA77QcqlMGQUi2v2dYh7QimHEnO?=
 =?us-ascii?Q?X+sfbbjm/18MQjq86GqEVf1vaWdJZUfdoTvpxFt9x9eJUxdTVqFrUiIxzU2p?=
 =?us-ascii?Q?xtozGBbbXjLifFQJ8R8T8a2W98pxcqR/J1rTUpy8HwstIQ2k8C2sx0sTZOq1?=
 =?us-ascii?Q?EpQrZIIHT+uNURFaspDts7LeUuA5GF2TiqemlIQRMQhpUE+naqreZhNBqvyZ?=
 =?us-ascii?Q?bM0P6pNQ5SXpJL67qArj0p77QD9a9JR+9IK2LjtvNFDw/6oOl2vCIHVshxXF?=
 =?us-ascii?Q?OHGsUcSi5rq4lZKYF8Zg5Z63refReDwbsyYlEfG5I0/6rEvQf8Bx4sh8NSo8?=
 =?us-ascii?Q?Wbji97U1INOlr5GCx6gkIGK8kPqIn3o3Hzy0iZBobo83c/bbNIQzI1uu/uU2?=
 =?us-ascii?Q?FYgObw2BMW6axnI6v3xAOBlk0kwdIOsL0IU1J2VNq3N4PXseDbA5SaDH+JlK?=
 =?us-ascii?Q?hnG6i4FtbPkFY/41FNu53XQydE3Q/xtL3yCKxWtPajKC6EYEhfXOo5rt+rhe?=
 =?us-ascii?Q?9rmtocYa5R6dkRHqBWScjdzjTJghvLMK+6Wsr+QoMhguROkZWdYFT9O+m6+f?=
 =?us-ascii?Q?VErgQTwusqczg9EXKpS1lUaXrsFYUG+1SL9QzmeGsLOCnm+9xK2ySEIB7CA+?=
 =?us-ascii?Q?v1rpx2gvX9sTYMorsICfPbte477JR5W9H1DfGUhml+zwdM17ESX3uFrcE0Xr?=
 =?us-ascii?Q?hQ97xYLcIJgUqtTYfduCdqYlUULTlEPNeWnvGQmm4n/uivp2afdPRY1x63AM?=
 =?us-ascii?Q?O9/KnHPzY5yHX+HcL6pPCHMG62ArKHNkQmmNmWSKwd7+FqhY6G7nl5IOKORZ?=
 =?us-ascii?Q?vxfGDNigtPjaVl83J5wDd/mUcxGBFYhO3hB9nfiFD9NUHv4nEIhzLR87M6Hm?=
 =?us-ascii?Q?Se7hTBySkRPMHFS0m2JLVIf/msktcQbBVhpEz9TqZwnZTthqZP4V6G05OVsF?=
 =?us-ascii?Q?TgilLwatuvK24qUPRA5DTztrmZYKEdgqGFAsrrS9HVNd8xJtqh1VvMx5k1lU?=
 =?us-ascii?Q?kt4f5pRT1jCAu8JG+MYkv9HVga0RtOLP/4J6x72Og+UgD0Bof3eEiMr4TNZJ?=
 =?us-ascii?Q?WhVh/DIar68EPGQJhw+MMUOEstG4Dl+OJ5qKfspG/k7sjAxD4rF2jg22w1q/?=
 =?us-ascii?Q?ww0jjEgVlY8qr7RZ+TZNwC7djtzBt+TfR6+Q0rA1tdaNWanmtI1DMiZqCwPT?=
 =?us-ascii?Q?SyP4lZJ6+aQeNRsQgjYCJV1RvRDElCTPJ2Cg+ATguV1Psa1dZwSH/YC5UqYf?=
 =?us-ascii?Q?rm7vIybpUbqD5og8ivs7+GbPXXxBofIpV9jGCHdT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9f40bc-2c82-4e93-d570-08dbd9796a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 18:52:49.6706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5LMEeEGDlohiKYBNUtJFBbG99KzLEntoetcrDOX05hIdAwLlWSgpLk2zfkfH4yubltYrkSrIsRUh3j2GKpuiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5787
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65; envelope-from=chen.zhang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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



> -----Original Message-----
> From: qemu-devel-bounces+chen.zhang=3Dintel.com@nongnu.org <qemu-
> devel-bounces+chen.zhang=3Dintel.com@nongnu.org> On Behalf Of Akihiko
> Odaki
> Sent: Monday, October 30, 2023 1:12 PM
> Cc: qemu-devel@nongnu.org; Yuri Benditovich
> <yuri.benditovich@daynix.com>; Andrew Melnychenko
> <andrew@daynix.com>; Michael S . Tsirkin <mst@redhat.com>; Jason Wang
> <jasowang@redhat.com>; Akihiko Odaki <akihiko.odaki@daynix.com>
> Subject: [PATCH v6 05/21] tap: Remove tap_receive()
>=20
> The receive member of NetClientInfo is only for legacy clients and the
> receive_iov member is always used when it is set.

Under normal circumstances we still need to maintain compatibility.
It seems that there is no need to remove the tap_receive here.
You just need to optimize the tap_receive to call the tap_receive_iov.
In the history, we can see a large number of devices still keep this interf=
ace,
For example, e1000_receive can directly call the e1000_receive_iov.

Thanks
Chen


>=20
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  net/tap.c | 36 ------------------------------------
>  1 file changed, 36 deletions(-)
>=20
> diff --git a/net/tap.c b/net/tap.c
> index d54e90f184..ab4e5a0e91 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -133,41 +133,6 @@ static ssize_t tap_receive_iov(NetClientState *nc,
> const struct iovec *iov,
>      return tap_write_packet(s, iovp, iovcnt);  }
>=20
> -static ssize_t tap_receive_raw(NetClientState *nc, const uint8_t *buf, s=
ize_t
> size) -{
> -    TAPState *s =3D DO_UPCAST(TAPState, nc, nc);
> -    struct iovec iov[2];
> -    int iovcnt =3D 0;
> -    struct virtio_net_hdr_mrg_rxbuf hdr =3D { };
> -
> -    if (s->host_vnet_hdr_len) {
> -        iov[iovcnt].iov_base =3D &hdr;
> -        iov[iovcnt].iov_len  =3D s->host_vnet_hdr_len;
> -        iovcnt++;
> -    }
> -
> -    iov[iovcnt].iov_base =3D (char *)buf;
> -    iov[iovcnt].iov_len  =3D size;
> -    iovcnt++;
> -
> -    return tap_write_packet(s, iov, iovcnt);
> -}
> -
> -static ssize_t tap_receive(NetClientState *nc, const uint8_t *buf, size_=
t size) -{
> -    TAPState *s =3D DO_UPCAST(TAPState, nc, nc);
> -    struct iovec iov[1];
> -
> -    if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
> -        return tap_receive_raw(nc, buf, size);
> -    }
> -
> -    iov[0].iov_base =3D (char *)buf;
> -    iov[0].iov_len  =3D size;
> -
> -    return tap_write_packet(s, iov, 1);
> -}
> -
>  #ifndef __sun__
>  ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen)  { @@ -366,=
7
> +331,6 @@ int tap_get_fd(NetClientState *nc)  static NetClientInfo
> net_tap_info =3D {
>      .type =3D NET_CLIENT_DRIVER_TAP,
>      .size =3D sizeof(TAPState),
> -    .receive =3D tap_receive,
>      .receive_iov =3D tap_receive_iov,
>      .poll =3D tap_poll,
>      .cleanup =3D tap_cleanup,
> --
> 2.42.0
>=20


