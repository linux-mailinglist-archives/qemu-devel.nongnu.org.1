Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7955180CE7F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 15:36:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rChNV-0005Np-FH; Mon, 11 Dec 2023 09:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rChNN-0005M1-VB
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 09:35:18 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rChNJ-0006EL-Kd
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 09:35:14 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55114c073b8so1776024a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 06:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702305312; x=1702910112; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zmqKwLOLcsRNrNYyTXT57CwemoxNNTvme8zbTGrtEt0=;
 b=UYzmoh+cxhLoWJLwcXKXq9Pj968t55C3y6LbyoP9PC6YYbVuYw3lkquUe6ZMZaZsmh
 gQM/F8gNEf2qUFaZ9HDsbIf50BSgSTe8GXXq2yGH7zFnKnv0ZJpSAUo+WBPviMadRA3G
 fx2rPQWoRa9VBhhAvtVzXuIxEqLk3wDSjw4f5xnjzgbc3Fhfq3eabWWRMzd2p5043v8v
 61q15YE3JJOB4Qgs84pjw/cFnZhyUO6e9SwW8f2gAZIfbb/wTkcDw2ONff7/5avvbzky
 JAqsPnxWRf9OpYCG7lQcPN6o6kW2JUQvD04QItOuLEHWbo92JFhJzKBd1Fydyn84IXrQ
 jtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702305312; x=1702910112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zmqKwLOLcsRNrNYyTXT57CwemoxNNTvme8zbTGrtEt0=;
 b=Jtk/taVV/10REIOW67pIliYw3kZSbL9xGDvDnFPl2lXmOoT2Hkd/M5nxgi+1V7jdu3
 CK7PZafZsTf7ZN4GcPF69/lCTeqNrFPIuPAmec1FBCi0kmsySZ6aqTTaXlpfSz45Kz1B
 ktacIHQ8uNxN8Gt35pMQZ8fcfySEA9yTnO5r0ODfy7wMExxPTlONdjk+Sv+0hnFiDPx2
 PUnfopwyLtYW69SX3yn/PzJGVMu+K2O5eHxERPI8CFTQiQVMeBC1usY2x+32jBXAgvTr
 waEgv0r/qYvWAWvq0Wx69Rs6QXgAgnFtfuIYpOOv0OnKIuf/CYnkByJu/9dYSqaKpM/F
 5BaA==
X-Gm-Message-State: AOJu0YyTb/2Sq+vaaoPacGoApt2IOKdnhrBPRycC4luCvlbQc2Qc6Jsv
 vUSd24wJsxP2UQe7+0AMDtIlnwnHoFO7djB6UYYQcA==
X-Google-Smtp-Source: AGHT+IFQUSF5aTbUINyImFAejJnIr1YynUjHHTNqeK5DyGnq0a8pM/X7umuRw9kR7kLJRyZ3NNkowwFfqnw3I97BbJ4=
X-Received: by 2002:a50:d741:0:b0:54c:4837:7d3a with SMTP id
 i1-20020a50d741000000b0054c48377d3amr1803630edj.121.1702305312219; Mon, 11
 Dec 2023 06:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20231123044219.896776-1-richard.henderson@linaro.org>
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Dec 2023 14:35:01 +0000
Message-ID: <CAFEAcA9jeoHuM0Bf0mtRB1tWkjGH4maBOrgBZYm-_ZU+yy-mzg@mail.gmail.com>
Subject: Re: [PATCH for-9.0 00/21] target/arm: kvm cleanups
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 23 Nov 2023 at 04:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is primarily concerned with merging kvm64.c with kvm.c
> and then unexporting everything that is not required outside.
>

Applied to target-arm.next for 9.0, thanks.

-- PMM

