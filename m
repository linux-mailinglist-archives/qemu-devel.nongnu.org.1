Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F267B7910
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 09:53:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwfa-0002W1-Oy; Wed, 04 Oct 2023 03:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1qnwfU-0002Tr-MG; Wed, 04 Oct 2023 03:51:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simon.rowe@nutanix.com>)
 id 1qnwfQ-0002pR-Hz; Wed, 04 Oct 2023 03:51:39 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3947Ik6L010328; Wed, 4 Oct 2023 00:51:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:mime-version; s=proofpoint20171006; bh=TAl4w+SZZCf
 kRuXY2pErTHXtknnofbxjkrqqN8PJ2AU=; b=cf2IYmq4XvVd6X9PMcXrmkXY/Vw
 GqKmORKJ8HOBDkH/hUhnhVnyrpEYNrY/DWYqijvNUNJLkYMU//QOB8HAzFJe06uC
 c5PFTR4pM5c0pkGHtnMUlcRO78KYC62k3XoQ7/kDDUNMdXDJEMx/aZwP7iJyGpOp
 bPMFIwXGpWOG0c0mpCc+1u8EiEE5FWhZlHwer21sWQZloUTG93tGwjcQ91CtlQeK
 kofdNHpPQKB6toQsLyWFqDao8KS6uaWADQOxvOpzOuQyx5v77Lwy87dWD4rKJKrd
 j9vr+NVfgCXheIGg7mGnPsXmTwEskFQZQnnApVYKfUX7FH2ZivX4jHHui0w==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tehsfg2k5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 00:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsR0P6Ud4wnAVsYhZJ58U1LfZV/s2OSScOW2ZNw9C/YEAuWNBqJEC8xdChjnBWguYaMMODTkyfYv9NbP1+Wt4DVrRdA62RPJTqVNMOQy9SGzuai0pXcri/IgjHcMltErIWFwA/lX596lZIaHAF0lLFxSNWXtzltAC/67BdY9s5x6tuvZFkeRDmLqc4pS/gS5rOk+FtU3vGttoT7UHNUFS4tDS4VQAWDI4HFZ9ga4q43b+aM4C06ditPq+LyKMwNvoZS6TehTSR5DDYO9DZVrJA+nyJCobCYAgKUx/T/FMmS/XeO4MZXC8oLjLXY4OeSVCxYJ9uPxO6lS4oI9m68e0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAl4w+SZZCfkRuXY2pErTHXtknnofbxjkrqqN8PJ2AU=;
 b=A1rR1cXc9w9uKOi1WhFwLMyfGBGEyXOAwvWkbxISAAfRGv11HFjqleWBUdq8VYp/tBBd8lT3U4Vg/zzZLouFKUIqJ6NHIqgLy1l//I3jQxuMbCVl5BnWnMcLbays/0aLSJWrxMEK1OseXO8aB+/zlAjt4d8eoMHTcZ6VERiX7ZDZCM3sNPjbpdAo6V+jcp7Z3t2IaP09se4ycL9S9F9UMYsJRrWPuHmDEV5OKk2h6mCKE4OgbTeqEQHomURMzhOrv7MXcYssdB0/dKpCXUAQ86obbnsQ4gfHbTjO4y3bIdP+sFN9cCip+ICcaSHbP4TUOftuRqQWwhsOJd190vTnrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAl4w+SZZCfkRuXY2pErTHXtknnofbxjkrqqN8PJ2AU=;
 b=XrxaWLayXx8wMtagpqmFLXujRLWl8VUFiEnA852yV4/xzlMGK+XEXxjoDjm1HYktDfbH4H5fp8HFGYb9gJ1eViO/+YdYjQ011YErQ97FnW8Ol/fPLKNm2BlAt/Tn2795ITe8X5Flw6N/1U0oldbK7kPcSKxv1hiP6E/bE0Wi4ZyAk5tmHTSxBZ7WDiMZWvivD8DWHz39pUj0xPiLl4y1DWSXNdIuY4c72+0M5KWKTAU0hqQ48YlQN4LLPoyAC2CNI9karXhRmOrypTcjnKR/0YrW9LmYbhErrRNMXxm1fEJ8Cm5OXMXIaLkAPsI2HY/+q1SlrptByigLqZZXWurRnw==
Received: from DM8PR02MB8121.namprd02.prod.outlook.com (2603:10b6:8:1a::12) by
 DS0PR02MB9600.namprd02.prod.outlook.com (2603:10b6:8:fc::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 07:51:30 +0000
Received: from DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::b986:4843:ab24:54cd]) by DM8PR02MB8121.namprd02.prod.outlook.com
 ([fe80::b986:4843:ab24:54cd%7]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 07:51:30 +0000
From: Simon Rowe <simon.rowe@nutanix.com>
To: John Snow <jsnow@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>
CC: qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Fiona Ebner <f.ebner@proxmox.com>, Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [PATCH 1/1] hw/ide/core: terminate in-flight DMA on IDE bus reset
Thread-Topic: [PATCH 1/1] hw/ide/core: terminate in-flight DMA on IDE bus reset
Thread-Index: AQHZ7KWy58usN3As2U6v1H3wKmYsk7Ar+paAgAwxs4CAADIggIAA9uFz
Date: Wed, 4 Oct 2023 07:51:30 +0000
Message-ID: <DM8PR02MB812138337E05E8A9836492F993CBA@DM8PR02MB8121.namprd02.prod.outlook.com>
References: <20230921160712.99521-1-simon.rowe@nutanix.com>
 <20230921160712.99521-2-simon.rowe@nutanix.com>
 <CAFn=p-YL_hmnrFY9hhuMgMkV4hL3dojMMWUdG9=DBGYuxi_TUw@mail.gmail.com>
 <ZRwf3rInMRkzD/sq@x1-carbon>
 <CAFn=p-bmMxJmVj8v31NsRpQd3bHd5zeeRbxQj6bDxUC8Tqh4CQ@mail.gmail.com>
In-Reply-To: <CAFn=p-bmMxJmVj8v31NsRpQd3bHd5zeeRbxQj6bDxUC8Tqh4CQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8121:EE_|DS0PR02MB9600:EE_
x-ms-office365-filtering-correlation-id: 96ec61c5-7dc7-43fd-ff94-08dbc4aeb88b
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WAtbDNEiZQXmJfAD7v4Tn72NCIFvUKLJzsKn2wxnbUhKLF3jfOV5Olwk/xNTKFf2oUUnzjL7cKJDaiDNAM7Z68VsNlweSJn5WJr+htlmx6v2vez2F4yJpuoQNTZ3GHGMKYmW4CtdR24EwosIu49ozKBqLAOMGRMSQu3+gdazTIcu21p3C3Wa7b8XjrWhBRoB/WfWbO3QfFvkUpYzTtXqgMm3scAOZJ4luoW+RfLlj4CKVFOS4pf5GHc08paYTLHZqAgC0yvg8r4qKQ6Zvcibvvrk0NvZFqmCot8c2Eix1CfgcU09DvTLEW6MGyZfEhog0vxf9FD5AvHxSm5PgWP/QnBNefftiSq6hJVy8ZfjMwxQSILdYOR17akqoq99dYjUchH4phiCKYJpKHQ5aZpeEg9/MUhPrd5vxi9Hg1xOCs3SoaU9DZLyscUwOR0tYvYht1swkfi9uDw4h4jjZUQZNC+ROR+Jpitly42TexJ33QUYmHPITZIQdXkic7drAQ+H58K3wknnC+hfZhCzW7/WAwa8PcNBgj16JmOfsUy6RQ610rRFA2rSXxqiyXMm0zLu/xkSZ9cmoCP0xqTtqGghvzLRLvMRBqSN3EA8EjaSMbbAtMH/dPfiHDeh9hi1nIF7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8121.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(55016003)(6506007)(71200400001)(478600001)(7696005)(86362001)(122000001)(38100700002)(38070700005)(2906002)(4744005)(41300700001)(83380400001)(107886003)(9686003)(26005)(110136005)(33656002)(66446008)(64756008)(44832011)(54906003)(5660300002)(66556008)(66476007)(76116006)(66946007)(8936002)(8676002)(316002)(52536014)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?91oF+tqRmzOwSz3rNdyeJBF7My8sKWuHpuM9cnQcfRUiFlPF8orUqEJz?=
 =?Windows-1252?Q?jh+c9erDjvICYf5+9UIKu5OEpZlEY1u807VR+VEHhgyjA/lJRkjuR/ls?=
 =?Windows-1252?Q?ijJQME10/qLmBlolhXVKCdnmIi4oTiPZAWv7RP57iV8rRRv9F9F2iELb?=
 =?Windows-1252?Q?jBuu4HlKw6fc0H3pkm0ElKWeI+mk1h+lFZx7QO8w6G18CMNbyBG1YsZY?=
 =?Windows-1252?Q?fpc5Zji5roBiSu74AJjZXCF/lpom+PrGipjjvDzy96iZeemY9ls+7iA6?=
 =?Windows-1252?Q?sLfrFnBmYwfkXxIz5kLZXoIW2ekkcYpC6m8NzS2PyoilI3V1CPVmJQVh?=
 =?Windows-1252?Q?L3eWhnAMCYdsRhsEoT19ZeeAVcLlXRTi5bMnFQNjtOCqMB5CJsHc0iNP?=
 =?Windows-1252?Q?O8jjSfnXTVvbNUlEiHbvXjmmvFSfCy6hi1d2XnEdrskFZbj//Ktp27/B?=
 =?Windows-1252?Q?UJ/SMU9Bomy2aH1lBMqO8nH/v7Q/3higUxRaCDaskqHc70hHbum8PFHK?=
 =?Windows-1252?Q?3ShQS1vp90a8SOvbxS7bzF83ESogLUxVZgifSNqjo7I6BT0V/qgOOhMZ?=
 =?Windows-1252?Q?FuRm+T3uJmxolHx2gWx0dhAl0ejMOTamJC0vz5EZH9Ju8jTYOz/yv8Ls?=
 =?Windows-1252?Q?PyrHnTk5G9CYmQd6mmv9BhFE29Q++o3RJNDFByRfve5Uoj0bIuUd8gU1?=
 =?Windows-1252?Q?EBfymNWV9pgBqQ4qCJ1/qx8UPghhp03MT1TE7WGCrgjS+e2fclIK5y90?=
 =?Windows-1252?Q?4M44ulCxUv9NSTMOmfDn/J/2qYQFkvZ0TIhUsKHdwGxUFZ0M0OIKeRS5?=
 =?Windows-1252?Q?7vGU1RSWKXI9e8JUrIWZdQnoK2oxWFu+CxBWAUYDF00a/piHnEML+WqK?=
 =?Windows-1252?Q?soI9iJw5PDDqJ0tpAGXF77bQidXZets5IEBo8rawkWLJ3LENowsu/vIO?=
 =?Windows-1252?Q?0bDaosD1UTbQ3z+L0seVGSaVMhM+woNKflzH6dRpa28H+jFmCf/fzUQm?=
 =?Windows-1252?Q?J3W4nTjur/ZI/+osNg0YH8M8oc5+KJ89IPbx8hiLLqec3wByItUXfpP5?=
 =?Windows-1252?Q?C3+A9+Nndvxd0N3gKDcjLY9hyzkuJbdbuqxpV3VVpWDwfvA+wDRYxbSS?=
 =?Windows-1252?Q?UfIHh7Z/hk5vFBp2fshC7E0/8gCgMedHjAk1n1cM8C+esG0Cg4iAZml/?=
 =?Windows-1252?Q?8lOgib2YildXS7t24klJ+1PUz/rok0GoO+hNVRKKIP9Dt3SMlFveFp3+?=
 =?Windows-1252?Q?W8FSmhSNNqADpwHYH+zpA33/gvJH3w5MjGZgeVZEFiUjyWohMFDfm0MS?=
 =?Windows-1252?Q?WfSP6gdj/KLU6E1M9bjniBoowagdFw0mzQWPDjP0Vt7BYcqI8uzaa1EP?=
 =?Windows-1252?Q?4abGuVgKUSCuihG7cmNEfZItmmAHIGjdE3rAV6M3pYSPfetwS1/rg0VN?=
 =?Windows-1252?Q?ATDNRioY+NhG8mjCJTmEOVtc5kRNJujWjfFcC5NgEnjhkhwA6L/DAlcm?=
 =?Windows-1252?Q?rKIwNtBMnOiCFcQ0UTeMOdlUwdVBIw+YKYoxrGi/BHr5AWpiXReE03MN?=
 =?Windows-1252?Q?qLEtJL7UVdsmKP2FyJsN+gbBJ8JzyJ6up64fIl6x7ATevN5KDxV+02kq?=
 =?Windows-1252?Q?TWVx7fQahCcRY1jkSkOqnFaN9mYk8B8K92CAk6NuMRvvi34U6QVjJcyk?=
 =?Windows-1252?Q?WC9I6ZqjEu229ZIzDug1gCVJxyZ6RLtLA6bjqfadKaRVN6fVGbemWA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR02MB812138337E05E8A9836492F993CBADM8PR02MB8121namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8121.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ec61c5-7dc7-43fd-ff94-08dbc4aeb88b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 07:51:30.2546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ZPVRemOdi+/mIeGxfCX+xjX4bdmwC/5jyXwKzAuq82PLvzYSlP/qkOUYOTOU96WpBgBi1xWPyYbRpLSXt17YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9600
X-Proofpoint-GUID: yG427xxuOVBunJI3F2dvfgPZcuN9EiCp
X-Proofpoint-ORIG-GUID: yG427xxuOVBunJI3F2dvfgPZcuN9EiCp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=simon.rowe@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_DM8PR02MB812138337E05E8A9836492F993CBADM8PR02MB8121namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

On Tuesday, 3 October 2023 John Snow <jsnow@redhat.com> wrote:

> Simon, can you confirm that Fiona's patches are appropriate for your repr=
oducer? In the meantime I'll do my
> own audit for the problem as you described it (thank you very much for th=
at) and see if there's anything else
> that needs to be addressed.

I=92ll run it through my setup and give it 24 hours testing.

Regards
Simon

--_000_DM8PR02MB812138337E05E8A9836492F993CBADM8PR02MB8121namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">On
</span><span style=3D"font-size:12.0pt;color:black">Tuesday, 3 October 2023=
 John Snow &lt;jsnow@redhat.com&gt; wrote:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; Simon, can you=
 confirm that Fiona's patches are appropriate for your reproducer? In the m=
eantime I'll do my
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; own audit for =
the problem as you described it (thank you very much for that) and see if t=
here's anything else
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; that needs to =
be addressed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">I=92ll =
run it through my setup and give it 24 hours testing.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Regards=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Simon<o=
:p></o:p></span></p>
</div>
</body>
</html>

--_000_DM8PR02MB812138337E05E8A9836492F993CBADM8PR02MB8121namp_--

