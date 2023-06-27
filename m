Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E99B73FA3D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:29:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE5wa-0000rn-4s; Tue, 27 Jun 2023 06:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qE5wX-0000rD-4n
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:29:05 -0400
Received: from mga09.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qE5wV-0002a8-58
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687861743; x=1719397743;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gMPL8usDlzvjz2i8pOLTHhbeLhtFrSwUonVbBQx7/fQ=;
 b=XTv5aCjCeNEmd70CVc19bJgRDo689OCX8uSBBCWFLqOCqpNTyohHRCnU
 VRG171B63bOiJPxFI3TltmfvE4Z8jWLBYqbc7zhEDOCh1Rrnuap99rypM
 vVW+PkSjHtlF55TQ+xHtprdB6fAMPgcRTg+wHAbfsthgdrTHG2+0MqeeK
 YB3JOL2q+SCEqorNsDBprnBvwMl4ic35p6lHUywpn2ui33aZlxNC7p1NX
 +f05YSYzxnelA+dHPg4p/R9Z6EoK84Dfqd53S7EwqFDWGFhkcDw561crA
 2xfGoa7bFEFLl9I9c8SER2S/JZ/jWsYZhpb9j0w6wNTuqPKObXcVT8GHX A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="364083556"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; d="scan'208";a="364083556"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2023 03:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="710608152"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; d="scan'208";a="710608152"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga007.jf.intel.com with ESMTP; 27 Jun 2023 03:28:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 03:28:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 03:28:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 03:28:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 03:28:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j50/Il31Uyxdu6b2oY8SMJqaw/yokmy9Mxxx8Wsxyt/sblU16YgIgJskbvj9GzwWKvoiFHmxtCsTFQiwowK9oPHenCOOdA+U4UnlgwUtG7+fpu9QJOMbo8AsOjKfat0CuGRYHC6h25JUnMSFvJpsNrWjOqoqeCulz9sgZDYispAlqOy49b7Z3GaHVwBTAjQZ8/DOT9yXQ1jyGVz63JtfycvzauU8zeRty14iuFO+NH4duop0OARtPi1SN6NytWSot5qfU+gZX3OUGOkpvDlk6Mi+FjLGrzGp4ND1BTtU01prNZaBohVah3RWR17vtLbvgTALTAjeiDWwAWVjFDQRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMPL8usDlzvjz2i8pOLTHhbeLhtFrSwUonVbBQx7/fQ=;
 b=aznG/jQK/dCqijByKe+ZxAGUXkyRaiDmFRDLSEj4uVJ9xFNGcbuOQ8D/54kQhhEzit65gsXFsgUHuMI9KFKqgcflV+9eKjksQKenVvOek24gPppLE4KEyCoXiIQhsVgTtgwvF0PQIHhfD1DdyChfQdW4a9czBLTldQzZ+/m4JWT4Gv7oEuxfoG6eOhErPpV6UGhPBauLQs3sAWpP1A6pR+4Bx+O1+b7K+ldn4lLBSu5YEGA0rSPsCEp0WEy2VMVPhRTzooT4nf3nqtLsOAVK6KRE6oYqYtfoyZ+74krp5t2W2QqofIfQiWo2eyedrVjnCQG1ZrFhygG72QEK2HGOSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA2PR11MB5052.namprd11.prod.outlook.com (2603:10b6:806:fa::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 10:28:41 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%5]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 10:28:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 1/3] vfio/pci: Fix resource leak in vfio_realize
Thread-Topic: [PATCH v3 1/3] vfio/pci: Fix resource leak in vfio_realize
Thread-Index: AQHZpBh99h+ohEs6RE+cMJ5+wAFWM6+VGTEAgAXtPLCAAaJjAIAAOw4AgAACDMCAAZQzAIAAAdJA
Date: Tue, 27 Jun 2023 10:28:41 +0000
Message-ID: <SJ0PR11MB674450A9ED5DACE77A6EE63D9227A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
 <20230621080204.420723-2-zhenzhong.duan@intel.com>
 <88aa1fc0-edf4-a98e-0cbb-fcf312b3b19e@oracle.com>
 <SJ0PR11MB67441D1922E854785F2FED3D9221A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB6744837FBCEAB1F9060BBAFD9226A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7e1567f1-aa79-cbeb-3c1a-20594f1942cd@oracle.com>
 <SJ0PR11MB6744DB25CF81FF634B82FF7A9227A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <8ef7f136-54ce-16dd-60fd-fb360b012646@oracle.com>
In-Reply-To: <8ef7f136-54ce-16dd-60fd-fb360b012646@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA2PR11MB5052:EE_
x-ms-office365-filtering-correlation-id: 556890a4-f296-4b84-4b7d-08db76f946f3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6vVfvN1OxswSlT4AqufaMqSQg/eEgVIIR+KKdH8RGoSm8fKDtmJ5PeF+IOhY9loH5Hl2eZ4P5ueILZpcCpmYT64GsQok/MamAeLjCJiaEkdg6Pk5UQ7HfmSwEhXsqs1HVBoVMY22fz4Yy6tbJxGMMVgqeJs6/d55l4TfYIbD0YyZxlzNFeye4p3knTBdmUDViaPq3p3HJrXtXMKNmGJDedTYshjqfsAX03sTFbk9Ga8q8lDcBdd+2m1f7My2KmC4qsTc9q8Pb3GeMVAOxJhWqh9Zt4XGGD+LOLBkzdMz7zsnz0x0WfcuUS0+s2fbkGKWIxtu69qw1AADCCsQAqeOlAqaid7cULax+9Tb2P0j/eyehdc1PS2of5qxZiBTpch+cejUw33mLdIHRnB4WL9r/EQ65sHpMsQGk4ey6x5i4BEVP6DbIdKC8V+AVZNWSsNoyydakmCawQRKpTu3pGMO0kbSmZPHSp3OSc3Ojq1SEVxakadGj7pxB2hqTRsuYruauD/+vzW0kKRhyxCD7XlfOg59bexddfvENtvz/c7CLGZlbEfKskZh0uwvctQ9hpP0ubPSW0CNb+FuJQAcpPiQhaK0B2XH5I+KgFjObpI2/wA9tU++9mXLE2EyC19VtC6m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199021)(316002)(76116006)(66556008)(66946007)(66446008)(64756008)(33656002)(6916009)(66476007)(38070700005)(478600001)(4326008)(52536014)(8936002)(8676002)(5660300002)(55016003)(86362001)(54906003)(41300700001)(7696005)(2906002)(9686003)(186003)(6506007)(82960400001)(26005)(83380400001)(38100700002)(107886003)(122000001)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjZ2b29wK2xVc1lERkhYZE1VdDluL3dRc0RwNUxMMXdyYU1mVmNSRGRGaXVE?=
 =?utf-8?B?U3FVRjZyZnQ2VUlic0Z1endYN1Z5VmNCM2pFeENza3NuLzI4bFg4UURObnhO?=
 =?utf-8?B?ZER4VXpxb2lGTmJlSUcxcnFYdGlURnpCRzdUVThsWmpObzZPL1gvN1VmQ2Jn?=
 =?utf-8?B?TEdrL3QxelVRWkkrS25Kbmo3SVFyM0lJMFlkcnV2a3lzaU84M210S2l5akZl?=
 =?utf-8?B?aEthWjdrRkN5VFNEVGU3S0RwYjU1LzhQQk1Od29PSnUzMUZnMnM0R2JocWJP?=
 =?utf-8?B?b3d2L1lVN3FNQ3VNQUJqclBCZW5iZTlUV3RWWm5CVDNoR2VXZnRNTThxV2hq?=
 =?utf-8?B?MEgzMkpucUh0RWtkblVTd0d6c1FibkVnNnBsZmQrU0xrUDBmVm9PQnlmWnlt?=
 =?utf-8?B?T1AzSTZQS0JuTXp1TzRQVmZiY3JoOU5HVDNwOFpxbU9DQTJid2dac2pmMGlY?=
 =?utf-8?B?RGRQQlVuRzBETHZwT0lYSnZTcUNWa1JaUThJL2ZVRDZpY2M1NXdOMy9LMTVD?=
 =?utf-8?B?b04wRXFvcUJYRUV0QXVwK25IUHBCUE9qWkdxZnlMcEZ0YURqMEovSkI0QWRH?=
 =?utf-8?B?cE9Ca090N3BmY3ZrQ2Y4dzNnNThZK1JKWm9zcGdFMUJwVzBBV29kTEN6RUp2?=
 =?utf-8?B?RjFVMFh0UmRjZ21rOSsyU0N4NStjMWlHOVBzS0kzSWk4L3R5ZmVHd3M5Z0No?=
 =?utf-8?B?Z1EvYUlISEtIcXNaWjVUUFZvWVpRZFpUeXgzazV6Y09keU16cmVjY3RGNUpQ?=
 =?utf-8?B?dm1JU3FSekMyVTBmUTUwRFBmckNEM0s2dXVZNGJOeUMvYXRFSHZuVjVaSTU0?=
 =?utf-8?B?Qms0ZTBtcThaek5RY0tHYU5WV3ExblI2M3hXVGxYQ2syMElDUHF2d0ZDTHZF?=
 =?utf-8?B?SUx4UU5rdkRzVW9MckVEem14TEloZktBc0lsRzdnZVQwc2pjcDIyVm42Rngz?=
 =?utf-8?B?VVVadEhCTWd1OFdjOS85MFVpaDRzWk1scDFFQUNzYTRoNE9VZ2c4ZlY2b01S?=
 =?utf-8?B?a05iUkc5R2Z1ZDNWUnZHSHNZVjBRM1RadldiVUd4SVFQaGcyaFlQTTRNUDlu?=
 =?utf-8?B?RWNHL2lJRGNteWNKQlNqdkpzVDZiUG5ucVFFZzdid0FlUC9HWWdFdE9oMyt1?=
 =?utf-8?B?ZmMzNk40a3BPZUU4RjRJd0Nvb0VEaVVmZ2EyRG9LUlVHSzhRZDl3NFJnMmo3?=
 =?utf-8?B?MVlMNjBVZVlTaXVXRWFjYjFZcUtjSzlQaWZhSXgxZTBTV1oxdGZsaUsyRFpk?=
 =?utf-8?B?TzArdUx5MUgrNm4zVElxUHJDTHJSVVVMTXhFd2xPQ21LTnRRYU1jYWxlQW5k?=
 =?utf-8?B?OWZRT1lSVklUUXM1c3JuUGUyYmVqSmcrbGdTTVNicXI5TVlkN0JqeENwMG4z?=
 =?utf-8?B?Q2RuaXphUUFXN1FZTWZwVUE3b2JuVkZTVVNxNlB6ODZDcWFUeC85SWxxVFNK?=
 =?utf-8?B?YTVvZjZZdi9lVmV3NWhrbXRkSnVEa3ZBZjRlWGxnMXNYdEhUd2ZsZW1XYy9F?=
 =?utf-8?B?N3A0ZXIxbGxvYnJLOE9ORDhFNjQ5cEROQ3VTT255TE5nVHkzSGRPU0hadTNN?=
 =?utf-8?B?VWl5alVTbW1McHY4TkZUSlRDaS9KYTNBdG15VFBJMC9VeWhhVnV3dkdwb0Vo?=
 =?utf-8?B?K2YzdThsSjhmenk4Z3VQU2JMalRJcjdYdGdhemRmaEc2cXp1ZkFCRzVYQVdK?=
 =?utf-8?B?VUFqL0hHMXI4enhZMzFtbjViTTRkR1RYYXlNR2t3K3ZGVU5PQldDbFZqU1FS?=
 =?utf-8?B?Ny8ybWFsT3pEUTNhaHdpUlkzYWpRcCt2cGUvZEx2cnpIV216dFB1aVJNYnZo?=
 =?utf-8?B?RWhlMkFWazVJcCs3a1hlbGxCalFBK0RoQmFwRGR6UU43dUhQdC9VTW5WcUdp?=
 =?utf-8?B?Ri9hL2RZejRpbmdXdy9Dbm1SMmZrYk9NWXVtbDduRWo4YlQ5NHVoZTk2UURm?=
 =?utf-8?B?TlRIbjZGYVJhdWd3QmV5Nm1mWWc5VzFyOGRBUFNoYmxyU1pKV0F3NmVYZ1B6?=
 =?utf-8?B?YkdpWVlRMmxCMVlYUkZ0TnJNOXFsNGdEMEVISDd2UG5HaEVUaW9ndXMxbnFS?=
 =?utf-8?B?WEdnR1owWnhwYlBPTzdLUlUxNzdLUWpJenJWT2p1czZKL2tvQ0ZidFFia2U0?=
 =?utf-8?Q?eWmAPaAiSqDVWMLotiJdofpiR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556890a4-f296-4b84-4b7d-08db76f946f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 10:28:41.1759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WV+20wnTMNmQNTs4KRf1pSRgi0uIUEZl6puUpdhGMIcuaAKxCwPf1sERc2IRfBKTqvuMd8rD7BK4T1qpbSidc1yFIdBlzjcatXwe2OSFAG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5052
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=zhenzhong.duan@intel.com; helo=mga09.intel.com
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0u
bWFydGluc0BvcmFjbGUuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIEp1bmUgMjcsIDIwMjMgNjoyMiBQ
TQ0KPlRvOiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj5DYzog
YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IGNsZ0ByZWRoYXQuY29tOyBxZW11LWRldmVsQG5v
bmdudS5vcmc7DQo+YXZpaGFpaEBudmlkaWEuY29tOyBQZW5nLCBDaGFvIFAgPGNoYW8ucC5wZW5n
QGludGVsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvM10gdmZpby9wY2k6IEZpeCBy
ZXNvdXJjZSBsZWFrIGluIHZmaW9fcmVhbGl6ZQ0KPg0KPj4+PiAgb3V0X2RlcmVnaXN0ZXI6DQo+
Pj4+ICAgICAgcGNpX2RldmljZV9zZXRfaW50eF9yb3V0aW5nX25vdGlmaWVyKCZ2ZGV2LT5wZGV2
LCBOVUxMKTsNCj4+Pj4gICAgICBpZiAodmRldi0+aXJxY2hpcF9jaGFuZ2Vfbm90aWZpZXIubm90
aWZ5KSB7DQo+Pj4+ICAgICAgICAgIGt2bV9pcnFjaGlwX3JlbW92ZV9jaGFuZ2Vfbm90aWZpZXIo
JnZkZXYtDQo+PmlycWNoaXBfY2hhbmdlX25vdGlmaWVyKTsNCj4+Pj4gICAgICB9DQo+Pj4+ICsg
ICAgdmZpb19kaXNhYmxlX2ludGVycnVwdHModmRldik7DQo+Pj4+ICsgICAgaWYgKHZkZXYtPmlu
dHgubW1hcF90aW1lcikgew0KPj4+PiArICAgICAgICB0aW1lcl9mcmVlKHZkZXYtPmludHgubW1h
cF90aW1lcik7DQo+Pj4+ICsgICAgfQ0KPj4+DQo+Pj4gQnV0IHRoaXMgb25lIHN1Z2dlc3RzIGFu
b3RoZXIgb25lIGFzIGl0IGxvb2tzIGEgcHJlLWV4aXN0aW5nIGlzc3VlPw0KPj4gWWVzLCBpdCdz
IGFub3RoZXIgcmVzb3VyY2UgbGVhayBJIGp1c3QgZm91bmQuDQo+PiBOb3Qgc3VyZSBpZiBpdCdz
IGJldHRlciB0byBhbHNvIG1lcmdlIGFib3ZlIGNoYW5nZSB0byB0aGlzIHBhdGNoIHdoaWNoDQo+
PiBpcyB0YXJnZXRpbmcgcmVzb3VyY2UgbGVhayBpc3N1ZXMsIG9yIHRvIFBBVENIMiB3aGljaCBp
cyB0YXJnZXRpbmcNCj5vdXRfZGVyZWdpc3RlciBwYXRoLCBvciB0byBjcmVhdGUgYSBuZXcgb25l
Lg0KPj4gQW55IHN1Z2dlc3Rpb24/DQo+DQo+SW4gZ2VuZXJhbCB0aGV5IGFyZSBhbGwgYnVncyBp
biB0aGUgc2FtZSBkZXJlZ2lzdHJhdGlvbiBwYXRoLCBidXQgZWFjaCByZXNvdXJjZQ0KPmlzIG5v
dCBiZWluZyB0ZWFyZG93biBjb3JyZWN0bHkuIEkgdGVuZCB0byBwcmVmZXIgJ2xvZ2ljYWwgY2hh
bmdlJyBwZXIgY29tbWl0LA0KPnNvIHRoZXJlJ3Mgd291bGQgYmUgYSBmaXggdGhlIGlycWNoaXBf
Y2hhbmdlIG5vdGlmaWVyIGFuZCBhbm90aGVyIG9uZSBmb3INCj5tbWFwX3RpbWVyIHRlYXJkb3du
LiBCb3RoIHdpdGggdGhlIEZpeGVzIHRhZ3MgdGhhdCBpbnRyb2R1Y2VkIGVhY2ggYnVnLg0KPlVu
bGVzcyBldmVyeXRoaW5nIHdhcyBpbnRyb2R1Y2VkIGJ5IHRoZSBzYW1lIGNoYW5nZSBpbiB3aGlj
aCBjYXNlIHlvdQ0KPndvdWxkIGRvIGV2ZXJ5dGhpbmcgaW4gb25lIHBhdGNoLg0KQ2xlYXIuDQoN
ClRoYW5rcw0KWmhlbnpob25nDQo=

