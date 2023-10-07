Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 615A17BC483
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 05:57:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoyQc-0002Ux-Sw; Fri, 06 Oct 2023 23:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qoyQT-0002Ui-Sz
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 23:56:27 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qoyQR-0005sn-5i
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 23:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1696650984; x=1728186984;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=8b5FeHwJfGcTteN14erOet/GPUllUDLQeOyG1jdBd1U=;
 b=jZXIfAhptW5ZqYbgG862qzRA3UV38R/hoSMnmqf+uavvp41R7CF5yZsA
 K7Ewm5NpEWbYUYFGjCfJvHm+wioDGhSCTqntwAsj8OT/I1YQvIMGLk9+V
 l7XJ2qy4RRacUCCkDTUUs3XlvKBBpovy/6y//5x9YhzoyJrk7y8HTo8fh
 wLn4rnL4nNI2nVUf87zL85kIZT1vkdYbVhFP9RyxQZMV9t+bW2YRNuC4q
 IitQP3cQXGl1J0puRgOGFSvSa8t/IQw0KCv8zfQuDLeLv/08QpfckWDnH
 lM7DrjZnSZcASzykmoUTwwJGotfn8oDIyxMO6ccFVZZtsoszV72pX8qGr Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="97909246"
X-IronPort-AV: E=Sophos;i="6.03,204,1694703600"; d="scan'208";a="97909246"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2023 12:56:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLlQDqL6usu01W8ATlG2vPejN3CaOgUBkLQk+B2mRT7pB5HiA7gtOAw81zdXpOhDMy/RF/M3KQanTdRr9IqEqGhWClcRIgvDGcJhD8BbwGWhD8xAiMSZVyCeoRbmmfXuCkMT+/oxUwF1a3IxDKM6LL8KH2qVuMOPEVGXR3q3vhn9cZ90Vz2HqlB0eh34vTBW+7nSeGI7DsbS5pgwYFpGlpx/NvRd2k01B+tIjgB2BfIoUc3GNDRmJH/h4lT5PHoICb3U4ibw3ODEQLylKNXxIQM8HZYB+FPOF95ple5TCSinOdUCgGlX6DLzTGUL2z5GVKpnOx1iFWYtzySKXBdNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8b5FeHwJfGcTteN14erOet/GPUllUDLQeOyG1jdBd1U=;
 b=nqsbQHlBYbTY3cwLxNcpX3WyzE99ketIHCvoRejDRee1pmM3wroj4Fysv9s9T2bkBCVtdguPHJ9Bf34jd96TO5hyNeFv/G2ldoJnhqnU6PoLhDC4eEYxbvjkZI7hosVT/m6L9vXb9LCHTs1S2+wBtKgrZHGHKgFc7ipUNsAqq25xrHMWde0BKI1Fl9pKO5j3dQs8DxKFNslL7G9zreKzX97GDb+5Ddm27tm1TBIC5okI8v2I+Lh6NjV4LhJT3C1jXKfNUR4R7ESrojDrk8L7MEtMQvebBWZCncTwbq8nW5B7FL6zcUqT/Aw8czynzcjRJ9jlXMV4Cp1zHVmblAHUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS3PR01MB9850.jpnprd01.prod.outlook.com (2603:1096:604:1ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 03:56:14 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 03:56:14 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "eblake@redhat.com" <eblake@redhat.com>
Subject: Re: [PATCH v2 52/53] migration/rdma: Use error_report() & friends
 instead of stderr
Thread-Topic: [PATCH v2 52/53] migration/rdma: Use error_report() & friends
 instead of stderr
Thread-Index: AQHZ8g6QNoTbYjEiYkufA+3DjikmfrA9wFCA
Date: Sat, 7 Oct 2023 03:56:14 +0000
Message-ID: <c40dcdd8-9e7c-5637-aa59-f481b9bbab4b@fujitsu.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-53-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-53-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS3PR01MB9850:EE_
x-ms-office365-filtering-correlation-id: 8b61c7b6-8cd6-4623-389e-08dbc6e95a22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sn0V7o2gQw8n00lpgoMrntNYtCr4OOFAuQgcB3+Gtdf1euP32T1SbchXQjclKE7Scd/ytHe/WZYqO+YDOr8r5XQFNAYWTyKXpZsybd3twoOxfTZZDHoRPAb25ZQxoDMWEZta0jGZN8QvfBTmymyqpJ6fJ3y1EOQgh2w37kl5BxkXymoeLF35RFytE8F3oTvXMfG419RuH80TQBBSInBGfPrGYbD6AQ+7dwyhzC5zACoYXQZ4XN0eYfTnIQX4TJ5Tdja9dlsdxjp5KRbiqxZwxOBHUZagFdPBBHyAKdGIILhZemcrdOZcaf3D5u8xps7pxajsxqKih7L+YCw89aWPhoiIg7JVoyncFFQFs1Nn+IFdAD2s2j6zveu69XO/xue2HJafPddXbMeUQCUDmaySCY3Fs7AtDlnsIEi8hxxeNdLEkR2c/kn//tRO9lm7YujT5BASxZalzDWqaqOpN8hjBGCiwv8A3UaCiUBJBw4f5Z5AFxA44lLSCaUc6iyqOFsQvdqjEkXqRmOX4EVv0uVp/FNHhjjnS+0Mk2Jo6oVdFirN5rhgQO8OdOBlhhIHOsUlyvswLKZeyWl5qHYsi011GED9NWwbtpGxezsLt8vA+Vw9OU2Nog3ogPFb4OoBDHI/k3DdiZDpeznko0gygeN/kO1OKA08vGn1jMmplNHF/xstDUfS1OS+sFV8oNQmzSpxFRCwFmLf6ALPUnpU+xWwBA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(230922051799003)(451199024)(1590799021)(64100799003)(1800799009)(186009)(85182001)(1580799018)(36756003)(82960400001)(6506007)(53546011)(2616005)(122000001)(26005)(6512007)(91956017)(66476007)(54906003)(316002)(76116006)(64756008)(66946007)(66556008)(66446008)(6486002)(71200400001)(38100700002)(38070700005)(110136005)(41300700001)(478600001)(83380400001)(86362001)(31686004)(31696002)(8936002)(2906002)(4326008)(5660300002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGs0MStjNzN0MUk3MlpGK2dzMm9RN1JBb2FBQ3F1Znd5UXNzYTdKb08vSmFB?=
 =?utf-8?B?Rnd4bmVTZytKbmxmZTFXOGlPa3Z3eHMwdUYyY3FlYTEvY1hZNWJaeXNDMFlK?=
 =?utf-8?B?YTk0VFVyeTBrL0NlM2xxT3VkV2JQdURIVElZdWNFOEdUT2NKR29HYktZYk5W?=
 =?utf-8?B?aHBCVXdTL01iY0NVQWxab2hyOVo3MFV2SHYrWi9LYVp0a3Fva1RYUy9jRVFx?=
 =?utf-8?B?aS9WazRwVjZQUVRLQW9LdnZsOWRka0FqdVptK3VSYmpaT2VOYjFJYXdxZmx5?=
 =?utf-8?B?MVJaYnZkdjhaSDkvS2kwMmI5T1c5d0RVNERHTW45WUZxNTA1VGhHQkIrdThO?=
 =?utf-8?B?ZmhRODl2ZVdMa090T1duNDhqSlFxWjJYUjlBVVVkeE51OWZFQVpyaktsM0Zp?=
 =?utf-8?B?S0ZHamIvUnhPa25RU2VyRjYwS3BtQ3JhdkI1Smt4SlUxWVRiemV3Y2QxdHkv?=
 =?utf-8?B?emFtcFJ5Qnp3Y1Z4b2drUjArd2dNRGwwR25XYzVQdys2VWNBOFJTTjlYY25p?=
 =?utf-8?B?Wm92TFF2elQ4WkRmT1o5VURtczhOc3E5WERodm9jeDRjS2liUnZLUWFvT3lZ?=
 =?utf-8?B?ME9ZMGlJeFkvbXB1RmtkZWNKZG1MTmRMOEY0SkllbnhjNzV6eVpqNk9PSmto?=
 =?utf-8?B?K2FFSHpZVHAxbmdVWGViem1TQStsb1cwQVZsSkxEQmpmeTBQSm9Ta3ZhVGNL?=
 =?utf-8?B?aWYzcTJPZ3ozbUF0aTJPZVQvQ0tISVhTQ3M1VTlTUm1mNVY1U1FFYjRTWHVJ?=
 =?utf-8?B?andKVTYrUEgwcDNFUGhaaXV0eTFSSW9ycHNDWEtQYmVGNnF2d3FYVzJmRTNu?=
 =?utf-8?B?aTR5RFJGVlZPWVVpZHR5VWMrbXNrSGpqRUF4QzBGNWplNm1MRDRpWlNYb0kx?=
 =?utf-8?B?a0EydUJZMU9Mb3E5b2tiL0ttbUdGeUxKNHUxVjQ5dVYvUFI0SHNOMU1tNnpQ?=
 =?utf-8?B?emVwYmZPZGx5VDB1cVVGRTNad1poODNaeC91OVQzLzRPcCtpRkwzZ0U4bUNa?=
 =?utf-8?B?U2VEQURkSFdkaDJFY2ZpbTc2RFloYndraXVzRnJENkthTzZZLzZ2c2loc3pj?=
 =?utf-8?B?SThmSTVYTnExSjluV1UxVWRJZnVyVEtDTXFya0U3d0RMVEp0ZXJybFl5V1M1?=
 =?utf-8?B?QjJZMXB4K0lFWXBaaStxNEdoMGRtTm9DbzEyeUgvOEFRKzBHMnQ5OVF2S3lG?=
 =?utf-8?B?Q25NTHRKYzMyL2tZZzNoWmZIZDlLemdQMWNyakFSQUc2a29uSFlrSHAyMEMv?=
 =?utf-8?B?MlZuaTIweXFLekJGT1NCNUNJdlMrTWhiaU1PWXRPN1A2NFlFK1o2bHVEYUN4?=
 =?utf-8?B?TlQ3TmtMaWpCMnlBQkl1ZkdwQVdzZEJ1bllJTDI4OE1nZUoxQ1pockVPZkg1?=
 =?utf-8?B?M2Rtbk9RNFJnRkh0QWtSN09peTNtR2MyQWlDSlgxcm1UWFU3UzVhYVd6UW4z?=
 =?utf-8?B?WVBqdXQrNWMzeXMvNnRXVFFubko1OWtiQ1ZWZnRVbGNIT0RFOER4NnBiNlVJ?=
 =?utf-8?B?NE05TlNSaHdqY1FjU3dnanphblJyZXU1WmtYb3ZVNDlBWDRBVi9abUdlcWhJ?=
 =?utf-8?B?TjZQYTN4cENncFlwZGF1enc4aWk4YXg4bzc3UTZrbjhRL0c3YzhJVkN3Z1hm?=
 =?utf-8?B?ZTVyUTl2ejZZanVOZ09SaFREVndVcnIzYWhjcVFycTEvb0FLQXNBU2pVZlNs?=
 =?utf-8?B?RWp3U0lDZFNPQ1YyNmZ6NkI0THhuSGRqODJ0SERNRGJZWWxUMkVNbFJvbHVN?=
 =?utf-8?B?WmJJb1NiVU95c1k2MENOWXVldHFhWDljS2htTkJDNENVQ1NQNWp5ejk3WjVu?=
 =?utf-8?B?ZWpNVHcwVDV5RjFWeFhZWE1EdkxjR09Vc0R4bFQ2Q1FVemNyYlpiZ0ZKaTJa?=
 =?utf-8?B?ak5GL0pzdzVDV1AzZ2lYQmQ3Q1hlZ2s2cWhaWldWbG8weE9BRzcwN25lWXo4?=
 =?utf-8?B?eXd1anZ3Rm82ODM0QUJwZ2Zpd2NaNUpqYjhrTHY2M1dHTkhKU1JqZXFVc09E?=
 =?utf-8?B?NjhUV1JVV1drV1R4N1V6d3VyeTUrNkR2WGI2ZUdRZVRoY2xkWmJPak1XRkk1?=
 =?utf-8?B?ajVrem5RZ3B0K3dueHl6NHA1aGFYMTBHVC9Pbk1rdnhIK0QxQzRzN1ZaU1Y1?=
 =?utf-8?B?RW5EWXhsdlkrRlRTblJBSHBLUGVNNGw5Ri9HVlZmZVV5M2p3djVjcGNJUEdI?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1F0808D7EF8BA4F96E94798DCE7B6F6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: W/sSBg+3453F65JTvWwb190ApO5JERJkQvS40H2pVo2B/v6yf1cma+U26Uiv3nolDaPFTJPK9j58cTjFkacgHeUigDBy/m4bIw1U501m7ObMqPRfR2nTPOzILnbNU6V0rhQAmjsBcWrCzApf2nk0mFczs6hJgAcKJ9gTnoLibC9qJemKIjddCsQrpFbCu5ZQHqvsbNJfKqOmUGE+JJBqGgDR1dMinHgqvMpQKY329bVpJwMx3p3+dAFJGC7WVPQtNHiohm8BkN4S+S5Sq1tA3AUFCaVbVZiMZ93krd7of+8T5qBlSdOoAsg0/tMVbFhXiBLq5+zuVrsa7/nbMdutKObkXF0kJQBr+udP/XMbmMpdIYUF3piB7rTdpP8vYWUgbNB7pCaHkoeh6RSC0YEmOJsuxq05ruwzrDnVSe/mqHzC7Bh5uiQboErMhXL0UHf9MhLCLAMigqIjR261Q49zUm4suQTg6fq0AKYZEgUmOyQO+OY15CmqtmQuoua+q4HyP0cu5jwu/0x8BItfE0KoEIjk77BWi52/Fx+pHscqnYWEDvplJ+1zTOe5RPa31JeCDUaLBXu0zhlU25gZu+WQglputkPICHYnQH5Hx+RRWSx7Kne09rS9iPU2XqdNabyaROPnMlZQzVDQ7Uf5yNMew8h4HTihShTrtmJg5+VqjjpIjhiNYB5ZRy9UccTljOYE0unHIMy20SVJjqBkiLSyGqTF0Myc6Gg3uYDs0uq3omTBAjZXhwEn3UIJfcwSr5oJsxpQOfRu8kPHgdfI9Mh6/MKwDfR/q990kuKguSRF5StvcHWHjzjPuhCeMLSnc5Gf
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b61c7b6-8cd6-4623-389e-08dbc6e95a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 03:56:14.4733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0H3FZdrk7hROD3pWRVTPXAhxTBmwrbFhJKNgbWfunwcLNnLpIHm82krKZw0wEa1fiWxLAKNTIAk18BADfFdTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9850
Received-SPF: pass client-ip=68.232.156.101;
 envelope-from=lizhijian@fujitsu.com; helo=esa14.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.797,
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

DQoNCk9uIDI4LzA5LzIwMjMgMjE6MjAsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBlcnJv
cl9yZXBvcnQoKSBvYmV5cyAtbXNnLCByZXBvcnRzIHRoZSBjdXJyZW50IGVycm9yIGxvY2F0aW9u
IGlmIGFueSwNCj4gYW5kIHJlcG9ydHMgdG8gdGhlIGN1cnJlbnQgbW9uaXRvciBpZiBhbnkuICBS
ZXBvcnRpbmcgdG8gc3RkZXJyDQo+IGRpcmVjdGx5IHdpdGggZnByaW50ZigpIG9yIHBlcnJvcigp
IGlzIHdyb25nLCBiZWNhdXNlIGl0IGxvc2VzIGFsbA0KPiB0aGlzLg0KPiANCj4gRml4IHRoZSBv
ZmZlbmRlcnMuICBCb251czogcmVzb2x2ZXMgYSBGSVhNRSBhYm91dCBwcm9ibGVtYXRpYyB1c2Ug
b2YNCj4gZXJybm8uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJt
YnJ1QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVq
aXRzdS5jb20+DQoNCg0KPiAtLS0NCj4gICBtaWdyYXRpb24vcmRtYS5jIHwgNDQgKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
MjEgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWln
cmF0aW9uL3JkbWEuYyBiL21pZ3JhdGlvbi9yZG1hLmMNCj4gaW5kZXggNTRiNTlkMTJiMS4uZGJh
MDgwMmZjYSAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL3JkbWEuYw0KPiArKysgYi9taWdyYXRp
b24vcmRtYS5jDQo+IEBAIC04NzcsMTIgKzg3NywxMiBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV9i
cm9rZW5faXB2Nl9rZXJuZWwoc3RydWN0IGlidl9jb250ZXh0ICp2ZXJicywgRXJyb3IgKiplcnJw
KQ0KPiAgIA0KPiAgICAgICAgICAgaWYgKHJvY2VfZm91bmQpIHsNCj4gICAgICAgICAgICAgICBp
ZiAoaWJfZm91bmQpIHsNCj4gLSAgICAgICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIldBUk46
IG1pZ3JhdGlvbnMgbWF5IGZhaWw6Ig0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAiIElQdjYgb3ZlciBSb0NFIC8gaVdBUlAgaW4gbGludXgiDQo+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICIgaXMgYnJva2VuLiBCdXQgc2luY2UgeW91IGFwcGVhciB0byBoYXZl
IGEiDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIgbWl4ZWQgUm9DRSAvIElC
IGVudmlyb25tZW50LCBiZSBzdXJlIHRvIG9ubHkiDQo+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICIgbWlncmF0ZSBvdmVyIHRoZSBJQiBmYWJyaWMgdW50aWwgdGhlIGtlcm5lbCAi
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIgZml4ZXMgdGhlIGJ1Zy5cbiIp
Ow0KPiArICAgICAgICAgICAgICAgIHdhcm5fcmVwb3J0KCJXQVJOOiBtaWdyYXRpb25zIG1heSBm
YWlsOiINCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAiIElQdjYgb3ZlciBSb0NFIC8g
aVdBUlAgaW4gbGludXgiDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIiBpcyBicm9r
ZW4uIEJ1dCBzaW5jZSB5b3UgYXBwZWFyIHRvIGhhdmUgYSINCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAiIG1peGVkIFJvQ0UgLyBJQiBlbnZpcm9ubWVudCwgYmUgc3VyZSB0byBvbmx5
Ig0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICIgbWlncmF0ZSBvdmVyIHRoZSBJQiBm
YWJyaWMgdW50aWwgdGhlIGtlcm5lbCAiDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IiBmaXhlcyB0aGUgYnVnLiIpOw0KPiAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAg
ICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIlJETUEgRVJST1I6ICINCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAiWW91IG9ubHkgaGF2ZSBSb0NFIC8gaVdBUlAgZGV2aWNlcyBpbiB5
b3VyIHN5c3RlbXMiDQo+IEBAIC0xNDE4LDEyICsxNDE4LDggQEAgc3RhdGljIGludCBxZW11X3Jk
bWFfdW5yZWdpc3Rlcl93YWl0aW5nKFJETUFDb250ZXh0ICpyZG1hKQ0KPiAgICAgICAgICAgYmxv
Y2stPnJlbW90ZV9rZXlzW2NodW5rXSA9IDA7DQo+ICAgDQo+ICAgICAgICAgICBpZiAocmV0ICE9
IDApIHsNCj4gLSAgICAgICAgICAgIC8qDQo+IC0gICAgICAgICAgICAgKiBGSVhNRSBwZXJyb3Io
KSBpcyBwcm9ibGVtYXRpYywgYmNhdXNlIGlidl9kZXJlZ19tcigpIGlzDQo+IC0gICAgICAgICAg
ICAgKiBub3QgZG9jdW1lbnRlZCB0byBzZXQgZXJybm8uICBXaWxsIGdvIGF3YXkgbGF0ZXIgaW4N
Cj4gLSAgICAgICAgICAgICAqIHRoaXMgc2VyaWVzLg0KPiAtICAgICAgICAgICAgICovDQo+IC0g
ICAgICAgICAgICBwZXJyb3IoInVucmVnaXN0cmF0aW9uIGNodW5rIGZhaWxlZCIpOw0KPiArICAg
ICAgICAgICAgZXJyb3JfcmVwb3J0KCJ1bnJlZ2lzdHJhdGlvbiBjaHVuayBmYWlsZWQ6ICVzIiwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICBzdHJlcnJvcihyZXQpKTsNCj4gICAgICAgICAg
ICAgICByZXR1cm4gLTE7DQo+ICAgICAgICAgICB9DQo+ICAgICAgICAgICByZG1hLT50b3RhbF9y
ZWdpc3RyYXRpb25zLS07DQo+IEBAIC0zNzY3LDcgKzM3NjMsOCBAQCBzdGF0aWMgaW50IHFlbXVf
cmRtYV9yZWdpc3RyYXRpb25faGFuZGxlKFFFTVVGaWxlICpmKQ0KPiAgICAgICAgICAgICAgICAg
ICBibG9jay0+cG1yW3JlZy0+a2V5LmNodW5rXSA9IE5VTEw7DQo+ICAgDQo+ICAgICAgICAgICAg
ICAgICAgIGlmIChyZXQgIT0gMCkgew0KPiAtICAgICAgICAgICAgICAgICAgICBwZXJyb3IoInJk
bWEgdW5yZWdpc3RyYXRpb24gY2h1bmsgZmFpbGVkIik7DQo+ICsgICAgICAgICAgICAgICAgICAg
IGVycm9yX3JlcG9ydCgicmRtYSB1bnJlZ2lzdHJhdGlvbiBjaHVuayBmYWlsZWQ6ICVzIiwNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cmVycm9yKGVycm5vKSk7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gICAgICAgICAgICAgICAgICAgfQ0KPiAg
IA0KPiBAQCAtMzk1NiwxMCArMzk1MywxMCBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV9yZWdpc3Ry
YXRpb25fc3RvcChRRU1VRmlsZSAqZiwNCj4gICAgICAgICAgICAqLw0KPiAgIA0KPiAgICAgICAg
ICAgaWYgKGxvY2FsLT5uYl9ibG9ja3MgIT0gbmJfZGVzdF9ibG9ja3MpIHsNCj4gLSAgICAgICAg
ICAgIGZwcmludGYoc3RkZXJyLCAicmFtIGJsb2NrcyBtaXNtYXRjaCAoTnVtYmVyIG9mIGJsb2Nr
cyAlZCB2cyAlZCkgIg0KPiAtICAgICAgICAgICAgICAgICAgICAiWW91ciBRRU1VIGNvbW1hbmQg
bGluZSBwYXJhbWV0ZXJzIGFyZSBwcm9iYWJseSAiDQo+IC0gICAgICAgICAgICAgICAgICAgICJu
b3QgaWRlbnRpY2FsIG9uIGJvdGggdGhlIHNvdXJjZSBhbmQgZGVzdGluYXRpb24uIiwNCj4gLSAg
ICAgICAgICAgICAgICAgICAgbG9jYWwtPm5iX2Jsb2NrcywgbmJfZGVzdF9ibG9ja3MpOw0KPiAr
ICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJyYW0gYmxvY2tzIG1pc21hdGNoIChOdW1iZXIgb2Yg
YmxvY2tzICVkIHZzICVkKSIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgbG9jYWwtPm5i
X2Jsb2NrcywgbmJfZGVzdF9ibG9ja3MpOw0KPiArICAgICAgICAgICAgZXJyb3JfcHJpbnRmKCJZ
b3VyIFFFTVUgY29tbWFuZCBsaW5lIHBhcmFtZXRlcnMgYXJlIHByb2JhYmx5ICINCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAibm90IGlkZW50aWNhbCBvbiBib3RoIHRoZSBzb3VyY2UgYW5k
IGRlc3RpbmF0aW9uLiIpOw0KPiAgICAgICAgICAgICAgIHJkbWEtPmVycm9yZWQgPSB0cnVlOw0K
PiAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4gICAgICAgICAgIH0NCj4gQEAgLTM5NzIsMTAg
KzM5NjksMTEgQEAgc3RhdGljIGludCBxZW11X3JkbWFfcmVnaXN0cmF0aW9uX3N0b3AoUUVNVUZp
bGUgKmYsDQo+ICAgDQo+ICAgICAgICAgICAgICAgLyogV2UgcmVxdWlyZSB0aGF0IHRoZSBibG9j
a3MgYXJlIGluIHRoZSBzYW1lIG9yZGVyICovDQo+ICAgICAgICAgICAgICAgaWYgKHJkbWEtPmRl
c3RfYmxvY2tzW2ldLmxlbmd0aCAhPSBsb2NhbC0+YmxvY2tbaV0ubGVuZ3RoKSB7DQo+IC0gICAg
ICAgICAgICAgICAgZnByaW50ZihzdGRlcnIsICJCbG9jayAlcy8lZCBoYXMgYSBkaWZmZXJlbnQg
bGVuZ3RoICUiIFBSSXU2NA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgInZzICUiIFBSSXU2
NCwgbG9jYWwtPmJsb2NrW2ldLmJsb2NrX25hbWUsIGksDQo+IC0gICAgICAgICAgICAgICAgICAg
ICAgICBsb2NhbC0+YmxvY2tbaV0ubGVuZ3RoLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAg
cmRtYS0+ZGVzdF9ibG9ja3NbaV0ubGVuZ3RoKTsNCj4gKyAgICAgICAgICAgICAgICBlcnJvcl9y
ZXBvcnQoIkJsb2NrICVzLyVkIGhhcyBhIGRpZmZlcmVudCBsZW5ndGggJSIgUFJJdTY0DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ2cyAlIiBQUkl1NjQsDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGxvY2FsLT5ibG9ja1tpXS5ibG9ja19uYW1lLCBpLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBsb2NhbC0+YmxvY2tbaV0ubGVuZ3RoLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICByZG1hLT5kZXN0X2Jsb2Nrc1tpXS5sZW5ndGgpOw0K
PiAgICAgICAgICAgICAgICAgICByZG1hLT5lcnJvcmVkID0gdHJ1ZTsNCj4gICAgICAgICAgICAg
ICAgICAgcmV0dXJuIC0xOw0KPiAgICAgICAgICAgICAgIH0NCj4gQEAgLTQwOTEsNyArNDA4OSw3
IEBAIHN0YXRpYyB2b2lkIHJkbWFfYWNjZXB0X2luY29taW5nX21pZ3JhdGlvbih2b2lkICpvcGFx
dWUpDQo+ICAgICAgIHJldCA9IHFlbXVfcmRtYV9hY2NlcHQocmRtYSk7DQo+ICAgDQo+ICAgICAg
IGlmIChyZXQgPCAwKSB7DQo+IC0gICAgICAgIGZwcmludGYoc3RkZXJyLCAiUkRNQSBFUlJPUjog
TWlncmF0aW9uIGluaXRpYWxpemF0aW9uIGZhaWxlZFxuIik7DQo+ICsgICAgICAgIGVycm9yX3Jl
cG9ydCgiUkRNQSBFUlJPUjogTWlncmF0aW9uIGluaXRpYWxpemF0aW9uIGZhaWxlZCIpOw0KPiAg
ICAgICAgICAgcmV0dXJuOw0KPiAgICAgICB9DQo+ICAgDQo+IEBAIC00MTAzLDcgKzQxMDEsNyBA
QCBzdGF0aWMgdm9pZCByZG1hX2FjY2VwdF9pbmNvbWluZ19taWdyYXRpb24odm9pZCAqb3BhcXVl
KQ0KPiAgIA0KPiAgICAgICBmID0gcmRtYV9uZXdfaW5wdXQocmRtYSk7DQo+ICAgICAgIGlmIChm
ID09IE5VTEwpIHsNCj4gLSAgICAgICAgZnByaW50ZihzdGRlcnIsICJSRE1BIEVSUk9SOiBjb3Vs
ZCBub3Qgb3BlbiBSRE1BIGZvciBpbnB1dFxuIik7DQo+ICsgICAgICAgIGVycm9yX3JlcG9ydCgi
UkRNQSBFUlJPUjogY291bGQgbm90IG9wZW4gUkRNQSBmb3IgaW5wdXQiKTsNCj4gICAgICAgICAg
IHFlbXVfcmRtYV9jbGVhbnVwKHJkbWEpOw0KPiAgICAgICAgICAgcmV0dXJuOw0KPiAgICAgICB9

