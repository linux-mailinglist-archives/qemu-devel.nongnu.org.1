Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A93F8010E1
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:12:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r973Q-0001Zc-NI; Fri, 01 Dec 2023 12:11:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r973O-0001Z3-0J
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:11:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r973M-0004nF-3h
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:11:49 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B1GaSbq010970; Fri, 1 Dec 2023 17:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xTL/woZwpGEchO2zg7aanieCRmODQ/9uAvGyBKEBJMM=;
 b=Y1fHS87O6gVf8IXO0Iuyg7nv0CcRsPU3fbpxRtdZFoNzElDHO/W/gfjDwKgebKDN1O/s
 OxXEExAE1B1qg6Fd0KmBgCI2rh8lr7hGGmJ/7gi8+RiQIudZJmw3j2c7Z3Tb3vgtBEbP
 tPiFBb3MtugvJ9T4U9fER6dgxOa+nrvY9AiaTShsNlUaALre3IvJZX3zF0D6OwL1pzao
 K1VvoUDuRKiyYGmnejnRvySjFi4ZHpYSXSk5tqUP6ejl//nDhjZcoPrHMgdE/0U59hJg
 hGtZ+o1tsFWniOKCUlEWEbf3aCwMInj5InNdtSUaEXFd3yydH2SlOOBG0uRwFKVMkiMD VA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uqhg78cds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Dec 2023 17:11:45 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B1FuLJb027187; Fri, 1 Dec 2023 17:11:44 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uk7cc3uwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Dec 2023 17:11:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fmu8yKIuqwSFb6RINS8EUvnSC/ESnewqIPNIzI2JxpcLepbrKFMYWlFs89/6izqsXT7EbiTiCXnB1W0SC4RqsSGSrZ2Nub6k9iTa19eXTp/vaM/JIAvilKSvJOdye3BXpWR+IEl0Jon3wKcZyE2vacwgs9pcN5RBsW/W7InM4r9T/V5oSwRewyTb/Zxpjk2Ep89XATPHfPia5ZVnxM23M9Rsz7YqU49MZhHyw3m/rhnBsuTwKEnHA/IquC0fn75YQpExGaktkok2U9srfg1EuO7nWHFiVXEL5j9EXPXHttFDRqHo13n8t+EeyguLFYu06dj1T7hPXOuqr22AtsjCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTL/woZwpGEchO2zg7aanieCRmODQ/9uAvGyBKEBJMM=;
 b=E6coEAWH9kaPsrVOzGV606yycV+meGNeL3NeE4sTCAIuKWqns69qaqe1Nyhp36FyRJgeDxCI6/Ssqr2T/TRyCAAQUgN48OJSofna0tx2tS7CNOOVFIfJMz79l5mwzFS1XkLJxxbi2I2IE4AZt3FIdlCKB+V61BZ7Bt39HFRYhQqZTjm150xNtYnp4eqGwHjq1oueKytoNIyu9ZFolWi+mHwQ98YVOyVwgN9oKziFm/hJerNtnDuyqLPdgqMMsR804HoJuj6rFJpyFOr/Y93L/liisqXHIP9YDoRzWz1qMvqBtKa8R+lT4pKnsMHwHMhDWeyJsnSCxv8rjYkbuN/M7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTL/woZwpGEchO2zg7aanieCRmODQ/9uAvGyBKEBJMM=;
 b=RkTriF+Ze9rK94KnmtH242zTczG8ZjPgidT501/XMoJz3tPmRLBg8byuVNPjBxny2yr784AjpPKUXS3qtkCxXCI4jYbldHejyVVxkMZ5Lpog/IHRrhtqZG9AqNHsY5GfFLB23xGt2+VgtAe5gu3g90TADzNcMYTqcOn4S/vP+2Y=
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 17:11:41 +0000
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::f3e1:362d:53d0:9f87]) by SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::f3e1:362d:53d0:9f87%7]) with mapi id 15.20.7025.021; Fri, 1 Dec 2023
 17:11:41 +0000
Message-ID: <0533cef9-2499-4480-b0a2-e5c00787ceda@oracle.com>
Date: Fri, 1 Dec 2023 12:11:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 03/14] cpus: stop vm in suspended runstate
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-4-git-send-email-steven.sistare@oracle.com>
 <ZWkIV1k7n7xW5doM@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZWkIV1k7n7xW5doM@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::33) To SJ0PR10MB4686.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:EE_|CO1PR10MB4497:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a05374-2527-4e0d-715a-08dbf290962b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqTZJm59xkqjZ05JUpySNVN4d3L/Oz2MZbDL/cZ6GpWGMaYb+N2avJYpfHMrSbOxfsxSfT0t8Oqaz7nyZN3uVZBOpWMqzERY/tTRtfQC93DkFYNYqinatz+8R9hwBsz4BTCZIIvPGDS2mhcEihd7NYxhAIn7dxVRnM6xOrEP1BwKSBqYcE+fqnaLSFir4dvmLgvKc5wkLbjSzp8cQf22Z1fiiRZd5MfIngKOqj1cTq/cSkOvAZFq/S/KwVsqUXBM+npH3a0E/qTRdpRy75833zdjpm5wfCf2StY/kjTLzbWUkKgx/D45KIdx5dQcBMVNHaGZ0Zr83e7UeggIniXSoOUqU6UIYcmI9vV8atd1N3jWX3gbqV6EUh9F4fV53awlB/uDsuFWDrEuqHrkt6FOwu2WzIYyiAZFkX6hRQ+KL05qgxb2OkDeVvF4ckMudvXBH6WuJexuySfH8Fg8PM9PMuU/IuDVnvlZP5OzhTZJqkgnBlRIMp15QbjhgG4dqBc1kddkTinCMcJz6jwTiK/HSW4Y5I3fjFE8FAEWNe4g4bXqHVLmpbWJN/dP/2hh08D9W3etQqYyWGkAaKeIHEN1otM2B4FwL0VW2gzc5e9G5gP6QpreHwUyhhsWhj1/EIRowAsWmsiG9bytE0PJFmqPYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4686.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(38100700002)(31696002)(86362001)(36756003)(66946007)(8936002)(8676002)(66476007)(54906003)(4326008)(6916009)(66556008)(316002)(7416002)(15650500001)(5660300002)(2906002)(31686004)(53546011)(44832011)(6512007)(2616005)(478600001)(6486002)(36916002)(26005)(6666004)(6506007)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2dvczE3RzUzNWcrcnZiWUhoN3EzNXJtWUR2WHNicUZUVzFrL0lLNWJ6aGNC?=
 =?utf-8?B?YkdESHBKSkZrd1lxMjU5d2dRSmxxcmQxNC9aZ3JTamw3MjY4SldLSnhCU1NP?=
 =?utf-8?B?dkJ0MDRGZjc4Y3BvSG1GREtmR1lNN3hTY2s3TlBuc1dJdkRCdVRJUUNDSU5x?=
 =?utf-8?B?a2gxOTVCUDZJaFJXdVYzSFhibTRweG1PWGpBWmI1THR2VVVCWitZSmZxYWpk?=
 =?utf-8?B?WnR0clh2VXlPbUZZUFVoTGE1eXlvVUFLQ0VNazJsbDdTV2FDaDRRM0gxTGxW?=
 =?utf-8?B?YVNNc0lxMmkvQVM3OVBxdXZDK0k2Vmt1WDNZNitCNDNUYTZKTUxvTytVVVB4?=
 =?utf-8?B?YWlDRFY5RitWcStCdCtBY01mWHc0R1pic0wyZUV5Y2JoamgwbnFLOXNJMGRH?=
 =?utf-8?B?SGNNVEpZVkJKNDFBVFN5c09iZHVpaEVpNDYrclIxQmZocU5NeXRaR2crUDVP?=
 =?utf-8?B?US9jLzRVejhwY2lsQUVISEpjaWd1V1NnRWgvR0thRkRqTHNkbGlRSm1USkNW?=
 =?utf-8?B?dEFTMnRIMWYvK05qcStFSDhJakVqOFpKdnc0TlNEUHp1VkNHQzgyeFJRaWJR?=
 =?utf-8?B?M2hRNGk1bkRPOGRBc2w0b2lsWlpoNk8rZjIxdnc2QWxUNnZpWEhkdjNORlVz?=
 =?utf-8?B?QUtFeW9XUXYyUEhTSzYvOVIrWkdEUnlJa1d6UzBtMFNaTVpUeGJpMDVHa2Zv?=
 =?utf-8?B?L0diUkswOWxNOEc0am5CR2svSEZBYzVVWGV0QjBITlJJUlBmTWk0aEFlaHhH?=
 =?utf-8?B?TnA0OGF0S2hjQmVaMkw4Q2hQdzFIbTllcXplUUQ0UlJGZzR2KzZOM1poOXVV?=
 =?utf-8?B?ekRtbVdLWWVVeXE4OU9KaWQzN0JIYnQzL2RIczhmTGRKcFhYeTgwYUEwMkJn?=
 =?utf-8?B?a0xIS2U2Y0NVWndScFZ5SFhvYzFDODdvRHBzcURBaVJYRENSQmFnU3FWSjhr?=
 =?utf-8?B?bEVsRXhLcWx6em52dFZrbHpJNDZwVXZ4ZTFCWlNlMGF0aWg1ODJIbVFSZmFz?=
 =?utf-8?B?dzlCUmRPTUt4Ym1hKzQ5ekh6SFcyQ3J3QW0zZ2w1VUNwSXRUWnhWRnJsWTdK?=
 =?utf-8?B?VlowVWNiOTRDWFE1Zk9DWHpibkp3bDJ0UGM1YllYbGFIOEQ5T3AwM3dWQ0F5?=
 =?utf-8?B?Z2QvVldCc212aWhzb1hlc25HYzl0SlhNWjl3bXM1NmxqRW44TTcvTnI1eDM0?=
 =?utf-8?B?TlEyZTFrcllUdnhxS0p1V3owcUFTT01oVGltcDEvb2lsNkcyVVcweFhpckhB?=
 =?utf-8?B?YzVvT2lwTU05R1VwaFNWTTN5T0k1MThzb3FJU1BSWk9aY2lKMUE1bk52SEVW?=
 =?utf-8?B?ektBalhpOTBPY1ZESlhUdVZ3VG1VS2JJRzRFU3Q3VVFhMkNQb05FeEtLWmFz?=
 =?utf-8?B?YjUrM0dSMTVscEc2TzhsU0lMWFE0UXlYTGhIWFB1dmZVaVlXYWZPWFhJUFN3?=
 =?utf-8?B?Y2RBamdjRG9QS1Mra2hSQjc0R0l6ZXpuTEZpdTJ1MUp6VlM2Y0hPWjNJemtZ?=
 =?utf-8?B?TTI1OEVBM29qMFVURTF5dmttWG1zN0hOU3EzN2tOOGxqN0VLVFZQbGN4cklw?=
 =?utf-8?B?c3A3RUdOSE5oTC9Ec0puTUZaMkpERlptQzRYc3ViY1B1eFNhMXZTRFF3TC9H?=
 =?utf-8?B?NjcwWUxHZ0J5Z2xCOEFKeUMrMlRPR3VOU3NFdUhHQS92Y2ZUKy84c09MTWk1?=
 =?utf-8?B?S2NOcGVGTHdsa0hjTk9BcVlhdUdWTnAyWXVPK055dUk3d3VsSEQ5ZnhLUHlZ?=
 =?utf-8?B?cHVCTlRoK2ZLQ1MrMEJnODRTQTFtRTdic1BJbkRzaC9hK0hvTWMzZk43cERV?=
 =?utf-8?B?eWs3Ly9ZN1lBdDFVR25WaDVOL2tNcmVJa3hhTmZwYktkYk1VeWJYL0wrQVU5?=
 =?utf-8?B?d3ZRTzZoMHdFUkYzT2Q3ZjlzNXdSLzRXM2k2QU5md2JhaGhhRjJiTlBXUGhs?=
 =?utf-8?B?cmk2S0c1aHhWNVNPWi9ibXprNFU2ekhiQ0wvZkU4Y3dGb0RyK0RhK3hlY2xr?=
 =?utf-8?B?VVRyRXlRVVNkazhPTFpGKzBxVllzdDJoeXdnMmJEeVI1eHA5cWNhZEljU2ts?=
 =?utf-8?B?RktIN1dkZHJ5OE8vR0srdVRVMXg5U1hpa08zYVA2bmllU05kdGVpeUlXYTk4?=
 =?utf-8?B?Vm5wcm91OEJrVDQxK3pYRzFXVXhUVFF6M3FsUVJzRmZHSWgwYlcrMnYzdUpO?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y5aljlzy6wy6tupI4opQgO7Z2v+9VDFmUQVU4P7ttbtufdtmBbtL4R3QjRD0PXO8drZOf2bEeJuVCBWyAHuK+sc1aToqAKFnudEbwaq1Pn3QuPhuSz7pG+H2dMEBsmO2ncAQqpEsVYn44vrmVE3LBGrMy0eyyB/kloTtwL5lw3h2UVDhwvhVNr0c9xB1CMn43f/v5r7qZs7NhaDjwMj4EEMgM0egtrSk+CkCqde9qVw9nw+n8A7Nmt06qy3boDcpxZYY/xtQJ4kxF1dtsgFlY6HSEBesNVTyh6RVeyVj9ZUKNDEfF1nhzdp/ozg1h/yRFPLuchQ3nxaxibtcA3fsFCepBneTVDrzzIKBulLYql6Esb7SPNvpICICo1c7AWNY9+JjRvC/pbPb2wQb13mNnyUUhBy0xEt6VyhUomeYSjnFGnw6p7hbSLK6LOX4DO9ltysPOurhJtUZ4gs6HvVfEU6QrjeG0UwEdXDc3ClGuiB0V5wOzvwpTpYpsMffGhU1VknZvZXnfphMMNi8TBfwmL1fTHsdqXZ5slbwbtgoBhYLeX51uc4D8fBwJd/9LHnL7BT9JXHviOjTeiKUgZLsqHZxa/dnuPMpKCOqvwRsyaKHSwVy3TBXPSGp4FWhhDL3IVaJPjhLDEsE758IllPIStWd4n25EG3mzFiSggAUwidwjdBr2e+4PSeUPx+Eh3wdoKcb6/ZDam1qC2CkznmWLV6VUgYSobyt+5lDxJQHB02OxYqvCqJtRyyuFZi+3ACpiveqeuk+hF0PfRdmVaVyB4tRa/86NoDTIDY7GhR9Ic0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a05374-2527-4e0d-715a-08dbf290962b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4686.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 17:11:41.4691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ypwDylKLUSH3E5nVewfr/W8iYMbpg/H2sfrNNAw/uO6ZBAAlDVIYyM2vogqxf3ptt3yfsj6CqfQc7h7dBwYaIxF8mhFh1WpaaIBpdBvSwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_15,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312010115
X-Proofpoint-GUID: jmOvBkFSo_PHuI9lHdr62TH-z8lwFAFX
X-Proofpoint-ORIG-GUID: jmOvBkFSo_PHuI9lHdr62TH-z8lwFAFX
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 11/30/2023 5:10 PM, Peter Xu wrote:
> On Thu, Nov 30, 2023 at 01:37:16PM -0800, Steve Sistare wrote:
>> Currently, a vm in the suspended state is not completely stopped.  The VCPUs
>> have been paused, but the cpu clock still runs, and runstate notifiers for
>> the transition to stopped have not been called.  This causes problems for
>> live migration.  Stale cpu timers_state is saved to the migration stream,
>> causing time errors in the guest when it wakes from suspend, and state that
>> would have been modified by runstate notifiers is wrong.
>>
>> Modify vm_stop to completely stop the vm if the current state is suspended,
>> transition to RUN_STATE_PAUSED, and remember that the machine was suspended.
>> Modify vm_start to restore the suspended state.
>>
>> This affects all callers of vm_stop and vm_start, notably, the qapi stop and
>> cont commands.  For example:
>>
>>     (qemu) info status
>>     VM status: paused (suspended)
>>
>>     (qemu) stop
>>     (qemu) info status
>>     VM status: paused
>>
>>     (qemu) cont
>>     (qemu) info status
>>     VM status: paused (suspended)
>>
>>     (qemu) system_wakeup
>>     (qemu) info status
>>     VM status: running
> 
> So system_wakeup for a stopped (but used to be suspended) VM will fail
> directly, not touching vm_was_suspended.  It's not mentioned here, but that
> behavior makes sense to me.

Right.  I'll add that example above.

>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Since you touched qapi/, please copy maintainers too.  I've copied Markus
> and Eric in this reply.

My bad, thanks for the cc.

> I also have some nitpicks which may not affect the R-b, please see below.
> 
>> ---
>>  include/sysemu/runstate.h |  5 +++++
>>  qapi/misc.json            | 10 ++++++++--
>>  system/cpus.c             | 19 ++++++++++++++-----
>>  system/runstate.c         |  3 +++
>>  4 files changed, 30 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
>> index f6a337b..1d6828f 100644
>> --- a/include/sysemu/runstate.h
>> +++ b/include/sysemu/runstate.h
>> @@ -40,6 +40,11 @@ static inline bool shutdown_caused_by_guest(ShutdownCause cause)
>>      return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
>>  }
>>  
>> +static inline bool runstate_is_started(RunState state)
> 
> Would runstate_has_vm_running() sound better?  It is a bit awkward when
> saying something like "start a runstate".

I have been searching for the perfect name for this accessor.
IMO using "running" in this accessor is confusing because it applies to both
the running and suspended state.  So, I invented a new aggregate state called
started.  vm_start transitions the machine to a started state.

How about runstate_was_started?  It works well at both start and stop call sites:

    void vm_resume(RunState state)
        if (runstate_was_started(state)) {
            vm_start();

    int vm_stop_force_state(RunState state)
        if (runstate_was_started(runstate_get())) {
            return vm_stop(state);

- Steve

>> +{
>> +    return state == RUN_STATE_RUNNING || state == RUN_STATE_SUSPENDED;
>> +}
>> +

