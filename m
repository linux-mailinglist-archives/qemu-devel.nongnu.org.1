Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F02AC7BC4D1
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 07:36:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qozxs-0007B3-D6; Sat, 07 Oct 2023 01:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qozxm-0007Ai-D2
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 01:34:54 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qozxj-00059o-Sf
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 01:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1696656893; x=1728192893;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QJNjKymaZgJzEPeR+aETRAno3ExyVwT49CuF6TFuRx8=;
 b=aAExEg/BI+cFehIw1HmPwRNM7kvqsuigr427cXRDH06OjQGVPRs6LZS5
 wW5hD8zD0AjF/WdSCbTRTv1xCwu3wr810FZ+TIwxLlj+P6E05939vB0B7
 naOeYvIIHwKhzWYsgEyT7FFznvX3dS324kSuj7J/22ZyOFRTS91O8RFbt
 vOUE/uqXI/3tYF8FO3GC1qeohN5J27cQ7MSB6q5B8W/PdXWQqmSasexwL
 C6HcGlryOXU49LpKmWd46hGgv/Bydmjsed/x4yueDSGA0HbOQAcA6jWyI
 g4m+6htzDmcCRj1Ls9CxuHnAEjhOaUxxidOFsT9dwXWde/Rc21zV27bdE Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="97911534"
X-IronPort-AV: E=Sophos;i="6.03,205,1694703600"; d="scan'208";a="97911534"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2023 14:34:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiAOgKKtAxmGEdvkU270YOy1VpGFnQJjAbSt3z3P8cWwQ+e1gSVheji/vccjKEPwfYikXT35uM88WmvcE1krhFNlzA8/mPBtiSisAggLAxoS4ZwfoMAkud5ZnW1F5ygyYkGmS09eFdGDqpC73NPeVpWIkwr9fuWFT9q4dKvHEG8huWwWyX+RKx516o57fSPPHXYamizDM6j1eja36EmgV+x3TLman68uuUSWB56Ftm97ZjY76dVjUEFkhakDTsuDGWDukHjE0wbIc9hSd7q3CoJfXpPT9GBt38KbETbwwhqA6kES6JSis9VNAWXx8mTm8MDQ60skuxX7x61xDHJPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJNjKymaZgJzEPeR+aETRAno3ExyVwT49CuF6TFuRx8=;
 b=eye4L7SjQFDPelnmesZHfWS61rJE29KAerH+vfKViF/W1tblbXVD+2Y0r/2GR4oZNmWHmB++tO9u2UulPm6lQ8bsnEEP+r6szR+Xx1B1x2WKcuL5VlTPjTeil1dGEQFJ2IL/AYc5lD431ixNPXUaJdqz9kHwlVkP2x6kpb7yJSxG2haaaZazRFrefVZSyOUdNM1vQ6OIVsg8rsxIAJKyQIqvP/kY4LvmJ6ATndYwPXHdE4EUTaMNapU+jvbl29fSv8PCkMBkXxDZRZX0DvLB2l6xSBprwYZQ5HZ2m/ivdX9UkMukTGe8woy9FqW0jkNImQvRsEWnZGyIntWokEQLRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TY3PR01MB10355.jpnprd01.prod.outlook.com (2603:1096:400:253::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 05:34:39 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 05:34:39 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "eblake@redhat.com" <eblake@redhat.com>
Subject: Re: [PATCH v2 16/53] migration/rdma: Fix or document problematic uses
 of errno
Thread-Topic: [PATCH v2 16/53] migration/rdma: Fix or document problematic
 uses of errno
Thread-Index: AQHZ8g6OaJmXu47xV0asfIb8KCocfbA9286A
Date: Sat, 7 Oct 2023 05:34:39 +0000
Message-ID: <b787af62-38c6-f92b-dc76-bc7ef73e261e@fujitsu.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-17-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-17-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TY3PR01MB10355:EE_
x-ms-office365-filtering-correlation-id: c5e3021f-516b-434a-1dc2-08dbc6f719a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /zlTtcbDFDPe/G2ZxU31PMdauyYofMWhUyV25TKmS+P/XQ0HVbjgq3cunMRrXw/XPR4TqoxaUyk4aS8f4Cd0ju0PNfGNoUv3bFiAYRz6YhqqyOXtrSRItrjz6J5XXLCrZ3aXx9v6gjBfI970JWK8W1o5XejKAa+JK9Jnpeks1BoubEatvfjsgKBg5aRxeAw+U263fH1OGgSHdxlgHp+zldATJekFUbacz2IlpH793nm/sDiRHGgAF/WLxU86paZtp19y78xc1zKfz/4I/bjIDYNTfuSn6/T2SqWPXOeIdN8f/sK0MLEW9oLXmvSeUKK0QerXqPoudYTpV5zaR/ZZctjUByVAY8fPplPSt9QD/6zT1UDXdfYxWylRbjjDeC0M7KHlvsjnZ8XptOx4vJlUaSsDM10xoxAoU5E29XXKr440Eg/EVNUMog8RUXUTyzUxcBGU3uzjMyJMVSkQ/ClEdXej62R4VedxJupzNCayBYiySCg2YQyduZUZ9w0JSiVCRpc9VLHY+rRn1cz2ljXR5txsFF/2E3GbAJ5hgjnIbGvCFC0LqJGH63RB33a9jcnZ3ugQ0E+zvLNPoVTsSrvEKz1qQVsgP2L0DkyZQTs3xDEUguRLoARmSyD4R0AJRS+3PqdJz1WTIysWkdSRHE1vZ2NSJXW9pqW2SnSvSmQ63V2eTziKoMo2L8UDQzwcep34jeBj+eROmsfSveuaH06yDg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(186009)(1590799021)(64100799003)(1800799009)(451199024)(82960400001)(91956017)(110136005)(76116006)(5660300002)(83380400001)(966005)(41300700001)(86362001)(38070700005)(38100700002)(64756008)(8936002)(478600001)(4326008)(8676002)(66476007)(66946007)(31696002)(66446008)(66556008)(31686004)(316002)(54906003)(122000001)(26005)(2906002)(6506007)(6486002)(6512007)(53546011)(1580799018)(36756003)(2616005)(85182001)(71200400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjZOQ0ZGN1lRVW5JdTZSV20xNzkvQ1pub09oV25TZFhyVjkybVRqLzZrc0Zv?=
 =?utf-8?B?RHJzUXhlZGN3NCtyWndkMEx0WnQraDk2ZE8zUHBya0dPWmNlVTRpVjBXOTBT?=
 =?utf-8?B?czlFa2xPZnRyV1orRDArdStRaXAzWjVNcUxOVGZHTHRtKytEaE9IeTVsSHkr?=
 =?utf-8?B?TWtlTGp5b01aWUowTTF6cFpEcThRS1dtUTBlUVhNaGYyVUt6NGltRU5tMEJa?=
 =?utf-8?B?WVBiTjc3KzhpdDFXRWQ2WVpIMXVqYzJlMi8xdFdONEJNSVhTV0tra0swcDZL?=
 =?utf-8?B?R2tDUmxSN0JDbk9PbzNsekpWUUlNbmwvRStyYXhlM3EvYXpZYW5xSlJwc2Yr?=
 =?utf-8?B?UFE2Uk1QaDEvYmFjUXM5c2QzRUdwMEhvN3pKaGJ2WllXZ08vQTdTZmRtdnln?=
 =?utf-8?B?NEd6aU53ZU0wL3BqVzVxcHcyY3B0ZE9UeUdoc1FuV1lkdmtoNFJyM1JDOGhE?=
 =?utf-8?B?bUtTbXNidyt1Z2hOL003TU1lSG1uVmdSTW1rdnRwZkFYY3lkc3JwM3FKaWhX?=
 =?utf-8?B?ZlFUVUdCdEhUTVRmb2V3eXdwekUxNjczVDdud1ExZkY5Sllxb1o4QmIxMXpH?=
 =?utf-8?B?WGgvaFNKSzBpeXNla3gycFh2V1ZndnFMSkdMTVJGaVY3ejRGZmNxV1BOdVVn?=
 =?utf-8?B?WUlKcjRrRndKMkxBR0h2SE1SWDE1NmF0akF5Ty9DV0g4ck9vYWRCaWphWm9i?=
 =?utf-8?B?dXE4SUdFVjVhOG5GR1pQZmJ4TUlqOXdyK1Y3NXdPL01Xejg0SXp2YmRPbmVW?=
 =?utf-8?B?MGRFazZVMGpnTWxKUVFzT2hLMTBIbERwbW4rVmtZc3RZc2pyUkdzMjVLM3Uv?=
 =?utf-8?B?V1hyeW1PQ3ZXN29mZHp5SXJRanNrSTF1WE5hUGFrWHRaWS9lKzFvWEZLd1Jo?=
 =?utf-8?B?V1N5MlQ2a0R4dXEzSnZtcXpVZjJoblRteUE5S2RQODVOVW1VMnpLbVorem1V?=
 =?utf-8?B?b0h1R0p6ZGw4U2hPQSsxc2R3V3o0OTZxcmR6bmROMmdRRm5nMklwT3kvc1V3?=
 =?utf-8?B?b0lDYWg1Vitsa1l2UDQ4Z2ZuQzEzNVdjSWZvZjA2aVFveTJIUS9RK0RySDdK?=
 =?utf-8?B?WDdldmw3Zm1kSGs2UGl6WmJPSGFSUHIybUladVZySURNaUkwY1hKbTZIZ2NH?=
 =?utf-8?B?MTRBMnBXa0orMmcyMzdPYVFwSXRyY2FFemRRdFlzMnVEcGdTWFluRnI0TWtK?=
 =?utf-8?B?ZTdWQlppeExTclRDRWNnenNVRW9mZ3VJYzNkTDNNN0poVEFKaDUrSDZnTUQy?=
 =?utf-8?B?a1ZBUWljTk9HWHh1YWZSUjd6NDRoVDVXcDJvVVd2eTdTN3NrS0c5em05Q3h5?=
 =?utf-8?B?ZXkyVVNqU3RuQ052KzN5d2tyOUlwanNuRFBtOUhRaGR1NWtkZW0wNS9ZNWcx?=
 =?utf-8?B?MUFxN210TVorRmJaRWtXdnQ4cWRDdHc3dDU2TzRiWVRTMDlpYWRSaWhaLy9B?=
 =?utf-8?B?TFk1V0REbTliVlZZaGo5OWxkalpMTEtDbU9WaTNZYUM5YjlYQ2REUGRzVUJM?=
 =?utf-8?B?b0VBTFV0ZUJJcytYZ0hoMkFFRnhkQXFHTWdyRlBkL1J0WEFNTHI3WWlCQWdq?=
 =?utf-8?B?UzJGN2dya1BsUEp0dFVlUHZadGdYV1pHcDg4aktUc3lkU2xWR1gvOEhhaGZn?=
 =?utf-8?B?L3NDeG8zZnFNd1J0OVZ2R1Jwb2N0am9heHBSNHk0cSsvWEE4S09BdTBNUk1U?=
 =?utf-8?B?VEcrMFdGNVVEMDJEV2llMHdvOCsyTnFGQUpCbEZoRStPR1JEN1BzSUpHekt4?=
 =?utf-8?B?Q2V2QlY2R0dwcWwyZmR0ZEZaZ0NMNlVsYUVqQWQ2czBsblhsR3ZBTk1hZHdU?=
 =?utf-8?B?UzVJcTRFSEcvdXZjYVQ3NkxHZGJ2RjRpQldCTlZEamI4ZUV2R1M3bTlPZ1FO?=
 =?utf-8?B?KzRVR1ZvWjRzandKcW5UQTlvTnpwQnNxcDBTVVZpcUNhS3JjMThFeHFtNE1R?=
 =?utf-8?B?ek5jRU14dVNXYXRKQklkb25CUithUkUwYW9sUkgvT3dIMHk1aVNHODhQY01P?=
 =?utf-8?B?Ri9DMzVFZ2xTVkttUWpXKys0U3hNb21qMTVXYkJCMEs2a3FYY2hLanJtc3NZ?=
 =?utf-8?B?a2U0cFQ4MWhJb0ZnRDVQYmpSRXo3QVNNVVhReEpDSjNmK1c4QWlqSy9HeHk1?=
 =?utf-8?B?dEYxdTNmZ1F6aHBUMzExc3ZNa0J6bWtkaFN0U1VQaFo3YjFRdmlEaURRL1hH?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B62194FFC593774998A855EB75DF8506@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BmZ2D48v3oqBF+84ZYnXl2sq5zjHa75eZuI1+9MjsPTbdkJJiEzLDRp6yEArw7aXBVqFlkkjHR4jEgTcbhhyc5nIQaGjdr/+BnTpaYNNyicqTy+Kr57TvKQR+bLzcf2PYZc+R74s0XDN0biNNSV3+81k4EQm29dO8v2GzDM+YZ0DFb1tC7pl/kMRF8Yn5tzUlWvWLImgkBM6oRkZYLNpnF0xW6bOoEoQMUmaf04jVCOFU5jiy7k8cGwSSJb00pEcppRLVKAWHl4BwuuWgInMW7qrsNP0GsJTrpb2HLYUmVtDpwx9PxxkY6QSYfPWF75aq/Wimer+W/zocGtZy6/NeVqTiiAVkz/6E1yXwuGa6JklkYg5sNsASebVoDplSvhxzuhhbxnuUtmkMr7asPfKnXiBEoj9Jaby2fzFT1EJ7GGryEB+RVqLqTz8ANeDLYoQQAg0A7NHEgdEe+OlZf+rPq5Clbn/vbHrlCTOVdgLtRJMxwpnegSQaYgNqTGRHDm4GKiuZDCE6NOVEewLE6IwCNduS8iWWDPX/bL4hJd9uE22i830gxDmyCKqt1XUN8pqMJVjxUr7WdgovbR8t38PjpkiY3qOaHWpE0meTg7MiUZ/DqbMy9Nwu2Alu7OSLegian7FO++ReF5w1mOuM15LOfGtABsc9m4zpDeZL5eukwl6QOiQhx0w3ZNe2jYWJF1+aAa+J8+E7DMak2rqb/NRHJkR1HtHlGQbCvnrdTTyy47GKBzVJZ0OLOCKwQ+4DrrF+u/NWSdf5xlOosoGtreFEKR3lTOuWYfC3K+Ts7HhMzxMtFvu0/hZiRWys7UHYVfa
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e3021f-516b-434a-1dc2-08dbc6f719a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 05:34:39.2030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AV+FWBQhL/+A0I/Gp6H0rzl5JG1AfCXtIrlyX+d+IpXJZ3sbWcePhIJQ0nuFT8GS/WXFRwi4TCBpJoD4cI07qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10355
Received-SPF: pass client-ip=68.232.156.101;
 envelope-from=lizhijian@fujitsu.com; helo=esa14.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.797,
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

DQoNCk9uIDI4LzA5LzIwMjMgMjE6MTksIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBXZSB1
c2UgZXJybm8gYWZ0ZXIgY2FsbGluZyBMaWJpYnZlcmJzIGZ1bmN0aW9ucyB0aGF0IGFyZSBub3QN
Cj4gZG9jdW1lbnRlZCB0byBzZXQgZXJybm8gKG1hbnVhbCBwYWdlIGRvZXMgbm90IG1lbnRpb24g
ZXJybm8pLCBvciB3aGVyZQ0KPiB0aGUgZG9jdW1lbnRhdGlvbiBpcyB1bmNsZWFyICgicmV0dXJu
cyBbLi4uXSB0aGUgdmFsdWUgb2YgZXJybm8gb24NCj4gZmFpbHVyZSIpLiAgV2hpbGUgdGhpcyBj
b3VsZCBiZSByZWFkIGFzICJzZXRzIGVycm5vIGFuZCByZXR1cm5zIGl0IiwNCj4gYSBnbGFuY2Ug
YXQgdGhlIHNvdXJjZSBjb2RlWypdIGtpbGxzIHRoYXQgaG9wZToNCj4gDQo+ICAgICAgc3RhdGlj
IGlubGluZSBpbnQgaWJ2X3Bvc3Rfc2VuZChzdHJ1Y3QgaWJ2X3FwICpxcCwgc3RydWN0IGlidl9z
ZW5kX3dyICp3ciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBpYnZfc2VuZF93ciAqKmJhZF93cikNCj4gICAgICB7DQo+ICAgICAgICAgICAgICByZXR1cm4g
cXAtPmNvbnRleHQtPm9wcy5wb3N0X3NlbmQocXAsIHdyLCBiYWRfd3IpOw0KPiAgICAgIH0NCj4g
DQo+IFRoZSBjYWxsYmFjayBjYW4gYmUNCj4gDQo+ICAgICAgc3RhdGljIGludCBtYW5hX3Bvc3Rf
c2VuZChzdHJ1Y3QgaWJ2X3FwICppYnFwLCBzdHJ1Y3QgaWJ2X3NlbmRfd3IgKndyLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGlidl9zZW5kX3dyICoqYmFkKQ0KPiAg
ICAgIHsNCj4gICAgICAgICAgICAgIC8qIFRoaXMgdmVyc2lvbiBvZiBkcml2ZXIgc3VwcG9ydHMg
UkFXIFFQIG9ubHkuDQo+ICAgICAgICAgICAgICAgKiBQb3N0aW5nIFdSIGlzIGRvbmUgZGlyZWN0
bHkgaW4gdGhlIGFwcGxpY2F0aW9uLg0KPiAgICAgICAgICAgICAgICovDQo+ICAgICAgICAgICAg
ICByZXR1cm4gRU9QTk9UU1VQUDsNCj4gICAgICB9DQo+IA0KPiBOZWl0aGVyIG9mIHRoZW0gdG91
Y2hlcyBlcnJuby4NCj4gDQo+IE9uZSBvZiB0aGVzZSBlcnJubyB1c2VzIGlzIGVhc3kgdG8gZml4
LCBzbyBkbyB0aGF0IG5vdy4gIFNldmVyYWwgbW9yZQ0KPiB3aWxsIGdvIGF3YXkgbGF0ZXIgaW4g
dGhlIHNlcmllczsgYWRkIHRlbXBvcmFyeSBGSVhNRSBjb21tbWVudHMuDQo+IFRocmVlIHdpbGwg
cmVtYWluOyBhZGQgVE9ETyBjb21tZW50cy4gIFRPRE8sIG5vdCBGSVhNRSwgYmVjYXVzZSB0aGUN
Cj4gYnVnIG1pZ2h0IGJlIGluIExpYmlidmVyYnMgZG9jdW1lbnRhdGlvbi4NCj4gDQo+IFsqXSBo
dHRwczovL2dpdGh1Yi5jb20vbGludXgtcmRtYS9yZG1hLWNvcmUuZ2l0DQo+ICAgICAgY29tbWl0
IDU1ZmEzMTZiNGIxOGYyNThkOGFjMWNlYjRhYTVhN2EzNWIwOTRkY2YNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCg0KDQpSZXZpZXdl
ZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQoNCj4gLS0tDQo+ICAg
bWlncmF0aW9uL3JkbWEuYyB8IDQ1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCA2IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmMgYi9taWdyYXRpb24v
cmRtYS5jDQo+IGluZGV4IDI4MDk3Y2U2MDQuLmJiYThjOTlmYTkgMTAwNjQ0DQo+IC0tLSBhL21p
Z3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBAQCAtODUzLDYgKzg1
MywxMiBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV9icm9rZW5faXB2Nl9rZXJuZWwoc3RydWN0IGli
dl9jb250ZXh0ICp2ZXJicywgRXJyb3IgKiplcnJwKQ0KPiAgIA0KPiAgICAgICAgICAgZm9yICh4
ID0gMDsgeCA8IG51bV9kZXZpY2VzOyB4KyspIHsNCj4gICAgICAgICAgICAgICB2ZXJicyA9IGli
dl9vcGVuX2RldmljZShkZXZfbGlzdFt4XSk7DQo+ICsgICAgICAgICAgICAvKg0KPiArICAgICAg
ICAgICAgICogaWJ2X29wZW5fZGV2aWNlKCkgaXMgbm90IGRvY3VtZW50ZWQgdG8gc2V0IGVycm5v
LiAgSWYNCj4gKyAgICAgICAgICAgICAqIGl0IGRvZXMsIGl0J3Mgc29tZWJvZHkgZWxzZSdzIGRv
YyBidWcuICBJZiBpdCBkb2Vzbid0LA0KPiArICAgICAgICAgICAgICogdGhlIHVzZSBvZiBlcnJu
byBiZWxvdyBpcyB3cm9uZy4NCj4gKyAgICAgICAgICAgICAqIFRPRE8gRmluZCBvdXQgd2hldGhl
ciBpYnZfb3Blbl9kZXZpY2UoKSBzZXRzIGVycm5vLg0KPiArICAgICAgICAgICAgICovDQo+ICAg
ICAgICAgICAgICAgaWYgKCF2ZXJicykgew0KPiAgICAgICAgICAgICAgICAgICBpZiAoZXJybm8g
PT0gRVBFUk0pIHsNCj4gICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiBAQCAtMTE2
MiwxMSArMTE2OCw3IEBAIHN0YXRpYyB2b2lkIHFlbXVfcmRtYV9hZHZpc2VfcHJlZmV0Y2hfbXIo
c3RydWN0IGlidl9wZCAqcGQsIHVpbnQ2NF90IGFkZHIsDQo+ICAgICAgIHJldCA9IGlidl9hZHZp
c2VfbXIocGQsIGFkdmljZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICBJQlZfQURWSVNF
X01SX0ZMQUdfRkxVU0gsICZzZ19saXN0LCAxKTsNCj4gICAgICAgLyogaWdub3JlIHRoZSBlcnJv
ciAqLw0KPiAtICAgIGlmIChyZXQpIHsNCj4gLSAgICAgICAgdHJhY2VfcWVtdV9yZG1hX2Fkdmlz
ZV9tcihuYW1lLCBsZW4sIGFkZHIsIHN0cmVycm9yKGVycm5vKSk7DQo+IC0gICAgfSBlbHNlIHsN
Cj4gLSAgICAgICAgdHJhY2VfcWVtdV9yZG1hX2FkdmlzZV9tcihuYW1lLCBsZW4sIGFkZHIsICJz
dWNjZXNzZWQiKTsNCj4gLSAgICB9DQo+ICsgICAgdHJhY2VfcWVtdV9yZG1hX2FkdmlzZV9tcihu
YW1lLCBsZW4sIGFkZHIsIHN0cmVycm9yKHJldCkpOw0KPiAgICNlbmRpZg0KPiAgIH0NCj4gICAN
Cj4gQEAgLTExODMsNyArMTE4NSwxMiBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV9yZWdfd2hvbGVf
cmFtX2Jsb2NrcyhSRE1BQ29udGV4dCAqcmRtYSkNCj4gICAgICAgICAgICAgICAgICAgICAgIGxv
Y2FsLT5ibG9ja1tpXS5sb2NhbF9ob3N0X2FkZHIsDQo+ICAgICAgICAgICAgICAgICAgICAgICBs
b2NhbC0+YmxvY2tbaV0ubGVuZ3RoLCBhY2Nlc3MNCj4gICAgICAgICAgICAgICAgICAgICAgICk7
DQo+IC0NCj4gKyAgICAgICAgLyoNCj4gKyAgICAgICAgICogaWJ2X3JlZ19tcigpIGlzIG5vdCBk
b2N1bWVudGVkIHRvIHNldCBlcnJuby4gIElmIGl0IGRvZXMsDQo+ICsgICAgICAgICAqIGl0J3Mg
c29tZWJvZHkgZWxzZSdzIGRvYyBidWcuICBJZiBpdCBkb2Vzbid0LCB0aGUgdXNlIG9mDQo+ICsg
ICAgICAgICAqIGVycm5vIGJlbG93IGlzIHdyb25nLg0KPiArICAgICAgICAgKiBUT0RPIEZpbmQg
b3V0IHdoZXRoZXIgaWJ2X3JlZ19tcigpIHNldHMgZXJybm8uDQo+ICsgICAgICAgICAqLw0KPiAg
ICAgICAgICAgaWYgKCFsb2NhbC0+YmxvY2tbaV0ubXIgJiYNCj4gICAgICAgICAgICAgICBlcnJu
byA9PSBFTk9UU1VQICYmIHJkbWFfc3VwcG9ydF9vZHAocmRtYS0+dmVyYnMpKSB7DQo+ICAgICAg
ICAgICAgICAgICAgIGFjY2VzcyB8PSBJQlZfQUNDRVNTX09OX0RFTUFORDsNCj4gQEAgLTEyOTEs
NiArMTI5OCwxMiBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV9yZWdpc3Rlcl9hbmRfZ2V0X2tleXMo
UkRNQUNvbnRleHQgKnJkbWEsDQo+ICAgICAgICAgICB0cmFjZV9xZW11X3JkbWFfcmVnaXN0ZXJf
YW5kX2dldF9rZXlzKGxlbiwgY2h1bmtfc3RhcnQpOw0KPiAgIA0KPiAgICAgICAgICAgYmxvY2st
PnBtcltjaHVua10gPSBpYnZfcmVnX21yKHJkbWEtPnBkLCBjaHVua19zdGFydCwgbGVuLCBhY2Nl
c3MpOw0KPiArICAgICAgICAvKg0KPiArICAgICAgICAgKiBpYnZfcmVnX21yKCkgaXMgbm90IGRv
Y3VtZW50ZWQgdG8gc2V0IGVycm5vLiAgSWYgaXQgZG9lcywNCj4gKyAgICAgICAgICogaXQncyBz
b21lYm9keSBlbHNlJ3MgZG9jIGJ1Zy4gIElmIGl0IGRvZXNuJ3QsIHRoZSB1c2Ugb2YNCj4gKyAg
ICAgICAgICogZXJybm8gYmVsb3cgaXMgd3JvbmcuDQo+ICsgICAgICAgICAqIFRPRE8gRmluZCBv
dXQgd2hldGhlciBpYnZfcmVnX21yKCkgc2V0cyBlcnJuby4NCj4gKyAgICAgICAgICovDQo+ICAg
ICAgICAgICBpZiAoIWJsb2NrLT5wbXJbY2h1bmtdICYmDQo+ICAgICAgICAgICAgICAgZXJybm8g
PT0gRU5PVFNVUCAmJiByZG1hX3N1cHBvcnRfb2RwKHJkbWEtPnZlcmJzKSkgew0KPiAgICAgICAg
ICAgICAgIGFjY2VzcyB8PSBJQlZfQUNDRVNTX09OX0RFTUFORDsNCj4gQEAgLTE0MDgsNiArMTQy
MSwxMSBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV91bnJlZ2lzdGVyX3dhaXRpbmcoUkRNQUNvbnRl
eHQgKnJkbWEpDQo+ICAgICAgICAgICBibG9jay0+cmVtb3RlX2tleXNbY2h1bmtdID0gMDsNCj4g
ICANCj4gICAgICAgICAgIGlmIChyZXQgIT0gMCkgew0KPiArICAgICAgICAgICAgLyoNCj4gKyAg
ICAgICAgICAgICAqIEZJWE1FIHBlcnJvcigpIGlzIHByb2JsZW1hdGljLCBiY2F1c2UgaWJ2X2Rl
cmVnX21yKCkgaXMNCj4gKyAgICAgICAgICAgICAqIG5vdCBkb2N1bWVudGVkIHRvIHNldCBlcnJu
by4gIFdpbGwgZ28gYXdheSBsYXRlciBpbg0KPiArICAgICAgICAgICAgICogdGhpcyBzZXJpZXMu
DQo+ICsgICAgICAgICAgICAgKi8NCj4gICAgICAgICAgICAgICBwZXJyb3IoInVucmVnaXN0cmF0
aW9uIGNodW5rIGZhaWxlZCIpOw0KPiAgICAgICAgICAgICAgIHJldHVybiAtcmV0Ow0KPiAgICAg
ICAgICAgfQ0KPiBAQCAtMTY1OCw2ICsxNjc2LDExIEBAIHN0YXRpYyBpbnQgcWVtdV9yZG1hX2Js
b2NrX2Zvcl93cmlkKFJETUFDb250ZXh0ICpyZG1hLA0KPiAgIA0KPiAgICAgICAgICAgcmV0ID0g
aWJ2X2dldF9jcV9ldmVudChjaCwgJmNxLCAmY3FfY3R4KTsNCj4gICAgICAgICAgIGlmIChyZXQp
IHsNCj4gKyAgICAgICAgICAgIC8qDQo+ICsgICAgICAgICAgICAgKiBGSVhNRSBwZXJyb3IoKSBp
cyBwcm9ibGVtYXRpYywgYmVjYXVzZSBpYnZfcmVnX21yKCkgaXMNCj4gKyAgICAgICAgICAgICAq
IG5vdCBkb2N1bWVudGVkIHRvIHNldCBlcnJuby4gIFdpbGwgZ28gYXdheSBsYXRlciBpbg0KPiAr
ICAgICAgICAgICAgICogdGhpcyBzZXJpZXMuDQo+ICsgICAgICAgICAgICAgKi8NCj4gICAgICAg
ICAgICAgICBwZXJyb3IoImlidl9nZXRfY3FfZXZlbnQiKTsNCj4gICAgICAgICAgICAgICBnb3Rv
IGVycl9ibG9ja19mb3Jfd3JpZDsNCj4gICAgICAgICAgIH0NCj4gQEAgLTIxOTksNiArMjIyMiwx
MSBAQCByZXRyeToNCj4gICAgICAgICAgIGdvdG8gcmV0cnk7DQo+ICAgDQo+ICAgICAgIH0gZWxz
ZSBpZiAocmV0ID4gMCkgew0KPiArICAgICAgICAvKg0KPiArICAgICAgICAgKiBGSVhNRSBwZXJy
b3IoKSBpcyBwcm9ibGVtYXRpYywgYmVjYXVzZSB3aGV0aGVyDQo+ICsgICAgICAgICAqIGlidl9w
b3N0X3NlbmQoKSBzZXRzIGVycm5vIGlzIHVuY2xlYXIuICBXaWxsIGdvIGF3YXkgbGF0ZXINCj4g
KyAgICAgICAgICogaW4gdGhpcyBzZXJpZXMuDQo+ICsgICAgICAgICAqLw0KPiAgICAgICAgICAg
cGVycm9yKCJyZG1hIG1pZ3JhdGlvbjogcG9zdCByZG1hIHdyaXRlIGZhaWxlZCIpOw0KPiAgICAg
ICAgICAgcmV0dXJuIC1yZXQ7DQo+ICAgICAgIH0NCj4gQEAgLTI1NTksNiArMjU4NywxMSBAQCBz
dGF0aWMgaW50IHFlbXVfcmRtYV9jb25uZWN0KFJETUFDb250ZXh0ICpyZG1hLCBib29sIHJldHVy
bl9wYXRoLA0KPiAgICAgICAgICAgcmV0ID0gcmRtYV9nZXRfY21fZXZlbnQocmRtYS0+Y2hhbm5l
bCwgJmNtX2V2ZW50KTsNCj4gICAgICAgfQ0KPiAgICAgICBpZiAocmV0KSB7DQo+ICsgICAgICAg
IC8qDQo+ICsgICAgICAgICAqIEZJWE1FIHBlcnJvcigpIGlzIHdyb25nLCBiZWNhdXNlDQo+ICsg
ICAgICAgICAqIHFlbXVfZ2V0X2NtX2V2ZW50X3RpbWVvdXQoKSBjYW4gZmFpbCB3aXRob3V0IHNl
dHRpbmcgZXJybm8uDQo+ICsgICAgICAgICAqIFdpbGwgZ28gYXdheSBsYXRlciBpbiB0aGlzIHNl
cmllcy4NCj4gKyAgICAgICAgICovDQo+ICAgICAgICAgICBwZXJyb3IoInJkbWFfZ2V0X2NtX2V2
ZW50IGFmdGVyIHJkbWFfY29ubmVjdCIpOw0KPiAgICAgICAgICAgRVJST1IoZXJycCwgImNvbm5l
Y3RpbmcgdG8gZGVzdGluYXRpb24hIik7DQo+ICAgICAgICAgICBnb3RvIGVycl9yZG1hX3NvdXJj
ZV9jb25uZWN0Ow==

