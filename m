Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE02072A301
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 21:22:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7hfB-0006Av-S6; Fri, 09 Jun 2023 15:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7hey-00069E-8w
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 15:20:32 -0400
Received: from pv50p00im-zteg10021401.me.com ([17.58.6.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1q7hew-0002Jn-Ew
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 15:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1686338422; bh=yUTl2fkzFaHsYhEA2iHXPxAbPTPE8YG2vGRqQUJHqT4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=fRtTaB2ZE9Yle7dNcht328rglXWvBg9mtNZAXzhIPiREUQQJmFUT7HJ8O2TQK7IqR
 45DRNhQjFM85xvEHKjk4n7vgs6vXGVyi7giHU2zvGainpbseI/glntCFYRkrcB1+JL
 G8gy8qBG3maYYAw9k+UOm2+loLQNLGNlqYKguVxvRe9Ba0/wosBv4T2IhxkCr1okDo
 UUeEJQo1/+wM3JPIEVKxH7QwdNNKb3w3L3iMWIcMz/Am2qSc8F1j9YvixoMO9lEHmd
 K1Ihs8B8r1LO0K7Wims8pZFheOmlHZI/Va1d3j0stnE1XJ3r0+8bXk6GuJJs4ekU3I
 KFamq/fo2kujw==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com
 [17.56.9.10])
 by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 8D6D68E0308;
 Fri,  9 Jun 2023 19:20:20 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v3 12/14] simpletrace: added simplified Analyzer2 class
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20230608124147.51125-13-mads@ynddal.dk>
Date: Fri, 9 Jun 2023 21:20:07 +0200
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <B5979ACE-9AC2-4E72-B132-4EFC150CB684@ynddal.dk>
References: <20230608124147.51125-1-mads@ynddal.dk>
 <20230608124147.51125-13-mads@ynddal.dk>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3731.600.7)
X-Proofpoint-GUID: Y2prbdkDLnET1ttdKb8sDujcXD3KyOng
X-Proofpoint-ORIG-GUID: Y2prbdkDLnET1ttdKb8sDujcXD3KyOng
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=725 malwarescore=0 clxscore=1030 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2306090162
Received-SPF: pass client-ip=17.58.6.47; envelope-from=mads@ynddal.dk;
 helo=pv50p00im-zteg10021401.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


> On 8 Jun 2023, at 14.41, Mads Ynddal <mads@ynddal.dk> wrote:
> 
> From: Mads Ynddal <m.ynddal@samsung.com>
> 
> By moving the dynamic argument construction to keyword-arguments,
> we can remove all of the specialized handling, and streamline it.
> If a tracing method wants to access these, they can define the
> kwargs, or ignore it be placing `**kwargs` at the end of the
> function's arguments list.
> 
> Added deprecation warning to Analyzer class to make users aware
> of the Analyzer2 class. No removal date is planned.
> 
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
> scripts/simpletrace.py | 72 ++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 72 insertions(+)

I noticed I'm missing Analyzer2 in __all__

