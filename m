Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF9B711E0E
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 04:38:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2NKU-0002pE-92; Thu, 25 May 2023 22:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1q2NKQ-0002p1-Uu
 for qemu-devel@nongnu.org; Thu, 25 May 2023 22:37:19 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1q2NKO-0000ZT-KY
 for qemu-devel@nongnu.org; Thu, 25 May 2023 22:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1685068636; x=1716604636;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Sro5rYOu91kTd9kz7jYCoaCPtR7pK7uhNI7KIMOqDnU=;
 b=TgJApjn1Uwez6HppD+Gq2cCBEtuPz749aX7pJXH8IvWWW5FePV0I/qwj
 jg5J8EeAGg1gB0By3fRm79nVkpplVX/t+D+BfzXEVhkH5MGMJ416lNLZ+
 J37oivUyd5sqZPKTp13MgrC5iVR1rqwa7TDWD7zvdb2+vGcEsBa8ExVcE
 NK78wB1nqTP/REDWYhsglpcz2Aky8Kb1uvLvpHPglpwqZ4z01s7KWKW1V
 itzEkttvC6l+BBuLZLNUK3eCYli5jCcaK7X/vuf66+AMVssPH7EPmkLCS
 7xFt/U5swVkwgmDNu3n2hkvrdwgMx/P1dkFAJSHqt59wZqwZv+ff34WHe A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="85473627"
X-IronPort-AV: E=Sophos;i="6.00,192,1681138800"; d="scan'208";a="85473627"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2023 11:37:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHTEjUIz7heI+kWrFvcJ0+GSy9ZWzIFSIGPjQQUGiDj/tvfYyIlEJNnGLjQNDB0PjdZUtiDOZWniO+wC25er5LytI90TNrnCuULuNjqvLfYziMsXi+3uFZmQ88mVBFD4jJ/haqS7S5LGST20rF4GYmxHsT9SJCEfpzJhkeOl7euro8wK8bv/Ip9Pouw+uZI+YawGx7EAydJLkuafEsAo21VfVhnH4FNyp8jg6C0J/Y4sxoll5MsJ10sRT9BKM2jZaFTPJWbVHya/xlv6LLjfz6CZLS9Z2eipOmmKdEmp/vDJrdXhKptJ+u0taNRtkD3aBEzg3ATUGwteOcl20ZY+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sro5rYOu91kTd9kz7jYCoaCPtR7pK7uhNI7KIMOqDnU=;
 b=QNET2zhwEv9SKkJxf/lJ/EQLVHLKqSSFfIHYlIiDq8Y4v5pIWJH5cl8sGMIRR2anNNK113u3/DqcAJOxuO2EIvU2IBRaBB46+B8ax1vCDsv5gDnB7LUKf2kYBhpG1LzMqMyVxuJ19ShgoTbmP5lUY689u7ap5LdMGpD9IVXzNsfjk5pVLUtxtd48KPscc/IyUkXp2ey2FGj/pUWcJUSEh3Iqd5y3hAdG8bc1MGcvyS7drnI+DiBOJJOCpqMgHgxgy9zjlnaDhSW8mjoVYK6r5fcQ8sgyL0YQJMKY9K56TmQMYJCF6kzxYbuP7hADqrqhO0UaQ34IB1xVvcUBKtBTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB11300.jpnprd01.prod.outlook.com (2603:1096:400:3c1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 02:37:06 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835%7]) with mapi id 15.20.6433.016; Fri, 26 May 2023
 02:37:05 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, "Zhijian Li (Fujitsu)"
 <lizhijian@fujitsu.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "ben.widawsky@intel.com"
 <ben.widawsky@intel.com>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, "mst@redhat.com" <mst@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs/clx: Change to lowercase as others
Thread-Topic: [PATCH 2/2] docs/clx: Change to lowercase as others
Thread-Index: AQHZii/uwlydRspfT0esLWxvOp5uvK9q6Y4AgAD3+wA=
Date: Fri, 26 May 2023 02:37:05 +0000
Message-ID: <debbd0e6-c038-e213-e024-0f5116a471e5@fujitsu.com>
References: <20230519085802.2106900-1-lizhijian@cn.fujitsu.com>
 <20230519085802.2106900-2-lizhijian@cn.fujitsu.com>
 <20230525124930.00004ed6@Huawei.com>
In-Reply-To: <20230525124930.00004ed6@Huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB11300:EE_
x-ms-office365-filtering-correlation-id: b6d2e0a3-a069-4ed8-cc25-08db5d921823
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H43SkBinsuoMMV7hPuLIF3q4hBLIm6mgDnxrA632dRoGCdd6i6DAyc/pRjhXjEMb2VHN+qPjeHtQBKgKpcbxa+2H++e12kKYuddoKG5JMTNhoibKBJ5x4IzZ3ZzRpTSd2iYHdZpihFUZKVMV4VP/hMcPJGzy7SNAKr5HeEhBJJ0PXw8ygpynf6eODK9q4NpLJIc4lOBZUGDJVfHy8RLxbEBBsTlOq3aZlh2xtlPjiy+SP+mWf/5/NdTqm7ms1rmDvD+yFGb3CyKmsMZwp2EipC5QY4jHroP/hJrP5QND/NeLS0I4yFBYs25H2Hqx5z//ZJT4uCZeIkaNawZ+bJ6vg6w87GRUCt4gd096Fht+U3dGEsG9Aowvh6NFXfjQRFdh8NV52rx87RoF+8sIWbspQXq0NWOf0N3/fwbZ99r1ZvCNAIHBhGYtf4B4340PruGHgPJSyxtPyRAAQM3Hm2bCFBGj+NUPFIpFmZaKVYd7bMji6f+pHPx2YAJhZXeWxOpt3aGAsBfRBmKVUclBEyIlTl2OJ9H276q3XYgm1SBsxdFlzi8+julEQ/O3G3SSxYU2KQAmUJIV4w0b0qEQfcKv4+F0YoxpcZ/hIjJPGyXy4tav1POo6nWBwx67icR0TG8qcEqa687F+72nGGNrum0Z1XJo1yjjklh8+cPE8TmJy/fRIsdZM2HZNNh1YfZT0m6AS3aktTWH/OEDhyPAmrKX1A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(1590799018)(31686004)(2906002)(5660300002)(54906003)(110136005)(71200400001)(6486002)(36756003)(85182001)(1580799015)(8936002)(8676002)(41300700001)(316002)(91956017)(66556008)(64756008)(66476007)(4326008)(76116006)(66446008)(66946007)(478600001)(38070700005)(31696002)(86362001)(38100700002)(122000001)(186003)(82960400001)(2616005)(83380400001)(6512007)(26005)(6506007)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFF3dUE2c3U3K3VxRUxic3ZyVU02NkMxTjRoMnowNHVUZExrSWFQWEFkN2Z6?=
 =?utf-8?B?OWJER0djS0p4QnB2QzV5TVkyckhzT0QzaXNaMW0xZDFNSnRzV2xBQTM5UTg0?=
 =?utf-8?B?UXZLRjkydTNFMFNueGVrbjIwZnR5OCs3SDVjNmVlV3BjNjVEOEFBYnFHOVo5?=
 =?utf-8?B?TWVRbVU2ZG55cDFpTUJoYUpiY3JVb25USWdHMU42cTlYN3FvbWlCWFFuaEtv?=
 =?utf-8?B?V2p4Q216Y1h3a1RmL2MxOUhXTkdzcld3RnNPblgra0JDc3NDeCtLZ3VZcVRT?=
 =?utf-8?B?YVY5UnljRHRONjVNcEZ4aFU0S2dOcUZUc3pnQ0xZT1NEUW1heTBpOWVCL3N0?=
 =?utf-8?B?akFKSkJ0cW82YjZWeUlCN29kOGVzcjViQWl0VzhPSzkwandYR1RCZFVuREdh?=
 =?utf-8?B?WHcvMzlpb3VrbG5DR1lwWmRacllZTzhucUZST0FUR3ozYSs1LzYxY3RKTFpE?=
 =?utf-8?B?bTdmUUs1M1BHeElQdlR3MHVFYk5jb1R6L1RiMDhNUzh5SlFPQkJIK2pCdkNr?=
 =?utf-8?B?c0RpbUhudE80QlVwYnltR1JDK0JYNmlQMVVFenRXRXFBRVl1RlRGb2VDR2Ro?=
 =?utf-8?B?L1paTGg4dk5wSVpWRlg0THgwR1ZCOUdpeHVrdmcvT2NyQ1czcE53Y2NSMEVP?=
 =?utf-8?B?elRtVE9NMmd1WVl5YWZJT3pFZ0RpYnJlclh1aE1lQWR4K3FWTHV6RHJ2ZlJH?=
 =?utf-8?B?QWt1L3ZRUVc4OE1weE5Vd0pEa0FXVXBnQ2tOUC9ZekViT1oyM3prVkVvZUtk?=
 =?utf-8?B?bHlpRklOWWxIVEdaQW1la0xHaWpZb1BTTHNxekxsaW1oNUJubGZ5ZTRBZlBR?=
 =?utf-8?B?U1ZmRTM3bWxlRGc3UkV3WWhEMjkvSHREWThPdkJGQVJDb2cva09XTE5GRHZt?=
 =?utf-8?B?K1kwTlNRcXIyYTEya0VQTVIybzBzanViMXhOVC9HdDlvRWljTWpOVTJabDRZ?=
 =?utf-8?B?UnE3OUxoS0xhaFVrUndBdGtJTEYxODJPd2dPM2xkWW1BNUFvRzZyMmQzbVNv?=
 =?utf-8?B?OTdIckxRRTRhVjQ4WkZ6eDNTaEdaVUZjUW5CZHk0M1orblFHb2M4WnBNdDRv?=
 =?utf-8?B?RHl3N2ZncTBEbWx6dlhKaTdPUGtGblgrWWc2K3QrWFRxYitUcTJwWnRKUkdX?=
 =?utf-8?B?THV4dURwRGhtRlNicTEvbEp1c2YrWEhIeXY0MkQwVllqMHdKRkdIU0xoSG9C?=
 =?utf-8?B?ZlVzWWZvQ0wrZ0hsV3RkeDdTdlhxOFJKNytlaVlhc3JkOS8xY2haMWp5L3NE?=
 =?utf-8?B?TCs2L1E4ZzhuK0dFbTMzcEtxZVkyRG9IV256MWVTZVd5Zm9YSmxsTHl0UzIv?=
 =?utf-8?B?d1ZCYmg1cG1vYlFMQkRuQUMvRisrS3JCM05VclZxTFpvOTRnQmw3Syt1aWVT?=
 =?utf-8?B?d0hmWmNzSm5SN29XbTBNUnBubE5kd2g5eWdIaXo4SjNvQWhGNEYxS3BsQ0M0?=
 =?utf-8?B?dzRMZGEvT3FDVTBXeFBtWC9tK1RLRVRKc2hmSExrZ2FrdnBCN3g3aG1tbkhF?=
 =?utf-8?B?SnlhMW94T0pQN0JXVkh0cElWb3F2NGIyYTE2emVRMmNLRnBKNjRpQmpjT0Vq?=
 =?utf-8?B?VUpaWWhZWk9zSmNNNlVYS1cxUkRoWXRPcUlxelI0S095Rzd1b3RhWGVCL09X?=
 =?utf-8?B?aHBUeWZlb0I5aTB3YTFVMzNvS0JPVCtRVWRQSjJSdFRJYmUyUTBjNS9ERzE0?=
 =?utf-8?B?d2h3WUdReUlwd1J6MW5OVC9wc2U3L281QlcrbWkyekVQS09NVVlzd2V6VGRN?=
 =?utf-8?B?YmZYdU5oY2FpWmVzaC9GazB4dGZzbCtQOWc4enJhVWxtL0FnVWhjSk5Ub3RK?=
 =?utf-8?B?NXozOUxRMklyRVYwSUNDS2VUUEdNZ3EwMFRHMXlKYzZoQmdLMUx0dk1Md3JM?=
 =?utf-8?B?U240MnBRcUp5L3RZay90VlNyY0JmYjM2ek0rTGQ1MGhjRURMRUFGY282YW14?=
 =?utf-8?B?T2p2U3NFSVdpMmN3NFBVUHdobUFKTFpnckFpQVpGaERLRFFBTXdDa1Q0azUy?=
 =?utf-8?B?Zloxd3g1ZWt0UUlybnFPMG9idmJ5cFJmaUJVaTJuU0JDNUJsUDZPaS85TzVh?=
 =?utf-8?B?UWFDeGFvMkd5MGhCb1FtanRGZWo4WGpYK2Z0bzV3c1dQZUZsSlZscnZtLy9z?=
 =?utf-8?B?OTY1MlFsdCtMVy9oMkVWMjlVQWVYQ3AwQS9KNTVJNnpKWWw3emVuR0FCazNC?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <270699AAF27CE448BF2A231D69496ABD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9XzACoGy4DzZHT0jX75Elu0MRn7liGsTuLCWKpePDPiTMDJdsLsM38V9Y1F8KKXUJ/vsF6U/U+vP90pfkM/5L9lace59D4LzgkVEYhgN+0jeKKdlFXDkPCqXDF1zGLeo2onq8l+Enyp/u8n8YTHPWafnkP54360dUh96ZwM1OCEsxOAK+Pz4msZj/j7YSji3cnaZIZcY3Ut3Zu/aYcdq5fMdyXv49t6mBqvYFAKkBsfSiBSEqCurK56m4xo9pmx//dPjDCuskA63hE16OUy+YVFw+0e6xalgo0rBC0swGkDrI04Ac9L+HJDWu6RTTkzDaG1tKcaQLxEZeyj6NlbP21mpUbPRX1JH5LjGqyhRXbLNTyHzS9iAfu2we7cJQQf8oB8dF+QQ/3YnGpdAzZvBEDJXQtvPJMGXJJ0u4z1WSl+rkeMjHO9Nde5buYgnYAd6NtCukLh2jRrCt0WcEFSf350Zd0Ixrq6DeZt+1QFsSXiwYnlsWkrvKERJnDA/3HbZUUSzzDMEPkKd1PBh/LYjg9Zx1ESfjnUW72J6P83EvGTQJ9OMX+qsltvsBIMetkXJEHqAgz7oY4f0EOeMsCGGBJRy7/IzaOULqhxSAoNU5KSDbyiGdERkzzZyZQ8JRH6PZubMwvkA5Rxd7S2ptrdJp7wmZuQv6jlAPe1Ojw/F8BRa1+qjzhvrLQYgzKtqAjyp8z9C3gDe3OxD/Jpf1lTc2PabI2YpShDf/bFOO1aYIZ76DWXrrvulOxyb1tuFggZD58M4Iyt30N3pXTh0wRd+b4n74Lm7gOV0DHQjg10NxS60ys6y1zWJnGH0cGApnnRxS6/3asQ5xtamH2E08N5LUidrDEG34IdRxbo9kaFsZwTsrHeXtZaMM+OsWL6NLuyc
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d2e0a3-a069-4ed8-cc25-08db5d921823
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 02:37:05.4109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJxfl26bGQRuc51e6+3ohigdAVDBiLVkTeq6Ho589c9pfo9zCvtCUMZQIVjMzIYOK736MPK764/phdBmVCrhZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11300
Received-SPF: pass client-ip=68.232.159.88; envelope-from=lizhijian@fujitsu.com;
 helo=esa8.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCk9uIDI1LzA1LzIwMjMgMTk6NDksIEpvbmF0aGFuIENhbWVyb24gdmlhIHdyb3RlOg0KPiBP
biBGcmksIDE5IE1heSAyMDIzIDE2OjU4OjAyICswODAwDQo+IExpIFpoaWppYW4gPGxpemhpamlh
bkBjbi5mdWppdHN1LmNvbT4gd3JvdGU6DQo+IA0KPj4gVXNpbmcgdGhlIHNhbWUgc3R5bGUgZXhj
ZXB0IHRoZSAnVG9wbycgYWJicmV2aWF0aW9uLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpo
aWppYW4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gSSdtIG5vdCBhIG5h
dGl2ZSBzcGVha2VyLCBmZWVsIGZyZWUgdG8gY29ycmVjdCBtZS4NCj4gDQo+IEkndmUgZWRpdGVk
IHNsaWdodGx5IGFuZCBhcHBsaWVkIHRvIG15IGxvY2FsIHN0YWdpbmcgdHJlZSBmb3IgY3hsIHBh
dGNoZXMuDQo+IEluY2x1ZGVzIGZpeGluZyBkb2NzL2NseCAtPiBkb2NzL2N4bCBpbiB0aGUgcGF0
Y2ggdGl0bGUuDQoNCj4gVGhhbmtzLCBJJ2xsIHF1ZXVlIHRoaXMgdXAgd2l0aCB0aGUgbmV4dCBz
ZXJpZXMgb2YgcmVmYWN0b3JpbmcgcGF0Y2hlcyBldGMsDQoNCg0KVGhhbmsgeW91IGZvciB5b3Vy
IGhlbHAuDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KPiANCj4gSm9uYXRoYW4NCj4gDQo+IA0K
Pj4gLS0tDQo+PiAgIGRvY3Mvc3lzdGVtL2RldmljZXMvY3hsLnJzdCB8IDggKysrKy0tLS0NCj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vZGV2aWNlcy9jeGwucnN0IGIvZG9jcy9zeXN0ZW0v
ZGV2aWNlcy9jeGwucnN0DQo+PiBpbmRleCBkMzU3N2E0ZDZkYS4uNTY0MTRkMjU4NzEgMTAwNjQ0
DQo+PiAtLS0gYS9kb2NzL3N5c3RlbS9kZXZpY2VzL2N4bC5yc3QNCj4+ICsrKyBiL2RvY3Mvc3lz
dGVtL2RldmljZXMvY3hsLnJzdA0KPj4gQEAgLTE1Nyw3ICsxNTcsNyBAQCByZXNwb25zaWJsZSBm
b3IgYWxsb2NhdGluZyBhcHByb3ByaWF0ZSByYW5nZXMgZnJvbSB3aXRoaW4gdGhlIENGTVdzDQo+
PiAgIGFuZCBleHBvc2luZyB0aG9zZSB2aWEgbm9ybWFsIG1lbW9yeSBjb25maWd1cmF0aW9ucyBh
cyB3b3VsZCBiZSBkb25lDQo+PiAgIGZvciBzeXN0ZW0gUkFNLg0KPj4gICANCj4+IC1FeGFtcGxl
IHN5c3RlbSBUb3BvbG9neS4geCBtYXJrcyB0aGUgbWF0Y2ggaW4gZWFjaCBkZWNvZGVyIGxldmVs
OjoNCj4+ICtFeGFtcGxlIHN5c3RlbSB0b3BvbG9neS4geCBtYXJrcyB0aGUgbWF0Y2ggaW4gZWFj
aCBkZWNvZGVyIGxldmVsOjoNCj4+ICAgDQo+PiAgICAgfDwtLS0tLS0tLS0tLS0tLS0tLS1TWVNU
RU0gUEhZU0lDQUwgQUREUkVTUyBNQVAgKDEpLS0tLS0tLS0tLS0tLS0tLS0+fA0KPj4gICAgIHwg
ICAgX19fX19fX19fXyAgIF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18gICBfX19f
X19fX19fICAgIHwNCj4+IEBAIC0xODcsOCArMTg3LDggQEAgRXhhbXBsZSBzeXN0ZW0gVG9wb2xv
Z3kuIHggbWFya3MgdGhlIG1hdGNoIGluIGVhY2ggZGVjb2RlciBsZXZlbDo6DQo+PiAgICAgICAg
ICBfX19fX19fX19fX3xfX18gICBfX19fX19fX19ffF9fICAgX198X19fX19fX19fICAgX19ffF9f
X19fX19fXw0KPj4gICAgICAoMyl8ICBSb290IFBvcnQgMCAgfCB8IFJvb3QgUG9ydCAxIHwgfCBS
b290IFBvcnQgMnwgfCBSb290IFBvcnQgMyB8DQo+PiAgICAgICAgIHwgIEFwcGVhcnMgaW4gICB8
IHwgQXBwZWFycyBpbiAgfCB8IEFwcGVhcnMgaW4gfCB8IEFwcGVhciBpbiAgIHwNCj4+IC0gICAg
ICB8ICBQQ0kgdG9wb2xvZ3kgfCB8IFBDSSBUb3BvbG9neXwgfCBQQ0kgVG9wbyAgIHwgfCBQQ0kg
VG9wbyAgICB8DQo+PiAtICAgICAgfCAgQXMgMGM6MDAuMCAgIHwgfCBhcyAwYzowMS4wICB8IHwg
YXMgZGU6MDAuMCB8IHwgYXMgZGU6MDEuMCAgfA0KPj4gKyAgICAgIHwgIFBDSSB0b3BvbG9neSB8
IHwgUENJIHRvcG9sb2d5fCB8IFBDSSBUb3BvICAgfCB8IFBDSSBUb3BvICAgIHwNCj4gDQo+IEkn
dmUgc3dpdGNoZWQgdG8gdG9wbyBmb3IgdGhlIGFiYnJldmlhdGlvbiBhcyB3ZWxsLiAgTm8gcGFy
dGljdWxhciByZWFzb24NCj4gaXQgc2hvdWxkIGhhdmUgYSBjYXBpdGFsIGxldHRlci4NCj4gDQo+
PiArICAgICAgfCAgYXMgMGM6MDAuMCAgIHwgfCBhcyAwYzowMS4wICB8IHwgYXMgZGU6MDAuMCB8
IHwgYXMgZGU6MDEuMCAgfA0KPj4gICAgICAgICB8X19fX19fX19fX19fX19ffCB8X19fX19fX19f
X19fX3wgfF9fX19fX19fX19fX3wgfF9fX19fX19fX19fX198DQo+PiAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgfA0KPj4gICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgIHwNCj4+IEBAIC0yNzIsNyArMjcyLDcgQEAgRXhhbXBsZSB0b3BvbG9neSBpbnZvbHZpbmcg
YSBzd2l0Y2g6Og0KPj4gICAgICAgICB8ICBSb290IFBvcnQgMCAgfA0KPj4gICAgICAgICB8ICBB
cHBlYXJzIGluICAgfA0KPj4gICAgICAgICB8ICBQQ0kgdG9wb2xvZ3kgfA0KPj4gLSAgICAgIHwg
IEFzIDBjOjAwLjAgICB8DQo+PiArICAgICAgfCAgYXMgMGM6MDAuMCAgIHwNCj4+ICAgICAgICAg
fF9fX19fX19fX19feF9fX3wNCj4+ICAgICAgICAgICAgICAgICAgICAgfA0KPj4gICAgICAgICAg
ICAgICAgICAgICB8DQo+IA0KPiA=

