Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A4A76BA33
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 19:02:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQskE-0004Tq-8Z; Tue, 01 Aug 2023 13:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1qQsk8-0004SY-My
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:01:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1qQsk4-0000Mt-4l
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:01:08 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 371BAprv027967; Tue, 1 Aug 2023 17:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1yH6H8+pi6w/zeqAIat2l9fsECkp2v3PYoG17wR2p8s=;
 b=lGtan5DYbprAwDqCfHPUvdn0hLIoKO2nQgnUMd++TGkDIm7RJloP7r+Apm0DetT26GJC
 /Rk0Yi1UGS8hkkKivadCGVbCMPZoWe41G7MD6GDccRpO3KNI0FxbJJHNvselXdGLeEz8
 e6+SEscSkgtrCZJq/N70rD06wimD8Y90fQdfKLAXe2vvDZ0pYI7ykFiTvMqcEQLZ/mVi
 PGbdlO7azADEkNOPE0bVHS797PTRT79N+k7CPvxkU0NryqU9DaZeGJuejaK7xzXkK+9i
 qq3nUXBS3TQMCnfBlj2NpOHRe6mvlE4HwUrgFNbPm6fu4Ige1gXgiY38kn+99hwbkJjd 8g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sj3wej8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Aug 2023 17:00:06 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 371G1Z0b037337; Tue, 1 Aug 2023 17:00:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3s4s7d7mmn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Aug 2023 17:00:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRrycUIWh3JlERkaluTNwL9GVPs5gYmLJvyQ7mTiN19iPnKYJhDgQ4UlshyQ/e4VEo2lqMjfi3RKdLjiLhQq2KHEcB+90n64YBjTjAdTX9t8sUuJS4VVXjWA//8mMJbq6Q+l3dGsP1ykshGLkX8ac/VEWpBifphLcStEuK7yUXMM3wi6fOJxVcJj1Vi+2KTm43MMjyp0IAg/WZRcC2n0c80Ul2e1zEyYUDBYy0MM9klPpz/P3L4ZkpGJD/k3Mj3ChQwgzDWXX66t6rsHY2zMufWnsYj+Dw4Kjb/2uWjyLv61H8YnDhDQVwCGGPSdEsZuO9oP56vACJR60WbVbkfcvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yH6H8+pi6w/zeqAIat2l9fsECkp2v3PYoG17wR2p8s=;
 b=NSdxF9FB8a1f4CaqwwRzS8pR8SRiNQKHdtF4L6Pw8uSyrEukzCYbOi/J4OR+wQCmF/qAZvXv3tYSkU1hwv1Lu4i8BxtcLSFQloiKQIYLIYilCM6r1GT/7ViFYjj1bnPuapt0VVb0N5MWnolAYaxmngIiYUEr7K9hZB0d2Li/m/qCXkNXdu9CBr9pfRGc0CNJT6Er/mA707v9B077pz6Ju7GTG3erbcugHFGhC5GTxWj4qbfRo6Hxd59eowFTdwyUGF7GgusKGsSsDX+/NbmARGjRWZbSIatWxHLejlNvxftEt4h5GeE5T/JCcPDFfoAEG320E5eXQol7Jy69s3MHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yH6H8+pi6w/zeqAIat2l9fsECkp2v3PYoG17wR2p8s=;
 b=IdLypNuGU1sMtHgz/jXxiRAu9j1UVQVhjCAUXkjM2v1htbXbzUSu191yH/LTQmMBfs7o5LEajCNd1z9a3YXzf2dN8Yu1YAJePwrhJrTnqFCD0RaSc5sZxHO6r2qx2tdijcMUyuiwrt2op34e/ywqVmTEnz6RVD7jXkX1uJjr2zk=
Received: from DM6PR10MB2523.namprd10.prod.outlook.com (2603:10b6:5:b2::27) by
 CH3PR10MB7395.namprd10.prod.outlook.com (2603:10b6:610:147::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44; Tue, 1 Aug 2023 17:00:02 +0000
Received: from DM6PR10MB2523.namprd10.prod.outlook.com
 ([fe80::7305:889d:4e5e:21ed]) by DM6PR10MB2523.namprd10.prod.outlook.com
 ([fe80::7305:889d:4e5e:21ed%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 17:00:02 +0000
Message-ID: <0050d9bc-f5b3-b8eb-9bc8-6a42e25bf618@oracle.com>
Date: Tue, 1 Aug 2023 13:00:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [Qemu-devel] [PATCH] acpi: Add emulated sleep button
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
References: <1500543086-26588-1-git-send-email-sf@sfritsch.de>
 <20170720165957.743ccf1a@nial.brq.redhat.com>
 <1a70f9be-e3ca-7311-a078-f55fe56ad0f3@oracle.com>
 <20210920095316.2dd133be@redhat.com>
 <8581b04d-5e9d-33e6-7918-d5f771dd2836@oracle.com>
 <20230714160419.5c2e1567@imammedo.users.ipa.redhat.com>
From: "Annie.li" <annie.li@oracle.com>
In-Reply-To: <20230714160419.5c2e1567@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:5:335::15) To DM6PR10MB2523.namprd10.prod.outlook.com
 (2603:10b6:5:b2::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB2523:EE_|CH3PR10MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8d2bb4-da06-490d-5bac-08db92b0bf48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5XD5WUUNOXAGcsejvhj7d22WjFLARUJCK6SV5YDreHhxguQjssk3iaaBcSXkZfFJEXyISozg/Qj4+CQcfm6Z6DK1THJF9DEceaFFuVd8ZWSOFMaYcUbLQsG+BJQmEBAw4ilGmqovcNOI+AxI8WWYQ5WMCNFJycfRwQxRDyAesbEhR9rtO/EXBQsZH3OkJr/s3vxQcEJr6kRUZGTi5k13jrj1qPtPu8VGVUfhyaXz5w2r4JKc5zbr/49UkOirOyN5icHXzb1tdP3I/R5tkitwjOGGFmOYymQF1ADrTEecYQaYib9nJ5jsuQl1KJyKf5gGUsplsCkSu4+bZnMg+gFkHRlGXByA/uSIqCJ2cjEVzpWQDGr0+Fybbphr93pj4BO2qhLTs8AzJWA23nZTuWaUpZbWKkAlXg15Tr8HYG0gA6QhdlzhNFkehmoFK8UoCedhR4xu/xMyR9k0/gAPDOs29nVh4eQzDgntg4flF+5xnIF+yblVn/ThtQE94ZSVw4FktZRav2NjkbY4XjMooi9kFU3Z0kAnoN9Xj81IjRHi177/ImLsZKvv4CVkMKNO6r/pV2wBMmCCIil8qL4e5nJ3yUW8eePLTKPzEq2MPLF/lW18HnSnPZl5JMv3mmdxp9o9/erAC2F/dVYnkmqkqf2Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB2523.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(36756003)(83380400001)(66946007)(66476007)(66556008)(316002)(4326008)(6916009)(8936002)(53546011)(8676002)(5660300002)(186003)(26005)(6506007)(478600001)(54906003)(45080400002)(31686004)(38100700002)(41300700001)(6486002)(6512007)(966005)(31696002)(30864003)(2906002)(2616005)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3c2cXlieWx2dExheVBhYS85Z2tBQXRxcDhpUWpDVmZ5OVViaURxWElnWHBz?=
 =?utf-8?B?M2d1SnpQQk8wWEs0aXhJZlRoTHpJOTNmengwQnNJR2JZUm4xK3pzMXBvU2E3?=
 =?utf-8?B?YVV2eHJyWWo3VUN1S2l6UkV2ZDhrcXRwS1IwcDl1M2tZVmp5QXIvS1FTM3ls?=
 =?utf-8?B?Sjhld1VpekF0ZXJGQWhoc2dCZmUyL2xvQlNKRVZyZ1Y1MUxWcDZ0RmM1eE9H?=
 =?utf-8?B?YkpuSytQbndHWFhmelYyV0RXQ2pZcHRIQ0gwbnZMWEZBNzRSN1ZzYnJIUHQ3?=
 =?utf-8?B?eCtRQjhvclN3cXdKd013cFBKcUdaUFdTOXlzSGVGRXV1eWdBTENVUzEyWXVs?=
 =?utf-8?B?SEtuS1FJVjFpTXdaRzFKUDBSZmJzd3VsMnYrNjJFS1JUNFJlRm1VT0pRRlh2?=
 =?utf-8?B?OEJiWTR3NjhFWTk1QTBYcWhWZ3RRL0swUEw0ZkVTY1FQNEdMQ2RUUmMwUyt1?=
 =?utf-8?B?Y0NjSnp2aThQUm1zU2srd0dBZEgrRnl0NWwyaXgrQ20wTXFYNVlhNEI4TXRu?=
 =?utf-8?B?dC9KRGVZbUlleEhZZ1M1a3diTzdab3hhcXJZTFRKeWhQaGFqSCtpYVhmWStq?=
 =?utf-8?B?cHRIVDRvbTBjRmtqVU5WWjgxd1NwYmVBOEZzZGo5ZCtKd3crcTFVQThSbU8y?=
 =?utf-8?B?bEl3RjRCdHN5bjBmb3VKR08rL2kvMTE4UWR0NlpISHZRZURobk5yc0ltTmNH?=
 =?utf-8?B?Z0FIT3BSUzlTLyttTXFyQ0duRTMwZE9nRjRacDFERU91MDZ5bEx5Q0x6aER2?=
 =?utf-8?B?TnNYOWg0MUpTeUtrQ1R5amZLNnZKdHdNdUN2ODRsdjJ1WmMrQ3lsQ0hNVkdu?=
 =?utf-8?B?dEhDYlBFVVFKdXVrRzJYN1ZlS2FJRFY1NUZPSkJjWjMvWDc2RXBUR0ZQTC9p?=
 =?utf-8?B?aitaWk1JVGNtbW1ZTmE1NklvdE1ibmt1cUY0MFFrb1VxelE5eWtXSzdqTzJ5?=
 =?utf-8?B?RkRBV2JLcUE5U25UakIxMWxWTlk4S3RwNGdjaHZ1VitrVlpGKzdCdk03bjY1?=
 =?utf-8?B?bWVMU2dTSVQzdTRjaDVNNCtxaTk5ZkRIbnM2Z3J1bllKbEc1M0xOcWk1VkIw?=
 =?utf-8?B?U2c1UHo4ZFVuNktHRTd4Z2h3aGpGYUFrYVNZNVNsMVkrZlVzSER5bDIxZlRC?=
 =?utf-8?B?RWE3S2VvaGtsVEU1T3JIbFh4Uk1UaG1ZQk9na3ZQbzlZeTBhaTdEeXJkNm5T?=
 =?utf-8?B?Y3ovZnVJQUYwR3NTdEdlUHJNZi9xb3JJdklkRWFOQkpOQU1MbmZhQ3FDMkcy?=
 =?utf-8?B?ci9xdFgzVmpIcWF4YTNrQzczOVpGdVFDRndmRGZyVXoyR0RiU1c0SXRBTXlU?=
 =?utf-8?B?WVlaSytDOC9DM1ZEdmxjZk55V2lPZXkxL0Nvb3N0MWNpUS83N2R6aFU3Nzdn?=
 =?utf-8?B?VmJwRloxUVF5SjNyZXhSMWF5M3pjbVlWZFpmOEtHRklYaUdiQ2hmZUZZL09O?=
 =?utf-8?B?MVJiT1NBNmdVUFovb0hDTmphYmNnWVdrZzNlNUxXRWk5T2dIS1Y2NTJHajNE?=
 =?utf-8?B?bTV0Ri9RS3ZtNkpNY1oyUHByYUZuc2IvZEpZVys4OFRvelBwdHhwdlVhR005?=
 =?utf-8?B?R3R0cVZ6bTFQY2pjNEsvOXpNS3FsaG5VVDhya01vU1Q0U09XQ2EzNWZUcS9t?=
 =?utf-8?B?K1I2d0RuUFVHUmczelI3R3hSVEpQc0huUk9mTTlJSkJzNEdyMFhzTnArZHRx?=
 =?utf-8?B?RmNjdCtqdFhqdDJPeURnbm1PZzI1bm1kdHNmU2QwUmFSTC9ZUm5HdVpFRVlQ?=
 =?utf-8?B?bENtU1c4cFpkWndVVUZyYVkzbkZxVG5Md0h5NExrWkljQm1DYU1aSEg0dG1r?=
 =?utf-8?B?NlhuMmdQVVpJNXQyV0J1dDZnM1FhNFRrbEI2c3dpeU5Md0UweDdsWHBkSUdr?=
 =?utf-8?B?RE83dWVva09KbWlqd1d2dnFkUHY0WmJCTEUzcGZWdFVBWmxzVmNhTXgzWTZp?=
 =?utf-8?B?SmEzR1dUSG1OZlZkZDJTc25CSTJ3TDlrcW5oK0hwUHgxYUtYc0ZGSGpZUDUr?=
 =?utf-8?B?Y2hVSndlYTVFUnhQQ2xHNkN0Z2VBZG5yaWRTUlF3eExNTy8wODMzVkNQUklK?=
 =?utf-8?B?YkpPTmhIYlM0VTNJTjZUT01kbVdpSnUzRlFYSUZEWE1TZ25VaFJ1N0lUT0t4?=
 =?utf-8?Q?cgTFW3AxMS+xjXhwxJJAbdPeL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EluU4wtWOHN03kSfU93+3NYvy+xZ0NJHt7x72kszue7UUGWbY9oFI1YxSl0JUtVA9pQowMew05r21PttmXL5J+bKzGj4DuQEF+JEQ/R9LmAJAFReYKfdo3HnnbHj6nW6HyEL/IUCkKCqX0bXj6vFQA3TsmrV4tFhbwJyLsvYMLaavKi/RXKCeTSiF6MLzc9a5/NdpJXaa10ZannrAmoht02wq15/QA7QrfcQjhZVdMkXtK0VdpcZ6gIoqGYLHMGEBjINS/ZKO/+szextpQnnekO9i7TAX7qyyyCW7+QZj5ZB/JhIVvXuZKZcoIBzz9uA4Isw/HEQBOHKJQTvqRGGPuV9klVYSflQz8YHmsm4pDI72l/lvJJEZ0hB0wbVU3rkrv9jqwLciCar5CoG0O/E6xTxwD2o4ofnWVMLtnIwslkHvb5Vh2dkU1xy+iwoZivrewYWBBJfvuB22hLjZ6jdIg2v47/J88nkploiVB2KhNG4s+oNFuxMoJVJvvpE+QPYrODyGIDv/5QuahknqtOaxAqAEModOfoDptf3WPjuE5qOhjBp5CkMjW3T9d9g+APo0om25cf+gzIEZfdAwqPzAU9IBRfPVflA/UkX8OgIYp4Q3YxTuEQ1k1nfhYenMLca+L3WaUmIYYVKUtua7tZNXOwPmQprhu9maDl24L1WYRvBH1zraLcTeFJlZ3fd1B/xaeuZ79E23vik5+wwwAy4Rhf/rdHVvI+iS31Rm/rl0CVaUP7AynOj/dofbiQyfCQa/kRB8e5J9L6Bw1zhc0+sO789W+LZLPK5WmcdlYuZu1CJi2L0Plobf45NJ/me+CEe57UggsIneSNfnHzfR1KkrA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8d2bb4-da06-490d-5bac-08db92b0bf48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2523.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 17:00:02.5836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5GjJRuas5PL+sSUSnCICXXUqsAaEEWen0sImRG6r6UiVySTTbEUTh6Dn9cwrWgOdG/3+5T+lsVh/mzf+Z6Wkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_14,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010154
X-Proofpoint-GUID: u7SHYXGenFZrk1LY9nArSANCojW7rCnR
X-Proofpoint-ORIG-GUID: u7SHYXGenFZrk1LY9nArSANCojW7rCnR
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Igor,

On 7/14/2023 10:04 AM, Igor Mammedov wrote:
> On Fri, 7 Jul 2023 13:43:36 -0400
> "Annie.li" <annie.li@oracle.com> wrote:
>
>> Hi Igor,
>>
>> Revisiting this thread and have more questions, please clarify, thank you!
>>
>> On 9/20/2021 3:53 AM, Igor Mammedov wrote:
>>> On Fri, 6 Aug 2021 16:18:09 -0400
>>> "Annie.li" <annie.li@oracle.com> wrote:
>>>   
>>>> Hello Igor,
>>>>
>>>> This is an old patch, but it does what we need.
>>>> I am getting a little bit lost about not implementing fixed hardware
>>>> sleep button, can you please clarify? thank you!
>>>>
>>>> On 7/20/2017 10:59 AM, Igor Mammedov wrote:
>>>>> On Thu, 20 Jul 2017 11:31:26 +0200
>>>>> Stefan Fritsch <sf@sfritsch.de> wrote:
>>>>>      
>>>>>> From: Stefan Fritsch <stefan_fritsch@genua.de>
>>>>>>
>>>>>> Add an ACPI sleep button and QMP/HMP commands to trigger it.  A sleep
>>>>>> button is a so called "fixed hardware feature", which makes it more
>>>>>> suitable for putting the system to sleep than a laptop lid, for example.
>>>>>>
>>>>>> The sleep button is disabled by default (Bit 5 in the FACP flags
>>>>>> register set and no button "device" present in SSDT/DSDT). Clearing said
>>>>>> bit enables it as a fixed feature device.
>>>>> per spec sleep button is used for both putting system into
>>>>> sleep and for waking it up.
>>>>>
>>>>> Reusing system_wakeup 'button' to behave as per spec would
>>>>> make this patch significantly smaller.
>> Current 'system_wakeup' sets the WAK_STS bit and PWRBTN_STS to wake up
>> the system, the system_wakeup 'button' is the power button. So(Correct me
>> if I am wrong) reusing the system_wakeup 'button' means reusing the power
>> button for sleep. See the following code of setting WAK_STS and PWRBTN_STS
>> for 'system_wakeup',
>>       case QEMU_WAKEUP_REASON_OTHER:
>>           /* ACPI_BITMASK_WAKE_STATUS should be set on resume.
>>              Pretend that resume was caused by power button */
>>           ar->pm1.evt.sts |=
>>               (ACPI_BITMASK_WAKE_STATUS | ACPI_BITMASK_POWER_BUTTON_STATUS);
> (that's quite ancient code (0bacd1300d) and I couldn't find a reason why
> power button was chosen.
>   https://urldefense.com/v3/__https://www.mail-archive.com/kvm@vger.kernel.org/msg05742.html__;!!ACWV5N9M2RV99hQ!PQp9_UyWYc4gTuTwNUiyPgE0Xwinlsi8F-J6zWOA8KRLUh0EIv68g01XQQrFzKipeZbe-vhHfpGZBb0$
> that was tested with WinXP so would be wise to check if SLEEP button
> works there. (though I'm not sure if we still care for XP being runnable on QEMU)
> )

don't have WinXP at hand to check for now...
Microsoft has ended the WinXP support since Apr 8, 2014.
If someone is still running WinXP, not sure if they care about
the sleep button.
>
> it doesn't have to be ACPI_BITMASK_POWER_BUTTON_STATUS,
> you can convert it to sleep button by using ACPI_BITMASK_SLEEP_BUTTON_STATUS.
> However you'll have to enable sleep button (which is disabled currently)
> in FADT (ACPI_FADT_F_SLP_BUTTON), for guest to see the button.
Agree
Per ACPI spec, SLPBTN_STS -

"This optional bit is set when the sleep button is pressed. In the system
working state, while SLPBTN_EN and SLPBTN_STS are both set, an
interrupt event is raised. In the sleep or soft-off states a wake event is
generated when the sleeping button is pressed and the SLPBTN_EN bit
is set."

Using ACPI_BITMASK_SLEEP_BUTTON_STATUS means qemu ends up with
supporting the sleep button.  With this, implementing the fixed
hardware sleep button(what this patch does) is one option. The interesting
topic is whether it should be implemented as General Control sleep button
or fixed hardware button.

>
>>           break;
>>
>> Per the ACPI spec, the power button can be used in single button model, i.e.
>> it can be used to either shut down the system or put the system into sleep.
>> However, this depends on the software policy and user's setting of the
>> system.
>> Sleep/shutdown can not be done through the power button in the same
>> scenario.
>> If the system has configured pressing the power button to put the system
>> into sleep,
>> system_sleep will put the system into sleep state through the power
>> button, as well
>> as system_powerdown. Pressing the power button will not shut down the
>> system.
>> In this case, system_powerdown has its own issue, but this is different
>> story and
>> let's just focus on things related to system_sleep here.
> regardless of what button is used OSPM is free to enable or disable it
> using FOO_EN bits.

Nod
The system_powerdown issue I mentioned above is -
If the guest is configured to go into sleep when the power button is
pressed, system_powerdown will trigger the guest to go into sleep state.
However, system_wakeup won't be able to wake up the guest in such case.
Looks the current qemu doesn't handle this scenario properly.
>>>> About reusing "system_wakeup", does it mean the following?
>>>>
>>>> 1. when guest is in sleep state, "system_wakeup" wakes up the guest
>>>> 2. when guest is running, "system_wakeup" puts the guest into sleep
>>> yes,  it could be something like this
>>>
>>>   
>>>> "system_wakeup" sets WAK_STS and then system transitions to the
>>>> working state. Correspondingly, I suppose both SLPBTN_STS and
>>>> SLPBTN_EN need to be set for sleeping, and this is what fixed
>>>> hardware sleep button requires?
>>> yep
>>>      
>>>> I have combined the sleep and wakeup together, share the
>>>> code between. But Xen also registers the wakeup notifier, and
>>>> this makes things more complicated if this notifier is shared
>>>> between sleep and wakeup. Or this is my misunderstanding?
>>>> please correct me if I am wrong.
>>> you'd have to fixup xen notifier to handle that
>>>      
>>>>> If you like idea of separate command/button better, then
>>>>> I'd go generic control sleep button way instead of fixed
>>>>> hardware, it would allow us to reuse most of the code in
>>>>> ARM target, plus I'd avoid notifiers and use acpi device
>>>>> lookup instead (see: qmp_query_acpi_ospm_status as example)
>    
>> Implementing the generic control sleep button for x86 does align
>> to the generic control power button implementation in ARM, but
>> it doesn't align to the current fixed hardware power button for x86.
>> Should sleep button be implemented as generic control sleep button
>> to reuse code in ARM or fixed hardware button to align to the fixed
>> power button for x86?
> sleep control button device was present in ACPI 1.0b so it might be
> supported by x86 as well (one just need to test it with ancient OS
> to find out if it were implemented. (WinXP,Vista,some ancient linux...))

If qemu needs to cover the ancient OS, isn't the fixed sleep hardware
button more appropriate?
How about qemu uses fixed sleep button for x86(just like what this
patch does), and share the sleep button for between wake-up and sleep?
The power button has been implemented as fixed hardware button for x86.

Thanks
Annie

>>>>>      
>>>> Do you mean the "Control Method Sleep Button" that needs to
>>>> notify OSPM by event indication 0x80?
>>> yes, in addition to virt-arm machine it could be reused by
>>> microvm which also uses 'reduced hardware' acpi model
>>> (i.e. it lacks fixed hardware registers like virt-arm does)
>>>
>>> maybe while adding button to pc/q35 you can look into adding
>>> it to microvm and virt-arm at the same time (should be trivial
>>> on top of pc/q35 support).
>>>   
>>>> Thanks
>>>> Annie
>>>>>> Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
>>>>>> ---
>>>>>>     hmp-commands.hx         | 16 ++++++++++++++++
>>>>>>     hmp.c                   |  5 +++++
>>>>>>     hmp.h                   |  1 +
>>>>>>     hw/acpi/core.c          |  8 ++++++++
>>>>>>     hw/acpi/ich9.c          | 10 ++++++++++
>>>>>>     hw/acpi/piix4.c         | 12 ++++++++++++
>>>>>>     hw/i386/acpi-build.c    |  1 -
>>>>>>     include/hw/acpi/acpi.h  |  2 ++
>>>>>>     include/hw/acpi/ich9.h  |  1 +
>>>>>>     include/sysemu/sysemu.h |  2 ++
>>>>>>     qapi-schema.json        | 12 ++++++++++++
>>>>>>     qmp.c                   |  5 +++++
>>>>>>     tests/test-hmp.c        |  1 +
>>>>>>     vl.c                    | 29 +++++++++++++++++++++++++++++
>>>>>>     14 files changed, 104 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>>>>>> index 1941e19932..8ba4380883 100644
>>>>>> --- a/hmp-commands.hx
>>>>>> +++ b/hmp-commands.hx
>>>>>> @@ -638,6 +638,22 @@ Reset the system.
>>>>>>     ETEXI
>>>>>>     
>>>>>>         {
>>>>>> +        .name       = "system_sleep",
>>>>>> +        .args_type  = "",
>>>>>> +        .params     = "",
>>>>>> +        .help       = "send ACPI sleep event",
>>>>>> +        .cmd = hmp_system_sleep,
>>>>>> +    },
>>>>>> +
>>>>>> +STEXI
>>>>>> +@item system_sleep
>>>>>> +@findex system_sleep
>>>>>> +
>>>>>> +Push the virtual sleep button; if supported the system will enter
>>>>>> +an ACPI sleep state.
>>>>>> +ETEXI
>>>>>> +
>>>>>> +    {
>>>>>>             .name       = "system_powerdown",
>>>>>>             .args_type  = "",
>>>>>>             .params     = "",
>>>>>> diff --git a/hmp.c b/hmp.c
>>>>>> index bf1de747d5..b4b584016c 100644
>>>>>> --- a/hmp.c
>>>>>> +++ b/hmp.c
>>>>>> @@ -1047,6 +1047,11 @@ void hmp_system_reset(Monitor *mon, const QDict *qdict)
>>>>>>         qmp_system_reset(NULL);
>>>>>>     }
>>>>>>     
>>>>>> +void hmp_system_sleep(Monitor *mon, const QDict *qdict)
>>>>>> +{
>>>>>> +    qmp_system_sleep(NULL);
>>>>>> +}
>>>>>> +
>>>>>>     void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
>>>>>>     {
>>>>>>         qmp_system_powerdown(NULL);
>>>>>> diff --git a/hmp.h b/hmp.h
>>>>>> index 1ff455295e..15b53de9ed 100644
>>>>>> --- a/hmp.h
>>>>>> +++ b/hmp.h
>>>>>> @@ -45,6 +45,7 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict);
>>>>>>     void hmp_quit(Monitor *mon, const QDict *qdict);
>>>>>>     void hmp_stop(Monitor *mon, const QDict *qdict);
>>>>>>     void hmp_system_reset(Monitor *mon, const QDict *qdict);
>>>>>> +void hmp_system_sleep(Monitor *mon, const QDict *qdict);
>>>>>>     void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
>>>>>>     void hmp_cpu(Monitor *mon, const QDict *qdict);
>>>>>>     void hmp_memsave(Monitor *mon, const QDict *qdict);
>>>>>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>>>>>> index 95fcac95a2..2ee64b6878 100644
>>>>>> --- a/hw/acpi/core.c
>>>>>> +++ b/hw/acpi/core.c
>>>>>> @@ -422,6 +422,14 @@ void acpi_pm1_evt_power_down(ACPIREGS *ar)
>>>>>>         }
>>>>>>     }
>>>>>>     
>>>>>> +void acpi_pm1_evt_sleep(ACPIREGS *ar)
>>>>>> +{
>>>>>> +    if (ar->pm1.evt.en & ACPI_BITMASK_SLEEP_BUTTON_ENABLE) {
>>>>>> +        ar->pm1.evt.sts |= ACPI_BITMASK_SLEEP_BUTTON_STATUS;
>>>>>> +        ar->tmr.update_sci(ar);
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>>     void acpi_pm1_evt_reset(ACPIREGS *ar)
>>>>>>     {
>>>>>>         ar->pm1.evt.sts = 0;
>>>>>> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
>>>>>> index c5d8646abc..3faeab4d2e 100644
>>>>>> --- a/hw/acpi/ich9.c
>>>>>> +++ b/hw/acpi/ich9.c
>>>>>> @@ -260,6 +260,14 @@ static void pm_reset(void *opaque)
>>>>>>         acpi_update_sci(&pm->acpi_regs, pm->irq);
>>>>>>     }
>>>>>>     
>>>>>> +static void pm_sleep_req(Notifier *n, void *opaque)
>>>>>> +{
>>>>>> +    ICH9LPCPMRegs *pm = container_of(n, ICH9LPCPMRegs, sleep_notifier);
>>>>>> +
>>>>>> +    acpi_pm1_evt_sleep(&pm->acpi_regs);
>>>>>> +}
>>>>>> +
>>>>>> +
>>>>>>     static void pm_powerdown_req(Notifier *n, void *opaque)
>>>>>>     {
>>>>>>         ICH9LPCPMRegs *pm = container_of(n, ICH9LPCPMRegs, powerdown_notifier);
>>>>>> @@ -299,6 +307,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm,
>>>>>>         qemu_register_reset(pm_reset, pm);
>>>>>>         pm->powerdown_notifier.notify = pm_powerdown_req;
>>>>>>         qemu_register_powerdown_notifier(&pm->powerdown_notifier);
>>>>>> +    pm->sleep_notifier.notify = pm_sleep_req;
>>>>>> +    qemu_register_sleep_notifier(&pm->sleep_notifier);
>>>>>>     
>>>>>>         legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
>>>>>>             OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
>>>>>> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>>>>>> index f276967365..15e20976c3 100644
>>>>>> --- a/hw/acpi/piix4.c
>>>>>> +++ b/hw/acpi/piix4.c
>>>>>> @@ -79,6 +79,7 @@ typedef struct PIIX4PMState {
>>>>>>         int smm_enabled;
>>>>>>         Notifier machine_ready;
>>>>>>         Notifier powerdown_notifier;
>>>>>> +    Notifier sleep_notifier;
>>>>>>     
>>>>>>         AcpiPciHpState acpi_pci_hotplug;
>>>>>>         bool use_acpi_pci_hotplug;
>>>>>> @@ -371,6 +372,15 @@ static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
>>>>>>         acpi_pm1_evt_power_down(&s->ar);
>>>>>>     }
>>>>>>     
>>>>>> +static void piix4_pm_sleep_req(Notifier *n, void *opaque)
>>>>>> +{
>>>>>> +    PIIX4PMState *s = container_of(n, PIIX4PMState, sleep_notifier);
>>>>>> +
>>>>>> +    assert(s != NULL);
>>>>>> +    acpi_pm1_evt_sleep(&s->ar);
>>>>>> +}
>>>>>> +
>>>>>> +
>>>>>>     static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
>>>>>>                                      DeviceState *dev, Error **errp)
>>>>>>     {
>>>>>> @@ -535,6 +545,8 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
>>>>>>     
>>>>>>         s->powerdown_notifier.notify = piix4_pm_powerdown_req;
>>>>>>         qemu_register_powerdown_notifier(&s->powerdown_notifier);
>>>>>> +    s->sleep_notifier.notify = piix4_pm_sleep_req;
>>>>>> +    qemu_register_sleep_notifier(&s->sleep_notifier);
>>>>>>     
>>>>>>         s->machine_ready.notify = piix4_pm_machine_ready;
>>>>>>         qemu_add_machine_init_done_notifier(&s->machine_ready);
>>>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>>>>> index 6b7bade183..06b28dacfe 100644
>>>>>> --- a/hw/i386/acpi-build.c
>>>>>> +++ b/hw/i386/acpi-build.c
>>>>>> @@ -294,7 +294,6 @@ static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
>>>>>>         fadt->plvl3_lat = cpu_to_le16(0xfff); /* C3 state not supported */
>>>>>>         fadt->flags = cpu_to_le32((1 << ACPI_FADT_F_WBINVD) |
>>>>>>                                   (1 << ACPI_FADT_F_PROC_C1) |
>>>>>> -                              (1 << ACPI_FADT_F_SLP_BUTTON) |
>>>>>>                                   (1 << ACPI_FADT_F_RTC_S4));
>>>>>>         fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_USE_PLATFORM_CLOCK);
>>>>>>         /* APIC destination mode ("Flat Logical") has an upper limit of 8 CPUs
>>>>>> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
>>>>>> index 7b3d93cf0d..51cf901ef6 100644
>>>>>> --- a/include/hw/acpi/acpi.h
>>>>>> +++ b/include/hw/acpi/acpi.h
>>>>>> @@ -78,6 +78,7 @@
>>>>>>     #define ACPI_BITMASK_PM1_COMMON_ENABLED         ( \
>>>>>>             ACPI_BITMASK_RT_CLOCK_ENABLE        | \
>>>>>>             ACPI_BITMASK_POWER_BUTTON_ENABLE    | \
>>>>>> +        ACPI_BITMASK_SLEEP_BUTTON_ENABLE    | \
>>>>>>             ACPI_BITMASK_GLOBAL_LOCK_ENABLE     | \
>>>>>>             ACPI_BITMASK_TIMER_ENABLE)
>>>>>>     
>>>>>> @@ -148,6 +149,7 @@ void acpi_pm_tmr_reset(ACPIREGS *ar);
>>>>>>     /* PM1a_EVT: piix and ich9 don't implement PM1b. */
>>>>>>     uint16_t acpi_pm1_evt_get_sts(ACPIREGS *ar);
>>>>>>     void acpi_pm1_evt_power_down(ACPIREGS *ar);
>>>>>> +void acpi_pm1_evt_sleep(ACPIREGS *ar);
>>>>>>     void acpi_pm1_evt_reset(ACPIREGS *ar);
>>>>>>     void acpi_pm1_evt_init(ACPIREGS *ar, acpi_update_sci_fn update_sci,
>>>>>>                            MemoryRegion *parent);
>>>>>> diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
>>>>>> index a352c94fde..2073eec168 100644
>>>>>> --- a/include/hw/acpi/ich9.h
>>>>>> +++ b/include/hw/acpi/ich9.h
>>>>>> @@ -48,6 +48,7 @@ typedef struct ICH9LPCPMRegs {
>>>>>>     
>>>>>>         uint32_t pm_io_base;
>>>>>>         Notifier powerdown_notifier;
>>>>>> +    Notifier sleep_notifier;
>>>>>>     
>>>>>>         bool cpu_hotplug_legacy;
>>>>>>         AcpiCpuHotplug gpe_cpu;
>>>>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>>>>>> index b21369672a..00f54653dc 100644
>>>>>> --- a/include/sysemu/sysemu.h
>>>>>> +++ b/include/sysemu/sysemu.h
>>>>>> @@ -75,6 +75,8 @@ void qemu_register_wakeup_notifier(Notifier *notifier);
>>>>>>     void qemu_system_shutdown_request(ShutdownCause reason);
>>>>>>     void qemu_system_powerdown_request(void);
>>>>>>     void qemu_register_powerdown_notifier(Notifier *notifier);
>>>>>> +void qemu_system_sleep_request(void);
>>>>>> +void qemu_register_sleep_notifier(Notifier *notifier);
>>>>>>     void qemu_system_debug_request(void);
>>>>>>     void qemu_system_vmstop_request(RunState reason);
>>>>>>     void qemu_system_vmstop_request_prepare(void);
>>>>>> diff --git a/qapi-schema.json b/qapi-schema.json
>>>>>> index 8b015bee2e..c6ccfcd70f 100644
>>>>>> --- a/qapi-schema.json
>>>>>> +++ b/qapi-schema.json
>>>>>> @@ -2314,6 +2314,18 @@
>>>>>>     { 'command': 'system_reset' }
>>>>>>     
>>>>>>     ##
>>>>>> +# @system_sleep:
>>>>>> +#
>>>>>> +# Requests that a guest perform a ACPI sleep transition by pushing a virtual
>>>>>> +# sleep button.
>>>>>> +#
>>>>>> +# Notes: A guest may or may not respond to this command.  This command
>>>>>> +#        returning does not indicate that a guest has accepted the request or
>>>>>> +#        that it has gone to sleep.
>>>>>> +##
>>>>>> +{ 'command': 'system_sleep' }
>>>>>> +
>>>>>> +##
>>>>>>     # @system_powerdown:
>>>>>>     #
>>>>>>     # Requests that a guest perform a powerdown operation.
>>>>>> diff --git a/qmp.c b/qmp.c
>>>>>> index b86201e349..bc1f2e3d7f 100644
>>>>>> --- a/qmp.c
>>>>>> +++ b/qmp.c
>>>>>> @@ -108,6 +108,11 @@ void qmp_system_reset(Error **errp)
>>>>>>         qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP);
>>>>>>     }
>>>>>>     
>>>>>> +void qmp_system_sleep(Error **erp)
>>>>>> +{
>>>>>> +    qemu_system_sleep_request();
>>>>>> +}
>>>>>> +
>>>>>>     void qmp_system_powerdown(Error **erp)
>>>>>>     {
>>>>>>         qemu_system_powerdown_request();
>>>>>> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
>>>>>> index d77b3c8710..3fa850bf1e 100644
>>>>>> --- a/tests/test-hmp.c
>>>>>> +++ b/tests/test-hmp.c
>>>>>> @@ -67,6 +67,7 @@ static const char *hmp_cmds[] = {
>>>>>>         "sum 0 512",
>>>>>>         "x /8i 0x100",
>>>>>>         "xp /16x 0",
>>>>>> +    "system_sleep",
>>>>>>         NULL
>>>>>>     };
>>>>>>     
>>>>>> diff --git a/vl.c b/vl.c
>>>>>> index fb6b2efafa..6a0f847dcf 100644
>>>>>> --- a/vl.c
>>>>>> +++ b/vl.c
>>>>>> @@ -1608,6 +1608,7 @@ static ShutdownCause reset_requested;
>>>>>>     static ShutdownCause shutdown_requested;
>>>>>>     static int shutdown_signal;
>>>>>>     static pid_t shutdown_pid;
>>>>>> +static int sleep_requested;
>>>>>>     static int powerdown_requested;
>>>>>>     static int debug_requested;
>>>>>>     static int suspend_requested;
>>>>>> @@ -1618,6 +1619,8 @@ static NotifierList suspend_notifiers =
>>>>>>         NOTIFIER_LIST_INITIALIZER(suspend_notifiers);
>>>>>>     static NotifierList wakeup_notifiers =
>>>>>>         NOTIFIER_LIST_INITIALIZER(wakeup_notifiers);
>>>>>> +static NotifierList sleep_notifiers =
>>>>>> +    NOTIFIER_LIST_INITIALIZER(sleep_notifiers);
>>>>>>     static uint32_t wakeup_reason_mask = ~(1 << QEMU_WAKEUP_REASON_NONE);
>>>>>>     
>>>>>>     ShutdownCause qemu_shutdown_requested_get(void)
>>>>>> @@ -1838,6 +1841,24 @@ static void qemu_system_powerdown(void)
>>>>>>         notifier_list_notify(&powerdown_notifiers, NULL);
>>>>>>     }
>>>>>>     
>>>>>> +static void qemu_system_sleep(void)
>>>>>> +{
>>>>>> +    notifier_list_notify(&sleep_notifiers, NULL);
>>>>>> +}
>>>>>> +
>>>>>> +static int qemu_sleep_requested(void)
>>>>>> +{
>>>>>> +    int r = sleep_requested;
>>>>>> +    sleep_requested = 0;
>>>>>> +    return r;
>>>>>> +}
>>>>>> +
>>>>>> +void qemu_system_sleep_request(void)
>>>>>> +{
>>>>>> +    sleep_requested = 1;
>>>>>> +    qemu_notify_event();
>>>>>> +}
>>>>>> +
>>>>>>     void qemu_system_powerdown_request(void)
>>>>>>     {
>>>>>>         trace_qemu_system_powerdown_request();
>>>>>> @@ -1850,6 +1871,11 @@ void qemu_register_powerdown_notifier(Notifier *notifier)
>>>>>>         notifier_list_add(&powerdown_notifiers, notifier);
>>>>>>     }
>>>>>>     
>>>>>> +void qemu_register_sleep_notifier(Notifier *notifier)
>>>>>> +{
>>>>>> +    notifier_list_add(&sleep_notifiers, notifier);
>>>>>> +}
>>>>>> +
>>>>>>     void qemu_system_debug_request(void)
>>>>>>     {
>>>>>>         debug_requested = 1;
>>>>>> @@ -1899,6 +1925,9 @@ static bool main_loop_should_exit(void)
>>>>>>         if (qemu_powerdown_requested()) {
>>>>>>             qemu_system_powerdown();
>>>>>>         }
>>>>>> +    if (qemu_sleep_requested()) {
>>>>>> +        qemu_system_sleep();
>>>>>> +    }
>>>>>>         if (qemu_vmstop_requested(&r)) {
>>>>>>             vm_stop(r);
>>>>>>         }
>>>   

