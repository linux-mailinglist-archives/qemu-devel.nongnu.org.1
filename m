Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 267087AEA2B
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:19:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql59A-0005SN-7L; Tue, 26 Sep 2023 06:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql592-0005S3-Sn
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:18:22 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql590-0006cP-EO
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695723498; x=1727259498;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=W31/ICDPsafEEvlklfSqEwU4ouEDn91eQBWZecXQLV4=;
 b=PHr7qydEhfJFIPrarPq6ZfPWZY8hMEWWz7DoicHxz6hMYX/f5OrFjdNi
 BgoBqASitwRzpuF6tDg5R9cKe/Xp9gpZmA8kah3Yl5NAeWjOeW26c8al9
 b9EKXOAG+hu/em3Ix0oU6RUWJWOPE58Mx5R/KAROKuJS7HtAUdf17C4MN
 D/fqs3ZuMj/ds5rsLe1Xxy966EQFqpb/Dalrt6B9jIFzGbA4oTPeFLuCD
 dTgQU9ImFoCX/Ri8g68moLZWUDROGqqH1M/osxtW3UC/9Dqbg/rqrcoBB
 d9EdsrPPAS2UnrxtI0cphz0wrKl1jVQ2rjXR1b7yk4Gnwi0I/Q8KAE4KJ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="97309658"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="97309658"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 19:18:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSzlhIrwXVaq5H7vYkFkWKlCRZnt5SvO6Zk5a19JyykVFhM3M+QVQ2KfbtnNw1AhHOYhpcD1LAlhIRagiD2+QyEBneHrYpX55RPmL7aojbVVeVhFWdh23+nxvgMR4X3Jhm3TYuuY7PC2tIXLpv5vvwwWv6+FpSqID59iKdLenovmFFX218nKHTjEWuch+0FIX9BQs3uS+Tx43eyjjYVOZiJbFRyk/8n7TmOzkdkWFKJ4xayRjkhTcXgM1pY4P706Y42LW63mPnuWHzRPgDCIXa5VadsFyaAWisso2iv6TeMRU0LQ3Cy1VKM7VOA6BijeFm6GFiVtcMfLSGRaJdIAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W31/ICDPsafEEvlklfSqEwU4ouEDn91eQBWZecXQLV4=;
 b=MSf1bnOsxMquP7gH2YBSQBugIIUwa+YYcWn7QBY2jtCk0ushW4tMIRGoZuxqDlYQwnPcVVboFrkmmquKOf841U2Q4rQsQWkrkQplyfoiCRNjQqDBdhYjoRgtV0ZwKv93mUlgb0k1klJK7H8S1mNMXr5aRNkFPWw3up1D3SQRtLQAEVMMPNakzpZYey3g1cfUXP9IQcCvqvJkusHydo4HcS8YxCxKgvCmcWvk591zze9xk4dzuH9v5CX6xsUTdvyXAG71v9LrbcDVxP4vV4BC3BF2YrysE1wMhxir4wIdfxqyVCCPIUZJ0ui/c7QxDWiKlffXHhH5wtdaI5X/JTx7Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB11372.jpnprd01.prod.outlook.com (2603:1096:400:3c0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 10:18:12 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 10:18:12 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "quintela@redhat.com"
 <quintela@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 26/52] migration/rdma: Replace int error_state by bool
 errored
Thread-Topic: [PATCH 26/52] migration/rdma: Replace int error_state by bool
 errored
Thread-Index: AQHZ6j74Mkjz3bLIcEGfFnt67L9lsrArG2wAgAAOxXCAAcbRgA==
Date: Tue, 26 Sep 2023 10:18:12 +0000
Message-ID: <70a030e5-e7f3-9c45-141e-a80589d963d1@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-27-armbru@redhat.com>
 <168b551c-0c91-fcd4-1520-6c8c483a0538@fujitsu.com>
 <878r8uenk7.fsf@pond.sub.org>
In-Reply-To: <878r8uenk7.fsf@pond.sub.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB11372:EE_
x-ms-office365-filtering-correlation-id: 04a507c6-e483-46bc-01d6-08dbbe79e3fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lumJHOFoWjmSSpYpevV3vIuGuXanZJhxl66HPpshiXuqqn+cYdU5qWBoZQSbZKQa7iTh5eyLYl6cWU+i/gy4ue7YuiFf/70wrck1Otr8qa60OBx3htO/r/NWAa2rMrtGxWrwopE5PS4NJFPMT3s8ScruW5Z5YrUj3kSpEGFtTG7Gy4gKurNouUVdY6V4vU3UpKiMiqUGup8E7x/uJdioQ+mCdWfAMlc11xkCSslZ2Zy6/faw8hTvnly/N/BMuJYqFR5j3Td7Kxuphx1dtOv8EQRLO1djDLsSJEwK7p1wSi5ehzQH84l+9+ZuYeSAfcbJu2/Fv9AqKFsfaKJ+s2pJQrXZHSDYRLCZUUz2PdmiG6/OoUHB7AyxxkMWxoA+OcV9xuz2/g5mljJ2h8PGjn5xhmtbiTzNWSD1C7EdC9hn70qbg553EXMTLSAm8wzSZYJCfZQAmkKqfMQw0jXQRhl+1/e4fCXkuIdZOWypUpduGD/Ofj6Yb8PaYV5tQwXiiVYbDZww2gI5BtSfajC2SXrtNWm9QgREfVazhSN9qlUfMf8cG1607/6Jj528kGJWHu/MyuLGfP36JJ7dWIJG+KFwBS0Rw7NFOgNWJ0RhjfuujKBP6fzZVBdsTOMZhBNN0H3z3DcpwCoMpbAsDcEwpIEQAmqCwmxqmj/8E6qMgRAkP4ntHSPo6MC/0KLRVTn2LTTOVpXW5GeQGBjlcA7eKtrmvQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39860400002)(136003)(366004)(230922051799003)(186009)(1590799021)(451199024)(1800799009)(4326008)(1580799018)(5660300002)(66476007)(26005)(8936002)(66556008)(316002)(54906003)(41300700001)(66946007)(6916009)(91956017)(66446008)(64756008)(76116006)(8676002)(478600001)(2616005)(2906002)(53546011)(71200400001)(122000001)(6512007)(6506007)(6486002)(4744005)(85182001)(36756003)(38070700005)(38100700002)(82960400001)(31696002)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NSsvejVIbTQrTHY1L2FoaWNoaXBCdzNpMFduUGxmUm0yanpqRCtFZTNsK2pw?=
 =?utf-8?B?TkxCTms1bUljK3JlZkxHbEJwenZaVUhWZU9FeER2VkJmUHkyMnN3NHhYQVds?=
 =?utf-8?B?QXZQZEVJUm1mVFUzK1IxeU9UdW9MdXh6dVg1WXBXcTZudXkwTWhhM3c5T1pG?=
 =?utf-8?B?TFdhQktZQ25YamUwLy8wNk93TDVzakU4eUxxc0dhREI2WkgyTGozUlRkcEpS?=
 =?utf-8?B?ZEdtcmRqTG04N1pzUUo5QU9xWlNTSXd1VFlzWDArQTF0cW9Oa3c3ZzkzeDFR?=
 =?utf-8?B?eG81d1VzZzdpbldUSnFRTWdSamdqdDVxTUNoUlpnZWtjVW5STTVqZERFUC9I?=
 =?utf-8?B?VlpudFJ6UnFuNzI4RXF1TW10dXlVczZad2FWbFF5WEZZRlBSU2hBVFhVS2FF?=
 =?utf-8?B?OTJPWVFyM3Z6czdvSWRldWNQaEVPSElYTTByTitWSU5MbjNka0E1Y2ljSDEz?=
 =?utf-8?B?QmJ3ZzFCaTI4UW5WRWgrK1h6QmY5UFFVOC9pUHFhNGphZTFIcUE3REROK1gz?=
 =?utf-8?B?ZGJwOVlianNmR3htTTNtOHB5bGZEK1BDeGhYK0hVY0duMFRwRXdiQkU2cnpP?=
 =?utf-8?B?RHZzWjVjQmR0VFloRUdjcnhQOWZJSk5taGhyUFNyeGlqTFM2dVpUZ2llenJj?=
 =?utf-8?B?bThMWTc5T1I2UzlISzdUVlBtcUFwaHRtaGt3aTgzbFJNN2dyRTNZRjkxSDdN?=
 =?utf-8?B?S1NaVGpEZlhiSUtTd3ZxL1JGVFFWcUZtdlh3ZTl1QWRUYWtKS052aVA2TjNo?=
 =?utf-8?B?NVdQRU1nTXJhZFRyWWIyVUNxM2tJbHMxVFgwOEVTdjZYOFdkeVhybTlSSWRn?=
 =?utf-8?B?TzNPTXNsNEpINjlQYmxPZFJUYnlTZjUrNEFnTzBXcmhib2pQVTNxOHBueHI4?=
 =?utf-8?B?SzExTVVQSmpZTjlXeW5GeUdQUmxhTDJQZ3lkWEdNbFBEamRaQ1FSbjAzS2Ew?=
 =?utf-8?B?Zk5DcGNrRE5pYzFza3RnZEx5a2g5bS9UT0pIUXhvZ1M5QitHNFRXaUNXYm40?=
 =?utf-8?B?VEFjb2NXdWlBZFc1RGZRWjJLT2xUYU5nd1I0UWR2SWFpL1FvNnVqTUxONWtQ?=
 =?utf-8?B?M29zbFFMWGFQakt4M2o0NngzY0daclhZelZlYXo4MVc5RUhpM3BlN3BaZXdr?=
 =?utf-8?B?NTk0aTZXN090SUl1aVdsbGE0Q2dxRktnbmpwV1lYSUJMdHR3ckxsRVNoQ0Ur?=
 =?utf-8?B?ZCtSWjUvMUo5YWQ0SkFmTzY3NWtGUTUzVXFUUVh6Z0NXcU9wUjJTQ2FTVEY2?=
 =?utf-8?B?Z3ZqTWIwblJlVTJXNzhwUUtlY0RDdWVGUlBKYkIrZ1NkV1d6U0lid0hXZmk2?=
 =?utf-8?B?cnB6N0Naeml1SXJSMzIzYnRnYnl4VmFRUlhINzFKTDhadzBlblQxZG9JYUZQ?=
 =?utf-8?B?b0dJdGYreFhGemhNTjlZbmowcVF0ZmdDd1h0NVM0Sjh3U2RKdjVzVGQvMERK?=
 =?utf-8?B?OCs4K2QxTzUzdmVKVTk2RmlxQnJkaElQNTNNTXFOU2U2ZytNV2lZR1Fib0Z0?=
 =?utf-8?B?djY4aStLaDJVZCtqWDJGVEFJbnBVaDNSajZGemhzY2lxYkI5a3J1MEZxR3FH?=
 =?utf-8?B?bElhSHlDblVxMDVRUmIrOWNlS3RwK21PNzE0cG5ORFcva0wxWWVSL2x3c3A4?=
 =?utf-8?B?aU9xMVBDS1oxRnFicFVxUzkyWitCVVRYaHZiM1NReEo3cEwvNy9OQkNSYnYr?=
 =?utf-8?B?THlTd2FTMzBIcmVPbGZ2QU9kZVp1Ly9qcmIyblUvL3JtTnhWdmdNamFyU0Vi?=
 =?utf-8?B?SUFSeEhKNklkODA2SFpIaGtMOU5tdlZIR3VpNUxicmxtMnR6MFJweE5md2dZ?=
 =?utf-8?B?eW1TU1BxYmZNRDJLdHUzaDVPblRQOVpvQU1aVGF6YU5MdEdrY0JvcU5pdXRi?=
 =?utf-8?B?aFIra0hpYzNCbjFzNVdva05CY3VsVk9yNmpxc1l0ZmdEU0hNSU9ITXVYVDdS?=
 =?utf-8?B?L0E4SC94TEJxVHUwOFRxYzFISVFLamhUMzYxMWFVRnc2VWdEUEZaNUcvRHAv?=
 =?utf-8?B?TkIwWEtuUTA1WnRGQXBFdmpUNWREc0UvUVpsU253b2Q3eEhpUGpUSVMvbFdQ?=
 =?utf-8?B?NVJ3dDQyQnNTSERPU3dlazVkNnZLamMyM0laL2ZzSFowRVhuUStYeWRlNGZE?=
 =?utf-8?B?WFg3ZnROcXlWR1NFTXh0cnZGNGVXOXUvTUtBNzRmWGxGWXhnQldyek14WHdB?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D49531261EEFC34BA44E45F5616A56E0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IHgajPTGskV9s5TJwhcDYuwzwzZFwsJTUjcAm1ozWFBJMZvlfnHTub8Die8H3LSKdOkohCzosCdiWIfBiuhfhLWWGaaAg24QRtWKDSupGqsvBfVmUy6fwBGYKLG3mFVcfdsMeQFLpBtyY+2wtUKQkZrzZH8xzgKLp56wA0G4Q6eM91YkTrCU/rnh/DSZBa38KQQegBtNTSnyhFh3oPuuAyNa90QiLr9Vxl4tlsgC8yWM1iV2HTN2/K/DSF6JE/3LfGN+xYB0zRYmN3tX+b4TWPrIXrkShBdXdo+fvu4IJgzjS+fgOuCgGEBVVrwd8i84rMAGz+I7WWM/5YfupbYfj5emxEl+2WiCXSZHEZ39Lajmgo+FbcLnXAhwMWGaGV6WGjONyknp6xlJGL/2R4iDXUz9+61FhpSVjhlwW33uikTpLTEWjEdzW12EBD9PF/krVl7Tj1srtfFhLOCaO6wUFJMqwsDf9Ny+MaZa/qy+dWutkrGDzb7S6AzQyn3aYM79npIzaL5MI6s07yvgSQtOk50T4t5ub//RoBEA9xOscL7vtwAx2VC/1k3O83nwBftUWCbtu2dmOpPllfhtjQL4PASTTLbDs46bjn5TParD5jtfLnsnQnIaoVzM3sHUhQicopbHIh2PAc0DMLs1Tb3fpbI0u+XRjY+o7YTDsXQIGzJf8/z+rU8IJK+kfGezss+HRtz6Z7wxMEGiB9m6zjHbuNm6Jz7XmH7nGg3gnSOl7KamRyFCBUpra67EZMI1m9TrO1fdtr1S+aMuHSwzhZTG2UNpwDcML5ZF88daCt94bZc=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a507c6-e483-46bc-01d6-08dbbe79e3fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 10:18:12.7965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ejn6VFLIIvFYNOSLOWKUhhyrflHQQYP+QMp/QviXL0LdyEDTA4Els0HTcEFmM9bisp/UiLOkHqStNH0mPZvp+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11372
Received-SPF: pass client-ip=216.71.156.121;
 envelope-from=lizhijian@fujitsu.com; helo=esa11.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDI1LzA5LzIwMjMgMTU6MDksIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiAiWmhp
amlhbiBMaSAoRnVqaXRzdSkiIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IHdyaXRlczoNCj4gDQo+
PiBPbiAxOC8wOS8yMDIzIDIyOjQxLCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4+PiBBbGwg
d2UgZG8gd2l0aCB0aGUgdmFsdWUgb2YgUkRNQUNvbnRleHQgbWVtYmVyIEBlcnJvcl9zdGF0ZSBp
cyB0ZXN0DQo+Pj4gd2hldGhlciBpdCdzIHplcm8uICBDaGFuZ2UgdG8gYm9vbCBhbmQgcmVuYW1l
IHRvIEBlcnJvcmVkLg0KPj4+DQo+Pg0KPj4gbWFrZSBzZW5zZSENCj4+DQo+PiBSZXZpZXdlZC1i
eTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4NCj4+IENhbiB3ZSBtb3Zl
IHRoaXMgcGF0Y2ggYWhlYWQgIltQQVRDSCAyMy81Ml0gbWlncmF0aW9uL3JkbWE6IENsZWFuIHVw
IHFlbXVfcmRtYV93YWl0X2NvbXBfY2hhbm5lbCgpJ3MgZXJyb3IgdmFsdWUiLA0KPj4gc28gdGhh
dCBbMjMvNTJdIFsyNC81Ml0gWzI1LzUyXSB3aWxsIGJlIG1vcmUgZWFzeSB0byByZXZpZXcuDQo+
IA0KPiBJIHRoaW5rIEkgY291bGQgc3F1YXNoIFBBVENIIDIzIGludG8gIltQQVRDSCAyNS81Ml0g
bWlncmF0aW9uL3JkbWE6IER1bWINCj4gZG93biByZW1haW5pbmcgaW50IGVycm9yIHZhbHVlcyB0
byAtMSIuICBXb3VsZCB0aGF0IHdvcmsgZm9yIHlvdT8NCg0KWWVhaH4sIHRoYW5rIHlvdQ0KDQoN
Cj4g

