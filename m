Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D4A7AACE0
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 10:39:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjbgu-0007iM-Uc; Fri, 22 Sep 2023 04:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjbgt-0007i6-5v
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 04:39:11 -0400
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjbgq-0000i2-EY
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 04:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695371948; x=1726907948;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ofRok9jobfq/wQEvONYXBWGaBJykHyyexT0h3+84F68=;
 b=DlTZ1PaYwoqf5/cKNf5OSMQpaVmNmyuHp3H+MyeDPGIvYnKJA3UnWmI/
 n0n24WJW/sVZdbCJ4KiqHAPlHwWLfUFjF/LOm1IUQeLkQRAHzmzf/DFST
 mwK+5bzW0IMQ9ZEFEFJO82O+A9o7qEoQRowPuCWhqkg9dX4mIoRu03t/G
 rH4564C+lUZQQa4XwNY8zLaNK3kIf6aDbYM2VyF4RbcAlURIpL1+CA3vC
 rAInXAdzrb588hjASbRV5+c9FGlNEzVkG0pCDkgJF90KFtxdsnWxuAHoc
 f3WKfvgNTKFHD/97f5c5BJrT5nxRdwILFO1xMMzJHjd/Mqh1Ns9XzsJJW Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="371099667"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; d="scan'208";a="371099667"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2023 01:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="697088480"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; d="scan'208";a="697088480"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Sep 2023 01:39:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 01:39:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 01:39:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 01:39:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsD4WyvARUjAN/wsVOHoX5fmfZyQMVWuTzfw22mBqFHAWyAV/ZvoP1pcDNd7XhmYDqW91xjfVg79SLwZvmlDV3rJ4lOt+20Z+KjrxpECamuNPoh6hP3U9fxWZMVqx888ENdbSTc+brbywrjg70oOH5piFriYGq6hGd4cykS3tD+UF7uV1SsgwYQ6wHhbXIrMVjDlzCNs29oEywkx18EHhhopT4BcIsnbn2GPZKZ3rsvGEOpOHec4xJgWIBKufSMTMDM5OI/2hJkhh4+tiVRnmOm4SHC1Gy/gkgGVX+nAFJUbiTq3WK4LTs0bJ7wNBcOvDPH/VSfQU/KtNJEkx7cjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofRok9jobfq/wQEvONYXBWGaBJykHyyexT0h3+84F68=;
 b=bYtZPcsiZ0j7pfn2xfxnjJO3I5aXQRvViuBf+KilTsa08OZYt5Xqq7u4/SzASlWgig4DUQM2udZrGdxgwNnNWBCM1EGMVL1WauTlDghApEO2wwxEnaeWpHqZFjLUZ0QV9RwIOoCJnNHvsDfa8S/mhQjEpCz61sWoNM6YSdgg5dq8R1K9GTuxrUeHISV0PzTnoMTq5SmWn3Vrr0YOnqQ54asKVkulSwjvvzz9HZ5fuVDoUXfTh2t8SnVnGS6GTt3xW4b6yDqQ7/4FleIDd2yxi1N8QhwmeEFRc9C2bm5vf4LsnHk7xl3bXmcaq1TsrvOcF3mO576FTIj89+n0Eq/7zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB6372.namprd11.prod.outlook.com (2603:10b6:208:3ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Fri, 22 Sep
 2023 08:39:01 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 08:39:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v1 16/22] backends/iommufd: Introduce the iommufd object
Thread-Topic: [PATCH v1 16/22] backends/iommufd: Introduce the iommufd object
Thread-Index: AQHZ2zBFSfkInimiOESc0RnCXG8zP7Amks4AgAAWv0A=
Date: Fri, 22 Sep 2023 08:39:01 +0000
Message-ID: <SJ0PR11MB67444FF282F686C55D5363D192FFA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-17-zhenzhong.duan@intel.com>
 <9c13451c-6e6d-a405-1c3c-a67bb7c6caf3@redhat.com>
In-Reply-To: <9c13451c-6e6d-a405-1c3c-a67bb7c6caf3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB6372:EE_
x-ms-office365-filtering-correlation-id: a9eccf2d-9fee-477e-ffa0-08dbbb475f29
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HSDw9nR8fbGZZgMWAdAVzSu8MeauYVO491FX+SbSTJn6lPn+LFQ2fES/SyhA13mbCTE3Qs57kmviZZ5xDL5DArUCeyak832/SeLbe804udwn54ssHZo7QTmniVIe/qgnhh7j+aQf2o/dlKtNEDtDp0k++6fDepkgcRJ2z1hY4HOiBL5d0tJ+TCu+4l+nyw2cyD1Fr+M6BsWfp9G7Dma83hkc+KPsrUZGNnXfN54NFvhISUFSLyWJeaj+WoeN84xSghWhnEZvd23gIqr6Fk3OLknaaU5RVtGWLKWOnrOIcXr3lGSKPbhwFDK+zeeU9hAOWpMjyf2kOvm48NTBJGiBQADwaR4XXxoaTJbPnOnaNtRn3aJEgrgALyYD7rm/hotHq+F/cJAbwrVA4fVdY9B4RUS9uit5P6DenkHn93P+OiL/qLIcwNgofM047epxMHJlZkRWXyj10WhhVpLjBpdNrjouLsjVOqHUKXkxex8bXSsZ9yjhuIhET23gm0XFA4p6rGm1t18fibjpJQuJjxPIOUdWtihEnrf4VQi8k70wQU5lpbOeDO0iqE/BP8QLjbfu3a/QHVsijsv4nxg374av/CmH9mXPefDGCuXOz6CfZ+KmvlAMfrbWuH3KFnPOIoat
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(186009)(1800799009)(451199024)(7696005)(6506007)(71200400001)(5660300002)(4326008)(26005)(9686003)(83380400001)(2906002)(4744005)(478600001)(52536014)(316002)(66946007)(8936002)(8676002)(66476007)(7416002)(54906003)(66446008)(64756008)(66556008)(41300700001)(110136005)(76116006)(55016003)(82960400001)(33656002)(38070700005)(122000001)(86362001)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWJCNFozdDRWOWFPZUwzVHdEVzJ5Y2xXRE9LaDdhRklqQXBlRDFXSUVkYWs2?=
 =?utf-8?B?Z3J1aGJCZEM2aW45WXM5UTVHcnUrbjRDM3dvbGwrRkZaV0oxTFR1RE9oU1p4?=
 =?utf-8?B?aG9Hc3JDUzRNZzBkSXRpQ1d3ejdibk1UN3htTXJHN3FyRkRLa1c4a0hIaFRu?=
 =?utf-8?B?bXpKVFlLWHErUEtRWlpVbGJ2TXBHOWNWdlJ4Rm91ZVpKb1pXSFUwQXpYcVZz?=
 =?utf-8?B?MWFVVmVMdGVyRytTZVo1MVBrZVZHU0daM29YcDZVMi9WZjZybk5KRVZ1NTFT?=
 =?utf-8?B?MEpvUGNqVmVHOXRHNVUxZ1RWMmxuYjJyOFpSUFVGYzg2NnArOXdHNkpvLzhm?=
 =?utf-8?B?TFJFVGRsZ1NLTVV5Q0FkbHZwcVJqQU5xTEcwTmdvanAxMmVseXlIZFBjRE93?=
 =?utf-8?B?aWZ4UzAySkN3S2J1eVFPMXp5bWljK0JndEtiQjI3K3NsY2taVnU4R0E0RTNo?=
 =?utf-8?B?ODBjVWJIYnFmM2lKRTV3YnFWN1ZXWlBaOXRrc0VUcDV3MlFOZlhuZGlzTXZk?=
 =?utf-8?B?SjFGNmVlREdRcEJXYUtkcW1IcEY3ZFVzREJ2QWhsVkhoUW42bWRmRE1UZ284?=
 =?utf-8?B?VUZVbzYyUm12VnQyeTdBdEpMQXBXMzJieWVyZ3o1SHJjSTkvLzlmWm5sV2lB?=
 =?utf-8?B?K1l4MVJGUmVSWjdoSmQxTERGcjYyaWQ0eTI3eERWc0VXMlJpWldIWmlndnFt?=
 =?utf-8?B?clQ3KzN4Q0V6VUszcXkwbG9GM1BWdm5uc2Y2WkRGMC9Jd3Q1K01KT3g1RlZI?=
 =?utf-8?B?QjIxMFhyS3d2MFNhMlRzNUdYS0RraGI4bEdSQk9BY2hLRm1NS0Z6NnZ3TkVR?=
 =?utf-8?B?bGVrZW8xNXY0QkllT1UwWCtIcGRLMHVUcm5CYnhiN0oyM2FwSmZmRzdva3h6?=
 =?utf-8?B?aUlnZkhkTFFjMjhrTk40YjlDVEZEL0VGVFR1NTFCVEZqYnhBRnRCc0FDTDVn?=
 =?utf-8?B?ZEV0eExCbkJKN3BZdEtod3BXem1NYTk2TE52eHFUaXh5RzFLSTlkdklYM2RJ?=
 =?utf-8?B?L09QWjVacTJRdFd2S1lxQ3ROdDhzbjM1N0VJTkdqZHJLSGcvSnJPMm1LVElL?=
 =?utf-8?B?bHdOKzZVdXlva2tlMTArTGo1WjN1QUQ0RThlejRRUUo0UnVES1k4azViR0oz?=
 =?utf-8?B?Z1dkZ0w1eDdHR2hCTmM0MlpkUzZSZEVqbWtvWXpXeWhYZnhzZTFyVW5qUnR0?=
 =?utf-8?B?TDNUTk5lVkowdko3QzZob0E2aHlyUHo3QTY0empDUk0yN1VablFpdUNpQXVM?=
 =?utf-8?B?aTZRSW9FdkNKaTdSMXVWNXB3OFViVUo1Z0V2V2dLZFVwSlhoVGFvdG1sUlBs?=
 =?utf-8?B?VjAwMmdmVGRzQ0k1VE8rczVxNFNlTCtXaGFXdHdKazIyRHpOYjVwZXlGRSs0?=
 =?utf-8?B?UlhRN3dlZGRKcHhJcDZ3Z1ZpV3Z1N0d0Rm5NZVVuOWU5QTU5QnBFRDhuL0h4?=
 =?utf-8?B?allmZ1BIWWc0em9ja2NYdWlZTzBCL1p0UGMyVHIvbnFubGpteVpZaUdtQVB5?=
 =?utf-8?B?eUMycHFaZHV6MlJObjlPQ0RvSlh4Q2FRYTYwQldCYXZ5OWpZWjJEbTgxSVFD?=
 =?utf-8?B?eHNwMGFpckc0S1FpYXQ3bFZhR24wT0UvbDEzeHp4V01vbk5Cd1Y2ejIvQTVw?=
 =?utf-8?B?OCtJK29qbUt5WXpHODBhN1hIWWtoK2VJWVd5VW9hbzBPdGttMEsxd0hudmtC?=
 =?utf-8?B?UHdrS1BmWTJHdVBsTVp4RUhmMFQ3NXVBZGRBbTBKbDl5RDl5STIwejM0c1l0?=
 =?utf-8?B?SExwM0E3OTF0Z2FRNUN1S3M2M0xrdTNLUDVRR0Nja0UwVUNHUTU4NTE5alk3?=
 =?utf-8?B?eEprcHNZc3pWVVdYaGZRQ3ozS3d6bm52VHlxTTB2eVlUU2p4ekV4RzdJYk5P?=
 =?utf-8?B?Z2dRSGNpS3NwUElaV0tiNFUzcGF3bDN0cnkydmV2ZDRuTGRXeGlQdkNNTUZS?=
 =?utf-8?B?dUlmeG5MTklQOXVIYlY1MFFLOEMxNmFZK1BUMkMrZ0txb2NHZzZGSUJ3Sits?=
 =?utf-8?B?L213MzMwbWZjWEI1UlBZbnB0Y1E0SW42NHV4WlB2bVlvTW8reU15WVlVc25Z?=
 =?utf-8?B?Mnd0VFB3SmRXUXVpVDdQVDFnWEoreFA5RmFoWEJBVndqNkpMMHUzR1JRTkxR?=
 =?utf-8?Q?hJ7+VZNO1f45qDo9/45CxeUyu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9eccf2d-9fee-477e-ffa0-08dbbb475f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 08:39:01.6595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLWwKfY0sTk8lHDnQSTfC/a95RsL7kWIRd+bgJvWpzeEwK3g0StKk5UaCeuNCc9o38pqWlFew5gVy5P+OyJlhPlwcSNasYM7uUyTRmvnCZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6372
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIFNlcHRlbWJlciAyMiwgMjAyMyAzOjE2
IFBNDQouLi4NCj4+ICtpbnQgaW9tbXVmZF9iYWNrZW5kX21hcF9kbWEoSU9NTVVGREJhY2tlbmQg
KmJlLCB1aW50MzJfdCBpb2FzLA0KPmh3YWRkciBpb3ZhLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICByYW1fYWRkcl90IHNpemUsIHZvaWQgKnZhZGRyLCBib29sIHJlYWRvbmx5KQ0K
Pj4gK3sNCj4+ICsgICAgaW50IHJldDsNCj4+ICsgICAgc3RydWN0IGlvbW11X2lvYXNfbWFwIG1h
cCA9IHsNCj4+ICsgICAgICAgIC5zaXplID0gc2l6ZW9mKG1hcCksDQo+PiArICAgICAgICAuZmxh
Z3MgPSBJT01NVV9JT0FTX01BUF9SRUFEQUJMRSB8DQo+PiArICAgICAgICAgICAgICAgICBJT01N
VV9JT0FTX01BUF9GSVhFRF9JT1ZBLA0KPj4gKyAgICAgICAgLmlvYXNfaWQgPSBpb2FzLA0KPj4g
KyAgICAgICAgLl9fcmVzZXJ2ZWQgPSAwLA0KPj4gKyAgICAgICAgLnVzZXJfdmEgPSAoaW50NjRf
dCl2YWRkciwNCj4NCj5UaGlzIG5lZWRzIGFuIGV4dHJhIGNhc3QgKHVpbnRwdHJfdCkNCg0KV2ls
bCBmaXguDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCg==

