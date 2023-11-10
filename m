Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0157E7B26
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 11:05:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1OMu-0001E6-E3; Fri, 10 Nov 2023 05:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r1OMs-0001Cg-9U
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 05:04:02 -0500
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r1OMn-0003rH-Hx
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 05:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699610637; x=1731146637;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=if05VVcvdrLNMn7OIzz+PyOwm+QUy7r0QO2tswkNHMw=;
 b=KDRxJH7BLohaKxabifVCprF9oY/O8RAyhMwBeMib+J3lEuxSFy6xxX1R
 d6vZycHXzI9D3U31SecmEPNlDf1X1nzdogpdxSS+sgc5YE18RtUw5aeew
 UwS37K0dL7K51MqjMPhQi3AkFhXTTPdTJPyrQ+rh2uFKmJkc8uNQMV+mV
 I+Y+hFutGVdGfY2cpn+zArhZ9QmH2g3o7pzo8d+2+EKE92/m68AtyexNF
 PUOS0Y8mp2emU7J0WydlqRaH/BzV1UswaRHeplyb+QS9YjLNEbLG2ReZq
 Xy0862LvwjCk87WcjKv16ykMgNbDr9C+/gHvvfpqkjJIDnmDgWogpCFPj Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="393038643"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="393038643"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2023 02:03:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="763717743"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="763717743"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Nov 2023 02:03:53 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 02:03:52 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 02:03:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 02:03:52 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 10 Nov 2023 02:03:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dogeqVZYSIRGY07gFFGDvWAOPBYjN6d23JuHclSx/6CrRe3L3ssk1Awg6ZthhSb74tTHEmYIuPOTB7iC9J7pABTWbSa7eCyz+mYX9kDvYXMdb2cqdRSiobnRLOw6Fn7xUb/ujgLgfLatQOVtVUh3W2ArIXU7zfWSOwcgWSVUwioTSeiTu0mSaaxgmKojuV5ZmGtS/TQaJfG+FY/FhI2Fr5kcZ6LuLGM8JQBTVmbJt/VEKTYSejizStt7ilGCXGhH4mA0wjpIyRVntT5/dL4An3iplSWE6zlBHJKCSFrP71bBFRl4cw3Fgvv7/5B+zkh3rEE+wXKNsuthhDefVgjhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if05VVcvdrLNMn7OIzz+PyOwm+QUy7r0QO2tswkNHMw=;
 b=XuvO1IWZkPvsy9vcfYQVfEn2vNlSaelNxOZOzJJkG9S9drGMEriWTHi0NUQ/GIyBYLEU0B3meCOEG9KdAl0Uvrtqzjn1hEYwFMKJ6CI+UJnWiAZJxojaJZmGZAAkAbOQAux8FQ8iXxNBRRYPhpTH74XzEwRGik7KW8Rs+tTtp1Rh/8ij/ERcukevTebTvC6YELdO7REQVAdWQmTO3YYj1r6SX1u2j6iw0FUsRNwqYqbyzJ5zTUbKMg5Dw4eN78CzqcA26j1EXnyftTVfPKqKmvpUwNCAce14PtBclhycP89t76TG8hhO+mGk6DfIiSDooVbc+wqX+8Os8Yhu9DitUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB6406.namprd11.prod.outlook.com (2603:10b6:8:8b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Fri, 10 Nov
 2023 10:03:50 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 10:03:50 +0000
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
Subject: RE: [PATCH v5 05/20] vfio/iommufd: Add support for iova_ranges and
 pgsizes
Thread-Topic: [PATCH v5 05/20] vfio/iommufd: Add support for iova_ranges and
 pgsizes
Thread-Index: AQHaEwR2gNJzVF6/z0+lxIPW6BywbrBzTK8AgAAGimA=
Date: Fri, 10 Nov 2023 10:03:49 +0000
Message-ID: <SJ0PR11MB67444D635637B8FC8639CF6B92AEA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
 <20231109114529.1904193-6-zhenzhong.duan@intel.com>
 <a83922bb-8c53-47d8-b15a-8a7052f02053@redhat.com>
In-Reply-To: <a83922bb-8c53-47d8-b15a-8a7052f02053@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB6406:EE_
x-ms-office365-filtering-correlation-id: f0f37638-d5d0-46d7-f988-08dbe1d45621
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sixyXTo0vvqzdo1J5EIgfcv6ei1/E2sobDiiH9+/LvepmcMn5thM7oBHIPxCvXYxOhiU3Ki+Xy88LOCJiNIVg3gk/tamFbtMZv6sfFnBazMp91ak3UlzMgPw3uB+6eOmt91U1PD0bEy7b5MKlHtteDprnaMdC9X9pryH/DcYF6El1gSJMkti5YvubDYoSeBv1ur/9ZivE8xhaIazFJvRLiN46qSo4oL7RaJ0grJ/r70wpPgyJWe2l7Thel3UCzELCS11TMotO3+rC57T3nGpw3GMyocRt8HMH/kUgUqbNkGPiq7Rja3t2CTV3MpokQxrxa+VwDxUAGd1hJHbkCCL22eCCm64zUtYL77hUYlK1I0QZTfyKdVHwK3wSc6nODmj5d4olRXqat1kfz/FsEcyWfmIuracn9tB8NbczKV2wGBnSTjf3jMJvHhfC4pN+Xp4DCtRSzzFS+t59Bj+9obT9TtlcIe6C8hRmsz9luKoyS7BZnIMrGIyvq2mSYJJadTdk3j0fghJneHWXpHP2Q1Is901zxnXONd/KvPK+gYs/u535YBTB408OcFdbrESPAClwz6OPt3wkrs3HWzjFW0EmZiUvNA67flyuP5XEKYflK2KJbsMCNpQDURVSkaTTwCX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(110136005)(82960400001)(38070700009)(107886003)(66556008)(83380400001)(66476007)(76116006)(26005)(66946007)(122000001)(6506007)(7696005)(478600001)(71200400001)(9686003)(66446008)(8936002)(8676002)(52536014)(4326008)(41300700001)(55016003)(86362001)(5660300002)(38100700002)(2906002)(316002)(64756008)(54906003)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEZ2VVd4Q3ZBSG5YdUhpUW04WnhrOThJZ2lHZnVVTjBPOGVoTjY2akUxUHhP?=
 =?utf-8?B?MGVkdUZKY284ZUt5WmorZWVQNHM3YU5qVUQ1WGxXZHNKSlFlSzBpckJoM1p0?=
 =?utf-8?B?ZG9rM3ZBYUNBZm9wVFZWWjZCN3BPV1hKVmZ1RldTY2lWTmw3blRQclNZKzJB?=
 =?utf-8?B?cnhZUmJucktDWDNJZ2lHbE1QTFpvemdyeUN3T2RoWHZnVUxqSGVDZzhGVUhQ?=
 =?utf-8?B?Qzdid2xHU2tTeGVYMjFIS0FsN3pnWTh0L1laM0lrNWtGUXFUMnJyZWRsdHUz?=
 =?utf-8?B?UTA5QUc0N0RNc3dlRktQdTkyYlpOSzl1WTIvcVFhVHRjYlN5ajRlWkIybzZs?=
 =?utf-8?B?d1VYV0k3L2JCRk1oVitFZC9sbUVPVUk4T1hXUk5Ic1V6YWY3dHBBZTNUdDBM?=
 =?utf-8?B?NFoxWnp6eEY1R0xPb09WQzZJVVRqTTlwZDVSUjczMVN0RlJ4UFpjMnMwZ3g1?=
 =?utf-8?B?cU40dktkdjdzRWNFcHl1SGErSVVmVnBRbW1ocnVRSXYyT2dwYXVYVFl4Yjda?=
 =?utf-8?B?QnBwdWJUN1ZwYkxLVWo4cDNtUEhGV1pIMHBWeDRUVkpsRnc5aGszWnRWVFFS?=
 =?utf-8?B?d29hdlFZc2JlTnQ2WDM0aHNTd0pYbHE2R25IcktjTmVmeXFrQVlyeTd3L3pq?=
 =?utf-8?B?M0doZHJ4dk1zbTNYNXBUOStiMElCU1ljRFgvcCtvaEdIUGovbER6S2RuS2ZP?=
 =?utf-8?B?TFZlZzdPWXpVWDRSUlhSVmNjN3ZGaTM0SUVLcnpMSUM4dGxyODUwb3R5R0pw?=
 =?utf-8?B?b043VjZDOWQvRnJKRHZndjBHVjVxNXdUUHRIamx4d3ZCM0hhd2xNQW9RWnJM?=
 =?utf-8?B?eWdhKzh2MW5BbjYyU3VUSjAvNzc3d2s3TWhVMStreGU1bU1hTnhMQm1yc2ti?=
 =?utf-8?B?a3ZHMXQ3K21MeE45cHh1SElNQkRBeU82RzhhUE5zZWoyU2FscEFQVWFkcEtt?=
 =?utf-8?B?WjVERFBzTWpCcWw5bWtQRTRBRFg5TTQ3U1I0a0dJR2g3Y3pvTTBITG5DaUZV?=
 =?utf-8?B?dmNBeWdkNE9Yb1hmaytUcFZNNmVka0VIM1lsbmdnREVXaGdjVjEzQnNERE9E?=
 =?utf-8?B?Tjdmc285bXVGUFVPMHdtOG1Bb0NKcWdmdTJpOVhCdHgxdDdQQTdSbzI0V0kw?=
 =?utf-8?B?c085RFErcXoyY3REbWU1UHhrSlZJNnBUWkl3UmR6bzdSc0QxeE5uUDBUYTZn?=
 =?utf-8?B?eWx0TEh0WHQ2NDBzQ2t6Z3hRR09rME16bWk2NVA4NEhZTldqYWdiNnJlWkl3?=
 =?utf-8?B?NWRnNmhDeVR6VGR1ZSt6eTRLbWcxQWZlYm1UaS9PcTlUUFhQR3RQN1QxcStw?=
 =?utf-8?B?VnErMXhiTDBNQ25hT1lCK2RGQ05NVncwcjhvVzZHMG9QbzZnSjZ6bllYZFMx?=
 =?utf-8?B?enB3WUtnRE1lMlFNSmFzZzgyd1FSL3I5OUs5L3BLNVpIc2g2dkpicVl4STE3?=
 =?utf-8?B?WjNJOWhZTlRDL3RXTTlQdVM5bjhzZUV4Yk1tTzBSTWhoWGdnTmlBREZNOEIw?=
 =?utf-8?B?MFlmSnNJenNscFBiRmNsc09iQUg1R0pVbXZFd25heDZWeUVLM0VMSkladTFG?=
 =?utf-8?B?NWNBc01IUFNJNmE3cFptbzh2blhuOXlUM1B3anVzQVZydWh0eVVFV0xjM3Zy?=
 =?utf-8?B?WXI0c0w0a2k3QnJUaWdaVW9QL2xabFJYT2N2Y0RPV3ZJd0g4MUIzaFFZSHlZ?=
 =?utf-8?B?WW4wdWJGcnJyOU9nTER4L0ZtNXpKd1RKcnpwVWl1RUhGRTQvb2JlSHZjQzVO?=
 =?utf-8?B?R1RxSVAxaXVRUERodm83ZTVLZEcxalhRL2YrYWJmZTJKVTFaaVFYYWxFQTFF?=
 =?utf-8?B?UUM1d0ZQRXZqOTQ2dGFKUVF6WElXZXd1N0lTc3lDWDExMDBDdzZMcG9NYXFI?=
 =?utf-8?B?aTU3ald2UUdMdUt0ZnBDS2o0MUJUamlhUDVmQW9jVC9jaWd4djU4NmlsYmNx?=
 =?utf-8?B?dGhYNEZ6bDlQSGJIVVVXM3ZINGxTTDJPTGtBd0N6MFhKbTFZZGZCbUY1anBY?=
 =?utf-8?B?VVRJWFFpMjNwaFp6Z20rMXF5ckt4bDRhaUhhQ3lxcXBwQ3A3VnkzL29iVXd5?=
 =?utf-8?B?Z3pjczNJdzVnbzhzQ3NDWDI1RGJPbGdZKytJbVJaZTdpRnhMcHZnTmhxWjBk?=
 =?utf-8?Q?/cVpRuQ5Lx6mIh/c3PiyEMC21?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f37638-d5d0-46d7-f988-08dbe1d45621
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 10:03:49.7336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/uRNqoClI7rtaNsh5IZw1ZTy1ZHy0WzJIpF1j0s+sUdKBgcyaFxraaDQpwRoZKDWo5KELNfZoUPg5XUVnvR0IsYLTNPcT3W5RJGBdpUBhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6406
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTAs
IDIwMjMgNTozNiBQTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDUvMjBdIHZmaW8vaW9tbXVm
ZDogQWRkIHN1cHBvcnQgZm9yIGlvdmFfcmFuZ2VzIGFuZA0KPnBnc2l6ZXMNCj4NCj5PbiAxMS85
LzIzIDEyOjQ1LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFNvbWUgdklPTU1VIHN1Y2ggYXMg
dmlydGlvLWlvbW11IHVzZSBpb3ZhIHJhbmdlcyBmcm9tIGhvc3Qgc2lkZSB0bw0KPj4gc2V0dXAg
cmVzZXJ2ZWQgcmFuZ2VzIGZvciBwYXNzdGhyb3VnaCBkZXZpY2UsIHNvIHRoYXQgZ3Vlc3Qgd2ls
bCBub3QNCj4+IHVzZSBhbiBpb3ZhIHJhbmdlIGJleW9uZCBob3N0IHN1cHBvcnQuDQo+Pg0KPj4g
VXNlIGFuIHVBUEkgb2YgSU9NTVVGRCB0byBnZXQgaW92YSByYW5nZXMgb2YgaG9zdCBzaWRlIGFu
ZCBwYXNzIHRvDQo+PiB2SU9NTVUganVzdCBsaWtlIHRoZSBsZWdhY3kgYmFja2VuZC4NCj4+DQo+
PiBBbHNvIHVzZSBvdXRfaW92YV9hbGlnbm1lbnQgcmV0dXJuZWQgZnJvbSB1QVBJIGFzIHBnc2l6
ZXMgaW5zdGVhZCBvZg0KPj4gcWVtdV9yZWFsX2hvc3RfcGFnZV9zaXplKCkgYXMgYSBmYWxsYmFj
ay4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5A
aW50ZWwuY29tPg0KPj4gLS0tDQo+PiB2NTogQWRkIG1pc3NlZCBwZ3NpemVzIGluaXRpYWxpemF0
aW9uIGluIHZmaW9fZ2V0X2luZm9faW92YV9yYW5nZQ0KPj4NCj4+ICAgaHcvdmZpby9pb21tdWZk
LmMgfCA0OA0KPisrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2h3L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+IGluZGV4IGVhNGUy
M2Y0ZWMuLjk1OGMzZTc5NGYgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2lvbW11ZmQuYw0KPj4g
KysrIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+IEBAIC0yNjcsNiArMjY3LDUzIEBAIHN0YXRpYyBp
bnQgaW9tbXVmZF9yYW1fYmxvY2tfZGlzY2FyZF9kaXNhYmxlKGJvb2wNCj5zdGF0ZSkNCj4+ICAg
ICAgIHJldHVybiByYW1fYmxvY2tfdW5jb29yZGluYXRlZF9kaXNjYXJkX2Rpc2FibGUoc3RhdGUp
Ow0KPj4gICB9DQo+Pg0KPj4gK3N0YXRpYyBpbnQgdmZpb19nZXRfaW5mb19pb3ZhX3JhbmdlKFZG
SU9JT01NVUZEQ29udGFpbmVyICpjb250YWluZXIsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDMyX3QgaW9hc19pZCkNCj4+ICt7DQo+PiArICAgIFZGSU9Db250
YWluZXJCYXNlICpiY29udGFpbmVyID0gJmNvbnRhaW5lci0+YmNvbnRhaW5lcjsNCj4+ICsgICAg
c3RydWN0IGlvbW11X2lvYXNfaW92YV9yYW5nZXMgKmluZm87DQo+PiArICAgIHN0cnVjdCBpb21t
dV9pb3ZhX3JhbmdlICppb3ZhX3JhbmdlczsNCj4+ICsgICAgaW50IHJldCwgc3osIGZkID0gY29u
dGFpbmVyLT5iZS0+ZmQ7DQo+PiArDQo+PiArICAgIGluZm8gPSBnX21hbGxvYzAoc2l6ZW9mKCpp
bmZvKSk7DQo+PiArICAgIGluZm8tPnNpemUgPSBzaXplb2YoKmluZm8pOw0KPj4gKyAgICBpbmZv
LT5pb2FzX2lkID0gaW9hc19pZDsNCj4+ICsNCj4+ICsgICAgcmV0ID0gaW9jdGwoZmQsIElPTU1V
X0lPQVNfSU9WQV9SQU5HRVMsIGluZm8pOw0KPj4gKyAgICBpZiAocmV0ICYmIGVycm5vICE9IEVN
U0dTSVpFKSB7DQo+PiArICAgICAgICBnb3RvIGVycm9yOw0KPj4gKyAgICB9DQo+PiArDQo+PiAr
ICAgIHN6ID0gaW5mby0+bnVtX2lvdmFzICogc2l6ZW9mKHN0cnVjdCBpb21tdV9pb3ZhX3Jhbmdl
KTsNCj4+ICsgICAgaW5mbyA9IGdfcmVhbGxvYyhpbmZvLCBzaXplb2YoKmluZm8pICsgc3opOw0K
Pj4gKyAgICBpbmZvLT5hbGxvd2VkX2lvdmFzID0gKHVpbnRwdHJfdCkoaW5mbyArIDEpOw0KPj4g
Kw0KPj4gKyAgICByZXQgPSBpb2N0bChmZCwgSU9NTVVfSU9BU19JT1ZBX1JBTkdFUywgaW5mbyk7
DQo+PiArICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgIGdvdG8gZXJyb3I7DQo+PiArICAgIH0N
Cj4+ICsNCj4+ICsgICAgaW92YV9yYW5nZXMgPSAoc3RydWN0IGlvbW11X2lvdmFfcmFuZ2UgKiko
dWludHB0cl90KWluZm8tPmFsbG93ZWRfaW92YXM7DQo+PiArDQo+PiArICAgIGZvciAoaW50IGkg
PSAwOyBpIDwgaW5mby0+bnVtX2lvdmFzOyBpKyspIHsNCj4+ICsgICAgICAgIFJhbmdlICpyYW5n
ZSA9IGdfbmV3KFJhbmdlLCAxKTsNCj4+ICsNCj4+ICsgICAgICAgIHJhbmdlX3NldF9ib3VuZHMo
cmFuZ2UsIGlvdmFfcmFuZ2VzW2ldLnN0YXJ0LCBpb3ZhX3Jhbmdlc1tpXS5sYXN0KTsNCj4+ICsg
ICAgICAgIGJjb250YWluZXItPmlvdmFfcmFuZ2VzID0NCj4+ICsgICAgICAgICAgICByYW5nZV9s
aXN0X2luc2VydChiY29udGFpbmVyLT5pb3ZhX3JhbmdlcywgcmFuZ2UpOw0KPj4gKyAgICB9DQo+
PiArICAgIGJjb250YWluZXItPnBnc2l6ZXMgPSBpbmZvLT5vdXRfaW92YV9hbGlnbm1lbnQ7DQo+
PiArDQo+PiArICAgIGdfZnJlZShpbmZvKTsNCj4+ICsgICAgcmV0dXJuIDA7DQo+PiArDQo+PiAr
ZXJyb3I6DQo+PiArICAgIHJldCA9IC1lcnJubzsNCj4+ICsgICAgZ19mcmVlKGluZm8pOw0KPj4g
KyAgICBlcnJvcl9yZXBvcnQoInZmaW8vaW9tbXVmZDogQ2Fubm90IGdldCBpb3ZhIHJhbmdlczog
JW0iKTsNCj4NCj5DYW4gd2UgcHJvcGFnYXRlIHRoZSBlcnJvciA/DQoNCkRvIHlvdSBtZWFuIHBy
b3BhZ2F0aW5nIHRoZSBlcnJvciB0byBjYWxsIHNpdGUgYW5kIGNhbGwgZXJyb3JfcmVwb3J0Pw0K
SW4gZmFjdCwgZ2V0dGluZyBpb3ZhIHJhbmdlIGZyb20gaG9zdCBpcyBhIGJldHRlciB0byBoYXZl
LCBub3QgYSBtdXN0Lg0KSWYgZmFpbHMgd2UgZmFsbGJhY2sgdG8gNjRiaXQgcmFuZ2UuDQoNClRo
YW5rcw0KWmhlbnpob25nDQo=

