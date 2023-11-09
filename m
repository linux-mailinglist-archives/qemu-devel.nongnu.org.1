Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 253A77E6A69
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:19:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13yy-0005nz-Fd; Thu, 09 Nov 2023 07:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1r13yr-0005n1-BP
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:17:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1r13yo-00067T-UP
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:17:53 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A91iE56020370; Thu, 9 Nov 2023 12:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=o8murElc2/GJTTx+0aW+xQXCOSqvq9FJ+MNr/Thqpfc=;
 b=Q7A5ngGx6tEEg295JBhFepIBISqbVUBaT1CP/B0RX/rxCEKKKIG+UgslftOsjm4M3a3s
 ZPDsqChlXh+ZoQ0EgSZj9AwQomj8nAtupU6JK8EnCaBobGRvy5e/YW8uO1ByE0gfFjhj
 hUBO4TR3U1z0voPvwXH5JiJ5zgrTAhUYWt63ZINEG1cQ2APh8fXwEtcJjfJiTXXRojST
 WEE/6sUxu0MrA7Jmdfx3jH6ur2dVtJPrVDOYRYM1roe+7qa6ajuFKlOE82aklQd1TBu5
 Iz9gu2Rwke0t+BSztqvbG2656NuOmY+TEuNXmgga3srJfC6epGe+whMWN3pEhQFv9iqu Nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w203tqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Nov 2023 12:17:45 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A9Ax7Al000404; Thu, 9 Nov 2023 12:17:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u7w1xv1r9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Nov 2023 12:17:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJ1Lqh86Qyb3V+ZJyQCSzOI7IoNhNMLanbwBV78O1Ubeie93wcCSXBYdyIyCfk12E8Azcc+vxMKgrWOvC9zsB7cUgp18NnDnyq14Dru8f1Sg7S/keeRGj233PBfOs9/smLAJ3osL7pONu84Zf7EsDSv/8VCs43YzjwcR8QxBVEPVQaXyVObazAfoWLQMgXOgkBc3bKRuTUnWN4SMEBWbakzuupKXQVcU4ZnFxKy8xZnmyB8BnfEK/Gn2HB9TjfCAwkpcwmFksi9D9Ym9Txml2WDNi17WrpmkQym8pHFKlrFrjmgJTIZK/bJb47Trh3kZNrSt5JzJev1abaRcm7Oa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8murElc2/GJTTx+0aW+xQXCOSqvq9FJ+MNr/Thqpfc=;
 b=e8IGw7Pvfko8fKGDmVjjs7hsY00uGN4TT9F6+dyaCESleV6HgM6mtwE/dFbE7IyiYrNAj0rznUaDRemji9bfVf9aIvGgBQgx58ZrzYyqHKWFouxbfl887BetTSpYKO6nPE5ouUScVOJgWLc3o0Tw4jTQt5O0FuRQZqGHtwnK91LNWavneHF/AmReh46TQPqnDKdbZp7hDmEXGR/spYuPGX9jGvYuhEyD4MHmyUFncHO78tjtWKWbbScd+EFg7tCCwvP0tRm4m0gSCMwG9NCnIBeYiAeE9eKbqFBFYr3gYU1j3M3fynV4NAilCt8rgMXQMDBgltcLIgkpjGX9BfWW4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8murElc2/GJTTx+0aW+xQXCOSqvq9FJ+MNr/Thqpfc=;
 b=jkMkteOXfQSsEIAv/KoXwLW+lF+nfQRzVtiFhOJ/s3CnL0JxznCMxhFO5FUIix56bJbWPwukEd7Fo840hjtyyC/tR8BNLV41xW0oh2rbrvgyzOpqHOUcK+zAQM7F8MMs2XiycmwzxHAu3tlE7xWGX1l7MLC5jij1y8ADnVHNRgQ=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SJ2PR10MB7827.namprd10.prod.outlook.com (2603:10b6:a03:568::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 12:17:41 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 12:17:41 +0000
Message-ID: <b6f22a3a-84cc-44ab-947b-b7e12656fe87@oracle.com>
Date: Thu, 9 Nov 2023 12:17:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-29-zhenzhong.duan@intel.com>
 <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
 <SJ0PR11MB6744D87FD3CBB3380647E68792A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231108124817.GS4488@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20231108124817.GS4488@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0027.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::17) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SJ2PR10MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 05492834-def8-4467-9986-08dbe11ddf03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZreZOU4Z1VdTpLvlcS94MeWNJlXZDDqn0kmIXCgISbDFru74kvz0s8jhsUwdVLmew12uMgy7hUWEpOj1l8SFJq0yj2Anx49UgTjx3vdVQYnHrClJ4QYgObCpS6gaAjS/ssTlL3gBcE253YyWZZzGMTeH/NytjmeCPkJ5vE+ebBnPsk8UOlOxUg0D6bVJd/bxpGtRb0FsvH8CjfWgZBRBTlsYszn9oWobJvSzAhYYQYprYU9ImrnzZ5vAY5YD1t/+FkBoiQ4kK+NBGuWbx0Eoqs/tTh/aXTk11lZAuOdbqCV767bvJeKFaoEVW7dwhDjlH3s2esP2Lxc1CxMn0/yd/802LllsxrRZJrVESZU3qrOYmwe0EMn3WKTTaYQ8R+P46kEqzMxnUzJLZePtCr0jShiFkxwLQbB0IAWLN1g4Yk8DXXG0kV0Fug4AIVE24bS94qdqZqUhRX63w4zKBrQcS5BGdhxZo14WzA8+zLSIH6FaI3zIhdspQxlnZpEQyvZzyW/Cuouk2uBvhxAq60iJOzMm8vWSuJ8+ukf2my9ZKBKSh5WGP0JofWvCscQdg4pV1JcMTWFjq0wjjibN7617cs74hoEQqkGjrEQxlJ239bPxORPnLkg5E49292+xJqFAlMHClo9U6oyrskEfN9jGnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(396003)(376002)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2906002)(41300700001)(66556008)(316002)(54906003)(478600001)(66476007)(8936002)(66946007)(5660300002)(4326008)(8676002)(38100700002)(36756003)(86362001)(110136005)(31686004)(7416002)(31696002)(6486002)(83380400001)(53546011)(6506007)(2616005)(6666004)(26005)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0taZTVkNGdMZzVnYTZ0ZEFvek0yeW9pMjZRM0RyZmcxOXd3TzMyWFFrUytW?=
 =?utf-8?B?cmpieGpVR25CTm5NU2svcC83QnpGNDZhRC9YSGlRMjdKM2FsTVd5MExmUnBh?=
 =?utf-8?B?Y3NrWUtKVXRaRy9reERnakViOXBhUktlQVE1R1hkWEFuSCtDSkJtSzAxWmpo?=
 =?utf-8?B?MUJvWFg0UkNubi9CSE1FdnpMRVF6TzU5dVNqUkNEcytFNERUbVVXR3lQajRr?=
 =?utf-8?B?VlZRQ3pORFBQcDlNdkU1MTZ0WTMyT3NtSGFLV1E5a1ZnN0FHbExnVkUzM0Ey?=
 =?utf-8?B?S0U3UnNWSlZraFFGWHFHTkZVdlYwMXoyOEIwUXBONkRuWGp3aExtWmVKZHA4?=
 =?utf-8?B?em9nQThjbWh0SXVIMGdhQWFHaHRqcVVQMnpNRXVTM3lwQ3RLOUR5UmtUVEls?=
 =?utf-8?B?RzNTcnF4WHZHcFRNcXRTVmU5YVBrWm0wTTRaMUpDM1lZaW5vMmdPdEVERUp4?=
 =?utf-8?B?RjkzTWhDTEFUaGR5MzBDZHBQTDVyOWFvamUrbnJzMDlMeHdoQlB5YTZ2OWtm?=
 =?utf-8?B?TXdZYXI2aFRXdzEyRDdsZmdHeE9IK0NaUjVOallHNlE3ZTM2WktpWm9PUG94?=
 =?utf-8?B?dHRWdmhZYURTZXBVOXZ2R2xaR2tWMURtL2tIWkJObFBBeXpnN29QT3E3bm90?=
 =?utf-8?B?dm5RWXFyU3Z3K1dreWM3NlJURkNDMXp5TFNBdjRxb2F2eVFPRnBXb3dQdmlo?=
 =?utf-8?B?R1VGa01zUGR2TFk0a0dWV3JKWHJzTllVdDRTbHhXczkzS1pnVWlMUGdBbmlz?=
 =?utf-8?B?Ui9LZVVXMkZCYzErVFh1Tk56YnVDak5wd3VwZEJZcHVtcTFlYmt4OUFPdmlU?=
 =?utf-8?B?REhNdFlaQjFCajZnM2p2dncvejBKZ0dCOGlaclBYS2hGY21mWllsbUJNcVlW?=
 =?utf-8?B?RGExMGJrNDZYYlNwdlZvREFaOVlDbGUyVlJwY3Q3bFFPYm5EYVlJUFhyby9L?=
 =?utf-8?B?U3Z1ZGk0aDFseGdMcHErOEJWN3lhbjdmVUlVRUtHaElVN3h6dkhYeGtGLzFm?=
 =?utf-8?B?UTVJcnBSdjhPNGJhUnhvNHc1ZjhoOVJuZVFEbEh5bFRsUG5zMzZNdG54Qjdw?=
 =?utf-8?B?MmRweTR2VnpZQzIwKzBvTytiLy9zZ1d3UzNEeVhDRVdaTXBVRkxXc3FDT216?=
 =?utf-8?B?eXlYdmZZanpudEp5bXNtOWh3TVpvZWRwQ3hPL2pUNUdQQk92SVhDMnZQL3dJ?=
 =?utf-8?B?MmYzTHRQNDFsamxwd1BSL1MzZlMvSTludlBZNCtNYVlXVlhkNTh2b1hwWjU5?=
 =?utf-8?B?TVpKU0UyYkVOZUhkaWVNKzZyVkhVRVYrUUtEVERWeFR4TjltSGJxbEtkMU1n?=
 =?utf-8?B?eGNVaVhMMkd0OGg2dzFpNUdHcmRhcFE2bi9sZlFJdkVnc3Z0UGsyMWFkQ3Zt?=
 =?utf-8?B?alEvdE9PZnR5Wm83cGpJVjRDOWdrYVFveTk2c0V3cERBZWIzeER0RE0vN3Q3?=
 =?utf-8?B?UWwySGk1c1dHRi9Db3pmZUtnOW1RQ2F4VmZxTTNJSTN6UG9FNkJxTFFha2w1?=
 =?utf-8?B?NTdTeHhRdGRUTFYwQkpyOEl3d25vOWlPOFk1ZW9UTU1vMHc4Tm1ZK1NJcGN2?=
 =?utf-8?B?UkJYb1o1RmV1YmdsbkVmVlVZVSsxdFBYTHBFNjJ0NVBCZlFSMHpNNWZGRHdC?=
 =?utf-8?B?M2JoT29oRGFGSzVJQlBzeUNTM0M0dUtaeHVwaytJRDBCQWo3RXFjcEpJL3JW?=
 =?utf-8?B?aThlQmVOUEdiaFAzOWFWY3hiOUVidVNkazFJRnBETFdNcUREa2hmM3htVUd4?=
 =?utf-8?B?U3I2WXFwckFHTHVweERvZU9GcWlRSzBwTTBvRTFaSS9xTm4rT1pxTHc5Rk1U?=
 =?utf-8?B?V0RwTUp4SldjUm94NDlzeVRBUmR3SDhtV01LOFZ2c3c3SWZsV0VNT0EwdDRN?=
 =?utf-8?B?TVprNzVWM0xFT3JTVGwxOFlSMnZtL05NMFplczhOU29EQWNtRERDOE4rNDhG?=
 =?utf-8?B?TUpqY3lSVFV1VEJIQ1NUTnB3MkxmbVd3Sk5iVm13aW1RTGZLRHVqVGgyQk94?=
 =?utf-8?B?VXhoc0hGbld0Vk9DU1p1bFRDSyswcGNEaW9PL09tY1VQVldmZU11N2NpUnp6?=
 =?utf-8?B?R1ZRWnVXcEpjV0xSbkhqVGZhTjBaRHdINDVhRitzd1pLeVhzVkhqT2ZVN1dU?=
 =?utf-8?B?QzAvK0plYkQ5V2RQKzMvTi92SEx1ZGtsazJHRjJYb0toeUhBblVzZkhmUWJH?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: M/mkbZ0qIgSEUHvENQ9Wxz2RkA3cdTmLOn/tAJwa6ndB+r3NXCm2KKZhXJRUV7e3EwXhYRfJgQ2/EqRuYL/QIniqyfiBxNvNkEnU1cvlJKTMkbhDW6oK0AVlAS9MGWY3KyNR7FL8cSLPlwX3clVhkn8W5oK2V62tA4LEIfQugLvlJKUzeNxHCsQ5wyM1o/kDHRGbdE4o5XER3+M/gGNjVLkkQXTufE+W6gzFE6UlyFhCQobxuAm85k0RcPk/mccoJpL5SVEZP/rHpwqEs5D/DPOBUTTLx2CfhUtfH9xCDt8hKt+FdkQ3/GiclPvf0tViW81PDnl88Un1DYvspTAbV5s3/vQdWEm3T6QjUAO+ay6XLvgzd04EJH4UjMXUM64lrz4y59wTVisajwqupku14eMqPNLdwl2t0KKRui2mZr6miDEqXYMJcUlegg9XH3CORFlkzuugaUttG0aHlBET7BrwRhCfzZEKIUQO0WfTYGEX5ImAWR5BZi/eRoJMWO/Y6GQbsxz53IdGtP+ZnnWYK2U3JqcIgs8lRDlwp4lY99iUOxie3pj34qNpG1i0pCeGoPaRZRUl1b1m/u91N+nZGKVfteNd93nBbzC3b6s0i32ut+NED9i9ecQUl5toeyvepVQd7spEnJ03K/COtLu6y8mILujNsf4ZNxKW4hqM+6+GheT7XwKBv5Geh+g+4Yt9GBxD/OxoL3w8njgVJmu+0QYTZuhoJqH8sF87Cj2FLnHNCwcTSOsxo34VPNkxaamHLD1VXojGJE5vT86uhgqKGNasWhYOkYCGYJvdM4T75NFVpMYiMeNXvRe7Cr1qvqEpmvldD/1ypRWmMinuUDftgkdBN9XtWiCZfmmLOV+FHXh2ehM3UDm4dyV84BVzLh1K
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05492834-def8-4467-9986-08dbe11ddf03
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 12:17:41.7036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtFicRhIFNo9wFKsQBssEAKvxY8cwdRov17L6hw8buXLkcclf2md55wh+ZBZsu32Z8rU7ZZT1OjMtJHXdtWxCbHLMsAEJD3P1OJixd2Sca8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090091
X-Proofpoint-ORIG-GUID: 7aHV6Vl6z0qRU9Y5N5CQMLebloXBDwce
X-Proofpoint-GUID: 7aHV6Vl6z0qRU9Y5N5CQMLebloXBDwce
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



On 08/11/2023 12:48, Jason Gunthorpe wrote:
> On Wed, Nov 08, 2023 at 07:16:52AM +0000, Duan, Zhenzhong wrote:
> 
>>>> +    ret = iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>>> +                                     container->ioas_id, &hwpt_id);
>>>> +
>>>> +    if (ret) {
>>>> +        error_setg_errno(errp, errno, "error alloc shadow hwpt");
>>>> +        return ret;
>>>> +    }
>>>
>>> The above alloc_hwpt fails for mdevs (at least, it fails for me attempting to use
>>> iommufd backend with vfio-ccw and vfio-ap on s390).  The ioctl is failing in the
>>> kernel because it can't find an IOMMUFD_OBJ_DEVICE.
>>>
>>> AFAIU that's because the mdevs are meant to instead use kernel access via
>>> vfio_iommufd_emulated_attach_ioas, not hwpt.  That's how mdevs behave when
>>> looking at the kernel vfio compat container.
>>>
>>> As a test, I was able to get vfio-ccw and vfio-ap working using the iommufd
>>> backend by just skipping this alloc_hwpt above and instead passing container-
>>>> ioas_id into the iommufd_cdev_attach_hwpt below.  That triggers the
>>> vfio_iommufd_emulated_attach_ioas call in the kernel.
>>
>> Thanks for help test and investigation.
>> I was only focusing on real device and missed the mdev particularity, sorry.
>> You are right, there is no hwpt support for mdev, not even an emulated hwpt.
>> I'll digging into this and see how to distinguish mdev with real device in
>> this low level function.
> 
> I was expecting that hwpt manipulation would be done exclusively
> inside the device-specific vIOMMU userspace driver. Generic code paths
> that don't have that knowledge should use the IOAS for everything

I am probably late into noticing this given Zhenzhong v5; but arent' we
forgetting the enforcing of dirty tracking in HWPT is done /via/ ALLOC_HWPT ?

We decided sometime ago that the domain_alloc_user flow (and thus enforcement of
dirty tracking) would go via hwpt manip as opposed to the autodomains flow.

Otherwise if I need to ressurect the autodomains support we will need a
ATTACH_IOAS flag replicating this enforcement to pass into the HWPT auto allocation.

Or I can add the hwpt manip on the qemu dirty tracking support of iommufd.

	Joao

