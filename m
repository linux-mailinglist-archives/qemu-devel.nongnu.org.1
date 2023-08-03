Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAD576F5C7
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRgub-0008V1-E2; Thu, 03 Aug 2023 18:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRguS-0008T2-Ub
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:35:08 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRguP-00060j-MB
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691102103; x=1691706903; i=deller@gmx.de;
 bh=8HW1rq0e/YlgtuWlgImvRBKG69TEI7l4p5a/YC8ZO50=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=g+4GkoTxLb3BfL5GtgAdPU3936zjvADOySougQK7xH1srdImSeWzgQjE3lGyw18JTRYQ2Fi
 76tKJ+qvHoblgUdF5On/R0cePQqE4NhvSrjohJ2W6/tPnxAuLPBbxUX9sAJ0iP14kRtOIvBrv
 sx1zrS3dkqblRfEvMlYrd8gBM1X7r2ex5MPKOrxEttuoz+x6H/Ra+tHoi5WMR8ulaSODbvA+D
 nqZT2GmoLj8WhAzUH0iAl/iq9Ghp6NckYYQdgTv56IOLFBkr/Jd5sDcttnAnaj8c435X94qh+
 iGYHUrsP4Ix+NACJiY3zFbNNeXk9Xd3OnXYi31p389SLmlQfNBkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.147.53]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfNl-1pYcNk03BP-00v4mb; Fri, 04
 Aug 2023 00:35:03 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 0/1] Hppa linux user speedup patches
Date: Fri,  4 Aug 2023 00:35:01 +0200
Message-ID: <20230803223502.653223-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lqyf2+ANAcjfgt64n6jZsmGt/jrC+PIQRAxpTGoFEQ9G3j6vp+M
 QF6trKyCwcHK073LMo7pU7DofC3ZCzYtHSBp/Wby17dW4WbSzFRrZ+L5gQWk8hr/SvRiBdd
 ZsGy+CmbSlN/2lHcfUj9hnLhiX4XLdz8x2TbIDvIYdaYEIaHByjuMp3SXAleW6bLoVO7CmU
 vjJ6TW30UwIcFDNwpJ6iw==
UI-OutboundReport: notjunk:1;M01:P0:IZs7LmQ/3uU=;Se4k4y/EMohYlvSoJBruHlXZjsx
 XW3fQlsWS7JkzYDOTD01dsATAz5FSrZ4uz+wPpeYoG845C6aWvWb4WMqiI5kKUd2w0crFah7C
 iRBo9rJ14vounv/MDdYDC1GoZr0vLpcA749ElfuHlYa4Y7dOk7O2So9jGGoX6+ZaCOBCQJ/cM
 fYv2YwVZcQQsTLxBqPe9IeYHwiC3YNa6oV6n6/g7F/6R9iBg2iajdZPYS/a/jNtqszLjr5CUK
 s25E+0nuf2cYpRuntSxARsVIhsOAu4VtI4MzRyjgzChz/uX7nvOKjj7rOxwsFyhHiGDsFLztJ
 JLiVnLr/Ng1oa4GKROl2faun3JnV6nIBi4HYDhmqDLEsTIaIzDQZuU9dVWG2hLZePp09CQ9W9
 fm7Ox08tq3eNCqEusPSwzyZfIOnI3TfOK4lmAQZYLVPxlZHUU9sGJ4sRsAP+BM4lCVdj7N88Q
 WN5K/RfJZ7a/ROg5K7l9LNqdMCm0FD010x8CT6Ch/EP3RY5VSfGeEuP8OeBzNdj07IQJNzSIb
 W+sWdr871yVweUl/UJ/eyr8JF5siQAwsO3emnjeBdwIRQ0KPmOio8J1VuDmSZ8t/6Nk1wMv8B
 S5H7o67vstgpPGB5d20iDrqnpTEPJ4/Exb3mOKveNUXjpHzYzOr7uXxJdAaEq29KpaD0pCJ7M
 Apx1o8qWHZXicyXyqKhnTrJk5E22WKPzQi+fu2Z0kxup3nmBAZkXrbOzcpDmo6fILU3dpS0t4
 t46raeMW4Ft4/Qwh/CLRKx8tcnaWPql5p3IO8Dy7yorkiP4ogt7MDVbadnUDFgIzZ0lZH6IZ9
 /f7JIqNEkrswRWuFXITZITTTocR3Nj35+MusAMWlEfq0H7GGTjgg/Wffyn2iNFK3dnKNznaji
 b6nsQ8Pk8zaQ+n+9UHHrz/DZG2jyBVJFxVY9cT4xydbovnKq1ptC3sMGq5p2QzSqx/inJbWz1
 HMmByQ==
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 9ba37026fcf6b7f3f096c0cca3e1e7307802486=
b:

  Update version for v8.1.0-rc2 release (2023-08-02 08:22:45 -0700)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-linux-user-speedup-pu=
ll-request

for you to fetch changes up to f8c0fd9804f435a20c3baa4c0c77ba9a02af24ef:

  target/hppa: Move iaoq registers and thus reduce generated code size (20=
23-08-04 00:02:56 +0200)

=2D---------------------------------------------------------------
Generated code size reduction with linux-user for hppa

Would you please consider pulling this trivial fix, which reduces
the generated code on x86 by ~3% when running linux-user with
the hppa target?

Thanks,
Helge

=2D---------------------------------------------------------------

Helge Deller (1):
  target/hppa: Move iaoq registers and thus reduce generated code size

 target/hppa/cpu.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

=2D-
2.41.0


