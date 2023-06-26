Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3993C73ECEA
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 23:30:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDtmn-0003Oj-V0; Mon, 26 Jun 2023 17:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1qDtmh-0003O7-1t; Mon, 26 Jun 2023 17:30:10 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1qDtmf-0005zD-51; Mon, 26 Jun 2023 17:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:References:
 In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W0w/+veI1Hj0flXTLkv0RmFCGlcWLr8fn64FIUZ7BEY=; b=OI8nV1VbwsRaIa1uHSQoxLrQ/J
 JlDlH/7JHPuUxygbA4/ebeLxdPrxD8g5zN261UscowcVsmDliDvfWxiAYub6xr/hh1x+eFZ2KPDvm
 +Szp57KFasMxTaLx2IMeFbNvB1qKYkUzRrSUMLqE97fyo7RTIg5bo4nbQz3+/5NYRtu+keHhJHGpm
 bcy4qglFtOUe44XUgMIrClBeRlppgr4NaUMWv1mcVIEvNE+sOcgFN/Oj0PD3zBdhji0qpStBBN/+5
 8ugtC4eeizO5BgIcNuxKir8aVZcJDQ7LQcVLQMHwRTfdoutkbyw8chplvVMkc24SKfrw/x46Xh4dM
 PFkl4SIw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qDtmd-004CWr-4w; Mon, 26 Jun 2023 23:30:03 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1qDtmb-00DPs0-1B; Mon, 26 Jun 2023 23:30:02 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.94.2)
 (envelope-from <berto@igalia.com>)
 id 1qDtma-009vI0-Eh; Mon, 26 Jun 2023 21:30:00 +0000
From: Alberto Garcia <berto@igalia.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 5/5] cryptodev: use NULL throttle timer cb for read
 direction
In-Reply-To: <20230625085631.372238-6-pizhenwei@bytedance.com>
References: <20230625085631.372238-1-pizhenwei@bytedance.com>
 <20230625085631.372238-6-pizhenwei@bytedance.com>
Date: Mon, 26 Jun 2023 21:30:00 +0000
Message-ID: <w51sfad52uf.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=213.97.179.56; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Sun 25 Jun 2023 04:56:31 PM +08, zhenwei pi wrote:
> Operations on a crytpodev are considered as *write* only, the callback
> of read direction is never invoked. Use NULL instead of an unreachable
> path(cryptodev_backend_throttle_timer_cb on read direction).
>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

