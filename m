Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E64768693
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 19:07:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ9ap-00061j-SW; Sun, 30 Jul 2023 12:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qQ9an-00060h-OW
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 12:48:29 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qQ9al-0005zO-S5
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 12:48:29 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id D25B911EEFB;
 Sun, 30 Jul 2023 16:48:25 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Sun, 30 Jul 2023 16:48:25 +0000
MIME-Version: 1.0
Subject: [PATCH QEMU v3 0/3] migration: craft the doc comments
Message-ID: <169073570563.19893.2928364761104733482-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-To: ~hyman <yong.huang@smartx.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi, please review the version 3 of the series, thanks.

V3:
- craft the commit message of
  "Add section for migration dirty limit and dirty page rate",
  and put the section after section "Migration", suggested
  by Markus.

V2:
- split the first commit in v1 into 2
- add commit message of commit:
  MAINTAINERS: Add Hyman Huang as maintainer

Yong

Hyman Huang(=E9=BB=84=E5=8B=87) (3):
  qapi: Reformat the dirty-limit migration doc comments
  qapi: Craft the dirty-limit capability comment
  MAINTAINERS: Add section "Migration dirty limit and dirty page rate"

 MAINTAINERS         |  9 +++++++
 qapi/migration.json | 66 +++++++++++++++++++++------------------------
 2 files changed, 40 insertions(+), 35 deletions(-)

--=20
2.38.5

