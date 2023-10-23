Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8B17D3F3F
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:31:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzgb-0007Ea-KK; Mon, 23 Oct 2023 14:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1quzgQ-0007Dv-Eo
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:29:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1quzgN-0002he-33
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:29:45 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39NI0nZB022660; Mon, 23 Oct 2023 18:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7D8vD8XbwePuDQ2/pD/6l0LRpalkC+Z6HtQwoSs/SWo=;
 b=bQilmFf6dayp3J05CgiW2hN8lTEihQ8PTm5MZBD/y/Ukh+3ld/cZ6v/uRN47Mg1gjwRv
 woHgC/d7+MI6ZjzUQDwSyLMn2W63jem8rdN3d5clhdt7APyIcn8JES+Z6Wc6EsV0TSpj
 iyYh/BM9BDljw5aJsybpdIRAGYArBxmXwv2fCgwzvjbnFMRiFBRSCLw3Zl0r7ulm1i3g
 kFMTKQMVRC4GgpPY8vVaqAkAECIBrcf4tk1AVCBauNY+9vKlh1ILiv3zvpXBSYnoCj0K
 gC3/eqw8V5YSTCGBtclFW+OgtaZOuNEpIVKRGpgFeUoK9L4Flp5prWPG0QqXVsB3uoOI Ng== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6hakqja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 18:29:40 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39NGoVBL014025; Mon, 23 Oct 2023 18:29:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tvbfhkx7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 18:29:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqRL8PZQui4YyyT+OPZwD8ZoYXmw1ynmkz6f46hsBNu8Qs8MbHt7rClxAUS+fPL4TgJqIac/AV6bHBO2n2CMlfUYMHHy/Voqi/TRzZjiQMi141jkgubaVVGm6utsU7zFpJxUp/hz0+kgy3Ea1joVTu0xRS4E1AY2spqsyhOYFT09e6Dcwlm1gyJHWmDk+Q17eEqH4q1nwFA/VPVd6EkFrYhYGtAz7LF88CE9Rp0Z365MloenJ7wgk1CNQZtOIOOCIYRdoBxHs7MiNoH1HKWkpkXa0Y2X0iAgRHxwpE0YenXdILWW1m0f3rAP/+mBJsCVa+wejvCWGOp0vEiADAmwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D8vD8XbwePuDQ2/pD/6l0LRpalkC+Z6HtQwoSs/SWo=;
 b=UKrVAxgcfBbVkXKSjcNMa0gvtidK6Q/T4RX1LwVGWoiyuMNAL2uTQ7SlxECbNfHAoPxS7NwyANUvau9sgyf5G3Vnz7Z12ZNafzhLZJyQbd6cXuw/94jWohvFm7x0lU45xPNUCje3dG0707sWLADpTK3CztKueubXbtl1W36RprX2+8TJdJNAiA8elJaLGe22DqxArnrrphEhY09Q+AMIh+8I+9bbLuKNMCCWHfgtN3nnWvGwNp54OfKMzfLg4v4PS8gWpDcbIn5MKBmTmW343dXc8CzL1NzxOZFREdvLvCpQK29jNjRco8gbLQaWCRs2Q4R9Z1cTp9JF6CZ2OjVMcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D8vD8XbwePuDQ2/pD/6l0LRpalkC+Z6HtQwoSs/SWo=;
 b=y9m8gyC6MQouW6axjLPPa8zAgH94ngEo1xvagfUF5nOurVfrhmN1REtxvRuCzV5nZFg10rEPKfBgMVPJf/Quf9laTkkx74tk1vVNGpMWDkfGkJB8k+oMzralxIDrTBsSg7Abzm9n77bWW3jGAJuCcZbaJn9cvwmhZaErwLjC5SQ=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by IA1PR10MB5972.namprd10.prod.outlook.com (2603:10b6:208:3ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 18:29:37 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c305:4801:5bd7:4775]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c305:4801:5bd7:4775%4]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 18:29:37 +0000
Message-ID: <2e4e6cdc-7356-4f7a-abed-8e6af92ffb13@oracle.com>
Date: Mon, 23 Oct 2023 14:29:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/4] migration: per-mode blockers
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-3-git-send-email-steven.sistare@oracle.com>
 <ZTZrOb0XqOWPwFQj@redhat.com>
 <61ccb916-e50f-4b05-a5bd-5fcf8bf0177f@oracle.com>
 <ZTaLHpkG9DttRn9n@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZTaLHpkG9DttRn9n@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::29) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|IA1PR10MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9759b3-ca1f-4490-7043-08dbd3f6033f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUbm0wpPVUkXM2Ot270xFQoK1hGeqU14O3UGTCkxl/RmqTzBZymUPxSyjCazVWMrkHz7TG54FWs8NVKN6VXwEo5sjjJiuYLbHHXg0Iyv6c8HcRELyONn39vkj97UdMg2XNGDLyo6GTv+T9OStj6AnNUZlz8RIL1NVYps58SfePp8l3TQ7v9kPA6n1HGMDm7HlP1En1mN6PqQX501kEgSLPIrVvJv1dCKm9T6xk7KJt8fkrwbidMQMsiYqEvBDpxU7tSsVM7Jj1vBrr60ScGaCcDN7+vo09QdVawS8dWOs16Vej6aG86/htQ/iFiCwhsJKCpcAMmihltYNpOUPXk8kfgbV3iw4MeiL5xdxEHQlJVBtu7JPGfZvDVzVLcxRvVKxze6BOvFJFp4tv9dr33DfvAeodNIPs++j3BZdwKIW38o5HBTB0T7L+41MooyNu5bkDZIs1yOudruy5Ke5Q5a10QZZJC9lAarABjYBOfn3cYUlB1qj+oOZaOmwrkz645NHTZlTFdjkiSupsGpT90saFIMjAgDvwswftRjQzRsQSm4BdjivrLEKO5ps54gEuslg7QvqCKSJIk38FbZd6SKh5wPi2h+imSdtXNgcU2DINMYggYLKGyuN+EdEuuK5y5INMEPTy/28DTmCHoHkxPSCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(2906002)(6506007)(5660300002)(41300700001)(86362001)(38100700002)(36756003)(83380400001)(31696002)(4326008)(44832011)(6512007)(36916002)(2616005)(26005)(53546011)(8676002)(8936002)(478600001)(66946007)(66476007)(316002)(6916009)(54906003)(66556008)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3lFZkNsb2NXdHFnd0hJclJKZ2dzQThZNG1mdDB0VzlhSVVzMmlzb21rVDcx?=
 =?utf-8?B?VXBNZURNSlFvTElzQVFmRUU2T3VKR2VWR0ZKbFpHaUdQU2d2V28yQ3VrU1BP?=
 =?utf-8?B?RG95QWgzbSs0VmRYSjZscy9ycE9vVzhNVEVLQkhNWjRwZVFCNUJuNFB0Vk9U?=
 =?utf-8?B?U2hMK0xwMWxUVDhSa0tSMHVFeEUrQ2QvNkJMSTlHOUUvWWc3ZkplZHdPMXgw?=
 =?utf-8?B?a2g3TVpnYjkwN2tzQmRSYWkyK3hrR0ExaDNBRW1uWCs3b0IrTzVva05jR29M?=
 =?utf-8?B?ZzQrQUxNaFM1c25DK1o4ZkhiOCtvbWdZQ2w3cFVtenJobWZaOG1weGhCd2lF?=
 =?utf-8?B?NnkvREl6NGR3OXRQN09TWUNESmlWYTJmWjZOMVgxaFNsTXlSUVdWMVpOV0hD?=
 =?utf-8?B?V3duc01XZzdsaXh5V1J5alFyNFloeVYwMStLTHRrbnBkRlMrVVdJVEdZMkpO?=
 =?utf-8?B?SWk5aFdFWFlvSG1tVkYxclRPdHFBTTJ6WndQWnRtOEl1WnpqcHkranpDSVZH?=
 =?utf-8?B?TkhmS25sb2MrRXRrSUNmTHRrdSs0NERDbHNpeDFSM1ZoWFl3R25Qb2dqNTRF?=
 =?utf-8?B?Z1RqS3VMQ1lVaDJzejEvOVdKWUJZUExEWDZVYkNVSUUzeHJnMWNOT3NqeVYz?=
 =?utf-8?B?N0hYZTdZVFJoWEJhZkNqd1NzUzRacjhJQTFFN3JBeVB0c0xzTVVUR1FyTjJi?=
 =?utf-8?B?NVBqRzdqNVFNM3JqUkNIZmF4aXl1L0t4L0V5SllXRVZHbnhNNEdHQk12a0JJ?=
 =?utf-8?B?N3FNN2JYaysrVkJpSFRYNWZwK251UHNGWVY1WmNMelVmdVZTbER3ZVB1YzF3?=
 =?utf-8?B?cUwveXJndU1zM2Fxd2NEMW9yQkd1TWRUQkpDL2hqVWdHT1hDRGZUN21kZURP?=
 =?utf-8?B?aDRuQWc5MWRFbk9sV2JHRzdnVVMvVWdGTzdCeENjajlLZGsvTHp1RVlEYVV2?=
 =?utf-8?B?ZU5IRDMwbVpPK0hxTm1DSUJ6cFF4V0xrck9pdkRJblFtajZ5QUtDVnZBekts?=
 =?utf-8?B?ZUI1MzhVeG5jc3ByTlVyKzBOeEZ1djFiK2pzTTBsMUQyMGhFdjVNYmR0Q2py?=
 =?utf-8?B?Y3kya1k5Um1WWmx6OGpLYmlXQlhUZmRjbFY4K3JLUXVHeG1NWEF5T1RxclM5?=
 =?utf-8?B?eUVObkxhdmQxeG1zY09PQThFQkt0dk1pRFlUYXI3bGVvNDFSbTFzWmlxTkY5?=
 =?utf-8?B?R0krNFlFakJpbnBZM0tUODNZWUxEVlFXUENQRGRrTy9IdE9YVExMVHFGNWxj?=
 =?utf-8?B?MGNGY2h2bjIxOG9lK054RlAyYzIyQ0JvYWFKVUhFTXZlTC9Ra2ZyMU10YlQ1?=
 =?utf-8?B?cWwxVXRHdEdJMnRvTkxPYzd3VHAyZmdsbHQzYUo5SXV0YVFwZ1hiZFZ2R216?=
 =?utf-8?B?b3FCWnR2WHBqdE93TG1aUklYZWx2SWtvVGErTUUvV2l5V3FmcUNlUmF6STc1?=
 =?utf-8?B?allac2szbGhIalM3ZGlJUjJSVlFLaHVESmV2Ry9HM0ppazFyQ0t5cVVBVlRI?=
 =?utf-8?B?MUxONS9GaFBrK0F0eVIxRFJtcEhkSEU3aTlPWkNHVWFTdEt1c1hKNkRPRDBL?=
 =?utf-8?B?NGcvcDdRcDY2K2xBQklXODIvcHBGeEVGcXVvVnRKNjBGMi9XR1h1YmRna3c4?=
 =?utf-8?B?S0x2cWFUM0s4allDY2Q4ak5RN1pTOXF3aEZtZ204V3ZWWEJBMUFEc3QycVU3?=
 =?utf-8?B?NzNhL1ZsYU5US3hFeGRuQVJmRGl0V3ppQ1d6NGZ0dVBOOVpKMFptZ2kzdm5G?=
 =?utf-8?B?aWdkdy9mUFhrQlBFNk94ME5XUDhhZ3k2SmsvWFBabWhIVXNLbFBLL2hnaEpn?=
 =?utf-8?B?K1ZUR3ZqbmZJcUVhUXQySEc4b0NVNGNMMjlvWE1WQ0loMThVa1hNc3BPaGk0?=
 =?utf-8?B?SG9FalVDWTB2Q1ZJeDJMRkdBR2ZiLy8yZEdjcGduWFVOT2dycVJPRDNaODJD?=
 =?utf-8?B?MW4rc25ObFVWeW1HcXorUUVGcjhSZHMxbS9QKzJkdkVlOVhnNFkxUGFxSWp5?=
 =?utf-8?B?ZVh0YzIzUjJPZUZDbnBCT2hiZzdqYWdwckxLZFYybGx4bGppcGtUeFlUNktj?=
 =?utf-8?B?M0VaZUx3ZTlBKzdqRGMyTWk0bmZTOS9BODd3NldzTHN1RE5rUE5OZVhKNzhD?=
 =?utf-8?B?WlB4NWpRQUhyNm9SQkNnRG1wdDdJQnBNS25LYjRlMmJidUNpT2RkdDBTblhR?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IXXfGyWUwmmgk6f6uwRi7vTFYM5eA+8wlHvuY6/v/s+/mWlKF6jKhSXYP7y3kSv9B1OsNq3mGFld7r0YD5GQ2/B4QhvgyKiAxe9agei/4pYGVCSDTxBm46TkXg/aih9i60cS+yv1g0a1AP+ly+c9gw0RbH7KVr87IdFk2SlrISDiZxvLlyLNHDc8bWAGjJ4BXt42G43QzyaiBZOTeGhG7o3giIfpHJfAv3PiFd8hOZkjPF57yDHSWEn6cinlunNDrInmJgaVijVL9k+ck9D/MaWVrGmaHV+psHQgyIWUK+rNEuNk5sJLP29S1cgk0EsQ/232j3/+jxsJTvEmugJgkjDN3lmqFth/dniIHlNzZK3mv9nlKyXhb4QIF0MshUUECN80ZzClcSJsmA3n5UYbIFekjiedjd5ie6Czx/UNy5aIe54Hx6dfWGh8Vp1/uCPQZUiDNINjCOm1zv/avekddMO7TFF57Ri/rV8NCElruxpz4cpR/3G2WlrIzqP0QeE/FJDIQAirK74UxZ57Cqprm7/AF+uLIrrZSlDzZc/hXvx6OXJ18Xg/xlvHNIKw1xki6MpT5Hsy7PudsuPSO2cGVmwiavDVP+IROQ5xSMmZ6cmWJ0PFgXhkVvHRxbnE49illzo53ElZ2bMKaEL0BXG8BukQ/VAR/ewdYaeovRzvtKEnfVIf99Sv5FdAsx8q3o7luMyCoJNDbV5ROVcr3jDW9MUkj7hiaeT+723jku9Z+P7oMv1uIETN0P5x6293hHtAJuf5qQDSoSJZTBZMfY1cXb6dDABJHcpcxDHBU28cRoY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9759b3-ca1f-4490-7043-08dbd3f6033f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:29:37.4272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24qobHIDOBnnqkkwMg8zZqPDuz/iSqiPBtqb1JribSKynoVFFHJBCfwtXY5osMkwngF62zCmmONz34Kxx3Z3o+3C7u3N5wss9XiAgzIRrtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_17,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230161
X-Proofpoint-GUID: ALDSZKzlYVhWFJdMvD9HA7_q_7QBfeuC
X-Proofpoint-ORIG-GUID: ALDSZKzlYVhWFJdMvD9HA7_q_7QBfeuC
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

On 10/23/2023 11:02 AM, Daniel P. Berrangé wrote:
> On Mon, Oct 23, 2023 at 10:37:59AM -0400, Steven Sistare wrote:
>> On 10/23/2023 8:46 AM, Daniel P. Berrangé wrote:
>>> On Thu, Oct 19, 2023 at 01:47:44PM -0700, Steve Sistare wrote:
>>>> Extend the blocker interface so that a blocker can be registered for
>>>> one or more migration modes.  The existing interfaces register a
>>>> blocker for all modes, and the new interfaces take a varargs list
>>>> of modes.
>>>>
>>>> Internally, maintain a separate blocker list per mode.  The same Error
>>>> object may be added to multiple lists.  When a block is deleted, it is
>>>> removed from every list, and the Error is freed.
>>>
>>> I'm not sure that assocating blockers with migration modes is
>>> the optimal way to model this.
>>>
>>> IIUC, some of the migration blockers exist because the feature
>>> relies on state that only exists on the current host.
>>>
>>> This isn't a problem with CPR since the migration is within
>>> the same host.  At the time though, these blockers should
>>> likely be redundant for a normal migration that uses "localhost".
>>>
>>> We can't express the distinction between localhost-migrate
>>> and cross-host-migrate historically, but we should have done.
>>> This new patch largely enables that I think which is good.
>>>
>>> What I think this means is that we shouldn't tie blockers
>>> to modes, but rather have different types of blockers as
>>> a bit set
>>>
>>>   enum MigrationBlockerType {
>>>      MIGRATION_BLOCKER_LOCAL_HOST = (1 << 0),
>>>      MIGRATION_BLOCKER_CROSS_HOST = (1 << 1),
>>>   };
>>>
>>>   #define MIGRATION_BLOCKER_ALL 0xff
>>>
>>>
>>> Cpr would check for blockers with MIGRATION_BLOCKER_LOCAL_HOST
>>> set only.
>>>
>>> Normal migration within localhost only would similarly only
>>> check MIGRATION_BLOCKER_LOCAL_HOST
>>>
>>> Normal migration between arbitrary host would check for
>>> MIGRATION_BLOCKER_LOCAL_HOST and MIGRATION_BLOCKER_CROSS_HOST
>>
>> Or, we could define MIG_MODE_LOCAL to relax the blockers for local migrations. 
>> The user would add mode explicitly to the migrate command, or we could 
>> implicitly switch from normal mode to local mode if we infer that the src
>> and target are the same node. MIG_MODE_LOCAL and MIG_MODE_CPR_REBOOT would 
>> relax the same blockers for now, but conceivably that could change.
>>
>> When I add cpr-exec mode, it will have its own mode-specific blockers.  
>> But, in your scheme, it could map to a new MigrationBlockerType.
> 
> Yes, there could be further types of blocker.
> 
> Do you have an example of something that would be a CPR blocker
> only ?

For cpr-exec with vfio, all ram blocks must shared, so the same pinned
pages can be attached after exec.  Secondary ram blocks, such as vga ram,
must be created with memfd.

There are misc others.  You cannot mix replay and cpr, or colo and cpr.

> I was thinking that migration blockers have a functional classification
> which motivates their existance.
> 
> The different migration modes are describing particular usage
> scenarios, and a given usage scenario will imply blockers for
> one or more functional reasons.

A "localhost" blocker reason is less useful and less clear-cut than it first
seemed. The blockdev blockers that I relaxed for reboot mode must still 
block normal mode migration to a local host, with concurrent access by the 
src and target VM's, because they do not support dirty bitmaps.  In fact, I'm
not sure if any of the blockers would be relaxed for a localhost migration.
For cpr, blocks are flushed before qemu exits.

>> I do prefer mode as the way of specifying the type of migration.
> 
> Sure, I didn't mean to suggest "mode" as an input to 'migrate'
> is bad. Just that I see migration blockers classification as
> being distinct from the 'mode'. So a user could specify 'mode'
> with 'migrate'  and that ends up mapping to certain types of
> blocker.
> 
>> The question is whether we map mode directly to blockers, or map mode 
>> plus other criteria such as locality to MigrationBlockerType(s) which 
>> map to blockers.  
>>
>> One consideration is, how will the user specify the equivalent of only-migratable 
>> on the command line?  I was thinking of adding -only-migratable <mode1,mode2,...> 
>> in a future patch, but if additional criteria maps to blockers, then we need 
>> additional options or syntax.
> 
> I guess I could see wanting to use --only-migratable to express that I
> want a guest that can do a localhost-migration, and CPR, but don't
> care about cross-host-migration, which would point towards blocker
> types being exposed.

Yes, but then users need to understand the additional concept of blocker type,
and know the mapping between mode and blocker type.

I was undecided before, but now I believe that mapping mode to a blocker type
does not add much value, and we should stick to blockers based on mode.

- Steve

