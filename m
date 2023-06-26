Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A2E73DC04
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 12:08:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDj8W-0004ta-4L; Mon, 26 Jun 2023 06:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qDj8S-0004sv-Lv
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:07:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qDj8P-0001Ew-OP
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:07:52 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35Q9LPE3004770; Mon, 26 Jun 2023 10:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=u7UBw1zR6MpCB0s58j8YY1fE+RSFaAfpRE8+/pQqjRg=;
 b=lybS4DzUJlz8T+0dlaWwaxGecq5hFaNMpqoSkZLLHurz2XqY0ULKDx4VjUkzifCFp3r1
 lnsoECmmnyoqkjF/9HpmuQ4kE52B4zIcyT+/DwezA9c4LzlKoi2BTRpIxwiU8fnwXcqE
 EsM5onmHSalpYQBa8TflwNN/NcxVzC/CWRW0mOsPKinejTPU86bo8kGPRDqIqiz/i9EF
 lM1yAG/W0PTMmRhTHBTKwye3UjcaGEgqF3Eq4Vvdrn+4wn2mmhqKg61h5YbeAOhJ4okk
 iBOv9Eky5GK4g92Ut9ludODCN7kMucV1m5J18mnAL9+bY6BPavN5GpTPM7PpotBzLIkH sQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq9329xk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 10:07:46 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35Q920Xg018817; Mon, 26 Jun 2023 10:07:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx34193-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 10:07:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxGhcb4GlmbppJ+2hENFPYYc9apln/lscgoYiPhXhpgxO0+NxH0RvZ9fnX2LBLwr3VW3B3zDowJ95GqKxKlkOv0Ccntiu+x6F8PyuZOipoeypsz1xHv8WOeTlfFC5Brh5xyPt7H0Sjft+Mn4U8ya7HvG5MMbkr63oLK+Ibd/Xqlqua1Ht/F2Aq++Du9eQbCu5Sq2uAeUQhN/NMkUZ8yvywsrQgl3DmUl44/9NOhstgFJqp3Y4G/185DZIxSZKvItTmTxMbAChiFehvFFp9xLiyE8XmyFDP0gFaQLAW3W+x3F+g+BlWqymM4jjnoVGa1ZQ+7kwmhodbvVQqFUwEq+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7UBw1zR6MpCB0s58j8YY1fE+RSFaAfpRE8+/pQqjRg=;
 b=GWrxWJKBWs90hXNSZjf804KNYVd/vNXt3aWUkw9SWLDmqRe4AKPvktDD/an4kGFL1DIB8v83TJzEgBu/h4MuIre7PH5/u6QRrO/77tuaUo1UkYUo08MFgO1jIrQuHPkJpxaBQy3dKdsefzMj4IR8eDcJeZPOSzLm75HuaholNVmQKk0WmDsMOgcP1X8DPRi5gqGVU/lIthUo53eynvGq8x0pVodM0ihYONqjuJLh7doJuO/kAA6o3RtG5w9s4bRE0z9QMYqMfcclCAF9fPEezvcEeZF5WMMq8+IXmNETClJJrnvRjbuo1/giChW4NrLd5gAhsYqYMnBRNY6k42dlfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7UBw1zR6MpCB0s58j8YY1fE+RSFaAfpRE8+/pQqjRg=;
 b=JtULNMZL76QyVvUTiZidnaNgqm28MHEabHXDWt7/e2jb2bvGZnjXLfcY4oT0Bpn60UAHgREiTPOUD17NNX2t2DFXFahglZKAZjmLGeb4eexWLvAjcnwMhdgXZcOJJDO5Xv/apqYXdrTAUp7nSMxCCHd5JaBXYjjr9U1we64r9ow=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DM4PR10MB6792.namprd10.prod.outlook.com (2603:10b6:8:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 10:07:41 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 10:07:41 +0000
Message-ID: <7e1567f1-aa79-cbeb-3c1a-20594f1942cd@oracle.com>
Date: Mon, 26 Jun 2023 11:07:36 +0100
Subject: Re: [PATCH v3 1/3] vfio/pci: Fix resource leak in vfio_realize
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "avihaih@nvidia.com" <avihaih@nvidia.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
 <20230621080204.420723-2-zhenzhong.duan@intel.com>
 <88aa1fc0-edf4-a98e-0cbb-fcf312b3b19e@oracle.com>
 <SJ0PR11MB67441D1922E854785F2FED3D9221A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB6744837FBCEAB1F9060BBAFD9226A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744837FBCEAB1F9060BBAFD9226A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0206.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::26) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DM4PR10MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: bed77bd5-1171-4f31-ec94-08db762d2db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hsbo3jhb+dqwF6z/w30Azs4cDwFxf+WiHrTu5EPA4tmwoIvZQiJKrHgbjJ1XY0xJYU0wpWm87QLJfIi7gLqoKL7aA8PW1shPcrRSIll2kTYcM45yKO+uimXfhTsAdREiTautghpfQuxsf7rpXiUbgXoMUUmDl8G889h/LvNbeUbDgoSt6QEpU8vupPn1TnLX55GMXKQZgYOjRbO0qvkUBFIsfYBK01xHjPSb8FR8teJtdZjDhtjRadE9wpa/2iXWaakZDlbt0I/FFwhVYoAsE4/9eulc98++UazTAfWjY+/QeQ2gS0GJcNPxLz/ekHwIWVYVcYN1T+6nFPY2CFHA5v6K14hhoa19FCiKrHA37rVJdjS8wb1GYqHrWNsp/xocVb0fCztKk8LvMffcch9jDN2h9ZI57Hs/fqqrSiEGvIvvf5GPlE0UuGlBHFzQF1z9mxPM+U0g5Xvncc9HQCa5tyFu1GVfnpRKXo42JoJ6VMXy0O560kK9KQdgVNbrv1q+NIqpTI1QpDwTh+TN9OBhJWdJ3r2sjb1rM54RhB6ZeA3yGdshRF89SShRyq8Vt5BktLvusmF0HWNh83LAXKrslsWOx/Z2FruNO01gAz5PWjMNa/5Zj8hDO6K++GyGmb86
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(8936002)(8676002)(66476007)(66556008)(4326008)(66946007)(41300700001)(6916009)(316002)(6506007)(53546011)(186003)(6512007)(26005)(2616005)(478600001)(54906003)(6666004)(6486002)(2906002)(5660300002)(38100700002)(36756003)(31696002)(86362001)(31686004)(83380400001)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFJnNGpManVEQ1dLb3RPY3NIYnYwVUc2by9pWmlwVEVMNzJPVDBPd3hJYUdp?=
 =?utf-8?B?aG5MZXVJQ0craUdVVXFranZ0TmJPNC94WTBadlJLa1lsNVl5QkV1Z2E5QXR6?=
 =?utf-8?B?NFVaOUhPQXA0d28yaUh3L3h0dWZqNXpjcGJ3Q0dlNi80Znd1ZUtSaTB4T1Fz?=
 =?utf-8?B?aWMxMEp4N0UzR1NpK1JabGFuVkprYlMrK1l0OEl6QW0rRXNFcnhqdzBtZUlW?=
 =?utf-8?B?TjBXeHdpVFNLemJNL3Z3Ui80UkZUSjFtWllUUnB2L2IwUXU2U0hUSFRtL3F3?=
 =?utf-8?B?dWJ3eGsvY3N0bXN4OUpENWVJRjdZZUtVbWxJTDljN3hTTnplTGh6bTJ0QmVL?=
 =?utf-8?B?dEF0cWRzYkNFc0lPM2dwQmpSTHRKeHdMWjBwanJtYXZaL0hwQzNmc0dtdm5a?=
 =?utf-8?B?MDVSUk1wRmNuN1AyNFdWRi9wajZ0OThtOEk2K2J1YktFRjdZWUtJelRwc3gz?=
 =?utf-8?B?WWVRRWZnSllkVDU5dm1FL3ltYUpERzYzaXRiZHNXc3BBUEpIeFV1S0NFR0dD?=
 =?utf-8?B?bEtjWlFPQ1JPWUt6WGJYZUdQQklYY1ZjRjA5OXAvckZvTmhJS3NKMjVlOEVv?=
 =?utf-8?B?ZVNrYXg4UUt1SFIydURBQW5pbEp6bjdMVjJrQjBmNWVZUnNHb1NCeC8wcTNB?=
 =?utf-8?B?Tlp1Q2Q5aVNpWDFhWTBYZEJteEUwb3RaemtoQU1PZ09TaTZaSWdsaGJSVnZV?=
 =?utf-8?B?Z2lGczhnMzlWUU1xWTJYc2ZENHlxUEJ3cFl1ZXdsbHhKeFRuK3kvN0RJcU96?=
 =?utf-8?B?MFAwRGowTlNXSXE0US9uMkFZdEt5MFJQKzF5M3lUZ004T3laSU9lTk10c3Fx?=
 =?utf-8?B?ZVh3L0VvRmpCeEhzYk50TWtieGh0ZUtRUXhvR01rTFhmWXM0ZTFpMk9WOUtq?=
 =?utf-8?B?ZTNqRGtGVmhQaWFOa2FQK09VQ2M3QUJweUlLd3Q3TmRISUxrSU02YkllbGpN?=
 =?utf-8?B?eUFJSHdVd1poQnowcXlKVUs4dlFrcDJla0J6ZXV6U2NJZHhlU2JjK0l0KzRm?=
 =?utf-8?B?enloejdLZkdTUVF5d1ljeG0yalg0MXFqc045Qml3VG83T1p3YXQ5blVCN1ZK?=
 =?utf-8?B?M0d6d0lxdGdRdVNnQ0krSkVzQUUyLzB3bitJMFVwR0NmVEJ6L25lRHNhTjdz?=
 =?utf-8?B?VHpWVWlIdml2cWd1ZEo3VUtVS2ZsQ3pBUzBSUXdDOEZTZ0c5amtPeXkwaTZW?=
 =?utf-8?B?Z0hrT0RlZ0YxaHdKb2dLNUVhT1o2UzNPVVFCQmpXOHQwTm11VlpXV1ZSdjRZ?=
 =?utf-8?B?VXdFaUxqR1FMNUdqS2dZNWF5WnVkRVVCVmFqYkQwSGdwaWNydjZzMkUzM3JM?=
 =?utf-8?B?MksyNTU4aGUvWXZ1di9nbG5KbXYrTkw5cjRCdTZRQ08zUDR4TThmV3U0MWRL?=
 =?utf-8?B?NEd1ZFZreWRYVkRwMXU1OFoxdS9CTXA4T0NVd2M5cFUwVXNqTHd3Z0ZUbm5D?=
 =?utf-8?B?TzdrbVp0RFR1WmVYNHF4TkNIRGFmUUJ4MEtzR3ZDR01vcFBtUHpDWmpmZllt?=
 =?utf-8?B?aU9aTEQ5TllqcXlRWkRGU1lYSEhFcHhoa2xyTUNEMFZIbEh3ZWJnb1lLNzJT?=
 =?utf-8?B?dDJHcFFYUjJSZTlMUWlNTStSU01TNWxuaWtHU3JFRDk4QzdjbkQ5c09DYnlZ?=
 =?utf-8?B?azhoRmlIUkhreFRzQU1GV01mZFZJbkNkOXRqa0gxTkFTU3lsSUVsL0ZNZlNH?=
 =?utf-8?B?c01SbXoyRzZiZW1OTFRjTU9qd0tDckFucDI4Sks4bnBCWlJEMFM2MENFYVRW?=
 =?utf-8?B?SXk5TkJiOW5YRURDdk1KQVhuLzMrRlI0K1p6dHN6d0IyTHl3ZW92NHNKRURm?=
 =?utf-8?B?MzhuUytwYUNOM2RIZHlHbVZlNWY4cEtYaFgvbHZ1ZFJkUGdaQktQZmp0NDVH?=
 =?utf-8?B?MDIwWHUwWW4vMXUrK1hHYXVIZkJ0ZXM2WVM3THJ0KzdOck1IQ2llQ2NDUGh6?=
 =?utf-8?B?NDJKVTdzUVlCT2loMXNCL1R0WVJHMXZubXNPcjNDbUlSM3QwQjZFellQaTB0?=
 =?utf-8?B?SVMxN3FjcnhickR4SUYxT1ZqK2tRMEZmcmE2QlJiNGN2bkRCU3VVcERHS08v?=
 =?utf-8?B?VDM0aVE2cUhETFpDbGN3ZE8xSWVzWjRWZXIvbVpYNWZIaTEzblc2WTA0OWUx?=
 =?utf-8?B?dk5HemZUWVlPWDNRNkMyVVRVcGZiM0tpblZXaXBielZqb0laMW1PdEtFcVFF?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OgaeVnzw2gvDd872y8dD8FqIY7Edrug/z2MB9XkNUjfGCJu3JSQog7uh9bB92vGKdlWWj7JpzfcAbRi/MPORQ0YS/iINlgJjnDxhmofkFfJk6ZVFLdoIaRgyHuWqGRo7q13zcKOOepWlK4d47+7/aFVm5z0QClitdRf4FiiP9um/YctbYRua8uIKqC6IFkuzOc+eeJ+X+s2083hELOE8h6Yc2B8SMv0Oo4DgvCsUjtH5kL2sdjoxm09agAyRn9XfwL9qVzW2JMs/iyQeRXCmz7Cs9gO+wZYmi4OYAh/IvuHhMMj2RryzqFXOhpl2WeExUJyiqxLUurtjU3Uo65J5nU23/jiJIs28KIBzylaFgynnVelK5z5V0DxjZwvBphloc927464Q92OIX2+TD8IRdMFRVv1LMmuwpYmr/u9TAM82MNp91q504sBEyc59PubAsPOTNOwZgy8HUxMIOLAS54a0gxCMo53BdO2VddPVxbZAh6huaFDTVJl7VKV3KpRMU7kp/P6vnaH9pax4G/s0cKulKI6JuqdsTipQ0xeATssIIqC7Fu9wdq88C6aK7nYgk37ce4jKaY2zqmcNhnQNo8pCkJfoRxn47g4IAqcUtWqzoQjwuzqiPKtR1fSsC3sVe8c+U75Uj5nEuu3CWSGR31BQ4xcX11kT59zn/+IqKslexrRwINa7z1oRwvVBpHMt8V1+aCfF51OW/U0ODramk5wz/ih7jiMSedNs7xjq7/yhExuZ6Oc7po96tp1VRdcBqe0NWnbMRpH8hWPpj0Zjf10gkXRM2ONUakQcdC9YTUlFbULW9o9vkK66vSnfs7pjlokBguugf8Ihz+AXJBlDUw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed77bd5-1171-4f31-ec94-08db762d2db5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 10:07:41.7277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3fuqZv6nx0IyEU3f2bB9PL/X1rQsvecTmMjuwmfz18Wb6ftvp/sI28KydddTYTRJf8mDFrYASwVPD6qg6+kh1Rm6rrWfFRILUrUds3Bmgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_06,2023-06-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260091
X-Proofpoint-ORIG-GUID: Zx5mTSzoZau9CoL5rdQ84cpPcDV_FE-m
X-Proofpoint-GUID: Zx5mTSzoZau9CoL5rdQ84cpPcDV_FE-m
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 26/06/2023 08:02, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Duan, Zhenzhong
>> Sent: Sunday, June 25, 2023 2:01 PM
>> To: Joao Martins <joao.m.martins@oracle.com>
>> Cc: alex.williamson@redhat.com; clg@redhat.com; qemu-devel@nongnu.org;
>> avihaih@nvidia.com; Peng, Chao P <chao.p.peng@intel.com>
>> Subject: RE: [PATCH v3 1/3] vfio/pci: Fix resource leak in vfio_realize
>>
>>> -----Original Message-----
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>> Sent: Wednesday, June 21, 2023 7:08 PM
>>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>> Cc: alex.williamson@redhat.com; clg@redhat.com; qemu-
>> devel@nongnu.org;
>>> avihaih@nvidia.com; Peng, Chao P <chao.p.peng@intel.com>
>>> Subject: Re: [PATCH v3 1/3] vfio/pci: Fix resource leak in vfio_realize
>>>
>>>
>>>
>>> On 21/06/2023 09:02, Zhenzhong Duan wrote:
>>>> When adding migration blocker failed in vfio_migration_realize(),
>>>> hotplug will fail and we see below:
>>>>
>>>> (qemu) device_add
>>>> vfio-pci,host=81:11.1,id=vfio1,bus=root1,x-enable-migration=true
>>>> 0000:81:11.1: VFIO migration is not supported in kernel
>>>> Error: disallowing migration blocker (--only-migratable) for: VFIO
>>>> device doesn't support migration
>>>>
>>>> If we hotplug again we should see same log as above, but we see:
>>>> (qemu) device_add
>>>> vfio-pci,host=81:11.0,id=vfio0,bus=root0,x-enable-migration=true
>>>> Error: vfio 0000:81:11.0: device is already attached
>>>>
>>>> That's because some references to VFIO device isn't released, we
>>>> should check return value of vfio_migration_realize() and release the
>>>> references, then VFIO device will be truely released when hotplug
>>>> failed.
>>>>
>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> ---
>>>>  hw/vfio/pci.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index
>>>> 73874a94de12..c71b0955d81c 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -3210,6 +3210,7 @@ static void vfio_realize(PCIDevice *pdev, Error
>>> **errp)
>>>>          ret = vfio_migration_realize(vbasedev, errp);
>>>>          if (ret) {
>>>>              error_report("%s: Migration disabled", vbasedev->name);
>>>> +            goto out_deregister;
>>>>          }
>>>>      }
>>>>
>>> This doesn't look right. This means that failure to support migration
>>> will deregister the device.
>>
>> In my understanding, failure to support migration but success to add
>> migration blocker will not deregister device. vfio_migration_realize() is
>> successful in this case.
>> But failure to add migration blocker should deregister device, because
>> vfio_exitfn() is never called in this case(errp set), jumping to out_deregister is
>> the best choice. Then vfio_migration_realize() should return failure in this
>> case.
> 

I was checking other devices in the tree, and I think you are right. Failure to
add the migration blocker results in a failure of device realize. Which IIUC
only happens in 'only-migratable' setups and during snapshots.

Maybe also including a sentence explainer in the commit message is useful too.

> I just realized the error path in vfio_realize() isn't adequate. We need to add more deregister code just as vfio_exitfn(), see below. I'll re-post after we are consensus on this and get some comments of PATCH3.
> 
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3210,7 +3210,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          ret = vfio_migration_realize(vbasedev, errp);
>          if (ret) {
>              error_report("%s: Migration disabled", vbasedev->name);
> -            goto out_deregister;
> +            goto out_vfio_migration;
>          }
>      }
> 
> @@ -3220,11 +3220,17 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
> 
>      return;
> 
> +out_vfio_migration:
> +    vfio_migration_exit(vbasedev);

This belongs in this patch from the looks

>  out_deregister:
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
>      if (vdev->irqchip_change_notifier.notify) {
>          kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
>      }
> +    vfio_disable_interrupts(vdev);
> +    if (vdev->intx.mmap_timer) {
> +        timer_free(vdev->intx.mmap_timer);
> +    }

But this one suggests another one as it looks a pre-existing issue?

>  out_teardown:
>      vfio_teardown_msi(vdev);
>      vfio_bars_exit(vdev);
> 
> Thanks
> Zhenzhong

