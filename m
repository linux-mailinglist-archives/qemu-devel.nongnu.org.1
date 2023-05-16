Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4FD704995
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:44:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrDK-0001OC-6f; Tue, 16 May 2023 05:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1pyrDH-0001E1-5Y; Tue, 16 May 2023 05:43:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1pyrDE-0007Ex-SF; Tue, 16 May 2023 05:43:22 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34G6StVu006307; Tue, 16 May 2023 09:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Vc7uKAQLj8DyxPbuxya1OboGtMf/tjUI6sm5XP68f0o=;
 b=CNuXejGJwx89BZU0D/VoiiQTnKnwgbYWzOMS9+AA4OraOJskAq2aIX5Sa8w7nyuVQFHq
 CVll6OEjQZeA/lTN+2xYvOMTfem8kt/6VHMRRfttCGTPZ0pp8SstPH8yrKKugOPTftRn
 215urx//1k8bMq+iUYoPzT0RjhXsYYi/TgLt0JSdXcnYcssyzxpapqbvbwIbh0qwQxdc
 hdSFSAavmKk6l3ul0juaJHwEvPNcN2dV9YN0jmpAj2oc261m0x1DrAnW6RLizkhumnZl
 L3wsRgoBmJC+bmvHFJAvTJsr5LbzyW3eWA3hg+hzXL2MpSwNMVDLs8N5sQGsDVZb00kD 8Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc2p04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 09:43:04 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34G8PJEt022018; Tue, 16 May 2023 09:43:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj10a3a4u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 09:43:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bS1eeoPKfXfjNe8tOa0CBJ5nFmyWHDnKF//f5qR06xZckMUvrqq6/myt7cbNunGIi8arJ70PNPnUwT3SqYF1wPYcSxlG6H8L7klphqrzh7yyNJlX7oQL1DnMIR5Hgt7q2MZyDE1vwzNXzY+nX37l3Z3cZe6yGYzALQvwtGHIxXaCN82rIQC5vKu0hEQjU9kk99YX/GweHH/d5YrH7Xi/zLSAkZ8s5O9Vyuw7nwiG40YUmbsDm/zt/KnzhOSms3PhWbfq71F4bADMiwlWXOWCO489NYP9UmxsWYg5+xW1aFwcvoqhIb/x95sgq7ZRuEavW9cZz41RFwFhufB3o4EwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vc7uKAQLj8DyxPbuxya1OboGtMf/tjUI6sm5XP68f0o=;
 b=TxY6Q1RWETQkbWKzqfAMPPzUjKcbhyxEbtPerZsSemSWFZiEObcGzOnZ5iV0DZYpjSPwqZ10yRUrzjMUmkQ81DKa3jqS7iWP42lRZcsUvSH8Lj7aNTVn6+sDVEPkhvQzbbOJIXTxXmsfHSI4VtVLN1+uYiZu0Fhmjehn8qv9qMRUq0Afn+H5ncbw59zkAYxKhDYWF2pZIE7Vp+gRys2cl7USB30XZtrSPEHxJaFtY6FeIRaZoZB5p6x7MsdQ8yOl4d4rOLmAf29XoJDYwEdJ8d2b7Ptsyoyn8AfyGOCkTILQ9D5hweHPHbt0qiIbjr+2sNpiQ+aUE6/8YIHKfNWl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc7uKAQLj8DyxPbuxya1OboGtMf/tjUI6sm5XP68f0o=;
 b=a9GZ1g8NqytUrmIVaeRDHKjcSgUxyNvN8LHFSCAc6MhYIa0GSGCfvEO16/rEDXXz/mTTgWAGf9OlR66YZeWGD4kLtROEhYXP7+DTxJX4mZASS9hSykgRR6rZSf8b/PS9ZVnNJEBiQCoZ2wzI7knnbj72+poIG4hEz/CQjp3DYsI=
Received: from DS7PR10MB4926.namprd10.prod.outlook.com (2603:10b6:5:3ac::20)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 09:43:00 +0000
Received: from DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::738c:b283:c54:57c0]) by DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::738c:b283:c54:57c0%4]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 09:43:00 +0000
From: David Edmondson <david.edmondson@oracle.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, John Snow
 <jsnow@redhat.com>, qemu-ppc@nongnu.org, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-block@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Eric Blake
 <eblake@redhat.com>, Leonardo Bras <leobras@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v2 03/16] migration: Move setup_time to mig_stats
In-Reply-To: <20230515195709.63843-4-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-4-quintela@redhat.com>
Date: Tue, 16 May 2023 10:42:52 +0100
Message-ID: <m27ct84noj.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:208:55::32) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|MW4PR10MB5701:EE_
X-MS-Office365-Filtering-Correlation-Id: 949e4922-ff30-4b0d-2d52-08db55f1efc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E57W0R0nTTZ1h7mVsnCAGEGF2CN6fB4MKe2ofcoppSJgAz7ykOu9NnT7L05lI2oQiuuWzwirdMLnhntaNg0GSIz5gn39rjF5m1su8P7VsEDg7ByNS8MRGCytQ4I/7LIao2FjwskyRCyArc4Q/G1333SJZ3pYsBXruD/sUleIb0+1FFlha4ZoFYNWKnIuV0iKsdQwO8GZyjxGQsGdw3ejpgStUf1PGnYzlCS8VDHfZcaEvd4l9yRSUBi+roQ73VKLoF/OHKpgj3n76Q0JmX60pNwviL612k+H7vd5vytXkz0+gd72WXpYqs2o9QAxGFE4pLWOkaGq04I3d/UIy+IGXL1wwyucwYjcKMI0nmK2Qfp0Lqzsbwv3cf/09sJEL3PZvWaLZ6DcCbHWWpkbYcbrlXIo9lX4xRxIcRuI3MJnHeJ6qwQQ0LIDVbOK4mzBTxJkAYVi+qRIJKH8nntyAwnmH2Xp0ONSdj8dlxtAMJOPoMdZBg5hbNLeflPbxUInxziWhksdJo+1Q7to3AUg7LBif8hS2nRLmw1IDslUP1PrYpCwCRd6zAtVq2Q9fEfG4l9V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB4926.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(86362001)(38100700002)(36756003)(2906002)(6666004)(478600001)(54906003)(6486002)(8676002)(186003)(66556008)(66574015)(8936002)(26005)(6512007)(6506007)(66476007)(2616005)(41300700001)(66946007)(4326008)(44832011)(5660300002)(316002)(7416002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkVpalhmcGFTOUtSd3orMGFFck55Yjl4TUszdXllV0M3eXo5TEJOd1V4Yjhm?=
 =?utf-8?B?aXoyU2tvVE5uMzFpS2NYYmN6dFg3WktvT0o0b1p1ZUtyY3JiUGdJNlNqbUpW?=
 =?utf-8?B?N1FlWExMdVdyd0V4azVCMGJOS3g2MmNkdk16MWwxSDJjZWI2aHJKQStjNHJT?=
 =?utf-8?B?N3B5dmYrOTFjVHlZRVFCWHdqVlJMQlc0TFAwczcyaGxPYmhlOEFDeG9kUEV6?=
 =?utf-8?B?YTNPRVlOMjJMSVZQRytELzdDQWk5blFhSWo2RUVxdkNHaDI5anQ1bDRrT2FI?=
 =?utf-8?B?ejd3WlRrVXdGdWVwUzFNQ003ZVJPRkdzemVzK0F1SUlURVZDelgvSXA5VUJz?=
 =?utf-8?B?NkdJNWMvNWRQMFREbTI4azBvZkg4SFVZd2lZRGR5VFY3UW9ZRkxjbGxMeGcw?=
 =?utf-8?B?VlNtcXZKVUIrM3ViekhhZDlUNlVFRlVZanRtZ0V4cFRFUWJFTG1CSnMxTGY2?=
 =?utf-8?B?MkdjM0diaGR6UkdRZ2M3dElVa0F5aHJ6aUxpQ2ZTN1ZReU9LVnFGRGRudmhw?=
 =?utf-8?B?cjFGK21aVXNUaEVEeW9peENLQUl3OUV2YUFNdUtBMVBlOWpWODRKdGw3NERq?=
 =?utf-8?B?YTIxd2ppektFOGdXemJIckUrMFNaZ1hmTkxxbVpiREYxbDJEYTRMSElVTFo3?=
 =?utf-8?B?M0VFK2ZScXdHYitpSW5OYlp6MWNXMnExL1Fobm1QTDEvZlJYRGp5MTBoT09y?=
 =?utf-8?B?VVQvOWc5UmsybHlacVhYdysvNUFWTllwV3FNMXEzRVNKVmtvTnF3L2diTk52?=
 =?utf-8?B?alY1RTdFQWdSVTV5UzBaNHdCT1d2RjNuOVlCa1luTWU3ZlcwZGNFcTF2SUFB?=
 =?utf-8?B?QStobndsUlBsWHYwdWNIb1NFWFlUdjYxdUF6T1l6anQ0Q214UXg1Z2dJTGF6?=
 =?utf-8?B?QUNqaGZ4aGgzRktnRE1qMkhMWThzdHNGNVRjVzZodGJKMHRra2dpL25sTTJP?=
 =?utf-8?B?OXFvRXhuaGR3cldHVSttQ2w0Y3RnY2ZmN3RqMTNtcmFhcGVSQmV4TUNuNzhQ?=
 =?utf-8?B?S1JXZ2ZnY05kMjVZeDNYbzQxcTkvUi9lbk5LczJrQ01jS0MrRU9lY2l3T2Ja?=
 =?utf-8?B?QVUwSlRqQmRYcy95ZnJoUmpoNUFqTHhhMjBScmVSZ2tEZDRZK3Y5UWVWVzhU?=
 =?utf-8?B?NUhzb2h1ekNpR1hDclZtMmY1QmY5MFVxUzlGRGVnTFhWZUN3SWg3c1FibERa?=
 =?utf-8?B?Y0tweE5EN2VXVHNxdU42YTJWcm0wOXZYVzU0elBXcGRBTXlrZzA5dWRZK243?=
 =?utf-8?B?YW92WnZsRHZmWG42UkQ3KzNxOTVVc1RUK2VwUkdKSS9MVzd6Sms0djd2dXZT?=
 =?utf-8?B?OGoyWWQ4Rjg2MWZmbDQ1NUNGTDhPZS9reWI0TXZhTWhCUW8vbTVoZ2t0VS9t?=
 =?utf-8?B?Yk80RjBVMkFjTkZmTENkOEdXTm1BMGFvcE5lM1dodXQ1VG84eEI5aFVtc2xX?=
 =?utf-8?B?cHNwZGdtbUVqVnZacFFkdVRtUytiOC9mUDM1c0cvV1BkbXlTa25kcXQ4YWw2?=
 =?utf-8?B?dGlYRkRId0JrY2psN1hCRUNWQkxDb1RBcFU5MnBybWRPaHBXRnhnNzZhbFl3?=
 =?utf-8?B?bWNLa1V3R2cyT0JCSmJWaFBSRmVhZS9rNkppKytiZE1YQ3VOSWI1QmZoclBv?=
 =?utf-8?B?TUxpRHAyNlc0Rk9WNjNCbW5GU1hPUlNVcGJvTjY2VlJxcjRkK3M4L0NBY1ZD?=
 =?utf-8?B?NVVTSXB0MmkzaytCaG55TXpiMGVIN3dFQ0NjNmxXbXc5WVN0c2pCMWlodWNo?=
 =?utf-8?B?UTlFSGtvYVpHbTBBdlBtNDBCRityM1NNeUlQR2ZocHdJNGcvai9jbUFobTA1?=
 =?utf-8?B?S1oxK0FkV055eW5PRUtWQ0VGK29zVjVTSVhIVk1LdkpSWmRRcFBkMlZ4Ynhl?=
 =?utf-8?B?WFFGS0NPU0RuVGcxWFVMMjVjV213TFVGZUdORjFqNEZsU3pTNzJxVWYwai9q?=
 =?utf-8?B?MUpBbW8zY2FvbDdpdlFqQ05NZURIV2VheFdtTzdFbGhaRE1PTytKcnVOQ1pQ?=
 =?utf-8?B?RU9SWUI4QUJZNEVBYWFwbmFULzlwcFdVOElXUWFuelUwMTRaajhES1ZZS1N3?=
 =?utf-8?B?bUhzeUVSTTl0cWFXNDZXK1Z5b0ViMEh5ckYyK0lPdmlXa0tYcmNnWU85WEJH?=
 =?utf-8?B?WnAzNDZnZ0xKTXFyRXoxZlR4MTNHQmVacS9UOWlFTHE4bC9lbDBWcWVwcy9h?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dUxraEVqSm9RZi9jUjJLWjByRTFDdTBIV0pKaFJseWpDcTFzdE5PVVdNOGVZ?=
 =?utf-8?B?ZmpjV0pBT3B4bS9BTExobnFoQks4cE9pOVcrSmMrdzZzd2hZM25aQmZZSi9Q?=
 =?utf-8?B?QVdBSVdnT3k0WXlsRHlCcEUrTDlpbkZSYXBIYUc5NlF4V1JLd1h0YmhsNFRq?=
 =?utf-8?B?aElocDhUMUFGbXB0RU8wUTkzWEFJTnVJS3RvblJicm51OXhrdnpzYitrVldE?=
 =?utf-8?B?OWZKQUxaRGZtVHRhMmgzZ01jck1BWWloejVQVnRJT1V0NGc1RVFBRHF5RkJX?=
 =?utf-8?B?bmppZ2lZMFNxTkRWWVFiZUltUWV4SjVtd1hObjZKYTRZRkFQQVRHVXo2Y2dZ?=
 =?utf-8?B?RCs2TnlqSkNyTkRNZmYrdGdNYTI3L2xQNmw5WnJVcVU1K3RiWjNRZDFRMkRq?=
 =?utf-8?B?bm1DRDFBaGR3UmIxR21lQzRTeFplQnEzZkN3N1RoWFBXVzFoNS9ER1V5SUZU?=
 =?utf-8?B?d3FRakZpUzRIa25yM3UxdHFHOG5PbGRuVVBsVFBsMC9iZS9XOUlMVzBPbkpr?=
 =?utf-8?B?Y3VKU1V5NGlnYnpiYUt4RlB6dmxxT2RUTTQvSEo3SjhzcGl1Q25MNTRWQit0?=
 =?utf-8?B?UTY5OUpHM3NYOG1zRUZubUhtQVlnZGpZblhJSTNmb3JoYXF1NWdCYk9vREtC?=
 =?utf-8?B?ZUg4cU02bjEwVW1UbWQ0Z2ZlMzRoTWIxVDQ4Ymk1MU41Mzlvdk1jVzE5cG1w?=
 =?utf-8?B?ajVSQk81QWpkSHAzK0MwdFRLeHM1M1NsYVp1NkZVaXBpOEpSdmlURGwycVZ6?=
 =?utf-8?B?MEhSeTQvNWIrUi9ZcXNLYTNjS0orN1pBSlFoa2ROSzBGaG1mTzd0WjBxOWwr?=
 =?utf-8?B?T0ZoTWRNMk80R1FBajZhNEtVMUdkUytCTTdpN1dqczRyTFdicUtXNmxqZDR0?=
 =?utf-8?B?TTlxa2xxcy9FblF6aitvQ0M4SEFMaUxvdDkzR0RvaGkxUWhpUWEyc2JOb2Fp?=
 =?utf-8?B?RHdUV3ZjWXc5Qm0rMlEyNUd6WFpaeHFIVERoWVAwdVVQZUtwaFpBNXdPR0dX?=
 =?utf-8?B?cjczc2lpRnNCZXZ4MmlndGxUWThqbmtzdnpnZ0ZOOVAxWjNPYnBWdDVyaWc2?=
 =?utf-8?B?SjVPdlhNOXlpeE1FQjRJOVNnZWdqamUxZ1dUVmwwZ21aUmdKOUNVSy9CV3ZY?=
 =?utf-8?B?RHhXSzZSZlFURDRyWTJDZjVqeWZ0QXJiNU8wY2c0Wkk1QkVKamlUblJwMVBU?=
 =?utf-8?B?ekVGVjdIODlFYnRCS0Juc0FBaU9pTHo2ajNvMGQ0MURycE1QQjJKUmVIaXRB?=
 =?utf-8?B?UzBhOGJZeDVpOXg4cmk5clhCZHdIRzFVbklKSDE1eU5CazA2MVNLd3pUeFVt?=
 =?utf-8?B?azZ6cTl2Mnh5ZDRtWUpsblg5b09nSG1ER29GaWZhd0hKdTIvRGFVbm4zOUlJ?=
 =?utf-8?B?cFRhYzJRb3dsQ0E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949e4922-ff30-4b0d-2d52-08db55f1efc2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 09:43:00.3532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpThMN5CrJQtNL1gvYqfthN7YASIzQwXam00UPqsyL6Xvi0VowNFuhpB03Ke4jAGaeRS7URtNpFiHwGn8hcwkyqLy5lazkGMa8Bh1G8FOTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_03,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160082
X-Proofpoint-ORIG-GUID: dE3ERTXFU7iF8B5Sn7keBC9GvlZRxMSL
X-Proofpoint-GUID: dE3ERTXFU7iF8B5Sn7keBC9GvlZRxMSL
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=david.edmondson@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Juan Quintela <quintela@redhat.com> writes:

> It is a time that needs to be cleaned each time cancel migration.
> Once there create migration_time_since() to calculate how time since a
> time in the past.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> ---
>
> Rename to migration_time_since (c=C3=A9dric)
> ---
>  migration/migration-stats.h | 13 +++++++++++++
>  migration/migration.h       |  1 -
>  migration/migration-stats.c |  7 +++++++
>  migration/migration.c       |  9 ++++-----
>  4 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index e782f1b0df..21402af9e4 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -75,6 +75,10 @@ typedef struct {
>       * Number of bytes sent during precopy stage.
>       */
>      Stat64 precopy_bytes;
> +    /*
> +     * How long has the setup stage took.
> +     */
> +    Stat64 setup_time;

Is this really a Stat64? It doesn't appear to need the atomic update
feature.

>      /*
>       * Total number of bytes transferred.
>       */
> @@ -87,4 +91,13 @@ typedef struct {
> =20
>  extern MigrationAtomicStats mig_stats;
> =20
> +/**
> + * migration_time_since: Calculate how much time has passed
> + *
> + * @stats: migration stats
> + * @since: reference time since we want to calculate
> + *
> + * Returns: Nothing.  The time is stored in val.

"stored in stats->setup_time"

> + */
> +void migration_time_since(MigrationAtomicStats *stats, int64_t since);
>  #endif
> diff --git a/migration/migration.h b/migration/migration.h
> index 48a46123a0..27aa3b1035 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -316,7 +316,6 @@ struct MigrationState {
>      int64_t downtime;
>      int64_t expected_downtime;
>      bool capabilities[MIGRATION_CAPABILITY__MAX];
> -    int64_t setup_time;
>      /*
>       * Whether guest was running when we enter the completion stage.
>       * If migration is interrupted by any reason, we need to continue
> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
> index 2f2cea965c..3431453c90 100644
> --- a/migration/migration-stats.c
> +++ b/migration/migration-stats.c
> @@ -12,6 +12,13 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qemu/stats64.h"
> +#include "qemu/timer.h"
>  #include "migration-stats.h"
> =20
>  MigrationAtomicStats mig_stats;
> +
> +void migration_time_since(MigrationAtomicStats *stats, int64_t since)
> +{
> +    int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
> +    stat64_set(&stats->setup_time, now - since);
> +}
> diff --git a/migration/migration.c b/migration/migration.c
> index c41c7491bb..e9466273bb 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -887,7 +887,7 @@ static void populate_time_info(MigrationInfo *info, M=
igrationState *s)
>  {
>      info->has_status =3D true;
>      info->has_setup_time =3D true;
> -    info->setup_time =3D s->setup_time;
> +    info->setup_time =3D stat64_get(&mig_stats.setup_time);
> =20
>      if (s->state =3D=3D MIGRATION_STATUS_COMPLETED) {
>          info->has_total_time =3D true;
> @@ -1390,7 +1390,6 @@ void migrate_init(MigrationState *s)
>      s->pages_per_second =3D 0.0;
>      s->downtime =3D 0;
>      s->expected_downtime =3D 0;
> -    s->setup_time =3D 0;
>      s->start_postcopy =3D false;
>      s->postcopy_after_devices =3D false;
>      s->migration_thread_running =3D false;
> @@ -2647,7 +2646,7 @@ static void migration_calculate_complete(MigrationS=
tate *s)
>          s->downtime =3D end_time - s->downtime_start;
>      }
> =20
> -    transfer_time =3D s->total_time - s->setup_time;
> +    transfer_time =3D s->total_time - stat64_get(&mig_stats.setup_time);
>      if (transfer_time) {
>          s->mbps =3D ((double) bytes * 8.0) / transfer_time / 1000;
>      }
> @@ -2969,7 +2968,7 @@ static void *migration_thread(void *opaque)
>      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>                                 MIGRATION_STATUS_ACTIVE);
> =20
> -    s->setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
> +    migration_time_since(&mig_stats, setup_start);
> =20
>      trace_migration_thread_setup_complete();
> =20
> @@ -3081,7 +3080,7 @@ static void *bg_migration_thread(void *opaque)
>      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>                                 MIGRATION_STATUS_ACTIVE);
> =20
> -    s->setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
> +    migration_time_since(&mig_stats, setup_start);
> =20
>      trace_migration_thread_setup_complete();
>      s->downtime_start =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> --=20
> 2.40.1
--=20
Walk without rhythm and it won't attract the worm.

