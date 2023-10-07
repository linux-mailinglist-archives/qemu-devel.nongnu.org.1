Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8987BC47E
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 05:52:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoyLH-0001Um-Ts; Fri, 06 Oct 2023 23:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qoyLF-0001UZ-UN
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 23:51:01 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qoyLB-0005Eh-SG
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 23:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1696650658; x=1728186658;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZWW/b+reiZqhpYwhty8HKKGTUQQnYmi8P5yRWhQInxs=;
 b=saw7wI2SpwOGFQflM+btw6pXqAY8oi3czQYO1GVOSEkrd4X1dDIKeWKk
 Of716lDtT8/Pch+YSPDcKNyMprdd6bBRseLPlW6P8dKAvxXFoYS5IZV3h
 9nDLgPmzPjOUpXXM4egUydlMbB3NoH7JRynn9M3KdwAaUCC5cFfNtrhte
 KuaK1EViMQvJB+07jsBziSt2D1dJmX4/0vH6oC/66WeqlBUXTTCEeW/pv
 DaQnSJHP8WBdNLeSlfph62Yfs2eKq2kOwUEGQllhdofVZsLL7C7tIP+Re
 3avgyaeiSNWTxkyrD8hBnk/eCHTb/I6fpreCnUnr7xERgaUlnbHBizfCm Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="98224578"
X-IronPort-AV: E=Sophos;i="6.03,204,1694703600"; d="scan'208";a="98224578"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2023 12:50:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDgBN9SQZDZH5uk2ihuFQqwwvVl+Gkjiu0S6tGINinTDwXVdsdnyHp7PC8QXqQ4dk2rOlOJXO6F5sKjKQ2y6m04M2UYkceXABdkT6Wdiy04qN/s0ZS8hzCzKbNRhF7ycV65uWksKKoBpSAegF7Q4yW7GNFYSombeVYLdw0nUAjaEWToA63erV6voWKS6qcdq1u4wbZURQo4TIeB3CFs32D5P2TogyhjCPL/6/4ht4FWyEcgnKQ8LVNUyFkLxApEMzO9o4HaK8hkejWiKLHyS1L8GZUjlFVzEsYbPpdXctUH4/QmMhggtSwiV7QujdLlg5T7o+kXFhjj65oecYtZmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWW/b+reiZqhpYwhty8HKKGTUQQnYmi8P5yRWhQInxs=;
 b=ElPabAkNL4syzwPl9V2LD7hWW/TlbukHHcrqFgpMRcDeXLv8sR1we5YRyrVMilvH6xBQLkwrFmR4NZmAV82EV6RH+MKuhv0zh9jeE7GGyWio1fOZK9iUS6/ZacShEzOlJcj+E+4o+5Io13xKxG7I/IcThD813jen0cw776IOFL8n12gqsuy/aZSqACyAewG9THJq+khTAtHB8mjfeL96ao+f1q1+jD+IawcZaz1rBxB/B+D3oZtpm22ZygEWLs8eAKETQMpVzpGz88UopFX3DGFCLRtWdu8qDNq7AXqRYmbBq3GZIWgBXuBmStyC4jKAKzYmDAf4raxaiOKDARdJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB8125.jpnprd01.prod.outlook.com (2603:1096:400:11f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 03:50:46 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 03:50:45 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "eblake@redhat.com" <eblake@redhat.com>
Subject: Re: [PATCH v2 51/53] migration/rdma: Downgrade qemu_rdma_cleanup()
 errors to warnings
Thread-Topic: [PATCH v2 51/53] migration/rdma: Downgrade qemu_rdma_cleanup()
 errors to warnings
Thread-Index: AQHZ8g/wXECimcI8sUCZOBYuOtXwVbA9vsUA
Date: Sat, 7 Oct 2023 03:50:45 +0000
Message-ID: <5c33a957-13a6-3a2c-374c-87feb4b14bf1@fujitsu.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-52-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-52-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB8125:EE_
x-ms-office365-filtering-correlation-id: 9fcb755d-e6c4-414a-a780-08dbc6e89643
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0aNTfyzBdu8VZkitFoLoJfbUFT9f+xlWxvka01HMHVDKEIcM2vZxxoiBxGUnCmP7Ab3XZtIiLObh9AhKrsCO1gCry7Ao/xJJWxyvyaXUu3ECVlLMC1/ka7/5ORWbXODZSi0pVJrSyl7S81OZh2FV2trMuGznjbeOaPLocqdONgPA7Qhg1IK5RMEuG3KDMwp4O2YksgBqFnG4y1IgfLnV85E/bl8d77WusC+lSEaDGVtmughe6rOlXsUVcB1TEZycOqcOIbnat6Pl6E6AX8vV/6//3uiS6Hb7+TVl3iEE1iaiKk0VWYDeYd+x0kUG0s+opWjyDmED8TyQ54bD+Vd1WKbjea+NpnGojC5PsHmWENR9lVmWg/O/rX15rv3kY+D7BvOA8izTA8kDd/oBrqYfmMiXPBlM9pnbNxzGbxSGgwHV2ycx6Lg9bvH3bazvhkSRRLWAt3MpqWV6foGJO8FEF3fL4UpVRc8tLA7edf5+LcwloEe+QdQBPlzx+n7N1vN0J/g1fGO4YWFMJL5VNChyLTc56cIXIN2MWN/hiB+nXU24X9n+6IrgK5evYQRyLT/PQYwN8pAcU09Bqn32wza1O/6ANXb7hg9ogkzyDjpWF9ueZ4v7K1FzVKjmfdqlij5H/vfqm4lAgEQQS5FgzmdTl1ISD24VwzLWgGkD0EcgQN0wUoLkeZQ4nXNsxwEnnkUyFwSCz+CSM/kYWju5xdrooA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(451199024)(1590799021)(64100799003)(1800799009)(122000001)(2906002)(38100700002)(38070700005)(85182001)(36756003)(82960400001)(1580799018)(8936002)(8676002)(6506007)(478600001)(86362001)(71200400001)(5660300002)(83380400001)(41300700001)(31696002)(54906003)(91956017)(66476007)(316002)(6486002)(110136005)(66556008)(64756008)(66946007)(66446008)(76116006)(4326008)(6512007)(2616005)(31686004)(53546011)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEFMUWk1UWxZQ0JVa3h0ODUwQXJncnVrbCtRbkYrMW1mdGlFdm8wWVBxRHBR?=
 =?utf-8?B?TkZQYmY0Z2pqbUZzNVVodWo1TzhVYitCc0wwNXcreGF1bHlmMkNsWXVLWXdw?=
 =?utf-8?B?Smc0MHBkZC94MWdBUTI2Z2VzclJjYWZ5WDYrUDdWTjg4MWh1a21MRVpwQm5v?=
 =?utf-8?B?b0Rsb1pycGp3UjhoRGhlN2I4bm1LaUh5WCs4dVJtbTFkWnozRVZmWWdJNSty?=
 =?utf-8?B?cjN6NXNhd3BIU3k0RFNSdFBjTXUrN25rUWFYZUcwNXhWSUYzUmNGd20vQ3Zz?=
 =?utf-8?B?aXVKSkJSeVV1UDduY01hVlNPYjVRc2VFOVZPQks4SVVjRU5PVXV0SUwzcGFj?=
 =?utf-8?B?dlpYbkI0WStiQWk4TFByM3R6c0J0eXk1QU5JdElodVAyMHE0UnpvQVdRdm8y?=
 =?utf-8?B?dDkvWGFuVk14NXNRbmlGdHdydVJGQXBhVU1ib21LQmNreEUxTDhUd2wydDBV?=
 =?utf-8?B?bFJpS0RiRVJiWDExdXQ1aW1CdENES01jZjRxMGdtc29Db0tRK0RBYWJFR1lu?=
 =?utf-8?B?YjdsWWJnZkcrRVk5VTJpeTVkZEU3VGhaNnNxZ3NRZk40dmZ0bUo5czBTd2ZP?=
 =?utf-8?B?VCt4TWVGZlNNakk1c2FEclV6ci9pWmFUb3JQaFgva1JsbVBzN0hBTXRCUEV5?=
 =?utf-8?B?eCtUYnB3QlRTVWsxMVdmUmpNNThoZUkwSDcxVGE5MFBiZnMxREM2eHdjdHBh?=
 =?utf-8?B?OHBvd0orS3Bsci83WlhqbWJHdzAwbG53V3AxSWR2Z0NhVG5NMS9xMGtGb21X?=
 =?utf-8?B?RDlBYkVrZnRZMEkzRmdJRzBBakZMV25LdzBrQmRBSXprc2tSQjkvVW55S1ht?=
 =?utf-8?B?eFVrK1BnNU1HRFM3cWhTYU1IVFF6Nk82TFdpU1o0WjVTeUVHajRZeUZTWGNJ?=
 =?utf-8?B?dEV6aFhBKzNRYVE1akhoN081NEtlTXRNczhGY2g3cVE3Vmw1cjEyaGxyR0J2?=
 =?utf-8?B?Ujl1NmJmTnZwYUp1ZW9kVm1jK1NJMitaazg1UlRJMDhQdEpVcGxtYTV1T3Qx?=
 =?utf-8?B?WVVlQk4vc2s3aEdZRDVvK2RWalI4aW9xOEROc3BOdUVySkE2TllKTklhdUkv?=
 =?utf-8?B?L1NXVDNiOEsrYWczUENJRC9RcWZUQUdUNFhpVllGS2lPRW5YRGN2eWJTRjdi?=
 =?utf-8?B?enBwb1AxOHFCQ2hzRWp6bGVsWjVKaUZlbXlDYmNNRVBLYnhadENWd0NTNWhn?=
 =?utf-8?B?Tk1sdmwwaXM3T0xKUHZ3TDFkbmtiZWY2bFBJcnN0NU5RT3lUTGJ0NDBvY25h?=
 =?utf-8?B?aktlampuZGhWbEJndktFM2p1cmhLN2ZJSkNFMVcrN1hOZmdNTGR0SkpFc05D?=
 =?utf-8?B?V1plMTFVS0kzRGh5NkdWeEhtRXZGSFBvejVoU3BveHBsWXJOQXppYTBXN3Az?=
 =?utf-8?B?TFA5dVZHSU1JTUFta3lxdXk5SlFRd0JuMU92c0h5NkxnbWZ3aFdCZk5NaVR3?=
 =?utf-8?B?eFZwcUQrbDBibWN4Nmk1NW9KUmkzK2RhcXlRd1JwMEU2bUFDaW9TWFZSelUw?=
 =?utf-8?B?NmZZT2hNYUg3R0lLZVV3dUpKSXdBY3VoK1hSTGk2ekthK0huNkREaFh2NVNr?=
 =?utf-8?B?dUlVWjJlNWx4a3hpTjlJb2d6VHB6VWN4UFUwUDVONENjNXVaM0VwOWVQa1BM?=
 =?utf-8?B?NXhLQkNsU3JwYlU1WFl4azg1NGFvNVBxRFlLUHhzUm1sNTF6dUFOUVBxRkhz?=
 =?utf-8?B?T3BzY0Z3cWZkRU9zcDE3d0Q5L2ErQ0FoUGEzVjdSVTh2RWh0cGdrQWZJYlpF?=
 =?utf-8?B?YkpvS01STkNBdnMwenByOTRjZGIvT1lCbGJZQjhUY2hkeFJYa2ltaVNLN0xx?=
 =?utf-8?B?WmsxRDBBUHlSVWZjMUJkWW94VC9DTS82d3lTOG81ZncvMGhrZU92UVI5bFlk?=
 =?utf-8?B?OWJwemNGTVhISjBzSDVsTVJnTjRnaXAycWpOK1Fuei9INFZSTDBORVJoc2xN?=
 =?utf-8?B?UGo4TDEwVGJ5NzFzL0tZNlk0a1hURFVLQUdiUlN1TGNoWFg1L3NlTExOQ0E5?=
 =?utf-8?B?aXVUUWVyNzZXSUdmQUFmZVZkYzZjRFpYVCtQY0QydmVzeVordWJDZTQ0NDNT?=
 =?utf-8?B?TXhMSjZtTUVMbkw2ZEN1dkkwcTVxMy90SFROODVwSkhGYnozVlUrOTVJNXBl?=
 =?utf-8?B?a2t1MlFKT1RGZ1ZmeDd4N1UvSTNuS3hzTlZ1OHJrMG13MlhzY3VJZFA3Q3hp?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5978D34DA44AFF418A98F8930EE45A4A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EPPQ9zep37NA6b6lHzK0y14mr4BDFbXc+8HQPT552vdpwVQg+nNK7Y6zy//+pLGg2QFRMUHfQx9meatsxkpiHxGLhQveaICWhQj6gGHwAIWj/sFLHBiCvH4dme3oFxnaGSrYhSpsECeYiouT2e9M4gGJOOWreh4+KW4anfQYnvdqn1eUb8P9HM/Qh3539lsCk684nlzaOXyNkWMmvR8GTSGkL2ceQjBY5jIATb8nOqVMiUXn/0UXi0uX0k8F5GNL3kqhq1DmwlvxgQOo/h4TZDM3C7odPrg541HV5Z7lL0ZYBcOpY98sxFVgm11HQzhm2YyvDgz5JOqmIg0UYBkBuNSWXTs0fRRfxJRjmK95P/Tzi9odlkAgFp5l/uo3+6ZRG0A0uer7fyfarwv51flUPPWz4r0RFWJ8NHvYgP2QAdTJ07P3EG8LHNMtOa2ccjIfhp85+j9hZEXrJIKgbrcsI7k0Om/R1tBPzki5YH6WPAVg/Bk+9mkhfqBAra9EjK1vzPUmT/QxSe3P8jzezXP8pzXSEI1C1jpFaIvjAHcSPKi7rmWPmTswS/JPxniyFKP/EE+0uMxgC2f/uDAPnJQsTBZNAW7VnzmzpTiSnFkRF0Ju4mTKIaQLuM0mXH3uX+TZesk+U/dIYNN9daGPWLl08mPKbniUEL+XRsM88Coi4Z2V4p8rb4c0fN7NwMSkA1R13J1n0jeYV22v5V3KV69P+x3C2ERdfSmgU1WoNBt8EWSvMlrZL4ylB3BVpjrJaAqhgvocyhMn4GWJrKXd4lB8uVuGty9Hd+DXOf6nHUgxk61OSRR2Cl8mr3GU4ywa6rhl
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcb755d-e6c4-414a-a780-08dbc6e89643
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 03:50:45.8514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hTgzbwidMskb/PSsGVIZF2hQE6oolQgGnYZ4X+a7M2QUWTmzC2Tx5iNSMY5eHZWwaT7kyG6fU35oANRSw8unA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8125
Received-SPF: pass client-ip=68.232.159.87; envelope-from=lizhijian@fujitsu.com;
 helo=esa7.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.797,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDI4LzA5LzIwMjMgMjE6MjAsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBGdW5j
dGlvbnMgdGhhdCB1c2UgYW4gRXJyb3IgKiplcnJwIHBhcmFtZXRlciB0byByZXR1cm4gZXJyb3Jz
IHNob3VsZA0KPiBub3QgYWxzbyByZXBvcnQgdGhlbSB0byB0aGUgdXNlciwgYmVjYXVzZSByZXBv
cnRpbmcgaXMgdGhlIGNhbGxlcidzDQo+IGpvYi4gIFdoZW4gdGhlIGNhbGxlciBkb2VzLCB0aGUg
ZXJyb3IgaXMgcmVwb3J0ZWQgdHdpY2UuICBXaGVuIGl0DQo+IGRvZXNuJ3QgKGJlY2F1c2UgaXQg
cmVjb3ZlcmVkIGZyb20gdGhlIGVycm9yKSwgdGhlcmUgaXMgbm8gZXJyb3IgdG8NCj4gcmVwb3J0
LCBpLmUuIHRoZSByZXBvcnQgaXMgYm9ndXMuDQo+IA0KPiBxZW11X3JkbWFfc291cmNlX2luaXQo
KSwgcWVtdV9yZG1hX2Nvbm5lY3QoKSwNCj4gcmRtYV9zdGFydF9pbmNvbWluZ19taWdyYXRpb24o
KSwgYW5kIHJkbWFfc3RhcnRfb3V0Z29pbmdfbWlncmF0aW9uKCkNCj4gdmlvbGF0ZSB0aGlzIHBy
aW5jaXBsZTogdGhleSBjYWxsIGVycm9yX3JlcG9ydCgpIHZpYQ0KPiBxZW11X3JkbWFfY2xlYW51
cCgpLg0KPiANCj4gTW9yZW92ZXIsIHFlbXVfcmRtYV9jbGVhbnVwKCkgY2FuJ3QgZmFpbC4gIEl0
IGlzIGNhbGxlZCBvbiBlcnJvcg0KPiBwYXRocywgYW5kIFFJT0NoYW5uZWwgY2xvc2UgYW5kIGZp
bmFsaXphdGlvbi4gIEFyZSB0aGUgY29uZGl0aW9ucyBpdA0KPiByZXBvcnRzIHJlYWxseSBlcnJv
cnM/ICBJIGRvdWJ0IGl0Lg0KPiANCj4gRG93bmdyYWRlIHFlbXVfcmRtYV9jbGVhbnVwKCkncyBl
cnJvcnMgdG8gd2FybmluZ3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgQXJtYnJ1c3Rl
ciA8YXJtYnJ1QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWpp
YW5AZnVqaXRzdS5jb20+DQoNCg0KPiAtLS0NCj4gICBtaWdyYXRpb24vcmRtYS5jIHwgNCArKy0t
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vcmRtYS5jIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBp
bmRleCA0ZTRkODE4NDYwLi41NGI1OWQxMmIxIDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vcmRt
YS5jDQo+ICsrKyBiL21pZ3JhdGlvbi9yZG1hLmMNCj4gQEAgLTIzNTgsOSArMjM1OCw5IEBAIHN0
YXRpYyB2b2lkIHFlbXVfcmRtYV9jbGVhbnVwKFJETUFDb250ZXh0ICpyZG1hKQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC50eXBlID0gUkRNQV9DT05UUk9MX0VS
Uk9SLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5yZXBlYXQg
PSAxLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiAtICAg
ICAgICAgICAgZXJyb3JfcmVwb3J0KCJFYXJseSBlcnJvci4gU2VuZGluZyBlcnJvci4iKTsNCj4g
KyAgICAgICAgICAgIHdhcm5fcmVwb3J0KCJFYXJseSBlcnJvci4gU2VuZGluZyBlcnJvci4iKTsN
Cj4gICAgICAgICAgICAgICBpZiAocWVtdV9yZG1hX3Bvc3Rfc2VuZF9jb250cm9sKHJkbWEsIE5V
TEwsICZoZWFkLCAmZXJyKSA8IDApIHsNCj4gLSAgICAgICAgICAgICAgICBlcnJvcl9yZXBvcnRf
ZXJyKGVycik7DQo+ICsgICAgICAgICAgICAgICAgd2Fybl9yZXBvcnRfZXJyKGVycik7DQo+ICAg
ICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgfQ0KPiAgIA==

