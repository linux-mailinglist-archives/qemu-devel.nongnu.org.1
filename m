Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2CD7A17A1
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 09:41:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh3Rj-0003Yq-5a; Fri, 15 Sep 2023 03:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qh3Rh-0003YT-11
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:40:57 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qh3Re-0000gp-JL
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694763654; x=1726299654;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rNrexxg7hjZbYDy3u+gfnHXkNfRW6oKEsY9epdV13zU=;
 b=PoJbKGtBzlep0etja65VyQvQ0oo0SeuDNz/k+JmydYI/FN5K8C1veNAU
 4QG4ghZ7aSrgV9ZksPQcoSp8U8BZfqkpbY1H+MArvVH8urUZFIHl6GMsN
 xccb/NJt0kxDay2gohzHmxAp1AMmFRn9fiS9LsJsWRpCrnLB59kT7SInZ
 BjobIVSps9nmeWX3XRRz1QIAHrFtWjUXcCZER2KZCCBpaARAD65WuuK0a
 8WxjBdJd6EU9bDHDwnFtHzvX46H11VIlHBZaQ34EQ9MK10Bf1ffSP33Sf
 I8fayJxcZdsDm2PPf6l/D6F+YY0jOubcp1CVMDV88CBmrXGIPqmUrPQFv g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="381914872"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; d="scan'208";a="381914872"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 00:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="774210571"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; d="scan'208";a="774210571"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Sep 2023 00:40:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 00:40:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 00:40:49 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 00:40:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCStpZnFrCY60pKUNWuB8a0W1zZYbbfn0DGtuCUDLZ83nXylhPTfARv5YKvYMEQxVhnSdwwET8dFuvNG10yA1opYSbH6JZG2MVQa/KQLeTE60R/j9QzC63L/w/pvzpZbmOwwqy8NbgCzm4KDQjjoqOo7nznn5AbKNWANpH0dDQCV6JlRWHeqg/Xqrt5xVEZlu9zB3rMKAmlOsa8G0Zxq0LV4J3ZWDf1R6W6uRYcrsGxhDHel4NXkocHQHGwdD2hBVKq7CugDtMLbvi+0nFVBcywtfLIFXRu+0bzibqwZnIUVjdOSfowQiVdZHouB7Fa78gq/4TsHA/XtpS27ZbB9Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNrexxg7hjZbYDy3u+gfnHXkNfRW6oKEsY9epdV13zU=;
 b=GYIR38G8IvPuIbx8vfKkyaHvlvrM5hFMsQnGRD8B9EffbAIHIZM2bGeqsYHw5ldz4A29h1kPuxpq6gNBUBIjuzuy/Q5VgeuIGgHaRxz/suO/2g/w/4xSyC0x1qMZFYHiESgEb30A6zfuZJO8WKj+XAVgWVE+O7DGvm5ndAPCRJAO/vIV8yMknNMXWCOgtUjvsZww0TxCGvzVWgCv0bl+2c5cQ/807bFaXyeguhBA2UnJAbNhXIImXg+ZY6HNGz9RDl8evkQMjlyMVFPr0tfxyWcc2Dd6iE+EZ+1arnc5/QazSOACfITXWYe8WrvIYW/yUJReAVfNkOxMZihTEyGFmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) by
 IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 07:40:47 +0000
Received: from DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::2d97:91c5:e989:bf4d]) by DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::2d97:91c5:e989:bf4d%4]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 07:40:47 +0000
From: "Liu, Jing2" <jing2.liu@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "jing2.liu@linux.intel.com"
 <jing2.liu@linux.intel.com>, "Liu, Jing2" <jing2.liu@intel.com>
Subject: RE: [PATCH v1 0/4] Support dynamic MSI-X allocation
Thread-Topic: [PATCH v1 0/4] Support dynamic MSI-X allocation
Thread-Index: AQHZ1Mps+u6FzGlF50KgAeqXrHgz2rAbozDw
Date: Fri, 15 Sep 2023 07:40:46 +0000
Message-ID: <DS0PR11MB811432F3818402828796CC65A9F6A@DS0PR11MB8114.namprd11.prod.outlook.com>
References: <20230822072927.224803-1-jing2.liu@intel.com>
In-Reply-To: <20230822072927.224803-1-jing2.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8114:EE_|IA1PR11MB7773:EE_
x-ms-office365-filtering-correlation-id: cddf87c3-8c1b-40b1-8fdc-08dbb5bf1341
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: koKTFvRbR3qrcyDAbaRqkOAdad1Fn3/6jR3fmNnrSofpppBrjQ90vdSu3aU8sNFOOr0rZilwxuep4DMGM5RthRSyylsjVSeiBp1WWTEj9tzGW41GsRGPyTIyMKa/mzBDSSO83OrbFiFISbjyM8TCCYlNkuH7NsukVhk4k7XRCG7lbXOXb9BepOeBnBIQXgFuk04t1x+34uA4ZrPVpdHPPnq5y96fu0VvdvuXci7rf9CVD/IAXTY5BAxie5SJqD0zpStJNVXjsOfZ7KDgUt4duLBAgMwo7tHZI8Mi9Xe61VjhzIA/KO4zSfg1zRZ3oTwbHBZM3cgbTnajsvV6Jlj0fiPIgQXVIHYxv9CFHIoy0bso+cVKzrFSXjLysb00aIsclSSM2PcdOjSTcgb/oFdhAx0uSjQ3j+aCu87NVO9bulszYmctfpYJCEPtHztEh0uKs6L6is1e88vhshiCrQhrodPO34yjVk3qMgBOk0++bmfY/M7I2xMgYiqELwyhJLqs0cxQLe9GNDwg2eWz/zPbgkdGToGnvG6Uc+EzCqWtla/Q8M369G+68zM/GUoKdqgPg5rixD2w+jeD5hldwnHMwYDptFixfcIoCTdK3f9Og44=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8114.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(186009)(451199024)(1800799009)(38070700005)(38100700002)(26005)(66574015)(122000001)(966005)(478600001)(33656002)(9686003)(7696005)(82960400001)(71200400001)(53546011)(6506007)(66946007)(76116006)(54906003)(41300700001)(66446008)(6916009)(66476007)(316002)(64756008)(66556008)(83380400001)(52536014)(5660300002)(2906002)(4326008)(8936002)(8676002)(86362001)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YngxYzAzMnVqWVBNZW5hWnZpTDZ1SXhaaDhIMDlZbXU3a3cvekNsTEwzVmpo?=
 =?utf-8?B?cDJtZDBQdzdwZnpQd09VdFFFdlV1L0FITkFVcVd0eld4bnlhQnBacXlDVXdj?=
 =?utf-8?B?a3ZpU1V0UDlZU29lczNBV0Qza0ZOa3pydDdMVVhEZERPN3l3c3hoYWlrY2x3?=
 =?utf-8?B?RS9IbGJxMlQ3L0tpaldLUFB0STdKVmU3TjJFSFliNSs3OEw1bWpyU3d1SXp4?=
 =?utf-8?B?citEVkZtdVRVMHdpMm9LNUR3Z3k4em42L293M3Y1ZWoybWNHNUtrMTFIUkt5?=
 =?utf-8?B?a011eGJBallTZmYrdEplZnBpUCs2ek1uZHpCdHVDcGZnNzdGaWZBd2ZPQ1Rw?=
 =?utf-8?B?U2tiZXJoaHM0RCtGVk03Rm5Ib2lkL1lzVjJUMlUyNDhQSXZsK2xxbkhKdU95?=
 =?utf-8?B?WDd5VEFIenplMnRULzVXTUNRb1p1VDNFZ1pQaVlDYkEzbU92TXZUUE9IVGd5?=
 =?utf-8?B?em54ekZiaUdaQ1MwN2dzYW84SG5LcWtpTHlwWDRvbC93NGY0dFZRelAycVF6?=
 =?utf-8?B?TnNFRWxLN3p6QkJRUDhldDRSU0E2N21KTnJ4Vms2RHhoQS9HU2xGL1Z5bnhr?=
 =?utf-8?B?U2tiYnNUaE12cjJpUlFzRllVNjN5RjR5c1A3dzJoaTFLc0RxOGQvY3BmcXFH?=
 =?utf-8?B?MUZZOHRadHl5d2dkRmZvbEIxQndXbGwrWUV2ZW1OV3ZRcFZoblR2QUU0ZFZt?=
 =?utf-8?B?bzZ1UGpZWk54eVQvRVhZanlFU2ppaElxTGp0emdCa2pSZmFvVXRxd2xZOXZJ?=
 =?utf-8?B?cWEyZmt1RkQvNDl3YTRhMFJHRU1lVWo2TXllNDVHKzdkTzdKNGZIU1pjVGd0?=
 =?utf-8?B?c3k0aWhia0tMYmFEUFljQW9uUStycXVHQitWYm5FTlZDN1JKOElMUmwvajIv?=
 =?utf-8?B?V1c3Q3pVMjNVVlI4UFBGWTBVZENEcFM0anp4VG1GWEx4M3pXV1J5UjczQlVw?=
 =?utf-8?B?ZnZVN1dnenFiYVA3RnJiUGI3K3pxZDZ1RFp0T0ZZVlhBVDR4RVBZdFY3VU04?=
 =?utf-8?B?QzhsMnJsajAxeTJ3VHNmQjFiVzhvUXUyWE5LbVBmSGFlM0x6MFc1Y2M0dnEw?=
 =?utf-8?B?eUk1Rkoxa0xiNFdHR3JPaDR3OURTeUlRN1NBZDRQOERFWXJRN1lUSHBYV2FV?=
 =?utf-8?B?b0ZCaXFGUXYvOC8yU0VzRkM1T2ROVDBmVUhDMGpJOUVRWUViTDIxTzFVVWdG?=
 =?utf-8?B?YTNnTFl3emhLM3dNN01NK24zeDJWYW9xdnlNd2VoNTVpNEh0UFpTdk1IcThm?=
 =?utf-8?B?SVZBWXlBc1ZOUFdnWHFoOUlwNjlCWWpkRmxaaFJ5ZVdYTEVFU1RFTU8xWE9u?=
 =?utf-8?B?UVJCVGZsYU9VR3ZyZHpVNTZybENOU25vVlJQeGZ1WVNpZ2JXWlk3MXVKNmtD?=
 =?utf-8?B?WnFTL0N4VWQyTUUxTUNkODNvREszMTlPYy91ckdwTmpWTHdad2pBQjQ1R0VO?=
 =?utf-8?B?Z0U2L2c0VW5ncHRRWWFlQklsOGVxSElWcnpsK2hyUG9yRXdpQ1QxS1ZvLzJm?=
 =?utf-8?B?bjA5SER5ZVgveDgvTDBmOFVFODZ5VjloTFN4d1dVVEtmaTFZNGVURjlkZ3N3?=
 =?utf-8?B?Vm81bjhybEJ1bTF0Q25FcitoM3lzMEMvc1k4YS9IeUhjRHlGdVI3Uk1GM3ZO?=
 =?utf-8?B?MHJYMVpMc25pdU5JTzNLV1JncnBIR1hCeWx5RGN1NlhTVEYwWFg3QUtmYk45?=
 =?utf-8?B?U2Z6c2VpZ25DVlBvQ0JyMmpzNlUreWZibUo3MmtjN2owRTlhOXh1QzFCZVVp?=
 =?utf-8?B?SUhnSHVVdVduVExzc0hkMForOVI4Y1BpYmE3ZnM5V29WeWsxZUZKbzFDdEhX?=
 =?utf-8?B?WnhmaDBNL2NoL3pOQk94Z2x3V0VGWWl5MzdjbitMdWtIK0tyUGh5VEY4RCth?=
 =?utf-8?B?R1B4WHF5WW1kZGZEcFpONDBaVENKNHNQNVZsbFFDTVgzdmtXdWdBMTNwUTNJ?=
 =?utf-8?B?L0l1ZXJWaFgyMkFVSXpjTmJmVjJPaE1qM0dLeGE0M3hsVzNzcDJBcTB4dDFl?=
 =?utf-8?B?TVY3WDlXdDR6TkE0RmVSdEtHeE5EN2JUZzRydGJDQlFOTFpqS1A2czdtd3BU?=
 =?utf-8?B?TE5ZSTFKaFREa21wRDhJdTkreTJDdVJFZnpZdlZRdStOYXdEaVpPVGJQU080?=
 =?utf-8?Q?njn+1TEM111TwOjjofIZaSXUw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8114.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddf87c3-8c1b-40b1-8fdc-08dbb5bf1341
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 07:40:46.9108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AzABLNPBTzdeuSZGxWpShSaKrDRudEwmByDI9b8CJDZtSoABQmmtdrYK8iALDcwwfFIs+V95NmF1aa/WMIwVsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7773
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
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

RnJpZW5kbHkgcGluZyB0byBoYXZlIHlvdXIgdmFsdWFibGUgaW5wdXRzIGFuZCBjb21tZW50cy4g
DQpUaGFua3MgdmVyeSBtdWNoLg0KDQpCUnMsDQpKaW5nDQoNCj4gT24gOC8yMi8yMDIzIDM6Mjkg
UE0sIEppbmcgTGl1IHdyb3RlOg0KPiBDaGFuZ2VzIHNpbmNlIFJGQyB2MToNCj4gLSBSRkMgdjE6
IGh0dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20vcWVtdS0NCj4gZGV2ZWxAbm9uZ251Lm9yZy9t
c2c5Nzg2MzcuaHRtbA0KPiAtIFJldmlzZSB0aGUgY29tbWVudHMuIChBbGV4KQ0KPiAtIFJlcG9y
dCBlcnJvciBvZiBnZXR0aW5nIGlycSBpbmZvIGFuZCByZW1vdmUgdGhlIHRyYWNlIG9mIGZhaWx1
cmUNCj4gICBjYXNlLiAoQWxleCwgQ8OpZHJpYykNCj4gLSBPbmx5IHN0b3JlIGR5bmFtaWMgYWxs
b2NhdGlvbiBmbGFnIGFzIGEgYm9vbCB0eXBlIGFuZCB0ZXN0DQo+ICAgYWNjb3JkaW5nbHkuIChB
bGV4KQ0KPiAtIE1vdmUgZHluYW1pYyBhbGxvY2F0aW9uIGRldGVjdGlvbiB0byB2ZmlvX21zaXhf
ZWFybHlfc2V0dXAoKS4gKEFsZXgpDQo+IC0gQ2hhbmdlIHRoZSBjb25kaXRpb24gbG9naWMgaW4g
dmZpb19tc2l4X3ZlY3Rvcl9kb191c2UoKSB0aGF0IG1vdmluZw0KPiAgIHRoZSBkZWZlcl9rdm1f
aXJxX3JvdXRpbmcgdGVzdCBvdXQgYW5kIGNyZWF0ZSBhIGNvbW1vbiBwbGFjZSB0byB1cGRhdGUN
Cj4gICBucl92ZWN0b3JzLiAoQWxleCkNCj4gLSBDb25zb2xpZGF0ZSB0aGUgd2F5IG9mIE1TSS1Y
IGVuYWJsaW5nIGR1cmluZyBkZXZpY2UgaW5pdGlhbGl6YXRpb24gYW5kDQo+ICAgaW50ZXJydXB0
IHJlc3RvcmluZyB0aGF0IHVzZXMgZmQgPSAtMSB0cmljay4gQ3JlYXRlIGEgZnVuY3Rpb24gZG9p
bmcNCj4gICB0aGF0LiAoQWxleCkNCj4gDQo+IEJlZm9yZSBrZXJuZWwgdjYuNSwgZHluYW1pYyBh
bGxvY2F0aW9uIG9mIE1TSS1YIGludGVycnVwdHMgd2FzIG5vdCBzdXBwb3J0ZWQuDQo+IFFlbXUg
dGhlcmVmb3JlIHdoZW4gYWxsb2NhdGluZyBhIG5ldyBpbnRlcnJ1cHQsIHNob3VsZCBmaXJzdCBy
ZWxlYXNlIGFsbA0KPiBwcmV2aW91c2x5IGFsbG9jYXRlZCBpbnRlcnJ1cHRzIChpbmNsdWRpbmcg
ZGlzYWJsZSBvZiBNU0ktWCkgYW5kIHJlLWFsbG9jYXRlIGFsbA0KPiBpbnRlcnJ1cHRzIHRoYXQg
aW5jbHVkZXMgdGhlIG5ldyBvbmUuDQo+IA0KPiBUaGUga2VybmVsIHNlcmllcyBbMV0gYWRkcyB0
aGUgc3VwcG9ydCBvZiBkeW5hbWljIE1TSS1YIGFsbG9jYXRpb24gdG8gdmZpby1wY2kNCj4gYW5k
IHVzZXMgdGhlIGV4aXN0aW5nIGZsYWcgVkZJT19JUlFfSU5GT19OT1JFU0laRSB0byBndWlkZSB1
c2VyIHNwYWNlLCB0aGF0DQo+IHdoZW4gZHluYW1pYyBNU0ktWCBpcyBzdXBwb3J0ZWQgdGhlIGZs
YWcgaXMgY2xlYXJlZC4NCj4gDQo+IFRoaXMgc2VyaWVzIG1ha2VzIHRoZSBiZWhhdmlvciBmb3Ig
VkZJTyBQQ0kgZGV2aWNlcyB3aGVuIGR5bmFtaWMgTVNJLVgNCj4gYWxsb2NhdGlvbiBpcyBzdXBw
b3J0ZWQuIFdoZW4gZ3Vlc3QgdW5tYXNrcyBhbiBpbnRlcnJ1cHQsIFFlbXUgY2FuIGRpcmVjdGx5
DQo+IGFsbG9jYXRlIGFuIGludGVycnVwdCBvbiBob3N0IGZvciB0aGlzIGFuZCBoYXMgbm90aGlu
ZyB0byBkbyB3aXRoIHRoZSBwcmV2aW91c2x5DQo+IGFsbG9jYXRlZCBvbmVzLiBUaGVyZWZvcmUs
IGhvc3Qgb25seSBhbGxvY2F0ZXMgaW50ZXJydXB0cyBmb3IgdGhvc2UgdW5tYXNrZWQNCj4gKGVu
YWJsZWQpIGludGVycnVwdHMgaW5zaWRlIGd1ZXN0IHdoZW4gZHluYW1pYyBNU0ktWCBhbGxvY2F0
aW9uIGlzIHN1cHBvcnRlZCBieQ0KPiBkZXZpY2UuDQo+IA0KPiBXaGVuIGd1ZXN0cyBlbmFibGUg
TVNJLVggd2l0aCBhbGwgb2YgdGhlIHZlY3RvcnMgbWFza2VkLCBRZW11IG5lZWQgbWF0Y2ggdGhl
DQo+IHN0YXRlIHRvIGVuYWJsZSBNU0ktWCB3aXRoIG5vIHZlY3RvciBlbmFibGVkLiBEdXJpbmcg
bWlncmF0aW9uIHJlc3RvcmUsIFFlbXUNCj4gYWxzbyBuZWVkIGVuYWJsZSBNU0ktWCBmaXJzdCBp
biBkeW5hbWljIGFsbG9jYXRpb24gbW9kZSwgdG8gYXZvaWQgdGhlIGd1ZXN0DQo+IHVudXNlZCB2
ZWN0b3JzIGJlaW5nIGFsbG9jYXRlZCBvbiBob3N0LiBUbyBjb25zb2xpZGF0ZSB0aGVtLCB3ZSB1
c2UgdmVjdG9yIDANCj4gd2l0aCBhbiBpbnZhbGlkIGZkIHRvIGdldCBNU0ktWCBlbmFibGVkIGFu
ZCBjcmVhdGUgYSBjb21tb24gZnVuY3Rpb24gZm9yIHRoaXMuDQo+IFRoaXMgaXMgY2xlYW5lciB0
aGFuIHNldHRpbmcgdXNlcnNwYWNlIHRyaWdnZXJpbmcgYW5kIGltbWVkaWF0ZWx5IHJlbGVhc2Uu
DQo+IA0KPiBBbnkgZmVlZGJhY2sgaXMgYXBwcmVjaWF0ZWQuDQo+IA0KPiBKaW5nDQo+IA0KPiBb
MV0gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzkzMTY3OS8NCj4gDQo+IEppbmcgTGl1ICg0KToN
Cj4gICB2ZmlvL3BjaTogZGV0ZWN0IHRoZSBzdXBwb3J0IG9mIGR5bmFtaWMgTVNJLVggYWxsb2Nh
dGlvbg0KPiAgIHZmaW8vcGNpOiBlbmFibGUgdmVjdG9yIG9uIGR5bmFtaWMgTVNJLVggYWxsb2Nh
dGlvbg0KPiAgIHZmaW8vcGNpOiB1c2UgYW4gaW52YWxpZCBmZCB0byBlbmFibGUgTVNJLVgNCj4g
ICB2ZmlvL3BjaTogZW5hYmxlIE1TSS1YIGluIGludGVycnVwdCByZXN0b3Jpbmcgb24gZHluYW1p
YyBhbGxvY2F0aW9uDQo+IA0KPiAgaHcvdmZpby9wY2kuYyAgICAgICAgfCAxMjYgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgaHcvdmZpby9wY2kuaCAgICAg
ICAgfCAgIDEgKw0KPiAgaHcvdmZpby90cmFjZS1ldmVudHMgfCAgIDIgKy0NCj4gIDMgZmlsZXMg
Y2hhbmdlZCwgMTAxIGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQ0KPiANCj4gLS0NCj4g
Mi4yNy4wDQoNCg==

