Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DCF770302
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 16:29:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRvm3-0004l4-0M; Fri, 04 Aug 2023 10:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qRvm0-0004ku-H7
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:27:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qRvly-0001bc-25
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:27:24 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 374Bx2Bp002542; Fri, 4 Aug 2023 14:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=jVIa7OJfLNDFrHXNgy5au62GmsPp5zgEQCt3IOyFoLQ=;
 b=q2bSPcMqg6zZwEU0fLm8vSZ5fwqBEkLGqoM2MWBE0yAzsL2LSyIfCk8rHX2oSjBYZHrw
 yNjYZvcoO7LdGsjnqB9AZ/AfXxlPgxvYPghFrCLwEqBGWbEjSX2XB0gciLMTKwJrg1Fa
 26MGUgaySi45lYIryoIriYOwIAlvakkew4+Qv9Z+X/vqi6E6gEIFD7zoXBI1VlAMZpeK
 FSdqetUTJrL7FkuxylAPyZsZgYoumOzlWWLa2o/Z5gAfyR5fPivjGz4Ifx/A0TCRi+Ye
 aecBmbseOFbMS3TTKtNykzkRRt5BGZCEkCtLNxd8M2Dk4l0GqoRK6xPgrqa6GRq9lIZP wA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spcbyf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Aug 2023 14:27:17 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 374DMXf7034896; Fri, 4 Aug 2023 14:27:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3s8m09cyug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Aug 2023 14:27:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQ7B+WCUTDGgEOqQDFSxGAQ83ENznsPWEUpcnST+3jpXJ1e18BCNWUu3VT7pNb2A4N7QrsWsKE2BjlqDmGHJjkp1mdnNYwNEu7ygiXkZ6NGfquLZaR5qseuwOcAJP1QztTewPAZ2T4NdvmEudkqqCMOwBSR/Q8a3Hkq2F1Gi8m9DIooYyis5H2twHFZ/u8FJaOnQA9+gdok1e0Sm6eQy3vHMsxidXE8+9MZUvigc1RYBKJlaePjhNYlqjECc6WgaV4QiXGBi1Hrv5KkIHZpWT3F229t0ot8epyyGpqzkzh3XRn7lRqo4i7wo+Q4QXmHstXHkgC6HU5HQc2lxMzCR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVIa7OJfLNDFrHXNgy5au62GmsPp5zgEQCt3IOyFoLQ=;
 b=IhSvXW8Fnw+gOjhQZNguCRZsraoZuSgKGS58s3WvlFDK6a5qGVv8O5hZPEw+0+Ws8GqYQCJ8iFC9BQXmk9yPmiWHEqiTCm+iUq7pOFg4ijP5wR4pW+HLRCfiWrs+rRHrAtQEb1fWAsh11Y9bJ44Rxu7mzAgcvK2+YKxHu/ilIk7+qrCAG1haP3852iOsSANAU9I3bFzF70Z17erVne02Smt3xJGRMEv5K0ZXw7gC5uC94cHxT/73QSF20VWSaMEB+Vjmxwv6Y1xjZj9qfnSrNdEKjvz/fVRke9f98wWSSbLL2MyK2AM5N4TurFW1FH5MVl04yvlKYal1qMKuBwCReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVIa7OJfLNDFrHXNgy5au62GmsPp5zgEQCt3IOyFoLQ=;
 b=dBgsAUB5YfId0b44m55SV0HRd47XTAtMKzV0MxNmMt9swjaewB7P73+MS38Wz7bhLOcVbjYw6wbK7FLHL8Nh0kBi2fY/cPk5/v6zsthw3rlZ3tlWmkp/T4rFn4lyzMr2nH3A3sUtKdTLO8/djoa53dv/j7WUVkMsjuqWlJ6nRbY=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by BL3PR10MB6188.namprd10.prod.outlook.com (2603:10b6:208:3bf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 14:27:12 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::565f:a60:aaf8:bae]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::565f:a60:aaf8:bae%6]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 14:27:12 +0000
Content-Type: multipart/alternative;
 boundary="------------0BnP0X0w0JX9mYZvrcwGKZUo"
Message-ID: <63c0c8de-0cbd-11c9-fedd-8e71f8febfa1@oracle.com>
Date: Fri, 4 Aug 2023 10:27:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/3] qmp, vhost-user: Remove virtio_list & update virtio
 introspection
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, laurent@vivier.eu,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
References: <20230803145500.2108691-1-jonah.palmer@oracle.com>
 <20230803155022-mutt-send-email-mst@kernel.org>
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <20230803155022-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: BL0PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:208:91::16) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|BL3PR10MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: f098ee6b-0074-40d2-e2e6-08db94f6e4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2VR9lAIHq8abN3MihnYFfdi/wsWhYQvRLnHwh5Ye8RZUX9/a1Kyt6nZcmVYjozS67KY93AwUkoNAtEFG6bXsqJgjHOZiuPGwq1QX0sbf32Q+gvoWGLRLwu/DB6NIgqk45kj6B5evp4lDRWlyMnZpMDPIj1VJCh/3DKelc3vSHaUxASsQLOgJmaZCi4Mg3Q/SzX8Pbjhd47bT6vtl2HRKWNTs12gNI6p7lvyslo/1M1qzI/xiFo9uP5qa9B+JN0iza1OlywM1bKp0MDtMo7B67GJJHT+fuHavEn5SEUy39Ps2TaxvSx6faFwXEeZ0n3lBY2QAtrBj1Gb+edioTho+UfxgdEN7mszFQEuFJrYmtVrjcoXxxIDPKkBt++ptyWmBjYgoEq2iYRQQrn/0CSLPdWcUh2bVbMp7o+BqopEY0locq3cNK70j+NM/q5k/IIKJ+uSm5f5Qy7rZ8P24tjCsF4hBahf4LLU6VHXNNKVWQHjjAbfGLZ4YpiZTmcYgLmEDQbFF+miqog28s45RWhPHWUzsZnJn0a2Og/GQXPwOuqdp6T9SvbnMs/9Qid5G2U+Gc6cOejgpus1XtmRuD2XcJ76glTf2KTQ6p35CxCj/Yan8hZvtmW8nvOFfv306goJ4PLNOt9Mc3rvnOWpmclhmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(1800799003)(186006)(41300700001)(8936002)(8676002)(83380400001)(53546011)(26005)(6506007)(38100700002)(2616005)(31696002)(86362001)(316002)(6916009)(478600001)(6486002)(6512007)(33964004)(66556008)(66476007)(4326008)(36756003)(6666004)(31686004)(15650500001)(2906002)(5660300002)(66946007)(44832011)(7416002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2FmSHlvRmROUVlVN1paWXpidWM0UGNvdFE2VHluYnprUzNnY0lWRFpSbWpq?=
 =?utf-8?B?WHhzdWJ0S3k3cHI2aE1JU0U2aTVoR3laS204aVpHYlc4ck1CdjZxQlBncWhM?=
 =?utf-8?B?TVdMM0ZMUmdUa1k5Z1A1a0pja3FmeEtrVzZBd21JQkM2OXlOR2phV3VtS0Fu?=
 =?utf-8?B?RW5HVXpZRm9sNm5JZHhZVnhYOWlQMUhqOTBvNkhhVG9RK1A3UVdIM05OcnU3?=
 =?utf-8?B?QVVya2ZPK2pCZ0JmMkxOV3RZTjVXS2hwZ01LZENWZjZlbXZ4NkJmemRPb0Qw?=
 =?utf-8?B?UEZiVEUvaEw4cGl5OHpvcjliQTY0ZlAxbGdtN1FSK0EzU3N6YW1XWTZvL3c3?=
 =?utf-8?B?eGd0NjFaZzViK0I2eFV1NW1tSWdIeW9KV1FyWlQ2bjlUMFRMWm5QTnl4eGU4?=
 =?utf-8?B?cnRHNUs2R0pmTzJHcXNudjNHckRpM1ZOb3dPMTlaL1hnZ0N4ZXVrUGJ0dFVi?=
 =?utf-8?B?dWNGbzJmRlNDVUZRT2p6T0pLVjVZc2NWN0UvYnRZOUZJV1NUYm1ZRmowaXJ1?=
 =?utf-8?B?bHhJZVpsUnMxa3NNQk1oNXpWS0hIL3J3bUluQ3hxc1BUWXFUa2VlSGFISmdl?=
 =?utf-8?B?QTVzTUx2SHIyNlBhUjBlM2o1VmFHeEkvSVdPZWwrQllBQlNpd1FObk51VURr?=
 =?utf-8?B?dlVNdkd6am9QZFF1K1k4VVl6VDdwejBoSTJGR21QMjR5VmZndjBrQ1E0YzNL?=
 =?utf-8?B?ekhkN3M1cWZ2RzErUUNnT0x1dzVJMER3QVZ0bTRDdHZRRndPUTB4UXdlaTFL?=
 =?utf-8?B?Mmo1djVYTmxoQnU1aENXYTBzWmlNbTF5b1Nld0NKT1Z5TmlLZjk1ZUNmNXVq?=
 =?utf-8?B?RkJBazIrL0FQM1d3VVRVVlVRd2Q4WkZUMTd4eHdHNDBrbUU5Ty9YMURYczY2?=
 =?utf-8?B?SVRPVnp0ejVPbzRwS1Y3NmhaZUs4U2VzKzZCMy9zQzIwUVp4Zmd0aGQvKyt1?=
 =?utf-8?B?TVFOZkYxN2NwM0p5OXU2NzJGRVhBLzZqbmt2S055YWxFNE1qNnFzZUtuVUZK?=
 =?utf-8?B?VThWSkdFbUNkUVpGV01vVUdUMXNmcWdPd1dUbE9lNVZocEZnQ1IrR3l6WlVo?=
 =?utf-8?B?bzZ0RmFPdm1JaWlYMTNlTE41WDVRSThuYzRwMzFPQ3duajV1L3RaY0dkYUtC?=
 =?utf-8?B?SHltZU1Bc1pYUy9ScDJoTTZ2SWw0dTBTQVRDbUppd2p1Ty9mbkxnblFjV3R6?=
 =?utf-8?B?aUloZUpES21maEVNaC9Fa1IxNWdjS3h4Wi9zTjVOVSthV0ovRW1wSm9qT0ZG?=
 =?utf-8?B?WlFpL3N3c0drV1d3SlUzMVp6R1hsaTA3R2s4a3RDaDRNVzVWZjdhbWx4V3lS?=
 =?utf-8?B?azRvOFJoOWFNWnZEbHVvSnhJZTZ3djUvcTVLMEJUc3ZKL3Z3clROQ2tGZUJx?=
 =?utf-8?B?b09YdVVZRXl4NnFFYkhNYW4yRng4RmRQN0thNThCNlJGS1BJb1lRL1Ywd0p2?=
 =?utf-8?B?TTk3K1pyamcxMi9taGxYRzR1dnd0eGU4V3h5U0k3cnlTUDRCZVI3Y3puMkVI?=
 =?utf-8?B?UkNBUldGb0lkYkFrU0JyZFVSWG9ZaEp1QUptWmVkVmNjN2RwODYwVEFMWGJW?=
 =?utf-8?B?RE9TN2M3NnkrbHZ5WjBIazhsUVZXZHRuMWFhNnlHQk5QaGo1dGdPQnhVVU9C?=
 =?utf-8?B?VnM3S1BZUkZYUVV5bDI5bGp5Y0JuTEExUmYydnVUOFlOUWt4amJxaVNTd0NR?=
 =?utf-8?B?OFNMY1Y5U0Jxc014akpiMCtDTWdIRGZlUUpEM0Vmd1h4SWRDMWtsWERjb1By?=
 =?utf-8?B?RmVYT01OR215ZTRWL0ltWS9rUi85M3BpUU9ra0NmM1p0SXJzSFd5dmhQYUQ3?=
 =?utf-8?B?cEFSWEZmQm0zQUNnWmUySlZDV1ZyL3lzWExROE5lT2Z4UmVyRU42bGVhR3Q1?=
 =?utf-8?B?M0VmdXlZY2g4ZXdJbWZFcDNjWnU3dkUwTzVYNmhBN05nd0lWdW9rVU9mUktR?=
 =?utf-8?B?eWFjYlpNWGd5OWphRU9BTGphdE4wekpJdkY4dWRlT1M3MEkvcDgvV0JzTHAz?=
 =?utf-8?B?MCs3OEZDMDdXdFJ2SERkbGJoQk9FZkd0NUpjSmE5K05sUUM5WG9jSWtJb1I4?=
 =?utf-8?B?MDNvdjVEaG4wUkpVZ3hLRlhDbkZBR3dyMDNobHJmRFJrK1BKMXNqaDNwTzB0?=
 =?utf-8?Q?kikW1vpGOZKtulZtxUYVejeAy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fs7ux0Xrq02TZN0Kszwrg/dimwMo83hlp4hzCvjkPSU3R7Mwk+3qWmWeeHI5eWSM9yqb4OVWn774yGUK3Oxg5sQQxZpxshKfhWyK6s2tAQQtjkJZY5Yd9LyIjy1oIISpUaos9WfNNFezrVOaeynKxP4jUeXdpqxtHWN4/emm9Httaddco28tXuIzmthmsLbhK1Akrt1bh9H/AcXtQc289mIvn6SfhaA8tpn280nbClxKVuWL9TaYjV+egCnrrMONC7i6A9Mbf3fSZWkx4ugxqyws24aKvhRYTY/YVjhoT7KGcJBmBXd8HLV5wy/DHLeLNiB0SO8AJX41n280z9XC1S2K0YVu1+QY42hB7zrrldkgGtncaEw7sFddbeH9JDzj2fbA4BnB3z9HYgI+lPyuga+B63Zmic6C0p2FXaBMRclzDij75VYjGv99BMvf1cAjfMVC0UFXYWNpDCiTMwYkchoeLGXV7qYTuvtKR0urQBvnQuPnJprKW7Awf629+ouC+No4KWN0DwQgKzSAG5kOlyCvs1qRZt93mBTyWk6IguKiHb8Nx6UYPvmozrG8RNLLaRJNFdU20uweToyp2J1rycV2zPURXWPJk/KO+jJhIeJLmCkQaCoenKwuOH07N0Bo53gI7xPv9gmS1n1avCJEW7LWZrLe2lkMGm6bFIdm27tOjX+PaVyj8urPHh5tmTQRlKhKjSmSoyON6ZqKoM49vOiZ8X2gRX5/QRXvvPegdm4q3Q7DdhgHKPZ1/lYphXCO1Q9PCmxpDKRiFN8RBc7tmAD27ZdnEkmxOHV77O1axI1udtJ7ZoVt6eHBgQDrDho+y/6xZ4tkAOfwHo1zUz1jJT8VFK4Qzvz2L6ZR6VctQAo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f098ee6b-0074-40d2-e2e6-08db94f6e4e6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:27:12.7591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYy0Ab3pEJdj2MmQinzCdtd1rTBz/8b/dhv+xnyGfAx22Ro+BqCdqHgfl1qH5XJahQ2bVlS7SeUys8KopsDopw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_13,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040128
X-Proofpoint-ORIG-GUID: 82jrIA9AKKeP57dHwnbmh3Yzss-sgrb1
X-Proofpoint-GUID: 82jrIA9AKKeP57dHwnbmh3Yzss-sgrb1
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--------------0BnP0X0w0JX9mYZvrcwGKZUo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/3/23 15:50, Michael S. Tsirkin wrote:

> On Thu, Aug 03, 2023 at 10:54:57AM -0400, Jonah Palmer wrote:
>> These patches update a few things related to virtio introspection via.
>> QMP/HMP commands.
>>
>> 1. Remove 'virtio_list' and instead query the QOM composition tree to
>> find any active & realized virtio devices.
>>
>> The 'virtio_list' was duplicating information about virtio devices that
>> was already available in the QOM composition tree, so there was no need
>> to keep this list.
>>
>> 2. Add new transport, protocol, and device features as well as support
>> to introspect vhost-user-gpio devices.
>>
>> Vhost-user-gpio previously had no support for introspection. Support for
>> introspecting its vhost-user device is now available in these patches.
>>
>> 3. Move VhostUserProtocolFeature definition to its corresponding header
>> file (vhost-user.h). Cleanup previous definitions in other files.
>>
>> VhostUserProtocolFeature was being defined in 3 separate files. Instead
>> of 3 separate definitions, use one instead and add it to the
>> vhost-user.h header file.
>>
>> New virtio transport feature:
>> -----------------------------
>>   - VIRTIO_F_RING_RESET
>>
>> New vhost-user protocol feature:
>> --------------------------------
>>   - VHOST_USER_PROTOCOL_F_STATUS
>>
>> New virtio device features:
>> ---------------------------
>> virtio-blk:
>>   - VIRTIO_BLK_F_SECURE_ERASE
>>
>> virtio-net:
>>   - VIRTIO_NET_F_NOTF_COAL
>>   - VIRTIO_NET_F_GUEST_USO4
>>   - VIRTIO_NET_F_GUEST_USO6
>>   - VIRTIO_NET_F_HOST_USO
>>
>> virtio/vhost-user-gpio:
>>   - VIRTIO_GPIO_F_IRQ
>>   - VHOST_F_LOG_ALL
>>   - VHOST_USER_F_PROTOCOL_FEATURES
> VHOST_F_LOG_ALL likely does not make sense.
>
Ah, okay. I can remove this in v4.

I'm not very familiar with virtio/vhost-user-gpio other than that
it's a virtual general-purpose I/O controller that maps native
GPIOs to a VM, allowing the VM to perform GPIO operations via. it.

I wasn't sure if the vhost-user version of it would make use of
this feature.

>> v3: use recursion and type casting to find realized virtio devices
>>      remove virtio scmi & bluetooth feature mappings
>>      revert virtio scmi & bluetooth case changes in qmp_decode_features
>>      change config define for VIRTIO_GPIO to CONFIG_VHOST_USER_GPIO
>>      move VhostUserProtocolFeature definition to header file
>>
>> v2: verify virtio devices via. 'TYPE_VIRTIO_DEVICES'
>>      verify path is a virtio device before checking if it's realized
>>      remove 'VIRTIO_BLK_F_ZONED' update (already exists)
>>      add cover letter
>>
>> Jonah Palmer (3):
>>    qmp: remove virtio_list, search QOM tree instead
>>    qmp: update virtio feature maps, vhost-user-gpio introspection
>>    vhost-user: move VhostUserProtocolFeature definition to header file
>>
>>   hw/scsi/vhost-user-scsi.c      |   4 -
>>   hw/virtio/vhost-user-gpio.c    |   7 ++
>>   hw/virtio/vhost-user.c         |  21 -----
>>   hw/virtio/virtio-qmp.c         | 154 ++++++++++++++++-----------------
>>   hw/virtio/virtio-qmp.h         |   7 --
>>   hw/virtio/virtio.c             |   6 --
>>   include/hw/virtio/vhost-user.h |  21 +++++
>>   7 files changed, 105 insertions(+), 115 deletions(-)
>>
>> -- 
>> 2.39.3
--------------0BnP0X0w0JX9mYZvrcwGKZUo
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>
</pre>
    <div class="moz-cite-prefix">
      <pre>On 8/3/23 15:50, Michael S. Tsirkin wrote:</pre>
    </div>
    <blockquote type="cite" cite="mid:20230803155022-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">On Thu, Aug 03, 2023 at 10:54:57AM -0400, Jonah Palmer wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">These patches update a few things related to virtio introspection via.
QMP/HMP commands.

1. Remove 'virtio_list' and instead query the QOM composition tree to
find any active &amp; realized virtio devices.

The 'virtio_list' was duplicating information about virtio devices that
was already available in the QOM composition tree, so there was no need
to keep this list.

2. Add new transport, protocol, and device features as well as support
to introspect vhost-user-gpio devices.

Vhost-user-gpio previously had no support for introspection. Support for
introspecting its vhost-user device is now available in these patches.

3. Move VhostUserProtocolFeature definition to its corresponding header
file (vhost-user.h). Cleanup previous definitions in other files.

VhostUserProtocolFeature was being defined in 3 separate files. Instead
of 3 separate definitions, use one instead and add it to the
vhost-user.h header file.

New virtio transport feature:
-----------------------------
 - VIRTIO_F_RING_RESET

New vhost-user protocol feature:
--------------------------------
 - VHOST_USER_PROTOCOL_F_STATUS

New virtio device features:
---------------------------
virtio-blk:
 - VIRTIO_BLK_F_SECURE_ERASE

virtio-net:
 - VIRTIO_NET_F_NOTF_COAL
 - VIRTIO_NET_F_GUEST_USO4
 - VIRTIO_NET_F_GUEST_USO6
 - VIRTIO_NET_F_HOST_USO

virtio/vhost-user-gpio:
 - VIRTIO_GPIO_F_IRQ
 - VHOST_F_LOG_ALL
 - VHOST_USER_F_PROTOCOL_FEATURES
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
VHOST_F_LOG_ALL likely does not make sense.

</pre>
    </blockquote>
    <pre>Ah, okay. I can remove this in v4.

I'm not very familiar with virtio/vhost-user-gpio other than that
it's a virtual general-purpose I/O controller that maps native
GPIOs to a VM, allowing the VM to perform GPIO operations via. it.

I wasn't sure if the vhost-user version of it would make use of
this feature.
</pre>
    <blockquote type="cite" cite="mid:20230803155022-mutt-send-email-mst@kernel.org">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">v3: use recursion and type casting to find realized virtio devices
    remove virtio scmi &amp; bluetooth feature mappings
    revert virtio scmi &amp; bluetooth case changes in qmp_decode_features
    change config define for VIRTIO_GPIO to CONFIG_VHOST_USER_GPIO
    move VhostUserProtocolFeature definition to header file

v2: verify virtio devices via. 'TYPE_VIRTIO_DEVICES'
    verify path is a virtio device before checking if it's realized
    remove 'VIRTIO_BLK_F_ZONED' update (already exists)
    add cover letter

Jonah Palmer (3):
  qmp: remove virtio_list, search QOM tree instead
  qmp: update virtio feature maps, vhost-user-gpio introspection
  vhost-user: move VhostUserProtocolFeature definition to header file

 hw/scsi/vhost-user-scsi.c      |   4 -
 hw/virtio/vhost-user-gpio.c    |   7 ++
 hw/virtio/vhost-user.c         |  21 -----
 hw/virtio/virtio-qmp.c         | 154 ++++++++++++++++-----------------
 hw/virtio/virtio-qmp.h         |   7 --
 hw/virtio/virtio.c             |   6 --
 include/hw/virtio/vhost-user.h |  21 +++++
 7 files changed, 105 insertions(+), 115 deletions(-)

-- 
2.39.3
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------0BnP0X0w0JX9mYZvrcwGKZUo--

