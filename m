Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BB4803EC7
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 20:52:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAExl-0008O5-JF; Mon, 04 Dec 2023 14:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rAExf-0008Nu-Gw
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 14:50:35 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rAExa-0004Eb-NC
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 14:50:33 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6d8750719b6so1988774a34.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 11:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701719429; x=1702324229; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qk7B2BrnPH3Q6F9NVwlyd7DoJfAhAZsPeUd55lrL2MA=;
 b=G1HKCg6nozj/hFacu08EDRRJjHQI9Lv+EWnPwIF8cBllrDRUy/bUhVB8EQeIH3RQbV
 p4FgTdQgXkLX3LoFZhUlpuDZtln3rBdWDl402f5rReG1DpnNvexZiRigCWjsXRxplzUR
 xw/QFmndOrpMg3bi9oJFpclES9vyRMFP1jDUWML+fQcLN53uyEQtEglZoZPhTBQ/0Ybt
 uG51aN3UukFBlvckv19S6T+WW6U/VuAmqU48PxtgH3T0meAkHLp289nshumtJ887uPfO
 XEWeB9Kj2jbSfiEwBKNh6N1cdgUrRxEHjO88nnbe6RAWBcSyi3zukCyPjwA5OHBgGYEe
 /RVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701719429; x=1702324229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qk7B2BrnPH3Q6F9NVwlyd7DoJfAhAZsPeUd55lrL2MA=;
 b=UTEmTcv5yi/zoaPh1dLU7gg5ylgAMnIUKSGU09EaWRpfCIx3aJ8wYm7FvNmDf9oeMu
 wgkMScV++EirIfwgQrembd4joUEDFyYH8lu6OMbBoF9Us+vK0C20/YsPeHvIpUEX6aKS
 cWvxQ4Kp28NXvnL//zy7PwB7U40nDWy7YW9XOFLOes6CDKblZ3nWodESVIgqzzBfG35z
 4zmBH0Z653SurlJ3UKIZk8NpCn2ZLABk69KkmDxaNXqFXxObSa1v/MaLDcySloTK3TUR
 nVnvvN66ic1oIUH1KeTCIJ+BuL3N+SqY/wJRFBI4M74R0csXuKPEkjFsDH7QveujVlQV
 Dihw==
X-Gm-Message-State: AOJu0YzaD7ky1I/RWWQ+negH6FvZWLL1EZuUVFa+BUemygZmDTYHCcMm
 ZVJeZijD6Ad2mwj25IjpzvSqoY4YJyQrsyGOCiE=
X-Google-Smtp-Source: AGHT+IHb/ahmHPPkIZmyZ7E6Qgr0SFgZaVZEtEbvBndQBKCUj/RKSbwyTHu9VexP68j30uAl3zHcksYFcXiRSE5yYXo=
X-Received: by 2002:a05:6870:d3cd:b0:1f9:fa57:f72a with SMTP id
 l13-20020a056870d3cd00b001f9fa57f72amr8180017oag.38.1701719429309; Mon, 04
 Dec 2023 11:50:29 -0800 (PST)
MIME-Version: 1.0
References: <20231204194039.56169-1-philmd@linaro.org>
In-Reply-To: <20231204194039.56169-1-philmd@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 4 Dec 2023 14:50:17 -0500
Message-ID: <CAJSP0QUjZQQCk+VSJyxLq2jzuK=nxXDCiBn-r4dVzNPOCgH67w@mail.gmail.com>
Subject: Re: [RFC PATCH-for-8.2?] accel/tcg: Implement tcg_unregister_thread()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, 4 Dec 2023 at 14:40, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Unplugging vCPU triggers the following assertion in

Unplugging leaks the tcg context refcount but does not trigger the
assertion directly. Maybe clarify that by changing the wording:

"Plugging a vCPU after it has been unplugged triggers..."

> tcg_register_thread():
>
>  796 void tcg_register_thread(void)
>  797 {
>  ...
>  812     /* Claim an entry in tcg_ctxs */
>  813     n =3D qatomic_fetch_inc(&tcg_cur_ctxs);
>  814     g_assert(n < tcg_max_ctxs);
>
> Implement and use tcg_unregister_thread() so when a
> vCPU is unplugged, the tcg_cur_ctxs refcount is
> decremented.
>
> Reported-by: Michal Such=C3=A1nek <msuchanek@suse.de>
> Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> RFC: untested
> Report: https://lore.kernel.org/qemu-devel/20231204183638.GZ9696@kitsune.=
suse.cz/
> ---
>  include/tcg/startup.h           |  5 +++++
>  accel/tcg/tcg-accel-ops-mttcg.c |  1 +
>  accel/tcg/tcg-accel-ops-rr.c    |  1 +
>  tcg/tcg.c                       | 17 +++++++++++++++++
>  4 files changed, 24 insertions(+)
>
> diff --git a/include/tcg/startup.h b/include/tcg/startup.h
> index f71305765c..520942a4a1 100644
> --- a/include/tcg/startup.h
> +++ b/include/tcg/startup.h
> @@ -45,6 +45,11 @@ void tcg_init(size_t tb_size, int splitwx, unsigned ma=
x_cpus);
>   */
>  void tcg_register_thread(void);
>
> +/**
> + * tcg_unregister_thread: Unregister this thread with the TCG runtime
> + */
> +void tcg_unregister_thread(void);
> +
>  /**
>   * tcg_prologue_init(): Generate the code for the TCG prologue
>   *
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mt=
tcg.c
> index fac80095bb..88d7427aad 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.c
> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> @@ -120,6 +120,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
>
>      tcg_cpus_destroy(cpu);
>      qemu_mutex_unlock_iothread();
> +    tcg_unregister_thread();
>      rcu_remove_force_rcu_notifier(&force_rcu.notifier);
>      rcu_unregister_thread();
>      return NULL;
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 611932f3c3..c2af3aad21 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -302,6 +302,7 @@ static void *rr_cpu_thread_fn(void *arg)
>          rr_deal_with_unplugged_cpus();
>      }
>
> +    tcg_unregister_thread();
>      rcu_remove_force_rcu_notifier(&force_rcu);
>      rcu_unregister_thread();
>      return NULL;
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index d2ea22b397..5125342d70 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -781,11 +781,18 @@ static void alloc_tcg_plugin_context(TCGContext *s)
>   * modes.
>   */
>  #ifdef CONFIG_USER_ONLY
> +
>  void tcg_register_thread(void)
>  {
>      tcg_ctx =3D &tcg_init_ctx;
>  }
> +
> +void tcg_unregister_thread(void)
> +{
> +}
> +
>  #else
> +
>  void tcg_register_thread(void)
>  {
>      TCGContext *s =3D g_malloc(sizeof(*s));
> @@ -814,6 +821,16 @@ void tcg_register_thread(void)
>
>      tcg_ctx =3D s;
>  }
> +
> +void tcg_unregister_thread(void)
> +{
> +    unsigned int n;
> +
> +    n =3D qatomic_fetch_dec(&tcg_cur_ctxs);
> +    g_free(tcg_ctxs[n]);
> +    qatomic_set(&tcg_ctxs[n], NULL);
> +}

tcg_ctxs[n] may not be our context, so this looks like it could free
another thread's context and lead to undefined behavior.

I haven't read the code so I can't suggest an alternative myself.

Stefan

> +
>  #endif /* !CONFIG_USER_ONLY */
>
>  /* pool based memory allocation */
> --
> 2.41.0
>

