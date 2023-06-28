Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4E1740CFE
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:32:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERW3-0004qM-9j; Wed, 28 Jun 2023 05:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1qERW1-0004qA-0Z
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 05:31:09 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1qERVx-0005kv-JT
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 05:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687944664; x=1719480664;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sV0QQqjPAoybJNz9AqD/coBdUtWTK5XyxrqTWySlFQw=;
 b=XT/M0029zsKrRAa4BlIvJ9uHkqZoQzqvuumhFd0F3ttuJp10nZ8D9Wf4
 Y4gKE4DtO6w8nqqBzgQ4ggr2tjhMTlTmWigADpqEFP1iAnrq6EbVp6E/o
 WDWb3rCasHPkbK3N0odpWnWxmkKAz6e7X9Qk4xzc321ahOSNuvgqqrB3R
 DA0H+2XgPGFE1FQVHuMCQE7x+IMwqdmFzgSxZ3bAfbdRBfRU7MTxslGmh
 NqlKhfPo2EUkU+nhMrxffxSOPbeEgjGaUR2T9lhi31qc3sZbrQ7z99dZG
 ejjuA2aKP5CAGzwLD8cfsoFo/CHdDZa2adBzMCpVNi/QbIsF7AjufyBRf Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="365256931"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="365256931"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 02:31:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="716876859"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="716876859"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga002.jf.intel.com with ESMTP; 28 Jun 2023 02:31:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 02:30:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 02:30:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 02:30:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtMBtrIymfxsxg/BWoxqLJcBhy3mjdAwUAWk7gPY7CZOhiXqnywacZSbnYGTAayOYpzXsC+gpsU0OVahQqqbxGyrDUEuzwj3aWayXlx09ooXdWywjhuKxRFBDPko5AaiGQCLAb9Tgcbhp38Vp9R9r9u2stsRqxl9XgeK66ISYUMbQ3FWvwVcQir0ehrv8AC3yns3eqnpw2kFxsALE+fP3STFs3kcpwC/Xc8oiWAtfU8jjghmGF735Hjl1LHi8iRqyDNAGibfnkWorvuFRGAhOb98BJvpD4T8DD+rZgPg9SpuIss7EQT+DcTA85v0K3AWKeWc5nArsUUMzZ9qd1H1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tocuFSpy6nfiyZnK1hnfSBINWWmjqrdmeVt7ri4QPs=;
 b=LxIRo9xsLHKZRB5eCjjqlzp8EtdadzW5bfe8wolidXGwuqGvY+jfDLilUYhT/KwCXNTx2IpVtdo4CpRQajDoBCMAcW5SgDhxLvmYBrS+41fngY2qKSxlHG2N31jch2DerllfrhZwNZviUyVYw11buQWJKTyUMM1H4hFauCDtwubtGEaE0xL1DQI7G2/yQDZ5bRWOY0t+bsXy01VAODpm3shvIrEvtDvSR/E/zL0A2dV+pxwbeXcJ90EUsgR6CFsgp+2N77v45SdbC/am/V93wJvowYlmkQXuvU52Dm+deFDgSoMKu6eLf4ybR8LbUt4hFw/0g5ulGaOKR5Vj3dW1Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0031.namprd11.prod.outlook.com (2603:10b6:301:69::37)
 by DM4PR11MB6065.namprd11.prod.outlook.com (2603:10b6:8:60::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 09:30:53 +0000
Received: from MWHPR11MB0031.namprd11.prod.outlook.com
 ([fe80::3c25:c17a:81f3:460a]) by MWHPR11MB0031.namprd11.prod.outlook.com
 ([fe80::3c25:c17a:81f3:460a%6]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 09:30:52 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
CC: "Zhang, Hailiang" <zhanghailiang@xfusion.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: RE: [PATCH 2/8] colo: Setup ram cache in normal migration path
Thread-Topic: [PATCH 2/8] colo: Setup ram cache in normal migration path
Thread-Index: AQHZpQNGpM/ZUxB7qEuRgChVCN0kGK+f7kMA
Date: Wed, 28 Jun 2023 09:30:52 +0000
Message-ID: <MWHPR11MB003138DF49076AFB5C8CC2089B24A@MWHPR11MB0031.namprd11.prod.outlook.com>
References: <cover.1687429356.git.lukasstraub2@web.de>
 <dcc6c36a6225cb883c9d58697351a316b8b285e3.1687429356.git.lukasstraub2@web.de>
In-Reply-To: <dcc6c36a6225cb883c9d58697351a316b8b285e3.1687429356.git.lukasstraub2@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0031:EE_|DM4PR11MB6065:EE_
x-ms-office365-filtering-correlation-id: 9fa4c661-151b-4478-f395-08db77ba5e09
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wtBVi7yCZWrKR94HtRGgUQ6kl1n2XggElnchJ2oPvMpde3j49PXvKJvZOpQwTGCTmgorrEOg/yLteeUCHJoQRBF1WTFMx/K4qGiH9oc2fsucD0WTviTFgFw5I1+4BsyiEK/j6Tb+lAZUvGA9HN4BfZsAEu6D32SoGG7AQ7PEVH1IMjjM9pHzlxff2JMmD9FF6azYTice+Gcnts/ff+JGnZZkR+jgGPsf6MQYIwyQiyxeadCbPpIdEkZJXqMXcHvSwZmqp5O9B055Y5elJyLjSuIn2MaJJqoS39kdplhsJHi6KHaIe06SIfcohyFVQw2WrAWGlPQAQu8+WwQYM9WjweCve06759i3Fj+CZN0UzqEYOb27OLCP6sW1Qk40wQCC1EA+/th4Yrg1WZyox77DIci/+FjTiSSPi+HTO8ZFGwCcyJe8dyZ/eFGT38q08L62z71vp2RibE4qUA1IGVwE4iOLe5fexTlbAYMU4utAy4UtMg+tHMK3mb03okyMEs6PtoMu5smVwI9nJi5+FaW2/9W8l8/PHwjWelBWXbHztIwhE2ofhyUQpqBldA+DDF0AfUIZFRGkxQ1cMxYMMhmjlf9Fq4WAgkPqsrV+triLqs0wSzdomB1dRjRzYT0BjW9O
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB0031.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(52536014)(5660300002)(66946007)(76116006)(33656002)(66556008)(64756008)(66446008)(4326008)(66476007)(478600001)(316002)(8936002)(8676002)(2906002)(110136005)(55016003)(54906003)(38070700005)(41300700001)(71200400001)(186003)(7696005)(86362001)(26005)(6506007)(53546011)(9686003)(122000001)(38100700002)(82960400001)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AlYmP79BBg2x2P38ZkMk7Vj1N4u8iSxmIJc0zDV4gMIpkG35h8N8GOPdFXWV?=
 =?us-ascii?Q?BOxJMmEaucpnnjIIJt9q8BWTRKIOXjHb7oSLHlRKmjdiJKPrwjC8YNytUBoP?=
 =?us-ascii?Q?RPxK+u7ig2Jq3oPlrjuQKnDwu7F4qA7ds6edaBgSzsWRmD2CPvC7N0k1cBPB?=
 =?us-ascii?Q?NVpc9/rkXsFssuvOVkQDydClRg9e/LHty56ZYWWmWNMU4eealK86i2XDr1/Q?=
 =?us-ascii?Q?IyAHF670TOINLF8IP6juNp2hnrha79fmJDiG0v6usMvahrIkIwg2EBTCl76i?=
 =?us-ascii?Q?KZgKpVU/v3kw5xji4sPhXYUIZev9ab5Bs4sr4WC0gkGXSuXtpW8iha4fq6eH?=
 =?us-ascii?Q?kCIh5os8tfVnr76oeEJBbSl9xIExrzfJDh+vdutGDQPc/eYV1oUkZcS4l4m+?=
 =?us-ascii?Q?k8A3bDWKuvcPl430VOxguE2bdMMkRiufVqxPmAMsb0N/7DrASG7XmZATT/Ua?=
 =?us-ascii?Q?XeoiHW92eKUK+giRMWwAjAcyeLzhZy+5plajCfXTlUHsf7vmTlWd1OlwBnZA?=
 =?us-ascii?Q?gzsIZoXu4on85TQ2IA+01zk2VuQqathPi9OKQWVuqcmflANsfnwymRoRt+o1?=
 =?us-ascii?Q?lpI/KaSuKnAGsIiSVpELZDBpaYfFuum2sGZ5ujlvROrIJHlhZUSMIQRQxfD5?=
 =?us-ascii?Q?d2oGuvLFgublBgrAeSWIvGtxN5x4FBRnjjX4AS/GGIsutjuPF3gWXfCJuMjr?=
 =?us-ascii?Q?cBHlU4JIV4UjzKb/x00Xc1oEfG1D34HkWdw53ZWJiCkD8O72CMxaRuHsX1oI?=
 =?us-ascii?Q?F2c+miTyHtat3g3MBqKpUU05yT7qj94qG4pQtUEpja445QwDYwJFCgLTalx7?=
 =?us-ascii?Q?mg7V8hRQ+d/AUSP4vZsUGKezj4fVfMb5T2eJl9THKsVMBJHayUUABp26sXkk?=
 =?us-ascii?Q?H4L1trKC7YsHfJGg7oipZ0W9kaga+wYzGns30m/7sPDINpUPRYKXY3dOUq+H?=
 =?us-ascii?Q?oC472MwrDByqR8vfCyIKStHTUUCKGDLl+bewfz0PeLngn8d1V1S1sEY9S3Ox?=
 =?us-ascii?Q?7u2ynDzyiaNR/FaKoRp39qQpfubXM/f0YgmXsKQrBGxhjNUtKN+4l9U7jOcI?=
 =?us-ascii?Q?QJhuyj++IspWnydhLBXbbTjif8GfTJ1VeGiZOEb23szuvnqEcTyUpYjK0sJg?=
 =?us-ascii?Q?S9PeasENfMa7t/zIKvSeupVoMdGA0lGOiVqaWoT5iRgbJIXgUlnUWAGSgRED?=
 =?us-ascii?Q?3UehPx9D3sB7yy6xK/SRU0H7ed3pKKgOOc1bF/pLU1v68aF/7sezE3mCeum0?=
 =?us-ascii?Q?qPo0SjTSM/NpupnPXnEuZSVpgfDEYfXUVA8w6j8/V6PP2AqK6ITNwUgj1ZyT?=
 =?us-ascii?Q?njtTqnfJ3uTJQGhIVXvfOaS+Ac9Q0jruKBPuMu4jDohWdfJyrHRgC9YSzsIO?=
 =?us-ascii?Q?/XaqgjtzgeKGHpClxfkGw+vWpvCY1ietI8WYbgc2UAAnAZYX60uroc67sjy5?=
 =?us-ascii?Q?kQU7lj94ksOoqbQd0LaCWhq3zZJrmYKE4pPP4njLGKd7pXdAoTO24j8i9Fe/?=
 =?us-ascii?Q?txmQ1g5nFuxkyAcv3fJfwjFkcgwdcrKpQodLKlDUNe5cWsUZNe/FX0THD76W?=
 =?us-ascii?Q?GkuBxLaJJv4MRyj58n2CEJWcgDnEEnGvLWmG1AbF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0031.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa4c661-151b-4478-f395-08db77ba5e09
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 09:30:52.7838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NeuAka9ux62iGwfwBBk3pHbaSmoVzZv46Syfpg5RUV2epAc+StnfZaktiC0c7hlRDEkdD1sysubw4eibbArB/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6065
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65; envelope-from=chen.zhang@intel.com;
 helo=mga03.intel.com
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



> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Thursday, June 22, 2023 8:15 PM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Zhang, Hailiang <zhanghailiang@xfusion.com>; Juan Quintela
> <quintela@redhat.com>; Peter Xu <peterx@redhat.com>; Leonardo Bras
> <leobras@redhat.com>; Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH 2/8] colo: Setup ram cache in normal migration path
>=20
> Now that x-colo capability needs to be always enabled on the incoming sid=
e
> we can use that to initialize the ram cache in the normal migration path.
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  migration/migration.c | 16 ++++++++++++----
>  migration/savevm.c    | 10 +---------
>  2 files changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c index
> dc05c6f6ea..050bd8ffc8 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -404,10 +404,6 @@ int migration_incoming_enable_colo(void)
>          return -EINVAL;
>      }
>=20
> -    if (ram_block_discard_disable(true)) {
> -        error_report("COLO: cannot disable RAM discard");
> -        return -EBUSY;
> -    }

COLO may call here when occur each checkpoint to pin the guest memory, in t=
he Colo_incoming_process_checkpoint().
Is it still working after move to the "process_incoming_migration_co()" ?


>      migration_colo_enabled =3D true;
>      return 0;
>  }
> @@ -519,6 +515,18 @@ process_incoming_migration_co(void *opaque)
>          goto fail;
>      }
>=20
> +    if (migrate_colo()) {
> +        if (ram_block_discard_disable(true)) {
> +            error_report("COLO: cannot disable RAM discard");
> +            goto fail;
> +        }
> +
> +        if (colo_init_ram_cache() < 0) {
> +            error_report("Init ram cache failed");

Change the code path to here need to add COLO tag to the error:
error_report("Init COLO ram cache failed");

It looks here removed the original  migration_incoming_disable_colo(),
But maybe it's OK for goto fail directly.

Thanks
Chen

> +            goto fail;
> +        }
> +    }
> +
>      mis->largest_page_size =3D qemu_ram_pagesize_largest();
>      postcopy_state_set(POSTCOPY_INCOMING_NONE);
>      migrate_set_state(&mis->state, MIGRATION_STATUS_NONE, diff --git
> a/migration/savevm.c b/migration/savevm.c index bc284087f9..155abb0fda
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2302,15 +2302,7 @@ static int
> loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
>=20
>  static int loadvm_process_enable_colo(MigrationIncomingState *mis)  {
> -    int ret =3D migration_incoming_enable_colo();
> -
> -    if (!ret) {
> -        ret =3D colo_init_ram_cache();
> -        if (ret) {
> -            migration_incoming_disable_colo();
> -        }
> -    }
> -    return ret;
> +    return migration_incoming_enable_colo();
>  }
>=20
>  /*
> --
> 2.39.2


