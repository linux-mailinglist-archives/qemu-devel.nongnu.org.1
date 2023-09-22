Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC0B7AAD84
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:14:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcDn-0006oW-EA; Fri, 22 Sep 2023 05:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjcDl-0006o8-Dc
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:13:09 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjcDg-0007SI-5t
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695373984; x=1726909984;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Tb6Ymc0AJzBKCWvTHOzGq2dODinJZYROA9dIKRD3Fc0=;
 b=sQ/hU2Gh6tmNZsxOxg+ZtDq61Xlu126asCTNGe4Z5H+2rWZ1diun96Rh
 ljxiMYMSzun9AJZnQ2U3b7HW7BZSc6a7EgLv/kaYLBocscZ1YWankspCX
 rdrCWZ3wyU2EzwhgFuUv3c/SeWvTxPeurovmL9q36tZH0x0dZbtDnSorb
 kunp0jwRFkBww5rJN/J4Awe4LI8QGYgOHaFdRZJBoQTkfmqzOEs8BDx9U
 ENOzGvPHzd+Nnx/FF9df8zzSAz7WgYDUPWCN+6YJqwZlhdqu6gHsUvbNl
 WBZXnHiOavYAGUwFD3QcDGfyJq0L3dDoodgTWQB0QeVT2l+YZQN1gN1Hl A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="96216355"
X-IronPort-AV: E=Sophos;i="6.03,167,1694703600"; d="scan'208";a="96216355"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2023 18:12:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRcFPmA/H0GtC1p0G2Bm4LwM22rIrD7LGo1ab89kVeAdOpm08h1S97xf4gIFL0LhY/ZfpSP7n9UQZFiTjTpURlBw0Fr3CvmP8refjVDjwahQ2UFF2dbD6U64lpzF0Z6ni/8xVGRBDnStHpv2G9WboQpXaEqeIhb5LoQw/9XF/LvP1AioywHXNiXIKJbGDmRswVudqzTHsrDKVRzaPc1kv6tOFDvjB/PPMsUhWkv6aKOjEf8BfAkFxqaYXHYXRsD6/1PTHdfaOzHqGqaBbMP9pfstMxjpgYsmtJQqXaHRHtHzEKS2jhWmey9lc52TIrrA6twYmmlL9IxicbncjlCfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tb6Ymc0AJzBKCWvTHOzGq2dODinJZYROA9dIKRD3Fc0=;
 b=AmJMvezuRrJJTzFAPH00Ui4ZOIX3DIReB46J25v/F6QxZ5Oka+q3HYL89la91PjpmiFgfwiTVrohYFXo4rAni2IQk+D98Mllq9AUyj0LwzHq2KbOFVcTP3m0JKUDyaVlA8zeBgzUPtWwX2Msmuuo5QSuB+DkGkkguOPhjemkmLFQTlDv2ldJX8x/qvw0b2YqVmB0VYZNFPJmJoBFtohLbaW5gvZPqTTxqylsobgdVqj2dacsI0W+NGLakArbkCOFysqJmKTVEn2+nFE2705nl/N7dNSgAnMCIcCRK5b/ct68xN0mR9NAKBrh9KJY/IrCiQTVXJc8alaJouHCc1hT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS3PR01MB8585.jpnprd01.prod.outlook.com (2603:1096:604:19e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 09:12:49 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 09:12:49 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 19/52] migration/rdma: Fix qemu_get_cm_event_timeout() to
 always set error
Thread-Topic: [PATCH 19/52] migration/rdma: Fix qemu_get_cm_event_timeout() to
 always set error
Thread-Index: AQHZ6j85TMWLa/lJskmDxM4VEcS+tLAmlWoA
Date: Fri, 22 Sep 2023 09:12:49 +0000
Message-ID: <ad770539-7416-1c23-c163-8a7b920cae4c@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-20-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-20-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS3PR01MB8585:EE_
x-ms-office365-filtering-correlation-id: 4fa220bb-4c1d-4f35-7acb-08dbbb4c17f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: omwx+55XaGXvSNx6NPMxXXFr4qDheHBqQkQFqpAMZxMvMvMpH2Qwq1lf5RFV9LOUil14uz36qrSGyLUPvK+XtDYyyVvwvt9JuZ7N9TzIU+6GTelZDI4U1XjRRow6j8jBHVnxJB3y7LdT1jwX1+MJk3PvJ8etvLicI4CoVCbpc000Nj45CKcvXx+839NudbgaCUQj4K4Ta7Tzec2J5M8JYPh2CBJYjblEz/+9cms3rhzqbywN0TAFmEeVJMi4UsfT3zM4pgP/GNUxwNl7C4FmYTx7P8C2oxo5xNd+UioiaJt11A4MfKlSwHR9l/nbUD+dX906lO+IEy5wQQafhKSxOurNQLeZlXCqQYE4uuGX0lcUghu3unIM4skTVFHPtfyo0M46/6MGjcZ4aCXD7verEhKBGr3R8/afYl4llGytrAqMPVe9TLh/qmFR1TrULFxPfiS1QPeVdTiD+Epryu9zdA4eZvzeAnCH3tGGToqKo7WU4L5hbO/aOgkzmXiVjcffB6GER9uXrb68NtSRtCkU0TDiMgQaX5KfzdPeHXlx8Yx48ft0hDnJ+Vd5tG9TFr1KkPu0YOhWCqii4dcNcOtcsKzK5WFzqrgfBtiaUVUkRK8+hb4mGkCNCffn+zHjl4W6pPFQo5+D8ML+vLaNXPeM/SKHSxlxZEc6qezVvhgurXNor8eEytl7+uTXiyJs39MbxWCfGFR/sNDKispGXS0LSw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(1590799021)(1800799009)(186009)(451199024)(2906002)(4326008)(41300700001)(8936002)(91956017)(66946007)(110136005)(316002)(66476007)(66556008)(66446008)(54906003)(8676002)(64756008)(76116006)(5660300002)(1580799018)(83380400001)(31696002)(26005)(2616005)(53546011)(86362001)(31686004)(122000001)(38070700005)(38100700002)(36756003)(85182001)(6486002)(6512007)(6506007)(82960400001)(478600001)(71200400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUo0WU04OEx3VDc1ZnZzS3N5N1NQVGtSYllVVGdaRnRRSTkxUHhNYUtYZHhJ?=
 =?utf-8?B?T2dOK1JhQllCTk9zY0w3Qmt0QUFZTUUzTExjY080KzZIclJLQnhJR2V1VjZs?=
 =?utf-8?B?ZUM1aHFDNkpSY3VNNHBJN3B3UCtaSUlSN1I2ZytCTGdTaW83L01uVkdrT3RQ?=
 =?utf-8?B?M3VFalRPVVRJQTIwMDcvbE5aVGFJMFBJbDlFTTloSTNvVmhZRkJ6dDlvUHYr?=
 =?utf-8?B?UXlSbVdLRGtOTzFHc3pTd09iZHhQYjdaKzUxZkhLUHl0cWwvQnlXSVNrUVFH?=
 =?utf-8?B?OUhBcVRWRERtVWFNY21XbFcvaWlUcWNKS3BUenJDQ1JTdmFuU1VuTTh4ZUNX?=
 =?utf-8?B?MkJmc3hmV1oyOGdma0gzMEc4Y3diOGxYZTFsd1BySUUvSGhpMkdrTTNJdU1R?=
 =?utf-8?B?ckZiR01QMGkxa2VpYy9kL0VpUEY1RFhIdk85eHpJK0NTWjhmWGlYNlo0bVJ1?=
 =?utf-8?B?MFA3RUpkZEU2V09JYzZGYVVNYk5nbXR6WDNBNDNxdlg2VzVUSVBNSUcxN1VI?=
 =?utf-8?B?cENaN2tLY0RXL1FnVmZrK0lFbXYxUjd1cW0xdWhVbElNM25vNUpxTXFGSjlJ?=
 =?utf-8?B?L2ZVQTNFYmU4S2lIQzQxdUk3cTVoVDYxOFcwbVBOd0pjQTArbm9LMSt3VGc2?=
 =?utf-8?B?UjhzYzlXMVJDZmRPNy9jc0NtNEl6WFFrUEhPMWh2S3p1OUhOc0xoTW5rM21o?=
 =?utf-8?B?ZGM0ZnU2RHl6Tzc3ZE9YcHdDbk1QckxQVDFGdDA5NkJFVFlwSDh6cituK1RL?=
 =?utf-8?B?NGlQa0p2eW5BTlN0SGN2aFR2bmJCZm1CdlNFOHJxckRnQVBTUXV1UjZxQVo1?=
 =?utf-8?B?aFZJc09MZUJhQklmbnkwU1l6cWw3dWZ3dHE4QjhvSzJ6SkhkdUlCMlJDMDl1?=
 =?utf-8?B?bEhKMzZhM3hURWVrZU9xM3RwdnNpcUF0WGVnbjc5amIvdmJUdEZuY2tpSHdn?=
 =?utf-8?B?ak9oR3dOMGZ0L1Arei9tRWhRNmlIVzBYSTlIOG5QZWRZRStpQmdySFdWUmY3?=
 =?utf-8?B?VTJyUEYreWYxa3c5cEF0VzRpdnVEMXkwTWFMTXlzNEhPQjJCMDFCQXV4WFVp?=
 =?utf-8?B?NnpLQWF4bmxqWFpLQ3IrOTBIZmc1Ny8yVWtxclp6ZmY3N1h5RnoycElHazA3?=
 =?utf-8?B?aVBVNk9NaU9tK0k3VmRoOVhWaEQvM0s3RGpkYXNTVDkrdG04dld5a1c3ZCtI?=
 =?utf-8?B?Snp2dFlnRUkyZVVOc2ZuZWtUbXB1cHdRUmxRUjdVZVRaUThsbjEyRFJzcFVL?=
 =?utf-8?B?ZUxEdUhoK2xBbU1TRTNOVit5aEpGMTlrN1BNT1hZYlNxRnNBZDF3bEg5RTNs?=
 =?utf-8?B?MmFIM0NUVFdDOGN6RGhvaEYvczVXQ3lWVG5nT3V6dVd6MWlOZmdGOERQTFR5?=
 =?utf-8?B?bVJ3S3QvTm9lL1hTeHo5RDBDVlJnNm1UK0FEV3AxM1MrMlg5Y0g5QTl5U2Iv?=
 =?utf-8?B?Y3psWjhSTVBNbnkvZUpaeE9YM0pRVlU4ZU5DOW5kTHRwWm16Q0JkQ2VZZWVa?=
 =?utf-8?B?dVZjNW9palozUlI3Y0x4VFIrSnREaWdOMFBmVStFcklTaUVPbU1vUUd3WUE4?=
 =?utf-8?B?dEx0NUMvSWNRWXhFOFZjVE1RNjdDTk1jWDBUenptcTJYakE2WmxCMUdrTXJV?=
 =?utf-8?B?T0pmdFdtTTBLaXd5eERVU01WeUlJa2VPUE1TNzV0QmxJRXdUQXkwelVqb0Rv?=
 =?utf-8?B?VlNEZ3RxVGlUWHBOdlN6aFZ4K2tQQ2NSQkpMWmduekxaeHA1eVZQeU9JNUxE?=
 =?utf-8?B?c245OEF3TGI2d1ZSRWRKclg4eVlDWk50MmppSk8ySWNYeVY2eHRRWVNjL0xo?=
 =?utf-8?B?a1FyYzJEK3JXRVN2YVZRODA1N05mZUpLeE81ZW1kNVBXVCs1Y2w0RGpqa0FW?=
 =?utf-8?B?a1BsVVRJNHFMb3ViU0hHNnZaMDZ0V1pZWW9JNms2M1hzQ2dublVGdStmMWNx?=
 =?utf-8?B?bEhxZkxjUmJ5VTBvRitUNUZDNEMrODF3d1Nzc3ZOOEdKZkoxaHY1TnpaNE9n?=
 =?utf-8?B?djV5WVFYOEgwK3NJVzQwUXpyT1JUWFBKOFV2V29FWVZYbkhsVXA2TTg0Tk94?=
 =?utf-8?B?Ly9pVVo3K1RCUE14Zmt0SU9Rbi9tY3NhVTl5eTY5ZVZqS1FZTmxleGxZU05R?=
 =?utf-8?B?clJjUlFkVkV2RUErTzlDY0h3aFFzbXZwNXFCK29vTk9JaFZWckZqbk5DcHBm?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E59ED058A34C94191A862671FB219B6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b8LgfD4pq9Gd5ScjkaBAew09wYCx1C5+3qccJE/n4lC+0rR8YV6XKZygdoJlriY5HgC0MJKveY+DmRnsjkulbbEEoNNlRtKQU7GqTH2BCzi2+WdNj42S3OzO63dt32/KSCd3EGWl+aHi7yHI6TVjJR/OLre8Y4anvFyAW0OuTQ8PgwBPkwkobhQZpp7Y4f4Vxqu/fTdhSC+4y12kjjf2MZg/uaWYB9a7Z1alRmpEy1cl0qR+VTcCuqJVmlJUrFO3O24Gz1e4pyZPtVK7sndMOn3MjVpXzLnja/8EdAekK5w9YbmfVy3Zblvih5jtRIG1Bl6WM/3Rsup868I36nyF95aPgwq7RyEzUzubQ+L7W3iqHYT8u20w/QQH5DiXdWgOeK63qoY6uJUvOHgMUzxU0QhDfCTEi2EPaHEe5HYwJEIpPSFm67HLsqMeRolizdZWfWG9i3kQtTw9pER2kJ9Orc+wAeeQHvkMMgw2/SkrBG3MgO7KK8SgBWda7QyLzXP3kqWJMdc1wUfBtXh9YqsiNkwBjxyuMU5S4qF1/bxevkAp5snj4P56+wSWL2u8WHBv51G8mCZnBubHFQD9l5A8lHJXkv1FDc+lXyMUF0vfMvRPFDUPRn0v3zLXAr/dlFtMCXb+Jl7GW7XpWxj0q8Nl+yZAwEVYQec7kIPjMgZfHnrWfva7Ym73NYuU4t2GY2z7iveQsw689nVMs8c/H8atXjNY8A87VC076CI0dc/XwYvFyfcXMGVQD3qq0eHqxEzE2nXGNvkpVEgxFIXFpn5TzjXIYYso6NU7AfMBwE3z8fs=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa220bb-4c1d-4f35-7acb-08dbbb4c17f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 09:12:49.7023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7LUloh+4A8patyo7GbhKW7r41RnCVnThKvXATAp1yTPOjTo49kTAFQXLup1IlAsd8e8b4q+3bvOXoyKOd2TkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8585
Received-SPF: pass client-ip=68.232.159.83; envelope-from=lizhijian@fujitsu.com;
 helo=esa6.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBxZW11
X2dldF9jbV9ldmVudF90aW1lb3V0KCkgbmVnbGVjdHMgdG8gc2V0IGFuIGVycm9yIHdoZW4gaXQg
ZmFpbHMNCj4gYmVjYXVzZSByZG1hX2dldF9jbV9ldmVudCgpIGZhaWxzLiAgSGFybWxlc3MsIGFz
IGl0cyBjYWxsZXINCj4gcWVtdV9yZG1hX2Nvbm5lY3QoKSBzdWJzdGl0dXRlcyBhIGdlbmVyaWMg
ZXJyb3IgdGhlbi4gIEZpeCBpdCBhbnl3YXkuDQo+IA0KPiBxZW11X3JkbWFfY29ubmVjdCgpIGFs
c28gc2V0cyB0aGUgZ2VuZXJpYyBlcnJvciB3aGVuIGl0cyBvd24gY2FsbCBvZg0KPiByZG1hX2dl
dF9jbV9ldmVudCgpIGZhaWxzLiAgTWFrZSB0aGUgZXJyb3IgaGFuZGxpbmcgbW9yZSBvYnZpb3Vz
OiBzZXQNCj4gYSBzcGVjaWZpYyBlcnJvciByaWdodCBhZnRlciByZG1hX2dldF9jbV9ldmVudCgp
IGZhaWxzLiAgRGVsZXRlIHRoZQ0KPiBnZW5lcmljIGVycm9yLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPg0KDQoNClJldmlld2VkLWJ5
OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCg0KDQo+IC0tLQ0KPiAgIG1p
Z3JhdGlvbi9yZG1hLmMgfCAxMCArKysrKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24v
cmRtYS5jIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBpbmRleCAwOGNkMTg2Mzg1Li5kM2RjMTYyMzYz
IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vcmRtYS5jDQo+ICsrKyBiL21pZ3JhdGlvbi9yZG1h
LmMNCj4gQEAgLTI1MDksNyArMjUwOSwxMSBAQCBzdGF0aWMgaW50IHFlbXVfZ2V0X2NtX2V2ZW50
X3RpbWVvdXQoUkRNQUNvbnRleHQgKnJkbWEsDQo+ICAgICAgICAgICBFUlJPUihlcnJwLCAiZmFp
bGVkIHRvIHBvbGwgY20gZXZlbnQsIGVycm5vPSVpIiwgZXJybm8pOw0KPiAgICAgICAgICAgcmV0
dXJuIC0xOw0KPiAgICAgICB9IGVsc2UgaWYgKHBvbGxfZmQucmV2ZW50cyAmIFBPTExJTikgew0K
PiAtICAgICAgICByZXR1cm4gcmRtYV9nZXRfY21fZXZlbnQocmRtYS0+Y2hhbm5lbCwgY21fZXZl
bnQpOw0KPiArICAgICAgICBpZiAocmRtYV9nZXRfY21fZXZlbnQocmRtYS0+Y2hhbm5lbCwgY21f
ZXZlbnQpIDwgMCkgew0KPiArICAgICAgICAgICAgRVJST1IoZXJycCwgImZhaWxlZCB0byBnZXQg
Y20gZXZlbnQiKTsNCj4gKyAgICAgICAgICAgIHJldHVybiAtMTsNCj4gKyAgICAgICAgfQ0KPiAr
ICAgICAgICByZXR1cm4gMDsNCj4gICAgICAgfSBlbHNlIHsNCj4gICAgICAgICAgIEVSUk9SKGVy
cnAsICJubyBQT0xMSU4gZXZlbnQsIHJldmVudD0leCIsIHBvbGxfZmQucmV2ZW50cyk7DQo+ICAg
ICAgICAgICByZXR1cm4gLTE7DQo+IEBAIC0yNTU5LDEwICsyNTYzLDEyIEBAIHN0YXRpYyBpbnQg
cWVtdV9yZG1hX2Nvbm5lY3QoUkRNQUNvbnRleHQgKnJkbWEsIGJvb2wgcmV0dXJuX3BhdGgsDQo+
ICAgICAgICAgICByZXQgPSBxZW11X2dldF9jbV9ldmVudF90aW1lb3V0KHJkbWEsICZjbV9ldmVu
dCwgNTAwMCwgZXJycCk7DQo+ICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICByZXQgPSByZG1h
X2dldF9jbV9ldmVudChyZG1hLT5jaGFubmVsLCAmY21fZXZlbnQpOw0KPiArICAgICAgICBpZiAo
cmV0IDwgMCkgew0KPiArICAgICAgICAgICAgRVJST1IoZXJycCwgImZhaWxlZCB0byBnZXQgY20g
ZXZlbnQiKTsNCj4gKyAgICAgICAgfQ0KPiAgICAgICB9DQo+ICAgICAgIGlmIChyZXQpIHsNCj4g
ICAgICAgICAgIHBlcnJvcigicmRtYV9nZXRfY21fZXZlbnQgYWZ0ZXIgcmRtYV9jb25uZWN0Iik7
DQo+IC0gICAgICAgIEVSUk9SKGVycnAsICJjb25uZWN0aW5nIHRvIGRlc3RpbmF0aW9uISIpOw0K
PiAgICAgICAgICAgZ290byBlcnJfcmRtYV9zb3VyY2VfY29ubmVjdDsNCj4gICAgICAgfQ0KPiAg
IA==

