Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C33A57EA8DE
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 04:01:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2jff-0008Qf-7T; Mon, 13 Nov 2023 22:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2jfd-0008QR-6y
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 22:00:57 -0500
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2jfa-0000HO-VV
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 22:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699930855; x=1731466855;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wWs4gvQ5p7kUG+a1G2QEkUf8NqrwkQ1pyB7htQFQOvQ=;
 b=Z6WgqqIUejLVexnOHANQuFQPhzTN/GmfK8GXpkzytHMwytmpD8zy23Vb
 9bxlfoq4Vj9ZieV5mgEKo8SpdwX4Ta5N4rKcqROXRs0h/0ycMK5GijxVF
 0QUoQ3heJr8W1KHRTFusrIEXLw+Q9AscIuyKEfuoaZmXOL5rlhOn9X4sa
 jBYk7n5cWDK+xOG8jKM9wyfXkZF6D5V/f4r8NL9Qvf1rLzxyoB+HWDLRL
 fWWCkojhg94vQ5accVu4efecpNfaHa120wnK1CDf7rQzxlSzxKpqhgQZ1
 xXQHA+BFS/MMUHgDMHqFJ6e7KrOQXTMCmeo9SHZoMBDItno1HdRz8Wt9K w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="387724810"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; d="scan'208";a="387724810"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2023 19:00:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="834878171"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; d="scan'208";a="834878171"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Nov 2023 19:00:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 19:00:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 19:00:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 19:00:40 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 19:00:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXjRJbjKDMwOcEGgGptbfoNxtocHZnWSZgqSwlOPYmRBP9AShPMsHHAvNqai13mrANJ1xzcgXqpVXphJheIFkXu6t/0qNnFeFtbZdjUcmaS3RJyFLgUzgPEk9PztG1dziOfCWFA7lAdBq8M7fn895GvJNFcE+Ru5SPVHZQicZof8wX7+i0oLHtessYo4BwgbOVBcu5orFKs6KvyDb9/Wqkew/nWEVYV6XGRscJ8/3G1IpfCX75SePXpl3GIJcqf/148BSYbfOxd5144/mMG7TibYxqoHQhqmaCKAkN/q6I2KUrOjrJNdLt5YtviKTx2oZwT77EmdBw5G/NbyM35ITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWs4gvQ5p7kUG+a1G2QEkUf8NqrwkQ1pyB7htQFQOvQ=;
 b=Y8GUoLxt1w51umeUNEN2bKo/6gmFOmaqkSdS9cWIALPhdX1S8h58oEFCUxCLyTwEb7wz40GoQ8issOCRGLmBrBaMIQXw5U6WjasXZzOYTWmoUifeEcswnpsqpWv2axqEbV8Ms6U3UgaPHSpWtZfp/DdyjcvmUu7eWut9IDANmLSt1CfsBfYinxJM6UFEB7fywadAmICJ/9bXWYgEi7xqpR+bhhjTn4QCVfG0CYWjdD/A0gGJDGDPG3EReVBEP2o92y6rKNAOnlGXmj02ruYwXsWZEQv1F3GB8WXkBavh4+v0LXiwgsUezlknAUtClNV2FdK3lx+CHAcVcJCpWiHKoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA3PR11MB8120.namprd11.prod.outlook.com (2603:10b6:806:2f3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 03:00:37 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 03:00:37 +0000
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
Thread-Index: AQHaEwR/PeZ4SQIHEk667S7BiGjbsbBzYgSAgAQxg+CAAIniAIABCY1w
Date: Tue, 14 Nov 2023 03:00:37 +0000
Message-ID: <SJ0PR11MB67441AE88308236E1AD0659C92B2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
 <20231109114529.1904193-11-zhenzhong.duan@intel.com>
 <07539cb1-2262-4ae9-82ea-cfb7b9b8f2d5@redhat.com>
 <SJ0PR11MB67445F52268A9F988A84655B92B3A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <896af239-b56f-424a-ba3a-f0d87888aa87@redhat.com>
In-Reply-To: <896af239-b56f-424a-ba3a-f0d87888aa87@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA3PR11MB8120:EE_
x-ms-office365-filtering-correlation-id: 3d3058e6-c10a-492f-81ab-08dbe4bde0f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i3b1x1zMZKhJsBwLbyN1ZjP0k8QzXJ5jz8Rc7F2CKwxnAUS2wS84iiwiZhDSMlkiOscwfvA0pIU/uyQYuzOmpL0gH8Q/HsniNapam6ALp+qZxjta3shDf6P/lVhNBq7b3FfEGhtOJ57iQHyJMJYOjRk8C5tMFxVjD2S9K1srIxyoFycUfb++m6WY43gvDeEySWdVZx/AJL63ddzwfSJyK2HOZQP7Oi3QJxZbK2+ebI5lr7IwOZvQAzaUTeQ3CPiYnMilFk0DdAafGUGOmxUUmawENJy8YdMB2SFEHrLdviDb8Yb7TMtSdZfBbUNoJR7cEVSjG9F8JN6SlEPBjzXyak+Eawg2Gll7dGbE0mRI3w40YLDgbyBz3At/PV0fULce/WOBc7ANq/zm39kKEBUqYlx01ZWe+ZBJADQeJhM5T2hbP7ruZubuplmyI+fVMuDJ4rRfM0qBKzzvD0FmgBGb4IBr0IsBvhU00m1bUY/AX0K/HGonLsofpCVAuagiIewM5aRxs6YDpVJl/Weyrq2QPWodjwkh1lA8UmvK45XNGYkujpdG00qb6RZ/VD5Leh3clSLHbawo8WmPF58EuD2vtnQDi0kQE8e0tvXMAanxuCk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(71200400001)(53546011)(41300700001)(55016003)(33656002)(26005)(66574015)(6506007)(7696005)(478600001)(316002)(9686003)(107886003)(5660300002)(86362001)(2906002)(122000001)(83380400001)(82960400001)(8936002)(52536014)(8676002)(4326008)(38070700009)(54906003)(66476007)(66446008)(64756008)(66946007)(66556008)(76116006)(110136005)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UitaRG1wRnowUW1yZXFPengwNW5GVGtHdytvdHRJZkkwT2QyVGVESzBaR3p5?=
 =?utf-8?B?SUpCMFM1R0crVG1QNzkvUU5BbTlwc3E3dkg0cXJDK2tVQ29XbjRDT1VsdmtI?=
 =?utf-8?B?QkZGN3JGSXEwckZ3OEJTYzRWREtKVjVTN3d5T0wxUUl1U253SjFKN3Nkai9a?=
 =?utf-8?B?TlV6ajl5S1NEQnExVE9pc1YyY25IOGVIeHFOdFFmTlBJbFJDV0NKcHBySkR2?=
 =?utf-8?B?elQra3BRcS95SkJWRUtyRFhBckNjWGZOQVRsZWxBTk9vZmhIM1FTd0p5ZkdC?=
 =?utf-8?B?cklNTlZIaDVxdExsQkNqdnBzQ3d6SHJna0hwaW5VQ1ptd0NHVUV4SmQ4SGJU?=
 =?utf-8?B?bzlIWklyaGFxRlA4NkxnYjkzMU1aWUdOaXZFUlBNY2x4SGZ1WlgxMS9qM0VZ?=
 =?utf-8?B?ZWljMzk3Q09qM2VsYVd6bS9sTmpIR3g3L0lJbUcrVUFzZ0RxNDl0dzd1Zllv?=
 =?utf-8?B?MXhuQTNpNVppSTB0WVNNOHlzZlowREFNbExEMng3aDdIQTNiOUhPZVYveDdH?=
 =?utf-8?B?b0RCOXk3OEx3blVYMllPQkNnajJUM0ZkSTdJVTJHRmRVRnpkMkRrbkN2c3Vr?=
 =?utf-8?B?cTdqVjhiaG5welJxYm8wRXgvWHFWV3cwWWJQZDZWSXcwMmRVdGJaOGJmaTIr?=
 =?utf-8?B?RndpcU00cmcvVHJpdDh2UUpieTdjVTFjUHNrUGJGemxYVVRxazcrTUtSYmVv?=
 =?utf-8?B?Sk5PeFhlUExCN3o0cmJicGR5d2Jqa2UxYXdIVyt2Z2Y5K0F2RUwxbU9ycXdu?=
 =?utf-8?B?dHZrUmluMW85MVRZRVcvWWJraFd4c2d4YnRoODFRVmVoWVRsbytoTTUwQ1pa?=
 =?utf-8?B?aVpVelV2ajg4cWRRelJlUmRBSmxLWmlhbkdOQXFyUWUxRjhOaUsyc0RSanlF?=
 =?utf-8?B?S2hQSkdHMmZhL3ZnL3lMRDVMbFVsVVZ2N1E5YURpVXVqeWs4WHRuVmdtN0VH?=
 =?utf-8?B?RVp0Ni9mRVhpamFIOHdNWmZ4SGt1a3gyMGJsSk5oLzl0dVZFY21oNjZvRThl?=
 =?utf-8?B?ZUwwaWJFVkZNd1RIdnUxZWFzTldTbU5vRy9kMkJUeWt1cDhTc3AvT1IrSi9J?=
 =?utf-8?B?NVZQVVY4UDZhZXlCVHFXQmtteXZQeG55WjRJdlhISHgwYjdlaE9QMWd1aDBB?=
 =?utf-8?B?TnhZVTNHcU9oVnlFeEljZzZPY2w5czRiNW5qYXFNYWhOZS9aWGhGZlJTWHVu?=
 =?utf-8?B?R2p6RUI2MzVYWkZ5aGRubnY3QzQrRWltMWkrbzcwZTNGQVdSUVBncGZ4TUl6?=
 =?utf-8?B?TDVTdUY2UEwyR0pTL1VRS2RkT2dNWkNlYllKeERBUExocDUyR1BWeDMxT0hL?=
 =?utf-8?B?RFNvM3BOMDdqQ2V0WS94bHovZU53S2hIeStiVTdQNHpIU1RDOTk3YldYVmpx?=
 =?utf-8?B?TVJMcXVGaDRhRjJjZE1LRkswSnkyRFZ3MXlTRXlyOWtQbDNwTHZ2Y3Uvb3R1?=
 =?utf-8?B?eFc2RlhSMEczdEhrd1ZoS2J5Y0VUY096V25ZdDJNREhMN3YyS1VEclZweFlX?=
 =?utf-8?B?VWdCZU9rOURyUkVZWWlubkhwRWFsNkhqc2xLQ3U0eGVUNXlvZFEvUEVrYXk2?=
 =?utf-8?B?UFlUUDlldmxkSUoyS2RzNXlMbzY3WVpYUkZxNFJwL1FESFVHYmlrMkNESjlq?=
 =?utf-8?B?MHRCSTdwYm91dURUa09VbGd2OVFMckRFcVUwQzdIOEo3Nmw2Rzd0eWpRbHg4?=
 =?utf-8?B?WUF1ajNoNzdseU9DT0V2a1VKR0ZZUDE4QWZPbXZMc0N1QzZTWUlLTXVFZW5H?=
 =?utf-8?B?R2Nic2s4eDFlamVQZkpTazZPb3FoMzlFWG44a0VxUklwTjhDaW5iY1FqMHE5?=
 =?utf-8?B?SXRPSU9WZ1V2eWk3ZGU2WjRZdVFzNGhGbXlsSVVVRWQ2QWZobVhVWHd5VXpo?=
 =?utf-8?B?dFdDVC9nc3dpcFgzTUJMeFpiTEY5ZnZ2VTc1aVhrVEpCQjNaMXhiVVYxM284?=
 =?utf-8?B?R3RyYlUyM2lnb2pWRG4yV04xeUY2R25nSU42dmd4N00wTDZrd01kc1hqQkdM?=
 =?utf-8?B?R2RJNW9VcHpTQWxNMjBqNkU5ZWZDNDcwQ2RxcUFDSUczZCtFQTVzMkM2ejZx?=
 =?utf-8?B?UDNyekx3V2JBR1FPSGpRVzgvbERyWVJ6NVQzVDRxUm5TUWZNT1diVFRyMi9Q?=
 =?utf-8?Q?WMjI9ybnTKJVQLaMXV2zIVLiU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3058e6-c10a-492f-81ab-08dbe4bde0f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 03:00:37.6612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PT+35TR0V5ReYDzq1lRsTS3f40Jp06tSDPBGD9YhBQK8dsKlt1C6YZ+yfrXJCQCr6QpKM6CgyMQb7vnoSdyck5m3I87Ta3ToOJGV/1TJzow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8120
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBNb25kYXksIE5vdmVtYmVyIDEzLCAyMDIzIDc6MDgg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY1IDEwLzIwXSB2ZmlvL3BjaTogTWFrZSB2ZmlvIGNk
ZXYgcHJlLW9wZW5hYmxlIGJ5IHBhc3NpbmcgYQ0KPmZpbGUgaGFuZGxlDQo+DQo+T24gMTEvMTMv
MjMgMDQ6MDAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+DQo+Pg0KPj4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQu
Y29tPg0KPj4+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTAsIDIwMjMgNjo1MyBQTQ0KPj4+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTAvMjBdIHZmaW8vcGNpOiBNYWtlIHZmaW8gY2RldiBwcmUt
b3BlbmFibGUgYnkNCj5wYXNzaW5nIGENCj4+PiBmaWxlIGhhbmRsZQ0KPj4+DQo+Pj4gT24gMTEv
OS8yMyAxMjo0NSwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+IFRoaXMgZ2l2ZXMgbWFuYWdl
bWVudCB0b29scyBsaWtlIGxpYnZpcnQgYSBjaGFuY2UgdG8gb3BlbiB0aGUgdmZpbw0KPj4+PiBj
ZGV2IHdpdGggcHJpdmlsZWdlIGFuZCBwYXNzIEZEIHRvIHFlbXUuIFRoaXMgd2F5IHFlbXUgbmV2
ZXIgbmVlZHMNCj4+Pj4gdG8gaGF2ZSBwcml2aWxlZ2UgdG8gb3BlbiBhIFZGSU8gb3IgaW9tbXUg
Y2RldiBub2RlLg0KPj4+Pg0KPj4+PiBUb2dldGhlciB3aXRoIHRoZSBlYXJsaWVyIHN1cHBvcnQg
b2YgcHJlLW9wZW5pbmcgL2Rldi9pb21tdSBkZXZpY2UsDQo+Pj4+IG5vdyB3ZSBoYXZlIGZ1bGwg
c3VwcG9ydCBvZiBwYXNzaW5nIGEgdmZpbyBkZXZpY2UgdG8gdW5wcml2aWxlZ2VkDQo+Pj4+IHFl
bXUgYnkgbWFuYWdlbWVudCB0b29sLiBUaGlzIG1vZGUgaXMgbm8gbW9yZSBjb25zaWRlcmVkIGZv
ciB0aGUNCj4+Pj4gbGVnYWN5IGJhY2tlbmQuIFNvIGxldCdzIHJlbW92ZSB0aGUgIlRPRE8iIGNv
bW1lbnQuDQo+Pj4+DQo+Pj4+IEFkZCBhIGhlbHBlciBmdW5jdGlvbiB2ZmlvX2RldmljZV9nZXRf
bmFtZSgpIHRvIGNoZWNrIGZkIGFuZCBnZXQNCj4+Pj4gZGV2aWNlIG5hbWUsIGl0IHdpbGwgYWxz
byBiZSB1c2VkIGJ5IG90aGVyIHZmaW8gZGV2aWNlcy4NCj4+Pj4NCj4+Pj4gVGhlcmUgaXMgbm8g
ZWFzeSB3YXkgdG8gY2hlY2sgaWYgYSBkZXZpY2UgaXMgbWRldiB3aXRoIEZEIHBhc3NpbmcsDQo+
Pj4+IHNvIGZhaWwgdGhlIHgtYmFsbG9vbi1hbGxvd2VkIGNoZWNrIHVuY29uZGl0aW9uYWxseSBp
biB0aGlzIGNhc2UuDQo+Pj4+DQo+Pj4+IFRoZXJlIGlzIGFsc28gbm8gZWFzeSB3YXkgdG8gZ2V0
IEJERiBhcyBuYW1lIHdpdGggRkQgcGFzc2luZywgc28NCj4+Pj4gd2UgZmFrZSBhIG5hbWUgYnkg
VkZJT19GRFtmZF0uDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBpbmNsdWRlL2h3L3Zm
aW8vdmZpby1jb21tb24uaCB8ICAxICsNCj4+Pj4gICAgaHcvdmZpby9oZWxwZXJzLmMgICAgICAg
ICAgICAgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgICBody92Zmlv
L2lvbW11ZmQuYyAgICAgICAgICAgICB8IDEyICsrKysrKystLS0tDQo+Pj4+ICAgIGh3L3ZmaW8v
cGNpLmMgICAgICAgICAgICAgICAgIHwgNDAgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0NCj4+Pj4gICAgNCBmaWxlcyBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspLCAxNiBkZWxl
dGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNv
bW1vbi5oIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tDQo+Y29tbW9uLmgNCj4+Pj4gaW5kZXggM2Rh
YzVjMTY3ZS4uOTYwYTE0ZThkOCAxMDA2NDQNCj4+Pj4gLS0tIGEvaW5jbHVkZS9ody92ZmlvL3Zm
aW8tY29tbW9uLmgNCj4+Pj4gKysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+
Pj4gQEAgLTIzOCw2ICsyMzgsNyBAQCBzdHJ1Y3QgdmZpb19pbmZvX2NhcF9oZWFkZXIgKg0KPj4+
PiAgICB2ZmlvX2dldF9kZXZpY2VfaW5mb19jYXAoc3RydWN0IHZmaW9fZGV2aWNlX2luZm8gKmlu
Zm8sIHVpbnQxNl90IGlkKTsNCj4+Pj4gICAgc3RydWN0IHZmaW9faW5mb19jYXBfaGVhZGVyICoN
Cj4+Pj4gICAgdmZpb19nZXRfY2FwKHZvaWQgKnB0ciwgdWludDMyX3QgY2FwX29mZnNldCwgdWlu
dDE2X3QgaWQpOw0KPj4+PiAraW50IHZmaW9fZGV2aWNlX2dldF9uYW1lKFZGSU9EZXZpY2UgKnZi
YXNlZGV2LCBFcnJvciAqKmVycnApOw0KPj4+PiAgICAjZW5kaWYNCj4+Pj4NCj4+Pj4gICAgYm9v
bCB2ZmlvX21pZ3JhdGlvbl9yZWFsaXplKFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBFcnJvciAqKmVy
cnApOw0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9oZWxwZXJzLmMgYi9ody92ZmlvL2hlbHBl
cnMuYw0KPj4+PiBpbmRleCAxNjg4NDdlN2M1Li5kODBhYTU4NzE5IDEwMDY0NA0KPj4+PiAtLS0g
YS9ody92ZmlvL2hlbHBlcnMuYw0KPj4+PiArKysgYi9ody92ZmlvL2hlbHBlcnMuYw0KPj4+PiBA
QCAtMjAsNiArMjAsNyBAQA0KPj4+PiAgICAgKi8NCj4+Pj4NCj4+Pj4gICAgI2luY2x1ZGUgInFl
bXUvb3NkZXAuaCINCj4+Pj4gKyNpbmNsdWRlIENPTkZJR19ERVZJQ0VTIC8qIENPTkZJR19JT01N
VUZEICovDQo+Pj4+ICAgICNpbmNsdWRlIDxzeXMvaW9jdGwuaD4NCj4+Pj4NCj4+Pj4gICAgI2lu
Y2x1ZGUgImh3L3ZmaW8vdmZpby1jb21tb24uaCINCj4+Pj4gQEAgLTYwOSwzICs2MTAsMzYgQEAg
Ym9vbCB2ZmlvX2hhc19yZWdpb25fY2FwKFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPmludA0KPj4+
IHJlZ2lvbiwgdWludDE2X3QgY2FwX3R5cGUpDQo+Pj4+DQo+Pj4+ICAgICAgICByZXR1cm4gcmV0
Ow0KPj4+PiAgICB9DQo+Pj4+ICsNCj4+Pj4gK2ludCB2ZmlvX2RldmljZV9nZXRfbmFtZShWRklP
RGV2aWNlICp2YmFzZWRldiwgRXJyb3IgKiplcnJwKQ0KPj4+PiArew0KPj4+PiArICAgIHN0cnVj
dCBzdGF0IHN0Ow0KPj4+PiArDQo+Pj4+ICsgICAgaWYgKHZiYXNlZGV2LT5mZCA8IDApIHsNCj4+
Pj4gKyAgICAgICAgaWYgKHN0YXQodmJhc2VkZXYtPnN5c2ZzZGV2LCAmc3QpIDwgMCkgew0KPj4+
PiArICAgICAgICAgICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCBlcnJubywgIm5vIHN1Y2ggaG9z
dCBkZXZpY2UiKTsNCj4+Pj4gKyAgICAgICAgICAgIGVycm9yX3ByZXBlbmQoZXJycCwgVkZJT19N
U0dfUFJFRklYLCB2YmFzZWRldi0+c3lzZnNkZXYpOw0KPj4+PiArICAgICAgICAgICAgcmV0dXJu
IC1lcnJubzsNCj4+Pj4gKyAgICAgICAgfQ0KPj4+PiArICAgICAgICAvKiBVc2VyIG1heSBzcGVj
aWZ5IGEgbmFtZSwgZS5nOiBWRklPIHBsYXRmb3JtIGRldmljZSAqLw0KPj4+PiArICAgICAgICBp
ZiAoIXZiYXNlZGV2LT5uYW1lKSB7DQo+Pj4+ICsgICAgICAgICAgICB2YmFzZWRldi0+bmFtZSA9
IGdfcGF0aF9nZXRfYmFzZW5hbWUodmJhc2VkZXYtPnN5c2ZzZGV2KTsNCj4+Pj4gKyAgICAgICAg
fQ0KPj4+PiArICAgIH0NCj4+Pj4gKyNpZmRlZiBDT05GSUdfSU9NTVVGRA0KPj4+PiArICAgIGVs
c2Ugew0KPj4+PiArICAgICAgICBpZiAoIXZiYXNlZGV2LT5pb21tdWZkKSB7DQo+Pj4NCj4+Pg0K
Pj4+IENhbiB3ZSBoYW5kbGUgd2l0aCB0aGlzIGNhc2Ugd2l0aG91dCBDT05GSUdfSU9NTVVGRCwg
c2ltcGx5IGJ5DQo+Pj4gdGVzdGluZyB2YmFzZWRldi0+aW9tbXVmZCA/DQo+Pg0KPj4gU3VyZSwg
d2lsbCBkby4NCj4+DQo+Pj4NCj4+Pj4gKyAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIlVz
ZSBGRCBwYXNzaW5nIG9ubHkgd2l0aCBpb21tdWZkIGJhY2tlbmQiKTsNCj4+Pj4gKyAgICAgICAg
ICAgIHJldHVybiAtRUlOVkFMOw0KPj4+PiArICAgICAgICB9DQo+Pj4+ICsgICAgICAgIC8qDQo+
Pj4+ICsgICAgICAgICAqIEdpdmUgYSBuYW1lIHdpdGggZmQgc28gYW55IGZ1bmN0aW9uIHByaW50
aW5nIG91dCB2YmFzZWRldi0+bmFtZQ0KPj4+PiArICAgICAgICAgKiB3aWxsIG5vdCBicmVhay4N
Cj4+Pj4gKyAgICAgICAgICovDQo+Pj4+ICsgICAgICAgIGlmICghdmJhc2VkZXYtPm5hbWUpIHsN
Cj4+Pj4gKyAgICAgICAgICAgIHZiYXNlZGV2LT5uYW1lID0gZ19zdHJkdXBfcHJpbnRmKCJWRklP
X0ZEJWQiLCB2YmFzZWRldi0+ZmQpOw0KPj4+PiArICAgICAgICB9DQo+Pj4+ICsgICAgfQ0KPj4+
PiArI2VuZGlmDQo+Pj4+ICsgICAgcmV0dXJuIDA7DQo+Pj4+ICt9DQo+Pj4+IGRpZmYgLS1naXQg
YS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4+IGluZGV4IDQ0ZGM2
ODQ4YmYuLmZkMzA0NzcyNzUgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L3ZmaW8vaW9tbXVmZC5jDQo+
Pj4+ICsrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4+IEBAIC0zMjYsMTEgKzMyNiwxNSBAQCBz
dGF0aWMgaW50IGlvbW11ZmRfYXR0YWNoX2RldmljZShjb25zdCBjaGFyDQo+Km5hbWUsDQo+Pj4g
VkZJT0RldmljZSAqdmJhc2VkZXYsDQo+Pj4+ICAgICAgICB1aW50MzJfdCBpb2FzX2lkOw0KPj4+
PiAgICAgICAgRXJyb3IgKmVyciA9IE5VTEw7DQo+Pj4+DQo+Pj4+IC0gICAgZGV2ZmQgPSBpb21t
dWZkX2NkZXZfZ2V0ZmQodmJhc2VkZXYtPnN5c2ZzZGV2LCBlcnJwKTsNCj4+Pj4gLSAgICBpZiAo
ZGV2ZmQgPCAwKSB7DQo+Pj4+IC0gICAgICAgIHJldHVybiBkZXZmZDsNCj4+Pj4gKyAgICBpZiAo
dmJhc2VkZXYtPmZkIDwgMCkgew0KPj4+PiArICAgICAgICBkZXZmZCA9IGlvbW11ZmRfY2Rldl9n
ZXRmZCh2YmFzZWRldi0+c3lzZnNkZXYsIGVycnApOw0KPj4+PiArICAgICAgICBpZiAoZGV2ZmQg
PCAwKSB7DQo+Pj4+ICsgICAgICAgICAgICByZXR1cm4gZGV2ZmQ7DQo+Pj4+ICsgICAgICAgIH0N
Cj4+Pj4gKyAgICAgICAgdmJhc2VkZXYtPmZkID0gZGV2ZmQ7DQo+Pj4+ICsgICAgfSBlbHNlIHsN
Cj4+Pj4gKyAgICAgICAgZGV2ZmQgPSB2YmFzZWRldi0+ZmQ7DQo+Pj4+ICAgICAgICB9DQo+Pj4+
IC0gICAgdmJhc2VkZXYtPmZkID0gZGV2ZmQ7DQo+Pj4+DQo+Pj4+ICAgICAgICByZXQgPSBpb21t
dWZkX2Nvbm5lY3RfYW5kX2JpbmQodmJhc2VkZXYsIGVycnApOw0KPj4+PiAgICAgICAgaWYgKHJl
dCkgew0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9wY2kuYyBiL2h3L3ZmaW8vcGNpLmMNCj4+
Pj4gaW5kZXggZTlhNDI2MjAwYi4uZjk1NzI1ZWQxNiAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvdmZp
by9wY2kuYw0KPj4+PiArKysgYi9ody92ZmlvL3BjaS5jDQo+Pj4+IEBAIC00NCw2ICs0NCw3IEBA
DQo+Pj4+ICAgICNpbmNsdWRlICJtaWdyYXRpb24vYmxvY2tlci5oIg0KPj4+PiAgICAjaW5jbHVk
ZSAibWlncmF0aW9uL3FlbXUtZmlsZS5oIg0KPj4+PiAgICAjaW5jbHVkZSAic3lzZW11L2lvbW11
ZmQuaCINCj4+Pj4gKyNpbmNsdWRlICJtb25pdG9yL21vbml0b3IuaCINCj4+Pj4NCj4+Pj4gICAg
I2RlZmluZSBUWVBFX1ZGSU9fUENJX05PSE9UUExVRyAidmZpby1wY2ktbm9ob3RwbHVnIg0KPj4+
Pg0KPj4+PiBAQCAtMjkzNCwxOCArMjkzNSwyMyBAQCBzdGF0aWMgdm9pZCB2ZmlvX3JlYWxpemUo
UENJRGV2aWNlICpwZGV2LCBFcnJvcg0KPj4+ICoqZXJycCkNCj4+Pj4gICAgICAgIFZGSU9EZXZp
Y2UgKnZiYXNlZGV2ID0gJnZkZXYtPnZiYXNlZGV2Ow0KPj4+PiAgICAgICAgY2hhciAqdG1wLCAq
c3Vic3lzOw0KPj4+PiAgICAgICAgRXJyb3IgKmVyciA9IE5VTEw7DQo+Pj4+IC0gICAgc3RydWN0
IHN0YXQgc3Q7DQo+Pj4+ICAgICAgICBpbnQgaSwgcmV0Ow0KPj4+PiAgICAgICAgYm9vbCBpc19t
ZGV2Ow0KPj4+PiAgICAgICAgY2hhciB1dWlkW1VVSURfU1RSX0xFTl07DQo+Pj4+ICAgICAgICBj
aGFyICpuYW1lOw0KPj4+Pg0KPj4+PiAtICAgIGlmICghdmJhc2VkZXYtPnN5c2ZzZGV2KSB7DQo+
Pj4+ICsgICAgaWYgKHZiYXNlZGV2LT5mZCA8IDAgJiYgIXZiYXNlZGV2LT5zeXNmc2Rldikgew0K
Pj4+PiAgICAgICAgICAgIGlmICghKH52ZGV2LT5ob3N0LmRvbWFpbiB8fCB+dmRldi0+aG9zdC5i
dXMgfHwNCj4+Pj4gICAgICAgICAgICAgICAgICB+dmRldi0+aG9zdC5zbG90IHx8IH52ZGV2LT5o
b3N0LmZ1bmN0aW9uKSkgew0KPj4+PiAgICAgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJO
byBwcm92aWRlZCBob3N0IGRldmljZSIpOw0KPj4+PiArI2lmZGVmIENPTkZJR19JT01NVUZEDQo+
Pj4+ICsgICAgICAgICAgICBlcnJvcl9hcHBlbmRfaGludChlcnJwLCAiVXNlIC1kZXZpY2UgdmZp
by1wY2ksaG9zdD1EREREOkJCOkRELkYsICINCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICItZGV2aWNlIHZmaW8tcGNpLHN5c2ZzZGV2PVBBVEhfVE9fREVWSUNFICINCj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJvciAtZGV2aWNlIHZmaW8tcGNpLGZkPURF
VklDRV9GRFxuIik7DQo+Pj4+ICsjZWxzZQ0KPj4+PiAgICAgICAgICAgICAgICBlcnJvcl9hcHBl
bmRfaGludChlcnJwLCAiVXNlIC1kZXZpY2UgdmZpby1wY2ksaG9zdD1EREREOkJCOkRELkYgIg0K
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAib3IgLWRldmljZSB2ZmlvLXBj
aSxzeXNmc2Rldj1QQVRIX1RPX0RFVklDRVxuIik7DQo+Pj4+ICsjZW5kaWYNCj4+Pg0KPj4+IG9y
IHNpbXBseSA6DQo+Pj4NCj4+Pg0KPj4+ICAgICAgICAgICAgICAgICBlcnJvcl9hcHBlbmRfaGlu
dChlcnJwLCAiVXNlIC1kZXZpY2UgdmZpby1wY2ksaG9zdD1EREREOkJCOkRELkYgIg0KPj4+ICAg
KyNpZmRlZiBDT05GSUdfSU9NTVVGRA0KPj4+ICAgKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICJvciAtZGV2aWNlIHZmaW8tcGNpLGZkPURFVklDRV9GRCAiDQo+Pj4gICArI2VuZGlmDQo+
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJvciAtZGV2aWNlIHZmaW8tcGNp
LHN5c2ZzZGV2PVBBVEhfVE9fREVWSUNFXG4iKTsNCj4+DQo+PiBHb29kIGlkZWEsIHdpbGwgZG8u
DQo+Pg0KPj4+DQo+Pj4NCj4+Pg0KPj4+PiAgICAgICAgICAgICAgICByZXR1cm47DQo+Pj4+ICAg
ICAgICAgICAgfQ0KPj4+PiAgICAgICAgICAgIHZiYXNlZGV2LT5zeXNmc2RldiA9DQo+Pj4+IEBA
IC0yOTU0LDEzICsyOTYwLDkgQEAgc3RhdGljIHZvaWQgdmZpb19yZWFsaXplKFBDSURldmljZSAq
cGRldiwgRXJyb3INCj4+PiAqKmVycnApDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB2ZGV2LT5ob3N0LnNsb3QsIHZkZXYtPmhvc3QuZnVuY3Rpb24pOw0KPj4+PiAgICAgICAg
fQ0KPj4+Pg0KPj4+PiAtICAgIGlmIChzdGF0KHZiYXNlZGV2LT5zeXNmc2RldiwgJnN0KSA8IDAp
IHsNCj4+Pj4gLSAgICAgICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCBlcnJubywgIm5vIHN1Y2gg
aG9zdCBkZXZpY2UiKTsNCj4+Pj4gLSAgICAgICAgZXJyb3JfcHJlcGVuZChlcnJwLCBWRklPX01T
R19QUkVGSVgsIHZiYXNlZGV2LT5zeXNmc2Rldik7DQo+Pj4+ICsgICAgaWYgKHZmaW9fZGV2aWNl
X2dldF9uYW1lKHZiYXNlZGV2LCBlcnJwKSkgew0KPj4+PiAgICAgICAgICAgIHJldHVybjsNCj4+
Pj4gICAgICAgIH0NCj4+Pj4gLQ0KPj4+PiAtICAgIHZiYXNlZGV2LT5uYW1lID0gZ19wYXRoX2dl
dF9iYXNlbmFtZSh2YmFzZWRldi0+c3lzZnNkZXYpOw0KPj4+PiAgICAgICAgdmJhc2VkZXYtPm9w
cyA9ICZ2ZmlvX3BjaV9vcHM7DQo+Pj4+ICAgICAgICB2YmFzZWRldi0+dHlwZSA9IFZGSU9fREVW
SUNFX1RZUEVfUENJOw0KPj4+PiAgICAgICAgdmJhc2VkZXYtPmRldiA9IERFVklDRSh2ZGV2KTsN
Cj4+Pj4gQEAgLTMzMjAsNiArMzMyMiw3IEBAIHN0YXRpYyB2b2lkIHZmaW9faW5zdGFuY2VfaW5p
dChPYmplY3QgKm9iaikNCj4+Pj4gICAgICAgIHZkZXYtPmhvc3QuYnVzID0gfjBVOw0KPj4+PiAg
ICAgICAgdmRldi0+aG9zdC5zbG90ID0gfjBVOw0KPj4+PiAgICAgICAgdmRldi0+aG9zdC5mdW5j
dGlvbiA9IH4wVTsNCj4+Pj4gKyAgICB2ZGV2LT52YmFzZWRldi5mZCA9IC0xOw0KPj4+IFdlIHNo
b3VsZCBwcm9iYWJseSBtb3ZlIHRoZSBhbGwgVkZJT0RldmljZSBpbml0aWFsaXphdGlvbnMgOg0K
Pj4+DQo+Pj4gICAgICB2YmFzZWRldi0+b3BzID0gJnZmaW9fcGNpX29wczsNCj4+PiAgICAgIHZi
YXNlZGV2LT50eXBlID0gVkZJT19ERVZJQ0VfVFlQRV9QQ0k7DQo+Pj4gICAgICB2YmFzZWRldi0+
ZGV2ID0gREVWSUNFKHZkZXYpOw0KPj4+DQo+Pj4gdW5kZXIgdmZpb19pbnN0YW5jZV9pbml0IChz
aG91bGQgYmUgY2FsbGVkIHZmaW9fcGNpX2luc3RhbmNlX2luaXQpLg0KPj4+DQo+Pj4gVGhpcyBp
cyB0cnVlIGZvciBhbGwgb3RoZXIgVkZJTyBkZXZpY2VzLiBNYXkgYmUgbm90IGZvciB0aGlzIHNl
cmllcywNCj4+PiBpdCBjYW4gY29tZSBsYXRlci4NCj4+DQo+PiBTdXJlLCBMZXQgbWUgc2VuZCBh
IHNlcGFyYXRlIHNlcmllcyBhZGRyZXNzaW5nIHRoaXMuDQo+Pg0KPj4+DQo+Pj4NCj4+Pj4NCj4+
Pj4gICAgICAgIHZkZXYtPm52X2dwdWRpcmVjdF9jbGlxdWUgPSAweEZGOw0KPj4+Pg0KPj4+PiBA
QCAtMzM3MywxMSArMzM3Niw2IEBAIHN0YXRpYyBQcm9wZXJ0eSB2ZmlvX3BjaV9kZXZfcHJvcGVy
dGllc1tdID0gew0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHFk
ZXZfcHJvcF9udl9ncHVkaXJlY3RfY2xpcXVlLCB1aW50OF90KSwNCj4+Pj4gICAgICAgIERFRklO
RV9QUk9QX09GRl9BVVRPX1BDSUJBUigieC1tc2l4LXJlbG9jYXRpb24iLCBWRklPUENJRGV2aWNl
LA0KPj4+IG1zaXhfcmVsbywNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBPRkZfQVVUT1BDSUJBUl9PRkYpLA0KPj4+PiAtICAgIC8qDQo+Pj4+IC0gICAgICogVE9ETyAt
IHN1cHBvcnQgcGFzc2VkIGZkcy4uLiBpcyB0aGlzIG5lY2Vzc2FyeT8NCj4+Pj4gLSAgICAgKiBE
RUZJTkVfUFJPUF9TVFJJTkcoInZmaW9mZCIsIFZGSU9QQ0lEZXZpY2UsIHZmaW9mZF9uYW1lKSwN
Cj4+Pj4gLSAgICAgKiBERUZJTkVfUFJPUF9TVFJJTkcoInZmaW9ncm91cGZkLCBWRklPUENJRGV2
aWNlLA0KPnZmaW9ncm91cGZkX25hbWUpLA0KPj4+PiAtICAgICAqLw0KPj4+PiAgICAjaWZkZWYg
Q09ORklHX0lPTU1VRkQNCj4+Pj4gICAgICAgIERFRklORV9QUk9QX0xJTksoImlvbW11ZmQiLCBW
RklPUENJRGV2aWNlLCB2YmFzZWRldi5pb21tdWZkLA0KPj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICBUWVBFX0lPTU1VRkRfQkFDS0VORCwgSU9NTVVGREJhY2tlbmQgKiksDQo+Pj4+IEBAIC0z
Mzg1LDYgKzMzODMsMjEgQEAgc3RhdGljIFByb3BlcnR5IHZmaW9fcGNpX2Rldl9wcm9wZXJ0aWVz
W10gPSB7DQo+Pj4+ICAgICAgICBERUZJTkVfUFJPUF9FTkRfT0ZfTElTVCgpLA0KPj4+PiAgICB9
Ow0KPj4+Pg0KPj4+PiArI2lmZGVmIENPTkZJR19JT01NVUZEDQo+Pj4+ICtzdGF0aWMgdm9pZCB2
ZmlvX3BjaV9zZXRfZmQoT2JqZWN0ICpvYmosIGNvbnN0IGNoYXIgKnN0ciwgRXJyb3IgKiplcnJw
KQ0KPj4+PiArew0KPj4+PiArICAgIFZGSU9QQ0lEZXZpY2UgKnZkZXYgPSBWRklPX1BDSShvYmop
Ow0KPj4+PiArICAgIGludCBmZCA9IC0xOw0KPj4+PiArDQo+Pj4+ICsgICAgZmQgPSBtb25pdG9y
X2ZkX3BhcmFtKG1vbml0b3JfY3VyKCksIHN0ciwgZXJycCk7DQo+Pj4+ICsgICAgaWYgKGZkID09
IC0xKSB7DQo+Pj4+ICsgICAgICAgIGVycm9yX3ByZXBlbmQoZXJycCwgIkNvdWxkIG5vdCBwYXJz
ZSByZW1vdGUgb2JqZWN0IGZkICVzOiIsIHN0cik7DQo+Pj4+ICsgICAgICAgIHJldHVybjsNCj4+
Pj4gKyAgICB9DQo+Pj4+ICsgICAgdmRldi0+dmJhc2VkZXYuZmQgPSBmZDsNCj4+Pg0KPj4+IFdl
IGNvdWxkIGludHJvZHVjZSBhIGNvbW1vbiBoZWxwZXIgaW4gaHcvdmZpby9jb21tb24uYyB0byBy
ZW1vdmUgY29kZQ0KPj4+IGR1cGxpY2F0aW9uIDoNCj4+Pg0KPj4+ICNpZmRlZiBDT05GSUdfSU9N
TVVGRA0KPj4+IHN0YXRpYyB2b2lkIHZmaW9fcGNpX3NldF9mZChPYmplY3QgKm9iaiwgY29uc3Qg
Y2hhciAqc3RyLCBFcnJvciAqKmVycnApDQo+Pj4gew0KPj4+ICAgICAgdmZpb19kZXZpY2Vfc2V0
X2ZkKCZWRklPX1BDSShvYmopLT52YmFzZWRldiwgc3RyLCBlcnJwKTsNCj4+PiB9DQo+Pj4gI2Vu
ZGlmDQo+Pg0KPj4gR29vZCBzdWdnZXN0aW9ucyEgV2lsbCBkby4NCj4NCj4NCj5UaGUgaWRlYWQg
aXMgdG8gaXNvbGF0ZSB0aGUgaW9tbXVmZCBhZGRpdGlvbiBpbiBzb21lIGNvbW1vbiBleHRlbnNp
b24uDQo+SSB0cmllZCB3aXRoIGEgUU9NIGludGVyZmFjZSBidXQgaXQgaXMgbm90IHJlYWxseSBz
YXRpZnlpbmcuIFNlZQ0KPnByZXZpb3VzIGVtYWlsLiBJIGFtIG5vdCBsb29zaW5nIGZhaXRoIHRo
b3VnaCB0byBmaW5kIGEgc29sdXRpb24gZm9yDQo+dGhpcyBtdWx0aSBpbmhlcml0YW5jZSBpc3N1
ZSB3aXRoIFZGSU8gZGV2aWNlcw0KDQpJIGtub3csIGFsd2F5cyBrZWVwIHRoaXMgaW4gbWluZPCf
mIoNCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

