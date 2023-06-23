Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9495873BF1D
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 21:58:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCmu7-0001eI-Gb; Fri, 23 Jun 2023 15:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qCmu2-0001dx-RV
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 15:57:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qCmtu-0006pH-AM
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 15:57:06 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35NJJNk2004752; Fri, 23 Jun 2023 19:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1qBRG1DhuksK80iSSOwxIANX2R78EcspWo2oeJVZC18=;
 b=OYd4hdGToQzvXfQvsD38FeNFtNzlXE1UG36a0GXOw+JfBaCSfrPggCBOOCjx/15p2kS8
 zfMqNDaSHzgHbOGoqOIa7+xQCpbbaMnqaCoKRSfdCbsOhtQkdTJbDSOKvwypgip8DsyQ
 nNq/OhpvWGRGkUarr5O4dL6nAjDz39oYNWToOTerkoJT8lUEbFDKGFE1oJHT/mcIGRRf
 1OXO19VbNUbAQgSSCwj/A/1co4cDMJL4t7NGiyKYY85N0xTmkvr+EYS53hoidtmRQEpT
 6mBRBJZiqsBnmGjO91dOxy5RNispw+z4lbudmmMF2Q9tS1+yNlpO9+lJA2xZFjD2e03q +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93e1muh8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jun 2023 19:56:55 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35NJ1nXq032965; Fri, 23 Jun 2023 19:56:54 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r939aham5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jun 2023 19:56:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6uCsr4dAqgZq0WndldibSxdtNFKpkjySRiKaX874Q5nwR2m/J5QAV1KWhdtob7erJmGLYZcbqdkXDZK7icWieUXLMe2xC1SeaX6wkeaeebGvdmeG5x+x8f+WXSNBbyIzqrQYGpt2gabnn0KfdDTaiGvZuLttQpV4fQ/AT9GHcV8S+vJ1q0Q+UM0WJT5LcK+847t+zkRlpseHY9UnoKVNk16xuXW2/Z1A5Zctr0TZbdHfxFhqJtMnTpEKIIxFGjAELMg1cXrw36DFWx4auw9SY+0ptrx80RsTzRA+HQZeA4H+gZ8C467qBKhXJLxh4eA4V+ttUqf0DE1EVX2Merfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qBRG1DhuksK80iSSOwxIANX2R78EcspWo2oeJVZC18=;
 b=KoQ6Fc9ESHg4ZxheMffD1EET0MwnhbprRn33Y5V5xblcvjjwS8S/anY7yedWJ9SzoW/s/aM8tfzwn7QFfpDzZF4X6yF/SDqvPkrTbIqrb4LTJDthunkFaOqtygtFvTv4GGwCS59DOWX19uulOtyK4IanRp0kjI4sAayTT4ny4eSVBk8EEeknoVs9Jib8Wrt7TsH0G+LyATTuxDWVS3UAsBcORbE5wDF2EIGx6BeOhWpXY1BOdcQg3qa60kCibezLJZ6JLHZ/UbjoCiPtXCvbxUOzHMMhdQ9SVybKf/yCmuFDoJzRYAtQMtRjfvP35Yj7dLgCUPE1vJOnF5FCkudRIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qBRG1DhuksK80iSSOwxIANX2R78EcspWo2oeJVZC18=;
 b=z/vaMTRf4pte1FEr9uODC+U9SadKVIHpkqZZFRGi7sMEylTblB2idLOu9sndQatfSB0T5LnkyKm5UXQ5faT1+j6n38XODbBWvZudDCur5caWZztYzdxz5PaHFQQpyrzL2zM39TKoN1TTVIW798q0FjrDuhMxf5+BN9N2bfya5jk=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by LV8PR10MB7752.namprd10.prod.outlook.com (2603:10b6:408:1e7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 19:56:51 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11%6]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 19:56:51 +0000
Message-ID: <d4c81d51-b0c7-d810-27ad-140596314603@oracle.com>
Date: Fri, 23 Jun 2023 15:56:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V1 2/3] migration: fix suspended runstate
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
 <1686860800-34667-3-git-send-email-steven.sistare@oracle.com>
 <ZJIeR7svXvtHdgs4@x1n> <6adfae20-60fe-ae08-1685-160b2a1efab5@oracle.com>
 <ZJNdcyrv0TzFUKMy@x1n> <340b5f58-0924-6f8e-6f82-0462a5cc22cc@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <340b5f58-0924-6f8e-6f82-0462a5cc22cc@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::19) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|LV8PR10MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: e42c24d5-07d3-480b-7a3b-08db7423fc47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kiwltvqRnuXCDz+EE9DeWa1wRpiw4TPmJasLHeVTrKaED0DtPvdJfjDqLI++2mWzpjcwed5oS67cAxfY8bD0r7Wv8SEQ/HgT3FKO93PFHK87PwYZAR2uuGkMNhcly6KURJiLSlv5RWoiRNia1SPO7bc/BJ+tkC5aFqemuw4X4gjp/UJP/nuyJI7Y2yHWEBJuEjjI/jXM4koN0Yei3VoZFsgwzvZIte+dmvFjFW2VhfdmgUpF+kZAWgdNwQ5uI1wA69B/tj9ddef4QyMUNfSqFoPnoEOz/jtjNjC5wFQS8QMvfjr9pgQSfbt17fPgUoam9zAZnXUgtbTOTSiFiWncLnJZHKC6N0YlUuJWh7sM4ZLzKMWP3nKRYuG8bq3ytFgLvdRgqboGJwnCxw2AiJgkQVN7mdzAFI3xHzZR1CUJNmZxyROvcpoBPj4NlTmQ+ff9THMls5WilKjRoEq1LtdzVGwYlJeebq9GlIqmE2qdFqOPeU5tWCU381IO6Q8OfLU8h2UfewPvO2qNjytPiOYpsSLeaA4z562Jk4RhRrXyMT0IHENqR69OsDpBgLocCzL30kNvieeMcTmI+O1N4X4STPY+RL7zblgV7XsqQ+l1mpxigJ5Srj+3n3ey7XBiZFa7lcIpNUi8vqJf39qGDRbxVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(54906003)(86362001)(2616005)(478600001)(36916002)(31696002)(6666004)(186003)(6486002)(41300700001)(4326008)(316002)(53546011)(31686004)(66476007)(83380400001)(6512007)(66946007)(6506007)(26005)(66556008)(6916009)(44832011)(8936002)(36756003)(5660300002)(8676002)(2906002)(38100700002)(15650500001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVlMRGJ1OHZuL3lSSHFIU0pNMVhVd1VkbUVmdlBlanNmNnNnWGhjWWJkUXBs?=
 =?utf-8?B?bk5BaVJaM2FCbHFIYUxLbHFmMVJLM2MrZjJSNTRodVZkWnFla2plcUNBRW1h?=
 =?utf-8?B?aHZaTkxQMytob2FFRnJiQ3VmbFhhVS9qSjM3dHlrVFlnMGtjSnkxUDVnU3Zx?=
 =?utf-8?B?QjViYklFbGZUQlJ1L2VqU00veTJmM2ViUjh4N3pJYjRTTkEwMEdWSGl2Q2Zu?=
 =?utf-8?B?NllmSC8vcmRlU3crQk1COUVoMmpFZFNGL2hLNkxQUzMzUzFuUk42aXlYVE9t?=
 =?utf-8?B?cDh3cElwdDZBOXNrcmVhWUd3RjJBN29pWXhhWVoxVmZuekZxMDV3NGNNdStS?=
 =?utf-8?B?MHJIeEJVdlhScUxVbWJJSW9VN1dFcE9EV01DWnNCN0p6YXFWNW15VThWMSsy?=
 =?utf-8?B?dndPdGlhVzdkRlQ1SFhqTW5JYWdhUzNjUVpRTy9KWjdWYkFESGx3ZVdUbjRU?=
 =?utf-8?B?VFpVUzZkMXpLdDVvV0o3Rnc5MEhMV3MrNy92VWhGbkt4RFZhOW9mR01WeGtU?=
 =?utf-8?B?OVJqOGs5M2hiZkJmbFRIdHRReVZrT3hVWnM2SmppQkJmTXZoYmhGTXJTcU14?=
 =?utf-8?B?OEtxOXJWNUZoNHNIdERCL0VuOTdHV09MU2JKaFJYQStYTDRteDlQTjFZd0lM?=
 =?utf-8?B?ckdjQXBtcDdONHNza0YrZUk3c25DUGZTMWpZTmtYU2djMDlTdjNYTzVyRHJN?=
 =?utf-8?B?V1M3ekNsbDlwejRKQ3BUNFhUNDJRc2E5ZEg0NFMyeExrM05hRGY5U2VlS2Nx?=
 =?utf-8?B?aUp4Ti9sRlA1Z1FOMDZ5c0dEekVhOFNHWUYzOUlDcy9LWUZiN1pwSDVsKzNi?=
 =?utf-8?B?WDJobWl3dHU2WFp3M3V0YlZyV1l5YXNCOFhubTR0SlVFdmlZc1k3OGlteS9R?=
 =?utf-8?B?ZGRXM0YrMmdaakl3ZWtCcm9DSVpDQWY2NHFOc2k0TEtCNm42ZitkMVlqeEhW?=
 =?utf-8?B?bzc3Und5LzlmRFZ2eUNtd3pubk12bitSQzBLTjdqSGU2SVFFQnVqVSt3S2pz?=
 =?utf-8?B?VjIrRjFDazNMUXBKYkZkL1BWTXRvYURUY1B6T0wvVUgzVWNVak9OVDNJTkJG?=
 =?utf-8?B?Qy96YStOTVVGc0hzSDVtWFRmUlNsRjI2bTNjMXFCRDZXci9tUTFlRzRuSlQ3?=
 =?utf-8?B?dGlOWmFLV0k4TTdrMHBOVkNWbTl3cFRpZHRsNUlvWkZVaHlySjZuKzF5SVJN?=
 =?utf-8?B?Qkg1OVY3cEYxM0tpdUZ2TmhCcW8wa01rUXh3TkFzaVpId2xZVm03dWV2ZC8y?=
 =?utf-8?B?bS9BNWZFbjRMcFo1OXpsMTFRMXlaM3hJODVaeFNMOTRFMmptNjVRVHJ2a3dX?=
 =?utf-8?B?VEx1SHJtMkY5TEordFhMYTM2Vjh5anJsaWpkaVNzWFk3a2lpMzRYbmJWMUFE?=
 =?utf-8?B?MjQxRkZPK3hCcHkyUnl4UEJjWGxQREVsVDNrNStqNFg1Q0ErU0pQeGJZSU1x?=
 =?utf-8?B?cGhCMmo4ZG5reWs2YWxZb1YwTnFhTUFtdk9ocWJKcVhTMkduZ3Q4bzlWcHdl?=
 =?utf-8?B?ZnlCVFM4WjUvY2JqTnh4V3NGd2pkek9TY1NyRG5ZUjhEenpJWHdoV1JmUHBz?=
 =?utf-8?B?QmhGWW40ajU5RHRxSFQ4ZzVoQlFwZnZubHVRdGhxWmEwb0xySGQzekJtbHBE?=
 =?utf-8?B?Zitmci95VXoxNXJBR1hmVStERlBXeGN2SGdIbnRGVk91V1RxQ2IvM052NzRF?=
 =?utf-8?B?NUdEc3kwUVU3NmVlVXBQTXhLSjdwSzhJVVJudUE2RzNNZHlHbVJkcWk4STd2?=
 =?utf-8?B?cU9MVnJaY0pZc0hmOVhZZFdPbzNmbkJiOHA2cDFxNnRCRUM4MHN3TVBKdWJ2?=
 =?utf-8?B?UkFVK05HUmkvaFFYeFFDL3JXRUJ1S0xTVU9HWVRxd3M0ZnJJRWFNOW9nbFNW?=
 =?utf-8?B?WDlZYUlJaTNNYjJkdU93UUVONTFaLzlXMGhiYmM1STZ5YVZyMGVVYWFvSkpR?=
 =?utf-8?B?bEU1RFVDQ29NVTFta3NRSVZFYlZkektOMDdBMlBzeDFJenM0a0NxMk1MTk5L?=
 =?utf-8?B?Z29ISmJpUlNmUlByZ1BWL2dMMUQrRXRja20xL0VPVlUrcksxbVFTM0VBSVRi?=
 =?utf-8?B?QmoxWUpuUTh4QXc3RGtUTUdickNiVk1NZ1FNa2c5VTJvMEx0ZDE4Mk1PZXNl?=
 =?utf-8?B?dGltTjFxSktXZC9ib1hua3lsR3hSRDVvZ2RhZS9KRzVWQkFrOGFKKzBTcEZn?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: juT1oryLCISDVRvCiqcZvujnHGI6tUKIIUuzs9HmLweG4WjFTFoFzLM+7P4gHkoJslqsJIVi0fHwsWrqBx51cfkeJKeIQ635TUiV7swTRbKvQPvUI7kmW5jMCNHWiWF2obz9b7ZL1TfJvYHvFO/UyM0KU7DlTmIpc72NPvTMV7AfECXnUkrFK56x0WoaNG1bgrTvwke+Aihe7GSV1etULK0ROYIwphSd03T5a2GN/wkoDLuSXgLfSegH3omAwn+nUREkTNerFEJP+o4InQTchFk9af2+AdAjYoqoPIBvbpC/F6qp+UXBRnwPRH2OZ9m3ogUwdEaJoqqQxsWcxJzj4lZZbnYlOJdooAclSB0B1j+oMLpBmZSwbY+QRmsHiYRCK+affgBO6bs1VnlguiyjMmbOGW6kX9Ldt5/GcOHc2kuB1RQCTI7y4wR713b0fHg+0v+dCfXzsVfzeYv5XSFm2g8XuqepNPzZpv7mJyjRQCWYOLB31i6doXm/Beb1NYYNo5deAzGk1VqH1E0HdzckBZKgdEIC48uVkYuAuUKAK5OJye7KPnyPrvlSxKsfMDZtqiigBNyMqj4kBMfSsjtfj2sw6vDl18oiQpv0LV4NyMeUi8vuNfGgvZIY5W77g/FlWtB4ZmmjCXxXji4KVFzqwtE/YkOCzBeShbRcZUoswcRN1jFX2jMs66S0uF2CTvlwuyd5QzD3X8kiarbqWYomkRvsAIULdMPALmDkAB6CoIn8Pkgb0ZqrMhyLZGTuJ+SxJk8pN6cuw5EdcInG1jKm0Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42c24d5-07d3-480b-7a3b-08db7423fc47
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 19:56:51.0674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhVOUQqbHJmB1QxHxyr6FRnZOGT2yc2Kjk4H2Tt1De3/5uSZHDF1y0DDUpdbF//hDFf9RquMswZUiDBX3iXTjBvJp8GmjNwhuaDjarGypD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_11,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230179
X-Proofpoint-GUID: 3m4pKXKe-51rFtw2_Sl3X3mi0UsL2x2l
X-Proofpoint-ORIG-GUID: 3m4pKXKe-51rFtw2_Sl3X3mi0UsL2x2l
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 6/23/2023 2:25 PM, Steven Sistare wrote:
> On 6/21/2023 4:28 PM, Peter Xu wrote:
>> On Wed, Jun 21, 2023 at 03:15:42PM -0400, Steven Sistare wrote:
>>> On 6/20/2023 5:46 PM, Peter Xu wrote:
>>>> On Thu, Jun 15, 2023 at 01:26:39PM -0700, Steve Sistare wrote:
>>>>> Migration of a guest in the suspended state is broken.  The incoming
>>>>> migration code automatically tries to wake the guest, which IMO is
>>>>> wrong -- the guest should end migration in the same state it started.
>>>>> Further, the wakeup is done by calling qemu_system_wakeup_request(), which
>>>>> bypasses vm_start().  The guest appears to be in the running state, but
>>>>> it is not.
>>>>>
>>>>> To fix, leave the guest in the suspended state, but call
>>>>> qemu_system_start_on_wakeup_request() so the guest is properly resumed
>>>>> later, when the client sends a system_wakeup command.
>>>>>
>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> ---
>>>>>  migration/migration.c | 11 ++++-------
>>>>>  softmmu/runstate.c    |  1 +
>>>>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>> index 17b4b47..851fe6d 100644
>>>>> --- a/migration/migration.c
>>>>> +++ b/migration/migration.c
>>>>> @@ -496,6 +496,10 @@ static void process_incoming_migration_bh(void *opaque)
>>>>>          vm_start();
>>>>>      } else {
>>>>>          runstate_set(global_state_get_runstate());
>>>>> +        if (runstate_check(RUN_STATE_SUSPENDED)) {
>>>>> +            /* Force vm_start to be called later. */
>>>>> +            qemu_system_start_on_wakeup_request();
>>>>> +        }
>>>>
>>>> Is this really needed, along with patch 1?
>>>>
>>>> I have a very limited knowledge on suspension, so I'm prone to making
>>>> mistakes..
>>>>
>>>> But from what I read this, qemu_system_wakeup_request() (existing one, not
>>>> after patch 1 applied) will setup wakeup_reason and kick the main thread
>>>> using qemu_notify_event().  Then IIUC the e.g. vcpu wakeups will be done in
>>>> the main thread later on after qemu_wakeup_requested() returns true.
>>>
>>> Correct, here:
>>>
>>>     if (qemu_wakeup_requested()) {
>>>         pause_all_vcpus();
>>>         qemu_system_wakeup();
>>>         notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
>>>         wakeup_reason = QEMU_WAKEUP_REASON_NONE;
>>>         resume_all_vcpus();
>>>         qapi_event_send_wakeup();
>>>     }
>>>
>>> However, that is not sufficient, because vm_start() was never called on the incoming
>>> side.  vm_start calls the vm state notifiers for RUN_STATE_RUNNING, among other things.
>>>
>>>
>>> Without my fixes, it "works" because the outgoing migration automatically wakes a suspended
>>> guest, which sets the state to running, which is saved in global state:
>>>
>>>     void migration_completion(MigrationState *s)
>>>         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>>>         global_state_store()
>>>
>>> Then the incoming migration calls vm_start here:
>>>
>>>     migration/migration.c
>>>         if (!global_state_received() ||
>>>             global_state_get_runstate() == RUN_STATE_RUNNING) {
>>>             if (autostart) {
>>>                 vm_start();
>>>
>>> vm_start must be called for correctness.
>>
>> I see.  Though I had a feeling that this is still not the right way to do,
>> at least not as clean.
>>
>> One question is, would above work for postcopy when VM is suspended during
>> the switchover?
> 
> Good catch, that is broken.
> I added qemu_system_start_on_wakeup_request to loadvm_postcopy_handle_run_bh
> and now it works.
> 
>     if (global_state_get_runstate() == RUN_STATE_RUNNING) {
>         if (autostart) {
>             vm_start();
>         } else {
>             runstate_set(RUN_STATE_PAUSED);
>         }
>     } else {
>         runstate_set(global_state_get_runstate());
>         if (runstate_check(RUN_STATE_SUSPENDED)) {
>             qemu_system_start_on_wakeup_request();
>         }
>     }
> 
>> I think I see your point that vm_start() (mostly vm_prepare_start())
>> contains a bunch of operations that maybe we must have before starting the
>> VM, but then.. should we just make that vm_start() unconditional when
>> loading VM completes?  I just don't see anything won't need it (besides
>> -S), even COLO.
>>
>> So I'm wondering about something like this:
>>
>> ===8<===
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -481,19 +481,28 @@ static void process_incoming_migration_bh(void *opaque)
>>  
>>      dirty_bitmap_mig_before_vm_start();
>>  
>> -    if (!global_state_received() ||
>> -        global_state_get_runstate() == RUN_STATE_RUNNING) {
>> -        if (autostart) {
>> -            vm_start();
>> -        } else {
>> -            runstate_set(RUN_STATE_PAUSED);
>> -        }
>> -    } else if (migration_incoming_colo_enabled()) {
>> +    if (migration_incoming_colo_enabled()) {
>>          migration_incoming_disable_colo();
>> +        /* COLO should always have autostart=1 or we can enforce it here */
>> +    }
>> +
>> +    if (autostart) {
>> +        RunState run_state = global_state_get_runstate();
>>          vm_start();
> 
> This will resume the guest for a brief time, against the user's wishes.  Not OK IMO.
> 
>> +        switch (run_state) {
>> +        case RUN_STATE_RUNNING:
>> +            break;
>> +        case RUN_STATE_SUSPENDED:
>> +            qemu_system_suspend();
> 
> qemu_system_suspend will not cause the guest to suspend.  It is qemu's response after
> the guest initiates a suspend.
> 
>> +            break;
>> +        default:
>> +            runstate_set(run_state);
>> +            break;
>> +        }
>>      } else {
>> -        runstate_set(global_state_get_runstate());
>> +        runstate_set(RUN_STATE_PAUSED);
>>      }
>> ===8<===
>>
>> IIUC this can drop qemu_system_start_on_wakeup_request() along with the
>> other global var.  Would something like it work for us?
> 
> Afraid not.  start_on_wake is the only correct solution I can think of.
> 
> - Steve

Actually, the start_on_wake concept is indeed required, but I can hide the
details in softmmu/cpus.s:

static bool vm_never_started = true;

void vm_start(void)
{
    if (!vm_prepare_start(false)) {
        vm_never_started = false;
        resume_all_vcpus();
    }
}

void vm_wakeup(void)
{
    if (vm_never_started) {
        vm_start();
    } else {
        runstate_set(RUN_STATE_RUNNING);
    }
}

... and qemu_system_wakeup_request() calls vm_wakeup().

Now the migration code simply sets the run state (eg SUSPENDED), no more 
calling qemu_system_start_on_wakeup_request.

- Steve

