Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D077B0359
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:53:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlT67-0004cf-8f; Wed, 27 Sep 2023 07:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlT5z-0004bs-2k; Wed, 27 Sep 2023 07:52:47 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlT5q-0003gH-Bg; Wed, 27 Sep 2023 07:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695815558; x=1727351558;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yEgRwIER1lkThS9JWvfUMVKdpZdEKWkTdUL4uKPHrFA=;
 b=a3wXQmnShQLJLr/zJogUww739/N+5zYvtsN+uh25OAOMnGzMV8phuHKG
 82tvpLWFErMQ5pWv5JX0i2gqiHADWKRCojzqlE92R6ZQeef/v79QTIVf+
 fpVlpl9jwpcvdne7rZYORVJSaX78HzRPs3PTS4LQfff/1cm5PEGBWdcwq
 3bn9z8iPgFkN8iBJVNGiwCDRjqCI3r/zFefLjFRixlCMus2GlvTGd/LRW
 DU4qhbp34NRZleHsfoTusdx2dFtQHl20Igg9WXgvuPbx4l2woZ6ku+xTm
 V2d3RKXsMNQJlKjpxsKRMEZCAsC2LKowIUooyQlTawN1qoGQjSxnUI73S g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="362055667"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; d="scan'208";a="362055667"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2023 04:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="819392144"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; d="scan'208";a="819392144"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Sep 2023 04:52:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 04:52:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 04:52:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 04:52:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKXu7LB6alyeW+nqzRheuQAEQJLOnOqd0wbZ90+/ZyqvCvmm8us8jt5QOdhu5ohJHE+9sy8mlHEi6E+L6w9K4uKvR/ty1Q9SLwjuVjxugfo+kFznHz14XPMIhCvdY65eLNBukaIJxDKfumrYZwlq+pVOZBVVEw2n3sMCNW2nW8xyFZdjW5mUo+P9SmW8BE3LeF+zmWCXVs5ZT8Dv6uFsdcoTwkUeQLk5Ns4w21SyJfW3ZqKLkbq7eo7U3iM6rdQZwST0v2zN1HhDCmn6WoV1mhLqsvdvW649D+8BNJZk2fbdfds03RMPWkKvhc/61XjR33xvg0wHbu4v8LJEZkxgYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEgRwIER1lkThS9JWvfUMVKdpZdEKWkTdUL4uKPHrFA=;
 b=ah7QJfZpR5/E68pyyDJKqnBo9V01fCyTipbDDMZ3YZK1D056bDMwEX36i5yon/EUpVG4iLkxMXUjCDdTfbVE/03NcK65uDwpfgVhQfqpmcFHfXE2awcBwCGt0WxRytVVaxp2vuKi69u5/eozGVb0v1BKmLi6vHfz+D3OcWQEYN895Q5THx7W2H09UXT5FliaN+cELtzrT5TJmbOTll8VyasF/ThjXSFaS/xFHxU4sEUemji2iLYWJaDjABBlLGEhcFKE0nR9LgNSfBOjrR3NsH7Lwvzlbbm6o+H3JkVQMGULJVr+Br3e3lLtqbKFWOvQibYu5M29gaxhNGCCxIaDug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by MW5PR11MB5931.namprd11.prod.outlook.com (2603:10b6:303:198::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 11:52:31 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24%3]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 11:52:31 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, "open list:vfio-ap"
 <qemu-s390x@nongnu.org>
Subject: RE: [PATCH v2 08/12] vfio/ap: Use vfio_[attach/detach]_device
Thread-Topic: [PATCH v2 08/12] vfio/ap: Use vfio_[attach/detach]_device
Thread-Index: AQHZ8G9VLwgGo0P7UUGFdxVvIkiJF7AuZaaAgAArHiA=
Date: Wed, 27 Sep 2023 11:52:30 +0000
Message-ID: <PH7PR11MB6722A8CD7B8CF95DA2FA92A492C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-9-zhenzhong.duan@intel.com>
 <78bc5496-a017-4f5a-a825-df992ef86016@redhat.com>
In-Reply-To: <78bc5496-a017-4f5a-a825-df992ef86016@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|MW5PR11MB5931:EE_
x-ms-office365-filtering-correlation-id: 72617550-e5c0-4940-0ccf-08dbbf503abc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c3FdrNM+ZCd19XSNBJflX4sV8HQ2yqZRkSXCAxPFIhPIDLzlVzx/bBZsZ/HG4kImMMC1vNs+k0XoBJC8jf5K1sahbdEAevLCCDuh4Dre4mQ6vPY7Bw5gn5DLk7PIb/9HHJXxOoO72g9B5038M9U2dOgqkNAddyEYIGOR+z+s0z25XATtYkAiPrhIfboRuJnzoW5kNvO8R6Ls+IPOPXs1jZcTRA/wAKS5UfKEfGfaVnbXNONvhinJ4/dWawn7eA36Gm9+0K6NDvFFblJAWVHgCnibntQBMN+/ujE8Ti16xADaQ3xpLmHHs4AbQ296iwPCR+O+D99X5MetWYtUDrENyl0W2/MHLPHBogUTdEF0Nw4jggJnJUehWM6Glv0J9Qg1qZLNyIlUv2BfTCET0IDajtp8yQopubz5t/q283V8xdRqdDkx3yVJRi1GF2aJPX/kn67z6+L8sZQLxHockMC+q3/l00g6rajHiW4U7HBTUn2FY38An1+1n7tuKoCdhlkHL5Yfc5lrfgu3kCUmjSF77wkB89TmrHs4195BJBkSrrtzCzrD1FgYMWDx+S+O7BswaMWzf49e9zVaJVv2SfkhbMUouko1T1vpMjDRhaABnxrnC3uR2tA/+K+TQNEIB9B6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(6506007)(9686003)(7696005)(86362001)(33656002)(38100700002)(55016003)(82960400001)(122000001)(26005)(2906002)(66446008)(7416002)(8936002)(478600001)(71200400001)(52536014)(83380400001)(5660300002)(38070700005)(54906003)(8676002)(41300700001)(66476007)(76116006)(4326008)(110136005)(66556008)(316002)(66946007)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjJRektFSFYzQnBIakc5dWRZU2x5L2F2OFpFVVF4NXQ4MHRvVjdQWEJZV0JS?=
 =?utf-8?B?YjVCRnVGYlNJNmxnVFpMLzIyQVNsM0krOEJYcmsvRnBKRmJMZ0lzS21yTTJX?=
 =?utf-8?B?UzRiUG9jQ3N6Z3k5Mk5CVlBaNEI1N2ppd2VvWUZwTTlPYnIzcnhDZUJQWjZ2?=
 =?utf-8?B?ZzR5a1pEb3pJWmx5cDA1dkhYZkEyWk9qTzJFZ1FmMjBzVlhJeWtKODZMb3BN?=
 =?utf-8?B?YzVDWXhaNmt2N1Z1dis3aXlwSWtNaHNPZktBdzBtSlVia2Z6TkdMa295ajRR?=
 =?utf-8?B?d3JPbzlmUnd2NHBLRkZSS3hldmlKZXBOYlZCeTdGV1FUUkpyVnZKWVVNMnNT?=
 =?utf-8?B?cUFZcmlCbDZQSXp4WWVzNS9nMkZwcTYyY3RoMGh5WEJ0UG5mblJ6RXRIZFNN?=
 =?utf-8?B?b3QzeVpmbW5CMU5TQ0FMUHZ6cSt2TzdCbDFWVkFZTXh0eDlqOFRKRW1MUGZt?=
 =?utf-8?B?aTVUYU1YMGhOc2RNRFpjMHZqS3BsWVhNa0JDSUl0VTRTd0IxU0RGRk5QcTJN?=
 =?utf-8?B?a2kxb2FnMU9kQWVCWFhQQzcxWWlwdVllcEZOU1pMTWRwZW0vdFBIbnlQMnd5?=
 =?utf-8?B?eVJ1YXRBbHZROTVHS1B0bUwxQ3ZqdkJZOGd5THdXVnRGQi9hNjlsaDdjK2ht?=
 =?utf-8?B?eGQvRlhoRXdFbHlqWjlySnVSWHhTMVFDQ1NFVE42KytHallCbjdoQmY3RGlp?=
 =?utf-8?B?dEdxeTJrS2xVNFJ2WW9peDJ1dEh2K2cycGdzemVLRTZab3g5eUE4N2Q5ZTc2?=
 =?utf-8?B?bkVMdHpkcFRBTmVaemVCYzN5dnNYQzdPcG83OUVUejN5TEowOHBCNmJ6STQ1?=
 =?utf-8?B?NmxrU3ROL1pGMUZyNzFDVXU4TUQ3NnhuRi9HQ3VEbit1VkxJZFdMZEJKT2c4?=
 =?utf-8?B?bWFsOTY5a2lKd2txbGpnK1BLTVdPclNBdVU5RUpwdGxJNmFiVDJTUW84aVVh?=
 =?utf-8?B?ZDZxNHZ1UkdNVHhNNnh3ak5iV3VoaFhnb1JrVXR0V2xiRlJuTXVIWjRNNWF2?=
 =?utf-8?B?VlhKZXNEa2M2bkQwb3QzTDRGYXpZMVlDc0c0VUF5WGJINzV4ZG9XeEVrSmpR?=
 =?utf-8?B?TVg2bldCU3p6U0FSUlNXaklGMU82d214Tnh4ekJLQ1BMTFVkNklaWnJKUlMr?=
 =?utf-8?B?ME1FV0VRa2p3UmttakVXTTZYUHNoNnN3b2dnbUVpL3c2T3lGT0duSzh2bitw?=
 =?utf-8?B?WWttSkd6ZHNTdEQwMEF6aXpNckV3VVNrenFiWFpWa1A4Z3NVWjFpTC82SnhG?=
 =?utf-8?B?NzI4Zml0QmVEcTl4SGdMUmxGcWtnM3NJYlh0eVBJZzBZMXo3eE5ka0dMei82?=
 =?utf-8?B?VHFvU0thWXZXUFg4eklaTkFCQkRMd08wOEE0QkxoZVlacUI5d0FoalRvZFlL?=
 =?utf-8?B?SENxYTY1NC9mNThubDRHZVAzbmxmUzVEVGpYdXRLYndLZmJrNHpwUXAwU3V6?=
 =?utf-8?B?eGd0VlJyV1E1RW01em5YdVRENGh0M0tWanpJa05FVkdwSldOMTYrVnIrS3Jj?=
 =?utf-8?B?eTRrVGlRaXJhN0hYUEZJRldxeHpMak8yNkxSRG5wVk1ZdFMzYXlEemFuNkxn?=
 =?utf-8?B?UDFlbmxiM2pscnk3SkRsSUYwaTdEZTlKTUtBMk5LQ2F2N1Rnd3lxM1loR0U0?=
 =?utf-8?B?K1ZPZVRIQ09QZjdJN3NNWVpMWU84RksydnRxeFNHSWNvTUdIODA2WUVHV1dV?=
 =?utf-8?B?cFdKUnArcVQ2REMzbHhTeUV1NmJYSEREODVGOXhXNmkrbEl1ZmZ0SFdNODZL?=
 =?utf-8?B?Ym0xa0huQnBST3hqVXdlYzVkYWQxVENGNWJmZWI4OEpiOERRVWhpaWQxSXZs?=
 =?utf-8?B?Zk1NeWVMWFlreG5KTjYzZnF6eW1WR25Tdm42emZBeS9ZbkdMTlhYdEhOQXBq?=
 =?utf-8?B?YW16bjJvU3Fod0pKZWd3ZlN3NG1jRzBLQlRuNEZyMHZ0RytTZVZySG1uVUMy?=
 =?utf-8?B?SEVuUmVySVN4OU9TOGNMV3FoSGpXeEZQT0hzYnh4dklvRkpKYlBmWWVleWFC?=
 =?utf-8?B?UzZuT2U4cFpMSHRlWFRkdFZMVVhBQWJuUUxUZ3ZTSDJscVFadHY3WjdyYldB?=
 =?utf-8?B?MDM2Y0pUWkdXSWIwMy9STFNsRTBLbjNqMmVXOTc1MS84S283OGxFNlloU0c3?=
 =?utf-8?Q?eCY9wwKJuTjeQof5I6Y38Jg9W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72617550-e5c0-4940-0ccf-08dbbf503abc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 11:52:30.6316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vChhP7WlGlkiAQpsl2gG8tsFxIruSj9FoWAUzxjFgRmqzNeuaqhPwE/W1WQCENoABYaumK0JcZhvfwqmkNZ/3gsFjKym28xqVJSYiScqsm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5931
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNywgMjAyMyA1
OjE2IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAwOC8xMl0gdmZpby9hcDogVXNlIHZmaW9f
W2F0dGFjaC9kZXRhY2hdX2RldmljZQ0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5PbiA5LzI2LzIz
IDEzOjMyLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj4+DQo+PiBMZXQgdGhlIHZmaW8tYXAgZGV2aWNlIHVzZSB2Zmlv
X2F0dGFjaF9kZXZpY2UoKSBhbmQNCj4+IHZmaW9fZGV0YWNoX2RldmljZSgpLCBoZW5jZSBoaWRp
bmcgdGhlIGRldGFpbHMgb2YgdGhlIHVzZWQNCj4+IElPTU1VIGJhY2tlbmQuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4gU2lnbmVk
LW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBa
aGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaHcv
dmZpby9hcC5jIHwgNjggKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA1NyBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9hcC5jIGIvaHcvdmZpby9hcC5j
DQo+PiBpbmRleCA2ZTIxZDFkYTVhLi4xNmVhN2ZiM2MyIDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZp
by9hcC5jDQo+PiArKysgYi9ody92ZmlvL2FwLmMNCj4+IEBAIC01Myw0MCArNTMsNiBAQCBzdHJ1
Y3QgVkZJT0RldmljZU9wcyB2ZmlvX2FwX29wcyA9IHsNCj4+ICAgICAgLnZmaW9fY29tcHV0ZV9u
ZWVkc19yZXNldCA9IHZmaW9fYXBfY29tcHV0ZV9uZWVkc19yZXNldCwNCj4+ICB9Ow0KPj4NCj4+
IC1zdGF0aWMgdm9pZCB2ZmlvX2FwX3B1dF9kZXZpY2UoVkZJT0FQRGV2aWNlICp2YXBkZXYpDQo+
PiAtew0KPj4gLSAgICBnX2ZyZWUodmFwZGV2LT52ZGV2Lm5hbWUpOw0KPj4gLSAgICB2ZmlvX3B1
dF9iYXNlX2RldmljZSgmdmFwZGV2LT52ZGV2KTsNCj4+IC19DQo+PiAtDQo+PiAtc3RhdGljIFZG
SU9Hcm91cCAqdmZpb19hcF9nZXRfZ3JvdXAoVkZJT0FQRGV2aWNlICp2YXBkZXYsIEVycm9yICoq
ZXJycCkNCj4+IC17DQo+PiAtICAgIEdFcnJvciAqZ2Vycm9yID0gTlVMTDsNCj4+IC0gICAgY2hh
ciAqc3ltbGluaywgKmdyb3VwX3BhdGg7DQo+PiAtICAgIGludCBncm91cGlkOw0KPj4gLQ0KPj4g
LSAgICBzeW1saW5rID0gZ19zdHJkdXBfcHJpbnRmKCIlcy9pb21tdV9ncm91cCIsIHZhcGRldi0+
dmRldi5zeXNmc2Rldik7DQo+PiAtICAgIGdyb3VwX3BhdGggPSBnX2ZpbGVfcmVhZF9saW5rKHN5
bWxpbmssICZnZXJyb3IpOw0KPj4gLSAgICBnX2ZyZWUoc3ltbGluayk7DQo+PiAtDQo+PiAtICAg
IGlmICghZ3JvdXBfcGF0aCkgew0KPj4gLSAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiJXM6IG5v
IGlvbW11X2dyb3VwIGZvdW5kIGZvciAlczogJXMiLA0KPj4gLSAgICAgICAgICAgICAgICAgICBU
WVBFX1ZGSU9fQVBfREVWSUNFLCB2YXBkZXYtPnZkZXYuc3lzZnNkZXYsIGdlcnJvci0+bWVzc2Fn
ZSk7DQo+PiAtICAgICAgICBnX2Vycm9yX2ZyZWUoZ2Vycm9yKTsNCj4+IC0gICAgICAgIHJldHVy
biBOVUxMOw0KPj4gLSAgICB9DQo+PiAtDQo+PiAtICAgIGlmIChzc2NhbmYoYmFzZW5hbWUoZ3Jv
dXBfcGF0aCksICIlZCIsICZncm91cGlkKSAhPSAxKSB7DQo+PiAtICAgICAgICBlcnJvcl9zZXRn
KGVycnAsICJ2ZmlvOiBmYWlsZWQgdG8gcmVhZCAlcyIsIGdyb3VwX3BhdGgpOw0KPj4gLSAgICAg
ICAgZ19mcmVlKGdyb3VwX3BhdGgpOw0KPj4gLSAgICAgICAgcmV0dXJuIE5VTEw7DQo+PiAtICAg
IH0NCj4+IC0NCj4+IC0gICAgZ19mcmVlKGdyb3VwX3BhdGgpOw0KPj4gLQ0KPj4gLSAgICByZXR1
cm4gdmZpb19nZXRfZ3JvdXAoZ3JvdXBpZCwgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LCBlcnJwKTsN
Cj4+IC19DQo+PiAtDQo+PiAgc3RhdGljIHZvaWQgdmZpb19hcF9yZXFfbm90aWZpZXJfaGFuZGxl
cih2b2lkICpvcGFxdWUpDQo+PiAgew0KPj4gICAgICBWRklPQVBEZXZpY2UgKnZhcGRldiA9IG9w
YXF1ZTsNCj4+IEBAIC0xODksMjIgKzE1NSwxNSBAQCBzdGF0aWMgdm9pZA0KPnZmaW9fYXBfdW5y
ZWdpc3Rlcl9pcnFfbm90aWZpZXIoVkZJT0FQRGV2aWNlICp2YXBkZXYsDQo+PiAgc3RhdGljIHZv
aWQgdmZpb19hcF9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkNCj4+ICB7
DQo+PiAgICAgIGludCByZXQ7DQo+PiAtICAgIGNoYXIgKm1kZXZpZDsNCj4+ICAgICAgRXJyb3Ig
KmVyciA9IE5VTEw7DQo+PiAtICAgIFZGSU9Hcm91cCAqdmZpb19ncm91cDsNCj4+ICAgICAgQVBE
ZXZpY2UgKmFwZGV2ID0gQVBfREVWSUNFKGRldik7DQo+PiAgICAgIFZGSU9BUERldmljZSAqdmFw
ZGV2ID0gVkZJT19BUF9ERVZJQ0UoYXBkZXYpOw0KPj4gKyAgICBWRklPRGV2aWNlICp2YmFzZWRl
diA9ICZ2YXBkZXYtPnZkZXY7DQo+Pg0KPj4gLSAgICB2ZmlvX2dyb3VwID0gdmZpb19hcF9nZXRf
Z3JvdXAodmFwZGV2LCBlcnJwKTsNCj4+IC0gICAgaWYgKCF2ZmlvX2dyb3VwKSB7DQo+PiAtICAg
ICAgICByZXR1cm47DQo+PiAtICAgIH0NCj4+IC0NCj4+IC0gICAgdmFwZGV2LT52ZGV2Lm9wcyA9
ICZ2ZmlvX2FwX29wczsNCj4+IC0gICAgdmFwZGV2LT52ZGV2LnR5cGUgPSBWRklPX0RFVklDRV9U
WVBFX0FQOw0KPj4gLSAgICBtZGV2aWQgPSBiYXNlbmFtZSh2YXBkZXYtPnZkZXYuc3lzZnNkZXYp
Ow0KPj4gLSAgICB2YXBkZXYtPnZkZXYubmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiJXMiLCBtZGV2
aWQpOw0KPj4gLSAgICB2YXBkZXYtPnZkZXYuZGV2ID0gZGV2Ow0KPj4gKyAgICB2YmFzZWRldi0+
bmFtZSA9IGdfcGF0aF9nZXRfYmFzZW5hbWUodmJhc2VkZXYtPnN5c2ZzZGV2KTsNCj5JIHRoaW5r
IHdlIHNoYWxsIGRvY3VtZW50IGluIHRoZSBjb21taXQgbXNnIHRoZSBmYWN0IHdlIHVzZQ0KDQpZ
ZXMsIHdpbGwgZG8uDQoNCj4NCj5nX3BhdGhfZ2V0X2Jhc2VuYW1lIGluc3RlYWQgb2YgYmFzZW5h
bWUgaGVyZSB0byBtYXRjaCBvdGhlciBkZXZpY2UgaW5pdA0KPnNlZSAzZTAxNWQ4MTViICB1c2Ug
Z19wYXRoX2dldF9iYXNlbmFtZSBpbnN0ZWFkIG9mIGJhc2VuYW1lDQo+DQo+YWxzbyBsZWFrIG9m
IHZiYXNlZGV2LT5uYW1lDQpJIGZyZWUgaXQgaW4gdmZpb19hcF91bnJlYWxpemUoKS4NCg0KVGhh
bmtzDQpaaGVuemhvbmcNCg==

