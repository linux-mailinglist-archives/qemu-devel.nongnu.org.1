Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A32F67A9127
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 05:13:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjA7H-00018g-2I; Wed, 20 Sep 2023 23:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjA7F-00018T-Gc; Wed, 20 Sep 2023 23:12:33 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjA7D-0001mf-Nb; Wed, 20 Sep 2023 23:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695265951; x=1726801951;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bqPVejx5CSWKdmXIJZU3EUPpSVgtCGCRsdQY9+6XbSM=;
 b=DDwFzNlDaHDVtl4UjwwM8gS5tpt4vPHkJAEuGhy41sV/JSZzfNucDi8A
 v+dmnKQg48AAMeaem8+EelzOA4xosEw4g+C+mCreP9i/4SLI+A/VQu6y5
 ua+sCoWRuraLt0E3sIzyf155G7Ab1vqJ8LwNANmdytHVLq/VJ74H6Npb4
 alPA9PO/3z+oxnucrgpp+edGdcTOHOyxvAJdYdeNYNSzfNAUJRO6cH3Sm
 8MVVHVvgDobT80WXZZ7dSDxEWcUrpgaVlfgzeMfU+RXMpYCORQHw/ZizX
 IW6VBCkvXCQfo6+n/yMWq66KkyYKKrjTmqCxSi0+o/MBB/E5/DSKl7hck A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="377706736"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="377706736"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 20:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="837150241"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="837150241"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 20:12:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 20:12:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 20:12:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 20:12:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIXScdNv8BxETK+roOM1VIJuZvAwgqlnRZBAcT2OrM260KBw/dut6E9ZWGBos3ysgFi0JYe/oOMtrszGXNKKFRXZPUBksKvThcLQPZ2jOhXHGkvKmtyeEvej7yqVy1hxp7NO2cX0hagJqSUXFuur1MiUuGzl+i5RE3DqcY/hgrOZdb2GePTPvZzSJatKeuRzyPlsI8C+M71Z31jL6LC3lbj5HuNzINzLrIR+GRLFtfvHmMKmmxWgQMG+aJjXOSs8EksvbRCDj+boBM6ObQ8+ODIZd6WUJfznJc2rt8zQqxTbZ2lMK4EIlcmAg0/yRANabWApeDzSCCGsbykmaSdZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqPVejx5CSWKdmXIJZU3EUPpSVgtCGCRsdQY9+6XbSM=;
 b=SVwgVZxeMkqUiUPSBFR8YErIiKWfY8+MjfJGGsdIXmsxI0F2f9gdQBF3dbWbzsD+zClKIhEh0FTEowPMAVJiKPVczex2mUfh84NWjUkEtZ0Z6rBuJ4eaCOAcp2pKJSdCS+YGkxR+le+6VHUledlAW85Dz6Fh7e/sME4Quw5seHC8uZYTp0vOmmXxCNu0J6FDVRWb1cSxsqhDFqd60EztOFMz1Fb7yIhdAIYvImqOMNVajh7QRf/mXLxM7TIzYH0cCar03s/s4qDvEFjtg44AeHEy6TfxzJdNvfPIEbx/VzsYaZ5WKDv2llTchXp9LLS+Ch47ZgtrtryjTmbGEhVWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB7124.namprd11.prod.outlook.com (2603:10b6:510:20f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 21 Sep
 2023 03:12:22 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 03:12:22 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, 
 Greg Kurz <groug@kaod.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>, "open
 list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
Subject: RE: [PATCH v1 13/22] vfio: Add base container
Thread-Topic: [PATCH v1 13/22] vfio: Add base container
Thread-Index: AQHZ2zBKcvHai3HTVU61uaTXJ4y/6rAihaoAgAFXxICAAN5PUA==
Date: Thu, 21 Sep 2023 03:12:22 +0000
Message-ID: <SJ0PR11MB6744F0C414B33957089002F992F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-14-zhenzhong.duan@intel.com>
 <eb3c51e0-d1ba-1452-6f85-786f7c36411a@redhat.com>
 <ebefafbe-59ee-4b12-0b63-c883ad230301@redhat.com>
In-Reply-To: <ebefafbe-59ee-4b12-0b63-c883ad230301@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB7124:EE_
x-ms-office365-filtering-correlation-id: 0fb0f0e6-8cf3-493c-cdfe-08dbba5092c3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: thTjF+sZmI3V3SkDSPeoJm/+zwG2s6M8A+y/CybLXEa8B+0kCgE8BaX/iEm1tEnJbUq+25GwPZqVa5Tf6giEvSMwthx9dT+fsqxE5n1AJrO9HbouGPjHGEmbUKr2ToDm84qyfvZ27F1NWs8DVewyFJu4Kwk64u+2ngRCdJI0KoKe3tIob5pPvKcHzKcAxZiTLkKyy0lk5Zv8g+qTMFu9KxTAwUeq37Crj+tTJrnzODap01fH7fV0+JKDXnwqtlXFbPTFL1FpqecHZKATOcPPn5UyxGhDla05V5sYpVz6sQj72UG9BfIbPZCsb5JmAMvNd9atcn2ijgkzoV/OG6ek+6TYyU+rzt/HaoXiPuEjVoAOURJbojruqHwX1w0QVi0AWH50Ss2uKLeP3xVnOmjq0GrBC2ywPgvVg0OnH3ZBd342r5FvKf/n19mic1fQ6WUMKZtZSu1uHfsI8pnWx2sYZoRlZYFVWZ89npac0BB8XXEGdWuEYo4Jms+1pFi/cjKvvCy2fhZDcrJbi971hc16jvWbSMcznybAFVJygvbB6vDoEFVYzsCM/SZf3u7MBy2zsWinLuK75u+p8I0pxSkeFrNtpxc9TYde1aNCIhIasV8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(55016003)(38070700005)(122000001)(7696005)(6506007)(53546011)(33656002)(86362001)(38100700002)(82960400001)(478600001)(316002)(26005)(2906002)(966005)(66574015)(71200400001)(83380400001)(8676002)(9686003)(5660300002)(52536014)(110136005)(8936002)(76116006)(7416002)(41300700001)(4326008)(66946007)(66556008)(64756008)(66476007)(66446008)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3FGUTh0NFFqbmNTNHJ5RnB3ZnVIZzNhRmI3bmZpYUpVbXlXcUtOYmJ0eEM1?=
 =?utf-8?B?ZG5mTm9wb0FZY09PTG0yb3JjTit4QU9zQ1I4Z3FSSklIU2pJZkg0ekRxZjM0?=
 =?utf-8?B?Z3RXT1l2VFd1ZEhyOUxmWVNtR0JjL2VTdjF6U3NlaXFKc1RBZ2R4SUJQUUpX?=
 =?utf-8?B?eW1Eb1ZZREVwUmt1Q0NlWHMrbUFReVA3NEJZWEtGdThsQW5NZ2UrVWl6eDhW?=
 =?utf-8?B?QzVYaG5qS0d2andPbXphbTdxN1pZZ3U3T253UEphNm5lQUl4VnViU1g5ejRt?=
 =?utf-8?B?b28xRytxSzEvMWtIV3M4MEVxdmhmWnBBWGRzYU1FTUc5UFh5bU1zaE44NTUy?=
 =?utf-8?B?YWZlaXFJc2V6R05PWUxsdmp0QWFURUVjMGZiK3FGSEVjTmJ1cWZmZjZ1Sytu?=
 =?utf-8?B?emc1bng5MTI5Mk5qYnZjYXRpQVZITjNVbDQ2amRwbldLRXVYV21UbGhFVys3?=
 =?utf-8?B?UEo0aUVmc2sxcEpPbWxnRWUxUThyaFFaYzJsM3RQOGE1bGNmSDlWYWJSYTNG?=
 =?utf-8?B?dWYzUUZUeTVEZTZ1aUNkMEVIMVcrTGgxZUppVmxWcTVNczdtOFhWaE5JUVly?=
 =?utf-8?B?dXQ0QnlEYUFXVUxsS1A4L29Jdit0bmRzNHZhNFQwN2V4bUgva3hrZ3BVaytx?=
 =?utf-8?B?OFNBaGZqcUIzcHpNaU0vaGlzQjZxejdXK2NJdldIeDA5eHZ6a091VXdLKzV3?=
 =?utf-8?B?TXZVRFlkWXhQUFNNd29Yd2Y3YmdUTDZaM0JWSjNiVGJoK2ovTDdEUERvYlIy?=
 =?utf-8?B?QkFQWUxJbzR1TDY4V2JabXdrSmdYdTRobjkzQlpTSGxBWVYzUnFtVWE5R0k2?=
 =?utf-8?B?bTl3Wll0aURvbU94ODEvUDcvZlNzWEczMWxyb3FrVEtYNDRndkpCUTZWVjZP?=
 =?utf-8?B?ZmNEQWUyMXNYQTNrWXVTQ2U0aXRoWkd0ZldCem43N3h2Zmg1d21BaWxvSmN1?=
 =?utf-8?B?bXNQQjFZc3RBWFZQckZSSVM1MVRMbEVzSzIvb3EvcG1YVEkrajRLWk9GRkVK?=
 =?utf-8?B?TjY3UFlnNnh0bFRBN2RXUjI2cXZibVRyWjI5UFZBZG0yYjF4RTdzdVAwNzQ0?=
 =?utf-8?B?djE0VUYwNExUNVI3c1M3OWIrRGFuZTNlOERVb2YzTzU3MGR5Mm5DVEk2Y0RE?=
 =?utf-8?B?dUhPa0M4MXpKcFFRSFJzUkRxajVJcnluQWZDNTJxNUd3Y2JlRkZmN2dqMWgr?=
 =?utf-8?B?YlJoL01rM2lDSkFxdzdKZW9vQVRTMkMzWC91S21DRll5MWhBeWlkelcyNDVB?=
 =?utf-8?B?eng2QWhZNlRUajZJQjZIVHJRR3Y2TnJ1WDNtT1dWaXFROVFPRUVCeXBPYktW?=
 =?utf-8?B?alBDVld4bXc5bU5KUm9sSGo0cEF0aCtMS3luV0twNU9WYm1JZVVoRSsvclJQ?=
 =?utf-8?B?VVZjdUlDNHh2SVkxQlJISllqRDk4TzJTRHd1MExJZ1F2amR0ZTVqQk1JeTU5?=
 =?utf-8?B?b1pzRVIvWWZ6SlhSWVlTdzV0M083L3B4UTlpQWFqQW9IM2RrV0hKaVhQSDg5?=
 =?utf-8?B?NjdkRzRTdUpJb0xGMVgraGlWYlVvWDFFNVdxWHhZSXFEV2RYOVBJOHFUQWpq?=
 =?utf-8?B?UlNyUnBJMm9YRWhEZFJzb3Uxek5PYTRrUHBGM052UGFheDBiV21kMGxFbjk4?=
 =?utf-8?B?cExIYlRsV1Y2OHBFS2FSd2l0MHBxT0VES0JVbWNzajZvQy9tc1dNZmQ2QVl1?=
 =?utf-8?B?RDkwV1VzRjNvNUVaUzBqQ0tzU1hNVFBHdlFJZ3pvbXFiaXM0SkwvQ1BRcUVy?=
 =?utf-8?B?eEhRb3dQZHZ6SkVYdkhKTkpxMGFkV1YybHNvTEUwbjh5d2JVT0lqS0VOb3Bt?=
 =?utf-8?B?Rno2bE5wY2dBLzI5ankzSHlUeExMaHMzU3VweGh1MWRIRXRLeHk3NWFyV2Ux?=
 =?utf-8?B?MndQZ1d1WUNEQzNqUGZBWHdWTis3dWxNZngxREpvNGY5aUZrc2VHYkxVWStG?=
 =?utf-8?B?K2VYSU92cUkybXlNQm83N0ZKaGd6cjk3Z1MrWTZYY2VxS0JhYzZrT3NRMjho?=
 =?utf-8?B?RTViM29qSXRZbGNaZCtjRHlpK2w5MElDRGVQMExMR3hzeVJOVVk3SWFNbVhL?=
 =?utf-8?B?Q3A4aXg2Q1lYVDNlSU5WSEJ5UERnTlRvL2hBS3VxbnJpdTVja1JlVHA3U0FC?=
 =?utf-8?B?K3c2cmErWm85YTVKTy9xejRxOElXVm50ZHlObWxyM0hYc1FSNWc0NlJQdU5p?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb0f0e6-8cf3-493c-cdfe-08dbba5092c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 03:12:22.5268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znC5g0NfESU51vVt6QYSuNpHBe6FRbv4gbB67VMLAwgY6Nch4uVVcZds40VIKKUe/g0crwYRnqHw5bfdXKiNbAq6oWoA3o/ghLZQ21n6rlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7124
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93;
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyA5
OjU0IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAxMy8yMl0gdmZpbzogQWRkIGJhc2UgY29u
dGFpbmVyDQo+DQo+SGkgQ2VkcmljLA0KPg0KPk9uIDkvMTkvMjMgMTk6MjMsIEPDqWRyaWMgTGUg
R29hdGVyIHdyb3RlOg0KPj4gT24gOC8zMC8yMyAxMjozNywgWmhlbnpob25nIER1YW4gd3JvdGU6
DQo+Pj4gRnJvbTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4NCj4+PiBBYnN0cmFj
dCB0aGUgVkZJT0NvbnRhaW5lciB0byBiZSBhIGJhc2Ugb2JqZWN0LiBJdCBpcyBzdXBwb3NlZCB0
byBiZQ0KPj4+IGVtYmVkZGVkIGJ5IGxlZ2FjeSBWRklPIGNvbnRhaW5lciBhbmQgbGF0ZXIgb24s
IGludG8gdGhlIG5ldyBpb21tdWZkDQo+Pj4gYmFzZWQgY29udGFpbmVyLg0KPj4+DQo+Pj4gVGhl
IGJhc2UgY29udGFpbmVyIGltcGxlbWVudHMgZ2VuZXJpYyBjb2RlIHN1Y2ggYXMgY29kZSByZWxh
dGVkIHRvDQo+Pj4gbWVtb3J5X2xpc3RlbmVyIGFuZCBhZGRyZXNzIHNwYWNlIG1hbmFnZW1lbnQu
IFRoZSBWRklPQ29udGFpbmVyT3BzDQo+Pj4gaW1wbGVtZW50cyBjYWxsYmFja3MgdGhhdCBkZXBl
bmQgb24gdGhlIGtlcm5lbCB1c2VyIHNwYWNlIGJlaW5nIHVzZWQuDQo+Pj4NCj4+PiAnY29tbW9u
LmMnIGFuZCB2ZmlvIGRldmljZSBjb2RlIG9ubHkgbWFuaXB1bGF0ZXMgdGhlIGJhc2UgY29udGFp
bmVyIHdpdGgNCj4+PiB3cmFwcGVyIGZ1bmN0aW9ucyB0aGF0IGNhbGxzIHRoZSBmdW5jdGlvbnMg
ZGVmaW5lZCBpbg0KPj4+IFZGSU9Db250YWluZXJPcHNDbGFzcy4NCj4+PiBFeGlzdGluZyAnY29u
dGFpbmVyLmMnIGNvZGUgaXMgY29udmVydGVkIHRvIGltcGxlbWVudCB0aGUgbGVnYWN5DQo+Pj4g
Y29udGFpbmVyDQo+Pj4gb3BzIGZ1bmN0aW9ucy4NCj4+Pg0KPj4+IEJlbG93IGlzIHRoZSBiYXNl
IGNvbnRhaW5lci4gSXQncyBuYW1lZCBhcyBWRklPQ29udGFpbmVyLCBvbGQNCj4+PiBWRklPQ29u
dGFpbmVyDQo+Pj4gaXMgcmVwbGFjZWQgd2l0aCBWRklPTGVnYWN5Q29udGFpbmVyLg0KPj4NCj4+
IFVzdWFseSwgd2UgaW50cm9kdWNlIHRoZSBuZXcgaW50ZXJmYWNlIHNvbGVseSwgcG9ydCB0aGUg
Y3VycmVudCBtb2RlbHMNCj4+IG9uIHRvcCBvZiB0aGUgbmV3IGludGVyZmFjZSwgd2lyZSB0aGUg
bmV3IG1vZGVscyBpbiB0aGUgY3VycmVudA0KPj4gaW1wbGVtZW50YXRpb24gYW5kIHJlbW92ZSB0
aGUgb2xkIGltcGxlbWVudGF0aW9uLiBUaGVuLCB3ZSBjYW4gc3RhcnQNCj4+IGFkZGluZyBleHRl
bnNpb25zIHRvIHN1cHBvcnQgb3RoZXIgaW1wbGVtZW50YXRpb25zLg0KPj4gc3BhcHIgc2hvdWxk
IGJlIHRha2VuIGNhcmUgb2Ygc2VwYXJhdGx5IGZvbGxvd2luZyB0aGUgcHJpbmNpcGxlIGFib3Zl
Lg0KPj4gV2l0aCBteSBQUEMgaGF0LCBJIHdvdWxkIG5vdCBldmVuIHJlYWQgc3VjaCBhIG1hc3Np
dmUgY2hhbmdlLCB0b28gcmlza3kNCj4+IGZvciB0aGUgc3Vic3lzdGVtLiBUaGlzIHBhdGggd2ls
bCBuZWVkIChtdWNoKSBmdXJ0aGVyIHNwbGl0dGluZyB0byBiZQ0KPj4gdW5kZXJzdGFuZGFibGUg
YW5kIGFjY2VwdGFibGUuDQo+Pg0KPj4gQWxzbywgcGxlYXNlIGluY2x1ZGUgdGhlIC5oIGZpbGUg
Zmlyc3QsIGl0IGhlbHBzIGluIHJlYWRpbmcuIEhhdmUgeW91DQo+PiBjb25zaWRlcmVkIHVzaW5n
IGFuIEludGVyZmFjZUNsYXNzID8NCj5pbiB0aGUgdHJhbnNpdGlvbiBmcm9tIHYxIC0+IHYyLCBJ
IHJlbW92ZWQgdGhlIFFPTWlmaWNhdGlvbiBvZiB0aGUNCj5WRklPQ29udGFpbmVyLCBmb2xsb3dp
bmcgRGF2aWQgR2lic29uJ3MgYWR2aWNlLiBRT00gb2JqZWN0cyBhcmUgdmlzaWJsZQ0KPmZyb20g
dGhlIHVzZXIgaW50ZXJmYWNlIGFuZCB0aGVyZSB3YXMgbm8gaW50ZXJlc3QgaW4gdGhhdC4gRG9l
cyBpdA0KPmFuc3dlciB5b3VyIHF1ZXN0aW9uPw0KPg0KPi0gcmVtb3ZlIHRoZSBRT01pZmljYXRp
b24gb2YgdGhlIFZGSU9Db250YWluZXIgYW5kIHNpbXBseSB1c2Ugc3RhbmRhcmQgb3BzDQo+KERh
dmlkKQ0KPg0KPlVuZm9ydHVuYXRlbHkgdGhlIGNvdmVybGV0dGVyIGxvZyBoaXN0b3J5IGhhcyBk
aXNhcHBlYXJlZCBpbiB0aGlzIG5ldyB2ZXJzaW9uLg0KPlpoZW56aG9uZywgSSB0aGluayBpdCBp
cyB1c2VmdWwgdG8gdW5kZXJzdGFuZCBob3cgdGhlIHNlcmllcyBtb3ZlcyBvbi4NCg0KSSBoYXZl
IGFyY2hpdmUgaXQgd2l0aCBhIGxpbmsgaHR0cHM6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hpdmUv
aHRtbC9xZW11LWRldmVsLzIwMjMtMDcvbXNnMDI1MjkuaHRtbA0KZm9yIGNsZWFuZXIgY292ZXIg
bGV0dGVyLCBsb29rcyBJJ20gd3JvbmcuIEknbGwgcmVzdG9yZSB0aGUgd2hvbGUgY2hhbmdlbG9n
IGluIHYyLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo=

