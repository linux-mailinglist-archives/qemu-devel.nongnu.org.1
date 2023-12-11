Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB1780C8EB
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 13:03:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCeym-0002H6-Ep; Mon, 11 Dec 2023 07:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCeyj-0002Ge-T8
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 07:01:42 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCeyg-0001Kx-EI
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 07:01:39 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d06d42a58aso40560425ad.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 04:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702296097; x=1702900897;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8dcHCxeaZY1wg/dw2gOh0oa5T+d4G9738aj+mRj9xSQ=;
 b=rKaZDLCuoqE+3wtG+LJiCquK4krJ+lAOUMSBpfABrfB9+8Ix2J0LbZapaXPoPzuyCh
 fB9t2EsjRBSQbveIlBsOsMSQ+MZiYwlohATIqdFt/9DhKQqH54sFtWtfZADL0VzC/0vs
 V2pgoQ87w+K+h6ygYg8G2DioSdSCUNAXfSa1WJRC8A5hxEXKcqCqtHOy0fZc4LIQ7fbr
 V6YwHxc/4vwakwhjEajaTYEBeU3C4HxIEyBVlFvw609wqLn8L3nMAsYl/Xtg2XvIdZX9
 rYA9jRoHntVHDfejMBA8vFvir6tOW6yUgmQ3ZqYSNuRBg8bxeWUu+a64JiXmfG0dZUi1
 BFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702296097; x=1702900897;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8dcHCxeaZY1wg/dw2gOh0oa5T+d4G9738aj+mRj9xSQ=;
 b=CIKkUJxnVRhSctp/q4/J0elXRBf8VbPNmIkPA30qJYgO/cxdGb660BFo55Bh8tuqvL
 vkVeCbHiviPw6xZee+qLNzENP8aZH4+pLVSC+gInRoRD+2QUlIcb51C4llcVfo0za7DV
 LMU5MEcwNTjY/4UqkofYPpPVAc3lHcbXO3gBED5bzaDmy29BJz0oCxb6zjz03azEG2SV
 nhP1Hl9OuCAWuu9+2zlIumthe+EQ904/L48P+skg8glPAMubQNpTw1x8gLnNYIyDe9El
 /ZWLk2jYJf4AiBN9qmQYoLRWC76fWNxJye9HqDqFioZkXfYfweGo/rPFGA0ZH/Ql8gWI
 kNJQ==
X-Gm-Message-State: AOJu0YykskkvqRulJ/AtWzFRFtCEetMiIz48pchEa4vOKYxvA56lh0Rr
 uOTazkLrvyElzAoH6WY2KJ1CTg==
X-Google-Smtp-Source: AGHT+IEmO2eeumr+nwOdFRCe9afX7njgwiqRL8XURCxcriEaqKvujPSB5numFrBrSfYye4qz/O6XSg==
X-Received: by 2002:a17:902:a5c7:b0:1d0:7844:5086 with SMTP id
 t7-20020a170902a5c700b001d078445086mr3595226plq.7.1702296096928; 
 Mon, 11 Dec 2023 04:01:36 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 m2-20020a170902bb8200b001cfd2cb1907sm6456737pls.206.2023.12.11.04.01.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 04:01:36 -0800 (PST)
Message-ID: <431e5902-970b-4fd5-8302-dcc9c4c76bd7@daynix.com>
Date: Mon, 11 Dec 2023 21:01:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/19] virtio-net RSS/hash report fixes and improvements
Content-Language: en-US
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org,
 "Zhang, Chen" <chen.zhang@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <20231210-rss-v8-0-9553ee714d38@daynix.com>
 <CAOEp5Ofj+a2rqGWw=oLXBqrXqUj6XRc=Je3ScaE5sxZFzaAOdA@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5Ofj+a2rqGWw=oLXBqrXqUj6XRc=Je3ScaE5sxZFzaAOdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/11 20:54, Yuri Benditovich wrote:
> People, I suggest to wait a little and understand what happens with the 
> previous series from Andrew Melnichenko (support for qemu under libvirt etc)

Can you share the link to the series?

> According to response from Jason from Sept 8 it was queued but I do not 
> see it in the master branch.

I didn't see it either.

Regards,
Akihiko Odaki

