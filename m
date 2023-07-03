Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A08745A2F
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:29:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGno-0008QI-VR; Mon, 03 Jul 2023 06:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1qGGni-0008MM-QL; Mon, 03 Jul 2023 06:28:58 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1qGGnf-0003dL-Bb; Mon, 03 Jul 2023 06:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:References:
 In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e6SgHnmzx6uEZq4I4nPXal7J0AF7m1lUDyvDLavc+j4=; b=hYqMymMh37D1UACpoRqJRpZPwc
 hUg17V6ZkfPfWAGRo7mFF2SRC+PbToxT1ooIdUR7Uj6y9tHpRjbb9edZYw4JWY5IHgyNYgQrF1tSP
 571bL+xJzrz0DK0L/oMjP7orYY2S0HH+qfcd1EeSxF4vOY5RMzxQcmTgP6QLsrCFiMC6HqVMijBWB
 zHesimGyHonBQ2I038nPzksdae9CyfOAmFMPW+JkQarJqEdyWdUkF6GxnE5dLLWz3pgBwK59GeHf3
 3EYQIs6nFjhnbg0AxCIshjO0CODw4Ar9/iefBVp7TS8dsajctf0BeyCEw4JilvI6JSsdvZzPckDya
 wTd9p6sg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qGGnc-007ZvW-6i; Mon, 03 Jul 2023 12:28:52 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1qGGna-002H7R-2z; Mon, 03 Jul 2023 12:28:52 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.94.2)
 (envelope-from <berto@igalia.com>)
 id 1qGGnZ-00BG7T-GN; Mon, 03 Jul 2023 10:28:49 +0000
From: Alberto Garcia <berto@igalia.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v2 5/5] cryptodev: use NULL throttle timer cb for read
 direction
In-Reply-To: <20230627072431.449171-6-pizhenwei@bytedance.com>
References: <20230627072431.449171-1-pizhenwei@bytedance.com>
 <20230627072431.449171-6-pizhenwei@bytedance.com>
Date: Mon, 03 Jul 2023 10:28:49 +0000
Message-ID: <w51ttul47by.fsf@igalia.com>
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

On Tue 27 Jun 2023 03:24:31 PM +08, zhenwei pi wrote:
> Operations on a crytpodev are considered as *write* only, the callback
> of read direction is never invoked. Use NULL instead of an unreachable
> path(cryptodev_backend_throttle_timer_cb on read direction).
>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

