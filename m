Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BAB7AEA29
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:16:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql57W-0004R2-Cd; Tue, 26 Sep 2023 06:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql57U-0004Jj-Ev
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:16:44 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql57S-0006Qo-P8
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695723402; x=1727259402;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ui/zMK67CRxUds2V4O/BEqj4WfSfgX8c05q9cvQ2P5s=;
 b=isopHeltOwI6yH9LRAGFwVJz9oGmV1Yd5T5yqmEK7VE4Haa4QSLyUaYm
 k4snthItXypeesPW+JWUZTA4yy6vW5TLX//iczVr5ZKTkuA9UbMuhRaia
 q8rdE5ZSmwdUaaWK+GJWSRqoaY8fk6FEclTXmKEFMaWUOpDRw262ctSBt
 MD1XCRqBtiseRlYvCod3oQ13jmQ/yqB32e7EHSKQT8ncmH9W4qwMuKAsk
 Mh4tUHIOHQeLEEZ9Nr+qn7DLnIudp2yEztdrJ/imOf0LPmM9jioaeZu9l
 Aet6DSEgXujcWxNWedW3AvAU9XzM8+VC7iZwxmvY+80+/8mqC1ZQ3SaqY Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="97309519"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="97309519"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 19:16:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPkqmiGHdk727PL+zxThHV6nZGmyoQbcm1Xm7eRPYItIlfJEhK3OSCoiVtce0I8FtaxcJij/V9E3ApF3/yaD+kS+Yg+qqqkF4YkvgZbadkP0DDxj9YaM0GwLSfAlnkuPJpHqprc0z0072DulhJ2tWtOEdFhcBM+zvi8ojJaMrO+DqlM1spArZoGjlGxADnh+iyTTbbiiNBBvD8gw6DjogGveqg8qWlW34YN/D/a4gDJ+TKliepAHAsW+MVALhXlbjh+aayVQd7HlAO6HdWkKMRTZzWZ63Z0S8xXqXqFPFKOzHPp/nUmzCiSWrhDf059QutvrzvCR54DTXiP7XFmE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ui/zMK67CRxUds2V4O/BEqj4WfSfgX8c05q9cvQ2P5s=;
 b=ZTTa+IAEmQTPH1JNdvnKsHOzHicgL82hAgqMwb/cNZHNP5GbOCQSaYqk6IU5Q+EVTpfJB8x7yxKweTdJSdOkywOl2MfNyoOd/pyDESRY157oRHXGdLMlmHHZNHzyvb2N0hKUqKb8jDOHJghGoFUdMo7oemOspIVB9BiYGgcf0Ja8PQSXLZ084U/UbEOx0uG6dXTetj8mYmu5d1Mj0bTHDvy0DRq1+caV5vCH0oAYCzVzkqIE79rtR5uppMW7++/OYycUx87Z1XPob3xUSoCWlfa0QbX1UexFczng69CbHaxldBrMYQmEZTdgVbmG/b49Ze/h+ueMa4CcDFkS8wiNFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB11372.jpnprd01.prod.outlook.com (2603:1096:400:3c0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 10:16:37 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 10:16:37 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 25/52] migration/rdma: Dumb down remaining int error
 values to -1
Thread-Topic: [PATCH 25/52] migration/rdma: Dumb down remaining int error
 values to -1
Thread-Index: AQHZ6j/Fo0SJ43k+WkSBOM+hZ/zEHbAs8JAA
Date: Tue, 26 Sep 2023 10:16:37 +0000
Message-ID: <8de64fc3-2d6c-9a54-de23-66c86f8b0f73@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-26-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-26-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB11372:EE_
x-ms-office365-filtering-correlation-id: 1b3495d7-74a1-47f2-90d8-08dbbe79aafc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EZGgpTpWAQT1ZpCjEDv9/5o2B9ir3EIskIabHWHU7TB1tJfOvCfBvMu9e05gvLguZsYV5WFaAIxplAiwW0PQjTFouWSUIcotsxHhqcAbyz0loZxVsI8FDkOEyY2+MFB+6egYqzsfnm7ERKXbmtBzgFzvyvcnhiohSz85k3AwX5Gfs+hw3PI4oEQa5IRooXLdYdQVdG958Gai16K7UYflmDiDzssmmexxDfYUcwOXma6KKkIPOZAbcnZ3GBsjgaOMy+6U3AXKxJbr5DJ9gOVqc0d5gdWy3oLakgGkEGkn2nc7LtXOAmJJdiixxMQEA39YB1BnoHFOYbiWXBgXjG8+sn6TmyxLxZeDmhcabSeXTZEdZsaOQKpD1LWsUfo7k0QsBrGVDQmxqZ6zqDnxsyVePj6GnKKYEsAUYK9HEvxLs6er97663e+qzUNFQCuy6givc87ZqLeHSWRk9hBQ1UxVjU/i/nWcCSh7JhbzxDto8RZ9sE6qJw88nV5JOYPXgVOxlvb0Hgn4wpoN3k2fw6Gl6ipUhrDzjt3Ra7+vYIZ723PphPuSRF3aa0t7zvkbaLIa6ihe0xC7l0beLsTdX3wRBW1+xdMtrtes+u5+8KGkxcwrwc6wwhUTlK+WMqrMo+RuSJnIjnjFQD75rG+cIwpyxjft0iAHljtG7ekgU6cXGTKG80tQPwP3feLW7LHUoSzjN/7UaUoSyFnYA59LA38kgQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39860400002)(136003)(366004)(230922051799003)(186009)(1590799021)(451199024)(1800799009)(4326008)(1580799018)(5660300002)(66476007)(26005)(8936002)(66556008)(316002)(54906003)(41300700001)(66946007)(110136005)(91956017)(66446008)(64756008)(76116006)(8676002)(478600001)(2616005)(2906002)(53546011)(71200400001)(122000001)(6512007)(6506007)(6486002)(558084003)(85182001)(36756003)(38070700005)(38100700002)(82960400001)(31696002)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0ZHVFN2YnAzcHV5TUJGbWFudjNOdUlQdE10SVYvTGRhalNabWNaR0Y5UDFh?=
 =?utf-8?B?MVNHSHcxcjhlOURpNTgxb1FRckxQWnFQTDVtS0Y5U3p6RDlVcTRGdVBxbnoz?=
 =?utf-8?B?dHpua3dOOXlGazlMNS9vR20yU1QySUlQSndsL3hNUEJHdlZXM2wrd3FuQkxw?=
 =?utf-8?B?bEhXSVc0SXMwUFFrN2pWZElPTXlya0tNYWZQbXFBRERCaURSUC9ScVBGVWp0?=
 =?utf-8?B?anNjODhLeFpyUzEza0dzdTZrTU9UU3RjSmRIcDNQdEVFMHlOQWsrK1RiRThN?=
 =?utf-8?B?eUwySmhWYlRDaTREdFVzVytmTFRRTUpNV0hnTDJDUy9jZ2JWdmlnTDJKdVgy?=
 =?utf-8?B?bjQ3WXhEaWV2Y2VYLytVY29HdGdnYXRFVmtBTE15YXl3amcreXFFS3Q4MFp4?=
 =?utf-8?B?aitlMk9hN2N0WXd1S0QzSytQTkF4TUE0SmxrSURtVHpQU0dlRERqMUhtckJD?=
 =?utf-8?B?V0tWQjRabHRNUnphNndyQ0tNaEdRN2w0SDZnTnp2THN2WjlINi80NkZRTklS?=
 =?utf-8?B?NkFJTjZKNWRFSDdQTXdJT0NQWVhjVE9rUmlVMitpMEZIZG92aGFNWE0zQnN2?=
 =?utf-8?B?YVdoWmtPTmlIWk95K0R2TjRhU3k1bWc2KzlSNEJhUU9Ya3AyRFlTWCtrSGdq?=
 =?utf-8?B?MUJGTHQ5cmhqcklqNzBvSnkrVU0yVjVqVDZobk1VNFZVTG1PRzNXczNVYjNo?=
 =?utf-8?B?SDMrMVVnZ0prMmc4WGlxditoem9DWVVTNWlsU1FhSktLSTdMNFdNLzBkZ0tY?=
 =?utf-8?B?TVJCTCtpM1dBbVdONWpBaW4vQVlSZ1NWNFlHRkpub1NMcUhiYksza1dRckV1?=
 =?utf-8?B?TVA5SUE3UXlYVUZDNm83K1U5dG5EVTlteWxWbjdZTThZTzFXYi8vN1dzS3Vo?=
 =?utf-8?B?NU9VWFJPSisramxMUEVQd0VGSHA0NVhickxPTVVJbzJPMkJRZThXVTlMVS9S?=
 =?utf-8?B?Y2J3OWp3MzhmOGRZMzRGTUxiaTBRRm0rWndta3d0SkZwV0RGa05yL1o1VTZT?=
 =?utf-8?B?RW96UDdyekFwL29rL2N5MzRnWTFXbGFoODVpV09VZUtKaUp2dE9JV1lJTzFU?=
 =?utf-8?B?bFJGWWdQTUpqVmRZWHh1Ny9ETlFEMmw4Tk9FWFo3OUhPdVdsblJFSEpJb0x5?=
 =?utf-8?B?TXpxbmcxckQvUVZyeTBkaFMzazd4NUx6dGpNcE1oTFFRODJoekF1aHBQVW4z?=
 =?utf-8?B?TTk1RkpPSFJGekNHemR4Q050YWdGeDMzVVJGRURCNGxGM2JVL0RlNU9VMHZW?=
 =?utf-8?B?K3htRk5uNFB6SzhESmFKQ28vWlFpQVZJeUZQNmx6alJDbGZmZFlBME5idjI4?=
 =?utf-8?B?US9BTUwwQkpvd1hCb01mVTJGWGljemVCWmtMNHRrcTlzWWNsV0xQcXFHUG9Z?=
 =?utf-8?B?ZjBtb0tOWDR2eSt0dkZweU84R3JyYnA3VEpndkdTcDVjNkdWM0haU00xNW9n?=
 =?utf-8?B?dkZ6YVh4TEZHRkMxditnQVhZN3NDcWRvR3M3K2dJYkRkS1laRHVGVFpPRVBV?=
 =?utf-8?B?UkU1ckdZRVhDRzBxR0JkaTEzemE0M0ZOSGhRN1p6aUVqN3NDeFZ5YWxWYTV1?=
 =?utf-8?B?c2wrRWJQakM4QldHWFMzRi9RbDZNZnhQZ0pCNkpGelVBL2NZTW5hS3AwRXRt?=
 =?utf-8?B?SlVEMGxqSDNXQVlIZW9DN0VtMGZ3V2UyMUNTcUdqNEs2VGZwR0tTOThQZjJR?=
 =?utf-8?B?V245UDVDVVh5ZGpMTHJIRkNtN2Y3Q1NaaXg3aWhrUSszTlZaZE5FOHdjNnI4?=
 =?utf-8?B?OEpWbWdib2MvSVYwRGRRM0JNS0MwUFEyRHpWY0c4dTVzdndtTVF2dEFjTVJK?=
 =?utf-8?B?REV4UnY1Y1kwZlpibzE0TFZxOFNVNGtDaDl2WURsTzIvWUJxLy9POEJRY043?=
 =?utf-8?B?ZUxqbFN4STM1VDA1OFRqUG9Mbmw2cWhsMU5tZWFsSSs3NGR1MkZEeXVZRXZl?=
 =?utf-8?B?bUNnT3Q5dUZQYWNCNmFweE8xVUE2MFJPYldTUkE4VDRWKzZOWXJWYjJkZnNP?=
 =?utf-8?B?bk9Vam41d2RIcTNMamRiVHhmdGFleFNFZFhJU2pxa0NWM2NwaGFLenEwU1cr?=
 =?utf-8?B?VFFGd0gzQTV0bStwWGZ0NDVjUjVLY0pUSG1JRnQzTWY2ZU9wbE01czV4SllI?=
 =?utf-8?B?amNMSmt4VmtFaHRQd2h2YkxVOUlUSG5nV2NuWnU5Rnh1YyttY1hPV2RTT28y?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88986978E7AEF548AAB479D5C14A3D0F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6BWwwAj0LMWUtiZU7p4ODL4V5wQVM8/1EVc3srt7VV7obrCIZtN+lCQPHeSisQlY5mbRjpL5TAl78MpWon/EK/f4udMWFRWs7zVhNhmiwlOjhteBAnwqbhr3OwaTc5Gj2NlzFiZxOYCpoFsP1DfQCWJErbC4zU+Vnu+WoaljhxnNvVMe23sFOfOBW5HG775CX9P7t2XMr6gNivyfa4PMgPaLisUB13RWpn1PJIGsIPEMbD2mLOp3sno20s9jkKjR4iIwH62GQ22oLBu9cjh5xws956RFRUw2xSTA6zV6LwDGPLTNR9vLYxp+dsk+K0fliJssYeGkOebvwc6yGAUh5rbqi8JHcBPZg7nLC7NV+VlzhIxcBYUJhxMcdA195UhOz+QddzEVXOnQTOHZTcE610o1Ym1DY1tg+/n06BlsiP49yQj5gaVZYJu/ZlEklX6J7G+pSgVCmZ3ps7SdIbpaEntdnWWFEHGcth6K/SpHKSy8XkRA+kT9VPWPJPIlv2aGCkEAQrke+3Rf8KnAVPovQy3KByZjWqJrtslm4t8RTn0UUviIl4QVwtGN4mzofwfvu8V26HZ7q4iWKKbrm4K16ni2fFDch1YBdw/+1FtwGy5iMgNnV5iulz3k5hOIHtojv51Lp/t6n6qmh/W6bQjkt/G1gpvoR9mnmSvq3PamVz6OSDjBkh/yYqKFOgY4Xjkbt+rvJoalj2iICiP+BWEhf6NPiS8De6Ls7SBS3oAuMRv590HkQiT4wsHdDA1JhTsa0Xjha01XbDfuOj1nD2jS23R+iYJhxNHoYI8nHOImW54=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3495d7-74a1-47f2-90d8-08dbbe79aafc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 10:16:37.1994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lw67KBp7zgz7C8Zp1xy2qhkwXjpYc1kWspRD9Yxf3K8oozqkIR4ZNCtNmOAS1F/D/7pUgyaIec7d5VXqNMjEvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11372
Received-SPF: pass client-ip=216.71.156.121;
 envelope-from=lizhijian@fujitsu.com; helo=esa11.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBUaGlz
IGlzIGp1c3QgdG8gbWFrZSB0aGUgZXJyb3IgdmFsdWUgbW9yZSBvYnZpb3VzLiAgQ2FsbGVycyBk
b24ndA0KPiBtaW5kLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEFybWJydXN0ZXIgPGFy
bWJydUByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1
aml0c3UuY29tPg==

