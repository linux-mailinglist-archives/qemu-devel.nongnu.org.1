Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 904067AE385
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 03:57:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkxJM-0001Hm-Sm; Mon, 25 Sep 2023 21:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkxJJ-0001Fs-UU
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 21:56:25 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkxJH-0007KG-R3
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 21:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695693383; x=1727229383;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZoWBP5z/ywRoZxr2J7/0kq1APDfBo4VPzxcW73HhhjM=;
 b=IICuLgBq2lY05PNszywSgsFCaLyQrM50am3jVT4H6VlVwMxbCR3QHvtN
 Te6cYy+KqQ4Be46G/+XeECVSWxtXN5qXw0gdNTg67FQ6vCFOmUQ0I0X9T
 l2cUjkkpbhTKCwW4XmPOO1kJze9N+Q0YjF4Yx8N0zFjohDQq/teyyJd4b
 7QgiUvHYFx61Xthm6D8QgNsGKUQEVzQtQapSs//Q86A9DVNKmn6Qa/BMA
 PbqukGInlGAwF28X1+R4p2BC5LitkpumM+GWKBS5UFsgoBdCWK6MMy8dZ
 sxqEMzKwvw2RmQrFkc7YSwc3IYZDee31Y5AvTHN926RCHkZrE4yhwxKWQ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="7782991"
X-IronPort-AV: E=Sophos;i="6.03,176,1694703600"; 
   d="scan'208";a="7782991"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 10:56:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8fyf3G+f2dvVhYthhLDhCSqMN9GYafb1/9yoIMkrYF0fDM9S22j4Q1/U4A8IQYRuKOnEzQ9x2fterJB4c78sNGC22ueEvS6r9dMmSKkW7mxSqH4HkJokfHMIsZQhhqF1Uadu/Xi8SrF28sABlVEeGXkhzwjiRKJrA9BZ+XxysVs7oBNyTptHUcudqsR31EaQV31/Ntg/kC8GXMdcXQPYmgRO5nIIkNcmZBIQhgKIJKlHnctm8jXcrXgb0yYOD7vH8qn+4VPO0sVP9ADXMW1SHbzq7/JfGTIefr/n6+Frrlr4x1XsrdI92vCSsqoMLq4lEIxPx48Qx0qAcug1zE6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoWBP5z/ywRoZxr2J7/0kq1APDfBo4VPzxcW73HhhjM=;
 b=OyzbtBcGaftamn+JFsx58fwOn/GxfqKybegqFNX4EWCdplGJ7CABlhXyH15linlf3oTiS93cLVCwfOhUsoy3UV7Eyd7g2kwjeQDTV0bABzqu2xJHWu6j12MCXeChcwUzoo+NfteqawgJDwHe4YPACoFnDXG9RwOnFoCbQApu+NLVsll5jAnJJgl6vTgwWFWnafpWC7RQA8Gf79WjIkTNeLXxRXrglvht0D1LC5g8IVgwPV2ocRxRqdS6mLZ7CMHamqIJ7RWX46EofNZ2Z/YpAy83wNW8FjD6AOT4xDR9jYP8KCGX7EmZNaZEEXVBqeWIDH+ciVozgBrBC03KjGwH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS3PR01MB7971.jpnprd01.prod.outlook.com (2603:1096:604:1bd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 01:56:16 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 01:56:16 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 38/52] migration/rdma: Convert qemu_rdma_write_flush() to
 Error
Thread-Topic: [PATCH 38/52] migration/rdma: Convert qemu_rdma_write_flush() to
 Error
Thread-Index: AQHZ6j9G7ZnnsR/TbUWEFrR8tEDX9bAsZMQA
Date: Tue, 26 Sep 2023 01:56:16 +0000
Message-ID: <10adb2ce-f8d3-d437-c6f8-7fcaedade3f9@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-39-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-39-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS3PR01MB7971:EE_
x-ms-office365-filtering-correlation-id: e1b604ea-01d8-412b-5c76-08dbbe33c563
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qhtUwgs+UYnfgKmJ5vXD2EEntzFiQsrHSk7vBLXDpkBPDo/2tFBx4YDVeP2MYPYTRn72iqZ+qcJdMStK1LOpybj+kHBiuYX8Lgh/YVthBVWJEv/oVCGOPikEfyvR2jGuR9ggAaFrvaIEVlgTL5KMmlrPeJyTrBRzVmCKlvsOAkub6v9cwFyr6Gol2oXpe+gApuvYC0fU0GMw0yR9fWIIpsvYrKwYWf4xnKi//WX5FQr8wXpUYGVylpM4wHDpvXq9MI0RvY68wZ3cbk+rUCx/hVFbFDJ4aZHgrCBkdQwGjYwsPp3p2QZqBtBPoPgHHGCJN+8zvi100VL4tXMt3L+eNIz35l2CL01u4LxckGSU4lBg80dDKxG5wZb341WV19SQuYZ6x89gK5m85HKaV7+PvVrriBwsYWpsQg3NvSs/i2cK8ZiLbJ4AAemmrI6+e79AIlGjM64PJym7zQFJG+OHKt7PXkpT7BzoYFMGfxcflB98rhUMrd6/Tp1NU4M7kOCSufBoAvBmAMayW5fsegOZ58gWH6FB4vO84bTKWLSluXwcnieOJhaaklrhqVldwTn2SGW6Mhq0Gy2MYUmQnrNSZwx3SuJrQrz//ng5V6PRwSSb0/1m/3Qn7dzx+McInigVRj4qsxJWcly7pwCJphb7unH5BKGlVf8IhiMU2IhJEenYuG2j6yW/iKfOzJw44nNqZ2uUEXAOf46jZuDVu0RMTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(1590799021)(1800799009)(53546011)(6506007)(6486002)(6512007)(83380400001)(76116006)(54906003)(66476007)(66946007)(66446008)(64756008)(91956017)(66556008)(110136005)(316002)(41300700001)(478600001)(31686004)(71200400001)(2616005)(8676002)(8936002)(4326008)(26005)(5660300002)(1580799018)(2906002)(85182001)(82960400001)(86362001)(38070700005)(38100700002)(31696002)(36756003)(122000001)(4744005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3pnOWtlOFR6bjg2MHQ5N0VGRCswM1dxZzFWdEJpV0tML2pWSkF2R3JMNzMx?=
 =?utf-8?B?TTViNWlNRWo3aWtQdG5ZMWhuNi9XNGMyRkl4b1E2VW84aDZ0MjB6OURKVit4?=
 =?utf-8?B?QmNPajVrTCtTMEtFUE8zdkN2cFkxdU5BNnVBRDhhTVViZ1ZTRGduZm5rdmgv?=
 =?utf-8?B?YU11WXFuaUY1WENpYVp4d21wdHdQU1NjdFVDK0VDbDlFcnhoRlh4SU9BVWdG?=
 =?utf-8?B?YmhSOUR0T0grRzBicnNFY2xzSC82dmdQT3cwcnJvWkNHUCtNTnVpelZzbTFr?=
 =?utf-8?B?bzdjRVh3VnA2RkxKWkFhOFdqMUoxaTJpNE1vTFFaNmdDdzBwbHg1a01lTXB1?=
 =?utf-8?B?ekZGcVQxSWVHVkRSZm1NQ3ptais2R2hySVlpKysrUURyVTZ6RSs4VG5CRURF?=
 =?utf-8?B?bkpldDVjU2lHZHE2R3VlakVZN1FjYkxjbEZXT1FIMXRZd3F2Q0FUcThWSHJX?=
 =?utf-8?B?Zk9VYzZXYWw4VU9lckM0TWw4NXZzbDNaWUlKd2dGdEFqYk9NdHhQdFhxT1Fk?=
 =?utf-8?B?TzVZUWdLMU9waGNKMEF0RytvVEkzYWl4MDU5M3plVUJFL1ppdVJqRXBGR0hZ?=
 =?utf-8?B?dEd5a1N5NE5aNC83WlI4VXdZT2JDOE9OVm5GaXJSOWxEVjNSNnNDamh1K0M1?=
 =?utf-8?B?c3EwNlBuRWlxTHlxWGRzQXh4K25tWVVzUWdvVDg3NjQ4ajg5TS9mL2tvWG5h?=
 =?utf-8?B?TWpwTHZRN095R0lGWENhZXprMnpiRi9NbnZjdThKWllLdkludlp3bXRqV3Vu?=
 =?utf-8?B?UXZ1RzR3L3RRZDkvbGRrc1djOUxwVU9MdVpJb1FWa3pXSzlpaDIzemVUZ3Ni?=
 =?utf-8?B?NXg3d1d6NVlhaUx6OWthRTJqWHRqelVhMHFjZlNWVFJIbHdvbFdVTlg2MU9m?=
 =?utf-8?B?TFBSUWtra0hWL0ZkYml5ZEY1SWJXbkhBTmJVOW8wN1lzdmZzcjhja1pERWp6?=
 =?utf-8?B?VVVJc2xZTm9RVFBpL3RuMG5GZXdQank4d3BNemlSOUxuNERZTE83Zkp2dTB4?=
 =?utf-8?B?VFJGTW0rTHpFdmh4aXoya1QzNVBTeWJmNlJqOVBTTkZlWWg4ZlNXaUpFdnlT?=
 =?utf-8?B?Vjh0WEd5OStUcWpucjdIK2V1U1dyT1FNdWl0dGZLUnQ1cmFhK1VTbXhIcWto?=
 =?utf-8?B?VlFzM2gyMTFMYUEvb3Z0azViamdKWFAyZkYwT3dXY0YxWVhPYzRaWU0yanZW?=
 =?utf-8?B?ejgrYlQ4ejN0dXg3RTdwL0tBUE92ZFM3eTZCQWttZm1HM2wrTi8xMWZHdS9l?=
 =?utf-8?B?a1BUeFNaTHpXa0VuVmZxdzFUdGlQUUdHWnRaeFdtOExVWG1uelJETDg5eERD?=
 =?utf-8?B?T3h3OVcwak1LOFN3U09GSFQrRHp1N1c1UXhnaExZMHphVHp1N1pETVJWdWo0?=
 =?utf-8?B?MTJ0NXdxRG8weU5VRFN5clpyODMyczBLOE9OUCtIczdsVUpvYU1HSjZLSlVD?=
 =?utf-8?B?REVrTjlqbHNJcFpjRlh6QzBKakZPMmZRZU50Z1gyOVk4VGhOTnpXcTZJVHAr?=
 =?utf-8?B?TWNySmZ6ZHlUVXFqZkw1cDM5RU0wNzB0bU85Qm9mTDV2V3JoTXZycTdCNi9K?=
 =?utf-8?B?c1djT0tVT2NBbmwwaUFDaDRENk44VDdTV09DQlpJQTJ0RG9lazJPRGpvejdS?=
 =?utf-8?B?VEJIMjNzazNaN0FOd3FPcm5ETVpEc2RTcitJNEZOS21EOUxrVlErK0xvQXJZ?=
 =?utf-8?B?M0pQeWNYZVl4NkkwODdqS2MrbVpxOXJMelFTNmhLZkhiaCtKdFBTalJIaFNx?=
 =?utf-8?B?R1o1L0ZibU4zM0ppQWlKSERhUEZuYW93LzhFN3htaU1maVRjdzlmK05aTTZY?=
 =?utf-8?B?ejBydUNQdmNLbEJVenR4dkprN2JMakhqRHhRZmkvWkVXRU9Sd1I4eU5FTmRM?=
 =?utf-8?B?RjNXNjcwdThPY3RTOUtXRXcrZkFOMktGUzJpeFRaTkxCKzJGUWhtL3FBdEI3?=
 =?utf-8?B?Yy9XU1Y2SjBxaURtSUhTWUsrN3phQ09sRDhJSnVZWnQ0T1kxYmJTblpqeERL?=
 =?utf-8?B?TmRwQTVlUGxUajYvbjF4Y0JGVXA1NDV0cDNFcE9QN1Fma0FiL3RtR3diS01T?=
 =?utf-8?B?Mmg3bndYRS9nenRVc2JEdGlGQmUrQnJUcm9XQVJ1NFNEUThMNStHRjNFVmJ5?=
 =?utf-8?B?ZFJzMkZFVk10SW96a2wveEp6ODd4NmJYUUplN1pZaUdraTlDK1NNMEhpUWFJ?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7C7FDE3032F26489A0BA1A4C596EE40@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l2zPcr0OJ1vzbIcTBEr3xZKpF50niQ4t+hUlwhQCbq73PL4L6rgq0vk1qxJSRp4R5w6i6t3C6rNSyw73HlnzXMG/SRV2XVzEAepTfNSv9M0X7vVZE68sXvMnGoZNyTczzssD9PjGG8ThEBToyCKr7s5I6G5fu3/edMBXDvVPcnROiWJrR66IFjU/q2v+3PZYovDrcM/XKoP56OJ07w85U/0A8hXjVrNSYeiTf2PK3X3qvXFB8jZweIsXWQNBvtdrjY7nCNy8+ACI3DcG+/+aeIXdO+1eD0gzri2/PvIWn03pNUYakYLQ5tw2wXSK8KwYyiwNloLONZxpBaAwwGQ2wQXk937lg6CijigSJc4ch6Et0ji07RrbyOg6mUTkumm5G/YQPS/eAr9nxH9KHr+rnFkfquN0lX8DU9kN5sO4l9Bt7QdxCYaLukKphj2j+DpDsWcB8F/F07Hoo2+B6qn78b9wjSnPPUbE+wEv2oH4pYsTdiFmW6Wo1sQ15wS96imRqjYqZivA3KpYx/L4nZpofwk4KsdsolHbA9Kar3UzdeUVSwcdYUt0RJ8yrglXdB2E6s6dKl8ucfXaR0tdRgAUh8xmm9OH2inYPlKIkxCF2blnar7DlF0B63/NOK25Br5QDjvm+0GxVPXz222DJqG41p0tQ93kJNqwfC2vDeUw6VIhF4evM4Ss4HgYtw62R0SiV9q1BgSfGn4Jn7B/UiwvP4VZxuL4ywr9JIQzpvLGhUjBC+BhVIr+c7OKrYxXdkTJetJP1blPpflugxjbmSk/js+USirmi2uqUedO+CfpuTE=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b604ea-01d8-412b-5c76-08dbbe33c563
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 01:56:16.6948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4yKvg/tOY9umtMrClztfiixgGIcLXmqCLZtcULB7r9DrREs/2xWdiHeXOEE7xNQjuzan2NRUvmqUlf1nGoQfNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7971
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBGdW5j
dGlvbnMgdGhhdCB1c2UgYW4gRXJyb3IgKiplcnJwIHBhcmFtZXRlciB0byByZXR1cm4gZXJyb3Jz
IHNob3VsZA0KPiBub3QgYWxzbyByZXBvcnQgdGhlbSB0byB0aGUgdXNlciwgYmVjYXVzZSByZXBv
cnRpbmcgaXMgdGhlIGNhbGxlcidzDQo+IGpvYi4gIFdoZW4gdGhlIGNhbGxlciBkb2VzLCB0aGUg
ZXJyb3IgaXMgcmVwb3J0ZWQgdHdpY2UuICBXaGVuIGl0DQo+IGRvZXNuJ3QgKGJlY2F1c2UgaXQg
cmVjb3ZlcmVkIGZyb20gdGhlIGVycm9yKSwgdGhlcmUgaXMgbm8gZXJyb3IgdG8NCj4gcmVwb3J0
LCBpLmUuIHRoZSByZXBvcnQgaXMgYm9ndXMuDQo+IA0KPiBxaW9fY2hhbm5lbF9yZG1hX3dyaXRl
digpIHZpb2xhdGVzIHRoaXMgcHJpbmNpcGxlOiBpdCBjYWxscw0KPiBlcnJvcl9yZXBvcnQoKSB2
aWEgcWVtdV9yZG1hX3dyaXRlX2ZsdXNoKCkuICBJIGVsZWN0ZWQgbm90IHRvDQo+IGludmVzdGln
YXRlIGhvdyBjYWxsZXJzIGhhbmRsZSB0aGUgZXJyb3IsIGkuZS4gcHJlY2lzZSBpbXBhY3QgaXMg
bm90DQo+IGtub3duLg0KPiANCj4gQ2xlYW4gdGhpcyB1cCBieSBjb252ZXJ0aW5nIHFlbXVfcmRt
YV93cml0ZV9mbHVzaCgpIHRvIEVycm9yLg0KPiANCj4gTmVjZXNzaXRhdGVzIHNldHRpbmcgYW4g
ZXJyb3Igd2hlbiBxZW11X3JkbWFfd3JpdGVfb25lKCkgZmFpbGVkLg0KPiBTaW5jZSB0aGlzIGVy
cm9yIHdpbGwgZ28gYXdheSBsYXRlciBpbiB0aGlzIHNlcmllcywgc2ltcGx5IHVzZSAiRklYTUUN
Cj4gdGVtcG9yYXJ5IGVycm9yIG1lc3NhZ2UiIHRoZXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
TWFya3VzIEFybWJydXN0ZXI8YXJtYnJ1QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBMaSBa
aGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+

