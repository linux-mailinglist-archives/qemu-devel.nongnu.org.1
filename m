Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CCB74324D
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 03:41:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF37Z-0004dA-2U; Thu, 29 Jun 2023 21:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF37W-0004cu-VF
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 21:40:23 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF37U-0005UG-PI
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 21:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688089220; x=1719625220;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qc5kk/GxdhkwAA/jTp84Z9t6TOSaN0tJ5k0hV2M2gOU=;
 b=iRM45X3MnfAID8rAwFdJtgX1GrOT5cn84/eWRIVPJctCK2FrPfBSXfBF
 +IvtXW50YaaoPoUPhN62XaoF8OWkhrIiOMHEWM3NULJxVcy1oT/hZHGyM
 Nn9jmPWJZMEgL5tcWzSlXBZXi1E+x6p7nQC/rdSCro+b5nTanqozVZwtM
 onvZmO6wvIPaIjTH0Td9Ht70sn5qlimdWAeCD7ihMWue41Lpu+TzFNNfn
 HsFlRoSZ2T+yG7KkkxL0n/9xc0tW1KjcaOxFINcZ2f7Bv94T3FXp9flGs
 fqiHbuDSqib+b5bIipCpzAJe3YhTFiuo8/shu5QxT7sBXj7CzqbzVlP0C Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="428322516"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; d="scan'208";a="428322516"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 18:40:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="891604670"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; d="scan'208";a="891604670"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga005.jf.intel.com with ESMTP; 29 Jun 2023 18:40:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 18:40:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 18:40:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 18:40:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FO1nZhxRbmAxqLaMQhEBYEPkJDcaQvuaoaNuMANHjaxJq3itHdAJ0x2n8SZ4zEQ3AXOahMlOgl3x9qGfDoOLHgH2P6PbKsGLrNkHhb/ccnLZfiRVrBMLUTX1ftQkNl3w9UuHeHMbHXofIW6yJZJ1PYGWPOGuBaSVyiuZPXFr783wloyeA6zW3/TB/6wkScshHWxbuf+pSSci3rYuS3YXEp1z3f2w3QZhSdGduR8rcUwNz6NDaMYr+tSZsaRlROACSlA7UX+K/sYCq9+iMyfqCV3mLg9bp8IkJfQV1hnzA30MXR1ASgs3Fbi3Bclk9UmfYz4nfcxDzcrQbBP420RuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qc5kk/GxdhkwAA/jTp84Z9t6TOSaN0tJ5k0hV2M2gOU=;
 b=a5DnHOrtONvtqaU+tIUB/n+r+EFHaTTywFCsAWRkL42RFelKmloG80TSZtyZU5LsXVJn+4dsMaXarGayr76CV/1Uq4/5pbeKYrWpYn0orZhbFi+JYm/lTzdbeaKm8uPyE8fZMaF7QPwZWZdv5++493M47pn3Xh2/UuBW6PhMWHVKbsPeozXBduaEVqQJSsTYF9T1zCwUPGB2q1qsVp+qLxZEkkWZWaAf9pJEWQ/lSLuoDgS4kTM0ADVtynV+yz6+Vrxt4FaBgj81s0PtinE4EAyDp5pxfEE8ylMFbHHD1fuQB7mXdJOOyxRpwANb9REjsbAES2M7ba5xj0zZzwdVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB5485.namprd11.prod.outlook.com (2603:10b6:5:388::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Fri, 30 Jun
 2023 01:40:13 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%6]) with mapi id 15.20.6521.024; Fri, 30 Jun 2023
 01:40:13 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 5/5] vfio/migration: Refactor and fix print of
 "Migration disabled"
Thread-Topic: [PATCH v4 5/5] vfio/migration: Refactor and fix print of
 "Migration disabled"
Thread-Index: AQHZqmc8HYoHMjMQv0uJrkNymTGr86+h++QAgACWnLA=
Date: Fri, 30 Jun 2023 01:40:13 +0000
Message-ID: <SJ0PR11MB6744A00C8090DD6B95FF692A922AA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-6-zhenzhong.duan@intel.com>
 <fa97ab02-1b53-758d-9b2e-0d277b5e4e3f@redhat.com>
In-Reply-To: <fa97ab02-1b53-758d-9b2e-0d277b5e4e3f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB5485:EE_
x-ms-office365-filtering-correlation-id: 528a14ca-abeb-4c62-75be-08db790af31b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i42+5aqy7bE3FheaJcdO5BNseOix1o0fOgBtUcMgzvDWRXrFzpyzxnGXSD6SeKFBfFwovWxej2LEXwRhlq32znE/QE78YzJfb4khLl9yNpeR1o3LBu1feOVmsatRn4R3cAwyweEskxthLrBFzyK7cLqmbZNxjUlrSs4jUZcACobv3g9t7ZoD1l2uunnzT7mr9xWp0bdPJq7BoM66y18iG3yZLuEmSv9LUzNIOrl6PxbGA9PxHswAjC4NYupbFa7rdE2wMkjh6WlRjCJlm5+JarRSTnHzU8tFCT9tdsNE+PPSDXIGYThJzbrOfmeTvniacsM4aqFMPHOYbbukQ9URTvxP8EY7rD7hp7CUXFXkAFJ8KByCGSfzIIVs5zH9VZVR5ignymGDe1uZ2f8IyLy17ggDyqGpRwl4x10gwbKhM00usPFqRU2rGHc6SVLYC0LpbpBftA+pwAPiTccVNkl84/UdekAcLKSTYJL6kLJqcPVMBpJFK3TrZZBb475OY/FRqnWe/ukP/ma1KIGkcpYhr4uzJ+wDmGvtOmAB1RFbZJ13NABtYERVFK11SPx6sl9lc4K2a1z1ir252pOulFZSRfM62ztPi/DLQcIhFhrha1VCPVBVFD+sFkYbYh1xME6I
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199021)(38070700005)(82960400001)(38100700002)(122000001)(33656002)(86362001)(55016003)(66946007)(52536014)(41300700001)(8676002)(478600001)(26005)(8936002)(6506007)(5660300002)(9686003)(107886003)(186003)(83380400001)(2906002)(66476007)(54906003)(110136005)(66556008)(64756008)(76116006)(4326008)(71200400001)(66574015)(316002)(7696005)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RC8rK1pGZEZiS2tqcnVpMjBpTUZtSytqQWNaa2lpOVVLZTZhQ0UyUE0xNmRp?=
 =?utf-8?B?WGZaZTEySzhGcWZCbHFTUHFvVUVPNzVnTlNNanUxOU5acUdCNTF2ZkpzVkFy?=
 =?utf-8?B?enJZOUpva2VxV0VMcnhybG5Fc3lCMldqWEhyTnJIeWxiYlpOcXk0RHVxRmRE?=
 =?utf-8?B?NEwvNmMzR1pmdko0T3VLODhzNHBsL2xpQW5KWTdoemQ1aFJQRVZyZ3FLQkJD?=
 =?utf-8?B?V1BLZXloRm9aQmRvNGJEdzdYeElvbW4rUmJvUGMrOHlwb2l0N0ZEL1FqbkJx?=
 =?utf-8?B?aERFOUkzM2FDaTMweW1PQytsck11djhoTTBERnprcGJ4N2JSWE1jT01QTHhM?=
 =?utf-8?B?T1NTZWt5Y3k5b1QxS3hyTVZHcnJTU2pQYnNqWVJaSW8xeDhPbzYzRXVQdURl?=
 =?utf-8?B?bFMycHR5R1NySmprZCs4b3IrL1V6UTJzMDh0dlMwNW1YNnk1TlhHdFVraUxK?=
 =?utf-8?B?b1ZIbnN6VXRrZjVQa1QrWGdkaVhidWZ4Zko1NlFwSlNRQ051V212TEpwZjZM?=
 =?utf-8?B?ZzJLUU8yMWs0U08zcWJIU29WY3RWb1gzQkFLRUMrTE9MWmRMYkI5TDRtY3RR?=
 =?utf-8?B?cTEySTZKaWJtSTY3TkM3Ukg3b3hXcUY2YkZ1NnNxQzFTemNHY0dpVWdjUFpG?=
 =?utf-8?B?eVVLNnUyZXhpSjhGNzJRb3BVQVpreHhLTnhyUW5LZE1Lci93cFMzWHV2NjZv?=
 =?utf-8?B?blFLUWNSME9xczdYbnYxM1VBVmlRdnhEWGFKcStWd0o3TjNpbEhsd080SEFz?=
 =?utf-8?B?Q0lZN0pZTU9EZnZXdW5VQnh4aEkxeUo0STlQVTFoVDBSRUZKR2JTZG9pNERI?=
 =?utf-8?B?SXlJZDM0ZDgvTnk0U0JMaEJQQXY1Vm9tZ3RiYkdDZ3RlbUhuTWFPeFNNMEFE?=
 =?utf-8?B?QXNnckh5ckxkNlhyank2UFBua3J3a0ZnZkZ5cHNDbGttK0Z1VUJPdmM2QmNF?=
 =?utf-8?B?M3FVbTdudUxxeE9uT0wvRzZmcDExOXpFem43Y0pwWnIwNXZoNFU3ODEwL0VM?=
 =?utf-8?B?STl3TW9hNzZmNXp4aiticC9pTVV1dzJkT1NHajhFUUZjWUxDYmlDR1RiY0xs?=
 =?utf-8?B?SVJ5NDdkZ2tudVNwcnpTT0dqdVlVYnZQVnZOdlpxV3FMcEVSMldhQkR3WVRD?=
 =?utf-8?B?VGQwU3lSVVh1YkhYRmluR09QUldQc1ZqSGZzVG9GSXUycSt1c0haL09tQlFV?=
 =?utf-8?B?UHBHRG95Rm1CTmNMMTJ3M1lnVDZGVk5lMVhXbmJlVGhMNjlVQnk3NUViUkhw?=
 =?utf-8?B?dFVVVnNmZkdRcFdFMlRkL2dVbDc2Sk9NS3JPS1dOUmZXTlVhWEY5d2dhbWJh?=
 =?utf-8?B?TUFXYXdyRUxMT09nSDlnUVdNdHh1ZVlDNmNHVFlpTG1iSGlDRGkxVWRnankx?=
 =?utf-8?B?QjhuMllMVjlCc1Nxdlgrbys0VHZFZ2xOKzh5c0N0VUlrTjRKOEY4bkhxQ25C?=
 =?utf-8?B?LzhRbm5jbkgwbTZVb3RRRURGL1lyWE1udGk5NXhURGt1eGsxK3RXMmRYOUtv?=
 =?utf-8?B?SGpYTWxlZ1hXNXlWcVo3Nnp3TjdKcTRNUzZuR1NqdnNWZ1VQRFEzZFdvMGhK?=
 =?utf-8?B?dG5vWHlLZ0pqaEwvSUpFTjhzNVQwOFkzS1ozY2tNVTlQN3RJOVkyWmhuKzRk?=
 =?utf-8?B?OExVSGxWR3lwZFNtVmVWeHhJSVUvZTFIT1Jyc3dYbWdiRGRaQTRaME5nWUQz?=
 =?utf-8?B?OTIxK3diZEgwUVc5WkthZE5MZjRqS3E1WW5Ic3Q5aWR2bWdZLzZwQkNhVVlJ?=
 =?utf-8?B?emFzZERXeEVveEJKZnBrVHBGYXZ4Z0FzMFNhVGNsTUxHRHh4WkJIaWVObXJz?=
 =?utf-8?B?ZEVKZmdpbnczRDdBZkNXb1VHV0R5QVl5WER6RzUxVDFSS2JWSFRQV2YzcmtQ?=
 =?utf-8?B?dHRMS09nU3pYVnVzYlo3WlFLVFN5RlhoaDY0ZjB6VWpqZjZPMXdSeWxJbjFN?=
 =?utf-8?B?NmNUbUYxckNQMUZ2bGNOcmZlRzVTVWVyQkxySlRhSXlxOWZ3OWhWNE96S2RL?=
 =?utf-8?B?TnhxSStnMDUzUTVlRGNiS2tQb3ZQUm5zTnArTTREajlaVkQ3TTdoU2RBUUo5?=
 =?utf-8?B?VVdQMlZTQlg4c3IwUWIway9OZHRrMVVmUU1UdGhrbGs0SnpIc0k0R1dkV2J4?=
 =?utf-8?Q?HCbfDeFHaEVR9iKqRqHIscHgs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528a14ca-abeb-4c62-75be-08db790af31b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 01:40:13.7995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pWrlKDj2A4+s+ZVIa0vLkpyLZKEfbLbYvA+NDOZBgspaqCB+R9DfgmtEE6Xk6/ZN/Gy4MagUh8XOwwNa1s4vAcFj/Y7oqs0sSGigxjSiL6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5485
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNs
Z0ByZWRoYXQuY29tPg0KPlNlbnQ6IEZyaWRheSwgSnVuZSAzMCwgMjAyMyAxMjo0MCBBTQ0KPlN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNS81XSB2ZmlvL21pZ3JhdGlvbjogUmVmYWN0b3IgYW5kIGZp
eCBwcmludCBvZiAiTWlncmF0aW9uDQo+ZGlzYWJsZWQiDQo+DQo+SGVsbG8gWmhlbnpob25nLA0K
Pg0KPk9uIDYvMjkvMjMgMTA6NDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gVGhpcyBwYXRj
aCByZWZhY3RvcnMgdmZpb19taWdyYXRpb25fcmVhbGl6ZSgpIGFuZCBpdHMgZGVwZW5kZW5kIGNv
ZGUNCj4+IGFzIGZvbGxvd3M6DQo+Pg0KPj4gMS4gSXQncyByZWR1bmRhbnQgaW4gdmZpb19taWdy
YXRpb25fcmVhbGl6ZSgpIHRvIHJlZ2lzdGVycyBtdWx0aXBsZSBibG9ja2VycywNCj4+ICAgICBl
Lmc6IHZJT01NVSBibG9ja2VyIGNhbiBiZSByZWZhY3RvcmVkIGFzIHBlciBkZXZpY2UgYmxvY2tl
ci4NCj4+IDIuIENoYW5nZSB2ZmlvX3Zpb21tdV9wcmVzZXQoKSB0byBiZSBvbmx5IGEgcGVyIGRl
dmljZSBjaGVja2VyLg0KPj4gMy4gUmVtb3ZlIGdsb2JhbCB2SU9NTVUgYmxvY2tlciByZWxhdGVk
IHN0dWZmLCBlLmc6DQo+PiAgICAgZ2lvbW11X21pZ3JhdGlvbl9ibG9ja2VyLCB2ZmlvX1tibG9j
a3x1bmJsb2NrXV9naW9tbXVfbWlncmF0aW9uKCkNCj4+ICAgICBhbmQgdmZpb19taWdyYXRpb25f
ZmluYWxpemUoKQ0KPj4gNC4gQ2hhbmdlIHZmaW9fbWlncmF0aW9uX3JlYWxpemUoKSwgdmZpb19i
bG9ja19tdWx0aXBsZV9kZXZpY2VzX21pZ3JhdGlvbigpDQo+PiAgICAgdmZpb19ibG9ja19taWdy
YXRpb24oKSBhbmQgdmZpb192aW9tbXVfcHJlc2V0KCkgdG8gcmV0dXJuIGJvb2wgdHlwZS4NCj4+
IDUuIFByaW50ICJNaWdyYXRpb24gZGlzYWJsZWQiIGRlcGVuZGluZyBvbiBlbmFibGVfbWlncmF0
aW9uIHByb3BlcnR5DQo+PiAgICAgYW5kIHByaW50IGl0IGFzIHdhcm5pbmcgaW5zdGVhZCBvZiBl
cnJvciB3aGljaCBpcyBvdmVya2lsbC4NCj4NCj4NCj5XZSBhcmUgY2xvc2UgdG8gc29mdCBmcmVl
emUgYW5kIHRoZXNlIGNvbWJvIHBhdGNoZXMgYWRkaW5nIHZhcmlvdXMgZml4ZXMgYWxsDQo+YXQg
b25jZSBhcmUgZGlmZmljdWx0IHRvIGV2YWx1YXRlLg0KPg0KPlBsZWFzZSBzcGxpdCB0aGlzIHBh
dGNoIGluIG11bHRpcGxlIG9uZXMgdG8gZWFzZSB0aGUgcmV2aWV3LiAgTWF5IGJlIHN0YXJ0IHdp
dGgNCj50aGUgIGludCAtPiBib29sIGNvbnZlcnNpb24gb2YgdGhlIHJldHVybiB2YWx1ZXMuIEl0
IHNob3VsZCByZW1vdmUgc29tZSBub2lzZS4NCkdvb2Qgc3VnZ2VzdGlvbiEgV2lsbCBkby4NCg0K
VGhhbmtzDQpaaGVuemhvbmcNCg==

