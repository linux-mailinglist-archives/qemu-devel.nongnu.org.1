Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 541EC832C91
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 16:57:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQrDy-0002rd-BA; Fri, 19 Jan 2024 10:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1rQrDu-0002rS-3T
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:56:02 -0500
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1rQrDq-0000tC-RY
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:56:01 -0500
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 07DD4240104
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 16:55:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1705679753; bh=MOOPIVyTYi81zWkrPInDAleexwy5PlR85SPabPuN7Lg=;
 h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type:
 Content-Transfer-Encoding:From;
 b=fv1w/MRtFpK97rlV6NhNHsM4ct8wkDLkPK2cBQl2ZXYb4FghmNjfDOhoal5Ws030m
 tNFBjahd1SjK94qd2gHVWeg6HLpVxQ1J29WOIH7LeOOylCCcsjWcOTJ7ZNxpkx+f5L
 YtVt1pLF/DY8XZv8Fg1vH+vd30QTTAmkZZ+AXJP9p3LSXKwZTQ7gQwd5RkWlof8ZN0
 eHNZtkBAMWJFs736NywbBkIRhBX8xnMi109SQqXqgeVkaS35QACYutC7Qcqhxk2TL+
 Z3mTbnx4aXbczqJLtTecFzv1ZEXWp8TShkOmKprFbJ1j/fua/RIHlDt2wNtU5oAF++
 1DzAfXN3Gjf8Q==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4TGkjf1WlFz6twn;
 Fri, 19 Jan 2024 16:55:50 +0100 (CET)
Message-ID: <4e802a6d-fb97-4e49-ab78-2a75371e464d@posteo.de>
Date: Fri, 19 Jan 2024 15:55:49 +0000
MIME-Version: 1.0
Content-Language: en-US
From: Thomas Huth <th.huth@posteo.de>
To: QEMU Developers <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, Michael Tokarev
 <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>,
 Brad Smith <brad@comstyle.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <f4bug@amsat.org>
Subject: QEMU's tests/unit/test-iov times out on NetBSD and OpenBSD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth@posteo.de;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


  Hi,

since we recently introduced test timouts in QEMU's meson set up, I noticed 
that the tests/unit/test-iov times out when doing "make vm-build-netbsd 
BUILD_TARGET=check-unit" (or vm-build-openbsd).

And indeed, when increasing the timeout, you can see that the test-iov runs 
for multiple minutes on these BSDs while it finishes within few seconds on 
Linux.

I had a closer look at the test, and the problem seems to be the

  usleep(g_test_rand_int_range(0, 30));

in the test_io() function. If I get that right, the usleep() seems to be 
more or less precise on (modern) Linux, but it seems like it sleeps for 
multiple milliseconds (not microseconds) on the BSDs. Since it is used in a 
nested loop, these milliseconds add up to a long time in total during the test.

Does anybody have an idea how to fix that? Is there a more precise (but stil 
portable) way to sleep less long here? Or could we maybe remove the usleep() 
here completely (it does not seem to have a real benefit for testing as far 
as I can see)?

  Thanks,
   Thomas

