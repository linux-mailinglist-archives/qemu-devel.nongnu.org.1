Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6017DC926
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:10:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkht-0004wv-Dh; Tue, 31 Oct 2023 05:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxkhr-0004wC-3M; Tue, 31 Oct 2023 05:06:39 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxkhn-0007w7-Sl; Tue, 31 Oct 2023 05:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698743195; x=1730279195;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=t/1ezQ+Nb30WQeCHk5M1ISOx8+eAs99GIUBsxod7VHA=;
 b=BD4lnWKK7nl5SBmzBOmkeo5lkFaDSavAesUlNxVIr9kcExlb0UUFBAHr
 y2RKTKW0W3LLrEQRfbmMKTIQwiMhS3lw8HS+kvG/gqDifOHa6QEp6TWJ5
 8J0l6vR8NhOSacomPrQsTmc7imiNFG9eQdg853/tmREqMMq+sgJHsrlh/
 oujYo+3XWxMAVh/pmN0mgHnnx8d+pGo2mT589UJ1LkQbF84laM31d3OKO
 jYh9x0Aavib4gQ5y7IYpui30jPcd4tDs8bmil/NfFuo1z1fX+Jnuzyp17
 UpU5iOi+hLk5Vpa8wjiHhBZ126l1i/6nBBimHaUWoTEd0dLH5g7bOufYN g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="388064298"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; d="scan'208";a="388064298"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2023 02:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="754072722"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; d="scan'208";a="754072722"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 31 Oct 2023 02:06:32 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 02:06:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 02:06:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 02:06:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 02:06:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7qUPbBcXQ8KSUvESrKDFu7EWpBW+aftYib0ogDMHKHmV1wtPWqDezX9JivYO4HvopQlQrjP/pgjkEoj0lC/oliATydnMXhsuznEnzFWTEwf9Z91QQkTrQNClZmVKEyAN5cW1pmqKU/sm1v2RGJvx0S3kOv79+j8Mm8SiZ11U5TuU2pA9qR2RiGgHbSu+tTroi1PpdT3IS7eiTUXWWFgkg68jttseeN8753np/Jo+qEl5WDPjsDrPb7ToO8i8m4LUCLvjsWxiHe+xnUMzHicvG0PFxhQ4IOTB6N4AQtUJOuToRLY/7uzFunYdqE2nq9LfSzQHhpk7hV9mgH9cVNG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/1ezQ+Nb30WQeCHk5M1ISOx8+eAs99GIUBsxod7VHA=;
 b=mOavkodgJCCMRAZj/se311mYi9MTuAej3CV7AgQzMGzdU3Q0bqSJOzyhXv7QWK7RGnUe+KrwsA8wLWVFLjskBPBUCyd9FQQj/8Wnq4jRmW9LFUY7sQvieT/Dm4blvS1Hn6Uskk+ZaMC5cKFzYKml3pLv9LZq28FpC18okoFkGBMAc4CNe7jhd7OE7unqFIT5MeHf+Q8zR/ZmzBU0qyoxvX4yQln0YDQa1y/7NrdTlxueri2ouqt2gFdnG9i5cjSspmNE4lOKPX22+B6l8M/+XuOGo1FA7lCaY3FqHPq9c8nGEd0fVAAluVyizB+ip3ClnklmU5hfzZhLrqmWJFYyPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB6991.namprd11.prod.outlook.com (2603:10b6:806:2b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Tue, 31 Oct
 2023 09:06:29 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 09:06:29 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Nicholas Piggin
 <npiggin@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
Subject: RE: [PATCH v3 29/37] vfio/iommufd: Bypass EEH if iommufd backend
Thread-Topic: [PATCH v3 29/37] vfio/iommufd: Bypass EEH if iommufd backend
Thread-Index: AQHaB/ntBhpb6AfL90mwX2uJD9PvDbBiYd+AgADMpHCAAHMtgIAAAMxw
Date: Tue, 31 Oct 2023 09:06:28 +0000
Message-ID: <SJ0PR11MB67441B36DF3C4A5F52DA23E492A0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-30-zhenzhong.duan@intel.com>
 <9e5a2eaf-4703-4797-8305-05baee9d7de4@redhat.com>
 <SJ0PR11MB67448F476F129A500E2F623D92A0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <183a9b3f-bc01-4feb-8663-f3777de62288@redhat.com>
In-Reply-To: <183a9b3f-bc01-4feb-8663-f3777de62288@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB6991:EE_
x-ms-office365-filtering-correlation-id: f712a87d-d233-4982-13c6-08dbd9f0ab2d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X0odTRAIcDG/rhqjmVz01yg8+F4WsoSDlO1vpzvCuptN7rHe1CX8ROlH7d5moyxApKVKJGTzb61RgrAqWtauuZ+rZ69huEjgGkDUBo0GV2zulFL71D4NWfOsisE2nvgR6NsTmpUQi8gADErTZQ1DpvQc9qseyfYp9rGnvTWpxdGy8V2c4NFvzhV9k66IewsaozWF6lJ8lyqqCSkhz0zIm+iZ0oGYEKLP1ZxIt85BXr655zrV5jlzp/yad7eqs3Cmh8LgRLoEv2jqBjjdJK/wwVkvs0iQV4oOorbuuXIVrObSmymWFs/lW/9mWhmFQPyQ40UsYRiBxtnBK5LhrzoU6m1jtQQXitoBzyjrDGT73vX0JlTMKQTsbKjkbRPO4Q7JlA19EHMwAA3h4HGR9Jt+nFU/3m6dWqwrEB8FjgGwg/m5kBeP8eQoUIGTlGs+DABQYX7kJUR1tisVQnI+S5n/wfW/USoQUFc69ZffxEt5dB4OYZ0G0C8HcuUdp6Z30S2j4IdOlh82V5gnDQIpGhUJBUFqsEPLJgKNIt/dpMbt8RTkpHVysfOIWyiHV0d2HGy3i2kf+1bvFasehb+SQsi0pl2tleX1RgqfMVUbgQD+lUniWGu+qqUJ+yVeVZ3WjGz5AMHsot1HlW7VU+c2+5teDQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(33656002)(8676002)(66446008)(66574015)(122000001)(71200400001)(66556008)(83380400001)(316002)(64756008)(7696005)(66946007)(26005)(41300700001)(53546011)(8936002)(5660300002)(9686003)(2906002)(7416002)(478600001)(52536014)(66476007)(4326008)(110136005)(54906003)(76116006)(82960400001)(38100700002)(6506007)(86362001)(38070700009)(55016003)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDhJMjJHYWZ1NW5HYlFTV1ArMFpoNEo1RWlUODlMaXBVVFYraUtaMEcwbzgx?=
 =?utf-8?B?bWl4VVI1aTkvZlEwSlBGNFVHWi8raUNKaGhTTW95RzJqRGVhUFoza0UvUW5T?=
 =?utf-8?B?VmVDRmErdW41cGRzVHllMVEwTEd2eU15QUxKU1JyZ0NoZ0U3ZHdBRlBGaHlt?=
 =?utf-8?B?Unh3MWtJMTU4TEZhdHFJeWZCUFg5cGRkTDkySFBTdGJRaDhIQjM5OXVVR2Rw?=
 =?utf-8?B?MkhnV0FNL0ZHUWNYZWpkQVFtdDZmSncyVG9zaThDby9rY1dpRjFCSnlsOHpV?=
 =?utf-8?B?UUJPWDdtc3ZHU2dVWmtnTFNWQ0s2QTRjUytvMUVSK21uWE9sV2ZiZzdtSW52?=
 =?utf-8?B?U0NENGdZS2dxRVBlUTMvRnNGak9uRVV1Z0haaUc3cENrMExLUkxKYk5vMGhu?=
 =?utf-8?B?THdQcDRSTkJMMGhVZDlFZVdvUk5mZjYvOE5LMzVQaFlkOEhFY1RmeFI5R1lY?=
 =?utf-8?B?cm1UbzczLzhBYXQ5ckN2V1JPWnh5TmxoUmF2a1k0UGU3UGVYa05NSVFKS1Bv?=
 =?utf-8?B?UiszMFE5WHY5OE4ybnFLMzdIZGxzTUMxcWZtby80TEQ3WFNIL242N0Y0Q0hw?=
 =?utf-8?B?elhOczQrcVJGUGNZWE1kNkgxSVg0WFFoc2dPc09RWnIwRFcxVnA5cjMzOWMr?=
 =?utf-8?B?RjlSSWxiVE1pZmowQTdYaGdzVEJVb2ZxNTFTbWFlWVhZeUh1MWNuQ29ES3d2?=
 =?utf-8?B?NmRGVWF2TnVsYkwzOXFBdERjNlFGM1ZVcTVvamc2UGtMSnNTeWdDOXRwa3pP?=
 =?utf-8?B?YXpnZEt2V2FGZkYranJZM3YwZHF2ekMwdWRBQ0tzU3NtUmFZa1Z2TzdEUmRk?=
 =?utf-8?B?TVp3RW1wdHVkU216NnAxWEE4YzlQcE41NTl5N2tOWGU1KzJlUGZpMkJ3dW1O?=
 =?utf-8?B?djB5c2haekY0TmVNcy9hZXk3aG5abFBHNVN1a3NNTHpiZ0QrZjJ1OCtRY3VY?=
 =?utf-8?B?QzMzSUdjeGZUOVV0Y0I5QzF4ZlVyYzUvSW13OXh1eHllcWdpUlViWk4rOUho?=
 =?utf-8?B?bElJdjN3eFFKMzBmZ3JzRStKRFdySlNVS2drL3ZLVW01QWFvek1EVzFyQno4?=
 =?utf-8?B?cnhzMHROTXdQMmc0MERrN25ZYUNHd252bUxlZlh0QTJYQjRBWW1CanUvamNi?=
 =?utf-8?B?UnB5cFRodXNacVRYWlovNGRNRlVkc0N4UzFhdTE1bERZTS9pY21GNU41bmMw?=
 =?utf-8?B?YkxNaExyTzBMei9MeTJEclZwLzRHK1VBZXZNNXVXV1cyQ1NxcVRHRVM4UG5r?=
 =?utf-8?B?WlZ3T0twWkxqU1EwZ1NwaHdWTnM3NDYxdzRXbVlNMFZSK09TN1NUb1JudzRD?=
 =?utf-8?B?SmZITmtTOTVudm90anRXaUVrODd0K3prUzhCUzFTdG1CYXpuRTBFcUZXSmpw?=
 =?utf-8?B?ak9oUkxQQXZuK09mZzN0T1Z0UWh4eXNxWXZVTEM1ajVvVmNranZuTEh1NlhB?=
 =?utf-8?B?azV5enN0WkE2bmdEM3VGV0tKZFpTcWl6WDdWTGtFczcvZXAvUWFUN3U3WFov?=
 =?utf-8?B?M0NkZldiSHJhVnBYNTRGcFNKMitIbmc2RWtaUGkvZEJkbzdGa3NNbEVpRy9z?=
 =?utf-8?B?eHU3eE80MlRkendId0F2cTFlV1d0Z1U3ME8wVjNVWWNVYzFTSnBoN1RuNEVx?=
 =?utf-8?B?cUN2OWZmVlk1R05LU3AwdlVXTWZOMWlhZ1hXNXJXU05CcTJrSS80UzA2c3hP?=
 =?utf-8?B?TmdOeDdocFRHQVZ3SFdaWHcwYW9JVUVQWnhUdzdSZ0ZLcXlhRXpGRzVJUFRC?=
 =?utf-8?B?c2RmYlozL2hKMU92TGtCa2ZKSEtZcnJRL2J6T3lueXRwV0YzTmFnYTZ2dXlZ?=
 =?utf-8?B?TEhqMzY0NlNHcTgyWFA2R1lkdTBvZFBVeVlCVUE4VnVrMkR1WmFUMGdEL0pF?=
 =?utf-8?B?a3dvWVl0Tll2M0NZWFVJUyt4TytHdXcxTjU3ZGI2RVdMbFRIWjFhMVFwbEsx?=
 =?utf-8?B?WlJqQ3NLMlhMME4wMWp2ZEhhN3F1TE02eDBDR0JhU1p2Y0xDbCtPZGU1ejA3?=
 =?utf-8?B?QUU1ZkdKZGtiSUxPbE5Calk5UVEvL3JCWjVQUkRZVnpLMHhMa3NGVlRPeUxV?=
 =?utf-8?B?S3d6SVJKeWdXVXJaSE05MnpVV0VuYm9zOEpRckFjUUE5SW5zMVpLMyt1eVVP?=
 =?utf-8?Q?yY9TbSPLbpmd2Te05dJg4arnC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f712a87d-d233-4982-13c6-08dbd9f0ab2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 09:06:28.9861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2YRlBjsue5T3gdCEOfaY9HxJjltsdSzubTNwn2f7KF6sSAMItSlkR5L409h8jDI1wLMdeTbf48wvF1JAd9m/mTRhS/YJXz+pdhZK0Hx/q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6991
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBPY3RvYmVyIDMxLCAyMDIzIDU6MDEg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDI5LzM3XSB2ZmlvL2lvbW11ZmQ6IEJ5cGFzcyBF
RUggaWYgaW9tbXVmZCBiYWNrZW5kDQo+DQo+T24gMTAvMzEvMjMgMDM6MjYsIER1YW4sIFpoZW56
aG9uZyB3cm90ZToNCj4+DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4g
RnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+IFNlbnQ6IE1vbmRh
eSwgT2N0b2JlciAzMCwgMjAyMyA5OjU3IFBNDQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAy
OS8zN10gdmZpby9pb21tdWZkOiBCeXBhc3MgRUVIIGlmIGlvbW11ZmQgYmFja2VuZA0KPj4+DQo+
Pj4gT24gMTAvMjYvMjMgMTI6MzAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+PiBJQk0gRUVI
IGlzIG9ubHkgc3VwcG9ydGVkIGJ5IGxlZ2FjeSBiYWNrZW5kIGN1cnJlbnRseSwgYnlwYXNzIGl0
DQo+Pj4+IGZvciBJT01NVUZEIGJhY2tlbmQuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFpo
ZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAg
ICBody9wcGMvc3BhcHJfcGNpX3ZmaW8uYyB8IDQgKystLQ0KPj4+PiAgICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0
IGEvaHcvcHBjL3NwYXByX3BjaV92ZmlvLmMgYi9ody9wcGMvc3BhcHJfcGNpX3ZmaW8uYw0KPj4+
PiBpbmRleCBkMWQwN2JlYzQ2Li5hMjUxODgzOGExIDEwMDY0NA0KPj4+PiAtLS0gYS9ody9wcGMv
c3BhcHJfcGNpX3ZmaW8uYw0KPj4+PiArKysgYi9ody9wcGMvc3BhcHJfcGNpX3ZmaW8uYw0KPj4+
PiBAQCAtOTMsMTAgKzkzLDEwIEBAIHN0YXRpYyBWRklPQ29udGFpbmVyDQo+Pj4gKnZmaW9fZWVo
X2FzX2NvbnRhaW5lcihBZGRyZXNzU3BhY2UgKmFzKQ0KPj4+Pg0KPj4+PiAgICAgICAgYmNvbnRh
aW5lciA9IFFMSVNUX0ZJUlNUKCZzcGFjZS0+Y29udGFpbmVycyk7DQo+Pj4+DQo+Pj4+IC0gICAg
aWYgKFFMSVNUX05FWFQoYmNvbnRhaW5lciwgbmV4dCkpIHsNCj4+Pj4gKyAgICBpZiAoUUxJU1Rf
TkVYVChiY29udGFpbmVyLCBuZXh0KSB8fCBiY29udGFpbmVyLT5vcHMgIT0gJnZmaW9fbGVnYWN5
X29wcykNCj57DQo+Pj4NCj4+PiBJdCdzIGN1cmlvdXMgdGhhdCBhIHRlc3Qgb24gdGhlIFZGSU9J
T01NVU9wcyBpcyBuZWVkZWQgc28gZGVlcCBpbg0KPj4+IHRoZSBzb2Z0d2FyZSBzdGFjaywgYW5k
IHNwYXByIHNob3VsZCBoYXZlIGl0cyBvd24gVkZJT0lPTU1VT3BzLCB3aGljaA0KPj4+IGRlIGZh
Y3RvIGRvZXNuJ3Qgc3VwcG9ydCBpb21tdWZkLg0KPj4NCj4+IFllcywgaW4gdGhpcyBzZXJpZXMs
IHNwYXByIHNoYXJlcyBzYW1lIG9wcyB2ZmlvX2xlZ2FjeV9vcHMsIGluIG5leHQgc2VyaWVzIEkN
Cj5zaG91bGQNCj4+IGNoZWNrIHdpdGggdmZpb19pb21tdV9zcGFwcl9vcHMuDQo+DQo+V2VsbCwg
c2luY2UgUFBDIGRvZXNuJ3Qgc3VwcG9ydCBJT01NVUZEIGl0IHNob3VsZCBiZSB0ZXN0ZWQgYmVm
b3JlIG9yIGNvbXBpbGUNCj5vdXQgYXMgc3VnZ2VzdGVkIG9uIHBhdGNoIDIzICJBZGQgaW9tbXVm
ZCBjb25maWd1cmUgb3B0aW9uIg0KDQpHb3QgaXQsIEknbGwgZGlzYWJsZWQgaXQgZm9yIFBQQyBh
cyB5b3Ugc3VnZ2VzdGVkLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+VGhhbmtzLA0KPg0K
PkMuDQo+DQo+DQo+PiBUaGUgZ2VuZXJhbCB2ZmlvLXBjaSBkZXZpY2Ugc3VwcG9ydHMgaW9tbXUg
cHJvcGVydHksIGlmIHdlIHBhc3MgYSB2ZmlvIGRldmljZQ0KPj4gd2l0aCBpb21tdWZkIGJhY2tl
bmQsIEkgZ3Vlc3Mgd2Ugd2lsbCBjcmFzaCBRZW11IGlmIHRoZXJlIGlzIG5vIGNoZWNrIGhlcmUu
DQo+Pg0KPj4gVGhhbmtzDQo+PiBaaGVuemhvbmcNCj4+DQoNCg==

