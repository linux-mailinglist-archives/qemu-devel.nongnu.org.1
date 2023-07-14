Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC707536C0
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 11:37:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKFDN-0004XZ-4K; Fri, 14 Jul 2023 05:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qKFDK-0004X3-3N
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 05:35:50 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qKFDG-0006yZ-TL
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 05:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689327346; x=1720863346;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RPvLhJSM7D2Qxv0M3aEPHHbIGM0InE6Ea0bxc2LnFIk=;
 b=jQNw/aR3Fq01zC6j8gAgwMfxo1/hOWFBGWJzv300qYZEEvJygOX5x0BE
 rx+PJOGmif6zjpaCo/9rc4JEVjGGe33mQQCu2KM9To0DKzmZbV2K3RQTZ
 xNLMrNRiyAn1TOKVNCttAV9H8UGoNsyP53DrSiA6woj/aJeBhmMSh9M9z
 22VluuUHf/qw6ayAmHulxXkVXG82/WhUXBz9dfrsLWET5SlIgMh7FCcqX
 HKQLGCzYs1gOj8A90lRzgM66dSD18dYKN33nAQCH0qpyNYQ3oHdd0Dnhi
 lVwdIDGE1AdeF5TetqHWPsHu5yAphL2/uXapkOWnRneFzpwe4ffyKeUi3 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362900749"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; d="scan'208";a="362900749"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2023 02:35:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="812364669"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; d="scan'208";a="812364669"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2023 02:35:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 02:35:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 02:35:42 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 02:35:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfLrDGA7NABahyqEUN6wVwHMbOTGMzzXQQw4cXOjujHzfQYMsKiFLbBLB/Mc0w7uYDWvv4EUXhjbimnRs+0/ox9K/kMsc9p86rtvLaFjYXqwkPD0y3h5hf1Xv8mpwTG/94QVztq9OX9xz/WVmjUdtV0ohYMzjInSDuOdn2jLUBOz3Z16TQekKHElCxpoIrCzjwtqEj6ptnY1zqVlRvmSGupO341Fh/hXofMeqx6p3zI4UYZhO737w7S/kZGUBePOQOmB9Gguwq6Z+fTt25lzli5vJjCGobhYa9gNd3Szsgt08oNn2EhHBcd3SJR57J16D4MVFeH6SFIfz4IAWmKWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkDvHa/1U5aF+tvdCypQtzcLTrFLgi4sAT9yhQ3JNO8=;
 b=H2tBc8+c9MSdT//kcd7f315cd4HvH5B28BDuHZHx6+XUJMoJWphygYQZz/pJRD4i6i4Ks/wLbDH9qktpe0Dn+biFh3k5zKzC3Z7FXf8i1OIsny8IyCCNi1wpFdbqMhazmXrozI0VNlXdQmctJ8fHWWu6svs1BNhPNDXiGBxYkLt05PdK8ODxmrCWsXrKsfDkzODV9PFYfq04IjSK9gkX/D/Pgzv1PQyKAoWZVRHvc3hB+b78ClFHMvbrqTuNYQnLeIWXIkDNCLAtUBRN5Q0U/cp/ObbkZJDduf9+sXN6AtRMJ1z1swAnxQnYXPGsdjBodoOudtG0X0IR09S88mghpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB6166.namprd11.prod.outlook.com (2603:10b6:8:ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 09:35:37 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d0e5:1c89:f359:e15d]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d0e5:1c89:f359:e15d%4]) with mapi id 15.20.6588.025; Fri, 14 Jul 2023
 09:35:36 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joel Granados <j.granados@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasonwang@redhat.com"
 <jasonwang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [RFC PATCH v4 20/24] vfio/iommufd: Implement the iommufd backend
Thread-Topic: [RFC PATCH v4 20/24] vfio/iommufd: Implement the iommufd backend
Thread-Index: AQHZtJQdq11XmhSd4UKr6+O0URrHh6+5AIOAgAACnsA=
Date: Fri, 14 Jul 2023 09:35:36 +0000
Message-ID: <SJ0PR11MB6744F14B3E9E5E96BA6D0DB29234A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
 <20230712072528.275577-21-zhenzhong.duan@intel.com>
 <CGME20230714092325eucas1p105978aa928776b6e008e08e793d0ac60@eucas1p1.samsung.com>
 <20230714092323.lc4puo4rbsmhxce6@localhost>
In-Reply-To: <20230714092323.lc4puo4rbsmhxce6@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB6166:EE_
x-ms-office365-filtering-correlation-id: 881b821c-1adc-4a1a-3bb1-08db844dadf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qyKDCQxjmzgfgFMSkTaSS95/hP4e7/D5u2v1b15rRtW2F8TJep9vsyGbyB7ReCjtT9yvWfcfDvh/FnTVK5roma90GWBVt92TGiJ/BsM1uu1kxRQsp5ZrPzKllrFc35lFiFo8t4qYJqFuMdIMZljoq97UP03GesXpPSxo4sVih25T0eXTt8mzMH4hV+ddeg7GpTQiO/ACLPCoZfiWxi8kMtQ7/seY0LfNFj6DqhRzANDpN9/lmhUMcvfba5kGx658D8mWGSBFp4H6Xtx5ODRhUrDuZzYWPrDZ3d+ZbhCKj1+wRtaXzi/8rk470Xw6qR2GU3TLvQdlahkobBUlnn5k+3QoKGAFWKMJDQmvtoLtwPfFWgqoSFL6hy9tT9nJr8kKhqXpL0mTj4olkIWGFbyeaI0OoW6obB1W8HaTgPMoDDTU2j6EYYUAki+bjGFcntuwdQOU3Ji5sE6zpPolSIFTDkuDyahp/HeMbuPrHX7lR+DwfAejpBB4z3NjwhTkskl8XZK30/WL46nyxWMSeSANeKpMdoGokYds/LwLWhucx0wqUNdh/uGzRxdOrek/zKnYzfUNIVxKb/ZY6TprOvXcXe1rjgYkpaGBWsdsC6GQxCOKOIYlRA9zNpPNk8bev4n0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199021)(478600001)(7696005)(71200400001)(54906003)(186003)(6506007)(9686003)(26005)(107886003)(76116006)(2906002)(316002)(41300700001)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(5660300002)(52536014)(8936002)(8676002)(38100700002)(122000001)(82960400001)(86362001)(33656002)(38070700005)(83380400001)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6lgqSfKSEHPSjA7x162hf9y/iZpghJRT/LoItVaHSWCA9LPwXn+xnNt8iigW?=
 =?us-ascii?Q?Ze/SGDovDF0ZQiWz9+QcqU19jI5yTibvkmLoG0Va+5YHFUij6izAfdzbMoLl?=
 =?us-ascii?Q?tfriEqpNtSwffPgsWLZ3SBlsRlpuvPQYpo3RhtILR3w7wSed0DGXE5ymH/Ef?=
 =?us-ascii?Q?3tay5dBku9JT6Zs37OUD+T6jBBZaNOX/0EDQgnqUvk8m++uRH1MYHAAMxt6r?=
 =?us-ascii?Q?zoEN17f9FB7ampjyW8DDfcyG7A+h+d0pBdBB2/HNug9U1GVyKCgUVYv8iDnq?=
 =?us-ascii?Q?oY1nPIFdvD60BcWsHyou7sBGUPEbP9rKEqC/iloia3eVF8TJLVicfJk6qNLf?=
 =?us-ascii?Q?J91MNFp0msLh2tPjdAvSXiuJfMYVf+Vd4gavpZVDrpnjShDnEBVwn5JXqrzx?=
 =?us-ascii?Q?V1pdsOQEPrsb8/jxoXTMbpdqBHLlEYwfPOArPeFaVKhB/d9Ccx/0a2xt/hX0?=
 =?us-ascii?Q?pImeLUwmSDKJj5IVfSgckNVA3XvRHaa1X9NfYAWZD7WIzUW12VPKaMtlGhv7?=
 =?us-ascii?Q?e290g36i1A4LpbqGNQYb5Sy6Tpanvcm0NzMdhZlWimZZFf6gM1RNZkYsJqVJ?=
 =?us-ascii?Q?jBA6M8wb8t/dQGYSVlBZoM8vfro0PALlZHGrKu8Lmrpo+7tw7VvSrkqeiKtL?=
 =?us-ascii?Q?AlTQoUYB7Huo5F3jLZGStBklPPdaZdGXV/gbvXXedhcwwKxTK6+3rpTZdGDM?=
 =?us-ascii?Q?NbY4p/CHOFAzMKjPHXIn1VXYHFiu2jLZncT/KyvG22U9VVXSK2nwmpdgIsFH?=
 =?us-ascii?Q?TwdAvLmq1C3ZTWFHBE4vRXAvfBe7/L9i9hKFNMIgxukwkZZ3yjeCQ1g8wQv+?=
 =?us-ascii?Q?f0wsNq34YYwgThlomcYRUNZvPiaDAjwjfItxvFtxiYrMRFhqHRHLOPOKLlZN?=
 =?us-ascii?Q?BvasToZ7jN1DOvCZXmIz0wLDfBeoYgAmQP7NzD1DTAa3eCa3UJJ3sKw+Ykq9?=
 =?us-ascii?Q?8YyH1AaI7Fg6QbcoQTW/RLvHO0N8OiEh2bmIheXo+AckG70USnimNw9aSpRo?=
 =?us-ascii?Q?4l1Vym5c55R/rMpguv+U4Iyka8SwpaEVfDLRylON0dAnr9vzTp6aENjIxUpJ?=
 =?us-ascii?Q?FdaRupzwIy4LNpDBJBWnBrenZHa23f5eRbTzmDmDONxERaD9gYTZ66+OQxUf?=
 =?us-ascii?Q?3Nr6z3EcAzxWrmAJpDzbf4ls/t4GkVlzhGnVSlt2dsR+qz53WFt7EwaVF7V0?=
 =?us-ascii?Q?jnU12Z3ZDLCYYtGkJ8NEvBxwJvQwUzC3DbswLGMog3+bQO1CeC5RZuUUWTAP?=
 =?us-ascii?Q?7UAJ1DWnLcwj8jgDBP0LPCQ633O9ERyiAMBlUHprmxlAoFpnxWR665AaCV55?=
 =?us-ascii?Q?9je7EExAIUSIzwtW6Qmr4OJJ7VpQuI8V4gVOE2TrBUtIbi3kvYIeIL8mnN80?=
 =?us-ascii?Q?wVyf8iTxaiV82ALD4cFWvkX1rQKY7yA19Ti1rWzmeY6GZZYTSEipCKQ6WMuS?=
 =?us-ascii?Q?qWytbz7KnGE2gJP3udaH+kLO1A20RjOqPm6euK/+dIutUO+yRiuWqzP4MEDy?=
 =?us-ascii?Q?yRiC+QWt6gs12i9H9nTXfR/TUvdIskGFilh6CfqXOzjtu9eFDs1SHu9sIvhr?=
 =?us-ascii?Q?r0Hx7kKJmuQVPM/vCCNLSZ+Bbw/n6wUdhfI5XNgj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881b821c-1adc-4a1a-3bb1-08db844dadf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 09:35:36.8797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JaqheQmhRX4oT3+ZrckbOSH9Zg1ZHH2JgfSYGe2sO5tNLsdqDBtNK5wPsfMimhz7ziro7vS/e7pjeuIsZYSlr4JwBp/cQlk4bJ6FAlTMCM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6166
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mga11.intel.com
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

>-----Original Message-----
>From: Joel Granados <j.granados@samsung.com>
>Sent: Friday, July 14, 2023 5:23 PM
>Subject: Re: [RFC PATCH v4 20/24] vfio/iommufd: Implement the iommufd
>backend
>
>On Wed, Jul 12, 2023 at 03:25:24PM +0800, Zhenzhong Duan wrote:
>> From: Yi Liu <yi.l.liu@intel.com>
...
>> +static int vfio_get_devicefd(const char *sysfs_path, Error **errp)
>> +{
>> +    long int ret =3D -ENOTTY;
>> +    char *path, *vfio_dev_path =3D NULL, *vfio_path =3D NULL;
>> +    DIR *dir =3D NULL;
>> +    struct dirent *dent;
>> +    gchar *contents;
>> +    struct stat st;
>> +    gsize length;
>> +    int major, minor;
>> +    dev_t vfio_devt;
>> +
>> +    path =3D g_strdup_printf("%s/vfio-dev", sysfs_path);
>> +    if (stat(path, &st) < 0) {
>> +        error_setg_errno(errp, errno, "no such host device");
>> +        goto out_free_path;
>> +    }
>> +
>> +    dir =3D opendir(path);
>> +    if (!dir) {
>> +        error_setg_errno(errp, errno, "couldn't open dirrectory %s", pa=
th);
>> +        goto out_free_path;
>> +    }
>> +
>> +    while ((dent =3D readdir(dir))) {
>> +        if (!strncmp(dent->d_name, "vfio", 4)) {
>> +            vfio_dev_path =3D g_strdup_printf("%s/%s/dev", path, dent->=
d_name);
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (!vfio_dev_path) {
>> +        error_setg(errp, "failed to find vfio-dev/vfioX/dev");
>> +        goto out_free_path;
>> +    }
>> +
>> +    if (!g_file_get_contents(vfio_dev_path, &contents, &length, NULL)) =
{
>> +        error_setg(errp, "failed to load \"%s\"", vfio_dev_path);
>> +        goto out_free_dev_path;
>> +    }
>> +
>> +    if (sscanf(contents, "%d:%d", &major, &minor) !=3D 2) {
>> +        error_setg(errp, "failed to get major:mino for \"%s\"", vfio_de=
v_path);
>Very small nit: Should be "minor" here.
Good catch, will fix.

Thanks
Zhenzhong


