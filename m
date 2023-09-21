Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B025A7A9092
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 03:41:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj8gM-0000gM-Rx; Wed, 20 Sep 2023 21:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qj8gK-0000fs-6y
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 21:40:40 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qj8gI-0004Gn-KR
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 21:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695260438; x=1726796438;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=N2iR4aJlOyzT4T5yoFdvF9ZDJKnetQbpBLqJ5CjF00M=;
 b=TKyGSETmvagokmx0hjyiHoXqVNt63QVKJSXY3wPWNk0/Q53lDIuH5K97
 piLG7nPDfrzQ+oCIA/m9Hk28pLIQS1WenGnUfrfp77VNuj6l4cPCSSsBG
 P4Zoq8Ur3GiXCxpcrpr6yj7RK3K73SgJdatlLPyAGHs51oYlv1x+afVjU
 kPCvoQb92BFpWa9aa0Hwl2Z6Z0CnWm7HHJV2oEr5dO613/2e4AoPZHfzo
 zpoZh+yz7jUeVq02Vxcynndow8dogepLZcd0TkKfwf9MPGCogjeupLi+j
 a/r6u1sNqD2S8a4/LZIxEu42U6JZkvlxE91s9SmYSKRUIwFBBFtN1M1B2 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="7080815"
X-IronPort-AV: E=Sophos;i="6.03,162,1694703600"; 
   d="scan'208";a="7080815"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 10:40:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhEkMq8oCHLpa6MvkWNsjjDEdv4f3eSOpmwF+4yPZSz3zUvO4yj6RnmWyvachLc/N7zNCR3k2EPDIYB8M5r5BgxIb+Lb5zuifl8Q3TUfo/olPkFV3EYxm62fHDQ+wWSeCPGRYCT39wz82Pios9qO8TGNOZnklK0Qll8p0wlGWPynobN0vIJhoS1yZV+0+JLceADRELWNLjL96Vgz2xoBIcsVHki0WezoYplizAtegTeKppv46bgxY5WpeeAXKE/JxiZ854NVzY0Rwepmc1dzR/nY/O6Qy6Kd3tux8kCCUOViawLpChznhj8ktbg6EZ0QNRxgqHIw45+p5gt8hKyfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2iR4aJlOyzT4T5yoFdvF9ZDJKnetQbpBLqJ5CjF00M=;
 b=HHP4cr/PNe7kC6vyMcuUbHXvbRDg6+cN1sE7x4jMC4G3rDzZcK2lF/SQ36VVeSR5gmvhFXUZQIHvpr5e9cogNIDWuGE2nZMd9hYZdYc/Cs8lHe4/IrTUUsFMVlYGFJPziUVF/u0UDVcv+F/olZk6mOTRC0z/1+tXWDB+JhrEaTyT9qXgdHdiJlOZutFtlSZojZhh284JmB8BigiXdwwiyFNWGzI3/Sf2gBf9KJ5/1eF/YHtwCF8MErnX54mrm0tkCwV8cMg8ORU97NlWFArZn92jFfWR/os25EOH4FeSYSv8IMKUyUF4Ay5NzMdcCWr2HwHZde8QC+BGmbYG7zRtsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYAPR01MB5786.jpnprd01.prod.outlook.com (2603:1096:404:8053::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 01:40:33 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 01:40:33 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zhijian Li (Fujitsu)"
 <lizhijian@fujitsu.com>
Subject: Re: [PATCH 1/2] migration: Fix rdma migration failed
Thread-Topic: [PATCH 1/2] migration: Fix rdma migration failed
Thread-Index: AQHZ66FzclkAheYxg0+MQmSF60kg9LAkgfOA
Date: Thu, 21 Sep 2023 01:40:33 +0000
Message-ID: <c2d47f77-87aa-4777-2ce8-2023602173a7@fujitsu.com>
References: <20230920090412.726725-1-lizhijian@fujitsu.com>
In-Reply-To: <20230920090412.726725-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYAPR01MB5786:EE_
x-ms-office365-filtering-correlation-id: 35c63a67-e197-4049-8ec9-08dbba43bee0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0+VQEvARvOWxENcfYiJnUqTpt4EwSrKN4xBY7f+dy3co0I0XWh7b6AdJpaoLeACXvndj0+h6ZLYeROE4jFKkeTc3yBposY2ezeKITqdD/7PB84jQmfhjOph5Xyp70+L9vkJCaK4ZC5DY/Ojtvd41uzJwPVOroBzLdB4/pPFbK81m4ahAOHK87bMV8NFcSQEE/s4YSdGL82+yjTkMVIzFMkGm1OsBqUsg0/aLLjwizkAzu8dOWV+f/Zu8rTDQ2Bk7/p/hQVmQgoqcRUloerLRR/qcMg7HnsyY4DMSxsO2zRUpyY8G7oBfFuriLH161zpM38VktlWAkbI93JpLcmrxUJ2xU/lRLVeh/+ZQaxg4BjSkZozsOcPHJXbog9amry1JbDgB2cwbBrOLXt7D+4g8fU+7u1nyEEka5t+yCMZ8BzMvw1FBDV+m+Im0vf1dBsdWXNeV/ZfM5BYqpIzDzkbDtB9u4nKkjKK/ZkMqiKIldya8m3rnMRUBd9chp8/jQGciwsF7AUmxIEzXOJsbzNAsoF/orWzISgy1mirypA1GAPy5phQP0Pq9MFqvWpcGEZYDzJF8aUrMPWIWib7SauNBfaIRcw+X1gSh+79gFW8/c12fA+Q+Plw12UCXR64ldBPgVwPuOaMlYv2Aqz//SlG2/ejvUNnuwJ9/7RONSIyZCex+6/tRetys2NW2crLP75/p7ECO+kVdQc3o0Tks1UZvg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(1800799009)(186009)(1590799021)(451199024)(6512007)(1580799018)(53546011)(6506007)(6486002)(71200400001)(82960400001)(83380400001)(122000001)(38070700005)(38100700002)(86362001)(31696002)(85182001)(36756003)(2616005)(107886003)(26005)(76116006)(110136005)(91956017)(54906003)(66446008)(66556008)(316002)(66476007)(64756008)(66946007)(41300700001)(2906002)(5660300002)(8936002)(8676002)(31686004)(478600001)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXdCVk82Sk1icm1PTmN2dTVoUVpPMjhyd2p0bm1NMzdFS3FycDc3anE2Vzkz?=
 =?utf-8?B?VWwrY3oxZXptM2lYY0dWbHZQc1NLUmFpMms3WkZNNHlhdWVKWExDczg2cUxw?=
 =?utf-8?B?dWRSYlAzNjFDckZKaHcrMXZJY1ZtY283bWwzZEpsY285MThSNDdhV3N0K3Vm?=
 =?utf-8?B?cS9lVk5kYjBud3M0SVZqSDZpb1ZPMWRoSWpRRURWek96TXY4Qk5XSGx5OFdW?=
 =?utf-8?B?YTRRdEl4YjBBUUZvN0ZvaEpiQ1M4aDQ0djlWU3B6NjVTWmhFQnFxazU5TndX?=
 =?utf-8?B?c2E1MThjcFNLQXQ5NjR6VHRLVmxEZDkrNW1Sa2U5WlBLT1JiSmtueEVvTEg2?=
 =?utf-8?B?RVBtU1pLYVQva2Y4RVJmT09VYmNld3l2L3ZYU1A1RCtpNXl0TzN6N25RMUxN?=
 =?utf-8?B?MFBxNTRZaWlwTUZNUWw0STRiUThXZy9rNUgwK1pRV0t3NWZBUFlZbDdZS0cx?=
 =?utf-8?B?clFSVElqZm00N2pHd1g5MlpPM3JPeCtCT05VUHlybk04SjNDTE9EYXduR25n?=
 =?utf-8?B?alNIMFNJMjEwZjg2ZzNDR05PRTBlcUhZcm1aVExXelM1TzRYOExRMWpaM0Vk?=
 =?utf-8?B?WFRrSkxQTDF1b1VYdW5nU01SZjJxK3hTeHNnTEM4dlY1Y1RjRDNzOWFuZ1RY?=
 =?utf-8?B?TFc1YWxJU0k4TGY4R1RBTkdGOVVoY3JJSnhIa2lVTU5ma0JGRjg3MkFjZWhX?=
 =?utf-8?B?NERrNjdlQy9rZ2FFMFpXbjY0ZFhtTFVpOWZhYTZlYmhBOVRtMEJCaTcrYUcw?=
 =?utf-8?B?YWxwOURQQUZwZjhFZmw0amcxa09TWU4wWlNIUmthbmQ0SVFBeTcrZnNyaFA1?=
 =?utf-8?B?elFObnh0RjRGY0lKRnJYMWJlOWpuejlOb2drSWx0Nk9IL09zdW1BSWlKd2Jk?=
 =?utf-8?B?eWU4NEhGMUJwVk5ZU2M5Qm01dE85RlRwNjBNOHpVSDFROG5rbXdob2Exancz?=
 =?utf-8?B?MHBCdlhIdmdrV2dMZ0Z0V24rRSt5TExmTXpkTG9EaDhBVFh1UWdFM3JGSkJY?=
 =?utf-8?B?dTh6aU0xbUdTbjZJMWZVZW1OalkrT3NLNWNxUUxBSWI4bjdRcElpdTJDc3JR?=
 =?utf-8?B?RmZzWUc3MWRnYThXMndQcWo5akpPdGhYRy9kbXFoZGhIMTlIZ2R2dXRkVXMy?=
 =?utf-8?B?cytEUzljVG1PNWp4WXEwSFpqZkFtSmxuQkpYMnVpR2tVY1BNa3Rqdzk0cklC?=
 =?utf-8?B?SHVwaW1RSk9TVWM0aVBXMmwvbmRzNGcySzBZL25VTE5pNnFQTmJTMUdnc1RD?=
 =?utf-8?B?d2VEMWxmV1JKZzRGUUxBYmZ1ZnFNQkhrRHFwOUdGaTRDc0NPMkRXbHZuamNF?=
 =?utf-8?B?N2MvQU1PclJvNTlScmthNkRkb2hvRFBielpId2VOOXh6RWMxU3NYdzN5dGp6?=
 =?utf-8?B?Wm9lWmhsWTRKdUt5REw4NUJKUFpwTFpjVTcxb1JyOHlXekpsbU9xbmdhSVM0?=
 =?utf-8?B?NkIrQS9lUzVMMkpNTjY3NTB6dVNmTi9udjRLOSs0dXp1SUhtYzg2eDE2dTdY?=
 =?utf-8?B?Z1d0QXlaSENhZlhkMVpUaDRRQWRuZXJJaitxZGRTMWlUMjZaT2xRckJYNSs4?=
 =?utf-8?B?ZXI5VHFDWDNnemlDYWQ0ckxITHh4bzVWVzJjODI0cWV1d0NuOFhwVzhDQWlm?=
 =?utf-8?B?a0ZGRUJ4WFZLV29BZk00UTJHbU0wSmdZMU11K2tnUmRtVjZOUFY3aVB1NXEx?=
 =?utf-8?B?bDVaanJNam9xUXltQk41NkJ1OGFKbVlNYUFUTnBLclpEKzYrODI4OWQzUUNC?=
 =?utf-8?B?ZjRRaU52L1ZkdFJVVnlFRStuNzNKTnFVQTVCbWkyUW5zUmNna0k2NEhwNEo3?=
 =?utf-8?B?amJQaGNrZHJya2R1SGptdHE5TW1vS3ZPbFhWQjErTUgzSWdhdU54Z1ExOEg2?=
 =?utf-8?B?SVlBQnpmL0NsRHRRb3A2M2Jxd2FsTDdaZWtOMENpT1lML3F1anhsQ0JoeC9B?=
 =?utf-8?B?MDB1bUVadWhsWU8yT2lmMlMxZXBLd2R5dmIydGI5SlAyMzhNbkpyQTd2aGwv?=
 =?utf-8?B?MlRTc000cGpuU1pYVk5GY3JBV1h2ZXNIRFBoUkhuT25vanZZMHcya0w0bjE2?=
 =?utf-8?B?MWVvdjdmK2NYNTg0ZFNya1BEMGFLQlFCR3R3WDY0V3VVWjRkVkJxQjVZT2Rh?=
 =?utf-8?B?aGFNRTZndTN1ZzFJT09VcFIvS1VxTzd1am9tZWxRTFFObHFsbHc3T0tmbUFU?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26FD6CE981430D4D958302003BA0F063@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iYKKQO01zT9pSr84y2yqEeLNGElfyWJQ97edE2eM3f11yNCfOqeIpatFx3MhK1pNJkjixBH8SCztQ2MUnEzfpZpb+xcqf+ny7ORV4mVXizQsgH/lPUT2Od27I62jLyo5f/Ud0N8fFv/yAOdFwkkKvV7CXFeR8Ja5KxA8CdE+AiQiqLx455AR9Te5qKJQz0gdlnlRm3a9S9tKbX/blNL9009Lg5oZKk155cSJBmeFmSmc3Fyi2c/BfyYqugc0eKVNsh4TeiTaEUvxUzJAsgplQcflWd2mOW6DRHRUQIfI2XyeuNLgL2h+IPaB7KJPu4GEGiliRUqMgSu5p/QRQ8nvfrqMj6GkH20oo2yJVE3KShmHD849KwDqJrg46y7E8gJOm6cEyIvuSPVCsPm4ju5UvugiX7YRnmEhhV8+Q4pACN+G1CcMW7LtrJwO7Fxh99FXEw9Byvn9PLY33F9BIDjEuEDTCjXr7RnFUqdI6wFqmh45xPKM3S4ehwgn77SgJy72bGXnQ8k8u7VI3Egb6MCbltzPNEcpWBo6kzsgVDe8o3bQpRNyg7RlkURRkXbOi+ReeWYNw4t6ZYJMXwdnA9d+NFymFuFNGIz66LFPFP7OuS6fDG7wUSdGv/RFqZc8Nr/Y5NpS5/LNRF3Np0af0X72cyvGRriB7ys3jPtN2Orv3Xj47XI8m93Fh5nZQcipi1vfIKKY0xKXvvRXTV77ctMl6kub0RAvggj2e5wHcCXoj7Ktry5Nnj57wt4s50W4IWdSX3mmv/DuNkc9AsCXcAc28HhWSiuQT0hTe6LAZBWG1Ho=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c63a67-e197-4049-8ec9-08dbba43bee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 01:40:33.0893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6mP5k5WNw7yZ1B9pwjprj085NnaaX1L9DRB7k+P4niIbF3nvRQkIqHHom6LZcjdyRFbqEBKM3bs4WiQLJfw4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5786
Received-SPF: pass client-ip=68.232.152.245;
 envelope-from=lizhijian@fujitsu.com; helo=esa1.fujitsucc.c3s2.iphmx.com
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

U29ycnkgdG8gYWxsLCBpIGZvcmdvdCB0byB1cGRhdGUgbXkgZW1haWwgYWRkcmVzcyB0byBsaXpo
aWppYW5AZnVqaXRzdS5jb20uDQoNCkNvcnJlY3RlZCBpdC4NCg0KDQpPbiAyMC8wOS8yMDIzIDE3
OjA0LCBMaSBaaGlqaWFuIHdyb3RlOg0KPiBGcm9tOiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AY24u
ZnVqaXRzdS5jb20+DQo+IA0KPiBEZXN0aW5hdGlvbiB3aWxsIGZhaWwgd2l0aDoNCj4gcWVtdS1z
eXN0ZW0teDg2XzY0OiByZG1hOiBUb28gbWFueSByZXF1ZXN0cyBpbiB0aGlzIG1lc3NhZ2UgKDM2
Mzg5NTAwMzIpLkJhaWxpbmcuDQo+IA0KPiBtaWdyYXRlIHdpdGggUkRNQSBpcyBkaWZmZXJlbnQg
ZnJvbSB0Y3AuIFJETUEgaGFzIGl0cyBvd24gY29udHJvbA0KPiBtZXNzYWdlLCBhbmQgYWxsIHRy
YWZmaWMgYmV0d2VlbiBSRE1BX0NPTlRST0xfUkVHSVNURVJfUkVRVUVTVCBhbmQNCj4gUkRNQV9D
T05UUk9MX1JFR0lTVEVSX0ZJTklTSEVEIHNob3VsZCBub3QgYmUgZGlzdHVyYmVkLg0KPiANCj4g
ZmluZF9kaXJ0eV9ibG9jaygpIHdpbGwgYmUgY2FsbGVkIGR1cmluZyBSRE1BX0NPTlRST0xfUkVH
SVNURVJfUkVRVUVTVA0KPiBhbmQgUkRNQV9DT05UUk9MX1JFR0lTVEVSX0ZJTklTSEVELCBpdCB3
aWxsIHNlbmQgYSBleHRyYSB0cmFmZmljIHRvDQo+IGRlc3RpbmF0aW9uIGFuZCBjYXVzZSBtaWdy
YXRpb24gdG8gZmFpbC4NCj4gDQo+IFNpbmNlIHRoZXJlJ3Mgbm8gZXhpc3Rpbmcgc3Vicm91dGlu
ZSB0byBpbmRpY2F0ZSB3aGV0aGVyIGl0J3MgbWlncmF0ZWQNCj4gYnkgUkRNQSBvciBub3QsIGFu
ZCBSRE1BIGlzIG5vdCBjb21wYXRpYmxlIHdpdGggbXVsdGlmZCwgd2UgdXNlDQo+IG1pZ3JhdGVf
bXVsdGlmZCgpIGhlcmUuDQo+IA0KPiBGaXhlczogMjk0ZTVhNDAzNCAoIm11bHRpZmQ6IE9ubHkg
Zmx1c2ggb25jZSBlYWNoIGZ1bGwgcm91bmQgb2YgbWVtb3J5IikNCj4gU2lnbmVkLW9mZi1ieTog
TGkgWmhpamlhbiA8bGl6aGlqaWFuQGNuLmZ1aml0c3UuY29tPg0KPiAtLS0NCj4gICBtaWdyYXRp
b24vcmFtLmMgfCAzICsrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vcmFtLmMgYi9taWdyYXRp
b24vcmFtLmMNCj4gaW5kZXggOTA0MGQ2NmU2MS4uODlhZTI4ZTIxYSAxMDA2NDQNCj4gLS0tIGEv
bWlncmF0aW9uL3JhbS5jDQo+ICsrKyBiL21pZ3JhdGlvbi9yYW0uYw0KPiBAQCAtMTM5OSw3ICsx
Mzk5LDggQEAgc3RhdGljIGludCBmaW5kX2RpcnR5X2Jsb2NrKFJBTVN0YXRlICpycywgUGFnZVNl
YXJjaFN0YXR1cyAqcHNzKQ0KPiAgICAgICAgICAgcHNzLT5wYWdlID0gMDsNCj4gICAgICAgICAg
IHBzcy0+YmxvY2sgPSBRTElTVF9ORVhUX1JDVShwc3MtPmJsb2NrLCBuZXh0KTsNCj4gICAgICAg
ICAgIGlmICghcHNzLT5ibG9jaykgew0KPiAtICAgICAgICAgICAgaWYgKCFtaWdyYXRlX211bHRp
ZmRfZmx1c2hfYWZ0ZXJfZWFjaF9zZWN0aW9uKCkpIHsNCj4gKyAgICAgICAgICAgIGlmIChtaWdy
YXRlX211bHRpZmQoKSAmJg0KPiArICAgICAgICAgICAgICAgICFtaWdyYXRlX211bHRpZmRfZmx1
c2hfYWZ0ZXJfZWFjaF9zZWN0aW9uKCkpIHsNCj4gICAgICAgICAgICAgICAgICAgUUVNVUZpbGUg
KmYgPSBycy0+cHNzW1JBTV9DSEFOTkVMX1BSRUNPUFldLnBzc19jaGFubmVsOw0KPiAgICAgICAg
ICAgICAgICAgICBpbnQgcmV0ID0gbXVsdGlmZF9zZW5kX3N5bmNfbWFpbihmKTsNCj4gICAgICAg
ICAgICAgICAgICAgaWYgKHJldCA8IDApIHs=

