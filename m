Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 099E87366BD
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:56:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBX96-0004i4-Dc; Tue, 20 Jun 2023 04:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qBX91-0004hq-06
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:55:24 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qBX8x-0005CH-8h
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687251319; x=1718787319;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wMzneVnPPSv9Bls6WCxBQ8yp2f/TjIvummVJQzZtyZQ=;
 b=A+J0Lw2RsYkXHhNXjM08sMVgmfs5NJUpz3fD0q945IFfuZEg6Zuu2Wig
 /cpuz2MFlz4S5mWtCzzngvaJ1oM0aYjt1Oxp60QaBQdOVcvPgScEmE/I8
 pDF4GtGhfDPpJNK0rFCaSzhYRHS3TCsYcWB96CopRQcjUFSdHrE9QDnVi
 83286mQsrNT5WqlmFJvRaF/4Sdb9DZQhRpiHUC062VGIh3FnTuW6sx8MR
 qRH0hClDvQzP9a50Ta0gGLp2LU4VDGSd3nGc2frkVOzD1RGEtKnxvOh28
 mEamYSmAKKg3MELezq9Kf9tRZ+W/mH77Qd0DT1QW/NkVfRGrT8y+ynobb Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="363229012"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; d="scan'208";a="363229012"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 01:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="826896756"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; d="scan'208";a="826896756"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2023 01:55:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 01:55:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 01:55:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 01:55:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 01:55:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSD1XtPdgea6GkzA6WET4fRmzqhfCleDgx+qPl5MzHftnMQN5y/TupnKHFTS+6l//SAjo3vTpGiP/eAklPMH9cS6CIyGVGuUyiEhy+kXRHTL7kguJWOS05Qcvu3fACrr8uihrQZPoyaEXsQldm5n/dDy5GTQAgUBHLso1V9FLFd7C4Xl15xA/8ulv2uKlqhk1J7MZpLwxUDrsgRC06Ta+bTJ61juLB8x9g41P9Or2GKAXjFX4mvN7lkQ2xocQ15nFjUrK3R3rhR9L1NAuY3/qo9uF7zE99tU4pUa36NkRj3jaFojVnJ26GegJzIuWxwixlE9n9Dc8XjiT2AQUcMeeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMzneVnPPSv9Bls6WCxBQ8yp2f/TjIvummVJQzZtyZQ=;
 b=a3rIsc+c28BIhvNCmE2whYQ0uPaJ1Mx0d46QayGYQGNsLhJGgumgdoiNo5O9CyYld7S7ef0tB4sEm7mSreyP0uArv6izZrXJHZy9i7GZk/QhcL4+mnIzcDdzCdk4WhmTZH+kWdKco+32N47ebAG5ZOSY1/RBz5a6bBFYkdyyCQ3/R86+NK6QaUWLvWwIYrKh7Y9Dml6/7LNIkGN3i9hyFbLgJneSmBPbPpmzuTc9fYgJfSNQm+dzmsJfi+U76AWHLUof2hvH6bz1J5my3ue1DucYXQda6FG66zX303k5r46m61CObqllJCcRC67Pl+Yc9H8llpxJboJ8RBj273XWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW6PR11MB8389.namprd11.prod.outlook.com (2603:10b6:303:23d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 08:55:07 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 08:55:07 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>, Avihai Horon
 <avihaih@nvidia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2] vfio/migration: Refactor and fix print of "Migration
 disabled"
Thread-Topic: [PATCH v2] vfio/migration: Refactor and fix print of "Migration
 disabled"
Thread-Index: AQHZoowecKaj4XAnBEKc7Un5J/J7Ha+R+RWAgAEJD5CAAFm6gIAABcXg
Date: Tue, 20 Jun 2023 08:55:07 +0000
Message-ID: <SJ0PR11MB674447BF091C1EF4789B726B925CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230619084446.399059-1-zhenzhong.duan@intel.com>
 <41469da8-dae3-df36-6de1-4b44bf6ba508@nvidia.com>
 <SJ0PR11MB67443F8A4A7AF037379355C5925CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <a49cbb60-d2ac-6329-806a-260d602d3056@oracle.com>
In-Reply-To: <a49cbb60-d2ac-6329-806a-260d602d3056@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW6PR11MB8389:EE_
x-ms-office365-filtering-correlation-id: 98252d62-5c98-4338-eaa6-08db716c0be2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9AXSMdKj/K2kQfFhCDG9njEjqEV3sNoTNL/IDgEwwI4JZnLEhF5UQPzmYh+DFx9BShZrdKCV6w+6CHaDXgS4MiTEsFhuEBjJNnohLp1cMzJ7QvVr0gzSJcyQcgjZdsBBPQBPWL80znH6B24o6pWG8m57gYKE8qggtzUo3sDDIdNz/qy1uby/NFLrh7l3l7oZWRH6NsCVGxSNkpw0XnE4qgypNFVoSAFVuBjrPwtixGw9SZmSkdlfktYEEFakfuq4L9GxMQrvbN4/yYZ8gq72KL40sWms4gicZS0DuPuKmLu6YZMBaOm3wcUJCXwHwExnXdzZndxUEUfbeadE3lCX40+RI7uPR4uSn4CJCxdWY8ckKMs7579ZQej8om3FCegEaA8UHPztP/cqUwK0zCKc1Aj/TogLai42jPIxLhEuF3JFc2zaxljexuY9+xNr1r8BO5hdL8fCtr4f2vKzuJznGC/ihXDFm5AAAMnSV8lxWF7JpZKIDvqSaHTFKQMpTp/5vf7Z1PuXeQch9w4oVU41en3cQFwTzh1avpZIHVaDAGfPY+86AB2EAPh/R4ffAi0YnOd5YjurLAHoSvAQUFBemskjWY+dfXiDzdzqvaYyhHwYVKwckYzf+mS2BRa/aWoa
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199021)(5660300002)(478600001)(26005)(52536014)(76116006)(66946007)(66556008)(64756008)(66446008)(66476007)(54906003)(110136005)(316002)(4326008)(41300700001)(2906002)(71200400001)(7696005)(8676002)(8936002)(107886003)(186003)(9686003)(6506007)(83380400001)(122000001)(55016003)(38100700002)(82960400001)(33656002)(86362001)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXF6NzhmcHc1N2s0dXVDOG1zcHpSRTIvREFXNFo1SWFGeEVSeWcyVGdDTzh1?=
 =?utf-8?B?YlJEdWhPandUS1N1N21QdUh4TldmYVhoWnB0c2dTVE5vWnNOajJZd1gzcFJU?=
 =?utf-8?B?anNqWTJRS2YxZ201d2x5eDFFZi93YkVFYm5ycXBkeVBjQk5RZnZvem1TUG44?=
 =?utf-8?B?ckN3SG51L1Q2aTVwRUtQMVBMWHFZQ2xyQ1hqck5kVytaSVNjQ1V6RDVXN3Yw?=
 =?utf-8?B?QUlUaU53NUZCQys0QzB1K3psZHNBajdSTGRVdjZjZmNOWHAxdUdyd1RMNHM1?=
 =?utf-8?B?VzJ4UkF3ZnUvL1c3Wm1RZFA5bndrQ0xFSEV4bDl0bEVhbDRhVHh5dTg2MXBa?=
 =?utf-8?B?aDlRYTlkbUp4MG1IUlhMR0pLSS9PMHR6R0N0QjdjeW5uQXNjNy9hM3ZZRVRC?=
 =?utf-8?B?Mk00MXorV1BULzAvQXdWT1VLaHJ3MDJBczhlYzJ2MG0wVmdJQ1BuQUdoeE5Q?=
 =?utf-8?B?d2p3U3Q4SnB0WUdYU0kxZXAyYXEwOXYrREtaNmhUZjFjWVI0SHdPNXlPZlJp?=
 =?utf-8?B?NTIrVHFrSjdoNkNSQjlnL0lSbWIwd2s4c3BvZW1DSHE5eGtzNTVwWEFoYzgw?=
 =?utf-8?B?aDAyVkRLSlgwQzI1RTlZWVRkeTlhMks3eEh6a0N5QWFyWk8xOTJ6aXUrVXB6?=
 =?utf-8?B?NjBETkJybGlhVk5SeXllb1I5MXBsMnZVQW9MMHh4WExCWFBYS3Zjdm0wYkpy?=
 =?utf-8?B?Q092d2REODJzMGV1NFlSamd1VFNhSFJlNy9pOXRBakdCQWpEQjB6MnZzZEdp?=
 =?utf-8?B?S3lQTm5pdFcrQ3Q4YlVCT2QvQ2NZL2Y5TEZiMENXaU90Nm5Yc0dDcFk1ay9s?=
 =?utf-8?B?Z25uQlo1b09FdC9oNDdSNDMyVDNkenBFck5ORWNvU3dMZGN1ZzJ2Uis4N2Yr?=
 =?utf-8?B?OHZQMDVnK1dtandKR0xiMFI4R2poNTgxVklyMFBkMG51WEc2TUVWczhMQm16?=
 =?utf-8?B?S1pnd3dnZGF4OW82Rkl3NlJEaDZUbmVMbndBb3IzQlRLNkxOYy8wa2ROelV2?=
 =?utf-8?B?N1NXdGJQeUcyZHczd0V5ZzZCdUFuL2lDUSszejRJNm4zWVZZa0J3aW52UTBS?=
 =?utf-8?B?NW40K2ZybkFRWXhWOFdqQWFPdENmS3dkSktMWEhzbVEwcHZVaVU1SVQ5MFdB?=
 =?utf-8?B?cTl1cDZuTC82NVprbVdHYzUwc1F3R0t5SUdKNjA5MjJ5V0NMalRrZzBIemFX?=
 =?utf-8?B?ZksvOXlTVE1jT0txOWVjSWxPQzA3ekZMeGlwNEl2a1RCOER1Mksvbm5ZY1F2?=
 =?utf-8?B?VGJDVVI0eFd6NHZMaGZHc0lzOERTZHMvM0UrcFdWaW9tYWpMWllhckZIdURr?=
 =?utf-8?B?VUIwaFYxYWlhcGlHMzJuei9LWUJKeEw5ellyRERXRko1ZUxLWkxVTEZPY1dy?=
 =?utf-8?B?VnluMmhBQ1RZcW1PL0NzOVprSXB5VitZSTByQTBMcUJEQ0pOWSt3NHBDOVBB?=
 =?utf-8?B?M3ZtQWpWYkpiRGZPSWpaMHZPdkVPZWQ4a01ydGtvL2I0NXUrTnpUKzNNY3FU?=
 =?utf-8?B?NEVBOWt5Tk5McndacitCTmhMS3hMM3BwZm9BNzhRaTVKQWZ6eDJnMnhvMUhD?=
 =?utf-8?B?WGJUUnhwN2E3TmpBWTNDNmpIYVFqc2o1dmw3cGVHZmVEcHArdkRJRU92ZnNt?=
 =?utf-8?B?S0p0bjBYL2lhdnJVbVRwVkVHOTRZUHp1MTBIT3ZoZjZGbW4raENnOEQzQVdQ?=
 =?utf-8?B?QlNRZkNac2ozdEl4czhqYVNueXh3cEZwQVdibzBBMmY1Y1U4Ny9kVGNxT2Fl?=
 =?utf-8?B?T2NkaDRLTlA3ZlhtdzA5U0NQWWNXOGF6ODBVZG16K1JXTzVFMlg3UWtJZnV3?=
 =?utf-8?B?VEY4Wi9WcVB4WkRMMU8rOHJjd1gwR3kzV0tVaHFYSFJBV0p5TnNPdnN3NnMz?=
 =?utf-8?B?TkpveDlJaUpVUmVkdWNaazR5bmdPMk9WRUp3anRBU1VKOXJQaS9hbytEcnNo?=
 =?utf-8?B?NXAwKzN2VTNCaTVEQkpFZWd6OGo4U2g5VE4rRlFSdFpHdUVMMmlEeGw2ejlz?=
 =?utf-8?B?SUtWY0dsU2Z3OGV6YTlhcUJLck5KQ3JwWUNyb3ROVUJyZHVQb3ViblZVdFJn?=
 =?utf-8?B?WC91bERjelVzT1hoQUFRanM5aDY0V1FkejMwNUE3NG9ISE1TZlhTNzRPSEtH?=
 =?utf-8?Q?TxRRAXqbhbZFLiL5Yl1KSeznD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98252d62-5c98-4338-eaa6-08db716c0be2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 08:55:07.2332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UUJu/P27UadBXCzO2RagKKAGnVSvFQwfk7MVu7AKzQRQ59a9DscVCinF285CqWiNvjthTfJrCMGg1hEKzGNdoaVHQyW98qE/UGVl5DA21k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8389
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mga03.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TZW50OiBUdWVzZGF5LCBKdW5lIDIwLCAyMDIzIDQ6
MjMgUE0NCj5UbzogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+OyBB
dmloYWkgSG9yb24NCj48YXZpaGFpaEBudmlkaWEuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3Jn
DQo+Q2M6IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyBjbGdAcmVkaGF0LmNvbTsgUGVuZywg
Q2hhbyBQDQo+PGNoYW8ucC5wZW5nQGludGVsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYy
XSB2ZmlvL21pZ3JhdGlvbjogUmVmYWN0b3IgYW5kIGZpeCBwcmludCBvZiAiTWlncmF0aW9uDQo+
ZGlzYWJsZWQiDQo+DQo+T24gMjAvMDYvMjAyMyAwNDowNCwgRHVhbiwgWmhlbnpob25nIHdyb3Rl
Og0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogQXZpaGFpIEhvcm9u
IDxhdmloYWloQG52aWRpYS5jb20+DQo+Pj4gU2VudDogTW9uZGF5LCBKdW5lIDE5LCAyMDIzIDc6
MTQgUE0NCj4+IC4uLg0KPj4+PiBhL2h3L3ZmaW8vbWlncmF0aW9uLmMgYi9ody92ZmlvL21pZ3Jh
dGlvbi5jIGluZGV4DQo+Pj4+IDZiNThkZGRiODg1OS4uYmM1MWFhNzY1Y2I4IDEwMDY0NA0KPj4+
PiAtLS0gYS9ody92ZmlvL21pZ3JhdGlvbi5jDQo+Pj4+ICsrKyBiL2h3L3ZmaW8vbWlncmF0aW9u
LmMNCj4+Pj4gQEAgLTYzMiw0MiArNjMyLDQxIEBAIGludDY0X3QgdmZpb19taWdfYnl0ZXNfdHJh
bnNmZXJyZWQodm9pZCkNCj4+Pj4gICAgICAgcmV0dXJuIGJ5dGVzX3RyYW5zZmVycmVkOw0KPj4+
PiAgIH0NCj4+Pj4NCj4+Pj4gLWludCB2ZmlvX21pZ3JhdGlvbl9yZWFsaXplKFZGSU9EZXZpY2Ug
KnZiYXNlZGV2LCBFcnJvciAqKmVycnApDQo+Pj4+ICtib29sIHZmaW9fbWlncmF0aW9uX3JlYWxp
emUoVkZJT0RldmljZSAqdmJhc2VkZXYsIEVycm9yICoqZXJycCkNCj4+Pj4gICB7DQo+Pj4+IC0g
ICAgaW50IHJldCA9IC1FTk9UU1VQOw0KPj4+PiArICAgIGludCByZXQ7DQo+Pj4+DQo+Pj4+IC0g
ICAgaWYgKCF2YmFzZWRldi0+ZW5hYmxlX21pZ3JhdGlvbikgew0KPj4+PiArICAgIGlmICghdmJh
c2VkZXYtPmVuYWJsZV9taWdyYXRpb24gfHwgdmZpb19taWdyYXRpb25faW5pdCh2YmFzZWRldikp
IHsNCj4+Pj4gKyAgICAgICAgZXJyb3Jfc2V0ZygmdmJhc2VkZXYtPm1pZ3JhdGlvbl9ibG9ja2Vy
LA0KPj4+PiArICAgICAgICAgICAgICAgICAgICJWRklPIGRldmljZSBkb2Vzbid0IHN1cHBvcnQg
bWlncmF0aW9uIik7DQo+Pj4+ICAgICAgICAgICBnb3RvIGFkZF9ibG9ja2VyOw0KPj4+PiAgICAg
ICB9DQo+Pj4+DQo+Pj4+IC0gICAgcmV0ID0gdmZpb19taWdyYXRpb25faW5pdCh2YmFzZWRldik7
DQo+Pj4+IC0gICAgaWYgKHJldCkgew0KPj4+PiArICAgIGlmICh2ZmlvX2Jsb2NrX211bHRpcGxl
X2RldmljZXNfbWlncmF0aW9uKGVycnApKSB7DQo+Pj4+ICsgICAgICAgIGVycm9yX3NldGcoJnZi
YXNlZGV2LT5taWdyYXRpb25fYmxvY2tlciwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAiTWln
cmF0aW9uIGlzIGN1cnJlbnRseSBub3Qgc3VwcG9ydGVkIHdpdGggbXVsdGlwbGUgIg0KPj4+PiAr
ICAgICAgICAgICAgICAgICAgICJWRklPIGRldmljZXMiKTsNCj4+Pj4gICAgICAgICAgIGdvdG8g
YWRkX2Jsb2NrZXI7DQo+Pj4+ICAgICAgIH0NCj4+Pg0KPj4+IEhlcmUgeW91IGFyZSB0eWluZyB0
aGUgbXVsdGlwbGUgZGV2aWNlcyBibG9ja2VyIHRvIGEgc3BlY2lmaWMgZGV2aWNlLg0KPj4+IFRo
aXMgY291bGQgYmUgcHJvYmxlbWF0aWM6DQo+Pj4gSWYgeW91IGFkZCB2ZmlvIGRldmljZSAjMSBh
bmQgdGhlbiBkZXZpY2UgIzIgdGhlbiB0aGUgYmxvY2tlciB3aWxsIGJlDQo+Pj4gYWRkZWQgdG8g
ZGV2aWNlICMyLiBJZiB5b3UgdGhlbiByZW1vdmUgZGV2aWNlICMxLCBtaWdyYXRpb24gd2lsbA0K
Pj4+IHN0aWxsIGJlIGJsb2NrZWQgYWx0aG91Z2ggaXQgc2hvdWxkbid0Lg0KPj4+DQo+Pj4gSSB0
aGluayB3ZSBzaG91bGQga2VlcCBpdCBhcyBhIGdsb2JhbCBibG9ja2VyIGFuZCBub3QgYSBwZXIt
ZGV2aWNlIGJsb2NrZXIuDQo+Pg0KPj4gVGhhbmtzIGZvciBwb2ludCBvdXQsIHlvdSBhcmUgcmln
aHQsIHNlZW1zIEkgbmVlZCB0byByZXN0b3JlIHRoZSBtdWx0aXBsZQ0KPmRldmljZXMgcGFydCBj
b2RlLg0KPg0KPkl0J3MgdGhlIHNhbWUgZm9yIHZJT01NVSBtaWdyYXRpb24gYmxvY2tlci4gWW91
IGNvdWxkIGhhdmUgYSBtYWNoaW5lIHdpdGgNCj5kZWZhdWx0X2J1c19ieXBhc3NfaW9tbXU9b24g
YW5kIGFkZCBkZXZpY2UgIzEgd2l0aCBieXBhc3NfaW9tbXU9b2ZmDQo+YXR0cmlidXRlIGluIHB4
YiBQQ0kgcG9ydCwgYW5kIHRoZW4gYWRkIGRldmljZSAjMiB3aXRoIGJ5cGFzc19pb21tdT1vbi4g
VGhlDQo+YmxvY2tlciBpcyBhZGRlZCBiZWNhdXNlIG9mIGRldmljZSAjMSBidXQgdGhlbiBpdCB3
aWxsIHJlbWFpbiBibG9ja2VkIGlmIHlvdQ0KPnJlbW92ZSBpdC4NCg0KUmlnaHQsIHRoYW5rcyBm
b3IgcG9pbnQgb3V0LCBJJ20gdGhpbmtpbmcgYWJvdXQgY2hhbmdpbmcgdmZpb192aW9tbXVfcHJl
c2V0KCkNCnRvIGNoZWNrIGNvcnJlc3BvbmRpbmcgZGV2aWNlJ3MgYWRkcmVzcyBzcGFjZSByYXRo
ZXIgdGhhbiBhbGwgdmZpbyBkZXZpY2VzJy4NCg0KTGV0IG1lIGtub3cgaWYgeW91IHByZWZlciB0
byByZXN0b3JlIHZJT01NVSBibG9ja2VyIGFzIGdsb2JhbCB0b28sIHRoZW4gSSdsbCBub3QNCnRy
eSB3aXRoIG15IGlkZWEgZnVydGhlcmx5Lg0KDQpSZWdhcmRzDQpaaGVuemhvbmcNCg==

