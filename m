Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 457FE7AE514
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 07:32:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql0g1-00006j-Md; Tue, 26 Sep 2023 01:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql0fz-00006b-2J
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:32:03 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql0fx-0003VS-AS
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695706321; x=1727242321;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=WtrwHSFx6zXN26vxTgeqzPwBe/h4aU3aMfyqwbuuyXI=;
 b=vtnS6jueJ5LAmrV9qaTKXgNHfTspQ8Knc7oFATG6K54I7ScAd0GMR47L
 xlTX9AmeNSu1Zo5XBXgxuxeHUjYG8IUfrBgAa4NhI6YLWV85Pue+a+hwg
 g3CCmWjmTIrxD5jd4WM5rNo9dXe0dWdH5LCsR3vplPVPhD8F9rx8uv3uV
 YoeFkoyXwS7vQrY7VxzdWceu0C906SsyWCcbsEtua24CSnHw9iHMewpHg
 qmPChHybS92MP6POnQiWpHMtujRnVyAnPoMRWqkv5SIumPFvL11+yOvuz
 rUmCMsrMncb0wmH3GKR0rkDnjqxy8JYTPQKE1Lm2u0Kd6NKpuGbc1mW8L A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96860472"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="96860472"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 14:31:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgxIvV73d9NHrvgH2RsDt+nV3ynTAu1NpMX6Cb7pCn+2AoJac6cqTEpJxr5vODm8ghd/ZKL9t6Qt4EP85IXfvobTlQZVsobDSt4o+5rR8oh22b6YrVgtRDOmWNmoo/v0krmVcCMI1s7jmdfz9zpFR1ENton/AJ9LOKrYhg4Tnc43LJD2MMujgytIRPIqFx6/fKW9VEBQ9ABKp4ES9QnOia7efRE7gGrHp8BdKOqW5jpfmtDgoh2mPt/GRvpmCdB2IJqiPpmE9ucTNi8Y7G5P43P74iR/zltF8UsKYNVdz4DAkiNkFUbu1S4ApMDgyS1KTt+eAPBxztSiPAfYWoUPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtrwHSFx6zXN26vxTgeqzPwBe/h4aU3aMfyqwbuuyXI=;
 b=aoaepGLcuaDApE9x41jBbdMEvbvVasWScQBoQesRl9maKNEqIUKj7bfHd9y6b5qotYx8Gp3OBgxvhnB3zpKb0/EJIP+0t6AB5AuW5UI1FqK8lPtkbcBM7R4ldgMOafr7rHHpnzFp4KOWcMPa4U5mT76weE1ll4gvKvmqifLZgKIYC9LsNgne2z01ywonAPmw6bhC5R2ODQeUiAbbiFrNvh668eBWRMnUsJX1/DY4k904xkUfaFMniva+bDa7o45asHTvoxSvVF+3y37AanMV3W1AKurznX6Vm3vmU7WO1GO/YOgmvz1kIrYmj1d+VpK9zf/ddpFsdF/eXinkNtM7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYWPR01MB11860.jpnprd01.prod.outlook.com (2603:1096:400:3fa::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 05:31:55 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 05:31:54 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 42/52] migration/rdma: Convert
 qemu_rdma_post_recv_control() to Error
Thread-Topic: [PATCH 42/52] migration/rdma: Convert
 qemu_rdma_post_recv_control() to Error
Thread-Index: AQHZ6j8avgzttis6V0GOc7tEKuenxLAsoQSA
Date: Tue, 26 Sep 2023 05:31:54 +0000
Message-ID: <ac36e4c7-7032-047e-0ccc-b97f057efaa8@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-43-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-43-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYWPR01MB11860:EE_
x-ms-office365-filtering-correlation-id: 415b9147-6521-40c2-3acc-08dbbe51e529
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rd1NTm2RckVbRDnHWGKzE/rCfRHrKtVdDB7/g4oeF4wVOyNaWfeadP9WKAG+bic48QrGVjqexTbvj29crYiw5WJxCGoFa1s0uA2tTkx1ATbolctxBLKlpVweNp6GwE4EcfzxBUj3wSELsGN0vPi6SMNo21dHHOb4tgmIi03mFODVJeE2ISOj3BIiaqn2+7fxEAQsirMCDzyG1pxknzJUx6r9eKwDHI1l43fj8pBCEqh0RaRmwrOHce/zo7D2wfH8HyanXF3eKZMk4lHTEJRFc58K9HeWbz5Nd2GdXShQzAZBeVQyGN6ZSKPBE5b6uEgJ6+gpLea8FSIU9eiZ/ZUMS/dR3C833EVM7t/sm7nGSFiDA/AnGQBOaKdwN0Bx3MeN+oJdyHGa3Prtg3oO8AvPRNd/J370UGZlqOMLD2OcwRCInU4w7/6ASz7wVVtVLtPM0+MecsXsPDqqWbfTkWdMnzYPVUB1OgbR1ZtiaNeeriYGc3MUS5lq2oooFxXtS0FN2HzMy6WrLnELJK0H7imRa+KnqgiyacV01/BhuHQ/bFSRteg3FOQH4OaelNsGhZ4A0XCsak/RqfX5AEKnsgH5ivVAK+TSzJc+4Qytv7egWelUzmIHD0oIdI5VDDhg6FB9j+zazCQiVcCJhUSkMhDmAcwGEy+/HbpcsHAjf4glwGSwNl4I155exwajf4vOK3Sq9ffEBFZLyO5RvIdmInYCRBexXriY9T4pnWlPl8nRtK7iauMH33RWogDnrnn0Sfz3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(1590799021)(186009)(1800799009)(451199024)(38070700005)(36756003)(85182001)(38100700002)(558084003)(82960400001)(31696002)(86362001)(31686004)(1580799018)(53546011)(66476007)(5660300002)(2906002)(2616005)(478600001)(316002)(41300700001)(66556008)(76116006)(54906003)(64756008)(91956017)(110136005)(66446008)(66946007)(122000001)(6486002)(71200400001)(6506007)(6512007)(83380400001)(4326008)(8936002)(8676002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXdoM0g1bms5dm5vWjd1NUZoc0tHOERhVEdZekMzelUyK2RaUWhnK0tldFdp?=
 =?utf-8?B?SjhGcWFGQ0E5ZWJHQ2trbDVvWHlMNCt6V0RmQnBtazRCeEovRjUvRE1tWEFF?=
 =?utf-8?B?aTM4aU9SOUY3L0piTWt2U3ArZ3pUYjNpVHRlejZoOWhwZVRIS24wdkFpNmpL?=
 =?utf-8?B?Mm9BOTlmR3JZSSszZkV5Uy9Fbk9RMUZoRGIyVzlaT3FVV0NnWm5jeGJCcTE3?=
 =?utf-8?B?cnhQb2lmSHBYazRuMnllVURXK244bkxscndNUmlmbXR6c1Fna1VrdHhUaTNi?=
 =?utf-8?B?VFJrTXN3RU51T0VNL2Z1OUE5cDlFTE9vUGxCTkUwWnluRWJOUmkzMGxTQzZw?=
 =?utf-8?B?Zm1ucmZKVzRrekZQUndzQWdDYnZFUWlYYWs4ZUllQ041OWV4WG80UHdHZE1i?=
 =?utf-8?B?aC90aGh6akYveWdRMDAwb20yMStIcG1kQTZpd1Vad29oU0NieUpITzZ4dlA2?=
 =?utf-8?B?ZGxCNHZmUDNJSjk3cUg3TlNKU2ZHR05uZDRoYW1SZzZGWG9qVlZtekNPTGVZ?=
 =?utf-8?B?bkdPeUtpZVlTWEZoQzRuamZhK2ZMOERkYk5QMGNJMytzK1g1TlpHdVNVbGVY?=
 =?utf-8?B?clBmOFBoNlRiTi9RV0R2MGpaS2dsWEZqRkhrV3pLS2x5MzZLdlVJSSt6UEZn?=
 =?utf-8?B?YU5HK1lpa1VadFJBcWE1cy9sdnFrNDZFc2lmVHBxbXVsc3NsYUx2dmhnNy9s?=
 =?utf-8?B?aGVvM3hIVGsxb3I2Q3F4RG1WVStiVGd6WEduQWR0a0drQUxRaGNybkpUaStT?=
 =?utf-8?B?ZmZOZERDaUhKQjVmbU0yT0E4eU92NFNQMERGVm1BZ2RFWERLMnQzTG1wMEN2?=
 =?utf-8?B?WmN1ZkZrOVIxdktFODYzbU1IZmlQQytRZWZ6aW5XZEhvbldkdGZXSTFpam9m?=
 =?utf-8?B?UW0yOE5ROHhVTHpsdDNEcUhjbEhjTlB1NFM4UmR5Qyt3TUNhYXNDdVFOZkln?=
 =?utf-8?B?UUQzU3hlNXZ3enhKRGRSMjk2RnQ2WXRaTHFsdi9HUUhGTlF6R1cvaVIvTHVo?=
 =?utf-8?B?WHRROWZyaFRuMnZoV0QvZm5JVURiZkNrTzh6cU00c2dkSS9kaGJMRTlqMFJB?=
 =?utf-8?B?UzlrN3MyeDFSa0gweERlVzZUZGp3bXliblFJZmtUWnZERWlhUFE5OGJjbDRZ?=
 =?utf-8?B?Ykk0dDdSZzRJWml1eFdTK3N0bUFPS1VaY1V1RURobXhwUEF4WEtCVUd6OXE3?=
 =?utf-8?B?bWJvM3FXbUpWSDRHU2lvcEE1bzB3YU5WdFpjT3I5VnE4ZVRoM2hVayt5RXEy?=
 =?utf-8?B?MUtwdmJiNkhCaklKWHZvZUFNQXlxNWUxUlBaTlcySFRQOE5nSlJXK1JFWk1i?=
 =?utf-8?B?bnpUdWZDajM5eU5lMkZoZHExS1JWQnZwQnNRekZaQU5OS2x2MlZLRHBWV2dX?=
 =?utf-8?B?aEhtT1YrY04zT0Y5WGdlSGtHVkt5MGx4bEZkSmhxZ2pyUU1KcERRekl0SjA1?=
 =?utf-8?B?ZURKZVd3SzlzaGFabGo0c0lkNi9rQnRXZ2orUnVzK1dQL2VPZ1ZNYXBVVndE?=
 =?utf-8?B?WVFzaTBtalNncUhXUkdKL2o3bkpYZWZmcmdrUlIyM3F3NmhjN29IS3hLbU0v?=
 =?utf-8?B?YmM4VnMraFlQZFVkMHVtNmpsWlUzMWJUZXQrZE1uZ2JEcTZhUWxzZVF1SlNX?=
 =?utf-8?B?V21ndzRxWkFQNUJHT2gvMWc4V2tydkQ4dXVLbzFqRnRxZ1BieVBuS1U5N05p?=
 =?utf-8?B?cEFhYTg1eGUySmVXNnJQOXBibEMvOEhVSVBSZ1NRYzkyeTZLTGIwa25ORjRH?=
 =?utf-8?B?QlJTWjU4ZkdkNUUyaUlUN214SlZVRWR3Y3RjaWhCOEYvc09QMlJIUm1lVHB1?=
 =?utf-8?B?RjFIbmxzaXkrWmszclpBYTBEbFN6N1NYK28yeENsRHBiRWR0Q3hLM3JJYTJa?=
 =?utf-8?B?bkdOM3VYdG9jRHIwNGE4VXVPcUlaeDBnZlNRbVRFem5rOXgvd2tDeStuVHBY?=
 =?utf-8?B?RXpMVExBeWxoakVXd2dsNGVhV0t3SXpaUG5VTTlBMzBOeEpTcTVkT0pOY3dK?=
 =?utf-8?B?dGlNQlBGdEhjNGg1UDRJTGdKODZBQVVaZ2c5MytERUszV28vWUF5MFpUeHg3?=
 =?utf-8?B?emxKZlc0N2Q4VDBnN0NNaEsycUViTi9udGdLbWNsRjhHTjdWYy9yc21CY0Z2?=
 =?utf-8?B?bjhtL2FGOUdQUkpXSHhRODYreFI3VUdMdmdrdWNvZmFwSmtEQU11YmZTb0Zt?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E108B5E25A9534FB97DCAF1DF6AE859@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0lrImk8qyYm9hKJT5Z2OdP74PbP24PxROiots9U5iqdc28cS1S/UBHrtEYl7pWYojB552eUcwNf2HMjgEdCeLRwev9CJo+u/w+rdZgtpQHpF8+FksrlNvbn5qpQv+U83yoX2XB1VBQRgfqgHWSINVGj2SJcgDPM03q+JmkyAn8Q4RcpdLPH19ifNbgOQHrOZayeeNouGx22vqZJjwf5sZ9YoOeFQfEJVE7+yDCBOF5Guf3zzoiG+0jeUBeJK65UgO2yZ5o+k9Fyk/xKrX5gY8DLnlQRvPfaPgj0Cqnp6OiR/VLLvLXx110U4xSv9oDatxhCtMpAOKHyoC4MC6AV6sGWdTZhHL2RrlfqRrGxc3DrHqXsjVRkTh4d4YA9j+KIM3i/Z7V8aw/ETAG45PFhXgQRAUM6KGo+ERDIpERBQlB4ZTC8vGSUCWgB9BKafyk9NAfWPenhgtncbIOPD6gBkl01UNxpm4GAlQxwigCmsdc8lzyD7p1/yFcl/U2sW9VmSAOStNScc/MAtwdw3F1aFb9453lu0fmFKQElTIsFmP9NLZr9wVWhpb9s+kG0bK+5hLJo8f1Fbq9MQSfvrGDMvQMeGmvEpR9QSPrc5dhLsmQjVA/s4XZLmNJmPQ0vMr3Xz3CrCrPWPDBfTFmsxWm4uVyyfd8WrpWaQgUocNWbVKAuf+Lwl3NTIODmbKsGOlZgfofZrunmfn21oGtzfMpU07Uc/xwsFvTs5df5r8oIKDgMDxuDyWVxG3KbdP2niAk9DQpohuWDsl4W7gO9jYjveEtCphHoPAsAH/giBa65Jxfg=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415b9147-6521-40c2-3acc-08dbbe51e529
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:31:54.8800 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TmydkJjpZER2YTnSDsJdRL+qVHiAxT7ylEV/SK/zKXv13v00g8jjfemaz0v7GItf8apjRLEI6xDle92ih//aPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11860
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBKdXN0
IGZvciBzeW1tZXRyeSB3aXRoIHFlbXVfcmRtYV9wb3N0X3NlbmRfY29udHJvbCgpLiAgRXJyb3Ig
bWVzc2FnZXMNCj4gbG9zZSBkZXRhaWwgSSBjb25zaWRlciBvZiBubyB1c2UgdG8gdXNlcnMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgQXJtYnJ1c3Rlcjxhcm1icnVAcmVkaGF0LmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4=

