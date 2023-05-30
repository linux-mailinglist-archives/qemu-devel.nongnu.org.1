Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCEC7162B4
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:54:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3znn-0005OJ-Th; Tue, 30 May 2023 09:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q3znk-0005NE-Jt
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:54:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q3znf-0001n6-KX
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:54:14 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UDOH2Y009085; Tue, 30 May 2023 13:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ydkk4a8dZlB3iAq+HFT/VBRAZjiqzILEbWQcsbgf+zA=;
 b=i2Aq7KsH8S0vhbEcS6lUtmInMzjWBGjelmoUOhXLkhlvE/0ixufE7MljQNGPxdri6Mr7
 /TkiHY04ntmyugEsxGLLz27dXxaKdSjeEXuXB7VYBhIB0IbLV0b6tJfNb5PXXVC4jaBj
 /WJrNTfxbviWw2KFlGGEzteiz7IZ1WLgOpeKq0Rze58gWMBg83fEKzbHnzediMSauD35
 I5I2koiJY7IOGJ1d6SEXG6ufV/vpi5bNfe6hZhb/jyWSUZ/Z6eHC+p05912IkeoDR2TM
 AmUXGw1b1bI6V3nBqai5tM26SB4Jw9Ry78iDezzzWm0NKzapPKgSx1QIwgsF7M3d3pX7 bw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhj4trt9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 13:53:53 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34UCwC3V019713; Tue, 30 May 2023 13:53:52 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a44hc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 13:53:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BI4Iu3pnUC9YVMYyW1G7tKzl5Nr/sTgmq+/DwyjCRafAfU7X+UhfMR+kOApvLOsRnFa28DYnXmRAUOTiBZy1ySO1Zx8e+6uekkAvHC4VojpcCaK2HfJtIWLuwjq25lR/aP0/xFlqIz1m9dOFegs9nt2+zDBP0oT5J3rNvKqzDBjbPoZBNYYv9fmM+qlyxUP4tJ2+nmkgwxYdweqtCThsSTU46cB8fbPHq/t1a+4sfKq6/XpunsAA++OAluTe40p1o2UGnef/R+EJtzeJk1qqOwmgK2sEQxRxxIn7BakkIqJyMFzf/ais4yTZ/QFE+Ti0bEI+zb3hGN9WUASlwUpM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ydkk4a8dZlB3iAq+HFT/VBRAZjiqzILEbWQcsbgf+zA=;
 b=h1kIgUlwvxtj7SPdIDukWxL743x87rbBs+uoy0mnOTmE8jDirXlfmKKOp3Ivc700zSBArp9wM4wBTLZ7IWYlGejlU1vb+JGyA0rtQWpX3ZTRFbT906La5LApJtUUFAgYfimHAGoUjbEaDmXMPCkKtXQJ0cVUaf1P3AC2nOS2BvKfmv4xEQ5lURbv2wT/7ErKsjB1t845qtnOqBMj5gG335HCpzRrB9GztuSeCiw0hf7aPxYF/v0sXarm3yQdIB7tFKwp7UES6ZIdXPqIxGqq3SOeBHwaBlSB8rpLvhswjKR6eGwuo3eoRxfp65lROSyINSiEW6U0Ld5UPpTgapaGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ydkk4a8dZlB3iAq+HFT/VBRAZjiqzILEbWQcsbgf+zA=;
 b=kJ8fg6B0dxFZfxFoUuit9HU05Df4Q5yf2bJ06CcKMss8icQw2PbMWghVS0XstWMISuUnuhrdX4CoULqiIptJd0hqGMVH6BxqPTZEK0O9gaX7dl/5A5L/EF1WBRaxKOAvOsaZvpYtNOsK5ndCGv9S/N4Sj0oDdCUAi/OiMeI8Awo=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA1PR10MB7661.namprd10.prod.outlook.com (2603:10b6:806:386::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 13:53:49 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::7361:8416:8d4c:7733]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::7361:8416:8d4c:7733%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:53:49 +0000
Message-ID: <479d7245-3626-8c89-658c-3a4f99900f9d@oracle.com>
Date: Tue, 30 May 2023 09:53:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V9 00/46] Live Update
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Jason Zeng <jason.zeng@linux.intel.com>, Zheng Chuan
 <zhengchuan@huawei.com>,
 Mark Kanda <mark.kanda@oracle.com>, Guoyi Tu <tugy@chinatelecom.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 David Hildenbrand <david@redhat.com>, John Snow <jsnow@redhat.com>,
 Peng Liang <tcx4c70@gmail.com>
References: <1658851843-236870-1-git-send-email-steven.sistare@oracle.com>
 <53075574-9e73-f773-ccb1-cca42a719801@oracle.com>
 <d0a2df99-5935-9b06-cc42-fd93488b59f5@oracle.com>
 <bd4c064c-39f9-cde2-d392-dff01c404080@linaro.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <bd4c064c-39f9-cde2-d392-dff01c404080@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0059.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::17) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA1PR10MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b6caea-77f3-410c-e654-08db61154b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/P+2uDQHDc+5pLYt1o8+o2esG/sAgJmIeJ4XJme4pekM2LpXtKP4tVHeAHpjcxUUm1V9yuFE7RXO5lu4E70EtynoFR+JIrsuBTOjs5AOHxrl6ao+Xpb9OKFE+tvANcpwYa82Om0CizUey/pv+BbtBoKo7Hzk6BDGqYjB1nIUqOclZhg9lYLCBIzxIc1J0MtBHeSmCv9uVou90bEpurSHaG8AMp0dj8D6h0MYIoV+mY2Kz5K5EgA0ZENv6EvtDY+ktTFDS3KJ7JfRotRcWIJf3B66T3eIIG357HUgmVKRTwMmt28J3qdtG1ueyMv/s8kkv6ws8hKcxiRCbn3ApQ3JcRPUR5/u7d5UX/CS7NlB9R/g0arc9J0jRM8VOGRcfriIJwXs/watjJw8N5i1vUHbsTHl71yF6WCXgDVoegnQHTxzDRaODd4DGQJW15mFmT9B6VL48BoKBBKt3lek4/zD8rQcLbldxGUnY03muBlsUdRj8b3s84u5JCF16Qoh5qhN9y1UoZ5Tvs+yajB33BsnPhnZSi+J+oN5Z5SZNERr3q6HBODa1lJoWcl159tZlPKa70KzBj629kKbr8osTkpoaS2ZHGmP9TKQkvfi0b0xgy0LLFIaujPulhBzYY6V25JpYKhZIT69OEb8IKyJ4rhlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(478600001)(83380400001)(5660300002)(186003)(6916009)(4326008)(86362001)(8676002)(6486002)(2906002)(8936002)(15650500001)(36916002)(41300700001)(316002)(31686004)(38100700002)(31696002)(6512007)(6666004)(6506007)(44832011)(26005)(66946007)(7416002)(2616005)(54906003)(53546011)(66556008)(66476007)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEZheU1Yamh2a0k3STZuYTdhZWhvTDBwTDU0N2NzMGF4QU95S1V2dmtxc2ln?=
 =?utf-8?B?MERCbG9VQkdWU3l2WldtKzFwZWJPUnBqSGRpck54VHl3TmtMOEY3aDdmUW1h?=
 =?utf-8?B?Ujh2OGU5SHZlVGRpYk51M1Zad29iR01kQ2hnMENPL2FZUk93TkgzQlZlYXR2?=
 =?utf-8?B?Q1BYcGVORUhnVUVWeHJ0eDFydzdJejc1S2o5SGhCcWg1WjlpMFptdVdjTElu?=
 =?utf-8?B?M3EzV1pPanFMYVZwQ1YxbWdxSzdDL3diOU92SkdHcy9GTW5jUGdpRXBKZWht?=
 =?utf-8?B?U0hBekJ2aTNiRkJDSDIrQ2k3d3pxR3J6MityNFVHUGJwMUMvMDgyMlRLank4?=
 =?utf-8?B?NVA1WUp1bklYUmVQS0pGN1BCSlZDUERoSjRsM3hOVkhkaWxKZGNqTlVFaHdP?=
 =?utf-8?B?R0lEakdGeGZ3WXRrVGV5aW1pRExWSU16U1dKOUJ5ZUp6SWxNRyt3cXY2TUFF?=
 =?utf-8?B?YmdQREtubGsrK0hGd0kyMmRtNUZGdmhhK2dkWlhuVDZFd0ZBMm5hKzVzbGVl?=
 =?utf-8?B?b3k3SXJtWnJTZlN2Y2F3Mkc3eTRsM1lSR2VnY2ZXZ3Faams5d01XcFZtUkhR?=
 =?utf-8?B?K2dPc09HdlJHQkJDMmdGNCtCYW5CbmFCN04zYVJGTHRuZUVSTVEzVExodC9y?=
 =?utf-8?B?SnhkeEpUT0tVM3N3aEFPbVFiVTBJWEp4YnZjdlF0UVlzMkxlcmkzQ2FXNm5v?=
 =?utf-8?B?b25ZTzcwUTdIMWlhU09VOXc1dkMwTitKZDV4RzlLZWRVcXdZUnBKTXpPWHFy?=
 =?utf-8?B?bGtUcktBMy9rOWV5ZEhXc0w2b3BKSkhETHZwVWJhMmZQL0k0QzBOUEFMbkMw?=
 =?utf-8?B?UVFzYWlDV0kreFg2YkI0M0toWHFra2hTdENyNGdza2EvdUwrSTEyNUJHU3RU?=
 =?utf-8?B?QWtFdmxFREtNSmI4WTJSKzFWdmFSV1lxTEZjQ1NZVTBBOExBSlFvZVZtRC9h?=
 =?utf-8?B?Q3lFMWp1aHFLZG50RlRIUFY2Z1FjSnc1VFhBUnZiTWRLVTJCWjB1K2FxOEdp?=
 =?utf-8?B?R0Y5UEc2Y2NZR2UraDBzRVJpcUM5aG1QR0dBT241dnNsTnNuUE5uVitHNi9j?=
 =?utf-8?B?cjFtQm1Fa2szWWhLSlVhaE1PU3JaaEM0RkJJaDFOQUVQY01ZNjNWV0pIc2dV?=
 =?utf-8?B?YTlVamtOazE4blAyc2p0MTFtNWtta1d0NEljZGhNbm53KzVkdDUraXM5YW1y?=
 =?utf-8?B?M2R6TnZCZnhKeEZlQlpJdUE3bFdGOFdTZmp0M0g0YmUyMm1rSElIQ0dOOHZK?=
 =?utf-8?B?a01BZmRlVDNwcnprUnBySUlOMTRXZlhmVFlGT1E1QVBxalVjNTJ1andSM3NP?=
 =?utf-8?B?UEN6UTlkS0NZOWdpcEEzbFhrZlptazd5Z0FCdlJhZkpEZ3NmcE5CcWU1YkRC?=
 =?utf-8?B?NFhYbEwyUDJpRVVjek8zWWlrdWpaNDVLNWl2RkhSLzh2QzQ5WlNLUTFzbitZ?=
 =?utf-8?B?MHZrY1FpN3ZkTzNQYXVhalF4TitCZGVRN1pWaTZuZVFmVUlDc1hxY3BxQllF?=
 =?utf-8?B?TGtuYjNPNzlqNzJyZXNqeFRjNjQzNzBiTCtHTDQ5L3dtMjFpekdrK3hWVDdF?=
 =?utf-8?B?R0l4aHRoejJLODBwRlc3SFgrOFVMZmFzeHpXSjl5eGZDbHBhYTJsNFJMY0M5?=
 =?utf-8?B?MW5wVnF6VUlhN3hVWXZkamhndmFSRncrVEowMitlc2Rrcy9WQ0ZISS9MYWNX?=
 =?utf-8?B?WUJSTXRxTXB0N1FvVkNFT2FmRFhDZ01aRFlzK20zMDZkaThEVGdkU2IzRCty?=
 =?utf-8?B?ajk4dXBlWURJQUhLUTU3QnlCYndIWnpCUnZMRkFHd1dIaDArbTQyTllaR3Rj?=
 =?utf-8?B?aEpPSTJMYnB0L2VTSHZVMzg2MFBWTFloRXZFUEJWYjA2MmtaaHNDaUVvTlBN?=
 =?utf-8?B?L2VRdUdaeGx1dTBsaTRpaU1vNHVEUVFxQ1EvdjYvQkc1MnYzdy9EQ2tjYm5o?=
 =?utf-8?B?U2N0cURyeGFNSWhlcUlYWVNEL2xYWC9CRUpodU9DT01TSDVJa1RzbXljQ0Fp?=
 =?utf-8?B?QkJVSUdrdGF6UmlrQjdYODRoVUM5dFVrYW9PZm94Z3ptc1BoKzJaVUl5cVJn?=
 =?utf-8?B?UDFwYTY4aGVZZFhFWDlMSEVDMHY5NGEvQ1duaWcvVkI5RnZFSlFxTWQraE01?=
 =?utf-8?B?RHp5MS9YYlk5Sm9FUGJrRGE1Y3BLZWRWSm5nQXNoZCtabnhsc0pmNVhQUUVB?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Njc5M3RCaXNKMDU2endGMUxLeDRkNDJFZkw4Tms1U1ZPclB3ZzJjV2hKNlVt?=
 =?utf-8?B?T0hyLzVIN3pGT1JmTnhHQlZuSjZ4OVBiOTY1N3pPcThteTJCa05nYzZJVVRr?=
 =?utf-8?B?S3BtZlJKSDd6TGNmT0s4d2cxRXZlclFKNHZZSlJ3czdSTzhxcDdwZlU4Y2xS?=
 =?utf-8?B?b2dDL1dTTW1CWUk0TEdJSnY3NmNpWlZndmxRR1liMWh0M3QyaUtjbXhsZlpz?=
 =?utf-8?B?ZHk3OUFuenU4cUYyWmRRZ29PZURLT256dUJxbGluNEFEak1kZkdJU0F2MkxC?=
 =?utf-8?B?eXpZUFltdUlLSGhhME1aekpReXdGb0ZqRldyQ0pkelA2MEh5cFVUMnN4aTgr?=
 =?utf-8?B?ZngwZzBWNlFSTmpKcmZ5ZXdXWjA4MStjendqTUpDa2dyTWFCZURzdGdZbnl1?=
 =?utf-8?B?Mm9aMkFBOFlsajlvWVdqQ3B2N1JmalM1aFovN0FDV3J1ZmhkU0ZObjZ6U1pH?=
 =?utf-8?B?TjhCZ0hTYmlxdEwzYUhIbGw4cXRSUjI1VVNRWVRGb1Y2TllKNjZGRkpWZWFh?=
 =?utf-8?B?NElPb3NoR1J4TFJtdERuUk9SUllSMEFidCtOWEhjdTg1R1V1MnRPbHBTRzNz?=
 =?utf-8?B?d0E2SCswMzY4TDljR2JRRGtqS2g5ZzRKRFFvdzVvVjd5VFlEVFdDblRIbGt6?=
 =?utf-8?B?VFJOOEUzZzRaM3lQYmZGUlFWZHZpWk5maXVwWEJNTXdOangvUEZwaXdaeWk3?=
 =?utf-8?B?cHF2TkVNcnpDdW81OSt6cUlVKzRTSk04S3BOaThQeS9Hemc4U0ZVQ3ErMExV?=
 =?utf-8?B?WW9wTlR2Z2hHdk1kV1hZZXRSd2lyc05NM2plNTBEVHBxRDBLNGRiYlNoOVli?=
 =?utf-8?B?QmU4WEN2VHJBaXZ1ZHlURGdUMEVKd1RzL292aWZPcWNqcHNtUFdlRjVKbm5r?=
 =?utf-8?B?bDdGaHJObWxKYnV0UUh0L0dTMDd5LzBnRFF2MzIydGQxQTlLa3VLeTlCbGlJ?=
 =?utf-8?B?YWRVM3c2QzYwcFNZczBVWTFYTjFtZ0xraGQyOTEvWnJBMU9pMDlCUjhzRHpE?=
 =?utf-8?B?dXdFYmphZ3NreHBoMmVmaFFXRHRiVjByK1Ixa21HZ3hBRU8wREl2eGdoa1R2?=
 =?utf-8?B?c0RKZmhoQlBxV2kvYjlwdk1UaWdCNE5RNGdSWXd6cy9tcjlDT1hLMUNDUTBN?=
 =?utf-8?B?YU80OFBkdFZ5ZzYwVWs5L2tveHorcjIybmMrU1RDU2dQeTl1eWRoTnprS1o3?=
 =?utf-8?B?RWh1YjFhbEdRQzJWQmVqcE1CVldkaHh1bU5PWm13RG80NlpqS1Z4NzkvZXAv?=
 =?utf-8?Q?Im8Vr6yUxa65xkl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b6caea-77f3-410c-e654-08db61154b6f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:53:49.4081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KeXq7l2z3MPTQMZUTXWoYVSoC71qNvFc3WNx/wJiJMcR5G142yfyPgQCujeBxN8wQmP/nGBDB16eECkq2sbKqbNDXdfrdfpjlW18VhxOUkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_10,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300113
X-Proofpoint-GUID: 4gpTbM79yqtZKhbGZGhsMYgodxYW5I5t
X-Proofpoint-ORIG-GUID: 4gpTbM79yqtZKhbGZGhsMYgodxYW5I5t
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 5/30/2023 9:38 AM, Philippe Mathieu-Daudé wrote:
> Hi Steve,
> 
> On 7/2/23 19:44, Steven Sistare wrote:
>> To make forward progress on this series and reduce its size, I will be posting
>> those of its patches that can be independently integrated and have some value
>> on their own, to a reduced distribution of reviewers for each.  This is what
>> I plan to break out:
>>
>> migration: fix populate_vfio_info
>>
>> memory: RAM_NAMED_FILE flag
>>
>> memory: flat section iterator
>>
>> oslib: qemu_clear_cloexec
>>
>> migration: simplify blockers
>>
>> migration: simplify notifiers
>>
>> python/machine: QEMUMachine full_args
>>
>> python/machine: QEMUMachine reopen_qmp_connection
>>
>> qapi: strList_from_string
>> qapi: QAPI_LIST_LENGTH
>> qapi: strv_from_strList
>> qapi: strList unit tests
> 
> The break out looks good, but I guess it is a bit obsolete (as of
> today), you probably already re-posted some of these patches as
> separate series. Do you mind replying with a "ping" to the posted
> ones which still applies and need to be reviewed?

Yes, I re-posted this list of patches, some of which have been accepted
or are close.  I will reply to the threads that are still open and cc you, 
but I will first verify that they still apply cleanly, and update them if not.
Thanks!

- Steve


