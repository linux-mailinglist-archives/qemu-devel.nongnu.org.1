Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8395574DA22
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIt3T-0002rY-Oz; Mon, 10 Jul 2023 11:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qIt3L-0002nk-J5
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:43:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qIt3I-0006W0-Rl
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:43:55 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36ACcOU5022937; Mon, 10 Jul 2023 15:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NWkMPhznEIPzkF0Ep6brkjlHiOEce/4GhgNT2TrBAls=;
 b=tiqZZ0tmsmYt4AgiZQmMC4SX5HLVkXasOlG5HH6kHBsBfldM7PFzmmYnbGFRSIUMDhK7
 sgoX/yYcEZdt8PAAJSLZjnK6Ghw+E6yeSkbNhBBRhHJwpH4oA4xb59cidckA6hPgZrJb
 R1M3xWbMlVoJRe6JUbCO3GYtPAolRduI1iNPSEJT7VtWoQ3r4bVLsM10vVahjSnYgAMB
 3Dit+5JKr4WIYRpJxwkOo7WAkL7IIFseDGCHE1Nf7EXlvn1QhtLFWzTn8Ljvkje+pkAC
 V8tQxKM04T7Xj9qoK5RuLxoJPgGHU8KkNnVY3W5u9qhuNIbcv55IGPJdL5fd3lw2dnqa Iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpyud2wme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jul 2023 15:43:30 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36AEYmF7019269; Mon, 10 Jul 2023 15:43:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rqd27vu6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jul 2023 15:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnQ9ObWHnhvON5Yono6Oydvg1V3P5VAvLhDwddxtHP24dt6KRmscl9p2mGdZNdWDWpL0GIDau/c0c8DL4HFI9sASmStJlsytFmBrMukzdg/kFw30emil7ToOe1dMjEo6ti9z7fpEdtTUN1C4orqvSj/PjPs7ETy5f8EIWAsctdDya9WnA7QYlpjtX45Efeq4o73mcFXLUEOFM2enqrHRyPUkZqDa+hIgGAn9y4w7Y9K+P+7qJgSLtKMA9PVibxzJh+ze0NFvcYupNHxw2Tbxe9EVY3YyY972b1Qfo6ZTVOiJIKEQgCW73vvteMc6vafAA9OerX4iF0D5Kx9z0xyo5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWkMPhznEIPzkF0Ep6brkjlHiOEce/4GhgNT2TrBAls=;
 b=ORcSZ5VQDr2xZgsXS0oyTlF8Lwu1sKepEj5r/S4lDBxEwX70jsg4B39bQeHiWzEdw56tzL8Gw5V7zaA7A5MtDbzl2HRub72mT77do1oeVgrGskyKC20Egv9vIWOqpugvcwiUZVEVP8p8ArpgVL/VrGM5NeqeqU3b9j9jFpIVHfFSkTz/+oeW8TIz/2mET5KttJU+Gpyd3xyZZnym/oXzkLQFrhboJHDrO8KqTLT/b13ZWILoOiH+VE7ZUvtaO2FLr15xfDl+UK3Y5RFZtKxwElf89k7d1eNZCcdH+s05sZnDbswajCv1CQAej+uOS+5/m+2SDiBcEnsvGFR5Jx8T3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWkMPhznEIPzkF0Ep6brkjlHiOEce/4GhgNT2TrBAls=;
 b=HNdOD3GD/hjKrg8rUiMRh4Xjux9PiRUeaDIz0dbgzHhDut3YjEZMrWrSJz5MWMy1YR6lL1zjNKV0reIHGr5raSY8ATQT1j4LKHWXB2LKDTFk5kOEdeYe+XcNfMgF4ZwbtsNGMk336VDgNDXjtGxWQnPbHNmqTbZG431C6BmZ1Xw=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA1PR10MB7791.namprd10.prod.outlook.com (2603:10b6:806:3a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 15:43:20 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 15:43:20 +0000
Message-ID: <eafc9251-4b5c-d905-4e92-e6b02f3c2c56@oracle.com>
Date: Mon, 10 Jul 2023 11:43:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V9 32/46] vfio-pci: cpr part 2 (msi)
Content-Language: en-US
To: Kunkun Jiang <jiangkunkun@huawei.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Jason Zeng <jason.zeng@linux.intel.com>,
 Zheng Chuan <zhengchuan@huawei.com>,
 Mark Kanda <mark.kanda@oracle.com>, Guoyi Tu <tugy@chinatelecom.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philippe.mathieu.daude@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 David Hildenbrand <david@redhat.com>, John Snow <jsnow@redhat.com>,
 Peng Liang <tcx4c70@gmail.com>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
 Zenghui Yu <yuzenghui@huawei.com>
References: <1658851843-236870-1-git-send-email-steven.sistare@oracle.com>
 <1658851843-236870-33-git-send-email-steven.sistare@oracle.com>
 <8f79e5cb-aa6b-8bff-d0ec-f62fc929f669@huawei.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8f79e5cb-aa6b-8bff-d0ec-f62fc929f669@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA1PR10MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: 229303ad-ca4f-40a0-cf78-08db815c631b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9E7Qu+7wjDqPb7dOHMyKKYnmdmFJeawCnbbDBeUQ2PUlaHWnJEErulDKaMlAnTMMM1majIi48KHmR/2fLwFMyfpzJPh0klE0oEXkEJY65LDYJC/+CXGvEpVG3LCWHJEjSjWFWHI3hpJ862EXT3GO8XwZe5MHVngI1QQaXG3le/pfPYMu4LRjI/3vNgdHln/UJAT/fquoz2K71RlslSWb456f6zUgHOIqTq7u8/jnsK5E+vjADXy+TJ5TzbfLmCPUpKN/MpAa6+hiDHwb+By1CsxXbkAitrroSPeXU0xijb2at51e1BtzI/jdVAL9JXAFYtmAYRSZ10fmFPAnkfJ6JUrArDoxzfDETAC0yNQBEUW9+SRr72vUWLZGz0pemEKcFFN6ev0t/kvXubMRBtVgedJg32QMN0LxOIqHyaeFSu19cFPDY+8vBWjkaUDHxshwzdWjo8gCSH4yF7xJABsyNovJCzpB3VWsUrZyNkkK0Pf7Lebt2q3OCIu/vXtYY5T+6MXbipcbTkK1BINQBF/tLda+kBBD7xqWnkg8ldIGFj+ZT9mrX9myP3SoJ+bv/w4ktSA0ceThKdk8bmjI+KOFm3ThfK4E5l4eodje3tPtv+tjetAv3+Vu1YhofKRo1yMc99YAjoNR8EGc7RuSbUzD8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(44832011)(7416002)(5660300002)(8676002)(66946007)(66556008)(66476007)(31686004)(2906002)(316002)(4326008)(8936002)(54906003)(6666004)(6486002)(36916002)(6512007)(53546011)(6506007)(26005)(186003)(83380400001)(41300700001)(2616005)(66899021)(38100700002)(478600001)(36756003)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0N4bSttSlJpU2VXRGNvaXZmK1dvVFhBNVJkNVYvakt6QUZJbHNlQ1ppRnJz?=
 =?utf-8?B?cUxoeFEyM0xnRzRJMlFUNmZnUnNkUERSRlZiYlJGblNUQ01ldG5mSVAveEVm?=
 =?utf-8?B?Nk1MRmh3dytnbmRNR29tQ2VIazJ4QWRDUHlIeEU3MVVSM3RRM0VYSDIrbkxU?=
 =?utf-8?B?RjlCQ1VyVHNiZ251ZmxXTVp4Y1NTdVZQVlJtdGZ6bWQzMzRsK3Vxd1ZWYjZ6?=
 =?utf-8?B?QkhMWGZvNmFFS2lQN0RzN2Z3d2dsdHdHRTh5TGR3cWRGZVFlNFFqWkd5ZGJq?=
 =?utf-8?B?Y2JkeE43TExOOVpRMk9jemIxZ2hXWGhQZEI2S3d4d0NqcTBnWHdOMTZ3QUpt?=
 =?utf-8?B?UnB4N092OVJWQlAwQ3UrUmllQnhHM2p2V0xFN0x4ZVRVTi9oZXZmUXViR0I0?=
 =?utf-8?B?emw0VURxaEtaZncwRHMxTkJaZityUWdKOFkrVnc3MUcwOElYL0NPT0Q4dU5U?=
 =?utf-8?B?dFBma21sV2hnSkRUem10UXZyYzdNM21xZU9KZS9lOEhUYkxucnVOZlJ6cjdV?=
 =?utf-8?B?bU91QkJveFM4NDZDVlN4UFlNYXZKR1lndVIwcFRLUktFSy9GNXZJM0IxR1NP?=
 =?utf-8?B?SlRwVHVnektMMkxNSklOVGxZTUw3d2VXZzVndXFrVzA5U3IxcU1La1d4dG9B?=
 =?utf-8?B?UXBhYUVmc1NManVNcnBBVWI4WFBRZDYwd3huU0JFa1NrN05wbnB3eU4rVG9W?=
 =?utf-8?B?WnV4cHdxc0huSVdsWHJ0eDY1amJEREhqUllVQmpjb0ZrbzFQQ093bWtVYWF2?=
 =?utf-8?B?dDZ6aXFRMitSUk54WnU5MDBCZURLcEQ2N204SzlPMDMrOGhPVHZmQmo1Nm5V?=
 =?utf-8?B?MHFsanBBb1U2YW9oZURlb0psdlk3ekFDbjd3c0FXenFxQ3BCbGc0OFB1cHFt?=
 =?utf-8?B?VmRoZmgzWTVVV2NiVHlXOTV6UnB1SERKSXFjRk5YVHBCM2QwZUoveVprWk93?=
 =?utf-8?B?Z3lwdTZhcTVEUEI0bkdJQ1VUUFJpenRLTHQzcThwM0tZM28xUzlaekN4Q3Bs?=
 =?utf-8?B?eDhOUTJVOGNKTWFMMXc1YTdXdjhlUWdYVlJXNmx0NmlScXNmQjArU1VLYXdt?=
 =?utf-8?B?MTg2cVF1N0FFakRIU0VhTE1LbDh6aXZIMzg5SEpNTitkWUpBczc5Y1k4N1Bi?=
 =?utf-8?B?dGtxdzIwRitxbi92WWQ2TUlZVDVTZk9Nek53aUYza3djcHRLUXZOY0Y5SDFn?=
 =?utf-8?B?WnJxU1VzWGJ6QUd5alY1Zm1UdzRjVnBTb2xRSHVwVXJxOFRXKzlEd0NPcWlT?=
 =?utf-8?B?RUMrN1RhV0RSN0NsL2U1SHlGZlVkYVd6cWF0RE43MFU1amJsTWZLQWJDMHBk?=
 =?utf-8?B?cmlONDd6N0NQQThON0xLZTBCWTVaMmlIbk9iWmlCckhINzNJblVJcitkY1Fv?=
 =?utf-8?B?cmhhWnBMV2tNWm1PRVNrcFUwa1QwUlNYS21Zd3FGYThDc1kzYUxMem4rM3hD?=
 =?utf-8?B?a3Z4Z2VTNVh4aVpLZ3kxU28xL3YvSjZXd3lSUmFkUVhpWk5UU2JQTW9WWXRN?=
 =?utf-8?B?aTc0N1pNNlpldWwvL0JsQktyQ2U2MmNjWTNVWHRTdFNvdkJrd2JJajNlVXN0?=
 =?utf-8?B?c1N1TnU4UXVYSUx6bTNtU2FpaEc3T1BDTnlUQ2lYT2NXcXpaWGt3UXhBZGZT?=
 =?utf-8?B?Y0Q0b3dQNFErY2tZbDZXcUNmc2FUVmdJU09qeFJyTk5iZ3ZoYjRRb3RDVXcx?=
 =?utf-8?B?ZlpQTS9TRXNhTlZLUkw3NnQrL2Frbi9EcnRCTWhVSThGSHBHN0MvOFA4Y1dK?=
 =?utf-8?B?MS96R3Q3eVZiSjIvMXgwejllSUtiek9jd0Jwa2hqRndLM20wK2tGWkIzRU53?=
 =?utf-8?B?N1UwdTdyMjdaK3ZxeFMweENldjZHbUx3aGpZVjIvZHUxZWQrNlhwejdpUWJW?=
 =?utf-8?B?TzUxbmlJWmtDYUM3U3dPMjhtYTVlUHJTSXk1Snl5LzIxWDI3ZUIyR2dVUkU1?=
 =?utf-8?B?TUJ4NUdGZWgvZWNBTHFMTlZOMFJIaUZEUW5ud1dKb3FxL3BUNmlsL3ZQWG82?=
 =?utf-8?B?MVpKLy9NdXZqOElWNWV2Z1ZIVXB5RGJDWjMwbWlJNEltNFJtalh4N01DUjhP?=
 =?utf-8?B?bkF3dkM1a1ZrS3piSjBqemF2NlFta04yUDg5TG9KR3NJWlJxZk1qQU9VQm53?=
 =?utf-8?B?SU5iWktpcFFsZzRIV1FIT0JvUVRGeUliMzVTK0k4dVE1WVhNNjE3bUIwbUYw?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QmszMXNRTU9sZnZheEd2cW1lQTVwdmJFVmx6MldXWm1xYVpudVF5dmNDUEVq?=
 =?utf-8?B?czdCMEhvRm52SEVoYlo1elJIaUhtMjlhRDdwem9CYUZwS3doeEZWa2F3S1FR?=
 =?utf-8?B?cGt0dDJ0dkx1aXRDRG0yU0kyRGNIQW1HZjJ4bHF6WnFWVk5EcW5sUnYzR2ZC?=
 =?utf-8?B?NldDYWFEckF4Y2hJOEFDeGhFSERDc09mV2UwSmIrb2h1Y1FwU1daYlU3K2RQ?=
 =?utf-8?B?OUNCS0p5eVhTZHR5VUhhSXRQcUVuQ0hSWWtKenN2V3VMZmdURUxpMDExK0pE?=
 =?utf-8?B?a0RKQ296NENONVdVOG1vdzJxanpaV2tZdUJQVTZlWXFHQUxTR1I0NUJNNDk0?=
 =?utf-8?B?dnpVdEFoWGc4YWRWMFR2dmxZOVFhVXptcFpBcEN5TGJVK1RXK25mT3Iwc0wv?=
 =?utf-8?B?ZUFlbXl6R2ZCSzFxcmlNZUtCeERYUWxvbk5FcHYzN1cyenNLYmMzRDlYKysw?=
 =?utf-8?B?b2dFYUhxVExNSmk2Q2xOWFlLMURuaTlkd29WSkRXdGRZN3ZRYlFqczYzaHlL?=
 =?utf-8?B?dE0wK2pUMXN6NmlVOExpUkpDRzkzU3JCYnBuTVQwNGdkNUVhSWhueW1MZENq?=
 =?utf-8?B?NXBYZmluKzFWVU1kTjFsODhJeng2d0Z6S0ZMNXhCWEROWUNlT3FTRmxDb1ZM?=
 =?utf-8?B?Q2h6d0ZoTWxzYjc0R01lL2ZYQ051d0tkS3lFbG5ESk9oaEpaSmE4WVBPcmtz?=
 =?utf-8?B?NERPekllZnM2aU5ScUpuaWZIRUMyelRvYnlOVHdrakRhS2o3V2JHUjhnUnZU?=
 =?utf-8?B?R2ZmdTN5N3BEaDk5Rnpib0hSYkpMU2lDWGVmdWxNS3FuMy83TXdwcC92Nm44?=
 =?utf-8?B?NTBLMFBYL3hWYmRkdEpIQ08weWM0SlZUYzJZQWZqZUI1eFZ6bWNic0EvSlgx?=
 =?utf-8?B?WkZoVTFmNnh6ci9qd3hYZEFra0dmRVptNm81cEFjdmlFK29mSkh5Z2hLb3dK?=
 =?utf-8?B?bEsxUVZCckNQMjIxQjJPaURSUVJhemtVRUpYdHdYbXlGWTFobUxmeWY1TW9a?=
 =?utf-8?B?cWIwT1UrVXdkSnBNbjVwNnJva1ExaFExYlo1cVhwbmhWSi94NXNVRHNjWU5X?=
 =?utf-8?B?WDd5c0lxRjFJSHJTUVFJMVYvUHhuNno0ajdYSXNkaUdHY1hxUjFSYVZKc3Vw?=
 =?utf-8?B?enNXTFZabncyYmhhSU9IK1hXOFBnbmhhUDdZbFRWVzZXWnJFZW9yWVl1M04z?=
 =?utf-8?B?UUNLMTM2NnRLZGFQZU9MS1BmN05PakZ5QzVtVG9iRXkzZnRtUVN3Q1RQZjRY?=
 =?utf-8?Q?q06j/hCpMmKoORW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229303ad-ca4f-40a0-cf78-08db815c631b
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 15:43:20.5375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8BWuUdS50/u5nfzeDvBG/YafvHdCb9n88wSHDNr5LKLD3rsS3O7U3Na7d/59Rz9VgW9JQSnE+fYr1dt8jlM/JGxYnHjGKJxqGe7n8HE03I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_12,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100142
X-Proofpoint-ORIG-GUID: eNL1x7gp2VWDum5goC0M--zdxLJ0nEht
X-Proofpoint-GUID: eNL1x7gp2VWDum5goC0M--zdxLJ0nEht
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/5/2023 4:56 AM, Kunkun Jiang wrote:
> Hi Steve,
> 
> I have a few questions about the msi part of the vfio device.
> In the reboot mode, you mentioned "The guest drivers' suspend methods
> flush outstanding requests and re-initialize the devices". This means,
> during the downtime,the vfio device dose not generate interrupts. So
> no special processing is required for the msi interrupt of the vfio
> device. Am I right?

Correct.

> In the cpr-exec mode, will the vfio device be "stopped"? If the vfio device
> is running all the time,it is possible to generate interrrupts during the
> downtime. How to deal with these interrupts?

The vfio device is not stopped, but its connection to the kvm instance is severed.
Interrupts are pended in the vfio kernel state, and that state is preserved across
exec, by preserving the vfio descriptors.  After exec, qemu creates a new kvm instance,
attaches vfio to it, and the interrupts are delivered.

> In addition, ARM GICv4 provides support for the direct injection of vLPIs.
> Interrupts are more difficult to handle. In this case, what should be done?

I have not studied this feature or tried it.

- Steve

> 
> Look forward to your reply.
> 
> Kunkun Jiang
> 
> On 2022/7/27 0:10, Steve Sistare wrote:
>> Finish cpr for vfio-pci MSI/MSI-X devices by preserving eventfd's and
>> vector state.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/pci.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 118 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index b5fd2ec..1d0e8db 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -54,17 +54,47 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>>   static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>>   static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
>>   +#define EVENT_FD_NAME(vdev, name)   \
>> +    g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
>> +
>> +static void save_event_fd(VFIOPCIDevice *vdev, const char *name, int nr,
>> +                          EventNotifier *ev)
>> +{
>> +    int fd = event_notifier_get_fd(ev);
>> +
>> +    if (fd >= 0) {
>> +        g_autofree char *fdname = EVENT_FD_NAME(vdev, name);
>> +
>> +        cpr_resave_fd(fdname, nr, fd);
>> +    }
>> +}
>> +
>> +static int load_event_fd(VFIOPCIDevice *vdev, const char *name, int nr)
>> +{
>> +    g_autofree char *fdname = EVENT_FD_NAME(vdev, name);
>> +    return cpr_find_fd(fdname, nr);
>> +}
>> +
>> +static void delete_event_fd(VFIOPCIDevice *vdev, const char *name, int nr)
>> +{
>> +    g_autofree char *fdname = EVENT_FD_NAME(vdev, name);
>> +    cpr_delete_fd(fdname, nr);
>> +}
>> +
>>   /* Create new or reuse existing eventfd */
>>   static int vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>>                                 const char *name, int nr)
>>   {
>> -    int fd = -1;   /* placeholder until a subsequent patch */
>>       int ret = 0;
>> +    int fd = load_event_fd(vdev, name, nr);
>>         if (fd >= 0) {
>>           event_notifier_init_fd(e, fd);
>>       } else {
>>           ret = event_notifier_init(e, 0);
>> +        if (!ret) {
>> +            save_event_fd(vdev, name, nr, e);
>> +        }
>>       }
>>       return ret;
>>   }
>> @@ -72,6 +102,7 @@ static int vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>>   static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
>>                                     const char *name, int nr)
>>   {
>> +    delete_event_fd(vdev, name, nr);
>>       event_notifier_cleanup(e);
>>   }
>>   @@ -512,6 +543,15 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>       VFIOMSIVector *vector;
>>       int ret;
>>   +    /*
>> +     * Ignore the callback from msix_set_vector_notifiers during resume.
>> +     * The necessary subset of these actions is called from vfio_claim_vectors
>> +     * during post load.
>> +     */
>> +    if (vdev->vbasedev.reused) {
>> +        return 0;
>> +    }
>> +
>>       trace_vfio_msix_vector_do_use(vdev->vbasedev.name, nr);
>>         vector = &vdev->msi_vectors[nr];
>> @@ -2784,6 +2824,11 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>>       fd = event_notifier_get_fd(&vdev->err_notifier);
>>       qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
>>   +    /* Do not alter irq_signaling during vfio_realize for cpr */
>> +    if (vdev->vbasedev.reused) {
>> +        return;
>> +    }
>> +
>>       if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
>>                                  VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>> @@ -2849,6 +2894,12 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>>       fd = event_notifier_get_fd(&vdev->req_notifier);
>>       qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
>>   +    /* Do not alter irq_signaling during vfio_realize for cpr */
>> +    if (vdev->vbasedev.reused) {
>> +        vdev->req_enabled = true;
>> +        return;
>> +    }
>> +
>>       if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
>>                              VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>> @@ -3357,6 +3408,46 @@ static Property vfio_pci_dev_properties[] = {
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   +static void vfio_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors, bool msix)
>> +{
>> +    int i, fd;
>> +    bool pending = false;
>> +    PCIDevice *pdev = &vdev->pdev;
>> +
>> +    vdev->nr_vectors = nr_vectors;
>> +    vdev->msi_vectors = g_new0(VFIOMSIVector, nr_vectors);
>> +    vdev->interrupt = msix ? VFIO_INT_MSIX : VFIO_INT_MSI;
>> +
>> +    vfio_prepare_kvm_msi_virq_batch(vdev);
>> +
>> +    for (i = 0; i < nr_vectors; i++) {
>> +        VFIOMSIVector *vector = &vdev->msi_vectors[i];
>> +
>> +        fd = load_event_fd(vdev, "interrupt", i);
>> +        if (fd >= 0) {
>> +            vfio_vector_init(vdev, i);
>> +            qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
>> +        }
>> +
>> +        if (load_event_fd(vdev, "kvm_interrupt", i) >= 0) {
>> +            vfio_add_kvm_msi_virq(vdev, vector, i, msix);
>> +        } else {
>> +            vdev->msi_vectors[i].virq = -1;
>> +        }
>> +
>> +        if (msix && msix_is_pending(pdev, i) && msix_is_masked(pdev, i)) {
>> +            set_bit(i, vdev->msix->pending);
>> +            pending = true;
>> +        }
>> +    }
>> +
>> +    vfio_commit_kvm_msi_virq_batch(vdev);
>> +
>> +    if (msix) {
>> +        memory_region_set_enabled(&pdev->msix_pba_mmio, pending);
>> +    }
>> +}
>> +
>>   /*
>>    * The kernel may change non-emulated config bits.  Exclude them from the
>>    * changed-bits check in get_pci_config_device.
>> @@ -3375,6 +3466,29 @@ static int vfio_pci_pre_load(void *opaque)
>>       return 0;
>>   }
>>   +static int vfio_pci_post_load(void *opaque, int version_id)
>> +{
>> +    VFIOPCIDevice *vdev = opaque;
>> +    PCIDevice *pdev = &vdev->pdev;
>> +    int nr_vectors;
>> +
>> +    if (msix_enabled(pdev)) {
>> +        msix_set_vector_notifiers(pdev, vfio_msix_vector_use,
>> +                                   vfio_msix_vector_release, NULL);
>> +        nr_vectors = vdev->msix->entries;
>> +        vfio_claim_vectors(vdev, nr_vectors, true);
>> +
>> +    } else if (msi_enabled(pdev)) {
>> +        nr_vectors = msi_nr_vectors_allocated(pdev);
>> +        vfio_claim_vectors(vdev, nr_vectors, false);
>> +
>> +    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
>> +        assert(0);      /* completed in a subsequent patch */
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static bool vfio_pci_needed(void *opaque)
>>   {
>>       return migrate_mode() == MIG_MODE_CPR_EXEC;
>> @@ -3386,8 +3500,11 @@ static const VMStateDescription vfio_pci_vmstate = {
>>       .minimum_version_id = 0,
>>       .priority = MIG_PRI_VFIO_PCI,       /* must load before container */
>>       .pre_load = vfio_pci_pre_load,
>> +    .post_load = vfio_pci_post_load,
>>       .needed = vfio_pci_needed,
>>       .fields = (VMStateField[]) {
>> +        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
>> +        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };

