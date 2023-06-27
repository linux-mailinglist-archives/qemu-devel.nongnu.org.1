Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE7B73F107
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 04:56:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDysI-0005U5-Rt; Mon, 26 Jun 2023 22:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qDysF-0005Sj-48
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 22:56:11 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qDysC-0002aO-Ht
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 22:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687834568; x=1719370568;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+kSM/8hGhHb+okFym1HEx0kc7BtOojdKTjLofe9HpTY=;
 b=iYl7Lotp1B6q3a7x+rekVAbMB/YE4QXYJMdReEozGAhbf5EklsWuiBF6
 ma5hD34nROq6Ptd1SGtsSpHdnqslRDUgflwtgR1vNmLBoKtFTuBJHih9b
 2OVE/io0sqgwcvF81DQznZJNKurrGzGVyn35EVlPa137w8zNUvHu5kGAw
 f403Aou8nzomQmplQycYLqtIAqHtzt2NqiTt2GJAZuUShRKFHW75G4PCt
 +R8/wfIFgl6C8a7uxAaCu0Va4ym0yd9kqu736l2YCGaoheVq2EE6/gL5n
 CpMgJ3d6NIpVjK6mxaJaGYbxiGeqcIulnUkz8UdXzICwHJ683iviuH5GW A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="341040010"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="341040010"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2023 19:56:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="806286291"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="806286291"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by FMSMGA003.fm.intel.com with ESMTP; 26 Jun 2023 19:56:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 19:56:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 19:56:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 19:56:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 19:56:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjDQTMykh4nGNgtTBBfezUtOEa7CyGUs4I7LYtch6gjMgDf9wTJWaPeZ1yTeUKdB4A3sJ5kPPqwD5jzO66JuRxGfd3HK4HrKT1A1PQu/mjIY662xwPwhLzQeNrIwctI7kH77ysdTCzm5SwC02xlLFR8130oqOcZwyZgTqSvGoidJXtL993PJwddeENBTdlADIEo2FZm1J5zIZyuL9pEwMEDJO3OCCLtq66ZbTu/IkfUBZQLSnxmQaLAYJM8/I7DrlI4SDkJc4Q3R6xjy/w31ukFvGeWxtUPWpQyBye0Tm8NK8/UP/wD2ZFJBXNnLn4JUiXRIodg+2yfv+5sB3A9bZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kSM/8hGhHb+okFym1HEx0kc7BtOojdKTjLofe9HpTY=;
 b=gvbIpOaFzf9UEM6iXtQ3KY38Bojp+ia7fSbTBeWIGqycwaCHp+G0kvEtk3iMO+fnCz7zSb2myZsE91/FCRzAOeIhGaRyCGnxQ4Z6IWGr+wHG+n2/NxwIxpK+Ay0SGTHOxZV8vSjxTibL6Db+yal8qQjBplYwLe3QaKBuuWZVRl17a/nQE52KAhZclalI3hwVt/wO+IFQRozsmhEdVDmlGNejibARDVznTAW9A59njE8Z4ljIKasoz9IbDzLSJNxZE2YSLkPH2b46TKZEYOmcsyJPLRmJD8+5c/mTauGqaT/LMeNKKb5TFFVZtL47l5nn1elWND1fLx7InMdLI6ut1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 02:55:56 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%5]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 02:55:56 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>, Avihai Horon
 <avihaih@nvidia.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3 3/3] vfio/migration: vfio/migration: Refactor and fix
 print of "Migration disabled"
Thread-Topic: [PATCH v3 3/3] vfio/migration: vfio/migration: Refactor and fix
 print of "Migration disabled"
Thread-Index: AQHZpBiDMAK8vCWoSUWN+eGvuOKtiq+c2rIAgAAMTICAARVJUA==
Date: Tue, 27 Jun 2023 02:55:56 +0000
Message-ID: <SJ0PR11MB6744F88600646B8FD4E7F5019227A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
 <20230621080204.420723-4-zhenzhong.duan@intel.com>
 <c8583433-9b9f-4380-8076-8ca623b66770@nvidia.com>
 <3afe5106-414e-5a3d-4a15-3992f80fac5b@oracle.com>
In-Reply-To: <3afe5106-414e-5a3d-4a15-3992f80fac5b@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB7024:EE_
x-ms-office365-filtering-correlation-id: a75395b8-d8b4-43d4-8192-08db76ba0794
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d100+qLmtskJJXP/WZ5FM2typ09vl0fnlqhcxue0gF+zGkPkOf6Nufu9Ic5fdiOuGgjF0J426R5ZeRNe65HzRC//bWZjWL97svimTMM0lD24m7KnRyhifpILS7R1i+visZTI8PEUqM++n0SBWpMDpv3aszRDfRw8P6S6OdaYB8EQVKa4vVTW8A3R0kpKWTtrtv+FAnmCQoGMqe2hxwJxK7W9AX0zX9gLBK6O3VMtO7GxIY8Ghb35La4/1DjgrliAQxfbWL14OgQ9lMiJGMDEBV4FQ2kq0EMgwGOT+zBjbVbsJjchmReSYIxBLhiNVRKIanF+faSH+1ca0TUDOH8H5hBG80T6AKXxoVCnwvkPvTgQBByYvWhF9krZyx93x1rIOOMq/C7x67OTsTIsLILLLEsVotsn+9gDjiVlXWcBi/+Tkvj6iPn2Obrglz3kz1aMHBO+cTO1hA/cOYDsOORPmmjn183RlM1D0ZhxAtdWUOtH9F40SsgoOo+KTp3xLPYnz3Cr0JvxE/iTHTnF4gi+evd+waBHVCPQDOVNcJwh0ls/tdtiOG2ODnUtMJVyniZ8mv0XDow7fTAdbU0GTJESjB+1Y9ZeLnu3p+VlavSr8iZGOi5oYUbwlcihTkwaJOpw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(66446008)(53546011)(33656002)(52536014)(5660300002)(64756008)(66556008)(86362001)(66476007)(41300700001)(8936002)(8676002)(76116006)(38100700002)(316002)(82960400001)(4326008)(122000001)(55016003)(38070700005)(66946007)(9686003)(6506007)(26005)(2906002)(478600001)(186003)(7696005)(71200400001)(54906003)(110136005)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGNmbWVPQmJlT1E0RXRaeURoUjhadEluMHI0cG9ybUh3UEpoOE9USHF0b2FK?=
 =?utf-8?B?MTdtVFBjM1dGTG5aTC9XS240M0ZGQy9iRkFKYm0zdjZqVnJKeUJOTmJwWk5x?=
 =?utf-8?B?QmVJb05uV1RmcWxRYVFjaWl1U1ZVaWdkL25iS0F2SDcwbkFWVS80WXJkWGIy?=
 =?utf-8?B?TWRPbXFzT3k1dnVoQUh6cE5yTjR2Z3BFV3ZPdFFlckczTXF5cGY1NnFZMXJ6?=
 =?utf-8?B?cS9QTGdzdVJsRnM1NEthdFlvKzBsdHV5d0lQN1l4ejFwVnlsZEludXlMRTQ0?=
 =?utf-8?B?NmlodnFWb3V1MzFkYkw0MzIzK1ZrNzB6SlhPc0pZRmF1WjBncG1teGRRTlVt?=
 =?utf-8?B?dzBZRWpDTGcwMzRZL0ZKc090aDVvN0ltT2ZMeHBVd1YrTE5JekVJVWlOam9o?=
 =?utf-8?B?cE9Ha1RGWGV5VDNkL21BN0t5ajdOdWV1c0owaHQ5YTRLV2VSVThIa1QvYUdU?=
 =?utf-8?B?Y2tJREtTeXorOWFvRVp4RC95RkxSY0lCdGdGSGZRcndsakhQQjU4Z0x5T3lP?=
 =?utf-8?B?emVFajdmNTJia3pSWkVteFl0MEdOWGczSTJtVWtrZUNjbnFLZWJ3Tys4a25Y?=
 =?utf-8?B?WmZNTlZQYUNteEd4K0M1d3k2aGcrdjJEamJ0V3AxeWJGSkVOVlRFQWJhN1U5?=
 =?utf-8?B?OWRJQmxNWER5SjB0WVcvbHRKQUgzU0k5WnVLdklkeWx4SFpoU1ovMURUcW1Y?=
 =?utf-8?B?LzVaalRFQmxyTGJKM21qMytUcmdiVU9mZGxWTzFDQ3NxYzYxRGJITkhBK1Jh?=
 =?utf-8?B?cHNoY1U1dXBOOGZjaEtub2c4c3NqVDZZSHl6L0VrZEVGdWpjRkF5ZGkyd2Vz?=
 =?utf-8?B?MDhiOWxmWEdveWVpUUltR1NYOW5ZcXA5cTFISlpiVEhZWkZUdy9aMHRjMjEx?=
 =?utf-8?B?VmcvQUQyaW9CYU9tNkJHTEVBVHlNb3YvcGxwYWE3enJWd040eGYzdytBTEJ1?=
 =?utf-8?B?WnptNms4Q0VuVmVXM3J5NmpwZ1haU08xNmt1U3NXSExmWnJuWUYwdFFXTXVU?=
 =?utf-8?B?b21qWG1ZbUp3UmtiU21WUkFxdEFybXJ0OXZYSHRvR1orVmF0eHFsNDB1WmJq?=
 =?utf-8?B?NWs1SjZzL2Q4eHdBdmt0T2lZUkdlUitQZUVWdG5ZanVyYk1vejFHVnBiZ2E5?=
 =?utf-8?B?d2F5NEJITVBEK2xvNXlJUG5HMnNOcnVEeVR2Wkh4c3lsWnVvY2tKY3NDL0FJ?=
 =?utf-8?B?UCtGNUJjNzYvVk14VFNpbS9KaU1rWk1lTmlHZlY3Ni9pQ3dHemJSMzJLZWJr?=
 =?utf-8?B?M3ZOcHpQdHJ6VHF6UjVNVWhTNWRPY2tvWlp0ZUptWDhUWWRSNmRPRkZpUWJD?=
 =?utf-8?B?am52SEtTd1BxRW4rRkZNYkJHK294M0NSU1g3SUNIaExJYTU2cmJUUUJGU2J5?=
 =?utf-8?B?Q0pnRStwV1VZOUlOZ0d1Rm0vTkFZQkh5bStHV1hmaHU2WTF2MkFIVDFIUlhR?=
 =?utf-8?B?Nlg4YmRuZldPekI0MFRjYVZ4azJCZ1Q3Skw4cE5HN21XczFyQUtvUzR4cnBj?=
 =?utf-8?B?MmFsUzRTUElTTlM4RmN1SlJTMVJYeWtaSytWclA1aERJYllyNUk0aVhHUlFW?=
 =?utf-8?B?RWEwN2FvdjMxWGIwN3ZCN2tmYUx0MFVWWDVVcUJKTDJZOU9DclBueE1mMGlq?=
 =?utf-8?B?ejZydDZmL1YzcjdRdUpsODBDVG9ob1daOGt5TGFmZnpCVTNqQkYyVnJNSnpL?=
 =?utf-8?B?RTU3RU9CMnhZWkdrM0R2alBDTklpU0dMTTVSMHVuYjlQc3NBcFBJNnhRK1M0?=
 =?utf-8?B?eHBpV3pMWmt5ZEZtUzZqWXB5TWJEQ0JDZjgvQmVkNE1naGllUExKTWRmbWF4?=
 =?utf-8?B?TUJVL1czQTVPYWNZVjI4QjZEZWY2Q1dKTTNITDlFRzFGeURYeFBCN244NFcx?=
 =?utf-8?B?NTR6SXh1YllQVmFtaC9LNGJ3Y2xySjN4VGRGbkZhNkVqc2lkZkUyNnJaQjdj?=
 =?utf-8?B?NUZudFg2NVNBaGYxdjZHQmtYbC82bTJ4MldSNEpITGZyc3YwVlhQeUE5QzJi?=
 =?utf-8?B?NXNzc3AzV0pNSHpIajFIYkoxSkdOdVI1RjZVLzNHd2pzUU5MbUlLZW82YWFY?=
 =?utf-8?B?VCtLcHhySnlyeTRCeTJnRm83R0VkK0x0ZTNTSkhQRUVaWXNvVy91aUdJTk8v?=
 =?utf-8?Q?2Dt9Tpg/ODFZtKrBTiR6obPo7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75395b8-d8b4-43d4-8192-08db76ba0794
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 02:55:56.6151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ksb1aTsExOxX4DwOKgVcLuKlEVxlMV6+qdxlh6+G4Vul/OOFSrbkuue4Y/bL3Vtf9i+zH7TgR3bfj4Et89my1wBeKWieww8umw7o3nPuvmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7024
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mga12.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TZW50OiBNb25kYXksIEp1bmUgMjYsIDIwMjMgNjox
OSBQTQ0KPlRvOiBBdmloYWkgSG9yb24gPGF2aWhhaWhAbnZpZGlhLmNvbT47IER1YW4sIFpoZW56
aG9uZw0KPjx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Q2M6IGFsZXgud2lsbGlhbXNvbkBy
ZWRoYXQuY29tOyBjbGdAcmVkaGF0LmNvbTsgUGVuZywgQ2hhbyBQDQo+PGNoYW8ucC5wZW5nQGlu
dGVsLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMg
My8zXSB2ZmlvL21pZ3JhdGlvbjogdmZpby9taWdyYXRpb246IFJlZmFjdG9yIGFuZCBmaXgNCj5w
cmludCBvZiAiTWlncmF0aW9uIGRpc2FibGVkIg0KPg0KPg0KPg0KPk9uIDI2LzA2LzIwMjMgMTA6
MzQsIEF2aWhhaSBIb3JvbiB3cm90ZToNCj4+DQo+PiBPbiAyMS8wNi8yMDIzIDExOjAyLCBaaGVu
emhvbmcgRHVhbiB3cm90ZToNCi4uLg0KPj4+IC12b2lkIHZmaW9fbWlncmF0aW9uX2ZpbmFsaXpl
KHZvaWQpDQo+Pj4gK2Jvb2wgdmZpb19ibG9ja19naW9tbXVfbWlncmF0aW9uKFZGSU9EZXZpY2Ug
KnZiYXNlZGV2KQ0KPj4+IMKgIHsNCj4+PiAtwqDCoMKgIGlmICghZ2lvbW11X21pZ3JhdGlvbl9i
bG9ja2VyIHx8DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIHZmaW9fdmlvbW11X3ByZXNldCgpKSB7DQo+
Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4+PiAtwqDCoMKgIH0NCj4+PiAtDQo+Pj4gLcKg
wqDCoCBtaWdyYXRlX2RlbF9ibG9ja2VyKGdpb21tdV9taWdyYXRpb25fYmxvY2tlcik7DQo+Pj4g
LcKgwqDCoCBlcnJvcl9mcmVlKGdpb21tdV9taWdyYXRpb25fYmxvY2tlcik7DQo+Pj4gLcKgwqDC
oCBnaW9tbXVfbWlncmF0aW9uX2Jsb2NrZXIgPSBOVUxMOw0KPj4+ICvCoMKgwqAgcmV0dXJuIHZi
YXNlZGV2LT5ncm91cC0+Y29udGFpbmVyLT5zcGFjZS0+YXMgIT0NCj4+PiArJmFkZHJlc3Nfc3Bh
Y2VfbWVtb3J5Ow0KPj4+IMKgIH0NCj4+DQo+PiBJIGd1ZXNzIHZmaW9fYmxvY2tfZ2lvbW11X21p
Z3JhdGlvbiBjYW4gYmUgbW92ZWQgdG8gbWlncmF0aW9uLmMgYW5kDQo+bWFkZSBzdGF0aWM/DQo+
PiBBbHRob3VnaCBKb2FvJ3MgdklPTU1VIHNlcmllcyB3aWxsIHByb2JhYmx5IGNoYW5nZSB0aGF0
IGJhY2sgbGF0ZXIgaW4gc29tZQ0KPndheS4NCj4+DQo+SSBndWVzcyBpdCBtYWtlcyBzZW5zZSAt
LSB0aGUgdGhpbmcgdGhhdCB3YXMgdGllaW5nIGhpbSB3YXMgdGhlIGdsb2JhbCBtaWdyYXRpb24N
Cj5ibG9ja2VyLCB3aGljaCBpcyBub3cgY29uc29saWRhdGVkIGludG8gdGhlIG1haW4gbWlncmF0
aW9uIGJsb2NrZXIuDQo+DQo+TXkgdklPTU1VIHNlcmllcyB3aWxsIHJlbGF4IHRoaXMgY29uZGl0
aW9uIHllcyAoc3RpbGwgc2FtZSBwZXItZGV2aWNlIHNjb3BlKS4NCj5BbmQgSSB3aWxsIG5lZWQg
dG8gY2hlY2sgdGhlIG1heGltdW0gSU9WQSBpbiB0aGUgdklPTU1VLiBCdXQgaXQncyBuZXcgY29k
ZQ0KPkkgY2FuIGFkanVzdCBhbmQgWmhlbnpob25nIHNob3VsZG4ndCB3b3JyeSBhYm91dCB0aGUg
dklPTU1VIGZ1dHVyZSBzdHVmZg0KQSBiaXQgY29uZnVzZWQsIHlvdSBhZ3JlZWQgdG8gbW92ZSB2
ZmlvX2Jsb2NrX2dpb21tdV9taWdyYXRpb24gaW50byBtaWdyYXRpb24uYw0KDQo+YnV0IEkgZG9u
J3QgZXhwZWN0IHRvIGluZmx1ZW5jZSBsb2NhdGlvbiwgc2F5IGlmIGl0IGdldHMgbW92ZWQgaW50
byBtaWdyYXRpb24uYw0KYW5kIGZpbmFsIGRlY2lzaW9uIGlzIG5vIG1vdmUgZm9yIGluZmx1ZW5j
aW5nIGxvY2F0aW9uIHJlYXNvbj8gRG8gSSBtaXN1bmRlcnN0YW5kPw0KDQpUaGFua3MNClpoZW56
aG9uZw0K

