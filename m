Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C4880D2AC
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 17:46:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCjQ9-0000sM-4Z; Mon, 11 Dec 2023 11:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCjQ4-0000sA-93
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 11:46:13 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCjPs-0003WR-AH
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 11:46:11 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2cc259392a6so10940181fa.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 08:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702313153; x=1702917953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IfU+CxsTVbLAxHNGCZboxpN6KgCAvgzelhiNGCSB2PY=;
 b=kBM1kP7v2MN+G6jjKN2I1GMSO4tpgPrf1LyYp2jDiprC6PZswz31RYTBKWBaFZ2q77
 7rOX34jETQP+DzqBZ92xim+DKndumLpcx4ZgCsUus08eqdCPAVgDpBTOOLHFuyX2CQSb
 z6Vxepq6r7W2zShdVQa8UyLhiqtmX+HHvZy6RmtaPH4948P3z+E+M3s1JycnXwzDXVce
 +WfYSJvM8h/VGbrXqx6Q4rPsTJJXbH0+sHTXxadCReX16B4ZqECHBysbeqQWo/TqNJ/l
 OqQ+UQQReHe7ClaTcHSzq4x319h/UsHX/OfY/N3PCiqmhbXs6Fo34Stc1DqjcCpE7GHT
 Zv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702313153; x=1702917953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IfU+CxsTVbLAxHNGCZboxpN6KgCAvgzelhiNGCSB2PY=;
 b=hEGLJuUDerXHa1hXV1Zlej0KSmNoNKNBvPySpXPmgDasd1yNJafIWUB968zRSfRLL1
 f37LtC2/H0VDzJSx+NPZFSZlCzUGVF7l41LOqkIF3O80DEguBrQP0kM1YvDQEHMkwhVD
 iACMr6F33v1mQk/Q5h8eujjbKNpBBpBmXm/SgEx5QlrLVg4hWIuvrLvpLNaQLRBRL/ux
 jKp+CFh2QV/y4/gbM2RQ5+9roYrTC39TVPhnW8s1x6qpDwXh77iXbwNTj/YP/Ane4XxJ
 MZoxZ5aQe3mk8l0ZaAFAGtZzy+dZq/GIHts4fRF1KrWKrc3PgxVGmddTI3xgTWgNGGrX
 RAZA==
X-Gm-Message-State: AOJu0Yy+iHhrP4a1KeN43hPj8eej1Am8iQNb0V69dHYKlzEiIfIcOXlV
 telf6M8lGoWHZ+Z1q2iwPtZzaw==
X-Google-Smtp-Source: AGHT+IHeREMKQDaPpTUx7rQEvmdLIQDFywhbRayKkrBk5X3ln+4/831VSJOND/jPCrP1ESFdlOPFjw==
X-Received: by 2002:a05:651c:2104:b0:2cc:2036:f942 with SMTP id
 a4-20020a05651c210400b002cc2036f942mr1205827ljq.29.1702313153274; 
 Mon, 11 Dec 2023 08:45:53 -0800 (PST)
Received: from [192.168.69.100] (cor91-h02-176-184-30-150.dsl.sta.abo.bbox.fr.
 [176.184.30.150]) by smtp.gmail.com with ESMTPSA id
 co7-20020a0564020c0700b0054caf3f8b2esm3839206edb.96.2023.12.11.08.45.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 08:45:52 -0800 (PST)
Message-ID: <3411e597-9feb-4d0b-82db-d3ea6df53b73@linaro.org>
Date: Mon, 11 Dec 2023 17:45:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] chardev: use bool for fe_open
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231211145959.93759-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231211145959.93759-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 11/12/23 15:59, Alex Bennée wrote:
> The function qemu_chr_fe_init already treats be->fe_open as a bool and
> if it acts like a bool it should be one. While we are at it add some
> kdoc decorations.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/chardev/char-fe.h | 19 ++++++++++++-------
>   chardev/char-fe.c         |  8 ++++----
>   2 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
> index 0ff6f87511..87b63f8bc8 100644
> --- a/include/chardev/char-fe.h
> +++ b/include/chardev/char-fe.h
> @@ -7,8 +7,12 @@
>   typedef void IOEventHandler(void *opaque, QEMUChrEvent event);
>   typedef int BackendChangeHandler(void *opaque);
>   
> -/* This is the backend as seen by frontend, the actual backend is
> - * Chardev */
> +/**
> + * struct CharBackend - back end as seen by front end
> + * @fe_open: the front end is ready for IO
> + *
> + * The actual backend is Chardev
> + */
>   struct CharBackend {
>       Chardev *chr;
>       IOEventHandler *chr_event;
> @@ -17,7 +21,7 @@ struct CharBackend {
>       BackendChangeHandler *chr_be_change;
>       void *opaque;
>       int tag;
> -    int fe_open;
> +    bool fe_open;

Clearer as 'fe_is_opened'.

>   };
>   
>   /**
> @@ -156,12 +160,13 @@ void qemu_chr_fe_set_echo(CharBackend *be, bool echo);
>   
>   /**
>    * qemu_chr_fe_set_open:
> + * @be: a CharBackend
> + * @fe_open: the front end open status
>    *
> - * Set character frontend open status.  This is an indication that the
> - * front end is ready (or not) to begin doing I/O.
> - * Without associated Chardev, do nothing.
> + * This is an indication that the front end is ready (or not) to begin
> + * doing I/O. Without associated Chardev, do nothing.
>    */
> -void qemu_chr_fe_set_open(CharBackend *be, int fe_open);
> +void qemu_chr_fe_set_open(CharBackend *be, bool fe_open);

Ditto, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


