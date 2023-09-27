Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1613F7B042D
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 14:30:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlTgK-0002Oi-8U; Wed, 27 Sep 2023 08:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlTgG-0002O4-Sh; Wed, 27 Sep 2023 08:30:16 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlTgD-00067l-Li; Wed, 27 Sep 2023 08:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695817814; x=1727353814;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gmpubeO64pylWXWjab01LPYJayNfiFEdoqds8kNundE=;
 b=NPmTXONDRLvBCvWiPdodLL/fgEAsMd04cvGrqsfeo/abxIvhAlSwJ5z/
 TOB+GkOTcJBQm3PdiUcNfIZ51I4ZFdfJReR9uiIu1EkprESV3qlmGb9HY
 gsFkNjTb8oqdDzE8rC/EfYH7RgK9DqyLEdlrwfr0zEWEaXJI82tr3wXdz
 +eiqqedLqnUj003nJ4QGEZtq9192NydPEOiOjrfTzfhXDOVqMvo82Nlrp
 cco+LMaosYnfOomi7I//V3h61U7/9b8/5N66CmbZaxuMAnNrbgpkVlXA7
 6zAt2zXVF+Zj6eU1Z1ww/b+YJHlaeSzG6OKMlCNW+FWLFObxYybpppUF/ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="3344132"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="3344132"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2023 05:30:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="864810669"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; d="scan'208";a="864810669"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Sep 2023 05:30:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 05:30:07 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 05:30:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 05:30:07 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 05:30:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZLuh2iHQGTXOjT+CFe73Fb8P6ZkOneQpiA5S6nzmwnL/+SwxA21zlizUUR40gESPvbS8p3ZgBglv6UlTrQ97g/ioFmEY631MTUvZy+5Q0memVnSD8z5Jyo6wFcztdQWEk8s/VA748C5+mMS7NH/sJ9NOOmfAu5+GMM2SNnOtBuv/3Kss0VPD2Ef9jMKe9wSmi4Hy9X/Ke0fF0wzIaom5EO9HTwJNTzXaIpzKT7Fod2+WeF8W/GHU14moIyPLO5xUsATaIC3pJ/O7RO4ejGkiqtpygW+pDZ2prUxPO7s38GJ8gtK4qsP2gK1GrW/xW5uiVPIBr1IA51hweKy1RLF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmpubeO64pylWXWjab01LPYJayNfiFEdoqds8kNundE=;
 b=ZgYCvqkIcQm/lEmGbvsWf2xxeUle7UL1jXCaJdr15/whgV2lyVnvV02vNQnC3ymmVECTO1YFFGEcfmPexICblJDk8LPq9Qld7DZ/XqKYZvRtZlbyEDuKn2O2PLIphUIy7oMJVuHqaDhc+HKLmdxar7fxu2Qe2tXqI/ZRh9PWIKAz+I7UKJLvCA2kwGFy8UcTGzg90DcZ653g1asft2xVttEbyZxwmtzfmxb9OqhE14CZ2ezZpbeRqnb34M0ta5dQCKgE5zdxca4q4zx2r8ZOHcj9lDFiwK8LZVmvEJCfiNXCtsPvcDOfYxbmaLAIQADePLk53DlJ0kLdhAjOzF+cLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by DS0PR11MB8000.namprd11.prod.outlook.com (2603:10b6:8:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 12:30:04 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24%3]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 12:30:04 +0000
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
Thread-Index: AQHZ8G9VLwgGo0P7UUGFdxVvIkiJF7AuZaaAgAArHiCAAAljAIAAAMAg
Date: Wed, 27 Sep 2023 12:30:04 +0000
Message-ID: <PH7PR11MB6722BC75E6B32425036CBA9792C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-9-zhenzhong.duan@intel.com>
 <78bc5496-a017-4f5a-a825-df992ef86016@redhat.com>
 <PH7PR11MB6722A8CD7B8CF95DA2FA92A492C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
 <dad18bf6-1e1d-15c4-fb87-7359a7a97e68@redhat.com>
In-Reply-To: <dad18bf6-1e1d-15c4-fb87-7359a7a97e68@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|DS0PR11MB8000:EE_
x-ms-office365-filtering-correlation-id: 3739aa22-09d5-4a20-671b-08dbbf557a1c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1XMxniOQOsjBIC6kb4q4xWdLv+rRa0oJbdeeyYbNScO1pGsTldbTK0r0I/6tEVmT4slJulUmZjmjqNmqMDc3Ij4R7EyWq3XsP0jzlsBzmjx348Qg+tOO8g6HyVZ1oZgv6U6LAbJWwhhAxB44PSYAber45nKxDJqPIM1Yy8wR2HubhJYtyOUye6x6tusWPNZf0gcu8JR1yZ6lQBAdKyuxhnsyZPi96JyEVxkHaIVHqc4vd7JgZnwqhfT84W1VnR4X7FJksSp46Q848bYIVgHTg8KzwN89B7k2HSC7gsuCHvqHbvexg7Q8jbGneLODpsnLeW3KQvkztGgND4PkDNvSSUf0WBVrSe5lK+MdYLIKumY4HZ25mBSffG0BJVzAQ8jB2oZ5TCS9P9k93zrt1Ce5MztJ7aU08v4HfEalyfaXqqJur+xF9ftPu8X5phN3EuML7pwbbd206Hbtjgpy7Hl895yUlWuErTHSWNj7Dle7bBI5b7CDqCRBYwtwvkL0U9hgIxJNXE9Eha12Dine06YA2dnYf9j/ujgMXkCCRVOKiX3pg2ECSP3AC4fzjULqyJ+FT8LctS4jlw9QKeQBBVC+CSLN24krhpxgTsmyZ01HPg9JC4WjFrprJ6PjWdZSODu0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(1800799009)(451199024)(186009)(53546011)(6506007)(9686003)(7696005)(33656002)(122000001)(55016003)(86362001)(38100700002)(82960400001)(8936002)(26005)(7416002)(2906002)(66446008)(478600001)(83380400001)(71200400001)(38070700005)(52536014)(110136005)(54906003)(8676002)(41300700001)(5660300002)(66476007)(4326008)(66556008)(316002)(76116006)(66946007)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azdwdi8xb2NOZUJURE9nR3d5Qzl1OENVZkx6Q3h2TEFJYU4wK3pqRC9KSHdO?=
 =?utf-8?B?YURkeUh3QnhPaXpIb1ZRWitpL2c2ZHZnVVZrUHBPU1pwTkhHRTJvaEJtZWNo?=
 =?utf-8?B?aVoxSzV5ejBJL3hSd2FaLy8wZmlJaGF0VksyV25RZkFQcnZrZWhZOGV4c0x3?=
 =?utf-8?B?RmxYR3RZSjB1SWJBdU1BTEplalp5MkorWEhkUWNiUUdmQS9LMDVhYzRtcEc4?=
 =?utf-8?B?bXh4RXZkU3J4bnFVOXZ6dXh2RmoxSnlqcld0Q1pTd0lpUEs0dmFBd0hReGlk?=
 =?utf-8?B?RjZXdWVxQm00ZHFabGZxc09oT0QrZHh1VDdkU3c2OXJpOUtZMEdDYzJaYjc1?=
 =?utf-8?B?U1JQc1Q3Q0pCWE43Z2VueGNsM1BiYUtiVFhDZFhOeG5NeTNSRjJFellRc2Vp?=
 =?utf-8?B?MFFSQnNIZ3hyTEptbXF5OXFsQXJzcFZ3ZC9ocGdrcWloQlR4U29iTWVNV243?=
 =?utf-8?B?UG42SDEvWXN3QXNOSURpVXJJalBBblZwLy9xd0xCU2VYanc2U1prQVczN2U2?=
 =?utf-8?B?L1FVVFJkT1hWRzViK3pMTUVqSHhRV0h4VU43LzlvSWxIRjBjaTExZjZUZWZ2?=
 =?utf-8?B?NUcwZXM1Y2EyaVFndEZqelJiSzRKd215WGFXKzNvaitJcmVDWm56NWNHb1N2?=
 =?utf-8?B?ZkZINC9nLzIvTlpZSEFNM3UyVWd3NzQrNjNFdE1TalBzSG9oNEkrdklHQUdG?=
 =?utf-8?B?VzZHRXpSWHc1cnpDQjN5UXZmWDJRUDQ3Mm03eGZEK1A5NS95QWs5ZldXWEk4?=
 =?utf-8?B?M2FYT1dRWTlYejVVTWxmWldKc0xvT3g5R0hLdUF1TU5jcGdTeWlxclJFbGNr?=
 =?utf-8?B?ZU9vNHJERnYyeTRUY05ZN2pKa2pRNHRzWlpVTExub3lhb3I2S2xMaXJYMzh4?=
 =?utf-8?B?VE80RHZsZUZON0czTjJBaXhSaEx0M1NuWmhKcjhSZU1zbTViR0hvL1NGSVFw?=
 =?utf-8?B?dlVncEFIYUlUMUVaTHljVEY1QkdPNS8zZlZhNXFGL29YM3JQM09IanpocWls?=
 =?utf-8?B?T1ZrVDBMdGt4MEVrYy8wbG1aeTdSOUxoanJ2YUx1M25tL2FlbytXd1ZVTDNC?=
 =?utf-8?B?V21CZlhYZXJqOGl2RHNZSnJEeVArMlpDaFJsRkY0WmJMbldUOWk0VVNvaUJ1?=
 =?utf-8?B?ZjI1SlpGb2d4WkRsWnpaeG1jNlFNWHEwdHVUVktDV0pPUWg0aWw3WUNIUlZY?=
 =?utf-8?B?d2lYdU9QWFFjRmlmTnl5TFZDcHlYSHcxT1BZeUVGeVNKbFZFc1lWWnVqNGlW?=
 =?utf-8?B?S2JVTXNFVWh6T3F4Wk12YmIxSXdlV0U2L0N6QW5yY0lkNTF5alVPcHhnZjZ2?=
 =?utf-8?B?VHpBZDdhVGNTUm9EQkptM3Z0djJCQ0RidmpySzVLRmNubDNFbjM5Q2c0Zjdj?=
 =?utf-8?B?Z0Y5RlhNRU1rSThLaFZqMmIvRHFhemVmekhlcnBZQTRsUzRVRlBUb09YTXlr?=
 =?utf-8?B?dmc1VFE1OWRubVNMNTFNU2lSMk90Q2ovZDhPWElIT0paSlFLQ2xDamdsV21x?=
 =?utf-8?B?bjFqaEFZU0tKUE9NWVVMdm40ZW5qemJIdS9rUUR5bkp5S2FMcmwwcDFPd2lN?=
 =?utf-8?B?VkVHSGMvUDBGNEh0bmhRdlJ2anFWRUNQYTlEWFRKZjRBL2c0TEszNVRBUFgw?=
 =?utf-8?B?TXdOMUVHL1lZaHBSMldteWJCTURMZERBTnlXZnJRdjc3SnVFRlhEaVB3NDls?=
 =?utf-8?B?eUE2Y0IxOWV2TEpyR3AxVkVQMXNFYWRCTlJuaXpzSExUNENva3U0M24yYVc1?=
 =?utf-8?B?NFhCWHU3aG13ck53SEYzZ09iWG9lQzdUUXpqcHN4TDE5VWFGaU15bGg3YU5U?=
 =?utf-8?B?aGJrOWozTExHM2t1alkvY3ZmRnVwcXVUTjRlcHUrRFhINzZlcVN2V0ptSjVI?=
 =?utf-8?B?WTJjT0lqTUUyVEFVRFM4MzVrWDZWMUIvTS9hNGF5bm5kL21vSGhzenRrT3hE?=
 =?utf-8?B?UTBiUnBBc0YzZStROGQwTjUxUnJ6T3Y4SHRid2ZDd1IydEJHWTRoakJ1Z2Jo?=
 =?utf-8?B?VVB5eFgwbjRwb3pOM1NadzRaNndnM2UzTlgxU1dsYVpBM1RUMEYyTjU1MEts?=
 =?utf-8?B?VVdqOHQzbFJHcEpScSthb2pleEUzYllXaHBRY2xZN1pyQUxod1dkdVdsSXZN?=
 =?utf-8?Q?weStc495gnzCLmJK7rVs7Zd3z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3739aa22-09d5-4a20-671b-08dbbf557a1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 12:30:04.4787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tw27yPjmFPUsldUeJRhthXi+X/9aywAGZBHFxggzmbRumTzSYh2P5wqiTYD0pDfI27pH+Ad80oFdKVZ7bLFDvPTSVQYp6llZcHzvt3n2nPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8000
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDA4LzEyXSB2ZmlvL2Fw
OiBVc2UgdmZpb19bYXR0YWNoL2RldGFjaF1fZGV2aWNlDQo+DQo+DQo+DQo+T24gOS8yNy8yMyAx
Mzo1MiwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPj4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+
PiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNywgMjAyMyA1OjE2IFBNDQo+Pj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MiAwOC8xMl0gdmZpby9hcDogVXNlIHZmaW9fW2F0dGFjaC9kZXRhY2hd
X2RldmljZQ0KPj4+DQo+Pj4gSGkgWmhlbnpob25nLA0KPj4+DQo+Pj4gT24gOS8yNi8yMyAxMzoz
MiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVn
ZXJAcmVkaGF0LmNvbT4NCj4+Pj4NCj4+Pj4gTGV0IHRoZSB2ZmlvLWFwIGRldmljZSB1c2UgdmZp
b19hdHRhY2hfZGV2aWNlKCkgYW5kDQo+Pj4+IHZmaW9fZGV0YWNoX2RldmljZSgpLCBoZW5jZSBo
aWRpbmcgdGhlIGRldGFpbHMgb2YgdGhlIHVzZWQNCj4+Pj4gSU9NTVUgYmFja2VuZC4NCj4+Pj4N
Cj4+Pj4gU2lnbmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0K
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+Pj4gU2ln
bmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+
Pj4gLS0tDQo+Pj4+ICBody92ZmlvL2FwLmMgfCA2OCArKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKSwgNTcgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ody92
ZmlvL2FwLmMgYi9ody92ZmlvL2FwLmMNCj4+Pj4gaW5kZXggNmUyMWQxZGE1YS4uMTZlYTdmYjNj
MiAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvdmZpby9hcC5jDQo+Pj4+ICsrKyBiL2h3L3ZmaW8vYXAu
Yw0KPj4+PiBAQCAtNTMsNDAgKzUzLDYgQEAgc3RydWN0IFZGSU9EZXZpY2VPcHMgdmZpb19hcF9v
cHMgPSB7DQo+Pj4+ICAgICAgLnZmaW9fY29tcHV0ZV9uZWVkc19yZXNldCA9IHZmaW9fYXBfY29t
cHV0ZV9uZWVkc19yZXNldCwNCj4+Pj4gIH07DQo+Pj4+DQo+Pj4+IC1zdGF0aWMgdm9pZCB2Zmlv
X2FwX3B1dF9kZXZpY2UoVkZJT0FQRGV2aWNlICp2YXBkZXYpDQo+Pj4+IC17DQo+Pj4+IC0gICAg
Z19mcmVlKHZhcGRldi0+dmRldi5uYW1lKTsNCj4+Pj4gLSAgICB2ZmlvX3B1dF9iYXNlX2Rldmlj
ZSgmdmFwZGV2LT52ZGV2KTsNCj4+Pj4gLX0NCj4+Pj4gLQ0KPj4+PiAtc3RhdGljIFZGSU9Hcm91
cCAqdmZpb19hcF9nZXRfZ3JvdXAoVkZJT0FQRGV2aWNlICp2YXBkZXYsIEVycm9yICoqZXJycCkN
Cj4+Pj4gLXsNCj4+Pj4gLSAgICBHRXJyb3IgKmdlcnJvciA9IE5VTEw7DQo+Pj4+IC0gICAgY2hh
ciAqc3ltbGluaywgKmdyb3VwX3BhdGg7DQo+Pj4+IC0gICAgaW50IGdyb3VwaWQ7DQo+Pj4+IC0N
Cj4+Pj4gLSAgICBzeW1saW5rID0gZ19zdHJkdXBfcHJpbnRmKCIlcy9pb21tdV9ncm91cCIsIHZh
cGRldi0+dmRldi5zeXNmc2Rldik7DQo+Pj4+IC0gICAgZ3JvdXBfcGF0aCA9IGdfZmlsZV9yZWFk
X2xpbmsoc3ltbGluaywgJmdlcnJvcik7DQo+Pj4+IC0gICAgZ19mcmVlKHN5bWxpbmspOw0KPj4+
PiAtDQo+Pj4+IC0gICAgaWYgKCFncm91cF9wYXRoKSB7DQo+Pj4+IC0gICAgICAgIGVycm9yX3Nl
dGcoZXJycCwgIiVzOiBubyBpb21tdV9ncm91cCBmb3VuZCBmb3IgJXM6ICVzIiwNCj4+Pj4gLSAg
ICAgICAgICAgICAgICAgICBUWVBFX1ZGSU9fQVBfREVWSUNFLCB2YXBkZXYtPnZkZXYuc3lzZnNk
ZXYsIGdlcnJvci0NCj4+bWVzc2FnZSk7DQo+Pj4+IC0gICAgICAgIGdfZXJyb3JfZnJlZShnZXJy
b3IpOw0KPj4+PiAtICAgICAgICByZXR1cm4gTlVMTDsNCj4+Pj4gLSAgICB9DQo+Pj4+IC0NCj4+
Pj4gLSAgICBpZiAoc3NjYW5mKGJhc2VuYW1lKGdyb3VwX3BhdGgpLCAiJWQiLCAmZ3JvdXBpZCkg
IT0gMSkgew0KPj4+PiAtICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJ2ZmlvOiBmYWlsZWQgdG8g
cmVhZCAlcyIsIGdyb3VwX3BhdGgpOw0KPj4+PiAtICAgICAgICBnX2ZyZWUoZ3JvdXBfcGF0aCk7
DQo+Pj4+IC0gICAgICAgIHJldHVybiBOVUxMOw0KPj4+PiAtICAgIH0NCj4+Pj4gLQ0KPj4+PiAt
ICAgIGdfZnJlZShncm91cF9wYXRoKTsNCj4+Pj4gLQ0KPj4+PiAtICAgIHJldHVybiB2ZmlvX2dl
dF9ncm91cChncm91cGlkLCAmYWRkcmVzc19zcGFjZV9tZW1vcnksIGVycnApOw0KPj4+PiAtfQ0K
Pj4+PiAtDQo+Pj4+ICBzdGF0aWMgdm9pZCB2ZmlvX2FwX3JlcV9ub3RpZmllcl9oYW5kbGVyKHZv
aWQgKm9wYXF1ZSkNCj4+Pj4gIHsNCj4+Pj4gICAgICBWRklPQVBEZXZpY2UgKnZhcGRldiA9IG9w
YXF1ZTsNCj4+Pj4gQEAgLTE4OSwyMiArMTU1LDE1IEBAIHN0YXRpYyB2b2lkDQo+Pj4gdmZpb19h
cF91bnJlZ2lzdGVyX2lycV9ub3RpZmllcihWRklPQVBEZXZpY2UgKnZhcGRldiwNCj4+Pj4gIHN0
YXRpYyB2b2lkIHZmaW9fYXBfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnAp
DQo+Pj4+ICB7DQo+Pj4+ICAgICAgaW50IHJldDsNCj4+Pj4gLSAgICBjaGFyICptZGV2aWQ7DQo+
Pj4+ICAgICAgRXJyb3IgKmVyciA9IE5VTEw7DQo+Pj4+IC0gICAgVkZJT0dyb3VwICp2ZmlvX2dy
b3VwOw0KPj4+PiAgICAgIEFQRGV2aWNlICphcGRldiA9IEFQX0RFVklDRShkZXYpOw0KPj4+PiAg
ICAgIFZGSU9BUERldmljZSAqdmFwZGV2ID0gVkZJT19BUF9ERVZJQ0UoYXBkZXYpOw0KPj4+PiAr
ICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2ID0gJnZhcGRldi0+dmRldjsNCj4+Pj4NCj4+Pj4gLSAg
ICB2ZmlvX2dyb3VwID0gdmZpb19hcF9nZXRfZ3JvdXAodmFwZGV2LCBlcnJwKTsNCj4+Pj4gLSAg
ICBpZiAoIXZmaW9fZ3JvdXApIHsNCj4+Pj4gLSAgICAgICAgcmV0dXJuOw0KPj4+PiAtICAgIH0N
Cj4+Pj4gLQ0KPj4+PiAtICAgIHZhcGRldi0+dmRldi5vcHMgPSAmdmZpb19hcF9vcHM7DQo+Pj4+
IC0gICAgdmFwZGV2LT52ZGV2LnR5cGUgPSBWRklPX0RFVklDRV9UWVBFX0FQOw0KPj4+PiAtICAg
IG1kZXZpZCA9IGJhc2VuYW1lKHZhcGRldi0+dmRldi5zeXNmc2Rldik7DQo+Pj4+IC0gICAgdmFw
ZGV2LT52ZGV2Lm5hbWUgPSBnX3N0cmR1cF9wcmludGYoIiVzIiwgbWRldmlkKTsNCj4+Pj4gLSAg
ICB2YXBkZXYtPnZkZXYuZGV2ID0gZGV2Ow0KPj4+PiArICAgIHZiYXNlZGV2LT5uYW1lID0gZ19w
YXRoX2dldF9iYXNlbmFtZSh2YmFzZWRldi0+c3lzZnNkZXYpOw0KPj4+IEkgdGhpbmsgd2Ugc2hh
bGwgZG9jdW1lbnQgaW4gdGhlIGNvbW1pdCBtc2cgdGhlIGZhY3Qgd2UgdXNlDQo+PiBZZXMsIHdp
bGwgZG8uDQo+Pg0KPj4+IGdfcGF0aF9nZXRfYmFzZW5hbWUgaW5zdGVhZCBvZiBiYXNlbmFtZSBo
ZXJlIHRvIG1hdGNoIG90aGVyIGRldmljZSBpbml0DQo+Pj4gc2VlIDNlMDE1ZDgxNWIgIHVzZSBn
X3BhdGhfZ2V0X2Jhc2VuYW1lIGluc3RlYWQgb2YgYmFzZW5hbWUNCj4+Pg0KPj4+IGFsc28gbGVh
ayBvZiB2YmFzZWRldi0+bmFtZQ0KPj4gSSBmcmVlIGl0IGluIHZmaW9fYXBfdW5yZWFsaXplKCku
DQo+aXMgaXQgY2FsbGVkIGlmIHJlYWxpemUgZmFpbHM/DQoNCk15IHVuZGVyc3RhbmRpbmcgaXM6
DQppZiByZWFsaXplIGZhaWxzLCBlcnIgcGF0aCBpbiByZWFsaXplKCkgdGFrZSB0aGlzIHJlc3Bv
bnNpYmlsaXR5LCBpZiBzdWNjZWVkLCB1bnJlYWxpemUoKSBzaG91bGQgZG8gdGhhdC4gU28gYXMg
eW91IGNhbiBzZWUsIEkgaGF2ZSBkb25lIGl0IGluIGVyciBwYXRoLg0KDQogICAgaWYgKHJldCkg
ew0KICAgICAgICBnX2ZyZWUodmJhc2VkZXYtPm5hbWUpOw0KICAgICAgICByZXR1cm47DQogICAg
fQ0KDQpaaGVuemhvbmcNCg==

