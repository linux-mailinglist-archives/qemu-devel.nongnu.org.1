Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39797780806
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 11:11:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWvVB-0002VM-Vx; Fri, 18 Aug 2023 05:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qWvV8-0002Tm-Ex
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:10:38 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qWvV6-00023E-7J
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:10:38 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fe3b86cec1so959341e87.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 02:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692349834; x=1692954634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eeqSIo/mIgJJPlkKnQJIhYtY/4H6w1YKGY2KemlysLo=;
 b=u9HS2nc+Gu0SpCxxm1/tIrN/wGR6liQBgfO97ZzmDQVdDqqvS4Czu6JXam4OznDH78
 cMDKE6b95wBdCUv06V9hnet4UdSgUSc8/f+kPIVideeOmIhc1HFoWlPgw1XpZMtzQ1Ad
 RQFPAEDK7/8SRVwLGBTIgBpyIVz8dyp6hkrtP4XZmDvCPZYLFIJpzx/zl/WEmzA6wEWZ
 7M0T7azz/CsWy6hzSTqxHdp+Ocp748LqVcylUZIFYTjmtDBNK++htnAzdyscGLJwXXyF
 Wr7ljUvDoSn/jn0MG3gbkNFoCPmX5Pv2bHJmPYRrY6z2o4Ck+uI3xpO0ESxHTSnZrQoJ
 uKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692349834; x=1692954634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eeqSIo/mIgJJPlkKnQJIhYtY/4H6w1YKGY2KemlysLo=;
 b=MnCfIvqJFajFlwmTNentsdMyrVgOPbB66OWRXs2HvCmk+DLJZnNHAmQOYK8ICIWpTT
 gxS5KfeFyvepRBmBTnLMXp0uP/UgEXjLz4gf76KsHco/ys8HhVWPSLZdQGiS6AaJujuz
 XB56JlTfyEb5FnijfUkXirRdli6GiUEdKEnEkzhNPJ9tvTnGhMlfI4J98dqaL1RLBnqS
 X2QPu/7A3ytYOn1vVZBIAsIpijtQwzmFff7udmacSdZ8jXrY7TKNtR+twT/gMVG4IDyL
 YuX9vDmNkMQX/d4WeYHx2gujP81FnrmFO35afyUSybP0lVnvaA6+37NhjCAQnvkmgV4g
 Vstg==
X-Gm-Message-State: AOJu0Yw0ZldXa1vZXulJpuchRwwAyrxU8+9PjEks0+qlHj5bZFvJ2smw
 RRTpoVDgc/kq5iO9kl1Yhi6AkpBe9Qbzu8KJzf0xsA==
X-Google-Smtp-Source: AGHT+IGpPXbnuDC5Q4q/+adG29s1Bdb6e1Iga624Iu59tSavQaGLrzEDSu0HT+If0X5xgL7CHc5zAnAkaziVjeuCXV8=
X-Received: by 2002:a19:ca1d:0:b0:4fe:958:88ac with SMTP id
 a29-20020a19ca1d000000b004fe095888acmr1124027lfg.6.1692349834066; Fri, 18 Aug
 2023 02:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230818090224.409192-1-chigot@adacore.com>
 <20230818090224.409192-4-chigot@adacore.com>
In-Reply-To: <20230818090224.409192-4-chigot@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Aug 2023 10:10:23 +0100
Message-ID: <CAFEAcA_1SdA_BH_u01FAYaZkABbCB2EcSf329=-GpZ2canjP7A@mail.gmail.com>
Subject: Re: [PATCH 3/3] gdbstub: replace exit(0) with proper shutdown
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Fri, 18 Aug 2023 at 10:03, Cl=C3=A9ment Chigot <chigot@adacore.com> wrot=
e:
>
> This replaces the exit(0) call by a shutdown request, ensuring a proper
> cleanup of Qemu. Otherwise, some connections could be broken without
> being correctly flushed.
>
> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> ---
>  gdbstub/gdbstub.c |  3 +--
>  gdbstub/softmmu.c | 11 +++++++++++
>  gdbstub/user.c    |  2 ++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 5f28d5cf57..358eed1935 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1298,7 +1298,6 @@ static void handle_v_kill(GArray *params, void *use=
r_ctx)
>      gdb_put_packet("OK");
>      error_report("QEMU: Terminated via GDBstub");
>      gdb_exit(0);
> -    exit(0);
>  }
>
>  static const GdbCmdParseEntry gdb_v_commands_table[] =3D {
> @@ -1818,7 +1817,7 @@ static int gdb_handle_packet(const char *line_buf)
>          /* Kill the target */
>          error_report("QEMU: Terminated via GDBstub");
>          gdb_exit(0);
> -        exit(0);
> +        break;
>      case 'D':
>          {
>              static const GdbCmdParseEntry detach_cmd_desc =3D {
> diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
> index f509b7285d..9ca7ae10bc 100644
> --- a/gdbstub/softmmu.c
> +++ b/gdbstub/softmmu.c
> @@ -434,6 +434,17 @@ void gdb_exit(int code)
>      }
>
>      qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
> +
> +    /*
> +     * Shutdown request is a clean way to stop the QEMU, compared
> +     * to a direct call to exit(). But we can't pass the exit code
> +     * through it so avoid doing that when it can matter.
> +     */
> +    if (code) {
> +        exit(code);
> +    } else {
> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +    }
>  }
>
>  /*
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index 5b375be1d9..f3d97d621f 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -113,6 +113,8 @@ void gdb_exit(int code)
>          gdb_put_packet(buf);
>          gdbserver_state.allow_stop_reply =3D false;
>      }
> +
> +    exit(code);
>  }

These are not the only places that call gdb_exit().
Notably, qemu_cleanup() calls it, and I'm pretty sure
it does not expect that gdb_exit() will either call
exit() or qemu_system_shutdown_request(), because it's
already in the process of cleaning up and stopping
the system.

If we send the "we're exiting" report to the gdb process,
that ought to be sufficient. If we're not actually managing
to send that last packet to gdb because we don't flush
the data out to the file descriptor, then it seems to me
that the fix ought to be to ensure we do do that flush
as part of gdb_exit() not to rearrange or try to avoid
all the subsequent calls to exit().

-- PMM

