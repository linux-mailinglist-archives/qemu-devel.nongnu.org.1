Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E298AD52DD
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Jun 2025 12:58:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPJ9F-0004sc-9t; Wed, 11 Jun 2025 06:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uPJ9A-0004sG-Da
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 06:57:32 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uPJ98-0003gt-Fv
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 06:57:32 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-606ddbda275so11830714a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 03:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749639447; x=1750244247; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TephkakpXOKkZja43JYV7fzw/Bf9/74knzYT3p3IV/I=;
 b=ZBISPhEc/5o4F9YxkMAsm0U0gpiRHAw260YfRRDU9usZvSajgqCFmooomnjKJLBq8j
 Aull0b+MyGt3MReE/xoZE4QN59cRALHW59Zu6g/55v13186qTPxH5qqBq+KEo+AulNLb
 3PKN0yAMvnemfNFnRakHpE6vtDFwWX5Jgjxkj5G1VHnJb5MJoP0iImULu0ZkpUyG/YS6
 +2M6H+Fw57sDMQ/Uy4YHLl2Ow3CR78PmULCSl233M83c2AisBQljaSfBUaU5zE48VJXZ
 sCYdTb28CNIhheJeQXr0lwaOEowQhDCqchGfr4L1qa8efgGwdwjsAkvdo4iBDWhrsl8L
 lKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749639447; x=1750244247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TephkakpXOKkZja43JYV7fzw/Bf9/74knzYT3p3IV/I=;
 b=HrBKldgBW2OHUt1k1evKqUJZt7zWWxj0ETavmvJyzQw+GM3B0ZExkLUk0oqVIxFq2E
 aQ7aDBhofZDTZnby8yaVoMX+mE6svlT1tXK4DFYiOxyINwu7f5VK9GARouADeTX3QuU2
 0xD2zVLdZlyrBu0I95egr2UU+Ng59a7l5TeagpYNeAjc8PZ93yWYvs7aGWegA036oMgB
 UkUaChsczsq/WBGZDkjiygublQiPeuYPTcJyBzewNox2EcAiSsIj+Pf6+CZWhjMAEqln
 GSW8E9nQPIVYbDqv4uwYSgXPhmEJAJmiSKeicwANXv/A+ae9PLVj3wUwJyiLxEmfAWPI
 1r/Q==
X-Gm-Message-State: AOJu0YzY0ErZq0Ccr4xMtOn90ie6x6SRpN3aK+fnuStDB8QjmE5usCkv
 B8i5lL/tqML+Lxr+xLfmEHwqflOiDPIESBURCHPIGxJdwPKIHxK5TOVLnI7Xa0DOvYvraeUuJpK
 jrVIAhXWliK5efI3yxDh0z1JyvasrQgNUKNYIi2ZOIQ==
X-Gm-Gg: ASbGncuMrPvqfXVLqC20a3JBNl5f5yPp/AT1uLzhIVrw4C0L0DhLwUAVvCu0Lvci3Oo
 UAjKfZNd8eKFWqSLduSuV0sztkOvL3CJwqXtSYzNOLAbHEzNI9BpCIMJqQacTRSvvpBgUTlbJzJ
 9H8PDZBvW0jpt/ACWVmSaxvR95eR278cTewcFM54WgCHsk
X-Google-Smtp-Source: AGHT+IG9MkPJYu6vzWS21PFBiCmWmRZJOQPZ9b6637ExDONViHZ8MF+k95ArrR7IoPfO/bEP2mv8cjKUNwIzbcq4VNY=
X-Received: by 2002:a05:6402:84d:b0:601:dc49:a99f with SMTP id
 4fb4d7f45d1cf-60846c4d8bemr2342367a12.18.1749639447259; Wed, 11 Jun 2025
 03:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250610202110.2243-1-shentey@gmail.com>
 <20250610202110.2243-2-shentey@gmail.com>
In-Reply-To: <20250610202110.2243-2-shentey@gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 11 Jun 2025 13:57:00 +0300
X-Gm-Features: AX0GCFs4WbWvamt5AfO_ND4wzfJ-ZEA6AimiMP8deSGNRZ60-yqof-eZhiwdcqw
Message-ID: <CAAjaMXbtcyB3J3AvGh8ZW3MSi41uMaE+TkZwipCs5pg6wvYJ=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust/qemu-api: Add initial logging support based
 on C API
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 10, 2025 at 11:21=E2=80=AFPM Bernhard Beschow <shentey@gmail.co=
m> wrote:
>
> A log_mask!() macro is provided which expects similar arguments as the
> C version. However, the formatting works as one would expect from Rust.
>
> To maximize code reuse the macro is just a thin wrapper around
> qemu_log(). Also, just the bare minimum of logging masks is provided
> which should suffice for the current use case of Rust in QEMU.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  docs/devel/rust.rst       |  1 +
>  rust/wrapper.h            |  2 ++
>  rust/qemu-api/meson.build |  1 +
>  rust/qemu-api/src/lib.rs  |  1 +
>  rust/qemu-api/src/log.rs  | 76 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 81 insertions(+)
>  create mode 100644 rust/qemu-api/src/log.rs
>
> diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
> index 47e9677fcb..dc8c44109e 100644
> --- a/docs/devel/rust.rst
> +++ b/docs/devel/rust.rst
> @@ -162,6 +162,7 @@ module           status
>  ``errno``        complete
>  ``error``        stable
>  ``irq``          complete
> +``log``          proof of concept
>  ``memory``       stable
>  ``module``       complete
>  ``qdev``         stable
> diff --git a/rust/wrapper.h b/rust/wrapper.h
> index 6060d3ba1a..15a1b19847 100644
> --- a/rust/wrapper.h
> +++ b/rust/wrapper.h
> @@ -48,6 +48,8 @@ typedef enum memory_order {
>  #endif /* __CLANG_STDATOMIC_H */
>
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/log-for-trace.h"
>  #include "qemu/module.h"
>  #include "qemu-io.h"
>  #include "system/system.h"
> diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> index cac8595a14..33caee3c4f 100644
> --- a/rust/qemu-api/meson.build
> +++ b/rust/qemu-api/meson.build
> @@ -21,6 +21,7 @@ _qemu_api_rs =3D static_library(
>        'src/errno.rs',
>        'src/error.rs',
>        'src/irq.rs',
> +      'src/log.rs',
>        'src/memory.rs',
>        'src/module.rs',
>        'src/prelude.rs',
> diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
> index 93902fc94b..e20be35460 100644
> --- a/rust/qemu-api/src/lib.rs
> +++ b/rust/qemu-api/src/lib.rs
> @@ -21,6 +21,7 @@
>  pub mod errno;
>  pub mod error;
>  pub mod irq;
> +pub mod log;
>  pub mod memory;
>  pub mod module;
>  pub mod qdev;
> diff --git a/rust/qemu-api/src/log.rs b/rust/qemu-api/src/log.rs
> new file mode 100644
> index 0000000000..9e3c61b8b7
> --- /dev/null
> +++ b/rust/qemu-api/src/log.rs
> @@ -0,0 +1,76 @@
> +// Copyright 2025 Bernhard Beschow <shentey@gmail.com>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#[repr(u32)]
> +/// Represents specific error categories within QEMU's logging system.
> +///
> +/// The `Log` enum provides a Rust abstraction for logging errors, corre=
sponding
> +/// to a subset of the error categories defined in the C implementation.
> +pub enum Log {
> +    /// Log an invalid access caused by the guest.
> +    /// Corresponds to `LOG_GUEST_ERROR` in the C implementation.
> +    GuestError =3D crate::bindings::LOG_GUEST_ERROR,
> +
> +    /// Log guest access of unimplemented functionality.
> +    /// Corresponds to `LOG_UNIMP` in the C implementation.
> +    Unimp =3D crate::bindings::LOG_UNIMP,
> +}
> +
> +/// A macro to log messages conditionally based on a provided mask.
> +///
> +/// The `log_mask` macro checks whether the given mask matches the curre=
nt log
> +/// level and, if so, formats and logs the message. It is the Rust count=
erpart
> +/// of the qemu_log_mask() macro in the C implementation.
> +///
> +/// # Parameters
> +///
> +/// - `$mask`: A log level mask. This should be a variant of the `Log` e=
num.
> +/// - `$fmt`: A format string following the syntax and rules of the `for=
mat!`
> +///   macro. It specifies the structure of the log message.
> +/// - `$args`: Optional arguments to be interpolated into the format str=
ing.
> +///
> +/// # Example
> +///
> +/// ```
> +/// use qemu_api::log::Log;
> +/// use qemu_api::log_mask;
> +///
> +/// let error_address =3D 0xbad;
> +/// log_mask!(
> +///     Log::GuestError,
> +///     "Address 0x{error_address:x} out of range\n"
> +/// );
> +/// ```
> +///
> +/// It is also possible to use printf-style formatting, as well as havin=
g a
> +/// trailing `,`:
> +///
> +/// ```
> +/// use qemu_api::log::Log;
> +/// use qemu_api::log_mask;
> +///
> +/// let error_address =3D 0xbad;
> +/// log_mask!(
> +///     Log::GuestError,
> +///     "Address 0x{:x} out of range\n",
> +///     error_address,
> +/// );
> +/// ```
> +#[macro_export]
> +macro_rules! log_mask {
> +    ($mask:expr, $fmt:tt $($args:tt)*) =3D> {{
> +        // Type assertion to enforce type `Log` for $mask
> +        let _: Log =3D $mask;
> +
> +        if unsafe {
> +            (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::ra=
w::c_int)) !=3D 0
> +        } {
> +            let formatted_string =3D format!($fmt $($args)*);
> +            let c_string =3D std::ffi::CString::new(formatted_string).un=
wrap();
> +
> +            unsafe {
> +                ::qemu_api::bindings::qemu_log(c_string.as_ptr());
> +            }
> +        }
> +    }};
> +}
> --
> 2.49.0
>

Maybe we could take this chance to remove the requirement for trailing
newline? Not urgent, and also something we could change afterwards
anyway. We could also introduce log_mask_ln! macro but now I'm just
bikeshedding.

Besides that, I think it'd be useful to have the macro re-exported in
rust/qemu-api/src/prelude.rs as well. Please add it for the next
version.

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

