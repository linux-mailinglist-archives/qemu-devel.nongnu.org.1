Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 443A97D99A6
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 15:22:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwMmw-0007LM-DE; Fri, 27 Oct 2023 09:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwMmt-0007Kj-0B
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:22:08 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwMmq-0002RF-Ej
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:22:06 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso4272915a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698412923; x=1699017723; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nHQ7YQy3lBrYrdyGxt3QRkq9zS4Q5TJ94eZgpMheI+k=;
 b=J9NID02ogXaqLvME3QMXFV4FKqypKox+5ErTwSvsyvSHmVjjwMDvm9NDO8/DDuusTT
 L+o/z966hQEe32Q0Z/TKNcv0yKyovaze0hCURQeClLM7x23MmovdML/PignDaykrjd6R
 a8OkjK8zlp57TFhHAjWD6UiJucA8lcugLQSzFSUN/HN3E8H/lkAsbOCX4QdXVj7cBsfO
 uXduHOVTi0lYAdstNgUVJIqsoxRVq7iqYcXRRCgLrt2ks22jHkaKMlAe6XHPY9x4mzqd
 dp42A1GWGWCbysVvxR6vCI2Oi1tDcvS1e4zsW+ewEFgzjLfngQs7NtsjtIcB1wRWPoaq
 F4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698412923; x=1699017723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nHQ7YQy3lBrYrdyGxt3QRkq9zS4Q5TJ94eZgpMheI+k=;
 b=CS61Ed2F0GQZyQtx/jb8vyBVl/jnuMpa8NW986BnopsLa4+6MTQqxqq9JB6/S7eBS5
 bksQxh6T8L/vjzBaAvPjcrPY2IXsKB6KePGx1z8far4ap5zbGhwe6ppXoTgcZHd7UxtC
 /hxJaZ/hOC5N7dPeIDX1HLGwikUrDbnZGw4yNpOyXVBFY8pGgjg6ZA1zca3U2lcmTiV9
 Z8tanV10vQSi6IyRPE5s2vhIi+2NuAABu/FNB49ilHKpbSPCVnGllXCqP/cdljHivd2b
 0jcOimRjjxhn6mBV/4Oi7PXaDVw9Ya/lvddYuH1YGEbaWYJZ04uhttEmt7uDPfkBuBNd
 26Aw==
X-Gm-Message-State: AOJu0YyCJ9R1NJUy3l82LAioWHQCSdhkjOmYmHs6uLBT7QglBd9gl8D5
 Gar1aUakgIW0yAp12cH/Nhxode8GWbOBk/7/kuMBtw==
X-Google-Smtp-Source: AGHT+IHTDcDknBDt+G/I5bwajw54Gy3SI/eFOSDtTCaCCEwmMxv+MlEQU77a7j+y6Ep1Kxzl1Xcnr+2MWCn5ewr6I4E=
X-Received: by 2002:a05:6402:10d6:b0:53e:5c4d:ba15 with SMTP id
 p22-20020a05640210d600b0053e5c4dba15mr5669696edu.8.1698412922726; Fri, 27 Oct
 2023 06:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
 <20231025193822.2813204-2-hao.xiang@bytedance.com> <87zg041c42.fsf@suse.de>
In-Reply-To: <87zg041c42.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Oct 2023 14:21:51 +0100
Message-ID: <CAFEAcA_2PP1AqqOWz8phfJ7e4s5_fMqCyCdhd0m9OvJHwjVeug@mail.gmail.com>
Subject: Re: [PATCH 01/16] Cherry pick a set of patches that enables multifd
 zero page feature.
To: Fabiano Rosas <farosas@suse.de>
Cc: Hao Xiang <hao.xiang@bytedance.com>, quintela@redhat.com, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, 27 Oct 2023 at 13:32, Fabiano Rosas <farosas@suse.de> wrote:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > Juan Quintela had a patchset enabling zero page checking in multifd
> > threads.
> >
> > https://lore.kernel.org/all/20220802063907.18882-13-quintela@redhat.com/
>
> Hmm, risky to base your series on code more than an year old. We should
> bother Juan so he sends an updated version for review.

Also, if we do need to base another series on some older
patches, the usual way to do this is to include those
patches in the series in a suitably split-up manner, not
to squash them all together into a single patch (with no
signed-off-by tag).

For "assume this as a baseline, please review the other
patches but this patch is not fit to go in", that should make
the whole patchset into an RFC patch so wo don't accidentally
apply this patch.

thanks
-- PMM

