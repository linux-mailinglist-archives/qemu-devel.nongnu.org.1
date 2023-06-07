Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F48A7261BC
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 15:55:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6tcm-0002lh-27; Wed, 07 Jun 2023 09:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q6tck-0002lT-19
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 09:54:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q6tcg-0007Of-FT
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 09:54:53 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3576Jpk7008057; Wed, 7 Jun 2023 13:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wzVMM2dPs/jfojnsjFkWS9UOmNnyGcmwsU6Sdv2Netg=;
 b=Rf5IOHOXe53mJTZ3faiRdeQoFk0HKG9N8WZF+18xie0ZxtyrSRQMEo0ydtCv8+M64d83
 asqYHMzLmqSO/2i+a7A59aA4UXkOCi+zOFPY/8qAA/v/MF3AOcYCz+vQMu/IM1+n7Jpf
 4upYrPuxBRZ4xVpVTlygxTfTuuJhhvZaJ0umxZ8nT6TCf9/+M6VBmWJt7DQnXKnTbK3s
 jRV1Fzn4CW9n9kiVm6lw0KTqy+PITeMmCaHSYQMvvvkIK8+TnOaOrqYxH6u4ZHtM2fvl
 DkvQ8Q5fqfDx2QpOPnXfAOXCJYHSI+dKFLrf3efDLhUogd8mDAL/k5MwZ4wEz866Blrs Ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6rhtxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 13:54:43 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357DjO3b015759; Wed, 7 Jun 2023 13:54:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6ksbrv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 13:54:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ML4lK5A8Z3mH1gLA89+n6MSYgYnQhuX/ZaawVM3ePniTeA4yGPsBXXpfbyIl6ndrspiyyJC5z9GTKnuihGrityGwS03YLwl/cRELPs8vkf5cCr70UP6+tPr/aZ815RjRuhqx8/fspJLhn1o5Ao4m4IAqyuFxqY1WzZxg6RIlhlNN+LNSuQqy1enSKyHhqXoq75MwkdzkBWXELLV3rRCCDEH4nkHBj4BYBYgLByn25MSBOdwKFuBya7Ko4aF4Fx8IyoRj6OT0kuEpBFpL3GeQmhoQew2rONJBhmBkvzeojToqpPX+CclJHoXwN2HZ7L9HLwZ7QUqholcEXp3OtckN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzVMM2dPs/jfojnsjFkWS9UOmNnyGcmwsU6Sdv2Netg=;
 b=fXqyhMAWYZ6Lv5VD4ITNEyD7uGVug6O02us+i3iMAoTDaqBD+Wd7CRpmnUfEoN5fRm9hy6qFjm69B0qUev4e1QrGNrfITLF9VzBavADmhkv+XaEJX0hSAMkdN70JyIsHw8lMhrl+N3lXyZmk3I4vSxUWh1a5A1G2Z6MBaucWQu2mfY6FQF35lFy22fSG58Lt9+w+tiaHPlmPGwQhcbpOfQAHXcFDB2pHKQc7r1wedzvzLSjinERWAPUlmJDQpXQExM4LwBxuLELJEXxcu3gLcuN6UFKjB7tsKSHRxX5KqFTXa2btd6asEcj0SyLDUJgn0Cxc5ikPbVUXZBt5DCDbZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzVMM2dPs/jfojnsjFkWS9UOmNnyGcmwsU6Sdv2Netg=;
 b=bo9SPUjbuYcofXTloNDn9k+e2KrUd06+YOvD8J17KnQJLMsK7Xyy1MRuaR65DrDSZhp2O8tX7FykWulV+hnE0MIlSXztQuS+6fX/+yIaU+j+aRjKtSlWNAQR4XiyqWa5nRq72i0nFCnrIcCIocD8YlxuR9ODGiUcS9I5KixHuDU=
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23)
 by PH0PR10MB4807.namprd10.prod.outlook.com (2603:10b6:510:3f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 13:54:39 +0000
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120]) by SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120%3]) with mapi id 15.20.6455.027; Wed, 7 Jun 2023
 13:54:39 +0000
Message-ID: <555c8a46-a530-c258-8614-0485536c60ee@oracle.com>
Date: Wed, 7 Jun 2023 09:54:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2 1/4] qapi: strList_from_string
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
References: <1675795727-235010-1-git-send-email-steven.sistare@oracle.com>
 <1675795727-235010-2-git-send-email-steven.sistare@oracle.com>
 <CAJ+F1CLFMUDvaOq2QXCKpb8Zj4PRr-tKV1q9L8m2EfgORPLj7A@mail.gmail.com>
 <32f34f74-213d-7107-907d-dda0a509878e@oracle.com> <87h6vwnstx.fsf@linaro.org>
 <87cz6j6tt0.fsf@pond.sub.org>
 <d25846e4-13fd-c683-b5e1-1660f4470d35@oracle.com>
 <875yca23dd.fsf@pond.sub.org>
 <7beaf84a-008e-c9a3-3698-2a230196acf9@oracle.com>
 <87cz6izmtz.fsf@pond.sub.org>
 <1bb65a74-d444-7601-47d3-290959239831@oracle.com>
 <87sffdvpmu.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87sffdvpmu.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::23) To SJ0PR10MB4686.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:EE_|PH0PR10MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efa6107-f273-45ed-dfcf-08db675ebc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeLDMi7CIkUTdPG5VGfGs/QaVIG0YOf2YpvpCnUnT9EphmlYdKc+Y7M1qeYfywGjkujM/VpMtVEKfvfetDm7HZsIu0Ugms7q7GHMsbxUYX3gepLSWi7QBzgPAIYFdvZc9ffKCfuJ+aJ9K/5cKvdG/KC8yDw2KaC8Iz0cIVMkzVoR2O60tmwhnPQaUS25oBfmhrupvMja6CFvz/YdMgher8TWpadTLLuOYheUrrvPEJ/PEzeFYGLO14EZyRfN32ZbX02qg0VyT++c2bPSahCPSrXbMihsGZWz5SaJwFoZtsk+7jnBEz3XX3et29qop91+adEyRHqAJjcwThGBH9OZbvm+xAtNrFmzqlApp/T2Y/PtHu0rqp6Do1qO0EYM94h3DG38OGpJdZtFoDyBiKauhF4qVaCha1+KrSVPKI1xSMQybMyBmMedEd8pxpYluDM7yBeS5C6xK1Pj0DEb5cYIhRRszT7aFtSADuIxfqJ24xbLOECekydjo8hwVtbyFcASZQrEVZJzKad8pVep9nvDT4CGarkBuwYFDPufEzYeYTQ5JEZaw3nl3FdlrLpWYnDPp7PqHbrjSPf/JwRWMY7IwPioNBsUzra4t3WF7n1LvLgUDydPWzmyM1F1gRYpA3UaSBeXQ3jwkTHDLmvf9G0CiGssjjBa8JwcH+w7lAnGdz81ND9fH4DzCWWDUr/n6vRn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4686.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(44832011)(186003)(5660300002)(26005)(6506007)(54906003)(2906002)(6512007)(31696002)(86362001)(966005)(6666004)(36916002)(6486002)(478600001)(36756003)(53546011)(38100700002)(66556008)(6916009)(4326008)(2616005)(316002)(66946007)(8936002)(8676002)(66476007)(41300700001)(31686004)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDZUd1k2NGZld3Nla0M4dS9LUDdHTStZSWFSYUd6NmZ0Ym4yQVMwbDFiSFd1?=
 =?utf-8?B?cm96TE1SeVZqcFZyUDY1WGhTbDh4cTVLaFQ0M0RtT2s3RjhyUEExYTB2S2FZ?=
 =?utf-8?B?Z2RxaDV5MndjL0dXeUZlUGVVckc5Nm03T0t6NWx5ZFhkR291QmJYNythNm5a?=
 =?utf-8?B?MFh1UFFPZ3lka1ZWY00rdGpuWVNZYjA0Y1hGcGpVcVIxaVpwRWFzM3Nqd0NW?=
 =?utf-8?B?bEV3NUo2emdBclNrdko3SjR5ckJ4U3dIRk5yZXFhSmhtTVdkTUI3MzJNb05v?=
 =?utf-8?B?cHJnSk40aU1QdFRVVEVPRTJVc0ZXMUZnQ1FlaXZzeWxZcjdFUzBlQ2QvbS8v?=
 =?utf-8?B?WFhJbStsY1pPMzBhN0Y5NXJUalBVWi81YWhUVWNMejh6Zlo1S1VOZXAydGJm?=
 =?utf-8?B?UW9IdWlVSDhNcy9SQVdkUzdSeERpRVY1Ny9TbjJESjQ3dHd0a1FSQW9RdUNG?=
 =?utf-8?B?cm5NRWNNaXlXQkMvYnpSTE9jT0gzMmZ1N2RVZzd0ZytEanFjWGdJVnVBWGFs?=
 =?utf-8?B?S3pvNUcyRGlRSUVBYlhSeFhWZnB2NnlHZDNaZzBJSEtDV3p5UkZIazhGR2Ja?=
 =?utf-8?B?THBHNVZYSjdrdy9TZjZVT1g4dUpVOXVxczNHRTFDUXZBZzdvdHVZRUs5UExt?=
 =?utf-8?B?NEF2L0oxcjYzbkFhQ0VHK0FmRk54ZlBKOGNzK2J1OUE2VUdWazZNdmlKUHpR?=
 =?utf-8?B?VEIzaldwOWxLMEdhNldEZHprTDh5UVdqMm9UNzBMdkFOakVLcSsyVzhva2RV?=
 =?utf-8?B?Z3ZBdDNFN0tXcVRGblUzWGVPdW5nTU5CK1kvakNORC9BWEthQkNjSmRmOEtp?=
 =?utf-8?B?Q0RoV3A1bGF5alNXNUMrWks0SVJEdHVZUG1qTlA0Ym1OTFJ2N0JxOEwvMlRr?=
 =?utf-8?B?dGE3bkJaOG1KU0QzUS9OK3ZjRmd5YThZUUptY3ZLNjVnR0ZyRExCbFIzenpi?=
 =?utf-8?B?U1NNSDU0eXBuUXV1TUVsZFhLc2NtQnl2YnViWWtmZVZ5aXFJWVZPU2E1VnJx?=
 =?utf-8?B?MldHOXFIdGswaEp4MlJ5cHhMb2hSZnlxL040eW51LzFjVjhmbExWUTlQWkhh?=
 =?utf-8?B?cGRuY0pRN1VuR1c0d08xY1NwZStMd0ZWNGhaTGNMS0Y1MGlvbXZMbWNXRmxz?=
 =?utf-8?B?US9aY3ZvdS9COGZZQVFCREVsUVdEUE1qR1cySjZ0MXkvdTNtYU9sSXJ2MEdi?=
 =?utf-8?B?a29EQUx5ZFIrbXM1Wk82SW81VENYWVgrUEp4SEw1dWlIN0dMbzIvSURicnB2?=
 =?utf-8?B?bUJjL3RRZmlPYXI2SGxBTSt6dzd2ME1WdkZUTmtiU1ZqSDd6Y2RVTFR6RlRw?=
 =?utf-8?B?K2ZHVjIwT0RBZmU1NDY1ZGJhTjFPQ3FzamlRVm9ZZGk3Ym8yeHA3bmVRSC83?=
 =?utf-8?B?UU1yNjV3dHV5d3E4WnVEVy96OWhDb0xCRHl4ZDcramJKcll2RzlPcmVLQkVT?=
 =?utf-8?B?UVJDSTViTVlpbEd1ZkM2MndzbEhWbElDTHVsQjBpaDNIUUdHQVZnSm9yK1FN?=
 =?utf-8?B?Q0NVVFUrbzNoejRRRHQrREJwV1c2Vy9aR0VNSStvU2M4ajJEamRPNFZTUStk?=
 =?utf-8?B?RVRHa0VlOHU0cXNWSzUyditxSHhkajQ3QVVubkxuK3doek51bWNvQVhyODgz?=
 =?utf-8?B?em9XL3FMYkEyUE1PeDZNZU5IbzNtbElYYVNiSlMzUXJjQTM3M2ovNWRQTlFi?=
 =?utf-8?B?UWp6WUVtRkZnejdkNFBQa3hFZktlVjI1ZUNtcjU5RHE4UDV3SnErMWRGQXpF?=
 =?utf-8?B?c2R3bjZKV21YQkZiUWg2eHRiNnAzTHVGVWpRK0RtclZhYkxyNHdLajYyK2Rl?=
 =?utf-8?B?aHhwcGlLSURTWmFJbXhDc2l2bHNucmZGYTUyejE4eVI0ZG9iR2Q2MzhnUVdX?=
 =?utf-8?B?dEQ3ZHltS3AxK2RmblZWdzNDWVYzN2VMeCtoV3NoNTJhRmxlWU9NNXZCUzh4?=
 =?utf-8?B?R2k1RmljeDNXdTZPWFo4NlgzU2Q5VEFIQVNWeWVKTkFaN213SFRuVHZRNHA1?=
 =?utf-8?B?UGNDSmhmZzcyd1pUQmpwa1djR1RYYTFRdW85M1pPSGFtREtha09zL1N5RmJP?=
 =?utf-8?B?dGw5ek9SOVcxYWk2UXI3M0F1ZTRGRm40aTdKd1poMTliMVhYTGM0RUZXTDQ3?=
 =?utf-8?B?S1lUMGdyMnVXc0lQRXh4dEFDcEcySDArck14S1NyT3FGbHQzRjJZcE05bC9j?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gsAxkfOo+C2ZkiuSxH+m2R27KRKdh6KWz5qOWbE5jJ/x8hV+qmWE+LC9efetkZ61xYUPRyZhCcWgBpyQcLt0Ht/auM01Yc1gTCBR9Vo5LprypxeBnZBbFJJ9aTTIUxJRVv+SvhWw1kVsqbOAl5KEXmyN3j0DD6OviqGKJaaWFriBWofBWH9vYUwtr2Tyrg0jjS6JdnDYYJfIi/8RlT38Cd6t88owH7hXkeD1PiXj2jakpAB5JSTBIrU0rrPETVvCh51zmhFiebflxhXSKb5rS4IRHhluj8h54p+LKWEz6cGCFlAKvSJd4+P8O+tK+kusgjoLUbB0Ep2KPd3SBMASKLinj8MEwY2R+ZOHgJnsDwi99HkbMAUO8ztUVcSZ6+d64eD2cR8fRogcWxaD5UcTNQ7ZUJREh7P/PRz4KfyzZLBeqnn2vfTpak3fkB8Klsvu3cIY+4iq4hnWR3NjOObQWG3XVqhat1Lj7IY//5AxCWiJO58vRcKX7+e9BcElS9CmosH7/8dgPInrkV/4tGa1GuuvNj9dPOWDMj0EW0ZB/X9J7AS2Kyoe+uk6Q/rdtV1VqEOu+dMhmskB1VL0KNUt/HOsDVwKz9iR9AhizTID6lAKOt+wyUDXpG718SKZftk4/mnQC78kkdnD4giClAmafBJReuu/h5kX0F9PB7d3sOQUFQChK8FT2uATA7vj5308hENH9souFHqz0mxiEqIGm4RPsaypfiYxUbiFPfwjQu3QtjO+t4rbLYbR9/XnGv4x8y0UsaO8+8seepNlp66WLqeLHxqfziFH8IJ0My40rkVpkBxYTtq7OKf3m5WKCd39Cq4SYlvGszHyIUlH0zRo3ZAyPQwVmV+Sl6RezHzhLUY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efa6107-f273-45ed-dfcf-08db675ebc6a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4686.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 13:54:39.0356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upZR8lRu/CMe4C2GuJtFQgjB1bjAmDdnL0P1NMjsvyNnqpIVEvnzRTpbCES+liX596RnJkmt+IfhlZX1Zdgo7hJNNucSJ6agrHgtRWhGR24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070117
X-Proofpoint-ORIG-GUID: xRedEIFFw3Tmp5RoAOJAwni4Jato3lGq
X-Proofpoint-GUID: xRedEIFFw3Tmp5RoAOJAwni4Jato3lGq
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 2/10/2023 4:25 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 2/9/2023 1:59 PM, Markus Armbruster wrote:
>>> Steven Sistare <steven.sistare@oracle.com> writes:
>>>> On 2/9/2023 11:46 AM, Markus Armbruster wrote:
>>>>> Steven Sistare <steven.sistare@oracle.com> writes:
> 
> [...]
> 
>>>>>> For more context, this patch has been part of my larger series for live update,
>>>>>> and I am submitting this separately to reduce the size of that series and make
>>>>>> forward progress:
>>>>>>     https://lore.kernel.org/qemu-devel/1658851843-236870-1-git-send-email-steven.sistare@oracle.com/
>>>>>>
>>>>>> In that series, strList_from_string is used to parse a space-separated list of args
>>>>>> in an HMP command, and pass them to the new qemu binary.
>>>>>>     https://lore.kernel.org/qemu-devel/1658851843-236870-16-git-send-email-steven.sistare@oracle.com/
>>>>>>
>>>>>> I moved and renamed the generalized function because I thought it might be useful
>>>>>> to others in the future, along with the other functions in this 'string list functions'
>>>>>> patch series.  But if you disagree, I can minimally modify hmp_split_at_comma() in its 
>>>>>> current location.
>>>>>
>>>>> I'm fine with moving it out of monitor/ if there are uses outside the
>>>>> monitor.  I just don't think qapi/ is the right home.
>>>>
>>>> I don't know where else it would go, as strList is a QAPI type.
>>>> include/qapi/util.h already defines QAPI_LIST_PREPEND and QAPI_LIST_APPEND, so it
>>>> seems like the natural place to add qapi strList functions.  I am open to
>>>> suggestions.
>>>
>>> What about util/?  Plenty of QAPI use there already.
>>>
>>> Another thought.  Current hmp_split_at_comma() does two things:
>>>
>>>     strList *hmp_split_at_comma(const char *str)
>>>     {
>>>
>>> One, split a comma-separated string into NULL-terminated a dynamically
>>> allocated char *[]:
>>>
>>>         char **split = g_strsplit(str ?: "", ",", -1);
>>>
>>> Two, convert a dynamically allocated char *[] into a strList:
>>>
>>>         strList *res = NULL;
>>>         strList **tail = &res;
>>>         int i;
>>>
>>>         for (i = 0; split[i]; i++) {
>>>             QAPI_LIST_APPEND(tail, split[i]);
>>>         }
>>>
>>>         g_free(split);
>>>         return res;
>>>     }
>>>
>>> Part two could live in qapi/.
>>
>> Works for me.
> 
> Note that I'm not demanding such a split.  I'm merely throwing in
> another idea for you to use or reject.

I decided to not split the function.  IMO having part 2 free memory allocated
by its caller is not clean.

However, I will base it on your original function, slightly modified:

strList *strList_from_string(const char *str, char *delim)
{
    g_autofree char **split = g_strsplit(str ?: "", delim, -1);
    strList *res = NULL;
    strList **tail = &res;

    for (; *split; split++) {
        QAPI_LIST_APPEND(tail, *split);
    }

    return res;
}

>> For future reference, what is your organizing principle for putting things in 
>> qapi/ vs util/ ?  I see plenty of calls to g_str* functions from qapi/*, so I 
>> don't know why removing g_strsplit changes the answer.
>>
>> Per your principle, where does strv_from_strList (patch 3) belong?  And if I
>> substitute char ** for GStrv, does the answer change?
> 
> As is, qapi/qapi-util provides:
> 
> 1. Helpers for qapi/ and QAPI-generated code.  Some of them are
>    used elsewhere, too.  That's fine.
> 
> 2. Tools for working with QAPI data types such as GenericList.
> 
> strv_from_strList() would fall under 2.  Same if you use char **
> instead.
> 
> hmp_split_at_comma() admittedly also falls under 2.  I just dislike
> putting things under qapi/ that contradict QAPI design principles.

What design principle does strList_from_string contradict?  Are you OK with 
putting the simplified version shown above in qapi-util?

(and apologies for my long delay in continuing this conversation).

- Steve

> 
> util/ is a bit of a grabbag, I feel.  Perhaps we could describe it as
> "utilities that don't really fit into a particular subsystem".
> 
> Does this help you along?
> 

