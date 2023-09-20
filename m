Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE197A7887
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 12:04:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiu4H-00026o-8g; Wed, 20 Sep 2023 06:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qiu4A-00026Z-NS
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 06:04:19 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qiu46-0003gp-Qp
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 06:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695204255; x=1726740255;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ozeWbjhDFTIPa4INO0WsU824bgbLfy+AHmxKKryuTkU=;
 b=nIEar7QAM9HeuCdDNy3Fp6PnXZCezvJv2bKS0A7IBUxn/D77Z1CvwqgC
 5OeQmhzjw73vJoerC2NjXaOHtte0jMGfZ03W/EZV6vkbJpDdj7XGP5ZL/
 Hqt9+Kfe+vAOVFv636kiJF2lNNXXeYSxdyCEyp8LQgsVdRCrluW5b3OtR
 tg36f/n5BVXVkaiuqWTIVM/DCuP6z3qGzJVcCiY4dpgkdDGG265+4bFnJ
 F/iiXo0Iv/aTVpB+KgA51AimyJb/RYZm93XaJd/wn4kyQR0d7Zpe3IOPg
 5cPpG71TzwEQh+/VUBRfeGRrbGkOOd6aJFt4te8p/Al4nNTpWdqFqASqI A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="95557733"
X-IronPort-AV: E=Sophos;i="6.02,161,1688396400"; d="scan'208";a="95557733"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 19:04:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xks6RGydkNOM0xUTck675c769IdqZkMh0twnhjgOJ41Lhgl1aEHBCcABlHWQd9/k21cPuNMMGD22z1gv16oGaZo0tg73dYaxH/b1pC8Eakr/hLnw9di0H3AfjOqpTjbNgPEJsSEEjLWclpjoBG6/3zh5LXdP6DUaM1hW3+/K/F8QjRJnKIvgKhdr7iy4ZetQuaATd77RlsyjBp1LfRky6lCBFyjYVWKMNNe1Q3ckNlax/DspflbR4lzX/Io0ud285PU1KUbp2B2RD/5zpdIkoNV7yvWLEOk3iEqmNGDSB26ybx1Wx1rxHUQjvX7kE3uWnlbZIXHCZLQOhcn+x2rSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozeWbjhDFTIPa4INO0WsU824bgbLfy+AHmxKKryuTkU=;
 b=FwdfcCOwBFdqnZJsNNisAutffrjXN/97qoVr+08pdejBvbNBd9LWxyIW9DQOMrkKxaplohIn9xvr5gfWFUHswSDBFT/o4M+MJzyvD2gefLrjOWLqXoVq8Vl4I1rkYNPitPTQHOlG8X0dCG6XT7AVzIctfDOYkMI0XQIHqIgEXphHFII43r5bnkSjBEuOpD4e6YpXeGMqvRqfSAuN4C0DjJQsoAenzSwK46zF1Xc89hRVVxKoGwXqIqXncNTmXkF+uqkrCkcnlSpUI0Aw0Hx0foF5IQbXJCQlpZq3rfglMmfnvwHPEaWO4CJnDmMtV/aGeQ+wDbHqrd3/sFayD41aWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS3PR01MB10059.jpnprd01.prod.outlook.com (2603:1096:604:1e6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29; Wed, 20 Sep
 2023 10:04:04 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.018; Wed, 20 Sep 2023
 10:04:04 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: William Roche <william.roche@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peterx@redhat.com" <peterx@redhat.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "lidongchen@tencent.com" <lidongchen@tencent.com>
Subject: Re: [PATCH v2 1/1] migration: skip poisoned memory pages on "ram
 saving" phase
Thread-Topic: [PATCH v2 1/1] migration: skip poisoned memory pages on "ram
 saving" phase
Thread-Index: AQHZ50kkGtrj55L5RUGhi5iQm46XLbAbNpUAgACLToCAB8MZgA==
Date: Wed, 20 Sep 2023 10:04:03 +0000
Message-ID: <128792ce-e3aa-a357-5e96-a4d8211193d6@fujitsu.com>
References: <ZQCxg+M2IpecRT8w@x1n>
 <20230914202054.3551250-1-william.roche@oracle.com>
 <20230914202054.3551250-2-william.roche@oracle.com>
 <60d3efa1-d2eb-8e11-8909-eb1ef33204c5@fujitsu.com>
 <e8b7b4d2-7185-9ba6-6122-4fa780a08427@oracle.com>
In-Reply-To: <e8b7b4d2-7185-9ba6-6122-4fa780a08427@oracle.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS3PR01MB10059:EE_
x-ms-office365-filtering-correlation-id: 73d765a9-83aa-4456-7319-08dbb9c0eb55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lWYUkzLWS/y/l64gqQDcTwW4Xaz6ko9uGBrI/qpgKLIU1C5jmPO54pr2k6Cs/k9cZQH+QLSM0ZKOd2F1L8lW0b9+dYlxriXRubWzXV41yIEhPyLGAmXnrEr0I6FL5O1zjJMdOq6HXKfTVodInBmOWqdGJuyInMTbzwXlZm4seHZmxOYxneQiGOxLRJZWgSC7V1rq22uesqDjuSLEcqMEEgY18jeEDFmUE7Jn+HSun6JHFCgLs+zoIdvbWNxjMFYfuL5tjJDSXWvugfJok4pqrsDOWprsHCp6e2boAaUa4wLZHWnvf/22viSCNBvZGDli/RDXKXbuK3ruWtcUWOvzvHkEBWUF5SsgrAmCpxSswUeT6Y91B6iMtyl2Pcw8wxcaRAzyXeVGVEgy7uwaoq4jiRI+43sguf/V93PSQhNvbxmYJyiWnFAOLM04nwDyMRdDJBeSulrJy5CTze+/poUQnL4Wy1N3Vo8/qLmo58WbCStJiq9rkUuX5roSpTIC/DTh01BjprUKSxti8ofaXfq6iSzN1XLKD8qlYLwWSw3AOYYZVN6CKDJk5i6UJffKa18kVLH5zp/gBxESJsfiNZK5jLpdORuHQbNZNKSaTZgNbcU8yUe30Q56ITCtB3HYSl+E8/0KaOAyFHHHBEBkxt5JYCCGAVGKPyP8OgJvLrC+y5FEXXUU6Xs3XkDmDpD5PAJEbgYQ04AjV+jzrvDE0y6ZNQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(186009)(1800799009)(451199024)(1590799021)(6486002)(53546011)(6506007)(6512007)(478600001)(71200400001)(83380400001)(2906002)(66946007)(76116006)(26005)(66476007)(66446008)(64756008)(316002)(54906003)(4326008)(110136005)(91956017)(5660300002)(8936002)(8676002)(41300700001)(66556008)(2616005)(86362001)(36756003)(85182001)(31696002)(82960400001)(122000001)(38100700002)(1580799018)(38070700005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFc3T1hNaVdUbDlRbjViMnpFbVc4SFRaa2ZtR2hsWXlvMXgwdTlSeDU0bnlC?=
 =?utf-8?B?d1dMTmlmd3RoSjlCdnRMSW1BSzQyZFh5eEEzKzZsVG95S1BYbVRWb2ZpN05W?=
 =?utf-8?B?cm5mVCt4d0s1ZkZPVGl2RFBXd0tSSVJ3Uk5tL0RBV3crVHRyM1VISXVVeTlZ?=
 =?utf-8?B?MXZOK0FWWm9vTVo5YmFPZDYzYng4ek1TTVJBd2JKL2I5ay9qamUxM2RaL1kv?=
 =?utf-8?B?eUo1TWJNeUhTL0M5VnJIYWN3bWpWSEpOVDQvL0R6dEY0TnJmZ3lhSUpOY2Nv?=
 =?utf-8?B?RVVPSVNCcm94OWR6OFZmSzFxZlUxK2V4Q1A2a0ZvMWtTZlpDQWx3cFVxZUVU?=
 =?utf-8?B?ZXBpUmN6K0phbEtzWC9DeU1VdEhadWhQMU15UDlIc1czdC9qcmNrWkRpVmYx?=
 =?utf-8?B?L0RlWFEwUjNIK3BKeFlmbXJmb2N5eWpCYlIwakN3emw3KytBRFBnRFAwU3Bt?=
 =?utf-8?B?UXVJYkh2OHZVcjNsQVY3cG01ZURCUGlidlJVY0RxWko2RjIzRVpvSkRZa3Yv?=
 =?utf-8?B?WjBYa1VYS0w2dmJHeFBPR2V2MDMxNUdvaTJnQXZ3aG9nMFlsa3RYVmxEQnQr?=
 =?utf-8?B?eW0vOFQxWGl3NzdWbEpuSWlLc1NrSmhPejlTTHRNZTl1SWh4WFV4Tk1aVlR5?=
 =?utf-8?B?RGVtN3pXcGlveVVqbDdISUd5d05HaWpVUW5Ub2o3MlpTR2NscE92K3pjUDEv?=
 =?utf-8?B?Q1VGOHE4a2FtYkV2UWhobU8vSXMwMy9PcGNQVHUxN0JvVW90blBOS1lwRzgz?=
 =?utf-8?B?RWltMVV5YkZWNTdpN1FZVVhSNVRPN3R6bU9BdnpUVjhKUjFMTlR6YzZtMlFJ?=
 =?utf-8?B?WE1sYTExcHB5UWlnZHZEcFJGTnlzTXhaTUgzajVabmViUW5OanFrRDgrMU9H?=
 =?utf-8?B?bjVNMGJIQmZNbjR1U2V1SnNTRTJZeXB0QXRjbG16U2pvTWVzNFpyZnNaM3ZH?=
 =?utf-8?B?Smpwc2taaVhqKzNlNkdSUU91ZjRiU0pxRlZ4NE5uMDZNRWxPeC8rZHo4QjlN?=
 =?utf-8?B?Mk9Wd0hCanRMdWkvRkV5Ym5CMFY0dFRJS3NWRXU2SDNjSVI4SmJTOEFva0xR?=
 =?utf-8?B?UVhncmxXRmFCdmorNFh1bjVTMzRPSzJPV3djQ29SQmNuWkVjSVRNS2x1WDN2?=
 =?utf-8?B?b3V0YmN0Y3NYckZaWVhiYlVBK3oxMDQ3R0VRNnRmaEp1di9QdW1LQjFFNDAw?=
 =?utf-8?B?NXFQWWdRMTA3V2dSTFljeUhvTGlKU2V1bkZ6RTZJcUg5Y1VTMlhFWFRvTnpm?=
 =?utf-8?B?ZzlDREZsYnJPdFFqUzcxUEVOTkxMeGVtMnFLWkZhZm1ML3YrcDJ0ZGZ3cUJk?=
 =?utf-8?B?UkFGYW0zTXV5dGhtZXJxTUJLei94MkxDL2dkUHEySmRqQmtZa084dk5uTUZ6?=
 =?utf-8?B?UXRzQkptVEpTRFRvZ0l1dmhXdW1vNW02bXcxRytXU1F6UGhxYklWQTlTOW55?=
 =?utf-8?B?aWNUQmd3UHdoQkJpZml6SWhneTdaMk1YT2Q1OHhDR1ZuQXd6OS90TFlyOVR0?=
 =?utf-8?B?QVJOcEVZdFNuNmVEOWJNaWZhUm5UVTFRTTJJU0g3T05UandJY0grYlI3ZVhJ?=
 =?utf-8?B?dnBRQ21VWEZ0U2ZlVmx5VGZ6VzYxM2xBOGJiRkl2c3dPaTd0Y1BqUHhpVEVz?=
 =?utf-8?B?V09udHhBY1Era1BMVkVxckRSRXpMS0w4eXRnV2x1ZFB6eDV6UWtzSmxiSlF0?=
 =?utf-8?B?bURrS2kvbnNtalRXUksrR2cxa0g4bEhCTEFBYWRQR0xSaE53aEdCYXFmTkQ5?=
 =?utf-8?B?ZFZqNGRPaTM3SUxSaTdyUUFFbjQyMzh6OWtBRURQbW1oM2NqbXprRThUNUtH?=
 =?utf-8?B?N3dkMGh6Yms3NFdZczdvVWk0bEdoZ0poQzR1NDNBSFdkQWY2alh5Qk9naFhn?=
 =?utf-8?B?YTFVK2s2Y3FWbkhwdVNkYUVrY2oxeW5IY3gzM2E4dGFCc0hjY2FtMDk4ejMr?=
 =?utf-8?B?S0N0MHFmY2tyT1BDeGlXZGU4bHlaODVhU2xWMFprbjdSQzdJUUg4bi9TZDJC?=
 =?utf-8?B?V2w2VnlrcFV6VlRBaUtxejRJVGhINlpXYkFjOVhqSUs2VXBoc081Zm9KenZK?=
 =?utf-8?B?aElVQi9HN1kyM1BMTnJ1Y1RJeUY1bU1jSFovY1RIMXF3aThUTmUvM2QrMS81?=
 =?utf-8?B?TXNGanowYzFpK2duR05iRWhEZm01b01pNHRmSnVOWDN2OExpdDFIeklLc0FY?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0085232836572240BF472E85D9DB8336@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FXkxSerU2TgJNPBpoRqj1Kz6LLA8SauVBGtRvXO7G1e1oiPFSBQwog/pmS6+5yZUIxvSDmVV0ooZdWqr0GYok3ZKU2phGyykXL6/zuWieZkv6ofbcGoNxBZKB0OTKYMjy/B7PY3jJNb/ru/F9i+LtQNJRniPw0ous0J4CJDCmqjNH/yzaCZT3WLOQITKIfRZqBMN17jBghhacD3EtXiZDbTrFTNsgMJG0jDbq6luAzN7RBQu5WOwhATPNnRWFLmML4FmD3tu9eyG+yvtEx/yAz1eo8EBHIqkqcNc5b+V/t9c+Vrjd6gEqZeGNHXDiwmBhnfPI8LkofROX1V6tS+Mh0m5rHk5PkJ09Ec3NsJMpHzvMIh5FaTkLO2W6mCvsnv+jOUIPVfZqtKQfBSp4KA34Ep1HX0ah+FTFLfNmhD5A5f2pVmBLOamVDhmgtgGJuqO3qvrS2QIQFKXlFYvZi0cq8ctLBe2IZXgWKem7tZEYzzfpq4S58jaZBj/lnjaMjY5MPsIljs/FKkxKDLzC9p6dSITsb+1GHroKK3/VAuJreEM+W+0SvZ71ToPesvfEEUVMDTdBQu6x2VEtQgOutQQ/Qk38Qx2t8xAJpqmf9OR1GSKaU5fEDl/vytMl6PvIpDhIk8/jwx4F1bURWrm0ZwNcUcYQPAUvGYGvs+1c8+UlTgrf74SEgoWqbHsINfupW6DVBkWvS6UngOjXmRgobZobV0wIwIVXcwAj11XiloeWR8V4+6a7J4W01k5+oXYZVv1HhnZ33rmJ+LKb6atC8nNhJ4e5qBvK8n8e95MPuA7yHBwxdx597w0vKqqTCdeaqcWO7u1I9wUIpmc4Gq3TUbDgL1xopEN1bIkpl4oNw7O7VQ=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d765a9-83aa-4456-7319-08dbb9c0eb55
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 10:04:03.5991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wFc79NM6qpjDRptXhowt5da14H36smklyLPryTpoiCS/Umqw95HvYExzPZmFUBSgXspO+pvo2EK4YdAm5G+fMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10059
Received-SPF: pass client-ip=68.232.156.101;
 envelope-from=lizhijian@fujitsu.com; helo=esa14.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE1LzA5LzIwMjMgMTk6MzEsIFdpbGxpYW0gUm9jaGUgd3JvdGU6DQo+IE9uIDkvMTUv
MjMgMDU6MTMsIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0KPj4NCj4+DQo+PiBJJ20gb2th
eSB3aXRoICJSRE1BIGlzbid0IHRvdWNoZWQiLg0KPj4gQlRXLCBjb3VsZCB5b3Ugc2hhcmUgeW91
ciByZXByb2R1Y2luZyBwcm9ncmFtL2hhY2tpbmcgdG8gcG9pc29uIHRoZSBwYWdlLCBzbyB0aGF0
DQo+PiBpIGFtIGFibGUgdG8gdGFrZSBhIGxvb2sgdGhlIFJETUEgcGFydCBsYXRlciB3aGVuIGkn
bSBmcmVlLg0KPj4NCj4+IE5vdCBzdXJlIGl0J3Mgc3VpdGFibGUgdG8gYWNrbm93bGVkZ2UgYSBu
b3QgdG91Y2hlZCBwYXJ0LiBBbnl3YXkNCj4+IEFja2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWpp
YW5AZnVqaXRzdS5jb20+ICMgUkRNQQ0KPj4NCj4gDQo+IFRoYW5rcy4NCj4gQXMgeW91IGFza2Vk
IGZvciBhIHByb2NlZHVyZSB0byBpbmplY3QgbWVtb3J5IGVycm9ycyBpbnRvIGEgcnVubmluZyBW
TSwNCj4gSSd2ZSBhdHRhY2hlZCB0byB0aGlzIGVtYWlsIHRoZSBzb3VyY2UgY29kZSAobWNlX3By
b2Nlc3NfcmVhY3QuYykgb2YgYQ0KPiBwcm9ncmFtIHRoYXQgd2lsbCBoZWxwIHRvIHRhcmdldCB0
aGUgZXJyb3IgaW5qZWN0aW9uIGluIHRoZSBWTS4NCg0KDQpJIGp1c3QgdHJpZWQgeW91IGh3cG9p
c29uIHByb2dyYW0gYW5kIGRvIFJETUEgbWlncmF0aW9uLiBNaWdyYXRpb24gZmFpbGVkLCBidXQg
Zm9ydHVuYXRlbHkNCnRoZSBzb3VyY2Ugc2lkZSBpcyBzdGlsbCBhbGl2ZSA6KS4NCg0KKHFlbXUp
IEZhaWxlZCB0byByZWdpc3RlciBjaHVuayE6IEJhZCBhZGRyZXNzDQpDaHVuayBkZXRhaWxzOiBi
bG9jazogMCBjaHVuayBpbmRleCA2NzEgc3RhcnQgMTM5OTU1MDk2NTE4NjU2IGVuZCAxMzk5NTUw
OTc1NjcyMzIgaG9zdCAxMzk5NTUwOTY1MTg2NTYgbG9jYWwgMTM5OTU0MzkyOTI0MTYwIHJlZ2lz
dHJhdGlvbnM6IDYzNg0KcWVtdS1zeXN0ZW0teDg2XzY0OiBjYW5ub3QgZ2V0IGxrZXkNCnFlbXUt
c3lzdGVtLXg4Nl82NDogcmRtYSBtaWdyYXRpb246IHdyaXRlIGVycm9yISAtMjINCnFlbXUtc3lz
dGVtLXg4Nl82NDogUkRNQSBpcyBpbiBhbiBlcnJvciBzdGF0ZSB3YWl0aW5nIG1pZ3JhdGlvbiB0
byBhYm9ydCENCnFlbXUtc3lzdGVtLXg4Nl82NDogZmFpbGVkIHRvIHNhdmUgU2F2ZVN0YXRlRW50
cnkgd2l0aCBpZChuYW1lKTogMihyYW0pOiAtMjINCnFlbXUtc3lzdGVtLXg4Nl82NDogRWFybHkg
ZXJyb3IuIFNlbmRpbmcgZXJyb3IuDQoNCg0KU2luY2UgY3VycmVudCBSRE1BIG1pZ3JhdGlvbiB0
cmFuc2ZlcnMgZ3Vlc3QgbWVtb3J5IGluIGEgY2h1bmsgc2l6ZSgxTSkgYnkgZGVmYXVsdCwgd2Ug
bWF5IG5lZWQgdG8NCg0Kb3B0aW9uIDE6IHJlZHVjZSBhbGwgY2h1bmsgc2l6ZSB0byAxIHBhZ2UN
Cm9wdGlvbiAyOiBoYW5kbGUgdGhlIGh3cG9pc29uIGNodW5rIHNwZWNpYWxseQ0KDQpIb3dldmVy
LCBiZWNhdXNlIHRoZXJlIG1heSBiZSBhIGNoYW5jZSB0byB1c2UgYW5vdGhlciBwcm90b2NvbCwg
aXQncyBhbHNvIHBvc3NpYmxlIHRvIHRlbXBvcmFyaWx5IG5vdCBmaXggdGhlIGlzc3VlLg0KDQpU
ZXN0ZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCg0KVGhhbmtzDQpa
aGlqaWFuDQoNCg0KDQoNCj4gDQo+IChCZSBjYXJlZnVsIHRoYXQgZXJyb3IgaW5qZWN0aW9uIGlz
IGN1cnJlbnRseSBub3Igd29ya2luZyBvbiBBTUQNCj4gcGxhdGZvcm1zIC0tIHRoaXMgaXMgYSB3
b3JrIGluIHByb2dyZXNzIGlzIGEgc2VwYXJhdGUgcWVtdSB0aHJlYWQpDQo+IA0KPiANCj4gVGhl
IGdlbmVyYWwgaWRlYToNCj4gV2UgYXJlIGdvaW5nIHRvIHRhcmdldCBhIHByb2Nlc3MgbWVtb3J5
IHBhZ2UgcnVubmluZyBpbnNpZGUgYSBWTSB0byBzZWUNCj4gd2hhdCBoYXBwZW5zIHdoZW4gd2Ug
aW5qZWN0IGFuIGVycm9yIG9uIHRoZSB1bmRlcmx5aW5nIHBoeXNpY2FsIHBhZ2UgYXQNCj4gdGhl
IHBsYXRmb3JtIChoeXBlcnZpc29yKSBsZXZlbC4NCj4gVG8gaGF2ZSBhIGJldHRlciB2aWV3IG9m
IHdoYXQncyBnb2luZyBvbiwgd2UnbGwgdXNlIGEgcHJvY2VzcyBtYWRlIGZvcg0KPiB0aGlzOiBJ
dCdzIGdvYWwgaXMgdG8gYWxsb2NhdGUgYSBtZW1vcnkgcGFnZSwgYW5kIGNyZWF0ZSBhIFNJR0JV
Uw0KPiBoYW5kbGVyIHRvIGluZm9ybSB3aGVuIGl0IHJlY2VpdmVzIHRoaXMgc2lnbmFsLiBJdCB3
aWxsIGFsc28gd2FpdCBiZWZvcmUNCj4gdG91Y2hpbmcgdGhpcyBwYWdlIHRvIHNlZSB3aGF0IGhh
cHBlbnMgbmV4dC4NCj4gDQo+ICDCoMKgwqAgQ29tcGlsaW5nIHRoaXMgdG9vbDoNCj4gIMKgwqDC
oCAkIGdjYyAtbyBtY2VfcHJvY2Vzc19yZWFjdF94ODYgbWNlX3Byb2Nlc3NfcmVhY3QuYw0KPiAN
Cj4gDQo+IExldCdzIHRyeSB0aGF0Og0KPiBUaGlzIHByb2NlZHVyZSBzaG93cyB0aGUgYmVzdCBj
YXNlIHNjZW5hcmlvLCB3aGVyZSBhbiBlcnJvciBpbmplY3RlZCBhdA0KPiB0aGUgcGxhdGZvcm0g
bGV2ZWwgaXMgcmVwb3J0ZWQgdXAgdG8gdGhlIGd1ZXN0IHByb2Nlc3MgdXNpbmcgaXQuDQo+IE5v
dGUgdGhhdCBxZW11IHNob3VsZCBiZSBzdGFydGVkIHdpdGggcm9vdCBwcml2aWxlZ2UuDQo+IA0K
PiAgwqDCoMKgIDEuIENob29zZSBhIHByb2Nlc3MgcnVubmluZyBpbiB0aGUgVk0gKGFuZCBpZGVu
dGlmeSBhIG1lbW9yeSBwYWdlDQo+IHlvdSB3YW50IHRvIHRhcmdldCwgYW5kIGdldCBpdHMgcGh5
c2ljYWwgYWRkcmVzcyDigJMgY3Jhc2goOCkgdnRvcCBjYW4NCj4gaGVscCB3aXRoIHRoYXQpIG9y
IHJ1biB0aGUgYXR0YWNoZWQgbWNlX3Byb2Nlc3NfcmVhY3QgZXhhbXBsZSAoY29tcGlsZWQNCj4g
Zm9yIHlvdXIgcGxhdGZvcm0gbWNlX3Byb2Nlc3NfcmVhY3RfW3g4Nnxhcm1dKSB3aXRoIGFuIG9w
dGlvbiB0byBiZQ0KPiBlYXJseSBpbmZvcm1lZCBvZiBfQU8gZXJyb3IgKC1lKSBhbmQgd2FpdCBF
TlRFUiB0byBjb250aW51ZSB3aXRoIHJlYWRpbmcNCj4gdGhlIGFsbG9jYXRlZCBwYWdlICgtdyAw
KToNCj4gDQo+IFtyb290QFZNIF0jIC4vbWNlX3Byb2Nlc3NfcmVhY3RfeDg2IC1lIC13IDANCj4g
U2V0dGluZyBFYXJseSBraWxsLi4uIE9rDQo+IA0KPiBEYXRhIHBhZ2VzIGF0IDB4N2ZhMGY5YjI1
MDAwwqAgcGh5c2ljYWxseSAweDIwMGYyZmEwMDANCj4gDQo+IFByZXNzIEVOVEVSIHRvIGNvbnRp
bnVlIHdpdGggcGFnZSByZWFkaW5nDQo+IA0KPiANCj4gIMKgwqDCoCAyLiBHbyBpbnRvIHRoZSBW
TSBtb25pdG9yIHRvIGdldCB0aGUgdHJhbnNsYXRpb24gZnJvbSAiR3Vlc3QNCj4gUGh5c2ljYWwg
QWRkcmVzcyB0byBIb3N0IFBoeXNpY2FsIEFkZHJlc3MiIG9yICJIb3N0IFZpcnR1YWwgQWRkcmVz
cyI6DQo+IA0KPiAgwqAocWVtdSkgZ3BhMmhwYSAweDIwMGYyZmEwMDAnDQo+IEhvc3QgcGh5c2lj
YWwgYWRkcmVzcyBmb3IgMHgyMDBmMmZhMDAwIChyYW0tbm9kZTEpIGlzIDB4NDZmMTJmYTAwMA0K
PiANCj4gDQo+ICDCoMKgwqAgMy4gQmVmb3JlIHdlIGluamVjdCB0aGUgZXJyb3IsIHdlIHdhbnQg
dG8ga2VlcCB0cmFjayBvZiB0aGUgVk0NCj4gY29uc29sZSBvdXRwdXQgKGluIGEgc2VwYXJhdGUg
d2luZG93KS4NCj4gSWYgeW91IGFyZSB1c2luZyBsaWJ2aXJ0OiAjIHZpcnNoIGNvbnNvbGUgbXl2
bQ0KPiANCj4gDQo+ICDCoMKgwqAgNC4gV2Ugbm93IHByZXBhcmUgZm9yIHRoZSBlcnJvciBpbmpl
Y3Rpb24gYXQgdGhlIHBsYXRmb3JtIGxldmVsIHRvDQo+IHRoZSBhZGRyZXNzIHdlIGZvdW5kLsKg
IFRvIGRvIHNvLCB3ZSdsbCBuZWVkIHRvIHVzZSB0aGUgaHdwb2lzb24taW5qZWN0DQo+IG1vZHVs
ZSAoeDg2KQ0KPiBCZSBjYXJlZnVsLCBhcyBod3BvaXNvbiB0YWtlcyBQYWdlIEZyYW1lIE51bWJl
cnMgYW5kIHRoaXMgUEZOIGlzIG5vdCB0aGUNCj4gcGh5c2ljYWwgYWRkcmVzcyDigJMgeW91IG5l
ZWQgdG8gcmVtb3ZlIHRoZSBsYXN0IDEyIGJpdHMgKHRoZSBsYXN0IDMgemVyb3MNCj4gb2YgdGhl
IGFib3ZlIGFkZHJlc3MpICENCj4gDQo+IFtyb290QGh2IF0jIG1vZHByb2JlIGh3cG9pc29uLWlu
amVjdA0KPiBbcm9vdEBodiBdIyBlY2hvIDB4NDZmMTJmYSA+IC9zeXMva2VybmVsL2RlYnVnL2h3
cG9pc29uL2NvcnJ1cHQtcGZuDQo+IA0KPiAgwqDCoMKgwqDCoMKgIElmIHlvdSBzZWUgIk9wZXJh
dGlvbiBub3QgcGVybWl0dGVkIiBlcnJvciB3aGVuIHdyaXRpbmcgYXMgcm9vdA0KPiBvbiBjb3Jy
dXB0LXBmbiwgeW91IG1heSBiZSBmYWNpbmcgYSAia2VybmVsX2xvY2tkb3duKDcpIiB3aGljaCBp
cw0KPiBlbmFibGVkIG9uIFNlY3VyZUJvb3Qgc3lzdGVtcyAoY2FuIGJlIHZlcmlmaWVkIHdpdGgN
Cj4gIm1va3V0aWwgLS1zYi1zdGF0ZSIpLiBJbiB0aGlzIGNhc2UsIHR1cm4gU2VjdXJlQm9vdCBv
ZmbCoCAoYXQgdGhlIFVFRkkNCj4gbGV2ZWwgZm9yIGV4YW1wbGUpDQo+IA0KPiAgwqDCoMKgIDUu
IExvb2sgYXQgdGhlIHFlbXUgb3V0cHV0IChlaXRoZXIgb24gdGhlIHRlcm1pbmFsIHdoZXJlIHFl
bXUgd2FzDQo+IHN0YXJ0ZWQgb3LCoCBpZiB5b3UgYXJlIHVzaW5nIGxpYnZpcnQ6wqAgdGFpbCAv
dmFyL2xvZy9saWJ2aXJ0L3FlbXUvbXl2bQ0KPiANCj4gMjAyMi0wOC0zMVQxMzo1MjoyNS42NDUz
OThaIHFlbXUtc3lzdGVtLXg4Nl82NDogd2FybmluZzogR3Vlc3QgTUNFIE1lbW9yeSBFcnJvciBh
dCBRRU1VIGFkZHIgMHg3ZWVlYWNlMDAwMDAgYW5kIEdVRVNUIGFkZHIgMHgyMDBmMjAwIG9mIHR5
cGUgQlVTX01DRUVSUl9BTyBpbmplY3RlZA0KPiANCj4gIMKgwqDCoCA2LiBPbiB0aGUgZ3Vlc3Qg
Y29uc29sZToNCj4gV2UnbGwgc2VlIHRoZSBWTSByZWFjdGlvbiB0byB0aGUgaW5qZWN0ZWQgZXJy
b3I6DQo+IA0KPiBbwqAgMTU1LjgwNTE0OV0gRGlzYWJsaW5nIGxvY2sgZGVidWdnaW5nIGR1ZSB0
byBrZXJuZWwgdGFpbnQNCj4gW8KgIDE1NS44MDYxNzRdIG1jZTogW0hhcmR3YXJlIEVycm9yXTog
TWFjaGluZSBjaGVjayBldmVudHMgbG9nZ2VkDQo+IFvCoCAxNTUuODA3MTIwXSBNZW1vcnkgZmFp
bHVyZTogMHgyMDBmMjAwOiBLaWxsaW5nIG1jZV9wcm9jZXNzX3JlYTozNTQ4IGR1ZSB0byBoYXJk
d2FyZSBtZW1vcnkgY29ycnVwdGlvbg0KPiBbwqAgMTU1LjgwODg3N10gTWVtb3J5IGZhaWx1cmU6
IDB4MjAwZjIwMDogcmVjb3ZlcnkgYWN0aW9uIGZvciBkaXJ0eSBMUlUgcGFnZTogUmVjb3ZlcmVk
DQo+IA0KPiAgwqDCoMKgIDcuIFRoZSBHdWVzdCBwcm9jZXNzIHRoYXQgd2Ugc3RhcnRlZCBhdCB0
aGUgZmlyc3Qgc3RlcCBnaXZlczoNCj4gDQo+IFNpZ25hbCA3IHJlY2VpdmVkDQo+IEJVU19NQ0VF
UlJfQU8gb24gdmFkZHI6IDB4N2ZhMGY5YjI1MDAwDQo+IA0KPiBBdCB0aGlzIHN0YWdlLCB0aGUg
Vk0gaGFzIGEgcG9pc29uZWQgcGFnZSwgYW5kIGEgbWlncmF0aW9uIG9mIHRoaXMgVk0NCj4gbmVl
ZHMgdG8gYmUgZml4ZWQgaW4gb3JkZXIgdG8gYXZvaWQgYWNjZXNzaW5nIHRoZSBwb2lzb25lZCBw
YWdlLg0KPiANCj4gIMKgwqDCoCA4LiBUaGUgcHJvY2VzcyBjb250aW51ZXMgdG8gcnVuIChhcyBp
dCBoYW5kbGVkIHRoZSBTSUdCVVMpLg0KPiBOb3cgaWYgeW91IHByZXNzIEVOVEVSIG9uIHRoaXMg
cHJvY2VzcyB0ZXJtaW5hbCwgaXQgd2lsbCB0cnkgdG8gcmVhZCB0aGUNCj4gcGFnZSB3aGljaCB3
aWxsIGdlbmVyYXRlIGEgbmV3IE1DRSAoYSBzeW5jaHJvbm91cyBvbmUpIGF0IFZNIGxldmVsIHdo
aWNoDQo+IHdpbGwgYmUgc2VudCB0byB0aGlzIHByb2Nlc3M6DQo+IA0KPiBTaWduYWwgNyByZWNl
aXZlZA0KPiBCVVNfTUNFRVJSX0FSIG9uIHZhZGRyOiAweDdmYTBmOWIyNTAwMA0KPiBFeGl0IGZy
b20gdGhlIHNpZ25hbCBoYW5kbGVyIG9uIEJVU19NQ0VFUlJfQVINCj4gDQo+ICDCoMKgwqAgOS4g
VGhlIFZNIGNvbnNvbGUgc2hvd3M6DQo+IFsgMjUyMC44OTUyNjNdIE1DRTogS2lsbGluZyBtY2Vf
cHJvY2Vzc19yZWE6MzU0OCBkdWUgdG8gaGFyZHdhcmUgbWVtb3J5IGNvcnJ1cHRpb24gZmF1bHQg
YXQgN2Y0NWU1MjY1MDAwDQo+IA0KPiAgwqDCoMKgIDEwLiBUaGUgVk0gY29udGludWVzIHRvIHJ1
bi4uLg0KPiBXaXRoIGEgcG9pc29uZWQgcGFnZSBpbiBpdHMgYWRkcmVzcyBzcGFjZQ0KPiANCj4g
SFRILA0KPiBXaWxsaWFtLg==

