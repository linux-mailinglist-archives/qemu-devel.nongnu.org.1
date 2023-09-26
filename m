Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C377AE570
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 08:01:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql18E-00087L-6X; Tue, 26 Sep 2023 02:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql18B-00080H-1g
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:01:11 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql187-0001AL-11
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695708068; x=1727244068;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=wIkTAlYxc85zhUc4UvwyD6Df2j8xZ1bkYaNDxBE4syg=;
 b=Hd3WH5W/eK/QV5ucq93omR5juqu5vywNfImrHLH6XlHE6bre6XSMvSye
 cbzmDHkb1ApJb5686UD057YciDDmwTARZmJG/XWiLMc2eVgPqy5GU5bLR
 j727ZsrLOCdszhGMtfISGAM/wi6ETj9qAmJwhtlh1GvyhZosKWtgmMW9l
 zXW/FnU6lrbrG2dv4pxqN/fUAFN/IdxuHy5Bh1Ol+RHtAXbw+ULnsM7yD
 mlYJ/duPt1BuQMtQacQb/Wp45I/vPbxxqvrBbsG+pkTmVJ7st1FBF3Jt4
 H4HuN/GEiucltxkTvI68F+Yt/TQbsDMu0xiEiL4vZxI0GaPrabanB8XQa w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96879552"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="96879552"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 15:01:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nr260+OPfvgnWv4Z2FElgjtWML/2ihS6iD9Jm7SBgNcd2as2jWzZp8UuST51G9uUL1HOoa8/L/fACN2fN2B7ZsGGQcTDe5iap5lXSn6M6KKogLZ6TgAFovYUUd2MBDMZIECaNsHftNELnqAXYESal2YJ8wv5NbhWqALgouLHPLlYcTh98VEyzFaVFfMnwpkxREQetXI8LbcFW2eE5DaF71ikdgj+QasaTVDnhAV+u0qjDF3/SFXAgPmLFdgnaq48uIT5gUyMJd08qEvHihZfhqp9DR9U3tf844oQwGnmmK3LG5D5xp17a4zeUTb2LHFnesHGa2dUrWfv7+GjDiUAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIkTAlYxc85zhUc4UvwyD6Df2j8xZ1bkYaNDxBE4syg=;
 b=lwkQzQdCjelHPv/4jIMbm59QBbCnli/Tu7cdky7DheH7oOFK0WsfqrggVFSfTqRAhzPmr+J+GEyIFH7ytPyX+pk+pyLtK/ZU56Nl4IyKgcGwymta7mENekRjto5SXdFWpuTng4x4woWVWSxv6TQgpPDA5ZS+CFoqwP7ZeWfthrYRz8MaRVqxVswbNKuBIKjjMupDXpxGENyt5Z7rmu8AAN7wPuIePdp2rBllx4O2QZGCgv+XC2qudqps2VTLawHJQeLbLuOTbxkJGz6vR75+/zhNubT5uDIVQCawiRqj5UVEwohSfWOgK9eR5GBA+ZwfkXSG+AMnrivJ5ZVvh0U7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TY3PR01MB9728.jpnprd01.prod.outlook.com (2603:1096:400:22a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 06:00:59 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 06:00:59 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 46/52] migration/rdma: Silence qemu_rdma_reg_control()
Thread-Topic: [PATCH 46/52] migration/rdma: Silence qemu_rdma_reg_control()
Thread-Index: AQHZ6j6A80fl+3sv0EW8xp2ro7HmBbAsqSWA
Date: Tue, 26 Sep 2023 06:00:59 +0000
Message-ID: <19e78db5-dbdc-c6b8-c6d3-bafe0178095f@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-47-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-47-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TY3PR01MB9728:EE_
x-ms-office365-filtering-correlation-id: bca5900f-ee5f-416e-9308-08dbbe55f4fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H58q+raSgjYj7ER9f/W8FS6hewjxOdtqxyKW86QvRmdMChIimXvhpaBLZjghBLhhuh6NBw6gniBUf8dsEzliRYllJ8dRQ2ZdK4XjgZkart19rtagc+ANd6I5ZLisTtwFc4Qst22d95tx9BGkkuv8eR60HAfLZzElWG47jMmPOCzit81T1Y2NJGAJwr2w58Q1QS2a5KySpc6XUR6sg192iaBaleHT2tqq63b4XgYClhsSC4M4b+rtWvZcpCm6L7Mh1hcTDEI/eoPzzJ1vCsGuyxnYK7ycE+ewvSMppUk9nE38npqxwzdMfdyArNQ2hFPrlGgDHgLCut21v7Vhs3wud/dcLXw3qFENGmtXHMVEioPOGaOH6j7168Yt56QNssrT4zbZLLaFXrhWXgJ2l7lvAoYxOzzQ3eWy4fKoWq1teKfyexHM9YghphpY2olLp7OOXr4fuT2f/jO6EGZOzoypaFeupxDctq3JzRuUY0Jht/OkAnFHfH6NaKxPJtjAyGe7IwbCP4RhyFQA7OmPDyP54jp2ScnIUhyAAy0LwbF1+3DeO7avSNCpdK/WPoxIisiUqAQ61c/cP78rH4XthByYVoTu7gvzQlT/jBaNYdTjjdAdH7M3BI6KVcl8VYf8CyitwJAI7e7dCopWi3e+Rx0jilaB4VnReRhHT8mP896j2w4wQEBeWmo6+JaSm4WWXuz+oIgxBHp4FD0gS/UMWAk9Bw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(1590799021)(186009)(1800799009)(451199024)(38070700005)(36756003)(122000001)(38100700002)(82960400001)(85182001)(86362001)(31696002)(31686004)(1580799018)(76116006)(53546011)(6512007)(5660300002)(66476007)(2906002)(2616005)(478600001)(41300700001)(316002)(66556008)(66446008)(54906003)(64756008)(91956017)(110136005)(66946007)(83380400001)(6506007)(71200400001)(6486002)(8936002)(8676002)(4326008)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEduTVZmK1hUOVZ6TnR6anZ6MG1ZbjB0aElPTHNlRGx5empxcWxSQUVlTlhV?=
 =?utf-8?B?OHNFdkJDZ3UvRzF1WFFpdmwxTTFmV0RUWG8zYXNrR3BUVlJ5dWlIN0Zzc3Vy?=
 =?utf-8?B?UTJTYjNnUFRpNkZaMzliMmxWWmhGcnhTOEJyNlM2ZEg3VUpsR1Bnb3RQRXR0?=
 =?utf-8?B?UWRWS1lMd1RlN1FzNTJGR293UGZhTTFhcEhaZTVzOXVTbDk5a3V2bEN1alkz?=
 =?utf-8?B?RTQ2UnVKS1FEaExBakpiQzhjT2hkcDliVThIRlJZbXJQbkl6Tmw5WTlENGJs?=
 =?utf-8?B?MHJVVGt1L3hRVzh2QWxxVWM1aWdWT0tYdFNoY2tsdGxJcVVsbEd1SWJwcVQv?=
 =?utf-8?B?aHFaWUlQejhuaEtBajYrdGF2UlVUU3ZJVm1ETDZHNTVqQlc5dm5URUdnWGp1?=
 =?utf-8?B?blM3VmV2N0dtQ1lqaUhYNWpFR2V2T0tkSnExQUh4ZnVvL1A2MTVwaytXNCtQ?=
 =?utf-8?B?Q1ZJNHB1cGpJOVNsTGsrK0ExUGw0KzY0OWx0UkJlTzRJTERMeFpDdHRJeTBV?=
 =?utf-8?B?STRNWWNmRGNJOFdoRVRsRmVsUXJjQ3pPOVhKUFdZcEdtaFFUdEswZzhBQnFq?=
 =?utf-8?B?V2g4QVRBZFVwRXBjUHR2ejYwR3hyWXdiN2l1bEM1OWJmTFo2OEZCdTI5dVlz?=
 =?utf-8?B?ZXhaL2JINTRMYTRTVWdhUVM4MDZ5Zk1kM3d2cW9wdU82MnA0MkRLQ0N6anZk?=
 =?utf-8?B?eklnOXZUQkx6RktSQjU3N2NKb3NFQjNHc2tFNVRHY21KTkcrbEMrSTVYY3Bn?=
 =?utf-8?B?YmM0UnVCbUFUS21vZnlTNmp5RFAzdllUUFJOYjdyWjlRK0dSSHBqdGR1YlBW?=
 =?utf-8?B?czFXeThkTEJpSklBbDliVS9ZVTkwZlVlN1BreWR2WU5JZFgwRFN2RjkwL1JE?=
 =?utf-8?B?azdWTlVNM0NRSVdqZ3FxOWk2VFZYYnFnb1hjVVhoZkxHVTlUTjVyYVc1Mkhn?=
 =?utf-8?B?aUo3eW9vcmFjTkNxM2pxV1JWZDRhRjZMOEp1d3ZKRHl2UEloWnBSTTN2MkhU?=
 =?utf-8?B?L0hOU2JtcExSMUFudlJ5WTYrenRYenVTUVpNdnVpaktiT3IxL0xRRE5VWGEr?=
 =?utf-8?B?VkMyZ2kxWXYyeE42YkV0SXlHcVVLeS9SMmtnZ1dEc0JvT3pUS2ZrelhIM1d0?=
 =?utf-8?B?Y1FSUGhvRHpDdjE2YzhvMWVGRWVnWFZ5OCthSDFCeGczVENXM25lY1ArVksz?=
 =?utf-8?B?T0R0ajhEN2NtdFhqTVQzWFBxVDNQRkRvM2dvVGJKVUZDb3Q0VjZoc3JOUm5R?=
 =?utf-8?B?a01XZ3dMcEkzWGxUZlNvcXZDZWZ3THd6YXFuM3BKSHAxM2JzM3R5MFNtcVM2?=
 =?utf-8?B?YVROZUh4ZTU3NUxpdFU0TUxhR2VyWE5QRU9GSWxCVkt0WWF6OWZxeTc0VzE1?=
 =?utf-8?B?Q0V0eXdHUWFnR1Yvd3lSRS9CaGVaSXovb0NrOHdRRWdFTGJ5WVUxakRjdGdz?=
 =?utf-8?B?S0Q5ZWx1ckpFL0lUWFEzeVc3YzRENjl3dHViV0x5RHl1MklvdmNmOVl2aFZD?=
 =?utf-8?B?SytaTi9Ka24vNTVZblBYSGk2aDZJeXlJV2dMUXVzd0NVVHVvNEtmZGJJbjI1?=
 =?utf-8?B?Wm1PbHo5NTloc0crYUE2aEZsaVBoMmNBNXB2Q01FUzZIZm0zazFObUlZMS8r?=
 =?utf-8?B?WldiL1libTRtWms1M011NkU0YzFSZ1RmNDVLYVVienROcTNKTGpLbklCQzhG?=
 =?utf-8?B?NEE4ZVZoQUg4TWZBQjAwMThrclZDNnpXZDJHVzFOaDIxK2h0TlFrbE4zTnpk?=
 =?utf-8?B?d0xhUE9EUlBPOGx1dUJvM1RYTThDWWFoSmlHMmxYeUNIUkNJZGh6VGM3b1ZH?=
 =?utf-8?B?QWxtai9rVTVKeHA1Nmc0dXE4UDNwSDFCSVZBQ2oyZVRPYmw5MEgvNjJ3dnJL?=
 =?utf-8?B?VWlXa1lhN1BLS2lDcU5ZU2tkVENMOW91K3RXQ3FFZzdmU3ZwTEVmeDJNV3RD?=
 =?utf-8?B?MDYrd3NRSTJKUG5nTnRBcjVJTDVqQmRMZlpBRnhQK0NFTW9pMzdvNy9FMHFj?=
 =?utf-8?B?OEJSTmxwb3RLUXBpMDduY2NqRGhva1lMaWRLMFQ2WG1zQjBaOXFyamtvdERR?=
 =?utf-8?B?QlREbFBRcUorK091bytxYXNZTmh3TWRkTHIzczB2dDVDbEtaWkhXbEZJMjMz?=
 =?utf-8?B?cVMvRk5hem9xdXU5L3lycmFSQVh6M1VuQ240QWdIOVNBb1dCRlk5dStmdlRS?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1533A641243E154DA1D4EFC773C17214@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5hXLYQb/pnM/h3/kGe1oZ7UD65fmT58lB65uE4t8nyPZ3Yx2M7AXcEUZLm3F+CHCkkR+cL6IaE7f2rlSFW2A2VoU6FjQaJtgUnn9fEgRXmFQa/OYRmhNUu7Yiq0CBm3pkne0qCVhWL0AHgflMC1zRg3eAL7QyW8yj9FnGj0HNwajZFnenwcXtC6Dd1XSV4jOYcmAQWprru19od9cm6kMbCQb2dIttMF5rEOCGDJzw0x4xi/3D3HIvbvInZAroM4BETzOrssGHiK2tzT4unmHlzXpQCzywDjr0BmLxJTGObfAq4cHx4yP7/hyZeL3+MdXq1EwQ8z/Kt6F7TSbbhmvaNBjtK5bR7DtC81keNF/MXMC2Ze6U53REzpXLYsIqjMsDRNGXycpi37H/HWlcpUrCHQr7TRwoQmfhsXCE0nhs5PY/lnGd4Uxt0aI1TBHDRgcPMVMJWlmvlxmCeqacv1XEli80lTGBMH5lqonUzAwJZrL5f6hmuoaegY7tPK5zq3mX9gnBup3Aq7ztev20jjJC9FxvytVlgkrzNKv9UY5K07sERp4tNFrhr9uxMOFCusKMbGeuioEwx+9EVrX2Xgz932mPcPBl8caqcKZ6ubefE8Zh935KvOsU6hyAjOJcgL4PRv+TcNnUgNmsjemXaLXwnC3TplSM074Ma2ru398GjwMEaJvEt32oEiwUhbN0E4hYTt9YZKNxHSdD/s9UqU/YIrlsgM591np32YS1eitZYZEL6+xywlmqJCyVtdnWGC1Mr3t8+JdzeNVKf4LlpTQVvzQYfXKYaWJJH0QFfk2CHg=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca5900f-ee5f-416e-9308-08dbbe55f4fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 06:00:59.4291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehol4wahlIIFvNdaHdb9a4sJeYtYaHXDCBXyWckEldN9TMh7yUuR+zysxBHGMAVSZt37iXud6Hj7W1eJydsicQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9728
Received-SPF: pass client-ip=68.232.159.90; envelope-from=lizhijian@fujitsu.com;
 helo=esa9.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDIsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBGdW5j
dGlvbnMgdGhhdCB1c2UgYW4gRXJyb3IgKiplcnJwIHBhcmFtZXRlciB0byByZXR1cm4gZXJyb3Jz
IHNob3VsZA0KPiBub3QgYWxzbyByZXBvcnQgdGhlbSB0byB0aGUgdXNlciwgYmVjYXVzZSByZXBv
cnRpbmcgaXMgdGhlIGNhbGxlcidzDQo+IGpvYi4gIFdoZW4gdGhlIGNhbGxlciBkb2VzLCB0aGUg
ZXJyb3IgaXMgcmVwb3J0ZWQgdHdpY2UuICBXaGVuIGl0DQo+IGRvZXNuJ3QgKGJlY2F1c2UgaXQg
cmVjb3ZlcmVkIGZyb20gdGhlIGVycm9yKSwgdGhlcmUgaXMgbm8gZXJyb3IgdG8NCj4gcmVwb3J0
LCBpLmUuIHRoZSByZXBvcnQgaXMgYm9ndXMuDQo+IA0KPiBxZW11X3JkbWFfc291cmNlX2luaXQo
KSBhbmQgcWVtdV9yZG1hX2FjY2VwdCgpIHZpb2xhdGUgdGhpcyBwcmluY2lwbGU6DQo+IHRoZXkg
Y2FsbCBlcnJvcl9yZXBvcnQoKSB2aWEgcWVtdV9yZG1hX3JlZ19jb250cm9sKCkuICBJIGVsZWN0
ZWQgbm90DQo+IHRvIGludmVzdGlnYXRlIGhvdyBjYWxsZXJzIGhhbmRsZSB0aGUgZXJyb3IsIGku
ZS4gcHJlY2lzZSBpbXBhY3QgaXMNCj4gbm90IGtub3duLg0KPiANCj4gQ2xlYW4gdGhpcyB1cCBi
eSBkcm9wcGluZyB0aGUgZXJyb3IgcmVwb3J0aW5nIGZyb20NCj4gcWVtdV9yZG1hX3JlZ19jb250
cm9sKCkuICBJIGJlbGlldmUgdGhlIGNhbGxlcnMnIGVycm9yIHJlcG9ydHMNCj4gc3VmZmljZS4g
IElmIHRoZXkgZG9uJ3QsIHdlIG5lZWQgdG8gY29udmVydCB0byBFcnJvciBpbnN0ZWFkLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPg0K
DQoNClJldmlld2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCg0K
DQo+IC0tLQ0KPiAgIG1pZ3JhdGlvbi9yZG1hLmMgfCAxIC0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmMgYi9taWdy
YXRpb24vcmRtYS5jDQo+IGluZGV4IGJmNGU2N2Q2OGQuLjI5YWQ4YWU4MzIgMTAwNjQ0DQo+IC0t
LSBhL21pZ3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBAQCAtMTM0
OSw3ICsxMzQ5LDYgQEAgc3RhdGljIGludCBxZW11X3JkbWFfcmVnX2NvbnRyb2woUkRNQUNvbnRl
eHQgKnJkbWEsIGludCBpZHgpDQo+ICAgICAgICAgICByZG1hLT50b3RhbF9yZWdpc3RyYXRpb25z
Kys7DQo+ICAgICAgICAgICByZXR1cm4gMDsNCj4gICAgICAgfQ0KPiAtICAgIGVycm9yX3JlcG9y
dCgicWVtdV9yZG1hX3JlZ19jb250cm9sIGZhaWxlZCIpOw0KPiAgICAgICByZXR1cm4gLTE7DQo+
ICAgfQ0KPiAgIA==

