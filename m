Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0B07AE367
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 03:43:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkx6G-0006NP-6T; Mon, 25 Sep 2023 21:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkx6C-0006JT-BX
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 21:42:52 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkx6A-0003VY-88
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 21:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695692570; x=1727228570;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=e/dH8DbNEnO2354gpKFtg3jGykShEfdAEiosAIZP79s=;
 b=Lp4Lw9LJOBa+u7VIoK0KqUmymppGTBRkyUleXjX91kcyE463vikJtm/c
 igpFlVKdhMQ+up0j2yscI1Bzy3M/losrNC7ErJj0cghdHOhhUUEq61Hgv
 ex84PGTHFpZo0/3UBmAraVWW/RaPI/L5xEQ8WXr91UMii4nDJH36CfcvR
 qrzfHwzqaWjNQXwPUCv5iSBsaCVyg5q9CDWkmD8SCFFBQgrEPByJX7t5L
 xAp6eqEfx8KqMkbakZ/NkHK9wZT7rwMGMUkAjzbNx9Uqr0g6c15eOAdwJ
 4YoyHaVESXlzziEOUmJBQCQrSPwL3Ab6yS4G03rHYm/9jdtV00GgPFfHx A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96971636"
X-IronPort-AV: E=Sophos;i="6.03,176,1694703600"; d="scan'208";a="96971636"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 10:42:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaaVzqWocd79HYU28T/CUooQGYwD2HNZleIv5AZqg+H0Vq6TNPuGKate27+tPqRzUhKhlypios9+crYKU5xBmoxFc9KYfX2wG1wBlLwuKwMDJ3o3s94Oh99lSQ6jurD8/PFA6+N09yURGy6iIW3PYX3W5Gpi7VhHZuUKRuUnZmaZyk/YNw65eKRN6lzJ1s4AKv4QyASbt8SerjYMuYzZ4bph9NsocfsN3xbLHdmrgsRrZPSZazGubTOjNrVwGNfAB2E/9mxUMbUiRLbAIqck0rjvDL4HZlQ8GDP/a/6kITKsP9x94O2aMMqZBQmxnPI4zuy/Lsh/9uejbtdsnCZQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/dH8DbNEnO2354gpKFtg3jGykShEfdAEiosAIZP79s=;
 b=Xms4lfdlALUyL5MgEC2GrdTXn7Uso/7T8m5uSvpm4MWp19iBJMhUfCSPDrm6byYWl0VFCo2zYXhBkuWHOrxtlPLpXJtyLG5lgR7Wujs4Y3sESGbtxJhQ/TdBFvqItTx7gHncJlGezjdyi4QcSA8rQK8ZqKGOTVJqSPROsgm0vesGR96WQNENCcGJ1w0VRHbyoNCJ5caBWWGsq7TGBytAxVM5819y9sUwj6G7RdRzN6prARLIihSZXVuxZgMADN+EWrTqnQrzW6Gss97kXatN3ve+MuPYhVxYBuAPDi7JJcmu6XKGvWIU+lEmG0uzkUqFn7BNT5GjtlQzQAI8BozS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYVPR01MB10831.jpnprd01.prod.outlook.com (2603:1096:400:2aa::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 01:42:43 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 01:42:43 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 35/52] migration/rdma: Convert qemu_rdma_exchange_send()
 to Error
Thread-Topic: [PATCH 35/52] migration/rdma: Convert qemu_rdma_exchange_send()
 to Error
Thread-Index: AQHZ6j6+BOg8P+hHTEaBmkOowUTchrAsYPuA
Date: Tue, 26 Sep 2023 01:42:42 +0000
Message-ID: <a689b82d-ab18-1985-6754-9a481cee4f75@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-36-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-36-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYVPR01MB10831:EE_
x-ms-office365-filtering-correlation-id: 3b6dc23b-1e25-496e-1b87-08dbbe31e062
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lODS7SqXG2zABt1CZxvIZxAg7B10FQoZsOY6m+uMbZEFTyHVjge3fN8JTxMMVWvo0/HdTtA3wqeqlqMT+BmjL7XWahtkBjgwcAOVaZslMSkQ2mVbkhADIZvqcixGGTbBd+D0UYcEnEqSDC1FOdpNFBzt+GxZsfD8Qer22lFUAJPZh5ifzXVbjyrCIEu82+7g83C7AVAiyW1Gni0WsMYiIwC20Um1LxvmlRcD2qhXeXyUpGZ3ujQDHrB2sFwp6SKGNfZS/OhF4cM4gHdOMIfhDhCUU3IjC4/6af9pgeH3OPDC5MlCrbSeZJufVBuRx7zDmrfDKOffSvgQ/Pp7TzY0RtllukB8gVmS5ZbViaGGe0k+3/ZLdhW6TWElwE3vI4ybEaALWzAyzjbzIDVvy09hSVKkEl8JtvYKLZA8Q+XKlGRAC+OadkE9b38cCL3Ur6Z+50dix2dzUlp2o4CWnQ49hw0W5OMZy6gN1CRQFR3MskjVuufLttTDybtm2V/W8AdQlUnMIGkEx2/cT9u4Iyjv+/VSl6H22Z+mnXOWSA+lo2L5Q48LH4NITYQBEHaNU6HBtGF85WX4k90x5R2j5RNvMyZhGLdGnCgMZ2OHD/Okge2STs0+6OnDPfNG+wWRMU9svVzvMEdh5XGhZM+GlwRDl/TG8be/w5CwS5724AhH+CrWPMqL9qjPbNJfII6n87FgG/R1yqKY3HcXl8JxHaF12g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(1590799021)(186009)(316002)(41300700001)(1580799018)(2616005)(71200400001)(6512007)(26005)(53546011)(478600001)(85182001)(6506007)(36756003)(6486002)(83380400001)(38070700005)(86362001)(82960400001)(38100700002)(122000001)(31696002)(66446008)(64756008)(66556008)(91956017)(110136005)(66476007)(54906003)(66946007)(76116006)(2906002)(4744005)(31686004)(8676002)(8936002)(5660300002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkFZZklYZ2ZvMWFYeHMxNjYweTdrN21EcGp4VXViK3haVnZ0aDV3STNWamtp?=
 =?utf-8?B?NWxlTVpyRkVXUXdmamcyOE14T2Y4ZTNtNC8zQmhPU1BtWGZhVnJzd3k2RUI0?=
 =?utf-8?B?QVRyU2VlQWMvSnlCWXlwREkwTi9FTGlqYXFtRHJ5NXo3emM1UG82cG1qbU9x?=
 =?utf-8?B?NVVZWjc2MVE3c0hrYXV0WlF5QVZ4dEtnU0pZY3JubUo4TlJ0QWtuUGJWcHdC?=
 =?utf-8?B?WEhrSE92T2xrbVNibG9TVzlTR2dhTm41aG1sQXIzM05mRVdiMnMzQ2VUQ1Zq?=
 =?utf-8?B?NlFidDU0WWFMUTJHMEJxVkFsMFo1d0VZZXJaWE55WXEzeElSR0tOSnA5S29h?=
 =?utf-8?B?NUFZelFLTEhNYk9sUE9iQVA2NldmMENsYzJ3VmprdHo0ODgxeldSZmlZU2ll?=
 =?utf-8?B?WGY1WUgvMTJ4bG5NRHlneUtlcTdVcHJyUnNBeU5lZWJyQWFJOUdLTVN2M3lM?=
 =?utf-8?B?R202RVp6QmtNRnpyOWxsRHE3Z1NVMEkxVVFGMWh0eUFtbkt0QVJubVJveTd2?=
 =?utf-8?B?ajZQMjJyMlVkb1RJcTl6UWRkYUc0WEhxTjAxMVZ4djI1N0toc2YreTd5dW02?=
 =?utf-8?B?NDBxQkMwcW5FRUE4S1VyWnNRQ0dJZkFSeDRqaG50K1ZkWTJ5ZE8rNmh3VE5L?=
 =?utf-8?B?U3FIc3RDdDhCUitYS1g2aG9SdVVaR2VCRzMvNzJ0aFFPZ1V3RFZHMzRSclY4?=
 =?utf-8?B?Vmhyejl2SmhpT0NDMmtkSkxjVTVzZ2RQU1JWM1R3U0tLejFDSHRpMVN6d3hs?=
 =?utf-8?B?a0c0dGpqU3BLOXh0SUlMVS9jRENuajlxQ1BYd08wdG5COG02clpYWG9QZlVj?=
 =?utf-8?B?U3p4amkxVS9UbWNHY25FeDhmdVVyelEwaWdEaXJNRWhTeklUSko4bUJ0ZnZ6?=
 =?utf-8?B?NHpNTitGS2cwSWFRQWI3R2plYjUvK2poSzNJMUxBaDcwdDdwWlc3NktxV0U1?=
 =?utf-8?B?TmswdjVmR3o5My82TzVOaTNaUEUrd2tHY3dmcUtLcmVLazhGTlpXUS9jSEdr?=
 =?utf-8?B?eDBjbUJLU0UraTFJL2piNmJBbmw0aUlQZnJkcjBoNVpaZWswdk5pUmxiVFVx?=
 =?utf-8?B?VWl1cndBeW5oVXRLZS92ZElQc2RXeXI1ZUt0QVR0cG1tWUVKRWpzTDlVMEFX?=
 =?utf-8?B?S1EyNmZLT0tTNDE3Y2o1YlFab1ozNTV2ZW1CcjZRblJyVGk0MjBNWGdjcnJv?=
 =?utf-8?B?eWN3YXU3WGRSeXM5OHRZdkw5K3h6dkRnWHNJWG1SRVV1d2NIblNqV3U3VzQ1?=
 =?utf-8?B?UlRjNnp6WUNHSjg3K3hOSks2bjNOZnhtNGM3aENUcWlnNmJpZVoxNmxpRVFJ?=
 =?utf-8?B?WDJOT2pFWDlyWkVUWlZOR2RIek9ONkRUL1RKVCsxZk8zNnIrT2RiS20vaXFm?=
 =?utf-8?B?Smdtay9wQmw4cFk3VE1KczR6Z3FiQ3RxTTJ2MUM1VlZIc2ZpZkFoQWhVRkpa?=
 =?utf-8?B?WTd4cnEzMGJ6dHk4Wk5PQVVVcU5FbmRDbVZORVR4d01UMThmUFZUZUdBWGx4?=
 =?utf-8?B?dk1jSVJWRlc2NFRqZVl5SzZtTnloZkRjVUFRKzVlUlhiYStrTTRuK0VYUDR6?=
 =?utf-8?B?L0hNK09qZXpDMlJOK1p4d1ppSmdnVHp0ODdkMXA4a2VMRWNDZkhnOXVHS1oy?=
 =?utf-8?B?clc4R1I3WlBGVE95VGx6bFB4dng1d3p3VlhNNFhDSHEzQXBwQ1lmS202MDV5?=
 =?utf-8?B?UlpPUUY1aGNYN3l3Z0lMRmRxUlNMbEdpODdoN1IyUFlHbWlucGFOaS9TbU1J?=
 =?utf-8?B?SjF6TDBpUjNTZGxvSDdVZERTRlVyc3R4WlhrQTZIeVhpODVxczZRc1dOTEJ2?=
 =?utf-8?B?QXNnOVBYUkpPcjUwd3FEVHRyNXA3VFdMc3pPMTkrWUQ0M2doSUFleEozM3V3?=
 =?utf-8?B?UHYwb3ZjRCtsMzhpdFhwdEdVZXZkbG9wLzduT3Vtc0tabWVSbzYzMkZ2VE9w?=
 =?utf-8?B?aU91UmNMTS9LMExNQWFqaVpsRjlhRmlnL0pHblJDUktxa0VicVQ5YytiRVYx?=
 =?utf-8?B?UHV3YUVRL0hyL2RER0NaKzRmQW9ucm9UNFlvMWFpeEdMdU5DcklEL003NzBX?=
 =?utf-8?B?TS9qb0xZcXZHNk93d245L3V1dHlIclI4NllqR3gyT1lwUmN6Y0pTd2RrWGhR?=
 =?utf-8?B?aEU0d1pMY2RoaUpwSXRpWTc5YnJlTWxTSDEvdTNoS0hGMWxVd2RzSUR4enQr?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A193FADDE7F95438936200589F93BC2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n1YPPQZmwK0yz/d/ehNOwp/EvkCzU8xJc24iVMbRKxvwPtSUgBi2cU0+pi3ycCzI2adfM6hx5lYxFX9QSg77ciWwVS12A4f8p8zNllq9tHWrIyKy/LiW7YXbdLumad6EZRchzc+q4bW8imEfsw64lSp+t1FnO7wtf0VwkaMljns0yL0dYyyVZP+pLZ34FhyGup15Jnx5DdQN4k2UVVCYfkYnXmvcpEp8LhYrlEJ9WPWH8fhYE526XL2lai47Hloe7Al5qGMUlh8n4zlFc2OTNXtuDVjIWxM9Hr1VxP4QSwyaw00azWl7nxR+1EDuJVVcONHIr4j3XeGK1ALrIRy0bc+wiuHmYDY41EjZtZPmVUmgJQjVYo9NlbvkrXFLCVOYrGrPE8V5Rvw1aMB545RT+ZjGp5v/BJk0ZUJdzsCC9BqJFNm3CPtoU5aj6IaO109pT1NRX2EPDXOpMX6ZgIoHodGHtAECj+JvCGx/uHLmB26aORnLDAvBexrt75V3F5xKlkmOnE301QeQLc5gP7u7M3f2pxr2OLs044UMdP7I8/VWWIgf0jnYfSd9eXLgpUZsdr5pfgLVOwlQ2DsI4OFL5R0EbzSmpouajE5HRysAgtY53IJhYh63OybTiJoGqNUWFF9WB5CUFBokCudVFwvsTcsBaRjCu43+d7im4rb5GOlULIjqOUtJ2bTrYDTqS0rmUG8kNUjqOqLijr35ZYrFQ+jMhm1q4tcRdohW0yfbBBEcG5Pl+k5aY+FyuHy+Ft1CmXE1Kln+JfKTCd1QnP2fgNIElHnrIxcVKpBsLjAPnGU=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6dc23b-1e25-496e-1b87-08dbbe31e062
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 01:42:42.9905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgAUo5+TjJQskB8p5/Ud1Izf5SOTgRh+dBrLIyH6afrPd3j2iL1MVAeUYf4R8yIaxu3gWCoK4yOOAkNSkDUkHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10831
Received-SPF: pass client-ip=68.232.159.76; envelope-from=lizhijian@fujitsu.com;
 helo=esa5.fujitsucc.c3s2.iphmx.com
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
aWEgcWVtdV9yZG1hX2V4Y2hhbmdlX3NlbmQoKS4gIEkgZWxlY3RlZCBub3QgdG8NCj4gaW52ZXN0
aWdhdGUgaG93IGNhbGxlcnMgaGFuZGxlIHRoZSBlcnJvciwgaS5lLiBwcmVjaXNlIGltcGFjdCBp
cyBub3QNCj4ga25vd24uDQo+IA0KPiBDbGVhbiB0aGlzIHVwIGJ5IGNvbnZlcnRpbmcgcWVtdV9y
ZG1hX2V4Y2hhbmdlX3NlbmQoKSB0byBFcnJvci4NCj4gDQo+IE5lY2Vzc2l0YXRlcyBzZXR0aW5n
IGFuIGVycm9yIHdoZW4gcWVtdV9yZG1hX3Bvc3RfcmVjdl9jb250cm9sKCksDQo+IGNhbGxiYWNr
KCksIG9yIHFlbXVfcmRtYV9leGNoYW5nZV9nZXRfcmVzcG9uc2UoKSBmYWlsZWQuICBTaW5jZSB0
aGVzZQ0KPiBlcnJvcnMgd2lsbCBnbyBhd2F5IGxhdGVyIGluIHRoaXMgc2VyaWVzLCBzaW1wbHkg
dXNlICJGSVhNRSB0ZW1wb3JhcnkNCj4gZXJyb3IgbWVzc2FnZSIgdGhlcmUuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXJrdXMgQXJtYnJ1c3Rlcjxhcm1icnVAcmVkaGF0LmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4=

