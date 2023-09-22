Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB337AAD54
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjc3G-0001Y3-A3; Fri, 22 Sep 2023 05:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjc38-0001Wt-8y
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:02:14 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjc30-0005CJ-0S
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695373322; x=1726909322;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=R7jhhWoeXt4cANVGSbtQ5VLRoFbI/t09+KjvAnuWh48=;
 b=VlijmB/igsO20IsQXEnXUx0lnlzjsJNODUwKYjbfDkz9w0kssht//mG1
 BOtLWfFJzvBjc92wNAbMM3OsF/1b/oSXchE2DNjY2f3Y7MFlsOVTYu3m+
 zI7merPYT6qoJ/tGseAWyeV+eONcf8JsLS2ttLYnzS+NnktQRcQ0aX6hE
 ld+AY958HByYX5CqIxax27/dlbTjgUn9/SW7/8EW7apKHI+B/LDo5Ydj2
 4AQkr/TzGvc4DhpZs3XNoY3F3G52wa0ohYSWyjfOs29jf5NKyy0ogjgqt
 hlgpWp+PMmfwjP8xdgvWLBUzcaS1zju+n+0xUUXj+WgN2xuPVAUolN7u3 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="95880887"
X-IronPort-AV: E=Sophos;i="6.03,167,1694703600"; d="scan'208";a="95880887"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2023 18:01:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ti99YMKFi2mTh7LkDs+QwR9HHg82tkq3SD7SD05O+wK8z/mwtiQDoc9mqcENKb2YET//67wYnx5oAkcniFzvX5WewdS8C0Xki5Kqz+04mPf+guv1+y1o9Z3JpVhGtFeYVF6+6av4M/1DayrKXq0y2Aw8ColyR4fV8JiU839Yq7NiJokZyX4NHaMfP8PRw8I0eNuO2P0RZHwp6c2mSwsiOJ2Qlg+jUehbU1J+5SxpaZvsnPCnmCBaOqWbP6x0CURttn6FHEIQmrUd5LTk1PZNPt05enAzwBZouhm/zRpRUZbLgO9p0kieeJ50/fMeZ274OEITxuZhElCEq92CdUa5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7jhhWoeXt4cANVGSbtQ5VLRoFbI/t09+KjvAnuWh48=;
 b=VOtMBK1wSSbLr1fLMhaab35lEguiEkj4uYiFt2H9p9Mib5EJcT7MP5X7rzzgx4tAiReCkFLlZsqC0ZQmvgaOGd/uMvb4Fe6tNaUUk4uHcyk0ZOi9SBQUMNCYqi7Z6gjv0h6qEDrvSoqk5/JzeNtNLdGU6O+SVYcS9dYx5ZxdKhP5fhYktusyEHgt79tPIQlHrrMyEV15NfTBkQeFXmijmzHC0Gsj7Ve2SFmUSuZBo7j/NYq7Wv8CTP8oMwZzUoV9mbrEHZDovv464xrWk5OtBdeJfz5NX8vq0TdW5wZMXKVgqZBXHCh4t4rNntV/uZfzB5p49HvAmKoAU0sdNqAUQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB8565.jpnprd01.prod.outlook.com (2603:1096:400:154::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 09:01:54 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 09:01:52 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 17/52] migration/rdma: Replace dangerous macro
 CHECK_ERROR_STATE()
Thread-Topic: [PATCH 17/52] migration/rdma: Replace dangerous macro
 CHECK_ERROR_STATE()
Thread-Index: AQHZ6j7DQ8GmTF5D8EKPHljCwg+3s7AmklyA
Date: Fri, 22 Sep 2023 09:01:52 +0000
Message-ID: <7afc2ff0-76bd-6b18-089a-14a566cd9b9d@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-18-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-18-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB8565:EE_
x-ms-office365-filtering-correlation-id: df36a70e-6145-40f3-31f3-08dbbb4a9061
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z57rRFukpt4xwPto0n+d+f9EUbGNzXvdIt9AEfPdG3okvf2Jfenp9gPzszlPOZvHo99ovH1dqRoSUWNM8eGM/hQ2DtHV903AJJQUjP49TiZ2uGCGeHXAuKvViajB+Iad+7QCZwhzo8MtPxKFIq5B5vXb8ldcbObtVmFoUpQv6mVMecHB8yNKHIkE4WOrQ3P5prgp6T+48qkVFuH1CrNGQQ+q/6jabuBFVFSjNXOFqbiWxb338kl/duqlzpsAmWyxnQx2w54G4Dq7d7p/RkOmxjHkUiDr53yF/yVAqTSOIsEGwDdP12lzn/KVOcBE+1thUqBM1SDZFl6CzK3/1L1GQjVx6OgOSiscgzbe6BorlrEQhtUeCp3itgXBUN3yw0hn+UX/dg9HwA7dh4r5WJjXeJdhIFgeGNDu+sGIJJnNQshwf7zrdzAlqpyd3+4VIMURyAA3bMOK93+q9mgdQJvae/6sz50coPP9rNvE5dJFM3Yo0NLG0ghbMQ1DHLl9fS0jYdjO8wFO/778E5A4B1yR5khPDd8TIdtoujpKopdEHv09GIRlagVO9Mw6Y3hA1T4uZA/yQ+V9Mfg7WnHnANOHgJr23u55VGTH7FElv3nq95TniiI12Boz4hcrsesRAEoTf1JXku5/wm6rQS+eLnP8W56/720Z3HnI5do8ZYibaCqYIjtr2Q10Zxo/b/stGfcQvryXUbi4mfrYn45E/+QIaw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199024)(1590799021)(186009)(1800799009)(2906002)(82960400001)(38070700005)(38100700002)(122000001)(1580799018)(6512007)(53546011)(6486002)(6506007)(86362001)(31696002)(2616005)(41300700001)(110136005)(66446008)(66476007)(66556008)(66946007)(316002)(36756003)(71200400001)(54906003)(64756008)(85182001)(478600001)(91956017)(76116006)(31686004)(5660300002)(26005)(83380400001)(8936002)(4326008)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vm41QlZHTEIwMnAvTHdMN0sxQkFvbE1UenQ3Uzh2UmdZODVkVDBLMThQU2hj?=
 =?utf-8?B?aEZhOU1FTTNVR3Vtd3hkYm0ydzNkNFZoWFRkSTRDQXhWOU91aDBPanp3MkpK?=
 =?utf-8?B?d2VVVnVFRjNPK0xvSDBPU0V0bE9mKytPRDdBOStGKy9LT05naytzSUp0TExI?=
 =?utf-8?B?cVRSaCtoYjhkekduTjNsVktqbjV6OVNKZjZDcmE3bDRtV2VpZGhLdHNkTHl6?=
 =?utf-8?B?NjVCaklKd2kza090YnBVaGZ2elNjYkN4d2JuaEx3TkJqRitQbXdNR2NMNmIz?=
 =?utf-8?B?WkJaTTNyS2E2YTBsSTBJY2JNdS9icDFBK28yTUNhQzliY2JqVUJndmpQQ09V?=
 =?utf-8?B?YnNDYjh1T1h3TU43VUJ2N3ZOa0sxTm1BTzh0enhJVE41UkdVb0sxZ0FsNjVB?=
 =?utf-8?B?V25NRXNCMXNURmd0dHNGSDh6UENBelVDRXV4eDB6ZEZlbm5GZW01cG9jNGFN?=
 =?utf-8?B?R1R0Z1ZoZmIraEprbERUcitIRUlBVmlucUsrRVkxK2JGSm5Zek9WakNwOEg3?=
 =?utf-8?B?RnZOYUo1YUtIZ3RocFZ1K3hRTWdieS8zNm1qME1WYmNFbmVUWUczMHNCZGVR?=
 =?utf-8?B?cmZReWdjR000MG52eGxnL3NPTS9FYXRQUmgxUkVYUDRKZGNkTndMWVRDVDVW?=
 =?utf-8?B?V2VCbTFFSWFkMFFmdnFkd3lSWHZEeVg0TDFGY3JaRkdvR2RieGpNZUhqem1p?=
 =?utf-8?B?WEFqd0hXSVF4cnVpWG92UGVDaklRK0NhU055NjhiTFYxaG9YVnphcGZtL2Vq?=
 =?utf-8?B?ai80QURneHh3Wk1TcE82d3NLSlZnMzBpQ1RSNWFNYVllcWpoSWh3Y25UeWdm?=
 =?utf-8?B?NFBJeGM4STFhR1Q0aFV0V04zMktyWlhrUjZzaGZDcy9MVHV3aEJXMGcxK0Vj?=
 =?utf-8?B?Ymk5akR3cXZpYUF0a3FCREVCVW1ZeHB6TUlkTUpxTUNOQjMxdXhSeVIxd2pE?=
 =?utf-8?B?VllZT1JCcXh6V1lTbVNUY2lsNEVKd2N6dnY4K0ptRk04YnNkcDkxSlRNeU96?=
 =?utf-8?B?b0xROTJSWXdZMGxETjFuRnVybHpJY2RlZE5RVTk2Y25oMWZ4bSs2b09OR1h2?=
 =?utf-8?B?ZDFqTDcxTEN6SGRVSzE5OXFlTkNmRVJnU0JoSEVYN2dRMS9MZTJIQnhKRVRY?=
 =?utf-8?B?WUNsejdkRFVoMjVQdEtuN0Jjc1NObTBsazhFeVRtUmsvZjhBZThySGRjRkNk?=
 =?utf-8?B?MlNxY1NQKzkweU82OXhVRXkvL01TUTBUZXdqbVUxTmo0Ulhza1NLaVZqa2JO?=
 =?utf-8?B?SXBxUFJ5SE5Sc3lMOElXcEdZK1JzaU5SQSsybk5IYVBkeTU5SDkycVZxL0pq?=
 =?utf-8?B?NlpvUDMxeTJ0Uk1IejZuV0hWZml6SjV4NFo1cUtKLzZyVVBXMVhPT3c2ZWJa?=
 =?utf-8?B?OENxZjJSNFM2ZmRwVzFVVkduVTcwYm13eDFOeWp4aXZKelJKb001cFpDWHFa?=
 =?utf-8?B?VWg5T1ozeW0xRG5ReFd1ZG5oeU5Cck1ISnlsQWpGZlJORGkrbVZQWFpyMUJy?=
 =?utf-8?B?YXQ1Zkltdlh2UFVaZ2dUVG5BWnpCbUNNc1ZYd1ZsSzJWYmdLNGhLanNWWGtG?=
 =?utf-8?B?RG9pSENrNnNxa1h3NktuMTRCMVJsUzJTYUp0aHl1Rk4wN0doV3d5NUxHVmI1?=
 =?utf-8?B?SkJTN2RWM2d6Nlh5VlRUWnI5emw2TGREb3E0ZE01eTdleGEwNlhWUSthcmtH?=
 =?utf-8?B?TUJtNzd1eG5kdExQc3RldTdMM1VDRFlrNzhOZFRBbkVSOWhLZUtWbENEMldE?=
 =?utf-8?B?SjZQK2lRSWZTN1hlRkhnNDhJTEVPQi9zTlJES2hPOUxQNTFBRUcyYXVLOFpD?=
 =?utf-8?B?ZnRVRndMSlBZT1Q3bGtjQU1jdThyUnF3WUFZVXRNSXppYVVKRzNvcGN4MThJ?=
 =?utf-8?B?VGM2dEkrQXViNUhQYVZUOWgxckpHcFNSQXFab0N3TFpSNENKNW5WbnlNZjZO?=
 =?utf-8?B?cUUvRURNclZYcERZSlMzd2dpbDRYV3lKSHpINjN3VGRncXVVV25jTlVYVksv?=
 =?utf-8?B?ckRTM2dqdVk0bEd3MFJVa0xJcFdKVGJFdGxxMndIeW9EelV0ZzkvaGVlL0Zn?=
 =?utf-8?B?U3NtZGlEcW5lQ3JIQ2kvOStValV4SHdNU0pNblQ0dDFkbGJKcWd0ZDNwMjBJ?=
 =?utf-8?B?eG4wRFp3dklOVWVNQTdobEtrNjFCQkloSC9PMEdxbzhoZENwVEFOUWJUY0RL?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47F5F00223587B48B0CD34D1379FD43E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wtqPQ/PCVG/xhoKoygaDZv56lc+5aR/7JJlTMpVRN4sfHNQEsGDRvJ7Nd583PBefz00sO/Jrkxd+XGirRfckuTwUV0iUag2IhEspN71iGubNidTh1H+RqOaP3W/MAos+qUpmSujVOB/3yHF+IQYUBcBAZr11X8C7tR7MO6qQWsVsVIEvcd1FuBy9E9vQpML4uqd5NfsSkNQvyOj0NF5SeuWLBwhE93GzvBX+pSZTM7Dvf3j30/xDn4Qffjldzi04rX4f8FCP4HBFiL+b7kPRO82yYvvIC/o1K02a1aP38qR3vDVhxY0K9gvPGo0vNNCoN9PugE7zb3j7RXXSBaai9q8W8ykYMIz+RYK7zFjDGr6lGW7zBcWnBtfrPBF2ln2wdPzCDgt3jhp4BBDvj2RwqD0dsp4FhqcL+6+eH9jfLa2OK1R4/ewBkya6tes+2PPVDsv9yC4db0YD8eV0+2pIopvxoRtfCg16zT1kaTORdkHC1naSlQnVu7cnubMl7QPaaQAnj9D564fWCWK9Ejc/qDT+rPOLe9DplGrEMboqp3wTJupp0vGopgqAZ6n7zJu4rCl8nxyxEqNniupGkZFOLUz9pV5iL/o3LmiwhpgdL1BbFq+yjmzBc9dwppNKPWowwPTthwOR2xKyZ4aorY0BZxHtEsHuxJKC9eLDSNEsL8GJoVK4oBMlQaE6RtFTI8osclrByrP2bXh98SWw6WxNEnyv4mKShhUHk9XMC3DOV3Q4Un+LW411/fvS1gNlZetF6thBdoQAQttyYNOtjoyjia8GCAqYEG1lYO9Wd2/j/GY=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df36a70e-6145-40f3-31f3-08dbbb4a9061
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 09:01:52.7089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CPQhmnrPhpfYotQ0FWtdPRmcxk8HB85hv5/20fRPi0sFzhj92B2w041thL/2v9aLbPdp+RdP8l8GnJtlG5LwSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8565
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBIaWRp
bmcgcmV0dXJuIHN0YXRlbWVudHMgaW4gbWFjcm9zIGlzIGEgYmFkIGlkZWEuICBVc2UgYSBmdW5j
dGlvbg0KPiBpbnN0ZWFkLCBhbmQgb3BlbiBjb2RlIHRoZSByZXR1cm4gcGFydC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCg0KUmV2
aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCg0KDQo+IC0tLQ0K
PiAgIG1pZ3JhdGlvbi9yZG1hLmMgfCA0MyArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDE2IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmMgYi9taWdyYXRp
b24vcmRtYS5jDQo+IGluZGV4IDMwZTZkZmY4NzUuLmJlNjZmNTM0ODkgMTAwNjQ0DQo+IC0tLSBh
L21pZ3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBAQCAtODUsMTgg
Kzg1LDYgQEANCj4gICAgKi8NCj4gICBzdGF0aWMgdWludDMyX3Qga25vd25fY2FwYWJpbGl0aWVz
ID0gUkRNQV9DQVBBQklMSVRZX1BJTl9BTEw7DQo+ICAgDQo+IC0jZGVmaW5lIENIRUNLX0VSUk9S
X1NUQVRFKCkgXA0KPiAtICAgIGRvIHsgXA0KPiAtICAgICAgICBpZiAocmRtYS0+ZXJyb3Jfc3Rh
dGUpIHsgXA0KPiAtICAgICAgICAgICAgaWYgKCFyZG1hLT5lcnJvcl9yZXBvcnRlZCkgeyBcDQo+
IC0gICAgICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJSRE1BIGlzIGluIGFuIGVycm9yIHN0YXRl
IHdhaXRpbmcgbWlncmF0aW9uIiBcDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICIgdG8gYWJvcnQhIik7IFwNCj4gLSAgICAgICAgICAgICAgICByZG1hLT5lcnJvcl9yZXBvcnRl
ZCA9IHRydWU7IFwNCj4gLSAgICAgICAgICAgIH0gXA0KPiAtICAgICAgICAgICAgcmV0dXJuIHJk
bWEtPmVycm9yX3N0YXRlOyBcDQo+IC0gICAgICAgIH0gXA0KPiAtICAgIH0gd2hpbGUgKDApDQo+
IC0NCj4gICAvKg0KPiAgICAqIEEgd29yayByZXF1ZXN0IElEIGlzIDY0LWJpdHMgYW5kIHdlIHNw
bGl0IHVwIHRoZXNlIGJpdHMNCj4gICAgKiBpbnRvIDMgcGFydHM6DQo+IEBAIC00NTEsNiArNDM5
LDE2IEBAIHR5cGVkZWYgc3RydWN0IFFFTVVfUEFDS0VEIHsNCj4gICAgICAgdWludDY0X3QgY2h1
bmtzOyAgICAgICAgICAgIC8qIGhvdyBtYW55IHNlcXVlbnRpYWwgY2h1bmtzIHRvIHJlZ2lzdGVy
ICovDQo+ICAgfSBSRE1BUmVnaXN0ZXI7DQo+ICAgDQo+ICtzdGF0aWMgaW50IGNoZWNrX2Vycm9y
X3N0YXRlKFJETUFDb250ZXh0ICpyZG1hKQ0KPiArew0KPiArICAgIGlmIChyZG1hLT5lcnJvcl9z
dGF0ZSAmJiAhcmRtYS0+ZXJyb3JfcmVwb3J0ZWQpIHsNCj4gKyAgICAgICAgZXJyb3JfcmVwb3J0
KCJSRE1BIGlzIGluIGFuIGVycm9yIHN0YXRlIHdhaXRpbmcgbWlncmF0aW9uIg0KPiArICAgICAg
ICAgICAgICAgICAgICAgIiB0byBhYm9ydCEiKTsNCj4gKyAgICAgICAgcmRtYS0+ZXJyb3JfcmVw
b3J0ZWQgPSB0cnVlOw0KPiArICAgIH0NCj4gKyAgICByZXR1cm4gcmRtYS0+ZXJyb3Jfc3RhdGU7
DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgdm9pZCByZWdpc3Rlcl90b19uZXR3b3JrKFJETUFDb250
ZXh0ICpyZG1hLCBSRE1BUmVnaXN0ZXIgKnJlZykNCj4gICB7DQo+ICAgICAgIFJETUFMb2NhbEJs
b2NrICpsb2NhbF9ibG9jazsNCj4gQEAgLTMyMTksNyArMzIxNywxMCBAQCBzdGF0aWMgc2l6ZV90
IHFlbXVfcmRtYV9zYXZlX3BhZ2UoUUVNVUZpbGUgKmYsDQo+ICAgICAgICAgICByZXR1cm4gLUVJ
TzsNCj4gICAgICAgfQ0KPiAgIA0KPiAtICAgIENIRUNLX0VSUk9SX1NUQVRFKCk7DQo+ICsgICAg
cmV0ID0gY2hlY2tfZXJyb3Jfc3RhdGUocmRtYSk7DQo+ICsgICAgaWYgKHJldCkgew0KPiArICAg
ICAgICByZXR1cm4gcmV0Ow0KPiArICAgIH0NCj4gICANCj4gICAgICAgcWVtdV9mZmx1c2goZik7
DQo+ICAgDQo+IEBAIC0zNTM1LDcgKzM1MzYsMTAgQEAgc3RhdGljIGludCBxZW11X3JkbWFfcmVn
aXN0cmF0aW9uX2hhbmRsZShRRU1VRmlsZSAqZikNCj4gICAgICAgICAgIHJldHVybiAtRUlPOw0K
PiAgICAgICB9DQo+ICAgDQo+IC0gICAgQ0hFQ0tfRVJST1JfU1RBVEUoKTsNCj4gKyAgICByZXQg
PSBjaGVja19lcnJvcl9zdGF0ZShyZG1hKTsNCj4gKyAgICBpZiAocmV0KSB7DQo+ICsgICAgICAg
IHJldHVybiByZXQ7DQo+ICsgICAgfQ0KPiAgIA0KPiAgICAgICBsb2NhbCA9ICZyZG1hLT5sb2Nh
bF9yYW1fYmxvY2tzOw0KPiAgICAgICBkbyB7DQo+IEBAIC0zODM5LDYgKzM4NDMsNyBAQCBzdGF0
aWMgaW50IHFlbXVfcmRtYV9yZWdpc3RyYXRpb25fc3RhcnQoUUVNVUZpbGUgKmYsDQo+ICAgew0K
PiAgICAgICBRSU9DaGFubmVsUkRNQSAqcmlvYyA9IFFJT19DSEFOTkVMX1JETUEocWVtdV9maWxl
X2dldF9pb2MoZikpOw0KPiAgICAgICBSRE1BQ29udGV4dCAqcmRtYTsNCj4gKyAgICBpbnQgcmV0
Ow0KPiAgIA0KPiAgICAgICBpZiAobWlncmF0aW9uX2luX3Bvc3Rjb3B5KCkpIHsNCj4gICAgICAg
ICAgIHJldHVybiAwOw0KPiBAQCAtMzg1MCw3ICszODU1LDEwIEBAIHN0YXRpYyBpbnQgcWVtdV9y
ZG1hX3JlZ2lzdHJhdGlvbl9zdGFydChRRU1VRmlsZSAqZiwNCj4gICAgICAgICAgIHJldHVybiAt
RUlPOw0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAgQ0hFQ0tfRVJST1JfU1RBVEUoKTsNCj4gKyAg
ICByZXQgPSBjaGVja19lcnJvcl9zdGF0ZShyZG1hKTsNCj4gKyAgICBpZiAocmV0KSB7DQo+ICsg
ICAgICAgIHJldHVybiByZXQ7DQo+ICsgICAgfQ0KPiAgIA0KPiAgICAgICB0cmFjZV9xZW11X3Jk
bWFfcmVnaXN0cmF0aW9uX3N0YXJ0KGZsYWdzKTsNCj4gICAgICAgcWVtdV9wdXRfYmU2NChmLCBS
QU1fU0FWRV9GTEFHX0hPT0spOw0KPiBAQCAtMzg4MSw3ICszODg5LDEwIEBAIHN0YXRpYyBpbnQg
cWVtdV9yZG1hX3JlZ2lzdHJhdGlvbl9zdG9wKFFFTVVGaWxlICpmLA0KPiAgICAgICAgICAgcmV0
dXJuIC1FSU87DQo+ICAgICAgIH0NCj4gICANCj4gLSAgICBDSEVDS19FUlJPUl9TVEFURSgpOw0K
PiArICAgIHJldCA9IGNoZWNrX2Vycm9yX3N0YXRlKHJkbWEpOw0KPiArICAgIGlmIChyZXQpIHsN
Cj4gKyAgICAgICAgcmV0dXJuIHJldDsNCj4gKyAgICB9DQo+ICAgDQo+ICAgICAgIHFlbXVfZmZs
dXNoKGYpOw0KPiAgICAgICByZXQgPSBxZW11X3JkbWFfZHJhaW5fY3EoZiwgcmRtYSk7

