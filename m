Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B2373E0DF
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:41:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmSZ-0004dj-Mx; Mon, 26 Jun 2023 09:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qDmSX-0004dL-BL
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:40:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qDmSR-0003Eo-8u
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:40:48 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QClD1n030300; Mon, 26 Jun 2023 13:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=oze/0V+8NRkg4yBiINtfcetbqtqqKnYwvZmkGBosBrA=;
 b=Jtv+4RjDi5buNLoKSQz/hlGeFjO8AWeWc52eKPmfYdW6fQ0yXd/vXEHooFIsDJax9yTv
 Aw+7tPgDabm38Hpgr7/6tZo9QBYgNQh82ulxLbj2gy7Jblzm9lZf6qJgd8Qnnn/wfpza
 lTYGc/vrcbirqBDvZ+BernLgLpzWblBdh76cqd0t3VYu4kAVWyasELUshOj84lgHRHaG
 ek6akAETn2cFTXjThbrKU4hmJsftVG2WRqCY1GI6adFy/Mj2iEYNh3lgyxEADNS5Lrdv
 lT23SZsqxpjdSrHNRmGZmJTGBh33aewt+QYIQ4igNTA96lt+griRcjYbj2YfRUyD6GsE Pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrca2j6a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 13:40:40 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QDY7G8011121; Mon, 26 Jun 2023 13:40:39 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx33hym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 13:40:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRocKFc7ojItmcFxVz9ZUn14tyet1hnobAuGIi1VS8BazdY5iLHNdoUcgSa76FA8sMu+ptLuz8K55moeocfHrqoojgDb1ozCIvHpc/ILoiCQ/VwajlyL2bHSbRPab2gfgYYST4ohp2MrZR85Pu1+gMFENLGda2XaBqcOvab4i6d+wcHuOthCEpMVTlUZggeOBMXLpfOXZw/jHPXSQRsvs168OVdJfeWxs30mhGAD3kS6aJX10At65mix8ZoFJg/YdkARdM+Skm+UqZipHICDisiRuC9FGWqWck2b7atKGbhoPPfUQgZvXP2SShGgL7Xh5fxyFCwlxiw6y2AERUJUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oze/0V+8NRkg4yBiINtfcetbqtqqKnYwvZmkGBosBrA=;
 b=fdhBdZZrwuIxUk0j64Kju1xxFlPGoqeT5io7VefddsiUW23N3GqFr2KKVgpNZPyZ4FAi7cRaSR54NcKSJid2LVyig464vSG4vQN8MrI6nUsLD07cghUHUEyJSQPGq78dcM+c67+Vqk/ioRqfJWCeyNBS8sT/srrtkOBNcAwwGbo9hq6y1rgAF60Ix2Ho+WnH9mYsfDheIJiC6PATTJA4wGs25rgPg4i8RLsW2L2FCFwI3s9IozY+uycKU3Ktfyhg03kMO2YbYkM8Xbz0ADZoHZVx91PqRuK/qBF3vaUEIafmRZBX2ImC/rWhOQFb/K+h3ML5Iq6I7ptiyL25xhJb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oze/0V+8NRkg4yBiINtfcetbqtqqKnYwvZmkGBosBrA=;
 b=xhtPKQY6qnHHLl4iROUd3UEcme4JzAWAaCoelo+16ViAgeWEuBee/cVuLqCj4qxLyNY+XfU+qrc13LkgNPm292XTE2Vc7lnKi9YXakIRhd8jMBhxJs304onEVLzFzjeCiyep0u+AXA1vB3WR2joQyfunUOzCDQ22aBTMO5nPbe4=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH7PR10MB6626.namprd10.prod.outlook.com (2603:10b6:510:209::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 13:40:37 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 13:40:37 +0000
Message-ID: <62b1ce2a-8191-fc6b-c7b7-e4c787deacf5@oracle.com>
Date: Mon, 26 Jun 2023 14:40:30 +0100
Subject: Re: [PATCH 3/3] vfio/migration: Make VFIO migration non-experimental
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, qemu-devel@nongnu.org
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-4-avihaih@nvidia.com>
 <cd94caa3-cb16-f44e-6ffc-2e8fc37e9441@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <cd94caa3-cb16-f44e-6ffc-2e8fc37e9441@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0541.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::12) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH7PR10MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9de83a-a818-41ba-8ba5-08db764aec77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTKZ+8zAGfILmEe2My3IBQkGMSzx+bTWMJZ6kFVwihC59lNVa0Cr2kOUw+wkUSYXB03GykEJdqk7x3DQ9k1TZbYRC5cP8vMrNJ+uE9ZmCVjqUiZMi2RNtqNfP18z+ki9ESq24oOMaY7l+uPUk2r8EmkorASKoxrF5Ous45UBcuNCrcSL70b0+WFxtWSypFmRnusJF/LuATe07kyYbX0JVT2/Zl1SzZ5NcoYVVHpPlAtp5Hn0H53sFFRD1NngsgStDFk4JxKQ54s4X6PqZuEoJazH8y9ReD8I+oSrqBqqrAXTOMNyJFAlzEuJYnQYnthqOMpZBVBKe6QJG++CcL3zDOqsai8BwBR6sIdn3v1N/eVfdOuuBf/hLxt3kSG8U+06Xgcz7qxGOxUiUOQ8FxIR3SmgdKYS73pP9jkd22oZr2b4fX0L6UOJEaLZ53bPRTF2OoOBq5HosbYQz9+Pm7XX2v4uZqq/MtqB8gVmz7EyCqA4jFS17GwRZ7oDOuUTzKDWxADwoZC3SjBGIU0w9WEdD3Kphg7VWIB0m/cTEHWt3G77reIDT5odFE8s4yzC9sk9GA+NnDyB4PJZal5aXfIINKQ2VDljoa9cShoHhc4Iz9okDvX8cY+ONGj9bqaj0COC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199021)(66574015)(478600001)(6666004)(6486002)(110136005)(54906003)(83380400001)(2616005)(26005)(6512007)(6506007)(53546011)(186003)(2906002)(5660300002)(7416002)(36756003)(38100700002)(4326008)(66946007)(316002)(31696002)(86362001)(8936002)(8676002)(41300700001)(66556008)(66476007)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1ZFOGlRbVpTcEFlajd2ajhUMy9BdEJ5NlhFaXhPNkVmR3FEdkNiOHB6UTVa?=
 =?utf-8?B?QlB6ZDNaTUFHdEhrSW95cXB0ZWpYeDIvNkNXOUtjZ0lWak8xS0dUQUNFTHp4?=
 =?utf-8?B?elRucVBJNThDVitpYU9kcHJMZUVvSlNtMmxnNkh0dDJ4cUwrWWhuclBORjhj?=
 =?utf-8?B?Q24zUWZqa09RYWNRTnBxR3ZONHdkc3FSampDR0Jnc0VRZUdSN0RYQjBFZzls?=
 =?utf-8?B?MTlXUGZma2ZUbGoybjE0bHZWdm9LRDNOdnFUYldPWitHQTVqVWQ0Y0E1K3Jk?=
 =?utf-8?B?SnRWa2FQYm9iUUhPdmwzUlJJVWdSNTVOd2dubXVDTGpuNlAzWTFtOXprcmRN?=
 =?utf-8?B?U1RCOTl0QWNOL1AvTm8rWjZIbXlSb28wMTRhdlQvSEpCTy9QUjBWWkcvNXhS?=
 =?utf-8?B?eEtubU9HU0VzQ2Nad3c2SEpQRFppRUhQU1d1anB5SCt6NFVvUVJLK001N2xK?=
 =?utf-8?B?ZUFycXBSVmFrenovMVVNZ05EeHJxd0VvRFdma3RkNFl3d0RBVXZyQXRyNHk0?=
 =?utf-8?B?VU5yQlVMUlUwZ2lpM1RXNlNTZ1FRelc3bHNROTJSTGVZUkRVd09FMjFYYmRj?=
 =?utf-8?B?R0RGcHhDNjNxdXZHaisxZUZZQlVja0JCTSt4endhUjY5M3NyejlrT3BaSDcx?=
 =?utf-8?B?T2lmMUsrR3p2ZEE4K2pEREVHS3B4SmhMOVJmZUFEaXNUT05mR0ZuYk5HOHRr?=
 =?utf-8?B?UnNOblFGV1l3TEZqbzRwNVhybTUyaFdBaU9NR2N6dFRqcnh1TWhwWHZ1Lzd0?=
 =?utf-8?B?a0tQZVlTM3pBWlNiRHhkQUpIdnRzakpzZHZWMFFESCtqN3FBNVE3eERvMmZx?=
 =?utf-8?B?c0tLMHFEY3B1VmRqeDFkdHJBNGFtcHkrZjQvK04vdk5hV3BUWmU0clJIRHMx?=
 =?utf-8?B?aVh3SkorZGs4S0RheStYN0xpdkRaRllvUk9pZFpNRFBaRTh5V0RsQ2ZXcTdZ?=
 =?utf-8?B?VHh2bG9xUGRScU53YkFtZzBEcUlSd28vdkpzenFsTlU1NmIzeC9mZncvaXA0?=
 =?utf-8?B?YVFZSEl0NDFtSlJoem93NkZvZlRteDdVY0hZMEFxMHFaNGYxWlozcWFURzV5?=
 =?utf-8?B?WkF5ZlVkVk1lSmdoMG5mZE9EcmJKaXNZOWRNN3dGckhMTE55TXJsUnk2K0Z6?=
 =?utf-8?B?a1MxekpERGF1QnBjMk83TTVpdmR3Z3lYM1cxZFdueWNkYk4wb0hIT1ZRVjRr?=
 =?utf-8?B?Q3BkYWIvUVFrRU1sQXM1dTJEUncxc1R2emFLRzd1T3BVZDBEdnlYRlB3VVZX?=
 =?utf-8?B?aHVrUFdCZmxMLzcwOXlKNXhDWHNqY3V2YXVWMllyYlJjaGFTZmJPNThFZEtq?=
 =?utf-8?B?VlNtRDRJcC83MTFxM3VpVG9xQ3Jwd2JLUVFENDZ6aXI1Qnl6MENpdFVpYVF5?=
 =?utf-8?B?NlIyMWJiN2Z5TnRIb0hwYUE3QjZuUTJwdHJ0eTVtTWhHV1Z2aVlQdnpnL1Rh?=
 =?utf-8?B?dzA4REVGSFpRNm55NFg3RThUdmNsQnBTaFA3ZVl1bkJjZmNodnBhcVB2ZHZx?=
 =?utf-8?B?T3Q0ZHhKZ0MzV0ZHTmxZN2F2WkFjUDlYVU13WmlBSmxUdWhtV3ZtbW1Xc3pX?=
 =?utf-8?B?TnpvaG1pT25EN0tHVmVuYUs2SVgydWlHMmE1UEJsT3JTMnhJRVhDMjZkQlJk?=
 =?utf-8?B?NUFvaDdCWERDbjlPcEFva1lpdEpUN2VqNWFHRW5RNnpoM08xOXdjVnZjQkFx?=
 =?utf-8?B?bXgwd0xYbG41d25CUVljckdqTndNeDdLSlU0RVZMeEwxM3JaM09CTldDTE5V?=
 =?utf-8?B?UGRQenY3Z1ZZYjRZVlNGOFFPWWFkaVZSbWtKeUtyY3BlRVBtUmtjaUJweXlK?=
 =?utf-8?B?U3lqRnlKTlZvbGphZlZGOU9nK0w5N1h5NTRiZmZHdzBPdzFLbXpGcWF4bExE?=
 =?utf-8?B?dGVOVEU4cGFnVjgrVENxM2hzaE1aSGMwVWVhQUZuU0REZitXb0FUcCs5WVpv?=
 =?utf-8?B?Y1pRT0U3YlNzdjRxbWJmdEI0RHBVQlFQbUVLWkZ1NW9hNFk4SktWTHhvNmZK?=
 =?utf-8?B?V3ViRlhtZXAyOXQ0UENlODZiOVArbWh1ak5ncTMxUkI1SFF2a3E2a1NoRVJ2?=
 =?utf-8?B?ZjgzalROYXpQamJDRlN0MVgyRlkzREVhN09SMkJ0UlF3SzZWdWVYQTlYd3RL?=
 =?utf-8?B?azNMbjZXRWwxTVFyQlBuSWdHYzRJdzFPZ3NYQjhRQ0RaVGJha01BRE5Sc0xI?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SN5gRJonkd8aNEwQHnwdlGqRKMhG94x95Bzk5RECXq6Gv+dhlIQgT/T2he/glcdoKyy3DTkkrdIQUzWcgw7eEypHdMvGd4MJ99haaI0zXUBigHTCIZMF7HcVW2udmlAcuj+IbDVwIaYt0D9vQDHcJlGbbWwAD1i7iojeqQDXDbV79yxyHfQjiF614QntCS5i5AskrYJ2f7nG9UtmW3e/+XuZ9klRuJxgrFCB9bYxTVxgRZLRQ1+ZVuJldvmyMTMhtWRfYvlbK0zHecADY8JfPev0iukWgwMm7d1c2M0zrK/twx1h/RalxLqKIugnQqu8VgfsNZ2/VCyMVjcDLR1BbtlqZOCss4WL0UbfJpf7UqvJvo9pdYecH+8IAIhB0qXetkafr0dNEHvgrsE0YGOQEQBzSSBzuTMf97NpEvYu1ONheKeZwk6lJocyJJI57rogZM1Af/Cko9C+gIvkH4s1DSxwi2unuMSVWsUjqOEnQIN1ZtV3+itP7j9dRD1TipmOqHduHlwOEzanWknsu1GebseHaUvkSJARafZpD6wDINjLtaITlNew4s7nG9bq0/GXhnI/6DLewzZ0mPcX+1RPZJL6To2H0IHYaBKvzwimC9DzvVTawV2FFUixNVguQGjKDKj8hsZWxsJxkFCAi2D32hbb9dhAjwlU2wSdRcHHN70fnjPUUgAYvVx3NBXrJjahrf21VpX6Cn9lSyxz8kImrsoJQ/hTGl6D05nDwNSvRi3dgzD01oi5PRwoO+UFKHduJ0xbcbnyxrxmdtxnzBwT9Nx8osQ9kfD0DziIqFVspnYgwxc/usNtHkI6yqweQ+zeOS03j7lI5F8XTYHdGCSMbg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9de83a-a818-41ba-8ba5-08db764aec77
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:40:37.3391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gur06jmuZ/1YAtO+LJLFw/bYBUwYpimeQTEQHdbLQW0rQWxRBBQbEsNbaSXIorkGjU9a1EIjIzqeggVJtYRFhf8CENIxbZK8rOAPw1E7WHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_10,2023-06-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260122
X-Proofpoint-ORIG-GUID: k8LQBScwK0bPzjgw-JRXXowa2r-pCfDi
X-Proofpoint-GUID: k8LQBScwK0bPzjgw-JRXXowa2r-pCfDi
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 26/06/2023 14:20, Cédric Le Goater wrote:
> Hello Avihai,
> 
> On 6/26/23 10:23, Avihai Horon wrote:
>> The major parts of VFIO migration are supported today in QEMU. This
>> includes basic VFIO migration, device dirty page tracking and precopy
>> support.
>>
>> Thus, at this point in time, it seems appropriate to make VFIO migration
>> non-experimental: remove the x prefix from enable_migration property,
>> change it to ON_OFF_AUTO and let the default value be AUTO.
>>
>> In addition, make the following adjustments:
>> 1. Require device dirty tracking support when enable_migration is AUTO
>>     (i.e., not explicitly enabled). This is because device dirty tracking
>>     is currently the only method to do dirty page tracking, which is
>>     essential for migrating in a reasonable downtime. 
> 
> hmm, I don't think QEMU should decide to disable a feature for all
> devices supposedly because it could be slow for some. That's too
> restrictive. What about devices with have small states ? for which
> the downtime would be reasonable even without device dirty tracking
> support.
> 

device dirty tracking refers to the ability to tracking dirty IOVA used by the
device which will DMA into RAM. It is required because the
consequence/alternative is to transfer all RAM in stop copy phase. Device state
size at that point is the least of our problems downtime wise.

I can imagine that allowing without dirty tracking is useful for developer
testing of the suspend/device-state flows, but as real default (auto) is very
questionable to let it go through without dirty tracking. When we have IOMMUFD
dirty tracking that's when we can relieve this restriction as a default.

But then note that (...)

> 
>> Setting
>>     enable_migration to ON will not require device dirty tracking.

(...) this lets it ignore dirty tracking as you would like.

>> 2. Make migration blocker messages more elaborate.
>> 3. Remove error prints in vfio_migration_query_flags().
>> 4. Remove a redundant assignment in vfio_migration_realize().
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   include/hw/vfio/vfio-common.h |  2 +-
>>   hw/vfio/migration.c           | 29 ++++++++++++++++-------------
>>   hw/vfio/pci.c                 |  4 ++--
>>   3 files changed, 19 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index b4c28f318f..387eabde60 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -139,7 +139,7 @@ typedef struct VFIODevice {
>>       bool needs_reset;
>>       bool no_mmap;
>>       bool ram_block_discard_allowed;
>> -    bool enable_migration;
>> +    OnOffAuto enable_migration;
>>       VFIODeviceOps *ops;
>>       unsigned int num_irqs;
>>       unsigned int num_regions;
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 79eb81dfd7..d8e0848635 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -731,14 +731,6 @@ static int vfio_migration_query_flags(VFIODevice
>> *vbasedev, uint64_t *mig_flags)
>>       feature->argsz = sizeof(buf);
>>       feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_MIGRATION;
>>       if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
>> -        if (errno == ENOTTY) {
>> -            error_report("%s: VFIO migration is not supported in kernel",
>> -                         vbasedev->name);
>> -        } else {
>> -            error_report("%s: Failed to query VFIO migration support, err: %s",
>> -                         vbasedev->name, strerror(errno));
>> -        }
>> -
>>           return -errno;
>>       }
>>   @@ -831,14 +823,28 @@ void vfio_reset_bytes_transferred(void)
>>     int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>>   {
>> -    int ret = -ENOTSUP;
>> +    int ret;
>>   -    if (!vbasedev->enable_migration) {
>> +    if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
>> +        error_setg(&vbasedev->migration_blocker,
>> +                   "%s: Migration is disabled for VFIO device", vbasedev->name);
>>           goto add_blocker;
>>       }
>>         ret = vfio_migration_init(vbasedev);
>>       if (ret) {
> 
> It would be good to keep the message for 'errno == ENOTTY' as it was in
> vfio_migration_query_flags(). When migration fails, it is an important
> information to know that it is because the VFIO PCI host device driver
> doesn't support the feature. The root cause could be deep below in FW or
> how the VF was set up.
> 
+1 As I have been in this rabbit hole

>> +        error_setg(&vbasedev->migration_blocker,
>> +                   "%s: Migration couldn't be initialized for VFIO device, "
>> +                   "err: %d (%s)",
>> +                   vbasedev->name, ret, strerror(-ret));
>> +        goto add_blocker;
>> +    }
>> +
>> +    if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO &&
>> +        !vbasedev->dirty_pages_supported) {
> 
> I don't agree with this test.
> 

The alternative right now is perceptual dirty tracking. How is that OK as a
default? It's not like we have even an option :(

Maybe perhaps you refer to avoid strongly enforcing *always* it to allow testing
of the non dirty tracking parts? Maybe when you 'force' enabling with
enable-migration=on is when you ignore the dirty tracking which is what this is
doing.

>> +        error_setg(&vbasedev->migration_blocker,
>> +                   "%s: VFIO device doesn't support device dirty tracking",
>> +                   vbasedev->name);
>>           goto add_blocker;
>>       }
> I agree that with ON_OFF_AUTO_AUTO, errors at realize time should be recorded
> in a migration blocker. What about the ON_OFF_AUTO_ON case ? If migration was
> explicitly requested for the device and the conditions on the host are not met,
> I think realize should fail and the machine abort.
> 
+1 Good point

> Thanks,
> 
> C.
> 
> 
> 
>> @@ -856,9 +862,6 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error
>> **errp)
>>       return 0;
>>     add_blocker:
>> -    error_setg(&vbasedev->migration_blocker,
>> -               "VFIO device doesn't support migration");
>> -
>>       ret = migrate_add_blocker(vbasedev->migration_blocker, errp);
>>       if (ret < 0) {
>>           error_free(vbasedev->migration_blocker);
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 73874a94de..48584e3b01 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3347,8 +3347,8 @@ static Property vfio_pci_dev_properties[] = {
>>                       VFIO_FEATURE_ENABLE_REQ_BIT, true),
>>       DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
>>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>> -    DEFINE_PROP_BOOL("x-enable-migration", VFIOPCIDevice,
>> -                     vbasedev.enable_migration, false),
>> +    DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>> +                            vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>>       DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>>                        vbasedev.ram_block_discard_allowed, false),
> 

