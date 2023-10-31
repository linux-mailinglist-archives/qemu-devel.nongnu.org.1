Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5897DCB2C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 11:53:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxmMp-00041P-MG; Tue, 31 Oct 2023 06:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxmMn-00040i-5K
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:53:01 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxmMk-0002V2-VS
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698749579; x=1730285579;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RH+ThCM85wAhryIccwKiPNaMKTYAoGfW1aYEzQ5kDH0=;
 b=HNuHA2tDILJLv6FyIdXo8mnjCLSSnoBfzc+y6eXW834/vi5AyVlhTGsR
 tTo/P1UXmZxOzpHAvAaii06tkZckKv17bOvDHE4O0fnicVKF1GIxFcSs+
 Q0Rq7GuRg50pHDCP7gh9cjk8vuJX0lz5rHQDpicWa9KroHP3p9/YfldLL
 3Xe3+OkSZkOA89LG/nFC3xpiQ2ak2dNcgucgU9RetwVjRFBWU3bv5IzqA
 hFIjx7m4FSzQMw/BKqWwGu0HyjTFMMZywZhsv7FcD++1OFuHOE/kDNft+
 Pnl/SKXIH9wfH8AM6H1rpnFbiZqqFqZV+S6fRKjKI/hjG6NU9ZBKG9I9Z A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="368468507"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; d="scan'208";a="368468507"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2023 03:52:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="826372349"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; d="scan'208";a="826372349"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 31 Oct 2023 03:52:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 03:52:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 03:52:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 03:52:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZIe4hyGiJE3WmJd7TMnQUGNQr3jWIU0cHDQ6XuIW76UGWrQ4EijgCB6TbH+YQsJ3HZe6dhvhc8L6jFUfUgfuLx6MZkAUh/n4sINMYVXs9hC8O0gA+Co6l9VFCzF1pSsrJTzlwsVCErE87p4vFZAhiWeiLxlQNXOJcXJccUk6f3JFS7GPF/srs/r0Cjrju20KBjaMaDWk583iUwgURMU2Cqz3iFFrrGpWcJLI8PTLhSEqZOLJcpDGlUFGmrgUZ4r5CEQkssgvMsusVuYI0fa1lnZVuSzNFm1W6cK3Ito+pJAQ1Xgk3gCWo1TQxycrNXhJ/wvVpbrDBoQT3B0KEPNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RH+ThCM85wAhryIccwKiPNaMKTYAoGfW1aYEzQ5kDH0=;
 b=VtmqwKr2RuUw1h8UddNKSOhOFmFGHpWNti4Vt1HF9zdr7JtVLlCTA5mxKiv3f8mzzCMQ2HgVzqvmGaGdnve8K4899wvbvZWPZI82uxdse6NQkgMEPrEGaxxIFUbXKR/4GmcZh1fhGAwpbMLB7k0kcb8EqLy1u2HqdyHc+BRdhlPN0dhzFygwL26mJRGqWD/djdUrDsj348L2U81gkCk2eJS/CwcuWwW6Mygan1wO3WWrJPknDx7bDrS2mXbiQkywUESruVj19VWqS1m228h9o3AIhpdSaTPxCexhG+pysuLGop/c1HU1T51i5BnbLdWw9rJAitHEhOVQLUX5C3LPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM8PR11MB5606.namprd11.prod.outlook.com (2603:10b6:8:3c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 10:52:45 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 10:52:45 +0000
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
 <pbonzini@redhat.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: RE: [PATCH v3 23/37] Add iommufd configure option
Thread-Topic: [PATCH v3 23/37] Add iommufd configure option
Thread-Index: AQHaB/neVoQG9JjiXEaDeKcK7L7ymrBjoPgAgAAeaaA=
Date: Tue, 31 Oct 2023 10:52:45 +0000
Message-ID: <SJ0PR11MB67443A43303B9A570DFB216A92A0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-24-zhenzhong.duan@intel.com>
 <2400c9be-8c0b-415f-90c5-3a04fbdf6744@redhat.com>
In-Reply-To: <2400c9be-8c0b-415f-90c5-3a04fbdf6744@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM8PR11MB5606:EE_
x-ms-office365-filtering-correlation-id: 2751647d-9562-43a5-9e5b-08dbd9ff83be
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MiFzMzyHnGZ1v3YpBegNf08ReyFpCiNsVr3O4913WS/1b0jRcDpfpuYVMQjB/ceu0NruzNDdY33d7eGkWIvWJUjr7PeASjA3jCavvPJVh3c1ksjkULPNDb4WGZv7+FUrlICwi1CSMHNXAkjXwbvtw9nDglN4VrcyjB8aZ8964LvQjCQM3DUAvhXwRNSVrFa8GGLqOA4aahEpxqzaM1suufJpRhpjn5JNmjsWP6tD6GTPGNPSKh1nx+BYlFJ0uDAPXz/OIppM0Iy03XnQd8SdSoUxEIsfE5aZMDPr15wOeuMOuKvwdpdviN+7LYiRP9r98smp7/+RQ42dLfHMMhmIh5DmfJ2Ee0mp1DR1WZNYxjGgjTmXXjVkf66oFKR0fi7ChTJ1LleqVi0LJB3Mvqfa0nFYEeFpXzeEmkVNlBHoT7LSctbqyfQBRXQa7qwP4SR12qM3etrBEO+zM6N6RTu3UXUbyxo+OyUtp4Cr+dBfFCmPqV/kIHVC526Gzse0wNFz8DDcI0iaNgIomn6E9vYwilHQSG119Sb4L0JKIpULJZYj0/w+TlbAa4cmhrN/uVI62bO1Y56dIS7aaVqoICRlYhqX8GhaZPffTPPoPvoBS4JnHSJGjcWwXEqBmy65meSF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(71200400001)(478600001)(966005)(55016003)(66574015)(26005)(38070700009)(86362001)(122000001)(82960400001)(38100700002)(83380400001)(33656002)(9686003)(7696005)(6506007)(76116006)(41300700001)(64756008)(54906003)(316002)(66556008)(110136005)(66946007)(66446008)(66476007)(7416002)(5660300002)(8936002)(4326008)(8676002)(52536014)(4744005)(2906002)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFkvZEFuWGhoTzRxZWhPcXhpV3JKUTFyc3prdldvNjNZbmpzU2ZWb2dOdTRu?=
 =?utf-8?B?UjUxWkNjWDJJVzdFQXFSVlJ2M0dYN0FPMWxHb3JBaURrZUpoVjZyNmlUVGJW?=
 =?utf-8?B?RGh3aVkxdnl1eWFWZzRDdmNzSDRuNU1qbzVYZU5icFdFbkNwdS9sNnIxODRZ?=
 =?utf-8?B?Wko0Mmx5RmtTSWRycndCWVBkamNGeC92UUJqYVUxMGF0bEU5Q2ZZTzNkSW1J?=
 =?utf-8?B?N00xamVyUDgwZGgrTTN5bEVueUFORGladk5VK1k1cDk5T3hYNURsZm5iNzJV?=
 =?utf-8?B?Ykw0d2VydHBua1NRRFRFeFEwWkRVWUlONTg2bHRXVHRZc05WUnlBVTROMTlQ?=
 =?utf-8?B?SS85TFdZTENTUVpEc0Rnb0xtRGN0NXN0WTBoQjM4ZDd2ejQxcDRoMEFXYTY2?=
 =?utf-8?B?aUlLV0U5L0JYdER6VW9YNEIvbkpQeXdydCtBUjRudXJHV0ZXeGdkK05EU21u?=
 =?utf-8?B?UENQQVNxRGRneVpqcFBLZkhVeVlQNXJxS0xtWXJ3VnBleEdPRjViTkR4eTJM?=
 =?utf-8?B?dDFTZXVmWGRRNlNMK1FHNDk3bFlseVdxL2h2TWZ1K1V4UHkvRlZUYTJmcTNl?=
 =?utf-8?B?OGJKa0cyazNic3NRczRXYmlVZXlkNUFHUjZkOFBtaSs1a1Z5akpDMnFNREVq?=
 =?utf-8?B?Y0JFTm5oMXJ3VjJyZDl6K1hlMVB4bU9mZ1RhVVpEam11MzF6TU96ZGx1b1dX?=
 =?utf-8?B?WTI0MExXQWVtY2liTWNiSjB5REltd2xtakVlRmFEbk1vdlcyNFRjQkhmbmR1?=
 =?utf-8?B?Q2crWU5FbCsrWUxPZGovNmtOeGg5a1RiRjFRUDBVTjRONTJRMWZBZ3g3SGNR?=
 =?utf-8?B?K3B4aGx5dVlRa2lvNm5wSEo4aWxUQm5Ea3BCbjJXaE9FZkVXY0VFMTJ3MWhk?=
 =?utf-8?B?WXhjTXhMSGVmQlNYenJwY2FHd20vM2w1eldiOS9FdlArejRMdENpZDFsaE80?=
 =?utf-8?B?OGgwWjdFb2VGOWU1VFFnWUF5M3FubnhyRHdkREJSblZjTEpYN0VrUEhLaE5M?=
 =?utf-8?B?WHA0YzNhL1BKb2ZkNUwrNDBheXFjbzd2a3RGSGxpT1VReDFwNmFURXJWMzQr?=
 =?utf-8?B?bHl1b1o0NnFuZ3h0bjhiN3FYTFpCNUFrM0ZVT1g0WG13VG5uZkFHQUJwYW5O?=
 =?utf-8?B?RU8xWGJHQzFqeTh2eXVPeFpmR2V0aUFIYWJOS0dBWGxGYlRQUGZnUVNobnhC?=
 =?utf-8?B?eFlQaEY3OHlheldWUTlTWU5Rck1BRzlqbTlISWRhY2VXRHB1QzBKa1Jya092?=
 =?utf-8?B?RC9yUSthMWpmSDB4RUpnVWU3c0dKMHdEMnd5MmVpdlZMbUxHSENLL2Z6RzNw?=
 =?utf-8?B?TG8yNWh6anlaSlNSZXc4QkpXbERRQmhUS3NJQ1lCL2hhYWxQUVpxQ3IyZENj?=
 =?utf-8?B?NWo3TnRuOVdNVlF0MytrZlAwa2p3TkxFREVNa29MWDVJcEU1dW9BQ2locE5S?=
 =?utf-8?B?dU1kLzNadjdhNFZHVDdrYUYwbWhUejdtT0llK1VXRVRsZlJwMDJGaUxvWHdM?=
 =?utf-8?B?YjNpdGYrajRhd01WZTdTdFNueEhjSTM0bU4wbkJoQ1A4QTBCWjR4Mk03cmlx?=
 =?utf-8?B?M1FDZEdmVHRYM3ppZ3lBc2dvdXVoQVJEMVh3TEg4NGcybWQ4TVpBczkwOXp5?=
 =?utf-8?B?S2FHT3dUR1pJOE4wVmtvOUNScG9nQXBHbFo4dU1ldlZkcndXZG55TWVQUkFl?=
 =?utf-8?B?SmFYelBFbHJKZWljNzJINWNmUHU1ZkFOL2M0Y1FCb05abGI5TTNHR29UY004?=
 =?utf-8?B?TkRmRDBGc2FNY0trZE9RU3FUVm16emtjdnExRGlnNlAzVXMwUWRVNmdiNS91?=
 =?utf-8?B?WjBUOUJVSkhOcXIwZjNnbkF2eVNtU0FkYU14RjhHek5vc3M4azJVVmtpUE1m?=
 =?utf-8?B?a1hUcm9WQTBxUWdib3NRTUJ0RzdDTHovbXJEdFpNYUVBRm9ROC9EZi9ET1RD?=
 =?utf-8?B?b3FZVFJGdHBzUzhKNnIxZS94bndZYVExNElNVG9JN05TQUorTlNFclNOODkw?=
 =?utf-8?B?a0pnemxRU3ZQS0JONWFpR25DT21hVEtRVG9NbW1LU1pUOTZjdjFiTHRTaytn?=
 =?utf-8?B?eHpEQzg5VTBIekd3SGx0elBtcWYzNHpNaFMvYnBZMHg0MnZMQmhiM3o5U1Bi?=
 =?utf-8?Q?KGnUmaQKhsXQKoL0yxT/EOFRz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2751647d-9562-43a5-9e5b-08dbd9ff83be
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 10:52:45.2777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWMGPDOQqsxzQ6TXU2JZ7bP8xefO7rewb/aRMjV37C2/nBUuGqd2O1gkchO/BKfzoh37GnNi9/mkAk18PThp3zQqzYuIsUirtmxgBHr3bhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5606
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.151;
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

SGkgQWxsLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBDw6lkcmljIExl
IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+U2VudDogVHVlc2RheSwgT2N0b2JlciAzMSwgMjAy
MyA0OjU5IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAyMy8zN10gQWRkIGlvbW11ZmQgY29u
ZmlndXJlIG9wdGlvbg0KPg0KPk9uIDEwLzI2LzIzIDEyOjMwLCBaaGVuemhvbmcgRHVhbiB3cm90
ZToNCj4+IFRoaXMgYWRkcyAiLS1lbmFibGUtaW9tbXVmZC8tLWRpc2FibGUtaW9tbXVmZCIgdG8g
ZW5hYmxlIG9yIGRpc2FibGUNCj4+IGlvbW11ZmQgc3VwcG9ydCwgZW5hYmxlZCBieSBkZWZhdWx0
Lg0KPg0KPkl0IHNob3VsZCBiZSBkaXNhYmxlZCBieSBkZWZhdWx0IGZvciBQUEMuDQoNCkkgZGlk
bid0IGZpbmQgaG93IHRvIGRpc2FibGUgaW9tbXVmZCBmb3IgUFBDIGFmdGVyIGRpZ2dpbmcgaW4g
aHR0cHM6Ly93d3cucWVtdS5vcmcvZG9jcy9tYXN0ZXIvZGV2ZWwva2NvbmZpZy5odG1sDQoNCkFw
cHJlY2lhdGUgYW55IGd1aWRlIG9yIGhlbHAhIFRoYW5rcyBpbiBhZHZhbmNlLg0KDQpCUnMuDQpa
aGVuemhvbmcgDQo=

