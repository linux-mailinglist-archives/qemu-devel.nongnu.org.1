Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41541836C75
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:06:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRxjB-0002kW-9P; Mon, 22 Jan 2024 12:04:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxiy-0002jx-Tb
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:04:41 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxix-0006Py-6e
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:04:40 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-556c3f0d6c5so4273672a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705943077; x=1706547877; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KSBqd9k1kWVdc0fAFzc8l9sC4D/kg9Zdss044DvcT4M=;
 b=ei+rK0r1em25ljn/cO1sUG7IE3gzyZZIe2VYPFiBjjdjKEPDpi4OsRfYSRK804poY/
 4c++85YJUZY9cx7u4KtLS0eGoqNdd7mOCgyoTXb1SAgP3BO/jSsj4iIW3cy/bs2Db0FG
 TZJjtzDnwIQ4Gg3Jyy8ZniuYaNdxXY0xFKy1BUpbAvqU5F2hcZrxrbRyMAz66/hMYu5L
 YHW/ZKkYefBm0feAoaU94B1QhBVeXbU+8ZUnP7Uu2Mp3rb4YLpOUkZsK9UNAmgsHgSHn
 sz/CDo28WTx2W79QofgMZv8Bm0RkhBPgNlvvwummdt+wDMJyq9q4qTDUkopkbhUBoVBX
 g3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705943077; x=1706547877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KSBqd9k1kWVdc0fAFzc8l9sC4D/kg9Zdss044DvcT4M=;
 b=VE31h05ZicYvFMXAUeGT/qyR6YPCAJ26j4ztbHguAfc89sX8tL0RM0/FsLEnmvbBXG
 PVl8JebKR8v44Ty834zd9QNeZJLssJlo3htanyo4h3QC/eVmwEQW/dWT1cM1sdCuT9Yj
 q9Ja0ZPqyO4+9ghy2VETH5nX/vVX1159YSHb0wtkVkk3l7L0YlR7hS/p4Oa22o29GbuD
 79SJWVNfDD5RUzrmSMfoj50iOpmX/6WOrAjtD/7q5I9sPAlkcr6U4sizxs6xRWX2rJAN
 eY166mjfo+gyIO16YvKpKTe+fMp5uFCTIO04jyw8j8i7qg/Xbr6HVD8XLksvovtdzBDq
 UqBw==
X-Gm-Message-State: AOJu0YzaVZxEtLWEYUZyuN8mhu2KQacKPP6OdpeKXuOS5SVxmCmCqm3i
 dXT0s/7me9Dpd+0MzyMEErhfzYYppwEL9p9ssLvQO4t8YJNKa5mKJ/z04EY+KY0hmhLladRH0sE
 09IydjTOQtw3lots7v+XaxNhtQ82jibTwyBRUMA==
X-Google-Smtp-Source: AGHT+IHO1KcTJW1u4+mSMIcMvgKv+pdrR3d1yuUOdJeydCxz3r/qSIX8/nj7/54HMnpyW642Dtofnm+JOMJNy1K/mDI=
X-Received: by 2002:aa7:d7d2:0:b0:55b:fef2:121c with SMTP id
 e18-20020aa7d7d2000000b0055bfef2121cmr88171eds.9.1705943076965; Mon, 22 Jan
 2024 09:04:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40mnyxgmwY39jKMHsZCrCXdozNwFO+RDTYMPUhfkGu_pfFQ@mail.gmail.com>
In-Reply-To: <CAHP40mnyxgmwY39jKMHsZCrCXdozNwFO+RDTYMPUhfkGu_pfFQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 17:04:26 +0000
Message-ID: <CAFEAcA-9LS2hP=Ju6K_wWdhFWVrwhYinSaq6P0s5xmcE6pDtKw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Avoid conflicting types for 'copy_file_range'
To: Manolo de Medici <manolodemedici@gmail.com>
Cc: qemu-devel@nongnu.org, bug-hurd@gnu.org, 
 Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

(Cc'ing the block folks)

On Thu, 18 Jan 2024 at 16:03, Manolo de Medici <manolodemedici@gmail.com> wrote:
>
> Compilation fails on systems where copy_file_range is already defined as a
> stub.

What do you mean by "stub" here ? If the system headers define
a prototype for the function, I would have expected the
meson check to set HAVE_COPY_FILE_RANGE, and then this
function doesn't get defined at all. That is, the prototype
mismatch shouldn't matter because if the prototype exists we
use the libc function, and if it doesn't then we use our version.

> The prototype of copy_file_range in glibc returns an ssize_t, not an off_t.
>
> The function currently only exists on linux and freebsd, and in both cases
> the return type is ssize_t
>
> Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> ---
>  block/file-posix.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 35684f7e21..f744b35642 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2000,12 +2000,13 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
>  }
>
>  #ifndef HAVE_COPY_FILE_RANGE
> -static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
> -                             off_t *out_off, size_t len, unsigned int flags)
> +ssize_t copy_file_range (int infd, off_t *pinoff,
> +                         int outfd, off_t *poutoff,
> +                         size_t length, unsigned int flags)

No space after "copy_file_range". No need to rename all the
arguments either.

>  {
>  #ifdef __NR_copy_file_range
> -    return syscall(__NR_copy_file_range, in_fd, in_off, out_fd,
> -                   out_off, len, flags);
> +    return (ssize_t)syscall(__NR_copy_file_range, infd, pinoff, outfd,
> +                            poutoff, length, flags);

Don't need a cast here, because returning the value will
automatically cast it to the right thing.

>  #else
>      errno = ENOSYS;
>      return -1;

These changes aren't wrong, but as noted above I'm surprised that
the Hurd gets into this code at all.

Note for Kevin: shouldn't this direct use of syscall() have
some sort of OS-specific guard on it? There's nothing that
says that a non-Linux host OS has to have the same set of
arguments to an __NR_copy_file_range syscall. If this
fallback is a Linux-ism we should guard it appropriately.

For that matter, at what point can we just remove the fallback
entirely? copy_file_range() went into Linux in 4.5, apparently,
which is now nearly 8 years old. Maybe all our supported
hosts now have a new enough kernel and we can drop this
somewhat ugly syscall() wrapper...

thanks
-- PMM

