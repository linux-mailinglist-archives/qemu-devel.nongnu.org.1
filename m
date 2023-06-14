Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA1072F9B8
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 11:48:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9N5x-0005SH-5U; Wed, 14 Jun 2023 05:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q9N5u-0005Rk-Qo
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 05:47:14 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q9N5s-0001QD-Pf
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 05:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686736032; x=1718272032;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NR1i0iD5RTZJ9+gNDGPKmuQtDXwSNs9yj2DYSPimPNM=;
 b=cIqO0qiu05ioaIXoSnwj8gmZx4fmxypSiHR1QRpgtm9tsGODn65qhWJt
 +LnugFCzG13yVoPkrO4qqurnd7JZs0izU2JzCM/+IHLXYx4AXMmcm0GFf
 grD8A+C2c3yeDxtd9EvM0uKK0+/rnIF83GkI6Rse29qG0v3mTl1YlHvlI
 eT6+r1w7xoD19H5bUYVlo9uyyPlkvaXqN0N3dqGnCsI9zFg02QGoPSb8o
 Bq3MZ7wW1AeToWMQMfQVbJOmFnfDOzB+Zdcr6F+mbar5IjoA8dBf96nC8
 BKgoY8MwfMFz0Ew+IZiNzzfjS1w82vj7xE9A7WBWDh/U3lhSi+yMmpRzH g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="357449697"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; d="scan'208";a="357449697"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2023 02:47:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="777175577"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; d="scan'208";a="777175577"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga008.fm.intel.com with ESMTP; 14 Jun 2023 02:47:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 02:47:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 02:47:08 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 02:47:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUHrUg/0OEn8ffThPBp91SJjWaeKYfks/FRmPvxefcmXkDUK7pkFSiLsmtMLCf+xFR9FCH4EJ22YlLS3PwEnXt8rdr/8dnsykrxL3VXHrhG1T+AkWybyiw+Aa2zw+wSO8jcf76BEZZ8s5GoJyNECQEWcUcgrGgUL0C/x7sY/lI0pUGBGyw9Drm1IzcDHV7puPKVbMmdEoqQE7sP401nn1hHiSH1hRRnpCTNoxJvLZ3AlfEeba4WR2IgevmxJoteoHRfma0h3qT4DCl+RHQNSqMZC3SgWDk7Tn33E5rcwq7gquvwP1Oy2hlewV6KtbBm3EiZzN3ay1DK71F+/G315ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NR1i0iD5RTZJ9+gNDGPKmuQtDXwSNs9yj2DYSPimPNM=;
 b=KPcpy+7aHWhrFbChbaW/dUuDbkAUp7d81AiDH6RW7KWOpob3TxkXIDBianU3pMoxSLMK9WrrrujrA397d2KLoIwd3Gu9riDujWO7OYJxLo2nAeqZ2xjXzy+k6NCg052WRUbciI+/pddC1ZiW1RfeimE1WkB3Nk7uuW48XWXLUbHXPg7FVHj/awGPAZlmjb44JWN7XHulNxPk8USCP/Y3lY5DRTRzPmNbo3/8VT+CBlIEL3ujVIaUfRg/pgPW4s9e9GXMuXuK4Fu7DA05KH87CIZ+MHLLz2H8d82/4WWjTafTrURy4SPRP+5i0mwDky3ZGGax4jSY+LwULcCM9xom0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ1PR11MB6273.namprd11.prod.outlook.com (2603:10b6:a03:458::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 09:47:05 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6455.043; Wed, 14 Jun 2023
 09:47:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Thread-Topic: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Thread-Index: AQHZmfDNwmLmlvy/GkmXR1XRJDGDhq+A8JUAgAABtYCAABkOgIAADRsAgAA5boCAAKIgUIABChmAgAcQXgA=
Date: Wed, 14 Jun 2023 09:47:05 +0000
Message-ID: <SJ0PR11MB6744197E09699EEFFDDA52A5925AA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-6-zhenzhong.duan@intel.com> <ZIHgFFSaBJWFUNd7@x1n>
 <ZIHhgyUv7YmWsG3H@nvidia.com> <ZIH2h7GAV6qirAgw@x1n>
 <ZIIBhmoT7H2/q0lb@nvidia.com> <ZIIxs9kXQyULglIJ@x1n>
 <SJ0PR11MB6744E9DE31D0424F4104FC469251A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ZIOY6w5n9hLEPUCC@x1n>
In-Reply-To: <ZIOY6w5n9hLEPUCC@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ1PR11MB6273:EE_
x-ms-office365-filtering-correlation-id: 91e3d66c-47fa-4d2c-6abe-08db6cbc4fef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i+HcGMzcj31iWzbxqZ0s5CwaDqQF+km+KAQ6KtGcGEPmEpn+ppHmi3rR8z2VvX1MtJx/0uENIQ2BcMcwIDxcxTHJDYNaEtOR62DsuRQdGeV2lakvYq2/RrbObsoaM4HddSZ1CT6gKweVGg5gfmrkEauNcUWlHvf6Isk0ikX/AT/bea7RCQqqkKWYm8TrDAaxom5j/SOPbPIZVkX3sHPyYhSmlRi7milZIXMrbnK9WAJ3xAnrS6U57liDxzr+LZs/Tzc/eaVuIzBxiG19Xn9DqpXTk2z6IJCj2tWlkuO7EmfVCvEx6AA3dfn5PWKDn8mqV4MExEY/hkjnsy1zGgF9FogKG0YrScCBX5ixIbUfVyTgfFCy/wVhmx8lV+sflqtF6rS8JC7AuugNMPrsjhx+5DyM2tr9IVJIPCwhkiHNo1IftUn8xqdmWUHdPMWr6IyMucO4wIlUPCodBqHA6m5Exy2/0UN5sZ7X1Oc7ge27d5o7JMR5fFUW6K4Uj91TIMspbcXifWzcjzvVhUgTAzuW0oixoyXMNa6Ly4ChZF6AYMBbnBKlRDbzjUnWl0mqB1OaynKx5MP9xRGA6lTxWlTPKo8bxtyxdEAAWEpz+ca2MCN2f5H24a0R2bkUtEToXMNm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199021)(6916009)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(316002)(7696005)(4326008)(71200400001)(107886003)(52536014)(5660300002)(8676002)(8936002)(41300700001)(478600001)(54906003)(86362001)(7416002)(38070700005)(186003)(2906002)(33656002)(38100700002)(82960400001)(122000001)(83380400001)(9686003)(26005)(6506007)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajMveldPcXhQQjd0T1QxRkhPVVZDMkZvU0ZuUWdQYlBobU1DcFJsMnlpcVB1?=
 =?utf-8?B?aVdHd0JNZVdhRS9zU2pxQzRVTlRoZkRqUGFGM0V4VmtYd3JPTXZIaFl6dldG?=
 =?utf-8?B?WDJkZmRaLzNsemUxc3VXSElsc0FuVExHRnJWT1dRTi8vSW13VjhyRWtUS2VV?=
 =?utf-8?B?Y0o5MHlaSDl4bnBaRmtIZWpjeEJWczA0dUh5NzlRQUNPYXNaWGdITkUxbDFL?=
 =?utf-8?B?MlZ4MXhMVm8ybXJ0dnd5OCtqcHliMEdkMEJadFBYeHU0TllsWWRXTnhQRGoz?=
 =?utf-8?B?N1dPZC90bnR2RGZJWnBVMkVEV3NDeFkxMWQzazFxTi9pbVZyM3Y2eFRoZ2I1?=
 =?utf-8?B?Ylk3aU50eUpzcDNOQmkwSk1QL2x2Z3hqR0d4Wk56Tk1HZUZMdDl4NGc3aVk1?=
 =?utf-8?B?WjhBTXhmWGVRU0FLdXl3bkdKNE9kYWZEVDNQSVZqT3lKQi9sTnBMUHljaklF?=
 =?utf-8?B?ZXc5ak1zcXZqWnJUUFNjT0lYNDY4SE9FeUtyektoUkdIZjFpNUdpOURmTWN3?=
 =?utf-8?B?MVF0bldpeFh2Y21JWWdNS1d1OEhzL0h2MG5ZUUNTVlc4WVJsY3hReHBXOEw5?=
 =?utf-8?B?MThaRU55NkY1dTVBRVZCeHUwelZXdTNCN0pXcUdQYUJrMnQ3Sk4zR0hxa2Ux?=
 =?utf-8?B?WFg4ZHhBZUxmQXlCbnBqKzhVcVpOR2dWalFWNGxRM1IrSU04eG5yR21jZUNU?=
 =?utf-8?B?eVF5bFdXQ3dNSmhzSkZ2WjVCVXBKc2x2Y25DNUtrMWduNWpaTHJpU1VmM0ts?=
 =?utf-8?B?ZnBHNFJRRkxGb2dkUXhzZzZxejB1cGNjOUs2NTQ0SnQwR0x4d0ZnR0xuclZv?=
 =?utf-8?B?VFpleGJIdEVOVXhsbmhjb3VIQlhTVCthaFNoN21HU0RhSjdRNTVpWHFuTndX?=
 =?utf-8?B?VzU5eW5XUlhZTHFMTUhMdzQzd1FkQVhUZjUwcXhTb2ZrbitqQVJEYlBGdHNt?=
 =?utf-8?B?S1dSRVlMN1pSUlJLY2laWi9tcnVocm16bVJTUllOYXZ4eU9tMW9RbzJhdm05?=
 =?utf-8?B?MDlWS1U3U1hBeFhKYTdMVm56WlJhTVhNNElxN1NsbDZjM2M3K0ZlcXpVWEhj?=
 =?utf-8?B?bW9IdEpkT2s4RDhSaGlmNGE3UVFJL3NCdU0rTis3amxnTmVveXB1amt6c1hh?=
 =?utf-8?B?ZHg5VEdzTFpxVmV1SjMwdmRRQnFXcUdQKzFlYTZzV3ZFNGlMM1dsa2UyVnFp?=
 =?utf-8?B?V3VoeG1tb2pRWUgyOW9Hdk44NUNvbzVLNk9MUE5xaTNCS0pMN1JjcjJSZFFM?=
 =?utf-8?B?b1VhZWNDU1J4bEtNTkZGSWlPTGtHSm56RGVPSGpVdmhPMHBiWHlkc3FLZW80?=
 =?utf-8?B?eVM4TFY5T09tNWxuRmlkVjI0TFpOV2prNmo1eG4yUXVIeXh3djZPbWtsRlkv?=
 =?utf-8?B?dzNZdnZTZEpVWHN4VGJjcUZzS3N4UTRLNkhaelNKMmZZb0lVY1Zob0lOcDV4?=
 =?utf-8?B?bDBhLzVIdzREV3dGczdDak81Z2lzMVRJTGJWVnlMMzN1SGNpUWwrMmplWlM0?=
 =?utf-8?B?Z0VIelFlaHBqRG04S3ZSV1hpdUZ2Vk5Pc3A4SjRBTnJxRFpiVDRsSkw5VGcr?=
 =?utf-8?B?MFNJREpjK1VkelFLUnVEdXU4NGZOTUZqUmNHV2dHYVlOc0tyeHFpZ2xjM01n?=
 =?utf-8?B?emRlV1M2OTdPZVNQZjNTaDAzdUUxY3A2a1VnaUFDNHRqNU1jNFRycVFlM1Qx?=
 =?utf-8?B?NW9qanVMOFNGSUY1WkMwUlpjSGJBYXhyZHUyV1AxR2FmY1FRYjV2K1ZtVmFo?=
 =?utf-8?B?MTBkcWk3RmpQU3plaFdidmRzRnQ5aUNlaTR4TTVRTFcwZ0x4WUNiYnlWZGh5?=
 =?utf-8?B?bGFzUG5hZDNCNUlheGxDWklyY2RlYnFSVk1ENWwrMGV3VXZLTnExempVSmwx?=
 =?utf-8?B?ODZScTQrbmdxYzVZNnpBNldKbFNhNllyVlpCNWVkT0tDNVRhTzcxUEpqVElo?=
 =?utf-8?B?Zk9jaUtUbTRzOGpyVENhalcwQWQ2VUFaUTI5WHdsWUhqeDN6K0VoWWxkK0Zv?=
 =?utf-8?B?ZlplZVgrSXo3WGNqWnZHR3FlQzU3b1N1TTFucVd2dlhzZ2NZN2U1OGVPck15?=
 =?utf-8?B?M2NmYlBIN3NSZnBSbm1UVURqazdtU0hWWUpJWUoreFd2TmZpUzFvSjJISkpV?=
 =?utf-8?Q?mWSzm38b7C6Bgy5PEoLk5x7P5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e3d66c-47fa-4d2c-6abe-08db6cbc4fef
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 09:47:05.3791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUpM9tU/tIvZCklGLJuewYddZElRpZop6PzJnykzmuhaWI5MRJ0k/1ntpjxSOnp5cHYQiby4il9kTUNugq2xxJF1gB2YTgXuTVHpJZ3yPoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6273
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mga04.intel.com
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

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJl
ZGhhdC5jb20+DQo+U2VudDogU2F0dXJkYXksIEp1bmUgMTAsIDIwMjMgNToyNiBBTQ0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjMgNS81XSBpbnRlbF9pb21tdTogT3B0aW1pemUgb3V0IHNvbWUgdW5u
ZWNlc3NhcnkNCj5VTk1BUCBjYWxscw0KPg0KPk9uIEZyaSwgSnVuIDA5LCAyMDIzIGF0IDA1OjQ5
OjA2QU0gKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+IFNlZW1zIHZ0ZF9wYWdlX3dh
bGtfb25lKCkgYWxyZWFkeSB3b3JrcyBpbiBhYm92ZSB3YXksIGNoZWNraW5nIG1hcHBpbmcNCj4+
IGNoYW5nZXMgYW5kIGNhbGxpbmcga2VybmVsIGZvciBjaGFuZ2VkIGVudHJpZXM/DQo+DQo+QWdy
ZWVkIGluIG1vc3QgY2FzZXMsIGJ1dCB0aGUgcGF0aCB0aGlzIHBhdGNoIG1vZGlmaWVkIGlzIG5v
dD8gIEUuZy4gaXQgaGFwcGVucw0KPmluIHJhcmUgY2FzZXMgd2hlcmUgd2Ugc2ltcGx5IHdhbnQg
dG8gdW5tYXAgZXZlcnl0aGluZyAoZS5nLiBvbiBhIHN5c3RlbQ0KPnJlc2V0LCBvciBpbnZhbGlk
IGNvbnRleHQgZW50cnkpPw0KPg0KPlRoYXQncyBhbHNvIHdoeSBJJ20gY3VyaW91cyB3aGV0aGVy
IHBlcmYgb2YgdGhpcyBwYXRoIG1hdHRlcnMgYXQgYWxsIChhbmQNCj5hc3N1bWluZyBub3cgd2Ug
YWxsIGFncmVlIHRoYXQncyB0aGUgb25seSBnb2FsIG5vdy4uKSwgYmVjYXVzZSBhZmFpdSBpdCBk
aWRuJ3QNCj5yZWFsbHkgdHJpZ2dlciBpbiBjb21tb24gcGF0aHMuDQpJIHVzZWQgYmVsb3cgY2hh
bmdlcyB0byBjb2xsZWN0IHRpbWUgc3BlbnQgd2l0aCBpb21tdWZkIGJhY2tlbmQgZHVyaW5nIHN5
c3RlbSByZXNldC4NCkVuYWJsZSBtYWNybyBURVNUX1VOTUFQIHRvIHRlc3QgdW5tYXAgaW92YSB0
cmVlIGVudHJpZXMgb25lIGJ5IG9uZS4NCkRpc2FibGUgVEVTVF9VTk1BUCB0byB1c2UgdW5tYXBf
QUxMDQoNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQpAQCAtMzczNiwxNiArMzczNiw0NCBAQCBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9maW5k
X2FkZF9hcyhJbnRlbElPTU1VU3RhdGUgKnMsIFBDSUJ1cyAqYnVzLA0KICAgICByZXR1cm4gdnRk
X2Rldl9hczsNCiB9DQoNCitzdGF0aWMgZ2Jvb2xlYW4gaW92YV90cmVlX2l0ZXJhdG9yMShETUFN
YXAgKm1hcCkNCit7DQorICAgIHN0YXRpYyBpbnQgY250Ow0KKyAgICBwcmludGYoIioqKioqKioq
KipkdW1wIGlvdmEgdHJlZSAlZDogaW92YSAlbHgsIHNpemUgJWx4XG4iLCArK2NudCwgbWFwLT5p
b3ZhLCBtYXAtPnNpemUpOw0KKyAgICByZXR1cm4gZmFsc2U7DQorfQ0KKw0KKy8vI2RlZmluZSBU
RVNUX1VOTUFQDQorI2lmZGVmIFRFU1RfVU5NQVANCitzdGF0aWMgZ2Jvb2xlYW4gdnRkX3VubWFw
X3NpbmdsZShETUFNYXAgKm1hcCwgZ3BvaW50ZXIgKnByaXZhdGUpDQorew0KKyAgICBJT01NVVRM
QkV2ZW50IGV2ZW50Ow0KKw0KKyAgICBldmVudC50eXBlID0gSU9NTVVfTk9USUZJRVJfVU5NQVA7
DQorICAgIGV2ZW50LmVudHJ5LmlvdmEgPSBtYXAtPmlvdmE7DQorICAgIGV2ZW50LmVudHJ5LmFk
ZHJfbWFzayA9IG1hcC0+c2l6ZTsNCisgICAgZXZlbnQuZW50cnkudGFyZ2V0X2FzID0gJmFkZHJl
c3Nfc3BhY2VfbWVtb3J5Ow0KKyAgICBldmVudC5lbnRyeS5wZXJtID0gSU9NTVVfTk9ORTsNCisg
ICAgZXZlbnQuZW50cnkudHJhbnNsYXRlZF9hZGRyID0gMDsNCisNCisgICAgbWVtb3J5X3JlZ2lv
bl9ub3RpZnlfaW9tbXVfb25lKChJT01NVU5vdGlmaWVyICopcHJpdmF0ZSwgJmV2ZW50KTsNCisg
ICAgcmV0dXJuIGZhbHNlOw0KK30NCisjZW5kaWYNCisNCiAvKiBVbm1hcCB0aGUgd2hvbGUgcmFu
Z2UgaW4gdGhlIG5vdGlmaWVyJ3Mgc2NvcGUuICovDQogc3RhdGljIHZvaWQgdnRkX2FkZHJlc3Nf
c3BhY2VfdW5tYXAoVlREQWRkcmVzc1NwYWNlICphcywgSU9NTVVOb3RpZmllciAqbikNCiB7DQor
ICAgIGludDY0X3Qgc3RhcnRfdHYsIGRlbHRhX3R2Ow0KICAgICBod2FkZHIgc2l6ZSwgcmVtYWlu
Ow0KICAgICBod2FkZHIgc3RhcnQgPSBuLT5zdGFydDsNCiAgICAgaHdhZGRyIGVuZCA9IG4tPmVu
ZDsNCiAgICAgSW50ZWxJT01NVVN0YXRlICpzID0gYXMtPmlvbW11X3N0YXRlOw0KLSAgICBJT01N
VVRMQkV2ZW50IGV2ZW50Ow0KICAgICBETUFNYXAgbWFwOw0KDQorICAgIGlvdmFfdHJlZV9mb3Jl
YWNoKGFzLT5pb3ZhX3RyZWUsIGlvdmFfdHJlZV9pdGVyYXRvcjEpOw0KKw0KKyAgICBzdGFydF90
diA9IHFlbXVfY2xvY2tfZ2V0X3VzKFFFTVVfQ0xPQ0tfUkVBTFRJTUUpOw0KICAgICAvKg0KICAg
ICAgKiBOb3RlOiBhbGwgdGhlIGNvZGVzIGluIHRoaXMgZnVuY3Rpb24gaGFzIGEgYXNzdW1wdGlv
biB0aGF0IElPVkENCiAgICAgICogYml0cyBhcmUgbm8gbW9yZSB0aGFuIFZURF9NR0FXIGJpdHMg
KHdoaWNoIGlzIHJlc3RyaWN0ZWQgYnkNCkBAIC0zNzYzLDYgKzM3OTEsMTMgQEAgc3RhdGljIHZv
aWQgdnRkX2FkZHJlc3Nfc3BhY2VfdW5tYXAoVlREQWRkcmVzc1NwYWNlICphcywgSU9NTVVOb3Rp
ZmllciAqbikNCiAgICAgYXNzZXJ0KHN0YXJ0IDw9IGVuZCk7DQogICAgIHNpemUgPSByZW1haW4g
PSBlbmQgLSBzdGFydCArIDE7DQoNCisjaWZkZWYgVEVTVF9VTk1BUA0KKyAgICBtYXAuaW92YSA9
IG4tPnN0YXJ0Ow0KKyAgICBtYXAuc2l6ZSA9IHNpemUgLSAxOw0KKyAgICBpb3ZhX3RyZWVfZm9y
ZWFjaF9yYW5nZV9kYXRhKGFzLT5pb3ZhX3RyZWUsICZtYXAsIHZ0ZF91bm1hcF9zaW5nbGUsDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKGdwb2ludGVyICopbik7DQorI2Vsc2UN
CisgICAgSU9NTVVUTEJFdmVudCBldmVudDsNCiAgICAgZXZlbnQudHlwZSA9IElPTU1VX05PVElG
SUVSX1VOTUFQOw0KICAgICBldmVudC5lbnRyeS50YXJnZXRfYXMgPSAmYWRkcmVzc19zcGFjZV9t
ZW1vcnk7DQogICAgIGV2ZW50LmVudHJ5LnBlcm0gPSBJT01NVV9OT05FOw0KQEAgLTM3ODgsNiAr
MzgyMyw3IEBAIHN0YXRpYyB2b2lkIHZ0ZF9hZGRyZXNzX3NwYWNlX3VubWFwKFZUREFkZHJlc3NT
cGFjZSAqYXMsIElPTU1VTm90aWZpZXIgKm4pDQogICAgIH0NCg0KICAgICBhc3NlcnQoIXJlbWFp
bik7DQorI2VuZGlmDQoNCiAgICAgdHJhY2VfdnRkX2FzX3VubWFwX3dob2xlKHBjaV9idXNfbnVt
KGFzLT5idXMpLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlREX1BDSV9TTE9UKGFz
LT5kZXZmbiksDQpAQCAtMzc5Nyw2ICszODMzLDkgQEAgc3RhdGljIHZvaWQgdnRkX2FkZHJlc3Nf
c3BhY2VfdW5tYXAoVlREQWRkcmVzc1NwYWNlICphcywgSU9NTVVOb3RpZmllciAqbikNCiAgICAg
bWFwLmlvdmEgPSBuLT5zdGFydDsNCiAgICAgbWFwLnNpemUgPSBzaXplIC0gMTsgLyogSW5jbHVz
aXZlICovDQogICAgIGlvdmFfdHJlZV9yZW1vdmUoYXMtPmlvdmFfdHJlZSwgbWFwKTsNCisNCisg
ICAgZGVsdGFfdHYgPSBxZW11X2Nsb2NrX2dldF91cyhRRU1VX0NMT0NLX1JFQUxUSU1FKSAtIHN0
YXJ0X3R2Ow0KKyAgICBwcmludGYoIioqKioqKioqKioqKiBkZWx0YV90diAlbHUgdXMgKioqKioq
KioqKioqKipcbiIsIGRlbHRhX3R2KTsNCiB9DQoNCg0KUkVTVUxUOg0KWyAgIDE0LjgyNTAxNV0g
cmVib290OiBQb3dlciBkb3duDQoqKioqKioqKioqZHVtcCBpb3ZhIHRyZWUgMTogaW92YSBmZmZi
ZTAwMCwgc2l6ZSBmZmYNCi4uLg0KKioqKioqKioqKmR1bXAgaW92YSB0cmVlIDY2OiBpb3ZhIGZm
ZmZmMDAwLCBzaXplIGZmZg0KLi4uDQpXaXRoIFRFU1RfVU5NQVA6DQoqKioqKioqKioqKiogZGVs
dGFfdHYgMzkzIHVzICoqKioqKioqKioqKioqDQoqKioqKioqKioqKiogZGVsdGFfdHYgMCB1cyAq
KioqKioqKioqKioqKg0KDQpXaXRob3V0IFRFU1RfVU5NQVA6DQoqKioqKioqKioqKiogZGVsdGFf
dHYgMzY0IHVzICoqKioqKioqKioqKioqDQoqKioqKioqKioqKiogZGVsdGFfdHYgMiB1cyAqKioq
KioqKioqKioqKg0KDQpJdCBsb29rcyBubyBleHBsaWNpdCBkaWZmZXJlbmNlLCB1bm1hcF9BTEwg
aXMgYSBsaXR0bGUgYmV0dGVyLg0KSSBhbHNvIHRyaWVkIGxlZ2FjeSBjb250YWluZXIsIHJlc3Vs
dCBpcyBzaW1pbGFyIGFzIGFib3ZlOg0KDQpXaXRoIFRFU1RfVU5NQVA6DQoqKioqKioqKioqKiog
ZGVsdGFfdHYgMzI1IHVzICoqKioqKioqKioqKioqDQoqKioqKioqKioqKiogZGVsdGFfdHYgMCB1
cyAqKioqKioqKioqKioqKg0KDQpXaXRob3V0IFRFU1RfVU5NQVA6DQoqKioqKioqKioqKiogZGVs
dGFfdHYgMzE3IHVzICoqKioqKioqKioqKioqDQoqKioqKioqKioqKiogZGVsdGFfdHYgMSB1cyAq
KioqKioqKioqKioqKg0KDQpUaGFua3MNClpoZW56aG9uZw0K

