Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D18207998ED
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 16:42:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qez9Y-0004Cy-Hq; Sat, 09 Sep 2023 10:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qez9X-0004CN-C5
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 10:41:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qez9U-0006cT-7u
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 10:41:39 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 389EWHS0004943; Sat, 9 Sep 2023 14:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=z/3rYuDqtHtC5F+jchk3dp5hx3VX7MH0WwFpSueFpHo=;
 b=Z/yFPFBJb2TjWlfnpQitXk4fxSyzXoLN89b8/jRgaFcuSUILcHU3P0+b/5qKLOIeYXu7
 7PIll5G0hupjxv/NMvIjd2NaxddJDAs+j82rBm6O9pY+o3WUKepJtKs++EU+Z4lfyS+u
 1E5bUAzu2PpO/HHx19xsOHlWIEAdONQ0cEUbgevIcw4dG1UHj2CUMoB4A45Mn+cK/EeA
 JHjJrGCljUqq4zv356q3oWCstF7r37Gj6mEo3vc71JjJeFUStuL7juuEMzpBpm8BVtGI
 jqYYgVCLjtm3y1yuZclQpd+3xTCWrsZb7vuL1/cwuZJ7zbv6gDWyxwSO2XKLZKpLQ6PB cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0sds81rp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 09 Sep 2023 14:41:33 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 389ER7Bk004349; Sat, 9 Sep 2023 14:41:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f53dc4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 09 Sep 2023 14:41:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBvHLMYKttd0aohc5mzcidG0MUvu5YFw7cHrVOpUx/xuVOm5icPsbCDTQq46e4GMKARXHcB2QSo3Dd2NF7EwfeHSYglpgj8zBgIqTvHk50N15+B8RxNFf9TF4qVnPJBH41mh9/Aaf+p53S8SbmPPF57yXNrPk8MflB2EuAk+z41X/Gg7vyQONg9v3hIDaiUyn5IQLCPPdDqSCDxoQKIib/Ardz/GoGnG+Xkb8l0iAlOAuD+oQG0pKKZX6aDgQPuCg4WYkim+xLjodKwhCH6+bq6jcDHRsRNu2+FTPITkbWaEc4kwNAUKhEtqyB7tvzqtCb0fIt93ZPcJuLHGEwtEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/3rYuDqtHtC5F+jchk3dp5hx3VX7MH0WwFpSueFpHo=;
 b=S0qRt9V/NyLFhSYZOPA84otLIY01cwLAot9u3p44hz4xYSAr/EiEKK4xiZEBLGwkJ7yDPuQfWj5o97S9j7NlxuMxrK6rlfEy4QG9+Pw8bDZ1qqt170T37kSD/hnU65CJeqFHgdzYPuI4dGoNn8rFDkjwQqf/K5VQJfnyJcNNm51tDJsGNseGRuqbnCZsOjdnQK0bQd328k1NEsoeJAK/Tqf1Zz8k7vop9cgtfbzaMwa6ZxmgA7Do0WOil3Lr9cys8g6w+RiOA4CSgV7G52pvs3pOumVLFPBGdxOzQBQsBlcu53ZpdBPT3DXp2zvMvsBXLO8mmarw6QZblCtxZQVj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/3rYuDqtHtC5F+jchk3dp5hx3VX7MH0WwFpSueFpHo=;
 b=LyED9URpxvWY8fqkF6gDmoKXOIJCyf/mhA1pADIAlYQtN38RYQGBzydpsnz8qnaGkNlDwWv+yUyxFvJB2YMasP0JVjEFsVwpwZ6tTp/qVMXgR776Y4M7exJGMv6YcsIAmxjMS+FD6MahdXVQgtua36qMxwEHBREqZVlyeBx5UJc=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH7PR10MB7837.namprd10.prod.outlook.com (2603:10b6:510:304::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Sat, 9 Sep
 2023 14:41:29 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6768.029; Sat, 9 Sep 2023
 14:41:29 +0000
Message-ID: <77edbb00-cd34-222a-088d-98fb1a902cb0@oracle.com>
Date: Sat, 9 Sep 2023 15:41:20 +0100
Subject: Re: [PATCH v3 1/1] migration: Allow user to specify available
 switchover bandwidth
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Chensheng Dong <chdong@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 lei4.wang@intel.com
References: <20230905193802.250440-1-peterx@redhat.com>
 <20230905193802.250440-2-peterx@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230905193802.250440-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0240.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:238::15) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH7PR10MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: e7cf4a06-5bed-4e90-5842-08dbb142da58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOX4WAqMFKRxbLNfCoM91IyVgvjlf72wLnWfVvJIhmPhPCx27Xx/AA9tdiX2b+WKOyC4e0vnVLcJDqYyjLGK9hUdHlbBTjF7Z930y4RAh34S9VOKibHtE5Fhxou5uICRWU+lB5Ip4dwH8jyeNQe+cFD6O5f+czS3CQpI8ouhtsVSfshvpBe8DVsNgCqlJz+TDKCSnIXRvdhCdBT5PqG+wzl9bdjbpQ+UlosgzgraQSwS9ev48+eyT/+TyhnLvNwPGzPDcA/PPElKHHZqfFIGxVwxovGk0vE86n4i0XXL9vOz14oLPFb00lcz8lwAih5uh6zsDJUgKj2TS8T0MkKYYSaJcGH6iInLNb4G6Yc0hjU4+cYZ9bd5fFHIofvna4w3xYK2F/wD1Z9fXEy2LQHknvthzodtuVeDuQjF8Tx6BjpcYJlC2psJxF/f7s5KJN7PLo0sdnz65zqDObCnOeukb0Lh0QDcOVl+D7kinYimzJSqmFFtSlcF2yd/iIA+mB1wdp2aJvLTaciAvhsHwXQnMGwyqa7doEcHeEhPFdeB3QUS/DcGsmg8Zx+6Zn8qPCkpXhfzrejhM05S3bKr8bHZcdVc4wzJl401Z4csL9nIJlt1qxi6iNn/98MHghKQJxvC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(186009)(1800799009)(451199024)(6486002)(6506007)(53546011)(6512007)(66899024)(6666004)(83380400001)(86362001)(31696002)(38100700002)(36756003)(2616005)(26005)(31686004)(316002)(7416002)(41300700001)(2906002)(8676002)(4326008)(30864003)(54906003)(8936002)(66476007)(66946007)(66556008)(478600001)(5660300002)(45080400002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azBEMFdHdGx2TG5IdFZncjRMK25yb1FlNGNsd1Rxd2pRRUVzYjhtTUQ4YUg0?=
 =?utf-8?B?bWxmT3dKWjJvUGpTK1hWcE1LakUzTWVMMDROaGo0b2JGUzQ3YlN0aC85aHFp?=
 =?utf-8?B?TmY1aHBSU3Q5dzJrUEJGUHN0NGcxRjFZNmp2MmMwK3ovVU5RNUxXZ1FXY0Yx?=
 =?utf-8?B?U0ZxUkMrQmoxNkF4WFNOcUdadU5DbzlzNTJoRFh1Y2UxSWowNnhybVBNbU5S?=
 =?utf-8?B?cERlV0RmVTY2d2huOHNrYlBkNDJPSVpCNmRRWkRBN0pXUlVZcWpxV2xjTXpm?=
 =?utf-8?B?MThjQVFKVURYUDZOejJjZGx4L0JKRjA4THBSZWpnQTFjRTk0eTc2MjB3QjhI?=
 =?utf-8?B?V1EvQzFPL1JVcy8vckZFKzdTaCtha2ZYSHVmY29DWjB5Q01WVmI5Unl5Zk1r?=
 =?utf-8?B?TUgyOWZPckJFcFZ6QngzR0F3em81QkEzVUJheTR2OGhBNVNRMVNHR2d1ekdl?=
 =?utf-8?B?Yjk2QmdRa0lKelZFSGlkMW5la3hWMnRhdC9RSkxoUk15bWZ5ak1TOGxJUnAv?=
 =?utf-8?B?bGlYeTVuRkpXRm9kQXBkNlhseE1RRjlSSERETVN6MVJPa0ZPMWtWMmF1R0xZ?=
 =?utf-8?B?ZHJyTFRWdkQzM3k1STc1dDdtbHNLbk4wZUo5TmJKVEk3VWhJblNBZ3JMRE14?=
 =?utf-8?B?NE5lU3p5QzFrSVIvR2d1Ui82TGgyZFBZa0hTVkZWWlNmM0ZiK3FiMzJucXhP?=
 =?utf-8?B?UDJFS3lJaWw0SXRjQWk1ZkJ3bWwvK2pqcFZHQTFIRVFDeW5qY3Mycm4vUDk0?=
 =?utf-8?B?L2NHK0E2eGJqbkl5TFVGeFhPRDQxdEprdzZ6OVA5VjNpL05xdVg0TXIyejNE?=
 =?utf-8?B?b1Q0TUI5YnRmREFKUDBBVnNUd09aZ1kwRDBoWVA4NWhpZ0RxcjJvQ0o4bGgy?=
 =?utf-8?B?VXRBTm5lNHhSSFpkL0hiK1ZOTGRBcXYxdUFOZ2pLWlY3T0UrdGpWRm5oVUow?=
 =?utf-8?B?WG5BK1lBekZrclg0dWFUNGZrM1RpNWNlTjlNQ3dDNUJ3cXlQS2lhaVBKUjl3?=
 =?utf-8?B?SktuRU9xQnZ3S0NmUkp2clRGV2l6cHdsUDRZZG5YQzNscEYxWkxEOTV5NGd1?=
 =?utf-8?B?K0hXUCtoR2hlSzUwMENlb1NzaE02RG5NRGtwb1VaVDhuK1BSUEEvcC9XMDFZ?=
 =?utf-8?B?amVMR0UyK2pTVGk0dUkrSmdMRXg5b2t3UjkzNVJOK2haa004RERhengveVVY?=
 =?utf-8?B?a1FwZHFmYzNHNHBaN0hMaDA5cTE4N24xOFNuc3o3Rzc5K3RqTUFyNkVpalZ2?=
 =?utf-8?B?YU9paE9hc1JsZThRZy9oVTJsVmphRTVsY24vZFdjbG9aSkgyMk1HUmdVSkZ2?=
 =?utf-8?B?OW16ZXB0MkYxczNKWU5RWFdaZHl0NGt4VHZzZHhxdm13QWRLbEZaRkVTS3M0?=
 =?utf-8?B?cGtVcnZLMUZ0VFFPTFQxSXdVRGhSZlZSRUIwN3RHSDF4aU5jbkJSTFdvTEZr?=
 =?utf-8?B?Y2ErdHBla0hHdnA4Z2dWbWNiY0lRTkZESmlzcUF6UjN2Sy9ETmY3K3V5SXho?=
 =?utf-8?B?MjI4bmZWRTdyWXpUQTNwMWQyN2JTOWk4eVRGL3FkK09rdVIrTlZaWEdDTndR?=
 =?utf-8?B?RU5vSVAyeTA1NEpKWCtlWStpVXZXcTdTQ1Uxbk5odnRsQlVhQ3p3SDNsTFhm?=
 =?utf-8?B?Y1NFdktRWDBEUlBjUmxkZnoyVjJJbkFqTm9oK3NVTXFMLzlZeEV6UlFhNDFM?=
 =?utf-8?B?eDYxU1Zna28rekhwNHZJZWk5b2h1MWM1eWNVc1pEZjlmcDdiQlZVdlRNWXJ1?=
 =?utf-8?B?SlEzZGk1c09mUUtuNnEvbUwyNzlmUEM2c2RXbmNLVmErSUc4Mnd6aEJMMXlS?=
 =?utf-8?B?MjNWc1FLOXpMMzZoSXBDK0xJZS9kekxXcm5Jdm1LMXlTY3BVRkpjUXBDdk15?=
 =?utf-8?B?dVk1ZTB3My8zLzdzRFhuOXU1UW5oZXlJYU1hNm5rSVEvY1U0L2JqazFLbEpQ?=
 =?utf-8?B?bkdmMU9IQVpaM040MUM2amJxVzJmR3ZIRng3dVFMV1ZXZWZlaC9oYlVGZC9X?=
 =?utf-8?B?N1F5eVRxOThpeXJpV1loNWFGUFY2SWkvMUYvOHpGdkdZdzBnblg5T3RSL0V4?=
 =?utf-8?B?ZmlNWGFoaERLN1hOeUczWW9rUEN1cHBzVC9naENxK2RrM3RPTkxzcm5wMlBM?=
 =?utf-8?B?eW5UekYzelZGbzdDdGpDdGVVU1Qva0VWVzdWd2t0Y1BLalZMdmN2T1hnV0VK?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NRqQhZO0MzG8TrF59mB3VjiD6EM9xEBCKIhu4FIpUqEfeNcJCqwM2dPr2tM4UMxLTSnV5oTl2ov3AnrDNXUBk1Rur+RbCQRWo92Y2lweWYVmNhxLnItIcZ+GufSurGYDVQhD91gmih2qYGc4M6VfKNlc8A4qi8lBwTwevHCLqziv6LNVGShaVMqjki5ht7BVrL+5GgCy7dQoCsu0ipsmGQHrSVM5ct98aTBW+/lchl9aPlD/L/8CbJwG+cDgDOFIVhYbvm2RVsAAm7mssX41l7ZCeZq0hHV50rFJsHbxSv8gD2gJsPptGRmfApFsSLvGN8TI75rfzJyevYtMsPGvzSJsGkAoL26Gz2sfFSAiZ3AL+Y6y2fGtinZkP1NE5CGJa528+BG36xKOBh+2+LXQlncKW+bBpN1xPTViVkoL8y2t9+B8gDt2lyQPV+H1jMwgtEbjm+uVW40i3uSV3kfnmnQ22ebKDP9Vpo1HoIzXoepJEbmWfvkbdszTkkO+hUt9SeX1bBWTmsdZFZQLGuQbphUUUlXIP9x95bZqcZmDiNYTsTsqCIEN1GvXVyGS4E05V/zUhcqU02heWQ42WGZBhHVBxOrQRQ++EASJ+z+hzrR9FvpN+E981V4hdgLjHP3T1Q1OqmlkZelEZrbENPus3okUWwldWqL+gTmtcSmmaPgZ0BCm9B3ueuNVrrKS1RdaOBcG6HILV4xfHzBtHM2LFIvByufR8RLPD/rQgBW8xNCdYltbzjLo6Ylq7k4HHJ7hoBUyU9XpR9QUl0QAtHDkE+eFYjBiIyEgUABuRdX+me5vqcvUn5QOb1RJsEiadG0t82o0KZJfUxS8cGbjkkr/2Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cf4a06-5bed-4e90-5842-08dbb142da58
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2023 14:41:29.4799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXy5v+haQcXWgavbM4tvfVIrSw4CTNQ0IvI5kZV05KvzoIk8N+h6qkuV7c3TaJxXGiVFwafjEtq5LXrjGq+nyz7WVZHOpOFH69QQpgzqzgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309090133
X-Proofpoint-GUID: 1Y6urfPjFVKpsGK6F-f0PE1Gcs7seLSm
X-Proofpoint-ORIG-GUID: 1Y6urfPjFVKpsGK6F-f0PE1Gcs7seLSm
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 05/09/2023 20:38, Peter Xu wrote:
> Migration bandwidth is a very important value to live migration.  It's
> because it's one of the major factors that we'll make decision on when to
> switchover to destination in a precopy process.
> 
> This value is currently estimated by QEMU during the whole live migration
> process by monitoring how fast we were sending the data.  This can be the
> most accurate bandwidth if in the ideal world, where we're always feeding
> unlimited data to the migration channel, and then it'll be limited to the
> bandwidth that is available.
> 
> However in reality it may be very different, e.g., over a 10Gbps network we
> can see query-migrate showing migration bandwidth of only a few tens of
> MB/s just because there are plenty of other things the migration thread
> might be doing.  For example, the migration thread can be busy scanning
> zero pages, or it can be fetching dirty bitmap from other external dirty
> sources (like vhost or KVM).  It means we may not be pushing data as much
> as possible to migration channel, so the bandwidth estimated from "how many
> data we sent in the channel" can be dramatically inaccurate sometimes.
> 
> With that, the decision to switchover will be affected, by assuming that we
> may not be able to switchover at all with such a low bandwidth, but in
> reality we can.
> 
> The migration may not even converge at all with the downtime specified,
> with that wrong estimation of bandwidth, keeping iterations forever with a
> low estimation of bandwidth.
> 
> The issue is QEMU itself may not be able to avoid those uncertainties on
> measuing the real "available migration bandwidth".  At least not something
> I can think of so far.
> 
> One way to fix this is when the user is fully aware of the available
> bandwidth, then we can allow the user to help providing an accurate value.
> 
> For example, if the user has a dedicated channel of 10Gbps for migration
> for this specific VM, the user can specify this bandwidth so QEMU can
> always do the calculation based on this fact, trusting the user as long as
> specified.  It may not be the exact bandwidth when switching over (in which
> case qemu will push migration data as fast as possible), but much better
> than QEMU trying to wildly guess, especially when very wrong.
> 
> A new parameter "avail-switchover-bandwidth" is introduced just for this.
> So when the user specified this parameter, instead of trusting the
> estimated value from QEMU itself (based on the QEMUFile send speed), it
> trusts the user more by using this value to decide when to switchover,
> assuming that we'll have such bandwidth available then.
> 
> Note that specifying this value will not throttle the bandwidth for
> switchover yet, so QEMU will always use the full bandwidth possible for
> sending switchover data, assuming that should always be the most important
> way to use the network at that time.
> 
> This can resolve issues like "unconvergence migration" which is caused by
> hilarious low "migration bandwidth" detected for whatever reason.
> 
> Reported-by: Zhiyi Guo <zhguo@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

FWIW,

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  qapi/migration.json            | 11 +++++++++++
>  migration/migration.h          |  2 +-
>  migration/options.h            |  2 ++
>  migration/migration-hmp-cmds.c | 14 ++++++++++++++
>  migration/migration.c          | 24 +++++++++++++++++++++---
>  migration/options.c            | 25 +++++++++++++++++++++++++
>  migration/trace-events         |  2 +-
>  7 files changed, 75 insertions(+), 5 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index eeb1878c4f..49c36ec9c0 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -766,6 +766,16 @@
>  # @max-bandwidth: to set maximum speed for migration.  maximum speed
>  #     in bytes per second.  (Since 2.8)
>  #
> +# @avail-switchover-bandwidth: to set the available bandwidth that
> +#     migration can use during switchover phase.  NOTE!  This does not
> +#     limit the bandwidth during switchover, but only for calculations when
> +#     making decisions to switchover.  By default, this value is zero,
> +#     which means QEMU will estimate the bandwidth automatically.  This can
> +#     be set when the estimated value is not accurate, while the user is
> +#     able to guarantee such bandwidth is available when switching over.
> +#     When specified correctly, this can make the switchover decision much
> +#     more accurate.  (Since 8.2)
> +#
>  # @downtime-limit: set maximum tolerated downtime for migration.
>  #     maximum downtime in milliseconds (Since 2.8)
>  #
> @@ -856,6 +866,7 @@
>              '*tls-hostname': 'StrOrNull',
>              '*tls-authz': 'StrOrNull',
>              '*max-bandwidth': 'size',
> +            '*avail-switchover-bandwidth': 'size',
>              '*downtime-limit': 'uint64',
>              '*x-checkpoint-delay': { 'type': 'uint32',
>                                       'features': [ 'unstable' ] },
> diff --git a/migration/migration.h b/migration/migration.h
> index 6eea18db36..ce910c1db2 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -283,7 +283,7 @@ struct MigrationState {
>      /*
>       * The final stage happens when the remaining data is smaller than
>       * this threshold; it's calculated from the requested downtime and
> -     * measured bandwidth
> +     * measured bandwidth, or avail-switchover-bandwidth if specified.
>       */
>      int64_t threshold_size;
>  
> diff --git a/migration/options.h b/migration/options.h
> index 4591545c62..d78b437e82 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -83,6 +83,7 @@ typedef enum {
>      MIGRATION_PARAMETER_TLS_HOSTNAME,
>      MIGRATION_PARAMETER_TLS_AUTHZ,
>      MIGRATION_PARAMETER_MAX_BANDWIDTH,
> +    MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH,
>      MIGRATION_PARAMETER_DOWNTIME_LIMIT,
>      MIGRATION_PARAMETER_X_CHECKPOINT_DELAY,
>      MIGRATION_PARAMETER_BLOCK_INCREMENTAL,
> @@ -128,6 +129,7 @@ int migrate_decompress_threads(void);
>  uint64_t migrate_downtime_limit(void);
>  uint8_t migrate_max_cpu_throttle(void);
>  uint64_t migrate_max_bandwidth(void);
> +uint64_t migrate_avail_switchover_bandwidth(void);
>  uint64_t migrate_max_postcopy_bandwidth(void);
>  int migrate_multifd_channels(void);
>  MultiFDCompression migrate_multifd_compression(void);
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 0a35a87b7e..07a98a4636 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -327,6 +327,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
>              params->max_bandwidth);
> +        assert(params->has_avail_switchover_bandwidth);
> +        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH),
> +            params->avail_switchover_bandwidth);
>          assert(params->has_downtime_limit);
>          monitor_printf(mon, "%s: %" PRIu64 " ms\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
> @@ -577,6 +581,16 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          }
>          p->max_bandwidth = valuebw;
>          break;
> +    case MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH:
> +        p->has_avail_switchover_bandwidth = true;
> +        ret = qemu_strtosz_MiB(valuestr, NULL, &valuebw);
> +        if (ret < 0 || valuebw > INT64_MAX
> +            || (size_t)valuebw != valuebw) {
> +            error_setg(&err, "Invalid size %s", valuestr);
> +            break;
> +        }
> +        p->avail_switchover_bandwidth = valuebw;
> +        break;
>      case MIGRATION_PARAMETER_DOWNTIME_LIMIT:
>          p->has_downtime_limit = true;
>          visit_type_size(v, param, &p->downtime_limit, &err);
> diff --git a/migration/migration.c b/migration/migration.c
> index 5528acb65e..85be4f019b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2684,17 +2684,33 @@ static void migration_update_counters(MigrationState *s,
>  {
>      uint64_t transferred, transferred_pages, time_spent;
>      uint64_t current_bytes; /* bytes transferred since the beginning */
> +    uint64_t switchover_bw;
> +    /* Expected bandwidth when switching over to destination QEMU */
> +    double expected_bw_per_ms;
>      double bandwidth;
>  
>      if (current_time < s->iteration_start_time + BUFFER_DELAY) {
>          return;
>      }
>  
> +    switchover_bw = migrate_avail_switchover_bandwidth();
>      current_bytes = migration_transferred_bytes(s->to_dst_file);
>      transferred = current_bytes - s->iteration_initial_bytes;
>      time_spent = current_time - s->iteration_start_time;
>      bandwidth = (double)transferred / time_spent;
> -    s->threshold_size = bandwidth * migrate_downtime_limit();
> +
> +    if (switchover_bw) {
> +        /*
> +         * If the user specified a switchover bandwidth, let's trust the
> +         * user so that can be more accurate than what we estimated.
> +         */
> +        expected_bw_per_ms = switchover_bw / 1000;
> +    } else {
> +        /* If the user doesn't specify bandwidth, we use the estimated */
> +        expected_bw_per_ms = bandwidth;
> +    }
> +
> +    s->threshold_size = expected_bw_per_ms * migrate_downtime_limit();
>  
>      s->mbps = (((double) transferred * 8.0) /
>                 ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
> @@ -2711,7 +2727,7 @@ static void migration_update_counters(MigrationState *s,
>      if (stat64_get(&mig_stats.dirty_pages_rate) &&
>          transferred > 10000) {
>          s->expected_downtime =
> -            stat64_get(&mig_stats.dirty_bytes_last_sync) / bandwidth;
> +            stat64_get(&mig_stats.dirty_bytes_last_sync) / expected_bw_per_ms;
>      }
>  
>      migration_rate_reset(s->to_dst_file);
> @@ -2719,7 +2735,9 @@ static void migration_update_counters(MigrationState *s,
>      update_iteration_initial_status(s);
>  
>      trace_migrate_transferred(transferred, time_spent,
> -                              bandwidth, s->threshold_size);
> +                              /* Both in unit bytes/ms */
> +                              bandwidth, switchover_bw / 1000,
> +                              s->threshold_size);
>  }
>  
>  static bool migration_can_switchover(MigrationState *s)
> diff --git a/migration/options.c b/migration/options.c
> index c9b90d932d..65d0b58fa9 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -101,6 +101,7 @@ const char *MigrationParameter_string[MIGRATION_PARAMETER__MAX] = {
>      [MIGRATION_PARAMETER_TLS_HOSTNAME] = "tls-hostname",
>      [MIGRATION_PARAMETER_TLS_AUTHZ] = "tls-authz",
>      [MIGRATION_PARAMETER_MAX_BANDWIDTH] = "max-bandwidth",
> +    [MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH] = "avail-switchover-bandwidth",
>      [MIGRATION_PARAMETER_DOWNTIME_LIMIT] = "downtime-limit",
>      [MIGRATION_PARAMETER_X_CHECKPOINT_DELAY] = "x-checkpoint-delay",
>      [MIGRATION_PARAMETER_BLOCK_INCREMENTAL] = "block-incremental",
> @@ -176,6 +177,8 @@ Property migration_properties[] = {
>                        parameters.cpu_throttle_tailslow, false),
>      DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
>                        parameters.max_bandwidth, MAX_THROTTLE),
> +    DEFINE_PROP_SIZE("avail-switchover-bandwidth", MigrationState,
> +                      parameters.avail_switchover_bandwidth, 0),
>      DEFINE_PROP_UINT64("x-downtime-limit", MigrationState,
>                        parameters.downtime_limit,
>                        DEFAULT_MIGRATE_SET_DOWNTIME),
> @@ -868,6 +871,13 @@ uint64_t migrate_max_bandwidth(void)
>      return s->parameters.max_bandwidth;
>  }
>  
> +uint64_t migrate_avail_switchover_bandwidth(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->parameters.avail_switchover_bandwidth;
> +}
> +
>  uint64_t migrate_max_postcopy_bandwidth(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -1004,6 +1014,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->tls_authz = QAPI_CLONE(StrOrNull, s->parameters.tls_authz);
>      params->has_max_bandwidth = true;
>      params->max_bandwidth = s->parameters.max_bandwidth;
> +    params->has_avail_switchover_bandwidth = true;
> +    params->avail_switchover_bandwidth = s->parameters.avail_switchover_bandwidth;
>      params->has_downtime_limit = true;
>      params->downtime_limit = s->parameters.downtime_limit;
>      params->has_x_checkpoint_delay = true;
> @@ -1144,6 +1156,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>          return false;
>      }
>  
> +    if (params->has_avail_switchover_bandwidth &&
> +        (params->avail_switchover_bandwidth > SIZE_MAX)) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                   "avail_switchover_bandwidth",
> +                   "an integer in the range of 0 to "stringify(SIZE_MAX)
> +                   " bytes/second");
> +        return false;
> +    }
> +
>      if (params->has_downtime_limit &&
>          (params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> @@ -1320,6 +1341,10 @@ static void migrate_params_apply(MigrationParameters *params, Error **errp)
>          }
>      }
>  
> +    if (params->has_avail_switchover_bandwidth) {
> +        s->parameters.avail_switchover_bandwidth = params->avail_switchover_bandwidth;
> +    }
> +
>      if (params->has_downtime_limit) {
>          s->parameters.downtime_limit = params->downtime_limit;
>      }
> diff --git a/migration/trace-events b/migration/trace-events
> index 4666f19325..ebd88de3d0 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -185,7 +185,7 @@ source_return_path_thread_shut(uint32_t val) "0x%x"
>  source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
>  source_return_path_thread_switchover_acked(void) ""
>  migration_thread_low_pending(uint64_t pending) "%" PRIu64
> -migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
> +migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size %" PRId64
>  process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
>  process_incoming_migration_co_postcopy_end_main(void) ""
>  postcopy_preempt_enabled(bool value) "%d"

