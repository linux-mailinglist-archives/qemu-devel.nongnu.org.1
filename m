Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 623E0756DDD
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 21:58:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLULe-0001yd-6n; Mon, 17 Jul 2023 15:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qLULW-0001wZ-7a
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:57:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qLULR-0001GS-Lb
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:57:26 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36HIxgH4027592; Mon, 17 Jul 2023 19:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=yoXLJ9c7euc1gdnpbSksFVSWK4ejA4qVAPK/kI0UuC4=;
 b=W0QxaJwOajtdgXKkoUfdVf0++kPm6parDMCTV0gDY5jLmHGfiWUXOmH07FTIEf+PRmVi
 97IbFsGrcgdf7/7Ta1kwf5yRndi4uuM3kSKYpztlacA4T3P9PB4LdnyEo/J1S3lukI9K
 65hjZ8FZTjxoejBrfbHun0J6sjyRL+pxCjwpWkAGoI6a8hCGcgO6ia5vUPiMI6ScYQ5I
 KeMtGzkm78obajseIaEisiesOapYthcRwrmbrmWT/KsBu4t8E1IVzPs8y68DvmUtIGBc
 BnBjra83oGaOyohSwUiVVJCkrB0IFv1vu1F/vHduZe1EOT+laxH0cxRbe0ZblRkvSlRw Ow== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a3kuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jul 2023 19:57:07 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36HJueAA017387; Mon, 17 Jul 2023 19:57:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ruhw44w0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jul 2023 19:57:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6Dc434lSgp9zKhA+0nlPTI1Wtpy/u7SsJADz6lxLWYm/7r+WxAqyn8wHVetAGEaTea2Aok4EL9T5e+YrTMrWCoRVRusJAZJQH9p2H6KFnCWg8JjSmmD/8zxLkiDBTGcmPval4aqCgc2Ti7kPcewZ3nS86vltXnbMcsHiB66SbU5hsUMCisToGgROt2Ih+UdESWutxSvTk1jsfu4U4Jj/fkFo7G5s0ylWDb3P7+PjvCS1dMLSqyuwMzkeZmxgQ48ZmTBLboJzMNFIr1WxAodRv8SN/7HeFpB5sBHi+FhMd9JrNs940AEKArPu1U63Rwf/IMBrBFjVywah0dlxxS7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoXLJ9c7euc1gdnpbSksFVSWK4ejA4qVAPK/kI0UuC4=;
 b=Ujgv2GpXup/EaDd35QwVe+aHg4PH9HlGWpXtRFnm8BfXgO8O3rPSpzjWiHruqWEnvlF8bcMNDVOQQ+isRKACatMM5Q0EKGwKCSZ94rgNYCQuUDmU5ZZpOvHdPk1ZQQJNYuJ1Jt+eRYaGNK2TuKGx1Ooj8ihjK0fnPFAOSj44HZtS6gmLWYuBJT8SiiQyjZE9z3ZuaUg68gEjTp4bRhQrxjd7Gfa6QyMfJBkUc7tVM6CAbVG1lmxoJiRhkEbVoZB4VcKNdpJTAVFzhDhPjOH35V8aE4C+ZJYJKC443la9uFxTAk1+II78Ncvfbzar2/yXCUsYJeZvkQVnJkHMqJRC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoXLJ9c7euc1gdnpbSksFVSWK4ejA4qVAPK/kI0UuC4=;
 b=CRR0yxC8xte3umTkSHXonI68kNRwVYjm7wpHQ85Xk+4dwx5f/n8wIXYfn12UfddTkWVdBk9ZjQfZJQrR2Go4MO/Ikb13NudS/oRcSY3tIC7qG/t+KoysswnhY+8e2cduSeeh06EDZsRyjgqQYx/nNzgZwGteC4rlp16YbbTudEI=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 19:57:03 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::a11b:61fb:cdea:424a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::a11b:61fb:cdea:424a%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 19:57:03 +0000
Message-ID: <8f3d011a-457f-a104-e7a8-4a3e430acd5e@oracle.com>
Date: Mon, 17 Jul 2023 12:56:58 -0700
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
 <88be4f76-f03d-fd50-8eaf-c6f7f7d31810@oracle.com>
 <CAJaqyWd-Zbe3dSo_biV7z_gQ=stk738B1qS6R8cnoz2RR_awHg@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWd-Zbe3dSo_biV7z_gQ=stk738B1qS6R8cnoz2RR_awHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::16) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: fe81c707-dd66-4d76-eb83-08db86fffd75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uuigqdQAFd12lUh0HTVrLocIOvnNfX2P95DpzmEKS/SPhzyxNTXi6bTpT8Oqj/0zkP24wiq4tj2X2ASqVGiJcZgc5SHnnN3DXS8QGif0m/Hv+jg8kpf6M8YlQThqMDBkVZfdd9GRBKJJPHwt74ADlMHjJAIrf8ZnUGvmw3JC/HmdPKO6BKe7o2qdCfDjHF1zzg8MJm8td1pCC9wsy51obD0PRCm4VB8cZ3IksXc88/q33ET2y0Gra6v/5WLkjgPNYIC3HqadPYgePMmzg2uQG8eO1R+NTpvoyUR1MMpgDeuI/GUpD74WkvJnPm8O9Gccix0sQHYe+Mx1c1iXpI0b2BYwhMR1M4Wf2nrhpagy8iyQKZJSaz2+zt9uubxWKcaDk8G6m/5W3VAK2EJ3pIpn8rKsi8+JBvQfExGQjweEv+mfwvWIhALs/RAUS80NW3n5lJ2YRFZXnOzfgqrZVspY7PX8My9gx0l5BOJ6bllocLOuC3tZhbmV7B7X0wseqgaYKUpCxQzlkbmox3cdVtkaoLf162xIM9m3kxedSpWpGLLQjaJkjsUsQ+9nd/uOGzeOwLXxOXfGz4y7tMnQCMgtEJDxGWSntDXTKXA7mhc5IoElqTljRYe+YT35qY+baRYaAfYqP+UT7DvmY88Ct3uC0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199021)(31686004)(66899021)(478600001)(36916002)(6486002)(6666004)(54906003)(83380400001)(31696002)(86362001)(2906002)(30864003)(53546011)(36756003)(186003)(6506007)(2616005)(966005)(316002)(6512007)(66556008)(38100700002)(26005)(6916009)(41300700001)(66946007)(66476007)(4326008)(8936002)(8676002)(5660300002)(7416002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0dXVk5TbjZYOFQwVFY2QTRmQnV6TTRYYkVjSW1GSTBDOWZ5alY5dUYrKzcv?=
 =?utf-8?B?OERBbGxZOVdGQU5HMWNnb0x2alJEUm53SUxsRGJzZHJyY2hGK0xURDUwY3Q0?=
 =?utf-8?B?K2Z2RmQ4V0ZjQmNEWjNFTHRmbXZCc0F4NmRBWmtwRXpyaG1OeHMxaUZhMmRE?=
 =?utf-8?B?K1pkeHVDdkxuNEc5MXhHekZRU296TDF4SUJnOWlNZzUvMmRqZDhQM1JQdnNN?=
 =?utf-8?B?RjI1NGVpYWxaY3Rta2krYzNneXVTTjA5N1A1Z1Z3RGNhNnRpZUpIMWRYOGlN?=
 =?utf-8?B?YzAwQjRlMVNlczEydnRVVkJVcmpkczMxR1pEMnQreHdhbHVIUDRsVENWc2Yy?=
 =?utf-8?B?eVF1cUMxOU5BaFg0RkxKcHphREN3Y1M5KzloS1NaRmJxZDI1MGZnQ0VKSDFR?=
 =?utf-8?B?K0pRVGtOUW9lM1NTdE54U3FaS2VCamptclZGYjZNVDVEWXpXbDJBcC92K29j?=
 =?utf-8?B?WEY4NTdMeVFnUndkaWtVYVY1SlRzWUR3N0JSa28rR2pEajIzQjMwMzJKR0ty?=
 =?utf-8?B?WTZWQ1U2bDVNT2tzaXczRVN1c3N2dE5qdFBKa2FyZk0wSzJYMU5oVGJqT1hC?=
 =?utf-8?B?Q3dwamdvVXo3bXQ4RWxLTHJJckdwN3ZvNjBoZkFMZlpyTFBaMFBxZjFXbE8x?=
 =?utf-8?B?L2p2Vlo4YU1qUlRWNytaeWo4OE85KyszVmdmeFQzMmM5b00ranNqN0NBZVBN?=
 =?utf-8?B?Z01VRy9nbGROZlg5cmpYcys3UnBmYUNROHRkbGNzNzhiWDdiZHAzTUF0YkE1?=
 =?utf-8?B?UlhWUmdpUi9vV2RhMTIxdmppbmFxTkVkRVNucDlETmxGSGlNNWdVcElPelF3?=
 =?utf-8?B?ajNpVEJUeUNmNUdEUGtTblNNV3ZLT01haSsvNldKL3FDd3EvT0NmaG13K0dY?=
 =?utf-8?B?NDBDcWhnMFpjdnVBTEFlS2JFdXZ2eGZkblZmZmoyL2ZYOUxPNE1WTDZVTVBw?=
 =?utf-8?B?WnpXaE14bkRaYjl4bWwzMFZZekt1Tm5yWEh1M2FPQ0lRMHB6bUpGNklHYTUx?=
 =?utf-8?B?Ri9oOWtFNmxEMXgvVDBZTW55U3FQLzNIM3hEYnFoVS9hT1I4STFLWUJXRGZ5?=
 =?utf-8?B?OWxQbXRPbWF4WkZvR0tnN3l6M2tzQ1hpbmZQSkNZai9JcmQxdGlFQ2xzYmlL?=
 =?utf-8?B?VDJrWGx3cGNPVG05R2pEQk44MzNEVHRkNEtMZHZvWUUzTWdIdkc1dlZUcVJQ?=
 =?utf-8?B?ZDIrTW1ZZzk4TEIyUmpmSWY1RGFCZkV0b21McGlWWVc1N3k3bkpacXpoSzly?=
 =?utf-8?B?M1lyeUtEYUZPcDRGb3BvZGpMVjBHSjRGUEhsdWloSU5ldXQ0MHM0cVpiaWEr?=
 =?utf-8?B?Q1dyNVM5MnZZcjNBdS9KK2FNbWhuT2JUUHZGK2duRTJsMEhpb3puZ2dFUTc2?=
 =?utf-8?B?WTlmM1JtcHM2cklhbFJDQjJhZnhRUUg5TjF1QWU3eGgvNTk3WEJqZlVxVGRl?=
 =?utf-8?B?YlNNQXRkcndzQ3BDaHZvRWU0SC9URjgyMTR4R0t6MllHZ3V0bXdNQlMzcXZG?=
 =?utf-8?B?UlJjcDNjUmp6Q3o1S0hiNm5ZVUd3TjRnMGdmN200K3lkUTBoSHFjQmIrT3Ju?=
 =?utf-8?B?U2s0R1JyWFFucTFjOGNRWGNTdG1nYkRzRUtZbWU1OFV0RkdhWHRkQ3FaSWg2?=
 =?utf-8?B?d2xWVHVXVkdLa0RwZ3BkSzJ0K2JWUVRWU1NNRmMxZm94VUdTamkzU2pUTVp4?=
 =?utf-8?B?RTFITkNYelJGVG5yN3ZQUXpRc2oyOHkxaklHT0xVcnVTdUk5TUYwNHZCUXNR?=
 =?utf-8?B?eDdiUk9lOGMyYUhxbUpqSllzR1piS1BhcTBNMUhic2J4Yjg0Szd6czlGY2lT?=
 =?utf-8?B?V2pFUUo3a2tHNHd1UGtJYWJaQTYrK3AwYjZHLzRhd0c3V3YrMHp3R0RFVEhN?=
 =?utf-8?B?VTZsWmM0SmdmZzZzcnVvQ3hoMm4vT3J0NEpGNWJWbDl2MTdKaU9DSUNhM0Uw?=
 =?utf-8?B?ZThOZjJLOWpDTytpRi8rS0U1aTBzZkN6bnI0dnZEMTVJOVcrRElDaWxiSWZO?=
 =?utf-8?B?QkcvNkRyc2syaVBndDlreDZJQ2srUXhRUElPcnRFbnMyamswaWhlcitBMXh2?=
 =?utf-8?B?TnFTSklCbEdUelhGTzlxd1M4cllYNXZPVW5MdWlYd2grNWs5SjF4cjFFVk1m?=
 =?utf-8?Q?ah23Pwkk6JdSaAQ7PKgYcw1gm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: x6hj19xuKiI+Ci4gCGTe97+oje86Ns7MdIG0FIhKFUlUo2QFl6lkj1E4eVDcYao0ql5CL5fJMoHSHngTxIf3DSO/gDShdFSbbnFbnta53Li9GV28h6oYAK+COIPxWOeCNItQKKkHjozO3hBIoSysnp5QSzHu9gQNfQMZ7HrMPIspC6DNIAc1MioT4J9kRdDgQE1cyVzI4o0Lm/LNoChwxTuQmNzcVz/4queI3P4S+rlzi7epOElxnoQZOXmWD9YXU2vofX4p5ep63r7pKkKP2+RrRduSQsOAoUSFlcTWV9rupD/9UaHe/6KpOsAHCAj1J0kPF6ABps78v+iLXf13G8uCRWYI/KEjnofnv2N1VI2XG422BCMgz7G7TpKOjxEGG9E6nKRowB+2zDWkdzVpwFdh0LV7Lu6+3Eo1IUoywIH/wQOk9UBqCd1H+cVnLvSwL8uoOhQ9Scs+jgy+ENeru7MQrR+n148PGI7qiU+L/aLjVPOOPA6Kgj8vUx4vQRaAVEhP4bpJvuHXurw1G3cWN1CsJ/A/Z8ToebGiB4qa2L7AQRD/iB1893G1EK831nfA9/iE8bBmsX3ILTYa2xDPbT6lUG/ZJgRBLT2BXazWIq2oInSl1uXjPDHrLvfBdyfBFFLwbQaP5DMEnJXQxiYCAFZOZm7rn308FO0/TmZoQJx/i5PEsBlU937OSyAz5W8zBlypv/ZxbZT8r6ER9jqKN0wv6Bf5RnjvNCil7kT/RwfBXxJDmqkPT/5BXwe9BS/sUn2CSAtCqttpEBK6y40497byxyE3Kxzc3PmeYalYcvaEVtIe632rBwnAJmBQBxDQGlw49vZ2swSlE17hYIycuw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe81c707-dd66-4d76-eb83-08db86fffd75
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 19:57:03.2695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9GqutpEAGGpTHGypojCmD91DlKMQK24mBWsx+QWoVG8XE5JiLD/ogJLSJJm8lH8iDoEqBciZDa45BBUW162MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_13,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307170181
X-Proofpoint-GUID: VGtlZZ9dHq5Rqm4O9qQW1-NsPUEnkCYv
X-Proofpoint-ORIG-GUID: VGtlZZ9dHq5Rqm4O9qQW1-NsPUEnkCYv
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

Hey,

I am now back from the break. Sorry for the delayed response, please see 
in line.

On 7/9/2023 11:04 PM, Eugenio Perez Martin wrote:
> On Sat, Jul 8, 2023 at 11:14 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 7/5/2023 10:46 PM, Eugenio Perez Martin wrote:
>>> On Thu, Jul 6, 2023 at 2:13 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 7/5/2023 11:03 AM, Eugenio Perez Martin wrote:
>>>>> On Tue, Jun 27, 2023 at 8:36 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> On 6/9/2023 7:32 AM, Eugenio Perez Martin wrote:
>>>>>>> On Fri, Jun 9, 2023 at 12:39 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>> On 6/7/23 01:08, Eugenio Perez Martin wrote:
>>>>>>>>> On Wed, Jun 7, 2023 at 12:43 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>>>> Sorry for reviving this old thread, I lost the best timing to follow up
>>>>>>>>>> on this while I was on vacation. I have been working on this and found
>>>>>>>>>> out some discrepancy, please see below.
>>>>>>>>>>
>>>>>>>>>> On 4/5/23 04:37, Eugenio Perez Martin wrote:
>>>>>>>>>>> Hi!
>>>>>>>>>>>
>>>>>>>>>>> As mentioned in the last upstream virtio-networking meeting, one of
>>>>>>>>>>> the factors that adds more downtime to migration is the handling of
>>>>>>>>>>> the guest memory (pin, map, etc). At this moment this handling is
>>>>>>>>>>> bound to the virtio life cycle (DRIVER_OK, RESET). In that sense, the
>>>>>>>>>>> destination device waits until all the guest memory / state is
>>>>>>>>>>> migrated to start pinning all the memory.
>>>>>>>>>>>
>>>>>>>>>>> The proposal is to bind it to the char device life cycle (open vs
>>>>>>>>>>> close),
>>>>>>>>>> Hmmm, really? If it's the life cycle for char device, the next guest /
>>>>>>>>>> qemu launch on the same vhost-vdpa device node won't make it work.
>>>>>>>>>>
>>>>>>>>> Maybe my sentence was not accurate, but I think we're on the same page here.
>>>>>>>>>
>>>>>>>>> Two qemu instances opening the same char device at the same time are
>>>>>>>>> not allowed, and vhost_vdpa_release clean all the maps. So the next
>>>>>>>>> qemu that opens the char device should see a clean device anyway.
>>>>>>>> I mean the pin can't be done at the time of char device open, where the
>>>>>>>> user address space is not known/bound yet. The earliest point possible
>>>>>>>> for pinning would be until the vhost_attach_mm() call from SET_OWNER is
>>>>>>>> done.
>>>>>>> Maybe we are deviating, let me start again.
>>>>>>>
>>>>>>> Using QEMU code, what I'm proposing is to modify the lifecycle of the
>>>>>>> .listener member of struct vhost_vdpa.
>>>>>>>
>>>>>>> At this moment, the memory listener is registered at
>>>>>>> vhost_vdpa_dev_start(dev, started=true) call for the last vhost_dev,
>>>>>>> and is unregistered in both vhost_vdpa_reset_status and
>>>>>>> vhost_vdpa_cleanup.
>>>>>>>
>>>>>>> My original proposal was just to move the memory listener registration
>>>>>>> to the last vhost_vdpa_init, and remove the unregister from
>>>>>>> vhost_vdpa_reset_status. The calls to vhost_vdpa_dma_map/unmap would
>>>>>>> be the same, the device should not realize this change.
>>>>>> This can address LM downtime latency for sure, but it won't help
>>>>>> downtime during dynamic SVQ switch - which still needs to go through the
>>>>>> full unmap/map cycle (that includes the slow part for pinning) from
>>>>>> passthrough to SVQ mode. Be noted not every device could work with a
>>>>>> separate ASID for SVQ descriptors. The fix should expect to work on
>>>>>> normal vDPA vendor devices without a separate descriptor ASID, with
>>>>>> platform IOMMU underneath or with on-chip IOMMU.
>>>>>>
>>>>> At this moment the SVQ switch is very inefficient mapping-wise, as it
>>>>> unmap all the GPA->HVA maps and overrides it. In particular, SVQ is
>>>>> allocated in low regions of the iova space, and then the guest memory
>>>>> is allocated in this new IOVA region incrementally.
>>>> Yep. The key to build this fast path for SVQ switching I think is to
>>>> maintain the identity mapping for the passthrough queues so that QEMU
>>>> can reuse the old mappings for guest memory (e.g. GIOVA identity mapped
>>>> to GPA) while incrementally adding new mappings for SVQ vrings.
>>>>
>>>>> We can optimize that if we place SVQ in a free GPA area instead.
>>>> Here's a question though: it might not be hard to find a free GPA range
>>>> for the non-vIOMMU case (allocate iova from beyond the 48bit or 52bit
>>>> ranges), but I'm not sure if easy to find a free GIOVA range for the
>>>> vIOMMU case - particularly this has to work in the same entire 64bit
>>>> IOVA address ranges that (for now) QEMU won't be able to "reserve" a
>>>> specific IOVA ranges for SVQ from the vIOMMU. Do you foresee this can be
>>>> done for every QEMU emulated vIOMMU (intel-iommu amd-iommu, arm smmu and
>>>> virito-iommu) so that we can call it out as a generic means for SVQ
>>>> switching optimization?
>>>>
>>> In the case vIOMMU allocates a new block we will use the same algorithm as now:
>>> * Find a new free IOVA chunk of the same size
>>> * Map this new SVQ IOVA, that may or may not be the same as SVQ
>>>
>>> Since we must go through the translation phase to sanitize guest's
>>> available descriptors anyway, it has zero added cost.
>> Not sure I followed, this can work but doesn't seem able to reuse the
>> old host kernel mappings for guest memory, hence still requires remap of
>> the entire host IOVA ranges when SVQ IOVA comes along. I think by
>> maintaining 1:1 identity map on guest memory, we don't have to bother
>> tearing down existing HVA->HPA mappings in kernel thus save the
>> expensive pinning calls at large. I don't clearly see under this scheme,
>> how the new SVQ IOVA may work with potential conflict on IOVA space from
>> hotplugged memory - in this case the 1:1 IOVA->GPA identity guest memory
>> mapping can't be kept.
>>
> There is no need to maintain the 1:1 for memory mapped after the
> pinning. The bigger reason to maintain them is to reduce the downtime
> because of pinning.
Yes, if guest users don't care about SVQ switching downtime there's no 
need to maintain 1:1, and SVQ translation like today should work for 
them. However most live migration users who care about downtime during 
live migration also care about the downtime for SVQ switching - you 
don't want to say that brownout time like 300ms or so in the mid of live 
migration at the cost of complete service loss of 4 to 5 seconds at the 
start of migration is a win to them. What I said above has the 
presumption that we both are looking at (the possibility of) a 
generic/software way to optimize/reduce pinning overhead on the downtime 
- say what can be done at QEMU level or host kernel to avoid pinning (at 
SVQ switch) rather than put burden on every hardware vendor to implement 
a separate ASID for SVQ.

> After that, we can reuse the method we're using at
> this moment, looking for a new free hole for the new map. ew only need
> to pin the new map.
Consider this sequence:
- initially host device uses original GPA for guest memory mapping
- live migration starts off, QEMU's iova tree maps guest memory GPA 1:1 
to IOVA
- SVQ new maps allocated from a free hole on iova tree that happen to 
fall just above the IOVA range for guest memory GPA
- new memory hot plugged to guest while migration is still going on in 
source host. although this hot plugged memory region sits right above 
the guest memory blocks in guest memory space (GPA), it will get new map 
in a separate range (not 1:1 mapped to GPA any more!) from the QEMU iova 
tree. Since QEMU mediates and translates virtqueue access to memory via 
SVQ (all guest memory maps to the same IOVA for SVQ), so far so good
- for some reason live migration fails before VM is able to be migrated 
to the destination host, VM has to resume from the source host immediately
- since live migration had failed, QEMU will unmap SVQ vrings from the 
IOVA tree and then stop shadowing virtqueue access
- the host vDPA device now has incorrect passthrough GPA mapping for the 
part of newly plugged guest memory, as that belongs to the IOVA range 
where SVQ translation is in use

Although it might not be easy for SVQ vrings and plugged memory to 
collide on the same GPA/IOVA range, this is something we should prevent 
from happening in the first place I'd assume. You can say we only look 
from higher IOVA ranges to map SVQ so that the lower range can be 
reserved for latent hot plug memory, but this still needs complicated 
implementation to deal with IOVA range fragmentation and special 
collision prevention from breaking the 1:1 map to guest memory space.

Regards,
-Siwei

>
>>> Another option would be to move the SVQ vring to a new region, but I
>>> don't see any advantage on maintaining 1:1 mapping at that point.
>> See above. For pinning avoidance point of view (i.e. QEMU software
>> optimization on SVQ switching downtime), I think it's crucial to
>> maintain 1:1 mapping and move SVQ vring to a specific region. But I'm
>> not sure how complex it will be for QEMU to get it implemented in a
>> clean way.
>>
>> Thanks,
>> -Siwei
>>
>>>> If this QEMU/vIOMMU "hack" is not universally feasible, I would rather
>>>> build a fast path in the kernel via a new vhost IOTLB command, say
>>>> INVALIDATE_AND_UPDATE_ALL, to atomically flush all existing
>>>> (passthrough) mappings and update to use the SVQ ones in a single batch,
>>>> while keeping the pages for guest memory always pinned (the kernel will
>>>> make this decision). This doesn't expose pinning to userspace, and can
>>>> also fix downtime issue.
>>>>
>>>>>     All
>>>>> of the "translations" still need to be done, to ensure the guest
>>>>> doesn't have access to SVQ vring. That way, qemu will not send all the
>>>>> unmaps & maps, only the new ones. And vhost/vdpa does not need to call
>>>>> unpin_user_page / pin_user_pages for all the guest memory.
>>>>>
>>>>> More optimizations include the batching of the SVQ vrings.
>>>> Nods.
>>>>
>>>>>>> One of the concerns was that it could delay VM initialization, and I
>>>>>>> didn't profile it but I think that may be the case.
>>>>>> Yes, that's the concern here - we should not introduce regression to
>>>>>> normal VM boot process/time. In case of large VM it's very easy to see
>>>>>> the side effect if we go this way.
>>>>>>
>>>>>>>      I'm not sure about
>>>>>>> the right fix but I think the change is easy to profile. If that is
>>>>>>> the case, we could:
>>>>>>> * use a flag (listener->address_space ?) and only register the
>>>>>>> listener in _init if waiting for a migration, do it in _start
>>>>>>> otherwise.
>>>>>> Just doing this alone won't help SVQ mode switch downtime, see the
>>>>>> reason stated above.
>>>>>>
>>>>>>> * something like io_uring, where the map can be done in parallel and
>>>>>>> we can fail _start if some of them fails.
>>>>>> This can alleviate the problem somehow, but still sub-optimal and not
>>>>>> scalable with larger size. I'd like zero or least pinning to be done at
>>>>>> the SVQ switch or migration time.
>>>>>>
>>>>> To reduce even further the pinning at SVQ time we would need to
>>>>> preallocate SVQ vrings before suspending the device.
>>>> Yep. Preallocate SVQ vrings at the start of migration, but before
>>>> suspending the device. This will work under the assumption that we can
>>>> reserve or "steal" some ranges from the GPA or GIOVA space...
>>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>>>>>> Actually I think the counterpart vhost_detach_mm() only gets
>>>>>>>> handled in vhost_vdpa_release() at device close time is a resulting
>>>>>>>> artifact and amiss of today's vhost protocol - the opposite RESET_OWNER
>>>>>>>> call is not made mandatory hence only seen implemented in vhost-net
>>>>>>>> device today. One qemu instance could well exec(3) another new qemu
>>>>>>>> instance to live upgrade itself while keeping all emulated devices and
>>>>>>>> guest alive. The current vhost design simply prohibits this from happening.
>>>>>>>>
>>>>>>> Ok, I was not aware of this. Thanks for explaining it!
>>>>>>>
>>>>>>>>>>>        so all the guest memory can be pinned for all the guest / qemu
>>>>>>>>>>> lifecycle.
>>>>>>>>>> I think to tie pinning to guest / qemu process life cycle makes more
>>>>>>>>>> sense. Essentially this pinning part needs to be decoupled from the
>>>>>>>>>> iotlb mapping abstraction layer, and can / should work as a standalone
>>>>>>>>>> uAPI. Such that QEMU at the destination may launch and pin all guest's
>>>>>>>>>> memory as needed without having to start the device, while awaiting any
>>>>>>>>>> incoming migration request. Though problem is, there's no existing vhost
>>>>>>>>>> uAPI that could properly serve as the vehicle for that. SET_OWNER /
>>>>>>>>>> SET_MEM_TABLE / RESET_OWNER seems a remote fit.. Any objection against
>>>>>>>>>> introducing a new but clean vhost uAPI for pinning guest pages, subject
>>>>>>>>>> to guest's life cycle?
>>>>>>>>>>
>>>>>>>>> I think that to pin or not pin memory maps should be a kernel
>>>>>>>>> decision, not to be driven by qemu.
>>>>>>>> It's kernel decision for sure. I am with this part.
>>>>>>>>
>>>>>>>>> I'm not against it if needed, but
>>>>>>>>> let me know if the current "clean at close" address your concerns.
>>>>>>>> To better facilitate QEMU exec (live update) case, I propose we add new
>>>>>>>> vhost uAPI pair for explicit pinning request - which would live with
>>>>>>>> user mm's, or more precisely qemu instance's lifecycle.
>>>>>>>>
>>>>>>> Ok I see your problem better now, but I think it should be solved at
>>>>>>> kernel level. Does that live update need to forcefully unpin and pin
>>>>>>> the memory again,
>>>>>> No, it should avoid the unpin&pin cycle, otherwise it'd defeat the
>>>>>> downtime expectation. The exec(3)'d process should inherit the page
>>>>>> pinning and/or mlock accounting from the original QEMU process, while
>>>>>> keeping original page pinning intact. Physical page mappings for DMA can
>>>>>> be kept as is to avoid the need of reprogramming device, though in this
>>>>>> case the existing vhost iotlb entries should be updated to reflect the
>>>>>> new HVA in the exec(3)'d QEMU process.
>>>>>>
>>>>>>>      or that is just a consequence of how it works the
>>>>>>> memory listener right now?
>>>>>>>
>>>>>>> Why not extend the RESET_OWNER to the rest of devices? It seems the
>>>>>>> most natural way to me.
>>>>>> Not sure, I think RESET_OWNER might be too heavy weighted to implement
>>>>>> live update, and people are not clear what the exact semantics are by
>>>>>> using it (which part of the device state is being reset, and how
>>>>>> much)... In addition, people working on iommufd intended to make this a
>>>>>> "one-shot" ioctl e.g. CHANGE_OWNER instead of RESET_OWNER+SET_OWNER:
>>>>>>
>>>>>> https://lore.kernel.org/kvm/Y5Ibvv9PNMifi0NF@ziepe.ca/
>>>>>>
>>>>>> New uAPI to just change ownership of mm seems a better fit to me...
>>>>>>
>>>>> I'm not sure about the right solution here, but there are other
>>>>> proposals to batch ioctls. But maybe creating a new one fits better.
>>>>>
>>>>> Thanks!
>>>>>
>>>>>> Thanks,
>>>>>> -Siwei
>>>>>>
>>>>>>> Thanks!
>>>>>>>
>>>>>>>
>>>>>>>>>> Another concern is the use_va stuff, originally it tags to the device
>>>>>>>>>> level and is made static at the time of device instantiation, which is
>>>>>>>>>> fine. But others to come just find a new home at per-group level or
>>>>>>>>>> per-vq level struct. Hard to tell whether or not pinning is actually
>>>>>>>>>> needed for the latter use_va friends, as they are essentially tied to
>>>>>>>>>> the virtio life cycle or feature negotiation. While guest / Qemu starts
>>>>>>>>>> way earlier than that. Perhaps just ignore those sub-device level use_va
>>>>>>>>>> usages? Presumably !use_va at the device level is sufficient to infer
>>>>>>>>>> the need of pinning for device?
>>>>>>>>>>
>>>>>>>>> I don't follow this. But I have the feeling that the subject of my
>>>>>>>>> original mail is way more accurate if I would have said just "memory
>>>>>>>>> maps".
>>>>>>>> I think the iotlb layer in vhost-vdpa just provides the abstraction for
>>>>>>>> mapping, not pinning. Although in some case mapping implicitly relies on
>>>>>>>> pinning for DMA purpose, it doesn't have to tie to that in uAPI
>>>>>>>> semantics. We can do explicit on-demand pinning for cases for e.g.
>>>>>>>> warming up device at live migration destination.
>>>>>>>>
>>>>>>>>
>>>>>>>>> I still consider the way to fix it is to actually delegate that to the
>>>>>>>>> kernel vdpa, so it can choose if a particular ASID needs the pin or
>>>>>>>>> not. But let me know if I missed something.
>>>>>>>> You can disregard this for now. I will discuss that further with you
>>>>>>>> guys while bind_mm and per-group use_va stuffs are landed.
>>>>>>>>
>>>>>>>> Thanks!
>>>>>>>> -Siwei
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>> Thanks!
>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>> -Siwei
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> This has two main problems:
>>>>>>>>>>> * At this moment the reset semantics forces the vdpa device to unmap
>>>>>>>>>>> all the memory. So this change needs a vhost vdpa feature flag.
>>>>>>>>>>> * This may increase the initialization time. Maybe we can delay it if
>>>>>>>>>>> qemu is not the destination of a LM. Anyway I think this should be
>>>>>>>>>>> done as an optimization on top.
>>>>>>>>>>>
>>>>>>>>>>> Any ideas or comments in this regard?
>>>>>>>>>>>
>>>>>>>>>>> Thanks!
>>>>>>>>>>>


