Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8729766DB
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Sep 2024 12:46:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sohJi-0008Ab-7F; Thu, 12 Sep 2024 06:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1sohJf-00084n-BS; Thu, 12 Sep 2024 06:44:47 -0400
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1sohJc-0003hb-Ih; Thu, 12 Sep 2024 06:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X2X8dANKe1PMwSjgr9a5G1KGegvVEPX8fEZmvTn6Sxs=; b=YE8fOK+2VHlni01+WjyJN7Wu3X
 bG4xGa4x6OSmWNW1jVCM0DRJvCnKNYRWtPFKW22bJUBtcwmRpzsmdDwbDsSx4TunXhAlrXtZqLgJM
 /NNfLNZDTbNSWQC62LxQ53WgqCsbjX9jPqqXC2ZIwe05b0h2u7bmQGm5cfBJaqjW8c9GCsLQvQEHQ
 7nf+/zM293Am4gaA1COyxk8KC5MQVB5b3euW963cw8DPcYYt1de2IZTTa3E5qOrj19vbQZ3X5nQIQ
 Ta28sZ9bCWfNhq2oR8KZqpkrCjmP+2ZAKMeIetDrl8NPjcuzbBPoICBEH9uIqqHHlU+HGWKzAgsTI
 2HJoHcWA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1sohJP-00CpJU-Ji; Thu, 12 Sep 2024 12:44:31 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1sohJN-00EdiY-I6; Thu, 12 Sep 2024 12:44:31 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1sohJN-006bYx-1G;
 Thu, 12 Sep 2024 10:44:29 +0000
Date: Thu, 12 Sep 2024 12:44:29 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 Madeeha Javed <javed@igalia.com>
Subject: Re: [PATCH v4] scripts/qcow2-to-stdout.py: Add script to write qcow2
 images to stdout
Message-ID: <ZuLGDRBSv5GFxvzw@igalia.com>
References: <20240730141552.60404-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730141552.60404-1-berto@igalia.com>
X-Spam-Score: -7
X-Spam-Bar: /
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 30, 2024 at 04:15:52PM +0200, Alberto Garcia wrote:
> This tool converts a disk image to qcow2, writing the result directly
> to stdout. This can be used for example to send the generated file
> over the network.

ping

