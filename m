Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 059CD7DB219
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 03:41:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxICe-00018M-Tf; Sun, 29 Oct 2023 22:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxICb-00018B-Au
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 22:40:29 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxICX-0000Hp-TN
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 22:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698633625; x=1730169625;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aUwyADJKMSXnGDg4QqZx+bOXNorA+45etQ+lGB+kCZs=;
 b=Ji+chVD255BaPanLap8DvI9IUj3b5Dco25Dl36QY7jgHh8ebchKg0iTc
 j1MzpcrpbKp75SLulqEx/51u1Wxz5LqJNbCmTw+XGrbxg4EpxVWZOR5RJ
 fJhyYHnxKZ9gOwS/dw+0a4yy5TJx5bb3Im8fOo3kBbVzYeFWsJGBqLz/x
 3YXnvwWrmXXGJkWW60y9gfiPseVhr2BEjwPGnHKH9/S/prAMxTPbRp4EA
 DYAPTLCuxPBryzHuCj1Gs+FTez0//HRk4ZMOJiY3TM4XwUO/1IX+zeyeV
 lU+OrOy51Ksphxyy0+AHJPxeI81MnDTlxvhgkK5/fKblVHANj0vUWdtD5 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="367346227"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; d="scan'208";a="367346227"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2023 19:40:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="1091485934"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; d="scan'208";a="1091485934"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Oct 2023 19:40:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 29 Oct 2023 19:40:19 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 29 Oct 2023 19:40:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 29 Oct 2023 19:40:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 29 Oct 2023 19:40:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzXGE782rFtckxsTDHX+Nmkq5Bj9ziowp/rJuWP6J5DjdgTE3ONXzXBiz3lfrN2IEclMdT2MK+whZJIsaZdIbZDLc735PjHCYItyoBmuswgOAjzGBEcXOoATEZ3Rwzzm7e1B8OKWNcAiftbG1h6vCqEpbeuC6ZYm7OvVIQVoJXU+uoJW0c9RiXq8Z+dtcE7M8pVQqLpvcgSnoK7tEdiK69LhidFT73R5F09DFSJ3hTqXneZVENB3cj0f/07NOO2YElyYIIq5e5wvta2bqseX+i5CwGVC3I1rscl99xVEoTYXVXQgU1PAO5kkIv7lMeTwaLsHlm1NjUkpfSIKScKsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUwyADJKMSXnGDg4QqZx+bOXNorA+45etQ+lGB+kCZs=;
 b=EIFAkXdJH2JybLQrioZRFB9pTyQAf3pyuj7+62WaQ5S/05iVwpYUMR5wwsxaDjQLJF/G911X6NhTbf7ujznvVaBdErG09+k0J4bT+i92pf98hH/K4tsUiMVb1A4DaXWZbYSgeR7kSaQsjkQNoTGP5zkUrDOYF1W4ZQNGt5OLw1yB1bV7e8Qz/+S0od5KfnfdFl4bPmlQo97XHrZdtHBYusB686zeAQc+Dw8k51qbvyU2HnvqGp7GVvQyXuMZtjFPCNstrlQ+4wk65rYyUxLM7EzlGgu3BfrLlIc5d2EHv5xeSwU/GHUjdjUTIDavR4aLOgcy+50oPx1BMRqbLJrocQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB7743.namprd11.prod.outlook.com (2603:10b6:208:401::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 02:40:14 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6933.024; Mon, 30 Oct 2023
 02:40:14 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v3 06/37] vfio: Introduce base object for VFIOContainer
 and targetted interface
Thread-Topic: [PATCH v3 06/37] vfio: Introduce base object for VFIOContainer
 and targetted interface
Thread-Index: AQHaB/m3gpleJSsOKU6iHbNcrj6sm7BdrIYAgAPuq5A=
Date: Mon, 30 Oct 2023 02:40:14 +0000
Message-ID: <SJ0PR11MB6744416314994A2AAA69D2B092A1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-7-zhenzhong.duan@intel.com>
 <77cb4375-beb8-4d6e-ba9f-304d357e7e67@redhat.com>
In-Reply-To: <77cb4375-beb8-4d6e-ba9f-304d357e7e67@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB7743:EE_
x-ms-office365-filtering-correlation-id: fdf67ab7-c61e-4d38-0985-08dbd8f18b6a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKDMv2TFtb+0FONQfWwppkArbZr3Uyn/nHyX/gRgFklFNx1tqY5ZpEMoqAWIME1GhN4d6MunpFcbGfeQdYKt7AJOZpoMouoqiW49izA97uxkwzZxCfQ3stFB5Ukr2r7/sq9wKDwvOr64Y9eGBowtAgN2m2mWjChvdAfcqL55xEqsDbj2n8XtvtMaECvohIK88FZ37ZSwnLlijTStsQpbRxsDTuIImLTzCTaOGhQKE7msZMYkYyK0H6NabCBYtIdINTH1voOeKCtiSjc3Yh2ro7cwMdQWiuuJu6baVTJ+yYIBI2fWQxv/NsEbWZ4LjG6y0RPjnJMneQYJJavwLoEtWnsyQ7RzkGYUFCC6AZQ7+QYjuUgB1UXTQ4QK0CSQGu7bPkUVN+Zdh2IihIlJ649zNkzs/ewFo4IexfpMDJZOzbD3l+D3moICxzXMO17lPcXXMLSPMjTl8r107I0red8PGuwOqsLUrIAFxrrEW2RHxldiDo5tg0ZVC8kVaU+HbnWx9s9vQAdfo6uMhRiXLNV0s+s6G35ed/MnstliC6LquHWeW1p61yPA3e3DeYCOWJXhgo2Tkb7/1mLPjlUetqmHAWVnx+I7sPhXSGafnSg3NzeGNA5G3xe1wxUEMN5MAUDV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(55016003)(9686003)(26005)(478600001)(7696005)(71200400001)(6506007)(66574015)(7416002)(2906002)(83380400001)(41300700001)(66556008)(110136005)(66946007)(5660300002)(76116006)(66476007)(8936002)(66446008)(52536014)(4326008)(8676002)(316002)(54906003)(64756008)(38070700009)(38100700002)(82960400001)(122000001)(86362001)(33656002)(2004002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDdmbWQ5ay90OUpqcHVwdnlBWnlDWWh6dFpxakZYMUlqQ214ZmNpeGtqNjVU?=
 =?utf-8?B?Wkx0cDUrQTdzUzFSOHpxb2xKT0x0U1Y4dHUwVzJYVUdBeVZxTnpsV0MzYjJj?=
 =?utf-8?B?Y2k1N1QyYWt1QjU1OXFVV2duMFo5NytOY3ZaeUhCTkZEZDV5dGRIVTBiNzRl?=
 =?utf-8?B?QU1jUHJMOEJaQTJTV21pdGlvTEVPeWFzWUNGTlVmUHRZc01qR2M0RlNLZWg1?=
 =?utf-8?B?cjFpMlJNV3lmcVVtZUUvcDBBMWpFUm0zMS9CRngyVm1SVUZUd2ZBVnBSLzNR?=
 =?utf-8?B?emV1VVUvN1BFTVkyOEx4MWhZTVo5VjYwanRxKzhzelVaeWRLL2RkMnpSMzNB?=
 =?utf-8?B?WUJqdlVSZ2x3cFZKdmszVFBJREp1Ukpqd2pjQ3ZTUzl3dzIxbzlYZ2orN0w5?=
 =?utf-8?B?N25STHZyZ1lXblJXWHh5cWZMMTdacXQ0cW9UUTdHWFJvb2duMXdkUXltNXJ2?=
 =?utf-8?B?YUh3ZTZNalc0OVRub2NrcjhjWFBiYW1ZcG1wL3NDSkt2WkVPS3pEV0FPeVN3?=
 =?utf-8?B?RmUrbVc0VlpyVCtrMjZhMkM2bDBuRWxuMGpCcUNiUXlYZ1k4TTRLSm9oZ20z?=
 =?utf-8?B?REg1OE54SSsxL3FaNUpnKzgzbEZUSHlMM3VhZzI5SE1oQ1lWOElNNmRoN1Bl?=
 =?utf-8?B?SExxRytjS0NtbHRUUVFuS0VMK2xTejFXdm5qdTBENzRvZUp4WDlqNUh6YU95?=
 =?utf-8?B?ZTVxTlFKWnJTN21mUkpQZjVNRlFTaGNWU01EVFU0c3FpKzI0Uy9RQ3pIalky?=
 =?utf-8?B?dm9qaFRBakhjTVRMYy8vU0dTU09RUEJOOGdaRC9mdEEvSTNOOHR4SmNvTUJ4?=
 =?utf-8?B?SFp0a3RLTjl1NisvUjJFZklSYVpsSlRhMndOTGVmYit0MHRhS1M1T0xSQlJI?=
 =?utf-8?B?RXB2TVdvSWdHYmZWZGxGT3AvZFVOeGZhcUZic2gxc2VpU1dKTUpKK1FtVUlZ?=
 =?utf-8?B?K1czY0U0RWdwRVNNV3kxTHJTWHVJZHJvMUlhaWZSSG1WZjdDY2FoNjFucGhG?=
 =?utf-8?B?NlI2cy9WdVZlMWtoaXFuWVZRQkRqQm5OdU9jRDRGcmVtM01RV01BdmlsdmtY?=
 =?utf-8?B?TFo0eElPcmR5cGpvMXIzaGNDSUcwU0dZZFhpaXZ1UnIwTG9sMnIranNZTFpH?=
 =?utf-8?B?dFp0dy9MbHkxYjJMT0RXQjJUTUVXMWRJL2s3d2krV2tZc0lCRWhiTmNkb3Z3?=
 =?utf-8?B?VlNpam1xRTFQT2ZqcGVISHJoQWltY1dNV3BBcEJFUTVtQW9oaEpleUh3WGRK?=
 =?utf-8?B?ZENLbkdHaTJWS2JUSzVMUW9mTytEN0I1M0pRblZBUys0cHJlQWxVRFdmakpG?=
 =?utf-8?B?dDlqLzdOVTB6SU9QYzZXSzdJU3JFRzhURVd6M0NwUTh0V21sZ0w0ZXkvQ211?=
 =?utf-8?B?THFjelBmN1YzRXZlWnJUTzAxL1N6T1dhNEF2ekZwRk9Jb2ZQcmt1eDE0Y21l?=
 =?utf-8?B?TzJ2ZGtkSGw1MCt3UjJwUWZ0aDM2eDY5NmdPYldNUm96alcwV3o3dW9HemJ3?=
 =?utf-8?B?VXhuMlZibXRrVWhFNDNWMUhJRG9GcXJQNkFSOVo1SmFYMG8vOGJWdG5CdkJx?=
 =?utf-8?B?Z0xlWDhCYWZGb00ycmFhazlZOXZpQkV2RzNJNDRUeXBVa2VpejRScnd0ZVE5?=
 =?utf-8?B?R3pZV1NIK3NnU1FNL1AwakUyNVJrbjZjL1l6Qm55ZjJ5QW5nVFREZXBobmxh?=
 =?utf-8?B?bjJPdU1qR25zTjU5aWdFV2ovS3dLenI2eGs4VE1CVlJyRy9BTDgzSmtFdzJv?=
 =?utf-8?B?RDkzempxak82RlgzNHNHR0JyVmx6UU05d2JOU3p6Umk4dlNqZS9FNVJzTjRB?=
 =?utf-8?B?UUlZY1hGUXNBR1pPR0ZaYTdrQkNYTnM0Y1UxOGY0bFFiSExWU1N6cWFMQUh1?=
 =?utf-8?B?UEV1R1JiRDZoZzg4NlFXSG5ldnNNeUZoMHFIRmhoUUNNWnNKcnZ6WHNzb25X?=
 =?utf-8?B?aGhyUVNmYjBmVEd6cnBCTkNBMU5JcC9haml2Zk1NNldsaE92bGpSNzFKbDNt?=
 =?utf-8?B?S1g4SWhCaEVGTC9sY0ZwaGJQUDI4bnFGVW5aN0I3ZHlYeFFEVWdSV2x6NVNR?=
 =?utf-8?B?L2lwQllXQ1BoTFdJL1AxejUrOHUyYUFHZnIwQk9CRFNHOXJUSjdzRm0xbXlt?=
 =?utf-8?Q?qGl+9qv4z8Ork4ALdkCNE5h3R?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf67ab7-c61e-4d38-0985-08dbd8f18b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 02:40:14.0525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9cfoIxTlj8vzvmNgKISW0DEX0XVzjElnF3OexV+iJrvpPfqbvd6ee4X/zBht5ihe1TbUFzxFwycbYwBqsWL6Hx1hF5ZG4itZ+fexcPDzt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7743
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIE9jdG9iZXIgMjcsIDIwMjMgMTA6MDMg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDA2LzM3XSB2ZmlvOiBJbnRyb2R1Y2UgYmFzZSBv
YmplY3QgZm9yIFZGSU9Db250YWluZXIgYW5kDQo+dGFyZ2V0dGVkIGludGVyZmFjZQ0KPg0KPk9u
IDEwLzI2LzIzIDEyOjMwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEludHJvZHVjZSBhIGR1
bWIgVkZJT0NvbnRhaW5lciBiYXNlIG9iamVjdCBhbmQgaXRzIHRhcmdldHRlZCBpbnRlcmZhY2Uu
DQo+DQo+dGFyZ2V0ZWQNCg0KV2lsbCBmaXguDQoNCj4NCj4NCj4+IFRoaXMgaXMgd2lsbGluZ2x5
IG5vdCBhIFFPTSBvYmplY3QgYmVjYXVzZSB3ZSBkb24ndCB3YW50IGl0IHRvIGJlDQo+PiB2aXNp
YmxlIGZyb20gdGhlIHVzZXIgaW50ZXJmYWNlLiAgVGhlIFZGSU9Db250YWluZXIgd2lsbCBiZSBz
bW9vdGhseQ0KPj4gcG9wdWxhdGVkIGluIHN1YnNlcXVlbnQgcGF0Y2hlcyBhcyB3ZWxsIGFzIGlu
dGVyZmFjZXMuDQo+Pg0KPj4gTm8gZnVjbnRpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4gU2ln
bmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpo
ZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaW5j
bHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggICAgICAgICB8ICA4ICstLS0NCj4+ICAgaW5jbHVk
ZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaCB8IDY0ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDY2IGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250
YWluZXItYmFzZS5oDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNv
bW1vbi5oIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+IGluZGV4IGI5YzdhN2U1
ODguLmQ4ZjI5M2NiNTcgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21t
b24uaA0KPj4gKysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+IEBAIC0zMCw2
ICszMCw3IEBADQo+PiAgICNpbmNsdWRlIDxsaW51eC92ZmlvLmg+DQo+PiAgICNlbmRpZg0KPj4g
ICAjaW5jbHVkZSAic3lzZW11L3N5c2VtdS5oIg0KPj4gKyNpbmNsdWRlICJody92ZmlvL3ZmaW8t
Y29udGFpbmVyLWJhc2UuaCINCj4+DQo+PiAgICNkZWZpbmUgVkZJT19NU0dfUFJFRklYICJ2Zmlv
ICVzOiAiDQo+Pg0KPj4gQEAgLTgxLDYgKzgyLDcgQEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0FkZHJl
c3NTcGFjZSB7DQo+PiAgIHN0cnVjdCBWRklPR3JvdXA7DQo+Pg0KPj4gICB0eXBlZGVmIHN0cnVj
dCBWRklPQ29udGFpbmVyIHsNCj4+ICsgICAgVkZJT0NvbnRhaW5lckJhc2UgYmNvbnRhaW5lcjsN
Cj4+ICAgICAgIFZGSU9BZGRyZXNzU3BhY2UgKnNwYWNlOw0KPj4gICAgICAgaW50IGZkOyAvKiAv
ZGV2L3ZmaW8vdmZpbywgZW1wb3dlcmVkIGJ5IHRoZSBhdHRhY2hlZCBncm91cHMgKi8NCj4+ICAg
ICAgIE1lbW9yeUxpc3RlbmVyIGxpc3RlbmVyOw0KPj4gQEAgLTIwMSwxMiArMjAzLDYgQEAgdHlw
ZWRlZiBzdHJ1Y3QgVkZJT0Rpc3BsYXkgew0KPj4gICAgICAgfSBkbWFidWY7DQo+PiAgIH0gVkZJ
T0Rpc3BsYXk7DQo+Pg0KPj4gLXR5cGVkZWYgc3RydWN0IHsNCj4+IC0gICAgdW5zaWduZWQgbG9u
ZyAqYml0bWFwOw0KPj4gLSAgICBod2FkZHIgc2l6ZTsNCj4+IC0gICAgaHdhZGRyIHBhZ2VzOw0K
Pj4gLX0gVkZJT0JpdG1hcDsNCj4+IC0NCj4+ICAgVkZJT0FkZHJlc3NTcGFjZSAqdmZpb19nZXRf
YWRkcmVzc19zcGFjZShBZGRyZXNzU3BhY2UgKmFzKTsNCj4+ICAgdm9pZCB2ZmlvX3B1dF9hZGRy
ZXNzX3NwYWNlKFZGSU9BZGRyZXNzU3BhY2UgKnNwYWNlKTsNCj4+ICAgYm9vbCB2ZmlvX2Rldmlj
ZXNfYWxsX3J1bm5pbmdfYW5kX3NhdmluZyhWRklPQ29udGFpbmVyICpjb250YWluZXIpOw0KPj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmggYi9pbmNs
dWRlL2h3L3ZmaW8vdmZpby0NCj5jb250YWluZXItYmFzZS5oDQo+PiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMC4uNWJlY2JkNTFhNw0KPj4gLS0tIC9kZXYvbnVsbA0K
Pj4gKysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPj4gQEAgLTAs
MCArMSw2NCBAQA0KPj4gKy8qDQo+PiArICogVkZJTyBCQVNFIENPTlRBSU5FUg0KPj4gKyAqDQo+
PiArICogQ29weXJpZ2h0IChDKSAyMDIzIEludGVsIENvcnBvcmF0aW9uLg0KPj4gKyAqIENvcHly
aWdodCBSZWQgSGF0LCBJbmMuIDIwMjMNCj4+ICsgKg0KPj4gKyAqIEF1dGhvcnM6IFlpIExpdSA8
eWkubC5saXVAaW50ZWwuY29tPg0KPj4gKyAqICAgICAgICAgIEVyaWMgQXVnZXIgPGVyaWMuYXVn
ZXJAcmVkaGF0LmNvbT4NCj4+ICsgKg0KPj4gKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3
YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQo+PiArICogaXQgdW5k
ZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNo
ZWQgYnkNCj4+ICsgKiB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lv
biAyIG9mIHRoZSBMaWNlbnNlLCBvcg0KPj4gKyAqIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVy
IHZlcnNpb24uDQo+PiArDQo+PiArICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRo
ZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsDQo+PiArICogYnV0IFdJVEhPVVQgQU5ZIFdB
UlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YNCj4+ICsgKiBNRVJD
SEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhl
DQo+PiArICogR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4NCj4+
ICsNCj4+ICsgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZw0KPj4gKyAqIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBu
b3QsIHNlZSA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uDQo+DQo+VGhpcyBzaG91bGQg
YmUgZW5vdWdoIDoNCj4NCj4gICBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1s
YXRlcg0KDQpXaWxsIGRvLg0KDQo+DQo+PiArICovDQo+PiArDQo+PiArI2lmbmRlZiBIV19WRklP
X1ZGSU9fQkFTRV9DT05UQUlORVJfSA0KPj4gKyNkZWZpbmUgSFdfVkZJT19WRklPX0JBU0VfQ09O
VEFJTkVSX0gNCj4NCj5IV19WRklPX1ZGSU9fQ09OVEFJTkVSX0JBU0VfSA0KPg0KPj4gKw0KPj4g
KyNpbmNsdWRlICJleGVjL21lbW9yeS5oIg0KPj4gKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQ0K
Pj4gKyNpbmNsdWRlICJleGVjL2h3YWRkci5oIg0KPj4gKyNlbmRpZg0KPg0KPmluY2x1ZGluZyAi
ZXhlYy9tZW1vcnkuaCIgc2hvdWxkIGJlIGVub3VnaC4NCg0KV2lsbCBkby4NCg0KPg0KPg0KPj4g
Kw0KPj4gK3R5cGVkZWYgc3RydWN0IFZGSU9EZXZpY2UgVkZJT0RldmljZTsNCj4+ICt0eXBlZGVm
IHN0cnVjdCBWRklPSU9NTVVPcHMgVkZJT0lPTU1VT3BzOw0KPj4gKw0KPj4gK3R5cGVkZWYgc3Ry
dWN0IHsNCj4+ICsgICAgdW5zaWduZWQgbG9uZyAqYml0bWFwOw0KPj4gKyAgICBod2FkZHIgc2l6
ZTsNCj4+ICsgICAgaHdhZGRyIHBhZ2VzOw0KPj4gK30gVkZJT0JpdG1hcDsNCj4+ICsNCj4+ICsv
Kg0KPj4gKyAqIFRoaXMgaXMgdGhlIGJhc2Ugb2JqZWN0IGZvciB2ZmlvIGNvbnRhaW5lciBiYWNr
ZW5kcw0KPj4gKyAqLw0KPj4gK3R5cGVkZWYgc3RydWN0IFZGSU9Db250YWluZXJCYXNlIHsNCj4+
ICsgICAgY29uc3QgVkZJT0lPTU1VT3BzICpvcHM7DQo+PiArfSBWRklPQ29udGFpbmVyQmFzZTsN
Cj4+ICsNCj4+ICtzdHJ1Y3QgVkZJT0lPTU1VT3BzIHsNCj4+ICsgICAgLyogYmFzaWMgZmVhdHVy
ZSAqLw0KPj4gKyAgICBpbnQgKCpkbWFfbWFwKShWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5l
ciwNCj4+ICsgICAgICAgICAgICAgICAgICAgaHdhZGRyIGlvdmEsIHJhbV9hZGRyX3Qgc2l6ZSwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgdm9pZCAqdmFkZHIsIGJvb2wgcmVhZG9ubHkpOw0KPj4g
KyAgICBpbnQgKCpkbWFfdW5tYXApKFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBpb3ZhLCByYW1fYWRkcl90IHNpemUsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgSU9NTVVUTEJFbnRyeSAqaW90bGIpOw0KPg0KPkNvdWxkIHRo
ZSBWRklPQ29udGFpbmVyQmFzZSAqcGFyYW1ldGVyIGJlIGNvbnN0ID8NCg0KWWVzLCBWRklPQ29u
dGFpbmVyQmFzZSBpcyBub3QgY2hhbmdlZCBieSBkbWFfdW5tYXAgYW5kIG90aGVyDQpmdW5jdGlv
bnMgZG1hX3VubWFwIGNhbGxzLiBJIHRyaWVkIGFuZCBmb3VuZCBtYWtpbmcgaXQgY29uc3QgaGVy
ZQ0Kd291bGQgaW1wYWN0IGFsbCBmdW5jdGlvbnMgaXQgY2FsbGVkIHdpdGggc2FtZSBwYXJhbWV0
ZXIgYmUgY29uc3QNCmluIGZvbGxvd2luZyBwYXRjaGVzIHdoaWNoIGxvb2tzIHVucmVsYXRlZCB0
byB0aGUgcGF0Y2ggaXRzZWxmDQp0byBhdm9pZCBjb21waWxlIGVycm9yLg0KDQpFLmcuIGJlbG93
IGZ1bmN0aW9ucyBhcmUgaW1wYWN0ZWQsDQp2ZmlvX2RldmljZXNfYWxsX3J1bm5pbmdfYW5kX21p
Z19hY3RpdmUNCnZmaW9fZGV2aWNlc19hbGxfZGV2aWNlX2RpcnR5X3RyYWNraW5nDQp2ZmlvX2Rl
dmljZXNfcXVlcnlfZGlydHlfYml0bWFwDQp2ZmlvX2NvbnRhaW5lcl9xdWVyeV9kaXJ0eV9iaXRt
YXANCnZmaW9fbGVnYWN5X3F1ZXJ5X2RpcnR5X2JpdG1hcA0KDQpUbyBtYWtlIGZvbGxvd2luZyBw
YXRjaGVzIGNsZWFuZXIgdG8gcmV2aWV3LCBJIHdvdWxkIGxpa2UgdG8ga2VlcA0KY3VycmVudCBj
b2RlIGV4Y2VwdCB5b3Ugb3Igb3RoZXJzIGhhdmUgYSBzdHJvbmcgb3Bpbmlvbi4NCkFub3RoZXIg
Y2hvaWNlIEkgY2FuIHRoaW5rIG9mIGlzIHRvIGFkZCBjb25zdCB0byBhbGwgaW1wYWN0IGZ1bmN0
aW9ucw0KaW4gYSBzZXBhcmF0ZSBwYXRjaC4NCg0KPg0KPj4gKyAgICBpbnQgKCphdHRhY2hfZGV2
aWNlKShjaGFyICpuYW1lLCBWRklPRGV2aWNlICp2YmFzZWRldiwNCj4NCj5jb250IGNoYXIgKm5h
bWUgID8NCg0KWWVzLCB3aWxsIGZpeC4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPlRoZSBy
ZXN0IGxvb2tzIGdvb2QgdG8gbWUuDQo+DQo+VGhhbmtzDQo+DQo+Qy4NCj4NCj4NCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgQWRkcmVzc1NwYWNlICphcywgRXJyb3IgKiplcnJwKTsNCj4+
ICsgICAgdm9pZCAoKmRldGFjaF9kZXZpY2UpKFZGSU9EZXZpY2UgKnZiYXNlZGV2KTsNCj4+ICsg
ICAgLyogbWlncmF0aW9uIGZlYXR1cmUgKi8NCj4+ICsgICAgaW50ICgqc2V0X2RpcnR5X3BhZ2Vf
dHJhY2tpbmcpKFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyLCBib29sIHN0YXJ0KTsNCj4+
ICsgICAgaW50ICgqcXVlcnlfZGlydHlfYml0bWFwKShWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRh
aW5lciwgVkZJT0JpdG1hcA0KPip2Ym1hcCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBod2FkZHIgaW92YSwgaHdhZGRyIHNpemUpOw0KPj4gK307DQo+PiArI2VuZGlmIC8qIEhX
X1ZGSU9fVkZJT19CQVNFX0NPTlRBSU5FUl9IICovDQoNCg==

