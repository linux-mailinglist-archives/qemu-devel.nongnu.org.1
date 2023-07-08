Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7486C74BD05
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 11:15:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI41m-000056-OR; Sat, 08 Jul 2023 05:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qI41j-0008WJ-VE
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 05:14:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qI41g-0008U8-Q3
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 05:14:51 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36895D1n019574; Sat, 8 Jul 2023 09:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=iwhZZEiq9UVbn6sQ//8Ml5AQUYEKijHJ1HSCcCi7Gf8=;
 b=DV+An8zxf7oWY8fJW8v2ZVfSzaxGXRqHuapljojxJnbHLP1vzScPwnEQ1Ou5x+IvFsCl
 5elCv1gkY47r2G3jt3Lq92ZDTDAlUgZgqc5kEog8Ky27agB2mK9+djwoKBQSK+aHoS5G
 t1AxY9hQXj6qy7ohLQ0an0HjwoHlvgyuWGsWOsSFSCecc74bRhCxJfe2lKIlX+9beqU1
 zv9xpIlW60/dbYTtUYwATKCnBUgZwv1C0TEAcbirpXV4DtfCNbkWJhbRsgQ7Dsem1dwh
 orTaaHOAHH3qHFhdQcWUy4trt8F+uYvpjjT85GXwlfkkqS7NcKRC/8eofQE+JwGJFGUP ow== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rq4uhg0d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 08 Jul 2023 09:14:35 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3687HGYq016042; Sat, 8 Jul 2023 09:14:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rpx81qx53-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 08 Jul 2023 09:14:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh9fdUUA6SoQPrGzy2W/wuTM8C3FID1hKrQy09UYbk8OYTkvcC0hWxoaa2EjBjgTEvsh6JpNnO/VYOSLH1he0hFLzLCo7BpsHMH/Ulvv4xNbI+23lWxuxa4wJ8Rlov5cOAap1hM0zaBvVryd3PmtVLX5v5vYR5DFazv/0HOIJLVMs/updjuFrQ1KhiMzo8dfGPjdITAsegeiUv4rWYKjmbs6NLPxBfWD1nX0PIyYVmP/pINQsoNgfUPjDgz/5YijDkgjfBAVbhdnN3tE2FddwpKF8ZcR9l2m/MAWlL8L8WqGCZeWgGMOwxbySqiLKhrZavByLdlLcmlvaYhK9OxIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwhZZEiq9UVbn6sQ//8Ml5AQUYEKijHJ1HSCcCi7Gf8=;
 b=Obn+Lldq9uIr5USFXcPtRfof/mre+xk2jqn0nlLR03KUcZYMBgBzhonXj0Ubh3xHsbP8pJHR1/gdAyqu4fLj4/ojpb1Dr3M0yTvSngE9fLwF1QDWcBgLawV3EikYeT+qpHeC2H/fVmvdwJtOzJsgtdfHkk/GylMijdcHyQIk0GT8GgbrD2wGj8JWJmfJbHFyyvJl6fa0v6h7eKHSM0qp1kg5RIVhqrsibleuQgg0N0Nzgk80SXuj0wWBVAVHBASvxcUgjRf/c9CAf2rR1WBhVkGVCOwio07NBX1h5MLWsBAToiGvFWZ4t8wUqi5EH7L13J0n0J9BLpsSjTdC2L/nHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwhZZEiq9UVbn6sQ//8Ml5AQUYEKijHJ1HSCcCi7Gf8=;
 b=ezaWUfAZs+SFuo9gmWSfXgk90vigreUeZAodDJA15caKCjv1qMEW+3C+oqNYigThPwhBGZf6bAW0TkK8+4zttwXBdT0s7taW4RuVjunNtcspkMqZe2Qq25l8bTbvy74QmP0JWZNBaOPsBCltMLRl5Xz1H1OUYQw0dE/OL9HL5Fo=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SJ0PR10MB4525.namprd10.prod.outlook.com (2603:10b6:a03:2db::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 09:14:31 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9842:10ce:30cd:cd06]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9842:10ce:30cd:cd06%4]) with mapi id 15.20.6565.025; Sat, 8 Jul 2023
 09:14:31 +0000
Message-ID: <88be4f76-f03d-fd50-8eaf-c6f7f7d31810@oracle.com>
Date: Sat, 8 Jul 2023 02:14:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Reducing vdpa migration downtime because of memory pin / maps
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Michael Tsirkin <mst@redhat.com>, Longpeng <longpeng2@huawei.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eli Cohen <elic@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Juan Quintela <quintela@redhat.com>, David Gilbert <dgilbert@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <CAJaqyWdV6pKP0SVZciMiu_HN86aJriZh0HBiwHNkO7+yErXnBA@mail.gmail.com>
 <c59d2d67-d31a-b6e6-54c5-5b81c18d9547@oracle.com>
 <CAJaqyWegsVHEVZt2_mf4wA8MuF7UXmU=UbHJfwyzURDRxfRgmg@mail.gmail.com>
 <bff286b8-0103-1698-c77d-736417396405@oracle.com>
 <CAJaqyWcwFgEH3MCOAhHe20P3oy2_aq2BUkTA9_7wePsT8=GoAg@mail.gmail.com>
 <8db2b6cf-1e32-67eb-f6c0-fe3a4175b410@oracle.com>
 <CAJaqyWd_wb5eXcTi2R+-n=AriP=rwKTCwObz1sZ45eRrpLw_wQ@mail.gmail.com>
 <a73797a7-a71d-9ac9-f92b-6bfad2c79058@oracle.com>
 <CAJaqyWcDLG3zG3-4Ht=ebWh-yAXY=srazwuOv1jy3sR-+dPfqg@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWcDLG3zG3-4Ht=ebWh-yAXY=srazwuOv1jy3sR-+dPfqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0197.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::6) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SJ0PR10MB4525:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d3fb4f-fe8d-4e86-de11-08db7f93bca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vXArOAgThqglt/q4/1FrN/NPbTiAz4UNXKV/1JNJel2Q9SJ6vr9NJncCRbE4lAmUT0nOmSgkiJo6SqNbP1XltM0vMGWds0g90a/5MXwYZARUPMHxHj++YAS+Jgqws3hI3c4HpemuGUO5BjtUcx/ux3CgzHJTv2/exuomnVixQTl9BX1YI5v2hjy5Xx+AW+fHjO0SIUuRdC0j+/H73uFZ/S43Do/YYpleF25xQehhVi8EELIevSfhyF4I+goPZpmPf9fmy4m3q1YpKO8BHFFO8JJPNJSjSf0TIBl9WpRejZfNbgijeSi9sm8CAcc/taEvL9SxqURv7hpoJKGphhW8Pdqnyex4n65HFme8GaYXKF6E8zqAJ9sQHihnruUvoEGoUbaA0eL69esBKM77cY94jbHFDiKojkS3e4blFzbqzaKD2FgrbGJNDh1e4KZk+PnnLmBeI1U571dqVZTDN/3P3dmjWKpJXsK38aloINpTbdL6kkNqqwqrS3U2bwihZu2XiFNfd3qRcOt5jgkZvD1xFxa2m/EI0RRenqMlWmEBd8kn3jQosFnnLzUL2h2m1XoytFxrRyGca4RtTDN+m/tADi1KBcCccYK4brFZDV7mRjWgNHz8oswIh7tTsW3QxeomVGj457Uf0j/19au68+gvCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(4326008)(6916009)(66946007)(66556008)(66476007)(38100700002)(2616005)(31696002)(86362001)(186003)(53546011)(6506007)(26005)(83380400001)(36756003)(478600001)(6512007)(966005)(6666004)(6486002)(36916002)(54906003)(30864003)(41300700001)(7416002)(31686004)(5660300002)(8676002)(8936002)(2906002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1lndkNFeUlaWnliKzlzME1qMHprVyt6TnJYdnQ4VjU5aFh0Y2dBRHo3YTJG?=
 =?utf-8?B?VHB2UUJMUlRwUVlOU3gvSWF6a2Y0WGhGMWdlbVZydGpmWHFPN0xINnpGTTZH?=
 =?utf-8?B?NGJUT0tIa1JiRWZnc003cTA0b1YzRWRjaFNETTdxSEJGbXJtMDlnc0dlVDA0?=
 =?utf-8?B?clBBaXVmc3d4Y3hRUldLWDYvMUFSbU43QXRVR1B6Z0s4MW1YVlVMSU9XWGRN?=
 =?utf-8?B?MGZUNG4yN3VxNVAzZ3Fuai9icjlNYW55dzhOVEgrbi9xRnl2NXdSVVZnZUZY?=
 =?utf-8?B?V0o5RTdEQTlTbkpFMDFDZmhveVVYd1l2YkJHWXNTV1dQeGZDVUltbTdYRFlv?=
 =?utf-8?B?Y3FwTGJEYndzVlg5NnlMMklQSnpwc0NzeW9ETDVkVWRYY1dhNHk5VFpOaTQv?=
 =?utf-8?B?T2pKdUhMakw3d01RZVNLWW92M2VDOEdzYU5LK0p1cklNK0F6Z2s1U3BLU080?=
 =?utf-8?B?aE5idWpqVHJ2SzVCSmFyb2hYVFNVUEc4Y25sQy9INHVYdXFMdm55SUUzRS9X?=
 =?utf-8?B?Q095QnFxNHZXeU5XL2JrSGZKeHdZZXJUcjkyVHBIdithaE15Vml1bnBhYzNE?=
 =?utf-8?B?OHI4NSt6bWwrZUxKa2hWWngrOElRUzMvUkdGTnlaV1ZvNXBCK1c4enhhcEFm?=
 =?utf-8?B?TzJLMDc1dWg0MXJHbm5yK0UrbGUyUERxd3BaMzN4NkNESUplRUdKK0wzN2FJ?=
 =?utf-8?B?MEhIcFlrSEZjN05TK0dYa2JoRktsN3Joby8wNTIyTEQxM2ZDQVpWRVc0Z2Y4?=
 =?utf-8?B?OVF5ZHpyTGxIbE1YYmNpSEhadVhmbFFVdzRhakRaejFjWDVVZjc0aW9pSzFF?=
 =?utf-8?B?aDBOdVNUUFhPZmxOVG5va3doQlBydU1NTFJycy8rKzdOMTZxNW9JS09PWW5p?=
 =?utf-8?B?UmVjd1MyZHdjN2ZLcGlIemlIMU13VFMzbDF5NTliTEZqdnZmb3FDU0g0TFRZ?=
 =?utf-8?B?TkdBV1dMSXlwWlZHM0I3bW4yTXY1YzdodlBtV1J4dWw3QXRvTkdHdjRQZ25t?=
 =?utf-8?B?bDBMWE80MjNzQ1c0eTdBMWxjTVZJSUtRTkVodXBVa0c5bXR4U1d2Q2dieXBv?=
 =?utf-8?B?bmNkdUpyUVFCTi9UeWxkclVLY3JmNXNEckx2djNpa2Zoam1kNGY0K0NXU3lz?=
 =?utf-8?B?YlYvbFNVSHFCNTA0UFBYMzQ0VldEVkJHSXhxUGZrMEw2S1FPU1lRaW1QL1VI?=
 =?utf-8?B?cEFrMmJMTllvMkhxcFdnQ1RwaEdIa2FDYk5UVll0TEo1ZEZ5ZHVVQW9FeENF?=
 =?utf-8?B?S2xTTi9CVEVHNE9jU2JqNDN1Q3RsTk9zdEw4dTgyMnhzdFY2YWNYenFJblR5?=
 =?utf-8?B?SUxxVVhVTmZWK3gyd3ZHZUE3WUJqVTBFQWtSYVBRZ2hYQkFHRUJGUmF3aFJu?=
 =?utf-8?B?SkxzZWRUNXVmNktuRXRJc1NwNGZMREJBWFNPQ0lYNWt1OUFXY1F3U09OT2Mz?=
 =?utf-8?B?WG9HY042U3c0RWZhR01oSTNmZUFjUVpUdnozWTA1MzZhYjJNYWNBS1hlUWVv?=
 =?utf-8?B?ZDA1UTE3MUhBRzVUSXNuSzUwd043TXdFUkVuMy9uTi9ZaGoyVElkckE1SUwy?=
 =?utf-8?B?ZE81RGQrMWNFdURwS1oxNkVRZWxtMkZ0UW5zMWZ4OXhEZkQ2eHJWRmdlN21l?=
 =?utf-8?B?TmtEZ0c4ZHBSL1dQcVFXaWVvZnd3KzJuRllCdHhhWjlZT2xnM1AwVGVwOTZh?=
 =?utf-8?B?RVB0VFI2V3I0N3k4UnNyVGIrb2dHTlNPNE9ZTUI4OTRMcXdLVExKZ3QyK0N3?=
 =?utf-8?B?aU9wWnU3eVB6NGlEMlNvekNmV29ScHNoQkhHc2hXQlJqc054cnZudzBLN0FV?=
 =?utf-8?B?Vis4cksyUE8zaFBzTWxOZzB4YnFMbHVWWkhLSWptQi9WRkhiMG5QMjY4MDlE?=
 =?utf-8?B?c2VjK0lmRHFRNWlURVhBMXhPQ3lib3l5MFQ4aWlMRCtjQzdGZzJJN2QxdnZP?=
 =?utf-8?B?ZUJ0Y2Y0b1VLa1UvbjA0cEpYMHgzVk85bTdySll4MjdNUVFlM2pTMmZVc1p5?=
 =?utf-8?B?NVdhNGdtOHU1NjU3aE5XNWJudjk4aG1DTHVVUU4yUTl1RXBuZU05OVhhc0d6?=
 =?utf-8?B?VEtjTC93aXhvbWcveDJoREJPNWxFejBPekFGakJTYWUyWXNyTVBlanVZNk1O?=
 =?utf-8?Q?hYDQj6thPyLrp4qlRZRHzX4em?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iXWt/nevQzL52YfhUf70JBHSdSAllTtawNb6wWrqIgErQqnT9bFpDrXBpT8TTz2cGiQSg33/BvRm9/1D8g9zYHWjU/z3/E3DIBMsTDXYUj120NAHJcovGSIU8tB01UcyxRYy0XwGg1UgDGvC5mjuNjwQCk7u5H+v4zpCeZiRyRwTVqcf0/QMjWu57pd61jkcdtkHnd9WzormW02PjW8pXIqO5oyQpwOMIIAWSCiHo7id9Wzm4jSh5Zg1Sa7emt42AazNhOPs+JLNmdEAt6pvn7IRNso/DqUgymfDANlXuK9vQjACDz8dSU3DfKHeJ3CugQMlRq/vhTSj7czWwW1E2fYZWtdpxExXXgKlKhXSKOh3OU29htJGIAt7YYYw/XB/XAsNgOo5/6aEX2cN9WzgVtBYkY3AXa0/03JmH27EMdTQqHGkPNjfkvhiV2OeasGQoCBRmAXKuX1yrlrJHxaUc73S6w3gDxNJOBiiWOgZyo615QbJGnO8rBn/Kp/N9QEwZeERyjZg2P5AgWv7epXXmhTlVyPMnZsxHmN7QJ9MCeXs8vyBJq53m+A16MWOeXx1Cy1nPD3eg0I4XU4Rz6nXQbJJR77LsFw5lz0T9NzgDS+wlTgVJKcWTpGDC9MXvDZ7xbMYPQyc5A9YEvYc2S8axHve8Sv7/vH5jN1sZqIgezxNLen7c9dU7cOz/m2KQhKcYTxKO1Dqv5boR0TPv1qr+MeTf2OQ6qtZMsmymR5WL5dUjJkdFbbDLlGN3cBMCmgJIYMBfOMUZafFc5p59S/6XfwwWEIFm/RE0o66jR5mWRmRoucyd0c7rOniozMWOjXoBwg7b1wChen5ORHnWfC9tQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d3fb4f-fe8d-4e86-de11-08db7f93bca5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 09:14:30.6834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHEH7wFNJmHm9ADjccckcjsOVlqNm1t3IEzc93wP1Xcyyx/i02tHIuVZW0HDbIDnpTZBuplMmslU+a1cHbwbYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4525
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-08_06,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307080083
X-Proofpoint-GUID: 8gUxh62PDnHL0v91OEvDpWj5ORhUJEFs
X-Proofpoint-ORIG-GUID: 8gUxh62PDnHL0v91OEvDpWj5ORhUJEFs
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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



On 7/5/2023 10:46 PM, Eugenio Perez Martin wrote:
> On Thu, Jul 6, 2023 at 2:13 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 7/5/2023 11:03 AM, Eugenio Perez Martin wrote:
>>> On Tue, Jun 27, 2023 at 8:36 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 6/9/2023 7:32 AM, Eugenio Perez Martin wrote:
>>>>> On Fri, Jun 9, 2023 at 12:39 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> On 6/7/23 01:08, Eugenio Perez Martin wrote:
>>>>>>> On Wed, Jun 7, 2023 at 12:43 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>> Sorry for reviving this old thread, I lost the best timing to follow up
>>>>>>>> on this while I was on vacation. I have been working on this and found
>>>>>>>> out some discrepancy, please see below.
>>>>>>>>
>>>>>>>> On 4/5/23 04:37, Eugenio Perez Martin wrote:
>>>>>>>>> Hi!
>>>>>>>>>
>>>>>>>>> As mentioned in the last upstream virtio-networking meeting, one of
>>>>>>>>> the factors that adds more downtime to migration is the handling of
>>>>>>>>> the guest memory (pin, map, etc). At this moment this handling is
>>>>>>>>> bound to the virtio life cycle (DRIVER_OK, RESET). In that sense, the
>>>>>>>>> destination device waits until all the guest memory / state is
>>>>>>>>> migrated to start pinning all the memory.
>>>>>>>>>
>>>>>>>>> The proposal is to bind it to the char device life cycle (open vs
>>>>>>>>> close),
>>>>>>>> Hmmm, really? If it's the life cycle for char device, the next guest /
>>>>>>>> qemu launch on the same vhost-vdpa device node won't make it work.
>>>>>>>>
>>>>>>> Maybe my sentence was not accurate, but I think we're on the same page here.
>>>>>>>
>>>>>>> Two qemu instances opening the same char device at the same time are
>>>>>>> not allowed, and vhost_vdpa_release clean all the maps. So the next
>>>>>>> qemu that opens the char device should see a clean device anyway.
>>>>>> I mean the pin can't be done at the time of char device open, where the
>>>>>> user address space is not known/bound yet. The earliest point possible
>>>>>> for pinning would be until the vhost_attach_mm() call from SET_OWNER is
>>>>>> done.
>>>>> Maybe we are deviating, let me start again.
>>>>>
>>>>> Using QEMU code, what I'm proposing is to modify the lifecycle of the
>>>>> .listener member of struct vhost_vdpa.
>>>>>
>>>>> At this moment, the memory listener is registered at
>>>>> vhost_vdpa_dev_start(dev, started=true) call for the last vhost_dev,
>>>>> and is unregistered in both vhost_vdpa_reset_status and
>>>>> vhost_vdpa_cleanup.
>>>>>
>>>>> My original proposal was just to move the memory listener registration
>>>>> to the last vhost_vdpa_init, and remove the unregister from
>>>>> vhost_vdpa_reset_status. The calls to vhost_vdpa_dma_map/unmap would
>>>>> be the same, the device should not realize this change.
>>>> This can address LM downtime latency for sure, but it won't help
>>>> downtime during dynamic SVQ switch - which still needs to go through the
>>>> full unmap/map cycle (that includes the slow part for pinning) from
>>>> passthrough to SVQ mode. Be noted not every device could work with a
>>>> separate ASID for SVQ descriptors. The fix should expect to work on
>>>> normal vDPA vendor devices without a separate descriptor ASID, with
>>>> platform IOMMU underneath or with on-chip IOMMU.
>>>>
>>> At this moment the SVQ switch is very inefficient mapping-wise, as it
>>> unmap all the GPA->HVA maps and overrides it. In particular, SVQ is
>>> allocated in low regions of the iova space, and then the guest memory
>>> is allocated in this new IOVA region incrementally.
>> Yep. The key to build this fast path for SVQ switching I think is to
>> maintain the identity mapping for the passthrough queues so that QEMU
>> can reuse the old mappings for guest memory (e.g. GIOVA identity mapped
>> to GPA) while incrementally adding new mappings for SVQ vrings.
>>
>>> We can optimize that if we place SVQ in a free GPA area instead.
>> Here's a question though: it might not be hard to find a free GPA range
>> for the non-vIOMMU case (allocate iova from beyond the 48bit or 52bit
>> ranges), but I'm not sure if easy to find a free GIOVA range for the
>> vIOMMU case - particularly this has to work in the same entire 64bit
>> IOVA address ranges that (for now) QEMU won't be able to "reserve" a
>> specific IOVA ranges for SVQ from the vIOMMU. Do you foresee this can be
>> done for every QEMU emulated vIOMMU (intel-iommu amd-iommu, arm smmu and
>> virito-iommu) so that we can call it out as a generic means for SVQ
>> switching optimization?
>>
> In the case vIOMMU allocates a new block we will use the same algorithm as now:
> * Find a new free IOVA chunk of the same size
> * Map this new SVQ IOVA, that may or may not be the same as SVQ
>
> Since we must go through the translation phase to sanitize guest's
> available descriptors anyway, it has zero added cost.
Not sure I followed, this can work but doesn't seem able to reuse the 
old host kernel mappings for guest memory, hence still requires remap of 
the entire host IOVA ranges when SVQ IOVA comes along. I think by 
maintaining 1:1 identity map on guest memory, we don't have to bother 
tearing down existing HVA->HPA mappings in kernel thus save the 
expensive pinning calls at large. I don't clearly see under this scheme, 
how the new SVQ IOVA may work with potential conflict on IOVA space from 
hotplugged memory - in this case the 1:1 IOVA->GPA identity guest memory 
mapping can't be kept.

> Another option would be to move the SVQ vring to a new region, but I
> don't see any advantage on maintaining 1:1 mapping at that point.
See above. For pinning avoidance point of view (i.e. QEMU software 
optimization on SVQ switching downtime), I think it's crucial to 
maintain 1:1 mapping and move SVQ vring to a specific region. But I'm 
not sure how complex it will be for QEMU to get it implemented in a 
clean way.

Thanks,
-Siwei

>
>> If this QEMU/vIOMMU "hack" is not universally feasible, I would rather
>> build a fast path in the kernel via a new vhost IOTLB command, say
>> INVALIDATE_AND_UPDATE_ALL, to atomically flush all existing
>> (passthrough) mappings and update to use the SVQ ones in a single batch,
>> while keeping the pages for guest memory always pinned (the kernel will
>> make this decision). This doesn't expose pinning to userspace, and can
>> also fix downtime issue.
>>
>>>    All
>>> of the "translations" still need to be done, to ensure the guest
>>> doesn't have access to SVQ vring. That way, qemu will not send all the
>>> unmaps & maps, only the new ones. And vhost/vdpa does not need to call
>>> unpin_user_page / pin_user_pages for all the guest memory.
>>>
>>> More optimizations include the batching of the SVQ vrings.
>> Nods.
>>
>>>>> One of the concerns was that it could delay VM initialization, and I
>>>>> didn't profile it but I think that may be the case.
>>>> Yes, that's the concern here - we should not introduce regression to
>>>> normal VM boot process/time. In case of large VM it's very easy to see
>>>> the side effect if we go this way.
>>>>
>>>>>     I'm not sure about
>>>>> the right fix but I think the change is easy to profile. If that is
>>>>> the case, we could:
>>>>> * use a flag (listener->address_space ?) and only register the
>>>>> listener in _init if waiting for a migration, do it in _start
>>>>> otherwise.
>>>> Just doing this alone won't help SVQ mode switch downtime, see the
>>>> reason stated above.
>>>>
>>>>> * something like io_uring, where the map can be done in parallel and
>>>>> we can fail _start if some of them fails.
>>>> This can alleviate the problem somehow, but still sub-optimal and not
>>>> scalable with larger size. I'd like zero or least pinning to be done at
>>>> the SVQ switch or migration time.
>>>>
>>> To reduce even further the pinning at SVQ time we would need to
>>> preallocate SVQ vrings before suspending the device.
>> Yep. Preallocate SVQ vrings at the start of migration, but before
>> suspending the device. This will work under the assumption that we can
>> reserve or "steal" some ranges from the GPA or GIOVA space...
>>
>> Thanks,
>> -Siwei
>>
>>>>>> Actually I think the counterpart vhost_detach_mm() only gets
>>>>>> handled in vhost_vdpa_release() at device close time is a resulting
>>>>>> artifact and amiss of today's vhost protocol - the opposite RESET_OWNER
>>>>>> call is not made mandatory hence only seen implemented in vhost-net
>>>>>> device today. One qemu instance could well exec(3) another new qemu
>>>>>> instance to live upgrade itself while keeping all emulated devices and
>>>>>> guest alive. The current vhost design simply prohibits this from happening.
>>>>>>
>>>>> Ok, I was not aware of this. Thanks for explaining it!
>>>>>
>>>>>>>>>       so all the guest memory can be pinned for all the guest / qemu
>>>>>>>>> lifecycle.
>>>>>>>> I think to tie pinning to guest / qemu process life cycle makes more
>>>>>>>> sense. Essentially this pinning part needs to be decoupled from the
>>>>>>>> iotlb mapping abstraction layer, and can / should work as a standalone
>>>>>>>> uAPI. Such that QEMU at the destination may launch and pin all guest's
>>>>>>>> memory as needed without having to start the device, while awaiting any
>>>>>>>> incoming migration request. Though problem is, there's no existing vhost
>>>>>>>> uAPI that could properly serve as the vehicle for that. SET_OWNER /
>>>>>>>> SET_MEM_TABLE / RESET_OWNER seems a remote fit.. Any objection against
>>>>>>>> introducing a new but clean vhost uAPI for pinning guest pages, subject
>>>>>>>> to guest's life cycle?
>>>>>>>>
>>>>>>> I think that to pin or not pin memory maps should be a kernel
>>>>>>> decision, not to be driven by qemu.
>>>>>> It's kernel decision for sure. I am with this part.
>>>>>>
>>>>>>> I'm not against it if needed, but
>>>>>>> let me know if the current "clean at close" address your concerns.
>>>>>> To better facilitate QEMU exec (live update) case, I propose we add new
>>>>>> vhost uAPI pair for explicit pinning request - which would live with
>>>>>> user mm's, or more precisely qemu instance's lifecycle.
>>>>>>
>>>>> Ok I see your problem better now, but I think it should be solved at
>>>>> kernel level. Does that live update need to forcefully unpin and pin
>>>>> the memory again,
>>>> No, it should avoid the unpin&pin cycle, otherwise it'd defeat the
>>>> downtime expectation. The exec(3)'d process should inherit the page
>>>> pinning and/or mlock accounting from the original QEMU process, while
>>>> keeping original page pinning intact. Physical page mappings for DMA can
>>>> be kept as is to avoid the need of reprogramming device, though in this
>>>> case the existing vhost iotlb entries should be updated to reflect the
>>>> new HVA in the exec(3)'d QEMU process.
>>>>
>>>>>     or that is just a consequence of how it works the
>>>>> memory listener right now?
>>>>>
>>>>> Why not extend the RESET_OWNER to the rest of devices? It seems the
>>>>> most natural way to me.
>>>> Not sure, I think RESET_OWNER might be too heavy weighted to implement
>>>> live update, and people are not clear what the exact semantics are by
>>>> using it (which part of the device state is being reset, and how
>>>> much)... In addition, people working on iommufd intended to make this a
>>>> "one-shot" ioctl e.g. CHANGE_OWNER instead of RESET_OWNER+SET_OWNER:
>>>>
>>>> https://lore.kernel.org/kvm/Y5Ibvv9PNMifi0NF@ziepe.ca/
>>>>
>>>> New uAPI to just change ownership of mm seems a better fit to me...
>>>>
>>> I'm not sure about the right solution here, but there are other
>>> proposals to batch ioctls. But maybe creating a new one fits better.
>>>
>>> Thanks!
>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>>> Thanks!
>>>>>
>>>>>
>>>>>>>> Another concern is the use_va stuff, originally it tags to the device
>>>>>>>> level and is made static at the time of device instantiation, which is
>>>>>>>> fine. But others to come just find a new home at per-group level or
>>>>>>>> per-vq level struct. Hard to tell whether or not pinning is actually
>>>>>>>> needed for the latter use_va friends, as they are essentially tied to
>>>>>>>> the virtio life cycle or feature negotiation. While guest / Qemu starts
>>>>>>>> way earlier than that. Perhaps just ignore those sub-device level use_va
>>>>>>>> usages? Presumably !use_va at the device level is sufficient to infer
>>>>>>>> the need of pinning for device?
>>>>>>>>
>>>>>>> I don't follow this. But I have the feeling that the subject of my
>>>>>>> original mail is way more accurate if I would have said just "memory
>>>>>>> maps".
>>>>>> I think the iotlb layer in vhost-vdpa just provides the abstraction for
>>>>>> mapping, not pinning. Although in some case mapping implicitly relies on
>>>>>> pinning for DMA purpose, it doesn't have to tie to that in uAPI
>>>>>> semantics. We can do explicit on-demand pinning for cases for e.g.
>>>>>> warming up device at live migration destination.
>>>>>>
>>>>>>
>>>>>>> I still consider the way to fix it is to actually delegate that to the
>>>>>>> kernel vdpa, so it can choose if a particular ASID needs the pin or
>>>>>>> not. But let me know if I missed something.
>>>>>> You can disregard this for now. I will discuss that further with you
>>>>>> guys while bind_mm and per-group use_va stuffs are landed.
>>>>>>
>>>>>> Thanks!
>>>>>> -Siwei
>>>>>>
>>>>>>
>>>>>>
>>>>>>> Thanks!
>>>>>>>
>>>>>>>> Regards,
>>>>>>>> -Siwei
>>>>>>>>
>>>>>>>>
>>>>>>>>> This has two main problems:
>>>>>>>>> * At this moment the reset semantics forces the vdpa device to unmap
>>>>>>>>> all the memory. So this change needs a vhost vdpa feature flag.
>>>>>>>>> * This may increase the initialization time. Maybe we can delay it if
>>>>>>>>> qemu is not the destination of a LM. Anyway I think this should be
>>>>>>>>> done as an optimization on top.
>>>>>>>>>
>>>>>>>>> Any ideas or comments in this regard?
>>>>>>>>>
>>>>>>>>> Thanks!
>>>>>>>>>


