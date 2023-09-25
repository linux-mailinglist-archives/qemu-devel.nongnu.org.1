Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F957AD108
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 09:04:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkfdC-0001QU-In; Mon, 25 Sep 2023 03:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkfd8-0001Om-Ca
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 03:03:42 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkfd3-0005JO-Tq
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 03:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695625417; x=1727161417;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=j6TlHyqq3JawuS7sKSctU3sZw/tiLYttrWFNUoF57Tw=;
 b=iGYhHYbdlbcQe+XcIntvAblWai8H26fjEkvFtWvMrLjzi6Ikc55jw7eU
 5Eyfac33aZfedHp/s9bmlM4aY1i3aWrZ1GieWkkLfQCl3yQ8ZTrB+B6oG
 4SXAfRvKVDrL12OAsu42YRTJqox6TiGACgZjyhqlgzWcd85Q26p1/bwX/
 xc8q5VY7vlm+G7OnyGwz5Hel8dloPUXul26k6MmXt8IK0JIEuz5gyi2XC
 FJoOY+ksbBAdnuEEddYfTP173lx7aEMLTqCSH09GSrwmOHyL95KSvPSd7
 F6hFOUILkArGkemaLYbwyiDAqf8vc9nWJDG+fgV34HVD57k35ah5lidZS g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="7669423"
X-IronPort-AV: E=Sophos;i="6.03,174,1694703600"; 
   d="scan'208";a="7669423"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 16:03:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvPfjkyU7DGREfC+zzvIsja+KqdXNF/A5VlV87wKl3sHOccpA1dsLQeXcaCtCvVpCExHnUCmHTEpxYGTbn9noCOIYclCsVbU5QmEvJTR31m4FFZcsXrlB1j+XXfW2T+yg5hHHd1EN6DhQ1lGznVFiXdmI11rW0ymAw0kLfw2emEqpSv5H0ecZeHhnGT19gtLkBGZm5sSKflu/juAAKyWJdhhQtEeMok65I+et3OmbEEVUu6QtEvxkOI/Dg0v3cOQEqJI5LXgw3zi+PEeXM0YXu85epOKTHNjOzhwknptjgnNifgOoSCpG8uz0dtPnaX9tE8fWRkN6iWSZPPOpCOOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6TlHyqq3JawuS7sKSctU3sZw/tiLYttrWFNUoF57Tw=;
 b=DEaCbAIZEhsipoPXPtD0CcGPQu1/eqN8cRexLT716XMT/uIEya/iFk0XKUWklQtvR4PJ2+WCdvTAXUF+L2YAXI5q2c32xAcu/PJmHbSnkdEoMkqNVv9xtujtmzR74eHSqsF3dlSEUPT2rlTdzYuYZkKUQ6GOMdG0dovFlaTMA6zdr30bkNeaSktKRQfjCWWvLbh/hjAnmJFoBk2KHn3KZm2cbpVZFi+lE1XBgKmNHKKfgoqKcdySfpEzOAvQ9x09c4wi/S/Un0VMhGdRCd4pBJV52PXT2WlKXyBZGUL1HXipwj79QCrWuj2dpvWEhDnkqR21ZBU/aj5nDkF/gfjZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TY3PR01MB11906.jpnprd01.prod.outlook.com (2603:1096:400:409::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 07:03:30 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 07:03:30 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "quintela@redhat.com"
 <quintela@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 21/52] migration/rdma: Fix QEMUFileHooks method return
 values
Thread-Topic: [PATCH 21/52] migration/rdma: Fix QEMUFileHooks method return
 values
Thread-Index: AQHZ6j+aVAvBH2UWIkaKLi0YdQZHdbAq92iAgAApV3eAAAeHgA==
Date: Mon, 25 Sep 2023 07:03:30 +0000
Message-ID: <99b991ac-2bb6-3276-0405-d4de524131f3@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-22-armbru@redhat.com>
 <742d57f9-7660-b40c-10fd-c81365b161b8@fujitsu.com>
 <87edimg3oj.fsf@pond.sub.org>
In-Reply-To: <87edimg3oj.fsf@pond.sub.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TY3PR01MB11906:EE_
x-ms-office365-filtering-correlation-id: 96297d20-b9e4-4ef1-36b4-08dbbd958623
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X1lDmZTX3Thl04czcf/JMLmGj/s7rg8zc4FJOssyBlLQlgtJO8ckAmjngl1s9r5CxA/Z73UC/mvyvcSZCN3rYnRSyHrAMscM7w2skwO9ZxyMDCN3IgUSeSWUQLfWzTR45Tvt4UR3ssrOyLVW02PwrVC0dxyySGipj+jePBrDmnQXEpzlnNYZAuZCfNLyPYSl819C7oyzTiNftZ1PvFPkWLTPnN5HMp6f7/1bJAl5Ci/7vBLTsWm9/gAu7M1L6yjR2rZGrTyUJ7pzOmkdgXfTDQll9ZITY9y9A9E2t1kcKxyOcvupEqO0ow7TKzMfit6fLfiK44SMCGAdPQKVw2Ue7l7EAD8P6f9Mh8I56Qyvkt5eVaIYwPjhU2q+EE/gGFrTPLpp4c/d2uQWne0B3f2+xDkCVDR2zNyCaX11xlvo0WUfpTuzte4sY5c7+BcJ8x1T12/23yBCAExHpT8CfUoXu/eh7i7h2Fj8C7B37zH5Sv4KoR4USq7zOD8fZ27JEiRlbSWhgFp41I4m2pRSZWmAurCImtejgRi8tzX4Kqhi0NH57AthPqZjj4Gbf/GrOirmWHI0N7scPuxOrCAk2u8udvcnFqIMAAGYuZ6ZhT1nhuHuBTdEuCxObTmeJSAM0DmxvvsosnS2RSBoTK2VJHB5HcDl7gJfZ7Z4DGmaWt0t4ecywVuh06tJ2FLi0GffWA5h8tXRDBQqv+hCL0vnCYvtXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(1800799009)(186009)(451199024)(1590799021)(1580799018)(83380400001)(26005)(8936002)(8676002)(4326008)(316002)(478600001)(66476007)(41300700001)(66556008)(66446008)(64756008)(54906003)(6916009)(66946007)(91956017)(76116006)(6512007)(5660300002)(53546011)(2616005)(2906002)(6486002)(6506007)(71200400001)(31696002)(86362001)(85182001)(36756003)(82960400001)(38070700005)(38100700002)(122000001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXZtM2pMaDZVMmFjeUp1Z1oyWHlvSFlFam1sdVc4Y0RramEreWtOVTd5cmpn?=
 =?utf-8?B?TkY2emptdW1lWSs4UWd0TnpTa2RCb21YZkhxKzh1dVpNYVVuaDdrcGtOLzhh?=
 =?utf-8?B?U3dEWVEvTzNTdGZFT2xiTUZmNTc3UVllS0h0K3N3eUM2bGNZT2hieVFqQncz?=
 =?utf-8?B?M1VpSDZ4c1lwREx6Rk51czRRSmFnM2FlQjRrOWNWYmd1OUdLS0wrWXl3TnFQ?=
 =?utf-8?B?UmVLQlY2R1VyMmdkS3pVMHJ2MkxqOFJ6YmNWenFzRkp6T0VFZmppWXl1NlZi?=
 =?utf-8?B?b0VSTnpyK3BHa1NqMDAzU1Bxc3Fia2x2amdaWDFwb3RjWmxtbkhRVnRNc0Nx?=
 =?utf-8?B?UnFjcjUrQ2w0MDhhMU5DLzh1VXFrMEJ1Wk41TDI0OW9qUVgzUVNvaXBKd2pY?=
 =?utf-8?B?ZFhWOTlOQ28xdXFoWExDc2xVVTgxazVBN1JyQlNkWGhyQ1hrRHRmMVVveUlp?=
 =?utf-8?B?akNtb0ZiK1hmQVhXcW10eklKWFZPbXgvQlcvZUg0Z0MxY2xsMGpWSjJKbFl1?=
 =?utf-8?B?cFl2b1pBdmRqdnRzUmdHT3FsRUFURnV1VUNHNjlLZlRvVlVyVkUzbkFYRnNS?=
 =?utf-8?B?a1JRVml3WWs5ZXFHTjJmdW5NTWxoR1lGdCtEYWFJN29kTXoyOWN5YWxSMVBO?=
 =?utf-8?B?VEw0S2JEWWNIMlJkZ242Qmg0M2NZQ0lFVmI1VGg0aXVxQmR5OUJKa0NYT1Qv?=
 =?utf-8?B?eTUxMlB2dWJSYk5MK3dYQUpGVGVsY3d0TmZzbGhQbVppNmpyRWVCSWpkQVJE?=
 =?utf-8?B?d3QwVVZWNmsxTHhmSThKMWZCam5SOXM0cDJEKzUvNTVTUHN3Umt0d2ozUk45?=
 =?utf-8?B?c1ZwNXFWSVhOYzdEb0xxWkRSRzI1eWI0QkM1dnMxNlkrbERiTEFDR0hMQzJp?=
 =?utf-8?B?RDZXTVpzNWRSamRsZXFnU3BrOUdnTXpOc3RqeFlnZDB2aUFYaHh6b1J4Nzh0?=
 =?utf-8?B?Wms1c1lXNnBuR0dlUXpaTzZoazNYWWhNQXlPYVdGMjJDTm9MclE5bVA4M3J5?=
 =?utf-8?B?VVV5WThlRktWNVBndWswRlZJMzBXVkRDcjdKWHhEanhGL3BKaTdQRE1pYkk5?=
 =?utf-8?B?bmRET0xYVDQ0ZWlNcEJleHBaOHVBVTlibWNxS1BPME1ld1ZQSVlCMy9wZjNP?=
 =?utf-8?B?Q1pQK2dJUEt0anMvZEczNFdHQUh3RmhGYm1hWlZhUy85NE0yKzgweHlXZUZO?=
 =?utf-8?B?OGhnVzdRZ2tiemJsYkFFL0lmREQ2QkNEeUdlRUVPYm9BL1BoVStWbXYvekhz?=
 =?utf-8?B?dFZLUEEzbUd1NDlQeFNsZk56VWtIVTdhOUZ3UmlkSFR3aXcxK1g0aU40Q3Ur?=
 =?utf-8?B?MXlKbU96dUthZ0JGLzd3RHhaM204dVZPSmZubmh5YW51Q3RMOGVQYXhtLzVD?=
 =?utf-8?B?czhqbXpPTUdQcFNncDRodTQ0TlM3bEtoeEFWd2xLbFBIMzVpTkxMdnczWDhF?=
 =?utf-8?B?Zmc3aHh1Z0s0cFRpSVkzQlV6NkpQcHF4MkRpTlF2SHk0KzkwYTVCbm1qdmp2?=
 =?utf-8?B?Y3pXeTdVY29ldHo4cEVwazVXM0wyc2dkamh1bjUrcm04aHltakRwK2JUdHNu?=
 =?utf-8?B?TTdnL28xTFd3L2JhSnVGQ2grYU1FT2k4cnFQT2ZlUlNlUHA1TjRJbTRncDc2?=
 =?utf-8?B?L3NFOXRTOWd0bTNSbmJ5aVBWTDhQZnVxL05mTmRueTQwcE04RmgzUHovdlFO?=
 =?utf-8?B?eURRWU04N0xxK0ZpdExqWDFSWDVZVTNCZlZTZVppODZFa0pITzRjRWFJTlla?=
 =?utf-8?B?ZU0xNTZmK05rNlhUeFNlZFI5bWVxd2xiZi9sZmdNR0RSakdjOEthNXF6QVk3?=
 =?utf-8?B?VnhINElpSGEvS1hBQWFPTHZPN2crRGdnVzZ3ZXhKd0J2QS9ZaHNqREJrK3JB?=
 =?utf-8?B?dGkxbEVHN1ZrOVdReGxMN0VkS0xRaWg3eDZVV3kyY1RoQmN4bFVlSjU0eFQr?=
 =?utf-8?B?NkxwL0dLVU14cGI5akRmTExHQnJsK1pSYkdISUJIbTJBbEFYV3UvVFRpQ2Ni?=
 =?utf-8?B?Z08vNWZFWnUzWDRJMlQ3cTI4VEUyOEJwRkpWRlAxOFJNdXNqeDRCLzZtZHAy?=
 =?utf-8?B?N2lVKzBlR2V6bW4rc0NoZTV6b1ZRb0NJdzYxdUhzUC8vTG4wRHJFVm1CYldq?=
 =?utf-8?B?eGRvOTBDZGoreGl4VVIvVDlTcW50Z0tqNkZNNExOSGs4eFRHWFVLUHZzbjdT?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0827FB5556C054689F434E65EBD0361@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ff7ou3KKWvDzsBQUUrOlOuciOI0D7ejt2ufRnJUUzthk5gjE8Rgd5bJvDdytzeOp/b/cv/Crh12HhgDPA9nkZsyXau0DEpa4jhwOZRYhViVRBmmbRtnPpT/tvWZYWI7CksD1bRyu6dV9Yt+1Dt143SeR5D5ciYBdVDqPKkAwWMVm9e0ZS9vXY33vM0je+8H2RK9/sJFxTzcbhjkwMx2rKN1OUpwGP5tPNFXo0TmBIUB7IlpspTtOJrhoekEFELJhoTdVNJm45hWd3mDyzGgCtYso7Wc32ygQakyyjdEtvx3+KYdhyp2kHLtVKu5uDEDF7ii6icX2yYrDxfrdU/9Seeme9aPkjloF6kvOZ2dSXL39vh5XFAniE4cVE59ZILWuhzRUkBVwX26BzMwcZ5kgPoxwxZPBWnAP/qY3Xo4o5GH5FBq0Aa05/lsZibBSUz8YAxWMM8Xw6uMisT5MJ1g1s73OFQRZrMA8L3mHJyl9N2kGf0Jz/k0SeqmVUJR5ZEgqP73cXyewba/9fPgBCFQyluGquAGNazY8T1dvk+7kkFZ1wCZlA0MszJfWMX5MtYNcl2KX7QJTOqtFYfQUPuHlqCXmaR0nxQyM+pj1Lk8pGM2e+CJebSQ6TOB0eK6/kIjG+8vKY1lDXqNygsdq6X/lNPJuWbw59si3ose5wEa3Cm72hXAqySZWF7jYg8ZsDHyr8/6xKGGYoPbItixA67ue2cyjNbxzPMlDK6RvVh1VWDbEu9EoxVJTTWgb2zQCHCSTZR+N6T9xx2Cjn092IOTvJXgW3P7RGie1MH7LkfHxLqU=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96297d20-b9e4-4ef1-36b4-08dbbd958623
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 07:03:30.1235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuPlVx1gqlnvJnqGHuwDZqpdMqBYav+8tfv92aV8+QZ7NiApIv6N0olvBmlPRMl/UVxvmBiNhR5Mx0C4aIlIEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11906
Received-SPF: pass client-ip=68.232.151.212;
 envelope-from=lizhijian@fujitsu.com; helo=esa3.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDI1LzA5LzIwMjMgMTQ6MzYsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiAiWmhp
amlhbiBMaSAoRnVqaXRzdSkiIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IHdyaXRlczoNCj4gDQo+
PiBPbiAxOC8wOS8yMDIzIDIyOjQxLCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4+PiBUaGUg
UUVNVUZpbGVIb29rcyBtZXRob2RzIGRvbid0IGNvbWUgd2l0aCBhIHdyaXR0ZW4gY29udHJhY3Qu
ICBEaWdnaW5nDQo+Pj4gdGhyb3VnaCB0aGUgY29kZSBjYWxsaW5nIHRoZW0sIHdlIGZpbmQ6DQo+
Pj4NCj4+PiAqIHNhdmVfcGFnZSgpOg0KPj4NCj4+IEknbSBmaW5lIHdpdGggdGhpcw0KPj4NCj4+
Pg0KPj4+ICAgICBOZWdhdGl2ZSB2YWx1ZXMgUkFNX1NBVkVfQ09OVFJPTF9ERUxBWUVEIGFuZA0K
Pj4+ICAgICBSQU1fU0FWRV9DT05UUk9MX05PVF9TVVBQIGFyZSBzcGVjaWFsLiAgQW55IG90aGVy
IG5lZ2F0aXZlIHZhbHVlIGlzDQo+Pj4gICAgIGFuIHVuc3BlY2lmaWVkIGVycm9yLg0KPj4+DQo+
Pj4gICAgIHFlbXVfcmRtYV9zYXZlX3BhZ2UoKSByZXR1cm5zIC1FSU8gb3IgcmRtYS0+ZXJyb3Jf
c3RhdGUgb24gZXJyb3IuICBJDQo+Pj4gICAgIGJlbGlldmUgdGhlIGxhdHRlciBpcyBhbHdheXMg
bmVnYXRpdmUuICBOb3RoaW5nIHN0b3BzIGVpdGhlciBvZiB0aGVtDQo+Pj4gICAgIHRvIGNsYXNo
IHdpdGggdGhlIHNwZWNpYWwgdmFsdWVzLCB0aG91Z2guICBGZWVscyB1bmxpa2VseSwgYnV0IGZp
eA0KPj4+ICAgICBpdCBhbnl3YXkgdG8gcmV0dXJuIG9ubHkgdGhlIHNwZWNpYWwgdmFsdWVzIGFu
ZCAtMS4NCj4+Pg0KPj4+ICogYmVmb3JlX3JhbV9pdGVyYXRlKCksIGJlZm9yZV9yYW1faXRlcmF0
ZSgpOg0KPj4NCj4+IGVycm9yIGNvZGUgcmV0dXJuZWQgYnkgYmVmb3JlX3JhbV9pdGVyYXRlKCkg
YW5kIGJlZm9yZV9yYW1faXRlcmF0ZSgpIHdpbGwgYmUNCj4+IGFzc2lnbmVkIHRvIFFFTVVGaWxl
IGZvciB1cHBlciBsYXllci4NCj4+IEJ1dCBpdCBzZWVtcyB0aGF0IG5vIGNhbGxlcnMgdGFrZSBj
YXJlIGFib3V0IHRoZSBlcnJvciA/ICBTaG91bGRuJ3QgbGV0IHRoZSBjYWxsZXJzDQo+PiB0byBj
aGVjayB0aGUgZXJyb3IgaW5zdGVhZCA/DQo+IA0KPiBUaGUgZXJyb3IgdmFsdWVzIHJldHVybmVk
IGJ5IHFlbXVfcmRtYV9yZWdpc3RyYXRpb25fc3RhcnQoKSBhbmQNCj4gcWVtdV9yZG1hX3JlZ2lz
dHJhdGlvbl9zdG9wKCkgY2Fycnkgbm8gYWRkaXRpb25hbCBpbmZvcm1hdGlvbiBhIGNhbGxlcg0K
PiBjb3VsZCBjaGVjay4NCg0KDQpJIHRoaW5rIHFlbXVfZmlsZV9nZXRfZXJyb3IoZikgY2FuIGJl
IHVzZWQgZm9yIGNhbGxlcnMgdG8gY2hlY2sgdGhlIGVycm9yIGNvZGUuDQoNCg0KDQo+IA0KPiBC
b3RoIHJldHVybiBlaXRoZXIgLUVJTyBvciByZG1hLT5lcnJvcl9zdGF0ZSBvbiBlcnJvci4gIFRo
ZSBsYXR0ZXIgaXMNCj4gKm5vdCogYSBuZWdhdGl2ZSBlcnJubyBjb2RlLiAgRXZpZGVuY2U6IHFp
b19jaGFubmVsX3JkbWFfc2h1dGRvd24oKQ0KPiBhc3NpZ25zIC0xLCBxZW11X3JkbWFfYmxvY2tf
Zm9yX3dyaWQoKSBhc3NpZ25zIHRoZSBlcnJvciB2YWx1ZSBvZg0KPiBxZW11X3JkbWFfcG9sbCgp
LCB3aGljaCBjYW4gYmUgdGhlIGVycm9yIHZhbHVlIG9mIGlidl9wb2xsX2NxKCksIHdoaWNoDQo+
IGlzIGFuIHVuc3BlY2lmaWVkIG5lZ2F0aXZlIHZhbHVlLCAuLi4NCj4gDQp5b3UgYXJlIHJpZ2h0
Lg0KDQoNCj4gSSBkZWNpZGVkIG5vdCB0byBpbnZlc3RpZ2F0ZSB3aGF0IHFlbXUtZmlsZS5jIGRv
ZXMgd2l0aCB0aGUgZXJyb3IgdmFsdWVzDQo+IGFmdGVyIG9uZSBxdWljayBnbGFuY2UgYXQgdGhl
IGNvZGUuICBJdCdzIGNvbmZ1c2luZywgYW5kIHF1aXRlIHBvc3NpYmx5DQo+IGNvbmZ1c2VkLiAg
QnV0IEknbSBhbHJlYWR5IGF0IDUwKyBwYXRjaGVzLCBhbmQgYW0gbmVpdGhlciBpbmNsaW5lZCBu
b3INCj4gYWJsZSB0byB0YWtlIG9uIG1vcmUgbWlncmF0aW9uIGNsZWFudXAgYXQgdGhpcyB0aW1l
Lg0KDQpZZWFoLCBpdCdzIGFscmVhZHkgYmlnIGVub3VnaCBwYXRjaCBzZXQuDQoNCnZlcnkgdGhh
bmtzDQoNClJldmlld2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoN
Cg0KPiANCj4+PiAgICAgTmVnYXRpdmUgdmFsdWUgbWVhbnMgZXJyb3IuICBxZW11X3JkbWFfcmVn
aXN0cmF0aW9uX3N0YXJ0KCkgYW5kDQo+Pj4gICAgIHFlbXVfcmRtYV9yZWdpc3RyYXRpb25fc3Rv
cCgpIGNvbXBseSBhcyBmYXIgYXMgSSBjYW4gdGVsbC4gIE1ha2UNCj4+PiAgICAgdGhlbSBjb21w
bHkgKm9idmlvdXNseSosIGJ5IHJldHVybmluZyAtMSBvbiBlcnJvci4NCj4+Pg0KPj4+ICogaG9v
a19yYW1fbG9hZDoNCj4+Pg0KPj4+ICAgICBOZWdhdGl2ZSB2YWx1ZSBtZWFucyBlcnJvci4gIHJk
bWFfbG9hZF9ob29rKCkgYWxyZWFkeSByZXR1cm5zIC0xIG9uDQo+Pj4gICAgIGVycm9yLiAgTGVh
dmUgaXQgYWxvbmUuDQo+Pg0KPj4gc2VlIGlubGluZSByZXBseSBiZWxvdywNCj4+DQo+Pj4NCj4+
PiBTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQo+
Pj4gLS0tDQo+Pj4gICAgbWlncmF0aW9uL3JkbWEuYyB8IDc5ICsrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAzNyBp
bnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9taWdy
YXRpb24vcmRtYS5jIGIvbWlncmF0aW9uL3JkbWEuYw0KPj4+IGluZGV4IGNjNTkxNTVhNTAuLjQ2
YjU4NTkyNjggMTAwNjQ0DQo+Pj4gLS0tIGEvbWlncmF0aW9uL3JkbWEuYw0KPj4+ICsrKyBiL21p
Z3JhdGlvbi9yZG1hLmMNCj4+PiBAQCAtMzIxOSwxMiArMzIxOSwxMSBAQCBzdGF0aWMgc2l6ZV90
IHFlbXVfcmRtYV9zYXZlX3BhZ2UoUUVNVUZpbGUgKmYsDQo+Pj4gICAgICAgIHJkbWEgPSBxYXRv
bWljX3JjdV9yZWFkKCZyaW9jLT5yZG1hb3V0KTsNCj4+PiAgICANCj4+PiAgICAgICAgaWYgKCFy
ZG1hKSB7DQo+Pj4gLSAgICAgICAgcmV0dXJuIC1FSU87DQo+Pj4gKyAgICAgICAgcmV0dXJuIC0x
Ow0KPj4+ICAgICAgICB9DQo+Pj4gICAgDQo+Pj4gLSAgICByZXQgPSBjaGVja19lcnJvcl9zdGF0
ZShyZG1hKTsNCj4+PiAtICAgIGlmIChyZXQpIHsNCj4+PiAtICAgICAgICByZXR1cm4gcmV0Ow0K
Pj4+ICsgICAgaWYgKGNoZWNrX2Vycm9yX3N0YXRlKHJkbWEpKSB7DQo+Pj4gKyAgICAgICAgcmV0
dXJuIC0xOw0KPj4+ICAgICAgICB9DQo+Pj4gICAgDQo+Pj4gICAgICAgIHFlbXVfZmZsdXNoKGYp
Ow0KPj4+IEBAIC0zMjkwLDkgKzMyODksMTAgQEAgc3RhdGljIHNpemVfdCBxZW11X3JkbWFfc2F2
ZV9wYWdlKFFFTVVGaWxlICpmLA0KPj4+ICAgICAgICB9DQo+Pj4gICAgDQo+Pj4gICAgICAgIHJl
dHVybiBSQU1fU0FWRV9DT05UUk9MX0RFTEFZRUQ7DQo+Pj4gKw0KPj4+ICAgIGVycjoNCj4+PiAg
ICAgICAgcmRtYS0+ZXJyb3Jfc3RhdGUgPSByZXQ7DQo+Pj4gLSAgICByZXR1cm4gcmV0Ow0KPj4+
ICsgICAgcmV0dXJuIC0xOw0KPj4+ICAgIH0NCj4+PiAgICANCj4+PiAgICBzdGF0aWMgdm9pZCBy
ZG1hX2FjY2VwdF9pbmNvbWluZ19taWdyYXRpb24odm9pZCAqb3BhcXVlKTsNCj4+PiBAQCAtMzUz
OCwxMiArMzUzOCwxMSBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV9yZWdpc3RyYXRpb25faGFuZGxl
KFFFTVVGaWxlICpmKQ0KPj4+ICAgICAgICByZG1hID0gcWF0b21pY19yY3VfcmVhZCgmcmlvYy0+
cmRtYWluKTsNCj4+PiAgICANCj4+PiAgICAgICAgaWYgKCFyZG1hKSB7DQo+Pj4gLSAgICAgICAg
cmV0dXJuIC1FSU87DQo+Pj4gKyAgICAgICAgcmV0dXJuIC0xOw0KPj4NCj4+IHRoYXQncyBiZWNh
dXNlIEVJTyBpcyBub3QgYWNjdXJhdGUgaGVyZSA/DQo+IA0KPiBJdCdzIGJlY2F1c2UgdGhlIGZ1
bmN0aW9uIGRvZXMgbm90IHJldHVybiBhIG5lZ2F0aXZlIGVycm5vIGNvZGUsIGFuZA0KPiByZXR1
cm5pbmcgLUVJTyBpcyBtaXNsZWFkaW5nIHJlYWRlcnMgaW50byBhc3N1bWluZyBpdCBkb2VzDQo+
IA0KPj4+ICAgICAgICB9DQo+Pj4gICAgDQo+Pj4gLSAgICByZXQgPSBjaGVja19lcnJvcl9zdGF0
ZShyZG1hKTsNCj4+PiAtICAgIGlmIChyZXQpIHsNCj4+PiAtICAgICAgICByZXR1cm4gcmV0Ow0K
Pj4NCj4+IERpdHRvDQo+IA0KPiBMaWtld2lzZS4NCj4gDQo+IFsuLi5dDQo+IA==

