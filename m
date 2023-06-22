Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4CF73AB9D
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:30:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCRrq-0008MH-4i; Thu, 22 Jun 2023 17:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qCRrU-0008Lu-3P
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:29:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qCRrQ-0002HV-0l
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:29:03 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35MIWbPd029505; Thu, 22 Jun 2023 21:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fXamm3rRRHV7Ft1qyWpWrjhBgycvczK5JxIL9q2ZWV4=;
 b=1NPLj0R30BZ5cwZj4Gzr4TOnwSBRJHkCEHIt3VwLPr/fm1xbWdt//Sf7+kilhCbG7Vnc
 kG+VxpMbVELAvUYfTh9QZhEW05Z6EWLTTTWW2hr7l2/SGF0d1tAB0nevoIIzxwvHxIFe
 cFIqiQ6yFJx/Vuf+wZGVfDHDJItGaNsWfgHwv182+i+yVdryrkSqww6S9A2YbLRtR8c0
 UeFlnQUdbRfBvTMoIr2oRfN+pecKMAnnBagrT/COl3neBEeDmu6JS3UQysTRAtmurWGR
 hk7eCjVHYKtMbIy/B7qK5vXT0CPjsCxI0AgRBYzu1k8Jupbomxu3qzJCwVnKJ0ua6l0b Dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r95cu2tpv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:28:56 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35MLD19Y032934; Thu, 22 Jun 2023 21:28:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r93993ucw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:28:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFcAK6qQ3GNFToXl9U7oGdlRePThpV2jPukDuUYuOTc9GHQwmU51qHYAXoEbRI4fxBdRBuJ8ifi1/faqWAtIgsTPd5vA9WxswKtkAfDe1M2WQ3aTiG8oagnMKZV5VZ7utWdeYPYQeg8sPgpTrqau0IEfeCdnMVFEmDYH06fWJJmf3abaqT4U+bIXmiPJtO++e7IjgJamKwSQALFc4TxHLKa/T0YMVjeSdrwCcUhe7xseQDg7LeUA7zlusFwzSGrpLluVX+KOdgUvKtV4iIW0Itw61XnLc1DnNUxPCHw+hrXc9qXGA2Igaextx/W7sIXo3pKu50nWRXEcWKV1XFTBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXamm3rRRHV7Ft1qyWpWrjhBgycvczK5JxIL9q2ZWV4=;
 b=nqhUxCpgAzoGXGi1PN67SKfzD0olhZyZ6e7o73DA1AbVCPVeedDx/Mc7nq8OL4xuZh/7UyQeuy0DsSUT3J9uoKd1mHu5wZckJ9LP/aqm8IGBOtjuq9kZ+cAyuvlYnYaBYWuQ2MEB99VHnl6iDYCGoJlhhhThyh+k9YS8cJyXnnJTqKbR4GMTjg3eV9IgEH2P/DqHdbT5Wes1e+W1ACLqPj3hlWuRjysp0b+i1CrINKPZUmnfl8dYQ5utkW1Sr3A6TBlQU8DHILFiuoDpCWnBzUe0J0o/tUqdYOmqVKrSFh48qZ6pYTB4ges6jl7z7UJN0H5I0fkpdABAi4sGBAiU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXamm3rRRHV7Ft1qyWpWrjhBgycvczK5JxIL9q2ZWV4=;
 b=cCwgD0IhsfHyXTC9cv8e8oPP/KbKeZ16HYa0vcraXCGsHOmmEX8HCiugWloUJ9YWgNsxY3REm/9+tnekEwdyTWz9y2IrkNv1g/J2CIf6Dg17QSuAgVwNgC7+ZaU6kDr/yUJJawFLsjKsw+AZsecWEUWz5956drO7YFwGBRwC1U4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS0PR10MB6917.namprd10.prod.outlook.com (2603:10b6:8:134::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 21:28:54 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11%6]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 21:28:54 +0000
Message-ID: <e732c868-b3ce-de9c-63e0-89bb6851dc51@oracle.com>
Date: Thu, 22 Jun 2023 17:28:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V1 3/3] tests/qtest: live migration suspended state
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
 <1686860800-34667-4-git-send-email-steven.sistare@oracle.com>
 <ZJMpFfetFkZ/QjfT@x1n> <e848fa92-3cfe-a3bc-d666-625e72a65518@oracle.com>
 <ZJNW+2RsId/gbEQ6@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZJNW+2RsId/gbEQ6@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:8:56::14) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS0PR10MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b93987d-7c02-4019-2826-08db7367adf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +36xvd/7BlQxch25M8pa6fMn9XFfshY/diCXy0DSvHewUjCarwF8fcD+GfHBqypxbyEcOjNI5yLUwQWrzMMrWcSVQZ0aFv1kQAJlc3Y+534hG9pU64ezyh9hOIvUFtP1KrkijLprYXxDqB+hBibYYzPp1/fkKuBF0oUj3PZjuQpEXpcXJ6NlcqQMVxA+6djC/GEuVKLXvRO8h1YQ+agpjJs7er4LQ/ezGROdCAvWMBgkSnko+sJnzIN3laeLJdBvHhIRHNCUgiFaG1Xp6CgtMVkZXdh856Y1jRb/IIU5ipZdkL+DkG43yWF9oGVT8m269oBZyNEbh5stddl9xK6BoKcTVELxWm0aqTCBTe9c/Zk+r9Wk8wA7JzsxW15lfGnCodShB9b2suuTmYCGnQHzozhppT+llb7/mPnoe7nVc/T10Mh/a/vCRmn0bsiCGugP/elmBF4j7e1qmM8POPwmN624Y8WPwlh4/HeQnCr0W0tKXIl5Mzhz2aBXO06c/yJUj+ewhPxFmJqUtP36HDruJdGd2LmQn7EVMlSL9D/qwFo5Ykd1FD1gOYIMhgcaxzDfT2Rn9PhGQlDJtt2TPcWIIfk/BmCFMJQ1mJe2Qlwj19sm3H5zEWLafFA55WEweMXxwjmik34yx5gQgb31n8grtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(8936002)(8676002)(2906002)(5660300002)(4744005)(54906003)(6666004)(31686004)(44832011)(316002)(41300700001)(15650500001)(66946007)(6916009)(4326008)(66556008)(66476007)(6486002)(36756003)(36916002)(478600001)(31696002)(86362001)(186003)(38100700002)(2616005)(83380400001)(6512007)(26005)(6506007)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2NKd3AwTEl4dXg2a0pKUkkzRmNPdEFiaUkvaEFyeTFtN1I2VUlYRG16b09O?=
 =?utf-8?B?S0hoU3ZlbnZjL3RKeWNIMTU1bTI1Nm94UFNLMjR0T2xmeklFamlLVjhjajFH?=
 =?utf-8?B?Y3p0QkpxVXBIYTR2ckNQYzNQOXhITGFBdmlQa2VOdGxiNlQzSC9EcG1jYkZW?=
 =?utf-8?B?SGQ5T2JOdVJCNWMyZGdGRG9yK3J2ekl6a3RKWDRiY3l3L3N4ZXpLNTdLRTVi?=
 =?utf-8?B?V0haVDNhS1pJUVNOdVhhYkVUMERkUmxjblc4Q0FDS2xDeVh0dE9nL0htUjFX?=
 =?utf-8?B?U1ZMOEZqeVBzWmRoQW9kR1FwdmNHdXpOMVRzeXh4ZWxoZFFDRWpGMFFaS1RV?=
 =?utf-8?B?c1NCdGl4L3g0dm1WZnlnOUZhUWdab3daR3ZDMTAwVDc3SWc3c2ZVZlQ3dFBP?=
 =?utf-8?B?dFk2VlR3L04vQ1RvUHM5N0cxbnpNUHJmQjlmVzZaajVHNk9ZdHIvM1V6QWpq?=
 =?utf-8?B?bDk4SzNEazFmVnlaemtaK0U1Q0UrL1pkQ0FwVEE2ekR2NVpnbW53R1EyeWxR?=
 =?utf-8?B?VUVUVHM0b1ErRTZPV0RwcWIwQWNQSUNNQ3RpZ25IVjYrWncrVWNmL1JCbFFR?=
 =?utf-8?B?UUVZZGFpcmRGQzNvUmhCQjZTZ1hSZVY5RFJEdlZnRitwT1FHZ0ZuUFJrQUZz?=
 =?utf-8?B?c2NzS0lOaHlGblc5Y0x2b0svdjQ3ZUxXUENXdzNYK2ZCUUxYODljamtYV3FX?=
 =?utf-8?B?K2d2azBBdmZNTU42bXFrbGVqdnF6RVpEQlN4WnJmOTU2OVpEcmZXZFR0dUxz?=
 =?utf-8?B?ZnFQaExpa0ZCRlNyWGhMNTViTEcxL1RNcThmRURZd3c2MnR4RHZvSzdpM3VF?=
 =?utf-8?B?SGIycFFqaTlXcnhhZ0duTlk2eEp0ejJWQ2NnaStwUUlMMlh1bkZqWGp5OFVu?=
 =?utf-8?B?dUtWT1ptQ3JqT3VxT2dBYlhDWGZ0Ykh2TmlQMFdFQklFTzhUVU13OTNka2ZY?=
 =?utf-8?B?dytSVm1FVWphbUlJMGlua1IwTTBxZmpuNkZNb0FqVVl1Z3NjREVYU1JMb0hK?=
 =?utf-8?B?OXYyVnhJNkhSQ2lLbmgyNzhJeUZ0S2lBczFid0RuUkxCdEFMVUxIc204b0do?=
 =?utf-8?B?U1lUb0NqUG8wZmhNRjBnWUpVczUwenVjWDV0UUp2TGpFUGxtcWRzTGE5N2Rs?=
 =?utf-8?B?QzhCb3pxVzNTdElYYitFVDR2RzdPdFlJZHdja1piYjBFYkZXbFpaRXArZFB2?=
 =?utf-8?B?Tk15eGF2bS9Vb3FRazFoeWFpRzR3VFFxeUhpd1JYQnZYd0VxYzdJMXJzUE9J?=
 =?utf-8?B?M3VvOG54SFV6NjFQeHV0NTlwWVFIR2lzTndTZ2lvRW5uYTRPVDdnWUYvUVJ3?=
 =?utf-8?B?b1FQMGlVN0YvRzQ1enNLcFlWblFmS295bENrNno3bzU2eTY5S2NCTzlWUnBU?=
 =?utf-8?B?RFc5QXBId1Zwbk1wQUJOeUoxRFZMZDI4aHZpdmdBTi9GMEdoUjBZbU1iLzg5?=
 =?utf-8?B?K0ppcDVVN2NQdzBrU3FmbEJ0Y3dxdzJ5akdOeE9kcWpMbXBMVnc3L3pHOVVh?=
 =?utf-8?B?RDkzT0hSNHZWNUphRXZtK2NLZDZhVHZER3FFQTBmUGpwVnlWUlIwTTd1Yndz?=
 =?utf-8?B?NWIyTFJpS25RUVNkUFdVVWFycU10Zm0yZG8zeC8xcCtYL1hhWnlBTVI5WWpE?=
 =?utf-8?B?QWJoZnJWeVBoWWNtdm43ZW94enhnM2JiOVJBYm8wbk9XVFk5VUdySDJMdk1W?=
 =?utf-8?B?N1czeGZLMnZlQ2xwNVVpWi9xUyt4bFRnMHJPN00zY1EvS3UvTGtqYnJ2cHB4?=
 =?utf-8?B?WDlXUncrcFZCQStGZW1TbzlMWHo0TjZRdUoxNHhxM1FyMUhBK1kzZDFnMzAr?=
 =?utf-8?B?WTdVMFRvQ2ttL2NRNkkzdmFqd1Y4czdjZ2tSNzUwV0ZsQlg0NDc1VkxGSU9j?=
 =?utf-8?B?eDhLMkFoWkRQbC9Gd1g3SndUbjVabWhBOWRzTGNXdVNUZE51NmZKRGhrQjhw?=
 =?utf-8?B?em1TTkhtV2xhNWswZy9xVGpwbDBBNzliNlpGNmsxSU1XbXQ4WlBtL3N5SkxE?=
 =?utf-8?B?WTNrMHh1ZGZjLy9IMGFqK2RyWGZOUlpiM2FNb0hBYktpdzJwZzM4SCtMTVdt?=
 =?utf-8?B?SisvQjd3NlZvYkRXYVJiSVRZN2NrQlJJRWtrdEFRZjJ2b1ZxWG5UWTd4bERk?=
 =?utf-8?B?bGovaWpGTGhoV0pXbmNidlI1RWNHR2U0SENWcjhOYlE5a2EyS2ZTNFJFSFNk?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KlAKQQ6IssxBu4D/JpFpPZqcur8YueU6M3tvTv+va31cDfouviHefYXVlczR4dVkg3NYniyg02Fkf1TGp0fSYrm2yK6TE6TL5dz0ZPU+/l7VbKMvU16CpaLE6jWLK6WyhlHLOS4BWGUJH1V/e6qGxGFNeeFlCg2OgUzH75nkoa9D8506+OJg893G6f9gKJohJBt858YY1BfbsPSUDWamdo7kZdmAdAO9e36NNwpz10Ql92wm0DueFAg9i1A8OLQ6K3h6L4xNpNrHHhPUAeLqBMlrxs/eNGK7SpsaKBFd38/m/nXJGcYm8E67hfairZdljTvCN6RAI/7uHLlKiofR8OlO+FDuAs0dVMQTo5zd3c4HzZFGFW+SAs6u8+ElhT4RvO9D360WpR4Pw+lAsgzKelElh/+/Rqf0W6oHXE7GagnmzF7dEhFaiPuxKgPIHJIkonwJXRzaImkgb7nWbyUWkoU4SNqanpUpOgFEyie5N9SeEcNUqj3hx3sU1nyTZpcM7BxmYu9kbt8jaQslCjk46xStwwUtONu9vaQCic+5RuNE6RkftYDPRn1Iy+/YPCiYlEJAm9C4rdcYUoKpFni6+2kstlxCrIHSNO+7L/i6nNhUGiwVuIHTKAdiUeGG/YKDssCEJgNh2rxhfA2EOcgaRnSx9yy3NyBID/o1lxtUcOgs6g1nLxuMij9xvtyj+9EeMPx5pU1+6LsmfMu0wuF5ofAFTXkbjwPdyFzxpIxAgOONCmEuH0k7R9TJtuCwlI9IoVQgutpvWOSj7dsyBk6w7Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b93987d-7c02-4019-2826-08db7367adf2
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:28:54.1659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hav8bxNls+RQ0ZWgdCPf0/YlQvpsMnlY+h6U6ifHhv4qDkfpZzAgKno/FCs6NNy+C9NpyEUL1QAMkZwv/J8KOdFtiE+CT11+GcZ78Sdh270=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_16,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=951
 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220183
X-Proofpoint-GUID: b5CzGiLTwO9v-QONsNMLHSIrsrLGTHmK
X-Proofpoint-ORIG-GUID: b5CzGiLTwO9v-QONsNMLHSIrsrLGTHmK
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

On 6/21/2023 4:00 PM, Peter Xu wrote:
> On Wed, Jun 21, 2023 at 03:39:44PM -0400, Steven Sistare wrote:
>>>> -        jmp mainloop
>>>> +        # should this test suspend?
>>>> +        mov (suspend_me),%eax
>>>> +        cmp $0,%eax
>>>> +        je mainloop
>>>> +
>>>> +        # are we waking after suspend?  do not suspend again.
>>>> +        mov $suspended,%eax
>>>
>>> So IIUC then it'll use 4 bytes over 100MB range which means we need at
>>> least 100MB+4bytes.. not obvious for a HIGH_ADDR definition to me..
>>>
>>> Could we just define a variable inside the section like suspend_me?
>>
>> No, because modifications to this memory backing the boot block are not
>> copied to the destination.  The dest reads a clean copy of the boot block
>> from disk, as specified by the qemu command line arguments.
> 
> Oh okay, can we use HIGH_ADDR-4, then?  I just still think it'll be nice if
> we can keep HIGH_ADDR the high bar of the whole range.

Sure.  I'll use LOW_ADDR + 4, and add a comment.

- Steve

