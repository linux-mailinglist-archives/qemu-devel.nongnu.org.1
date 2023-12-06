Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B99F807222
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 15:18:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAsiQ-0000NA-8h; Wed, 06 Dec 2023 09:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1rAsiN-0000Mf-Pu
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 09:17:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1rAsiL-0001uT-9t
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 09:17:27 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B6DSuZ1032502; Wed, 6 Dec 2023 14:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=D8b5C0k5mp8rOkfM4qFPA5N3W44gm7A6BRIJ7fRn88w=;
 b=KbgVNXjU7/03FrYDJK7ksyr2CW6EX/O6Jkxevxijo88+/kLd0qC6H21i1OT/tcC3INNY
 x7VHVKYuRv7s0Mrh1rQZG+M8IAcOytq9oddTJIyCrbbkR9i1JF9YBVeGHavc6ea1OjCi
 c8wQRUphrfyl+Nsjplspr8/fa80A69Xy+FeaxvyWpAwFSB7U7edM5wb9NRKKVFi0oLo2
 X84nvK7bkqOVirnsgP66wML4lBSN6KdQp37zFywEgTdU8Fj0U0/roc7Ssds+4WpwhK1B
 gP9A+BrXTgnxrULTATYa+lqAH5IQEo8xXVUJlfPkAxuIkLb7hU5ENXmeYJ9IZOZ8azK3 gA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdabsju6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 14:17:19 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B6EAaWU039916; Wed, 6 Dec 2023 14:17:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan5x71k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 14:17:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELps19EGwrnoiMGwayBBcdAqUHwDU4+mveHs5UwQ9EaIdAjz4AQ8EY/y7HP1vB9wc63Eji7XKm8S1QVcZOngG3MjIieAAzLjDzTpi/i0253CMlpciLUvO1uu9id9uhvEKGCvvo9MQk+e57AYltx+fONEETZ9jqO35DBQT0rJon9GZeL1PjAuqPCT+LxOHW+/o0m1X776jOrXCR/DNq76AtiKS/icwsWzzSyusz0oGhHSYEOuLXQ1swoGIoXGOe8lcdED0qP3BcR5Ej+EseBpEMSA3yiQOnsun/sRLS34dqOFgxj4lgoMwxqygYBDh7LK15A57Y8HUOfAo16gWw2EmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8b5C0k5mp8rOkfM4qFPA5N3W44gm7A6BRIJ7fRn88w=;
 b=Zp9EiPWXgXy6nEAuX+m3VA7OtdNt5NRyvmeMofuFxqrEA7yHOgPFrfsDMO7b/ig7n9qIKmdjUw9uQ+0kP1V8M56GkCWRd4oma/y0L6CpEuBeBeo7YuzcsKw0P3kPoy0SF5mI08vgWGvT0rj7a83gvqZdUIxqyAwbjs5BxA6Zu98WHrFzVI4ssDyi9azYrKOqH39ItYoYg6XUPbQwr1nOVQkrA4f/YNAqgzHBpidA7PugTIJOq/N3XEoH7ZXV/p3w4saLS75+IXFE0uU/3+5x7vQjpzcj2E/RiD1+/JaLAYLgiUrCaOum7kA6wb8o08KuhCsIu4JclltSScEPiE/QBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8b5C0k5mp8rOkfM4qFPA5N3W44gm7A6BRIJ7fRn88w=;
 b=Dt4wMzdGXhZxijQQhWYsB4RDw99P9szjWzMA7LrsQ1/6ZrS0yBhtYnS/7tqP7Ow2NBy1rpEAEtJLL4WjHgF42mVuf1e9ObrYagxsl/BE+wrVCsSyzqux+0lihb4m8j3nLsU+22B9z6hTsTN99W9W/wHU9SoLRibB2nflAV5AmCs=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 14:17:14 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 14:17:14 +0000
Message-ID: <4fd5951c-b19a-48fe-bef2-4383fcbbae46@oracle.com>
Date: Wed, 6 Dec 2023 13:17:08 -0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-8.2?] accel/tcg: Implement tcg_unregister_thread()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Michal_Such=C3=A1nek?=
 <msuchanek@suse.de>, Stefan Hajnoczi <stefanha@gmail.com>
References: <20231204194039.56169-1-philmd@linaro.org>
From: Miguel Luis <miguel.luis@oracle.com>
In-Reply-To: <20231204194039.56169-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0423.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::27) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CO1PR10MB4500:EE_
X-MS-Office365-Filtering-Correlation-Id: a074c506-659b-4ff9-3f0e-08dbf6660b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NgrAjogQv0UJLAizqPYhjVlE+IZU5wYU1V84AM+rK6LqY59ISorVM90Ffdlb2QY0SNCaB9pk/ZD9wST0oAL/K+KM9UPkwZ4TQZKhEvB9btu5iSq5IgetGbakrAo3v759Mxx8DUuix57tFc8c9S5AwGeHV5/uQaGW1oR4+ogH2a9BVIl6heIhF8ZIoGW8rbqcSNs1i8ws4C95xAvTM0FQtxAYIuUTHQkRpSa6bKhaF5HOcsPP77MeHmysHq31rNuxwXxHi8wWm2rW2H+dzwG46m2eCWPxsokYNG69YApaDqRZiLHfDlViutqPD8vyhBSh2/avLjswp9Pbfc9dfiMiyWLw748E9n3zrfsnmB4Iz2s9nFw9F0OIfmsilhoBFbolnkXNoEg255MG2TwZ+gJ2J1QXOVQjvupsAZsx4oLmW2NaZuTnThneZRG7Txa/gfGqVgx9QASXCFY41yGVUkIYVO62Q7esIOVC5D1miInmOgc6C8gx1CROwQsE8id4gquw9OQIpymTUH65AeyTaABTOjKo3/d106C5CrXgiDVkB4VF8YWNIBLtfhLHB04LhEUE17rf8/GE34zEwT1UxLX66PhQMNFyQMsp5K01S2MwH+fznJzQ/6zxgFxySrAVDv5tuTzTwRoEMu9SBRtRECEIg03Eibz4SzXKInUNVwZ4bmFVdH+lKQ/OEseq6wm+vb2g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6666004)(83380400001)(966005)(6486002)(478600001)(6512007)(26005)(6506007)(53546011)(2616005)(54906003)(316002)(66476007)(66556008)(66946007)(4326008)(8936002)(8676002)(31696002)(38100700002)(31686004)(5660300002)(2906002)(66899024)(41300700001)(36756003)(86362001)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW5wMVFJdFVOOVREbjQydmd4VWpLN0VFc2FpSndhb3o4OGQrcFJmTVpjMlB0?=
 =?utf-8?B?QTE0NkxBZVVTbE44bjhOQ2VUSFFZaHE5OTFDbEVib1I3TTRuRVVMTjRnTVNX?=
 =?utf-8?B?MFFTbEQxUU4yanNTNFlyQTByaTNxTy9IYlVtb1djQzMzclFZZXZOL3ZZNy9V?=
 =?utf-8?B?NnRHMXBxYVo5ZmVsV3liLzRGbE9OUzdRQjd1amVNWE5BcHVjSmszT09idExH?=
 =?utf-8?B?MkZNSGlWb1BlZm9xY0Q2MEM4LzM3STFwOHJQY3lLdStUakI3Y0dNVGRnT2Jj?=
 =?utf-8?B?aERsdi9ydkpPWWlXYjQ3ZHNTYjFvZXJMQVBtZ0R2bElWeGJlVXZvOXpybnk5?=
 =?utf-8?B?bFhsV1R5YTFEbE1leFErQ1lRcURkYkhhckxkaXJwKzNaNlJxdVR6WG04Mjdn?=
 =?utf-8?B?NWpEekFML1A5R3ByeUFqMGZkVHBaamJBV2NSK21tYVRYS3ZaQm9KUDRudlp3?=
 =?utf-8?B?RFFXc1MxcUFMK2FvMVZoNTBTTk13M0xmV0RPT3FCMlM0T0xZdlFhQ0E5MXdo?=
 =?utf-8?B?UXhwbWlpVW84V2Q4TUdEd3FZTnE5NTk4UnRvODdsakQ4RGtSL0JYMCt4VW5F?=
 =?utf-8?B?bU5Jd1pmT0QwV2JPN2F3NmhjYy9HS3BpUzZFWlU3T2xnYjlMU2NweTlpTXFQ?=
 =?utf-8?B?ZlV1b1IvN2xGOGRtT2tHWTMxMDJNNnV6dHVpUHNkblZpYTJhSUczcFJ0TlJB?=
 =?utf-8?B?cXpHWEl0MlNZdytxcDNFMytwS0hWY0F0dUJEcmQyRXJ2ZmszclhLT1BGcGJs?=
 =?utf-8?B?YmxqVnJvTjgxa1ZRTEcvdWtPMStZSFY4MXNqWFQwVG5UeXR6Vi9kcnNqVmNv?=
 =?utf-8?B?Wk4rbDBReks1SkxlREZERXNRRzh6YUlZMk5yeVpBeWZKc0V3ZlptRGVxMVBB?=
 =?utf-8?B?N3FXbnhBcVJobmlzb1hlUjM4eHk1aUFIaDEwREZJanZjQmNOQXJGR1B0bk5Q?=
 =?utf-8?B?bTZtaUdQRnovdUpTZjlQbjNENHI4L09sSVVqUzI2MS9EQk5OMGdUYVMwajh4?=
 =?utf-8?B?anNzRXUxOG5MeUx4eE53WlVyMU1KOWM0dGpXR0FQYXI3VTEyTnVXS3RDRXo4?=
 =?utf-8?B?RmpxSXRNaGlQdE1ONElJaTlGM1p2Y1RGR2N2OHpoSnRCSm9WVC9MOVVBNHJZ?=
 =?utf-8?B?NExoWTBjTEtUeTBNcG1WY1diRFU4U3BaZSs4OTFkak9hTW5COENtOVBabDRn?=
 =?utf-8?B?WHVlb3l3SklSOCtEYVdLblByejZWUlFuc0tpeXcrVndGczVZWUhpL0haUFFm?=
 =?utf-8?B?cWFqaUwrTWtmMzFrRUJHZDRWZTNtdXYzZHJSeS9UM0ZDTkhYTkdKb0oxYnBR?=
 =?utf-8?B?MXpiWGE3ZENZVkgzT2I3SUxNcGNxUllHOGRJTUw5MHVqaVRSbEpVcTBhOFBi?=
 =?utf-8?B?RnYyU1VFM1dKY0hwT2VYK0JQYlhwYUdSOTA0U1diMFdKSTlnSEc2UEJ1MW9G?=
 =?utf-8?B?T2twNlJVVlVvT0V0ODhhQ25URHYxSmRLSVRaRnBHZGtFKzNQbXU1cG0xcjFu?=
 =?utf-8?B?NXdMWGxSTzZRQTN2am92Yys1d1o1WjJ1M3QzSlI4aXN2c1JxNGphUzVrZ1B3?=
 =?utf-8?B?SThKazRGcmpSQnI4UXBicHFnRVNLeVFjczUzT1J6eHVDcVIraGVPbW5aanlK?=
 =?utf-8?B?WGMyb2ZtY0hQOThDVFF4ajZzNkdYQUpQeStBODBjMmQ5bms5c1VYNGttNkpN?=
 =?utf-8?B?cXdFS05YTnFwcERhN243c1BlVXBnTzEyL3dveTgralczcFMwZUxadVE3b0dm?=
 =?utf-8?B?Ukp1b1V2dVJmSm16blpXb2VFaVQ2MktreXZvVmEzUGFlc2NBTkI1amx3WkV3?=
 =?utf-8?B?aUIzSXFwTVNvelFqaDJObkRXM1gwcWNpbVBXQjZTclU4WlVIc0U3N3NlSFph?=
 =?utf-8?B?Q0pDazNpdVE3NmRydmI4TEJHb1JCRGlxMDJudlpPSmI4OVp4UklMUXJ1UGZJ?=
 =?utf-8?B?K2VUMEY3VmJNeXBySldBQnkyV0NYV1MzeE5sTUtVQXo0ZHRicG0rdkt1VE9a?=
 =?utf-8?B?bFlZWEEzN0NwU0cxU2xLcUZJd1o3WXI2QWpxd2lYU2ZGRXhhdWIzVlJoN2Ro?=
 =?utf-8?B?Q0phM2d5bG1WQ01XbE90TlJwcXRkak5hMTNOVXJUdWhaZFoxdWs0VW1GN2hZ?=
 =?utf-8?Q?0FeDYBo8SQ3SZWZgyZkxlIy+3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1EOTU0eZ07lxnYrqA+XG2CkqRK4zeXmiXTnZmPSk5lQfTFgF0SW9okA8Qk2Tf/MB4NHc0geTp8gTwJy8ZOLPjJMWdISqvgzqZaJBKaz1Z3YMZuBYnTEN6bnB5G9d7G69g2tyms2OVyvRq70zzVfFuks5qJX7DtUR1caxafz5cVt7uMg3inJECWwagH7O7xf47vdfT95639T9wU1kT7xI00mKcs3fQnTSXlPw9qGmjI0pUkgWKGmNcI6a5/G2e6LDBCy8BWz6dAwaC7K8jnok220qRvqDTugF3eGq1cjegULuLZBeuQuLkPMZ7/1CgjBgCcbLK4LNxpAxRrC3N3fJownBCb0IlON11F18xE6g7qBg9n1ku+GqjiBlCJAXh7BDF7nQKV68ZpZEmaWYU/D5Z7crwh+J3YsKmZ1/QLHWT0Cp9UoWdplQIKgv4abwvTuelJTgvFcGawofEB7ad1nRryvkjjtw8vv5nDg8PQf3cKPrIIsY8UN+vlmXha3cedle1U+FQFnIVJNoj5KDsu75/cd883TDXW0aw5cvhXn8KyibjpNiIzgWkwdpBPEqf9uHbiWaYesWmpsI+JcoyfN9dTyni374fk7XqPSodE+snj7IvMLkk/e06iRvnhHZ3eCApXtjg8ADyl/oBuTDUbBbDw8PCVzn8LWU9gcy5I03uOZedZDkpKBu0JX69u/OcNLUBCtnBlctpRltsWWRbBvUoNKZ03UfF/g3Xtk6JulJGyVeXV25tHucTU8OiTP6aXQTJaY3LgZNyqJt7DvvMiMLnsGLGZYgxmgv74mOauStE7WqVlm6Hgg7T2oMkQ6GAqA+9PMIezZ1mGhTOUk8fvKAzvY+IaOqCEVOkk4WnVZ5Dg4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a074c506-659b-4ff9-3f0e-08dbf6660b74
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 14:17:14.4895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AymTsP7N1HPhgpDt9X9TdGSaAXpJXVxo5FzSLEqOJMZ5E+xF6fBGwkNvkm0EP/vTfSgA72aZC4c5sHu1RnaLgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4500
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_11,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060115
X-Proofpoint-ORIG-GUID: 285NusSPBMUw3V4GjPg9JLyLEWSMszUa
X-Proofpoint-GUID: 285NusSPBMUw3V4GjPg9JLyLEWSMszUa
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Hi!

On 04/12/2023 18:40, Philippe Mathieu-Daudé wrote:
> Unplugging vCPU triggers the following assertion in
> tcg_register_thread():
>
>  796 void tcg_register_thread(void)
>  797 {
>  ...
>  812     /* Claim an entry in tcg_ctxs */
>  813     n = qatomic_fetch_inc(&tcg_cur_ctxs);
>  814     g_assert(n < tcg_max_ctxs);
>
> Implement and use tcg_unregister_thread() so when a
> vCPU is unplugged, the tcg_cur_ctxs refcount is
> decremented.


I've had addressed this issue before (posted at [1]) and had exercised
it with vCPU hotplug/unplug patches for ARM although I was not sure about what
would be needed to be done regarding plugins on the context of
tcg_unregister_thread. I guess they would need to be freed also?


> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC: untested
> Report: https://lore.kernel.org/qemu-devel/20231204183638.GZ9696@kitsune.suse.cz/
> ---
>  include/tcg/startup.h           |  5 +++++
>  accel/tcg/tcg-accel-ops-mttcg.c |  1 +
>  accel/tcg/tcg-accel-ops-rr.c    |  1 +
>  tcg/tcg.c                       | 17 +++++++++++++++++
>  4 files changed, 24 insertions(+)
>
> diff --git a/include/tcg/startup.h b/include/tcg/startup.h
> index f71305765c..520942a4a1 100644
> --- a/include/tcg/startup.h
> +++ b/include/tcg/startup.h
> @@ -45,6 +45,11 @@ void tcg_init(size_t tb_size, int splitwx, unsigned max_cpus);
>   */
>  void tcg_register_thread(void);
>  
> +/**
> + * tcg_unregister_thread: Unregister this thread with the TCG runtime
> + */
> +void tcg_unregister_thread(void);
> +
>  /**
>   * tcg_prologue_init(): Generate the code for the TCG prologue
>   *
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
> index fac80095bb..88d7427aad 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.c
> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> @@ -120,6 +120,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
>  
>      tcg_cpus_destroy(cpu);
>      qemu_mutex_unlock_iothread();
> +    tcg_unregister_thread();
>      rcu_remove_force_rcu_notifier(&force_rcu.notifier);
>      rcu_unregister_thread();
>      return NULL;
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 611932f3c3..c2af3aad21 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -302,6 +302,7 @@ static void *rr_cpu_thread_fn(void *arg)
>          rr_deal_with_unplugged_cpus();
>      }
>  
> +    tcg_unregister_thread();
>      rcu_remove_force_rcu_notifier(&force_rcu);
>      rcu_unregister_thread();
>      return NULL;
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index d2ea22b397..5125342d70 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -781,11 +781,18 @@ static void alloc_tcg_plugin_context(TCGContext *s)
>   * modes.
>   */
>  #ifdef CONFIG_USER_ONLY
> +
>  void tcg_register_thread(void)
>  {
>      tcg_ctx = &tcg_init_ctx;
>  }
> +
> +void tcg_unregister_thread(void)
> +{
> +}
> +
>  #else
> +
>  void tcg_register_thread(void)
>  {
>      TCGContext *s = g_malloc(sizeof(*s));
> @@ -814,6 +821,16 @@ void tcg_register_thread(void)
>  
>      tcg_ctx = s;
>  }
> +
> +void tcg_unregister_thread(void)
> +{
> +    unsigned int n;
> +
> +    n = qatomic_fetch_dec(&tcg_cur_ctxs);
> +    g_free(tcg_ctxs[n]);


Is the above off-by-one?


> +    qatomic_set(&tcg_ctxs[n], NULL);
> +}
> +

Thank you

Miguel

[1]: https://lore.kernel.org/qemu-devel/20230926103654.34424-5-salil.mehta@huawei.com/


>  #endif /* !CONFIG_USER_ONLY */
>  
>  /* pool based memory allocation */

