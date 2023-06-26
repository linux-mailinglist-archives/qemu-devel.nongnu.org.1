Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC573ECD4
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 23:26:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDti9-00006I-GO; Mon, 26 Jun 2023 17:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1qDthu-0008Vt-6h; Mon, 26 Jun 2023 17:25:16 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1qDthr-0004lY-Fg; Mon, 26 Jun 2023 17:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:References:
 In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bnl5JtjVcq0BhJhQ7qwlrlAd9j26+VtX2gFLsNw7f48=; b=DPyHtc4EARMHxsU34/P1wIOBEg
 b2W8R/Y+pW8/tdmQx9DKDFcchmoOB11Xf0B6TZp/5Seqgxu8d7ocQqT48TJzWLom92nmMJEYvcVp1
 zR4iE+UJMWNfDz0/XeUZzYfMXDgAGCG8m2wyJ+qchwJ5HzyC2TREWo8OuDsBO73AKV1T9bS2xruwv
 gsieMLSrSuTS0qFhddJKGfGME+u0ldq80Hns544olgo5I87jJxW9HeWv7pgDSl3sRk9GQCbrfPAal
 ZHGEwhjc533lWocGsUBNEHuxOhMxz66V6D/o5fCNSQRTkA4g+pyzSpY5DjoRWjhOv0X3OWYTBnRYb
 KyoVXEfw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qDthb-004CPX-CZ; Mon, 26 Jun 2023 23:24:51 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1qDthZ-00DPiP-B7; Mon, 26 Jun 2023 23:24:51 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.94.2)
 (envelope-from <berto@igalia.com>)
 id 1qDthY-009vD5-Om; Mon, 26 Jun 2023 21:24:48 +0000
From: Alberto Garcia <berto@igalia.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 1/5] throttle: introduce enum ThrottleTimerType
In-Reply-To: <20230625085631.372238-2-pizhenwei@bytedance.com>
References: <20230625085631.372238-1-pizhenwei@bytedance.com>
 <20230625085631.372238-2-pizhenwei@bytedance.com>
Date: Mon, 26 Jun 2023 21:24:48 +0000
Message-ID: <w51y1k55333.fsf@igalia.com>
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

On Sun 25 Jun 2023 04:56:27 PM +08, zhenwei pi wrote:
> Use enum ThrottleTimerType instead of number index.

> +typedef enum {
> +    THROTTLE_TIMER_READ = 0,
> +    THROTTLE_TIMER_WRITE,
> +    THROTTLE_TIMER_MAX
> +} ThrottleTimerType;

If you're doing this I suppose you could also change 'bool is_write'
with something like 'ThrottleTimerType timer', i.e

static bool throttle_compute_timer(ThrottleState *ts,
                                   ThrottleTimerType timer,
                                   int64_t now,
                                   int64_t *next_timestamp)

Berto

