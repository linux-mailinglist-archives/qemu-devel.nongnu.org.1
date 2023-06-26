Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D2973ECFB
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 23:39:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDtux-0006Cx-Px; Mon, 26 Jun 2023 17:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1qDtup-0006Cf-0m; Mon, 26 Jun 2023 17:38:32 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1qDtun-0008DO-KE; Mon, 26 Jun 2023 17:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:References:
 In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nQvGYahceAsuhjU9EleRIUV6q1PvCfz1pu2FtJKYJgg=; b=lokgTWM6r5WKnXVsJVL6CesWzT
 jqQLnb41ea5on3lIT0oy1CrqmgSIxQwJDI3BX9P5rWTG4/5gWp9z4TIJH8GGBqGAGcVDskkBLPizY
 F+vS9USZtza8vdweC+zP/6ykXjfZPfpN7lTEXdrHaLshGIMoelI4G3Z01IebkQ7R03218FBYb8gY3
 ryQCzZ5aQWHMRvc4wWd9GH8vPPR5Xy2RwXoLUx/qbCjxv2UCV57k7xx/7VMDZ6AuWOd+SJlSlrPmu
 1UE36B4aRVNqSondstEeuFMj9PV4+BD+azdanq0nFcueqrbXHMoIwoTuC/V4wPQ12TE+mzXMV3g3C
 xKrhWwKg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qDtuj-004CiD-PQ; Mon, 26 Jun 2023 23:38:25 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1qDtuh-00DQGE-LB; Mon, 26 Jun 2023 23:38:25 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.94.2)
 (envelope-from <berto@igalia.com>)
 id 1qDtuh-009vU8-2I; Mon, 26 Jun 2023 21:38:23 +0000
From: Alberto Garcia <berto@igalia.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 3/5] throttle: support read-only and write-only
In-Reply-To: <20230625085631.372238-4-pizhenwei@bytedance.com>
References: <20230625085631.372238-1-pizhenwei@bytedance.com>
 <20230625085631.372238-4-pizhenwei@bytedance.com>
Date: Mon, 26 Jun 2023 21:38:23 +0000
Message-ID: <w51mt0l52gg.fsf@igalia.com>
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

On Sun 25 Jun 2023 04:56:29 PM +08, zhenwei pi wrote:
>  void throttle_timers_attach_aio_context(ThrottleTimers *tt,
>                                          AioContext *new_context)
>  {
> -    tt->timers[THROTTLE_TIMER_READ] =
> -        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
> -                      tt->timer_cb[THROTTLE_TIMER_READ], tt->timer_opaque);
> -    tt->timers[THROTTLE_TIMER_WRITE] =
> -        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
> -                      tt->timer_cb[THROTTLE_TIMER_WRITE], tt->timer_opaque);
> +    if (tt->timer_cb[THROTTLE_TIMER_READ]) {
> +        tt->timers[THROTTLE_TIMER_READ] =
> +            aio_timer_new(new_context, tt->clock_type, SCALE_NS,
> +                          tt->timer_cb[THROTTLE_TIMER_READ], tt->timer_opaque);
> +    }
> +
> +    if (tt->timer_cb[THROTTLE_TIMER_WRITE]) {
> +        tt->timers[THROTTLE_TIMER_WRITE] =
> +            aio_timer_new(new_context, tt->clock_type, SCALE_NS,
> +                          tt->timer_cb[THROTTLE_TIMER_WRITE], tt->timer_opaque);
> +    }
>  }

If now any of the timers can be NULL, don't you want to add additional
checks / assertions to (at least) throttle_schedule_timer() ?

Berto

