Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F13527240C6
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 13:24:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Ulw-0008Km-VC; Tue, 06 Jun 2023 07:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q6Uls-0008Kb-NY
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:22:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q6Ull-0003OQ-Bj
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:22:40 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3565wDUx022543; Tue, 6 Jun 2023 11:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/4L3wUZ2y76HZq5vmYRK9o5I9uOHCt8Ei64I/uBIVIQ=;
 b=l5yEGorDazu9RAL+UYGVMpeuVzLv607INSOlQZJk+uOKiLQLLUaZ3FFfibSvTO1pWjyj
 P6B3kV4dO8smA3lLACT2iypY8mHz2xgUo+kxqAkfuy//MFnqfoIhm89c/D4Aw/+U1p+U
 QDHVS0C7UoS2uLom/JL+AIgtd4DivdkAbgWTMtt0wm5oZFJAFr47fCfw81zvs7i0o3u9
 eZQq7Gbe9JNyry51Y6bWSdkqSsRN2Dktgi8s/pu6UkgC0tAdFIRzhvGU+UxO7YObaSP6
 om3BGJiP267vAdYKk5GE1FBNoYrIFHtWLxUmecynRb+mEHXTFie6jH1VrVxEQgNNWj9u Bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx2wn425-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Jun 2023 11:22:25 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 356BJA5H019455; Tue, 6 Jun 2023 11:22:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r0tsxgmfa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Jun 2023 11:22:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOIpXOS6F0G6iQNjRYPgTskELQqR7fGTFJdLkEpQwscDxNstsfn6Bqvh8q6CNBp21WYnlyrtEixXW4rCpXb6MxP6QL6R4ORSdQ3OhsKZVj1iEhnVev/exLQWwPFIgKStDcr2NGDpKkBofVX3Dtx+7RT+NIDN5oAMPc0nP55paiPajU6GmRsG7enm7/Ng2feGbsdTy9U4aoenY0Wdxoik9hrdfsBsWU8m3i4YOTU6rsAPHVhRsO2uSUSn+eWNWwt3lF76gDr4Gy2U8mTg/CqphZxyBj8MRT1qn1T5CaecBMuJcc+ILEpVk80o+odWU1It5qyT13YtPRhtE6S1nyePqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4L3wUZ2y76HZq5vmYRK9o5I9uOHCt8Ei64I/uBIVIQ=;
 b=V1cTSW0yqQ9JUZ0GlaVmW7atfZ7Qv4UxOBKogDBqYCBnugKmAlY5Y/kNKseHj2QOEH6ZktxFli/sP/3jI/v4IaovmriP56ea20m0bQtDXeH5DD1Mu6Zr7sbUCZfyHl+rAvtAm450UR+2+UfEx41PDwx7zfGgk2eL3RzMG9gP913zhiTqtLc+6DIi9YCpq258BbROpdLPUqzDHDE8veLpfxS6dCun4NSZEKB2/b+p3o600A9+5qJG6WEwxcwb45PKsdaXEr6eVvtvhuVDkJPqs7pZmGPAd1kQay8FGULrAfo/5iTit5lBZj1nb8jW8W+iEgm5JTQVKmYf/OXp49taKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4L3wUZ2y76HZq5vmYRK9o5I9uOHCt8Ei64I/uBIVIQ=;
 b=cC1dfBqpZzzWnjnhK2OQulKhSMByov9yXXounVs880qNJM4bQuUZ8byBubk2JTVpcwjVPMCwCEl6oUpnUXQiBC86w1fCzSU6AjGJn611KCag8i6KLhih5JTb+3hzPdXl/6pRO2PNTi2Tx80Wma+fRIXFnryy7gKriC2CSTpswcI=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by LV8PR10MB7821.namprd10.prod.outlook.com (2603:10b6:408:1e6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 11:22:23 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 11:22:22 +0000
Message-ID: <8db546c9-395a-432e-ef07-ed6d6447a097@oracle.com>
Date: Tue, 6 Jun 2023 12:22:16 +0100
Subject: Re: [PATCH v3 03/15] hw/pci: Add a pci_device_iommu_memory_region()
 helper
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
 <20230530175937.24202-4-joao.m.martins@oracle.com> <ZH4UAtl1v8JDWsl1@x1n>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ZH4UAtl1v8JDWsl1@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0109.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::25) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|LV8PR10MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c3e20a-85f1-4555-6209-08db66804c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 752nPk70SmkvFOekCmkou378c7jIhSM06Kt+i+cJS7Wh/dH1I5WYs3fGlwZnRGo2vx9R/g3ESbEG5hHRtQvOVOKlSGdivjtJZKJ+xxdBp9/OMTrHs4uM5mJ/it+u2Cm20cE6UeJyWPhK1rLOHN/W0YjeR/nfFmQvW1b5dGFVvLU85FrZHoGGbhVxOqvlCoK7HyS6grLhFNTH+TKN2gnW9hM2stQMNEmhMvRxMOYO3oS3BAx0wbQkdD85HKVzmJzE+SSizwhclt3Rv/CNM/dlgFsSRa66s0E0toOezL1HFUACL9Q7CcBW5GU4WHed7/dtl64iB0Zwun3DPJtcG+1XfHGa0apVHnrLLl4HGMzCuTOjI7RCX6AGtyIbB690bW6lHm/W1HJlYmVo3mdaUI/NSD8rG7KeZ06tOJv0xWvAz5b2w0JyYYeeCdFsXdTD0RJejwFzMG+VtPBYBdCj5kVd+SDPBzsBNXB05ZQtgwUyE5Ntl5bNqkECnsYbwmaEPDXxiPCjfvR54kQsNCz4Jnrv6Q4LBzj/YhotWZ2LLfVOFxDPVEPpgh8BfNXSKAVaOAsCJ93bkK9SpQd1T7OYYFmJ7IXJccicaVG1p9Ne8gdFCaNU0XxEhVBJbATzAGtSe/NJzhipJVeNk07yTb3+gpP2j8VInLVJdT6tA1gwUQ9dqg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(2906002)(2616005)(36756003)(31696002)(86362001)(38100700002)(6486002)(41300700001)(316002)(6666004)(5660300002)(8676002)(8936002)(478600001)(54906003)(66946007)(66556008)(66476007)(6916009)(4326008)(31686004)(6506007)(6512007)(53546011)(26005)(186003)(7416002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkhQKzJoTWdhSzFDbUNkQUdiY3IvN2ZPaDhObVJXa3NLMGMycVdEZzhEWHlN?=
 =?utf-8?B?MFhBeWd5d0k5Z1B0SUp1ZUVmeGNNaDdGazZkRG1OU0Vybk9lRFBkQVhFbGsz?=
 =?utf-8?B?ME4wb3R2VStEd0FuZ0ttQjFUalFHSnpoSFEvbFhJdVNjbU5ZSzlmbStPK1o0?=
 =?utf-8?B?TUNCMkpXSWVVZTBKWG1YMDJGOVgvaW95K3c1ZEp0QlAxRjUrR3JYaUpVQUJT?=
 =?utf-8?B?OEk2S1pWbTk2ZnFRaERxODdDckhPL3ZrZnU1WEljdEpLSldnR2h4WER6b05F?=
 =?utf-8?B?Q3Z1YlkyY2VqZzNMaGlPQjJiMzNOcjFyQ2l3WnZQNUs5NVNjWmNXV3NvMzV4?=
 =?utf-8?B?SjFmK1ZFRlk4bWc2ai8zSW5ESzd2SmZMYkdiNnFIcmkrVnI4eXVRRHFBbHJR?=
 =?utf-8?B?eVFXQXQ4TXRwL0JsZW1MUlg4U0QwRm1qd0NFcEkzcy8xcWxNTGZBOGdaZXZL?=
 =?utf-8?B?WGlWYVY5TEZLbWVzMlZHcmpYaFZHOVdkcWt3TkZjRXdLZ2hSNXB4QnBEcUlD?=
 =?utf-8?B?WVBCQU9GcHRkcXhOYjNGTytLSWo5NWNKZnB2WWVHayt5c1lGcUNVOW01c1J0?=
 =?utf-8?B?d2ZwWWQrRUNQSmVsc1JpTGJVcExMaDRNdEdaZWhJZlRaRUcvdjVJajRVaGRk?=
 =?utf-8?B?UzdiVzUrKzRuSStMdmFLcjZEZk40TjdSSFh4UnFaV2txQ3lxV2ZKcFdlbkxG?=
 =?utf-8?B?c3RvWVVwL2dLUnlBN3RWZFlIb290dTQvb0FaaktUMTNkWk9yZjlVc1JycjdF?=
 =?utf-8?B?b1daM1BnREt5bXpsQWo0MXBrUVA0cEd6SUxTUWxLbE1qQVU0V3A1SDhSMHp5?=
 =?utf-8?B?UGVndUtPVHZkVWJKbHVndlNHNDIvV01uemVUZk00eVhTUXRwL3M4cFlUZU9S?=
 =?utf-8?B?aENwWnQ1eXBqNFNPZ3U1cW9uZ090Y28zK0grUWpnY0J0UktrS0NUcTBVOS9C?=
 =?utf-8?B?eDRuaDVsYWcvZzhFcXl6eGhsWmJJdmExaUl6NEpSS2RYdFF6NDNkVFlUSXRl?=
 =?utf-8?B?WGxNcEN5Y20wRFd1WkVBS0xldlFJaVRIVnFWOWV3d3V2U2pJWUdWenJETHRS?=
 =?utf-8?B?bTRwd21qdTRmTmdNVXNPMjVzVG5EaXNsb2pOVEJvbEFNd1VCaXRUSXFxc3Nn?=
 =?utf-8?B?VHA5ZzhteDBadXZBd3d5R1lJNVFsZlZTaFNoTzNFQUQyaUVNTThsSXN0Smt3?=
 =?utf-8?B?RndFbzM3OEdudDhsUDlNa2o0RisxT2RPaEpMZHFncVY1ZlQ1TXcvcmlRQnNl?=
 =?utf-8?B?ODVEOVZvSGNOVXBuOWtqV3hYSXR5VW1LSnZ6U2dZTUYvVUVMNFc5QUNiSlMx?=
 =?utf-8?B?akVhM2ljY1dPY1hTdGMvdjdkZ1BLeDNJeWtleEw5UktEclZ6Y2xOU1NjSnU2?=
 =?utf-8?B?dTFSc1ZnZWdpUzNwbjRYVTlaT2ZFUDdKWGpVSzVLeDRQSEdNK2F2bSs0OGto?=
 =?utf-8?B?d2xiZnFIek1XMDJ6MFlRWmZSektEdElMeWFCSFlVTXoyaHpHKy85Y002SDBB?=
 =?utf-8?B?dlpSb3hPLzFXSS84dWNkcjJoR29XN3p0V2ZXa0ZKSHJIbWVIbTcxaU9KVEdK?=
 =?utf-8?B?SGk3ZDVyR3NqeHBvU3lWM2VCQjVSb0paODc1Mk5haDZOMEtpbHp0SThKZzRr?=
 =?utf-8?B?Y1JnbXlnWXFUOG9TNWRWaW1TanQyM2Y4cEhVWVJQdVRNRjlwVE9YbTB0d3Vy?=
 =?utf-8?B?SXFVZlZmdXBFTEpqaHNlaGlGdkZ4cDU0QnBuRlZTS3cwb21nYkpsT2ZxeDRC?=
 =?utf-8?B?dVJ1RHg2ZStFV1JDUnhUZzRRWDVxY1Iya3RUT2tCUjBLcmlHUFQ4aG5FaTM3?=
 =?utf-8?B?TXVsQ3hOY3ZJemcvZzhsaGQ2NmF1UDlKaXpJdjNjeGdHb2QxVXJIWGVEbnJx?=
 =?utf-8?B?TjF3ZFZlamozMHh1aVBNRWpIZEswVDE3eDNBS0YvK0g1c3BHd1k5ZEF3elZh?=
 =?utf-8?B?bGRDOGdTdmlsSjlrZ2g5SDVIano4S3ViOFZyUlo2a2cxMU5UTmhqeHVKRFVP?=
 =?utf-8?B?akFXeTdEZDRoVTl3ekNrTW50aHF0TnAxSytYQWE4VkZaUXZQazQ1cnZMZUdq?=
 =?utf-8?B?UVVpdmM3OVI4blpjUk5YdW1INjg0OWlkV2d6NERCZnh5eXJ3bjJvaFdSNXp1?=
 =?utf-8?B?OUFuL1lIMGdkRERnTC82TnV0QXU1TEg3ZTdHbUZ2RnBFSWJLblFpRzd5SWJK?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TAfa/Bn6peQlw52anRtP9CuBbesNDJNuvtD8y0sErnkEeF4wwqpYY4fy5r8HvCjKpD6kRWzL4ZrD96NO0PjMs18VRQ6GlJuohbPKQhYwImSXtnL3aJ9g36Ci4+RD4Bm+LhHf0BtcKWFmkjN9UtI1BEhEVqqaz7opWnr1cK+aQ2SRBg5dWdyt0hkodbO/L9j7XPyDxoh7vRLAsuP5teYi5i/XWvjjKRV9Audijh4mY23Cp2eTtA/5AQD1Lq6wkfcI7nztxexxwenH4lDUVB/Q2etaqk51yWIWnmKjbmcUCtrzUqXsnhqkyP65tqfk/yoTu+PtkUQEx7sz5fdon5KEwfcYh0QvdLvezI8pnocZFbFkmmvZn93CdqvGgX74CeWEWFmoXRdGmzxvj3zz1RlucbOo5a8o458MnMwtNSLb01G28+s1++hQJLXel4CCbZWhVGqIK937J/po926skn2wGr2OF4R2I1OKDbxd/pg6OLRj1ThhMyP79GjxBc/yji1lJrNpQoR47MsJHGDUOEgnDkKzvKoAQ5c047gKaK5qaDghHi7kQuVRb24LDQcaW2ITsPyAXWd00cRDUlXmTFZuIxKYSAwbhn2uU+8SS4PkCIYEsAmA22X0h2W3ICkVLRYZ3c9Brcu4RP1P2errpV+PFY6I8Vy1PXw7uW2xrISAIfpUGgxMYE7/w05Xze0DJ188lgjNdUxpvKBg8Ban/I6e73finN6gGkGrqAShB95EJ8ix9heTNkfZoAO2GJnwsX6UWzDLwKpjfM4ouIVGT1nt4XbCh59x6XGk1p694Kh92T0SmmIq3kDvqVVkQexXgFBmhPKzKhNyWiyRQCfvvyp03Ru96PO0++U2lsqWdtBN+WUpdH7jwki+n9skAgtnuzlw0qJc2wv6FMAW6desuE2JOg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c3e20a-85f1-4555-6209-08db66804c6a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 11:22:22.9002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZouWwyTJzzcIAi2wh+/EZr5l6YrZoVgvhFFGi7tDc5MSKSJKn0PeH83vlTl/4wILYHxCBEU/df941BKtbOgeTM19KSTkyF5gdlWUwQXrKz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_07,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=831
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060095
X-Proofpoint-GUID: xiD4LOxxBoi7ln7Sl08lRx5WDIscwGPj
X-Proofpoint-ORIG-GUID: xiD4LOxxBoi7ln7Sl08lRx5WDIscwGPj
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

On 05/06/2023 17:57, Peter Xu wrote:
> On Tue, May 30, 2023 at 06:59:25PM +0100, Joao Martins wrote:
>> Much like pci_device_iommu_address_space() fetches the IOMMU AS, add a
>> pci_device_iommu_memory_region() which lets it return an the IOMMU MR
>> associated with it. The IOMMU MR is returned correctly for vIOMMUs using
>> pci_setup_iommu_info(). Note that today most vIOMMUs create the address
>> space and IOMMU MR at the same time, it's just mainly that there's API
>> to make the latter available.
> 
> Have you looked into other archs outside x86?  IIRC on some other arch one
> address space can have >1 IOMMU memory regions.. at least with such AS and
> MR layering it seems always possible?  Thanks,
> 

I looked at all callers of pci_setup_iommu() restricting to those that actually
track an IOMMUMemoryRegion when they create a address space... as this is where
pci_device_iommu_memory_region() is applicable. From looking at those[*], I see
always a 1:1 association between the AS and the IOMMU-MR in their initialization
when iommu_fn is called. Unless I missed something... Is there an arch you were
thinking specifically?

[I am not sure we can track today an 1:N AS->IOMMU association today in Qemu]

[*] alpha, arm smmu, ppc, s390, virtio, and some pci bridges (pnv_phb3 and pnv_phb4)

	Joao

