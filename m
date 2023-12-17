Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FCD8161E4
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 21:02:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rExJm-00063h-8c; Sun, 17 Dec 2023 15:00:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=071565f1aa=kai.kang@windriver.com>)
 id 1rEwSt-0004hK-D6
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 14:06:15 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=071565f1aa=kai.kang@windriver.com>)
 id 1rEwSr-0005QF-97
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 14:06:15 -0500
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3BHIfOWr012763
 for <qemu-devel@nongnu.org>; Sun, 17 Dec 2023 19:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=message-id:date:from:subject:to:content-type
 :content-transfer-encoding:mime-version; s=PPS06212021; bh=N+8Is
 ltUDWQa4N4zN03Sc+fGdPWtxRQwWtLi/+O/nuA=; b=swBWuMxqB+PDdIWzGgL7V
 9u9GB73XCD5w0ELfbxXt2HfYUGkBBk5pr5Nb67Pa3PVT30zq9KQbeSHQgiOh3rkN
 Y1vfry0Ir1gFYEZdoD+5IMRuq5kf4pymIX4OnI3Iq12wYgcOMbxHsmibgTVIZeAT
 gzsN0quPt5PKbyucczQ/Y1ATJ+LqVQM2R3UIWhU2e8bkbh4oohGERsABUy3xyhH8
 NOy2hrzsWa+rQIlYzB1cLLDHsPIANhzPVIawFk06oSOIF0EuHP4i7EZCDdiUMLij
 bNrZHhm346U/cJMlunqLKMgkCBlUbXYqyCG6rat4lZGLatw7Ft393vas97uJwF41
 g==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v113x9afb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 17 Dec 2023 19:06:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVU/+MMta6FmE0Uehg0WFlqDTMQDrEa05HOqCcsmM6A/cdjXz2ZjXqzD8JJB1jvJsyz6oQHscccZSP9AyeJIzm62DzQerHyOIv+EIVPQ5xs385Gkf/rRyQF1JQC+8q2ePXGeHrshkZCXkDO5bAvVctKAHrGkQpvVnopUybe2HouoGbejX4+iaswpNKTg/uncyyyn6uRgNIoVUmk8DZUlK0AGQJNkZ888LFrQP4ZfV0fQidJT4466Nrqh7kvHAxyRKX9kosD0HP6jYX21GojWaL807peAKnQslZExlRlY23LG8EiywqtDKEjnauqTydqczQ3j7NBbftCqcMMCcYondA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+8IsltUDWQa4N4zN03Sc+fGdPWtxRQwWtLi/+O/nuA=;
 b=fWNZfOUFsfr8Ujerp6RBWQj2w+xBFOVvqkv/XhzI8Zn6jph31oRz1bC666d1j76nw+i8+sMvt+D+O0Fld2MJ7UtSzYYgfKpV5awILRrjxtgqxUs+TJYZDNXJp8qXHfTd4VTP7QZYScvBeIUMwFR4NJHVnqi0X0K3nmw2+uejrSDGVArZIWMSrArjdIRZQNlzNb1Nno0al0wRn2mYAgECotUCKFabr00TdVCD/iRTrL2T7gWsIpsrZOatd4J9p2xvYeh1djFq02fKL0DAPShWcZurB7TqRP5dNviLk0/NWb/b0pO28n3Kpp4zjC4W50qSLmVNVS3g5m9VhZfbIXNMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB6064.namprd11.prod.outlook.com (2603:10b6:8:77::14) by
 BL1PR11MB5318.namprd11.prod.outlook.com (2603:10b6:208:312::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Sun, 17 Dec
 2023 19:06:05 +0000
Received: from DS7PR11MB6064.namprd11.prod.outlook.com
 ([fe80::dca9:26e2:b46:2372]) by DS7PR11MB6064.namprd11.prod.outlook.com
 ([fe80::dca9:26e2:b46:2372%3]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 19:06:05 +0000
Message-ID: <7132f398-ae8f-c9aa-563b-95a6657a3940@windriver.com>
Date: Mon, 18 Dec 2023 03:05:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From: Kai <kai.kang@windriver.com>
Subject: isa serial char devices created with reverse order since qemu 6.2.0
To: qemu-devel@nongnu.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0148.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::7) To DS7PR11MB6064.namprd11.prod.outlook.com
 (2603:10b6:8:77::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6064:EE_|BL1PR11MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: dae0feae-23bb-4425-5596-08dbff333780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dR64RIBAhIMaCA2PGuO9uBBolR7i/FHgTWdSmdk8SSLE7rB4H8UItTmuCisX59LttKRA5qsJDHTSD/kGvjLm8WvndDYHTO/4tSE/eh0H9nX9pa8U0zap+R8ZbhNkp8NhHgWTkhY/FjfJvh97PIiu5qJV+gw2qMGMozEYLi5pfo6jlky+vTXV87KY9RlBCiILvXE0RvBaWt0pditwwU1//HDcNf67zCC3i0/AXUQ64v1Gw2h0zY0i9XFVOlfG/T6SsvlVGfPU7AndSpHd/fDUOdWiLf+HG3vnjvNx0TbdvciKaJJRCsojiSak3bQUBIAqOmCLv/ln6dLNqOyvBohpPpqX52F5J+aaSmnSzdZ2XSBvaZ/Bx46JcRrEZlunjfBt6co8Kuqn0Sl84IUwwjsUInquXIqAyXYow5IpZmb1bQWhkNV8kj3BOsJFFdBgRFU2SKZgeGQLS8feGUgHjsWDj2R/IeOwYLJL9wqBqh5+oxhDQ/89zJo6pOdpMX/3wz0eNgl7L1tiWa1NKDRILSnkh7+XB1bY2MN1nAoLX6mtQMXhmT+xSsf3omncGkrScxMFVrmeReF970sSeMEX1cqLjswSSGEo1mYvCTDLPOs1muwylgrBWnY8tOrRqO7tjGsAoELQZtc6HnEeIZZ8PW2Jyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB6064.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39840400004)(376002)(366004)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(2616005)(6666004)(6512007)(6506007)(83380400001)(5660300002)(41300700001)(2906002)(478600001)(316002)(8676002)(8936002)(66946007)(66556008)(6486002)(66476007)(6916009)(36756003)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzN0NnB3S3p2Q0loUkU4UjBJWnBXdEpPbWIxa2NvWjZxbUJncnN5V09OejNC?=
 =?utf-8?B?UVIwVkhuWVhFbVVVNTVQMTB6MkU2U25RMFpLSjNVaWJyUVNWMlNuN1lsZUdq?=
 =?utf-8?B?NzBDV1BMWGpFUnJiY0hIb2RjNXBHSDd1YkVNYXJiUHduZ3Z2OHAxUThNSWxB?=
 =?utf-8?B?Q2dUUkpDbEdFUHJyYndRSkdOOXExdlFpUW1wbGRPMTVCTU1yTDVoRGdUNDFU?=
 =?utf-8?B?bGo2VTBxSGlMUXhMQ0JLVHNIUkJoZzBnMENZNVlsaUNDbVBpV1BGWkRMTHgy?=
 =?utf-8?B?am5rT2ZxSlhRWmRvdUIrSiswTnBQbGJSMXMwMXVjUU5xK3R1T0dldTFJd29p?=
 =?utf-8?B?eVFIRHg5Ujhibjh6a0dMT1RWVzJJYUMycDNnOEV1aGkyQVRvT0ViWVhkNnVO?=
 =?utf-8?B?QUFHOWJpdFVpdDMxblZ1TTZZVDBpOG1COWF0eDhJaTJwRHVuRS8yQjcyNTlO?=
 =?utf-8?B?WTJmTEtRRDVWS0tNaEUzRWJ6Y1ZjdVVydVB4ZWppYUVneDMvbXdTSytYRlNm?=
 =?utf-8?B?UThTTzVEeEpIYWxoNENtbzZ0QWlpYzk4cGpMdW1uU2VJQTB2UlZJMmZzcHNN?=
 =?utf-8?B?dWZROFl3L3RWbFBUVEVheno4Q1lVMUNVVDBBMFVpWDZ4ZjdWQldLK1RjZFNG?=
 =?utf-8?B?UHFDWnlQZXJLRnNGaGZ2Q3J0WjljTG9nTm1QVER6Mk1YM2dtcXN6R3BBdVFo?=
 =?utf-8?B?dWsrMTBwd0hLeWlIQWVNTEJsVndVakJEa0RWREZNdTlkWmtYbGQ4NW5hWmpU?=
 =?utf-8?B?S3RIK1d0VFF3TjVtV3lWOGxrRkdTb3UvQnFjUEtUOXFuaXhVWGZwRzhDQSs3?=
 =?utf-8?B?S1pjUXZpbytNblBwcGhjWHZlOVE4ZUIrVUtmbENSWnVWMzdUaHBWbGxaZ1kv?=
 =?utf-8?B?eC94MFZkSWxsMVZzblA0Ky9rNWVzeS9iNlArL014WTlSL2trMmZ6ZlAydVc1?=
 =?utf-8?B?cS9JM0RZS2ZmQ25BNnhIVE4yQ29CRVZKREkveW9IRkt4Q3E1cFA5L0g4bThw?=
 =?utf-8?B?WVFJVlo5aTNFNXlCSGlXVDBBcm1YL2RNK3BCMDUrRTNGNUI3empjaG02SHpH?=
 =?utf-8?B?WktKZ0M5SlY3WTg4ZjNMZTZiZHd4N2xlQWw3aWRJMlBkSVVBZm5aWHE1ZUdm?=
 =?utf-8?B?c3JRbWt1SmlLVmZlUFFiZ0hnd004aGh3S09KSEdEOXRKT0pUbFV5WTlIc3NY?=
 =?utf-8?B?RzN2TFhMVmlCa0RVVG9ya2krR0JNY2kza3FSME4rWTRHVnhacG0rMHVGZFhl?=
 =?utf-8?B?ckplb1J3ZjV3T3NPczJrMHBUYmpyb1hpR3RvZW5pQUpSSlRGaktmOXBZNXVH?=
 =?utf-8?B?TXRHSlhyTHZQN2J4ZHE4MXNQRGM5RW9rT0pRdDk2QTV1ZzJXUTZYVXR5ZTBM?=
 =?utf-8?B?OWZGMElLNWVPbGVyelh5WnZaSjRHSWRtUFRVa2hiMGxrQ0QwdkRtOG54Unl4?=
 =?utf-8?B?NmVFaGpjZDlEL0JkYTQxbCt4TkFHUkZUaFRPbjEyMXZ0YW9VNnVvaUpWN1h1?=
 =?utf-8?B?WkdEZVVNam1oWGxweW83c0xYZC90b1NudHJkcGFUYjZyN2lQejlBeElmY0pU?=
 =?utf-8?B?SVZFb2VzL25IOXpkcXhRWE9acXFKdjM1aVpyL1o0MloxSFIxWDZpNUdkWVRE?=
 =?utf-8?B?M1BFaG0wZHkzL3JlRWJ4cU9BaFYvREFBYlJTRXJMS0laTnV2bVNya0xWbmtU?=
 =?utf-8?B?Tk1ibUMyS25BQkpyL1dQNEhleG8waDV3bnhoekZza0pBWlY5Mm9XSGd5WThj?=
 =?utf-8?B?ZjRtdjBTbi82N1JLLzA1cU5aT0ZZSFBSa2RlS3VKRVhRaGxJYnl1ZGJwa0ZL?=
 =?utf-8?B?WXFRSjh4WHMwUEZOUXAzazNJM3RDTVZwb1BQU2hsa1pSMHBVV1ZBMWlWWVFw?=
 =?utf-8?B?MGVGRkpQcDk4citoY1FLY1JkeUxETjVDVXhKMXgzMHRaYmh2Q2YzSXNsQlIz?=
 =?utf-8?B?Qy9YRHNrNWJadEU0RkRmR1JLNHpScjdScVNCUVBRZG5UYUVtVURuZm9wVXZr?=
 =?utf-8?B?MGIvOHdzM096YzdnLzJSNG5xK2QvM0ovbllDbkNPeW9jcmNIdXk4TFZWRnMz?=
 =?utf-8?B?QzVEMmdxNWtqaUs0QkIrNzZuci9MOXVXbjBYcVA5Y24rMElDZHh4YVovUXFP?=
 =?utf-8?Q?LG8MarFWkIJ8aFSvc9m/0hIBD?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae0feae-23bb-4425-5596-08dbff333780
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6064.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 19:06:04.8265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWBsJv+hg/hic5oy4+iYp4H76CKsm0wtqUg48T9/BtijAjfQDCeLoqzp38U3lqAbTLYTuSrj7iGVkObNQ9U/Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5318
X-Proofpoint-ORIG-GUID: Ddz0ElLcfa_KiMqiAXPs2FKFMdClN4Ep
X-Proofpoint-GUID: Ddz0ElLcfa_KiMqiAXPs2FKFMdClN4Ep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 mlxlogscore=775 malwarescore=0 spamscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312170142
Received-SPF: pass client-ip=205.220.178.238;
 envelope-from=prvs=071565f1aa=kai.kang@windriver.com;
 helo=mx0b-0064b401.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 17 Dec 2023 15:00:52 -0500
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

Hi,

I am working on qemu 6.2.0 for isa serial char device in 
hw/char/serial-isa.c.
It once creates 2 ports with "1" and  "2" literally. But with the 
following commit

commit dcdbfaafe90a5e6e172368b2aa5500a9ca192e49
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Fri May 15 17:04:10 2020 +0200

     acpi: move aml builder code for serial device

     The code uses the isa_serial_io array to figure what the device uid is.
     Side effect is that acpi antries are not limited to port 1+2 any more,
     we'll also get entries for ports 3+4.

they are created in reverse order with 4,3,2,1.

With the following command,

# qemu-system-x86_64 -enable-kvm -S -cpu Conroe -m 2048 -chardev 
pty,id=charserial0 -device 
isa-serial,chardev=charserial0,id=serial0,index=0 -chardev 
tty,id=charserial1,path=/dev/ttyS1 -device 
isa-serial,chardev=charserial1,id=serial1,index=1

It calls the realize function serial_isa_realizefn() with indexes "0" 
and "1". But calls serial_isa_build_aml() with 1 and 0.

I didn't figure out the root cause. Which part of source codes should I 
focus on next please?
Or fortunately someone just knows the root cause.

Thanks a lot.

-- 
Kai Kang
Wind River Linux


