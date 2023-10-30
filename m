Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F6C7DB236
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 04:14:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxIjN-0003G0-CI; Sun, 29 Oct 2023 23:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxIjL-0003Fo-CA; Sun, 29 Oct 2023 23:14:19 -0400
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxIjI-0005ID-7H; Sun, 29 Oct 2023 23:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698635656; x=1730171656;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8gQl+6r9kH85x1U8SdnQS2OyQZVQ2pU4+z0UM5hTu5E=;
 b=GjHODmn7TOY+dYYCbjUB/Izp+GXBYwv9ws8MYw3eZqlmQ6DDtZNQHFAf
 80YOl33l8wnkDDdzxxbH75jUX+PbI8MCLSVmolPsA/jC54frm2ZDGBM62
 1ucq0GTCulZYpuN7mzycOMYo9NArSRyNplkpEu5DqzVssrteBexAe1Zmw
 /COVUZRU+f1Qd68sIkZoSw9bw5iro4+9fkxuwZ/gmd8Av+ZsVGQS29nOf
 fiUwLR6mTbnz0c+Ck5p5JDcECoAgJS9xT6MdKH6htgNM7eJSmedRRpYq5
 EA4zz9tjLptlwGGO8gVbaHd/O+rY29kx2mxntyWzsJNDqXY7lsuC9bk0V Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="378378638"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; d="scan'208";a="378378638"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2023 20:14:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="736619780"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; d="scan'208";a="736619780"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Oct 2023 20:14:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 29 Oct 2023 20:14:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 29 Oct 2023 20:14:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 29 Oct 2023 20:14:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 29 Oct 2023 20:14:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVb3wDQIFEqFQImDOVai6BMxnoprX3V4OLN5afl7aRu45jzZaX6D3BtISic27ZCV4SvPEBwlqPlAMKM5VA+ys4PZEIY79zLO08We4FLxbWDqwqR17E+yVCvDSqdKyX3pnBo+LAOTiaRxxB6DApfIEW2jl8BTIPeUdHEcCDCy6ccBD7RLyiTSpPAXstbgNaGWWehc6aA/kfTfn4sEJCGTaLTDgJ2igBEpEvUPo0/ZBTd9mgrrGI8eNezfulYH11ICZh2zfGzKKEFpEW2fakRFP6fbAfrCWi9X1ei49gN0BGSDxv08L7cXDOkuJGuAb7dPJm4cqpuktmKKOdAQ1d3GRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gQl+6r9kH85x1U8SdnQS2OyQZVQ2pU4+z0UM5hTu5E=;
 b=SxlwZ4BThsSIvNvlNqEnfidvw//1HE8ldlJTq3nsr4+o2lSYv05GNQO8ZYkXJd2utwiREeGPgTJyYCxLtoBsSXfGLIxOOg+LD+S96aEupylNsSFuojwASnGHnockE1YQqQZ2FeftSQKtCGIJr6LA/ZMo+6I3NY50HfzoBMD92cAGbPVSFa3nxkYCWXjNI3wY+KG3fDUshMLx6dvUJFSJF5AJNErSvPjAt1Il13SS5Wgfo9loJiHCHkzbxzqeNLQkSiQufZZKCxDDxECWheyM466pdR+4IlQNkYViMYb1nF2HNtOtASvt3AcGpHrqYDKiPLEaSsm6RAXKr+cP/ApBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB6679.namprd11.prod.outlook.com (2603:10b6:806:269::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 03:14:06 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6933.024; Mon, 30 Oct 2023
 03:14:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Nicholas Piggin <npiggin@gmail.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, David Gibson
 <david@gibson.dropbear.id.au>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
Subject: RE: [PATCH v3 14/37] vfio/container: Move vrdl_list, pgsizes and
 dma_max_mappings to base container
Thread-Topic: [PATCH v3 14/37] vfio/container: Move vrdl_list, pgsizes and
 dma_max_mappings to base container
Thread-Index: AQHaB/nFH6P4Ule5nEa3zqkjNeOMLLBdyzWAgAPdYKA=
Date: Mon, 30 Oct 2023 03:14:06 +0000
Message-ID: <SJ0PR11MB6744DE88DF50BFBACD9D3D6492A1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-15-zhenzhong.duan@intel.com>
 <7603f300-1305-45da-9560-d073bdbc5036@redhat.com>
In-Reply-To: <7603f300-1305-45da-9560-d073bdbc5036@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB6679:EE_
x-ms-office365-filtering-correlation-id: 646699e9-bbd4-47af-2066-08dbd8f646dd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: opagShN9afFQa+iuxC+Rm0anMHp8OzUCwCpIG0yiiRyVG4heWkAadqPGFKxiQFvfH7i1JBDpvap2aDiG8IbwNAgeQEik2ykvFxKEeMaKtnxFWWRpfzjBy4nuiXOzh8kh3pCUzCODKj4XPFCZoopGQ19/ykJ47CpdUms991fWbaEChOYze1l3yar7qmYU82+66R/l46zIsLkaNu6q6Z9ry5zAp50Io8Jto/57J5liBsYkZM29vTieC0fAmJZ3i2xYZgBLmNWlp2y7tR+4vH4n/yQiH90PWgYkZ/GARPDUs8VQufO2zZ8OfKAfWltQoVQIElnFFgbkZXdT5dD5XLAolXif6sXS75hlWwBJw8GhX42RAvqpgfZdKYj1v0V13vtHgolMxm5BK6rw5qpuX0R2sj64JttBd4ki/skJ8Tr+60QxtSmElbiF3zpI7eOxgNqfj7UJt2LyMCS7O1lDJjMZYX4SVcKEBVKKhxXUNKnku//civs38feg1+K3dRcCP/bkZsD9hZZl9ICQXOlm4KbpJ0LBNZzREF9DYNH0tYOgFx0zZurYjHxNGtGwjZjUS9/ft5P7K9jaj4sBAmTAWbhJZZ1LzQh7B7Z4P8PG4Ph4paypn7RDWp4NtJ9v9sshZsZo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(83380400001)(5660300002)(7416002)(71200400001)(9686003)(6506007)(7696005)(52536014)(122000001)(82960400001)(8936002)(8676002)(33656002)(64756008)(66446008)(66556008)(66476007)(54906003)(316002)(41300700001)(38070700009)(66946007)(55016003)(86362001)(478600001)(76116006)(110136005)(38100700002)(2906002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFV6Q1JoM3FXU3lJZkpOOWoyUS8wN3dBQ0w5Z21la3R3WURFTmZaZE83ZGt2?=
 =?utf-8?B?Wjg2a0tDelJnZUdvblFwTHROMjd5K1ppd0p6dVRERGdySUR2bHBDZTB4dHRE?=
 =?utf-8?B?aXBxb1Y2V3FwZkVtTE9iMHozd1EyeEhKbUgzRGFKcjM3bEdBN2RzSXc5dWhZ?=
 =?utf-8?B?MXJ5Zk1GWjFCTUlNcXBGVExPb09KOWd5Z1JKSW9OWmkwVWNmOFVGZThhaEdX?=
 =?utf-8?B?dnZxVnJYWWV3L3RGUG41R0hQUXJNTVF2enh5RUpXbXFyNC9mdWZlTEhsdTcw?=
 =?utf-8?B?ejFjS1A5Yy9lM1JvNGQzaVYyRzh6K3hxLzZhaTNZSEdteDBNY0VuMVplOG81?=
 =?utf-8?B?Rk1QekoyYlZwQ2FxOXNUQkRxNzdJWW1XbUNORGhyenN1cVFUaWFVNHlXdWU5?=
 =?utf-8?B?aDlSUnhscDB6emVNcVB2ZHhUZjk0TWlUWU9DNStYQm1abGpCVGNPS1gzVUlw?=
 =?utf-8?B?SGNMTG5mSGNpMW5MRXNOM0xYelhlQVpwUVdQQit3b3c3Y1ZxZmhEY1U5Y1g1?=
 =?utf-8?B?UUVpSDRJaTRUemN2KzhjRnNzK3FSYk5sYXBQeGdRNnh0cS9jREFtVUFCai9B?=
 =?utf-8?B?YjhLeWtBNGNTcm5aaDVhUXZVU1oyQ1BsbWNhNGQ3d2lWTFppK1FSdWZTVkZn?=
 =?utf-8?B?cWU5ME80SWlXenBNWXVoNFVTbm5FdWFXSGdCcENTUlhUd2k1VzRaejVmTkxh?=
 =?utf-8?B?UHE3K1oyQitkQ2FWeG8yUEE4YXltdGx2WTVzbnZGUzVxZ3didld6WVpHekZW?=
 =?utf-8?B?c1VBaVAwKys2a1oyVm5lbDlUM1dxQXlFUGowOHVJczBOMjE0eXJBby9zM3Nu?=
 =?utf-8?B?V3ZqbERrNTBoU0FCN3hpUGYzTXN4WmVCVGpWTGZWUitpTERLcFlZOVQ4Wlda?=
 =?utf-8?B?SGZtTUFrZTBOdnBPNStVUUpBQjZRM2FZVWpUNW1ocnRXRFJPcm1MRW9SaGw5?=
 =?utf-8?B?YjFYaGlIcEgvTFF1VVNnZmpYck5aYUNNNzVxRm5rbkE3c3lmSGpQWmFNYith?=
 =?utf-8?B?UmJjRGNJalRJUndRVWlRMkpjWjYzMGRoZWpDa0ZrOHY0MzR6NHE2QVUxanJ1?=
 =?utf-8?B?ZSs2R3RWVmE3dlB5UTIwQzUvcTBFd2kzMGFaWnArekEwNk5abEhwTCtpWGlC?=
 =?utf-8?B?Y1hUNzQzeDRJRHdRRXQxaEVtOUhiczI1VEhIY1FFSHAwWG9CUWg1OG0zc3p4?=
 =?utf-8?B?MGFXbXBXendVVHJaK292TWtEcGc0YlNiem1KOWdlRU1WZDlNcDloMk1OL2Z0?=
 =?utf-8?B?eEl3TXlJWU1PU0tFL0k4QXI0OGIyY2Q3NmdLczNDQzhBRTRkSE5MMGpnWE9N?=
 =?utf-8?B?Z0Rsd083VmczRGx3WmcyMVJKeFRVVzJCaXhVMGpuNXkrcHptUmZWNlFWUXZG?=
 =?utf-8?B?M21ZdjNmVGRvdDByTEdlTFFXNHcwZ0I2N1BPWEN0TUJpUW5zZ3R3bE5IeThU?=
 =?utf-8?B?TXhRUlczWmplZ0xqSktjWmU1eFM5TXpWSkRmaGxxbjFDUVRFYmFNQU9saHRl?=
 =?utf-8?B?WTEvb0VZTjIxT2pvb09aUjBqK0FYZWlmQkZmaGh1UDI4NG40dEUxZ1dtRTJN?=
 =?utf-8?B?eXhkUDdaNFBsY2xRZWFKZVRRSlFLdzdQQldGLy9IcG9odHBGZXZJMENFT1lp?=
 =?utf-8?B?cXNUSEtMS2ZHY2w5cGJZZFB5L2c5OSs4SXdFWmJEZ0N6QXdTcTdybE5kbkxo?=
 =?utf-8?B?QzN2OWtsenVmRXFMZUs3UFFxaGVzM3JRZkpMNmdMb0FJZkIyNTNLSEllRW9E?=
 =?utf-8?B?RVN2M05HQ0hPc3RkRmRsdUF5ejNRTVNDUG53LzA5KzRaYVZwTWd5Rmw3L0xG?=
 =?utf-8?B?aHcxQVhBM2VVQ2pmZnUwdnh5RGoySVlBVzVIOEVtYWxqMW1PdmtSL0FIVzRB?=
 =?utf-8?B?a09HangxVk9BT0htN3VlR2l1S1BBL1FjamdjUm5TbUV0WjUvbU1WNVZ0UEcz?=
 =?utf-8?B?SDVhS3hRRVRrR2x4cTFkeTNpTWIzaUwyVE5NbmZzQng1L0xEUWkrbVloMXk2?=
 =?utf-8?B?aFV4WkNGYXVRdElpckFVOEdRVStQK2VXVTZwY1RGT0hFY1l5ZVNsMjRRVTRY?=
 =?utf-8?B?NUhrakNVTkhKUHBnbEd4NU10MzNnMmVxM3prYnROaTVpRVZUaUFLL1RpQk44?=
 =?utf-8?Q?085/xo5N3w3YdOv3biErrsAqW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646699e9-bbd4-47af-2066-08dbd8f646dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 03:14:06.5364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WPpQvAY51qep2X6fRiqE83kbMSqeHuJ4DwYe3Vd1Pce+9M0ZzK36nt6qBHJQRlacwiDFQju5orjHRzGOKYcSoskVwZ/V+KC56101jf7Kjd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6679
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IEZyaWRheSwgT2N0b2JlciAyNywg
MjAyMyAxMTo1MiBQTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMTQvMzddIHZmaW8vY29udGFp
bmVyOiBNb3ZlIHZyZGxfbGlzdCwgcGdzaXplcyBhbmQNCj5kbWFfbWF4X21hcHBpbmdzIHRvIGJh
c2UgY29udGFpbmVyDQo+DQo+T24gMTAvMjYvMjMgMTI6MzAsIFpoZW56aG9uZyBEdWFuIHdyb3Rl
Og0KPj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4NCi4uLg0K
DQo+PiAgIHZvaWQgdmZpb19jb250YWluZXJfZGVzdHJveShWRklPQ29udGFpbmVyQmFzZSAqYmNv
bnRhaW5lcikNCj4+ICAgew0KPj4gKyAgICBWRklPUmFtRGlzY2FyZExpc3RlbmVyICp2cmRsLCAq
dnJkbF90bXA7DQo+PiAgICAgICBWRklPR3Vlc3RJT01NVSAqZ2lvbW11LCAqdG1wOw0KPj4NCj4+
ICAgICAgIFFMSVNUX1JFTU9WRShiY29udGFpbmVyLCBuZXh0KTsNCj4+DQo+PiArICAgIFFMSVNU
X0ZPUkVBQ0hfU0FGRSh2cmRsLCAmYmNvbnRhaW5lci0+dnJkbF9saXN0LCBuZXh0LCB2cmRsX3Rt
cCkgew0KPj4gKyAgICAgICAgUmFtRGlzY2FyZE1hbmFnZXIgKnJkbTsNCj4+ICsNCj4+ICsgICAg
ICAgIHJkbSA9IG1lbW9yeV9yZWdpb25fZ2V0X3JhbV9kaXNjYXJkX21hbmFnZXIodnJkbC0+bXIp
Ow0KPj4gKyAgICAgICAgcmFtX2Rpc2NhcmRfbWFuYWdlcl91bnJlZ2lzdGVyX2xpc3RlbmVyKHJk
bSwgJnZyZGwtPmxpc3RlbmVyKTsNCj4+ICsgICAgICAgIFFMSVNUX1JFTU9WRSh2cmRsLCBuZXh0
KTsNCj4+ICsgICAgICAgIGdfZnJlZSh2cmRsKTsNCj4+ICsgICAgfQ0KPg0KPldoZXJlIHdhcyB0
aGlzIGRvbmUgcHJldmlvdXNseSA/DQoNCkdvb2QgY2F0Y2ghIFRoaXMgc2hvdWxkIGJlIHJlbW92
ZWQuDQoNCj5NYXkgYmUgdGhlIHZyZGwgbGlzdCBzaG91bGQgYmUgaGFuZGxlZA0KPnNlcGFyYXRs
eSBmcm9tIHBnc2l6ZXMgYW5kIGRtYV9tYXhfbWFwcGluZ3MuDQoNCkdvb2Qgc3VnZ2VzdGlvbiEg
V2lsbCBkby4NCg0KPg0KPj4gICAgICAgUUxJU1RfRk9SRUFDSF9TQUZFKGdpb21tdSwgJmJjb250
YWluZXItPmdpb21tdV9saXN0LCBnaW9tbXVfbmV4dCwNCj50bXApIHsNCj4+ICAgICAgICAgICBt
ZW1vcnlfcmVnaW9uX3VucmVnaXN0ZXJfaW9tbXVfbm90aWZpZXIoDQo+PiAgICAgICAgICAgICAg
ICAgICBNRU1PUllfUkVHSU9OKGdpb21tdS0+aW9tbXVfbXIpLCAmZ2lvbW11LT5uKTsNCj4+IGRp
ZmYgLS1naXQgYS9ody92ZmlvL2NvbnRhaW5lci5jIGIvaHcvdmZpby9jb250YWluZXIuYw0KPj4g
aW5kZXggOGQ1YjQwOGU4Ni4uMGUyNjVmZmE2NyAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZmaW8vY29u
dGFpbmVyLmMNCj4+ICsrKyBiL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4+IEBAIC0xNTQsNyArMTU0
LDcgQEAgc3RhdGljIGludCB2ZmlvX2xlZ2FjeV9kbWFfdW5tYXAoVkZJT0NvbnRhaW5lckJhc2UN
Cj4qYmNvbnRhaW5lciwgaHdhZGRyIGlvdmEsDQo+PiAgICAgICAgICAgaWYgKGVycm5vID09IEVJ
TlZBTCAmJiB1bm1hcC5zaXplICYmICEodW5tYXAuaW92YSArIHVubWFwLnNpemUpICYmDQo+PiAg
ICAgICAgICAgICAgIGNvbnRhaW5lci0+aW9tbXVfdHlwZSA9PSBWRklPX1RZUEUxdjJfSU9NTVUp
IHsNCj4+ICAgICAgICAgICAgICAgdHJhY2VfdmZpb19sZWdhY3lfZG1hX3VubWFwX292ZXJmbG93
X3dvcmthcm91bmQoKTsNCj4+IC0gICAgICAgICAgICB1bm1hcC5zaXplIC09IDFVTEwgPDwgY3R6
NjQoY29udGFpbmVyLT5wZ3NpemVzKTsNCj4+ICsgICAgICAgICAgICB1bm1hcC5zaXplIC09IDFV
TEwgPDwgY3R6NjQoY29udGFpbmVyLT5iY29udGFpbmVyLnBnc2l6ZXMpOw0KPj4gICAgICAgICAg
ICAgICBjb250aW51ZTsNCj4+ICAgICAgICAgICB9DQo+PiAgICAgICAgICAgZXJyb3JfcmVwb3J0
KCJWRklPX1VOTUFQX0RNQSBmYWlsZWQ6ICVzIiwgc3RyZXJyb3IoZXJybm8pKTsNCj4+IEBAIC01
NTksOSArNTU5LDcgQEAgc3RhdGljIGludCB2ZmlvX2Nvbm5lY3RfY29udGFpbmVyKFZGSU9Hcm91
cCAqZ3JvdXAsDQo+QWRkcmVzc1NwYWNlICphcywNCj4+ICAgICAgIGNvbnRhaW5lciA9IGdfbWFs
bG9jMChzaXplb2YoKmNvbnRhaW5lcikpOw0KPj4gICAgICAgY29udGFpbmVyLT5mZCA9IGZkOw0K
Pj4gICAgICAgY29udGFpbmVyLT5lcnJvciA9IE5VTEw7DQo+PiAtICAgIGNvbnRhaW5lci0+ZG1h
X21heF9tYXBwaW5ncyA9IDA7DQo+PiAgICAgICBjb250YWluZXItPmlvdmFfcmFuZ2VzID0gTlVM
TDsNCj4+IC0gICAgUUxJU1RfSU5JVCgmY29udGFpbmVyLT52cmRsX2xpc3QpOw0KPj4gICAgICAg
YmNvbnRhaW5lciA9ICZjb250YWluZXItPmJjb250YWluZXI7DQo+PiAgICAgICB2ZmlvX2NvbnRh
aW5lcl9pbml0KGJjb250YWluZXIsIHNwYWNlLCAmdmZpb19sZWdhY3lfb3BzKTsNCj4+DQo+PiBA
QCAtNTg5LDEzICs1ODcsMTMgQEAgc3RhdGljIGludCB2ZmlvX2Nvbm5lY3RfY29udGFpbmVyKFZG
SU9Hcm91cCAqZ3JvdXAsDQo+QWRkcmVzc1NwYWNlICphcywNCj4+ICAgICAgICAgICB9DQo+Pg0K
Pj4gICAgICAgICAgIGlmIChpbmZvLT5mbGFncyAmIFZGSU9fSU9NTVVfSU5GT19QR1NJWkVTKSB7
DQo+PiAtICAgICAgICAgICAgY29udGFpbmVyLT5wZ3NpemVzID0gaW5mby0+aW92YV9wZ3NpemVz
Ow0KPj4gKyAgICAgICAgICAgIGNvbnRhaW5lci0+YmNvbnRhaW5lci5wZ3NpemVzID0gaW5mby0+
aW92YV9wZ3NpemVzOw0KPj4gICAgICAgICAgIH0gZWxzZSB7DQo+PiAtICAgICAgICAgICAgY29u
dGFpbmVyLT5wZ3NpemVzID0gcWVtdV9yZWFsX2hvc3RfcGFnZV9zaXplKCk7DQo+PiArICAgICAg
ICAgICAgY29udGFpbmVyLT5iY29udGFpbmVyLnBnc2l6ZXMgPSBxZW11X3JlYWxfaG9zdF9wYWdl
X3NpemUoKTsNCj4+ICAgICAgICAgICB9DQo+Pg0KPj4gLSAgICAgICAgaWYgKCF2ZmlvX2dldF9p
bmZvX2RtYV9hdmFpbChpbmZvLCAmY29udGFpbmVyLT5kbWFfbWF4X21hcHBpbmdzKSkgew0KPj4g
LSAgICAgICAgICAgIGNvbnRhaW5lci0+ZG1hX21heF9tYXBwaW5ncyA9IDY1NTM1Ow0KPj4gKyAg
ICAgICAgaWYgKCF2ZmlvX2dldF9pbmZvX2RtYV9hdmFpbChpbmZvLCAmYmNvbnRhaW5lci0+ZG1h
X21heF9tYXBwaW5ncykpIHsNCj4+ICsgICAgICAgICAgICBjb250YWluZXItPmJjb250YWluZXIu
ZG1hX21heF9tYXBwaW5ncyA9IDY1NTM1Ow0KPj4gICAgICAgICAgIH0NCj4+DQo+PiAgICAgICAg
ICAgdmZpb19nZXRfaW5mb19pb3ZhX3JhbmdlKGluZm8sIGNvbnRhaW5lcik7DQo+PiBkaWZmIC0t
Z2l0IGEvaHcvdmZpby9zcGFwci5jIGIvaHcvdmZpby9zcGFwci5jDQo+PiBpbmRleCAzNDk1NzM3
YWIyLi5kYmM0YzI0MDUyIDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9zcGFwci5jDQo+PiArKysg
Yi9ody92ZmlvL3NwYXByLmMNCj4+IEBAIC0yMjMsMTMgKzIyMywxMyBAQCBzdGF0aWMgaW50IHZm
aW9fc3BhcHJfY3JlYXRlX3dpbmRvdyhWRklPQ29udGFpbmVyDQo+KmNvbnRhaW5lciwNCj4+ICAg
ICAgIGlmIChwYWdlc2l6ZSA+IHJhbXBhZ2VzaXplKSB7DQo+PiAgICAgICAgICAgcGFnZXNpemUg
PSByYW1wYWdlc2l6ZTsNCj4+ICAgICAgIH0NCj4+IC0gICAgcGdtYXNrID0gY29udGFpbmVyLT5w
Z3NpemVzICYgKHBhZ2VzaXplIHwgKHBhZ2VzaXplIC0gMSkpOw0KPj4gKyAgICBwZ21hc2sgPSBj
b250YWluZXItPmJjb250YWluZXIucGdzaXplcyAmIChwYWdlc2l6ZSB8IChwYWdlc2l6ZSAtIDEp
KTsNCj4+ICAgICAgIHBhZ2VzaXplID0gcGdtYXNrID8gKDFVTEwgPDwgKDYzIC0gY2x6NjQocGdt
YXNrKSkpIDogMDsNCj4+ICAgICAgIGlmICghcGFnZXNpemUpIHsNCj4+ICAgICAgICAgICBlcnJv
cl9yZXBvcnQoIkhvc3QgZG9lc24ndCBzdXBwb3J0IHBhZ2Ugc2l6ZSAweCUiUFJJeDY0DQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICIsIHRoZSBzdXBwb3J0ZWQgbWFzayBpcyAweCVseCIsDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgIG1lbW9yeV9yZWdpb25faW9tbXVfZ2V0X21pbl9wYWdl
X3NpemUoaW9tbXVfbXIpLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgIGNvbnRhaW5lci0+cGdz
aXplcyk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgY29udGFpbmVyLT5iY29udGFpbmVyLnBn
c2l6ZXMpOw0KPj4gICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4gICAgICAgfQ0KPj4NCj4+
IEBAIC0zODUsNyArMzg1LDcgQEAgdm9pZA0KPnZmaW9fY29udGFpbmVyX2RlbF9zZWN0aW9uX3dp
bmRvdyhWRklPQ29udGFpbmVyICpjb250YWluZXIsDQo+Pg0KPj4gICBib29sIHZmaW9fc3BhcHJf
Y29udGFpbmVyX2luaXQoVkZJT0NvbnRhaW5lciAqY29udGFpbmVyLCBFcnJvciAqKmVycnApDQo+
PiAgIHsNCj4+IC0NCj4+ICsgICAgVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIgPSAmY29u
dGFpbmVyLT5iY29udGFpbmVyOw0KPj4gICAgICAgc3RydWN0IHZmaW9faW9tbXVfc3BhcHJfdGNl
X2luZm8gaW5mbzsNCj4+ICAgICAgIGJvb2wgdjIgPSBjb250YWluZXItPmlvbW11X3R5cGUgPT0g
VkZJT19TUEFQUl9UQ0VfdjJfSU9NTVU7DQo+PiAgICAgICBpbnQgcmV0LCBmZCA9IGNvbnRhaW5l
ci0+ZmQ7DQo+PiBAQCAtNDI0LDcgKzQyNCw3IEBAIGJvb2wgdmZpb19zcGFwcl9jb250YWluZXJf
aW5pdChWRklPQ29udGFpbmVyDQo+KmNvbnRhaW5lciwgRXJyb3IgKiplcnJwKQ0KPj4gICAgICAg
fQ0KPj4NCj4+ICAgICAgIGlmICh2Mikgew0KPj4gLSAgICAgICAgY29udGFpbmVyLT5wZ3NpemVz
ID0gaW5mby5kZHcucGdzaXplczsNCj4+ICsgICAgICAgIGJjb250YWluZXItPnBnc2l6ZXMgPSBp
bmZvLmRkdy5wZ3NpemVzOw0KPj4gICAgICAgICAgIC8qDQo+PiAgICAgICAgICAgICogVGhlcmUg
aXMgYSBkZWZhdWx0IHdpbmRvdyBpbiBqdXN0IGNyZWF0ZWQgY29udGFpbmVyLg0KPj4gICAgICAg
ICAgICAqIFRvIG1ha2UgcmVnaW9uX2FkZC9kZWwgc2ltcGxlciwgd2UgYmV0dGVyIHJlbW92ZSB0
aGlzDQo+PiBAQCAtNDM5LDcgKzQzOSw3IEBAIGJvb2wgdmZpb19zcGFwcl9jb250YWluZXJfaW5p
dChWRklPQ29udGFpbmVyDQo+KmNvbnRhaW5lciwgRXJyb3IgKiplcnJwKQ0KPj4gICAgICAgICAg
IH0NCj4+ICAgICAgIH0gZWxzZSB7DQo+PiAgICAgICAgICAgLyogVGhlIGRlZmF1bHQgdGFibGUg
dXNlcyA0SyBwYWdlcyAqLw0KPj4gLSAgICAgICAgY29udGFpbmVyLT5wZ3NpemVzID0gMHgxMDAw
Ow0KPj4gKyAgICAgICAgYmNvbnRhaW5lci0+cGdzaXplcyA9IDB4MTAwMDsNCj4+ICAgICAgICAg
ICB2ZmlvX2hvc3Rfd2luX2FkZChjb250YWluZXIsIGluZm8uZG1hMzJfd2luZG93X3N0YXJ0LA0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluZm8uZG1hMzJfd2luZG93X3N0YXJ0ICsN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbmZvLmRtYTMyX3dpbmRvd19zaXplIC0g
MSwNCj4+IEBAIC00NTUsNyArNDU1LDE1IEBAIGxpc3RlbmVyX3VucmVnaXN0ZXJfZXhpdDoNCj4+
DQo+PiAgIHZvaWQgdmZpb19zcGFwcl9jb250YWluZXJfZGVpbml0KFZGSU9Db250YWluZXIgKmNv
bnRhaW5lcikNCj4+ICAgew0KPj4gKyAgICBWRklPSG9zdERNQVdpbmRvdyAqaG9zdHdpbiwgKm5l
eHQ7DQo+PiArDQo+PiAgICAgICBpZiAoY29udGFpbmVyLT5pb21tdV90eXBlID09IFZGSU9fU1BB
UFJfVENFX3YyX0lPTU1VKSB7DQo+PiAgICAgICAgICAgbWVtb3J5X2xpc3RlbmVyX3VucmVnaXN0
ZXIoJmNvbnRhaW5lci0+cHJlcmVnX2xpc3RlbmVyKTsNCj4+ICAgICAgIH0NCj4+ICsgICAgUUxJ
U1RfRk9SRUFDSF9TQUZFKGhvc3R3aW4sICZjb250YWluZXItPmhvc3R3aW5fbGlzdCwgaG9zdHdp
bl9uZXh0LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgbmV4dCkgew0KPj4gKyAgICAgICAg
UUxJU1RfUkVNT1ZFKGhvc3R3aW4sIGhvc3R3aW5fbmV4dCk7DQo+PiArICAgICAgICBnX2ZyZWUo
aG9zdHdpbik7DQo+PiArICAgIH0NCj4+ICsNCj4+ICAgfQ0KPg0KPkkgYW0gc3VyZSB0aGlzIGNo
YW5nZSAgYmVsb25ncyB0byB0aGlzIHBhdGNoLg0KDQpHb29kIGNhdGNoISBZZXMsIEkgc2hvdWxk
IG1vdmUgaXQgaW50byBiZWxvdyBwYXRjaC4NCiJ2ZmlvL2NvbW1vbjogTW92ZSB2ZmlvX2hvc3Rf
d2luX2FkZC9kZWwgaW50byBzcGFwci5jIg0KDQpUaGFua3MNClpoZW56aG9uZw0K

