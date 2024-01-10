Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77654829D84
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 16:25:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNaRs-0007ea-Mm; Wed, 10 Jan 2024 10:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thorpej@me.com>) id 1rNaRq-0007dR-IO
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 10:24:54 -0500
Received: from pv34p98im-ztdg02162201.me.com ([17.143.234.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thorpej@me.com>) id 1rNaRo-0007cf-A2
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 10:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1704900283; bh=cP732x/HPvihHkAXO4X3EILarzfpDquwXkx455oqEJ0=;
 h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
 b=RSOnH59YKxSS6xsZvTuZ98jpPwyneBn/RXqEYfKhEInxmFZfiW5bTE4r1mriG1Tk8
 IMV4TfIBQMIX41nYqfKKscdi6oD7i73+rFxqB7hCxvR+nIL0axnm5csgcUUfyV9Wh+
 54W0EsoiLQlNT0JePEwLBbnnUbyZczD4js8oGMP8Udb2l3M2xOO0mKbTeZ/c6HnpzS
 bz5eac/Ztcd1eL/d0QACFMbdTk2PK0wejKCsoTpgbRDOYMBTZH3skfQHZnaXRLqo6X
 Tfmqa7Ug8W34ihtUuAF6e4xfrzzQAFTngYJhE+RBzNCWoy8LUMIyth2PHumj0L9R+o
 /N8I5moLAhN/Q==
Received: from smtpclient.apple (pv43p00im-smtp.mail.me.com [17.56.9.9])
 by pv34p98im-ztdg02162201.me.com (Postfix) with ESMTPSA id 6059E3600CB
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 15:24:42 +0000 (UTC)
From: Jason Thorpe <thorpej@me.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Goldfish TTY enhancement
Message-Id: <8FAAD163-46DD-426F-AF69-1DDAB45B2A9B@me.com>
Date: Wed, 10 Jan 2024 07:24:14 -0800
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Proofpoint-ORIG-GUID: nezhkLZP3fr8eI-TOFxlL0qAqMoHoxa1
X-Proofpoint-GUID: nezhkLZP3fr8eI-TOFxlL0qAqMoHoxa1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_07,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 phishscore=0 clxscore=1011 mlxlogscore=862 spamscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401100126
Received-SPF: pass client-ip=17.143.234.141; envelope-from=thorpej@me.com;
 helo=pv34p98im-ztdg02162201.me.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Having recently written a driver for the Goldfish TTY for NetBSD, I =
found it a bit odd (and a little annoying) that the device has a =
PUT_CHAR register but not a GET_CHAR register, something particularly =
useful for early-console or in-kernel debugger use.  As it stands, to =
get a single character from the device, you have to first poke a DMA =
address into 1 (or 2) registers and then poke the command register.  =
Depending on the operating system environment, this might involve a lot =
of kernel machinery.  My current driver works around this, but makes an =
explicit assumption that a physical address is a valid DMA address, =
which is the true for the m68k virt platform, but is the sort of =
assumption one shouldn=E2=80=99t be making these days.

Would there be an objection to adding a single-register-read get-char =
operation to the Goldfish TTY?  The change I have in mind is to bump the =
version to 2 (so that driver software can identity the capability) and =
then allow reads of the PUT_CHAR register to return the first pending =
byte or -1 if the FIFO is empty.  Happy to create an additional register =
for the purpose if that=E2=80=99s preferred, but it seemed better to =
keep the footprint of the device the same.

If the consensus is that this is a worthwhile enhancement, I=E2=80=99ll =
post a patch.

Cheers.

-- thorpej


