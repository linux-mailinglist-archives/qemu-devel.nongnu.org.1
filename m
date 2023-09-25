Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EA57AD401
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 11:01:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkhRh-0001Cu-1y; Mon, 25 Sep 2023 05:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkhRe-0001CP-3x
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 04:59:58 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkhRb-0002EY-Rm
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 04:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695632396; x=1727168396;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZnHaMh/6kERbLc2uxCROvUF30zlKJFtBnx4E85GmnO4=;
 b=DGtzSPE8u7ZPdLH7JVH9+UKnGPufH2AumUlYA8vpsvxd7vkSh81sGwNS
 DZ5uQeBwo5EiesjNN9bb65SB5cYqN+FQXgoy1yX1vqWThHqeGk+i/R58z
 3rZdj8dhS+8yhDSMe58Z1IE4Ob+7oV6BmoahQN3TEfwphJ2yuTmrwn4bj
 8Mmjtm4uPI4Wnev47IXrUE2EmZHjKUh7Ta8delz9Yj3ZRI46WA5cPgjYK
 8ywT+ucVyE3TBboFpQiOF/x4lve7woiWX2jyoHNZWi33vzgupRlkY38tZ
 Lk2FzQk91hiZQnGjbAbtD6GZWAVK0KhUwB7oPcMR3ZEHBiFWVy0NbDF8U A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96447509"
X-IronPort-AV: E=Sophos;i="6.03,174,1694703600"; d="scan'208";a="96447509"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 17:59:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDZf7uqBjDMGzqYVBO2kZy73H+bLym0vh4AH8JltIzObOEnz7SQYzYI1auJrrjwf4iQDJDsy0Vg1Pz/56b0QVy37CMfozhn0B1lcFYc18DIbrYdWJmHOD7IX/VFHjrUqpVz/Toy+AEPRRWeFqcH23IpjSymzxK/3DBKlPCPoNKJkHfckevF+3o6bq/3jS2TpMKGIDrP5gW2qUNqKSfrOrxIHlTBSsICaK+rTFuNCWXYdDwGjnzHN263X5Cf4VgPSMUcptMp7L6QlU1r37tuusqNSoCijWqxf4OqJIQdUvbq2gJaq2Jf+5NSnma0L5mAMtn8BkbrG1rKhynCguVnrNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnHaMh/6kERbLc2uxCROvUF30zlKJFtBnx4E85GmnO4=;
 b=JdvxMuRbvP1bWHQ3jOd23q+2uz9sUgSwECaY1sfzSN0z792NcPBig87cLUIqUpXuCe3V3ggpnPLtrVJ+TvjTWXoajB6YLDQrMuVVuQdQvvb8cdWLcHz3RoOtU/WTfLYPkVe0K5U18jmvQYyffjho7dvoQqaVnDSIhzIIUKQWTyfTxeDlgby5tIAaSDOK1Yhkt4oVNbdkI8Q7IeiM2WGgwWWQOEtiKJYn9WWOHVPIQnXfF+vhNPeuYoofnuVeaHpBfz8JrHFbYyHisOmenvnWchYQZCOtDBMe4ED2XCnggxCGvereq0dxBn0B6b9KIdvLYVCSInLIms+nQbNnYSpB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OSZPR01MB8057.jpnprd01.prod.outlook.com (2603:1096:604:1b0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:59:47 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:59:47 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Peter Xu <peterx@redhat.com>
CC: "quintela@redhat.com" <quintela@redhat.com>, "leobras@redhat.com"
 <leobras@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH 1/2] migration: Fix rdma migration failed
Thread-Topic: [PATCH 1/2] migration: Fix rdma migration failed
Thread-Index: AQHZ66FzclkAheYxg0+MQmSF60kg9LAm/20AgARGkwA=
Date: Mon, 25 Sep 2023 08:59:47 +0000
Message-ID: <dd78c523-998c-04ea-d559-ae578ee2aa27@fujitsu.com>
References: <20230920090412.726725-1-lizhijian@fujitsu.com>
 <ZQ210LoAWDIJ5l9J@x1n>
In-Reply-To: <ZQ210LoAWDIJ5l9J@x1n>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OSZPR01MB8057:EE_
x-ms-office365-filtering-correlation-id: 262c0c80-49e6-4536-0764-08dbbda5c4e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lmaJ9MW2pPbVj9PGb42ipzrBWULwHqRTLptbJpG6Q0K/Rt18XNBUs3FQjAmVuRHuoYan29WT5b/ppQRcYJF74QncFWWFAf63SmFeipR3+Qw8Te9QJBEEp+AGoXbxz9OsEepzn83juziHcdWsYP03GbGmmeDkQ83NY5AM990eHNtnCX2emIYEJo4S34DSgt3NEqQFgEOzZH74uXCuwHpUr55iMjJmpDeQOD8VXVcOjCl8WPFQghhIVZlIMQMRR+LhrDng/KaFRryOyJ96hwSpZPvRIzt63YFZnvptwZJo6i1WuhLFfDM8DqfMqcq168wCbyvC68cSGd/+gh+veFowEeOAV2n2U3RrhhF5SLxFW0RD1kQwVpe0ojdqr0U1qBNathJPxWfF1ByxaAibQrSlCiL+J5C2boanstSepVRvdWkEFL1O/LimlHATp5+hW8MtOto230JB2UTofBDvJl+o6PBSUTnULF77uXWhstaqbANEgTMaYoopRFHV0D9gfl3/O/tt3dFPpAR5GDlu71WNw9y0SK4v1Jp0PJuIcDQ55E4drsO6sFeB7VVierTMjugmXDZqeO7T27sGY4e2TU3c4t3NFyhq+I5GEKscgMv4O/oSXunnSzYCVlDN8jiMbagw3aLDT1L3u8hc0rYHc5TqUbu3m4DlSmmke5wMxwdGerciQmKeGT9R6pf6IXeBMvFIYalZPfJ+BKhNs7swx7z/kg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(1590799021)(1800799009)(186009)(451199024)(36756003)(122000001)(38100700002)(38070700005)(82960400001)(85182001)(86362001)(31696002)(31686004)(1580799018)(53546011)(5660300002)(2616005)(2906002)(66476007)(478600001)(41300700001)(316002)(66556008)(76116006)(6916009)(54906003)(64756008)(66446008)(91956017)(66946007)(71200400001)(6506007)(6486002)(6512007)(83380400001)(107886003)(4326008)(8676002)(8936002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXp0Nm5DZU9kVWJaM2R1WGFNbUhJeDdwdjV0VHYzUTNDS0VhMEZ5WjR5RWlJ?=
 =?utf-8?B?cXk2dDhDMngrNDNid3hmUlQ1SUdEVlBkRGszQjMwMFRaVTJoWEZ6TmpFMzhw?=
 =?utf-8?B?b1VwWlFkc1dNdmQvWUVFSVl5bndDVTFQQmo1dlJIZWt1S2s4V25DU2JsWmJn?=
 =?utf-8?B?QlArWG8yU011TGxwUktZTUwvbk5xd29BMllSWE5RQWJWUitQOHZEb0ZEL2Vs?=
 =?utf-8?B?VVFhNlEyOVZ0TnovTUNSeVNxR2NNTlVEc3JuTy9yZmlOWHk0NnQ1NVlDRlFa?=
 =?utf-8?B?b3BTU09Tb1NkRmFNNWFDKzhNZUYxakFKV0V1NWJzK3JERnVzcGhjcnlwL2ZC?=
 =?utf-8?B?NklVSlJNcnJxTkROUkdMMm5NZCt2MHhSaHU4QXhBb0poUjh4VlcvcnRBd1Qr?=
 =?utf-8?B?dE82YU01c2RUZ0dvbmNJOEQ1TGx6alhhSUppakdRSExlSmEwL1YvRitTQWND?=
 =?utf-8?B?VmZ2bG9XOFRDUnM0cExyczJZOUMrbEwwQWdOOGhpbFVKT0tWT1A2MHhzM0d6?=
 =?utf-8?B?dVp5WVE0dGlOOUk1clh4NVhTQlF5dVE4NWorSWY1dFozUmhnNWZ2QUJKcTNi?=
 =?utf-8?B?QnZqYmNzQURWN3FuenlLUE9iYm8zRVRmVXdQamJzN2NuY1FTU2R3bzlHN1F0?=
 =?utf-8?B?aGgrcis2MkZ5cVNVM3BZUUN5WE1UUXh4c3lyeFM3VkVMdzBKZVoxalMzcVlC?=
 =?utf-8?B?b01YZ29takt4NmFjYjlXa0J0VjR4a0t3ZmNJZStaeXVQWGE4QnkwK2Y0WEZq?=
 =?utf-8?B?ZC9MUkNJWGkrbEtPWjNudDJFaExtZWwxM0c1eDN6MDREWWJxNWx3V1NGaW41?=
 =?utf-8?B?YXRFMjFhUmtTWDU2SVV1cTlORXFqOEowRjJqUnE0YUlLZHJ4N3kwWmc4MDMw?=
 =?utf-8?B?Y0xpaktKVG1xTUR2dzVoTzdxVG5FZ1FTbHI0Mkk2Z2ZQZGRieG1zTnQyNjBN?=
 =?utf-8?B?MGJUYTNNUWhMaitOZTBsYTdYUlRtZ1RBNmd2WXJPMTRsUDJPbXhtaEZwbDdv?=
 =?utf-8?B?L0NXTS9FWGQ5aEliS0tRd0MrVFpFYlg2eTk2U0t6eklpMVQrazdzODRyZlp5?=
 =?utf-8?B?YkdGamdkQkREZ3hkYUhxL1NwekZaMG1BQ1Rkbi93MUNYMnB5M080ZVNpNHp6?=
 =?utf-8?B?VVZ6RnBrY3laeUtMWklXZnVTc3FvcmpiOWxRa2w1OXpVK2RySTI3d2lydjJM?=
 =?utf-8?B?TVBHS1F4SVg3SXBZK0QrTEpIL3RBN1RiVy9DZjJMbitRRTBLd21lOWg5WXFT?=
 =?utf-8?B?WW84bTAyVkw2azlxNEd1UFNkNWcvT2MrZTBPZzZLRzBBWUxkTHgrMnkwMWwv?=
 =?utf-8?B?NlVwSDE5Y01GT3hNMEdGWml2R1hOQ0RGNWd2Q09YRTA3QXQ4c1RaOU9LTEZI?=
 =?utf-8?B?eVRiSWNIMWpxd0RmM0w4WEZTSXN1OGUzOGpMNUN2MU1RbmxIYkRuM2J6R0Ju?=
 =?utf-8?B?bTRqM3c1eDZHMHZmaGZxTVZHeDBrbW9UTjZuZ2NNYjkwQVUyWVRjV1VkdkJu?=
 =?utf-8?B?STkyRGFuZnJhT21vNm1FWUZjaFUwV256KzM3UVBvWi94Q0Jnbk9VTlkyWTU0?=
 =?utf-8?B?d2g0ZHc3M1Q4MkpvVXcvQkhmNWg5TDJ4NWhHL0RkdjF0YmJlMFF2UmJwREhY?=
 =?utf-8?B?SHZHU0FZRVpvQTRDSjlPV2xsQ3lrTERUR2JGaWJXZDkyVGhtQm56MEoxVlZX?=
 =?utf-8?B?eFIzTzMxa0NnVmdiRmhWdmErTlVqVHNCT2c5MENhNUZQT0JlRFVQNFFWYlJ5?=
 =?utf-8?B?SkhzVGFSdG8zZUNLZUFSSDgydVh6Mm11ZFRUQkR1MklISk9ONTZRdndrdThS?=
 =?utf-8?B?YTcwV1graW1LK0pvUW1DTXE1MjdPN1BORkkydnh5cGtIRTNXaFFrU09WMmRW?=
 =?utf-8?B?eWlkcy85UVpUWnpWZWEwZ1NkOUNjT2dsdGdzdUorQks1U1NtelNUQmkxTS9k?=
 =?utf-8?B?TEd4MTlGMCtMdWJqbWRIeVFzUzdWZW9KZEZrSVhwT0NzNUNvc3R0QWxLN3V1?=
 =?utf-8?B?cWlZWE05ZFFrZ0hxZDFLNWFYbUtqRWJoQ3ZsWXE3RHNpQmd3VXJ3WEdLdkRV?=
 =?utf-8?B?QW53RHJ3V2tsVElNbmZJZ1QzaUcvdk5lVGEvL0xDZHNuajRpSFg2S21GSU1o?=
 =?utf-8?B?RnJaMGQwbDh0dDdMb2ZiK05Za0dyY0U1ZkNHMDZ1SUF6dER5MVJNaDR6akRK?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A542FE01E5ECE14B8E6996EE231A436A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3bhc/ETHybXtEkeLqKzGgJ5hacF9aFPLlYUpoQA+wCXVBbar5kuQjGdNGI6HHY3iLLxQp3KxAjLRJ+YeUO5UyF7qFqHU//tBDjkAcupls+t6VI+Do8ZclfhQZqOFmQat7iwaTzbnLdZK682qXEDpQxFQzHuHVacKtxvb3Hx9Q3jfK6JGv9o9P0UU7bi3c9VVJaETeH2WEKveEXkVJWN5CrqxJRQ91NB0eQhEv9wHzAkRI8LwxcwNrH0pak5vGcxKxb/jXusUDe+AWx+NmALPhriW9L3pwC9A+9OOPo5wx3k1fegc73Zs96EvVlMAeq17zSM6VYKgDhskxg6l1aqTHITSZPmK5OoNZGrqi9jropstt1fifoDJoq8LCt6BZFzO4ITFsIGnAJEVXbUWndzOvKbwjzFaZpFIGDQwUZt3MnqGewF0JVSFY9q3SSTfpviReSaFaxKy2RBD/bhufsDX0Yx0RRq9vudwBfMsM1urVdUrJWojDqYOTOEC3eczK6/wJ8lyeB1ASn6b6rxlL5N5y16AEhA8boL7XR/7KEppWbn0frAzOiQyegQsAnnsnMmY1215l/PMxW8tU7mZiewwurHpTMXQPfNMmcPuaI8KJRWuu7MjP5e1tf8pkGoXlDVCKW2GesHc/Y5fx+pfh3Dy4s6UHB1Ybes3teelbVcC0CJ07J1Ub6XIlMUGgsGtvWNK4Cr/ZKYMDvqx4HO9uQjnQU2aG+NabKwU14gtvGmobaqC8vmCz3pFL3Ybs9Jmo2h+OoZAnbN7VRxKWknvTwxnOF7lk1+jBrbAUibY5t449H0=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262c0c80-49e6-4536-0764-08dbbda5c4e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 08:59:47.3468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VP4k5sheR9/uA0LAY1OjH2moTxKcGOxMhPOzEK6zH8HSbC0JwhKexFyIXuJ18OENlKvj0kVYFB05LOZtmx+PGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8057
Received-SPF: pass client-ip=216.71.158.65; envelope-from=lizhijian@fujitsu.com;
 helo=esa20.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDIyLzA5LzIwMjMgMjM6NDIsIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBXZWQsIFNlcCAy
MCwgMjAyMyBhdCAwNTowNDoxMVBNICswODAwLCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4gRnJvbTog
TGkgWmhpamlhbiA8bGl6aGlqaWFuQGNuLmZ1aml0c3UuY29tPg0KPj4NCj4+IERlc3RpbmF0aW9u
IHdpbGwgZmFpbCB3aXRoOg0KPj4gcWVtdS1zeXN0ZW0teDg2XzY0OiByZG1hOiBUb28gbWFueSBy
ZXF1ZXN0cyBpbiB0aGlzIG1lc3NhZ2UgKDM2Mzg5NTAwMzIpLkJhaWxpbmcuDQo+Pg0KPj4gbWln
cmF0ZSB3aXRoIFJETUEgaXMgZGlmZmVyZW50IGZyb20gdGNwLiBSRE1BIGhhcyBpdHMgb3duIGNv
bnRyb2wNCj4+IG1lc3NhZ2UsIGFuZCBhbGwgdHJhZmZpYyBiZXR3ZWVuIFJETUFfQ09OVFJPTF9S
RUdJU1RFUl9SRVFVRVNUIGFuZA0KPj4gUkRNQV9DT05UUk9MX1JFR0lTVEVSX0ZJTklTSEVEIHNo
b3VsZCBub3QgYmUgZGlzdHVyYmVkLg0KPj4NCj4+IGZpbmRfZGlydHlfYmxvY2soKSB3aWxsIGJl
IGNhbGxlZCBkdXJpbmcgUkRNQV9DT05UUk9MX1JFR0lTVEVSX1JFUVVFU1QNCj4+IGFuZCBSRE1B
X0NPTlRST0xfUkVHSVNURVJfRklOSVNIRUQsIGl0IHdpbGwgc2VuZCBhIGV4dHJhIHRyYWZmaWMg
dG8NCj4+IGRlc3RpbmF0aW9uIGFuZCBjYXVzZSBtaWdyYXRpb24gdG8gZmFpbC4NCj4+DQo+PiBT
aW5jZSB0aGVyZSdzIG5vIGV4aXN0aW5nIHN1YnJvdXRpbmUgdG8gaW5kaWNhdGUgd2hldGhlciBp
dCdzIG1pZ3JhdGVkDQo+PiBieSBSRE1BIG9yIG5vdCwgYW5kIFJETUEgaXMgbm90IGNvbXBhdGli
bGUgd2l0aCBtdWx0aWZkLCB3ZSB1c2UNCj4+IG1pZ3JhdGVfbXVsdGlmZCgpIGhlcmUuDQo+Pg0K
Pj4gRml4ZXM6IDI5NGU1YTQwMzQgKCJtdWx0aWZkOiBPbmx5IGZsdXNoIG9uY2UgZWFjaCBmdWxs
IHJvdW5kIG9mIG1lbW9yeSIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWpp
YW5AY24uZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgbWlncmF0aW9uL3JhbS5jIHwgMyArKy0N
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vcmFtLmMgYi9taWdyYXRpb24vcmFtLmMNCj4+IGlu
ZGV4IDkwNDBkNjZlNjEuLjg5YWUyOGUyMWEgMTAwNjQ0DQo+PiAtLS0gYS9taWdyYXRpb24vcmFt
LmMNCj4+ICsrKyBiL21pZ3JhdGlvbi9yYW0uYw0KPj4gQEAgLTEzOTksNyArMTM5OSw4IEBAIHN0
YXRpYyBpbnQgZmluZF9kaXJ0eV9ibG9jayhSQU1TdGF0ZSAqcnMsIFBhZ2VTZWFyY2hTdGF0dXMg
KnBzcykNCj4+ICAgICAgICAgICBwc3MtPnBhZ2UgPSAwOw0KPj4gICAgICAgICAgIHBzcy0+Ymxv
Y2sgPSBRTElTVF9ORVhUX1JDVShwc3MtPmJsb2NrLCBuZXh0KTsNCj4+ICAgICAgICAgICBpZiAo
IXBzcy0+YmxvY2spIHsNCj4+IC0gICAgICAgICAgICBpZiAoIW1pZ3JhdGVfbXVsdGlmZF9mbHVz
aF9hZnRlcl9lYWNoX3NlY3Rpb24oKSkgew0KPj4gKyAgICAgICAgICAgIGlmIChtaWdyYXRlX211
bHRpZmQoKSAmJg0KPj4gKyAgICAgICAgICAgICAgICAhbWlncmF0ZV9tdWx0aWZkX2ZsdXNoX2Fm
dGVyX2VhY2hfc2VjdGlvbigpKSB7DQo+PiAgICAgICAgICAgICAgICAgICBRRU1VRmlsZSAqZiA9
IHJzLT5wc3NbUkFNX0NIQU5ORUxfUFJFQ09QWV0ucHNzX2NoYW5uZWw7DQo+PiAgICAgICAgICAg
ICAgICAgICBpbnQgcmV0ID0gbXVsdGlmZF9zZW5kX3N5bmNfbWFpbihmKTsNCj4+ICAgICAgICAg
ICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+PiAtLSANCj4+IDIuMzEuMQ0KPj4NCj4gDQo+IE1h
eWJlIGJldHRlciB0byBwdXQgdGhhdCBjaGVjayBhdCB0aGUgZW50cnkgb2YNCj4gbWlncmF0ZV9t
dWx0aWZkX2ZsdXNoX2FmdGVyX2VhY2hfc2VjdGlvbigpPw0KPiANCg0KSXQgc291bmRzIGdvb2Qg
dG8gbWU6DQpkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL29wdGlvbnMuYyBiL21pZ3JhdGlvbi9vcHRp
b25zLmMNCmluZGV4IDFkMWUxMzIxYjBhLi4zMjdiY2YyZmJlNCAxMDA2NDQNCi0tLSBhL21pZ3Jh
dGlvbi9vcHRpb25zLmMNCisrKyBiL21pZ3JhdGlvbi9vcHRpb25zLmMNCkBAIC0zNjgsNyArMzY4
LDcgQEAgYm9vbCBtaWdyYXRlX211bHRpZmRfZmx1c2hfYWZ0ZXJfZWFjaF9zZWN0aW9uKHZvaWQp
DQogIHsNCiAgICAgIE1pZ3JhdGlvblN0YXRlICpzID0gbWlncmF0ZV9nZXRfY3VycmVudCgpOw0K
DQotICAgIHJldHVybiBzLT5tdWx0aWZkX2ZsdXNoX2FmdGVyX2VhY2hfc2VjdGlvbjsNCisgICAg
cmV0dXJuICFtaWdyYXRlX211bHRpZmQoKSB8fCBzLT5tdWx0aWZkX2ZsdXNoX2FmdGVyX2VhY2hf
c2VjdGlvbjsNCiAgfQ0KDQogIGJvb2wgbWlncmF0ZV9wb3N0Y29weSh2b2lkKQ0KDQoNClRoYXQg
Y2hhbmdlcyBtYWtlIG1pZ3JhdGVfbXVsdGlmZF9mbHVzaF9hZnRlcl9lYWNoX3NlY3Rpb24oKSBh
bHdheXMgdHJ1ZSB3aGVuIG11bHRpZmQgaXMgZGlzYWJsZWQuDQoNClRoYW5rcw0KDQoNCg0KPiBJ
IGFsc28gaG9wZSB0aGF0IHNvbWUgZGF5IHRoZXJlJ3Mgbm8gbXVsdGlmZCBmdW5jdGlvbiBjYWxs
ZWQgaW4gZ2VuZXJpYw0KPiBtaWdyYXRpb24gY29kZSBwYXRocy4uDQo+IA==

