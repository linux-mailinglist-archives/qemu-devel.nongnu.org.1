Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDD57367B9
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:29:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXfO-0005HH-4e; Tue, 20 Jun 2023 05:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qBXfM-0005H1-0V
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:28:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qBXfJ-0003uW-Kg
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:28:47 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35JNLk5c004972; Tue, 20 Jun 2023 09:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=C9jnd0/CJ5RHGajg4ht553/I+inazOl4PdtZ1xvBVEc=;
 b=TGKnYkpwYNiqyjbEAjZ4VgUciaH3f4gqs1Wv8iOpHJE9fCCHfa95OyVNUbnmj4zF4PhJ
 m34b7NPcxCCoR+IcGuhNyQVElRu9vCy37xnQl4UwvGjVu5tNXVL+JYL2qVLPDvkHAGQ0
 +46QAaJIDCnP2Nc+xfBJIx1XDm159cxuxJ6slOT94cZWcSC14KqPhPPmyKnwSuAco4KJ
 XasQovCEx6gnB+zm2ktolIWvejGBJsVIarXmDUprmurDLnCMt+CN+QHpnBz8xz9ogmE8
 Oz+did4lO/ziNPuE5JTGLh6/OlOlq8kEF+5lxz/ulUWjm26rzuOFzBgb2hebtS8CEMAT vQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94etm8b1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jun 2023 09:28:33 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35K8xT78005866; Tue, 20 Jun 2023 09:28:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r93943ugd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jun 2023 09:28:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv+Tuv0M5aIStDGwXhTXYM8FWaP7FvI3sWn8j4f9j4WAYZfwp2/NrTE2gO9t9ObS2sJ/5WcZ2b2Pd3j0spOnQ5/SCf6k+fi+zgC6mJwajYV2POVdvTUT9TjtIEjrOvMd6rAukbWF8dfUT1yre9aCma7t6qthtJde/jNS7H9R93i7MIBMMS81V7VoXoeBJKM31xPgK8vjtcA22USCuP3YK+Rg4iWNPM2nNNi2vpUoF8ZyskffWX6LiGxe2nBix9R2r/Ho6QNeakID2TRU1PB5A5zQ2D6D+/ensDYyFJM2b6Q1oeaxjIvgnAWpx/dUNLl2YGdwWgTf7f8x+dIEk355Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9jnd0/CJ5RHGajg4ht553/I+inazOl4PdtZ1xvBVEc=;
 b=TK0cRflqvCGgOPoYjp/BTjWcmXQHFsJt6S1u7GEjPN6fDcwmbKIOmvhvy7Eiophda3IpCyu2548RwsHGwr54tZxK7moJQY/maFvpUAbHEaq1gl/zRMfNtUUWce+rNv+AFdLj4zRMjelLJEJmNi/juTUY5OPTANT1iUJfsEGeRm7ib3iV/MNRgN/sNxoSazntYiug/rnBk8iKEJF5ctUKmYc9p+W1wEnALSagM68Uexue1qccw6Gv5BiuRPzcZKpSw7GS9O9Un1UBvCDqDd6lmQHgX6qMMhffaD7HtPdmjJefGYogYteWSOGIyqJ+2VCNW5qpuMkRl47oSD9Wj4sLAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9jnd0/CJ5RHGajg4ht553/I+inazOl4PdtZ1xvBVEc=;
 b=C8pWHV27MFIlxf2gv1sskMcmzRCL1V2QaDzNM7JIfLPkzksKaGON/tRHoiRZ5/saOY+w7qbf/rkGRFHR0pvQV5/gcuFpECW+ylUvPrPwh9wUGLMK9VtiGWKNCarX8C9rPVe3P0yOJnwQA+/iOZ29bGmLw6/hM01I6flG2zLIBwg=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SA2PR10MB4793.namprd10.prod.outlook.com (2603:10b6:806:110::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:28:28 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 09:28:31 +0000
Message-ID: <bbe7b49f-41a8-9587-407e-2cac149fbff7@oracle.com>
Date: Tue, 20 Jun 2023 10:28:25 +0100
Subject: Re: [PATCH v2] vfio/migration: Refactor and fix print of "Migration
 disabled"
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Avihai Horon <avihaih@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20230619084446.399059-1-zhenzhong.duan@intel.com>
 <41469da8-dae3-df36-6de1-4b44bf6ba508@nvidia.com>
 <SJ0PR11MB67443F8A4A7AF037379355C5925CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <a49cbb60-d2ac-6329-806a-260d602d3056@oracle.com>
 <SJ0PR11MB674447BF091C1EF4789B726B925CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB674447BF091C1EF4789B726B925CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P192CA0009.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::14) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SA2PR10MB4793:EE_
X-MS-Office365-Filtering-Correlation-Id: a2fadf8e-534a-4cf5-d2cf-08db7170b651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2VnitZoHSm7Kj+swb0IHI/cYUFf1PWhUojmc4oxTE4p6i317YB5yxb8x1Q/Mya8B2SomgQkADxkpyjjJK0iZuNHIT4NU3DlhTIvV+FzGgy8xPtEJi6vSLm/tu7aqdbFMhv490u0SBTqGzK8G3Y2+8J4lVKGpudmDJd+c/wnrnLJPufJmwwgqmUUWb+6cDe1xBpw63BQwVmQvJCVNo6rJ2ZJz8v1S4SIChAC6l6B85RjwLrNzLePAknOzA7FM1iSGttxOFm+RIPra2/iS14nLx4XqsVj+QClj1LkRw7UkpLlsDO1lJi5l8J+8kaULyi8I7PovFopJ//kKgrNZvpWpo4QgfVs53oGajBF6fLSPcAOEvY68n+LASul5qHGooSOoXUYj42sRGjyYphqNt/FuSpnlOYeMI+H/nZ6brsyzIkR0VLTQ7YRB/ITvcwDfcdi/4dcMOJMKTSLiz8ympRESTysG94zG9wK0hhu3VF5oMSoj1siaGs0zW2OpZnF4nkLPj/I5U7A1NT2aLNENHhofbWjfdSTyMu1+SNY/CzKnHFwK1xclpmN9ds7i1QeI21w+TeRwpqm/sSPY8XjnYfn6WAYRWhooDjmlEAgnNyAusAtbL//mmE4H/W4NsF0y0j0F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(41300700001)(31686004)(5660300002)(6666004)(54906003)(2906002)(316002)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(36756003)(478600001)(110136005)(6486002)(31696002)(38100700002)(53546011)(86362001)(2616005)(83380400001)(26005)(186003)(6512007)(6506007)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDk4c1FoSTdRK2xaWmw1Rm56MFFOdk5CQmVVZXpmYjU5LzRXUjB4WjZGNTFQ?=
 =?utf-8?B?YmNaZkxYaTNuSmd5VFA2VkpnUlBJcHNZOVNZcFVHS2tuU0ErL3JlL2FEOWNv?=
 =?utf-8?B?dXI4L0ZXZU9tODRnRDkyV0FuL3dkd21Qa25oeXpidXo2SWVIR2tKQ1NiMFFs?=
 =?utf-8?B?Y0l0S1RRQVhCOXQxV2dRaitTdHgxY00zTXpSSkFBQkNMbnVqV1Q4UlBQZVYw?=
 =?utf-8?B?UHFTMFAyRXljUTk2SGE4RUFoR3lzTnk1c1RvNmpFYUtUbjhUZWxqSjYzQW9t?=
 =?utf-8?B?Njd5Nm1sdnNxZEw0N3lwdXhtRUVwZzFFZnYwMVRrQlprak4xcVpGU2FDVVBJ?=
 =?utf-8?B?LzZ5ZXJGV1lLTTNHdTZ0bHY4dDNwNkpNV0lJRTRGSXVrUVovZ0lYK2JaN0R5?=
 =?utf-8?B?WGc2TXA3S2V5SVIyckk1M2J3bHdSN2h4ZnZTaURJaWZXTFV0aWxobTlyTXNL?=
 =?utf-8?B?RTRUd043bXRXRHJGYlJyMkEra0JvVVhFdjM1ZGo4bWhXT2NlTVAyZ2p3TDNK?=
 =?utf-8?B?b2JLWVUyVmE1U21lcmdhSU1LbXJtbTJDclZQTG9nQTU1SjJ2YnA1UTRrUThT?=
 =?utf-8?B?clVnQzhBZTA0OVpQRUFJRnFFdEhGd2laNVdTcDBxeXhnZ0d2Rjg5V2NvVHFt?=
 =?utf-8?B?aGVOVDJGTUNGVGNCUFJpbjNtUHRRS2ZDV2ZZdkJRbmNLWmNjeWJ6MWJOUEtv?=
 =?utf-8?B?Q3lDSUYvTU03dURSY2RyNzhDN1c3dHV2S2piNkc0KzYydkZlZUtFNHVndGlC?=
 =?utf-8?B?d0p3OFdKbXVVSDBrTlROQ2tZdG15d25KMWpYNGRCQXFVbmtKSHVhWWFrTnd2?=
 =?utf-8?B?M0M0MDRvM00wQ2hJeFBsNVlKMi9va3Z6anRjR0ZyZi9TNnQ4WUNITm9iN09Y?=
 =?utf-8?B?WDVJL3lNQ2dIUXJwNU1NQ0JoaXZRM2QvUVF4RXdsQjl0c2QrL0xSMTN4UWJy?=
 =?utf-8?B?QVJBeHhvcVdoZEc3bUpKKzZaYXJSdVF5UkZ4aG1JdkQ3RjR3dk1lQWRUSklZ?=
 =?utf-8?B?MkhlOFRtSnphNnJwUVlxL1UwQVVXcHdianN5U0ovck9LbmlKVCsyQ3VLcCs1?=
 =?utf-8?B?SE5wRFMxL1kwTlNXMkZzcjVWVWRtVFFXcjdMa2tuamNIYmhSQ2RwWVIvUEpY?=
 =?utf-8?B?SG03WURwZzhnaEl0OEJyMGhwSVoyb3dxNHE4YVRSMjAzK2dGeVhkcjIycEFL?=
 =?utf-8?B?M3doaXlsUjZDbWVHclFVUFFMNFZvTWpoR2U5ZEtoMHVoRDJQbkFEK0pTZzdR?=
 =?utf-8?B?VllvTThidm56ZG5DaElPTHk1TGxrWGQ0NEpaa0I4K1ErZFNrRjExNlRGOEV5?=
 =?utf-8?B?cnJGc1ZWeldWdjdubU5wbllwZzZQRlFWMExVQUliL2k1S3N3T0F3RERuMWpJ?=
 =?utf-8?B?dTY4cTVTZ3FoKzhKNWRSbUFEZW1PSnI3eURyTk9NSzZSZ1BvWE5SREg4Si9n?=
 =?utf-8?B?SU90OXJWd1E2VGd0SGh4WU9rZFY4VXhSVEl6M3ludlZkMFFDNWdsQ0FtdTEy?=
 =?utf-8?B?OG1lWk16bDRsUFY3YS90eG1ES0N0a1pVR1lVU0xPWFlwaHdSVDJNQnNJMTQ0?=
 =?utf-8?B?blJRWWlyY3k5RDJ0aENkUGIrcGloU2E0RmVsZGtoUHBhZEt6cVBUU3QydjI1?=
 =?utf-8?B?cnBWUkgzaFZRc05UYmcwalF6NHh4ajVjZ0dCaE1scDRlY3NTcStlSGcveHdF?=
 =?utf-8?B?MnFkaDdJQnYzbTg2Wk5TWk0xL3g5dDd6MHo5ZVEwVUxadEFvZDZkdkhaaW5O?=
 =?utf-8?B?TURDM3JMLytaNk53cFlxSGZvbEpMRllIYnJLZ3ZHSGlTVG53SDJZZjZ0NkRW?=
 =?utf-8?B?T3l1d0w2aGtHOWwyaURSNkNGd1N6Y2lkeHpzdm5ReFBJeEsyTWIyUXhpMGFI?=
 =?utf-8?B?VGFxaFg5L0ZMenpNU2lNY3ArMXlaMkorays4b2U2bHdxa3hLdEVxRTI0aklN?=
 =?utf-8?B?aEljWjF1aVdwMzVYcXA3UzU0YXA2SlBUQlJLNG9LWUtNT0RvOUZpRG9lekZx?=
 =?utf-8?B?SWJnOGZPOERxU2s5UUZKS3Vnc0hTRVN3RytDWTNUR0xRaThFL0k4SUNRMm1E?=
 =?utf-8?B?WWNrSURDWWs0a1R6QnREbGVxOGpjeExETkJXOElZRWxOcldyVU91Z2t4QUVK?=
 =?utf-8?B?UVI2bGNDRXViQU82V01vSFExMHpmc08vT2lmcUFTMWxIQnhPV2s3NFN3Rmxn?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1ydtsOjaIiGu94H0jyMulN5inKG7EDsaCbB9A/gDVcB/M1ZQf2c46k4vdT4vlGFm214MXWoxruyxlKRZxp9vf+TpC5mWpOzYTPd+eNTx5iXl09DW6VIwJA4JH9y2IcDQ3LzZm4EaS+3/m/tWbD4ef5E2B0QTwn21tTLXtU4Lma/ym6eBa1ALFfV1Bl+DblXglfM9A+fyz8Vf2IW4kdvvLWVwKtsNMigN66ZfEzjJzYbd7A1lpV7L62p5sk2Lqb1C+nnrBxoCNl2MzNZv3TxhsOE1SM1CxMQYlOUsNwBJMm2ccXpMU9p103dLkyYSMSt6foI1+Ap7B/VrefR2STy/Nk7wNWyOiYNIbcsEHGhtKqVknrMKTj90IFXCGikpJi5e4wiE/GvopW3smushjrvHcy7y8jPVEx2GCtvmbv10P3WP6URSwA4ERr9BcyawGb7S6fUnduSxz11OsOGC+85ms9GFGUKOrmV2w422FJFiN7gvZxJymMbNB3vv7Y8rjtvjJSXFlQu8ZcAdrwGxtwo7StJXyTpnidgSufH1tmMmJM10ZEufu7SlrzdUWQGYwB8Y8iJlOkextBoiPCpsRIAh3U8TU/RGvwtysnhS3crpVAVyQ+UYQQIsdZCtOyPBkKFDrJXfFZolBHPUtfeTIqe4pjZWht1TmEpVUIhRzZEkJdeHjWQmxcO3/anywJje78GM2oSBvFD2Cx4PEEcrzs/Sjs4kalpwZZwJ+W3Iwu9k8ZhbXCIo4R1EpY1lsA+zX4mXwDzDYQLQ0Fy7bXuZpMHEtd1jINGsU+jEn1bcX8GeGTpv3qwpoV4TjcVwfrHZXqgMmiLig2IhULPBGiHgEAbg2Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fadf8e-534a-4cf5-d2cf-08db7170b651
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:28:31.4203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igS/GM5AaX9fFB0ZqUQymqAZhkMl9ScEnfeFeTBDCQNhLyGWRMNtwiMPNhi4mqNoyUiTrOKJ/YAF9dSfWTRPbA/aJ+tW96TMX06W4Sy0f7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200084
X-Proofpoint-GUID: nLjedCkbBcuRXVB772JNyEV4OdrcO8EI
X-Proofpoint-ORIG-GUID: nLjedCkbBcuRXVB772JNyEV4OdrcO8EI
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

On 20/06/2023 09:55, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Sent: Tuesday, June 20, 2023 4:23 PM
>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; Avihai Horon
>> <avihaih@nvidia.com>; qemu-devel@nongnu.org
>> Cc: alex.williamson@redhat.com; clg@redhat.com; Peng, Chao P
>> <chao.p.peng@intel.com>
>> Subject: Re: [PATCH v2] vfio/migration: Refactor and fix print of "Migration
>> disabled"
>>
>> On 20/06/2023 04:04, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Avihai Horon <avihaih@nvidia.com>
>>>> Sent: Monday, June 19, 2023 7:14 PM
>>> ...
>>>>> a/hw/vfio/migration.c b/hw/vfio/migration.c index
>>>>> 6b58dddb8859..bc51aa765cb8 100644
>>>>> --- a/hw/vfio/migration.c
>>>>> +++ b/hw/vfio/migration.c
>>>>> @@ -632,42 +632,41 @@ int64_t vfio_mig_bytes_transferred(void)
>>>>>       return bytes_transferred;
>>>>>   }
>>>>>
>>>>> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>>>>> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>>>>>   {
>>>>> -    int ret = -ENOTSUP;
>>>>> +    int ret;
>>>>>
>>>>> -    if (!vbasedev->enable_migration) {
>>>>> +    if (!vbasedev->enable_migration || vfio_migration_init(vbasedev)) {
>>>>> +        error_setg(&vbasedev->migration_blocker,
>>>>> +                   "VFIO device doesn't support migration");
>>>>>           goto add_blocker;
>>>>>       }
>>>>>
>>>>> -    ret = vfio_migration_init(vbasedev);
>>>>> -    if (ret) {
>>>>> +    if (vfio_block_multiple_devices_migration(errp)) {
>>>>> +        error_setg(&vbasedev->migration_blocker,
>>>>> +                   "Migration is currently not supported with multiple "
>>>>> +                   "VFIO devices");
>>>>>           goto add_blocker;
>>>>>       }
>>>>
>>>> Here you are tying the multiple devices blocker to a specific device.
>>>> This could be problematic:
>>>> If you add vfio device #1 and then device #2 then the blocker will be
>>>> added to device #2. If you then remove device #1, migration will
>>>> still be blocked although it shouldn't.
>>>>
>>>> I think we should keep it as a global blocker and not a per-device blocker.
>>>
>>> Thanks for point out, you are right, seems I need to restore the multiple
>> devices part code.
>>
>> It's the same for vIOMMU migration blocker. You could have a machine with
>> default_bus_bypass_iommu=on and add device #1 with bypass_iommu=off
>> attribute in pxb PCI port, and then add device #2 with bypass_iommu=on. The
>> blocker is added because of device #1 but then it will remain blocked if you
>> remove it.
> 
> Right, thanks for point out, I'm thinking about changing vfio_viommu_preset()
> to check corresponding device's address space rather than all vfio devices'.
> 
> Let me know if you prefer to restore vIOMMU blocker as global too, then I'll not
> try with my idea furtherly.

The vIOMMU migration blocker doesn't need to be global, true, as it doesn't care
about others address space -- if each device has a blocker as long as the one
device blocker is removed it should become make VM migratable again (but atm we
will be blocked by the multi device blocker anyway). This should consolidate
things into a single migration blocker and avoid the special path. I am not
enterily sure if the refactor will give *that* much gain but that's probably
because I haven't seen the final result.

IIUC the problem with this patch is that you remove what unblocks the migration,
and I guess that need to stay there for the global case.

