Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9A57F24A4
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 04:31:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5HSQ-00018b-LN; Mon, 20 Nov 2023 22:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5HSO-00018N-NQ
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 22:29:48 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5HSM-0002HR-2E
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 22:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700537386; x=1732073386;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RA8fDdWbRufhI/Y/28n8VBahmafkrRPyWhw2NT3bkAQ=;
 b=eORXdLpkFRf52fydlUJDZY9bfCjns1vbsrQXveSZGqAguB7vQA4iBbBW
 M5S4iTMzfLl/e2cscx1xXbVg6XXOCp1myI6ztA8mL/Mp5IGeOWyiUBLEp
 c81icp6jcF2IxjulqUf8bj72Xbfm9CaC0/cEdnFQbok2dc6z4YcCALo88
 SrDlzTsig2XVxcopAtVZIMGc/tyRWPIQtPnSQDz1AfsOb2WfkJk3lVgvn
 snHHqpV3xkwAtXGRX/X9fXBxKTKOn4t0TnakKuepZVzdPJgVn6WnSNA1U
 ADNfRyz8zzfSSk/Bkro58o/HpUNARpyfL83Oy1z9OqLWvI2cP08v8hJkb Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4879448"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="4879448"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2023 19:26:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="716406095"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="716406095"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Nov 2023 19:26:49 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 19:26:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 19:26:49 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 19:26:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2D1r/i/M39NtGj9tQX02mFgFBJxjjQEuDzg/p1grkex3TsKjWn/rnQaUtFYcOgNafU1pUomlBPpm6tg+nMElWSDjVkT9W8Mcf82ZVn0geiKxsOW9veesZs8k+LDoxw7wOmh/KcXHAKMt7GZKNIeoCxDTHWWB5wGiR2zr5d1TUON8e3nVUlBFQPKU5DLTgshuK7puuVRzvWYEwMc+Sf1NhkQ2McTN7gJCIPUDTNtcF7jP6TsHkXnXT/gNtfyXOhka1hf/c5mmo+Mp6oIAiKcDv5KBi4mUP8kx7xfQGhT4eWF3PCi+6GWUBUof5EUAIGlZxkWSaAb58OjpuGYN4loiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RA8fDdWbRufhI/Y/28n8VBahmafkrRPyWhw2NT3bkAQ=;
 b=dUNcmBhDIRwn3Z4e/grqdd7/J1S9YtsMHDnHTtmK1Gn2+l+TJxkljEQE0YOBi42iwxy9sy0S/aa+YYrbLXdN3s2Iwej6Npi0tiYZDWTCcAF8CbI7IaK7rMMJ+6qDDuc+wmXB+SYTW6T6Wa7J/oVAZ37ieRlFg3rLHLVlrRVIg56O7JciwVU7RNG0rNtE47sDGWaBcI6dAyD0fIZPc7JhaVgnlWy7k/1SG3ciIIjzZIYIIRlhA+2yI5NFvSF8uDpcRHV1rm6b8eT/M9xCxiUGcNYYdVrms4zMblEbuvG7VcXtebNAu9FdJpwx+VML6BWv8rqYK4pl/YyYiObMfRkjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ2PR11MB7474.namprd11.prod.outlook.com (2603:10b6:a03:4ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 21 Nov
 2023 03:26:41 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 03:26:40 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann
 <kraxel@redhat.com>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Subject: RE: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Thread-Topic: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Thread-Index: AQHaFuTq+kqpFvBx/0+jXWJho7L/CbB+X2AAgAAFFfCAACIGAIAAB2wAgAQAf1CAAFnbgIAAFZjwgAB8wYCAAKx2AA==
Date: Tue, 21 Nov 2023 03:26:40 +0000
Message-ID: <SJ0PR11MB67441701C3CD12A968092CB192BBA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-2-zhenzhong.duan@intel.com>
 <c964fdf3-d6ef-40cd-b4c0-32f1fb8501ae@redhat.com>
 <SJ0PR11MB6744B1B91C890A9A1B81E89792B7A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <248389a7-3f89-42ae-98e7-34d6612cf186@redhat.com>
 <c0c265d6-aaea-4071-b280-b93df459165e@redhat.com>
 <SJ0PR11MB67444672699A62007207FB3492B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ebc65641-4597-4679-8214-0f4555f9bd21@redhat.com>
 <SJ0PR11MB674445FEAD689AF8B5A8A42B92B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <395120c5-06d0-4421-a9b8-20bd79bf3f5c@redhat.com>
In-Reply-To: <395120c5-06d0-4421-a9b8-20bd79bf3f5c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ2PR11MB7474:EE_
x-ms-office365-filtering-correlation-id: 571e0dea-8654-4fe8-e860-08dbea41ad46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eGTjDIG4P8LJMH0XDaHakG1MDvz2uxDVky+xDbYKGAzBmji3Ckqf2LByHULeVnzN7dJcNlEmeHCooOkokuQHaCLVn6AqKuBV+Ct3GCQe5N6izXwhuUkPpXbpSiq6C5HPN+UC7Av4PHnadnvwnnCcmqEWBx5wL8e5tt78PamjShqJYKwI6gMwc9/UQJCVe4hH64MT975kQweW/0xeYSasQpdMvlwaMc4PHnhaq7Inl/jir+ZW7Y41cC3H5D7ePaZj2h1h8jfpi285LKkLwhkgGPb8yeu+c60uDfrT+iaM49rmLvppakNPrpOLCWSKy2UXf/Ezbl6UmsE3WoCKB4QG30vSCdQwVIHN5/STe2SBg8wnbzAnXlHymgXs6lwYKcDwUVI8UhglrPF5KBsecNxn1MMutvCIZQHXERfM/LKnl79uA4jwLWbJo4/zBa3xd1r01HuCyz98b7UmrzDgKSka7QhGwRumoDFJkjamFA6NVRdNuIkZ/3imdoCoEFfFlyxwj61Wt5Zry8nkzQs90EAohjaNj3VhmGywnnWtugRwGueG97guv4nlcXaV7KcHt+e7aFhrN5vm60nbPR3f12hii9LQFIZe/tLtkO5i6clBgVvSycAW0PppFx3i0QSe5e4NTEm1swRC/oweQ2dpaqxw9Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(38100700002)(110136005)(66476007)(86362001)(66946007)(66446008)(76116006)(64756008)(66556008)(54906003)(8936002)(52536014)(316002)(66574015)(53546011)(8676002)(6506007)(82960400001)(4326008)(7696005)(38070700009)(9686003)(5660300002)(122000001)(71200400001)(478600001)(7416002)(83380400001)(41300700001)(2906002)(966005)(55016003)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V09PeXdWQlYwb1A2SGphTkVXQ3ZnRWdJcjlaOEU1ZVVnRHJncWJuWmw0RmRD?=
 =?utf-8?B?SUVFcWI1UlBXaXJINU1pSGFRS3M0dE5yZ1N4VGJVSGZoellUYllDdzVTSU5x?=
 =?utf-8?B?SVdKbWhJL3FPcCtsRnJDNC93eEtnUW5pMGU5ZDh3MU1FK3JxWVYySjVVdmg2?=
 =?utf-8?B?MlhqbUZvWnR4cVpYSFNZT3FqRStLRWNKOWJrUUJaMHdjWWFsVG9PTUI2Vkxo?=
 =?utf-8?B?OS9Pb0lnL0dnZUJoZXY5K1N0dTIwZjFTSXFkZVl6Q1RvcXFtMTRDUmdUWDVQ?=
 =?utf-8?B?NHNvTUhOTytFZ01kdDBoK01KN1JLdHJ5S1daVklDR21heEd0eThqSzc4S2hj?=
 =?utf-8?B?Y1VhUzR0WHJidXZNL09GRFpBTVpEU3JXUjh0SzlvVlBKZytyL24xNldtanY1?=
 =?utf-8?B?bW45dEJHeHJVSjZkTzd4OTJaS3p1cmtlMzhxUk90b0V2MUVuOENDVmZNemN5?=
 =?utf-8?B?dEhQd0MvVUlzeWNQMG5iRm1QOExraUhrelpNVTFWNEJYL0NQS1IwK0gyalM3?=
 =?utf-8?B?QWtaQlE2RE9xMXdaV1EzQXBxdmlyNzVBMXN1Q3hiZjIzUUhtS1gxdVBVS0dJ?=
 =?utf-8?B?NjFzQnljaHhGQWxCNDNDYkMxMHNtRVBVZGtWdmhac0oybkhIQU9HcmRQeTVR?=
 =?utf-8?B?ZW43NTFjR3ROdUVKdXd3UUkrcDVDdWZGeHh4WkJ4L1QwRzFWUmtsUHcvUTdI?=
 =?utf-8?B?ekJ6bllsT0dOTlhDVGhDNFRlV2RJNkN2N254SVJUVTFVaDhJeTRVM1FXaDNj?=
 =?utf-8?B?Y2l1SEluYitUYmhKVVRHQlh4QzRpR3UrcFdScE5DZjg2N1NyQlJGSDNZU1NU?=
 =?utf-8?B?VVVqSC9Scm13eTRaU2xvT01ubHVJL2l3b1JDM0FCWmozTVBuZFo3bGtkN0hF?=
 =?utf-8?B?SmxkdzZ0d25ITFFVMGxQMjJGeWhlNEVFTG1PNjJvZFFFNWdlVnArUDBpYzdF?=
 =?utf-8?B?QndSelFCVjI1OE9FbXNvZXVWSVNpVDU1WGd3OWpteEhsSFJvcldvbTNpSys1?=
 =?utf-8?B?TkZJYUYwTVNncG1xQkFiWWp3amZEQ1lYZnhlcmU5YW81S1QrRDR3NGc3Mmpq?=
 =?utf-8?B?cjE3cWxJTWVCak5OTUYwY2VJOWRRWFAwUmFYalNoSHlFL3dGQ24rQjhMSXhj?=
 =?utf-8?B?VWhUYmVhZHU2RDhtTGlPdzc4a2YzQmhvYnZTMUk4WmlZMnRIOW5BQUdQVzAv?=
 =?utf-8?B?TkpxaVorbUswVmozaHNWcUg3MStOaVdFU1lUTEhhTURjQjFWRXdSU2U3R0Rq?=
 =?utf-8?B?VFZkK0FaNmtOdkJ5ZTM5Zmt5Zm1lNGVTaXFpWkJWT29ydlIwVGF0K05ES2FK?=
 =?utf-8?B?TzJ1bFRQS3pSRmhCV0dGTDNUYmZPZWs4a0JHVnhPTTNINWEzb1U3bHk0Qllz?=
 =?utf-8?B?L21xeTk2K0YvbzdBaW5wLzhOeGhCSERXU1Y1YWhxYmlKZ0xZc29UZ0JWTWtJ?=
 =?utf-8?B?WmhPVHlJdjdibTlEUVVOVy8rYVVpWFhBQzRFYkNRdHBQMFM0TVVxR0hra1JN?=
 =?utf-8?B?UkN2MHBHdGZ6VktiUVFxK1o4NHIyYk1mbm9sbHBrT2ZBUm01NUtNVm83eVN5?=
 =?utf-8?B?Wis0d2Y4RTAvaTV6QUlBSDk4Um1FbUp4TFFEc2NBK09qY09LVU1TdzQvYlNC?=
 =?utf-8?B?eFVVYThFZm9Yd09nR0FhTUpkQTBZR2FlLzJod1VFOHp6ek9tcmdOdGtKdEow?=
 =?utf-8?B?cWsrN0MzRHNWZisvSjFiS3cvRVBYNlJEVlVHRXoySGhTcE0zSWZUR2J3TUlP?=
 =?utf-8?B?ZUlXdmZsbWV1aUtmZExLZUZsamU0ZzJ1OWJvOHgzVUsxcG1jS2FpVnk5YUIz?=
 =?utf-8?B?OUorV01jSUdHRWlDZVdRd1czc3h6Mis1NHEzS3ZMeEdPdFJPM3FLVDQweWNE?=
 =?utf-8?B?azNRQjNNODVuSlIyTW1kWitVVkZSZGVBQ3VLdmgvTTFsOThrcC9yT082bXM5?=
 =?utf-8?B?YlU3Tkx2dWFJR2xxcmpNU1U4S2JDUVlqb1VTZXdzRlhIRG10bDc5YTd6WGxk?=
 =?utf-8?B?NG1WKzlnVGROZ29zRmRCTFJTNDd2NmgxcmF4bENpOXA3NldBUmpycG5oWjdt?=
 =?utf-8?B?QnVPWEttL1cyTHBiMjg4bC9tQlN6SC9qM01OYVQ3QjkyVmcyaGJpZ29OaTZJ?=
 =?utf-8?Q?Bvo0JpN8XkRJV7ofUNC8JXSwd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571e0dea-8654-4fe8-e860-08dbea41ad46
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 03:26:40.3692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmJeRivVu3bGwRLw4nEb8wgBHCPA1YebNRB99ayA/z4a26ILYwq0hRr1R0/HfALVVN6eWV0OLJng3y9RqOGmEPmfEwAMzu2BesOFOauxXcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7474
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAyMSwgMjAyMyAxOjA5
IEFNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NiAwMS8yMV0gYmFja2VuZHMvaW9tbXVmZDogSW50
cm9kdWNlIHRoZSBpb21tdWZkIG9iamVjdA0KPg0KPkhlbGxvIFpoZW56aG9uZw0KPg0KPk9uIDEx
LzIwLzIzIDExOjA3LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+PiBIaSBDw6lkcmljLA0KPj4N
Cj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEPDqWRyaWMgTGUgR29h
dGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+PiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDIwLCAyMDIz
IDQ6MjUgUE0NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDAxLzIxXSBiYWNrZW5kcy9pb21t
dWZkOiBJbnRyb2R1Y2UgdGhlIGlvbW11ZmQNCj5vYmplY3QNCj4+Pg0KPj4+Pj4+PiBBIHNpbWls
YXIgaXNzdWUgd2l0aCBhIGZpeCBzdWJtaXR0ZWQgYmVsb3csIGNjaW5nIHJlbGF0ZWQgcGVvcGxl
Lg0KPj4+Pj4+PiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwv
MjAyMy0xMS9tc2cwMjkzNy5odG1sDQo+Pj4+Pj4+IEl0IGxvb2tzIHRoZSBmaXggd2lsbCBub3Qg
d29yayBmb3IgaG90cGx1Zy4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gT3IgYmVsb3cgcWVtdSBjbWRsaW5l
IG1heSBoZWxwOg0KPj4+Pj4+PiAiLWNwdSBob3N0LGhvc3QtcGh5cy1iaXRzLWxpbWl0PTM5Ig0K
Pj4+Pj4+DQo+Pj4+Pj4gZG9uJ3QgeW91IGhhdmUgdGhlIHNhbWUgaXNzdWUgd2l0aCBsZWdhY3kg
VkZJTyBjb2RlLCB5b3Ugc2hvdWxkPw0KPj4+Pj4NCj4+Pj4+IEkgdGVuZCB0byBiZSBsYXp5IGFu
ZCB1c2Ugc2VhYmlvcyBmb3IgZ3Vlc3RzIG9uIHRoZSBjb21tYW5kIGxpbmUuDQo+Pj4+PiBJIGRv
IHNlZSB0aGUgZXJyb3Igd2l0aCBsZWdhY3kgVkZJTyBhbmQgdWVmaS4NCj4+Pj4+DQo+Pj4+PiBI
b3dldmVyLCB3aXRoIHRoZSBhZGRyZXNzIHNwYWNlIHNpemUgd29yay1hcm91bmQgYW5kIGlvbW11
ZmQsIHRoZQ0KPj4+Pj4gZXJyb3IgaXMgZGlmZmVyZW50LCBhbiBFRkFVTFQgbm93LiBTb21lIHBh
Z2UgcGlubmluZyBpc3N1ZSBpdCBzZWVtcy4NCj4+Pj4NCj4+Pj4gWWVzLCB0aGlzIHJlbWluZHMg
bWUgb2YgaW9tbXVmZCBub3Qgc3VwcG9ydGluZyBwMnAgbWFwcGluZyB5ZXQuDQo+Pj4NCj4+PiBP
Sy4gU2hvdWxkIHdlIHRyYW5zZm9ybSB0aGlzIGVycm9yIGluIGEgd2FybmluZyA/IFRoZSBjb2Rl
IG5lZWRzDQo+Pj4gYXQgbGVhc3QgYSBjb21tZW50Lg0KPj4NCj4+IE1ha2Ugc2Vuc2UsIHRob3Vn
aCBJJ20gbm90IGNsZWFyIGlmIHRoZXJlIGlzIG90aGVyIGNvcm5lciBjYXNlIHJldHVybiBFRkFV
TFQuDQo+DQo+eWVwLiBUaGF0J3MgdGhlIHByb2JsZW0uDQo+DQo+PiBJIHBsYW4gYmVsb3cgY2hh
bmdlIGluIHY3Og0KPj4NCj4+IGRpZmYgLS1naXQgYS9iYWNrZW5kcy9pb21tdWZkLmMgYi9iYWNr
ZW5kcy9pb21tdWZkLmMNCj4+IGluZGV4IDUzZmRhYzRjYzAuLmJhNThhMGViMGQgMTAwNjQ0DQo+
PiAtLS0gYS9iYWNrZW5kcy9pb21tdWZkLmMNCj4+ICsrKyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0K
Pj4gQEAgLTE3OCw3ICsxNzgsMTMgQEAgaW50IGlvbW11ZmRfYmFja2VuZF9tYXBfZG1hKElPTU1V
RkRCYWNrZW5kDQo+KmJlLCB1aW50MzJfdCBpb2FzX2lkLCBod2FkZHIgaW92YSwNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhZGRyLCByZWFkb25seSwgcmV0KTsNCj4+
ICAgICAgIGlmIChyZXQpIHsNCj4+ICAgICAgICAgICByZXQgPSAtZXJybm87DQo+PiAtICAgICAg
ICBlcnJvcl9yZXBvcnQoIklPTU1VX0lPQVNfTUFQIGZhaWxlZDogJW0iKTsNCj4+ICsNCj4+ICsg
ICAgICAgIC8qIFRPRE86IE5vdCBzdXBwb3J0IG1hcHBpbmcgaGFyZHdhcmUgUENJIEJBUiByZWdp
b24gZm9yIG5vdy4gKi8NCj4+ICsgICAgICAgIGlmIChlcnJubyA9PSBFRkFVTFQpIHsNCj4+ICsg
ICAgICAgICAgICB3YXJuX3JlcG9ydCgiSU9NTVVfSU9BU19NQVAgZmFpbGVkOiAlbSwgUENJIEJB
Uj8iKTsNCj4+ICsgICAgICAgIH0gZWxzZSB7DQo+PiArICAgICAgICAgICAgZXJyb3JfcmVwb3J0
KCJJT01NVV9JT0FTX01BUCBmYWlsZWQ6ICVtIik7DQo+PiArICAgICAgICB9DQo+PiAgICAgICB9
DQo+PiAgICAgICByZXR1cm4gcmV0Ow0KPj4gICB9DQo+Pg0KPj4gSSBmYWlsZWQgdG8gY2hhbmdl
IHZmaW9fY29udGFpbmVyX2RtYV9tYXAgcHJpbnQgYXMgd2FybmluZyBiZWNhdXNlIGZvciBsZWdh
Y3kNCj5jb250YWluZXIsIGl0J3MgcmVhbCBlcnJyby4NCj4+IFNvIHByaW50IGFmdGVyIGZpeDoN
Cj4+DQo+PiBxZW11LXN5c3RlbS14ODZfNjQ6IHdhcm5pbmc6IElPTU1VX0lPQVNfTUFQIGZhaWxl
ZDogQmFkIGFkZHJlc3MsIFBDSQ0KPkJBUj8NCj4+IHFlbXUtc3lzdGVtLXg4Nl82NDogdmZpb19j
b250YWluZXJfZG1hX21hcCgweDU2MGNiNmNiMTYyMCwNCj4weGUwMDAwMDAwMjEwMDAsIDB4MzAw
MCwgMHg3ZjMyZWQ1NWMwMDApID0gLTE0IChCYWQgYWRkcmVzcykNCj4NCj5JIGFtIE9LIHdpdGgg
dGhhdC4gTGV0J3Mgc2VlIHdoYXQgdGhlIG90aGVycyBoYXZlIHRvIHNheS4NCj4NCj4+Pg0KPj4+
PiBTbyBFRkFVTFQgaXMgZXhwZWN0ZWQuIE1heWJlIEkgc2hvdWxkIGFkZCBhIGNvbW1lbnQgaW4g
ZG9jcy9kZXZlbC92ZmlvLQ0KPj4+IGlvbW11ZmQucnN0DQo+Pj4NCj4+PiBZZXMuIEl0IHdvdWxk
IGJlIGdvb2QgdG8gaGF2ZSBhIGxpc3Qgb2YgZ2FwcyBhbmQgZWZmZWN0cyBpbiB0aGUNCj4+PiBk
b2N1bWVudGF0aW9uLiBTZWUgSmFzb24ncyBwcmVzZW50YXRpb24gYXQgTFBDLg0KPj4+DQo+Pj4N
Cj4+Pg0KPmh0dHBzOi8vbHBjLmV2ZW50cy9ldmVudC8xNy9jb250cmlidXRpb25zLzE0MTgvYXR0
YWNobWVudHMvMTI5Ny8yNjA3L0xQQzIwMg0KPj4+IDNfaW9tbXVmZC5wZGYNCj4+DQo+PiBJIHNl
ZSwgUENJIFBlZXIgdG8gUGVlciBhbmQgUE9XRVIvU1BBUFIgYXJlIHJlbGF0ZWQgdG8gcWVtdSBp
b21tdWZkDQo+aW1wbGVtZW50YXRpb24uDQo+PiBGb3IgUE9XRVIvU1BBUFIsIHdlIGhhdmUgIlN1
cHBvcnRlZCBwbGF0Zm9ybSIgc2VjdGlvbi4NCj4NCj55ZXMuDQo+DQo+PiBCZWxvdyBhcmUgb3Ro
ZXIgZ2FwcyBJIGNhbiB0aGluayBvZiBmb3Igbm93Og0KPj4NCj4+IEdhcHM6DQo+PiAxLiBkaXJ0
eSBwYWdlIHN5bmMsIFdJUCAoSm9hbykNCj4+IDIuIHAycCBkbWEgbm90IHN1cHBvcnRlZCB5ZXQu
DQo+PiAzLiBmZCBwYXNzaW5nIHdpdGggbWRldiBub3Qgc3VwcG9ydCByYW0gZGlzY2FyZCh2Zmlv
LXBjaSkgYXMgbm8gd2F5IHRvIGtub3cgaXQncw0KPmEgbWRldiBmcm9tIGEgZmQuDQo+DQo+Q2Fs
bCB0aGUgc2VjdGlvbiBDYXZlYXRzIG1heWJlPw0KDQpHb3QgaXQuDQoNClRoYW5rcw0KWmhlbnpo
b25nDQo=

