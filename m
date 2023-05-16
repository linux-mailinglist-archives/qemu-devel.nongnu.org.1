Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1385B704C05
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:12:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysal-0005gE-Pi; Tue, 16 May 2023 07:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1pysai-0005fJ-SI; Tue, 16 May 2023 07:11:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1pysad-0003Yf-HG; Tue, 16 May 2023 07:11:40 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34G6TTXo003915; Tue, 16 May 2023 11:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RUKJ25HPYRwm7IH2NRWJF1hPdxtMyla7c1xABKz19G0=;
 b=EbqXFBd3InUVrVY8oYtBSUak2DxDoLu1TWes72kNeRmiVKqxSWFJqctS2L9vpQrSEcWO
 /pr6wYwhKnd+mAFqUVxEnDhLOlhlIR1PL7d+MLRS3po7pNFOpdQe7OqAsVjeoXN642I+
 nNn/v9olacEVn6RsCrxSQHeJkIKfkgHsKB1UBcOaa1HOMhIrPHDzZB7GtfAVJX9Wu77O
 nYgQ2VLzUz3GDlFitqLeSEpzK9uNxEdikJWYk8SuGZ4SI+gHWojdT+MZrltahPrJ3hCD
 jSJXZzOutfOyGw3eEI2PPDBpQq23CE/wyULR1f3x5+3uygdUvhZtrP1Ksb17P9p3xLr5 VQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2eb2c92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 11:07:46 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34G9FHEw017860; Tue, 16 May 2023 11:07:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj104d5vu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 11:07:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huLJSsMkurrE5EA7/aEaLBYn/iTOVFVyavcH2JMnkNcbstA08SZICPy9S0+mxp40iqMA+QrtwWt33HqsIuI5Q1Kc1G5EyuiytW2XLLmVY77wZ2tG19r1dqRTX3yRypKvi05xvxMY30w5PeojSPJuV1QHBZ3U65Ue1a2eIsrVHaVEWhpzo9ztlUTDFYbDSaUq470Jl9XML++HheIt4At/eN9b270jLK47v0GsAYOp5Xe/d7RvWvSHRC/1TcIK3clJ4Zm2eqXuKnunOM6Jt7gX8AnXRac6jZReA52DHJtC/mEBv4v4Vd9d8CUXefrLGp3PdOViXFn71I4aeqPmoUVW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUKJ25HPYRwm7IH2NRWJF1hPdxtMyla7c1xABKz19G0=;
 b=UxmbMlsaLnfGxILIo3cjiWu2n4x5UkDM5p4Tm41McfzWCDgnZluIipOdXeP/h/tNmrt21npASCEpIwbrDInc6YJGtIsqQWzhHafMzWv6Kt7f7zppTM4miyqEA9MzHLwKu79MuJ34C9MgWR4bb7lAlqNViwrENFxVt8DrzPomgjjy4KkGXHG8YuBTYFLBEGgYCHOHYwdJnrU2JnfHd5i6JR9k3B/FGDogSu5t7kVQwfyhIUczKRtSrxCplp8LNNjZ0qAbKCOwKTtYW72GwcFrg+TLCuAA1pTCPXenwm3v4Ix5S6WC6K1lVRDXe49v9ifbFzKoc9yZZPgiImCuCtDdDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUKJ25HPYRwm7IH2NRWJF1hPdxtMyla7c1xABKz19G0=;
 b=mRB4HZ/sQ+dg7OAX6bBWj1jgyMiyk/Y+jDANcmgdUBg65VDK9ld3rOLKlKu9MawW4D9wJ9psFWLVDUp9QSrpM++1aETe9MNZ/+FaxjVIX5b0WvVjLmwzCef1V3csnsNUrLOv+vqQZz+hRyR1FhblDa6oNZww4R/Q+cKNqgISUYs=
Received: from BN0PR10MB4918.namprd10.prod.outlook.com (2603:10b6:408:12e::9)
 by DS7PR10MB7321.namprd10.prod.outlook.com (2603:10b6:8:e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Tue, 16 May
 2023 11:07:41 +0000
Received: from BN0PR10MB4918.namprd10.prod.outlook.com
 ([fe80::6e7c:fef1:7e91:b7ab]) by BN0PR10MB4918.namprd10.prod.outlook.com
 ([fe80::6e7c:fef1:7e91:b7ab%2]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 11:07:41 +0000
From: David Edmondson <david.edmondson@oracle.com>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Greg Kurz
 <groug@kaod.org>, qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, John
 Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org, Daniel Henrique
 Barboza <danielhb413@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, David Gibson
 <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-block@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Eric Blake <eblake@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v2 03/16] migration: Move setup_time to mig_stats
In-Reply-To: <871qjgh9oq.fsf@secure.mitica>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-4-quintela@redhat.com> <m27ct84noj.fsf@oracle.com>
 <871qjgh9oq.fsf@secure.mitica>
Date: Tue, 16 May 2023 12:07:32 +0100
Message-ID: <m2zg64356z.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM4PR0902CA0016.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::26) To BN0PR10MB4918.namprd10.prod.outlook.com
 (2603:10b6:408:12e::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4918:EE_|DS7PR10MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 0903ec7d-919e-4eec-23b9-08db55fdc3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXGJafGaw1dkE2Bc3gH/RtQUnxPcb6vkX9Vb1EhtM5fyNiay2ktYpXi4iXJ0vkLMF1V58opfCfBzR+Kk4PZWsv+lTT2u5GF/34AGOjq52/ayhQ5jDuHB1ghYBeHTVXuJFtu156AgblCLH+d4IO5nbul/5k+KpxP7kBKmAjSaBZW1Nk2po97vAgrhbHGu3I0Z0xel1HtL1SUX0EjK29gQXF0Sn+PAEaGBGuKpwddSjzHrA3Dww/qK89DiSZu/wrh/NdYIo4g0NGWD4ONskkpWULuAax0m0a75erdj/2pS0TvI53W3urf4VXxzMq+ePaArF3IpSAEsLyiAzrn9NZGLVGC8aJDltYstqtjxfz/50YQc8eCpSnsHuMSBE60TcRhttho9FjSu72fGRysvo+Yvv1ATYvpwv/cGmEftN+2Gfq5UdvgBooylm5i9OwoXtNqKvLTpz17cWwIlSjdNQiW2/CL8G14TLSZyg6I77PkNv8XbpZmRnBOWfpCOeeEE9ISnhqFtUqMJ31nKEIMEbo0Z1Duw4VAf0rlvrqWAjPiT1HmuhFV8zTTNQkr8QSLDOIS0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB4918.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(86362001)(36756003)(316002)(54906003)(4326008)(6916009)(66946007)(66476007)(66556008)(478600001)(5660300002)(8676002)(8936002)(41300700001)(44832011)(7416002)(6666004)(2906002)(38100700002)(6506007)(2616005)(26005)(186003)(6512007)(83380400001)(66574015)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjNzcGRicTNROUF5TnhYa3BtNEtINFU4OHlGekczZXYxa0JMRzhudWNOWmtF?=
 =?utf-8?B?NWFmeGJ2eERUQWRhVm1hTXJxcWtSMVlZbVdFS1ZGUEpFRUZaS2RKckoyaFJL?=
 =?utf-8?B?MVZ1ci94di85dHZiRW0zWGRVWkZPMzZLUWdLbnVMQThHcDRsUUdqU2syM3dC?=
 =?utf-8?B?dnZ0aS9ienhTWExKUnNtVzVROXJ0dkVvMHlrbkkzUFg1Z0JRNUR6d1FzdkNC?=
 =?utf-8?B?ZVBBVFBBcmV6RmVmTHI3SkZUSVRRamZoQjE5VXFqb2c3Zk5aYm41L2crcmZ2?=
 =?utf-8?B?aWJDS0N0OGwxSW5jejJPcHRFdmZ1cDhZTlJ4YmkvRnBFSFA2NUR6enZXQWJx?=
 =?utf-8?B?ZjRYdTAvb3lTL0JqTUxKTGs0RW1temFtRGVtMDZoRmVJcW1SSlNjYVhDbitY?=
 =?utf-8?B?MnhGMS9ZUmdVclBTcTl3RVVObWhBZ3pvL1VZQW8yNlozVzNOOXRyZWQrTzJ5?=
 =?utf-8?B?VU5GL0xRWFlSSXJ1MW9LY3Z3UGpyemVqOEdITXErZzg2TnBWYWg5aHpYTjV2?=
 =?utf-8?B?dzZUY1hRVlBaYkhIS1Qvb2VaQ3R5dzE5bTBEUnh0MWRjRU93Q3VWcWFKaklx?=
 =?utf-8?B?cWYvQmNxM29XYVIrRlBSQ05vdmNKcExHcjNxNVRRUUhYN0V6R3lxSnFNTTVO?=
 =?utf-8?B?M1NXUlpYME5WckNBWXdUUDdSdFRYU3JuNGRqZDlIaGVnZ05Jb3RFeFNTd2I4?=
 =?utf-8?B?bVhQMlB5M0sySWZ6RXo5UzNPUWwzS1Z1V3JWdlgrbjlVUnhLTVB1amxXbGxD?=
 =?utf-8?B?MVZLNjR3RFQ2alNYQnlLckRrUklrU0tlN09QM1FSU0FWS2o4QlJzQnk0djBo?=
 =?utf-8?B?RVNLS1h2ak55K3dsOGtpOWtBZGliT0NXWGFjZlo1SWhRQW4rM0NyTkkySkYx?=
 =?utf-8?B?dW5xUDI3MUkraU9hNis1WVNiVDZKeFkrbXZTVHA5OWdnd3VqZHJGWjRxSjg4?=
 =?utf-8?B?dGVzNWJSYjh2Tm4yWVhYdHlDd1FyL3lyN1NDT2QyQ3pwaXdwK2lEWWZYZjNl?=
 =?utf-8?B?UWZwQUdhM2RPOGQ5U0ErMUtSUFhNQWp6OW1TZURjRG1XejRWSC93N1JWTXVw?=
 =?utf-8?B?VW5uYTFWdkFsWVg3bmFYQjVhaDk3SllVRFRVU2RBUEFCYU5VWXdxQlBRaXgr?=
 =?utf-8?B?N0VzQzA2NWFvUmw4TmY4NklKMG1YZldkcHFJQUp3dSs0dnN6VDlwUWtmRDJD?=
 =?utf-8?B?TGRJcVVwTURMVDNOMGtxeGZXRGRFcnU3VFF2dzJ0YVpMNjQ2QnVSWENJL3VU?=
 =?utf-8?B?TzA2ZmJGTVJwa2lkYjVuV3ppc3FMU09Xemhndkp1MTJxcU5wVHEzWnpJYVhl?=
 =?utf-8?B?SCt4anU4LzExS2xONlF1UmZmOUVkWjB6RWZpbEdWcnhzWHZkSEVUa0pnMXFh?=
 =?utf-8?B?NzJzb0NyUzM4TElkZ2trOVd1RHRnamlCNlVvSVl6YnhvWTJMTkswUmtEdTRP?=
 =?utf-8?B?UHBUaWpScnNrU1hsdWVZclNaLzhkMmVVeFVyYzEwN1VvdU43N0VWOFFlR1Rj?=
 =?utf-8?B?bCs0NUVZY1JYSDZKdmdqVkxNN1l3T3VRMXlkK1hENmR3STU2bFpXcUFBR05Z?=
 =?utf-8?B?QXNBWmxYOUtJSE1vcFNhMlNhM2xia3BZSmlha0xTRExSb1lCR010RlVKaFYz?=
 =?utf-8?B?RFo1SzVBRUtQVHdrY2QvbWtIdG1menlvU0hweE40SEtwdjI5NXcycVZsNDlH?=
 =?utf-8?B?OHJ4L01pU0JaSnZ2UTUxTFVySEt2Y2JQdTI3TTdmWGR6THE2R1dBaVhXbGcx?=
 =?utf-8?B?TkVVUUlrb1Z1WWozM3F2RkxPQkE2dE92ekpuV1dDcS8vUlJVaTdpL2RtVEpK?=
 =?utf-8?B?K3N4bGFLOEtsd3EwRXY5SENQSExKUElHNHpyU1M2NkZNa1RiNHRiSll1a1Rz?=
 =?utf-8?B?NFYyVlUvMWthT3F5MWtGTHBHc1ltdFpXR0tZVTlqRE9mKzBkeVlLbmVoWG1O?=
 =?utf-8?B?Q0prc0wwOEdLSDhSbVdwYXdYZmpHRHBXaHBMdzBFRkFKaldwRDMvaUFwTXJW?=
 =?utf-8?B?cEkyMWVqT0RPK0JBY2dkMGVvbjJtUnIyTkhpTC82YVh3WDJ2bXB6WDJIUUtw?=
 =?utf-8?B?a0Z3cmxBaHZ4dzl2Rm9BUFVwWjFhSVVJd0txL1hvZENaWDMxVGp1YVJNWWE4?=
 =?utf-8?B?eWw0VUZpR1dtYzVHYitMQ1BoQm40TkpZdHcyUlJPTGN0NVlnU1IrWFdDR3Fh?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UkFKWW9McGs3Z3NVMlVGeHZSaHZySnZzemUwMUE3Rm1Fcm96bXY3OEpuRlda?=
 =?utf-8?B?L0JIc0pQSmxoRG91TzFqcVZzRmxPYnBTS1B1OHgvRm5BTE9mYjZzOE9YeGxO?=
 =?utf-8?B?MFU2ejZhYXdZL085YlFqVStlbTZBbHRuQ3Y5dFRJMC9QeFpTR3YreDIrbmx3?=
 =?utf-8?B?eEdCSmo0MTFmcS81V2FFZU1yYnpvYk9iMU5UMitjVnFPVDgrTzk0NG4wMC9N?=
 =?utf-8?B?c2NzcE5sT2tmdlV5eGtVeVVSVzZKaEJjbWxNNXpTZElvZDlNR1h6Mi90SlJN?=
 =?utf-8?B?ZDlOTVk3KzhRdUxPUmFnUEh4eUd1dzVGQWtVVnF1NHF0emdEM0xCc1dTQW94?=
 =?utf-8?B?OWNJanNkQU0xaXgvRSs5cWpPeVQ3V2NZa1dIWHNEaEhPbENNMFVqMDRDNGR1?=
 =?utf-8?B?ZWF3S2NYd1F3U1ZmckR2aURmR05FQXdQVnRFaUs0NlZ1cHhmeHAyMUliT21y?=
 =?utf-8?B?MlFtbVlBQTlTQVZxV0RBYy9NdGhUVGZoVUFibTR1c2lJcVVGSDdqcE9nc3Uy?=
 =?utf-8?B?UDFyTkY5VTRseUVGNGxpNDAyTVo0bjhrSUZBOTBBZk90MzZMU0tWVk5WdXFv?=
 =?utf-8?B?dnVwQXYwbU1DYWpZaEpDMVVwSFVndFU2bENRQ0psS2xDVEk0bUVjRHg1L1ND?=
 =?utf-8?B?dTJYTGxOWFB1dkVteXBaa2FjTDFGS0pCYXpDZHBIdEpIUitJcUczdFgvZmVo?=
 =?utf-8?B?ZG83VnVRRy9qektRVkNSNlIrQ2tSVFpYS2QxaXR6RDRSV012WDF1UzdEaERK?=
 =?utf-8?B?Y0dRdEI3ZU5jTUkyeEtTNzFEamgwbTBxL21peXJDR3JrK3Q5V2tUcFo1RUhP?=
 =?utf-8?B?dWxxZDRXMEF5azdYanNvOGplUzJqTUhxMEFJK2M1ai9GZjMyVDdyVVdqWEZT?=
 =?utf-8?B?ZjFTREFKQ3F0aXlpOGJMWXRIcVRHYzB2QnZIOUMzQ1IzbCs2NDFzaTE2Lzls?=
 =?utf-8?B?b2V5VndaNWEwVmpUYlYzV0ZUWTBIdlE0WEducjdwUVFVbVRxQ1h0UlBjN2V4?=
 =?utf-8?B?TG9uZkRweW5QcC9EdHJZOUZwelRBNmF1WFVnb1c2OXpLNDhHVHZZblZ2ZWZR?=
 =?utf-8?B?K1BWZ2tCMXFFTzl3d0RBR3pMd1RPdlhZb0JEY0xwSmQzUWlCb1RwM3lIMytV?=
 =?utf-8?B?U0hVNklBQytRVHdXbGlZcnl0WnBlR3dIbTMzQU4zajdqSUd0SmVlalVaMDYz?=
 =?utf-8?B?SXpKUWlaV2tpUXAvSzYxaC8ySlg2Q3B3dVNkeVhCVU9KTTNua2ZJK3lveVdR?=
 =?utf-8?B?anljS25ZK2dMMllNWkZ6aXNmU0VucEt3b3E5RVBiSTlLTW1jcGpMdjdjWkhq?=
 =?utf-8?B?OEFSOUJlaXEybjQ0V2JmcHBBbENQZVBHUy9od2N4ZzNYNHdXUHRHeFU5K1lQ?=
 =?utf-8?B?TEpleDRlY3FCVkE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0903ec7d-919e-4eec-23b9-08db55fdc3d7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4918.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 11:07:40.7031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mRZG0lqbDx/aqzQv/mRmwfoBgoX2L+6nhPxiHICy+WmE6THwJG3MAXtsO6JixSN/y/KI5s0RO7kXxKXD8sTtgj0ttkOGxGQDoaH6DiB01M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_04,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160094
X-Proofpoint-GUID: RcLs5Cm_uumrSwQlY-fenUrQfv99DQ4s
X-Proofpoint-ORIG-GUID: RcLs5Cm_uumrSwQlY-fenUrQfv99DQ4s
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=david.edmondson@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Juan Quintela <quintela@redhat.com> writes:

> David Edmondson <david.edmondson@oracle.com> wrote:
>> Juan Quintela <quintela@redhat.com> writes:
>>
>>> It is a time that needs to be cleaned each time cancel migration.
>>> Once there create migration_time_since() to calculate how time since a
>>> time in the past.
>>>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>
>>> ---
>>>
>>> Rename to migration_time_since (c=C3=A9dric)
>>> ---
>>>  migration/migration-stats.h | 13 +++++++++++++
>>>  migration/migration.h       |  1 -
>>>  migration/migration-stats.c |  7 +++++++
>>>  migration/migration.c       |  9 ++++-----
>>>  4 files changed, 24 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
>>> index e782f1b0df..21402af9e4 100644
>>> --- a/migration/migration-stats.h
>>> +++ b/migration/migration-stats.h
>>> @@ -75,6 +75,10 @@ typedef struct {
>>>       * Number of bytes sent during precopy stage.
>>>       */
>>>      Stat64 precopy_bytes;
>>> +    /*
>>> +     * How long has the setup stage took.
>>> +     */
>>> +    Stat64 setup_time;
>>
>> Is this really a Stat64? It doesn't appear to need the atomic update
>> feature.
>
> What this whole Migration Atomic Counters series try to do is that
> everything becomes atomic and then we can use everything everywhere.
>
> Before this series we had (I am simplifying here):
>
> - transferred, precopy_bytes, postcopy_bytes, downtime_bytes -> atomic,
>   you can use it anywhere
>
> - qemu_file transferred -> you can only use it from the main migration
>   thread
>
> - qemu_file rate_limit -> you can only use it from the main migration
>   thread
>
> And we had to update the three counters in every place that we did a
> write wehad to update all of them.
>
> You can see the contorsions that we go to to update the rate_limit and
> the qemu_file transferred fields.
>
> After the series (you need to get what it is already on the tree, this
> series, QEMUFileHooks cleanup, and another serie on my tree waiting for
> this to be commited), you got three counters:
>
> - qemu_file: atomic, everytime we do a qemu_file write we update it
> - multifd_bytes: atomic, everytime that we do a write in a multifd
>   channel, we update it.
> - rdma_bytes: atomic, everytime we do a write through RDMA we update it.
>
> And that is it.
>
> Both rate_limit and transferred are derived from these three counters:
>
> - at any point in time migration_transferred_bytes() returns the amount
>   of bytes written since the start of the migration:
>      qemu_file_bytes + multifd_bytes + rdma_bytes.
>
> - transferred on this period:
>        at_start_of_period =3D migration_transferred_bytes().
>        trasferred_in_this_period =3D migration_transferred_bytes() - at_s=
tart_of_period;
>
> - Similar for precopy_bytes, postcopy_bytes and downtime_bytes.  When we
>   move from one stage to the next, we store what is the value of the
>   previous stage.
>
> The counters that we use to calculate the rate limit are updated around
> 10 times per second (can be a bit bigger at the end of periods,
> iterations, ...)  So performance is not extra critical.
>
> But as we have way less atomic operations (really one per real write),
> we don't really care a lot if we do some atomic operations when a normal
> operation will do.
>
> I.e. I think we have two options:
>
> - have the remaining counters that are only used in the main migration
>   thread not be atomic.  Document them and remember to do the correct
>   thing everytime we use it.  If we need to use it in another thread,
>   just change it to atomic.
>
> - Make all counters atomic. No need to document anything.  And you can
>   call any operation/counter/... in migration-stats.c from anywhere.
>
> I think that the second option is better.  But I can hear reasons from
> people that think that the 1st one is better.

For the counters, no argument - making them all atomic seems like the
right way forward.

start_time isn't a counter, and isn't manipulated at multiple points in
the code by different actors.

I don't hate it being a Stat64, it just seems odd when the other 'time'
related variables are not.

> Comments?
>
> Later, Juan.
--=20
You can't hide from the flipside.

