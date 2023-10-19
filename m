Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D117CF46F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:51:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPgK-00031m-Df; Thu, 19 Oct 2023 05:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1qtPgH-0002sl-7U; Thu, 19 Oct 2023 05:51:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1qtPg9-0005MH-FJ; Thu, 19 Oct 2023 05:50:59 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39J7OFQL010759; Thu, 19 Oct 2023 09:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WB+JArNsbhXRI8qSsxfWfj1NTUXTIFfyYSkdyQ7deew=;
 b=b++TkvjL6dIYDvEBzWPlvr8CqOnGxPzC6VXhx/30qTW7yqfU/gme/WJlPzXF84pL9DEk
 MdY1rN8/uC0xrZbqlWZrCnvQUkekf85iC69KKQ0I/oDJYvHOklTiO7Su+nrIhGPtJfhF
 R+s7RX3/OoYTT9lhcPineJuMftMMG1LRXrbf6Qt4bkKaSh+PlY113NgHdF+gCtJejUUV
 By1ypGJDoc3P45R4wnl0DtiiaYLM75iE2shrkwAjBUU4ZWHFDjy3siCzYJTn8ndD5x2B
 MdFqR4roeJd4VM81DRBz/smr0GKUmiSnlu7vWVTunC5RZ4qw7LgRKtUhxW2RlJV7cxGL jA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjy1j5fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 09:50:20 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39J9OAPt009668; Thu, 19 Oct 2023 09:50:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3trg0qgc08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 09:50:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSaMSxnwLNegagOIMgr0Cmol9QurJ9lXr22rbgSnFphHLteqhPv7psNCeOLF26CQLCYFHPnOv1xEY6Zzix7l8N8DcBflFv0JxGWPpVLTNuqhTEWLw6K0afYd4w08KU3dsLZZWQBi0HoCzHVSsb2bisk+IV2piOj/BgD8ZMeU+pCRjaOuP2EgdmxgqdEgSSV8miv5QJUBfXKBkNlDSC+FK7I3Hl8ylWBdAUsMP+q2sU579i7QkuqPDstFz1QJgpF103SHa1TEcoQjfD3p/bDJ5+XwnL7gBUwHMpJ8CJyFBC3Jpzi4VZbBqwM8D5V110OiYKiUgzgm/bR43uMhnntwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WB+JArNsbhXRI8qSsxfWfj1NTUXTIFfyYSkdyQ7deew=;
 b=UBN7TAA0cv2T1mqOfl5B/tK88L56cRP9pmaOBFtBLS0eA3y2+w8eH1cydZE2WO2t6oxeUWOHMs3/sqOZYKu/HVe+V3osJY+olW1+Xk7WiLxi/jdoS3FYW49iMAxN9Mtj/IwfksgcGTg2lPPJzr32PlIltyIo7cX1Kwj0oHI8vi+rq9vmFsqK/0JHldYpeJy2O36PQhPi7U5/6GhjYPEcGBfJiLmruuUVGDvOPRms+H6v+jpmpgW9g+qPFTSgGvZivetuXrDwLhc30cwHqlOsJzeaPWJ1yMrWf0/S5iRPNw/x3QlBrS8u5bt8evK45SIlSKVU0zQM8F2nUMZCHUGohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WB+JArNsbhXRI8qSsxfWfj1NTUXTIFfyYSkdyQ7deew=;
 b=iYKsexuGfgIJe8LbQZAYLabHC1zKF8y2ENoAlePjJDC9cEy/1tXm4FrLD91+RBUYhOHKsOBEhXstrouS8LOE5g5AeC+8g3zAVD8W3yzMu7Lo5Ju0H7i3j0oQzO3VORXqJMupPB+6pWvcrqwbab/7QW8Mrry4xUGq47VWINbZyig=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DM4PR10MB6184.namprd10.prod.outlook.com (2603:10b6:8:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 09:50:16 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3%3]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 09:50:16 +0000
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
Thread-Index: AQHZ/cNWJqm/pSxZvkeMuMYpUSehELBH6oqAgARG/4CAAAJ8gIAEs7qA
Date: Thu, 19 Oct 2023 09:50:16 +0000
Message-ID: <51B6C120-3707-4730-AE14-0F5CD32DC984@oracle.com>
References: <20231013105129.25648-1-salil.mehta@huawei.com>
 <4764CF47-47CA-4685-805C-BBE6310BE164@oracle.com>
 <187d0a24a81b4f1abbb23795325073ea@huawei.com>
 <D78AD548-0934-48E3-957A-E5123D9E7F4C@oracle.com>
In-Reply-To: <D78AD548-0934-48E3-957A-E5123D9E7F4C@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|DM4PR10MB6184:EE_
x-ms-office365-filtering-correlation-id: 389202c8-67da-4048-8c9d-08dbd088cc4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9x1yRPjmc6pvotqYt6SAEnx7GadQeePw7eQU8gaEsGyGlASOLtYIva37DHDr0WgYQuLHVkDMno/mh9R7gQjEqF8Vp5T14NOKoXaFWGbjuBvUR8XP6p1pBC3RZaEmb3vr+AvNH7VKKvwBe2v4Lk7GHN3BErQz1JQtdx0UnozkHX1jq2apbuZlUuYpGzDu2nMyZOjS7IeIyasM7yyBtmzPYf5ta3fqvQ1HKoK76otP3u04w3msL2DA+pxx/xSMsASUqnqYtL5PIT0+MQyVrgQFEKeaCK9hFUnxJsQdV5V+XLkTvZUsnYhgGH4jD4EIMXVfb7ejshgnIPL2qQn6CWDCZHMwrLSGiJQKxObErvhxsX2AwJiq2gm8NUZxp/864Ht6UPbkIh/HGiSqH9kotc9lIMFHlvLLePXri6gG5STy/lxbD17ePs2m1SsfDMnaCi74pQR8Ouuqa+YHD5+N7SStM/s5HgEdx4IFcdcXJ02BmrYBO7hXYPM8/y622DHd9sXplinhZ1kezjtIwHCHKIWnzHerzKmIaLzceZ86LrJEx+LWAZSGlfm1qVbjGK9fi4AGqYvkxoGiQ23kyj83MqzTS8PFw+WEZYXGpilazdoAWk9QjYqvdBQEffdnWqK78GPKhiimqX48+iM//ZaA8XpQ/EI/jBHkUumyM1nIJPKV5YrDa+5EVXJz8CZ9mAitGQgu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(66899024)(86362001)(66476007)(76116006)(66946007)(91956017)(66446008)(66556008)(64756008)(54906003)(6916009)(316002)(71200400001)(966005)(8676002)(6486002)(478600001)(8936002)(33656002)(5660300002)(36756003)(44832011)(41300700001)(2906002)(4326008)(7416002)(7406005)(38100700002)(6506007)(38070700005)(2616005)(53546011)(6512007)(83380400001)(122000001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFVpZXA4SS96czdUYUlKYTlQSmdTSFRJYzZqOVJEaDNIZ1hSamtRYW9sNTJW?=
 =?utf-8?B?NkF0Y2hWR2g4TmwyTDhwNlcwYlM3b2JkNzROb3JZNm9kalVvTjkzUGZwNnVl?=
 =?utf-8?B?bnkrUytMOW92cXFrWXRQQVJHck1QcWNsQnNVZGZOR3pHTE14MldpTUo1Y3E3?=
 =?utf-8?B?T3dTUk1QZm1Vc1B2Y0ZSYUZ4dnA1V05VM2ViNGJxcHhoRmJJUFZPMVl2d25y?=
 =?utf-8?B?dnRvY0xyeGJRT3VKMTg4ZWJXbWdpU1JpNUdLTzJwaG9GaTFBYWFrYjVvSENF?=
 =?utf-8?B?TmdiNWxiYlkwWFFKbkcxR09mQVNzeFpNUEF5TDlSTklFdDFWbWxZcEhkL3cy?=
 =?utf-8?B?dzNiNE1UMDlYM0VxT0NKYm9Ebmhub2ZJa1ZYQXRDZUpyMkk4NVMzbWJUaXN4?=
 =?utf-8?B?MlZqanQyOFFFY1EzTmtBTm5CZXVjc2VxQ3diM0ZRT0FTbkpyNzNUUGx2Y0Zk?=
 =?utf-8?B?SkJTbEEvVkR6OHREYy9yL3RZaDU3R1ZEVmJET3ZyM2VkRGpDREFqQnJLOG82?=
 =?utf-8?B?S1ZBNWRkL2F1YlV3WEw4WFozWkFHQnpRak4wWU5kTHV5NjNubG9JZnpkQlB3?=
 =?utf-8?B?aXhJUUtjQmY4RzNqOHVnNHlxek1NblVPZzR1MDJOWi9iVXErU2FsWFcxM05O?=
 =?utf-8?B?NWM3eC83MnltcVNvNmh0dUZxWVlPUEtKci82bTJ0aE5xNnpGWFQrSHdoZGNr?=
 =?utf-8?B?VS9qVmlpVXNZU2d0MGk1em5YeXZodlEvK01VRmhvM285NXpiN1dTbFR3Ty9z?=
 =?utf-8?B?S0hLdVJ6K204YU0rTVh0NkRqTVhZdWlydExzcVBGWnNoUTN1QkUyOTBsY1Fp?=
 =?utf-8?B?VVdtSWRFeHJKZWw3dE11REkxRlI2MHdzYm4zWXpQNExJOVUySDU2YUZ2eFha?=
 =?utf-8?B?eFJlMVh4eDdKdkFHV3RCcXZJak5qMDBxTnd3WGc3ZjhGWGdObVBabU1YR292?=
 =?utf-8?B?eXplL3BFeXA1NkdUU2Z2NEZjK3BmR2FYSnU0MDVkOWxONWxzVVZDQzZaRmlw?=
 =?utf-8?B?elBZSkhNSVNHYjkvSTV4YlYwL0JlalpnYmd3Q1pJa0NWUExpS25DMVRuakVp?=
 =?utf-8?B?UTNUa2h3OTlkejhoOHV4VXYyZHdZaDlZMlFsQ25UVGxUV0VKUEFOZjlmOGVI?=
 =?utf-8?B?eUNZc3cwMExCcnpOcCtnN3ZGZ2hmRXJ4Q0pSOUZDaGRpNU9tVzZSTDBqUjFw?=
 =?utf-8?B?aDNNaVdRcEdPSi9tK2NOQVpMakczY2pFR3R2RS9DM1BYTU5aVFJWUG51VWdR?=
 =?utf-8?B?azMrOVVLQWpmNWRhSGdxK0UveUEyLzFIZDJxVkRFaS9reUwyU3B2dkxVVFQ4?=
 =?utf-8?B?clgvS2RteHVPMkdLMWZaVzZRMlQ3dThVNkZsMnoyT1JIQWN1eTQ1YlNpRnM1?=
 =?utf-8?B?bFpMeHhvSjJTYUNqQ2tDOE9EZHRFYUpPcFFrRVhMak1JekVoQUx3eFdGbk1m?=
 =?utf-8?B?OGVOaTd2NysyQkRXZ1hiRnZkdEpZV3JGdlZOTmp5cFAvNFJ5T3M0SjRHU0tG?=
 =?utf-8?B?czhjTlQ1TmZCOXA2T2Zmdi9Oa1ZVMWJxMkdyQWFEZFdKWWZZWFVNNnNMTHpQ?=
 =?utf-8?B?d3ZNR0ZoUUlZeGg1LzQ5K0k2S3NWT2xmVDQxSTNDa2krQm5HMnJIdERTczFD?=
 =?utf-8?B?OE9acCtuSm4zN3p5eDZBeWFFUGdyZkNwdE1yYno0VnhmMXBtN0p4YUhIUUJn?=
 =?utf-8?B?OVg0TzAzM3V1SUdYdTNRaElGSXJhcVQ2ZUQrckJ5c0RGaHhlbG1tSC9YeHU0?=
 =?utf-8?B?R09xZzB5QmFXMTNCYVEreWtNbmRiRWVhSUZKR2RVNUpVZzZCVmtReDRxbFh1?=
 =?utf-8?B?RjlWa0VBK1BkQmVML2dRY2pBOHEyaE05MUNJbTZJM3RqWDdZVGN1N1JDcmFQ?=
 =?utf-8?B?YkQzNzVJYnZKQU9xbkNRSEIvRU1PSnZlMUxNbW5FeDVXL2NoL0xIcVpFeTJ3?=
 =?utf-8?B?V3I4R2owU2NxL1RVeDgvL0g5cnBQUlJJalZCai9kR3AwMTFKU0hIaVkrYzdQ?=
 =?utf-8?B?WmdvU0FHUmZzTGhCdU84RzJnaDRMMEFlemFIaStZNG9IY1lGK3RWaUtTVURj?=
 =?utf-8?B?WHFGV2xNaDh3c20xQTJzVWk3dVY4cVlvRStldjBPditNZUdPRUZid1ladDZp?=
 =?utf-8?B?Um8yTE1CaVlWY1lJTGJRYWw5QXhvSmtERDJScmxYN1V2MHJzaytUaVNwQ1pk?=
 =?utf-8?B?NlFyN3NrbDZCcEpxVHd5QlpxV1dLR0Z4TWl4Y1VEVUxPYnVDNVZ4UzlCWGdz?=
 =?utf-8?B?S3dmd2xPdG10c1pSWmlmWjdRdzZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C5ED297DFDFB745BC1FFD370B1F6733@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VUNpdEZJc2RGSWV1NS9QNnc0cU1DVm8vTU1IUGN3S2VGWks2UHl4VERKajkz?=
 =?utf-8?B?OEZLRFVxNk5qa21KbXo3aU1hV09oc05wZEgxaG1pSENxOEtJa2NiWlI3OEph?=
 =?utf-8?B?T3JMRVVwbkJMenREM3BHVzhmdG5mU3czMHpqOGM1U0JCVXc3YUcxMnNCTkRy?=
 =?utf-8?B?anFwWGc0dGNZNFVhT1p6c2NMZFZZNWY0YndWYVhudlhaOEF1ZUxXTElESHMv?=
 =?utf-8?B?QnlqTXhiQTVwNmhqRWVZYmpCQlFYK3E4VmV1TDRuQnM3dVZtZGVuMWRvamc5?=
 =?utf-8?B?WTc2LzUwUWx5WTFzY0R5VitYR09zTVk0SkFYc0wyb096SEFNZ3Q2U2tFN2lL?=
 =?utf-8?B?aFI4dFU3MzllUXIyQ3IxS0ViU1lBSjJ0cWRXb3VNMlJxbm9jUGxud0hjOVJ0?=
 =?utf-8?B?Um9iZC9VQjVONy96MWpIeGJEa2pwcmt1cEMwMzE1aXl1RjJaVmx2eFFiSXBv?=
 =?utf-8?B?ekRYUnNZSXRRQkUwMlhTZytiRmdqU1hVZWdWUnNMVnlWOElLSHFRMEI4M0Ur?=
 =?utf-8?B?T0pscHh6QWlKVTc5amRwVVdkcWRQWUFsUVB6UkhoSC96N3lZSzQwTlZlWE83?=
 =?utf-8?B?YlZBTEZMMUtvekJvUVFySkViQlpYNHBIVHBqWXIydHNkZVlFdmgxeEF5ODJr?=
 =?utf-8?B?WDVKOVRtS1RoUG44c0dyQXh5VGtYRDA5aEZaUEcxcklzZkxzdDJzOTRXRzVX?=
 =?utf-8?B?OUhLM01PTS9qM3JMeTJjWTFUQUpQdjkvUnZKd2JreFhDTWxWZVBDZmVLZk1P?=
 =?utf-8?B?VEJIM3NucEVjWHVmSnlBbVZ6UG1UWVQvZ0hCaDlNZGlFSkFFd0VJbzNrUDJF?=
 =?utf-8?B?R3hsemRvbHJrY2piM0tScFBraWR1bmpGdlRNbUNXaGZ6V1dzTFNPWGdqNUdr?=
 =?utf-8?B?bXpteEg4Z1VXVlprM2RSQjNlbmRieHMrWUJORE5tL0lVN3lxdFRiWXJITDdz?=
 =?utf-8?B?Ri91cHlBa3NXQUZKdC9PeEtFa2t1bjRtQWhRWkxnWFo2cnUrd0pURllWd2NR?=
 =?utf-8?B?NFRmY01JRmlReCsyTUpHZ25lV05WczVBd2hOSEdXdmY0VTZQYW40cTd0b1dq?=
 =?utf-8?B?S1hXTzVySlV4eDN2TEFVbjh3TUh6VHA0L0tEdmJHTEhKOUxXVkRlY1BnRXRp?=
 =?utf-8?B?cU1MVmt2UU1hOEFzZjVRZmE1Tkc0ckthY0pKTzMza3V6YkYyZ2VjSkd6TXJw?=
 =?utf-8?B?V0h0ZW1BSzVHeCttR3FPWDM2R1JUdkNJcVBLRHpVdU9lMTZBdllkbVF0bzBt?=
 =?utf-8?B?bllTS2Z3Y2NIcFUwU05CZXlSekpxWVJqZFFxMmlYeGlQcFJGKzgzMVBqQnk3?=
 =?utf-8?B?Z0lXMTI0YWdlelNnOHpMbFdjWW83QWFYcXF2Rm1xMWdVZUIrM0NRbG04L2l3?=
 =?utf-8?B?YXhPVkhBbTFOQmwraGdDL1BYdkplZnlBVkpIZUdzRFlaT2xROHNGeWU4a0tH?=
 =?utf-8?B?L3kxT2N1R2dldjhpWjd5SHZ3dDJoM2N2WmJUMlpBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389202c8-67da-4048-8c9d-08dbd088cc4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 09:50:16.4449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dl7wrQLUkSBYYrJIp83Va2ZqGTHJtAQ0HAVN47i37097ZxfCoxXrgwSL05Nvk3KojdDtrUuorYlIVP8WM7j2xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_07,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190082
X-Proofpoint-GUID: tVAGw0G2ETOL2DRWdpqFI1nw1fTaJeVQ
X-Proofpoint-ORIG-GUID: tVAGw0G2ETOL2DRWdpqFI1nw1fTaJeVQ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0a-00069f02.pphosted.com
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

DQo+IE9uIDE2IE9jdCAyMDIzLCBhdCAxMDowMSwgTWlndWVsIEx1aXMgPG1pZ3VlbC5sdWlzQG9y
YWNsZS5jb20+IHdyb3RlOg0KPiANCj4gSGkgU2FsaWwsDQo+IA0KPj4gT24gMTYgT2N0IDIwMjMs
IGF0IDA5OjUyLCBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4gd3JvdGU6DQo+
PiANCj4+IEhpIE1pZ3VlbCwNCj4+IA0KPj4+IEZyb206IE1pZ3VlbCBMdWlzIDxtaWd1ZWwubHVp
c0BvcmFjbGUuY29tPg0KPj4+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAxMywgMjAyMyA1OjM0IFBN
DQo+Pj4gVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPj4+IENjOiBx
ZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtYXJtQG5vbmdudS5vcmc7IE1hcmMgWnluZ2llcg0K
Pj4+IDxtYXpAa2VybmVsLm9yZz47IGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZzsgSm9uYXRoYW4g
Q2FtZXJvbg0KPj4+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBscGllcmFsaXNpQGtl
cm5lbC5vcmc7IFBldGVyIE1heWRlbGwNCj4+PiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsg
UmljaGFyZCBIZW5kZXJzb24NCj4+PiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz47IGlt
YW1tZWRvQHJlZGhhdC5jb207DQo+Pj4gYW5kcmV3LmpvbmVzQGxpbnV4LmRldjsgZGF2aWRAcmVk
aGF0LmNvbTsgcGhpbG1kQGxpbmFyby5vcmc7DQo+Pj4gZXJpYy5hdWdlckByZWRoYXQuY29tOyBv
bGl2ZXIudXB0b25AbGludXguZGV2OyBwYm9uemluaUByZWRoYXQuY29tOw0KPj4+IG1zdEByZWRo
YXQuY29tOyB3aWxsQGtlcm5lbC5vcmc7IGdzaGFuQHJlZGhhdC5jb207IHJhZmFlbEBrZXJuZWwu
b3JnOw0KPj4+IGFsZXguYmVubmVlQGxpbmFyby5vcmc7IGxpbnV4QGFybWxpbnV4Lm9yZy51azsN
Cj4+PiBkYXJyZW5Ab3MuYW1wZXJlY29tcHV0aW5nLmNvbTsgaWxra2FAb3MuYW1wZXJlY29tcHV0
aW5nLmNvbTsNCj4+PiB2aXNobnVAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsgS2FybCBIZXViYXVt
IDxrYXJsLmhldWJhdW1Ab3JhY2xlLmNvbT47DQo+Pj4gc2FsaWwubWVodGFAb3Buc3JjLm5ldDsg
emh1a2VxaWFuIDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+OyB3YW5neGlvbmdmZW5nDQo+Pj4gKEMp
IDx3YW5neGlvbmdmZW5nMkBodWF3ZWkuY29tPjsgd2FuZ3lhbmFuIChZKSA8d2FuZ3lhbmFuNTVA
aHVhd2VpLmNvbT47DQo+Pj4gamlha2VybmVsMkBnbWFpbC5jb207IG1hb2JpYm9AbG9vbmdzb24u
Y247IGxpeGlhbmdsYWlAbG9vbmdzb24uY247IExpbnV4YXJtDQo+Pj4gPGxpbnV4YXJtQGh1YXdl
aS5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNiAwLzldIEFkZCBhcmNoaXRlY3R1cmUg
YWdub3N0aWMgY29kZSB0byBzdXBwb3J0IHZDUFUNCj4+PiBIb3RwbHVnDQo+Pj4gDQo+Pj4gSGkg
U2FsaWwsDQo+Pj4gDQo+Pj4+IE9uIDEzIE9jdCAyMDIzLCBhdCAxMDo1MSwgU2FsaWwgTWVodGEg
PHNhbGlsLm1laHRhQGh1YXdlaS5jb20+IHdyb3RlOg0KPj4+PiANCj4+Pj4gVmlydHVhbCBDUFUg
aG90cGx1ZyBzdXBwb3J0IGlzIGJlaW5nIGFkZGVkIGFjcm9zcyB2YXJpb3VzDQo+Pj4gYXJjaGl0
ZWN0dXJlc1sxXVszXS4NCj4+Pj4gVGhpcyBzZXJpZXMgYWRkcyB2YXJpb3VzIGNvZGUgYml0cyBj
b21tb24gYWNyb3NzIGFsbCBhcmNoaXRlY3R1cmVzOg0KPj4gDQo+PiANCj4+IFsuLi5dDQo+PiAN
Cj4+IA0KPj4+IEkgdGVzdGVkIGl0IGZvciBBcm02NCwgbWFrZSBjaGVjaywgYm9vdC9yZWJvb3Qs
IGxpdmUgbWlncmF0aW9uIGFuZCBmb3VuZCBubw0KPj4+IGlzc3VlcywNCj4+PiBzbyBmb3IgdGhp
cywgcGxlYXNlIGZlZWwgZnJlZSB0byBhZGQ6DQo+Pj4gDQo+Pj4gVGVzdGVkLWJ5OiBNaWd1ZWwg
THVpcyA8bWlndWVsLmx1aXNAb3JhY2xlLmNvbT4NCj4+IA0KPj4gR3JlYXQuIE1hbnkgdGhhbmtz
IGZvciB0aGUgY29uZmlybWF0aW9uLiANCj4+IA0KPj4gSSBndWVzcyB5b3UgYXJlIHJlcGVhdGlu
ZyB0aGUgc2FtZSBmb3IgeDg2IGFzIHdlbGw/DQo+PiANCj4gDQo+IFlvdSBhcmUgd2VsY29tZSEN
Cj4gDQo+IEFic29sdXRlbHksIEnigJltIHJlcGVhdGluZyB0aG9zZSBzYW1lIHRlc3RzIGZvciB4
ODYuDQo+IA0KDQpVbmZvcnR1bmF0ZWx5LCB0aGVyZSdzIGEgcXRlc3QgZmFpbGluZyBmb3IgeDg2
Lg0KDQpUaGUgZmFpbGluZyB0ZXN0IGlzIGRldmljZS1pbnRyb3NwZWN0LXRlc3QgaW4gd2hpY2gg
dGhlIGFzc2VydCBmb3IgbWMtPnBvc3NpYmxlX2NwdV9hcmNoX2lkcyBmYWlscy4NCg0KVGhlcmXi
gJlzIGFsc28gYSBzdWdnZXN0aW9uIHRvIGZpeCBpdCBoZXJlOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9xZW11LWRldmVsLzE1ZTcwNjE2LTZhYmItNjNhNC0xN2QwLTgyMGY0YTI1NDYwN0BvcG5z
cmMubmV0L1QvI20xMDhmMTAyYjJmZTkyYjdkZDcyMThmMmY5NDJmN2IyMzNhOWQ2YWYzDQoNClRo
YW5rcywNCk1pZ3VlbA0KDQoNCj4gVGhhbmtzDQo+IE1pZ3VlbA0KPiANCj4+IFNhbGlsLg0KDQoN
Cg==

