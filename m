Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5652F7E9549
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 04:02:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2NBl-0001tk-I7; Sun, 12 Nov 2023 22:00:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2NBV-0001tE-2U
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 22:00:24 -0500
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2NBQ-00073E-JO
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 22:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699844416; x=1731380416;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=X6Uo8W74S3Q1E36xCT3ZERLLjQ1lF2Budpp/IKANyKs=;
 b=HORDgJgTb9OtBF7fZWVepBqaD8/v9xTqc5iv8L3tVQk16TCIvS9GbrrT
 Wx8eNF0Ougxj4I9xshuYYXJM3hOqymkWrkZAs2LSuTpYIH3A8M4slaqiX
 wZMHtrtEqi7LUAtM0rNsKiq3a7WoSEXCbriZIlySdtOZcJZ3xu0vQGclh
 fm/mT2PtcsLc1gg9O06eWR4JpsE+TJ9+YZmSH0b4he05v3DP4ZPF6r6ti
 N+/pvY1Z1xmCP+XxoF/eXvzyEW5bpnKFpPGeGJCIsZwY1FmfodM7TRGNw
 qhUUv//WJR9mfoMp7cGHeaa7IEQBtYo1ApmTT1Eks80v+eG+zLo2wIcRU Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="454672209"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; d="scan'208";a="454672209"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2023 19:00:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="5545215"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Nov 2023 19:00:10 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 19:00:10 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 19:00:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 12 Nov 2023 19:00:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 12 Nov 2023 19:00:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUZ6wHmRncattp+RgA3L/ZtwTgPfl4WblvHd4cWQrxMsplwALA0Knv6xSdz9V0yfzY8gTIIwK5EThGT1BbPTq3m1W50AWb9PRhe9brCHKFPitTBtgAKSU1j9TTawzbbZHbFW0Z4XasD202StynuhrtASZDW+OV0Nu477ABKPObZ2Xh00Olu+TfJtOIahc1SbQoK39Q6g4swFyIu+8ErJzSxuQlCukPorXX89ATazTDkQ603pnwyinjO6TYzqa2JGmjAtbDVqFkXjKCi+8nW+S4DbAGCY27pIYb1+0gHUV9QV5302G65UtFwBeoq6PAueTHuTVFtKDePso30FqP07/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6Uo8W74S3Q1E36xCT3ZERLLjQ1lF2Budpp/IKANyKs=;
 b=DoRqpQ/ZXOLl+679rn6Fyl9bMUrili9DBa6ohirwX/wjbKSv7vfQ2TJy0NUD0mCVRY5DrZQjxQaQvNDsuofR7s47XxjvQwFPMBX+jkmRegahcEljNiEcWMhGpzzO0PlThHDv1zJJA5xQTyTTD69SmjsrcfPnQc3zNCae+vL+/SPM2t39x+E/O7krepNi975kZi/RjqIT8TfqTwcrkpF7i+SS6kFoZQBiZPvOX31fs5bxIGsQE5AnkLDy7EiGpN1yJtRRhfBRtBYZ1mKWBMd6nOBRFlgkmPxn+iMUh07eMfDcXcs32gOGT19jDj5RMX6P+W1xHYR2RC1MEVmFuH3VqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW4PR11MB5910.namprd11.prod.outlook.com (2603:10b6:303:189::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Mon, 13 Nov
 2023 03:00:07 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 03:00:07 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 10/20] vfio/pci: Make vfio cdev pre-openable by passing
 a file handle
Thread-Topic: [PATCH v5 10/20] vfio/pci: Make vfio cdev pre-openable by
 passing a file handle
Thread-Index: AQHaEwR/PeZ4SQIHEk667S7BiGjbsbBzYgSAgAQxg+A=
Date: Mon, 13 Nov 2023 03:00:07 +0000
Message-ID: <SJ0PR11MB67445F52268A9F988A84655B92B3A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
 <20231109114529.1904193-11-zhenzhong.duan@intel.com>
 <07539cb1-2262-4ae9-82ea-cfb7b9b8f2d5@redhat.com>
In-Reply-To: <07539cb1-2262-4ae9-82ea-cfb7b9b8f2d5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW4PR11MB5910:EE_
x-ms-office365-filtering-correlation-id: 017593f6-cfde-4947-7973-08dbe3f4a45c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lb1+nXfR4CdWeEdb7NfctqBO7xscvNydp9J9x98l6czHDggkkp2qZNKEcrKDze7kSCFoYvFw8arihApQQphZz6xG7nu7DHXIXUJJnkF+zI9naXtLj9AwFq/kr+jepnRZiVeRTwQtcKBVJj0c7DOPj76k/zw0Z97usjqOdC6uwLKq5iOB6D1rTq0hmKC5bAHFaVq0+KedHK2+PrS5jHl43b3ZeaucNpPBBKSNyevQOXwm1c2vNlUvw8X4goXAGVlvsshccFtYpa9z2lCMERsiK24huoaC3c0QUx6ltVnSri5sxlXeplLJ1ZjtdCvivX8rmerQ91Mq1O4iGQ3tGeniVKnBpdxXLn499JrbMfEyNzW/eo+ZL51jzLgm2W9z8t/IutUwGu0VcAtWIKhct42nbdYJibptuJkeqda1aolZfKbcFwgHtgs9f+Hj5ADFggUvcUYSmOZOB3pFUZhb+VgHhHRzBCdT4DegQlLWdeweFOtcho/HOip71OMMk6CmCxTMb/PNNibcSgt2C/tW2waR0L2IesZ8MYBnHoP/fHAqclzq5ILPMNx24R/fb6UzqnYKdDJhrFlKE0Tvvl8qIppvuhwomIM0def8EkDJKmEzYhF64HYvggMq0aQOK8TZBsF3KBM38EuKd66XejE++NC7Cg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(107886003)(26005)(66574015)(6506007)(7696005)(71200400001)(9686003)(83380400001)(5660300002)(4326008)(8936002)(8676002)(52536014)(2906002)(41300700001)(478600001)(316002)(110136005)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(82960400001)(122000001)(33656002)(86362001)(38100700002)(38070700009)(55016003)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTRqQmozQmlJajUzVHRUaWZ4OWVKcE90dWhvWHJRaWZvRGRnRHlCeUpJNGpQ?=
 =?utf-8?B?a1pkdWljcVhpMnBHYTBqSlBIczhpOUcvUUMvSG1DVTJyeGR3UzA1dmE2SXdL?=
 =?utf-8?B?V3BBaElGRzhaNTdiZWk2WitRNUk4T2ZpWWVSdnhpUXJIb2R1RXBaOUxpUFlB?=
 =?utf-8?B?VkhESTF4aC9CeTJXSHhManhmUmJQV005L1hpYU0xN2lnRGdFWHlMbjZncVJ0?=
 =?utf-8?B?VnFXZkxXK1h2SUtBQXlvbFJybUl5bGN0UU1sSy9kZERBMDRDUWovNk5LcDB4?=
 =?utf-8?B?ZHcvdjU0WEJNekdhNGJacVVyeFlnZUFNY2d4KzF1b056djlGdU9yZ2R1TXQx?=
 =?utf-8?B?YWxsZFVBZUlSZ3VIQ0UxM2k1YUFhWkRmeVVFbisvWjZDcURKdkFRNk9xNGpt?=
 =?utf-8?B?U0VxbVRiNkdDcUZSbDFLOFJUVVBzNE9QaWR1bHNkcU91ZkJsRDY5ZzFxT2sx?=
 =?utf-8?B?QUdobHQ5TG9IZ1d2S29UY29WLzZZQVp0b3JyT0QrWDBUc1JPVkcxNnNkdTZ3?=
 =?utf-8?B?OUpqQjJqT05LYkpscXVIVWZpSlRDaCtwQkxKQWcxYk9ib3pCaGZkbDVXQ1Fh?=
 =?utf-8?B?YnlES2dkVFZOamlXZDJqVUV3UzBTUW9LeGtCNnRVU0QrNjZqTDg0VE94UXZt?=
 =?utf-8?B?SDVXZnVCdjVNdUtqN2RZQVRqcDlYRExCV3BWaGlpQXkrcDI4SENhSlZOaG5P?=
 =?utf-8?B?Ui84b1ZMZEFSVTNPWGFDRXluS3BrR2NjTTFqZ0pIdllubWhCS3FpSEhMeHhO?=
 =?utf-8?B?YTdXNzltVG5saXFveHZGemsrTjljRC9BQUY4QVBCSWUvdGVsN3dTcWFuZzlM?=
 =?utf-8?B?SW9hNDZjbjNXaXVPaEVzODNDZ0JSRWRua3JPZXlQbU9lU2p4a2NaZjI0MUJp?=
 =?utf-8?B?L1Z4WjRsandaeHJYbHV4TnZNVmRxSkpiQngwazUvdVV4d3BHSCtJRnErbGU0?=
 =?utf-8?B?V3N3MmJ3Y0haaTVIVGRoZ3ExWGxPSTcvb20rdExYVXJsODJ1M3hocUM5ajl0?=
 =?utf-8?B?N1FKaHNuM3MzVkw1c2JxRDlySkhtQUhBaHBwaEN5ZGRHN3FXblI4MThYNFZY?=
 =?utf-8?B?NnQyTnlJQnVFWWdMMUJEbjVrWUI0KzRoTVVwREpWSDVYYlE3blliYzl5dzV3?=
 =?utf-8?B?Y2hHMFhkS21yeW1DZkQ1cHhSZWJoQ0d3ck51LzJBVnFuMVU1N3JmcFRVSTll?=
 =?utf-8?B?NWpnS3c4UTl1SGRFMHREbFNhRkpSWkYvbjZHMk9YdGlBdlg2bEpwOGJhUjZD?=
 =?utf-8?B?TUJmdXlKSSswZVkyU2lha3MrTWtUYy9JMFFEQm9BYXEyNzRoeXFiRmJURTU5?=
 =?utf-8?B?VmdMWUZ4STZHQkxSS3AzVmx6Rm9LY2J5dWUyVnZibGJJVHFVVU5zc0hSOHZq?=
 =?utf-8?B?QWczOEw2NXkxOWozbnkrRjZaalNEdUlGbHJOSkFBaHlIVG54VER6dXlaaURH?=
 =?utf-8?B?RkFLaUVuLzFjZFErWjgybnpuanZCc1h4bnpGaldsenlmd2JTT1d0QVBJQW5k?=
 =?utf-8?B?enVtejYzNXhBN2Y3K1Ruc0lxZzVrbnpEUUkrTHVBOVROZHl2S2ZUbTAvOXBs?=
 =?utf-8?B?QXZwaXZhTnU5b2sybTVhZWxwT01memdUUHAva2FtUW5KekhJMjYxdWkzNnRE?=
 =?utf-8?B?WWczVnJvdUV6MFJxSVFYZDM2MEdZOFhNK2xHL1I2NVZBVHpWNFFPdDRxWG5Q?=
 =?utf-8?B?THZNZVZ0TzlpbGFFTThVVlRmNzdobTI5dml1N3I4WWE4c29rYjJZY3dYWVV6?=
 =?utf-8?B?ZmV6RUhwaFNPdGdzSktNMGp1WlV0VnA2SEVMcjc2cSs0b3Nna0F3ZnhOYmtG?=
 =?utf-8?B?c0xneFdKUFJJQXFyZVhLTmlZTG9PcWpBVlVhaForM1MyeG0vR29XZEdaUEdR?=
 =?utf-8?B?dHU3c0l4RUVCdEdIUHcwRlVYRk1iZTZmd0JXWTdiY08vMDRUdnUwOHljSHVh?=
 =?utf-8?B?UEpPdi80Ykw3Q2hKNWtMNkNQbEVyaktZVSs3eGFySU96aW5aZE94SXNMVWxa?=
 =?utf-8?B?bnhab3VmQ0tqQ0J5OURJTTIvclRRUENOZkh1dDdiYU5zK3ZIZjB5Z3VvL2Fi?=
 =?utf-8?B?czRDZ08xaXlBVWFJODZvWmVGVGk4MWxxQkhPTHBZRW1JUkFqMTlZWHNPOHpQ?=
 =?utf-8?Q?HNSWTLe6thfMKQXhgQQ2p4Qg3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017593f6-cfde-4947-7973-08dbe3f4a45c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 03:00:07.1519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DMdDXvOocXJbgpR3pAtMtreoqmSluSh2CU1HCaAoeoPZ4/iBE0syRmVfYxv4qqsvQfm9SH348SETHL0Gy6Y8TOYuyym/bZ+7XST+nV/JQr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5910
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIE5vdmVtYmVyIDEwLCAyMDIzIDY6NTMg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY1IDEwLzIwXSB2ZmlvL3BjaTogTWFrZSB2ZmlvIGNk
ZXYgcHJlLW9wZW5hYmxlIGJ5IHBhc3NpbmcgYQ0KPmZpbGUgaGFuZGxlDQo+DQo+T24gMTEvOS8y
MyAxMjo0NSwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBUaGlzIGdpdmVzIG1hbmFnZW1lbnQg
dG9vbHMgbGlrZSBsaWJ2aXJ0IGEgY2hhbmNlIHRvIG9wZW4gdGhlIHZmaW8NCj4+IGNkZXYgd2l0
aCBwcml2aWxlZ2UgYW5kIHBhc3MgRkQgdG8gcWVtdS4gVGhpcyB3YXkgcWVtdSBuZXZlciBuZWVk
cw0KPj4gdG8gaGF2ZSBwcml2aWxlZ2UgdG8gb3BlbiBhIFZGSU8gb3IgaW9tbXUgY2RldiBub2Rl
Lg0KPj4NCj4+IFRvZ2V0aGVyIHdpdGggdGhlIGVhcmxpZXIgc3VwcG9ydCBvZiBwcmUtb3Blbmlu
ZyAvZGV2L2lvbW11IGRldmljZSwNCj4+IG5vdyB3ZSBoYXZlIGZ1bGwgc3VwcG9ydCBvZiBwYXNz
aW5nIGEgdmZpbyBkZXZpY2UgdG8gdW5wcml2aWxlZ2VkDQo+PiBxZW11IGJ5IG1hbmFnZW1lbnQg
dG9vbC4gVGhpcyBtb2RlIGlzIG5vIG1vcmUgY29uc2lkZXJlZCBmb3IgdGhlDQo+PiBsZWdhY3kg
YmFja2VuZC4gU28gbGV0J3MgcmVtb3ZlIHRoZSAiVE9ETyIgY29tbWVudC4NCj4+DQo+PiBBZGQg
YSBoZWxwZXIgZnVuY3Rpb24gdmZpb19kZXZpY2VfZ2V0X25hbWUoKSB0byBjaGVjayBmZCBhbmQg
Z2V0DQo+PiBkZXZpY2UgbmFtZSwgaXQgd2lsbCBhbHNvIGJlIHVzZWQgYnkgb3RoZXIgdmZpbyBk
ZXZpY2VzLg0KPj4NCj4+IFRoZXJlIGlzIG5vIGVhc3kgd2F5IHRvIGNoZWNrIGlmIGEgZGV2aWNl
IGlzIG1kZXYgd2l0aCBGRCBwYXNzaW5nLA0KPj4gc28gZmFpbCB0aGUgeC1iYWxsb29uLWFsbG93
ZWQgY2hlY2sgdW5jb25kaXRpb25hbGx5IGluIHRoaXMgY2FzZS4NCj4+DQo+PiBUaGVyZSBpcyBh
bHNvIG5vIGVhc3kgd2F5IHRvIGdldCBCREYgYXMgbmFtZSB3aXRoIEZEIHBhc3NpbmcsIHNvDQo+
PiB3ZSBmYWtlIGEgbmFtZSBieSBWRklPX0ZEW2ZkXS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBa
aGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGlu
Y2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oIHwgIDEgKw0KPj4gICBody92ZmlvL2hlbHBlcnMu
YyAgICAgICAgICAgICB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIGh3
L3ZmaW8vaW9tbXVmZC5jICAgICAgICAgICAgIHwgMTIgKysrKysrKy0tLS0NCj4+ICAgaHcvdmZp
by9wY2kuYyAgICAgICAgICAgICAgICAgfCA0MCArKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLQ0KPj4gICA0IGZpbGVzIGNoYW5nZWQsIDcxIGluc2VydGlvbnMoKyksIDE2IGRlbGV0
aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24u
aCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+PiBpbmRleCAzZGFjNWMxNjdlLi45
NjBhMTRlOGQ4IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgN
Cj4+ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+PiBAQCAtMjM4LDYgKzIz
OCw3IEBAIHN0cnVjdCB2ZmlvX2luZm9fY2FwX2hlYWRlciAqDQo+PiAgIHZmaW9fZ2V0X2Rldmlj
ZV9pbmZvX2NhcChzdHJ1Y3QgdmZpb19kZXZpY2VfaW5mbyAqaW5mbywgdWludDE2X3QgaWQpOw0K
Pj4gICBzdHJ1Y3QgdmZpb19pbmZvX2NhcF9oZWFkZXIgKg0KPj4gICB2ZmlvX2dldF9jYXAodm9p
ZCAqcHRyLCB1aW50MzJfdCBjYXBfb2Zmc2V0LCB1aW50MTZfdCBpZCk7DQo+PiAraW50IHZmaW9f
ZGV2aWNlX2dldF9uYW1lKFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBFcnJvciAqKmVycnApOw0KPj4g
ICAjZW5kaWYNCj4+DQo+PiAgIGJvb2wgdmZpb19taWdyYXRpb25fcmVhbGl6ZShWRklPRGV2aWNl
ICp2YmFzZWRldiwgRXJyb3IgKiplcnJwKTsNCj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2hlbHBl
cnMuYyBiL2h3L3ZmaW8vaGVscGVycy5jDQo+PiBpbmRleCAxNjg4NDdlN2M1Li5kODBhYTU4NzE5
IDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9oZWxwZXJzLmMNCj4+ICsrKyBiL2h3L3ZmaW8vaGVs
cGVycy5jDQo+PiBAQCAtMjAsNiArMjAsNyBAQA0KPj4gICAgKi8NCj4+DQo+PiAgICNpbmNsdWRl
ICJxZW11L29zZGVwLmgiDQo+PiArI2luY2x1ZGUgQ09ORklHX0RFVklDRVMgLyogQ09ORklHX0lP
TU1VRkQgKi8NCj4+ICAgI2luY2x1ZGUgPHN5cy9pb2N0bC5oPg0KPj4NCj4+ICAgI2luY2x1ZGUg
Imh3L3ZmaW8vdmZpby1jb21tb24uaCINCj4+IEBAIC02MDksMyArNjEwLDM2IEBAIGJvb2wgdmZp
b19oYXNfcmVnaW9uX2NhcChWRklPRGV2aWNlICp2YmFzZWRldiwgaW50DQo+cmVnaW9uLCB1aW50
MTZfdCBjYXBfdHlwZSkNCj4+DQo+PiAgICAgICByZXR1cm4gcmV0Ow0KPj4gICB9DQo+PiArDQo+
PiAraW50IHZmaW9fZGV2aWNlX2dldF9uYW1lKFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBFcnJvciAq
KmVycnApDQo+PiArew0KPj4gKyAgICBzdHJ1Y3Qgc3RhdCBzdDsNCj4+ICsNCj4+ICsgICAgaWYg
KHZiYXNlZGV2LT5mZCA8IDApIHsNCj4+ICsgICAgICAgIGlmIChzdGF0KHZiYXNlZGV2LT5zeXNm
c2RldiwgJnN0KSA8IDApIHsNCj4+ICsgICAgICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAs
IGVycm5vLCAibm8gc3VjaCBob3N0IGRldmljZSIpOw0KPj4gKyAgICAgICAgICAgIGVycm9yX3By
ZXBlbmQoZXJycCwgVkZJT19NU0dfUFJFRklYLCB2YmFzZWRldi0+c3lzZnNkZXYpOw0KPj4gKyAg
ICAgICAgICAgIHJldHVybiAtZXJybm87DQo+PiArICAgICAgICB9DQo+PiArICAgICAgICAvKiBV
c2VyIG1heSBzcGVjaWZ5IGEgbmFtZSwgZS5nOiBWRklPIHBsYXRmb3JtIGRldmljZSAqLw0KPj4g
KyAgICAgICAgaWYgKCF2YmFzZWRldi0+bmFtZSkgew0KPj4gKyAgICAgICAgICAgIHZiYXNlZGV2
LT5uYW1lID0gZ19wYXRoX2dldF9iYXNlbmFtZSh2YmFzZWRldi0+c3lzZnNkZXYpOw0KPj4gKyAg
ICAgICAgfQ0KPj4gKyAgICB9DQo+PiArI2lmZGVmIENPTkZJR19JT01NVUZEDQo+PiArICAgIGVs
c2Ugew0KPj4gKyAgICAgICAgaWYgKCF2YmFzZWRldi0+aW9tbXVmZCkgew0KPg0KPg0KPkNhbiB3
ZSBoYW5kbGUgd2l0aCB0aGlzIGNhc2Ugd2l0aG91dCBDT05GSUdfSU9NTVVGRCwgc2ltcGx5IGJ5
DQo+dGVzdGluZyB2YmFzZWRldi0+aW9tbXVmZCA/DQoNClN1cmUsIHdpbGwgZG8uDQoNCj4NCj4+
ICsgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJVc2UgRkQgcGFzc2luZyBvbmx5IHdpdGgg
aW9tbXVmZCBiYWNrZW5kIik7DQo+PiArICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+PiAr
ICAgICAgICB9DQo+PiArICAgICAgICAvKg0KPj4gKyAgICAgICAgICogR2l2ZSBhIG5hbWUgd2l0
aCBmZCBzbyBhbnkgZnVuY3Rpb24gcHJpbnRpbmcgb3V0IHZiYXNlZGV2LT5uYW1lDQo+PiArICAg
ICAgICAgKiB3aWxsIG5vdCBicmVhay4NCj4+ICsgICAgICAgICAqLw0KPj4gKyAgICAgICAgaWYg
KCF2YmFzZWRldi0+bmFtZSkgew0KPj4gKyAgICAgICAgICAgIHZiYXNlZGV2LT5uYW1lID0gZ19z
dHJkdXBfcHJpbnRmKCJWRklPX0ZEJWQiLCB2YmFzZWRldi0+ZmQpOw0KPj4gKyAgICAgICAgfQ0K
Pj4gKyAgICB9DQo+PiArI2VuZGlmDQo+PiArICAgIHJldHVybiAwOw0KPj4gK30NCj4+IGRpZmYg
LS1naXQgYS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+PiBpbmRleCA0
NGRjNjg0OGJmLi5mZDMwNDc3Mjc1IDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9pb21tdWZkLmMN
Cj4+ICsrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+PiBAQCAtMzI2LDExICszMjYsMTUgQEAgc3Rh
dGljIGludCBpb21tdWZkX2F0dGFjaF9kZXZpY2UoY29uc3QgY2hhciAqbmFtZSwNCj5WRklPRGV2
aWNlICp2YmFzZWRldiwNCj4+ICAgICAgIHVpbnQzMl90IGlvYXNfaWQ7DQo+PiAgICAgICBFcnJv
ciAqZXJyID0gTlVMTDsNCj4+DQo+PiAtICAgIGRldmZkID0gaW9tbXVmZF9jZGV2X2dldGZkKHZi
YXNlZGV2LT5zeXNmc2RldiwgZXJycCk7DQo+PiAtICAgIGlmIChkZXZmZCA8IDApIHsNCj4+IC0g
ICAgICAgIHJldHVybiBkZXZmZDsNCj4+ICsgICAgaWYgKHZiYXNlZGV2LT5mZCA8IDApIHsNCj4+
ICsgICAgICAgIGRldmZkID0gaW9tbXVmZF9jZGV2X2dldGZkKHZiYXNlZGV2LT5zeXNmc2Rldiwg
ZXJycCk7DQo+PiArICAgICAgICBpZiAoZGV2ZmQgPCAwKSB7DQo+PiArICAgICAgICAgICAgcmV0
dXJuIGRldmZkOw0KPj4gKyAgICAgICAgfQ0KPj4gKyAgICAgICAgdmJhc2VkZXYtPmZkID0gZGV2
ZmQ7DQo+PiArICAgIH0gZWxzZSB7DQo+PiArICAgICAgICBkZXZmZCA9IHZiYXNlZGV2LT5mZDsN
Cj4+ICAgICAgIH0NCj4+IC0gICAgdmJhc2VkZXYtPmZkID0gZGV2ZmQ7DQo+Pg0KPj4gICAgICAg
cmV0ID0gaW9tbXVmZF9jb25uZWN0X2FuZF9iaW5kKHZiYXNlZGV2LCBlcnJwKTsNCj4+ICAgICAg
IGlmIChyZXQpIHsNCj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL3BjaS5jIGIvaHcvdmZpby9wY2ku
Yw0KPj4gaW5kZXggZTlhNDI2MjAwYi4uZjk1NzI1ZWQxNiAxMDA2NDQNCj4+IC0tLSBhL2h3L3Zm
aW8vcGNpLmMNCj4+ICsrKyBiL2h3L3ZmaW8vcGNpLmMNCj4+IEBAIC00NCw2ICs0NCw3IEBADQo+
PiAgICNpbmNsdWRlICJtaWdyYXRpb24vYmxvY2tlci5oIg0KPj4gICAjaW5jbHVkZSAibWlncmF0
aW9uL3FlbXUtZmlsZS5oIg0KPj4gICAjaW5jbHVkZSAic3lzZW11L2lvbW11ZmQuaCINCj4+ICsj
aW5jbHVkZSAibW9uaXRvci9tb25pdG9yLmgiDQo+Pg0KPj4gICAjZGVmaW5lIFRZUEVfVkZJT19Q
Q0lfTk9IT1RQTFVHICJ2ZmlvLXBjaS1ub2hvdHBsdWciDQo+Pg0KPj4gQEAgLTI5MzQsMTggKzI5
MzUsMjMgQEAgc3RhdGljIHZvaWQgdmZpb19yZWFsaXplKFBDSURldmljZSAqcGRldiwgRXJyb3IN
Cj4qKmVycnApDQo+PiAgICAgICBWRklPRGV2aWNlICp2YmFzZWRldiA9ICZ2ZGV2LT52YmFzZWRl
djsNCj4+ICAgICAgIGNoYXIgKnRtcCwgKnN1YnN5czsNCj4+ICAgICAgIEVycm9yICplcnIgPSBO
VUxMOw0KPj4gLSAgICBzdHJ1Y3Qgc3RhdCBzdDsNCj4+ICAgICAgIGludCBpLCByZXQ7DQo+PiAg
ICAgICBib29sIGlzX21kZXY7DQo+PiAgICAgICBjaGFyIHV1aWRbVVVJRF9TVFJfTEVOXTsNCj4+
ICAgICAgIGNoYXIgKm5hbWU7DQo+Pg0KPj4gLSAgICBpZiAoIXZiYXNlZGV2LT5zeXNmc2Rldikg
ew0KPj4gKyAgICBpZiAodmJhc2VkZXYtPmZkIDwgMCAmJiAhdmJhc2VkZXYtPnN5c2ZzZGV2KSB7
DQo+PiAgICAgICAgICAgaWYgKCEofnZkZXYtPmhvc3QuZG9tYWluIHx8IH52ZGV2LT5ob3N0LmJ1
cyB8fA0KPj4gICAgICAgICAgICAgICAgIH52ZGV2LT5ob3N0LnNsb3QgfHwgfnZkZXYtPmhvc3Qu
ZnVuY3Rpb24pKSB7DQo+PiAgICAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIk5vIHByb3Zp
ZGVkIGhvc3QgZGV2aWNlIik7DQo+PiArI2lmZGVmIENPTkZJR19JT01NVUZEDQo+PiArICAgICAg
ICAgICAgZXJyb3JfYXBwZW5kX2hpbnQoZXJycCwgIlVzZSAtZGV2aWNlIHZmaW8tcGNpLGhvc3Q9
RERERDpCQjpERC5GLCAiDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIi1kZXZp
Y2UgdmZpby1wY2ksc3lzZnNkZXY9UEFUSF9UT19ERVZJQ0UgIg0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICJvciAtZGV2aWNlIHZmaW8tcGNpLGZkPURFVklDRV9GRFxuIik7DQo+
PiArI2Vsc2UNCj4+ICAgICAgICAgICAgICAgZXJyb3JfYXBwZW5kX2hpbnQoZXJycCwgIlVzZSAt
ZGV2aWNlIHZmaW8tcGNpLGhvc3Q9RERERDpCQjpERC5GICINCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIm9yIC1kZXZpY2UgdmZpby1wY2ksc3lzZnNkZXY9UEFUSF9UT19ERVZJ
Q0VcbiIpOw0KPj4gKyNlbmRpZg0KPg0KPm9yIHNpbXBseSA6DQo+DQo+DQo+ICAgICAgICAgICAg
ICAgIGVycm9yX2FwcGVuZF9oaW50KGVycnAsICJVc2UgLWRldmljZSB2ZmlvLXBjaSxob3N0PURE
REQ6QkI6REQuRiAiDQo+ICArI2lmZGVmIENPTkZJR19JT01NVUZEDQo+ICArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIm9yIC1kZXZpY2UgdmZpby1wY2ksZmQ9REVWSUNFX0ZEICINCj4g
ICsjZW5kaWYNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIm9yIC1kZXZpY2Ug
dmZpby1wY2ksc3lzZnNkZXY9UEFUSF9UT19ERVZJQ0VcbiIpOw0KDQpHb29kIGlkZWEsIHdpbGwg
ZG8uDQoNCj4NCj4NCj4NCj4+ICAgICAgICAgICAgICAgcmV0dXJuOw0KPj4gICAgICAgICAgIH0N
Cj4+ICAgICAgICAgICB2YmFzZWRldi0+c3lzZnNkZXYgPQ0KPj4gQEAgLTI5NTQsMTMgKzI5NjAs
OSBAQCBzdGF0aWMgdm9pZCB2ZmlvX3JlYWxpemUoUENJRGV2aWNlICpwZGV2LCBFcnJvcg0KPioq
ZXJycCkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZkZXYtPmhvc3Quc2xvdCwg
dmRldi0+aG9zdC5mdW5jdGlvbik7DQo+PiAgICAgICB9DQo+Pg0KPj4gLSAgICBpZiAoc3RhdCh2
YmFzZWRldi0+c3lzZnNkZXYsICZzdCkgPCAwKSB7DQo+PiAtICAgICAgICBlcnJvcl9zZXRnX2Vy
cm5vKGVycnAsIGVycm5vLCAibm8gc3VjaCBob3N0IGRldmljZSIpOw0KPj4gLSAgICAgICAgZXJy
b3JfcHJlcGVuZChlcnJwLCBWRklPX01TR19QUkVGSVgsIHZiYXNlZGV2LT5zeXNmc2Rldik7DQo+
PiArICAgIGlmICh2ZmlvX2RldmljZV9nZXRfbmFtZSh2YmFzZWRldiwgZXJycCkpIHsNCj4+ICAg
ICAgICAgICByZXR1cm47DQo+PiAgICAgICB9DQo+PiAtDQo+PiAtICAgIHZiYXNlZGV2LT5uYW1l
ID0gZ19wYXRoX2dldF9iYXNlbmFtZSh2YmFzZWRldi0+c3lzZnNkZXYpOw0KPj4gICAgICAgdmJh
c2VkZXYtPm9wcyA9ICZ2ZmlvX3BjaV9vcHM7DQo+PiAgICAgICB2YmFzZWRldi0+dHlwZSA9IFZG
SU9fREVWSUNFX1RZUEVfUENJOw0KPj4gICAgICAgdmJhc2VkZXYtPmRldiA9IERFVklDRSh2ZGV2
KTsNCj4+IEBAIC0zMzIwLDYgKzMzMjIsNyBAQCBzdGF0aWMgdm9pZCB2ZmlvX2luc3RhbmNlX2lu
aXQoT2JqZWN0ICpvYmopDQo+PiAgICAgICB2ZGV2LT5ob3N0LmJ1cyA9IH4wVTsNCj4+ICAgICAg
IHZkZXYtPmhvc3Quc2xvdCA9IH4wVTsNCj4+ICAgICAgIHZkZXYtPmhvc3QuZnVuY3Rpb24gPSB+
MFU7DQo+PiArICAgIHZkZXYtPnZiYXNlZGV2LmZkID0gLTE7DQo+V2Ugc2hvdWxkIHByb2JhYmx5
IG1vdmUgdGhlIGFsbCBWRklPRGV2aWNlIGluaXRpYWxpemF0aW9ucyA6DQo+DQo+ICAgICB2YmFz
ZWRldi0+b3BzID0gJnZmaW9fcGNpX29wczsNCj4gICAgIHZiYXNlZGV2LT50eXBlID0gVkZJT19E
RVZJQ0VfVFlQRV9QQ0k7DQo+ICAgICB2YmFzZWRldi0+ZGV2ID0gREVWSUNFKHZkZXYpOw0KPg0K
PnVuZGVyIHZmaW9faW5zdGFuY2VfaW5pdCAoc2hvdWxkIGJlIGNhbGxlZCB2ZmlvX3BjaV9pbnN0
YW5jZV9pbml0KS4NCj4NCj5UaGlzIGlzIHRydWUgZm9yIGFsbCBvdGhlciBWRklPIGRldmljZXMu
IE1heSBiZSBub3QgZm9yIHRoaXMgc2VyaWVzLA0KPml0IGNhbiBjb21lIGxhdGVyLg0KDQpTdXJl
LCBMZXQgbWUgc2VuZCBhIHNlcGFyYXRlIHNlcmllcyBhZGRyZXNzaW5nIHRoaXMuDQoNCj4NCj4N
Cj4+DQo+PiAgICAgICB2ZGV2LT5udl9ncHVkaXJlY3RfY2xpcXVlID0gMHhGRjsNCj4+DQo+PiBA
QCAtMzM3MywxMSArMzM3Niw2IEBAIHN0YXRpYyBQcm9wZXJ0eSB2ZmlvX3BjaV9kZXZfcHJvcGVy
dGllc1tdID0gew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHFkZXZf
cHJvcF9udl9ncHVkaXJlY3RfY2xpcXVlLCB1aW50OF90KSwNCj4+ICAgICAgIERFRklORV9QUk9Q
X09GRl9BVVRPX1BDSUJBUigieC1tc2l4LXJlbG9jYXRpb24iLCBWRklPUENJRGV2aWNlLA0KPm1z
aXhfcmVsbywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPRkZfQVVUT1BD
SUJBUl9PRkYpLA0KPj4gLSAgICAvKg0KPj4gLSAgICAgKiBUT0RPIC0gc3VwcG9ydCBwYXNzZWQg
ZmRzLi4uIGlzIHRoaXMgbmVjZXNzYXJ5Pw0KPj4gLSAgICAgKiBERUZJTkVfUFJPUF9TVFJJTkco
InZmaW9mZCIsIFZGSU9QQ0lEZXZpY2UsIHZmaW9mZF9uYW1lKSwNCj4+IC0gICAgICogREVGSU5F
X1BST1BfU1RSSU5HKCJ2ZmlvZ3JvdXBmZCwgVkZJT1BDSURldmljZSwgdmZpb2dyb3VwZmRfbmFt
ZSksDQo+PiAtICAgICAqLw0KPj4gICAjaWZkZWYgQ09ORklHX0lPTU1VRkQNCj4+ICAgICAgIERF
RklORV9QUk9QX0xJTksoImlvbW11ZmQiLCBWRklPUENJRGV2aWNlLCB2YmFzZWRldi5pb21tdWZk
LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICBUWVBFX0lPTU1VRkRfQkFDS0VORCwgSU9NTVVG
REJhY2tlbmQgKiksDQo+PiBAQCAtMzM4NSw2ICszMzgzLDIxIEBAIHN0YXRpYyBQcm9wZXJ0eSB2
ZmlvX3BjaV9kZXZfcHJvcGVydGllc1tdID0gew0KPj4gICAgICAgREVGSU5FX1BST1BfRU5EX09G
X0xJU1QoKSwNCj4+ICAgfTsNCj4+DQo+PiArI2lmZGVmIENPTkZJR19JT01NVUZEDQo+PiArc3Rh
dGljIHZvaWQgdmZpb19wY2lfc2V0X2ZkKE9iamVjdCAqb2JqLCBjb25zdCBjaGFyICpzdHIsIEVy
cm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAgIFZGSU9QQ0lEZXZpY2UgKnZkZXYgPSBWRklPX1BD
SShvYmopOw0KPj4gKyAgICBpbnQgZmQgPSAtMTsNCj4+ICsNCj4+ICsgICAgZmQgPSBtb25pdG9y
X2ZkX3BhcmFtKG1vbml0b3JfY3VyKCksIHN0ciwgZXJycCk7DQo+PiArICAgIGlmIChmZCA9PSAt
MSkgew0KPj4gKyAgICAgICAgZXJyb3JfcHJlcGVuZChlcnJwLCAiQ291bGQgbm90IHBhcnNlIHJl
bW90ZSBvYmplY3QgZmQgJXM6Iiwgc3RyKTsNCj4+ICsgICAgICAgIHJldHVybjsNCj4+ICsgICAg
fQ0KPj4gKyAgICB2ZGV2LT52YmFzZWRldi5mZCA9IGZkOw0KPg0KPldlIGNvdWxkIGludHJvZHVj
ZSBhIGNvbW1vbiBoZWxwZXIgaW4gaHcvdmZpby9jb21tb24uYyB0byByZW1vdmUgY29kZQ0KPmR1
cGxpY2F0aW9uIDoNCj4NCj4jaWZkZWYgQ09ORklHX0lPTU1VRkQNCj5zdGF0aWMgdm9pZCB2Zmlv
X3BjaV9zZXRfZmQoT2JqZWN0ICpvYmosIGNvbnN0IGNoYXIgKnN0ciwgRXJyb3IgKiplcnJwKQ0K
PnsNCj4gICAgIHZmaW9fZGV2aWNlX3NldF9mZCgmVkZJT19QQ0kob2JqKS0+dmJhc2VkZXYsIHN0
ciwgZXJycCk7DQo+fQ0KPiNlbmRpZg0KDQpHb29kIHN1Z2dlc3Rpb25zISBXaWxsIGRvLg0KDQpU
aGFua3MNClpoZW56aG9uZw0K

