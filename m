Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 783A8806106
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 22:48:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAdGA-0003Iw-3n; Tue, 05 Dec 2023 16:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAdG1-0003Gw-5V
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:47:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAdFy-0002DV-GK
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:47:08 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B5LO3LV006495; Tue, 5 Dec 2023 21:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=B2oH6LhMpA1gUA+JT+donLbKDtvTIoWyAdmvHEMg9qM=;
 b=I7v85cziuJC++lMQ3PBhQDjTVXFbvoRheVaP4lm7cYw8V6cn0z0Y11hNzGQW6J16sLZ+
 kchVU4xu6mYoJMsQ9kNROymvZrcRKwtjXFXcC9tVt5avcmKgmIMnfkCwRlcX7vf0JQ5W
 MOC21vLT0DVIBA/HUoQSH0QyXF5v1XFzVUsRdlBUc3yehM4S01/s9Omz2XnmykwDgX2Y
 CGJZJvfuse5zrotNwP3YhiJEjfVn5Uly9AuMirZTW94iir1BEXwyvwjDZpl6F13w49Wq
 WpNEPOVp4dGdX/blN5tqHr4lskab1Rf9+7ffSG/03W0mJLXfJ5QmpPDR+a5WaCbfauxO 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utan9g69j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 21:47:01 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B5K91hr039780; Tue, 5 Dec 2023 21:47:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan4v0y7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 21:47:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtxJNZB5L0saGlByyCa1Ll190smIp8XYNrBXUrod/B4xyVB6Si0ZvBoNHcVNtnJVSfRyD9jjM9/vg/+sspe5BA7TtIBOh9CYKsdWAp4C89UQfEPbLDG9hgPXyguyS+5C3t7sfsIL4753FFc3Lr5YJg6jf3AEbh8VU3v8QiVPfy6hkdGJ1QMpvjn9DWLpM+MpKoXRozgqsi94pWBofiQsyGet7k5WzEFFA4OLRSz7L/ObxviGIw3mos8n1j093PyGjLDMWpapB782gxc1cmLIoMK9bMKwfSPy5NYAdT46aP37TlXu7KmjqlNb48fVRyVgkZpj6Gf3HBMv7xOz6FH3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2oH6LhMpA1gUA+JT+donLbKDtvTIoWyAdmvHEMg9qM=;
 b=RkXKC5d9/8cXhZJRjcrye58AoX5bl9B+RNTYdK2DCxtdB82LaQ/kCxjYtoVri9uN7ZGtEyNtLy9VmcBaj5MykjIaP0MdPuLoV9jno9Zhx3tEh2YrCqe9oLXdsdNUbWVzXpV4+umR9WHR0RsHz7EmtuBh9WOyAqmF0r3p8kIelMYuantfvZdntUMq5I2gEgmyQdfKBcVWAoauvAxTyjlw5i8wRJ1JjvQQ6Y4QaKzOSsc1h2k1/3t4B1GNkZ796BtaDKbBYtquLqzO7FvgLUdpI7v2bkuHKHLjqPZY2om9Ha7IdsvYrKS5vyjcFrgEbfsH1cU1yYVecpVIWe7kMVajiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2oH6LhMpA1gUA+JT+donLbKDtvTIoWyAdmvHEMg9qM=;
 b=OA/YCa6aK3QoHVAJB1aHnhIwRbQAPFcPtZNkwgamgIEOROiey/VQIpHdBKZEJruapT8/lM5C81YG4eNw074ao/Q6xCEQm3b1bHFHQa2iTCkMshv48dqRCBbURhdX7XzuVvpgRiZP9Bl1DBXjVMthLAfkShVuKv+aQRSlnVdqiUE=
Received: from DM6PR10MB2523.namprd10.prod.outlook.com (2603:10b6:5:b2::27) by
 PH7PR10MB7839.namprd10.prod.outlook.com (2603:10b6:510:2ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 21:46:58 +0000
Received: from DM6PR10MB2523.namprd10.prod.outlook.com
 ([fe80::b99c:2487:feac:f0d5]) by DM6PR10MB2523.namprd10.prod.outlook.com
 ([fe80::b99c:2487:feac:f0d5%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 21:46:58 +0000
Message-ID: <bc3d29ae-48ab-3d85-24e7-89f4f08f9c9f@oracle.com>
Date: Tue, 5 Dec 2023 16:46:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC PATCH 01/11] acpi: hmp/qmp: Add hmp/qmp support for
 system_sleep
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, miguel.luis@oracle.com
References: <20231205002143.562-1-annie.li@oracle.com>
 <20231205002356.1239-1-annie.li@oracle.com> <87r0k075ij.fsf@pond.sub.org>
From: "Annie.li" <annie.li@oracle.com>
In-Reply-To: <87r0k075ij.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To DM6PR10MB2523.namprd10.prod.outlook.com
 (2603:10b6:5:b2::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB2523:EE_|PH7PR10MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba51c12-aac8-4835-592d-08dbf5dbb498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DqjHzjWmlSRxKd3dNEHb7+DLQlqHmHkpuVYdl+8Jq2Kual3UdReipNbqrW45PV7F1wLAEEr66OdrPGC1NCFK+zu28ykyJ4Egwtshx2yyGFTnHSZ+wUVbzH9CoF2Ed3zRm2PNHzbrAAdo+iMIjNThEhjDsga4rEf5vuUM5uyVHxtiXOoAsurzA/w5RqoZ8TSy4Y6sz3G5x0igwsbDrO7rYjRCuFwJtNIk18vO0e45GXycD2QlX6r634wZeOB/UrLkNZD8IrCfdLVa6feeSFTzZO8tp/imcUPY4P3XnWrCyZpH2Lbcha5bbs7EtlpSIDfkakt+9Cf8WxAol8RjUPkMRn11S+2JFSQX4tTk2CjRlKr592zS5o2IZgNkwvaRmxrFGUnhuUMCBU6dktNej60WSTDw/MgT31TvQA0Om1vQsjouOxq73PWb8X9lLziMDri+ZdyBHQG50RaMcXRAHA0RxpQlBh0HgInKkbA2BhqVMhM5uaf0fw09cywDxjdKcm8AcNZC56t4EVqpEyGfMv6I1eQ9YT05lha5JvbLZjuk7SayWqZXyrikPWmvJw6UCMLwjmpNhHwpWCRoQG5mNO23A29Df+K++sDvVBkXZKqaM4jSxu5zj2U+UhK2OYYexkDJLqWY1QLi9SZZm6HgozCXvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB2523.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(36756003)(31696002)(86362001)(5660300002)(2906002)(2616005)(107886003)(26005)(6512007)(53546011)(83380400001)(6506007)(6666004)(478600001)(6486002)(38100700002)(31686004)(4326008)(316002)(6916009)(8676002)(8936002)(66946007)(66556008)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R01MMFgyMFpEM25ZcWc4NkZtQ0ZiZElLRkJRWmI5bE9JaVc3NWd0UHl1aXFL?=
 =?utf-8?B?Y0hqQnliVVpBaWV0eFowN0twb1VtSkhCeFVVRVpTdjRMSis0cTVnYUFFbG9M?=
 =?utf-8?B?RzhpSlZSZGFwbWxmaFFiS3lzY0Q4SEt1QVB4cFBQRjFjcHVVcCtRLzJPU2ox?=
 =?utf-8?B?NUVIMllDNWZ6bS8xbGRIdElhVXpUVVM0T1ZOdDJkdXEvV1dDTXBsTDhEUk9X?=
 =?utf-8?B?eWVEQzZubVNlb1FGRFlCWTROeWVYOEJZaXZnb3ppZ05Kd2VmejZEU0hVKzZq?=
 =?utf-8?B?NW9DUStlS3NMWUswbnl0YmozT3VMUy8wSE9HSDZHM2JLMXJqRXk1aDRaWEpJ?=
 =?utf-8?B?cWVTYWlzcWV1MVVYZkZSTUFLRmpvQytNRFc4VVVld08zVUI3QUxtKzdYRzlN?=
 =?utf-8?B?cUM1YTUwM0I0N0xiTU1mbzgwVnNZZ2l2dnNpSlJySzNCbWl3T2huL0R0VWF2?=
 =?utf-8?B?OXZkNVpldnlsbjNKZUF2dlk5RjZoQmhvQXRORkhJRlhESllhYlhKUWoxMEpR?=
 =?utf-8?B?NTZnUHA3R1BKakZOK3pQK0ExclpjREgvSXh0cDNJYmdtMy9TYWpzZ05nTGJl?=
 =?utf-8?B?aXViK05vWGFxU3BpRlNjdjdWQUpVcndpY1NBVHFNL0FPQ05qQXBOb0IwdmRM?=
 =?utf-8?B?ZmZ3eXpONEttRUgzU1VZbFNpZHFNSjJyMkFhaTVWWFhsNzJyMkNKYkpZVXAx?=
 =?utf-8?B?TXRDcHdyeTdsZkJEQWdwN05PTkR6NFFZbnFBOUFndjROQnlUMCtSZlpaWEpi?=
 =?utf-8?B?Z3h3Kzk0YUpIUzVKUW5ORDBkd0E2SjdnenNXQXptL3M3TzQ0Q3VycmtRRzdT?=
 =?utf-8?B?ekd1WE90d2NYQ3NPME13Nnk5ZmJzYS9IU212ZzlXdkhyblhhY1FEbmF5YUxK?=
 =?utf-8?B?SFBVQVNFbGdpWkVmNEdYczYwak5GUVFBRTlHYzE5TWlQVmkwY3luOGFtSjdI?=
 =?utf-8?B?Rk1XWU4wMUdrYTl4QlN5ZU5oamJVQitNQllhYTQ3VUoxaEV0WldxK29TSCty?=
 =?utf-8?B?ay9KMGV5OTNPMFVRNUVNZEh2SW5BNG11NUltWk9BMlZSNnBrZjc2NlRWQmFO?=
 =?utf-8?B?K0h1c2pzNkJ2MWIrUk5laWpQcjN6VGM5ZHVBOUJIMXBwc1MrSWRlY2wwdUs4?=
 =?utf-8?B?S2s0L0hKMmJteFdkWVY5TjVXN3kxM0JwcHBmR1JsM0NXUGw1NjBLMFI0TDNo?=
 =?utf-8?B?Q04vQ3dGaGJGYllsK2ZoNnhLOHdRQjRGSjVtVGxmeVZZRUtaTkQyZEdoSlI1?=
 =?utf-8?B?elNSTklIYXVwMkExZGdjQzI2REZ0QjF6Z05KVjQ0aHlVOGdCamtoYytpQTJr?=
 =?utf-8?B?ejdSVnJoaDlCWUszcE9sT2U4WGRINnE1Nk5ZanRRZTlEbmtjMUxFVW1ySExJ?=
 =?utf-8?B?WU1kZE5BenNGcy9SQWJPaW5KSkJTbGMxY1J5bTMrYkxCdDdteDduT01Wekxw?=
 =?utf-8?B?bzVibkI5QitpZE16YW9sbFBseE9WTFgwZHdkblMxbnZ6QytPdDlFUkNTVnAx?=
 =?utf-8?B?bmxLM1BZY0txeWd6S3dqdG9TNm4xNzBqdTNCVWJ1c1NqMThnZFI4Zm4rNm9j?=
 =?utf-8?B?SHVMNFJRTldiUXdYS2VHTDNoREY5V1F2UW1QMVNmSWNHUmwyam95dDJLNnhh?=
 =?utf-8?B?d2QyVUNUQkVLYnJrV0JGaWVzdmVnOWd3bXVUUkloNWZOYmZSYm0wK29QMVMy?=
 =?utf-8?B?MU83RmIyRXE0a3hlNHY4MkF6THJDZjZWVDg3cGY3MzgySDRvZG90by9uM05m?=
 =?utf-8?B?R2hxZUVxdW9FL1dxeGxKMFJhQmsxcGl2WFArNE4wOXJtWHFvSmV4WkNjbU5X?=
 =?utf-8?B?TTdvT2thZGJiOSs3SVh3WnB4Qk1Pb0p6cldlZVdoOURIbXVmWlRpd045UVJY?=
 =?utf-8?B?QXJTVndaelJMWkpqTEhpQkYzN1ExMlhXaC9UTFBTMldHY2FjS3ZyWTR0OXVX?=
 =?utf-8?B?TkM4YThBTFBqaDJjS3AxSFBZY29YMTZUN0tRNG9DZ1VHR1Mrdkk1T2d2TlZC?=
 =?utf-8?B?aEc5TjhDekRLSWdIWGNsTDArNGhGakZqSUJ4dTJydWxRRkdVZ1ZiNXY4blly?=
 =?utf-8?B?eWY0T3hRYlBaYzU5dlQ4cjBScEV3MklOSVgwNlFzUGI5Y3pzREY1TXFDRm9J?=
 =?utf-8?Q?J53jTFIwaX418TQ4P05wu7doR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rbRjnzJANpwPqofJ3bOgVYa+Wmj8Qntn7OTwPJ3AnQCAvZjVyGHQCukEfBD4pMAXLIv/VruAT2Uz4zZasJiPC8GuPouTDR+PdByxrc5StNxXH3S5OUHzPqF/vVEMbZAlmXo6sX079dX8/3fPQcokYGzfF99BApPfib06raiMUrniIa1cdPPWxMib3/VQPb0OSYOgtva4ahv6JsIylc8sChMoVQ9v8gG2sFMiFTPMjB8PT0teGoI3Np6YfvboTPONsqW4lCtjDDHGP+31Ug6UpjqFwBG5JSc7TELzBhfo1ag5DDDE/WlpIB33l50pgQBWp2Rv2A3hH36OFI/ispxGBXWB/W3yT3vivf2yHM2Qz3CrPIMT9hYsTZBUxegRwC92jKf53sbVkWJS7PI3POFwsVZZjxH4Uth1fdCovx3Iut8kpxmaVGW0+GdvOPRIzKlD7xHik7PKqVF3VD/NIuE7OAR57HdDE6FIFyUPdyowjDMcP9A98jAp30x1OWjoe17CYl1LJpAQ7RFeNn3oOAiQUfWMEc8NTjdccq/WL5Md/5EHNLMkRKm27lmiu3F77zUgPPjD5z152KUV2mN/dJUX2F28/pFd4BZrh62qARE2XEx+ZciQoLmNxCTPFocpeXTE07YMfqb51rFxVhl+jqlcNn9nOYAhZPNDSehXPoG6UUsRhZ2NZ6K6emlpq6DXG72nmDOgbvG41Gk7zBIwTYUMTgdh2LQXZAzbu/tNAXo+TnRNwTarhzymCR989/OpHdAmWWPc2lahHEQnxlrxALdJZQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba51c12-aac8-4835-592d-08dbf5dbb498
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2523.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 21:46:58.3160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qx8cA1K/S2hxP9Soa/H6YoXx8lluu34m7Hg/50mxTyKNqZzVipZgMX77HViChyz5RNybQ9NK4kxvQYCNE8/bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7839
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_17,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312050168
X-Proofpoint-ORIG-GUID: IwXKNUs2D1e1UaxoaKSaPZm1U3Gb7fJw
X-Proofpoint-GUID: IwXKNUs2D1e1UaxoaKSaPZm1U3Gb7fJw
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -67
X-Spam_score: -6.8
X-Spam_bar: ------
X-Spam_report: (-6.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.02,
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

Hi Markus,

On 12/5/2023 3:34 PM, Markus Armbruster wrote:
> You neglected to cc: QAPI schema maintainers.  I found it by chance.
> Next time :)
Yep, should have cc to the maintainers.
>
> Annie Li <annie.li@oracle.com> writes:
>
>> Following hmp/qmp commands are implemented for pressing virtual
>> sleep button,
>>
>> hmp: system_sleep
>> qmp: { "execute": "system_sleep" }
>>
>> These commands put the guest into suspend or other power states
>> depending on the power settings inside the guest.
> How is this related to system_wakeup?
Both 'system_sleep' and 'system_wakeup' trigger the event to notify the
guest OSPM the sleep button has been pressed. 'system_wakeup' triggers
wake up notification when the guest is in suspend state.
>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
>> ---
>>   hmp-commands.hx            | 14 ++++++++++++++
>>   hw/core/machine-hmp-cmds.c |  5 +++++
>>   hw/core/machine-qmp-cmds.c |  9 +++++++++
>>   include/monitor/hmp.h      |  1 +
>>   qapi/machine.json          | 18 ++++++++++++++++++
>>   qapi/pragma.json           |  1 +
>>   6 files changed, 48 insertions(+)
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 765349ed14..bd01e49ec5 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -652,6 +652,20 @@ SRST
>>     whether profiling is on or off.
>>   ERST
>>   
>> +    {
>> +        .name       = "system_sleep",
>> +        .args_type  = "",
>> +        .params     = "",
>> +        .help       = "send ACPI sleep event",
> Suggest "push the virtual sleep button", because it's easier to
> understand, and consistent with the documentation below.
ACK
>
>> +        .cmd = hmp_system_sleep,
>> +    },
>> +
>> +SRST
>> +``system_sleep``
>> +  Push the virtual sleep button; if supported the system will enter
>> +  an ACPI sleep state.
>> +ERST
>> +
>>       {
>>           .name       = "system_reset",
>>           .args_type  = "",
>> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
>> index a6ff6a4875..641a365e3e 100644
>> --- a/hw/core/machine-hmp-cmds.c
>> +++ b/hw/core/machine-hmp-cmds.c
>> @@ -185,6 +185,11 @@ void hmp_system_reset(Monitor *mon, const QDict *qdict)
>>       qmp_system_reset(NULL);
>>   }
>>   
>> +void hmp_system_sleep(Monitor *mon, const QDict *qdict)
>> +{
>> +    qmp_system_sleep(NULL);
>> +}
>> +
>>   void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
>>   {
>>       qmp_system_powerdown(NULL);
>> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
>> index 3860a50c3b..9f1e636c90 100644
>> --- a/hw/core/machine-qmp-cmds.c
>> +++ b/hw/core/machine-qmp-cmds.c
>> @@ -257,6 +257,15 @@ void qmp_system_reset(Error **errp)
>>       qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET);
>>   }
>>   
>> +void qmp_system_sleep(Error **errp)
>> +{
>> +    if (!qemu_wakeup_suspend_enabled()) {
>> +        error_setg(errp,
>> +                   "suspend from running is not supported by this guest");
>> +        return;
>> +    }
> This can't be right: it either fails or does nothing.
>
> I guess you're leaving the "do something" part to later patches.
Right. This patch focuses on hmp/qmp, more implementations are in patch 6.
>   That's
> okay, but it needs a TODO comment here, and a prominent mention in the
> commit message.

Good point

>
>> +}
>> +
>>   void qmp_system_powerdown(Error **errp)
>>   {
>>       qemu_system_powerdown_request();
>> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
>> index 13f9a2dedb..d72a3b775c 100644
>> --- a/include/monitor/hmp.h
>> +++ b/include/monitor/hmp.h
>> @@ -45,6 +45,7 @@ void hmp_quit(Monitor *mon, const QDict *qdict);
>>   void hmp_stop(Monitor *mon, const QDict *qdict);
>>   void hmp_sync_profile(Monitor *mon, const QDict *qdict);
>>   void hmp_system_reset(Monitor *mon, const QDict *qdict);
>> +void hmp_system_sleep(Monitor *mon, const QDict *qdict);
>>   void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
>>   void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
>>   void hmp_announce_self(Monitor *mon, const QDict *qdict);
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index b6d634b30d..3ac69df92f 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -297,6 +297,24 @@
>>   ##
>>   { 'command': 'system_reset' }
>>   
>> +##
>> +# @system_sleep:
>> +#
>> +# Requests that a guest perform a ACPI sleep transition by pushing a virtual
>> +# sleep button.
> Imperative mood, please: "Request that ..."
>
> I think "the guest" would be better.
>
> Limit line length to 70, please.
ACK
>
>> +#
>> +# Notes: A guest may or may not respond to this command. This command
>> +#        returning does not indicate that a guest has accepted the request
>> +#        or that it has gone to sleep.
> Please format like
>
>      # Notes: A guest may or may not respond to this command.  This command
>      #    returning does not indicate that a guest has accepted the request
>      #    or that it has gone to sleep.
>    
ACK
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "system_sleep" }
>> +# <- { "return": {} }
>> +#
>> +##
>> +{ 'command': 'system_sleep' }
>> +
>>   ##
>>   # @system_powerdown:
>>   #
>> diff --git a/qapi/pragma.json b/qapi/pragma.json
>> index 0aa4eeddd3..ef15229854 100644
>> --- a/qapi/pragma.json
>> +++ b/qapi/pragma.json
>> @@ -23,6 +23,7 @@
>>           'set_password',
>>           'system_powerdown',
>>           'system_reset',
>> +        'system_sleep',
>>           'system_wakeup' ],
>>       # Commands allowed to return a non-dictionary
>>       'command-returns-exceptions': [
> I figure you spell system_sleep with '_' instead of '-' for consistency
> with existing system_FOO commands.
Yep
>    That's okay, but I recommend to
> point it out in the commit message.

Will do.

Thanks
Annie


