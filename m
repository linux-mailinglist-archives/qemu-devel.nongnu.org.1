Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 927CF7285DF
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 18:57:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7IwN-0004nW-29; Thu, 08 Jun 2023 12:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sheshas@marvell.com>)
 id 1q7IwJ-0004mh-GH
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:56:47 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sheshas@marvell.com>)
 id 1q7IwF-0000Ma-0Z
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:56:46 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3588D2qE023579; Thu, 8 Jun 2023 09:55:35 -0700
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3r329c3uwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jun 2023 09:55:35 -0700
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 358Geaj8026953;
 Thu, 8 Jun 2023 09:55:34 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3r329c3uw7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jun 2023 09:55:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGMrEVilbdl5j4iKn+tbFy6SmdNG70jtqfLi6UiybfFSGMxYIOej3CYMcT5xi+RkiQu0jHdpYNR1J7HG8S6lCxdC5Ol3ZN/e/FGwMu3Ivi6llmLQ7Qoxuf3UXiLDlMJdYOzISkMnEXqkAF+L55y36NvPp3bNnM7zkw2c6xieJ662KQUMA+aKFRwSMATomhqiqbnOQA8QxjSObSAKQo18d36BC9/3pw1MJm6In/uZBs7aIX3BDfDMeAivfzNNWvphyAec2Tug/PYP/SN/yitINWcq9os2dKijWPgZs2KFQpuwTuDpIqA5isozICEFVGPHhO6aNcsdkPWwKDt5tCnS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogjJHimvFmoSpZZuSnQ/JRA/zkIjG99kRpYY5lj9swI=;
 b=NvhNlcSKYsFkeJ87hC2aFZqL9oyzoGLgB6ZWm6vimjQNnTnDM7bdrBFsOwf9kLRdYXtcxUmqeKzegmDK56j0v/GtjcmO1o4O12d0LYXaLNswaRLkmBSTr7F0ZDy5oRdi7crdDL2jV0pwDawI8ZvuELxP4cLYDB+ONnPfG3c64q0tJN4pAGORo2eV7LMW8v01i+xGLpJ4Z/b9np1IT+DXVP2CpUypk9zYKxB1Mrcc+cABOmnyhTKo2yOPB6472T9lvblN+cRuy/lMHIdxmcHngbFW8DkHvI2tcrWd35wqavC3E4vzoyzaP+sxlkO9Tf5Xi6DYqloErUDaTgDSPpnPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogjJHimvFmoSpZZuSnQ/JRA/zkIjG99kRpYY5lj9swI=;
 b=QZSCLnnYqsKT9RDrZ/Dhn0cv05efhjtgxrGJDwRSW1iVb44pqhHRHNjt/RZ6jeORwIkpWA2qGcOoK2F7WfSYMBsSOaodfeSSAHAqfvLeRbzNxZSvf7a7U8DJku7lpsYVa4Qklfc0IKp6H4ddNlNVs3XkSwmy232d7KKpKZFsS3w=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by SJ0PR18MB4865.namprd18.prod.outlook.com (2603:10b6:a03:404::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 16:55:29 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::cd6c:c34b:dc45:b864]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::cd6c:c34b:dc45:b864%6]) with mapi id 15.20.6477.016; Thu, 8 Jun 2023
 16:55:29 +0000
From: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Fan Ni <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "gregory.price@memverge.com"
 <gregory.price@memverge.com>, "hchkuo@avery-design.com.tw"
 <hchkuo@avery-design.com.tw>, "cbrowy@avery-design.com"
 <cbrowy@avery-design.com>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, Adam Manzanares <a.manzanares@samsung.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>, "nmtadam.samsung@gmail.com"
 <nmtadam.samsung@gmail.com>, "nifan@outlook.com" <nifan@outlook.com>, Ira
 Weiny <ira.weiny@intel.com>
Subject: Re: [EXT] Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Topic: [EXT] Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Index: AQHZhDHwBF2t8l6CHEO7jqFQqFgBOK98n/AAgAAEVoCAAymO8IAABjkAgAAFXhKAAPmEAIAAXICDgAAb9Gk=
Date: Thu, 8 Jun 2023 16:55:29 +0000
Message-ID: <DM6PR18MB28447B61A0D857865A499879AF50A@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
 <20230511175609.2091136-1-fan.ni@samsung.com>
 <647e1cf4e7e5e_7471a2948f@iweiny-mobl.notmuch>
 <20230605175112.GA2290821@bgt-140510-bm03>
 <DM6PR18MB2844A78EB692A69CE10031E2AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
 <20230607183059.GA2354376@bgt-140510-bm03>
 <DM6PR18MB284486E36310719093C8A6D6AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
 <20230608104322.0000632f@Huawei.com>
 <DM6PR18MB2844B37EE5A5AB7005EECCB3AF50A@DM6PR18MB2844.namprd18.prod.outlook.com>
In-Reply-To: <DM6PR18MB2844B37EE5A5AB7005EECCB3AF50A@DM6PR18MB2844.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|SJ0PR18MB4865:EE_
x-ms-office365-filtering-correlation-id: 9717229b-ce5b-4bc7-afde-08db68412a26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WrEi1yzRlXAQ+WzXsYtEc+WqgQMs7REtg7Am/FzBcJdRjdNduFtHYkWGYEZOvB4tvqTaiUnu/R1BV62SrVd8bbCyrh8gaxZa35GUEGm0HX/skkV8EOzjEFXdXsq0/dNvg0ouPF9ScgS+CJh2RU5RE0YHx66s9WUG7b/IS32vZTPxgVq6xZR95Jf7HqTrBlsrDbLZupk7X8qEWSXthBpxmNfgEOk1r08Neq+pCSmo7QbehQxsdRNr7VzcbvYIbPC6wCqGvCtHXETwBlHytdHV/TMfgyh8+qdZLLtj3Cnfzu2wvt2ziNKhIfD5Umh/ne7UAvudEF5Zugud+bQMqzPYmLvvmULoVfSxFwXO9Mzmn1uhiI+nga2OLpRE22RMkB1TyIpNz2H95Fm/USCrmc+6EW4ZG0Tws+mKRCy/HOJBywDObYIeINsynoOUZOKFnvjpHOhrulAjkzEBqU/iX2CfWhEP5orzF7Lt4YObOEpN46DRfE3S/x883w3vfmx8aJkPTJfqPYUvUWvr6me2DVXiZrtQ9znQSTd/W8/jT1W1BYJoLm5GZ69XhtR8Repapul7190G9w1Fs55n1KQTUjKNgCaeUzBa5OTUu8fyKJgQOtc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR18MB2844.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(396003)(376002)(136003)(366004)(346002)(451199021)(186003)(83380400001)(2940100002)(478600001)(38070700005)(71200400001)(45080400002)(9686003)(53546011)(6506007)(26005)(8936002)(55016003)(86362001)(122000001)(66556008)(316002)(7416002)(66446008)(76116006)(6916009)(66476007)(91956017)(5660300002)(7696005)(66946007)(30864003)(2906002)(4326008)(966005)(64756008)(38100700002)(33656002)(52536014)(41300700001)(8676002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X0l3U8LQEGPGDpkqH3G/3m9SzJmyKeKC0OaPhhbXZNPOlCwnd1bGQLpOpq?=
 =?iso-8859-1?Q?v40h4vSGMPJBF/7tNj0To8M1YwAmcHwJJNP+7116I98kItYvxgP19bFU++?=
 =?iso-8859-1?Q?ypRjGrD1rox4XsAr39FyPH8Tcj7zBKv33W6de7v184h7DWcTRR1S5drJbb?=
 =?iso-8859-1?Q?Bdz3xYDztwWo5C4SFNhi4bncMcBJdi4SpWQYEY5hLyfDbyyeS93QEbBgev?=
 =?iso-8859-1?Q?gdeWxvWaZNS0X6zJ8hvryRr9m1x70YVu2T3WUjuXbJT4lOG6QBdMzjlzOA?=
 =?iso-8859-1?Q?IZMXTW6Py+vowh/AjWGs92AqA4GIn7TOlrANhu/gcdHMsa9RkX4K6ppK1U?=
 =?iso-8859-1?Q?s7fse6DTjI91QBpZDNoSh7tgM1R9E9/sBLKpXvXTlVg50WwB/zqnpW/IpU?=
 =?iso-8859-1?Q?41afwTMR9fMO2h2RVV213Jlf2qzxxnmHA8r0trhp5AMHn6XGw6ee9ujgxW?=
 =?iso-8859-1?Q?AUZAXHe3MVUP+u+3x7heO7NuxHMyx4cbZDan/agXVOOyshCUNSyvUc+4fo?=
 =?iso-8859-1?Q?AE4HEMEogs6tNcbgdCFQg81HpElJPkXLWQUjLCZTRXITl8FuZCwa9sbaPM?=
 =?iso-8859-1?Q?CsnOxfX1lsbXJ9xF6Pp0Y6/CC23UwgC0QOQUttikXzOYMcVNbuOtA75KwK?=
 =?iso-8859-1?Q?0b0nSHA42Gokkov4fPTb5NHqzyQs8lHmHS6GTxfSH02uv7625xpU/jxSh4?=
 =?iso-8859-1?Q?W6uVCDxzBvtECv8PV+tgetnzSFTaKyK0UTpcySg+SJD7iixZEVipjy5auF?=
 =?iso-8859-1?Q?6yZ1EzbGbKyx0LNqLPZ7KVu+91Z+0/tbmeFmB3c+N4I02/zlxwVwSx3MLy?=
 =?iso-8859-1?Q?QC7iyaAw7Gjlv+IJ9aSkGdV/UbJWE57dQroaUjP15E6vxlfv4+nNkkaan7?=
 =?iso-8859-1?Q?Hbt6h1xv+N5a4lCI/LwzOwQ33fCMkkS7ntDhKsAWdrAdu1MjNnviDLAL3a?=
 =?iso-8859-1?Q?D/fiwxn2Tus88DICrVBQaqSDlWqyu8GHeIA4bJuspJHYdt2C93nLYDjqb4?=
 =?iso-8859-1?Q?PfRULjefxmMTLvtRipm4nso2whM+6qeN39JaiFCM31hfupR7sgZxV8wBrh?=
 =?iso-8859-1?Q?maH3O63UvWCzXMqyMSzJrqL/VZRWkodtr3fNmRN/U8sNcDX5Kk1Zaoeii6?=
 =?iso-8859-1?Q?rYx+CaoEt/rKFkAeIvzcp9J0ZEmf+q5Y/v1FRHtrZOBaCjxDmoonBgoua6?=
 =?iso-8859-1?Q?kspRG1E6ohqPmRJtINMII2rL76EquagokI8LGd4xhfSFwW0824+ZaO4OIr?=
 =?iso-8859-1?Q?XIMJCUbeR3gIi1fELqxmIiz9k4YAMEkEkKvrbU9nmAvR8XMPvaB2lPa+40?=
 =?iso-8859-1?Q?cmUHZBctbhcx8Wp1XdStpzMLx3UXvMk5095pk/N/AXB67oaBdIx2h8KB0g?=
 =?iso-8859-1?Q?+p2CEf0jKMD5sj4QhjLqw39w8YoG+OdUSB8gl66isSiK9PqGMJD9bV1NXw?=
 =?iso-8859-1?Q?YHjAmaHtaVGtMNjQwqwTKYjejf29sjOjEwwTwSBf9emwgRlS0b56NKzH5c?=
 =?iso-8859-1?Q?Rkj3bzBUht4cy2poc5FjIAVl0dqhvlQeqyN78MaVd16DkAI4iSM4EdnuUt?=
 =?iso-8859-1?Q?OXPxZagobLMtD82RTwWjxTd1OEOaa7nVobGbxC1Raqmcb1DMUSlyI5DvqY?=
 =?iso-8859-1?Q?hb7S1jZZEoCdA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9717229b-ce5b-4bc7-afde-08db68412a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 16:55:29.2077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dpY72ero8g3pbWWb4jmNwbkKUupZhDA2OQ5qQDhgwVTjM35a9fdnQBbdEjPx4qJBidYkP3nqXaqkCm/lIoG/SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4865
X-Proofpoint-GUID: 8IuKfNFmquPD8AKH39PYGpzAOdI9Gxyk
X-Proofpoint-ORIG-GUID: AU4vBXyjRJwuAEm0N1PoVFXkjB5-_wKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_12,2023-06-08_01,2023-05-22_02
Received-SPF: pass client-ip=67.231.148.174; envelope-from=sheshas@marvell.com;
 helo=mx0b-0016f401.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

Here is the repo where I am committing my changes=0A=
=0A=
https://gitlab.com/sheshas/qemu-fmapi/-/commits/cxl-2023-05-25=0A=
=0A=
=0A=
From: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>=0A=
Sent: Thursday, June 8, 2023 8:20 AM=0A=
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
Cc: Fan Ni <fan.ni@samsung.com>; qemu-devel@nongnu.org <qemu-devel@nongnu.o=
rg>; linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>; gregory.price@m=
emverge.com <gregory.price@memverge.com>; hchkuo@avery-design.com.tw <hchku=
o@avery-design.com.tw>; cbrowy@avery-design.com <cbrowy@avery-design.com>; =
dan.j.williams@intel.com <dan.j.williams@intel.com>; Adam Manzanares <a.man=
zanares@samsung.com>; dave@stgolabs.net <dave@stgolabs.net>; nmtadam.samsun=
g@gmail.com <nmtadam.samsung@gmail.com>; nifan@outlook.com <nifan@outlook.c=
om>; Ira Weiny <ira.weiny@intel.com>=0A=
Subject: Re: [EXT] Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qe=
mu =0A=
=A0=0A=
=0A=
=0A=
=0A=
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
Sent: Thursday, June 8, 2023 2:43 AM=0A=
To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>=0A=
Cc: Fan Ni <fan.ni@samsung.com>; qemu-devel@nongnu.org <qemu-devel@nongnu.o=
rg>; linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>; gregory.price@m=
emverge.com <gregory.price@memverge.com>; hchkuo@avery-design.com.tw <hchku=
o@avery-design.com.tw>; cbrowy@avery-design.com <cbrowy@avery-design.com>; =
dan.j.williams@intel.com <dan.j.williams@intel.com>; Adam Manzanares <a.man=
zanares@samsung.com>; dave@stgolabs.net <dave@stgolabs.net>; nmtadam.samsun=
g@gmail.com <nmtadam.samsung@gmail.com>; nifan@outlook.com <nifan@outlook.c=
om>; Ira Weiny <ira.weiny@intel.com>=0A=
Subject: [EXT] Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu =
=0A=
=A0=0A=
External Email=0A=
=0A=
----------------------------------------------------------------------=0A=
On Wed, 7 Jun 2023 18:52:14 +0000=0A=
Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:=0A=
=0A=
> From: Fan Ni <fan.ni@samsung.com>=0A=
> Sent: Wednesday, June 7, 2023 11:31 AM=0A=
> To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>=0A=
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>; qemu-devel@nongnu.org=
 <qemu-devel@nongnu.org>; linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.=
org>; gregory.price@memverge.com <gregory.price@memverge.com>; hchkuo@avery=
-design.com.tw <hchkuo@avery-design.com.tw>; cbrowy@avery-design.com <cbrow=
y@avery-design.com>; dan.j.williams@intel.com <dan.j.williams@intel.com>; A=
dam Manzanares <a.manzanares@samsung.com>; dave@stgolabs.net <dave@stgolabs=
.net>; nmtadam.samsung@gmail.com <nmtadam.samsung@gmail.com>; nifan@outlook=
.com <nifan@outlook.com>; Ira Weiny <ira.weiny@intel.com>=0A=
> Subject: [EXT] Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu=
 =0A=
> =A0=0A=
> External Email=0A=
> =0A=
> ----------------------------------------------------------------------=0A=
> On Wed, Jun 07, 2023 at 06:13:01PM +0000, Shesha Bhushan Sreenivasamurthy=
 wrote:=0A=
> > Hi Fan,=0A=
> >=A0=A0=A0 I am implementing DCD FMAPI commands and planning to start pus=
hing changes to the below branch. That requires the contributions you have =
made. Can your changes be pushed to the below branch ?=0A=
> > =0A=
> > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-20=
23-05-25__;!!EwVzqGoTKBqv-0DWAJBm!Vt5uIqwW-L4c4gh02ulI4M762JNQ3_aE9k9lb6Qlw=
E2xm6T23ic7ig7Y77i1VN7l_RX_ySIQhre_z7Q0JA$=A0=A0 =0A=
> =0A=
> Can you push changes to the branch directly? I think it is Jonathan's pri=
vate=0A=
> branch. However, I can fork the branch and rebase my patch series atop an=
d=0A=
> share with you the new repo if that helps you move forward your=0A=
> work.=0A=
> Let me know your thought.=0A=
> =0A=
> ss - I saw commits from others, so assumed you can. Since it is Jonathan'=
s private repo, I will step back and let him answer.=0A=
=0A=
I tend to apply stuff in manually rather than given more people commit acce=
ss=0A=
to that particular gitlab tree. =0A=
=0A=
Easiest option is to fork on gitlab and share the path of your own fork.=0A=
=0A=
I normally queue reasonably mature stuff up on my tree, but that's about ma=
naging=0A=
the series sent with intent of being applied upstream + providing a fairly =
stable test=0A=
branch.=A0 It's not intended as a general place for stuff in development (t=
hough I might=0A=
sneak out an extra branch myself from time to time if I want to talk about =
it :)=0A=
=0A=
Jonathan=0A=
=0A=
ss - Thanks ! I have forked Jonathan's repo on Gitlab and will work of cxl-=
2023-05-25 branch. I will apply Fan's patch manually and continue ..=0A=
=0A=
> =0A=
> Fan=0A=
> =0A=
> > =0A=
> > =0A=
> > From: Fan Ni <fan.ni@samsung.com>=0A=
> > Sent: Monday, June 5, 2023 10:51 AM=0A=
> > To: Ira Weiny <ira.weiny@intel.com>=0A=
> > Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; jonathan.cameron@hua=
wei.com <jonathan.cameron@huawei.com>; linux-cxl@vger.kernel.org <linux-cxl=
@vger.kernel.org>; gregory.price@memverge.com <gregory.price@memverge.com>;=
 hchkuo@avery-design.com.tw <hchkuo@avery-design.com.tw>; cbrowy@avery-desi=
gn.com <cbrowy@avery-design.com>; dan.j.williams@intel.com <dan.j.williams@=
intel.com>; Adam Manzanares <a.manzanares@samsung.com>; dave@stgolabs.net <=
dave@stgolabs.net>; nmtadam.samsung@gmail.com <nmtadam.samsung@gmail.com>; =
nifan@outlook.com <nifan@outlook.com>=0A=
> > Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu =0A=
> > =A0=0A=
> > On Mon, Jun 05, 2023 at 10:35:48AM -0700, Ira Weiny wrote:=A0 =0A=
> > > Fan Ni wrote:=A0 =0A=
> > > > Since the early draft of DCD support in kernel is out=0A=
> > > > (https://urldefense.com/v3/__https://lore.kernel.org/linux-cxl/2023=
0417164126.GA1904906@bgt-140510-bm03/T/*t__;Iw!!EwVzqGoTKBqv-0DWAJBm!RHzXPI=
cSiGsqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21LzAGN=
Ok$ ),=0A=
> > > > this patch series provide dcd emulation in qemu so people who are i=
nterested=0A=
> > > > can have an early try. It is noted that the patch series may need t=
o be updated=0A=
> > > > accordingly if the kernel side implementation changes.=A0 =0A=
> > > =0A=
> > > Fan,=0A=
> > > =0A=
> > > Do you have a git tree we can pull this from which is updated to a mo=
re=0A=
> > > recent CXL branch from Jonathan?=0A=
> > > =0A=
> > > Thanks,=0A=
> > > Ira=A0 =0A=
> > =0A=
> > Hi Ira,=0A=
> > =0A=
> > I have a git tree of the patch series based on Jonathan's branch=0A=
> > cxl-2023-02-28: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__=
github.com_moking_qemu-2Ddev_tree_dcd-2Drfe&d=3DDwIFAg&c=3DnKjWec2b6R0mOyPa=
z7xtfQ&r=3DZta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4unU&m=3Dw6dicn5kXEG4Imk6=
TpICIjdA6KJ-xt84dtHui-Y0fv5H13bijtzEvjxECKE5MHYf&s=3D3yeO9RN5FY3gPfO2y19X05=
7YeqRTTQTQNfNA-Gfir_Q&e=3D .=0A=
> > =0A=
> > That may be not new enough to include some of the recent patches, but I=
 can=0A=
> > rebase it to a newer branch if you can tell me which branch you want to=
 use.=0A=
> > =0A=
> > Thanks,=0A=
> > Fan=0A=
> >=A0=A0 =0A=
> > >=A0=A0 =0A=
> > > > =0A=
> > > > To support DCD emulation, the patch series add DCD related mailbox =
command=0A=
> > > > support (CXL Spec 3.0: 8.2.9.8.9), and extend the cxl type3 memory =
device=0A=
> > > > with dynamic capacity extent and region representative.=0A=
> > > > To support read/write to the dynamic capacity of the device, a host=
 backend=0A=
> > > > is provided and necessary check mechnism is added to ensure the dyn=
amic=0A=
> > > > capacity accessed is backed with active dc extents.=0A=
> > > > Currently FM related mailbox commands (cxl spec 3.0: 7.6.7.6) is no=
t supported=0A=
> > > > , but we add two qmp interfaces for adding/releasing dynamic capaci=
ty extents.=0A=
> > > > Also, the support for multiple hosts sharing the same DCD case is m=
issing.=0A=
> > > > =0A=
> > > > Things we can try with the patch series together with kernel dcd co=
de:=0A=
> > > > 1. Create DC regions to cover the address range of the dynamic capa=
city=0A=
> > > > regions.=0A=
> > > > 2. Add/release dynamic capacity extents to the device and notify th=
e=0A=
> > > > kernel.=0A=
> > > > 3. Test kernel side code to accept added dc extents and create dax =
devices,=0A=
> > > > and release dc extents and notify the device=0A=
> > > > 4. Online the memory range backed with dc extents and let applicati=
on use=0A=
> > > > them.=0A=
> > > > =0A=
> > > > The patch series is based on Jonathan's local qemu branch:=0A=
> > > > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cx=
l-2023-02-28__;!!EwVzqGoTKBqv-0DWAJBm!RHzXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOI=
eUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21OO3UHEM$ =0A=
> > > > =0A=
> > > > Simple tests peformed with the patch series:=0A=
> > > > 1 Install cxl modules:=0A=
> > > > =0A=
> > > > modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem=0A=
> > > > =0A=
> > > > 2 Create dc regions:=0A=
> > > > =0A=
> > > > region=3D$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)=0A=
> > > > echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region=0A=
> > > > echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity=0A=
> > > > echo 1 > /sys/bus/cxl/devices/$region/interleave_ways=0A=
> > > > echo "dc" >/sys/bus/cxl/devices/decoder2.0/mode=0A=
> > > > echo 0x10000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size=0A=
> > > > echo 0x10000000 > /sys/bus/cxl/devices/$region/size=0A=
> > > > echo=A0 "decoder2.0" > /sys/bus/cxl/devices/$region/target0=0A=
> > > > echo 1 > /sys/bus/cxl/devices/$region/commit=0A=
> > > > echo $region > /sys/bus/cxl/drivers/cxl_region/bind=0A=
> > > > =0A=
> > > > /home/fan/cxl/tools-and-scripts# cxl list=0A=
> > > > [=0A=
> > > >=A0=A0 {=0A=
> > > >=A0=A0=A0=A0 "memdevs":[=0A=
> > > >=A0=A0=A0=A0=A0=A0 {=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "memdev":"mem0",=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "pmem_size":536870912,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "ram_size":0,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "serial":0,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "host":"0000:0d:00.0"=0A=
> > > >=A0=A0=A0=A0=A0=A0 }=0A=
> > > >=A0=A0=A0=A0 ]=0A=
> > > >=A0=A0 },=0A=
> > > >=A0=A0 {=0A=
> > > >=A0=A0=A0=A0 "regions":[=0A=
> > > >=A0=A0=A0=A0=A0=A0 {=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "region":"region0",=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "resource":45365592064,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "size":268435456,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "interleave_ways":1,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "interleave_granularity":256,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "decode_state":"commit"=0A=
> > > >=A0=A0=A0=A0=A0=A0 }=0A=
> > > >=A0=A0=A0=A0 ]=0A=
> > > >=A0=A0 }=0A=
> > > > ]=0A=
> > > > =0A=
> > > > 3 Add two dc extents (128MB each) through qmp interface=0A=
> > > > =0A=
> > > > { "execute": "qmp_capabilities" }=0A=
> > > > =0A=
> > > > { "execute": "cxl-add-dynamic-capacity-event",=0A=
> > > >=A0=A0=A0=A0=A0 "arguments": {=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "path": "/machine/periphe=
ral/cxl-pmem0",=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "region-id" : 0,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "num-extent": 2,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "dpa":0,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "extent-len": 128=0A=
> > > >=A0=A0=A0=A0=A0 }=0A=
> > > > }=0A=
> > > > =0A=
> > > > /home/fan/cxl/tools-and-scripts# lsmem=0A=
> > > > RANGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SIZE=A0=A0 STATE REMOVABLE=A0=A0 BL=
OCK=0A=
> > > > 0x0000000000000000-0x000000007fffffff=A0=A0=A0 2G=A0 online=A0=A0=
=A0=A0=A0=A0 yes=A0=A0=A0 0-15=0A=
> > > > 0x0000000100000000-0x000000027fffffff=A0=A0=A0 6G=A0 online=A0=A0=
=A0=A0=A0=A0 yes=A0=A0 32-79=0A=
> > > > 0x0000000a90000000-0x0000000a9fffffff=A0 256M offline=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 338-339=0A=
> > > > =0A=
> > > > Memory block size:=A0=A0=A0=A0=A0=A0 128M=0A=
> > > > Total online memory:=A0=A0=A0=A0=A0=A0 8G=0A=
> > > > Total offline memory:=A0=A0=A0 256M=0A=
> > > > =0A=
> > > > =0A=
> > > > 4.Online the momory with 'daxctl online-memory dax0.0' to online th=
e memory=0A=
> > > > =0A=
> > > > /home/fan/cxl/ndctl# ./build/daxctl/daxctl online-memory dax0.0=0A=
> > > > [=A0 230.730553] Fallback order for Node 0: 0 1=0A=
> > > > [=A0 230.730825] Fallback order for Node 1: 1 0=0A=
> > > > [=A0 230.730953] Built 2 zonelists, mobility grouping on.=A0 Total =
pages: 2042541=0A=
> > > > [=A0 230.731110] Policy zone: Normal=0A=
> > > > onlined memory for 1 device=0A=
> > > > =0A=
> > > > root@bgt-140510-bm03:/home/fan/cxl/ndctl# lsmem=0A=
> > > > RANGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SIZE=A0=A0 STATE REMOVABLE BLOCK=0A=
> > > > 0x0000000000000000-0x000000007fffffff=A0=A0=A0 2G=A0 online=A0=A0=
=A0=A0=A0=A0 yes=A0 0-15=0A=
> > > > 0x0000000100000000-0x000000027fffffff=A0=A0=A0 6G=A0 online=A0=A0=
=A0=A0=A0=A0 yes 32-79=0A=
> > > > 0x0000000a90000000-0x0000000a97ffffff=A0 128M=A0 online=A0=A0=A0=A0=
=A0=A0 yes=A0=A0 338=0A=
> > > > 0x0000000a98000000-0x0000000a9fffffff=A0 128M offline=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 339=0A=
> > > > =0A=
> > > > Memory block size:=A0=A0=A0=A0=A0=A0 128M=0A=
> > > > Total online memory:=A0=A0=A0=A0 8.1G=0A=
> > > > Total offline memory:=A0=A0=A0 128M=0A=
> > > > =0A=
> > > > 5 using dc extents as regular memory=0A=
> > > > =0A=
> > > > /home/fan/cxl/ndctl# numactl --membind=3D1 ls=0A=
> > > > CONTRIBUTING.md=A0 README.md=A0 clean_config.sh=A0 cscope.out=A0=A0=
 git-version-gen=0A=
> > > > ndctl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 scripts=A0=A0 test.h=
=A0=A0=A0=A0=A0 version.h.in COPYING=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 acpi.h=0A=
> > > > config.h.meson=A0=A0 cxl=A0=A0=A0=A0=A0=A0=A0=A0=A0 make-git-snapsh=
ot.sh=A0=A0 ndctl.spec.in=A0 sles=A0=A0=A0=A0 tools=0A=
> > > > Documentation=A0=A0=A0=A0=A0=A0=A0 build=A0=A0=A0=A0=A0=A0 contrib=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 daxctl=A0=A0=A0=A0=A0=A0=A0 meson.build=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rhel=0A=
> > > > tags=A0=A0=A0=A0=A0=A0=A0 topology.png LICENSES=A0=A0=A0 ccan=A0=A0=
=A0=A0=A0=A0=A0 cscope.files=0A=
> > > > git-version=A0 meson_options.txt=A0=A0=A0=A0=A0 rpmbuild.sh=A0=A0=
=A0 test=A0=A0=A0=A0 util=0A=
> > > > =0A=
> > > > =0A=
> > > > QEMU command line cxl configuration:=0A=
> > > > =0A=
> > > > RP1=3D"-object memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-pat=
h=3D/tmp/cxltest.raw,size=3D512M \=0A=
> > > > -object memory-backend-file,id=3Dcxl-mem2,share=3Don,mem-path=3D/tm=
p/cxltest2.raw,size=3D512M \=0A=
> > > > -object memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tm=
p/lsa.raw,size=3D512M \=0A=
> > > > -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \=0A=
> > > > -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,sl=
ot=3D2 \=0A=
> > > > -device cxl-type3,bus=3Droot_port13,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa=
1,dc-memdev=3Dcxl-mem2,id=3Dcxl-pmem0,num-dc-regions=3D1\=0A=
> > > > -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G,cxl-fmw.0.interl=
eave-granularity=3D8k"=0A=
> > > > =0A=
> > > > =0A=
> > > > Kernel DCD support used to test the changes=0A=
> > > > =0A=
> > > > The code is tested with the posted kernel dcd support:=0A=
> > > > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/ke=
rnel/git/cxl/cxl.git/log/?h=3Dfor-6.5*dcd-preview__;Lw!!EwVzqGoTKBqv-0DWAJB=
m!RHzXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7l=
r21q5Iza3M$ =0A=
> > > > =0A=
> > > > commit: f425bc34c600e2a3721d6560202962ec41622815=0A=
> > > > =0A=
> > > > To make the test work, we have made the following changes to the ab=
ove kernel commit:=0A=
> > > > =0A=
> > > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c=0A=
> > > > index 5f04bbc18af5..5f421d3c5cef 100644=0A=
> > > > --- a/drivers/cxl/core/mbox.c=0A=
> > > > +++ b/drivers/cxl/core/mbox.c=0A=
> > > > @@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CX=
L_MEM_COMMAND_ID_MAX] =3D {=0A=
> > > >=A0=A0=A0=A0=A0 CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),=0A=
> > > >=A0=A0=A0=A0=A0 CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),=
=0A=
> > > >=A0=A0=A0=A0=A0 CXL_CMD(GET_DC_EXTENT_LIST, 0x8, CXL_VARIABLE_PAYLOA=
D, 0),=0A=
> > > > +=A0=A0 CXL_CMD(GET_DC_CONFIG, 0x2, CXL_VARIABLE_PAYLOAD, 0),=0A=
> > > >=A0 };=0A=
> > > >=A0 =0A=
> > > >=A0 /*=0A=
> > > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c=
=0A=
> > > > index 291c716abd49..ae10e3cf43a1 100644=0A=
> > > > --- a/drivers/cxl/core/region.c=0A=
> > > > +++ b/drivers/cxl/core/region.c=0A=
> > > > @@ -194,7 +194,7 @@ static int cxl_region_manage_dc(struct cxl_regi=
on *cxlr)=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cxlds->dc_list_gen_num =3D e=
xtent_gen_num;=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(cxlds->dev, "No of p=
reallocated extents :%d\n", rc);=0A=
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enable_irq(cxlds->cxl_irq[CXL_EVENT=
_TYPE_DCD]);=0A=
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*enable_irq(cxlds->cxl_irq[CXL_EVE=
NT_TYPE_DCD]);*/=0A=
> > > >=A0=A0=A0=A0=A0 }=0A=
> > > >=A0=A0=A0=A0=A0 return 0;=0A=
> > > >=A0 err:=0A=
> > > > @@ -2810,7 +2810,8 @@ int cxl_add_dc_extent(struct cxl_dev_state *c=
xlds, struct resource *alloc_dpa_re=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 dev_dax->align, memremap_compat_align()))) {=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rc =3D alloc_dev_dax_range(d=
ev_dax, hpa,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resource_size(alloc_dpa_res))=
;=0A=
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;=0A=
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rc)=0A=
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;=
=0A=
> > > >=A0=A0=A0=A0=A0 }=0A=
> > > >=A0 =0A=
> > > >=A0=A0=A0=A0=A0 rc =3D xa_insert(&cxlr_dc->dax_dev_list, hpa, dev_da=
x, GFP_KERNEL);=0A=
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c=0A=
> > > > index 9e45b1056022..653bec203838 100644=0A=
> > > > --- a/drivers/cxl/pci.c=0A=
> > > > +++ b/drivers/cxl/pci.c=0A=
> > > > @@ -659,7 +659,7 @@ static int cxl_event_irqsetup(struct cxl_dev_st=
ate *cxlds)=0A=
> > > >=A0 =0A=
> > > >=A0=A0=A0=A0=A0 /* Driver enables DCD interrupt after creating the d=
c cxl_region */=0A=
> > > >=A0=A0=A0=A0=A0 rc =3D cxl_event_req_irq(cxlds, policy.dyncap_settin=
gs, CXL_EVENT_TYPE_DCD,=0A=
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IRQF_SHARED | IRQF_ONESHOT | IRQF_NO_A=
UTOEN);=0A=
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IRQF_SHARED | IRQF_ONESHOT);=0A=
> > > >=A0=A0=A0=A0=A0 if (rc) {=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(cxlds->dev, "Failed =
to get interrupt for event dc log\n");=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;=0A=
> > > > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_=
mem.h=0A=
> > > > index 6ca85861750c..910a48259239 100644=0A=
> > > > --- a/include/uapi/linux/cxl_mem.h=0A=
> > > > +++ b/include/uapi/linux/cxl_mem.h=0A=
> > > > @@ -47,6 +47,7 @@=0A=
> > > >=A0=A0=A0=A0=A0 ___C(SCAN_MEDIA, "Scan Media"),=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \=0A=
> > > >=A0=A0=A0=A0=A0 ___C(GET_SCAN_MEDIA, "Get Scan Media Results"),=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> > > >=A0=A0=A0=A0=A0 ___C(GET_DC_EXTENT_LIST, "Get dynamic capacity exten=
ts"),=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> > > > +=A0=A0 ___C(GET_DC_CONFIG, "Get dynamic capacity configuration"),=
=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> > > >=A0=A0=A0=A0=A0 ___C(MAX, "invalid / last command")=0A=
> > > >=A0 =0A=
> > > >=A0 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a=0A=
> > > > =0A=
> > > > =0A=
> > > > =0A=
> > > > Fan Ni (7):=0A=
> > > >=A0=A0 hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to outp=
ut=0A=
> > > >=A0=A0=A0=A0 payload of identify memory device command=0A=
> > > >=A0=A0 hw/cxl/cxl-mailbox-utils: Add dynamic capacity region represe=
ntative=0A=
> > > >=A0=A0=A0=A0 and mailbox command support=0A=
> > > >=A0=A0 hw/mem/cxl_type3: Add a parameter to pass number of DC region=
s the=0A=
> > > >=A0=A0=A0=A0 device supports in qemu command line=0A=
> > > >=A0=A0 hw/mem/cxl_type3: Add DC extent representative to cxl type3 d=
evice=0A=
> > > >=A0=A0 hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add=
/release=0A=
> > > >=A0=A0=A0=A0 dynamic capacity response=0A=
> > > >=A0=A0 Add qmp interfaces to add/release dynamic capacity extents=0A=
> > > >=A0=A0 hw/mem/cxl_type3: add read/write support to dynamic capacity=
=0A=
> > > > =0A=
> > > >=A0 hw/cxl/cxl-mailbox-utils.c=A0 | 389 +++++++++++++++++++++++++++-=
=0A=
> > > >=A0 hw/mem/cxl_type3.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 492 ++++++++++++=
+++++++++++++++++++-----=0A=
> > > >=A0 include/hw/cxl/cxl_device.h |=A0 50 +++-=0A=
> > > >=A0 include/hw/cxl/cxl_events.h |=A0 16 ++=0A=
> > > >=A0 qapi/cxl.json=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 44 =
++++=0A=
> > > >=A0 5 files changed, 924 insertions(+), 67 deletions(-)=0A=
> > > > =0A=
> > > > -- =0A=
> > > > 2.25.1=A0 =0A=
> > > =0A=
> > >=A0 =

