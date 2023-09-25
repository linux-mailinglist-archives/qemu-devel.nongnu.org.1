Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BA27AD2AE
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 10:07:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkgbx-00082o-8o; Mon, 25 Sep 2023 04:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkgbs-00082V-3I
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 04:06:28 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkgbq-0001Ck-1j
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 04:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695629186; x=1727165186;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=StMWPg2eePPgLRrGtrB9eTFoZdp3HmSuVF78JvlWPyQ=;
 b=mJ7Pa0BLK2fE8q/x8JmnNnfh1zCMLMK3cd0lvh9hK9fspzZ0a8NMRxRL
 x0TkKrga1fwJnv0E6qkhbBj8G6PNAEWjMHn/nQFKHj9dQ1qtvHiK3MGc3
 mos6aJC2oDBP5Yp17bPo39ofXkw9e406FD/wXr4gIoDxNtJz9SkiJToue
 RZKQtMe3eVaDG4aU5lVmazuLCzxw7JDAKd0EO6FiUbT9Sy4C0vtys8Ztb
 Be0rUrdZjR/tgJLUoJaG11khF05MDfvzGb1RjtY4aNXRTmLZzxLN9pqJe
 yRaChy0GN21g5pftqAYNVI+PtZc6vrj52wQSBURuCN/OzKLJOMr4V3h7d A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96214764"
X-IronPort-AV: E=Sophos;i="6.03,174,1694703600"; d="scan'208";a="96214764"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 17:06:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDjdd2DXkFLfik36U2iQLFydqkQ1Fi3os42jr+91HK2KgIjOmc6OTYiqgag2Ojz7JBw71rrHmcreTTUuQfAjxDEJdNAQ0xCx13mC3tr+QEhOWZD5P2dsN7GaGsLCxVoqtJgUqUcPc1qaD9whlt6vH+NgeSH/cB0Uky7/xCQ/Y7jMVMMxBjGeJdWdiwwrKoMSBeIGDux/GIi4U3BQe/weILZFEhKm1AcWmT1p/3ei1QNUyHc1sR2bdP1aK3H8Ds4/zZiAy9bv9lsNjkQi/9OsXBkF08xy5nQo9kls6GkElwOT6VwNZfO+hV/NwU9fu5mi7QuR8pfBWl8arYJw6n/ydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StMWPg2eePPgLRrGtrB9eTFoZdp3HmSuVF78JvlWPyQ=;
 b=QIAn4Eb/n37K3NZHdZCw9MXGAFYzs/6AcqC3QCBDnLbOOakTWsmI1L1GymCOtczr8McfyGtd2deXkbW6X6Jd3zp74M+H8iagd85B/8FTJv5lZqmdIv6Hp7RDvjqcZhuMSrrfHWMnwbxYnNzRxs2n4pGN/hqYnILHMTBW0upKm2N73yJNyY2QyXJumhibQi/c6qv51xx0AT5hZW+LMmtcGipXrYMPJ83CaWc6h9dCW7qmtd8wri2Kyvo1Rd6rvV4vUoEHnLHPzBKFbPZd5Mp8LUvp6cmmo2Xld3lnJohmIWJprRB9XBljMzxc3TbXri9DaegieHQJYkM0lr2RnDRMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS3PR01MB9589.jpnprd01.prod.outlook.com (2603:1096:604:1ca::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:06:19 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:06:19 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Peter Xu <peterx@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "quintela@redhat.com" <quintela@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 00/52] migration/rdma: Error handling fixes
Thread-Topic: [PATCH 00/52] migration/rdma: Error handling fixes
Thread-Index: AQHZ6j6LFBwwrEIGtUePddDiST4w/rAiXhoAgAKYSwCAAgYiAIAEPU2A
Date: Mon, 25 Sep 2023 08:06:18 +0000
Message-ID: <f007a369-5f29-bfb1-0e28-14ad962ea7f0@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com> <ZQnRKjo0M50BRbZh@x1n>
 <9224534e-2f95-4c7f-a082-725dd5eb9cab@fujitsu.com>
 <ZQ2xDgV8pFQN7qBc@x1n>
In-Reply-To: <ZQ2xDgV8pFQN7qBc@x1n>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS3PR01MB9589:EE_
x-ms-office365-filtering-correlation-id: f26bc456-cbd3-4fd0-62a4-08dbbd9e4c91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /FjlP28vX/dpvlaqrD5pGeJ9QMdt4Y/c+oUccZrDLP6CP9+tlv3E60wVCQMzLd+CS2TU/YDxmHdZ56Q11xnD80Z1Z32LfokeDZofWWwlSMsncN3B8i/oM03Wp1vV3bwg0Pizq8+52qI7i19/kJYG8E1eWxMWrw+goSQNivNSJayh6OCKERVTIehCM1tkRWqEzwbdmK8LXC6pb6Vs5BqrGbzxA4eXXHaraFjEOjpI/A6OY+DC7jN8smsGjHy2T8l9jF7uubpYaDRcJzWCsUXgawHXdZ57RB+ztz9I+GE8dztoE3hIcQagFS8TBwG5r2h/+izauks3u+xCcNrFdUJVynJ+otyfCV6sQi9/rgn/kSODIu8RKwnRtpgp7uHw49XK7JVjxIX4hO6AqBABddOBhnmp9qKeUv2HAZ3AYisNXLIMExStSClrazogyRZlD9yeSkSmlVvdIn/BmZ1bnrSiHXH10eXCSnKzeyVwTgFme+sbcqjCd+W4miNlYpqBNayPq56APqPoAK5DkLgb46iIRsolfIlcirmcO59nI0+Wx9rhdCSTJlPABvjaS5DbfqSz3KtBOUz/ytZKQ7aFK8v+kIOysVo57BZSc8JHHqibVxJJjN4/1P13fXuR5kO7HXK4gKpSoftPvG9tYlSuuh7EOjmFsm4seI8C40EZFx7nOq4SJd5gJtCtKQ0QsZc7AkoME4ZaFAdT5KP3IGnFX4IEkA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(186009)(1800799009)(451199024)(1590799021)(2906002)(86362001)(1580799018)(38070700005)(6512007)(6506007)(5660300002)(85182001)(36756003)(53546011)(83380400001)(71200400001)(38100700002)(82960400001)(122000001)(478600001)(6486002)(8676002)(4326008)(8936002)(2616005)(41300700001)(26005)(31686004)(91956017)(76116006)(66446008)(66476007)(64756008)(66556008)(66946007)(31696002)(54906003)(6916009)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXUvWjFGZUxuRzlLZ3FBbkpFUGFyMjBJMVV2VnNpNlk5UnJoVDZoMGVFcTNl?=
 =?utf-8?B?VStMSUYySW5yak1UdmFwOEtZK1Rvbmp3MmZNWHo5WU9kVDkwRDdKdkduWENv?=
 =?utf-8?B?ZXQrWFdvUERhU3JsUDBtM0twbHFhd25ZSUg0d0VaTW9ja2l6TEo4ZmljdGR6?=
 =?utf-8?B?a2I0TzByTlR4SUtMNytiMG5GSCszN3FBS2FXZ1U1RFF3NVFyZGhXNUVZN2dh?=
 =?utf-8?B?Zzh0RTJ1TXVsMHUwUkUzT0RzL2NIRzRaZTdLTDZqL0gzbE0vUnB6a21OaUF3?=
 =?utf-8?B?OVo5STZSRzlwamZCN3AwU1ZtSXJXUjR4bDRLSWNvT3FYSHJWZXZPQTh6S1Q4?=
 =?utf-8?B?U3lpalZPcVhtMHRYZ2hzd0dGdGVFM3F5TWNQbTRESWxQb21YZGprcUUvbHBB?=
 =?utf-8?B?THFQVUZOcmQzdzQyTEhrdXdyeWVwcGpZZDVQYWhTdWRoZjljVDZWL1NVbmNx?=
 =?utf-8?B?ZXE1WTJFLzh5WmgzVS9WRXpKQnVxTGhiVlUrdVJtcy9BYUlhTWh2cDBPYnM0?=
 =?utf-8?B?ZmVxQTNKRUdoTlNJMkt4UjFPYXQxYmlzMHNOVlNFbWRvdmZESE9nY1NhMUh3?=
 =?utf-8?B?aVJ3VHBIaXhCQ3JwZTZoYVVYM1Vhb0lUYnMva2FIMVkvc0RnNTRjWVh1WW13?=
 =?utf-8?B?M1ZRckZYdk96TWZTek92SUt6M1FUa2VCOU5LdjNaT2FwTUFZbFhveUtpSUpZ?=
 =?utf-8?B?dlRNK29VMlljNEdnWEVJSHVKbGZMamgxbE15N3F5MUluWDNvMk1Jck56dk9G?=
 =?utf-8?B?Q2lQM1c2TlByVXdXQkJRQkFmY1BCU0dIYW5ueWZXcmNjOVVvZWpqNUJoYjFv?=
 =?utf-8?B?YlQyOE1xdisycXFUNDZtM0c1NURrTzdyOVBYdjRnN0FUazhEdjJTN1Q4M3Jl?=
 =?utf-8?B?V3p3ZGJ3aytwbitPNFhEcTJVNzRoemgrV2lSUGdENHl5YnRIYnIvN0V6MFhl?=
 =?utf-8?B?OE5Dc2dxcVZ5SHByak5jSm5laWdReFY5NVc1anRLakJRaUNYWUJ0ckNDbk1p?=
 =?utf-8?B?Z2VPVVQ4RTFOdVo0aTJ4a2x5RForOXFMQ2NHWW9vRHZPclZLT0VpVVJwcjEv?=
 =?utf-8?B?aU5ldFRsOGpBd1hFSmR2YzV0U0dNd1MyenFKdVRKNFVlUlNHbVpJSXNwMjNQ?=
 =?utf-8?B?SXBTQ3BzTmc4dUMrdGk5dmUvR0hYRERidVJpWFVQT3NHR0RjZUk2VEF4MUJT?=
 =?utf-8?B?dVN2b0FwbnVtc0dxbHd4d1dOcjAxVGRGQithWm5lbi9lRXFvZU01R3p1WlpX?=
 =?utf-8?B?NjVCM1lrTnlGQmtTV09HWWZFbHdLM1BZKzI1YnpTTkVkcW85VTJYdGtaNjhW?=
 =?utf-8?B?L2dOSElrV3E5a2lTeW9xb1JtZUtJTW9ja3BzTDlKR1FmZy9QdWFMaURVL2cy?=
 =?utf-8?B?R0dzMEtZS2RHcEJicjdwUU9kaCtwYlVPRlY0ZldoVnNCVGR6Q01rbDU2WjBn?=
 =?utf-8?B?ZVhDZnNaR0dTZXpHSkZIdG1KR0p2Q01QUWt1aGgyenhXSEJTVnFoenJLRmVs?=
 =?utf-8?B?TWJRWi9uOUE1eG9TcnIwMlkxRHNQRXpNWnlyUjNFVmthQXBpMlhyTTdtaW1n?=
 =?utf-8?B?YXVDV1c1UU1IaVZxcHFLUXgvWEUwRkdwNVFFU1E0VzRoYTFWUjhSbnB3bWN1?=
 =?utf-8?B?L1FBelJUUnkycUZZcVl0ejNOUG5OOHNyK3F4SGtyUVhmODBrVkJMK3lyTHZM?=
 =?utf-8?B?N0xLcnVFTFVQYzF4RjUybEY5T2N6Uks0d29aM2UyZnRZUmhGVUhtM3VhV3RY?=
 =?utf-8?B?c1lVNEZkZGU2bkw1dy9oeFE3ZUVpRTRQRmFNS3cvSWxqazA4YzVFK3pFVHMx?=
 =?utf-8?B?eEZNaGxQUExmOTQ1OEVLOWpZN1IzSHZZaFYwUFNOcmtNZ1A1d05HUWh4NjNP?=
 =?utf-8?B?bFhWa0thMWVwNGxtN1hnWWdBTmhoMk1DeFNGcVpSc25PMm45M2pPWVp0bWpj?=
 =?utf-8?B?anBWeE9NUDRrZHVhU1oyNXZNT3ZuVU02WmRCeHBkcVd2K0JuVmZqb0NESGhr?=
 =?utf-8?B?V1NGSE9UaDNVZWhQSEVCbDRUbDIvWEw0N1ZhT2JwQndKYnZQVzg0TVhmOTky?=
 =?utf-8?B?dEFpUHdpMjFiTTJ3dHVmd1lqZ3RSNE43MTJWSFVTZ2VhTmFydllTKzNJc0Fq?=
 =?utf-8?B?cUU3clMxdmoyWW9mQ3pwbjlNaDRSVkh6UENJYUZ6Q29NN2hGK3RiVTc2VG9C?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <260E86C13990A547ACAE355AD80BACAF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wHV2l5lpiKNA7V6MSURgWL6bnhHJclk8mSE5Cykd47C/y8Jn4si02bO+vMxiJRWk7KRLauMxnbutyKndZAIHZeCWNOwF5lLIZ30KWrTThDumbUUwQBjhp5dTA2cxuNjTP7SGR43TPe5azazIF4pvZNHZUyprz0/sRDVfBIbrostQUuyq3iZahCeg+u+9GpIBpYlVvV2jyMGtKu5rZBOcClLXRkNqnTYWllq7udXbSjFJVj0OF2hdmTIO4Ihkg4CEkw5krR8QX1lzuKAdGRNvEOCNMaEeussg2Qj63K7gyE78h/lmapvBaa1GcGcHGdf3mT/yVfzr8yO2n6FCYygfFDOuQSrbWRWUL25ykhvkRxAMUglU2sOcSGOoYnoAkkGXyNSQKBL2ZRbDbzuIb+rdpEmu4bHxawjDzxDQBTQl5sRgHyVhZVlKNJgse8luwhEUsmOle7FoqAilaBcvmEaY91URcLuBxP5Nsgtvh8Jt1RKuN/D47qB0/lUGbWAOEjcBICgp3ZMQcPmUDFn1kqADUwom/5YwkFqYrC+ju58g9xt4+dbu9x3haDO0uulaBfylKKGRUwLmYa+zAFNRO1FpLkX49+7PO2SHjKIADsk3iBK0ZltXMGn+c3cj6BSxL4xuL6BXXRkVagQqWJ22XE8u6m1Nv2JgdSEXX0kh/oXueZ8z/89Ido+QSUsdHeE/Hhf+7zgzfO/aHsICswttWsNwK9D/gHVSXPf3MdoBh8K+qGYBm69SkAI+iVr/NWb4awcICgpLwwPiGkBP2w9+CaJJ1JhB3afxwdTUl81cTtr4QKQ=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f26bc456-cbd3-4fd0-62a4-08dbbd9e4c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 08:06:19.0127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: omK3l0jXLZfU3Yuo1U0N2q5/T7BvJzo9VUMJ40STbvAAMo8yfBlhDnf/9y3Qv+RldbhyuQPL8w1RXEb4o8nadw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9589
Received-SPF: pass client-ip=68.232.156.96; envelope-from=lizhijian@fujitsu.com;
 helo=esa13.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDIyLzA5LzIwMjMgMjM6MjEsIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBUaHUsIFNlcCAy
MSwgMjAyMyBhdCAwODoyNzoyNEFNICswMDAwLCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToN
Cj4+IEknbSB3b3JyaWVkIHRoYXQgSSBtYXkgbm90IGhhdmUgZW5vdWdoIHRpbWUsIGFiaWxpdHks
IG9yIGVudmlyb25tZW50IHRvIHJldmlldy90ZXN0DQo+PiB0aGUgUkRNQSBwYXRjaGVzLiBidXQg
Zm9yIHRoaXMgcGF0Y2ggc2V0LCBpIHdpbGwgdGFrZSBhIGxvb2sgbGF0ZXIuDQo+IA0KPiBUaGF0
J2xsIGJlIGhlbHBmdWwsIHRoYW5rcyENCj4gDQo+IFNvIGl0IHNlZW1zIG1heWJlIGF0IGxlYXN0
IHdlIHNob3VsZCBoYXZlIGFuIGVudHJ5IGZvciByZG1hIG1pZ3JhdGlvbiB0bw0KPiByZWZsZWN0
IHRoZSBzdGF0ZSBvZiB0aGUgY29kZSB0aGVyZS4gIEFGQUlVIHdlIGRvbid0IHN0cmljdGx5IG5l
ZWQgYQ0KPiBtYWludGFpbmVyIGZvciB0aGUgZW50cmllczsgYW4gZW1wdHkgZW50cnkgc2hvdWxk
IHN1ZmZpY2UsIHdoaWNoIEkgY2FuDQo+IHByZXBhcmUgYSBwYXRjaCBmb3IgaXQ6DQo+IA0KPiBS
RE1BIE1pZ3JhdGlvbg0KPiBTOiBPZGQgRml4ZXMNCj4gRjogbWlncmF0aW9uL3JkbWEqDQo+IA0K
PiBaaGlqaWFuLCBpZiB5b3Ugc3RpbGwgd2FudCB0byBnZXQgZW1haWxzIHdoZW4gc29tZW9uZSBj
aGFuZ2VzIHRoZSBjb2RlLA0KPiBtYXliZSB5b3Ugc3RpbGwgd2FudGVkIGJlIGxpc3RlZCBhcyBh
IHJldmlld2VyIChldmVuIGlmIG5vdCBhIG1haW50YWluZXIpPw0KPiBTbyB0aGF0IHlvdSBkb24n
dCBuZWNlc3NhcmlseSBuZWVkIHRvIHJldmlldyBldmVyeSB0aW1lLCBidXQganVzdCBpbiBjYXNl
DQo+IHlvdSBzdGlsbCB3YW50IHRvIGdldCBub3RpZmllZCB3aGVuZXZlciBzb21lb25lIGNoYW5n
ZXMgaXQsIHRoYXQgbWVhbnMgb25lDQo+IGxpbmUgYWRkZWQgb250byBhYm92ZToNCj4gDQo+IFI6
IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4gDQo+IERvIHlvdSBwcmVmZXIg
bWUgdG8gYWRkIHRoYXQgUjogZm9yIHlvdSB3aGVuIEkgc2VuZCB0aGUgbWFpbnRhaW5lciBmaWxl
DQo+IHVwZGF0ZT8NCg0KWWVzLCB0aGFua3MuIG15IHBsZWFzdXJlIDopDQoNCg0KDQo+IA0KPiBJ
J20gY3VyaW91cyB3aGV0aGVyIEZ1aml0c3UgaXMgdXNpbmcgdGhpcyBjb2RlIGluIHByb2R1Y3Rp
b24sIGlmIHNvIGl0J2xsDQo+IGJlIGdyZWF0IGlmIHlvdSBjYW4gYmUgc3VwcG9ydGVkIGFzLA0K
DQpUaGlzIGRlcGVuZHMgb24gRnVqaXRzdSdzIGN1c3RvbWVyIHJlcXVpcmVtZW50cywgSSBkb24n
dCByZWFsbHkga25vdyBlaXRoZXIgOikNCg0KDQpUaGFua3MNClpoaWppYW4NCg0KICBwZXJoYXBz
IHBhcnQgb2YsIHlvdXIgam9iIHRvIG1haW50YWluDQo+IHRoZSByZG1hIGNvZGUuICBCdXQgbWF5
YmUgdGhhdCdzIG5vdCB0aGUgY2FzZS4+IA0KPiBJbiBhbGwgY2FzZXMsIHRoYW5rcyBhIGxvdCBm
b3IgdGhlIGhlbHBzIGFscmVhZHkuDQo+IA==

