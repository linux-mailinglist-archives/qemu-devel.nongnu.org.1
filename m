Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9E7745A1F
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:28:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGlt-0006GL-6k; Mon, 03 Jul 2023 06:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1qGGlq-0006FC-Go; Mon, 03 Jul 2023 06:27:02 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1qGGlp-0003NU-12; Mon, 03 Jul 2023 06:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:References:
 In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=74vx5tQpjkPsEAb3RxPhnq876V4hn0UieAU1AnVR+Lk=; b=OhDP52hWWqnScLGsC8BIAbu9ol
 ZB1ZzRLryaNdPX2Nz2TmgmorAucRkCZDP2JdfIDFM8i0EuqK6G3Zy2Q58JNXDQSJtPImXpCdv3FX3
 AY/wdCBw1DDqFOJOsmwelVlnNiwc+b5Yih+TaNddp3PwKbn5gzDfw1ED9TklEA4fJk6mxtJNehVl4
 DMBeLCDmLujdVeFbb76c6sGk6iThYwiDj3RagWQsothjojiEzx3wVetgODI03xg1hTnuesbbBgCI0
 3fnXvaxvsge0UNQlVSlJS1Qg1mulPUgCG4SylE5t4xZJqxK6MU5xVRm1Zq8ZHtk+nafRmG6pF8RbJ
 z339lEMg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qGGln-007Ztb-14; Mon, 03 Jul 2023 12:26:59 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1qGGlk-002Gzm-Ta; Mon, 03 Jul 2023 12:26:58 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.94.2)
 (envelope-from <berto@igalia.com>)
 id 1qGGlk-00BG6Z-Ag; Mon, 03 Jul 2023 10:26:56 +0000
From: Alberto Garcia <berto@igalia.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v2 2/5] test-throttle: use enum ThrottleType
In-Reply-To: <20230627072431.449171-3-pizhenwei@bytedance.com>
References: <20230627072431.449171-1-pizhenwei@bytedance.com>
 <20230627072431.449171-3-pizhenwei@bytedance.com>
Date: Mon, 03 Jul 2023 10:26:56 +0000
Message-ID: <w51zg4d47f3.fsf@igalia.com>
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

On Tue 27 Jun 2023 03:24:28 PM +08, zhenwei pi wrote:
> Use enum ThrottleType instead in the throttle test codes.
>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

