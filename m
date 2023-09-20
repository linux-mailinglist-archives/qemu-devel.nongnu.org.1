Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB6C7A8AB5
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 19:37:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj173-0003fu-GH; Wed, 20 Sep 2023 13:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qj171-0003fh-8Z
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 13:35:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qj16y-0001gp-4w
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 13:35:43 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38KGiM3m002354; Wed, 20 Sep 2023 17:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=cDl02ApOyaNmrnM1oneJMGYsVmNvGQpPN+vH7l3kd1M=;
 b=LiRsDXC9xXpoLiRYl+W679CPcqizjvMKf3VRoR2cRJXYBD+IzoabJBuPiD1BaraDOgoD
 dJzgN8TOX7bptkDujfiwDx1ZYzjfs//RONt61ObLmdvQOUqdsHoHEpD2Yp435SBqNZhS
 fvEbzThL1r3VMIzp5WsFZXJxfOIqyUFTWxoCc58cFqXCL2WMGXz7JuVaMHtc+V02Lt3R
 aEbowewrJOR4Pd8bKBDbwhhvZVwPQ5ACfcQD7sDsNPof9OE565esdfuv+egr/ug4aR7K
 k4a7WMTKYxaRuYn1WzNuBLwlxxbVzAqIkU1U6EjS9xb8pVZhjQjclR1D56dpCdoiw3IQ 7w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t5353010c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Sep 2023 17:35:35 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38KHKmE2027258; Wed, 20 Sep 2023 17:35:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t52t7nwpm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Sep 2023 17:35:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnZxED+DSN6b0eNye/g5qzoE9pu3e0fajNI1aZ7zt0ATxAhVZoiGB6JR3WhRNlzVFv3yBajezOqpcHrqGrvpp1kkSuHEhFExoB4pNMqiov5tNgpy9uTtFKnHMch5aNEdyQaIM6IsztJT9VrD7ZBOkxW+54EGCcP6scb9yQlU0s49B0JcTP657CdGFO66TdaYhkE0SYJwYSKOfBgYqqrTP8GM5cfU0AfsOwQDgXtHf14vkuuA5+rnAR7MCBQBPnHqH4pdyskmy//T39RFJs/dIIAm65egxJ8GzaMZi48s8QOkjPXxAOMs7/6g+W2PCVBs2/R4F7HDxBonZH78YmqyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDl02ApOyaNmrnM1oneJMGYsVmNvGQpPN+vH7l3kd1M=;
 b=UBVc9hivapG2/fEc9YTdOmipLF/j4TcWQpc6NyeJK/nhYn1XFViIm/+C96PgiXtRe8UuPR+FhFJfT/t6/Otc6Ke4zbhWnvuGCH5BQvsJveUVJqTJVSZcCsop6k1t308Lhk3sjJjxfqBs5N5S2MwFNoqb4DVHd0v7/vuOScqP+QgmNOAj0sC4n0QouPiIVZSJSFlXpA4Nf7mV4N5/BIV2Umn396FDUesh3KiYc+LdGhpd5ls6kLIRgC/I3PN2M6FfIn8AaBdjPvVKpmjLcN4RUtaZjpqHgNlsH2v24UFug17U7QogkP8mpOzOdrqnsJU3xejgPIZfiHcYAQEDMVfNrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDl02ApOyaNmrnM1oneJMGYsVmNvGQpPN+vH7l3kd1M=;
 b=WRTdNGyknR+/AKu9qAeYtDD5RgcZBie2uzooC+YMkJXGctOSrmKaRbZnwyhi4QOh2x3KZa/UF7d0720aVQBquBO5thnfhzZR0CGNsxVtSEeH+Bk1XdgRjqN1tXpJSeOngJWiBP36nkpgd/pTDDaq8XOTsEqITBjt4cbv2RrfJF8=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by PH7PR10MB5855.namprd10.prod.outlook.com (2603:10b6:510:13f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Wed, 20 Sep
 2023 17:35:31 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 17:35:31 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Jon Doron <arilou@gmail.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org, =?utf-8?Q?Marc?=
 =?utf-8?Q?-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Subject: Re: Concerns regarding e17bebd049 ("dump: Set correct vaddr for ELF
 dump")
In-Reply-To: <ZQqj9tFS7cLMTkHv@jondnuc>
References: <87h6nqxdth.fsf@oracle.com> <ZQqj9tFS7cLMTkHv@jondnuc>
Date: Wed, 20 Sep 2023 10:35:29 -0700
Message-ID: <87edisycgu.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:510:5::32) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|PH7PR10MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 885ef600-3946-414e-dccf-08dbb9fffcd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxJErwdlEtT+0gZPH0MQarx5V2pOIq+Pb0bgktncFXPcI89hB47P1UWquFYEY35XfnvmmgHzmhAEV9pPPg7a2rt3om+dxWlLFj56o6Ee7a/Dpt4HWOPtZd7PLMaL3CPb895e9eDB54grqDNwQOqcnPjBFjLTpHwyRt04Tn6dgVPLmY/RwC5//PGIMuQCuUzA8YyCqCZnk6wheddLmgLRmKnwVZt4U8j1o4xSi4hxKuX+HFz80Bjp473TIvhsooQNsXtMn/CPwNf5AZCvF9Ltp1AbydF0WB7D6R5uNjWaBX/eZc/xMGWF77LcfNZ9iJVczAJJYtppqDny6CzVeTZnq2+cSoTRsQntHX4rQPvTjiYZuBcrY8d2rvpjf2b5DKamOUhQ1Kei9rd6JfcMLTO9mngHXxr5Btck4ps4AK3Lug+yAkJQIjdHk2rCH1pBThoSboerdeAlEWW+pzvy6lYVE0ILZ/Wmx0K96JseoQH7OAK6DhfnXQ1d5nBezCobkmCmlQk9nRQMoC9M3tQUBc/GZRRCcdoyI77k6rN0iUCxXS8090ty+rAyG9Y8FD+ElvU1HKV9KoLndB/l1R/1ywBXcIoaHCMSKr2VhB5uLqAc6II=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(186009)(451199024)(1800799009)(6486002)(6506007)(478600001)(6512007)(2616005)(2906002)(54906003)(66556008)(66476007)(316002)(66946007)(41300700001)(5660300002)(8936002)(4326008)(6916009)(38100700002)(8676002)(86362001)(36756003)(83380400001)(2004002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CvctVYoL80NU8+pCgaHFwsmOJeUgqwO2d2Q88kWJIwiUvvUH//d6oE6sqYLY?=
 =?us-ascii?Q?44TPH7eBnxBNDsCxNYsMeEyr57ChZ1oonQQxy/DpYBPNOkDp9AgjJzZXs3yM?=
 =?us-ascii?Q?0ByE1i6jcC9TljNuho1YO+WevxmkAP3qrUIUyULw5vzZd80Ps5VkSia7CDVp?=
 =?us-ascii?Q?DQdYbtCVL6tBOXqseWVyaCruzFeh+8PN7kgtJ0DKTelLrkQCi5mpiABEg+7X?=
 =?us-ascii?Q?lwikKFyuMhZSkQg/W7u0EPtI6AYANfI9AqFpNn5TjyqDJ1nTmacQ+ui/CXPT?=
 =?us-ascii?Q?YqtKiWAvIWxl9ymIOErNhw0jmseGfo7SUAoZFwV62LjAXU/Xl5KWZApTjkR0?=
 =?us-ascii?Q?vEeD/YfjKfZDZp8YZ/nWMGMm3O50slh1EMxWxi3nmEBGqF6W1VX8LG221Nr5?=
 =?us-ascii?Q?W46iXfEs82da/zE1HjTwT6R6ZyXEcATRt/byAPS27tOCpv2HKneTTRQGHUcI?=
 =?us-ascii?Q?TA2BbCFw3nt4eu6IWF+k4JUHxru1am0EUQrAbwTkHc1bk0cUhNPBc9ZdaZbi?=
 =?us-ascii?Q?Jt9QoWocv8lR9mbn69Dh0CDgRVd1jUFF0mNfAT0byMahy+34nnb+vLjBy4xG?=
 =?us-ascii?Q?MRgyXoIL6HCwBWC8IiEwD9r3DId4S5EbLzVYVaPmxFwvS39yFm6e4MC7xOlA?=
 =?us-ascii?Q?wOkU8bOR7HyeC3Kb33JFExeJSQ6vdbp5srrq17wag8XDlGgZY+aTSnERMbvk?=
 =?us-ascii?Q?UqlczvTQOm3/ydTy8ma/uFakhE3xMKSyFItTIiYL7+25rCg/KHwQEH+TIhGD?=
 =?us-ascii?Q?/WuObkaD5SDj/dhTNPkktyrxBhxCLUVSWtKC5bkU52VXOAxAXfR3QJHzKU9Z?=
 =?us-ascii?Q?euhbDGny5KnU9vAp3MEtWx5v4Y5u6+vGf3WEW41GsfhzzU1wPtNvbpGy0Mad?=
 =?us-ascii?Q?SQSWVOr32XcNX+fVrQLIf8FPg2ZwZAv/tk+TuF3xvhKai9xbDn+nmhGfJIsC?=
 =?us-ascii?Q?ZZerf8WlbrxF+wKElmATM9tmNc+LU9LNa77LIFzV0bLU8V027fNXPl0xOHbV?=
 =?us-ascii?Q?+9He2qHoJJCa2cmMhX8GOM4z2OV12JSII0AzlYQL7JGFGw1EiAMDDb1DqN+z?=
 =?us-ascii?Q?bq/WvtoBiFKdbwqXvQg7vrkw3c0kfRzWDKqW0SwbuujRdzGeiWNV9r8z4PtE?=
 =?us-ascii?Q?t0Ha30PJfOxkwwK2WIfphCrdysB6TxNfTJbjv3BnkMmNd5O15d9Ea3QZx3ig?=
 =?us-ascii?Q?DDa/Xo5jJhlRXuV3EY3y3BAccZFICK8bCUUt96z2BqIup9snsGbU6FSZ7/ab?=
 =?us-ascii?Q?UlLOWvWN5FA30y+9IYD4QGx5fPu5SnMMkx4X/XUmreOz6gIYMm61esLj9SKd?=
 =?us-ascii?Q?L7kCpAwq+wucBYHwt5Z4asGulj5S0P74cJynYHsSID6zoVvMQnERhU6qCyGB?=
 =?us-ascii?Q?lFEJSPLX+YVlZof/JNgVfnolHCkhG/CfSscKT3ETbmfD0AYNNoWPW8V7FCFW?=
 =?us-ascii?Q?6XRsKzLaru5dpk7Thw2lPyGlenb2cPRjOTuM8BrVPxcdKin2n0IWH+j3Qv8w?=
 =?us-ascii?Q?Boa9DQjnhfQWVk0XA9JJeqJfiHa/yiS3cu2O8oEkDZ43lmBP/th4HpLHeDiR?=
 =?us-ascii?Q?5/4SIXQoQoapNDo07uv1zUe70mibKvTpYdq/ZQ848AISpHY8mW5yl2ZlHtAz?=
 =?us-ascii?Q?uSw/XoV3SZwh/P09+y7KzIAsUYkHBHL+pY/AxCOBJLR/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ObDQRuOnd7eGHOJLlNKVhVzeIHYmNnJ+GaEMsTho1aWrLNgYVPzz//6sdTpTFSKc1G5Ke4T+TQT5R+nVYz+9DMrCbSJV1+Qajz02zCHL1Y7RpZ5P3/tRq5Le2EDmi7B7dy6uBfuzuhMq8zPYc8DbEt+6Q+aQwKlya0epTKrol+bdX5lV9rzdYF0pObQNT8zvnjlLdVDwZWjhq3d0gigMpLNu2ynW1/OZHlDdo9rXSC50LB25Pxd8keGTdtVqpi+H8dhpOQvsMIfWgGpX/eXddo3a2Yar+erOTZcisSwy9fdo/+3E4W9YrqNCgjPoRN7djQyugTEgx9+9B7j4Cr0sTGKPFgRa75/rSu2hptiAjErfxD/P/SzXCLVwA5O4iaVwDcFb+a7FdvxywfuHZP8+4kgLePH0HVBirTWF0nevxDF8K8+XV2oTLSjhA3DILk6iheG56/OeowZP4m7Z2xb6JxM+tkQQQX6f3bDZKxLKn2aZSf0xQvAY42FD/2peXK1OvMEHqJkhiv4k2aV0X0SFwiQZuy8Sq16Ji5EKl4+tFGspCYtpRfeA9yGDWrunyUo5uZdHmfuUZGJJ7LhXkg1oXW9mchgsmZqlx8WIOo017yRSPdyKFotC8QxpP0WWDZRA4FtUtqCoIGqC85XInNLP+iVhXZo4RqLs/2FqZiu0jrdyYqjtnAJbF8fbWvSANchh19jY0E0Lg58ZW7ddkK7grMoUq28vRsAxQpjjfngzAhdWjAhLEUioxqDJsivW4yb9Tf7KYfV1eqioWi0KldKhtkxuyg1HHPz7BjyTj8TQx3PfPd19MwKS8T4fDjffgMjvxKH7MI2/VFjCM1x7NFYWrdMcip0TBcSnOe3FxoqYgqs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885ef600-3946-414e-dccf-08dbb9fffcd0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:35:31.4175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRTfe+BcZ3eLrWVbtxeQXOMWMF8IUBp84G+gRCiU/QP2Iov19vRqQtMzP3rvAr03DZhYQEOjNmYEIT5f7c8vu8HzAgkbf/AP9iiOproSOjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_08,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200145
X-Proofpoint-ORIG-GUID: NezhkSQvYjzQzW_HuVKp45e_Tyun0Njn
X-Proofpoint-GUID: NezhkSQvYjzQzW_HuVKp45e_Tyun0Njn
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=stephen.s.brennan@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Hi Jon,

Jon Doron <arilou@gmail.com> writes:
> Hi Stephen,
> Like you have said the reason is as I wrote in the commit message, 
> without "fixing" the vaddr GDB is messing up mapping and working with 
> the generated core file.

For the record I totally love this workaround :)

It's clever and gets the job done and I would have done it in a
heartbeat. It's just that it does end up making vmcores that have
incorrect data, which is a pain for debuggers that are actually designed
to look at kernel core dumps.

> This patch is almost 4 years old, perhaps some changes to GDB has been 
> introduced to resolve this, I have not checked since then.

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  NOTE           0x0000000000000168 0x0000000000000000 0x0000000000000000
                 0x0000000000001980 0x0000000000001980         0x0
  LOAD           0x0000000000001ae8 0x0000000000000000 0x0000000000000000
                 0x0000000080000000 0x0000000080000000         0x0
  LOAD           0x0000000080001ae8 0x0000000000000000 0x00000000fffc0000
                 0x0000000000040000 0x0000000000040000         0x0

(gdb) info files
Local core dump file:
        `/home/stepbren/repos/test_code/elf/dumpfile', file type elf64-x86-64.
        0x0000000000000000 - 0x0000000080000000 is load1
        0x0000000000000000 - 0x0000000000040000 is load2

$ gdb --version 
GNU gdb (GDB) Red Hat Enterprise Linux 10.2-10.0.2.el9
Copyright (C) 2021 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.


It doesn't *look like* anything has changed in this version of GDB. But
I'm not really certain that GDB is expected to use the physical
addresses in the load segments: it's not a kernel debugger.

I think hacking the p_vaddr field _is_ the way to get GDB to behave in
the way you want: allow you to read physical memory addresses.

> As I'm no longer using this feature and have not worked and tested it 
> in a long while, so I have no obligations to this change, but perhaps
> someone else might be using it...

I definitely think it's valuable for people to continue being able to
use QEMU vmcores generated with paging=off in GDB, even if GDB isn't
desgined for it. It seems like a useful hack that appeals to the lowest
common denominator: most people have GDB and not a purpose-built kernel
debugger. But maybe we could point to a program like the below that will
tweak the p_paddr field after the fact, in order to appeal to GDB's
sensibilities?

Thanks,
Stephen

---
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <byteswap.h>

#include <elf.h>

static void fail(const char *msg)
{
	fprintf(stderr, "%s\n", msg);
	exit(EXIT_FAILURE);
}

static void perror_fail(const char *pfx)
{
	perror(pfx);
	exit(EXIT_FAILURE);
}

static void usage(void)
{
	puts("usage: phys2virt COREFILE");
	puts("Modifies the ELF COREFILE so that load segments have their virtual");
	puts("address value copied from the physical address field.");
	exit(EXIT_SUCCESS);
}

static int endian(void)
{
	union {
		uint32_t ival;
		char     cval[4];
	} data;
	data.ival = 1;
	if (data.cval[0])
		return ELFDATA2LSB;
	else
		return ELFDATA2MSB;
}

int main(int argc, char **argv)
{
	char *filename;
	FILE *f;
	Elf64_Ehdr hdr;
	Elf64_Phdr *phdrs;
	off_t phoff;
	int phnum, phentsize;
	bool bswap;

	if (argc != 2 || strcmp(argv[1], "-h") == 0)
		usage();

	filename = argv[1];
	f = fopen(filename,  "r+");
	if (!f)
		perror_fail("open");

	if (fread(&hdr, sizeof(hdr), 1, f) != 1)
		perror_fail("read elf header");

	if (memcmp(hdr.e_ident, ELFMAG, 4) != 0)
		fail("not an ELF file");

	if (hdr.e_ident[EI_CLASS] != ELFCLASS64)
		fail("file is not 64-bits: unsupported");

	if (bswap) {
		phoff = bswap_64(hdr.e_phoff);
		phnum = bswap_16(hdr.e_phnum);
		phentsize = bswap_16(hdr.e_phentsize);
	} else {
		phoff = hdr.e_phoff;
		phnum = hdr.e_phnum;
		phentsize = hdr.e_phentsize;
	}
	if (phentsize != sizeof(Elf64_Phdr))
		fail("error: mismatch between phentsize and sizeof(Elf64_Phdr)");

	if (fseek(f, phoff, SEEK_SET) < 0)
		perror_fail("fseek");

	phdrs = calloc(phnum, phentsize);
	if (!phdrs)
		fail("error: allocation error");

	if (fread(phdrs, phentsize, phnum, f) != phnum)
		perror_fail("fread phdrs");

	for (int i = 0; i < phnum; i++)
		phdrs[i].p_vaddr = 0; //phdrs[i].p_paddr;

	if (fseek(f, phoff, SEEK_SET) < 0)
		perror_fail("fseek");
	if (fwrite(phdrs, phentsize, phnum, f) != phnum)
		perror_fail("fwrite phdrs");

	fclose(f);
	return EXIT_SUCCESS;
}

