Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A75B7AAAA7
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 09:45:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjaoV-0004oY-FF; Fri, 22 Sep 2023 03:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjaoT-0004oQ-Jp
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:42:57 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjaoR-00076R-Hk
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695368575; x=1726904575;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=iAvx5chIz7ByqylKGoqyeD5Mzi+ZZKHMr9v3rdqxMUY=;
 b=bVqz5UTx2AIudaoBjt6vH14bKUhcVJuGwpoXWoVPHhGpfYgki7QWBhJv
 Uli5+wAHNRLDht6mGROiaGTcKHGLulXN6191CovaLpB+02hpM3XnLu3jL
 AbzUwRby8n+YvTiKjdV7lf2ag/KFgSw/tmRjLOL1h6N6+xZiT8ng9wnCp
 X0RMZRKHPPvxc80MQayN74FyrcFKRPidnrihzgFDFq6i1ntZD33DPjZYs
 NoLmL4Z3LoR7ICtPnlEecXokOFeSJwNU2hpYdHEybgSDUFR3P545XVIKs
 rdmzijjmirZUxG6I4ohjxaox6Bd+1m8fxmBPYW+Td6ddeAZ3J24q9k/X1 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="95726046"
X-IronPort-AV: E=Sophos;i="6.03,167,1694703600"; d="scan'208";a="95726046"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2023 16:42:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eA11BEaYJXuGZhdDDVEUidjGYrExCZB6WaA9uXOESaLImkTRv3RxcU3HTt1fkBhVhNYNPyzSlJqmg96Fc9fjNgOJoANbnFvo7YKtxdwKIk7VOUXVf/wjWML8IUtdJ0dyHKYATQXovnPpguWMT70Dby8m5btcgJKo5VLcFHiPW6+4Mtj6QpJjYvkrqoJ8N6PvzbeD5aH42ekE0UJHzvUcsYI/G0nA1EeMjM5saWiogYI6joZxtJEqUlKjQ6/yAGL7fyILudlSPXmNMNc3B+d9uqm/DaQMA+uJK7YXexwckXoVuO65XFlo2UeqKdBNnIjw1VZDS56UXBDjDWifTQWpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAvx5chIz7ByqylKGoqyeD5Mzi+ZZKHMr9v3rdqxMUY=;
 b=MDEm/3KsNTK4uZIznZ5wX+49rwo/p9cMX3F0r8iGk6g3brRSTTkTfPxmEo76oNH+W+PdidrRfuavM+ej9zYSlgehybXYUBobFZGiBYXNMxJNy5kUHNyXDDGyhR4Bzptf++hOXCEzE1sc1sOSD4/uSGnXw5l9CUFOUgbFBY79SowoC2uutwl8LLv5dcUeAuOIfjEVzULySMRQmSX32knqvxXQXaUo6y4Xw4/7+UWHDx/YAQGPmSwp0F3MNQLUQpv5kHOBEvPLpNBGf5psLMLdpOr5htHpDfsfj2yMYzrwlGW4YcSd54y+YaF1cxL2H4IsjRK0uML+pdWhQ351rYlagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYBPR01MB5374.jpnprd01.prod.outlook.com (2603:1096:404:802d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 07:42:46 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 07:42:46 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Fabiano Rosas <farosas@suse.de>, "quintela@redhat.com"
 <quintela@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zhijian Li (Fujitsu)"
 <lizhijian@fujitsu.com>
Subject: Re: [PATCH 1/2] migration: Fix rdma migration failed
Thread-Topic: [PATCH 1/2] migration: Fix rdma migration failed
Thread-Index: AQHZ66FzclkAheYxg0+MQmSF60kg9LAjqZ4AgALP34A=
Date: Fri, 22 Sep 2023 07:42:46 +0000
Message-ID: <403e4645-a8d0-3af0-5c93-cf37a42eb619@fujitsu.com>
References: <20230920090412.726725-1-lizhijian@fujitsu.com>
 <87wmwlm2qx.fsf@suse.de>
In-Reply-To: <87wmwlm2qx.fsf@suse.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYBPR01MB5374:EE_
x-ms-office365-filtering-correlation-id: 2ee8cb90-25dd-4ba2-453f-08dbbb3f835a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oOXCFi/AEgAtNHg1aRr8+XEhz/tuig3yfvwF04shBhUTmHjNrwzRQyw0NAYVypuRRCsEZ2NflzgQ3W1dcjvn60J4PcTd/7u6xEMiMouXGj8rzJeIZ0yf73ifr4uXRFUw1t6sDmOG2qnWyF79fwDuND2k28wfyOZqsKRb10oNq8ZCo7DcvdW53Pozv7IGNNsvAmtzmf4AF7AmPiGoBefIuSCtV5ZgfLPzaRG6fvHgeZftmSNi/KetZkjBzFhwpXRR9nkVSbUuLKal3Lu7Jnm+3riqLTPH7a+sdEZDfzkOz/ERfBfqGxGkz9QGqTgLVTtqzhgkaQ3w6EaSA6BxYFPz8Sl5j/qsCrXvCthSuWKIRGHpJJCxROOYPFbSKgFA3v7iD9lvTlFIg9rsh0LQzFrTP1PPdH+rfu6ZZIyBlp+y/6zJ497tlNp7CrzWYusL4Gk9cmjEBXB4oL0uTUCuZ/OyRMOKfqF7lGgxVG2VZsaqAjDXv8QXrq+ASzP+2BOHcmzgABZgBJXL8Y/bA5lso0/109CyLE04JMEpe/MF287rVQajIAd7F6nKf0WgiVyd2tGxnMMKjELZ30EWDwgSYEBSY6vcamMMEy78bFRn5igpc8YJZXttcUXnTarNf/hrWRcA5qtIja1u893Qp0g3eklEIDrKUyB3aT5wpGpu67t5BeBY24dI+VDbrY7QIpa4DqmFu86QXeltZZA9LSU7+haLbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39860400002)(186009)(451199024)(1590799021)(1800799009)(8676002)(71200400001)(54906003)(4326008)(66446008)(64756008)(110136005)(76116006)(91956017)(66556008)(66946007)(86362001)(478600001)(5660300002)(41300700001)(316002)(85182001)(66476007)(31696002)(36756003)(8936002)(38100700002)(6512007)(6506007)(53546011)(6486002)(122000001)(82960400001)(31686004)(2616005)(107886003)(26005)(2906002)(38070700005)(83380400001)(1580799018)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1pPMG41SEp1TDNHTWRqemFXTGh0VHJCcDFCT3RBemx1cmdmeC9FSmM4NUVV?=
 =?utf-8?B?a2Iya3FsajJSRkpkZHNWZnBEc3BUaHhNeHVveXZOcVRmNWZ3c2JhRWRjRUpD?=
 =?utf-8?B?ZVA4b09TZ2Q5eURRRzVSZW5iTWUzbTBVbW9aRVFvODVsd0U3TG1JSmszb21Y?=
 =?utf-8?B?Z0NFYmZSanJuNEMvZ3hmYXVVeGlxSE54MU9PdXFodmp5ZnNvZU5SbE1pL3ps?=
 =?utf-8?B?Y3JnMHhPKzZldUhsbTcyKzhrbWh0QngyYWFDYWFTV2wra2xXS0RXZmFBQVBH?=
 =?utf-8?B?MHl1em9aUXFkQmxMSmpOZXV1SXFFazlEMXZ4UXlhc050RmJ4Rk9odTFQbU9J?=
 =?utf-8?B?MGtneExIaWRkS2NwTXVPd08yVTFsT1RncHBJa0JNd25SMGpuckZEVUl0TGhR?=
 =?utf-8?B?MUZkckM1UVZ1VlYvSkNqTmI2OFM5U2h1L3BML1oySzE5anBzSnk3TmxJeFhh?=
 =?utf-8?B?ZEIzYTEvRlZYSWhiOGZNQWVTSGRHNDlQUkhpalhtTGVYUElMb0w4Y21rUG5Z?=
 =?utf-8?B?TmNoTmZPaTNZZTNZVGdWaHkydzBmOHhjeCtqdlh5YlQ3bFZnanJPMnBhM2tn?=
 =?utf-8?B?NmRKMVVzdEpxS2xDdG1BR215cHRjR3ZYaUEyeVBvTXVkU240VDBvbWlneDJ0?=
 =?utf-8?B?NG9RZm01R1U1TjN4c2ZMZUpKU3QzMlcvcWNSQlJ6a3FROFFTQmluSkhZVWl2?=
 =?utf-8?B?U2hUTFgxOWVINUU2OW01dy9OVDNVTnlDT01ONmpEbUdQeDNGWldVWU9GVlVn?=
 =?utf-8?B?cG5NaWxNNUVzZnZOUThsQWMrTEFGR2NqUklieVF3M2ZJTzVNbUE5cHdBeDVL?=
 =?utf-8?B?MHp1ZDdJZ2JtL0UrR1g2bmpxQTZGeWxwSEVGMXBrNE9JWUg0MmtLejhhNGtt?=
 =?utf-8?B?SEkrdU40anE4NGVoNjY5NlBnU3pXTXZpakZObDQ0OW9kSlJldjdFUCtlV1Bq?=
 =?utf-8?B?QzY5c09oTnJkN0s1bHd5YkVxRHJRU0NqeVAzRHpkU3Q4a2dkdmdxbnBCNXJV?=
 =?utf-8?B?ckc0c2UzM29FSFJUZDhnckpCQUY4RjVTSFExcktINkVGaHcxcDJtZ2FZMy9G?=
 =?utf-8?B?K2hONW5DUnZ4N0NoeUZCR3ViSHFRZWJ3Sy96QmYvMlI0TWZIWkxKVHNDT0FG?=
 =?utf-8?B?MEVOaGNDSGRDYWFjQVlVWWlrZE9vbm9hZnhaTmkyd3I3U2k4d2ZFVUszL3dF?=
 =?utf-8?B?cU1BQnRhRUMwdTZwMDRLeUkwVTNJS2NhUkZOMU9yUmJtNjhydjVrNG1HNlBK?=
 =?utf-8?B?NHZJZEl4OE12ZzFDa1BCdC8zS3M5YXJvRldOV2oydGo5VkE3WS91UTJ0WDcy?=
 =?utf-8?B?dGg1bXVTeXZEQ0hhM1ZDNkRCd29UR2dtelNmSTkzSFpoMFcxRWNlcmxCKzF3?=
 =?utf-8?B?c2JEMXQ0N3dCRDdVekxBVkpNZXIybXd2U2V3MkZ0Wk5sbTB6WHFycjJTaU52?=
 =?utf-8?B?RnExMzFZaXlFMGhjN01LdmNTaHBVMkZiQjRwd1hMQVJkQkovV0VTK2d2Q3VI?=
 =?utf-8?B?ZmJlV2xEMWpTVjBsUmdNM0hLYTUydUxkeFlSQmNYc1NBM1Z0ZjQ4c3R2THU0?=
 =?utf-8?B?YlNMdHdwUzhiVmdUemtVbVhSWkUxOGZ0RmQ1TkU5cUZXc1dOUTVBc1dFNnda?=
 =?utf-8?B?eTlhSGFkOTdyTGVBbWhISEliQ0UvWUhPOWZFaGhUOWk2QnA4R1RHSUdPTmRF?=
 =?utf-8?B?ekE0ZE9DcGpuRGtiWEhENG9JMTdwM3lYK21FcERSL0g2WU1TMXBEM0ZYdEJW?=
 =?utf-8?B?QnFhb0dRL2JhYzdqbXdFZUNxdWU4RmNjbWtwSnNkdEloVHJLSisxVkZrdUVF?=
 =?utf-8?B?d1ZtZElOR2pCU0t6NFNpTUlHNWFLaytwMjdUWFBLcTc2ZFF6SXNnSXN3SXI2?=
 =?utf-8?B?SG9DcHZiN2NHR2ZVelZpeXVneStPbjdFV0xCMEppYzZiM3dLSVIyWE9JMEYv?=
 =?utf-8?B?NHhwTzJwdFFULzd1VUdsaWJVNDVDNVlTL0F5RkhDVnQyeE1nK2xpUkRpV1BS?=
 =?utf-8?B?a0JQNUZkcFdUd003N0NlbVNJbTFyUXBseVBOUGVnL2RFWEUxVE5jSWkxMzlD?=
 =?utf-8?B?QmdnUFVrYklmbWdqZXhjNkJER2Z5VTZEM0tUQU9iWEdEV3ZBY3B3WnJLc1N6?=
 =?utf-8?B?R25kWGphc1JtZkdaaU90OUlVdG1sdkRHSHlBdGxZUzRJNE0zaEJnZUtTaFdS?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98D4230222F3564B9E10DA4C32E3A0E1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2WvqVMIlbRNsX608QIYns5I6lYYZTfd3QqlznEV/WIureAg3DFr0OvM6lxvJLtq5u7ADd7l1bQ60YL4SlPYM+Jp4jZq2hmraeLfOC3Nr6FUeikwYeks1dw/CXQ4DCsN5FPjPiFocFUmMWUkntQFTwOL4rvm1iLTHGE20Zmx6HuQj1BlR0aCK7RKLlLDKvJCqAJxC8zCKdibRh7DAIRpJvEvrbADn6XqlDGb6swZtA0qb9ybC+vyQ+06HdJpFy+OYNLxk7T05u030hvR7bgXDrKMBDOONgsSbdI6GUCTjWewmhZhdLbY1spOTXrnrf9Um3VsyrOUgoa6mocKUdE825hxEfpKAqdnbHOBqgA4b8JXQiAcrw9TE1PV6CF7WGta4CHk88/0YQKUHpkOrHAkwdzUW+mQsi+MuGD0cjn9VUUeAj8iHasT4ZD45Mjw3eOtz3d5HW8xK+b9dloYhbqRVEiJmGDqHQBrnik87Vmryo76X4xkKNq2CHdLLWRfYokPJ4fVoFYyOOt06DmlmjNe/eXhxzsBocvK8nX6LY0DPqjSPWcw5BojAALxZgyXZXaRWJdpxW2YZv6Hmmr11Ar/JXFpSQ3JC1EtBnFJI94JYHQz6xWd+OqKEjYiM6iYwR3p/37awjXddDc7CA4hk/wL42GiVdB/iDaNg/rPhU9W4N/+0WKmCQB+Nwg4xAoz4Fi6BCynVY5ZoV891c7AdqwRXJDloWIN6td+LBXKMTfwCEQq/MsIBwVaRVPVCNXEFj444fhuUukRj82VGIetQoJ7KXknA+jxk65ld8j9pp5wXAlwYD13fnZOcklvr3RmGSbht
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee8cb90-25dd-4ba2-453f-08dbbb3f835a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 07:42:46.4117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2oWOcNM7TatUYc7oDPMgTCkiFdH5tqYoaRUtf5WE6CO623xAhhQTvgvIHuh05DY9AvrvfLk4Qi33PzB7lW6CYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5374
Received-SPF: pass client-ip=216.71.158.62; envelope-from=lizhijian@fujitsu.com;
 helo=esa19.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDIwLzA5LzIwMjMgMjA6NDYsIEZhYmlhbm8gUm9zYXMgd3JvdGU6DQo+IExpIFpoaWpp
YW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4gd3JpdGVzOg0KPiANCj4+IEZyb206IExpIFpoaWpp
YW4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT4NCj4+DQo+PiBEZXN0aW5hdGlvbiB3aWxsIGZh
aWwgd2l0aDoNCj4+IHFlbXUtc3lzdGVtLXg4Nl82NDogcmRtYTogVG9vIG1hbnkgcmVxdWVzdHMg
aW4gdGhpcyBtZXNzYWdlICgzNjM4OTUwMDMyKS5CYWlsaW5nLg0KPj4NCj4+IG1pZ3JhdGUgd2l0
aCBSRE1BIGlzIGRpZmZlcmVudCBmcm9tIHRjcC4gUkRNQSBoYXMgaXRzIG93biBjb250cm9sDQo+
PiBtZXNzYWdlLCBhbmQgYWxsIHRyYWZmaWMgYmV0d2VlbiBSRE1BX0NPTlRST0xfUkVHSVNURVJf
UkVRVUVTVCBhbmQNCj4+IFJETUFfQ09OVFJPTF9SRUdJU1RFUl9GSU5JU0hFRCBzaG91bGQgbm90
IGJlIGRpc3R1cmJlZC4NCj4gDQo+IFllYWgsIHRoaXMgaXMgcmVhbGx5IGZyYWdpbGUuIFdlIG5l
ZWQgYSBsb25nIHRlcm0gc29sdXRpb24gdG8gdGhpcy4gQW55DQo+IG90aGVyIGNoYW5nZSB0byBt
dWx0aWZkIHByb3RvY29sIGFzIHdlbGwgYXMgYW55IG90aGVyIGNoYW5nZSB0byB0aGUNCj4gbWln
cmF0aW9uIHJhbSBoYW5kbGluZyBtaWdodCBoaXQgdGhpcyBpc3N1ZSBhZ2Fpbi4NCg0KWWVhaCwg
aXQncyBwYWluIHBvaW50Lg0KDQpBbm90aGVyIG9wdGlvbiBpcyB0aGF0IGxldCBSRE1BIGNvbnRy
b2wgaGFuZGxlciB0byBrbm93IFJBTV9TQVZFX0ZMQUdfTVVMVElGRF9GTFVTSCBtZXNzYWdlDQph
bmQgZG8gbm90aGluZyB3aXRoIGl0Lg0KDQoNCj4gDQo+IFBlcmhhcHMgY29tbWl0IDI5NGU1YTQw
MzQgKCJtdWx0aWZkOiBPbmx5IGZsdXNoIG9uY2UgZWFjaCBmdWxsIHJvdW5kIG9mDQo+IG1lbW9y
eSIpIHNob3VsZCBzaW1wbHkgbm90IGhhdmUgdG91Y2hlZCB0aGUgc3RyZWFtIGF0IHRoYXQgcG9p
bnQsIGJ1dCB3ZQ0KPiBkb24ndCBoYXZlIGFueSBleHBsaWNpdCBzYWZlZ3VhcmRzIHRvIGF2b2lk
IGludGVybGVhdmluZyBmbGFncyBmcm9tDQo+IGRpZmZlcmVudCBsYXllcnMgbGlrZSB0aGF0IChh
c3N1bWluZyBtdWx0aWZkIGlzIGF0IGFub3RoZXIgbG9naWNhbCBsYXllcg0KPiB0aGFuIHRoZSBy
YW0gaGFuZGxpbmcpPiANCj4gSSBkb24ndCBoYXZlIGFueSBnb29kIHN1Z2dlc3Rpb25zIGF0IHRo
aXMgbW9tZW50LCBzbyBmb3Igbm93Og0KPiANCj4gUmV2aWV3ZWQtYnk6IEZhYmlhbm8gUm9zYXMg
PGZhcm9zYXNAc3VzZS5kZT4=

