Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E46267CA737
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 13:56:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsMCr-0004Fa-5v; Mon, 16 Oct 2023 07:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qsMCp-0004F1-Au
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:56:19 -0400
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qsMCn-0005W4-Ta
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:56:19 -0400
Received: from blackfin.pond.sub.org
 (p200300d36f42770072c066a7e7963076.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f42:7700:72c0:66a7:e796:3076])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id EF7F526A3A
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 14:14:19 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7951D21E6A1F; Mon, 16 Oct 2023 13:55:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH 03/17] meson, cutils: allow non-relocatable installs
In-Reply-To: <20231016063127.161204-4-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 16 Oct 2023 08:31:13 +0200")
Date: Mon, 16 Oct 2023 09:12:34 +0200
Lines: 2
References: <20231016063127.161204-1-pbonzini@redhat.com>
 <20231016063127.161204-4-pbonzini@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Message-ID: <87edhuixx5.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Out of curiosity: what's a non-relocatable install, and why should I
care?

