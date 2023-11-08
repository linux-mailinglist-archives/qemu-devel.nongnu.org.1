Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BAA7E50DB
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 08:18:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0coQ-0008Vm-LX; Wed, 08 Nov 2023 02:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0coM-0008Ux-Lx
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 02:17:15 -0500
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0coJ-0005IQ-0k
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 02:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699427830; x=1730963830;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4r3bSc7UFEdtAQFCU7vYBtVqiqdZYnOX8+T419bRuEk=;
 b=ijVWZu6OS8KqWhf6729KW9lv+09hc50S7Q4cC6uLlFGhRSu1PJ6N1xEq
 /SLsLzImJs3o+Gro6yWNkhEfRmVqTC0JEBNi2lHiIWAGIYn+KX8hitU1f
 BOCPdSWJn+ABocZoRns3Lc0GgQuvZpYwn5Swxu1xm85YmEgzEUon7bfIu
 yxD+9PGUD9Vg844GPkRPxL5aTPoRAWuXzpSjLKdLAjpyWEIQAhOnfFDTf
 NNkfqWTtss7bnKevFj5w8PFzIQscEHF7dI9bIbLoLLuxg2mYMYxEThbUH
 s/sk5kJCzuydfIGGMv1A9j6z/JDeKts7QlAPbuNDCzTRj2S8XwzhVy92P A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="420812561"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; d="scan'208";a="420812561"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2023 23:17:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="4092904"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Nov 2023 23:17:07 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 23:17:05 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 23:17:05 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 23:17:05 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 23:17:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3eYuWLPXE2HKDV4toMxWce/uMZ9aL8QImxyAzOCNX8Gw6i00rrQ0hJ9ZLKk4TuUsb90VWSYMnahrFA2rlTPOuMyEfYfalv0po1Q5a3pxZESumGiKqtnJDBjyjhsPS8omjIw/KDTaCPDqanDRpuQo9SqJATa71gRv8XSON1AcfnxH8KCuMpK4FmEC9b79E40UK+AwHv1L7FurIL6Egfg3TEaGnG8ugW747r+N3ZN3hgF1pxwqgpeGYvDnMF542RQUjtRnq/yqHN8HHxFstEnEFutqrSl4GLb90G4LZp5NlQjPwR+HcLYg37vt48fWZZLHo0OwjIJTMNGWPy9TNjmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4r3bSc7UFEdtAQFCU7vYBtVqiqdZYnOX8+T419bRuEk=;
 b=BeqigiiPoiuk+HqtE348rLKOkIpOxfg3lSNqTvu4PfSh8bh4+KIIsARBIMi/oE/fZgKpEGeRNeSwluv8xmiFctFb97wCnLAJH3+EXRYpUUD+ZUf/kVTKIa9pe7p38j1NjNEnFwQIZpDwgKvfbm3uSfUEX2pSf65+yIvc6fIHWk7g4QorjrJpZ765oUQovUtoP0PLtAs90WsjeMGwBIo8AI0C6Rl7836tpSMvlMg7VG9oKOGCyPol0bLOY4ZDP1omTmgqW1F3xsTzvAj8lIvy8/hMS0kvkx30ptnjeFEuWHeix+bXFfZmvI8PQVGWGpIEMZNyU/Qf8TIEx2sHXdhvIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH0PR11MB5491.namprd11.prod.outlook.com (2603:10b6:610:d6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 07:16:53 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 07:16:53 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Thomas Huth <thuth@redhat.com>, Eric Farman
 <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, "Jason J. Herne"
 <jjherne@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: RE: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
Thread-Topic: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
Thread-Index: AQHaDV58rXzWcAbguEiSUs8ukZNa17BvxJKAgABFgEA=
Date: Wed, 8 Nov 2023 07:16:52 +0000
Message-ID: <SJ0PR11MB6744D87FD3CBB3380647E68792A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-29-zhenzhong.duan@intel.com>
 <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
In-Reply-To: <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH0PR11MB5491:EE_
x-ms-office365-filtering-correlation-id: 66f50d00-6fd9-4a59-b4f1-08dbe02aaedc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x/S6dTXbgq5BzdiQgeZsxVSwrOpFSaJPYAvM6iOHLdJ7LOdbvm1a4JWPj4KREhPmR4JFDKLl1dRllKpbukJcCZNVNF6QVUyQ8FKPq6ECnHpN9C+S2dug71X/EtFxV4tL3kmNiVJAIaKBqTSEw+ckEAzll8cU90khDSeVyp8AvfSEjK89+51DQdUyDgbfebVr3DabpEtHaT/+dXJ6AtbI9o5DugKuVQaAdmlreMgcBWUF9CrY29Scw/EvshOR4FKMlKzknIYRiaeSw6UgY1611mFD0ix7VRRXjuOhl1s+MfQKORgY87rqBA8z0bSqBf8HtIYlz5g/ZMMoaR8LKG1R6BkoCluZm1be4qT+UMmBT2q03FSSQXpKh0cvcRl8R8FFlcF4fErrxREwqcblltAjza/DvqNqOXR6Tz5gP7DRadkz1O80y5b8T9D6jrFnRLoBZbAhcvbJakXZH1HFk4pE/z5OU6QPwgx0oE4JYJ9xnXJiuRIY/7/EBf3ZAl969kP8xPObt0ks3mNkOBCCj5qUrWSbnDU9wD4qfEnABIquh8vtwF4FLjJATXZqY0GXQjh2AhTrU7lmWdE/0jb/4/JlDd3oLzdQq0JSJhB6+CuHjQrDbDLlUbBDDNPhdgVt5iYl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(64756008)(55016003)(9686003)(478600001)(6506007)(7696005)(71200400001)(38100700002)(33656002)(86362001)(122000001)(82960400001)(54906003)(7416002)(66556008)(76116006)(66946007)(66476007)(66446008)(83380400001)(2906002)(41300700001)(26005)(316002)(5660300002)(38070700009)(110136005)(52536014)(4326008)(8936002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWlkTStPaWwwOXhocFhxaUU4NmhXMWZ5WTZoejIxbm51YVkzYXNoRlJuQWV0?=
 =?utf-8?B?c2RxWXdISUEwZzQ5cXVwdUNUVE5VUTdMQmxldGNoTFhmeHZsUWFrZlRKc2ZX?=
 =?utf-8?B?MU5rNGdTcThUV3JNSC9xMzlFLy9SNDN6MU1sQW5vMDNmcWluMEZlZzNxWlZX?=
 =?utf-8?B?dzM1bGV4UHBYOGhRWXNsbHhkR01FZXdKeHIzUXZwekhHMWJGT2llQ0g4K0Ra?=
 =?utf-8?B?eU51S2NPRVZkQ085VTBveFJjcFdQVC9jamR1a3drTERHbk1NemJLNjdQVmxp?=
 =?utf-8?B?R0dEc3BNZmJjS2M3NTl5L2JrT1F3NVBlcmdrazZvb3NhbkxNc0ZSYndmY2pR?=
 =?utf-8?B?SkpPMDJVR1p0ZVNicUc5REE5L0x3bi9CSzVEam50U3l2ZFhTTTd3VEFtZ1R0?=
 =?utf-8?B?MUpWdEJZNGJBVWk5blJ6eTRVdFR5bmJyQWFuck1sZlpFSTN4RjMvRHJjOG1G?=
 =?utf-8?B?eVdyNmVac2FKSGwvY2R5OFNuTm81SUhTbHZvODBRVnlKVThSaDZRUHl6YjFS?=
 =?utf-8?B?SVNUclh0WlVlWitwMEc3eHN3ZHZaOTQ2cmxyZ3JUb2V0VjA1ZVRUeWZsTFNL?=
 =?utf-8?B?V09oVG1IaUV6Ylc3dFVVbEZDbFVvTG9KN2psNnZvRHVRRmxpWGVFY1hFRG81?=
 =?utf-8?B?OHd3VnRzUUtiMWh0Q2FpZXhzZWQvTnpxajRvWmE3QjNyNFNNRklaTWFrN2Ra?=
 =?utf-8?B?SEFFNXA5dGRoczhQV0tzY2daUDdVUm41dEsrQlFBYk1PYXlpbzJmZEt5dStn?=
 =?utf-8?B?Zk9majl1dXhCL296WmpzSjBKL1VZc0NlNzZWNlhpaXFXMWl2Sk53TXJLNHg0?=
 =?utf-8?B?SnExRGdLU0czUGpZSDIxOFdUaStBNjRFYTdQa0lKY1p6c2hpWGRUcFFqQ01m?=
 =?utf-8?B?ZGxybmxsOHN1WXFWY2RxQW5kZjBMeGN1aEhkaDNXbS9FTjZzeFVBTDNwN2Z4?=
 =?utf-8?B?d2lTTWYwcFVIazNmMHpWWlFUYWpkY3B3RzFETzd3MmFJZUNWaFk4R0NlTjhT?=
 =?utf-8?B?RkRneEIxeUtKcTFMUVJhOGJuOXJPMEllM3l4ZktYMHlybjljUS9udHVLYzFz?=
 =?utf-8?B?aXVQdnh0cGpTT1JybGY4VFBPVm5RdnJkK2c0YWZCeVJKalpnMTBPU0VJRUZL?=
 =?utf-8?B?dmdMZ3JiNU5kTWh2K09OUk1aU1c2a3BrQTdndzlLMXlXa2FwTmp2U29ET05O?=
 =?utf-8?B?NU82RjhHWnVNYU9kNVprYVNZK2Rhb3hlM01PUWRtZDJtekNwbkpZeUh0b0tO?=
 =?utf-8?B?Tkdqc3c3YTlzSFExcWZrSk1EM2RNdEFSZjdtRjhwOXNRNERjNWdheGpxdkZt?=
 =?utf-8?B?MERRaHdBZ2FFZFdyNy9Day9TS0FkejQzbUlnRyt4WWZ6YU1qWmUrMGt6VkhM?=
 =?utf-8?B?TmwxOWFVVUZrSzA4dXQ0cHlFTjhoaTJzcWZmTllkNXA5Y1lkZXBSYnNMNiti?=
 =?utf-8?B?SXR5azdTbG1BSGtobnQ1cFNBVDdzcVpZaTNFSmdtVlZBK3pYRmw2YUlaSjFo?=
 =?utf-8?B?SHBvNnRVcnRSbXduUzBIQ2puRituc1E2STZldjdjcjR0MjNMelZNbFFxU0FE?=
 =?utf-8?B?U1A0bFNqanFzMzhtOUpaVDFyTkNpcnNTdmM2Y1ZQVSs1TU4zYjE1QWE5NG8r?=
 =?utf-8?B?SkE2UC8yT3B3R042cmkveGc3YklxUmJrMkRGcjJnUzl2MmRzNVlDUDBEOFNK?=
 =?utf-8?B?cTh4SUo5TmRWTk1UajdJSGE4Q2ZoUmlNSVJiU25WNjIyYjdBVU85SVh4Qm8y?=
 =?utf-8?B?NTdTVm94Y28wS0RhNVYxdGM0WHIvT1ZvZzFvdnlxTzlEbGlkQnZlZ0V0dWRK?=
 =?utf-8?B?eSsyKzMvVUZPa25DTkRtaDlPQlhxSmpySWhRdG9RZmhLdnp5TDJtV01VU3ZQ?=
 =?utf-8?B?bTdpamZrZDBkRWgweUhKRkczdFFOWi9VUG5uRVplOTlycFZkMWY4aTg5UC84?=
 =?utf-8?B?WStydjNQMVhBNlJVeGJnQ25JQUZ2bjVzRno4ZHRRaW9VMzI5QlEwSjlEZHZ6?=
 =?utf-8?B?clNSYi9SdVBTNGs0YmtRb0g4MXNLOWRHSUJvVDA5MXZKMUs0dWRjejRDOTlD?=
 =?utf-8?B?anNGdStJVXBaWXREYS8yT2o1dmdyMW9KdUd3WTlkNm5RUHA3NUlpc0lkeWRB?=
 =?utf-8?Q?J7rN7BEiQtON5EqS8z4AA1cEB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f50d00-6fd9-4a59-b4f1-08dbe02aaedc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 07:16:52.9586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bT2hvbTUwVeeD5dPpswyfSe0aX/WXVOUcLHx+l6IqOFzm7ikzHxmiwanHxgm3qhGotciMmLHcJS92ZvNrn64iUmsP3DXw1hitmz/xS/y66E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5491
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

SGkgTWF0dGhldywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTWF0dGhl
dyBSb3NhdG8gPG1qcm9zYXRvQGxpbnV4LmlibS5jb20+DQo+U2VudDogV2VkbmVzZGF5LCBOb3Zl
bWJlciA4LCAyMDIzIDExOjAwIEFNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NCAyOC80MV0gdmZp
by9pb21tdWZkOiBJbXBsZW1lbnQgdGhlIGlvbW11ZmQgYmFja2VuZA0KPg0KPk9uIDExLzIvMjMg
MzoxMiBBTSwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBGcm9tOiBZaSBMaXUgPHlpLmwubGl1
QGludGVsLmNvbT4NCj4+DQo+PiBBZGQgdGhlIGlvbW11ZmQgYmFja2VuZC4gVGhlIElPTU1VRkQg
Y29udGFpbmVyIGNsYXNzIGlzIGltcGxlbWVudGVkDQo+PiBiYXNlZCBvbiB0aGUgbmV3IC9kZXYv
aW9tbXUgdXNlciBBUEkuIFRoaXMgYmFja2VuZCBvYnZpb3VzbHkgZGVwZW5kcw0KPj4gb24gQ09O
RklHX0lPTU1VRkQuDQo+Pg0KPj4gU28gZmFyLCB0aGUgaW9tbXVmZCBiYWNrZW5kIGRvZXNuJ3Qg
c3VwcG9ydCBkaXJ0eSBwYWdlIHN5bmMgeWV0IGR1ZQ0KPj4gdG8gbWlzc2luZyBzdXBwb3J0IGlu
IHRoZSBob3N0IGtlcm5lbC4NCj4+DQo+PiBDby1hdXRob3JlZC1ieTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5h
dWdlckByZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRl
bC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5A
aW50ZWwuY29tPg0KPj4gLS0tDQo+DQo+Wy4uLl0NCj4NCj4+ICtzdGF0aWMgaW50IGlvbW11ZmRf
Y2Rldl9hdHRhY2hfY29udGFpbmVyKFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVkZJT0lPTU1VRkRDb250YWluZXIgKmNv
bnRhaW5lciwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVy
cm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAgIGludCByZXQsIGlvbW11ZmQgPSB2YmFzZWRldi0+
aW9tbXVmZC0+ZmQ7DQo+PiArICAgIFZGSU9JT0FTSHdwdCAqaHdwdDsNCj4+ICsgICAgdWludDMy
X3QgaHdwdF9pZDsNCj4+ICsgICAgRXJyb3IgKmVyciA9IE5VTEw7DQo+PiArDQo+PiArICAgIC8q
IHRyeSB0byBhdHRhY2ggdG8gYW4gZXhpc3RpbmcgaHdwdCBpbiB0aGlzIGNvbnRhaW5lciAqLw0K
Pj4gKyAgICBRTElTVF9GT1JFQUNIKGh3cHQsICZjb250YWluZXItPmh3cHRfbGlzdCwgbmV4dCkg
ew0KPj4gKyAgICAgICAgcmV0ID0gaW9tbXVmZF9jZGV2X2F0dGFjaF9od3B0KHZiYXNlZGV2LCBo
d3B0LT5od3B0X2lkLCAmZXJyKTsNCj4+ICsgICAgICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAg
ICAgICBjb25zdCBjaGFyICptc2cgPSBlcnJvcl9nZXRfcHJldHR5KGVycik7DQo+PiArDQo+PiAr
ICAgICAgICAgICAgdHJhY2VfaW9tbXVmZF9jZGV2X2ZhaWxfYXR0YWNoX2V4aXN0aW5nX2h3cHQo
bXNnKTsNCj4+ICsgICAgICAgICAgICBlcnJvcl9mcmVlKGVycik7DQo+PiArICAgICAgICAgICAg
ZXJyID0gTlVMTDsNCj4+ICsgICAgICAgIH0gZWxzZSB7DQo+PiArICAgICAgICAgICAgZ290byBm
b3VuZF9od3B0Ow0KPj4gKyAgICAgICAgfQ0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHJldCA9
IGlvbW11ZmRfYmFja2VuZF9hbGxvY19od3B0KGlvbW11ZmQsIHZiYXNlZGV2LT5kZXZpZCwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGFpbmVyLT5pb2FzX2lk
LCAmaHdwdF9pZCk7DQo+PiArDQo+PiArICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgIGVycm9y
X3NldGdfZXJybm8oZXJycCwgZXJybm8sICJlcnJvciBhbGxvYyBzaGFkb3cgaHdwdCIpOw0KPj4g
KyAgICAgICAgcmV0dXJuIHJldDsNCj4+ICsgICAgfQ0KPg0KPlRoZSBhYm92ZSBhbGxvY19od3B0
IGZhaWxzIGZvciBtZGV2cyAoYXQgbGVhc3QsIGl0IGZhaWxzIGZvciBtZSBhdHRlbXB0aW5nIHRv
IHVzZQ0KPmlvbW11ZmQgYmFja2VuZCB3aXRoIHZmaW8tY2N3IGFuZCB2ZmlvLWFwIG9uIHMzOTAp
LiAgVGhlIGlvY3RsIGlzIGZhaWxpbmcgaW4gdGhlDQo+a2VybmVsIGJlY2F1c2UgaXQgY2FuJ3Qg
ZmluZCBhbiBJT01NVUZEX09CSl9ERVZJQ0UuDQo+DQo+QUZBSVUgdGhhdCdzIGJlY2F1c2UgdGhl
IG1kZXZzIGFyZSBtZWFudCB0byBpbnN0ZWFkIHVzZSBrZXJuZWwgYWNjZXNzIHZpYQ0KPnZmaW9f
aW9tbXVmZF9lbXVsYXRlZF9hdHRhY2hfaW9hcywgbm90IGh3cHQuICBUaGF0J3MgaG93IG1kZXZz
IGJlaGF2ZSB3aGVuDQo+bG9va2luZyBhdCB0aGUga2VybmVsIHZmaW8gY29tcGF0IGNvbnRhaW5l
ci4NCj4NCj5BcyBhIHRlc3QsIEkgd2FzIGFibGUgdG8gZ2V0IHZmaW8tY2N3IGFuZCB2ZmlvLWFw
IHdvcmtpbmcgdXNpbmcgdGhlIGlvbW11ZmQNCj5iYWNrZW5kIGJ5IGp1c3Qgc2tpcHBpbmcgdGhp
cyBhbGxvY19od3B0IGFib3ZlIGFuZCBpbnN0ZWFkIHBhc3NpbmcgY29udGFpbmVyLQ0KPj5pb2Fz
X2lkIGludG8gdGhlIGlvbW11ZmRfY2Rldl9hdHRhY2hfaHdwdCBiZWxvdy4gIFRoYXQgdHJpZ2dl
cnMgdGhlDQo+dmZpb19pb21tdWZkX2VtdWxhdGVkX2F0dGFjaF9pb2FzIGNhbGwgaW4gdGhlIGtl
cm5lbC4NCg0KVGhhbmtzIGZvciBoZWxwIHRlc3QgYW5kIGludmVzdGlnYXRpb24uDQpJIHdhcyBv
bmx5IGZvY3VzaW5nIG9uIHJlYWwgZGV2aWNlIGFuZCBtaXNzZWQgdGhlIG1kZXYgcGFydGljdWxh
cml0eSwgc29ycnkuDQpZb3UgYXJlIHJpZ2h0LCB0aGVyZSBpcyBubyBod3B0IHN1cHBvcnQgZm9y
IG1kZXYsIG5vdCBldmVuIGFuIGVtdWxhdGVkIGh3cHQuDQpJJ2xsIGRpZ2dpbmcgaW50byB0aGlz
IGFuZCBzZWUgaG93IHRvIGRpc3Rpbmd1aXNoIG1kZXYgd2l0aCByZWFsIGRldmljZSBpbg0KdGhp
cyBsb3cgbGV2ZWwgZnVuY3Rpb24uDQoNCkJScy4NClpoZW56aG9uZw0KDQo=

