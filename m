Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D09817B10DE
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 04:40:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlgv5-0001wE-9L; Wed, 27 Sep 2023 22:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlgv2-0001vt-NZ
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 22:38:24 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlgv0-0007q3-9p
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 22:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695868702; x=1727404702;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fZx2tEwdEFnCWet+NxAN1KvVTpfvJ2Br6BIZ6IhQbOw=;
 b=fOuKw4a+g3jZ3AAhf+AMcY7s+fucjRp2nyfWpSLziKvMjzn0S4U3TYEy
 xy00/MImRnmqF7zhn+AlFDXEbfbd0KDMxjF961Q3FT0+fY87GQm/T8XQw
 ffaPDtmvnph1pmGaGjMQXbgiJnDVW9hk3KtU0IFVzT83jYKgeMnw286AH
 uwBedPqN08XoMxY1j/SRLTuxe9Sha7ZQuHMc+cV7NUrC5q8KISw/4DsCq
 SgRvmHKj69weVpdIq1rsxUiWjowPOsDk46ZJduJljzQraEtU1otPXMz9B
 VE6hhYRNAZITsd52NQgDsfhn78fvy+YaHXewoC4jQbTzBqGaCtyKJaBBk A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="367036323"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; d="scan'208";a="367036323"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2023 19:38:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="996406085"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; d="scan'208";a="996406085"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Sep 2023 19:38:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 19:38:18 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 19:38:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 19:38:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 19:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JREzknOeJ/mnbvH2ZCjYiSw+bQ7O1G7ernEgvz2BLmLdHZUCiPTZRMw2rJevvQZjgrgZ8yewmmepNL/WZkThqmkTWb1Uvcw8mM2AbEhp/0XvFtNQcPQkH9yULY5FeowqptMHcajF3o6a6IhpX6WqfP07NkxyDxgP1nv8RCZh/NGBGVRlOfu3GaDPho8pvOhfhZpF/JSbhiJYJtfy4X1AS891j99zyNuXD29KsowZFJoigKK9oYrUwc6zqfnCZeXh8/VKQEP3O42R6BlRapXs+iDKXmlLULSVXvrMWGoFrQAO5thAxgeW7cDWfN5VB0yw+PK/y6p/70sy0zjnO8R8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZx2tEwdEFnCWet+NxAN1KvVTpfvJ2Br6BIZ6IhQbOw=;
 b=DUMjWKxpu5MsQxgzaeRi6xSWpEdF8QlPhKyWkFLI1EVt/0DB+dc8ksHGS9Qm63X7l5H/PMynIwtUHJPcGQgRxH5r4DbSEDYuX5BL832Jb0QZmisp3q5c0YY+uzdgmfB0cw5uHksaTy9N/QE3tmARY/9B+VoKR9wxtoddsIa7hYVQ9EFJXAfx5kpTp2eYsvXHWDinaZr61iqB1ZjU9WMLdBrT7WlXuMguEG88dvnaeXzTc6R/Cx+aPl3+zIcXnjg9Jxl7SXQc1CsN1ObI4CPKI+NEyvUM/A/0ScflekhpVTB3Fsf5DuiGyFRpIob1NtfO8Qw4a+vCPG4ZqWMIOt8KLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by CO1PR11MB4834.namprd11.prod.outlook.com (2603:10b6:303:90::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 28 Sep
 2023 02:38:15 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24%3]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 02:38:15 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 11/12] vfio/common: Introduce two kinds of VFIO device
 lists
Thread-Topic: [PATCH v2 11/12] vfio/common: Introduce two kinds of VFIO device
 lists
Thread-Index: AQHZ8G9ag5lqydfO7ECChsV/UjxuUbAup/qAgADfhLA=
Date: Thu, 28 Sep 2023 02:38:15 +0000
Message-ID: <PH7PR11MB672242793610087ACBDCEAC692C1A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-12-zhenzhong.duan@intel.com>
 <dba250f5-4d75-b4d4-953b-6495f7ddbaf1@redhat.com>
In-Reply-To: <dba250f5-4d75-b4d4-953b-6495f7ddbaf1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|CO1PR11MB4834:EE_
x-ms-office365-filtering-correlation-id: 1f60ae60-ee38-4814-a4a4-08dbbfcbf783
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PgTrAJPqgI4rvMoWgZo2zV26yfChMAGhLFG2TzCMXB7wNnlpXGjNRQWmF0hi1oL4qoZxoFYbVqfUg6paUhOWq3kbDyF0p0XRg43CX2kAm4ZHlhPKPDKfRp6RBBB3wd47TTnVT5JO8WkUcZdcY8qoro4UiECnDBqzgVA9hlsfXbXK9YDpthlmB+qKZxqgW6N07fNg9cdkUVcwNh0mTCG1hXX9XaKG/yUADNlzp3Wk+Tjit8TqVRFnEBCHlzIRitwUqVqrXiU66SnpqcRMmt7pHYPW1Xgar6QOy0d1GrVM5dzrCAKoGkHYwPGiUuXzUQA82w6gb6K7uUu4JeyeKIvH+KNtxTbi1FoUprKnkO912cR5eWjn5JptGroBA06uE4yEurFy5B6EFYUE0nkxb0JGorezkokqqzjpYoLeGfESXl4ob1U6i7qwefSXm0McT0ngVW76CPPsCY3/B8O7UmLgrox69gYR13+GqZcmXuKeEwLdYbULliq+ewIoEuVgsQk5FbKlIBAkTrp+tcQHIgrKEs9v3k5tWygYb/8N/yvVzel36TrTdpGtkc4UhDQL2qFn2TAiD4VgCsj2rBcSRUQRAhdITH8Ua0+o3yMzGgQMbXu+25gc3ixye1r3mnIsB5jQl4Fy8vXp0kVDP6G5AXM4Rg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(396003)(346002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(478600001)(71200400001)(41300700001)(86362001)(38070700005)(6506007)(38100700002)(122000001)(7696005)(9686003)(33656002)(82960400001)(26005)(83380400001)(107886003)(54906003)(66946007)(316002)(76116006)(64756008)(66446008)(66476007)(4326008)(66556008)(52536014)(110136005)(5660300002)(2906002)(55016003)(8936002)(8676002)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nnp3aDQ2ZWNuelJ1aUFpS1YrSjBpWmw0ODI3QXlZYXBCeU9pSWRMMk9FZTd0?=
 =?utf-8?B?bFR3a3F3K1hZYkNPN0FOQjlhU2RVMExsby9PWjd3cUlxUm9hamhyaGwwV2JQ?=
 =?utf-8?B?eDhMeHg3V0FSOXUycWhXenVKaGFNbVg4LzlhV3ZGK2pOeWZOaFdUTHRxNUxH?=
 =?utf-8?B?RG1sMkJWWUhXaVVvTnJHWkRUYUhqdWx3UnZHa25EZUoycHY3eGFJbjVPS28v?=
 =?utf-8?B?dXJsWm5Mc1E5K015UkZ4Z1FaV3R1clhublQ1UjhNTDRnNjRrWms2cjJ5NVJz?=
 =?utf-8?B?Znl0T0EvYjJ0MGVINElvMDBVNWdIS3BONlFYSTBRVVpaUG5UVnNiUjJ2NDFC?=
 =?utf-8?B?S3FQUFdRaVJSNy9CQzFiamVrd3lYWFhsbjFDeU5yM1NRYk4xYW9NRVY0aFFL?=
 =?utf-8?B?clNLb21NTGZhRTlxdDlLdVhBOTcvb0JnaGZDMTZSc3YvNlpyZTB0T1R5VU1O?=
 =?utf-8?B?NFdEbzdZd2syc0RUQ2pqSldnaVgvRWFmVU9kak1sK3k3bVN0USs3UHFmMy9S?=
 =?utf-8?B?UzlZSEl1N1RsWFV0c01iWVdrZmdDMU1ZVzJvUExoWWNuREh0aG9ndzM2WFQw?=
 =?utf-8?B?T2tVYlhPc3A1WlhnSHU4WllIZ0lmRlVxTmpsbElyd09rTWo2clQ0Z1RicFZt?=
 =?utf-8?B?OU1iVWtzeUlSUjhXbHFDKzlPRzN0c2NyNXp6L28vaWVyU0F5Qnl6cEtsS1I0?=
 =?utf-8?B?dzNheGh6NEFsRkhNMzBrWEdaN3dQUm52RGo5VDJWRGRMYmxLOVNrMW9BRVk5?=
 =?utf-8?B?TzBvblhSK3BIUlFiYjZCeTdmVG02RWxFTU02ZGNtV2FtcEhMcHNoUTZ6WjVl?=
 =?utf-8?B?aEZVNmNtRmhzS243c0Jkdnp6TVdzQldqUURhMFNQalRoQXplSVJmbjBFRGMz?=
 =?utf-8?B?N0xZTnc1R3VFNDZSd0NEWnozZWFaY2xIaGd4ZGNmWDUrc2VoMStqZjljbW1C?=
 =?utf-8?B?K2NTZnpKclVGM0NsUGtDTnh0bUphRlBSN0MwOXNGT0R0eVlWL3pxM2hHQlVZ?=
 =?utf-8?B?aXNmTzNZNm9yUytoNGFZaUJwMjNsdmxjYVJEdk9VNkVaNzI2YTgvcE5rU3FP?=
 =?utf-8?B?MHJkb0I2cFBNWHozaVRWa0ZYclZENXhvcXlRSXBjQ0hDSE1LUlhOb2V4VXlI?=
 =?utf-8?B?d2M2UmdtaEd0QmNRdTF3a0MxOU5Cc2ZGK1RrMm5yZ25qb3dVclovaERqZVBC?=
 =?utf-8?B?T25TOWx6REZ2VCtkcUp1bjRPTzAwZ21mdHlYUC95UzQyYjBMTUl2UGNicWt0?=
 =?utf-8?B?bHJmM0d3N1JRbGZnUFE1MFdWbGMvVmpaNnU1M3hrdUJJbTdDZGlnaFlKREkv?=
 =?utf-8?B?UHljZmdXVGdUb3E5MlhXeDRQSkdiZnVLT3hmUk1oYWFJTHhTUW9wUjFTQUZ3?=
 =?utf-8?B?cEdGVWUwL0dlT1RZeEhUWVdzakgzbE9Va2NHcmNWTEd2NDJ1UGY3ZlVrdzEy?=
 =?utf-8?B?ZytqNUx4T3kvZUFVUG5xcjc1V0UrMGU4ei8yN1F0N1pwVFRLcHZXVXRLMFB6?=
 =?utf-8?B?SjNDK2pDbW4xL2pxSHlqeGZTVzc1RjY1eFdoYzBZT1FyZmhaeUVDNVBhRnZi?=
 =?utf-8?B?angyM0VGc2Z1emFhMTBOZGVpTnVTRGZYeUl6UnRUNzk3djltV3hFSDljZlhT?=
 =?utf-8?B?dTlxSHEvOHMvTUZyWnh1NzVHYThmNUE5emlPSUFuV0R3MHZ0bk9QelhHTmlp?=
 =?utf-8?B?ZGk3ejZxc2F3Smk1QVRPZzF4TmpQS1hnT1poSE91SUpab1c0WEtWVG9Zalor?=
 =?utf-8?B?MkJ1aEVBWkNRNGhRbVc0bEpDeW55UUpnNlQ0VkxZSVJMdkF5dWFNSVBWREk1?=
 =?utf-8?B?RXNMUkZQTDlMUkJOa092L2dTMWl6ZFZ3RFcwK3BDeHlUUGlNUlpGV1NLYUUy?=
 =?utf-8?B?eDRRYjcycUptRzl3U3Z4Tlh3UU5hdGhPclVDditvVml0c1A1Y2tzQXlIL1hR?=
 =?utf-8?B?TjArWnNiOG9yMkY5Tm9EcUx3SHNEaHVEeEcyUFZZZENWRlIyLzFuY0lFTDJZ?=
 =?utf-8?B?ekJ5TTR5SGJiRXNLTTA2aUFRSlkyNi9RQVBhSGZIemNQT2hlekNLS3E2cGJl?=
 =?utf-8?B?NzRodjkyUS9IQXF1ZDdSNjRGYndrQU1uOWdyVkVReVJsWTZpZmdRL0tla0No?=
 =?utf-8?Q?U08xvMiR6DY3km4fksEQIhrqm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f60ae60-ee38-4814-a4a4-08dbbfcbf783
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 02:38:15.4878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fnDmPOwR3QU0L+CkVx1pQ07/WsQ2YpWSCO8pOHX29C/7b7ZHwnj+GSAACuxLF4lXlOwtKQF7VEqQ6Fs6rbvnNY8uqweTte3FHt0dMI7UeWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4834
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDI3
LCAyMDIzIDk6MTQgUE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDExLzEyXSB2ZmlvL2NvbW1v
bjogSW50cm9kdWNlIHR3byBraW5kcyBvZiBWRklPIGRldmljZQ0KPmxpc3RzDQo+DQo+SGkgWmhl
bnpob25nLA0KPk9uIDkvMjYvMjMgMTM6MzIsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSW4g
VkZJTyBzdWJzeXN0ZW0sIHRoZXJlIGFyZSBkaWZmZXJlbnQgVkZJTyBkZXZpY2UgaXRlcmF0aW9u
IHJlcXVpcmVtZW50cy4NCj4+IE9uZSByZXF1aXJlbWVudCBpcyB0byBpdGVyYXRlIGFsbCBWRklP
IGRldmljZXMsIHRoZSBvdGhlciBpcyB0byBpdGVyYXRlDQo+PiBWRklPIGRldmljZSBpbiBzYW1l
IGNvbnRhaW5lci4NCj4+DQo+PiBDdXJyZW50bHkgVkZJTyBkZXZpY2UgaXMgaXRlcmF0ZWQgdGhy
b3VnaCBWRklPIGdyb3VwIGxpc3Qgd2hpY2ggaXMgZ3JvdXANCj4+IHBlcmNlaXZhYmxlIGFuZCBs
ZXNzIGVmZmljaWVudC4NCj4+DQo+PiBJbnRyb2R1Y2UgdHdvIGtpbmRzIG9mIFZGSU8gZGV2aWNl
IGxpc3RzLCBvbmUgaXMgYSBnbG9iYWwgbGlzdCwgdGhlIG90aGVyDQo+PiBpcyBwZXIgY29udGFp
bmVyIGxpc3QuIFdpdGggdGhlIHR3byBsaXN0cyBhZGRlZCwgd2UgY2FuIG1ha2Ugc29tZSBtaWdy
YXRpb24NCj4+IGFuZCByZXNldCByZWxhdGVkIGZ1bmN0aW9ucyBncm91cCBhZ25vc3RpYy4NCj4+
DQo+PiBGb3IgZXhhbXBsZSwgdmZpb19kZXZpY2VfbGlzdCBpcyB1c2VkIGluIGJlbG93IGZ1bmN0
aW9uczoNCj4+IHZmaW9fbWlnX2FjdGl2ZQ0KPj4gdmZpb19yZXNldF9oYW5kbGVyDQo+PiB2Zmlv
X211bHRpcGxlX2RldmljZXNfbWlncmF0aW9uX2lzX3N1cHBvcnRlZA0KPj4NCj4+IFBlciBjb250
YWluZXIgbGlzdCBpcyB1c2VkIGluIGJlbG93IGZ1bmN0aW9uczoNCj4+IHZmaW9fZGV2aWNlc19h
bGxfZGlydHlfdHJhY2tpbmcNCj4+IHZmaW9fZGV2aWNlc19hbGxfZGV2aWNlX2RpcnR5X3RyYWNr
aW5nDQo+PiB2ZmlvX2RldmljZXNfYWxsX3J1bm5pbmdfYW5kX21pZ19hY3RpdmUNCj4+IHZmaW9f
ZGV2aWNlc19kbWFfbG9nZ2luZ19zdG9wDQo+PiB2ZmlvX2RldmljZXNfZG1hX2xvZ2dpbmdfc3Rh
cnQNCj4+IHZmaW9fZGV2aWNlc19xdWVyeV9kaXJ0eV9iaXRtYXANCj4+DQo+PiBUaGlzIGlzIGEg
cHJlcmVxdWlzaXRlIGZvciBmdXR1cmUgSU9NTVVGRCBiYWNrZW5kIHN1cHBvcnQgd2hpY2gNCj4+
IGhhcyBzYW1lIGtpbmQgb2YgaXRlcmF0aW9uIHJlcXVpcmVtZW50Lg0KPj4NCj4+IHZmaW9fZ3Jv
dXBfbGlzdCBpcyBwcmVzZXJ2ZWQgZm9yIHNvbWUgZnVuY3Rpb25zIHdoaWNoIGhvbm9yIGdyb3Vw
DQo+PiBpdGVyYXRpb24sIHRob3NlIGZ1bmN0aW9ucyBhcmUgYWxsIHJlbGF0ZWQgdG8gbGVnYWN5
IGJhY2tlbmQuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBBbGV4IFdpbGxpYW1zb24gPGFsZXgud2ls
bGlhbXNvbkByZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4NCj5UaGlzIG1heSBiZSBzcGxpdCBpbnRvIDMgcGF0
Y2hlcw0KPjEuIGNyZWF0aW9uIG9mIGNvbnRhaW5lci0+ZGV2aWNlX2xpc3QNCj4yLiBjcmVhdGlv
biBvZiBnbG9iYWwgZGV2aWNlIGxpc3QNCj4zLiBhZGRpdGlvbiBvZiBjb250YWluZXIgZmllbGQg
aW4gdmJhc2VkZXYgKHdoaWNoIGlzIG5vdCBkZXNjcmliZWQgaW4NCj50aGUgY29tbWl0IG1zZyBi
eSB0aGUgd2F5KSBhbmQgbG9va3Mgc29tZWhvdyB1bnJlbGF0ZWQgdG8gbWU/DQoNCkFoLCBvaywg
SSBqdXN0IHRob3VnaHQgYWRkaW5nIHBvaW50ZXIgdG8gY29udGFpbmVyIGlzIHRyaXZpYWwgd2hp
Y2ggaXMNCmNvdW50ZXJwYXJ0IHRvIGNvbnRhaW5lci0+ZGV2aWNlX2xpc3QuIEFuZCB5ZXMsIEkn
bSBmaW5lIHRvIHNwbGl0IGl0DQppbnRvIDMgcGF0Y2hlcy4NCg0KVGhhbmtzDQpaaGVuemhvbmcN
Cg==

