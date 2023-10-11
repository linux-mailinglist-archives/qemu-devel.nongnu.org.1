Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C667C4E18
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:05:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqV7r-0000xS-7G; Wed, 11 Oct 2023 05:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qqV7i-0000wC-Nr
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:03:24 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qqV7e-0000Tz-4m
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697014998; x=1728550998;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Q5rhdu+rM27Ph5UsZJczC7z33fKyQxC5RyAFZfwff28=;
 b=iPMxZo/uId80SeRZNi+4j/PzoUhbOFYrI+YfcLrcsD/TbI7jzu1CifsB
 j1EGLqqTC9mFr9WEStHq9cfz/COn8czb+tFfoxNOIRBii/vTaLhbAovRk
 9ixj+m2Frf5djubP+nKwIRu012su+T9kCaOYt6PdoE28Rgt/TmP2n3GnU
 KO5XUagXPW3whyKpUEC5Ly0NVAd5CQbzPAwTJ2P7bkUgc9NYx+OlrvgUk
 03P/3rPOsOyMUOJdAGpSfcHRstjEdcg6PyzHmES/bTdyVv5nso2C+owYq
 20hu/vWmJInHFsD178am2JHceMGqIcVffmQp7eUf3n1qBt/IbuqWykD78 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388485020"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; d="scan'208";a="388485020"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2023 02:03:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001031205"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; d="scan'208";a="1001031205"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Oct 2023 02:03:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 02:03:11 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 02:03:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 02:03:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 02:03:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZDsx1MtNxAAmFYtfLSvm/Xj8JYlR0lFsLHzSizdXlR8q/c+5+RHSARQsP8zYy8kA2P8E2TPeJVUXa7zZUHcPeY/C3c/bqwXEDGkH0WT53Ct9wj5+M2ebq3HtQDAI43xmLZt9MJOqiK+yeBHuqKZWX/gehEDHL+CoPm9L5ey+d9Vwl26CZfiwnCddhn9pF1Tr2AhBXN6lNxad8p5uDIyVgHxF+g9tEqr37trKCgxbUN6RTxg6AeM6y1/M9z6yiBFadSzFxhO4H7X8su2JdxwGABSHlxkzNRZ1dgVY+bbYJZR0JOLXAVMIrImPtCyJ85QUxz39avBo4ML0r6l0/62Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5rhdu+rM27Ph5UsZJczC7z33fKyQxC5RyAFZfwff28=;
 b=E+HTTMeAQWN/TECkE7NHsL9DPFiiupjp51tUX4VWWDqOz1NA09dZ5ScPkBz3HvD8mRi2cj1suPZwi+vEss3iiS6eiLTEB2bdHrC3uTAK0DgZS3rSQJttNKen1xHThzsh0vpd6X6YhJz06R0VaHADH3v8TRqtrk1vxuejxYjKQTIWVZQb7PxzgXcSPDwtNK0rY+knON8dnyqXJJKa4wMRWtjZrKL9W4xYTdb/cw+mGZZJnroRiYrVMpr1W76zQTMlLr0XP7HQ7eYfziQYxQPWxqTWkMKlCjh55IiPHaneLeaX/W8YmTGtrgJ+Te5KArzOsB5kAXMRq3pv5fiVX4BCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 SA2PR11MB5003.namprd11.prod.outlook.com (2603:10b6:806:11e::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Wed, 11 Oct 2023 09:03:09 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::6a55:3e93:ac5f:7b6d]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::6a55:3e93:ac5f:7b6d%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 09:03:08 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "quintela@redhat.com" <quintela@redhat.com>, "isaku.yamahata@gmail.com"
 <isaku.yamahata@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2] migration: refactor migration_completion
Thread-Topic: [PATCH v2] migration: refactor migration_completion
Thread-Index: AQHZxrZrzbuQ2/SdmUaa0xzmirIuk6/aJDIAgGqAMLA=
Date: Wed, 11 Oct 2023 09:03:08 +0000
Message-ID: <DS0PR11MB63737BF4616A4903AED2BC4ADCCCA@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230804093053.5037-1-wei.w.wang@intel.com> <ZMz/GEdnh1opN/o3@x1n>
In-Reply-To: <ZMz/GEdnh1opN/o3@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|SA2PR11MB5003:EE_
x-ms-office365-filtering-correlation-id: 39fda0ef-7d33-4754-cd4b-08dbca38e396
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WAjYl8EzevaQbuVogFy4NUBqanGEMg+KcLA4r3aDgyOC56xtn3XthAAMl2K1If6ZSSm0VxCVLGykkIDjeyCDmvBLkGxC6t9eaZFxzu1c4Vdr6/Y/TEXcInqbVimdeEA0ST6xDNrTyi03OtzYkmrDw86rt1NIobVMzYS8SBloTjdI+ExKDOzP+xtm4H49dJsSevJHd8HXghFhOqijeSra5IYo+4JE1BEAJnDSPVX1N2SbvXZVT63NUTRfuisgBi1ar+yZABx1CI50G2CX+xoEVllK+OYxRUisPixbvjZH9aHMFkdlUFhr2S7FEJhlJPR3ZadjZuXz2KGdcKSafTbRX8omXSoAHFOTKvPqXDfWXdvUIbdVEOnqFOwvDVCMAtnc8+yzhEuz/5drwV8XineGuvTt4VoYmFqf4vpmcjEQL7N5dvERmGNipfuY+hUWUjXWsb9BE5pduE0h3+OU5IdUGg2bJYsoVBbQy2hScbAjPaEnm+zp38dSubfKbnPbPtDzE22XBKuZ09v2sWLpGWabnjAuHW8j3TzFmqOrHZ6NabfR2KsewiDps1TjIB9k9dHOdJleLTmZSvmFkEQJRp7CbBoPbLdej0bvfonG6rIRNKo+h61RJ1KUnBDE0Gldm9G7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(122000001)(83380400001)(316002)(38070700005)(4744005)(2906002)(53546011)(86362001)(6506007)(82960400001)(9686003)(7696005)(71200400001)(38100700002)(5660300002)(33656002)(52536014)(8936002)(8676002)(4326008)(55016003)(478600001)(6916009)(41300700001)(54906003)(64756008)(66946007)(76116006)(66446008)(66476007)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFNQdE1NWWJ0Wi8xZlJkaTkrZkp6QzI2NWR3Z2dzY3ZKNHNLN2xaL2JtR1JJ?=
 =?utf-8?B?S2tDSVRhL0UxRUIrbjBTUWFnUmlxcnY2N0tVdG95eGlYMDg1ekI2VFhMQWJW?=
 =?utf-8?B?end4bkw3S1U3MXVDd0ZQallwTHM5MSs5NGZ5dWk3L1AzQ3dqTiszejFUWitT?=
 =?utf-8?B?Q3E3eEwrU2ZCMG5MOW44eHN5bTBMTExKa1hobjRmMHJ2U0xBNno1b21CZW9z?=
 =?utf-8?B?SnVkZkxTS0VtYkdEWkszd2JnRzU0RGdOYkttL2NBSTlOTVMyR09zdDRPcXhv?=
 =?utf-8?B?ZEYrZ2ZhUnZQYzUxZ2h5bCtBNTYrbHpmMzQzNXQ3WXNBR1hwMUkvZDZNbjBO?=
 =?utf-8?B?eU9UeUJuQTVvMDZNREJXUm1NT0dXVmg5QlJtaDhma0JKMXg2Nk5LYTJZcVFh?=
 =?utf-8?B?Q2EvWVhFUHhKZ0FVb0N3dlVzblAwYUdNVFBZd043YVJDdE1qVU50Mytsc24r?=
 =?utf-8?B?OE9MMUx6cWp6emZrL0p2UW5VbWFUV0E5YmVhK1R1cmJRMXZGY1NERDQvVmJY?=
 =?utf-8?B?ekhpd0lLRmdQZVFIZkFNcndGKy8yNG1aNlZNLzNUS0Rma0luWUZvWWZWMFZi?=
 =?utf-8?B?NHluU1h0OW5ybEdxbHVra0lMZ1FSeG4rc0RpYUd0NVhwTExLN09td1c5NE4z?=
 =?utf-8?B?TDEvMndDL25yNzlxWkV6VG1VazIyMkkvS3FrbndNbTd1Y1B2cTlSaFI4UmhI?=
 =?utf-8?B?NzlPSUh1WVUreTRCZFAvcUZSMFFGVFBTR01oVmpZWEVVRXFIeVA2UjBCRnRa?=
 =?utf-8?B?N3JTTFhycUJhTjc2R2YxVzlhZDVPSDRHVW9qWWJxOFhObkU5R0dCL3RDKzlE?=
 =?utf-8?B?NmRjdjhSeVJZOG4va2d5VGZPekxYT3ZCUTB0dUVQNEdiYXFZZTJVVTlCbDkz?=
 =?utf-8?B?Y3ZyZHlZVVNVZnNYbHY0Q3REaWFIYUpBY01Xb1dZWkRvZVB6Rkg5bTR3L2RZ?=
 =?utf-8?B?L2ZQVDdYcFBVUk5hV3RYaTQzQUw2bzRFRXA2OWxJMTg4eWlvVGMycEhyV0lv?=
 =?utf-8?B?eG5LcEhHRDhEQWIxTTROc2JDd3ZnZTNXeTRZOUdHWm1RUFFzT1daY1loS2kr?=
 =?utf-8?B?bGR6RVdNTnJSanlnczBRenltQTZoaGhLc2NIZVpVejVWRThvWURsT1oySjg3?=
 =?utf-8?B?N2FObklKTG9xZzlBVEc0Umh4c2xhaW0wMjZzMExjcFJuWHNUaWtRWE1aNVFi?=
 =?utf-8?B?eGgvR1AyTjFscFVQeVZ5NVZrYlRENlUra1p1b2JaZG1TdFRuSmRFcWg1ZnhK?=
 =?utf-8?B?YWpXSHB2Y2Zta01lcndEeFlXeHdVTTVjaHJneUVNVTloTWh5TldwZFkxajVH?=
 =?utf-8?B?d0djbll1Qkc0ZXYxSmo4cFNDM0hJT3I2c1hqckJoUG5SOEtlNlR1S3NiSTQy?=
 =?utf-8?B?akt2TktJak5LTHR6UzNXLzNiKzJWSGYyTkxCNTFJSExINGsvUlM4ZThBMTJr?=
 =?utf-8?B?N0E5bkdBekRVWktYRC9vZXd4dWU2R2djLzNQNDZUc0dnekpjeTBENHppQUxt?=
 =?utf-8?B?cUxQbURPMkZ5WDlzWUFYZTU4RVRJRUVsbWR0NENyOUFYa1MvcDZwMzFlL2JM?=
 =?utf-8?B?a2hEMEdyRERqY1I5TXdHbGtUMU9Qek9RbEN0Rlc1ZlJpZ0NZTklVQk12VVFK?=
 =?utf-8?B?QjYxZ2Fza3BZL3lwZkJBT0hSNzUzL29pbW1Ed0NETUVjKzg0SjdHOUZDU2k3?=
 =?utf-8?B?aXhiSks3eXRiVHBkZjd1MTFmem8zTFNCdWZhUTh0ZmwzdHprVU8xdlVtTWtu?=
 =?utf-8?B?SGdOcTFmM1BzMllCWHAzMUovdTJLTXBSY0lqOGNZczNHaE1WbTR1b3YzbkQ1?=
 =?utf-8?B?OW5wWVZ2T0oyeC9sZlkzU0FnZ3Ezejhkb0llVzhvMytvbHJsWHZ2UjM1L0RL?=
 =?utf-8?B?Z0ZtbXU3d1owSkp6T2NrUUtwVjBzWWg5cEhTeGUxZThkN05POVpYQ3doUEF0?=
 =?utf-8?B?QlhZWmY0NkI0NERVVzlLT29HMS9CWndOeWlhc2dLV3ZOVWZQK1BzUnI2K0RB?=
 =?utf-8?B?dVlvNzAvSE55SER0Szhkb002K01vamtXd1VtS3Vod1RjSUlOc2ZDaHRhK08r?=
 =?utf-8?B?QUY2Y2twazNiYzBYRG1DQUw5cWozaFBGbjF4SUlSaUxNYWluaE1pQnJnT1Rp?=
 =?utf-8?Q?tBhV9InScCc7IRn8Kxa9k+BXb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fda0ef-7d33-4754-cd4b-08dbca38e396
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 09:03:08.7926 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LuY+RSI6OqSBZ5c3pf8ejRotJ8drmE/QVlF/apUAAVAg+s4Zu4YIdNDcWawHs14NN9DcJHE3LBdb/KtJk4adQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5003
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

T24gRnJpZGF5LCBBdWd1c3QgNCwgMjAyMyA5OjM3IFBNLCBQZXRlciBYdSB3cm90ZToNCkZyaSwg
QXVnIDA0LCAyMDIzIGF0IDA1OjMwOjUzUE0gKzA4MDAsIFdlaSBXYW5nIHdyb3RlOg0KPiA+IEN1
cnJlbnQgbWlncmF0aW9uX2NvbXBsZXRpb24gZnVuY3Rpb24gaXMgYSBiaXQgbG9uZy4gUmVmYWN0
b3IgdGhlIGxvbmcNCj4gPiBpbXBsZW1lbnRhdGlvbiBpbnRvIGRpZmZlcmVudCBzdWJmdW5jdGlv
bnM6DQo+ID4gLSBtaWdyYXRpb25fY29tcGxldGlvbl9wcmVjb3B5OiBjb21wbGV0aW9uIGNvZGUg
cmVsYXRlZCB0byBwcmVjb3B5DQo+ID4gLSBtaWdyYXRpb25fY29tcGxldGlvbl9wb3N0Y29weTog
Y29tcGxldGlvbiBjb2RlIHJlbGF0ZWQgdG8gcG9zdGNvcHkNCj4gPiAtIGNsb3NlX3JldHVybl9w
YXRoX29uX3NvdXJjZTogcnAgdGhyZWFkIHJlbGF0ZWQgY2xlYW51cCBvbiBtaWdyYXRpb24NCj4g
PiBjb21wbGV0aW9uLiBJdCBpcyBuYW1lZCB0byBtYXRjaCB3aXRoIG9wZW5fcmV0dXJuX3BhdGhf
b25fc291cmNlLg0KPiA+DQo+ID4gVGhpcyBpbXByb3ZlcyByZWFkYWJpbGl0eSBhbmQgaXMgZWFz
aWVyIGZvciBmdXR1cmUgdXBkYXRlcyAoZS5nLiBhZGQNCj4gPiBuZXcgc3ViZnVuY3Rpb25zIHdo
ZW4gY29tcGxldGlvbiBjb2RlIHJlbGF0ZWQgdG8gbmV3IGZlYXR1cmVzIGFyZQ0KPiA+IG5lZWRl
ZCkuIE5vIGZ1bmN0aW9uYWwgY2hhbmdlcyBpbnRlbmRlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFdlaSBXYW5nIDx3ZWkudy53YW5nQGludGVsLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBQ
ZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IA0KDQpIaSBKdWFuLA0KRG8geW91IHRoaW5r
IHRoaXMgcmVmYWN0b3Jpbmcgd291bGQgYmUgZ29vZCB0byBtZXJnZSBvciBoYXZlIGFueSBtb3Jl
IGNvbW1lbnRzPw0KDQpUaGFua3MsDQpXZWkNCg==

