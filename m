Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CACF7DC46C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 03:29:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxeU9-0001WK-2o; Mon, 30 Oct 2023 22:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxeTz-0001Vy-Ey; Mon, 30 Oct 2023 22:27:55 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxeTu-0004iy-MX; Mon, 30 Oct 2023 22:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698719270; x=1730255270;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QfTfAFmR2E2s57cSoMrQdyMvI7ovGPsQXeamz4sqEKM=;
 b=iLRq7zRSAoBZKSNqh/Xk2R+1GVOtxg8/jyfq9HN1ZKMz81uTtQc609sT
 PrwJNOF4dzHbSpipKcHuyfCd7VnurXKYtYUMQbkL2su0aonaug5lJKfzv
 N6Wo+6ms9ciZujVLFX6Lgp0ZFlrr+A8PpWvBv3PoqxdxH1LL1Z0Pw3W67
 rTEYJMJc6Tuhr5suu30emRgKgGVQE1eO0wxVijGFVUhgmSAgRLJczLJqF
 uhKUVZHHotXd+SWVsVGkx26QRYRBYk8aKExD4vBlhQJkfwHxCINySaBpH
 Hi5QLNTInmAwWqQG8t/9MVstWczuuRvjEE9Z7R+POzRaXMwxqzAZLfHOZ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="387080159"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; d="scan'208";a="387080159"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2023 19:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="795423961"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; d="scan'208";a="795423961"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Oct 2023 19:27:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 19:27:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 19:27:06 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 19:27:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFnMVWG8O8uvBYonbz5BwH2Td5UetooqF9AOAbIs73cBqeOXP2ABppVQSxOB78utsrSNLXBeKRr9iyIlmSTARwk1neeI0ThjpwUdkYC+aKjfOqcYt/sZXzQCosybBFtg91KU0x+FrTaY0jxatHINN55ETDbBvX+iV4GtuEHHzFXokh+Q3d81oTGXSixD5FRdU6z2UDqUFHXYsrup4y3Mo6dCnLw4CjSz4vSebmm2YnmzICe1iZfrizE9banPzsZE535ikjLZ8FFcDtf+RjAmKq3CPCav1rpITHckdmEroMe+Ozhs5fvof21Px7JHoy1HSFvfK0rT6QYC74lNlMsJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfTfAFmR2E2s57cSoMrQdyMvI7ovGPsQXeamz4sqEKM=;
 b=UW8a+uPlUnQtn07hyUskf0EomV6G6g5WKByHtAifDj233advnMXkbuTt01X4gqHRQiH+MQXwop5GYJSj1J9BFJ9BzEEeCA/rFdRjEsOoXZ95bbuE4ldsqZXNY+Wgrtt4HYQrAouL2h0p25/EP3nTejDg4+YyBU79jDP/qrwa1J1FYMgNYhpagS9YysNzlCOBhBkfMnv3H0v38Ye3TaNA070kVGTNlm9HZyybDmef76Yj740AEby35nVbKpBmRz7zLIcksnKWyFpb/j+W6uKu85OtnXSyu7S44OZHI+TluhfITNHc6PrX1D7pDSQ75bo88rM4t5GksVN47EuQhL2bDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB6611.namprd11.prod.outlook.com (2603:10b6:510:1ce::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 31 Oct
 2023 02:26:57 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 02:26:57 +0000
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
Thread-Index: AQHaB/ntBhpb6AfL90mwX2uJD9PvDbBiYd+AgADMpHA=
Date: Tue, 31 Oct 2023 02:26:57 +0000
Message-ID: <SJ0PR11MB67448F476F129A500E2F623D92A0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-30-zhenzhong.duan@intel.com>
 <9e5a2eaf-4703-4797-8305-05baee9d7de4@redhat.com>
In-Reply-To: <9e5a2eaf-4703-4797-8305-05baee9d7de4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB6611:EE_
x-ms-office365-filtering-correlation-id: a07c442e-6354-4d64-c9c8-08dbd9b8dadd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HY5IkB5UH/3x1qlQ5suFW+iCYdEkAu+iI1+LKCT3FdVzmht3UKK+ZQIwrMbH7vNEK5KH6hw2PXMeSxIVI/wYD1/IgZBKV5ChgIRV6ceBN7VdvkrK3WBw4ZguVUVNvRzvkE8ARZ+zM3WuAFkRSCe3hdEPzmu/EaXJqXv3OY0kBkxjPIh27egk0fUhSme86bOHEJZf77uNv4I0FoEAnXkmW6y0+S9E+eK9Rbb09NuFW9g/zkyBPwGQGUm2j6snteO2YFC4g6GXr+LARc5khTyWvjAN2KL+FFDXdDn8jW+atW4CvoXT1Jzucry3wAj46KkodMeuq+RHQCzJVCY3V7kPxhBj/on8N2Hy7mRfKB8FP712WPgCYJdaJc0nHeGw/xOkHseCSVKce+0ljwYX3oMsIADwqbKvoDTJ7jT8fi7bG0ufCE3qZE7L8suoASDWWZxVZDfUPo0tst+2Ui20maG0k1NiMh2jvQJQc2EVsG4HSipolmdkKdK2N/DcineI4ULRuJfXBs9dwnd5nUdEchWOZ/TaVwhQpO26z87sGLle6HcEmDHFzD+RltwLJ1c9UnfdCrjZKxRGLMW1OtCkQ7IcHP1qf9QwMwzqB0P2Sgz2Qre1Tpw9fRInGaSaR9zsRiccZyHL9HWro8Hds+w+K5MO2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(122000001)(9686003)(71200400001)(7696005)(6506007)(82960400001)(110136005)(33656002)(26005)(66556008)(316002)(66476007)(54906003)(64756008)(478600001)(66446008)(55016003)(66946007)(83380400001)(38100700002)(76116006)(86362001)(8936002)(38070700009)(41300700001)(2906002)(8676002)(4326008)(52536014)(7416002)(5660300002)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTVaTHprQkdnWXpjU0VOOVRqYWRtM2RBWVpzVkRqMGtZckhUa3Rza2U3Nm1G?=
 =?utf-8?B?OTF4WGhHbDIzK0hMMXY0NW90RUphZGtYNkpkaS9kTU9VVU81bjdsM2JMY0xU?=
 =?utf-8?B?UG9jQWFGaVBvampRaWtuUEs5dGx3bis5WEliVDFHMkc4bFFFRy9uUmVYa29O?=
 =?utf-8?B?QkxZc1luc0I1ZjlFNnZJM3FwejQ0RUpRUWRpakJQaUpOZUdiQVNvdFJwZjl2?=
 =?utf-8?B?Q1FDVzQzeDlQUFdqczZYb1RlVWlpeFNNa0dManZOU2NXei9yTlJ5aVlobWN3?=
 =?utf-8?B?b0s1eFpiMkxmMHNmVWtUb2N2T0dSMXRGeEFrWE10MFJBOGduek5oRHFJUU5k?=
 =?utf-8?B?a09tYVp0bGFpTm10VzRDYko4UlhYTitibXBqOXZXVUU4MXErOXo2OTR6aHdo?=
 =?utf-8?B?TkpidUxYMElGZ1FNQWJhclBWVlljazl5ZUJ6d3M2cFZUSzlLbXVtVnZIWDAv?=
 =?utf-8?B?TTVmYm9UNDRkbjNqY0pjL2V0N2swWUJCR2dQcFViOXgwQ3dZTUFmTnJ2RWNV?=
 =?utf-8?B?YjFPdGVrK2ZpRHRYVG5qNmFQcUptUDBHbnRCaVR1Nyt2S1RteUswdWJwSnR2?=
 =?utf-8?B?YmpmVUpFZlhYcEFlS0oyYTVyVUZsMXZVbGRaTFpMckZqemxTUTRTd3g4cG9L?=
 =?utf-8?B?dWMyMk02dmZqSnhCSEs1NGpEcGlqT2xGTVZTR3B5MThzVjNpYkkvNkRHTDZR?=
 =?utf-8?B?ZVE1WG5vR2FFNG1XSWd6VzZNSlZKdnpyQVFyK0RJSkV5c2xiQU9CMjUxU0Fr?=
 =?utf-8?B?dzllN01jWjlYSWZucEEyYU81anpYYjB4ekxUUnVyYjdaRkhUUC9XaFR0Y2RO?=
 =?utf-8?B?eFpnbGZaQndMNEpDVzA1QklYbWtUQ3VFSWE4U0JKR1Y0RUphTHhEQUlZM3Ja?=
 =?utf-8?B?VHRtbnhiQ3AyS3llM1NnNXJ3a0JUR240WHVFaGJ2VlhpT1IzbEE0Nm9hcjly?=
 =?utf-8?B?bjB5RkhUSS8vWmcwYnlndnFxaWJOVnpFalZTSmtwcXdJa1VtcVM3Wi8xeWJD?=
 =?utf-8?B?bE9sYUdMYk5UWEJIKzd5d2FzWHMyR1ZkdXRrWTJBWnZ0K2ppd0F3NlNIMzJM?=
 =?utf-8?B?c0NIa3JOc1pSc1RFSWphTTY2c1hoOUpBTG16TUJMaXU1WkYrMEoySFhtWGxz?=
 =?utf-8?B?Q3lXOUVpVFd5SVZXZTFzdXdxK3U4R1E3USt0RVozeTFHTERBdFR5WlFOaHlJ?=
 =?utf-8?B?MnpQN3Fsd0V0bFp1WVdZZzNrbzlVMTVUamx4ZW1VUjhjbUZBWTZzYTZvdHVr?=
 =?utf-8?B?SC9kR3dqaUNKRDhBaXdRS0kzdkdHUFhmem5aNkpLL0diMHZEWDBHblVVankr?=
 =?utf-8?B?Y3ZzZkkyQkUwREhxR3Zvc3NBVnpvMGVvM2NZM1FCRDc4UU1Ld1ZQT2RLVU5m?=
 =?utf-8?B?b241OFRaYU1hVHIzMEFpdWxiVk5DOHVEWFRiUFBydkJGWTZOQnU2WEhYM2xC?=
 =?utf-8?B?TzQzWjFIWXdmT2QrWHhhNStSaGZ4aFBPVmVoSVN0NFcwek5remluUUx6NUF3?=
 =?utf-8?B?MDFhZDZUbXlpcDA5T1hOM2VtTjJMNEphODdNcDBrUnlEakJzK3ZCNVhvMjg3?=
 =?utf-8?B?NW13dmFYOW45ZHN6V0llUjhucjMwTDIzOXhhWjREdWcrdnhCbDhYN3Y1L2xz?=
 =?utf-8?B?Mi9HS1FlV2dEeWpNWWk4Y0ZCVUFPbFMya0dZRkZ2MjRWL2dhTi8yUU5hM2Ny?=
 =?utf-8?B?UDVDZVFmQW1pclluaXh6WVhzclV6R3dCRldGU3QvU2RlRnRRZHg1S3dwaHB5?=
 =?utf-8?B?YjJFWEVKcFI4WTNpN3FieWc5cEVmRFNiWndSQnV0OFVEZklFWW03c2VmRUtX?=
 =?utf-8?B?OG1TNWlmNmdkRFNzU2k4MTI1VkhhTkdRLzYzL0tQclNPSnVmY2I5aDVva1Bk?=
 =?utf-8?B?VFp1WHAyRE9KOTNCNHJSdXF0d29kZktwLzh2V0dEeFNKV0NiSS9pd2s5OE9W?=
 =?utf-8?B?OGl5eG5YZWx5MytJRGJqcDNWcG53M0k0M0NWZ0hLMGJXWm1XdWh6UEc4NkZq?=
 =?utf-8?B?YnBTdkp2MWRXVnJ6NkNsdnk4cHFncWxDMC9tRjlQN2JENWFQNjlYOFZpOWkx?=
 =?utf-8?B?Ulo3VWJ3dU0vWk9xVE5hU2J6TGplNEM4S1VVcVNGR3lXSzVwU3VscnVWeGJz?=
 =?utf-8?Q?IFXApECop1DUenJyXbaZivmlp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07c442e-6354-4d64-c9c8-08dbd9b8dadd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 02:26:57.1657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UK8w3gIT2itEFd1HWIUqqi6HXp75djkSdfNVuGUh8+OfStwvI7povMaqpz3WRtptzjiJ+4jEzFw1JdiQTX1ABhZHfRxPjxRLyPzW7YpIdgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6611
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBNb25kYXksIE9jdG9iZXIgMzAsIDIwMjMgOTo1NyBQ
TQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMjkvMzddIHZmaW8vaW9tbXVmZDogQnlwYXNzIEVF
SCBpZiBpb21tdWZkIGJhY2tlbmQNCj4NCj5PbiAxMC8yNi8yMyAxMjozMCwgWmhlbnpob25nIER1
YW4gd3JvdGU6DQo+PiBJQk0gRUVIIGlzIG9ubHkgc3VwcG9ydGVkIGJ5IGxlZ2FjeSBiYWNrZW5k
IGN1cnJlbnRseSwgYnlwYXNzIGl0DQo+PiBmb3IgSU9NTVVGRCBiYWNrZW5kLg0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+
PiAtLS0NCj4+ICAgaHcvcHBjL3NwYXByX3BjaV92ZmlvLmMgfCA0ICsrLS0NCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvaHcvcHBjL3NwYXByX3BjaV92ZmlvLmMgYi9ody9wcGMvc3BhcHJfcGNpX3ZmaW8uYw0K
Pj4gaW5kZXggZDFkMDdiZWM0Ni4uYTI1MTg4MzhhMSAxMDA2NDQNCj4+IC0tLSBhL2h3L3BwYy9z
cGFwcl9wY2lfdmZpby5jDQo+PiArKysgYi9ody9wcGMvc3BhcHJfcGNpX3ZmaW8uYw0KPj4gQEAg
LTkzLDEwICs5MywxMCBAQCBzdGF0aWMgVkZJT0NvbnRhaW5lcg0KPip2ZmlvX2VlaF9hc19jb250
YWluZXIoQWRkcmVzc1NwYWNlICphcykNCj4+DQo+PiAgICAgICBiY29udGFpbmVyID0gUUxJU1Rf
RklSU1QoJnNwYWNlLT5jb250YWluZXJzKTsNCj4+DQo+PiAtICAgIGlmIChRTElTVF9ORVhUKGJj
b250YWluZXIsIG5leHQpKSB7DQo+PiArICAgIGlmIChRTElTVF9ORVhUKGJjb250YWluZXIsIG5l
eHQpIHx8IGJjb250YWluZXItPm9wcyAhPSAmdmZpb19sZWdhY3lfb3BzKSB7DQo+DQo+SXQncyBj
dXJpb3VzIHRoYXQgYSB0ZXN0IG9uIHRoZSBWRklPSU9NTVVPcHMgaXMgbmVlZGVkIHNvIGRlZXAg
aW4NCj50aGUgc29mdHdhcmUgc3RhY2ssIGFuZCBzcGFwciBzaG91bGQgaGF2ZSBpdHMgb3duIFZG
SU9JT01NVU9wcywgd2hpY2gNCj5kZSBmYWN0byBkb2Vzbid0IHN1cHBvcnQgaW9tbXVmZC4NCg0K
WWVzLCBpbiB0aGlzIHNlcmllcywgc3BhcHIgc2hhcmVzIHNhbWUgb3BzIHZmaW9fbGVnYWN5X29w
cywgaW4gbmV4dCBzZXJpZXMgSSBzaG91bGQNCmNoZWNrIHdpdGggdmZpb19pb21tdV9zcGFwcl9v
cHMuDQoNClRoZSBnZW5lcmFsIHZmaW8tcGNpIGRldmljZSBzdXBwb3J0cyBpb21tdSBwcm9wZXJ0
eSwgaWYgd2UgcGFzcyBhIHZmaW8gZGV2aWNlDQp3aXRoIGlvbW11ZmQgYmFja2VuZCwgSSBndWVz
cyB3ZSB3aWxsIGNyYXNoIFFlbXUgaWYgdGhlcmUgaXMgbm8gY2hlY2sgaGVyZS4NCg0KVGhhbmtz
DQpaaGVuemhvbmcNCg0K

