Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C3E7D3F6B
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:41:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzpw-0002T1-NE; Mon, 23 Oct 2023 14:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1quzpu-0002Sf-MI
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:39:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1quzps-0004dJ-0O
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:39:34 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39NI00gO027945; Mon, 23 Oct 2023 18:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=pdu0CvKMuj8yql1Q3nvkeW5pkV+uvrtVEowzjtdL/BU=;
 b=ZF+a34xyITYyLlV7V+U9DuoLRs/T493pqGKtpVWFlcIODRIwPab3nylVhtfKTCYggGEN
 rti2KdcGIUHlNsmAYjJPdNqRWKz2UBwKaDugDvVNPuWytkywLlbKJkqFhrF/SdiSgPE1
 e7T5eveAJz/PkflUSbJc0nwCOelYOeGRbsPVWG/7aeDW1n80BrvgOp4PlMOfKGE4WeAS
 ps4cVOXqBDG5xivVzyRmPeOQjuZX7gqxqIeTLql18MpCCtf5/o65FPMzWJW7duLHCdXL
 hqm9ytv0WreT+1VeAnCGCiZ0/s2G5Hb+Pk9JU+If/wRMO29HaZ3oWhO3y/OOYe37CrJr FQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv76u3rst-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 18:39:29 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39NHJbH7031243; Mon, 23 Oct 2023 18:39:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tv53aup6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 18:39:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMa6g4blPOAfJfia+bG3BHeY4C9GQAoxbcs5CQhL8urrD8A8F2BvkeTjrk4fI+QmQo54d7Z9Kjd0koGZaebzPiYR3lys5lVvKjos0nQRX6rbsCy7eitzyM4W86YH3SOZ1lq7cN+iOewYgZAHuboSuVxnWv+XxeYyMhCtaS09uIISBlKw/VBFLASl2f+ArcckhIFsDtAqeKZQZwaoaAM60ywHpPpmSeRScrf0t3EcQnLnQbgEZQHQsza7EWCMzqVEhDFhTGcN29e0pSgj+uMrPBWLlEcDlhcsT9k2gVFYWNVnviFwU1JMrBsVqqa9wL5eDEQzxqLTulWDgKuQwj/Z4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdu0CvKMuj8yql1Q3nvkeW5pkV+uvrtVEowzjtdL/BU=;
 b=AZ3GW46D6zP+hN2xuVKASU1c2HHxR7ZLXvkdgoefX7KQkiN646rfG4ZPn+Q/810RJli/EK62YlYNQMPnh09wqrnw9SQh8w98yTGpY/DW45To1MsJpK4L7xhsIAw2qRQFDWq1YWZvnuiF/lKVLR/9Gf7sTgxRkwCajItXZ0CoxvwLC22LUH2gsDEBNqgQbjKEuhw6lz4Eb23SOZ8KHp8CLEzWusEwkHd67RQtro3KVlLGHMZ+VFhL28XS9noyqqKvwdNpBICz76KsuC8hn8Utn9iI3A+nnKl6QRxzSseRI5ph5Cl05uz4eyp9J8nxSJ7UmUSvky0V7U6Rh/AfJPmhjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdu0CvKMuj8yql1Q3nvkeW5pkV+uvrtVEowzjtdL/BU=;
 b=acl0h5utz7V1RHF3n13ea7SHfTcFwJtDzvdqTlH10QpJIwUPmi6yltsJZV7LJdUDF/FRIbYEVRLTdHa626yfdhyxa5b7Fy5LURRKyHZG+jA4fZ+gVyFRU9tHqkYnAK/OB7kWRdrYvxUVMHG/Z+bXYHvLuKH6FCiU+uJymob2eyo=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA3PR10MB6999.namprd10.prod.outlook.com (2603:10b6:806:318::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 18:39:25 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c305:4801:5bd7:4775]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c305:4801:5bd7:4775%4]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 18:39:25 +0000
Message-ID: <fe0848ae-6600-4b46-bf2a-05b9dea55472@oracle.com>
Date: Mon, 23 Oct 2023 14:39:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 4/4] cpr: reboot mode
Content-Language: en-US
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-5-git-send-email-steven.sistare@oracle.com>
 <87mswdzkyj.fsf@secure.mitica>
 <2814d5e1-76be-4d4e-a76b-25b2eabd2cfe@oracle.com>
 <875y31yter.fsf@secure.mitica>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <875y31yter.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::20) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA3PR10MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbe4733-88c9-4f29-7f1f-08dbd3f761a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0ihiGfB5Q314mnSnNlOokV2YW3P3psKjYASIRn9H5BHwscojFIPXQbX0635iB2RgXhM0ElEzPmTiLBRA8K8q+u7tHzcx8XPybH/nYElac26eJyj9cZw25brLqf5GhkvCtEPbG9pHpVblk8zjgSTjLX5PMTGb1g5EamsZ+xizTrpFvggij2OFjI8dyLMimBvkk6kd3d5rMgQsd05ZJTHPVVKSlpjmekwtmtQiv1IXdn28F3QTg/ZZ1Lj9ezp/CXMFKUDNbYjqYG2NrL0Lq7KrV1iXpNA97Z43oCGZpArIe6PhKuHl67l2BdA2dCENu9DIzYGKwYfzbvsVh/1HZCDvvccW4wq7r7pwfvJaxE9MEpCB1MmxNDzxfoAY0YC112dFW0WCHVBGD/9Jo3dJhU0RyGvK2vVGX7fafHKnsJLvZx3V1NLCIkE+qCOpwSAGxhOAxKbl8t5f3KRQgLH8BXaklh0kdrnxUhctWNagTxhhfIXIoXb0wlADAKp8m7oyQ+3gcaeNR9zO5X2cbxPV9XiTZXeclnA6EPGV3wWOfmq0wEeLsVFN+yEGgAkxBT9d9FCLRdimi3vUVqZHR3LQUWVUD2imn8VILIPBQ/606JjZL9Vg60H+VjLB52lUxHeGzCHuhSuhCrwjkeNdupZcPIvLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(36916002)(6506007)(6666004)(53546011)(83380400001)(8676002)(41300700001)(5660300002)(4326008)(44832011)(2906002)(8936002)(478600001)(6486002)(54906003)(66476007)(66946007)(66556008)(316002)(6916009)(6512007)(86362001)(31696002)(2616005)(38100700002)(36756003)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDF5K05yaDJ1elNEeDFGTUx4LzMyQWF0UGdVSWRIbGNOcXRlQmNVbE5nZ0pR?=
 =?utf-8?B?VTZ3NWFoZEx0QlBiUVdrMUF6RnowMkVEVGV6ZmlZK2FCeG5Kd1R4dDNNN0sx?=
 =?utf-8?B?TlhDenpWeTh5REVFYmgwSXdTSUdiWEtNZGNXdlJhQ2tKUlhTOHRCSVZrQXJE?=
 =?utf-8?B?M3pkSzAwd3Iza0NocUFTTVpGQW96QWpJT0o4WTRrV0RndmZEWTh6VDlTeG9z?=
 =?utf-8?B?bDVtS2RVaU1oejV5N01ZM1M5YTF5cExUcHVzVjdhNlRNTmJQb1lUbllUYTda?=
 =?utf-8?B?b3NyV3VRdnpuditTMFBJYk0xZEp2ekxtVVFxUEhYNFFla0VRQjRyS2VJWVlY?=
 =?utf-8?B?U0Y2eDUxVTcyb0JsTGhsUkRkTkZrVksvNUFXR28wWUkwei9RL0daWTVScTNT?=
 =?utf-8?B?UytwekZQTjZnL1p0djBmVFVxWmdrT0kzL0RJUUpDd1k2Z2FwdUdWSEg4dUs2?=
 =?utf-8?B?bkNaNjZqLzBtTmQzZWRYWStlRFZSV1dLM0hicDVtZWpMNVl2M0ZpVHhLUVdm?=
 =?utf-8?B?MVRSalo2TGtYaWFIekUxelR4eW1XMGhXREd2NWdDbEZJUC9EZ1k1K0NaNndq?=
 =?utf-8?B?U09TRmhvZkE0T0JRbVZVV1hhMlYrVHBuMkpHMVZydkRsTHRNVkF5Tmwzc1Jn?=
 =?utf-8?B?VjE3Rzd6UlBZQ1BSZGJ6TjhEQ2NZSGR3U0lEbXpuZzUzK0xTTmZDZ2R3MGUz?=
 =?utf-8?B?RzhlOTlUL0IvMmxzd3VVdHF4QVJ2czFseGlqMVZodi9PbHFMOWgwQkVVYmx1?=
 =?utf-8?B?RTJVL2N6TUd4Ny9VVFFjN1JZaTd4Z0JaTjkvemdPT0tWVWNra29zTGljMzYy?=
 =?utf-8?B?NGsrSXl6aHBnaFBLeDNFZFAzbGtSWlgwTzdycEVEc3BoVFJrNjZHU0J1cFor?=
 =?utf-8?B?WHpUOStaQ1dnR095OG9pYXpLS1hrTEtXcDZ1T3ZvZjBLNVVXenZxTXJWQ0s4?=
 =?utf-8?B?QkFVanJVSE9xNGVheVBnaStwbVVLV1ppdzc0ZnFPR0dJTmtNazdoRHhrK2E2?=
 =?utf-8?B?MXhRQzUrZnRvS05TMlpZNHd5QkZSWkZDMDFNQVZTUnRPcy9mRGgzRERFT2No?=
 =?utf-8?B?cmUyL1RudjRpb01MVDNqOFVwRXQwSnA1am5iTG4zOUJ2VVowNzZaWElZMHBH?=
 =?utf-8?B?QjdJSjZjUHB2eVB5SU9yNzFSeFpMMURLbzNSQXo3Yk92a0pqbVZaOFZqTkpT?=
 =?utf-8?B?c1V1UkZadWRNUVZEb1k1MTdpbHNnWW9hTll2a0IrdEt2NE05OTBtL3FPT1hW?=
 =?utf-8?B?ZCt3R3NYUHFuSktaZmZkelJqY3dmODNmZGQwRmNuRjM3V3h3T1NqSnpVc1FZ?=
 =?utf-8?B?d3dCR1lIWmhsNGViUjVUNVVEQ0tqK2NDQVE5d1Z1bzU4V1g3eVpEODNOTkRZ?=
 =?utf-8?B?bkM2WldabXpuQUhuakJxbkRSeXovQzdad3d1TS9pcU1DMkJEdU9ML2YrNnZh?=
 =?utf-8?B?dXpYd1Eza2p4cHhYWjFQN3hSRWFvcExVS01MWjliTFNHV2JESzkyZE9ZdUxh?=
 =?utf-8?B?cDBFZmxIUFRzUHNjVTBuWUIva2ZWNDJ2Q0VMbUpuMER3R1l5ZXkxSmR3anRP?=
 =?utf-8?B?VWkzMW8xaXRpU3pNbm9OS25FZUNleXlXdzd2ZmdFUXVnTy9yUjhmT1JjMEpM?=
 =?utf-8?B?eTJKNmJvTDEydGpvcCtHZWNYZ1FzNHVmZFlVczErblFSKzJZT3hCNjJIckdD?=
 =?utf-8?B?K3NWZUlqdWpXeVVIa0tHczdwNkppN2lCWThic1hpd3o5bE1kb1J1Yk9mTGNq?=
 =?utf-8?B?cnFtNmxqYi9zYlIvaTNiQjRFV0I1L3lva0FBd2s1bE9KczdBc0pxVzZtUG11?=
 =?utf-8?B?d0IyRmU4dHU1YjdSeE1OVE16VlgzT1drZmZMZDJvMXZDQm5WVUNpbkhrLy9m?=
 =?utf-8?B?QytxT3ZKcHdpaTl5OVptZ29mcmVsRUZhdDZRZElPZW15VmRrTTFGTllJZmZr?=
 =?utf-8?B?NzZqQzhRTUs5bDhDOXFTNUlPZU45V1d5QXBUcElsa2J5REtHWXRnSlRSbVZL?=
 =?utf-8?B?Z1dvOGJtOCtGc3laZFE2YUk1TENiWlN3emQ2RXNIZjlxUThHY0pETUJxQnJj?=
 =?utf-8?B?SVJhVlNxVElIdFBUMHRCbVpNV1BEc2xYMVZCc3RaQjNQbXhNNXY1amdGSDYv?=
 =?utf-8?B?SWVvYTZUZENBdlpkc2dUd0hILzhTbGZaSlR4SUpVcXBPdTZMd2NnOGFtSmw3?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rsYDauLdEJEC2lvk4rSSv8w9KRCQAdd6tyT6VUFWf08rTgovEEGI3tl0aYsY49i3mH+kFQf01QNYQ8Ul0su1hGJq7Qxq5xIMwOFQCHXUHgIja7H9D17I9XVpX/oO4ALwQH+snoim2RDbyTf84clUWMW8y7GsCu6OS9QCUPPisUrUucROIWoVwCOmViQyGHMl/0IBcXqZQRdW9uKY2OIJLel+PJjwxwpnQ7ieFp5gknoZ+KcqpJii1KwXehmEy369Op5LFqou0F0XbrECPR/AlPKMUyXzRDQMrZGAh6kSlDCs8yQACNnylqh8CS7cZx/9b+igqN0NF53uxFQ6s6ffMtcPYIlQHTJvUT6tqyfTwTf4ogyJFR4IArfyB6hlGkXEVfCi76Zme6k/ZSTVdDgVRUpsvQpv/H9MDyHk8w2ZWcfYHJf5EciZJC9034aGd1FR6j2X6/tTqdIHq45ASKxh7oFBXrx+XmDzKvKIJ72L5Nap7oSCRZWdisoLHme45JaO/QrzwQQQsLfW+8vgyoiQFF85qqReCK9DDgLW1NZSyT+ZJFR7PTnc0sY4OVZRc9NpaA2Xhhqt7osIFAcC25048hgF0l+nuqPlTwfy687S0r94gpcmz9M2F4J8R0pCGjK3w3U8vYR1NLA4xTJhm3JJUfKISCkpj7ixYBI4IdtLyEJ3Nvz4sI040yngY6LCdUEJGOVp6HWy+5yYYLnMJ8dcqUygP+fc9GZ/S3MD+wRKfKNDFP+6KzkXFSQMlgABhPHjwN5PVHeca+5ZmuxabFsluH3vbQQ2dWTPuDL+DegEf/g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbe4733-88c9-4f29-7f1f-08dbd3f761a9
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:39:25.4000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTNrcTIuw0pWyy/4pFL+GcvGgvmUhXrF7C7zS9QbiYSKX8aLvxKDlM3f62ANOqlmoovxQGRC7x/GBpMqWJ6PFjsJCPnguvjrnThIiqDngiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6999
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_18,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230163
X-Proofpoint-GUID: m7SxgO1Q6FGclJlWO0F9e7SpDTvcVJ2I
X-Proofpoint-ORIG-GUID: m7SxgO1Q6FGclJlWO0F9e7SpDTvcVJ2I
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 10/20/2023 3:40 PM, Juan Quintela wrote:
> Steven Sistare <steven.sistare@oracle.com> wrote:
>> On 10/20/2023 5:45 AM, Juan Quintela wrote:
>>> Steve Sistare <steven.sistare@oracle.com> wrote:
>>>> Add the cpr-reboot migration mode.  Usage:
>>>>
>>>> $ qemu-system-$arch -monitor stdio ...
>>>> QEMU 8.1.50 monitor - type 'help' for more information
>>>> (qemu) migrate_set_capability x-ignore-shared on
>>>> (qemu) migrate_set_parameter mode cpr-reboot
>>>> (qemu) migrate -d file:vm.state
>>>> (qemu) info status
>>>> VM status: paused (postmigrate)
>>>> (qemu) quit
>>>>
>>>> $ qemu-system-$arch -monitor stdio -incoming defer ...
>>>> QEMU 8.1.50 monitor - type 'help' for more information
>>>> (qemu) migrate_set_capability x-ignore-shared on
>>>> (qemu) migrate_set_parameter mode cpr-reboot
>>>> (qemu) migrate_incoming file:vm.state
>>>> (qemu) info status
>>>> VM status: running
>>>>
>>>> In this mode, the migrate command saves state to a file, allowing one
>>>> to quit qemu, reboot to an updated kernel, and restart an updated version
>>>> of qemu.  The caller must specify a migration URI that writes to and reads
>>>> from a file.  Unlike normal mode, the use of certain local storage options
>>>> does not block the migration, but the caller must not modify guest block
>>>> devices between the quit and restart.  The guest RAM memory-backend must
>>>> be shared, and the @x-ignore-shared migration capability must be set,
>>>> to avoid saving RAM to the file.  Guest RAM must be non-volatile across
>>>> reboot, such as by backing it with a dax device, but this is not enforced.
>>>> The restarted qemu arguments must match those used to initially start qemu,
>>>> plus the -incoming option.
>>>
>>> Please, add this message to doc/<somewhere> instead (or additionally) to
>>> the commit log.
>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>  qapi/migration.json | 16 +++++++++++++++-
>>>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index 184fb78..2d862fa 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -620,9 +620,23 @@
>>>>  #
>>>>  # @normal: the original form of migration. (since 8.2)
>>>>  #
>>>> +# @cpr-reboot: The migrate command saves state to a file, allowing one to
>>>> +#              quit qemu, reboot to an updated kernel, and restart an updated
>>>> +#              version of qemu.  The caller must specify a migration URI
>>>> +#              that writes to and reads from a file.  Unlike normal mode,
>>>> +#              the use of certain local storage options does not block the
>>>> +#              migration, but the caller must not modify guest block devices
>>>> +#              between the quit and restart.  The guest RAM memory-backend
>>>> +#              must be shared, and the @x-ignore-shared migration capability
>>>> +#              must be set, to avoid saving it to the file.  Guest RAM must
>>>> +#              be non-volatile across reboot, such as by backing it with
>>>> +#              a dax device, but this is not enforced.  The restarted qemu
>>>> +#              arguments must match those used to initially start qemu, plus
>>>> +#              the -incoming option. (since 8.2)
>>>> +#
>>>>  ##
>>>>  { 'enum': 'MigMode',
>>>> -  'data': [ 'normal' ] }
>>>> +  'data': [ 'normal', 'cpr-reboot' ] }
>>>>  
>>>>  ##
>>>>  # @BitmapMigrationBitmapAliasTransform:
>>>
>>> It only works with file backend, and we don't have any check for that.
>>> Wondering how to add that check.
>>
>> Actually, it works for other backends, but the ram contents are saved in the
>> state file, which is slower. I should spell that out in the json comment and
>> in the commit message.
> 
> Thanks.
>>
>>> Additionally, you are not adding a migration test that does exactly what
>>> you put there in the comment.
>>
>> I provide tests/avocado/cpr.py in the original long series.  Would you
>> like me to add it to this series, or post it later?  Would you prefer I
>> add a test to tests/qtest/migration-test.c?
> 
> test/qtest/migration-test.c
> 
> please.
> 
> Something simple like what you say in the commit should be a good start.

I wrote a new test which I will submit with V2 of this series.  Turned out to be
easy after Fabiano provided test_file_common.

+static void *test_mode_reboot_start(QTestState *from, QTestState *to)
+{
+    migrate_set_parameter_str(from, "mode", "cpr-reboot");
+    migrate_set_parameter_str(to, "mode", "cpr-reboot");
+
+    migrate_set_capability(from, "x-ignore-shared", true);
+    migrate_set_capability(to, "x-ignore-shared", true);
+
+    return NULL;
+}
+
+static void test_mode_reboot(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .start.use_shmem = true,
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = test_mode_reboot_start
+    };
+
+    test_file_common(&args, true);
+}

- Steve

