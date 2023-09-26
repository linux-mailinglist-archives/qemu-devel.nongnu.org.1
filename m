Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2F37AE532
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 07:45:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql0sP-0002nY-5f; Tue, 26 Sep 2023 01:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql0sN-0002nH-Jh
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:44:51 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql0sL-00069H-KA
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695707089; x=1727243089;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=SR2cefkJnDTtn8BsQoaqO148r/JkXDuQ4SmEpfTIQfU=;
 b=FHZjQk33Gzy869LCukXNNS/ZEMOKo/vmIduB37q/4/9jKB7BMQL8W3OX
 Q2hso7f8wscje+kGtN9EDeu+zJeSq2XmljsOVGG4vNRODYZmB/V9vhzva
 zE3dFDv+B1KZ27pxvu2MeS25lQla9PJ0092FCjj8IqsWv5YhL/2uKTHHr
 KhR3XVCMtEK6noVblJVk5hNKRaFFU03XzOi8foQasOUe4L/PrI3h/yxbd
 pla9OM55+KntJ9Y/Sv0eKtmvg7sc4D4SkKYhMDhjuYqDDPbXDxK9cxYOG
 CTNH0CVIDSfqikf0r8ZsMbP1HSYtEOI4r6+AyRnRnv3Yy0Cr6mEz+eV2T g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96861976"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="96861976"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 14:44:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQd3vpE0De3KA4vC9h309TDRTrwMAR6bNJohp0hwXgn6y90vVabGerZgLvA7enAO70TfQhcjUDwqQUP5qZ5qS2TystQnNDNbTkXK4ZEFD4hboAkfnIuoEbAbGcVvXt9Qd/rkdmq7wB89JbG4z2uoK9rhzTiFAc+lpY6ifc+l/M1eBL/0h63cBZJ161DVhfp30hwN8Rz5VcRVuNbfiZmSuTNqaPDiPJxZFMTIoQPJtStsht5vjxTiG0VSGLSCcZtIl4qL3CudRUOSDygVXx8Ret6DtOxh4IhA4qYTBe84+AnMKNkcbbl/a6gj64c7INbpmRXnw2RAkk0uporqLNb3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SR2cefkJnDTtn8BsQoaqO148r/JkXDuQ4SmEpfTIQfU=;
 b=A2aozBHX5rLT1KGYYVQhwY7lyoTFzxLkBvXu5Jb6w+yuvMOfoPf5bMj+fz5qmEiFpLKJOa/jqoBO1chW4GQj2ZFavOsk/mvw2VydbkgKJ8zA6lgugMgSy+yuWSe0areWtxuJMwsQooNkAPCRunfyO03p7VLfSHKUgfBNB1a0Xw0RWHxljHCnCFgMeytYm1kfoE7dtIE1vyKkzfCXzHgWRKot6Q9N9uz2fz6ZetSLFX0S4IbU527FgdNJqrJNWmcjNpBN137NYAhLDoKd04s1hIiOGFlQKEAl1SPqtklTE6O/rxSDy2gQ0q/CqvBd8yPYnUhGZK8EDzkZhgiNRA+HIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TY1PR01MB10720.jpnprd01.prod.outlook.com (2603:1096:400:327::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 05:44:41 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 05:44:41 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 44/52] migration/rdma: Silence qemu_rdma_resolve_host()
Thread-Topic: [PATCH 44/52] migration/rdma: Silence qemu_rdma_resolve_host()
Thread-Index: AQHZ6j9e0uNXv/u5Wk2BZpNVo5ji1LAspJYA
Date: Tue, 26 Sep 2023 05:44:41 +0000
Message-ID: <fc1d484a-c9b1-2093-09f6-66fd3042decd@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-45-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-45-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TY1PR01MB10720:EE_
x-ms-office365-filtering-correlation-id: 2551a95c-17a6-4ba7-966f-08dbbe53ae0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y8paEfrOUuSqhXFiQDUUziQQcsMkHlDr+baAlucz1GpwbdnCPPi+gJ4QqPf40Ds7IEPpOPHyM1wDwoOJuJzZi5AEqHfLgXI6mrxYQ94lmNowPlXUW0PFjaZo+dcqSfTYvrJ65FqAxD3v53f+kpOeHy0+xYFvLrg/jO7uqHAjfW8hXprFcDUNHRHoYXSngesQe9SXMmZaTzTAlXNxfd2zm3SFBnFarKCzuJYa9v/kuro7roE+gfcx4jVD0iWqq4+5JM5ChXi3NZiflidKWd6B+pnRgdM49b9nyOfKLc/PjVDgzth2qOoj7CWuf1wFkamwLxvSHTrtInOZPdu6GHulTDgbgXMNBo6EQWVPVeJduoJnXzbdA1QnyKMzHhosAW7JCEHnctjCYPSlDVSqIUse85RtJPgrmWHWW86mE5hDOyhW33Tsz58esUDfaUvIBqfaRYxYZrFLt5fR6MjX4GhZdccrair73JN2FkzXWb47avECvo8mtc3PPfEUKwtwbe0v4fYydNjzAvUX4jMmbVwoEY9EiNxm4JNgSI39Z643N7ZsIdhIyxpNYpguAsXzb92c178CMh5GVd1Tp5YijTNmWFhUf2cBlwuD34TCS7FnS8v7E+hy44iZgUpXtiuo9jo5jdutp70sXDmbDycxYZ8R2Z27f51VQ50hGeVujs1uJoAD+euPTei8U993JmzDC4YZp6ZWxu17Wr69kVQRZrvDMg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799009)(451199024)(1590799021)(186009)(41300700001)(2616005)(8936002)(8676002)(4326008)(31696002)(54906003)(66476007)(66446008)(66946007)(64756008)(66556008)(316002)(26005)(31686004)(76116006)(110136005)(91956017)(86362001)(1580799018)(4744005)(2906002)(6486002)(82960400001)(122000001)(478600001)(38070700005)(53546011)(83380400001)(71200400001)(36756003)(38100700002)(6506007)(6512007)(85182001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXkwUEZ4UnZMOFZQc201RmZiMkRoeU1kUHJBVE40bEhFQzJTRWF6blhpMHhC?=
 =?utf-8?B?SEVORGxSdmxOQVBISXRScytHL1hPSmUrWllyeFNMMmIybG9UU3d0eXlrUFp3?=
 =?utf-8?B?WVc5UWZGaDNxT0Z0SGttdEkrRWJPL0JDbGUxMG1WSDJJMGFXUDJjV1VpS08r?=
 =?utf-8?B?aU5QSUVpbC8xRllBVU1JcWFvRnM1RGhEb3p5WnFHZHFCVStWVXViL0RScnRU?=
 =?utf-8?B?VnZxNGc0aUtJeERSb3hTT0R2TFR2V3pRNzRLOS9hQXBWOElkUmU5ZEZycDI2?=
 =?utf-8?B?TUxkTDBkbFIzaWlkYlliVEwxMW1qVXpzNlJ0VzNHUmtaL3ptY1VwUTV3b3gr?=
 =?utf-8?B?cGtBdlJkajUyRC94L3pUbkNLMnVDYUh2OThBRnZmMFZ5b1NVenFlYk8ybS9l?=
 =?utf-8?B?a0xFZlFoQXViMi85WVlNcTlESCsveVpZbERuTmpsY3JBUXJQN1pYL0xvUkVW?=
 =?utf-8?B?WW56T3dzTGR1SlprVGd1UEt0ekRVWWhjZFB3eVk0ZDJjSnJQajdiMkxGQ0ZS?=
 =?utf-8?B?VDJOWHZuVG92cUFVMGltMm1ZU2FDOHZ4dmpIcTRCNUZDaGRRN3hpSGlmRDhl?=
 =?utf-8?B?dmc4MXhFZ1pYYWNzb016Z0w5RmhOWFNXWTZERitZaXpKTDBXS0tTRG5lUWg4?=
 =?utf-8?B?SzNrTDBVYUxRaVVESTBRcHZQSDBjQ1RhaExZWnV5eDB0UHJJcTRhOWtld0wz?=
 =?utf-8?B?anVxeEo3WkpGZnV3Y2cybWhLN1V6N2NEekluQTk2TDIwcFcxdkRNSVZNbFVq?=
 =?utf-8?B?WS9IVHFENkRHNXZJdzlJVFgxQVpOTG82UkNHQW0wZzF4OHFSelRNODNSTC9r?=
 =?utf-8?B?YkVzdVUvaDFzRk1JRDV3a3piVnppMXJSUS9nNFl0eU9rdzd6aC9QWmRDYkZ6?=
 =?utf-8?B?em1STm92enpGQmdIVVVESlJtRDdnRXRFNjlXRXFFdE9IK2xBT1Z0NlFsUnVM?=
 =?utf-8?B?anpWeUs4V1BZVDRVM3ZOSEd2dFpITkcwS0ZxbmJKNkNUWmU5L0x5SVh6VGhW?=
 =?utf-8?B?TFgzTUFsNFlpUmZRcjNvTXdJTklUa0ZQMVZ1VDJQeXBzWm5hUFlZVnVGSE95?=
 =?utf-8?B?YmpxQUlyWVIrOFlvR2NPcUVVM1AzbnV5elFUNCtXNmg5MTJyV2VueGhQcStJ?=
 =?utf-8?B?L05kT0hJUTdkTXdkSmJKUnZBenhwVWtDRGc4U2c5MFRzZ0FXK2dNOTk4eFNr?=
 =?utf-8?B?MitJUGlwcmFtSGh2ZXY3WnZrT3RGT1pLUEZMMDh2QW1KZEtvNUxWSEN4RmNI?=
 =?utf-8?B?UkxzcWFpSTdxUlVlL3BJampvVGVUNHg3cmZGR3JWY09jSzBpUHp0NmFjd0dl?=
 =?utf-8?B?U1pxcHQ0OExkRUpENU1mbDRaMm5FTTkzZHp6RVQyalEya0Zac2MrSUZTMjVx?=
 =?utf-8?B?QktuaXdPSWhIeFp3T1BjSkJ0cEc2Njdya3BHUngvblpMZVJuenhYVHUyMEJa?=
 =?utf-8?B?NVBqK0UxclFOOVFpa01lSnQyNlVtUC8vRWpFN05KOWhpQVZsTzFBLy9YNVVG?=
 =?utf-8?B?ZFZ0T0tYTHNnSlNCMVV4VWZTSGRKWjBzN1p0R3lhR2QzbVVpZG9TVmJzaVBZ?=
 =?utf-8?B?bWZTdWR6L2RXbEdQMEN1TFFVLzNuNjhkd3cyOFU5b0hTeFRhOGUrKy9zbmJO?=
 =?utf-8?B?ZGtoRlBzalVaaTUreE85TzNFR0RTNHNPVWQreFpMOXVRVlhUOFhmck1JVVJP?=
 =?utf-8?B?eVpSMVk5eEV1OGVCUklrYWwrY2d0UVg1RjZUMFRReDl1NVl5bDJjNEhEeXIz?=
 =?utf-8?B?QmJBaFlVaVRUTmNGQjBFUWphdVZjMnlmM0JkKy9QdDdHSGg3OEtITWtBOVFF?=
 =?utf-8?B?ZHFrOHROaXpDbzRNUVBrYldTd2gwQS9GR2RQQVhYaklxNUxsOFl4T1hNWko1?=
 =?utf-8?B?ODFXNWI5NlRyTElBQlhFMXJPYTcwUDY1UDhhcTBHVEJ4bzcwVks3V1htUWJt?=
 =?utf-8?B?TkZmS3ovRnJEbHMvM1FPakhqblJic3ZvOEk5R1kybDZtUmt3TEdMRWJZcjFz?=
 =?utf-8?B?RFB1amhWMWN0R0w4R0NxRnlnUldNQms5N09EdE1zUEJGazE5MWl0Y1VTN1hj?=
 =?utf-8?B?OHhYSDZzaUZIR0NYMFFWTUhnUGNPWnRBWnZIS0hMMFcxRm9jaHp0NFZIWlN4?=
 =?utf-8?B?ZVI3TGJ0Tm1DeWFiQ1ZrbWFnNS9PQzBNamZ4eEpMQnliQm1OSmF6cWZxMm1J?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8792A7981904AD42934F49C908AC3D2F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xOubRkJvX5tfWmNJzk8dYnYft8kTqcrzjIQCkwuIDXoSc0sikLnJ6D5ZDDJhmZOZ1SjVS4QnaSPQgDdhL/sbyRifBRlVBoQXeTDewp3aPn0lz/05y5dXm+BZfx5PQDc91KLf6+7DFQTN5bOuFVRNx6G2ve+27NBRYX5UYzH7A+yOfFjmNoHIhOU+KBbVfim7cN5HHMR8Xaw+/o6AVs4DArL75XVeH1KskWqFSnrqZa0NnuKYfYL+nb5d9D6CpbXSahKLSygvSCa8JFt1KT8rQY54YA6URzu2zohYIsbzcDpB8RkAcaymoK6FusNEC+5BGUiuZXjI7YhFFb6j1yhkyQWpOU1ND6kXvRBTlD/+B9EJlDBpPgNFS3yPBban563HwLSBveRdBAA870Tgqy8/AcuxIKG8tT7ae+vW/OoAhOfJPfbOBjItZx0D/A0J6RGzp1CoW0u1Cvf3TYuifkCaaWNFSFiL7rAExV5VkpU0mIPdpZahiOHFfGK0Hz85Nt3zEVrLIQA69MiLoN/ABWa1tvF1hIZG5B5JtCoil7Q/0DA/QhRl1TdT3/dJ2I6SHPmcghWJpyg6dWfAA8G+Jbt9zGPZayP1FyvZFwF8lZVEvjZQH3BYNpCo7CuLF7B5kwJiFMOWLgiSDwbpjH2gIs/hnLdg1f3Fjgu+tX6Q+PT2evdQ5WqUjUX46eoDDbAqnpp43Q1XdULHRJGh5CqwqzOebG4MzzrnKHrd1xXZZUsRCKFPyrQaFr3FmwYZ46ECRpr712rIoEru6SINdZOBO8Ayw7PR62Dc30MDrpWnuApJrDE=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2551a95c-17a6-4ba7-966f-08dbbe53ae0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:44:41.4019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9mk+BO8vwLFI0KGzW5BGsbOQ1WJmFg/aeuAoBWrnGulzk6jpgB7X6wJTnRVzbvVN13C8bQbNoimWCEr19DZ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10720
Received-SPF: pass client-ip=68.232.159.247;
 envelope-from=lizhijian@fujitsu.com; helo=esa10.fujitsucc.c3s2.iphmx.com
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
LCBpLmUuIHRoZSByZXBvcnQgaXMgYm9ndXMuDQo+IA0KPiBxZW11X3JkbWFfcmVzb2x2ZV9ob3N0
KCkgdmlvbGF0ZXMgdGhpcyBwcmluY2lwbGU6IGl0IGNhbGxzDQo+IGVycm9yX3JlcG9ydCgpLg0K
PiANCj4gQ2xlYW4gdGhpcyB1cDogZHJvcCBlcnJvcl9yZXBvcnQoKS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCg0KDQo+IC0tLQ0KPiAgIG1p
Z3JhdGlvbi9yZG1hLmMgfCAxIC0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmMgYi9taWdyYXRpb24vcmRtYS5jDQo+
IGluZGV4IDQxZjBhZTRkZGIuLjBlMzY1ZGIwNmEgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9y
ZG1hLmMNCj4gKysrIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBAQCAtMTAwMyw3ICsxMDAzLDYgQEAg
cm91dGU6DQo+ICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsDQo+ICAgICAgICAgICAgICAgICAg
ICAgICJSRE1BIEVSUk9SOiByZXN1bHQgbm90IGVxdWFsIHRvIGV2ZW50X2FkZHJfcmVzb2x2ZWQg
JXMiLA0KPiAgICAgICAgICAgICAgICAgICAgICByZG1hX2V2ZW50X3N0cihjbV9ldmVudC0+ZXZl
bnQpKTsNCj4gLSAgICAgICAgZXJyb3JfcmVwb3J0KCJyZG1hX3Jlc29sdmVfYWRkciIpOw0KPiAg
ICAgICAgICAgcmRtYV9hY2tfY21fZXZlbnQoY21fZXZlbnQpOw0KPiAgICAgICAgICAgZ290byBl
cnJfcmVzb2x2ZV9nZXRfYWRkcjsNCj4gICAgICAgfQ==

