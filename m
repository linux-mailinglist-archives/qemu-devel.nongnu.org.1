Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C917757A33
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 13:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLidd-0002W7-Eo; Tue, 18 Jul 2023 07:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1qLida-0002VK-FN; Tue, 18 Jul 2023 07:13:02 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1qLidT-0002yn-28; Tue, 18 Jul 2023 07:13:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EEAFA61509;
 Tue, 18 Jul 2023 11:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F66AC433CB;
 Tue, 18 Jul 2023 11:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689678769;
 bh=eJH6JmeiVWySWNwpHaGDOVkjbRE4Z9FrAI8vqHnqzgw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hb8MOLlg/CMPs4dtWTr2Wbgo0FhR1o5odt55V39g8QfGtELFqF6giusChb0un+s+h
 EyS15LHGjhSh/JJWXUVOuJYZnsIfd9e0Ta00AydLHTBPnUAV7PUs2V9KG0ssmuw0ie
 I/hrE/0bWo8xo5+Cb3Rget3Cj7oczmBZnt5RD2q0s0gdLxA2b1JouoEJlwiB5kqxyA
 H6a/Z1XQDBDXV6YxFwhfyhcJfTtHAEsXp9UQXLiO/t2RkYAmvbF9fDZ7o6k9nVN6ny
 HQF0Za8TjViMAa1ZWmdHPfN4vvXinSBNdVOhINXw8TabQvjcyMhSnj0R0ceK0huQoK
 FllxjHBpGyxuA==
Date: Tue, 18 Jul 2023 13:12:43 +0200
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/nvme: fix endianness issue for shadow doorbells
Message-ID: <ZLZzq2mRsTAoAn9w@kbusch-mbp.dhcp.thefacebook.com>
References: <20230718103511.53767-2-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718103511.53767-2-its@irrelevant.dk>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=kbusch@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jul 18, 2023 at 12:35:12PM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> In commit 2fda0726e514 ("hw/nvme: fix missing endian conversions for
> doorbell buffers"), we fixed shadow doorbells for big-endian guests
> running on little endian hosts. But I did not fix little-endian guests
> on big-endian hosts. Fix this.
> 
> Solves issue #1765.
> 
> Fixes: 3f7fe8de3d49 ("hw/nvme: Implement shadow doorbell buffer support")
> Cc: qemu-stable@nongnu.org
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Looks good!

Reviewed-by: Keith Busch <kbusch@kernel.org>

