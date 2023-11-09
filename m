Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC90B7E702E
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:26:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r18lv-0003Vu-Em; Thu, 09 Nov 2023 12:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r18lq-0003VU-3f; Thu, 09 Nov 2023 12:24:46 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r18lo-0000S8-0y; Thu, 09 Nov 2023 12:24:45 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9DrQQo019214; Thu, 9 Nov 2023 17:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=h8J1JQln1xp2w+bjrJcuI8EsZhrQR0ViuJCVk1cheEY=;
 b=D2NwMxN2KWWsxr3wFTPHoWZuQCdGxJQet1thUPClObsAJCrhYJRIIQln2Fov6KnCH6Q6
 gRJDm4XAUGOeTk5DcOFM0VR3h5aD+PBocDeCtuN2O+qNPdWjk2FCTVuRhOvlkDkQJjzd
 R69ziMISGBS6TKaYx38971kmWLvnI4gHv1w6QQU4E4VP/AbOnGVX0kZic5Oj7Gp+WqRi
 J7NdXcDfoccqWxhr/K++n8monPu4JNE4R0ry/1eDKlPHdx1QbTLJMJSvIgZa9xqOOwtJ
 KfLaBvnb/B6FwnzNMUldvIR/A6k182NyWRBpxcfdjhM/0R/bN4DLhcm3yY71mCe8S0Jw sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w214jxn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Nov 2023 17:24:14 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A9GWCfL017517; Thu, 9 Nov 2023 17:24:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u8c00pu4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Nov 2023 17:24:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnzRZaLQgeFvdlmMXKs5VRr5Y6mjBIe32AN4LKEZgBcBK6DgCRIlM2jJNGf3Nnywa9DAzZbt6V4GAB+AkyeOtzeXCTYu3bH0rOkJyNpP8xkT8AShBazFtdVdrxSQzJaUSF/bzqznOabfcu2TqWZEs2GbOzjaNq+bOAsnlUpc+cW1bEjmjMQ7x5tejqCzIeyRTHnsBJ2YINAJcBlWQdQG7zRn4n2BS73fd4EaH1ynrfSN4SWuyp8PZ0bQI5UsB0SkPUpiWu7LPLn/JChS4axxXTdTlwv41X4kcU5RloA1yeu9TvBIlUJo8l0hLqtRVYd250xkLUbw5y/+URCMwgYxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8J1JQln1xp2w+bjrJcuI8EsZhrQR0ViuJCVk1cheEY=;
 b=BHgVS9yC/vjrc7ZH57u+oPII0qvMhL3hRp7v6W1h8s3e26pWDbjjEDllfRu3gCZo7jL0kDkI/+LHWDWbktpMaNPshXGdNbuFrRPum00vdDTCQUoemVPd4c6WTp29Rn71pgtd9t7S4WvKKYvUXYNQIJxGLOOSb4CMaX82qnC2keht7a/tsZ7GXN/6d2VALh3H3hqLhD2TgbynlMCphb4KSVIZNpsWNKJDnFhC9Ql134+AJOYwmkOzlT5aQigIUj4BvJMmIC1W3rMffkpTjZ7MtMZeTAKGZWjBdKkMaXm1NaKGq29jgZGBlh0sKywehKanZ16Nb1PR+I1vmhIzcphmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8J1JQln1xp2w+bjrJcuI8EsZhrQR0ViuJCVk1cheEY=;
 b=L8A12X48VSJrc7xURZtthmleYHbZQC9i2zw+AqEyMi9era6wpBvd0JL6wbjKzodrLa1+GEqdq+MlZrkxH1p8CJk/VednVMfXT78HRh4CzhW6TaDYP9pm3Qi8g10xal5ABzt2cHueaKv70Zc1Mu77mwzHzr/VbMqsyLvAvZg4EHc=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SN7PR10MB6548.namprd10.prod.outlook.com (2603:10b6:806:2ab::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 9 Nov
 2023 17:24:10 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 17:24:10 +0000
Message-ID: <39d99e8d-29ee-431f-82a2-34947f9f4eb5@oracle.com>
Date: Thu, 9 Nov 2023 12:24:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 21/40] migration: per-mode blockers
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kevin Wolf
 <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Eric Blake <eblake@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Corey Minyard <minyard@acm.org>,
 John Snow <jsnow@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Jason Wang
 <jasowang@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>
References: <20231102114054.44360-1-quintela@redhat.com>
 <20231102114054.44360-22-quintela@redhat.com>
 <CAFEAcA_LrLsJ_4PnWLW0cuuTQRP5J7yq48xm8=kLDL39MObn9g@mail.gmail.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAFEAcA_LrLsJ_4PnWLW0cuuTQRP5J7yq48xm8=kLDL39MObn9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0137.namprd02.prod.outlook.com
 (2603:10b6:208:35::42) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SN7PR10MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 800a9899-3aa3-4f43-0e05-08dbe148af69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4k6/KfuxeNrTV4V82SoSBZguq8GeHsUfekj/BXWUWXA7WaJWzuCu+tQ42hiZF9/L9wLHZ0u1tllO9FZ2HxElOsNZiej55WQjfDiXJ6Puks2wjB1BO+Z/bUTxokD8VWo2eXlY8DZCOsJA79r9g+ZhPj9G9+xzpwCkhCFr2sVZAVfAd6AAFjfbBJDXYcBn0yCtq/Kc6E7fvzZiv9WzGgB4XiuGW7ZIU6TP4acd/7MQNn+kABjBEA3KA/zW60XML6TqveLfpMpVFIIUrAP52Yw6wIPYMQDqMqlR6Fq963d93XyaXwQoLvXWBW/KrzN422oYxJJVtf/BXAIJmaazLvSF0rMpzbtnt5xcP9YZdT0xawCmbuVjD9TnaAgMsqZY67kAJViwYIXGoOA0b2UaBVlIPuIWHjbp4cxFg5ij/QEf9j8CpRSRhvVUHxuCaSKKyrNq10LoYQjDDfBN/ddQs+SstykcA1WPSu7j4CgCt4GH8Jkwy23qAmXJwp8rP10MyRFpua+49gr3lnMVJ436RCl9XsjvFe7P6m5cVdP5UqLcRI0aFW7pTJPEwGnBkRUSOzZM+bQgHuTdNl22XGs0d60y1SD7wrQJbWrw0Nhr6oangkFd4AYZPc6zXTMosk8zqtf/tAcGKlEvrJqXU4YmyRlHcr1L3vO5QpPbSJe1/o9YPy+MJEsFIHAq4gsH975/air
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8676002)(4326008)(2906002)(38100700002)(8936002)(31696002)(86362001)(7406005)(5660300002)(7416002)(53546011)(316002)(36756003)(31686004)(44832011)(41300700001)(6486002)(110136005)(66476007)(26005)(54906003)(2616005)(83380400001)(6512007)(6666004)(66556008)(66946007)(478600001)(6506007)(36916002)(461764006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHdaNjMwZFNzbGhob2VLU1NSYndHMUI3Tk5nUU1MTWJyZGJQWU80RkU1U0xn?=
 =?utf-8?B?bjQ5VlRSeUN4Z0M3bXd2T0VjU3pneXY4cVFzTE9ZL1dNQ0lBb05wS2VrU0lP?=
 =?utf-8?B?aEVReC90Si9SWlBzUmMzaDFqYmpDZlBZQmtIM3NTbDc1RU1xTDBINHZINklP?=
 =?utf-8?B?RnNVZGtJK1pQenBnRXFlY1Vqc0JhNjdRRjk3bjFHUTlLU3l5UVczZlN4c3N0?=
 =?utf-8?B?ano1TjFTQ0tLdDUvVnh5dXc4ZUQ1dzRxLzB5UzczSyt3QlJ2bFlkWUY0TDVM?=
 =?utf-8?B?MGZVVk1rT2xJeXZLZEpsOFQ3TGtFNTRZQ3YzNkpqVnZoclZ2YWRIWjhNOXZm?=
 =?utf-8?B?Y3UvSmY5dXZwU2h4NWI4TFl5bzdjenZoeUJKdGJjVzFtT2tqbHRHRkpvb1VH?=
 =?utf-8?B?Y3MyWFlEQ3ZoYS9YSWlZYmROd3lTcUh3RFFaNEJwUDlGbmc2eGZ5Mk5GWEJC?=
 =?utf-8?B?QXNvOEdlQWVzZWh4d3U4R2p1THRiWUJoMTFBVEJtVEFHclNFTGNOWStucUVI?=
 =?utf-8?B?T2FDUFFHOVBYbks4NFFGZ3F1NStrY2pMNkRaTk16Z3J6amxkYlhRVnZBZGor?=
 =?utf-8?B?Ri9qZUNGZzltZHlldGxDZkptaThSOEpsYlYvdDgzb29EcXJyTUdoR3dSYWlx?=
 =?utf-8?B?N2tRV2pkSUI2dDk5MXQ2NFpSdTVhL09TMHpDRXM1RmZZNXZFWGtEdEhHN3hs?=
 =?utf-8?B?cVFnMjhwcmlPdUhRcFB4ajEvekdzYWI3T1NHSThGVCtzc0tPTktNQXJsK3hs?=
 =?utf-8?B?ZG9wOERkWmFmVTFrd1g3VERBeVVkZXVBbGFHOXNRRE9ncUM5WWlEUEJ6eE5X?=
 =?utf-8?B?b3l3QzlIbFVINS93Tk5MdEVuK1ZCVy80YWpUUXl5cDh3dlZrQlR6N0xLMEs3?=
 =?utf-8?B?MEF4RjlRMVkxTHJNeG1DVlc4d2hpcDEwb1lHcEREcXFlR1J2cG9HRnh5cWVW?=
 =?utf-8?B?UGFEb3RsUkFSVzhHR2NxMzNGS285QjZaME5QbERpRVljOFcwMko1ZGNUbTgw?=
 =?utf-8?B?SWlJQkFqdTdVSnR4Tzk4TFJuM0MydHZpU1pPZHRnQU1VTmN0cVNEdnhma3dT?=
 =?utf-8?B?VXQrY3BuY3BFb3JyMG5LaXRIYWJ0cGJUQ3ZGMWRnQVljS2EvU0J3Zmd4OTdP?=
 =?utf-8?B?N0hjcVdaVGhpUmxYOEw1ZGI3cC9ybkw1dTJGNkRUWURmUzl6VnViMzdTUk90?=
 =?utf-8?B?ZjdSSWZsaUhvVk95eTR3bGY1aUJReVpOeW43Z05ZUXhmL1U3WXMvMmYvSkph?=
 =?utf-8?B?UCtvNDhzK2ZWT1dXOGVSOG1aN05ad2E0SnNWNzVocWwrT3RjU2Fha2JWV1dk?=
 =?utf-8?B?WnkweUJ4SmpVSGZ5aEVYYURFTkhqK2xSZDAwYWV4Z0FhTFFTZHN6Y3ZQM2VY?=
 =?utf-8?B?aVpBaUVtU3BhODBuT1F6SVBYN2ZMbEp3ZUxmWFQvSFFCKzBqREp3L1dubHdV?=
 =?utf-8?B?NFNIV0NBb3VpSlFMblk4M09DZS81Q0ZtWVk4MmF0ZC9SYWNqSmQ1Y1JuZkpF?=
 =?utf-8?B?Q0V5eW83Q0lkT2RLdTZzRVpMOWt0eFNMaGNhek9saWxCVE5BVFBZOFNtYWJE?=
 =?utf-8?B?QW1wU1VsSExaeHlBb3EyWlpOSlpoQmVpNFRpVzUvZTRqbWlHSmpnSGFpZWgv?=
 =?utf-8?B?WjVnL0FVdmVuYXJHdks5VkJVS1YrNERVb2d2YnRENm80TEhpUDFBdEV3dVpt?=
 =?utf-8?B?QzFsYzFmS0dpNFBrMlRMeWZjREtJOE1LcGl2d3ZOS1gwbUNWZWZndVZrRE5l?=
 =?utf-8?B?SzFDS2ZYTnFlL0FzU0xUUFlObmRrRDdLWE5URTB4SGNMSy9ZVkk1YzFmZ1U3?=
 =?utf-8?B?ZUw4SWtqS1pPT1ZXSFpiZXMvNEVNMUZscURkdGFOS0ZiQUdBYlBHVHJZUkhR?=
 =?utf-8?B?Ui9sQ0FBcG9TODhjWWdOa3RJdHJlaGxQMTZJSjFUN1JVcHpYQ0FIUVRSVTlu?=
 =?utf-8?B?MlV5ajk3dXl0TVFqVmxzNGNmUmxmTDRQNVZ0ZGY2V0xDSSttSHB6ZUFjczUr?=
 =?utf-8?B?S2NGWU91ckg1VlV3eHc2dzl2ZkhKTW42Kzl5cE5KWEU3ZW5YYmNDVmZzSlk2?=
 =?utf-8?B?ZVVhczlzT0FOLzNVdDJjbFhKMFFIZlRSWkN0R2tYQkxBZHF2Vitta01xK2ZW?=
 =?utf-8?B?alN2ZE5vRWV2TXdROUVNWW5jdzhBV3BXbzdmQU9KODIyV0JXb2JFMWtueXNG?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RXhUeGZvYVZxUzFnd0ZKUXpKUEZHOU1RcG4vcmV5ZWRDaU84UmxZRko0YzBh?=
 =?utf-8?B?dmRLeE9HbDVJMlB2a0VVWlJDVDlUT00ycXg5d3B1SUZ4MnRGUHY5eUE3dlhk?=
 =?utf-8?B?YjRFYXVMVDNVRy9xMDJOZ1NYZGNGYWJvQjhGdjNTbERYVSsvL3dpT1pXNDha?=
 =?utf-8?B?VXN0amFQMWZubkloL3RvYi9OWk11VGRVZ3ZBMUlybmwzK2w5MFdadzNSTTR0?=
 =?utf-8?B?aDJENmo3cUdBOXViYUU3MVN4OEJDdU9UVTRqYStqa0QxLzBIY1o4VWJJTDN1?=
 =?utf-8?B?MGRnWGQvL2dydUFBcXA1aERsWWpGbUhiOGtIcjMxNFBsK3hFN1Z6c3I3UHkz?=
 =?utf-8?B?bGlySVBoNGhMblNjbmVuMnNaa1A1OWFtaEZLbkdqL205ZEZLSEJ3VGdyRVkv?=
 =?utf-8?B?dm1KZE1KN1I3RUx5YmRudW9NYzFSVnZyb0NkY1pwaWttbVNNMDF4amtlUlFE?=
 =?utf-8?B?T2dOY0NUNXVQd2xlakcrZlZVOGxHT0xEaFA0TElaQWJqaUNUZWVEY3BrWjY0?=
 =?utf-8?B?MVVJQ2IrMk9XbjFRK0M2MEQ4cUdhanVGelVCTUdhQXZiL254bU15SnNKemIx?=
 =?utf-8?B?SmNTeEtKQ0ZCZVNsZU1nZDhGRnNTMWdTdlpUQXR6RkFXRHIyS2tSRUxNWFE0?=
 =?utf-8?B?amMxbmZOb0JsWkl3MjUvaTdDaWVuU1NWUXNiVnB5K3d5a0FOT1FUdjRyMzVP?=
 =?utf-8?B?SU82RnJFU3FmOXZQYUh4L3l5QlY3L29ZTWFLNXBGVFU3RmVzQ0tTYldibVpZ?=
 =?utf-8?B?MU9Wd2ZQK1dkSXNsbHVXYjMvZUljYXFPazlNVER1NUFET2JUbEtIeTFzK25R?=
 =?utf-8?B?a2liTm1sYWRVTXpIZDUwNHpjWE5TVkszTXJyZjZ1ZG91T3FPSEdlQWpHWDBz?=
 =?utf-8?B?bEJ2VHRBSnhOMGJqcm1ZMlJNVGxBdXlXeDk5LzcrK0JYNHA3MVFwNGgwR1Fv?=
 =?utf-8?B?QzJVdVVvTkRyYmxsSFVRZjVSQVRvbVlJcHI5dzl1N3Y1cUYwbkxYNkFEQWY5?=
 =?utf-8?B?cjIyQkY5NlRCRzlUVnp2eDdUelNtd28zUGxZSzYvd2twZjgxSmhqdGlObHZz?=
 =?utf-8?B?TnFJMDhkdmxEMzUxVnlKZzNuaEFCRVZ0Z0JNYVpNMFRFRnliUERIaGJybnFN?=
 =?utf-8?B?VmI1aTloblZ6RUJBSjd5R1VIQWI1Tk5lQzBMSUEvL3FlbXorUGtvY0FtVkNz?=
 =?utf-8?B?anJYWDFKUk5ONU9RSFJBMjNRWFFhWmcrd0VOemRkQkpOUkhDUUxlWFB0UHk1?=
 =?utf-8?B?UDJjSU84R1FMWnhndW1SUS9rWHF4a0JzNmZjeUxpMHBZN1ZndU5HN3k4bDkz?=
 =?utf-8?B?VEpzS1RobjYrRFNuYXl3YW9GUU03VldFbXBubCtmelhYYWY5VXZVaGtnc2tN?=
 =?utf-8?B?N2gxaklyS3JXVjkzSGJtaWZWd2lRdHNrZFc4WGNUYTFrTTRtcFRyVGE1Q3ln?=
 =?utf-8?B?TzM1WjA0SXpOMzVLQWpHK3I1aUxyejk3OEkySW9BYUNIc3U4TjZyVXV0b2I5?=
 =?utf-8?B?Y0Npck54ZWt2MytuSklqZWcvL2hkdEp3aE9rVUxHbnJTdnc4WGRiQXpPQ0pm?=
 =?utf-8?B?MTRrbzlFY0Q4cUpqT0RxYmVRVmRRTTJlUHk5a0crc2ozOXZsWmVmWmJYN2xm?=
 =?utf-8?B?RzNpTjVMYlZXS0ZDYlV6ZmFGZWJpYnNOWk0yVHFlVnBxUzZ6ckFUUjRXaG9K?=
 =?utf-8?B?Y1ltNFdiVy9RVFREMjBTSVZmR2FVaGl3V3RSWUVwdlgrUUMrNDJ4TW5HeEUz?=
 =?utf-8?Q?fDl+4oeETUsOPxRqPA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800a9899-3aa3-4f43-0e05-08dbe148af69
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:24:10.1270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7P/Sir0BNtaqfZBdSAjJgUM44Vy2mA6B6a2lwxkczpbvGeW4tYKsziZfFE9HCwjGtZvm4kgJcMlSn8mUqDrEsHkNmOZVorQh948mfewEmsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090132
X-Proofpoint-GUID: So3ZrvUbmgQ74AvC68DO9cfhe9mQfTeq
X-Proofpoint-ORIG-GUID: So3ZrvUbmgQ74AvC68DO9cfhe9mQfTeq
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/9/2023 12:10 PM, Peter Maydell wrote:
> On Thu, 2 Nov 2023 at 11:43, Juan Quintela <quintela@redhat.com> wrote:
>>
>> From: Steve Sistare <steven.sistare@oracle.com>
>>
>> Extend the blocker interface so that a blocker can be registered for
>> one or more migration modes.  The existing interfaces register a
>> blocker for all modes, and the new interfaces take a varargs list
>> of modes.
>>
>> Internally, maintain a separate blocker list per mode.  The same Error
>> object may be added to multiple lists.  When a block is deleted, it is
>> removed from every list, and the Error is freed.
>>
>> No functional change until a new mode is added.
> 
> Hi; Coverity worries about this code:
> 
>> -static GSList *migration_blockers;
>> +static GSList *migration_blockers[MIG_MODE__MAX];
>>
>>  static bool migration_object_check(MigrationState *ms, Error **errp);
>>  static int migration_maybe_pause(MigrationState *s,
>> @@ -1043,7 +1043,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>>  {
>>      MigrationState *s = migrate_get_current();
>>      int state = qatomic_read(&s->state);
>> -    GSList *cur_blocker = migration_blockers;
>> +    GSList *cur_blocker = migration_blockers[migrate_mode()];
> 
> because it thinks that migrate_mode() might return a value that's
> too big for the migration_blockers[] array. (CID 1523829, 1523830.)
> 
> I think Coverity complains mostly because it doesn't understand
> that the MIG_MODE__MAX in the enum is not a valid enum value
> that a function returning a MigMode might return. But we can
> help it out by assert()ing in migrate_mode() that the value
> we're about to return is definitely a valid mode.

Thanks Peter, I will submit a fix with suggested-by, unless you want to.
I'll look at all uses of migration_blocker[].
Would coverity be happier if I also increase the size of the array?

- Steve

