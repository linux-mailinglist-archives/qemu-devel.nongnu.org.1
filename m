Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C727A5879
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 06:45:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiSbg-0006s8-Hk; Tue, 19 Sep 2023 00:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qiSbZ-0006rK-NF
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 00:44:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qiSbW-0005wq-J4
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 00:44:56 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38IK3xEn031273; Tue, 19 Sep 2023 04:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=s5eX9mmkOLxLJoVQDaMMh8ssR8q8kF+RkKsX/tTpcck=;
 b=QTAUX85aAZ+97Gg0iZ9WUrFWiYesCFItuig0ywbVJ+gSNZJheaaccy/OD5DgqyTUfe/z
 jFX3wMWjK3Y0HmkvBpImRDE3BXNdAxO+ZHvtmxobKnr3dAEkoS1LH+bh1QPzopiHAsEZ
 nHSs3xazaz6YkwEyfkXpKLviECoD9ysRGr0gnAPfQaMDRI+vwBppsmM6kOvgTZVTOCf+
 iadMRVD0yb7xH2aGo8Qc9NXBhMDKAwS9ayfsRKocCOb+Yy6dRTa43I0Vo6+sU3cY4Ive
 qRJTaiuNAxO/NmoRGrSJZsA5L7f2joWS+xNDzz0W0RaDDwkH3c5OokQR0tvg+y8jPXPs ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t5352v1tv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 04:44:32 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38J4TImL012197; Tue, 19 Sep 2023 04:44:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t52t5cvnb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 04:44:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxADUbwz4NcP73vTnvoqSFm538ev6dtPr+gDlaC/LLHDUUWFtEuGAL3ZJVVMRcjUFCqdTdXyh1nsIjyKpIr7Qcu2UHk1uFvl+8mYsIi3o+1aJmvcRoFsSO2S9YSjymZp+uZv26rZEwbf4B7Yr8UNj4Q+tUarxHUOLh0DHvZByt3RFeFMq9exDRxE8r3MyuXR0N+ZKm28tqx2zEcXNfLQf2Hgl8bnNxZmVD2/ktMX+fqlE3xixfCwjtGGYmDLRBAzyUjxH6Qa/bJghNUqDY/AuyctALRXC0ICYWxX0BCrseZ+0z6gODQ52W6FU51eP5gQrbTGojxAF5Xro/8wElCHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5eX9mmkOLxLJoVQDaMMh8ssR8q8kF+RkKsX/tTpcck=;
 b=lfFjB+OX/6see6dMJS3zki4F0+DtMTJwOfTQ5y3e1eMH2c2oG6jfN/PgU1UKrzMh8bK/OoC4QkdBf3GaGoO8x7tKmDaqG9tbH/uIIy2+BN5j3tPmzaUiQJpsupQN49S+wUik8lPxIj1ajbDjJIMo601oYBeN9LMbaT1inYUWjnvy+TMGoqlwiHVt+mTlFhUP2CweJY2Ib3JcrpE6RbCDfU9pey3Hrukqg/ag9rNCEMNHquOHBa2GXFK+jB9PFXa0LnTV52a2b68sYmx4meUP3t9ID4MPbyau6BzPV0X/Fq/CSAGdQb8+iG0QbUrq1p9WAEISub36pwU/fWf8fb7ItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5eX9mmkOLxLJoVQDaMMh8ssR8q8kF+RkKsX/tTpcck=;
 b=qZmnbg8xV/tbfVgZ9ohCZ7ONldU33aRIh1OH2DFSzvq41JZ1ztuPjFUC2ictGUv30fQtPfpbats222RRhjVBiEnIxyh9e/u+2yE7Z9XZFmq/hB3XQgaEj7OOI1GbGvcNozCtsotF4lgAG+b+TmojsN/ok84b9/csMCA7vVSmhNQ=
Received: from BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17)
 by BLAPR10MB4868.namprd10.prod.outlook.com (2603:10b6:208:333::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 04:44:29 +0000
Received: from BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798]) by BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:44:29 +0000
Date: Mon, 18 Sep 2023 21:44:25 -0700
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Juan Quintela <juan.quintela@gmail.com>
Cc: "f4bug@amsat.org" <f4bug@amsat.org>,
 Joao Martins <joao.m.martins@oracle.com>,
 "mdean@redhat.com" <mdean@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "afaerber@suse.de" <afaerber@suse.de>,
 "bazulay@redhat.com" <bazulay@redhat.com>,
 "bbauman@redhat.com" <bbauman@redhat.com>, "cw@f00f.org" <cw@f00f.org>,
 "dustin.kirkland@canonical.com" <dustin.kirkland@canonical.com>,
 "eblake@redhat.com" <eblake@redhat.com>,
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "iggy@theiggy.com" <iggy@theiggy.com>,
 "jan.kiszka@web.de" <jan.kiszka@web.de>,
 "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>,
 "jjherne@linux.vnet.ibm.com" <jjherne@linux.vnet.ibm.com>,
 "mimu@linux.vnet.ibm.com" <mimu@linux.vnet.ibm.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "imp@bsdimp.com" <imp@bsdimp.com>, "z.huo@139.com" <z.huo@139.com>,
 "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 David Edmondson <david.edmondson@oracle.com>,
 Konrad Wilk <konrad.wilk@oracle.com>,
 Alessandro Di Federico <ale@rev.ng>, "anjo@rev.ng" <anjo@rev.ng>,
 "shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>, 
 "wei.w.wang@intel.com" <wei.w.wang@intel.com>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Mark Burton <mburton@qti.qualcomm.com>
Subject: Re: Call for agenda for 2023-09-19 QEMU developers call
Message-ID: <n24acjjdhqeguo6yubxmwgdujgwmufnd2xvqo4datslawvtgc3@cpa3du62xks6>
References: <CALUyDQ5Tcby25VQ05REYXsv8v_MO-nVcsHcrQWEAJefPArCoXA@mail.gmail.com>
 <BYAPR10MB286984E6DDD6D4C2C915CAAE8CFBA@BYAPR10MB2869.namprd10.prod.outlook.com>
 <87h6nruj12.fsf@secure.mitica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6nruj12.fsf@secure.mitica>
X-ClientProxiedBy: BYAPR07CA0039.namprd07.prod.outlook.com
 (2603:10b6:a03:60::16) To BYAPR10MB2869.namprd10.prod.outlook.com
 (2603:10b6:a03:85::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2869:EE_|BLAPR10MB4868:EE_
X-MS-Office365-Filtering-Correlation-Id: 78697e28-ce67-4090-6791-08dbb8cb1b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9EG+4JXUzoFUxEnWxaHpdbxKjOC9f8fszMKZKUDeQMl2b0zJCAXcI5/3mSsh3+ayySJaBgrITBqBrN1ICdi/hykAdYEQ72IYrmc7F9anSn3aD3ALZUWj/qlbV8kKzK/Xny9vx1za+XcWXoRaBrkWjux/3U35QylmTnShNxcSQAW00ur5j9uNUldtClIVFPCTJJweW1kD+gbty/2Mizw1yLYOvyaMjtVR6dKzvjeBGgp5tSdjgvgL0AJamhe7Y7ox9QvYH/yqv+06dwP3nMweKfCApGoaYPD/iK/PxNejRbNtO45K89l9OCvQqLJ/8h3zz0tBBK66lg5+4zgXcR97OB1XpJkc3JwiPOnhiLDkl0n5y6+MIKPExiGC0TrQn2DjNUH/Y/LdGlcBi4bsGYTp1wA02gF0of4Bu8D3p8kbUh0lRi8VBdiFuYwzHnruNr0vtSrMAjAZKH0ba+1epgDCA9p6ntS1a93UKsWLP3mbSdnO3ijDbJpze/CLB+LOrVWauYDLBi8/LMRt2VJ5JF7T4p/fSti+fmaRZM21Gjn3GsL5cSVTQq3HYvIrQKGzHG3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2869.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(136003)(366004)(346002)(396003)(39860400002)(376002)(186009)(1800799009)(451199024)(6666004)(33716001)(41300700001)(6916009)(316002)(54906003)(66946007)(66556008)(66476007)(6506007)(6486002)(86362001)(6512007)(9686003)(26005)(8676002)(4326008)(8936002)(5660300002)(44832011)(478600001)(7406005)(7416002)(2906002)(4744005)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zmU8PNOoNleiT+EfIS/zlvAuCEkS18kQ27T1TigEJ8jbAlmpQN832Li4n7Wq?=
 =?us-ascii?Q?qzQzJ/nsYcQKaFaAURw519IxDOVqi7OdQ9dQLrf/PWc3uJ66h3M4Ithy+4b3?=
 =?us-ascii?Q?TKlDbzC7XNJPhyjuTwxk2Ast5ovU67YU8GYkoTJDRSyxts8waJf2jZhexMsa?=
 =?us-ascii?Q?VFfIL915H36fgaJOykRMtLTQa1eWmvU+TSdx+GVuNiWvC/6ClaTZyK8kgpb7?=
 =?us-ascii?Q?0Wyc2HhjI+y/KCVhkYsyhNJUnUVs+lb5PAt+/FNJfEV8M1w5nOTM537lSFz1?=
 =?us-ascii?Q?/tYXFpdhY+YJ5VILjgIZJtHYc6NcKL8Rr3AxjymGdeAXHTqAl2jPsq4xFauT?=
 =?us-ascii?Q?Oe4eZ1m74GXJvLV0emNX6mDDRuvpDjiwx9Eq4xZnvu+0n6R+XImbvGKHbhkb?=
 =?us-ascii?Q?ZYZ2TmWxP0yYDQpGqzh8L93S3Bi+oCuXHDwWu/IQgNRYU3l2GIaIkQFiPEan?=
 =?us-ascii?Q?0hCxryR7u+hwgFg2K3iGTK2AKiK0vzVuFAY4Dx0hEUu2pVGrjvV6eMJaY5MK?=
 =?us-ascii?Q?ohvvNoEh9cHILOZwMV1BGiHkfo471idRJBqRrxD73/Pwc8p1O0VB3gTe6K3L?=
 =?us-ascii?Q?ZWDsK9C4rcEEHRa8zJLIERJVW+nzZCmXkueuyAA2GGdnHBsoDgi0RHFK8dz4?=
 =?us-ascii?Q?zoKmhhPmL76jrywY72z1UW7dj3VlzzhkxILBVf6SoeZcLfR3XIQBnnvs58e3?=
 =?us-ascii?Q?NKhJOfShLJ6LtgtQBSyINTvlKAY0DDZY9al5cyCv1FjbUJqTce/TA9Lsf1xy?=
 =?us-ascii?Q?TSfofQ5/bNB3eXT0z4uAPhxe6n5VSiRsDXpUVxfhpKRHXTwbGZed7lmG2X50?=
 =?us-ascii?Q?/Ifje/1MgRvLhtwsIRiqgjcFgppwz62sMMTuKVfaKzQ+FVFR/JIui+nX6W60?=
 =?us-ascii?Q?iMYsilphGsl7ntmIhaOw+CcbhBuCFyT1o6QcOww55qKmJjdB32bM6NgBC+14?=
 =?us-ascii?Q?tVuyBXkItPiUMqiXklBzxVEAfDXvO6HIyd/rUAc6Lq6i9DFGDBtn4AMmwVlF?=
 =?us-ascii?Q?0lrWWaTUl0aHjG8WQj4eI0nuGKWN/ZbmL0bFanacMSsrJbMmCis8iHz1Rmde?=
 =?us-ascii?Q?oSNEyEfptTac3UgEgQ9AnYQTE/1fVmEPQnZ6LVEBjFfbsFUoxY0MUPTg8gJh?=
 =?us-ascii?Q?kTYdVz6iiL2FkA6KZgqrBCPjYKhOQrbx081McjU/F+SOMjceanVrMYfxSqCc?=
 =?us-ascii?Q?Jwb8nit1sMKxAqzs1Qd5ANviNXKRTI8TSMLi02P1MLNnGABzPQlebSuRKemv?=
 =?us-ascii?Q?zRvIB/S1k4NT+nUVqB7oySnk+iP31UfIFxS6ImJiRNk+zk8gOPf1OV5vd7eu?=
 =?us-ascii?Q?i6MbMDMwY25apRc95guiFb9f1n+fuvK83JNO2EWFjFtLHfv6VerLaj1GHmWj?=
 =?us-ascii?Q?nZcJQ2pFCgHYY8HAOulMrxIZcifAQBG3jSVvWzeCBVQzHqXqORFLsYcdj6aU?=
 =?us-ascii?Q?upaCJQpUpymtzKGtpeBXnJz87yRUFXNP8niSUtl5iMprrgholDJu0a+s9xMZ?=
 =?us-ascii?Q?JxhpQ3DkCHs+vQ4EvU7qpddVOEz221RzAYThHnsueNQr139XTorwqddrr6oU?=
 =?us-ascii?Q?q+w/+OfvqehhUj+ZFWnexcvwkqngRGR6ma0rwr3u068/9ALl9uUrEosP6ip9?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?FO8arze3lSPI7jEQvIX1py3A29jOgW75hGOqoNeZ9gLdA7NS+9Ok7McuX6gy?=
 =?us-ascii?Q?LQjBSZZGTSu71ZSbws2UJJYAaiODl9bfcUUt1DJYDot39lqhTSxETslGvHT3?=
 =?us-ascii?Q?b42YLXWnCHQbAISUbiFzEvyTCVAEoUXIbG5vt+2f5+gZ4oa0vFdIbOtqxq4Y?=
 =?us-ascii?Q?P7WViKfpjq4w/DTbeYFjCRDPPy6f5JemYmgCiANHnBBqlt1F475++DB33efa?=
 =?us-ascii?Q?xzDrRe3XV/qaqFSU/l/9SMLlYA2B/w/HfcqGFlGmrj7neekC2rSWDuQipt2a?=
 =?us-ascii?Q?ZrEzIQiApOD18YsZ7YgXR9AhhRaqtvWtjf2hmFHtrfcguL5oYPrk6/LZi6Mx?=
 =?us-ascii?Q?8XOo0Z3S96Ow5QVFLiG0SGIjfoyim45KdwIVajuWPHhi2oCZW0GrDXvJtmU0?=
 =?us-ascii?Q?UbJ4biRtX0jDN5mPKotYFafh3oDaCwxnQYJIQ4cIb1Hr4ARZ94IAp5BNEncJ?=
 =?us-ascii?Q?wPmdL3vEIh0Age7yRL76u6YTe1i++veOtblgMoG6+SFeJJpNu96EcSzogcj2?=
 =?us-ascii?Q?Jl0uwqV5p/xeXhW9lYsUmLmGQeL/QSYSAufYojC1Q4dKbRFJkKvkLHlJHsM9?=
 =?us-ascii?Q?IsL/UeNnJInWZ6f7eNOmG+2rbCZPGv4phgrHOYIHSROKhVWpIlt81ZVcYVa/?=
 =?us-ascii?Q?q4cJNSsZzeI6ehRjP/dxQEwBBcmJgOMp8I8Uvq+pgwLrRyqnlaX7fIWFWleD?=
 =?us-ascii?Q?ZOQQOODaqN+NmjRMq3wsO6sHto3CyTtEB4s2o4892F6yHnupc3MQkhnBG8Hi?=
 =?us-ascii?Q?8lOxyteREMwF5Qm9cwiG0O208Txhn+7oTSphaa0HvypwI7U7C1ffzcsl5wMi?=
 =?us-ascii?Q?ciNqU+xFYJAu39HTKfTfJwNd8awbrXLhASl1pTFnCvydxZaxU36eglF3sqOT?=
 =?us-ascii?Q?FKevWq8PKaHYPGSaId0dQGx8c74qNB/UZ7zUFlgPgMOA7scrG+v+1Yay8+KW?=
 =?us-ascii?Q?xr9HUFv3zrB9QLOlcn5+IANyTSAqVglfzfMwJhyfg1COo+P5s4TRp+DlTaiU?=
 =?us-ascii?Q?m1pVRHEW+Yn2hpdKM+o+8GW/Yj7PCQCFTg/tgBh9mdziS0f1D73/iEQiSQj1?=
 =?us-ascii?Q?LKQfSAdvfqKvYHte+cdwZ9Q2rRZaVP2/SI7Z/aBD74HiHdA5DpYUApmQEqmh?=
 =?us-ascii?Q?BqfQ+sZsWZMf2rwLuUOUyhzqaqBWGlLbdqzEx21s4uLKbkJWKimNF2SISXC9?=
 =?us-ascii?Q?DWfVe8rPVqADvIVHJkY61LjteikxVUzfaheWK58sal794pz9eNz744Z8FN7E?=
 =?us-ascii?Q?meStEDN/eHjspa5JvMG6KyP/nPlXHgqUxsLxMLklARd5a1YKI+/VqSNFfkei?=
 =?us-ascii?Q?no+REf9MYvtk/JhtwQ0LsH3r?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78697e28-ce67-4090-6791-08dbb8cb1b6f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2869.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:44:28.9171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYKjwWUOBabxtVFVpv68OvkgOieCVaEzFqxSeGwRJ9RyF309ADD+j/BGMcgpLIgzwT6HQjL7LKYT9lU1bbPOe8ucU5XGeyIXZGwNs9WF8is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190040
X-Proofpoint-ORIG-GUID: YGy2ATEmC52624jAosoMN-5iqCY9fb9H
X-Proofpoint-GUID: YGy2ATEmC52624jAosoMN-5iqCY9fb9H
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=elena.ufimtseva@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On Tue, Sep 19, 2023 at 02:02:49AM +0200, Juan Quintela wrote:
> Elena Ufimtseva <elena.ufimtseva@oracle.com> wrote:
> > Hello Juan,
> >
> > Not sure if this is worth its own topic, would be it possible to hear
> > the community thoughts on the live migration series review/pull
> > progress (atomics, zero page multifd etc.. )? Seems like there are few
> > outstanding relevant patches.
> 
> Hi
> 
> If everybody agrees, can we move this topic to next call?
> I am on vacation this week and the next.
> 
> I was planning time to "moderate" the call, but preparing for a call
> about my topics is going to mean a divorce O:-)
> 

Thank you Juan! Understood :)

> Later, Juan.
> 
> PD.  I have had too many problem in the recent past with several things,
>      from my test machines to disappear (and configuring new ones taking
>      forever), to very bad time with the BOTS.  I expect/hope that
>      things are gonig to get better in the near future.

