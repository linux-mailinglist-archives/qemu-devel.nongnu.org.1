Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A549E7818
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Dec 2024 19:30:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJd5K-0005tW-EQ; Fri, 06 Dec 2024 13:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <1263914829+auto_=qemu-devel-bounces+1263914829=qq.com=nongnu.org@qq.com>)
 id 1tJd5H-0005t9-Bd
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:29:48 -0500
Received: from xmbghk7.mail.qq.com ([43.163.128.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <1263914829+auto_=qemu-devel-bounces+1263914829=qq.com=nongnu.org@qq.com>)
 id 1tJd5D-0000od-D7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1733509773; bh=Tya4X6xk2Em9udC+qAiV7Z5rR3qPi1LdIgzkmCpXaXk=;
 h=From:To:Subject:Date:In-Reply-To;
 b=mONM8HTXTxhvHhYblewav1foH9FTxU228APzLYM8dGJHQW85V8Yksvpo0dgITVImv
 iKUsx/3LlqlsiR8FG33Ke9bp19E13mGo1pCmp1NhAVnfNXYHJ4Vo9GXe/QoKjQI8TN
 3xY1wiu0MhzFcIvJXKUEYs3pN9wzgBTP1lqLA3Zw=
X-QQ-XMRINFO: MFuljud3PUW4EHVQZqpniSQ=
X-QQ-XMAILINFO: NmxDRtNfo6mLXkP+nKTzXtpTa2mUpZcj6iNJosSyJjqkwi84iL91oxc8Rcml9E
 JEqyRktnIUbiagYHIgVRJ6Bge8FbPstfOhmHC6jL5Jjur3grZFpICKzirLqZfLI9DnUXDHEhHODC+
 eMQZxre7HcHRs6nQ2ZU/f9bRM+QXcLzcZj+eeGqsqIieBiW57eEP/bm2m6Er/mqRMrAPgNn/AMwh7
 16hxEtJiKV077eoEXNkCce27F/MC+HKOqh6MVj2xyWC4FihynbWqg+NNFtVQfxr5r+HxisaA8PXse
 zbRCpuVBQSPdNK3pQ/HstS4OuOeUboIstU6SxjRPF3NGJAxcQ3gYiviPIUBI7jQ2QEtmD/O7Ihv7O
 6a5eVJw5AR7T6/eV9mVpanp+9y67cHmW0pShTExqLwDIBIzHzWUZfqmXnSQhNW8CHItDp7di+9qB3
 pXV833L7Vn/4x6x8YNPY9ERViHkoadIB7LjUYJvuSTZq4ae45CNnK2HQvJia/e1w11GvcIBqd3x8K
 Ijo+p994Ae90LcJR6/YiZUuBWugdTx8qsQumyUYC4dos0rHSmlnwgz7HcCjoGp8HlcOHzCjAaHUVF
 IDYeuA1aEWU4IdXlhpKULT6lEj5RFNH71DdHDLikbZxeUBwaLQAoqtzFwS1JZHIX/D2sBNSlpX7/z
 ew2SkO35wBbkyDC55tthKfajWuZEhfKTdJQ0xR+HqWjAdG7J4/RYTJ15ZpRiwfuFZDWnhJLgUXCN5
 HMBnPyR7/3eJyueG9PPbL/8k/tjz/eqs43Z3dzgYyUl/ziExh6XK8YgHLBqniycuxMaoIRovaKiHH
 2EIJuIGzTyYp57ssNwbkCaQAWfvQL9BUER7aDyDRybFfoZpmZW11u4QwEdr19wR3nAY5AECq9ZtYr
 twuGx1Jpj5u3WV2JmwXqSiTrOXY4PXNt/XhZboyOsjjptt+Qmfg2nZ9234f/aiGHC4H66JShUqshk
 MQjlLH7kuDpXdP/RW93l1q1OqGPn1kAFqpTyAE4Px/RTc1oUhp1xuvQHxvHAfCrcoa7ERgem3xngD
 M8t9mVdlSbRsMRnff2X+aOVNl1ZC4yNZ44NIq
From: "=?utf-8?B?MTI2MzkxNDgyOQ==?=" <1263914829@qq.com>
To: "qemu-devel-request" <qemu-devel-request@nongnu.org>
Subject: =?utf-8?B?6Ieq5Yqo5Zue5aSNOiBRZW11LWRldmVsIERpZ2Vz?=
 =?utf-8?B?dCwgVm9sIDI2MSwgSXNzdWUgMTA0?=
Mime-Version: 1.0
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 7 Dec 2024 02:26:20 +0800
X-QQ-AUTO-REPLY: true
Message-ID: <tencent_7472C33A5D341DB214F0566D@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
In-Reply-To: <mailman.58.1733509514.12711.qemu-devel@nongnu.org>
X-QQ-mid: rexmmxzc27-2t1733509576tufgredfm
Received-SPF: pass client-ip=43.163.128.55;
 envelope-from=1263914829+auto_=qemu-devel-bounces+1263914829=qq.com=nongnu.org@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_40=-0.001, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.001, HTML_MESSAGE=0.001, HTML_MIME_NO_HTML_TAG=0.377,
 MIME_HTML_ONLY=0.1, PYZOR_CHECK=1.392, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

6L+Z5piv5p2l6IeqUVHpgq7nrrHnmoTlgYfmnJ/oh6rliqjlm57lpI3pgq7ku7bjgII8YnIg
IC8+PGJyICAvPuS9oOWlve+8jOaIkeacgOi/keato+WcqOS8keWBh+S4re+8jOaXoOazleS6
suiHquWbnuWkjeS9oOeahOmCruS7tuOAguaIkeWwhuWcqOWBh+acn+e7k+adn+WQju+8jOWw
veW/q+e7meS9oOWbnuWkjeOAgg==


