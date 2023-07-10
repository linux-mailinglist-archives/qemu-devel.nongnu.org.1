Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EABA74D99E
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:12:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsXW-0005SN-Hb; Mon, 10 Jul 2023 11:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qIsXS-0005SD-6V
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:10:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qIsXO-0004Jg-QD
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:10:57 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36AAO2Cw014570; Mon, 10 Jul 2023 15:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=TGXcfq+tG4yLaERfptaSjva3LdSewbaEvCHuWKXvcMQ=;
 b=hCA6Q0gVdC9FIfkGUBsRJSEOyKlLQRUCfBZpqyd6IWxODW6HacftpCReWP4R9WE664bz
 eBVZVrL0Th4kQ1QDjrrxlGeQhiniu6rlD/SLHZ2JGf+ivaYUYG04h2O6xyCRGICbxVXR
 eAC5T54KPTPVcJ2k7IslLIkvcMbu/JzHyJk1433iwZb5IqtaZU+KVfKuy7dzanmFJOjG
 TMQB+h+B0r809wXXuLPLKKKbhhg3jCLVDIFZa15n7oSImSPnMk+qxDBEDfCc5ZTU3ZpH
 6mrDD9iX5C6VgP6rro2uXdrNxwljj/tObSZBZI/I0dZaiqtTOshaPci0XQ5+Sb9g7MTA FA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrea2rs18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jul 2023 15:10:13 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36AEYlBk027307; Mon, 10 Jul 2023 15:10:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rpx83kh05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jul 2023 15:10:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUdMqVo1eZEWkKVxFQSBeK6PPOZQjGZKe+AcVzu1NNxl12usypmi6SC/CAGmS0Ir3B8BdXKQ3tmuSzE0zxFCNIntHbO5/gm2tax/YFA8hDT/fVZP+qBsMw/t76k2tyA/i3xr2y3qbc2XyhuJ4Ike/YJzofquFoMgyPQ8miXLxBFPMzh274l5LIupRcxEy5UNau9YHgA9sfMBWmAXBwvRYEAT8bPzdqzH7kWiASIg5BjUvhAaam1QCEV96GwruTLDms5ESKq/a7ktWx0vwYKhh1MKRjXSmb1z+ZTCagA53QcW1JL6wLfCX5ewZObtw5FMEj70KkQH/+bBZ+wt1vePLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGXcfq+tG4yLaERfptaSjva3LdSewbaEvCHuWKXvcMQ=;
 b=b30sJmHM5llZUEj+bu/LzPiLw1m1OJugmyo0IH/0Nh/FFMJhT7eDVnwrla4XhzXTiR/7IAEr6yTqyU4HqnN/WoVjkx5BJcAmyQPwpFTFkqI0DcVoknjYrlgvW4PjcPnTAOjpsplOPuIn1oAze1Ospp2RZpFTgaYx6jLwSbp3Wu3+t2Pn4CFlD6w/YgUhWB9KuKowvDVULlKkB/IRRVb18zOjRiZNAeW5T07TSqVzabrQ2KeQ/MjRcjePdqr2/fmpn/vvR0hNyGoF3l5N8rU6TLyYMmR3/TFJJR75CMcBTrw/yLcB8ahQYacixYqQvUz+YY8oKLJMxrvkwa+2TqAtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGXcfq+tG4yLaERfptaSjva3LdSewbaEvCHuWKXvcMQ=;
 b=mPIyJWsLzyngElkgkh23RfSWT7nenQO6I/7wBPzs4Ei0Y4J9C5LCJT0OPPqd5TJW4j0bVyei/ENCqxuwuAfOzQM8jsI4W0bQ4i3gHJhf3+UgDQw+pHJKN7BVUn5MTV/lq70fGvDe8TPWJ1wO3iHXGv5PNSF/UJm7JMiVp+WAeUE=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CO1PR10MB4433.namprd10.prod.outlook.com (2603:10b6:303:6e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 15:10:09 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 15:10:09 +0000
Message-ID: <2f6c228f-702a-1c61-7278-0870c0f5d6b2@oracle.com>
Date: Mon, 10 Jul 2023 11:10:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V9 00/46] Live Update
Content-Language: en-US
To: Michael Galaxy <mgalaxy@akamai.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Jason Zeng <jason.zeng@linux.intel.com>, Zheng Chuan
 <zhengchuan@huawei.com>,
 Mark Kanda <mark.kanda@oracle.com>, Guoyi Tu <tugy@chinatelecom.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philippe.mathieu.daude@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 David Hildenbrand <david@redhat.com>, John Snow <jsnow@redhat.com>,
 Peng Liang <tcx4c70@gmail.com>, "Hunt, Joshua" <johunt@akamai.com>
References: <1658851843-236870-1-git-send-email-steven.sistare@oracle.com>
 <53075574-9e73-f773-ccb1-cca42a719801@oracle.com>
 <ada81103-d4eb-dd02-45a8-176dae06d26c@akamai.com>
 <c4f8a36f-53e6-9d88-f542-bcbcf5deabd4@akamai.com>
 <2ed16545-c0f0-0103-a1e0-03fcc49959e1@oracle.com>
 <f9c3117e-3dc5-03fa-8fcd-4092660e44fc@akamai.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <f9c3117e-3dc5-03fa-8fcd-4092660e44fc@akamai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::15) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CO1PR10MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 296bca96-b7bc-4605-12af-08db8157c06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3nLmPJBRlHOSaWQGE3I0XPbKpQ3CWLxbatT4bMKaUgfyK/YciqVyycFDmB363aG31D0jH6nN3e+b511ln8COl5VAwBRFhJVGIBWxSd4a11pmVUfvem4qfrHsVVaS38ympo4u65tXmcy1oNTh2nQPXM/qc+o3Z9q5gX+sqQevu8Ygbjic6uKr8cyiPYL0BbRnoWrQoUjXSSjq3k4bXu0LEHOsfyVUib6yxcO2IIC0aQ95o+AHABqvnWVVH4lxuBDB31XWJ8V7tQEGXaxk/UAtNRjScvwjrcpt2DRMH+rCAp/MFn7QAGEcMORCYVLNA0yS1EW6DjuIwGIuua8BPFA50snNUvJFnBBHVuOGIz7M0HgXfXzMNpodSxALwWbQxNAip5LCHGXsKNwzd3KIAUNatGWRYZ4mlJxN4kyNM7+dZ80JZwPO77mK+s0I8osrmlwLl0SaYnP5/tbYznpApxBdRzM0oJiinbltFRDTeOFtMgtLD5yYmY2FIKanGolpqGwRq862WeLodHVtOxLWyyenPlMnN4bml1/mj3aSyMwaxRFJq2wAsXznseKq5kwacDFHMExZjjzKV2hACF7cJfVUNvAu+H7IA8os0F2A59qreAmaB40tmFVEorKUnkHSuTLcolAyL9P4XRt9eG1CwqUJlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(6666004)(6486002)(478600001)(83380400001)(26005)(2616005)(6506007)(186003)(36756003)(53546011)(6512007)(36916002)(316002)(2906002)(41300700001)(38100700002)(66476007)(66946007)(66556008)(4326008)(44832011)(86362001)(7416002)(31696002)(8676002)(8936002)(15650500001)(31686004)(5660300002)(110136005)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDh0RnVPYTdzOTFXMkYxTFV5QU16aGdXUjN5MjBzUGQwRFJpejJYU2V5S0Fm?=
 =?utf-8?B?RHRXWFVTK1lUSVJUamxlakxGWHNvL2kxbkJ1VEVzdGc3elZrY2VQVTRBejI1?=
 =?utf-8?B?S04yY0NwMk5zVTIrMWNVSEJ1K093TjRWalpqRjJsakxORW90VGFZNWxLNHFG?=
 =?utf-8?B?K3VFMlJIdFgzNVlqbDMwSGNqQ2dWeXpCTU83TDg4dmZPcnBNMjhZNlFRSTM3?=
 =?utf-8?B?aS9lOW5xYW5QZUZPbVNmK3ZmekpaQ1owdSt0MkFDRmpZbzgreXBIVHdrVEJB?=
 =?utf-8?B?ME11TmhxaHZuR1cxUzkxcWd5aWwxSUhuam5uL0NhV3F6ZmRua0p6OG1NY29L?=
 =?utf-8?B?M1Z5MC9oKzlCQmFJY3BoNzNQdzVkeHBmQXFEQTg1V2ovODRrdWVOSDh5Vjcy?=
 =?utf-8?B?Yi9HWkp5N3dPM1NkTUtSTEdjbk9Ra3VEWXBnY1NBbitrTCtwZllkV1lKZTM0?=
 =?utf-8?B?NnNFSFQ0YXBWQWxCWjBCTUZmSDEvM1JVOTBoMXk5bnRHL3Ywc3NEZ1RaSnZG?=
 =?utf-8?B?NXRBWUdTYWFEdjRodG12dDluMVlMeUp2NEJHRkZQK0hVTUJIT0RFb3dMS1hu?=
 =?utf-8?B?UXdYR3lvR05KeHN0TlBOZURjUnZVWG9vaUV6NFZSb1QyRUtPUE5mVFhmVHB6?=
 =?utf-8?B?RmdURXNGTEhyMWZ2WjNheXFkMjYwOEtYaWhWWGRvTm5FcXNmY1paQ2I2M3Ir?=
 =?utf-8?B?Q25wSVMxU0lYcnlOTFd5ek9hRmVTd0JrdUNxL2g4dE9nM0Q4QWVFbWJuRXU2?=
 =?utf-8?B?YVk4Z3NkZXRWRGpKV2NkYTduMHJLVnNVSjdjV3ozL0ZaNzNwU2FnSzJhOEpY?=
 =?utf-8?B?UzhRVlBoRXg5WFNlalhlZy92VjR0M2RSOWpHK2dTRmVBcjZtb1JacmFvaTJk?=
 =?utf-8?B?S29mWDVxYnFKY2wrU1djaTJjaTRjK05zKzl5TjI2d0VwbUpVS0FvOThWc2Fr?=
 =?utf-8?B?VkFSWnorMjVsRU9RN1hwV3JPL3BHOEJlbytlaDljbkt3T3IyU1hLNUphbDVR?=
 =?utf-8?B?WjRDREZZalM2TXdEbVVCNFE4Z3R1S2Q5MkJCUllpWVBab1ZWS2JSaVB6Q0dn?=
 =?utf-8?B?aHQzTkFKOWxzbElDN1ZMV1U1RzYrZlovS1g5NXViTVR2TUdQSTZscWljM1Rs?=
 =?utf-8?B?SnlJSmh5L0tHNjRVN2w1WU9CMXg2RDhabUdaVjAwOGN1Q3RWeUJjSktnY3l2?=
 =?utf-8?B?NXBkR2w0Z1pSdWlUaHZUeW4zSkJNb1Jtc3UzcWE3bkhOam16U2x4VU5yS0dU?=
 =?utf-8?B?M2ZuR1FKUEF5MEJDMitiTFk4RGswZVRsUVBTYVhDMmxSNkszWitHYTVlNnIw?=
 =?utf-8?B?VlkyVjFGb3hqZk9CUEluNERvWkZ2YWEyT0s4NS9IWkF1NlA5Nkx1bURzTmJZ?=
 =?utf-8?B?VitGdnROaENGNmxhRjlodlA0QU9IUitQZWMzM2FpdVhLbURjNDV5bzQ5bjd6?=
 =?utf-8?B?d2wwbXJiR1VoNjRCcHlkc0E2enlBOTZ3QW9qaHFkc25waU82RC9SN2wrYU9P?=
 =?utf-8?B?blh3elNYdktsM0NOalhEb0V5N0t5ZmU2NmJVQkJCYVVaeWk3NVV5VFpid1ph?=
 =?utf-8?B?Q3Y3Y3FLcGFrVmZKVGhsWkZZQ3NrMzBvaktlblBhWG9tZG1Ec1B2WjgzNFhq?=
 =?utf-8?B?bCt6YXd3QWFhczlPVkNVWmJxalp5aUJrZjROU09QMDZWZGN2Zm1PMm9VbjIx?=
 =?utf-8?B?RWF4cmo5NkhVNjUrSHp2c09kUFNJbHNMZFFTWWdLVklEZ0tBNWJsczhJVHFR?=
 =?utf-8?B?SXhQT3NZU1htYTFUdGFtNStGeW9MU2doNjVJd2hKdGtsWFJLSjFRQS9FdXdN?=
 =?utf-8?B?bU53cVpKdGxpOUpDTmlJWE9xVjlHV3hhcndwRk5KWllZdi93SFhKZ1c2ZzZh?=
 =?utf-8?B?QzhKUTVxc0F3a1RxMDRsMGRvL0puaHUwSm53UEgvZ08vZWxIK0dBcWdJT1o2?=
 =?utf-8?B?eldiR2ZpQWJqV05BcDRSNkdFRndZd2lIRmNwQ1hEVHhyd01UZ1dVc0RSMFlm?=
 =?utf-8?B?Tm1PZ0FCUGRXVlZkTk5kbS9iQ3l2b3hqZXd5dzg0Tnd1UHFTL3Uzd1o5V1pm?=
 =?utf-8?B?ejFrbEgxTlRIaGxpdXlaUjl1OXBVaXRwaGJiY0RXdFR3dUg0Nmw2WDcxT1ZS?=
 =?utf-8?B?cjRNaUJ5byt6blRydC9SMjM4TXJUTG0zd3hVNG93QkxFM1ROZlZlQ0pJUi9Z?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?c1A1U1hUT2NXQ0gvMDR6N3JYWUZIb052eVZPSzhzSHZnKzFaYW9qWW9uYzk1?=
 =?utf-8?B?cktRNHl4UHorRE8wNDlBVnVZYnVDM3hjaktZa2h6ajVUWG5jcEtMeElpc3lo?=
 =?utf-8?B?bUJhN0Q2R1ZEakpwNUI1bGlYdnhyOFJDaHpkem50Q2NUU2x1VitFM3JvODFU?=
 =?utf-8?B?RTdtN3lNTnhraUdGOGFpKzNLcUxubmkydzdHSllGZGZ2M1RkN1BBMDVoMmRI?=
 =?utf-8?B?UXJhRzh1dUJPTEh0M3RWRVo5RmErbUVrUTBtcmE2TEhmT25RZHgyZEFtUk5t?=
 =?utf-8?B?MWZZTE8rWFlHNXBMYXI0ODUyZkhyVWZqSXlwRnkxWWo3bnJSWTNOdWVNajA3?=
 =?utf-8?B?ZExlcTBtK1pJc1BYTWxHVkJ1b05jYlVkdGtNSUtjditraWw0Y24xcmdjTnR4?=
 =?utf-8?B?TXNzMWgzOHd4ajNNc2ZBbTZLRVlaZi94SVZ6Z1R5QU55aHBoRHBWUWFrNXBz?=
 =?utf-8?B?Sk9xbit0WkZEWEljVU9CcjB0R1hoZU1pa0Z4bStzTGQrMXBSYm02UHNUckZr?=
 =?utf-8?B?Y0pnMEJXdjFNZktaaFhPNWhDL3NpRFhmUlE5VHdoVzlCY05ZdFp2V05peDM2?=
 =?utf-8?B?Z256ZDNMaUR4WnYwR2xHVGlFVm02WUFxRjJiTUFPTlY1amVEQTExVXVNVm9r?=
 =?utf-8?B?YWtXMkM3ZWFGc0pNL0VHYVBhZ0RleWNQYjlwR211QnNpZU92M0tFalBqa0g4?=
 =?utf-8?B?RlgwT3lDZVZGcFVBMUw1Q3Z1NGhWMmF1a1dIWnVaZXNiL0lTVzFBaU5iVi9q?=
 =?utf-8?B?ZGp2TTc1WmJSbXpEeEhWbmtib2J6OERxR2w4MEhJWWFqSHUxQmZ1MG96SDRH?=
 =?utf-8?B?TUVtRys5YjQ2OW1KMDdERXJ1Z2lwOVNiYUg4M0xDTmhXa2NsVFpTM0NnR1po?=
 =?utf-8?B?ejhsb3VCZHpKMnRCNWprdVZqdlhBNDVWNGtMdFNsSk5CdkhyOE5TSFd1Yk1n?=
 =?utf-8?B?aG9UTU54UmM2WThhbjF4ZHF2dndjR3o0WklYWWpsa1hPR0djODh0R3VvY1Vy?=
 =?utf-8?B?cUZYK2x3WGcyWmhSK29zVmZxYjRNSnFlVzZYZ25jZVFNTklkWVR2TnZtZFla?=
 =?utf-8?B?djltNmQxVTMwS0ZhbEwwTmZkWnBabVVVZE5qUHBLcDRydldJelprckhSQmN1?=
 =?utf-8?B?NUpibnNUMkhXcTNObTZ5SzNSOC9TNjVZclpJQUFGd0VmZ21wQUxBVGFvdWpZ?=
 =?utf-8?B?eUdEUmdWSmR4ZHRseWtVa2hBUUVITmhJQWxNYXNMYk1UeWNvL1BDd28rVGVO?=
 =?utf-8?B?cGlvbFBlS0RSUVFBbHFIQ3hpd0NoTlVQTGF6dWE3eWdQZ3hoMmVTQjZjeCtE?=
 =?utf-8?Q?idrbsw58icpEg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296bca96-b7bc-4605-12af-08db8157c06f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 15:10:09.7064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8hFPbaQ235CEvBxSea25r+b5qvYZ8EOScI7fGYsf9gtErMWWiaRx0gzO92pOrl/RtfX0cyWZDr8ECqkhsj8dT0TN5kgtxsIqyiZaOb6Fvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_11,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100136
X-Proofpoint-GUID: KV-LUqfrMcjfNzt7VoSHY-P7_f0hX_4a
X-Proofpoint-ORIG-GUID: KV-LUqfrMcjfNzt7VoSHY-P7_f0hX_4a
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

On 6/12/2023 10:59 AM, Michael Galaxy wrote:
> Hi Steve,
> On 6/7/23 12:37, Steven Sistare wrote:
>> On 6/7/2023 11:55 AM, Michael Galaxy wrote:
>>> Another option could be to expose "-migrate-mode-disable" (instead of enable) and just enable all 3 modes by default,
>>> since we are already required to switch from "normal" mode to a CPR-specific mode when it is time to do a live update,
>>> if the intention is to preserve the capability to completely prevent a running QEMU from using these modes
>>> before the VM starts up.
>>>
>>> - Michael
>>>
>>> On 6/6/23 17:15, Michael Galaxy wrote:
>>>> Hi Steve,
>>>>
>>>> In the current design you have, we have to specify both the command line parameter "-migrate-mode-enable cpr-reboot"
>>>> *and* issue the monitor command "migrate_set_parameter mode cpr-${mode}".
>>>>
>>>> Is it possible to opt-in to the CPR mode just once over the monitor instead of having to specify it twice on the command line?
>>>> This would also match the live migration model: You do not need to necessarily "opt in" to live migration mode through
>>>> a command line parameter, you simply request it when you need to. Can CPR behave the same way?
>>>>
>>>> This would also make switching over to a CPR-capable version of QEMU much simpler and would even make it work for
>>>> existing libvirt-managed guests as their command line parameters would no longer need to change. This would allow us to
>>>> simply power-off and power-on existing VMs to make them CPR-capable and then work on a libvirt patch later when
>>>> we're ready to do so.
>>>>
>>>>
>>>> Comments?
>> Hi Michael,
>>    Requiring -migrate-enable-mode allows qemu to initialize objects
>> differently, if necessary, so that migration for a mode is not blocked.
>> See callers of migrate_mode_enabled.  There is only one so far, in
>> ram_block_add.  If the mode is cpr-exec, then it creates anonymous ram
>> blocks using memfd_create, else using MAP_ANON.  In the V7 series, this
>> was controlled by a '-machine memfd-alloc=on' option.
>>
>> migrate-enable-mode is more future proof for the user.  If something new must
>> initialize differently to support cpr, then it adds a call to migrate_mode_enabled,
>> and the command line remains the same.  However, I could be persuaded to go either way.
> 
> OK, so it is cpr-exec that needs this option (because of ram block allocation), not really cpr-reboot.
> Could the option then be made to only be required for cpr-exec and not cpr-reboot, then,
> since cpr-reboot doesn't require that consideration?

In a different forum Juan said this is a memory issue, so it should be expressed
as a memory related option.  So, I will delete -migrate-enable-mode and revert back
to -machine memfd-alloc, as defined in the V7 patch series.

>> A secondary reason for -migrate-enable-mode is to support the only-cpr-capable
>> option.  It needs to know which mode will be used, in order to check a
>> mode-specific blocker list.
> 
> Still, only-cpr-capable is also optional. If and only if one needs this option, the mode could be
> specified as part of the option itself, rather than requiring an extra command line parameter, no?

Yes, I will make that change.

- Steve

> Further, in many clouds (including ours), our VM-management is generational with the
> development of the software versioning, so we *always* run tests and know whether or not a VM is CPR-capable.
> 
> If it is not CPR-capable, we would never run the VM in the first place, which means we would never
> really use that option at all.
> 
> I do see the appeal of the option, but could we simplify it, since it is opt-in?

