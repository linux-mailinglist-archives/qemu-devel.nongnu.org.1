Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4E27C9ADD
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 20:50:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs6BI-0000Uw-5D; Sun, 15 Oct 2023 14:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@gentoo.org>) id 1qrzUh-00028b-Hj
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 07:41:15 -0400
Received: from woodpecker.gentoo.org ([140.211.166.183] helo=smtp.gentoo.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <sam@gentoo.org>) id 1qrzUe-0005z2-DZ
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 07:41:15 -0400
User-agent: mu4e 1.10.7; emacs 30.0.50
From: Sam James <sam@gentoo.org>
To: raj.khem@gmail.com
Cc: laurent@vivier.eu,qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 2/2] linux-user: Replace use of lfs64 related functions
 and macros
In-Reply-To: <20221217180844.3453267-2-raj.khem@gmail.com>
Date: Sun, 15 Oct 2023 12:39:47 +0100
Organization: Gentoo
Message-ID: <878r8415bj.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=140.211.166.183; envelope-from=sam@gentoo.org;
 helo=smtp.gentoo.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 15 Oct 2023 14:49:36 -0400
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

Did anything happen with this, or did it get stuck?

We just had another user hit it in Gentoo at
https://bugs.gentoo.org/915809.

It looks like openembedded (obviously given the author) and Alpine have
been using this for nearly a year.

thanks,
sam

