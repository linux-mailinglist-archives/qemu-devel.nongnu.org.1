Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4712E7E9A60
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 11:36:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2UGs-0004ph-GG; Mon, 13 Nov 2023 05:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2UGq-0004pP-6p
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 05:34:20 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2UGo-0003nN-Lu
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 05:34:19 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53e08b60febso6537002a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 02:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699871656; x=1700476456; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QrcXSqAi8vMbw67ksSuWjxTgnBx4C/i2PpT4Irf43ko=;
 b=SMsUJzetJwZ5Z9Seskagha1tNla44ul8hdDX7cCJGK1Yj5vbFcqe3bm828BFPLZhSw
 qbGLPx/8dF4r1rRHPuYowJrs7IUawOgTIHfEzu/obaSHTBYPCTyhRzOp1CRTfTCACrut
 EqyaIhi+szPP9hyA0oT2jGh/R8nwq4EDJifRM5qmkAbD1su6mqHYMxi5ntP6Z93NbqN3
 M+AuxK/lUMlvm39NjTTzfrO+5VWvi4TuBWklCYa4V5KYPr7fDy8+p6+JelAMlrOhOvZc
 q3Ll6ytyu+UeedKNpWcXs56FFBzwZJI7Z0P+VVrQenfEsTJBjBtFQvQJV4fIv48xeji7
 RQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699871656; x=1700476456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QrcXSqAi8vMbw67ksSuWjxTgnBx4C/i2PpT4Irf43ko=;
 b=Xd2KI3koV3TfSPPO7rHgEvEIaeCWVDyFpKDPUUuZ2Yu5ckJGIDm4AaCEHRwbcKGrlw
 pvxsbypEQVYYGh/cQOEsbQaG6pjs07/PIH3kEEjm9Nv3L/RNz6nmxowVLpq4ew5gPP5C
 5PYD1I7BjhB47i223Qx1+oqZVXDKVW4nK7qfPiRy0PrfDPnLJ5MndZ2iDekPoSO11yBJ
 +R2k5S0xpsLr3kx4etv7P5QyjayWSIUtIN/ZrxRYiuNUsOSuDbuZE0tXt8jrXn2r2rOm
 23vowxX/V+n8YY/Hn4CX8v8J0shSSiZsP9NP3IMg3gPsNxAah0yzGst2cG8TzWx/3Nj1
 QyFQ==
X-Gm-Message-State: AOJu0Yyy3v+4lErECXWJkvmaWnnJa2cjdMDfaPbzJ3Kd8ib5LeyifOSD
 Vltjl477hP7PtJPIWxka3QjoYr2YbirzxT8iPsgJxgUXi4PCFwE2ww4=
X-Google-Smtp-Source: AGHT+IEzYxYS6ER2NT1eR+xrrQe/XZ1Wl9yidR4ZvKX1NyCqBMyzxNU5ylI9GNQxu+24Ch+ghomaWFANuIrZNJg5Ekc=
X-Received: by 2002:a05:6402:31e2:b0:53e:4dc6:a2e8 with SMTP id
 dy2-20020a05640231e200b0053e4dc6a2e8mr4621279edb.19.1699871656458; Mon, 13
 Nov 2023 02:34:16 -0800 (PST)
MIME-Version: 1.0
References: <3b2253d199165648b958570d6c4db86d6ced139d.1699545634.git.maciej.szmigiero@oracle.com>
 <54045bb8-8cc1-403e-b22d-2b14476e30a7@redhat.com>
In-Reply-To: <54045bb8-8cc1-403e-b22d-2b14476e30a7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2023 10:33:32 +0000
Message-ID: <CAFEAcA_eEkU_6XRA+sOUBaM+6iXr_vFdVmOD++RbYHiq037rbA@mail.gmail.com>
Subject: Re: [PATCH] hv-balloon: avoid alloca() usage
To: David Hildenbrand <david@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 13 Nov 2023 at 08:59, David Hildenbrand <david@redhat.com> wrote:
>
> On 09.11.23 17:02, Maciej S. Szmigiero wrote:
> > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> >
> > alloca() is frowned upon, replace it with g_malloc0() + g_autofree.
> >
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>
> If this fixes a coverity issue of #number, we usually indicate that
> using "CID: #number" or Fixes: CID: #number"

It won't actually fix the CID, though -- the Coverity issue is
because Coverity doesn't understand that if you allocate memory
for a struct with a single-element array + something extra then
it's OK to index off the apparent end of the array because the
extra memory is there. Switching the allocation from
alloca to g_malloc won't change that, because we're still
walking off the end of the defined struct.

I don't personally like that coding pattern partly because of this,
but I'm assuming we're dealing with somebody else's API here.
Using a proper standard variable-length-array rather than a
one element array might also help, but again, I'm guessing we
don't have that flexibility to change it.

thanks
-- PMM

