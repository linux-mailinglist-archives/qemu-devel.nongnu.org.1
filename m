Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FBA7A5345
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 21:49:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiKDw-0006cn-Or; Mon, 18 Sep 2023 15:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qiKDs-0006cZ-0k
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 15:47:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qiKDo-0007ZJ-UY
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 15:47:54 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38II1IPP010136; Mon, 18 Sep 2023 19:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=fQnl2ARBMF07LDxMrpMS/CW3tZn5mZLKThlf3IhNU5s=;
 b=BMT557LhXG8UfkpL6i61dhd52NjvuAlHVw23VKNAyrcwp9Tf5k5f6RlXr1x8pA4yG6Ru
 ycmJGAB5STyIzfUpa9HTDuTr6Uhp0ydg3xieDYfxEhGVpU8UUTv/UjLkNolnOQsBUqoH
 eiwLsmoMISP0I7v4q19P+qN/cHMyaEpOIAWqJWbqNo4InNUhX8T9jSW1YFavkM75pvJ6
 Qh3QnM1TIeeg9PaJKm6O6uuE6tRg6MnlswD8UQv7CFbKaOBm6qYLY1RgP7IJczAW8o5d
 +1FNcKP9K4waJhkSbf9C3E/sEfRaqeHUwCwmS7d6AQ/DAvnKYoACJHe9Hd0L6Y7xWR1M Jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t5352ue84-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Sep 2023 19:47:25 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38IJkn3t012084; Mon, 18 Sep 2023 19:47:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t52t4y9dc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Sep 2023 19:47:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MN4jsW6JAUJQmc3IpsXMB8QH5TggjyK8zPwQ2ImVoxY+CUp1a4nYHL/suvkPFqGCnCVlfJWwLeKDL+kFeoSVxaxZF6cFaC/gSdkllaeuFrCiBILtoDv2aYkFXBPU6C2PXM/JCEvLsACgykh7fvckecRJ1jQWVka0/7wU+7JbkgYURJIUkC/1pFQ2AYl6rMI14EMv0hkdFRi3SzF0UwvUeoZF5/zSL/fVIT06jEwd+37akwYx5SzVFY0CEof4h8+cxYjsnL1ZBagH1SJpkhyTC9WvsTDTgKil9kGq2eDHlLgCx5XNJmxzzda9Hvrwp/xH2bc04fcReRY5H4JHmLyD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQnl2ARBMF07LDxMrpMS/CW3tZn5mZLKThlf3IhNU5s=;
 b=l0uv8ZnksQmNiQu3tVgckmF2zlvuTWtoLsjTNuaYdyZGFcVStAF6J49rUxVVVj+Nkh33MpAkmig+/UNs10IXq8iVgbE6wd+R7dFgYEsRDNxn40gbvgDMqhZhuf3Q2GJT69FacS3stYNYcriIjjT4MOrkKakQmpfTxsARmDhwOLiyOn/YbjoX5mwSu3RESNnagTTea35idBoGSRuC8UGiNmA6GZ+e4fNfKABToVMNNbeZNX/gzNYTi0bmqKeETbH0WxC8h0hpviHY0e47N3lKcWpG2Xa2GMm+2YcicPF2Bi8qz+P8FNWxz7adBjI3ffeUQIXzU44vGAWxbABVYhrLlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQnl2ARBMF07LDxMrpMS/CW3tZn5mZLKThlf3IhNU5s=;
 b=mrgF/QyNpvPW/6d4/Wz1L+hPvXn39arzBK8y6ai3llhUcgI3XUZY1E2r3Np29uk+j6yJ8p9mm1zgwXPSDAPt2AA5Ii/t/aVMGf/kmGKLgkrKEUI+Weacf7iZ3lOqb6spGY01jQT0tU2Jqo5mlSKkL5Qj1U1RB90UA/SaH4hVHYk=
Received: from BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17)
 by CY8PR10MB6515.namprd10.prod.outlook.com (2603:10b6:930:5d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Mon, 18 Sep
 2023 19:47:22 +0000
Received: from BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798]) by BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 19:47:21 +0000
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Juan Quintela <juan.quintela@gmail.com>, "f4bug@amsat.org"
 <f4bug@amsat.org>, Joao Martins <joao.m.martins@oracle.com>, Juan Quintela
 <quintela@redhat.com>, "mdean@redhat.com" <mdean@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>, "afaerber@suse.de"
 <afaerber@suse.de>, "bazulay@redhat.com" <bazulay@redhat.com>,
 "bbauman@redhat.com" <bbauman@redhat.com>, "cw@f00f.org" <cw@f00f.org>,
 "dustin.kirkland@canonical.com" <dustin.kirkland@canonical.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "iggy@theiggy.com" <iggy@theiggy.com>, "jan.kiszka@web.de"
 <jan.kiszka@web.de>, "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>,
 "jjherne@linux.vnet.ibm.com" <jjherne@linux.vnet.ibm.com>,
 "mimu@linux.vnet.ibm.com" <mimu@linux.vnet.ibm.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "imp@bsdimp.com" <imp@bsdimp.com>, "z.huo@139.com" <z.huo@139.com>,
 "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 David Edmondson <david.edmondson@oracle.com>, Konrad Wilk
 <konrad.wilk@oracle.com>,
 Alessandro Di Federico <ale@rev.ng>, "anjo@rev.ng" <anjo@rev.ng>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "wei.w.wang@intel.com"
 <wei.w.wang@intel.com>, "chao.p.peng@linux.intel.com"
 <chao.p.peng@linux.intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Mark Burton <mburton@qti.qualcomm.com>
Subject: Re: Call for agenda for 2023-09-19 QEMU developers call
Thread-Topic: Call for agenda for 2023-09-19 QEMU developers call
Thread-Index: AQHZ57EPVJ85Tc9zX0KPjy8CvzJ1qLAgwTBt
Date: Mon, 18 Sep 2023 19:47:21 +0000
Message-ID: <BYAPR10MB286984E6DDD6D4C2C915CAAE8CFBA@BYAPR10MB2869.namprd10.prod.outlook.com>
References: <CALUyDQ5Tcby25VQ05REYXsv8v_MO-nVcsHcrQWEAJefPArCoXA@mail.gmail.com>
In-Reply-To: <CALUyDQ5Tcby25VQ05REYXsv8v_MO-nVcsHcrQWEAJefPArCoXA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR10MB2869:EE_|CY8PR10MB6515:EE_
x-ms-office365-filtering-correlation-id: f621ade4-89c0-4b5e-50b1-08dbb8801316
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 47M8GN8X4RuHF1UMRFLoncoMG4m4g9YEC8m8u1phjXvnTcU0KUpJifu3eHPKynMkNhLgRCyC4FsGef+wPa7Qi3D0DXxTSjqdbObs9qRsRcB4qZe/tyROohJYehDxcVtZP3Nyp/bkd/iKyH6wKueu30cNN7kZxXS7Fr/BAQzP4miaWyeDAJYQn5t9f/N0j4MT5vqidx7W/6IyaNtWmcn7r/7FR0pDKroQdvMBGNFnLcl2GF2OMQ580E+cIkUu/Ttj12diRtQG9FIco55kSaZAwtXWAlthMBpb+HKIPr+TnhbAryLBbRa3THodwN+MPGV4/FCUHYojqnODoSNC5smSX7ON9MT5Ipf+u80iMm4FsbgNMwRpDvKWLfo08RRVRa6CFP/xtRdrEOxWjupTl9NDCLJ7neC/ntivl0KuQGvQZqBU9cPfkWdlbjh5rDGYe8+3fIBncdUtw90y7wR8gnYe75uBqLhOl31Xf2k9UeuUPg+annF/y+hH50ThccGZiWODS72dg8ch9WsZs8PKAv2JbE/Bznv0jGI/N4m/+NbwwhUtgHoJ6hcShCYV9pKsfqHMEY6gYHKIeCnxmTUL2XKTv5SOWIf/pj5Lcof5oAelE18M3WEnq7FYFsYzAuJ+dlAD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2869.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(1800799009)(186009)(451199024)(316002)(41300700001)(8676002)(8936002)(83380400001)(9686003)(55016003)(26005)(7696005)(6506007)(478600001)(53546011)(71200400001)(122000001)(38100700002)(86362001)(38070700005)(921005)(33656002)(66446008)(64756008)(66476007)(66556008)(66946007)(110136005)(76116006)(2906002)(19627405001)(44832011)(5660300002)(52536014)(7416002)(7406005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2BzsvRqUGMkoncHbsWE4/Dqurj5vVIeXUcgK/4tchXbAdFWUTk94B06fOkRn?=
 =?us-ascii?Q?enZPdWqY42HMSFBpOMQpl6Vdn50HzMNDkIHAk9GTeCW5/xeDnIcM+DBE69+g?=
 =?us-ascii?Q?LcGrO0M4iKe/tDziGlK4O2zfA2CLtZHvy6YqHCJS2nLHtnohXzGWuZfrJIKD?=
 =?us-ascii?Q?RqEap+5wE3fzWCriXd8UuSTwd6fHUAFj6y20rBODSBLrDDOJtu+c9o/BmO5S?=
 =?us-ascii?Q?PhN3k6JnU1AHjtkCSIpMdRqxXF6qMksse8+7pijKbA4cxNVcfO8RmrZjSmdr?=
 =?us-ascii?Q?ycWpUuPOyzU7B1gyTscTfjcnZuJn7R1cgGMENKSF0gVXRxMKAxbyWiXvyIa2?=
 =?us-ascii?Q?lpYMQTPEN8QzaIQO2svFBlWtIB+L7dZnpSxz6P+bTT1MGAOAwSOyvbBJVAdW?=
 =?us-ascii?Q?LvhVZbMIw128F7nY6PrEiZpvXJLs1ReIefQpGidi46k39WQPRlj0ufg5Jeyt?=
 =?us-ascii?Q?gn9PNUSJcADnQmpm1nqF30JYE44nPizd6k+kk3o6VItYrLLIgTBCeeETdv9x?=
 =?us-ascii?Q?Cv99NZGHzzke6enFOZbewjsPIa7QMwQZxMRMd8JT/BKYUAzsUnehB34bI5eH?=
 =?us-ascii?Q?2+zl6kMXHJhN9buslNgSrQgN5tyrGtgoXZuLUSWnldx/pL/jVusGH6VB07Aa?=
 =?us-ascii?Q?ITqqXIVSG8KIsiSbZVAfR6mIQXl4lpvvrHi3rKrhhOwc4Xs7lZ255d2SGAl3?=
 =?us-ascii?Q?p/xqpDG7fQ75MUVDblS1lgr39/tsQdmR6WiNMXxrLUKLBfLVsxdmGPiuIyzj?=
 =?us-ascii?Q?eEqH2VnJ1wp4+z26Dz7ZB4VuWz8e7FS0EFrBeCAEDHaCVRmWaiHSX8WwWt4a?=
 =?us-ascii?Q?iayS+0tos0Rl56oktn6JLvAVlI2R0og46hglXbpeQmF6moWkfDkUX4alMWa3?=
 =?us-ascii?Q?ZiZGRJs7q7iJM6vh7LMCJxt1u3xyvXi9P4IHQsN8PmR3K4pTKAL634I6MX/i?=
 =?us-ascii?Q?jS+6C9wBSzwwhpVo1ODIrh8d3+zqA1qC+/7FdPqzQilmp7Dq4FQwh2AQK395?=
 =?us-ascii?Q?dH+JPru3VqMhfQRNQoLKy5ETNUOpCPXeOP0ntmQ/ZM1jzKy9biAvMfWf4KWN?=
 =?us-ascii?Q?fgLF+BPz7QCGYmBvtHymhnu3fTpQfy2g/6BLM9QxO5pgx7xusInG4jH53m/J?=
 =?us-ascii?Q?j4sJmXgz2Me9NAwq0lM5zF/f/jUHYtL3BjEau+twnbe6e2Gum7TB1yu9L+uG?=
 =?us-ascii?Q?4bN01rjB5+h/Hy8t/42chMhL6s2ODw6OwX9143bJPyQNZ8nNlIOHyo5V01qn?=
 =?us-ascii?Q?6Ih6MR7dlhgBXEZDZi7ehyO66vW3Ov/oqbmchDK6MalQXzFBvqgD875NBkVI?=
 =?us-ascii?Q?DZVp5nPw0EgUo6JQBkCGQYXvNc5fQHEk2hSL6e7NBgAdsVaPeMgwA26vpYyV?=
 =?us-ascii?Q?2xqp3a72eWNfVEMQ21rtsOWOXNbkAmpehUgP6b4eKK525Lk6qKi8zabw9XSB?=
 =?us-ascii?Q?aREYCd9CvD1QQm/qkVXBN3Arm1afAXy5XNavbTjPRm4pGw7N7OG+pajUS2qj?=
 =?us-ascii?Q?NoFfLOwQIefTOofpC0bFv4TuuVGxTTG237QeJW8qKqEe+pAzeb9tmEeYPBRn?=
 =?us-ascii?Q?nFlldlOBXj2ZrmHR+zTwUOgpbN5HWH6mSyeW1BD7?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR10MB286984E6DDD6D4C2C915CAAE8CFBABYAPR10MB2869namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vWO7sCVp+yqUUlUzjCJZIoTTanQW5x6/saIfVvL5ubJYQHSpGF2tL/a1p5Sx?=
 =?us-ascii?Q?7JY1qp9S4Kt7/3MtEVpVnEEYwX75XiRs9ZcXy8nj4XBZ/OpOdhuypkkXhLXp?=
 =?us-ascii?Q?I8AxLAHHMyk0u2AIzeogUnQp++qJu8dyjV2NdsFeGecq+BeuYCjIpi9zbL+a?=
 =?us-ascii?Q?Nnv1unL39pSeFHL0sYTmTxyOot6p2NTd3KuAKkkDQIVvwfzdc5l7ZU9pGZ+9?=
 =?us-ascii?Q?qRGBT1858wjY5ceeKDr3Tm1PeOLSOZpFruODepIWKWalZfK8BdJcQ206rb8u?=
 =?us-ascii?Q?lR8JCKrmSWvfU6jQBFJLF9bHsTlb1tCy5fDWgHEduifi3GMTO+9Japm9m1uk?=
 =?us-ascii?Q?LF9oSC3bJzrrjup8OT4XP/kAf9BbSeKDIM41nEHaSEJz/ie94kr93L6zcNZU?=
 =?us-ascii?Q?fp53z4l332ztPj/8aJd0svtO6aqqWgkcYyqb64msqDInWQccDtxPERzAWcRO?=
 =?us-ascii?Q?CwhFJClJdoJ9heR7FVeQ0f9Te9wbGjGqDLtw4YKEPFGTk44NV5XWJMGsPD0a?=
 =?us-ascii?Q?kWQPfPObmxmIAJ/0FN8IfrPfhRv6X+lugQqk9FL7JYXlMkZU77jkvXy0V9Zv?=
 =?us-ascii?Q?pTw2CgbaH8BGPorzil9LwAZPZ8fw3alHGzjOga738OhNwf6tbCiF6l7T6lfb?=
 =?us-ascii?Q?B0nMT9a2pB1bOsqpBy3AX2eqr86ONnGgBlDgmgWyHx+0YS3ZcZcGvDdeVjm3?=
 =?us-ascii?Q?s/lcxZhgRNGmyYHNSZ6R/4pyJYTxdGizgHu3TKDCo0tqHvmalFzkMZaM8i9l?=
 =?us-ascii?Q?tFsZDmrZOKo4MP3mJ1AkejrOs8ATHmyAv/L98uT2/Nv1v7ptaHtDl8K/u5Q9?=
 =?us-ascii?Q?gYxobsbE9ZpnuUKmQrZuEihdYZCZzQSxYNt8ubJTSS5Z9HkQoP0Y+sSBxzmb?=
 =?us-ascii?Q?hJHOwTxeJvzHdu2ujDn2HmAruVp4qRqIa/miIyOO98VKb6+5bcD6XmHi2Jda?=
 =?us-ascii?Q?c0cMWoA/UcIncc9nWttl1C0tgyZAFvRYnli++TJvc13zeWtDuwbRGrCJbz6q?=
 =?us-ascii?Q?yfComdCb+DkzByahrX7fzKNOcXv3CUwX4f830LbgIRAOKapiRhTd4lF8n0TM?=
 =?us-ascii?Q?Uf9WyzE/8I+cIXgOaYNpsy2zVE4zT2P716Hh+0uVQiCxIPyetWsmItV614Yk?=
 =?us-ascii?Q?AN2dNC8JZhITGVEzVeZ4vvlMGh4iyqsIfAeC+6rgK5j9Eo6SJJNww05bZ739?=
 =?us-ascii?Q?Y/xcSRBBPMhvDWO8jIgqvE6gfc8jiMZFsolH/PMPxtp5IB3YH/CiLlm5Ie42?=
 =?us-ascii?Q?xKYtvBsIjsKgaFZIehGPp7FlbyY3oTk3jWv36Rg5I8OcedjSMfV6MMnbvBzr?=
 =?us-ascii?Q?2j3c8bb9XUdky2wkVAUk5uIX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2869.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f621ade4-89c0-4b5e-50b1-08dbb8801316
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 19:47:21.8035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aLaodtZb7UkKp9Uj7t/SYrdy2U1VcaYAKfp5huxYs4DZ20iDBlXzKrHqTWA1o7Ap83RInpFQ/eTq9ueWM9uo8UOXqKgOA3qc6dJYrbdYVn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_08,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180174
X-Proofpoint-ORIG-GUID: 5xzOYaZkdfi02TNBB0JjU2NVggI_zbFj
X-Proofpoint-GUID: 5xzOYaZkdfi02TNBB0JjU2NVggI_zbFj
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=elena.ufimtseva@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--_000_BYAPR10MB286984E6DDD6D4C2C915CAAE8CFBABYAPR10MB2869namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Juan,

Not sure if this is worth its own topic, would be it possible to hear the c=
ommunity thoughts on the live migration series review/pull progress (atomic=
s, zero page multifd etc.. )? Seems like there are few outstanding relevant=
 patches.


Thank you!
________________________________
From: Juan Quintela <juan.quintela@gmail.com>
Sent: Friday, September 15, 2023 1:45 AM
To: f4bug@amsat.org <f4bug@amsat.org>; Joao Martins <joao.m.martins@oracle.=
com>; Juan Quintela <quintela@redhat.com>; mdean@redhat.com <mdean@redhat.c=
om>; felipe@nutanix.com <felipe@nutanix.com>; afaerber@suse.de <afaerber@su=
se.de>; bazulay@redhat.com <bazulay@redhat.com>; bbauman@redhat.com <bbauma=
n@redhat.com>; cw@f00f.org <cw@f00f.org>; dustin.kirkland@canonical.com <du=
stin.kirkland@canonical.com>; eblake@redhat.com <eblake@redhat.com>; edgar.=
iglesias@gmail.com <edgar.iglesias@gmail.com>; eric.auger@redhat.com <eric.=
auger@redhat.com>; iggy@theiggy.com <iggy@theiggy.com>; jan.kiszka@web.de <=
jan.kiszka@web.de>; jidong.xiao@gmail.com <jidong.xiao@gmail.com>; jjherne@=
linux.vnet.ibm.com <jjherne@linux.vnet.ibm.com>; mimu@linux.vnet.ibm.com <m=
imu@linux.vnet.ibm.com>; peter.maydell@linaro.org <peter.maydell@linaro.org=
>; richard.henderson@linaro.org <richard.henderson@linaro.org>; stefanha@gm=
ail.com <stefanha@gmail.com>; imp@bsdimp.com <imp@bsdimp.com>; z.huo@139.co=
m <z.huo@139.com>; zwu.kernel@gmail.com <zwu.kernel@gmail.com>; jgg@nvidia.=
com <jgg@nvidia.com>; cjia@nvidia.com <cjia@nvidia.com>; David Edmondson <d=
avid.edmondson@oracle.com>; Elena Ufimtseva <elena.ufimtseva@oracle.com>; K=
onrad Wilk <konrad.wilk@oracle.com>; Alessandro Di Federico <ale@rev.ng>; a=
njo@rev.ng <anjo@rev.ng>; shameerali.kolothum.thodi@huawei.com <shameerali.=
kolothum.thodi@huawei.com>; wei.w.wang@intel.com <wei.w.wang@intel.com>; ch=
ao.p.peng@linux.intel.com <chao.p.peng@linux.intel.com>; qemu-devel@nongnu.=
org <qemu-devel@nongnu.org>; Mark Burton <mburton@qti.qualcomm.com>
Subject: Call for agenda for 2023-09-19 QEMU developers call

Hi

If you have any topics, please add to this email.

Thanks, Juan.

--_000_BYAPR10MB286984E6DDD6D4C2C915CAAE8CFBABYAPR10MB2869namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hello Juan,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Not sure if this is worth its own topic, would be it possible to hear the c=
ommunity thoughts on the live migration series review/pull progress (atomic=
s, zero page multifd etc.. )? Seems like there are few outstanding relevant=
 patches.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thank you!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Juan Quintela &lt;jua=
n.quintela@gmail.com&gt;<br>
<b>Sent:</b> Friday, September 15, 2023 1:45 AM<br>
<b>To:</b> f4bug@amsat.org &lt;f4bug@amsat.org&gt;; Joao Martins &lt;joao.m=
.martins@oracle.com&gt;; Juan Quintela &lt;quintela@redhat.com&gt;; mdean@r=
edhat.com &lt;mdean@redhat.com&gt;; felipe@nutanix.com &lt;felipe@nutanix.c=
om&gt;; afaerber@suse.de &lt;afaerber@suse.de&gt;; bazulay@redhat.com
 &lt;bazulay@redhat.com&gt;; bbauman@redhat.com &lt;bbauman@redhat.com&gt;;=
 cw@f00f.org &lt;cw@f00f.org&gt;; dustin.kirkland@canonical.com &lt;dustin.=
kirkland@canonical.com&gt;; eblake@redhat.com &lt;eblake@redhat.com&gt;; ed=
gar.iglesias@gmail.com &lt;edgar.iglesias@gmail.com&gt;; eric.auger@redhat.=
com
 &lt;eric.auger@redhat.com&gt;; iggy@theiggy.com &lt;iggy@theiggy.com&gt;; =
jan.kiszka@web.de &lt;jan.kiszka@web.de&gt;; jidong.xiao@gmail.com &lt;jido=
ng.xiao@gmail.com&gt;; jjherne@linux.vnet.ibm.com &lt;jjherne@linux.vnet.ib=
m.com&gt;; mimu@linux.vnet.ibm.com &lt;mimu@linux.vnet.ibm.com&gt;;
 peter.maydell@linaro.org &lt;peter.maydell@linaro.org&gt;; richard.henders=
on@linaro.org &lt;richard.henderson@linaro.org&gt;; stefanha@gmail.com &lt;=
stefanha@gmail.com&gt;; imp@bsdimp.com &lt;imp@bsdimp.com&gt;; z.huo@139.co=
m &lt;z.huo@139.com&gt;; zwu.kernel@gmail.com &lt;zwu.kernel@gmail.com&gt;;
 jgg@nvidia.com &lt;jgg@nvidia.com&gt;; cjia@nvidia.com &lt;cjia@nvidia.com=
&gt;; David Edmondson &lt;david.edmondson@oracle.com&gt;; Elena Ufimtseva &=
lt;elena.ufimtseva@oracle.com&gt;; Konrad Wilk &lt;konrad.wilk@oracle.com&g=
t;; Alessandro Di Federico &lt;ale@rev.ng&gt;; anjo@rev.ng &lt;anjo@rev.ng&=
gt;;
 shameerali.kolothum.thodi@huawei.com &lt;shameerali.kolothum.thodi@huawei.=
com&gt;; wei.w.wang@intel.com &lt;wei.w.wang@intel.com&gt;; chao.p.peng@lin=
ux.intel.com &lt;chao.p.peng@linux.intel.com&gt;; qemu-devel@nongnu.org &lt=
;qemu-devel@nongnu.org&gt;; Mark Burton &lt;mburton@qti.qualcomm.com&gt;<br=
>
<b>Subject:</b> Call for agenda for 2023-09-19 QEMU developers call</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"auto">Hi
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">If you have any topics, please add to this email.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Thanks, Juan.</div>
</div>
</div>
</body>
</html>

--_000_BYAPR10MB286984E6DDD6D4C2C915CAAE8CFBABYAPR10MB2869namp_--

