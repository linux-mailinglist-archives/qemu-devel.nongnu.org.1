Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8D593BC8F
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Jul 2024 08:34:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWs2Y-0004f4-ST; Thu, 25 Jul 2024 02:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <y-goto@fujitsu.com>)
 id 1sWoa3-0005ow-4d
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 22:51:47 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <y-goto@fujitsu.com>)
 id 1sWoZz-0004uW-Fy
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 22:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1721875904; x=1753411904;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aNJ2QXcBzMtZOqwSKS6jCWb1j1NibY32P1OoeFSxAuQ=;
 b=xbhrag+xTBbjYbmcMuHLpEjoxbww/mk9IrZrR/nUVriATo3oZWx8tkli
 pIdl0l+mQgce7dxly0y2FWYFr1loPLy0H6zfjrhO1hJ4E3vpvrjL3vOxq
 CF07zH+7FwZNiHL75o/8uMaZhL9/BuirkXOUhOA8mSnZU0dfDp1HeEOJi
 zEhSzOvYc9pnu9dXkPs8mg4lTrpAi+OVWotV9Yv6Jsc4cAXtYBSP09wdD
 TWAwMc7WL+93bXyPIpTvyVxgF0lSdNnw2NDAm6Qb9xKcMUl+/nCmzxqAN
 dm59+0g9x84sXdyYurKd1pBHd+Pcaa8C+0M+wQIkk8CLYEztZwCETQ0QG g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="125960579"
X-IronPort-AV: E=Sophos;i="6.09,234,1716217200"; d="scan'208";a="125960579"
Received: from mail-japanwestazlp17010000.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.0])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 11:51:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmfjdqQLWsOs+VHWvIoB7gbHiVfD1fS/nTS4p3Ycj46JVhS5NtsjK1oRyTekC79crwlc2B2nHXEnfsphJI337k6K/Gdo6mi5rxCok9qrMKSA4lQg3quFb5i6LI0a4m7bIf8j0RkOfWBaAmsyG9TpU9naMGCh7m0IPWFHCoDcOd9ddVgFgDeZd0uvkVxS2f+fGI/q7OBaLXglpKfw4OFXL82irLz3imjBUn6gxoW8Y8SPVMQ7heamwTguM8Dc6qn38XyYMazWq2CBfGvstXzUrkVD5NKpnW3q1T4ZAl/ZYW2YoukOf0wP5d/4CW25TsN+kCASjtYtIIzTBxMzmfRUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNJ2QXcBzMtZOqwSKS6jCWb1j1NibY32P1OoeFSxAuQ=;
 b=jU0rr/SUwVgUTwAiFExIIYCbNwI142v/1KuSH/5i9JHzUlb1lPn1arXmoMcLtzMZ8zvzREVnfsqVJe48X9XoUcaFOLkSxQxV24ymHBJOVhh3oPXnK4+yYUTObCrczcW95HiSgI7IUUJdUV1VbC6R24D4Qo4LBGCLTSbcTu9Gf+eX9FeOmdAsFnuVFISIYDA0CMAUtxQex+nT89AWprRYmJ6g6qwvOz0dqf0l7ejwOnJAkO4wyuM8suuUgXoCJSuudo7WpZe/hCJ+ZIH3qbbKoMrgl0p9NkxbHe/vWQ+9OQmON937H6WQ7tgG0oauX1Bfqcddw5+/xdjpxBqW0Qn8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com (2603:1096:400:1e3::8)
 by OS3PR01MB9769.jpnprd01.prod.outlook.com (2603:1096:604:1eb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 02:51:32 +0000
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::9a0b:13f0:812b:69f5]) by TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::9a0b:13f0:812b:69f5%7]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 02:51:32 +0000
To: Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>, "ira.weiny@intel.com"
 <ira.weiny@intel.com>, "Shiyang Ruan (Fujitsu)" <ruansy.fnst@fujitsu.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>
Subject: RE: [RFC PATCH] cxl: avoid duplicating report from MCE & device
Thread-Topic: [RFC PATCH] cxl: avoid duplicating report from MCE & device
Thread-Index: AQHawaAoWgk8pjOOskeQSU0FFeNEPbHSg+kAgAYH4QCACjtogIAboFIAgAQfNQCABGqdMA==
Date: Thu, 25 Jul 2024 02:51:32 +0000
Message-ID: <TYWPR01MB10082E47A7175979826DE676F90AB2@TYWPR01MB10082.jpnprd01.prod.outlook.com>
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
 <6675bd86ea005_57ac29411@dwillia2-xfh.jf.intel.com.notmuch>
 <965e2c27-6147-4237-b4b6-6aaf74363aa2@fujitsu.com>
 <1fab087b-eb6c-485e-a2ed-f86e8dfacc5d@fujitsu.com>
 <ec0f2e8d-e783-4211-8d41-2b9a6df67049@intel.com>
 <b537967c-eed7-4265-9a9e-3925d49aecef@fujitsu.com>
In-Reply-To: <b537967c-eed7-4265-9a9e-3925d49aecef@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZThhODEwZjctYWU0OS00ZjVmLWE5OTktM2IzY2YwNjQ0?=
 =?utf-8?B?ZTgzO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjQtMDctMjVUMDI6Mjg6MTFaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: e524b4078da04fa782943bfb827579ce
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10082:EE_|OS3PR01MB9769:EE_
x-ms-office365-filtering-correlation-id: 4ad88181-972e-494c-4a5f-08dcac54b103
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?aFZpeXEzd05Qd0xkT2VtNWRLbFBIbDA0R0RLK1k0U0ZxV2dWbldBK3hmSE9k?=
 =?utf-8?B?aThOc1RTV2t3aGdyRHh5RXArempUOXBUV3E3UktzcDZaMkFmNWxUVmVVdUVD?=
 =?utf-8?B?bU1HSmlHM1pYcldmbHJ1RjhXOTcvQzUxa3BzSWlueklBbjhsOFhSdnlOb2ZS?=
 =?utf-8?B?cW5DbmdkK1IzbHIvZUJyTXkzOVZ2SjFYancwT2VBTDRqdWdnblpnazlvZW5Z?=
 =?utf-8?B?Vml0VXpOSVpTVHVRa2xOVk1Yd2FjNk5OTHVMcVUrOUdPbnRHazFxSHhLem5a?=
 =?utf-8?B?SWJRUnFkSHpxc1d2UStUV29YQ1h0N3lmN1djOU1VVnBWN0Nra3AyQldGVHkv?=
 =?utf-8?B?YnJnRmdiVmx5MStSbjJabWlPTzhXU2NsYlhIZ012QUNBeXNNak1rZ2wrRm1z?=
 =?utf-8?B?TnZKNVN5aG85VnlDVnZrSEEvRXIxRlorenZEb1dxL2YrRmFLeEZFRk1nSUY4?=
 =?utf-8?B?Rm1YNkl2ekpuTWdoQWJBUk1QNXB3cUtZRlhwdDQ3MUxwU200REkweWZiYWxl?=
 =?utf-8?B?OTVNSXBZd09Wc3R6QTJ0eE1xY3o0MGxVcWdOc1ZUTW8va3NLelM0a3FZc09D?=
 =?utf-8?B?YnRzKytxWjlXRFRSaG1wUkxXMldYVG03NlFVcUJjR0RvTUJrU3pUM3YxTDk4?=
 =?utf-8?B?UlFtY29jWmlDUkhjR3phRmkrcW13eU1IeW0zcjBRYkF5aVhVcEhqZWxpdm0r?=
 =?utf-8?B?NjdheVNiTnhhNDcvWitwSmNhWkVsTmxCZmZFKzFBby90b0dicEowbEVVQURD?=
 =?utf-8?B?Vy8wdjJnS0xUQkViTzhHT1I5ODZKYVgyUnpEdGJPWFhjM0RPSmJFQ2x3SUJ4?=
 =?utf-8?B?MmFzN05BdmJYZXFOait3ZDRZR2xDVmJiM3NHbmgwZ1d3WXNuYnNDM0U0cE11?=
 =?utf-8?B?UitGbDdSSnRMeml3Uys4SXlESTBEVXRhbnFEUTh1d0xzSVZqZktjaUFBdDlq?=
 =?utf-8?B?bE9xeDZ0ZFlRYkZOM25mbkdrMHdDQTU0bmVHdXhGL2o4ZFpXdG9PeXQzWUlN?=
 =?utf-8?B?WGlNc0p1NGpFNGttd2tsc3IyanhxbHZVQzlLMVdjaWJTVUc0RUJXQkNsTTJz?=
 =?utf-8?B?NHhVdm12UDJzdVlMZ1Rpek9JUmlkazEyT3dFcjlyT0g2eFhlNmtiTmh1Q0VO?=
 =?utf-8?B?cjFZSm9xclhFYlNrclJ4Z2V3L1BLbks1SDVlSFpiQlVUWWxlKzg4WlZZV3pU?=
 =?utf-8?B?OVBNaTVnNy8xY3AxVWtzOFVkeDhJOWdaTisrbXlHT200U01IaXFETFd5K2pU?=
 =?utf-8?B?QjVrMU1QTG9zQit3ZTlBVnA2WDhHOXZqekxmS0FpQ2ZxWXRuRjZVdUQ3ZzhQ?=
 =?utf-8?B?eUtrTXpJUGpaalhUL0hmYW5pbmhIcVFiWWVaV29KV0JLNHhvUjQxQ3hDanNS?=
 =?utf-8?B?VHdCYzBmSldCK2x2cmNZZ29HWW5PbzZkQXk1cFZmWWhRcVIxWURHamVsVGty?=
 =?utf-8?B?UEdOSWR2ZjRBS0JJZVhyYWZVZ0czNDM1aE03djR4bnN3Rm9sMERSdE9KTHRm?=
 =?utf-8?B?U0gvNnpBaWtzRnJTNWlTV0NWZjNsRiswaGI2RXRMMi9aUC95c0FOelJBY1Rp?=
 =?utf-8?B?WkZGMytzL20zYm8wUkllTlZXR2QrbHBIQ1JrOVluWHRkM0dMT3AvNVYvMkZG?=
 =?utf-8?B?M0lacGRQbEs3ZWFKWnV1VUVqcnViV3owLzRrSzhkZGNNNmoyQUxqc29JYVhz?=
 =?utf-8?B?akxMUlJWby9lWXZWNVhZK1p0QWhrQnNHdkVBYkdVQTZQMkxlZFJWYktMTFkr?=
 =?utf-8?B?N3gwekd2WTNicVk0ckQvMTNETTltUDV5VnNTMkd4WHhiN0tYWERETHFrQWtM?=
 =?utf-8?B?eis3cW5uelBMcGgvcm1kOGplZXBUV1crZjhJYXI0UTFXT3U3WURXTXpLS2RQ?=
 =?utf-8?B?OXVLRW1NWGFMdERWd0tPV3d5aDg3QjF3QkMxR1o2YVJqbXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10082.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDErZzFmcVhObWdUeGRZbnRTREJkUSt0enNzSnNUU1MzcG5jUGkwdlk4eTR0?=
 =?utf-8?B?d0g5Y1Z3dE1XMk9QYXRoVTBTNjRMaEZuRDdpY2NMRjd2c0NYell6NzlLbW05?=
 =?utf-8?B?SFhlRXJvRjl3ZTIyZ0lLUCt3aVliMGNiUytUSG9hOUtpMTNxVFJGU2VPSVFK?=
 =?utf-8?B?bUMvQkhFcFB6VktzcWhnZlIvR1ptVE1XdlFqRFF1N0VibW82UXhlczd0RGl4?=
 =?utf-8?B?Qm1uUFdkMStNME56eEtPdFpWL1NQY1ovZlprZVBaVFNoVGN5WjVETUV2cHY0?=
 =?utf-8?B?VUppUmx1dlRKS25QRGtia3hYTDRJOHMvY1BFeHlwQTRkYWZySVVuVHdydDNO?=
 =?utf-8?B?Q1p3YzVycDBrTlN3bkJkaFd6L3pxWjZGaUFuT3hTRThhc0J3aEJTcGw2bEVa?=
 =?utf-8?B?Y2RHeERseXVoL3pheDN6MFVIbWpXUlM1bzBxL2JTVWJNMVMweVJCRDNlNHpi?=
 =?utf-8?B?dlNKRUtTVWF2eS9JTUxxZ1RyVTRPYTVTREtHc0VUQUgzaW9XWU8zSjgvNlFL?=
 =?utf-8?B?NC9JL1FmdEdhcVhDRUUxamdvaFV2WHZmRWJvdnhEcU5ZTEZpa0JMazVVKzZr?=
 =?utf-8?B?STliVkVHWUt3ODB3NHZwc24ybXFjZlNiZWNrbEk4dHNRcExTVVdETVMrUGhp?=
 =?utf-8?B?cmlOZ3BodU1KbllvY2FQclNXU0d3WUJleklPd2ZwVUxLNjFUVWl1dVhpNjg4?=
 =?utf-8?B?MlRoNkxrbkY1Q2VoWktINDVQNmtiMkhiOTk1S1kvdEFwRW4yWlE2eG9BYmNE?=
 =?utf-8?B?K29peENvSUE2RlppaTJSQXFzZnFXQVdHL1pVZXpTeHhLRXB6eVFKSDkrTmxK?=
 =?utf-8?B?TDNVSHBoQVpYTUNDamoxMGNNc1lIRHpZcGx0WmRBcU1vd0srK0lvSmlKaC9M?=
 =?utf-8?B?c0hTK3N3cEVqYWdKYkpzV2lCVGNmbi85WHRRVEhWSFBPWmhOVXBwTEIrRkk0?=
 =?utf-8?B?MEtaRCtMOHMzUXk0ODltYm96bTJ2QUEzL1lIakw5UDBEbWRNS3BhSVN3WXVQ?=
 =?utf-8?B?Q2haZ0FhK0hUbEV0dll1VlNFK1RtOW1ZK0IweUtZbkVjQVo1RW1STURYWlZT?=
 =?utf-8?B?T3lTaGF2THRLSzNESTJwTHhrZGRnN0MzT1lUT3NHVzc2UzZSSUFEM09Jcjgw?=
 =?utf-8?B?UDViaHhibjdyemNmZ2I1V1hvNWR3bkZ3Z1R0TGI4VEFVRis2VnpmdGdrNHht?=
 =?utf-8?B?TTRHcDVWd3phTVNlbG5Ta2JEaGlidms0WTNWNDJyQkNsMEQ0QUpnZFdHUGgz?=
 =?utf-8?B?emV5Rzdaam9QZmhuNkxITHBpRUp5MUZkSDdpdXZtTnN0TTNXWHBDdWYvdUhx?=
 =?utf-8?B?Vk16dzkvWnR2NU8yc1ZyMnJXbE9sbWR5dSs4RmhYTXVXK0t1TGtXRVkwNjM1?=
 =?utf-8?B?L00yMkNRZHFnYktCWDkzOEtnTEFXODBWbjBIbHhRNVNjYjNaMlNjdk9hUFVu?=
 =?utf-8?B?dG52T0RmQ0t4anhIQ2Z2VFZqRWp4NmR1dHBuZGVFck5aaGNlcnhVTG42SnpQ?=
 =?utf-8?B?Nmlsa2xROEcrQWNmdmx1MW1ncDUxbGswZzdKbEpBMXduRHRmZ3F4Tlk5MXVY?=
 =?utf-8?B?bVcwRm9EazdsalYyVjV4ZWMyNDVUb29ORXNqYXRZVlNrcThjcWp2ZHlkdXgz?=
 =?utf-8?B?NEFvNmg2TytQM1M1ZGlZNU0xWmZ5c3JIcWc0WmFSb2NKbThUbEJnS2dwTk5Y?=
 =?utf-8?B?azJvbm1mcXRwaFBrWktmWDl6UFg4V3FMZ0ZnK2l5c2k3MmJ6TktvZm11L0oz?=
 =?utf-8?B?Vll1dVNFaHRPNUV4dUswSHZ3dVZGbUpUZEM1U3FJc1lPSHBHeDJQVndmOGtj?=
 =?utf-8?B?b0poekNjeGhYQkhtejh4MTdCYXJZK3lXNytwcXU2T2ZNdmJTYnIzRjY0MW5q?=
 =?utf-8?B?eWQ1NzNqQUpsYURCQU85amtLR003ZTN0ckdhMytwWUp5SGFIdmRhWmNrTHFQ?=
 =?utf-8?B?UU8zOEV6ajZvU3FZeVBOZVFxbnkvVWtCMkZVaVk1MkowTm1lOCtGRkRtWE02?=
 =?utf-8?B?WElEL25QVEZDcXVjSFRVNitqOHhmL2x5UjFWc254QVl1WTBoUGRKOFErN3BW?=
 =?utf-8?B?R2RLNWRZSzAyMWxrT2hSSnl5RjNqdUVtczExUHl6U1JZVnFyejVZc3BtczM5?=
 =?utf-8?Q?bwHdxQEhWgMuaRG2CuQY6YmRc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QeXB+iyUF3LWaomCuwuko8vOq7OHUS8PEPYXgk0Mr45Ye1KGFYqnEF0b6ZtklNELBDp3uCjQpNJhK5UsL7eNnalK07Q6MvFLmU/l+ACc2xlcwoys0hwFQtfw7p/TFRD8v3yxDXSpl+/8eUm/7Cb3kVex//HoB8BHAvKYAGlWCC9vlypgG5YEEQ0q+ukqJlOaEdL7SlD040cCX6UCi6iCaFdf5H9VIIfoYDnImqBwTkZgHyYAAr9f+enDau8IS6X+rT1WYLC/G0saXlfJCLgGr9Umh2oc4Jaq9wdEkxQf7txAm7K+Biob3omfvkzoLqDeRiZ4JsUDtx9n1Zbh6Q3ygmEFzYOOcBB4eMWD5QDLvNKmBGdgtbhwVOdHVcsZ2sHp12N7nC9K1yd4vhidLiuGr67rdTleRWKfEIxr0N2/S43nLSE4HzO2z2X/hCgN64mkcENVKMu0jYtODgdwto+VAyv8kRz4T3XcUjLkU1/uB7yEHTSPnV7aTOyKkpXXnxQXmcTTYQox33uZcghz8uofJ0sNf0hoPbdZxaqfkb3iRvzLTW19hPZzZ/9ZHV1XXKr3h5Jttof6WX2sQuGlrUFieEB216/kKA89VtCkR3UjCze6G/BFn8QsPsX2+eFrsAqQ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10082.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad88181-972e-494c-4a5f-08dcac54b103
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 02:51:32.6630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5b8lV8yUuAAYLAGKkUN86dD/JhG1XFDCIRClyBWXvLjbDRnT+jfkTPKrsfR2pbeemBQTOis6Yt87NE7B1P/tig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9769
Received-SPF: pass client-ip=216.71.158.65; envelope-from=y-goto@fujitsu.com;
 helo=esa20.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 25 Jul 2024 02:33:24 -0400
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
Reply-to:  "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
From:  "Yasunori Gotou (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

SGVsbG8sIGV2ZXJ5b25lIQ0KDQo+ID4+PiDlnKggMjAyNC82LzIyIDE6NTEsIERhbiBXaWxsaWFt
cyDlhpnpgZM6DQo+ID4+Pj4gU2hpeWFuZyBSdWFuIHdyb3RlOg0KPiA+Pj4+PiBCYWNrZ3JvdW5k
Og0KPiA+Pj4+PiBTaW5jZSBDWEwgZGV2aWNlIGlzIGEgbWVtb3J5IGRldmljZSwgd2hpbGUgQ1BV
IGNvbnN1bWVzIGEgcG9pc29uDQo+IHBhZ2Ugb2YNCj4gPj4+Pj4gQ1hMIGRldmljZSwgaXQgYWx3
YXlzIHRyaWdnZXJzIGEgTUNFIGJ5IGludGVycnVwdCAoSU5UMTgpLCBubyBtYXR0ZXINCj4gPj4+
Pj4gd2hpY2gtRmlyc3QgcGF0aCBpcyBjb25maWd1cmVkLsKgIFRoaXMgaXMgdGhlIGZpcnN0IHJl
cG9ydC7CoCBUaGVuDQo+ID4+Pj4+IGN1cnJlbnRseSwgaW4gRlctRmlyc3QgcGF0aCwgdGhlIHBv
aXNvbiBldmVudCBpcyB0cmFuc2ZlcnJlZCBhY2NvcmRpbmcNCj4gPj4+Pj4gdG8gdGhlIGZvbGxv
d2luZyBwcm9jZXNzOiBDWEwgZGV2aWNlIC0+IGZpcm13YXJlIC0+DQo+IE9TOkFDUEktPkFQRUkt
PkdIRVMNCj4gPj4+Pj4gIMKgIC0+IENQRVIgLT4gdHJhY2UgcmVwb3J0LsKgIFRoaXMgaXMgdGhl
IHNlY29uZCBvbmUuwqAgVGhlc2UgdHdvDQo+IHJlcG9ydHMNCj4gPj4+Pj4gYXJlIGluZGljYXRp
bmcgdGhlIHNhbWUgcG9pc29uaW5nIHBhZ2UsIHdoaWNoIGlzIHRoZSBzby1jYWxsZWQNCj4gImR1
cGxpY2F0ZQ0KPiA+Pj4+PiByZXBvcnQiWzFdLsKgIEFuZCB0aGUgbWVtb3J5X2ZhaWx1cmUoKSBo
YW5kbGluZyBJJ20gdHJ5aW5nIHRvIGFkZCBpbg0KPiA+Pj4+PiBPUy1GaXJzdCBwYXRoIGNvdWxk
IGFsc28gYmUgYW5vdGhlciBkdXBsaWNhdGUgcmVwb3J0Lg0KPiA+Pj4+Pg0KPiA+Pj4+PiBIb3Bl
IHRoZSBmbG93IGJlbG93IGNvdWxkIG1ha2UgaXQgZWFzaWVyIHRvIHVuZGVyc3RhbmQ6DQo+ID4+
Pj4+IENQVSBhY2Nlc3NlcyBiYWQgbWVtb3J5IG9uIENYTCBkZXZpY2UsIHRoZW4NCj4gPj4+Pj4g
IMKgIC0+IE1DRSAoSU5UMTgpLCAqYWx3YXlzKiByZXBvcnQgKDEpDQo+ID4+Pj4+ICDCoCAtPiAq
IEZXLUZpcnN0IChpbXBsZW1lbnRlZCBub3cpDQo+ID4+Pj4+ICDCoMKgwqDCoMKgwqAgLT4gQ1hM
IGRldmljZSAtPiBGVw0KPiA+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIC0+IE9TOkFDUEktPkFQ
RUktPkdIRVMtPkNQRVIgLT4gdHJhY2UgcmVwb3J0DQo+ICgyLmEpDQo+ID4+Pj4+ICDCoMKgwqDC
oCAqIE9TLUZpcnN0IChub3QgaW1wbGVtZW50ZWQgeWV0LCBJJ20gd29ya2luZyBvbiBpdCkNCj4g
Pj4+Pj4gIMKgwqDCoMKgwqDCoCAtPiBDWEwgZGV2aWNlIC0+IE1TSQ0KPiA+Pj4+PiAgwqDCoMKg
wqDCoMKgwqDCoMKgIC0+IE9TOkNYTCBkcml2ZXIgLT4gbWVtb3J5X2ZhaWx1cmUoKSAoMi5iKQ0K
PiA+Pj4+PiBzbywgdGhlICgxKSBhbmQgKDIuYS9iKSBhcmUgZHVwbGljYXRlZC4NCj4gPj4+Pj4N
Cj4gPj4+Pj4gKEkgZGlkbid0IGdldCByZXNwb25zZSBpbiBteSByZXBseSBmb3IgWzFdIHdoaWxl
IEkgaGF2ZSB0byBtYWtlIHBhdGNoIHRvDQo+ID4+Pj4+IHNvbHZlIHRoaXMgcHJvYmxlbSwgc28g
cGxlYXNlIGNvcnJlY3QgbWUgaWYgbXkgdW5kZXJzdGFuZGluZyBpcw0KPiB3cm9uZy4pDQo+ID4+
Pj4NCj4gPj4+PiBUaGUgQ1BVIE1DRSBtYXkgbm90IGJlIGluIHRoZSBsb29wLiBDb25zaWRlciB0
aGUgY2FzZSBvZiBwYXRyb2wgc2NydWIsDQo+ID4+Pj4gb3IgZGV2aWNlLURNQSBhY2Nlc3Npbmcg
cG9pc29uLiBJbiB0aGF0IGNhc2UgdGhlIGRldmljZSB3aWxsIHNpZ25hbCBhDQo+ID4+Pj4gY29t
cG9uZW50IGV2ZW50IGFuZCB0aGUgQ1BVIG1heSBuZXZlciBpc3N1ZSB0aGUgTUNFLg0KPiA+Pj4N
Cj4gPj4+IE15IG90aGVyIHBhdGNoOiAiY3hsL2NvcmU6IGFkZCBwb2lzb24gY3JlYXRpb24gZXZl
bnQgaGFuZGxlciIsIGFkZHMNCj4gY2FsbGluZyBtZW1vcnlfZmFpbHVyZSgpIHdoZW4gYW4gZXZl
bnQgaXMgcmVjZWl2ZWQgZm9ybSBkZXZpY2UsIHdoaWNoIGNoZWNrcw0KPiB0aGUgcG9pc29uIHJl
Y29yZCAoaW5zZXJ0IGlmIG5vdCBleGlzdHMpIHRvIG1ha2Ugc3VyZSBwb2lzb24gd291bGQgYmUN
Cj4gcmVwb3J0ZWQvaGFuZGxlZCwgYnV0IG5vdCB0d2ljZSwgbm8gbWF0dGVyIENQVSBpc3N1ZXMg
dGhlIE1DRSBsYXRlciBvcg0KPiBlYXJsaWVyLsKgIEFuZCB0aGUgbG9jayBvZiBwb2lzb24gcmVj
b3JkIG1ha2VzIHN1cmUgdGhhdCBpdCdzIGZpbmUgZXZlbiBpbiByYWNlDQo+IGNvbmRpdGlvbi4N
Cj4gPj4+DQo+ID4+Pj4NCj4gPj4+PiBXaGF0IGlzIG1pc3NpbmcgZm9yIG1lIGZyb20gdGhpcyBk
ZXNjcmlwdGlvbiBpcyAqd2h5KiBkb2VzIHRoZSBkdXBsaWNhdGUNCj4gPj4+PiByZXBvcnQgbWF0
dGVyIGluIHByYWN0aWNlPyBJZiBhbGwgdGhhdCBoYXBwZW5zIGlzIHRoYXQgdGhlIGtlcm5lbA0K
PiA+Pj4+IHJlcGVhdHMgdGhlIGxvb2t1cCB0byBvZmZsaW5lIHRoZSBwYWdlIGFuZCBzZXQgdGhl
IEhXUG9pc29uIGJpdCwgaXMgdGhhdA0KPiA+Pj4+IGR1cGxpY2F0ZWQgd29yayB3b3J0aCBhZGRp
bmcgbW9yZSB0cmFja2luZz8NCj4gPj4+DQo+ID4+PiBCZXNpZGVzIHNldHRpbmcgdGhlIEhXUG9p
c29uIGJpdCBmb3IgdGhlIHBvaXNvbiBwYWdlLCBtZW1vcnlfZmFpbHVyZSgpDQo+IGFsc28gZmlu
ZHMgYW5kIG5vdGlmaWVzIHRob3NlIHByb2Nlc3NlcyB3aG8gYXJlIGFjY2Vzc2luZyB0aGUgcG9p
c29uIHBhZ2UsDQo+IGFuZCB0cmllcyB0byByZWNvdmVyeSB0aGUgcGFnZS7CoCBBbmQgdGhlcmUg
c2VlbXMgbm8gbG9jayB0byBwcmV2ZW50IHRoZSAybmQNCj4gbWVtb3J5X2ZhaWx1cmUoKSBhbmQg
Y2xlYXJpbmcgcG9pc29uIG9wZXJhdGlvbiBmcm9tIGJlaW5nIGNhbGxlZCBpbiByYWNlLCB0aGVu
DQo+IHRoZSBIV1BvaXNvbiBiaXQgY291bGQgYmUgdW5zdXJlLsKgIEkgdGhpbmsgdGhhdCdzIHRo
ZSBwcm9ibGVtLg0KPiA+Pj4NCj4gPj4+ICDCoD4gU28sIEkgdGhpbmsgYWxsIENYTCBwb2lzb24g
bm90aWZpY2F0aW9uIGV2ZW50cyBzaG91bGQgdHJpZ2dlciBhbg0KPiA+Pj4gIMKgPiBhY3Rpb24g
b3B0aW9uYWwgbWVtb3J5X2ZhaWx1cmUoKS4gSSBleHBlY3QgdGhpcyBuZWVkcyB0byBtYWtlIHN1
cmUNCj4gPj4+ICDCoD4gdGhhdCBkdXBsaWNhdGVzIHJlIG5vdCBhIHByb2JsZW0uIEkuZS4gaW4g
dGhlIGNhc2Ugb2YgQ1BVIGNvbnN1bXB0aW9uDQo+ID4+PiAgwqA+IG9mIENYTCBwb2lzb24sIHRo
YXQgY2F1c2VzIGEgc3luY2hyb25vdXMgTUZfQUNUSU9OX1JFUVVJUkVEDQo+IGV2ZW50IHZpYQ0K
PiA+Pj4gIMKgPiB0aGUgTUNFIHBhdGggKmFuZCogaXQgbWF5IHRyaWdnZXIgdGhlIGRldmljZSB0
byBzZW5kIGFuIGVycm9yIHJlY29yZA0KPiA+Pj4gIMKgPiBmb3IgdGhlIHNhbWUgcGFnZS4gQXMg
ZmFyIGFzIEkgY2FuIHNlZSwgZHVwbGljYXRlIHJlcG9ydHMgKE1DRSArIENYTA0KPiA+Pj4gIMKg
PiBkZXZpY2UpIGFyZSB1bmF2b2lkYWJsZS4NCj4gPj4+DQo+ID4+PiBBcyB5b3UgbWVudGlvbmVk
IGluIG15IG90aGVyIHBhdGNoLCB0aGlzIHByb2JsZW0gc2hvdWxkIGJlIHNvbHZlZCBhdA0KPiBm
aXJzdC7CoCBNeSBwYXRjaCBhZGRzIHRoZSBwb2lzb24gcmVjb3JkICh0cmFja2luZywgd2hpY2gg
bWlnaHQgbm90IGJlY29tZQ0KPiB2ZXJ5IGxhcmdlKSB0byBwcmV2ZW50IGR1cGxpY2F0aW5nIHJl
cG9ydC4NCj4gPj4NCj4gPj4gUGluZ34NCj4gPj4NCj4gPj4gQW5kIEkgaGFkIHNvbWUgcHJvYmxl
bXMgd2hlbiB1c2luZyB4YXJyYXksIHBsZWFzZSBzZWUgYmVsb3cuDQo+ID4+DQo+ID4+Pg0KPiA+
Pj4+DQo+ID4+Pj4+IFRoaXMgcGF0Y2ggYWRkcyBhIG5ldyBub3RpZmllcl9ibG9jayBhbmQgTUNF
X1BSSU9fQ1hMLCBmb3IgQ1hMDQo+IG1lbWRldg0KPiA+Pj4+PiB0byBjaGVjayB3aGV0aGVyIHRo
ZSBjdXJyZW50IHBvaXNvbiBwYWdlIGhhcyBiZWVuIHJlcG9ydGVkIChpZiB5ZXMsDQo+ID4+Pj4+
IHN0b3AgdGhlIG5vdGlmaWVyIGNoYWluLCB3b24ndCBjYWxsIHRoZSBmb2xsb3dpbmcgbWVtb3J5
X2ZhaWx1cmUoKQ0KPiA+Pj4+PiB0byByZXBvcnQpLCBpbnRvIGB4ODZfbWNlX2RlY29kZXJfY2hh
aW5gLsKgIEluIHRoaXMgd2F5LCBpZiB0aGUgcG9pc29uDQo+ID4+Pj4+IHBhZ2UgYWxyZWFkeSBo
YW5kbGVkKHJlY29yZGVkIGFuZCByZXBvcnRlZCkgaW4gKDEpIG9yICgyKSwgdGhlIG90aGVyDQo+
IG9uZQ0KPiA+Pj4+PiB3b24ndCBkdXBsaWNhdGUgdGhlIHJlcG9ydC7CoCBUaGUgcmVjb3JkIGNv
dWxkIGJlIGNsZWFyIHdoZW4NCj4gPj4+Pj4gY3hsX2NsZWFyX3BvaXNvbigpIGlzIGNhbGxlZC4N
Cj4gPj4+Pj4NCj4gPj4+Pj4gWzFdDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWN4
bC82NjRkOTQ4ZmI4NmYwX2U4YmUyOTRmOEBkd2lsbGlhMi1tb2JsMy5hDQo+IG1yLmNvcnAuaW50
ZWwuY29tLm5vdG11Y2gvDQo+ID4+Pj4+DQo+ID4+Pj4+IFNpZ25lZC1vZmYtYnk6IFNoaXlhbmcg
UnVhbiA8cnVhbnN5LmZuc3RAZnVqaXRzdS5jb20+DQo+ID4+Pj4+IC0tLQ0KPiA+Pj4+PiAgwqAg
YXJjaC94ODYvaW5jbHVkZS9hc20vbWNlLmggfMKgwqAgMSArDQo+ID4+Pj4+ICDCoCBkcml2ZXJz
L2N4bC9jb3JlL21ib3guY8KgwqDCoCB8IDEzMA0KPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4+Pj4+ICDCoCBkcml2ZXJzL2N4bC9jb3JlL21lbWRldi5jwqAgfMKg
wqAgNiArLQ0KPiA+Pj4+PiAgwqAgZHJpdmVycy9jeGwvY3hsbWVtLmjCoMKgwqDCoMKgwqAgfMKg
wqAgMyArDQo+ID4+Pj4+ICDCoCA0IGZpbGVzIGNoYW5nZWQsIDEzOSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4+Pj4+DQo+ID4+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9tY2UuaA0KPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL21jZS5oDQo+ID4+Pj4+IGlu
ZGV4IGRmZDJlOTY5OWJkNy4uZDgxMDljNDhlN2Q5IDEwMDY0NA0KPiA+Pj4+PiAtLS0gYS9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9tY2UuaA0KPiA+Pj4+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9tY2UuaA0KPiA+Pj4+PiBAQCAtMTgyLDYgKzE4Miw3IEBAIGVudW0gbWNlX25vdGlmaWVyX3By
aW9zIHsNCj4gPj4+Pj4gIMKgwqDCoMKgwqAgTUNFX1BSSU9fTkZJVCwNCj4gPj4+Pj4gIMKgwqDC
oMKgwqAgTUNFX1BSSU9fRVhUTE9HLA0KPiA+Pj4+PiAgwqDCoMKgwqDCoCBNQ0VfUFJJT19VQywN
Cj4gPj4+Pj4gK8KgwqDCoCBNQ0VfUFJJT19DWEwsDQo+ID4+Pj4+ICDCoMKgwqDCoMKgIE1DRV9Q
UklPX0VBUkxZLA0KPiA+Pj4+PiAgwqDCoMKgwqDCoCBNQ0VfUFJJT19DRUMsDQo+ID4+Pj4+ICDC
oMKgwqDCoMKgIE1DRV9QUklPX0hJR0hFU1QgPSBNQ0VfUFJJT19DRUMNCj4gPj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY3hsL2NvcmUvbWJveC5jIGIvZHJpdmVycy9jeGwvY29yZS9tYm94LmMN
Cj4gPj4+Pj4gaW5kZXggMjYyNmYzZmZmMjAxLi4wZWIzYzU0MDFlODEgMTAwNjQ0DQo+ID4+Pj4+
IC0tLSBhL2RyaXZlcnMvY3hsL2NvcmUvbWJveC5jDQo+ID4+Pj4+ICsrKyBiL2RyaXZlcnMvY3hs
L2NvcmUvbWJveC5jDQo+ID4+Pj4+IEBAIC00LDYgKzQsOCBAQA0KPiA+Pj4+PiAgwqAgI2luY2x1
ZGUgPGxpbnV4L2RlYnVnZnMuaD4NCj4gPj4+Pj4gIMKgICNpbmNsdWRlIDxsaW51eC9rdGltZS5o
Pg0KPiA+Pj4+PiAgwqAgI2luY2x1ZGUgPGxpbnV4L211dGV4Lmg+DQo+ID4+Pj4+ICsjaW5jbHVk
ZSA8bGludXgvbm90aWZpZXIuaD4NCj4gPj4+Pj4gKyNpbmNsdWRlIDxhc20vbWNlLmg+DQo+ID4+
Pj4+ICDCoCAjaW5jbHVkZSA8YXNtL3VuYWxpZ25lZC5oPg0KPiA+Pj4+PiAgwqAgI2luY2x1ZGUg
PGN4bHBjaS5oPg0KPiA+Pj4+PiAgwqAgI2luY2x1ZGUgPGN4bG1lbS5oPg0KPiA+Pj4+PiBAQCAt
ODgwLDYgKzg4Miw5IEBAIHZvaWQgY3hsX2V2ZW50X3RyYWNlX3JlY29yZChjb25zdCBzdHJ1Y3QN
Cj4gY3hsX21lbWRldiAqY3hsbWQsDQo+ID4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGN4
bHIpDQo+ID4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBocGEgPSBjeGxfdHJhY2Vf
aHBhKGN4bHIsIGN4bG1kLCBkcGEpOw0KPiA+Pj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGhwYSAh
PSBVTExPTkdfTUFYICYmIGN4bF9tY2VfcmVjb3JkZWQoaHBhKSkNCj4gPj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiA+Pj4+PiArDQo+ID4+Pj4+ICDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKGV2ZW50X3R5cGUgPT0gQ1hMX0NQRVJfRVZFTlRfR0VOX01FRElBKQ0KPiA+Pj4+
PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJhY2VfY3hsX2dlbmVyYWxfbWVkaWEoY3hs
bWQsIHR5cGUsIGN4bHIsIGhwYSwNCj4gPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZldnQtPmdlbl9tZWRpYSk7DQo+ID4+Pj4+IEBAIC0x
NDA4LDYgKzE0MTMsMTI3IEBAIGludCBjeGxfcG9pc29uX3N0YXRlX2luaXQoc3RydWN0DQo+IGN4
bF9tZW1kZXZfc3RhdGUgKm1kcykNCj4gPj4+Pj4gIMKgIH0NCj4gPj4+Pj4gIMKgIEVYUE9SVF9T
WU1CT0xfTlNfR1BMKGN4bF9wb2lzb25fc3RhdGVfaW5pdCwgQ1hMKTsNCj4gPj4+Pj4gK3N0cnVj
dCBjeGxfbWNlX3JlY29yZCB7DQo+ID4+Pj4+ICvCoMKgwqAgc3RydWN0IGxpc3RfaGVhZCBub2Rl
Ow0KPiA+Pj4+PiArwqDCoMKgIHU2NCBocGE7DQo+ID4+Pj4+ICt9Ow0KPiA+Pj4+PiArTElTVF9I
RUFEKGN4bF9tY2VfcmVjb3Jkcyk7DQo+ID4+Pj4+ICtERUZJTkVfTVVURVgoY3hsX21jZV9tdXRl
eCk7DQo+ID4+Pj4NCj4gPj4+PiBJIHdvdWxkIHJlY29tbWVuZCBhbiB4YXJyYXkgZm9yIHRoaXMg
dXNlIGNhc2UgYXMgdGhhdCBhbHJlYWR5IGhhcyBpdHMNCj4gPj4+PiBvd24gaW50ZXJuYWwgbG9j
a2luZyBhbmQgZWZmaWNpZW50IG1lbW9yeSBhbGxvY2F0aW9uIGZvciBuZXcgbm9kZXMuDQo+ID4+
Pj4NCj4gPj4+PiBIb3dldmVyLCB0aGUgIndoeSIgcXVlc3Rpb24gbmVlZHMgdG8gYmUgYW5zd2Vy
ZWQgZmlyc3QuDQo+ID4+Pg0KPiA+Pj4geGFycmF5IGRvZXMgbG9vayBiZXR0ZXIuwqAgSSBkaWRu
J3QgdGhpbmsgb2YgaXQgYmVmcmUuwqAgVGhhbmtzIGZvciBzdWdnZXN0aW9uLg0KPiA+Pg0KPiA+
PiBJJ20gdHJ5aW5nIHVzaW5nIHhhcnJheSBidXQgYnV0IEknbSBydW5uaW5nIGludG8gdHdvIHBy
b2JsZW1zLg0KPiA+Pg0KPiA+PiBUaGUgZmlyc3Qgb25lIGlzOiB4YXJyYXkgc3RvcmVzIGFuIGVu
dHJ5IHdpdGggYSBzcGVjaWZpZWQgaW5kZXgsIGJ1dCBoZXJlIHdlDQo+IG9ubHkgbmVlZCB0byBz
dG9yZSB0aGUgUEZOLsKgIEknbSBub3Qgc3VyZSBob3cgdG8gc3BlY2lmaWMgYW4gaW5kZXggZm9y
IGENCj4gUEZOLsKgIFNvIEkgdGhpbmsgeGFycmF5IG1pZ2h0IG5vdCBzdWl0YWJsZSBmb3IgbXkg
Y2FzZS4NCj4gPj4gVGhlIHNlY29uZCBvbmU6IGJlY2F1c2Ugd2Ugb25seSBuZWVkIHRvIHN0b3Jl
L3NlYXJjaCBQRk4sIHRoZSBsaXN0IG5vZGUNCj4gb25seSBjb250YWlucyBhIGxpc3RfaGVhZCBh
bmQgYSBQRk4uIEJ1dCB4YXJyYXkgc2VlbXMgdG8gcmVxdWlyZSBtb3JlIG1lbW9yeQ0KPiBmb3Ig
ZWFjaCBub2RlLCB3aGljaCBjYXVzZXMgbW9yZSBvdmVyaGVhZC4NCj4gPg0KPiA+IFVzZSBQRk4g
YXMgdGhlIGluZGV4IG9mIHRoZSB4YXJyYXkgc2luY2UgaXQncyB1bmlxdWUuIEFuZCB0aGF0IG1h
a2VzIGZpbmRpbmcNCj4gdGhlIGVudHJ5IGVhc3kgd2l0aCB4YXJyYXkgYmVjYXVzZSB5b3UganVz
dCBwYXNzIGluIHRoZSBQRk4gYXMgdGhlIGtleS4gWW91IGNhbg0KPiBzdG9yZSBhbiB4YXJyYXkg
ZW50cnkgd2l0aCBubyBkYXRhLg0KPiANCj4gSSBkaWRuJ3Qga25vdyBpdCBjYW4gc3RvcmUgaW5k
ZXggd2l0aCBubyBkYXRhLiAgSSdsbCB0cnkgaW4gdGhpcyB3YXkuDQo+IA0KPiA+IEF0IHRoaXMg
cG9pbnQgeW91IGFyZSBqdXN0IGRldGVjdGluZyB3aGV0aGVyIHRoZSBlbnRyeSBoYXMgYmVlbiBz
dG9yZWQgKHZhbGlkKQ0KPiBvciBub3QuIEhvcGUgdGhhdCBoZWxwcy4NCj4gDQo+IFRoYW5rIHlv
dSB2ZXJ5IG11Y2ghDQoNCkFyZSB0aGVyZSBhbnkgb2YgeW91IHdobyBhcmUgc3RpbGwgdW5zdXJl
IGFib3V0IHRoZSBwdXJwb3NlIGFuZCBzaWduaWZpY2FuY2Ugb2YgY3JlYXRpbmcgdGhpcyBwYXRj
aCwNCmFzIHdlIG1vdmUgZm9yd2FyZCB3aXRoIHRoaXMgaW1wbGVtZW50YXRpb24/DQpXZSBoYXZl
IHRyaWVkIHRvIHN1bW1hcml6ZSB0aGUgcHVycG9zZSBhbmQgY3VycmVudCBzdGF0dXMgb2YgdGhp
cyBkZXZlbG9wbWVudCBpbiB0aGUgZm9sbG93aW5nIGVtYWlsOg0KOg0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtbW0vODNjNzA1Y2UtYTAxMy00YTg4LWFkY2QtMThkYmMxNmQ4OGRmQGZ1
aml0c3UuY29tL1QvI21iMmU4NzgxY2E2NTMwMzUxMzA5ZTcxYWNjYTk5YzY2MWY5NTgyNDkyDQoN
CkkgYmVsaWV2ZSB3ZSBjYW4gaW1wbGVtZW50IHRoaXMgdXNpbmcgeGFycmF5LCBidXQgSSdkIGxp
a2UgdG8gcmVhY2ggYW4gYWdyZWVtZW50IG9uIHRoZQ0Kb2JqZWN0aXZlcyBhdCB0aGlzIHN0YWdl
IGJlZm9yZSBzdWJtaXR0aW5nIGFueSBuZXcgeGFycmF5LWJhc2VkIHBhdGNoZXMuIA0KSWYgZG91
YnRzIGFib3V0IHRoZSBwdXJwb3NlIGFyaXNlIGFmdGVyIHN1Ym1pdHRpbmcgdGhlIHBhdGNoLCBp
dCBjb3VsZCBiZSBhIHdhc3RlIG9mDQp0aW1lIGFuZCBlZmZvcnQuDQoNCkFueSB0aG91Z2h0cz8g
T3RoZXJ3aXNlLCBjYW4gd2UgZ28gYWhlYWQ/DQoNClRoYW5rcywNCi0tLS0tDQpZYXN1bm9yaSBH
b3RvDQoNCg0KDQoNCj4gDQo+IA0KPiAtLQ0KPiBSdWFuLg0KPiANCj4gPg0KPiA+Pg0KPiA+PiBN
YXliZSBJJ20gb3ZlcnRoaW5raW5nIHRoaXM/DQo+ID4+DQo+ID4+DQo+ID4+IC0tDQo+ID4+IFRo
YW5rcw0KPiA+PiBSdWFuLg0KPiA+Pg0KPiA+Pj4NCj4gPj4+IC0tDQo+ID4+PiBUaGFua3MNCj4g
Pj4+IFJ1YW4uDQoNCg==

