Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1937DC82C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 09:32:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkA1-00005O-CZ; Tue, 31 Oct 2023 04:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxk9y-00004y-RQ
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 04:31:39 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxk9w-00017Y-4W
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 04:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698741096; x=1730277096;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WsMswetVMfwk7AxXSmXSXvPugjzCEzNxlhS/1l9izoM=;
 b=SRPybKMnNaUC0MrIHPxCqQWAC1YfH5DWGdMNaI0tDOHjlKWEsMgdUSuU
 7NxA13/MaKTOIDETBaYwVQ/+VIVqWWLcCcrWykQIt07cXZpDaqgEoKIG1
 EsXpha76/j1mKihaGewGn7mtHABtw1kCOH7mhfy89tqaD7/Fk8L9tpVql
 eyMdy5uGs5L6RDt0k2vejljaC8yUtjgB3XfB9r5CQL6ypzl4d7kPjcKqC
 odm+ybljDL1EsGVSAmfDmqVXRzY8TNsRiv4VAU8EcIe1j+9XdK/Mt+tVN
 ImonbYClU1qNubCnwKVl1nn9EJe5+1fu2vuq0ndKNhgVX2IRyWhqs8jko A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="452512378"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; d="scan'208";a="452512378"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2023 01:31:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1781091"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 31 Oct 2023 01:31:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 01:31:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 01:31:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 01:31:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 01:31:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hT2k0abgcPIlADVDYTkCsv7BzGsdVUWwiget7ShHvX1hK83KMkVfbwwG6pG00eFzKXJv2++lP8CXQs1DuufJuaUh9kye7l4BlHHqFOzpXeix4VYmmJR1iyLFzv2TAS9LUq8Thwbrtzbshdw2RvASNo3mxK4Us94rAb4nqlVuwpDMPQAGIPvZvhlOUa6rru8b5DoxMHSZijzcAhVbVwio/TSobbG6sz6cXj3aevsXloAs7Kk/LicobUNsHus5QOJHCNvw99+px9s+d+VeG49XbebMnzIxcsYpuPBtYhmM3WDrcpkty84AhioJwBdxUP3ZeN1HmM1+73RpJyw0ipSXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsMswetVMfwk7AxXSmXSXvPugjzCEzNxlhS/1l9izoM=;
 b=hg49pBounGyes+gQYTgwRyijH+oHOsxfmYwaug3nol7OAX+lQcT/Sjj/7Oz9k5/X9Aei4Fq/lkJ4Vn9tWCjQ6dZQ18qUffDzw7+q+NZlaHHzb361dZB1dkV6sNJOrP9lE7QHKGavTYDEuysfrveVKVGpKPwbyqrj5Syo/vZMZflNBV5ke+t9q3MgpeS9/a8TVdj0gW4A+2JXIoqbJ6UKw7ibPriYvYzD4UkfovhbftGOi7+zOMnUEW0Aq++CvVwWpnGEeut7sf6Cxk+KIE94C5nM0ASVOvBjkScJ+M/EScfqnPJuV0jye1/TSA1AgpPuCEpUlZSx/ncGUvMKupmxBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB6759.namprd11.prod.outlook.com (2603:10b6:806:25e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Tue, 31 Oct
 2023 08:31:27 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 08:31:26 +0000
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
Thread-Index: AQHaB/m3gpleJSsOKU6iHbNcrj6sm7BdrIYAgAPuq5CAAfS3AIAAA+8A
Date: Tue, 31 Oct 2023 08:31:26 +0000
Message-ID: <SJ0PR11MB6744860112770B62B1F9097C92A0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-7-zhenzhong.duan@intel.com>
 <77cb4375-beb8-4d6e-ba9f-304d357e7e67@redhat.com>
 <SJ0PR11MB6744416314994A2AAA69D2B092A1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <130d7bdd-e827-443b-ac9a-38268e720bc0@redhat.com>
In-Reply-To: <130d7bdd-e827-443b-ac9a-38268e720bc0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB6759:EE_
x-ms-office365-filtering-correlation-id: 2f5e7d4c-179a-417e-989f-08dbd9ebc635
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H064CRdv38wS9+Tw0pR5IVeGQCfxan2SErSec840B/GvuPxNmC+ziS3H6hqeqKIj6ESgch3+isFUDVgjo9zij3Zoh/dGDv/5yJfH5XIXz/a5iLvHax02c+dwWmYu+qFfbn9wkX0x6p7aZQnxUbzgHkJUASmtDK52mGNSprNql6MuQeaR/Sx2UXDyAGq1IlKSlL00o1oVVH0LdB1ez/ShhpLZzbn5GirADy1xX76+N7PHf6lI/x5DII0vF8WCbL4E/F3RIU+nMs2yVH+KoEEaWvVDVak4SKqnl0oR/7wQmn1dHhOJmKN74hrHFkECoi6wELWQlq4upfsfrZFcd+FFx9LMY49+uhzsZ/7C2YYl2gryNit6LQbkrzyKVxZcANCOlaIN+QdakoU9/fg89S3NZJoDlCWsSDDXwSPysmZ9Pn6TSDRu4LDcM3n58gCeAhMxHo3SeitiW1OdhcX1yxE+S09RhSYF/nqxkw8tQN6kyCmRNFcpiSH/e0ZPjkYFmDz/1X94ekIakylKeItzO6Nds3U6LsguUSarruKn3b7clo/kOAxP+LGV7WkgyiR+LK0ul4idc3u0JhWbNm5E3o6/vqkgMFU0hfBTpa9hM3DfyuJSWWRHZodvUWvOUMp8NT7ZVji3WHiNTuP7j/N4Qn4tZg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(122000001)(82960400001)(26005)(9686003)(38070700009)(2906002)(86362001)(83380400001)(66574015)(38100700002)(53546011)(55016003)(478600001)(6506007)(7696005)(71200400001)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(54906003)(316002)(4326008)(8676002)(8936002)(52536014)(110136005)(7416002)(66899024)(41300700001)(5660300002)(33656002)(13296009)(2004002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk5TcVNtQ28ydXNRSXZGbFFoOWJleVV2b0FzOWpuRU9ITUhIbDNEVitWUWp0?=
 =?utf-8?B?Rmw1MjE4QzRobytOZjZmaE1UeHRmOW9qOFdFVG9mRHJETzNtMU1DNWxHTzZO?=
 =?utf-8?B?dE1HS1QvQ1RiY1BGb20wT2VERjZmQUN2NUFmYzhLWTUyZ3VnNEdkMjR0TnBH?=
 =?utf-8?B?bTVXeU5aMUwxYlRiNzcyYVFaSUdBNk0vRXlxWVY4d05YV3U4NlBkNGtMZWls?=
 =?utf-8?B?SUJNWTNVU0JOcEJnRkpVeUtoMW14cmJrRCttbzJCMHllamZhL3ZrS2FpbFN0?=
 =?utf-8?B?MFFPL0wxOW9oc0VVOFVVS1F5WHloSFozTWYvMW1QYit2eWZKUnd2ejVrRURk?=
 =?utf-8?B?RitXdWpNbiszYlhXcFZaQjAwTmZ3dkF3dUJaT01xQ2s3dFh2bzdadk1nSFRP?=
 =?utf-8?B?YlZWWmxVbzZrQXMrdE14aFZROXF1d0ptdWxzVlkwNFVXUGdMLzFNTlpJZkxZ?=
 =?utf-8?B?akJZYWlacnZnMlJKaldSREJpWG5RQVVIVHNaRFJZajFRdnRTc1lqTm1RWDNs?=
 =?utf-8?B?MXNLUGZCcFR4aXF2czVLV0lBZkRuaVpCOEF1ak53VnRUUjB5bUpSeGkxZlBz?=
 =?utf-8?B?ZUg1Mm5QZVQwOFk5ak5HUW5tbVEvV1dMNlRLK2pUbEIwbVBORVRZOG83VVZv?=
 =?utf-8?B?ME1wUHNwSkZ0Und1Vi9VY010aDE4dlE3ayttUFllWXNJMmpnb05SUmVma1gz?=
 =?utf-8?B?UTQwZUczYUtyN2I0ZXhnYlQ0S1VjRG4zb0FJZUNtSjBHYWdncEhyTFZOU1hy?=
 =?utf-8?B?Znd0TFZ0KzVXYUNHKzd4NlVUNDRldUZlQzRZeXd4T0ZwRXFNQWZpM1VqajFq?=
 =?utf-8?B?aEV3aHRWdUNPem0zK3E1REFaZTZyMno4ME9iSXpScU9vbXgvNk9UckU0Vmdj?=
 =?utf-8?B?bUpVb2xQZ1M2eG5xMkh2dm9rMFpFajh1VHcybVNUOWYwcnNvZm1jMUNKTlVE?=
 =?utf-8?B?Zm5SWXVmSlV1eVFLZHNqVHBwaCtWNGZvSkNFQmZPbVBQQ1BtY0dPK2NiOU83?=
 =?utf-8?B?SUZNLzRxQUEwSGc3cWRWNHorZnZ1b0EvdXJDdWl5M3RVSkZTbzE4ejR5czhG?=
 =?utf-8?B?aXFuanBRcnZFMGpXbklRSHo1cnVjZ3lzeFF1bmphdzVXemhwUE9GQzNQZGI3?=
 =?utf-8?B?dUszQXFmaFNRNDhyMmZQaVVjakl4YXpXUzVNWk5yVHJkVy9BM1QrSEVWUXll?=
 =?utf-8?B?Nll6bmsvQ2pDbjg1UVVnbEZKWlZ6U2FYMnF0TEZlOXV3ZC9vdXZpVG5USldm?=
 =?utf-8?B?SFNkZkg3WnFXb1g5WWpnSlNBRnhSdGsyVUtBNHRvVDBWdllsQll1WFMrTjNm?=
 =?utf-8?B?RHRDOVUvTnlCYjE1bXZtTHliblphM254SHBhREhtcVNlQ3RiUUhuR1hKaHdD?=
 =?utf-8?B?b2xhdXVWOFpwYTJ2Sm84L0tjN3lQN1lYNjZOZHh5SzBNc0Q0QldIdThLREtu?=
 =?utf-8?B?VUIyYWM3UWZaRTI0bW0wS3pCaXdGbHdaSllEcWNTS3dyK05nWFdLbDk3djM4?=
 =?utf-8?B?NlNFRndhL0FrcUNmOGxVcWNybGsvNG9LcFRPaisreEFSZjl0ZjdXTkJoS3lj?=
 =?utf-8?B?TUVHOFd1blpIYW9WcFZMVWlQeWxNZ2RWZnhqVkRML3Z3eUVoTDMvaER5L1VF?=
 =?utf-8?B?L3RFWTNXQU5IY0dYYjU2dVVDbDJ2a3lVbWpIcDBvUzZMOEJKYVlxT0I0T09q?=
 =?utf-8?B?ZUd4cS9idlg0Z0pjWUQ3WGFaVURVVmJjRGgzOG1IeHFkWkl0Y1Y2MkZnQVhK?=
 =?utf-8?B?OHZ6TWFGTENMbUtWNFNySUMyeGRNRFNTRHM1eHZFWFlIbEdCemQxZ2NWQ1R5?=
 =?utf-8?B?TGR4dmFBNjRFbHRpSENFOE9uVExVWWwxYkZRd0lhUXV3Q0EwVnBwcloyM0tz?=
 =?utf-8?B?UUhMMk16MHVvTyttekdRMG9NYWdoWnl2bWlONDdEemZSVDBHK3lHdlZuY0w1?=
 =?utf-8?B?eFNRbTd6TCtRNytMMTRVdXh0N3VRSUZyVXlPSmJpMDFOL0R5YUNLZ1hPbXhR?=
 =?utf-8?B?WWdnSzBZOFVBMURvZHhRRm1URFBTSXJ6dmVVWVAwMUFxTC92T2pldkFvVHBQ?=
 =?utf-8?B?d29peGRxTXExcTZEcW85MzVJWFRMU2hjVHZsS0JSb3dKSXd1Q0o5aUkyTzZI?=
 =?utf-8?Q?Nt76bWW3FH3ZRA5vJSs02TIyd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5e7d4c-179a-417e-989f-08dbd9ebc635
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 08:31:26.8514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pdu3FuiQQ05L84PTsPI/PSWcRykVyYQYXrp0V+MCUMjS3wqeinmUHXMwYhXPuOD8hTEXB9J+e+0ROa8d18hkIJs5itf6JnztwUOV7bkGIRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6759
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBPY3RvYmVyIDMxLCAyMDIzIDM6NTgg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDA2LzM3XSB2ZmlvOiBJbnRyb2R1Y2UgYmFzZSBv
YmplY3QgZm9yIFZGSU9Db250YWluZXIgYW5kDQo+dGFyZ2V0dGVkIGludGVyZmFjZQ0KPg0KPk9u
IDEwLzMwLzIzIDAzOjQwLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4NCj4+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdA
cmVkaGF0LmNvbT4NCj4+PiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMjcsIDIwMjMgMTA6MDMgUE0N
Cj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDA2LzM3XSB2ZmlvOiBJbnRyb2R1Y2UgYmFzZSBv
YmplY3QgZm9yIFZGSU9Db250YWluZXINCj5hbmQNCj4+PiB0YXJnZXR0ZWQgaW50ZXJmYWNlDQo+
Pj4NCj4+PiBPbiAxMC8yNi8yMyAxMjozMCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+IElu
dHJvZHVjZSBhIGR1bWIgVkZJT0NvbnRhaW5lciBiYXNlIG9iamVjdCBhbmQgaXRzIHRhcmdldHRl
ZCBpbnRlcmZhY2UuDQo+Pj4NCj4+PiB0YXJnZXRlZA0KPj4NCj4+IFdpbGwgZml4Lg0KPj4NCj4+
Pg0KPj4+DQo+Pj4+IFRoaXMgaXMgd2lsbGluZ2x5IG5vdCBhIFFPTSBvYmplY3QgYmVjYXVzZSB3
ZSBkb24ndCB3YW50IGl0IHRvIGJlDQo+Pj4+IHZpc2libGUgZnJvbSB0aGUgdXNlciBpbnRlcmZh
Y2UuICBUaGUgVkZJT0NvbnRhaW5lciB3aWxsIGJlIHNtb290aGx5DQo+Pj4+IHBvcHVsYXRlZCBp
biBzdWJzZXF1ZW50IHBhdGNoZXMgYXMgd2VsbCBhcyBpbnRlcmZhY2VzLg0KPj4+Pg0KPj4+PiBO
byBmdWNudGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTog
RXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBZ
aSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5
aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBE
dWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBpbmNsdWRl
L2h3L3ZmaW8vdmZpby1jb21tb24uaCAgICAgICAgIHwgIDggKy0tLQ0KPj4+PiAgICBpbmNsdWRl
L2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oIHwgNjQNCj4rKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQ0KPj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody92ZmlvL3Zm
aW8tY29udGFpbmVyLWJhc2UuaA0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92
ZmlvL3ZmaW8tY29tbW9uLmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby0NCj5jb21tb24uaA0KPj4+
PiBpbmRleCBiOWM3YTdlNTg4Li5kOGYyOTNjYjU3IDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNsdWRl
L2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4+PiArKysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1j
b21tb24uaA0KPj4+PiBAQCAtMzAsNiArMzAsNyBAQA0KPj4+PiAgICAjaW5jbHVkZSA8bGludXgv
dmZpby5oPg0KPj4+PiAgICAjZW5kaWYNCj4+Pj4gICAgI2luY2x1ZGUgInN5c2VtdS9zeXNlbXUu
aCINCj4+Pj4gKyNpbmNsdWRlICJody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaCINCj4+Pj4N
Cj4+Pj4gICAgI2RlZmluZSBWRklPX01TR19QUkVGSVggInZmaW8gJXM6ICINCj4+Pj4NCj4+Pj4g
QEAgLTgxLDYgKzgyLDcgQEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0FkZHJlc3NTcGFjZSB7DQo+Pj4+
ICAgIHN0cnVjdCBWRklPR3JvdXA7DQo+Pj4+DQo+Pj4+ICAgIHR5cGVkZWYgc3RydWN0IFZGSU9D
b250YWluZXIgew0KPj4+PiArICAgIFZGSU9Db250YWluZXJCYXNlIGJjb250YWluZXI7DQo+Pj4+
ICAgICAgICBWRklPQWRkcmVzc1NwYWNlICpzcGFjZTsNCj4+Pj4gICAgICAgIGludCBmZDsgLyog
L2Rldi92ZmlvL3ZmaW8sIGVtcG93ZXJlZCBieSB0aGUgYXR0YWNoZWQgZ3JvdXBzICovDQo+Pj4+
ICAgICAgICBNZW1vcnlMaXN0ZW5lciBsaXN0ZW5lcjsNCj4+Pj4gQEAgLTIwMSwxMiArMjAzLDYg
QEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0Rpc3BsYXkgew0KPj4+PiAgICAgICAgfSBkbWFidWY7DQo+
Pj4+ICAgIH0gVkZJT0Rpc3BsYXk7DQo+Pj4+DQo+Pj4+IC10eXBlZGVmIHN0cnVjdCB7DQo+Pj4+
IC0gICAgdW5zaWduZWQgbG9uZyAqYml0bWFwOw0KPj4+PiAtICAgIGh3YWRkciBzaXplOw0KPj4+
PiAtICAgIGh3YWRkciBwYWdlczsNCj4+Pj4gLX0gVkZJT0JpdG1hcDsNCj4+Pj4gLQ0KPj4+PiAg
ICBWRklPQWRkcmVzc1NwYWNlICp2ZmlvX2dldF9hZGRyZXNzX3NwYWNlKEFkZHJlc3NTcGFjZSAq
YXMpOw0KPj4+PiAgICB2b2lkIHZmaW9fcHV0X2FkZHJlc3Nfc3BhY2UoVkZJT0FkZHJlc3NTcGFj
ZSAqc3BhY2UpOw0KPj4+PiAgICBib29sIHZmaW9fZGV2aWNlc19hbGxfcnVubmluZ19hbmRfc2F2
aW5nKFZGSU9Db250YWluZXIgKmNvbnRhaW5lcik7DQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tDQo+
Pj4gY29udGFpbmVyLWJhc2UuaA0KPj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+PiBpbmRl
eCAwMDAwMDAwMDAwLi41YmVjYmQ1MWE3DQo+Pj4+IC0tLSAvZGV2L251bGwNCj4+Pj4gKysrIGIv
aW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPj4+PiBAQCAtMCwwICsxLDY0
IEBADQo+Pj4+ICsvKg0KPj4+PiArICogVkZJTyBCQVNFIENPTlRBSU5FUg0KPj4+PiArICoNCj4+
Pj4gKyAqIENvcHlyaWdodCAoQykgMjAyMyBJbnRlbCBDb3Jwb3JhdGlvbi4NCj4+Pj4gKyAqIENv
cHlyaWdodCBSZWQgSGF0LCBJbmMuIDIwMjMNCj4+Pj4gKyAqDQo+Pj4+ICsgKiBBdXRob3JzOiBZ
aSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+Pj4gKyAqICAgICAgICAgIEVyaWMgQXVnZXIg
PGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+Pj4gKyAqDQo+Pj4+ICsgKiBUaGlzIHByb2dyYW0g
aXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0K
Pj4+PiArICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSBhcyBwdWJsaXNoZWQgYnkNCj4+Pj4gKyAqIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yDQo+Pj4+ICsgKiAoYXQgeW91
ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLg0KPj4+PiArDQo+Pj4+ICsgKiBUaGlzIHByb2dy
YW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwNCj4+
Pj4gKyAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVk
IHdhcnJhbnR5IG9mDQo+Pj4+ICsgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQ
QVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlDQo+Pj4+ICsgKiBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLg0KPj4+PiArDQo+Pj4+ICsgKiBZb3Ugc2hvdWxkIGhh
dmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9u
Zw0KPj4+PiArICogd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgc2VlIDxodHRwOi8vd3d3Lmdu
dS5vcmcvbGljZW5zZXMvPi4NCj4+Pg0KPj4+IFRoaXMgc2hvdWxkIGJlIGVub3VnaCA6DQo+Pj4N
Cj4+PiAgICBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPj4NCj4+
IFdpbGwgZG8uDQo+Pg0KPj4+DQo+Pj4+ICsgKi8NCj4+Pj4gKw0KPj4+PiArI2lmbmRlZiBIV19W
RklPX1ZGSU9fQkFTRV9DT05UQUlORVJfSA0KPj4+PiArI2RlZmluZSBIV19WRklPX1ZGSU9fQkFT
RV9DT05UQUlORVJfSA0KPj4+DQo+Pj4gSFdfVkZJT19WRklPX0NPTlRBSU5FUl9CQVNFX0gNCj4+
Pg0KPj4+PiArDQo+Pj4+ICsjaW5jbHVkZSAiZXhlYy9tZW1vcnkuaCINCj4+Pj4gKyNpZm5kZWYg
Q09ORklHX1VTRVJfT05MWQ0KPj4+PiArI2luY2x1ZGUgImV4ZWMvaHdhZGRyLmgiDQo+Pj4+ICsj
ZW5kaWYNCj4+Pg0KPj4+IGluY2x1ZGluZyAiZXhlYy9tZW1vcnkuaCIgc2hvdWxkIGJlIGVub3Vn
aC4NCj4+DQo+PiBXaWxsIGRvLg0KPj4NCj4+Pg0KPj4+DQo+Pj4+ICsNCj4+Pj4gK3R5cGVkZWYg
c3RydWN0IFZGSU9EZXZpY2UgVkZJT0RldmljZTsNCj4+Pj4gK3R5cGVkZWYgc3RydWN0IFZGSU9J
T01NVU9wcyBWRklPSU9NTVVPcHM7DQo+Pj4+ICsNCj4+Pj4gK3R5cGVkZWYgc3RydWN0IHsNCj4+
Pj4gKyAgICB1bnNpZ25lZCBsb25nICpiaXRtYXA7DQo+Pj4+ICsgICAgaHdhZGRyIHNpemU7DQo+
Pj4+ICsgICAgaHdhZGRyIHBhZ2VzOw0KPj4+PiArfSBWRklPQml0bWFwOw0KPj4+PiArDQo+Pj4+
ICsvKg0KPj4+PiArICogVGhpcyBpcyB0aGUgYmFzZSBvYmplY3QgZm9yIHZmaW8gY29udGFpbmVy
IGJhY2tlbmRzDQo+Pj4+ICsgKi8NCj4+Pj4gK3R5cGVkZWYgc3RydWN0IFZGSU9Db250YWluZXJC
YXNlIHsNCj4+Pj4gKyAgICBjb25zdCBWRklPSU9NTVVPcHMgKm9wczsNCj4+Pj4gK30gVkZJT0Nv
bnRhaW5lckJhc2U7DQo+Pj4+ICsNCj4+Pj4gK3N0cnVjdCBWRklPSU9NTVVPcHMgew0KPj4+PiAr
ICAgIC8qIGJhc2ljIGZlYXR1cmUgKi8NCj4+Pj4gKyAgICBpbnQgKCpkbWFfbWFwKShWRklPQ29u
dGFpbmVyQmFzZSAqYmNvbnRhaW5lciwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICBod2FkZHIg
aW92YSwgcmFtX2FkZHJfdCBzaXplLA0KPj4+PiArICAgICAgICAgICAgICAgICAgIHZvaWQgKnZh
ZGRyLCBib29sIHJlYWRvbmx5KTsNCj4+Pj4gKyAgICBpbnQgKCpkbWFfdW5tYXApKFZGSU9Db250
YWluZXJCYXNlICpiY29udGFpbmVyLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgaHdhZGRy
IGlvdmEsIHJhbV9hZGRyX3Qgc2l6ZSwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIElPTU1V
VExCRW50cnkgKmlvdGxiKTsNCj4+Pg0KPj4+IENvdWxkIHRoZSBWRklPQ29udGFpbmVyQmFzZSAq
cGFyYW1ldGVyIGJlIGNvbnN0ID8NCj4+DQo+PiBZZXMsIFZGSU9Db250YWluZXJCYXNlIGlzIG5v
dCBjaGFuZ2VkIGJ5IGRtYV91bm1hcCBhbmQgb3RoZXINCj4+IGZ1bmN0aW9ucyBkbWFfdW5tYXAg
Y2FsbHMuIEkgdHJpZWQgYW5kIGZvdW5kIG1ha2luZyBpdCBjb25zdCBoZXJlDQo+PiB3b3VsZCBp
bXBhY3QgYWxsIGZ1bmN0aW9ucyBpdCBjYWxsZWQgd2l0aCBzYW1lIHBhcmFtZXRlciBiZSBjb25z
dA0KPj4gaW4gZm9sbG93aW5nIHBhdGNoZXMgd2hpY2ggbG9va3MgdW5yZWxhdGVkIHRvIHRoZSBw
YXRjaCBpdHNlbGYNCj4+IHRvIGF2b2lkIGNvbXBpbGUgZXJyb3IuDQo+Pg0KPj4gRS5nLiBiZWxv
dyBmdW5jdGlvbnMgYXJlIGltcGFjdGVkLA0KPj4gdmZpb19kZXZpY2VzX2FsbF9ydW5uaW5nX2Fu
ZF9taWdfYWN0aXZlDQo+PiB2ZmlvX2RldmljZXNfYWxsX2RldmljZV9kaXJ0eV90cmFja2luZw0K
Pj4gdmZpb19kZXZpY2VzX3F1ZXJ5X2RpcnR5X2JpdG1hcA0KPj4gdmZpb19jb250YWluZXJfcXVl
cnlfZGlydHlfYml0bWFwDQo+PiB2ZmlvX2xlZ2FjeV9xdWVyeV9kaXJ0eV9iaXRtYXA+DQo+PiBU
byBtYWtlIGZvbGxvd2luZyBwYXRjaGVzIGNsZWFuZXIgdG8gcmV2aWV3LCBJIHdvdWxkIGxpa2Ug
dG8ga2VlcA0KPj4gY3VycmVudCBjb2RlIGV4Y2VwdCB5b3Ugb3Igb3RoZXJzIGhhdmUgYSBzdHJv
bmcgb3Bpbmlvbi4NCj4+IEFub3RoZXIgY2hvaWNlIEkgY2FuIHRoaW5rIG9mIGlzIHRvIGFkZCBj
b25zdCB0byBhbGwgaW1wYWN0IGZ1bmN0aW9ucw0KPj4gaW4gYSBzZXBhcmF0ZSBwYXRjaC4NCj4N
Cj5JdCB3b3VsZCBiZSBnb29kIHRvIGhhdmUsIGZvciBsYXRlci4NCg0KT0ssIEknbGwgYWRkIGEg
cGF0Y2ggZm9yIGNvbnN0IGNoYW5nZSBpbiB0aGlzIHNlcmllcy4NCg0KPg0KPk9uIGEgcmVsYXRl
ZCB0b3BpYywgSSBmaW5kIHRoZSBjb2RlIGRpZmZpY3VsdCB0byByZWFkIGJlY2F1c2UgaXQgaXMN
Cj5jb21wbGV4LCBvZiBjb3Vyc2UsIGFuZCBkZWFsaW5nIHdpdGggYSB0aGljayBsYXllciBvZiBz
b2Z0d2FyZSBjb25zdHJ1Y3RzDQo+YnV0IGFsc28gYmVjYXVzZSBpdCBsYWNrcyBhIGNvbnNpc3Rl
bnQgbmFtaW5nIHNjaGVtZSBpbiB0aGUgZGlmZmVyZW50DQo+c3VibW9kdWxlcy4gRm9yIGluc3Rh
bmNlLCBpb21tdWZkLmMgaGFzIHZhcmlvdXMgcm91dGluZSBwcmVmaXhlcyBmb3INCj5sb2NhbCBy
b3V0aW5lcy4gVGhpcyBpcyBxdWl0ZSBjb25mdXNpbmcuIFNhbWUgZm9yIDoNCj4NCj4gICBody92
ZmlvL2NvbW1vbi5jDQo+ICAgaHcvdmZpby9oZWxwZXJzLmMNCj4gICBody92ZmlvL2NvbnRhaW5l
ci5jDQo+ICAgaHcvdmZpby9jb250YWluZXItYmFzZS5jDQoNCkkgc2VlLCBsZXQgbWUgY2hhbmdl
IGFsbCByb3V0aW5lcyBpbiBpb21tdWZkLmMgdG8gdXNlIGlvbW11ZmRfKiBwcmVmaXguDQpGb3Ig
Y29udGFpbmVyLWJhc2UuYywgdmZpb19jb250YWluZXJfKiBpcyB0aGUgcHJlZml4Lg0KRm9yIG90
aGVyIGZpbGVzLCBJIGNhbiBtYWtlIGEgcHJlZml4IGNsZWFudXAgc2VyaWVzIGluIGZ1dHVyZSBh
cyB0aGlzIHNlcmllcw0KZm9jdXMgb24gaW9tbXVmZC4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K
Pg0KPlRoaXMgaXMgbm90IG5lY2Vzc2FyaWx5IGludHJvZHVjZWQgYnkgdGhlIGNoYW5nZXMgb2Yg
dGhpcyBzZXJpZXMuDQo+U29tZXRoaW5nIHRvIGltcHJvdmUgZm9yIHN1cmUgdGhvdWdoLg0KPg0K
PlRoYW5rcywNCj4NCj5DLg0KPg0KPg0KPj4NCj4+Pg0KPj4+PiArICAgIGludCAoKmF0dGFjaF9k
ZXZpY2UpKGNoYXIgKm5hbWUsIFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4+DQo+Pj4gY29udCBj
aGFyICpuYW1lICA/DQo+Pg0KPj4gWWVzLCB3aWxsIGZpeC4NCj4+DQo+PiBUaGFua3MNCj4+IFpo
ZW56aG9uZw0KPj4NCj4+Pg0KPj4+IFRoZSByZXN0IGxvb2tzIGdvb2QgdG8gbWUuDQo+Pj4NCj4+
PiBUaGFua3MNCj4+Pg0KPj4+IEMuDQo+Pj4NCj4+Pg0KPj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgIEFkZHJlc3NTcGFjZSAqYXMsIEVycm9yICoqZXJycCk7DQo+Pj4+ICsgICAgdm9pZCAo
KmRldGFjaF9kZXZpY2UpKFZGSU9EZXZpY2UgKnZiYXNlZGV2KTsNCj4+Pj4gKyAgICAvKiBtaWdy
YXRpb24gZmVhdHVyZSAqLw0KPj4+PiArICAgIGludCAoKnNldF9kaXJ0eV9wYWdlX3RyYWNraW5n
KShWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwgYm9vbA0KPnN0YXJ0KTsNCj4+Pj4gKyAg
ICBpbnQgKCpxdWVyeV9kaXJ0eV9iaXRtYXApKFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVy
LCBWRklPQml0bWFwDQo+Pj4gKnZibWFwLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaHdhZGRyIGlvdmEsIGh3YWRkciBzaXplKTsNCj4+Pj4gK307DQo+Pj4+ICsjZW5kaWYg
LyogSFdfVkZJT19WRklPX0JBU0VfQ09OVEFJTkVSX0ggKi8NCj4+DQoNCg==

