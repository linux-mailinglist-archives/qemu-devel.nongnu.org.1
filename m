Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B87577AEA56
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:28:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5Gx-000846-Qj; Tue, 26 Sep 2023 06:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5Gt-00083Q-VM
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:26:28 -0400
Received: from ms11p00im-qufo17282101.me.com ([17.58.38.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5Gp-00082K-3a
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1695723977; bh=AIivesW69kdiP3fcwij1hPKRTSVQ78/QuNmAF6J7Nz0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=Q7LHXYpSYeF65d2AWozCnGAggmCeZj4mNW0mTfBLFcwiXMf3Wo874rfUhLhDQ1U79
 3K1lGjomD1OxzqrAqNL/NNjPkMIwdAObLNYnr0PqZWdOfc+8LndyTbZUHFMjXCimHs
 2WQFleo+NSUkees/DDQDY3i3ez6z2aqkdNTDBzxxX4cD38FrwfAh7VKAkTbmaHQgvg
 LEQnhKr3AnNcUwAhiFhe94RdQt0rB0OZdjIpa5lvwQom9BLJAyQLclwJlN8bSSoCxg
 KKVsBR3VjnEI2V/xeL9DWA5Vj9ApCgBhWT92bqTYuEtU87ZwtmGM6/UhoMA2d/E+kO
 4moexeabAg7HQ==
Received: from smtpclient.apple (ms11p00im-dlb-asmtpmailmevip.me.com
 [17.57.154.19])
 by ms11p00im-qufo17282101.me.com (Postfix) with ESMTPSA id 0DC728C01AA;
 Tue, 26 Sep 2023 10:26:15 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v4 13/14] MAINTAINERS: add maintainer of simpletrace.py
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20230920203744.GM1094271@fedora>
Date: Tue, 26 Sep 2023 12:26:02 +0200
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD495C81-077B-4428-8871-D4BE5A6BDBA4@ynddal.dk>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-14-mads@ynddal.dk> <20230920203744.GM1094271@fedora>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Proofpoint-GUID: f1rVPkXJM0K7UFi38YAUYusM16bMNso0
X-Proofpoint-ORIG-GUID: f1rVPkXJM0K7UFi38YAUYusM16bMNso0
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=472 spamscore=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2309260091
Received-SPF: pass client-ip=17.58.38.58; envelope-from=mads@ynddal.dk;
 helo=ms11p00im-qufo17282101.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


> You're welcome to be the maintainer. I haven't touched it in years.
>=20
> When you have reviewed future simpletrace.py patches you can either =
post
> your Reviewed-by and I'll include them in my tracing pull requests, or
> you could send pull requests to the qemu.git maintainer yourself
> (requires publishing a GPG key and signing pull request tags).
>=20
> Please let me know which option you prefer.

For future patches, I would like to send pull requests myself with a GPG =
key to=20
get the practice. I can have Klaus Jensen <its@irrelevant.dk> sign my =
key to
get started.

=E2=80=94
Mads Ynddal


