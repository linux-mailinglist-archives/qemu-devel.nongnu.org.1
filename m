Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C297BC439
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 04:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoxDb-0005V1-K3; Fri, 06 Oct 2023 22:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qoxDZ-0005Uc-QS
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 22:39:01 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qoxDX-0007lN-RE
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 22:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1696646340; x=1728182340;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=b3lpTNowZ6ecdCOJK7bybJjT7OM7YDuIRpjzcCYIu6g=;
 b=mbzn0tvlKI0C52AMp7Un1SZPbebkxSDQrmkdWglJFmxzVJpcuYdfIQ7R
 +7vXAp+K7DMpeSNbWpRU6tJW99tR6PSyf4/L/jQiu4rVB2fP++OO3+pCB
 oUSvXW/OPiSUB0PaEiDbHzb+89DeX+Awxrklj1n8h/U9x6AzrRqW4swNa
 t9TB7NdTk+nw2LMTIPU29wml2moJtfypDt+JdesQC1tiCLlEfnxXSXyEQ
 fMDCLxZiV5Sn6Y8seZT/5Xb6EC2n7nUGqMQZ76UzqvcfofzjYQ0W9WW9z
 8x4rtrE+9Rp4m4R7jiBgWUcJMiquIkoW0qzvtSHOqWT5c5ygn1OLmvuuN w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="98347487"
X-IronPort-AV: E=Sophos;i="6.03,204,1694703600"; d="scan'208";a="98347487"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2023 11:38:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IljQdzM8x3icj1okTF1W+FuadGMRDWonbnFHQQSpjKP/VSs5oV9O6InL5MCoABFAt0Z60SMNPZdX8sWgVaHAyeP3BAnMb1yg2H+w0h9QeK54yzjnnnY38kIVGwSZKU1Nme0G8OTYXbYzHNEG8JrPn1pUeuWsq3Wl87zRpFWoAYiEWs9HzQ1x+GuZGaAAvVNkJlrzQ6vBJI+mkV/WlJQn+EFpo0ycBiImRrIX5ERQFeeIf1QWVhx8egxE8Fu8A9VGQAcv48I6fSZIHHdpIHE5eXy3Jqnng07okaECvcJ46ajQnVfgp/UDhNYtfIeDXEceJehA30z1ZNiDG+r3DhDAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3lpTNowZ6ecdCOJK7bybJjT7OM7YDuIRpjzcCYIu6g=;
 b=INSbi6baD+Y/7DbUU3wbeEOtkHyUO0Izg3h7ab6/ngI7zTtc85z4HFgmv/UlP43M0YzHoeUx1NeEqHFRddd8BqzdduXGISx2T/Tize83SbTM4+bsWF/F4oCWY7bCgrw/VA/avtuUzmRidWloFYW0W28MfljAKgr4M68myMChaSUQE/t7weWQr2xKBJz5s5g9bUogCRRRzAERB5H75va7woIHBM9Gvo+eAMWo4Dga1psmXtVYL/ARgODZg2mYk3Zg/PqXZA5MyIRfsosyH6q9UgcoEZB/oJpExCyzuISJ3fiwJbbHCt99pQmeuOk3ta16ymhAf2fAnvrCDdMd0zly7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS3PR01MB6165.jpnprd01.prod.outlook.com (2603:1096:604:d1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 02:38:49 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 02:38:49 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "eblake@redhat.com" <eblake@redhat.com>
Subject: Re: [PATCH v2 07/53] migration/rdma: Clean up two more harmless
 signed vs. unsigned issues
Thread-Topic: [PATCH v2 07/53] migration/rdma: Clean up two more harmless
 signed vs. unsigned issues
Thread-Index: AQHZ8g6NXoDuu4lXA0GFOok8UZIXMbA9qqaA
Date: Sat, 7 Oct 2023 02:38:49 +0000
Message-ID: <b7d52f4b-09d9-d748-2e9e-d739f5670cc4@fujitsu.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-8-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-8-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS3PR01MB6165:EE_
x-ms-office365-filtering-correlation-id: a320e70a-f859-434a-eaf9-08dbc6de894a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b4khZQq7FlnWtbWf39SHBH0H+ZlDzK00s9nQdznr1SnZ3zZAgcy19WwQXK7l64hDXn7alyOOeNJzhelubKj27CtH8/AvfPgQZcyTMKUwmD1t25ZCIyIkDw5JOlyzhcW7BgOIc/gmztS+PTI7DDskt2SyB5zsAdzC6zGZVf9M5dD+wdqdSkQRh7u0pS58+hz4fF0g8SnfVVrgzD9IcjckqfoPOEHOrY98gpkh+F/T/4V8ebVXmEB6xTVeVMteUb4Ju9KedKb7gJTM+6HuhxR1LngSUC+/x1TRSb5km5qu193B0A4irSw3qnL72HDgEW89gC0azYIuHUXaa5sG3itKgL0h+FON3vzX5PDOpaAOe+yi21hN8xcshtzBwJSElEp3v6nIa0dhAd8FdQClJU8Ddd43A8PCEug3GcZoTeIKLy+B8hUgGta9Wj+ljMiOdEBn2FgAOvjQxcZCZCciAFUSbRVhouffct4rDQj6/BG1HuqoeqDnPpAKGneG6BMEqwYNDj7kPGd8BjDjBTVKAefch6vWUNW7LnWaudfL1Rt2HLl/0ZJ0Hiyt3Zfd6GRYy2WrdvNzgWYR1cVFysvtSjKcxFjKfNJtF3gJRhrSF1jacpLdB0aBNBVvXcL6WbksLghgXoj38wDWqZ0v85VHCfHogwmqA5s8PFfhkMVH2elD2TueTHioS5x4tdG008uTxMcB+Eaef1MbWnF8UmbdwptvcQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(451199024)(1590799021)(186009)(64100799003)(1800799009)(31696002)(5660300002)(54906003)(316002)(64756008)(2906002)(66446008)(31686004)(86362001)(6486002)(41300700001)(66556008)(4744005)(76116006)(110136005)(66946007)(478600001)(91956017)(8676002)(4326008)(66476007)(8936002)(38100700002)(38070700005)(71200400001)(6506007)(6512007)(1580799018)(122000001)(2616005)(85182001)(36756003)(82960400001)(83380400001)(26005)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFBXZEhtWjdrWDIyRlZwQy80QUo4U3lkMERWMGlYWTM0dDBOOU8vNWd0bHFJ?=
 =?utf-8?B?dEpLRHVFWEI1bzlmZXRuKzBMSmVBQ203bW1pWm0yWVhHU2lDcHFzSkZJZzhk?=
 =?utf-8?B?Ykp1ZmJDbFV0WjFZc3E3ejBUc25GdHFhU0xwVXB0TTVMTVU0SWNEVkpHWVpm?=
 =?utf-8?B?WWxUUDBFRGhzQkp0N1BQZWxGYVY4NnJ1eEFQdldGdmZ0eWs1cDhXZE5mb3lD?=
 =?utf-8?B?Mnc1d2pIeUdoOGFEK1BtNW5pWk9qZnBLR3VIK0VyUmxRUUpjbXNDWlFyVGsy?=
 =?utf-8?B?YlN4SVM5NnNUQ29iK1hGZ0pPSUw4SlltRVBvWkdtOWZVY1BFK2hQVFk2YjNH?=
 =?utf-8?B?RDhrQmFEaGR2eFJ0SkdtTjMwSm5IeHpIS0tyY3d1SmVSRldmczNnLy9kNTls?=
 =?utf-8?B?NVhLYUhnRm90M3lTVmZROUdmYmQ1eENSWGdNdlF5cmNneHdCS09pOEUyaGZJ?=
 =?utf-8?B?WHU3UXpKVXEzNzNiRDJudnM3UFlRQzVFdHdRWlo0TGFJazlDT1VmZlBLY1Nl?=
 =?utf-8?B?WmZrUUd2cFZZNHJ4ZnhLL29rMjRWYXdlcVFjKytsNXJ6SGs0VkMxWnVpL2lM?=
 =?utf-8?B?K0tpb1JBNng2QlZhU1BsWkZuZFNuNkdGS0dFZkQ4QmxiSFd2ei8xL3VsOGFh?=
 =?utf-8?B?L1JYUnFwTTBPb0hFUWJ3TFR0VTAyQ0hKRFN5UHRDSnFOaXpWUnZtbytZMGY2?=
 =?utf-8?B?NGNFM3FmWG1wRlIzNWtoTFlZZWpLeFQ1eDZJai9uMFJ1QzF4SHlzZ0daRCty?=
 =?utf-8?B?TzJMOGd6eU5DOUpRN1FHc0dzVHY5eFltT1lXNUl2MG8yUUFnb0d6STJERElP?=
 =?utf-8?B?RE1TN21jQ01Fa09GQ2VmQnZZdHR4WlliUzNPQmVGUnd4NUlDeU1ScVNXQ1hk?=
 =?utf-8?B?cnB3UngrenIxSVRoQlRsMVduNUovNG5pTzFvUUN4cUpadUdvWFNZK1FRSWNZ?=
 =?utf-8?B?NXlLWklvTGF2M01LcGhvQ0k1VlBCUlNpTkUydU5DZTk2YzViU0poOUUvVmwy?=
 =?utf-8?B?L01TMVBlUG4zTG1Od0xFRUU2QVhQMTQyR3o1TWVJWHlGZFJ4V2VWUDdyOUpx?=
 =?utf-8?B?b2FvdkdmVmRIY3hzWGs4aXlPZkRNVTNxREViNEQza1cxUjg1V0MwdUQyWnZ2?=
 =?utf-8?B?ZmZjNXdwZE1qblF4amh4QVc0UnI2MENPTlBDOFY3MGNTdlpXVktVaHBYK3RR?=
 =?utf-8?B?WmxYd2U0c0pLZzNyTURJY0pKY2Jzc0FHd1E3TngrNmdVYmNjQjRndnBWMFhG?=
 =?utf-8?B?YTRxOUhQNlg5ZitPK056MlRQc0ZOVW9oQUJVckpRMmd3eEQrTURnMStGTlk4?=
 =?utf-8?B?V3RDOHJFcUxDR1NuL2t2V1duZFpLc0l2TFUrNzhtNm9EYytSc2I0MzRpd3BZ?=
 =?utf-8?B?c01KSXNpWlZ1OHE1WXNJMDFRZEU0cnJMR05wWHIxOUtPcjBkQlNlYk9SSGlM?=
 =?utf-8?B?aGZha1VBTHlyZjQrTHRxUzF3bmNwUTZRME0wWDc2aEZrTlQ0eHlKNWlOQ2Yr?=
 =?utf-8?B?VldWUTJ5VjEvNlZrK2cvZnBhbFh6bFVyY2pHb0U3V2lnZXVVMnd6RkgySm5X?=
 =?utf-8?B?NnJPc3d6KzJqb2xITUIreWxpeG9PZ1ZWQXJkTC9UYWprQ3JzbVF0Vk9mTTA2?=
 =?utf-8?B?ZDROUEJqcWJHbVBpampXelpwck9hK0x2R2FydlpsK2pGZ3pGZVQzOEdWNFFJ?=
 =?utf-8?B?ZjdZWVFFWG40STJmS21QbktzcEN4ZjNVcEtvYStZdlhxYWpic09IU3dGS3g2?=
 =?utf-8?B?aWhFM3RqSG9nbXlLb1F6VSt2N2NsUWJEVFBZcUs4anhlMFhzOWRKM0pRSG9W?=
 =?utf-8?B?andVMU1WZ292bFlQVnk5S3EyT2xsMlRKZUE2dVpyblY3bXc5eFAzQUtiTDYy?=
 =?utf-8?B?Tkw0MVMxZDBSeVVPbytKV0JWalNVa21VSTlWS3ZwMWpqQXc5RGVLeTJLYUE0?=
 =?utf-8?B?V05UOGZCSzU3VFFMVEpJOGJBVUZweEwrSG1VdXhCUGNMN3ZtR3llbEVyVVAy?=
 =?utf-8?B?c1ZhY3RZaUxDNjJQTjVxcXMvL0FHd2FpZXhnZGljaFh4WnZ4RFVPdnlqWThZ?=
 =?utf-8?B?Vnc1YnV3OGFvOTJZRTVGQmhscTl1dFIxMTZ0RXdMSzdRSjZQdzUxUFJRa2Zp?=
 =?utf-8?B?bkIxYmxaU29xck5jQVRKZE8zNnhQckxzT1dIS2dQelY2cTgxWVo5dUpOWDZD?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <163BA4BB08B2F54BA3D10E6EC1DB459A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: npLRxQVrXUlzVB/eypac0AxTXTMqqDk1kG6huj3Bap7rFmaJh/PZuhkWq3gBXjmUld+kQ1E13j7ffA5m/PXhSdLDCx4J+FQfPefPOUS8PUYrGJ055DBu6MbLbionRmpn5LsecVsyLTOvqjfdwUjQsmHfhyyoCZFjnBx71YCrdgfQfZrUGb6JcMmliQ+zL+RiCINtRTgea2MYg8vsnwfydxZLTdICn35FtaiEEz4cLrEOWML+5zaaYzD/0oHy2FNRfLoBoCVbOBinn9U6+y4KXJCkVZsxJFdbuUqkE4Jbtnac+Cta9iiaauZQ8H3Z2eTM/akTQmpGDAHjG+o8HwKNy+55l6AqsEpq11RapOWyHc54/bMNovaUD0wipW7ALsQ86EI9oaYXLRLB22vwMHV4phRueg9baAYdP3K6yP3VvJVB6ssVNYte2ru6q1We29cRRmkYy9bXx7ifC9C8Y0jpRXIJO7j3/ZG+D+k0Z5J6XRTKJ+BzSSZSHGLGuDd/vogSkRks9GXGoJbuWH/UjWdZe2fT8Zs/R0wLI1sikjO8xfazeIFDOHCMhEPjZXQPHJBCL569SBW8dQRaaUp5iQZLzIVuJWn/3mu6B7monO3kYCAH+5ptOAKDOr1Q4plxrnVGfFnIroK69CfcRXJPObsXcmeBXdBh5CIwMduuhrjx4gVEEFto+fkA+2+WpaEFR64cAlRuKBcuqn/3pFXqOZAZ3nvrIFHcohu9DYyX03L/9xBIdJPmxMIjo5u6FZKdM7GzA8RVGfmdyRMzST0cCxseFPRxYTkZyBBTT9A6V4Z1wyhm1nvpBSzewRCNpbKkl/TK
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a320e70a-f859-434a-eaf9-08dbc6de894a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 02:38:49.0918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tod4Bfpg9nniv8fMROBccjSeQLhyjZYJe9fMoTvZWo4YhZ2wlnwyveiuA1ZqQ0Q894wZXWgSJYPxkrqiQrBXsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6165
Received-SPF: pass client-ip=216.71.156.125;
 envelope-from=lizhijian@fujitsu.com; helo=esa12.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDI4LzA5LzIwMjMgMjE6MTksIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBxZW11
X3JkbWFfZXhjaGFuZ2VfZ2V0X3Jlc3BvbnNlKCkgY29tcGFyZXMgaW50IHBhcmFtZXRlciBAZXhw
ZWN0aW5nDQo+IHdpdGggdWludDMyX3QgaGVhZC0+dHlwZS4gIEFjdHVhbCBhcmd1bWVudHMgYXJl
IG5vbi1uZWdhdGl2ZQ0KPiBlbnVtZXJhdGlvbiBjb25zdGFudHMsIFJETUFDb250cm9sSGVhZGVy
IHVpbnQzMl90IG1lbWJlciB0eXBlLCBvcg0KPiBxZW11X3JkbWFfZXhjaGFuZ2VfcmVjdigpIGlu
dCBwYXJhbWV0ZXIgZXhwZWN0aW5nLiAgQWN0dWFsIGFyZ3VtZW50cw0KPiBmb3IgdGhlIGxhdHRl
ciBhcmUgbm9uLW5lZ2F0aXZlIGVudW1lcmF0aW9uIGNvbnN0YW50cy4gIENoYW5nZSBib3RoDQo+
IHBhcmFtZXRlcnMgdG8gdWludDMyX3QuDQo+IA0KPiBJbiBxaW9fY2hhbm5lbF9yZG1hX3JlYWR2
KCksIGxvb3AgY29udHJvbCB2YXJpYWJsZSBAaSBpcyBzc2l6ZV90LCBhbmQNCj4gY291bnRzIGZy
b20gMCB1cCB0byBAbmlvdiwgd2hpY2ggaXMgc2l6ZV90LiAgQ2hhbmdlIEBpIHRvIHNpemVfdC4N
Cj4gDQo+IFdoaWxlIHRoZXJlLCBtYWtlIHFpb19jaGFubmVsX3JkbWFfcmVhZHYoKSBhbmQNCj4g
cWlvX2NoYW5uZWxfcmRtYV93cml0ZXYoKSBtb3JlIGNvbnNpc3RlbnQ6IGNoYW5nZSB0aGUgZm9y
bWVyJ3MgQGRvbmUNCj4gdG8gc3NpemVfdCwgYW5kIGRlbGV0ZSB0aGUgbGF0dGVyJ3MgdXNlbGVz
cyBpbml0aWFsaXphdGlvbiBvZiBAbGVuLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEFy
bWJydXN0ZXI8YXJtYnJ1QHJlZGhhdC5jb20+DQo+IFJldmlld2VkLWJ5OiBGYWJpYW5vIFJvc2Fz
PGZhcm9zYXNAc3VzZS5kZT4NCg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBm
dWppdHN1LmNvbT4=

