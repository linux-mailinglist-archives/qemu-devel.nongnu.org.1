Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7ED7498ED
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:02:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHLoQ-0006Zh-Fl; Thu, 06 Jul 2023 06:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3548fa01511b4d8d19d4b187d3989b7033b733d8@lizzy.crudebyte.com>)
 id 1qHLoO-0006YF-E0
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:02:08 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3548fa01511b4d8d19d4b187d3989b7033b733d8@lizzy.crudebyte.com>)
 id 1qHLoM-0007lR-Jn
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:Message-Id:References:In-Reply-To:Content-ID:
 Content-Description; bh=7fDRpBUjC1DpnffeXbTlMqe1kKEUANtc+FnIhX0KxME=; b=LWEWh
 5tbD4qmj5/N7iaZfnx/gO0b/9vtNlQHgYugy6X+VKveAXiYcchb2zc3jAFYlBTamXwO/khNn6NEdq
 9uUYm2TvXWWj0eCNX2QW9/c5A6Yzv5IP3C6IDFqYV70mz0o5KetBlQwP7ahCYD/bjVdIacvetR7f7
 Or3XNHb32Nll3jtYS8m9vNbKiNzfg+jwGCEArICUFXLUw5rXgcplg6tj/B/Uco3nsZeJQN+trH7rz
 JJesLhVYorMxvuf7UXyaXE7+iwM+iUE9aZE5IAxta0+6BytlzlvkxEbqyrfAQMTfLiPvLgp7k71tf
 sxVFjC+WE347SAAgdiPFnxxDs3CWg==;
Message-Id: <cover.1688637466.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 06 Jul 2023 11:57:47 +0200
Subject: [PULL 0/2] 9p queue 2023-07-06
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Philippe Mathieu-Daudé <philmd@linaro.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=3548fa01511b4d8d19d4b187d3989b7033b733d8@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 0618e72d64e434dd6f1bc38b107670474c49fb86:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-07-04 18:40:13 +0200)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20230706

for you to fetch changes up to 3548fa01511b4d8d19d4b187d3989b7033b733d8:

  MAINTAINERS: raise status of 9p to 'Maintained' (2023-07-06 11:42:08 +0200)

----------------------------------------------------------------
Administrative changes only:

* Deprecate 9p 'proxy' backend.

* Raise status of 9p to 'Maintained'.

----------------------------------------------------------------
Christian Schoenebeck (2):
      9pfs: deprecate 'proxy' backend
      MAINTAINERS: raise status of 9p to 'Maintained'

 MAINTAINERS                        | 11 +++++++++--
 docs/about/deprecated.rst          | 23 +++++++++++++++++++++++
 docs/tools/virtfs-proxy-helper.rst |  3 +++
 fsdev/qemu-fsdev.c                 |  8 ++++++++
 fsdev/virtfs-proxy-helper.c        |  9 +++++++++
 hw/9pfs/9p-proxy.c                 |  5 +++++
 hw/9pfs/9p-proxy.h                 |  5 +++++
 meson.build                        |  2 +-
 qemu-options.hx                    |  6 +++++-
 9 files changed, 68 insertions(+), 4 deletions(-)

