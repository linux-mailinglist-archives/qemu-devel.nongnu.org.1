Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EA67DC032
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 20:03:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxXWk-0003Zt-Qu; Mon, 30 Oct 2023 15:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1qxXWi-0003Zf-Vj
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 15:02:17 -0400
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1qxXWf-00076U-UN
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 15:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698692533; x=1730228533;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5EPawMsuqubxIRxeNnZVAUnnXaobeEoAuPJZ3TFD1Zk=;
 b=j3T2T9XsN/URoUrYMuZkPypKdQujMJcJH/fPQ5+pZUyNXd6enwwwjQlt
 aUoI8mcpgdor3SSET9oYzFtZ9cXXYDXsf5mNiZQCvSBXb2zMpM1a2KzzM
 7abKSMwJWjc2AXSoyIl4tFYjsKPNndDIZIjJIzgrYZ69Bw3jK8jkPkvdC
 PIhNF+a9AcEwM3NoVOdPkT2D8JwzGEEYq3m+PlmSZGBc5bkUcHTf0RQHy
 IvYL7jDxcbfJOcRAJ8rLbeJf6h4CtQ4v5WGSorvr+KzI9qFc3RS+vtkXB
 KgoNuDJJWKdrnF30ZxOfZOZOQpCTsobeheGel+4/RgKIheAUoWxxxDebJ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="378516711"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; d="scan'208";a="378516711"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2023 12:02:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="1563510"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Oct 2023 12:02:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 12:02:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 12:02:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 12:02:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ayiue0hX96scGkm1+awafVGApyzcOgLzETk+uveg2aP+7rv57ympg4epBrzoRDjaGrFIpK0NO9rC/rzGWCFuBl5aOM7Ehs+So6Mf6Dt47j0AuA9Q0wo2thjUYMQttWFjVwEJhMWVQAB/VQs/nWRlpbmaYB3nZc5jdHlFAnX07CbpmMKvE2sn1EklAq9Wg9pOg/CUOCq63iXxFA2ar23bGZkioBq0QfWntzssRlRL7sS3PtOSkO2wysvV85UZZD2UZVJmz4bqCehkvRVgqSMCUCDdxqDWhGQQDBmnDYDMfLhwax66XIq+d2hgLHyH0mSMVnXStEyoUWwVyUF93jRbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ntvy/nvgEa4AV0i8iskVbBeHFoFv5LLuNBcPk35gN9w=;
 b=J9iLsq2547WYvNFAT2gU6uawb5plrl8Z+NHXo6s6a7NQh7fg3OnxL1qQrIz6nSiuzJtG0fCQAtzvVo6DImKmK37Ua8rrVoNkVf4a8gS9lraHubfhKmIGWWEqyURkm/mdcD8h0cVUlzezFlwxnnTBHJSezBk6JY7i/pMM0suPauASnzhfPWP8DSZf9yjt+DYlPwb8sCf1kCfTFlh1CUESldFv3aZTpLF/dGv3H67nMHpsFoHDae0IsO2ucWkQFnpgRHQO+lyEWbT0TCgFV0N+cs9JwlFRpLWcyINO60/BM2yqqFpnYRJzriMP8+tvtL/TdQ3TIvH6/92DtVcKq8w8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8)
 by CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 19:02:07 +0000
Received: from CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::bb1a:e610:1da4:e04e]) by CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::bb1a:e610:1da4:e04e%2]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 19:02:07 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Yuri Benditovich
 <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH v6 13/21] virtio-net: Always set populate_hash
Thread-Topic: [PATCH v6 13/21] virtio-net: Always set populate_hash
Thread-Index: AQHaCvJdRuvtYxd/lkaab9vqnm6T/LBir73Q
Date: Mon, 30 Oct 2023 19:02:07 +0000
Message-ID: <CYYPR11MB8432DFE20351884E5BBA27669BA1A@CYYPR11MB8432.namprd11.prod.outlook.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-14-akihiko.odaki@daynix.com>
In-Reply-To: <20231030051356.33123-14-akihiko.odaki@daynix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8432:EE_|CO1PR11MB4865:EE_
x-ms-office365-filtering-correlation-id: 626da9e7-2aad-4714-dbf4-08dbd97ab64d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q64ONFD9ClDsQhwuF4WWxrmb2rt17tCHornILZto6GXaaNgOdowb4bjExmLsgDhCICirCab41e8nAwetABgJWTz7wgHeBW8wxTDJZ0LRcGGp8A2xxqH3293/1EAUwSqcpXjVeiJifskT4PWA58FZM96rCwX1tSsKczlpiIxcVwbCb6/RDK7dWd/Cgo3/zftPrEi2E8+NhubpKmJCw++DzcmiuGRuAjP73flgXjq3Sz9sdOPl0AeWVvXtE2W/yZeic6llTg2SDF5wEpA9rI5gl+nKVG5PI/W/6iKvHQOZnzQIfM/jz8G7vyKzuzTjwPvzItIxbh9kch2CNm2NUOFPDoi4587MiUkeRkazC736bAvJdDlBPAmk760sw70XQb4Rnyn8w4du9SpDfiVIEQw0q2slKqvxx3GbXwYkqd8sz62UvyzeveWxf/KiFGFiTUEe9/HFgk9v4SlvMBjSmpREf30FD0zHTZKsVLyrVlTGNEaAAiQaQbYQIfj0q3yqg5fMs03QSih0Fik+XgJ/kvPEk3UJnTTLK9DxNBaUTFG+q09xxQOEs8BoYCJ5tTuPNCBTqLf8uHtz22Z+RUcbwtEgxSf8um8eGklRoEjnRw1HpxSQq3zo79aHAgqd4CwZGMV+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(55016003)(9686003)(71200400001)(83380400001)(478600001)(7696005)(6506007)(64756008)(33656002)(86362001)(38100700002)(122000001)(82960400001)(5660300002)(6916009)(66476007)(66446008)(54906003)(66556008)(66946007)(41300700001)(26005)(2906002)(52536014)(76116006)(8676002)(8936002)(38070700009)(316002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f5i9fYT4f6SDYli42l5ViEhGcFuzU0IiHMVzz1AvMBZGRaroUPsFXJG/vrRe?=
 =?us-ascii?Q?0WW+JYmZQsK0aoEntRk5Q84IJDp/hpBLe2WeCNkbtLsTsFsaclAWjeatpurQ?=
 =?us-ascii?Q?2d4N+WP0elUVRYVHVWrAr6aJvfUxv2y7mJYPncypy0kNaUixa2JKFeI95RA+?=
 =?us-ascii?Q?NYGsqRjAhTUGh2Pjkf9vGNpu47ZqdQPwP8S72Qwg9tTGk/h44cHdxFfvhBtu?=
 =?us-ascii?Q?ccO6gQ/qS8AS8IvlY1rvk14mEqUQPbISL/+G0mMbapbKAgQVupzTEKldthb2?=
 =?us-ascii?Q?AuB3SWA4djCQ6EgMtPA9nSpgKRqw+RzpsF9nE6nPADodtoyPBKNlv1exTgpv?=
 =?us-ascii?Q?utE1SaiPEsijqEH5yVqsxeHKGL76gDkqzZ7kyF5E1IC8C17XlQaHXiBXCJNG?=
 =?us-ascii?Q?BuM8U9mxSrbReGqr87nmXyMGUl1Ka1yCUzYdSq0ioHBHVnE26gYsCkcVpldh?=
 =?us-ascii?Q?ZUIIBhs1ogMUC/iu3OjDs/8COre2hZ3U12ZDJoy0gpVv1R0quzPD5cUSmapK?=
 =?us-ascii?Q?yfaa7CTyWtNnUURXHJkGzuP9E4dFUTtwhhHy+fZ5XTPHGDDU/Akz38nGcOoL?=
 =?us-ascii?Q?xDCn2k+mMWeiJklO2lXVFqhRQqWHH/IRZKhXoSiAHzlILRSf8O7/KcUXrGNL?=
 =?us-ascii?Q?0SAlxB5G8+9AT78jJoUr8y49bpcBqqepTDbPonyHAr0AsLOo6L8hZq6K+ruq?=
 =?us-ascii?Q?ZtqeRHqsC9yjMeDlMGH3f5wqVBOEgTV81K1vR6JKZpASK+NZKyWwQfo0UFov?=
 =?us-ascii?Q?JjDoZKl2eNEw07CbAmEGuCw+mf3HkNOWo82fxL8jQvNhtpcoB6MaJkqSj4RV?=
 =?us-ascii?Q?tz8ND3tuLQgkGSUSA+qfVQEfTmYcmIqMbmewZXFfjWIcQE5dhvZuQXvFj8Lb?=
 =?us-ascii?Q?q05zIOA6qsvJuy9Dp4SmHJPtQ8wqOo/jDQUrPa2+m8YnYrWiXTdh89QDcVF2?=
 =?us-ascii?Q?Nrx5t+oNsYoBcZ/hxtoJp40bv5NOlZTtA6AZ6qz5tzqcL/naM45Rb9kURExX?=
 =?us-ascii?Q?DyFDwzWECRP7fRgjlApY1iiI09X30uCVc2DNF2nXfjvPv+unMjlkrRaYjYm7?=
 =?us-ascii?Q?MoDeCE/dypEDUMVpCygQ1XiuwGRUqQwFdUnUjvSOLK4M5oS7uGr35ABMmTEP?=
 =?us-ascii?Q?5lrTZ7P+7w8TsvZBWaSde6JyENTlYvST1M5M24uAUxk5OZ9/grj5SrZhlomn?=
 =?us-ascii?Q?VlG1HrMFJF2edF3SjzfQxIbRy31O+cLWqAejrCN3rVzaplp4PGgwSt8KVRcu?=
 =?us-ascii?Q?xxF1q+kznzo8K1SVLwVSRJ2WIVPt7EBG+C4DqLFJ9pkEYdjfYENKif25sv27?=
 =?us-ascii?Q?XoxyBosTUblO5Trriix+MjGT02PXWHLqQfEUGbWUZ8Ja0ECUaMBajTIsHPFh?=
 =?us-ascii?Q?kn2FNBg/ulDMSHcn4gfb6lJs9uWHD7oo2um39LWsiHQeuDpM4YgNVt6NhNNC?=
 =?us-ascii?Q?wmJ31kvosbFTzKC3OxYZ02pdSwUsYvitGAJXe+92iq7sLxroUjpitgwrRN9X?=
 =?us-ascii?Q?QWoDZkXGqqpnyq3fTMhS7345GqG02VNYGqbaeMaObB1gakINJdTzyO/TIOxL?=
 =?us-ascii?Q?VB8eAoJyYp4uDkvQJSYFb46pR5g77QvKwL3KF9BP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626da9e7-2aad-4714-dbf4-08dbd97ab64d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 19:02:07.0848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EonthThlcxfg2eYt02yaWq3Qh0eMQ4vmqhqq3Udi1zxi20lO89Had88tMFh5C4UGchZ42aPdispDxIBPZgwVVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4865
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=chen.zhang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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



> -----Original Message-----
> From: qemu-devel-bounces+chen.zhang=3Dintel.com@nongnu.org <qemu-
> devel-bounces+chen.zhang=3Dintel.com@nongnu.org> On Behalf Of Akihiko
> Odaki
> Sent: Monday, October 30, 2023 1:13 PM
> Cc: qemu-devel@nongnu.org; Yuri Benditovich
> <yuri.benditovich@daynix.com>; Andrew Melnychenko
> <andrew@daynix.com>; Michael S . Tsirkin <mst@redhat.com>; Jason Wang
> <jasowang@redhat.com>; Akihiko Odaki <akihiko.odaki@daynix.com>
> Subject: [PATCH v6 13/21] virtio-net: Always set populate_hash
>=20
> The member is not cleared during reset so may have a stale value.
>=20

/docs/devel/ebpf_rss.rst:
populate_hash - for now, not used. eBPF RSS doesn't support hash reporting.

We need update docs?
And why not clear it in virtio_net_reset function?

Thanks
Chen

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/virtio-net.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c index
> 1fa020d905..0fe75b3c08 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -650,6 +650,7 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n,
> int mergeable_rx_bufs,
>          n->guest_hdr_len =3D n->mergeable_rx_bufs ?
>              sizeof(struct virtio_net_hdr_mrg_rxbuf) :
>              sizeof(struct virtio_net_hdr);
> +        n->rss_data.populate_hash =3D false;
>      }
>=20
>      for (i =3D 0; i < n->max_queue_pairs; i++) {
> --
> 2.42.0
>=20


