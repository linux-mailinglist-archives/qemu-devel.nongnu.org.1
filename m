Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2E47AE868
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 10:58:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql3sN-0005hL-GA; Tue, 26 Sep 2023 04:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql3sD-0005gs-5s
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:56:53 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql3s9-0008Sm-A7
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695718610; x=1727254610;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7FBAKAu6cUBm1sdCsP5JgloP/1yyQZ3IQkzQqfeXqJQ=;
 b=ZkIvIyeQdCzx+m1zB+xTvD4f2JIXLaiMTuwfI81vLukOAD+GX9qd3xvu
 h9N/pg7fmkSd3/UL2VYNZo8ydyw2cwXFGazAHrxUijJUVcbBOd1OrRm7c
 XjxpaUbIeMdYxwddv4aRk6FDMmj7Nik8f4TfK4BC7K1+8l8FJeLSjgw/D
 p44b4zhCmNidvzu3YA4AtlpnJPpgjL6jkgWYW/rR3y86kiUxoHY/MHLKc
 +WKlmMFNx9M33eJAp9R7oGMukyQPM2yaa+aekEGsnQ893audv3c4TPDfO
 mIOJa2kr5/wkkVRP+PQJkqxFP17UNK9vMSST931a5bMobsESc8hCbRlN+ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96638355"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="96638355"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 17:56:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UH+Ju63ZuvrygYKXbU6D3Sxn495lNgRbfCh8iWhHccv/6/SzFWKEM1QaR8/xd3sa9hGdPHEd7YDBXs5ChXN61YCL8HIlFxpJTe3QM2vB+81G5XqgIDDOsZ7vLH9tZO/Rdlh3wzGSq/6VWlkBRpkWYy/im9brZlGj/FhAclO0aCXPmVUVwYCIEzj1Paqivp/k541wT/+MoJRt7lX9lPTlKFJpy5Sefzv7+CjwuaoZqgKdqxVpb8uF3SUf7U4uFTk8lHMfuUEjNvFbPxwOmk6ahK6Y3xisr8ssxhcAsW8gKNgAQHsrt+rahFM62g29WDxK8RcCHfOt8HDDyLn78Dpk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FBAKAu6cUBm1sdCsP5JgloP/1yyQZ3IQkzQqfeXqJQ=;
 b=GByCGY8XHta9vuNN5ZNlf8m4LCckGbecSyuM16asOq58H31z4wDgaY2pSiOEoVk/yxG9+6waFISgSsroPeczS6WSlRVALQJVDpzTD/V+3NZHC/Hy+8hRqngdY36erNbvR89atJrJxnIz5T7gZJbREifUgl7LjqlhYUgJwcaH/YWp3/niaA6TIBq0GRRDJf8l+BJTtVXJE4pFxioTRWeXedkZjgxAxEm48cTk0Xaa7qKKB/DmhDeOyLWZKz2INdjP1KxY0g52MWXaRnTb/iPry25Ehy4VhlIpRrx2Ag6epcyM4jYiX0C2OsTy2xG52ZDUoAOUVmIWBG/jIiUmKDGIxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYAPR01MB6156.jpnprd01.prod.outlook.com (2603:1096:402:30::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 08:56:37 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 08:56:37 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Juan
 Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] MAINTAINERS: Add entry for rdma migration
Thread-Topic: [PATCH] MAINTAINERS: Add entry for rdma migration
Thread-Index: AQHZ77UPHR0m8BSIBU2oVvqC1SatrbAsz0qA
Date: Tue, 26 Sep 2023 08:56:37 +0000
Message-ID: <8a275028-b073-5127-840e-0250f4090998@fujitsu.com>
References: <20230925133441.265455-1-peterx@redhat.com>
In-Reply-To: <20230925133441.265455-1-peterx@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYAPR01MB6156:EE_
x-ms-office365-filtering-correlation-id: 5dd8c432-e9e7-4e3e-f86f-08dbbe6e7dfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JQhKfQ+ICNo4VlFwATpdhA0FFFeDhW4MsjQeom6RaWVfzpk/dYoHRep5hzQ9SnsYoPN+o4MzIODivqCsfQ7IPxKIbS6XRyigIDnxJ5xK4RRYZe3Clm/Ked5sSQYJHNDyAbXCB5Y10ZwBX394wq8C2FPYDJ1ZYgqnDX8NeRFtvg/fRxHiaIIK7TnyLUXHUnLbnMtWJz+kQpiLKjki4rX0SufFtZtxPatMN67pdWtr+4kTBi9pbjFuCVo4BoI2e4U5IFrSrOPx81+2fAyVknEU+U6gjenhCdx3LovS0u5JjBJPZxXL2UZgQEkXf6vx5icVlU8+LxJNKFS3nNsXiCPaKSBZZnhWsKg1o3U8y7AgdzRRgLoigcW29TxSDKO2Q9zdn20BPi2jE92Jh6GlxFgb5wB8I11KjeCCa0YBLPOoK8WIpqpDddKT0wTyG/cA3QwTCQsGduwx8be2+6Y6niiukf3JdeeqX61h5tPiFFcNBd5PP6vmFCWbD6IZ6psgX/UevbLTYVKGJxFZHLtA9T1zTJ0XBbZu3e8nyO/O+YfrSyw7yAPEsqywhxyja+e7tdzsnnkkkS4FAQwBruahdORE+W8kfMaMNx7QdBNtUkAWFuuoRi1plT120EbSvsPMB4Q+nLhajBCTZKmxg7ofth9KvhwnRsSfswPEMB4RKYGIqnfBaiob489GidsNr71iXo8Z6YAXPzNMIVBSsCljYAAFxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(366004)(136003)(396003)(230922051799003)(1800799009)(1590799021)(451199024)(186009)(6512007)(26005)(83380400001)(2616005)(1580799018)(31696002)(86362001)(36756003)(38070700005)(122000001)(38100700002)(85182001)(53546011)(82960400001)(66946007)(66556008)(54906003)(76116006)(91956017)(64756008)(66446008)(110136005)(31686004)(4744005)(2906002)(8676002)(4326008)(41300700001)(316002)(8936002)(71200400001)(5660300002)(66476007)(6486002)(6506007)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEhOclZZVFpPN0dDSVowSndUT21ZTDhBK0xPdE9ZYjJ1MzdBNVNacnBvL0hI?=
 =?utf-8?B?YWhGMzA5SCszcGVBVk4xaWVwK1hGbEE4QkdRaWx4anNjN1dSK2ZidlZ0bjIv?=
 =?utf-8?B?eENFY3RQQjZpZHFETE9udk4vVTkyTHcwUmplS1VZdnFHRkkyM093akxmKzRk?=
 =?utf-8?B?azVJSTdaQTJuWi9tNUVFc1JFOWFDczFhMG9ib3BxYTJsSjZxVHlnTG5FSmNY?=
 =?utf-8?B?MUs1QU1JdXo4YjhqWU1sai9hQ1o4UHlDUkZ0WlRFYWlEd2R1cWFVSnBuNEhp?=
 =?utf-8?B?eUhTUGN3S3JCY2RqWkhKaUZoS2VMRG8xNzMvdi9LejFWb0pjNHMvQk5ZcDdw?=
 =?utf-8?B?dVpOSSs2dXFHZDBSclFRVDNZb2RrUlQvditXSGNEdmtKNlE2WmFvRVV1MnJE?=
 =?utf-8?B?UTh3OCs3d3RFT2ZOaWJTd09lUG5IZTFqY3d2b0JNQi9FUFV2cjA2Nkp6NlFV?=
 =?utf-8?B?aXZrdG5TZUpocXlvVThaRHhpOHhWcWpwYVJjb05PMmJtc0ZUckFJT29MNHB4?=
 =?utf-8?B?YVR4ajRBRkpNSUNzdlBsU3FTQmd3a2ZTdWh4aWxuWjg3WE4yd3pFbldFODhM?=
 =?utf-8?B?SlUvVTNGWkxEekl3bmYrSjR3OW5KT0UyM0kydFpyTWx2ckZ2K0dPN3ovVjFV?=
 =?utf-8?B?a0t2TU1Fazg3a0xpYVFmRmdOMXN1TDlWOHZZbFkxNDNmOGxjbzdBVzVURDRp?=
 =?utf-8?B?K0l5bzhUb1pNZkp6Nkx2UEZwTmpPWmo2eEFVNEVtSzhxWUdXWmp3SzJYQlBX?=
 =?utf-8?B?UlZUdEZpUTNQM2ZJeUI0dkpYK2JJc0g0c2RyZ21OZWNXTUV5QlkwSEdzbXdE?=
 =?utf-8?B?UGRhd1R3eXIwVnJxV3JhTk9FTnZxbWh2S1ZPSTdCRlUzVCtYaWJHa3NPU0dR?=
 =?utf-8?B?a2pBdWZpNXF1VlExS1J3NWdzbXJYdUpaTEc5RUx0Q2NJdWJHbzBJWEJqZjFt?=
 =?utf-8?B?QVVFeWNVYkRGTnMvMEEwZ09wTS9SaVZldkl0M09OVitnT24xV1RhdkVwcHFp?=
 =?utf-8?B?YVNlcUhKY1U3UXhYNy93V2VJUUh3N1VjeDBnRWJ6TTRtOG1TOWdQb0ovZURI?=
 =?utf-8?B?d3REdXlIYzJEWGx6WlBwZTJEUldwbUVoYVh6T1BxWDJKdE1lOGpsamtZWDFN?=
 =?utf-8?B?OVg1c0E4Z1ZnTUJvblJvZTM2S01lSkdQaWRFc1pPN1pKdnVBWk0rMSs4R2RM?=
 =?utf-8?B?RWhBbzcxQW1UYWo0Wm1sRWNRL2tKV2VXa2dWdEdJL1FuQVZqOGFGdTY2N0F2?=
 =?utf-8?B?bnpoaWQvcUNjUlhKUW5sem5HajY5RVczaFhaMmtpK0ZPcko4a3dZaTZFcXJp?=
 =?utf-8?B?ZVA5dWV6UUJ3cHJHYUZyM3hYdVdFbFR2TWN2YlpZN2FRTE1Dc2FSNUpkcW9C?=
 =?utf-8?B?TnZjT0dVSVFNa2VoTlNOOFRZMWQzL1h5c1NVNWFnV0hKK25BSmNTRllTaXps?=
 =?utf-8?B?S29JK0tMcnE3bHF1eG8rckQ4aHBCR0t0d2JCNlZoL3lMRjZEZ1dlaStlaFRq?=
 =?utf-8?B?dWtqbFZrODZJTU1zcm0yeS9kT1g0RnJaY3FQWTJnY1hlMmVCOXhYblZYdkpm?=
 =?utf-8?B?Nk55bzBWQUJxQXEwVDd5OWRUQ3BsbVRhaktrV3FjV1NKSHlDOXJEREIrUThX?=
 =?utf-8?B?d2d4U0Z3OTRXdUxpN2pFTnJIeGx2R2VBR1k1YzZsOGw1d3V6RTlXbU1nNW0y?=
 =?utf-8?B?dGtKajMrNTZhMzBoSC9kb3I0RVkyQjRaRHNwZ3VjKzBmOVVlOG1DdDZicENI?=
 =?utf-8?B?Q3NiTHArdTdDV1RlU3MxSXpmMWFINFYvTnhMNjNDb3JwT3psWFBXRmoxWUt2?=
 =?utf-8?B?eE9VL29IVDlab2tJMFVBQ2s3YytyR25ON3hDbHJMaGI0eFFUVmVQSWdxaHRY?=
 =?utf-8?B?UzdPV3NrYzVJYnlnQW1tRG5hRFc1cGYrWm9aN0VYZ09IUE5pcFR5MzY5Ujgw?=
 =?utf-8?B?OFVHcXJXYzUwVFpJbFFyV3dvcEtuekdWaCsrY2VmTlBBTU4rS3F2STNwcHBz?=
 =?utf-8?B?UkxiOCtXczUzcVM4dk1hUjJIZnlLN1RzV3hZY2FlUmlkU2UrQ0xHNGZwWmJR?=
 =?utf-8?B?K2duSFJqeHc1MlNJV1JPRG9jT2I3RWxoKzVxNFhOZCtBWlZYUDhCMHlNL2FD?=
 =?utf-8?B?djhTZzdDVVhaQXp2WWdJK0NGdndVU1NZczllclFYOEkxQjFZYkFjMHpNK1pj?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5C566A9DA3BA24A8249A8B0BA0655D2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fW7Fcc+yEohgaEdgjDgE50UD9tRXjEy75rQNdwu+fU3HF/Qvlzlu/U/Z0usr27rjGLIYSbsbENmOUG+UvTzrcLrry67cMMuYGxKdi7rSSbZ6N8R81L0hEwYaUA5F7FABiuHfR+Bo61Dma69IAF4TOhF2wIcUvZMvrUu3QOsNQCpr0ytcnLZk5ASvnixGSaZC4E8eNn3qz8ow1wOYtcSf6LekBjvcJX77lL3aJD/vqDjOiFGR2yDVs/91UzrEs11KbXXvjes5jEed18MqPAktsASDB/rcrNRkNHXIgsa8WdAwWmJiH42iMI544amZBTWmWu5H4b2Wf56wKzXKi9hYp7iGbEzQGbCWd1kj62HAokEVqgway4/xJWNZ75GVdraHWxv73rdMiCotTuroZ9q7UsDvLenBdmZq3toqyx2r25ofjj+Uask77vILPTflbhZor3dwmLzzL4d9hHHZrOsJJLvPc0wPG8IMsyHWnMeytszRYM99++KlMBBfdEMopO0bzN5StKoaR//uhKvSIti8oCqSOWy9HE3n8ZB0NR5gi6NkeasVW1ZJvXh4Gg4+uuRkxjvxKZC+xs28cYve5+wNf8g3/8hEUKX079khRTfXg14XzrjGzaMeAYBZuMYyXFwRxHnw0a3XCgToykdlCvCLIxW8sqXRD6wsrV9V4tvAJWmoiBV1TdDLm7sfvgji9BMVQ74KrcR+0HF+gI4ktOr4hPp4ks2z67pVWNeef26WlCn50eKOuHZZsE2XCbyv0jD3BFBclzmasSGCPsKevGLCrdEGbvFREe3j3xWtzQLRVRWhoRUhm2+De3EiFR0lXoOU
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd8c432-e9e7-4e3e-f86f-08dbbe6e7dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 08:56:37.2109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ic9yWrCx5pWkLaf41NUfdxDH3mQ1LRsH9zO25GeCQIZj+B2LoBpg+UmsHHJZMDpmIhfhSA0umtHYOohpef5eWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6156
Received-SPF: pass client-ip=216.71.158.34; envelope-from=lizhijian@fujitsu.com;
 helo=esa17.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDI1LzA5LzIwMjMgMjE6MzQsIFBldGVyIFh1IHdyb3RlOg0KPiBJdCdzIG5vdCBvYnZp
b3VzIHRvIG1hbnkgdGhhdCBSRE1BIG1pZ3JhdGlvbiBpcyBpbiBPZGQgRml4ZXMgc3RhZ2UgZm9y
IGENCj4gbG9uZyB0aW1lLiAgQWRkIGFuIGV4cGxpY2l0IHN1YiBlbnRyeSBmb3IgaXQgKGJlc2lk
ZXMgbWlncmF0aW9uLCB3aGljaA0KPiBhbHJlYWR5IGNvdmVycyB0aGUgcmRtYSBmaWxlcykgdG8g
YmUgY2xlYXIgb24gdGhhdCwgbWVhbndoaWxlIGFkZCBaaGlqaWFuDQo+IGFzIFJldmlld2VyLCBz
byBaaGlqaWFuIGNhbiBzZWUgdGhlIHBhdGNoZXMgYW5kIHJldmlldyB3aGVuIGhlIHN0aWxsIGhh
cw0KPiB0aGUgYmFuZHdpZHRoLg0KDQoNCkZlZWwgZnJlZSB0byBhZGQgbXkgQWNrZWQgdGFnLiB0
aGFua3MuDQoNCkFja2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoN
Cg0KPiANCj4gQ2M6IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+
IENjOiBKdWFuIFF1aW50ZWxhIDxxdWludGVsYUByZWRoYXQuY29tPg0KPiBDYzogTWFya3VzIEFy
bWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPg0KPiBDYzogWmhpamlhbiBMaSAoRnVqaXRzdSkg
PGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4gQ2M6IEZhYmlhbm8gUm9zYXMgPGZhcm9zYXNAc3Vz
ZS5kZT4NCj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiAt
LS0NCj4gICBNQUlOVEFJTkVSUyB8IDUgKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0K
PiBpbmRleCAzNTViMTk2MGNlLi5mNmIyMWRhNzUzIDEwMDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVS
Uw0KPiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtMzIxNyw2ICszMjE3LDExIEBAIEY6IHFhcGkv
bWlncmF0aW9uLmpzb24NCj4gICBGOiB0ZXN0cy9taWdyYXRpb24vDQo+ICAgRjogdXRpbC91c2Vy
ZmF1bHRmZC5jDQo+ICAgDQo+ICtSRE1BIE1pZ3JhdGlvbg0KPiArUjogTGkgWmhpamlhbiA8bGl6
aGlqaWFuQGZ1aml0c3UuY29tPg0KPiArUzogT2RkIEZpeGVzDQo+ICtGOiBtaWdyYXRpb24vcmRt
YSoNCj4gKz4gICBNaWdyYXRpb24gZGlydHkgbGltaXQgYW5kIGRpcnR5IHBhZ2UgcmF0ZQ0KPiAg
IE06IEh5bWFuIEh1YW5nIDx5b25nLmh1YW5nQHNtYXJ0eC5jb20+DQo+ICAgUzogTWFpbnRhaW5l
ZA==

