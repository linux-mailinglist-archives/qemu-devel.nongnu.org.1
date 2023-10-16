Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E317CA4B1
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:03:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKRF-0006j2-Im; Mon, 16 Oct 2023 06:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1qsKRB-0006ie-Qe; Mon, 16 Oct 2023 06:03:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1qsKR5-0006l4-MC; Mon, 16 Oct 2023 06:03:01 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39G6mxIc005380; Mon, 16 Oct 2023 10:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QaLOaPjX6rX9GjKObe8G4dZnFcqchEN3lycdVGiktvE=;
 b=NSpYrG+XOeotoqQ8h+E4y9H/Mq4K2KIYLbyCT0M2xgV+As2Vf0mxC6hy5Bg1QI4wSQgI
 stZ+6J6odiC+vfw/2+9HAC0Xm0CGC10NzusZbzyxC05jmcwNjqfigEV29FaunO2X8w88
 04beMEt706sz8b8hrb6CLs3RN2hV7eGMRnxU6kepUx35fDgMYx6NWgSHcy316DVO1/wQ
 PRQhfUdRxpDljFen9MJ3Ymwycm0bSnxbpdh9zcNVDfhQrEpT+E8FvPGYx4F5CG8rXNca
 WLBJBh3rCI5UPt+XZ4QYKNN8IiYNKC04eWB4u7GVKFJU3wNboq85XB99xVwM8lUdkWtZ MA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1ctbbc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Oct 2023 10:02:02 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39G9Fa8j028505; Mon, 16 Oct 2023 10:02:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3trfy1xegf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Oct 2023 10:02:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9jBz9yEJ9cGdtxhkg8QDt2GLG6RrJgFyLC07yFns7vOLR49I5zL1S9j1o63Hl1mE/R1USKG/qsesbCPk7eQ8Fo7E2oBR0GJ9u71uPrrimMkVKpQWTZQbxPjIVMfqq2bCKid4h8cuGWOr5yuRDDmPxuH46Jq30ARggXLkcM60acMLovKhdMYdJojK2TumAiouY247/NQPDWIS70pzmZm2T6No//I+FLAQb4mwNW8AdMYpK/DPV/lvYOIrg4RhtL/kIQmbx7ngBdq/gfyIBhqs4mrAC3nKxagBfTZpMpr3dyidccvAA/croD1y2r7uR/tXmrKARQpeR6LYbQK1nVHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaLOaPjX6rX9GjKObe8G4dZnFcqchEN3lycdVGiktvE=;
 b=Ld5coMITI15QA9siKAkYj2KQKte+W8Qd9X/QixCq0e22YzEGAUN2yd9QohsT0rogU2RYs3yYNcvg2kuUp4HNbTxQ4E4/C43D0SgyC/LnSdXs5xf51IcQWPO2fwWI1uX/GQtqZhqmZLoRljoK7Ba29/orOfbHMywJTqnJEPciSgrgJ8nD3j0GD32XfoRyVeIO9fOqoXg4NLyO7ImSNSAE6Wg1XHM6AgabaDLeI+E6Uf/fGKJI4jUNEZhH4J1n0+cPHmbxW1Snu70Smv4ycDQHKQgLAcaaptnyXv/rRmPhf6uhPxgiGoDmrxLIqQLp0x9F4jxSnZIDcimU1rO3ndaDhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaLOaPjX6rX9GjKObe8G4dZnFcqchEN3lycdVGiktvE=;
 b=ptboLp7xX6yflAgdpwpjYVyJZZT66pusDpTMDLQ6idVHhAIAtTpcJBtetrJ9WOlBHxCZXoexWDy8GvSrgdPMQ8P2wjuPdjIoXJCznD3SxVRJtw+zoXRS949quZY1kFvgeeMiVvPuvCtROJZTvo1YA+8cypHa7DAfQzf6CQjDty8=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DM6PR10MB4281.namprd10.prod.outlook.com (2603:10b6:5:216::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Mon, 16 Oct
 2023 10:01:57 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3%3]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 10:01:57 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Salil Mehta <salil.mehta@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Marc Zyngier <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 Karl Heubaum <karl.heubaum@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH V6 0/9] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Topic: [PATCH V6 0/9] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Index: AQHZ/cNWJqm/pSxZvkeMuMYpUSehELBH6oqAgARG/4CAAAJ8gA==
Date: Mon, 16 Oct 2023 10:01:57 +0000
Message-ID: <D78AD548-0934-48E3-957A-E5123D9E7F4C@oracle.com>
References: <20231013105129.25648-1-salil.mehta@huawei.com>
 <4764CF47-47CA-4685-805C-BBE6310BE164@oracle.com>
 <187d0a24a81b4f1abbb23795325073ea@huawei.com>
In-Reply-To: <187d0a24a81b4f1abbb23795325073ea@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|DM6PR10MB4281:EE_
x-ms-office365-filtering-correlation-id: 5cd3a5d7-6dad-4eda-8cd0-08dbce2eeeeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yo/y47HK8PcoZVztRcmmV+9cVPMKaQJkLyxkfq1Js1ONLsNgP6EC+W3/roSLlaM2pIO4xf64MwgcIgoxKDm6C6iDP0p3Rftvf7J6z6bpUcgkV+VsJ0LVI7w/t0OtZToG/P6Xl4f+W/n+lPdkEFy8c+htb5r6q7+0iAOHD/dP0LMMwrhTYwH8P/zRHgyRicPU6zIAxRTHe1qD/1HZGldMTDtBrxMDP83n6yrpJb5Z05gkQu3Mdjlr4rPUQLfix3cd+c5i6glWvgtJ01dNA9zOyRDzScNgsdTDF+ZButbKp/oT/ODxicJgjW78YlIYDiO/B8t45rkKxYJ0O0DCmfsvICIug4tQSn106eyZFOF2a7qFCc2AX/MjX3RqT5loSaAMnkM+BkQtMw3pNFqytLVnHnbx3xz110Y0LfSELk1BXLa6ar9CQSjzOdHeb2ic9utwrsDXjuuQ8CbdOTEWncVAMxJCm9jynu7oNRjvwjwD7+3pPeiD3VIKnMiEVP9RVhhP65U35CzBkSlTv40/fmlnt/0Hud08hv3Vdd5ss/lhQDa3xeYQ0ZBMivxewc5aim/ea89+1UcEsFGrwFsTTYTaWqJO6Yf2KxeDDiAdZqqoxx0Hi29ZKB93hY+nalXyNPX3a+VRVHdwcxUcrJ3UWUEYlw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(53546011)(76116006)(7416002)(7406005)(44832011)(5660300002)(4326008)(2906002)(8936002)(8676002)(41300700001)(54906003)(86362001)(66476007)(66946007)(66556008)(316002)(6916009)(66899024)(64756008)(66446008)(33656002)(36756003)(122000001)(83380400001)(6512007)(71200400001)(6506007)(2616005)(478600001)(6486002)(91956017)(38100700002)(38070700005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU5LbEF3WWtBdjZmdDRmZ2Fqb2s2OXRlQXl4SHNDUmIycU9VY0Q2RVp0OFAv?=
 =?utf-8?B?Yy90WHoxRVNnQUJuQU5DZ3pMRkNYaXVvVlJvUVZvb2UzNnR2dGlLWUJWZVpu?=
 =?utf-8?B?bnBCdTJzUklZbnBpdjE4dklkNjVyMUNPRUZUdXdOdzFPU0J1My96c3c5L1Z5?=
 =?utf-8?B?eHdPOXArSlJ6M25sQkNZWE9hZmRLWU00UDVpS0t6MXJPeENabFZ0aWgrRlll?=
 =?utf-8?B?NVd2ZjhVM2IzekY1Ti9EZXg2dHAyZFhvZjVRckF0WjdTTTRsTXN6L3B2c0dR?=
 =?utf-8?B?MmtFWjRJTVo4YXZLcml1SFBLR3VWWGVVcjNYRnExRGFCYjloOHpualhpOGZi?=
 =?utf-8?B?eHNicUNpWUZ0ZlE3SktQTTZ3VjBJV2pWMWtYczNibk9iSnhXL2V4SXR1VWty?=
 =?utf-8?B?MGIrMys2ZGFtOHJ0VkVpTDNReVEwcGI5S09mdGV2cG5QTVhUSmZNU2hJb2dU?=
 =?utf-8?B?dmdJemUrVndJVklOQmd4aUx1SG9oVkFEOG5nSXlUbisvaGREZDhDN2hyUDJP?=
 =?utf-8?B?U0RZWC8rRGJLTGkvSWhWclRqQ1JHcWF2bFY2K25CbDhMVFlvbldGeHhBcS9O?=
 =?utf-8?B?dUVZeVpyMUwvcnRDd2tRRFh5R2VjbXVUUTl4aFBSK2IrckJsWGZOMi9MamlM?=
 =?utf-8?B?NHlZSEduR2pBOURYY2ZhVUVFRVZzbGFKNTRrSGtTR3U0K1ZINW9haTVTTldJ?=
 =?utf-8?B?bnVRMEFDM2dIVy9jNmJ3MTRvTHlreEhtOW1yeGVZcWlxdXhnRGJQTkVhUklu?=
 =?utf-8?B?R1oxdnFJRm1vQVJMK3pFTHJrWWpoS3pQZy9KeGx5K2pXL3JvYjJDSzd6SWpq?=
 =?utf-8?B?cEc0dGpDeUY0K2NJa1YvRjczbXJyWjNnK0laYU8vUHl0b2J4a1Zvcy9EU0Ev?=
 =?utf-8?B?NndPRjFmNlFacSthSVJLRVBWSmE0aEx6czlZTDVyQm8yeTBLWTBaV1M0eXlU?=
 =?utf-8?B?dVRlY2tOOGZZNXJ2cE9xdFliK1RSYkxYbUFiQis2Q1NRM3lVVHBsNFhnMWhl?=
 =?utf-8?B?blJMcDNiQVVvc3dmL1BYbjNQUVN2Wll6YTNHVTNCb1dRSWdGbkRTa3FBcHdJ?=
 =?utf-8?B?K2Y5QjZ5V25TU3ZHMXh4ZzN3NGZJbTFZUCs2WjU4bDFiUnVSWU9wRGtuVkNZ?=
 =?utf-8?B?bXZXeXBvNHlORS9VR0dhTnN3SnA3dWdPbVpza002MDExbXY0MWl4eloxMmg4?=
 =?utf-8?B?TmF0WDBEU2swTE9yVUQ1NzJKRmQxb1VacFEzTmdsaGJEZXFJSVZxNUpqVXNO?=
 =?utf-8?B?ZzI5UTVMUmgrZXlUZWhjK2dWVU9ZalRQL3kzM0xOa2ZNaWJhRERIMVN2RERj?=
 =?utf-8?B?ZXF4dERXMktWUzJ0UnNVcm44NldyL1dYa2dmVTJGcmMxVStTVzBZWlM0WDVr?=
 =?utf-8?B?Rm5VS2NUQng4S0FyZ1MwaXNzM2t6S1NuZkliT2ZJMG9WeG9kL1JIalI1RlJx?=
 =?utf-8?B?UmhuU2ZrMkgvaCthWjlodWFnektKSFZvNFF5SWM0YTRLNTlLZTVpQWRhK0Fu?=
 =?utf-8?B?eTBTMkJ4a2Z6Nno4ZFdSU0FsR053RlVuVzZoY25tR2R6dVFQNE1XYkRnYzA0?=
 =?utf-8?B?UUljUVdsV1lQUEpCNUlZRDZGaVJwTmw4ZEFQZGU0cURzQjE0dHBwN0dHY0Zy?=
 =?utf-8?B?SEoxUWk2VWFpV0hJSHZhUXlRQjR0UUlpSWJpUEU2Wm91UTNLTlloMTNHMmti?=
 =?utf-8?B?QkpqTXVUc1hHc24zT1A0Q0wrV1BoQUNyMElZcUszRE9JMkcrbFV3cEtFVHV0?=
 =?utf-8?B?VEVEeXJzaFg2enNvOTY0bk9wNi9UY1VLdStvUU5hc0h2bTk2a1F5S1FRT3lv?=
 =?utf-8?B?MnNFbm5zNC9tRHdSU21rVXhOdDNuRWxPYUQ2dHQxUldrTktKM2tpMGE3b2Q4?=
 =?utf-8?B?aGhOWjRiK0N1emtXNW45Y0lHUVZJSFE5UElBem9jbldNMTJSbTc5bUZjM0N4?=
 =?utf-8?B?ejc1R3g5dDJucHFacUFHdzRlRkpaMnJzeHV2Y0lZMklTWU1qZ0ErRU0rVk4r?=
 =?utf-8?B?N2lBWURvMWUvaDVRWDhRbnQwampxOTNDUjd0UXdYMExmM0ZwemhBc0lYY3J0?=
 =?utf-8?B?WXNJM1lpR0JvY3hrR1NnOVNHWE5YWlAyYjdtK29rbUxUQVFuajE2b1VhRVM5?=
 =?utf-8?B?a1U5bnVWT3RKaGwrT3M1WnVCR3lqSzd0aHNrNVBqTE5STEJTUituNUxrNnpO?=
 =?utf-8?Q?4xiZIMHeOZqA5OXcyKbHyjw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72D0B36D325D0245A337D9CC6472AAB2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eUhibDZSVjhXaGY0YmhKQlhOWDFFOGVBRHQrWmcweHVqTHkvNVFUYzE3TlZq?=
 =?utf-8?B?NXdXcWEvOUIrNjJvVjQweklsMWIreGlGaDIzZTQ4Ny8yclhkY2ZKTjQwRWhj?=
 =?utf-8?B?eWVsc1BzTzY3aFNHU2Z1eFQ4V3o4SW9oeXVkaGkvVVN6WVZsOGo3VlVjbmlU?=
 =?utf-8?B?MEJ3blFQZ1BxREZ5Vm1XTHpwVmhrdE5PUU9UazhOYnF2Y3RRRnFuSnZBZkN0?=
 =?utf-8?B?ZkI2KzVtbHJkWDNoSHhaR1pWM0F4QnRjejc1N2JOZDRWTmxlMzEwMlFrL3F1?=
 =?utf-8?B?d1pITFhVWVVWMVhiT2R3Rkp3QVpUUU00OUNrbG1SZ2dHYXJwTFFnRm1UWG5z?=
 =?utf-8?B?OHZPWm1FbFlGMkpIRTNzNkU4U2ZLMGszWmFaWWZ6VFpHM28xb1B2Tmg4cW53?=
 =?utf-8?B?VmdQQkUxNm9GMXduaU9HRlZ1dXBIamZlMmh6R2xaZkVlcklQZXk1aVpCNkxR?=
 =?utf-8?B?T0dwNG9rY0hOZVBZMDUrcjJESzYwK0RzdldCeXdJTDlrbUFQVnhxRFcxbmNv?=
 =?utf-8?B?MXE2cUpnei9mRjlLczBJRUM5VmFBa3ZkUXJ0ZGFaUEZLOTNYSXNadllLbWY1?=
 =?utf-8?B?RG1NV2NvL1BLeitZLzhSQjdvanZHK2gybjJ1WUxzenUzSy9GRFk1Y0RmbE1p?=
 =?utf-8?B?WTJKaEpPMi95VEgrZEM2b20vbmNONUNMK0tpenpuTUExNHRrRTV6UC83cWs4?=
 =?utf-8?B?aktJVHN4Q3Y1b0w4cGVUamNHOWU1Z1ZJemJ2N1Zzam9kS2lobDhiek1QaGdM?=
 =?utf-8?B?R2ErcktTQU5GZXNMSzVucWpBdElGZVJoZWNlUVJPY2NyQUZpU1BvUTRLcENh?=
 =?utf-8?B?ZmErNElnTGIzOFJ6Q1duUkFPZW1MUmJYUmFCNnV5MksxREQ3ckNDRWNPR2pZ?=
 =?utf-8?B?K0FYQzdyMUUyWlVNNkloQllJODMxcW9QRHh3ejVNZGNRaUtWeUpLNytlSnBS?=
 =?utf-8?B?Uy84Y1BkM2tLZ21VNFlXejArVVRLMVZ2WVFBL2w0SDVxMEhrdUhlME9jeGpV?=
 =?utf-8?B?c2lnNmhlRC8ybGZZZDRJekRzVG5xQU11ZEc2TU8zYzNsNmxGRVhKRUhPdVA2?=
 =?utf-8?B?QWk2Q3FmQkhZZUdMK2JCSk9leUJrWmpKcnFsbFRHbjg3eXMvZ1Q1VnZDM2Fv?=
 =?utf-8?B?eW5TY1VqTE1WV0dVbzNmS3ZvcEViSDlheW1oeGpPWmNQbFZPZGtHQXlydm4r?=
 =?utf-8?B?dGtrejFwSks4V1dxVTJ1VWt2ODVoMjlpcDNyUmZRckNLZHYwOUZObFF1WmtL?=
 =?utf-8?B?ZFNybk1ZTTgwUkdKVE1mcy95VlRVL3ZEanJrUHhRdEVJRlZKcVp2aHZDODhu?=
 =?utf-8?B?UHh3WlU4R3o3aDNDbTdrTkxjaGt4NW5YQVdwcUkraTNFRTA1Q3hHUElralA5?=
 =?utf-8?B?dDdIdndnVFQ0bTVjQlBma1cyWmxZYWRoVWVZV0JUNFdVNHVZYVpaQm9SRElZ?=
 =?utf-8?B?VTVVQnE4SCt3eG1JS3BZWnA4VmsyQlhyazN2WEJRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd3a5d7-6dad-4eda-8cd0-08dbce2eeeeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 10:01:57.5128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwJzkUm7d1f0AcwPq9RJxbWI3xdKcoV0P2b8KvMIfmx16AwETi1113TvjqAmhBwBmFukNlJEO959/bWV0lxAmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310160087
X-Proofpoint-GUID: GFedQ7Yh5J9KkbVahOz-4HfWHOlD9uiQ
X-Proofpoint-ORIG-GUID: GFedQ7Yh5J9KkbVahOz-4HfWHOlD9uiQ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgU2FsaWwsDQoNCj4gT24gMTYgT2N0IDIwMjMsIGF0IDA5OjUyLCBTYWxpbCBNZWh0YSA8c2Fs
aWwubWVodGFAaHVhd2VpLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSBNaWd1ZWwsDQo+IA0KPj4gRnJv
bTogTWlndWVsIEx1aXMgPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+DQo+PiBTZW50OiBGcmlkYXks
IE9jdG9iZXIgMTMsIDIwMjMgNTozNCBQTQ0KPj4gVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0
YUBodWF3ZWkuY29tPg0KPj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS1hcm1Abm9u
Z251Lm9yZzsgTWFyYyBaeW5naWVyDQo+PiA8bWF6QGtlcm5lbC5vcmc+OyBqZWFuLXBoaWxpcHBl
QGxpbmFyby5vcmc7IEpvbmF0aGFuIENhbWVyb24NCj4+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdl
aS5jb20+OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IFBldGVyIE1heWRlbGwNCj4+IDxwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc+OyBSaWNoYXJkIEhlbmRlcnNvbg0KPj4gPHJpY2hhcmQuaGVuZGVy
c29uQGxpbmFyby5vcmc+OyBpbWFtbWVkb0ByZWRoYXQuY29tOw0KPj4gYW5kcmV3LmpvbmVzQGxp
bnV4LmRldjsgZGF2aWRAcmVkaGF0LmNvbTsgcGhpbG1kQGxpbmFyby5vcmc7DQo+PiBlcmljLmF1
Z2VyQHJlZGhhdC5jb207IG9saXZlci51cHRvbkBsaW51eC5kZXY7IHBib256aW5pQHJlZGhhdC5j
b207DQo+PiBtc3RAcmVkaGF0LmNvbTsgd2lsbEBrZXJuZWwub3JnOyBnc2hhbkByZWRoYXQuY29t
OyByYWZhZWxAa2VybmVsLm9yZzsNCj4+IGFsZXguYmVubmVlQGxpbmFyby5vcmc7IGxpbnV4QGFy
bWxpbnV4Lm9yZy51azsNCj4+IGRhcnJlbkBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBpbGtrYUBv
cy5hbXBlcmVjb21wdXRpbmcuY29tOw0KPj4gdmlzaG51QG9zLmFtcGVyZWNvbXB1dGluZy5jb207
IEthcmwgSGV1YmF1bSA8a2FybC5oZXViYXVtQG9yYWNsZS5jb20+Ow0KPj4gc2FsaWwubWVodGFA
b3Buc3JjLm5ldDsgemh1a2VxaWFuIDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+OyB3YW5neGlvbmdm
ZW5nDQo+PiAoQykgPHdhbmd4aW9uZ2ZlbmcyQGh1YXdlaS5jb20+OyB3YW5neWFuYW4gKFkpIDx3
YW5neWFuYW41NUBodWF3ZWkuY29tPjsNCj4+IGppYWtlcm5lbDJAZ21haWwuY29tOyBtYW9iaWJv
QGxvb25nc29uLmNuOyBsaXhpYW5nbGFpQGxvb25nc29uLmNuOyBMaW51eGFybQ0KPj4gPGxpbnV4
YXJtQGh1YXdlaS5jb20+DQo+PiBTdWJqZWN0OiBSZTogW1BBVENIIFY2IDAvOV0gQWRkIGFyY2hp
dGVjdHVyZSBhZ25vc3RpYyBjb2RlIHRvIHN1cHBvcnQgdkNQVQ0KPj4gSG90cGx1Zw0KPj4gDQo+
PiBIaSBTYWxpbCwNCj4+IA0KPj4+IE9uIDEzIE9jdCAyMDIzLCBhdCAxMDo1MSwgU2FsaWwgTWVo
dGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IFZpcnR1YWwgQ1BV
IGhvdHBsdWcgc3VwcG9ydCBpcyBiZWluZyBhZGRlZCBhY3Jvc3MgdmFyaW91cw0KPj4gYXJjaGl0
ZWN0dXJlc1sxXVszXS4NCj4+PiBUaGlzIHNlcmllcyBhZGRzIHZhcmlvdXMgY29kZSBiaXRzIGNv
bW1vbiBhY3Jvc3MgYWxsIGFyY2hpdGVjdHVyZXM6DQo+IA0KPiANCj4gWy4uLl0NCj4gDQo+IA0K
Pj4gSSB0ZXN0ZWQgaXQgZm9yIEFybTY0LCBtYWtlIGNoZWNrLCBib290L3JlYm9vdCwgbGl2ZSBt
aWdyYXRpb24gYW5kIGZvdW5kIG5vDQo+PiBpc3N1ZXMsDQo+PiBzbyBmb3IgdGhpcywgcGxlYXNl
IGZlZWwgZnJlZSB0byBhZGQ6DQo+PiANCj4+IFRlc3RlZC1ieTogTWlndWVsIEx1aXMgPG1pZ3Vl
bC5sdWlzQG9yYWNsZS5jb20+DQo+IA0KPiBHcmVhdC4gTWFueSB0aGFua3MgZm9yIHRoZSBjb25m
aXJtYXRpb24uIA0KPiANCj4gSSBndWVzcyB5b3UgYXJlIHJlcGVhdGluZyB0aGUgc2FtZSBmb3Ig
eDg2IGFzIHdlbGw/DQo+IA0KDQpZb3UgYXJlIHdlbGNvbWUhDQoNCkFic29sdXRlbHksIEnigJlt
IHJlcGVhdGluZyB0aG9zZSBzYW1lIHRlc3RzIGZvciB4ODYuDQoNClRoYW5rcw0KTWlndWVsDQoN
Cj4gU2FsaWwuDQoNCg==

