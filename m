Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 452D77AAD51
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:00:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjc0I-0008EV-BR; Fri, 22 Sep 2023 04:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjc0F-0008AI-RW
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 04:59:11 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjc0D-0004ds-Kt
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 04:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695373149; x=1726909149;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=YPX6AlT2lhQH3yYPd+jgHVJ3k4OjxecPfN8qAkf0iJw=;
 b=UM3U8ldtNm/1XyBdwQ2XRrGG7PhINsjWzc45uDN5OUBshBwuJjXQeUNv
 +hj1qbAVebqlCsUDUigQxJG9qUxsyG4MtGEaLjFaPhfprBSca7dGZncCD
 CU8/cahP31ie0mSa14D4f5FVbnIeVC5bxfHQ5TLaPRmuVq4mOQIiT391f
 2TRScwc9J5XCF9Qu5gDUtHr2klrgQeV8I6gE9hg+PT8YzU5/AxaFjyzs8
 ISQ+KXAZpiOBv1F+GuxejjXflnes29FBsPEMh5U6l2Z/Y60ejkF1ojlC9
 3rWlvjoSGBhlDCiAZSkPhoinvQmbTO9AXDPH0jThgMauBc5m39uSu/KSs Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="9219003"
X-IronPort-AV: E=Sophos;i="6.03,167,1694703600"; 
   d="scan'208";a="9219003"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2023 17:59:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wlcko7mnudGaUbLoB6uEYh8cb5hJEuots+n7pgeXKBPKreyU0V5W2bzq9rjyOyfmgnc4xZKGKRjOs2BJLSdLTizB2rDNoE8wSrZhpcgJ2C86HRgJ+aWNhxbu2TbFrNgBJrj0y+WX4qTF2gNK5XiToKyDJBUPk7NosTeE188I1ml+tTquxvMh1e58eZoJfRUUG+6M3foZZE64VSAUdlxbG067jIAOo1G+TtzJZ6L8vT4nBawKq5YWMcehXatxhC7y11t+0UvhOGiiRbKuIxmWhkRmmvtLAvBtNo78L7XBwvd19D4BHAGxzePPB4izsIYZ7nYma4ighnA1Fm8WuEWSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPX6AlT2lhQH3yYPd+jgHVJ3k4OjxecPfN8qAkf0iJw=;
 b=mRIJ8zlVjycU1TT9gHmX6cnG3B5IsrpVUlw1xGHrc0p2HK5CfYaF+18FiYNX0iZCllqM/BpyCDtqcOMdeklLfNzwhAUz8XdtQ2EvpUOgO5ZOKCGaoPIaly6cthHvaAZdFfoCmmZ2VmrzU8NCc+p0pRIJ6NRoL5yyjgxZaSz8I4WmvaCMjd9o8JcwzBeydR4U3FgmUqpSfc+kdoVEwJIjL+cXzR2QxnNuO+LQswsGW6MYr6LunPJAXxKrDGDjRSce0j8DvP9+tNdTq4FOWS55QINPtKgvbP/Fkm69dGh/3Fy0VFNr99cOqCCHCmy4lOdPb5TcooDxENAnPaZ5EUtUmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TY3PR01MB9763.jpnprd01.prod.outlook.com (2603:1096:400:22c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 08:59:01 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 08:59:01 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 16/52] migration/rdma: Fix io_writev(), io_readv() methods
 to obey contract
Thread-Topic: [PATCH 16/52] migration/rdma: Fix io_writev(), io_readv()
 methods to obey contract
Thread-Index: AQHZ6j9FYaX7fN20ZUqLlTHlFNfG3rAmkY6A
Date: Fri, 22 Sep 2023 08:59:00 +0000
Message-ID: <e0e7e9ac-5d36-05d4-8f30-9a47fa9bb3fc@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-17-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-17-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TY3PR01MB9763:EE_
x-ms-office365-filtering-correlation-id: 598a22df-cc9e-4cbc-1bde-08dbbb4a2a06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nr7UnKv+hsDckLmWST5SowbwG0Ar5HCnUO7j6VSa5xlJwpKiStlTDVAU4aNwbqevtPnfEY7LiPjPmGuyQcMpfc5kxn6GGgaklo0tRUDD3FVCvYVFif0C4Sum+9iPo/2048DOCeJ8mT0YoYQfPsruLHaO1yYg4loUzHQScp2i/CSx5inq/UKj8exB0PlKtQPVkQtTL/YBwKvmzJGI2Q7ArTxau6PAUeLLtJrs/TrmfvFecMblNpGiOHsjAO3uy2SSKT4QvDA6+RsTI3ls2kvXvPVE5owAMjMy0jNtop/JDE1BV4RTI8hYSfq7fsV2iixRPwYLxi0VV2bxGjWu1KdSxucoetSScZwXNLtUfn/YeGSDeq8/Oa7jl0GHMaSfPgJhLNI6qxkxkHurFSHPyiPgRWxsR8r2BaN5AQzIazXsYeoC8WYDBCAIDqXIMui7vvIzo4GovTbnLhY96gQJ9FbHCWNAsPzMW+CwaYlIyPSVL9jTYy4pnxnogrlJg3FGMV8JhDl37PS433mWy+Cv88NIRvsPMZHtRPRMJ+i5DqyAJV1sKWoeQ9bZFVR0deao7EqMtz5R+3DRuzwpk11fK5Ro+dbjuryXO/CLV9mjwpNLYklv8O2ACZ1bRxoxZgYeHmOBLtdQfFKSkl3xQd9xDTvYFZAJuafbl18S0n+95fWfBdH64BwbOA5F6OQJsL1B3r2VgkkpkCSMweQDfKC3SOlugQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199024)(1800799009)(1590799021)(186009)(2906002)(5660300002)(76116006)(26005)(66556008)(66476007)(316002)(41300700001)(64756008)(66946007)(110136005)(478600001)(54906003)(91956017)(66446008)(4326008)(8936002)(31686004)(8676002)(6506007)(71200400001)(6486002)(53546011)(6512007)(1580799018)(85182001)(2616005)(82960400001)(36756003)(38100700002)(122000001)(38070700005)(31696002)(86362001)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTZoa3N3SEUySldXQmQzZGxHZU8rTW1XRGtoeUVHUDEwTHhXeVBqZTF0cnhG?=
 =?utf-8?B?TktCNy9pT0pWcUozMTgyMUgxSUlMNVQwSUZQMXYweDlzaHdqTEUvc0huWjRK?=
 =?utf-8?B?WVNwZk13K3hWTmliQmgyK1FHbi9EYmI4akRDZzdJOUlUMXFXZm9XOHpTRmY3?=
 =?utf-8?B?Mjd1Zm40V1FmMGhicWhHZ21sOEJjR0orSnRPTDFVSnIzeVFFL1RWd3pjT3ZV?=
 =?utf-8?B?Zmk4MFpJNW5rclhiUElaMFc0UUkrbWl2bDltdnZxWlk4N29GbFVFZXA2RjFs?=
 =?utf-8?B?ZGRlU1ZxU09qNkNXY0lSMjZRSGJBbnJVWHhKMTRnbjVnYWpmY0YrZkZibUlu?=
 =?utf-8?B?Y2NhSU1zdTEwY29JU243bEpjalF4K056cUIzMGIvalErbkpXQzNoRzhkOTUr?=
 =?utf-8?B?a28wMjh0L25XdHJqWnRMdzlTcjB5WjROcjNONy9MQTV6VVNJcSsrRVM4NEo5?=
 =?utf-8?B?M1FhOHE3Q3pLZ2pxYW1VdTVuSUozVlNkenIreVFQcExZZGo4SUtzL1JkY0VF?=
 =?utf-8?B?YW8rd3VTSklzSVBSdER5TDlUaVFCTGFVRUc3MlJ3OXZkMU5oemMxVnBMazdu?=
 =?utf-8?B?TjlqVXVvN0xBT05GdS94NFR0N0dLUlFvN013ZUtzV2tER1A5dGxCTFhtN1pk?=
 =?utf-8?B?b2I3NXR6cDdyb1h0SkNjZzZvaVhSWjFTUHB0MnZxMUhseC81SXRRdWZOY2pz?=
 =?utf-8?B?d2c2R0w1TUJlQnNHaHJqVTJCRFdZRWFSTHZKcHhCSEtSR2hMNElBUzFuKzhl?=
 =?utf-8?B?a2Q1N2xVYVFaV2NxTW92dTZ0Nm5mbkxOQ01qTVU5R1hpS3JMQnlUZTRHSGVF?=
 =?utf-8?B?d3ExRE5wcVBYNzl6aTVKTy85Zkhoamo5c2F2UlVJQzIwTk9PYjQ4U1NRWDZo?=
 =?utf-8?B?WFY5MzExZWRsSUZ0OHF0dGl3MkJUT0FRM29DK1hxbHpsSjkrRjF6VVpRQzJC?=
 =?utf-8?B?LzFlQ0FvZU5SSGs1VHYxVEhTdWxtRFpHWTBGYVdkODlRa0d2MEJ0SGFWbndO?=
 =?utf-8?B?ZkRCQmpra0JYcENBNzhpL1EvYU1LSlorc2ZQS3ROcjRVT3c4bmkzQjBYSlZV?=
 =?utf-8?B?S3VYZG1seU1sdUxnTGx0dGdjMTEyV2pxWVdLU0lFWHVzVmtXNmt2WHkrL21I?=
 =?utf-8?B?cUpONlpvYWJnWGtUOXlJU1Jib3FWZ0s4Q3dJU0tZYk11Z1ZFY0lzVXVib3M4?=
 =?utf-8?B?QjZsa1I4cVpYN1pjMDhoTU4yV3l1aUlqN0JvSzZGMjk3NnJ2M1A0UXJSU3BU?=
 =?utf-8?B?aEFNY2NkR2VFdUF1KzU4RFJQYTFKdEJpUGhabzlreTlpSmxDRjhKUWtDNnVG?=
 =?utf-8?B?RWlDZXcyZTl6ajNxZG0yMDg2d09jdk00ZzFaRmpsSFczaGhpL3dlTVByblZC?=
 =?utf-8?B?Tm1TZkx2SjhEblBaQUpHZ2NRY2swdVRTdnA1RFg2V0VMT2Nud09HbDFHR0VR?=
 =?utf-8?B?ZTdSR2F3c25XTFJZQUM0eGZOaWh6cXRmd05iaXByckNDa2lzQXFMUDVBbnpw?=
 =?utf-8?B?VkxFR095M3VueHRkblAyNDdTR2pjQzQxRHdTaGR1bnJoQzh0UzlZK0NIbXJm?=
 =?utf-8?B?NUF1UXVrd25kUVBiWkc0ODNRenRNTjFtc0U1R1VIcmpPcjZnY3dvMGdhMXJH?=
 =?utf-8?B?TWExem1jdE16RUtJV2lRQWNhRmVPSVY1YTNPbXdBbmdhU0xLRWVPRTZBOGhX?=
 =?utf-8?B?ZzN3KzlwN01ldmJRYjVQUmhmQkp2VVhyWE5xb0d0d25pRUE2QmxYUmtBUHpo?=
 =?utf-8?B?eWFBNjEwbXBEZFBsSGxCOVV6N2xmSDNtVTg1RmxPTjR0L2ZaVStHaFFYNnQx?=
 =?utf-8?B?c3VwdkdUWGIyTlMrMzZBUU1LRTRONXpON0UxMnF4bUxrcGJmejF2VzZ5SEh1?=
 =?utf-8?B?aldLZ1FzQlVjM282b3Aya0dYNG1xTnluTzVuK29YZnVaQmtaR0ZFOGFiQzEw?=
 =?utf-8?B?VlZKN0krRGdrT1VPdHF4YXFTb0FESzlmclhBdng3QmlWWm53U1Z3cll6L0VZ?=
 =?utf-8?B?NHptYXNCbmhIZG1LS1ppaDlZTHF0aXZTK3UxYm5id0ZyZ3hGS2tyRTdQQlZo?=
 =?utf-8?B?NnpKL2VvbnNndEJwSGUzRHBmeitTQ3ZvdjJOaVJkd016czdtV3ArcWVIbW9j?=
 =?utf-8?B?VG1TNDM2T3h6R3JHN2xTV3Rzb0xPTlA0S2xUMEYxdFhLN2tNdkxlVk5QVVd5?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FB5D7C8DD82894CB961FAF9A5295157@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iVrpOsLKG6B0ZadpjFBj9BudWLY2PNzpwKEIeaRyUnC4TiNFnmNxHXOMw9IaQCTmzGPfmmZvhoiuq8X9hHa7dc5/nip2WVARsEu/X67i3WYmYDe84HikcyEDSi2X6/0Ifpc1+uoQYBAJ3f1RmGvkuXNvZ6sIdHRUCDIpW2wcUEJsDzBhgQPcKMvRBASkdL6olm9GNRLHWSO/BCr2QPIShXHbxYC/j/XGCuY3tBKja4M+pXnFR/SeF4Aq3NIqkSClRu70YqV3ShCIeMSlCWMPczIQc3UpcvpjtVgd67gGWZbRdGpw5aXKmbWkgbC/fLGDN70K+A/zdHgxmWfYmv/fDbbEIS0Q33L34yBIF7xnkH4qau9y7hBCRDKbGPRhZ0mGMKgCJHvj8ZLSGyRhc9bcyo1FeCwi6p5y/vblxhc9ScMIq+gjVnlexOWVo9vke8SknyKXjIMP0if5ul9V4AMN6mNaqlOcWcpNYp1qE+/1WKjSzxSBiQo/9/lyeah9e5T71c1/d73Gfe2za528tFDJfpcCUUeUVFRRH4VMGGoGD4GEqpzt0elMdd3WjAAt3IELygQQa233I9+sBTlGwMGIzhvuCrfSNjaGqplLvNCqeXvvm9Pb11kJkfkwL+WZyub5EDAtZBi+CpOy3NpvnXSZyRSzZk/IFSp+c0K1h35c+HnkzjjMLsQTA+fhzW9vTg4eYT+4TUSpoTb1DKMo67avep946zHDXjMu5UAhr3m55gebMJj0WIoNo/x7Jr3Rb16TgXo7CChptL+U1Ug9BDGHwnNfiBxgBKeT+w+gziGnf4o=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598a22df-cc9e-4cbc-1bde-08dbbb4a2a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 08:59:00.9890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLMm7xTlUTdjdPSSI/085WMiYe83arXWYMEhdb6GzlAcsUy1RI3EksUvNYfMQ6LcGu9OZZEDHulAN7EHRUZDGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9763
Received-SPF: pass client-ip=68.232.151.214;
 envelope-from=lizhijian@fujitsu.com; helo=esa4.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBRSU9D
aGFubmVsQ2xhc3MgbWV0aG9kcyBxaW9fY2hhbm5lbF9yZG1hX3JlYWR2KCkgYW5kDQo+IHFpb19j
aGFubmVsX3JkbWFfd3JpdGV2KCkgdmlvbGF0ZSB0aGVpciBtZXRob2QgY29udHJhY3Qgd2hlbg0K
PiByZG1hLT5lcnJvcl9zdGF0ZSBpcyBub24temVybzoNCj4gDQo+IDEuIFRoZXkgcmV0dXJuIHdo
YXRldmVyIGlzIGluIHJkbWEtPmVycm9yX3N0YXRlIHRoZW4uICBPbmx5IC0xIHdpbGwgYmUNCj4g
ICAgIGZpbmUuICAtMiB3aWxsIGJlIG1pc2ludGVycHJldGVkIGFzICJ3b3VsZCBibG9jayIuICBB
bnl0aGluZyBsZXNzDQo+ICAgICB0aGFuIC0yIGlzbid0IGRlZmluZWQgaW4gdGhlIGNvbnRyYWN0
LiAgQSBwb3NpdGl2ZSB2YWx1ZSB3b3VsZCBiZQ0KPiAgICAgbWlzaW50ZXJwcmV0ZWQgYXMgc3Vj
Y2VzcywgYnV0IEkgYmVsaWV2ZSB0aGF0J3Mgbm90IGFjdHVhbGx5DQo+ICAgICBwb3NzaWJsZS4N
Cj4gDQo+IDIuIFRoZXkgbmVnbGVjdCB0byBzZXQgYW4gZXJyb3IgdGhlbi4gIElmIHNvbWV0aGlu
ZyB1cCB0aGUgY2FsbCBzdGFjaw0KPiAgICAgZGVyZWZlcmVuY2VzIHRoZSBlcnJvciB3aGVuIGZh
aWx1cmUgaXMgcmV0dXJuZWQsIGl0IHdpbGwgY3Jhc2guICBJZg0KPiAgICAgaXQgaWdub3JlcyB0
aGUgcmV0dXJuIHZhbHVlIGFuZCBjaGVja3MgdGhlIGVycm9yIGluc3RlYWQsIGl0IHdpbGwNCj4g
ICAgIG1pc3MgdGhlIGVycm9yLg0KPiANCj4gQ3JhcCBsaWtlIHRoaXMgaGFwcGVucyB3aGVuIHJl
dHVybiBzdGF0ZW1lbnRzIGhpZGUgaW4gbWFjcm9zLA0KPiBlc3BlY2lhbGx5IHdoZW4gdGhlaXIg
dXNlcyBhcmUgZmFyIGF3YXkgZnJvbSB0aGUgZGVmaW5pdGlvbi4NCj4gDQo+IEkgZWxlY3RlZCBu
b3QgdG8gaW52ZXN0aWdhdGUgaG93IGNhbGxlcnMgYXJlIGltcGFjdGVkLg0KPiANCj4gRXhwYW5k
IHRoZSB0d28gYmFkIG1hY3JvIHVzZXMsIHNvIHdlIGNhbiBzZXQgYW4gZXJyb3IgYW5kIHJldHVy
biAtMS4NCj4gVGhlIG5leHQgY29tbWl0IHdpbGwgdGhlbiBnZXQgcmlkIG9mIHRoZSBtYWNybyBh
bHRvZ2V0aGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJy
dUByZWRoYXQuY29tPg0KDQoNClJldmlld2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVq
aXRzdS5jb20+DQoNCg0KPiAtLS0NCj4gICBtaWdyYXRpb24vcmRtYS5jIHwgMTIgKysrKysrKysr
Ky0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3JkbWEuYyBiL21pZ3JhdGlvbi9yZG1hLmMN
Cj4gaW5kZXggMjE3M2NiMDc2Zi4uMzBlNmRmZjg3NSAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9u
L3JkbWEuYw0KPiArKysgYi9taWdyYXRpb24vcmRtYS5jDQo+IEBAIC0yNzYxLDcgKzI3NjEsMTEg
QEAgc3RhdGljIHNzaXplX3QgcWlvX2NoYW5uZWxfcmRtYV93cml0ZXYoUUlPQ2hhbm5lbCAqaW9j
LA0KPiAgICAgICAgICAgcmV0dXJuIC0xOw0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAgQ0hFQ0tf
RVJST1JfU1RBVEUoKTsNCj4gKyAgICBpZiAocmRtYS0+ZXJyb3Jfc3RhdGUpIHsNCj4gKyAgICAg
ICAgZXJyb3Jfc2V0ZyhlcnJwLA0KPiArICAgICAgICAgICAgICAgICAgICJSRE1BIGlzIGluIGFu
IGVycm9yIHN0YXRlIHdhaXRpbmcgbWlncmF0aW9uIHRvIGFib3J0ISIpOw0KPiArICAgICAgICBy
ZXR1cm4gLTE7DQo+ICsgICAgfQ0KPiAgIA0KPiAgICAgICAvKg0KPiAgICAgICAgKiBQdXNoIG91
dCBhbnkgd3JpdGVzIHRoYXQNCj4gQEAgLTI4NDcsNyArMjg1MSwxMSBAQCBzdGF0aWMgc3NpemVf
dCBxaW9fY2hhbm5lbF9yZG1hX3JlYWR2KFFJT0NoYW5uZWwgKmlvYywNCj4gICAgICAgICAgIHJl
dHVybiAtMTsNCj4gICAgICAgfQ0KPiAgIA0KPiAtICAgIENIRUNLX0VSUk9SX1NUQVRFKCk7DQo+
ICsgICAgaWYgKHJkbWEtPmVycm9yX3N0YXRlKSB7DQo+ICsgICAgICAgIGVycm9yX3NldGcoZXJy
cCwNCj4gKyAgICAgICAgICAgICAgICAgICAiUkRNQSBpcyBpbiBhbiBlcnJvciBzdGF0ZSB3YWl0
aW5nIG1pZ3JhdGlvbiB0byBhYm9ydCEiKTsNCj4gKyAgICAgICAgcmV0dXJuIC0xOw0KPiArICAg
IH0NCj4gICANCj4gICAgICAgZm9yIChpID0gMDsgaSA8IG5pb3Y7IGkrKykgew0KPiAgICAgICAg
ICAgc2l6ZV90IHdhbnQgPSBpb3ZbaV0uaW92X2xlbjs=

