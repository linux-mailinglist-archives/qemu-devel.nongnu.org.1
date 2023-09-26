Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F03F87AE503
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 07:26:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql0a9-0006Ej-TF; Tue, 26 Sep 2023 01:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql0a6-0006BR-TM
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:25:58 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql0a5-0002NZ-C9
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695705957; x=1727241957;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=EDpKuKn7EWgO2rVO2VJvsMNZXBq/2ddowfZerb1fa8o=;
 b=HGmOdHD3mpuIC2argTm+Y581UEbyiAbas7pogOHXWDhun+bFQ5hq+6uR
 M1DB26mQssuNm3ixydxaNw8Mv/1oB7CgX7DJwR2AilIxEgZhm26fM4GL2
 4DsPTbdafdT68DRH4X4mQQ7zffS4NeawGrpEDyXmsuxhNQQXhl5/9DwZo
 fI1/zq3FtepuVfbHuHQj9qS0WSE8JMJpfzJDz7HPSRCsrOiW+AuZtngsM
 3ZDxXX1zX9bBMv2AvO+v4EZRCNk3fLZu6xAOuttkcB8mZ+mS8y5xxswSu
 IL/M0AtX172+2z8N77sZkhWq3Mbxu+hVSiINUVNjy08uwZMDqXv7lCjBx g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="9719778"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; 
   d="scan'208";a="9719778"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 14:25:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKL5TwYQH+f6QhCdWNfznDlrLSwX5mUvHJeVXwHiseAzJF89m6uz1d8kE4dwCm6hC6bq3xIUuMBF7xk24uUthw7W5IEGVKuX3Y40uJBVYXZb80h+LhQakSQ2pvGtsFlg40KVdXEHciwcmLuc2S2+o/sW4rweIOKjBWCSAMoMHbBgxCLAFIBQwEhTrVRTQVzp0Xpjh/scyw1HgFN5iHkkC+9yzFhUmo2u0VNAxN5CNy3r/ONaqVEqaL9xL8hvEdksG02PBIA3c7zfuLlaPY0Q96AhKd/UsBL/lqA+D9aPGoO0TXElwNpgxvDJavkwNnccmrDfVfQIR53JDQSYtCkTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDpKuKn7EWgO2rVO2VJvsMNZXBq/2ddowfZerb1fa8o=;
 b=h56d9a3uhQejf8sGQTeR6l0fF/CVYsh6pIPKXX467NIY0E0qBiAdpy3fSRbAve1ZGmkBUOXGTTwSLfp+G7dTbJSGlJ44+bGLoNZG7vJTrjzh7xxV2KzSoSBYDUD9gsXGf92u/4nq0uVIcq7+jzLuWm0KbLmjIPpJfPtT0HNatIIeIfhTs3IC9D+bj3EO/qy9XMZSBq7bcrZq5U8kgDWtfmun0RY9XnDAu0t2Q4AD6XdC9lkFBdb4HdkPMLjrdAjGoSWi857kSUt0cxEsAQHxdiz5wsyydkwZbKi2RQxn1HFbpOamVnWGfh9D+lAcdqu2yjj2DKJvmNuFFoyFl1Pa4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OSZPR01MB8123.jpnprd01.prod.outlook.com (2603:1096:604:165::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 05:25:50 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 05:25:50 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 40/52] migration/rdma: Convert qemu_rdma_write() to Error
Thread-Topic: [PATCH 40/52] migration/rdma: Convert qemu_rdma_write() to Error
Thread-Index: AQHZ6j83AH1criALoEWiFW1Bhy0UjLAsn1EA
Date: Tue, 26 Sep 2023 05:25:50 +0000
Message-ID: <fd3bd7bb-7424-7db9-9db3-e73d0844d3b3@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-41-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-41-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OSZPR01MB8123:EE_
x-ms-office365-filtering-correlation-id: 6e114b26-0f4f-4ac5-fb03-08dbbe510bbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wvGScl++NW2uNkXMu7hRcIQqEnnxJIO7/DYsH/RXzXm1Ko9bAJuqdsiUBdw4p+T1hCn39jteEL5b44nWFojmfEJKRj0lozIwtjG2ZBUGtZ/YiaI2zSLQXZZGSpK/ZZ7Rsaf6ztgKRhVUtfRCNUUo5ylgczMYR7pa2AN7fZDC1BUNOFR7jjfU1rLyoJM0hbNlGuVp9EDRpbrPtXwFrS8GpWy0+PT1HZM0L+h7hVpgpEb7kWDwBUIdGJy1tbwZh2M254ewBDDkoqaz54HBChNAuCuvhcSJwyr8+b8BlNzLavdnD/3IbBG9NlwCuYhuWED32gQutAdLohefya0qXFR7OL6fea5FT897kA1pewl31GiAh6OEtmOsiUguozAcDAZlLEDjxQFIbmSw8dATUJ2pr9MDtsKk07nis9qg4dEGrv3TdoePYg4f6EVjGxlmVDQp9YAWrvNnWfjwwaNNL9wfG4jH4/OYyDUbvvnirRmmupoP5g+zfhmJaMoFlnc23lUKIMLY1UXzV8q1K11qtww34aJl/c0+6+H9TNnH4D5PNzNbs4xGg+I2Dcuh02sF1r+AoMwbzhJmoAAAA15rgu7BJjQ8sDiBXcHNO7Kh2Acp3rxENyum0F+iHFXCAh9FD0n3OmRDjy6rhnn3WwIE3fymabb/68EngOkX1nO+YKz4G0T/lyzXFCKUPhSMtlGz7p/DHkYIHGbHWxkwy462AgRP1w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(1590799021)(186009)(1800799009)(451199024)(38070700005)(558084003)(36756003)(122000001)(38100700002)(82960400001)(85182001)(86362001)(31696002)(31686004)(1580799018)(76116006)(53546011)(6512007)(5660300002)(66476007)(2906002)(2616005)(478600001)(41300700001)(316002)(66556008)(66446008)(54906003)(64756008)(91956017)(110136005)(66946007)(6506007)(71200400001)(6486002)(8936002)(8676002)(4326008)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGtyTDZteEthUGZxUW5MWlEzQ0p1anNWNVViMllxeW1ObjE3aG9FZlZVNnNy?=
 =?utf-8?B?dnI4NkhJazFHdTUzKzRjY3ZqY0xqcHJ1SkVSTkl0dWtzdU1HL0k2WmxkcHpY?=
 =?utf-8?B?cFI3NnFZU2Q3VXRSQVV0QWNSQmhEUTNYdFNGd0JHbkU2S0dUblN1YzEzeTlM?=
 =?utf-8?B?L0I0R2JQbG41cEVHR0xLam9uSUh4RGZCWDBSZXdBQkNJRkJyR3A4MDhwd21h?=
 =?utf-8?B?bEZVNGdsUForeWFXbEphY2hYdHJ0NlFOd0NMazZYQklRQTFwMThWL2R0R21y?=
 =?utf-8?B?T0w4cEtFZWUwTWZqV3RFbFdXeFZKSVRqYjlSZTNPVWtNTGVYOXh3OXlwTk5h?=
 =?utf-8?B?OUh4YTl5Rkk3eFNnckxUK0pQUkhRS0l4WlF6SklVZTkzVGs2RkdEM0hGNWZ6?=
 =?utf-8?B?TU4wWEtRRGtUOEJOTThEdjU4RVYxN0FIWVdOWHhVWkQxVVN6c0llYkpBdDRE?=
 =?utf-8?B?YXE4MGpRa2tPb2tPbXN3cjJOcG9hUlVmNWt1bGFDK1BXZDUzYUlTMTRyZytZ?=
 =?utf-8?B?VWZhSGhUQjNOV29ydEViaTVlOUtKaVl3MkZTN3JYM0ZWK1NxL0ZHb3V5c2xR?=
 =?utf-8?B?MytqZFc1c2FnNVVlRXdEblcyR3BtMFF0TnRwOUhONlllVkJNY2RPc0J6NHNw?=
 =?utf-8?B?YzV5UDM1a3lPWmNVZitHaGhVMmlVUm9kMG1lbWN2OFBQYzdZZGFLdkxTNVNY?=
 =?utf-8?B?bnQraUtNdGQxZmE4bUpWTkFtandkOHoxUEthLzg3dWlRMk90aGQyRnMxTEJL?=
 =?utf-8?B?VUxIZ3hOSGJkYWtzelhISGNDL0FIN09CVHQvdG90ODl1Q0E3eW5RYnhjQU0y?=
 =?utf-8?B?SHovb2NmOUNSNHBGbnpaSU9lUU9rK1lLQzBBYlVFMFJPZVgwRlpUMXJPTWI3?=
 =?utf-8?B?ZjhodUl2Q2x1T1pnMURiN3dOTlRiZlA5dmZkQ3BIdnZNbmM5b3lpZkpkV0Nm?=
 =?utf-8?B?WHNvVHZYenZaRFcxUnZSa2FIZzN1WmdNWk5ZSUl5amlTT0RYY1N6ZGZ2ME8w?=
 =?utf-8?B?NEdmQ3NucitFVnl2eEZGQXhUb0QwcWdnT1NzZ0hFRCttcGhuMFZ0MXZ6cS9K?=
 =?utf-8?B?OEo4NkxPQTYrZXRyd0dzY2VLeXhxUm92N3g1US9Ea1NxbHNFYjZNcXRRVk4r?=
 =?utf-8?B?ZC9VUDQrdVQra2dIdHI2NElXWUlsVW1yZU9kVHUrWFVQTlJvRjdaaEFpTnFl?=
 =?utf-8?B?bmFHZUNXRW5lY3c5WHFKYk9QMnpIZmZMdy9uZ1lTRnRkWFFzTFltSXVlaTNL?=
 =?utf-8?B?eDJ5UElrcEhCZVN5NVFFL2lPcVJTTFFZZjNSZkl5YVNveEtqWVdFK29iaWJy?=
 =?utf-8?B?bm5lT0MxUVhDTlg5S3RwNEJQTlBYa0xDOEl2eDBmMTc4OFlEK3A5UnlnUWl5?=
 =?utf-8?B?eEFESmZwL1JOejNBVE5UaW1CdGdjemMvSUVSYzNqOHJHUWdtelRkRTE4cVlo?=
 =?utf-8?B?U2hyNklHZlQxWWtBZlp2MjBjaWhHeGk5VnRJcTB0b0g1cFhYbnAzTHkvSFlW?=
 =?utf-8?B?aE5SdDFhbjM4SEEvMGtBTU9Vci80dnYwc1pxY0N1MGt3U2FqRVAvQVJNUlU2?=
 =?utf-8?B?SHFzbExvVXdoN0s1V2dmTDV5SE9JMkZMcGlBZCtGbUhWb2NLTUdnUTQzYkhC?=
 =?utf-8?B?eFVZT3NpQjZwMzBzZGxZZWpPdS9zN1pKMWRvQjN2aXVnNTUyOHdXdGxhOXNu?=
 =?utf-8?B?anZiL1lvcVZOY3FKRlZRam1Hc0ljYzgrVTJzVEtHTmtsczlHNzFqS2VUc1lS?=
 =?utf-8?B?M1VMU051WWJGOEJFc3JoRXkzczVVdlg4L2dmeU0zeXdySmYwZ2hEa2NOQUc5?=
 =?utf-8?B?cFI3K1FRblJmMGEwb01jdlgzcHJDV2N6aE1FZDZsMS90eTRmdGJXRjZRU2Zp?=
 =?utf-8?B?Mk1YTDhFS0ZwRmdQei9jQzlVaG5EdldNdVphUU9ETTZ4V2VjL0J0dGU3TUdv?=
 =?utf-8?B?d3lWOVc2MlVTQW85cjhhbGdsQlM2a3ZpUEUycTY1ekY2azhKWGhCSkNWODBS?=
 =?utf-8?B?ZWtHMkN5VEFBRG85bWpuM0dNV0pIS1hvcW5nNDFjeXBTOSswakxJbHVjWG9J?=
 =?utf-8?B?VG00MTBJaDdocmhGa01FTi8xV3djWTVkbkttSlBDTnRoU3kyOHBPRVRsSGJx?=
 =?utf-8?B?b2xlYWxWa0xKc3hPNG9ORWRIQVBjbmFnMHhjU2U5RE5ZV1drR3pxdmtRSk5S?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D60DCF977A6AC84CBE062ED1976EAA64@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9oMOzv7imY7DyhMueEdDj9qNZ4lO2381yE7YP4UQJX5N8ur80XLY+4ncMjuQ8CrVbMUMYRgS7keOuOofKyyGlGCvpopcdW+xjfyqvX7mmRy0M7+wNrQYZpyJuQ51YHkg+fK7DY2DdUz+/Kc9rO8uq5Dv4zfjHQVOJA2YEqS5E2Ap7kqdCK1N4+SzwjqT372QUbDi4yep5RJjH/Q1nWLloyBwq0kXGXc+mDCU6M3Ukw70XPdd2uaR/fYM4umm2JFIhUXWm/UtgPsiu0b3o7lcOgKT3X3XfijidbPdJNhDe7aMSGcnG0eFNf4ICnrdofhMZFimtDoiEa67uvVKNeVQ7iolmqIpg2s6plhGRoMoX/2slIChjLCEVXuc28HRizdjvxM5cGOc2x3Ac1FUwFSPld56sJ2qZzHiR+o4t/IlI/AnLkKUaPbVKIH/M+6f/mdCwjECC+wGrWIPEdynegVlB027ef31gE6Bafv2FsZGaWBT5wS8DnLIeE0enzCKRjRAYcpj0DHAiN++tpK3SWUmBtOtFcPd8AgsuZNm3zEHmrx8QZ9BGFsslWsnFQgrx+n59tVHIIgpGU1SmiyD8ckPAT0gVz+9Ou5wRs5+4m7k6c+zGKdhX+RvOSsIKRstN49pboF/3fuRy1bDEXW/OOyCuhBGxN94TRyTRu/oSiji6FRT6FHnljgP3AM4WcRQ+gBlZBnVvbzM081N8eQZgsuMje9paXuLnZwEUGAqhTslLG4SbywwiiTupzZdEwrV4DrBmihC/F8aiRiykM7O7MXBZvXDfJ/HEIZUsXZx53Tk2js=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e114b26-0f4f-4ac5-fb03-08dbbe510bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:25:50.1670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGj9dI3GJX+fl08GH8xOpks2byMNdW3MbotMS5DK0kfYoVep1NIfKpm8CzfhsMMlw24Wnfc2G9OtUzmgIzSeBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8123
Received-SPF: pass client-ip=68.232.151.214;
 envelope-from=lizhijian@fujitsu.com; helo=esa4.fujitsucc.c3s2.iphmx.com
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
IGZvciBjb25zaXN0ZW5jeSB3aXRoIHFlbXVfcmRtYV93cml0ZV9vbmUoKSBhbmQNCj4gcWVtdV9y
ZG1hX3dyaXRlX2ZsdXNoKCksIGFuZCBmb3Igc2xpZ2h0bHkgc2ltcGxlciBjb2RlLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTWFya3VzIEFybWJydXN0ZXI8YXJtYnJ1QHJlZGhhdC5jb20+DQoNClJl
dmlld2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+

