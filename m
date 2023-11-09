Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 018DC7E6AE7
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:04:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r14hD-0002mZ-SF; Thu, 09 Nov 2023 08:03:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1r14h8-0002mN-Rd
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 08:03:38 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1r14h4-0008HG-W0
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 08:03:38 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A91hp48020070; Thu, 9 Nov 2023 13:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gCVY5/wPws6csXCgDjOUZoq4QE8SlMK3Zz9VB+F4un8=;
 b=ZStpV2Y5UsBordc4ld3/tP9aWxN47XSH8AkvZ/rWsAHF0o4rvEnKKh13Sd8NnkEakdko
 UfCK8c/patqS19d3gvR0sqk1A8VVg/gGmoo9aNZbWhOc9hO8rNSxhuDPvcnI9yCkXM0f
 a6qFyDak4CGtqueX7fCXXPCfc1Q/WVpinVjWv35B7cL8BY6eW9ZbyI2wB8HFek8gzIy+
 fiDKvm1Ndf+z67k+G0yFUBCw806k3b9JTh+ZizLYdHHTxui0xn6IQloMZR+vfbSBMcQi
 dujwjOc+ZLzW7Zp7kbXhYOojF1/3exkyndSXzB4yjXdt8MuFhEA1WP/YAmUacRB+EY1U UQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w203vtk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Nov 2023 13:03:30 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A9BdAtd017648; Thu, 9 Nov 2023 13:03:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u8c00be2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Nov 2023 13:03:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Evi5shJJoyFjUu3gZUEU76kt8EaYNQ9Z2L1nfHd9SVM3sP9naHVOxcg+vQ5Pqe2dgp/LnL9NveTwdZkKL4B/IydiqlAjlCwOm49EhDd1/halC3Rk6NV/gDJToH72tyyawIwMJLAju0YZ4mIIHgawxqN2GH+w284OyS2KZDeHRFBvg9ELR5oAwg8ByOEMHzM+xnuct9ThK1qQs04o7+dHTw2+RGJKnolgKebyg125vBh3dYmotEe6Nxhx4YVazOdPJ24VQAvjS9U0+J3H1RK8xdLJjFEKKyvjEOWo8pwIwKFItvKgsWWup6E51xAoY5VT80HSmByM+VnI5MjTRQ60mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCVY5/wPws6csXCgDjOUZoq4QE8SlMK3Zz9VB+F4un8=;
 b=RyMeQZNO5Xwp3E3sDDiecFp0KM+9B0KPMs25Bh2+VDUFh4zmDOoB+QKFjZeiOAAtUtmHdw/o3506P5xXaKmNCZEGSpiONHj+T3/4ORJaM1LKW+78Nm0tW3Guq/cA1TT4g1D6czTrNQwrfLYxv+E41KAZBO5BUfrDQL1EyPDHVggYjRfWJVo0372Y3Crhmm0lB4NEeR+66/im4Q3bYExq8sMS1STGrIu8jx2VFtk03SqaNgucPZSmhkhQdFZHLGRBpv+JJEBilARMaHb4YWlycruvGXpipeP9V1DLkpZ4Zkzp6eP3gv3bQvoPNfJoDkic6pyIROHxQn/HUjRhwOnNSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCVY5/wPws6csXCgDjOUZoq4QE8SlMK3Zz9VB+F4un8=;
 b=Es73zkUU3StYDPDDI+l4aB+ghXHTQAIEVyU2bViDcylVHJ2WXUPWZ2yDOpIUBInlEtabNvuwB1wwJL5fF/nHwgCWsApmKluEMz1S/TqCt4LryHqa9QgNZyB7dWwFr7bikVvZI5qcyO6W9c1UllVcuVvkm18h6R2Q9HsUDBkxLyY=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by LV8PR10MB7798.namprd10.prod.outlook.com (2603:10b6:408:1f7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 13:03:08 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 13:03:08 +0000
Message-ID: <d7475721-2388-4b9c-a47f-1891e82a635e@oracle.com>
Date: Thu, 9 Nov 2023 13:03:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-29-zhenzhong.duan@intel.com>
 <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
 <SJ0PR11MB6744D87FD3CBB3380647E68792A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231108124817.GS4488@nvidia.com>
 <b6f22a3a-84cc-44ab-947b-b7e12656fe87@oracle.com>
 <20231109125700.GZ4488@nvidia.com>
 <592a04c2-0b4e-4bb2-80e4-f4c2dfacf00c@oracle.com>
In-Reply-To: <592a04c2-0b4e-4bb2-80e4-f4c2dfacf00c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0043.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::17) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|LV8PR10MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: f2573105-a760-4d1d-994f-08dbe1243824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+7pAx1ZoAq+5QCUBaHQnvfxp9kPFq066YOG4+Pwxc6qUjErl49dJsYKD9gp/cLyYOeFOWSjfIX1hVyD+9/NM+J5vBVH+f+VVzMsCNV0Yu/E+JMW2fSMDMOm1w2+JYB3rX7N4q0hXW+cX7b9zheEnKmz8Eo/LFxpphdpwARta293biG5BEl43ERytdWqom3Zbaco27mJtvODcja6KQXIFFmyV4h3q160+9sOK5I7nVHk+f17qSiASCExOeaZi5BoRjleCgxTcbp+6OSsOvPyR9RGwvSgcDE3YPJChWrDayc8DBkE7dJrOUkf5M7yetCqjlQ6+eu349pSJV1hizb9vSUBzZYgTVIFToKmlIjyg4obpSrCY872RD5kHDysZLMWDh7B1Z/ek6qjqwSpByPrihuBmmhsCOgP5BKGpzeMHC8mTJVzaSjCf4GNMjBHIZ6PEGgAtWsfjwUYcwEhyuEkg1VbyZmDrLTALLNhyI4+c8ddcIZBf08dDb3noZKOgnonxb2JA3JfUrnxWJ+obRdEmluCyE/upAQO0K6QfKPWv+NVgFMdgzUoPPwGocdvcjOcXUDr2lvEISEUIzFAXQgctvFOkeA7aYQL47+Fppbjh6pSCThRjiku58mmCrdU2oPe86knnkMMune7wBMVE4Wt/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(83380400001)(53546011)(6512007)(6666004)(26005)(6506007)(2616005)(6916009)(478600001)(316002)(66556008)(4326008)(8936002)(8676002)(38100700002)(36756003)(2906002)(66946007)(41300700001)(86362001)(66476007)(5660300002)(7416002)(31696002)(31686004)(54906003)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUxKZVBPSGZQV0IyVDZlK29NbkRNZHpsQXYvbjZlWVc3RkJmWU1VUnByVnR5?=
 =?utf-8?B?Ukl0eUxhaUZNMHU5YmZJYTl0R2dVQ25qNEh1Y3k1SXJ1KzJLREczckdPTE1q?=
 =?utf-8?B?WDkzeU54bFhVQ0tnWVdDeW5jakdETENHTU9ZNW0zNGc2WG1ydEhTUWZON1c1?=
 =?utf-8?B?dGcrUWxENGRhRXFNRFdWM01obi9hU0tKNmFWNm5xRmkwZEh6VCtaeEQ0bFNa?=
 =?utf-8?B?b3dabWtNQm1wVEphejNzN1JBbWRWekw4NEp3RmlCTE5MOWlwL1Z3RFFxZk9h?=
 =?utf-8?B?MVdsQnpYVEVUVXZZWC8yeElpNE1Wc2RUK0crMEFMZSswSzc5QTRzR3NHcVV6?=
 =?utf-8?B?RER1eTIrODh6T1hXN2g4U09hR29jWHFBZ1c3dDhyOEVJWmVsNzl5RWNycTRx?=
 =?utf-8?B?S2xsdkFsdEVXY2Zsc2swbjVobVg4MW9KME0rdUxYVU93NENweGU4eURNcHFj?=
 =?utf-8?B?NXF4STMrNzhQUEp1U0RvWDltMGhPTHFCM0J0SHdXYVlUSHR5NXVaSE1YcWdS?=
 =?utf-8?B?VnhBTTM4RGhpdlUzVkdZZDRBak0vYnNCTkV2Y0dUMGRvdHo2QUxrN2hieWJj?=
 =?utf-8?B?clg5S3NzV045SEhWTU1rdkVpdHRFVGI2K0RwaUJXYXF4bGhwdUtENHdUQVVH?=
 =?utf-8?B?NmtGOS9CWWs1M1hmU082cHA5d091MnJXamVqV0VKRFBraDFQYXJXN1BLVmVp?=
 =?utf-8?B?bk5ZMHVlZ3ZMUGNWdzdYcjlBV0NOMHRVNmxxN3o0ak85MHNHVGhPYTZwZUJN?=
 =?utf-8?B?bnVacTd2TG04S0hETXZWWXRWZUEvc3h6elNzU1ZtSGVwRENvWnZSekRncHhF?=
 =?utf-8?B?aUY4bkkxZmxSSk53ajE4WVErczBYWHVSWmdvaVAzaTM5bmR2NzZSWmFxMk0z?=
 =?utf-8?B?N1I1Q3VrcW1iS2ZBQm55RkZOYzVYa0dKQkkveHVpb0Z3V2RoL0RYWGFTYVdo?=
 =?utf-8?B?ditCdEJSbU55YWc1MVF5end0N3JwbU56RzkwdVZ0VlVYeHRxWUFaMWluQWhz?=
 =?utf-8?B?Qm1rOGkvTlY1NkxEc0RKanMxSTdtUWlDbmZYVkFCMmt6QzlrTno2TVBUT0ZX?=
 =?utf-8?B?YTNsQmJYb29JZkMrcllqS2s3NkxVdFB2dkVRWFhTYmdIRVE3NDM3Z2h0VU8v?=
 =?utf-8?B?VzRGSUVqakpPdU8wam1BaDdmRDVEOVhPUnd5dDJSeFJhREIwUm8yV214Ykwz?=
 =?utf-8?B?elN6NzQ3NTZ2Qi8vNkFZRk5kbGNjcXZ1dUdGL2NJR1N6RVF4Zlk0MTdwZm1w?=
 =?utf-8?B?Y0tCZGJQdkhLb05oSmhiRzBVUTlBTUltcFNCd3JNdVB6Z3N6SXFic1ZrenAx?=
 =?utf-8?B?Ty92K2c2RnBGWGltVzJ4ZE1BaEpkYzJia0VwbU5MRis0RTM5Q0Q3WXVmT0ZW?=
 =?utf-8?B?dDdUM3dOVmJzRWdvWFdHenl2Uk1WV1FiZ2ZNRHE1VTRWL1dYdTZQeVJlYlU4?=
 =?utf-8?B?ZFJjKzNPRlg0ZUIxZjJpckJRazdZT3Q0azBKdEY2Y0taU0hieFVrelltSDBY?=
 =?utf-8?B?VXRlSGEza1c1aWxpeGxOUU9tUkFmNnNJOWt5UytmOGorMWNOK3VXTVgrdnNX?=
 =?utf-8?B?eWRtY2VKSE1VaWZ5NFpiOXdRY0JmbkNKMEo0ajFRM3pPZ2dFV1hJQUt4Q1hJ?=
 =?utf-8?B?U05Cb1NFMGhTTTAwR1dkdjNBNUsvdmlORFJERmE2a29GNjU2UWVTUWxMajFv?=
 =?utf-8?B?bUtncXVPQVNMRjNqdWZqc1kxSWNaL1FPRHRyN0c1dkxWckx5VnMzaU4xOHI5?=
 =?utf-8?B?OWxzUWIvL0FyNjRiV2pFZDFSRXdpWS8veGtVL2psMncwK3c2QzBhYlJDQ2FZ?=
 =?utf-8?B?S2pGR2dlamVVRTV2aE5DTSs1OGtYWEJoMXVTUnVYUFpsUjlMRS9qZjVBK3Ns?=
 =?utf-8?B?S2lUbDZiQ3JOdmRucHhsaGNoS2dKVWkveGZpdDNRMU9venRFcS8veThGc3Qx?=
 =?utf-8?B?b0pncGMxZ29GQlVpVy9uTVptUnJ0eVRNN0tnZDJBRGpKUUQ5NS9UeUJicmhG?=
 =?utf-8?B?cnBxbFM2YzBWTUFZbWxQekdrV3U3MUNiSFYvTExxMStNUVk3a0VsRFJhTEtW?=
 =?utf-8?B?NmdXUndKT0lqWGVndTJuNlBvT0N5cmR0N2RGYWZNTy9IT3NyRlJyc0JJSlYw?=
 =?utf-8?B?a3Jtb2tGTThFSzFpTThJMjJ0L1A5NFhNSmpGcXNxQVBNYk9MOWZjNEJ6dDZi?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8iryKjmvmIua7fOy8nbzRQl+ht6tX7B/89puF+7xxyesnVAdSv4tACwmBQHpFiGEewRZZsFU382a80y2nCa0341mlR479KlCav+dGk0aQWBGoYRdqlJd3bXVtMrXOCZKAyJyu8yRC/ktX0A9PCzkmY/fWyg7dI3SGxWaer6eabI1Ld3r5fnFS/AzyIcTs4Ya8XGnMeV4GXh8dAE89+vj6wINkYyy1DbgDQOXV079uzNbGMIwSzahfKKGPQKjXbsYvyFiB74ggB6EDXVpD1W9nA8uoIxyYdD6lkar/kJGSSxPw1zvM8gX4Pnfdtu3RatWn68cF5/6mLEpa+KBXuga2qb+is+/MlX56FwmRniKFj70SIFOdZ6KOC0W2IZP2EgKr+95PRTNSJVP+zjVGjhbERJvRIVg9ThyBUy8A23gg12JgxUJ8B0GZo5z9qXm/+BSgJUFY3/a78MUvo5ZNmxZy2iIa0/Ae/R7Figa5H/G4dLRDAktxeDrv4jLuMmiQoUh8Iz7aiuZgCtwBaGSIFICw1ZCritz5YPpX8izuT7r+MJ3NHjhDDa/J9YU3bv+TPnkVqMNs05oBQl1xAuun4mRaKd9XINwyoBAsIpp/EXtVCpL7wGn0Imkb8K7T2TI9mS6k6nmf6CshhPaGwF6ywBey/hi4OlgBvco/5wqRoA6vV4x/KDbD1qzq4nqaffnLwvtlz4HQasnWRuNarQ4j8vciWE7zFr3IMx/HWOIZcOeDW5J/I2eUqLUV2615MLvjXm7M+4d+W0EWdmM5lar4o4XGfeZ5buyVfbDYprg3NZUEZNWbLT5hRjDMDLATXKkMy3xtXIq9cpXKBQakm0r00UIGcOF4jyoEDo1WLDSGytH1XdlIIw/hWalqdIZQCh0c3l9
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2573105-a760-4d1d-994f-08dbe1243824
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 13:03:08.1677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHbbv9zNYmBSN8wPXfgRsXCQ9Bc9pA1XFPnrwhsZ01gPomOIH7tbzWC0AQl0p7zj3/9lXaqqo93sKEYMkiX39zcDdJeqsntuvQK9O4eQgvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090098
X-Proofpoint-ORIG-GUID: X_lAuu5hqTL2k0bqQisJfC33IFdnsk-j
X-Proofpoint-GUID: X_lAuu5hqTL2k0bqQisJfC33IFdnsk-j
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

On 09/11/2023 12:59, Joao Martins wrote:
> On 09/11/2023 12:57, Jason Gunthorpe wrote:
>> On Thu, Nov 09, 2023 at 12:17:35PM +0000, Joao Martins wrote:
>>> On 08/11/2023 12:48, Jason Gunthorpe wrote:
>>>> On Wed, Nov 08, 2023 at 07:16:52AM +0000, Duan, Zhenzhong wrote:
>>>>
>>>>>>> +    ret = iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>>>>>> +                                     container->ioas_id, &hwpt_id);
>>>>>>> +
>>>>>>> +    if (ret) {
>>>>>>> +        error_setg_errno(errp, errno, "error alloc shadow hwpt");
>>>>>>> +        return ret;
>>>>>>> +    }
>>>>>>
>>>>>> The above alloc_hwpt fails for mdevs (at least, it fails for me attempting to use
>>>>>> iommufd backend with vfio-ccw and vfio-ap on s390).  The ioctl is failing in the
>>>>>> kernel because it can't find an IOMMUFD_OBJ_DEVICE.
>>>>>>
>>>>>> AFAIU that's because the mdevs are meant to instead use kernel access via
>>>>>> vfio_iommufd_emulated_attach_ioas, not hwpt.  That's how mdevs behave when
>>>>>> looking at the kernel vfio compat container.
>>>>>>
>>>>>> As a test, I was able to get vfio-ccw and vfio-ap working using the iommufd
>>>>>> backend by just skipping this alloc_hwpt above and instead passing container-
>>>>>>> ioas_id into the iommufd_cdev_attach_hwpt below.  That triggers the
>>>>>> vfio_iommufd_emulated_attach_ioas call in the kernel.
>>>>>
>>>>> Thanks for help test and investigation.
>>>>> I was only focusing on real device and missed the mdev particularity, sorry.
>>>>> You are right, there is no hwpt support for mdev, not even an emulated hwpt.
>>>>> I'll digging into this and see how to distinguish mdev with real device in
>>>>> this low level function.
>>>>
>>>> I was expecting that hwpt manipulation would be done exclusively
>>>> inside the device-specific vIOMMU userspace driver. Generic code paths
>>>> that don't have that knowledge should use the IOAS for everything
>>>
>>> I am probably late into noticing this given Zhenzhong v5; but arent' we
>>> forgetting the enforcing of dirty tracking in HWPT is done /via/
>>> ALLOC_HWPT ?
>>
>> The underlying viommu driver supporting mdev cannot support dirty
>> tracking via the hwpt flag, so it doesn't matter.
>>
>> The entire point is that a mdev doesn't have a hwpt or any of the hwpt
>> linked features including dirty tracking.
> 
> I am not talking about mdevs; but rather the regular (non mdev) case not being
> able to use dirty tracking with autodomains hwpt allocation.

... without any vIOMMU.

