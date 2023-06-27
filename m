Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0563273FA9D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:57:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE6Nn-0003Y4-E5; Tue, 27 Jun 2023 06:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qE6Nk-0003Xc-Tr
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:57:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qE6Ni-000099-EO
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:57:12 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35R8Dke7026013; Tue, 27 Jun 2023 10:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NvOvoCx+wY/RVo9VnqkDpjVUUIImqeKppVsbc0+ihe0=;
 b=T/tmR3cXwbacA+TnmQovXou0RxoxLXuayLpdcMsaFk+tFTiXW4acpfJwIqTY5YHKIW9P
 6Z77NyIHLTbmEJ3pSOFaa+1MBpIx3kOmpP7GMYT3PIKFEafrc7gskdeqwbdUrGneGcf6
 5FwTjai8lXClez8LT5uZQSNhgrvJXgRA9gTRezYvy17cwcoVk3I5B6WbwNg5orx7tinr
 s/6m6gLKygJzHIhhD13ZB/3nYCRrf7eFZKzMG92cfnfi6V5mJU8PD1lhfbO+3EfJx7OH
 4lc3lIWUxKX3XXwb0Z/cLl7JWTFxAnt6RZdgUkkO+V1XNa984t/1Lzt1WmUzFVhZtWMl nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40e2wty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 10:57:06 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35R9fFNB003960; Tue, 27 Jun 2023 10:57:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpxab4df-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 10:57:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoRS8DlmXvWHS4gyAPbJhUjYJjPYFF3tgAxycXb1EQ65b0Gsyavf73FsH6beJu6TF3D4rKgUfk+kTedQq1FUThTeEiqMTVSOPSpOVDifMJhQgjEq19EUWkppFin9hwU0ToCe3nwS5llebcZ2SdtK7gaQgfnUyr313RhnwX3lYbx6NM8ny5B+xKPZ9/WAQOetE5Jr2e8h/JV9hg/CJfAfLrsA7YZdspHg/B1nv9jHqUViPtBF5GbmMKHqnphSEsuzK85U++6z66dek1ZNntqIpKpHtwEHHW8l2Wm8q0aClIKRlB2ztEwypA3rj10MjxWzCZZEnVv4Yq1fWbywIOXn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvOvoCx+wY/RVo9VnqkDpjVUUIImqeKppVsbc0+ihe0=;
 b=iuQZHd5PahTEhrOdZpWUAEANHM9KvtdDg3k27WZw22HT4jglH+PubD37+yIGoCduqDXHTjlHjqfVRIP7kqbwLZTr8AG0kkfPol5xP8Uig5bcEo5JYxFygwWZ6IguMbs8+BI1Yu/9cr72JemlKcrUZYPVD7uMlesjmGDdQZzJaI+ecyD66I1V597U+bvsI+3gLsOvcdxTdpOFbHhI/ht8hLTIK5/OXo8QFXiwWGOTrB7j2IqBrM4xhEQCBDLoQqQSr8tS5P7R76ffBQohj4oHt72/UKn1wsduolMr4IQGIftlEfkSLdAaxdi9kif+Fz6W/HIIq50SGVMw0OSoMWxS2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvOvoCx+wY/RVo9VnqkDpjVUUIImqeKppVsbc0+ihe0=;
 b=mqk/tGvNDEFpvAu/2SMzXIBElbSLoVSQBDTU4WvpynnjHFOPnImfetX+c+JfmIFnRxNjSeweJEZxY0m/zMGKIj9NWsezPr7tz3J8DUBaM4XDGqmcT0K0zTvBJSlZag8w44As/Ai5wm34MCLTtpazpV+baThFxJcfCTB7jiO7W3c=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SJ1PR10MB5978.namprd10.prod.outlook.com (2603:10b6:a03:45f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 10:57:03 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 10:57:03 +0000
Message-ID: <bbdf6724-4c5c-cb93-9da3-c28d3b75620a@oracle.com>
Date: Tue, 27 Jun 2023 11:56:57 +0100
Subject: Re: [PATCH v3 3/3] vfio/migration: vfio/migration: Refactor and fix
 print of "Migration disabled"
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Avihai Horon <avihaih@nvidia.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
 <20230621080204.420723-4-zhenzhong.duan@intel.com>
 <c8583433-9b9f-4380-8076-8ca623b66770@nvidia.com>
 <3afe5106-414e-5a3d-4a15-3992f80fac5b@oracle.com>
 <SJ0PR11MB6744F88600646B8FD4E7F5019227A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744F88600646B8FD4E7F5019227A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::17) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SJ1PR10MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 48dfd662-0674-46b1-1b06-08db76fd3d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Jyu49XQvcQ02XdrRyPtfhEd8TMb2HNjPJWQ7uS+NEfu+IH5CDBP7ep6Wc665X/kdukg3Xt1ytCFYv+O8OyTb/xoRbhzLMqeasotPcq/pyHWbpgnt5+wZZq0tiAalJGF3iKIKX4qzJPzd9IUtM9JEQsUcpvy4NY8kq4c+AHtasHcQebIbw8I5Pkr1EmFm564bNdYxevJTW9XvGlWSOT4BzNrcQ2AEnGivAw2pF+KBKQjyuwcHp7Mssb33f6JSfxbpDQyl0K6GzGc3BDk3wdBM2ZrzNU4H5TpVDjJmmm+nGJTJ4qiBHixgdQVxxLFM+Z2vRVnNiCmRZvRRNkY6rZo5qRa0Wg4tQThDG8HsQUa417AD/6IojsvFKz0p5YL3V0iMIOpKa31Y0vQ86KqUVL3dtYkAqpE5SflvmBtZ4nDlddxb8dfbF10y9fXoe5v1yS5fF0my2B+ovBhed/3oNbx1s1zmPA8nuMkphqEx9QW0j568CQP/t3GptuTZQhNLE6beN0DFuXXnRkr926dhtbaETrwkg9MUUqaIjDKm/fJA5ffC4WIQrBxnw7zBwwm3W2UWFCjxcsJzrxsXI45sEhMJuW9Yy0/rtGEH2ZXQ9C0LXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(66556008)(66476007)(6506007)(36756003)(966005)(110136005)(6666004)(54906003)(478600001)(2616005)(83380400001)(26005)(186003)(53546011)(2906002)(6486002)(5660300002)(316002)(66946007)(31696002)(38100700002)(8676002)(86362001)(8936002)(41300700001)(4326008)(31686004)(6512007)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3VTcyt2VkNhcHAyRlJTZVdHQXJTdmxoN21KMWI4ZHNDQU05Ym53ZUxXSDI1?=
 =?utf-8?B?QS9yNG94R3h4cnN4RE5ndkYzQUZYUVhVOUUybjl6cU9XaGtZU3hOSmE5SHlr?=
 =?utf-8?B?aFMxT0lyeXlXaWdFRDJyeTltMTNVWVByRy95SGRmRUs0bC8xMi8zaHhIVkhW?=
 =?utf-8?B?VFNZWVlNa2VTdGxYVEJGZHNFQklmckZTc1RuNHdyaE9ZL2w4bGtveFVIaXRj?=
 =?utf-8?B?aTlENHZ3cXRqNmQ3TlErQjlxSlB4akFYTTdpa0xaVmNuWEptWnFDS3lYVkpx?=
 =?utf-8?B?SWtBeisrL291TWUyaHF0NUpZVFlNZlVBTW1sZGcwQ3g4SGhudHZrR1Noc2lF?=
 =?utf-8?B?ZXFzZWcwWXNHTHhabzJQaU8wQXhBbjVGUHdaL09oNEVNTi85YVRrRXNtVXZx?=
 =?utf-8?B?cUwreGdNU3BRQytZSGJsaUt2VGJlR255VXV5RmExektYc2JuRUVCSm9RWTFm?=
 =?utf-8?B?dnROUHU4c1I4b0NudHhuUk1lZEhUSXRObUVsbWI5QXAzSWtTaDhtelVYclYy?=
 =?utf-8?B?eTRrMmVMT0x3czhJUVVxVVJjdThyZ3czMjlhT3pnSWtWV2wzOGpSWWRCRFNz?=
 =?utf-8?B?WUwyK281MGMrTjhGcWJXb2F3dHc4OVRibE9vSE1IZ3YwVi96Q2Y5Wkp4Ym9C?=
 =?utf-8?B?MGs1NFltT05hem1RTWRSejhjUTR4SnE4MEMvZm1hb3hsWGlRRVVxVXNyZWtZ?=
 =?utf-8?B?S3cvMjg4NE1GdThwWVM5WmJIT3JYMUd3NjR3NkJVNHBUOGVnREtTYUt3azQy?=
 =?utf-8?B?SktjUTF1OEJ4alFXM3BkMU9lY1pIR25OQ3VpcXppQzd1VGlIYlUveTM2dmJm?=
 =?utf-8?B?ZHRmUjlRSk14NC81bTdGVFZSbW5YNnRGMHorRjZ5R0JqY1JieURDdlpMZ0hJ?=
 =?utf-8?B?ajhvTDhCSTlXSGdjb3h6cVpPYmRJZ2R3ajErZm03d0lpTHpScmZNdC92djBF?=
 =?utf-8?B?akhDZit5NzhUT2cveUtHeGFQS1llRnBHOGU0T0VFS282MUpNdVd6VFk5Q3Vv?=
 =?utf-8?B?anJVR0xDTExiNmFNK1M0Q2xxc0g1UFJSa0tNRGVsNm1CSURHUk1ZUGMrYUp3?=
 =?utf-8?B?dGprODZraVY2ek9VYUxTMlhBSktXVExHSURKL296NUFsdVRrb3N1WHc2RG1S?=
 =?utf-8?B?L29xOGVEWDNjYmdkVDJmVzArb1ZWMjRLRG9SekdXZUdoV014VzQ5eStBblJX?=
 =?utf-8?B?Nm0yN1gwSHN1Zmx2a05WSWQ3YVJ6RlNtZmlGRDNOaUJRL01DdUt6VE5FVE9t?=
 =?utf-8?B?U1FxRVVxR0U3WjNSQWM1NVp0cFVTeWF5N2lRN1FveHY4TkYzWWpSRVRJakk0?=
 =?utf-8?B?c1YzOE5PL2RBQ1BJZjdnU0NFQTJPT3BiczMvQ2NwOUN1UkRuTHN6cE9xTTdy?=
 =?utf-8?B?RVFtWDh3RjBZMHc1eW14dTVGQkQzd0N6ZnhtVDQrdWgxOHNkWEpXeXJQSnc1?=
 =?utf-8?B?K1VXK3BrMXBqdGxkK1c5TzRNREE4T3pzMm9qQ0xNSjNWcHBZMUoyOHNmc2Qw?=
 =?utf-8?B?aXdHUDA0bVkvWVZBckNWM3lIbmhBRGJTWmZ6QzNiTjJwZHBCajRMR0hXejcz?=
 =?utf-8?B?U3c0bHJhZzVXRWswQUlCUEp0YndTSHRUTjZVREtUUDY1MFN6YXh6RWdQMEZQ?=
 =?utf-8?B?VHg1T2NRUG1Jcm52empuVktuWk9NUnVzVnpKYmFvNWdieFp5RjVKTE1PTEJ0?=
 =?utf-8?B?NjJ4ZDB5T3VRNCtxMlN1WVUzK1V3M1c5SG5wSzczb0VzU0txdDc4cXdqNi8v?=
 =?utf-8?B?dGlxTFErR1pGVzRtVFpNdENsQXRPZkZ6Ymc0QzNWc01laWNDd1pKdGliTDBF?=
 =?utf-8?B?TTVHVklNLzdDdlFiVCs0TWVYQXZvb2JCRGlhVGhWNzJSS0VCRWltZmpQRXpI?=
 =?utf-8?B?QU85elFqd3V3RTBneFUxd3ZhbHJmMnlUNmFoYTVLRkwvVkpCSnZFSzVRM0VY?=
 =?utf-8?B?SjV3RlZpUnpPNmlhQjl0MHlVdWRlclIzd0tSaXUzbGhGQ3VnWmJ2RGJha1I0?=
 =?utf-8?B?MzU3VFdwRTFJVjhkcUUvb09BVlNnN0V3SEhaQmJQWHdBVm01SGJUR3gvRmh6?=
 =?utf-8?B?VktOSUtaVjJuMXY2Zk1pYWRtY2crYW5DVWhjWTZzZzU0d0dxS1pvWFVpc0Jj?=
 =?utf-8?B?alFFVHRlc25FUFdDdklqWFVtdzBkVWhWS2ZQeU5VR3dyeGg0RFhRWEoyNTJ2?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mM4iwLRcp0UJ4LpEIpZlU7SvXBZzNCDyDFNGuNmzgvTuw6bbDlU8Tvqw7YSAZQP0IherXRw1pPWgvQHLH1f/pHp/e+f+ZB++87JA5PigHTxxRUETTTCmrhex2VNLV1evXq2/My2o2z+Ur5KMW5Cu7SaLqGm6+SNH3PVgShTHgK8IYafJ3D0vOYEf32YE2MzO/oEZKTKxghV5W//EzVeAHM1r8+RAXCv/d9shiZFgDZskU87X9jQ1cwzIGZjAxDBJMr2aU0khreB63BX/l2Gu10u1CN9RILh5JGrvNwDQSrPiu0KU7iTbtYKxlIaBYqm6/P80BeECfX7OB0+e46ETB3B+d6h6NbbedtrTvRUP6fvM+5IZNfyj6tKx5xxWTVQkIiPd0SFznbHH3q955GYAEoyTcIIwUhAqaVVscGNNPratPSxXW3+gLQrEcOeubhxlbOkGWP3KyRQePhbMmW6vQApI/xNAKv6V8IVcQQv3OhCTQcxVXUoxNSM1RYmaH2RNUWK33o1mwi+PNhM+djCQ2eItI0E7mR4gKzAWQyaA3KLEzVq09B0G70iN6JHAcLUuxkhdGC2WSMQRVqeiseXpLXEFfKkUFeD1vngdWYdRr+fzGxO5c3chE+RepcodXeFQjoQJ8gdV9tKE40TBGbKsKscgAYHWEpMKE5vNidZArbdrvToYPspJvNIquKDN3lVeRuLz0Kd/sYmlRWMT2uyi2LXAde263lRfdloAPaO4c9SOUPvgUXervkUL5GrtZoJgUIt+vaQsKu3YcGDbverFkkMEijH9hgURpRJ7Ayd8380rsJtor/eaX0aus4THR9cS++spKCpJmO5ezkVop1BI/Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dfd662-0674-46b1-1b06-08db76fd3d64
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 10:57:03.3615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPOdhCPZMMKQi7td49siOAUdu/Defm62+WfMX027TBSw7kkyphFDMG/gIXQIq2GUXyg3ZvOHcChu1apRoE+ihVn1j4WWGrQy4CkM9VIIgig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306270100
X-Proofpoint-GUID: U9yb4n685AnbJs4Ty8wgKWK_x4oXYSdI
X-Proofpoint-ORIG-GUID: U9yb4n685AnbJs4Ty8wgKWK_x4oXYSdI
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 27/06/2023 03:55, Duan, Zhenzhong wrote:
>> I guess it makes sense -- the thing that was tieing him was the global migration
>> blocker, which is now consolidated into the main migration blocker.
>>
>> My vIOMMU series will relax this condition yes (still same per-device scope).
>> And I will need to check the maximum IOVA in the vIOMMU. But it's new code
>> I can adjust and Zhenzhong shouldn't worry about the vIOMMU future stuff
> A bit confused, you agreed to move vfio_block_giommu_migration into migration.c
> 
>> but I don't expect to influence location, say if it gets moved into migration.c
> and final decision is no move for influencing location reason? Do I misunderstand?

Sorry for the confusion.

The thing is that I will need 'similar code' to test if a vIOMMU is enabled or
not. The reason being that dirty tracking will need this to understand what to
track meaning to decide whether we track the whole address space or just the
linear map[0]. And all that code is in common, not migration.c and where I use
it will have to look at all address spaces (because dirty tracking is started
for all devices, so there's no vbasedev to look at).

Eventually after the vIOMMU stuff, the migration blocker condition will look
more or less like this:

	return (!vfio_viommu_preset(vbasedev) ||
		(vfio_viommu_preset(vbasedev) &&
		 !vfio_viommu_get_max_iova(&max)))

Whereby vfio_viommu_preset(vbasedev) is what you currently call
vfio_block_giommu_migration(vbasedev) in current patch. So perhaps I would say
to leave it in common.c and rename it to vfio_viommu_preset(vbasedev) with a
comment on top for /* Block migration with a vIOMMU */

Then when the time comes I can introduce in my vIOMMU series a
vfio_viommu_possible() [or some other name] when starting dirty tracking which
looks all VFIOAddressSpaces and reuses your vfio_viommu_preset(vbasedev). This
should cover current and future needs, without going to great extents beyond the
purpose of this patch?

[0]
https://lore.kernel.org/qemu-devel/20230622214845.3980-13-joao.m.martins@oracle.com/#iZ31hw:vfio:common.c

