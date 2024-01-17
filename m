Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A2A830BF3
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 18:32:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ9ly-0001Tg-Pv; Wed, 17 Jan 2024 12:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQ9lv-0001TI-US
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:32:15 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQ9lu-0004CB-Bd
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:32:15 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-559f92bf7b6so46465a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705512732; x=1706117532; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UI3Yt09naz9k/K/ZCcVs/A0x4BRir28vu+0LQFu+n+E=;
 b=wgQ47s1LdjSLDpKNECjrDgGk265yK8KNSQZjPX5PqqzFekYLc84Iq7sSzHxBRxudTT
 4Aai4xN0ylq8k/DFQqBnmsjKNbE41nadm5zmGn2j4EMw4SQ4qf1kUz3c25TOaOJDZqA5
 x8Rlq0Ucrigbx5q9KCPY5FIDG0cNYRLzQBnxdNIwRICltgCr+ZkHjgzueySy4kPdqYpS
 PKzwyrGM0ned+n1U5eM5vREkFnYGqWGU3ArJLllvQqEcOfIH5HyjK+77WwsOPJn9N5tC
 c+Ls+gP+yYR1EfjlJLzkux+DSiS9OZW7LN4jDouxnIT2d9WEtVfJCOwJs2eEcEwbdgbR
 w3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705512732; x=1706117532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UI3Yt09naz9k/K/ZCcVs/A0x4BRir28vu+0LQFu+n+E=;
 b=Pz/hLrtwkAkOVeDMhv33mdKQ1oUIhrCA3yx68zsl/xqybyYVUVduzsZs9UqZCU78Jt
 B9ig7DZle/oZS9I9y3n2oiDipq4I680KvbIbNmEm9qZSv5pn3PqIoSDhsTe0kIqgRUJs
 spDcD9DzN5nxIi795ZLeKzN0uHDzhL8yCwA4QERbiIlUjcQRle7JP20h7EeFutdi0/s2
 vniARPdhWKEJ9qPgRW/IkJJP7nYMEkDWNMWe6kwcsh+PVewGaH6QH21a5mfvkivjnVgz
 iSSpNp1uDmoUL+mQMpc7EBcRGH2DGwkAVOvKRYDkicd0HSVmHXnB2rn+ekbBBTWVGKLX
 Ef+Q==
X-Gm-Message-State: AOJu0Yx0QzxMinWXHsdBMGS9NzV/oebt8yjesofiL+i1LjpyX8aBIwx0
 FNEnQe1/sV+VuvXjFQdDowcjAeZhstQCTy3+3q7t+iYPm9gavQ==
X-Google-Smtp-Source: AGHT+IF18PgCNceRusUmaaMlInvJN93N8WPTk0PcPvI8tvhHeOdfIFyb+rQnF9UWlOyKhPd5uJcSfmrirqqEZyBdX/8=
X-Received: by 2002:a05:6402:1bcb:b0:559:f1ed:f164 with SMTP id
 ch11-20020a0564021bcb00b00559f1edf164mr462053edb.27.1705512732000; Wed, 17
 Jan 2024 09:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20240109092015.4136865-1-kai.kang@windriver.com>
In-Reply-To: <20240109092015.4136865-1-kai.kang@windriver.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Jan 2024 17:31:39 +0000
Message-ID: <CAFEAcA9LBXMxOzJwmXYEVj+q0hTzMQZrpZHOOKFYWZDKXFyHig@mail.gmail.com>
Subject: Re: [PATCH] qdev: not add devices to bus in reverse order
To: Kai Kang <kai.kang@windriver.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

(cc'd the people listed for this file in MAINTAINERS)

On Tue, 9 Jan 2024 at 13:53, Kai Kang <kai.kang@windriver.com> wrote:
>
> When this section of source codes were added via commit:
>
> * 02e2da45c4 Add common BusState
>
> it added devices to bus with LIST_INSERT_HEAD() which operated on the
> single direction list. It didn't have something like LIST_INSERT_TAIL()
> at that time and kept that way when turned to QTAILQ.
>
> Then it causes the fist device in qemu command line inserted at the end
> of the bus child link list. And when realize them, the first device will
> be the last one to be realized.
>
> Replace QTAILQ_INSERT_HEAD_RCU() with QTAILQ_INSERT_TAIL_RCU() to make
> sure that devices are added to bus with the sequence in the command
> line.

What are the problems being caused by the the list items being added
in reverse order? Your commit message doesn't say what specific
bug or problem it's trying to fix.

In general this kind of patch is something I'm very cautious about,
because it seems very likely that various bits of the code where
order does matter will currently be expecting (and working around)
the reverse-order behaviour, because that's what has been done by
bus_add_child() for the last 20-plus years. (As one concrete example,
see the big comment at the top of create_virtio_devices() in
hw/arm/virt.c. There are probably others where we didn't comment
on the ordering but just assume it.)

> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 43d863b0c5..5e2ff43715 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -89,7 +89,7 @@ static void bus_add_child(BusState *bus, DeviceState *child)
>      kid->child = child;
>      object_ref(OBJECT(kid->child));
>
> -    QTAILQ_INSERT_HEAD_RCU(&bus->children, kid, sibling);
> +    QTAILQ_INSERT_TAIL_RCU(&bus->children, kid, sibling);
>
>      /* This transfers ownership of kid->child to the property.  */
>      snprintf(name, sizeof(name), "child[%d]", kid->index);

thanks
-- PMM

