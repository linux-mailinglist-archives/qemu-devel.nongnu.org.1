Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC4E7DC412
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 03:00:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxe2X-0005I0-Q9; Mon, 30 Oct 2023 21:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxe2W-0005Hs-1P
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 21:59:32 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxe2T-0008H3-41
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 21:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698717569; x=1730253569;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XN2a0YLVofSm7TyTCp5Jf/hE0oJ6K8RakxZAiRCNihg=;
 b=Qyg8jMqP+BRM3pEU+PsFWyjIxgLmOCcB9XsDeTn+cTuhAT7ow6RIGJza
 G7bXPC/BlsliTfpWurXaqQNfndlSzUon1zMRG8eNSmsXO81yBOB2lTaRg
 GxaD/wuTYpYdEwFyZb1IR15jAz9HaLEzNtwoc7hZzdmOshxLTQc3oWRyi
 Sjwc8g7T8Ey5fJom86JJMKSTeErnp6EpzcwsDVX6SzVDbVj/ROcszWOYM
 mtVjAgKuGmFbdU4O0/BfXd8C6oK+MNbzwIfRH/eCpc2NKAAKs2PPlkJA+
 3m2QWriMggYKZpBeg9NQ5K3IY/D5ZaHeN9I9I13MWr8BOVK18mZxi7zuF w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="419306872"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; d="scan'208";a="419306872"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2023 18:59:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="795421518"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; d="scan'208";a="795421518"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Oct 2023 18:59:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 18:59:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 18:59:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 18:59:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ae87FaOFMOmU1e/DO5uHHKJOC+/moJjjLv5Rs7aPofnoDQ2TdlFCAl8xCPGvbK8TkxJYKA/wbuPHLWAknbPIepwqPa+PtvttpDCmhSx+3o8WsIN8mQerHHs/ccsBxc7+WTYq8ylqg6httjvLXjUjCn+pdfJmFELc3Y6rcAkJzpPeHYqxmB9BOQli223igoaNqTyTW8V3HxbL/8fJVK0u5n19ch33Ft6xaTeEIOAu34gkQsnNEVflxnvekHUjms8L3QDkGGKiwmHVjjXhMdMfohU0e7YGsJas60rXijuMwJqTgLQzSEA5fS8qgliuFQhAkYncHopkWqxsvdcHM5bplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XN2a0YLVofSm7TyTCp5Jf/hE0oJ6K8RakxZAiRCNihg=;
 b=Cs/zfNSa9lGZIAP4BtMQuVLq5e1Otgqz5r5NSw4fkwreUlTfssaSwvNVhodzJ7SIi8IaVZ/0x5pgoBwKLmWEPvnYY9OoAroqxUpxvOpp8YQPYdeLBpVWm4ljGiSfIDrwm30Kr9qia+LAYw9sQ341oLTPcQr/FpGca+isnBhHxL2ail/Qj7ex+uY8g8QcK6ReMSQ84mDTeNbJxlteUdHq88k0TQyrbd/Pg3FDVnyUwjSAZUY6DPklOFrrQ7pLaYnoWifKAsk/jNuqn43DCfErl9h4fEn9st0JUmyHMyH/ZdFPvPkLbFP4Q5fg7dc0NvRLu5u3MY7xsWbS2SyU/tcXYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA2PR11MB4876.namprd11.prod.outlook.com (2603:10b6:806:119::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 01:59:19 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 01:59:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 25/37] util/char_dev: Add open_cdev()
Thread-Topic: [PATCH v3 25/37] util/char_dev: Add open_cdev()
Thread-Index: AQHaB/nhpD6AzdLQlkCCqv18kuYrL7BicdGAgAC5qYA=
Date: Tue, 31 Oct 2023 01:59:19 +0000
Message-ID: <SJ0PR11MB674498EBF8AB8684999B1A0792A0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-26-zhenzhong.duan@intel.com>
 <50827527-ff82-434f-ab95-770572b0d81c@redhat.com>
In-Reply-To: <50827527-ff82-434f-ab95-770572b0d81c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA2PR11MB4876:EE_
x-ms-office365-filtering-correlation-id: d507df5f-b811-4695-0afe-08dbd9b4fed6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8xrJ71AzYAyxJULplJDS7kkbJbOk+fLuWfNOhxen4mcTLGXkAefouvEgg+ySlV4cKNEc6BBNyj19+N39/KfKOQEjBWawK6BRayqCoMtciOK1HU64C2IECbjLiXUANzcclDCyfC6sQZOCPwQ1bsATZAnXuQQ02tPBdiwcZjuJEVpSpMUo3yE7d7QsS2V6BxBnNtIZRzXz7nQFB0dzq/Oy6SNoKExILkSZHnsV8WmgjnGFpGGjiGeTpm2SEdGlewIY04x0N0klixa5+W1WHQdK+eghVMePa28iKl1ca1bYI1y/tuFDbJihqtnhx807vYP3KILpktBEe3TgTQdTRNL91EwVa6wMsQ98oEk5I6298CGQffJCQBgxj7vHFq0V9ugnhtO7K3ZscxJXIUw+5r4UTFKS4BDWngx1qvhs8Y24NX2QMR0Ig2ffa/WQYaO9GL0CzYG04/MmGIQnkmBIcL3wRUie6kcHGU8NAr4Iz30giAjQR0xqVX1yJaLEHIJTiskgReUm909yCYE3p18EZXQ5mJ/Y10/P9eq08Vlo77vmqU7xQuoG8Pubdmqyuqprvq6CCeQJ1xlYUG46KB15tjmex1tEJWRnPy9Ml3VyNXadrIeppULQ7pq5+1NdvmqOiYTTUYJHXjslVLXFskMIvezqnPWQeYI5N7RRzPYfA2pUtTs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(230373577357003)(230473577357003)(451199024)(64100799003)(1800799009)(186009)(55016003)(9686003)(26005)(6506007)(107886003)(478600001)(7696005)(71200400001)(66574015)(83380400001)(2906002)(5660300002)(41300700001)(66556008)(66946007)(76116006)(110136005)(966005)(66476007)(66446008)(64756008)(8936002)(52536014)(8676002)(4326008)(316002)(54906003)(38100700002)(122000001)(82960400001)(86362001)(33656002)(38070700009)(66899024)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3d6Ly9CSEtESHUwcDJEZERDRWcxZWJqQmg2eUFwNTNjUitNY2xyZDFnNlJr?=
 =?utf-8?B?T2Zpb2lOeHE2dEdjWUtsUU5Eemltd1hld3RqMjJEby9VWXdtZ1NXUE9talZ4?=
 =?utf-8?B?ZHF5QWFHbjFhaENtYXQ4NUNOUFUvWXdSVWlaSWpFcmpERWZvTkN4ckduS2NI?=
 =?utf-8?B?eHplU3d4NEdWRHBGdjVMODJFVDJmOUhnRlJyTktocy9WVDVkTTZ1dFZJNlFx?=
 =?utf-8?B?N1hxSS9HajNOZWRrcjgxRm1uUytNV01IMjZWT2F4eHdZK2N6SjJmdTN5TGxC?=
 =?utf-8?B?a3hQNVRGTENSWFduWFlQcnFTaDNyOVBQTzZ1dkwyYi96MTFUSk4zbm5aT2F3?=
 =?utf-8?B?OUlmYU5uUFNiVzA0bExRSHR2eHlSY1p3Zys2Y1g3ODNRT3ZpV0Fyc1p4RE1p?=
 =?utf-8?B?SGYxUmVsOENFeHY1c1kyRlVnZzdCNlpmRzhQRm1kNHc3eHVYdHNwOHRyZFdJ?=
 =?utf-8?B?SmtiWVdCVkxHWlJ4dVNjSTM3L09BRm53WFhBR1NFZ3dvZlB1YzNlMWtRQU5C?=
 =?utf-8?B?eExtbG1neU10dTZ5eGxTL3NDeHc2Y3lDcHhrcXVRQ0VleWhQekpTbkR6ZFAw?=
 =?utf-8?B?R0lhSnhWZnZDZEU4S0FKaTlseVdwd3Z0aFZONVRyWkFIdXVCM1BuL1RXb01W?=
 =?utf-8?B?N1B2WnlNSTcyWHRuTVpVRXV1N21KTGc1SDJYWS9TUmVrUHM1ZWQyQmRNbktu?=
 =?utf-8?B?Y0piU3QxN2dlQVlDMXNwR1VwK1hVYTJJb3A4dXc3bmEwcUp2WWdkYlVTaEZS?=
 =?utf-8?B?K0NkZkI5TU45MHYxNTRMTjZUSVZvcXkwdFF1MmlvMDJaSXhnUHNsWUZOdzl0?=
 =?utf-8?B?VE9LS3lFYkFQU2x2SGpuVFJINjhFQjJMSDNuSzkzcTdxM3JRYXNaOEJpUmNi?=
 =?utf-8?B?cGNOa3QxYVJXTEx2TGRDcTl0NGw0U0MxcHQ3VkRWanFqOURDaUFhVkNYcGE4?=
 =?utf-8?B?YlF4bkltOEd6VUtOZnFST1pyTlQrTERJckFKYVFNN1VLR1hnNC9Va3Q1c01M?=
 =?utf-8?B?TEpkZEpGRnZ3SGV0VWs2RVZRSzErbHhmNjliV25BOXhQYXN0eW9yQlVLMHBX?=
 =?utf-8?B?Q1lIVmhHdk9PY3Btdm9Jc1VUVnhnWFVwbGQ5cC9TUHFzNHIxSTRaOGFMYXQv?=
 =?utf-8?B?V0VxcWNNLzVCdGF3RlpqeWs4VmRyTi90cnJGTWp6YndjTjlDTStlSzlTaVRo?=
 =?utf-8?B?U3B1bElsNGM1Tk9TSWRKR2k5N0xBbWdvNmNGTkNNQklBK2VDS3FnNnN2TTJK?=
 =?utf-8?B?QmlMQXh6ODdKRVBjRGtGR1o5OGRNdHQxbWQ0c0pTVlkyTElvY1BWM2dFWjlk?=
 =?utf-8?B?SWt1V2NHZzNwUklHR0RvckNzWjMwSlhNNHM5Tm4vaEJTM01zUVhHZDFaOGYx?=
 =?utf-8?B?WVdnZVh6U1FnL1lNdVIwNzd6Z2xnZnNPaHN1aS91Q1VFYVloVkdFdWVLWVRy?=
 =?utf-8?B?SnUzTmkzcFl5UWRVc3FJL0RZMThVMG83RU50azVRbDY0MC9UZC80UUJkSnc2?=
 =?utf-8?B?QXhRT3luUHNNWGtMZWZGZmN0c0ZuQmtxSzZ5YVo2SVV0dkJKblB0WG9vRHB6?=
 =?utf-8?B?WEpMSmVmTmdHS0ZWQ2RHUy9hT0Q1aHdxaXR0bXRVZEp6V1ozbitjdjJ0YVYy?=
 =?utf-8?B?QmVGNDAzSDlkczJpaWFqdUpQcGRkVWN5ZzZsWU9kZkpKalloNkJmc00rN0dr?=
 =?utf-8?B?WXpOUzVLcFhZL00wMHkwcDlYcE5RNmxaazEyYitkMERTbW9rbHU4UmhGVjQ1?=
 =?utf-8?B?bHNJNEVDNm5tb1BUYlQyNHh4M2tsOEc0YTdEcjZ1b2YyUmFqaHdBQmRoZXpx?=
 =?utf-8?B?Wk5CNDJIcHJyN25VMms1M2Q1UmF3WEVZN2tQTGJlNXdtNjFvcGh1N1FZeEpm?=
 =?utf-8?B?Q1hkYURyTzliUEJDaGNqbEt5QTV5MEQyK2MrRm40b1Q1dFptdlVPMWprQUpm?=
 =?utf-8?B?ZUtVVXJPZXdzWWpmbEZGT3h1UktxekQzdWFEOHB2bzJpcTN4UkRpaFlrNERR?=
 =?utf-8?B?TnFtSThaNmRLeDFwckthTXE0QXVkUHRjL2pCeSsxRmJ2QkpMYmJjTUxlSi9X?=
 =?utf-8?B?TXBkM0NzVFd2TDh0b1NwQllvQk5vdzhmTWM5NEttNnlyRFJrZ3J4aG1YVFA1?=
 =?utf-8?Q?U17+Ckt3TRKOprj08rr/8pzZh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d507df5f-b811-4695-0afe-08dbd9b4fed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 01:59:19.5742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H89s5yu7E4U5Byl/Sv/h1LDY2J2HoX4njdWf8Ub0dfaLNmJQsYsDFQV0HKpHVQApT7xPYltbfN6c5LtXtwuKcM97pzOh8YQ+IWTbAS69Xig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4876
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBNb25kYXksIE9jdG9iZXIgMzAsIDIwMjMgMTA6NTQg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDI1LzM3XSB1dGlsL2NoYXJfZGV2OiBBZGQgb3Bl
bl9jZGV2KCkNCj4NCj5PbiAxMC8yNi8yMyAxMjozMCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+
PiBGcm9tOiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+DQo+PiAvZGV2L3ZmaW8vZGV2
aWNlcy92ZmlvWCBtYXkgbm90IGV4aXN0LiBJbiB0aGF0IGNhc2UgaXQgaXMgc3RpbGwgcG9zc2li
bGUNCj4+IHRvIG9wZW4gL2Rldi9jaGFyLyRtYWpvcjokbWlub3IgaW5zdGVhZC4gQWRkIGhlbHBl
ciBmdW5jdGlvbiB0byBhYnN0cmFjdA0KPj4gdGhlIGNkZXYgb3Blbi4NCj4+DQo+PiBTdWdnZXN0
ZWQtYnk6IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9u
ZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+ICAgTUFJTlRBSU5FUlMg
ICAgICAgICAgICAgICAgIHwgIDYgKysrDQo+PiAgIGluY2x1ZGUvcWVtdS9jaGFyZGV2X29wZW4u
aCB8IDE2ICsrKysrKysrDQo+PiAgIHV0aWwvY2hhcmRldl9vcGVuLmMgICAgICAgICB8IDgxICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgdXRpbC9tZXNvbi5idWls
ZCAgICAgICAgICAgIHwgIDEgKw0KPj4gICA0IGZpbGVzIGNoYW5nZWQsIDEwNCBpbnNlcnRpb25z
KCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3FlbXUvY2hhcmRldl9vcGVuLmgN
Cj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHV0aWwvY2hhcmRldl9vcGVuLmMNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPj4gaW5kZXggN2FhNTdhYjE2Zi4u
MTIzZTk5OWJlZSAxMDA2NDQNCj4+IC0tLSBhL01BSU5UQUlORVJTDQo+PiArKysgYi9NQUlOVEFJ
TkVSUw0KPj4gQEAgLTM0NDcsNiArMzQ0NywxMiBAQCBTOiBNYWludGFpbmVkDQo+PiAgIEY6IGlu
Y2x1ZGUvcWVtdS9pb3ZhLXRyZWUuaA0KPj4gICBGOiB1dGlsL2lvdmEtdHJlZS5jDQo+Pg0KPj4g
K2NkZXYgT3Blbg0KPj4gK006IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gK1M6IE1h
aW50YWluZWQNCj4+ICtGOiBpbmNsdWRlL3FlbXUvY2hhcmRldl9vcGVuLmgNCj4+ICtGOiB1dGls
L2NoYXJkZXZfb3Blbi5jDQo+PiArDQo+PiAgIGVsZjJkbXANCj4+ICAgTTogVmlrdG9yIFBydXR5
YW5vdiA8dmlrdG9yLnBydXR5YW5vdkBwaHlzdGVjaC5lZHU+DQo+PiAgIFM6IE1haW50YWluZWQN
Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvY2hhcmRldl9vcGVuLmggYi9pbmNsdWRlL3Fl
bXUvY2hhcmRldl9vcGVuLmgNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAw
MDAwMDAwLi42NTgwZDM1MWM2DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9pbmNsdWRlL3Fl
bXUvY2hhcmRldl9vcGVuLmgNCj4+IEBAIC0wLDAgKzEsMTYgQEANCj4+ICsvKg0KPj4gKyAqIFFF
TVUgQ2hhcmRldiBIZWxwZXINCj4+ICsgKg0KPj4gKyAqIENvcHlyaWdodCAoQykgMjAyMyBJbnRl
bCBDb3Jwb3JhdGlvbi4NCj4+ICsgKg0KPj4gKyAqIEF1dGhvcnM6IFlpIExpdSA8eWkubC5saXVA
aW50ZWwuY29tPg0KPj4gKyAqDQo+PiArICogVGhpcyB3b3JrIGlzIGxpY2Vuc2VkIHVuZGVyIHRo
ZSB0ZXJtcyBvZiB0aGUgR05VIEdQTCwgdmVyc2lvbiAyLiAgU2VlDQo+PiArICogdGhlIENPUFlJ
TkcgZmlsZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeS4NCj4+ICsgKi8NCj4+ICsNCj4+ICsj
aWZuZGVmIFFFTVVfQ0hBUkRFVl9IRUxQRVJTX0gNCj4+ICsjZGVmaW5lIFFFTVVfQ0hBUkRFVl9I
RUxQRVJTX0gNCj4+ICsNCj4+ICtpbnQgb3Blbl9jZGV2KGNvbnN0IGNoYXIgKmRldnBhdGgsIGRl
dl90IGNkZXYpOw0KPj4gKyNlbmRpZg0KPj4gZGlmZiAtLWdpdCBhL3V0aWwvY2hhcmRldl9vcGVu
LmMgYi91dGlsL2NoYXJkZXZfb3Blbi5jDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5k
ZXggMDAwMDAwMDAwMC4uMDA1ZDJiODFiZA0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvdXRp
bC9jaGFyZGV2X29wZW4uYw0KPj4gQEAgLTAsMCArMSw4MSBAQA0KPj4gKy8qDQo+PiArICogQ29w
eXJpZ2h0IChjKSAyMDE5LCBNZWxsYW5veCBUZWNobm9sb2dpZXMuIEFsbCByaWdodHMgcmVzZXJ2
ZWQuDQo+PiArICogQ29weXJpZ2h0IChDKSAyMDIzIEludGVsIENvcnBvcmF0aW9uLg0KPj4gKyAq
DQo+PiArICogVGhpcyBzb2Z0d2FyZSBpcyBhdmFpbGFibGUgdG8geW91IHVuZGVyIGEgY2hvaWNl
IG9mIG9uZSBvZiB0d28NCj4+ICsgKiBsaWNlbnNlcy4gIFlvdSBtYXkgY2hvb3NlIHRvIGJlIGxp
Y2Vuc2VkIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VDQo+PiArICogR2VuZXJhbCBQdWJsaWMg
TGljZW5zZSAoR1BMKSBWZXJzaW9uIDIsIGF2YWlsYWJsZSBmcm9tIHRoZSBmaWxlDQo+PiArICog
Q09QWUlORyBpbiB0aGUgbWFpbiBkaXJlY3Rvcnkgb2YgdGhpcyBzb3VyY2UgdHJlZSwgb3IgdGhl
DQo+PiArICogT3BlbklCLm9yZyBCU0QgbGljZW5zZSBiZWxvdzoNCj4+ICsgKg0KPj4gKyAqICAg
ICAgUmVkaXN0cmlidXRpb24gYW5kIHVzZSBpbiBzb3VyY2UgYW5kIGJpbmFyeSBmb3Jtcywgd2l0
aCBvcg0KPj4gKyAqICAgICAgd2l0aG91dCBtb2RpZmljYXRpb24sIGFyZSBwZXJtaXR0ZWQgcHJv
dmlkZWQgdGhhdCB0aGUgZm9sbG93aW5nDQo+PiArICogICAgICBjb25kaXRpb25zIGFyZSBtZXQ6
DQo+PiArICoNCj4+ICsgKiAgICAgIC0gUmVkaXN0cmlidXRpb25zIG9mIHNvdXJjZSBjb2RlIG11
c3QgcmV0YWluIHRoZSBhYm92ZQ0KPj4gKyAqICAgICAgICBjb3B5cmlnaHQgbm90aWNlLCB0aGlz
IGxpc3Qgb2YgY29uZGl0aW9ucyBhbmQgdGhlIGZvbGxvd2luZw0KPj4gKyAqICAgICAgICBkaXNj
bGFpbWVyLg0KPj4gKyAqDQo+PiArICogICAgICAtIFJlZGlzdHJpYnV0aW9ucyBpbiBiaW5hcnkg
Zm9ybSBtdXN0IHJlcHJvZHVjZSB0aGUgYWJvdmUNCj4+ICsgKiAgICAgICAgY29weXJpZ2h0IG5v
dGljZSwgdGhpcyBsaXN0IG9mIGNvbmRpdGlvbnMgYW5kIHRoZSBmb2xsb3dpbmcNCj4+ICsgKiAg
ICAgICAgZGlzY2xhaW1lciBpbiB0aGUgZG9jdW1lbnRhdGlvbiBhbmQvb3Igb3RoZXIgbWF0ZXJp
YWxzDQo+PiArICogICAgICAgIHByb3ZpZGVkIHdpdGggdGhlIGRpc3RyaWJ1dGlvbi4NCj4+ICsg
Kg0KPj4gKyAqIFRIRSBTT0ZUV0FSRSBJUyBQUk9WSURFRCAiQVMgSVMiLCBXSVRIT1VUIFdBUlJB
TlRZIE9GIEFOWSBLSU5ELA0KPj4gKyAqIEVYUFJFU1MgT1IgSU1QTElFRCwgSU5DTFVESU5HIEJV
VCBOT1QgTElNSVRFRCBUTyBUSEUgV0FSUkFOVElFUw0KPk9GDQo+PiArICogTUVSQ0hBTlRBQklM
SVRZLCBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRSBBTkQNCj4+ICsgKiBOT05JTkZS
SU5HRU1FTlQuIElOIE5PIEVWRU5UIFNIQUxMIFRIRSBBVVRIT1JTIE9SIENPUFlSSUdIVA0KPkhP
TERFUlMNCj4+ICsgKiBCRSBMSUFCTEUgRk9SIEFOWSBDTEFJTSwgREFNQUdFUyBPUiBPVEhFUiBM
SUFCSUxJVFksIFdIRVRIRVIgSU4NCj5BTg0KPj4gKyAqIEFDVElPTiBPRiBDT05UUkFDVCwgVE9S
VCBPUiBPVEhFUldJU0UsIEFSSVNJTkcgRlJPTSwgT1VUIE9GIE9SDQo+SU4NCj4+ICsgKiBDT05O
RUNUSU9OIFdJVEggVEhFIFNPRlRXQVJFIE9SIFRIRSBVU0UgT1IgT1RIRVIgREVBTElOR1MgSU4N
Cj5USEUNCj4+ICsgKiBTT0ZUV0FSRS4NCj4+ICsgKg0KPj4gKyAqIEF1dGhvcnM6IFlpIExpdSA8
eWkubC5saXVAaW50ZWwuY29tPg0KPj4gKyAqDQo+PiArICogQ29waWVkIGZyb20NCj4+ICsgKiBo
dHRwczovL2dpdGh1Yi5jb20vbGludXgtcmRtYS9yZG1hLWNvcmUvYmxvYi9tYXN0ZXIvdXRpbC9v
cGVuX2NkZXYuYw0KPj4gKyAqDQo+PiArICovDQo+PiArDQo+PiArI2luY2x1ZGUgInFlbXUvb3Nk
ZXAuaCINCj4+ICsjaW5jbHVkZSAicWVtdS9jaGFyZGV2X29wZW4uaCINCj4+ICsNCj4+ICtzdGF0
aWMgaW50IG9wZW5fY2Rldl9pbnRlcm5hbChjb25zdCBjaGFyICpwYXRoLCBkZXZfdCBjZGV2KQ0K
Pj4gK3sNCj4+ICsgICAgc3RydWN0IHN0YXQgc3Q7DQo+PiArICAgIGludCBmZDsNCj4+ICsNCj4+
ICsgICAgZmQgPSBxZW11X29wZW5fb2xkKHBhdGgsIE9fUkRXUik7DQo+PiArICAgIGlmIChmZCA9
PSAtMSkgew0KPj4gKyAgICAgICAgcmV0dXJuIC0xOw0KPj4gKyAgICB9DQo+PiArICAgIGlmIChm
c3RhdChmZCwgJnN0KSB8fCAhU19JU0NIUihzdC5zdF9tb2RlKSB8fA0KPj4gKyAgICAgICAgKGNk
ZXYgIT0gMCAmJiBzdC5zdF9yZGV2ICE9IGNkZXYpKSB7DQo+PiArICAgICAgICBjbG9zZShmZCk7
DQo+PiArICAgICAgICByZXR1cm4gLTE7DQo+PiArICAgIH0NCj4+ICsgICAgcmV0dXJuIGZkOw0K
Pj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW50IG9wZW5fY2Rldl9yb2J1c3QoZGV2X3QgY2RldikN
Cj4+ICt7DQo+PiArICAgIGdfYXV0b2ZyZWUgY2hhciAqZGV2cGF0aDsNCj4NCj5QbGVhc2UgaW5p
dGlhbGl6ZSBnX2F1dG9mcmVlIHZhcmlhYmxlcyAoID0gTlVMTCkNCg0KVGhhbmtzIGZvciBwb2lu
dCBvdXQsIHdpbGwgZml4Lg0KDQpCUnMuDQpaaGVuemhvbmcNCg==

