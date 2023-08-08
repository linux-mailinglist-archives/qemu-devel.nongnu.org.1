Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEACE773826
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 08:17:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTG0d-0000Zf-K0; Tue, 08 Aug 2023 02:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qTG0H-0000YN-9E
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 02:15:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qTG0E-00040U-TA
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 02:15:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8C2E118D6B;
 Tue,  8 Aug 2023 09:15:33 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B67031C28E;
 Tue,  8 Aug 2023 09:15:30 +0300 (MSK)
Message-ID: <3855b75e-aaac-31ca-7400-60231c5f17ab@tls.msk.ru>
Date: Tue, 8 Aug 2023 09:15:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH for-8.1 v10 10/14] util/selfmap: Rewrite using
 qemu/interval-tree.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-11-richard.henderson@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230807163705.9848-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -86
X-Spam_score: -8.7
X-Spam_bar: --------
X-Spam_report: (-8.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.809,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

07.08.2023 19:37, Richard Henderson wrote:
> We will want to be able to search the set of mappings.
> For this patch, the two users iterate the tree in order.

> diff --git a/include/qemu/selfmap.h b/include/qemu/selfmap.h

>   /**
>    * read_self_maps:
>    *
>    * Read /proc/self/maps and return a list of MapInfo structures.

Nitpick: this comment still says "a list", while in all other places
it has been changed to "a tree".

>    */
> -GSList *read_self_maps(void);
> +IntervalTreeRoot *read_self_maps(void);

/mjt

