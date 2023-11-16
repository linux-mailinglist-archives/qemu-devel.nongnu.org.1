Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A449C7EDD17
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 09:48:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Y22-0002pu-Hp; Thu, 16 Nov 2023 03:47:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3Y1v-0002p4-0e
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 03:47:19 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3Y1r-0001Lr-E1
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 03:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700124436; x=1731660436;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PdvodlY8PWd7E/BvUHbcDPjjLzAB5C3baVvrP/MAdps=;
 b=Ru7h5JpDhLcXEXHIxWM+I6VOHJWQJnQyUlHdr6/yCQOe3F34U+AinvWQ
 hnjabJzKYvdpiPTfnHg0i71QeIEKx5XQ8bm08mp4L8qBYeCwc71KrJ0kr
 lNrcFU4pXqcYUnCUSWg0/CVbv9dHg857vPkIDoxvQ6fcx/PxVvFY2gsv4
 mDXc1P4nVMyax9VkE1Oe5AH3IG32o8u+9NXMohpT5kvheHi56+6Cr+Mm7
 oIvQtZhsOvtPj0zEdu/DEBH9BzINuPThoPHAI5XRQidrNoOsK1xh9Lfnf
 5mok0JU8PmItfJPL+6C6fRJ2eBO1KqQ7k6jet5ILHdP0qA5mdSo9601pf Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="4123051"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="4123051"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2023 00:47:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="882677496"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; d="scan'208";a="882677496"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Nov 2023 00:47:11 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 00:47:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 00:47:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 00:47:10 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 00:47:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0K0brPrQMnVFpG1C1s2YWe6lOI+gjJXAECp+iGwcIK88om+H46tyfsphnQTdLL255ToBkNnNMOmM70F8dRFsEIrwTFCxsOekuOnIs2+Lv+rm0nKwOKVkGvBAnr5ChvJN2RD8U5/QIuRUNqoFXwWLKwsDguqSGB+mGwVbg0L7CZ/zUtyO+QoEysq8kmHy5rMsyAtS/f2x/pMweIBD8NUiNwN33tDJVszN7rI5H+2Ilk82WIMDC9gn5PESTs+Znc7kVZ7xgaol20SHaOCZNmDGLa42cvk6dIwp67eOokL4cRkm6v1qQlIbBszC6lSEOFP82Q06/hUlBnfPPF9vq7+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdvodlY8PWd7E/BvUHbcDPjjLzAB5C3baVvrP/MAdps=;
 b=oZjhx0X1zi1mFj1uUrUe8zSg4hLbmkI8Q5Tgq4bO5IQeFcvmVT/6erBAXhQi7mX1gDprS0cLw+UUGhvhtvaNH3o1kcog55aKa2X1rlxCtnpFpBRsKhHjpGDBIiT0pTQ3fLlseEfWO5kekK1VHnvRftQzx4lEC+lqtUfBVTEMhTom15BkI29Wnub31vMRFoUXJgl+I+jdyIbVkG1X5j3XCWyUF8E6gBEHaM1Nvepp7bh6uEUF8x8YXYJX9Jvox462pKTExbFW7vPuxkNIC9CJuHgsqcAO14iix6h4nYezj4R/CPeAFh51lWxHOf/mxHvVvJtk40FYGucLYM6uvPAEdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB4910.namprd11.prod.outlook.com (2603:10b6:a03:2d7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 08:47:08 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6977.029; Thu, 16 Nov 2023
 08:47:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Thread-Topic: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Thread-Index: AQHaFuTq+kqpFvBx/0+jXWJho7L/CbB7V4QAgAD6yFCAAE7dAIAAAZtw
Date: Thu, 16 Nov 2023 08:47:07 +0000
Message-ID: <SJ0PR11MB6744F1531AD1FCBE89C0139292B0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-2-zhenzhong.duan@intel.com>
 <2599bd21-31fa-490e-aecd-0749c4abe657@redhat.com>
 <SJ0PR11MB674492FC92766292663D698792B0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ac069b07-d732-44db-a707-3e5deebe29af@redhat.com>
In-Reply-To: <ac069b07-d732-44db-a707-3e5deebe29af@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB4910:EE_
x-ms-office365-filtering-correlation-id: 83778fc7-542b-4114-b366-08dbe6809daa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R0WteGOoIYqCxqm+DYQl9BEV9cPAoeiFyoSfs27AfGFqkYc2QGOJGXk4qGzKJj8UzKVy8leM6WOL4D8I3Kg5j+dfRQxhrN4eOySCzmQXN3JNF0/6bdCfzzP4OIZjwpnR9jTabzDeihJaVUpdQ4FdlMmCfLzu4ky9rzj+ESuVIZr7TsAaePtv6jMEf763pCxVrh8A4ZXvPSio1jR+5w84R5G0jc2bsyFpAlG7lcBW58qEWbofsm7xpif+OmUdy2vp0wdtEjoUdbTaFL5XWatt/AY3ke9R+w61Fvrk88wkwXrCuhcL91Oi0ABcES3VNdC4iVL8HBfzxfnU4wzOWPIBgu2aYzPtff4P6N09oj7+2pO8A6uTYxP6KAihSOi+Fw1k0eXA9Tr+WVP5uwA36UOeHV1CSq/hHoSmhON4Yi50KB58nfLPh/jpCr4yKoFeeT+SllTfMk7isR+YOJQBZdByw6h4jE7zGFo7JVagcBFu5japSKEihojjXWS7Y7bKUfZrbH8J/O647vkr+YmSr8jZ5RtW0+tuA5cYgxMttry999w36G9cXKcgLP8Ololj3j17LmjI8uqPZ6uplbLwZoAkprQ5VnRxyhWDm/yyrji4FG0VFYYy43HYyB2PWnQKrvbs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(7416002)(9686003)(82960400001)(122000001)(26005)(2906002)(8936002)(38070700009)(478600001)(66446008)(52536014)(5660300002)(86362001)(66476007)(41300700001)(33656002)(8676002)(316002)(110136005)(54906003)(76116006)(66556008)(64756008)(4326008)(66946007)(6506007)(53546011)(7696005)(71200400001)(83380400001)(38100700002)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVJacFZpRC9Lc1VZSDVvd1ZiZGE0U2xzbDJqTkxNaEhQTXE1dEQ3V0JUWmtN?=
 =?utf-8?B?a2NLcWxwL00xaVd1MkJrK1ZKN1QzR3pBWnJJbzluOFlhaytoV043Nk1Qc0tY?=
 =?utf-8?B?LzV3WDUrYysyc1IzYTZsRzlnWGIybEhwdmtOdE5nZXYwVG0rZUhkVnJEb09a?=
 =?utf-8?B?NC9oL0p0MnVLenp6TU82eW9IaCtWVDEyckJuN2NOSmpienpoTlF5b0ZwNXcv?=
 =?utf-8?B?bll4bjhsbjRDaG80bGROSnpyRjJOVGVQeWJaYU9IRVhURUJYaklQakZVd20x?=
 =?utf-8?B?RU44SmwzMTRLZW5FMHFYaWdTODdIYVFtd0FaU0E5czZ6dFRSUFRndmlKd0Nn?=
 =?utf-8?B?Nm9xWkNsTTRCaVNLUHRxeXZYWG90WE9tWXA1aGM3N0xuUVdVeWVTUEVaOU9l?=
 =?utf-8?B?cHZjc0w3bTJXUFJsQWdwT1hwYnE4cUlSL3c0S0Z2a0M4OXQvNUt4K0ZSNXBj?=
 =?utf-8?B?bzRYRUhUMC92MGIrdUdNYk5teTc2eHdLT0Mxc2x2Q2JmNTIwZ2d3cnpUYmxm?=
 =?utf-8?B?SUZNeG1VM3RIY3NIdjlkYkwyK01RbGk1QjU3RHpraE13RWFLQnZ0c2lXRDFP?=
 =?utf-8?B?ckRnaXJWQ1pnRnZvY0Yxd0w1d1ZnVTlhdE1hSDQrZTQzTTJYeHlwVE9wc0hV?=
 =?utf-8?B?eXVVR3FZRllNTms0R1VlZXlVS3IyMFFMZTdJeC9HREJOZm4zY0g0UjlXUmRx?=
 =?utf-8?B?MWlZMmpjZVA3WnNMYXFQRldOUEZQMjd5VVdlU2Q0RW9tWmtLUEMvc284K1NF?=
 =?utf-8?B?VGp3VnM5aTZRUU91eDJOU0JvOVg0THJJazVka2NaL3hXbUFRcS8rdXo5WGhJ?=
 =?utf-8?B?QmdKOTlaOGljaGpNZGdNYVcxQWRmbTkxK1B3aktsSTd0cXJ6czNic0dxWWN5?=
 =?utf-8?B?RkNMY1Z0UldtVHZXL1FvOE9mWG92UWkzY2JzWFhLajF1eHNubFIzTm04L0V6?=
 =?utf-8?B?RVlBRHl3WnpDaTZtTUY3SE42QURyUkQ3QTRkdk1vWE5WNG44azhtM1VhNTRU?=
 =?utf-8?B?NGpaN2M2RXY0RTduNEdPSVRxZlFKMEwzWmpYYnR6WHduVlF5NmNIL3pETnFC?=
 =?utf-8?B?ZWNvblFBZnVRNmlCd0NXVmdnMnNnbGNHVVdoeG5QRmZFVVNjQjlIYjNYSVpm?=
 =?utf-8?B?MkdKQSt4Z0hmK0QrRWxmVmRyOXNIVVpwRUNFNEVtaWxVTVhzZVQzYVkyVTI1?=
 =?utf-8?B?bW1nSjhVNFdnZVRpbDAzK0JCb0JpcE5sQ3YzQ3NBckhDaFU3cEpNZTVDRzBu?=
 =?utf-8?B?ZXdBelNycTRPODNqbmlLeVVqL1dJNFNlK3BWd2tQSXhqc3ZJVnpBb0NmRDg3?=
 =?utf-8?B?dDcwUDY0aEE0V0Ftay81R3NFSlltdEsxSldvdThJa0JhdmM5dmVGK2JPRXF5?=
 =?utf-8?B?cjZtSTZ3OTFOT01ER05vMnlzQ1JiUHRrOHFtM3NBNExqaGpmckhoNVFuSk5C?=
 =?utf-8?B?d0VKYTZySzhJd3haUFRnV0tEUHFiZGJIWmRaNEUvNVhMNTFaTUNiTzZHMVh6?=
 =?utf-8?B?Q0xzUGViOHdRNGlORFFBcHlueUlMYmlFYnFMQkJnNGxHTFk2VC9DYzgxZHp4?=
 =?utf-8?B?R1FyeXRKaDQzM1FxK05TWWdabTZaZnFDVzA3WU5FR0lzYkhuUkdWMWE4bEJL?=
 =?utf-8?B?U3ZCdmt1TnZUelFodEl5TFJiL2tNSU5iNXk0Y3pUWGIySUdQR0RPalljcWx1?=
 =?utf-8?B?THlMdEM0KzRvVEQ0anIxaThnTWJnUjNHQXVFQThOWnliVzJkTzFSR1dBL3Ft?=
 =?utf-8?B?MmU5OWdZN2RjU24wY1pTc1dBeW5UT21zbUl0UWYxb3A1TjFTOEdyWTd4U1Jz?=
 =?utf-8?B?VzdoSEh3RXFyUDF6U2VDbzI5aGw4U2N5dDgwYWQvSGhUUFN1QnBLVk5MNUli?=
 =?utf-8?B?aHNkc0FuUTRXWnRwb1ZFb2dVd1c2aTA1M2FiVHVhbGxDU2VYRHlPQTVLeWVD?=
 =?utf-8?B?SjN4aU52WFI3cElkQUpiRWxuVTZZcnIrbkVLcFJVV3E4SXczZExYM0UrdWRB?=
 =?utf-8?B?UzlSQ2w0d3lYSVNCZm5UbnJ3NUpBaTE1MEphUnZPVUNNaFlyaU1GUWVvUGdk?=
 =?utf-8?B?VEZ3MDBTYjJ3bWR6QVlYUmVLZkxidkpxZ0xRZjkyRkRURHY1WXU2cTZqajZo?=
 =?utf-8?Q?o4oSWlLz8x2j6iW2L6OxGT4nW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83778fc7-542b-4114-b366-08dbe6809daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 08:47:07.8252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pIkkhRWmXZDMFv+lOrATNgMx2ToSYEU1Q9FnBcsvT4VtjTHqWtM0U+kSBQrJihVMSmdJdlWUbjb4EvTm5b2pWwlXaNJwg0NVuROdBxpbWWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4910
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTYsIDIwMjMgNDoz
MyBQTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDEvMjFdIGJhY2tlbmRzL2lvbW11ZmQ6IElu
dHJvZHVjZSB0aGUgaW9tbXVmZCBvYmplY3QNCj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+T24gMTEv
MTYvMjMgMDU6MDQsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+IEhpIEVyaWMsDQo+Pg0KPj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5h
dWdlckByZWRoYXQuY29tPg0KPj4+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTUsIDIwMjMg
ODo1MyBQTQ0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDEvMjFdIGJhY2tlbmRzL2lvbW11
ZmQ6IEludHJvZHVjZSB0aGUgaW9tbXVmZA0KPm9iamVjdA0KPj4+DQo+Pj4gSGkgWmhlbnpob25n
LA0KPj4+DQo+Pj4gT24gMTEvMTQvMjMgMTE6MDksIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+
PiBGcm9tOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4+DQo+Pj4+IElu
dHJvZHVjZSBhbiBpb21tdWZkIG9iamVjdCB3aGljaCBhbGxvd3MgdGhlIGludGVyYWN0aW9uDQo+
Pj4+IHdpdGggdGhlIGhvc3QgL2Rldi9pb21tdSBkZXZpY2UuDQo+Pj4+DQo+Pj4+IFRoZSAvZGV2
L2lvbW11IGNhbiBoYXZlIGJlZW4gYWxyZWFkeSBwcmUtb3BlbmVkIG91dHNpZGUgb2YgcWVtdSwN
Cj4+Pj4gaW4gd2hpY2ggY2FzZSB0aGUgZmQgY2FuIGJlIHBhc3NlZCBkaXJlY3RseSBhbG9uZyB3
aXRoIHRoZQ0KPj4+PiBpb21tdWZkIG9iamVjdDoNCj4+Pj4NCj4+Pj4gVGhpcyBhbGxvd3MgdGhl
IGlvbW11ZmQgb2JqZWN0IHRvIGJlIHNoYXJlZCBhY2Nyb3NzIHNldmVyYWwNCj4+Pj4gc3Vic3lz
dGVtcyAoVkZJTywgVkRQQSwgLi4uKS4gRm9yIGV4YW1wbGUsIGxpYnZpcnQgd291bGQgb3Blbg0K
Pj4+PiB0aGUgL2Rldi9pb21tdSBvbmNlLg0KPj4+Pg0KPj4+PiBJZiBubyBmZCBpcyBwYXNzZWQg
YWxvbmcgd2l0aCB0aGUgaW9tbXVmZCBvYmplY3QsIHRoZSAvZGV2L2lvbW11DQo+Pj4+IGlzIG9w
ZW5lZCBieSB0aGUgcWVtdSBjb2RlLg0KPj4+Pg0KPj4+PiBTdWdnZXN0ZWQtYnk6IEFsZXggV2ls
bGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6
IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTog
WWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9u
ZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiB2NjogcmVt
b3ZlIHJlZHVuZGFudCBjYWxsLCBhbGxvY19od3B0LCBnZXQvcHV0X2lvYXMNCj4+Pj4NCj4+Pj4g
IE1BSU5UQUlORVJTICAgICAgICAgICAgICB8ICAgNyArKw0KPj4+PiAgcWFwaS9xb20uanNvbiAg
ICAgICAgICAgIHwgIDE5ICsrKysNCj4+Pj4gIGluY2x1ZGUvc3lzZW11L2lvbW11ZmQuaCB8ICA0
NCArKysrKysrKw0KPj4+PiAgYmFja2VuZHMvaW9tbXVmZC5jICAgICAgIHwgMjI4DQo+KysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+ICBiYWNrZW5kcy9LY29uZmln
ICAgICAgICAgfCAgIDQgKw0KPj4+PiAgYmFja2VuZHMvbWVzb24uYnVpbGQgICAgIHwgICAxICsN
Cj4+Pj4gIGJhY2tlbmRzL3RyYWNlLWV2ZW50cyAgICB8ICAxMCArKw0KPj4+PiAgcWVtdS1vcHRp
b25zLmh4ICAgICAgICAgIHwgIDEyICsrKw0KPj4+PiAgOCBmaWxlcyBjaGFuZ2VkLCAzMjUgaW5z
ZXJ0aW9ucygrKQ0KPj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvc3lzZW11L2lvbW11
ZmQuaA0KPj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJhY2tlbmRzL2lvbW11ZmQuYw0KPj4+Pg0K
Pj4+PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPj4+PiBpbmRleCBm
ZjEyMzhiYjk4Li5hNDg5MWY3YmRhIDEwMDY0NA0KPj4+PiAtLS0gYS9NQUlOVEFJTkVSUw0KPj4+
PiArKysgYi9NQUlOVEFJTkVSUw0KPj4+PiBAQCAtMjE2Niw2ICsyMTY2LDEzIEBAIEY6IGh3L3Zm
aW8vYXAuYw0KPj4+PiAgRjogZG9jcy9zeXN0ZW0vczM5MHgvdmZpby1hcC5yc3QNCj4+Pj4gIEw6
IHFlbXUtczM5MHhAbm9uZ251Lm9yZw0KPj4+Pg0KPj4+PiAraW9tbXVmZA0KPj4+PiArTTogWWkg
TGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+ICtNOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2Vy
QHJlZGhhdC5jb20+DQo+Pj4gWmhlbnpob25nLCBkb24ndCB5b3Ugd2FudCB0byBiZSBhZGRlZCBo
ZXJlPw0KDQpTb3JyeSwgbWlzc2VkIHRoaXMgY29tbWVudC4NCk15IHBsZWFzdXJlLCBJJ2xsIGFk
ZCBteXNlbGYgaW4gdjcuDQoNCj4+Pj4gK1M6IFN1cHBvcnRlZA0KPj4+PiArRjogYmFja2VuZHMv
aW9tbXVmZC5jDQo+Pj4+ICtGOiBpbmNsdWRlL3N5c2VtdS9pb21tdWZkLmgNCj4+Pj4gKw0KPj4+
PiAgdmhvc3QNCj4+Pj4gIE06IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+
Pj4+ICBTOiBTdXBwb3J0ZWQNCj4+Pj4gZGlmZiAtLWdpdCBhL3FhcGkvcW9tLmpzb24gYi9xYXBp
L3FvbS5qc29uDQo+Pj4+IGluZGV4IGM1M2VmOTc4ZmYuLjFmZDg1NTVhNzUgMTAwNjQ0DQo+Pj4+
IC0tLSBhL3FhcGkvcW9tLmpzb24NCj4+Pj4gKysrIGIvcWFwaS9xb20uanNvbg0KPj4+PiBAQCAt
Nzk0LDYgKzc5NCwyMyBAQA0KPj4+PiAgeyAnc3RydWN0JzogJ1ZmaW9Vc2VyU2VydmVyUHJvcGVy
dGllcycsDQo+Pj4+ICAgICdkYXRhJzogeyAnc29ja2V0JzogJ1NvY2tldEFkZHJlc3MnLCAnZGV2
aWNlJzogJ3N0cicgfSB9DQo+Pj4+DQo+Pj4+ICsjIw0KPj4+PiArIyBASU9NTVVGRFByb3BlcnRp
ZXM6DQo+Pj4+ICsjDQo+Pj4+ICsjIFByb3BlcnRpZXMgZm9yIGlvbW11ZmQgb2JqZWN0cy4NCj4+
Pj4gKyMNCj4+Pj4gKyMgQGZkOiBmaWxlIGRlc2NyaXB0b3IgbmFtZSBwcmV2aW91c2x5IHBhc3Nl
ZCB2aWEgJ2dldGZkJyBjb21tYW5kLA0KPj4+ICJwcmV2aW91c2x5IHBhc3NlZCB2aWEgJ2dldGZk
JyBjb21tYW5kIiwgSSB3b25kZXIgaWYgdGhpcyBhcHBsaWVzIGhlcmUgb3INCj53aGV0aGVyDQo+
Pj4gaXQgaXMgY29weS9wYXN0ZSBvZg0KPj4+IFJlbW90ZU9iamVjdFByb3BlcnRpZXMuZmQgZG9j
Pw0KPj4gTWF5YmUgY29waWVk8J+YiiBJIHRoaW5rcyB0aGlzIGFwcGxpZXMgaGVyZSBiZWNhdXNl
IEkgdXNlIG1vbml0b3JfZmRfcGFyYW0gdG8NCj5nZXQgZmQuDQo+PiBPciBJIG1pc3MgYW55dGhp
bmc/DQo+VGhpcyBpcyBhIGJpdCBjcnlwdGljIHRvIG1lIGFuZCBJIGRvbid0IHJlYWxseSB1bmRl
cnN0YW5kIHdoYXQgaXQgbWVhbnMuDQo+SXQgZG9lcyBub3QgbWVhbiBpdCBpcyBub3QgY29ycmVj
dCBidXQgSSBhbSBjdXJpb3VzIGFib3V0IGV4cGxhbmF0aW9ucw0KPmlmIGFueWJvZHkgaGFzIHNv
bWUgOy0pDQoNCkkgaGF2ZSBhIHdlYWsgdW5kZXJzdGFuZGluZyBvbiB0aGlzLCBtYXkgaGF2ZSBl
cnJvcnPwn5iKDQpRTVAgc3VwcG9ydCBhIGNvbW1hbmQgbmFtZWQgJ2dldGZkJyB0byBzZW5kIGEg
cHJlLW9wZW5lZCBmZCB3aXRoIGEgbmFtZSwNClRoaXMgZmQgaXMgdGhlbiBzdG9yZWQgaW4gYSBm
ZCBsaXN0LiBUaGVuIHdlIGNhbiB1c2UgdGhhdCBuYW1lIHRvIHJlZmVyZW5jZSB0aGUgZmQNCklu
IHRocyBsaXN0Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

